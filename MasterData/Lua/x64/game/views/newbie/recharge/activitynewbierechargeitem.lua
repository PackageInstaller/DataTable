local ActivityNewbieRechargeItem = class("ActivityNewbieRechargeItem", ReduxView)

function ActivityNewbieRechargeItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.button_.transform, "stage")
	self.rechargeUpdateHandler_ = handler(self, self.RefreshUI)

	manager.notify:RegistListener(NEWBIE_RECHARGE_UPDATE, self.rechargeUpdateHandler_)
end

function ActivityNewbieRechargeItem:Dispose()
	ActivityNewbieRechargeItem.super.Dispose(self)
	manager.notify:RemoveListener(NEWBIE_RECHARGE_UPDATE, self.rechargeUpdateHandler_)

	self.rechargeUpdateHandler_ = nil
end

function ActivityNewbieRechargeItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_first_recharge = self.index_
		})

		local var_4_0 = ActivityNewbieData:GetRechargeStatus()[self.index_] or 0
		local var_4_1 = ActivityNewbieData:GetRechargeTemplate()[self.index_]

		if var_4_0 == 0 then
			if var_4_1.source[1] == ViewConst.SYSTEM_ID.PASSPORT_BUY then
				if TimeMgr.GetInstance():GetServerTime() < PassportData:GetStartTimestamp() then
					ShowTips("SYSTEM_LOCK")

					return
				end

				if TimeMgr.GetInstance():GetServerTime() >= PassportData:GetEndTimestamp() then
					ShowTips("NO_ACTIVE_BATTLEPASS")

					return
				end
			end

			JumpTools.JumpToPage2(var_4_1.source)
		else
			ActivityNewbieAction.ReceiveRechargeReward(self.index_, function(arg_5_0)
				if isSuccess(arg_5_0.result) then
					getReward(var_4_1.reward)
					ActivityNewbieData:SetRechargeStatus(self.index_)

					self.button_.interactable = false

					self.controller_:SetSelectedState(2)
				else
					ShowTips(arg_5_0.result)
				end
			end)
		end
	end)

	if self.infoBtn_ then
		self:AddBtnListener(self.infoBtn_, nil, function()
			ShowPopItem(POP_ITEM, ActivityNewbieData:GetRechargeTemplate()[self.index_].reward[1])
		end)
	end
end

function ActivityNewbieRechargeItem:RefreshUI()
	local var_7_0 = ActivityNewbieData:GetRechargeStatus()[self.index_] or 0

	self.button_.interactable = var_7_0 ~= 2

	self.controller_:SetSelectedState(tostring(var_7_0))
end

return ActivityNewbieRechargeItem
