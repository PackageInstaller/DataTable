local CoreVerificationChallengeStageAffixItemMode2 = class("CoreVerificationChallengeStageAffixItemMode2", ReduxView)

function CoreVerificationChallengeStageAffixItemMode2:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationChallengeStageAffixItemMode2:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationChallengeStageAffixItemMode2:InitUI()
	self:BindCfgUI()

	self.selController_ = self.controller:GetController("sel")
	self.lockController_ = self.controller:GetController("lock")
	self.bufftypeController_ = self.controller:GetController("bufftype")
	self.showtoogleController_ = self.controller:GetController("showtoogle")
	self.showTipsController_ = self.controller:GetController("showTips")
	self.categoryController_ = self.affixController_:GetController("category")
	self.pointbgController_ = self.controller:GetController("pointbg")
end

function CoreVerificationChallengeStageAffixItemMode2:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.buff_id, true)
		end
	end)
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.selController_:GetSelectedIndex() == 0 then
			self.selController_:SetSelectedIndex(1)

			if self.clickFunc then
				CoreVerificationChallengeMode2Data:SetSelectAffixsAdd(self.buff_id, self.state + 1)
				self.clickFunc(self.buff_id, false)
			end
		else
			self.selController_:SetSelectedIndex(0)

			if self.clickFunc then
				CoreVerificationChallengeMode2Data:SetSelectAffixsRemove(self.buff_id)
				self.clickFunc(self.buff_id, false)
			end
		end
	end)
end

function CoreVerificationChallengeStageAffixItemMode2:RefreshUI(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	SetActive(self.gameObject_, true)

	self.stage_id = arg_7_4
	self.challengeType = arg_7_3

	self.showtoogleController_:SetSelectedIndex(arg_7_3)
	self.bufftypeController_:SetSelectedIndex(arg_7_2)

	self.buff_id = arg_7_1
	self.state = arg_7_2

	self.categoryController_:SetSelectedIndex(arg_7_2)

	self.affixData = ActivityAffixPoolCfg[arg_7_1].affix
	self.name.text = getAffixName(self.affixData)
	self.icon.sprite = getAffixSprite(self.affixData)

	if self.state == 1 then
		self.limitText_.text = ActivityAffixPoolCfg[arg_7_1].point
		self.limitText_2.text = ActivityAffixPoolCfg[arg_7_1].point

		self.pointbgController_:SetSelectedIndex(1)

		self.buffText_.text = "+" .. ActivityAffixPoolCfg[arg_7_1].point * 10 .. "%"
	else
		self.limitText_.text = ActivityAffixPoolCfg[arg_7_1].point
		self.limitText_2.text = ActivityAffixPoolCfg[arg_7_1].point

		self.pointbgController_:SetSelectedIndex(0)
	end

	if CoreVerificationChallengeMode2Data:IsSelectAffixById(arg_7_1) then
		self.selController_:SetSelectedIndex(1)
	else
		self.selController_:SetSelectedIndex(0)
	end
end

function CoreVerificationChallengeStageAffixItemMode2:RefreshLock()
	self.lockController_:SetSelectedIndex(CoreVerificationChallengeMode2Data:IsUnLockBuffById(self.buff_id) and 0 or 1)
end

function CoreVerificationChallengeStageAffixItemMode2:RegisterClickListener(arg_9_1)
	self.clickFunc = arg_9_1
end

function CoreVerificationChallengeStageAffixItemMode2:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function CoreVerificationChallengeStageAffixItemMode2:Dispose()
	CoreVerificationChallengeStageAffixItemMode2.super.Dispose(self)
end

return CoreVerificationChallengeStageAffixItemMode2
