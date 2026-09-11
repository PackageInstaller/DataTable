local CoreVerificationChallengeStageAffixItem = class("CoreVerificationChallengeStageAffixItem", ReduxView)

function CoreVerificationChallengeStageAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationChallengeStageAffixItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationChallengeStageAffixItem:InitUI()
	self:BindCfgUI()

	self.selController_ = self.controller:GetController("sel")
	self.lockController_ = self.controller:GetController("lock")
	self.bufftypeController_ = self.controller:GetController("bufftype")
	self.showtoogleController_ = self.controller:GetController("showtoogle")
	self.showTipsController_ = self.controller:GetController("showTips")
	self.categoryController_ = self.affixController_:GetController("category")
end

function CoreVerificationChallengeStageAffixItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.buff_id, true)
		end
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		ShowTips("CORE_VERIFICATION_CL_BUFF_TIPS_2")
	end)
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.selController_:GetSelectedIndex() == 0 then
			if #CoreVerificationChallengeData:GetSelectAffixs() < 6 then
				self.selController_:SetSelectedIndex(1)
				self.showTipsController_:SetSelectedIndex(1)

				if self.clickFunc then
					CoreVerificationChallengeData:SetSelectAffixsAdd(self.buff_id, self.state + 1)
					self.clickFunc(self.buff_id, false)
				end
			else
				ShowTips("CORE_VERIFICATION_CL_BUFF_TIPS_3")
			end
		else
			self.selController_:SetSelectedIndex(0)
			self.showTipsController_:SetSelectedIndex(0)

			if self.clickFunc then
				CoreVerificationChallengeData:SetSelectAffixsRemove(self.buff_id)
				self.clickFunc(self.buff_id, false)
			end
		end
	end)
end

function CoreVerificationChallengeStageAffixItem:RefreshUI(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	SetActive(self.gameObject_, true)

	self.stage_id = arg_8_4
	self.challengeType = arg_8_3

	self.showtoogleController_:SetSelectedIndex(arg_8_3)
	self.bufftypeController_:SetSelectedIndex(arg_8_2)

	self.buff_id = arg_8_1
	self.state = arg_8_2

	self.categoryController_:SetSelectedIndex(arg_8_2)

	self.affixData = ActivityAffixPoolCfg[arg_8_1].affix
	self.name.text = getAffixName(self.affixData)
	self.icon.sprite = getAffixSprite(self.affixData)
	self.lvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), (CoreVerificationChallengeData:GetBuffLevelById(self.buff_id)))

	if CoreVerificationChallengeData:IsSelectAffixById(arg_8_1) then
		self.selController_:SetSelectedIndex(1)
		self.showTipsController_:SetSelectedIndex(1)
	else
		self.selController_:SetSelectedIndex(0)
		self.showTipsController_:SetSelectedIndex(0)
	end
end

function CoreVerificationChallengeStageAffixItem:RefreshLock()
	self.lockController_:SetSelectedIndex(CoreVerificationChallengeData:IsUnLockBuffById(self.buff_id) and 0 or 1)
end

function CoreVerificationChallengeStageAffixItem:RegisterClickListener(arg_10_1)
	self.clickFunc = arg_10_1
end

function CoreVerificationChallengeStageAffixItem:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function CoreVerificationChallengeStageAffixItem:Dispose()
	CoreVerificationChallengeStageAffixItem.super.Dispose(self)
end

return CoreVerificationChallengeStageAffixItem
