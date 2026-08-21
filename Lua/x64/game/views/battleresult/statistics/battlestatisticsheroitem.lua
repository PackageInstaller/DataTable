local var_0_0 = class("BattleStatisticsHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.heroData_ = arg_1_2
	arg_1_0.totalData_ = arg_1_3
	arg_1_0.maxData_ = arg_1_4
	arg_1_0.data_ = arg_1_5

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
	arg_2_0:RefreshUI()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:RemoveListeners()
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.haveHeroController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "haveHero")
	arg_4_0.highGo1_ = arg_4_0:FindGo("line1/high")
	arg_4_0.highGo2_ = arg_4_0:FindGo("line2/high")
	arg_4_0.highGo3_ = arg_4_0:FindGo("line3/high")
	arg_4_0.controllers_ = {
		ControllerUtil.GetController(arg_4_0.highGo1_.transform, "zero"),
		ControllerUtil.GetController(arg_4_0.highGo2_.transform, "zero"),
		ControllerUtil.GetController(arg_4_0.highGo3_.transform, "zero")
	}
end

function var_0_0.AddListeners(arg_5_0)
	return
end

function var_0_0.RemoveListeners(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0)
	if arg_7_0.heroData_ then
		arg_7_0.haveHeroController_:SetSelectedState("true")

		local var_7_0 = arg_7_0.heroData_
		local var_7_1 = HeroCfg[arg_7_0.heroData_.id]
		local var_7_2 = arg_7_0.data_
		local var_7_3 = arg_7_0.maxData_
		local var_7_4 = arg_7_0.totalData_

		arg_7_0.battleCountIcon_.sprite = getSpriteViaConfig("HeroIcon", var_7_0.skin_id)

		SetActive(arg_7_0.battleCountIcon_.gameObject, true)

		arg_7_0.battleCountLv_.text = var_7_0.level
		arg_7_0.battleCountDamageNum_.text = tostring(var_7_2.damage)
		arg_7_0.battleCountHurtNum_.text = tostring(var_7_2.hurt)
		arg_7_0.battleCountCureNum_.text = tostring(var_7_2.cure)
		arg_7_0.battleCountDamageImg_.enabled = int64.equals(var_7_3.damage, var_7_2.damage) and var_7_3.damage > int64.zero
		arg_7_0.battleCountHurtNumImg_.enabled = int64.equals(var_7_3.hurt, var_7_2.hurt) and var_7_3.hurt > int64.zero
		arg_7_0.battleCountCureNumImg_.enabled = int64.equals(var_7_3.cure, var_7_2.cure) and var_7_3.cure > int64.zero

		if var_7_2.damage == 0 then
			arg_7_0.controllers_[1]:SetSelectedState("true")

			arg_7_0.battleCountDamageNum_.text = "--"
		else
			arg_7_0.controllers_[1]:SetSelectedState("false")
		end

		if var_7_2.hurt == 0 then
			arg_7_0.controllers_[2]:SetSelectedState("true")

			arg_7_0.battleCountHurtNum_.text = "--"
		else
			arg_7_0.controllers_[2]:SetSelectedState("false")
		end

		if var_7_2.cure == 0 then
			arg_7_0.controllers_[3]:SetSelectedState("true")

			arg_7_0.battleCountCureNum_.text = "--"
		else
			arg_7_0.controllers_[3]:SetSelectedState("false")
		end
	else
		arg_7_0.haveHeroController_:SetSelectedState("false")
	end
end

return var_0_0
