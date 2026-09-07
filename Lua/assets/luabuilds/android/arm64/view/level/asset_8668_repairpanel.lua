local RepairPanel = class("RepairPanel", import("..base.BasePanel"))

function RepairPanel:init()
	RepairPanel.super.init(self)

	self.desc = self._tf:Find("window/desc")
	self.descFree = self._tf:Find("window/text_free")
	self.descCharge = self._tf:Find("window/text_charge")
	self.free = self._tf:Find("window/text_free/time")
	self.charge = self._tf:Find("window/text_charge/time")
	self.diamond = self._tf:Find("window/diamond")
	self.cost = findTF(self.diamond, "cost")
	self.cancel = self._tf:Find("window/actions/cancel_button")
	self.confirm = self._tf:Find("window/actions/use_button")
	self.back = self._tf:Find("top/btnBack")
	self.onConfirm = nil
	self.onCancel = nil

	return
end

function RepairPanel:set(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.repairTimes = arg_2_1
	self.freeTimes = arg_2_2
	self.chargeTimes = arg_2_3
	self.chargeDiamond = arg_2_4

	local var_2_0 = self.freeTimes - math.min(self.repairTimes, self.freeTimes)

	setText(self.free, var_2_0 .. "/" .. self.freeTimes)
	setText(self.charge, self.chargeTimes - (self.repairTimes - (self.freeTimes - var_2_0)) .. "/" .. self.chargeTimes)
	setText(self.cost, self.chargeDiamond)
	setActive(self.descFree, var_2_0 > 0)
	setActive(self.descCharge, var_2_0 <= 0)
	setText(self.desc, i18n("battle_repair_special_tip"))
	setText(self.descFree, i18n("battle_repair_normal_name"))
	setText(self.descCharge, i18n("battle_repair_special_name"))

	local var_2_1 = self.repairTimes < self.freeTimes + self.chargeTimes

	setActive(self.diamond, self.repairTimes < self.freeTimes + self.chargeTimes and self.repairTimes >= self.freeTimes)
	setButtonEnabled(self.confirm, var_2_1)
	setGray(self.confirm, not var_2_1, true)
	onButton(self, self.back, function()
		if self.onCancel then
			self.onCancel()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.cancel, function()
		if self.onCancel then
			self.onCancel()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.confirm, function()
		if self.onConfirm then
			self.onConfirm()
		end

		return
	end, SFX_CONFIRM)

	return
end

return RepairPanel
