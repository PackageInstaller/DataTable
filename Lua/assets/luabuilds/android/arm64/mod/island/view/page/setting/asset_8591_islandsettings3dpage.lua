local IslandSettings3DPage = class("IslandSettings3DPage", import("view.base.BaseSubView"))

function IslandSettings3DPage:getUIName()
	return "IslandSettingsCombinationPage"
end

function IslandSettings3DPage:OnLoaded()
	self:OnBindEvent()

	self.panelContainer = self._tf:Find("content")
	self.panels = {}

	for iter_2_0, iter_2_1 in ipairs((self:GetPanels())) do
		table.insert(self.panels, iter_2_1.New(self.panelContainer))
	end

	self.contentSizeFitter = self.panelContainer:GetComponent(typeof(ContentSizeFitter))
	self.cg = self._tf:GetComponent(typeof(CanvasGroup))
	self.scrollrect = self.panelContainer:GetComponent(typeof(ScrollRect))

	self:InitPanels()
	setActive(self._tf, true)

	return
end

function IslandSettings3DPage:OnBindEvent()
	self:bind(IslandSettingsOtherGraphicsPanle.EVT_UPDTAE, function()
		local var_4_0 = self:GetPanel(IslandSettingsOtherGraphicsPanle)

		if var_4_0 then
			var_4_0:RefreshPanelByGraphcLevel()
			self:RebuildLayout(function()
				return
			end)
		end

		return
	end)
	self:bind(IslandSettingsGraphicsPanle.EVT_UPDTAE, function()
		local var_6_0 = self:GetPanel(IslandSettingsGraphicsPanle)

		if var_6_0 then
			var_6_0:OnUpdate()
		end

		return
	end)

	return
end

function IslandSettings3DPage:GetPanels()
	local var_7_0 = {
		IslandSettingsGraphicsPanle,
		IslandSettingsOtherGraphicsPanle
	}

	if self:NeedAdjustScreen() then
		table.insert(var_7_0, 1, IslandSettingsAdjustScreenPanle)
	end

	return var_7_0
end

function IslandSettings3DPage:NeedAdjustScreen()
	return Screen.width / Screen.height - 0.001 > ADAPT_NOTICE
end

function IslandSettings3DPage:GetPanel(arg_9_1)
	if not self.panels then
		return nil
	end

	return _.detect(self.panels, function(arg_10_0)
		return isa(arg_10_0, arg_9_1)
	end)
end

function IslandSettings3DPage:InitPanels()
	local var_11_0 = {}
	local var_11_1 = GetOrAddComponent(self.contentSizeFitter, typeof(CanvasGroup))

	self.scrollrect.enabled = false

	for iter_11_0, iter_11_1 in ipairs(self.panels) do
		table.insert(var_11_0, function(arg_12_0)
			iter_11_1:Init(arg_12_0)

			return
		end)
	end

	seriesAsync(var_11_0, function()
		self.scrollrect.enabled = true

		self:OnInitPanle()

		return
	end)

	return
end

function IslandSettings3DPage:RebuildLayout(arg_14_1)
	onDelayTick(function()
		self.contentSizeFitter.enabled = false
		self.contentSizeFitter.enabled = true

		arg_14_1()

		return
	end, 0.05)

	return
end

function IslandSettings3DPage:OnInitPanle()
	if self.contextData.scroll then
		local var_16_1 = self.contextData.scroll == "world_settings" and self:GetPanel(SettingsWorldPanle) or self:GetPanel(self.contextData.scroll)
		local var_16_2 = self:GetPanel(self.contextData.scroll)

		if var_16_2 then
			self:ScrollToPanel(var_16_2)
		end
	end

	return
end

function IslandSettings3DPage:ScrollToPanel(arg_17_1)
	setAnchoredPosition(self.panelContainer, {
		y = -self.panelContainer:InverseTransformPoint(arg_17_1._tf.position).y
	})

	return
end

function IslandSettings3DPage:OnDestroy()
	for iter_18_0, iter_18_1 in ipairs(self.panels) do
		iter_18_1:Dispose()
	end

	self.panels = nil

	return
end

function IslandSettings3DPage:Show()
	self.cg.blocksRaycasts = true
	self.cg.alpha = 1

	return
end

function IslandSettings3DPage:Hide()
	self.cg.blocksRaycasts = false
	self.cg.alpha = 0

	return
end

return IslandSettings3DPage
