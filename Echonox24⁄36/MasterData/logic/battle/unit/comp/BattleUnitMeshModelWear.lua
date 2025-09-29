-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitMeshModelWear.lua

module("logic.battle.unit.comp.BattleUnitMeshModelWear", package.seeall)

local M = class("BattleUnitMeshModelWear", UnitComponentBase)

function M:onInit()
	self:_setEvents(true)

	self._resPathDic = {}
	self._resGoDic = {}
	self._resLoader = MultiResLoader.New()
	self._hasWear = false
end

function M:onInitFinish()
	local modelCode = self._unit.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modelCode)

	if modelCO.mountWear and #modelCO.mountWear > 0 then
		self._hasWear = true

		for i, key in ipairs(modelCO.mountWear) do
			self._resPathDic[key] = BattleEnum.ModelWearKeyRes[key]
		end
	end

	if self._unit.meshModel:hasLoadedRes() then
		self:_onMeshModelLoaded()
	end
end

function M:onReset()
	self._hasWear = false

	self:_setEvents(false)
	table.clear(self._resPathDic)
	self:_clearWearAndRelease()
end

function M:_setEvents(isOn)
	if isOn then
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	end
end

function M:_onMeshModelLoaded()
	if not self._hasWear then
		return
	end

	if not self._unit.meshModel:isLowModel() then
		self:_loadHighModelWear()
	else
		self:_clearWearAndRelease()
	end
end

function M:_loadHighModelWear()
	self:_addResPathToLoader()
	self._resLoader:load(self._onWearLoaded, false, self)
end

function M:_addResPathToLoader()
	for i, resPath in pairs(self._resPathDic) do
		self._resLoader:addResPath(resPath)
	end
end

function M:_onWearLoaded()
	for key, path in pairs(self._resPathDic) do
		local parentGo = GameObjectUtils.FindChildRecursively(self._unit.meshModel:getInst(), 10, key)

		if parentGo then
			local res = self._resLoader:getResource(path)

			self._resGoDic[key] = goutil.clone(res:GetMainAsset())

			goutil.addChildToParent(self._resGoDic[key], parentGo)
		end
	end
end

function M:_clearWearAndRelease()
	self._resLoader:clear()

	for k, wearGo in pairs(self._resGoDic) do
		if wearGo then
			goutil.destroy(wearGo)
		end
	end

	table.clear(self._resGoDic)
end

function M:onDestroy()
	self:onReset()
end

return M
