local SpringPreheatPrayTreeView = class("SpringPreheatPrayTreeView", ReduxView)

function SpringPreheatPrayTreeView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeUI"
end

function SpringPreheatPrayTreeView:UIParent()
	return manager.ui.uiMain.transform
end

function SpringPreheatPrayTreeView:Init()
	self:BindCfgUI()
	self:AddListeners()
	self:RegistEventListener(NEW_DAY, handler(self, self.OnNewDay))
	self:InitBranch()

	self.stageController_ = ControllerUtil.GetController(self.transform_, "stage")

	self.stageController_:SetSelectedState("preheat")
end

function SpringPreheatPrayTreeView:AddListeners()
	self:AddBtnListener(self.previewBtn_, nil, function()
		JumpTools.OpenPageByJump("springPreheatPrayPreview", {})
	end)
end

function SpringPreheatPrayTreeView:InitBranch()
	self.branchList_ = {}

	for iter_6_0 = 1, self:GetDays() do
		local var_6_0 = SpringPreheatPrayBubbleView.New(self[string.format("bubbleGo_%d", iter_6_0)])

		var_6_0:SetData(iter_6_0)
		var_6_0:SetClickHandler(function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
			self:OnClickBubble(iter_6_0, arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		end)

		self.branchList_[iter_6_0] = var_6_0
	end
end

function SpringPreheatPrayTreeView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
		JumpTools.Back()
	end)

	for iter_8_0, iter_8_1 in ipairs(self.branchList_) do
		iter_8_1:OnEnter()
	end

	self:RefreshUI()
end

function SpringPreheatPrayTreeView:OnExit()
	manager.windowBar:HideBar()

	for iter_10_0, iter_10_1 in ipairs(self.branchList_) do
		iter_10_1:OnExit()
	end
end

function SpringPreheatPrayTreeView:Dispose()
	for iter_11_0, iter_11_1 in ipairs(self.branchList_) do
		iter_11_1:Dispose()
	end

	SpringPreheatPrayTreeView.super.Dispose(self)
end

function SpringPreheatPrayTreeView:RefreshUI()
	for iter_12_0, iter_12_1 in ipairs(self.branchList_) do
		iter_12_1:UpdateItemIdList()
		iter_12_1:RefreshItemUiList()
		iter_12_1:RefreshUI()
	end

	local var_12_0 = ActivityData:GetActivityData((SpringPreheatData:GetWelfareActivityId()))

	self.tipsText_.text = string.format(GetTips("SPRING_BLESSING_SCREEN_TIPS"), manager.time:STimeDescS(var_12_0.startTime, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(var_12_0.stopTime, "!%Y.%m.%d %H:%M"))
end

function SpringPreheatPrayTreeView:OnClickBubble(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	local var_13_0 = SpringPreheatData:GetDayState(arg_13_3)

	if var_13_0 == 1 then
		ShowTips(string.format(GetTips("SPRING_PREHEAT_REWARD_BUBBLE_LOCKED"), arg_13_3))
	elseif var_13_0 == 2 then
		ShowTips(string.format(GetTips("SPRING_PREHEAT_REWARD_BUBBLE_NOT_READY"), arg_13_3))
	elseif var_13_0 == 3 then
		JumpTools.OpenPageByJump("SpringPreheatPraySelectReward", {
			maxSelectCount = 2,
			onSelectionConfirmed = function(arg_14_0)
				self:RefreshUI()
			end
		})
	elseif var_13_0 == 4 then
		JumpTools.OpenPageByJump("springPreheatPrayBranch", {
			day = arg_13_3
		})
	end
end

function SpringPreheatPrayTreeView:OnNewDay()
	self:RefreshUI()
end

function SpringPreheatPrayTreeView:GetDays()
	return SpringPreheatData:GetMaxProgress()
end

return SpringPreheatPrayTreeView
