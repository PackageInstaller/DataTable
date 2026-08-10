local var_0_0 = {}

function LaunchT0WorldScene(arg_1_0, arg_1_1, arg_1_2)
	DestroyLua()

	local var_1_0 = getData("T0World", "LastEnterTimes") or 0
	local var_1_1 = manager.time:GetServerTime()
	local var_1_2 = manager.time:CheckIsToday(var_1_0, var_1_1)

	saveData("T0World", "LastEnterTimes", var_1_1)
	T0WorldLuaBridge.Launcher(arg_1_0, arg_1_1, arg_1_2 or -1, not var_1_2)

	if GameToSDK.IsPCPlatform() then
		LuaHidTools.ForceSelectKeyboard(HID_TYPES.KeyMouse)
	end
end

function T0EnterWordScene(arg_2_0, arg_2_1)
	manager.uiInit()
	gameContext:SetSystemLayer("battle")
	manager.windowBar:SetWhereTag("T0World")
	T0WorldMgr:InitContext(arg_2_0, arg_2_1)

	local var_2_0 = SettingData:GetSoundSettingData().voice_language

	manager.audio:SetBgmAisacControl("104402_live_voice_change", var_2_0 == 1 and 0 or 1)
end

function T0ExitWorldSecene()
	manager.audio:SetBgmAisacControl("104402_live_voice_change", 0)
	T0WorldMgr:ClearContext()
	DestroyLua()
end

function T0WorldUIShow()
	gameContext:Go("/springPreheatBlank/t0SceneGameMain")
end

function T0WorldSetSubtitleDisplayMultiple(arg_5_0)
	T0VoiceContent.showMultiple = arg_5_0
end

function T0WorldPushSubtitle(arg_6_0)
	manager.notify:Invoke(T0_WORLD_PUSH_SUBTITLE, arg_6_0)
end

local var_0_1 = {
	awb = "vo_sys_%d.awb",
	name = "v_s_%d_%s",
	sheet = "vo_sys_%d"
}

function T0WorldStartTalk(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	T0WorldMgr.context.isTaking = true

	local var_7_0 = arg_7_1

	if var_7_0 == nil or var_7_0 <= 0 then
		var_7_0 = T0WorldMgr:GetHeroID()
	end

	local var_7_1 = HeroTools.FindMatchSkinVoiceCfg(var_7_0, arg_7_2)
	local var_7_2
	local var_7_3
	local var_7_4

	if var_7_1 then
		var_7_2, var_7_3, var_7_4 = HeroTools.PlayTalkBySkinID(var_7_0, arg_7_2, nil, arg_7_0)
	else
		var_7_2, var_7_3, var_7_4 = string.format(var_0_1.sheet, var_7_0), string.format(var_0_1.name, var_7_0, arg_7_2), string.format(var_0_1.awb, var_7_0)

		HeroTools.PlayTalkWithLips(var_7_0, arg_7_0, var_7_2, var_7_3, var_7_4)
		manager.notify:Invoke(HERO_SOUND_PLAY, var_7_0, arg_7_2, 1)
	end

	local var_7_5 = manager.audio:GetVoiceLength(var_7_2, var_7_3, var_7_4)

	manager.notify:Invoke(T0_WORLD_START_TALK, var_7_0, arg_7_2, var_7_5, arg_7_3, arg_7_4)
end

function T0WorldShowCaptions(arg_8_0, arg_8_1)
	manager.notify:Invoke(T0_WORLD_SHOW_CAPTIONS, arg_8_0, arg_8_1)
end

function ExitT0WorldScene()
	if GameToSDK.IsPCPlatform() then
		LuaHidTools.ForceSelectKeyboard(nil)
	end

	DestroyLua()
	LuaExchangeHelper.GoToMain()
	OpenPageUntilLoaded("/home", {})
end

function T0WorldChangeLocation(arg_10_0)
	T0WorldMgr:SetCaptureScene(arg_10_0)
	manager.notify:Invoke(T0_WORLD_CAPTURE_SCENE_CHANGE, arg_10_0)
	T0WorldMgr:DefalutSettingByScene(arg_10_0)
end

function T0WorldEmitterEvent(arg_11_0, ...)
	manager.notify:Invoke(arg_11_0, ...)
end

function T0WorldOpenCaptureFilter(arg_12_0)
	if arg_12_0 then
		JumpTools.OpenPageByJump("t0SceneCaptureSetting")
	elseif gameContext:IsOpenRoute("t0SceneCaptureSetting") then
		JumpTools.Back()
	end
end

function T0WorldEnterHideUIMode(arg_13_0)
	manager.ui.uiPop.gameObject:SetActive(not arg_13_0)
end

function T0WorldViewControllerModeChange(arg_14_0)
	local var_14_0 = arg_14_0 == T0WorldMgr.CaptureModeStateEnum.empty or arg_14_0 == T0WorldMgr.CaptureModeStateEnum.mainUIHide

	T0WorldEnterHideUIMode(var_14_0)
	manager.notify:Invoke(T0_WORLD_CHANGE_CONTROLLER_MODE, arg_14_0)
end

function GetT0WorldCaptureCount()
	return T0WorldMgr.context.captureCount or 0
end

function T0WorldSetCaptureLookAt(arg_16_0)
	T0WorldMgr.context.isUseLookAt = arg_16_0
end

function RecordT0SDK(arg_17_0)
	local var_17_0 = arg_17_0.sdkExtraType and tonumber(arg_17_0.sdkExtraType) or nil
	local var_17_1 = (T0WorldMgr:GetSceneID() or 0) > 0 and T0WorldMgr:GetSceneID() or 1
	local var_17_2 = arg_17_0.select_param and arg_17_0.select_param ~= "" and arg_17_0.select_param or nil

	SDKTools.SendMessageToSDK("activity_sandplay_act", {
		sys_id = 101,
		skin_id = T0WorldMgr:GetHeroID(),
		scene_id = T0WorldMgr:GetDLCID(),
		type = arg_17_0.sdkType and tonumber(arg_17_0.sdkType) or 1,
		param_tree = arg_17_0.treeID and tostring(arg_17_0.treeID) or "",
		param_id = arg_17_0.entityID or -1,
		position = var_17_1,
		hero_id = arg_17_0.characterID or 0,
		stage_id = var_17_0,
		params_list = arg_17_0.select_list or {},
		params_select = var_17_2 or arg_17_0.nodeID or ""
	})
end

function RecordT0WorldInterationSDK(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6)
	local var_18_0 = (arg_18_4 or 0) > 0 and arg_18_4 or nil
	local var_18_1 = (T0WorldMgr:GetSceneID() or 0) > 0 and T0WorldMgr:GetSceneID() or 1

	SDKTools.SendMessageToSDK("activity_sandplay_act", {
		sys_id = 101,
		skin_id = T0WorldMgr:GetHeroID(),
		scene_id = T0WorldMgr:GetDLCID(),
		type = arg_18_0 and tonumber(arg_18_0) or 1,
		param_tree = arg_18_2 and tostring(arg_18_2) or "",
		param_id = arg_18_1 or -1,
		params_select = arg_18_2 and tostring(arg_18_3) or "",
		stage_id = var_18_0,
		position = var_18_1,
		hero_id = arg_18_5 or 0,
		params_list = arg_18_6 or {}
	})
end

function RecordT0WorldCaptureSDK(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0 and tonumber(arg_19_0) or 1
	local var_19_1 = T0WorldMgr:GetUseSceneType() or 1
	local var_19_2 = {}

	if var_19_0 == 1 then
		var_19_2 = string.format("[{pose:%s},{emoji:%s},{filter:%s},{camera_look:%s},{camera_position:%s},{camera_distance:%s}]", T0WorldMgr:GetUseSettingByType(T0WorldMgr.SwitchTypeEnum.Action) or -1, T0WorldMgr:GetUseSettingByType(T0WorldMgr.SwitchTypeEnum.Face) or -1, T0WorldMgr:GetUseSettingByType(T0WorldMgr.SwitchTypeEnum.Filter) or -1, T0WorldMgr.context.isUseLookAt or false, arg_19_1, manager.ui.mainCameraCom_.fieldOfView)
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		sys_id = 101,
		skin_id = T0WorldMgr:GetHeroID(),
		scene_id = T0WorldMgr:GetDLCID(),
		result = var_19_0,
		position = var_19_1,
		other_data = var_19_2 or {}
	})
end

var_0_0.ConditionEnum = {
	Condition = 1
}

function T0WorldCheckConditionMeet(arg_20_0, arg_20_1)
	return (IsConditionAchieved(arg_20_1))
end

function T0AddBlackShow(arg_21_0)
	manager.transition:OnlyShowEffect(arg_21_0)
end

return var_0_0
