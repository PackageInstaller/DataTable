local var_0_0 = class("MainChangeSkinBtn", import(".MainBaseBtn"))

function var_0_0.OnClick(arg_1_0)
	arg_1_0:emit(NewMainScene.ON_CHANGE_SKIN)

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1)
	arg_2_0:UpdateChangeSkinBtn()

	return
end

function var_0_0.UpdateChangeSkinBtn(arg_3_0)
	local var_3_9000
	local var_3_0

	if getProxy(SettingsProxy):IsOpenRandomFlagShip() then
		var_3_0 = _.select(getProxy(SettingsProxy):GetRandomFlagShipList(), function(arg_4_0)
			local var_4_0 = getProxy(BayProxy)

			return var_4_0:GetShipPhantom(arg_4_0) ~= nil
		end)
	else
		local var_3_1 = getProxy(PlayerProxy)

		var_3_0 = var_3_1:getRawData().characters
	end

	local var_3_2 = getProxy(SettingsProxy)
	local var_3_3 = var_3_2.GetFlagShipDisplayMode(var_3_9000)
	local var_3_4 = var_3_3 == FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR and 0 or #var_3_0

	if getProxy(PlayerProxy).getRawData(var_3_2):ExistEducateChar() and var_3_3 ~= FlAG_SHIP_DISPLAY_ONLY_SHIP then
		var_3_4 = var_3_4 + 1
	end

	setActive(arg_3_0._tf, var_3_4 > 1)

	return
end

return var_0_0
