local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("NewGuildActivitySPTeamInfoView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	var_0_1.super.InitUI(arg_1_0)

	local var_1_0 = Asset.Load("UI/GuildActivitySPUI/items/spenergy")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_0.extensionContainer_)

	arg_1_0.energyItem_ = GuildActivitySPTeamInfoEnergyItemView.New(var_1_1)
end

function var_0_1.HeadRenderer(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.HeadRenderer(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0 = arg_2_0.heroDataList_[arg_2_1].id

	arg_2_2:SetEnergy(true, GuildActivitySPData:GetHeroFatigue(var_2_0))
end

function var_0_1.RefreshInfoBtn(arg_3_0)
	SetActive(arg_3_0.infoBtn_.gameObject, false)
end

function var_0_1.GetHeroList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = HeroData:GetHeroList()

	for iter_4_0, iter_4_1 in ipairs(GuildActivitySPData:GetFightHeroList()) do
		if var_4_1[iter_4_1.id] then
			var_4_0[iter_4_1.id] = var_4_1[iter_4_1.id]
		end
	end

	return (HeroTools.Sort(var_4_0))
end

function var_0_1.UpdateHeroView(arg_5_0)
	var_0_1.super.UpdateHeroView(arg_5_0)
	arg_5_0.energyItem_:SetCurrent(true)

	local var_5_0 = GameSetting.activity_club_sp_hero_fatigue_max.value[1]

	arg_5_0.energyItem_:SetData(var_5_0, GuildActivitySPData:GetHeroFatigue(arg_5_0.selectHeroData_.id))
end

function var_0_1.Dispose(arg_6_0)
	if arg_6_0.energyItem_ then
		arg_6_0.energyItem_:Dispose()

		arg_6_0.energyItem_ = nil
	end

	var_0_1.super.Dispose(arg_6_0)
end

return var_0_1
