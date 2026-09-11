local CoreVerificationCommonStageAffixItem = class("CoreVerificationCommonStageAffixItem", ReduxView)

function CoreVerificationCommonStageAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationCommonStageAffixItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationCommonStageAffixItem:InitUI()
	self:BindCfgUI()

	self.selController_ = self.controller:GetController("sel")
	self.lockController_ = self.controller:GetController("lock")
	self.bufftypeController_ = self.controller:GetController("bufftype")
	self.showtoogleController_ = self.controller:GetController("showtoogle")
	self.showTipsController_ = self.controller:GetController("showTips")
	self.categoryController_ = self.affixController_:GetController("category")
end

function CoreVerificationCommonStageAffixItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.buff_id, true, self.index)
		end
	end)
end

function CoreVerificationCommonStageAffixItem:RefreshUI(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	SetActive(self.gameObject_, true)

	self.index = arg_6_4
	self.challengeType = arg_6_3

	self.showtoogleController_:SetSelectedIndex(0)
	self.bufftypeController_:SetSelectedIndex(arg_6_2)

	self.buff_id = arg_6_1
	self.state = arg_6_2

	self.categoryController_:SetSelectedIndex(arg_6_2)

	self.affixData = ActivityAffixPoolCfg[arg_6_1].affix
	self.name.text = getAffixName(self.affixData)
	self.icon.sprite = getAffixSprite(self.affixData)
	self.lvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), (CoreVerificationChallengeData:GetBuffLevelById(self.buff_id)))
end

function CoreVerificationCommonStageAffixItem:RefreshLock()
	self.lockController_:SetSelectedIndex(0)
end

function CoreVerificationCommonStageAffixItem:RegisterClickListener(arg_8_1)
	self.clickFunc = arg_8_1
end

function CoreVerificationCommonStageAffixItem:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function CoreVerificationCommonStageAffixItem:Dispose()
	CoreVerificationCommonStageAffixItem.super.Dispose(self)
end

return CoreVerificationCommonStageAffixItem
