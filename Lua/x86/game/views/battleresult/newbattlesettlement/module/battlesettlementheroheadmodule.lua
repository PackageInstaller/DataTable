local var_0_0 = class("BattleSettlementHeroHeadModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.BuildContext(arg_2_0)
	arg_2_0.levelUpTween = nil
	arg_2_0.heroData = nil
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:BuildContext()

	if arg_3_0.controller_ then
		arg_3_0.npcController = arg_3_0.controller_:GetController("isNpc")
	end
end

function var_0_0.ShowCaptain(arg_4_0, arg_4_1)
	SetActive(arg_4_0.captainObj_, arg_4_1)
end

function var_0_0.SetHeroData(arg_5_0, arg_5_1)
	arg_5_0.heroData = arg_5_1

	if not arg_5_1 then
		SetActive(arg_5_0.heroNoneObj_, true)
		SetActive(arg_5_0.heroHeadObj_, false)

		return
	else
		SetActive(arg_5_0.heroNoneObj_, false)
		SetActive(arg_5_0.heroHeadObj_, true)
	end

	local var_5_0 = arg_5_1.id
	local var_5_1 = arg_5_1.using_skin
	local var_5_2 = (arg_5_1.star or 0) / 100

	arg_5_0:SetHeroCfgData(var_5_0, var_5_1, var_5_2)

	if arg_5_0.npcController then
		local var_5_3 = HeroCfg[var_5_0]

		if var_5_3 and (var_5_3.role_type == 1 or var_5_3.role_type == 2) then
			arg_5_0.npcController:SetSelectedState("true")
		else
			arg_5_0.npcController:SetSelectedState("false")
		end
	end
end

function var_0_0.SetHeroLevelData(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = math.modf(arg_6_1)

	if LvTools.GetIsMaxLv(var_6_0, "hero") then
		arg_6_0:ShowLevel(var_6_0, 1)
	else
		arg_6_0:ShowLevel(var_6_0, var_6_1)
	end
end

function var_0_0.ShowLevel(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.levelText_.text = tostring(arg_7_1 or 1)
	arg_7_0.expSlider_.value = arg_7_2
end

function var_0_0.PlayLevelUpTween(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	arg_8_0:StopTween()

	arg_8_0.levelUpTween = LeanTween.value(arg_8_0.gameObject_, arg_8_1 + arg_8_3, arg_8_2 + arg_8_4, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
		arg_8_0:SetHeroLevelData(arg_9_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_8_0:StopTween()
	end))
end

function var_0_0.RenderContentView(arg_11_0, arg_11_1)
	return
end

function var_0_0.StopTween(arg_12_0)
	if not isNil(arg_12_0.levelUpTween) then
		arg_12_0.levelUpTween:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_12_0.gameObject_)

		arg_12_0.levelUpTween = nil
	end
end

function var_0_0.SetHeroCfgData(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = HeroCfg[arg_13_1]

	arg_13_0.heroCfg_ = var_13_0
	arg_13_0.campLogo_.sprite = HeroTools.GetHeroRaceIcon(arg_13_1)

	if arg_13_3 == 0 then
		arg_13_0.rareImg_.sprite = HeroTools.GetRareSprite(math.floor(var_13_0.rare or 0))
	else
		arg_13_0.rareImg_.sprite = HeroTools.GetRareSprite(math.floor(arg_13_3))
	end

	local var_13_1 = HeroTools.GetHeroSkillAttributeIcon(arg_13_1)

	if var_13_1 == nil then
		SetActive(arg_13_0.atkTypeGo_, false)
	else
		SetActive(arg_13_0.atkTypeGo_, true)

		arg_13_0.attackType_.sprite = var_13_1
	end

	if arg_13_2 then
		local var_13_2 = SkinCfg[arg_13_2]

		arg_13_0.headIcon_.sprite = HeroTools.GetHeadSprite(var_13_2.picture_id)

		arg_13_0.headIcon_:SetNativeSize()
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:StopTween()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
