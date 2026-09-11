local CoreVerificationChallengeHeroHeadItem = class("CoreVerificationChallengeHeroHeadItem", ReduxView)

function CoreVerificationChallengeHeroHeadItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = arg_1_2

	self:Init()
end

function CoreVerificationChallengeHeroHeadItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationChallengeHeroHeadItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controller_:GetController("state01")
end

function CoreVerificationChallengeHeroHeadItem:AddUIListener()
	return
end

function CoreVerificationChallengeHeroHeadItem:RefreshUI(arg_5_1)
	if arg_5_1 > 0 then
		self.stateController_:SetSelectedIndex(0)

		self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Itemshead/" .. arg_5_1)
	else
		self.stateController_:SetSelectedIndex(1)
	end
end

function CoreVerificationChallengeHeroHeadItem:SetActive(arg_6_1)
	self.gameObject_:SetActive(arg_6_1)
end

return CoreVerificationChallengeHeroHeadItem
