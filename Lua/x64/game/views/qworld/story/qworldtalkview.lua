local var_0_0 = class("QWorldTalkView", import("game.extend.ReduxView"))

function var_0_0.GetUIName(arg_1_0)
	return "Widget/System/QWorld/QWorldTalkUI"
end

function var_0_0.Ctor(arg_2_0)
	arg_2_0.gameObject_ = Object.Instantiate(Asset.Load(arg_2_0:GetUIName()), manager.ui.uiStory.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:AdaptScreen()

	arg_2_0.isInHide = false
	arg_2_0.ExcuteContext = {
		isPlayingVoice = false,
		isInExcuting = false
	}

	arg_2_0:Hide()
	arg_2_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_4_0, arg_4_0.gameObject_)
	arg_4_0:AddListener()
end

function var_0_0.AddListener(arg_5_0)
	return
end

function var_0_0.Show(arg_6_0)
	if arg_6_0.isInHide then
		arg_6_0.isInHide = false

		arg_6_0.gameObject_:SetActive(true)
	end
end

function var_0_0.TryShow(arg_7_0)
	if arg_7_0.isInTalk then
		arg_7_0:Show()
	end
end

function var_0_0.Hide(arg_8_0, arg_8_1)
	if not arg_8_0.isInHide then
		if arg_8_1 then
			arg_8_0:StopTimer()
		else
			arg_8_0:StopVoice()
		end

		arg_8_0.gameObject_:SetActive(false)

		arg_8_0.isInHide = true
	end
end

function var_0_0.RenderContent(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	arg_9_0.contentId = arg_9_1

	arg_9_0:StopTimer()

	arg_9_0.callback = arg_9_5
	arg_9_0.speed = arg_9_4

	local var_9_0 = SandplayStoryTalkCfg[tonumber(arg_9_1)]
	local var_9_1 = var_9_0.dialogue_text
	local var_9_2 = "***"

	if arg_9_2 then
		var_9_2 = GetI18NText(arg_9_2)
	end

	local var_9_3 = -1
	local var_9_4 = var_9_0.cue_sheet

	if var_9_4 and var_9_4 ~= "" then
		manager.audio:PlayVoice(var_9_0.cue_sheet, var_9_0.cue_name, true)

		var_9_3 = manager.audio:GetVoiceLength(var_9_0.cue_sheet, var_9_0.cue_name, true) / 1000
	end

	arg_9_0.contentTxt_.text = GetI18NText(var_9_1)
	arg_9_0.nameTxt_.text = var_9_2

	arg_9_0:StartTimer(var_9_1, var_9_3)
end

function var_0_0.StartTimer(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = utf8len(arg_10_1) * (arg_10_0.speed or 1)

	if arg_10_2 and arg_10_2 ~= -1 then
		var_10_0 = arg_10_2
	end

	arg_10_0.timer = Timer.New(function()
		local var_11_0 = arg_10_0.callback

		arg_10_0.callback = nil

		arg_10_0:StopTimer()

		if var_11_0 then
			var_11_0(arg_10_0.contentId)
		end
	end, var_10_0, 1)
	arg_10_0.isInTalk = true

	arg_10_0.timer:Start()
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer then
		arg_12_0.isInTalk = false
		arg_12_0.callback = nil

		arg_12_0.timer:Stop()

		arg_12_0.timer = nil
	end

	arg_12_0:StopVoice()
end

function var_0_0.StopVoice(arg_13_0)
	if arg_13_0.ExcuteContext.isInExcuting then
		manager.audio:StopVoiceImmediate()
	end
end

function var_0_0.PauseVoice(arg_14_0)
	if arg_14_0.ExcuteContext.isInExcuting then
		manager.audio:PauseVoice()
	end
end

function var_0_0.RenderContentList(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0:StopTimer()

	if arg_15_0.ExcuteContext.isInExcuting then
		arg_15_0:StopVoice()

		if arg_15_0.ExcuteContext.callback then
			arg_15_0.ExcuteContext.callback()

			arg_15_0.ExcuteContext.callback = nil
		end

		arg_15_0.ExcuteContext.isInExcuting = false
	end

	arg_15_0.ExcuteContext.isInExcuting = true
	arg_15_0.ExcuteContext.callback = arg_15_3

	arg_15_0:ShowContentList(arg_15_1, 1, arg_15_2, arg_15_3)
end

function var_0_0.ShowContentList(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if arg_16_1[arg_16_2] then
		local var_16_0 = tonumber(arg_16_1[arg_16_2])

		arg_16_0:RenderContent(var_16_0, SandplayStoryTalkCfg[var_16_0].speaker_name, nil, arg_16_3, function()
			arg_16_0:ShowContentList(arg_16_1, arg_16_2 + 1, arg_16_3, arg_16_4)
		end)
	else
		arg_16_0.ExcuteContext.isInExcuting = false

		if arg_16_4 then
			arg_16_4()
		end
	end
end

function var_0_0.TryDispose(arg_18_0)
	if arg_18_0.ExcuteContext.isInExcuting then
		return false
	end

	arg_18_0.ExcuteContext.isInExcuting = false

	arg_18_0:Dispose()

	return true
end

function var_0_0.TryInterrupt(arg_19_0)
	arg_19_0:StopTimer()

	if arg_19_0.ExcuteContext.isInExcuting then
		arg_19_0:StopVoice()

		arg_19_0.ExcuteContext.isInExcuting = false

		if arg_19_0.ExcuteContext.callback then
			arg_19_0.ExcuteContext.callback()

			arg_19_0.ExcuteContext.callback = nil
		end
	end
end

function var_0_0.Dispose(arg_20_0)
	GameObject.Destroy(arg_20_0.gameObject_)
	Asset.Unload(arg_20_0:GetUIName())
	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
