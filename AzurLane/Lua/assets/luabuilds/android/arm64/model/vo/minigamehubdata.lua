local var_0_0 = class("MiniGameHubData", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id
	arg_1_0.count = arg_1_1.available_cnt or arg_1_0:getConfig("reborn_times")
	arg_1_0.usedtime = arg_1_1.used_cnt or 0
	arg_1_0.ultimate = arg_1_1.ultimate or 0
	arg_1_0.highScores = {}

	local var_1_0 = arg_1_1.maxscores or {}

	underscore.each(var_1_0, function(arg_2_0)
		arg_1_0.highScores[arg_2_0.key] = {
			arg_2_0.value1,
			arg_2_0.value2
		}

		return
	end)

	return
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.mini_game_hub
end

function var_0_0.UpdateData(arg_4_0, arg_4_1)
	arg_4_0.count = arg_4_1.available_cnt or arg_4_0.count
	arg_4_0.usedtime = arg_4_1.used_cnt or arg_4_0.usedtime
	arg_4_0.ultimate = arg_4_1.ultimate or arg_4_0.ultimate

	local var_4_1 = arg_4_1.maxscores or {}

	underscore.each(var_4_1, function(arg_5_0)
		arg_4_0.highScores[arg_5_0.key] = {
			arg_5_0.value1,
			arg_5_0.value2
		}

		return
	end)
	print("Hub 更新", "ID:", tostring(arg_4_0.id), "Count:", tostring(arg_4_0.count), "UsedTime:", tostring(arg_4_0.usedtime), "Ultimate:", tostring(arg_4_0.ultimate))

	return
end

function var_0_0.CheckInTime(arg_6_0)
	local var_6_0 = arg_6_0:getConfig("act_id")

	if var_6_0 ~= nil then
		if pg.activity_template[var_6_0] then
			return (pg.TimeMgr.GetInstance():inTime(pg.activity_template[var_6_0].time))
		end
	else
		return true
	end

	return
end

return var_0_0
