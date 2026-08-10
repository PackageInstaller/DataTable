local var_0_0 = class("V210MusicMainItem", ReduxView)

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

	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.gradeController_ = ControllerUtil.GetController(arg_3_0.transform_, "grade")
	arg_3_0.difficultController_ = ControllerUtil.GetController(arg_3_0.transform_, "difficult")
	arg_3_0.linkTagController_ = arg_3_0.controller_:GetController("linkTag")
	arg_3_0.selectDifficult = 0
	arg_3_0.isFistSetData = true
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_easyBtn, nil, function()
		arg_4_0:SelectDiffectType(0)
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_difficult, nil, function()
		if arg_4_0:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Challenge) == false then
			arg_4_0:EnterHardest()
		end

		arg_4_0:SelectDiffectType(1)
	end)
	arg_4_0:AddBtnListener(arg_4_0.challengeBtn_, nil, function()
		arg_4_0:EnterHardest()
		arg_4_0:SelectDiffectType(2)
	end)
	arg_4_0:AddBtnListener(arg_4_0.hardestBtn_, nil, function()
		return
	end)
end

function var_0_0.SelectDiffectType(arg_9_0, arg_9_1)
	if arg_9_0.surpriseHard then
		local var_9_0 = arg_9_0:GetHardestIndex()

		arg_9_0.selectDifficult = var_9_0

		MusicData:SetDifficultIndex(arg_9_0.music_id, var_9_0)
	else
		if not arg_9_1 then
			arg_9_1 = arg_9_0:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Challenge) and MusicConst.MusicDiffcult.Challenge or MusicConst.MusicDiffcult.Hard
			arg_9_1 = arg_9_1 - 1
		end

		arg_9_0.selectDifficult = arg_9_1

		MusicData:SetDifficultIndex(arg_9_0.music_id, arg_9_1)
	end

	arg_9_0:RefreshUI()
end

function var_0_0.GetHardestIndex(arg_10_0)
	local var_10_0 = 2

	if arg_10_0:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Challenge) then
		var_10_0 = 3
	end

	return var_10_0
end

function var_0_0.EnterHardest(arg_11_0)
	if arg_11_0.surpriseId == 0 then
		return
	end

	local var_11_0 = Time.realtimeSinceStartup

	if var_11_0 - 5 > arg_11_0.surpriseTime then
		arg_11_0.surpriseTime = var_11_0
		arg_11_0.surpriseCount = 1
	else
		arg_11_0.surpriseCount = arg_11_0.surpriseCount + 1

		if arg_11_0.surpriseCount >= 5 and (arg_11_0.surpriseHard or true) then
			arg_11_0.surpriseHard = true
		end
	end
end

function var_0_0.CheckHaveDiffcultType(arg_12_0, arg_12_1)
	local var_12_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_12_0.music_id]

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if arg_12_1 == ActivityMusicCfg[iter_12_1].difficult then
			return true
		end
	end

	return false
end

function var_0_0.SetBtnShowState(arg_13_0)
	local var_13_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_13_0.music_id]

	SetActive(arg_13_0.m_easyBtn.gameObject, arg_13_0:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Normal))
	SetActive(arg_13_0.m_difficult.gameObject, arg_13_0:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Hard))
	SetActive(arg_13_0.challengeBtn_.gameObject, arg_13_0:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Challenge))
end

function var_0_0.SetData(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0.index = arg_14_1
	arg_14_0.music_id = arg_14_2
	arg_14_0.isLookBack = arg_14_3

	arg_14_0:SetBtnShowState()

	arg_14_0.surpriseTime = 0
	arg_14_0.surpriseCount = 0
	arg_14_0.surpriseId = 0

	local var_14_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_14_0.music_id]

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = ActivityMusicCfg[iter_14_1]

		if MusicConst.MusicDiffcult.Hardest == var_14_1.difficult then
			arg_14_0.surpriseId = iter_14_1

			break
		end
	end

	arg_14_0.surpriseHard = false
	arg_14_0.selectDifficult = MusicData:GetDifficultyIndex(arg_14_0.music_id)

	if arg_14_0.selectDifficult == arg_14_0:GetHardestIndex() and arg_14_0.isFistSetData then
		arg_14_0.isFistSetData = false
	else
		if arg_14_0:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Challenge) then
			arg_14_0.selectDifficult = math.min(arg_14_0.selectDifficult, 2)
		else
			arg_14_0.selectDifficult = math.min(arg_14_0.selectDifficult, 1)
		end

		MusicData:SetDifficultIndex(arg_14_0.music_id, arg_14_0.selectDifficult)
	end

	arg_14_0:RefreshUI()
end

function var_0_0.UpdateDifficultController(arg_15_0)
	if arg_15_0.surpriseHard or arg_15_0.selectDifficult == arg_15_0:GetHardestIndex() then
		arg_15_0.difficultController_:SetSelectedIndex(3)
	else
		arg_15_0.difficultController_:SetSelectedIndex(arg_15_0.selectDifficult)
	end
end

function var_0_0.RefreshUI(arg_16_0)
	arg_16_0.selectDifficult = MusicData:GetDifficultyIndex(arg_16_0.music_id)

	arg_16_0:UpdateDifficultController()

	local var_16_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_16_0.music_id][arg_16_0.selectDifficult + 1]
	local var_16_1 = ActivityMusicCfg[var_16_0]

	arg_16_0.linkTagController_:SetSelectedIndex(ActivityMusicCfg[var_16_0].tagType)

	arg_16_0.m_title.text = GetI18NText(var_16_1.name)

	local var_16_2 = var_16_1.icon

	arg_16_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music_icon/" .. var_16_2)
	arg_16_0.m_bgIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music1_icon/" .. var_16_2)
	arg_16_0.m_author.text = GetI18NText(var_16_1.creator_name)

	arg_16_0:RefreshActivity()
	arg_16_0:RefrenTime()
end

function var_0_0.RefreshActivity(arg_17_0)
	local var_17_0 = arg_17_0.selectDifficult + 1
	local var_17_1 = ActivityMusicCfg.get_id_list_by_activity_id[arg_17_0.music_id][var_17_0]
	local var_17_2 = ActivityMusicCfg[var_17_1]
	local var_17_3 = ActivityData:GetActivityData(arg_17_0.music_id)

	if var_17_3 and var_17_3:IsActivitying() or arg_17_0.isLookBack then
		local var_17_4 = MusicData:GetScore(arg_17_0.music_id, var_17_2.difficult)
		local var_17_5 = MusicData:GetIsComplete(arg_17_0.music_id, var_17_2.difficult)

		if MusicConst.MusicFinishState.Unfinished == var_17_5 then
			arg_17_0.stateController_:SetSelectedIndex(1)
			arg_17_0.gradeController_:SetSelectedIndex(6)
		else
			arg_17_0.stateController_:SetSelectedIndex(0)

			arg_17_0.m_scoreLab.text = var_17_4

			local var_17_6 = var_17_4 / var_17_2.total_score * 100
			local var_17_7 = arg_17_0:KeepDecimalPlace(var_17_6, 2)

			arg_17_0.m_accuracyLab.text = string.format("%.2f%%", var_17_7)

			local var_17_8 = GameSetting.attach_music_grade.value

			for iter_17_0, iter_17_1 in ipairs(var_17_8) do
				if iter_17_1 <= var_17_6 then
					arg_17_0.gradeController_:SetSelectedIndex(iter_17_0 - 1)

					break
				end
			end
		end
	end
end

function var_0_0.KeepDecimalPlace(arg_18_0, arg_18_1, arg_18_2)
	return math.floor(arg_18_1 * 10^arg_18_2) / 10^arg_18_2
end

function var_0_0.RegistCallBack(arg_19_0, arg_19_1)
	arg_19_0.callback_ = arg_19_1
end

function var_0_0.RefrenTime(arg_20_0)
	local var_20_0 = arg_20_0.selectDifficult + 1
	local var_20_1 = ActivityMusicCfg.get_id_list_by_activity_id[arg_20_0.music_id][var_20_0]
	local var_20_2 = ActivityMusicCfg[var_20_1]
	local var_20_3 = ActivityData:GetActivityData(arg_20_0.music_id)

	if arg_20_0.isLookBack then
		arg_20_0:RefreshActivity()

		return
	end

	if var_20_3 then
		if not var_20_3:IsActivitying() then
			local var_20_4 = manager.time:GetServerTime()

			if var_20_3 and var_20_4 <= var_20_3.startTime + 1 then
				arg_20_0.m_lockLab.text = string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_20_3.startTime))
			else
				arg_20_0.m_lockLab.text = GetTips("TIME_OVER")
			end

			arg_20_0.stateController_:SetSelectedIndex(2)
			arg_20_0.gradeController_:SetSelectedIndex(6)
		elseif arg_20_0.stateController_:GetSelectedState() == "2" then
			arg_20_0:RefreshActivity()
		end
	else
		arg_20_0.m_lockLab.text = GetTips("TIME_OVER")

		arg_20_0.stateController_:SetSelectedIndex(2)
	end
end

function var_0_0.UpdateScale(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.transform_:TransformPoint(Vector3(0, 0, 0))
	local var_21_1 = arg_21_1:InverseTransformPoint(var_21_0).x + arg_21_0.transform_.rect.width / 2
	local var_21_2 = 1 - math.abs(var_21_1) / 8000

	arg_21_0.m_content.localScale = Vector2.New(var_21_2, var_21_2)
end

function var_0_0.Dispose(arg_22_0)
	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.MoveAniEffect(arg_23_0, arg_23_1)
	local var_23_0 = math.abs(arg_23_1 - arg_23_0.index)

	if var_23_0 < 0.1 then
		var_23_0 = 0
	end

	arg_23_0.m_content.localScale = Vector3.Lerp(Vector3.one, Vector3.one * 0.8, var_23_0)
	arg_23_0.alphaCanvasgroup_.alpha = Mathf.Lerp(1, 0.8, var_23_0)

	if var_23_0 < 0.2 then
		arg_23_0.alphaCanvasgroup_.blocksRaycasts = true
	else
		arg_23_0.alphaCanvasgroup_.blocksRaycasts = false
	end
end

return var_0_0
