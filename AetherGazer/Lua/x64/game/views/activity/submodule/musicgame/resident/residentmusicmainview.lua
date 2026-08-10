local var_0_0 = class("ResidentMusicMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
	arg_3_0:AddEventListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.musicFilter = ResidentMusicFilter.New(arg_4_0.filterViewGo_)
	arg_4_0.musicContent = ResidentMusicContent.New(arg_4_0.musicContentGo_)
	arg_4_0.musicTree = ResidentMusicTree.New(arg_4_0.musicTreeGo_)
	arg_4_0.emptyController_ = arg_4_0.controller_:GetController("empty")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.settingBtn_, nil, function()
		JumpTools.OpenPageByJump("/residentMusicSettingView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.playBtn_, nil, function()
		arg_5_0:OnPlayBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.filterBtn_, nil, function()
		arg_5_0:UpdateFilterShow(true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.limitRewardBtn_, nil, function()
		local var_9_0 = MusicData:GetActivityTaskID(MusicData:GetPageActivityID())

		JumpTools.OpenPageByJump("residentMusicRewardView", {
			activity_id = var_9_0
		})
	end)
end

function var_0_0.OnPlayBtn(arg_10_0)
	local var_10_0 = arg_10_0.musicContent:GetMusicID()
	local var_10_1 = ActivityMusicCfg.get_id_list_by_activity_id[var_10_0]
	local var_10_2 = MusicData:GetDifficultyIndex(var_10_0)

	MusicAction.Play(var_10_1[var_10_2])
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_12_0)
	local var_12_0 = GameSetting.v210_music_describe and GameSetting.v210_music_describe.value or {}

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_12_0
		})
	end)
end

function var_0_0.OnEnter(arg_14_0)
	local var_14_0 = SettingData:GetSoundSettingData()

	if var_14_0 and var_14_0.music then
		manager.audio:SetVolume("music", var_14_0.music / 100)
	end

	arg_14_0.selectMainActivityID, arg_14_0.selectMusicActivityID = MusicData:GetSelectData()
	arg_14_0.timer = Timer.New(function()
		arg_14_0:RefrenBGM()
	end, 1, -1)

	arg_14_0.timer:Start()
	arg_14_0.musicFilter:OnEnter()

	arg_14_0.BGMID = 0

	if MusicData:GetCacheMusicTreePos() then
		arg_14_0.musicTree:SetPos(MusicData:GetCacheMusicTreePos())
	end

	arg_14_0:UpdateTreeData()
	arg_14_0:AddLimitRewardTimer()

	if not getData("EnternalMusic", "showHelp") then
		local var_14_1 = GameSetting.v210_music_describe and GameSetting.v210_music_describe.value or {}

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_14_1
		})
		saveData("EnternalMusic", "showHelp", 1)
	end

	manager.redPoint:bindUIandKey(arg_14_0.limitRewardBtn_.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, MusicData:GetPageActivityID()))
end

function var_0_0.AddLimitRewardTimer(arg_16_0)
	if arg_16_0.limitRewardTimer then
		arg_16_0.limitRewardTimer:Stop()

		arg_16_0.limitRewardTimer = nil
	end

	local var_16_0 = ActivityData:GetActivityData(MusicData:GetPageActivityID()).stopTime

	arg_16_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_16_0, true)

	if var_16_0 < manager.time:GetServerTime() then
		SetActive(arg_16_0.limitRewardBtn_.gameObject, false)

		return
	end

	SetActive(arg_16_0.limitRewardBtn_.gameObject, true)

	arg_16_0.limitRewardTimer = Timer.New(function()
		if manager.time:GetServerTime() > var_16_0 then
			if arg_16_0.limitRewardTimer then
				arg_16_0.limitRewardTimer:Stop()

				arg_16_0.limitRewardTimer = nil
			end

			SetActive(arg_16_0.limitRewardBtn_.gameObject, false)

			return
		end

		arg_16_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_16_0, true)
	end, 1, -1)

	arg_16_0.limitRewardTimer:Start()
end

function var_0_0.RefrenBGM(arg_18_0)
	local var_18_0 = arg_18_0.musicContent:GetMusicID()

	if not var_18_0 then
		return
	end

	local var_18_1 = ActivityMusicCfg.get_id_list_by_activity_id[var_18_0]
	local var_18_2 = var_18_1[MusicData:GetDifficultyIndex(var_18_0)] or var_18_1[1]

	if arg_18_0.BGMID == var_18_2 then
		return
	end

	arg_18_0:PlayBg()
end

function var_0_0.PlayBg(arg_19_0)
	manager.audio:ClearBGMFlag()

	local var_19_0 = arg_19_0.musicContent:GetMusicID()

	if not var_19_0 then
		return
	end

	local var_19_1 = ActivityMusicCfg.get_id_list_by_activity_id[var_19_0]
	local var_19_2 = var_19_1[MusicData:GetDifficultyIndex(var_19_0)] or var_19_1[1]
	local var_19_3 = ActivityMusicCfg[var_19_2]

	if var_19_3.aisacKey ~= "" then
		AudioManager.Instance:SetAisacControlOfCategory("music", var_19_3.aisacKey, var_19_3.aisacValue)
	end

	arg_19_0.BGMID = var_19_2

	manager.audio:PlayBGM(var_19_3.cueSheetName, "musicgame_preview", var_19_3.awbFile)
end

function var_0_0.UpdateFilterShow(arg_20_0, arg_20_1)
	arg_20_0.musicFilter:ShowView(arg_20_1)

	if arg_20_1 then
		manager.windowBar:HideBar()
	else
		arg_20_0:UpdateBar()
	end
end

function var_0_0.ClearSelectMusic(arg_21_0)
	if arg_21_0.selectMainActivityID and arg_21_0.selectMusicActivityID then
		arg_21_0:ChangeTargetSelectInfo(arg_21_0.selectMainActivityID, arg_21_0.selectMusicActivityID, false)
	end

	arg_21_0.selectMainActivityID = nil
	arg_21_0.selectMusicActivityID = nil
end

function var_0_0.ChangeSelectMusicInfo(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.emptyController_:SetSelectedState("normal")
	arg_22_0:ClearSelectMusic()
	MusicAction.SetMusicRead(arg_22_2)

	arg_22_0.selectMainActivityID = arg_22_1
	arg_22_0.selectMusicActivityID = arg_22_2

	arg_22_0:ChangeTargetSelectInfo(arg_22_0.selectMainActivityID, arg_22_0.selectMusicActivityID, true)
	arg_22_0.musicContent:SetData(arg_22_2)
	MusicData:SetSelectedData(arg_22_0.selectMainActivityID, arg_22_0.selectMusicActivityID)
	arg_22_0:RefrenBGM()
end

function var_0_0.ChangeTargetSelectInfo(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0.musicTree:GetTargetGroupItem(arg_23_1)

	if var_23_0 then
		local var_23_1 = var_23_0:GetTargetMusicSelectItem(arg_23_2)

		if var_23_1 then
			var_23_1:ChangeSelectState(arg_23_3)
		end
	end
end

function var_0_0.UpdateTreeData(arg_24_0)
	local var_24_0 = arg_24_0.musicFilter:GetSelectMusicList()

	arg_24_0.musicTree:SetData(var_24_0)

	if not arg_24_0:CheckTargetIDIsInFilterList(var_24_0, arg_24_0.selectMainActivityID, arg_24_0.selectMusicActivityID) then
		local var_24_1, var_24_2 = arg_24_0:GetDefaultFilterSelect(var_24_0)

		if var_24_1 and var_24_2 then
			arg_24_0:ChangeSelectMusicInfo(var_24_1, var_24_2)
		else
			arg_24_0.emptyController_:SetSelectedState("empty")
		end
	else
		arg_24_0:ChangeSelectMusicInfo(arg_24_0.selectMainActivityID, arg_24_0.selectMusicActivityID)
	end
end

function var_0_0.CheckTargetIDIsInFilterList(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	for iter_25_0, iter_25_1 in pairs(arg_25_1) do
		for iter_25_2, iter_25_3 in pairs(iter_25_1.musicActList) do
			if iter_25_3 == arg_25_3 then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetDefaultFilterSelect(arg_26_0, arg_26_1)
	if #arg_26_1 == 0 then
		return nil, nil
	end

	local var_26_0 = MusicData:GetMusicTypeByTheme(arg_26_1[1].theme)
	local var_26_1 = arg_26_1[1].musicActList[1]

	return MusicConst.MusicViewRoutesName[var_26_0].activityID, var_26_1
end

function var_0_0.MoveToTargetMusicID(arg_27_0, arg_27_1)
	local var_27_0, var_27_1 = arg_27_0.musicTree:FindScrollIndexMovePos(arg_27_1)

	if not var_27_0 then
		arg_27_0.musicFilter:ClearFilter()
		arg_27_0.musicFilter:OnOkBtn()
	end

	arg_27_0.musicTree:ScrollToPos(-var_27_1 - 132)
	arg_27_0.musicTree:SelectTargetItem(arg_27_1)
end

function var_0_0.AddEventListener(arg_28_0)
	arg_28_0:RegistEventListener(MUSIC_FILTER_COLSE, handler(arg_28_0, arg_28_0.OnFilterClose))
	arg_28_0:RegistEventListener(MUSIC_FILTER_UPDATE, handler(arg_28_0, arg_28_0.OnFilterUpdate))
	arg_28_0:RegistEventListener(MUSIC_TREE_CLICK_ITEM, handler(arg_28_0, arg_28_0.OnTreeClickItem))
	arg_28_0:RegistEventListener(MUSIC_JUMP_SELECT, handler(arg_28_0, arg_28_0.OnJumpToTargetSelect))
end

function var_0_0.OnFilterClose(arg_29_0)
	arg_29_0:UpdateFilterShow(false)
end

function var_0_0.OnFilterUpdate(arg_30_0)
	arg_30_0:UpdateFilterShow(false)
	arg_30_0:ClearSelectMusic()
	arg_30_0:UpdateTreeData()
end

function var_0_0.OnTreeClickItem(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0:ChangeSelectMusicInfo(arg_31_1, arg_31_2)
end

function var_0_0.OnJumpToTargetSelect(arg_32_0, arg_32_1)
	arg_32_0:MoveToTargetMusicID(arg_32_1)
end

function var_0_0.OnExit(arg_33_0)
	manager.redPoint:unbindUIandKey(arg_33_0.limitRewardBtn_.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, MusicData:GetPageActivityID()))
	MusicData:SetCacheMusicTreePos(arg_33_0.musicTree:GetPosY())

	if arg_33_0.timer then
		arg_33_0.timer:Stop()

		arg_33_0.timer = nil
	end

	arg_33_0.musicTree:BindRed(false)
	arg_33_0.musicFilter:OnExit()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_34_0)
	arg_34_0:RemoveAllEventListener()

	if arg_34_0.timer then
		arg_34_0.timer:Stop()

		arg_34_0.timer = nil
	end

	if arg_34_0.limitRewardTimer then
		arg_34_0.limitRewardTimer:Stop()

		arg_34_0.limitRewardTimer = nil
	end

	for iter_34_0, iter_34_1 in pairs(arg_34_0.musicGroupList or {}) do
		iter_34_1:Dispose()

		iter_34_1 = nil
	end

	arg_34_0.musicGroupList = nil

	for iter_34_2, iter_34_3 in pairs(arg_34_0.musicSelectList or {}) do
		iter_34_3:Dispose()

		iter_34_3 = nil
	end

	arg_34_0.musicSelectList = nil

	arg_34_0.musicTree:Dispose()
	arg_34_0.musicFilter:Dispose()
	arg_34_0.musicContent:Dispose()
	var_0_0.super.Dispose(arg_34_0)
end

return var_0_0
