local var_0_0 = class("ChargeActGiftLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ChargeIActGiftUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getActivityById(arg_2_0.contextData.actId)

	if var_2_0 and not var_2_0:isEnd() then
		arg_2_0.spriteDic = {
			name = {},
			icon = {}
		}

		for iter_2_0, iter_2_1 in ipairs(var_2_0:getConfig("config_data")[1]) do
			table.insert({}, function(arg_3_0)
				LoadSpriteAtlasAsync("actgiftpackages/skin_card_name_" .. iter_2_1, "", function(arg_4_0)
					arg_2_0.spriteDic.name[iter_2_1] = arg_4_0

					arg_3_0()

					return
				end)

				return
			end)
			table.insert({}, function(arg_5_0)
				LoadSpriteAtlasAsync("actgiftpackages/skin_card_" .. iter_2_1, "", function(arg_6_0)
					arg_2_0.spriteDic.icon[iter_2_1] = arg_6_0

					arg_5_0()

					return
				end)

				return
			end)
		end
	end

	parallelAsync({}, arg_2_1)

	return
end

function var_0_0.init(arg_7_0)
	setText(arg_7_0.rtTip:Find("Text"), i18n("black5_bundle_desc"))
	setText(arg_7_0.rtAward:Find("word/Text"), i18n("black5_bundle_tip"))
	setText(arg_7_0.btnPay:Find("Text"), i18n("black5_bundle_buy_all"))
	setText(arg_7_0.btnGet:Find("Text"), i18n("black5_bundle_receive"))
	arg_7_0:BlurPanel(arg_7_0._tf)

	return
end

function var_0_0.didEnter(arg_8_0)
	onButton(arg_8_0, arg_8_0.rtBg, function()
		arg_8_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.rtTip, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("black5_bundle_help")
		})

		return
	end, SFX_PANEL)

	local var_8_0 = getProxy(ActivityProxy):getActivityById(arg_8_0.contextData.actId)

	UIItemList.StaticAlign(arg_8_0.rtContainer, arg_8_0.rtSkinTpl, #var_8_0:getConfig("config_data")[1], function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_1 = arg_11_1 + 1

		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = var_0[arg_11_1]

			setImageSprite(arg_11_2:Find("name"), arg_8_0.spriteDic.name[var_0[arg_11_1]])
			setImageSprite(arg_11_2, arg_8_0.spriteDic.icon[var_0[arg_11_1]])

			local var_11_1 = getProxy(ShipSkinProxy):hasNonLimitSkin(var_0[arg_11_1])

			setActive(arg_11_2:Find("btn_skin"), not var_11_1)
			setActive(arg_11_2:Find("got"), var_11_1)

			if var_11_1 then
				setText(arg_11_2:Find("got/Text"), i18n("black5_bundle_purchased"))
			else
				local var_11_2 = Goods.Create({
					id = pg.ship_skin_template[var_0[arg_11_1]].shop_id
				}, Goods.TYPE_SKIN)

				setText(arg_11_2:Find("btn_skin/price/Text"), (var_11_2:getConfig("resource_num")))
				onButton(arg_8_0, arg_11_2:Find("btn_skin"), function()
					arg_8_0:emit(ChargeActGiftMediator.GO_SHOP, var_11_0)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	updateDrop(arg_8_0.rtAward:Find("icon/bg/IconTpl"), (Drop.Create(var_8_0:GetConfigClientSetting("drop"))))
	onButton(arg_8_0, arg_8_0.rtAward:Find("icon"), function()
		arg_8_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_8_1, var_8_2, var_8_3 = GiftActCommodity.CalcPrice(var_8_0)

	setActive(arg_8_0.rtAward:Find("word"), var_8_1 > 0)
	setActive(arg_8_0.btnPay, var_8_1 > 0)
	setActive(arg_8_0.btnGet, var_8_1 == 0)

	if var_8_1 > 0 then
		setActive(arg_8_0.btnPay:Find("price/old"), var_8_1 < var_8_3)
		setText(arg_8_0.btnPay:Find("price/old"), string.format("<material=strike>%d</material>", var_8_3))
		setText(arg_8_0.btnPay:Find("price/price"), var_8_1)
		onButton(arg_8_0, arg_8_0.btnPay, function()
			local var_14_0 = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResDiamond,
				count = var_8_1
			})

			if var_14_0.count > var_14_0:getOwnedCount() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("temple_consume_not_enough"))

				return
			end

			local var_14_1 = Goods.Create({
				shop_id = var_8_0:GetConfigClientSetting("packageID")
			}, Goods.TYPE_GIFT_PACKAGE_ACT)

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("black5_bundle_popup", var_14_0.count, var_14_1:GetName()),
				onYes = function()
					arg_8_0:emit(ChargeActGiftMediator.DO_PAY)

					return
				end
			})

			return
		end, SFX_CONFIRM)
	else
		onButton(arg_8_0, arg_8_0.btnGet, function()
			arg_8_0:emit(ChargeActGiftMediator.DO_PAY)

			return
		end, SFX_CONFIRM)
	end

	return
end

function var_0_0.willExit(arg_17_0)
	arg_17_0:UnOverlayPanel(arg_17_0._tf)

	return
end

return var_0_0
