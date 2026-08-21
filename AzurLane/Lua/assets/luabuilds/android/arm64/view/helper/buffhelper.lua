local var_0_0 = class("BuffHelper")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}

function var_0_0.GenBuffsForActivity(arg_1_0)
	if arg_1_0 and not arg_1_0:isEnd() and var_0_2[arg_1_0.id] == arg_1_0 then
		return underscore.map(var_0_3[arg_1_0.id], function(arg_2_0)
			return var_0_1[arg_2_0]
		end)
	end

	if var_0_3[arg_1_0.id] then
		underscore.each(var_0_3[arg_1_0.id], function(arg_3_0)
			if var_0_1[arg_3_0] then
				var_0_4[var_0_1[arg_3_0]:getConfig("benefit_type")][arg_3_0] = nil
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

	local var_1_0 = arg_1_0:GetBuffList() or {}

	switch(arg_1_0:getConfig("type"), {
		[ActivityConst.ACTIVITY_TYPE_BUFF] = function()
			local var_4_0 = arg_1_0:getConfig("config_id")
			local var_4_1 = {}

			if var_4_0 == 0 then
				var_4_1 = arg_1_0:getConfig("config_data")
			else
				table.insert(var_4_1, var_4_0)
			end

			for iter_4_0, iter_4_1 in ipairs(var_4_1) do
				table.insert(var_1_0, (ActivityBuff.New(arg_1_0.id, iter_4_1)))
			end

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF] = function()
			for iter_5_0, iter_5_1 in pairs((arg_1_0:GetBuildingIds())) do
				if pg.activity_event_building[iter_5_1] then
					_.each(pg.activity_event_building[iter_5_1].buff, function(arg_6_0)
						table.insert(var_1_0, ActivityBuff.New(arg_1_0.id, arg_6_0))

						return
					end)
				end
			end

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2] = function()
			for iter_7_0, iter_7_1 in pairs((arg_1_0:GetBuildingIds())) do
				if pg.activity_event_building[iter_7_1] then
					_.each(pg.activity_event_building[iter_7_1].buff, function(arg_8_0)
						table.insert(var_1_0, ActivityBuff.New(arg_1_0.id, arg_8_0))

						return
					end)
				end
			end

			local var_7_0 = arg_1_0:GetSceneBuildingId()

			if var_7_0 > 0 then
				if pg.activity_event_building[var_7_0] then
					_.each(pg.activity_event_building[var_7_0].buff, function(arg_9_0)
						table.insert(var_1_0, ActivityBuff.New(arg_1_0.id, arg_9_0))

						return
					end)
				end
			end

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_PT_BUFF] = function()
			for iter_10_0, iter_10_1 in pairs(arg_1_0.data3_list) do
				table.insert(var_1_0, ActivityBuff.New(arg_1_0.id, iter_10_1))
			end

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_ATELIER_LINK] = function()
			for iter_11_0, iter_11_1 in ipairs((arg_1_0:GetSlots())) do
				if iter_11_1[1] > 0 and iter_11_1[2] > 0 then
					local var_11_0 = AtelierMaterial.New({
						configId = iter_11_1[1]
					})

					table.insert(var_1_0, ActivityBuff.New(arg_1_0.id, var_11_0:GetBuffs()[iter_11_1[2]]))
				end
			end

			return
		end
	})

	var_0_2[arg_1_0.id] = arg_1_0
	var_0_3[arg_1_0.id] = underscore.map(var_1_0, function(arg_12_0)
		var_0_1[arg_12_0.id] = arg_12_0

		local var_12_0 = arg_12_0:getConfig("benefit_type")

		var_0_4[var_12_0] = var_0_4[var_12_0] or {}
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
	for iter_14_0, iter_14_1 in ipairs(getProxy(PlayerProxy):getRawData():GetBuffs()) do
		local var_14_0 = CommonBuff.New(iter_14_1)

		if var_14_0:getConfig("benefit_type") == arg_14_0 then
			table.insert({}, var_14_0)
		end
	end

	local var_14_1 = var_0_4[arg_14_0] or {}

	for iter_14_2, iter_14_3 in pairs(var_14_1) do
		if iter_14_3 and tobool(var_0_1[iter_14_2]) then
			table.insert({}, var_0_1[iter_14_2])
		end
	end

	return underscore.filter({}, function(arg_15_0)
		return arg_15_0:isActivate()
	end)
end

function var_0_0.GetAllBuff()
	local var_16_0 = underscore.map(getProxy(PlayerProxy):getRawData():GetBuffs(), function(arg_17_0)
		return CommonBuff.New(arg_17_0)
	end)

	for iter_16_0, iter_16_1 in pairs((getProxy(ActivityProxy):getRawData())) do
		table.insertto(var_16_0, var_0_0.GenBuffsForActivity(iter_16_1))
	end

	return underscore.filter(var_16_0, function(arg_18_0)
		return arg_18_0:isActivate()
	end)
end

function var_0_0.GetBackYardExpBuffs()
	return underscore.filter(var_0_0.GetBenefitTypeBuffs(BuffUsageConst.DORM_EXP), function(arg_20_0)
		return arg_20_0:isActivate()
	end)
end

function var_0_0.GetBackYardEnergyBuffs()
	return underscore.filter(var_0_0.GetBenefitTypeBuffs(BuffUsageConst.DORM_ENERGY), function(arg_22_0)
		return arg_22_0:isActivate()
	end)
end

function var_0_0.GetShipModExpBuff()
	return underscore.filter(var_0_0.GetBenefitTypeBuffs(BuffUsageConst.SHIP_MOD_EXP), function(arg_24_0)
		return arg_24_0:isActivate()
	end)
end

function var_0_0.GetBackYardPlayerBuffs()
	for iter_25_0, iter_25_1 in ipairs(getProxy(PlayerProxy):getRawData():GetBuffs()) do
		local var_25_0 = CommonBuff.New(iter_25_1)

		if var_25_0:getConfig("benefit_type") == BuffUsageConst.DORM_EXP then
			table.insert({}, var_25_0)
		end
	end

	return underscore.filter({}, function(arg_26_0)
		return arg_26_0:isActivate()
	end)
end

function var_0_0.GetBattleBuffs(arg_27_0)
	return underscore.filter(var_0_0.GetBenefitTypeBuffs(BuffUsageConst.BATTLE), function(arg_28_0)
		return arg_28_0:isActivate()
	end)
end

function var_0_0.GetBuffsByActivityType(arg_29_0)
	local var_29_0 = {}

	_.each(getProxy(ActivityProxy):getActivitiesByType(arg_29_0), function(arg_30_0)
		table.insertto(var_29_0, var_0_0.GenBuffsForActivity(arg_30_0))

		return
	end)

	return underscore.filter({}, function(arg_31_0)
		return arg_31_0:isActivate()
	end)
end

function var_0_0.GetBuffsForMainUI()
	local var_32_0 = getProxy(ActivityProxy)
	local var_32_1 = var_0_0.GetBuffsByActivityType(ActivityConst.ACTIVITY_TYPE_BUFF)

	for iter_32_0 = #var_32_1, 1, -1 do
		if not var_32_1[iter_32_0]:checkShow() then
			table.remove(var_32_1, iter_32_0)
		end
	end

	local var_32_2 = var_32_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	if var_32_2 and not var_32_2:isEnd() then
		local var_32_3 = var_32_2:getConfig("config_client").bufflist

		for iter_32_1, iter_32_2 in pairs(getProxy(PlayerProxy):getRawData().buff_list) do
			local var_32_4 = pg.TimeMgr.GetInstance()

			if var_32_4:GetServerTime() < iter_32_2.timestamp and table.contains(var_32_3, iter_32_2.id) then
				local var_32_5 = ActivityBuff.New(var_32_2.id, iter_32_2.id, iter_32_2.timestamp)

				if var_32_5:checkShow() then
					table.insert(var_32_1, var_32_5)
				end
			end
		end
	end

	local var_32_6 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_3)

	if var_32_6 then
		local var_32_7 = var_32_6:getConfig("config_data")[2]

		for iter_32_3, iter_32_4 in ipairs(getProxy(PlayerProxy):getRawData().buff_list) do
			if table.indexof(var_32_7, iter_32_4.id, 1) then
				local var_32_9 = pg.TimeMgr.GetInstance()

				if var_32_9:GetServerTime() < iter_32_4.timestamp then
					local var_32_10 = ActivityBuff.New(var_32_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME).id, iter_32_4.id, iter_32_4.timestamp)

					if var_32_10:checkShow() then
						table.insert(var_32_1, var_32_10)
					end
				end

				break
			end
		end
	end

	local var_32_11 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

	if var_32_11 then
		local var_32_12 = var_32_11:getConfig("config_data")[2]

		for iter_32_5, iter_32_6 in ipairs(getProxy(PlayerProxy):getRawData().buff_list) do
			if table.indexof(var_32_12, iter_32_6.id, 1) then
				local var_32_14 = pg.TimeMgr.GetInstance()

				if var_32_14:GetServerTime() < iter_32_6.timestamp then
					local var_32_15 = ActivityBuff.New(var_32_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME).id, iter_32_6.id, iter_32_6.timestamp)

					if var_32_15:checkShow() then
						table.insert(var_32_1, var_32_15)
					end
				end

				break
			end
		end
	end

	return var_32_1
end

return var_0_0
