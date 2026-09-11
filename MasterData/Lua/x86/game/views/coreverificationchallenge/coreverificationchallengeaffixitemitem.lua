local CoreVerificationChallengeAffixItemItem = class("CoreVerificationChallengeAffixItemItem", ReduxView)

function CoreVerificationChallengeAffixItemItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationChallengeAffixItemItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationChallengeAffixItemItem:InitUI()
	self:BindCfgUI()

	self.categoryController_ = self.affixController_:GetController("category")
end

function CoreVerificationChallengeAffixItemItem:AddUIListener()
	self:AddBtnListener(self.btn, nil, function()
		return
	end)
end

function CoreVerificationChallengeAffixItemItem:RefreshUI(arg_6_1)
	self.categoryController_:SetSelectedIndex(arg_6_1.type - 1)

	self.icon.sprite = getAffixSprite(ActivityAffixPoolCfg[arg_6_1.buff_id].affix)
end

function CoreVerificationChallengeAffixItemItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function CoreVerificationChallengeAffixItemItem:Dispose()
	CoreVerificationChallengeAffixItemItem.super.Dispose(self)
end

return CoreVerificationChallengeAffixItemItem
