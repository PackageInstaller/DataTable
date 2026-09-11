local AstrolabeUnlockView = class("AstrolabeUnlockView", ReduxView)

function AstrolabeUnlockView:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function AstrolabeUnlockView:Init()
	self:InitUI()
end

function AstrolabeUnlockView:InitUI()
	self:BindCfgUI()

	self.conditionController1_ = self.condition1Controllerexcollection_:GetController("clear")
	self.conditionController2_ = self.condition2Controllerexcollection_:GetController("clear")
end

function AstrolabeUnlockView:AddUIListener()
	self:AddBtnListenerScale(self.unlockBtn_, nil, function()
		if not self.isCanUp_ then
			ShowTips("ERROR_ASTROLABE_UNLOCK_CONDITION_NOT_MATCH")

			return
		end

		if not checkGold(self.cost_) then
			return
		end

		AstrolabeAction.AstrolabeUnlock(self.info_.heroId, self.info_.id)
	end)
end

function AstrolabeUnlockView:RefreshUI(arg_6_1)
	if arg_6_1 then
		self.info_ = arg_6_1

		self:RefreshLimit()
		self:RefreshCost()
	end
end

function AstrolabeUnlockView:RefreshLimit()
	local var_7_0 = HeroAstrolabeCfg[self.info_.id]

	self.isAchieve_, self.current_, self.all_ = IsConditionAchieved(HeroAstrolabeCfg[self.info_.id].unlock_condition, {
		heroId = self.info_.heroId
	})
	self.conditiondescire1Text_.text = GetI18NText(ConditionCfg[HeroAstrolabeCfg[self.info_.id].unlock_condition].desc)

	self.conditionController1_:SetSelectedState(self.isAchieve_ and "clear" or "notclear")

	self.isLastEquiped_ = self.heroViewProxy_:GetLastIsEquiped(self.info_.id, self.info_.heroId)

	if HeroTools.IsSpHero(self.info_.heroId) then
		self.num1Text_.text = self.current_ >= self.all_ and "1/1" or "0/1"

		SetActive(self.condition2Go_, false)

		if HeroAstrolabeCfg[var_7_0.pre_astrolabe_id] then
			SetActive(self.condition2Go_, not self.isLastEquiped_)

			self.conditiondescire2Text_.text = HeroAstrolabeCfg[var_7_0.pre_astrolabe_id].astrolabe_type == 2 and string.format(GetTips("SP_SURPASS_LOCK_DES_2"), HeroAstrolabeCfg[var_7_0.pre_astrolabe_id].name) or string.format(GetTips("SP_SURPASS_LOCK_DES_1"), HeroAstrolabeCfg[var_7_0.pre_astrolabe_id].name)
		end
	else
		self.isLastEquiped_ = self.heroViewProxy_:GetLastIsUnlock(self.info_.id, self.info_.heroId)
		self.num1Text_.text = string.format("%d/%d", self.current_, self.all_)
		self.conditiondescire2Text_.text = GetTips("NORMAL_ASTROLABE_DES")

		SetActive(self.condition2Go_, var_7_0.pos ~= 1)
	end

	self.conditionController2_:SetSelectedState(self.isLastEquiped_ and "clear" or "notclear")

	self.num2Text_.text = self.isLastEquiped_ and "1/1" or "0/1"
	self.isCanUp_ = self.isAchieve_ and self.isLastEquiped_
	self.tokenImg_.sprite = ItemTools.getItemSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function AstrolabeUnlockView:RefreshCost()
	if self.info_ == nil then
		return
	end

	if HeroAstrolabeCfg[self.info_.id].unlock[1] then
		self.cost_ = HeroAstrolabeCfg[self.info_.id].unlock[1][2] or 0
	end

	self.costtextText_.text = self.cost_
	self.costtextText_.color = self.cost_ > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) and CurrencyConst.LACK_COLOR or CurrencyConst.ENOUGH_COLOR
end

function AstrolabeUnlockView:OnAstrolabeUnlock(arg_9_1, arg_9_2)
	return
end

function AstrolabeUnlockView:OnEnter()
	return
end

function AstrolabeUnlockView:OnExit()
	return
end

function AstrolabeUnlockView:SetProxy(arg_12_1)
	self.heroViewProxy_ = arg_12_1
end

function AstrolabeUnlockView:Dispose()
	AstrolabeUnlockView.super.Dispose(self)
end

return AstrolabeUnlockView
