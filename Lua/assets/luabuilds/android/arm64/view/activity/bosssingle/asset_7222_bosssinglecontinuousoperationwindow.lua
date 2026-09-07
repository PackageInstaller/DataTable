local BossSingleContinuousOperationWindow = class("BossSingleContinuousOperationWindow", import("view.activity.worldboss.ContinuousOperationWindow"))
local var_0_1 = 15

function BossSingleContinuousOperationWindow:getUIName()
	return "BossSingleContinuousOperationWindowUI"
end

function BossSingleContinuousOperationWindow:ResUISettings()
	return {
		reset = true,
		gemOffsetX = 628,
		showType = PlayerResUI.TYPE_OIL
	}
end

function BossSingleContinuousOperationWindow:init()
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

function BossSingleContinuousOperationWindow:didEnter()
	onButton(self, self.panel:Find("battle"), function()
		if self.contextData.oilCost * self.contextData.battleTimes > getProxy(PlayerProxy):getRawData().oil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

			return
		end

		self:emit(BossSinglePreCombatMediator.CONTINUOUS_OPERATION)

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
	self._pageUtil:setNumUpdate(function(arg_8_0)
		self.contextData.battleTimes = arg_8_0

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

function BossSingleContinuousOperationWindow:UpdateContent()
	local var_9_0 = i18n("multiple_sorties_cost1", self.contextData.oilCost * self.contextData.battleTimes)

	if self.contextData.oilCost * self.contextData.battleTimes > getProxy(PlayerProxy):getRawData().oil then
		var_9_0 = string.gsub(var_9_0, "#92fc63", COLOR_RED)
	end

	self.consumeText.text = var_9_0

	return
end

return BossSingleContinuousOperationWindow
