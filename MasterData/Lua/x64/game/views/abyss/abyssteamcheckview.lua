local AbyssTeamCheckView = class("AbyssTeamCheckView", ReduxView)

function AbyssTeamCheckView:UIName()
	return "Widget/System/Challenge_Abyss/AbyssTeamCheckUI"
end

function AbyssTeamCheckView:UIParent()
	return manager.ui.uiPop.transform
end

function AbyssTeamCheckView:OnCtor()
	return
end

function AbyssTeamCheckView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssTeamCheckView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, AbyssTeamCheckItemView)
end

function AbyssTeamCheckView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.layerInfo_.layer, self.layerInfo_.userId, self.layerInfo_.stageInfos[arg_6_1])
end

function AbyssTeamCheckView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function AbyssTeamCheckView:AddEventListeners()
	return
end

function AbyssTeamCheckView:OnTop()
	self:UpdateBar()
end

function AbyssTeamCheckView:OnBehind()
	manager.windowBar:HideBar()
end

function AbyssTeamCheckView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AbyssTeamCheckView:OnEnter()
	self.layerInfo_ = self.params_.layerInfo

	self:AddEventListeners()
	self:UpdateView()
end

function AbyssTeamCheckView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function AbyssTeamCheckView:UpdateView()
	self.layerLabel_.text = string.format(GetTips("ABYSS_LAYER_LABEL"), GetI18NText(self.layerInfo_.layer))

	self.uiList_:StartScroll(#self.layerInfo_.stageInfos)
end

function AbyssTeamCheckView:OnMainHomeViewTop()
	return
end

function AbyssTeamCheckView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	AbyssTeamCheckView.super.Dispose(self)
end

return AbyssTeamCheckView
