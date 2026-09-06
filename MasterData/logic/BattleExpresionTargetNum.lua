-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/expression/BattleExpresionTargetNum.lua

module("logic.extensions.battle.model.expression.BattleExpresionTargetNum", package.seeall)

local BattleExpresionTargetNum = class("BattleExpresionTargetNum", BattleExpressionBase)

function BattleExpresionTargetNum:ctor(expCo)
	self._expCo = expCo

	local limitParams = string.split(expCo.limitParams, "#")

	self._valueOp = limitParams[1]
	self._value = tonumber(limitParams[2])
end

function BattleExpresionTargetNum:isMet()
	local battleScene = SceneMgr.instance:getCurScene()
	local units = battleScene.unitFactory:getUnits(BattleModel.instance:getEnemyPlayerTeam())

	if units then
		local aliveNum = 0

		for k, v in pairs(units) do
			if not v.attrs:isDead() then
				aliveNum = aliveNum + 1
			end
		end

		if self._valueOp == GameEnum.LESS_THAN then
			return aliveNum <= self._value
		elseif self._valueOp == GameEnum.GREATER_THAN then
			return aliveNum >= self._value
		end
	end
end

function BattleExpresionTargetNum:getTips()
	if self._expCo.limitTips and self._expCo.limitTips ~= 0 and #self._expCo.limitTips > 0 then
		return self._expCo.limitTips
	end

	if self._valueOp == GameEnum.LESS_THAN then
		return string.format(lang("catch_targetnum_less"), self._value)
	elseif self._valueOp == GameEnum.GREATER_THAN then
		return string.format(lang("catch_targetnum_great"), self._value)
	end
end

return BattleExpresionTargetNum
