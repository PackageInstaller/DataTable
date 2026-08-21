local var_0_0 = class("ChargeTecShipGiftSellLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ChargeTecShipGiftSellLayer"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initUIText()

	return
end

function var_0_0.didEnter(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)
	arg_3_0:updateGiftList()

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.showGoodVO = arg_5_0.contextData.showGoodVO
	arg_5_0.chargedList = arg_5_0.contextData.chargedList
	arg_5_0.goodVOList = arg_5_0.showGoodVO:getSameLimitGroupTecGoods()
	arg_5_0.normalGoodVO = nil
	arg_5_0.highGoodVO = nil
	arg_5_0.upGoodVO = nil

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.goodVOList) do
		if iter_5_1:getConfig("limit_arg") == 1 then
			arg_5_0.highGoodVO = iter_5_1
		elseif iter_5_1:getConfig("limit_arg") == 2 then
			arg_5_0.normalGoodVO = iter_5_1
		elseif iter_5_1:getConfig("limit_arg") == 3 then
			arg_5_0.upGoodVO = iter_5_1
		end
	end

	arg_5_0.goodVOShowList = {}

	local var_5_0 = ChargeConst.getBuyCount(arg_5_0.chargedList, arg_5_0.normalGoodVO.id)
	local var_5_1 = ChargeConst.getBuyCount(arg_5_0.chargedList, arg_5_0.highGoodVO.id)
	local var_5_2 = ChargeConst.getBuyCount(arg_5_0.chargedList, arg_5_0.upGoodVO.id)

	if var_5_0 == 0 and var_5_1 == 0 and var_5_2 == 0 then
		table.insert(arg_5_0.goodVOShowList, arg_5_0.normalGoodVO)
		table.insert(arg_5_0.goodVOShowList, arg_5_0.highGoodVO)
	elseif var_5_0 > 0 and var_5_1 == 0 and var_5_2 == 0 then
		table.insert(arg_5_0.goodVOShowList, arg_5_0.normalGoodVO)
		table.insert(arg_5_0.goodVOShowList, arg_5_0.upGoodVO)
	elseif (var_5_0 <= 0 or var_5_2 <= 0) and var_5_1 > 0 then
		-- block empty
	end

	return
end

function var_0_0.initUIText(arg_6_0)
	setText(arg_6_0._tf:Find("Adapt/TipBG/Text"), i18n("tech_package_tip"))

	return
end

function var_0_0.findUI(arg_7_0)
	arg_7_0.bg = arg_7_0._tf:Find("BG")
	arg_7_0.itemTpl = arg_7_0._tf:Find("ItemTpl")
	arg_7_0.giftTpl = arg_7_0._tf:Find("GiftTpl")
	arg_7_0.giftContainer = arg_7_0._tf:Find("List")
	arg_7_0.giftUIItemList = UIItemList.New(arg_7_0.giftContainer, arg_7_0.giftTpl)

	arg_7_0.giftUIItemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			arg_8_1 = arg_8_1 + 1

			arg_7_0:updateGiftTF(arg_8_2, arg_7_0.goodVOShowList[arg_8_1])
		end

		return
	end)

	return
end

function var_0_0.addListener(arg_9_0)
	onButton(arg_9_0, arg_9_0.bg, function()
		arg_9_0:closeView()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateGiftTF(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:Find("BG/Special")
	local var_11_1 = arg_11_1:Find("Buy/Normal")
	local var_11_2 = arg_11_1:Find("Buy/Special")
	local var_11_3 = arg_11_1:Find("Buy/Up")
	local var_11_4 = arg_11_1:Find("Buy/Disable")
	local var_11_5 = arg_11_1:Find("Title")
	local var_11_6 = arg_11_1:Find("GiftImage")
	local var_11_7 = arg_11_1:Find("Desc1")
	local var_11_8 = arg_11_1:Find("Desc2")
	local var_11_9 = arg_11_1:Find("List")
	local var_11_10 = arg_11_2:getConfig("limit_arg") == 1
	local var_11_11 = arg_11_2:getConfig("limit_arg") == 2
	local var_11_12 = arg_11_2:getConfig("limit_arg") == 3
	local var_11_13 = ChargeConst.getBuyCount(arg_11_0.chargedList, arg_11_0.normalGoodVO.id) > 0

	setActive(arg_11_1:Find("BG/Normal"), var_11_11)
	setActive(var_11_0, not var_11_11)
	setActive(var_11_1, var_11_11 and not var_11_13)
	setActive(var_11_2, var_11_10)
	setActive(var_11_3, var_11_12)
	setActive(var_11_4, var_11_11 and var_11_13)

	if var_11_11 and var_11_13 then
		setGray(arg_11_1, true, true)
	end

	local function var_11_14()
		pg.m02:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = arg_11_2.id
		})
		arg_11_0:closeView()

		return
	end

	onButton(arg_11_0, var_11_1, function()
		var_11_14()

		return
	end, SFX_PANEL)
	onButton(arg_11_0, var_11_2, function()
		var_11_14()

		return
	end, SFX_PANEL)
	onButton(arg_11_0, var_11_3, function()
		var_11_14()

		return
	end, SFX_PANEL)
	setText(var_11_5, arg_11_2:getConfig("name_display"))
	setText(var_11_7, arg_11_2:getConfig("descrip"))
	setText(var_11_8, arg_11_2:getConfig("descrip_extra"))
	setImageSprite(var_11_6, LoadSprite("chargeicon/" .. arg_11_2:getConfig("picture")), true)

	local var_11_15 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_2:getConfig("display")) do
		table.insert({}, Drop.Create(iter_11_1))
	end

	local var_11_16 = UIItemList.New(var_11_9, arg_11_0.itemTpl)

	var_11_16:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_0 = arg_16_2:Find("Container"):GetChild(0)

			arg_16_1 = arg_16_1 + 1

			local var_16_1 = var_11_15[arg_16_1]

			updateDrop(var_16_0, var_11_15[arg_16_1])
			onButton(arg_11_0, var_16_0, function()
				arg_11_0:emit(BaseUI.ON_DROP, var_16_1)

				return
			end, SFX_PANEL)
			setScrollText(arg_16_2:Find("TextMask/Text"), var_11_15[arg_16_1]:getName())
		end

		return
	end)
	var_11_16:align(#{})

	return
end

function var_0_0.updateGiftList(arg_18_0)
	arg_18_0.giftUIItemList:align(#arg_18_0.goodVOShowList)

	return
end

return var_0_0
