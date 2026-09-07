local BuildShipProxy = class("BuildShipProxy", import(".NetProxy"))

BuildShipProxy.ADDED = "BuildShipProxy ADDED"
BuildShipProxy.TIMEUP = "BuildShipProxy TIMEUP"
BuildShipProxy.UPDATED = "BuildShipProxy UPDATED"
BuildShipProxy.REMOVED = "BuildShipProxy REMOVED"
BuildShipProxy.DRAW_COUNT_UPDATE = "BuildShipProxy DRAW_COUNT_UPDATE"
BuildShipProxy.REGULAR_BUILD_POOL_COUNT_UPDATE = "BuildShipProxy.REGULAR_BUILD_POOL_COUNT_UPDATE"

function BuildShipProxy:register()
	self:on(12024, function(arg_2_0)
		self.data = {}
		self.workCount = arg_2_0.worklist_count
		self.drawCount1 = arg_2_0.draw_count_1
		self.drawCount10 = arg_2_0.draw_count_10

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.worklist_list) do
			local var_2_0 = BuildShip.New(iter_2_1)

			var_2_0:setId(iter_2_0)
			table.insert(self.data, var_2_0)
		end

		self:setBuildShipState()

		self.regularExchangeCount = arg_2_0.exchange_count

		return
	end)

	return
end

function BuildShipProxy:GetPools()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(getProxy(ActivityProxy):getActivitiesByTypes({
		ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1,
		ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD
	})) do
		local var_3_1 = {}

		table.insert(var_3_1, function(arg_4_0)
			if iter_3_1 and not iter_3_1:isEnd() then
				arg_4_0()
			end

			return
		end)
		table.insert(var_3_1, function(arg_5_0)
			if iter_3_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD and iter_3_1.data2 >= pg.ship_data_create_exchange[iter_3_1.id].exchange_available_times then
				-- block empty
			else
				arg_5_0()
			end

			return
		end)
		seriesAsync(var_3_1, function()
			table.insert(var_3_0, BuildShipActivityPool.New({
				activityId = iter_3_1.id,
				id = iter_3_1:getConfig("config_id"),
				mark = BuildShipPool.BUILD_POOL_MARK_NEW
			}))

			return
		end)
	end

	table.insert(var_3_0, BuildShipPool.New({
		id = 2,
		mark = BuildShipPool.BUILD_POOL_MARK_LIGHT
	}))
	table.insert(var_3_0, BuildShipPool.New({
		id = 3,
		mark = BuildShipPool.BUILD_POOL_MARK_HEAVY
	}))
	table.insert(var_3_0, BuildShipPool.New({
		id = 1,
		mark = BuildShipPool.BUILD_POOL_MARK_SPECIAL
	}))

	return var_3_0
end

function BuildShipProxy:GetPoolsWithoutNewServer()
	return _.select(self:GetPools(), function(arg_8_0)
		return not (arg_8_0:IsActivity() and arg_8_0:IsNewServerBuild())
	end)
end

function BuildShipProxy:setBuildShipState()
	self:removeBuildTimer()

	self.buildIndex = 0
	self.buildTimers = {}

	for iter_9_0, iter_9_1 in ipairs(self.data or {}) do
		if 0 == self:getMaxWorkCount() then
			break
		end

		if not iter_9_1:isFinish() then
			self.buildIndex = iter_9_0

			self:addBuildTimer()
		end

		if iter_9_1:isFinish() then
			iter_9_1.state = BuildShip.FINISH or BuildShip.ACTIVE
		end
	end

	return
end

function BuildShipProxy:getNextBuildShip()
	local var_10_0

	if self.data[self.buildIndex + 1] and self.data[self.buildIndex + 1].state == BuildShip.INACTIVE then
		self.buildIndex = self.buildIndex + 1
		var_10_0 = self.data[self.buildIndex + 1]
	end

	return var_10_0
end

function BuildShipProxy:activeNextBuild()
	local var_11_0 = self:getNextBuildShip()

	if var_11_0 then
		var_11_0:active()
		self:updateBuildShip(self.buildIndex, var_11_0)
		self:addBuildTimer()
	end

	return
end

function BuildShipProxy:addBuildTimer()
	local var_12_0 = self.buildIndex

	if self.buildTimers[self.buildIndex] then
		self.buildTimers[self.buildIndex]:Stop()

		self.buildTimers[self.buildIndex] = nil
	end

	local function var_12_1()
		self:activeNextBuild()
		self.data[var_12_0]:finish()
		self.data[var_12_0]:display("- build finish -")
		self:updateBuildShip(var_12_0, self.data[var_12_0])

		return
	end

	local var_12_2 = self.data[self.buildIndex].finishTime - pg.TimeMgr.GetInstance():GetServerTime()

	if var_12_2 > 0 then
		self.buildTimers[self.buildIndex] = Timer.New(function()
			self.buildTimers[var_12_0]:Stop()

			self.buildTimers[var_12_0] = nil

			var_12_1()

			return
		end, var_12_2, 1)

		self.buildTimers[self.buildIndex]:Start()
	else
		var_12_1()
	end

	return
end

function BuildShipProxy:getMaxWorkCount()
	return self.workCount
end

function BuildShipProxy:getBuildShipCount()
	return table.getCount(self.data)
end

function BuildShipProxy:removeBuildTimer()
	for iter_17_0, iter_17_1 in pairs(self.buildTimers or {}) do
		iter_17_1:Stop()
	end

	self.buildTimers = nil

	return
end

function BuildShipProxy:remove()
	self:removeBuildTimer()

	if self.exchangeItemTimer then
		self.exchangeItemTimer:Stop()

		self.exchangeItemTimer = nil
	end

	return
end

function BuildShipProxy:getBuildShip(arg_19_1)
	return Clone(self.data[arg_19_1])
end

function BuildShipProxy:getFinishCount()
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in pairs(self.data) do
		if iter_20_1.state == BuildShip.FINISH then
			var_20_0 = var_20_0 + 1
		end
	end

	return var_20_0
end

function BuildShipProxy:getNeedFinishCount()
	return table.getCount(self.data) - self:getFinishCount()
end

function BuildShipProxy:getActiveCount()
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(self.data) do
		if iter_22_1.state == BuildShip.ACTIVE then
			var_22_0 = var_22_0 + 1
		end
	end

	return var_22_0
end

function BuildShipProxy:getFinishedIndex()
	for iter_23_0, iter_23_1 in ipairs(self.data) do
		if iter_23_1.state == BuildShip.FINISH then
			return iter_23_0
		end
	end

	return
end

function BuildShipProxy:canBuildShip(arg_24_1)
	local var_24_0 = self:getActiveCount()
	local var_24_1 = pg.ship_data_create_material[arg_24_1]
	local var_24_2 = getProxy(BagProxy):getItemById(pg.ship_data_create_material[arg_24_1].use_item)

	if var_24_2 and var_24_2.count >= var_24_1.number_1 then
		return getProxy(PlayerProxy):getData().gold >= var_24_1.use_gold and var_24_0 == 0
	end

	return
end

function BuildShipProxy:getActiveOrFinishedCount()
	local var_25_0 = 0

	for iter_25_0, iter_25_1 in pairs(self.data) do
		if iter_25_1.state == BuildShip.ACTIVE or iter_25_1.state == BuildShip.FINISH then
			var_25_0 = var_25_0 + 1
		end
	end

	return var_25_0
end

function BuildShipProxy:getDrawCount()
	return {
		drawCount1 = self.drawCount1,
		drawCount10 = self.drawCount10
	}
end

function BuildShipProxy:increaseDrawCount(arg_27_1)
	if arg_27_1 == 1 then
		self.drawCount1 = self.drawCount1 + 1
	elseif arg_27_1 == 10 then
		self.drawCount10 = self.drawCount10 + 1
	end

	self:sendNotification(BuildShipProxy.DRAW_COUNT_UPDATE, self:getDrawCount())

	return
end

function BuildShipProxy:addBuildShip(arg_28_1)
	assert(isa(arg_28_1, BuildShip), "should be an instance of BuildShip")
	table.insert(self.data, arg_28_1)

	local var_28_0 = self:getActiveCount()
	local var_28_1 = self:getMaxWorkCount()

	if var_28_0 < var_28_1 then
		arg_28_1:setState(BuildShip.ACTIVE)

		self.buildIndex = #self.data

		self:addBuildTimer()
	elseif var_28_0 == var_28_1 then
		arg_28_1:setState(BuildShip.INACTIVE)
	else
		assert(false, "激活的建船数量大于最大数量")
	end

	self:sendNotification(BuildShipProxy.ADDED, arg_28_1:clone())

	return
end

function BuildShipProxy:finishBuildShip(arg_29_1)
	if self.buildTimers[arg_29_1] then
		self.buildTimers[arg_29_1].func()
	end

	return
end

function BuildShipProxy:updateBuildShip(arg_30_1, arg_30_2)
	assert(isa(arg_30_2, BuildShip), "should be an instance of BuildShip")

	self.data[arg_30_1] = arg_30_2:clone()

	self:sendNotification(BuildShipProxy.UPDATED, {
		index = arg_30_1,
		buildShip = arg_30_2:clone()
	})

	return
end

function BuildShipProxy:removeBuildShipByIndex(arg_31_1)
	local var_31_0 = self.data[arg_31_1]:clone()

	assert(var_31_0 ~= nil, "buildShip should exist")

	self.lastPoolType = self.data[arg_31_1].type

	table.remove(self.data, arg_31_1)
	self:sendNotification(BuildShipProxy.REMOVED, {
		index = arg_31_1,
		buildShip = var_31_0
	})

	return
end

function BuildShipProxy:getSkipBatchBuildFlag()
	return self.skipBatchFlag or false
end

function BuildShipProxy:setSkipBatchBuildFlag(arg_33_1)
	self.skipBatchFlag = arg_33_1

	return
end

function BuildShipProxy:getLastBuildShipPoolType()
	return self.lastPoolType or 0
end

function BuildShipProxy:getSupportShipCost()
	return pg.gameset.supports_config.description[1]
end

function BuildShipProxy:changeRegularExchangeCount(arg_36_1)
	self.regularExchangeCount = math.clamp(self.regularExchangeCount + arg_36_1, 0, pg.ship_data_create_exchange[REGULAR_BUILD_POOL_EXCHANGE_ID].exchange_request)

	self:sendNotification(BuildShipProxy.REGULAR_BUILD_POOL_COUNT_UPDATE)

	return
end

function BuildShipProxy:getRegularExchangeCount()
	return self.regularExchangeCount
end

return BuildShipProxy
