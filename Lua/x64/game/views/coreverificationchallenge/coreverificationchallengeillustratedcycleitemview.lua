local var_0_0 = class("CoreVerificationChallengeIllustratedCycleItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.items = {}
	arg_2_0.illustratedType = CoreVerificationChallengeTools.GetBadgeCount()
	arg_2_0.stateController_ = arg_2_0.controller_:GetController("default0")

	for iter_2_0 = 1, 4 do
		arg_2_0.items[iter_2_0] = CoreVerificationChallengeIllustratedItem.New(arg_2_0["badgeGo_" .. iter_2_0], iter_2_0)
	end
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.UpdateBar(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Refresh(arg_5_0, arg_5_1)
	arg_5_0:Show(true)

	local var_5_0 = CoreVerificationChallengeTools.GetChallengeStageCfgByIndex(arg_5_1)
	local var_5_1 = var_5_0.get_id_list_by_stage_type[2]
	local var_5_2 = 0
	local var_5_3 = CoreVerificationClBadgeCfg.get_id_list_by_set_id_sort[arg_5_1][1]
	local var_5_4 = CoreVerificationClBadgeCfg[var_5_3].activity_id
	local var_5_5 = ActivityCfg[var_5_4].sub_activity_list[2]

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		if var_5_5 == var_5_0[iter_5_1].activity_id then
			var_5_2 = iter_5_0

			break
		end
	end

	local var_5_6 = var_5_0[var_5_1[var_5_2]]

	arg_5_0.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", var_5_6.stage_img))

	local var_5_7 = CoreVerificationChallengeTools.GetIllustrated()

	for iter_5_2 = 1, 4 do
		for iter_5_3, iter_5_4 in ipairs(var_5_7) do
			local var_5_8 = CoreVerificationClBadgeCfg[iter_5_4.illustrated_id]

			if arg_5_0.illustratedType[arg_5_0.index] == var_5_8.set_id then
				if var_5_8.sort == 0 and iter_5_2 == 4 then
					arg_5_0.items[4]:RefreshUI(iter_5_4, arg_5_0.illustratedType[arg_5_0.index])
				elseif var_5_8.sort == iter_5_2 then
					arg_5_0.items[iter_5_2]:RefreshUI(iter_5_4, arg_5_0.illustratedType[arg_5_0.index])
				else
					arg_5_0.items[iter_5_2]:RefreshUI(nil, arg_5_0.illustratedType[arg_5_0.index])
				end
			else
				arg_5_0.items[iter_5_2]:RefreshUI(nil, arg_5_0.illustratedType[arg_5_0.index])
			end
		end

		if #var_5_7 < 1 then
			arg_5_0.items[iter_5_2]:RefreshUI(nil, arg_5_0.illustratedType[arg_5_0.index])
		end
	end

	if arg_5_0.index % 2 == 0 then
		arg_5_0.stateController_:SetSelectedIndex(1)
	else
		arg_5_0.stateController_:SetSelectedIndex(0)
	end
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0 = 1, 4 do
		arg_7_0.items[iter_7_0]:Dispose()

		arg_7_0.items[iter_7_0] = nil
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
