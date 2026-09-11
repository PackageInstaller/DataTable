local PaChinKoPopView = class("PaChinKoPopView", ReduxView)

function PaChinKoPopView:UIName()
	return PaChinKoTools.GetCfg(self.params_.mainActivityID).pop_prefab_path
end

function PaChinKoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function PaChinKoPopView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function PaChinKoPopView:OnEnter()
	return
end

function PaChinKoPopView:OnExit()
	return
end

function PaChinKoPopView:Dispose()
	PaChinKoPopView.super.Dispose(self)
end

function PaChinKoPopView:AddListeners()
	self:AddBtnListener(self.uiCloseBtn_, nil, function()
		self:Back()
	end)
end

return PaChinKoPopView
