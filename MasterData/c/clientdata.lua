-- ClientData这个类是用来存储客户端数据的，包括玩家数据，道具数据，任务数据等等
-- 通过这个类可以获取到玩家的数据，也可以设置玩家的数据，从服务器获取数据后，如果这些数据不适合放在Me中，会存放在这里，如果Me中存在数据，会更新Me中的数据

---@class ClientData
local ClientData = class("ClientData")

local Player = require("PlayerAll").loadAllModules()
local cjson = require "cjson"

function ClientData:ctor()
	self.needCalc = nil
	self.propChange = nil
	self.HideInfo = nil
	self.IsHangData = nil
	self.showItemChange = true
	self.nowSetStoryId = 0
	self.signInShowed = false
	self.listDown = false
	self.activityPanelLastSelectId = nil --记录活动面板最后选择的活动ID 跳转用

	self.nowSelectChatperId = 0
	self.nowSelectLevelId = nil

	self.PosterData = {}
	self.backMainFunc = nil
	self.NoticeData = {}  --公告信息
	self._customData = {} --自定义数据
	self._levelUpBackFunc = nil
	self.isPlaySpineInto = false--是否播放过spine进入动画

	---@type boolean? 是否跳过开场剧情
	self._jumpOpenStory = nil
	self._maintainance = false	--公告获取的是否维护中
	self._whiteList = {} --维护白名单
	-- {
	-- 	premiumShopData = {
	-- 		[1] = GoodsInfo,
	-- 		...
	-- 	},
	-- 	generalShopData = {
	-- 		[1] = {
	-- 			[1] = {
	-- 				nextRefreshTime = 0,
	-- 				refreshNum = 1,
	-- 				goodsInfoList = {
	-- 					[1] = GoodsInfo,
	-- 					...
	-- 				}
	-- 			},
	-- 			...
	-- 		},
	-- 		...
	-- 	},
	-- 	foreverData = {
	-- 		[1] = 1,
	-- 		...
	-- 	},
	-- }
	-- GoodsInfo = {
	-- 	id = 12,		--商品id
	-- 	buyTimes = 1,	--购买次数
	-- 	RefreshTime = 2351232,	--下次刷新时间
	-- 	isDated = false,		--是否过期
	-- 	allBuyTimes = 0,		--总购买次数
	-- 	triggerTime = 1235123	--触发时间
	--  discount = 50,	--折扣	
	-- }
	GameMsgMgr:regEvent(GameMsgType.GameReconnected, self, self.OnGameReconnected)
	GameMsgMgr:regEvent(GameMsgType.GameDisconnected, self, self.OnGameDisconnected)
	-- self.justUseItem = false
end

--升级回调
function ClientData:CheckLevelUpBackFunc()
	if self._levelUpBackFunc then
		self._levelUpBackFunc()
		self._levelUpBackFunc = nil
	end
end

--设置当前选中章节ID
function ClientData:SetNowSelectChatperId(ChatperId)
	self.nowSelectChatperId = ChatperId
end
--获取当前选中章节ID
function ClientData:GetNowSelectChatperId()
	return self.nowSelectChatperId
end

--设置当前选中关卡ID	跳转用
function ClientData:SetNowSelectLevelId(levelId)
	self.nowSelectLevelId = levelId
end

--获取当前选中关卡ID	跳转用
function ClientData:GetNowSelectLevelId()
	return self.nowSelectLevelId
end

--获取角色数据
function ClientData:GetRoleList()
	return Me.heroList
end

--获取道具列表
function ClientData:getItemMap()
	return Me.itemMap
end

--根据id获取道具信息
function ClientData:getItemById(id)
	return Me.itemMap[id]
end

--设置门票数据
function ClientData:SetTicketData(ticket)
	Me.ticket = ticket
	GameMsgMgr:sendEvent(GameMsgType.RefreshMainPanel)
	GameMsgMgr:sendEvent(GameMsgType.RefreshBattleRepeatPanel)
    RedPointMgr:Refresh("MainPanelUserDetail")
end

--设置委托列表
function ClientData:SetDelegateEventMap(delegateEventList)
	if not Me.affectionData then
		return
	end
	-- 仅在有明确数据时更新，避免 partial update 用 nil 误清；空列表用 {} 同步
	if delegateEventList ~= nil then
		Me.affectionData.delegateEventList = delegateEventList
	end
end

--设置上次选中的活动ID
function ClientData:RecordActivityPanelLastSelectId(activityId)
	self.activityPanelLastSelectId = activityId
end

--获取上次选中的活动ID
function ClientData:GetActivityPanelLastSelectId()
	return self.activityPanelLastSelectId
end

--设置普通门票恢复倒计时
function ClientData:SetTicketRecoverTimeRemaining()
	local lastRecoverTime = Me.ticket.lastRecoverTime
    local setTime = Config.GetConfigInfo("RecoverTicketTime")
    local nowTime = math.modf(EngineUtil.ServerTime_Seconds())
	local needRecoverNumAll = Config.GetConfigInfo("LimitNormalTicketNum") - Me.ticket.num
    local nextRecoverTime = lastRecoverTime + setTime
	local allRecoverTime = lastRecoverTime + (setTime * needRecoverNumAll)
    local timeRemainingNext = nextRecoverTime - nowTime
	local timeRemainingAll = allRecoverTime - nowTime
	if timeRemainingNext < 1 and needRecoverNumAll > 0 then
		Me:recoverNormalTicketReq()
	end
	return timeRemainingNext, timeRemainingAll
end

--获取对应道具
function ClientData:GetItemPropData(id)
	local itemPropData = Me.itemProps[id]
	return itemPropData
end

--根据类型获取道具列表
function ClientData:GetItemPropsDataByType(type)
	local itemPropsList = {}
	for k, v in pairs(Me.itemProps) do
		local itemData =  Config.GetItemPropInfo(v.id)
		if itemData and itemData.Type == type then
			table.insert(itemPropsList, v)
		end
	end
	return itemPropsList
end

--获取玩家邮件数据
function ClientData:GetMailList()
	local mailList = Me.mails
	return mailList
end

--获取玩家收藏邮件key列表数据
function ClientData:GetFavorMailKeyList()
	local favorMailKeyList = Me.mailCollect
	return favorMailKeyList
end

--获取玩家收藏邮件数据
function ClientData:getMailCollectCosData()
	return self.mailCollectCosData
end

--获取当前剧情id
function ClientData:GetNowSetStoryId()
	return self.nowSetStoryId
end

--设置当前剧情id
function ClientData:SetNowSetStoryId(id)
	self.nowSetStoryId = id
end

--获取看板娘信息
function ClientData:GetPosterData()
	return Me.posterData
end

function ClientData:Clear()
end

--更新角色数据
function ClientData.HeroNtf(hero)
	local ok, res = Me:updateHero(hero)
end

function ClientData.HeroListNtf(heroes)
	for i,v in pairs(heroes) do
		ClientData.HeroNtf(v)
	end 
end

--初始化角色数据
function ClientData:InitRoleList()
    if Me.heroList and tablex.size(Me.heroList) ~= 0 then
		ClientData.HeroListNtf(Me.heroList)
	end
end

--初始化武器数据
function ClientData:InitWeaponMap()
    if Me.weaponMap and tablex.size(Me.weaponMap) ~= 0 then
		Me:updateWeaponData(Me.weaponMap)
	end
end

---差量更新道具信息
---@param itemProp ItemInfo
function ClientData.ItemPropsNtf(itemProp)
	local ok, res, added = Me:updateItemMap(itemProp)
end

---差量更新道具信息列表
---@param itemProps table<integer, ItemInfo>
function ClientData.ItemPropsListNtf(itemProps)
	for i,v in pairs(itemProps) do
		if not next(v) then
			Me.itemMap[i] = nil
		else
			ClientData.ItemPropsNtf(v)
		end
		
	end
end

function ClientData.FormationMapNtf(formationMap)
	if not Me.formationMap then
		Me.formationMap = {}
	end
	for i,v in pairs(formationMap) do
		Me.formationMap[i] = v
	end
	
	--TODO: 这里可以和前端刷新挂钩
end

--获取当前编队
function ClientData:GetNowFormationList()
	local formationMap = Me:getFormationMap()
	return formationMap
end

function ClientData:GetFormationMapById(id)
	return Me:getFormationListInfoById(id)
end

--获取玩家任务列表
function ClientData:GetTaskList()
	local needTask = {}
	for k, v in pairs(Me.taskList) do
		if v.state == GE.TaskState.Progressing then
			table.insert(needTask, v)
		end
	end
	return needTask
end

local updateFilter = 
{
	skills = true,
	equips = true,
	heroes = true,
	itemProps = true,
	tags = true,
	chapterInfo = true,
}

function ClientData.FromProto(data, key)
	local value = Player.SerialiseValues[key]
	if updateFilter[key] then
		data = value.fromProtoFunc(data, value.key)
	end
	return data
end

function ClientData:GetRoomInfo()
	return Me.roomInfoMap
end

function ClientData:SetRoomInfo(roomInfoMap)
	if type(roomInfoMap) ~= "table" then
		return
	end
	Me.roomInfoMap = Me.roomInfoMap or {}
	for roomId, newRoomInfo in pairs(roomInfoMap) do
		if newRoomInfo then
			Me.roomInfoMap[roomId] = Me.roomInfoMap[roomId] or {}
			Me.roomInfoMap[roomId].furUuidList = Me.roomInfoMap[roomId].furUuidList or {}
			Me.roomInfoMap[roomId].furPosList = Me.roomInfoMap[roomId].furPosList or {}
			
			local newFurUuidList = newRoomInfo.furUuidList or {}
			local newFurPosList = newRoomInfo.furPosList or {}
			
			local currFurUuidDict = {}
			for i, currFurUuid in ipairs(Me.roomInfoMap[roomId].furUuidList) do
				currFurUuidDict[currFurUuid] = true
			end
			local hasNewFur = false
			for i, newFurUuid in ipairs(newFurUuidList) do
				if not currFurUuidDict[newFurUuid] then
					table.insert(Me.roomInfoMap[roomId].furUuidList, newFurUuid)
					hasNewFur = true
				end
			end
			if hasNewFur then
				local MainPanel = UIMgr:GetUI("MainPanel")
				if MainPanel then
					MainPanel:SetRoomDataView()
				end
			end

			local currFurPosDict = {}
			for i, currFurPos in ipairs(Me.roomInfoMap[roomId].furPosList) do
				currFurPosDict[currFurPos.furUuid] = currFurPos
			end
			for i, newFurPos in ipairs(newFurPosList) do
				local currFurPos = currFurPosDict[newFurPos.furUuid]
				if not currFurPos then
					table.insert(Me.roomInfoMap[roomId].furPosList, newFurPos)
				else
					currFurPos.furPosX = newFurPos.furPosX
					currFurPos.furPosY = newFurPos.furPosY
				end
			end
		end
	end
end

---玩家差量更新
---@param data UserInfoUpdate
function ClientData.UserInfoUpdate(data)
	if not Me then
		LuaLogger.ws("No Me in ClientData.UserInfoUpdate(data)")
		return
	end
	local userinfo = data.userinfo
	LuaLogger.ds("************&&&&***************" ..  tablex.dump(userinfo))
	--主动请求部分服务器数据相关处理
	local rejectIsOpen = true
	if Standalone then
		rejectIsOpen = false
	end
	local rejectKeys = {}
	for k, v in pairs(userinfo) do
		if rejectIsOpen and GE.ToObsoletePushData[k] and Me.pushDataDownMap[k] == nil then
			table.insert(rejectKeys, k)
		end
	end
	if #rejectKeys > 0 then
		for _, v in ipairs(rejectKeys) do
			userinfo[v] = nil
		end
	end
	--优先处理队列
	local isLevelUpgradeToastFirst = false --等级升级界面优先于成就界面显示
	for k, v in pairs(userinfo) do
		if k == "level" then
			--等级有变化
			if Me.level and Me.level ~= v then
				local oldTicketNum = Me:getTicketData().num
				local newTicketNum = userinfo.ticket and userinfo.ticket.num or oldTicketNum
				UIMgr:popUI("LevelUpgradeToast", {newLevel = v, oldLevel = Me.level, oldTicketNum = oldTicketNum, newTicketNum = newTicketNum})
				isLevelUpgradeToastFirst = true
			end
			Me.level = v
			GameMsgMgr:sendEvent(GameMsgType.RefreshMainPanel)
		end
	end
	--普通处理队列
	for k, v in pairs(userinfo) do
		if k == "heroList" then
			if Me.heroList.newUser ~= nil then
				Me.heroList.newUser = nil
			end
			ClientData.HeroListNtf(userinfo.heroList)
			GameMsgMgr:sendEvent(GameMsgType.HeroListNtf)
			GameMsgMgr:sendEvent(GameMsgType.RefreshEventMsg)
			RedPointMgr:Refresh("DockBtnRedJudge")
		elseif k == "itemMap" then
			ClientData.ItemPropsListNtf(userinfo.itemMap)
			GameMsgMgr:sendEvent(GameMsgType.ItemMapNtf)
			GameMsgMgr:sendEvent(GameMsgType.RefreshTopResource)
			RedPointMgr:Refresh("GraphPaperRedJudge")
			RedPointMgr:Refresh("HomeBtnRedJudge")
		elseif k == "formationMap" then
			ClientData.FormationMapNtf(userinfo.formationMap)
		elseif k == "userData" then
			ClientData:SetUserDataInfoNtf(v)
		elseif k == "nextResetTime" then
			ClientData:SetNextResetTime(v)
		elseif k == "lastResetTime" then
			ClientData:SetLastResetTime(v)
		elseif k == "ticket" then
			ClientData:SetTicketData(v)
			GameMsgMgr:sendEvent(GameMsgType.RefreshTopResource)
		elseif k == "equipMap" then
			Me:updateEquipData(v)
			ClientData:InitRoleList()
		elseif k == "pveLevelMap" then
			Me:updatePveLevelData(v)
			GuideMgr:BattleFinishSetGuide()
			GameMsgMgr:sendEvent(GameMsgType.PveLevelMapUpdate)
		elseif k == "homeland" then
			local oldLevel
			if Me.homeland and Me.homeland.prosperityInfo then
				oldLevel = Me.homeland.prosperityInfo.currentLevel or 0
			end
			Me:updateHomelandData(v)
			GameMsgMgr:sendEvent(GameMsgType.RefreshHomeland)
			if v and v.prosperityInfo then
				GameMsgMgr:sendEvent(GameMsgType.ProsperityInfoUpdate)
				local newLevel = v.prosperityInfo.currentLevel
				if oldLevel ~= nil and newLevel and newLevel > oldLevel then
					GameMsgMgr:sendEvent(GameMsgType.ProsperityLevelUp, {newLevel = newLevel})
				end
			end
			RedPointMgr:Refresh("HomeBtnRedJudge")
		elseif k == "technologyTree" then
			Me:updateTechnologyTreeData(v)
			RedPointMgr:Refresh("ScienceTreeBtnRedJudge")
			ClientData:InitRoleList()
		elseif k == "exp" then
			Me.exp = v
			GameMsgMgr:sendEvent(GameMsgType.RefreshMainPanel)
		elseif k == "weaponMap" then
			Me:updateWeaponData(v)
			ClientData:InitRoleList()
		elseif k == "missionList" then
			ClientData:SetMissionListInfoNtf(v, isLevelUpgradeToastFirst)
		elseif k == "handbookData" then
			Me:updateHandbookData(v)
		elseif k == "skinList" then
			Me:updateSkinData(v)
		elseif k == "posterData" then
			Me:updatePosterData(v)
		elseif k == "headList" then
			Me:updateHeadData(v)
		elseif k == "name" then
			Me.name = v
		elseif k == "head" then
			Me.head = v
			GameMsgMgr:sendEvent(GameMsgType.RefreshHead)
		elseif k == "serverChannel" then
			Me.serverChannel = v
		elseif k == "gachaData" then
			Me.gachaData = v
			RaffleMgr:initRecordData()
		elseif k == "chapterAwardMap" then
			Me:updateChapterAwardData(v)
		elseif k == "mailCollect" then
			Me:updateMailCollectData(v)
			ClientData:setMailCollectDataByKey(function()
				GameMsgMgr:sendEvent(GameMsgType.MailListChange)
			end)
		elseif k == "affectionData" then
			--Me:updateAffectionData(v)
			LuaLogger.ds("affectionData",tablex.dump(v))
			Me:updateAffectionData(v)
			ClientData:InitRoleList()
			GameMsgMgr:sendEvent(GameMsgType.RefreshEventMsg)
		elseif k == "generalShopData" then
			LuaLogger.ds("generalShopData", tablex.dump(v))

			Me:updateGeneralShopData(v)
			--ClientData:SetShopInfoData(v)
			GameMsgMgr:sendEvent(GameMsgType.RefresShopDataMsg)
		elseif k == "premiumShopMap" then
			LuaLogger.ds("premiumShopMap", tablex.dump(v))
			Me:updatePremiumShopMap(v)
		elseif k == "payDiamond" then
			Me.payDiamond = v
			LuaLogger.ds("payDiamond", tablex.dump(v))
			GameMsgMgr:sendEvent(GameMsgType.RefreshTopResource)
		elseif k == "dispatchData" then
			LuaLogger.ds("dispatchData", tablex.dump(v))
			ClientData:SetDispatchData(v)
			GameMsgMgr:sendEvent(GameMsgType.DispatchDataUpdate)
			RedPointMgr:Refresh("DispatchBtnRedJudge")
		elseif k == "signData" then
			LuaLogger.ds("signData", tablex.dump(v))
			Me.signData = v
		elseif k == "activityMap" then
			Me.activityMap = v
			GameMsgMgr:sendEvent(GameMsgType.ActivityMapUpdate)
			RedPointMgr:Refresh("ActivityPanelRedPoint")
		elseif k == "extraRewardsMap" then
			Me.extraRewardsMap = v
		elseif k == "funtionOpenMap" then
			Me.funtionOpenMap = v
			GameMsgMgr:sendEvent(GameMsgType.FunctionOpenMapUpdate)
			RedPointMgr:Refresh("QuestionRedJudge")
		elseif k == "weatherForecastData" then
			Me.weatherForecastData = v
		elseif k == "userDefined" then
			ClientData:SetCustomData(v)
		elseif k == "passDataMap" then
			Me.passDataMap = v
		elseif k == "genRoleFragData" then
			ClientData:SetGenRoleFragData(v)
		elseif k == "qnaireMap" then
			Me.qnaireMap = v
			GameMsgMgr:sendEvent(GameMsgType.QnaireMapDataUpdate)
		elseif k == "cycleCardDatas" then
			Me:updateCycleCardData(v)
			GameMsgMgr:sendEvent(GameMsgType.Shop_CycleCardActivityUpdate)
		elseif k == "regularActivityData" then
			Me:updateRegularActivityData(v)
		elseif k == "miniPassMap" then
			Me.miniPassMap = v
		elseif k == "combatIntelligenctInfo" then
			Me:updateCombatIntelligenctInfo(v)
		elseif k == "shareMap" then
			Me.shareMap = v
		end
	end
	-- --统一刷新属性数据
	-- ClientData:InitRoleList()
	

	local roomEditPanel = UIMgr:GetUI("RoomEditPanel")
	if roomEditPanel then
		roomEditPanel:OnNtf()
	end
	local inputPanel = UIMgr:GetUI("InputPanel")
	if inputPanel then
		inputPanel:OnNtf()
	end
end

--设置自定义数据
function ClientData:SetCustomData(data)
	local temp = luautil.unserialize(data)
	--LuaLogger.ds("SetCustomData", tablex.dump(temp))
	Me.userDefined = temp
end

--获取自定义数据
function ClientData:GetCustomData(key)
	--LuaLogger.ds("self._customData", tablex.dump(Me.userDefined))
	return Me.userDefined[key]
end

--商店数据初始化
function ClientData:ShopInfoInit()
	if not Me.shopInfoData.premiumShopData then
		Me.shopInfoData.premiumShopData = {}
	end
	if not Me.shopInfoData.generalShopData then
		Me.shopInfoData.generalShopData = {}
	end
	if not Me.shopInfoData.foreverData then
		Me.shopInfoData.foreverData = {}
	end
end

--设置商店数据
function ClientData:SetShopInfoData(shopInfoData)
	self:ShopInfoInit()
	--氪金商店数据
	if shopInfoData.premiumShopData then
		for id, goodsInfo in pairs(shopInfoData.premiumShopData) do
			Me.shopInfoData.premiumShopData[id] = goodsInfo
		end
	end
	--商品永久购买次数
	if shopInfoData.foreverData then
		for id, times in pairs(shopInfoData.foreverData) do
			Me.shopInfoData.foreverData[id] = times
		end
	end
	--普通商店
	--普通商店商店数据
	if shopInfoData.generalShopData then
		for shopId, detail in pairs(shopInfoData.generalShopData) do
			--商店初始化
			if not Me.shopInfoData.generalShopData[shopId] then
				Me.shopInfoData.generalShopData[shopId] = {}
			end
			--商店到期刷新时间
			if detail.nextRefreshTime then
				Me.shopInfoData.generalShopData[shopId].nextRefreshTime = detail.refreshTime
			end
			--商店已手动刷新次数
			if detail.nextRefreshTime then
				Me.shopInfoData.generalShopData[shopId].refreshNum = detail.refreshNum
			end
			--商店具体商品列表
			if detail.goodsInfoList then
				for goodsId, goodsInfo in pairs(detail.goodsInfoList) do
					if not Me.shopInfoData.generalShopData[shopId].goodsInfoList then
						Me.shopInfoData.generalShopData[shopId].goodsInfoList = {}
					end
					Me.shopInfoData.generalShopData[shopId].goodsInfoList[goodsId] = goodsInfo
				end
			end
		end
	end
	-- GameMsgMgr:sendEvent(GameMsgType.RefreshMainPanle)
	-- GameMsgMgr:sendEvent(GameMsgType.RefreshShopInfoPanel)
end

--获取商店数据
function ClientData:GetShopInfoDataAll()
	return Me.shopInfoData
end

--根据类型获取商店数据
function ClientData:GetShopInfoDataByType(type)
	--todo
end

--获取氪金商店数据
function ClientData:GetPremiumShopData()
	return Me.shopInfoData.premiumShopData
end

--获取付费钻石
--@return {int}	totalNum	付费钻石
function ClientData:GetPayDiamond()
	local payResNum = 0
	local channel = SDKMgr:getChannel()
	LuaLogger.ds("渠道", channel)
	local deviceType = UnityEngine.Application.platform:ToInt()
	local payChannel =  Config.ChannelSetting[channel].pay[deviceType]
	local data
	if payChannel and payChannel.gold then
		data = Me.payDiamond[payChannel.gold]
	end
	if data then
		payResNum = data.num
	end
	local totalNum = payResNum
	return totalNum
end

function ClientData:SetGenRoleFragData(v)
	Me.genRoleFragData = v
	if not Me.genRoleFragData then
		Me.genRoleFragData = {}
		Me.genRoleFragData = v
	else
		if v.availableCount then
			Me.genRoleFragData.availableCount = v.availableCount
		end
		if v.genRoleList then
			Me.genRoleFragData.genRoleList = v.genRoleList
		end
	end
end

--设置派遣数据
function ClientData:SetDispatchData(v)
	local genNewTask = false
	if v.dispatchRandomTaskList and tablex.size(v.dispatchRandomTaskList) > 0 then
		if not Me.dispatchData.dispatchRandomTaskList or tablex.size(Me.dispatchData.dispatchRandomTaskList) == 0 then
			genNewTask = true
		else
			for id, info in pairs(v.dispatchRandomTaskList) do
				if not Me.dispatchData.dispatchRandomTaskList[id] then
					genNewTask = true
					break
				end
			end
		end
	end
	if not Me.dispatchData then
		Me.dispatchData = {}
		Me.dispatchData = v
	else
		if v.dispatchRandomTaskList then
			if not Me.dispatchData.dispatchRandomTaskList then
				Me.dispatchData.dispatchRandomTaskList = {}
			end
			for id, info in pairs(v.dispatchRandomTaskList) do
				if tablex.size(info) == 0 then
					Me.dispatchData.dispatchRandomTaskList[id] = nil
				else
					Me.dispatchData.dispatchRandomTaskList[id] = info
				end
			end
		end
		if v.dispatchTaskList then
			if not Me.dispatchData.dispatchTaskList then
				Me.dispatchData.dispatchTaskList = {}
			end
			for id, info in pairs(v.dispatchTaskList) do
				if tablex.size(info) == 0 then
					Me.dispatchData.dispatchTaskList[id] = nil
				else
					Me.dispatchData.dispatchTaskList[id] = info
				end
			end
		end
		if v.finishRouteList then
			Me.dispatchData.finishRouteList = v.finishRouteList
		end
		if v.rewardRecordList then
			Me.dispatchData.rewardRecordList = v.rewardRecordList
		end
	end
	if genNewTask then
		RedPointMgr:SetRedDotState("RandomDispatchEventRed", true)
	end
	if tablex.size(Me.dispatchData.dispatchRandomTaskList) == 0 then
		--限时派遣到期前都未手动点击触发红点消除，自动消除红点
		RedPointMgr:SetRedDotState("RandomDispatchEventRed", false)
	end
	-- LuaLogger.e("after")
	-- LuaLogger.e(tablex.dump(Me.dispatchData))
end

function ClientData.MailNtf(data)
	LuaLogger.ds("MailNtf", tablex.dump(data.mails))

	if not data.mails then
		return
	end

	if not Me.mails then
		Me.mails = {}
	end

	local newMail, needRedPoint
	for i,v in ipairs(data.mails) do
		if not Me.mails[v.id] then
			newMail = true
			v.state = v.state or MailState.NotRead
			Me.mails[v.id] = v
		else
			if v.state == MailState.Deleted then
				Me.mails[v.id] = nil
			else
				for key, value in pairs(v) do
					Me.mails[v.id][key] = value
				end
			end
		end
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
	if needRedPoint then
		RedPointMgr:SetRedDotState("NewMailRed", true)
	end
	GameMsgMgr:sendEvent(GameMsgType.MailListChange, newMail)
	RedPointMgr:Refresh("MailBtnRedJudge")
end


---通知自身好友数据
---@param data SelfFriendDataNTF
function ClientData.SelfFriendDataNTF(data)
	ClientData.UpdateTable(data.friendPointGive, Me.friendPointGive)
	ClientData.UpdateTable(data.friendPointGet, Me.friendPointGet)

	GameMsgMgr:sendEvent(GameMsgType.FriendPointChange)
end

---@param data FriendInfoNTF
function ClientData.FriendInfoNTF(data)
	LuaLogger.ds("FriendInfoNTF type:" .. data.operate)
	if data == nil then
		return
	end
	local operate = data.operate
 	---1好友列表、2请求列表、3搜索好友、4推荐好友
	local friendList = data.friendList
	---@type table<integer, FriendInfo>?
	local sourceTab = nil
	if data.operate == GE.OperateFriendPush.friendList then
		sourceTab = Me.friends

		--如果是删除的好友 要把申请列表移除
		for k, v in pairs(friendList) do
			if tablex.empty(v) then
				local index = tablex.indexof(Me.selfRequestTab, k)
				if index < 0 then
					table.remove(Me.selfRequestTab, index)
				end
			end
		end
	elseif operate == GE.OperateFriendPush.requestList then

		if friendList[Me.uid] ~= nil then
			LuaLogger.es("好友申请列表出现自己 uid:" .. Me.uid)
		end

		for k, v in pairs(friendList) do
			if v.uid == Me.uid then
				LuaLogger.es("好友申请列表出现自己 k:" .. k .. "  id:" .. Me.uid)
			end
		end

		sourceTab = Me.requestFriends
	elseif operate == GE.OperateFriendPush.searchFriend then
		sourceTab = Me.searchFriends
	elseif operate == GE.OperateFriendPush.suggestFriendList then
		sourceTab = Me.suggestFriends
	end

	if sourceTab == nil then
		return
	end

	ClientData.UpdateTable(friendList, sourceTab)
	GameMsgMgr:sendEvent(GameMsgType.FriendListChange, data.operate, friendList)
end




--根据收藏邮件key列表获取收藏邮件数据
function ClientData:setMailCollectDataByKey(callback)
	self.mailCollectCosData = {}
	local favorKeyData = ClientData:GetFavorMailKeyList() or {}
    local favorKeyCount = tablex.size(favorKeyData)
    if favorKeyCount == 0 then
        if callback then
            callback()
        end
        return
    end
    local checkCount = 0
    for _, urlKey in pairs(favorKeyData) do
        local maintenancefile = urlKey
        SDKMgr:getUserCosLog(maintenancefile, function(success, data)
            if success then
                data.isFavor = true
                table.insert(self.mailCollectCosData, data)
            else
                LuaLogger.es("拉取收藏邮件失败!")
            end
            checkCount = checkCount + 1
            if checkCount == favorKeyCount then
                if callback then
                    callback()
                end
				LuaLogger.ds("拉取收藏邮件完成!", tablex.dump(self.mailCollectCosData))
            end
        end)
    end
end

--前端修改收藏邮件数据
function ClientData:changeMailCollectCosData(id)
	local isCollect = false
	if not self.mailCollectCosData then
		self.mailCollectCosData = {}
	end
	for index, mailData in pairs(self.mailCollectCosData) do
		if mailData.id == id then
			isCollect = true
			table.remove(self.mailCollectCosData, index)
			break
		end
	end
	if not isCollect then
		local mailData = Me.mails[id]
		if mailData then
			mailData.isFavor = true
			table.insert(self.mailCollectCosData, mailData)
		end
	end
	GameMsgMgr:sendEvent(GameMsgType.MailListChange)
end

function ClientData.ErrorReasonNtf(data)
	local str = CommonLogic.GetResInfo(data)
    LuaLogger.e(str)
end

function ClientData.KickNtf(data)
	GameMsgMgr:sendEvent(GameMsgType.Kick, data)
end

function ClientData.None18OvertimeNtf(data)
	GameMsgMgr:sendEvent(GameMsgType.None18Overtime, data)
end

function ClientData.GameVersionNeedUpdateNtf(data)
	GameMsgMgr:sendEvent(GameMsgType.GameVersionNeedUpdate, data)
end

function ClientData.MaintainNtf(data)
	GameMsgMgr:sendEvent(GameMsgType.MaintainNotify, data)
end

function ClientData:SubMsg(name, func)
	GameNetHandler:SendMessage(name, {}, function (data)
		-- LuaLogger.ds("receive submsg", name, tablex.dump(data))
		func(data)
		self:SubMsg(name, func)
	end, -1)
end

function ClientData:SubscribeMessage()
	-- GameNetHandler:RegisterMsgDealer("user.ItemListNotify", ItemListNtf)
	-- GameNetHandler:RegisterMsgDealer("user.SkillListNotify", skillListNtf)
	-- GameNetHandler:RegisterMsgDealer("user.UserInfo", userInfoNtf) -- 拷贝

	for i,v in ipairs(Player.NtfProtos) do
		local pos = v:find(".", 1, true)
		local funcName = v:sub(pos + 1)
		--if funcName == "UserInfoUpdate" then
		if false then
			for i = 1, 3 do
				self:SubMsg(v, ClientData[funcName])
			end
		else
			self:SubMsg(v, ClientData[funcName])
		end

	end

	GameNetHandler:RegisterMsgDealer("user.KickNtf", ClientData.KickNtf)
	GameNetHandler:RegisterMsgDealer("user.ErrorReason", ClientData.ErrorReasonNtf)
	GameNetHandler:RegisterMsgDealer("user.None18OvertimeNtf", ClientData.None18OvertimeNtf)
	GameNetHandler:RegisterMsgDealer("user.GameVersionNeedUpdateNtf", ClientData.GameVersionNeedUpdateNtf)
	--GameNetHandler:RegisterMsgDealer("user.MaintainNtf", ClientData.MaintainNtf)
	GameNetHandler:RegisterMsgDealer("user.MailNtf", ClientData.MailNtf)
	GameNetHandler:RegisterMsgDealer("user.UserInfoUpdate", ClientData.UserInfoUpdate)
	GameNetHandler:RegisterMsgDealer("user.paySuccessNtf", ClientData.paySuccessNtf)
	GameNetHandler:RegisterMsgDealer("user.RewardNTF", ClientData.RewardNTF)
	GameNetHandler:RegisterMsgDealer("user.NoticeNtf", ClientData.NoticeNtf)

	GameNetHandler:RegisterMsgDealer("user.FriendInfoNTF", ClientData.FriendInfoNTF)

	GameNetHandler:RegisterMsgDealer("user.SelfFriendDataNTF", ClientData.SelfFriendDataNTF)

end

function ClientData:OnGameReconnected()
	LuaLogger.ds("ClientData OnGameReconnected()")
	self:ResumSyncServerTime()
end

function ClientData:OnGameDisconnected()
	LuaLogger.ds("ClientData OnGameDisconnected()")
	self:PauseSyncServerTime()
end

function ClientData:ServerTimeCorrect()
	self.startTimer = true
	self:PauseSyncServerTime()

	local ti = DTimer.TimerInfo.New()
	ti.Left = 0
	ti.Interval = GlobalSetting.ServerTimeSync
	ti.MaxRepeatNum = -1
	ti.CombMode = true
	ti.OnComp = function()
		self:SubTimeReq()
	end
	self.serverTimeCorrect = ti
	DTimer.Instance:StartTimer(self.serverTimeCorrect)
end

function ClientData:SubTimeReq()
	local sec = EngineUtil.ServerTime_Seconds()
	GameNetHandler:SendMessage("user.TimeReq",{sec = sec},function(data)
		if data.msec then
			EngineGlobal.SetServerTime(data.msec)
			if Me then
				--serverTime每分钟随心跳函数跟后端同步，需要使用更精确的时间时可使用EngineUtil.ServerTime_Seconds()
				--可获取基于同步serverTime后的当前时间戳
				Me.servertime = EngineUtil.ServerTime_Seconds()
				Me.timeZone = data.timeZone
			end
		else
			LuaLogger.ws("data.msec is nil, maybe waiting to reconnect")
		end
		GameMsgMgr:sendEvent(GameMsgType.RefreshMainPanel)
	end)
end

function ClientData:PauseSyncServerTime()
	if self.serverTimeCorrect then -- 刷新
		self.serverTimeCorrect.OnComp = nil
		DTimer.Instance:RemoveTimer(self.serverTimeCorrect)
	end
	self.serverTimeCorrect = nil
end

function ClientData:ResumSyncServerTime()
	if self.startTimer == true then -- 刷新
		self:ServerTimeCorrect()
	end
end

--根据ID获取喵广场猫猫数据
--CatId {int} 猫id
function ClientData:GetMiaoBuyListByID(CatId)
	for _, value in pairs(Me.miaoBuyData.miaoBuyList) do
		if value.id == CatId then
			return value
		end
	end
	return nil
end

--获取外出信息
function ClientData:GetGoOutInfo()
	return Me.goOutInfo
end

--设置外出信息
function ClientData:SetGoOutInfoNtf(goOutInfo)
	for type, info in pairs(goOutInfo) do
		Me.goOutInfo[type] = info
	end
end

--获取拼图碎片信息
function ClientData:GetPicPieceInfo()
	return Me.picData.picPiece
end

--获取已领取拼图奖励信息
function ClientData:GetPicGetAllInfo()
	return Me.picData.picGetAll
end

--设置拼图碎片信息
function ClientData:SetPicPieceInfoNtf(picPieceInfo)
	Me.picData = picPieceInfo
end

--检查碎片是否存在
function ClientData:IsPicPieceExist(pieceId)
	return tablex.find(Me.picData.picPiece, pieceId)
end

--根据uuid获取玩家身上石头存在该家具组
function ClientData:GetHasFurByUuid(uuid)
	for _, v in pairs(Me.roomInfoMap) do
		for _, Fur in pairs(v.furUuidList) do
			if uuid == Fur then
				return true
			end
		end
	end
	return false
end

--设置抽卡保底数据
function ClientData:RaffleGuaranteeNtf(data)
	for ensureType, value in pairs(data) do
		if not Me.raffleInfoMap[ensureType] then
			Me.raffleInfoMap[ensureType] = {}
			local raffleInfo = {
				ensureType = ensureType,
				isSRNum = value.isSRNum,
				isSSRNum = value.isSSRNum,
				totalNum = value.totalNum
			}
			Me.raffleInfoMap[ensureType] = raffleInfo
		else
			Me.raffleInfoMap[ensureType] = value
		end
	end
end

--获取签到信息
function ClientData:GetSignInInfo()
	return Me.signInInfo
end

--设置签到信息
function ClientData:SetSignInInfoNtf(signInInfo)
	for type, info in pairs(signInInfo) do
		Me.signInInfo[type] = info
	end
end

--获取下次重置时间
function ClientData:GetNextResetTime()
	return Me.nextResetTime
end

--获取上次重置时间
function ClientData:GetLastResetTime()
	-- local refreshTm = ClientData:GetNextResetTime() - 24 * 3600 - tonumber(Config.GetConfigInfo("DailyResetTime")) * 3600
    -- refreshTm = DLuaUtil.GetGreenwichZeroHourTime(nil, refreshTm)
    -- local lastRefreshTime = DLuaUtil.GetNextResetTime(refreshTm, tonumber(Config.GetConfigInfo("DailyResetTime")) * 3600)
	-- return lastRefreshTime
	if (Me.lastResetTime <= 0) then
		Me.lastResetTime = Me.nextResetTime - 24 * 3600
	end
	return Me.lastResetTime
end

--设置上次刷新时间
function ClientData:SetLastResetTime(lastResetTime)
	Me.lastResetTime = lastResetTime
end

--设置下次刷新时间
function ClientData:SetNextResetTime(nextResetTime)
	Me.nextResetTime = nextResetTime
end

--任务推送更新
--@param missionList table 任务列表
--@param isLevelUpgradeToastFirst bool 是否有等级升级界面在先
function ClientData:SetMissionListInfoNtf(missionList, isLevelUpgradeToastFirst)
	local tipsList = {}
	local updateAchieveTask = false
	local updateDateTask = false
	local updateWeekTask = false
	local updateAchieveLevelTask = false
	local localMissionList = Me:getMissionList() or {}
	for key, value in pairs(missionList) do
		local missionId = tonumber(key) or key
		local configData = nil
		if value.type == GE.MissionSystemType.task then
			--获取任务配置信息
			configData = Config.GetTaskTableInfo(value.id)
			if configData then
				if configData.taskType == GE.MissionType.Achieve then
					updateAchieveTask = true
				elseif configData.taskType == GE.MissionType.EveryDay then
					updateDateTask = true
				elseif configData.taskType == GE.MissionType.EveryWeek then
					updateWeekTask = true
				elseif configData.taskType == GE.MissionType.AchieveLevel then
					updateAchieveLevelTask = true
				end
			end
		elseif value.type == GE.MissionSystemType.affection then
			--获取任务配置信息
			configData = Config.GetHomeEventInfo(value.id)
		end
		--LuaLogger.ds("Mission - <color=#FF0000>localMissionList[key]</color>", tablex.dump(localMissionList[key]))
		if localMissionList[missionId] and next(localMissionList[missionId]) then
			if localMissionList[missionId].state ~= value.state then
				if value.state == GE.MissionState.Unclaimed 
				and configData.taskType ~= GE.MissionType.AchieveLevel
				and configData.taskType ~= GE.MissionType.BossTask
				and configData.taskType ~= GE.MissionType.FirstCharge
				and configData.taskType ~= GE.MissionType.HeroExchange
				and configData.taskType ~= GE.MissionType.PortConstruction
				and configData.taskType ~= GE.MissionType.SevenDayTask
				and configData.taskType ~= GE.MissionType.CommanderRank
				and configData.taskType ~= GE.MissionType.HomeLandEvent
				and configData.taskType ~= GE.MissionType.ActivityTask
				and configData.taskType ~= GE.MissionType.Prosperity
				then
					table.insert(tipsList, value)
				end
			end
		end
		localMissionList[missionId] = value
	end
	--红点刷新
	GameMsgMgr:sendEvent(GameMsgType.MissionRefresh)
	RedPointMgr:Refresh("ActivityPanelRedPoint")
	if updateDateTask then
		RedPointMgr:Refresh("TaskPanelDayTaskRedJudge")
	end	
	if updateWeekTask then
		RedPointMgr:Refresh("TaskPanelWeekTaskRedJudge")
	end
	if updateAchieveTask then
		RedPointMgr:Refresh("TaskPanelAchieveTaskRedJudge")
	end
	if updateAchieveLevelTask then
		RedPointMgr:Refresh("TaskPanelAchieveLevelRedJudge")
	end
	LuaLogger.ds("Mission - <color=#FF0000>tipsList</color>",tablex.dump(tipsList))
	local showFunc = function()
		if tipsList and next(tipsList) then
			for k, value in pairs(tipsList) do
				UIMgr:popUI("MissionMsgPanel", {id = value.id})
			end
		end
	end
	--等级升级界面优先于成就界面显示
	if isLevelUpgradeToastFirst then
		self._levelUpBackFunc = showFunc
	else
		showFunc()
	end
	--LuaLogger.ds("Mission - <color=#FF0000>任务推送更新</color>", tablex.dump(Me.missionList))
end

--通过id获取任务信息
function ClientData:GetTaskInfo(id)
	local missionId = tonumber(id) or id
	local missionList = Me:getMissionList() or {}
	return missionList[missionId] or missionList[tostring(missionId)]
end

--获取全部任务信息
function ClientData:GetAllTaskInfo()
	return Me:getMissionList()
end

--通过类型获取任务信息
function ClientData:GeTaskInfoByType(taskType)
	local missionListByType = {}
	local missionList = Me:getMissionList() or {}
	for key, value in pairs(missionList) do
		local configData = Config.GetTaskTableInfo(value.id)
		if configData.taskType == taskType then
			table.insert(missionListByType, value)
		end
	end
	return missionListByType
end

--获取新手签到信息
function ClientData:GetNewbieSignInInfo()
	return Me.newbieSignInInfo
end

--设置新手签到信息
function ClientData:SetNewbieSignInInfoNtf(newbieSignInInfo)
	for type, info in pairs(newbieSignInInfo) do
		Me.newbieSignInInfo[type] = info
	end
end

--获取用户数据信息
function ClientData:GetUserDataInfo()
	return Me.userData
end

--设置用户数据信息
function ClientData:SetUserDataInfoNtf(userDataInfo)
	for type, info in pairs(userDataInfo) do
		Me.userData[type] = info
	end
end

--获取活动信息
function ClientData:GetActivityInfo(activityId)
	--print("GetActivityInfo",activityId,tablex.dump(Me.activityInfo))
	return Me.activityInfo[activityId]
end

--设置活动信息
function ClientData:SetActivityInfoNtf(activityInfo)
	print("SetActivityInfoNtf",tablex.dump(activityInfo))
	for type, info in pairs(activityInfo) do
		Me.activityInfo[type] = info
	end
end

--设置家具皮肤信息
function ClientData:SetFurSkinMap(furSkinMap)
	if type(furSkinMap) ~= "table" then
		return
	end
	Me.furSkinMap = Me.furSkinMap or {}
	for furId, skinId in pairs(furSkinMap) do
		if skinId > 0 then
			Me.furSkinMap[furId] = skinId
		else
			Me.furSkinMap[furId] = nil
		end
	end
end

--获取家具皮肤信息
function ClientData:GetFurSkinMap()
	return Me.furSkinMap
end

--设置皮肤数据
function ClientData:SetSkinListData(SkinList)
	Me.skinList = SkinList
end

--获取皮肤数据
function ClientData:GetSkinListData()
	return Me.skinList or {}
end

--根据角色ID获取皮肤列表
function ClientData:getSkinDataByRoleId(roleId)
	local skinList = self:GetSkinListData()
	local roleSkinList = Config.GetCharacterSkinInfoByCharacterID(roleId)
	local temp = {}
	for _, v in pairs(roleSkinList) do
		if skinList[v.id] then
			table.insert(temp, skinList[v.id])
		end
	end
	return temp
end

--获取头像列表
function ClientData:GetHeadList()
	return Me.headList
end

--设置是否播放过spine的into动画
function ClientData:SetIsPlaySpineIntoAni(isPlay)
	self.isPlaySpineInto = isPlay
end

--获取是否播放过spine的into动画
function ClientData:GetIsPlaySpineIntoAni()
	return self.isPlaySpineInto
end

--数数日志公共事件属性记录
function ClientData:RecordSuperProperties()
	local info = {}
	ClientData:SetPresetProperties(info)
	-- Me:RecordSuperPropertiesReq(info)
	GameNetHandler:SendWaitMessage("user.RecordSuperPropertiesReq", {info = info}, function(data)
		print("RecordSuperPropertiesResp")
	end)
end

--支付成功ntf
function ClientData.paySuccessNtf(data)
	LuaLogger.ds("paySuccessNtf", tablex.dump(data))
	-- --周卡特殊处理
	-- if data.item == 5002 then
	-- 	UICommonUtils.PopToast(LocalStrEnum.TipBuySuccess)
	-- 	return
	-- end
	PayMgr:paySuccess(data)
end

--通用奖励推送
function ClientData.RewardNTF(data)
	LuaLogger.ds("通用奖励推送!!!!!!!!!!", tablex.dump(data))
	if data.rewardList then
		Me:ReceiveReward(data.rewardList)
	end
end

--------------------公告--------------------
function ClientData:GetAllNoticeData()
	return self.NoticeData.data
end

function ClientData:SetAllNoticeData(data)
	self.NoticeData = data
end

--根据id获取具体公告内容
function ClientData:GetNoticeInfoById(id)
	for k, v in pairs(self.NoticeData) do
		if v.id == id then
			return v
		end
	end
end

function ClientData:NoticeDataReq(callback)
	local url
	local keyStore = {}
	local path
	local channelStr
	local channel = SDKMgr:getChannel()
	LuaLogger.ds("NoticeDataReq渠道", channel)
	if GV.IsEditor then
		url = "http://192.168.1.137:9001/api/bfg/getNotices"
		keyStore = {
			key = "bV2mX3wJ7xF6cM9oQ7nF6xK9jM4mW9qG",
			secret = "tF0fF9bB9yZ4mY6lH7aN5mM2aS0qE4jC"
		}
		path = "/api/bfg/getNotices"
		channelStr = tostring(channel)
	else
		url = "https://notice-review.moecove.com/api/bfg/getNotices"
		keyStore = {
			key = "bV2mX3wJ7xF6cM9oQ7nF6xK9jM4mW9qG",
			secret = "tF0fF9bB9yZ4mY6lH7aN5mM2aS0qE4jC"
		}
		path = "/api/bfg/getNotices"
		channelStr = tostring(channel)
	end

	local signature = HttpCrypt:generateSignature("GET", path, nil, keyStore.secret, channelStr)
	--LuaLogger.ds("signature", signature)
	local dict = {}
	table.insert(dict, "X-API-Key")
	table.insert(dict, keyStore.key)
	table.insert(dict, "X-Signature")
	table.insert(dict, signature)
	table.insert(dict, "X-Channel")
	table.insert(dict, channelStr)
	local reqbody = ""
	local loaderTime = 1
	local timeout = 20000 --20秒超时时间，由于第三方身份证验证可能比较慢，之前5秒不够
	print("NoticeDataReq reqbody:",reqbody)
	HttpUtil.HttpGetInLua(url, timeout, dict, function(respcode, responseJson)
		LuaLogger.ds("NoticeDataReq响应", respcode, responseJson)
		local success = respcode == 200
		local response
		if responseJson and success then
			response = cjson.decode(responseJson)
			LuaLogger.ds("NoticeDataReq公告数据", tablex.dump(response))
			if response.code ~= 0 then
				UICommonUtils.PopToast(response.message)
			else
				if type(response.data) == "table" then
					self:SetAllNoticeData(response.data)
					GameMsgMgr:sendEvent(GameMsgType.NoticeRefresh)
					RedPointMgr:Refresh("NoticeRedJudge")
					--维护状态判断
					self._maintainance = false
					for k, v in pairs(response.data.data) do
						--3为维护公告
						if v.type == 3 then
							LuaLogger.ds("NoticeDataReq维护公告", v.title)
							--时间边界判断
							local isValid = true
							if v.start_time and v.start_time ~= "" then
								local startTime = DLuaUtil.ParseConfigTimeClient(v.start_time)
								if startTime > os.time() then
									isValid = false
									LuaLogger.ds("NoticeDataReq维护公告未开始")
								end
							end
							if v.end_time and v.end_time ~= "" then
								local endTime = DLuaUtil.ParseConfigTimeClient(v.end_time)
								-- LuaLogger.ds("NoticeDataReq维护公告结束时间", endTime)
								-- LuaLogger.ds("NoticeDataReq维护公告当前时间", os.time())
								if endTime < os.time() then
									isValid = false
									LuaLogger.ds("NoticeDataReq维护公告已结束")
								end
							end
							if isValid then
								self._maintainance = true
								break
							end
						end
					end
				end
				self._whiteList = response.data.whitelist or {}
				-- self._whiteList = {}
			end
		end
		if callback then
			callback()
		end
	end)

	-- self.NoticeData = {
	-- 	{
	-- 		id = 1,
	-- 		type = 1,  
	-- 		title = "测试系统公告",
	-- 		start_time = "2025-5-30 00:00:00",
	-- 		end_time = nil,
	-- 		web_url = "https://mby.moefantasy.com/privacy.html",
	-- 	},
	-- 	{
	-- 		id = 2,
	-- 		type = 1,  
	-- 		title = "测试系统公告2",
	-- 		start_time = "2025-5-30 00:00:00",
	-- 		end_time = "2025-10-26 00:00:00",
	-- 		web_url = "https://beian.miit.gov.cn/",
	-- 	},
	-- }

	--刷新公告
	function ClientData.NoticeNtf()
		self:NoticeDataReq()
	end
end

--- 获取是否为维护状态
function ClientData:IsMaintaning()
	return self._maintainance
end

--- 获取公告白名单
function ClientData:GetWhiteList()
	return self._whiteList
end

--------------------------------------------
function ClientData:SetPresetProperties(data)
	local props = ThinkingAnalytics:getPresetProperties()
	local locationInfo = ThinkingAnalytics:getLocationInfo()
	data.zone_offset = props.ZoneOffset
	data.screen_height = props.ScreenHeight
	data.screen_width = props.ScreenWidth
	if locationInfo then
		data.country_code = locationInfo.countryCode
		data.ip = locationInfo.ip
		data.province = locationInfo.province
		data.country = locationInfo.country
		data.city = locationInfo.city
	end
	data.lib_version = "3.0.0"
	data.os = props.OS
	data.device_id = props.DeviceId
	data.bundle_id = props.BundleId
	data.device_model = props.DeviceModel
	data.system_language = props.SystemLanguage
	data.network_type = props.NetworkType
	data.lib = "Unity"
	data.os_version = props.OSVersion
	data.app_version = props.AppVersion
	data.simulator = props.Simulator
	data.install_time = tonumber(props.InstallTime)
	data.distinct_id = UnityEngine.PlayerPrefs.GetString("DistinctId")
	LuaLogger.ds("PresetProperties", tablex.dump(data))
end

--前端日志协议通用接口
function ClientData:sendDailyLogMessage(data, callback)
	LuaLogger.ds("sendDailyLogMessage data:", tablex.dump(data))
	--埋点开关
	if not GV.GlobalConfig.WriteShuShuLog then
		return
	end
	if (data.event_type and data.event_type == 2) then
		if (UnityEngine.PlayerPrefs.HasKey("GameStageSendTime")) then
			local lastSendTime = UnityEngine.PlayerPrefs.GetInt("GameStageSendTime")
			local zeroTimestamp = DLuaUtil.GetCurrZeroHourTime()
            if (lastSendTime >= zeroTimestamp) then
                return
			end
        end
	end
	
	local cjson = require "cjson"
	local url = string.format("%s/9/log/data", SDKMgr.datalogip)
	LuaLogger.ds("sendDailyLogMessage url:", url)
	if url then
		if Me then
			data.user_aid = Me.aid
			data.user_uid = Me.uid
			data.user_name = Me.name
		end
		-- ClientData:SetPresetProperties(data)
		-- print("sendDailyLogMessage data",tablex.dump(data))

		local reqbody = cjson.encode(data)

		local dict = {}
		local loaderTime = 1
		local timeout = 20000 --20秒超时时间，由于第三方身份证验证可能比较慢，之前5秒不够
		LuaLogger.ds("sendDailyLogMessage reqbody:",reqbody)
		HttpUtil.HttpRequest(url, reqbody, timeout, dict, function(respcode, responseJson)
			LuaLogger.ds(respcode, responseJson)
			local success = respcode == 200
			local response
			if responseJson and success then
				response = cjson.decode(responseJson)
				if response.error then
					success = false
				end
			elseif respcode == 404 then
				response = {error = GE.PassportErrorCode.ServerConnectFailed}
			else
				response = {error = GE.PassportErrorCode.ResponseError}
			end

			if callback then
				callback(success, response)
			end
		end)
	end
end

--前端登陆前日志协议接口
function ClientData:sendGameOpenLogMessage(stageName)
	local sendData = {
        event_type = 2,
        stage_name = stageName,
        distinct_id = SDKMgr:getDistinctId(),
        device = NativeInfoLua.GetDeviceID(),
        device_info = NativeInfoLua.GetDeviceDetail(),
        channel = UpdateManager.Instance.Code5,
    }
    self:sendDailyLogMessage(sendData)
end

--前端引导日志协议接口
function ClientData:sendGuideLogMessage(groupId, guideId, stepId)
	local sendData = {
		event_type = 33,
		group_id = groupId,
		guide_id = guideId,
		guide_step_id = stepId,
		distinct_id = SDKMgr:getDistinctId(),
		login_channel  = SDKMgr:getChannel(),
	}
	self:sendDailyLogMessage(sendData)
end

--前端AVG剧情内容日志协议接口
function ClientData:sendAvgLogMessage(needData)
	local sendData = needData
	sendData.distinct_id = SDKMgr:getDistinctId()
	sendData.login_channel  = SDKMgr:getChannel()
	self:sendDailyLogMessage(sendData)
end

--设置主界面侧边栏
function ClientData:SetListDown(bool)
	self.listDown = bool
end

--获取主界面侧边栏
function ClientData:GetListDown()
	return self.listDown
end

--设置返回主界面要执行的逻辑
-- function ClientData:SetIsMapBack(func)
-- 	self.backMainFunc = func
-- end

-- --获取是否从地图返回
-- function ClientData:GetIsMapBack()
-- 	return self.backMainFunc
-- end

---@param jump boolean 是否跳过开场剧情
function ClientData:SetJumpOpenStory(jump)
	self.jumpOpenStory = jump
end

---@return boolean 是否跳过开场剧情
function ClientData:GetJumpOpenStory()
	local r = self.jumpOpenStory
	return r
end

function ClientData.UpdateTable(updateTab, sourceTab)
	if updateTab == nil then
		return
	end
	for k, v in pairs(updateTab) do
		if type(v) == "table" then
			if tablex.next(v) == nil then
				sourceTab[k] = nil
			else
				if sourceTab[k] == nil then
					sourceTab[k] = v
				else
					ClientData.UpdateTable(v, sourceTab[k])
				end
			end
		else
			sourceTab[k] = v
		end
	end
end


return ClientData