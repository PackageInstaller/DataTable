local DodgeBarrageMainView = class("DodgeBarrageMainView", ReduxView)

function DodgeBarrageMainView:UIName()
	return "Widget/Version/ShashwatUI_3_7/ShashwatUI_3_7_BarrageUI/ShashwatUI_3_7_BarrageMainUI"
end

function DodgeBarrageMainView:UIParent()
	return manager.ui.uiMain.transform
end

function DodgeBarrageMainView:Init()
	self:InitUI()
	self:AddUIListeners()

	self.stageDiff_ = 1
	self.hardStageStartIndex_ = #ActivityDodgeBarrageCfg.get_id_list_by_diff[0] + 1
end

function DodgeBarrageMainView:InitUI()
	self:BindCfgUI()

	self.stageScroll_ = LuaList.New(handler(self, self.IndexItem), self.stageListGo_, DodgeBarrageStageItem)

	self.stageScroll_:SetPageChangeHandler(handler(self, self.SelectStage))

	self.lockController_ = self.itemCon_:GetController("lock")
	self.reachController_ = self.itemCon_:GetController("reach")
	self.bgController_ = self.itemCon_:GetController("bg")
	self.targetScoreController_ = self.itemCon_:GetController("targetScore")
	self.diffController_ = self.diffCon_:GetController("difficulty")
	self.targetScoreCon_ = {}
	self.targetScoreText_ = {}

	for iter_4_0 = 1, 3 do
		self.targetScoreCon_[iter_4_0] = self["scoreCon_" .. iter_4_0]:GetController("reach")
		self.targetScoreText_[iter_4_0] = self["scoreText_" .. iter_4_0]
	end
end

function DodgeBarrageMainView:AddUIListeners()
	self:AddBtnListener(self.btnDesc_, nil, function()
		local var_6_0 = {
			content = GetTips("ACTIVITY_DODGE_BARRAGE_DESC")
		}

		var_6_0.key = "ACTIVITY_DODGE_BARRAGE_DESC"

		JumpTools.OpenPageByJump("gameHelp", var_6_0)
	end)
	self:AddBtnListener(self.btnTask_, nil, function()
		JumpTools.OpenPageByJump("dodgeBarrageTaskView")
	end)
	self:AddBtnListener(self.btnGoBattle_, nil, function()
		JumpTools.OpenPageByJump("/sectionSelectHero", {
			section = self.selectItem_:GetStageData().id,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_DODGE_BARRAGE,
			activityID = self.activityId_
		})
	end)
	self:AddBtnListener(self.btnNormal_, nil, function()
		self:RefreshScore(self.hardStageStartIndex_)
	end)
	self:AddBtnListener(self.btnHard_, nil, function()
		self:RefreshScore(self.hardStageStartIndex_ + 1)
	end)
	self:AddBtnListener(self.btnHardest_, nil, function()
		self:RefreshScore(self.hardStageStartIndex_ + 2)
	end)
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
		if self.selectItem_ then
			self.selectItem_:UnSelectItem()

			self.selectItem_ = nil
		end
	end))
end

function DodgeBarrageMainView:OnEnter()
	self.activityId_ = DodgeBarrageData:GetActivityId()
	self.redPointKey_ = DodgeBarrageData:GetRedPointKey()

	manager.redPoint:bindUIandKey(self.btnTask_.transform, self.redPointKey_)
	self:RefreshLastStage()
	self:RefreshData()
	self:RefreshTime()
end

function DodgeBarrageMainView:RefreshLastStage()
	local var_14_0 = DodgeBarrageData:GetLastStage()

	self.stageIndex_ = var_14_0 ~= 0 and var_14_0 or 1
end

function DodgeBarrageMainView:RefreshData()
	self.stageList_ = clone(ActivityDodgeBarrageCfg.all)

	self.stageScroll_:StartScroll(#self.stageList_)
end

function DodgeBarrageMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ActivityTools.JumpBackToActivityMainViewByTheme(ActivityCfg[self.activityId_].activity_theme)
	end)
end

function DodgeBarrageMainView:RefreshTime()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	self.remainTime = ActivityData:GetActivityData(self.activityId_).stopTime
	self.activityTime_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.remainTime)
	self.updateTimer_ = Timer.New(function()
		self.activityTime_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.remainTime)
	end, 1, self.remainTime - manager.time:GetServerTime() + 1, 1)

	self.updateTimer_:Start()
end

function DodgeBarrageMainView:IndexItem(arg_20_1, arg_20_2)
	arg_20_2:RefreshUI(arg_20_1, self.stageList_[arg_20_1], self.stageIndex_)
	arg_20_2:RegisterClick(function(arg_21_0)
		self.stageScroll_:SwitchToPage(arg_21_0)
	end)

	if arg_20_1 == #self.stageList_ then
		self.stageScroll_:SwitchToPage(self.stageIndex_)
		SetActive(self.scoreGo_, true)
	end
end

function DodgeBarrageMainView:SelectStage(arg_22_1)
	if self.selectItem_ then
		self.selectItem_:UnSelectItem()

		self.selectItem_ = nil
	end

	self.stageIndex_ = arg_22_1
	self.selectItem_ = self.stageScroll_:GetItemByIndex(arg_22_1)

	self.selectItem_:SelectItem()

	self.isNormal_ = self.selectItem_:GetIsNormal()

	self.bgController_:SetSelectedState(self.isNormal_ and "normal" or "hard")

	self.lockText_.text = self.selectItem_:GetLockText()

	self.lockController_:SetSelectedState(self.selectItem_:GetIsLock() and "lock" or "unlock")
	self:RefreshScore(self.stageIndex_)
end

function DodgeBarrageMainView:RefreshScore(arg_23_1)
	local var_23_0 = ActivityDodgeBarrageCfg[arg_23_1]
	local var_23_1 = DodgeBarrageData:GetStageScore(ActivityDodgeBarrageCfg[arg_23_1].stage_id) or 0

	self.stageMaxScore_.text = var_23_1 or 0

	self.targetScoreController_:SetSelectedState(#var_23_0.targetScore)

	for iter_23_0, iter_23_1 in ipairs(var_23_0.targetScore) do
		self.targetScoreText_[iter_23_0].text = iter_23_1

		self.targetScoreCon_[iter_23_0]:SetSelectedState(iter_23_1 <= var_23_1 and "show" or "hide")
	end

	self.reachController_:SetSelectedState(var_23_1 >= var_23_0.targetScore[#var_23_0.targetScore] and "show" or "hide")
end

function DodgeBarrageMainView:OnExit()
	manager.redPoint:unbindUIandKey(self.btnTask_.transform, self.redPointKey_)

	self.selectItem_ = nil
	self.stageDiff_ = 1

	manager.windowBar:HideBar()
	SetActive(self.scoreGo_, false)
end

function DodgeBarrageMainView:Dispose()
	DodgeBarrageMainView.super.Dispose(self)

	if self.stageScroll_ then
		self.stageScroll_:Dispose()

		self.stageScroll_ = nil
	end

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

return DodgeBarrageMainView
