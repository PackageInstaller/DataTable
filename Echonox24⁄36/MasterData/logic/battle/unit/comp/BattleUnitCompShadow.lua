-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompShadow.lua

module("logic.battle.unit.comp.BattleUnitCompShadow", package.seeall)

local BattleUnitCompShadow = class("BattleUnitCompShadow", UnitComponentBase, IBattleUnitComponent)

function BattleUnitCompShadow:onInit()
	self._shadowRoot = self._unit.mountRoot:createRoot("shadowRoot")
	self._loader = PrefabLoader.Get(self._shadowRoot)
	self._meshModel = self._unit.meshModel

	self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
end

function BattleUnitCompShadow:onReuse()
	return
end

function BattleUnitCompShadow:onReset()
	self._loader:clear()
end

function BattleUnitCompShadow:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	self._loader:clear()
end

function BattleUnitCompShadow:rebuildShadow(resPath)
	local rectangle = self._unit.transform:getRectangle()

	if rectangle then
		local centerX, centerZ = rectangle:getCenterXZ()
		local scaleX = rectangle:getMaxx() - rectangle:getMinx() + 1
		local scaleZ = rectangle:getMaxz() - rectangle:getMinz() + 1

		Astral.TransformUtil.SetLocalPos(self._shadowRoot.transform, centerX, BattleConst.YOffsetUnitShadow, centerZ)
		Astral.TransformUtil.SetLocalScale(self._shadowRoot.transform, scaleX, 1, scaleZ)
	else
		Astral.TransformUtil.SetLocalPos(self._shadowRoot.transform, 0, BattleConst.YOffsetUnitShadow, 0)
		Astral.TransformUtil.SetLocalScale(self._shadowRoot.transform, 1, 1, 1)
	end

	self._loader:load(resPath)
end

function BattleUnitCompShadow:_onMeshModelLoaded()
	return
end

return BattleUnitCompShadow
