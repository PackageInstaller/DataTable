-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/SkillUnitInfoRecorder.lua

module("logic.battle.skill.performance.SkillUnitInfoRecorder", package.seeall)

local SkillUnitInfoRecorder = class("SkillUnitInfoRecorder", AbstractGlobalReusable)

function SkillUnitInfoRecorder:ctor()
	self._position = Vector3.New()
	self._lookAt = Vector3.New()
	self._avatarOffset = Vector3.New()
	self._baseSpeed = 10
	self._mappedAnimation = {}
	self._needMappedAnimation = {
		UnitAnimState.Idle,
		UnitAnimState.Idle2,
		UnitAnimState.Hit2,
		UnitAnimState.Hit
	}
end

function SkillUnitInfoRecorder:record(unit)
	unit.meshModelMover:setIgnoreTerrain(true)
	unit.uiFollow:turnOnPerspective()
	unit.bubble:clearAllBubbleGroup()
	unit.meshModel:clearQueue()

	local goAvatar = unit.mountRoot:getAvatarRoot()

	self._avatarOffset:Set(Astral.TransformUtil.GetLocalPos(goAvatar.transform, 0, 0, 0))

	local x, z = unit.mover:getPos()

	self._position:Set(x, 0, z)

	self._baseSpeed = unit.mover._baseSpeed

	unit.meshModel:getLookAtDirInVec3(self._lookAt)

	local signRoot = unit.mountRoot:getSignRoot()

	goutil.setActive(signRoot, false)
	BattleTableUtil.clearTable(self._mappedAnimation)

	for i, baseAnimation in ipairs(self._needMappedAnimation) do
		local mappedAnimation = unit.meshModelMover:getMappedAnimationByLayer(baseAnimation, BattleEnum.kMappingLayers.BUSINESS)

		if mappedAnimation and mappedAnimation ~= baseAnimation then
			self._mappedAnimation[baseAnimation] = mappedAnimation

			unit.meshModelMover:resetBusinessMappedAnimation(baseAnimation)
		end
	end

	unit.effectPlayer:stopEffect(BattleConst.SANITY_STRENGTHEN_REALEASE_EFFECT)
end

function SkillUnitInfoRecorder:prepareUnit(unit)
	unit.stateEffect:clearAllStateEffect()
end

function SkillUnitInfoRecorder:resume(unit)
	unit.meshModelMover:setIgnoreTerrain(false)
	unit.uiFollow:turnOffPerspective()

	local goAvatar = unit.mountRoot:getAvatarRoot()

	Astral.TransformUtil.SetLocalPos(goAvatar.transform, self._avatarOffset:Get())

	local x, y, z = self._position:Get()

	unit.mover:setPosDirectly(x, z)
	unit.mover:setSpeed(self._baseSpeed)
	unit.meshModel:lookAtDirVec3(self._lookAt)
	unit.effectPlayer:clearAllOnceEffect()
	unit.material:killAll(true)
	unit.material:doMainAlpha(1, 0)
	unit.material:setAlphaEnable(false)
	unit.effectPlayer:delayShowEliteAndBossEffect()

	local signRoot = unit.mountRoot:getSignRoot()

	goutil.setActive(signRoot, true)
	unit.uiProxy:forceSync()
	unit.sceneProxy:forceSync()
	self:_tryCheckDeadState(unit)

	for baseAnimation, mappedAnimation in pairs(self._mappedAnimation) do
		unit.meshModelMover:mapBusinessAnimation(baseAnimation, mappedAnimation)
	end

	BattleTableUtil.clearTable(self._mappedAnimation)
end

function SkillUnitInfoRecorder:_tryCheckDeadState(unit)
	if unit.property:isStateActive(BattleEnum.State.DEAD) then
		local deathAnimation = unit.meshModelMover:getMappedAnimation(UnitAnimState.Death)

		unit.meshModel:frozenAnimationToLastFrame(deathAnimation)
		unit.property:activeState(BattleEnum.State.DEAD_FROZEN)
		unit.uiProxy:setVisible(false, true)
		unit.sceneProxy:setVisible(false)
		unit.effectPlayer:stopAllLoopEffect()
	else
		unit.stateEffect:applyAllStateEffect()
	end
end

return SkillUnitInfoRecorder
