local AutoChessTipsSepcSubItem = class("AutoChessTipsSepcSubItem", ReduxView)

function AutoChessTipsSepcSubItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessTipsSepcSubItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AutoChessTipsSepcSubItem:AddUIListeners()
	TerminologyTools.AddTerminologyHandler(self, self.desc_, self.button_, nil)
end

function AutoChessTipsSepcSubItem:InitUI()
	self:BindCfgUI()
	self:InitController()
end

function AutoChessTipsSepcSubItem:InitController()
	self.lvController_ = self.controllerEx_:GetController("lv")
end

function AutoChessTipsSepcSubItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.buffId_ = arg_6_1
	self.index_ = arg_6_2
	self.chessItemData_ = arg_6_3

	self:RefreshUI()
end

function AutoChessTipsSepcSubItem:RefreshUI()
	AutoChessTools.GetChessBuffDesc(self.chessItemData_, self.buffId_, self.desc_)
	self.lvController_:SetSelectedIndex(self.index_ - 1)
end

function AutoChessTipsSepcSubItem:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function AutoChessTipsSepcSubItem:Dispose()
	AutoChessTipsSepcSubItem.super.Dispose(self)
end

return AutoChessTipsSepcSubItem
