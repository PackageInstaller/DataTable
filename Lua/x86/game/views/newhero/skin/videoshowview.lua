local var_0_0 = class("VideoShowView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero/VideoShowUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.maxVideoX_ = arg_3_0.movie_.transform.sizeDelta.x
	arg_3_0.maxVideoY_ = arg_3_0.movie_.transform.sizeDelta.y
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.criMovie_ = arg_4_0.movie_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.skipBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.start_path = arg_8_0.params_.start_path

	arg_8_0:AdaptVideo()
	arg_8_0:Play()
end

function var_0_0.AdaptVideo(arg_9_0)
	local var_9_0 = arg_9_0.maxVideoX_ / manager.ui.canvasSize_.x
	local var_9_1 = arg_9_0.maxVideoY_ / manager.ui.canvasSize_.y
	local var_9_2 = arg_9_0.maxVideoX_
	local var_9_3 = arg_9_0.maxVideoY_

	if var_9_0 > 1 then
		var_9_2 = manager.ui.canvasSize_.x
		var_9_3 = var_9_3 / var_9_0
	elseif var_9_1 > 1 then
		var_9_2 = var_9_2 / var_9_1
		var_9_3 = manager.ui.canvasSize_.y
	end

	arg_9_0.movie_.transform.sizeDelta = Vector2(var_9_2, var_9_3)
end

function var_0_0.Play(arg_10_0)
	SetFile(arg_10_0.criplayer_, nil, arg_10_0.start_path, CriMana.Player.SetMode.New)

	local var_10_0 = manager.audio:GetMusicVolume()

	arg_10_0.criplayer_:SetVolume(var_10_0)
	arg_10_0:SetVideoTrack(arg_10_0.criplayer_, arg_10_0.start_path)
	arg_10_0.criMovie_:Play()

	arg_10_0.criplayer_.statusChangeCallback = handler(arg_10_0, arg_10_0.CirMovieStatusChange)
end

function var_0_0.CirMovieStatusChange(arg_11_0, arg_11_1)
	local var_11_0 = tostring(arg_11_1)

	if var_11_0 == "PlayEnd" or var_11_0 == "Stop" then
		arg_11_0:Back()
	end
end

function var_0_0.SetVideoTrack(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = manager.video:GetVedioTrackIndex(arg_12_2)

	arg_12_1:SetAudioTrack(var_12_0)
	arg_12_1:SetSubtitleChannel(var_12_0)
end

function var_0_0.OnExit(arg_13_0)
	if arg_13_0.callBack then
		arg_13_0.callBack()

		arg_13_0.callBack = nil
	end

	arg_13_0.criplayer_.statusChangeCallback = nil

	arg_13_0.criMovie_:Stop()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
