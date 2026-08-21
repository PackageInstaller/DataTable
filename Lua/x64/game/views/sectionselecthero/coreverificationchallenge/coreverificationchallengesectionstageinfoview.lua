local var_0_0 = class("CoreVerificationChallengeSelectHeroAdditionalView", SectionStageInfoView)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.recommonHeroItemList_ = {}

	local var_1_0 = arg_1_0.recommonHeroItemContent_.childCount

	for iter_1_0 = 1, var_1_0 do
		local var_1_1 = arg_1_0.recommonHeroItemContent_:GetChild(iter_1_0 - 1)
		local var_1_2 = CoreVerificationChallengeHeroHeadItem.New(var_1_1.gameObject, iter_1_0)

		table.insert(arg_1_0.recommonHeroItemList_, var_1_2)
	end
end

function var_0_0.Refresh(arg_2_0)
	var_0_0.super.Refresh(arg_2_0)

	local var_2_0 = arg_2_0.sectionProxy_.stageID

	arg_2_0.recommonTeam_ = CoreVerificationChallengeTools.GetModeCfg()[var_2_0].recommend_team

	for iter_2_0 = 1, 3 do
		local var_2_1 = arg_2_0[string.format("recommonHeroIcon_%d", iter_2_0)]
		local var_2_2 = arg_2_0.recommonTeam_[iter_2_0]

		if var_2_2 and var_2_2 ~= 0 then
			arg_2_0.recommonHeroItemList_[iter_2_0]:SetActive(true)
			arg_2_0.recommonHeroItemList_[iter_2_0]:RefreshUI(var_2_2)
		else
			arg_2_0.recommonHeroItemList_[iter_2_0]:SetActive(false)
		end
	end
end

function var_0_0.Dispose(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.recommonHeroItemList_) do
		iter_3_1:Dispose()
	end

	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
