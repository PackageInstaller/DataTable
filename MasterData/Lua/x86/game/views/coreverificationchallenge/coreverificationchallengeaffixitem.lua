local CoreVerificationChallengeAffixItem = class("CoreVerificationChallengeAffixItem", ReduxView)

function CoreVerificationChallengeAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationChallengeAffixItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationChallengeAffixItem:InitUI()
	self:BindCfgUI()

	self.selController_ = self.controller:GetController("sel")
	self.lockController_ = self.controller:GetController("lock")
	self.categoryController_ = self.affixController_:GetController("category")
end

function CoreVerificationChallengeAffixItem:AddUIListener()
	self:AddBtnListener(self.delBtn_, nil, function()
		return
	end)
end

function CoreVerificationChallengeAffixItem:RefreshUI(arg_6_1, arg_6_2)
	SetActive(self.gameObject_, true)

	self.state = arg_6_2

	self.categoryController_:SetSelectedIndex(arg_6_2)

	self.name.text = getAffixName(ActivityAffixPoolCfg[arg_6_1].affix)
	self.desc.text = getAffixDesc(ActivityAffixPoolCfg[arg_6_1].affix)
	self.icon.sprite = getAffixSprite(ActivityAffixPoolCfg[arg_6_1].affix)

	if arg_6_2 == 0 then
		self.lvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), CoreVerificationChallengeData:GetBuffLevelById(arg_6_1))
	end
end

function CoreVerificationChallengeAffixItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function CoreVerificationChallengeAffixItem:Dispose()
	CoreVerificationChallengeAffixItem.super.Dispose(self)
end

return CoreVerificationChallengeAffixItem
