local CoreVerificationChallengeRankAffixItem = class("CoreVerificationChallengeRankAffixItem", ReduxView)

function CoreVerificationChallengeRankAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationChallengeRankAffixItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationChallengeRankAffixItem:InitUI()
	self:BindCfgUI()

	self.categoryController_ = self.affixController_:GetController("category")
end

function CoreVerificationChallengeRankAffixItem:AddUIListener()
	return
end

function CoreVerificationChallengeRankAffixItem:SetData(arg_5_1)
	local var_5_0 = ActivityAffixPoolCfg[arg_5_1.id].affix

	if arg_5_1.lv == 0 then
		self.categoryController_:SetSelectedIndex(1)

		self.lvText.text = " "
	elseif arg_5_1.lv == -1 then
		self.categoryController_:SetSelectedIndex(0)

		self.lvText.text = " "
	elseif AffixTypeCfg[var_5_0[1]].extra_description == "AFFIX_CORE_BUFF" then
		self.categoryController_:SetSelectedIndex(0)

		self.lvText.text = string.format(GetTips("PINBALL_HERO_LEVEL"), arg_5_1.lv)
	else
		self.categoryController_:SetSelectedIndex(1)

		self.lvText.text = " "
	end

	self.nameText.text = getAffixName(var_5_0)
	self.icon.sprite = getAffixSprite(var_5_0)
end

function CoreVerificationChallengeRankAffixItem:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function CoreVerificationChallengeRankAffixItem:Dispose()
	CoreVerificationChallengeRankAffixItem.super.Dispose(self)
end

return CoreVerificationChallengeRankAffixItem
