local var_0_0 = class("ResidentMusicSettingView", ReduxView)
local var_0_1 = 5
local var_0_2 = 1
local var_0_3 = 50
local var_0_4 = -50
local var_0_5 = 50
local var_0_6 = -50
local var_0_7 = 100
local var_0_8 = 0
local var_0_9 = 0
local var_0_10 = 1

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicSetUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
	arg_3_0:InitMusicSet()

	arg_3_0.trackPathType = MusicData:GetTrackPathType()
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
	arg_5_0:InitKeySetUI()

	arg_5_0.m_speedSlider.minValue = var_0_2
	arg_5_0.m_speedSlider.maxValue = var_0_1
	arg_5_0.m_judgeSlider.minValue = var_0_4
	arg_5_0.m_judgeSlider.maxValue = var_0_3
	arg_5_0.m_screanSlider.minValue = var_0_6
	arg_5_0.m_screanSlider.maxValue = var_0_5
	arg_5_0.m_volumeSlider.minValue = var_0_8
	arg_5_0.m_volumeSlider.maxValue = var_0_7
	arg_5_0.m_mixSlider.minValue = var_0_9
	arg_5_0.m_mixSlider.maxValue = var_0_10
	arg_5_0.ratingController = ControllerUtil.GetController(arg_5_0.transform_, "rating")
	arg_5_0.testController = ControllerUtil.GetController(arg_5_0.transform_, "test")
	arg_5_0.pathController = ControllerUtil.GetController(arg_5_0.transform_, "path")
	arg_5_0.spectralController = ControllerUtil.GetController(arg_5_0.transform_, "spectral")
	arg_5_0.showStateController = ControllerUtil.GetController(arg_5_0.transform_, "showState")
	arg_5_0.keyPosController = ControllerUtil.GetController(arg_5_0.transform_, "Keyposition")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.keySetBtn_, nil, function()
		arg_6_0.showStateController:SetSelectedState("keySet")
	end)
	arg_6_0.m_speedSlider.onValueChanged:AddListener(function()
		local var_8_0 = string.format("%.1f", arg_6_0.m_speedSlider.value)

		arg_6_0.speedNum = tonumber(var_8_0)
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
		local var_11_0 = string.format("%.0f", arg_6_0.m_judgeSlider.value)

		arg_6_0.judgeNum = tonumber(var_11_0)
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
		local var_14_0 = string.format("%.0f", arg_6_0.m_screanSlider.value)

		arg_6_0.screanNum = tonumber(var_14_0)
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
		local var_17_0 = string.format("%.0f", arg_6_0.m_volumeSlider.value)

		arg_6_0.volumeNum = tonumber(var_17_0)
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
	arg_6_0.m_mixSlider.onValueChanged:AddListener(function()
		local var_20_0 = string.format("%.1f", arg_6_0.m_mixSlider.value)

		arg_6_0.mixNum = tonumber(var_20_0)
		arg_6_0.m_mixValueLab.text = arg_6_0.mixNum

		arg_6_0:ChangeMixValue()
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.m_mixAddBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_6_0.mixNum < var_0_10 then
			arg_6_0.mixNum = arg_6_0.mixNum + 0.1
			arg_6_0.mixNum = math.min(arg_6_0.mixNum, var_0_10)
			arg_6_0.m_mixSlider.value = arg_6_0.mixNum
			arg_6_0.m_mixValueLab.text = arg_6_0.mixNum

			arg_6_0:ChangeMixValue()

			return true
		end

		return false
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.m_mixMinusBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_6_0.mixNum > var_0_9 then
			arg_6_0.mixNum = arg_6_0.mixNum - 0.1
			arg_6_0.mixNum = math.max(arg_6_0.mixNum, var_0_9)
			arg_6_0.m_mixSlider.value = arg_6_0.mixNum
			arg_6_0.m_mixValueLab.text = arg_6_0.mixNum

			arg_6_0:ChangeMixValue()

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
	arg_6_0:AddBtnListener(arg_6_0.m_slopeOn, nil, function()
		arg_6_0:ChangeTrackPath(MusicConst.MusicTrackType.Slope)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_verticalOn, nil, function()
		arg_6_0:ChangeTrackPath(MusicConst.MusicTrackType.Vertical)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_evenSlopeOn, nil, function()
		arg_6_0:ChangeTrackPath(MusicConst.MusicTrackType.Constant_Slope)
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

function var_0_0.OnTop(arg_32_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.OnEnter(arg_33_0)
	SetActive(arg_33_0.musicSetGo, true)

	arg_33_0.raycaster = manager.ui.mainCamera:AddComponent(typeof(PhysicsRaycaster))

	arg_33_0.musicSetController:Begain()
	arg_33_0:InitMusicSet()
	arg_33_0:SetMusicCamera()
	arg_33_0.ratingController:SetSelectedIndex(0)
	arg_33_0:InitBackScene()

	arg_33_0.trackPathType = MusicData:GetTrackPathType()
	arg_33_0.spectralType = MusicData:GetSpectralType()
	arg_33_0.speedNum = MusicData:GetSpeedValue(arg_33_0.trackPathType)
	arg_33_0.m_speedSlider.value = arg_33_0.speedNum
	arg_33_0.m_speedLab.text = arg_33_0.speedNum

	arg_33_0:ChangeSpeed()

	arg_33_0.judgeNum = MusicData:GetJudgeValue()
	arg_33_0.m_judgeSlider.value = arg_33_0.judgeNum
	arg_33_0.m_judgeLab.text = arg_33_0.judgeNum

	arg_33_0:ChangeJudge()

	arg_33_0.screanNum = MusicData:GetScreanValue()
	arg_33_0.m_screanSlider.value = arg_33_0.screanNum
	arg_33_0.m_screanLab.text = arg_33_0.screanNum

	arg_33_0:ChangeScreen()

	arg_33_0.volumeNum = MusicData:GetVolumeValue()
	arg_33_0.m_volumeSlider.value = arg_33_0.volumeNum
	arg_33_0.m_volumeLab.text = arg_33_0.volumeNum

	arg_33_0:ChangeVolume()

	arg_33_0.mixNum = MusicData:GetMixValue()
	arg_33_0.m_mixSlider.value = arg_33_0.mixNum
	arg_33_0.m_mixValueLab.text = arg_33_0.mixNum

	arg_33_0:ChangeMixValue()
	arg_33_0:ChangeTrackPath(arg_33_0.trackPathType, true)
	arg_33_0:ChangeSpectralType(arg_33_0.spectralType)

	arg_33_0.test = arg_33_0.musicSetController.autoClick

	arg_33_0.testController:SetSelectedIndex(arg_33_0.test and 1 or 0)
end

function var_0_0.OnExit(arg_34_0)
	manager.windowBar:HideBar()

	if arg_34_0.raycaster then
		Object.Destroy(arg_34_0.raycaster_)
	end

	arg_34_0.musicSetController:End()
	SetActive(arg_34_0.musicSetGo, false)
	MusicData:SetSpeedValue(arg_34_0.speedNum, arg_34_0.trackPathType)
	MusicData:SetJudgeValue(arg_34_0.judgeNum)
	MusicData:SetScreanValue(arg_34_0.screanNum)
	MusicData:SetVolumeValue(arg_34_0.volumeNum)
	MusicData:SetShoMovie(arg_34_0.showMovie)
	MusicData:SetTrackPathType(arg_34_0.trackPathType)
	MusicData:SetSpectralType(arg_34_0.spectralType)
	SDKTools.SendMessageToSDK("activity_music_setting", {
		activity_id = ActivityConst.VOLUME_MUSIC,
		speed = tostring(arg_34_0.speedNum),
		time = tostring(arg_34_0.judgeNum),
		other_data = MusicData:GetSpectralAndVercialSDKKey()
	})

	if arg_34_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_34_0.backGround_, ASSET_TYPE.SCENE)
	end

	if arg_34_0.sceneSetting_ then
		arg_34_0.sceneSetting_.enabled = true
	end
end

function var_0_0.GetIsVertical(arg_35_0)
	return arg_35_0.trackPathType == MusicConst.MusicTrackType.Vertical
end

function var_0_0.SetMusicCamera(arg_36_0)
	local var_36_0

	var_36_0 = MusicData:GetTrackPathType() == MusicConst.MusicTrackType.Constant_Slope

	if arg_36_0.trackPathType == MusicConst.MusicTrackType.Constant_Slope then
		manager.ui:SetMainCamera("musicSetConstant")
	elseif arg_36_0.trackPathType == MusicConst.MusicTrackType.Vertical then
		manager.ui:SetMainCamera("musicSetVertical")
	else
		manager.ui:SetMainCamera("musicSet")
	end

	if arg_36_0.AdaptiveTimer then
		arg_36_0.AdaptiveTimer:Stop()

		arg_36_0.AdaptiveTimer = nil
	end

	arg_36_0.AdaptiveTimer = FrameTimer.New(function()
		arg_36_0:AdaptiveSetGo()
	end, 1, 1)

	arg_36_0.AdaptiveTimer:Start()
end

function var_0_0.AdaptiveSetGo(arg_38_0)
	return
end

function var_0_0.ChangeSpeed(arg_39_0)
	local var_39_0 = arg_39_0.speedNum
	local var_39_1 = 45.833333333333336 * var_39_0 * var_39_0 - 562.5 * var_39_0 + 2016.6666666666667

	arg_39_0.musicSetController.stayTime = var_39_1

	if arg_39_0.trackPathType == MusicConst.MusicTrackType.Constant_Slope then
		arg_39_0.musicSetController.constantStayTime = arg_39_0.speedNum * 10
	end
end

function var_0_0.ChangeJudge(arg_40_0)
	local var_40_0 = arg_40_0.judgeNum
	local var_40_1 = math.abs(var_40_0) / 50 * 300

	if var_40_0 < 0 then
		var_40_1 = -1 * var_40_1
	end

	MusicGame.MusicSetController.latency = var_40_1 - 42
end

function var_0_0.ChangeScreen(arg_41_0)
	local var_41_0 = arg_41_0.screanNum
	local var_41_1 = math.abs(var_41_0) / 50 * 300

	if var_41_0 < 0 then
		var_41_1 = -1 * var_41_1
	end

	MusicGame.MusicSetController.judgeLatency = var_41_1
end

function var_0_0.ChangeVolume(arg_42_0)
	local var_42_0 = arg_42_0.volumeNum
	local var_42_1 = math.abs(var_42_0) / 100

	manager.audio:SetEffectAisacControl("musicgame_hitsound_volume", var_42_1)
end

function var_0_0.ChangeMixValue(arg_43_0)
	local var_43_0 = arg_43_0.mixNum

	MusicData:SetMixValue(var_43_0)

	MusicGame.MusicSetController.mixRange = var_43_0
end

function var_0_0.ChangeTestBool(arg_44_0, arg_44_1)
	if arg_44_0.test == arg_44_1 then
		return
	end

	arg_44_0.test = arg_44_1

	arg_44_0.testController:SetSelectedIndex(arg_44_0.test and 1 or 0)

	arg_44_0.musicSetController.autoClick = arg_44_1
end

function var_0_0.ChangeSpectralType(arg_45_0, arg_45_1)
	arg_45_0.spectralType = arg_45_1

	local var_45_0

	if arg_45_1 == MusicConst.MusicSpectralType.None then
		var_45_0 = 0
	elseif arg_45_1 == MusicConst.MusicSpectralType.Mirror then
		var_45_0 = 1
	elseif arg_45_1 == MusicConst.MusicSpectralType.Random then
		var_45_0 = 2
	end

	if var_45_0 then
		arg_45_0.spectralController:SetSelectedIndex(var_45_0)
	end
end

function var_0_0.ChangeTrackPath(arg_46_0, arg_46_1, arg_46_2)
	if not arg_46_2 and arg_46_1 == arg_46_0.trackPathType then
		return
	end

	MusicData:SetSpeedValue(arg_46_0.speedNum, arg_46_0.trackPathType)

	arg_46_0.trackPathType = arg_46_1
	arg_46_0.speedNum = MusicData:GetSpeedValue(arg_46_0.trackPathType)
	arg_46_0.m_speedSlider.value = arg_46_0.speedNum
	arg_46_0.m_speedLab.text = arg_46_0.speedNum

	arg_46_0.pathController:SetSelectedIndex(arg_46_0.trackPathType - 1)
	arg_46_0.musicSetController:SetTrackType(arg_46_0.trackPathType)
	arg_46_0:SetMusicCamera()
	arg_46_0:ChangeSpeed()
end

function var_0_0.InitBackScene(arg_47_0)
	local var_47_0 = "UI/Common/BackgroundQuad"

	arg_47_0.backGround_ = manager.resourcePool:Get(var_47_0, ASSET_TYPE.SCENE)
	arg_47_0.backGroundTrs_ = arg_47_0.backGround_.transform

	arg_47_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	arg_47_0.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	arg_47_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	arg_47_0.backGroundTrs_.localScale = Vector3(11, 11, 1)
	arg_47_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = arg_47_0.bgImg_.sprite
end

function var_0_0.OnMusicSetNodeHit(arg_48_0, arg_48_1, arg_48_2)
	SetActive(arg_48_0.m_effect, false)
	SetActive(arg_48_0.m_effect, true)

	if arg_48_1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == arg_48_2 or MusicConst.MusicNodeHitType.Long == arg_48_2) then
		manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_musicgame_hitsound", "")
	end

	if MusicConst.MusicNodeHitRating.PerfectPlus == arg_48_1 then
		arg_48_0.ratingController:SetSelectedIndex(4)
	elseif MusicConst.MusicNodeHitRating.Perfect == arg_48_1 then
		arg_48_0.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == arg_48_1 then
		arg_48_0.ratingController:SetSelectedIndex(2)
	else
		arg_48_0.ratingController:SetSelectedIndex(1)
	end
end

function var_0_0.Dispose(arg_49_0)
	arg_49_0:DisposeSet()
	var_0_0.super.Dispose(arg_49_0)
end

return var_0_0
