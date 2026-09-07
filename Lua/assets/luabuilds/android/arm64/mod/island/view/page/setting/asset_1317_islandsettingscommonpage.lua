local IslandSettingsCommonPage = class("IslandSettingsCommonPage", import("view.base.BaseSubView"))

function IslandSettingsCommonPage:getUIName()
	return "IslandSettingsCommonPage"
end

function IslandSettingsCommonPage:OnLoaded()
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

function IslandSettingsCommonPage:GetPanels()
	return {
		IslandSettingsCardShowPanel,
		IslandSettingsEscapePanel
	}
end

function IslandSettingsCommonPage:GetPanel(arg_4_1)
	if not self.panels then
		return nil
	end

	return _.detect(self.panels, function(arg_5_0)
		return isa(arg_5_0, arg_4_1)
	end)
end

function IslandSettingsCommonPage:InitPanels()
	local var_6_0 = {}
	local var_6_1 = GetOrAddComponent(self.contentSizeFitter, typeof(CanvasGroup))

	self.scrollrect.enabled = false

	for iter_6_0, iter_6_1 in ipairs(self.panels) do
		table.insert(var_6_0, function(arg_7_0)
			iter_6_1:Init(arg_7_0)

			return
		end)
	end

	seriesAsync(var_6_0, function()
		self.scrollrect.enabled = true

		self:Update()

		return
	end)

	return
end

function IslandSettingsCommonPage:Show()
	self.cg.blocksRaycasts = true
	self.cg.alpha = 1

	return
end

function IslandSettingsCommonPage:Update()
	for iter_10_0, iter_10_1 in ipairs(self.panels) do
		iter_10_1:OnUpdate()
	end

	return
end

function IslandSettingsCommonPage:Hide()
	self.cg.blocksRaycasts = false
	self.cg.alpha = 0

	return
end

function IslandSettingsCommonPage:Save()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self.panels) do
		var_12_0 = table.mergeArray(var_12_0, (iter_12_1:GetFlags()))
	end

	self:emit(IslandMediator.SET_SETTINGS_FLAG, var_12_0)

	return
end

function IslandSettingsCommonPage:OnDestroy()
	for iter_13_0, iter_13_1 in ipairs(self.panels) do
		iter_13_1:Dispose()
	end

	self.panels = nil

	return
end

return IslandSettingsCommonPage
