local DamageTestModeItem = class("DamageTestModeItem", ReduxView)

function DamageTestModeItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "chooseItem")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
end

function DamageTestModeItem:Dispose()
	DamageTestModeItem.super.Dispose(self)
end

function DamageTestModeItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_(self.index_)
		end
	end)
end

function DamageTestModeItem:RefreshUI(arg_5_1)
	self:SetSelectMode(self.index_ == arg_5_1)
end

function DamageTestModeItem:SetSelectMode(arg_6_1)
	if arg_6_1 then
		self.selectController_:SetSelectedState("on")
	else
		self.selectController_:SetSelectedState("off")
	end
end

function DamageTestModeItem:RegistClickFunc(arg_7_1)
	self.clickFunc_ = arg_7_1
end

return DamageTestModeItem
