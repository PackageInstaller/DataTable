local var_0_0 = class("CoreVerificationPreView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_Verification/CoreVerificationPreview"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.backBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnEnter(arg_6_0)
	local var_6_0 = CoreVerificationData:GetPreviewInfo()
	local var_6_1 = CoreVerificationInfoCfg[var_6_0[1][1]]
	local var_6_2 = CoreVerificationInfoCfg[var_6_0[2][1]]
	local var_6_3 = BossChallengeUICfg[var_6_1.stage_id] or BossChallengeUICfg[3090009]
	local var_6_4 = BossChallengeUICfg[var_6_2.stage_id] or BossChallengeUICfg[3090009]

	arg_6_0.mainImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.CollectBoss.path, var_6_3.boss_id_list[1]))
	arg_6_0.mainText_.text = GetI18NText(var_6_3.main_name)
	arg_6_0.subImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.CollectBoss.path, var_6_4.boss_id_list[1]))
	arg_6_0.subText_.text = GetI18NText(var_6_4.main_name)
	arg_6_0.title1Text_.text = GetTips("CORE_VERIFICATION_BOSS_1")
	arg_6_0.title2Text_.text = GetTips("CORE_VERIFICATION_BOSS_2")

	if var_6_1.recommend[1] then
		SetActive(arg_6_0.mainRe1Img_.gameObject, true)

		arg_6_0.mainRe1Img_.sprite = HeroTools.GetSkillAttributeIcon(var_6_1.recommend[1])
	else
		SetActive(arg_6_0.mainRe1Img_.gameObject, false)
	end

	if var_6_1.recommend[2] then
		SetActive(arg_6_0.mainRe2Img_.gameObject, true)

		arg_6_0.mainRe2Img_.sprite = HeroTools.GetSkillAttributeIcon(var_6_1.recommend[2])
	else
		SetActive(arg_6_0.mainRe2Img_.gameObject, false)
	end

	if table.isEmpty(var_6_1.recommend) then
		SetActive(arg_6_0.mainRe1Img_.gameObject, true)

		arg_6_0.mainRe1Img_.sprite = HeroTools.GetSkillAttributeIcon()
	end

	if var_6_2.recommend[1] then
		SetActive(arg_6_0.subRe1Img_.gameObject, true)

		arg_6_0.subRe1Img_.sprite = HeroTools.GetSkillAttributeIcon(var_6_2.recommend[1])
	else
		SetActive(arg_6_0.subRe1Img_.gameObject, false)
	end

	if var_6_2.recommend[2] then
		SetActive(arg_6_0.subRe2Img_.gameObject, true)

		arg_6_0.subRe2Img_.sprite = HeroTools.GetSkillAttributeIcon(var_6_2.recommend[2])
	else
		SetActive(arg_6_0.subRe2Img_.gameObject, false)
	end

	if table.isEmpty(var_6_2.recommend) then
		SetActive(arg_6_0.subRe1Img_.gameObject, true)

		arg_6_0.subRe1Img_.sprite = HeroTools.GetSkillAttributeIcon()
	end
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
