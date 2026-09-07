local LevelContinuousOperationWindow = class("LevelContinuousOperationWindow", import("view.activity.worldboss.ContinuousOperationWindow"))

function LevelContinuousOperationWindow:getUIName()
	return "LevelContinuousOperationWindowUI"
end

function LevelContinuousOperationWindow:ResUISettings()
	return {
		reset = true,
		gemOffsetX = 628,
		showType = PlayerResUI.TYPE_OIL
	}
end

function LevelContinuousOperationWindow:init()
	self.panel = self._tf:Find("window/panel")
	self._countSelect = self.panel:Find("content")
	self._pageUtil = PageUtil.New(self._countSelect:Find("value_bg/left"), self._countSelect:Find("value_bg/right"), self._countSelect:Find("max"), self._countSelect:Find("value_bg/value"))
	self.consumeText = self.panel:Find("content/consume"):GetComponent("RichText")

	setText(self._tf:Find("window/top/bg/title/title"), i18n("multiple_sorties_title"))
	setText(self._tf:Find("window/top/bg/title/title/title_en"), i18n("multiple_sorties_title_eng"))
	setText(self.panel:Find("content/desc_txt"), i18n("multiple_sorties_times"))
	setText(self.panel:Find("Tip"), i18n("multiple_sorties_main_tip"))
	setText(self.panel:Find("battle/pic"), i18n("msgbox_text_battle"))
	setText(self.panel:Find("bonus/Text"), i18n("expedition_extra_drop_tip"))
	setText(self.panel:Find("ticket/Text"), i18n("multiple_sorties_challenge_ticket_use"))

	return
end

function LevelContinuousOperationWindow:didEnter()
	onButton(self, self._tf:Find("window/top/btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.contextData.useTicket = defaultValue(self.contextData.useTicket, self.contextData.extraRate.enabled)

	triggerToggle(self.panel:Find("ticket/checkbox"), self.contextData.extraRate.enabled)
	onToggle(self, self.panel:Find("ticket/checkbox"), function(arg_7_0)
		self.contextData.useTicket = arg_7_0

		self:emit(LevelMediator2.ON_SPITEM_CHANGED, arg_7_0)
		self:UpdateContent()

		return
	end, SFX_PANEL, SFX_CANCEL)
	self._pageUtil:setNumUpdate(function(arg_8_0)
		self.contextData.battleTimes = arg_8_0

		self:UpdateContent()

		return
	end)
	self._pageUtil:setMaxNum(self.contextData.maxCount)

	if self.contextData.maxCount >= 0 then
		local var_4_0 = getProxy(PlayerProxy):getRawData().oil
		local var_4_1 = math.floor(var_4_0 / self.contextData.oilCost)

		warning(self.contextData.oilCost, var_4_0, var_4_1)

		self.contextData.battleTimes = math.min(self.contextData.maxCount, var_4_1)
		self.contextData.battleTimes = math.max(self.contextData.battleTimes, 1)
	end

	self._pageUtil:setDefaultNum(self.contextData.battleTimes)
	self:UpdateContent()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function LevelContinuousOperationWindow:UpdateContent()
	local var_9_0 = self.contextData.battleTimes
	local var_9_1 = self.contextData.extraRate
	local var_9_2 = self.contextData.extraRate.extraCount
	local var_9_3 = math.clamp(self.contextData.battleTimes - self.contextData.extraRate.freeBonus, 0, self.contextData.extraRate.extraCount)
	local var_9_4 = self.contextData.useTicket and var_9_3 or 0

	if self.contextData.useTicket then
		setText(self.panel:Find("ticket/Number"), setColorStr(self.contextData.useTicket and var_9_3 or 0, (var_9_0 <= var_9_2 or nil) and (COLOR_GREEN or COLOR_RED)) .. "/" .. var_9_2)
	else
		setText(self.panel:Find("ticket/Number"), var_9_2)
	end

	local var_9_6 = var_9_2 > 0 and var_9_3 > 0

	setActive(self.panel:Find("ticket/checkboxBan"), not (var_9_2 > 0 and var_9_3 > 0))
	setToggleEnabled(self.panel:Find("ticket/checkbox"), var_9_6)

	if self.contextData.useTicket and not var_9_6 then
		triggerToggle(self.panel:Find("ticket/checkbox"), false)
	end

	local var_9_7 = self.contextData.oilCost * (var_9_0 + (var_9_1.rate - 1) * var_9_4)
	local var_9_8 = i18n("multiple_sorties_cost1", self.contextData.oilCost * (var_9_0 + (var_9_1.rate - 1) * var_9_4))
	local var_9_9 = getProxy(PlayerProxy):getRawData()

	if self.contextData.oilCost * (var_9_0 + (var_9_1.rate - 1) * var_9_4) > var_9_9.oil then
		var_9_8 = string.gsub(var_9_8, "#92fc63", COLOR_RED)
	end

	if var_9_4 > 0 then
		var_9_8 = var_9_8 .. i18n("multiple_sorties_cost3", var_9_4)
	end

	self.consumeText.text = var_9_8

	onButton(self, self.panel:Find("battle"), function()
		if var_9_7 > var_9_9.oil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

			return
		end

		self:emit(PreCombatMediator.CONTINUOUS_OPERATION)

		return
	end, SFX_PANEL)

	return
end

return LevelContinuousOperationWindow
