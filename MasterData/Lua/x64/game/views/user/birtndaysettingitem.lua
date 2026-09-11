local BirtndaySettingItem = class("BirtndaySettingItem", ReduxView)

function BirtndaySettingItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:BindCfgUI()

	self.controller = ControllerUtil.GetController(self.gameObject_.transform, "state")
end

function BirtndaySettingItem:RefreshUI(arg_2_1, arg_2_2)
	self.text_.text = arg_2_1
	self.bigText_.text = arg_2_1

	self.controller:SetSelectedState(arg_2_1 == arg_2_2 and "on" or "off")
end

return BirtndaySettingItem
