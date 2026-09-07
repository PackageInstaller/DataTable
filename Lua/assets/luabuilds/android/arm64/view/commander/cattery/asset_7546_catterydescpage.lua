local CatteryDescPage = class("CatteryDescPage", import("...base.BaseSubView"))

CatteryDescPage.CHANGE_STYLE = "CatteryDescPage:CHANGE_STYLE"
CatteryDescPage.CHANGE_COMMANDER = "CatteryDescPage:CHANGE_COMMANDER"

function CatteryDescPage:getUIName()
	return "CatteryDescPage"
end

function CatteryDescPage:OnCatteryUpdate(arg_2_1)
	self:Flush(arg_2_1)

	if self.page and self.page:GetLoaded() and self.page:isShowing() then
		self.page:OnCatteryUpdate(arg_2_1)
	end

	return
end

function CatteryDescPage:OnCatteryStyleUpdate(arg_3_1)
	self.cattery = arg_3_1

	self:UpdateCatteryStyle()

	if self.page and self.page:GetLoaded() and self.page:isShowing() and isa(self.page, CommanderHomeSelCatteryStylePage) then
		self.page:OnCatteryStyleUpdate(arg_3_1)
	end

	return
end

function CatteryDescPage:OnLoaded()
	self.closeBtn = self._tf:Find("right/close_btn")
	self.styleIcon = self._tf:Find("left/bg/mask/icon"):GetComponent(typeof(Image))
	self.char = self._tf:Find("left/bg/char")
	self.commanderEmpty = self._tf:Find("left/bg/info/empty")
	self.styleInfo = self.commanderEmpty
	self.commanderExp = self._tf:Find("left/bg/info/commander_exp")
	self.commanderLevelTxt = self.commanderExp:Find("level/Text"):GetComponent(typeof(Text))
	self.commanderExpTxt = self.commanderExp:Find("value_bg/Text"):GetComponent(typeof(Text))
	self.commanderExpImg = self.commanderExp:Find("exp/Image")
	self.pageContainer = self._tf:Find("")
	self.toggleGroup = self._tf:Find("left/tags"):GetComponent(typeof(ToggleGroup))
	self.pagesTF = self._tf:Find("right/pages")
	self.tags = {
		self._tf:Find("left/tags/commander"),
		self._tf:Find("left/tags/home")
	}
	self.pages = {
		CommanderHomeSelCommanderPage.New(self.pagesTF, self.event),
		CommanderHomeSelCatteryStylePage.New(self.pagesTF, self.event)
	}

	return
end

function CatteryDescPage:OnInit()
	self:bind(CatteryDescPage.CHANGE_STYLE, function(arg_6_0, arg_6_1)
		self:PreviewCatteryStyle(arg_6_1)

		return
	end, SFX_PANEL)
	self:bind(CatteryDescPage.CHANGE_COMMANDER, function(arg_7_0, arg_7_1)
		self:PreviewCatteryCommader(arg_7_1)

		return
	end)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	for iter_5_0, iter_5_1 in ipairs(self.tags) do
		onToggle(self, iter_5_1, function(arg_10_0)
			if arg_10_0 then
				self:SwitchPage(iter_5_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function CatteryDescPage:SwitchPage(arg_11_1)
	if self.page == self.pages[arg_11_1] then
		return
	end

	if self.page then
		self.page:Hide()
	end

	self.pages[arg_11_1]:ExecuteAction("Update", self.home, self.cattery)

	self.page = self.pages[arg_11_1]

	local var_11_0 = isa(self.pages[arg_11_1], CommanderHomeSelCatteryStylePage)

	setActive(self.commanderEmpty, var_11_0)
	setActive(self.commanderExp, not var_11_0)
	self:FlushCatteryInfo()

	return
end

function CatteryDescPage:Update(arg_12_1, arg_12_2)
	self:Show()

	self.home = arg_12_1
	self.cattery = arg_12_2
	self.page = nil

	triggerToggle(self.tags[1], true)

	if arg_12_2 then
		self:Flush(arg_12_2)
	end

	return
end

function CatteryDescPage:Show()
	CatteryDescPage.super.Show(self)
	self:emit(CommanderHomeLayer.DESC_PAGE_OPEN)

	return
end

function CatteryDescPage:Flush(arg_14_1)
	self.cattery = arg_14_1

	self:FlushCatteryInfo()
	self:UpdateCatteryStyle()

	return
end

function CatteryDescPage:FlushCatteryInfo()
	if isa(self.page, CommanderHomeSelCommanderPage) then
		local var_15_1 = self.cattery:ExistCommander()
	end

	self:UpdateCommander(self.cattery:GetCommander())

	return
end

function CatteryDescPage:UpdateCommander(arg_16_1)
	local var_16_0 = arg_16_1 ~= nil

	self:ReturnChar()

	if var_16_0 then
		self:LoadChar(arg_16_1)

		self.commanderLevelTxt.text = "LV." .. arg_16_1:getLevel()

		if arg_16_1:isMaxLevel() then
			self.commanderExpTxt.text = "MAX"

			setFillAmount(self.commanderExpImg, 1)
		else
			self.commanderExpTxt.text = "<color=#92FC63FF>" .. arg_16_1.exp .. "</color>/" .. arg_16_1:getNextLevelExp()

			setFillAmount(self.commanderExpImg, arg_16_1.exp / arg_16_1:getNextLevelExp())
		end
	end

	setActive(self.commanderExp, var_16_0)
	setActive(self.commanderEmpty, not var_16_0)

	return
end

function CatteryDescPage:PreviewCatteryCommader(arg_17_1)
	self:UpdateCommander(arg_17_1)

	return
end

function CatteryDescPage:UpdateCatteryStyle()
	local var_18_0 = self.cattery:_GetStyle_()

	self.styleIcon.sprite = self.cattery:ExistCommander() and GetSpriteFromAtlas("CatteryStyle/" .. var_18_0:GetName(self.cattery:IsDirty()), "") or GetSpriteFromAtlas("CatteryStyle/" .. var_18_0:GetName(false), "")

	return
end

function CatteryDescPage:PreviewCatteryStyle(arg_19_1)
	self.styleIcon.sprite = GetSpriteFromAtlas("CatteryStyle/" .. pg.commander_home_style[arg_19_1].name, "")

	return
end

function CatteryDescPage:LoadChar(arg_20_1)
	self.painting = arg_20_1:getPainting()

	setCommanderPaintingPrefab(self.char, self.painting, "info")

	return
end

function CatteryDescPage:ReturnChar()
	if self.painting then
		retCommanderPaintingPrefab(self.char, self.painting)

		self.painting = nil
	end

	return
end

function CatteryDescPage:Hide()
	self:emit(CommanderHomeLayer.DESC_PAGE_CLOSE)
	self.toggleGroup:SetAllTogglesOff()
	CatteryDescPage.super.Hide(self)

	for iter_22_0, iter_22_1 in pairs(self.pages) do
		if iter_22_1:GetLoaded() and iter_22_1:isShowing() then
			iter_22_1:Hide()
		end
	end

	return
end

function CatteryDescPage:OnDestroy()
	self:ReturnChar()

	for iter_23_0, iter_23_1 in ipairs(self.pages) do
		iter_23_1:Destroy()
	end

	return
end

return CatteryDescPage
