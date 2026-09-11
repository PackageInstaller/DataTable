local CoreVerificationChallengeRecommendAttributeItem = class("CoreVerificationChallengeRecommendAttributeItem", ReduxView)

function CoreVerificationChallengeRecommendAttributeItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = arg_1_2

	self:Init()
end

function CoreVerificationChallengeRecommendAttributeItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationChallengeRecommendAttributeItem:InitUI()
	self:BindCfgUI()
end

function CoreVerificationChallengeRecommendAttributeItem:AddUIListener()
	return
end

function CoreVerificationChallengeRecommendAttributeItem:RefreshUI(arg_5_1)
	self.icon_.sprite = HeroTools.GetSkillAttributeIcon(arg_5_1)
end

function CoreVerificationChallengeRecommendAttributeItem:SetActive(arg_6_1)
	self.gameObject_:SetActive(arg_6_1)
end

return CoreVerificationChallengeRecommendAttributeItem
