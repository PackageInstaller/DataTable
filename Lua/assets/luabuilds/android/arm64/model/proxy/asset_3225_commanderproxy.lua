local CommanderProxy = class("CommanderProxy", import(".NetProxy"))

CommanderProxy.COMMANDER_UPDATED = "CommanderProxy:COMMANDER_UPDATED"
CommanderProxy.COMMANDER_ADDED = "CommanderProxy:COMMANDER_ADDED"
CommanderProxy.COMMANDER_DELETED = "CommanderProxy:COMMANDER_DELETED"
CommanderProxy.RESERVE_CNT_UPDATED = "CommanderProxy:RESERVE_CNT_UPDATED"
CommanderProxy.COMMANDER_BOX_FINISHED = "CommanderProxy:COMMANDER_BOX_FINISHED"
CommanderProxy.PREFAB_FLEET_UPDATE = "CommanderProxy:PREFAB_FLEET_UPDATE"
CommanderProxy.MAX_WORK_COUNT = 4
CommanderProxy.MAX_SLOT = 10
CommanderProxy.MAX_PREFAB_FLEET = 3

function CommanderProxy:register()
	self.data = {}
	self.boxes = {}
	self.prefabFleet = {}
	self.openCommanderScene = false

	for iter_1_0 = 1, CommanderProxy.MAX_PREFAB_FLEET do
		self.prefabFleet[iter_1_0] = CommnaderFleet.New({
			id = iter_1_0
		})
	end

	for iter_1_1 = 1, pg.gameset.commander_box_count.key_value do
		self:addBox((CommanderBox.New({
			id = iter_1_1
		})))
	end

	self.pools = {}

	for iter_1_2, iter_1_3 in ipairs(pg.commander_data_create_material.all) do
		table.insert(self.pools, (CommanderBuildPool.New({
			id = iter_1_3
		})))
	end

	self.boxUsageCount = 0

	self:on(25001, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.commanders) do
			self:addCommander((Commander.New(iter_2_1)))
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.box) do
			self:updateBox((CommanderBox.New(iter_2_3, iter_2_2)))
		end

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.presets) do
			local var_2_0 = {}

			for iter_2_6, iter_2_7 in ipairs(iter_2_5.commandersid) do
				local var_2_1 = self:getCommanderById(iter_2_7.id)

				if var_2_1 then
					var_2_0[iter_2_7.pos] = var_2_1
				end
			end

			self.prefabFleet[iter_2_5.id]:Update({
				id = iter_2_5.id,
				name = arg_2_0.name,
				commanders = var_2_0
			})
		end

		self.boxUsageCount = arg_2_0.usage_count or 0

		if not LOCK_CATTERY then
			self:sendNotification(GAME.GET_COMMANDER_HOME)
		end

		return
	end)

	self.newCommanderList = {}

	self:on(25039, function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.commander_list) do
			local var_3_0 = Commander.New(iter_3_1)

			self:addCommander(var_3_0)
			table.insert(self.newCommanderList, var_3_0)
		end

		return
	end)

	return
end

function CommanderProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_5_0)
			self:resetBoxUseCnt()

			local var_5_0 = self:GetCommanderHome()

			if var_5_0 then
				var_5_0:ResetCatteryOP()
				var_5_0:ReduceClean()
			end

			return
		end
	}
end

function CommanderProxy:GetNewestCommander(arg_6_1, arg_6_2)
	local var_6_0 = defaultValue(arg_6_2, true)

	if arg_6_1 >= #self.newCommanderList then
		return self.newCommanderList
	else
		local var_6_1 = {}

		for iter_6_0 = #self.newCommanderList - arg_6_1 + 1, #self.newCommanderList do
			table.insert(var_6_1, self.newCommanderList[iter_6_0])
		end

		return var_6_1
	end

	if var_6_0 then
		self.newCommanderList = {}
	end

	return
end

function CommanderProxy:getPrefabFleetById(arg_7_1)
	return self.prefabFleet[arg_7_1]
end

function CommanderProxy:getPrefabFleet()
	return Clone(self.prefabFleet)
end

function CommanderProxy:updatePrefabFleet(arg_9_1)
	self.prefabFleet[arg_9_1.id] = arg_9_1

	self:sendNotification(CommanderProxy.PREFAB_FLEET_UPDATE)

	return
end

function CommanderProxy:updatePrefabFleetName(arg_10_1, arg_10_2)
	self.prefabFleet[arg_10_1]:updateName(arg_10_2)
	self:sendNotification(CommanderProxy.PREFAB_FLEET_UPDATE)

	return
end

function CommanderProxy:getCommanderCnt()
	return table.getCount(self.data)
end

function CommanderProxy:getPoolById(arg_12_1)
	return _.detect(self:getPools(), function(arg_13_0)
		return arg_13_0.id == arg_12_1
	end)
end

function CommanderProxy:getPools()
	return self.pools
end

function CommanderProxy:getBoxUseCnt()
	return self.boxUsageCount
end

function CommanderProxy:updateBoxUseCnt(arg_16_1)
	self.boxUsageCount = self.boxUsageCount + arg_16_1

	self:sendNotification(CommanderProxy.RESERVE_CNT_UPDATED, self.boxUsageCount)

	return
end

function CommanderProxy:resetBoxUseCnt()
	self.boxUsageCount = 0

	self:sendNotification(CommanderProxy.RESERVE_CNT_UPDATED, 0)

	return
end

function CommanderProxy:updateBox(arg_18_1)
	self.boxes[arg_18_1.id] = arg_18_1

	return
end

function CommanderProxy:addBox(arg_19_1)
	self.boxes[arg_19_1.id] = arg_19_1

	return
end

function CommanderProxy:getBoxes()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(self.boxes) do
		table.insert(var_20_0, iter_20_1)
	end

	return var_20_0
end

function CommanderProxy:getBoxById(arg_21_1)
	assert(self.boxes[arg_21_1], "attemp to get a nil box" .. arg_21_1)

	return self.boxes[arg_21_1]
end

function CommanderProxy:getCommanderById(arg_22_1)
	if self.data[arg_22_1] then
		return self.data[arg_22_1]:clone()
	end

	return
end

function CommanderProxy:RawGetCommanderById(arg_23_1)
	if self.data[arg_23_1] then
		return self.data[arg_23_1]
	end

	return
end

function CommanderProxy:GetSameConfigIdCommanderCount(arg_24_1)
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in pairs(self.data) do
		if iter_24_1.configId == arg_24_1 then
			var_24_0 = var_24_0 + 1
		end
	end

	return var_24_0
end

function CommanderProxy:addCommander(arg_25_1)
	self.data[arg_25_1.id] = arg_25_1

	if getProxy(PlayerProxy):getInited() then
		self:sendNotification(CommanderProxy.COMMANDER_ADDED, arg_25_1:clone())
	end

	return
end

function CommanderProxy:updateCommander(arg_26_1)
	assert(self.data[arg_26_1.id], "commander can not be nil")
	assert(isa(arg_26_1, Commander), "commander should be and instance of Commander")

	self.data[arg_26_1.id] = arg_26_1

	self:sendNotification(CommanderProxy.COMMANDER_UPDATED, arg_26_1:clone())

	return
end

function CommanderProxy:removeCommanderById(arg_27_1)
	self:checkPrefabFleet(arg_27_1)
	assert(self.data[arg_27_1], "commander can not be nil")

	self.data[arg_27_1] = nil

	self:sendNotification(CommanderProxy.COMMANDER_DELETED, arg_27_1)

	return
end

function CommanderProxy:checkPrefabFleet(arg_28_1)
	for iter_28_0, iter_28_1 in pairs(self.prefabFleet) do
		if iter_28_1:contains(arg_28_1) then
			iter_28_1:removeCommander(arg_28_1)
		end
	end

	return
end

function CommanderProxy:haveFinishedBox()
	for iter_29_0, iter_29_1 in pairs(self.boxes) do
		if iter_29_1:getState() == CommanderBox.STATE_FINISHED then
			return true
		end
	end

	return false
end

function CommanderProxy:IsFinishAllBox()
	local var_30_0 = 0
	local var_30_1 = 0
	local var_30_2 = 0

	for iter_30_0, iter_30_1 in pairs(self.boxes) do
		local var_30_3 = iter_30_1:getState()

		if var_30_3 == CommanderBox.STATE_FINISHED then
			var_30_0 = var_30_0 + 1
		elseif var_30_3 == CommanderBox.STATE_EMPTY then
			var_30_1 = var_30_1 + 1
		end

		var_30_2 = var_30_2 + 1
	end

	return var_30_0 > 0 and var_30_0 + var_30_1 == var_30_2
end

function CommanderProxy:onRemove()
	self:RemoveCalcExpTimer()
	CommanderProxy.super.onRemove(self)

	self.openCommanderScene = false

	return
end

function CommanderProxy:AddCommanderHome(arg_32_1)
	self.commanderHome = arg_32_1

	self:StartCalcExpTimer(GetNextHour(1) - pg.TimeMgr.GetInstance():GetServerTime())

	return
end

function CommanderProxy:GetCommanderHome()
	return self.commanderHome
end

function CommanderProxy:StartCalcExpTimer(arg_34_1)
	self:RemoveCalcExpTimer()

	self.calcExpTimer = Timer.New(function()
		self:RemoveCalcExpTimer()
		self:sendNotification(GAME.CALC_CATTERY_EXP, {
			isPeriod = arg_34_1 == 16
		})
		self:StartCalcExpTimer(3600)

		return
	end, arg_34_1, 1)

	self.calcExpTimer:Start()

	return
end

function CommanderProxy:RemoveCalcExpTimer()
	if self.calcExpTimer then
		self.calcExpTimer:Stop()

		self.calcExpTimer = nil
	end

	return
end

function CommanderProxy:AnyCatteryExistOP()
	local var_37_0 = self:GetCommanderHome()

	if var_37_0 then
		return var_37_0:AnyCatteryExistOP()
	end

	return false
end

function CommanderProxy:AnyCatteryCanUse()
	local var_38_0 = self:GetCommanderHome()

	if var_38_0 then
		return var_38_0:AnyCatteryCanUse()
	end

	return false
end

function CommanderProxy:IsHome(arg_39_1)
	local var_39_0 = self:GetCommanderHome()

	if var_39_0 then
		return var_39_0:CommanderInHome(arg_39_1)
	end

	return false
end

function CommanderProxy:UpdateOpenCommanderScene(arg_40_1)
	self.openCommanderScene = arg_40_1

	return
end

function CommanderProxy:InCommanderScene()
	return self.openCommanderScene
end

function CommanderProxy:AnyPoolIsWaiting()
	local var_42_0 = 0

	for iter_42_0, iter_42_1 in pairs(self.boxes) do
		local var_42_1 = iter_42_1:getState()

		if var_42_1 == CommanderBox.STATE_WAITING or var_42_1 == CommanderBox.STATE_STARTING then
			return false
		end

		if var_42_1 == CommanderBox.STATE_FINISHED then
			var_42_0 = var_42_0 + 1
		end
	end

	return var_42_0 > 0
end

function CommanderProxy:ShouldTipBox()
	if (function()
		local var_44_0 = 0

		for iter_44_0, iter_44_1 in pairs(self.pools) do
			var_44_0 = var_44_0 + iter_44_1:getItemCount()
		end

		return var_44_0 > 0
	end)() then
		if (function()
			for iter_45_0, iter_45_1 in pairs(self.boxes) do
				if iter_45_1:getState() == CommanderBox.STATE_EMPTY then
					return true
				end
			end

			return false
		end)() then
			return true
		else
			return self:IsFinishAllBox()
		end
	else
		return self:IsFinishAllBox()
	end

	return
end

function CommanderProxy:CalcQuickItemUsageCnt()
	local var_46_0 = Item.getConfigData(Item.COMMANDER_QUICKLY_TOOL_ID).usage_arg[1]

	local function var_46_1(arg_47_0, arg_47_1)
		return math.ceil((arg_47_1 - arg_47_0) / var_46_0)
	end

	local var_46_2 = getProxy(BagProxy):getItemCountById(Item.COMMANDER_QUICKLY_TOOL_ID)
	local var_46_3 = 0
	local var_46_4 = 0
	local var_46_5 = 0
	local var_46_6 = {}
	local var_46_7 = {}

	for iter_46_0, iter_46_1 in pairs(self.boxes) do
		table.insert(var_46_7, iter_46_1)
	end

	table.sort(var_46_7, function(arg_48_0, arg_48_1)
		local var_48_0 = arg_48_1.state

		if arg_48_0.state == arg_48_1.state then
			return arg_48_0.index < arg_48_1.index
		else
			return var_48_0 < arg_48_0.state
		end

		return
	end)

	for iter_46_2, iter_46_3 in ipairs(var_46_7) do
		local var_46_9 = iter_46_3:getState()

		if var_46_9 == CommanderBox.STATE_WAITING then
			var_46_3 = var_46_3 + 1
			var_46_5 = var_46_5 + 1

			table.insert(var_46_6, iter_46_3)

			var_46_4 = var_46_4 + var_46_1(iter_46_3.beginTime, iter_46_3.finishTime)
		elseif var_46_9 == CommanderBox.STATE_STARTING then
			var_46_3 = var_46_3 + 1
			var_46_5 = var_46_5 + 1

			table.insert(var_46_6, iter_46_3)

			var_46_4 = var_46_4 + var_46_1(pg.TimeMgr.GetInstance():GetServerTime(), iter_46_3.finishTime)
		end

		if var_46_4 == var_46_2 then
			break
		elseif var_46_2 < var_46_4 then
			var_46_4 = var_46_2
			var_46_5 = var_46_5 - 1

			table.remove(var_46_6, #var_46_6)

			break
		end
	end

	local var_46_10 = {
		0,
		0,
		0
	}

	for iter_46_4, iter_46_5 in ipairs(var_46_6) do
		local var_46_11 = iter_46_5.pool:getRarity()

		var_46_10[var_46_11] = var_46_10[var_46_11] + 1
	end

	return var_46_4, var_46_3, var_46_5, var_46_10
end

return CommanderProxy
