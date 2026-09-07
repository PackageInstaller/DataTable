local TechnologyProxy = class("TechnologyProxy", import(".NetProxy"))

TechnologyProxy.TECHNOLOGY_UPDATED = "TechnologyProxy:TECHNOLOGY_UPDATED"
TechnologyProxy.BLUEPRINT_ADDED = "TechnologyProxy:BLUEPRINT_ADDED"
TechnologyProxy.BLUEPRINT_UPDATED = "TechnologyProxy:BLUEPRINT_UPDATED"
TechnologyProxy.REFRESH_UPDATED = "TechnologyProxy:REFRESH_UPDATED"

function TechnologyProxy:register()
	self.tendency = {}

	self:on(24, function(arg_2_0)
		self:updateTechnologys(arg_2_0.refresh_list)

		self.refreshTechnologysFlag = arg_2_0.refresh_flag

		self:updateTecCatchup(arg_2_0.catchup)
		self:updateTechnologyQueue(arg_2_0.queue)

		return
	end)

	self.bluePrintData = {}
	self.item2blueprint = {}
	self.maxConfigVersion = 0

	_.each(pg.ship_data_blueprint.all, function(arg_3_0)
		local var_3_0 = ShipBluePrint.New({
			id = arg_3_0
		})

		self.maxConfigVersion = math.max(self.maxConfigVersion, var_3_0:getConfig("blueprint_version"))
		self.bluePrintData[var_3_0.id] = var_3_0
		self.item2blueprint[var_3_0:getItemId()] = var_3_0.id

		return
	end)
	self:on(63100, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.blueprint_list) do
			assert(self.bluePrintData[iter_4_1.id], "miss config ship_data_blueprint>>>>>>>>" .. iter_4_1.id)
			self.bluePrintData[iter_4_1.id]:updateInfo(iter_4_1)
		end

		self.coldTime = arg_4_0.cold_time or 0
		self.pursuingTimes = arg_4_0.daily_catchup_strengthen or 0
		self.pursuingTimesUR = arg_4_0.daily_catchup_strengthen_ur or 0

		return
	end)

	return
end

function TechnologyProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_6_0)
			self:updateRefreshFlag(0)

			return
		end,
		[ProxyRegister.HourCall] = function(arg_7_0)
			if arg_7_0 == 4 then
				self:resetPursuingTimes()
			end

			return
		end
	}
end

function TechnologyProxy:setVersion(arg_8_1)
	PlayerPrefs.SetInt("technology_version", arg_8_1)
	PlayerPrefs.Save()

	return
end

function TechnologyProxy:getVersion()
	if not PlayerPrefs.HasKey("technology_version") then
		self:setVersion(1)

		return 1
	else
		return PlayerPrefs.GetInt("technology_version")
	end

	return
end

function TechnologyProxy:getConfigMaxVersion()
	return self.maxConfigVersion
end

function TechnologyProxy:setTendency(arg_11_1, arg_11_2)
	self.tendency[arg_11_1] = arg_11_2

	return
end

function TechnologyProxy:getTendency(arg_12_1)
	return self.tendency[arg_12_1]
end

function TechnologyProxy:updateBlueprintStates()
	for iter_13_0, iter_13_1 in pairs(self.bluePrintData or {}) do
		iter_13_1:updateState()
	end

	return
end

function TechnologyProxy:getColdTime()
	return self.coldTime
end

function TechnologyProxy:updateColdTime()
	self.coldTime = pg.TimeMgr.GetInstance():GetServerTime() + 0

	return
end

function TechnologyProxy:updateRefreshFlag(arg_16_1)
	self.refreshTechnologysFlag = arg_16_1

	self:sendNotification(TechnologyProxy.REFRESH_UPDATED, self.refreshTechnologysFlag)

	return
end

function TechnologyProxy:updateTechnologys(arg_17_1)
	self.data = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		self.tendency[iter_17_1.id] = iter_17_1.target

		for iter_17_2, iter_17_3 in ipairs(iter_17_1.technologys) do
			self.data[iter_17_3.id] = Technology.New({
				id = iter_17_3.id,
				time = iter_17_3.time,
				pool_id = iter_17_1.id
			})
		end
	end

	return
end

function TechnologyProxy:updateTecCatchup(arg_18_1)
	self.curCatchupTecID = arg_18_1.version
	self.curCatchupGroupID = arg_18_1.target
	self.catchupData = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1.pursuings) do
		local var_18_0 = TechnologyCatchup.New(iter_18_1)

		self.catchupData[var_18_0.id] = var_18_0
	end

	self.curCatchupPrintsNum = self:getCurCatchNum()

	print("初始下发的科研追赶信息", self.curCatchupTecID, self.curCatchupGroupID, self.curCatchupPrintsNum)

	return
end

function TechnologyProxy:updateTechnologyQueue(arg_19_1)
	self.queue = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		table.insert(self.queue, Technology.New({
			queue = true,
			id = iter_19_1.id,
			time = iter_19_1.time
		}))
	end

	table.sort(self.queue, function(arg_20_0, arg_20_1)
		return arg_20_0.time < arg_20_1.time
	end)

	return
end

function TechnologyProxy:moveTechnologyToQueue(arg_21_1)
	self.data[arg_21_1].inQueue = true

	table.insert(self.queue, self.data[arg_21_1])

	self.data[arg_21_1] = nil

	return
end

function TechnologyProxy:removeFirstQueueTechnology()
	assert(#self.queue > 0)
	table.remove(self.queue, 1)

	return
end

function TechnologyProxy:getActivateTechnology()
	for iter_23_0, iter_23_1 in pairs(self.data or {}) do
		if iter_23_1:isActivate() then
			return Clone(iter_23_1)
		end
	end

	return
end

function TechnologyProxy:getTechnologyById(arg_24_1)
	assert(self.data[arg_24_1], "technology should exist>>" .. arg_24_1)

	return self.data[arg_24_1]:clone()
end

function TechnologyProxy:updateTechnology(arg_25_1)
	assert(self.data[arg_25_1.id], "technology should exist>>" .. arg_25_1.id)
	assert(isa(arg_25_1, Technology), "technology should be instance of Technology")

	self.data[arg_25_1.id] = arg_25_1

	self:sendNotification(TechnologyProxy.TECHNOLOGY_UPDATED, arg_25_1:clone())

	return
end

function TechnologyProxy:getTechnologys()
	return underscore.values(self.data)
end

function TechnologyProxy:getPlanningTechnologys()
	return table.mergeArray(self.queue, {
		self:getActivateTechnology()
	})
end

function TechnologyProxy:getBluePrints()
	return Clone(self.bluePrintData)
end

function TechnologyProxy:getBluePrintById(arg_29_1)
	return Clone(self.bluePrintData[arg_29_1])
end

function TechnologyProxy:getRawBluePrintById(arg_30_1)
	return self.bluePrintData[arg_30_1]
end

function TechnologyProxy:addBluePrint(arg_31_1)
	assert(isa(arg_31_1, ShipBluePrint), "bluePrint should be instance of ShipBluePrint")
	assert(self.bluePrintData[arg_31_1.id] == nil, "use function updateBluePrint instead")

	self.bluePrintData[arg_31_1.id] = arg_31_1

	self:sendNotification(TechnologyProxy.BLUEPRINT_ADDED, arg_31_1:clone())

	return
end

function TechnologyProxy:updateBluePrint(arg_32_1)
	assert(isa(arg_32_1, ShipBluePrint), "bluePrint should be instance of ShipBluePrint")
	assert(self.bluePrintData[arg_32_1.id], "use function addBluePrint instead")

	self.bluePrintData[arg_32_1.id] = arg_32_1

	self:sendNotification(TechnologyProxy.BLUEPRINT_UPDATED, arg_32_1:clone())

	return
end

function TechnologyProxy:getBuildingBluePrint()
	for iter_33_0, iter_33_1 in pairs(self.bluePrintData) do
		if iter_33_1:isDeving() or iter_33_1:isFinished() then
			return iter_33_1
		end
	end

	return
end

function TechnologyProxy:getAllBluePrintShipIds()
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs(self.bluePrintData) do
		if iter_34_1:isFetched() then
			table.insert(var_34_0, iter_34_1.shipId)
		end
	end

	return var_34_0
end

function TechnologyProxy:GetBlueprint4Item(arg_35_1)
	return self.item2blueprint[arg_35_1]
end

function TechnologyProxy:updatePhantomQuestProgress(arg_36_1, arg_36_2)
	for iter_36_0, iter_36_1 in pairs(self.bluePrintData) do
		if iter_36_1:isFetched() and arg_36_2[iter_36_1.shipId] then
			iter_36_1:setPhantomQuestProgress(arg_36_1, arg_36_2[iter_36_1.shipId])
		end
	end

	return
end

function TechnologyProxy:getCatchupData(arg_37_1)
	self.catchupData[arg_37_1] = self.catchupData[arg_37_1] or TechnologyCatchup.New({
		version = arg_37_1
	})

	return self.catchupData[arg_37_1]
end

function TechnologyProxy:updateCatchupData(arg_38_1, arg_38_2, arg_38_3)
	self.catchupData[arg_38_1]:addTargetNum(arg_38_2, arg_38_3)

	return
end

function TechnologyProxy:getCurCatchNum()
	if self.curCatchupTecID ~= 0 and self.curCatchupGroupID ~= 0 then
		return self.catchupData[self.curCatchupTecID]:getTargetNum(self.curCatchupGroupID)
	else
		return 0
	end

	return
end

function TechnologyProxy:getCatchupState(arg_40_1)
	if not self.catchupData[arg_40_1] then
		return TechnologyCatchup.STATE_UNSELECT
	end

	return self.catchupData[arg_40_1]:getState()
end

function TechnologyProxy:updateCatchupStates()
	for iter_41_0, iter_41_1 in pairs(self.catchupData) do
		iter_41_1:updateState()
	end

	return
end

function TechnologyProxy:isOpenTargetCatchup()
	return pg.technology_catchup_template ~= nil and #pg.technology_catchup_template.all > 0
end

function TechnologyProxy:getNewestCatchupTecID()
	return math.max(unpack(pg.technology_catchup_template.all))
end

function TechnologyProxy:isOnCatchup()
	return self.curCatchupTecID ~= 0 and self.curCatchupGroupID ~= 0
end

function TechnologyProxy:getBluePrintVOByGroupID(arg_45_1)
	return self.bluePrintData[arg_45_1]
end

function TechnologyProxy:getCurCatchupTecInfo()
	return {
		tecID = self.curCatchupTecID,
		groupID = self.curCatchupGroupID,
		printNum = self.curCatchupPrintsNum
	}
end

function TechnologyProxy:setCurCatchupTecInfo(arg_47_1, arg_47_2)
	self.curCatchupTecID = arg_47_1
	self.curCatchupGroupID = arg_47_2
	self.curCatchupPrintsNum = self:getCurCatchNum()

	self:updateCatchupStates()
	print("设置后的科研追赶信息", self.curCatchupTecID, self.curCatchupGroupID, self.curCatchupPrintsNum)

	return
end

function TechnologyProxy:addCatupPrintsNum(arg_48_1)
	self:updateCatchupData(self.curCatchupTecID, self.curCatchupGroupID, arg_48_1)

	self.curCatchupPrintsNum = self:getCurCatchNum()

	print("增加科研图纸", arg_48_1, self.curCatchupPrintsNum)

	return
end

function TechnologyProxy:IsShowTip()
	local var_49_0, var_49_1 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getData().level, "TechnologyMediator")

	return OPEN_TEC_TREE_SYSTEM and getProxy(TechnologyNationProxy):getShowRedPointTag() or (SelectTechnologyMediator.onBlueprintNotify() or SelectTechnologyMediator.onTechnologyNotify()) and var_49_0
end

function TechnologyProxy:addPursuingTimes(arg_50_1, arg_50_2)
	if arg_50_2 then
		self.pursuingTimesUR = self.pursuingTimesUR + arg_50_1
	else
		self.pursuingTimes = self.pursuingTimes + arg_50_1
	end

	return
end

function TechnologyProxy:resetPursuingTimes()
	self.pursuingTimes = 0
	self.pursuingTimesUR = 0

	self:sendNotification(GAME.PURSUING_RESET_DONE)

	return
end

function TechnologyProxy:getPursuingTimes(arg_52_1)
	if arg_52_1 then
		return self.pursuingTimesUR
	else
		return self.pursuingTimes
	end

	return
end

function TechnologyProxy:calcMaxPursuingCount(arg_53_1)
	local var_53_0 = pg.gameset[arg_53_1:isRarityUR() and "blueprint_pursue_discount_ur" or "blueprint_pursue_discount_ssr"].description
	local var_53_1 = getProxy(PlayerProxy):getRawData():getResource(PlayerConst.ResGold)
	local var_53_2 = 0

	local function var_53_3(arg_54_0)
		local var_54_0 = #var_53_0

		while arg_54_0 < var_53_0[var_54_0][1] do
			var_54_0 = var_54_0 - 1
		end

		return var_53_0[var_54_0][2]
	end

	for iter_53_0 = self:getPursuingTimes(arg_53_1:isRarityUR()) + 1, var_53_0[#var_53_0][1] - 1 do
		local var_53_5 = arg_53_1:getPursuingPrice(var_53_3(iter_53_0))

		if var_53_1 < var_53_5 then
			return var_53_2
		else
			var_53_1 = var_53_1 - var_53_5
			var_53_2 = var_53_2 + 1
		end
	end

	return var_53_2 + math.floor(var_53_1 / arg_53_1:getPursuingPrice())
end

function TechnologyProxy:calcPursuingCost(arg_55_1, arg_55_2)
	local var_55_0 = pg.gameset[arg_55_1:isRarityUR() and "blueprint_pursue_discount_ur" or "blueprint_pursue_discount_ssr"].description
	local var_55_1 = 0

	local function var_55_2(arg_56_0)
		local var_56_0 = #var_55_0

		while arg_56_0 < var_55_0[var_56_0][1] do
			var_56_0 = var_56_0 - 1
		end

		return var_55_0[var_56_0][2]
	end

	for iter_55_0 = self:getPursuingTimes(arg_55_1:isRarityUR()) + 1, var_55_0[#var_55_0][1] - 1 do
		local var_55_4 = arg_55_1:getPursuingPrice(var_55_2(iter_55_0))

		if arg_55_2 == 0 then
			return var_55_1
		else
			var_55_1 = var_55_1 + var_55_4
			arg_55_2 = arg_55_2 - 1
		end
	end

	return var_55_1 + arg_55_2 * arg_55_1:getPursuingPrice()
end

function TechnologyProxy:getPursuingDiscount(arg_57_1)
	local var_57_0 = getGameset(arg_57_1 and "blueprint_pursue_discount_ur" or "blueprint_pursue_discount_ssr")[2]
	local var_57_1 = #var_57_0

	while self < var_57_0[var_57_1][1] do
		var_57_1 = var_57_1 - 1
	end

	return var_57_0[var_57_1][2]
end

function TechnologyProxy:getItemCanUnlockBluePrint(arg_58_1)
	if not self.unlockItemDic then
		self.unlockItemDic = {}

		for iter_58_0, iter_58_1 in ipairs(pg.ship_data_blueprint.all) do
			for iter_58_2, iter_58_3 in ipairs(self.bluePrintData[iter_58_1]:getConfig("gain_item_id")) do
				self.unlockItemDic[iter_58_3] = self.unlockItemDic[iter_58_3] or {}

				table.insert(self.unlockItemDic[iter_58_3], iter_58_1)
			end
		end
	end

	return self.unlockItemDic[arg_58_1]
end

function TechnologyProxy:CheckPursuingCostTip(arg_59_1)
	if TechnologyProxy.getPursuingDiscount(self.pursuingTimes + 1, false) > 0 and TechnologyProxy.getPursuingDiscount(self.pursuingTimesUR + 1, true) > 0 then
		return false
	end

	local var_59_0 = {}

	if arg_59_1 then
		for iter_59_0, iter_59_1 in ipairs(arg_59_1) do
			var_59_0[iter_59_1] = true
		end
	else
		for iter_59_2 = 1, self.maxConfigVersion do
			var_59_0[iter_59_2] = true
		end
	end

	for iter_59_3, iter_59_4 in pairs(self.bluePrintData) do
		if var_59_0[iter_59_4:getConfig("blueprint_version")] and iter_59_4:isPursuingCostTip() then
			return true
		end
	end

	return false
end

return TechnologyProxy
