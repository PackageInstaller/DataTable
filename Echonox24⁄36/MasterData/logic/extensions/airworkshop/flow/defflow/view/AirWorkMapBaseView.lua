-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/AirWorkMapBaseView.lua

module("logic.extensions.airworkshop.flow.defflow.view.AirWorkMapBaseView", package.seeall)

local M = class("AirWorkMapBaseView", ViewComponent)
local gridRow = 15
local gridColumn = 15

AirWorkShopBuildingEnum = {
	AirWorkShopEnum.UnitType.GroundBuilding,
	AirWorkShopEnum.UnitType.MountainBuilding,
	AirWorkShopEnum.UnitType.SpecialBuilding
}

function M:ctor()
	M.super.ctor(self)

	self._mapGrids = false
	self._mapGridsDataType = false
end

function M:buildUI()
	self._mapGridGo = self:getGo("0&air_workshop_terrain_grid_item_896512179")

	goutil.setActive(self._mapGridGo, false)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	self:_removeListener()
end

function M:onEnter()
	local levelId = AirWorkMapModel.instance:getFirstLevel()
	local guanQiaData = AirWorkMapModel.instance:getLevelMOById(levelId)

	self._mapData = guanQiaData:getMapMO()

	self:_setMapData()
end

function M:onExitFinished()
	self:_setGridStatus(0)
end

function M:destroyUI()
	self:_removeListener()

	self._mapGrids = false
	self._mapGridsDataType = false
end

function M:_removeListener()
	for i, v in ipairs(self._mapGrids or {}) do
		local btnClick = Astral.ButtonAdapter.Get(goutil.findChild(v, "btnClick"))

		btnClick:RemoveClickListener()
	end
end

function M:createMap()
	self._mapGrids = {}
	self._mapGridsDataType = {}

	for i = 1, gridRow * gridColumn do
		local gridGo = goutil.cloneAndSetParent(self._mapGridGo, self._mapRootGo.transform, "grid" .. i)

		goutil.setActive(gridGo, true)

		local btnClick = Astral.ButtonAdapter.Get(goutil.findChild(gridGo, "btnClick"))

		btnClick:AddClickListener(function()
			self:_onGridClick(i)
		end, self)
		table.insert(self._mapGrids, gridGo)

		self._mapGridsDataType[i] = 0
	end
end

function M:_resetMap()
	self._mapGridsDataType = {}

	for i = 1, gridRow * gridColumn do
		self:_setGridData(i, 0)

		self._mapGridsDataType[i] = 0
	end
end

function M:refreshMap()
	self:_resetMap()
	self:_setMapData()
end

function M:onGridClick(index)
	self:_setGridStatus(index)

	local x, y = AirWorkShopUtil.convertToXY(index)
end

function M:showKillData(data, isShow)
	self._cellKillMoList = data

	for i, v in ipairs(self._cellKillMoList) do
		local x, y = v:getPosition()
		local gridIndex = AirWorkShopUtil.convertXYtoIndex(x, y)

		self:_setGridData(gridIndex, AirWorkShopEnum.UnitType.KillData, isShow, v)
	end
end

function M:lookMessage(isShow)
	self._showMessage = isShow

	for i, v in ipairs(self._mapGrids) do
		local messageGo = goutil.findChild(v, "objMessage")
		local messageImgGo = goutil.findChild(v, "objMessage/imgMessage")

		goutil.setActive(messageGo, isShow)
		goutil.setActive(messageImgGo, false)

		if isShow then
			goutil.setActive(messageImgGo, self:hasMessage(i))
		end
	end
end

function M:hasMessage(index)
	for i, v in ipairs(self._mapData:getBuildingList()) do
		local x, y = v:getPosition()
		local gridIndex = AirWorkShopUtil.convertXYtoIndex(x, y)

		if index == gridIndex and v:getMsgMO() then
			return true
		end
	end

	for i, v in ipairs(self._mapData:getHeroMOList()) do
		local x, y = v:getPosition()
		local gridIndex = AirWorkShopUtil.convertXYtoIndex(x, y)

		if index == gridIndex and v:getMsgMO() then
			return true
		end
	end

	for i, v in ipairs(self._mapData:getAmbushMOList()) do
		local x, y = v:getPosition()
		local gridIndex = AirWorkShopUtil.convertXYtoIndex(x, y)

		if index == gridIndex and v:getMsgMO() then
			return true
		end
	end

	return false
end

function M:_setMapData()
	local sceneId = self._mapData:getSceneId()
	local sceneCo = AirWorkShopConfig.instance:getSceneCO(sceneId)
	local levelCo = BattleConfig.instance:getBattleLevelCO(sceneCo.levelId)
	local bordCo = BattleConfig.instance:getCheckerBoardCO(levelCo.sceneId)

	for i, v in ipairs(bordCo.cellConfigs) do
		local canWark = v.isEnable
		local x, y = v.coordinates[1], v.coordinates[2]
		local gridIndex = AirWorkShopUtil.convertXYtoIndex(x, y)

		if canWark then
			self:_setGridData(gridIndex, AirWorkShopEnum.UnitType.Ground)
		else
			self:_setGridData(gridIndex, 0)
		end
	end

	for i, v in ipairs(self._mapData:getBuildingList()) do
		local x, y = v:getPosition()
		local gridIndex = AirWorkShopUtil.convertXYtoIndex(x, y)
		local buildingCo = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioBuilding, v:getId())

		self:_setGridData(gridIndex, AirWorkShopBuildingEnum[buildingCo.type])
	end

	for i, v in ipairs(self._mapData:getHeroMOList()) do
		local x, y = v:getPosition()
		local gridIndex = AirWorkShopUtil.convertXYtoIndex(x, y)

		self:_setGridData(gridIndex, AirWorkShopEnum.UnitType.Hero, nil, v:getId())
	end

	for i, v in ipairs(self._mapData:getAmbushMOList()) do
		local x, y = v:getPosition()
		local gridIndex = AirWorkShopUtil.convertXYtoIndex(x, y)

		self:_setGridData(gridIndex, AirWorkShopEnum.UnitType.Ambush, nil, v:getId())
	end

	for i, v in ipairs(self._mapData:getBorns()) do
		local cellNO = v:getBornCell()
		local x, y = cellNO.cell.x, cellNO.cell.z
		local gridIndex = AirWorkShopUtil.convertXYtoIndex(x, y)

		self:_setGridData(gridIndex, AirWorkShopEnum.UnitType.BornPoint)
	end

	local condition = self._mapData:getCondition()

	if condition then
		local co = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioWinCondition, condition.id)

		if co then
			local exitPointList = {}

			if co.type == AirWorkShopEnum.ConditionType.Move then
				for i = 1, #condition.params, 2 do
					local x, y = condition.params[i], condition.params[i + 1]

					table.insert(exitPointList, {
						x = x,
						y = y
					})
				end
			end

			for i, v in ipairs(exitPointList) do
				local x, y = v.x, v.y
				local gridIndex = AirWorkShopUtil.convertXYtoIndex(x, y)

				self:_setGridData(gridIndex, AirWorkShopEnum.UnitType.ExitPoint)
			end
		end
	end
end

function M:_setGridData(index, type, isShow, cellData)
	self._mapGridsDataType[index] = type

	local gridGo = self._mapGrids[index]
	local groundGo = goutil.findChild(gridGo, "objGround")
	local groundBuildingGo = goutil.findChild(gridGo, "objHighland")
	local mountainBuildingGo = goutil.findChild(gridGo, "objMountain")
	local specialBuildingGo = goutil.findChild(gridGo, "objSpecial")
	local defenseGo = goutil.findChild(gridGo, "objDefense")
	local ambushGo = goutil.findChild(gridGo, "objAmbush")
	local conditionPosGo = goutil.findChild(gridGo, "objEnd")
	local killHighGo = goutil.findChild(gridGo, "objKillHight")
	local killMiddleGo = goutil.findChild(gridGo, "objKillMiddle")
	local killLowGo = goutil.findChild(gridGo, "objKillLow")
	local exitPointGo = goutil.findChild(gridGo, "objLeavePoint")
	local bornPointGo = goutil.findChild(gridGo, "objAttackPoint")
	local txtHigh = goutil.findChildTextComponent(killHighGo, "txtNum")
	local txtMiddle = goutil.findChildTextComponent(killMiddleGo, "txtNum")
	local txtLow = goutil.findChildTextComponent(killLowGo, "txtNum")

	goutil.setActive(groundGo, type == AirWorkShopEnum.UnitType.Ground)
	goutil.setActive(groundBuildingGo, type == AirWorkShopEnum.UnitType.GroundBuilding)
	goutil.setActive(mountainBuildingGo, type == AirWorkShopEnum.UnitType.MountainBuilding)
	goutil.setActive(specialBuildingGo, type == AirWorkShopEnum.UnitType.SpecialBuilding)
	goutil.setActive(defenseGo, type == AirWorkShopEnum.UnitType.Hero)
	goutil.setActive(ambushGo, type == AirWorkShopEnum.UnitType.Ambush)
	goutil.setActive(conditionPosGo, type == AirWorkShopEnum.UnitType.ConditionMovePosition)
	goutil.setActive(exitPointGo, type == AirWorkShopEnum.UnitType.ExitPoint)
	goutil.setActive(bornPointGo, type == AirWorkShopEnum.UnitType.BornPoint)

	if type == AirWorkShopEnum.UnitType.Hero then
		local imgIcon = goutil.findChildImageComponent(defenseGo, "headIcon")
		local heroId = cellData
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)
		local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())

		IconLoader.setSprite(imgIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	end

	if type == AirWorkShopEnum.UnitType.Ambush then
		local imgIcon = goutil.findChildImageComponent(ambushGo, "headIcon")
		local heroId = cellData
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)
		local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())

		IconLoader.setSprite(imgIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	end

	if type == AirWorkShopEnum.UnitType.KillData then
		local count = cellData:getCount()

		txtMiddle.text = count
		txtLow.text = count

		goutil.setActive(killHighGo, type == AirWorkShopEnum.UnitType.KillData and isShow and count > 99)
		goutil.setActive(killMiddleGo, type == AirWorkShopEnum.UnitType.KillData and isShow and count >= 10 and count < 99)
		goutil.setActive(killLowGo, type == AirWorkShopEnum.UnitType.KillData and isShow and count < 10)
	end
end

function M:_setGridStatus(index)
	for i, v in ipairs(self._mapGrids) do
		local selectGo = goutil.findChild(v, "imgSelect")

		goutil.setActive(selectGo, i == index)
	end
end

return M
