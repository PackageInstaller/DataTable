local CombineGamePoolPopView = class("CombineGamePoolPopView", ReduxView)

function CombineGamePoolPopView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfPrizeUI"
end

function CombineGamePoolPopView:UIParent()
	return manager.ui.uiPop.transform
end

function CombineGamePoolPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGamePoolPopView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetRewardItem), self.listGo_, KagutsuchiGachaRewardItem)
end

function CombineGamePoolPopView:SetRewardItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.activityId, self.poolId, KagutsuchiGachaData:GetAllDrawItemIds(self.poolId)[arg_5_1])
end

function CombineGamePoolPopView:AddUIListener()
	self:AddBtnListener(self.bgmask_, nil, function()
		self:Back()
	end)
end

function CombineGamePoolPopView:OnEnter()
	self.activityId = self.params_.activityId
	self.poolId = self.params_.poolId

	self:UpdateView()
end

function CombineGamePoolPopView:UpdateView()
	self.list:StartScroll(#KagutsuchiGachaData:GetAllDrawItemIds(self.poolId))

	self.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_POOL_NAME")
end

function CombineGamePoolPopView:OnExit()
	manager.windowBar:HideBar()
end

function CombineGamePoolPopView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CombineGamePoolPopView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	CombineGamePoolPopView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGamePoolPopView
