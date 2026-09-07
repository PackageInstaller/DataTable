local WorldResource = class("WorldResource", import("..base.BaseUI"))

WorldResource.Listeners = {
	onUpdateInventory = "OnUpdateInventory",
	onUpdateActivate = "OnUpdateActivate",
	onUpdateStamina = "OnUpdateStamina",
	onBossProgressUpdate = "OnBossProgressUpdate"
}

function WorldResource:Ctor()
	WorldResource.super.Ctor(self)
	PoolMgr.GetInstance():GetUI("WorldResPanel", false, function(arg_2_0)
		arg_2_0.transform:SetParent(pg.UIMgr.GetInstance().UIMain.transform, false)
		self:onUILoaded(arg_2_0)

		return
	end)

	return
end

function WorldResource:init()
	for iter_3_0, iter_3_1 in pairs(WorldResource.Listeners) do
		self[iter_3_0] = function(...)
			WorldResource[iter_3_1](self, ...)

			return
		end
	end

	local var_3_0 = nowWorld()

	self.stamina = self._tf:Find("res/stamina")

	onButton(self, self.stamina, function()
		var_3_0.staminaMgr:Show()

		return
	end, SFX_PANEL)

	self.oil = self._tf:Find("res/oil")

	onButton(self, self.oil, function()
		local var_6_0 = ShoppingStreet.getRiseShopId(ShopArgs.BuyOil, self.player.buyOilCount)

		if not var_6_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_today_buy_limit"))

			return
		end

		local var_6_1 = pg.shop_template[var_6_0]
		local var_6_2 = pg.shop_template[var_6_0].num

		if pg.shop_template[var_6_0].num == -1 and var_6_1.genre == ShopArgs.BuyOil then
			var_6_2 = ShopArgs.getOilByLevel(self.player.level)
		end

		if pg.gameset.buy_oil_limit.key_value > self.player.buyOilCount then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_SINGLE_ITEM,
				content = i18n("oil_buy_tip", var_6_1.resource_num, var_6_2, self.player.buyOilCount),
				drop = {
					id = 2,
					type = DROP_TYPE_RESOURCE,
					count = var_6_2
				},
				onYes = function()
					pg.m02:sendNotification(GAME.SHOPPING, {
						isQuickShopping = true,
						count = 1,
						id = var_6_0
					})

					return
				end
			})
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = i18n("help_oil_buy_limit"),
				custom = {
					{
						text = "text_iknow",
						sound = SFX_CANCEL
					}
				}
			})
		end

		return
	end, SFX_PANEL)

	self.Whuobi = self._tf:Find("res/Whuobi")

	onButton(self, self.Whuobi, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_SINGLE_ITEM,
			drop = Drop.New({
				type = DROP_TYPE_WORLD_ITEM,
				id = WorldItem.MoneyId
			})
		})

		return
	end, SFX_PANEL)

	self.bossProgress = self._tf:Find("res/boss_progress")

	onButton(self, self.bossProgress, function()
		local var_9_0 = WorldBossConst.GetCurrBossItemInfo()
		local var_9_1 = WorldBossConst.CanUnlockCurrBoss()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_DROP_ITEM,
			name = var_9_0.name,
			content = var_9_0.display,
			iconPath = var_9_0.icon,
			frame = var_9_0.rarity,
			yesText = i18n("common_go_to_analyze"),
			yesGray = not var_9_1,
			onYes = function()
				if var_9_1 then
					if var_3_0:GetBossProxy():IsOpen() then
						pg.m02:sendNotification(GAME.GO_SCENE, SCENE.WORLDBOSS)

						goto label_10_0
					end
				end

				pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_progress_no_enough"))
				pg.MsgboxMgr.GetInstance():hide()

				::label_10_0::

				return
			end
		})

		return
	end, SFX_PANEL)

	if var_3_0:GetActiveMap() then
		self:setStaminaMgr(var_3_0.staminaMgr)
	else
		self.atlas = var_3_0:GetAtlas()

		self.atlas:AddListener(WorldAtlas.EventUpdateActiveMap, self.onUpdateActivate)
		setActive(self.stamina, false)
	end

	self:setWorldInventory(var_3_0:GetInventoryProxy())
	self:SetWorldBossRes(var_3_0:GetBossProxy())

	return
end

function WorldResource:setParent(arg_11_1, arg_11_2)
	setParent(self._go, arg_11_1, arg_11_2)

	return
end

function WorldResource:setPlayer(arg_12_1)
	assert(isa(arg_12_1, Player), "should be an instance of Player")

	self.player = arg_12_1

	setText(self.oil:Find("max_value"), "MAX:" .. pg.user_level[arg_12_1.level].max_oil)
	setText(self.oil:Find("value"), arg_12_1.oil)

	return
end

function WorldResource:OnUpdateActivate()
	self:setStaminaMgr(nowWorld().staminaMgr)
	self.atlas:RemoveListener(WorldAtlas.EventUpdateActiveMap, self.onUpdateActivate)

	return
end

function WorldResource:setStaminaMgr(arg_14_1)
	self.staminaMgr = arg_14_1

	setText(self.stamina:Find("max_value"), "MAX:" .. arg_14_1:GetMaxStamina())
	self.staminaMgr:AddListener(WorldStaminaManager.EventUpdateStamina, self.onUpdateStamina)
	self:OnUpdateStamina()
	setActive(self.stamina, true)

	return
end

function WorldResource:setWorldInventory(arg_15_1)
	self.inventoryProxy = arg_15_1

	self.inventoryProxy:AddListener(WorldInventoryProxy.EventUpdateItem, self.onUpdateInventory)
	self:OnUpdateInventory()

	return
end

function WorldResource:OnUpdateStamina()
	setText(self.stamina:Find("value"), self.staminaMgr:GetDisplayStanima())

	return
end

function WorldResource:OnUpdateInventory(arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_1 or arg_17_1 == WorldInventoryProxy.EventUpdateItem and arg_17_3.id == WorldItem.MoneyId then
		setText(self.Whuobi:Find("value"), self.inventoryProxy:GetItemCount(WorldItem.MoneyId))
	end

	return
end

function WorldResource:SetWorldBossRes(arg_18_1)
	self.worldBossProxy = arg_18_1

	self.worldBossProxy:AddListener(WorldBossProxy.EventUnlockProgressUpdated, self.onBossProgressUpdate)
	self:OnBossProgressUpdate()

	return
end

function WorldResource:OnBossProgressUpdate()
	local var_19_0 = WorldBossConst.GetCurrBossItemProgress()
	local var_19_1, var_19_2, var_19_3 = WorldBossConst.GetCurrBossItemCapacity()
	local var_19_4, var_19_5 = WorldBossConst.GetCurrBossConsume()
	local var_19_6 = self.bossProgress:Find("value")
	local var_19_7 = self.bossProgress:Find("max_value")
	local var_19_8

	if var_19_3 <= var_19_2 then
		var_19_8 = COLOR_GREY or COLOR_WHITE
	end

	setText(var_19_6, "<color=" .. var_19_8 .. ">" .. var_19_0 .. "/" .. var_19_5 .. "</color>")
	setText(var_19_7, "<color=" .. var_19_8 .. ">DAILY:" .. var_19_2 .. "/" .. var_19_3 .. "</color>")
	setActive(self.bossProgress, nowWorld():IsSystemOpen(WorldConst.SystemWorldBoss))

	return
end

function WorldResource:willExit()
	if self.staminaMgr then
		self.staminaMgr:RemoveListener(WorldStaminaManager.EventUpdateStamina, self.onUpdateStamina)
	else
		self.atlas:RemoveListener(WorldAtlas.EventUpdateActiveMap, self.onUpdateActivate)
	end

	self.inventoryProxy:RemoveListener(WorldInventoryProxy.EventUpdateItem, self.onUpdateInventory)
	self.worldBossProxy:RemoveListener(WorldBossProxy.EventUnlockProgressUpdated, self.onBossProgressUpdate)
	PoolMgr.GetInstance():ReturnUI("WorldResPanel", self._go)

	return
end

return WorldResource
