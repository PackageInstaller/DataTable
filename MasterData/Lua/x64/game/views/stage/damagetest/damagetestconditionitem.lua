local DamageTestConditionItem = class("DamageTestConditionItem", ReduxView)

function DamageTestConditionItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "select")
	self.chooseConditionHandler_ = handler(self, self.ChooseCondition)

	manager.notify:RegistListener(BOSS_CHALLENGE_CHOOSE_CONDITION, self.chooseConditionHandler_)
end

function DamageTestConditionItem:Dispose()
	DamageTestConditionItem.super.Dispose(self)
	manager.notify:RemoveListener(BOSS_CHALLENGE_CHOOSE_CONDITION, self.chooseConditionHandler_)

	self.chooseConditionHandler_ = nil
end

function DamageTestConditionItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		DamageTestData:SetSelectAffix(self.damageTestId_, self.itemType_, self.id_)
		manager.notify:Invoke(BOSS_CHALLENGE_CHOOSE_CONDITION, {
			itemType = self.itemType_,
			id = self.id_
		})
	end)
end

function DamageTestConditionItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.damageTestId_ = arg_5_1
	self.itemType_ = arg_5_2
	self.id_ = arg_5_3

	if self.itemType_ == BossConst.TYPE_STAGE then
		self.descText_.text = BattleInstance.GetStarMissionText(StageChallengeConditionPoolCfg[arg_5_3].condition[1], StageChallengeConditionPoolCfg[arg_5_3].condition[2], StageChallengeConditionPoolCfg[arg_5_3].condition[3])
		self.pointText_.text = StageChallengeConditionPoolCfg[arg_5_3].point
	else
		local var_5_0 = ActivityAffixPoolCfg[arg_5_3]

		self.descText_.text = getAffixDesc(ActivityAffixPoolCfg[arg_5_3].affix)
		self.pointText_.text = var_5_0.point
	end

	self:ChooseCondition({
		itemType = arg_5_2,
		id = arg_5_3
	})
end

function DamageTestConditionItem:ChooseCondition(arg_6_1)
	self:RefreshMutex(arg_6_1)
end

function DamageTestConditionItem:RefreshMutex(arg_7_1)
	if self.itemType_ == arg_7_1.itemType then
		if self.itemType_ == BossConst.TYPE_STAGE then
			self:RefreshMutexStage()
		else
			self:RefreshMutexAffix()
		end
	end
end

function DamageTestConditionItem:RefreshMutexStage()
	for iter_8_0, iter_8_1 in ipairs((DamageTestData:GetAffixList(self.damageTestId_, self.itemType_))) do
		if self.id_ ~= iter_8_1 and StageChallengeConditionPoolCfg[self.id_] and StageChallengeConditionPoolCfg[self.id_].condition[1] == StageChallengeConditionPoolCfg[iter_8_1].condition[1] then
			self.controller_:SetSelectedState("not")

			return
		elseif self.id_ == iter_8_1 then
			self.controller_:SetSelectedState("true")

			return
		end
	end

	self.controller_:SetSelectedState("false")
end

function DamageTestConditionItem:RefreshMutexAffix()
	for iter_9_0, iter_9_1 in ipairs((DamageTestData:GetAffixList(self.damageTestId_, self.itemType_))) do
		if self.id_ ~= iter_9_1 and ActivityAffixPoolCfg[self.id_] and ActivityAffixPoolCfg[self.id_].affix[1] == ActivityAffixPoolCfg[iter_9_1].affix[1] then
			self.controller_:SetSelectedState("not")

			return
		elseif self.id_ == iter_9_1 then
			self.controller_:SetSelectedState("true")

			return
		end
	end

	self.controller_:SetSelectedState("false")
end

return DamageTestConditionItem
