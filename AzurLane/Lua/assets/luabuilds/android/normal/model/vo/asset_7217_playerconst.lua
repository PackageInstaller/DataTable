class = var_0_10000

local var_0_0 = var_0_10000("PlayerConst")

var_0_0.ResGold = 1
var_0_0.ResOil = 2
var_0_0.ResExploit = 3
var_0_0.ResDiamond = 4
var_0_0.ResOilField = 5
var_0_0.ResDormMoney = 6
var_0_0.ResGoldField = 7
var_0_0.ResGuildCoin = 8
var_0_0.ResBlueprintFragment = 9
var_0_0.ResClassField = 10
var_0_0.ResFreeDiamond = 14
var_0_0.ResStoreGold = 16
var_0_0.ResStoreOil = 17
var_0_0.ResIslandGold = 18
var_0_0.ResIslandGem = 19
var_0_0.ResIslandSpeedUpTicket = 20
var_0_0.ResBattery = 101
var_0_0.ResPT = 102

local var_0_1

local function var_0_2(arg_1_0)
	local var_1_0

	if not var_0_1 then
		var_1_0 = {}
		DROP_TYPE_RESOURCE = var_1_10002
		var_1_0[var_1_10002] = function(arg_2_0)
			getProxy = var_2_10001
			PlayerProxy = var_2_10002

			if var_2_10001(var_2_10002) then
				var_1:UpdatePlayerRes({
					arg_2_0
				})
			end

			return
		end
		DROP_TYPE_ITEM = var_1_10002
		var_1_0[var_1_10002] = function(arg_3_0)
			getProxy = var_2_10001
			BagProxy = var_2_10002

			if var_2_10001(var_2_10002) then
				if arg_3_0.count > 0 then
					var_1:addItemById(arg_3_0.id, arg_3_0.count)
				elseif arg_3_0.count < 0 then
					var_1:removeItemById(arg_3_0.id, -arg_3_0.count)
				end
			end

			return
		end
		DROP_TYPE_WORLD_ITEM = var_1_10002
		var_1_0[var_1_10002] = function(arg_4_0)
			nowWorld = var_2_10001

			local var_4_0 = var_2_10001()

			assert = var_2_10002

			local var_4_1 = var_4_0.type

			World = var_2_10004

			var_2_10002(var_4_1 == var_2_10004.TypeFull)

			if var_4_0:GetInventoryProxy() then
				if arg_4_0.count > 0 then
					var_2:AddItem(arg_4_0.id, arg_4_0.count)
				elseif arg_4_0.count < 0 then
					var_2:RemoveItem(arg_4_0.id, -arg_4_0.count)
				end
			end

			return
		end
	end

	var_0_1 = var_1_0
	switch = var_1_0

	var_1_0(arg_1_0.type, var_0_1, function(arg_5_0)
		local var_5_0 = arg_5_0.type

		DROP_TYPE_USE_ACTIVITY_DROP = var_2_10002

		if var_2_10002 < var_5_0 then
			getProxy = var_5_0
			ActivityProxy = var_2_10002

			local var_5_1 = var_5_0(var_2_10002)

			var_5_0 = var_5_0.getActivityById
			pg = var_2_10003

			if var_5_0(var_5_1, var_2_10003.activity_drop_type[arg_5_0.type].activity_id) then
				var_2_10003 = var_5_0

				if not var_5_0.isEnd(var_2_10003) then
					var_5_1 = arg_5_0.count

					if 0 < var_5_1 then
						var_2_10003 = var_5_0

						var_5_0.addVitemNumber(var_2_10003, arg_5_0.id, arg_5_0.count)
					elseif arg_5_0.count < 0 then
						var_2_10003 = var_5_0

						var_5_0.subVitemNumber(var_2_10003, arg_5_0.id, -arg_5_0.count)
					end
				end
			end

			getProxy = var_5_1
			ActivityProxy = var_2_10003
			var_2_10003 = var_5_1(var_2_10003)

			var_2.updateActivity(var_2_10003, var_5_0)
		else
			assert = var_5_0

			local var_5_2 = false

			string = var_2_10003

			local var_5_3 = var_2_10003.format
			local var_5_4 = "without drop_type_%d owner logic from id_%d"

			type = var_2_10005

			var_5_0(var_5_2, var_5_3(var_5_4, var_2_10005, arg_5_0.id))
		end

		return
	end, arg_1_0)

	return
end

local function var_0_3(arg_6_0)
	math = var_1_10001
	arg_6_0.count = var_1_10001.max(arg_6_0.count, 0)

	var_0_2(arg_6_0)

	return
end

local var_0_4 = addPlayerOwn

local function var_0_5(arg_7_0)
	math = var_1_10001
	arg_7_0.count = -var_1_10001.max(arg_7_0.count, 0)
	print = var_1

	var_1(arg_7_0.count)
	var_0_2(arg_7_0)

	return
end

local var_0_6 = reducePlayerOwn

function var_0_0.addTranDrop(arg_8_0, arg_8_1)
	underscore = var_1_10002
	arg_8_0 = var_1_10002.map(arg_8_0, function(arg_9_0)
		Drop = var_2_10001

		return var_2_10001.New({
			type = arg_9_0.type,
			id = arg_9_0.id,
			count = arg_9_0.number
		})
	end)
	getProxy = var_2
	BayProxy = var_3

	local var_8_0 = var_2(var_3)
	local var_8_1 = var_2.getNewShip(var_8_0, false)
	local var_8_2 = {}

	pairs = var_4

	for iter_8_0, iter_8_1 in var_4(var_8_1) do
		var_1_10010 = iter_8_1

		if iter_8_1.isMetaShip(var_1_10010) then
			table = var_9

			var_9.insert(var_8_2, iter_8_1.configId)
		end
	end

	ipairs = var_4

	for iter_8_2, iter_8_3 in var_4(arg_8_0) do
		local var_8_3 = iter_8_3.type

		DROP_TYPE_SHIP = var_1_10010

		if var_8_3 == var_1_10010 then
			Ship = var_8_3

			if var_8_3.isMetaShipByConfigID(iter_8_3.id) then
				Player = var_9

				if not var_9.isMetaShipNeedToTrans(iter_8_3.id) then
					getProxy = var_9
					MetaCharacterProxy = var_1_10010
					var_1_10010 = var_9(var_1_10010)

					var_9.setMetaIDMark(var_1_10010, iter_8_3.id)
				end
			end
		end
	end

	local var_8_4 = {}

	ipairs = var_5

	for iter_8_4, iter_8_5 in var_5(arg_8_0) do
		local var_8_5, var_8_6 = iter_8_5:DropTrans(var_8_2, arg_8_1)
		local var_8_7

		if var_8_5 then
			var_8_7 = var_8_5.type
			DROP_TYPE_TIMESTAMP = var_13

			if var_8_7 ~= var_13 then
				table = var_8_7

				var_8_7.insert(var_8_4, var_8_5)

				pg = var_8_7

				local var_8_8 = var_8_7.m02

				var_8_7 = var_8_7.sendNotification
				GAME = var_1_10014

				var_8_7(var_8_8, var_1_10014.ADD_ITEM, var_8_5)
			end
		end

		if var_8_6 then
			pg = var_8_7

			local var_8_9 = var_8_7.m02
			local var_8_10 = var_12.sendNotification

			GAME = var_1_10014

			var_8_10(var_8_9, var_1_10014.ADD_ITEM, var_8_6)
		end
	end

	if arg_8_1 and arg_8_1.taskId then
		pg = var_5

		if var_5.task_data_template[arg_8_1.taskId].auto_commit == 1 then
			do return {} end

			goto label_8_0
		end
	end

	do return var_8_4 end

	::label_8_0::

	return
end

local var_0_7
local var_0_8

function var_0_0.MergePassItemDrop(arg_10_0)
	if not var_0_7 then
		local var_10_0 = {}

		DROP_TYPE_SKIN = var_1_10002
		var_10_0[var_1_10002] = 1
		DROP_TYPE_SHIP = var_1_10002
		var_10_0[var_1_10002] = 9
		var_0_8 = var_10_0
		var_0_7 = {}
		pairs = var_1

		local var_10_1 = {}

		DROP_TYPE_RESOURCE = var_3
		var_10_1[var_3] = {
			[0] = 8,
			14,
			2,
			[nil] = 8
		}
		DROP_TYPE_ITEM = var_3
		var_10_1[var_3] = {
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

		for iter_10_0, iter_10_1 in var_1(var_10_1) do
			pairs = var_1_10006

			for iter_10_2, iter_10_3 in var_1_10006(iter_10_1) do
				local var_10_2 = var_0_7

				string = var_1_10012
				var_10_2[var_1_10012.format("%d_%d", iter_10_0, iter_10_2)] = iter_10_3
			end
		end

		local var_10_3 = var_0_0

		setmetatable = var_2
		var_10_3.PassItemOrder = var_2(var_0_7, {
			__index = function(arg_11_0, arg_11_1)
				unpack = var_2_10002
				underscore = var_2_10003

				local var_11_0 = var_2_10003.map

				string = var_2_10004

				local var_11_1, var_11_2 = var_2_10002(var_11_0(var_2_10004.split(arg_11_1, "_"), function(arg_12_0)
					tonumber = var_3_10001

					return var_3_10001(arg_12_0)
				end))

				if var_0_8[var_11_1] then
					arg_11_0[arg_11_1] = var_0_8[var_11_1]
				else
					DROP_TYPE_ITEM = var_4

					if var_11_1 == var_4 then
						Item = var_4

						if var_4.getConfigData(var_11_2).type == 13 then
							arg_11_0[arg_11_1] = 9

							goto label_11_0
						end
					end

					arg_11_0[arg_11_1] = 100
				end

				::label_11_0::

				return arg_11_0[arg_11_1]
			end
		})
	end

	local var_10_4 = var_0_0.MergeSameDrops(arg_10_0)

	table = var_2

	local var_10_5 = var_2.sort
	local var_10_6 = var_10_4

	CompareFuncs = iter_10_0

	var_10_5(var_10_6, iter_10_0({
		function(arg_13_0)
			return var_0_0.PassItemOrder[arg_13_0.type .. "_" .. arg_13_0.id]
		end,
		function(arg_14_0)
			return arg_14_0.id
		end
	}))

	return var_10_4
end

function var_0_0.CheckResForShopping(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.count * arg_15_1
	local var_15_1 = 0
	local var_15_2 = arg_15_0.type

	DROP_TYPE_RESOURCE = var_1_10005

	if var_15_2 == var_1_10005 then
		getProxy = var_15_2
		PlayerProxy = var_1_10005
		var_1_10005 = var_15_2(var_1_10005)

		local var_15_3 = var_4.getRawData(var_1_10005)

		var_15_1 = var_4.getResource(var_15_3, arg_15_0.id)
	else
		local var_15_4 = arg_15_0.type

		DROP_TYPE_ITEM = var_1_10005

		if var_15_4 == var_1_10005 then
			getProxy = var_15_4
			BagProxy = var_1_10005

			local var_15_5 = var_15_4(var_1_10005)

			var_15_1 = var_15_4.getItemCountById(var_15_5, arg_15_0.id)
		else
			assert = var_15_4

			var_15_4(false)
		end
	end

	return var_15_0 <= var_15_1
end

function var_0_0.ConsumeResForShopping(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.count * arg_16_1
	local var_16_1 = arg_16_0.type

	DROP_TYPE_RESOURCE = var_1_10004

	if var_16_1 == var_1_10004 then
		getProxy = var_16_1
		PlayerProxy = var_1_10004
		var_1_10004 = var_16_1(var_1_10004)

		local var_16_2 = var_3.getData(var_1_10004)

		var_1_10004 = var_3.consume

		local var_16_3 = {}

		id2res = var_1_10007
		var_16_3[var_1_10007(arg_16_0.id)] = var_16_0

		var_1_10004(var_16_2, var_16_3)

		getProxy = var_1_10004
		PlayerProxy = var_16_2

		local var_16_4 = var_1_10004(var_16_2)

		var_1_10004.updatePlayer(var_16_4, var_3)
	else
		local var_16_5 = arg_16_0.type

		DROP_TYPE_ITEM = var_1_10004

		if var_16_5 == var_1_10004 then
			getProxy = var_16_5
			BagProxy = var_1_10004

			local var_16_6 = var_16_5(var_1_10004)

			var_16_5.removeItemById(var_16_6, arg_16_0.id, var_16_0)
		else
			assert = var_16_5

			var_16_5(false)
		end
	end

	return
end

function var_0_0.GetTranAwards(arg_17_0, arg_17_1)
	local var_17_0 = {}

	PlayerConst = var_1_10003

	local var_17_1 = var_1_10003.addTranDrop(arg_17_1.award_list)

	ipairs = var_4

	for iter_17_0, iter_17_1 in var_4(var_17_0) do
		local var_17_2 = iter_17_1.type

		DROP_TYPE_SHIP = var_1_10010

		if var_17_2 == var_1_10010 then
			pg = var_17_2

			local var_17_3 = var_17_2.ship_data_template[iter_17_1.id]

			getProxy = var_1_10010
			CollectionProxy = var_1_10011
			var_1_10011 = var_1_10010(var_1_10011)

			if not var_1_10010.getShipGroup(var_1_10011, var_17_3.group_type) then
				Ship = var_1_10011

				if var_1_10011.inUnlockTip(iter_17_1.id) then
					pg = var_1_10011

					local var_17_4 = var_1_10011.TipsMgr.GetInstance()

					var_1_10011 = var_1_10011.ShowTips
					i18n = var_1_10013

					var_1_10011(var_17_4, var_1_10013("collection_award_ship", var_17_3.name))
				end
			end
		end
	end

	if arg_17_0.isAwardMerge then
		var_17_1 = var_0_0.MergeSameDrops(var_17_1)
	end

	return var_17_1
end

function var_0_0.MergeTechnologyAward(arg_18_0)
	local var_18_0 = arg_18_0.items

	ipairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0.commons) do
		iter_18_1.riraty = true
		table = var_7

		var_7.insert(var_18_0, iter_18_1)
	end

	ipairs = var_2

	for iter_18_2, iter_18_3 in var_2(arg_18_0.catchupItems) do
		iter_18_3.catchupTag = true
		table = var_7

		var_7.insert(var_18_0, iter_18_3)
	end

	ipairs = var_2

	for iter_18_4, iter_18_5 in var_2(arg_18_0.catchupActItems) do
		iter_18_5.catchupActTag = true
		table = var_7

		var_7.insert(var_18_0, iter_18_5)
	end

	return var_18_0
end

function var_0_0.CanDropItem(arg_19_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_19_0 = var_1_10001(var_1_10002)
	local var_19_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	if var_19_1(var_19_0, var_1_10004.UTAWARERU_ACTIVITY_PT_ID) and not var_2:isEnd() then
		local var_19_2 = var_2

		var_19_0 = var_2.getConfig(var_19_2, "config_client").pt_id
		_ = var_19_2

		local var_19_3 = var_19_2.detect
		local var_19_4 = var_1
		local var_19_5 = var_1.getActivitiesByType

		ActivityConst = var_1_10007

		local var_19_6 = var_19_3(var_19_5(var_19_4, var_1_10007.ACTIVITY_TYPE_PT_RANK), function(arg_20_0)
			return arg_20_0:getConfig("config_id") == var_19_0
		end)
		local var_19_7 = var_4.getData1(var_19_6)

		if 1500 <= var_19_7 then
			local var_19_8 = var_19_7 - 1500

			_ = var_5

			local var_19_9 = var_5.detect(arg_19_0, function(arg_21_0)
				local var_21_0 = arg_21_0.type

				DROP_TYPE_RESOURCE = var_2_10002

				return var_21_0 == var_2_10002 and arg_21_0.id == var_19_0
			end)

			_ = var_6
			arg_19_0 = var_6.filter(arg_19_0, function(arg_22_0)
				local var_22_0 = arg_22_0.type

				DROP_TYPE_RESOURCE = var_2_10002

				return var_22_0 ~= var_2_10002 or arg_22_0.id ~= var_19_0
			end)

			if var_19_9 and var_19_8 < var_19_9.count then
				var_19_9.count = var_19_9.count - var_19_8
				table = var_6

				var_6.insert(arg_19_0, var_19_9)
			end
		end
	end

	table = var_19_0

	return var_19_0.getCount(arg_19_0) > 0
end

local var_0_9

local function var_0_10(arg_23_0)
	local var_23_0

	if not var_0_9 then
		var_23_0 = {}
		DROP_TYPE_SHIP = var_1_10002
		var_23_0[var_1_10002] = true
		DROP_TYPE_OPERATION = var_1_10002
		var_23_0[var_1_10002] = true
		DROP_TYPE_LOVE_LETTER = var_1_10002
		var_23_0[var_1_10002] = true
	end

	var_0_9 = var_23_0

	if var_0_9[arg_23_0.type] then
		return true
	else
		local var_23_1 = arg_23_0.type

		DROP_TYPE_ITEM = var_2

		if var_23_1 == var_2 then
			tobool = var_23_1

			if var_23_1(arg_23_0.extra) then
				do return true end

				goto label_23_0
			end
		end

		return false
	end

	::label_23_0::

	return
end

function var_0_0.MergeSameDrops(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = {}

	ipairs = var_1_10003

	for iter_24_0, iter_24_1 in var_1_10003(arg_24_0) do
		if not var_24_1[iter_24_1.type .. "_" .. iter_24_1.id] then
			if var_0_10(iter_24_1) then
				-- block empty
			else
				var_24_1[var_8] = iter_24_1
			end

			table = var_9

			var_9.insert(var_24_0, iter_24_1)
		else
			var_24_1[var_8].count = var_24_1[var_8].count + iter_24_1.count
		end
	end

	return var_24_0
end

function var_0_0.CheckMedalAllCollectionTrack()
	unpack = var_1_10000
	getGameset = var_1_10001

	local var_25_0, var_25_1 = var_1_10000(var_1_10001("live_streaming26_data2")[2])
	local var_25_2 = 0

	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_25_3 = var_1_10003(var_1_10004)
	local var_25_4 = var_3.getRawData(var_25_3)

	pairs = var_25_3
	pg = var_1_10005

	for iter_25_0, iter_25_1 in var_25_3(var_1_10005.activity_medal_template.get_id_list_by_group) do
		math = var_1_10009

		if iter_25_0 == var_1_10009.clamp(iter_25_0, var_25_0, var_25_1) then
			if var_25_4.activityMedalGroupList[iter_25_0] then
				local var_25_5 = var_25_4.activityMedalGroupList[iter_25_0]

				if not var_1_10009.GetAll(var_25_5) then
					var_25_2 = -1

					break
				else
					var_25_2 = var_25_2 + 1
				end
			end
		end
	end

	getProxy = var_4
	PlayerProxy = var_5

	local var_25_6 = var_4(var_5)
	local var_25_7 = var_4.getRawData(var_25_6).id

	PlayerPrefs = var_25_6

	if var_25_6.GetInt("MEDAL_ALL_COLLECTION:" .. var_25_7, 0) < var_25_2 then
		PlayerPrefs = var_5

		var_5.SetInt("MEDAL_ALL_COLLECTION:" .. var_25_7, var_25_2)

		pg = var_5

		local var_25_8 = var_5.GameTrackerMgr.GetInstance()
		local var_25_9 = var_5.Record

		GameTrackerBuilder = var_7

		var_25_9(var_25_8, var_7.BuildAllCollection(20001, var_25_2))
	end

	return
end

function var_0_0.UpdateLinkActivity(arg_26_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_26_0 = var_1_10001(var_1_10002)

	underscore = var_1_10002

	local var_26_1 = var_1_10002.filter
	local var_26_2 = var_26_0
	local var_26_3 = var_26_0.getActivitiesByType

	ActivityConst = var_1_10005

	local var_26_4 = var_26_1(var_26_3(var_26_2, var_1_10005.ACTIVITY_TYPE_LINK_COLLECT), function(arg_27_0)
		return not arg_27_0:isEnd()
	end)

	ipairs = var_3

	for iter_26_0, iter_26_1 in var_3(var_26_4) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.activity_limit_item_guide.get_id_list_by_activity[iter_26_1.id]
		assert = var_9

		var_9(var_1_10008, "activity_limit_item_guide not exist activity id: " .. iter_26_1.id)

		ipairs = var_9

		for iter_26_2, iter_26_3 in var_9(var_1_10008) do
			pg = var_1_10014
			var_1_10014 = var_1_10014.activity_limit_item_guide[iter_26_3]
			ipairs = var_1_10015

			for iter_26_4, iter_26_5 in var_1_10015(arg_26_0) do
				if iter_26_5.type == var_1_10014.type and iter_26_5.id == var_1_10014.drop_id then
					local var_26_5 = iter_26_1:getKVPList(1, var_1_10014.id) + iter_26_5.count

					iter_26_1:updateKVPList(1, var_1_10014.id, var_26_5)
				end
			end
		end

		var_26_0:updateActivity(iter_26_1)
	end

	return
end

return var_0_0
