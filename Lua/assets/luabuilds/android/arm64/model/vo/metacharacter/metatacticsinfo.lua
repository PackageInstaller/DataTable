local var_0_0 = class("MetaTacticsInfo")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	if arg_1_1 then
		arg_1_0.shipID = arg_1_1.ship_id
		arg_1_0.curDayExp = arg_1_1.exp
		arg_1_0.curSkillID = arg_1_1.skill_id
		arg_1_0.skillExpInfoTable = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_1.skill_exp) do
			arg_1_0.skillExpInfoTable[iter_1_1.skill_id] = iter_1_1.exp
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
	arg_2_0.curDayExp = arg_2_1.day_exp
	arg_2_0.skillExpInfoTable[arg_2_1.skill_id] = arg_2_1.skill_exp

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
	return arg_6_0.skillExpInfoTable[arg_6_1] or 0
end

function var_0_0.isExpMaxPerDay(arg_7_0)
	return arg_7_0.curDayExp >= pg.gameset.meta_skill_exp_max.key_value
end

function var_0_0.isAnyLearning(arg_8_0)
	return arg_8_0.curSkillID and arg_8_0.curSkillID > 0
end

var_0_0.States = {
	LearnAble = 1,
	LearnFinished = 3,
	Learning = 2,
	None = 0
}

function var_0_0.getTacticsStateForShow(arg_9_0)
	local var_9_0 = arg_9_0:isAnyLearning()
	local var_9_1 = getProxy(BayProxy):getShipById(arg_9_0.shipID)
	local var_9_2 = var_9_1 and var_9_1:isAllMetaSkillLevelMax() or false

	if not var_9_0 and not var_9_2 then
		return var_0_0.States.LearnAble
	elseif var_9_0 then
		if getProxy(BayProxy):getShipById(arg_9_0.shipID):isSkillLevelMax(arg_9_0.curSkillID) then
			if not var_9_2 then
				if not MetaCharacterConst.isMetaTacticsRedTag((getProxy(BayProxy):getShipById(arg_9_0.shipID):getGroupId())) then
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

function var_0_0.printInfo(arg_10_0)
	return
end

return var_0_0
