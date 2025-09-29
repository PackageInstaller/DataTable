-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentUtil.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentUtil", package.seeall)

local BattleCampAdjustmentUtil = {}

function BattleCampAdjustmentUtil.requestMoveEntity(unit, unionIndex)
	if not unit then
		return
	end

	local entityId = unit.property:getEntityId()
	local netAgent = BattleMgr.instance:getNetAgent()

	netAgent:sendMoveEntityRequest(entityId, unionIndex)

	local currentUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())

	if not BattleCampAdjustmentModel.instance:isCellIndexUsed(unionIndex) then
		BattleCampAdjustmentModel.instance:setCellIndexUsedState(currentUnionIndex, false)
	end

	BattleCampAdjustmentModel.instance:setCellIndexUsedState(unionIndex, true)
	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnBoardUsedUpdate)
end

function BattleCampAdjustmentUtil.requestPlaceEntity(heroId, unionIndex)
	local netAgent = BattleMgr.instance:getNetAgent()

	netAgent:sendPlaceEntityRequest(heroId, unionIndex)
	BattleCampAdjustmentModel.instance:setCharacterInTeam(heroId)
	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnAvailableHeroListUpdate)
	BattleCampAdjustmentModel.instance:setCellIndexUsedState(unionIndex, true)
	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnBoardUsedUpdate)

	local pathArrow = BattleMgr.instance:getPathArrow()

	pathArrow:removeCurrentFocus()
end

function BattleCampAdjustmentUtil.requestPlaceEntityBatch(heroIdList, unionIndexList)
	local netAgent = BattleMgr.instance:getNetAgent()

	netAgent:sendPlaceEntityRequestBatch(heroIdList, unionIndexList)

	for _, heroId in ipairs(heroIdList) do
		BattleCampAdjustmentModel.instance:setCharacterInTeam(heroId)
	end

	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnAvailableHeroListUpdate)

	for _, unionIndex in ipairs(unionIndexList) do
		BattleCampAdjustmentModel.instance:setCellIndexUsedState(unionIndex, true)
	end

	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnBoardUsedUpdate)

	local pathArrow = BattleMgr.instance:getPathArrow()

	pathArrow:removeCurrentFocus()
end

function BattleCampAdjustmentUtil.requestRemoveEntity(unit)
	if not unit then
		return
	end

	local entityId = unit.property:getEntityId()
	local netAgent = BattleMgr.instance:getNetAgent()

	netAgent:sendRemoveEntityRequest(entityId)

	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())

	BattleCampAdjustmentModel.instance:setCellIndexUsedState(unionIndex, false)
	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnBoardUsedUpdate)

	local model = BattleMgr.instance:getModel()

	model:getBattleFieldInfo():removeEntityInfo(entityId)
	BattleCampAdjustmentModel.instance:setCharacterOutTeam(unit.property:getEntityCode())
	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnAvailableHeroListUpdate)

	local pathArrow = BattleMgr.instance:getPathArrow()

	pathArrow:removeCurrentFocus()
end

function BattleCampAdjustmentUtil.clearOperateUnit()
	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnClearOperateUnit)
end

function BattleCampAdjustmentUtil.showFocusSign(unionIndex)
	local pathArrow = BattleMgr.instance:getPathArrow()

	pathArrow:showFocusSign(unionIndex)
end

function BattleCampAdjustmentUtil.hideFocusSign()
	local pathArrow = BattleMgr.instance:getPathArrow()

	pathArrow:hideFocusSign()
end

function BattleCampAdjustmentUtil.isLockedUnit(unit)
	if not unit then
		return
	end

	local characterCode = unit.property:getViewEntityCode()

	return BattleCampAdjustmentModel.instance:isLockedCharacter(characterCode)
end

function BattleCampAdjustmentUtil.canPlaceOnUnionIndex(unit, unionIndex)
	if unionIndex < 0 then
		return false
	end

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local toUnit = unitMgr:getUnitOnUnionIndex(unionIndex)

	if BattleCampAdjustmentUtil.isLockedUnit(toUnit) then
		return false, lang("tip_not_replace_leader")
	end

	local boardModel = BattleMgr.instance:getBoardModel()
	local cellMO = boardModel:getBoardCellMO(unionIndex)
	local terrainCO = TerrainConfig.instance:getTerrainCO(cellMO:getCellType())

	if not TerrainCOUtil.isTerrainEnableForUnit(terrainCO, unit) then
		return false
	end

	return BattleCampAdjustmentModel.instance:isValidBornUnionIndex(unionIndex)
end

local kCamp2Count = {}

function BattleCampAdjustmentUtil.calculateMaxSameCampCount(characterCodeList)
	local camp2Count = kCamp2Count
	local maxCount = 0
	local activeCamp = 0

	for _, entityCode in pairs(characterCodeList) do
		local entityCO = BattleConfigUtil.getEntityConfig(entityCode)

		if entityCO then
			local count = (camp2Count[entityCO.camp] or 0) + 1

			camp2Count[entityCO.camp] = count

			if entityCO.camp ~= GameEnum.CampEnum.StarrySkyChurch and maxCount < count then
				activeCamp = entityCO.camp
				maxCount = count
			end
		end
	end

	if maxCount <= 0 then
		activeCamp = GameEnum.CampEnum.StarrySkyChurch
		maxCount = camp2Count[GameEnum.CampEnum.StarrySkyChurch] or 0
	else
		maxCount = maxCount + (camp2Count[GameEnum.CampEnum.StarrySkyChurch] or 0)
	end

	BattleTableUtil.clearTable(camp2Count)

	return maxCount, activeCamp
end

local kCharacterCodeList = {}

function BattleCampAdjustmentUtil.getValidCharacterCodeList(characterCodeList)
	BattleTableUtil.clearTable(kCharacterCodeList)

	for _, heroId in ipairs(characterCodeList) do
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

		if heroMO then
			table.insert(kCharacterCodeList, heroId)
		end
	end

	return kCharacterCodeList
end

function BattleCampAdjustmentUtil.setUnitForDrag(unit)
	unit.meshModelMover:setOffsetXYZ(0, 1, 0)
	unit.uiProxy:setVisible(false)
	unit.sceneProxy:setVisible(false)
end

function BattleCampAdjustmentUtil.setDragUnitToUnionIndex(unit, unionIndex)
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local position = boardMgr:getCellPosition(unionIndex)

	unit.uiProxy:setVisible(true)
	unit.sceneProxy:setVisible(true)
	unit.meshModelMover:setOffsetXYZ(0, 0, 0)
	unit.mover:setPosDirectly(position.x, position.z)
	unit.meshModel:lookAtDirVec3(BattleCampAdjustmentModel.instance:getBornDirectionOfUnionIndex(unionIndex))
end

function BattleCampAdjustmentUtil.playPlaceEffect(unit)
	local activeCampChanged = BattleCampAdjustmentModel.instance:isSameActiveCampChanged()
	local placeEffectId = BattleCampAdjustmentUtil.getPlaceEffectId(unit)

	unit.effectPlayer:playEffect(placeEffectId)
	BattleAudioUtil.playVoice(unit, BattleAudioUtil.VoiceEnum.speech_shangzhen)
end

function BattleCampAdjustmentUtil.getPlaceEffectId(unit)
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

function BattleCampAdjustmentUtil.playSameCampEffect()
	return
end

return BattleCampAdjustmentUtil
