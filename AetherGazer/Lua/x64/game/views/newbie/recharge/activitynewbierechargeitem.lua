local var_0_0 = class("ActivityNewbieRechargeItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.button_.transform, "stage")
	arg_1_0.rechargeUpdateHandler_ = handler(arg_1_0, arg_1_0.RefreshUI)

	manager.notify:RegistListener(NEWBIE_RECHARGE_UPDATE, arg_1_0.rechargeUpdateHandler_)
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	manager.notify:RemoveListener(NEWBIE_RECHARGE_UPDATE, arg_2_0.rechargeUpdateHandler_)

	arg_2_0.rechargeUpdateHandler_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_first_recharge = arg_3_0.index_
		})

		local var_4_0 = ActivityNewbieData:GetRechargeStatus()[arg_3_0.index_] or 0
		local var_4_1 = ActivityNewbieData:GetRechargeTemplate()[arg_3_0.index_]

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
			ActivityNewbieAction.ReceiveRechargeReward(arg_3_0.index_, function(arg_5_0)
				if isSuccess(arg_5_0.result) then
					getReward(var_4_1.reward)
					ActivityNewbieData:SetRechargeStatus(arg_3_0.index_)

					arg_3_0.button_.interactable = false

					arg_3_0.controller_:SetSelectedState(2)
				else
					ShowTips(arg_5_0.result)
				end
			end)
		end
	end)

	if arg_3_0.infoBtn_ then
		arg_3_0:AddBtnListener(arg_3_0.infoBtn_, nil, function()
			local var_6_0 = ActivityNewbieData:GetRechargeTemplate()[arg_3_0.index_]

			ShowPopItem(POP_ITEM, var_6_0.reward[1])
		end)
	end
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = ActivityNewbieData:GetRechargeStatus()[arg_7_0.index_] or 0

	arg_7_0.button_.interactable = var_7_0 ~= 2

	arg_7_0.controller_:SetSelectedState(tostring(var_7_0))
end

return var_0_0
