local var_0_0 = class("VolumeMusicSettingView", ReduxView)
local var_0_1 = 5
local var_0_2 = 1
local var_0_3 = 50
local var_0_4 = -50

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicSettingUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.m_speedSlider.minValue = var_0_2
	arg_4_0.m_speedSlider.maxValue = var_0_1
	arg_4_0.m_judgeSlider.minValue = var_0_4
	arg_4_0.m_judgeSlider.maxValue = var_0_3
	arg_4_0.movieController = ControllerUtil.GetController(arg_4_0.m_movieBtn.transform, "select")
	arg_4_0.soundController = ControllerUtil.GetController(arg_4_0.m_soundBtn.transform, "select")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_cancelBtn, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_confirmBtn, nil, function()
		MusicData:SetSpeedValue(arg_5_0.speedNum)
		MusicData:SetJudgeValue(arg_5_0.judgeNum)
		MusicData:SetShoMovie(arg_5_0.showMovie)
		MusicData:SetPlayKeyEffectSound(arg_5_0.playSound)
		SDKTools.SendMessageToSDK("activity_music_setting", {
			activity_id = ActivityConst.VOLUME_MUSIC,
			speed = tostring(arg_5_0.speedNum),
			time = tostring(arg_5_0.judgeNum)
		})
		arg_5_0:Back()
	end)
	arg_5_0.m_speedSlider.onValueChanged:AddListener(function()
		local var_8_0 = string.format("%.1f", arg_5_0.m_speedSlider.value)

		arg_5_0.speedNum = tonumber(var_8_0)
		arg_5_0.m_speedLab.text = arg_5_0.speedNum
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.m_speedAddBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.speedNum < var_0_1 then
			arg_5_0.speedNum = arg_5_0.speedNum + 0.1
			arg_5_0.speedNum = math.min(arg_5_0.speedNum, var_0_1)
			arg_5_0.m_speedSlider.value = arg_5_0.speedNum
			arg_5_0.m_speedLab.text = arg_5_0.speedNum

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

			return true
		end

		return false
	end)
	arg_5_0.m_judgeSlider.onValueChanged:AddListener(function()
		local var_11_0 = string.format("%.0f", arg_5_0.m_judgeSlider.value)

		arg_5_0.judgeNum = tonumber(var_11_0)
		arg_5_0.m_judgeLab.text = arg_5_0.judgeNum
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.m_judgeAddBtn.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.judgeNum < var_0_3 then
			arg_5_0.judgeNum = arg_5_0.judgeNum + 1
			arg_5_0.judgeNum = math.min(arg_5_0.judgeNum, var_0_3)
			arg_5_0.m_judgeSlider.value = arg_5_0.judgeNum
			arg_5_0.m_judgeLab.text = arg_5_0.judgeNum

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

			return true
		end

		return false
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_movieBtn, nil, function()
		arg_5_0.showMovie = not arg_5_0.showMovie

		arg_5_0.movieController:SetSelectedIndex(arg_5_0.showMovie and 1 or 0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_soundBtn, nil, function()
		arg_5_0.playSound = not arg_5_0.playSound

		arg_5_0.soundController:SetSelectedIndex(arg_5_0.playSound and 1 or 0)
	end)
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.speedNum = MusicData:GetSpeedValue()
	arg_17_0.m_speedSlider.value = arg_17_0.speedNum
	arg_17_0.m_speedLab.text = arg_17_0.speedNum
	arg_17_0.judgeNum = MusicData:GetJudgeValue()
	arg_17_0.m_judgeSlider.value = arg_17_0.judgeNum
	arg_17_0.m_judgeLab.text = arg_17_0.judgeNum
	arg_17_0.showMovie = MusicData:GetShowMovie()

	arg_17_0.movieController:SetSelectedIndex(arg_17_0.showMovie and 1 or 0)

	arg_17_0.playSound = MusicData:GetPlayKeyEffectSound()

	arg_17_0.soundController:SetSelectedIndex(arg_17_0.playSound and 1 or 0)
end

function var_0_0.OnExit(arg_18_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_19_0)
	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
