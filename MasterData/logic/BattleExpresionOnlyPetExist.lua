-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/expression/BattleExpresionOnlyPetExist.lua

module("logic.extensions.battle.model.expression.BattleExpresionOnlyPetExist", package.seeall)

local BattleExpresionOnlyPetExist = class("BattleExpresionOnlyPetExist", BattleExpressionBase)

function BattleExpresionOnlyPetExist:ctor(expCo)
	self._expCo = expCo

	local limitParams = string.split(expCo.limitParams, "#")

	self._petIds = {}

	for i = 1, #limitParams do
		self._petIds[tonumber(limitParams[i])] = true
	end
end

function BattleExpresionOnlyPetExist:isMet()
	local battleScene = SceneMgr.instance:getCurScene()
	local units = battleScene.unitFactory:getUnits(BattleModel.instance:getEnemyPlayerTeam())

	if units then
		local isMet = true

		for k, v in pairs(units) do
			if not v.attrs:isDead() and not self._petIds[v.raceId] then
				isMet = nil
			end
		end

		return isMet
	end
end

function BattleExpresionOnlyPetExist:getTips()
	if self._expCo.limitTips and self._expCo.limitTips ~= 0 and #self._expCo.limitTips > 0 then
		return self._expCo.limitTips
	end

	local names = {}

	for k, v in pairs(self._petIds) do
		local petCO = CharacterConfig.instance:getPetCo(k)

		table.insert(names, petCO.name)
		table.insert(names, ",")
	end

	table.remove(names)

	return string.format(lang("catch_onlypet_exist"), table.concat(names))
end

return BattleExpresionOnlyPetExist
