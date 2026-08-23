local SceneData = class("SceneData")
local var_0_1 = table.insert

function SceneData:createScene(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	return SceneData.new(self, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
end

function SceneData:ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = loadCfg("cfg.battle_scene_info")
	local var_2_1 = var_2_0.get(arg_2_2)

	self._serialId = arg_2_1
	self._sceneCfg = var_2_1
	self._attacker = arg_2_4
	self._sceneTime = arg_2_3
	self._battleField = arg_2_5

	local var_2_2 = {}

	while var_2_0.hasKey("passive_skill_id_" .. 1) do
		if var_2_1["passive_skill_id_" .. 1] > 0 then
			var_0_1(var_2_2, var_2_1["passive_skill_id_" .. 1])
		end
	end

	self._spRules = load("core.rule.SkillSpecialRule"):initRule(arg_2_4.identity, arg_2_5, arg_2_4)
end

function SceneData:executeSpRule(arg_3_1, arg_3_2)
	if self._spRules[arg_3_1] then
		for iter_3_0, iter_3_1 in ipairs(self._spRules[arg_3_1]) do
			if iter_3_1:check(arg_3_2) and iter_3_1:execute() then
				self._battleField:getBattleData():addPassive({
					info = iter_3_1.info,
					knight = self.attacker,
					identity = self.attacker.identity
				})
			end
		end
	end
end

function SceneData:doRound()
	self.sceneTime = self.sceneTime - 1

	if self.sceneTime == 0 and self.sceneCfg.disappear_skill_id > 0 then
		self._battleField:getBattleData():addPassive({
			isSkill = true,
			identity = self.attacker.identity,
			knight = self.attacker,
			info = loadCfg("cfg.skill_info").get(self.sceneCfg.disappear_skill_id)
		})
	end
end

return SceneData
