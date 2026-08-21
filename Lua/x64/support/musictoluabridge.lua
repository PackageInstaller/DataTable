local var_0_0 = {}
local var_0_1

function var_0_0.SetUpMusic()
	local var_1_0 = SceneManager.GetSceneByName("X106")

	SceneManager.SetActiveScene(var_1_0)
	manager.uiInit()

	local var_1_1 = MusicData:GetGameId()
	local var_1_2 = ActivityMusicCfg[var_1_1].activity_id
	local var_1_3 = MusicData:GetMusicViewPathList(var_1_2)

	JumpTools.OpenPageByJump(var_1_3.musicName)
	gameContext:SetSystemLayer("battle")
	manager.audio:DestoryCriAtom()
	manager.audio:SetEffectAisacControl("musicgame_hitsound_volume", MusicData:GetVolumeData())

	local var_1_4 = MusicLuaBridge.GetTrackNum()

	if var_1_4 < 4 then
		for iter_1_0 = 4, var_1_4 + 1, -1 do
			local var_1_5 = GameObject.Find("Music/gameRoot/Track" .. iter_1_0)

			if var_1_5 then
				SetActive(var_1_5, false)
			end
		end
	end

	local var_1_6 = MusicData:GetTrackPathType() == MusicConst.MusicTrackType.Constant_Slope
	local var_1_7 = MusicData:GetTrackPathType() == MusicConst.MusicTrackType.Vertical

	if var_1_6 then
		manager.ui:SetMainCamera("musicConstant")
		MusicToLuaBridge.slantAdapt(var_1_4)
	elseif var_1_7 then
		manager.ui:SetMainCamera("musicVertical")
		MusicToLuaBridge.verticalAdapt(var_1_4)
	else
		manager.ui:SetMainCamera("music")
		MusicToLuaBridge.slantAdapt(var_1_4)
	end

	local var_1_8 = GameObject.Find("movie")

	if var_1_8 then
		var_1_8:GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music_bg/" .. ActivityMusicCfg[var_1_1].icon)
	end
end

function var_0_0.verticalAdapt(arg_2_0)
	local var_2_0 = manager.ui.mainCameraCom_
	local var_2_1 = manager.ui.mainCamera.transform
	local var_2_2
	local var_2_3
	local var_2_4 = GameObject.Find("gameRoot/center")

	if var_2_4 then
		local var_2_5 = var_2_4.transform.position
		local var_2_6 = var_2_1:InverseTransformPoint(var_2_5)

		var_2_2 = 1.5 * math.abs(var_2_6.z) * Mathf.Tan(var_2_0.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_2_0.aspect
	else
		var_2_2 = 40
	end

	local var_2_7 = 1

	if not (arg_2_0 > 4) or not (arg_2_0 - 1) then
		local var_2_8 = 0
	end

	local var_2_9 = var_2_2 / (arg_2_0 + 1) * 1.2
	local var_2_10 = var_2_9
	local var_2_11 = var_2_10 / 2
	local var_2_12 = 0
	local var_2_13 = -22.9
	local var_2_14 = Vector3.New(var_2_9, 99, 0.2)

	cell_value_list = {}

	for iter_2_0 = 0, arg_2_0 - 1 do
		cell_value_list[iter_2_0 + 1] = -((arg_2_0 - 1) / 2) + iter_2_0
	end

	local var_2_15 = Vector3.New(0.1, 0, 0)
	local var_2_16 = Vector3(0, -1, 0)

	for iter_2_1 = 1, arg_2_0 do
		local var_2_17 = GameObject.Find("Music/gameRoot/Track" .. iter_2_1)
		local var_2_18 = var_2_17.transform

		var_2_18.localPosition = Vector3(var_2_10 * cell_value_list[iter_2_1], var_2_13, 0)
		var_2_17:GetComponent("BoxCollider").size = var_2_14

		local var_2_19 = var_2_18:Find("bg/leftLine")

		if var_2_19 then
			var_2_19.localPosition = Vector3.New(-1 * var_2_11 + var_2_12, 0, 0)
		end

		local var_2_20 = var_2_18:Find("bg/line")

		if var_2_20 then
			local var_2_21 = var_2_11 + var_2_12 + 0.1

			var_2_20.localPosition = Vector3.New(var_2_21, 0, 0)
		end

		local var_2_22 = var_2_18:Find("bg/clickEffect/eff_glow/glow")

		if var_2_22 then
			var_2_22:GetComponent("SpriteRenderer").size = Vector2.New(var_2_10, 5.12)
		end

		local var_2_23 = var_2_18:Find("effectContent")

		var_2_23.localEulerAngles = Vector3.zero
		var_2_23.localPosition = var_2_16
		var_2_18:Find("nodeContent").localPosition = var_2_15
	end

	local var_2_24 = GameObject.Find("Music/background/frame")

	if var_2_24 then
		local var_2_25 = var_2_24:GetComponent("SpriteRenderer")
		local var_2_26 = var_2_25.size.y

		var_2_25.size = Vector2.New(var_2_10 * arg_2_0, var_2_26)
	end

	local var_2_27 = GameObject.Find("Music/background/mask")

	if var_2_27 then
		var_2_27:GetComponent("SpriteRenderer").size = Vector2.New(var_2_10 * arg_2_0 - 0.1, 999)
	end

	local var_2_28 = 1 * Mathf.Tan(var_2_0.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_2_0.aspect
	local var_2_29 = GameObject.Find("movie")

	if var_2_29 then
		if MusicData:GetShowMovie() then
			SetActive(var_2_29, true)

			local var_2_30 = var_2_29.transform

			var_2_30:SetParent(manager.ui.mainCamera.transform)

			var_2_30.localPosition = Vector3(0, 0, 27)
			var_2_30.localEulerAngles = Vector3(0, 0, 0)
			var_2_30.localScale = Vector3.one

			local var_2_31 = var_2_30:GetComponent("SpriteRenderer")
			local var_2_32 = var_2_2 * 0.5625

			var_2_31.size = Vector2.New(var_2_2, var_2_32)
		else
			SetActive(var_2_29, false)
		end
	end

	local var_2_33 = GameObject.Find("object/long/bg")

	if var_2_33 then
		var_2_33.transform.localScale = Vector3.New(var_2_10 / 3.9, 1, 1)
	end

	local var_2_34 = GameObject.Find("object/short")

	if var_2_34 then
		var_2_34.transform.localScale = Vector3.New(var_2_10 / 7.5, 1, 1)
	end

	local var_2_35 = GameObject.Find("object/good_effect_chuizhi").transform
	local var_2_36 = GameObject.Find("object/perfect_effect_chuizhi").transform
	local var_2_37 = {
		nil,
		nil,
		nil,
		1.8,
		1.7,
		1.6
	}
	local var_2_38 = Vector3.one * var_2_37[arg_2_0]

	for iter_2_2 = 0, var_2_35.childCount - 1 do
		var_2_35:GetChild(iter_2_2).localScale = var_2_38
	end

	for iter_2_3 = 0, var_2_36.childCount - 1 do
		var_2_36:GetChild(iter_2_3).localScale = var_2_38
	end

	local var_2_39 = GameObject.Find("Pool").transform

	for iter_2_4 = 0, var_2_39.childCount - 1 do
		local var_2_40 = var_2_39:GetChild(iter_2_4)

		if var_2_40 then
			for iter_2_5 = 0, var_2_40.childCount - 1 do
				var_2_40:GetChild(iter_2_5).localScale = var_2_38
			end
		end
	end

	local var_2_41 = GameObject.Find("cubeLeft").transform
	local var_2_42 = GameObject.Find("cubeRight").transform

	var_2_41.transform.localPosition = Vector3.New(-50, 0, 0)
	var_2_42.transform.localPosition = Vector3.New(50, 0, 0)
end

function var_0_0.slantAdapt(arg_3_0)
	local var_3_0 = manager.ui.mainCameraCom_
	local var_3_1 = manager.ui.mainCamera.transform
	local var_3_2
	local var_3_3 = GameObject.Find("gameRoot/center")

	if var_3_3 then
		local var_3_4 = var_3_3.transform.position
		local var_3_5 = var_3_1:InverseTransformPoint(var_3_4)

		var_3_2 = 2 * math.abs(var_3_5.z) * Mathf.Tan(var_3_0.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_3_0.aspect
	else
		var_3_2 = 40
	end

	local var_3_6 = var_3_2 / (arg_3_0 + 1)
	local var_3_7 = var_3_6 / 2
	local var_3_8 = -22.9
	local var_3_9 = 0
	local var_3_10 = Vector3.New(var_3_6, 99, 0.2)
	local var_3_11 = Vector3.New(var_3_6 * 1.3, 99, 0.2)
	local var_3_12 = {}

	for iter_3_0 = 1, arg_3_0 do
		var_3_12[iter_3_0] = 30 + (iter_3_0 - arg_3_0 * 0.5 + (iter_3_0 - arg_3_0 * 0.5 > 0 and 1 or -1)) * 5
	end

	local var_3_13 = {}

	for iter_3_1 = 0, arg_3_0 - 1 do
		var_3_13[iter_3_1 + 1] = -((arg_3_0 - 1) / 2) + iter_3_1
	end

	for iter_3_2 = 1, arg_3_0 do
		local var_3_14 = GameObject.Find("Music/gameRoot/Track" .. iter_3_2)

		var_3_14.transform.localPosition = Vector3.New(var_3_6 * var_3_13[iter_3_2], var_3_8, 0)

		local var_3_15 = var_3_14:GetComponent("BoxCollider")

		if iter_3_2 == 1 then
			var_3_15.center = Vector3.New(-var_3_6 * 0.15, 0, 0)
			var_3_15.size = var_3_11
		elseif iter_3_2 == arg_3_0 then
			var_3_15.center = Vector3.New(var_3_6 * 0.15, 0, 0)
			var_3_15.size = var_3_11
		else
			var_3_15.size = var_3_10
		end

		local var_3_16 = var_3_14.transform
		local var_3_17 = var_3_16:Find("bg/leftLine")

		if var_3_17 then
			var_3_17.localPosition = Vector3.New(-1 * var_3_7 - var_3_9, 0, 0)
		end

		local var_3_18 = var_3_16:Find("bg/line")

		if var_3_18 then
			var_3_18.localPosition = Vector3.New(var_3_7 + var_3_9, 0, 0)
		end

		local var_3_19 = var_3_16:Find("bg/clickEffect/eff_glow/glow")

		if var_3_19 then
			var_3_19:GetComponent("SpriteRenderer").size = Vector2.New(var_3_6 + 0.1, 5.12)
		end

		local var_3_20 = var_3_16:Find("effectContent")

		if var_3_12[iter_3_2] then
			var_3_20.localEulerAngles = Vector3(0, var_3_12[iter_3_2], 0)
		end
	end

	local var_3_21 = GameObject.Find("Music/background/frame")

	if var_3_21 then
		local var_3_22 = var_3_21:GetComponent("SpriteRenderer")
		local var_3_23 = var_3_22.size.y

		var_3_22.size = Vector2.New(var_3_6 * arg_3_0, var_3_23)
	end

	local var_3_24 = GameObject.Find("Music/background/mask")

	if var_3_24 then
		var_3_24:GetComponent("SpriteRenderer").size = Vector2.New(var_3_6 * arg_3_0 - 0.1, 999)
	end

	local var_3_25 = GameObject.Find("movie")

	if var_3_25 then
		if MusicData:GetShowMovie() then
			SetActive(var_3_25, true)

			local var_3_26 = var_3_25.transform

			var_3_26:SetParent(manager.ui.mainCamera.transform)

			var_3_26.localPosition = Vector3(0, 0, 27)
			var_3_26.localEulerAngles = Vector3(0, 0, 0)
			var_3_26.localScale = Vector3.one

			local var_3_27 = var_3_26:GetComponent("SpriteRenderer")
			local var_3_28 = var_3_2 / var_3_0.aspect
			local var_3_29 = var_3_2
			local var_3_30 = var_3_2 * 0.5625
			local var_3_31 = var_3_2

			if var_3_30 < var_3_28 then
				var_3_30 = var_3_28
				var_3_31 = var_3_30 / 0.5625
			end

			var_3_27.size = Vector2.New(var_3_31, var_3_30)
		else
			SetActive(var_3_25, false)
		end
	end

	local var_3_32 = GameObject.Find("object/long/bg")

	if var_3_32 then
		var_3_32.transform.localScale = Vector3.New(var_3_6 / 3.9, 1, 1)
	end

	local var_3_33 = GameObject.Find("object/short")

	if var_3_33 then
		var_3_33.transform.localScale = Vector3.New(var_3_6 / 7.5, 1, 1)
	end
end

function var_0_0.OnMusicSceneLoaded()
	var_0_1 = GameLocalData:GetCommonModule("userSetting").frame or PictureQualitySettingCfg[5].frame

	if var_0_1 == 0 then
		SettingAction.ChangePicSetting("frame", 1)
	end

	MusicLuaBridge.StartMusicGame()
	manager.notify:CallUpdateFunc(MUSIC_SCENE_LOADED)
end

function var_0_0.OnMusicSceneExit()
	if var_0_1 == 0 then
		SettingAction.ChangePicSetting("frame", 0)
	end

	gameContext:SetSystemLayer("home")

	local var_5_0 = SettingData:GetSoundSettingData()

	if var_5_0 and var_5_0.music then
		manager.audio:SetVolume("music", var_5_0.music / 100)
	end
end

function var_0_0.MusicInitPlay()
	MusicData:ResetGameData()
	manager.notify:CallUpdateFunc(MUSIC_INIT_PLAY)

	local var_6_0 = SettingData:GetSoundSettingData()

	if var_6_0 and var_6_0.music then
		manager.audio:SetVolume("music", var_6_0.music / 100)
	end
end

function var_0_0.MusicNodeHit(arg_7_0, arg_7_1)
	MusicData:ModifGameData(arg_7_0)
	manager.notify:CallUpdateFunc(MUSIC_NODE_HIT, arg_7_0, arg_7_1)
end

function var_0_0.MusicSetNodeHit(arg_8_0, arg_8_1)
	MusicData:ModifGameData(arg_8_0)
	manager.notify:CallUpdateFunc(MUSIC_SET_NODE_HIT, arg_8_0, arg_8_1)
end

function var_0_0.OnMusicOver()
	local var_9_0 = MusicData:GetGameScore()
	local var_9_1 = MusicData:GetGameId()

	if var_9_1 == 0 then
		MusicAction.GoToMusicMain()

		return
	end

	MusicAction.QueryCompelet(var_9_1, var_9_0)
end

function var_0_0.OnSpecialEffectTriggerEvent(arg_10_0)
	manager.notify:CallUpdateFunc(MUSIC_SPECIAL_EFFECT_TRIGGER, arg_10_0)
end

function var_0_0.OnMusicActiveExit()
	MusicAction.GoToMusicMain()
end

function var_0_0.OnMusicPause()
	local var_12_0 = MusicData:GetGameId()
	local var_12_1 = ActivityMusicCfg[var_12_0].activity_id
	local var_12_2 = MusicData:GetMusicViewPathList(var_12_1)

	JumpTools.OpenPageByJump(var_12_2.musicStop)
end

function var_0_0.GetTrackKeySetData(arg_13_0)
	return MusicData:GetTrackKeySetData(arg_13_0)
end

return var_0_0
