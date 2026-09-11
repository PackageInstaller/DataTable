local SpringFestivalGreetingEnvelopView = class("SpringFestivalGreetingEnvelopView", ReduxView)

function SpringFestivalGreetingEnvelopView:UIName()
	return "UI/EmptyDream/letter/EDream_letterpop"
end

function SpringFestivalGreetingEnvelopView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringFestivalGreetingEnvelopView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function SpringFestivalGreetingEnvelopView:OnEnter()
	self:RefreshUI()
end

function SpringFestivalGreetingEnvelopView:OnExit()
	return
end

function SpringFestivalGreetingEnvelopView:Dispose()
	SpringFestivalGreetingEnvelopView.super.Dispose(self)
	self.commonItemView_:Dispose()

	self.commonItemView_ = nil
end

function SpringFestivalGreetingEnvelopView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function SpringFestivalGreetingEnvelopView:GetActivityID()
	return ActivityConst.SPRING_FESTIVAL_GREETING
end

function SpringFestivalGreetingEnvelopView:RefreshUI()
	if self.commonItemView_ == nil then
		self.commonItemView_ = CommonItem.New(self.itemGo_)
	end

	local var_10_0 = self:GetActivityID()
	local var_10_1 = ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[var_10_0][SpringFestivalGreetingData:GetUnlockCnt(var_10_0)]].reward_item_list[1]

	self.commonItemView_:RefreshData(formatReward(var_10_1))
	self.commonItemView_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_10_1)
	end)

	self.cntText_.text = string.format("%s/%s", SpringFestivalGreetingData:GetReceiveCnt(var_10_0), #ActivityPointRewardCfg.get_id_list_by_activity_id[var_10_0])

	self:RefreshTimeText()
end

function SpringFestivalGreetingEnvelopView:RefreshTimeText()
	local var_12_0 = ActivityData:GetActivityData((self:GetActivityID()))

	self.timeText_.text = string.format("%s——%s", manager.time:STimeDescS(var_12_0.startTime, "!%m/%d %H:%M"), manager.time:STimeDescS(var_12_0.stopTime, "!%m/%d %H:%M"))

	local var_12_1 = manager.time:GetServerTime()

	if var_12_1 < var_12_0.startTime or var_12_0.stopTime < var_12_1 then
		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end
end

return SpringFestivalGreetingEnvelopView
