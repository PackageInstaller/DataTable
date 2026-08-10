local var_0_0 = class("ObtainDLCView", require("game.views.obtain.ObtainBaseView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	var_0_0.super.Init(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.criMovie_ = arg_3_0.movie_:GetComponent("CriManaMovieControllerForUI")
	arg_3_0.criplayer_ = arg_3_0.criMovie_.player

	arg_3_0.criplayer_:SetMaxPictureDataSize(300000)
end

function var_0_0.OnClick(arg_4_0)
	return true
end

function var_0_0.Show(arg_5_0, arg_5_1)
	arg_5_0.item = arg_5_1

	if arg_5_0.gameObject_ then
		SetActive(arg_5_0.gameObject_, true)
	end

	local var_5_0 = arg_5_1.id
	local var_5_1 = ItemCfg[var_5_0]

	for iter_5_0, iter_5_1 in ipairs(SkinSceneActionCfg.all) do
		local var_5_2 = SkinSceneActionCfg[iter_5_1]

		if var_5_2.special_scene_id == var_5_1.param[1] then
			arg_5_0.start_path = var_5_2.start_path

			arg_5_0.criMovie_:Stop()
			DownloadSingleAssetQuanquan(arg_5_0.start_path, function()
				if tostring(arg_5_0.criplayer_.status) ~= "Stop" then
					arg_5_0.stopTimer_ = Timer.New(function()
						if tostring(arg_5_0.criplayer_.status) == "Stop" then
							arg_5_0:Play()
							arg_5_0:StopMovieStopTimer()

							return
						end
					end, 0.033, -1)

					arg_5_0.stopTimer_:Start()
				else
					arg_5_0:Play()
				end
			end, function()
				print("ObtainDLCView Download Fail")
			end)

			break
		end
	end
end

function var_0_0.SetVideoTrack(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = manager.video:GetVedioTrackIndex(arg_9_2)

	arg_9_1:SetAudioTrack(var_9_0)
	arg_9_1:SetSubtitleChannel(var_9_0)
end

function var_0_0.Play(arg_10_0)
	SetFile(arg_10_0.criplayer_, nil, arg_10_0.start_path, CriMana.Player.SetMode.New)
	SetFile(arg_10_0.criplayer_, nil, arg_10_0.start_path, CriMana.Player.SetMode.AppendRepeatedly)

	local var_10_0 = manager.audio:GetMusicVolume()

	arg_10_0.criplayer_:SetVolume(var_10_0)
	arg_10_0:SetVideoTrack(arg_10_0.criplayer_, arg_10_0.start_path)
	arg_10_0.criMovie_:Play()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:StopMovieStopTimer()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.Hide(arg_12_0)
	manager.audio:StopVoice()
	arg_12_0.criMovie_:Stop()
	arg_12_0:StopMovieStopTimer()
	ObtainBaseView.Hide(arg_12_0)
end

function var_0_0.StopMovieStopTimer(arg_13_0)
	if arg_13_0.stopTimer_ then
		arg_13_0.stopTimer_:Stop()

		arg_13_0.stopTimer_ = nil
	end
end

function var_0_0.NeedHideShare(arg_14_0)
	return true
end

return var_0_0
