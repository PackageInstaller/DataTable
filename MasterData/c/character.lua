---@class Character : Player
local Character = class("Character", require "Player")
local Player = require("PlayerAll").loadAllModules()
local json = require "cjson"
function Character:ctor()
	---@type integer
	self.nowSelectLevel = nil
	self.nowEnterMeans = GE.EnterBattleType.Normal

	self.pushDataDownMap = {}	--部分需要主动请求的数据下发完成标记
	self.pushDatasendList = {}	--部分需要主动请求的数据发送列表
	
	-- 队列请求相关字段
	self.isFunctionDataRequesting = false	--是否正在请求中
	self.functionDataRequestQueue = {}	--功能数据请求队列

	self._successCB = nil	--支付成功回调
end

function Character:getGmtStamp()
	return EngineUtil.ServerTime_Seconds()
end

function Character:getLocalStamp()
	return luautil.gmtStampToLocal(self:getGmtStamp())
end

function Character:getTimeZone()
	return Me.timeZone
end



function Character:jsonDecode(v)
	return json.decode(v)
end

function Character:jsonEncode(v)
	return json.encode(v)
end

---获取当前当天时间
function Character:GetServerTime()
	local curTime = EngineUtil.ServerTime_Seconds()
	curTime = curTime + self:getTimeZone() * 3600		--转换成格林威治时间  --服务器时间差了8个小时
	curTime = Mathf.Floor(curTime)
	return curTime
end


function Character.DoGM(content)
	-- todo:判断是否GM模式
    if CommonLogic.GMProcess(require "GMLocal", content, Me) then
        return
    end

    GameNetHandler:SendWaitMessage("user.ChatReq", { type = 0, content = content }, function (data)
        
    end)
end

function Character:enterScene(reEnter, callback, callback2)
	local chatline
	local channel = UpdateManager.Instance.Code5
	--local channel = 1
	local deviceType = UnityEngine.Application.platform:ToInt()
	--local deviceType = UnityEngine.RuntimePlatform.Android:ToInt()

	GameNetHandler:SendWaitMessage("user.EnterSceneReq", {reEnter = reEnter, channel = channel, deviceType = deviceType}, function (data)
        LuaLogger.ds("enterscene", reEnter, chatline)
        if callback then
	        callback(data)
        end

		--请求邮件数据
		Me:mailListReq()
		
		self.isEnterScene = true

        -- if data.notDealedMailNum and self.notDealedMailNum ~= data.notDealedMailNum then
        -- 	self.notDealedMailNum = data.notDealedMailNum
		-- 	GameMsgMgr:sendEvent(GameMsgType.MailListChange, true)

        -- 	LuaLogger.ds("new mail num", data.notDealedMailNum)
        -- end
		--支付初始化
		PayMgr:Init()
	end)
end

function Character:SetEnterGame(isEnterGame)
	self._isEnterGame = isEnterGame
end

function Character:isEnterGame()
	return self._isEnterGame
end

--设置当前进入的关卡id
function Character:setNowSelectLevel(levelId, enterMeans)
	self.nowSelectLevel = levelId
	self.nowEnterMeans = enterMeans or GE.EnterBattleType.Normal
end

--获取当前进入的关卡id
function Character:getNowSelectLevel()
	return self.nowSelectLevel
end

--获取当前进入的方式
function Character:getNowEnterMeans()
	return self.nowEnterMeans
end

--------------------------前端用数据获取----------------------------
--根据ID获取货币类
function Character:getMoneyById(res_id)
	return Me:getItemNumById(res_id)
end


--------------------------服务器请求----------------------------
---获取非登录同步的功能数据
---@param functionList PushData[]
---@param callback function?
function Character:getFunctionDataReq(functionList, callback)
	if Standalone then
		if (callback) then
			callback()
		end
		return
	end
	if functionList == nil or #functionList == 0 then
		if (callback) then
			callback()
		end
		return
	end

	if functionList then
		local listCount = #functionList
		if listCount > 10 then
			return
		end
	end

	-- 将请求加入队列
	table.insert(self.functionDataRequestQueue, {
		functionList = functionList,
		callback = callback
	})

	-- 如果正在请求中，直接返回，等待当前请求完成后处理
	if self.isFunctionDataRequesting then
		return
	end

	-- 开始处理队列中的请求
	self:_processFunctionDataRequest()
end

---处理功能数据请求队列（内部方法）
function Character:_processFunctionDataRequest()
	if #self.functionDataRequestQueue == 0 then
		self.isFunctionDataRequesting = false
		return
	end

	self.isFunctionDataRequesting = true

	-- 收集队列中所有请求的functionList和callback
	local allFunctionLists = {}
	local allCallbacks = {}
	
	-- 使用set去重，合并所有队列中的functionList
	local mergedFunctionSet = {}
	for i = 1, #self.functionDataRequestQueue do
		local request = self.functionDataRequestQueue[i]
		table.insert(allFunctionLists, request.functionList)
		table.insert(allCallbacks, request.callback)
		
		for j = 1, #request.functionList do
			mergedFunctionSet[request.functionList[j]] = true
		end
	end
	
	-- 清空队列
	self.functionDataRequestQueue = {}
	
	-- 构建合并后的functionList
	local mergedFunctionList = {}
	for func, _ in pairs(mergedFunctionSet) do
		table.insert(mergedFunctionList, func)
	end

	local sendList = {}
	local isAllReady = true
	--根据记录状态和是否为空表，决定是否请求
	for i = #mergedFunctionList, 1, -1 do
		local dataKey = mergedFunctionList[i]
		---nil表示没有加载
		--- 1表示加载中
		--- 2表示加载完成
		if self.pushDataDownMap[dataKey] == 1 then
			isAllReady = false
		end
		if self.pushDataDownMap[dataKey] == nil then --or tablex.next(self[dataKey]) then
			table.insert(sendList, dataKey)
			if self.pushDataDownMap[dataKey] == nil then
				self.pushDataDownMap[dataKey] = 1
			end
		end
	end

	-- 保存所有待处理请求的回调信息
	for i = 1, #allFunctionLists do
		local ddd = {
			funs = allFunctionLists[i],
			callback = allCallbacks[i]
		}
		table.insert(self.pushDatasendList, ddd)
	end

	if #sendList == 0 and isAllReady then
		-- 执行所有已就绪的回调
		for i = #self.pushDatasendList, 1, -1 do
			local sendData = self.pushDatasendList[i]
			local allReady = true
			for j = 1, #sendData.funs do
				local dataKey = sendData.funs[j]
				if self.pushDataDownMap[dataKey] ~= 2 then --or tablex.next(self[dataKey]) then
					allReady = false
					break
				end
			end
			if allReady then
				if sendData.callback ~= nil then
					sendData.callback()
				end
				table.remove(self.pushDatasendList, i)
			end
		end
		-- 处理队列中可能新增的请求
		self:_processFunctionDataRequest()
		return
	end

	if #sendList == 0 then
		-- 处理队列中可能新增的请求
		self:_processFunctionDataRequest()
		return
	end

	---@type GetFunctionDataReq
	local data = {
		functions = sendList
	}

	GameNetHandler:SendWaitMessage("user.GetFunctionDataReq", data, function (data)
		if data.ret ~= 0 then
			-- 请求失败，继续处理队列
			self:_processFunctionDataRequest()
			return
		end

		for i = 1, #sendList do
			self.pushDataDownMap[sendList[i]] = 2
		end

		for i = #self.pushDatasendList, 1, -1 do
			local sendData = self.pushDatasendList[i]
			local allReady = true
			for j = 1, #sendData.funs do
				local dataKey = sendData.funs[j]
				if self.pushDataDownMap[dataKey] ~= 2 then --or tablex.next(self[dataKey]) then
					allReady = false
					break
				end
			end
			if allReady then
				if sendData.callback ~= nil then
					sendData.callback()
				end
				table.remove(self.pushDatasendList, i)
			end
		end
		
		-- 处理队列中的下一批请求
		self:_processFunctionDataRequest()
	end)
end

-------------------------------------------------------------------
function Character:battleStartReq(level, heroCidList, enterMeans, callback)
	print("%%%%%%%%%% BattleStartReq", level, tablex.dump(heroCidList))
	GameNetHandler:SendWaitMessage("user.BattleStartReq", { level = level ,heroCidList = heroCidList, enterMeans = enterMeans}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% BattleStartResp", tablex.dump(data), tablex.dump(data.battleStartInfo))
			callback(data)
		else
			print("%%%%%%%%%% BattleStartResp failed", tablex.dump(data))
			UICommonUtils.PopOkBox(LocalStrEnum.ActionFailReason_SystemError, CommonLogic.GetResInfo(data), function ()
				if data.ret == ActionFailReason.BattleVersionMismatch then
					--战斗版本不一致的情况下需要重启走热更
					Restart()
				else
					local battleMgr = BattleCore:getBattleMgr()
					battleMgr:clear()
					LoadingMgr:SetLoadingStart(function()
						StateMgr:BackLastState()
					end, nil, nil, "Character")
				end
			end)
		end
    end)
end

---@param orderReport BattleOrderReport
---@param battleLogData BattleLogData
---@param simpleVerifyData ReportRoleDoSkillData[]
---@param callback fun(resultData: BattleResultResp)
function Character:battleResultReq(orderReport, battleLogData, simpleVerifyData, callback)
	GameNetHandler:SendWaitMessage("user.BattleResultReq", { orderReport = orderReport, battleLogData = battleLogData, simpleVerifyData = simpleVerifyData }, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% BattleResultResp")
		end
		callback(data)
    end)
end

function Character:useNormalTicketReq(num, callback)
	GameNetHandler:SendWaitMessage("user.UseNormalTicketReq", { num = num}, function (data)
		if data.ret == ActionFailReason.None then
			callback()
		end
    end)
end

--购买体力
function Character:buyNormalTicketReq(data , callback)
	GameNetHandler:SendWaitMessage("user.BuyNormalTicketReq", data, function (data)
		if data.ret == ActionFailReason.None then
			callback()
		end
    end)
end

--抽卡
--data.raffleId {int} 卡池id
--data.count {int}	抽取次数
function Character:startRaffleReq(data , callback)
	GameNetHandler:SendWaitMessage("user.StartRaffleReq", { raffleId = data.raffleId , count = data.count }, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% StartRaffleResp", tablex.dump(data))
			if callback then
				callback(data)
			end
		end
    end)
end

--测试抽卡
--data.raffleId {int} 卡池id
--data.count {int}	抽取次数
function Character:testRaffleReq(data , callback)
	GameNetHandler:SendWaitMessage("user.TestRaffleReq", { raffleId = data.raffleId , count = data.count }, function(data)
		if data.ret == 0 then
			--print("%%%%%%%%%% TestRaffleResp", tablex.dump(data))
			if callback then
				callback(data.rewardList)
			end
		end
    end)
end

--引导抽卡
function Character:guideRaffleReq(callback)
	GameNetHandler:SendWaitMessage("user.GuideRaffleReq", {}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% GuideRaffleResp", tablex.dump(data))
			if callback then
				callback(data)
			end
		end
    end)
end

--记录引导id
function Character:changeGuideIDReq(data, callback)
	GameNetHandler:SendWaitMessage("user.ChangeGuideIDReq", {guideType = data.guideType, guideId = data.guideId}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% ChangeGuideIDResp", tablex.dump(data))
			for key, value in pairs(data.guideInfoMap) do
				Me:setGuideIdByGroupId(key, value)
			end
			if callback then
				callback(data)
			end
		end
    end)
end

--领取新手签到奖励
function Character:GetNewbieSignInRewardReq(callback)
	GameNetHandler:SendWaitMessage("user.GetNewbieSignInRewardReq", {}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetNewbieSignInRewardResp", tablex.dump(data))
			GameMsgMgr:sendEvent(GameMsgType.RefreshMainPanel)
			data.titleType = "SignIn"
			Me:ReceiveReward(data)
			if (callback) then
				callback()
			end
			
		end
	end)
end

--请求邮件列表
function Character:mailListReq(stamp, callback)
	GameNetHandler:SendWaitMessage("user.MailListReq", {}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% MailListResp", tablex.dump(data))

			if not data.mailList then
				return
			end

			if not Me.mails then
				Me.mails = {}
			end
			local needRedPoint = false
			for i,v in ipairs(data.mailList) do
				Me.mails[v.id] = v
				if not needRedPoint then
					if v.reward then
						if (v.state == MailState.NotRead) or (v.state == MailState.Read) then
							needRedPoint = true
						end
					else
						if v.state == MailState.NotRead then
							needRedPoint = true
						end
					end
				end
			end

			if needRedPoint then
				RedPointMgr:SetRedDotState("NewMailRed", true)
			end

			if (callback) then
				callback(data)
			end
		end
	end)
end

--操作邮件
function Character:mailActionReq(data, callback)
	GameNetHandler:SendWaitMessage("user.MailActionReq", {id = data.id, action = data.action}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% MailActionResp", tablex.dump(data))

			if data.rewards then
				self:ReceiveReward(data.rewards)
			end
			RedPointMgr:Refresh("MainPanelUserDetail")

			if (callback) then
				callback(data)
			end
		end
	end)
end

--收藏邮件
function Character:mailCollectReq(id, callback)
	GameNetHandler:SendWaitMessage("user.MailCollectReq", {id = id}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% MailCollectResp", tablex.dump(data))
			ClientData:changeMailCollectCosData(id)
			if (callback) then
				callback(data)
			end

		end
	end)
end

--领取任务奖励
function Character:GetMissionRewardReq(idList, callback, disableShowRewardList)
	GameNetHandler:SendWaitMessage("user.GetMissionRewardReq", {idList = idList}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetMissionRewardResp", tablex.dump(data))
			GameMsgMgr:sendEvent(GameMsgType.RefreshMainPanel)
			-- data.titleType = "SignIn"
			if data.rewardList and next(data.rewardList) and (not disableShowRewardList) then
				self:ReceiveReward(data.rewardList)
			end
			if (callback) then
				callback(data)
			end
		end
	end)
end

--提交并领取任务奖励
function Character:SubmitClaimMissionRewardReq(idList, callback)
	LuaLogger.ds("%%%%%%%%%% SubmitClaimMissionRewardReq", tablex.dump(idList))
	GameNetHandler:SendWaitMessage("user.SubmitClaimMissionRewardReq", {idList = idList}, function(data)
		LuaLogger.ds("%%%%%%%%%% SubmitClaimMissionRewardResp", tablex.dump(data))
		if data.ret == 0 then
			if data.rewardList and next(data.rewardList) then
				self:ReceiveReward(data.rewardList)
			end
			if (callback) then
				callback(data)
			end
		end
	end)
end

--领取活动积分奖励
function Character:GetActivityPointsBonusReq(activityId, rewardIndex, callback)
	GameNetHandler:SendWaitMessage("user.GetActivityPointsBonusReq", {activityId = activityId, rewardIndex = rewardIndex}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetActivityPointsBonusResp", tablex.dump(data))
			GameMsgMgr:sendEvent(GameMsgType.RefreshMainPanel)
			--TODO
			--UIMgr:popUICover("ReceiveRewardPanel", data)
			self:ReceiveReward(data)
			if (callback) then
				callback()
			end
		end
	end)
end

--数数日志公共事件属性记录
function Character:RecordSuperPropertiesReq(info, callback)
	GameNetHandler:SendWaitMessage("user.RecordSuperPropertiesReq", {info = info}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% RecordSuperPropertiesResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
end

--前端主动请求刷新体力
function Character:recoverNormalTicketReq(data, callback)
	GameNetHandler:SendWaitMessage("user.RecoverNormalTicketReq", {}, function(data)
		if data.ret == 0 then
			if (callback) then
				callback(data)
			end
		end
	end)
end

--角色升级
function Character:roleLevelUpReq(data, callback)
	GameNetHandler:SendWaitMessage("user.HeroLevelUpReq", {id = data.id, upLevel = data.upLevel}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% HeroLevelUpResp", tablex.dump(data))
			callback()
		end
    end)
end

--修改角色编队
---@param data ChangeFormationListReq
---@param callback function 回调函数
function Character:changeFormationListReq(data, callback)
	GameNetHandler:SendWaitMessage("user.ChangeFormationListReq", {id = data.id, formationList = data.formationList}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% ChangeFormationListResp", tablex.dump(data))
			callback()
		end
    end)
end

--升级装备
---@param data table {id = id, useList = useList} 装备ID，升级所需的物品列表（在这里面只需要核心物品，道具/装备）
---@param callback function 回调函数，可能的返回值 ActionFailReason.None, ItemNotFound, EquipNotFound, CfgNotFind,NotLevelUpMaterial, EquipIsLock, ParameterInvalid, EquipIsEquip, CurrencyNoEnough
function Character:addEquipExpReq(data, callback)
	GameNetHandler:SendWaitMessage("user.AddEquipExpReq", {id = data.id, useList = data.useList}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% AddEquipExpResp", tablex.dump(data))
			callback(data)
			GameMsgMgr:sendEvent(GameMsgType.RefreshWarehousePanel)
			GameMsgMgr:sendEvent(GameMsgType.RefreshMainPanel)
		end
    end)
end

--装备升星(突破)
---@param data table {id = id, idList = idList} 装备ID，升级所需的物品列表（在这里面只需要核心物品，装备本身）
---@param callback function 回调函数，可能的返回值 ActionFailReason.None, ItemNotFound, EquipNotFound, CfgNotFind, EquipLevelNotEnough, EquipIsLock, ParameterInvalid, EquipIsEquip, CurrencyNoEnough
---@return void
function Character:addEquipStarReq(data, callback)
	GameNetHandler:SendWaitMessage("user.AddEquipStarReq", {id = data.id, useIdList = data.idList}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% AddEquipStarResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
			GameMsgMgr:sendEvent(GameMsgType.RefreshWarehousePanel)
			GameMsgMgr:sendEvent(GameMsgType.RefreshMainPanel)
		end
    end)
end

--装备分解
---@param data table {idList = idList} 装备ID列表
---@param callback function 回调函数，可能的返回值 ActionFailReason.None, EquipNotFound, EquipIsLock, EquipIsEquip
---@return void
function Character:decomposeEquipReq(data, callback)
	GameNetHandler:SendWaitMessage("user.DecomposeEquipReq", {idList = data.idList}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% DecomposeEquipResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
			GameMsgMgr:sendEvent(GameMsgType.RefreshWarehousePanel)
		end
    end)
end

--更改装备锁定状态,本质上就是反转当前的状态
---@param equipData table {equipId = equipId} 装备ID
---@param callback function 回调函数，可能的返回值 ActionFailReason.None, EquipNotFound
---@return void
function Character:changeEquipLockStateReq(equipData, callback)
	GameNetHandler:SendWaitMessage("user.ChangeEquipLockStateReq", {equipId = equipData.equipId}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% ChangeEquipLockStateResp", tablex.dump(data))

			GameMsgMgr:sendEvent(GameMsgType.RefreshCustomItemLockState, {id = equipData.equipId, type = GE.RewardType.Equipment})
			if (callback) then
				callback(data)
			end
		end
    end)
end

--穿戴装备
---@param data table {charId = charId, partId = partId, equipId = equipId} 分别是角色ID，部位ID，装备ID
---@param callback function 回调函数，可能的返回值 ActionFailReason.None, ActionFailReason.HeroNoFind，ActionFailReason.EquipNoFind，ActionFailReason.ParameterInvalid
---@return void
function Character:setCharEquipReq(data, callback)
	GameNetHandler:SendWaitMessage("user.SetCharEquipReq", {charId = data.charId, partId = data.partId, equipId = data.equipId}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% SetCharEquipResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--卸下装备
---@param data table {equipId = equipId} 装备ID
---@param callback function 回调函数，可能的返回值 ActionFailReason.None, ActionFailReason.EquipNotFind, ActionFailReason.HeroNoFind
---@return void
function Character:removeCharEquipReq(data, callback)
	GameNetHandler:SendWaitMessage("user.RemoveCharEquipReq", {equipId = data.equipId}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% RemoveCharEquipResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--请求解锁天赋树节点
function Character:talentTreeUnLockPointReq(data, callback)
	GameNetHandler:SendWaitMessage("user.TalentTreeUnLockPointReq", {talentID = data.talentID, heroId = data.RoleId }, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% TalentTreeUnLockPointResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--请求解锁天赋树节点
function Character:talentTreeStageUnlockReq(data, callback)
	GameNetHandler:SendWaitMessage("user.TalentTreeStageUnlockReq", {stageID = data.stageID, heroId = data.RoleId }, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% TalentTreeStageUnlockResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--请求解锁科技树节点
function Character:technologyTreeUnlockReq(data, callback)
	GameNetHandler:SendWaitMessage("user.TechnologyTreeUnlockReq", {groupId = data.groupId}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% TechnologyTreeUnlockResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--请求跑片开始
function Character:genRoleFragStartReq(data, callback)
	GameNetHandler:SendWaitMessage("user.GenRoleFragStartReq", { roleIdList = data.roleIdList }, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% GenRoleFragStartResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
	
end

--请求签到奖励
function Character:getSignRewardReq(data, callback)
	GameNetHandler:SendWaitMessage("user.GetSignRewardReq", { signType = data.signType, signIndex = data.signIndex, signId = data.signId}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetSignRewardResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
	
end


--派遣开始请求
function Character:dispatchStartReq(data, callback)
	GameNetHandler:SendWaitMessage("user.DispatchStartReq", {dispatchId = data.dispatchId, lineId = data.lineId, roleIdList = data.roleIdList}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% DispatchStartResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--派遣结束请求
function Character:dispatchEndReq(data, callback)
	GameNetHandler:SendWaitMessage("user.DispatchEndReq", {dispatchIdList = data.dispatchIdList}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% DispatchEndResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--派遣章节奖励领取
function Character:dispatchChapterRewardReq(data, callback)
	GameNetHandler:SendWaitMessage("user.DispatchChapterRewardReq", {chapterId = data.chapterId}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% DiapatchChapterRewardResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--请求客服链接
function Character:getSupportLinkReq(callback)
	GameNetHandler:SendWaitMessage("user.GetSupportLinkReq", {}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetSupportLinkResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end


--保存家园随机生成的角色状态
---@param data table {roleIdList = roleIdList, constructIdList = constructIdList} 角色ID列表，建筑ID列表
---@param callback function 回调函数，可能的返回值 ActionFailReason.None, LackParameter, ParameterInvalid, HeroNoFind, BuildingNotExist
function Character:setHomeShowRoleReq(data, callback)
	GameNetHandler:SendWaitMessage("user.SetHomeShowHeroReq", {heroIdList = data.roleIdList, constructIdList = data.constructIdList }, function (data)
	if data.ret == 0 then
		print("%%%%%%%%%% SetHomeShowHeroResp", tablex.dump(data))
		if (callback) then
			callback(data)
		end
		GameMsgMgr:sendEvent(GameMsgType.RefreshEventMsg)
	end
end)
end

--设置家园建筑部署角色
---@param data table {constructionId = constructionId, heroIdList = heroIdList} 建筑ID，角色ID列表
---@param callback function 回调函数，可能的返回值 ActionFailReason.None, HeroNoFind, BuildingNotExist
function Character:setHomeDisposeHeroReq(data, callback)
	self:setHomeDisposesHeroReq({data}, callback)
end

--设置家园建筑部署角色
---@param homeDisposesHero SetHomeDisposeHeroReq[] 建筑ID，角色ID列表
---@param callback function 回调函数，可能的返回值 ActionFailReason.None, HeroNoFind, BuildingNotExist
function Character:setHomeDisposesHeroReq(homeDisposesHero, callback)
	GameNetHandler:SendWaitMessage("user.SetHomeDisposesHeroReq", {homeDisposesHero = homeDisposesHero}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% SetHomeDisposesHeroReq", tablex.dump(data))
			if (callback) then
				callback(data)
			end
			GameMsgMgr:sendEvent(GameMsgType.RoleDisposeChange)
			GameMsgMgr:sendEvent(GameMsgType.RefreshEventMsg)
		end
	end)
end

function Character:charDelReq(data, callback)
	GameNetHandler:SendWaitMessage("user.CharDelReq", {}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% CharDelResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
			-- --清除本地数据
			-- Me:clearData()
			-- --重新加载游戏
			-- g_GameMain:Restart()
		end
	end)
	
end


--重复战斗
function Character:battleRepeatReq(data, callback)
	GameNetHandler:SendWaitMessage("user.BattleRepeatReq", {levelId = data.levelId, repeatNum = data.repeatNum, formationId = data.formationId}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% BattleRepeatResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
			GameMsgMgr:sendEvent(GameMsgType.RefreshMaterilalLevelPanel)
		else
			--请求失败时释放寄存Toast，避免升级Toast一直被拦截
			UIMgr:endDepositToast(GE.DepositToastType.BattleRepeat)
		end
    end)
end

--武器分解
function Character:decomposeWeaponReq(data, callback)
	GameNetHandler:SendWaitMessage("user.DecomposeWeaponReq", {idList = data.idList}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% DecomposeWeaponResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--装备角色技能
function Character:equipRoleSkillReq(data, callback)
	GameNetHandler:SendWaitMessage("user.EquipHeroSkillReq", {heroId = data.roleId, skillList = data.skillList}, function (data)
		if data.ret == 0 then
			LuaLogger.ds("%%%%%%%%%% EquipHeroSkillResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--武器锁定状态修改，在代码实现中，就是来进行状态的反转
---@param weaponData table {weaponId = weaponId}
---@param callback function 回调函数 可能的返回状态：ActionFailReason.None，ActionFailReason.WeaponNoFind, 
---@return void
function Character:changeWeaponLockStateReq(weaponData, callback)
	GameNetHandler:SendWaitMessage("user.ChangeWeaponLockStateReq", {weaponId = weaponData.weaponId}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% ChangeWeaponLockStateResp", tablex.dump(data))
			GameMsgMgr:sendEvent(GameMsgType.RefreshCustomItemLockState, {id = weaponData.weaponId, type = GE.RewardType.Weapon})

			if (callback) then
				callback(data)
			end
		end
    end)
end

--装备武器
---@param data table {charId = charId, partId = partId, weaponId = weaponId} 分别是角色ID，部位ID，武器ID
---@param callback function 回调函数，ActionFailReason.None, ActionFailReason.HeroNoFind，ActionFailReason.WeaponNoFind，ActionFailReason.ParameterInvalid
---@return void
function Character:setCharWeaponReq(data, callback)
	GameNetHandler:SendWaitMessage("user.SetCharWeaponReq", {charId = data.charId, partId = data.partId, weaponId = data.weaponId}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% SetCharWeaponResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--卸下武器
---@param data table {weaponId = weaponId} 武器ID
---@param callback function 回调函数，ActionFailReason.None,ActionFailReason.WeaponNotFind, ActionFailReason.HeroNoFind
---@return void
function Character:removeCharWeaponReq(data, callback)
	GameNetHandler:SendWaitMessage("user.RemoveCharWeaponReq", {weaponId = data.weaponId}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% RemoveCharWeaponResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--升级武器
---@param data table {weaponId = weaponId, useList = useList} 武器ID，升级所需的物品列表（在这里面只需要核心物品，道具+武器）
---@param callback function 回调函数, 可能的返回状态：ActionFailReason.None，ActionFailReason.WeaponIsLock, ActionFailReason.WeaponIsEquip
---ActionFailReason.WeaponNoFind，ActionFailReason.ParameterInvalid,ActionFailReason.CfgNotFind, ActionFailReason.ItemNoEnough,ActionFailReason.Failed
---@return void
function Character:addWeaponExpReq(data, callback)
	GameNetHandler:SendWaitMessage("user.AddWeaponExpReq", {weaponId = data.weaponId, useList = data.useList}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% AddWeaponExpResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
			GameMsgMgr:sendEvent(GameMsgType.RefreshWarehousePanel)
			GameMsgMgr:sendEvent(GameMsgType.RefreshMainPanel)
		end
    end)
end

--融合武器
---@param data table {fuseList = fuseList} 融合所需的武器列表
---@param callback function 回调函数，可能的返回状态：ActionFailReason.None，ActionFailReason.ItemNoFind, ActionFailReason.WeaponNoFind, ActionFailReason.WeaponIsLock, ActionFailReason.WeaponIsEquip
---ActionFailReason.CfgNotFind,
---@return void
function Character:fuseWeaponReq(data, callback)
	GameNetHandler:SendWaitMessage("user.FuseWeaponReq", {fuseList = data.fuseList}, function (data)
		if data.ret == 0 then
			print("%%%%%%%%%% FuseWeaponResp", tablex.dump(data))
			if (callback) then
				callback(data.newWeaponId)
			end
			GameMsgMgr:sendEvent(GameMsgType.RefreshWarehousePanel)
		end
    end)
end

--角色升星
function Character:roleStarUpReq(data, callback)
	GameNetHandler:SendWaitMessage("user.HeroStarUpReq", {id = data.id}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% HeroStarUpResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--请求领取角色星级奖励
function Character:getHeroStarRewardReq(data, callback)
	GameNetHandler:SendWaitMessage("user.GetHeroStarRewardReq", {id = data.id}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetHeroStarRewardResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
end


--更换看板娘
function Character:setPosterDataReq(data, callback)
	GameNetHandler:SendWaitMessage("user.SetPosterDataReq", {posterId = data.posterId}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% SetPosterDataResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--更改看板娘位置缩放
function Character:setPosterPosReq(data, callback)
	GameNetHandler:SendWaitMessage("user.SetPosterPosReq", {PosX = data.PosX, PosY = data.PosY, Size = data.Size}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% SetPosterPosResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--更换皮肤穿戴
function Character:equipSkinReq(data, callback)
	GameNetHandler:SendWaitMessage("user.EquipSkinReq", {heroId = data.roleId, skinId = data.skinId}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% EquipSkinResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--更换头像
function Character:changeHeadReq(data, callback)
	GameNetHandler:SendWaitMessage("user.ChangeHeadReq", {HeadId = data.HeadId}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% ChangeHeadResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--更换签名
function Character:changeSignReq(data, callback)
	GameNetHandler:SendWaitMessage("user.ChangeSignReq", {signTxt = data.signTxt}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% ChangeSignResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--更换名称
function Character:changeNameReq(data, callback)
	GameNetHandler:SendWaitMessage("user.ChangeNameReq", {newName = data.newName}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% ChangeNameResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end


--领取家园建筑产出
---@param constIds integer[]
---@param callback fun(data:GetBuildingsRewardResp) 回调函数，可能的返回值 ActionFailReason.None, BuildingNotExist, BuildingNoOutput
---@return void
function Character:GetBuildingsRewardReq(constIds, callback)
	GameNetHandler:SendWaitMessage("user.GetBuildingsRewardReq", {constIds = constIds}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetBuildingsRewardReq", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--请求生产武器
---@param data table {blueprintId = blueprintId, count = count} 蓝图ID，生产数量
---@param callback function 回调函数，可能的返回值 ActionFailReason.None, CfgNotFind, ItemNoFind, ItemNoEnough
---@return void
function Character:weaponProductionReq(data, callback)
	GameNetHandler:SendWaitMessage("user.WeaponProductionReq", {blueprintId = data.blueprintId, count = data.count}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% WeaponProductionResp", tablex.dump(data))
			if (callback) then
				callback(data)
				self:ReceiveReward(data.rewardList)
			end
		else
			if (callback) then
				callback(data)
			end
		end
    end)
end

--请求领取章节奖励
function Character:GetChapterRewardReq(data, callback)
	GameNetHandler:SendWaitMessage("user.GetChapterAwardReq", {id = data.chapterAwardId}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetChapterAwardResp", tablex.dump(data))
			if (callback) then
				callback(data)
				self:ReceiveReward(data.rewardList)
			end
		end
	end)
end

--请求修改图鉴收藏状态（自动反转当前状态）
---@param data table {bookType = bookType, id = id} 图鉴类型，图鉴id
---@param callback function 回调函数，可能的返回值 ActionFailReason.None, ActionFailReason.HandbookNoFind, ActionFailReason.ParameterInvalid，返回数据中包含isCollected表示操作后的收藏状态
---@return void
function Character:setHandbookCollectedReq(data, callback)
	GameNetHandler:SendWaitMessage("user.SetHandbookCollectedReq", {
		bookType = data.bookType,
		id = data.id
	}, function(respData)
		if respData.ret == 0 then
			print("%%%%%%%%%% SetHandbookCollectedResp success, isCollected:", respData.isCollected)
		end
		if callback then
			callback(respData)
		end
	end)
end

--请求家园建筑升级
function Character:HomeLvUpReq(needData, callback)
	GameNetHandler:SendWaitMessage("user.HomeLvUpReq", {constructionId = needData.constructionId}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% HomeLvUpResp", tablex.dump(data))
			--根据是否有家园演出触发不同流程
			local constructData = Me:getConstructionDataById(needData.constructionId)
			local constructLvCfg = Config.GetConstructionLevelInfoByTypeLevel(needData.constructionId, constructData.level)
			if constructLvCfg.action and constructLvCfg.action ~= 0 then
				StoryMgr:setHomeLvUpSkipCallback(function()
					if (callback) then
						callback(data)
					end
				end)
				StoryMgr:playHomeStory(constructLvCfg.action)
			else
				if (callback) then
					callback(data)
				end
			end

			--GameMsgMgr:sendEvent(GameMsgType.HomeBuildingChange)
		end
	end)
	
end

--设置家园中建筑的散步角色
---@param data table {heroIdList = heroIdList} 角色ID列表
---@param callback function 回调函数，可能的返回值 ActionFailReason.None, LackParameter, HeroNoFind, HomeWalkMax, HeroInWork
---@return void
function Character:setHomeWalkHeroReq(data, callback)
	GameNetHandler:SendWaitMessage("user.SetHomeWalkHeroReq", {heroIdList = data.heroIdList}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% SetHomeWalkHeroResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
			GameMsgMgr:sendEvent(GameMsgType.RoleWalkChange)
		end
    end)
end

--请求赠送角色好感度礼物
function Character:heroAffectionGitfReq(data, callback)
	GameNetHandler:SendWaitMessage("user.HeroAffectionGitfReq", {id = data.id, giftId = data.giftId, count = data.count}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% HeroAffectionGitfResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

function Character:gmCommandReq(data, callback)
	GameNetHandler:SendWaitMessage("user.GmCommandReq", {content = data.content}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% GmCommandResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
end



--请求领取角色好感度等级奖励
function Character:heroAffectionRewardReq(data, callback)
	GameNetHandler:SendWaitMessage("user.HeroAffectionRewardReq", {id = data.id, level = data.level}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% HeroAffectionRewardResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--接受好感度事件请求
function Character:acceptAffectionEventReq(data, callback)
	GameNetHandler:SendWaitMessage("user.AcceptAffectionEventReq", {id = data.id, selectIndex = data.selectIndex}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% AcceptAffectionEventResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--请求完成好感度事件委托
function Character:delegateEventFinishReq(data, callback)
	GameNetHandler:SendWaitMessage("user.DelegateEventFinishReq", {id = data.id}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% DelegateEventFinishResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
    end)
end

--请求领取模拟演习层奖励
function Character:getSimulatedAwardReq(data, callback)
	GameNetHandler:SendWaitMessage("user.GetSimulatedAwardReq", {floorId = data.floorId}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetSimulatedAwardResp", tablex.dump(data))
			self:ReceiveReward(data.rewardList, callback)
			--提前变化按钮状态
			local simulatedLevel = UIMgr:getUIData("SimulatedLevelPanel")
			if simulatedLevel then
				simulatedLevel.ui:changeToFinishBtn()
			end
		end
	end)
end

--请求模拟演习扫荡战斗
function Character:simulatedSweepReq(data, callback)
	GameNetHandler:SendWaitMessage("user.SimulatedSweepReq", {formationId = data.formationId}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% SimulatedSweepResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
			UIMgr:popUICover("SimulatedSweepRewardPanel", data)
		end
	end)
end

--请求领取Boss积分奖励
function Character:getBossScoreAwardReq(data, callback)
	GameNetHandler:SendWaitMessage("user.GetBossScoreAwardReq", {scoreId = data.scoreId or 0}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetBossScoreAwardResp", tablex.dump(data))
			self:ReceiveReward(data.rewardList)
			if (callback) then
				callback(data)
			end
		end
	end)
end

--请求设置Boss战Tag列表
function Character:setWeeklyBossTagReq(data, callback)
	GameNetHandler:SendWaitMessage("user.SetWeeklyBossTagReq", {bossId = data.bossId, tagList = data.tagList}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% SetWeeklyBossTagResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
end

--请求已读功能开放
function Character:readFunctionReq(data, callback)
	GameNetHandler:SendWaitMessage("user.ReadFunctionReq", {functionId = data.functionId}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% ReadFunctionResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
end



--请求打开道具礼包奖励
function Character:openGiftPackReq(data, callback)
	GameNetHandler:SendWaitMessage("user.OpenGiftPackReq", {id = data.id, num = data.num, selectIndex = data.selectIndex}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% OpenGiftPackResp", tablex.dump(data))
			self:ReceiveReward(data.rewardList)
			if (callback) then
				callback()
			end
			
		end
	end)
end

---上报家园英雄完成行为
---@param data ReportHeroHomeActionCompletedReq
---@param callback function?
function Character:ReportHeroHomeActionCompletedReq(data, callback)

	local s = ""
	for i = 1, #data.heroActions do
		local v = data.heroActions[i]
		s = s .. "id:" .. tostring(v.heroId) .. " actionId:" .. tostring(v.actionId) .. "\n"
	end
	LuaLogger.ds("===>> 请求角色数据" .. s)
	GameNetHandler:SendWaitMessage("user.ReportHeroHomeActionCompletedReq", data, function(data)

		if data.ret == 0 then
			LuaLogger.ds("===>>> ReportHeroHomeActionCompletedReq\n" ..  tablex.dump(data))

			local str = ""
			for i,v in ipairs(data.infos) do
				local lastActionType = -1
				local heroInfo = Me:getPlayerHero(v.heroId)
				if heroInfo then
					lastActionType = heroInfo.homelandActionInfo and heroInfo.homelandActionInfo.lastActionId
					lastActionType = lastActionType or 0 
				end


				str = str .. "id:".. v.heroId.. ",actionId:".. v.actionId.. ",lastActionType:" .. lastActionType.. ", 属性奖励数量:".. (v.attributeVals and #v.attributeVals or  0).. ", 道具奖励数量:".. (v.rewardList and #v.rewardList or  0) .. "\n"
			end
			LuaLogger.ds("===>>> " .. str)
			if (callback) then
				callback(data)
			end
		end
	end)
end



---进出家园请求
---@param isEnter boolean true 进家园 false 出家园
function Character:ReportHomelandEnterExitReq(isEnter)
	GameNetHandler:SendWaitMessage("user.ReportHomelandEnterExitReq", {isEnter = isEnter}, function(data)
		if data.ret == 0 then
			LuaLogger.ds("===>>> 设置家园进出状态成功 isEnger:" .. tostring(data.isEnter))
		end
	end)
end


---领取家园收益请求
---@param callback fun() 回调
function Character:ReportHomelandGetEarningRewardReq(callback)
	LuaLogger.ds("领取家园收益")
	GameNetHandler:SendWaitMessage("user.ReportHomelandGetEarningRewardReq", {}, function(data)
		if data.ret == 0 then
			LuaLogger.ds("===>>> 领取家园收益请求成功 ..." .. tablex.dump(data.rewardList))
			Me.homeland.earningsItemList = {}
			self:ReceiveReward(data.rewardList)
			if callback ~= nil then
				callback()
			end
		end
	end)
end

---一键收集家园资源（建筑产出+离线收益）
---@param callback fun(rewardList:table)? 成功回调
function Character:OneKeyCollectHomelandResourceReq(callback)
	LuaLogger.ds("一键收集家园资源")
	GameNetHandler:SendWaitMessage("user.OneKeyCollectHomelandResourceReq", {}, function(data)
		if data.ret == 0 then
			LuaLogger.ds("===>>> 一键收集成功 ..." .. tablex.dump(data.rewardList))
			Me.homeland.earningsItemList = {}
			self:ReceiveReward(data.rewardList)
			GameMsgMgr:sendEvent(GameMsgType.HomelandOneKeyCollected)
			if callback ~= nil then
				callback(data.rewardList)
			end
		end
	end)
end

---刷新商店
---@param shopType integer
---@param callback function?
function Character:ShopRefreshReq(shopType, callback)


	GameNetHandler:SendWaitMessage("user.ShopRefreshReq", {shopId = shopType}, function(data)
			if data.ret ~= 0 then
				LuaLogger.es("刷新商店失败 eror:" .. tostring(data.ret))
				return
			end
	    	UICommonUtils.PopToast(LocalStrEnum.Shop_RefreshSuccessTip)

			GameMsgMgr:sendEvent(GameMsgType.Shop_RefreshShopTypeMsg, shopType, data.ret)
			if callback ~= nil then
				callback(data.ret)
			end
		end)
end


---购买商品
---@param goodsId integer
---@param buyNum integer
---@param callback fun(goodsId:integer)?
function Character:ShopBuyReq(goodsId, buyNum, callback,callBackAfterReward)
	GameNetHandler:SendWaitMessage("user.ShopBuyReq", {goodsId = goodsId, buyNum = buyNum}, function(data)
		if data.ret ~= 0 then
			return
		end

		--抽卡界面购买抽奖券时不显示弹窗
		if RaffleMgr:getIsBuyRaffleTicket() then
			if (callback) then
				callback(data.ret)
			end
			RaffleMgr:setIsBuyRaffleTicket(false)
			return
		end

		if tablex.size(data.rewardList) > 0 then

			self:ReceiveReward(data.rewardList, callBackAfterReward)
		else
			if (callBackAfterReward) then
				callBackAfterReward(goodsId)
			end
		end
		GameMsgMgr:sendEvent(GameMsgType.Shop_BuyGoodsMsg, goodsId, buyNum, data.ret)
		if callback ~= nil then
			callback(goodsId)
		end
	end)
end



--向服务器记录自定义字段
-- {key = value,
-- key = value}
function Character:RecordCustomData(data, callback)
	local cjson = require "cjson"
	LuaLogger.ds("%%%%%%%%%% SetUserDefinedReq", tablex.dump(data))
	GameNetHandler:SendWaitMessage("user.SetUserDefinedReq", {info = luautil.serialize(data)}, function(data)
		LuaLogger.ds("%%%%%%%%%% SetUserDefinedResp", tablex.dump(data))
		if callback then
			callback(data)
		end
	end)
end




--请求领取通行证奖励
function Character:getPassRewardReq(data, callback)
	GameNetHandler:SendWaitMessage("user.GetPassRewardReq", {id = data.id,level = data.level,rewardState = data.rewardState}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetPassRewardResp", tablex.dump(data))
			self:ReceiveReward(data.rewardList)
			if (callback) then
				callback(data)
			end
		
		end
	end)
end


--调查问卷领奖调用
function Character:GetQnaireRewardReq(data, callback)
	GameNetHandler:SendWaitMessage("user.GetQnaireRewardReq", {qnaireId = data.qnaireId}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetQnaireRewardResp", tablex.dump(data))
			self:ReceiveReward(data.rewardList)
			if (callback) then
				callback(data)
			end
		end
	end)
end

--修改英雄名称
function Character:heroChangeNameReq(data, callback)
	GameNetHandler:SendWaitMessage("user.HeroChangeNameReq", {id = data.id, newName = data.newName}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% HeroChangeNameResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
end

--region 好友相关

---请求推荐好友列表
function Character:SuggestFriendReq()
	Me.searchFriends = {}
	Me.suggestFriends = {}
	GameNetHandler:SendWaitMessage("user.OperateFriendReq", {operate = GE.OperateFriend.suggest, uidList = {}}, function(data)
			if data.ret == 0 then
			
			end
		end)
end


---添加好友请求
---@param uids integer|integer[]
---@param callback fun(uids:integer[])
function Character:AddFriend(uids, callback)
	if type(uids) == "number" then
		uids = {uids}
	end

	GameNetHandler:SendWaitMessage("user.OperateFriendReq", {operate = GE.OperateFriend.reqAdd, uidList = uids}, function(data)
			if data.ret ~= 0 then
				return
			end

			local tab = {}
			local delRequestTab = {}
			for i = 1, #data.successList do
				local uid = data.successList[i]
				---更新请求添加好友数据
				local index = tablex.indexof(self.selfRequestTab, uid)
				if index < 0 then
					table.insert(self.selfRequestTab, index)
				end


				---清除好友查找信息列表数据
				tab[uid] = {}

				---如果此好友在申请列表中则直接同意
				if self.requestFriends[uid] ~= nil then
					delRequestTab[uid] = self.requestFriends[uid]
				end
			end

		
			---清除好友查找信息列表数据
			ClientData.FriendInfoNTF({operate = GE.OperateFriendPush.searchFriend, friendList = tab})
			ClientData.FriendInfoNTF({operate = GE.OperateFriendPush.suggestFriendList, friendList = tab})

			if tablex.size(delRequestTab) > 0 then
				---添加好友
				ClientData.FriendInfoNTF({operate = GE.OperateFriendPush.friendList, friendList = delRequestTab})


				for k, v in pairs(delRequestTab) do
					delRequestTab[k] = {}
				end
				---删除申请列表
				ClientData.FriendInfoNTF({operate = GE.OperateFriendPush.requestList, friendList = delRequestTab})
			end

			UICommonUtils.PopToast(LocalStrEnum.Friend_ApplySuccess)
			if callback then
				callback(data.successList)
			end
		end)
end


---删除好友
---@param uids integer|integer[]
function Character:DeleteFriend(uids)
	if type(uids) == "number" then
		uids = {uids}
	end
	GameNetHandler:SendWaitMessage("user.OperateFriendReq", {operate = GE.OperateFriend.del, uidList = uids}, function(data)
			if data.ret ~= 0 then
				return
			end

		
			local tab = {}
			for i = 1, #data.successList do
				local uid = data.successList[i]
				tab[uid] = {}
				local index = tablex.indexof(Me.selfRequestTab, uid)
				if index > 0 then
					table.remove(Me.selfRequestTab, index)
				end
			end

			local delFriendInfo = self.friends[data.successList[1]]
			ClientData.FriendInfoNTF({operate = GE.OperateFriendPush.friendList, friendList = tab})
			
			if delFriendInfo ~= nil then
				local s = string.format(LocalStrEnum.Friend_DeleteSuccess, delFriendInfo.baseInfo.name) 
				UICommonUtils.PopToast(s)
			end
		end)
end

---查找好友
---@param uids integer|integer[]
---@param callback fun(friendInfo:FriendInfo)?
function Character:SearchFriend(uids, callback)
	if type(uids) == "number" then
		uids = {uids}
	end
	self.searchFriends = {}
	GameNetHandler:SendWaitMessage("user.OperateFriendReq", {operate = GE.OperateFriend.find, uidList = uids}, function(data)
			if data.ret ~= 0 then
				return
			end
		end)
end

---拒绝添加好友
---@param uids integer|integer[]
---@param callback fun(uids:integer[])?
function Character:RejectAddFriend(uids, callback)
	if type(uids) == "number" then
		uids = {uids}
	end
	GameNetHandler:SendWaitMessage("user.OperateFriendReq", {operate = GE.OperateFriend.rejectAdd, uidList = uids}, function(data)
			if data.ret ~= 0 then
				return
			end

			local tab = {}
			for i = 1, #data.successList do
				tab[data.successList[i]] = {}
			end
			ClientData.FriendInfoNTF({operate = GE.OperateFriendPush.requestList, friendList = tab})	
			if (callback) then
				callback(data.uidList)
			end
		end)
end

---同意添加好友
---@param uids integer|integer[]
---@param callback fun(uids:integer[])?
function Character:AgreeAddFriend(uids, callback)
	if type(uids) == "number" then
		uids = {uids}
	end
	GameNetHandler:SendWaitMessage("user.OperateFriendReq", {operate = GE.OperateFriend.applyAdd, uidList = uids}, function(data)
			if data.ret ~= 0 then
				return
			end
			local tab = {}
			for i = 1, #data.successList do
				local uid = data.successList[i]
				local fInfo = Me.requestFriends[uid]
				if fInfo == nil then
					LuaLogger.es("添加好友失败 未找到对应的好友数据id:" .. tostring(uid))
					return
				end
				tab[uid] = fInfo
			end

			ClientData.FriendInfoNTF({operate = GE.OperateFriendPush.friendList, friendList = tab})

			local tab = {}
			for i = 1, #data.successList do
				tab[data.successList[i]] = {}
			end
			ClientData.FriendInfoNTF({operate = GE.OperateFriendPush.requestList, friendList = tab})

			UICommonUtils.PopToast(LocalStrEnum.Friend_AgreeAddFriend)
			if (callback) then
				callback(data.uidList)
			end
		end)
end

---发送友情点
---@param uids integer|integer[]
---@param callback fun(uids:integer[])?
function Character:GiveFriendPointReq(uids, callback)
	if type(uids) == "number" then
		uids = {uids}
	end
	GameNetHandler:SendWaitMessage("user.GiveFriendPointReq", { uidList = uids}, function(data)
		if data.ret ~= 0 then
			return
		end
		local time = EngineUtil.ServerTime_Seconds()
		time = math.floor(time)
		for i = 1, #data.successList do
			local id = data.successList[i]
			Me.friendPointGive[id] = time
		end

		UICommonUtils.PopToast(LocalStrEnum.Friend_GiveGiftSuccess)
		if (callback) then
			callback(data.successList)
		end
	end)
end


---领取友情点
---@param uids integer|integer[]
---@param callback fun(uids:integer[])?
function Character:GetFriendPointReq(uids, callback)
	if type(uids) == "number" then
		uids = {uids}
	end
	GameNetHandler:SendWaitMessage("user.GetFriendPointReq", {uidList = uids}, function(data)
		if data.ret ~= 0 then
			return
		end
		for i = 1, #data.successList do
			local id = data.successList[i]
			Me.friendPointGet[id] = true
		end
		UICommonUtils.PopToast(LocalStrEnum.Friend_GetGiftSuccess)
		if (callback) then
			callback(data.successList)
		end
	end)
end




---添加家园互动道具奖励
function Character:ReportHomelandCovePropsAddRewardReq(covePropsId, actionId, callback)
	GameNetHandler:SendWaitMessage("user.ReportHomelandCovePropsAddRewardReq", {id = covePropsId, actionId = actionId}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% ReportHomelandCovePropsAddRewardReq", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
end


---领取家园互动道具奖励
function Character:ReportHomelandCovePropsGetRewardReq(covePropsId, callback)
	GameNetHandler:SendWaitMessage("user.ReportHomelandCovePropsGetRewardReq", {id = covePropsId}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% ReportHomelandCovePropsGetRewardReq", tablex.dump(data))
			self:ReceiveReward(data.rewards)
			if (callback) then
				callback(data)
			end
		end
	end)
end



---进出关卡
---@param levelId integer
---@param callback function?
function Character:BattleEnterLevelReq(levelId, callback)
	GameNetHandler:SendWaitMessage("user.BattleEnterLevelReq", {levelId = levelId}, function(data)
		if data.ret == 0 then
			if (callback) then
				callback(data)
			end
		end
	end)
end


---发送英雄交互对话
---@param heroId integer
---@param talkId integer
---@param callback function
function Character:ReportHomelandCoveHeroInteractionReq(heroId, talkId, callback)
	GameNetHandler:SendWaitMessage("user.ReportHomelandCoveHeroInteractionReq", {heroId = heroId, talkId = talkId}, function(data)
		if data.ret == 0 then
			if (callback) then
				callback(data)
			end
		end
	end)
end


---发送创建战斗宝箱信息
---@param covePoints table<integer, CovePos>
---@param isCrateReward boolean
---@param callback fun(coveBoxReward:CoveBoxReward[])?
function Character:ReportCreateHomelandBattleRewardBoxReq(covePoints, isCrateReward, callback)
	GameNetHandler:SendWaitMessage("user.ReportCreateHomelandBattleRewardBoxReq", {covePoints = covePoints, isCrateReward = isCrateReward}, function(data)
		if data.ret == 0 then
			if callback ~= nil then
				callback(data.coveBoxReward)
			end
		end
	end)
end


---发送戰鬥結束消息
---@param callback fun(coveBoxReward:CoveBoxReward[])?
function Character:ReportHomelandBattleGameOverReq(callback)
	GameNetHandler:SendWaitMessage("user.ReportHomelandBattleGameOverReq", {}, function(data)
		if data.ret == 0 then
			if callback ~= nil then
				callback(data.coveBoxReward)
			end
		end
	end)
end


---发送领取宝箱消息
---@param uids integer[]
---@param callback fun(reward:RewardInfo[])?
function Character:ReportGetHomelandBattleRewardBoxReq(uids, callback)

	GameNetHandler:SendWaitMessage("user.ReportGetHomelandBattleRewardBoxReq", {uids = uids}, function(data)
		if data.ret == 0 then
			self:ReceiveReward(data.rewardList)
			if callback ~= nil then
				callback()
			end
		end
	end)
end

--endregion
---显示获奖奖励
---@param rewardList RewardInfo[] 奖励列表
---@param closeFun fun()? 回调函数
function Character:ReceiveReward(rewardList, closeFun)
	if rewardList == nil then
		if (closeFun) then
			closeFun()
		end
		return
	end
	--剔除不需要显示的奖励
	local finalRewardList = {}
	for _, rewardData in pairs(rewardList) do
		if rewardData.type == GE.RewardType.ItemProp then
			local itemConfig = Config.GetItemInfo(rewardData.id)
			if itemConfig.awardIsNotShow == 1 then
				
			else
				table.insert(finalRewardList, rewardData)
			end
		else
			--其他奖励类型直接添加
			table.insert(finalRewardList, rewardData)
		end
	end
	if #finalRewardList == 0 then
		if (closeFun) then
			closeFun()
		end
		return
	end
	local heroReward = {}
	local skinReward = {}
	for i = 1, #finalRewardList do
		local rl = finalRewardList[i]
		if rl.type == GE.RewardType.Character then
			table.insert(heroReward, rl)
		elseif rl.type == GE.RewardType.Skin then
			table.insert(skinReward, rl.id)
		end
	end
	--普通道具奖励页面
	local showReward_item = function ()
		UIMgr:popUICover("ReceiveRewardPanel", {rewardList = finalRewardList,closeFunc = function()
			if (closeFun) then
				closeFun()
			end
		end})
	end
	if #heroReward == 0 and #skinReward == 0 then
		showReward_item()
		return
	end

	local showSkin_item = function ()
		if #skinReward > 0 then
			UIMgr:popUICover("SkinPreviewPanel", {
				skinId = skinReward[1],
				nowMode = true,
				skinList = skinReward,
				callback = showReward_item
			})
		else
			showReward_item()
		end
	end

	if #heroReward > 0 then
		RaffleMgr:setRaffleResultList(heroReward)
		RaffleMgr:ShowResultData(showSkin_item)
	elseif #skinReward > 0 then
		showSkin_item()
	end
end


local REWARD_TO_ITEM_MAP = {
    [GE.RewardType.Character] = GE.ItemTypeIndex.Character,
    [GE.RewardType.Skin]      = GE.ItemTypeIndex.skin,
	[GE.RewardType.Weapon] = GE.ItemTypeIndex.weapon,
	[GE.RewardType.Equipment] = GE.ItemTypeIndex.equip,
}

local REWARD_TO_CUSTOMMSG_MAP = {
    [GE.RewardType.Character] = GE.CustomMsgType.Character,
    [GE.RewardType.Skin]      = GE.CustomMsgType.Skin,
	[GE.RewardType.Weapon] = GE.CustomMsgType.Weapon,
	[GE.RewardType.Equipment] = GE.CustomMsgType.Equip,
}

-- 自动生成反向映射表，避免手动写两次逻辑
local ITEM_TO_REWARD_MAP = {}
for k, v in pairs(REWARD_TO_ITEM_MAP) do
    ITEM_TO_REWARD_MAP[v] = k
end

---@param rewardType GE.RewardType
---@return GE.ItemTypeIndex
function Character:RewardTypeToItemype(rewardType)
	return REWARD_TO_ITEM_MAP[rewardType] or GE.ItemTypeIndex.item
end

---@param itemType GE.ItemTypeIndex
---@return GE.RewardType
function Character:ItemTypeToReward(itemType)
	return ITEM_TO_REWARD_MAP[itemType] or GE.RewardType.ItemProp
end

---@param rewardType GE.RewardType
---@return GE.CustomMsgType
function Character:RewardTypeToCustomMsgType(rewardType)
	return REWARD_TO_CUSTOMMSG_MAP[rewardType] or GE.CustomMsgType.Item
end



---@class ShowItemTipsData
---@field id integer 道具ID
---@field type GE.RewardType 奖励类型
---@field navType GE.NavigationType? 导航类型，决定跳转按钮的显示和功能
---@field CanLock boolean? 是否显示锁定功能，默认为true
---@field needNum integer? 需要的数量，只有当type为ItemProp时有效
---@field tipsPassEventState integer? 通过事件状态
---@field isResources boolean? 是否是资源类(关联是否显示跳转的另一种判断)

---@param rewardData ShowItemTipsData
function Character:ShowItemTips(rewardData)
	if rewardData.type == GE.RewardType.Character then
		UIMgr:popUICover("DockRolePanel", { characterId = rewardData.id, uiMode = 3 })
        return
	elseif rewardData.type == GE.RewardType.Skin then
       	UIMgr:popUICover("SkinPreviewPanel", { skinId = rewardData.id})
        return
	end
	local cfg = nil
	if rewardData.type == GE.RewardType.ItemProp then	
		cfg = Config.GetItemInfo(rewardData.id)
	elseif rewardData.type == GE.RewardType.Weapon then
        local weaponData = Me:getWeaponDataById(rewardData.id)
		if weaponData == nil then
        	--预览模式
			rewardData.CanLock = false
			weaponData = {cid = rewardData.id}
		end
        cfg = Config.GetWeaponInfo(weaponData.cid)
	elseif rewardData.type == GE.RewardType.Equipment then
		local equipData = Me:getEquipDataByid(rewardData.id)
        if equipData == nil then
        	--预览模式
			rewardData.CanLock = false
			equipData = {cid = rewardData.id}
		end
        cfg = Config.GetEquipmentInfo(equipData.cid)
	end
	local data =  {
        type = self:RewardTypeToCustomMsgType(rewardData.type),
        config = cfg,
        Id = rewardData.id,
		CanLock = rewardData.CanLock,
		tipsPassEventState = rewardData.tipsPassEventState,
		navType = rewardData.navType,
		needNum = rewardData.needNum,
		ownerPanelName = rewardData.ownerPanelName,
		isResources = rewardData.isResources or false,
		disableMaskEvent = rewardData.disableMaskEvent,
    } 
    UIMgr:popUICover("CustomTipsMsgPanel", data)
end

--请求修改角色语种
function Character:setCharVoiceReq(data, callback)
	GameNetHandler:SendWaitMessage("user.SetCharVoiceReq", data, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% SetCharVoiceResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
end

--请求兑换码奖励
function Character:getRedeemCodeAwardReq(data, callback)
	GameNetHandler:SendWaitMessage("user.GetRedeemCodeAwardReq", data, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% GetRedeemCodeAwardResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
end

--请求修改角色初始语种
function Character:setCharInitVoiceReq(voiceType, callback)
	GameNetHandler:SendWaitMessage("user.SetCharInitVoiceReq", {type = voiceType}, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% SetCharInitVoiceResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
end


--请求修改角色初始语种
function Character:GameShareReq(data, callback)
	GameNetHandler:SendWaitMessage("user.GameShareReq", data, function(data)
		if data.ret == 0 then
			print("%%%%%%%%%% GameShareResp", tablex.dump(data))
			if (callback) then
				callback(data)
			end
		end
	end)
end


function Character:payReq(id, pay_channel, extra, callBack,SuccessCB)
	if GV.GlobalConfig.IsInternalFormal() then
		local isIOS = UnityEngine.Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer
		if isIOS then
			local version = string.format("%d.%d.%d.%d", EngineGlobal.PublishCode1, EngineGlobal.PublishCode2, EngineGlobal.PublishCode3, EngineGlobal.PublishCode4)
			--print("version", version)
			--if version ~= "1.0.0.55" then
			--	UICommonUtils.PopMsgBox(LocalStrEnum.UI_PromptTitle, "请至App store更新游戏版本或卸载重装。\n若更新后支付还有问题，请加官方qq群439723180联系管理员-令狐伯光。", MsgBoxType.OK, function ()
			--	end)
			--	return
			--end
		end
	end
	local init = PayMgr:CheckPayInit(pay_channel)
	if not init then
		UICommonUtils.PopToast("支付没有初始化")
		return
	end
	if not Me._pay_initial then
		UICommonUtils.PopToast("支付初始化中")
		return
	end
	local item_id = id
	local item_num = 1
	if type(id) == "table" then
		item_id = id.id
		item_num = id.num or 1
	end

	self._successCB = SuccessCB
	GameNetHandler:SendWaitMessage("user.payReq", {itemid = item_id, item_num = item_num, pay_channel = pay_channel, extra = extra, identify = NativeInfo.GetBundleIdentifier(), device = NativeInfoLua.GetDeviceID(), deviceType = UnityEngine.Application.platform:ToInt()}, function (data)
		if data.ret == ActionFailReason.None then
			Me.__orderString = data.orderString
			Me.__game_trade_no = data.game_trade_no
		end
		callBack(data.ret == ActionFailReason.None, data)
	end)
end

function Character:payValidateReq(receipt, token, success, payType, callBack)
	GameNetHandler:SendWaitMessage("user.payValidateReq", {receipt = receipt, identify = NativeInfo.GetBundleIdentifier(), device = NativeInfoLua.GetDeviceID(), purchaseToken = token, success = success, payType = payType, deviceType = UnityEngine.Application.platform:ToInt(), orderString = Me.__orderString or "empty" }, function (data)
		self:updateRewards( data)
		callBack(data.ret == ActionFailReason.None, data)
	end)
end

function Character:payResultReq(receipt, token, success, pay_channel, msg, callBack)
	GameNetHandler:SendWaitMessage("user.payResultReq", {game_trade_no = Me.__game_trade_no, receipt = receipt, purchaseToken = token, identify = NativeInfo.GetBundleIdentifier(), device = NativeInfoLua.GetDeviceID(), success = success, pay_channel = pay_channel, result_msg = msg, deviceType = UnityEngine.Application.platform:ToInt(), orderString = Me.__orderString or "empty" }, function (data)
		callBack(data.ret == ActionFailReason.None, data)
	end)
end


--获取当前进入的方式
function Character:getPaySuccessCB()
	return self._successCB
end

return Character