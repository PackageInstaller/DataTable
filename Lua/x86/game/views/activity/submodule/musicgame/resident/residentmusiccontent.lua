local var_0_0 = class("ResidentMusicContent", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0.trackDropdown_.options:Clear()

	arg_3_0.gradeController_ = ControllerUtil.GetController(arg_3_0.transform_, "grade")
	arg_3_0.linkTagController_ = arg_3_0.controller_:GetController("linkTag")
	arg_3_0.intonationController_ = arg_3_0.controller_:GetController("intonation")
	arg_3_0.difficultController_ = arg_3_0.controller_:GetController("difficult")
	arg_3_0.stateController_ = arg_3_0.controller_:GetController("state")
	arg_3_0.evaluateController_ = arg_3_0.controller_:GetController("evaluate")
	arg_3_0.trackStateController_ = arg_3_0.hardestController_:GetController("trackState")
	arg_3_0.selectDifficult = 0
	arg_3_0.difficultBtnShowStateControllerList = {}

	local var_3_0 = {
		MusicConst.MusicDiffcult.Normal,
		MusicConst.MusicDiffcult.Hard,
		MusicConst.MusicDiffcult.Challenge,
		MusicConst.MusicDiffcult.Hardest
	}

	for iter_3_0 = 1, arg_3_0.btnTabTrs_.childCount do
		local var_3_1 = arg_3_0.btnTabTrs_:GetChild(iter_3_0 - 1):GetComponent("ControllerExCollection"):GetController("state")
		local var_3_2 = var_3_0[iter_3_0]

		arg_3_0.difficultBtnShowStateControllerList[var_3_2] = var_3_1
	end
end

function var_0_0.GetHardestTackDataList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = ActivityMusicCfg.get_id_list_by_activity_id[arg_4_0.music_id]

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_2 = ActivityMusicCfg[iter_4_1]

		if var_4_2.difficult == MusicConst.MusicDiffcult.Hardest then
			table.insert(var_4_0, var_4_2)
		end
	end

	return var_4_0
end

function var_0_0.UpdateDropDownUIContent(arg_5_0)
	local var_5_0 = arg_5_0:GetHardestTackDataList()

	arg_5_0.dropDownText_ = {}
	arg_5_0.dropDownTrack = {}

	arg_5_0.trackDropdown_.options:Clear()

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_1 = string.format(GetTips("ACTIVITY_MUSIC_SETTING_KEY"), iter_5_1.track)

		arg_5_0.trackDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(var_5_1))

		arg_5_0.dropDownText_[#arg_5_0.dropDownText_ + 1] = var_5_1
		arg_5_0.dropDownTrack[#arg_5_0.dropDownTrack + 1] = iter_5_1.track
	end

	arg_5_0:RefreshDropDownOptions()

	arg_5_0.trackDropdown_.value = MusicData:GetTrackCount(arg_5_0.music_id) - 4
end

function var_0_0.RefreshDropDownOptions(arg_6_0)
	if arg_6_0.dropDownText_ then
		local var_6_0 = "<color=#000000>%s</color>"
		local var_6_1 = "<color=#FFFFFF>%s</color>"
		local var_6_2 = arg_6_0.trackDropdown_.options.Count

		for iter_6_0 = 1, var_6_2 do
			if iter_6_0 - 1 == arg_6_0.trackDropdown_.value then
				arg_6_0.trackDropdown_.options[iter_6_0 - 1].text = string.format(var_6_1, arg_6_0.dropDownText_[iter_6_0])
			else
				arg_6_0.trackDropdown_.options[iter_6_0 - 1].text = string.format(var_6_0, arg_6_0.dropDownText_[iter_6_0])
			end
		end
	end

	arg_6_0.trackDropdown_.captionText.text = arg_6_0.dropDownText_[arg_6_0.trackDropdown_.value + 1]
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.m_easyBtn, nil, function()
		arg_7_0:SetDifficulty(MusicConst.MusicDiffcult.Normal)
	end)
	arg_7_0:AddBtnListener(arg_7_0.m_difficult, nil, function()
		arg_7_0:SetDifficulty(MusicConst.MusicDiffcult.Hard)
	end)
	arg_7_0:AddBtnListener(arg_7_0.challengeBtn_, nil, function()
		arg_7_0:SetDifficulty(MusicConst.MusicDiffcult.Challenge)
	end)
	arg_7_0:AddBtnListener(arg_7_0.hardestBtn_, nil, function()
		arg_7_0:SetDifficulty(MusicConst.MusicDiffcult.Hardest)
	end)
	arg_7_0:AddToggleListener(arg_7_0.trackDropdown_, function(arg_12_0)
		arg_7_0:RefreshDropDownOptions()

		if arg_7_0.isInitDrop then
			return
		end

		arg_7_0:SetDifficulty(MusicConst.MusicDiffcult.Hardest, arg_7_0:GetTrackByDropValue(arg_12_0))
		MusicData:SetTrackCount(arg_7_0.music_id, arg_7_0:GetTrackByDropValue(arg_12_0))
	end)
	arg_7_0:AddBtnListener(arg_7_0.trackDownBtn_, nil, function()
		arg_7_0:SetDifficulty(MusicConst.MusicDiffcult.Hardest, arg_7_0:GetTrackByDropValue(arg_7_0.trackDropdown_.value))

		if #arg_7_0:GetHardestTackDataList() <= 1 then
			return
		end

		arg_7_0.trackDropdown_:Show()
	end)
end

function var_0_0.GetTrackByDropValue(arg_14_0, arg_14_1)
	return arg_14_0.dropDownTrack[arg_14_1 + 1] or 4
end

function var_0_0.SetDifficulty(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_2 or -1
	local var_15_1 = -1
	local var_15_2 = ActivityMusicCfg.get_id_list_by_activity_id[arg_15_0.music_id]

	for iter_15_0, iter_15_1 in pairs(var_15_2) do
		local var_15_3 = ActivityMusicCfg[iter_15_1]

		if var_15_3.difficult == arg_15_1 then
			if var_15_0 > 0 then
				if var_15_0 == var_15_3.track then
					var_15_1 = iter_15_0

					break
				end
			else
				var_15_1 = iter_15_0

				break
			end
		end
	end

	if arg_15_0.difficultIndex == var_15_1 then
		return
	end

	if var_15_1 < 0 then
		return
	end

	MusicData:SetDifficultIndex(arg_15_0.music_id, var_15_1)
	arg_15_0:RefreshUI()
end

function var_0_0.GetMusicID(arg_16_0)
	return arg_16_0.music_id
end

function var_0_0.SetData(arg_17_0, arg_17_1)
	arg_17_0.music_id = arg_17_1

	arg_17_0.trackDropdown_:Hide()

	arg_17_0.isInitDrop = true

	arg_17_0:UpdateDropDownUIContent()

	arg_17_0.isInitDrop = false

	arg_17_0:RefreshUI()
end

function var_0_0.GetMusicCfg(arg_18_0)
	local var_18_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_18_0.music_id]
	local var_18_1 = var_18_0[arg_18_0.difficultIndex] or var_18_0[1]

	return ActivityMusicCfg[var_18_1]
end

function var_0_0.UpdateDifficultyBtnShowState(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = 0
	local var_19_2 = ActivityMusicCfg.get_id_list_by_activity_id[arg_19_0.music_id]

	for iter_19_0, iter_19_1 in ipairs(var_19_2) do
		local var_19_3 = ActivityMusicCfg[iter_19_1]

		var_19_0[var_19_3.difficult] = true

		if var_19_3.difficult == MusicConst.MusicDiffcult.Hardest then
			var_19_1 = var_19_1 + 1
		end
	end

	for iter_19_2, iter_19_3 in pairs(arg_19_0.difficultBtnShowStateControllerList) do
		if var_19_0[iter_19_2] then
			iter_19_3:SetSelectedState("normal")
		else
			iter_19_3:SetSelectedState("hide")
		end
	end

	if var_19_1 > 1 then
		arg_19_0.trackStateController_:SetSelectedState("normal")
	else
		arg_19_0.trackStateController_:SetSelectedState("onlyOne")
	end
end

function var_0_0.RefreshUI(arg_20_0)
	arg_20_0:UpdateDifficultyBtnShowState()

	arg_20_0.difficultIndex = MusicData:GetDifficultyIndex(arg_20_0.music_id)
	arg_20_0.selectDifficult = arg_20_0:GetMusicCfg().difficult

	arg_20_0:UpdateMusicInfo()
	arg_20_0:UpdateDifficulty()
	arg_20_0:UpdateGradeInfo()
end

function var_0_0.CheckHaveDiffcultType(arg_21_0, arg_21_1)
	local var_21_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_21_0.music_id]

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if arg_21_1 == ActivityMusicCfg[iter_21_1].difficult then
			return true
		end
	end

	return false
end

function var_0_0.UpdateDifficulty(arg_22_0)
	if arg_22_0.selectDifficult == MusicConst.MusicDiffcult.Normal then
		arg_22_0.difficultController_:SetSelectedState("normal")
	elseif arg_22_0.selectDifficult == MusicConst.MusicDiffcult.Hard then
		arg_22_0.difficultController_:SetSelectedState("hard")
	elseif arg_22_0.selectDifficult == MusicConst.MusicDiffcult.Challenge then
		arg_22_0.difficultController_:SetSelectedState("challenge")
	elseif arg_22_0.selectDifficult == MusicConst.MusicDiffcult.Hardest then
		arg_22_0.difficultController_:SetSelectedState("hardest")
	end
end

function var_0_0.UpdateMusicInfo(arg_23_0)
	local var_23_0 = arg_23_0:GetMusicCfg()

	arg_23_0.m_author.text = GetI18NText(var_23_0.creator_name)
	arg_23_0.m_title.text = GetI18NText(var_23_0.name)

	local var_23_1 = var_23_0.icon

	arg_23_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music_icon/" .. var_23_1)
	arg_23_0.m_bgIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music1_icon/" .. var_23_1)

	local var_23_2 = MusicData:GetTagImagePath(var_23_0.id)

	if var_23_2 then
		arg_23_0.linkTagController_:SetSelectedState("show")

		arg_23_0.linkImage_.sprite = getSpriteWithoutAtlas(var_23_2)
	else
		arg_23_0.linkTagController_:SetSelectedState("hide")
	end
end

function var_0_0.UpdateGradeInfo(arg_24_0)
	local var_24_0 = MusicData:GetScore(arg_24_0:GetMusicCfg().id)
	local var_24_1 = MusicData:GetIsComplete(arg_24_0:GetMusicCfg().id)

	if MusicConst.MusicFinishState.Unfinished == var_24_1 then
		arg_24_0.stateController_:SetSelectedState("unfinish")
		arg_24_0.gradeController_:SetSelectedIndex(6)
	else
		arg_24_0.stateController_:SetSelectedState("normal")

		local var_24_2 = arg_24_0:GetMusicCfg()

		arg_24_0.m_scoreLab.text = var_24_0

		local var_24_3 = var_24_0 / var_24_2.total_score * 100
		local var_24_4 = arg_24_0:KeepDecimalPlace(var_24_3, 2)

		arg_24_0.m_accuracyLab.text = string.format("%.2f%%", var_24_4)

		local var_24_5 = GameSetting.attach_music_grade.value

		for iter_24_0, iter_24_1 in ipairs(var_24_5) do
			if iter_24_1 <= var_24_3 then
				arg_24_0.gradeController_:SetSelectedIndex(iter_24_0 - 1)

				break
			end
		end
	end

	if var_24_1 == MusicConst.MusicFinishState.Perfect then
		arg_24_0.evaluateController_:SetSelectedIndex(2)
	elseif var_24_1 == MusicConst.MusicFinishState.NoMistake then
		arg_24_0.evaluateController_:SetSelectedIndex(1)
	else
		arg_24_0.evaluateController_:SetSelectedIndex(0)
	end
end

function var_0_0.KeepDecimalPlace(arg_25_0, arg_25_1, arg_25_2)
	return math.floor(arg_25_1 * 10^arg_25_2) / 10^arg_25_2
end

function var_0_0.Dispose(arg_26_0)
	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
