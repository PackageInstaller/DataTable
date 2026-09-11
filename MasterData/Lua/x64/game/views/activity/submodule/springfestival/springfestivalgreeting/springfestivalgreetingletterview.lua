local SpringFestivalGreetingLetterView = class("SpringFestivalGreetingLetterView", ReduxView)

function SpringFestivalGreetingLetterView:UIName()
	return "UI/EmptyDream/letter/EDream_letterpop_2"
end

function SpringFestivalGreetingLetterView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringFestivalGreetingLetterView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.adaptImg_ = self:FindCom("AdaptImage", nil, self.portraitImage_.transform)
	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function SpringFestivalGreetingLetterView:OnEnter()
	self:RefreshUI()
end

function SpringFestivalGreetingLetterView:OnExit()
	return
end

function SpringFestivalGreetingLetterView:Dispose()
	SpringFestivalGreetingLetterView.super.Dispose(self)
	self.commonItemView_:Dispose()

	self.commonItemView_ = nil
end

function SpringFestivalGreetingLetterView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		local var_9_0 = self:GetActivityID()

		if not ActivityData:GetActivityIsOpen(var_9_0) then
			ShowTips("TIME_OVER")

			return
		end

		SpringFestivalGreetingAction.GetGreetingReward(var_9_0, ActivityPointRewardCfg.get_id_list_by_activity_id[var_9_0][SpringFestivalGreetingData:GetUnlockCnt(var_9_0)], function(arg_10_0)
			if isSuccess(arg_10_0.result) then
				getReward2(arg_10_0.reward_list)
				self:RefreshReceiveState()
			else
				ShowTips(arg_10_0.result)
			end
		end)
	end)
end

function SpringFestivalGreetingLetterView:GetActivityID()
	return ActivityConst.SPRING_FESTIVAL_GREETING
end

function SpringFestivalGreetingLetterView:RefreshUI()
	local var_12_0 = self:GetActivityID()
	local var_12_1 = SpringFestivalGreetingData:GetUnlockCnt(var_12_0)

	self.portraitImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/letter_role_title/" .. SkinCfg[ActivitySpringFestivalGreetingCfg[ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[var_12_0][var_12_1]].story_name].picture_id)
	self.titleText_.text = string.format(GetTips("ACTIVITY_HERO_PRESENT"), GetI18NText(HeroCfg[SkinCfg[ActivitySpringFestivalGreetingCfg[ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[var_12_0][var_12_1]].story_name].hero].suffix))
	self.greetingText_.text = GetI18NText(ActivitySpringFestivalGreetingCfg[ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[var_12_0][var_12_1]].story_word)

	local var_12_2 = ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[var_12_0][var_12_1]].reward_item_list[1]

	if self.commonItemView_ == nil then
		self.commonItemView_ = CommonItem.New(self.itemGo_)
	end

	self.commonItemView_:RefreshData(formatReward(ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[var_12_0][var_12_1]].reward_item_list[1]))
	self.commonItemView_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_12_2)
	end)
	self:RefreshReceiveState()
end

function SpringFestivalGreetingLetterView:RefreshReceiveState()
	local var_14_0 = self:GetActivityID()

	if SpringFestivalGreetingData:GetReceiveCnt(var_14_0) == SpringFestivalGreetingData:GetUnlockCnt(var_14_0) then
		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end
end

return SpringFestivalGreetingLetterView
