local CommanderHomeBaseSelPage = class("CommanderHomeBaseSelPage", import("view.base.BaseSubView"))

function CommanderHomeBaseSelPage:OnLoaded()
	self.scrollrect = self._tf:Find("scrollrect"):GetComponent("LScrollRect")
	self.okBtn = self._tf:Find("ok_button")

	setActive(self._tf, true)

	return
end

function CommanderHomeBaseSelPage:OnInit()
	self.cards = {}

	function self.scrollrect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function CommanderHomeBaseSelPage:OnInitItem(arg_5_1)
	local var_5_0 = CommanderCard.New(arg_5_1)

	onButton(self, var_5_0._tf, function()
		self:OnSelected(var_5_0)

		return
	end, SFX_PANEL)

	self.cards[arg_5_1] = var_5_0

	return
end

function CommanderHomeBaseSelPage:OnUpdateItem(arg_7_1, arg_7_2)
	local var_7_0 = self.cards[arg_7_2]

	if not self.cards[arg_7_2] then
		self:OnInitItem(arg_7_2)

		var_7_0 = self.cards[arg_7_2]
	end

	local var_7_1 = arg_7_1 + 1

	var_7_0:update(self.displays[arg_7_1 + 1])
	setActive(var_7_0._tf:Find("line"), var_7_1 % 4 == 1)

	return
end

function CommanderHomeBaseSelPage:Update()
	self:Show()

	self.displays = {}

	for iter_8_0, iter_8_1 in pairs((getProxy(CommanderProxy):getData())) do
		table.insert(self.displays, iter_8_1)
	end

	local var_8_0 = getProxy(FleetProxy):getCommandersInFleet()

	table.sort(self.displays, function(arg_9_0, arg_9_1)
		local var_9_0 = table.contains(var_8_0, arg_9_0.id) and 1 or 0
		local var_9_1 = table.contains(var_8_0, arg_9_1.id) and 1 or 0

		if var_9_0 == var_9_1 then
			return arg_9_0.level > arg_9_1.level
		else
			return var_9_1 < var_9_0
		end

		return
	end)

	for iter_8_2 = 1, 8 - #self.displays do
		table.insert(self.displays, false)
	end

	self.scrollrect:SetTotalCount(#self.displays, -1)

	return
end

function CommanderHomeBaseSelPage:OnDestroy()
	for iter_10_0, iter_10_1 in pairs(self.cards) do
		iter_10_1:clear()
	end

	return
end

function CommanderHomeBaseSelPage:OnSelected()
	return
end

return CommanderHomeBaseSelPage
