local MetaTacticsInfo = class("MetaTacticsInfo")

function MetaTacticsInfo:Ctor(arg_1_1)
	if arg_1_1 then
		self.shipID = arg_1_1.ship_id
		self.curDayExp = arg_1_1.exp
		self.curSkillID = arg_1_1.skill_id
		self.skillExpInfoTable = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_1.skill_exp) do
			self.skillExpInfoTable[iter_1_1.skill_id] = iter_1_1.exp
		end
	else
		self.shipID = nil
		self.curDayExp = 0
		self.curSkillID = nil
		self.skillExpInfoTable = {}
	end

	return
end

function MetaTacticsInfo:updateExp(arg_2_1)
	self.curDayExp = arg_2_1.day_exp
	self.skillExpInfoTable[arg_2_1.skill_id] = arg_2_1.skill_exp

	return
end

function MetaTacticsInfo:setNewExp(arg_3_1, arg_3_2)
	self.skillExpInfoTable[arg_3_1] = arg_3_2

	self:printInfo()

	return
end

function MetaTacticsInfo:switchSkill(arg_4_1)
	self.curSkillID = arg_4_1

	return
end

function MetaTacticsInfo:unlockSkill(arg_5_1, arg_5_2)
	self.skillExpInfoTable[arg_5_1] = 0

	if arg_5_2 then
		self.curSkillID = arg_5_1
	end

	return
end

function MetaTacticsInfo:getSkillExp(arg_6_1)
	return self.skillExpInfoTable[arg_6_1] or 0
end

function MetaTacticsInfo:isExpMaxPerDay()
	return self.curDayExp >= pg.gameset.meta_skill_exp_max.key_value
end

function MetaTacticsInfo:isAnyLearning()
	return self.curSkillID and self.curSkillID > 0
end

MetaTacticsInfo.States = {
	LearnAble = 1,
	LearnFinished = 3,
	Learning = 2,
	None = 0
}

function MetaTacticsInfo:getTacticsStateForShow()
	local var_9_0 = self:isAnyLearning()
	local var_9_1 = getProxy(BayProxy):getShipById(self.shipID)
	local var_9_2 = var_9_1 and var_9_1:isAllMetaSkillLevelMax() or false

	if not var_9_0 and not var_9_2 then
		return MetaTacticsInfo.States.LearnAble
	elseif var_9_0 then
		if getProxy(BayProxy):getShipById(self.shipID):isSkillLevelMax(self.curSkillID) then
			if not var_9_2 then
				if not MetaCharacterConst.isMetaTacticsRedTag((getProxy(BayProxy):getShipById(self.shipID):getGroupId())) then
					return MetaTacticsInfo.States.LearnAble
				end
			end

			return MetaTacticsInfo.States.LearnFinished
		else
			return MetaTacticsInfo.States.Learning
		end
	else
		return MetaTacticsInfo.States.None
	end

	return
end

function MetaTacticsInfo:printInfo()
	return
end

return MetaTacticsInfo
