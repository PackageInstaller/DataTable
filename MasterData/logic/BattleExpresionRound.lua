-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/expression/BattleExpresionRound.lua

module("logic.extensions.battle.model.expression.BattleExpresionRound", package.seeall)

local BattleExpresionRound = class("BattleExpresionRound", BattleExpressionBase)

function BattleExpresionRound:ctor(expCo)
	self._expCo = expCo

	if expCo.limitParams == "1" then
		self._result = 1
	end

	if expCo.limitParams == "0" then
		self._result = 0
	end
end

function BattleExpresionRound:isMet()
	local round = BattleModel.instance.currRoundNum

	return self._result == round % 2
end

function BattleExpresionRound:getTips()
	if self._expCo.limitTips and self._expCo.limitTips ~= 0 and #self._expCo.limitTips > 0 then
		return self._expCo.limitTips
	end

	if self._result == 0 then
		return lang("catch_even_round")
	elseif self._result == 1 then
		return lang("catch_odd_round")
	end
end

return BattleExpresionRound
