local var_0_0 = class("V210MusicSettingView", ReduxView)
local var_0_1 = 5
local var_0_2 = 1
local var_0_3 = 50
local var_0_4 = -50
local var_0_5 = 50
local var_0_6 = -50
local var_0_7 = 100
local var_0_8 = 0

function var_0_0.UIName(arg_1_0)
	local var_1_0 = MusicData:GetNowMusicUINameList()

	if var_1_0 and var_1_0.settingView then
		return var_1_0.settingView
	else
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicSetUI"
	end
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
	arg_3_0:InitMusicSet()

	arg_3_0.isVertical = MusicData:GetVerical()
	arg_3_0.spectralType = MusicData:GetSpectralType()

	arg_3_0:SetMusicCamera()

	arg_3_0.speedNum = 0
	arg_3_0.judgeNum = 0
	arg_3_0.screanNum = 0
	arg_3_0.showMovie = true
	arg_3_0.test = true
end

function var_0_0.InitMusicSet(arg_4_0)
	if arg_4_0.musicSetGo then
		return
	end

	local var_4_0 = Asset.Load("Music/V210MusicSet")

	arg_4_0.musicSetGo = Object.Instantiate(var_4_0)
	arg_4_0.musicSetController = arg_4_0.musicSetGo:GetComponent("MusicSetController")
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.m_speedSlider.minValue = var_0_2
	arg_5_0.m_speedSlider.maxValue = var_0_1
	arg_5_0.m_judgeSlider.minValue = var_0_4
	arg_5_0.m_judgeSlider.maxValue = var_0_3
	arg_5_0.m_screanSlider.minValue = var_0_6
	arg_5_0.m_screanSlider.maxValue = var_0_5
	arg_5_0.m_volumeSlider.minValue = var_0_8
	arg_5_0.m_volumeSlider.maxValue = var_0_7
	arg_5_0.ratingController = ControllerUtil.GetController(arg_5_0.transform_, "rating")
	arg_5_0.testController = ControllerUtil.GetController(arg_5_0.transform_, "test")
	arg_5_0.pathController = ControllerUtil.GetController(arg_5_0.transform_, "path")
	arg_5_0.spectralController = ControllerUtil.GetController(arg_5_0.transform_, "spectral")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0.m_speedSlider.onValueChanged:AddListener(function()
		local var_7_0 = string.format("%.1f", arg_6_0.m_speedSlider.value)

		arg_6_0.speedNum = tonumber(var_7_0)
		arg_6_0.m_speedLab.text = arg_6_0.speedNum

		arg_6_0:ChangeSpeed()
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.m_speedAddBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_6_0.speedNum < var_0_1 then
			arg_6_0.speedNum = arg_6_0.speedNum + 0.1
			arg_6_0.speedNum = math.min(arg_6_0.speedNum, var_0_1)
			arg_6_0.m_speedSlider.value = arg_6_0.speedNum
			arg_6_0.m_speedLab.text = arg_6_0.speedNum

			arg_6_0:ChangeSpeed()

			return true
		end

		return false
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.m_speedDelBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_6_0.speedNum > var_0_2 then
			arg_6_0.speedNum = arg_6_0.speedNum - 0.1
			arg_6_0.speedNum = math.max(arg_6_0.speedNum, var_0_2)
			arg_6_0.m_speedSlider.value = arg_6_0.speedNum
			arg_6_0.m_speedLab.text = arg_6_0.speedNum

			arg_6_0:ChangeSpeed()

			return true
		end

		return false
	end)
	arg_6_0.m_judgeSlider.onValueChanged:AddListener(function()
		local var_10_0 = string.format("%.0f", arg_6_0.m_judgeSlider.value)

		arg_6_0.judgeNum = tonumber(var_10_0)
		arg_6_0.m_judgeLab.text = arg_6_0.judgeNum

		arg_6_0:ChangeJudge()
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.m_judgeAddBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_6_0.judgeNum < var_0_3 then
			arg_6_0.judgeNum = arg_6_0.judgeNum + 1
			arg_6_0.judgeNum = math.min(arg_6_0.judgeNum, var_0_3)
			arg_6_0.m_judgeSlider.value = arg_6_0.judgeNum
			arg_6_0.m_judgeLab.text = arg_6_0.judgeNum

			arg_6_0:ChangeJudge()

			return true
		end

		return false
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.m_judgeDelBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_6_0.judgeNum > var_0_4 then
			arg_6_0.judgeNum = arg_6_0.judgeNum - 1
			arg_6_0.judgeNum = math.max(arg_6_0.judgeNum, var_0_4)
			arg_6_0.m_judgeSlider.value = arg_6_0.judgeNum
			arg_6_0.m_judgeLab.text = arg_6_0.judgeNum

			arg_6_0:ChangeJudge()

			return true
		end

		return false
	end)
	arg_6_0.m_screanSlider.onValueChanged:AddListener(function()
		local var_13_0 = string.format("%.0f", arg_6_0.m_screanSlider.value)

		arg_6_0.screanNum = tonumber(var_13_0)
		arg_6_0.m_screanLab.text = arg_6_0.screanNum

		arg_6_0:ChangeScreen()
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.m_screanAddBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_6_0.screanNum < var_0_5 then
			arg_6_0.screanNum = arg_6_0.screanNum + 1
			arg_6_0.screanNum = math.min(arg_6_0.screanNum, var_0_5)
			arg_6_0.m_screanSlider.value = arg_6_0.screanNum
			arg_6_0.m_screanLab.text = arg_6_0.screanNum

			arg_6_0:ChangeScreen()

			return true
		end

		return false
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.m_screanDelBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_6_0.screanNum > var_0_6 then
			arg_6_0.screanNum = arg_6_0.screanNum - 1
			arg_6_0.screanNum = math.max(arg_6_0.screanNum, var_0_6)
			arg_6_0.m_screanSlider.value = arg_6_0.screanNum
			arg_6_0.m_screanLab.text = arg_6_0.screanNum

			arg_6_0:ChangeScreen()

			return true
		end

		return false
	end)
	arg_6_0.m_volumeSlider.onValueChanged:AddListener(function()
		local var_16_0 = string.format("%.0f", arg_6_0.m_volumeSlider.value)

		arg_6_0.volumeNum = tonumber(var_16_0)
		arg_6_0.m_volumeLab.text = arg_6_0.volumeNum

		arg_6_0:ChangeVolume()
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.m_volumeAddBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_6_0.volumeNum < var_0_7 then
			arg_6_0.volumeNum = arg_6_0.volumeNum + 1
			arg_6_0.volumeNum = math.min(arg_6_0.volumeNum, var_0_7)
			arg_6_0.m_volumeSlider.value = arg_6_0.volumeNum
			arg_6_0.m_volumeLab.text = arg_6_0.volumeNum

			arg_6_0:ChangeVolume()

			return true
		end

		return false
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.m_volumeDelBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_6_0.volumeNum > var_0_8 then
			arg_6_0.volumeNum = arg_6_0.volumeNum - 1
			arg_6_0.volumeNum = math.max(arg_6_0.volumeNum, var_0_8)
			arg_6_0.m_volumeSlider.value = arg_6_0.volumeNum
			arg_6_0.m_volumeLab.text = arg_6_0.volumeNum

			arg_6_0:ChangeVolume()

			return true
		end

		return false
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_testOn, nil, function()
		arg_6_0:ChangeTestBool(true)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_testOff, nil, function()
		arg_6_0:ChangeTestBool(false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_pathOn, nil, function()
		arg_6_0:ChangeVericalBool(false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_pathOff, nil, function()
		arg_6_0:ChangeVericalBool(true)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_mirrorOn, nil, function()
		arg_6_0:ChangeSpectralType(MusicConst.MusicSpectralType.Mirror)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_mirrorOff, nil, function()
		arg_6_0:ChangeSpectralType(MusicConst.MusicSpectralType.None)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_RandomOn, nil, function()
		arg_6_0:ChangeSpectralType(MusicConst.MusicSpectralType.Random)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_RandomOff, nil, function()
		arg_6_0:ChangeSpectralType(MusicConst.MusicSpectralType.None)
	end)
end

function var_0_0.OnTop(arg_27_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_28_0)
	arg_28_0:InitMusicSet()
	arg_28_0:SetMusicCamera()
	arg_28_0.ratingController:SetSelectedIndex(0)
	arg_28_0:InitBackScene()

	arg_28_0.isVertical = MusicData:GetVerical()
	arg_28_0.spectralType = MusicData:GetSpectralType()
	arg_28_0.speedNum = MusicData:GetSpeedValue(arg_28_0.isVertical)
	arg_28_0.m_speedSlider.value = arg_28_0.speedNum
	arg_28_0.m_speedLab.text = arg_28_0.speedNum

	arg_28_0:ChangeSpeed()

	arg_28_0.judgeNum = MusicData:GetJudgeValue()
	arg_28_0.m_judgeSlider.value = arg_28_0.judgeNum
	arg_28_0.m_judgeLab.text = arg_28_0.judgeNum

	arg_28_0:ChangeJudge()

	arg_28_0.screanNum = MusicData:GetScreanValue()
	arg_28_0.m_screanSlider.value = arg_28_0.screanNum
	arg_28_0.m_screanLab.text = arg_28_0.screanNum

	arg_28_0:ChangeScreen()

	arg_28_0.volumeNum = MusicData:GetVolumeValue()
	arg_28_0.m_volumeSlider.value = arg_28_0.volumeNum
	arg_28_0.m_volumeLab.text = arg_28_0.volumeNum

	arg_28_0:ChangeVolume()
	arg_28_0:ChangeVericalBool(arg_28_0.isVertical, true)
	arg_28_0:ChangeSpectralType(arg_28_0.spectralType)

	arg_28_0.test = arg_28_0.musicSetController.autoClick

	arg_28_0.testController:SetSelectedIndex(arg_28_0.test and 1 or 0)
	SetActive(arg_28_0.musicSetGo, true)

	arg_28_0.raycaster = manager.ui.mainCamera:AddComponent(typeof(PhysicsRaycaster))

	arg_28_0.musicSetController:Begain()
end

function var_0_0.OnExit(arg_29_0)
	manager.windowBar:HideBar()

	if arg_29_0.raycaster then
		Object.Destroy(arg_29_0.raycaster_)
	end

	arg_29_0.musicSetController:End()

	if manager.windowBar:GetWhereTag() == "qworld" then
		QWorldMgr:EnableCamera(QWorldCameraFlag.Player)

		if arg_29_0.musicSetGo then
			Asset.Unload("Music/V210MusicSet")
			Object.Destroy(arg_29_0.musicSetGo)

			arg_29_0.musicSetGo = nil
		end
	end

	MusicData:SetSpeedValue(arg_29_0.speedNum, arg_29_0.isVertical)
	MusicData:SetJudgeValue(arg_29_0.judgeNum)
	MusicData:SetScreanValue(arg_29_0.screanNum)
	MusicData:SetVolumeValue(arg_29_0.volumeNum)
	MusicData:SetShoMovie(arg_29_0.showMovie)
	MusicData:SetVerical(arg_29_0.isVertical)
	MusicData:SetSpectralType(arg_29_0.spectralType)
	SDKTools.SendMessageToSDK("activity_music_setting", {
		activity_id = ActivityConst.VOLUME_MUSIC,
		speed = tostring(arg_29_0.speedNum),
		time = tostring(arg_29_0.judgeNum),
		other_data = MusicData:GetSpectralAndVercialSDKKey()
	})

	if arg_29_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_29_0.backGround_, ASSET_TYPE.SCENE)
	end

	if arg_29_0.sceneSetting_ then
		arg_29_0.sceneSetting_.enabled = true
	end
end

function var_0_0.SetMusicCamera(arg_30_0)
	if arg_30_0.isVertical then
		if manager.windowBar:GetWhereTag() == "qworld" then
			QWorldMgr:EnableCamera(QWorldCameraFlag.CustomCamera, "musicVerticalCamera")
		else
			manager.ui:SetMainCamera("musicSetVertical")
		end
	elseif manager.windowBar:GetWhereTag() == "qworld" then
		QWorldMgr:EnableCamera(QWorldCameraFlag.CustomCamera, "musicCamera")
	else
		manager.ui:SetMainCamera("musicSet")
	end

	if arg_30_0.AdaptiveTimer then
		arg_30_0.AdaptiveTimer:Stop()

		arg_30_0.AdaptiveTimer = nil
	end

	arg_30_0.AdaptiveTimer = FrameTimer.New(function()
		arg_30_0:AdaptiveSetGo()
	end, 1, 1)

	arg_30_0.AdaptiveTimer:Start()
end

function var_0_0.AdaptiveSetGo(arg_32_0)
	local var_32_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_32_1 = arg_32_0.setPosTrs_.position
	local var_32_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_32_0, var_32_1)
	local var_32_3 = manager.ui.mainCamera.transform.localPosition.z
	local var_32_4 = manager.ui.mainCameraCom_:ScreenToWorldPoint(Vector3(var_32_2.x, var_32_2.y, 50)).x + (arg_32_0.isVertical and 0 or 3)

	arg_32_0.musicSetGo.transform.position = Vector3(var_32_4, 0, 0)
end

function var_0_0.ChangeSpeed(arg_33_0)
	local var_33_0 = 5 - arg_33_0.speedNum
	local var_33_1 = 1500
	local var_33_2 = 350
	local var_33_3 = var_33_2 + var_33_0 * (var_33_1 - var_33_2) / 4

	arg_33_0.musicSetController.stayTime = var_33_3
end

function var_0_0.ChangeJudge(arg_34_0)
	local var_34_0 = arg_34_0.judgeNum
	local var_34_1 = math.abs(var_34_0) / 50 * 300

	if var_34_0 < 0 then
		var_34_1 = -1 * var_34_1
	end

	MusicGame.MusicSetController.latency = var_34_1 - 42
end

function var_0_0.ChangeScreen(arg_35_0)
	local var_35_0 = arg_35_0.screanNum
	local var_35_1 = math.abs(var_35_0) / 50 * 300

	if var_35_0 < 0 then
		var_35_1 = -1 * var_35_1
	end

	MusicGame.MusicSetController.judgeLatency = var_35_1
end

function var_0_0.ChangeVolume(arg_36_0)
	local var_36_0 = arg_36_0.volumeNum
	local var_36_1 = math.abs(var_36_0) / 100

	manager.audio:SetEffectAisacControl("musicgame_hitsound_volume", var_36_1)
end

function var_0_0.ChangeTestBool(arg_37_0, arg_37_1)
	if arg_37_0.test == arg_37_1 then
		return
	end

	arg_37_0.test = arg_37_1

	arg_37_0.testController:SetSelectedIndex(arg_37_0.test and 1 or 0)

	arg_37_0.musicSetController.autoClick = arg_37_1
end

function var_0_0.ChangeSpectralType(arg_38_0, arg_38_1)
	arg_38_0.spectralType = arg_38_1

	local var_38_0

	if arg_38_1 == MusicConst.MusicSpectralType.None then
		var_38_0 = 0
	elseif arg_38_1 == MusicConst.MusicSpectralType.Mirror then
		var_38_0 = 1
	elseif arg_38_1 == MusicConst.MusicSpectralType.Random then
		var_38_0 = 2
	end

	if var_38_0 then
		arg_38_0.spectralController:SetSelectedIndex(var_38_0)
	end
end

function var_0_0.ChangeVericalBool(arg_39_0, arg_39_1, arg_39_2)
	if not arg_39_2 and arg_39_1 == arg_39_0.isVertical then
		return
	end

	MusicData:SetSpeedValue(arg_39_0.speedNum, arg_39_0.isVertical)

	arg_39_0.isVertical = arg_39_1
	arg_39_0.speedNum = MusicData:GetSpeedValue(arg_39_0.isVertical)
	arg_39_0.m_speedSlider.value = arg_39_0.speedNum
	arg_39_0.m_speedLab.text = arg_39_0.speedNum

	arg_39_0.pathController:SetSelectedIndex(arg_39_0.isVertical and 0 or 1)

	MusicGame.MusicSetController.isVertical = arg_39_1

	arg_39_0:ChangeSpeed()
	arg_39_0:SetMusicCamera()
end

function var_0_0.InitBackScene(arg_40_0)
	local var_40_0 = "UI/Common/BackgroundQuad"

	arg_40_0.backGround_ = manager.resourcePool:Get(var_40_0, ASSET_TYPE.SCENE)
	arg_40_0.backGroundTrs_ = arg_40_0.backGround_.transform

	arg_40_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	arg_40_0.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	arg_40_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	arg_40_0.backGroundTrs_.localScale = Vector3(11, 11, 1)
	arg_40_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = arg_40_0.bgImg_.sprite

	local var_40_1 = QWorldData:GetCurSceneName()

	arg_40_0.sceneSetting_ = manager.ui:GetSceneSettingBySceneName(var_40_1)
	arg_40_0.sceneSetting_.enabled = false
end

function var_0_0.OnMusicSetNodeHit(arg_41_0, arg_41_1, arg_41_2)
	SetActive(arg_41_0.m_effect, false)
	SetActive(arg_41_0.m_effect, true)

	if arg_41_1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == arg_41_2 or MusicConst.MusicNodeHitType.Long == arg_41_2) then
		manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_musicgame_hitsound", "")
	end

	if MusicConst.MusicNodeHitRating.PerfectPlus == arg_41_1 then
		arg_41_0.ratingController:SetSelectedIndex(4)
	elseif MusicConst.MusicNodeHitRating.Perfect == arg_41_1 then
		arg_41_0.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == arg_41_1 then
		arg_41_0.ratingController:SetSelectedIndex(2)
	else
		arg_41_0.ratingController:SetSelectedIndex(1)
	end
end

function var_0_0.Dispose(arg_42_0)
	var_0_0.super.Dispose(arg_42_0)
end

return var_0_0
