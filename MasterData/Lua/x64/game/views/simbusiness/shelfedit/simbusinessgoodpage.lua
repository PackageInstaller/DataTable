local SimBusinessGoodPage = class("SimBusinessGoodPage", ReduxView)

function SimBusinessGoodPage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SimBusinessGoodPage:Init()
	self:InitUI()
	self:AddUIListener()

	self.itemLable = SimBusinessSellGoodSmallItem.New(self.lableGo)
	self.goodItem = SimBusinessShowItem.New(self.showGo)
	self.btnController = self.controller:GetController("state")
end

function SimBusinessGoodPage:InitUI()
	self:BindCfgUI()
end

function SimBusinessGoodPage:RefreshView(arg_4_1)
	self.id = arg_4_1
	self.cfg = SimBusinessGoodsCfg[arg_4_1]

	if self.cfg then
		self.name.text = self.cfg.name

		self.itemLable:RefreshView(self.cfg.type, SimBusinessConst.ShowItmeType.good)

		self.skill.text = self.cfg.sell_ability_addition
		self.skillDesc.text = self.cfg.special_effect_desc

		self.goodItem:RefreshView(arg_4_1, SimBusinessConst.ShowItmeType.good)
		self:RefreshBtnState()

		self.iconImg_.sprite = ItemTools.getItemSprite((SimBusinessData:GetSimBusinessFundItemID()))

		return true
	end
end

function SimBusinessGoodPage:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.id and SimBusinessTools.GetGoodsReadyToUnlock(self.id) then
			SimBusinessAction.UnlockGoods({
				self.id
			})
		end
	end)

	if self.resetBtn_ then
		self:AddBtnListener(self.resetBtn_, nil, function()
			SimBusinessAction.RevokeUnlockGoods({
				self.id
			}, function(arg_8_0, arg_8_1)
				local var_8_0 = SimBusinessGame.GetInstance()
				local var_8_1

				if SimBusinessTools.IsChallengeLevel(var_8_0.stage) then
					var_8_1 = SimBusinessGame.CalcShelfLayout()

					if not arg_8_1.is_unlock then
						SimBusinessTools.ClearLocalShelfGoods(var_8_1, arg_8_1.goods_id_list)
					end
				end

				var_8_0:InitShelfLayout(var_8_0.stage, var_8_1)
			end)
		end)
	end
end

function SimBusinessGoodPage:OnExit()
	return
end

function SimBusinessGoodPage:RefreshBtnState()
	local var_10_0, var_10_1, var_10_2 = SimBusinessTools.GetGoodLockState(self.id)

	if var_10_0 then
		self.cost.text = self.cfg.unlock_cost

		if var_10_1 == SimBusinessTools.State.LOCK_BY_LEVEL then
			self.btnController:SetSelectedState("lock")

			self.lockDesc.text = var_10_2 ~= nil and GetTipsF("SIM_BUSINESS_GOODS_UNLOCK_LEVEL_LIMIT", var_10_2) or GetTips("SIM_BUSINESS_GOODS_CAN_NOT_UNLOCK")
		elseif var_10_1 == SimBusinessTools.State.LOCK_BY_COST then
			if var_10_2 then
				self.btnController:SetSelectedState("deficient")
			else
				self.btnController:SetSelectedState("up")
			end
		end
	else
		self.btnController:SetSelectedState("max")
	end
end

function SimBusinessGoodPage:Dispose()
	self.goodItem:Dispose()
	self.itemLable:Dispose()
	SimBusinessGoodPage.super.Dispose(self)
end

return SimBusinessGoodPage
