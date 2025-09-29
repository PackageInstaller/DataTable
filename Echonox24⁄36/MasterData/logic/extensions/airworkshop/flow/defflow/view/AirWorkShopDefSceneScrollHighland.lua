-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/AirWorkShopDefSceneScrollHighland.lua

module("logic.extensions.airworkshop.flow.defflow.view.AirWorkShopDefSceneScrollHighland", package.seeall)

local M = class("AirWorkShopDefSceneScrollHighland", AirWorkShopDefSceneScrollBuildingBase)

function M:buildUI()
	self._btnSwitch = Astral.ButtonAdapter.GetFrom(self.mainGO, "btnSwitch")

	self._btnSwitch:AddClickListener(self._onClickSwitch, self)

	self._canFlyBtnGo = goutil.findChild(self.mainGO, "btnSwitch/state1")
	self._canotFlyBtnGo = goutil.findChild(self.mainGO, "btnSwitch/state2")

	M.super.buildUI(self)
end

function M:destroy()
	M.super.destroy(self)
	self._btnSwitch:RemoveClickListener()
end

function M:_initData()
	self._canFly = true

	M.super._initData(self)
end

function M:_updateCurBuildings()
	goutil.setActive(self._canFlyBtnGo, self._canFly)
	goutil.setActive(self._canotFlyBtnGo, not self._canFly)
	BattleTableUtil.clearTable(self._curBuildingCOList)

	for i, buildCO in ipairs(self._buildingCOList) do
		if buildCO.canFly == self._canFly then
			table.insert(self._curBuildingCOList, buildCO)
		end
	end
end

function M:_getAllBuildingList()
	return AirWorkShopDefSceneModel.instance:getAvailableHighlandCOList()
end

function M:_onClickSwitch()
	self._canFly = not self._canFly

	self:_updateCurBuildings()
	self:_updateScrollView()
end

function M:_afterEndDrag(dragUnit, unionIndex)
	AirWorkShopDefOperateUtil.tryCombineHighland(dragUnit, unionIndex)
end

function M:_getUnitTagType()
	return AirWorkShopEnum.TabEnum.Highland
end

function M:cancelSelectedId()
	if self._selectBuildingId == -1 then
		return
	end

	self._lastSelectedCharacterId = self._selectBuildingId
	self._selectBuildingId = -1

	AirWorkShopDefOperateUtil.setCoverHighlandIdAndCreate(false)
	self:_updateScrollView()
end

function M:setSelectedId(characterId)
	if self._selectBuildingId == characterId then
		return
	end

	self._lastSelectedCharacterId = self._selectBuildingId
	self._selectBuildingId = characterId

	AirWorkShopDefOperateUtil.setCoverHighlandIdAndCreate(self._selectBuildingId)
	self:_updateScrollView()
end

return M
