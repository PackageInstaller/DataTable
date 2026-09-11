local TowerStageView = class("TowerStageView", ReduxView)

function TowerStageView:UIName()
	return "Widget/System/Tower/TowerStageUI"
end

function TowerStageView:UIParent()
	return manager.ui.uiMain.transform
end

function TowerStageView:Init()
	self:InitUI()
end

function TowerStageView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.indexItem), self.m_list, TowerStageItem)
end

function TowerStageView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
end

function TowerStageView:OnEnter()
	self.chapterClientID_ = 401
	self.data = ChapterClientCfg.get_id_list_by_toggle[self.chapterClientID_]

	if TowerData:GetTowerStageViewScrollPos() then
		self.list:StartScrollByPosition(#self.data, TowerData:GetTowerStageViewScrollPos())
	else
		self.list:StartScroll(#self.data)
	end

	TowerAction.CancelTowerRedPoint()
end

function TowerStageView:OnExit()
	manager.windowBar:HideBar()
end

function TowerStageView:indexItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.data[arg_8_1], arg_8_1)
	arg_8_2:RegistCallBack(handler(self, self.OnItemClick))
end

function TowerStageView:OnItemClick()
	TowerData:CacheTowerStageViewScrollPos(self.list:GetScrolledPosition())
end

function TowerStageView:Dispose()
	TowerData:CacheTowerStageViewScrollPos(nil)
	self.list:Dispose()
	TowerStageView.super.Dispose(self)
end

return TowerStageView
