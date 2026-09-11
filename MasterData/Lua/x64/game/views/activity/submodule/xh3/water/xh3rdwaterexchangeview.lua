local XH3rdWaterExchangeView = class("XH3rdWaterExchangeView", ReduxView)

function XH3rdWaterExchangeView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPPopUI"
end

function XH3rdWaterExchangeView:UIParent()
	return manager.ui.uiPop.transform
end

function XH3rdWaterExchangeView:OnCtor()
	return
end

function XH3rdWaterExchangeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH3rdWaterExchangeView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uilistGo_, XH3rdWaterExchangeItemView)
end

function XH3rdWaterExchangeView:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.taskIdList_[arg_6_1], self.params_.activityID)
end

function XH3rdWaterExchangeView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function XH3rdWaterExchangeView:AddEventListeners()
	self:RegistEventListener(ACTIVITY_WATER_SELF_ASSISTANT_REWARD_UPDATE, function()
		self:UpdateView()
	end)
end

function XH3rdWaterExchangeView:OnWaterResult(arg_11_1)
	JumpTools.OpenPageByJump("/xH3rdWaterResult", {
		activityID = arg_11_1
	})
end

function XH3rdWaterExchangeView:OnTop()
	self:UpdateBar()
end

function XH3rdWaterExchangeView:OnBehind()
	manager.windowBar:HideBar()
end

function XH3rdWaterExchangeView:UpdateBar()
	self:ShowDefaultBar()
end

function XH3rdWaterExchangeView:OnEnter()
	self:AddEventListeners()
	self:UpdateView()
end

function XH3rdWaterExchangeView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function XH3rdWaterExchangeView:UpdateView()
	self.taskIdList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[self.params_.activityID]

	self.uiList_:StartScroll(#self.taskIdList_)
end

function XH3rdWaterExchangeView:OnMainHomeViewTop()
	return
end

function XH3rdWaterExchangeView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	XH3rdWaterExchangeView.super.Dispose(self)
end

return XH3rdWaterExchangeView
