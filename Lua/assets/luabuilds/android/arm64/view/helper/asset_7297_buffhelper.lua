local BuffHelper = class("BuffHelper")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}

function BuffHelper:GenBuffsForActivity()
	if self and not self:isEnd() and var_0_2[self.id] == self then
		return underscore.map(var_0_3[self.id], function(arg_2_0)
			return var_0_1[arg_2_0]
		end)
	end

	if var_0_3[self.id] then
		underscore.each(var_0_3[self.id], function(arg_3_0)
			if var_0_1[arg_3_0] then
				var_0_4[var_0_1[arg_3_0]:getConfig("benefit_type")][arg_3_0] = nil
			end

			var_0_1[arg_3_0] = nil

			return
		end)
	end

	var_0_2[self.id] = nil
	var_0_3[self.id] = nil

	if not self or self:isEnd() then
		return {}
	end

	local var_1_0 = self:GetBuffList() or {}

	switch(self:getConfig("type"), {
		[ActivityConst.ACTIVITY_TYPE_BUFF] = function()
			local var_4_0 = self:getConfig("config_id")
			local var_4_1 = {}

			if var_4_0 == 0 then
				var_4_1 = self:getConfig("config_data")
			else
				table.insert(var_4_1, var_4_0)
			end

			for iter_4_0, iter_4_1 in ipairs(var_4_1) do
				table.insert(var_1_0, (ActivityBuff.New(self.id, iter_4_1)))
			end

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF] = function()
			for iter_5_0, iter_5_1 in pairs((self:GetBuildingIds())) do
				if pg.activity_event_building[iter_5_1] then
					_.each(pg.activity_event_building[iter_5_1].buff, function(arg_6_0)
						table.insert(var_1_0, ActivityBuff.New(self.id, arg_6_0))

						return
					end)
				end
			end

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2] = function()
			for iter_7_0, iter_7_1 in pairs((self:GetBuildingIds())) do
				if pg.activity_event_building[iter_7_1] then
					_.each(pg.activity_event_building[iter_7_1].buff, function(arg_8_0)
						table.insert(var_1_0, ActivityBuff.New(self.id, arg_8_0))

						return
					end)
				end
			end

			local var_7_0 = self:GetSceneBuildingId()

			if var_7_0 > 0 then
				if pg.activity_event_building[var_7_0] then
					_.each(pg.activity_event_building[var_7_0].buff, function(arg_9_0)
						table.insert(var_1_0, ActivityBuff.New(self.id, arg_9_0))

						return
					end)
				end
			end

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_PT_BUFF] = function()
			for iter_10_0, iter_10_1 in pairs(self.data3_list) do
				table.insert(var_1_0, ActivityBuff.New(self.id, iter_10_1))
			end

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_ATELIER_LINK] = function()
			for iter_11_0, iter_11_1 in ipairs((self:GetSlots())) do
				if iter_11_1[1] > 0 and iter_11_1[2] > 0 then
					table.insert(var_1_0, ActivityBuff.New(self.id, AtelierMaterial.New({
						configId = iter_11_1[1]
					}):GetBuffs()[iter_11_1[2]]))
				end
			end

			return
		end
	})

	var_0_2[self.id] = self
	var_0_3[self.id] = underscore.map(var_1_0, function(arg_12_0)
		var_0_1[arg_12_0.id] = arg_12_0

		local var_12_0 = arg_12_0:getConfig("benefit_type")

		var_0_4[var_12_0] = var_0_4[var_12_0] or {}
		var_0_4[var_12_0][arg_12_0.id] = true

		return arg_12_0.id
	end)

	return var_1_0
end

function BuffHelper.ClearAllCache()
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}

	return
end

function BuffHelper:GetBenefitTypeBuffs()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(getProxy(PlayerProxy):getRawData():GetBuffs()) do
		local var_14_1 = CommonBuff.New(iter_14_1)

		if var_14_1:getConfig("benefit_type") == self then
			table.insert(var_14_0, var_14_1)
		end
	end

	for iter_14_2, iter_14_3 in pairs(var_0_4[self] or {}) do
		if iter_14_3 and tobool(var_0_1[iter_14_2]) then
			table.insert(var_14_0, var_0_1[iter_14_2])
		end
	end

	return underscore.filter(var_14_0, function(arg_15_0)
		return arg_15_0:isActivate()
	end)
end

function BuffHelper.GetAllBuff()
	local var_16_0 = underscore.map(getProxy(PlayerProxy):getRawData():GetBuffs(), function(arg_17_0)
		return CommonBuff.New(arg_17_0)
	end)

	for iter_16_0, iter_16_1 in pairs((getProxy(ActivityProxy):getRawData())) do
		table.insertto(var_16_0, BuffHelper.GenBuffsForActivity(iter_16_1))
	end

	return underscore.filter(var_16_0, function(arg_18_0)
		return arg_18_0:isActivate()
	end)
end

function BuffHelper.GetBackYardExpBuffs()
	return underscore.filter(BuffHelper.GetBenefitTypeBuffs(BuffUsageConst.DORM_EXP), function(arg_20_0)
		return arg_20_0:isActivate()
	end)
end

function BuffHelper.GetBackYardEnergyBuffs()
	return underscore.filter(BuffHelper.GetBenefitTypeBuffs(BuffUsageConst.DORM_ENERGY), function(arg_22_0)
		return arg_22_0:isActivate()
	end)
end

function BuffHelper.GetShipModExpBuff()
	return underscore.filter(BuffHelper.GetBenefitTypeBuffs(BuffUsageConst.SHIP_MOD_EXP), function(arg_24_0)
		return arg_24_0:isActivate()
	end)
end

function BuffHelper.GetBackYardPlayerBuffs()
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(getProxy(PlayerProxy):getRawData():GetBuffs()) do
		local var_25_1 = CommonBuff.New(iter_25_1)

		if var_25_1:getConfig("benefit_type") == BuffUsageConst.DORM_EXP then
			table.insert(var_25_0, var_25_1)
		end
	end

	return underscore.filter(var_25_0, function(arg_26_0)
		return arg_26_0:isActivate()
	end)
end

function BuffHelper:GetBattleBuffs()
	return underscore.filter(BuffHelper.GetBenefitTypeBuffs(BuffUsageConst.BATTLE), function(arg_28_0)
		return arg_28_0:isActivate()
	end)
end

function BuffHelper:GetBuffsByActivityType()
	local var_29_0 = {}

	_.each(getProxy(ActivityProxy):getActivitiesByType(self), function(arg_30_0)
		table.insertto(var_29_0, BuffHelper.GenBuffsForActivity(arg_30_0))

		return
	end)

	return underscore.filter(var_29_0, function(arg_31_0)
		return arg_31_0:isActivate()
	end)
end

function BuffHelper.GetBuffsForMainUI()
	local var_32_0 = getProxy(ActivityProxy)
	local var_32_1 = BuffHelper.GetBuffsByActivityType(ActivityConst.ACTIVITY_TYPE_BUFF)

	for iter_32_0 = #var_32_1, 1, -1 do
		if not var_32_1[iter_32_0]:checkShow() then
			table.remove(var_32_1, iter_32_0)
		end
	end

	local var_32_2 = var_32_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	if var_32_2 and not var_32_2:isEnd() then
		local var_32_3 = var_32_2:getConfig("config_client").bufflist

		for iter_32_1, iter_32_2 in pairs(getProxy(PlayerProxy):getRawData().buff_list) do
			if pg.TimeMgr.GetInstance():GetServerTime() < iter_32_2.timestamp and table.contains(var_32_3, iter_32_2.id) then
				local var_32_4 = ActivityBuff.New(var_32_2.id, iter_32_2.id, iter_32_2.timestamp)

				if var_32_4:checkShow() then
					table.insert(var_32_1, var_32_4)
				end
			end
		end
	end

	local var_32_5 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_3)

	if var_32_5 then
		local var_32_6 = var_32_5:getConfig("config_data")[2]

		for iter_32_3, iter_32_4 in ipairs(getProxy(PlayerProxy):getRawData().buff_list) do
			if table.indexof(var_32_6, iter_32_4.id, 1) then
				if pg.TimeMgr.GetInstance():GetServerTime() < iter_32_4.timestamp then
					local var_32_8 = ActivityBuff.New(var_32_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME).id, iter_32_4.id, iter_32_4.timestamp)

					if var_32_8:checkShow() then
						table.insert(var_32_1, var_32_8)
					end
				end

				break
			end
		end
	end

	local var_32_9 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

	if var_32_9 then
		local var_32_10 = var_32_9:getConfig("config_data")[2]

		for iter_32_5, iter_32_6 in ipairs(getProxy(PlayerProxy):getRawData().buff_list) do
			if table.indexof(var_32_10, iter_32_6.id, 1) then
				if pg.TimeMgr.GetInstance():GetServerTime() < iter_32_6.timestamp then
					local var_32_12 = ActivityBuff.New(var_32_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME).id, iter_32_6.id, iter_32_6.timestamp)

					if var_32_12:checkShow() then
						table.insert(var_32_1, var_32_12)
					end
				end

				break
			end
		end
	end

	return var_32_1
end

return BuffHelper
