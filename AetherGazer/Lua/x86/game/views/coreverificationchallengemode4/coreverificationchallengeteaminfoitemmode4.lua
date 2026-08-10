local var_0_0 = class("CoreVerificationChallengeTeamInfoItemMode4", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.challengeHeadItems = {}

	for iter_2_0 = 1, 3 do
		arg_2_0.challengeHeadItems[iter_2_0] = CoreVerificationChallengeHeroHeadItem.New(arg_2_0["heroRightGo_" .. iter_2_0], iter_2_0)
	end
end

function var_0_0.Dispose(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.challengeHeadItems) do
		iter_3_1:Dispose()
	end

	arg_3_0.challengeHeadItems = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.scoreText_.text = arg_4_1.score
	arg_4_0.pushTimeText_.text = manager.time:DescCdTime2(arg_4_1.time, "00:00+")

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.challengeHeadItems) do
		local var_4_0 = nullable(arg_4_1, "heroList", iter_4_0, "hero_id") or 0

		iter_4_1:RefreshUI(var_4_0)
	end
end

return var_0_0
