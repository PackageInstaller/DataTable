local CanteenGainItem = class("CanteenGainItem", ReduxView)

function CanteenGainItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)

	SetActive(self.gameObject_, true)

	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function CanteenGainItem:InitUI()
	self:BindCfgUI()
end

function CanteenGainItem:RefreshUI(arg_3_1)
	local var_3_0

	if arg_3_1.skillType ~= CanteenConst.HeroSkillType.FoodCostQucik then
		if arg_3_1.skillType == CanteenConst.HeroSkillType.FoodCostRise then
			local var_3_1 = DormSkillData:GetSkillEffect(arg_3_1.skillType, nil, nil, arg_3_1.foodType)

			var_3_0 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[arg_3_1.skillType].desc), tostring((CanteenTools:GetFootTypeName(arg_3_1.foodType))))
			var_3_0 = var_3_0 .. (var_3_1 > 0 and string.format(GetI18NText(BackHomeHeroSkillDescCfg[arg_3_1.skillType].pos_desc), string.format("<color=#e48a00>" .. var_3_1 .. "</color>")) or string.format(GetI18NText(BackHomeHeroSkillDescCfg[arg_3_1.skillType].neg_desc), string.format("<color=#e48a00>" .. -var_3_1 .. "</color>")))
		elseif arg_3_1.skillType == CanteenConst.HeroSkillType.PopularRise then
			local var_3_3 = DormSkillData:GetSkillEffect(arg_3_1.skillType)

			var_3_0 = GetI18NText(BackHomeHeroSkillDescCfg[arg_3_1.skillType].desc)
			var_3_0 = var_3_0 .. (var_3_3 > 0 and string.format(GetI18NText(BackHomeHeroSkillDescCfg[arg_3_1.skillType].pos_desc), string.format("<color=#e48a00>" .. var_3_3 .. "</color>")) or string.format(GetI18NText(BackHomeHeroSkillDescCfg[arg_3_1.skillType].neg_desc), string.format("<color=#e48a00>" .. -var_3_3 .. "</color>")))
		end
	end

	self.desc.text = var_3_0
end

function CanteenGainItem:Dispose()
	Object.Destroy(self.gameObject_)
	CanteenGainItem.super.Dispose(self)
end

return CanteenGainItem
