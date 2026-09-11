local ChessReviveItem = class("ChessReviveItem", ReduxView)

function ChessReviveItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChessReviveItem:Init()
	self.isOn_ = false

	self:InitUI()
	self:AddUIListener()
end

function ChessReviveItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "select")
end

function ChessReviveItem:RefreshUI(arg_4_1, arg_4_2)
	self.index_ = arg_4_2
	self.headImg_.sprite = getSpriteViaConfig("HeroLittleIcon", arg_4_1)
end

function ChessReviveItem:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self.func_(self.index_)
	end)
end

function ChessReviveItem:RegisterListener(arg_7_1)
	self.func_ = arg_7_1
end

function ChessReviveItem:ShowSelect(arg_8_1)
	if arg_8_1 then
		self.controller_:SetSelectedState("sel")

		self.isOn_ = true
	else
		self.controller_:SetSelectedState("nor")

		self.isOn_ = false
	end
end

function ChessReviveItem:Dispose()
	ChessReviveItem.super.Dispose(self)
end

return ChessReviveItem
