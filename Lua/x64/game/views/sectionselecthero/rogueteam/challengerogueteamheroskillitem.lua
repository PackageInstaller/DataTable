local var_0_0 = import("game.views.newHero.items.HeroSkillItem")
local var_0_1 = class("ChallengeRogueTeamHeroSkillItem", var_0_0)

function var_0_1.RefreshLv(arg_1_0, arg_1_1)
	arg_1_0.lvText_.text = string.format("%d", arg_1_1.lv + arg_1_1.addSkillLv + arg_1_1.addEquipSkillLv)

	local var_1_0 = arg_1_0.heroViewProxy_:GetHeroData(arg_1_1.heroId)

	if var_1_0.modifySkill and var_1_0.modifySkill[arg_1_0.index_] or var_1_0.tempID then
		arg_1_0.lvBg_.color = Color(0.44, 0.64, 0.87)
		arg_1_0.lvText_.color = Color.white
	else
		arg_1_0.lvBg_.color = Color(1, 1, 1)
		arg_1_0.lvText_.color = Color.black
	end
end

function var_0_1.RefreshData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.data_ = arg_2_1
	arg_2_0.info_ = arg_2_2
	arg_2_0.heroViewProxy_ = arg_2_3
	arg_2_0.index_ = arg_2_4

	arg_2_0:Render()
end

function var_0_1.RefreshUI(arg_3_0, arg_3_1)
	if arg_3_1 then
		local var_3_0 = arg_3_0:GetRealSkillId(arg_3_1)
		local var_3_1 = HeroSkillCfg[var_3_0]

		arg_3_0.skilliconImg_.sprite = getSprite("Atlas/" .. arg_3_1.heroId, var_3_0)

		SetActive(arg_3_0.upGo_, arg_3_1.isCanUp)
		arg_3_0:RefreshLv(arg_3_1)
	end
end

return var_0_1
