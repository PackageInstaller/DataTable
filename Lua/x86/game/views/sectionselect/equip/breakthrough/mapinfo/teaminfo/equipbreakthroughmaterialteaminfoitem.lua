local var_0_0 = class("EquipBreakThroughMaterialTeamInfoItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index_ = arg_1_3

	arg_1_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:RefreshUI()
end

function var_0_0.OnExit(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = EquipBreakThroughMaterialData:GetHeroState()[arg_6_0.index_]

	if var_6_0 == nil then
		arg_6_0:Show(false)

		return
	end

	local var_6_1 = var_6_0.heroID
	local var_6_2 = HeroTools.HeroUsingSkinInfo(var_6_1).id
	local var_6_3 = SkinCfg[var_6_2]

	arg_6_0.image_.sprite = getSpriteViaConfig("HeroIcon", var_6_3.picture_id)

	local var_6_4 = HeroCfg[var_6_1]

	arg_6_0.nameText_.text = string.format("%s·%s", GetI18NText(var_6_4.name), GetI18NText(var_6_4.suffix))

	local var_6_5 = SettingData:GetCurrentLanguage()

	if var_6_5 == "fr" or var_6_5 == "de" then
		arg_6_0.nameText_.text = string.format("%s-%s", GetI18NText(var_6_4.name), GetI18NText(var_6_4.suffix))
	end

	local var_6_6 = HeroData:GetHeroList()[var_6_1]

	arg_6_0.lvText_.text = var_6_6.level or 1
	arg_6_0.hpSlider_.value = var_6_0.rate / 10000

	local var_6_7 = math.ceil(var_6_0.rate / 100)

	if var_6_7 <= 0 and var_6_0.rate > 0 then
		var_6_7 = 1
	end

	arg_6_0.hpText_.text = string.format("%s%%", var_6_7)

	arg_6_0:Show(true)
end

return var_0_0
