ys = ys or {}

local var_0_0 = ys.Battle.BattleAttr
local var_0_1 = class("BattleBuffTaunt", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffTaunt = var_0_1
var_0_1.__name = "BattleBuffTaunt"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._tauntActive = false

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._guardTargetFilter = arg_2_0._tempData.arg_list.guardTarget
	arg_2_0._handleCloak = arg_2_1:GetCloak() ~= nil

	return
end

function var_0_1.onTrigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0

	if not arg_3_0._handleCloak then
		do return end

		var_3_0 = true
	end

	for iter_3_0, iter_3_1 in ipairs((arg_3_0:getTargetList(arg_3_1, arg_3_0._guardTargetFilter, arg_3_0._tempData.arg_list))) do
		var_3_0 = var_3_0 and var_0_0.IsCloak(iter_3_1)
	end

	if not var_3_0 and not arg_3_0._tauntActive then
		arg_3_0:forceToExpose(arg_3_1)
	elseif var_3_0 and arg_3_0._tauntActive then
		arg_3_0:releaseExpose(arg_3_1)
	end

	return
end

function var_0_1.onRemove(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:releaseExpose(arg_4_1)

	return
end

function var_0_1.forceToExpose(arg_5_0, arg_5_1)
	if not arg_5_0._handleCloak then
		return
	end

	arg_5_0._tauntActive = true

	local var_5_0 = arg_5_1:GetCloak()

	var_5_0:ForceToMax()
	var_5_0:UpdateTauntExpose(true)

	return
end

function var_0_1.releaseExpose(arg_6_0, arg_6_1)
	if not arg_6_0._handleCloak then
		return
	end

	arg_6_0._tauntActive = false

	arg_6_1:GetCloak():UpdateTauntExpose(false)

	return
end

return
