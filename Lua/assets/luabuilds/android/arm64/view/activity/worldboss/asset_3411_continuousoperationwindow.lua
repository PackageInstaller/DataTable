local ContinuousOperationWindow = class("ContinuousOperationWindow", import("view.base.BaseUI"))
local var_0_1 = 15

function ContinuousOperationWindow:getUIName()
	return "ContinuousOperationWindowUI"
end

function ContinuousOperationWindow:ResUISettings()
	return {
		reset = true,
		gemOffsetX = 628,
		showType = PlayerResUI.TYPE_OIL
	}
end

function ContinuousOperationWindow:init()
	self.panel = self._tf:Find("window/panel")
	self._countSelect = self.panel:Find("content")
	self._pageUtil = PageUtil.New(self._countSelect:Find("value_bg/left"), self._countSelect:Find("value_bg/right"), self._countSelect:Find("max"), self._countSelect:Find("value_bg/value"))
	self.consumeText = self.panel:Find("content/consume"):GetComponent("RichText")

	setText(self._tf:Find("window/top/bg/title/title"), i18n("multiple_sorties_title"))
	setText(self._tf:Find("window/top/bg/title/title/title_en"), i18n("multiple_sorties_title_eng"))
	setText(self.panel:Find("content/desc_txt"), i18n("multiple_sorties_times"))
	setText(self.panel:Find("Tip"), i18n("multiple_sorties_tip"))
	setText(self.panel:Find("battle/pic"), i18n("msgbox_text_battle"))
	setText(self.panel:Find("bonus/Text"), i18n("expedition_extra_drop_tip"))
	setText(self.panel:Find("ticket/Text"), i18n("multiple_sorties_challenge_ticket_use"))

	return
end

function ContinuousOperationWindow:SetActivity(arg_4_1)
	self.activity = arg_4_1

	return
end

function ContinuousOperationWindow:didEnter()
	onButton(self, self.panel:Find("battle"), function()
		if self.contextData.oilCost * self.contextData.battleTimes > getProxy(PlayerProxy):getRawData().oil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

			return
		end

		self:emit(PreCombatMediator.CONTINUOUS_OPERATION)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("window/top/btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	local var_5_0 = getProxy(SettingsProxy):isTipActBossExchangeTicket() == 1

	self.contextData.useTicket = defaultValue(self.contextData.useTicket, var_5_0)

	triggerToggle(self.panel:Find("ticket/checkbox"), var_5_0)
	onToggle(self, self.panel:Find("ticket/checkbox"), function(arg_9_0)
		self.contextData.useTicket = arg_9_0

		self:UpdateContent()

		return
	end, SFX_PANEL, SFX_CANCEL)

	local var_5_1 = LoadSprite(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = pg.activity_event_worldboss[self.activity:getConfig("config_id")].ticket
	}):getIcon(), "")

	self.consumeText:AddSprite("ticket", var_5_1)
	setImageSprite(self.panel:Find("ticket/Text/Icon"), var_5_1)
	self._pageUtil:setNumUpdate(function(arg_10_0)
		self.contextData.battleTimes = arg_10_0

		self:UpdateContent()

		return
	end)
	self._pageUtil:setMaxNum(var_0_1)

	self.contextData.battleTimes = self.contextData.battleTimes or 1

	self._pageUtil:setDefaultNum(self.contextData.battleTimes)
	self:UpdateContent()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ContinuousOperationWindow:UpdateContent()
	local var_11_0 = self.contextData.battleTimes
	local var_11_1 = getProxy(PlayerProxy):getRawData():getResource(pg.activity_event_worldboss[self.activity:getConfig("config_id")].ticket)
	local var_11_2 = self.activity:GetStageBonus(self.contextData.stageId)
	local var_11_3 = math.clamp(self.contextData.battleTimes - var_11_2, 0, var_11_1)
	local var_11_4 = self.contextData.useTicket and var_11_3 or 0
	local var_11_5 = tostring(var_11_2)

	if (self.contextData.useTicket and var_11_3 or 0) > 0 then
		var_11_5 = var_11_5 .. setColorStr("+" .. var_11_4, COLOR_GREEN)
	end

	setText(self.panel:Find("bonus/Number"), var_11_5)
	setText(self.panel:Find("ticket/Number"), var_11_4 .. "/" .. var_11_1)

	local var_11_6 = var_11_1 > 0 and var_11_3 > 0

	setActive(self.panel:Find("ticket/checkboxBan"), not (var_11_1 > 0 and var_11_3 > 0))
	setToggleEnabled(self.panel:Find("ticket/checkbox"), var_11_6)

	local var_11_7 = i18n("multiple_sorties_cost1", self.contextData.oilCost * var_11_0)

	if self.contextData.oilCost * var_11_0 > getProxy(PlayerProxy):getRawData().oil then
		var_11_7 = string.gsub(var_11_7, "#92fc63", COLOR_RED)
	end

	if var_11_4 > 0 then
		var_11_7 = var_11_7 .. i18n("multiple_sorties_cost2", var_11_4)
	end

	self.consumeText.text = var_11_7

	return
end

function ContinuousOperationWindow:willExit()
	self._pageUtil:Dispose()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ContinuousOperationWindow
