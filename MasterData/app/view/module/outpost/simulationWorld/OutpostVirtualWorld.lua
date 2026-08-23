local var_0_0, var_0_1 = pcall(function()
	return require("socket")
end)
local OutpostFightSystem = require("app.view.module.outpost.simulationWorld.fight.OutpostFightSystem")
local VirtualDiamondGridMap = require("app.view.module.outpost.simulationWorld.map.VirtualDiamondGridMap")
local var_0_4 = g.core.const.ConstMgr.outpostConst
local var_0_5 = table.insert
local var_0_6 = table.remove
local var_0_7 = 0.03333333333333333
local VirtualWorld = class("VirtualWorld")

function VirtualWorld:ctor()
	self._allEntityDict = {}
	self._tickDict = {}
	self._addTickList = {}
	self._removeTickList = {}
	self._secondTickDict = {}
	self._addSecondTickList = {}
	self._removeSecondTickList = {}
	self._preSecondTickTime = var_0_4.WorldParam.SecondTickTime
	self._isTickCompensation = false
	self._lastDt = 0
	self.lockEvent = false
	self._tipsData = {}
	self.fightSystem = OutpostFightSystem.new()
	self._gridMap = VirtualDiamondGridMap.new(self)
end

function VirtualWorld:setMapSize(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.lockEvent = true

	self._gridMap:initMap(arg_3_1, arg_3_2, arg_3_3, arg_3_4)

	self.lockEvent = false
end

function VirtualWorld:tickUpdate(arg_4_1)
	if arg_4_1 > 2 then
		return
	end

	if self._isTickCompensation then
		self._lastDt = self._lastDt + arg_4_1

		while self._lastDt >= var_0_7 do
			self:_onTick(var_0_7)

			self._lastDt = self._lastDt - var_0_7
		end
	else
		self:_onTick(arg_4_1)
	end

	self._preSecondTickTime = self._preSecondTickTime - arg_4_1

	if self._preSecondTickTime <= 0 then
		self._preSecondTickTime = self._preSecondTickTime + var_0_4.WorldParam.SecondTickTime

		self:_onTickSecond()
	end
end

function VirtualWorld:_onTick(arg_5_1)
	self:_tickEntity(arg_5_1)
	self.fightSystem:onTick(arg_5_1)
end

function VirtualWorld:_onTickSecond()
	local var_6_0 = var_0_6(self._addSecondTickList)

	while var_6_0 do
		if self._allEntityDict[var_6_0.oid] then
			self._secondTickDict[var_6_0.oid] = var_6_0
		end

		var_6_0 = var_0_6(self._addSecondTickList)
	end

	for iter_6_0, iter_6_1 in pairs(self._secondTickDict) do
		iter_6_1:onSecondTick()
	end

	local var_6_1 = var_0_6(self._removeSecondTickList)

	while var_6_1 do
		self._secondTickDict[var_6_1.oid] = nil
		var_6_1 = var_0_6(self._removeSecondTickList)
	end
end

function VirtualWorld:_tickEntity(arg_7_1)
	local var_7_0 = var_0_6(self._addTickList)

	while var_7_0 do
		if self._allEntityDict[var_7_0.oid] then
			self._tickDict[var_7_0.oid] = var_7_0
		end

		var_7_0 = var_0_6(self._addTickList)
	end

	for iter_7_0, iter_7_1 in pairs(self._tickDict) do
		iter_7_1:onTick(arg_7_1)
	end

	local var_7_1 = var_0_6(self._removeTickList)

	while var_7_1 do
		self._tickDict[var_7_1.oid] = nil
		var_7_1 = var_0_6(self._removeTickList)
	end
end

function VirtualWorld:addEntity(arg_8_1, arg_8_2)
	if self._allEntityDict[arg_8_1.oid] then
		assert(false, string.format("流水id 重复了：%s 类名：%s", arg_8_1.oid, arg_8_1.__cname))

		return
	end

	self._allEntityDict[arg_8_1.oid] = arg_8_1
	arg_8_1.world = self

	arg_8_1:setClear(false)
	arg_8_1:onCreate(arg_8_2)
end

function VirtualWorld:removeEntity(arg_9_1)
	self._allEntityDict[arg_9_1.oid] = nil

	if self._tickDict[arg_9_1.oid] then
		self._tickDict[arg_9_1.oid] = nil
	end

	if self._secondTickDict[arg_9_1.oid] then
		self._secondTickDict[arg_9_1.oid] = nil
	end

	arg_9_1:onDestroy()
	arg_9_1:setClear(true)

	arg_9_1.world = nil
end

function VirtualWorld:addTickEntity(arg_10_1)
	var_0_5(self._addTickList, arg_10_1)
end

function VirtualWorld:removeTickEntity(arg_11_1)
	var_0_5(self._removeTickList, arg_11_1)
end

function VirtualWorld:addSecondTickEntity(arg_12_1)
	var_0_5(self._addSecondTickList, arg_12_1)
end

function VirtualWorld:removeSecondTickEntity(arg_13_1)
	var_0_5(self._removeSecondTickList, arg_13_1)
end

function VirtualWorld:aStarPath(arg_14_1, arg_14_2, arg_14_3)
	return self._gridMap:findPath(arg_14_1, arg_14_2, arg_14_3)
end

function VirtualWorld:joinMap(arg_15_1)
	if not self._allEntityDict[arg_15_1.oid] then
		return
	end

	self._gridMap:worldJoinMap(arg_15_1)
end

function VirtualWorld:getVirtualMap()
	return self._gridMap
end

function VirtualWorld:exitWorld()
	if self._profiler then
		self._profiler:onStop()
	end

	self._gridMap:exitMap()
end

function VirtualWorld:changeTipsData(arg_18_1, arg_18_2, arg_18_3)
	if arg_18_1 == var_0_4.TIPS_TYPE.KNIGHT then
		self._tipsData[var_0_4.TIPS_TYPE.KNIGHT] = self._tipsData[var_0_4.TIPS_TYPE.KNIGHT] or {}

		if arg_18_2 then
			if not self._tipsData[var_0_4.TIPS_TYPE.KNIGHT][arg_18_2] then
				self._tipsData.changed = true
			end

			self._tipsData[var_0_4.TIPS_TYPE.KNIGHT][arg_18_2] = arg_18_3
		else
			for iter_18_0, iter_18_1 in pairs(self._tipsData[var_0_4.TIPS_TYPE.KNIGHT]) do
				if iter_18_1.entity and not iter_18_1.cmdBuild then
					self._tipsData[var_0_4.TIPS_TYPE.KNIGHT][iter_18_0] = nil
					self._tipsData.changed = true
				end
			end
		end
	elseif arg_18_1 == var_0_4.TIPS_TYPE.BUILD then
		self._tipsData.changed = true
		self._tipsData.checkTipBuild = arg_18_2
	end
end

function VirtualWorld:getCheckTipKnight()
	return self._tipsData[var_0_4.TIPS_TYPE.KNIGHT]
end

function VirtualWorld:getTopBuild()
	return self._tipsData.checkTipBuild
end

function VirtualWorld:isNeedUpdateTip()
	if self._tipsData.changed then
		self._tipsData.changed = false

		return true
	end

	return false
end

return VirtualWorld
