local var_0_0 = class("SkinDlcShowView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero/SkinDlcShowUI"
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

	arg_4_0.criMovie_ = arg_4_0.movie_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player

	arg_4_0.criplayer_:SetMaxPictureDataSize(300000)
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
	local var_8_0 = arg_8_0.params_.goodId
	local var_8_1 = arg_8_0.params_.dlcItemID

	arg_8_0.callBack = arg_8_0.params_.callBack
	arg_8_0.params_.callBack = nil

	local var_8_2 = arg_8_0.params_.start_path

	if not var_8_2 then
		if arg_8_0.params_.dlcId then
			var_8_0 = arg_8_0.params_.dlcId
			arg_8_0.params_.dlcId = nil
		end

		local var_8_3 = getShopCfg(var_8_0)
		local var_8_4
		local var_8_5

		if var_8_3 then
			local var_8_6

			var_8_4, var_8_6 = var_8_3.give_id or var_8_3.description, var_8_3.give or 1
		end

		local var_8_7
		local var_8_8

		if var_8_3 and var_8_3.description then
			local var_8_9 = var_8_3.description

			var_8_8 = RechargeShopDescriptionCfg[var_8_9]
		elseif var_8_3 then
			var_8_8 = ItemCfg[var_8_4]
		else
			var_8_8 = ItemCfg[var_8_1]
		end

		local var_8_10 = true

		for iter_8_0, iter_8_1 in ipairs(SkinSceneActionCfg.all) do
			local var_8_11 = SkinSceneActionCfg[iter_8_1]

			if var_8_11.special_scene_id == var_8_8.param[1] then
				DownloadSingleAssetQuanquan(var_8_11.start_path, function()
					arg_8_0.start_path = var_8_11.start_path

					arg_8_0:Play()
				end)

				break
			end
		end
	else
		DownloadSingleAssetQuanquan(var_8_2, function()
			arg_8_0.start_path = var_8_2

			arg_8_0:Play()
		end)
	end
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.callBack then
		arg_11_0.callBack()

		arg_11_0.callBack = nil
	end

	arg_11_0.criplayer_.statusChangeCallback = nil

	arg_11_0.criMovie_:Stop()
	manager.windowBar:HideBar()
end

function var_0_0.CirMovieStatusChange(arg_12_0, arg_12_1)
	local var_12_0 = tostring(arg_12_1)

	if var_12_0 == "PlayEnd" or var_12_0 == "Stop" then
		arg_12_0:Back()
	end
end

function var_0_0.Play(arg_13_0)
	SetFile(arg_13_0.criplayer_, nil, arg_13_0.start_path, CriMana.Player.SetMode.New)

	local var_13_0 = manager.audio:GetMusicVolume()

	arg_13_0.criplayer_:SetVolume(var_13_0)
	arg_13_0:SetVideoTrack(arg_13_0.criplayer_, arg_13_0.start_path)
	arg_13_0.criMovie_:Play()

	arg_13_0.criplayer_.statusChangeCallback = handler(arg_13_0, arg_13_0.CirMovieStatusChange)
end

function var_0_0.SetVideoTrack(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = manager.video:GetVedioTrackIndex(arg_14_2)

	arg_14_1:SetAudioTrack(var_14_0)
	arg_14_1:SetSubtitleChannel(var_14_0)
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
