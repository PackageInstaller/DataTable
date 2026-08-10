local var_0_0 = class("WindowMaterialItem", import("game.extend.ReduxView"))

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.materialType_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
	arg_2_0:RefreshText()
	arg_2_0:InitIcon()

	arg_2_0.isCanAdd_ = true
	arg_2_0.isCanClick_ = false

	arg_2_0:AddBtnListener(nil, nil, "OnClick")
	arg_2_0:RegistEventListener(MATERIAL_MODIFY, handler(arg_2_0, arg_2_0.UpdateMaterial))
end

function var_0_0.UpdateMaterial(arg_3_0, arg_3_1)
	if arg_3_1 == arg_3_0.materialType_ then
		arg_3_0:RefreshText()
	end
end

function var_0_0.OnClick(arg_4_0)
	if arg_4_0.isCanAdd_ or arg_4_0.isCanClick_ then
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "_" .. arg_4_0.class.__cname, string.format("%d", arg_4_0.materialType_))
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_4_0.materialType_
		})
	end
end

function var_0_0.CloseOther(arg_5_0)
	local var_5_0 = gameContext:GetAllOpenRoute()
	local var_5_1 = false

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if iter_5_1 == "currencyBuyGold" or iter_5_1 == "diamondExchange" or iter_5_1 == "currencyBuyFatigue" then
			var_5_1 = true
		end
	end

	if var_5_1 then
		JumpTools.Back()
	end
end

function var_0_0.UnBindListener(arg_6_0)
	arg_6_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveListeners()
	arg_7_0:RemoveAllListeners()
	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.transform_ = nil
	arg_7_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.buttonIcon_, nil, function()
		manager.notify:Invoke(WINDOW_BAR_INFO, arg_9_0.materialType_, arg_9_0.gameObject_)
	end)
end

function var_0_0.RemoveListeners(arg_11_0)
	return
end

function var_0_0.SetCanAdd(arg_12_0, arg_12_1)
	if arg_12_0.isCanAdd_ == arg_12_1 then
		return
	end

	arg_12_0.isCanAdd_ = arg_12_1

	SetActive(arg_12_0.add_, arg_12_1)
end

function var_0_0.SetCanClick(arg_13_0, arg_13_1)
	arg_13_0.isCanClick_ = arg_13_1
end

function var_0_0.SetActive(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)

	if arg_14_1 then
		arg_14_0:RegistEventListener(MATERIAL_MODIFY, handler(arg_14_0, arg_14_0.UpdateMaterial))
		arg_14_0:RefreshText()
		arg_14_0.transform_:SetAsLastSibling()
	end
end

function var_0_0.RefreshText(arg_15_0)
	arg_15_0.text_.text = NumberTools.RetractNumberForWindBar(arg_15_0:GetCnt())
end

function var_0_0.InitIcon(arg_16_0)
	arg_16_0.icon_.sprite = ItemTools.getItemLittleSprite(arg_16_0.materialType_)
end

function var_0_0.GetCnt(arg_17_0)
	local var_17_0 = arg_17_0.materialType_

	if var_17_0 == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
		return CommunityData:GetCurrenyA()
	end

	return ItemTools.getItemNum(var_17_0)
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)

	arg_18_0.transform_ = nil
	arg_18_0.gameObject_ = nil
end

return var_0_0
