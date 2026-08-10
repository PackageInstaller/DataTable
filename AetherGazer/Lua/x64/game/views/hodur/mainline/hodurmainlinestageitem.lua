local var_0_0 = class("HodurMainlineStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = arg_2_0.mainControllerEx_:GetController("state")
	arg_2_0.selectController_ = arg_2_0.mainControllerEx_:GetController("select")
	arg_2_0.lineController_ = arg_2_0.mainControllerEx_:GetController("line")
	arg_2_0.selected_ = false
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.stageBtn_, nil, function()
		if arg_3_0.onClickHandler_ then
			arg_3_0.onClickHandler_(arg_3_0.stageID_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.stageID_ = arg_5_1
	arg_5_0.pos_ = arg_5_2
	arg_5_0.last_ = arg_5_3
	arg_5_0.chapterID_ = arg_5_4

	arg_5_0:RefreshUI()
end

function var_0_0.SetClickHandler(arg_6_0, arg_6_1)
	arg_6_0.onClickHandler_ = arg_6_1
end

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	arg_7_0.selected_ = arg_7_1

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	if arg_8_0.last_ then
		arg_8_0.lineController_:SetSelectedState("off")
	else
		arg_8_0.lineController_:SetSelectedState("on")
	end

	local var_8_0 = ActivityHodurCfg[arg_8_0.stageID_]

	arg_8_0.selectController_:SetSelectedState(arg_8_0.selected_ and "on" or "off")

	arg_8_0.bossHeadImg_1.sprite = getSpriteWithoutAtlas(HodurConst.BOSS_IMG_PATH .. var_8_0.boss_img)
	arg_8_0.bossHeadImg_2.sprite = getSpriteWithoutAtlas(HodurConst.BOSS_IMG_PATH .. var_8_0.boss_img)

	if arg_8_0.isAni_ then
		return
	end

	if HodurTools.GetStagePass(arg_8_0.stageID_, arg_8_0.chapterID_) then
		arg_8_0.stateController_:SetSelectedState("Complete")
	elseif HodurTools.GetStageUnlock(arg_8_0.stageID_, arg_8_0.chapterID_) then
		if arg_8_0.pos_ ~= 1 and not getData("activity_hodur", "first_unlock_" .. arg_8_0.stageID_) then
			saveData("activity_hodur", "first_unlock_" .. arg_8_0.stageID_, true)
			arg_8_0.stateController_:SetSelectedState("lock")
			FrameTimer.New(function()
				if arg_8_0.aniTimer_ then
					arg_8_0.aniTimer_:Stop()

					arg_8_0.aniTimer_ = nil
					arg_8_0.isAni_ = false
				end

				arg_8_0.aniTimer_ = Timer.New(function()
					local var_10_0 = arg_8_0.animator_:GetCurrentAnimatorStateInfo(0)

					if var_10_0.normalizedTime >= 0.55 and not arg_8_0.aniNormal then
						arg_8_0.aniNormal = true

						arg_8_0.stateController_:SetSelectedState("Normal")
					end

					if var_10_0.normalizedTime >= 1 then
						if arg_8_0.aniTimer_ then
							arg_8_0.aniTimer_:Stop()

							arg_8_0.aniTimer_ = nil
						end

						arg_8_0.aniNormal = false

						manager.ui:UIEventEnabledByUI(true, false)

						arg_8_0.isAni_ = false
					end
				end, 0.033, -1)

				arg_8_0.aniTimer_:Start()
			end, 1, 1):Start()
			arg_8_0.animator_:Play("UI_itemCheckpoint_unlock", 0, 0)
			manager.audio:PlayEffect("minigame_activity_4_7", "minigame_activity_4_7_hodur_lock02", "")
			manager.ui:UIEventEnabledByUI(false, true)

			arg_8_0.isAni_ = true
		else
			arg_8_0.stateController_:SetSelectedState("Normal")
		end
	else
		arg_8_0.stateController_:SetSelectedState("lock")
	end
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.aniTimer_ then
		arg_11_0.aniTimer_:Stop()

		arg_11_0.aniTimer_ = nil
		arg_11_0.isAni_ = false
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
