local AutoChessTipsSubItem = class("AutoChessTipsSubItem", ReduxView)

function AutoChessTipsSubItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessTipsSubItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AutoChessTipsSubItem:AddUIListeners()
	TerminologyTools.AddTerminologyHandler(self, self.desc_, self.button_, nil)
end

function AutoChessTipsSubItem:InitUI()
	self:BindCfgUI()
end

function AutoChessTipsSubItem:SetData(arg_5_1, arg_5_2)
	self.buffId_ = arg_5_1
	self.chessItemData_ = arg_5_2

	self:RefreshUI()
end

function AutoChessTipsSubItem:RefreshUI()
	self.name_.text = AutoChessBuffCfg[self.buffId_].name
	self.icon_.sprite = AutoChessTools.GetBuffIcon(AutoChessBuffCfg[self.buffId_].icon)

	AutoChessTools.GetChessBuffDesc(self.chessItemData_, self.buffId_, self.desc_)
end

function AutoChessTipsSubItem:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function AutoChessTipsSubItem:Dispose()
	AutoChessTipsSubItem.super.Dispose(self)
end

return AutoChessTipsSubItem
