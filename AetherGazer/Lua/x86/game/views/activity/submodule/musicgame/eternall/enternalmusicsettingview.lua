local var_0_0 = class("EnternalMusicSettingView", ReduxView)
local var_0_1 = 5
local var_0_2 = 1
local var_0_3 = 50
local var_0_4 = -50
local var_0_5 = 50
local var_0_6 = -50
local var_0_7 = 100
local var_0_8 = 0

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicSetUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	local var_3_0 = Asset.Load("Music/MusicSet")

	arg_3_0.musicSetGo = Object.Instantiate(var_3_0)
	arg_3_0.musicSetController = arg_3_0.musicSetGo:GetComponent("MusicSetController")

	manager.ui:SetMainCamera("musicSet")

	arg_3_0.speedNum = 0
	arg_3_0.judgeNum = 0
	arg_3_0.screanNum = 0
	arg_3_0.showMovie = true
	arg_3_0.test = true
	arg_3_0.ratingController = ControllerUtil.GetController(arg_3_0.transform_, "rating")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.m_speedSlider.minValue = var_0_2
	arg_4_0.m_speedSlider.maxValue = var_0_1
	arg_4_0.m_judgeSlider.minValue = var_0_4
	arg_4_0.m_judgeSlider.maxValue = var_0_3
	arg_4_0.m_screanSlider.minValue = var_0_6
	arg_4_0.m_screanSlider.maxValue = var_0_5
	arg_4_0.m_volumeSlider.minValue = var_0_8
	arg_4_0.m_volumeSlider.maxValue = var_0_7
	arg_4_0.testController = ControllerUtil.GetController(arg_4_0.transform_, "test")
	arg_4_0.vedioController = ControllerUtil.GetController(arg_4_0.transform_, "vedio")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0.m_speedSlider.onValueChanged:AddListener(function()
		local var_6_0 = string.format("%.1f", arg_5_0.m_speedSlider.value)

		arg_5_0.speedNum = tonumber(var_6_0)
		arg_5_0.m_speedLab.text = arg_5_0.speedNum

		arg_5_0:ChangeSpeed()
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.m_speedAddBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.speedNum < var_0_1 then
			arg_5_0.speedNum = arg_5_0.speedNum + 0.1
			arg_5_0.speedNum = math.min(arg_5_0.speedNum, var_0_1)
			arg_5_0.m_speedSlider.value = arg_5_0.speedNum
			arg_5_0.m_speedLab.text = arg_5_0.speedNum

			arg_5_0:ChangeSpeed()

			return true
		end

		return false
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.m_speedDelBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.speedNum > var_0_2 then
			arg_5_0.speedNum = arg_5_0.speedNum - 0.1
			arg_5_0.speedNum = math.max(arg_5_0.speedNum, var_0_2)
			arg_5_0.m_speedSlider.value = arg_5_0.speedNum
			arg_5_0.m_speedLab.text = arg_5_0.speedNum

			arg_5_0:ChangeSpeed()

			return true
		end

		return false
	end)
	arg_5_0.m_judgeSlider.onValueChanged:AddListener(function()
		local var_9_0 = string.format("%.0f", arg_5_0.m_judgeSlider.value)

		arg_5_0.judgeNum = tonumber(var_9_0)
		arg_5_0.m_judgeLab.text = arg_5_0.judgeNum

		arg_5_0:ChangeJudge()
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.m_judgeAddBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.judgeNum < var_0_3 then
			arg_5_0.judgeNum = arg_5_0.judgeNum + 1
			arg_5_0.judgeNum = math.min(arg_5_0.judgeNum, var_0_3)
			arg_5_0.m_judgeSlider.value = arg_5_0.judgeNum
			arg_5_0.m_judgeLab.text = arg_5_0.judgeNum

			arg_5_0:ChangeJudge()

			return true
		end

		return false
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.m_judgeDelBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.judgeNum > var_0_4 then
			arg_5_0.judgeNum = arg_5_0.judgeNum - 1
			arg_5_0.judgeNum = math.max(arg_5_0.judgeNum, var_0_4)
			arg_5_0.m_judgeSlider.value = arg_5_0.judgeNum
			arg_5_0.m_judgeLab.text = arg_5_0.judgeNum

			arg_5_0:ChangeJudge()

			return true
		end

		return false
	end)
	arg_5_0.m_screanSlider.onValueChanged:AddListener(function()
		local var_12_0 = string.format("%.0f", arg_5_0.m_screanSlider.value)

		arg_5_0.screanNum = tonumber(var_12_0)
		arg_5_0.m_screanLab.text = arg_5_0.screanNum

		arg_5_0:ChangeScreen()
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.m_screanAddBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.screanNum < var_0_5 then
			arg_5_0.screanNum = arg_5_0.screanNum + 1
			arg_5_0.screanNum = math.min(arg_5_0.screanNum, var_0_5)
			arg_5_0.m_screanSlider.value = arg_5_0.screanNum
			arg_5_0.m_screanLab.text = arg_5_0.screanNum

			arg_5_0:ChangeScreen()

			return true
		end

		return false
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.m_screanDelBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.screanNum > var_0_6 then
			arg_5_0.screanNum = arg_5_0.screanNum - 1
			arg_5_0.screanNum = math.max(arg_5_0.screanNum, var_0_6)
			arg_5_0.m_screanSlider.value = arg_5_0.screanNum
			arg_5_0.m_screanLab.text = arg_5_0.screanNum

			arg_5_0:ChangeScreen()

			return true
		end

		return false
	end)
	arg_5_0.m_volumeSlider.onValueChanged:AddListener(function()
		local var_15_0 = string.format("%.0f", arg_5_0.m_volumeSlider.value)

		arg_5_0.volumeNum = tonumber(var_15_0)
		arg_5_0.m_volumeLab.text = arg_5_0.volumeNum

		arg_5_0:ChangeVolume()
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.m_volumeAddBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.volumeNum < var_0_7 then
			arg_5_0.volumeNum = arg_5_0.volumeNum + 1
			arg_5_0.volumeNum = math.min(arg_5_0.volumeNum, var_0_7)
			arg_5_0.m_volumeSlider.value = arg_5_0.volumeNum
			arg_5_0.m_volumeLab.text = arg_5_0.volumeNum

			arg_5_0:ChangeVolume()

			return true
		end

		return false
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.m_volumeDelBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.volumeNum > var_0_8 then
			arg_5_0.volumeNum = arg_5_0.volumeNum - 1
			arg_5_0.volumeNum = math.max(arg_5_0.volumeNum, var_0_8)
			arg_5_0.m_volumeSlider.value = arg_5_0.volumeNum
			arg_5_0.m_volumeLab.text = arg_5_0.volumeNum

			arg_5_0:ChangeVolume()

			return true
		end

		return false
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_testOn, nil, function()
		arg_5_0:ChangeTestBool(true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_testOff, nil, function()
		arg_5_0:ChangeTestBool(false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_vedioOn, nil, function()
		arg_5_0:ChangeVedioBool(true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_vedioOff, nil, function()
		arg_5_0:ChangeVedioBool(false)
	end)
end

function var_0_0.OnTop(arg_22_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_23_0)
	manager.ui:SetMainCamera("musicSet")
	arg_23_0.ratingController:SetSelectedIndex(0)
	arg_23_0:InitBackScene()

	arg_23_0.speedNum = MusicData:GetSpeedValue()
	arg_23_0.m_speedSlider.value = arg_23_0.speedNum
	arg_23_0.m_speedLab.text = arg_23_0.speedNum

	arg_23_0:ChangeSpeed()

	arg_23_0.judgeNum = MusicData:GetJudgeValue()
	arg_23_0.m_judgeSlider.value = arg_23_0.judgeNum
	arg_23_0.m_judgeLab.text = arg_23_0.judgeNum

	arg_23_0:ChangeJudge()

	arg_23_0.screanNum = MusicData:GetScreanValue()
	arg_23_0.m_screanSlider.value = arg_23_0.screanNum
	arg_23_0.m_screanLab.text = arg_23_0.screanNum

	arg_23_0:ChangeScreen()

	arg_23_0.volumeNum = MusicData:GetVolumeValue()
	arg_23_0.m_volumeSlider.value = arg_23_0.volumeNum
	arg_23_0.m_volumeLab.text = arg_23_0.volumeNum

	arg_23_0:ChangeVolume()

	arg_23_0.showMovie = MusicData:GetShowMovie()

	arg_23_0.vedioController:SetSelectedIndex(arg_23_0.showMovie and 1 or 0)

	arg_23_0.test = arg_23_0.musicSetController.autoClick

	arg_23_0.testController:SetSelectedIndex(arg_23_0.test and 1 or 0)
	SetActive(arg_23_0.musicSetGo, true)

	arg_23_0.raycaster = manager.ui.mainCamera:AddComponent(typeof(PhysicsRaycaster))

	arg_23_0.musicSetController:Begain()
end

function var_0_0.OnExit(arg_24_0)
	manager.windowBar:HideBar()

	if arg_24_0.raycaster then
		Object.Destroy(arg_24_0.raycaster_)
	end

	arg_24_0.musicSetController:End()
	SetActive(arg_24_0.musicSetGo, false)
	MusicData:SetSpeedValue(arg_24_0.speedNum)
	MusicData:SetJudgeValue(arg_24_0.judgeNum)
	MusicData:SetScreanValue(arg_24_0.screanNum)
	MusicData:SetVolumeValue(arg_24_0.volumeNum)
	MusicData:SetShoMovie(arg_24_0.showMovie)
	SDKTools.SendMessageToSDK("activity_music_setting", {
		activity_id = ActivityConst.VOLUME_MUSIC,
		speed = tostring(arg_24_0.speedNum),
		time = tostring(arg_24_0.judgeNum)
	})

	if arg_24_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_24_0.backGround_, ASSET_TYPE.SCENE)
	end
end

function var_0_0.ChangeSpeed(arg_25_0)
	local var_25_0 = 5 - arg_25_0.speedNum
	local var_25_1 = 1500
	local var_25_2 = 350
	local var_25_3 = var_25_2 + var_25_0 * (var_25_1 - var_25_2) / 4

	arg_25_0.musicSetController.stayTime = var_25_3
end

function var_0_0.ChangeJudge(arg_26_0)
	local var_26_0 = arg_26_0.judgeNum
	local var_26_1 = math.abs(var_26_0) / 50 * 300

	if var_26_0 < 0 then
		var_26_1 = -1 * var_26_1
	end

	MusicGame.MusicSetController.latency = var_26_1
end

function var_0_0.ChangeScreen(arg_27_0)
	local var_27_0 = arg_27_0.screanNum
	local var_27_1 = math.abs(var_27_0) / 50 * 300

	if var_27_0 < 0 then
		var_27_1 = -1 * var_27_1
	end

	MusicGame.MusicSetController.judgeLatency = var_27_1
end

function var_0_0.ChangeVolume(arg_28_0)
	local var_28_0 = arg_28_0.volumeNum
	local var_28_1 = math.abs(var_28_0) / 100

	manager.audio:SetEffectAisacControl("musicgame_hitsound_volume", var_28_1)
end

function var_0_0.ChangeTestBool(arg_29_0, arg_29_1)
	if arg_29_0.test == arg_29_1 then
		return
	end

	arg_29_0.test = arg_29_1

	arg_29_0.testController:SetSelectedIndex(arg_29_0.test and 1 or 0)

	arg_29_0.musicSetController.autoClick = arg_29_1
end

function var_0_0.ChangeVedioBool(arg_30_0, arg_30_1)
	if arg_30_1 == arg_30_0.showMovie then
		return
	end

	arg_30_0.showMovie = arg_30_1

	arg_30_0.vedioController:SetSelectedIndex(arg_30_0.showMovie and 1 or 0)
end

function var_0_0.InitBackScene(arg_31_0)
	local var_31_0 = "UI/Common/BackgroundQuad"

	arg_31_0.backGround_ = manager.resourcePool:Get(var_31_0, ASSET_TYPE.SCENE)
	arg_31_0.backGroundTrs_ = arg_31_0.backGround_.transform

	arg_31_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	arg_31_0.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	arg_31_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	arg_31_0.backGroundTrs_.localScale = Vector3(11, 11, 1)
	arg_31_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng1stUI/XuHeng1st_bg_00122")
end

function var_0_0.OnMusicSetNodeHit(arg_32_0, arg_32_1, arg_32_2)
	SetActive(arg_32_0.m_effect, false)
	SetActive(arg_32_0.m_effect, true)

	if arg_32_1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == arg_32_2 or MusicConst.MusicNodeHitType.Long == arg_32_2) then
		manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_musicgame_hitsound", "")
	end

	if MusicConst.MusicNodeHitRating.PerfectPlus == arg_32_1 then
		arg_32_0.ratingController:SetSelectedIndex(4)
	elseif MusicConst.MusicNodeHitRating.Perfect == arg_32_1 then
		arg_32_0.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == arg_32_1 then
		arg_32_0.ratingController:SetSelectedIndex(2)
	else
		arg_32_0.ratingController:SetSelectedIndex(1)
	end
end

return var_0_0
