local KsMath = require("app.core.utils.KsMath")
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_2 = g.core.model.User.outpostData
local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local var_0_4 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBuildBase = class("OutpostEntityBuildBase", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBase"))

function OutpostEntityBuildBase:ctor()
	OutpostEntityBuildBase.super.ctor(self)

	self.entityType = var_0_4.EntityType.Build
	self.buildType = var_0_4.BuildType.None
	self._buildStruct = nil
	self._knightList = {}
	self._doorList = {}
	self._doorMiniGridDict = {}
	self._eventDict = {}
end

function OutpostEntityBuildBase:resetAllDoor()
	self._doorList = {}
	self._doorMiniGridDict = {}
end

function OutpostEntityBuildBase:addDoorPixelPos(arg_3_1, arg_3_2)
	table.insert(self._doorList, arg_3_1)

	self._doorMiniGridDict[arg_3_2] = true
end

function OutpostEntityBuildBase:getBuildType()
	return self.buildType
end

function OutpostEntityBuildBase:setBuildStruct(arg_5_1)
	self._buildStruct = arg_5_1
end

function OutpostEntityBuildBase:tryJoinKnight(arg_6_1)
	if not self:isInBuildDoorRange(arg_6_1.x, arg_6_1.y) then
		return false
	end

	local var_6_0 = self._buildStruct:canAddKnight(arg_6_1:getUid())

	if var_6_0 ~= var_0_4.REJECT_IN_BUILD_REASON.NONE then
		if not self._eventDict[arg_6_1.oid] then
			var_0_2:dispatchWorldEvent(OutpostEvent.KnightTalk, {
				talkType = var_0_4.TalkType.Talk1001,
				buildType = self.buildType,
				entity = arg_6_1,
				status = var_6_0
			})
			self.world:changeTipsData(var_0_4.TIPS_TYPE.BUILD, self.buildType)

			self._eventDict[arg_6_1.oid] = true
		end

		return
	end

	table.insert(self._knightList, arg_6_1)
	self:inBuild(arg_6_1)

	local var_6_1 = {}

	var_6_1.knightId = arg_6_1:getEntityKnightStruct():getServerId()
	var_6_1.hpRate = arg_6_1:getAttr():getHpRate()
	var_6_1.demonicEnergy = arg_6_1:getDemonicEnergy()
	var_6_1.hunger = arg_6_1.hunger
	var_6_1.fatigue = arg_6_1:getFatigue()
	var_6_1.mood = arg_6_1.mood

	self._buildStruct:onEffect(var_6_1)

	return true
end

function OutpostEntityBuildBase:initSetInKnight(arg_7_1)
	table.insert(self._knightList, arg_7_1)
	self:inBuild(arg_7_1)
end

function OutpostEntityBuildBase:inBuild(arg_8_1)
	arg_8_1.inBuilding = self

	var_0_2:dispatchWorldEvent(OutpostEvent.RoleInBuild, {
		entity = arg_8_1,
		build = self
	})

	if #self._knightList == 1 then
		self.world:addSecondTickEntity(self)
	end

	self:OnIn(arg_8_1)
end

function OutpostEntityBuildBase:OnIn(arg_9_1)
	return
end

function OutpostEntityBuildBase:outBuild(arg_10_1)
	arg_10_1.inBuilding = nil

	self:OnOut(arg_10_1)
	arg_10_1:OnOutBuild(self)

	if #self._knightList == 1 then
		self.world:removeSecondTickEntity(self)
	end

	self._eventDict[arg_10_1.oid] = false

	var_0_2:dispatchWorldEvent(OutpostEvent.RoleOutBuild, {
		entity = arg_10_1,
		build = self
	})
	var_0_2:dispatchWorldEvent(OutpostEvent.KnightTalk, {
		talkType = var_0_4.TalkType.Talk1002,
		buildType = self.buildType,
		entity = arg_10_1
	})
	self.world:changeTipsData(var_0_4.TIPS_TYPE.BUILD)
end

function OutpostEntityBuildBase:OnOut(arg_11_1)
	return
end

function OutpostEntityBuildBase:getBuildDoorRandomPos()
	return self._doorList[math.random(1, #self._doorList)]
end

function OutpostEntityBuildBase:isInBuildDoorRange(arg_13_1, arg_13_2)
	local var_13_0, var_13_1 = OutpostCommon.pixelToCoord(arg_13_1, arg_13_2)

	return self._doorMiniGridDict[KsMath.mathUnifiedCoordinate(var_13_0, var_13_1)]
end

function OutpostEntityBuildBase:getBuildStruct()
	return self._buildStruct
end

function OutpostEntityBuildBase:canUseBuild()
	if #self._doorList <= 0 then
		return false
	end

	return not self._buildStruct:isLockBuild()
end

function OutpostEntityBuildBase:onSecondTick(arg_16_1)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self._knightList) do
		if not self._buildStruct:isInBuilding(iter_16_1:getUid()) then
			self:outBuild(iter_16_1)
			table.insert(var_16_0, 1, iter_16_0)
		end
	end

	for iter_16_2, iter_16_3 in ipairs(var_16_0) do
		table.remove(self._knightList, iter_16_3)
	end
end

return OutpostEntityBuildBase
