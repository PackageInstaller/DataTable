local var_0_0 = class("V210MusicMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = MusicData:GetNowMusicUINameList()

	if var_1_0 and var_1_0.mainView then
		return var_1_0.mainView
	else
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicMainUI"
	end
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

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, V210MusicMainItem)
	arg_4_0.lockController = ControllerUtil.GetController(arg_4_0.transform_, "lock")
	arg_4_0.openToggleController = ControllerUtil.GetController(arg_4_0.toggleTrs_, "open")
	arg_4_0.useShowToggleController = ControllerUtil.GetController(arg_4_0.toggleTrs_, "useShow")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("V210MusicReward")
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_settingBtn, nil, function()
		JumpTools.OpenPageByJump("/V210MusicSetting")
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_palyBtn, nil, function()
		local var_8_0 = arg_5_0.musics[arg_5_0.pageIndex]
		local var_8_1 = ActivityMusicCfg.get_id_list_by_activity_id[var_8_0]
		local var_8_2 = MusicData:GetDifficultyIndex(var_8_0) + 1

		MusicAction.Play(var_8_1[var_8_2])
	end)
	arg_5_0:AddBtnListener(arg_5_0.nowmusicBtn_, nil, function()
		arg_5_0:UpdateMusicListShow(0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.backmusic1Btn_, nil, function()
		arg_5_0:UpdateMusicListShow(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.backmusic2Btn_, nil, function()
		arg_5_0:UpdateMusicListShow(2)
	end)
	arg_5_0:AddBtnListener(arg_5_0.backmusic3Btn_, nil, function()
		arg_5_0:UpdateMusicListShow(3)
	end)
	arg_5_0:AddBtnListener(arg_5_0.togglebtnBtn_, nil, function()
		local var_13_0 = arg_5_0.openToggleController:GetSelectedState() == "true" and 0 or 1

		arg_5_0.openToggleController:SetSelectedIndex(var_13_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.togglerootclosebtnBtn_, nil, function()
		arg_5_0.openToggleController:SetSelectedIndex(0)
	end)
	arg_5_0.list_:SetPageChangeHandler(handler(arg_5_0, arg_5_0.OnPageChange))
	arg_5_0.m_scroller.onValueChanged:AddListener(function()
		arg_5_0:OnScrollerMove()
	end)
end

function var_0_0.GetScrollContentValue(arg_16_0)
	return -arg_16_0.contentTrs_.anchoredPosition.x / 1182 + 1
end

function var_0_0.OnScrollerMove(arg_17_0)
	local var_17_0 = arg_17_0:GetScrollContentValue()
	local var_17_1 = arg_17_0.list_:GetItemList()

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		iter_17_1:MoveAniEffect(var_17_0)
	end
end

function var_0_0.OnTop(arg_18_0)
	local var_18_0 = GameSetting.v210_music_describe and GameSetting.v210_music_describe.value or {}

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_18_0
		})
	end)
	manager.windowBar:RegistBackCallBack(function()
		arg_18_0:Back()

		if manager.windowBar:GetWhereTag() == "qworld" then
			PlayQWorldBgm()
		end
	end)
end

function var_0_0.UpdateMusicListShow(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.useShowToggleController:GetSelectedState()

	if arg_21_0.useShowToggleController:GetStateIndex(var_21_0) == arg_21_1 then
		return
	end

	arg_21_0.openToggleController:SetSelectedIndex(0)

	local var_21_1 = MusicConst.MusicLookBackID[arg_21_1] or nil

	arg_21_0:UpdateMusicDataByActId(var_21_1)
end

function var_0_0.UpdateMusicDataByActId(arg_22_0, arg_22_1)
	if arg_22_1 then
		arg_22_0.useShowToggleController:SetSelectedIndex(table.indexof(MusicConst.MusicLookBackID, arg_22_1))
	else
		arg_22_0.useShowToggleController:SetSelectedIndex(0)
	end

	local var_22_0 = ActivityCfg[arg_22_0.activity_id]

	arg_22_0.musics = {}

	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(var_22_0.sub_activity_list) do
		if ActivityCfg[iter_22_1] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(var_22_1, iter_22_1)
		end
	end

	if arg_22_1 then
		local var_22_2 = {}

		for iter_22_2, iter_22_3 in pairs(var_22_1) do
			var_22_2[iter_22_3] = true
		end

		for iter_22_4, iter_22_5 in pairs(ActivityMusicCfg.get_id_list_by_activity_id) do
			if MusicData:GetMusicViewPathList(iter_22_4, true).activityID == arg_22_1 then
				table.insert(arg_22_0.musics, iter_22_4)
			end
		end

		table.sort(arg_22_0.musics, function(arg_23_0, arg_23_1)
			return arg_23_0 < arg_23_1
		end)
	else
		arg_22_0.musics = var_22_1
	end

	arg_22_0.lookBackActID = arg_22_1

	arg_22_0.list_:StartScroll(#arg_22_0.musics, arg_22_0.pageIndex, true, false)
	arg_22_0.list_:SwitchToPage(arg_22_0.pageIndex)
	arg_22_0.musicmainuiAni_:Play("MusicGameUI 1", 0, 0)
end

function var_0_0.OnEnter(arg_24_0)
	local var_24_0 = SettingData:GetSoundSettingData()

	if var_24_0 and var_24_0.music then
		manager.audio:SetVolume("music", var_24_0.music / 100)
	end

	arg_24_0.activity_id = arg_24_0.params_.activity_id

	local var_24_1 = ActivityCfg[arg_24_0.activity_id]

	arg_24_0.titleTxt_.text = GetI18NText(var_24_1.remark)
	arg_24_0.lookBackActID = arg_24_0.lookBackActID or MusicData:GetLookBackState()
	arg_24_0.pageIndex = MusicData:GetSelectIndex(arg_24_0.activity_id)

	arg_24_0:UpdateMusicDataByActId(arg_24_0.lookBackActID)

	arg_24_0.BGMID = 0

	local var_24_2 = arg_24_0.musics[arg_24_0.pageIndex]
	local var_24_3 = MusicData:GetDifficultyIndex(var_24_2)

	MusicData:SetDifficultIndex(var_24_2, var_24_3)
	arg_24_0:OnPageChange(arg_24_0.pageIndex)
	arg_24_0:RefrenTime()

	arg_24_0.timer = Timer.New(function()
		arg_24_0:RefrenTime()
		arg_24_0:RefrenBGM()
	end, 1, -1)

	arg_24_0.timer:Start()
	MusicAction.SetMusicRead(arg_24_0.activity_id)
	manager.redPoint:bindUIandKey(arg_24_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, arg_24_0.activity_id))

	if not getData("EnternalMusic", "showHelp") then
		local var_24_4 = GameSetting.v210_music_describe and GameSetting.v210_music_describe.value or {}

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_24_4
		})
		saveData("EnternalMusic", "showHelp", 1)
	end
end

function var_0_0.OnExit(arg_26_0)
	MusicData:SetLookBackState(arg_26_0.lookBackActID)
	manager.windowBar:HideBar()

	if arg_26_0.timer then
		arg_26_0.timer:Stop()

		arg_26_0.timer = nil
	end

	manager.redPoint:unbindUIandKey(arg_26_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, arg_26_0.activity_id))
end

function var_0_0.RefrenTime(arg_27_0)
	local var_27_0 = ActivityData:GetActivityData(arg_27_0.activity_id)

	if var_27_0 and var_27_0:IsActivitying() then
		arg_27_0.m_timeLab.text = manager.time:GetLostTimeStrWith2Unit(var_27_0.stopTime)
	else
		arg_27_0.m_timeLab.text = GetTips("TIME_OVER")

		JumpTools.Back()

		return
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_0.m_timeLab.transform)

	local var_27_1 = arg_27_0.list_:GetItemList()

	for iter_27_0, iter_27_1 in pairs(var_27_1) do
		iter_27_1:RefrenTime()
	end

	local var_27_2 = arg_27_0.musics[arg_27_0.pageIndex]

	if ActivityData:GetActivityIsOpen(var_27_2) or arg_27_0.lookBackActID then
		arg_27_0.lockController:SetSelectedIndex(1)
	else
		arg_27_0.lockController:SetSelectedIndex(0)
	end
end

function var_0_0.IndexItem(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.musics[arg_28_1]

	arg_28_2:SetData(arg_28_1, var_28_0, arg_28_0.lookBackActID)
	arg_28_2:MoveAniEffect(arg_28_0:GetScrollContentValue())
end

function var_0_0.OnPageChange(arg_29_0, arg_29_1)
	if arg_29_1 > #arg_29_0.musics then
		arg_29_1 = #arg_29_0.musics
	end

	arg_29_0.pageIndex = arg_29_1

	MusicData:SetSelectIndex(arg_29_0.pageIndex)

	local var_29_0 = arg_29_0.musics[arg_29_1]

	if ActivityData:GetActivityIsOpen(var_29_0) or arg_29_0.lookBackActID then
		arg_29_0.lockController:SetSelectedIndex(1)
	else
		arg_29_0.lockController:SetSelectedIndex(0)
	end

	arg_29_0:PlayBg()
end

function var_0_0.PlayBg(arg_30_0)
	manager.audio:ClearBGMFlag()

	local var_30_0 = arg_30_0.musics[arg_30_0.pageIndex]

	if not var_30_0 then
		return
	end

	local var_30_1 = ActivityData:GetActivityData(var_30_0)

	if (not var_30_1 or not var_30_1:IsActivitying()) and not arg_30_0.lookBackActID then
		manager.audio:StopBgmImmediate()

		return
	end

	local var_30_2 = ActivityMusicCfg.get_id_list_by_activity_id[var_30_0]
	local var_30_3 = var_30_2[MusicData:GetDifficultyIndex(var_30_0) + 1] or var_30_2[1]
	local var_30_4 = ActivityMusicCfg[var_30_3]

	if var_30_4.aisacKey ~= "" then
		AudioManager.Instance:SetAisacControlOfCategory("music", var_30_4.aisacKey, var_30_4.aisacValue)
	end

	arg_30_0.BGMID = var_30_3

	manager.audio:PlayBGM(var_30_4.cueSheetName, var_30_4.cueName, var_30_4.awbFile)
end

function var_0_0.RefrenBGM(arg_31_0)
	local var_31_0 = arg_31_0.musics[arg_31_0.pageIndex]

	if not var_31_0 then
		return
	end

	local var_31_1 = ActivityMusicCfg.get_id_list_by_activity_id[var_31_0]
	local var_31_2 = var_31_1[MusicData:GetDifficultyIndex(var_31_0) + 1] or var_31_1[1]

	if arg_31_0.BGMID == var_31_2 then
		return
	end

	arg_31_0:PlayBg()
end

function var_0_0.Dispose(arg_32_0)
	arg_32_0.list_:Dispose()
	var_0_0.super.Dispose(arg_32_0)
end

return var_0_0
