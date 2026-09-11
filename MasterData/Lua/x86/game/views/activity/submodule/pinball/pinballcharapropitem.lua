local PinballCharaPropItem = class("PinballCharaPropItem", BaseView)

function PinballCharaPropItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PinballCharaPropItem:Init()
	self:BindCfgUI()
end

function PinballCharaPropItem:UpdatePropValueText(arg_3_1, arg_3_2, arg_3_3)
	self.value_.text = arg_3_3 and GetTipsF("PINBALL_HERO_ATTRIBUTE_NEXT_LEVEL", arg_3_1, arg_3_3) or GetTipsF("PINBALL_HERO_ATTRIBUTE", arg_3_1)
end

function PinballCharaPropItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_1 then
		self.name_.text = arg_4_1
	end

	self:UpdatePropValueText(arg_4_2, arg_4_3, arg_4_4)

	self.bar_.minValue = 0
	self.bar_.maxValue = arg_4_3 or 200
	self.bar_.value = arg_4_2
end

return PinballCharaPropItem
