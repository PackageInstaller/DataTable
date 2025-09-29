-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattlePlotPerformanceMgr.lua

module("logic.battle.battleflow.component.BattlePlotPerformanceMgr", package.seeall)

local BattlePlotPerformanceMgr = class("BattlePlotPerformanceMgr", IBattleFlowComp, AbstractGlobalReusable)
local kFollowCenter = "follow_center"
local kPlotAvatarSynchronizer = typeof(SpaceX.PlotAvatarSynchronizer)
local kCreateType = {
	Exist = 1,
	Create = 0
}

function BattlePlotPerformanceMgr:onStart()
	self._unitMgr = self.flow.unitMgr or false
	self._resLoader = SingleResLoader.New()
	self._handler = Handler.New()
	self._synchronizers = {}
	self._plotUnits = {}
	self._existsUnits = {}
	self._goInst = false
end

function BattlePlotPerformanceMgr:onClear()
	if self._goInst then
		self:clear()
	end
end

function BattlePlotPerformanceMgr:start(url, callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self._resLoader:load(url, self._onResLoaded, self)
end

function BattlePlotPerformanceMgr:clear()
	self:_adjustCameraCenter()
	self:_clearSynchronizers()
	self:_clearPlotUnits()
	self:_clearExistsUnits()
	self:_showAllUnitUI()
	self._handler:clear()
	self._resLoader:clear()

	if self._goInst then
		goutil.destroy(self._goInst)

		self._goInst = false
	end
end

function BattlePlotPerformanceMgr:_clearSynchronizers()
	for _, synchronizer in ipairs(self._synchronizers) do
		synchronizer:ClearMainGameObject()
	end

	BattleTableUtil.clearTable(self._synchronizers)
end

function BattlePlotPerformanceMgr:_clearPlotUnits()
	BattleTableUtil.clearReusableTable(self._plotUnits)
end

function BattlePlotPerformanceMgr:_clearExistsUnits()
	for _, unit in ipairs(self._existsUnits) do
		self:_resumeUnitFromPerformance(unit)
	end

	BattleTableUtil.clearTable(self._existsUnits)
end

function BattlePlotPerformanceMgr:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()

	goutil.addChildToParent(self._goInst, SceneMgr.instance:getSceneRoot())

	local proxy = Timeline.PlayableDirectorProxy.Get(self._goInst)

	proxy:AddListener(self._onTimelineFinished, self)
	self:_setupBindings()
	self:_hideAllUnitUI()
end

function BattlePlotPerformanceMgr:_setupBindings()
	local list = BattleTableUtil.getTempList()

	GameObjectUtils.GetComponentsInChildren(self._goInst, kPlotAvatarSynchronizer, list)

	for _, avatarSynchronizer in ipairs(list) do
		if avatarSynchronizer.createType == kCreateType.Create then
			local modelCode = avatarSynchronizer.modelCode
			local unit = self:_createPlotUnit(avatarSynchronizer.modelCode)

			unit.avatarSynchronizer:setAvatarSynchronizer(avatarSynchronizer)
		elseif avatarSynchronizer.createType == kCreateType.Exist then
			local x, z = avatarSynchronizer:GetCellPosition(0, 0)
			local unit = self._unitMgr:getUnitOnUnionIndex(BoardIndexConverter.coordinatesToUnionIndex(x, z))

			if unit then
				self:_setupUnitForPerformance(unit)
				avatarSynchronizer:SetMainGameObject(unit.mountRoot:getRoot())
				BattlePlotUnitCompAvatarSynchronizer:setupModelModifier(avatarSynchronizer.gameObject, unit)
				table.insert(self._existsUnits, unit)
			elseif BattleLog.enableError then
				BattleLog.error(string.format("Cannot find unit on cell[%s, %s]", x, z))
			end
		end
	end

	BattleTableUtil.releaseTempList(list)
end

function BattlePlotPerformanceMgr:_createPlotUnit(modelCode)
	local unit = BattlePlotUnit:createInstance(modelCode)

	table.insert(self._plotUnits, unit)

	local modelCO = ModelConfig.instance:getModelConfig(modelCode)

	unit.property:setModelCode(modelCode)
	unit.meshModel:setBody(ModelCOUtil.getLowModelUrl(modelCO))
	BattleUnitGenerator.addUnitToScene(unit)

	return unit
end

function BattlePlotPerformanceMgr:_onTimelineFinished()
	self._handler:call()
	self:clear()
end

function BattlePlotPerformanceMgr:_setupUnitForPerformance(unit)
	local root = unit.mountRoot:getRoot()
	local x, y, z = unit.meshModel:getLookAtDir()

	TransformUtils.SetEulerAngles(root.transform, x, y, z)
	unit.meshModel:lookAtDir(0, 0, 0)
end

function BattlePlotPerformanceMgr:_resumeUnitFromPerformance(unit)
	unit.mover:forceSyncPosition()

	local root = unit.mountRoot:getRoot()
	local x, y, z = TransformUtils.GetEulerAngles(root.transform, 0, 0, 0)

	TransformUtils.SetEulerAngles(root.transform, 0, 0, 0)
	unit.meshModel:lookAtDir(x, y, z)
end

function BattlePlotPerformanceMgr:_hideAllUnitUI()
	local units = self._unitMgr:getAllUnits()

	for _, unit in ipairs(units) do
		if unit.property:isMaskEnable(BattleUnitFlagMask.MaskAttackable) then
			unit:setProxyVisible(false)
		end
	end
end

function BattlePlotPerformanceMgr:_showAllUnitUI()
	local units = self._unitMgr:getAllUnits()

	if not units then
		return
	end

	for _, unit in ipairs(units) do
		if unit.property:isMaskEnable(BattleUnitFlagMask.MaskAttackable) and unit:isActive() then
			unit:setProxyVisible(true)
		end
	end
end

function BattlePlotPerformanceMgr:_adjustCameraCenter()
	local goFollowCenter = goutil.findChild(self._goInst, kFollowCenter)

	if goFollowCenter then
		local x, y, z = TransformUtils.GetPosition(goFollowCenter.transform, 0, 0, 0)

		BattleCameraUtil.doFollowPosition(x, y, z, 0)
	end
end

return BattlePlotPerformanceMgr
