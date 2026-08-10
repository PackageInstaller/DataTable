local var_0_0 = class("SelectMusicPopup", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolDance/IdolDancePlayerPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.musicUIList = LuaList.New(handler(arg_3_0, arg_3_0.RenderMusicItem), arg_3_0.uiList_, IdolDanceMusicItem)
	arg_3_0.playStateController = arg_3_0.controllers_:GetController("state")

	function arg_3_0.musicItemSelectFunc(arg_4_0)
		arg_3_0.select = arg_4_0

		arg_3_0.musicUIList:Refresh()
		arg_3_0:RefreshView()
		DIYBridge:RestartBGM(arg_4_0)
	end

	arg_3_0:AddBtnListener(arg_3_0.emptyAreaBtn_, nil, function()
		if arg_3_0.backIfClickBG then
			arg_3_0:OnClosePopup()
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.select = DIYBridge.music
	arg_6_0.onSelectMusic = arg_6_0.params_.onSelectMusic
	arg_6_0.backIfClickBG = true

	DIYBridge:RestartBGM(arg_6_0.select)
	arg_6_0.musicUIList:StartScroll(#IdolStageMusicCfg.all)
	arg_6_0:RefreshView()
end

function var_0_0.OnExit(arg_7_0)
	manager.audio:StopBGM()
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_8_0:OnClosePopup()
	end)
end

function var_0_0.OnBehind(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.musicUIList:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.OnClosePopup(arg_12_0)
	if arg_12_0.select and arg_12_0.onSelectMusic and not arg_12_0:onSelectMusic(arg_12_0.select) then
		JumpTools.Back()
	end
end

function var_0_0.RefreshView(arg_13_0, arg_13_1)
	arg_13_1 = arg_13_1 or arg_13_0.select
	arg_13_0.name_.text = nullable(IdolStageMusicCfg, arg_13_1, "music_name")

	arg_13_0:UpdateMusicThumbnail(arg_13_1)

	arg_13_0.duration_.text = manager.time:DescCdTime2(IdolTraineeTools.GetMusicDuration(arg_13_1) or 0)
end

function var_0_0.UpdateMusicThumbnail(arg_14_0, arg_14_1)
	local var_14_0
	local var_14_1 = nullable(IdolStageMusicCfg, arg_14_1, "music_record")

	if var_14_1 then
		local var_14_2 = MusicRecordCfg[var_14_1]
		local var_14_3 = MusicAlbumRecordCfg[var_14_2.album]

		if var_14_3.cover then
			var_14_0 = "TextureConfig/IllustratedHandbook/musicCD/" .. var_14_3.cover
		end
	end

	if var_14_0 == nil then
		local var_14_4 = nullable(IdolStageMusicCfg, arg_14_1, "cover")

		if var_14_4 and var_14_4 ~= "" then
			var_14_0 = "TextureConfig/Music/Music_icon/" .. var_14_4
		end
	end

	arg_14_0.thumbnail_.spriteSync = var_14_0
end

function var_0_0.RenderMusicItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:SetData(IdolStageMusicCfg.all[arg_15_1])
	arg_15_2:SetSelected(arg_15_0.select == arg_15_2.music)
	arg_15_2:SetOnClick(arg_15_0.musicItemSelectFunc)
end

function var_0_0.PlayBGM(arg_16_0, arg_16_1)
	local var_16_0 = IdolStageMusicCfg[arg_16_1]

	if var_16_0 then
		manager.audio:PlayBGM(var_16_0.cue_sheet, var_16_0.cue_name, var_16_0.awb_name)
		arg_16_0.playStateController:SetSelectedState("play")
	end
end

function var_0_0.StopBGM(arg_17_0)
	manager.audio:StopBGM()
	arg_17_0.playStateController:SetSelectedState("stop")
end

function var_0_0.SetSelectMusic(arg_18_0, arg_18_1)
	arg_18_0.select = arg_18_1

	arg_18_0.musicUIList:Refresh()
	arg_18_0:RefreshView()
	DIYBridge:RestartBGM(arg_18_0.select)
end

return var_0_0
