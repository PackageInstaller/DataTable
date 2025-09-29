-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/skilleffect/SkillEffectActionParser.lua

module("logic.battle.config.skilleffect.SkillEffectActionParser", package.seeall)

local SkillEffectActionParser = class("SkillEffectActionParser")
local programmingParser = {}

function SkillEffectActionParser:ctor()
	self._addBuffCodes = {}
	self._addTagCodes = {}
	self._weakPointParams = false
	self._transportDistance = false
	self._transPortRangeKey = false
	self._multiAOEParams = false
	self._entityLinkedWeakPointParams = false
	self._haloShape = false
	self._haloRangeKey = false
	self._haloShapeKey = false
	self._hasUnitRelatedTransport = false
	self._secondSelectSelectableTarget = false
	self._aoeShape = false
	self._aoeActionIdx = 0
	self._moveAudio = false
	self._deadPeformLost = false
end

function SkillEffectActionParser:clear()
	self._weakPointParams = false
	self._transportDistance = false
	self._transPortRangeKey = false
	self._multiAOEParams = false
	self._entityLinkedWeakPointParams = false
	self._haloShape = false
	self._haloRangeKey = false
	self._haloShapeKey = false
	self._hasUnitRelatedTransport = false
	self._secondSelectSelectableTarget = false
	self._aoeShape = false
	self._aoeActionIdx = 0
	self._moveAudio = false
	self._deadPeformLost = false

	BattleTableUtil.clearTable(self._addBuffCodes)
	BattleTableUtil.clearTable(self._addTagCodes)
end

function SkillEffectActionParser:getAddBuffCodes()
	return self._addBuffCodes
end

function SkillEffectActionParser:getTagCodes()
	return self._addTagCodes
end

function SkillEffectActionParser:getWeakPointParams()
	return self._weakPointParams
end

function SkillEffectActionParser:getMultiAOEParams()
	return self._multiAOEParams
end

function SkillEffectActionParser:getAoeShape()
	return self._aoeShape, self._aoeActionIdx
end

function SkillEffectActionParser:getEntityLinkedWeakPointParams()
	return self._entityLinkedWeakPointParams
end

function SkillEffectActionParser:getTransportDistance()
	return self._transportDistance, self._transPortRangeKey
end

function SkillEffectActionParser:getHaloParams()
	return self._haloRangeKey, self._haloShapeKey, self._haloShape
end

function SkillEffectActionParser:hasUnitRelatedTransport()
	return self._hasUnitRelatedTransport
end

function SkillEffectActionParser:getSecondSelectSelectableTarget()
	return self._secondSelectSelectableTarget
end

function SkillEffectActionParser:getMoveAudio()
	return self._moveAudio
end

function SkillEffectActionParser:getDeadPerformLost()
	return self._deadPeformLost
end

function SkillEffectActionParser:parseActionParams(action, index, actionIndex)
	self._index = index
	self._actionIndex = actionIndex

	local actionCode = action.code
	local skillActionCO = ActiveSkillConfig.instance:getSkillEffectActionCO(actionCode)
	local programmingArray = string.split(skillActionCO.programming, ActiveSkillCOUtil.DELIMITER02)
	local programmingKey = programmingArray[1]
	local parseFunction = programmingParser[programmingKey]

	if parseFunction then
		parseFunction(self, programmingArray, action)
	end
end

function SkillEffectActionParser:_parseAoeShape(action)
	return
end

function programmingParser:WeakPoint(programmingArray, action)
	self._weakPointParams = action
end

function programmingParser:EntityLinkedWeakPoint(programmingArray, action)
	self._entityLinkedWeakPointParams = action
end

function programmingParser:AddBuff(programmingArray, action)
	for i, buff in ipairs(action.buffList) do
		table.insert(self._addBuffCodes, buff.buffId)
	end
end

function programmingParser:TagRefAction(programmingArray, action)
	table.insert(self._addTagCodes, action.tag)
end

function programmingParser:AddBuffInRange(programmingArray, action)
	for i, buff in ipairs(action.buffList) do
		table.insert(self._addBuffCodes, buff.buffId)
	end
end

function programmingParser:AddBuffToOneInRange(programmingArray, action)
	for i, buff in ipairs(action.buffList) do
		table.insert(self._addBuffCodes, buff.buffId)
	end
end

function programmingParser:AddBuffToMultipleInRange(programmingArray, action)
	for i, buff in ipairs(action.buffList) do
		table.insert(self._addBuffCodes, buff.buffId)
	end
end

function programmingParser:AddBuffByPositionChange(programmingArray, action)
	for i, buff in ipairs(action.buffList) do
		table.insert(self._addBuffCodes, buff.buffId)
	end
end

function programmingParser:ChangePositionToRange(programmingArray, action)
	self._transPortRangeKey = string.format("effect-%d_action-%d_range", self._index, self._actionIndex)
	self._transportDistance = action.range
end

function programmingParser:NormalDamageAttrRatioInRange(programmingArray, action)
	self._aoeActionIdx = self._actionIndex
	self._aoeShape = action.shape
	self._multiAOEParams = action
end

function programmingParser:RealDamageAttrRatioInRange(programmingArray, action)
	self._aoeActionIdx = self._actionIndex
	self._aoeShape = action.shape
	self._multiAOEParams = action
end

function programmingParser:Aoe(programmingArray, action)
	self._aoeActionIdx = self._actionIndex
	self._aoeShape = action.shape
end

function programmingParser:Halo(programmingArray, action)
	self._haloRangeKey = string.format("effect-%d_action-%d_shape_range", self._index, self._actionIndex)
	self._haloShapeKey = string.format("effect-%d_action-%d_shape_type", self._index, self._actionIndex)
end

function programmingParser:SetBlocked(programmingArray, action)
	self._haloRangeKey = string.format("effect-%d_action-%d_range", self._index, self._actionIndex)
	self._haloShape = programmingArray[2] == "RHOMBUS" and "Rhombus" or "Circle"
end

function programmingParser:ChangePositionToTarget(programmingArray, action)
	self._transPortRangeKey = string.format("effect-%d_action-%d_range", self._index, self._actionIndex)
	self._transportDistance = action.shape
	self._hasUnitRelatedTransport = true
	self._secondSelectSelectableTarget = action.targetType == "FRIEND_EXCEPT_SELF" and BattleEnum.SkillSelectableTarget.MEMBER or BattleEnum.SkillSelectableTarget.ENEMY
end

function programmingParser:EmptyAction(programmingArray, action)
	if action.code == 60029 then
		self._moveAudio = action.audioName
	end

	if action.code == 70120 then
		self._deadPeformLost = true
	end
end

return SkillEffectActionParser
