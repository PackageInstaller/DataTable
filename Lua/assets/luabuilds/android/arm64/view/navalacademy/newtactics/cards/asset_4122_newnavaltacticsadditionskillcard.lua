local NewNavalTacticsAdditionSkillCard = class("NewNavalTacticsAdditionSkillCard", import(".NewNavalTacticsSkillCard"))

function NewNavalTacticsAdditionSkillCard:Update(arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1:GetNextLevelExp()
	local var_1_1 = arg_1_1:GetExp()

	arg_1_1:AddExp(arg_1_2)

	local var_1_2 = not not (not arg_1_1:IsMaxLevel() and arg_1_1:IsMaxLevel())
	local var_1_3 = arg_1_1:GetNextLevelExp()
	local var_1_4 = arg_1_1:GetExp()
	local var_1_5 = arg_1_1.level - arg_1_1.level > 0

	arg_1_1.level = arg_1_1.level

	NewNavalTacticsAdditionSkillCard.super.Update(self, arg_1_1, arg_1_1.level - arg_1_1.level)

	self.nextTxt.text = var_1_2 and var_1_1 .. "+<color=#A9F548FF>" .. var_1_0 - var_1_1 .. "</color>/" .. var_1_0 or var_1_5 and "0+<color=#A9F548FF>" .. var_1_4 .. "</color>/" .. var_1_3 or var_1_1 .. "+<color=#A9F548FF>" .. arg_1_2 .. "</color>/" .. var_1_0

	return
end

return NewNavalTacticsAdditionSkillCard
