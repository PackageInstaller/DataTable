local SpecialKnightStruct = require("app.view.module.knight.model.SpecialKnightStruct")
local FogNightmareWaveEffectMonsterStruct = class("FogNightmareWaveEffectMonsterStruct", (require("app.view.module.fogNightmare.model.struct.waveEffect.FogNightmareWaveEffectBaseStruct")))
local UniteTokenStructData = require("app.view.module.uniteToken.model.UniteTokenStructData")

function FogNightmareWaveEffectMonsterStruct:ctor(arg_1_1)
	self._monsters = {}
	self._monsterPositionMap = {}
	self._uniteTokens = {}
	self._showSkills = {}

	FogNightmareWaveEffectMonsterStruct.super.ctor(self, arg_1_1)

	self._effectType = arg_1_1.type
end

function FogNightmareWaveEffectMonsterStruct:_init(arg_2_1)
	self._param = arg_2_1
	self._teamid = arg_2_1.parameter_1

	for iter_2_0 = 1, 3 do
		local var_2_0 = 1
		local var_2_1 = g.core.config.monster_team_info.fetch(arg_2_1.parameter_1, iter_2_0)

		if not var_2_1 then
			break
		end

		while g.core.config.monster_team_info.hasKey("monster_" .. 1) do
			if var_2_1["monster_" .. 1] ~= 0 then
				local var_2_2 = g.core.config.monster_info.get(var_2_1["monster_" .. 1])
				local var_2_3 = SpecialKnightStruct.new(var_2_2.advance_id)

				var_2_3:updateAttrsByMonsterInfo(var_2_2)

				self._monsters[#self._monsters + 1] = var_2_3
				self._monsterPositionMap[var_2_0 + (iter_2_0 - 1) * 6] = var_2_3
			end

			var_2_0 = var_2_0 + 1
		end

		local var_2_5 = 1
		local var_2_6 = "unite_token_" .. 1

		while g.core.config.monster_team_info.hasKey(var_2_6) do
			if var_2_1[var_2_6] ~= 0 then
				self._uniteTokens[#self._uniteTokens + 1] = UniteTokenStructData.new(var_2_1[var_2_6])
			end

			var_2_5 = var_2_5 + 1
			var_2_6 = "unite_token_" .. var_2_5
		end
	end

	self._showSkills = {}

	local var_2_7 = 1

	while g.core.config.fog_stage_info.hasKey("show_skill_" .. 1) do
		if arg_2_1["show_skill_" .. 1] > 0 then
			table.insert(self._showSkills, arg_2_1["show_skill_" .. 1])
		end

		var_2_7 = var_2_7 + 1
	end
end

function FogNightmareWaveEffectMonsterStruct:reset()
	require("app.view.module.fogNightmare.model.struct.bpm.BPMAction").reset(self)

	for iter_3_0, iter_3_1 in ipairs(self._monsters) do
		iter_3_1:resetFullHp()
	end
end

function FogNightmareWaveEffectMonsterStruct:updateEffectByNetInfo(arg_4_1)
	return
end

function FogNightmareWaveEffectMonsterStruct:getCompName()
	return "FogNightmareMonsterWaveComp"
end

function FogNightmareWaveEffectMonsterStruct:getAllMonsters()
	return self._monsters
end

function FogNightmareWaveEffectMonsterStruct:getPower()
	return self._param.power
end

function FogNightmareWaveEffectMonsterStruct:getALLUniteTokens()
	return self._uniteTokens
end

function FogNightmareWaveEffectMonsterStruct:getAllShowSkills()
	return self._showSkills
end

function FogNightmareWaveEffectMonsterStruct:doing(arg_10_1)
	local var_10_0 = true

	for iter_10_0, iter_10_1 in pairs(self._monsterPositionMap) do
		iter_10_1:updateMonsterHp(arg_10_1.monster_hps[iter_10_0])

		if iter_10_1:getHpPercent() > 0 then
			var_10_0 = false
		end
	end

	if var_10_0 then
		self:_onFinish()
	end
end

return FogNightmareWaveEffectMonsterStruct
