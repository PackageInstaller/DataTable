local HeroAttributeItemView = class("HeroAttributeItemView", ReduxView)

function HeroAttributeItemView:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.textName_.text = GetI18NText(PublicAttrCfg[arg_1_4].name)

	SetActive(self.attributeImg_.gameObject, arg_1_4 >= 151 and arg_1_4 <= 158)

	if arg_1_4 >= 151 and arg_1_4 <= 158 then
		self.attributeImg_.sprite = HeroTools.GetSkillAttributeIcon(arg_1_4 % 151 * 2)
	end

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")

	if arg_1_3 % 2 == 1 then
		self.controller_:SetSelectedState("0")
	else
		self.controller_:SetSelectedState("1")
	end

	self.attributeID_ = arg_1_4
end

function HeroAttributeItemView:SetData(arg_2_1)
	self.textNum_.text = PublicAttrCfg[self.attributeID_].percent == 1 and string.format("%.2f%%", arg_2_1 / 10) or math.floor(arg_2_1)
end

function HeroAttributeItemView:Dispose()
	HeroAttributeItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return HeroAttributeItemView
