local var_0_0 = class("EnternalMusicMainItem", ReduxView)

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
	arg_3_0.selectDifficult = 0
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_easyBtn, nil, function()
		arg_4_0.selectDifficult = 0

		MusicData:SetDifficultIndex(arg_4_0.music_id, arg_4_0.selectDifficult)
		arg_4_0:RefreshUI()
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_difficult, nil, function()
		if arg_4_0.surpriseId ~= 0 then
			local var_6_0 = Time.realtimeSinceStartup

			if var_6_0 - 5 > arg_4_0.surpriseTime then
				arg_4_0.surpriseTime = var_6_0
				arg_4_0.surpriseCount = 1
			else
				arg_4_0.surpriseCount = arg_4_0.surpriseCount + 1

				if arg_4_0.surpriseCount >= 5 then
					if not arg_4_0.surpriseHard then
						arg_4_0.m_hardAnim:Play("ex_difficult", 0, 0)
					end

					arg_4_0.surpriseHard = true
				end
			end
		end

		if arg_4_0.surpriseHard then
			arg_4_0.selectDifficult = 2

			MusicData:SetDifficultIndex(arg_4_0.music_id, 2)
		else
			arg_4_0.selectDifficult = 1

			MusicData:SetDifficultIndex(arg_4_0.music_id, 1)
		end

		arg_4_0:RefreshUI()
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.music_id = arg_7_1
	arg_7_0.surpriseTime = 0
	arg_7_0.surpriseCount = 0
	arg_7_0.surpriseId = 0

	local var_7_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_7_0.music_id]

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if ActivityMusicCfg[iter_7_1].difficult > 2 then
			arg_7_0.surpriseId = iter_7_1

			break
		end
	end

	arg_7_0.surpriseHard = false
	arg_7_0.selectDifficult = MusicData:GetDifficultyIndex(arg_7_0.music_id)
	arg_7_0.selectDifficult = math.min(arg_7_0.selectDifficult, 1)

	MusicData:SetDifficultIndex(arg_7_0.music_id, arg_7_0.selectDifficult)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.selectDifficult = MusicData:GetDifficultyIndex(arg_8_0.music_id)

	arg_8_0.difficultController_:SetSelectedIndex(math.min(arg_8_0.selectDifficult, 1))

	if arg_8_0.surpriseHard then
		arg_8_0.m_hardLab.text = GetTips("ACTIVITY_MUSIC_LEVEL_3")
	else
		arg_8_0.m_hardLab.text = GetTips("ACTIVITY_MUSIC_LEVEL_2")
	end

	local var_8_0 = arg_8_0.selectDifficult + 1
	local var_8_1 = ActivityMusicCfg.get_id_list_by_activity_id[arg_8_0.music_id][var_8_0]
	local var_8_2 = ActivityMusicCfg[var_8_1]

	arg_8_0.m_title.text = GetI18NText(var_8_2.name)
	arg_8_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng1stUI/" .. var_8_2.icon)

	arg_8_0:RefreshActivity()
	arg_8_0:RefrenTime()
end

function var_0_0.RefreshActivity(arg_9_0)
	local var_9_0 = arg_9_0.selectDifficult + 1
	local var_9_1 = ActivityMusicCfg.get_id_list_by_activity_id[arg_9_0.music_id][var_9_0]
	local var_9_2 = ActivityMusicCfg[var_9_1]
	local var_9_3 = ActivityData:GetActivityData(arg_9_0.music_id)

	if var_9_3 and var_9_3:IsActivitying() then
		local var_9_4 = MusicData:GetScore(arg_9_0.music_id, var_9_0)

		if var_9_4 == 0 then
			arg_9_0.stateController_:SetSelectedIndex(1)
			arg_9_0.gradeController_:SetSelectedIndex(6)
		else
			arg_9_0.stateController_:SetSelectedIndex(0)

			arg_9_0.m_scoreLab.text = var_9_4

			local var_9_5 = var_9_4 / var_9_2.total_score * 100
			local var_9_6 = arg_9_0:KeepDecimalPlace(var_9_5, 2)

			arg_9_0.m_accuracyLab.text = string.format("%.2f%%", var_9_6)

			local var_9_7 = GameSetting.attach_music_grade.value

			for iter_9_0, iter_9_1 in ipairs(var_9_7) do
				if iter_9_1 <= var_9_5 then
					arg_9_0.gradeController_:SetSelectedIndex(iter_9_0 - 1)

					break
				end
			end
		end
	end
end

function var_0_0.KeepDecimalPlace(arg_10_0, arg_10_1, arg_10_2)
	return math.floor(arg_10_1 * 10^arg_10_2) / 10^arg_10_2
end

function var_0_0.RegistCallBack(arg_11_0, arg_11_1)
	arg_11_0.callback_ = arg_11_1
end

function var_0_0.RefrenTime(arg_12_0)
	local var_12_0 = arg_12_0.selectDifficult + 1
	local var_12_1 = ActivityMusicCfg.get_id_list_by_activity_id[arg_12_0.music_id][var_12_0]
	local var_12_2 = ActivityMusicCfg[var_12_1]
	local var_12_3 = ActivityData:GetActivityData(arg_12_0.music_id)

	if var_12_3 then
		if not var_12_3:IsActivitying() then
			local var_12_4 = manager.time:GetServerTime()

			if var_12_3 and var_12_4 <= var_12_3.startTime + 1 then
				arg_12_0.m_lockLab.text = string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_12_3.startTime))
			else
				arg_12_0.m_lockLab.text = GetTips("TIME_OVER")
			end

			arg_12_0.stateController_:SetSelectedIndex(2)
			arg_12_0.gradeController_:SetSelectedIndex(6)
		elseif arg_12_0.stateController_:GetSelectedState() == "2" then
			arg_12_0:RefreshActivity()
		end
	else
		arg_12_0.m_lockLab.text = GetTips("TIME_OVER")

		arg_12_0.stateController_:SetSelectedIndex(2)
	end
end

function var_0_0.UpdateScale(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.transform_:TransformPoint(Vector3(0, 0, 0))
	local var_13_1 = arg_13_1:InverseTransformPoint(var_13_0).x + arg_13_0.transform_.rect.width / 2
	local var_13_2 = 1 - math.abs(var_13_1) / 8000

	arg_13_0.m_content.localScale = Vector2.New(var_13_2, var_13_2)
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
