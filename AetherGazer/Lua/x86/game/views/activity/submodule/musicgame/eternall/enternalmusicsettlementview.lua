local var_0_0 = class("EnternalMusicSettlementView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicScoreUI"
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
	arg_4_0.newController_ = ControllerUtil.GetController(arg_4_0.transform_, "new")
	arg_4_0.evaluateController_ = ControllerUtil.GetController(arg_4_0.transform_, "evaluate")
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
		OpenPageUntilLoaded("/enternalMusicMain", {
			activity_id = ActivityConst.ENTERNAL_MUSIC
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_backBtn, nil, function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/enternalMusicMain", {
			activity_id = ActivityConst.ENTERNAL_MUSIC
		})
	end)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = MusicData:GetGameId()
	local var_11_1 = ActivityMusicCfg[var_11_0]

	arg_11_0.m_name.text = GetI18NText(var_11_1.name)
	arg_11_0.m_bg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng1stUI/" .. var_11_1.icon)

	if var_11_1.difficult == 2 then
		arg_11_0.difficultController_:SetSelectedIndex(1)
	elseif var_11_1.difficult == 9 then
		arg_11_0.difficultController_:SetSelectedIndex(2)
	else
		arg_11_0.difficultController_:SetSelectedIndex(0)
	end

	local var_11_2 = arg_11_0.params_.cur
	local var_11_3 = arg_11_0.params_.max

	arg_11_0.m_curScoreLab.text = var_11_2
	arg_11_0.m_maxScoreLab.text = var_11_3

	local var_11_4 = var_11_2 / var_11_1.total_score * 100

	arg_11_0.m_comboLab.text = MusicData:GetMaxComboHit()
	arg_11_0.m_accuracyLab.text = string.format("%.2f%%", var_11_4)

	local var_11_5 = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Miss)
	local var_11_6 = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Good)

	arg_11_0.m_mistakeLab.text = var_11_5
	arg_11_0.m_preciseLab.text = var_11_6
	arg_11_0.m_perfectLab.text = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Perfect)
	arg_11_0.m_perfectPluasLab.text = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.PerfectPlus)

	if var_11_6 == 0 and var_11_5 == 0 then
		arg_11_0.evaluateController_:SetSelectedIndex(2)
	elseif var_11_5 == 0 then
		arg_11_0.evaluateController_:SetSelectedIndex(1)
	else
		arg_11_0.evaluateController_:SetSelectedIndex(0)
	end

	arg_11_0.newController_:SetSelectedIndex(arg_11_0.params_.new and 1 or 0)

	local var_11_7 = GameSetting.attach_music_grade.value

	for iter_11_0, iter_11_1 in ipairs(var_11_7) do
		if iter_11_1 <= var_11_4 then
			arg_11_0.gradeController_:SetSelectedIndex(iter_11_0 - 1)

			break
		end
	end
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
