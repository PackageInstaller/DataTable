local var_0_0 = 1
local var_0_1 = 2
local var_0_3 = 4
local var_0_4 = 6
local activity_conf_data = require("data.activity_conf_data")
local activity_img_data = require("data.activity_img_data")
local activity_sign_data = require("data.activity_sign_data")
local activity_sign_conf = require("data.activity_modules.activity_sign_conf")
local network = require("network.network")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local recharge_manager = require("controller.recharge_manager")
local var_0_14 = 0
local var_0_15 = 0
local var_0_16 = 1

function ACTIVITY_OBJ_NEW.initModulesign(arg_1_0, arg_1_1)
	arg_1_0._status = arg_1_1.status
	arg_1_0._signstarttime = arg_1_1.starttime
	arg_1_0._signfinishtime = arg_1_1.finishtime
end

function ACTIVITY_OBJ_NEW:getSignType()
	return self._signtype or activity_sign_conf[self._id].signtype
end

function ACTIVITY_OBJ_NEW:getSignVersion()
	return self._signVersion
end

function ACTIVITY_OBJ_NEW:getActivitySign(arg_4_1)
	if not self:isHaveModule("sign") then
		if arg_4_1 then
			arg_4_1(0)
		end

		return
	end

	if self._status ~= ACTIVITY_ACTIVING then
		if arg_4_1 then
			arg_4_1(2)
		end

		return
	end

	network:rpc("get_activity_sign", {
		id = self._id
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			self._signtype = arg_5_0.signtype
			self._signVersion = arg_5_0.version

			if self._signtype == var_0_0 then
				local var_5_0 = 0
				local var_5_1 = {}
				local var_5_2 = {}
				local var_5_3 = self._id .. "-" .. var_5_0 + 1

				if arg_5_0.version > 1 then
					var_5_3 = string.format("%d-%d-%d", self._id, arg_5_0.version, var_5_0 + 1)
				end

				while activity_sign_data[var_5_3] do
					var_5_0 = var_5_0 + 1

					table.insert(var_5_2, activity_sign_data[var_5_3].dropid)

					var_5_3 = self._id .. "-" .. var_5_0 + 1

					if arg_5_0.version > 1 then
						var_5_3 = string.format("%d-%d-%d", self._id, arg_5_0.version, var_5_0 + 1)
					end
				end

				for iter_5_0 = 1, var_5_0 do
					table.insert(var_5_1, iter_5_0 <= arg_5_0.loginsign.sign)
				end

				if arg_4_1 then
					arg_4_1(1, var_5_1, arg_5_0.cansign, {}, arg_5_0.loginsign.sign, var_5_2)
				end
			elseif self._signtype == var_0_1 then
				if arg_4_1 then
					arg_4_1(1, arg_5_0.timingsign.signstats, arg_5_0.cansign, arg_5_0.timingsign.signdate)
				end
			elseif self._signtype == var_0_3 or self._signtype == var_0_4 then
				local activity_manager = require("controller.activity_manager")

				activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_BP_SIGN_DATA_UPDATE, arg_5_0.bpsign)
			end
		elseif arg_4_1 then
			arg_4_1(arg_5_0.result)
		end
	end)
end

local function var_0_20()
	local var_6_0 = math.floor(require("model.playermodel").rechargeamountTGV / 100)
	local var_6_1 = math.min(var_6_0, 20)
	local var_6_2 = {}

	for iter_6_0 = 1, var_6_1 do
		if iter_6_0 == var_6_1 then
			table.insert(var_6_2, var_6_0 - math.floor(var_6_0 / var_6_1) * (var_6_1 - 1))
		else
			table.insert(var_6_2, math.floor(var_6_0 / var_6_1))
		end
	end

	return var_6_2
end

local function var_0_21(arg_7_0)
	local var_7_0 = {}

	for iter_7_0 = 1, math.min(math.floor(require("model.playermodel").rechargeamountTGV / 100), 20) do
		table.insert(var_7_0, arg_7_0[iter_7_0])
	end

	return var_7_0
end

function ACTIVITY_OBJ_NEW:getActivitySignData(arg_8_1)
	local var_8_0 = {
		otherData = (function()
			local var_9_0 = {
				drops = {}
			}

			for iter_9_0, iter_9_1 in pairs(activity_sign_data) do
				local var_9_1, var_9_2 = string.match(iter_9_0, "(%d+)-(%d+)")
				local var_9_3 = tonumber(var_9_1)

				if var_9_3 and var_9_3 == self._id then
					var_9_0.drops[tonumber(var_9_2)] = iter_9_1.dropid
				end
			end

			var_9_0.startTime = activity_conf_data[self._id].starttime
			var_9_0.endTime = activity_conf_data[self._id].finishtime

			return var_9_0
		end)()
	}

	self:getActivitySign(function(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
		if arg_10_0 == 1 then
			var_8_0.signstats = arg_10_1
			var_8_0.signdate = arg_10_3
			var_8_0.cansign = arg_10_2
			var_8_0.otherData.drops = arg_10_5 or var_8_0.otherData.drops

			function var_8_0.activitySingCallback(arg_11_0, arg_11_1)
				self:activitySign(arg_11_0, function(arg_12_0)
					if arg_12_0 == 1 then
						require("controller.activity_manager"):updateActivityAlert("sign", self._id, false)
					elseif arg_12_0 == 0 then
						global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[1][0])
					elseif arg_12_0 == 2 then
						global_ShowBlockWords(L_ACTIVITY_END)
					elseif arg_12_0 == 3 then
						global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[1][3])
					elseif arg_12_0 == 4 then
						global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[1][4])
					elseif arg_12_0 == 6 then
						global_ShowBlockWords(L_DIAMOND_LACK)
					end

					if arg_11_1 then
						arg_11_1(arg_12_0)
					end
				end)
			end

			if self._id == TGV_SIGN_ACTIVITYID then
				var_8_0.otherData.drops = var_0_20()
				var_8_0.signstats = var_0_21(arg_10_1)
			end

			if arg_8_1 then
				arg_8_1(var_8_0)
			end
		elseif arg_10_0 == 0 then
			global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[0])
		elseif arg_10_0 == 2 then
			global_ShowBlockWords(L_ACTIVITY_SIGN_STATE[2])
		else
			print("unknow error result: ", arg_10_0)
		end
	end)
end

local function var_0_22(arg_13_0, arg_13_1)
	if arg_13_0 == 0 then
		playermodel.diamond = playermodel.diamond - arg_13_1

		global_update_gold_stone_diamond(nil, nil, arg_13_1)
	elseif arg_13_0 == 1 then
		playermodel.gold = playermodel.gold - arg_13_1

		global_update_gold_stone_diamond(arg_13_1)
	elseif arg_13_0 == 2 then
		playermodel.honor = playermodel.honor - arg_13_1
	else
		item_manager:deleteItem(arg_13_0, arg_13_1)
	end
end

function ACTIVITY_OBJ_NEW:activitySign(...)
	local var_14_0
	local var_14_1
	local var_14_2 = {
		...
	}

	if #var_14_2 == 1 then
		var_14_1 = var_14_2[1]
	else
		var_14_1 = var_14_2[2]
		var_14_0 = var_14_2[1]
	end

	if not self:isHaveModule("sign") then
		if var_14_1 then
			var_14_1(0)
		end

		return
	end

	if self._status ~= ACTIVITY_ACTIVING then
		if var_14_1 then
			var_14_1(2)
		end

		return
	end

	network:rpc("activity_sign", {
		id = self._id,
		signid = var_14_0
	}, function(arg_15_0)
		if arg_15_0.result == 1 then
			if arg_15_0.gold then
				playermodel.gold = playermodel.gold + arg_15_0.gold
			end

			if arg_15_0.diamond then
				playermodel.diamond = playermodel.diamond + arg_15_0.diamond
			end

			if arg_15_0.items and #arg_15_0.items > 0 or arg_15_0.diamond then
				local var_15_0 = {
					items = arg_15_0.items,
					diamond = arg_15_0.diamond
				}

				for iter_15_0, iter_15_1 in ipairs(var_15_0.items) do
					var_15_0.items[iter_15_0].dropNum = item_manager:setItemByServerItem(iter_15_1)
				end

				LayerManager:pushInLayer("PopPurchaseResultLayer", var_15_0)
			end

			if arg_15_0.currencytype and arg_15_0.currencycost and arg_15_0.currencycost > 0 then
				var_0_22(arg_15_0.currencytype, arg_15_0.currencycost)
			end

			if arg_15_0.consumes then
				for iter_15_2, iter_15_3 in ipairs(arg_15_0.consumes) do
					item_manager:deleteItem(iter_15_3.entityid, iter_15_3.num)
				end
			end

			global_update_gold_stone_diamond(arg_15_0.gold, nil, item_manager:getItemNumber(var_0_14))

			if var_14_1 then
				var_14_1(1)
			end
		elseif var_14_1 then
			var_14_1(arg_15_0.result)
		end
	end)
end

function ACTIVITY_OBJ_NEW:isSignVip()
	return item_manager:isHaveEnoughItem(activity_sign_conf[self._id].vip_need)
end

function ACTIVITY_OBJ_NEW:getSignVipBuyReward()
	if not activity_sign_conf[self._id].vip_drop then
		return {}
	end

	return drop_manager:getAllDrops(activity_sign_conf[self._id].vip_drop)
end

function ACTIVITY_OBJ_NEW:buySignVip()
	if activity_sign_conf[self._id].vip_recharge then
		self:rechargeForSignVip(activity_sign_conf[self._id].vip_recharge)

		return
	end

	network:rpc("activity_sign_vip_buy", {
		activityid = self._id
	}, function(arg_19_0)
		if arg_19_0.result == 1 then
			global_get(arg_19_0)
			global_ShowBlockWords(L_TWISTEGG_LACK_OF_COST.Buy_Success)

			if arg_19_0.cost_diamond then
				item_manager:deleteItem(var_0_14, arg_19_0.cost_diamond)
			end

			if arg_19_0.consumes then
				for iter_19_0, iter_19_1 in ipairs(arg_19_0.consumes) do
					item_manager:deleteItem(iter_19_1.itemid, iter_19_1.num)
				end
			end

			global_update_gold_stone_diamond(arg_19_0.gold, arg_19_0.diamond, item_manager:getItemNumber(var_0_14))
			self:getActivitySignData()
		elseif arg_19_0.result == 4 then
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer",
				jumpto = jumpto
			})
		end
	end)
end

function ACTIVITY_OBJ_NEW.rechargeForSignVip(arg_20_0, arg_20_1)
	network:rpc("check_recharge", {
		id = arg_20_1,
		client = config.clientmode
	}, function(arg_21_0)
		if arg_21_0.result == 1 then
			arg_20_0.recharging = false

			AnalyticManager.clickPurchaseItem({
				product = arg_20_1,
				rolenum = playermodel:getOwnedServantNum(),
				grade = playermodel.grade,
				class = playermodel.class
			})
			recharge_manager:confirmPayment(arg_20_1)
		elseif arg_21_0.result == 2 then
			print("测试模式")
		elseif arg_21_0.result == 3 then
			global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
		elseif arg_21_0.result == 4 then
			global_ShowBlockWords(L_RECHARGE_OUT_TIME)
		elseif arg_21_0.result == 5 then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
		elseif arg_21_0.result == 6 then
			global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
		end
	end)
end

function ACTIVITY_OBJ_NEW:getSignDropByIndex(arg_22_1)
	return drop_manager:getAllDrops(activity_sign_data[self._id .. "-" .. arg_22_1].dropid)
end

function ACTIVITY_OBJ_NEW:getVipSignDropByIndex(arg_23_1)
	return drop_manager:getAllDrops(activity_sign_data[self._id .. "-" .. arg_23_1].sp_dropid)
end

function ACTIVITY_OBJ_NEW:activityBpSign(arg_24_1, arg_24_2)
	local function var_24_0()
		network:rpc("activity_sign", {
			id = self._id,
			signid = arg_24_1
		}, function(arg_26_0)
			if arg_26_0.result == 1 then
				global_gain(arg_26_0)

				if arg_26_0.currencytype and arg_26_0.currencycost and arg_26_0.currencycost > 0 then
					var_0_22(arg_26_0.currencytype, arg_26_0.currencycost)
				end

				if arg_26_0.consumes then
					for iter_26_0, iter_26_1 in ipairs(arg_26_0.consumes) do
						item_manager:deleteItem(iter_26_1.entityid, iter_26_1.num)
					end
				end

				global_update_gold_stone_diamond(arg_26_0.gold, nil, item_manager:getItemNumber(var_0_14))
				self:getActivitySignData()
			elseif arg_26_0.result == 6 then
				LayerManager:pushInLayer("PopGoBuyDiamond", {
					is_need_pop_layer = 1
				})

				return
			elseif arg_26_0.result == 3 then
				global_ShowBlockWords(L_ACTIVITY_SIGN_FINISH)
			elseif arg_26_0.result == 7 then
				global_ShowBlockWords(L_BP_SIGN[7])
			end
		end)
	end

	if arg_24_2 == var_0_15 then
		LayerManager:pushInLayer("PopDoLayer", {
			labels = {
				title = L_BP_SIGN[1],
				des = string.format(L_BP_SIGN[2], activity_sign_data[self._id .. "-" .. arg_24_1].supplementcost),
				button = L_BP_SIGN[3]
			},
			surecallback = var_24_0
		})
	elseif arg_24_2 == var_0_16 then
		LayerManager:pushInLayer("PopDoLayer", {
			labels = {
				title = L_BP_SIGN[4],
				des = L_BP_SIGN[5],
				button = L_BP_SIGN[6]
			},
			surecallback = var_24_0
		})
	else
		var_24_0()
	end
end
