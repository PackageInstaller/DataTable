-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/TerrainCOUtil.lua

module("logic.battle.config.TerrainCOUtil", package.seeall)

local TerrainCOUtil = {}
local INT_MAX = 4294967295
local KHeightRate = 0.4

function TerrainCOUtil.isTerrainEnableForUnit(terrainCO, unit)
	local career = unit.property:getCareer()
	local battleCamp = unit.property:getBattleCamp()
	local consume = terrainCO.career_mobility_consume[career]

	if consume < 0 then
		return false
	end

	local forbidBattleCamp = terrainCO.forbidBattleCamp

	if forbidBattleCamp and table.indexof(forbidBattleCamp, battleCamp) then
		return false
	end

	if consume then
		return true, consume
	end

	if enableErrorLog then
		printError(string.format("Cannot find mobility consume terrainCode = %s, career = %s", terrainCO.code, career))
	end

	return false
end

function TerrainCOUtil.getMobilityConsume(terrainCO, unit)
	local _, consume = TerrainCOUtil.isTerrainEnableForUnit(terrainCO, unit)

	return consume or INT_MAX
end

function TerrainCOUtil.getCellHeight(cellCO)
	return cellCO.height * KHeightRate
end

function TerrainCOUtil.getTerrainType(cellMO)
	local flow = BattleMgr.instance:getActiveBattleFlow()

	if flow and flow.buildingMgr then
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(cellMO:getCoordinates())
		local unit = flow.buildingMgr:getHighlandUnitOnUnionIndex(unionIndex)

		if unit and unit.property:getTabType() == AirWorkShopEnum.TabEnum.Highland then
			if unit.property:canFly() then
				return BattleEnum.CellType.TERRAIN102
			else
				return BattleEnum.CellType.TERRAIN106
			end
		end
	end

	return cellMO:getCellType()
end

return TerrainCOUtil
