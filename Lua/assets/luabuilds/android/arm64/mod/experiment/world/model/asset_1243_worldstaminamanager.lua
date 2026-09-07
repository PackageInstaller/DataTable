local WorldStaminaManager = class("WorldStaminaManager", import("...BaseEntity"))

WorldStaminaManager.Fields = {
	staminaExchangeTimes = "number",
	staminaLastRecoverTime = "number",
	staminaExtra = "number",
	transform = "userdata",
	updateTimer = "table",
	preSelectIndex = "number",
	stamina = "number",
	UIMain = "userdata"
}
WorldStaminaManager.EventUpdateStamina = "WorldStaminaManager.EventUpdateStamina"

function WorldStaminaManager:Build()
	pg.DelegateInfo.New(self)

	self.UIMain = pg.UIMgr.GetInstance().OverlayMain

	local var_1_0 = PoolMgr.GetInstance()

	var_1_0:GetUI("WorldStaminaRecoverUI", true, function(arg_2_0)
		if not self.UIMain then
			var_1_0:ReturnUI("WorldStaminaRecoverUI", arg_2_0)
		else
			self.transform = tf(arg_2_0)

			setParent(self.transform, self.UIMain, false)
			setActive(self.transform, false)
			onButton(self, self.transform:Find("bg"), function()
				self:Hide()

				return
			end, SFX_CANCEL)
			onButton(self, self.transform:Find("window/top/btnBack"), function()
				self:Hide()

				return
			end, SFX_CANCEL)
			onButton(self, self.transform:Find("window/button_container/custom_button_2"), function()
				self:Hide()

				return
			end, SFX_CANCEL)
		end

		return
	end)

	return
end

function WorldStaminaManager:Setup(arg_6_1)
	self.stamina = arg_6_1[1]
	self.staminaExtra = arg_6_1[2]
	self.staminaLastRecoverTime = arg_6_1[3]
	self.staminaExchangeTimes = arg_6_1[4]

	if not self.updateTimer then
		self.updateTimer = Timer.New(function()
			self:UpdateStamina()

			return
		end, 1, -1)

		self.updateTimer:Start()
		self.updateTimer.func()
	end

	return
end

function WorldStaminaManager:Dispose()
	pg.DelegateInfo.Dispose(self)

	if self.updateTimer then
		self.updateTimer:Stop()
	end

	if self.transform then
		PoolMgr.GetInstance():ReturnUI("WorldStaminaRecoverUI", go(self.transform))
	end

	self:Clear()

	return
end

function WorldStaminaManager:Reset()
	self.stamina = self:GetMaxStamina()

	return
end

function WorldStaminaManager:ChangeStamina(arg_10_1, arg_10_2)
	self.stamina = arg_10_1
	self.staminaExtra = arg_10_2

	self:DispatchEvent(WorldStaminaManager.EventUpdateStamina)

	return
end

function WorldStaminaManager:UpdateStamina()
	local var_11_0 = math.floor((pg.TimeMgr.GetInstance():GetServerTime() - self.staminaLastRecoverTime) / pg.gameset.world_movepower_recovery_interval.key_value)

	if var_11_0 > 0 then
		self.staminaLastRecoverTime = self.staminaLastRecoverTime + var_11_0 * pg.gameset.world_movepower_recovery_interval.key_value

		if self.stamina < self:GetMaxStamina() then
			self.stamina = math.min(self.stamina + var_11_0, self:GetMaxStamina())

			self:DispatchEvent(WorldStaminaManager.EventUpdateStamina)
		end
	end

	return
end

function WorldStaminaManager:CheckUpdateShow()
	if self:IsShowing() then
		self:Show()
	end

	return
end

function WorldStaminaManager:Show()
	local var_13_0 = self.transform:Find("window/world_stamina_panel")

	setText(var_13_0:Find("content/tip_bg/tip"), i18n("world_stamina_recover", (string.format("%.2d:%.2d:%.2d", math.floor(pg.gameset.world_movepower_recovery_interval.key_value / 16), math.floor(pg.gameset.world_movepower_recovery_interval.key_value % 16 / 60), pg.gameset.world_movepower_recovery_interval.key_value % 60))))
	setText(var_13_0:Find("content/tip_bg/stamina/value"), self:GetTotalStamina())

	local var_13_1 = var_13_0:Find("content/item_list")
	local var_13_2 = var_13_0:Find("item")

	setActive(var_13_2, false)

	local var_13_3 = self.transform:Find("window/button_container/custom_button_1")

	removeAllChildren(var_13_1)

	local var_13_4 = self:GetExchangeItems()

	for iter_13_0, iter_13_1 in ipairs(var_13_4) do
		local var_13_5 = cloneTplTo(var_13_2, var_13_1)

		updateDrop(var_13_5:Find("IconTpl"), iter_13_1.drop)
		setText(var_13_5:Find("IconTpl/icon_bg/count"), (iter_13_1.drop.count or nil) and (iter_13_1.drop.count or ""))
		setText(var_13_5:Find("name/Text"), shortenString(getText(var_13_5:Find("IconTpl/name")), 5))
		onToggle(self, var_13_5, function(arg_14_0)
			if arg_14_0 then
				self.preSelectIndex = iter_13_0

				if iter_13_0 > 1 then
					setText(var_13_0:Find("content/Text"), i18n("world_stamina_text2", iter_13_1.name, iter_13_1.stamina))
					onButton(self, var_13_3, function()
						if iter_13_1.drop.count == 0 then
							pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))
						else
							local var_15_0 = nowWorld()
							local var_15_1 = {}
							local var_15_2 = pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d")

							if var_15_0:CheckResetProgress() and PlayerPrefs.GetString("world_stamina_reset_tip", "") ~= var_15_2 and var_15_0:GetResetWaitingTime() < 0 and self:GetTotalStamina() + iter_13_1.stamina > self:GetMaxStamina() then
								PlayerPrefs.SetString("world_stamina_reset_tip", var_15_2)
								table.insert(var_15_1, function(arg_16_0)
									pg.MsgboxMgr.GetInstance():ShowMsgBox({
										content = i18n("world_stamina_resetwarning", self:GetMaxStamina()),
										onYes = arg_16_0
									})

									return
								end)
							end

							seriesAsync(var_15_1, function()
								pg.m02:sendNotification(GAME.WORLD_ITEM_USE, {
									count = 1,
									itemID = iter_13_1.drop.id,
									args = {}
								})

								return
							end)
						end

						return
					end, SFX_CONFIRM)
				elseif iter_13_0 == 1 then
					setText(var_13_0:Find("content/Text"), i18n("world_stamina_text", iter_13_1.cost, iter_13_1.stamina, iter_13_1.times, iter_13_1.limit))
					onButton(self, var_13_3, function()
						if iter_13_1.drop.count < iter_13_1.cost then
							pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_oil"))
						elseif iter_13_1.times == 0 then
							pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))
						else
							local var_18_0 = nowWorld()
							local var_18_1 = {}
							local var_18_2 = pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d")

							if var_18_0:CheckResetProgress() and PlayerPrefs.GetString("world_stamina_reset_tip", "") ~= var_18_2 and var_18_0:GetResetWaitingTime() < 0 and self:GetTotalStamina() + iter_13_1.stamina > self:GetMaxStamina() then
								PlayerPrefs.SetString("world_stamina_reset_tip", var_18_2)
								table.insert(var_18_1, function(arg_19_0)
									pg.MsgboxMgr.GetInstance():ShowMsgBox({
										content = i18n("world_stamina_resetwarning", self:GetMaxStamina()),
										onYes = arg_19_0
									})

									return
								end)
							end

							seriesAsync(var_18_1, function()
								pg.m02:sendNotification(GAME.WORLD_STAMINA_EXCHANGE)

								return
							end)
						end

						return
					end, SFX_CONFIRM)
				end
			end

			return
		end, SFX_PANEL)
	end

	if self.preSelectIndex then
		triggerToggle(var_13_1:GetChild(self.preSelectIndex - 1), true)
	else
		local var_13_7 = 1

		for iter_13_2 = 2, #var_13_4 do
			if var_13_4[iter_13_2].drop.count > 0 then
				var_13_7 = iter_13_2

				break
			end
		end

		triggerToggle(var_13_1:GetChild(var_13_7 - 1), true)
	end

	setActive(self.transform, true)
	pg.UIMgr.GetInstance():BlurPanel(self.transform)

	return
end

function WorldStaminaManager:Hide()
	self.preSelectIndex = nil

	setActive(self.transform, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.transform, self.UIMain)

	return
end

function WorldStaminaManager:IsShowing()
	return self.transform and isActive(self.transform) or false
end

function WorldStaminaManager:GetStamina()
	return self.stamina
end

function WorldStaminaManager:GetMaxStamina()
	return pg.gameset.world_movepower_maxvalue.key_value
end

function WorldStaminaManager:GetExtraStamina()
	return self.staminaExtra
end

function WorldStaminaManager:GetTotalStamina()
	return self:GetStamina() + self:GetExtraStamina()
end

function WorldStaminaManager:GetStepStaminaCost()
	return pg.gameset.world_cell_cost_movepower.key_value
end

function WorldStaminaManager:GetMaxMoveStep()
	return math.floor(self:GetTotalStamina() / self:GetStepStaminaCost())
end

function WorldStaminaManager:ConsumeStamina(arg_29_1)
	self.staminaExtra = self.staminaExtra - arg_29_1

	if self.staminaExtra < 0 then
		self.stamina = self.stamina + self.staminaExtra
		self.staminaExtra = 0
	end

	assert(self.stamina >= 0, "out of stamina.")
	self:DispatchEvent(WorldStaminaManager.EventUpdateStamina)

	return
end

function WorldStaminaManager:GetExchangeData()
	return pg.gameset.world_supply_value.description[math.min(#pg.gameset.world_supply_value.description, self.staminaExchangeTimes + 1)][1], pg.gameset.world_supply_price.description[math.min(#pg.gameset.world_supply_price.description, self.staminaExchangeTimes + 1)][3], #pg.gameset.world_supply_price.description - self.staminaExchangeTimes, #pg.gameset.world_supply_price.description
end

function WorldStaminaManager:GetExchangeItems()
	local var_31_0 = nowWorld():GetInventoryProxy()
	local var_31_1, var_31_2, var_31_3, var_31_4 = self:GetExchangeData()
	local var_31_5 = {}
	local var_31_6 = {}
	local var_31_7 = {
		id = PlayerConst.ResOil,
		type = DROP_TYPE_RESOURCE
	}

	var_31_7.count = getProxy(PlayerProxy):getRawData().oil
	var_31_6.drop = Drop.New(var_31_7)
	var_31_6.cost = var_31_2
	var_31_6.stamina = var_31_1
	var_31_6.times = var_31_3
	var_31_6.limit = var_31_4
	var_31_5[1] = var_31_6

	for iter_31_0, iter_31_1 in ipairs(pg.gameset.world_supply_itemlist.description) do
		local var_31_8 = Drop.New({
			type = DROP_TYPE_WORLD_ITEM,
			id = iter_31_1,
			count = var_31_0:GetItemCount(iter_31_1)
		})
		local var_31_10 = {
			cost = 1,
			drop = var_31_8,
			name = var_31_8:getConfig("name")
		}

		var_31_10.stamina = var_31_8:getSubClass():getItemStaminaRecover()

		table.insert(var_31_5, var_31_10)
	end

	return var_31_5
end

function WorldStaminaManager:ExchangeStamina(arg_32_1, arg_32_2)
	self.stamina = self.stamina + arg_32_1

	if arg_32_2 then
		self.staminaExchangeTimes = self.staminaExchangeTimes + 1
	end

	self:DispatchEvent(WorldStaminaManager.EventUpdateStamina)
	self:CheckUpdateShow()

	return
end

function WorldStaminaManager:GetDisplayStanima()
	return self:GetTotalStamina()
end

return WorldStaminaManager
