local var_0_0 = class("HolidayVillaShopLayer", import(".SixthAnniversaryIslandShopLayer"))

function var_0_0.getUIName(arg_1_0)
	return "HolidayVillaShopUI"
end

function var_0_0.setPlayer(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	setText(arg_2_0.rtRes:Find("Text"), getProxy(ActivityProxy):getActivityById(ActivityConst.HOLIDAY_ACT_ID):getVitemNumber(66005))

	return
end

function var_0_0.refreshAllGoodsCard(arg_3_0)
	arg_3_0.goodsList = arg_3_0.shop:getSortGoods()

	arg_3_0.goodsItemList:align(#arg_3_0.goodsList)

	return
end

function var_0_0.init(arg_4_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_4_0._tf)

	local var_4_0 = arg_4_0._tf:Find("main")

	setText(var_4_0:Find("time/Text"), i18n("islandshop_tips1"))

	arg_4_0.rtTime = var_4_0:Find("time/Text_2")
	arg_4_0.rtRes = var_4_0:Find("tpl")

	local var_4_1 = arg_4_0._tf:Find("main/view/content")

	arg_4_0.goodsItemList = UIItemList.New(var_4_1, var_4_1:Find("goods"))

	arg_4_0.goodsItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			arg_4_0.goodsCardDic[arg_4_0.goodsList[arg_5_1].id] = arg_5_2

			onButton(arg_4_0, arg_5_2, function()
				arg_4_0:emit(HolidayVillaShopMediator.OPEN_GOODS_WINDOW, arg_4_0.goodsList[arg_5_1])

				return
			end, SFX_PANEL)
			arg_4_0:updateGoodsCard(arg_5_2, arg_4_0.goodsList[arg_5_1])
		end

		return
	end)
	onButton(arg_4_0, arg_4_0._tf:Find("bg"), function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0._tf:Find("main/btn_back"), function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)

	return
end

return var_0_0
