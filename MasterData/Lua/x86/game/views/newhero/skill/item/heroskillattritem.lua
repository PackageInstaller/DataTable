local HeroSkillAttrItem = class("HeroSkillAttrItem", ReduxView)
local var_0_1 = {
	showState = {
		max = "max",
		name = "showState",
		normal = "normal"
	}
}

function HeroSkillAttrItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function HeroSkillAttrItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controllerexcollection_:GetController(var_0_1.showState.name)
end

function HeroSkillAttrItem:RefreshUI(arg_3_1, arg_3_2)
	if PublicAttrCfg[arg_3_1.attrType] then
		self.descText_.text = PublicAttrCfg[arg_3_1.attrType].name or ""
	end

	self.valuenowText_.text = arg_3_1.nowValue / 10 .. "%"
	self.valuelaterText_.text = arg_3_1.nextValue / 10 .. "%"

	self.stateController_:SetSelectedState(arg_3_2 == false and var_0_1.showState.max or arg_3_1.nextValue ~= 0 and var_0_1.showState.normal or var_0_1.showState.max)
end

function HeroSkillAttrItem:Dispose()
	HeroSkillAttrItem.super.Dispose(self)
end

return HeroSkillAttrItem
