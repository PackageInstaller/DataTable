local IslandDeviceBaseBtn = class("IslandDeviceBaseBtn", import(".IslandMainBaseBtn"))

function IslandDeviceBaseBtn:Ctor(arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(self)

	self._tf = arg_1_1
	self.event = arg_1_2
	self.configId = arg_1_3
	self.config = pg.island_main_btns[self.configId]
	self.lockTF = self._tf:Find("lock")

	local var_1_0 = self.lockTF:Find("Text")

	if var_1_0 then
		setText(var_1_0, i18n("island_freight_btn_locked"))
	end

	self.unlockTF = self._tf:Find("unlock")
	self.tipTF = self.unlockTF:Find("tip")
	self.nameTF = self._tf:Find("name")

	local var_1_1 = self.nameTF and self.nameTF:GetComponent(typeof(Text))

	if var_1_1 then
		var_1_1.text = self.config.name
	end

	self:Init()

	return
end

function IslandDeviceBaseBtn:CheckCanPressDown()
	if self.configId == 19 and _IslandCore then
		if _IslandCore:GetView():GetController():IsPlayerInTimeline() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_photo_fur_lock"))

			return false
		end
	end

	return true
end

function IslandDeviceBaseBtn:Init()
	onButton(self, self._tf, function()
		if not self:IsUnlock() then
			return
		end

		if not self:CheckCanPressDown() then
			return
		end

		self:OnClick()

		return
	end, SFX_PANEL)

	return
end

function IslandDeviceBaseBtn:UnlockCheck()
	local var_5_0 = self:IsUnlock()

	setActive(self.lockTF, not var_5_0)
	setActive(self.unlockTF, var_5_0)

	if var_5_0 then
		self:FlushDataUI()
	end

	return
end

function IslandDeviceBaseBtn:FlushDataUI()
	return
end

return IslandDeviceBaseBtn
