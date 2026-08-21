local var_0_0 = class("IslandEffectView", import("..IslandBaseHudView"))
local var_0_1 = {
	(import(".IslandRecEnergyEffect"))
}

function var_0_0.GetUIName(arg_1_0)
	return "IslandEffectUI"
end

function var_0_0.OnInit(arg_2_0, arg_2_1)
	var_0_0.super.OnInit(arg_2_0, arg_2_1)

	arg_2_0.effects = {}

	for iter_2_0, iter_2_1 in ipairs(var_0_1) do
		local var_2_0 = iter_2_1.New(arg_2_0._tf)
		local var_2_1 = var_2_0:GetType()

		arg_2_0.effects[var_2_1] = var_2_0
	end

	return
end

function var_0_0.Play(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0.effects[arg_3_3] then
		arg_3_0.effects[arg_3_3]:Play(arg_3_1, arg_3_2)
	end

	return
end

function var_0_0.OnLateUpdate(arg_4_0)
	var_0_0.super.OnLateUpdate(arg_4_0)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.effects) do
		iter_4_1:Update()
	end

	return
end

function var_0_0.OnDispose(arg_5_0)
	local var_5_0 = arg_5_0.effects or {}

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		iter_5_1:Dispose()
	end

	arg_5_0.effects = nil

	var_0_0.super.OnDispose(arg_5_0)

	return
end

return var_0_0
