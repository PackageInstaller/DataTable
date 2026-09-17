local var_0_0 = {}
local network = require("network.network")
local net_dispatcher = require("network.net_dispatcher")
local playermodel = require("model.playermodel")
local recharge_data = require("data.recharge_data")
local item_data = require("data.item_data")
local shop_timelimit_data = require("data.shop.shop_timelimit_data")
local time_check_manager = require("controller.time_check_manager")

require("view.Sprite.ConfirmDialogSprite")
require("view.Layer.PopLayer")

local net_waitinglayer = require("network.net_waitinglayer")

var_0_0.formalert = false
RECHARGE_TYPE_BATTLE_PASS = 12

function var_0_0:init(arg_1_1)
	self:check_uncomplete_forms(arg_1_1)
	self:init_form_purchase_listener()
end

function var_0_0.check_uncomplete_forms(arg_2_0, arg_2_1)
	network:rpc("check_uncomplete_form", nil, function(arg_3_0)
		if arg_3_0.result == 1 then
			arg_2_0.formalert = true

			if arg_2_1 then
				arg_2_1()
			end
		elseif arg_3_0.result == 2 and arg_2_1 then
			arg_2_1()
		end
	end)
end

function var_0_0.init_form_purchase_listener(arg_4_0)
	net_dispatcher:registerListener(function(arg_5_0)
		arg_4_0:popPurchaseResult(arg_5_0)
	end, "purchase_success")
	net_dispatcher:registerListener(function(arg_6_0)
		local var_6_0 = require("controller.supermarket_privilege_manager"):getInstance()

		var_6_0:removePurchaseWaitingLayer()
		var_6_0:stateUpdate(arg_6_0)
	end, "subscribe_status_change")
end

function var_0_0.getRechargeInfo(arg_7_0, arg_7_1)
	network:rpc("get_recharge_info", {
		client = config.clientmode
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			local var_8_0 = {}

			for iter_8_0, iter_8_1 in pairs(arg_8_0.products) do
				if recharge_data[iter_8_1.id] then
					table.insert(var_8_0, iter_8_1)
				end
			end

			if arg_7_1 then
				arg_7_1(1, var_8_0, arg_8_0.orderList)
			end
		elseif arg_8_0.result == 2 then
			global_riseWord(L_RECHARGE_GET_INFO[2])

			if arg_7_1 then
				arg_7_1(2)
			end
		elseif arg_8_0.result == 3 then
			global_riseWord(L_RECHARGE_GET_INFO[3])

			if arg_7_1 then
				arg_7_1(3)
			end
		elseif arg_7_1 then
			arg_7_1(0)
		end
	end)
end

local function var_0_9()
	net_waitinglayer.addPurchaseWaitingLayer()
end

local function var_0_10()
	net_waitinglayer.removeWaitingLayer()
end

function var_0_0.doPayment(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	print("doPayment: ", arg_11_1, arg_11_2, arg_11_3)

	local function var_11_0(arg_12_0, arg_12_1)
		print("purchase result: ", arg_12_0, arg_12_1)

		if arg_12_0 == "ok" then
			var_0_9()
		else
			print(arg_12_0)
		end
	end

	local var_11_1 = DeviceManager.createHTTPRequest(function(arg_13_0)
		local var_13_0 = arg_13_0.request

		if arg_13_0.name ~= "completed" then
			return
		end

		if var_13_0:getResponseStatusCode() ~= 200 then
			global_ShowBlockWords(L_RECHARGE_RESPONSE[200])

			return
		end

		local var_13_1 = json.decode((var_13_0:getResponseString()))

		var_11_0(var_13_1.msg, var_13_1.formid)
	end, arg_11_3, "POST")

	var_11_1:setPOSTData(json.encode({
		channel = "999999",
		productid = arg_11_1,
		playerid = playermodel.playerid,
		ammount = recharge_data[arg_11_1].rmb
	}))
	var_11_1:start()
end

function var_0_0.requestOrderSign(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = recharge_data[arg_14_1].diamond or 1

	print("Request Order Sign: ", arg_14_1, recharge_data[arg_14_1].productid, recharge_data[arg_14_1].rmb * 100)
	network:rpc("purchase_order_sign", {
		platform = DeviceManager.getChannelID(),
		productid = recharge_data[arg_14_1].productid,
		money = recharge_data[arg_14_1].rmb * 100,
		game_money = var_14_0
	}, function(arg_15_0)
		if arg_15_0.result == 1 and arg_14_2 then
			arg_14_2(arg_15_0.outTradeNo, arg_15_0.notifyURL)
		end
	end)
end

function var_0_0.runConfirmPayment(arg_16_0, arg_16_1)
	LayerManager:pushInLayer("PopDoLayer", {
		surecallback = function()
			arg_16_0:requestOrderSign(arg_16_1, function(arg_18_0, arg_18_1)
				arg_16_0:doPayment(arg_16_1, arg_18_0, arg_18_1)
			end)
		end,
		labels = {
			titleImage = "title_recharge.png",
			des = string.format(L_RECHARGE_SURE_BACK.Des, recharge_data[arg_16_1].name)
		}
	})
end

function var_0_0:confirmPayment(arg_19_1)
	if arg_19_1 == 1 or arg_19_1 == 90 or arg_19_1 == 365 then
		global_ShowBlockWords("商品无法购买")

		if callback then
			callback(0)
		end

		return
	end

	if self:needCheckHuaweiPrivacy() then
		global_basic_scene:addChild(require("view.Layer.PrivacyPurchaseLayer"):create(function()
			self:runConfirmPayment(arg_19_1)
		end, function()
			return
		end), 999)
	else
		self:runConfirmPayment(arg_19_1)
	end
end

function var_0_0.needCheckHuaweiPrivacy(arg_22_0)
	if config.packagechannel ~= "feiyu" then
		return false
	end

	if accountManager:getChannel() ~= "270054" then
		return false
	end

	if not FySDK.showPrivacyDialog then
		return false
	end

	return not cc.UserDefault:getInstance():getBoolForKey("agreehuaweipurchase", false)
end

function var_0_0.popPurchaseResult(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.remain
	local var_23_1 = 0

	if arg_23_1.diamond and arg_23_1.diamond > 0 then
		playermodel.diamond = playermodel.diamond + arg_23_1.diamond
		var_23_1 = var_23_1 + arg_23_1.diamond
	end

	if arg_23_1.extradiamond and arg_23_1.extradiamond > 0 then
		playermodel.diamond = playermodel.diamond + arg_23_1.extradiamond
		var_23_1 = var_23_1 + arg_23_1.extradiamond
	end

	if arg_23_1.gold and arg_23_1.gold > 0 then
		playermodel.gold = playermodel.gold + arg_23_1.gold
	end

	if arg_23_1.sp and arg_23_1.sp > 0 then
		playermodel.strengthpoint = playermodel.strengthpoint + arg_23_1.sp

		GlobalUpdateSp()
	end

	local var_23_2

	if arg_23_1.items then
		var_23_2 = {}

		local item_manager = require("controller.item_manager")

		for iter_23_0, iter_23_1 in pairs(arg_23_1.items) do
			local var_23_4 = item_manager:setItemByServerItem(iter_23_1)

			if item_data[iter_23_1.itemid].unshowpur == nil then
				table.insert(var_23_2, {
					entityid = iter_23_1.entityid,
					itemid = iter_23_1.itemid,
					dropNum = (iter_23_1.itemid == CURRENCY_DIAMOND_PAID and arg_23_1.paiddiamond and arg_23_1.paiddiamond > 0 or nil) and arg_23_1.paiddiamond,
					horcrux_attr = iter_23_1.horcrux_attr
				})
			end
		end
	end

	global_update_gold_stone_diamond(arg_23_1.gold, nil, var_23_1)

	local var_23_5 = {
		id = arg_23_1.product,
		name = recharge_data[arg_23_1.product].name,
		diamond = arg_23_1.diamond,
		extradiamond = arg_23_1.extradiamond,
		remain = var_23_0,
		gold = arg_23_1.gold,
		sp = arg_23_1.sp,
		items = var_23_2
	}

	if global_basic_scene and (var_23_5.items and next(var_23_5.items) or var_23_5.gold or var_23_5.diamond) then
		var_23_5.openType = var_23_5.items == nil and 2 or 1

		LayerManager:pushInLayer("PopPurchaseResultLayer", var_23_5)
	elseif recharge_data[arg_23_1.product].type == require("controller.supermarket_privilege_recharge_manager"):getInstance().SHOP_TYPE then
		LayerManager:pushInLayer("PrivilegeSuccessTipsLayer")
	else
		global_ShowBlockWords("购买" .. recharge_data[arg_23_1.product].name .. "成功")
	end

	playermodel.haverecharge = true
	playermodel.rechargeamount = playermodel.rechargeamount + recharge_data[arg_23_1.product].rmb
	playermodel.rechargeamountxinxiya = playermodel.rechargeamountxinxiya + recharge_data[arg_23_1.product].rmb

	local var_23_6 = cc.EventCustom:new("purchase_success")

	var_23_6.id = arg_23_1.product
	var_23_6.remain = var_23_0

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_23_6)
	var_0_10()

	playermodel.rechargecount = playermodel.rechargecount + 1

	AnalyticManager.purchaseSuccess({
		product = arg_23_1.product
	})

	local level_manager = require("controller.level_manager")

	if recharge_data[arg_23_1.product].type == 1 then
		AnalyticManager.onPurchaseSuccess(arg_23_1.product, {
			purchasecount = playermodel.rechargecount,
			purchaseamount = playermodel.rechargeamount,
			rolenum = playermodel:getOwnedServantNum(),
			grade = playermodel.grade,
			class = playermodel.class,
			level = level_manager:getCurFightChapter(),
			firstpurchase = var_23_1 == recharge_data[arg_23_1.product].first_award
		})
	else
		AnalyticManager.onPurchaseSuccess(arg_23_1.product, {
			purchasecount = playermodel.rechargecount,
			purchaseamount = playermodel.rechargeamount,
			rolenum = playermodel:getOwnedServantNum(),
			grade = playermodel.grade,
			class = playermodel.class,
			level = level_manager:getCurFightChapter()
		})
	end
end

function var_0_0.checkalert(arg_24_0)
	if var_0_0.formalert then
		cc.Director:getInstance():getRunningScene():addChild(PopLayer:PurchaseAlert(), 10004)

		var_0_0.formalert = false
	end
end

function var_0_0:updateShopLimitAlertData(arg_25_1)
	if not arg_25_1 then
		print("????????????大兄弟你数据没传")

		return
	end

	self.shopLimitAlert = self.shopLimitAlert or {}

	if not self.cacheProductsData then
		self.cacheProductsData = self:intersectRecharge(arg_25_1)

		self:updateRechargeCacheData(self.cacheProductsData)
	else
		local var_25_0 = self:intersectRecharge(arg_25_1)

		if not self:compareWithCache(var_25_0) then
			self:updateRechargeCacheData(var_25_0)

			self.cacheProductsData = var_25_0
		end
	end
end

function var_0_0.intersectRecharge(arg_26_0, arg_26_1)
	local var_26_0 = {}
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in pairs(shop_timelimit_data) do
		if iter_26_1.rechargeid then
			iter_26_1.price = recharge_data[iter_26_1.rechargeid].rmb
		end

		table.insert(var_26_1, iter_26_1)
	end

	local var_26_2 = {}

	if var_26_1 and next(var_26_1) then
		for iter_26_2, iter_26_3 in pairs(var_26_1) do
			local var_26_3 = {}

			if iter_26_3.showchannel then
				for iter_26_4, iter_26_5 in pairs(split(iter_26_3.showchannel, ",")) do
					table.insert(var_26_3, iter_26_5)
				end
			end

			local account_manager = require("controller.account_manager")

			if (not next(var_26_3) or var_26_3[account_manager:getChannel()] or account_manager:getChannel() == "palmpi") and iter_26_3.order and arg_26_1[iter_26_3.rechargeid] then
				iter_26_3.have_bought = arg_26_1[iter_26_3.rechargeid].have_bought
				iter_26_3.buy_limit = arg_26_1[iter_26_3.rechargeid].buy_limit
				iter_26_3.new_tag = arg_26_1[iter_26_3.rechargeid].new_tag
				var_26_2[iter_26_2] = iter_26_3
				var_26_0[iter_26_3.group] = var_26_0[iter_26_3.group] or {}

				table.insert(var_26_0[iter_26_3.group], iter_26_3)
			end
		end
	end

	return var_26_2, var_26_0
end

function var_0_0:compareWithCache(arg_27_1)
	for iter_27_0, iter_27_1 in pairs(arg_27_1) do
		if self.cacheProductsData[iter_27_0] then
			if iter_27_1.have_bought > self.cacheProductsData[iter_27_0].have_bought then
				return false
			end
		else
			return false
		end
	end

	return true
end

function var_0_0:updateRechargeCacheData(arg_28_1)
	if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():getWritablePath() .. "recharge_alert_cache_data" .. playermodel.playerid .. ".txt") then
		local var_28_0 = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath() .. "recharge_alert_cache_data" .. playermodel.playerid .. ".txt")

		if var_28_0 == "nil" then
			local var_28_1 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. "recharge_alert_cache_data" .. playermodel.playerid .. ".txt", "w+"))

			var_28_1:write((json.encode((self:formatRechargeCacheData(arg_28_1)))))
			var_28_1:flush()
			var_28_1:close()
		else
			local var_28_2 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. "recharge_alert_cache_data" .. playermodel.playerid .. ".txt", "w+"))

			var_28_2:write((json.encode((self:formatRechargeCacheData(arg_28_1, (json.decode(var_28_0)))))))
			var_28_2:flush()
			var_28_2:close()
		end
	else
		local var_28_3 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. "recharge_alert_cache_data" .. playermodel.playerid .. ".txt", "w+"))

		var_28_3:write((json.encode((self:formatRechargeCacheData(arg_28_1)))))
		var_28_3:flush()
		var_28_3:close()
	end
end

function var_0_0:formatRechargeCacheData(arg_29_1, arg_29_2)
	local var_29_0 = {}
	local var_29_1 = {}
	local var_29_2 = arg_29_2 and arg_29_2["id" .. playermodel.playerid]

	if arg_29_2 and arg_29_2["id" .. playermodel.playerid] then
		for iter_29_0, iter_29_1 in pairs(arg_29_1) do
			local var_29_3

			if not var_29_2["shop_" .. iter_29_1.id] then
				var_29_3 = 2
			else
				if var_29_2["shop_" .. iter_29_1.id].alert then
					var_29_3 = var_29_2["shop_" .. iter_29_1.id].alert
				end

				if iter_29_1.new_tag and iter_29_1.new_tag == 1 then
					var_29_3 = var_29_3 and var_29_3 > 1 and var_29_3 or 1
				end

				if shop_timelimit_data[iter_29_1.id] and shop_timelimit_data[iter_29_1.id].end_alert_time then
					local var_29_4 = time_check_manager:getCurTime()

					if var_29_4 > global_get_time_by_date(shop_timelimit_data[iter_29_1.id].end_alert_time) and not global_check_same_day(var_29_4, var_29_2["shop_" .. iter_29_1.id].click_time) then
						var_29_3 = 3
					end
				end
			end

			iter_29_1.alert = var_29_3

			local var_29_5 = {
				alert = var_29_3,
				have_bought = iter_29_1.have_bought
			}

			var_29_5.click_time = var_29_2["shop_" .. iter_29_1.id] and var_29_2["shop_" .. iter_29_1.id].click_time
			var_29_5.group = shop_timelimit_data[iter_29_1.id].group
			var_29_1["shop_" .. iter_29_1.id] = var_29_5
		end
	else
		for iter_29_2, iter_29_3 in pairs(arg_29_1) do
			local var_29_6

			if shop_timelimit_data[iter_29_3.id] and shop_timelimit_data[iter_29_3.id].end_alert_time and time_check_manager:getCurTime() > global_get_time_by_date(shop_timelimit_data[iter_29_3.id].end_alert_time) then
				var_29_6 = 3
			end

			var_29_6 = var_29_6 and var_29_6 > 2 and var_29_6 or 2
			iter_29_3.alert = var_29_6
			var_29_1["shop_" .. iter_29_3.id] = {
				alert = var_29_6,
				have_bought = iter_29_3.have_bought
			}
		end
	end

	self:formatAlertData(var_29_1)

	var_29_0["id" .. playermodel.playerid] = var_29_1

	return var_29_0
end

function var_0_0:formatAlertData(arg_30_1)
	local var_30_0 = {
		{},
		{},
		{}
	}
	local var_30_1 = {}

	for iter_30_0, iter_30_1 in pairs(arg_30_1) do
		if iter_30_1.alert then
			local var_30_2 = tonumber(split(iter_30_0, "_")[2])
			local var_30_3 = shop_timelimit_data[var_30_2] and shop_timelimit_data[var_30_2].group

			if var_30_3 and not var_30_1[var_30_3] then
				table.insert(var_30_0[iter_30_1.alert], var_30_3)

				var_30_1[var_30_3] = true
			end
		end
	end

	self:setShopLimitAlertData(var_30_0)
	print("alert =========", dump(var_30_0))
end

function var_0_0.deletAlertInCache(arg_31_0, arg_31_1, arg_31_2)
	if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():getWritablePath() .. "recharge_alert_cache_data" .. playermodel.playerid .. ".txt") then
		local var_31_0 = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath() .. "recharge_alert_cache_data" .. playermodel.playerid .. ".txt")

		if var_31_0 == "nil" then
			print("Error:recharge_alert_cache_data.txt doesn't exist")

			return
		else
			local var_31_1 = json.decode(var_31_0)

			for iter_31_0, iter_31_1 in pairs(var_31_1["id" .. playermodel.playerid]) do
				if iter_31_1.group and iter_31_1.group == arg_31_1 then
					if iter_31_1.alert then
						iter_31_1.alert = nil
					end

					iter_31_1.click_time = arg_31_2
				end
			end

			arg_31_0.cacheProductsData = var_31_1["id" .. playermodel.playerid]

			local var_31_2 = cc.FileUtils:getInstance()
			local var_31_3 = assert(io.open(var_31_2:getWritablePath() .. "recharge_alert_cache_data" .. playermodel.playerid .. ".txt", "w+"))

			var_31_3.write(var_31_2, (json.encode(var_31_1)))
			var_31_3:flush()
			var_31_3:close()
		end
	else
		print("Error:recharge_alert_cache_data.txt doesn't exist")

		return
	end
end

function var_0_0.setShopLimitAlertData(arg_32_0, arg_32_1)
	arg_32_0.shopLimitAlert = arg_32_1
end

function var_0_0:getShopLimitAlertData()
	return self.shopLimitAlert
end

function var_0_0.getCommodityPriceStr(arg_34_0, arg_34_1)
	local var_34_0 = DeviceManager:getCurCity()

	return CITY_CURRENCY_LIST[var_34_0] .. (recharge_data[arg_34_1][CITY_KEY_LIST[var_34_0]] or "")
end

return var_0_0
