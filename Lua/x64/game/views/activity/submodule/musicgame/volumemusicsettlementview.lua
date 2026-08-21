local var_0_0 = class("VolumeMusicSettlementView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicSettlementUI"
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

	arg_4_0.difficultController_ = ControllerUtil.GetController(arg_4_0.transform_, "difficult")
	arg_4_0.gradeController_ = ControllerUtil.GetController(arg_4_0.transform_, "grade")
	arg_4_0.fullComboController_ = ControllerUtil.GetController(arg_4_0.transform_, "fullCombo")
	arg_4_0.newController_ = ControllerUtil.GetController(arg_4_0.transform_, "new")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_restartBtn, nil, function()
		local var_6_0 = MusicData:GetGameId()
		local var_6_1 = ActivityMusicCfg[var_6_0]

		if var_6_1 then
			SDKTools.SendMessageToSDK("activity_music_start", {
				is_restart = false,
				activity_id = var_6_1.activity_id,
				difficulty_id = var_6_1.difficult
			})
		end

		MusicLuaBridge.ReStartMusicGame()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_backBtn, nil, function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/volumeMusicMain", {
			activity_id = ActivityConst.VOLUME_MUSIC
		})
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = MusicData:GetGameId()
	local var_10_1 = ActivityMusicCfg[var_10_0]

	arg_10_0.m_name.text = GetI18NText(var_10_1.name)
	arg_10_0.m_bg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIDownUI/" .. var_10_1.icon)

	if var_10_1.difficult == 2 then
		arg_10_0.difficultController_:SetSelectedIndex(1)
	elseif var_10_1.difficult == 9 then
		arg_10_0.difficultController_:SetSelectedIndex(2)
	else
		arg_10_0.difficultController_:SetSelectedIndex(0)
	end

	local var_10_2 = arg_10_0.params_.cur
	local var_10_3 = arg_10_0.params_.max

	arg_10_0.m_curScoreLab.text = var_10_2
	arg_10_0.m_maxScoreLab.text = var_10_3

	local var_10_4 = var_10_2 / var_10_1.total_score * 100

	arg_10_0.m_comboLab.text = MusicData:GetMaxComboHit()
	arg_10_0.m_accuracyLab.text = string.format("%.2f%%", var_10_4)

	local var_10_5 = MusicData:GetGameRecord(-1)

	arg_10_0.m_perfectLab.text = MusicData:GetGameRecord(1)
	arg_10_0.m_preciseLab.text = MusicData:GetGameRecord(0)
	arg_10_0.m_mistakeLab.text = var_10_5

	if var_10_5 == 0 then
		arg_10_0.fullComboController_:SetSelectedIndex(1)
	else
		arg_10_0.fullComboController_:SetSelectedIndex(0)
	end

	arg_10_0.newController_:SetSelectedIndex(arg_10_0.params_.new and 1 or 0)

	local var_10_6 = GameSetting.attach_music_grade.value

	for iter_10_0, iter_10_1 in ipairs(var_10_6) do
		if iter_10_1 <= var_10_4 then
			arg_10_0.gradeController_:SetSelectedIndex(iter_10_0 - 1)

			break
		end
	end
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
