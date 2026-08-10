local var_0_0 = class("ActivityHeroEnhanceTalentItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.selController_ = arg_2_0.controller_:GetController("select")
	arg_2_0.lockController_ = arg_2_0.controller_:GetController("lock")
	arg_2_0.addController_ = arg_2_0.controller_:GetController("add")
	arg_2_0.useController_ = arg_2_0.controller_:GetController("use")
	arg_2_0.effectController_ = arg_2_0.controller_:GetController("effect")
	arg_2_0.textNameController_ = arg_2_0.controller_:GetController("textName")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.onClickHandler_ then
			arg_3_0.onClickHandler_(arg_3_0.talentId_)
		end
	end)
end

function var_0_0.SetMainTag(arg_5_0, arg_5_1)
	arg_5_0.mainTag_ = arg_5_1
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.activityId_ = arg_6_1
	arg_6_0.talentId_ = arg_6_2
end

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	arg_7_0.selected_ = arg_7_1
end

function var_0_0.SetUsed(arg_8_0, arg_8_1)
	arg_8_0.used_ = arg_8_1
end

function var_0_0.SetLock(arg_9_0, arg_9_1)
	arg_9_0.locked_ = arg_9_1
end

function var_0_0.SetFirstAddFlag(arg_10_0, arg_10_1)
	arg_10_0.isFirstAdd_ = arg_10_1
end

function var_0_0.SetClickHandler(arg_11_0, arg_11_1)
	arg_11_0.onClickHandler_ = arg_11_1
end

local var_0_1 = {
	"Ⅰ",
	"Ⅱ",
	"Ⅲ",
	"Ⅳ",
	"Ⅴ",
	"Ⅵ",
	"Ⅶ",
	"Ⅷ",
	"Ⅸ"
}

function var_0_0.RefreshUI(arg_12_0)
	local var_12_0 = arg_12_0.talentId_

	if var_12_0 then
		local var_12_1 = TalentTreeCfg[var_12_0]

		arg_12_0.affixImage_.sprite = getAffixSprite({
			var_12_1.affix_id
		})

		if arg_12_0.affixNameText_ then
			arg_12_0.affixNameText_.text = GetI18NText(var_12_1.name)
		end

		if arg_12_0.textNameController_ then
			arg_12_0.textNameController_:SetSelectedState("true")
		end

		local var_12_2 = ActivityHeroEnhanceTools.GetCfgByTalentId(arg_12_0.activityId_, var_12_0)
		local var_12_3 = ActivityHeroEnhanceTools.GetCfgTalentListByStage(var_12_2, var_12_1.stage)
		local var_12_4 = table.indexof(var_12_3, var_12_0)

		arg_12_0.affixLevelText_.text = var_0_1[var_12_4]

		SetActive(arg_12_0.affixLevelGo_, true)
		arg_12_0.addController_:SetSelectedState("false")
	else
		if arg_12_0.affixNameText_ then
			arg_12_0.affixNameText_.text = ""
		end

		if arg_12_0.textNameController_ then
			arg_12_0.textNameController_:SetSelectedState("false")
		end

		SetActive(arg_12_0.affixLevelGo_, false)
		arg_12_0.addController_:SetSelectedState("true")
	end

	if arg_12_0.effectController_ then
		if arg_12_0.isFirstAdd_ then
			arg_12_0.effectController_:SetSelectedState("firstAdd")
		else
			arg_12_0.effectController_:SetSelectedState("none")
		end
	end

	arg_12_0.selController_:SetSelectedState(arg_12_0.selected_ and "true" or "false")
	arg_12_0.useController_:SetSelectedState(arg_12_0.used_ and "true" or "false")

	if arg_12_0.locked_ then
		if arg_12_0.mainTag_ and arg_12_0.waitForPlayAnim_ and arg_12_0.activityId_ and not getData("heroEnhanceTalentUnlock" .. arg_12_0.activityId_, tostring(var_12_0)) then
			saveData("heroEnhanceTalentUnlock" .. arg_12_0.activityId_, tostring(var_12_0), true)
			arg_12_0.lockController_:SetSelectedState("true")
			FrameTimer.New(function()
				arg_12_0:PlayAnim(function()
					arg_12_0.lockController_:SetSelectedState("false")

					arg_12_0.waitForPlayAnim_ = false
				end)
			end, 1, 1):Start()
		else
			arg_12_0.lockController_:SetSelectedState(arg_12_0.locked_ and "true" or "false")
		end
	else
		arg_12_0.lockController_:SetSelectedState(arg_12_0.locked_ and "true" or "false")
	end

	if arg_12_0.isResult and not var_12_0 then
		arg_12_0.lockController_:SetSelectedState("true")
	end
end

function var_0_0.SetResult(arg_15_0)
	arg_15_0.isResult = true
end

function var_0_0.SetPlayAnim(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.waitForPlayAnim_ = arg_16_1
	arg_16_0.playAnimCallback_ = arg_16_2
end

function var_0_0.PlayAnim(arg_17_0, arg_17_1)
	arg_17_0.animator_:Play("UI_jiesuo_01", 0, 0)

	if arg_17_0.aniTimer_ then
		arg_17_0.aniTimer_:Stop()

		arg_17_0.aniTimer_ = nil
	end

	arg_17_0.aniTimer_ = Timer.New(function()
		if arg_17_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.6 then
			if arg_17_0.aniTimer_ then
				arg_17_0.aniTimer_:Stop()

				arg_17_0.aniTimer_ = nil
			end

			if arg_17_1 then
				arg_17_1()
			end

			if arg_17_0.playAnimCallback_ then
				arg_17_0.playAnimCallback_()

				arg_17_0.playAnimCallback_ = nil
			end

			manager.ui:UIEventEnabledByUI(true, false)
		end
	end, 0.033, -1)

	manager.ui:UIEventEnabledByUI(false, true)
	arg_17_0.aniTimer_:Start()
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.aniTimer_ then
		arg_19_0.aniTimer_:Stop()

		arg_19_0.aniTimer_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
