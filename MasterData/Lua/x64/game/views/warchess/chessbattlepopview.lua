local ChessBattlePopView = class("ChessBattlePopView", ReduxView)

function ChessBattlePopView:UIName()
	return "Widget/System/WarChess_Battle/WarChessBattlePopUI"
end

function ChessBattlePopView:UIParent()
	return manager.ui.uiMain.transform
end

function ChessBattlePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBattlePopView:InitUI()
	self:BindCfgUI()
end

function ChessBattlePopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
		self.info_.MaskCallback()
	end)
	self:AddBtnListener(self.btnOK_, nil, function()
		self:Back()
		self.info_.OkCallback()
	end)
	self:AddBtnListener(self.btnCancel_, nil, function()
		self:Back()
		self.info_.CancelCallback()
	end)
end

function ChessBattlePopView:RefreshUI()
	self.contentText_.text = GetI18NText(self.info_.content)
end

function ChessBattlePopView:OnEnter()
	manager.ui:SetMainCamera(WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].scene_id, true)

	self.info_ = self.params_

	self:RefreshUI()
end

function ChessBattlePopView:OnExit()
	return
end

function ChessBattlePopView:Dispose()
	ChessBattlePopView.super.Dispose(self)
end

return ChessBattlePopView
