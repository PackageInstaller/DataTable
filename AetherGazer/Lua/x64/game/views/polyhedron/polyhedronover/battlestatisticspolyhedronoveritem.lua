local var_0_0 = import("game.views.battleResult.statistics.BattleStatisticsHeroItem")
local var_0_1 = class("BattleStatisticsPolyhedronOverItem", var_0_0)

function var_0_1.RefreshUI(arg_1_0)
	if arg_1_0.heroData_ then
		arg_1_0.haveHeroController_:SetSelectedState("true")

		local var_1_0 = arg_1_0.heroData_
		local var_1_1 = HeroCfg[arg_1_0.heroData_.id]
		local var_1_2 = arg_1_0.data_
		local var_1_3 = arg_1_0.maxData_
		local var_1_4 = arg_1_0.totalData_
		local var_1_5 = SkinCfg[var_1_0.skin_id]

		arg_1_0.battleCountIcon_.sprite = getSpriteViaConfig("HeroIcon", var_1_5.picture_id)

		SetActive(arg_1_0.battleCountIcon_.gameObject, true)

		arg_1_0.battleCountLv_.text = var_1_0.level
		arg_1_0.battleCountDamageNum_.text = var_1_2.damage
		arg_1_0.battleCountHurtNum_.text = var_1_2.hurt
		arg_1_0.battleCountCureNum_.text = var_1_2.cure
		arg_1_0.battleCountDamageImg_.enabled = var_1_3.damage == var_1_2.damage and var_1_3.damage > 0
		arg_1_0.battleCountHurtNumImg_.enabled = var_1_3.hurt == var_1_2.hurt and var_1_3.hurt > 0
		arg_1_0.battleCountCureNumImg_.enabled = var_1_3.cure == var_1_2.cure and var_1_3.cure > 0

		if var_1_2.damage == 0 then
			arg_1_0.controllers_[1]:SetSelectedState("true")

			arg_1_0.battleCountDamageNum_.text = "--"
		else
			arg_1_0.controllers_[1]:SetSelectedState("false")
		end

		if var_1_2.hurt == 0 then
			arg_1_0.controllers_[2]:SetSelectedState("true")

			arg_1_0.battleCountHurtNum_.text = "--"
		else
			arg_1_0.controllers_[2]:SetSelectedState("false")
		end

		if var_1_2.cure == 0 then
			arg_1_0.controllers_[3]:SetSelectedState("true")

			arg_1_0.battleCountCureNum_.text = "--"
		else
			arg_1_0.controllers_[3]:SetSelectedState("false")
		end
	else
		arg_1_0.haveHeroController_:SetSelectedState("false")
	end
end

return var_0_1
