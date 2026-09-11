local var_0_0 = {}
local var_0_1

function var_0_0.SetUpZuma()
	SceneManager.SetActiveScene((SceneManager.GetSceneByName("X108")))
	manager.uiInit()
	gameContext:SetSystemLayer("battle")
	manager.ui:SetMainCamera("zuma")
	JumpTools.OpenPageByJump("springFestivalZumaGameView")
	ZumaData:InitGamePointData()
	ZumaToLuaBridge.CameraAdaptive()
end

function var_0_0.CameraAdaptive()
	local var_2_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_2_1 = UnityEngine.Camera.main
	local var_2_2 = manager.ui:GetCanvasSize()

	manager.ui:SetMainCameraFieldOfView(CameraCfg.zuma.fieldOfView)

	local var_2_5 = GameObject.Find("ZumaPlayEnter/Bg")
	local var_2_6 = var_2_5.transform:GetComponent("SpriteRenderer").sprite.bounds
	local var_2_7 = math.abs(var_2_1.transform:InverseTransformPoint(var_2_5.transform.position).z)
	local var_2_8 = Mathf.Tan(var_2_1.fieldOfView * 0.5 * Mathf.Deg2Rad)

	var_2_1.transform.position = Vector3(0, 0, -((var_2_6.max - var_2_6.min).x - 2 * var_2_7 * var_2_8 * var_2_1.aspect < (var_2_6.max - var_2_6.min).y - 2 * var_2_7 * var_2_8 and 0.5 * (var_2_6.max - var_2_6.min).y / var_2_8 or 0.5 * (var_2_6.max - var_2_6.min).x / var_2_8 / var_2_1.aspect))

	manager.notify:CallUpdateFunc(ZUMA_CAMERA_UPDATE)
end

function var_0_0.OnZumaSceneLoaded()
	var_0_1 = GameLocalData:GetCommonModule("userSetting").frame or PictureQualitySettingCfg[5].frame

	if var_0_1 ~= 1 then
		SettingAction.ChangePicSetting("frame", 1)
	end

	manager.notify:CallUpdateFunc(ZUMA_SCENE_LOADED)
end

function var_0_0.OnZumaSceneExit()
	if var_0_1 ~= 1 then
		SettingAction.ChangePicSetting("frame", var_0_1)
	end

	gameContext:SetSystemLayer("home")
end

function var_0_0.OnZumaOver(arg_5_0)
	JumpTools.OpenPageByJump("springFestivalZumaGameSettleView", {
		isWin = arg_5_0
	})
end

function var_0_0.ZumaballHit(arg_6_0)
	ZumaData:SetZumaScore(arg_6_0)
	manager.notify:CallUpdateFunc(ZUMA_BALL_HIT)
end

function var_0_0.ZumaBallCountsUpdate(arg_7_0)
	ZumaData:SetZumaBallCount(arg_7_0)
	manager.notify:CallUpdateFunc(ZUMA_BALL_COUNT_UPDATE)
end

function var_0_0.ZumaCombo(arg_8_0)
	manager.notify:CallUpdateFunc(ZUMA_COMBO_UPDATE, arg_8_0)
end

function var_0_0.ZumaStop(arg_9_0)
	manager.notify:CallUpdateFunc(ZUMA_STOP_SHOW, arg_9_0)
end

function var_0_0.ZumaSkillUpdate(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	manager.notify:CallUpdateFunc(ZUMA_SKILL_GAME_UPDATE, arg_10_0, arg_10_1, arg_10_2)
	ZumaData:RecordPointSkillUseTimes(arg_10_3)
end

function var_0_0.ZumaSkillUseStateUpdate(arg_11_0, arg_11_1)
	manager.notify:CallUpdateFunc(ZUMA_SKILL_GAME_USE_STAGE_UPDATE, arg_11_0, arg_11_1)
end

function var_0_0.ZumaGameReChallenge()
	ZumaData:InitGamePointData()
	ZumaData:SetZumaScore(0)
	manager.notify:CallUpdateFunc(ZUMA_BALL_HIT)
	manager.notify:CallUpdateFunc(ZUMA_SKILL_GAME_UPDATE, 0, 0, 0)
	manager.notify:CallUpdateFunc(ZUMA_BALL_COUNT_UPDATE)
	manager.notify:CallUpdateFunc(ZUMA_STOP_SHOW, false)
	manager.notify:CallUpdateFunc(ZUMA_SKILL_GAME_USE_STAGE_UPDATE, false, ZumaData:GetZumaSkillTypeID())
end

function var_0_0.ZumaEndlessChangeMap(arg_13_0)
	if not arg_13_0 then
		ZumaData:RecordEndlessPointScoreToList()
	end

	manager.notify:CallUpdateFunc(ZUMA_ENDLESS_CHANGE_MAP, arg_13_0)
end

function var_0_0.ZumaEndlessSetMapName(arg_14_0)
	ZumaData:RecordEndlessPointMapNameToList(arg_14_0)
end

function var_0_0.GetZumaGamePlayTime()
	return math.floor((ZumaLuaBridge.GetCurTime()))
end

return var_0_0
