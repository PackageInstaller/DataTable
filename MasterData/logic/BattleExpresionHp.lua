-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/expression/BattleExpresionHp.lua

module("logic.extensions.battle.model.expression.BattleExpresionHp", package.seeall)

local BattleExpresionHp = class("BattleExpresionHp", BattleExpressionBase)

function BattleExpresionHp:ctor(expCo)
	self._expCo = expCo

	local limitParams = string.split(expCo.limitParams, "#")

	self._position = nil

	if limitParams[1] == "站位" then
		self._position = tonumber(limitParams[2])
		self._valueType = limitParams[3]
		self._valueOp = limitParams[4]
		self._value = tonumber(limitParams[5])
	else
		self._valueType = limitParams[1]
		self._valueOp = limitParams[2]
		self._value = tonumber(limitParams[3])
	end
end

function BattleExpresionHp:isMet()
	if not self._position then
		return self:_isMetNonePosition()
	else
		return self:_isMetPosition()
	end
end

function BattleExpresionHp:_isMetNonePosition()
	local battleScene = SceneMgr.instance:getCurScene()
	local units = battleScene.unitFactory:getAllCatchableUnit()

	if units then
		local cnt = #units

		for i = 1, cnt do
			if self:_isUnitMet(units[i]) then
				return true
			end
		end
	end
end

function BattleExpresionHp:_isUnitMet(unit)
	if self._valueType == GameEnum.RATE_TYPE then
		if self._valueOp == GameEnum.LESS_THAN then
			local maxHp = unit.attrs:getMaxHp()
			local hp = unit.attrs:getCurTempHp()

			if hp > 0 and hp / maxHp <= self._value then
				return true
			end
		elseif self._valueOp == GameEnum.GREATER_THAN then
			local maxHp = unit.attrs:getMaxHp()
			local hp = unit.attrs:getCurTempHp()

			if hp / maxHp >= self._value then
				return true
			end
		end
	elseif self._valueType == GameEnum.CONSTANT_TYPE then
		if self._valueOp == GameEnum.LESS_THAN then
			local hp = unit.attrs:getCurTempHp()

			if hp > 0 and hp <= self._value then
				return true
			end
		elseif self._valueOp == GameEnum.GREATER_THAN then
			local hp = unit.attrs:getCurTempHp()

			if hp > 0 and hp >= self._value then
				return true
			end
		end
	end
end

function BattleExpresionHp:_isMetPosition()
	local battleScene = SceneMgr.instance:getCurScene()
	local units = battleScene.unitFactory:getUnits(BattleModel.instance:getEnemyPlayerTeam())

	if units then
		local unit

		for k, v in pairs(units) do
			if v.fmtIndex == self._position then
				unit = v

				break
			end
		end

		if unit then
			return self:_isUnitMet(unit)
		end

		return true
	end
end

function BattleExpresionHp:getTips()
	if self._expCo.limitTips and self._expCo.limitTips ~= 0 and #self._expCo.limitTips > 0 then
		return self._expCo.limitTips
	end

	if not self._position then
		return self:_getTipsNonePosition()
	else
		return self:_getTipsPosition()
	end
end

function BattleExpresionHp:_getTipsNonePosition()
	if self._valueType == GameEnum.RATE_TYPE then
		if self._valueOp == GameEnum.LESS_THAN then
			return string.format(lang("catch_hp_percent_less"), self._value * 100)
		elseif self._valueOp == GameEnum.GREATER_THAN then
			return string.format(lang("catch_hp_percent_great"), self._value * 100)
		end
	elseif self._valueType == GameEnum.CONSTANT_TYPE then
		if self._valueOp == GameEnum.LESS_THAN then
			return string.format(lang("catch_hp_less"), self._value)
		elseif self._valueOp == GameEnum.GREATER_THAN then
			return string.format(lang("catch_hp_great"), self._value)
		end
	end
end

function BattleExpresionHp:_getTipsPosition()
	local battleScene = SceneMgr.instance:getCurScene()
	local units = battleScene.unitFactory:getUnits(BattleModel.instance:getEnemyPlayerTeam())

	if units then
		local unit

		for k, v in pairs(units) do
			if v.fmtIndex == self._position then
				unit = v

				break
			end
		end

		if unit then
			local petCO = CharacterConfig.instance:getPetCo(unit.raceId)

			if self._valueType == GameEnum.RATE_TYPE then
				if self._valueOp == GameEnum.LESS_THAN then
					return string.format(lang("catch_hp_percent_pos_less"), petCO.name, self._value * 100)
				elseif self._valueOp == GameEnum.GREATER_THAN then
					return string.format(lang("catch_hp_percent_pos_great"), petCO.name, self._value * 100)
				end
			elseif self._valueType == GameEnum.CONSTANT_TYPE then
				if self._valueOp == GameEnum.LESS_THAN then
					return string.format(lang("catch_hp_pos_less"), petCO.name, self._value)
				elseif self._valueOp == GameEnum.GREATER_THAN then
					return string.format(lang("catch_hp_pos_great"), petCO.name, self._value)
				end
			end
		end
	end
end

return BattleExpresionHp
