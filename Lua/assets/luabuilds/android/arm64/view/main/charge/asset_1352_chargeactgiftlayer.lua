local ChargeActGiftLayer = class("ChargeActGiftLayer", import("view.base.BaseUI"))

function ChargeActGiftLayer:getUIName()
	return "ChargeIActGiftUI"
end

function ChargeActGiftLayer:preload(arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getActivityById(self.contextData.actId)
	local var_2_1 = {}

	if var_2_0 and not var_2_0:isEnd() then
		self.spriteDic = {
			name = {},
			icon = {}
		}

		for iter_2_0, iter_2_1 in ipairs(var_2_0:getConfig("config_data")[1]) do
			table.insert(var_2_1, function(arg_3_0)
				LoadSpriteAtlasAsync("actgiftpackages/skin_card_name_" .. iter_2_1, "", function(arg_4_0)
					self.spriteDic.name[iter_2_1] = arg_4_0

					arg_3_0()

					return
				end)

				return
			end)
			table.insert(var_2_1, function(arg_5_0)
				LoadSpriteAtlasAsync("actgiftpackages/skin_card_" .. iter_2_1, "", function(arg_6_0)
					self.spriteDic.icon[iter_2_1] = arg_6_0

					arg_5_0()

					return
				end)

				return
			end)
		end
	end

	parallelAsync(var_2_1, arg_2_1)

	return
end

function ChargeActGiftLayer:init()
	setText(self.rtTip:Find("Text"), i18n("black5_bundle_desc"))
	setText(self.rtAward:Find("word/Text"), i18n("black5_bundle_tip"))
	setText(self.btnPay:Find("Text"), i18n("black5_bundle_buy_all"))
	setText(self.btnGet:Find("Text"), i18n("black5_bundle_receive"))
	self:BlurPanel(self._tf)

	return
end

function ChargeActGiftLayer:didEnter()
	onButton(self, self.rtBg, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtTip, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("black5_bundle_help")
		})

		return
	end, SFX_PANEL)

	local var_8_0 = getProxy(ActivityProxy):getActivityById(self.contextData.actId)
	local var_8_1 = var_8_0:getConfig("config_data")[1]

	UIItemList.StaticAlign(self.rtContainer, self.rtSkinTpl, #var_8_1, function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_1 = arg_11_1 + 1

		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = var_8_1[arg_11_1]

			setImageSprite(arg_11_2:Find("name"), self.spriteDic.name[var_8_1[arg_11_1]])
			setImageSprite(arg_11_2, self.spriteDic.icon[var_8_1[arg_11_1]])

			local var_11_1 = getProxy(ShipSkinProxy):hasNonLimitSkin(var_8_1[arg_11_1])

			setActive(arg_11_2:Find("btn_skin"), not var_11_1)
			setActive(arg_11_2:Find("got"), var_11_1)

			if var_11_1 then
				setText(arg_11_2:Find("got/Text"), i18n("black5_bundle_purchased"))
			else
				setText(arg_11_2:Find("btn_skin/price/Text"), (Goods.Create({
					id = pg.ship_skin_template[var_8_1[arg_11_1]].shop_id
				}, Goods.TYPE_SKIN):getConfig("resource_num")))
				onButton(self, arg_11_2:Find("btn_skin"), function()
					self:emit(ChargeActGiftMediator.GO_SHOP, var_11_0)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)

	local var_8_2 = Drop.Create(var_8_0:GetConfigClientSetting("drop"))

	updateDrop(self.rtAward:Find("icon/bg/IconTpl"), var_8_2)
	onButton(self, self.rtAward:Find("icon"), function()
		self:emit(BaseUI.ON_DROP, var_8_2)

		return
	end, SFX_PANEL)

	local var_8_3, var_8_4, var_8_5 = GiftActCommodity.CalcPrice(var_8_0)

	setActive(self.rtAward:Find("word"), var_8_3 > 0)
	setActive(self.btnPay, var_8_3 > 0)
	setActive(self.btnGet, var_8_3 == 0)

	if var_8_3 > 0 then
		setActive(self.btnPay:Find("price/old"), var_8_3 < var_8_5)
		setText(self.btnPay:Find("price/old"), string.format("<material=strike>%d</material>", var_8_5))
		setText(self.btnPay:Find("price/price"), var_8_3)
		onButton(self, self.btnPay, function()
			local var_14_0 = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResDiamond,
				count = var_8_3
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
					self:emit(ChargeActGiftMediator.DO_PAY)

					return
				end
			})

			return
		end, SFX_CONFIRM)
	else
		onButton(self, self.btnGet, function()
			self:emit(ChargeActGiftMediator.DO_PAY)

			return
		end, SFX_CONFIRM)
	end

	return
end

function ChargeActGiftLayer:willExit()
	self:UnOverlayPanel(self._tf)

	return
end

return ChargeActGiftLayer
