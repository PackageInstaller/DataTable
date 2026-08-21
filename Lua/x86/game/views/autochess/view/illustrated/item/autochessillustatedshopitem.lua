local var_0_0 = class("AutoChessIllustatedShopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.scrollView_ = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.PointerClick)))
	arg_3_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.OnBeginDrag)))
	arg_3_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.OnEndDrag)))
	arg_3_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.OnDrag)))
end

function var_0_0.OnBeginDrag(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.scrollView_:OnBeginDrag(arg_4_2)
end

function var_0_0.OnEndDrag(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.scrollView_:OnEndDrag(arg_5_2)
end

function var_0_0.OnDrag(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.scrollView_:OnDrag(arg_6_2)
end

function var_0_0.PointerClick(arg_7_0)
	if arg_7_0:CheckIsLock() then
		if AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN then
			ShowTips("AUTO_CHESS_INDEX_LOCKED")

			return
		end

		if AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 or AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_5_0 then
			ShowTips("AUTO_CHESS_2_INDEX_UNLOCK_TIP")

			return
		end
	end

	manager.notify:Invoke(AUTO_CHESS_ILLUSTATED_CLICK, arg_7_0.id, arg_7_0.chessType)
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(arg_8_0, arg_8_0.originalGo_)

	arg_8_0.qualityController = arg_8_0.shopControllerEx_:GetController("QualityBg")
	arg_8_0.selectController = arg_8_0.shopControllerEx_:GetController("illustratedSelect")
	arg_8_0.illustratedBgController = arg_8_0.shopControllerEx_:GetController("illustratedBg")
	arg_8_0.lockController = arg_8_0.shopControllerEx_:GetController("lock")
	arg_8_0.moneyController_ = arg_8_0.shopControllerEx_:GetController("money")
	arg_8_0.bottomController = arg_8_0.controllerEx_:GetController("Bottom")

	arg_8_0.illustratedBgController:SetSelectedState("state1")
	arg_8_0:UpdateSelectState(false)
end

function var_0_0.RefreshUI(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.chessType = arg_9_2
	arg_9_0.id = arg_9_1.id
	arg_9_0.isLock = arg_9_1.isLock

	if arg_9_0.chessType == AutoChessConst.ILLUSTRATE_TYPE.CHESS_SHOP then
		arg_9_0:RefreshChessUI(arg_9_0.id)
	elseif arg_9_0.chessType == AutoChessConst.ILLUSTRATE_TYPE.PROP_SHOP then
		arg_9_0:RefreshPropUI(arg_9_0.id)
	end
end

function var_0_0.CheckIsLock(arg_10_0)
	local var_10_0 = arg_10_0.lockController:GetSelectedState()
	local var_10_1 = false

	if var_10_0 == "on" then
		var_10_1 = true
	elseif var_10_0 == "off" then
		var_10_1 = false
	end

	return var_10_1
end

function var_0_0.RefreshChessUI(arg_11_0)
	arg_11_0.bottomController:SetSelectedState("on")

	local var_11_0 = arg_11_0.id
	local var_11_1 = AutoChessCfg[var_11_0]

	arg_11_0.qualityController:SetSelectedIndex(var_11_1.star - 1)

	arg_11_0.attactkText_.text = var_11_1.body[1] or 0
	arg_11_0.hpText_.text = var_11_1.body[2] or 0
	arg_11_0.iconImage_.sprite = AutoChessTools.GetChessBody(var_11_0)

	if arg_11_0.isLock then
		arg_11_0.lockController:SetSelectedState("on")
		arg_11_0.bottomController:SetSelectedState("off")
	else
		arg_11_0.lockController:SetSelectedState("off")
	end
end

function var_0_0.RefreshPropUI(arg_12_0)
	arg_12_0.bottomController:SetSelectedState("off")

	local var_12_0 = arg_12_0.id
	local var_12_1 = AutoChessItemCfg[var_12_0]

	arg_12_0.qualityController:SetSelectedIndex(var_12_1.star - 1)

	arg_12_0.iconImage_.sprite = AutoChessTools.GetPropIcon(var_12_1.icon)

	if arg_12_0.isLock then
		arg_12_0.lockController:SetSelectedState("on")
	else
		arg_12_0.lockController:SetSelectedState("off")
		arg_12_0.moneyController_:SetSelectedState("on")

		arg_12_0.money_.text = var_12_1.shop_price
	end
end

function var_0_0.UpdateSelectState(arg_13_0, arg_13_1)
	arg_13_0.isSelect = arg_13_1

	if arg_13_1 then
		arg_13_0.selectController:SetSelectedState("state1")
	else
		arg_13_0.selectController:SetSelectedState("state0")
	end
end

function var_0_0.GetSelectState(arg_14_0)
	return arg_14_0.isSelect
end

function var_0_0.IsMeetIDAndType(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == arg_15_0.id and arg_15_2 == arg_15_0.chessType then
		return true
	else
		return false
	end
end

function var_0_0.Show(arg_16_0, arg_16_1)
	SetActive(arg_16_0.gameObject_, arg_16_1)
end

function var_0_0.Dispose(arg_17_0)
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
