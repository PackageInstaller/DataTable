class = var_0_10000

local var_0_0 = var_0_10000("MetaTacticsInfo")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	if arg_1_1 then
		arg_1_0.shipID = arg_1_1.ship_id
		arg_1_0.curDayExp = arg_1_1.exp
		arg_1_0.curSkillID = arg_1_1.skill_id
		arg_1_0.skillExpInfoTable = {}
		ipairs = var_2

		for iter_1_0, iter_1_1 in var_2(arg_1_1.skill_exp) do
			local var_1_0 = iter_1_1.skill_id
			local var_1_1 = iter_1_1.exp

			arg_1_0.skillExpInfoTable[var_1_0] = var_1_1
		end
	else
		arg_1_0.shipID = nil
		arg_1_0.curDayExp = 0
		arg_1_0.curSkillID = nil
		arg_1_0.skillExpInfoTable = {}
	end

	return
end

function var_0_0.updateExp(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.day_exp
	local var_2_1 = arg_2_1.skill_id
	local var_2_2 = arg_2_1.skill_exp

	arg_2_0.curDayExp = var_2_0
	arg_2_0.skillExpInfoTable[var_2_1] = var_2_2

	return
end

function var_0_0.setNewExp(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.skillExpInfoTable[arg_3_1] = arg_3_2

	arg_3_0:printInfo()

	return
end

function var_0_0.switchSkill(arg_4_0, arg_4_1)
	arg_4_0.curSkillID = arg_4_1

	return
end

function var_0_0.unlockSkill(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.skillExpInfoTable[arg_5_1] = 0

	if arg_5_2 then
		arg_5_0.curSkillID = arg_5_1
	end

	return
end

function var_0_0.getSkillExp(arg_6_0, arg_6_1)
	local var_6_0

	if not arg_6_0.skillExpInfoTable[arg_6_1] then
		var_6_0 = 0
	end

	return var_6_0
end

function var_0_0.isExpMaxPerDay(arg_7_0)
	local var_7_0 = arg_7_0.curDayExp

	pg = var_1_10002

	return var_7_0 >= var_1_10002.gameset.meta_skill_exp_max.key_value
end

function var_0_0.isAnyLearning(arg_8_0)
	local var_8_0

	if arg_8_0.curSkillID then
		var_8_0 = arg_8_0.curSkillID > 0
	end

	return var_8_0
end

var_0_0.States = {
	LearnAble = 1,
	LearnFinished = 3,
	Learning = 2,
	None = 0
}

function var_0_0.getTacticsStateForShow(arg_9_0)
	local var_9_0 = arg_9_0:isAnyLearning()

	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_9_1 = var_1_10002(var_1_10004)

	if var_2.getShipById(var_9_1, arg_9_0.shipID) then
		local var_9_2 = var_2
		local var_9_3

		if not var_2.isAllMetaSkillLevelMax(var_9_2) then
			var_9_3 = false
		end

		if not var_9_0 and not var_9_3 then
			return var_0_0.States.LearnAble
		elseif var_9_0 then
			getProxy = var_9_1
			BayProxy = var_1_10006

			local var_9_4 = var_9_1(var_1_10006)
			local var_9_5 = var_4.getShipById(var_9_4, arg_9_0.shipID)

			if var_4.isSkillLevelMax(var_9_5, arg_9_0.curSkillID) then
				if not var_9_3 then
					getProxy = var_9_2
					BayProxy = var_7

					local var_9_6 = var_9_2(var_7)
					local var_9_7 = var_5.getShipById(var_9_6, arg_9_0.shipID)
					local var_9_8 = var_5.getGroupId(var_9_7)

					MetaCharacterConst = var_9_5

					if not var_9_5.isMetaTacticsRedTag(var_9_8) then
						return var_0_0.States.LearnAble
					end
				end

				return var_0_0.States.LearnFinished
			else
				return var_0_0.States.Learning
			end
		else
			return var_0_0.States.None
		end

		return
	end
end

function var_0_0.printInfo(arg_10_0)
	return
end

return var_0_0
