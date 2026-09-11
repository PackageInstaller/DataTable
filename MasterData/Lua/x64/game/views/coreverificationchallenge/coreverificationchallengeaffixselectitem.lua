local CoreVerificationChallengeAffixSelectItem = class("CoreVerificationChallengeAffixSelectItem", ReduxView)

function CoreVerificationChallengeAffixSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationChallengeAffixSelectItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationChallengeAffixSelectItem:InitUI()
	self:BindCfgUI()

	self.categoryController_ = self.affixController_:GetController("category")
end

function CoreVerificationChallengeAffixSelectItem:AddUIListener()
	self:AddBtnListener(self.btn, nil, function()
		return
	end)
end

function CoreVerificationChallengeAffixSelectItem:SetData(arg_6_1, arg_6_2)
	if arg_6_2.type - 1 == 0 then
		self.categoryController_:SetSelectedIndex(0)
	else
		self.categoryController_:SetSelectedIndex(1)
	end

	self.icon.sprite = getAffixSprite(ActivityAffixPoolCfg[arg_6_2.buff_id].affix)
end

function CoreVerificationChallengeAffixSelectItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function CoreVerificationChallengeAffixSelectItem:Dispose()
	CoreVerificationChallengeAffixSelectItem.super.Dispose(self)
end

return CoreVerificationChallengeAffixSelectItem
