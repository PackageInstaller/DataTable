local CoreVerificationBossItemNew = class("CoreVerificationBossItemNew", ReduxView)

function CoreVerificationBossItemNew:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.bossType_ = arg_1_2

	self:Init()
end

function CoreVerificationBossItemNew:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationBossItemNew:InitUI()
	self:BindCfgUI()

	self.passController_ = self.mainControllerEx_:GetController("passState")
end

function CoreVerificationBossItemNew:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		self:Go("/coreVerificationInfo", {
			bossType = self.bossType_
		})
	end)
end

function CoreVerificationBossItemNew:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData({
		hero_id = self.lockHero_[arg_6_1],
		skin_id = HeroTools.HeroUsingSkinInfo(self.lockHero_[arg_6_1]).id
	})
end

function CoreVerificationBossItemNew:RefreshUI()
	self.lockHero_ = CoreVerificationData:GetLockHeroByBossType(self.bossType_)

	local var_7_0, var_7_1, var_7_2 = CoreVerificationData:GetMaxPassByBossType(self.bossType_)

	if var_7_0 then
		self.passController_:SetSelectedIndex(0)

		self.timeText_.text = manager.time:DescCdTime2(var_7_2)
	else
		self.passController_:SetSelectedIndex(1)
	end

	self.diffText_.text = GetTips("HARDLEVEL") .. var_7_1
	self.bossImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", CoreVerificationData:GetBossUICfgByBossType(self.bossType_).icon))

	local var_7_3 = CoreVerificationData:GetRecommendByBossType(self.bossType_)

	if var_7_3[1] then
		SetActive(self.recommend1Img_.gameObject, true)

		self.recommend1Img_.sprite = HeroTools.GetSkillAttributeIcon(var_7_3[1])
	else
		SetActive(self.recommend1Img_.gameObject, false)
	end

	if var_7_3[2] then
		SetActive(self.recommend2Img_.gameObject, true)

		self.recommend2Img_.sprite = HeroTools.GetSkillAttributeIcon(var_7_3[2])
	else
		SetActive(self.recommend2Img_.gameObject, false)
	end

	if table.isEmpty(var_7_3) then
		SetActive(self.recommend1Img_.gameObject, true)

		self.recommend1Img_.sprite = HeroTools.GetSkillAttributeIcon()
	end
end

function CoreVerificationBossItemNew:Dispose()
	CoreVerificationBossItemNew.super.Dispose(self)
end

return CoreVerificationBossItemNew
