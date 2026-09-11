local CoreVerificationBossItem = class("CoreVerificationBossItem", ReduxView)

function CoreVerificationBossItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.bossType_ = arg_1_2

	self:Init()
end

function CoreVerificationBossItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationBossItem:InitUI()
	self:BindCfgUI()

	self.heroHeadItem_ = {}

	for iter_3_0 = 1, 6 do
		self.heroHeadItem_[iter_3_0] = CoreVerificationRoleIcon.New(self["hero" .. iter_3_0 .. "Go_"])
	end

	self.passController_ = self.mainControllerEx_:GetController("passState")
end

function CoreVerificationBossItem:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		self:Go("/coreVerificationInfo", {
			bossType = self.bossType_
		})
	end)
end

function CoreVerificationBossItem:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData({
		hero_id = self.lockHero_[arg_6_1],
		skin_id = HeroTools.HeroUsingSkinInfo(self.lockHero_[arg_6_1]).id
	})
end

function CoreVerificationBossItem:RefreshUI()
	self.lockHero_ = CoreVerificationData:GetLockHeroByBossType(self.bossType_)

	local var_7_0, var_7_1, var_7_2 = CoreVerificationData:GetMaxPassByBossType(self.bossType_)

	if var_7_0 then
		self.passController_:SetSelectedState("complete")

		self.timeText_.text = manager.time:DescCdTime2(var_7_2)
	else
		self.passController_:SetSelectedState("empty")
	end

	for iter_7_0 = 1, 6 do
		self.heroHeadItem_[iter_7_0]:SetData(self.lockHero_[iter_7_0])
	end

	self.diffText_.text = var_7_1
	self.bossImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossAttribute.path, CoreVerificationData:GetBossUICfgByBossType(self.bossType_).icon))

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

function CoreVerificationBossItem:Dispose()
	for iter_8_0 = 1, 6 do
		if self.heroHeadItem_[iter_8_0] then
			self.heroHeadItem_[iter_8_0]:Dispose()

			self.heroHeadItem_[iter_8_0] = nil
		end
	end

	CoreVerificationBossItem.super.Dispose(self)
end

return CoreVerificationBossItem
