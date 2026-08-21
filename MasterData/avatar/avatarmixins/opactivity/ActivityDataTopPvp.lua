-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataTopPvp.lua

local PVPCommon = require("Logic/PVP/PVPCommon")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResBPPvpTimer = require("ClientData/ResBPPvpTimer")
local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")
local ResBPPvpShow = require("ClientData/ResBPPvpShow")
local ResBPPvpRoomTimer = require("ClientData/ResBPPvpRoomTimer")
local ResBPPvpBPRound = require("ClientData/ResBPPvpBPRound")
local ResBPPvpHeroAutoBanRule = require("ClientData/ResBPPvpHeroAutoBanRule")
local ResBPPvpMarqueeControl = require("ClientData/ResBPPvpMarqueeControl")
local ActivityDataTopPvp = Class("ActivityDataTopPvp", ActivityDataBase)

function ActivityDataTopPvp:ctor()
	self.roomId = nil

	self:initData()
	self:initStateMap()
end

function ActivityDataTopPvp:initData()
	self.opTopPvpNextGetGroupMatchReportTime = 0
	self.opTopPvpNextGetKnockoutReportTime = 0
	self.record = {}
	self.myKnockoutFormations = {}
	self.firstShowBetRoom = {}
end

function ActivityDataTopPvp:initStateMap()
	self.stateMap = {
		"GroupFormationReady",
		"GroupFormation",
		"GroupFight",
		"GroupSettleReady",
		"GroupSettle",
		"KnockoutRoomPoolPrepare",
		"KnockoutRoomPrepare",
		"KnockoutBPPoolSync",
		"KnockoutRoomChoose",
		"KnockoutRoomFight",
		"KnockoutRoomSettle",
		"KnockoutRoomShow"
	}
	self.reStateMap = {
		GroupSettleReady = 4,
		KnockoutRoomChoose = 9,
		KnockoutRoomFight = 10,
		GroupFormation = 2,
		KnockoutRoomPoolPrepare = 6,
		KnockoutBPPoolSync = 8,
		KnockoutRoomSettle = 11,
		GroupFight = 3,
		GroupSettle = 5,
		KnockoutRoomPrepare = 7,
		GroupFormationReady = 1,
		KnockoutRoomShow = 12
	}
	self.knockoutStateMap = {}
	self.knockoutStateMap[101] = "BP"
	self.knockoutStateMap[102] = "BPShow"
	self.knockoutStateMap[103] = "Formation"
	self.knockoutStateMap[104] = "FightPrepare"
	self.knockoutStateMap[105] = "FightReq"
	self.knockoutStateMap[106] = "CountDown"
	self.knockoutStateMap[107] = "Fight"
	self.reKnockoutMap = {
		BP = 101,
		FightReq = 105,
		Formation = 103,
		BPShow = 102,
		Fight = 107,
		CountDown = 106,
		FightPrepare = 104
	}
end

function ActivityDataTopPvp:updateClientData(actId)
	self.actId = actId
end

function ActivityDataTopPvp:updateMgrData(opActivityMgrItem, crossData)
	self.topPvpMgrData = opActivityMgrItem
	self.endTime = self.topPvpMgrData.time.closetime
	self.openTime = self.topPvpMgrData.time.opentime
	self.crossData = crossData

	if self.crossData then
		self.topPvpData = crossData.specdata.bp_pvp

		if self.topPvpData.state and self.topPvpData.state.timer_id then
			self.state = self.topPvpData.state
		end

		if self.topPvpData.bet_info then
			-- block empty
		end
	end

	if self:checkTopPvpCrossdata() then
		self:setMarqueeTimer()

		local ui = UIManager.tryGetUI("activityGatherMainDlg")

		if ui then
			ui:onRefresh()
		end

		self:refreshUI()
		self:checkGathetBtnRedDot()
	end
end

function ActivityDataTopPvp:checkTopPvpCrossdata(...)
	if self.state and self.state.timer_id and self.state.timer_id > 1 then
		return true
	end

	return false
end

function ActivityDataTopPvp:onStateChange(opActState)
	self.opactState = opActState

	if opActState == Const.OPACT_STATE_CLOSE then
		self.onStateClose()
	end
end

function ActivityDataTopPvp:onStateClose()
	local isNeedTips = false
	local uis = {
		"topPvpMainDlg"
	}

	for _, name in ipairs(uis) do
		local ui = UIManager.tryGetUI(name)

		if ui and ui:getVisible() then
			isNeedTips = true

			break
		end
	end

	local function yesFunc(...)
		for _, name in ipairs(uis) do
			local ui = UIManager.getUI(name, nil, false)

			if ui then
				ui:setVisible(false)
			end
		end

		local ui = UIManager.tryGetUI("activityGatherMainDlg")

		if ui then
			ui:onBtnsRefresh()
		end
	end

	if isNeedTips then
		local msgContent = ClientUtils.getClientNotice(714)

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", msgContent, yesFunc, nil, nil)
	end
end

function ActivityDataTopPvp:getRemainOpenTime(...)
	return self.endTime - ClientUtils.getServerTime()
end

function ActivityDataTopPvp:getCurStageRemainTime(...)
	local lastedTime = ClientUtils.getServerTime() - self.state.start_time
	local openTime = self.openTime
	local endTime = ResBPPvpTimer[self.state.timer_id].end_time or 0
	local leastTime = ResBPPvpTimer[self.state.timer_id].least_time or 0

	if openTime and endTime then
		local lastTime = openTime + endTime - ClientUtils.getServerTime()

		if leastTime < lastTime + lastedTime then
			return lastTime
		else
			return leastTime - lastedTime
		end
	end
end

function ActivityDataTopPvp:getTopPvpStage()
	if self.state and self.state.timer_id and ResBPPvpTimer[self.state.timer_id] then
		return ResBPPvpTimer[self.state.timer_id].state
	end
end

function ActivityDataTopPvp:getTopPvpTimerId()
	return self.state.timer_id
end

function ActivityDataTopPvp:getTopPvpCurStageStartTime()
	return self.state.startTime
end

function ActivityDataTopPvp:updateRoleData(roledata)
	self.roledata = roledata.bppvp
	self.groupId = self.roledata.group_id
	self.challenge = self.roledata.challenge
	self.bet = self.roledata.bet
	self.bppoolSign = self.roledata.bppool_sign

	if self.roledata.knockout_id then
		if not self.myKnockoutRoomId then
			self.myKnockoutRoomId = self.roledata.knockout_id
		elseif self.roledata.knockout_id and self.myKnockoutRoomId < self.roledata.knockout_id then
			self.myKnockoutRoomId = self.roledata.knockout_id
		end
	end

	if self.roledata.ban_rule then
		self.banRule = self.roledata.ban_rule

		self:updateBpBanRule()
	end

	if self.roledata.cur_bet_room then
		self:updateBetRoomId(self.roledata.cur_bet_room)
	end

	if self.roledata.bppool then
		self:updateBpHeros(self.roledata.bppool)
	end

	self:refreshUI()
	self:checkGetSnapShotFormation()
end

function ActivityDataTopPvp:setMarqueeShow(id)
	if GameFsm.isInState(Const.STATE_LOGIN) then
		return
	end

	local actData = CurAvatar:getTopPVPActivityData()

	if not actData then
		return
	end

	if id == 0 then
		return
	end

	local notShowMarqueeUIs = {
		topPvpMainDlg = true,
		topPvpWaitDlg = true,
		topPvpKnockoutDragHeroDlg = true,
		topPvpBpMainDlg = true,
		battleStartTopPvpDlg = true
	}

	if GameFsm.isInState(Const.STATE_BATTLE) or GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
		local state = GameFsm.getCurState()

		if state.battleType ~= BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT and state.battleType ~= BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH then
			for uiname, v in pairs(notShowMarqueeUIs) do
				local ui = UIManager.tryGetUI(uiname)

				if ui and ui:getVisible() then
					return
				end
			end

			UIManager.getUI("noticeLampDlg", true):show(id)
		end
	else
		for uiname, v in pairs(notShowMarqueeUIs) do
			local ui = UIManager.tryGetUI(uiname)

			if ui and ui:getVisible() then
				return
			end
		end

		UIManager.getUI("noticeLampDlg", true):show(id)
	end
end

function ActivityDataTopPvp:marqueeShowFunc()
	local constType = {
		spectator = 2,
		player = 1
	}
	local actData = CurAvatar:getTopPVPActivityData()

	if not actData then
		return
	end

	local nowState = actData:getTopPvpStage()

	for i = 1, #ResBPPvpMarqueeControl do
		local resData = ResBPPvpMarqueeControl[i]
		local roundFlag = false

		if resData.round == nowState then
			roundFlag = true
		end

		if roundFlag == true then
			local inGroupMatch = false

			if nowState <= actData.reStateMap.GroupSettle then
				inGroupMatch = true
			end

			if inGroupMatch then
				local qualification = actData:checkGroupMatchQualification()
				local qualificationFlag = false

				if resData.target_type == constType.player and qualification or resData.target_type == constType.spectator and not qualification then
					qualificationFlag = true
				end

				if qualificationFlag == true then
					if GameFsm.isInState(Const.STATE_BATTLE) or GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
						if resData.battle_id then
							actData:setMarqueeShow(resData.battle_id)
						end
					elseif resData.normal_id then
						actData:setMarqueeShow(resData.normal_id)
					end
				end
			else
				local qualification = actData:checkKnockoutNowRoundQualification()
				local qualificationFlag = false

				if resData.target_type == constType.player and qualification or resData.target_type == constType.spectator and not qualification then
					qualificationFlag = true
				end

				if qualificationFlag == true then
					local betted = actData:checkGambleBtnRedDot()
					local betFlag = false

					if resData.bet_sign == 1 and betted ~= true or resData.bet_sign == 0 and betted == true then
						betFlag = true
					end

					if betFlag == true then
						if GameFsm.isInState(Const.STATE_BATTLE) or GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
							if resData.battle_id then
								actData:setMarqueeShow(resData.battle_id)
							end
						elseif resData.normal_id then
							actData:setMarqueeShow(resData.normal_id)
						end
					end
				end
			end
		end
	end
end

function ActivityDataTopPvp:setMarqueeTimer()
	local nowState = self:getTopPvpStage()

	if nowState then
		if nowState <= self.reStateMap.GroupSettle then
			if self:checkGroupMatchQualification() == true then
				if self.timer then
					self.timer:Stop()

					self.timer = nil
				end

				local cd = ResBPPvpMisc[1].marquee_show_cd or 60

				self.timer = Timer.New(self.marqueeShowFunc, cd, -1)

				self.timer:Start()
			elseif self.timer then
				self.timer:Stop()

				self.timer = nil

				return
			end
		else
			if self.timer then
				self.timer:Stop()

				self.timer = nil
			end

			local cd = ResBPPvpMisc[1].marquee_show_cd or 60

			self.timer = Timer.New(self.marqueeShowFunc, cd, -1)

			self.timer:Start()
		end
	end
end

function ActivityDataTopPvp:setknockoutBetRoomShow(...)
	UIManager.getUI("topPvpLiveConfirmDlg", true):show(self.cacheBetRoomInfo)
	self:updateFirstShowBetRoomFlag()
end

function ActivityDataTopPvp:refreshUI()
	local ui = UIManager.tryGetUI("mainStageDlg")

	if ui then
		ui.panelTopPvpEnterTips:refreshUI()
	end

	local ui = UIManager.tryGetUI("topPvpMainDlg")

	if ui and ui:getVisible() then
		ui:refreshState()
	end

	local ui = UIManager.tryGetUI("activityGatherMainDlg")

	if ui then
		ui:onBtnsRefresh()
	end

	self:setMarqueeTimer()

	if self:checkTopPvpCrossdata() then
		self:checkGathetBtnRedDot()
	end
end

function ActivityDataTopPvp:checkTopPvpRefreshStateUIs(...)
	local ui = UIManager.tryGetUI("activityGatherMainDlg")

	if ui and ui:getVisible() then
		return true
	end

	local ui = UIManager.tryGetUI("topPvpMainDlg")

	if ui and ui:getVisible() then
		return true
	end

	return false
end

function ActivityDataTopPvp:refreshStateTimer(...)
	local remainTime = self:getCurStageRemainTime()

	local function fun()
		local actData = CurAvatar:getTopPVPActivityData()

		if not actData then
			return
		end

		if not self:checkTopPvpRefreshStateUIs() then
			return
		end

		local actId = CurAvatar:getTopPVPActivityOpId()

		if actId then
			RPC.bPPvpActivityStateGet(actId)
		end
	end

	if remainTime and remainTime > 0 then
		if remainTime > 0 then
			if self.stateTimer then
				self.stateTimer:Stop()

				self.stateTimer = nil
			end

			self.stateTimer = Timer.New(fun, remainTime, 1)

			self.stateTimer:Start()
		else
			local actId = CurAvatar:getTopPVPActivityOpId()

			if actId then
				RPC.bPPvpActivityStateGet(actId)
			end
		end
	end
end

function ActivityDataTopPvp:updateTopPvpState(pvp_state)
	if not pvp_state then
		return
	end

	local needRefresh = false

	if self.state and pvp_state and self.state.timer_id ~= pvp_state.timer_id and self.state.timer_id ~= 0 then
		self.state = pvp_state

		local nowState = self:getTopPvpStage()

		if self.stateMap[nowState] == "KnockoutRoomPrepare" and self:checkFirstShowBetRoom() and self:checkBetRoomCanEnter() then
			self:setknockoutBetRoomShow()
		end

		needRefresh = true

		self:refreshUI()
	end

	if not self.state or self.state.timer_id == 0 then
		self.state = pvp_state
		needRefresh = true

		self:refreshUI()
	end

	if needRefresh and needRefresh == true then
		self:oneStateChangeRefresh()
	end

	if self.state and self.state.timer_id and self.state.timer_id ~= 0 then
		self:refreshStateTimer()

		local nowState = self:getTopPvpStage()

		if self.stateMap[nowState] == "KnockoutRoomFight" and not self.timer then
			self:setMarqueeTimer()
		end
	end

	self.state = pvp_state
end

function ActivityDataTopPvp:oneStateChangeRefresh(...)
	local nowState = self:getTopPvpStage()

	if nowState then
		if self.stateMap[nowState] == "GroupFight" then
			local ui = UIManager.tryGetUI("topPvpMainDlg")

			if ui and ui:getVisible() then
				local resData = ResBPPvpShow[13070018]

				if resData then
					local hint = resData.desc

					if hint then
						MsgManager.notice(hint)
					end
				end
			end
		elseif self.stateMap[nowState] == "KnockoutRoomShow" then
			RPC.rankCacheGetPage(Const.RANK_CACHE_TYPE_TOP_PVP, 1, 0, 1)
		end
	end
end

function ActivityDataTopPvp:updateGroupMatchRecord(record)
	self.opTopPvpNextGetGroupMatchReportTime = ClientUtils.getServerTime() + ResBPPvpMisc[1].record_get_cd
	self.record.opBPPvpReports = record
end

function ActivityDataTopPvp:getGroupMatchRemainTime()
	local nowState = self:getTopPvpStage()

	if nowState and self.stateMap[nowState] == "GroupSettle" then
		return self:getCurStageRemainTime()
	end

	local num = self.reStateMap.GroupSettle
	local endTime = ResBPPvpTimer[num].end_time or 0
	local remainTime = endTime + self.openTime - ClientUtils.getServerTime()

	return remainTime
end

function ActivityDataTopPvp:checkGroupMatchQualification()
	if self.groupId and self.groupId ~= 0 then
		return true
	end

	return false
end

function ActivityDataTopPvp:checkGroupMatchChallenged(uid)
	for k, v in pairs(self.challenge) do
		if v.uid == uid then
			return true
		end
	end

	return false
end

function ActivityDataTopPvp:checkGetSnapShotFormation()
	if CurAvatar:isFormationSnapShot(Const.FORMATION_TOPPVP_DEFEND_1) and self.snapShotFormation == nil then
		RPC.formationSnapshotGet(Const.FORMATION_TOPPVP_DEFEND_1)
	end
end

function ActivityDataTopPvp:checkTopPvpIsInGroupMatch(...)
	local nowState = self:getTopPvpStage()

	if nowState and nowState >= self.reStateMap.GroupFormationReady and nowState <= self.reStateMap.GroupSettle then
		return true
	end
end

function ActivityDataTopPvp:refreshSnapShotFormation(formation)
	if formation then
		self.snapShotFormation = formation

		local ui = UIManager.getUI("topPvpMainDlg", nil, false)

		if ui then
			ui:refreshUI()
		end
	end
end

function ActivityDataTopPvp:isSnapFormationFull()
	if self.snapShotFormation then
		local count = 0

		for i, teamInfo in ipairs(self.snapShotFormation.item) do
			for j, info in ipairs(teamInfo.data.item) do
				count = count + 1
			end
		end

		return count == 15
	else
		return false
	end
end

function ActivityDataTopPvp:checkGroupMatchFormationNew(...)
	if not self.groupId or self.groupId == 0 then
		return false
	end

	if self.state.timer_id ~= self.reStateMap.GroupFormation then
		return false
	end

	local result = false
	local isNeedCheckLocal = true

	if CurAvatar:isFormationSnapShot(Const.FORMATION_TOPPVP_DEFEND_1) and self:isSnapFormationFull() then
		isNeedCheckLocal = false
	end

	if isNeedCheckLocal then
		local allCount = 0
		local singleCount = 0
		local isLess
		local allUsedMap = {}

		for i = 1, 3 do
			local formation = CurAvatar:getNowFormation(Const["FORMATION_TOPPVP_DEFEND_" .. i])

			singleCount = 0

			for gid, pos in pairs(formation) do
				local hero = CurAvatar.heroDic[gid]

				if hero then
					singleCount = singleCount + 1
					allUsedMap[hero.id] = true
				end
			end

			allCount = allCount + singleCount

			if singleCount < 5 then
				isLess = true
			end
		end

		local ownCount = CurAvatar:getHeroCount()

		if allCount < ownCount and isLess == true then
			for gid, hero in pairs(CurAvatar.heroDic) do
				if allUsedMap[hero.id] ~= true then
					result = true

					break
				end
			end
		end
	end

	return result
end

function ActivityDataTopPvp:checkGroupMatchTabRedDot(...)
	local timer_id = self.state.timer_id

	if timer_id ~= self.reStateMap.GroupFormation and timer_id ~= self.reStateMap.GroupFight then
		return false
	end

	if timer_id == self.reStateMap.GroupFormation then
		return self:checkGroupMatchFormationNew()
	end

	if timer_id == self.reStateMap.GroupFight and self.myGroupData and self.challenge then
		return #self.myGroupData.group_member ~= #self.challenge + 1
	end
end

function ActivityDataTopPvp:updateKnockoutRecord(record)
	self.opTopPvpNextGetKnockoutReportTime = ClientUtils.getServerTime() + ResBPPvpMisc[1].record_get_cd
	self.record.opBPPvpKnockoutReports = record
end

function ActivityDataTopPvp:updateInKnockoutRoomId(Id)
	self.inKnockoutRoomId = Id
end

function ActivityDataTopPvp:updateMyKnockoutRoomId(id)
	if id and id ~= 0 then
		if not self.myKnockoutRoomId then
			self.myKnockoutRoomId = id

			self:refreshUI()
		elseif id > self.myKnockoutRoomId then
			self.myKnockoutRoomId = id
		end

		self:refreshUI()
	end

	if id and id ~= 0 then
		local areaId = self:getKnockoutAreaId(id)

		if areaId then
			local actId = CurAvatar:getTopPVPActivityOpId()

			RPC.bPPvpKnockoutRoomInfoGet(actId, areaId, id)
		end
	end
end

function ActivityDataTopPvp:checkRoomIdIsInNowRound(id)
	if not id or id == 0 then
		return false
	end

	local nowRound = self:getKnockoutRound()

	if nowRound then
		local round = math.floor(id % 100 / 10)

		if round == nowRound then
			return true
		else
			return false
		end
	else
		return false
	end
end

function ActivityDataTopPvp:updataCacheRoomInfo(room)
	if self.cacheRoomInfo == nil then
		self.cacheRoomInfo = room

		self:refreshUI()
	else
		self.cacheRoomInfo = room
	end
end

function ActivityDataTopPvp:getKnockoutAreaId(roomId)
	if roomId then
		local areaId = math.floor(roomId % 1000 / 100)

		return areaId
	else
		return 1
	end
end

function ActivityDataTopPvp:getMyknockoutAreaId()
	return self:getKnockoutAreaId(self.myKnockoutRoomId)
end

function ActivityDataTopPvp:getBetKnockoutAreaId()
	return self:getKnockoutAreaId(self.betRoomId)
end

function ActivityDataTopPvp:updateBpHeros(data)
	self.bpHeros = {}

	local visMap = {}

	for i = 1, 3 do
		self.bpHeros[i] = {}

		if data[i] then
			local onePool = data[i].bpnode

			for j = 1, #onePool do
				local hero = CurAvatar.heroDic[onePool[j].gid]

				if hero and not visMap[onePool[j].gid] then
					visMap[onePool[j].gid] = true

					table.insert(self.bpHeros[i], hero)
				end
			end
		end
	end
end

function ActivityDataTopPvp:getRemainNowRoundStartFightTime(...)
	local endTime

	for i, oneState in ipairs(ResBPPvpTimer) do
		if oneState.kickout_round == self:getKnockoutRound() and self.stateMap[oneState.state] == "KnockoutRoomChoose" then
			endTime = oneState.end_time
		end
	end

	if endTime then
		local remainTime = self.openTime + endTime - ClientUtils.getServerTime()

		return remainTime
	end

	return 0
end

function ActivityDataTopPvp:checkKnockoutQualification(...)
	if self.myKnockoutRoomId and self.myKnockoutRoomId ~= 0 then
		return true
	end

	return false
end

function ActivityDataTopPvp:getKnockoutRound()
	local id = self:getTopPvpTimerId()

	if self.stateMap[ResBPPvpTimer[id].state] == "KnockoutRoomShow" then
		return 7
	end

	return ResBPPvpTimer[id].kickout_round or 0
end

function ActivityDataTopPvp:checkKnockoutNowRoundQualification(...)
	if not self:checkKnockoutQualification() then
		return false
	end

	local nowRound = self:getKnockoutRound()
	local myRound = math.floor(self.myKnockoutRoomId % 100 / 10)

	return nowRound <= myRound
end

function ActivityDataTopPvp:getMyKnockoutRoom()
	return self.inKnockoutRoom
end

function ActivityDataTopPvp:getMyKnockoutRoomCommData(...)
	return self.inKnockoutRoom.comm
end

function ActivityDataTopPvp:updateMyKnockRoom(data)
	self.inKnockoutRoom = data
end

function ActivityDataTopPvp:CanChangeBpHeros(...)
	if not self:checkKnockoutNowRoundQualification() then
		return false
	end

	local state = self:getTopPvpStage()

	if self.stateMap[state] == "KnockoutRoomPoolPrepare" then
		return true
	end

	return false
end

function ActivityDataTopPvp:checkMyHeroBag(gid)
	local hero = CurAvatar.heroDic[gid]

	if hero then
		return true
	end

	return false
end

function ActivityDataTopPvp:getClearHeroPos(oneBag)
	for i = 1, #oneBag do
		if not self:checkMyHeroBag(oneBag[i].gid) then
			return i
		end
	end
end

function ActivityDataTopPvp:clearHero(...)
	local nowServerData = self.bpHeros

	self.heroBag = {}

	for teamType, oneBag in pairs(nowServerData) do
		local newBag = {}

		for pos, hero in ipairs(oneBag) do
			newBag[pos] = hero
		end

		self.heroBag[teamType] = newBag
	end

	for i = 1, 3 do
		for j = 1, #nowServerData[i] do
			local index = self:getClearHeroPos(self.heroBag[i])

			if index then
				table.remove(self.heroBag[i], index)
			end
		end
	end

	return self.heroBag
end

function ActivityDataTopPvp:getMyBPAllHeros(...)
	if not self.bpHeros or self.bppoolSign ~= 1 then
		self.bpHeros = {}

		for i = 1, 3 do
			self.bpHeros[i] = {}
		end
	end

	return self:clearHero()
end

function ActivityDataTopPvp:checkKnockoutEnd()
	local nowState = self:getTopPvpStage()

	if nowState == self.reStateMap.KnockoutRoomShow then
		return true
	else
		return false
	end
end

function ActivityDataTopPvp:checkBpFirstQualification(knockoutRoom)
	local memberData = knockoutRoom.knockout_member
	local firstPlayer = knockoutRoom.first_bp_uid
	local myIndex

	for i, player in pairs(memberData) do
		if player.uid == CurAvatar.uid then
			myIndex = i
		end
	end

	return myIndex == firstPlayer
end

function ActivityDataTopPvp:checkCanQueryHallData(...)
	if self.hallDataGetTime == nil then
		return true
	elseif ClientUtils.getServerTime() > self.hallDataGetTime + ResBPPvpMisc[1].hall_get_cd then
		return true
	else
		return false
	end
end

function ActivityDataTopPvp:initCacheRoomData(knockoutRoom)
	self.cacheRoomData = knockoutRoom

	if self.cacheRoomData.knockout_member then
		for i = 1, #self.cacheRoomData.knockout_member do
			local memberData = self.cacheRoomData.knockout_member[i]

			for j = 1, 3 do
				if memberData.bppool and memberData.bppool[j] and memberData.bppool[j].picknode then
					local picknode = memberData.bppool[j].picknode

					if picknode and #picknode ~= 0 and picknode[1] and picknode[1].pos then
						local pickPos = {}

						for k = 1, #picknode do
							local data = {}

							data.pos = picknode[k].pos + 1

							table.insert(pickPos, data)
						end

						memberData.bppool[j].pickPos = pickPos
					else
						memberData.bppool[j].pickPos = {}
					end
				end
			end

			local opHero = memberData.op_hero

			if opHero then
				memberData.preList = {}

				local preList = utils.getBitsDictFromByteString(memberData.op_hero)

				for i, j in pairs(preList) do
					if j == true then
						table.insert(memberData.preList, i + 1)
					end
				end
			end
		end
	end
end

function ActivityDataTopPvp:updateRoomState(state)
	if self.cacheRoomData and state then
		self.cacheRoomData.state = state
	end
end

function ActivityDataTopPvp:updateMyRoomState(state)
	if self.cacheRoomInfo and state then
		self.cacheRoomInfo.state = state
	end
end

function ActivityDataTopPvp:updateRoomSettle(data)
	if self.cacheRoomData then
		if data.winner then
			self.cacheRoomData.winner = data.winner
		end

		if data.replay_id then
			self.cacheRoomData.replay_id = data.replay_id
		end

		if data.round_time and #data.round_time ~= 0 then
			self.cacheRoomData.round_time = {}

			for i = 1, #data.round_time do
				if data.round_time[i] then
					local rtime = {}

					rtime.time = data.round_time[i]

					table.insert(self.cacheRoomData.round_time, rtime)
				end
			end
		end
	end
end

function ActivityDataTopPvp:updateRoomInfoSettle(data)
	if self.cacheRoomInfo then
		if data.winner then
			self.cacheRoomInfo.winner = data.winner
		end

		if data.replay_id then
			self.cacheRoomInfo.replay_id = tostring(data.replay_id)
		end

		if data.round_time and #data.round_time ~= 0 then
			self.cacheRoomInfo.round_time = {}

			for i = 1, #data.round_time do
				if data.round_time[i] then
					local rtime = {}

					rtime.time = data.round_time[i]

					table.insert(self.cacheRoomInfo.round_time, rtime)
				end
			end
		end
	end
end

function ActivityDataTopPvp:updateBpData(data)
	if self.cacheRoomData and self.cacheRoomData.state then
		local timeId = self.cacheRoomData.state.timer_id

		if timeId then
			local resRoomData = ResBPPvpRoomTimer[timeId]

			if resRoomData then
				local bpId = resRoomData.bp_id
				local round = resRoomData.bp_round

				if bpId and round and bpId ~= 0 and data.op_pos then
					if data.spare_bp_time then
						self.cacheRoomData.knockout_member[data.op_pos].spare_bp_time = data.spare_bp_time
					end

					if data.op_type then
						local pos

						pos = data.op_type == 100 and (data.op_pos == 1 and 2 or 1) or data.op_pos

						if data.op_hero_idx then
							self.cacheRoomData.knockout_member[data.op_pos].preList = data.op_hero_idx

							for i = 1, #data.op_hero_idx do
								local heroPos = data.op_hero_idx[i] + 1
								local state = self.cacheRoomData.knockout_member[pos].bppool[round].bpnode[heroPos].state

								self.cacheRoomData.knockout_member[pos].bppool[round].bpnode[heroPos].state = data.op_type + state

								if data.op_type == 200 then
									local data = {}

									data.pos = heroPos

									if not self.cacheRoomData.knockout_member[pos].bppool[round].picknode then
										self.cacheRoomData.knockout_member[pos].bppool[round].picknode = {}
									end

									table.insert(self.cacheRoomData.knockout_member[pos].bppool[round].pickPos, data)
								end
							end
						end
					end
				end
			end
		end
	end
end

function ActivityDataTopPvp:getChaheRoomData(...)
	return self.cacheRoomData
end

function ActivityDataTopPvp:checkHaveFormation(knockoutRoom)
	for i, member in pairs(knockoutRoom.knockout_member) do
		if member.uid == CurAvatar.uid then
			return member.is_formation == 1
		end
	end
end

function ActivityDataTopPvp:checkCacheRoomInfoFormation()
	if self.cacheRoomInfo and self.cacheRoomInfo.winner and self.cacheRoomInfo.winner ~= 0 then
		return true
	end

	if self.cacheRoomInfo and self.cacheRoomInfo.knockout_member and self.cacheRoomInfo.knockout_member[1] and self.cacheRoomInfo.knockout_member[1].uid then
		return self:checkHaveFormation(self.cacheRoomInfo)
	end

	return false
end

function ActivityDataTopPvp:updateCacheRommInfoMyFormation(...)
	if self.cacheRoomInfo and self.cacheRoomInfo.knockout_member and self.cacheRoomInfo.knockout_member[1] and self.cacheRoomInfo.knockout_member[1].is_formation then
		for i = 1, 2 do
			local member = self.cacheRoomData.knockout_member[i]

			if member.uid == CurAvatar.uid then
				member.is_formation = 1
			end
		end
	end
end

function ActivityDataTopPvp:getMyKnockoutFormation()
	local round = self:getKnockoutRound()

	if round then
		return self.myKnockoutFormations[round]
	end
end

function ActivityDataTopPvp:updateMyKnockoutFormation(formation)
	local round = self:getKnockoutRound()

	if round then
		self.myKnockoutFormations[round] = formation
	end
end

function ActivityDataTopPvp:updateBpHerosState(knockoutRoom)
	local memberData = knockoutRoom.knockout_member
	local myData

	for i = 1, #memberData do
		if memberData[i].uid == CurAvatar.uid then
			myData = memberData[i]
		end
	end

	self.bpState = {}

	for i = 1, 3 do
		self.bpState[i] = utils.deepcopy(myData.bppool[i].bpnode)
	end
end

function ActivityDataTopPvp:initFormationRoomData(knockoutRoom)
	self:updateBpHerosState(knockoutRoom)

	self.formationStartTime = knockoutRoom.state.start_time
end

function ActivityDataTopPvp:getKnockoutFormationRemainTime()
	if not self.formationStartTime then
		return 0
	end

	local lastTime = 0

	for k, v in pairs(ResBPPvpRoomTimer) do
		if self.knockoutStateMap[v.state] == "Formation" then
			lastTime = v.last_time
		end
	end

	return lastTime + self.formationStartTime - ClientUtils.getServerTime()
end

function ActivityDataTopPvp:checkBpHeroState(heroId)
	for i = 1, 3 do
		for j = 1, #self.bpState[i] do
			if self.bpState[i][j].hero_id == heroId then
				return self.bpState[i][j].state >= 200
			end
		end
	end
end

function ActivityDataTopPvp:getMyFormationHeros()
	local heroBags = {}

	for i = 1, 3 do
		heroBags[i] = {}
	end

	for i = 1, 3 do
		if self.roledata.bppool[i] then
			local onePool = self.roledata.bppool[i].bpnode

			for j = 1, #onePool do
				local hero = CurAvatar.heroDic[onePool[j].gid]

				if hero and self:checkBpHeroState(hero.id) then
					table.insert(heroBags[i], hero)
				end
			end
		end
	end

	return heroBags
end

function ActivityDataTopPvp:getKnockoutRoomStage(timeId)
	if timeId == 0 then
		return 0
	end

	return ResBPPvpRoomTimer[timeId].state or 0
end

function ActivityDataTopPvp:updateQueryHallTime()
	self.hallDataGetTime = ClientUtils.getServerTime()
end

function ActivityDataTopPvp:updateBetRoomId(id)
	if not self.betRoomId then
		if id and id ~= 0 then
			self.betRoomId = id

			local areaId = self:getKnockoutAreaId(id)
			local actId = CurAvatar:getTopPVPActivityOpId()

			if actId and areaId and id and id ~= 0 and areaId ~= 0 then
				RPC.bPPvpKnockoutRoomInfoGet(actId, areaId, id)
			end
		end
	elseif id and id ~= 0 and id > self.betRoomId then
		self.betRoomId = id

		local areaId = self:getKnockoutAreaId(id)
		local actId = CurAvatar:getTopPVPActivityOpId()

		if actId and areaId and id and id ~= 0 and areaId ~= 0 then
			RPC.bPPvpKnockoutRoomInfoGet(actId, areaId, id)
		end
	end
end

function ActivityDataTopPvp:getRoleBetData(...)
	return self.bet
end

function ActivityDataTopPvp:updateBetSupport(bluenum, rednum)
	self.betBlueNum = bluenum
	self.betRedNum = rednum
end

function ActivityDataTopPvp:updateBetTime(...)
	self.betTime = ClientUtils.getServerTime()
end

function ActivityDataTopPvp:checkBetNumTime()
	if not self.betTime then
		return false
	end

	local cd = ResBPPvpMisc[1].bet_sync_time or 10

	if self.betTime + cd > ClientUtils.getServerTime() then
		return true, self.betBlueNum, self.betRedNum
	else
		return false
	end
end

function ActivityDataTopPvp:betRecordIsEmpty()
	if self.bet then
		for i = 1, #self.bet do
			if self.bet ~= 0 then
				return false
			end
		end
	end

	return true
end

function ActivityDataTopPvp:updateChangeBetTime(...)
	self.preChangeBetTime = ClientUtils.getServerTime()
end

function ActivityDataTopPvp:checkCanChangeBetPostion()
	if not self.preChangeBetTime then
		return true
	end

	local now = ClientUtils.getServerTime()
	local cd = ResBPPvpMisc[1].bet_change_cd or 2

	cd = cd + 1

	if now >= self.preChangeBetTime + cd then
		return true
	else
		local remainTime = math.ceil(self.preChangeBetTime + cd - now)

		return false, string.format(Lang.get(84542), remainTime)
	end
end

function ActivityDataTopPvp:checkInCanEnterRoomStage(...)
	local nowState = self:getTopPvpStage()

	if not nowState then
		return false
	elseif self.stateMap[nowState] ~= "KnockoutRoomPrepare" and self.stateMap[nowState] ~= "KnockoutBPPoolSync" and self.stateMap[nowState] ~= "KnockoutRoomChoose" and self.stateMap[nowState] ~= "KnockoutRoomFight" then
		return false
	else
		return true
	end
end

function ActivityDataTopPvp:checkFirstShowBetRoom()
	if not self:checkInCanEnterRoomStage() then
		return false
	end

	local nowRound = self:getKnockoutRound()

	if nowRound and not self.firstShowBetRoom[nowRound] then
		return true
	end
end

function ActivityDataTopPvp:updateFirstShowBetRoomFlag()
	local nowRound = self:getKnockoutRound()

	if nowRound then
		self.firstShowBetRoom[nowRound] = true
	end
end

function ActivityDataTopPvp:checkBetRoomCanEnter()
	if not self:checkFirstShowBetRoom() then
		return false
	end

	if self:checkKnockoutNowRoundQualification() then
		return false
	end

	local ui = UIManager.tryGetUI("topPvpMainDlg")

	if not ui or not ui:getVisible() then
		return false
	end

	if self.cacheBetRoomInfo then
		if self.cacheBetRoomInfo.room_id ~= self.betRoomId then
			return false
		end

		if self.cacheBetRoomInfo.room_id and self.cacheBetRoomInfo.room_id ~= 0 then
			local roomId = self.cacheBetRoomInfo.room_id
			local round = self:getKnockoutRound()
			local roomRound = math.floor(roomId % 100 / 10)

			if round ~= roomRound then
				return false
			end
		else
			return false
		end

		local nowState = self:getTopPvpStage()

		if self.stateMap[nowState] == "KnockoutRoomFight" then
			if self.cacheBetRoomInfo.winner == 0 then
				return true
			else
				local roomInfo = self.cacheBetRoomInfo
				local roomStage = self:getKnockoutRoomStage(roomInfo.state.timer_id)

				if self.knockoutStateMap[roomStage] == "Fight" then
					if roomInfo.round_time then
						local startTime = roomInfo.state.start_time
						local round_time = roomInfo.round_time

						if not round_time or #round_time ~= 3 then
							return false
						end

						local cannotQuery = utils.IsSyncBattlePassed(startTime, round_time)

						if cannotQuery then
							return false
						else
							return true
						end
					else
						return false
					end
				else
					return true
				end
			end
		else
			return true
		end
	end
end

function ActivityDataTopPvp:updateCacheBetRoomInfo(room)
	self.cacheBetRoomInfo = room
end

function ActivityDataTopPvp:updateBpBanRule(...)
	if self.banRule and ResBPPvpHeroAutoBanRule[self.banRule] then
		local data = ResBPPvpHeroAutoBanRule[self.banRule]

		self.banRuleList = {}

		table.insert(self.banRuleList, data.career_1)
		table.insert(self.banRuleList, data.career_2)
		table.insert(self.banRuleList, data.career_3)
		table.insert(self.banRuleList, data.career_4)
		table.insert(self.banRuleList, data.career_5)
	end
end

function ActivityDataTopPvp:updateBpBanRuleId(id)
	self.banRule = id

	self:updateBpBanRule()
end

function ActivityDataTopPvp:getBpBanRule(...)
	if self.banRule and self.banRuleList then
		return self.banRuleList
	end
end

function ActivityDataTopPvp:updateBulletMaxSeq(id)
	self.maxReq = id
end

function ActivityDataTopPvp:getBulletMaxSeq(...)
	if not self.maxReq then
		self.maxReq = 0
	end

	return self.maxReq
end

function ActivityDataTopPvp:updateBulletSwitch(state)
	self.bulletSwitch = state
end

function ActivityDataTopPvp:getBulletSwitch(state)
	return self.bulletSwitch
end

function ActivityDataTopPvp:checkBpPoolAbsentRedDot()
	if not self:CanChangeBpHeros() then
		return false
	end

	local bpHeros = self:getMyBPAllHeros()

	for i = 1, 3 do
		if #bpHeros[i] ~= 10 then
			return true
		end
	end

	return false
end

function ActivityDataTopPvp:checkBpPoolSetRedDot()
	return false
end

function ActivityDataTopPvp:isInGroupMatch(...)
	local nowState = self:getTopPvpStage()

	if nowState <= self.reStateMap.GroupSettle then
		return true
	end

	return false
end

function ActivityDataTopPvp:checkGambleBtnRedDot()
	if self:isInGroupMatch() then
		return false
	end

	local nowState = self:getTopPvpStage()

	if nowState <= self.reStateMap.KnockoutBPPoolSync then
		local round = self:getKnockoutRound()

		if round == 7 then
			return false
		else
			if not self.bet or #self.bet == 0 then
				return true
			end

			if self.bet and self.bet[round] and self.bet[round].bet_pos then
				return self.bet[round].bet_pos == 0
			end

			return false
		end
	end
end

function ActivityDataTopPvp:checkKnockoutTab64()
	if self:isInGroupMatch() then
		return false
	end

	local round = self:getKnockoutRound()

	if round >= 4 then
		return false
	end

	return self:checkGambleBtnRedDot()
end

function ActivityDataTopPvp:checkKnockoutTab8(...)
	if self:isInGroupMatch() then
		return false
	end

	local round = self:getKnockoutRound()

	if round < 4 then
		return false
	end

	return self:checkGambleBtnRedDot()
end

function ActivityDataTopPvp:checkKnockoutTabMy(...)
	if not self:checkKnockoutNowRoundQualification() then
		return false
	else
		local nowState = self:getTopPvpStage()

		if nowState > self.reStateMap.KnockoutRoomPoolPrepare and nowState < self.reStateMap.KnockoutRoomSettle then
			if self.cacheRoomInfo and self.cacheRoomInfo.state and self.cacheRoomInfo.state.timer_id then
				local roomStage = self:getKnockoutRoomStage(self.cacheRoomInfo.state.timer_id)

				if self.knockoutStateMap[roomStage] == "Fight" then
					local startTime = self.cacheRoomInfo.state.start_time

					if startTime and self.cacheRoomInfo.round_time then
						local remainTime = utils.GetSyncBattleRemainTime(startTime, self.cacheRoomInfo.round_time)

						if remainTime and remainTime > 0 then
							local function fun()
								if GameFsm.isInState(Const.STATE_LOGIN) then
									return
								end

								self:refreshUI()
								self.timerRed:Stop()
							end

							if self.timerRed then
								self.timerRed:Stop()

								self.timerRed = nil
							end

							self.timerRed = Timer.New(fun, remainTime + 1, 1)

							self.timerRed:Start()

							return true
						else
							return false
						end
					else
						return false
					end
				else
					return true
				end
			else
				return true
			end
		elseif self.stateMap[nowState] == "KnockoutRoomPoolPrepare" then
			return self:checkBpPoolAbsentRedDot()
		else
			return false
		end
	end
end

function ActivityDataTopPvp:destroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.stateTimer then
		self.stateTimer:Stop()

		self.stateTimer = nil
	end

	if self.timerRed then
		self.timerRed:Stop()

		self.timerRed = nil
	end

	ActivityDataTopPvp.super.destroy(self)
end

function ActivityDataTopPvp:checkKnockoutTabRedDot()
	if self:checkBpPoolAbsentRedDot() or self:checkBpPoolSetRedDot() or self:checkKnockoutTabMy() or self:checkKnockoutTab8() or self:checkKnockoutTab64() then
		return true
	end

	return false
end

function ActivityDataTopPvp:checkGathetBtnRedDot(...)
	if not self:checkTopPvpCrossdata() then
		return false
	end

	if self:checkKnockoutTabRedDot() or self:checkGroupMatchTabRedDot() then
		RedDotManager.setKeyState(UIConst.RD_HINT_TOPPVP, true)

		return
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_TOPPVP, false)
end

function ActivityDataTopPvp:checkObjNewOpened(...)
	local actObject = self.actObject

	if not actObject.roleCommonData or actObject.roleCommonData.miss_focus == 0 or actObject.roleCommonData.miss_focus == nil then
		return true
	else
		return false
	end
end

function ActivityDataTopPvp:registerRDEvent()
	if self.actObject.redDotId then
		RedDotManager.setKeyRelation(UIConst.RD_HINT_TOPPVP, self.actObject.redDotId)
	end
end

function ActivityDataTopPvp:unRegistRDEvent()
	if self.actObject.redDotId then
		RedDotManager.delKeyRelation(UIConst.RD_HINT_TOPPVP, self.actObject.redDotId)
	end
end

function ActivityDataTopPvp:isNewOpened()
	local nowState = self:getTopPvpStage()

	if nowState then
		local num = self.reStateMap.GroupSettle

		if nowState <= num then
			local can = self:checkGroupMatchQualification()

			if can then
				return self:checkObjNewOpened()
			else
				return false
			end
		else
			return self:checkObjNewOpened()
		end
	end
end

return ActivityDataTopPvp
