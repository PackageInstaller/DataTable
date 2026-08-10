local var_0_0 = class("EnternalMusicMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicMainUI"
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

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, EnternalMusicMainItem)
	arg_4_0.lockController = ControllerUtil.GetController(arg_4_0.transform_, "lock")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("enternalMusicReward")
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_settingBtn, nil, function()
		JumpTools.OpenPageByJump("/enternalMusicSetting")
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_palyBtn, nil, function()
		local var_8_0 = arg_5_0.musics[arg_5_0.pageIndex]
		local var_8_1 = ActivityMusicCfg.get_id_list_by_activity_id[var_8_0]
		local var_8_2 = MusicData:GetDifficultyIndex(var_8_0) + 1

		MusicAction.Play(var_8_1[var_8_2])
	end)
	arg_5_0.list_:SetPageChangeHandler(handler(arg_5_0, arg_5_0.OnPageChange))
end

function var_0_0.OnTop(arg_9_0)
	local var_9_0 = GameSetting.enternal_music_describe and GameSetting.enternal_music_describe.value or {}

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = var_9_0
		}
	})
end

function var_0_0.OnEnter(arg_10_0)
	local var_10_0 = SettingData:GetSoundSettingData()

	if var_10_0 and var_10_0.music then
		manager.audio:SetVolume("music", var_10_0.music / 100)
	end

	arg_10_0.activity_id = arg_10_0.params_.activity_id

	local var_10_1 = ActivityCfg[arg_10_0.activity_id]

	arg_10_0.musics = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_1.sub_activity_list) do
		if ActivityCfg[iter_10_1] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(arg_10_0.musics, iter_10_1)
		end
	end

	arg_10_0.pageIndex = MusicData:GetSelectIndex(arg_10_0.activity_id)

	arg_10_0.list_:StartScroll(#arg_10_0.musics, arg_10_0.pageIndex, true, false)
	arg_10_0.list_:SwitchToPage(arg_10_0.pageIndex)

	arg_10_0.BGMID = 0

	local var_10_2 = arg_10_0.musics[arg_10_0.pageIndex]
	local var_10_3 = MusicData:GetDifficultyIndex(var_10_2)
	local var_10_4 = math.min(var_10_3, 1)

	MusicData:SetDifficultIndex(var_10_2, var_10_4)
	arg_10_0:OnPageChange(arg_10_0.pageIndex)
	arg_10_0:RefrenTime()

	arg_10_0.timer = Timer.New(function()
		arg_10_0:RefrenTime()
		arg_10_0:RefrenBGM()
	end, 1, -1)

	arg_10_0.timer:Start()
	MusicAction.SetMusicRead(arg_10_0.activity_id)
	manager.redPoint:bindUIandKey(arg_10_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, arg_10_0.activity_id))

	if not getData("EnternalMusic", "showHelp") then
		local var_10_5 = GameSetting.enternal_music_describe and GameSetting.enternal_music_describe.value or {}

		JumpTools.OpenPageByJump("gameHelpPro", {
			pages = var_10_5
		})
		saveData("EnternalMusic", "showHelp", 1)
	end
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()

	if arg_12_0.timer then
		arg_12_0.timer:Stop()

		arg_12_0.timer = nil
	end

	manager.redPoint:unbindUIandKey(arg_12_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, arg_12_0.activity_id))
end

function var_0_0.RefrenTime(arg_13_0)
	local var_13_0 = ActivityData:GetActivityData(arg_13_0.activity_id)

	if var_13_0 and var_13_0:IsActivitying() then
		arg_13_0.m_timeLab.text = manager.time:GetLostTimeStr(var_13_0.stopTime)
	else
		arg_13_0.m_timeLab.text = GetTips("TIME_OVER")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.m_timeLab.transform)

	local var_13_1 = arg_13_0.list_:GetItemList()

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		iter_13_1:RefrenTime()
	end

	local var_13_2 = arg_13_0.musics[arg_13_0.pageIndex]

	if ActivityData:GetActivityIsOpen(var_13_2) then
		arg_13_0.lockController:SetSelectedIndex(1)
	else
		arg_13_0.lockController:SetSelectedIndex(0)
	end
end

function var_0_0.IndexItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.musics[arg_14_1]

	arg_14_2:SetData(var_14_0)
end

function var_0_0.OnPageChange(arg_15_0, arg_15_1)
	if arg_15_1 > #arg_15_0.musics then
		arg_15_1 = #arg_15_0.musics
	end

	arg_15_0.pageIndex = arg_15_1

	MusicData:SetSelectIndex(arg_15_0.pageIndex)

	local var_15_0 = arg_15_0.musics[arg_15_1]

	if ActivityData:GetActivityIsOpen(var_15_0) then
		arg_15_0.lockController:SetSelectedIndex(1)
	else
		arg_15_0.lockController:SetSelectedIndex(0)
	end

	arg_15_0:PlayBg()
end

function var_0_0.PlayBg(arg_16_0)
	manager.audio:ClearBGMFlag()

	local var_16_0 = arg_16_0.musics[arg_16_0.pageIndex]

	if not var_16_0 then
		return
	end

	local var_16_1 = ActivityMusicCfg.get_id_list_by_activity_id[var_16_0]
	local var_16_2 = var_16_1[MusicData:GetDifficultyIndex(var_16_0) + 1] or var_16_1[1]
	local var_16_3 = ActivityMusicCfg[var_16_2]

	if var_16_3.aisacKey ~= "" then
		manager.audio:SetBgmAisacControl(var_16_3.aisacKey, var_16_3.aisacValue)
	end

	arg_16_0.BGMID = var_16_2

	manager.audio:PlayBGM(var_16_3.cueSheetName, var_16_3.cueName, var_16_3.awbFile)
end

function var_0_0.RefrenBGM(arg_17_0)
	local var_17_0 = arg_17_0.musics[arg_17_0.pageIndex]

	if not var_17_0 then
		return
	end

	local var_17_1 = ActivityMusicCfg.get_id_list_by_activity_id[var_17_0]
	local var_17_2 = var_17_1[MusicData:GetDifficultyIndex(var_17_0) + 1] or var_17_1[1]

	if arg_17_0.BGMID == var_17_2 then
		return
	end

	arg_17_0:PlayBg()
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.list_:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
