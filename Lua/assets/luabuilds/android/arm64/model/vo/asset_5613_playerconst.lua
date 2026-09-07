local PlayerConst = class("PlayerConst")

PlayerConst.ResGold = 1
PlayerConst.ResOil = 2
PlayerConst.ResExploit = 3
PlayerConst.ResDiamond = 4
PlayerConst.ResOilField = 5
PlayerConst.ResDormMoney = 6
PlayerConst.ResGoldField = 7
PlayerConst.ResGuildCoin = 8
PlayerConst.ResBlueprintFragment = 9
PlayerConst.ResClassField = 10
PlayerConst.ResFreeDiamond = 14
PlayerConst.ResStoreGold = 16
PlayerConst.ResStoreOil = 17
PlayerConst.ResIslandGold = 18
PlayerConst.ResIslandGem = 19
PlayerConst.ResIslandSpeedUpTicket = 20
PlayerConst.ResBattery = 101
PlayerConst.ResPT = 102

local var_0_1

local function var_0_2(arg_1_0)
	var_0_1 = var_0_1 or {
		[DROP_TYPE_RESOURCE] = function(arg_2_0)
			local var_2_0 = getProxy(PlayerProxy)

			if var_2_0 then
				var_2_0:UpdatePlayerRes({
					arg_2_0
				})
			end

			return
		end,
		[DROP_TYPE_ITEM] = function(arg_3_0)
			local var_3_0 = getProxy(BagProxy)

			if var_3_0 then
				if arg_3_0.count > 0 then
					var_3_0:addItemById(arg_3_0.id, arg_3_0.count)
				elseif arg_3_0.count < 0 then
					var_3_0:removeItemById(arg_3_0.id, -arg_3_0.count)
				end
			end

			return
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_4_0)
			local var_4_0 = nowWorld()

			assert(var_4_0.type == World.TypeFull)

			local var_4_1 = var_4_0:GetInventoryProxy()

			if var_4_1 then
				if arg_4_0.count > 0 then
					var_4_1:AddItem(arg_4_0.id, arg_4_0.count)
				elseif arg_4_0.count < 0 then
					var_4_1:RemoveItem(arg_4_0.id, -arg_4_0.count)
				end
			end

			return
		end
	}

	switch(arg_1_0.type, var_0_1, function(arg_5_0)
		if arg_5_0.type > DROP_TYPE_USE_ACTIVITY_DROP then
			local var_5_0 = getProxy(ActivityProxy):getActivityById(pg.activity_drop_type[arg_5_0.type].activity_id)

			if var_5_0 and not var_5_0:isEnd() then
				if arg_5_0.count > 0 then
					var_5_0:addVitemNumber(arg_5_0.id, arg_5_0.count)
				elseif arg_5_0.count < 0 then
					var_5_0:subVitemNumber(arg_5_0.id, -arg_5_0.count)
				end
			end

			getProxy(ActivityProxy):updateActivity(var_5_0)
		else
			assert(false, string.format("without drop_type_%d owner logic from id_%d", type, arg_5_0.id))
		end

		return
	end, arg_1_0)

	return
end

function addPlayerOwn(arg_6_0)
	arg_6_0.count = math.max(arg_6_0.count, 0)

	var_0_2(arg_6_0)

	return
end

function reducePlayerOwn(arg_7_0)
	arg_7_0.count = -math.max(arg_7_0.count, 0)

	print(arg_7_0.count)
	var_0_2(arg_7_0)

	return
end

function PlayerConst:addTranDrop(arg_8_1)
	self = underscore.map(self, function(arg_9_0)
		return Drop.New({
			type = arg_9_0.type,
			id = arg_9_0.id,
			count = arg_9_0.number
		})
	end)

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs((getProxy(BayProxy):getNewShip(false))) do
		if iter_8_1:isMetaShip() then
			table.insert(var_8_0, iter_8_1.configId)
		end
	end

	for iter_8_2, iter_8_3 in ipairs(self) do
		if iter_8_3.type == DROP_TYPE_SHIP and Ship.isMetaShipByConfigID(iter_8_3.id) and not Player.isMetaShipNeedToTrans(iter_8_3.id) then
			getProxy(MetaCharacterProxy):setMetaIDMark(iter_8_3.id)
		end
	end

	local var_8_1 = {}

	for iter_8_4, iter_8_5 in ipairs(self) do
		local var_8_2, var_8_3 = iter_8_5:DropTrans(var_8_0, arg_8_1)

		if var_8_2 and var_8_2.type ~= DROP_TYPE_TIMESTAMP then
			table.insert(var_8_1, var_8_2)
			pg.m02:sendNotification(GAME.ADD_ITEM, var_8_2)
		end

		if var_8_3 then
			pg.m02:sendNotification(GAME.ADD_ITEM, var_8_3)
		end
	end

	if arg_8_1 and arg_8_1.taskId and pg.task_data_template[arg_8_1.taskId].auto_commit == 1 then
		return {}
	else
		return var_8_1
	end

	return
end

local var_0_3
local var_0_4

function PlayerConst:MergePassItemDrop()
	if not var_0_3 then
		var_0_4 = {
			[DROP_TYPE_SKIN] = 1,
			[DROP_TYPE_SHIP] = 9
		}
		var_0_3 = {}

		for iter_10_0, iter_10_1 in pairs({
			[DROP_TYPE_RESOURCE] = {
				[0] = 8,
				14,
				2,
				[nil] = 8
			},
			[DROP_TYPE_ITEM] = {
				[20001] = 3,
				[21101] = 12,
				[16502] = 6,
				[50006] = 10,
				[16024] = 7,
				[16004] = 7,
				[17023] = 16,
				[17024] = 11,
				[17034] = 11,
				[30015] = 13,
				[42036] = 4,
				[30025] = 13,
				[21131] = 12,
				[30035] = 13,
				[17013] = 16,
				[17003] = 16,
				[20013] = 14,
				[17044] = 11,
				[17004] = 11,
				[15008] = 15,
				[21121] = 12,
				[16014] = 7,
				[42030] = 5,
				[17014] = 11,
				[17033] = 16,
				[21111] = 12,
				[17043] = 16,
				[30045] = 13,
				[15001] = 17,
				[54007] = 5
			}
		}) do
			for iter_10_2, iter_10_3 in pairs(iter_10_1) do
				var_0_3[string.format("%d_%d", iter_10_0, iter_10_2)] = iter_10_3
			end
		end

		PlayerConst.PassItemOrder = setmetatable(var_0_3, {
			__index = function(self, arg_11_1)
				local var_11_0, var_11_1 = unpack(underscore.map(string.split(arg_11_1, "_"), function(arg_12_0)
					return tonumber(arg_12_0)
				end))

				self[arg_11_1] = var_0_4[var_11_0] and var_0_4[var_11_0] or var_11_0 == DROP_TYPE_ITEM and Item.getConfigData(var_11_1).type == 13 and 9 or 100

				return self[arg_11_1]
			end
		})
	end

	local var_10_0 = PlayerConst.MergeSameDrops(self)

	table.sort(var_10_0, CompareFuncs({
		function(arg_13_0)
			return PlayerConst.PassItemOrder[arg_13_0.type .. "_" .. arg_13_0.id]
		end,
		function(arg_14_0)
			return arg_14_0.id
		end
	}))

	return var_10_0
end

function PlayerConst:CheckResForShopping(arg_15_1)
	local var_15_0 = self.count * arg_15_1
	local var_15_1 = 0

	if self.type == DROP_TYPE_RESOURCE then
		var_15_1 = getProxy(PlayerProxy):getRawData():getResource(self.id)
	elseif self.type == DROP_TYPE_ITEM then
		var_15_1 = getProxy(BagProxy):getItemCountById(self.id)
	else
		assert(false)
	end

	return var_15_0 <= var_15_1
end

function PlayerConst:ConsumeResForShopping(arg_16_1)
	if self.type == DROP_TYPE_RESOURCE then
		local var_16_0 = getProxy(PlayerProxy):getData()

		var_16_0:consume({
			[id2res(self.id)] = self.count * arg_16_1
		})
		getProxy(PlayerProxy):updatePlayer(var_16_0)
	elseif self.type == DROP_TYPE_ITEM then
		getProxy(BagProxy):removeItemById(self.id, self.count * arg_16_1)
	else
		assert(false)
	end

	return
end

function PlayerConst:GetTranAwards(arg_17_1)
	local var_17_0 = PlayerConst.addTranDrop(arg_17_1.award_list)

	for iter_17_0, iter_17_1 in ipairs({}) do
		if iter_17_1.type == DROP_TYPE_SHIP then
			if not getProxy(CollectionProxy):getShipGroup(pg.ship_data_template[iter_17_1.id].group_type) and Ship.inUnlockTip(iter_17_1.id) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("collection_award_ship", pg.ship_data_template[iter_17_1.id].name))
			end
		end
	end

	if self.isAwardMerge then
		var_17_0 = PlayerConst.MergeSameDrops(var_17_0)
	end

	return var_17_0
end

function PlayerConst:MergeTechnologyAward()
	for iter_18_0, iter_18_1 in ipairs(self.commons) do
		iter_18_1.riraty = true

		table.insert(self.items, iter_18_1)
	end

	for iter_18_2, iter_18_3 in ipairs(self.catchupItems) do
		iter_18_3.catchupTag = true

		table.insert(self.items, iter_18_3)
	end

	for iter_18_4, iter_18_5 in ipairs(self.catchupActItems) do
		iter_18_5.catchupActTag = true

		table.insert(self.items, iter_18_5)
	end

	return self.items
end

function PlayerConst:CanDropItem()
	local var_19_0 = getProxy(ActivityProxy)
	local var_19_1 = var_19_0:getActivityById(ActivityConst.UTAWARERU_ACTIVITY_PT_ID)

	if var_19_1 and not var_19_1:isEnd() then
		local var_19_2 = var_19_1:getConfig("config_client").pt_id
		local var_19_3 = _.detect(var_19_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_20_0)
			return arg_20_0:getConfig("config_id") == var_19_2
		end):getData1()

		if var_19_3 >= 1500 then
			local var_19_4 = _.detect(self, function(arg_21_0)
				return arg_21_0.type == DROP_TYPE_RESOURCE and arg_21_0.id == var_19_2
			end)

			self = _.filter(self, function(arg_22_0)
				return arg_22_0.type ~= DROP_TYPE_RESOURCE or arg_22_0.id ~= var_19_2
			end)

			if var_19_4 and var_19_3 - 1500 < var_19_4.count then
				var_19_4.count = var_19_4.count - (var_19_3 - 1500)

				table.insert(self, var_19_4)
			end
		end
	end

	return table.getCount(self) > 0
end

local var_0_5

local function var_0_6(arg_23_0)
	var_0_5 = var_0_5 or {
		[DROP_TYPE_SHIP] = true,
		[DROP_TYPE_OPERATION] = true,
		[DROP_TYPE_LOVE_LETTER] = true
	}

	if var_0_5[arg_23_0.type] then
		return true
	elseif arg_23_0.type == DROP_TYPE_ITEM and tobool(arg_23_0.extra) then
		return true
	else
		return false
	end

	return
end

function PlayerConst:MergeSameDrops()
	local var_24_0 = {}
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in ipairs(self) do
		if not var_24_1[iter_24_1.type .. "_" .. iter_24_1.id] then
			if var_0_6(iter_24_1) then
				-- block empty
			else
				var_24_1[iter_24_1.type .. "_" .. iter_24_1.id] = iter_24_1
			end

			table.insert(var_24_0, iter_24_1)
		else
			var_24_1[iter_24_1.type .. "_" .. iter_24_1.id].count = var_24_1[iter_24_1.type .. "_" .. iter_24_1.id].count + iter_24_1.count
		end
	end

	return var_24_0
end

function PlayerConst.CheckMedalAllCollectionTrack()
	local var_25_0, var_25_1 = unpack(getGameset("live_streaming26_data2")[2])
	local var_25_2 = 0
	local var_25_3 = getProxy(PlayerProxy):getRawData()

	for iter_25_0, iter_25_1 in pairs(pg.activity_medal_template.get_id_list_by_group) do
		if iter_25_0 == math.clamp(iter_25_0, var_25_0, var_25_1) then
			if not var_25_3.activityMedalGroupList[iter_25_0] or not var_25_3.activityMedalGroupList[iter_25_0]:GetAll() then
				var_25_2 = -1

				break
			else
				var_25_2 = var_25_2 + 1
			end
		end
	end

	local var_25_4 = getProxy(PlayerProxy):getRawData().id

	if var_25_2 > PlayerPrefs.GetInt("MEDAL_ALL_COLLECTION:" .. var_25_4, 0) then
		PlayerPrefs.SetInt("MEDAL_ALL_COLLECTION:" .. var_25_4, var_25_2)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAllCollection(20001, var_25_2))
	end

	return
end

function PlayerConst:UpdateLinkActivity()
	local var_26_0 = getProxy(ActivityProxy)

	for iter_26_0, iter_26_1 in ipairs((underscore.filter(var_26_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_LINK_COLLECT), function(arg_27_0)
		return not arg_27_0:isEnd()
	end))) do
		assert(pg.activity_limit_item_guide.get_id_list_by_activity[iter_26_1.id], "activity_limit_item_guide not exist activity id: " .. iter_26_1.id)

		for iter_26_2, iter_26_3 in ipairs(pg.activity_limit_item_guide.get_id_list_by_activity[iter_26_1.id]) do
			for iter_26_4, iter_26_5 in ipairs(self) do
				if iter_26_5.type == pg.activity_limit_item_guide[iter_26_3].type and iter_26_5.id == pg.activity_limit_item_guide[iter_26_3].drop_id then
					iter_26_1:updateKVPList(1, pg.activity_limit_item_guide[iter_26_3].id, iter_26_1:getKVPList(1, pg.activity_limit_item_guide[iter_26_3].id) + iter_26_5.count)
				end
			end
		end

		var_26_0:updateActivity(iter_26_1)
	end

	return
end

return PlayerConst
