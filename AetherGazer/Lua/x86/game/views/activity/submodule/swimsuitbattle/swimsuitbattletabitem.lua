local var_0_0 = class("SwimsuitBattleTabItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.activityID_ = 0
	arg_3_0.selectController_ = arg_3_0.mainControllerEx_:GetController("select")
	arg_3_0.lockController_ = arg_3_0.mainControllerEx_:GetController("lock")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.mainBtn_, nil, function()
		if arg_4_0.click_ then
			arg_4_0.click_()
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	arg_6_0.click_ = arg_6_5
	arg_6_0.activityID_ = arg_6_3
	arg_6_0.heroIconImg_.spriteAsync = SpritePathCfg.HeroLittleIcon.path .. arg_6_2
	arg_6_0.type1Img_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_6_1, false)
	arg_6_0.type2Img_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_6_1, true)

	if SkinCfg[arg_6_2] then
		arg_6_0.name1Text_.text = SkinCfg[arg_6_2].name
	else
		arg_6_0.name1Text_.text = ""
	end

	arg_6_0.name2Text_.text = HeroCfg[arg_6_1].suffix

	arg_6_0:RefreshLock()
	arg_6_0.selectController_:SetSelectedState(arg_6_4 and "true" or "false")
	manager.redPoint:bindUIandKey(arg_6_0.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_HERO, arg_6_3))
end

function var_0_0.Select(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "true" or "false")
end

function var_0_0.RefreshLock(arg_8_0)
	local var_8_0 = ActivityData:GetActivityData(arg_8_0.activityID_).startTime
	local var_8_1 = manager.time:GetServerTime()

	if var_8_1 < var_8_0 then
		arg_8_0.lockController_:SetSelectedState("true")

		arg_8_0.lockText_.text = string.format(GetTips("ACTIVITY_HERO_ENHANCE_HERO_UNLOCK_CONDITION"), manager.time:DiffDay(var_8_1, var_8_0))
	else
		arg_8_0.lockController_:SetSelectedState("false")
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	manager.redPoint:unbindUIandKey(arg_9_0.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_HERO, arg_9_0.activityID_))
end

return var_0_0
