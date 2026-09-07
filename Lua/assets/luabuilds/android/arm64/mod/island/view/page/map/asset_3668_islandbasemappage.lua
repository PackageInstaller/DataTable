local IslandBaseMapPage = class("IslandBaseMapPage", import("...base.IslandBasePage"))

IslandBaseMapPage.HIDE_DESC = "IslandBaseMapPage:HIDE_DESC"
IslandBaseMapPage.CLOSE = "IslandBaseMapPage:CLOSE"

function IslandBaseMapPage:getUIName()
	return "IslandMapUI"
end

function IslandBaseMapPage:OnLoaded()
	self.maps = {}
	self.bg = self._tf:Find("bg")

	self:InitMaps()
	setText(self._tf:Find("adapt/title/Text"), i18n("island_map_title"))

	return
end

function IslandBaseMapPage:InitMaps()
	eachChild(self.bg, function(arg_4_0)
		if arg_4_0.name:sub(-1) ~= "$" then
			self.maps[tonumber(arg_4_0.name)] = arg_4_0
		end

		return
	end)

	return
end

function IslandBaseMapPage:OnInit()
	for iter_5_0, iter_5_1 in pairs(self.maps) do
		onButton(self, iter_5_1, function()
			if not self:CheckUnlock(iter_5_0) then
				return
			end

			self:ShowDesc(iter_5_0)

			return
		end, SFX_PANEL)
	end

	onButton(self, self._tf:Find("bg"), function()
		if self.selectedId then
			self:HideSelected()
		end

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("adapt/back"), function()
		self:ClosePage(self.class)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("adapt/home"), function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	self:bind(IslandBaseMapPage.HIDE_DESC, function()
		self:HideSelected()

		return
	end)
	self:bind(IslandBaseMapPage.CLOSE, function()
		self:ClosePage(self.class)

		return
	end)

	return
end

function IslandBaseMapPage:OnShow()
	self:Flush()

	return
end

function IslandBaseMapPage:Flush()
	for iter_13_0, iter_13_1 in pairs(self.maps) do
		setActive(iter_13_1:Find("selcted"), false)

		local var_13_0 = self:CheckUnlock(iter_13_0)

		setActive(iter_13_1:Find("lock"), not var_13_0)
		setActive(iter_13_1:Find("full"), false)
		setActive(iter_13_1:Find("finish"), false)
		setActive(iter_13_1:Find("fetch"), false)
		setActive(iter_13_1:Find("icon"), var_13_0)
	end

	return
end

function IslandBaseMapPage:CheckUnlock(arg_14_1)
	return (self:GetIsland():GetAblityAgency():IsUnlockMap(arg_14_1))
end

function IslandBaseMapPage:ShowDesc(arg_15_1)
	if self.selectedId then
		self:HideSelected(self.selectedId)
	end

	setActive(self.maps[arg_15_1]:Find("selcted"), true)
	self:GoDesc(arg_15_1)

	self.selectedId = arg_15_1

	return
end

function IslandBaseMapPage:HideSelected()
	if self.maps[self.selectedId] == nil then
		return
	end

	local var_16_0 = self.maps[self.selectedId]:Find("selcted")

	dftAniEvent = var_16_0:GetComponent(typeof(DftAniEvent))

	dftAniEvent:SetEndEvent(function()
		dftAniEvent:SetEndEvent(nil)
		setActive(var_16_0, false)

		return
	end)
	var_16_0:GetComponent(typeof(Animation)):Play("IslandMapUI_selectedout")

	self.selectedId = nil

	return
end

function IslandBaseMapPage:GoDesc(arg_18_1)
	self:OpenPage(IslandBaseMapDescPage, arg_18_1)

	return
end

return IslandBaseMapPage
