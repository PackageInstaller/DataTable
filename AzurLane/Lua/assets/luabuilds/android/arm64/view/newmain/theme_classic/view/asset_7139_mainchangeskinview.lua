class = var_0_10000

local var_0_0 = "MainChangeSkinView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.MainBaseView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	ChangeSkinToggle = var_3

	local var_1_0 = var_3.New

	findTF = var_5
	arg_1_0._changeSkinToggle = var_1_0(var_5(arg_1_1, "toggleUI"))

	local var_1_1 = arg_1_0._changeSkinToggle

	var_3.SetAsmrTurnning(var_1_1, true)

	arg_1_0.inChange = false
	arg_1_0._parentTF = arg_1_0._tf.parent
	arg_1_0._anchoredPosition = arg_1_0._tf.anchoredPosition
	onButton = var_3

	local var_1_2 = arg_1_0

	findTF = var_6

	local var_1_3 = var_6(arg_1_0._tf, "click")

	local function var_1_4()
		if arg_1_0.inChange then
			return
		end

		local var_2_0 = arg_1_0._changeSkinToggle

		if var_0.IsAsmrSkin(var_2_0) then
			getProxy = var_0
			SettingsProxy = var_2_0

			local var_2_1 = var_0(var_2_0)
			local var_2_2 = var_0.setCharacterSetting

			var_2_10003 = arg_1_0._flagShip.id
			SHIP_FLAG_L2D = var_2_10004

			var_2_2(var_2_1, var_2_10003, var_2_10004, true)

			getProxy = var_2_2
			SettingsProxy = var_2_1

			local var_2_3 = var_2_2(var_2_1)
			local var_2_4 = var_0.setCharacterSetting

			var_2_10003 = arg_1_0._flagShip.id
			SHIP_FLAG_SP = var_2_10004

			var_2_4(var_2_3, var_2_10003, var_2_10004, true)
		end

		arg_1_0.inChange = true

		local var_2_5 = arg_1_0.event
		local var_2_6 = var_0.emit

		NewMainMediator = var_2_10003

		local var_2_7 = var_2_10003.CHANGE_SKIN_TOGGLE
		local var_2_8 = {}
		local var_2_9 = arg_1_0._flagShip

		var_2_8.skin_id = var_5.getSkinId(var_2_9)

		var_2_6(var_2_5, var_2_7, var_2_8)

		return
	end

	SFX_CONFIRM = var_8

	var_3(var_1_2, var_1_3, var_1_4, var_8)

	return
end

function var_0_1.Init(arg_3_0, arg_3_1)
	arg_3_0._flagShip = arg_3_1

	arg_3_0:updateUI()

	return
end

function var_0_1.Refresh(arg_4_0, arg_4_1)
	arg_4_0.inChange = false
	arg_4_0._flagShip = arg_4_1

	arg_4_0:updateUI()

	return
end

function var_0_1.updateUI(arg_5_0)
	local var_5_0 = arg_5_0._flagShip
	local var_5_1 = var_1.getSkinId(var_5_0)

	ShipSkin = var_1_10002

	if not var_1_10002.GetChangeSkinGroupId(var_5_1) then
		setActive = var_5_0

		var_5_0(arg_5_0._tf, false)
	else
		setActive = var_5_0

		var_5_0(arg_5_0._tf, true)
	end

	if arg_5_0._changeSkinToggle and var_2 and var_2 > 0 then
		local var_5_2 = arg_5_0._changeSkinToggle
		local var_5_3 = var_3.setShipData
		local var_5_4 = var_5_1
		local var_5_5 = arg_5_0._flagShip

		var_5_3(var_5_2, var_5_4, var_7.GetShipPhantomMark(var_5_5))
	end

	if arg_5_0._asmrTurnningParent then
		ShipSkin = var_3

		local var_5_6

		if var_3.GetChangeSkinCustomDataId(var_5_1, "asmr") == 1 and true or false then
			setParent = var_5_6

			var_5_6(arg_5_0._tf, arg_5_0._asmrTurnningParent)

			var_5_6 = arg_5_0._tf
			Vector2 = var_5
			var_5_6.anchoredPosition = var_5(0, 0)
		else
			setParent = var_5_6

			var_5_6(arg_5_0._tf, arg_5_0._parentTF)

			arg_5_0._tf.anchoredPosition = arg_5_0._anchoredPosition
		end
	end

	return
end

function var_0_1.SetAsmrTurnningParent(arg_6_0, arg_6_1)
	arg_6_0._asmrTurnningParent = arg_6_1

	return
end

function var_0_1.Dispose(arg_7_0)
	var_0_1.super.Dispose(arg_7_0)

	arg_7_0._asmrTurnningParent = nil

	return
end

return var_0_1
