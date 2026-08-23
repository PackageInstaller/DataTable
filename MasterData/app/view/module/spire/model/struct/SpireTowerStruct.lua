local SpireFloorStruct = require("app.view.module.spire.model.struct.SpireFloorStruct")
local SpireTowerStruct = class("SpireTowerStruct")

function SpireTowerStruct:ctor(arg_1_1, arg_1_2, arg_1_3)
	self._cfg = arg_1_1
	self._curFloor = 1
	self._isPass = false
	self._floorList = arg_1_2
	self._isBossTower = false
	self._preTowerStruct = nil
	self._showChallenge = (g.core.common.Storage:load("spire_tower_challenge.json", true) or {})[tostring(self._cfg.id)]

	self:_initTowerData(arg_1_3)
end

function SpireTowerStruct:_initTowerData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(self._floorList) do
		self._floorList[iter_2_0] = SpireFloorStruct.new(iter_2_0, iter_2_1, arg_2_1)
	end

	if self._cfg.boss_id ~= 0 then
		self._floorList[#self._floorList]:setBossStage(self._cfg.boss_id, arg_2_1)

		self._isBossTower = true
	end
end

function SpireTowerStruct:getCfg()
	return self._cfg
end

function SpireTowerStruct:setPreTower(arg_4_1)
	self._preTowerStruct = arg_4_1
end

function SpireTowerStruct:isUnLock(arg_5_1, arg_5_2)
	return g.core.common.ServerTime:getTime() >= g.core.common.ServerTime:getNextNDayZeroTime(arg_5_1, self._cfg.unlock) and (self._preTowerStruct or nil) and (arg_5_2 and arg_5_2[self._cfg.pre_type] and true or self._preTowerStruct:isPass())
end

function SpireTowerStruct:isUnlockByTime(arg_6_1)
	return g.core.common.ServerTime:getTime() >= self:getUnlockTime(arg_6_1)
end

function SpireTowerStruct:getUnlockTime(arg_7_1)
	return g.core.common.ServerTime:getNextNDayZeroTime(arg_7_1, self._cfg.unlock)
end

function SpireTowerStruct:getCurFloorIndex()
	return self._curFloor
end

function SpireTowerStruct:getFloor(arg_9_1)
	return self._floorList[arg_9_1]
end

function SpireTowerStruct:getCurFloor()
	return self._floorList[self._curFloor]
end

function SpireTowerStruct:getMaxFloor()
	return self._floorList[#self._floorList]
end

function SpireTowerStruct:getFloorList()
	return self._floorList
end

function SpireTowerStruct:isBossTower()
	return self._isBossTower
end

function SpireTowerStruct:getMulFormationType()
	return self._cfg.type + 21
end

function SpireTowerStruct:getBossResId()
	return (self._isBossTower or nil) and self:getMaxFloor():getBossStage():getShowSpineId()
end

function SpireTowerStruct:getPassFloorPassAwards(arg_16_1)
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0 = 1, #self._floorList do
		var_16_0 = self._floorList[iter_16_0]:getPassStagePassAwards(var_16_0, var_16_1, arg_16_1)
	end

	return var_16_0
end

function SpireTowerStruct:getPassFloorIdleAwards(arg_17_1)
	local var_17_0 = {}
	local var_17_1 = {}

	for iter_17_0 = 1, self._curFloor do
		var_17_0 = self._floorList[iter_17_0]:getPassStageIdleAwards(var_17_0, var_17_1, arg_17_1)
	end

	return var_17_0
end

function SpireTowerStruct:getCurPassStageStruct()
	local var_18_0

	if self._floorList[self._curFloor]:getCurStage() ~= 1 then
		var_18_0 = self._floorList[self._curFloor]:getCurPassStageStruct()
	elseif self._curFloor > 1 then
		var_18_0 = self._floorList[self._curFloor - 1]:getCurPassStageStruct()
	end

	return var_18_0
end

function SpireTowerStruct:isPass(arg_19_1)
	return (self:getMaxFloor():isPass(arg_19_1))
end

function SpireTowerStruct:getAllPassStageCnt()
	local var_20_0 = 0

	for iter_20_0 = 1, self._curFloor do
		var_20_0 = iter_20_0 < self._curFloor and var_20_0 + #self._floorList[iter_20_0]:getStageList() or var_20_0 + self._floorList[iter_20_0]:getCurPassStage()
	end

	return var_20_0
end

function SpireTowerStruct:getDeepBuffList()
	local var_21_0 = {}

	for iter_21_0 = 1, self._curFloor do
		local var_21_1 = self._floorList[iter_21_0]:getStageList()

		for iter_21_1 = 1, self._floorList[iter_21_0]:getCurStage() do
			for iter_21_2, iter_21_3 in ipairs((var_21_1[iter_21_1]:getBuffInfoList())) do
				var_21_0[#var_21_0 + 1] = iter_21_3.buff
			end
		end
	end

	return var_21_0
end

function SpireTowerStruct:showChallenge()
	if self._showChallenge then
		return
	end

	local var_22_0 = g.core.common.Storage:load("spire_tower_challenge.json", true) or {}

	var_22_0[tostring(self._cfg.id)] = true

	g.core.common.Storage:save("spire_tower_challenge.json", var_22_0, true)

	self._showChallenge = true
end

function SpireTowerStruct:isShowChallenge()
	return self._showChallenge
end

function SpireTowerStruct:updateTowerDataBySvrInfo(arg_24_1)
	local var_24_0 = arg_24_1.floor or 1

	for iter_24_0 = 1, var_24_0 - 1 do
		self._floorList[iter_24_0]:updateStage({
			pass_time = 1,
			stage = self._floorList[iter_24_0]:getMaxStage()
		})
	end

	self._floorList[var_24_0]:updateStage(arg_24_1, true)

	self._curFloor = self._floorList[var_24_0]:isPass() and math.min(var_24_0 + 1, #self._floorList) or var_24_0
end

function SpireTowerStruct:updateBossStage(arg_25_1)
	self._floorList[#self._floorList]:updateBossStage(arg_25_1)
end

function SpireTowerStruct:onS2CStageFinish(arg_26_1)
	local var_26_0 = self:getCurFloor()

	var_26_0:onS2CStageFinish(arg_26_1)

	if var_26_0:isPass() then
		self._curFloor = math.min(self._curFloor + 1, #self._floorList)
	end
end

function SpireTowerStruct:onS2CBossFinish(arg_27_1)
	self:getCurFloor():onS2CBossFinish(arg_27_1)
end

return SpireTowerStruct
