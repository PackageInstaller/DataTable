local var_0_0 = class("BossChallengeModeItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "chooseItem")
	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
	arg_1_0.chooseHandler_ = handler(arg_1_0, arg_1_0.ChooseMode)

	manager.notify:RegistListener(CHALLENGE_CHOOSE_MODE, arg_1_0.chooseHandler_)
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	manager.notify:RemoveListener(CHALLENGE_CHOOSE_MODE, arg_2_0.chooseHandler_)

	arg_2_0.chooseHandler_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		local var_4_0 = BattleBossChallengeData:GetOpenModeList()
		local var_4_1 = BossChallengeAdvanceCfg.all[arg_3_0.index_]

		if table.keyof(var_4_0, var_4_1) == nil then
			local var_4_2 = BossChallengeAdvanceCfg[BossChallengeAdvanceCfg.all[arg_3_0.index_ - 1]]

			if var_4_2.type == 1 then
				ShowTips(string.format(GetTips("BOSS_CHALLENGE_UNLOCK_TIPS"), GetI18NText(var_4_2.name2), BossChallengeAdvanceCfg[var_4_1].open_condition))
			else
				ShowTips(string.format(GetTips("BOSS_CHALLENGE_ADVANCE_UNLOCK_TIPS"), GetI18NText(var_4_2.name2), BossChallengeAdvanceCfg[var_4_1].open_condition))
			end

			return
		end

		manager.notify:Invoke(CHALLENGE_CHOOSE_MODE, arg_3_0.index_)
	end)
end

function var_0_0.ChooseMode(arg_5_0, arg_5_1)
	if arg_5_0.index_ == arg_5_1 then
		arg_5_0.selectController_:SetSelectedState("on")
	else
		arg_5_0.selectController_:SetSelectedState("off")
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1

	local var_6_0 = BossChallengeAdvanceCfg.all[arg_6_1]
	local var_6_1 = BossChallengeAdvanceCfg[var_6_0]

	arg_6_0.modeText_.text = GetI18NText(var_6_1.name)

	if var_6_1.type == 2 then
		arg_6_0.difficultText_.text = ""

		local var_6_2 = table.keyof(BossChallengeAdvanceCfg.get_id_list_by_type[2], var_6_0)

		arg_6_0.romaImage_.sprite = getSprite("Atlas/Tower", string.format("bg_n%s", var_6_2))
	else
		arg_6_0.difficultText_.text = GetI18NText(var_6_1.name2)
	end

	SetActive(arg_6_0.romaGo_, var_6_1.type == 2)
	SetSpriteWithoutAtlasAsync(arg_6_0.bgImage_, SpritePathCfg.ChapterPaint.path .. var_6_1.bg)

	if table.keyof(BattleBossChallengeData:GetOpenModeList(), var_6_0) then
		arg_6_0.lockController_:SetSelectedState("false")
	else
		arg_6_0.lockController_:SetSelectedState("true")
	end

	arg_6_0:ChooseMode(arg_6_2)
end

return var_0_0
