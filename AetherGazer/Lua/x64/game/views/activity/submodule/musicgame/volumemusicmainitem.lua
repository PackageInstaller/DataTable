local var_0_0 = class("VolumeMusicMainItem", ReduxView)

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

		arg_4_0.difficultController_:SetSelectedIndex(arg_4_0.selectDifficult)
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
					MusicAction.Play(arg_4_0.surpriseId)
				end
			end
		end

		arg_4_0.selectDifficult = 1

		arg_4_0.difficultController_:SetSelectedIndex(arg_4_0.selectDifficult)
		MusicData:SetDifficultIndex(arg_4_0.music_id, arg_4_0.selectDifficult)
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

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.selectDifficult = MusicData:GetDifficultyIndex(arg_8_0.music_id)

	arg_8_0.difficultController_:SetSelectedIndex(arg_8_0.selectDifficult)

	local var_8_0 = arg_8_0.selectDifficult + 1
	local var_8_1 = ActivityMusicCfg.get_id_list_by_activity_id[arg_8_0.music_id][var_8_0]
	local var_8_2 = ActivityMusicCfg[var_8_1]

	arg_8_0:RefrenTime()

	arg_8_0.m_title.text = GetI18NText(var_8_2.name)
	arg_8_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIDownUI/" .. var_8_2.icon)
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	arg_9_0.callback_ = arg_9_1
end

function var_0_0.RefrenTime(arg_10_0)
	local var_10_0 = arg_10_0.selectDifficult + 1
	local var_10_1 = ActivityMusicCfg.get_id_list_by_activity_id[arg_10_0.music_id][var_10_0]
	local var_10_2 = ActivityMusicCfg[var_10_1]
	local var_10_3 = ActivityData:GetActivityData(arg_10_0.music_id)

	if var_10_3 then
		if var_10_3:IsActivitying() then
			local var_10_4 = MusicData:GetScore(arg_10_0.music_id, var_10_0)

			if var_10_4 == 0 then
				arg_10_0.stateController_:SetSelectedIndex(1)
				arg_10_0.gradeController_:SetSelectedIndex(5)
			else
				arg_10_0.stateController_:SetSelectedIndex(0)

				arg_10_0.m_scoreLab.text = var_10_4

				local var_10_5 = var_10_4 / var_10_2.total_score * 100

				arg_10_0.m_accuracyLab.text = string.format("%.2f%%", var_10_5)

				local var_10_6 = GameSetting.attach_music_grade.value

				for iter_10_0, iter_10_1 in ipairs(var_10_6) do
					if iter_10_1 <= var_10_5 then
						arg_10_0.gradeController_:SetSelectedIndex(iter_10_0 - 1)

						break
					end
				end
			end
		else
			local var_10_7 = manager.time:GetServerTime()

			if var_10_3 and var_10_7 < var_10_3.startTime then
				arg_10_0.m_lockLab.text = string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_10_3.startTime))
			else
				arg_10_0.m_lockLab.text = GetTips("TIME_OVER")
			end

			arg_10_0.stateController_:SetSelectedIndex(2)
			arg_10_0.gradeController_:SetSelectedIndex(5)
		end
	else
		arg_10_0.m_lockLab.text = GetTips("TIME_OVER")

		arg_10_0.stateController_:SetSelectedIndex(2)
	end
end

function var_0_0.UpdateScale(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.transform_:TransformPoint(Vector3(0, 0, 0))
	local var_11_1 = arg_11_1:InverseTransformPoint(var_11_0).x + arg_11_0.transform_.rect.width / 2
	local var_11_2 = 1 - math.abs(var_11_1) / 8000

	arg_11_0.m_content.localScale = Vector2.New(var_11_2, var_11_2)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
