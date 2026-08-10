local var_0_0 = class("AstrolabeUnlockView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.conditionController1_ = arg_3_0.condition1Controllerexcollection_:GetController("clear")
	arg_3_0.conditionController2_ = arg_3_0.condition2Controllerexcollection_:GetController("clear")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListenerScale(arg_4_0.unlockBtn_, nil, function()
		local var_5_0 = HeroAstrolabeCfg[arg_4_0.info_.id]

		if not arg_4_0.isCanUp_ then
			ShowTips("ERROR_ASTROLABE_UNLOCK_CONDITION_NOT_MATCH")

			return
		end

		if not checkGold(arg_4_0.cost_) then
			return
		end

		AstrolabeAction.AstrolabeUnlock(arg_4_0.info_.heroId, arg_4_0.info_.id)
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.info_ = arg_6_1

		arg_6_0:RefreshLimit()
		arg_6_0:RefreshCost()
	end
end

function var_0_0.RefreshLimit(arg_7_0)
	local var_7_0 = HeroAstrolabeCfg[arg_7_0.info_.id]
	local var_7_1 = ConditionCfg[var_7_0.unlock_condition]

	arg_7_0.isAchieve_, arg_7_0.current_, arg_7_0.all_ = IsConditionAchieved(var_7_0.unlock_condition, {
		heroId = arg_7_0.info_.heroId
	})
	arg_7_0.conditiondescire1Text_.text = GetI18NText(var_7_1.desc)

	arg_7_0.conditionController1_:SetSelectedState(arg_7_0.isAchieve_ and "clear" or "notclear")

	arg_7_0.isLastEquiped_ = arg_7_0.heroViewProxy_:GetLastIsEquiped(arg_7_0.info_.id, arg_7_0.info_.heroId)

	if HeroTools.IsSpHero(arg_7_0.info_.heroId) then
		arg_7_0.num1Text_.text = arg_7_0.current_ >= arg_7_0.all_ and "1/1" or "0/1"

		local var_7_2 = var_7_0.pre_astrolabe_id

		SetActive(arg_7_0.condition2Go_, false)

		if HeroAstrolabeCfg[var_7_2] then
			SetActive(arg_7_0.condition2Go_, not arg_7_0.isLastEquiped_)

			if HeroAstrolabeCfg[var_7_2].astrolabe_type == 2 then
				arg_7_0.conditiondescire2Text_.text = string.format(GetTips("SP_SURPASS_LOCK_DES_2"), HeroAstrolabeCfg[var_7_2].name)
			else
				arg_7_0.conditiondescire2Text_.text = string.format(GetTips("SP_SURPASS_LOCK_DES_1"), HeroAstrolabeCfg[var_7_2].name)
			end
		end
	else
		arg_7_0.isLastEquiped_ = arg_7_0.heroViewProxy_:GetLastIsUnlock(arg_7_0.info_.id, arg_7_0.info_.heroId)
		arg_7_0.num1Text_.text = string.format("%d/%d", arg_7_0.current_, arg_7_0.all_)
		arg_7_0.conditiondescire2Text_.text = GetTips("NORMAL_ASTROLABE_DES")

		SetActive(arg_7_0.condition2Go_, var_7_0.pos ~= 1)
	end

	arg_7_0.conditionController2_:SetSelectedState(arg_7_0.isLastEquiped_ and "clear" or "notclear")

	arg_7_0.num2Text_.text = arg_7_0.isLastEquiped_ and "1/1" or "0/1"
	arg_7_0.isCanUp_ = arg_7_0.isAchieve_ and arg_7_0.isLastEquiped_
	arg_7_0.tokenImg_.sprite = ItemTools.getItemSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function var_0_0.RefreshCost(arg_8_0)
	if arg_8_0.info_ == nil then
		return
	end

	local var_8_0 = HeroAstrolabeCfg[arg_8_0.info_.id]

	arg_8_0.cost_ = var_8_0.unlock[1] and var_8_0.unlock[1][2] or 0
	arg_8_0.costtextText_.text = arg_8_0.cost_

	if arg_8_0.cost_ > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) then
		arg_8_0.costtextText_.color = CurrencyConst.LACK_COLOR
	else
		arg_8_0.costtextText_.color = CurrencyConst.ENOUGH_COLOR
	end
end

function var_0_0.OnAstrolabeUnlock(arg_9_0, arg_9_1, arg_9_2)
	return
end

function var_0_0.OnEnter(arg_10_0)
	return
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.SetProxy(arg_12_0, arg_12_1)
	arg_12_0.heroViewProxy_ = arg_12_1
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
