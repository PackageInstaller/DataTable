local CoreVerificationPreView = class("CoreVerificationPreView", ReduxView)

function CoreVerificationPreView:UIName()
	return "Widget/System/Core_Verification/CoreVerificationPreview"
end

function CoreVerificationPreView:UIParent()
	return manager.ui.uiPop.transform
end

function CoreVerificationPreView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function CoreVerificationPreView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function CoreVerificationPreView:OnEnter()
	local var_6_0 = CoreVerificationData:GetPreviewInfo()
	local var_6_1 = CoreVerificationInfoCfg[var_6_0[1][1]]
	local var_6_2 = CoreVerificationInfoCfg[var_6_0[2][1]]
	local var_6_3 = BossChallengeUICfg[CoreVerificationInfoCfg[var_6_0[1][1]].stage_id] or BossChallengeUICfg[3090009]
	local var_6_4 = BossChallengeUICfg[var_6_2.stage_id] or BossChallengeUICfg[3090009]

	self.mainImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.CollectBoss.path, var_6_3.boss_id_list[1]))
	self.mainText_.text = GetI18NText(var_6_3.main_name)
	self.subImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.CollectBoss.path, var_6_4.boss_id_list[1]))
	self.subText_.text = GetI18NText(var_6_4.main_name)
	self.title1Text_.text = GetTips("CORE_VERIFICATION_BOSS_1")
	self.title2Text_.text = GetTips("CORE_VERIFICATION_BOSS_2")

	if var_6_1.recommend[1] then
		SetActive(self.mainRe1Img_.gameObject, true)

		self.mainRe1Img_.sprite = HeroTools.GetSkillAttributeIcon(var_6_1.recommend[1])
	else
		SetActive(self.mainRe1Img_.gameObject, false)
	end

	if var_6_1.recommend[2] then
		SetActive(self.mainRe2Img_.gameObject, true)

		self.mainRe2Img_.sprite = HeroTools.GetSkillAttributeIcon(var_6_1.recommend[2])
	else
		SetActive(self.mainRe2Img_.gameObject, false)
	end

	if table.isEmpty(var_6_1.recommend) then
		SetActive(self.mainRe1Img_.gameObject, true)

		self.mainRe1Img_.sprite = HeroTools.GetSkillAttributeIcon()
	end

	if var_6_2.recommend[1] then
		SetActive(self.subRe1Img_.gameObject, true)

		self.subRe1Img_.sprite = HeroTools.GetSkillAttributeIcon(var_6_2.recommend[1])
	else
		SetActive(self.subRe1Img_.gameObject, false)
	end

	if var_6_2.recommend[2] then
		SetActive(self.subRe2Img_.gameObject, true)

		self.subRe2Img_.sprite = HeroTools.GetSkillAttributeIcon(var_6_2.recommend[2])
	else
		SetActive(self.subRe2Img_.gameObject, false)
	end

	if table.isEmpty(var_6_2.recommend) then
		SetActive(self.subRe1Img_.gameObject, true)

		self.subRe1Img_.sprite = HeroTools.GetSkillAttributeIcon()
	end
end

function CoreVerificationPreView:OnExit()
	return
end

function CoreVerificationPreView:Dispose()
	CoreVerificationPreView.super.Dispose(self)
end

return CoreVerificationPreView
