local var_0_0 = class("VolumeMusicMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.pageIndex = 1
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, VolumeMusicMainItem)
	arg_4_0.lockController = ControllerUtil.GetController(arg_4_0.transform_, "lock")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("VolumeMusicReward")
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_settingBtn, nil, function()
		JumpTools.OpenPageByJump("voumeMusicSetting")
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_palyBtn, nil, function()
		local var_8_0 = arg_5_0.musics[arg_5_0.pageIndex]
		local var_8_1 = ActivityMusicCfg.get_id_list_by_activity_id[var_8_0]
		local var_8_2 = MusicData:GetDifficultyIndex(var_8_0) + 1

		MusicAction.Play(var_8_1[var_8_2])
	end)
	arg_5_0.m_scroller.onValueChanged:AddListener(function()
		local var_9_0 = arg_5_0.list_:GetItemList()

		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			iter_9_1:UpdateScale(arg_5_0.m_viewport)
		end
	end)
	arg_5_0.list_:SetPageChangeHandler(handler(arg_5_0, arg_5_0.OnPageChange))
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MUSIC_DESCRIBE")
end

function var_0_0.OnEnter(arg_11_0)
	local var_11_0 = SettingData:GetSoundSettingData()

	if var_11_0 and var_11_0.music then
		manager.audio:SetVolume("music", var_11_0.music / 100)
	end

	arg_11_0.activity_id = arg_11_0.params_.activity_id

	local var_11_1 = ActivityCfg[arg_11_0.activity_id]

	arg_11_0.musics = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_1.sub_activity_list) do
		if ActivityCfg[iter_11_1] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(arg_11_0.musics, iter_11_1)
		end
	end

	arg_11_0.pageIndex = MusicData:GetSelectIndex(arg_11_0.activity_id)

	arg_11_0.list_:StartScroll(#arg_11_0.musics, arg_11_0.pageIndex, true, false)
	arg_11_0.list_:SwitchToPage(arg_11_0.pageIndex)
	arg_11_0:OnPageChange(arg_11_0.pageIndex)
	arg_11_0:RefrenTime()

	arg_11_0.timer = Timer.New(function()
		arg_11_0:RefrenTime()
	end, 1, -1)

	arg_11_0.timer:Start()
	MusicAction.SetMusicRead(arg_11_0.activity_id)
	manager.redPoint:bindUIandKey(arg_11_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, arg_11_0.activity_id))
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()

	if arg_13_0.timer then
		arg_13_0.timer:Stop()

		arg_13_0.timer = nil
	end

	manager.redPoint:unbindUIandKey(arg_13_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, arg_13_0.activity_id))
end

function var_0_0.RefrenTime(arg_14_0)
	local var_14_0 = ActivityData:GetActivityData(arg_14_0.activity_id)

	if var_14_0 and var_14_0:IsActivitying() then
		arg_14_0.m_timeLab.text = manager.time:GetLostTimeStr(var_14_0.stopTime)
	else
		arg_14_0.m_timeLab.text = GetTips("TIME_OVER")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.m_timeLab.transform)

	local var_14_1 = arg_14_0.list_:GetItemList()

	for iter_14_0, iter_14_1 in pairs(var_14_1) do
		iter_14_1:RefrenTime()
	end

	local var_14_2 = arg_14_0.musics[arg_14_0.pageIndex]

	if ActivityData:GetActivityIsOpen(var_14_2) then
		arg_14_0.lockController:SetSelectedIndex(1)
	else
		arg_14_0.lockController:SetSelectedIndex(0)
	end
end

function var_0_0.IndexItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.musics[arg_15_1]

	arg_15_2:SetData(var_15_0)
end

function var_0_0.OnPageChange(arg_16_0, arg_16_1)
	if arg_16_1 > #arg_16_0.musics then
		arg_16_1 = #arg_16_0.musics
	end

	arg_16_0.pageIndex = arg_16_1

	MusicData:SetSelectIndex(arg_16_0.pageIndex)

	local var_16_0 = arg_16_0.musics[arg_16_1]

	if ActivityData:GetActivityIsOpen(var_16_0) then
		arg_16_0.lockController:SetSelectedIndex(1)
	else
		arg_16_0.lockController:SetSelectedIndex(0)
	end

	arg_16_0:PlayBg()
end

function var_0_0.PlayBg(arg_17_0)
	local var_17_0 = arg_17_0.musics[arg_17_0.pageIndex]
	local var_17_1 = ActivityMusicCfg.get_id_list_by_activity_id[var_17_0]
	local var_17_2 = var_17_1[MusicData:GetDifficultyIndex(var_17_0) + 1] or var_17_1[1]
	local var_17_3 = ActivityMusicCfg[var_17_2]

	manager.audio:PlayBGM(var_17_3.cueSheetName, var_17_3.cueName, var_17_3.awbFile)
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.list_:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
