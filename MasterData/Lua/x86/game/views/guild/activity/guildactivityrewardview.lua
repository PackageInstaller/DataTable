local GuildActivityRewardView = class("GuildActivityRewardView", ReduxView)

function GuildActivityRewardView:UIName()
	return "UI/GuildActivityUI/GuildActivityRewardPop"
end

function GuildActivityRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildActivityRewardView:Init()
	self:InitUI()
	self:AddUIListener()

	self.receiveHandler_ = handler(self, self.OnGuildActivityReceiveRateReward)
end

function GuildActivityRewardView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function GuildActivityRewardView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, GuildActivityRewardItem)
end

function GuildActivityRewardView:OnEnter()
	GuildActivityLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true
	self.activityID_ = self.params_.activityID
	self.rateIDList_ = GuildActivityData:GetSortedRateIDList(self.activityID_)

	self.scrollHelper_:StartScroll(#self.rateIDList_)
end

function GuildActivityRewardView:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.rateIDList_[arg_8_1], self.activityID_)
	arg_8_2:setReceiveCallBack(self.receiveHandler_)
end

function GuildActivityRewardView:Dispose()
	self.scrollHelper_:Dispose()
	GuildActivityRewardView.super.Dispose(self)
end

function GuildActivityRewardView:OnGuildActivityReceiveRateReward()
	self.rateIDList_ = GuildActivityData:GetSortedRateIDList(self.activityID_)

	self.scrollHelper_:StartScroll(#self.rateIDList_)
end

return GuildActivityRewardView
