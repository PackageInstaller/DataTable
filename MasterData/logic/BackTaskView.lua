-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/BackTaskView.lua

module("logic.extensions.playerreturn.view.BackTaskView", package.seeall)

local BackTaskView = class("BackTaskView", TableViewComponent)

function BackTaskView:ctor()
	BackTaskView.super.ctor(self)

	self._taskItemList = nil
	self._allTaskCfgs = nil
end

function BackTaskView:bindEvents()
	BackTaskView.super.bindEvents(self)
	self._receiveBtn:AddClickListener(self._onClickReceiveBtn, self)
	self._listsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.BackList)
	end, self)
	self._leftBtn:AddClickListener(function()
		self:_onClickLeftOrRigthBtn(true)
	end, self)
	self._rightBtn:AddClickListener(function()
		self:_onClickLeftOrRigthBtn(false)
	end, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "backtask")
	end, self)

	for i = 1, #self._taskItemList do
		if self._taskItemList[i] and self._taskItemList[i].shareBtn then
			self._taskItemList[i].shareBtn:AddClickListener(function()
				self:_onClickShareBtn(i)
			end, self)
		end
	end

	self._btnShare:AddClickListener(self._onClickShareURL, self)
end

function BackTaskView:unbindEvents()
	BackTaskView.super.unbindEvents(self)
	self._receiveBtn:RemoveClickListener()
	self._listsBtn:RemoveClickListener()
	self._leftBtn:RemoveClickListener()
	self._rightBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()

	for i = 1, #self._taskItemList do
		if self._taskItemList[i] and self._taskItemList[i].shareBtn then
			self._taskItemList[i].shareBtn:RemoveClickListener()
		end
	end

	self._btnShare:RemoveClickListener()
end

function BackTaskView:onExit()
	BackTaskView.super.onExit(self)
	self:_setLeftAndRightTween(true)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBackTaskBase, self._updataTaskViewShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBackGainPrize, self._updataLeftInfoShow, self)
	removetimer(self._calculationSurplusTime, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil
end

function BackTaskView:destroyUI()
	BackTaskView.super.destroyUI(self)

	self._taskItemList = nil
	self._allTaskCfgs = nil
end

function BackTaskView:buildUI()
	BackTaskView.super.buildUI(self)

	self._timerTxt = goutil.findChildTextComponent(self.mainGO, "timerGo/timerTxt")
	self._tipsBtn = self:getBtn("tipsBtn")

	local leftInfoGo = self:getGo("leftInfoGo")

	self._gradeTxt = goutil.findChildTextComponent(leftInfoGo, "gradeGo/gradeTxt")
	self._scoreSli = goutil.findChildComponent(leftInfoGo, "scoreSli", "Slider")
	self._scoreTxt = goutil.findChildTextComponent(leftInfoGo, "scoreTxt")
	self._receiveBtn = Framework.ButtonAdapter.GetFrom(leftInfoGo, "receiveBtn")
	self._receiveTxt = goutil.findChildTextComponent(leftInfoGo, "receiveBtn/receiveTxt")
	self._listsBtn = Framework.ButtonAdapter.GetFrom(leftInfoGo, "listsBtn")
	self._leftBtn = Framework.ButtonAdapter.GetFrom(leftInfoGo, "leftBtn")
	self._leftIconGo = goutil.findChild(leftInfoGo, "leftBtn/leftIconGo")
	self._rightBtn = Framework.ButtonAdapter.GetFrom(leftInfoGo, "rightBtn")
	self._rightIconGo = goutil.findChild(leftInfoGo, "rightBtn/rightIconGo")

	local rightInfoGo = self:getGo("rightInfoGo")

	self._taskItemList = {}

	local go

	for i = 1, 4 do
		go = goutil.findChild(rightInfoGo, "taskItem_" .. i)

		if go then
			self._taskItemList[i] = {
				itemGo = go,
				descTxt = goutil.findChildTextComponent(go, "descTxt"),
				shareBtn = Framework.ButtonAdapter.GetFrom(go, "shareBtn"),
				limitTxt = goutil.findChildTextComponent(go, "limitTxt")
			}
		end
	end

	self._btnShare = self:getBtn("btnShare")
end

function BackTaskView:onEnter()
	BackTaskView.super.onEnter(self)

	if GameUtil.getUserDayData("RP_BackTaskView") ~= 1 then
		GameUtil.saveUserDayData("RP_BackTaskView", 1)
		RedPointModel.instance:updateAllRedPoint()
	end

	self._leftTweenPos = UnityTweens.TweenPosition.Create(self._leftIconGo, Vector3.New(5, 0, 0), Vector3.New(-5, 0, 0), 0.8, UnityTweens.EaseType.easeInCubic)
	self._leftTweenFade = UnityTweens.UITweenFade.Create(self._leftIconGo, 1, 0.4, 0.8, UnityTweens.EaseType.easeInCubic)
	self._rightTweenPos = UnityTweens.TweenPosition.Create(self._rightIconGo, Vector3.New(-5, 0, 0), Vector3.New(5, 0, 0), 0.8, UnityTweens.EaseType.easeInCubic)
	self._rightTweenFade = UnityTweens.UITweenFade.Create(self._rightIconGo, 1, 0.4, 0.8, UnityTweens.EaseType.easeInCubic)
	self._leftTweenPos.loopType = UnityTweens.LoopType.pingPong
	self._leftTweenFade.loopType = UnityTweens.LoopType.pingPong
	self._rightTweenPos.loopType = UnityTweens.LoopType.pingPong
	self._rightTweenFade.loopType = UnityTweens.LoopType.pingPong

	GlobalDispatcher:addListener(GlobalNotify.UpdataBackTaskBase, self._updataTaskViewShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataBackGainPrize, self._updataLeftInfoShow, self)

	local actId = PlayerReturnConfig.instance:getOpenActivityId()

	self._actCfg = PlayerReturnConfig.instance:getBackActivityCfg(actId)

	self:_updataTaskViewShow()
	self:_showActivityTimer()

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.mainGO.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
	PlayerReturnController.instance:csGetCIGetActInfoReq()
end

function BackTaskView:_updataTaskViewShow()
	self._slideIndex = nil

	self:_updataLeftInfoShow()
	self:_updataRightInfoShow()
end

function BackTaskView:_onClickLeftOrRigthBtn(isLeft)
	if isLeft then
		if self._slideIndex <= 1 then
			return
		end

		self._slideIndex = self._slideIndex - 1
	else
		if self._slideIndex >= self._allCount then
			return
		end

		self._slideIndex = self._slideIndex + 1
	end

	self:_updataLeftInfoShow()
end

function BackTaskView:_updataLeftInfoShow()
	self._backInfo = PlayerReturnModel.instance:getBackTaskInfo()

	local prizeCfg, count = PlayerReturnModel.instance:getBackPrizeInfo(self._actCfg.prizePlan, self._slideIndex)

	if prizeCfg == nil then
		self._slideIndex = nil
		self._curViewDatas = {}
		self._scoreTxt.text = ""
		self._scoreSli.value = 0

		GameUtil.SetActive(self._receiveBtn, false)
		self:_setLeftAndRightTween(true)
	else
		GameUtil.SetActive(self._receiveBtn, true)

		if checknumber(self._slideIndex) <= 0 then
			self._slideIndex = prizeCfg.prizeId
		end

		self._getPrizeType = 1
		self._allCount = count

		uGuiUtil.setImageGrayState(self._receiveBtn.gameObject, true)
		uGuiUtil.setTextGrayState(self._receiveTxt.gameObject, true)

		if self._backInfo then
			if self._backInfo.prizeIds and table.indexof(self._backInfo.prizeIds, self._slideIndex) then
				self._getPrizeType = 3
			elseif self._backInfo.score >= prizeCfg.scoreReq then
				self._getPrizeType = 2

				uGuiUtil.setImageGrayState(self._receiveBtn.gameObject, false)
				uGuiUtil.setTextGrayState(self._receiveTxt.gameObject, false)
			end

			self._scoreTxt.text = self._backInfo.score .. "/" .. prizeCfg.scoreReq
			self._scoreSli.value = self._backInfo.score / prizeCfg.scoreReq
		else
			self._scoreTxt.text = "0/" .. prizeCfg.scoreReq
			self._scoreSli.value = 0
		end

		self._curViewDatas = string.split(prizeCfg.prize, "#")

		self:_setLeftAndRightTween(false)
	end

	self._gradeTxt.text = langPara("text_recall_desc_34", ConstString.ChineseNumber[checknumber(self._slideIndex)])

	self._tableview:ReloadData()
end

function BackTaskView:_setLeftAndRightTween(isReset)
	if isReset then
		self._leftTweenPos:Stop()
		self._leftTweenFade:Stop()
		self._rightTweenPos:Stop()
		self._rightTweenFade:Stop()
		GameUtil.SetActive(self._leftBtn, false)
		GameUtil.SetActive(self._rightBtn, false)

		return
	end

	if self._slideIndex <= 1 then
		self._leftTweenPos:Stop()
		self._leftTweenFade:Stop()
		GameUtil.SetActive(self._leftBtn, false)
		GameUtil.SetActive(self._rightBtn, true)
		self._rightTweenPos:Begin()
		self._rightTweenFade:Begin()
	elseif self._slideIndex >= self._allCount then
		self._rightTweenPos:Stop()
		self._rightTweenFade:Stop()
		GameUtil.SetActive(self._rightBtn, false)
		GameUtil.SetActive(self._leftBtn, true)
		self._leftTweenPos:Begin()
		self._leftTweenFade:Begin()
	else
		GameUtil.SetActive(self._leftBtn, true)
		GameUtil.SetActive(self._rightBtn, true)
		self._leftTweenPos:Begin()
		self._leftTweenFade:Begin()
		self._rightTweenPos:Begin()
		self._rightTweenFade:Begin()
	end
end

function BackTaskView:_onClickReceiveBtn()
	if self._getPrizeType <= 1 then
		FloatWordMgr.instance:show(lang("text_halloween_desc_11"))

		return
	end

	if self._getPrizeType >= 3 then
		FloatWordMgr.instance:show(lang("mail_got"))

		return
	end

	PlayerReturnController.instance:csGetCIGainPrizeReq(self._slideIndex)
end

function BackTaskView:_updataRightInfoShow()
	if self._allTaskCfgs == nil or #self._allTaskCfgs == 0 then
		self._allTaskCfgs = PlayerReturnConfig.instance:getBackTaskCfg(self._actCfg.inviteLimitPlan)
	end

	self._baseInfo = PlayerReturnModel.instance:getBackTaskInfo()

	for i = 1, #self._allTaskCfgs do
		if self._allTaskCfgs[i] and self._taskItemList[i] then
			self._taskItemList[i].descTxt.text = string.format(self._allTaskCfgs[i].desc, PlayerReturnModel.instance:_getTaskGradeName(i), self._allTaskCfgs[i].scorePrize)

			local sup = math.max(self._allTaskCfgs[i].timesLimit - self:_getTaskGradeLimit(i), 0)

			self._taskItemList[i].limitTxt.text = checknumber(self._allTaskCfgs[i].limitType) == 2 and langPara("text_recall_desc_40", sup, self._allTaskCfgs[i].timesLimit) or langPara("text_recall_desc_39", sup, self._allTaskCfgs[i].timesLimit)

			local isGray = sup <= 0

			uGuiUtil.setImageGrayState(self._taskItemList[i].shareBtn.gameObject, isGray)
			uGuiUtil.setTextGrayState(self._taskItemList[i].limitTxt.gameObject, isGray)
		end
	end
end

function BackTaskView:_getTaskGradeLimit(index)
	if self._baseInfo == nil then
		return 0
	end

	if index < 4 then
		for _, info in pairs(self._baseInfo.inviteTimesInfos or {}) do
			if info and info.type == index then
				return info.times
			end
		end

		return 0
	end

	if index == 4 then
		return checknumber(self._baseInfo.accUseCodeTimes)
	end

	return 0
end

function BackTaskView:_onClickShareBtn(index)
	if self._allTaskCfgs == nil or self._allTaskCfgs[index] == nil then
		return
	end

	if not ((self._allTaskCfgs[index].timesLimit > 0 and self._allTaskCfgs[index].timesLimit <= self:_getTaskGradeLimit(index) or nil) and false) then
		FloatWordMgr.instance:show(lang("text_recall_desc_35"))

		return
	end

	if index >= 4 then
		UIStateManager.instance:push(ViewName.BackCode)
	else
		UIStateManager.instance:push(ViewName.BackShare, self._baseInfo.myCode)
	end
end

function BackTaskView:_onClickShareURL()
	local bgImageName = "share_01"

	UIStateManager.instance:push(ViewName.ShareQRCode, bgImageName, url)
end

function BackTaskView:_showActivityTimer()
	removetimer(self._calculationSurplusTime, self)

	local actCfg = ActivityDefineConfig.instance:getCfgById(PlayerReturnModel.instance.backActType, PlayerReturnModel.instance.backActId)

	if actCfg == nil or actCfg.endTime == nil then
		self._timerTxt.text = lang("text_equip_desc_1")

		return
	end

	self._timeEnd = GameUtil.string2time(actCfg.endTime)

	if self._timeEnd <= ServerTime.now() then
		self._timerTxt.text = lang("text_equip_desc_1")
	else
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function BackTaskView:_calculationSurplusTime()
	local supTime = self._timeEnd - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = lang("text_equip_desc_1")

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and langPara("text_countdown_min", day, hour, min) or langPara("text_countdown_second", hour, min, sec)
end

function BackTaskView:_getPath()
	return {
		cellPath = "leftInfoGo/goodsItem",
		viewPath = "leftInfoGo/goodsItemSR"
	}
end

function BackTaskView:_cellSize()
	return 122, 148
end

function BackTaskView:_updateCell(view, cell, data)
	local goodsPos = goutil.findChild(cell, "goodsPos")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local receiveGo = goutil.findChild(cell, "receiveGo")

	MaterialMgr.resetAll(goodsPos)

	nameTxt.text = MaterialMgr.getMaterialsNameByCfg(data)

	MaterialMgr.setCellByCfg(data, goodsPos)

	if self._getPrizeType == 2 then
		GameUtil.SetActive(receiveGo, false)
	elseif self._getPrizeType == 3 then
		GameUtil.SetActive(receiveGo, true)
	else
		GameUtil.SetActive(receiveGo, false)
	end
end

return BackTaskView
