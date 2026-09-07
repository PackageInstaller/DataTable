local GuildOfficeLogPage = class("GuildOfficeLogPage", import("....base.BaseSubView"))
local var_0_1 = {
	{
		GuildConst.TYPE_SUPPLY,
		GuildConst.START_BATTLE,
		GuildConst.TECHNOLOGY
	},
	{
		GuildConst.TYPE_DONATE,
		GuildConst.WEEKLY_TASK
	},
	{
		GuildConst.TECHNOLOGY_OVER,
		GuildConst.SWITCH_TOGGLE
	}
}

function GuildOfficeLogPage:Flag2Filter(arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(var_0_1) do
		if bit.band(arg_1_1, (bit.lshift(1, iter_1_0))) > 0 then
			for iter_1_2, iter_1_3 in ipairs(iter_1_1) do
				table.insert(var_1_0, iter_1_3)
			end
		end
	end

	return var_1_0
end

function GuildOfficeLogPage:getUIName()
	return "GuildOfficeLogPage"
end

function GuildOfficeLogPage:OnLoaded()
	self.uilist = UIItemList.New(self._tf:Find("frame/window/sliders/list/content"), self._tf:Find("frame/window/sliders/list/content/tpl"))

	setText(self._tf:Find("frame/window/top/bg/infomation/title"), i18n("guild_log_title"))

	self.btnAll = self._tf:Find("frame/window/sliders/filter/1")
	self.btns = {
		self._tf:Find("frame/window/sliders/filter/2"),
		self._tf:Find("frame/window/sliders/filter/3"),
		self._tf:Find("frame/window/sliders/filter/4")
	}

	return
end

function GuildOfficeLogPage:OnInit()
	onButton(self, self._tf:Find("frame/window/top/btnBack"), function()
		self:Close()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("frame"), function()
		self:Close()

		return
	end, SFX_PANEL)
	onButton(self, self.btnAll, function()
		self:SelectAll()

		return
	end, SFX_PANEL)

	for iter_4_0, iter_4_1 in ipairs(self.btns) do
		onButton(self, iter_4_1, function()
			if self.allFlags ~= self.flags and bit.band(self.flags, bit.lshift(1, iter_4_0)) > 0 then
				self:UnSelectFlag(iter_4_0, iter_4_1)
			else
				self:SelectFlag(iter_4_0, iter_4_1)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function GuildOfficeLogPage:SelectAll()
	self.flags = 0

	for iter_9_0, iter_9_1 in pairs(self.btns) do
		setActive(iter_9_1:Find("sel"), false)

		self.flags = bit.bor(self.flags, bit.lshift(1, iter_9_0))
	end

	setActive(self.btnAll:Find("sel"), true)
	self:Filter()

	return
end

function GuildOfficeLogPage:UnSelectFlag(arg_10_1, arg_10_2)
	setActive(arg_10_2:Find("sel"), false)

	local var_10_0 = bit.bxor(self.flags, bit.lshift(1, arg_10_1))

	if var_10_0 == 0 then
		self:SelectAll()
	else
		self.flags = var_10_0

		self:Filter()
	end

	return
end

function GuildOfficeLogPage:SelectFlag(arg_11_1, arg_11_2)
	local function var_11_0()
		setActive(arg_11_2:Find("sel"), true)
		setActive(self.btnAll:Find("sel"), false)

		self.flags = bit.bor(self.flags, bit.lshift(1, arg_11_1))

		self:Filter()

		return
	end

	if self.flags ~= self.allFlags and self.allFlags == bit.bor(self.flags, bit.lshift(1, arg_11_1)) then
		self:SelectAll()
	elseif self.flags == self.allFlags then
		self.flags = 0

		var_11_0()
	else
		var_11_0()
	end

	return
end

function GuildOfficeLogPage:Show(arg_13_1)
	self.guild = arg_13_1

	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setActive(self._tf, true)
	triggerButton(self.btnAll)

	self.allFlags = self.flags

	return
end

function GuildOfficeLogPage:Filter()
	self.displays = {}

	local var_14_0 = self:Flag2Filter(self.flags)

	for iter_14_0, iter_14_1 in ipairs((self.guild:getCapitalLogs())) do
		if iter_14_1:IsSameType(var_14_0) then
			table.insert(self.displays, iter_14_1)
		end
	end

	self.uilist:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			setText(arg_15_2, self.displays[arg_15_1 + 1]:getText())
		end

		return
	end)
	self.uilist:align(#self.displays)

	return
end

function GuildOfficeLogPage:Close()
	setActive(self._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function GuildOfficeLogPage:OnDestroy()
	self:Close()

	return
end

return GuildOfficeLogPage
