local CatchDuckDetailPopView = class("CatchDuckDetailPopView", ReduxView)

function CatchDuckDetailPopView:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_CatchDuckUI/SummerUI_3_5_CatchDuckEntranceUI"
end

function CatchDuckDetailPopView:UIParent()
	return manager.ui.uiPop.transform
end

function CatchDuckDetailPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CatchDuckDetailPopView:InitUI()
	self:BindCfgUI()
end

function CatchDuckDetailPopView:AddUIListener()
	self:AddBtnListener(self.btnChange_, nil, function()
		return
	end)
end

function CatchDuckDetailPopView:OnEnter()
	self:RefreshUI()
end

function CatchDuckDetailPopView:RefreshUI()
	return
end

function CatchDuckDetailPopView:Dispose()
	CatchDuckDetailPopView.super.Dispose(self)
end

return CatchDuckDetailPopView
