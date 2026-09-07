local SettingsRandomFlagShipAndSkinPanel = class("SettingsRandomFlagShipAndSkinPanel", import(".SettingsBasePanel"))

SettingsRandomFlagShipAndSkinPanel.EVT_UPDTAE = "SettingsRandomFlagShipAndSkinPanel:EVT_UPDTAE"
SettingsRandomFlagShipAndSkinPanel.SHIP_FREQUENTLYUSED = 1
SettingsRandomFlagShipAndSkinPanel.SHIP_LOCKED = 2
SettingsRandomFlagShipAndSkinPanel.COUSTOM = 3

function SettingsRandomFlagShipAndSkinPanel:GetUIName()
	return "RandomFlagShipAndSkin"
end

function SettingsRandomFlagShipAndSkinPanel:GetTitle()
	return i18n("random_ship_and_skin_title")
end

function SettingsRandomFlagShipAndSkinPanel:GetTitleEn()
	return "                                                                                      / RANDOM RANGE"
end

function SettingsRandomFlagShipAndSkinPanel:OnInit()
	self.subTitleTxt = self._tf:Find("title"):GetComponent(typeof(Text))
	self.shipToggles = {
		[SettingsRandomFlagShipAndSkinPanel.SHIP_FREQUENTLYUSED] = self._tf:Find("1"),
		[SettingsRandomFlagShipAndSkinPanel.SHIP_LOCKED] = self._tf:Find("2"),
		[SettingsRandomFlagShipAndSkinPanel.COUSTOM] = self._tf:Find("3")
	}
	self.shipToggleTxts = {
		[SettingsRandomFlagShipAndSkinPanel.SHIP_FREQUENTLYUSED] = i18n("random_ship_frequse_mode"),
		[SettingsRandomFlagShipAndSkinPanel.SHIP_LOCKED] = i18n("random_ship_locked_mode"),
		[SettingsRandomFlagShipAndSkinPanel.COUSTOM] = i18n("random_ship_custom_mode")
	}
	self.editBtn = findTF(self._tf, "edit_btn")

	self:UpdateSelected()
	self:InitToggles()

	return
end

function SettingsRandomFlagShipAndSkinPanel:InitToggles()
	for iter_5_0, iter_5_1 in pairs(self.shipToggles) do
		onToggle(self, iter_5_1, function(arg_6_0)
			if arg_6_0 then
				self:UpdateShipRandomMode(iter_5_0)
			end

			return
		end, SFX_PANEL)
		setText(iter_5_1:Find("Text"), self.shipToggleTxts[iter_5_0])
	end

	onButton(self, self.editBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.RANDOM_DOCKYARD)

		return
	end, SFX_PANEL)

	return
end

function SettingsRandomFlagShipAndSkinPanel:UpdateShipRandomMode(arg_8_1)
	if arg_8_1 == SettingsRandomFlagShipAndSkinPanel.COUSTOM and not self.refreshFlag then
		if #getProxy(BayProxy):getRandomFlagShipPhantomMarks() == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_custom_mode_empty"))
		end
	end

	self.refreshFlag = nil

	if self.randomFlagShipMode ~= arg_8_1 then
		pg.m02:sendNotification(GAME.CHANGE_RANDOM_SHIP_MODE, {
			mode = arg_8_1
		})
	end

	return
end

function SettingsRandomFlagShipAndSkinPanel:UpdateSelected()
	local var_9_0 = getProxy(PlayerProxy):getRawData():GetRandomFlagShipMode()

	self.randomFlagShipMode = var_9_0

	triggerToggle(self.shipToggles[var_9_0], true)

	return
end

function SettingsRandomFlagShipAndSkinPanel:OnRandomFlagshipFlagUpdate()
	self.refreshFlag = true

	self:UpdateSelected()

	return
end

return SettingsRandomFlagShipAndSkinPanel
