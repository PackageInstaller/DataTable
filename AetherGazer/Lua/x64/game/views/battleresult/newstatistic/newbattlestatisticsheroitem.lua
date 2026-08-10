local var_0_0 = class("NewBattleStatisticsHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.BuildContext(arg_2_0)
	arg_2_0.modeController = arg_2_0.controller_:GetController("default0")
	arg_2_0.heroModule = BattleSettlementHeroHeadModule.New(arg_2_0.heroHeadObj_)
	arg_2_0.data = {}
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:BuildContext()
end

function var_0_0.SetHeroData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.data.index = arg_4_1
	arg_4_0.data.heroData = arg_4_2

	if arg_4_2 then
		arg_4_0.modeController:SetSelectedState("hero")
		arg_4_0.heroModule:ShowCaptain(arg_4_1 == 1)
		arg_4_0.heroModule:SetHeroData(arg_4_2)
		arg_4_0.heroModule:ShowLevel(arg_4_2.level, 1)
	else
		arg_4_0.modeController:SetSelectedState("none")
	end
end

function var_0_0.SetStatisticsData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.data.total = arg_5_1
	arg_5_0.data.max = arg_5_2
	arg_5_0.data.data = arg_5_3

	local var_5_0 = arg_5_3.damage
	local var_5_1 = arg_5_3.hurt
	local var_5_2 = arg_5_3.cure
	local var_5_3 = tonumber(tostring(var_5_0))
	local var_5_4 = tonumber(tostring(var_5_1))
	local var_5_5 = tonumber(tostring(var_5_2))
	local var_5_6 = "%.0f%%"

	if arg_5_0:valuePass(arg_5_1.damage) then
		local var_5_7 = var_5_3 / tonumber(tostring(arg_5_1.damage))

		arg_5_0.attackNumTxt_.text = tostring(var_5_0)
		arg_5_0.attackTxt_.text = string.format(var_5_6, var_5_7 * 100)
		arg_5_0.attackSlider_.value = var_5_7
	else
		arg_5_0.attackNumTxt_.text = tostring(var_5_0)
		arg_5_0.attackTxt_.text = "0%"
		arg_5_0.attackSlider_.value = 0
	end

	if arg_5_0:valuePass(arg_5_1.hurt) then
		local var_5_8 = var_5_4 / tonumber(tostring(arg_5_1.hurt))

		arg_5_0.damageNumTxt_.text = tostring(var_5_1)
		arg_5_0.damageTxt_.text = string.format(var_5_6, var_5_8 * 100)
		arg_5_0.damageSlider_.value = var_5_8
	else
		arg_5_0.damageNumTxt_.text = tostring(var_5_1)
		arg_5_0.damageTxt_.text = "0%"
		arg_5_0.damageSlider_.value = 0
	end

	if arg_5_0:valuePass(arg_5_1.cure) then
		local var_5_9 = var_5_5 / tonumber(tostring(arg_5_1.cure))

		arg_5_0.healNumTxt_.text = tostring(var_5_2)
		arg_5_0.healTxt_.text = string.format(var_5_6, var_5_9 * 100)
		arg_5_0.healSlider_.value = var_5_9
	else
		arg_5_0.healNumTxt_.text = tostring(var_5_2)
		arg_5_0.healTxt_.text = "0%"
		arg_5_0.healSlider_.value = 0
	end
end

function var_0_0.valuePass(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = pcall(function()
		if type(arg_6_1) == "number" then
			return arg_6_1 > 0
		else
			return arg_6_1 > int64.zero
		end
	end)

	if var_6_0 then
		return var_6_1
	else
		return false
	end
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.heroModule:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
