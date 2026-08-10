local var_0_0 = class("AutoChessShopItem", AutoChessItem)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_0.originalGo_)
	arg_1_0:InitController()
	arg_1_0:InitBuffKeywordConfig()
end

function var_0_0.InitController(arg_2_0)
	var_0_0.super.InitController(arg_2_0)

	arg_2_0.lockController_ = arg_2_0.shopControllerEx_:GetController("lock")
	arg_2_0.bgController_ = arg_2_0.shopControllerEx_:GetController("QualityBg")
	arg_2_0.dragController_ = arg_2_0.shopControllerEx_:GetController("Drag")
	arg_2_0.bottomController_ = arg_2_0.controllerEx_:GetController("Bottom")
	arg_2_0.bgController_ = arg_2_0.shopControllerEx_:GetController("QualityBg")
	arg_2_0.lvupController_ = arg_2_0.shopControllerEx_:GetController("lvlup")
	arg_2_0.moneyController_ = arg_2_0.shopControllerEx_:GetController("money")
	arg_2_0.deleteController_ = arg_2_0.shopControllerEx_:GetController("Delete")
	arg_2_0.levelController_ = arg_2_0.shopControllerEx_:GetController("level")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.super.SetData(arg_3_0, arg_3_1)

	if not arg_3_0.chessItemData_ or not arg_3_0.chessItemData_.uniqueId then
		arg_3_0.bgController_:SetSelectedState("off")
		arg_3_0:SetActive(false)
	else
		arg_3_0.atkChangeController_:SetSelectedState("none")
		arg_3_0.hpChangeController_:SetSelectedState("none")
		arg_3_0.levelController_:SetSelectedIndex(arg_3_0.chessItemData_.attributeData.level - 1)
		arg_3_0:SetActive(true)
		arg_3_0:UpdateLevel()
		arg_3_0:UpdateMoney()
		arg_3_0.lockController_:SetSelectedState(arg_3_0.chessItemData_.isLock == 0 and "off" or "on")
		arg_3_0.dragController_:SetSelectedState("off")
	end
end

function var_0_0.UpdateLock(arg_4_0)
	if arg_4_0.chessItemData_ then
		if arg_4_0.chessItemData_.isLock == 0 then
			arg_4_0.lockController_:SetSelectedState("off")
			arg_4_0.unlockAnim_:Play("ComCardItem_unlock", 0, 0)
		else
			arg_4_0.lockController_:SetSelectedState("on")
			arg_4_0.lockAnim_:Play("ComCardItem_lock", 0, 0)
		end
	end
end

function var_0_0.Refresh(arg_5_0)
	if arg_5_0.chessItemData_ and arg_5_0.chessItemData_.isLock == 0 then
		arg_5_0.refreshAnim_:Play("Refresh", 0, 0)
	end
end

function var_0_0.UpdateMoney(arg_6_0)
	if arg_6_0.chessItemData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
		arg_6_0.moneyController_:SetSelectedState("on")

		local var_6_0 = AutoChessTools.GetAttrValue(arg_6_0.gameType_, AutoChessConst.ATTR_KEY.SHOP_FREE_PROP_COUNT) > 0

		arg_6_0.money_.text = var_6_0 and 0 or arg_6_0.chessCfg_.shop_price
	else
		arg_6_0.moneyController_:SetSelectedState("off")
	end
end

function var_0_0.UpdateLevel(arg_7_0)
	arg_7_0.bgController_:SetSelectedIndex(arg_7_0.chessCfg_.star - 1)
end

function var_0_0.UpdateLvUp(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.lvupController_:SetSelectedState("on")
	else
		arg_8_0.lvupController_:SetSelectedState("off")
	end
end

function var_0_0.UpdateAttribute(arg_9_0)
	arg_9_0.bottomController_:SetSelectedState(arg_9_0.chessItemData_.shopType == AutoChessConst.SHOP_TYPE.PROP and "off" or "on")
end

function var_0_0.BeginDrag(arg_10_0, arg_10_1)
	if AutoChessData:GetIsInBuyChess() then
		return
	end

	if not arg_10_0.chessItemData_ or not arg_10_0.chessItemData_.uniqueId then
		return
	end

	if arg_10_0.chessItemData_.shopType ~= AutoChessConst.SHOP_TYPE.REWARD and not AutoChessTools.GetNowMoneyEnough(arg_10_0.gameType_, arg_10_0.chessCfg_.shop_price) then
		ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

		return
	end

	arg_10_0.dragController_:SetSelectedState("on")

	if arg_10_0.beginDragFunc then
		arg_10_0.beginDragFunc(arg_10_0.chessItemData_)
	end
end

function var_0_0.EndDrag(arg_11_0, arg_11_1)
	if not arg_11_0.chessItemData_ or not arg_11_0.chessItemData_.uniqueId then
		return
	end

	arg_11_0.dragController_:SetSelectedState("off")

	if arg_11_0.endDragFunc then
		arg_11_0.endDragFunc()
	end
end

function var_0_0.SetSelect(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0.dragController_:SetSelectedState("on")
	else
		arg_12_0.dragController_:SetSelectedState("off")
	end
end

function var_0_0.SetDeleteState(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2

	if arg_13_0.chessItemData_ and arg_13_0.chessItemData_.index == arg_13_1 then
		var_13_0 = not arg_13_2
	end

	if var_13_0 then
		arg_13_0.deleteController_:SetSelectedState("on")
	else
		arg_13_0.deleteController_:SetSelectedState("off")
	end
end

function var_0_0.UpdateExpChange(arg_14_0)
	arg_14_0.levelController_:SetSelectedIndex(arg_14_0.chessItemData_.attributeData.level - 1)
end

function var_0_0.PlayGetEffectAnim(arg_15_0, arg_15_1)
	local var_15_0 = AutoChessBuffCfg[arg_15_1]

	if var_15_0 then
		if var_15_0.action_type == AutoChessConst.ACTION_EFFECT_TYPE.REFRESH_SHOP then
			arg_15_0.refreshAnim_:Play("Ani_takeseffect", -1, 0)
			arg_15_0.refreshAnim_:Update(0)
		else
			arg_15_0.upLevelAnim_:Play("attackAni_buff", -1, 0)
			arg_15_0.upLevelAnim_:Update(0)
		end
	end
end

function var_0_0.ResetUI(arg_16_0)
	return
end

return var_0_0
