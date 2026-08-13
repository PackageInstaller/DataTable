class = var_0_10000

local var_0_0 = "IslandNode"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_map_event_list
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_1.id
	arg_2_0.eventId = arg_2_1.event_id
	arg_2_0.isNew = arg_2_1.is_new == 1

	return
end

function var_0_1.IsUnlock(arg_3_0)
	local var_3_0

	if not arg_3_0.isUnlock then
		var_3_0 = arg_3_0:GetUnlock()
	end

	arg_3_0.isUnlock = var_3_0

	return arg_3_0.isUnlock
end

function var_0_1.GetUnlock(arg_4_0)
	getProxy = var_1_10001
	SixthAnniversaryIslandProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)
	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.getConfig(var_4_1, "open_need")

	getProxy = var_4_1
	ActivityProxy = var_4

	local var_4_3 = var_4_1(var_4)
	local var_4_4 = var_3.getActivityByType

	ActivityConst = var_1_10005

	local var_4_5

	if not var_4_4(var_4_3, var_1_10005.ACTIVITY_TYPE_BUILDING_BUFF_2) or not var_3:GetTotalBuildingLevel() then
		var_4_5 = 0
	end

	local var_4_6 = {}

	ipairs = var_1_10006
	getProxy = var_1_10007
	ActivityTaskProxy = var_1_10008

	local var_4_7 = var_1_10007(var_1_10008)

	for iter_4_0, iter_4_1 in var_1_10006(var_7.getFinishTasks(var_4_7)) do
		var_4_6[iter_4_1:GetConfigID()] = true
	end

	local var_4_8

	if var_4_2[1] <= var_4_5 then
		underscore = var_4_8

		if var_4_8.all(var_4_2[2], function(arg_5_0)
			local var_5_0 = var_4_0
			local var_5_1 = var_1.GetNode(var_5_0, arg_5_0)

			return var_1.IsCompleted(var_5_1)
		end) then
			underscore = var_4_8
			var_4_8 = var_4_8.all(arg_4_0:getConfig("open_task"), function(arg_6_0)
				return var_4_6[arg_6_0]
			end)
		end
	else
		var_4_8 = false
	end

	if false then
		var_4_8 = true
	end

	return var_4_8
end

function var_0_1.IsVisual(arg_7_0)
	local var_7_0

	if arg_7_0:getConfig("node_status") == 1 or not arg_7_0:IsCompleted() then
		if arg_7_0:IsUnlock() then
			var_7_0 = not arg_7_0:ChangeVisual()
		end
	else
		var_7_0 = false
	end

	if false then
		var_7_0 = true
	end

	return var_7_0
end

function var_0_1.ChangeVisual(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_3

	if arg_8_0.getConfig(var_8_0, "node_change") ~= 0 then
		getProxy = var_8_0
		SixthAnniversaryIslandProxy = var_3

		local var_8_1 = var_8_0(var_3)
		local var_8_2 = var_2.GetNode(var_8_1, var_1)

		var_8_3 = var_2.IsUnlock(var_8_2)
	else
		var_8_3 = false
	end

	if false then
		var_8_3 = true
	end

	return var_8_3
end

function var_0_1.IsCompleted(arg_9_0)
	return arg_9_0.eventId == 0
end

function var_0_1.IsNew(arg_10_0)
	return not arg_10_0:IsTreasure() and arg_10_0.isNew
end

function var_0_1.IsMain(arg_11_0)
	return arg_11_0:getConfig("type") == 1
end

function var_0_1.IsTreasure(arg_12_0)
	return arg_12_0:getConfig("type") == 4
end

function var_0_1.IsRefresh(arg_13_0)
	return arg_13_0:getConfig("refresh") == 1
end

function var_0_1.IsFlowerField(arg_14_0)
	return arg_14_0:getConfig("type") == 5 and arg_14_0:getConfig("params")[1] == "flowerfield"
end

function var_0_1.GetScale(arg_15_0)
	return 0.8
end

function var_0_1.RedDotHint(arg_16_0)
	switch = var_1_10001

	return var_1_10001(arg_16_0:getConfig("type"), {
		[4] = function()
			return false
		end,
		[5] = function()
			local var_18_0 = var_0_1
			local var_18_1

			if not var_0_1.markDic then
				var_18_1 = {
					minigame1 = function(...)
						getProxy = var_3_10000
						ActivityProxy = var_3_10001

						local var_19_0 = var_3_10000(var_3_10001)
						local var_19_1 = var_0.getActivityById

						ActivityConst = var_3_10002

						local var_19_2 = var_19_1(var_19_0, var_3_10002.ISLAND_GAME_ID)
						local var_19_3 = var_0.getConfig(var_19_2, "config_id")

						getProxy = var_19_2
						MiniGameProxy = var_2

						local var_19_4 = var_19_2(var_2)

						return var_1.GetHubByHubId(var_19_4, var_19_3).count > 0
					end,
					minigame2 = function(...)
						return var_0_1.markDic.minigame1(...)
					end,
					minigame3 = function(...)
						return var_0_1.markDic.minigame1(...)
					end,
					flowerfield = function()
						getProxy = var_3_10000
						ActivityProxy = var_3_10001

						local var_22_0 = var_3_10000(var_3_10001)
						local var_22_1 = var_0.getActivityByType

						ActivityConst = var_3_10002

						local var_22_2 = var_22_1(var_22_0, var_3_10002.ACTIVITY_TYPE_FLOWER_FIELD)

						Activity = var_22_0

						return var_22_0.IsActivityReady(var_22_2)
					end,
					hotspringtask = function()
						getProxy = var_3_10000
						ActivityProxy = var_3_10001

						local var_23_0 = var_3_10000(var_3_10001)
						local var_23_1 = var_0.getActivityByType

						ActivityConst = var_3_10002

						local var_23_2 = var_23_1(var_23_0, var_3_10002.ACTIVITY_TYPE_HOTSPRING_2)

						Activity = var_23_0

						return var_23_0.IsActivityReady(var_23_2)
					end
				}
			end

			var_18_0.markDic = var_18_1
			switch = var_18_0

			local var_18_2 = arg_16_0

			return var_18_0(var_1.getConfig(var_18_2, "params")[1], var_0_1.markDic, function()
				return false
			end)
		end
	}, function()
		local var_25_0 = arg_16_0

		return not var_0.IsCompleted(var_25_0)
	end)
end

function var_0_1.GetEffectName(arg_26_0)
	switch = var_1_10001

	return var_1_10001(arg_26_0:getConfig("type"), {
		[4] = function()
			return "haidao_baoxiang"
		end
	}, function()
		return ""
	end)
end

function var_0_1.CanTrigger(arg_29_0)
	if arg_29_0:getConfig("type") == 5 then
		return true
	else
		return not arg_29_0:IsCompleted()
	end

	return
end

function var_0_1.CanToggleOn(arg_30_0)
	switch = var_1_10001

	return var_1_10001(arg_30_0:getConfig("type"), {
		[4] = function()
			return false
		end,
		[5] = function()
			return true
		end
	}, function()
		local var_33_0 = arg_30_0

		return not var_0.IsCompleted(var_33_0)
	end)
end

return var_0_1
