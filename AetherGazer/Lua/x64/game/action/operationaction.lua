local var_0_0 = {}

manager.net:Bind(40021, function(arg_1_0)
	OperationData:InitOperationOpenList(arg_1_0)
end)

local function var_0_1(arg_2_0, arg_2_1)
	if arg_2_0 == nil or #arg_2_0 == 0 then
		return nil
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		if iter_2_1.type == arg_2_1 then
			return iter_2_1
		end
	end
end

manager.net:Bind(40035, function(arg_3_0)
	local var_3_0 = var_0_1(arg_3_0.sys_supend_list, 1)

	OperationData:SetFunctionStopIdList(var_3_0)
end)
manager.net:Bind(40033, function(arg_4_0)
	OperationData:InitFollowOpenList(arg_4_0)
end)

function var_0_0.GetCurServerTimestampAndSign(arg_5_0)
	manager.net:SendWithLoadingNew(10700, {}, 10701, function(arg_6_0)
		_G.SERVER_TIMESTAMP = arg_6_0.timestamp
		_G.SERVER_TIMESTAMP_SIGN = arg_6_0.timestamp_sign

		if arg_5_0 then
			arg_5_0()
		end
	end)
end

function var_0_0.UpdateUrlContext(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = {
		key = arg_7_0,
		params = arg_7_2 or {},
		url = arg_7_1 or var_0_0.GetOperationUrl(arg_7_0),
		urlOpenWay = arg_7_3 or var_0_0.InitUrlOpenWay(arg_7_0)
	}

	if arg_7_4 == nil then
		var_7_0.screenOrientation = OperationConst.SCREEN_ORIENTATION.FREE
	else
		var_7_0.screenOrientation = arg_7_4
	end

	if arg_7_5 == nil then
		var_7_0.isNeedCloseBtn = true
	else
		var_7_0.isNeedCloseBtn = arg_7_5
	end

	var_0_0.curUrlContext = var_7_0
end

function var_0_0.OpenOperationUrl(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	var_0_0.UpdateUrlContext(arg_8_0, nil, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	var_0_0.PrepareToOpenUrl()
end

function var_0_0.OpenOperationUrlDirectly(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	var_0_0.UpdateUrlContext(nil, arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	var_0_0.PrepareToOpenUrl()
end

function var_0_0.OpenOperationUrlBeforeLogin(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	var_0_0.UpdateUrlContext(arg_10_0, nil, arg_10_1, arg_10_2, arg_10_3, arg_10_4)

	if not var_0_0.curUrlContext.url then
		return
	end

	local var_10_0 = var_0_0.ParseUrl(var_0_0.curUrlContext.url, var_0_0.curUrlContext.params, var_0_0.curUrlContext.key)

	var_0_0.OpenUrl(var_10_0, var_0_0.curUrlContext.urlOpenWay, var_0_0.curUrlContext.screenOrientation, var_0_0.curUrlContext.isNeedCloseBtn)
end

function var_0_0.PrepareToOpenUrl()
	if not var_0_0.curUrlContext.url then
		return
	end

	var_0_0.GetCurServerTimestampAndSign(function()
		local var_12_0 = var_0_0.ParseUrl(var_0_0.curUrlContext.url, var_0_0.curUrlContext.params, var_0_0.curUrlContext.key)

		var_0_0.OpenUrl(var_12_0, var_0_0.curUrlContext.urlOpenWay, var_0_0.curUrlContext.screenOrientation, var_0_0.curUrlContext.isNeedCloseBtn)
	end)
end

function var_0_0.GetOperationUrl(arg_13_0, arg_13_1)
	local var_13_0 = GameToSDK.clientInfo.configS

	if not var_13_0 then
		if not arg_13_1 then
			print("error GameToSDK.clientInfo empty configS")
		end

		return nil
	end

	if not var_13_0:ContainsKey(arg_13_0) then
		if not arg_13_1 then
			print("error GameToSDK.clientInfo empty configS by key : " .. arg_13_0)
		end

		return nil
	end

	return var_13_0:get_Item(arg_13_0)
end

function var_0_0.InitUrlOpenWay(arg_14_0)
	local var_14_0

	if not arg_14_0 or GameToSDK.IsEditorOrPcPlatform() then
		var_14_0 = OperationConst.URL_OPEN_WAY.NORMAL
	elseif GameToSDK.PLATFORM_ID == 1 and (arg_14_0 == "FORUM_URL" or arg_14_0 == "PC_SHOP" or arg_14_0 == "FORUM_URL_HOME" or arg_14_0 == "FORUM_URL_HERO" or arg_14_0 == "REFUND_URL" or arg_14_0 == "OFFICIAL_SUGGEST_URL") then
		var_14_0 = OperationConst.URL_OPEN_WAY.NORMAL
	elseif GameToSDK.PLATFORM_ID == 4 and arg_14_0 == "REFUND_URL" then
		var_14_0 = OperationConst.URL_OPEN_WAY.NORMAL
	else
		var_14_0 = OperationConst.URL_OPEN_WAY.INTERNAL
	end

	return var_14_0
end

function var_0_0.OpenUrl(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	print(string.format("OpenUrl, url: %s, openWay : %s, screenOrientation: %s, isNeedCloseBtn: %s", arg_15_0, arg_15_1, arg_15_2, arg_15_3))

	if arg_15_1 == OperationConst.URL_OPEN_WAY.NORMAL then
		var_0_0.OpenNormalUrl(arg_15_0)
	elseif arg_15_1 == OperationConst.URL_OPEN_WAY.INTERNAL then
		var_0_0.OpenInternalUrl(arg_15_0, arg_15_2, arg_15_3)
	end
end

function var_0_0.OpenNormalUrl(arg_16_0)
	if GameToSDK.PLATFORM_ID == 1 then
		LuaForUtil.LinkThirdApp(arg_16_0)
	else
		Application.OpenURL(arg_16_0)
	end
end

function var_0_0.OpenInternalUrl(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == nil then
		arg_17_1 = OperationConst.SCREEN_ORIENTATION.FREE
	end

	if arg_17_2 == nil then
		arg_17_2 = true
	end

	FrameTimer.New(function()
		LuaForUtil.OpenWebView(arg_17_0, arg_17_2, function()
			print("--->> open webView to portrait")
			LuaForUtil.EnableAudioSessionRestoration_IOS(false)
		end, function()
			print("====>>> close webView recover")
			LuaForUtil.EnableAudioSessionRestoration_IOS(true)
		end, arg_17_1)
	end, 6, 1):Start()
end

function var_0_0.ParseUrl(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0

	if var_0_0.ContainsParamHolder(arg_21_0, arg_21_1) then
		var_21_0 = var_0_0.ReplaceUrlParamHolders(arg_21_0, arg_21_1)
	else
		var_21_0 = var_0_0.ParseUrlParams(arg_21_0, arg_21_1, arg_21_2)
	end

	return (EncodeURL(var_21_0))
end

function var_0_0.ContainsParamHolder(arg_22_0)
	return string.find(arg_22_0, "{(.-)}") ~= nil
end

function var_0_0.ReplaceUrlParamHolders(arg_23_0, arg_23_1)
	return arg_23_0:gsub("{(.-)}", function(arg_24_0)
		if OperationConst.URL_PARAM_MARK[arg_24_0] then
			return OperationConst.URL_PARAM_MARK[arg_24_0].getFunc(arg_23_1)
		end
	end)
end

function var_0_0.ParseUrlParams(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0

	if arg_25_2 == "INQUERY_URL" then
		var_25_0 = string.format(arg_25_0, arg_25_1.userId, arg_25_1.signUserId)
	elseif arg_25_2 == "FORUM_URL" or arg_25_2 == "OFFICIAL_SUGGEST_URL" or arg_25_2 == "PC_SHOP" then
		var_25_0 = string.format(arg_25_0, arg_25_1.userId, arg_25_1.signUserId, arg_25_1.gameAppId, arg_25_1.token)
	elseif arg_25_2 == "FORUM_URL_HERO" then
		var_25_0 = string.format(arg_25_0, arg_25_1.userId, arg_25_1.signUserId, arg_25_1.gameAppId, arg_25_1.token, arg_25_1.heroName)
	elseif arg_25_2 == "OFFICIAL_DISCUSS_URL" then
		var_25_0 = string.format(arg_25_0, arg_25_1.gameAppId, arg_25_1.token)
	elseif arg_25_2 == "ACTIVITY_URL" then
		var_25_0 = string.format(arg_25_0, arg_25_1.userId, arg_25_1.signUserId)
	elseif arg_25_2 == "GUIDE_URL" or arg_25_2 == "INFORMATION_URL" then
		var_25_0 = string.format(arg_25_0, arg_25_1.userId, arg_25_1.signUserId)
	elseif arg_25_2 == "PC_FEEDBACK" then
		var_25_0 = string.format(arg_25_0, arg_25_1.userId, arg_25_1.signUserId)
	elseif arg_25_2 == BattleStageData:GetDiscussKey() or arg_25_2 == BattleStageData:GetQuestionKey() then
		var_25_0 = string.format(arg_25_0, arg_25_1.userId, arg_25_1.signUserId, arg_25_1.gameAppId, arg_25_1.token)
	else
		var_25_0 = arg_25_0
	end

	return var_25_0
end

function var_0_0.OnApplicationBack()
	local var_26_0 = SurveyData:GetCacheFollowTip()

	if var_26_0 then
		ShowTips(var_26_0)
	end
end

function var_0_0.GetUnreadMsgResult()
	if GameToSDK.PLATFORM_ID == 4 then
		return
	end

	local var_27_0 = var_0_0.GetOperationUrl("BBS_BASE_URL")

	if var_27_0 then
		local var_27_1 = PlayerData:GetPlayerInfo()
		local var_27_2 = var_27_1.userID .. "_" .. var_27_1.signUserId

		LuaForUtil.GetUnreadMsg(var_27_0, var_27_2, 1, function(arg_28_0)
			if arg_28_0 > 0 then
				manager.redPoint:setTip(RedPointConst.FORUM_UNREAD, 1)
			end
		end)
	end
end

local var_0_2
local var_0_3 = false

function var_0_0.ChangeScreenSettingToPortrait()
	var_0_2 = Screen.orientation

	local var_29_0 = tonumber(SettingData:GetSettingData().pic.resolution)
	local var_29_1, var_29_2 = SettingTools.GetSettingScreenSize(var_29_0)

	SetActive(manager.ui.mainCamera, false)
	FrameTimer.New(function()
		if not var_0_3 then
			ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

			Screen.autorotateToPortrait = true
			Screen.autorotateToPortraitUpsideDown = false
			Screen.autorotateToLandscapeLeft = false
			Screen.autorotateToLandscapeRight = false
		else
			ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.Portrait)
		end

		UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
		setScreenOrientation(false)
		U3DHud.mInstance:SetWidthAndHeight(1080, 1920)
		FrameTimer.New(function()
			Screen.SetResolution(var_29_2, var_29_1, true)

			if not var_0_3 then
				FrameTimer.New(function()
					ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

					Screen.autorotateToPortrait = false
					Screen.autorotateToPortraitUpsideDown = false
					Screen.autorotateToLandscapeLeft = true
					Screen.autorotateToLandscapeRight = true

					FrameTimer.New(function()
						ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.Portrait)
						FrameTimer.New(function()
							UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
							U3DHud.mInstance:SetWidthAndHeight(1080, 1920)
							Screen.SetResolution(var_29_2, var_29_1, true)

							var_0_3 = true
						end, 1, 1):Start()
					end, 1, 1):Start()
				end, 1, 1):Start()
			else
				FrameTimer.New(function()
					UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
					U3DHud.mInstance:SetWidthAndHeight(1080, 1920)
					Screen.SetResolution(var_29_2, var_29_1, true)
				end, 1, 1):Start()
			end
		end, 1, 1):Start()
	end, 1, 1):Start()
	FrameTimer.New(function()
		SetActive(manager.ui.mainCamera, true)
	end, 6, 1):Start()
end

function var_0_0.RecoverScreenSetting()
	SetActive(manager.ui.mainCamera, false)
	FrameTimer.New(function()
		ScreenRotateUtil.ChangeScreenOrientation(var_0_2)
		ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

		Screen.autorotateToPortrait = false
		Screen.autorotateToPortraitUpsideDown = false
		Screen.autorotateToLandscapeLeft = true
		Screen.autorotateToLandscapeRight = true

		setScreenOrientation(true)

		local var_38_0 = tonumber(SettingData:GetSettingData().pic.resolution)
		local var_38_1, var_38_2 = SettingTools.GetSettingScreenSize(var_38_0)

		UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(false)
		U3DHud.mInstance:SetWidthAndHeight(1920, 1080)
		FrameTimer.New(function()
			Screen.SetResolution(var_38_1, var_38_2, true)
		end, 2, 1):Start()
	end, 1, 1):Start()
	FrameTimer.New(function()
		SetActive(manager.ui.mainCamera, true)
	end, 4, 1):Start()
end

return var_0_0
