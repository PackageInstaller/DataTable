local SkinDiscountGiftMainSignItem = class("SkinDiscountGiftMainSignItem", ReduxView)

function SkinDiscountGiftMainSignItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.controllerEx_:GetController("state")
	self.commonItem_ = CommonItemView.New(self.commonItem_)
end

function SkinDiscountGiftMainSignItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil
	self.itemData_ = nil

	SkinDiscountGiftMainSignItem.super.Dispose(self)
end

function SkinDiscountGiftMainSignItem:AddListeners()
	return
end

function SkinDiscountGiftMainSignItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.activityID_ = arg_4_1

	local var_4_0 = SkinDiscountGiftTools.GetSignState(arg_4_1, arg_4_2)

	if var_4_0 == ActivityConst.SIGN_STATE.GETTED then
		self.stateController_:SetSelectedState("state2")
	elseif var_4_0 == ActivityConst.SIGN_STATE.CAN_GET then
		self.stateController_:SetSelectedState("state1")
	else
		self.stateController_:SetSelectedState("state0")
	end

	local var_4_1 = SignCfg[arg_4_3].reward

	if not self.itemData_ then
		self.itemData_ = clone(ItemTemplateData)

		function self.itemData_:clickFun()
			local var_5_0 = SkinDiscountGiftTools.GetSignState(arg_4_1, arg_4_2)

			if var_5_0 == ActivityConst.SIGN_STATE.GETTED then
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			elseif var_5_0 == ActivityConst.SIGN_STATE.CAN_GET then
				if not ActivityData:GetActivityIsOpen(arg_4_1) then
					ShopTips("TIME_OVER")

					return
				end

				SignAction.QuerySevenDaySign(arg_4_1)
			else
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end
	end

	self.itemData_.id = var_4_1[1]
	self.itemData_.number = var_4_1[2]
	self.itemData_.completedFlag = var_4_0 == ActivityConst.SIGN_STATE.GETTED

	self.commonItem_:SetData(self.itemData_)

	self.dayText_.text = string.format(GetI18NText(GetTips("SIGN_DAY")), arg_4_2)
end

return SkinDiscountGiftMainSignItem
