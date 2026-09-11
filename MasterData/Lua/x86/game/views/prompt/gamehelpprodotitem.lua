local GameHelpProDotItem = class("GameHelpProDotItem", ReduxView)

function GameHelpProDotItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.selectController_ = self.controllerEx_:GetController("sel")
end

function GameHelpProDotItem:SetData(arg_2_1)
	if arg_2_1 then
		self.selectController_:SetSelectedState("state1")
	else
		self.selectController_:SetSelectedState("state0")
	end
end

function GameHelpProDotItem:Dispose()
	GameHelpProDotItem.super.Dispose(self)
end

return GameHelpProDotItem
