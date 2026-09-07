local BuildShipRegularExchangeLayer = class("BuildShipRegularExchangeLayer", import("view.base.BaseUI"))

function BuildShipRegularExchangeLayer:getUIName()
	return "BuildShipRegularExchangeUI"
end

function BuildShipRegularExchangeLayer:preload(arg_2_1)
	self.cfg = pg.ship_data_create_exchange[REGULAR_BUILD_POOL_EXCHANGE_ID]
	self.ids = self.cfg.exchange_ship_id
	self.iconSprites = {}

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(self.ids) do
		table.insert(var_2_0, function(arg_3_0)
			GetSpriteFromAtlasAsync("RegularExchangeIcon", tostring(iter_2_1), function(arg_4_0)
				self.iconSprites[iter_2_1] = arg_4_0

				arg_3_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_2_0, arg_2_1)

	return
end

function BuildShipRegularExchangeLayer:setCount(arg_5_1)
	self.count = arg_5_1

	setText(self.textCount, self.count .. "/" .. self.cfg.exchange_request)
	setGray(self.btnConfirm, self.count < self.cfg.exchange_request)

	return
end

function BuildShipRegularExchangeLayer:init()
	self.btnBack = self._tf:Find("top/bg/btn_back")

	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)

	local var_6_0 = self._tf:Find("select/view/container")

	self.iconList = UIItemList.New(var_6_0, var_6_0:Find("tpl"))

	self.iconList:make(function(arg_8_0, arg_8_1, arg_8_2)
		arg_8_1 = arg_8_1 + 1

		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = Ship.New({
				configId = self.ids[arg_8_1]
			})

			setImageSprite(arg_8_2:Find("Image"), self.iconSprites[var_8_0.configId], true)
			setActive(arg_8_2:Find("noget"), not getProxy(CollectionProxy):getShipGroup(var_8_0:getGroupId()))
			onToggle(self, arg_8_2, function(arg_9_0)
				if arg_9_0 then
					self:setSelectedShip(var_8_0)
				end

				return
			end, SFX_PANEL)
			triggerToggle(arg_8_2, arg_8_1 == 1)
		end

		return
	end)
	onButton(self, self._tf:Find("select/operation/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("Normalbuild_URexchange_help")
		})

		return
	end, SFX_PANEL)
	setText(self._tf:Find("select/operation/count/Text"), i18n("Normalbuild_URexchange_text2") .. ":")

	self.textCount = self._tf:Find("select/operation/count/num")
	self.btnConfirm = self._tf:Find("select/operation/confirm")

	onButton(self, self.btnConfirm, function()
		if self.count < self.cfg.exchange_request then
			pg.TipsMgr.GetInstance():ShowTips(i18n("Normalbuild_URexchange_warning1"))
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("Normalbuild_URexchange_confirm", self.shipVO:getName()),
				onYes = function()
					self:emit(BuildShipRegularExchangeMediator.EXCHAGNE_SHIP, self.shipVO.configId)
					self:closeView()

					return
				end
			})
		end

		return
	end, SFX_CONFIRM)

	self.rtName = self._tf:Find("select/name_bg")
	self.rtPaint = self._tf:Find("main/paint")

	self:OverlayPanel(self._tf)

	return
end

function BuildShipRegularExchangeLayer:setSelectedShip(arg_13_1)
	if self.shipVO then
		retPaintingPrefab(self.rtPaint, self.shipVO:getPainting())
	end

	self.shipVO = arg_13_1

	GetImageSpriteFromAtlasAsync("shiptype", ShipType.Type2BattlePrint(arg_13_1:getShipType()), self.rtName:Find("shiptype/Image"), true)
	setText(self.rtName:Find("name"), arg_13_1:getName())
	setText(self.rtName:Find("english"), string.upper(arg_13_1:getConfig("english_name")))
	setPaintingPrefabAsync(self.rtPaint, arg_13_1:getPainting(), "huode")

	return
end

function BuildShipRegularExchangeLayer:flush()
	mergeSort(self.ids, CompareFuncs({
		function(arg_15_0)
			return getProxy(CollectionProxy):getShipGroup(Ship.New({
				configId = arg_15_0
			}):getGroupId()) and 1 or 0
		end
	}, true))
	self.iconList:align(#self.ids)

	return
end

function BuildShipRegularExchangeLayer:didEnter()
	self:flush()

	return
end

function BuildShipRegularExchangeLayer:willExit()
	self.iconSprites = nil

	if self.shipVO then
		retPaintingPrefab(self.rtPaint, self.shipVO:getPainting())
	end

	self:UnOverlayPanel(self._tf)

	return
end

return BuildShipRegularExchangeLayer
