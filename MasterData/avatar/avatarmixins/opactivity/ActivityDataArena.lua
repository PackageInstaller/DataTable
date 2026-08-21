-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataArena.lua

local ResArenaFormationHide = require("ClientData/ResArenaFormationHide")
local PVPCommon = require("Logic/PVP/PVPCommon")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResArenaDan = require("ClientData/ResArenaDan")
local ResArenaLeague = require("ClientData/ResArenaLeague")
local ResArenaMisc = require("ClientData/ResArenaMisc")
local UserData = require("Helper/UserData")
local ActivityDataArena = Class("ActivityDataArena", ActivityDataBase)

function ActivityDataArena:ctor(...)
	return
end

function ActivityDataArena:updateClientData(actId)
	self.actId = actId
end

function ActivityDataArena:registerRDEvent()
	if self.actObject.redDotId then
		RedDotManager.setKeyRelation(UIConst.RD_HINT_OPACTPVP, self.actObject.redDotId)
	end
end

function ActivityDataArena:unRegistRDEvent()
	if self.actObject.redDotId then
		RedDotManager.delKeyRelation(UIConst.RD_HINT_OPACTPVP, self.actObject.redDotId)
	end
end

function ActivityDataArena:updateSystemData(systemItem)
	return
end

function ActivityDataArena:updateMgrData(opActivityMgrItem)
	self.arenaMgrData = opActivityMgrItem

	self:refreshWillEndTip()
	self:refreshState()
end

function ActivityDataArena:updateRoleData(roleData, isUpdate)
	self.arenaData = utils.deepcopy(roleData.arena)

	self:checkGetSnapShotFormation()
	self:refreshState()
	self:refreshWillEndTip()
end

function ActivityDataArena:willEnd()
	local leftTime = self:getLeftTimeToFreeze()

	return leftTime >= 0 and leftTime <= self:willEndCountDown()
end

function ActivityDataArena:willEndCountDown()
	return 43200
end

function ActivityDataArena:reduceChallengeTimes(...)
	if self.arenaData then
		self.arenaData.challenge_times = self.arenaData.challenge_times - 1
	end

	self:refreshWillEndTip()
end

function ActivityDataArena:getLeftTimeToFreeze(...)
	if self.state == Const.OPACT_STATE_CLOSE or self.state == Const.OPACT_STATE_FREEZE then
		return -1
	end

	if self.arenaMgrData then
		return self.arenaMgrData.time.freezetime - ClientUtils.getServerTime()
	end

	return -1
end

function ActivityDataArena:getLeftTimeToEnd(...)
	if self.state == Const.OPACT_STATE_CLOSE then
		return -1
	end

	if self.arenaMgrData then
		return self.arenaMgrData.time.closetime - ClientUtils.getServerTime()
	end

	return -1
end

function ActivityDataArena:getEndTime(...)
	return self:getLeftTimeToEnd()
end

local closeUI = {
	"activityPvpEnemyDlg",
	"activityPvpRecordDlg",
	"activityPvpMainDlg",
	"activityPvpWelcomeDlg",
	"activityPvpRankChangeDlg",
	"activityPvpPartAwardDlg",
	"activityPvpTopRankDlg",
	"activityPvpCheckTeamDlg"
}
local freezeUI = {
	"activityPvpEnemyDlg",
	"activityPvpRecordDlg"
}

function ActivityDataArena:onStateChange(opActState)
	self.state = opActState

	if opActState == Const.OPACT_STATE_OPEN then
		self:refreshState()
		self:refreshSceneShow()
	elseif opActState == Const.OPACT_STATE_CLOSE then
		self:onFreezeOrEnd(closeUI)
		self:refreshState()

		CurAvatar.opactPvpNeedGetTopRank = true
	elseif opActState == Const.OPACT_STATE_FREEZE then
		self:onFreezeOrEnd(freezeUI)
		self:refreshState()
		self:refreshWillEndTip()
	end
end

function ActivityDataArena:onFreezeOrEnd(uis)
	local isNeedTip = false

	for _, name in ipairs(uis) do
		local ui = UIManager.getUI(name, nil, false)

		if ui then
			isNeedTip = true

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

		local ui = UIManager.getUI("rankingAwardDlg", nil, false)

		if ui and ui:getRankAwardType() == Const.RANK_AWARD_TYPE_OPACTPVP then
			ui:setVisible(false)
		end
	end

	if isNeedTip then
		local msgContent = ClientUtils.getClientNotice(324)

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", msgContent, yesFunc, nil, nil)
	end
end

function ActivityDataArena:getLimitId(...)
	return Const.CONDITION_LIMIT_OPACTPVP
end

function ActivityDataArena:registEndEvent(...)
	ActivityDataArena.super.registEndEvent(self)

	local freezeTipTime = self:getLeftTimeToFreeze() - 43200

	if freezeTipTime > 0 then
		ClientTimerManager.startGlobalTimer("activity_pvp_frozen_tip" .. self.actObject.actId, freezeTipTime, Slot(self.refreshWillEndTip, self))
	end
end

function ActivityDataArena:unRegistEndEvent(...)
	ActivityDataArena.super.unRegistEndEvent(self)
	ClientTimerManager.stopGlobalTimer("activity_pvp_frozen_tip" .. self.actObject.actId)
end

local uis = {
	"pvpChooseDlg",
	"activityPvpMainDlg"
}

function ActivityDataArena:refreshState(...)
	if self.arenaData == nil then
		self:checkRedHint()

		return
	end

	for _, name in ipairs(uis) do
		local ui = UIManager.getUI(name, nil, false)

		if ui then
			ui:refreshUI()
		end
	end

	self:checkRedHint()
end

function ActivityDataArena:checkRedHint(...)
	CurAvatar:checkOpactPvpFormationRedHind()
	CurAvatar:checkOpactPvpChallengeRedHind()
	CurAvatar:checkPartChangeRedHint()
	CurAvatar:checkOpactPvpReportRedHint()
end

function ActivityDataArena:isRandTeam(...)
	if self.arenaData then
		return self.arenaData.rand_formation == 1
	end
end

function ActivityDataArena:getMyCurPartInfo(...)
	local score = 0

	if self.arenaData then
		score = self.arenaData.score
	end

	return self:getPartInfoByScore(score)
end

function ActivityDataArena:getCurFormationHideMode()
	local score = 0

	if self.arenaData then
		score = self.arenaData.score
	end

	local partInfo = self:getPartInfoByScore(score)

	if partInfo then
		return ResArenaFormationHide[partInfo.hide_mode].formation
	end

	return {}
end

function ActivityDataArena:getPartInfoByScore(score, league)
	if league == nil and self.arenaData then
		league = self.arenaData.league
	end

	if league == 0 then
		league = 4
	end

	local zoneInfo = PVPCommon.getZoneInfo(league)

	if zoneInfo then
		for i = zoneInfo.dan_low_limit, zoneInfo.dan_high_limit do
			local info = ResArenaDan[i]

			if i == zoneInfo.dan_low_limit and score < info.low_score then
				return info, i == #ResArenaDan
			elseif i == zoneInfo.dan_high_limit and score > info.high_score then
				return info, i == #ResArenaDan
			elseif score >= info.low_score and score <= info.high_score then
				return info, i == #ResArenaDan
			end
		end
	end

	return ResArenaDan[1], false
end

function ActivityDataArena:canUpgradeZone()
	if self.arenaData == nil then
		return false, ""
	end

	local curLeague = self.arenaData.league
	local toLeague = curLeague - 1

	if toLeague < 0 then
		toLeague = #ResArenaLeague
	elseif toLeague == 0 then
		return false, Lang.get(1918)
	end

	local info = ResArenaLeague[toLeague]
	local curInfo = ResArenaLeague[curLeague]

	if info and curInfo then
		local partInfo = self:getPartInfoByScore(self.arenaData.score)
		local isStageOk = CurAvatar:mainStageStatePassed(info.need_stage[1], info.need_stage[2], info.need_stage[3])
		local isAllOk = false

		if isStageOk then
			if partInfo.dan >= curInfo.lvup_dan then
				isAllOk = true
			else
				isAllOk = false
			end
		else
			isAllOk = false
		end

		if isAllOk then
			local requireStage = CurAvatar:getMainStageInfo(info.need_stage[1], info.need_stage[2], info.need_stage[3])
			local curStage = CurAvatar:getNowStageData()
			local offset = math.floor((curStage.idx - requireStage.idx + 1) / 15)
			local initScore = info.init_score + offset * ResArenaMisc[1].stage_score
			local initPart = self:getPartInfoByScore(initScore, toLeague)

			return true, utils.format(Lang.get(1916), initScore, initPart.dan_name)
		else
			local partInfo = ResArenaDan[curInfo.lvup_dan]

			return false, utils.format(Lang.get(1917), info.need_stage[2], info.need_stage[3], partInfo.dan_name)
		end
	end
end

function ActivityDataArena:getOpactPvpDefendPower(...)
	local power = 0

	if CurAvatar:isFormationSnapShot(Const.FORMATION_OPACTPVP_DEFEND_1) then
		if self.snapShotFormation == nil then
			return 0
		else
			return PVPCommon.getFormationPower(self.snapShotFormation.item)
		end
	else
		for i = 1, 3 do
			power = power + CurAvatar:getNowFormationCapacity(Const["FORMATION_OPACTPVP_DEFEND_" .. i])
		end

		return power
	end
end

function ActivityDataArena:checkGetSnapShotFormation(...)
	if CurAvatar:isFormationSnapShot(Const.FORMATION_OPACTPVP_DEFEND_1) and self.snapShotFormation == nil then
		RPC.formationSnapshotGet(Const.FORMATION_OPACTPVP_DEFEND_1)
	end
end

function ActivityDataArena:refreshSnapShotFormation(formation)
	if formation then
		self.snapShotFormation = formation

		CurAvatar:checkOpactPvpFormationRedHind()

		local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

		if ui then
			ui:refreshPower()
			ui:refreshRankList()
		end
	end
end

function ActivityDataArena:isSnapFormationFull(...)
	if self.snapShotFormation then
		local count = 0

		for i, teamInfo in ipairs(self.snapShotFormation.item) do
			for j, info in ipairs(teamInfo.data.item) do
				count = count + 1
			end
		end

		return count == 15
	else
		return true
	end
end

function ActivityDataArena.topMsgShow(rank_data)
	local _name, _serverName, index

	for i, data in ipairs(rank_data) do
		local name, serverName, serverId = utils.GetPlayerName(data.comm.name)

		if serverId == SvrListManager.getSelectedSvrID() then
			_name = name
			_serverName = serverName
			index = i

			break
		end
	end

	if _name then
		local ResColor = require("ClientData/ResColor")

		_name = utils.getColorfulStr(_name, ResColor.BLUE)
		_serverName = utils.getColorfulStr(_serverName, ResColor.BLUE)
		index = utils.getColorfulStr(tostring(index), ResColor.BLUE)

		local content = utils.getColorfulStr(Lang.get(1690), ResColor.QUALITYORANGE) .. _name .. utils.getColorfulStr(Lang.get(1919), ResColor.QUALITYORANGE) .. _serverName .. utils.getColorfulStr(Lang.get(1920), ResColor.QUALITYORANGE) .. index .. utils.getColorfulStr(Lang.get(1921), ResColor.QUALITYORANGE)

		CurAvatar:receiveFakeSystemMsg(content)
	end
end

function ActivityDataArena:refreshSceneShow(...)
	if self.state == Const.OPACT_STATE_OPEN then
		ClientUtils.record.opactPvpTopTen = nil

		SceneManager.refreshArenaRank()
	elseif self.state == Const.OPACT_STATE_CLOSE then
		-- block empty
	end
end

local willEndUIs = {
	"mainStageDlg",
	"pvpChooseDlg"
}

function ActivityDataArena:refreshWillEndTip(...)
	for _, name in ipairs(willEndUIs) do
		local ui = UIManager.getUI(name, nil, false)

		if ui and ui.checkPvpState then
			ui:checkPvpState()
		end
	end
end

function ActivityDataArena:getPreDan(...)
	if ClientUtils.record.preOpactPvpDan == nil then
		local dan = UserData.loadCommonDataInt("opactPvpDan" .. CurAvatar.uid)

		if dan == 0 then
			-- block empty
		else
			ClientUtils.record.preOpactPvpDan = dan
		end
	end

	return ClientUtils.record.preOpactPvpDan
end

function ActivityDataArena:savePreDan(dan)
	ClientUtils.record.preOpactPvpDan = dan

	UserData.saveCommonDataInt("opactPvpDan" .. CurAvatar.uid, dan)
end

return ActivityDataArena
