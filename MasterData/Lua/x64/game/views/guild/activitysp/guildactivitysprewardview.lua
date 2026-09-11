local GuildActivitySPRewardView = class("GuildActivitySPRewardView", ReduxView)

function GuildActivitySPRewardView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPRewardPop"
end

function GuildActivitySPRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildActivitySPRewardView:Init()
	self:InitUI()
	self:AddUIListener()

	self.receiveHandler_ = handler(self, self.OnGuildActivityReceiveRateReward)
end

function GuildActivitySPRewardView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function GuildActivitySPRewardView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, GuildActivitySPRewardItem)
end

function GuildActivitySPRewardView:OnEnter()
	GuildActivitySPLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true
	self.activityID_ = self.params_.activityID
	self.rateIDList_ = GuildActivitySPData:GetSortedRateIDList(self.activityID_)

	self.scrollHelper_:StartScroll(#self.rateIDList_)
end

function GuildActivitySPRewardView:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.rateIDList_[arg_8_1], self.activityID_)
	arg_8_2:setReceiveCallBack(self.receiveHandler_)
end

function GuildActivitySPRewardView:Dispose()
	self.scrollHelper_:Dispose()
	GuildActivitySPRewardView.super.Dispose(self)
end

function GuildActivitySPRewardView:OnGuildActivityReceiveRateReward()
	self.rateIDList_ = GuildActivitySPData:GetSortedRateIDList(self.activityID_)

	GuildActivitySPAction.UpdataHadAwardRedPoint(self.activityID_)
	self.scrollHelper_:StartScroll(#self.rateIDList_)
end

return GuildActivitySPRewardView
