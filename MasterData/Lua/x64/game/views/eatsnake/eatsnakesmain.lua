local EatSnakesMainView = class("EatSnakesMainView", ReduxView)

function EatSnakesMainView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_3_10_SnakegameMainUI"
end

function EatSnakesMainView:UIParent()
	return manager.ui.uiMain.transform
end

function EatSnakesMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EatSnakesMainView:InitUI()
	self:BindCfgUI()

	self.btnController_ = self.btnCon_:GetController("lock")
	self.targetController_ = {}
	self.targetText_ = {}

	for iter_4_0 = 1, 3 do
		self.targetText_[iter_4_0] = self["condition" .. iter_4_0 .. "Txt_"]
		self.targetController_[iter_4_0] = self["condition" .. iter_4_0 .. "Controller_"]:GetController("lock")
	end

	self.stageItemList_ = {}

	for iter_4_1 = 1, 7 do
		self.stageItemList_[iter_4_1] = EatSnakeStageItem.New(self["stage_" .. iter_4_1])
	end

	self:InitScrollView()
end

function EatSnakesMainView:InitScrollView()
	self.scrollView_ = StageScrollView.New(self.scrollViewGo_)

	self.scrollView_:RegistPointerUp(handler(self, self.CloseStageView))
	self.scrollView_:RegistBeginDrag(handler(self, self.CloseStageView))
end

function EatSnakesMainView:AddUIListener()
	self:AddBtnListener(self.viewBtn_, nil, function()
		if self.isOpen then
			self:CloseStageView()
		end

		JumpTools.GoToSystem("/eatSnakesShow", {
			activityId = self.activityId
		})
	end)
	self:AddBtnListener(self.studyBtn_, nil, function()
		if self.isOpen then
			self:CloseStageView()
		end

		JumpTools.GoToSystem("eatSnakesTask", {
			activityId = self.activityId
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		EatSnakeAction.PlayEatSnakeGame(ActivityEatSnakeCfg[ActivityEatSnakeCfg.all[self.selectIndex]].id)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:CloseStageView()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:CloseStageView()
	end)
end

function EatSnakesMainView:callbackFunction(arg_12_1, arg_12_2)
	self.selectIndex = arg_12_1

	if self.selectItem_ then
		self.selectItem_.selectController:SetSelectedState("off")
	end

	self.selectItem_ = arg_12_2

	self.selectItem_.selectController:SetSelectedState("on")
	SetActive(self.chapterGo_, true)
	self:MoveStageContent(arg_12_2.transform_.position)
	self:UpdateStageView()
end

function EatSnakesMainView:MoveStageContent(arg_13_1)
	self.scrollView_:MoveContentScreenPosXDelta(UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, arg_13_1).x - Screen.width / 2, 0.09)
end

function EatSnakesMainView:UpdateStageView()
	self.isOpen = true

	local var_14_0 = ActivityEatSnakeCfg[ActivityEatSnakeCfg.all[self.selectIndex]]
	local var_14_1 = self.stageData[self.selectIndex]

	for iter_14_0 = 1, 3 do
		self.targetText_[iter_14_0].text = ConditionCfg[ActivityEatSnakeCfg[ActivityEatSnakeCfg.all[self.selectIndex]].target_list[iter_14_0]].desc

		self.targetController_[iter_14_0]:SetSelectedState((not var_14_1 or iter_14_0 > var_14_1.target) and "lock" or "unlock")
	end

	self.stageTxt_.text = GetI18NText(ActivityEatSnakeCfg[ActivityEatSnakeCfg.all[self.selectIndex]].name)

	if self.openTimer_ then
		self.openTimer_:Stop()

		self.openTimer_ = nil
	end

	local var_14_2 = ActivityData:GetActivityData(ActivityEatSnakeCfg[ActivityEatSnakeCfg.all[self.selectIndex]].activity_id).startTime

	local function var_14_3()
		if not ActivityData:GetActivityIsOpen(var_14_0.activity_id) then
			self.btnController_:SetSelectedState("true")

			self.lockText_.text = var_14_2 < manager.time:GetServerTime() and GetTips("TIME_OUT") or string.format(GetTips("SNAKEGAME_STAGE_LOCK_2"), manager.time:GetLostTimeStr(var_14_2))
		elseif self.selectIndex > 1 and self.stageData[self.selectIndex - 1] == nil then
			self.btnController_:SetSelectedState("true")

			self.lockText_.text = GetTips("SNAKEGAME_STAGE_LOCK")
		else
			self.btnController_:SetSelectedState("false")
		end
	end

	var_14_3()

	self.openTimer_ = Timer.New(function()
		var_14_3()
	end, 1, -1, 1)

	self.openTimer_:Start()
end

function EatSnakesMainView:OnEnter()
	self:UpdateData()
	self:UpdateView()
	self:UpdateStageItem()
	self:BindRedPoint()
end

function EatSnakesMainView:UpdateData()
	self.stageData = EatSnakeData:GetDataByPara("stageList")
	self.activityId = EatSnakeData:GetDataByPara("activityID")
end

function EatSnakesMainView:UpdateView()
	self.contentTrans_.anchoredPosition = EatSnakeData:GetEnterPos() or Vector2(0, 0)

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	SetActive(self.chapterGo_, false)

	local var_19_0 = ActivityData:GetActivityData(self.activityId).stopTime

	self.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(var_19_0, true)
	self.updateTimer_ = Timer.New(function()
		self.remainTxt_.text = manager.time:GetServerTime() < var_19_0 and GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(var_19_0, true) or GetTips("TIME_OUT")
	end, 1, -1, 1)
	self.activityTitle_.text = GetI18NText(ActivityCfg[self.activityId].remark)

	self.updateTimer_:Start()
end

function EatSnakesMainView:UpdateStageItem()
	for iter_21_0, iter_21_1 in ipairs(self.stageItemList_) do
		iter_21_1:SetData(iter_21_0, self.stageData[iter_21_0], #self.stageData, self, ActivityEatSnakeCfg[ActivityEatSnakeCfg.all[iter_21_0]], handler(self, self.callbackFunction))
	end
end

function EatSnakesMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.studyBtn_.transform, RedPointConst.EAT_SNAKE_TASK)
end

function EatSnakesMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.studyBtn_.transform, RedPointConst.EAT_SNAKE_TASK)
end

function EatSnakesMainView:CloseStageView()
	if self.isOpen then
		self.isOpen = false

		SetActive(self.chapterGo_, false)

		if self.selectItem_ then
			self.selectItem_.selectController:SetSelectedState("off")
		end

		self.scrollView_:Recover()
	end

	if self.openTimer_ then
		self.openTimer_:Stop()

		self.openTimer_ = nil
	end
end

function EatSnakesMainView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnComplete(nil)
		LeanTween.cancel(self.content_.gameObject)

		self.tween_ = nil
	end
end

function EatSnakesMainView:OnExit()
	EatSnakeData:SetEnterPos(self.contentTrans_.anchoredPosition)

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	if self.openTimer_ then
		self.openTimer_:Stop()

		self.openTimer_ = nil
	end

	self.isOpen = false

	self:UnbindRedPoint()
	self.scrollView_:OnExit()
	manager.windowBar:HideBar()
end

function EatSnakesMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("SNAKEGAME_GAMEPLAY_DESC")
	self.scrollView_:Recover()
end

function EatSnakesMainView:Dispose()
	for iter_28_0, iter_28_1 in pairs(self.stageItemList_) do
		iter_28_1:Dispose()

		iter_28_1 = nil
	end

	self.stageItemList_ = nil

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	if self.openTimer_ then
		self.openTimer_:Stop()

		self.openTimer_ = nil
	end

	self.scrollView_:Dispose()

	self.scrollView_ = nil

	EatSnakesMainView.super.Dispose(self)
end

return EatSnakesMainView
