local SettingsResRepairBtn = class("SettingsResRepairBtn")

function SettingsResRepairBtn:InitTpl(arg_1_1)
	self._tf = cloneTplTo(arg_1_1.tpl, arg_1_1.container, "REPAIR")
	self._go = self._tf.gameObject

	setImageSprite(self._tf:Find("icon"), arg_1_1.iconSP)

	return
end

function SettingsResRepairBtn:Ctor(arg_2_1)
	self:InitTpl(arg_2_1)
	pg.DelegateInfo.New(self)

	self.Progress = self._tf:Find("progress")
	self.ProgressHandle = self._tf:Find("progress/handle")
	self.Info1 = self._tf:Find("status")
	self.Info2 = self._tf:Find("version")
	self.LabelNew = self._tf:Find("version/new")
	self.Dot = self._tf:Find("new")
	self.Loading = self._tf:Find("loading")

	setText(self._tf:Find("title"), i18n("repair_setting_label"))

	local var_2_0 = false

	setActive(self._tf:Find("BG"), not var_2_0)
	setActive(self._tf:Find("BGDel"), var_2_0)

	local var_2_1 = self._tf:Find("version")

	setAnchoredPosition(self._tf:Find("status"), var_2_0 and {
		y = -106
	} or {
		y = -135
	})
	setAnchoredPosition(var_2_1, var_2_0 and {
		y = -160
	} or {
		y = -198
	})
	self:Init()

	return
end

function SettingsResRepairBtn:Init()
	self:UpdateRepairStatus()
	onButton(self, self._tf, function()
		pg.RepairResMgr.GetInstance():Repair()

		return
	end, SFX_PANEL)
	setActive(findTF(self._tf, "DelBtn"), false)

	return
end

function SettingsResRepairBtn:UpdateRepairStatus()
	setSlider(self.Progress, 0, 1, 0)
	setActive(self.Dot, false)
	setActive(self.Loading, false)
	setText(self.Info1, (i18n("word_files_repair")))
	setText(self.Info2, "")

	local var_5_0 = 1

	setSlider(self.Progress, 0, 1, 1)
	setActive(self.ProgressHandle, var_5_0 ~= 0 and var_5_0 ~= 1)
	setActive(self.Dot, false)
	setActive(self.Loading, false)
	setActive(self.LabelNew, false)

	return
end

function SettingsResRepairBtn:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return SettingsResRepairBtn
