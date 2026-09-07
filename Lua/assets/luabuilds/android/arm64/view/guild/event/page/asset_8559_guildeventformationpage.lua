local GuildEventFormationPage = class("GuildEventFormationPage", import(".GuildEventBasePage"))

function GuildEventFormationPage:getUIName()
	return "GuildEventFormationUI"
end

function GuildEventFormationPage:OnLoaded()
	self.tpl = self._tf:Find("ShipCardTpl")
	self.closeBtn = self._tf:Find("frame/close")
	self.sendBtn = self._tf:Find("frame/btn")
	self.sendBtnGray = self._tf:Find("frame/btn/gray")
	self.slots = {
		self._tf:Find("frame/ship1"),
		self._tf:Find("frame/ship2")
	}
	self.items = {}
	self.cdTimer = {}

	return
end

function GuildEventFormationPage:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		self.contextData.editFleet = nil

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		self.contextData.editFleet = nil

		return
	end, SFX_PANEL)

	return
end

function GuildEventFormationPage:OnFleetUpdated(arg_6_1)
	self.extraData.fleet = arg_6_1

	self:UpdateSlots()

	return
end

function GuildEventFormationPage:OnFleetFormationDone()
	for iter_7_0, iter_7_1 in ipairs(self.slots) do
		self:RefreshCdTimer(iter_7_0)
	end

	self:UpdateSendBtn()

	return
end

function GuildEventFormationPage:OnShow()
	if not getProxy(GuildProxy).isFetchAssaultFleet then
		self:emit(GuildEventMediator.ON_GET_FORMATION)
	else
		self:UpdateSlots()
	end

	self:UpdateSendBtn()

	return
end

function GuildEventFormationPage:UpdateSendBtn()
	local var_9_0 = self.contextData.editFleet and self.contextData.editFleet and not self.extraData.fleet:AnyShipChanged(self.contextData.editFleet) or true

	setActive(self.sendBtnGray, var_9_0)

	if var_9_0 then
		removeOnButton(self.sendBtn)

		return
	end

	onButton(self, self.sendBtn, function()
		if self.existBossBattle then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_formation_erro_in_boss_battle"))

			return
		end

		self:emit(GuildEventMediator.UPDATE_FORMATION)

		return
	end, SFX_PANEL)

	return
end

function GuildEventFormationPage:UpdateSlots()
	self.fleet = self.contextData.editFleet or self.extraData.fleet

	local var_11_1 = self.guild:GetActiveEvent()
	local var_11_2 = var_11_1 and var_11_1:GetBossMission()

	self.existBossBattle = var_11_2 and var_11_2:IsActive()

	for iter_11_0, iter_11_1 in ipairs(self.slots) do
		self:UpdateSlot(iter_11_0, iter_11_1, (self.fleet:GetShipByPos(iter_11_0)))
		self:RefreshCdTimer(iter_11_0)
	end

	return
end

function GuildEventFormationPage:ShipIsBattle(arg_12_1)
	return self.existBossBattle
end

function GuildEventFormationPage:UpdateSlot(arg_13_1, arg_13_2, arg_13_3)
	local var_13_1 = arg_13_2:Find("ship")
	local var_13_2 = arg_13_2:Find("tag/tag")

	if arg_13_3 then
		if not var_13_1 then
			var_13_1 = cloneTplTo(self.tpl, arg_13_2)

			setActive(var_13_1, true)
			var_13_1:SetAsFirstSibling()
		end

		local var_13_3 = self.items[arg_13_1] or DockyardShipItem.New(var_13_1)

		var_13_3:update(GuildAssaultShip.ConverteFromShip(arg_13_3))

		var_13_3.go.name = "ship"

		setActive(var_13_2, self:ShipIsBattle(arg_13_3))
	else
		if var_13_1 then
			setActive(var_13_1, false)
			setActive(var_13_2, false)
		end

		local var_13_4

		do
			setActive(var_13_2, false)

			var_13_4 = onButton
		end
	end

	var_13_4(self, arg_13_3 and var_13_1 or arg_13_2, function()
		if not getProxy(GuildProxy):CanFormationPos(arg_13_1) then
			return
		end

		if self.existBossBattle then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_formation_erro_in_boss_battle"))

			return
		end

		self:emit(GuildEventMediator.ON_SELECT_SHIP, arg_13_1, arg_13_3, self.fleet)

		return
	end, SFX_PANEL)

	return
end

function GuildEventFormationPage:RefreshCdTimer(arg_15_1)
	local var_15_0 = self.slots[arg_15_1]
	local var_15_1 = self.slots[arg_15_1]:Find("tag/timer")
	local var_15_2 = var_15_1:Find("Text"):GetComponent(typeof(Text))
	local var_15_3 = self.slots[arg_15_1]:Find("tag/tag")
	local var_15_4 = not getProxy(GuildProxy):CanFormationPos(arg_15_1)

	setActive(var_15_1, false)
	self:RemoveTimer(arg_15_1)

	local var_15_5

	if var_15_4 then
		self.cdTimer[arg_15_1] = Timer.New(function()
			local var_16_0 = getProxy(GuildProxy):GetNextCanFormationTime(arg_15_1) - pg.TimeMgr.GetInstance():GetServerTime()

			if var_16_0 > 0 then
				var_15_2.text = pg.TimeMgr.GetInstance():DescCDTime(var_16_0)
			else
				setActive(var_15_1, false)
				setActive(var_15_0:Find("tag"), isActive(var_15_3))
			end

			return
		end, 1, -1)

		self.cdTimer[arg_15_1]:Start()
		self.cdTimer[arg_15_1].func()
		setActive(var_15_1, true)

		var_15_5 = isActive(var_15_3) or var_15_4
	end

	setActive(self.slots[arg_15_1]:Find("tag"), var_15_5)

	return
end

function GuildEventFormationPage:RemoveTimer(arg_17_1)
	if self.cdTimer[arg_17_1] then
		self.cdTimer[arg_17_1]:Stop()

		self.cdTimer[arg_17_1] = nil
	end

	return
end

function GuildEventFormationPage:OnDestroy()
	GuildEventFormationPage.super.OnDestroy(self)

	for iter_18_0, iter_18_1 in pairs(self.cdTimer) do
		self:RemoveTimer(iter_18_0)
	end

	return
end

return GuildEventFormationPage
