local var_0_0 = class("SimBusinessShowItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController = arg_3_0.controllerExCollection_:GetController("select")
	arg_3_0.typeController = arg_3_0.controllerExCollection_:GetController("category")
	arg_3_0.lockController = arg_3_0.controllerExCollection_:GetController("UnlockCondition")
end

function var_0_0.RefreshView(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_0.type = arg_4_2
	arg_4_0.itemID = arg_4_1

	arg_4_0.lockController:SetSelectedState("normal")
	arg_4_0.typeController:SetSelectedState("0")

	if arg_4_0.type == SimBusinessConst.ShowItmeType.shelf then
		arg_4_0:RefreshShelfItem(arg_4_4, arg_4_5)
	elseif arg_4_0.type == SimBusinessConst.ShowItmeType.good then
		arg_4_0:RefreshGoodItem(arg_4_4, arg_4_5)
	end

	if arg_4_3 and arg_4_3 == arg_4_0.itemID then
		arg_4_0.selectController:SetSelectedState("true")
	else
		arg_4_0.selectController:SetSelectedState("false")
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.clickBtn_, nil, function()
		if arg_5_0.clickFunc then
			arg_5_0.clickFunc(arg_5_0.itemID)
		end

		if arg_5_0.type == SimBusinessConst.ShowItmeType.shelf then
			SimBusinessTools.SetShowShelfRedPoint(arg_5_0.itemID, false)
			SimBusinessTools.MarkShelfRedPointNeverShowAgain(arg_5_0.itemID)
			manager.redPoint:SetRedPointIndependent(arg_5_0.transform_, false)
		elseif arg_5_0.type == SimBusinessConst.ShowItmeType.good then
			SimBusinessTools.SetShowGoodsRedPoint(arg_5_0.itemID, false)
			SimBusinessTools.MarkGoodsRedPointNeverShowAgain(arg_5_0.itemID)
			manager.redPoint:SetRedPointIndependent(arg_5_0.transform_, false)
		end
	end)
end

function var_0_0.RegisterClickItemFunc(arg_7_0, arg_7_1)
	arg_7_0.clickFunc = arg_7_1
end

function var_0_0.RefreshShelfItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.iconImage_.sprite = SimBusinessTools.GetShelfIcon(arg_8_0.itemID)

	if arg_8_1 then
		local var_8_0 = string.format("%s_%s", RedPointConst.ACTIVITY_SIM_BUSINESS_SHELF_LEVEL_UP, tostring(arg_8_0.itemID))

		if manager.redPoint:getTipBoolean(var_8_0) then
			manager.redPoint:SetRedPointIndependent(arg_8_0.transform_, true)
		else
			manager.redPoint:SetRedPointIndependent(arg_8_0.transform_, false)
		end

		if arg_8_2 then
			local var_8_1, var_8_2 = SimBusinessTools.GetShelfUnlocked(arg_8_0.itemID)

			if not var_8_1 then
				arg_8_0.lockController:SetSelectedState("lock")

				if var_8_2 then
					arg_8_0.lockDesc.text = GetTipsF("SIM_BUSINESS_GOODS_UNLOCK_LEVEL_LIMIT", var_8_2)
				end
			end
		end
	end
end

function var_0_0.RefreshGoodItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.iconImage_.sprite = SimBusinessTools.GetGoodsIcon(arg_9_0.itemID)

	arg_9_0.typeController:SetSelectedState(tostring(nullable(SimBusinessGoodsCfg, arg_9_0.itemID, "type") or 0))

	if arg_9_1 then
		local var_9_0 = string.format("%s_%s", RedPointConst.ACTIVITY_SIM_BUSINESS_UNLOCK_GOOD, tostring(arg_9_0.itemID))

		if manager.redPoint:getTipBoolean(var_9_0) then
			manager.redPoint:SetRedPointIndependent(arg_9_0.transform_, true)
			manager.redPoint:setTip(var_9_0, 1)
		else
			manager.redPoint:SetRedPointIndependent(arg_9_0.transform_, false)
			manager.redPoint:setTip(var_9_0, 0)
		end
	end

	if arg_9_2 then
		local var_9_1, var_9_2, var_9_3 = SimBusinessTools.GetGoodLockState(arg_9_0.itemID)

		if var_9_1 then
			if var_9_2 == SimBusinessTools.State.LOCK_BY_LEVEL then
				if var_9_3 ~= nil then
					arg_9_0.lockDesc.text = GetTipsF("SIM_BUSINESS_GOODS_UNLOCK_LEVEL_LIMIT", var_9_3)
				else
					arg_9_0.lockDesc.text = GetTips("SIM_BUSINESS_GOODS_CAN_NOT_UNLOCK")
				end

				arg_9_0.lockController:SetSelectedState("lock")
			elseif var_9_2 == SimBusinessTools.State.LOCK_BY_COST then
				arg_9_0.lockController:SetSelectedState("canUnlock")
			end
		end
	end
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
