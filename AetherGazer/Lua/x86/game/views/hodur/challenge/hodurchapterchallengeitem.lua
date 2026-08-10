local var_0_0 = class("HodurChapterChallengeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = arg_2_0.mainControllerEx_:GetController("state")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.selfBtn_, nil, function()
		if HodurTools.GetChapterState(arg_3_0.chapterID_) == HodurConst.COMMON_STATE.LOCK then
			local var_4_0 = ActivityHodurChapterCfg[arg_3_0.chapterID_].previous_chapter
			local var_4_1 = ActivityHodurChapterCfg[var_4_0]

			ShowTips(string.format(GetTips("ACTIVITY_TOWER_DEFENSE_UNLOCK_DESC"), var_4_1.chapter_name))

			return
		end

		JumpTools.OpenPageByJump("/hodurChallengeView", {
			chapter_id = 4,
			activity_id = ActivityConst.ACTIVITY_HODUR_MAIN
		})
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.chapterID_ = arg_5_1
	arg_5_0.unlockMode_ = false

	arg_5_0:RefreshUI()
end

function var_0_0.SetUnlockMode(arg_6_0)
	arg_6_0.unlockMode_ = true
end

function var_0_0.PlayUnlockAnim(arg_7_0)
	arg_7_0.stateController_:SetSelectedState("lock")

	arg_7_0.animator_.enabled = true

	arg_7_0.animator_:Play("UI_itemChallenge_unlock_cx", 0, 0)

	arg_7_0.aniTimer_ = Timer.New(function()
		if arg_7_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			arg_7_0.stateController_:SetSelectedState("unlock")

			arg_7_0.animator_.enabled = false
			arg_7_0.unlockMode_ = false

			manager.ui:UIEventEnabled(true)

			if arg_7_0.aniTimer_ then
				arg_7_0.aniTimer_:Stop()

				arg_7_0.aniTimer_ = nil
			end
		end
	end, 0.033, -1)

	arg_7_0.aniTimer_:Start()
	manager.ui:UIEventEnabled(false)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.chapterNameText_.text = ActivityHodurChapterCfg[arg_9_0.chapterID_].chapter_name

	if arg_9_0.unlockMode_ or HodurTools.GetChapterState(arg_9_0.chapterID_) == HodurConst.COMMON_STATE.LOCK then
		arg_9_0.stateController_:SetSelectedState("lock")
	else
		arg_9_0.stateController_:SetSelectedState("unlock")
	end

	arg_9_0.scoreText_.text = HodurTools.GetChallengeMaxScore()
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.aniTimer_ then
		arg_10_0.aniTimer_:Stop()

		arg_10_0.aniTimer_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
