local var_0_0 = class("CoreVerificationChallengeIllustratedPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Core_verification_BadgePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController_ = arg_4_0.controller_:GetController("default0")
	arg_4_0.showLvController_ = arg_4_0.lvController_:GetController("showLv")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("challenge_attribute_achie_hide")
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.lvBtn_1, nil, function()
		if arg_5_0.bagdeCfg.level > 0 then
			arg_5_0.bagdeCfg = CoreVerificationChallengeTools.GetIllustratedInfoByLevel(1, arg_5_0.bagdeCfg.set_id)

			arg_5_0:RefreshView()
			arg_5_0.stateController_:SetSelectedIndex(0)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.lvBtn_2, nil, function()
		if arg_5_0.bagdeCfg.level > 0 then
			arg_5_0.bagdeCfg = CoreVerificationChallengeTools.GetIllustratedInfoByLevel(2, arg_5_0.bagdeCfg.set_id)

			arg_5_0:RefreshView()
			arg_5_0.stateController_:SetSelectedIndex(1)
		end
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.bagdeCfg = arg_9_0.params_.bagdeCfg
	arg_9_0.cfg = arg_9_0.params_.cfg
	arg_9_0.params_.cfg = nil

	if arg_9_0.bagdeCfg.level == 0 then
		arg_9_0.showLvController_:SetSelectedIndex(0)
	elseif arg_9_0.bagdeCfg.level == 1 then
		arg_9_0.showLvController_:SetSelectedIndex(1)
		arg_9_0.stateController_:SetSelectedIndex(0)
	else
		arg_9_0.showLvController_:SetSelectedIndex(1)
		arg_9_0.stateController_:SetSelectedIndex(1)
	end

	arg_9_0:RefreshView()
end

function var_0_0.RefreshView(arg_10_0)
	arg_10_0.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", arg_10_0.bagdeCfg.id))
	arg_10_0.name_.text = arg_10_0.bagdeCfg.name

	local var_10_0 = arg_10_0.bagdeCfg.unlock_condition
	local var_10_1 = ConditionCfg[var_10_0]

	if var_10_1.type == 11304 then
		local var_10_2 = var_10_1.params[1]
		local var_10_3 = CoreVerificationChallengeTools.GetModeCfgBySetId(arg_10_0.bagdeCfg.set_id)[var_10_2]

		arg_10_0.condition_.text = string.format(GetI18NText(var_10_1.desc), GetI18NText(var_10_3.stage_name))
	elseif var_10_1.type == 11305 then
		local var_10_4 = var_10_1.params[1]
		local var_10_5 = CoreVerificationChallengeTools.GetModeCfgBySetId(arg_10_0.bagdeCfg.set_id)[var_10_4]
		local var_10_6 = var_10_1.params[2]

		arg_10_0.condition_.text = string.format(GetI18NText(var_10_1.desc), GetI18NText(var_10_5.stage_name), var_10_6)
	elseif var_10_1.type == 11306 then
		local var_10_7 = var_10_1.params[2]
		local var_10_8 = CoreVerificationChallengeTools.GetModeCfgBySetId(arg_10_0.bagdeCfg.set_id)[var_10_7]
		local var_10_9 = var_10_1.params[1]

		arg_10_0.condition_.text = string.format(GetI18NText(var_10_1.desc), GetI18NText(var_10_8.stage_name))
	elseif var_10_1.type == 11307 then
		local var_10_10 = var_10_1.params[1]
		local var_10_11 = CoreVerificationChallengeTools.GetModeCfgBySetId(arg_10_0.bagdeCfg.set_id)[var_10_10]
		local var_10_12 = var_10_1.params[2]

		arg_10_0.condition_.text = string.format(GetI18NText(var_10_1.desc), GetI18NText(var_10_11.stage_name), var_10_12)
	end

	if CoreVerificationChallengeData:IsUnlockIllustratedById(arg_10_0.bagdeCfg.id) then
		local var_10_13 = CoreVerificationChallengeData:GetIllustratedById(arg_10_0.bagdeCfg.id)

		arg_10_0.time_.text = GetTips("COMPLETE_TIMES") .. manager.time:DescCTime(var_10_13.time, "!%Y.%m.%d")
		arg_10_0.desc_.text = arg_10_0.bagdeCfg.desc
	else
		arg_10_0.time_.text = " "
		arg_10_0.desc_.text = " "
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
