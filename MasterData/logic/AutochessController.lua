-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/controller/AutochessController.lua

module("logic.extensions.autochess.controller.AutochessController", package.seeall)

local AutochessController = class("AutochessController", BaseController)

AutochessController.PetUp = "AutochessController.PetUp"
AutochessController.MaxStarNum = 5

function AutochessController:ctor()
	return
end

function AutochessController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.BattleEnd, self._onBattleEnd, self)
	self:onReset()
end

function AutochessController:onReset()
	self._sellRaceId = nil
end

function AutochessController:_onBattleEnd()
	self._isInResultView = false
end

function AutochessController:startMatch(activityId)
	self:onReset()
	AutochessModel.instance:clearLastRank()
	AutoChessAgent.instance:sendPM_ACStartMatchReq(activityId)
end

function AutochessController:matchRes()
	UIStateManager.instance:push(ViewName.AutochessmatchView)
end

function AutochessController:matchFailed()
	FloatWordMgr.instance:show("匹配失败")
	UIStateManager.instance:popByName(ViewName.AutochessmatchView)
end

function AutochessController:notifyGameStartRes(msg)
	AutochessModel.instance:resetDataOnGameStart()

	self._gameEndMsg = nil
	self._isInResultView = false

	AutochessModel.instance:setSelectBuffIds(msg.selectBuffIds)
	AutochessModel.instance:setPlayers(msg.players)
	AutochessModel.instance:setEnemyRoundInfo(msg.enemyRoundInfo)
	UIStateManager.instance:push(ViewName.AutochessselectteamView)
	UIStateManager.instance:popByName(ViewName.AutochessmatchView)
end

function AutochessController:selectInitBuffFinish()
	AutochessModel.instance:setInitBuffId(self._initBuffId)
	UIStateManager.instance:push(ViewName.AutochessmissionView)
end

function AutochessController:isOpenTime(activityId)
	local actCfg = AutochessConfig.instance:getActCfg(activityId)

	if not actCfg then
		return false
	end

	local v = actCfg

	if string.nilorempty(v.openTime) then
		return true
	end

	local timeArr = string.split(v.openTime, ",")

	for i, time in ipairs(timeArr) do
		local arr = string.split(time, "#")
		local sStr = arr[1]
		local eStr = arr[2]

		if GameUtil.checkIsInTimePeriod(sStr, eStr, true) then
			return true
		end
	end
end

function AutochessController:getAttrIconIndex(raceId)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(raceId)

	race = race % 10

	return race - 1
end

function AutochessController:notifyNextRoundRes(msg)
	AutochessModel.instance:saveLastRank()
	AutochessModel.instance:setDecHp(-1)

	local fmt = AutochessModel.instance:getCurrFormation()
	local isEmptyFmt = fmt:isEmpty()
	local roundType = msg.roundType

	AutochessModel.instance:setRoundId(msg.roundId)
	AutochessModel.instance:setPlayers(msg.players)
	AutochessModel.instance:setIsBuffRound(roundType == 2)
	AutochessModel.instance:resetRoundRefreshTimes()

	local battleResult

	if msg:HasField("battleResult") then
		battleResult = msg.battleResult

		if msg.battleResult.decHp and battleResult.decHp > 0 then
			AutochessModel.instance:setDecHp(battleResult.decHp)
		end
	end

	if battleResult then
		if isEmptyFmt then
			UIStateManager.instance:push(ViewName.AutochessbattlerfailedView)
			FloatWordMgr.instance:show("布阵为空 挑战失败")
		else
			BattleFacade.instance:startAutoChess()
			BattleController.instance:viewUserFightMonsterBtlResult(battleResult.battleResult)

			if roundType == 2 then
				UIJumper.instance:pushOneStack(ViewName.AutochessselectbuffView)
			end
		end
	end

	if roundType == 1 then
		UIStateManager.instance:popByName(ViewName.AutochessselectbuffView)
		AutochessModel.instance:setEnemyRoundInfo(msg.enemyRoundInfo)
	elseif roundType == 2 then
		AutochessModel.instance:setBuffRoundInfo(msg.buffRoundInfo)
		UIStateManager.instance:push(ViewName.AutochessselectbuffView)
	else
		UIStateManager.instance:popByName(ViewName.AutochessselectbuffView)
	end

	if not battleResult then
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
	end
end

function AutochessController:notifyGameEndRes(msg)
	UIStateManager.instance:popByName(ViewName.AutochessselectbuffView)
	UIJumper.instance:removeTopState(ViewName.AutochessselectbuffView)

	local state = msg.state

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

	self._gameEndChangeSetId = msg.changeSetId
	self._gameEndMsg = msg

	AutochessModel.instance:setGameEndMsg(msg)

	if not SceneMgr.instance.isGogingToEnterBattleScene then
		UIStateManager.instance:popByName(ViewName.AutochessselectbuffView)
		UIStateManager.instance:popByName(ViewName.AutochessselectfullstarbuffView)
		UIStateManager.instance:popByName(ViewName.AutochessselectteamView)
		UIStateManager.instance:popByName(ViewName.AutochessmissionView)

		if state < 0 then
			UIStateManager.instance:push(ViewName.AutochessmainView)
			FloatWordMgr.instance:show("异常退出")

			return
		end

		self:enterResultView()
	elseif self._isInResultView then
		self:enterResultView()
	end
end

function AutochessController:getGameEndChangesetId()
	return self._gameEndChangeSetId
end

function AutochessController:hasGameEndMsg()
	return self._gameEndMsg
end

function AutochessController:enterResultView()
	self._isInResultView = true

	if self._gameEndMsg then
		UIJumper.instance:removeTopState(ViewName.AutochessmissionView)
		UIStateManager.instance:popByName(ViewName.AutochessmissionView)

		if SceneMgr.instance.isGogingToEnterBattleScene then
			UIJumper.instance:pushOneStack(ViewName.AutochessmainView)
			UIStateManager.instance:push(ViewName.AutochessbattleresultView)
		else
			UIStateManager.instance:push(ViewName.AutochessmainView)

			if self._gameEndMsg.state >= 0 then
				UIStateManager.instance:push(ViewName.AutochessrankresultView)
			end
		end
	else
		if SceneMgr.instance.isGogingToEnterBattleScene then
			UIJumper.instance:pushOneStack(ViewName.AutochessmissionView)
		else
			UIStateManager.instance:push(ViewName.AutochessmissionView)
		end

		UIStateManager.instance:push(ViewName.AutochessbattleresultView)
	end
end

function AutochessController:_formNumCheck()
	local roundId = AutochessModel.instance:getRoundId()
	local formationNum = AutochessConfig.instance:getRoundFormationNum(roundId)
	local formation = AutochessModel.instance:getCurrFormation()
	local nums = formation:getCurExistPetNumber()

	return nums < formationNum
end

function AutochessController:sendPM_ACSellPetReq(raceId, star)
	self._sellRaceId = raceId

	AutoChessAgent.instance:sendPM_ACSellPetReq(raceId, star)
end

function AutochessController:notifyAfterPetChangedRes(msg)
	local buyRaceId = 0

	if self._isBuyOp then
		buyRaceId = self._buyRaceId
	end

	AutochessModel.instance:notifyAfterPetChangedRes(msg, self._sellRaceId, buyRaceId)

	self._sellRaceId = nil

	local isDirty1 = self:_autoChangeFmt()
	local isDirty2 = self:_autoPushPetToFmt()

	if buyRaceId > 0 then
		GlobalDispatcher:dispatch(AutochessController.PetUp, buyRaceId)
	end
end

function AutochessController:sendPM_ACBuyPetReq(index, raceId)
	self._isBuyOp = true
	self._buyRaceId = raceId

	AutoChessAgent.instance:sendPM_ACBuyPetReq(index, raceId)
end

function AutochessController:_autoChangeFmt()
	local getPetInfoList = AutochessModel.instance:getPetInfoList()
	local fmt = AutochessModel.instance:getCurrFormation()
	local position = fmt:GetPositions()
	local petInfos = AutochessModel.instance:getPetInfoList()
	local isDirty = false

	for pos, petId in ipairs(position) do
		if petId > 0 then
			local petMo = AutochessModel.instance:getPet(petId)
			local star = petInfos[petMo.raceId]

			if petMo.raceId == self._buyRaceId then
				self._buyRaceId = nil
			end

			if not star then
				printInfo("testautoche:重置位置 ", pos)
				fmt:SetPosition(pos, 0)

				isDirty = true
			else
				local cfg = AutochessConfig.instance:getCreepsCfgByStarLevel(petMo.raceId, star)

				if cfg.creepsId ~= petMo.petId then
					printInfo("testautoche:替换位置 ", pos, petMo.raceId, star)
					fmt:SetPosition(pos, cfg.creepsId)

					isDirty = true
				end
			end
		end
	end

	return isDirty
end

function AutochessController:_autoPushPetToFmt()
	local isDirty = false

	if not self._isBuyOp then
		return
	end

	self._isBuyOp = false

	if not self._buyRaceId then
		return
	end

	local isOk = self:_formNumCheck()

	if not isOk then
		return
	end

	local petInfos = AutochessModel.instance:getPetInfoList()
	local star = petInfos[self._buyRaceId]

	if not star then
		return
	end

	local cfg = AutochessConfig.instance:getCreepsCfgByStarLevel(self._buyRaceId, star)
	local fmt = AutochessModel.instance:getCurrFormation()
	local position = fmt:GetPositions()

	for i, v in ipairs(position) do
		if v <= 0 then
			isDirty = true

			printInfo("testautoche:自动上阵位置 ", i, self._buyRaceId, star)
			fmt:SetPosition(i, cfg.creepsId)

			break
		end
	end

	return isDirty
end

function AutochessController:sendPM_ACSelectInitBuffReq(buffId)
	self._initBuffId = buffId

	AutoChessAgent.instance:sendPM_ACSelectInitBuffReq(buffId)
end

function AutochessController:sendPM_ACSelectBuffReq(buffId)
	self._selectEquipBuffId = buffId

	AutoChessAgent.instance:sendPM_ACSelectBuffReq(buffId)
end

function AutochessController:onHandleSelectEquipBuff()
	if self._selectEquipBuffId then
		AutochessModel.instance:insertEquipBuffId(self._selectEquipBuffId)

		self._selectEquipBuffId = nil
	end
end

function AutochessController:sendPM_ACSelectFullStarBuffReq(buffId)
	self._selectEquipBuffId = buffId

	AutoChessAgent.instance:sendPM_ACSelectFullStarBuffReq(buffId)
end

function AutochessController:getOpenTimeDesc(activityId)
	local v = AutochessConfig.instance:getActCfg(activityId)
	local list = {}
	local timeArr = string.split(v.openTime, ",")

	for i, time in ipairs(timeArr) do
		local arr = string.split(time, "#")
		local sStr = arr[1]
		local eStr = arr[2]
		local sArr = string.split(sStr, ":")
		local eArr = string.split(eStr, ":")

		list[i] = string.format("%s:%s-%s:%s", sArr[1], sArr[2], eArr[1], eArr[2])
	end

	return table.concat(list, " ")
end

function AutochessController:getFetterDatas(creepIds)
	local fettersId2num = {}

	for i, petId in ipairs(creepIds) do
		local creepsCfg = AutochessConfig.instance:getCreepsCfg(petId)
		local fettersId = AutochessConfig.instance:getPetFettersId(creepsCfg.raceId)

		if fettersId > 0 and not fettersId2num[fettersId] then
			fettersId2num[fettersId] = {
				num = 0,
				numDesc = "",
				fettersId = fettersId
			}

			local tempcfgs = AutochessConfig.instance:getFettersBuffCfgs(fettersId)
			local cfgs = table.values(tempcfgs)

			table.sort(cfgs, function(a, b)
				return a.num < b.num
			end)

			local t = {}

			for j, cfg in ipairs(cfgs) do
				t[j] = cfg.num
			end

			fettersId2num[fettersId].numDesc = table.concat(t, "/")
		end

		if fettersId > 0 then
			fettersId2num[fettersId].num = fettersId2num[fettersId].num + 1
		end
	end

	local fetters = table.values(fettersId2num)

	table.sort(fetters, function(a, b)
		return a.fettersId < b.fettersId
	end)

	return fetters
end

function AutochessController:notifyInitBuffInfoChangedRes(msg)
	local initBuffCfg = AutochessConfig.instance:getInitBuffCfg(msg.buffId)

	if initBuffCfg.type == "ExtraEquipBuff" then
		local t = GameUtil.jsonToTable(msg.param)

		AutochessModel.instance:insertEquipBuffId(t.equipBuffId)
		FloatWordMgr.instance:show("获得一件神装")
		AutochessModel.instance:setShowBtnEquipEffect(true)
	end
end

AutochessController.instance = AutochessController.New()

return AutochessController
