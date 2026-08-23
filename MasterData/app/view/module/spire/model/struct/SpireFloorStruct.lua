local SpireStageStruct = require("app.view.module.spire.model.struct.SpireStageStruct")
local SpireBossStageStruct = require("app.view.module.spire.model.struct.SpireBossStageStruct")
local SpireFloorStruct = class("SpireFloorStruct")

function SpireFloorStruct:ctor(arg_1_1, arg_1_2, arg_1_3)
	self._floor = arg_1_1
	self._curStage = 1
	self._stageBuffDic = {}
	self._stageList = {}

	self:initStageList(arg_1_2, arg_1_3)
end

function SpireFloorStruct:initStageList(arg_2_1, arg_2_2)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		self._stageList[#self._stageList + 1] = SpireStageStruct.new(iter_2_1.id, arg_2_2)
	end
end

function SpireFloorStruct:getFloorId()
	return self._floor
end

function SpireFloorStruct:getStageList()
	return self._stageList
end

function SpireFloorStruct:getMaxStage()
	local var_5_0 = #self._stageList

	if self:hasBossStage() then
		var_5_0 = var_5_0 - 1
	end

	return var_5_0
end

function SpireFloorStruct:getCurStage()
	if self:isPass() then
		return self:getCurPassStage()
	end

	return self._curStage
end

function SpireFloorStruct:getCurPassStage()
	return self:isPass() and self:getMaxStage() or self._curStage - 1
end

function SpireFloorStruct:getCurStageStruct()
	return self._stageList[self._curStage]
end

function SpireFloorStruct:getNextStageStruct()
	return self._stageList[self._curStage + 1]
end

function SpireFloorStruct:getCurPassStageStruct()
	local var_10_0 = self:getCurPassStage()

	return (var_10_0 > 0 or nil) and self._stageList[var_10_0]
end

function SpireFloorStruct:setBossStage(arg_11_1, arg_11_2)
	self._stageList[#self._stageList + 1] = SpireBossStageStruct.new(arg_11_1, arg_11_2)
end

function SpireFloorStruct:hasBossStage()
	return self._stageList[#self._stageList]:isBossStage()
end

function SpireFloorStruct:getBossStage()
	if self:hasBossStage() then
		return self._stageList[#self._stageList]
	end
end

function SpireFloorStruct:isPass(arg_14_1)
	if arg_14_1 then
		-- block empty
	end

	return self._stageList[self:getMaxStage()]:isPass()
end

function SpireFloorStruct:getPassStagePassAwards(arg_15_1, arg_15_2, arg_15_3)
	arg_15_1 = arg_15_1 or {}
	arg_15_2 = arg_15_2 or {}

	for iter_15_0 = 1, math.min(self._curStage, (self:getMaxStage())) do
		for iter_15_1, iter_15_2 in ipairs((self._stageList[iter_15_0]:getPassAwards())) do
			local var_15_0 = arg_15_2[table.concat({
				iter_15_2.type,
				iter_15_2.value
			}, "_")]
			local var_15_1 = iter_15_2.size

			if arg_15_3 then
				var_15_1 = 0
			end

			if not var_15_0 then
				var_15_0 = {
					size = 0,
					type = iter_15_2.type,
					value = iter_15_2.value
				}
				arg_15_1[#arg_15_1 + 1] = var_15_0
			end

			var_15_0.size = var_15_0.size + var_15_1
		end
	end

	return arg_15_1, arg_15_2
end

function SpireFloorStruct:getPassStageIdleAwards(arg_16_1, arg_16_2, arg_16_3)
	arg_16_1 = arg_16_1 or {}
	arg_16_2 = arg_16_2 or {}

	for iter_16_0 = 1, math.min(self._curStage, (self:getMaxStage())) do
		for iter_16_1, iter_16_2 in ipairs((self._stageList[iter_16_0]:getOutputGoods())) do
			local var_16_0 = arg_16_2[table.concat({
				iter_16_2.type,
				iter_16_2.value
			}, "_")]
			local var_16_1 = iter_16_2.size

			if arg_16_3 then
				var_16_1 = 0
			end

			if not var_16_0 then
				var_16_0 = {
					size = 0,
					type = iter_16_2.type,
					value = iter_16_2.value
				}
				arg_16_1[#arg_16_1 + 1] = var_16_0
			end

			var_16_0.size = var_16_0.size + var_16_1
		end
	end

	return arg_16_1, arg_16_2
end

function SpireFloorStruct:updateFloorBySvrInfo(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1.spires) do
		self:updateStage(iter_17_1)

		self._curStage = math.min(iter_17_1.stage + 1, #self._stageList)
	end

	if arg_17_1.boss then
		self:updateBossStage(arg_17_1.boss)
	end
end

function SpireFloorStruct:updateStage(arg_18_1, arg_18_2)
	if self._stageList[arg_18_1.stage] then
		self._stageList[arg_18_1.stage]:updateStageBySvrInfo(arg_18_1)

		if arg_18_2 then
			self._curStage = math.min(arg_18_1.stage + 1, #self._stageList)
		end
	end
end

function SpireFloorStruct:updateBossStage(arg_19_1)
	local var_19_0 = self:getBossStage()

	if var_19_0 then
		var_19_0:updateStageBySvrInfo(arg_19_1)
	end
end

function SpireFloorStruct:updateBossBuff(arg_20_1, arg_20_2)
	local var_20_0 = self:getBossStage()

	if var_20_0 then
		var_20_0:updateBossBuff(arg_20_1, arg_20_2)
	end
end

function SpireFloorStruct:onS2CStageFinish(arg_21_1)
	self:getCurStageStruct():onStageFinish(arg_21_1)

	self._curStage = math.min(self._curStage + 1, #self._stageList)
end

function SpireFloorStruct:onS2CBossFinish(arg_22_1)
	self:getBossStage():onStageFinish(arg_22_1)
end

return SpireFloorStruct
