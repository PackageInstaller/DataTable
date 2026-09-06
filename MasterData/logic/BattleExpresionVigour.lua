-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/expression/BattleExpresionVigour.lua

module("logic.extensions.battle.model.expression.BattleExpresionVigour", package.seeall)

local BattleExpresionVigour = class("BattleExpresionVigour", BattleExpressionBase)

function BattleExpresionVigour:ctor(expCo)
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

function BattleExpresionVigour:isMet()
	if not self._position then
		return self:_isMetNonePosition()
	else
		return self:_isMetPosition()
	end
end

function BattleExpresionVigour:_isMetNonePosition()
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

function BattleExpresionVigour:_isUnitMet(unit)
	if self._valueType == GameEnum.RATE_TYPE then
		if self._valueOp == GameEnum.LESS_THAN then
			local maxVigour = unit.attrs:getMaxVigour()
			local vigour = unit.attrs:getCurVigour()

			if vigour / maxVigour <= self._value then
				return true
			end
		elseif self._valueOp == GameEnum.GREATER_THAN then
			local maxVigour = unit.attrs:getMaxVigour()
			local vigour = unit.attrs:getCurVigour()

			if vigour / maxVigour >= self._value then
				return true
			end
		end
	elseif self._valueType == GameEnum.CONSTANT_TYPE then
		if self._valueOp == GameEnum.LESS_THAN then
			local vigour = unit.attrs:getCurVigour()

			if vigour <= self._value then
				return true
			end
		elseif self._valueOp == GameEnum.GREATER_THAN then
			local vigour = unit.attrs:getCurVigour()

			if vigour >= self._value then
				return true
			end
		end
	end
end

function BattleExpresionVigour:_isMetPosition()
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

function BattleExpresionVigour:getTips()
	if self._expCo.limitTips and self._expCo.limitTips ~= 0 and #self._expCo.limitTips > 0 then
		return self._expCo.limitTips
	end

	if not self._position then
		return self:_getTipsNonePosition()
	else
		return self:_getTipsPosition()
	end
end

function BattleExpresionVigour:_getTipsNonePosition()
	if self._valueType == GameEnum.RATE_TYPE then
		if self._valueOp == GameEnum.LESS_THAN then
			return string.format(lang("catch_vigour_percent_less"), self._value * 100)
		elseif self._valueOp == GameEnum.GREATER_THAN then
			return string.format(lang("catch_vigour_percent_great"), self._value * 100)
		end
	elseif self._valueType == GameEnum.CONSTANT_TYPE then
		if self._valueOp == GameEnum.LESS_THAN then
			return string.format(lang("catch_vigour_less"), self._value)
		elseif self._valueOp == GameEnum.GREATER_THAN then
			return string.format(lang("catch_vigour_great"), self._value)
		end
	end
end

function BattleExpresionVigour:_getTipsPosition()
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
					return string.format(lang("catch_vigour_percent_pos_less"), petCO.name, self._value * 100)
				elseif self._valueOp == GameEnum.GREATER_THAN then
					return string.format(lang("catch_vigour_percent_pos_great"), petCO.name, self._value * 100)
				end
			elseif self._valueType == GameEnum.CONSTANT_TYPE then
				if self._valueOp == GameEnum.LESS_THAN then
					return string.format(lang("catch_vigour_pos_less"), petCO.name, self._value)
				elseif self._valueOp == GameEnum.GREATER_THAN then
					return string.format(lang("catch_vigour_pos_great"), petCO.name, self._value)
				end
			end
		end
	end
end

return BattleExpresionVigour
