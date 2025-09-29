-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattlePlotUnitCompAvatarSynchronizer.lua

module("logic.battle.unit.comp.BattlePlotUnitCompAvatarSynchronizer", package.seeall)

local BattlePlotUnitCompAvatarSynchronizer = class("BattlePlotUnitCompAvatarSynchronizer", BattleUnitCompBase)

function BattlePlotUnitCompAvatarSynchronizer:onInit()
	self._avatarSynchronizer = false

	self:onReuse()
end

function BattlePlotUnitCompAvatarSynchronizer:onReuse()
	self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)

	self._avatarSynchronizer = false
end

function BattlePlotUnitCompAvatarSynchronizer:onReset()
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)

	self._avatarSynchronizer = false
end

function BattlePlotUnitCompAvatarSynchronizer:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)

	self._avatarSynchronizer = false
end

function BattlePlotUnitCompAvatarSynchronizer:setAvatarSynchronizer(avatarSynchronizer)
	self._avatarSynchronizer = avatarSynchronizer

	self:_onMeshModelLoaded()
end

function BattlePlotUnitCompAvatarSynchronizer:_onMeshModelLoaded()
	if self._avatarSynchronizer and self._unit.meshModel:getInst() then
		self._avatarSynchronizer:SetMainGameObject(self._unit.mountRoot:getRoot())
		BattlePlotUnitCompAvatarSynchronizer:setupModelModifier(self._avatarSynchronizer.gameObject, self._unit)
	end
end

function BattlePlotUnitCompAvatarSynchronizer:setupModelModifier(mainGO, unit)
	local goInst = unit.meshModel:getInst()

	SpaceX.ModelModifierUtils.SetupSynchronizerTarget(mainGO, goInst)
end

return BattlePlotUnitCompAvatarSynchronizer
