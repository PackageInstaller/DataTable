local MainChangeSkinBtn = class("MainChangeSkinBtn", import(".MainBaseBtn"))

function MainChangeSkinBtn:OnClick()
	self:emit(NewMainScene.ON_CHANGE_SKIN)

	return
end

function MainChangeSkinBtn:Flush(arg_2_1)
	self:UpdateChangeSkinBtn()

	return
end

function MainChangeSkinBtn:UpdateChangeSkinBtn()
	local var_3_0 = getProxy(SettingsProxy):IsOpenRandomFlagShip() and _.select(getProxy(SettingsProxy):GetRandomFlagShipList(), function(arg_4_0)
		return getProxy(BayProxy):GetShipPhantom(arg_4_0) ~= nil
	end) or getProxy(PlayerProxy):getRawData().characters
	local var_3_1 = getProxy(SettingsProxy)
	local var_3_2 = var_3_1:GetFlagShipDisplayMode()
	local var_3_3 = var_3_2 == FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR and 0 or #var_3_0

	if getProxy(PlayerProxy).getRawData(var_3_1):ExistEducateChar() and var_3_2 ~= FlAG_SHIP_DISPLAY_ONLY_SHIP then
		var_3_3 = var_3_3 + 1
	end

	setActive(self._tf, var_3_3 > 1)

	return
end

return MainChangeSkinBtn
