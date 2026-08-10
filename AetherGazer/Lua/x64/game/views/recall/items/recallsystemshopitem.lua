local var_0_0 = import("game.views.shop.base.ShopItemBase")
local var_0_1 = class("RecallSystemShopItem", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.commonItem_ = CommonItemView.New(arg_1_0.itemGo_, true)
	arg_1_0.commonData = clone(ItemTemplateData)
end

function var_0_1.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.buyBtn_, nil, function()
		arg_2_0:ClickFunction()
	end)
	arg_2_0:AddBtnListener(arg_2_0.bgBuyBtn_, nil, function()
		arg_2_0:ClickFunction()
	end)
end

function var_0_1.UpdateView(arg_5_0)
	CommonTools.SetCommonData(arg_5_0.commonItem_, {
		id = arg_5_0.itemCfg.id,
		clickFun = function(arg_6_0)
			ShowPopItem(POP_ITEM, {
				arg_6_0.id,
				arg_6_0.number
			})
		end
	}, arg_5_0.commonData)

	arg_5_0.itemNameTxt_.text = string.format("%s x%d", ItemTools.getItemName(arg_5_0.itemCfg.id), arg_5_0.shopCfg.give)

	arg_5_0:SetPriceText()
	arg_5_0:SetCostIcon()

	if arg_5_0.shopCfg.limit_num == -1 or arg_5_0.shopCfg.limit_num == nil then
		SetActive(arg_5_0.buyLimitGo_, false)
		SetActive(arg_5_0.buyLimitTxt_.gameObject, false)
		SetActive(arg_5_0.maskGo_, false)
	else
		local var_5_0 = arg_5_0.shopCfg.limit_num - arg_5_0.data.buyTime

		if var_5_0 > 0 then
			SetActive(arg_5_0.buyLimitTxt_.gameObject, true)
			SetActive(arg_5_0.buyLimitGo_, true)
			SetActive(arg_5_0.maskGo_, false)

			arg_5_0.buyLimitTxt_.text = string.format("<color=#0d89bf>%d</color>/%d", var_5_0, arg_5_0.shopCfg.limit_num)
		else
			SetActive(arg_5_0.buyLimitTxt_.gameObject, false)
			SetActive(arg_5_0.buyLimitGo_, false)
			SetActive(arg_5_0.maskGo_, true)
		end
	end
end

function var_0_1.Dispose(arg_7_0)
	arg_7_0.commonItem_:Dispose()
	var_0_1.super.Dispose(arg_7_0)
end

return var_0_1
