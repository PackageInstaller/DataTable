local var_0_0 = class("BattleMultipleResultHeroItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.heroData_ = arg_1_2
	arg_1_0.stageData = arg_1_3
	arg_1_0.isLock_ = arg_1_4
	arg_1_0.heroCollectData = arg_1_5 or {}

	arg_1_0:InitUI()
	arg_1_0:RefreshUI()
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:RemoveTween()
	var_0_0.super.Dispose(arg_2_0)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.icon_.sprite = getSpriteViaConfig("HeroLittleIcon", arg_4_0.heroData_.using_skin)

	if arg_4_0.isLock_ then
		arg_4_0:LockHero()
	else
		arg_4_0:RefreshHero()
	end
end

function var_0_0.LockHero(arg_5_0)
	arg_5_0.addExpText_.text = "+0"
	arg_5_0.lvText_.text = arg_5_0.heroData_.level
	arg_5_0.expProgressBar_.value = 1
end

function var_0_0.RefreshHero(arg_6_0)
	local var_6_0 = arg_6_0.heroData_
	local var_6_1 = arg_6_0.heroCollectData
	local var_6_2 = 1
	local var_6_3 = 1
	local var_6_4 = 0
	local var_6_5 = 0

	if var_6_1 then
		var_6_2 = var_6_1.oldLv
		var_6_3 = var_6_1.newLv
		var_6_4 = var_6_1.oldPersent
		var_6_5 = var_6_1.newPersent
	end

	arg_6_0.addExpText_.text = ""

	arg_6_0:RemoveTween()

	arg_6_0.heroExp_ = var_6_3 + var_6_5
	arg_6_0.tweens_ = LeanTween.value(arg_6_0.expProgressBar_.gameObject, var_6_2 + var_6_4, var_6_3 + var_6_5, 6):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
		arg_6_0:UpdateHeroData(arg_7_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_6_0:RemoveTween()
	end))
end

function var_0_0.RemoveTween(arg_9_0)
	local var_9_0 = arg_9_0.tweens_

	if var_9_0 then
		var_9_0:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(var_9_0.id)
	end
end

function var_0_0.UpdateHeroData(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = math.modf(arg_10_1)

	arg_10_0.lvText_.text = string.format("%d", var_10_0)

	if LvTools.GetIsMaxLv(var_10_0, "hero") then
		arg_10_0.expProgressBar_.value = 1
	else
		arg_10_0.expProgressBar_.value = var_10_1
	end
end

function var_0_0.EndAnimator(arg_11_0)
	arg_11_0:RemoveTween()

	if not arg_11_0.isLock_ then
		arg_11_0:UpdateHeroData(arg_11_0.heroExp_)
	end
end

return var_0_0
