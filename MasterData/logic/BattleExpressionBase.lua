-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/expression/BattleExpressionBase.lua

module("logic.extensions.battle.model.expression.BattleExpressionBase", package.seeall)

local BattleExpressionBase = class("BattleExpressionBase")

function BattleExpressionBase:isMet()
	return
end

function BattleExpressionBase.createExpression(expCo)
	if expCo.limitClazz == "CircleLimit" then
		return BattleExpresionRound.New(expCo)
	elseif expCo.limitClazz == "IfHasBuff" then
		return BattleExpresionBuff.New(expCo)
	elseif expCo.limitClazz == "IfHpCondition" then
		return BattleExpresionHp.New(expCo)
	elseif expCo.limitClazz == "IfVigourCondition" then
		return BattleExpresionVigour.New(expCo)
	elseif expCo.limitClazz == "IfTargetsNum" then
		return BattleExpresionTargetNum.New(expCo)
	elseif expCo.limitClazz == "IfOnlyPetExist" then
		return BattleExpresionOnlyPetExist.New(expCo)
	end
end

return BattleExpressionBase
