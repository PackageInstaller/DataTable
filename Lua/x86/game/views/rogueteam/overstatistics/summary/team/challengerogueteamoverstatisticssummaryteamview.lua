local var_0_0 = class("ChallengeRogueTeamOverStatisticsSummaryTeamView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.heroItemList_ = {}

	arg_1_0:RefreshUI()
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.heroItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.heroItemList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = ChallengeRogueTeamData:GetHeroList()
	local var_4_1 = ChallengeRogueTeamData:GetUnlockTrailHeroList()
	local var_4_2, var_4_3, var_4_4, var_4_5 = ChallengeRogueTeamData:GetReserveHeroList()
	local var_4_6 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_2) do
		if iter_4_1 ~= 0 then
			table.insert(var_4_6, {
				heroID = iter_4_1,
				trialID = var_4_5[iter_4_0]
			})
		end
	end

	for iter_4_2, iter_4_3 in pairs(var_4_0) do
		if not arg_4_0:HasInHeroList(iter_4_3.id, 0, var_4_6) then
			table.insert(var_4_6, {
				trialID = 0,
				heroID = iter_4_3.id
			})
		end
	end

	for iter_4_4, iter_4_5 in pairs(var_4_1) do
		local var_4_7 = iter_4_5.tempID
		local var_4_8 = HeroStandardSystemCfg[var_4_7]

		if not arg_4_0:HasInHeroList(var_4_8.hero_id, var_4_7, var_4_6) then
			table.insert(var_4_6, {
				heroID = var_4_8.hero_id,
				trialID = var_4_7
			})
		end
	end

	for iter_4_6, iter_4_7 in ipairs(var_4_6) do
		if arg_4_0.heroItemList_[iter_4_6] == nil then
			arg_4_0.heroItemList_[iter_4_6] = ChallengeRogueTeamOverStatisticsSummaryTeamItem.New(arg_4_0.heroItem_, arg_4_0.parent_)
		end

		arg_4_0.heroItemList_[iter_4_6]:SetData(iter_4_7)
	end

	for iter_4_8 = #var_4_6 + 1, #arg_4_0.heroItemList_ do
		arg_4_0.heroItemList_[iter_4_8]:Show(false)
	end
end

function var_0_0.HasInHeroList(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	for iter_5_0, iter_5_1 in ipairs(arg_5_3) do
		if iter_5_1.heroID == arg_5_1 and iter_5_1.trialID == arg_5_2 then
			return true
		end
	end

	return false
end

function var_0_0.GetHeight(arg_6_0)
	return arg_6_0.rectTransform_.rect.height
end

function var_0_0.Show(arg_7_0, arg_7_1)
	arg_7_0.animator_.enabled = arg_7_1

	if arg_7_1 == false then
		arg_7_0.canvasGroup_.alpha = 0
	end
end

return var_0_0
