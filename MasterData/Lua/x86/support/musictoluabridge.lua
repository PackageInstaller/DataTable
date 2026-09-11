local var_0_0 = {}
local var_0_1

function var_0_0.SetUpMusic()
	SceneManager.SetActiveScene((SceneManager.GetSceneByName("X106")))
	manager.uiInit()

	local var_1_0 = MusicData:GetGameId()

	JumpTools.OpenPageByJump(MusicData:GetMusicViewPathList(ActivityMusicCfg[var_1_0].activity_id).musicName)
	gameContext:SetSystemLayer("battle")
	manager.audio:DestoryCriAtom()
	manager.audio:SetEffectAisacControl("musicgame_hitsound_volume", MusicData:GetVolumeData())

	local var_1_1 = MusicLuaBridge.GetTrackNum()

	if var_1_1 < 4 then
		for iter_1_0 = 4, var_1_1 + 1, -1 do
			local var_1_2 = GameObject.Find("Music/gameRoot/Track" .. iter_1_0)

			if var_1_2 then
				SetActive(var_1_2, false)
			end
		end
	end

	local var_1_3 = MusicData:GetTrackPathType()
	local var_1_4 = MusicData:GetTrackPathType() == MusicConst.MusicTrackType.Vertical

	if var_1_3 == MusicConst.MusicTrackType.Constant_Slope then
		manager.ui:SetMainCamera("musicConstant")
		MusicToLuaBridge.slantAdapt(var_1_1)
	elseif var_1_4 then
		manager.ui:SetMainCamera("musicVertical")
		MusicToLuaBridge.verticalAdapt(var_1_1)
	else
		manager.ui:SetMainCamera("music")
		MusicToLuaBridge.slantAdapt(var_1_1)
	end

	local var_1_5 = GameObject.Find("movie")

	if var_1_5 then
		var_1_5:GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music_bg/" .. ActivityMusicCfg[var_1_0].icon)
	end
end

function var_0_0.verticalAdapt(arg_2_0)
	local var_2_0 = manager.ui.mainCameraCom_
	local var_2_1
	local var_2_3 = GameObject.Find("gameRoot/center")

	var_2_1 = var_2_3 and 1.5 * math.abs(manager.ui.mainCamera.transform:InverseTransformPoint(var_2_3.transform.position).z) * Mathf.Tan(var_2_0.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_2_0.aspect or 40

	if arg_2_0 <= 4 or not (arg_2_0 - 1) then
		-- block empty
	end

	local var_2_6 = Vector3.New(var_2_1 / (arg_2_0 + 1) * 1.2, 99, 0.2)

	cell_value_list = {}

	for iter_2_0 = 0, arg_2_0 - 1 do
		cell_value_list[iter_2_0 + 1] = -((arg_2_0 - 1) / 2) + iter_2_0
	end

	local var_2_7 = Vector3.New(0.1, 0, 0)
	local var_2_8 = Vector3(0, -1, 0)

	for iter_2_1 = 1, arg_2_0 do
		local var_2_9 = GameObject.Find("Music/gameRoot/Track" .. iter_2_1)

		var_2_9.transform.localPosition = Vector3(var_2_1 / (arg_2_0 + 1) * 1.2 * cell_value_list[iter_2_1], -22.9, 0)
		var_2_9:GetComponent("BoxCollider").size = var_2_6

		local var_2_10 = var_2_9.transform:Find("bg/leftLine")

		if var_2_10 then
			var_2_10.localPosition = Vector3.New(-1 * (var_2_1 / (arg_2_0 + 1) * 1.2 / 2) + 0, 0, 0)
		end

		local var_2_11 = var_2_9.transform:Find("bg/line")

		if var_2_11 then
			var_2_11.localPosition = Vector3.New(var_2_1 / (arg_2_0 + 1) * 1.2 / 2 + 0 + 0.1, 0, 0)
		end

		local var_2_12 = var_2_9.transform:Find("bg/clickEffect/eff_glow/glow")

		if var_2_12 then
			var_2_12:GetComponent("SpriteRenderer").size = Vector2.New(var_2_1 / (arg_2_0 + 1) * 1.2, 5.12)
		end

		local var_2_13 = var_2_9.transform:Find("effectContent")

		var_2_13.localEulerAngles = Vector3.zero
		var_2_13.localPosition = var_2_8
		var_2_9.transform:Find("nodeContent").localPosition = var_2_7
	end

	local var_2_14 = GameObject.Find("Music/background/frame")

	if var_2_14 then
		local var_2_15 = var_2_14:GetComponent("SpriteRenderer")

		var_2_15.size = Vector2.New(var_2_1 / (arg_2_0 + 1) * 1.2 * arg_2_0, var_2_15.size.y)
	end

	local var_2_16 = GameObject.Find("Music/background/mask")

	if var_2_16 then
		var_2_16:GetComponent("SpriteRenderer").size = Vector2.New(var_2_1 / (arg_2_0 + 1) * 1.2 * arg_2_0 - 0.1, 999)
	end

	local var_2_17 = 1 * Mathf.Tan(var_2_0.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_2_0.aspect
	local var_2_18 = GameObject.Find("movie")

	if var_2_18 then
		if MusicData:GetShowMovie() then
			SetActive(var_2_18, true)
			var_2_18.transform:SetParent(manager.ui.mainCamera.transform)

			var_2_18.transform.localPosition = Vector3(0, 0, 27)
			var_2_18.transform.localEulerAngles = Vector3(0, 0, 0)
			var_2_18.transform.localScale = Vector3.one
			var_2_18.transform:GetComponent("SpriteRenderer").size = Vector2.New(var_2_1, var_2_1 * 0.5625)
		else
			SetActive(var_2_18, false)
		end
	end

	local var_2_19 = GameObject.Find("object/long/bg")

	if var_2_19 then
		var_2_19.transform.localScale = Vector3.New(var_2_1 / (arg_2_0 + 1) * 1.2 / 3.9, 1, 1)
	end

	local var_2_20 = GameObject.Find("object/short")

	if var_2_20 then
		var_2_20.transform.localScale = Vector3.New(var_2_1 / (arg_2_0 + 1) * 1.2 / 7.5, 1, 1)
	end

	local var_2_21 = GameObject.Find("object/good_effect_chuizhi").transform
	local var_2_22 = GameObject.Find("object/perfect_effect_chuizhi").transform
	local var_2_23 = Vector3.one * ({
		nil,
		nil,
		nil,
		1.8,
		1.7,
		1.6
	})[arg_2_0]

	for iter_2_2 = 0, var_2_21.childCount - 1 do
		var_2_21:GetChild(iter_2_2).localScale = var_2_23
	end

	for iter_2_3 = 0, var_2_22.childCount - 1 do
		var_2_22:GetChild(iter_2_3).localScale = var_2_23
	end

	local var_2_24 = GameObject.Find("Pool").transform

	for iter_2_4 = 0, var_2_24.childCount - 1 do
		local var_2_25 = var_2_24:GetChild(iter_2_4)

		if var_2_25 then
			for iter_2_5 = 0, var_2_25.childCount - 1 do
				var_2_25:GetChild(iter_2_5).localScale = var_2_23
			end
		end
	end

	GameObject.Find("cubeLeft").transform.transform.localPosition = Vector3.New(-50, 0, 0)
	GameObject.Find("cubeRight").transform.transform.localPosition = Vector3.New(50, 0, 0)
end

function var_0_0.slantAdapt(arg_3_0)
	local var_3_0 = manager.ui.mainCameraCom_
	local var_3_1
	local var_3_2 = GameObject.Find("gameRoot/center")

	var_3_1 = var_3_2 and 2 * math.abs(manager.ui.mainCamera.transform:InverseTransformPoint(var_3_2.transform.position).z) * Mathf.Tan(var_3_0.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_3_0.aspect or 40

	local var_3_3 = var_3_1 / (arg_3_0 + 1)
	local var_3_4 = var_3_1 / (arg_3_0 + 1) / 2
	local var_3_5 = 0
	local var_3_6 = Vector3.New(var_3_1 / (arg_3_0 + 1), 99, 0.2)
	local var_3_7 = Vector3.New(var_3_1 / (arg_3_0 + 1) * 1.3, 99, 0.2)
	local var_3_8 = {}

	for iter_3_0 = 1, arg_3_0 do
		var_3_8[iter_3_0] = 30 + (iter_3_0 - arg_3_0 * 0.5 + (iter_3_0 - arg_3_0 * 0.5 > 0 and 1 or -1)) * 5
	end

	local var_3_9 = {}

	for iter_3_1 = 0, arg_3_0 - 1 do
		var_3_9[iter_3_1 + 1] = -((arg_3_0 - 1) / 2) + iter_3_1
	end

	for iter_3_2 = 1, arg_3_0 do
		local var_3_10 = GameObject.Find("Music/gameRoot/Track" .. iter_3_2)

		var_3_10.transform.localPosition = Vector3.New(var_3_3 * var_3_9[iter_3_2], -22.9, 0)

		local var_3_11 = var_3_10:GetComponent("BoxCollider")

		if iter_3_2 == 1 then
			var_3_11.center = Vector3.New(-var_3_3 * 0.15, 0, 0)
			var_3_11.size = var_3_7
		elseif iter_3_2 == arg_3_0 then
			var_3_11.center = Vector3.New(var_3_3 * 0.15, 0, 0)
			var_3_11.size = var_3_7
		else
			var_3_11.size = var_3_6
		end

		local var_3_12 = var_3_10.transform
		local var_3_13 = var_3_10.transform:Find("bg/leftLine")

		if var_3_13 then
			var_3_13.localPosition = Vector3.New(-1 * var_3_4 - var_3_5, 0, 0)
		end

		local var_3_14 = var_3_12:Find("bg/line")

		if var_3_14 then
			var_3_14.localPosition = Vector3.New(var_3_4 + var_3_5, 0, 0)
		end

		local var_3_15 = var_3_12:Find("bg/clickEffect/eff_glow/glow")

		if var_3_15 then
			var_3_15:GetComponent("SpriteRenderer").size = Vector2.New(var_3_3 + 0.1, 5.12)
		end

		if var_3_8[iter_3_2] then
			var_3_12:Find("effectContent").localEulerAngles = Vector3(0, var_3_8[iter_3_2], 0)
		end
	end

	local var_3_16 = GameObject.Find("Music/background/frame")

	if var_3_16 then
		local var_3_17 = var_3_16:GetComponent("SpriteRenderer")

		var_3_17.size = Vector2.New(var_3_3 * arg_3_0, var_3_17.size.y)
	end

	local var_3_18 = GameObject.Find("Music/background/mask")

	if var_3_18 then
		var_3_18:GetComponent("SpriteRenderer").size = Vector2.New(var_3_3 * arg_3_0 - 0.1, 999)
	end

	local var_3_19 = GameObject.Find("movie")

	if var_3_19 then
		if MusicData:GetShowMovie() then
			SetActive(var_3_19, true)
			var_3_19.transform:SetParent(manager.ui.mainCamera.transform)

			var_3_19.transform.localPosition = Vector3(0, 0, 27)
			var_3_19.transform.localEulerAngles = Vector3(0, 0, 0)
			var_3_19.transform.localScale = Vector3.one

			local var_3_21 = var_3_1 * 0.5625
			local var_3_22 = var_3_1

			if var_3_1 * 0.5625 < var_3_1 / var_3_0.aspect then
				var_3_21 = var_3_1 / var_3_0.aspect
				var_3_22 = var_3_1 / var_3_0.aspect / 0.5625
			end

			var_3_19.transform:GetComponent("SpriteRenderer").size = Vector2.New(var_3_22, var_3_21)
		else
			SetActive(var_3_19, false)
		end
	end

	local var_3_23 = GameObject.Find("object/long/bg")

	if var_3_23 then
		var_3_23.transform.localScale = Vector3.New(var_3_3 / 3.9, 1, 1)
	end

	local var_3_24 = GameObject.Find("object/short")

	if var_3_24 then
		var_3_24.transform.localScale = Vector3.New(var_3_3 / 7.5, 1, 1)
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
	local var_9_0 = MusicData:GetGameId()

	if var_9_0 == 0 then
		MusicAction.GoToMusicMain()

		return
	end

	MusicAction.QueryCompelet(var_9_0, (MusicData:GetGameScore()))
end

function var_0_0.OnSpecialEffectTriggerEvent(arg_10_0)
	manager.notify:CallUpdateFunc(MUSIC_SPECIAL_EFFECT_TRIGGER, arg_10_0)
end

function var_0_0.OnMusicActiveExit()
	MusicAction.GoToMusicMain()
end

function var_0_0.OnMusicPause()
	JumpTools.OpenPageByJump(MusicData:GetMusicViewPathList(ActivityMusicCfg[MusicData:GetGameId()].activity_id).musicStop)
end

function var_0_0.GetTrackKeySetData(arg_13_0)
	return MusicData:GetTrackKeySetData(arg_13_0)
end

return var_0_0
