-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/AirWorkShopDefOperateUtil.lua

module("logic.extensions.airworkshop.flow.defflow.AirWorkShopDefOperateUtil", package.seeall)

local AirWorkShopDefOperateUtil = {}

function AirWorkShopDefOperateUtil.updateUnitVisible()
	local pathArrow = AirWorkShopDefMgr.instance:getPathArrow()

	pathArrow:updateBlockCells()

	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()

	for k, unit in pairs(unitMgr:getAllUnit()) do
		local isShow = AirWorkShopDefSceneModel.instance:getPreviewSelect(unit.property:getTabType())

		unit:setVisible(isShow)
	end
end

function AirWorkShopDefOperateUtil.changeToAmbush(unitMO, condition, params)
	local entityId = unitMO:getEntityId()
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)

	if not unit then
		printError("entity不存在,entityId:", entityId)

		return
	end

	if unit.property:getUnitType() == AirWorkShopEnum.UnitType.Hero then
		local model = AirWorkShopDefMgr.instance:getModel()
		local modifiedMapMO = model:getModiedMapMO()
		local heroId = unitMO:getId()
		local unionIndex = unitMO:getUnionIndex()
		local msgMO = unitMO:getMsgMO()
		local heroAttrInfo = AirWorkHeroAttrInfo:createInstance()

		heroAttrInfo:copy(unitMO:getHeroAttrInfo())
		modifiedMapMO:removeUnitMO(entityId)

		local ambushMO = modifiedMapMO:addAmbushMO(entityId, heroId, unionIndex, condition, params, msgMO, heroAttrInfo)

		unit.property:setUnitMO(ambushMO)
		unit.uiProxy:rebuildUI()
	elseif unit.property:getUnitType() == AirWorkShopEnum.UnitType.Ambush then
		unitMO:setConditionAndParams(condition, params)
	end
end

function AirWorkShopDefOperateUtil.changeToHero(unitMO)
	local entityId = unitMO:getEntityId()
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)

	if not unit then
		printError("entity不存在,entityId:", entityId)

		return
	end

	if not unit.property:getUnitType() == AirWorkShopEnum.UnitType.Ambush then
		return
	end

	local model = AirWorkShopDefMgr.instance:getModel()
	local modifiedMapMO = model:getModiedMapMO()
	local heroId = unitMO:getId()
	local unionIndex = unitMO:getUnionIndex()
	local msgMO = unitMO:getMsgMO()
	local heroAttrInfo = AirWorkHeroAttrInfo:createInstance()

	heroAttrInfo:copy(unitMO:getHeroAttrInfo())
	modifiedMapMO:removeUnitMO(entityId)

	local heroMO = modifiedMapMO:addHeroMO(entityId, heroId, unionIndex, msgMO, heroAttrInfo)

	unit.property:setUnitMO(heroMO)
	unit.uiProxy:rebuildUI()
end

function AirWorkShopDefOperateUtil.showAllUnit()
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()

	for k, unit in pairs(unitMgr:getAllUnit()) do
		unit:setVisible(true)
	end
end

function AirWorkShopDefOperateUtil.clearSceneFocusUnit()
	local unitOperator = AirWorkShopDefMgr.instance:getUnitOperator()

	unitOperator:clearFocusUnit()
end

function AirWorkShopDefOperateUtil.isUnitInCurrentType(unit)
	if not unit then
		return false
	end

	return unit.property:getTabType() == AirWorkShopDefSceneModel.instance:getCurTabType()
end

function AirWorkShopDefOperateUtil.isUnitVisible(unit)
	return AirWorkShopDefSceneModel.instance:getPreviewSelect(unit.property:getTabType())
end

function AirWorkShopDefOperateUtil.isUnitReachLimit(unitTagType)
	local count = AirWorkShopDefSceneModel.instance:getCurTabTypeCount(unitTagType)
	local limit = AirWorkShopDefSceneModel.instance:getCurTabTypeLimit(unitTagType)

	return limit <= count
end

function AirWorkShopDefOperateUtil.canSetToUnionIndex(unit, unionIndex, showToast)
	local boardModel = AirWorkShopDefMgr.instance:getBoardModel()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

	if unit.transform:isComposite() then
		local vertices = unit.transform:getVertices()

		for _, vertex in pairs(vertices) do
			local vertexX, vertexZ = vertex:getXZ()

			vertexX = vertexX + x
			vertexZ = vertexZ + z

			if not AirWorkShopDefOperateUtil._canSetToUnionIndex(vertexX, vertexZ, unit, showToast) then
				return false
			end
		end
	elseif not AirWorkShopDefOperateUtil._canSetToUnionIndex(x, z, unit, showToast) then
		return false
	end

	return true
end

function AirWorkShopDefOperateUtil.canBornOrLeaveSetToUnionIndex(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local boardModel = AirWorkShopDefMgr.instance:getBoardModel()

	if not boardModel:isValideCoordinates(x, z) then
		return false
	end

	local cellMO = boardModel:getBoardCellMOByCoordinates(x, z)

	if not cellMO:isEnable() then
		return false
	end

	local entityIds = BattleTableUtil.getTempList()

	boardModel:getAllEntityOnBoard(unionIndex, entityIds)

	local count = #entityIds

	BattleTableUtil.releaseTempList(entityIds)

	return count == 0
end

function AirWorkShopDefOperateUtil._canSetToUnionIndex(x, z, dragUnit, showToast)
	local boardModel = AirWorkShopDefMgr.instance:getBoardModel()
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()
	local model = AirWorkShopDefMgr.instance:getModel()

	if not boardModel:isValideCoordinates(x, z) then
		if showToast then
			FloatWordMgr.instance:show(lang("tip_airwork_cannot_select_point"))
		end

		return false
	end

	local vertexCellMO = boardModel:getBoardCellMOByCoordinates(x, z)
	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z)

	if model:isInAttackArea(unionIndex) then
		if showToast then
			FloatWordMgr.instance:show(lang("tip_airwork_cannot_select_attackpoint"))
		end

		return
	end

	if not AirWorkShopDefOperateUtil.judgeNodeEnable(vertexCellMO, dragUnit) then
		if showToast then
			FloatWordMgr.instance:show(lang("tip_airwork_cannot_select_point"))
		end

		return
	end

	local boardEntityList = BattleTableUtil.getTempList()

	boardModel:getAllEntityOnBoard(unionIndex, boardEntityList)

	for i, entityId in ipairs(boardEntityList) do
		if entityId ~= dragUnit.property:getEntityId() then
			local oldUnit = unitMgr:getUnit(entityId)

			if not AirWorkShopDefOperateUtil.canUnitExchange(dragUnit, oldUnit) then
				BattleTableUtil.releaseTempList(boardEntityList)

				if showToast then
					FloatWordMgr.instance:show(lang("tip_airwork_cannot_select_point"))
				end

				return false
			end
		end
	end

	BattleTableUtil.releaseTempList(boardEntityList)

	return true
end

function AirWorkShopDefOperateUtil.canUnitExchange(newUnit, oldUnit)
	if oldUnit then
		local newTabType = newUnit.property:getTabType()
		local oldTabType = oldUnit.property:getTabType()

		if (newTabType == AirWorkShopEnum.TabEnum.Message or oldTabType == AirWorkShopEnum.TabEnum.Message) and oldTabType ~= newTabType then
			return true
		end

		if newTabType == AirWorkShopEnum.TabEnum.Building and oldTabType == AirWorkShopEnum.TabEnum.Hero or newTabType == AirWorkShopEnum.TabEnum.Hero and oldTabType == AirWorkShopEnum.TabEnum.Building then
			local buildCode

			if newTabType == AirWorkShopEnum.TabEnum.Building then
				buildCode = newUnit.property:getEntityCode()
			else
				buildCode = oldUnit.property:getEntityCode()
			end

			local buildCO = AirWorkShopConfig.instance:getBuildingCO(buildCode)

			if buildCO.terrainId > 0 then
				local terrainCO = TerrainConfig.instance:getAdditionalTerrainCO(buildCO.terrainId)

				if terrainCO and terrainCO.effect == AirWorkShopEnum.BuildingType.DoubleD then
					return true
				end
			end
		end

		if newUnit.property:getTabType() == AirWorkShopEnum.TabEnum.Hero then
			if oldUnit.property:getTabType() == AirWorkShopEnum.TabEnum.Highland and oldUnit.property:canFly() and AirWorkShopDefOperateUtil.unitCanFly(newUnit) then
				-- block empty
			elseif oldUnit.property:getTabType() == AirWorkShopEnum.TabEnum.Hero then
				-- block empty
			else
				return false
			end
		else
			return false
		end
	end

	return true
end

function AirWorkShopDefOperateUtil.unitCanFly(unit)
	local terrainCO = TerrainConfig.instance:getTerrainCO(102)
	local career = unit.property:getCareer()
	local consume = terrainCO.career_mobility_consume[career]

	return consume >= 0
end

function AirWorkShopDefOperateUtil.judgeNodeEnable(cellMO, unit)
	local tabType = unit.property:getTabType()

	if tabType == AirWorkShopEnum.TabEnum.Hero then
		if not cellMO:isEnable() then
			return false
		end

		local terrainCO = TerrainConfig.instance:getTerrainCO(cellMO:getCellType())
		local career = unit.property:getCareer()
		local battleCamp = 1
		local consume = terrainCO.career_mobility_consume[career]

		if consume < 0 then
			return false
		end

		local forbidBattleCamp = terrainCO.forbidBattleCamp

		if forbidBattleCamp and table.indexof(forbidBattleCamp, battleCamp) then
			return false
		end

		return true
	else
		return cellMO:isEnable()
	end
end

function AirWorkShopDefOperateUtil.openBuildingTips(itemId, go)
	local itemData = ItemData.New({
		count = 1,
		itemId = itemId
	})
	local data = ToolTipsUtil.createItemTipsData(itemData, go)

	if not ViewMgr.instance:isOpen(data.viewName) then
		ToolTipsMgr.showTips(data.viewName, data)
	end
end

function AirWorkShopDefOperateUtil.tryCombineHighland(unit, unionIndex)
	local checker = AirWorkShopDefMgr.instance:getHighlandChecker()

	checker:tryCombineGroup(unit, unionIndex)
end

function AirWorkShopDefOperateUtil.captureCamera(levelId)
	local shot = AirWorkShopDefMgr.instance:getCameraShot()

	shot:setForCapture()

	local bytesData = CameraShotUtil.CaptureCamera(shot:getCamera(), AirWorkShopConst.CaptureWdith, AirWorkShopConst.CaptureHeight)

	AirWorkMapModel.instance:setCapturedData(bytesData)
end

function AirWorkShopDefOperateUtil.setCoverHighlandIdAndCreate(buildId)
	AirWorkShopDefSceneModel.instance:setCoverHighlandIdAndCreate(buildId)

	local scenePicker = AirWorkShopDefMgr.instance:getScenePicker()

	scenePicker:destroyHighland()

	if buildId then
		scenePicker:createHighland()
	end
end

function AirWorkShopDefOperateUtil.removeUnitWithDoubleCheck(unit, showToast)
	local function func(a, b)
		AirWorkShopDefSceneUtil.tryRemoveUnit(unit, showToast)
	end

	if unit.property:getUnitType() == AirWorkShopEnum.UnitType.Ambush then
		local info = {}

		info.clickRightCallBackFunc = func
		info.clickRightCallBackHandler = self
		info.content = lang("tip_air_workshop_ambush_set_1")
		info.leftTxt = lang("tip_common_cancel_1")
		info.rightTxt = lang("tip_common_ensure_1")

		ViewMgr.instance:open(ViewName.CommonConfirmTips, info)

		return AirWorkShopEnum.CallBackState.Stop
	elseif unit.property:getUnitType() == AirWorkShopEnum.UnitType.Message then
		local info = {}

		info.clickRightCallBackFunc = func
		info.clickRightCallBackHandler = self
		info.content = lang("tip_air_workshop_message_set_1")
		info.leftTxt = lang("tip_common_cancel_1")
		info.rightTxt = lang("tip_common_ensure_1")

		ViewMgr.instance:open(ViewName.CommonConfirmTips, info)

		return AirWorkShopEnum.CallBackState.Stop
	end

	local unitMO = unit.property:getUnitMO()
	local msg = unitMO:getMsgMO()

	if msg and msg:getLeaveMsgMO() then
		local info = {}

		info.clickRightCallBackFunc = func
		info.clickRightCallBackHandler = self
		info.content = unit.property:getTabType() == AirWorkShopEnum.TabEnum.Hero and "是否回收留言角色，回收后留言配置将会清除?" or "是否回收留言部件，回收后留言配置将会清除?"
		info.leftTxt = lang("tip_common_cancel_1")
		info.rightTxt = lang("tip_common_ensure_1")

		ViewMgr.instance:open(ViewName.CommonConfirmTips, info)

		return AirWorkShopEnum.CallBackState.Stop
	end

	func()
end

function AirWorkShopDefOperateUtil.closeToastTips()
	if ViewMgr.instance:isOpen(ViewName.CharacterTopToastTips) then
		ViewMgr.instance:close(ViewName.CharacterTopToastTips)
	end
end

function AirWorkShopDefOperateUtil.hasEntityRefresh(modifiedMapMO, levelId)
	local levelMO = AirWorkMapModel.instance:getLevelMOById(levelId)

	if not levelMO then
		return false
	end

	for i, v in ipairs(modifiedMapMO:getHeroMOList()) do
		local heroAttrInfo = v:getHeroAttrInfo()

		if not modifiedMapMO:hasMarkRefreshHero(v:getId()) and heroAttrInfo.isCreateByAgent and not heroAttrInfo:isSame2HeroData() then
			return true
		end
	end

	for i, v in ipairs(modifiedMapMO:getAmbushMOList()) do
		local heroAttrInfo = v:getHeroAttrInfo()

		if not modifiedMapMO:hasMarkRefreshHero(v:getId()) and heroAttrInfo.isCreateByAgent and not heroAttrInfo:isSame2HeroData() then
			return true
		end
	end

	return false
end

function AirWorkShopDefOperateUtil.fillNeedRefreshEntitys(modifiedMapMO, levelId)
	local list = modifiedMapMO:getRefreshHeros()
	local levelMO = AirWorkMapModel.instance:getLevelMOById(levelId)

	if not levelMO then
		return
	end

	for i, v in ipairs(modifiedMapMO:getHeroMOList()) do
		local heroAttrInfo = v:getHeroAttrInfo()

		if heroAttrInfo.isCreateByAgent and not heroAttrInfo:isSame2HeroData() then
			heroAttrInfo:reset()
			heroAttrInfo:initAttrByClient(v:getId())

			list[v:getId()] = true
		end
	end

	for i, v in ipairs(modifiedMapMO:getAmbushMOList()) do
		local heroAttrInfo = v:getHeroAttrInfo()

		if heroAttrInfo.isCreateByAgent and not heroAttrInfo:isSame2HeroData() then
			heroAttrInfo:reset()
			heroAttrInfo:initAttrByClient(v:getId())

			list[v:getId()] = true
		end
	end
end

return AirWorkShopDefOperateUtil
