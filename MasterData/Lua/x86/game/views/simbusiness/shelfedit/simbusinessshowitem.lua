local SimBusinessShowItem = class("SimBusinessShowItem", ReduxView)

function SimBusinessShowItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SimBusinessShowItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SimBusinessShowItem:InitUI()
	self:BindCfgUI()

	self.selectController = self.controllerExCollection_:GetController("select")
	self.typeController = self.controllerExCollection_:GetController("category")
	self.lockController = self.controllerExCollection_:GetController("UnlockCondition")
end

function SimBusinessShowItem:RefreshView(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	self.type = arg_4_2
	self.itemID = arg_4_1

	self.lockController:SetSelectedState("normal")
	self.typeController:SetSelectedState("0")

	if self.type == SimBusinessConst.ShowItmeType.shelf then
		self:RefreshShelfItem(arg_4_4, arg_4_5)
	elseif self.type == SimBusinessConst.ShowItmeType.good then
		self:RefreshGoodItem(arg_4_4, arg_4_5)
	end

	if arg_4_3 and arg_4_3 == self.itemID then
		self.selectController:SetSelectedState("true")
	else
		self.selectController:SetSelectedState("false")
	end
end

function SimBusinessShowItem:AddUIListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.itemID)
		end

		if self.type == SimBusinessConst.ShowItmeType.shelf then
			SimBusinessTools.SetShowShelfRedPoint(self.itemID, false)
			SimBusinessTools.MarkShelfRedPointNeverShowAgain(self.itemID)
			manager.redPoint:SetRedPointIndependent(self.transform_, false)
		elseif self.type == SimBusinessConst.ShowItmeType.good then
			SimBusinessTools.SetShowGoodsRedPoint(self.itemID, false)
			SimBusinessTools.MarkGoodsRedPointNeverShowAgain(self.itemID)
			manager.redPoint:SetRedPointIndependent(self.transform_, false)
		end
	end)
end

function SimBusinessShowItem:RegisterClickItemFunc(arg_7_1)
	self.clickFunc = arg_7_1
end

function SimBusinessShowItem:RefreshShelfItem(arg_8_1, arg_8_2)
	self.iconImage_.sprite = SimBusinessTools.GetShelfIcon(self.itemID)

	if arg_8_1 then
		if manager.redPoint:getTipBoolean((string.format("%s_%s", RedPointConst.ACTIVITY_SIM_BUSINESS_SHELF_LEVEL_UP, tostring(self.itemID)))) then
			manager.redPoint:SetRedPointIndependent(self.transform_, true)
		else
			manager.redPoint:SetRedPointIndependent(self.transform_, false)
		end

		if arg_8_2 then
			local var_8_0, var_8_1 = SimBusinessTools.GetShelfUnlocked(self.itemID)

			if not var_8_0 then
				self.lockController:SetSelectedState("lock")

				if var_8_1 then
					self.lockDesc.text = GetTipsF("SIM_BUSINESS_GOODS_UNLOCK_LEVEL_LIMIT", var_8_1)
				end
			end
		end
	end
end

function SimBusinessShowItem:RefreshGoodItem(arg_9_1, arg_9_2)
	self.iconImage_.sprite = SimBusinessTools.GetGoodsIcon(self.itemID)

	self.typeController:SetSelectedState(tostring(nullable(SimBusinessGoodsCfg, self.itemID, "type") or 0))

	if arg_9_1 then
		local var_9_0 = string.format("%s_%s", RedPointConst.ACTIVITY_SIM_BUSINESS_UNLOCK_GOOD, tostring(self.itemID))

		if manager.redPoint:getTipBoolean(var_9_0) then
			manager.redPoint:SetRedPointIndependent(self.transform_, true)
			manager.redPoint:setTip(var_9_0, 1)
		else
			manager.redPoint:SetRedPointIndependent(self.transform_, false)
			manager.redPoint:setTip(var_9_0, 0)
		end
	end

	if arg_9_2 then
		local var_9_1, var_9_2, var_9_3 = SimBusinessTools.GetGoodLockState(self.itemID)

		if var_9_1 then
			if var_9_2 == SimBusinessTools.State.LOCK_BY_LEVEL then
				self.lockDesc.text = var_9_3 ~= nil and GetTipsF("SIM_BUSINESS_GOODS_UNLOCK_LEVEL_LIMIT", var_9_3) or GetTips("SIM_BUSINESS_GOODS_CAN_NOT_UNLOCK")

				self.lockController:SetSelectedState("lock")
			elseif var_9_2 == SimBusinessTools.State.LOCK_BY_COST then
				self.lockController:SetSelectedState("canUnlock")
			end
		end
	end
end

function SimBusinessShowItem:Dispose()
	SimBusinessShowItem.super.Dispose(self)
end

return SimBusinessShowItem
