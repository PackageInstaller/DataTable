local SpringWelfarePrayTreeView = class("SpringWelfarePrayTreeView", ReduxView)

function SpringWelfarePrayTreeView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeUI"
end

function SpringWelfarePrayTreeView:UIParent()
	return manager.ui.uiMain.transform
end

function SpringWelfarePrayTreeView:Init()
	self:BindCfgUI()
	self:AddListeners()
	self:InitBranch()

	self.stageController_ = ControllerUtil.GetController(self.transform_, "stage")

	self.stageController_:SetSelectedState("welfare")

	self.prayController_ = ControllerUtil.GetController(self.prayBtn_.transform, "state")
end

function SpringWelfarePrayTreeView:AddListeners()
	self:AddBtnListener(self.mailBtn_, nil, function()
		JumpTools.OpenPageByJump("springWelfareLetterBox", {})
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("springWelfareTask", {})
	end)
	self:AddBtnListener(self.prayBtn_, nil, function()
		self:TryStartPray()
	end)
end

function SpringWelfarePrayTreeView:InitBranch()
	self.branchList_ = {}

	for iter_8_0 = 1, self:GetDays() do
		local var_8_0 = SpringWelfarePrayBubbleView.New(self[string.format("bubbleGo_%d", iter_8_0)])

		var_8_0:SetData(iter_8_0)
		var_8_0:SetClickHandler(function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
			self:OnClickBubble(iter_8_0, arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		end)

		self.branchList_[iter_8_0] = var_8_0
	end
end

function SpringWelfarePrayTreeView:UpdateBar()
	local var_10_0, var_10_1 = SpringWelfareData:GetPoolSignCost()
	local var_10_2, var_10_3 = SpringWelfareData:GetPoolCost()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_10_0,
		var_10_2
	})
	manager.windowBar:SetBarCanAdd(var_10_0, true)
	manager.windowBar:SetBarCanAdd(var_10_2, true)
	manager.windowBar:SetGameHelpKey("SPRING_BLESSING_DES")
end

function SpringWelfarePrayTreeView:OnEnter()
	self:UpdateBar()

	for iter_11_0, iter_11_1 in ipairs(self.branchList_) do
		iter_11_1:OnEnter()
	end

	local var_11_0 = self:GetActivityID()
	local var_11_1 = ActivityTools.GetRedPointKey(var_11_0) .. var_11_0

	manager.redPoint:bindUIandKey(self.mailBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_LETTER, var_11_1))
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_REWARD, var_11_1))
	self:RefreshUI()
end

function SpringWelfarePrayTreeView:OnTop()
	self:NewDayEffect()
	self:RefreshPrayStateUI()
end

function SpringWelfarePrayTreeView:OnExit()
	manager.windowBar:HideBar()

	for iter_13_0, iter_13_1 in ipairs(self.branchList_) do
		iter_13_1:OnExit()
	end

	local var_13_0 = self:GetActivityID()
	local var_13_1 = ActivityTools.GetRedPointKey(var_13_0) .. var_13_0

	manager.redPoint:unbindUIandKey(self.mailBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_LETTER, var_13_1))
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_REWARD, var_13_1))
end

function SpringWelfarePrayTreeView:Dispose()
	for iter_14_0, iter_14_1 in ipairs(self.branchList_) do
		iter_14_1:Dispose()
	end

	SpringWelfarePrayTreeView.super.Dispose(self)
end

function SpringWelfarePrayTreeView:RefreshUI()
	for iter_15_0, iter_15_1 in ipairs(self.branchList_) do
		iter_15_1:UpdateItemIdList()
		iter_15_1:RefreshItemUiList()
	end

	self:RefreshPrayStateUI()

	local var_15_0 = ActivityData:GetActivityData((self:GetActivityID()))

	self.tipsText_.text = string.format(GetTips("SPRING_BLESSING_SCREEN_TIPS"), manager.time:STimeDescS(var_15_0.startTime, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(var_15_0.stopTime, "!%Y.%m.%d %H:%M"))

	SpringWelfareAction:UpdateRedPoint(self:GetActivityID())
end

function SpringWelfarePrayTreeView:RefreshPrayStateUI()
	local var_16_0 = SpringWelfareData:GetCurPrayDay()
	local var_16_1 = self:GetDays()
	local var_16_2 = SpringWelfareData:GetDayState(var_16_0)
	local var_16_3 = 0
	local var_16_4 = 0

	if var_16_2 == SPRING_WELFARE_DAY_STATE_TYPE.ACQUIRED then
		self.prayController_:SetSelectedState(var_16_0 == var_16_1 and "finish" or "prayed")
		SetActive(self.prayCostGo_, false)

		return
	elseif var_16_2 == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
		var_16_3, var_16_4 = SpringWelfareData:GetPoolSignCost()

		self.prayController_:SetSelectedState("sign")
	elseif var_16_2 == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		var_16_3, var_16_4 = SpringWelfareData:GetPoolCost()

		self.prayController_:SetSelectedState("pray")

		if var_16_4 > ItemTools.getItemNum(var_16_3) then
			if self:CanSign((SpringWelfareData:GetCurSignDay())) then
				var_16_3, var_16_4 = SpringWelfareData:GetPoolSignCost()

				self.prayController_:SetSelectedState("sign")
			end
		end
	end

	SetActive(self.prayCostGo_, true)

	self.prayIcon_.sprite = ItemTools.getItemSprite(var_16_3)
	self.prayInfoText_.text = var_16_4
end

function SpringWelfarePrayTreeView:OnNewDay()
	self:RefreshUI()

	for iter_17_0, iter_17_1 in ipairs(self.branchList_) do
		iter_17_1:RefreshUI()
	end

	if gameContext:GetLastOpenPage() == "springWelfarePrayTree" then
		self:NewDayEffect()
	end
end

function SpringWelfarePrayTreeView:OnActivitySpringWelfareInit()
	self:OnNewDay()
end

function SpringWelfarePrayTreeView:OnTaskListChange()
	SpringWelfareAction:UpdateRedPoint(self:GetActivityID())
end

function SpringWelfarePrayTreeView:OnClickBubble(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	JumpTools.OpenPageByJump("springWelfarePrayBranch", {
		day = arg_20_3
	})
end

function SpringWelfarePrayTreeView:TryStartPray()
	local var_21_0 = SpringWelfareData:GetCurPrayDay()
	local var_21_1 = SpringWelfareData:GetDayState(var_21_0)

	if var_21_1 == SPRING_WELFARE_DAY_STATE_TYPE.ACQUIRED then
		ShowTips("SPRING_WELFARE_ALREADY_PRAY")
	elseif var_21_1 == SPRING_WELFARE_DAY_STATE_TYPE.NOT_ACQUIRE then
		return
	end

	local var_21_2 = false
	local var_21_3 = 0
	local var_21_4 = 0

	if var_21_1 == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
		var_21_3, var_21_4 = SpringWelfareData:GetPoolSignCost()
		var_21_2 = true
	elseif var_21_1 == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		var_21_3, var_21_4 = SpringWelfareData:GetPoolCost()
	end

	if var_21_4 > ItemTools.getItemNum(var_21_3) then
		local var_21_5 = SpringWelfareData:GetCurSignDay()

		if self:CanSign(var_21_5) then
			var_21_0 = var_21_5
			var_21_2 = false
		elseif var_21_3 == 1 then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

			return
		else
			ShowTips("SPRING_WELFARE_PRAY_COST_LACK")

			return
		end
	end

	if not var_21_2 or _G.SkipTip.SkipSpringWelfareResignTip then
		SpringWelfareAction:StartPray(var_21_0, handler(self, self.OnFinishPray))
	else
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					var_21_3,
					var_21_4
				},
				(string.format(GetTips("RESIGN"), var_21_4))
			},
			OkCallback = function()
				SpringWelfareAction:StartPray(var_21_0, handler(self, self.OnFinishPray))
			end,
			ToggleCallback = function(arg_23_0)
				_G.SkipTip.SkipSpringWelfareResignTip = arg_23_0
			end,
			toggleText = GetTips("LOGIN_MUTE_TIP")
		})
	end
end

function SpringWelfarePrayTreeView:OnFinishPray(arg_24_1)
	self:PlayEffect(function()
		self:RefreshUI()

		for iter_25_0, iter_25_1 in ipairs(self.branchList_) do
			iter_25_1:RefreshUI()
		end
	end)
end

function SpringWelfarePrayTreeView:PlayEffect(arg_26_1)
	if self.prayAni_ then
		self.isAniPlaying_ = true

		manager.windowBar:HideBar()
		SetActive(self.prayAniGo_, true)
		self.prayAni_:Play("IndiaWishingTreeUI_sign", -1, 0)
		self.prayAni_:Update(0)
		AnimatorTools.PlayAnimationWithCallback(self.prayAni_, "IndiaWishingTreeUI_sign", function()
			self.isAniPlaying_ = false

			SetActive(self.prayAniGo_, false)
			self:UpdateBar()
			arg_26_1()
		end)
	else
		arg_26_1()
	end
end

function SpringWelfarePrayTreeView:NewDayEffect()
	local var_28_0 = SpringWelfareData:GetNextNewSystemLetterId()

	if not var_28_0 then
		return
	end

	local var_28_1 = SpringWelfareData:GetLetterData(var_28_0)

	if var_28_1 and not var_28_1.gotReward then
		JumpTools.OpenPageByJump("springWelfareSystemLetter", {
			gotReward = false,
			firstView = true,
			letterServerId = var_28_0
		})
	end
end

function SpringWelfarePrayTreeView:GetDays()
	return SpringPreheatData:GetMaxProgress()
end

function SpringWelfarePrayTreeView:GetActivityID()
	return SpringWelfareData:GetActivityId()
end

function SpringWelfarePrayTreeView:CanSign(arg_31_1)
	arg_31_1 = arg_31_1 or SpringWelfareData:GetCurSignDay()

	if arg_31_1 < 0 then
		return false
	end

	local var_31_0, var_31_1 = SpringWelfareData:GetPoolSignCost()

	if var_31_1 > ItemTools.getItemNum(var_31_0) then
		return false
	end

	return true
end

return SpringWelfarePrayTreeView
