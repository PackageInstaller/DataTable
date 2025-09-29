-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompTerrainModel.lua

module("logic.battle.unit.comp.BattleUnitCompTerrainModel", package.seeall)

local M = class("BattleUnitCompTerrainModel", UnitComponentBase, IBattleUnitComponent)

function M:onInit()
	self._goAvatar = self._unit.mountRoot:getAvatarRoot()
	self._resLoader = SingleResLoader.New()
	self._meshModelMover = self._unit.meshModelMover
	self._terrainCellList = {}

	self:onReuse()
end

function M:onReset()
	self._isMultiUnit = false

	self:clear()
end

function M:onEnable()
	for k, cell in pairs(self._terrainCellList) do
		cell:onEnable()
	end
end

function M:onDestroy()
	M.super.onDestroy(self)
	self:clear()

	self._resLoader = false
end

function M:setBody(url)
	self._isMultiUnit = self._unit.rectangle:getGroupType() == BattleEnum.AdditionalTerrainGroup.PointAdd

	self:clear()
	self._resLoader:load(url, self._onResLoaded, self, true)
end

function M:clear()
	self._cellCount = 0
	self._animation = false

	self._resLoader:clear()
	BattleTableUtil.clearReusableTable(self._terrainCellList)
end

function M:playBornAnimation()
	for k, cell in pairs(self._terrainCellList) do
		cell:playBornAnimation()
	end
end

function M:getCellList()
	return self._terrainCellList
end

function M:_onResLoaded()
	if self._isMultiUnit then
		for i, cellComp in pairs(self._terrainCellList) do
			local goInst = self._resLoader:getResInstance()

			goutil.addChildToParent(goInst, self._goAvatar)
			cellComp:buildUI(goInst)
			cellComp:playBornAnimation()
		end
	else
		self:getOrCreateByUnionIndex(-1)
	end
end

function M:getOrCreateByPos(x, y, index)
	local unionIndex = x * 1000 + y * 10 + index

	return self:getOrCreateByUnionIndex(unionIndex)
end

function M:getOrCreateByUnionIndex(unionIndex)
	if self._terrainCellList[unionIndex] then
		return self._terrainCellList[unionIndex]
	end

	local cellComp = BattleGroupTerrainCell:createInstance()

	if self._resLoader:isLoaded() then
		local goInst = self._resLoader:getResInstance()

		cellComp:buildUI(goInst)
		goutil.addChildToParent(goInst, self._goAvatar)
	end

	cellComp:setAnimDoneListnener(self._animationDoneListener, self)
	cellComp:setPosAndIndexUnion(unionIndex)
	cellComp:playBornAnimation()

	self._terrainCellList[unionIndex] = cellComp
	self._cellCount = self._cellCount + 1

	return cellComp
end

function M:playClearAnimation()
	if self._cellCount > 0 then
		for k, cell in pairs(self._terrainCellList) do
			cell:playClearAnimation()
		end
	else
		BattleUnitGenerator.destroyUnit(self._unit)
	end
end

function M:_animationDoneListener(animName, unionIndex)
	if animName == "end" then
		self._cellCount = self._cellCount - 1

		if unionIndex then
			self._terrainCellList[unionIndex] = nil
		end

		if self._cellCount == 0 then
			BattleUnitGenerator.destroyUnit(self._unit)
		end
	end
end

function M:resetRemoveState()
	for k, cell in pairs(self._terrainCellList) do
		cell:setRemoveState(true)
	end
end

function M:removeTerrainWithState()
	for k, cell in pairs(self._terrainCellList) do
		if cell:getRemoveState() then
			cell:playClearAnimation()
		end
	end
end

return M
