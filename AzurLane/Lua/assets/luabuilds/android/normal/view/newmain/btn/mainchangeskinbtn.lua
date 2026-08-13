class = var_0_10000

local var_0_0 = "MainChangeSkinBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseBtn"))

function var_0_1.OnClick(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.emit

	NewMainScene = var_1_10003

	var_1_1(var_1_0, var_1_10003.ON_CHANGE_SKIN)

	return
end

function var_0_1.Flush(arg_2_0, arg_2_1)
	arg_2_0:UpdateChangeSkinBtn()

	return
end

function var_0_1.UpdateChangeSkinBtn(arg_3_0)
	local var_3_0

	getProxy = var_1_10002
	SettingsProxy = var_1_10003

	local var_3_1 = var_1_10002(var_1_10003)
	local var_3_2

	if var_2.IsOpenRandomFlagShip(var_3_1) then
		_ = var_3_2
		var_3_2 = var_3_2.select
		getProxy = var_3_1
		SettingsProxy = var_1_10004
		var_1_10004 = var_3_1(var_1_10004)
		var_3_0 = var_3_2(var_3_1.GetRandomFlagShipList(var_1_10004), function(arg_4_0)
			getProxy = var_2_10001
			BayProxy = var_2_10002

			local var_4_0 = var_2_10001(var_2_10002)

			return var_1.GetShipPhantom(var_4_0, arg_4_0) ~= nil
		end)
	else
		getProxy = var_3_2
		PlayerProxy = var_3_1
		var_3_1 = var_3_2(var_3_1)
		var_3_0 = var_3_2.getRawData(var_3_1).characters
	end

	getProxy = var_3_2
	SettingsProxy = var_3_1

	local var_3_3 = var_3_2(var_3_1)
	local var_3_4 = var_2.GetFlagShipDisplayMode(var_3_3)

	FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR = var_3_3

	local var_3_5 = var_3_4 == var_3_3 and 0 or #var_3_0

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_3_6 = var_1_10004(var_1_10005)
	local var_3_7 = var_4.getRawData(var_3_6)

	if var_4.ExistEducateChar(var_3_7) then
		FlAG_SHIP_DISPLAY_ONLY_SHIP = var_4

		if var_3_4 ~= var_4 then
			var_3_5 = var_3_5 + 1
		end
	end

	setActive = var_4

	var_4(arg_3_0._tf, var_3_5 > 1)

	return
end

return var_0_1
