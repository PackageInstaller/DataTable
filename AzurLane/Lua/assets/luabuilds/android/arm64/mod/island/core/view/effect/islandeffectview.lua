import = var_0_10000

local var_0_0 = var_0_10000(".IslandRecEnergyEffect")

class = var_0_10001

local var_0_1 = "IslandEffectView"

import = var_0_10004

local var_0_2 = var_0_10001(var_0_1, var_0_10004("..IslandBaseHudView"))
local var_0_3 = {
	var_0_0
}

function var_0_2.GetUIName(arg_1_0)
	return "IslandEffectUI"
end

function var_0_2.OnInit(arg_2_0, arg_2_1)
	var_0_2.super.OnInit(arg_2_0, arg_2_1)

	arg_2_0.effects = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(var_0_3) do
		local var_2_0 = iter_2_1.New(arg_2_0._tf)

		arg_2_0.effects[var_2_0:GetType()] = var_2_0
	end

	return
end

function var_0_2.Play(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0.effects[arg_3_3] then
		var_4:Play(arg_3_1, arg_3_2)
	end

	return
end

function var_0_2.OnLateUpdate(arg_4_0)
	var_0_2.super.OnLateUpdate(arg_4_0)

	pairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.effects) do
		iter_4_1:Update()
	end

	return
end

function var_0_2.OnDispose(arg_5_0)
	pairs = var_1_10001

	local var_5_0

	if not arg_5_0.effects then
		var_5_0 = {}
	end

	for iter_5_0, iter_5_1 in var_1_10001(var_5_0) do
		iter_5_1:Dispose()
	end

	arg_5_0.effects = nil

	var_0_2.super.OnDispose(arg_5_0)

	return
end

return var_0_2
