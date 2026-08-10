local var_0_0 = require("cjson")
local var_0_1 = {
	IsSDK = function()
		return GameToSDK.CURRENT_SDK_ID ~= SDK_PLATFORM.DEV
	end,
	ToJsonFormat = function(arg_2_0)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in pairs(arg_2_0) do
			var_2_0[iter_2_0] = iter_2_1
		end

		return var_0_0.encode(var_2_0)
	end
}

function var_0_1.SendPaymentMessageToSDK(arg_3_0, arg_3_1)
	var_0_1.SendMessageToSDK(arg_3_0, arg_3_1)

	var_0_1.paying = true
end

function var_0_1.OnMainHomeViewTop()
	if var_0_1.paying then
		var_0_1.paying = false

		var_0_1.SendMessageToSDK("payment_touch", {
			payment_return = gameContext.routes_[#gameContext.routes_]
		})
	end
end

function var_0_1.SendMessageToSDK(arg_5_0, arg_5_1)
	SDKAction.SendMessageToSDK(arg_5_0, arg_5_1)
end

function var_0_1.JsonEncode(arg_6_0)
	return var_0_0.encode(arg_6_0)
end

function var_0_1.SetPublicAttribute(arg_7_0)
	local var_7_0 = {
		messageType = "SetPublicAttribute"
	}

	for iter_7_0, iter_7_1 in pairs(arg_7_0) do
		var_7_0[iter_7_0] = iter_7_1
	end

	local var_7_1 = var_0_0.encode(var_7_0)

	SendMessageToSDK(var_7_1)
end

function var_0_1.SetDefaultPublicAttribute()
	local var_8_0 = PlayerData:GetPlayerInfo()
	local var_8_1 = _G.deviceInfo or {}
	local var_8_2 = {
		messageType = "SetPublicAttribute",
		user_name = var_8_0.nick,
		level = var_8_0.userLevel,
		client_vs = tostring(LuaForUtil.GetClientVersion()),
		pay_money = RechargeData:GetTotalRechargeNum() * 100,
		insider_state = RechargeData:GetMonthCardLastDay(),
		total_flower = CurrencyData:GetRechargeDiamond(),
		free_flower = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE),
		dundun = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY),
		gold_coin = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD),
		diamond = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND),
		resource_vs = LuaForUtil.GetResourceVersion()
	}

	if GameToSDK.PLATFORM_ID == 1 then
		var_8_2.idfa = tostring(var_8_1.idfa)
		var_8_2.ios_flower = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS)
	else
		var_8_2.oaid = tostring(var_8_1.oaid)
		var_8_2.mac = tostring(var_8_1.mac)
		var_8_2.imei = tostring(var_8_1.imei)
		var_8_2.android_flower = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS)
	end

	local var_8_3 = var_0_0.encode(var_8_2)

	SendMessageToSDK(var_8_3)
end

function var_0_1.SetCurrencyPublicAttribute(arg_9_0)
	local var_9_0 = {
		messageType = "SetPublicAttribute"
	}

	if arg_9_0 == CurrencyConst.CURRENCY_TYPE_VITALITY then
		var_9_0.dundun = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	elseif arg_9_0 == CurrencyConst.CURRENCY_TYPE_GOLD then
		var_9_0.gold_coin = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
	elseif arg_9_0 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
		var_9_0.diamond = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
	elseif arg_9_0 == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
		var_9_0.free_flower = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE)
		var_9_0.total_flower = var_9_0.free_flower + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS) + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS)
		var_9_0.ios_flower = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS)
		var_9_0.android_flower = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS)
	end

	local var_9_1 = var_0_0.encode(var_9_0)

	SendMessageToSDK(var_9_1)
end

function var_0_1.SetRechargePublicAttribute()
	local var_10_0 = {
		messageType = "SetPublicAttribute",
		pay_money = RechargeData:GetTotalRechargeNum() * 100,
		insider_state = RechargeData:GetMonthCardLastDay()
	}
	local var_10_1 = var_0_0.encode(var_10_0)

	SendMessageToSDK(var_10_1)
end

local var_0_2 = "EVENT_SIGN_IN"
local var_0_3 = "EVENT_SIGN_OUT"

function var_0_1.SetSignInAttribute()
	if var_0_1.GetIsOverSea() then
		return
	end

	local var_11_0 = PlayerData:GetPlayerInfo()
	local var_11_1 = {
		messageType = "SubmitEvent",
		eventId = var_0_2,
		KEY_USER_ID = var_11_0.userID
	}
	local var_11_2 = var_0_0.encode(var_11_1)

	SendMessageToSDK(var_11_2)
end

function var_0_1.SetSignOutAttribute()
	if var_0_1.GetIsOverSea() then
		return
	end

	local var_12_0 = PlayerData:GetPlayerInfo()
	local var_12_1 = {
		messageType = "SubmitEvent",
		eventId = var_0_3,
		KEY_USER_ID = var_12_0.userID
	}
	local var_12_2 = var_0_0.encode(var_12_1)

	SendMessageToSDK(var_12_2)
end

function var_0_1.SetBaseAttribute(arg_13_0)
	if not var_0_1.GetIsOverSea() then
		return
	end

	local var_13_0 = {
		user_id = PlayerData:GetPlayerInfo().userID,
		time = manager.time:GetServerTime()
	}
	local var_13_1 = {
		messageType = "SubmitEvent",
		eventId = arg_13_0
	}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		var_13_1[iter_13_0] = iter_13_1
	end

	local var_13_2 = var_0_0.encode(var_13_1)

	SendMessageToSDK(var_13_2)
end

function var_0_1.SetParamsAttribute(arg_14_0, arg_14_1)
	if not var_0_1.GetIsOverSea() then
		return
	end

	local var_14_0 = {
		messageType = "SubmitEvent",
		eventId = arg_14_0
	}

	if arg_14_1 then
		for iter_14_0, iter_14_1 in pairs(arg_14_1) do
			var_14_0[iter_14_0] = iter_14_1
		end
	end

	local var_14_1 = var_0_0.encode(var_14_0)

	SendMessageToSDK(var_14_1)
end

function var_0_1.ShareWithCallback(arg_15_0, arg_15_1)
	var_0_1.shareCallback_ = arg_15_1

	local var_15_0 = {
		messageType = "Share",
		url = arg_15_0.url,
		title = arg_15_0.title,
		content = arg_15_0.content,
		imagePath = arg_15_0.imagePath,
		imageUrl = arg_15_0.imageUrl
	}
	local var_15_1 = var_0_0.encode(var_15_0)

	SendMessageToSDKWithCallBack(var_15_1, "shareCallback", function(arg_16_0)
		if arg_16_0 == nil then
			arg_15_1(arg_15_0.platform, {
				code = {
					result = 1
				}
			})

			return
		end

		local var_16_0 = arg_16_0.platform

		arg_15_1(var_16_0, arg_16_0)
	end)
end

function var_0_1.ShareWithPlatformCallback(arg_17_0, arg_17_1)
	var_0_1.shareCallback_ = arg_17_1

	local var_17_0 = {
		messageType = "ShareWithPlatform",
		platform = arg_17_0.platform,
		url = arg_17_0.url,
		title = arg_17_0.title,
		content = arg_17_0.content,
		imagePath = arg_17_0.imagePath,
		imageUrl = arg_17_0.imageUrl
	}
	local var_17_1 = var_0_0.encode(var_17_0)

	SendMessageToSDKWithCallBack(var_17_1, "shareCallback", function(arg_18_0)
		if arg_18_0 == nil then
			arg_17_1(arg_17_0.platform, {
				code = {
					result = 1
				}
			})

			return
		end

		local var_18_0 = arg_18_0.platform

		arg_17_1(var_18_0, arg_18_0)
	end)
end

function var_0_1.PlatformStrToId(arg_19_0)
	return ({
		SinaWeibo = 4,
		QZone = 2,
		Wechat = 3,
		WechatMoments = 5,
		QQ = 1
	})[arg_19_0]
end

function var_0_1.GetIsArea(arg_20_0)
	return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER ~= arg_20_0
end

function var_0_1.GetIsOverSea()
	return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER ~= "zh_cn"
end

function var_0_1.GetIsJapan()
	return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER == "jp"
end

function var_0_1.GetIsEnglish()
	return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER == "en"
end

function var_0_1.GetIsInputServer(arg_24_0)
	return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER == arg_24_0
end

function var_0_1.GetIsKorea()
	return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER == "kr"
end

function var_0_1.GetIsTw()
	return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and GameToSDK.CURRENT_SERVER == "tw"
end

function var_0_1.GetIsThisServer(arg_27_0)
	return GameToSDK.CURRENT_SERVER and GameToSDK.CURRENT_SERVER ~= "" and table.indexof(arg_27_0, GameToSDK.CURRENT_SERVER)
end

return var_0_1
