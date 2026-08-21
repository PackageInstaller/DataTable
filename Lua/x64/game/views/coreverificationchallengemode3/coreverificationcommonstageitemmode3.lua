local var_0_0 = class("CoreVerificationCommonStageItemMode3", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.cfg = arg_1_2
	arg_1_0.index = arg_1_3
	arg_1_0.stage_id = arg_1_2.stage_id

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.challengeHeadItems = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.challengeHeadItems[iter_3_0] = CoreVerificationChallengeHeroHeadItem.New(arg_3_0["heroItem_" .. iter_3_0], iter_3_0)
	end

	arg_3_0.stateController_ = arg_3_0.controller_:GetController("selection01")
	arg_3_0.titleText_.text = arg_3_0.cfg.stage_name
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = arg_4_0.heroList and arg_4_0.heroList or {}

		JumpTools.OpenPageByJump("/coreVerificationCommonStageViewMode3", {
			cfg = arg_4_0.cfg,
			index = arg_4_0.index,
			heroList = var_5_0
		})
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.heroList = arg_6_1.common_lock_id and arg_6_1.common_lock_id or {}

		if arg_6_1 and arg_6_1.stage_id > 0 and #arg_6_1.common_lock_id > 0 then
			arg_6_0.stateController_:SetSelectedIndex(1)
		else
			arg_6_0.stateController_:SetSelectedIndex(0)
		end

		local var_6_0 = arg_6_1.common_lock_id

		for iter_6_0 = 1, 3 do
			local var_6_1 = var_6_0[iter_6_0] and var_6_0[iter_6_0] or 0

			arg_6_0.challengeHeadItems[iter_6_0]:RefreshUI(var_6_1)
		end

		arg_6_0.scoreText_.text = arg_6_1.reset_normal_value
	else
		arg_6_0.stateController_:SetSelectedIndex(0)

		for iter_6_1 = 1, 3 do
			arg_6_0.challengeHeadItems[iter_6_1]:RefreshUI(0)
		end
	end
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0 = 1, 3 do
		arg_7_0.challengeHeadItems[iter_7_0]:Dispose()

		arg_7_0.challengeHeadItems[iter_7_0] = nil
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
