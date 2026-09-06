-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroPvPMainView.lua

module("logic.extensions.aoqihero.view.AoqiHeroPvPMainView", package.seeall)

local AoqiHeroPvPMainView = class("AoqiHeroPvPMainView", ViewComponent)

function AoqiHeroPvPMainView:ctor()
	AoqiHeroPvPMainView.super.ctor(self)
end

function AoqiHeroPvPMainView:unbindEvents()
	AoqiHeroPvPMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnDefence)
	GameUtil.rmClickHandler(self._btnReport)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnStrengthen)
end

function AoqiHeroPvPMainView:bindEvents()
	AoqiHeroPvPMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnDefence, self._onClickDefence, self)
	GameUtil.addClickHandler(self._btnReport, self._onClickReport, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnStrengthen, self._onClicktrengthen, self)
end

function AoqiHeroPvPMainView:buildUI()
	AoqiHeroPvPMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnStart = self:getGo("btnStart")
	self._btnDefence = self:getGo("btnDefence")
	self._btnReport = self:getGo("btnReport")
	self._btnRank = self:getGo("btnRank")
	self._btnStrengthen = self:getGo("btnStrengthen")
	self._headIcon = self:getGo("playerInfo/headIcon")
	self._txtScore = self:getTxt("playerInfo/txtScore")
	self._txtAreaName = self:getTxt("playerInfo/txtAreaName")
	self._txtRank = self:getTxt("playerInfo/txtRank")
	self._txtOpenTime = self:getTxt("txtOpenTime")
	self._txtGameTime = self:getTxt("txtGameTime")
	self._txtStraight = self:getTxt("txtStraight")
	self._redpointReport = self:getGo("btnReport/redpoint")
	self._redpointStart = self:getGo("btnStart/redpoint")
end

function AoqiHeroPvPMainView:onExit()
	AoqiHeroPvPMainView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headIcon)
	RedPointController.instance:unregRedPoint(self._redpointReport)
end

function AoqiHeroPvPMainView:onEnter()
	AoqiHeroPvPMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_NotifyAoQiHeroPvPRoomEndRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = AoQiHeroConfig.instance:getActivityCfg(self._activityId)

	local headInfo = RoleModel.instance:getHeadInfo()

	HeadItemController.instance:setHeadCellByInfo(self._headIcon, headInfo, false)

	self._txtAreaName.text = langPara("%s-%s", RoleModel.instance:getAreaName(), RoleModel.instance:getUserName())

	local startTime = GameUtil.string2date("0-0-0 " .. self._activityCfg.startTime)
	local endTime = GameUtil.string2date("0-0-0 " .. self._activityCfg.endTime)

	self._txtOpenTime.text = langPara("%02d:%02d-%02d:%02d开启", startTime.hour, startTime.min, endTime.hour, endTime.min)

	RedPointController.instance:regRedPoint(self._redpointReport, RedPointModel.ID_AOQI_HERO_NEW_REPORT)
	self:_refreshView()
end

function AoqiHeroPvPMainView:_refreshView()
	self._txtScore.text = langPara("积分：%d", AoQiHeroModel.instance:getPvpScore(self._activityId))

	local rank = AoQiHeroModel.instance:getPvpRank(self._activityId)

	rank = checknumber(rank)
	self._txtRank.text = rank > 0 and langPara("排名：%d", rank) or lang("排名：未上榜")

	local winStreak = AoQiHeroModel.instance:getPvpWinStreak(self._activityId)

	GameUtil.SetActive(self._txtStraight, winStreak > 0)

	self._txtStraight.text = langPara("<size=80>%d</size>连胜", winStreak)

	local times = AoQiHeroModel.instance:getPvpTimes(self._activityId)

	self._txtGameTime.text = langPara("今日剩余次数：<color=#2DFF06FF>%d</color>", self._activityCfg.pvpDailyTimes - times)

	GameUtil.SetActive(self._redpointStart, self._activityCfg.pvpDailyTimes - times > 0)
end

function AoqiHeroPvPMainView:_onClickStart()
	if not AoQiHeroController.instance:isPassAllStage(self._activityId) then
		FloatWordMgr.instance:show(lang("请先通关全部普通关卡"))

		return
	end

	local mapInfo = AoQiHeroModel.instance:getPvPMapInfo(self._activityId)

	if checknumber(mapInfo.mapId) <= 0 then
		FloatWordMgr.instance:show(lang("请先布置攻阵"))

		return
	end

	if not GameUtil.checkIsInTimePeriod(self._activityCfg.startTime, self._activityCfg.endTime, true) then
		FloatWordMgr.instance:show(lang("不在开放时间内"))

		return
	end

	local times = AoQiHeroModel.instance:getPvpTimes(self._activityId)

	if self._activityCfg.pvpDailyTimes - times <= 0 then
		FloatWordMgr.instance:show(lang("今日剩余次数为0"))

		return
	end

	local teamInfo = AoQiHeroModel.instance:getCurPetTeams(self._activityId)
	local hasPet = false

	for i, v in pairs(teamInfo) do
		if v.petId ~= 0 then
			hasPet = true
		end
	end

	if not hasPet then
		FloatWordMgr.instance:show(lang("当前攻阵未上阵精灵，请先上阵精灵后再匹配"))
	else
		UIStateManager.instance:push(ViewName.AoqiHeroMatchView, self._activityId)
	end
end

function AoqiHeroPvPMainView:_onClickDefence()
	UIStateManager.instance:push(ViewName.AoQiHeroDefenceView, self._activityId)
end

function AoqiHeroPvPMainView:_onClickReport()
	UIStateManager.instance:push(ViewName.AoqiHeroAllReportView, self._activityId)
end

function AoqiHeroPvPMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.AoqiHeroRankView, self._activityId, 3)
end

function AoqiHeroPvPMainView:_onClicktrengthen()
	UIStateManager.instance:push(ViewName.AoqiHeroStrengthenView, self._activityId)
end

function AoqiHeroPvPMainView:_onClickTips()
	TipsFacade.instance:openRulesView("aoqi_hero_rule_pvp")
end

return AoqiHeroPvPMainView
