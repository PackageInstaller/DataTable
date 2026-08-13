class = var_0_10000

local var_0_0 = var_0_10000("BuffHelper")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}

function var_0_0.GenBuffsForActivity(arg_1_0)
	if arg_1_0 and not arg_1_0:isEnd() and var_0_2[arg_1_0.id] == arg_1_0 then
		underscore = var_1

		return var_1.map(var_0_3[arg_1_0.id], function(arg_2_0)
			return var_0_1[arg_2_0]
		end)
	end

	if var_0_3[arg_1_0.id] then
		underscore = var_1

		var_1.each(var_0_3[arg_1_0.id], function(arg_3_0)
			if var_0_1[arg_3_0] then
				local var_3_0 = var_0_4
				local var_3_1 = var_0_1[arg_3_0]

				var_3_0[var_2.getConfig(var_3_1, "benefit_type")][arg_3_0] = nil
			end

			var_0_1[arg_3_0] = nil

			return
		end)
	end

	var_0_2[arg_1_0.id] = nil
	var_0_3[arg_1_0.id] = nil

	if not arg_1_0 or arg_1_0:isEnd() then
		return {}
	end

	local var_1_0

	if not arg_1_0:GetBuffList() then
		var_1_0 = {}
	end

	switch = var_2

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.getConfig(var_1_1, "type")
	local var_1_3 = {}

	ActivityConst = var_1_1
	var_1_3[var_1_1.ACTIVITY_TYPE_BUFF] = function()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.getConfig(var_4_0, "config_id")
		local var_4_2 = {}

		if var_4_1 == 0 then
			local var_4_3 = arg_1_0

			var_4_2 = var_4_0.getConfig(var_4_3, "config_data")
		else
			table = var_4_0

			var_4_0.insert(var_4_2, var_4_1)
		end

		ipairs = var_4_0

		for iter_4_0, iter_4_1 in var_4_0(var_4_2) do
			ActivityBuff = var_2_10007
			var_2_10007 = var_2_10007.New(arg_1_0.id, iter_4_1)
			table = var_2_10008

			var_2_10008.insert(var_1_0, var_2_10007)
		end

		return
	end
	ActivityConst = var_6
	var_1_3[var_6.ACTIVITY_TYPE_BUILDING_BUFF] = function()
		local var_5_0 = arg_1_0
		local var_5_1 = var_0.GetBuildingIds(var_5_0)

		pairs = var_2_10001

		for iter_5_0, iter_5_1 in var_2_10001(var_5_1) do
			pg = var_2_10006

			if var_2_10006.activity_event_building[iter_5_1] then
				_ = var_2_10007

				var_2_10007.each(var_2_10006.buff, function(arg_6_0)
					table = var_3_10001

					local var_6_0 = var_3_10001.insert
					local var_6_1 = var_1_0

					ActivityBuff = var_3_10004

					var_6_0(var_6_1, var_3_10004.New(arg_1_0.id, arg_6_0))

					return
				end)
			end
		end

		return
	end
	ActivityConst = var_6
	var_1_3[var_6.ACTIVITY_TYPE_BUILDING_BUFF_2] = function()
		local var_7_0 = arg_1_0
		local var_7_1 = var_0.GetBuildingIds(var_7_0)

		pairs = var_2_10001

		for iter_7_0, iter_7_1 in var_2_10001(var_7_1) do
			pg = var_2_10006

			if var_2_10006.activity_event_building[iter_7_1] then
				_ = var_2_10007

				var_2_10007.each(var_2_10006.buff, function(arg_8_0)
					table = var_3_10001

					local var_8_0 = var_3_10001.insert
					local var_8_1 = var_1_0

					ActivityBuff = var_3_10004

					var_8_0(var_8_1, var_3_10004.New(arg_1_0.id, arg_8_0))

					return
				end)
			end
		end

		local var_7_2 = arg_1_0
		local var_7_3 = var_1.GetSceneBuildingId(var_7_2)

		if 0 < var_7_3 then
			pg = var_2

			if var_2.activity_event_building[var_7_3] then
				_ = var_7_2

				var_7_2.each(var_2.buff, function(arg_9_0)
					table = var_3_10001

					local var_9_0 = var_3_10001.insert
					local var_9_1 = var_1_0

					ActivityBuff = var_3_10004

					var_9_0(var_9_1, var_3_10004.New(arg_1_0.id, arg_9_0))

					return
				end)
			end
		end

		return
	end
	ActivityConst = var_6
	var_1_3[var_6.ACTIVITY_TYPE_PT_BUFF] = function()
		local var_10_0 = arg_1_0.data3_list

		pairs = var_2_10001

		for iter_10_0, iter_10_1 in var_2_10001(var_10_0) do
			table = var_2_10006
			var_2_10006 = var_2_10006.insert

			local var_10_1 = var_1_0

			ActivityBuff = var_2_10009

			var_2_10006(var_10_1, var_2_10009.New(arg_1_0.id, iter_10_1))
		end

		return
	end
	ActivityConst = var_6
	var_1_3[var_6.ACTIVITY_TYPE_ATELIER_LINK] = function()
		local var_11_0 = arg_1_0
		local var_11_1 = var_0.GetSlots(var_11_0)

		ipairs = var_2_10001

		for iter_11_0, iter_11_1 in var_2_10001(var_11_1) do
			local var_11_2 = iter_11_1[1]
			local var_11_3 = iter_11_1[2]

			if var_11_2 > 0 and 0 < var_11_3 then
				table = var_8

				local var_11_4 = var_8.insert
				local var_11_5 = var_1_0

				ActivityBuff = var_2_10011
				var_2_10011 = var_2_10011.New

				local var_11_6 = arg_1_0.id

				AtelierMaterial = var_2_10014

				local var_11_7 = var_2_10014.New({
					configId = var_11_2
				})

				var_11_4(var_11_5, var_2_10011(var_11_6, var_2_10014.GetBuffs(var_11_7)[var_11_3]))
			end
		end

		return
	end

	var_2(var_1_2, var_1_3)

	var_0_2[arg_1_0.id] = arg_1_0

	local var_1_4 = var_0_3
	local var_1_5 = arg_1_0.id

	underscore = var_1_2
	var_1_4[var_1_5] = var_1_2.map(var_1_0, function(arg_12_0)
		var_0_1[arg_12_0.id] = arg_12_0

		local var_12_0 = arg_12_0:getConfig("benefit_type")
		local var_12_1 = var_0_4
		local var_12_2

		if not var_0_4[var_12_0] then
			var_12_2 = {}
		end

		var_12_1[var_12_0] = var_12_2
		var_0_4[var_12_0][arg_12_0.id] = true

		return arg_12_0.id
	end)

	return var_1_0
end

function var_0_0.ClearAllCache()
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}

	return
end

function var_0_0.GetBenefitTypeBuffs(arg_14_0)
	local var_14_0 = {}

	ipairs = var_1_10002
	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_14_1 = var_1_10004(var_1_10006)
	local var_14_2 = var_4.getRawData(var_14_1)

	for iter_14_0, iter_14_1 in var_1_10002(var_4.GetBuffs(var_14_2)) do
		CommonBuff = var_1_10007

		local var_14_3 = var_1_10007.New(iter_14_1)

		if var_1_10007.getConfig(var_14_3, "benefit_type") == arg_14_0 then
			table = var_8

			var_8.insert(var_14_0, var_1_10007)
		end
	end

	pairs = var_2

	local var_14_4

	if not var_0_4[arg_14_0] then
		var_14_4 = {}
	end

	for iter_14_2, iter_14_3 in var_2(var_14_4) do
		if iter_14_3 then
			tobool = var_1_10007

			if var_1_10007(var_0_1[iter_14_2]) then
				table = var_1_10007

				var_1_10007.insert(var_14_0, var_0_1[iter_14_2])
			end
		end
	end

	underscore = var_2

	return var_2.filter(var_14_0, function(arg_15_0)
		return arg_15_0:isActivate()
	end)
end

function var_0_0.GetAllBuff()
	underscore = var_1_10000

	local var_16_0 = var_1_10000.map

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_16_1 = var_1_10002(var_1_10004)
	local var_16_2 = var_2.getRawData(var_16_1)
	local var_16_3 = var_16_0(var_2.GetBuffs(var_16_2), function(arg_17_0)
		CommonBuff = var_2_10001

		return var_2_10001.New(arg_17_0)
	end)

	getProxy = var_1_10001
	ActivityProxy = var_3

	local var_16_4 = var_1_10001(var_3)
	local var_16_5 = var_1.getRawData(var_16_4)

	pairs = var_2

	for iter_16_0, iter_16_1 in var_2(var_16_5) do
		table = var_1_10007

		var_1_10007.insertto(var_16_3, var_0_0.GenBuffsForActivity(iter_16_1))
	end

	underscore = var_2

	return var_2.filter(var_16_3, function(arg_18_0)
		return arg_18_0:isActivate()
	end)
end

function var_0_0.GetBackYardExpBuffs()
	underscore = var_1_10000

	local var_19_0 = var_1_10000.filter
	local var_19_1 = var_0_0.GetBenefitTypeBuffs

	BuffUsageConst = var_1_10004

	return var_19_0(var_19_1(var_1_10004.DORM_EXP), function(arg_20_0)
		return arg_20_0:isActivate()
	end)
end

function var_0_0.GetBackYardEnergyBuffs()
	underscore = var_1_10000

	local var_21_0 = var_1_10000.filter
	local var_21_1 = var_0_0.GetBenefitTypeBuffs

	BuffUsageConst = var_1_10004

	return var_21_0(var_21_1(var_1_10004.DORM_ENERGY), function(arg_22_0)
		return arg_22_0:isActivate()
	end)
end

function var_0_0.GetShipModExpBuff()
	underscore = var_1_10000

	local var_23_0 = var_1_10000.filter
	local var_23_1 = var_0_0.GetBenefitTypeBuffs

	BuffUsageConst = var_1_10004

	return var_23_0(var_23_1(var_1_10004.SHIP_MOD_EXP), function(arg_24_0)
		return arg_24_0:isActivate()
	end)
end

function var_0_0.GetBackYardPlayerBuffs()
	local var_25_0 = {}

	ipairs = var_1_10001
	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_25_1 = var_1_10003(var_1_10005)
	local var_25_2 = var_3.getRawData(var_25_1)

	for iter_25_0, iter_25_1 in var_1_10001(var_3.GetBuffs(var_25_2)) do
		CommonBuff = var_1_10006

		local var_25_3 = var_1_10006.New(iter_25_1)
		local var_25_4 = var_1_10006.getConfig(var_25_3, "benefit_type")

		BuffUsageConst = var_8

		if var_25_4 == var_8.DORM_EXP then
			table = var_25_4

			var_25_4.insert(var_25_0, var_1_10006)
		end
	end

	underscore = var_1

	return var_1.filter(var_25_0, function(arg_26_0)
		return arg_26_0:isActivate()
	end)
end

function var_0_0.GetBattleBuffs(arg_27_0)
	underscore = var_1_10001

	local var_27_0 = var_1_10001.filter
	local var_27_1 = var_0_0.GetBenefitTypeBuffs

	BuffUsageConst = var_1_10005

	return var_27_0(var_27_1(var_1_10005.BATTLE), function(arg_28_0)
		return arg_28_0:isActivate()
	end)
end

function var_0_0.GetBuffsByActivityType(arg_29_0)
	local var_29_0 = {}

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_29_1 = var_1_10002(var_1_10004)
	local var_29_2 = var_2.getActivitiesByType(var_29_1, arg_29_0)

	_ = var_1_10003

	var_1_10003.each(var_29_2, function(arg_30_0)
		table = var_2_10001

		var_2_10001.insertto(var_29_0, var_0_0.GenBuffsForActivity(arg_30_0))

		return
	end)

	underscore = var_3

	return var_3.filter(var_29_0, function(arg_31_0)
		return arg_31_0:isActivate()
	end)
end

function var_0_0.GetBuffsForMainUI()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_32_0 = var_1_10000(var_1_10002)
	local var_32_1 = var_0_0.GetBuffsByActivityType

	ActivityConst = var_1_10003

	for iter_32_0 = #var_32_1(var_1_10003.ACTIVITY_TYPE_BUFF), 1, -1 do
		local var_32_2 = var_1[iter_32_0]

		if not var_1_10006.checkShow(var_32_2) then
			table = var_1_10006

			var_1_10006.remove(var_1, iter_32_0)
		end
	end

	local var_32_3 = var_32_0
	local var_32_4 = var_32_0.getActivityByType

	ActivityConst = iter_32_0

	local var_32_5, var_32_6

	if var_32_4(var_32_3, iter_32_0.ACTIVITY_TYPE_MINIGAME) then
		var_32_5 = var_2

		if not var_2.isEnd(var_32_5) then
			var_32_5 = var_2
			var_32_6 = var_2.getConfig(var_32_5, "config_client").bufflist
			getProxy = var_32_3
			PlayerProxy = var_1_10006
			var_1_10006 = var_32_3(var_1_10006)
			var_32_3 = var_32_3.getRawData(var_1_10006)
			pairs = var_32_5

			for iter_32_1, iter_32_2 in var_32_5(var_32_3.buff_list) do
				pg = var_1_10010
				var_1_10012 = var_1_10010.TimeMgr.GetInstance()

				if var_1_10010.GetServerTime(var_1_10012) < iter_32_2.timestamp then
					table = var_1_10012

					if var_1_10012.contains(var_32_6, iter_32_2.id) then
						ActivityBuff = var_1_10012

						local var_32_7 = var_1_10012.New(var_2.id, iter_32_2.id, iter_32_2.timestamp)

						if var_1_10012.checkShow(var_32_7) then
							table = var_1_10013

							var_1_10013.insert(var_1, var_1_10012)
						end
					end
				end
			end
		end
	end

	getProxy = var_32_6
	MiniGameProxy = var_32_5

	local var_32_8 = var_32_6(var_32_5)
	local var_32_9 = var_3.GetMiniGameDataByType

	MiniGameConst = var_1_10006

	local var_32_10

	if var_32_9(var_32_8, var_1_10006.MG_TYPE_3) then
		getProxy = var_32_3
		PlayerProxy = var_32_10
		var_32_10 = var_32_3(var_32_10)
		var_32_3 = var_32_3.getRawData(var_32_10)
		var_1_10007 = var_3
		var_32_8 = var_3.getConfig(var_1_10007, "config_data")[2]
		var_32_10 = nil
		ipairs = var_1_10007

		for iter_32_3, iter_32_4 in var_1_10007(var_32_3.buff_list) do
			table = var_1_10012

			if var_1_10012.indexof(var_32_8, iter_32_4.id, 1) then
				pg = var_1_10012

				local var_32_11 = var_1_10012.TimeMgr.GetInstance()

				if var_1_10012.GetServerTime(var_32_11) < iter_32_4.timestamp then
					local var_32_12 = var_32_0
					local var_32_13 = var_32_0.getActivityByType

					ActivityConst = var_1_10017

					local var_32_14 = var_32_13(var_32_12, var_1_10017.ACTIVITY_TYPE_MINIGAME)

					ActivityBuff = var_15
					var_1_10018 = var_15.New(var_32_14.id, iter_32_4.id, iter_32_4.timestamp)

					if var_15.checkShow(var_1_10018) then
						table = var_16

						var_16.insert(var_1, var_15)
					end
				end

				break
			end
		end
	end

	getProxy = var_32_3
	MiniGameProxy = var_32_10

	local var_32_15 = var_32_3(var_32_10)
	local var_32_16 = var_4.GetMiniGameDataByType

	MiniGameConst = var_1_10007

	if var_32_16(var_32_15, var_1_10007.MG_TYPE_5) then
		getProxy = var_32_8
		PlayerProxy = var_7

		local var_32_17 = var_32_8(var_7)
		local var_32_18 = var_5.getRawData(var_32_17)
		local var_32_19 = var_4
		local var_32_20 = var_4.getConfig(var_32_19, "config_data")[2]
		local var_32_21

		ipairs = var_32_19

		for iter_32_5, iter_32_6 in var_32_19(var_32_18.buff_list) do
			table = var_1_10013

			if var_1_10013.indexof(var_32_20, iter_32_6.id, 1) then
				pg = var_1_10013

				local var_32_22 = var_1_10013.TimeMgr.GetInstance()

				if var_1_10013.GetServerTime(var_32_22) < iter_32_6.timestamp then
					local var_32_23 = var_32_0
					local var_32_24 = var_32_0.getActivityByType

					ActivityConst = var_1_10018

					local var_32_25 = var_32_24(var_32_23, var_1_10018.ACTIVITY_TYPE_MINIGAME)

					ActivityBuff = var_16

					local var_32_26 = var_16.New(var_32_25.id, iter_32_6.id, iter_32_6.timestamp)

					if var_16.checkShow(var_32_26) then
						table = var_17

						var_17.insert(var_1, var_16)
					end
				end

				break
			end
		end
	end

	return var_1
end

return var_0_0
