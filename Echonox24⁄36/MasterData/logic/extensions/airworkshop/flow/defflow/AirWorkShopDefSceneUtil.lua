-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/AirWorkShopDefSceneUtil.lua

module("logic.extensions.airworkshop.flow.defflow.AirWorkShopDefSceneUtil", package.seeall)

local AirWorkShopDefSceneUtil = {}

AirWorkShopDefSceneUtil.uniqueId = 1000

function AirWorkShopDefSceneUtil.setUnitForDrag(unit)
	unit.meshModelMover:setOffsetXYZ(0, 1, 0)
end

function AirWorkShopDefSceneUtil.requestUniqueId()
	AirWorkShopDefSceneUtil.uniqueId = AirWorkShopDefSceneUtil.uniqueId + 1

	return AirWorkShopDefSceneUtil.uniqueId
end

function AirWorkShopDefSceneUtil.createHero(heroId)
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)
	local mapMO = AirWorkShopDefSceneModel.instance:getMapMO()
	local entityId = AirWorkShopDefSceneUtil.requestUniqueId()
	local airHeroMO = mapMO:addHeroMO(entityId, heroId)

	return AirWorkShopUnitGenerator.createHeroUnit(airHeroMO)
end

function AirWorkShopDefSceneUtil.createHeroByHeroMO(airHeroMO)
	local entityId = AirWorkShopDefSceneUtil.requestUniqueId()

	airHeroMO:setEntityId(entityId)

	return AirWorkShopUnitGenerator.createHeroUnit(airHeroMO)
end

function AirWorkShopDefSceneUtil.createAmbushByHeroMO(airAmbushMO)
	local entityId = AirWorkShopDefSceneUtil.requestUniqueId()

	airAmbushMO:setEntityId(entityId)

	return AirWorkShopUnitGenerator.createHeroUnit(airAmbushMO)
end

function AirWorkShopDefSceneUtil.createBornUnitAndSetPos(unionIndex)
	local mapMO = AirWorkShopDefSceneModel.instance:getMapMO()
	local direction = AirWorkShopDefSceneUtil.getDirectionOfPos(unionIndex)
	local bornMO = mapMO:addBornPos(unionIndex, direction)
	local unit = AirWorkShopDefSceneUtil.createBornUnit(bornMO)

	AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(unit, unionIndex)
	AirWorkShopDefSceneUtil.requestPlacePos(unionIndex, unit)
end

function AirWorkShopDefSceneUtil.createBornUnit(bornMO)
	local entityId = AirWorkShopDefSceneUtil.requestUniqueId()

	bornMO:setEntityId(entityId)

	return AirWorkShopUnitGenerator.createBornPos(bornMO)
end

function AirWorkShopDefSceneUtil.createLeaveUnitAndSetPos(unionIndex)
	local mapMO = AirWorkShopDefSceneModel.instance:getMapMO()
	local unitMO = mapMO:addLeaveMO(unionIndex)
	local unit = AirWorkShopDefSceneUtil.createLeaveUnit(unitMO)

	AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(unit, unionIndex)
	AirWorkShopDefSceneUtil.requestPlacePos(unionIndex, unit)
end

function AirWorkShopDefSceneUtil.createLeaveUnit(unitMO)
	local entityId = AirWorkShopDefSceneUtil.requestUniqueId()

	unitMO:setEntityId(entityId)

	return AirWorkShopUnitGenerator.createLeavePos(unitMO)
end

function AirWorkShopDefSceneUtil.requestPlaceHero(heroId, unionIndex, unit)
	printWarn("viking", "place", heroId, unionIndex, unit.property:getName())
	AirWorkShopDefSceneModel.instance:setCharacterInTeam(heroId)
	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnAvailableHeroListUpdate)

	local pathArrow = AirWorkShopDefMgr.instance:getPathArrow()

	pathArrow:removeCurrentFocus()
	AirWorkShopDefSceneUtil.addUnit(unit, unionIndex)
	AirWorkShopDefSceneModel.instance:refreshUnitCount()
end

function AirWorkShopDefSceneUtil.createHighland(buildingId)
	local mapMO = AirWorkShopDefSceneModel.instance:getMapMO()
	local entityId = AirWorkShopDefSceneUtil.requestUniqueId()
	local airMO = mapMO:addHighlandMO(entityId, buildingId)

	return AirWorkShopUnitGenerator.createBuildingUnit(airMO)
end

function AirWorkShopDefSceneUtil.onlyCreateHighland(buildingId)
	local entityId = AirWorkShopDefSceneUtil.requestUniqueId()
	local airMO = AirWorkBuildingMO:createInstance(entityId, buildingId)

	return AirWorkShopUnitGenerator.createBuildingUnit(airMO)
end

function AirWorkShopDefSceneUtil.createHighlandByMO(buildMO)
	local entityId = AirWorkShopDefSceneUtil.requestUniqueId()

	buildMO:setEntityId(entityId)

	return AirWorkShopUnitGenerator.createBuildingUnit(buildMO)
end

function AirWorkShopDefSceneUtil.requestPlaceBuilding(buildId, unionIndex, unit)
	printWarn("viking", "place", buildId, unionIndex, unit.property:getName())

	local pathArrow = AirWorkShopDefMgr.instance:getPathArrow()

	pathArrow:removeCurrentFocus()
	AirWorkShopDefSceneUtil.addUnit(unit, unionIndex)
	AirWorkShopDefSceneModel.instance:refreshUnitCount()
end

function AirWorkShopDefSceneUtil.requestPlacePos(unionIndex, unit)
	printWarn("viking", "placePos", unionIndex, unit.property:getName(), unit.property:getEntityId())

	local pathArrow = AirWorkShopDefMgr.instance:getPathArrow()

	pathArrow:removeCurrentFocus()
	AirWorkShopDefSceneUtil.addUnit(unit, unionIndex)
end

function AirWorkShopDefSceneUtil.requestRemoveEntity(unit)
	if not unit then
		return
	end

	AirWorkShopDefOperateUtil.clearSceneFocusUnit()

	local entityId = unit.property:getEntityId()
	local x, z = unit.transform:getCoordinates()

	if x and z and unit.property:getTabType() == AirWorkShopEnum.TabEnum.Hero then
		AirWorkShopDefSceneModel.instance:setCharacterOutTeam(unit.property:getEntityCode())
		BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnAvailableHeroListUpdate)
	end

	local pathArrow = AirWorkShopDefMgr.instance:getPathArrow()

	pathArrow:removeCurrentFocus()
	AirWorkShopDefSceneUtil._removeUnit(unit)
	AirWorkShopDefSceneModel.instance:refreshUnitCount()
end

function AirWorkShopDefSceneUtil.requestMoveEntity(unit, unionIndex)
	if not unit then
		return
	end

	local entityId = unit.property:getEntityId()
	local currentUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())

	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnBoardUsedUpdate)
	AirWorkShopDefSceneUtil.exchangeUnitToUnionIndex(unit, unionIndex)
end

function AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(unit, unionIndex)
	local boardMgr = AirWorkShopDefMgr.instance:getBoardMgr()
	local position = boardMgr:getCellPosition(unionIndex)

	unit.uiProxy:setVisible(true)
	unit.meshModelMover:setOffsetXYZ(0, 0, 0)
	unit.mover:setPosDirectly(position.x, position.z)
	unit.meshModel:lookAtDirVec3(MeshModelDirection.Default)
end

function AirWorkShopDefSceneUtil.addUnit(unit, unionIndex)
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()
	local boardMgr = AirWorkShopDefMgr.instance:getBoardMgr()

	boardMgr:setUnitToUnionIndex(unit, unionIndex)
	unitMgr:addUnit(unit)
end

function AirWorkShopDefSceneUtil.onlyRemoveUnit(unit)
	AirWorkShopUnitGenerator.removeUnit(unit)
	AirWorkShopUnitGenerator.destroyUnit(unit)
end

function AirWorkShopDefSceneUtil._removeUnit(unit)
	AirWorkShopDefSceneModel.instance:removeUnitMO(unit)
	AirWorkShopUnitGenerator.removeUnit(unit)
	AirWorkShopUnitGenerator.destroyUnit(unit)
end

function AirWorkShopDefSceneUtil.exchangeUnitToUnionIndex(unit, unionIndex)
	local boardMgr = AirWorkShopDefMgr.instance:getBoardMgr()

	boardMgr:exchangeUnitToUnionIndex(unit, unionIndex)
end

function AirWorkShopDefSceneUtil.showFocusSign(unionIndex)
	local pathArrow = AirWorkShopDefMgr.instance:getPathArrow()

	pathArrow:showFocusSign(unionIndex)
end

function AirWorkShopDefSceneUtil.hideFocusSign()
	local pathArrow = AirWorkShopDefMgr.instance:getPathArrow()

	pathArrow:hideFocusSign()
end

function AirWorkShopDefSceneUtil.playPlaceEffect(unit)
	local placeEffectId = AirWorkShopDefSceneUtil.getPlaceEffectId(unit)

	unit.effectPlayer:playEffect(placeEffectId)
end

function AirWorkShopDefSceneUtil.getPlaceEffectId(unit)
	local effectId = BattleConst.PLACE_ENTITY

	if unit.transform then
		local rect = unit.transform:getRectangle()

		if rect then
			local xlen = rect:getMaxx() - rect:getMinx()
			local zlen = rect:getMaxz() - rect:getMinz()

			if xlen >= 1 and zlen >= 1 then
				effectId = BattleConst.PLACE_ENTITY2x2
			end
		end
	end

	return effectId
end

function AirWorkShopDefSceneUtil.canSetAmbush(unitMO)
	if unitMO:getUnitType() == AirWorkShopEnum.UnitType.Ambush then
		return true
	end

	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()
	local maxCount = AirWorkShopDefSceneModel.instance:getCurUnitTypeLimit(AirWorkShopEnum.UnitType.Ambush)
	local count = 0

	for k, unit in pairs(unitMgr:getAllUnit()) do
		if unit.property:getUnitType() == AirWorkShopEnum.UnitType.Ambush then
			count = count + 1
		end
	end

	return count < maxCount
end

function AirWorkShopDefSceneUtil.getBuildingPath(buildCO)
	if buildCO.terrainId > 0 then
		local terrainCO = BattleConfigUtil.getEntityConfig(buildCO.terrainId)

		return GameUrl.getTerrainModelUrl(terrainCO.resPath)
	else
		return string.format("scene/sx_scene-assets/sx-s111_city/sx-s111_city_b_04/prefab/%s.prefab", buildCO.resName)
	end
end

function AirWorkShopDefSceneUtil.checkMapMOLegal(mapMO)
	local heroList = mapMO:getHeroMOList()

	if #heroList <= 0 then
		FloatWordMgr.instance:show(lang("tip_airwork_at_least_add_one_hero"))

		return false
	end

	local tagList = mapMO:getTags()

	if #tagList <= 0 then
		ViewMgr.instance:open(ViewName.AirWorkShopSettingView, 2)
		FloatWordMgr.instance:show(lang("tip_airwork_at_least_add_one_tag"))

		return false
	end

	return true
end

function AirWorkShopDefSceneUtil.checkModified()
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelId = model:getLevelId()

	if not levelId then
		return true
	end

	local modifiedMapMO = model:getModiedMapMO()
	local levelMO = AirWorkMapModel.instance:getLevelMOById(levelId)

	return not modifiedMapMO:isSame(levelMO:getMapMO())
end

function AirWorkShopDefSceneUtil.hasTest(levelId)
	return
end

function AirWorkShopDefSceneUtil.tryRemoveUnit(removedUnit, showToast)
	if AirWorkShopDefSceneUtil.canRemoveUnit(removedUnit, showToast) then
		AirWorkShopDefSceneUtil.requestRemoveEntity(removedUnit)

		return true
	end

	return false
end

function AirWorkShopDefSceneUtil.canRemoveUnit(removedUnit, showToast)
	if removedUnit.property:getTabType() == AirWorkShopEnum.TabEnum.Hero then
		local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()

		for k, unit in pairs(unitMgr:getAllUnit()) do
			if unit.property:getUnitType() == AirWorkShopEnum.UnitType.Ambush then
				local unitMO = unit.property:getUnitMO()

				if unitMO:getParams() == removedUnit.property:getEntityCode() then
					if showToast then
						FloatWordMgr.instance:show(string.format(lang("tip_airwork_ambush_set_with_hero"), unit.property:getName()))
					end

					return false
				end
			end
		end
	end

	return true
end

function AirWorkShopDefSceneUtil.getExtraWinConditionDesc(extraConditionNO)
	local params = extraConditionNO.params
	local co = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioWinCondition, extraConditionNO.id)

	if co.type == AirWorkShopEnum.ConditionType.Kill then
		local heroInfoCo = PastInfoConfig.instance:getCharacterInfo(params[1])

		return string.format(co.battleDescribe, heroInfoCo.name)
	else
		return co.battleDescribe
	end
end

function AirWorkShopDefSceneUtil.getMapCenterPosByLevelId(checkerBoardCode)
	local boardCO = BattleConfig.instance:getCheckerBoardCO(checkerBoardCode)

	if boardCO then
		return math.floor(boardCO.width / 2), math.floor(boardCO.height / 2)
	end

	return 0, 0
end

function AirWorkShopDefSceneUtil.getDirectionOfPos(unionIndex)
	local model = AirWorkShopDefMgr.instance:getModel()
	local sceneCode = model:getBattleSceneCode()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local boardCO = BattleConfig.instance:getCheckerBoardCO(sceneCode)

	if boardCO then
		local centerX = math.floor(boardCO.width / 2)
		local centerZ = math.floor(boardCO.height / 2)

		if math.abs(centerX - x) > math.abs(centerZ - z) then
			if centerX <= x then
				return BattleEnum.Direction.Left
			else
				return BattleEnum.Direction.Right
			end
		elseif centerZ <= z then
			return BattleEnum.Direction.Down
		else
			return BattleEnum.Direction.Up
		end
	end
end

function AirWorkShopDefSceneUtil.reset2BakeMap(mapMO, bakeMapMO, curState)
	if curState == AirWorkShopEnum.DefState.Clear then
		AirWorkShopDefSceneUtil.removeAllHeroAndBuildings(mapMO)

		local heroList = mapMO:getHeroMOList()
		local bakeHeroList = bakeMapMO:getHeroMOList()

		table.insertto(heroList, bakeHeroList)

		local ambushMOList = mapMO:getAmbushMOList()
		local bakeAmbushMOList = bakeMapMO:getAmbushMOList()

		table.insertto(ambushMOList, bakeAmbushMOList)

		local buildingMOList = mapMO:getBuildingList()
		local bakeBuildingMOList = bakeMapMO:getBuildingList()

		table.insertto(buildingMOList, bakeBuildingMOList)
		AirWorkShopDefSceneUtil.placeAllHeroAndBuildings(mapMO)
	end

	if curState == AirWorkShopEnum.DefState.BornPosSet then
		AirWorkShopDefSceneUtil.removeAllBornPos(mapMO)

		local bornMOList = mapMO:getBorns()
		local bakebornMOList = bakeMapMO:getBorns()

		table.insertto(bornMOList, bakebornMOList)
		AirWorkShopDefSceneUtil.placeAllBornPos(mapMO)
	end

	if curState == AirWorkShopEnum.DefState.LeavePosSet then
		AirWorkShopDefSceneUtil.removeAllLeavePos(mapMO)

		local moList = mapMO:getLeaveMOs()
		local bakeMOList = bakeMapMO:getLeaveMOs()

		table.insertto(moList, bakeMOList)
		AirWorkShopDefSceneUtil.placeAllLeavePos(mapMO)
	end
end

function AirWorkShopDefSceneUtil.resetExtraWinCondition2BakeMap(mapMO, bakeMapMO)
	local extra = mapMO:getCondition()
	local bakeExtra = bakeMapMO:getCondition()

	if extra and bakeExtra then
		extra.id = bakeExtra.id

		for i, v in ipairs(bakeExtra.params) do
			extra.params[i] = v
		end
	elseif extra then
		extra.id = 0

		table.clear(extra.params)
	end
end

function AirWorkShopDefSceneUtil.removeAllBornPos(mapMO)
	local tempList = BattleTableUtil.getTempList()
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()

	for i, bornMO in ipairs(mapMO:getBorns()) do
		local unit = unitMgr:getUnit(bornMO:getEntityId())

		if unit then
			table.insert(tempList, unit)
		end
	end

	for i, unit in ipairs(tempList) do
		AirWorkShopDefSceneUtil.requestRemoveEntity(unit)
	end

	BattleTableUtil.releaseTempList(tempList)
end

function AirWorkShopDefSceneUtil.removeAllLeavePos(mapMO)
	local tempList = BattleTableUtil.getTempList()
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()

	for i, leaveMO in ipairs(mapMO:getLeaveMOs()) do
		local unit = unitMgr:getUnit(leaveMO:getEntityId())

		if unit then
			table.insert(tempList, unit)
		end
	end

	for i, unit in ipairs(tempList) do
		AirWorkShopDefSceneUtil.requestRemoveEntity(unit)
	end

	BattleTableUtil.releaseTempList(tempList)
end

function AirWorkShopDefSceneUtil.removeAllHeroAndBuildings(mapMO)
	local tempList = BattleTableUtil.getTempList()
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()

	for i, unitMO in ipairs(mapMO:getBuildingList()) do
		local unit = unitMgr:getUnit(unitMO:getEntityId())

		if unit then
			table.insert(tempList, unit)
		end
	end

	for i, unit in ipairs(tempList) do
		AirWorkShopDefSceneUtil.requestRemoveEntity(unit)
	end

	BattleTableUtil.clearTable(tempList)

	for i, unitMO in ipairs(mapMO:getHeroMOList()) do
		local unit = unitMgr:getUnit(unitMO:getEntityId())

		if unit then
			table.insert(tempList, unit)
		end
	end

	for i, unit in ipairs(tempList) do
		AirWorkShopDefSceneUtil.requestRemoveEntity(unit)
	end

	BattleTableUtil.clearTable(tempList)

	for i, unitMO in ipairs(mapMO:getAmbushMOList()) do
		local unit = unitMgr:getUnit(unitMO:getEntityId())

		if unit then
			table.insert(tempList, unit)
		end
	end

	for i, unit in ipairs(tempList) do
		AirWorkShopDefSceneUtil.requestRemoveEntity(unit)
	end

	BattleTableUtil.releaseTempList(tempList)
end

function AirWorkShopDefSceneUtil.placeAllHeroAndBuildings(mapMO)
	local heroMOList = mapMO:getHeroMOList()

	for i, heroMO in ipairs(heroMOList) do
		local heroId = heroMO:getId()
		local unionIndex = heroMO:getUnionIndex()
		local unit = AirWorkShopDefSceneUtil.createHeroByHeroMO(heroMO)

		AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(unit, unionIndex)
		AirWorkShopDefSceneUtil.requestPlaceHero(heroId, unionIndex, unit)
	end

	local ambushMOList = mapMO:getAmbushMOList()

	for i, ambushMO in ipairs(ambushMOList) do
		local heroId = ambushMO:getId()
		local unionIndex = ambushMO:getUnionIndex()
		local unit = AirWorkShopDefSceneUtil.createAmbushByHeroMO(ambushMO)

		AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(unit, unionIndex)
		AirWorkShopDefSceneUtil.requestPlaceHero(heroId, unionIndex, unit)
	end

	local buildingMOList = mapMO:getBuildingList()

	for i, buildMO in ipairs(buildingMOList) do
		local buildId = buildMO:getId()
		local unionIndex = buildMO:getUnionIndex()
		local unit = AirWorkShopDefSceneUtil.createHighlandByMO(buildMO)

		AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(unit, unionIndex)
		AirWorkShopDefSceneUtil.requestPlaceBuilding(buildId, unionIndex, unit)
	end
end

function AirWorkShopDefSceneUtil.placeAllBornPos(mapMO)
	local bornMOList = mapMO:getBorns()

	for i, bornMO in ipairs(bornMOList) do
		local unit = AirWorkShopDefSceneUtil.createBornUnit(bornMO)
		local unionIndex = bornMO:getUnionIndex()

		AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(unit, unionIndex)
		AirWorkShopDefSceneUtil.requestPlacePos(unionIndex, unit)
	end
end

function AirWorkShopDefSceneUtil.placeAllLeavePos(mapMO)
	local moList = mapMO:getLeaveMOs()

	for i, mo in ipairs(moList) do
		local unit = AirWorkShopDefSceneUtil.createLeaveUnit(mo)
		local unionIndex = mo:getUnionIndex()

		AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(unit, unionIndex)
		AirWorkShopDefSceneUtil.requestPlacePos(unionIndex, unit)
	end
end

function AirWorkShopDefSceneUtil.isPosUnit(unit)
	if unit.property:getUnitType() == AirWorkShopEnum.UnitType.ExitPoint or unit.property:getUnitType() == AirWorkShopEnum.UnitType.BornPoint then
		return true
	end

	return false
end

function AirWorkShopDefSceneUtil.transLeaveMOList2Params(moList, paramList)
	for i, v in ipairs(moList) do
		local x, z = BoardIndexConverter.unionIndexToCoordinates(v:getUnionIndex())

		table.insert(paramList, x)
		table.insert(paramList, z)
	end
end

function AirWorkShopDefSceneUtil.hasExtraWinCondition(extra)
	return extra and extra.id ~= 0
end

function AirWorkShopDefSceneUtil.updateWinConditionByLeavePointChange(modifiedMapMO)
	local extra = modifiedMapMO:getCondition()

	extra.id = 2

	table.clear(extra.params)

	for i, v in ipairs(modifiedMapMO:getLeaveMOs()) do
		local x, z = BoardIndexConverter.unionIndexToCoordinates(v:getUnionIndex())

		table.insert(extra.params, x)
		table.insert(extra.params, z)
	end
end

function AirWorkShopDefSceneUtil.updateLeaveMapMoWhenSave(modifiedMapMO)
	local leaveMOList = modifiedMapMO:getLeaveMOs()

	AirWorkShopDefSceneUtil.removeAllLeavePos(modifiedMapMO)

	local extra = modifiedMapMO:getCondition()

	if extra and extra.id == 1 then
		local params = extra.params

		for i = 1, #params, 2 do
			local x = params[i]
			local z = params[i + 1]
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z)

			AirWorkShopDefSceneUtil.createLeaveUnitAndSetPos(unionIndex)
		end
	end
end

function AirWorkShopDefSceneUtil.resetLeavePointByPointList(modifiedMapMO, params)
	if params then
		AirWorkShopDefSceneUtil.removeAllLeavePos(modifiedMapMO)

		for i = 1, #params, 2 do
			local x = params[i]
			local z = params[i + 1]
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z)

			AirWorkShopDefSceneUtil.createLeaveUnitAndSetPos(unionIndex)
		end
	end
end

function AirWorkShopDefSceneUtil.isInAirBattle(battleType)
	return battleType == BattleExtension_pb.BattleType.RODEO_AIR or battleType == BattleExtension_pb.BattleType.TEST_AIR or battleType == BattleExtension_pb.BattleType.FREE_AIR or battleType == BattleExtension_pb.BattleType.ENDLESS_AIR
end

function AirWorkShopDefSceneUtil.isCanFlyHighLand(unit)
	if unit.property:getTabType() == AirWorkShopEnum.TabEnum.Highland then
		local buildCO = AirWorkShopConfig.instance:getBuildingCO(unit.property:getEntityCode())

		return buildCO.canFly
	end

	return false
end

return AirWorkShopDefSceneUtil
