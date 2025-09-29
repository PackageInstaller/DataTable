-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/SkillTimelineContext.lua

module("logic.battle.skill.performance.SkillTimelineContext", package.seeall)

local SkillTimelineContext = class("SkillTimelineContext")

SkillTimelineContext.AttackerAnimationTrack = "AttackerAnimationTrack"
SkillTimelineContext.AttackerFaceAnimationTrack = "AttackerFaceAnimationTrack"
SkillTimelineContext.VictimAnimationTrack = "VictimAnimationTrack"
SkillTimelineContext.CinemachineBrainTrack = "CinemachineBrainTrack"
SkillTimelineContext.CharacterLightTrack = "CharacterLightTrack"
SkillTimelineContext.ToonMaskTrack = "ToonMaskTrack"
SkillTimelineContext.GlitchMaskTrack = "GlitchMaskTrack"
SkillTimelineContext.NormalCameraShakeTrack = "NormalCameraShakeTrack"
SkillTimelineContext.NormalRelativeVirtualCameraTrack = "NormalRelativeVirtualCameraTrack"
SkillTimelineContext.SceneActiveTrack = "Scene Active Track"
SkillTimelineContext.ActiveVirtualCameraTrack = "ActiveVirtualCameraTrack"
SkillTimelineContext.LoopRegionTrack = "LoopRegionTrack"
SkillTimelineContext.VictimRoot = "beattackmove"
SkillTimelineContext.AOEAttackedRoot = "aoeeffect"
SkillTimelineContext.AttackerSynchronizerRoot = "attacker_synchronizer"
SkillTimelineContext.VictimSynchronizerRoot = "victim_synchronizer"
SkillTimelineContext.SceneAOEAttackRoot = "scene_aoe_effect"
SkillTimelineContext.UnitFeature = "unit_feature"
SkillTimelineContext.Bullet = "bullet"
SkillTimelineContext.VCamera = "vCamera"
SkillTimelineContext.Param_WeakPointBrokenEntityId = "Param_WeakPointBrokenEntityId"
SkillTimelineContext.Param_IsResourceReversed = "Param_IsResourceReversed"

local kLeftInitPosVec3 = Vector3.New(-4.5, 0, 0)
local kRightInitPosVec3 = Vector3.New(4.5, 0, 0)
local kCenterPosition = Vector3.New(0, 0, 0)

function SkillTimelineContext:ctor(skillVSInfo)
	self._skillVSInfo = skillVSInfo
	self._unitInfoRecorders = {}
	self._centerPosition = Vector3.New()
	self._leftInitPosition = Vector3.New()
	self._rightInitPosition = Vector3.New()
	self._paramTable = {}
end

function SkillTimelineContext:init()
	self:_initPositions()
end

function SkillTimelineContext:clear()
	self:resumeAllUnit()
	BattleTableUtil.clearTable(self._paramTable)
end

function SkillTimelineContext:getSkillVSInfo()
	return self._skillVSInfo
end

function SkillTimelineContext:getAttackCameraCode()
	return BattleConst.ATTACK_CAMERA_CODE
end

function SkillTimelineContext:getLeftInitPosition()
	return self._leftInitPosition
end

function SkillTimelineContext:getRightInitPosition()
	return self._rightInitPosition
end

function SkillTimelineContext:getCenterPosition()
	return self._centerPosition
end

function SkillTimelineContext:judgeAttackerInitPosition(isReversePosition)
	return isReversePosition and self._rightInitPosition or self._leftInitPosition
end

function SkillTimelineContext:judgeVictimInitPosition(isReversePosition)
	return isReversePosition and self._leftInitPosition or self._rightInitPosition
end

function SkillTimelineContext:recordUnit(unit)
	if self._unitInfoRecorders[unit] then
		return
	end

	local recorder = SkillUnitInfoRecorder:createInstance()

	self._unitInfoRecorders[unit] = recorder

	recorder:record(unit)
end

function SkillTimelineContext:recordUnits(units)
	for _, unit in ipairs(units) do
		self:recordUnit(unit)
	end
end

function SkillTimelineContext:prepareUnit(unit)
	local recorder = self._unitInfoRecorders[unit]

	if recorder then
		recorder:prepareUnit(unit)
	end
end

function SkillTimelineContext:prepareUnits(units)
	for _, unit in ipairs(units) do
		self:prepareUnit(unit)
	end
end

function SkillTimelineContext:resumeUnit(unit)
	local recorder = self._unitInfoRecorders[unit]

	if not recorder then
		return
	end

	recorder:resume(unit)
	recorder:returnSelf()

	self._unitInfoRecorders[unit] = nil
end

function SkillTimelineContext:resumeAllUnit()
	for unit, recorder in pairs(self._unitInfoRecorders) do
		recorder:resume(unit)
	end

	BattleTableUtil.clearReusableTable(self._unitInfoRecorders)
end

function SkillTimelineContext:_initPositions()
	local scene = SceneMgr.instance:getScene(SceneType.Battle)

	self._centerPosition:Set(scene.stage:getAdditionSceneCenterPosition())
	self._leftInitPosition:Set(kLeftInitPosVec3:Get())
	self._leftInitPosition:Add(self._centerPosition)
	self._rightInitPosition:Set(kRightInitPosVec3:Get())
	self._rightInitPosition:Add(self._centerPosition)
end

function SkillTimelineContext:setParam(paramKey, value)
	self._paramTable[paramKey] = value
end

function SkillTimelineContext:getParam(paramKey)
	return self._paramTable[paramKey]
end

function SkillTimelineContext:clearParam(paramKey)
	self._paramTable[paramKey] = nil
end

return SkillTimelineContext
