local ChargeTecShipGiftSellLayer = class("ChargeTecShipGiftSellLayer", import("...base.BaseUI"))

function ChargeTecShipGiftSellLayer:getUIName()
	return "ChargeTecShipGiftSellLayer"
end

function ChargeTecShipGiftSellLayer:init()
	self:initData()
	self:findUI()
	self:addListener()
	self:initUIText()

	return
end

function ChargeTecShipGiftSellLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:updateGiftList()

	return
end

function ChargeTecShipGiftSellLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function ChargeTecShipGiftSellLayer:initData()
	self.showGoodVO = self.contextData.showGoodVO
	self.chargedList = self.contextData.chargedList
	self.goodVOList = self.showGoodVO:getSameLimitGroupTecGoods()
	self.normalGoodVO = nil
	self.highGoodVO = nil
	self.upGoodVO = nil

	for iter_5_0, iter_5_1 in ipairs(self.goodVOList) do
		if iter_5_1:getConfig("limit_arg") == 1 then
			self.highGoodVO = iter_5_1
		elseif iter_5_1:getConfig("limit_arg") == 2 then
			self.normalGoodVO = iter_5_1
		elseif iter_5_1:getConfig("limit_arg") == 3 then
			self.upGoodVO = iter_5_1
		end
	end

	self.goodVOShowList = {}

	local var_5_0 = ChargeConst.getBuyCount(self.chargedList, self.normalGoodVO.id)
	local var_5_1 = ChargeConst.getBuyCount(self.chargedList, self.highGoodVO.id)
	local var_5_2 = ChargeConst.getBuyCount(self.chargedList, self.upGoodVO.id)

	if var_5_0 == 0 and var_5_1 == 0 and var_5_2 == 0 then
		table.insert(self.goodVOShowList, self.normalGoodVO)
		table.insert(self.goodVOShowList, self.highGoodVO)
	elseif var_5_0 > 0 and var_5_1 == 0 and var_5_2 == 0 then
		table.insert(self.goodVOShowList, self.normalGoodVO)
		table.insert(self.goodVOShowList, self.upGoodVO)
	elseif (var_5_0 <= 0 or var_5_2 <= 0) and var_5_1 > 0 then
		-- block empty
	end

	return
end

function ChargeTecShipGiftSellLayer:initUIText()
	setText(self._tf:Find("Adapt/TipBG/Text"), i18n("tech_package_tip"))

	return
end

function ChargeTecShipGiftSellLayer:findUI()
	self.bg = self._tf:Find("BG")
	self.itemTpl = self._tf:Find("ItemTpl")
	self.giftTpl = self._tf:Find("GiftTpl")
	self.giftContainer = self._tf:Find("List")
	self.giftUIItemList = UIItemList.New(self.giftContainer, self.giftTpl)

	self.giftUIItemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			arg_8_1 = arg_8_1 + 1

			self:updateGiftTF(arg_8_2, self.goodVOShowList[arg_8_1])
		end

		return
	end)

	return
end

function ChargeTecShipGiftSellLayer:addListener()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_PANEL)

	return
end

function ChargeTecShipGiftSellLayer:updateGiftTF(arg_11_1, arg_11_2)
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
	local var_11_13 = ChargeConst.getBuyCount(self.chargedList, self.normalGoodVO.id) > 0

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
		self:closeView()

		return
	end

	onButton(self, var_11_1, function()
		var_11_14()

		return
	end, SFX_PANEL)
	onButton(self, var_11_2, function()
		var_11_14()

		return
	end, SFX_PANEL)
	onButton(self, var_11_3, function()
		var_11_14()

		return
	end, SFX_PANEL)
	setText(var_11_5, arg_11_2:getConfig("name_display"))
	setText(var_11_7, arg_11_2:getConfig("descrip"))
	setText(var_11_8, arg_11_2:getConfig("descrip_extra"))
	setImageSprite(var_11_6, LoadSprite("chargeicon/" .. arg_11_2:getConfig("picture")), true)

	local var_11_15 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_2:getConfig("display")) do
		table.insert(var_11_15, Drop.Create(iter_11_1))
	end

	local var_11_16 = UIItemList.New(var_11_9, self.itemTpl)

	var_11_16:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_0 = arg_16_2:Find("Container"):GetChild(0)

			arg_16_1 = arg_16_1 + 1

			local var_16_1 = var_11_15[arg_16_1]

			updateDrop(var_16_0, var_11_15[arg_16_1])
			onButton(self, var_16_0, function()
				self:emit(BaseUI.ON_DROP, var_16_1)

				return
			end, SFX_PANEL)
			setScrollText(arg_16_2:Find("TextMask/Text"), var_11_15[arg_16_1]:getName())
		end

		return
	end)
	var_11_16:align(#var_11_15)

	return
end

function ChargeTecShipGiftSellLayer:updateGiftList()
	self.giftUIItemList:align(#self.goodVOShowList)

	return
end

return ChargeTecShipGiftSellLayer
