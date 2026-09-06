-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchenterView.lua

module("logic.extensions.annimatch.view.AnnimatchenterView", package.seeall)

local AnnimatchenterView = class("AnnimatchenterView", ViewComponent)

function AnnimatchenterView:ctor()
	AnnimatchenterView.super.ctor(self)
end

function AnnimatchenterView:unbindEvents()
	AnnimatchenterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnEnter)
	GameUtil.rmClickHandler(self.btnTip)
	GameUtil.rmClickHandler(self.btnRank)
	GameUtil.rmClickHandler(self.btnPrize)
	GameUtil.rmClickHandler(self.btnExchange)
	GameUtil.rmClickHandler(self.btnTask)
	GameUtil.rmClickHandler(self._btnVote)
end

function AnnimatchenterView:bindEvents()
	AnnimatchenterView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnEnter, self.onClickEnter, self)
	GameUtil.addClickHandler(self.btnTip, self.onClickHelp, self)
	GameUtil.addClickHandler(self.btnRank, self.onClickRank, self)
	GameUtil.addClickHandler(self.btnPrize, self.onClickPrize, self)
	GameUtil.addClickHandler(self.btnExchange, self.onClickExchange, self)
	GameUtil.addClickHandler(self.btnTask, self.onClickTask, self)
	GameUtil.addClickHandler(self._btnVote, self._onClickBtnVote, self)
end

function AnnimatchenterView:buildUI()
	AnnimatchenterView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnEnter = self:getGo("btnEnter")
	self.txtEnter = self:getTxt("btnEnter/txt")
	self.goldBarCon = self:getGo("goldBarCon")
	self.btnTip = self:getGo("btnTip")
	self.btnRank = self:getGo("btnRank")
	self.btnPrize = self:getGo("btnPrize")
	self.btnPrizeimgPoint = self:getGo("btnPrize/imgPoint")
	self.btnExchange = self:getGo("btnExchange")
	self.btnExchangeimgPoint = self:getGo("btnExchange/imgPoint")
	self.btnTask = self:getGo("btnTask")
	self.btnTaskimgPoint = self:getGo("btnTask/imgPoint")
	self.remain = self:getGo("remain")
	self.txtNum = self:getTxt("remain/txtNum")
	self.icon = self:getGo("remain/txtNum/icon")
	self.btnAdd = self:getGo("remain/txtNum/btnAdd")
	self._btnVote = self:getGo("btnVote")
	self._redPointVote = self:getGo("btnVote/imgPoint")

	GameUtil.SetActive(self.remain, false)

	self.txtOpenTime = self:getTxt("txtOpenTime")
	self.txtTime = self:getTxt("time/txt")
end

function AnnimatchenterView:onExit()
	AnnimatchenterView.super.onExit(self)
	removetimer(self._updateCountDownTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAnnimatchTicketUpdate, self.refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAnnimatchInfoUpdate, self.onOpenNextView, self)
	RedPointController.instance:unregRedPoint(self.btnTaskimgPoint)
	UIEffectManager.instance:stopEffect(self._pmEff)
end

function AnnimatchenterView:onEnter()
	AnnimatchenterView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnnimatchTicketUpdate, self.refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnnimatchInfoUpdate, self.onOpenNextView, self)
	self.addGEvent(self, GlobalNotify.PM_AnnualCompetitionBanPetInfoRes, self.refreshUI, self)

	local activityId = AnnimatchController.instance:getCurrActId()

	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionGainTicketReq(activityId)

	local cfg = AnnimatchConfig.instance:getCfgById(activityId)
	local btn_list = {
		{
			showAdd = true,
			id = MaterialMgr.createSerName(MatType.ACTIVITY_ITEM, cfg.ticketItemId)
		}
	}

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor, btn_list)
	self:refreshUI()
	RedPointController.instance:regRedPoint(self.btnTaskimgPoint, RedPointModel.ID_ANNIMATCH_TASK_REWARD)

	local effPath = "20230728/xiaridazuozhan/fx_ui_xiaridazuozhan_fw.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)

	if cfg then
		if not cfg.useVoteBanPet then
			local useVoteBanPet = false

			GameUtil.SetActive(self._btnVote, useVoteBanPet)
			AnnimatchController.instance:showChangeSetId()
			AnnimatchController.instance:sendPM_AnnualCompetitionBanPetInfoReq(activityId)
		end
	end
end

function AnnimatchenterView:onOpenNextView()
	local activityId = AnnimatchController.instance:getCurrActId()
	local info = AnnimatchModel.instance:getInfo(activityId)

	if AnnimatchController.instance:checkHasNextPet(activityId) then
		UIStateManager.instance:push(ViewName.AnnimatchselectView)
	else
		UIStateManager.instance:push(ViewName.AnnimatchmainView, true)
	end
end

function AnnimatchenterView:refreshUI()
	local activityId = AnnimatchController.instance:getCurrActId()
	local isAdmission = AnnimatchModel.instance:getIsAdmission(activityId)
	local banInfo = AnnimatchModel.instance:getBanPetInfo(activityId)

	self.txtEnter.text = isAdmission and AnnimatchConfig.instance:getCommonByKey("ENTER_CONTINUE") or AnnimatchConfig.instance:getCommonByKey("ENTER_BEGIN")

	local cfg = AnnimatchConfig.instance:getCfgById(activityId)
	local arr = string.split(cfg.openTime, "#")

	self.txtOpenTime.text = langPara("开启时间：%s-%s", arr[1], arr[2])

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(math.floor(activityId / 1000), activityId)

	self.endTime = endTime

	removetimer(self._updateCountDownTime, self)
	settimer(1, self._updateCountDownTime, self, true)
	self:_updateCountDownTime()
	GameUtil.SetActive(self._redPointVote, false)

	if banInfo then
		local sysBanPetNum = checknumber(AnnimatchConfig.instance:getCommonByKey("CAN_BAN_PET_WIN_TIMES"))
		local hasBan = #banInfo.selfBanRaceIds > 0
		local canBan = sysBanPetNum <= banInfo.totalWinTimes

		GameUtil.SetActive(self._redPointVote, not hasBan and canBan)
	end
end

function AnnimatchenterView:_updateCountDownTime()
	local time = self.endTime - ServerTime.nowServerLook()

	time = math.max(0, time)

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(time)

	self.txtTime.text = langPara("aceteammainview__9", day, hour, min, sec)
end

function AnnimatchenterView:onClickHelp()
	TipsFacade.instance:openRulesView(AnnimatchConfig.instance:getCommonByKey("ACT_RULE"))
end

function AnnimatchenterView:onClickRank()
	UIStateManager.instance:push(ViewName.AnnimatchrankView)
end

function AnnimatchenterView:onClickPrize()
	UIStateManager.instance:push(ViewName.AnnimatchprizeView)
end

function AnnimatchenterView:onClickExchange()
	local jump = AnnimatchConfig.instance:getCommonByKey("ENTER_EXCHANGE_JUMP")

	GotoMgr.gotoByString(jump)
end

function AnnimatchenterView:onClickTask()
	UIStateManager.instance:push(ViewName.AnnimatchtaskView)
end

function AnnimatchenterView:onClickEnter()
	local boo = AnnimatchController.instance:checkIsInActTime()

	if boo then
		local activityId = AnnimatchController.instance:getCurrActId()
		local cfg = AnnimatchConfig.instance:getCfgById(activityId)
		local arr = string.split(cfg.openTime, "#")

		if GameUtil.checkIsInTimePeriod(arr[1], arr[2], true) then
			local isAdmission = AnnimatchModel.instance:getIsAdmission(activityId)

			if isAdmission then
				AnnimatchController.instance:sendGetInfoWithOpenView(activityId)
			else
				local ticket = MaterialMgr.createSerName(MatType.ACTIVITY_ITEM, cfg.ticketItemId)
				local type, id, num = MatType.ACTIVITY_ITEM, cfg.ticketItemId, 1
				local name = MaterialMgr.getMaterialsName(type, id)
				local costTips = AnnimatchConfig.instance:getCommonByKey("COST_TICKET_CONTENT")
				local content = langPara(costTips, name, name)

				TipsFacade.instance:openPopupCostMatViewNew(type, id, num, content, function()
					AnnimatchController.instance:sendPayTheTicket(activityId)
				end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
			end
		else
			TipsFacade.instance:openCommonTips(AnnimatchConfig.instance:getCommonByKey("NOT_IN_OPEN_TIME"))
		end
	else
		TipsFacade.instance:openCommonTips(AnnimatchConfig.instance:getCommonByKey("ACT_TIME_OVER"))
	end
end

function AnnimatchenterView:_onClickBtnVote()
	local activityId = AnnimatchController.instance:getCurrActId()

	UIStateManager.instance:push(ViewName.AnniMatchBanView, activityId)
end

return AnnimatchenterView
