local SupportShipPoolPage = class("SupportShipPoolPage", import("...base.BaseSubView"))

function SupportShipPoolPage:getUIName()
	return "SupportShipPoolPageUI"
end

function SupportShipPoolPage:OnLoaded()
	self.medalCount = self._tf:Find("gallery/res_items/medal")
	self.patingTF = self._tf:Find("painting")
	self.bg = self._tf:Find("gallery/bg")
	self.tipSTxt = self.bg:Find("type_intro/mask/title"):GetComponent("ScrollText")
	self.shopBtn = self._tf:Find("gallery/shop_btn")
	self.helpBtn = self._tf:Find("gallery/help_btn")
	self.startBtn = self._tf:Find("gallery/start_btn")

	return
end

function SupportShipPoolPage:OnInit()
	onButton(self, self.shopBtn, function()
		self:emit(BuildShipMediator.ON_SUPPORT_SHOP)

		return
	end, SFX_PANEL)

	return
end

function SupportShipPoolPage:Flush()
	self:UpdateMedal()

	local var_5_0 = getProxy(BuildShipProxy):getSupportShipCost()
	local var_5_1 = pg.gametip.honor_medal_support_tips_display.tip

	setText(self._tf:Find("gallery/prints/intro/text"), pg.gametip.honor_medal_support_tips_display.tip.support_tip_consume)
	setImageSprite(self.bg, GetSpriteFromAtlas(pg.gametip.honor_medal_support_tips_display.tip.bg, ""))
	self.tipSTxt:SetText(pg.gametip.honor_medal_support_tips_display.tip.support_tip_ship)

	local var_5_2 = self._tf:Find("gallery/item_bg/medal")

	setText(var_5_2:Find("name"), Drop.New({
		type = DROP_TYPE_ITEM,
		id = ITEM_ID_SILVER_HOOK
	}):getName())
	setText(var_5_2:Find("count/Text"), var_5_0)
	self:UpdateBuildPoolPaiting()
	onButton(self, self.helpBtn, function()
		self.contextData.helpWindow:ExecuteAction("Show", var_5_1, "support")

		return
	end, SFX_CANCEL)

	local var_5_3 = getProxy(BagProxy)

	onButton(self, self.startBtn, function()
		self.contextData.msgbox:ExecuteAction("Show", {
			buildType = "medal",
			itemVO = Item.New({
				id = ITEM_ID_SILVER_HOOK,
				count = var_5_3:getItemCountById(ITEM_ID_SILVER_HOOK)
			}),
			cost = var_5_0,
			max = MAX_BUILD_WORK_COUNT,
			onConfirm = function(arg_8_0)
				self:emit(BuildShipMediator.ON_SUPPORT_EXCHANGE, arg_8_0)

				return
			end
		})

		return
	end, SFX_UI_BUILDING_STARTBUILDING)

	return
end

function SupportShipPoolPage:UpdateMedal()
	setText(self.medalCount:Find("Text"), getProxy(BagProxy):getItemCountById(ITEM_ID_SILVER_HOOK))

	return
end

function SupportShipPoolPage:UpdateBuildPoolPaiting()
	local var_10_0 = self.contextData.falgShip:getPainting()

	if self.painting ~= var_10_0 then
		pg.UIMgr.GetInstance():LoadingOn()
		setPaintingPrefabAsync(self.patingTF, var_10_0, "build", function()
			self.painting = var_10_0

			pg.UIMgr.GetInstance():LoadingOff()

			return
		end)
	end

	return
end

function SupportShipPoolPage:ShowOrHide(arg_12_1)
	if arg_12_1 then
		self:Show()
	else
		self:Hide()
	end

	return
end

function SupportShipPoolPage:OnDestroy()
	return
end

return SupportShipPoolPage
