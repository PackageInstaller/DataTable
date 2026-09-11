NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local NewBattleMultipleResultView = class("NewBattleMultipleResultView", NewBattleSettlementView)

function NewBattleMultipleResultView:OnAddListner()
	self:AddBtnListener(self.nextStageBtn_, nil, function()
		self:OnceMoreFunc()
	end)
	SetActive(self.costImage_.gameObject, false)
end

function NewBattleMultipleResultView:Init()
	self.hasSnapshot_ = GetBattleResultSnapShot()

	self:InitUI()

	self.btnController = self.btnController_:GetController("btn")
	self.multiController = self.multiController_:GetController("double")
	self.adaptComp = self:FindCom("AdaptImage", nil, self.commonMaskBg_.transform)

	self:AddListener()
end

function NewBattleMultipleResultView:ShowCost()
	local var_4_0 = self.stageData:GetCost()
	local var_4_1 = self.stageData:GetMultiple()

	if self.stageType ~= BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE and self.stageType ~= BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
		SetActive(self.costImage_.gameObject, true)

		self.vitalityCostText_.text = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) >= var_4_0 * var_4_1 and string.format("<color=#%s>%s</color>", ColorConst.BLACK_HEX, var_4_0 * var_4_1) or string.format("<color=#%s>%s</color>", ColorConst.RED_HEX, var_4_0 * var_4_1)
	else
		SetActive(self.costImage_.gameObject, false)
	end
end

function NewBattleMultipleResultView:ShowContent()
	self:onRenderMultiResultContent()
end

function NewBattleMultipleResultView:onRenderMultiResultContent()
	self.multiView = self.multiView or BattleSettlementMultiResultModule.New(self.contentContainer_)

	self.multiView:RenderView({
		stageData = self.stageData,
		rewardList = self.params_.rewardList,
		extraReward = self.params_.extraReward,
		rewardTimes = self.params_.multiple
	})
	self.multiController:SetSelectedState("false")

	if self.params_.extraReward then
		for iter_6_0, iter_6_1 in pairs(self.params_.extraReward) do
			if type(iter_6_1) == "table" and #iter_6_1 > 0 then
				local var_6_0, var_6_1, var_6_2 = ActivityMultiRewardData:GetLastBattleMultiData()
				local var_6_3
				local var_6_4
				local var_6_5

				if RegressionDataNew:GetMultipleUseTimes() > 0 and RegressionDataNew:GetLastMultipleUseTimes() > 0 then
					var_6_3, var_6_4, var_6_5 = RegressionDataNew:GetMultipleValue()
				end

				if var_6_3 ~= nil and var_6_4 ~= nil and var_6_5 ~= nil then
					self.multiCountText_.text = string.format(GetTips("NEW_REGRESSION_DOUBLE_REWARD_DESC"), var_6_3, var_6_4)
					self.multiRatioText_.text = var_6_5 / 100
				else
					self.multiCountText_.text = string.format(GetTips("NEW_REGRESSION_DOUBLE_REWARD_DESC"), var_6_0, var_6_1)
					self.multiRatioText_.text = var_6_2 / 100
				end

				self.multiController:SetSelectedState("true")

				break
			end
		end
	end

	self:SetBtnOnceMore()
end

function NewBattleMultipleResultView:SetBtnOnceMore()
	if self.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT then
		SetActive(self.nextStageBtn_.gameObject, false)
	else
		SetActive(self.nextStageBtn_.gameObject, self:NeedOnceMore())
	end
end

function NewBattleMultipleResultView:NeedOnceMore()
	if self.params_.notOnceMore then
		return false
	end

	return true
end

function NewBattleMultipleResultView:Dispose()
	self.multiView:Dispose()
	NewBattleMultipleResultView.super.Dispose(self)
end

return NewBattleMultipleResultView
