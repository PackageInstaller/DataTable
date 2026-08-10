local var_0_0 = class("CoreVerificationChallengeIllustratedItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.sort = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	local var_2_0 = CoreVerificationChallengeTools.GetActivityId()

	for iter_2_0, iter_2_1 in ipairs(CoreVerificationClBadgeCfg.get_id_list_by_activity_id[var_2_0]) do
		if arg_2_0.sort == CoreVerificationClBadgeCfg[iter_2_1].sort then
			arg_2_0.bagdeCfg = CoreVerificationClBadgeCfg[iter_2_1]

			break
		elseif arg_2_0.sort == 4 and CoreVerificationClBadgeCfg[iter_2_1].level == 1 then
			arg_2_0.bagdeCfg = CoreVerificationClBadgeCfg[iter_2_1]

			break
		end
	end
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = arg_3_0.controller_:GetController("lock")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = arg_4_0.bagdeCfg.id
		local var_5_1 = arg_4_0.bagdeCfg.level
		local var_5_2 = "challenge_attribute_achie_touch_" .. var_5_0 .. "_" .. var_5_1

		OperationRecorder.RecordButtonTouch(var_5_2)
		JumpTools.OpenPageByJump("coreVerificationChallengeIllustratedPopView", {
			bagdeCfg = arg_4_0.bagdeCfg,
			cfg = arg_4_0.cfg
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.btn2_, nil, function()
		local var_6_0 = arg_4_0.bagdeCfg.id
		local var_6_1 = arg_4_0.bagdeCfg.level
		local var_6_2 = "challenge_attribute_achie_touch_" .. var_6_0 .. "_" .. var_6_1

		OperationRecorder.RecordButtonTouch(var_6_2)
		JumpTools.OpenPageByJump("coreVerificationChallengeIllustratedPopView", {
			bagdeCfg = arg_4_0.bagdeCfg,
			cfg = arg_4_0.cfg
		})
	end)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		arg_7_0.cfg = arg_7_1
		arg_7_0.bagdeCfg = CoreVerificationClBadgeCfg[arg_7_1.illustrated_id]

		arg_7_0.stateController_:SetSelectedIndex(0)

		arg_7_0.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", arg_7_0.bagdeCfg.id))
	elseif arg_7_0.stateController_:GetSelectedIndex() ~= 0 then
		for iter_7_0, iter_7_1 in ipairs(CoreVerificationClBadgeCfg.all) do
			if arg_7_0.sort == CoreVerificationClBadgeCfg[iter_7_1].sort and arg_7_2 == CoreVerificationClBadgeCfg[iter_7_1].set_id then
				arg_7_0.bagdeCfg = CoreVerificationClBadgeCfg[iter_7_1]

				break
			elseif arg_7_0.sort == 4 and CoreVerificationClBadgeCfg[iter_7_1].level >= 1 and arg_7_2 == CoreVerificationClBadgeCfg[iter_7_1].set_id then
				arg_7_0.bagdeCfg = CoreVerificationClBadgeCfg[iter_7_1]

				break
			end
		end

		arg_7_0.stateController_:SetSelectedIndex(1)
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
