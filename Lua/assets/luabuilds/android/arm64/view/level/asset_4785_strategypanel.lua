local StrategyPanel = class("StrategyPanel", import("..base.BasePanel"))

function StrategyPanel:init()
	StrategyPanel.super.init(self)

	self.icon = self._tf:Find("window/panel/item/icon_bg/icon")
	self.count = self._tf:Find("window/panel/item/icon_bg/count")
	self.name = self._tf:Find("window/panel/item/name")
	self.desc = self._tf:Find("window/panel/item/desc")
	self.btnCancel = self._tf:Find("window/panel/actions/cancel_button")
	self.btnUse = self._tf:Find("window/panel/actions/use_button")
	self.btnBack = self._tf:Find("top/btnBack")
	self.tips = self._tf:Find("window/panel/tips")
	self.txSwitch = findTF(self.btnUse, "switch")
	self.txUse = findTF(self.btnUse, "use")
	self.onConfirm = nil
	self.onCancel = nil

	return
end

function StrategyPanel:set(arg_2_1)
	self.strategy = arg_2_1

	local var_2_0 = pg.strategy_data_template[arg_2_1.id]

	GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.strategy_data_template[arg_2_1.id].icon, "", self.icon)

	if var_2_0.type == 1 then
		setText(self.count, "")
		setActive(self.tips, true)
		setActive(self.txSwitch, true)
		setActive(self.txUse, false)
	else
		setText(self.count, arg_2_1.count)
		setActive(self.tips, false)
		setActive(self.txSwitch, false)
		setActive(self.txUse, true)
	end

	setText(self.name, var_2_0.name)
	setText(self.desc, var_2_0.desc)
	onButton(self, self.btnBack, function()
		if self.onCancel then
			self.onCancel()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.btnCancel, function()
		if self.onCancel then
			self.onCancel()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.btnUse, function()
		if self.onConfirm then
			self.onConfirm()
		end

		return
	end, SFX_CONFIRM)

	return
end

return StrategyPanel
