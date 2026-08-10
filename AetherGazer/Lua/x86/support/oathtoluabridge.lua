local var_0_0 = {}
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = false
local var_0_4 = {}
local var_0_5

function OathLaunchScene(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	DestroyLua()

	var_0_1 = arg_1_1
	var_0_2 = arg_1_2

	OathToLuaBridge:InitCaputureSettingList()

	arg_1_3 = arg_1_3 or OathConst.OATH_SCENE_MODE.OATH
	var_0_3 = OathToLuaBridge.OathCheckIsMeetOath(var_0_1)

	OathLuaBridge.Launcher(arg_1_0, var_0_2, arg_1_3)
	SDKTools.SendMessageToSDK("activity_sys_act", {
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = OathToLuaBridge:GetOathHeroID(),
		type = OathConst.OATH_SCENE_ID.ENTER,
		mould_id = var_0_3 and 1 or 2
	})
end

function var_0_0.InitCaputureSettingList(arg_2_0)
	var_0_4 = {}

	for iter_2_0, iter_2_1 in pairs(OathConst.OATH_CAPTURE_FILTER_TYPE) do
		table.insert(var_0_4, OathTools.GetDefalutSetting(var_0_2, iter_2_1))
	end
end

function var_0_0.GetCaptureSwitch(arg_3_0, arg_3_1)
	return var_0_4[arg_3_1]
end

function var_0_0.SetCaptureSwitch(arg_4_0, arg_4_1)
	local var_4_0 = WeddingCaptureSwitchCfg[arg_4_1]

	var_0_4[var_4_0.switchType] = arg_4_1

	OathLuaBridge.ChangeCapturePose(var_4_0.switchType, var_4_0.switchName)

	if var_4_0.switchType == OathConst.OATH_CAPTURE_FILTER_TYPE.Action then
		local var_4_1 = OathTools.GetDefalutSetting(var_4_0.character, OathConst.OATH_CAPTURE_FILTER_TYPE.Face)

		arg_4_0:SetCaptureSwitch(var_4_1)
	end

	manager.notify:Invoke(OATH_SCENE_CAPTURE_SWITCH_CHANGE, arg_4_1)
end

function var_0_0.GetUseOathCharacterID(arg_5_0)
	return var_0_2
end

function var_0_0.GetOathHeroID(arg_6_0)
	return var_0_1
end

function var_0_0.OathOpenCaptureFilter(arg_7_0)
	if arg_7_0 then
		JumpTools.OpenPageByJump("oathCaptureSettingView")
	elseif gameContext:IsOpenRoute("oathCaptureSettingView") then
		JumpTools.Back()
	end
end

function var_0_0.OathExitScene()
	var_0_5 = nil

	DestroyLua()
	LuaExchangeHelper.GoToMain(CustomLoadingConst.Oath_Loading)
	manager.windowBar:ClearWhereTag()
	OpenPageUntilLoaded("/oathMainView", {
		selectHeroID = var_0_1
	})
end

function var_0_0.OathExitBookReModeScene(arg_9_0, arg_9_1)
	var_0_5 = nil

	DestroyLua()
	LuaExchangeHelper.GoToMain(CustomLoadingConst.Oath_Loading)
	manager.windowBar:ClearWhereTag()
	OpenPageUntilLoaded("/oathMainView", {
		selectHeroID = arg_9_0,
		enterCallback = function()
			JumpTools.OpenPageByJump("oathBookView", {
				heroID = arg_9_0,
				sprite = arg_9_1
			})
		end
	})
end

function var_0_0.OathEnterScene(arg_11_0, arg_11_1)
	manager.uiInit()
	gameContext:SetSystemLayer("battle")
	manager.windowBar:SetWhereTag("Oath")

	if arg_11_1 then
		OathToLuaBridge.OathInitUI(arg_11_0)
		var_0_0.OathAddBlackShow()
	else
		OathToLuaBridge.OathInitUI(arg_11_0)
	end
end

function var_0_0.OathAddBlackShow()
	if var_0_0.blackHideTimer_ then
		var_0_0.blackHideTimer_:Stop()

		var_0_0.blackHideTimer_ = nil
	end

	manager.transition:OnlyShowEffect(true)

	var_0_0.blackHideTimer_ = Timer.New(function()
		manager.transition:OnlyShowEffect(false)
		var_0_0.blackHideTimer_:Stop()

		var_0_0.blackHideTimer_ = nil
	end, 1, 0.1)

	var_0_0.blackHideTimer_:Start()
end

function var_0_0.OathLoadModel(arg_14_0)
	var_0_5 = arg_14_0

	manager.notify:Invoke(OATH_SCENE_LOAD_MODEL, arg_14_0)
end

function var_0_0.OathInitUI(arg_15_0)
	if arg_15_0 == OathConst.OATH_SCENE_MODE.CAPTURE or arg_15_0 == OathConst.OATH_SCENE_MODE.SHARE or arg_15_0 == OathConst.OATH_SCENE_MODE.BOOK_RE then
		gameContext:Go("/springPreheatBlank/oathSceneCaptureView", {
			sceneMode = arg_15_0
		})
	elseif arg_15_0 == OathConst.OATH_SCENE_MODE.OATH then
		gameContext:Go("/springPreheatBlank/oathSceneProcessView")
	end
end

function var_0_0.OathEnterCaptureHideUIMode(arg_16_0)
	manager.ui.uiPop.gameObject:SetActive(not arg_16_0)
end

function var_0_0.OathEmitterEvent(arg_17_0, ...)
	manager.notify:Invoke(arg_17_0, ...)
end

function var_0_0.OathCheckConditionMeet(arg_18_0)
	if arg_18_0 == OathConst.OATH_SCENE_CONDITION_TYPE.OATH_IS_MEET then
		return var_0_3
	end

	return true
end

function var_0_0.IsOath()
	return OathTools.IsOath(var_0_1)
end

function var_0_0.OathCheckIsMeetOath(arg_20_0)
	if OathTools.IsOath(arg_20_0) then
		return true
	end

	local var_20_0 = WeddingCfg[arg_20_0].condition

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if not IsConditionAchieved(iter_20_1) then
			return false
		end
	end

	return true
end

function var_0_0.OathFinsh()
	if OathTools.IsOath(var_0_1) then
		return
	end

	OathCollectionContentAction.Oath(var_0_1)
end

function var_0_0.OathRecordSDK(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1

	if arg_22_1 then
		var_22_0 = string.format("[%s]", var_22_0)
	else
		var_22_0 = {}
	end

	SDKTools.SendMessageToSDK("activity_sys_act", {
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = OathToLuaBridge:GetOathHeroID(),
		type = OathConst.OATH_SCENE_ID.INTERATION,
		mould_id = var_0_3 and 1 or 2,
		param_tree = arg_22_0,
		params_list = var_22_0,
		use_seconds = arg_22_2 and math.floor(arg_22_2 + 0.5) or 0
	})
end

function var_0_0.GetOathModel()
	return var_0_5
end

return var_0_0
