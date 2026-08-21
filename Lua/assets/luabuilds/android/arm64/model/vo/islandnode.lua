local var_0_0 = class("IslandNode", import(".BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_map_event_list
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_1.id
	arg_2_0.eventId = arg_2_1.event_id
	arg_2_0.isNew = arg_2_1.is_new == 1

	return
end

function var_0_0.IsUnlock(arg_3_0)
	arg_3_0.isUnlock = arg_3_0.isUnlock or arg_3_0:GetUnlock()

	return arg_3_0.isUnlock
end

function var_0_0.GetUnlock(arg_4_0)
	local var_4_0 = getProxy(SixthAnniversaryIslandProxy)
	local var_4_1 = arg_4_0:getConfig("open_need")
	local var_4_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)
	local var_4_3 = var_4_2 and var_4_2:GetTotalBuildingLevel() or 0
	local var_4_4 = {}

	for iter_4_0, iter_4_1 in ipairs(getProxy(ActivityTaskProxy):getFinishTasks()) do
		var_4_4[iter_4_1:GetConfigID()] = true
	end

	return var_4_3 >= var_4_1[1] and underscore.all(var_4_1[2], function(arg_5_0)
		return var_4_0:GetNode(arg_5_0):IsCompleted()
	end) and underscore.all(arg_4_0:getConfig("open_task"), function(arg_6_0)
		return var_4_4[arg_6_0]
	end)
end

function var_0_0.IsVisual(arg_7_0)
	return (arg_7_0:getConfig("node_status") == 1 or not arg_7_0:IsCompleted()) and arg_7_0:IsUnlock() and not arg_7_0:ChangeVisual()
end

function var_0_0.ChangeVisual(arg_8_0)
	local var_8_0 = arg_8_0:getConfig("node_change")

	return var_8_0 ~= 0 and getProxy(SixthAnniversaryIslandProxy):GetNode(var_8_0):IsUnlock()
end

function var_0_0.IsCompleted(arg_9_0)
	return arg_9_0.eventId == 0
end

function var_0_0.IsNew(arg_10_0)
	return not arg_10_0:IsTreasure() and arg_10_0.isNew
end

function var_0_0.IsMain(arg_11_0)
	return arg_11_0:getConfig("type") == 1
end

function var_0_0.IsTreasure(arg_12_0)
	return arg_12_0:getConfig("type") == 4
end

function var_0_0.IsRefresh(arg_13_0)
	return arg_13_0:getConfig("refresh") == 1
end

function var_0_0.IsFlowerField(arg_14_0)
	return arg_14_0:getConfig("type") == 5 and arg_14_0:getConfig("params")[1] == "flowerfield"
end

function var_0_0.GetScale(arg_15_0)
	return 0.8
end

function var_0_0.RedDotHint(arg_16_0)
	return switch(arg_16_0:getConfig("type"), {
		[4] = function()
			return false
		end,
		[5] = function()
			var_0_0.markDic = var_0_0.markDic or {
				minigame1 = function(...)
					local var_19_0 = getProxy(MiniGameProxy):GetHubByHubId((getProxy(ActivityProxy):getActivityById(ActivityConst.ISLAND_GAME_ID):getConfig("config_id"))).count

					return var_19_0 > 0
				end,
				minigame2 = function(...)
					return var_0_0.markDic.minigame1(...)
				end,
				minigame3 = function(...)
					return var_0_0.markDic.minigame1(...)
				end,
				flowerfield = function()
					return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FLOWER_FIELD)))
				end,
				hotspringtask = function()
					return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)))
				end
			}

			return switch(arg_16_0:getConfig("params")[1], var_0_0.markDic, function()
				return false
			end)
		end
	}, function()
		return not arg_16_0:IsCompleted()
	end)
end

function var_0_0.GetEffectName(arg_26_0)
	return switch(arg_26_0:getConfig("type"), {
		[4] = function()
			return "haidao_baoxiang"
		end
	}, function()
		return ""
	end)
end

function var_0_0.CanTrigger(arg_29_0)
	if arg_29_0:getConfig("type") == 5 then
		return true
	else
		return not arg_29_0:IsCompleted()
	end

	return
end

function var_0_0.CanToggleOn(arg_30_0)
	return switch(arg_30_0:getConfig("type"), {
		[4] = function()
			return false
		end,
		[5] = function()
			return true
		end
	}, function()
		return not arg_30_0:IsCompleted()
	end)
end

return var_0_0
