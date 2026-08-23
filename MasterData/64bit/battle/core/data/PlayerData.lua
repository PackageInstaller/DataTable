local PlayerData = class("PlayerData")

function PlayerData:createPlayer(arg_1_1)
	return PlayerData.new(self, arg_1_1)
end

function PlayerData:ctor(arg_2_1, arg_2_2)
	self._skillAffectTimes = {}
	self._uniteSkills = {}

	local var_2_0 = arg_2_2:getComboInfo(arg_2_1)

	if var_2_0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_0.skillIndex or {}) do
			for iter_2_2, iter_2_3 in ipairs((load("core.rule.UniteSkillRule").initRule(iter_2_1, arg_2_2:getBattleField()))) do
				table.insert(self._uniteSkills, iter_2_3)
			end
		end
	end
end

function PlayerData:executeUniteSkills(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self._uniteSkills) do
		local var_3_1, var_3_2 = iter_3_1:execute(arg_3_1)

		if var_3_1 then
			table.insert(var_3_0, var_3_2)
		end
	end

	return var_3_0
end

function PlayerData:addSkillAffectTimes(arg_4_1, arg_4_2, arg_4_3)
	self._skillAffectTimes[arg_4_1 .. "_" .. arg_4_2] = self._skillAffectTimes[arg_4_1 .. "_" .. arg_4_2] or 0
	self._skillAffectTimes[arg_4_1 .. "_" .. arg_4_2] = self._skillAffectTimes[arg_4_1 .. "_" .. arg_4_2] + arg_4_3
end

function PlayerData:getSkillAffectTimes(arg_5_1, arg_5_2)
	self._skillAffectTimes[arg_5_1 .. "_" .. arg_5_2] = self._skillAffectTimes[arg_5_1 .. "_" .. arg_5_2] or 0

	return self._skillAffectTimes[arg_5_1 .. "_" .. arg_5_2]
end

return PlayerData
