local MardukSpecialRewardView = class("MardukSpecialRewardView", ReduxView)

function MardukSpecialRewardView:UIName()
	return "UI/MardukUI/special/MardukSpecialRewardUI"
end

function MardukSpecialRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function MardukSpecialRewardView:OnCtor()
	return
end

function MardukSpecialRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MardukSpecialRewardView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, MardukSpecialRewardItemView)
end

function MardukSpecialRewardView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.activityIds_[arg_6_1])
end

function MardukSpecialRewardView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function MardukSpecialRewardView:AddEventListeners()
	self:RegistEventListener(MARDUK_SPECIAL_REWARD_UPDATE, function(arg_10_0)
		self:UpdateView()
	end)
end

function MardukSpecialRewardView:OnTop()
	self:UpdateBar()
end

function MardukSpecialRewardView:OnBehind()
	manager.windowBar:HideBar()
end

function MardukSpecialRewardView:UpdateBar()
	self:ShowDefaultBar()
end

function MardukSpecialRewardView:OnEnter()
	self:AddEventListeners()

	self.cfg_ = ActivityCfg[self.params_.activityID]
	self.activityIds_ = self.cfg_.sub_activity_list

	self.uiList_:StartScroll(#self.activityIds_, MardukSpecialData:GetCanGetRewardIndex(self.params_.activityID))
	self:UpdateView()
end

function MardukSpecialRewardView:UpdateView()
	self.getLabel1_.text = MardukSpecialData:GetGotRewardNum(self.activityIds_)
	self.getLabel2_.text = "/" .. 3 * #self.activityIds_
end

function MardukSpecialRewardView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function MardukSpecialRewardView:OnMainHomeViewTop()
	return
end

function MardukSpecialRewardView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	MardukSpecialRewardView.super.Dispose(self)
end

return MardukSpecialRewardView
