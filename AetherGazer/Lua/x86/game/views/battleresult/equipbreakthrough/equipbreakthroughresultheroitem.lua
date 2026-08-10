local var_0_0 = class("EquipBrealThroughResultHeroItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:BindCfgUI()
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.stageData_ = arg_2_1

	arg_2_0:RefreshUI()
end

function var_0_0.OnExit(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = arg_5_0.stageData_:GetHeroTeam()
	local var_5_1 = arg_5_0.stageData_:GetSystemHeroTeam()

	if var_5_0[arg_5_0.index_] == nil or var_5_0[arg_5_0.index_] == 0 then
		SetActive(arg_5_0.gameObject_, false)

		return
	end

	SetActive(arg_5_0.gameObject_, true)

	local var_5_2 = HeroTools.HeroUsingSkinInfo(var_5_0[arg_5_0.index_])

	arg_5_0.icon_.sprite = getSpriteViaConfig("HeroIcon", var_5_2.picture_id)
	arg_5_0.lvText_.text = HeroData:GetHeroData(var_5_0[arg_5_0.index_]).level

	local var_5_3 = EquipBreakThroughMaterialData:GetHeroState()[arg_5_0.index_] and EquipBreakThroughMaterialData:GetHeroState()[arg_5_0.index_].rate or 10000

	arg_5_0.slider_.value = var_5_3 / 10000

	local var_5_4 = math.ceil(var_5_3 / 100)

	if var_5_3 > 0 and var_5_4 < 1 then
		var_5_4 = 1
	end

	arg_5_0.rateText_.text = string.format("%s%%", var_5_4)
end

return var_0_0
