local CoreStoryTemplatePage = class("CoreStoryTemplatePage", import("view.activity.CorePage.CoreActivityPage"))

function CoreStoryTemplatePage:OnInit()
	self.bg = self._tf:Find("bg_story")
	self.ad = self._tf:Find("AD")
	self.goBtn = self._tf:Find("AD/go_btn")
	self.scenario = CoreScenarioTemplatePage.New(self._tf)

	self.scenario:SetCoreStoryPage(self)

	self.loader = AutoLoader.New()
	self.mapGroup = {}
	self.currentBG = nil

	return
end

function CoreStoryTemplatePage:OnFirstFlush()
	onButton(self, self.goBtn, function()
		self.scenario:Load()
		self.scenario:SetActivity(self.activity)
		self.scenario:UpdateStoryTask()
		self.scenario:ActionInvoke("UpdateView")
		self:ShowScenarioLayer(true)

		return
	end, SFX_PANEL)

	return
end

function CoreStoryTemplatePage:OnShowFlush()
	CoreStoryTemplatePage.super.OnShowFlush(self)

	if self.coreActivityUI.contextData.activeScenario then
		self.scenario.needFocusStory = true

		triggerButton(self.goBtn)
	end

	return
end

function CoreStoryTemplatePage:SwitchBG(arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_1 or #arg_5_1 <= 0 then
		existCall(arg_5_2)

		return
	elseif arg_5_3 then
		-- block empty
	elseif table.equal(self.currentBG, arg_5_1) then
		return
	end

	self.currentBG = arg_5_1

	for iter_5_0, iter_5_1 in ipairs(self.mapGroup) do
		self.loader:ClearRequest(iter_5_1)
	end

	table.clear(self.mapGroup)
	table.insert(self.mapGroup, (self.loader:GetSpriteDirect("bg/" .. arg_5_1[1].BG, "", function(arg_6_0)
		setImageSprite(self.bg, arg_6_0)
		SetActive(self.bg, true)

		return
	end)))

	return
end

function CoreStoryTemplatePage:ShowScenarioLayer(arg_7_1)
	if arg_7_1 then
		self.scenario:ActionInvoke("Show")
		self.coreActivityUI:ActiveScenarioLayer(true)
		SetActive(self.ad, false)
		SetActive(self.bg, true)
	else
		self.scenario:Hide()
		self.coreActivityUI:ActiveScenarioLayer(false)
		SetActive(self.ad, true)
		SetActive(self.bg, false)
	end

	return
end

function CoreStoryTemplatePage:IsShowingPopWindow()
	return self.scenario:isShowing()
end

function CoreStoryTemplatePage:ClosePopWindow()
	self.scenario:Hide()
	self:ShowScenarioLayer(false)

	return
end

return CoreStoryTemplatePage
