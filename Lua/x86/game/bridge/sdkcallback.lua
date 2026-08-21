local var_0_0 = require("cjson")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4

function OnGameSdkCallback(arg_1_0)
	local var_1_0 = var_0_0.decode(arg_1_0) or {}
	local var_1_1 = var_1_0.callbackType

	print("OnGameSdkCallback messageType", var_1_1, var_1_0.code, table.toString(var_1_0))

	local var_1_2 = var_0_1[var_1_1]

	var_0_1[var_1_1] = nil

	if var_1_1 == "Login" then
		_G.LOGIN_TYPE = var_1_0.channelLoginType

		if tostring(var_1_0.channelLoginType) == "3" then
			_G.LOGIN_TYPE = 1
		else
			_G.LOGIN_TYPE = 0
		end

		_G.APP_ID = var_1_0.appId
		_G.YONGSHI_ID = var_1_0.id

		if Application.identifier == "com.biligamekr.agonestore" then
			_G.B_SDK_ID = 8266
		elseif GameToSDK.PLATFORM_ID == 0 then
			_G.B_SDK_ID = 8264
		elseif GameToSDK.PLATFORM_ID == 1 then
			_G.B_SDK_ID = 8265
		else
			_G.B_SDK_ID = 8264
		end

		print("Application.identifier", Application.identifier, var_1_0.channelLoginType)

		_G.CHANNEL_UDID = var_1_0.channelUdid
		_G.CHANNEL_USERID = var_1_0.channelUserId

		SDKTools.SetPublicAttribute({
			channel_id = var_1_0.channelId,
			yongshi_id = var_1_0.id
		})

		var_0_4 = var_1_0
		_G.CPUINFO = tostring(UnityEngine.SystemInfo.processorType .. "-" .. tostring(UnityEngine.SystemInfo.processorFrequency) .. "-" .. tostring(UnityEngine.SystemInfo.processorCount))
		_G.TMP_ACCOUNT_ID = tostring(var_0_4.id)

		local var_1_3 = "Not Reachable"

		if Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
			var_1_3 = "WIFI"
		elseif Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
			var_1_3 = "4G/5G"
		end

		_G.NETTYPE = var_1_3

		SendMessageManagerToSDK("SDKLoginSuccess")

		local var_1_4 = gameContext:GetOpenPageHandler("login")

		if var_1_4 then
			var_1_4:SetSDKId()
		end
	elseif var_1_1 == "Inited" then
		SDKInited()
	elseif var_1_1 == "ReLogin" then
		SDKTools.SetSignOutAttribute()
		ReconnectLogic.ReconnectError()

		var_0_4 = nil

		manager.notify:CallUpdateFunc(LOGIN_SEVER_UPDATE)
	elseif var_1_1 == "Exit" then
		Quit()
	elseif var_1_1 == "AntiAddiction" then
		AntiAddiction(var_1_0)
	elseif var_1_1 == "ShowQuitConfirm" then
		ShowQuitConfirm()
	elseif var_1_1 == "GetBulletin" then
		GetBulletin(var_1_0)
	elseif var_1_1 == "DeviceInfoGet" then
		DeviceInfoGet(var_1_0)
	elseif var_1_1 == "UpdateInfoGet" then
		UpdateInfoGet(var_1_0.info1, var_1_0.info2)
	elseif var_1_1 == "NeedGameUserInfo" then
		NeedGameUserInfo()
	elseif var_1_1 == "ReceivePushNotification" then
		ReceivePushNotification(var_1_0.message)
	elseif var_1_1 == "MarketCommentsNoSupport" then
		MarketCommentsNoSupport(var_1_0)
	elseif var_1_1 == "ChannelLoginInfoGet" then
		ChannelLoginInfoGet(var_1_0)
	elseif var_1_1 == "payResult" then
		manager.notify:Invoke(RECHARGE_SDK_SUCCESS)
	elseif var_1_1 == "payFailed" then
		local var_1_5 = var_1_0.errorMsg or var_1_0.info1 or ""

		ShowTips(var_1_5)
		print(string.format("充值失败， errorMsg = %s", var_1_5))
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_stop = gameContext.routes_[#gameContext.routes_]
		})
		manager.notify:Invoke(RECHARGE_FAILED, var_1_5)
	elseif var_1_1 == "LoginFailed" then
		_G.clickCDing_ = false
		_G.isLogining = false

		local var_1_6 = var_1_0.message or ""

		ShowTips(var_1_6)
		print(string.format("Login Failed, messager = %s", var_1_6))

		var_0_4 = nil

		SendMessageManagerToSDK("SDKLoginFailed")
	elseif var_1_1 == "CustomerServiceUnreadMsg" then
		local var_1_7 = var_1_0.num or 0

		print(string.format("CustomerServiceUnreadMsg, callbackInfo.num = %s", tostring(var_1_7)))
		manager.redPoint:setTip(RedPointConst.CUSTOMER_SERVICE_UNREAD, var_1_7 == 0 and 0 or 1)
	elseif var_1_1 == "iosWillPopupPay" then
		manager.notify:Invoke(RECHARGE_WILL_POPUP)
	elseif var_1_1 == "shareCallback" then
		local var_1_8 = var_1_0.code

		manager.notify:Invoke(SHARE_CALLBACK, var_1_8)

		if var_1_8 == 0 then
			ShowTips("SHARE_SUCCESS")
		elseif var_1_8 == 2 then
			ShowTips("SHARE_CANCEL")
		else
			local var_1_9 = GetTips("SHARE_FAIL")

			ShowTips(var_1_9)
		end
	elseif var_1_1 == "GetAgeTipCallback" then
		local var_1_10 = var_1_0.tip or ""

		if var_1_10 ~= nil and var_1_10 ~= "" then
			manager.notify:Invoke(AGE_TIP_CALLBACK, var_1_10)
		end
	elseif var_1_1 == "getPlatformData" then
		manager.notify:Invoke(GET_PLATFORM_DATA_CALLBACK, var_1_0)
	elseif var_1_1 == "SocailDiscordCancelAuth" then
		manager.notify:Invoke(SOCAIL_DISCORD_CANCEL, var_1_0)
	elseif var_1_1 == "getServerTimeResult" then
		local var_1_11 = var_1_0.timeStamp

		manager.notify:Invoke(SDK_GET_SERVERTIME, var_1_11)
	elseif var_1_1 == "downloadImage" then
		if var_1_0.code == 1 then
			local var_1_12 = var_1_0.downloadPath

			manager.notify:Invoke(SDK_DOWNLOAD_IMG, {
				code = 1,
				path = var_1_12
			})
		else
			manager.notify:Invoke(SDK_DOWNLOAD_IMG, {
				code = 0
			})
		end
	elseif var_1_1 == "uploadImage" then
		if var_1_0.code == 1 then
			local var_1_13 = var_1_0.uploadUrl

			manager.notify:Invoke(SDK_UPLOAD_IMG, {
				code = 1,
				url = var_1_13
			})
		else
			manager.notify:Invoke(SDK_UPLOAD_IMG, {
				code = 0
			})
		end
	elseif var_1_1 == "FoldStatusCallback" then
		if var_1_0.width < var_1_0.height then
			_G.SCREEN_WIDTH = var_1_0.height
			_G.SCREEN_HEIGHT = var_1_0.width
		else
			_G.SCREEN_WIDTH = var_1_0.width
			_G.SCREEN_HEIGHT = var_1_0.height
		end

		DeploySetting(SettingData:GetSettingData())
		manager.notify:Invoke("FoldStatusCallback")
		print(string.format("FoldStatusCallback %dx%d", _G.SCREEN_WIDTH, _G.SCREEN_HEIGHT))
	end

	if var_1_2 then
		if var_0_2[var_1_1] then
			var_0_2[var_1_1](var_1_0)

			var_0_2[var_1_1] = nil
		end

		if var_0_3 and var_0_3[var_1_1] and #var_0_3[var_1_1] > 0 then
			local var_1_14 = table.remove(var_0_3[var_1_1], 1)

			SendMessageToSDKWithCallBack(var_1_14.sendString, var_1_14.waitTag, var_1_14.callBack)
		end
	end
end

function SDKInited()
	GameToSDK.IsSDKInited = true
end

function GetBulletin(arg_3_0)
	_G.bulletinInfo = arg_3_0
	_G.bulletinInfoGetted = true
end

function GetSDKLoginInfo()
	return var_0_4
end

function GetSDKLoginToken()
	if var_0_4 then
		return var_0_4.token
	end
end

local var_0_5 = false

function EvokeGateWayLogin(arg_6_0)
	print("EvokeGateWayLogin selectRegionServerId : " .. (arg_6_0 or "null"))

	if var_0_4 and var_0_4.token then
		if not var_0_5 then
			var_0_5 = true

			RegionServerMgr.instance:UpdateRegionServerInfo(_G.TMP_ACCOUNT_ID or "", function(arg_7_0, arg_7_1)
				var_0_5 = false

				if _G.isLogining then
					return
				end

				local var_7_0 = true
				local var_7_1 = GetTips("SERVER_MAINTENANCE")
				local var_7_2 = RegionServerMgr.instance:GetRegionServerInfo(arg_6_0)

				if arg_7_0 and not isNil(var_7_2) then
					GATEWAY_ADDR = var_7_2.ip
					GATEWAY_PORT = var_7_2.port

					print("EvokeGateWayLogin Info " .. GATEWAY_ADDR .. GATEWAY_PORT)

					var_7_0 = var_7_2.maintain

					local var_7_3 = var_7_2.maintainReason

					if not string.isNullOrEmpty(var_7_3) then
						print(string.format("平台下发维护信息 ：%s", var_7_3))

						local var_7_4, var_7_5 = pcall(var_0_0.decode, var_7_3)

						if var_7_4 then
							local var_7_6 = SettingData:GetCurrentLanguage()

							if var_7_6 == "tc" and var_7_5.tw then
								var_7_1 = var_7_5.tw
							elseif var_7_6 == "zh_cn" and var_7_5.cn then
								var_7_1 = var_7_5.cn
							elseif var_7_5[var_7_6] then
								var_7_1 = var_7_5[var_7_6]
							end
						else
							var_7_1 = var_7_3
						end
					end

					local var_7_7 = gameContext:GetOpenPageHandler("login")

					if var_7_7 then
						var_7_7:SetSDKId()
					end
				else
					print("EvokeGateWayLogin UpdateRegionServerInfo fail")

					var_7_0 = true
				end

				if arg_7_0 then
					manager.notify:CallUpdateFunc(LOGIN_SEVER_UPDATE)
				end

				if var_7_0 then
					print("EvokeGateWayLogin Maintain")
					ShowMessageBox({
						ButtonType = "SingleBtn",
						isTop = true,
						content = var_7_1,
						OkCallback = function()
							return
						end
					})
				else
					print("唤起网关登录")
					PlayerPrefs.SetString("RegionServerId", arg_6_0)
					RegionServerMgr.instance:UpdateClintConfigs(arg_6_0)
					GateWayLogin(var_0_4)
				end
			end)
		end

		return true
	else
		return false
	end
end

function GateWayLogin(arg_9_0)
	SendMessageToSDKWithCallBack("{\"messageType\" : \"GetChannelLoginInfo\"}", "ChannelLoginInfoGet", function()
		print("sdk登录信息返回")

		if _G.ChannelLoginInfo.code == 0 then
			CheckVersion(function()
				print(string.format("请求网关登录: id = %s, token = %s, channelId = %s, appId = %s", arg_9_0.id, arg_9_0.token, arg_9_0.channelId, arg_9_0.appId))
				LoginAction.GateWayLogin(arg_9_0.id, arg_9_0.token, arg_9_0.channelId, arg_9_0.appId)
			end)
		end
	end)
end

local var_0_6 = false

function ShowQuitConfirm()
	if var_0_6 then
		return
	end

	var_0_6 = true

	ShowMessageBox({
		isTop = true,
		content = GetTips("TIP_QUIT_GAME"),
		OkCallback = function()
			var_0_6 = false

			Quit()
		end,
		CancelCallback = function()
			var_0_6 = false
		end,
		MaskCallback = function()
			var_0_6 = false
		end
	})
end

function AntiAddiction(arg_16_0)
	local var_16_0 = arg_16_0.sdkTip ~= nil and arg_16_0.sdkTip or GetTips("ANTIADDICTION_ONLINE_TIME_LIMIT")

	ShowMessageBox({
		isTop = true,
		ButtonType = "SingleBtn",
		content = var_16_0,
		OkCallback = function()
			ReconnectLogic.ReconnectError()
		end,
		CancelCallback = function()
			return
		end
	})
end

function DeviceInfoGet(arg_19_0)
	_G.deviceInfo = arg_19_0

	for iter_19_0, iter_19_1 in pairs(arg_19_0) do
		print(string.format("deviceInfo.%s = %s", iter_19_0, iter_19_1))
	end
end

function MarketCommentsNoSupport()
	local var_20_0 = {
		gameAppId = _G.ChannelLoginInfo.channelAppId,
		token = _G.ChannelLoginInfo.channelToken
	}

	OperationAction.OpenOperationUrl("OFFICIAL_DISCUSS_URL", var_20_0)
end

function ChannelLoginInfoGet(arg_21_0)
	_G.ChannelLoginInfo = arg_21_0
end

function NeedGameUserInfo()
	local var_22_0 = PlayerData:GetPlayerInfo()
	local var_22_1 = _G.TMP_ACCOUNT_ID
	local var_22_2 = var_22_0.nick
	local var_22_3 = var_22_0.userID

	if var_22_0.userID == 1 then
		return
	end

	local var_22_4 = BattleChapterStageCfg[BattleInstance.GetCurrentBattleId()].name
	local var_22_5 = manager.time:STimeDescS(var_22_0.register_timestamp, "!%Y/%m/%d %H:%M")
	local var_22_6 = var_22_0.userLevel
	local var_22_7 = TowerData:GetTowerMaxId()
	local var_22_8 = BattleTowerStageCfg[var_22_7] and BattleTowerStageCfg[var_22_7].name or ""
	local var_22_9 = tostring(_G.CHANNEL_MASTER_ID)
	local var_22_10 = tostring(RechargeData:GetTotalRechargeNum())
	local var_22_11 = "暂无区组"
	local var_22_12 = tostring(_G.YONGSHI_ID)
	local var_22_13 = tostring(TowerData:GetTowerMaxId())
	local var_22_14 = _G.TMP_SERVER_ID
	local var_22_15 = CurrencyData:GetRechargeDiamond()

	SendMessageToSDK(string.format("{\"messageType\" : \"SendGameUserInfo\", \"accountId\" : \"%s\",\"nickName\" : \"%s\" , \"uId\" : \"%d\", \"maxChapterLevel\" : \"%s\", \"createTime\" : \"%s\", \"userLv\" : \"%d\", \"maxChallengeLv\" : \"%s\", \"channel\" : \"%s\", \"rechargeNum\" : \"%s\", \"region\" : \"%s\", \"mixId\" : \"%s\", \"maxTower\" : \"%s\", \"serverId\" : \"%d\", \"currency\" : \"%d\" }", var_22_1, var_22_2, var_22_3, var_22_4, var_22_5, var_22_6, var_22_8, var_22_9, var_22_10, var_22_11, var_22_12, var_22_13, var_22_14, var_22_15))
	GameToSDK.UpUserInfo(PlayerTools.PackUserData("UpdateData"))
end

function ReceivePushNotification(arg_23_0)
	ShowTips(arg_23_0)
end

function SendMessageToSDK(arg_24_0)
	GameToSDK.SendMessage(arg_24_0)
end

function SendMessageToSDKWithCallBack(arg_25_0, arg_25_1, arg_25_2)
	if var_0_1[arg_25_1] then
		if var_0_3[arg_25_1] == nil then
			var_0_3[arg_25_1] = {}
		end

		table.insert(var_0_3[arg_25_1], {
			sendString = arg_25_0,
			waitTag = arg_25_1,
			callBack = arg_25_2
		})

		return
	end

	print("SendMessageToSDKWithCallBack", arg_25_0, arg_25_1)
	GameToSDK.SendMessage(arg_25_0)

	if GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV then
		arg_25_2()

		return
	end

	var_0_1[arg_25_1] = true
	var_0_2[arg_25_1] = arg_25_2
end

function ReceiveSavePhotoMessage(arg_26_0, arg_26_1)
	if arg_26_0 then
		ShowTips("SAVE_PHOTO_SUCCESS")
	else
		ShowTips("SAVE_PHOTO_FAIL")
	end
end

function GetSDKServerTime()
	GameToSDK.GetServerTime()
end

function SetSDKUploadImageLimit(arg_28_0, arg_28_1)
	local var_28_0 = string.format("{\"messageType\":\"SetImageMaxCount\",\"maxCount\":\"%d\",\"savePath\":\"%s\"}", arg_28_0, arg_28_1)

	GameToSDK.SetImageMaxCount(var_28_0)
end

function SDKUploadImage(arg_29_0, arg_29_1)
	local var_29_0 = string.format("{\"messageType\":\"UploadImage\",\"imagePath\":\"%s\",\"moduleStr\":\"%s\"}", arg_29_1, arg_29_0)

	GameToSDK.UploadImage(var_29_0)
end

function SDKDownloadImage(arg_30_0, arg_30_1)
	local var_30_0 = string.format("{\"messageType\":\"DownloadImage\",\"path\":\"%s\",\"url\":\"%s\"}", arg_30_1, arg_30_0)

	GameToSDK.DownloadImage(var_30_0)
end

function SDKDonwloadUrlToLocalPath(arg_31_0)
	local var_31_0 = (arg_31_0 or ""):match("[^/]+$")

	if not var_31_0 or var_31_0 == "" then
		return ""
	end

	local var_31_1, var_31_2 = var_31_0:gsub("%.[^.]*$", "")

	return var_31_1 or ""
end
