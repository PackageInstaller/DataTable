local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("GuildActivityTeamInfoView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	var_0_1.super.InitUI(arg_1_0)

	local var_1_0 = Asset.Load("UI/GuildActivityUI/items/energy")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_0.extensionContainer_)

	arg_1_0.energyItem_ = GuildActivityTeamInfoEnergyItemView.New(var_1_1)
end

function var_0_1.HeadRenderer(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.HeadRenderer(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0 = arg_2_0.heroDataList_[arg_2_1].id
	local var_2_1 = arg_2_0.heroDataList_[arg_2_1].trialID
	local var_2_2, var_2_3, var_2_4 = arg_2_0:IsInTeam(var_2_0, var_2_1)

	arg_2_2:SetInTeamFlag(var_2_2, var_2_3)
	arg_2_2:SetEnergy(true, GuildActivityData:GetHeroFatigue(var_2_0))
	arg_2_2:SetHeroLock(table.keyof(arg_2_0.lockHeroList_, var_2_0) ~= nil or table.keyof(arg_2_0.lockHeroList_, var_2_1) ~= nil)
end

function var_0_1.RefreshInfoBtn(arg_3_0)
	SetActive(arg_3_0.infoBtn_.gameObject, false)
end

function var_0_1.GetFilterClass(arg_4_0)
	return GuildActivityFilterView
end

function var_0_1.GetHeroList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = HeroData:GetHeroList()

	for iter_5_0, iter_5_1 in ipairs(GuildActivityData:GetFightHeroList()) do
		if var_5_1[iter_5_1.id] then
			var_5_0[iter_5_1.id] = var_5_1[iter_5_1.id]
		end
	end

	return (HeroTools.Sort(var_5_0))
end

function var_0_1.UpdateHeroView(arg_6_0)
	var_0_1.super.UpdateHeroView(arg_6_0)
	arg_6_0.energyItem_:SetCurrent(true)

	local var_6_0 = GameSetting.activity_club_hero_fatigue_max.value[1]

	arg_6_0.energyItem_:SetData(var_6_0, GuildActivityData:GetHeroFatigue(arg_6_0.selectID_))
end

function var_0_1.Dispose(arg_7_0)
	if arg_7_0.energyItem_ then
		arg_7_0.energyItem_:Dispose()

		arg_7_0.energyItem_ = nil
	end

	var_0_1.super.Dispose(arg_7_0)
end

function var_0_1.GetHeroTeam(arg_8_0)
	arg_8_0.heroTeam_, arg_8_0.lockStateList_, arg_8_0.lockHeroList_, arg_8_0.heroTrialList_ = GetLocalHeroTeam(arg_8_0.params_.stageType, arg_8_0.params_.stageID, arg_8_0.params_.activityID)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.heroTeam_) do
		local var_8_0 = false

		for iter_8_2, iter_8_3 in ipairs(GuildActivityData:GetFightHeroList()) do
			if iter_8_3.id == iter_8_1 then
				var_8_0 = true

				break
			end
		end

		if not var_8_0 then
			arg_8_0.heroTeam_[iter_8_0] = 0
		end
	end

	for iter_8_4 = 1, 2 do
		for iter_8_5 = iter_8_4 + 1, 3 do
			if arg_8_0.heroTeam_[iter_8_4] == 0 then
				arg_8_0.heroTeam_[iter_8_4], arg_8_0.heroTeam_[iter_8_5] = arg_8_0.heroTeam_[iter_8_5], arg_8_0.heroTeam_[iter_8_4]
			end
		end
	end
end

return var_0_1
