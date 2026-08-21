local var_0_0 = class("NewNavalTacticsAdditionSkillCard", import(".NewNavalTacticsSkillCard"))

function var_0_0.Update(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1:GetNextLevelExp()
	local var_1_1 = arg_1_1:GetExp()

	arg_1_1:AddExp(arg_1_2)

	local var_1_2 = false

	if not arg_1_1:IsMaxLevel() and arg_1_1:IsMaxLevel() then
		var_1_2 = true
	end

	local var_1_3 = arg_1_1:GetNextLevelExp()
	local var_1_4 = arg_1_1:GetExp()
	local var_1_5 = arg_1_1.level - arg_1_1.level
	local var_1_6 = arg_1_1.level - arg_1_1.level > 0

	arg_1_1.level = arg_1_1.level

	var_0_0.super.Update(arg_1_0, arg_1_1, var_1_5)

	arg_1_0.nextTxt.text = var_1_2 and var_1_1 .. "+<color=#A9F548FF>" .. var_1_0 - var_1_1 .. "</color>/" .. var_1_0 or var_1_6 and "0+<color=#A9F548FF>" .. var_1_4 .. "</color>/" .. var_1_3 or var_1_1 .. "+<color=#A9F548FF>" .. arg_1_2 .. "</color>/" .. var_1_0

	return
end

return var_0_0
