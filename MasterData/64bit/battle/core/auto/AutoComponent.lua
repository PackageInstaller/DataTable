local var_0_0 = {}
local var_0_1 = load("const.BattleConst")

var_0_0.auto = {
	false,
	false
}
var_0_0.lastId = 0

function var_0_0.init(arg_1_0)
	arg_1_0.auto = {
		false,
		false
	}
	arg_1_0.lastId = 0
	arg_1_0.lastSuccubaId = 0
end

function var_0_0:setAuto(arg_2_1, arg_2_2)
	self.auto[arg_2_1] = arg_2_2
end

function var_0_0:checkAuto(arg_3_1)
	local var_3_0 = arg_3_1:getFirstAttackId()
	local var_3_1 = self.lastId == 0 and var_3_0 or 3 - self.lastId
	local var_3_2 = self:checkMyAuto(arg_3_1, self.lastId == 0 and var_3_0 or 3 - self.lastId)

	if not var_3_2 then
		var_3_1 = 3 - var_3_1
		var_3_2 = self:checkMyAuto(arg_3_1, var_3_1)
	end

	if var_3_2 then
		self.lastId = var_3_1
	end

	return var_3_2
end

function var_0_0:checkMyAuto(arg_4_1, arg_4_2)
	if self.auto[arg_4_2] then
		local var_4_0 = arg_4_1:getComboInfo(arg_4_2):getCanUseSkillIdForAi(function(arg_5_0)
			return arg_4_1:getSkillEffectComboCostMod(arg_4_2, arg_5_0)
		end)

		if var_4_0 and var_4_0 > 0 then
			return {
				id = var_4_0,
				identity = arg_4_2,
				type = var_0_1.AUTO_TYPE.UNITE
			}
		end
	end
end

function var_0_0:checkMySuccubaAuto(arg_6_1)
	local var_6_0 = arg_6_1:getFirstAttackId()
	local var_6_1 = self.lastSuccubaId == 0 and var_6_0 or 3 - self.lastSuccubaId
	local var_6_2 = self:checkSuccubaAuto(arg_6_1, self.lastSuccubaId == 0 and var_6_0 or 3 - self.lastSuccubaId)

	if not var_6_2 then
		var_6_1 = 3 - var_6_1
		var_6_2 = self:checkSuccubaAuto(arg_6_1, var_6_1)
	end

	if var_6_2 then
		self.lastSuccubaId = var_6_1
	end

	return var_6_2
end

function var_0_0.checkSuccubaAuto(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:getSuccubaInfo(arg_7_2)

	if var_7_0 then
		local var_7_1 = var_7_0:getCanUseSkillIdForAi()

		if var_7_1 and var_7_1 > 0 then
			return {
				id = var_7_1,
				identity = arg_7_2,
				type = var_0_1.AUTO_TYPE.SUCCUBA
			}
		end
	end
end

return var_0_0
