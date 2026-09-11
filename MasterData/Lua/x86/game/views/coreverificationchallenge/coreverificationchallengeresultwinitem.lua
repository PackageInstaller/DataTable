local CoreVerificationChallengeResultWinItem = class("CoreVerificationChallengeResultWinItem", ReduxView)

function CoreVerificationChallengeResultWinItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationChallengeResultWinItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationChallengeResultWinItem:InitUI()
	self:BindCfgUI()

	self.categoryController_ = self.affixController_:GetController("category")
end

function CoreVerificationChallengeResultWinItem:AddUIListener()
	return
end

function CoreVerificationChallengeResultWinItem:RefreshUI(arg_5_1)
	if arg_5_1.type - 1 == 0 then
		self.categoryController_:SetSelectedIndex(0)

		self.lvText.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), CoreVerificationChallengeData:GetBuffLevelById(arg_5_1.buff_id) or 1)
	else
		self.categoryController_:SetSelectedIndex(1)

		self.lvText.text = " "
	end

	local var_5_0 = ActivityAffixPoolCfg[arg_5_1.buff_id].affix

	self.icon.sprite = getAffixSprite(ActivityAffixPoolCfg[arg_5_1.buff_id].affix)
	self.nameText.text = getAffixName(var_5_0)
end

function CoreVerificationChallengeResultWinItem:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function CoreVerificationChallengeResultWinItem:Dispose()
	CoreVerificationChallengeResultWinItem.super.Dispose(self)
end

return CoreVerificationChallengeResultWinItem
