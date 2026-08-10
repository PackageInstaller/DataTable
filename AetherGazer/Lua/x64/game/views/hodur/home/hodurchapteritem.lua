local var_0_0 = class("HodurChapterItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = arg_2_0.mainControllerEx_:GetController("state")

	for iter_2_0 = 1, 3 do
		arg_2_0["starController_" .. iter_2_0] = arg_2_0["starControllerEx_" .. iter_2_0]:GetController("star")
	end
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.selfBtn_, nil, function()
		if HodurTools.GetChapterState(arg_3_0.chapterID_) == HodurConst.COMMON_STATE.LOCK then
			local var_4_0 = ActivityHodurChapterCfg[arg_3_0.chapterID_].previous_chapter
			local var_4_1 = ActivityHodurChapterCfg[var_4_0]

			ShowTips(string.format(GetTips("ACTIVITY_TOWER_DEFENSE_UNLOCK_DESC"), var_4_1.chapter_name))

			return
		end

		JumpTools.OpenPageByJump("/hodurMainlineView", {
			chapter_id = arg_3_0.chapterID_,
			activity_id = ActivityConst.ACTIVITY_HODUR_MAIN
		})
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.unlockMode_ = false
	arg_5_0.chapterID_ = arg_5_1

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	if arg_6_0.unlockMode_ or HodurTools.GetChapterState(arg_6_0.chapterID_) == HodurConst.COMMON_STATE.LOCK then
		arg_6_0.stateController_:SetSelectedState("lock")
	elseif HodurTools.GetChapterState(arg_6_0.chapterID_) == HodurConst.COMMON_STATE.UNLOCK then
		arg_6_0.stateController_:SetSelectedState("lock")
		arg_6_0.stateController_:SetSelectedState("unlock")
	else
		arg_6_0.stateController_:SetSelectedState("pass")
	end

	local var_6_0 = #ActivityHodurChapterCfg[arg_6_0.chapterID_].stage_list
	local var_6_1 = HodurTools.GetChapterProgress(arg_6_0.chapterID_)

	for iter_6_0 = 1, 3 do
		if iter_6_0 <= var_6_0 then
			SetActive(arg_6_0["starGo_" .. iter_6_0], true)
		else
			SetActive(arg_6_0["starGo_" .. iter_6_0], false)
		end
	end

	for iter_6_1 = 1, var_6_0 do
		if iter_6_1 <= var_6_1 then
			arg_6_0["starController_" .. iter_6_1]:SetSelectedState("on")
		else
			arg_6_0["starController_" .. iter_6_1]:SetSelectedState("off")
		end
	end

	arg_6_0.chapterNameText_.text = ActivityHodurChapterCfg[arg_6_0.chapterID_].chapter_name
end

function var_0_0.SetUnlockMode(arg_7_0)
	arg_7_0.unlockMode_ = true
end

function var_0_0.PlayUnlockAnim(arg_8_0)
	arg_8_0.stateController_:SetSelectedState("lock")

	arg_8_0.animator_.enabled = true

	arg_8_0.animator_:Play("UI_itemNormal01_unlock_cx", 0, 0)

	arg_8_0.aniTimer_ = Timer.New(function()
		if arg_8_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			arg_8_0.animator_.enabled = false

			arg_8_0.stateController_:SetSelectedState("unlock")
			manager.ui:UIEventEnabled(true)

			arg_8_0.unlockMode_ = false

			if arg_8_0.aniTimer_ then
				arg_8_0.aniTimer_:Stop()

				arg_8_0.aniTimer_ = nil
			end
		end
	end, 0.033, -1)

	arg_8_0.aniTimer_:Start()
	manager.ui:UIEventEnabled(false)
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.aniTimer_ then
		arg_10_0.aniTimer_:Stop()

		arg_10_0.aniTimer_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
