local WorldCruiseShopPage = class("WorldCruiseShopPage", import("view.base.BaseSubView"))

function WorldCruiseShopPage:getUIName()
	return "WorldCruiseShopPage"
end

function WorldCruiseShopPage:UpdateShop(arg_2_1)
	self.shop = arg_2_1 or getProxy(ShopsProxy):GetCruiseShop()

	return
end

function WorldCruiseShopPage:OnLoaded()
	self:UpdateShop()

	local var_3_0 = self._tf:Find("frame")

	self.lockTF = var_3_0:Find("views/lock")
	self.remainTF = var_3_0:Find("views/remain")
	self.togglesTF = var_3_0:Find("toggles")

	eachChild(self.togglesTF, function(arg_4_0)
		setText(arg_4_0:Find("unselected/Text"), i18n("cruise_shop_title_" .. arg_4_0.name))
		setText(arg_4_0:Find("selected/Text"), i18n("cruise_shop_title_" .. arg_4_0.name))
		onToggle(self, arg_4_0, function(arg_5_0)
			if arg_5_0 then
				setActive(self.remainTF, arg_4_0.name == "equip_skin")
			end

			self:Flush()

			return
		end, SFX_PANEL)

		return
	end)

	local var_3_1 = var_3_0:Find("views")
	local var_3_2 = string.format("-%s-", i18n("word_sell_out"))

	self.skinView = var_3_1:Find("skin")

	setText(self.skinView:Find("tpl_skin/mask/sell_out/Text"), var_3_2)

	self.skinScrollCom = GetComponent(self.skinView:Find("content"), "LScrollRect")

	function self.skinScrollCom.onUpdateItem(arg_6_0, arg_6_1)
		self:UpdateSkinItem(arg_6_0, tf(arg_6_1))

		return
	end

	self.equipSkinView = var_3_1:Find("equip_skin")

	setText(self.equipSkinView:Find("tpl_equip_skin/mask/sell_out/Text"), var_3_2)

	self.equipSkinScrollCom = GetComponent(self.equipSkinView:Find("content"), "LScrollRect")

	function self.equipSkinScrollCom.onUpdateItem(arg_7_0, arg_7_1)
		self:UpdateEquipSkinItem(arg_7_0, tf(arg_7_1))

		return
	end

	return
end

function WorldCruiseShopPage:OnInit()
	self.unlockPhase = pg.gameset.battlepass_level.key_value
	self.paintingList = {}

	return
end

function WorldCruiseShopPage:Flush(arg_9_1)
	self:Show()

	if arg_9_1 then
		self:UpdateShop(arg_9_1)
	end

	self.isLock = self.contextData.phase < self.unlockPhase
	self.remainCnt = self.shop:GetRemainEquipSkinCnt()

	setText(self.lockTF:Find("Image/Text"), i18n("cruise_shop_lock_tip", self.contextData.phase, self.unlockPhase))
	setActive(self.lockTF, self.isLock)
	setText(self.remainTF, i18n("cruise_shop_limit_tip") .. self.remainCnt)

	self.skinGoods = self.shop:getSortGoodsByType(CruiseShop.TYPE_SKIN)

	if isActive(self.skinView) then
		self.skinScrollCom:SetTotalCount(#self.skinGoods)
	end

	self.equipSkinGoods = self.shop:getSortGoodsByType(CruiseShop.TYPE_EQUIP_SKIN)

	if isActive(self.equipSkinView) then
		self.equipSkinScrollCom:SetTotalCount(#self.equipSkinGoods)
	end

	return
end

function WorldCruiseShopPage:UpdateSkinItem(arg_10_1, arg_10_2)
	local var_10_0 = self.skinGoods[arg_10_1 + 1]
	local var_10_1 = self.skinGoods[arg_10_1 + 1]:getDropInfo()
	local var_10_2 = self.skinGoods[arg_10_1 + 1]:GetName() or "??"

	if string.match(var_10_2, "(%d+)") then
		setText(arg_10_2:Find("skin_name"), shortenString(var_10_2, 7))
	else
		setText(arg_10_2:Find("skin_name"), shortenString(var_10_2, 8))
	end

	setText(arg_10_2:Find("name"), pg.ship_data_statistics[tonumber(var_10_1:getConfig("ship_group") .. "1")].name)
	setText(arg_10_2:Find("buy/Text"), var_10_0:GetPrice())

	local var_10_3 = arg_10_2:Find("icon_mask/painting")
	local var_10_4 = var_10_1:getConfig("painting")

	retPaintingPrefab(var_10_3, var_10_4, "pifu")
	setPaintingPrefabAsync(var_10_3, var_10_4, "pifu", function()
		setLocalPosition(var_10_3, {
			x = 0,
			y = 40
		})

		self.paintingList[var_10_4] = var_10_3

		return
	end)

	local var_10_5 = var_10_0:canPurchase()

	setActive(arg_10_2:Find("mask"), not var_10_5)
	onButton(self, arg_10_2, function()
		if not var_10_5 then
			return
		end

		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
			contentText = i18n("charge_scene_buy_confirm", var_10_0:GetPrice(), var_10_0:GetName()),
			onConfirm = function()
				if getProxy(PlayerProxy):getData():getTotalGem() < var_10_0:GetPrice() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

					return
				end

				self:emit(WorldCruiseMediator.ON_CRUISE_SHOPPING, var_10_0.id, 1)

				return
			end
		})

		return
	end, SFX_CONFIRM)

	return
end

function WorldCruiseShopPage:UpdateEquipSkinItem(arg_14_1, arg_14_2)
	local var_14_0 = self.equipSkinGoods[arg_14_1 + 1]
	local var_14_1 = self.equipSkinGoods[arg_14_1 + 1]:getDropInfo()

	updateDrop(arg_14_2:Find("IconTpl"), var_14_1)

	local var_14_2 = var_14_0:GetName() or "??"

	if string.match(var_14_2, "(%d+)") then
		setText(arg_14_2:Find("name"), shortenString(var_14_2, 5))
	else
		setText(arg_14_2:Find("name"), shortenString(var_14_2, 6))
	end

	setText(arg_14_2:Find("buy/Text"), var_14_0:GetPrice())
	setText(arg_14_2:Find("Text"), i18n("common_already owned") .. string.format("%s/%s", var_14_0:GetOwnedCnt(), var_14_0:getLimitCount()))

	local var_14_3 = var_14_0:canPurchase()

	setActive(arg_14_2:Find("mask"), not var_14_3)
	onButton(self, arg_14_2, function()
		local var_15_2
		local var_15_1
		local var_15_0

		if not var_14_3 then
			do return end

			var_15_0 = {
				drop = var_14_1
			}
			var_15_1 = {
				{
					type = pg.NewStyleMsgboxMgr.BUTTON_TYPE.cancel,
					name = i18n("msgbox_text_cancel"),
					sound = SFX_CANCEL
				}
			}
			var_15_2 = {
				type = pg.NewStyleMsgboxMgr.BUTTON_TYPE.confirm,
				name = i18n("text_exchange")
			}
		end

		function var_15_2.func()
			if self.remainCnt <= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("cruise_limit_count"))

				return
			end

			if getProxy(PlayerProxy):getData():getTotalGem() < var_14_0:GetPrice() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

				return
			end

			self:emit(WorldCruiseMediator.ON_CRUISE_SHOPPING, var_14_0.id, 1)

			return
		end

		var_15_2.sound = SFX_CONFIRM
		var_15_1[2] = var_15_2
		var_15_0.btnList = var_15_1

		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_DROP, var_15_0)

		return
	end, SFX_CONFIRM)

	return
end

function WorldCruiseShopPage:OnDestroy()
	for iter_17_0, iter_17_1 in pairs(self.paintingList) do
		setLocalPosition(iter_17_1, {
			x = 0,
			y = 0
		})
		retPaintingPrefab(iter_17_1, iter_17_0)
	end

	return
end

return WorldCruiseShopPage
