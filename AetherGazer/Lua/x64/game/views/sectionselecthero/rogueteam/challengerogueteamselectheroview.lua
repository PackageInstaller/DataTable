local var_0_0 = import("game.views.sectionSelectHero.SelectHeroBaseView")
local var_0_1 = class("ChallengeRogueTeamSelectHeroView", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	arg_1_0.teamBuffController_ = arg_1_0.controllerExCollection_:GetController("atriEffect")
end

function var_0_1.Refresh(arg_2_0)
	var_0_1.super.Refresh(arg_2_0)
	arg_2_0:RefreshTeamBuff()
end

function var_0_1.RefreshTeamBuff(arg_3_0)
	arg_3_0.attriList_ = {}

	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.cacheHeroTeam_) do
		if iter_3_1 ~= 0 then
			var_3_0 = var_3_0 + 1
		end
	end

	if var_3_0 == 0 then
		arg_3_0.teamBuffController_:SetSelectedState("off")
	else
		arg_3_0.teamBuffController_:SetSelectedState(var_3_0)
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_0.cacheHeroTeam_) do
		local var_3_1 = HeroCfg[iter_3_3]

		if var_3_1 then
			table.insert(arg_3_0.attriList_, var_3_1.ATK_attribute[1])
		end
	end

	table.sort(arg_3_0.attriList_, function(arg_4_0, arg_4_1)
		return arg_4_0 < arg_4_1
	end)

	for iter_3_4, iter_3_5 in ipairs(arg_3_0.attriList_) do
		arg_3_0["attributeIcon" .. iter_3_4 .. "_"].sprite = HeroTools.GetSkillAttributeIcon(iter_3_5)
	end
end

function var_0_1.AddListener(arg_5_0)
	var_0_1.super.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.attriBtn_, nil, function()
		JumpTools.OpenPageByJump("challengeRogueTeamSectionSelectAttriDescription", {
			heroList = arg_5_0.cacheHeroTeam_
		})
	end)
end

return var_0_1
