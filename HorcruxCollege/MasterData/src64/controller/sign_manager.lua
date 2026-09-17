local var_0_0 = {}
local network = require("network.network")
local sign_data = require("data.sign_data")
local sign_daily_data = require("data.sign_daily_data")
local sign_accumulate_data = require("data.sign_accumulate_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_sign_data = require("data.activity_sign_data")
local activity_img_data = require("data.activity_img_data")
local drop_manager = require("controller.drop_manager")
local item_data = require("data.item_data")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local autopop_manager = require("controller.autopop_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local playermodel = require("model.playermodel")
local var_0_16 = 1

SIGN_TIME_FLAG = {
	{
		time_str = "09:00:00",
		end_time = 9,
		start_time = 0
	},
	{
		time_str = "12:00:00",
		end_time = 12,
		start_time = 9
	},
	{
		time_str = "16:00:00",
		end_time = 16,
		start_time = 12
	},
	{
		time_str = "20:00:00",
		end_time = 20,
		start_time = 16
	},
	{
		time_str = "23:59:59",
		end_time = 24,
		start_time = 20
	}
}

function var_0_0.init(arg_1_0)
	arg_1_0.SignLimit = 3
	arg_1_0.Day = 0
	arg_1_0.SignLastTime = 0
	arg_1_0.SignTask = 0
	arg_1_0.AccumulatedSign = 0
	arg_1_0.SignAccuAward = {}
	arg_1_0.callFuncTag = false
	arg_1_0.existTag = false
end

function var_0_0:createSignLayer(arg_2_1, arg_2_2, arg_2_3)
	if self.callFuncTag and self.callFuncTag == true then
		return
	end

	if self.existTag and self.existTag == true then
		return
	end

	self.callFuncTag = true
	self.callback = arg_2_2
	self.initType = arg_2_1
	self.afterSignCallback = arg_2_3

	self:judgeAutoSign()
end

function var_0_0.get_time_period(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(SIGN_TIME_FLAG) do
		if arg_5_1 >= iter_5_1.start_time and arg_5_1 < iter_5_1.end_time then
			return iter_5_0
		end
	end
end

function var_0_0:judgeAutoSign()
	local var_6_0 = self.callback

	network:rpc("get_sign_time", nil, function(arg_7_0)
		print(dump(arg_7_0))

		self.server_time = arg_7_0.time
		self.SignLimit = arg_7_0.sign_limit
		self.SignLastTime = arg_7_0.sign_last_time
		self.Day = arg_7_0.daycount
		self.SignTask = arg_7_0.signtask
		self.AccumulatedSign = arg_7_0.accumulatedsign

		if arg_7_0.iscansign then
			self.initType = var_0_16

			self:sign()
		else
			if self.initType ~= var_0_16 then
				self:sign()
			elseif var_6_0 then
				var_6_0()
			end

			print("不可签到")
		end
	end)
end

function var_0_0.getSignInfo(arg_8_0, arg_8_1)
	network:rpc("get_sign_time", nil, function(arg_9_0)
		arg_8_0.server_time = arg_9_0.time
		arg_8_0.SignLimit = arg_9_0.sign_limit
		arg_8_0.SignLastTime = arg_9_0.sign_last_time
		arg_8_0.Day = arg_9_0.daycount
		arg_8_0.SignTask = arg_9_0.signtask
		arg_8_0.AccumulatedSign = arg_9_0.accumulatedsign

		if arg_8_1 then
			arg_8_1()
		end
	end)
end

function var_0_0:sign()
	local var_10_0 = self:getSignLayerUIData()
	local var_10_1 = {
		statusTag = {
			accumulated = false,
			normal = false
		}
	}

	local function var_10_2(arg_11_0, arg_11_1)
		var_10_1.day = self.Day
		var_10_1.items = var_10_0

		if arg_11_0 and next(arg_11_0) ~= nil then
			var_10_1.statusTag = arg_11_0
		end

		var_10_1.serverTime = self.server_time
		var_10_1.signLimit = self.SignLimit
		var_10_1.signLastTime = self.SignLastTime
		var_10_1.signTask = self.SignTask
		var_10_1.accumulatedSign = self.AccumulatedSign
		var_10_1.callback = self.callback

		if arg_11_1 then
			var_10_1.itemMessage = self:getSignItemData(arg_11_1)
		end

		LayerManager:pushInLayer("SignLayer", {
			initpara = var_10_1
		})

		self.callFuncTag = false
	end

	if self.initType == var_0_16 then
		self:completeSignatServer(var_10_2)
	else
		var_10_2()
	end
end

function var_0_0.getSignItemData(arg_12_0, arg_12_1)
	local var_12_0 = {
		items = {}
	}

	if arg_12_1.gold and arg_12_1.gold > 0 then
		var_12_0.gold = arg_12_1.gold
	elseif arg_12_1.diamond and arg_12_1.diamond ~= 0 then
		var_12_0.diamond = arg_12_1.diamond
	elseif arg_12_1.items then
		var_12_0.items = arg_12_1.items
	end

	if arg_12_1.accumulatedgold and var_12_0.gold then
		var_12_0.gold = var_12_0.gold + arg_12_1.accumulatedgold
	elseif arg_12_1.accumulatedgold and var_12_0.gold == nil then
		var_12_0.gold = arg_12_1.accumulatedgold
	end

	if arg_12_1.accumulateddiamond and var_12_0.diamond then
		var_12_0.diamond = var_12_0.diamond + arg_12_1.accumulateddiamond
	elseif arg_12_1.accumulateddiamond and var_12_0.diamond == nil then
		var_12_0.diamond = arg_12_1.accumulateddiamond
	end

	if arg_12_1.accumulateditems then
		(function(arg_13_0, arg_13_1)
			local var_13_0 = 0

			for iter_13_0, iter_13_1 in pairs(arg_13_0) do
				var_13_0 = var_13_0 + 1
			end

			for iter_13_2, iter_13_3 in pairs(arg_13_1) do
				local var_13_1 = 0

				if arg_13_0 then
					for iter_13_4, iter_13_5 in pairs(arg_13_0) do
						if iter_13_2 == iter_13_4 then
							iter_13_5.addNumber = iter_13_5.addNumber + iter_13_3.addNumber
						else
							var_13_1 = var_13_1 + 1
						end
					end
				end

				if var_13_1 == var_13_0 then
					arg_13_0[iter_13_2] = iter_13_3
					var_13_0 = var_13_0 + 1
				end
			end

			return arg_13_0
		end)(var_12_0.items, arg_12_1.accumulateditems)
	end

	print("$$$$$$$$", dump(var_12_0.items))

	return var_12_0
end

function var_0_0:getSignLayerUIData()
	local var_14_0 = {}

	for iter_14_0 = 1, 3 do
		local var_14_1
		local var_14_2

		if iter_14_0 == 1 then
			var_14_1 = "firsttime"
			var_14_2 = "firstnum"
		elseif iter_14_0 == 2 then
			var_14_1 = "secondtime"
			var_14_2 = "secondnum"
		else
			local var_14_3

			if iter_14_0 == 3 then
				var_14_1 = "thirdtime"
				var_14_2 = "thirdnum"
				var_14_3 = {}
			end
		end

		var_14_3.itemid = sign_data[self.Day][var_14_1]
		var_14_3.itemnum = sign_data[self.Day][var_14_2]
		var_14_0[iter_14_0] = var_14_3
	end

	return var_14_0
end

function var_0_0.completeSignatServer(arg_15_0, arg_15_1)
	local var_15_0 = {
		accumulated = false,
		normal = false
	}

	network:rpc("get_sign_awards", nil, function(arg_16_0)
		print(dump(arg_16_0))
		AlertManager:unregister_alert(ALERT_SIGN, true)

		if arg_16_0.result == 1 then
			if arg_16_0.items and next(arg_16_0.items) then
				for iter_16_0, iter_16_1 in pairs(arg_16_0.items) do
					iter_16_1.addNumber = item_manager:setItemByServerItem(iter_16_1)
					var_15_0.normal = true
				end
			elseif arg_16_0.gold and arg_16_0.gold ~= 0 then
				playermodel.gold = playermodel.gold + arg_16_0.gold
				var_15_0.normal = true
			elseif arg_16_0.diamond and arg_16_0.diamond ~= 0 then
				playermodel.diamond = playermodel.diamond + arg_16_0.diamond
				var_15_0.normal = true
			end

			if arg_16_0.accumulateditems then
				for iter_16_2, iter_16_3 in pairs(arg_16_0.accumulateditems) do
					iter_16_3.addNumber = item_manager:setItemByServerItem(iter_16_3)
					var_15_0.accumulated = true
				end
			end

			if arg_16_0.accumulatedgold then
				playermodel.gold = playermodel.gold + arg_16_0.accumulatedgold
				var_15_0.accumulated = true
			end

			if arg_16_0.accumulateddiamond then
				playermodel.diamond = playermodel.diamond + arg_16_0.accumulateddiamond
				var_15_0.accumulated = true
			end

			arg_15_0.SignLastTime = arg_16_0.sign_last_time
			arg_15_0.SignLimit = arg_16_0.sign_limit

			if arg_16_0.gold and arg_16_0.gold > 0 then
				AnalyticManager.getGold("signgold", arg_16_0.gold)
			end

			if arg_16_0.diamond and arg_16_0.diamond > 0 then
				AnalyticManager.getDiamond(arg_16_0.diamond, 2)
			end

			AnalyticManager.signSuccess()

			if arg_15_1 then
				arg_15_1(var_15_0, arg_16_0)
			end

			if arg_15_0.afterSignCallback then
				arg_15_0.afterSignCallback()
			end

			activity_manager:fireEvent(activity_manager.activityEventId.SIGN_IN_MAIN_LAYER)
		elseif arg_16_0.result == 2 then
			global_ShowBlockWords(L_SIGN_WARNING[2])
		elseif arg_16_0.result == 3 then
			global_ShowBlockWords(L_SIGN_WARNING[3])
		elseif arg_16_0.result == 4 then
			global_ShowBlockWords(L_SIGN_ILLEGAL)
		else
			print("sign defeat")
		end
	end)
end

function var_0_0.createMidasLayer(arg_17_0, arg_17_1)
	LayerManager:pushInLayer("HandOfMidasLayer", {
		callback = arg_17_1
	})
end

function var_0_0.resumeSign(arg_18_0)
	arg_18_0.existTag = false
end

function var_0_0.setSign(arg_19_0)
	arg_19_0.existTag = true
end

function var_0_0:createActivitySignLayer(arg_20_1)
	self.id = arg_20_1.activityID
	self.activityType = arg_20_1.id
	self.activityCallback = arg_20_1.callback
	self.initParam = arg_20_1.initParam
	self.isAutoPop = arg_20_1.isAutoPop

	self:activitySign()
end

function var_0_0:getActivitySignLayerUIData(arg_21_1)
	local var_21_0 = (activity_conf_data[self.id].is_sign1_auto ~= 1 or self.id == 2) and function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == 1 then
			self.activitySignTime = arg_23_1
			self.activitySignData = arg_23_2
			self.activitySignTag = true

			function self.activitySingCallback(arg_24_0)
				self.activity:activitySign(function(arg_25_0)
					if arg_25_0 == 1 then
						activity_manager:updateActivityAlert("sign", self.id, false)
					elseif arg_25_0 == 0 then
						global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[1][0])
					elseif arg_25_0 == 2 then
						global_ShowBlockWords(L_ACTIVITY_END)
					elseif arg_25_0 == 3 then
						global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[1][3])
					elseif arg_25_0 == 4 then
						global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[1][4])
					end

					if arg_24_0 then
						arg_24_0(arg_25_0)
					end
				end)
			end

			if arg_21_1 then
				arg_21_1()
			end
		elseif arg_23_0 == 0 then
			global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[0])
		elseif arg_23_0 == 2 then
			global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[2])
		else
			print("unknow error")
		end
	end or function(arg_26_0, arg_26_1)
		if arg_26_0 == 1 then
			self.signstats = arg_26_1
			self.activitySignTag = true

			function self.activitySingCallback(arg_27_0, arg_27_1)
				self.activity:activitySign(arg_27_0, function(arg_28_0)
					if arg_28_0 == 1 then
						activity_manager:updateActivityAlert("sign", self.id, false)
					elseif arg_28_0 == 0 then
						global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[1][0])
					elseif arg_28_0 == 2 then
						global_ShowBlockWords(L_ACTIVITY_END)
					elseif arg_28_0 == 3 then
						global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[1][3])
					elseif arg_28_0 == 4 then
						global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[1][4])
					elseif arg_28_0 == 6 then
						global_ShowBlockWords(L_DIAMOND_LACK)
					end

					if arg_27_1 then
						arg_27_1(arg_28_0)
					end
				end)
			end

			if arg_21_1 then
				arg_21_1()
			end
		elseif arg_26_0 == 0 then
			global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[0])
		elseif arg_26_0 == 2 then
			global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[2])
		else
			print("unknow error")
		end
	end

	self.otherData = (function()
		local var_22_0 = {
			drops = {}
		}

		for iter_22_0, iter_22_1 in pairs(activity_sign_data) do
			local var_22_1, var_22_2 = string.match(iter_22_0, "(%d+)-(%d+)")
			local var_22_3 = tonumber(var_22_1)

			if var_22_3 and var_22_3 == self.id then
				var_22_0.drops[tonumber(var_22_2)] = iter_22_1.dropid
			end
		end

		var_22_0.startTime = activity_conf_data[self.id].starttime
		var_22_0.endTime = activity_conf_data[self.id].finishtime
		var_22_0.path = activity_img_data[self.id].path

		return var_22_0
	end)()
	self.activity = activity_manager:getActivityObj(self.id)

	self.activity:getActivitySign(var_21_0)
end

function var_0_0:activitySign()
	self:getActivitySignLayerUIData(function()
		local var_30_0 = {
			signTime = self.activitySignTime,
			signData = self.activitySignData
		}

		var_30_0.signTag = self.activitySignTag or false
		var_30_0.otherData = self.otherData
		var_30_0.callback = self.activityCallback
		var_30_0.activitySingCallback = self.activitySingCallback
		var_30_0.activityId = self.id
		var_30_0.activityUIObjName = self:getUIObjLayerName()
		var_30_0.signstats = self.signstats
		var_30_0.initParam = self.initParam
		var_30_0.isAutoPop = self.isAutoPop

		LayerManager:pushInLayer("ActivitySignBaseLayer", var_30_0)
	end)
end

function var_0_0:getUIObjLayerName()
	if not self.activityType then
		return "ActivitySignLayer"
	end

	return "ActivitySignLayer_" .. split(self.activityType, "-")[1] .. "_" .. split(self.activityType, "-")[2]
end

function var_0_0.getSignItemDataNew(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = {}
	local var_32_1 = 1

	while var_32_1 <= arg_32_2 do
		local var_32_2 = drop_manager:getDropMsg(sign_daily_data[string.format("%d/%d", arg_32_1, var_32_1)].dropid)
		local var_32_3
		local var_32_4
		local var_32_5
		local var_32_6

		if var_32_2.diamond and var_32_2.diamond > 0 then
			var_32_4 = var_32_2.diamond
			var_32_5 = 1000000
			var_32_6 = 5
		elseif var_32_2.gold and var_32_2.gold > 0 then
			var_32_4 = var_32_2.diamond
			var_32_5 = 1000001
			var_32_6 = 1
		elseif var_32_2.equips and next(var_32_2.equips) then
			for iter_32_0, iter_32_1 in pairs(var_32_2.equips) do
				var_32_3 = iter_32_1.dropid
				var_32_4 = iter_32_1.dropNum
				var_32_5 = item_data[iter_32_1.dropid].image_id
				var_32_6 = item_data[iter_32_1.dropid].equip_quality
			end
		end

		table.insert(var_32_0, {
			itemid = var_32_3,
			itemNum = var_32_4,
			image_id = var_32_5,
			quality = var_32_6,
			bag_item_type = item_data[var_32_3].bag_item_type
		})

		var_32_1 = var_32_1 + 1
	end

	return var_32_0
end

function var_0_0.getSignAccuTimeFromServe(arg_33_0, arg_33_1)
	network:rpc("get_sign_time_new", nil, function(arg_34_0)
		print("%%%%%", dump(arg_34_0))

		if arg_34_0.iscansign then
			AlertManager:register_alert(ALERT_SIGN)
		else
			AlertManager:unregister_alert(ALERT_SIGN, true)
		end

		if arg_34_0.result == 1 then
			arg_33_0.AccumulatedSign = arg_34_0.signaccumulate

			if arg_33_1 then
				arg_33_1(arg_34_0)
			end
		elseif arg_34_0.result == 2 then
			global_ShowBlockWords(L_SIGN_ILLEGAL)
		end
	end)
end

function var_0_0.getTime(arg_35_0, arg_35_1)
	local var_35_0 = {
		year = tonumber(os.date("%Y", arg_35_1)),
		month = tonumber(os.date("%m", arg_35_1)),
		day = tonumber(os.date("%d", arg_35_1))
	}

	var_35_0.dayNum = tonumber(os.date("%d", os.time({
		day = 0,
		year = var_35_0.year,
		month = var_35_0.month + 1
	})))

	return var_35_0
end

function var_0_0.signResult(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	network:rpc("get_sign_result", {
		date = arg_36_1,
		month = arg_36_2
	}, function(arg_37_0)
		if arg_37_0.result == 1 then
			if arg_37_0.costdiamond then
				playermodel.diamond = playermodel.diamond - arg_37_0.costdiamond
			end

			global_update_gold_stone_diamond(nil, nil, playermodel.diamond)

			if arg_37_0.cost_item and next(arg_37_0.cost_item) then
				for iter_37_0, iter_37_1 in pairs(arg_37_0.cost_item) do
					item_manager:deleteItem(iter_37_1.entityid, iter_37_1.num)
				end
			end

			if arg_36_3 then
				arg_36_3(arg_37_0)
			end
		elseif arg_37_0.result == 2 then
			global_ShowBlockWords(L_SIGN_ILLEGAL)
		elseif arg_37_0.result == 3 then
			global_ShowBlockWords(L_SIGNED_YET)
		elseif arg_37_0.result == 4 then
			global_ShowBlockWords(L_DIAMOND_LACK)
		end
	end)
end

function var_0_0.getsignAccuItemData(arg_38_0, arg_38_1)
	local var_38_0 = {}

	while sign_accumulate_data[arg_38_1]["needs_" .. 1] do
		local var_38_1 = drop_manager:getDropMsg(sign_accumulate_data[arg_38_1]["dropid_" .. 1])

		if var_38_1.equips[1] then
			table.insert(var_38_0, {
				daycount = sign_accumulate_data[arg_38_1]["needs_" .. 1],
				dropid = sign_accumulate_data[arg_38_1]["dropid_" .. 1],
				image = "equipment/" .. item_data[var_38_1.equips[1].dropid].image_id .. ".png",
				image_on = "equipment/" .. item_data[var_38_1.equips[1].dropid].image_id .. ".png",
				dropNum = var_38_1.equips[1].dropNum
			})
		elseif var_38_1.diamond then
			table.insert(var_38_0, {
				image = "equipment/1000000.png",
				dropid = 1,
				image_on = "equipment/1000000.png",
				daycount = sign_accumulate_data[arg_38_1]["needs_" .. 1],
				dropNum = var_38_1.diamond
			})
		elseif var_38_1.gold then
			table.insert(var_38_0, {
				image = "equipment/1000001.png",
				dropid = 0,
				image_on = "equipment/1000001.png",
				daycount = sign_accumulate_data[arg_38_1]["needs_" .. 1],
				dropNum = var_38_1.gold
			})
		end
	end

	return var_38_0
end

function var_0_0.accuAwardResult(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	network:rpc("get_sign_accumulate_result", {
		month = arg_39_1,
		index = arg_39_2
	}, function(arg_40_0)
		if arg_40_0.result == 1 then
			arg_39_0.SignAccuAward = arg_40_0.signaccuaward

			global_update_gold_stone_diamond(nil, nil, playermodel.diamond)

			if arg_39_3 then
				arg_39_3(arg_40_0)
			end
		elseif arg_40_0.result == 2 then
			global_ShowBlockWords(L_ACCUMU_AWARD_YET)
		elseif arg_40_0.result == 3 then
			global_ShowBlockWords(L_SIGN_ILLEGAL)
		elseif arg_40_0.result == 4 then
			global_ShowBlockWords(L_ACCUMU_SIGN_UNREADY)
		end
	end)
end

function var_0_0.getAccuAwardDropDetail(arg_41_0, arg_41_1, arg_41_2)
	return (drop_manager:getDropMsg(sign_accumulate_data[arg_41_1]["dropid_" .. arg_41_2]))
end

function var_0_0.getSignRedDot(arg_42_0, arg_42_1)
	network:rpc("get_sign_time_new", nil, function(arg_43_0)
		arg_42_0.SignAccuAward = arg_43_0.signaccuaward

		if arg_42_1 then
			arg_42_1(arg_43_0.iscansign or arg_42_0:isAccuAwardsRedDot(arg_43_0.signtotal))
		end
	end)
end

function var_0_0.checkSignType(arg_44_0, arg_44_1)
	network:rpc("get_sign_type", nil, function(arg_45_0)
		print("$$$$$$$$$$$$$$$$$$$", dump(arg_45_0))

		if arg_45_0.result == 1 then
			if arg_44_1 then
				arg_44_1(arg_45_0.isSignTypeNew)
			end
		end
	end)
end

function var_0_0:isAccuAwardsRedDot(arg_46_1)
	local var_46_0 = self:getTime(time_check_manager:getCurTime())
	local var_46_1 = false

	for iter_46_0 = 1, sign_accumulate_data[var_46_0.month].accumulateAll do
		if arg_46_1 < sign_accumulate_data[var_46_0.month]["needs_" .. iter_46_0] then
			break
		end

		if self.SignAccuAward[iter_46_0] then
			var_46_1 = false
		else
			var_46_1 = true

			break
		end
	end

	return var_46_1
end

return var_0_0
