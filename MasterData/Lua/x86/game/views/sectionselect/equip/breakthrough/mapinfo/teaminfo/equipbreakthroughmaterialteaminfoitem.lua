local EquipBreakThroughMaterialTeamInfoItem = class("EquipBreakThroughMaterialTeamInfoItem", ReduxView)

function EquipBreakThroughMaterialTeamInfoItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.index_ = arg_1_3

	self:BindCfgUI()
end

function EquipBreakThroughMaterialTeamInfoItem:OnEnter()
	self:RefreshUI()
end

function EquipBreakThroughMaterialTeamInfoItem:OnExit()
	return
end

function EquipBreakThroughMaterialTeamInfoItem:Dispose()
	EquipBreakThroughMaterialTeamInfoItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function EquipBreakThroughMaterialTeamInfoItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function EquipBreakThroughMaterialTeamInfoItem:RefreshUI()
	local var_6_0 = EquipBreakThroughMaterialData:GetHeroState()[self.index_]

	if var_6_0 == nil then
		self:Show(false)

		return
	end

	local var_6_1 = var_6_0.heroID

	self.image_.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[HeroTools.HeroUsingSkinInfo(var_6_0.heroID).id].picture_id)
	self.nameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[var_6_1].name), GetI18NText(HeroCfg[var_6_1].suffix))

	local var_6_2 = SettingData:GetCurrentLanguage()

	if var_6_2 == "fr" or var_6_2 == "de" then
		self.nameText_.text = string.format("%s-%s", GetI18NText(HeroCfg[var_6_1].name), GetI18NText(HeroCfg[var_6_1].suffix))
	end

	self.lvText_.text = HeroData:GetHeroList()[var_6_1].level or 1
	self.hpSlider_.value = var_6_0.rate / 10000

	local var_6_3 = math.ceil(var_6_0.rate / 100)

	if var_6_3 <= 0 and var_6_0.rate > 0 then
		var_6_3 = 1
	end

	self.hpText_.text = string.format("%s%%", var_6_3)

	self:Show(true)
end

return EquipBreakThroughMaterialTeamInfoItem
