local SettingsOptionPage = class("SettingsOptionPage", import("...base.BaseSubView"))

function SettingsOptionPage:getUIName()
	return "SettingsCombinationPage"
end

function SettingsOptionPage:OnLoaded()
	self:OnBindEvent()

	self.panelContainer = self._tf:Find("content")
	self.panels = {}

	for iter_2_0, iter_2_1 in ipairs((self:GetPanels())) do
		table.insert(self.panels, iter_2_1.New(self.panelContainer))
	end

	self.contentSizeFitter = self.panelContainer:GetComponent(typeof(ContentSizeFitter))
	self.cg = self._tf:GetComponent(typeof(CanvasGroup))
	self.scrollrect = self._tf:Find("content"):GetComponent(typeof(ScrollRect))

	self:InitPanels()
	setActive(self._tf, true)

	return
end

function SettingsOptionPage:OnBindEvent()
	self:bind(SettingsRandomFlagShipAndSkinPanel.EVT_UPDTAE, function()
		local var_4_0 = self:GetPanel(SettingsRandomFlagShipAndSkinPanel)

		if var_4_0 then
			var_4_0:OnRandomFlagshipFlagUpdate()
		end

		return
	end)
	self:bind(SettingsNotificationPanel.UPDATE_ALARM_PANEL, function()
		local var_5_0 = self:GetPanel(SettingsNotificationPanel)

		if var_5_0 then
			var_5_0:UpdateAndroidAlarm()
		end

		return
	end)

	return
end

function SettingsOptionPage:GetPanels()
	local var_6_0 = {
		SettingsFpsPanle,
		SettingsNotificationPanel,
		SettingsWorldPanle,
		SettingsRandomFlagShipAndSkinPanel,
		SettingsStoryAutoPlayPanel,
		SettingsStorySpeedPanel,
		SettingsMainScenePanel,
		SettingsOtherPanel
	}

	if self:NeedAdjustScreen() then
		table.insert(var_6_0, 1, SettingsAdjustScreenPanle)
	end

	if ServerChooseMgr.Inst:IsGatewayPackage() then
		table.insert(var_6_0, 1, SettingsDebugPanel)
	end

	return var_6_0
end

function SettingsOptionPage:NeedAdjustScreen()
	return Screen.width / Screen.height - 0.001 > ADAPT_NOTICE
end

function SettingsOptionPage:GetPanel(arg_8_1)
	if not self.panels then
		return nil
	end

	return _.detect(self.panels, function(arg_9_0)
		return isa(arg_9_0, arg_8_1)
	end)
end

function SettingsOptionPage:InitPanels()
	local var_10_0 = {}
	local var_10_1 = GetOrAddComponent(self.contentSizeFitter, typeof(CanvasGroup))

	self.scrollrect.enabled = false

	for iter_10_0, iter_10_1 in ipairs(self.panels) do
		table.insert(var_10_0, function(arg_11_0)
			iter_10_1:Init(arg_11_0)

			return
		end)
	end

	seriesAsync(var_10_0, function()
		self.scrollrect.enabled = true

		self:OnInitPanle()

		return
	end)

	return
end

function SettingsOptionPage:RebuildLayout(arg_13_1)
	onDelayTick(function()
		self.contentSizeFitter.enabled = false
		self.contentSizeFitter.enabled = true

		arg_13_1()

		return
	end, 0.05)

	return
end

function SettingsOptionPage:OnInitPanle()
	if self.contextData.scroll then
		local var_15_1 = self.contextData.scroll == "world_settings" and self:GetPanel(SettingsWorldPanle) or self:GetPanel(self.contextData.scroll)
		local var_15_2 = self:GetPanel(self.contextData.scroll)

		if var_15_2 then
			self:ScrollToPanel(var_15_2)
		end
	end

	return
end

function SettingsOptionPage:ScrollToPanel(arg_16_1)
	setAnchoredPosition(self.panelContainer, {
		y = -self.panelContainer:InverseTransformPoint(arg_16_1._tf.position).y
	})

	return
end

function SettingsOptionPage:OnDestroy()
	for iter_17_0, iter_17_1 in ipairs(self.panels) do
		iter_17_1:Dispose()
	end

	self.panels = nil

	return
end

function SettingsOptionPage:Show()
	self.cg.blocksRaycasts = true
	self.cg.alpha = 1

	return
end

function SettingsOptionPage:Hide()
	self.cg.blocksRaycasts = false
	self.cg.alpha = 0

	return
end

return SettingsOptionPage
