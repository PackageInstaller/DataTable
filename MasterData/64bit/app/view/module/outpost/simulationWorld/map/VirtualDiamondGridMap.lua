local var_0_0 = g.core.config.outpost_map_info
local var_0_1 = math.abs
local var_0_2 = math.round
local var_0_3 = math.random
local var_0_4 = table.insert
local KsAStar = require("app.core.utils.KsAStar")
local OutpostEntityFactory = require("app.view.module.outpost.simulationWorld.OutpostEntityFactory")
local KsMath = require("app.core.utils.KsMath")
local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local OutPostBarrierConfig = require("app.view.module.outpost.const.OutPostBarrierConfig")
local OutPostObsConfig = require("app.view.module.outpost.const.OutPostObsConfig")
local OutPostMaskConfig = require("app.view.module.outpost.const.OutPostMaskConfig")
local QuadTree = require("app.view.module.outpost.simulationWorld.quadtree.QuadTree")
local var_0_14 = g.core.model.User.outpostData
local var_0_15 = g.core.const.ConstMgr.outpostConst
local var_0_16 = g.core.config.outpost_arena_info
local var_0_17 = {}
local VirtualDiamondGridMap = class("VirtualDiamondGridMap")

function VirtualDiamondGridMap:ctor(arg_1_1)
	self._gridWidth = 0
	self._gridHeight = 0
	self._gridXCount = 0
	self._gridYCount = 0
	self._pixelWidth = 0
	self._pixelHeight = 0
	self.world = arg_1_1
	self._monsterMapTypeList = {}
	self._bossMapTypeDict = {}
	self._allBuildDict = {}
	self._allKnightList = {}
	self._allKnightIdDict = {}
	self._arenaEntity = {}
	self._allDropDict = {}
	self._allBossBoxDict = {}
	self._allMapTypeGridDictList = {}
	self._allMoveMiniGrid = {}
	self._halfWidth = 0
	self._halfHeight = 0
	self.astar = KsAStar.CreateAStar()
	self.isPathfinding = false
end

function VirtualDiamondGridMap:initMap(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self._gridWidth = arg_2_3
	self._gridHeight = arg_2_4
	self._gridXCount = arg_2_1
	self._gridYCount = arg_2_2
	self._pixelWidth = math.ceil((arg_2_1 + arg_2_2) * arg_2_3 * 0.5)
	self._pixelHeight = math.ceil((arg_2_1 + arg_2_2) * arg_2_4 * 0.5)
	self._tree = QuadTree.new(-self._pixelWidth * 0.5, 0, self._pixelWidth, self._pixelHeight, 4, 4)

	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in g.core.config.outpost_build_info.ipairs() do
		local var_2_2, var_2_3 = OutpostCommon.coordToPixel(iter_2_1.x, iter_2_1.y)
		local var_2_4 = OutpostEntityFactory.createBuild(self.world, iter_2_1.build_type)

		var_2_4.x = var_2_2
		var_2_4.y = var_2_3

		self._tree:insert(var_2_4)

		if not self.world.lockEvent then
			var_0_14:dispatchWorldEvent(OutpostEvent.EntityAdd, var_2_4)
		end

		self._allBuildDict[var_2_4.oid] = var_2_4

		local var_2_5 = var_0_14:getBuildData():getBuild({
			needCreate = true,
			type = iter_2_1.build_type
		})

		var_2_4:setBuildStruct(var_2_5)

		for iter_2_2, iter_2_3 in pairs(var_2_5:getInBuildKnight()) do
			if var_2_5:isInBuilding(iter_2_2) then
				var_2_1[iter_2_2] = var_2_4
			end
		end

		var_2_0[iter_2_1.build_type] = {}

		for iter_2_4 = -1, iter_2_1.x_length do
			for iter_2_5 = -1, iter_2_1.y_length do
				if iter_2_4 >= 0 and iter_2_4 <= iter_2_1.x_length - 1 and iter_2_5 >= 0 and iter_2_5 <= iter_2_1.y_length - 1 then
					var_0_17[KsMath.mathUnifiedCoordinate(iter_2_1.x - iter_2_4, iter_2_1.y - iter_2_5)] = true
				elseif iter_2_1.build_type == var_0_15.BuildType.ArmorShop or iter_2_1.build_type == var_0_15.BuildType.WeaponShop then
					if iter_2_4 < 0 or iter_2_5 < 0 then
						var_0_4(var_2_0[iter_2_1.build_type], KsMath.mathUnifiedCoordinate(iter_2_1.x - iter_2_4, iter_2_1.y - iter_2_5))
					end
				else
					var_0_4(var_2_0[iter_2_1.build_type], KsMath.mathUnifiedCoordinate(iter_2_1.x - iter_2_4, iter_2_1.y - iter_2_5))
				end
			end
		end
	end

	local var_2_6 = {}

	for iter_2_6, iter_2_7 in var_0_0.ipairs() do
		if not var_0_14:isArenaOpen(iter_2_7.map_type) then
			if not self._arenaEntity[iter_2_7.map_type] then
				self._arenaEntity[iter_2_7.map_type] = {}

				table.insert(var_2_6, iter_2_7.map_type)

				var_2_6[iter_2_7.map_type] = true
			end

			local var_2_7, var_2_8 = OutpostCommon.coordToPixel(iter_2_7.x, iter_2_7.y)
			local var_2_9 = OutpostEntityFactory.createDoor(self.world, iter_2_7)

			var_2_9.x = var_2_7
			var_2_9.y = var_2_8

			self._tree:insert(var_2_9)
			table.insert(self._arenaEntity[iter_2_7.map_type], var_2_9)
		end
	end

	if next(var_2_6) then
		for iter_2_8, iter_2_9 in pairs(OutPostMaskConfig) do
			local var_2_10 = KsMath.mathCoordinateIndex(iter_2_8)

			if var_2_6[iter_2_9] and self._arenaEntity[iter_2_9] then
				local var_2_11 = OutpostEntityFactory.createMask(self.world)
				local var_2_12, var_2_13 = OutpostCommon.coordToPixel(var_2_10.x, var_2_10.y)

				var_2_11.x = var_2_12
				var_2_11.y = var_2_13

				self._tree:insert(var_2_11)
				table.insert(self._arenaEntity[iter_2_9], var_2_11)
			end
		end
	end

	for iter_2_10, iter_2_11 in pairs(OutPostBarrierConfig) do
		if type(iter_2_10) == "number" then
			local var_2_14 = KsMath.mathCoordinateIndex(iter_2_10)
			local var_2_15, var_2_16 = OutpostCommon.coordToPixel(var_2_14.x, var_2_14.y)
			local var_2_17 = OutpostEntityFactory.createBarrier(self.world, iter_2_11)

			var_2_17.x = var_2_15
			var_2_17.y = var_2_16

			self._tree:insert(var_2_17)

			if not self.world.lockEvent then
				var_0_14:dispatchWorldEvent(OutpostEvent.EntityAdd, var_2_17)
			end

			for iter_2_12 = 0, iter_2_11.x_w - 1 do
				for iter_2_13 = 0, iter_2_11.y_w - 1 do
					var_0_17[KsMath.mathUnifiedCoordinate(var_2_14.x - iter_2_12, var_2_14.y - iter_2_13)] = true
				end
			end
		end
	end

	local var_2_18 = {}

	for iter_2_14, iter_2_15 in var_0_16.ipairs() do
		var_2_18[KsMath.mathUnifiedCoordinate(iter_2_15.x, iter_2_15.y)] = iter_2_15.grid_type
	end

	self._allMoveMiniGrid = {}

	for iter_2_16 = 0, arg_2_1 - 1 do
		for iter_2_17 = 0, arg_2_2 - 1 do
			local var_2_19 = KsMath.mathUnifiedCoordinate(iter_2_16, iter_2_17)
			local var_2_20 = var_2_18[var_2_19] or 0

			self._allMapTypeGridDictList[var_2_20] = self._allMapTypeGridDictList[var_2_20] or {}

			if not self:isCanNotMove(var_2_19) then
				for iter_2_18 = 0, var_0_15.MiniGridX - 1 do
					for iter_2_19 = 0, var_0_15.MiniGridY - 1 do
						self._allMoveMiniGrid[KsMath.mathUnifiedCoordinate(iter_2_16 * var_0_15.MiniGridX - 1 + iter_2_18, iter_2_17 * var_0_15.MiniGridY - 1 + iter_2_19)] = var_2_20
					end
				end

				var_0_4(self._allMapTypeGridDictList[var_2_20], var_2_19)
			end
		end
	end

	self._halfWidth = arg_2_3 / var_0_15.MiniGridX / 2
	self._halfHeight = arg_2_4 / var_0_15.MiniGridY / 2

	for iter_2_20, iter_2_21 in pairs(self._allBuildDict) do
		iter_2_21:resetAllDoor()

		for iter_2_22, iter_2_23 in ipairs(var_2_0[iter_2_21:getBuildType()]) do
			if not self:isCanNotMove(iter_2_23) then
				local var_2_21 = KsMath.mathCoordinateIndex(iter_2_23)

				for iter_2_24 = 0, var_0_15.MiniGridX - 1 do
					for iter_2_25 = 0, var_0_15.MiniGridY - 1 do
						iter_2_21:addDoorPixelPos(cc.p(self:coordToPixel(var_2_21.x * var_0_15.MiniGridX - 1 + iter_2_24, var_2_21.y * var_0_15.MiniGridY - 1 + iter_2_25)), iter_2_23)
					end
				end
			end
		end
	end

	for iter_2_26, iter_2_27 in ipairs(var_0_14:getKnightsData():getAllLineUpKnights()) do
		self:addKnight(iter_2_27, var_2_1[iter_2_27:getServerId()])
	end

	for iter_2_28, iter_2_29 in pairs(var_0_14:getAllMonsters()) do
		self:addMonster(iter_2_29)
	end

	for iter_2_30, iter_2_31 in pairs(var_0_14:getAllBoss()) do
		self:addBoss(iter_2_31)
	end

	for iter_2_32, iter_2_33 in pairs(var_0_14:getAllDropDict()) do
		self:addDrop(iter_2_32, iter_2_33.mapType, iter_2_33.drop)
	end

	for iter_2_34, iter_2_35 in pairs(var_0_14:getBossBoxDict()) do
		self:addBossBox(iter_2_35)
	end

	g.core.model.User.outpostData:resetRejectBuildCache()
end

function VirtualDiamondGridMap:addKnight(arg_3_1, arg_3_2)
	local var_3_0 = OutpostEntityFactory.createKnight(self.world, arg_3_1)

	if arg_3_2 then
		local var_3_1 = arg_3_2:getBuildDoorRandomPos()

		var_3_0.x = var_3_1.x
		var_3_0.y = var_3_1.y
	else
		local var_3_2 = self._allMapTypeGridDictList[arg_3_1:getMapType()] or {}
		local var_3_3 = KsMath.mathCoordinateIndex(var_3_2[var_0_3(1, #var_3_2)])
		local var_3_4, var_3_5 = OutpostCommon.coordToPixel(var_3_3.x, var_3_3.y)

		var_3_0.x = var_3_4
		var_3_0.y = var_3_5
	end

	self._tree:insert(var_3_0)
	var_0_4(self._allKnightList, var_3_0)

	self._allKnightIdDict[arg_3_1:getServerId()] = var_3_0

	if arg_3_2 then
		arg_3_2:initSetInKnight(var_3_0)
	end

	if not self.world.lockEvent then
		var_0_14:dispatchWorldEvent(OutpostEvent.EntityAdd, var_3_0)
	end
end

function VirtualDiamondGridMap:addMonster(arg_4_1)
	local var_4_0 = OutpostEntityFactory.createMonster(self.world, arg_4_1)
	local var_4_1 = var_4_0:getMapType()

	if self._allMapTypeGridDictList[var_4_1] then
		local var_4_2 = KsMath.mathCoordinateIndex(self._allMapTypeGridDictList[var_4_1][var_0_3(1, #self._allMapTypeGridDictList[var_4_1])])
		local var_4_3, var_4_4 = OutpostCommon.coordToPixel(var_4_2.x, var_4_2.y)

		self._monsterMapTypeList[var_4_1] = self._monsterMapTypeList[var_4_1] or {}

		var_0_4(self._monsterMapTypeList[var_4_1], var_4_0)

		var_4_0.x = var_4_3
		var_4_0.y = var_4_4

		self._tree:insert(var_4_0)
		var_4_0:setBossToHide(self:hasBoss(var_4_1))

		if not self.world.lockEvent then
			var_0_14:dispatchWorldEvent(OutpostEvent.EntityAdd, var_4_0)
		end
	else
		var_4_0:dispose()
	end
end

function VirtualDiamondGridMap:addDrop(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0, var_5_1 = OutpostCommon.coordToPixel(arg_5_3.pos_x, arg_5_3.pos_y)
	local var_5_2 = OutpostEntityFactory.createDrop(self.world, arg_5_3)

	var_5_2.x = var_5_0 + var_0_3(-50, 50)
	var_5_2.y = var_5_1 + var_0_3(-50, 50)

	self._tree:insert(var_5_2)
	var_5_2:setMapType(arg_5_2)

	self._allDropDict[arg_5_1] = var_5_2

	if not self.world.lockEvent then
		var_0_14:dispatchWorldEvent(OutpostEvent.EntityAdd, var_5_2)
	end
end

function VirtualDiamondGridMap:addBossBox(arg_6_1)
	local var_6_0 = OutpostEntityFactory.createBossBox(self.world, arg_6_1)
	local var_6_1 = var_6_0:getMapType()
	local var_6_2 = 0
	local var_6_3 = 0

	for iter_6_0, iter_6_1 in var_0_0.ipairs() do
		if iter_6_1.map_type == var_6_1 then
			var_6_2 = iter_6_1.boss_x
			var_6_3 = iter_6_1.boss_y

			break
		end
	end

	local var_6_4, var_6_5 = OutpostCommon.coordToPixel(var_6_2, var_6_3)

	var_6_0.y, var_6_0.x = var_6_5 + var_0_3(-50, 50), var_6_4 + var_0_3(-50, 50)

	self._tree:insert(var_6_0)

	self._allBossBoxDict[arg_6_1.id] = var_6_0

	if not self.world.lockEvent then
		var_0_14:dispatchWorldEvent(OutpostEvent.EntityAdd, var_6_0)
	end
end

function VirtualDiamondGridMap:addBoss(arg_7_1)
	local var_7_0 = OutpostEntityFactory.createBoss(self.world, arg_7_1)
	local var_7_1 = var_7_0:getMapType()

	for iter_7_0, iter_7_1 in ipairs((self:getAllMonsterByMapType(var_7_1))) do
		iter_7_1:setBossToHide(true)
	end

	for iter_7_2, iter_7_3 in var_0_0.ipairs() do
		if iter_7_3.map_type == var_7_1 then
			local var_7_2, var_7_3 = OutpostCommon.coordToPixel(iter_7_3.boss_x, iter_7_3.boss_y)

			var_7_0.x = var_7_2
			var_7_0.y = var_7_3

			var_7_0:setEyeRange(iter_7_3.boss_range)

			break
		end
	end

	self._tree:insert(var_7_0)

	self._bossMapTypeDict[var_7_1] = var_7_0

	if not self.world.lockEvent then
		var_0_14:dispatchWorldEvent(OutpostEvent.EntityAdd, var_7_0)
	end
end

function VirtualDiamondGridMap:removeKnight(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self._allKnightList) do
		if iter_8_1:getEntityKnightStruct():getServerId() == arg_8_1 then
			iter_8_1:dispose()
			table.remove(self._allKnightList, iter_8_0)

			self._allKnightIdDict[arg_8_1] = nil

			break
		end
	end
end

function VirtualDiamondGridMap:removeBoss(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self._bossMapTypeDict) do
		if iter_9_1:getUid() == arg_9_1 then
			self:removeMonster(iter_9_1)
			iter_9_1:dispose()

			break
		end
	end
end

function VirtualDiamondGridMap:removeDrop(arg_10_1)
	if self._allDropDict[arg_10_1] then
		self._allDropDict[arg_10_1]:dispose()

		self._allDropDict[arg_10_1] = nil
	end
end

function VirtualDiamondGridMap:removeBossBox(arg_11_1)
	if self._allBossBoxDict[arg_11_1] then
		self._allBossBoxDict[arg_11_1]:dispose()

		self._allBossBoxDict[arg_11_1] = nil
	end
end

function VirtualDiamondGridMap:removeAllDrop()
	for iter_12_0, iter_12_1 in pairs(self._allDropDict) do
		self:removeDrop(iter_12_0)
	end
end

function VirtualDiamondGridMap:resetDeadBossMapType(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs((self:getAllMonsterByMapType(arg_13_1))) do
		iter_13_1:setBossToHide(false)
	end
end

function VirtualDiamondGridMap:getPixelWidth()
	return self._pixelWidth
end

function VirtualDiamondGridMap:getPixelHeight()
	return self._pixelHeight
end

function VirtualDiamondGridMap:worldJoinMap(arg_16_1)
	self._tree:insert(arg_16_1)
end

function VirtualDiamondGridMap:removeMonster(arg_17_1)
	local var_17_0 = arg_17_1:getMapType()

	if self._bossMapTypeDict[var_17_0] and self._bossMapTypeDict[var_17_0].oid == arg_17_1.oid then
		self._bossMapTypeDict[var_17_0] = nil

		self:resetDeadBossMapType(var_17_0)
	else
		for iter_17_0, iter_17_1 in ipairs((not self._monsterMapTypeList[var_17_0] or nil) and {}) do
			if iter_17_1.oid == arg_17_1.oid then
				table.remove(self._monsterMapTypeList[var_17_0], iter_17_0)

				break
			end
		end
	end
end

function VirtualDiamondGridMap:pixelToCoord(arg_18_1, arg_18_2)
	return var_0_2((arg_18_1 / self._halfWidth + arg_18_2 / self._halfHeight) * 0.5), var_0_2((arg_18_2 / self._halfHeight - arg_18_1 / self._halfWidth) * 0.5)
end

function VirtualDiamondGridMap:coordToPixel(arg_19_1, arg_19_2)
	return (arg_19_1 - arg_19_2) * self._halfWidth, (arg_19_1 + arg_19_2) * self._halfHeight
end

function VirtualDiamondGridMap:findPath(arg_20_1, arg_20_2, arg_20_3)
	if arg_20_3 ~= nil then
		while self.isPathfinding do
			arg_20_3:yield()
		end
	end

	self.isPathfinding = true

	local var_20_0 = self.astar:searchNearPath(cc.p(self:pixelToCoord(arg_20_1.x, arg_20_1.y)), cc.p(self:pixelToCoord(arg_20_2.x, arg_20_2.y)), self, arg_20_3)

	self.isPathfinding = false

	if var_20_0 and #var_20_0 >= 2 then
		local var_20_1 = {
			arg_20_1
		}

		for iter_20_0 = 2, #var_20_0 - 1 do
			var_0_4(var_20_1, cc.p(self:coordToPixel(var_20_0[iter_20_0].x, var_20_0[iter_20_0].y)))
		end

		var_0_4(var_20_1, arg_20_2)

		if arg_20_3 ~= nil then
			arg_20_3:yield()
		end

		return var_20_1
	end
end

function VirtualDiamondGridMap:doCanMoveAStar(arg_21_1, arg_21_2)
	return self._allMoveMiniGrid[KsMath.mathUnifiedCoordinate(arg_21_1.x, arg_21_1.y)] ~= nil
end

function VirtualDiamondGridMap:doCalcEstimateAStar(arg_22_1, arg_22_2)
	return var_0_1(arg_22_1.x - arg_22_2.x) + var_0_1(arg_22_1.y - arg_22_2.y)
end

function VirtualDiamondGridMap:queryRectEntities(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	return self._tree:queryRect(arg_23_1 - arg_23_3 * 0.5, arg_23_2 - arg_23_4 * 0.5, arg_23_3, arg_23_4)
end

function VirtualDiamondGridMap:queryRangeEntities(arg_24_1, arg_24_2, arg_24_3)
	return self._tree:queryRange(arg_24_1, arg_24_2, arg_24_3)
end

function VirtualDiamondGridMap:getAllMonsterByMapType(arg_25_1)
	return self._monsterMapTypeList[arg_25_1] or {}
end

function VirtualDiamondGridMap:getGridByMapType(arg_26_1)
	return self._allMapTypeGridDictList[arg_26_1]
end

function VirtualDiamondGridMap:getBuildByType(arg_27_1)
	for iter_27_0, iter_27_1 in pairs(self._allBuildDict) do
		if iter_27_1:canUseBuild() and iter_27_1.buildType == arg_27_1 then
			return iter_27_1
		end
	end
end

function VirtualDiamondGridMap:canMoveInMiniPos(arg_28_1, arg_28_2, arg_28_3)
	return self._allMoveMiniGrid[KsMath.mathUnifiedCoordinate(arg_28_1, arg_28_2)] == arg_28_3
end

function VirtualDiamondGridMap:hasBoss(arg_29_1)
	if arg_29_1 then
		return self._bossMapTypeDict[arg_29_1] ~= nil
	else
		return next(self._bossMapTypeDict) ~= nil
	end
end

function VirtualDiamondGridMap:getBoss()
	return self._bossMapTypeDict
end

function VirtualDiamondGridMap:getKnightById(arg_31_1)
	return self._allKnightIdDict[arg_31_1]
end

function VirtualDiamondGridMap:getAllKnightList()
	return self._allKnightList
end

function VirtualDiamondGridMap:getAllMonster()
	return self._monsterMapTypeList
end

function VirtualDiamondGridMap:isCanNotMove(arg_34_1)
	if var_0_14:isLockDoor(arg_34_1) then
		return true
	end

	return var_0_17[arg_34_1] or OutPostObsConfig[arg_34_1]
end

function VirtualDiamondGridMap:clearOnArenaUnlock(arg_35_1)
	if self._arenaEntity[arg_35_1] then
		for iter_35_0, iter_35_1 in ipairs(self._arenaEntity[arg_35_1]) do
			iter_35_1:dispose()
		end
	end

	self._arenaEntity[arg_35_1] = nil
end

function VirtualDiamondGridMap:getOneDrop()
	local var_36_0 = next(self._allDropDict)

	if var_36_0 then
		return self._allDropDict[var_36_0]
	end
end

function VirtualDiamondGridMap:getPixelPosLevel(arg_37_1, arg_37_2)
	local var_37_0, var_37_1 = self:pixelToCoord(arg_37_1, arg_37_2)

	return self._allMoveMiniGrid[KsMath.mathUnifiedCoordinate(var_37_0, var_37_1)] or 0
end

function VirtualDiamondGridMap:exitMap()
	for iter_38_0, iter_38_1 in ipairs(self._allKnightList) do
		local var_38_0 = iter_38_1:getFsm()

		if var_38_0 then
			var_38_0:cleanupFSM()
		end
	end

	for iter_38_2, iter_38_3 in pairs(self._monsterMapTypeList) do
		for iter_38_4, iter_38_5 in ipairs(iter_38_3) do
			local var_38_1 = iter_38_5:getFsm()

			if var_38_1 then
				var_38_1:cleanupFSM()
			end
		end
	end

	for iter_38_6, iter_38_7 in pairs(self._bossMapTypeDict) do
		local var_38_2 = iter_38_7:getFsm()

		if var_38_2 then
			var_38_2:cleanupFSM()
		end
	end
end

function VirtualDiamondGridMap:getBossBoxEntity(arg_39_1)
	return self._allBossBoxDict[arg_39_1]
end

return VirtualDiamondGridMap
