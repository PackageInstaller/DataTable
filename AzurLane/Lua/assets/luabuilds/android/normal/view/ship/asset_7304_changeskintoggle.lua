class = var_0_10000

local var_0_0 = var_0_10000("ChangeSkinToggle")
local var_0_1 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0._toggles = {}
	arg_1_0._toggleTfs = {}

	for iter_1_0 = 1, var_0_1 do
		findTF = var_1_10006
		var_1_10006 = var_1_10006(arg_1_0._tf, "ad/toggle/" .. iter_1_0)
		GetComponent = var_7

		local var_1_0 = var_1_10006

		typeof = var_9
		Toggle = var_1_10010

		local var_1_1 = var_7(var_1_0, var_9(var_1_10010))

		var_1_1.isOn = false
		table = var_8

		var_8.insert(arg_1_0._toggles, var_1_1)

		table = var_8

		var_8.insert(arg_1_0._toggleTfs, var_1_10006)
	end

	findTF = var_2
	arg_1_0._toggleContainer = var_2(arg_1_0._tf, "ad/toggle")
	findTF = var_2
	arg_1_0._asmrContainer = var_2(arg_1_0._tf, "ad/asmr")

	arg_1_0:UpdateVisible(false)

	arg_1_0._asmrTurnning = false

	return
end

function var_0_0.setShipData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._skinId = arg_2_1
	ShipSkin = var_1_10003

	local var_2_0 = var_1_10003.GetChangeSkinGroupId(arg_2_0._skinId)

	ShipSkin = var_4

	local var_2_1 = var_4.GetStoreChangeSkinId(var_2_0, arg_2_2)

	arg_2_0._toggleIndex = 1

	if var_2_1 then
		ShipSkin = var_5
		arg_2_0._toggleIndex = var_5.GetChangeSkinIndex(var_2_1)
	end

	ShipSkin = var_5
	arg_2_0._nextSkinId = var_5.GetChangeSkinNextId(arg_2_0._skinId)

	arg_2_0:UpdateVisible(true)
	arg_2_0:updateUI()

	return
end

function var_0_0.setSkinData(arg_3_0, arg_3_1)
	arg_3_0._skinId = arg_3_1
	ShipSkin = var_1_10002
	arg_3_0._toggleIndex = var_1_10002.GetChangeSkinIndex(arg_3_1)
	ShipSkin = var_2
	arg_3_0._nextSkinId = var_2.GetChangeSkinNextId(arg_3_0._skinId)

	arg_3_0:UpdateVisible(true)
	arg_3_0:updateUI()

	return
end

function var_0_0.updateUI(arg_4_0)
	for iter_4_0 = 1, #arg_4_0._toggles do
		local var_4_0 = arg_4_0._toggles[iter_4_0]
		local var_4_1 = arg_4_0._toggleTfs[iter_4_0]

		var_4_0.isOn = iter_4_0 == arg_4_0._toggleIndex and true or false
		setActive = var_7
		findTF = var_1_10008

		var_7(var_1_10008(var_4_1, "bg"), var_4_0.isOn)
	end

	arg_4_0:updateToggleUI()
	arg_4_0:updateAsmrUI()

	return
end

function var_0_0.updateToggleUI(arg_5_0)
	ShipSkin = var_1_10001

	local var_5_0

	if not var_1_10001.GetChangeSkinCustomDataId(arg_5_0._skinId, "toggle_skin") then
		var_5_0 = 1
	end

	for iter_5_0 = 1, #arg_5_0._toggleTfs do
		local var_5_1 = arg_5_0._toggleTfs[iter_5_0]
		local var_5_2 = arg_5_0
		local var_5_3 = arg_5_0.setChildVisible

		findTF = var_1_10009

		var_5_3(var_5_2, var_1_10009(var_5_1, "bg"), false)

		findTF = var_5_3

		local var_5_4 = var_5_3(var_5_1, "bg/Checkmark_" .. var_5_0)

		setActive = var_8

		var_8(var_5_4, true)

		pg = var_8

		local var_5_5 = var_8.ship_skin_template[arg_5_0._skinId].tag

		pg = var_1_10009
		var_1_10009 = var_1_10009.ship_skin_template[arg_5_0._nextSkinId].tag

		local var_5_6

		if iter_5_0 == arg_5_0._toggleIndex then
			setActive = var_10
			findTF = var_5_6
			var_5_6 = var_5_6(var_5_4, "l2d")
			table = var_12

			local var_5_7 = var_12.contains
			local var_5_8 = var_5_5

			ShipSkin = var_1_10014

			local var_5_9

			if not var_5_7(var_5_8, var_1_10014.WITH_LIVE2D) then
				table = var_5_9
				var_5_9 = var_5_9.contains

				local var_5_10 = var_5_5

				ShipSkin = var_1_10014
				var_5_9 = var_5_9(var_5_10, var_1_10014.WITH_LIVE2D_PLUS)
			end

			var_10(var_5_6, var_5_9)

			setActive = var_10
			findTF = var_5_6
			var_5_6 = var_5_6(var_5_4, "spine")
			table = var_12

			local var_5_11 = var_12.contains
			local var_5_12 = var_5_5

			ShipSkin = var_1_10014

			local var_5_13

			if not var_5_11(var_5_12, var_1_10014.WITH_SPINE) then
				table = var_5_13
				var_5_13 = var_5_13.contains

				local var_5_14 = var_5_5

				ShipSkin = var_1_10014
				var_5_13 = var_5_13(var_5_14, var_1_10014.WITH_SPINE_PLUS)
			end

			var_10(var_5_6, var_5_13)
		else
			setActive = var_10
			findTF = var_5_6

			local var_5_15 = var_5_6(var_5_1, "tag/l2d")

			table = var_12

			local var_5_16 = var_12.contains
			local var_5_17 = var_1_10009

			ShipSkin = var_1_10014

			local var_5_18

			if not var_5_16(var_5_17, var_1_10014.WITH_LIVE2D) then
				table = var_5_18
				var_5_18 = var_5_18.contains

				local var_5_19 = var_1_10009

				ShipSkin = var_1_10014
				var_5_18 = var_5_18(var_5_19, var_1_10014.WITH_LIVE2D_PLUS)
			end

			var_10(var_5_15, var_5_18)

			setActive = var_10
			findTF = var_5_15

			local var_5_20 = var_5_15(var_5_1, "tag/spine")

			table = var_12

			local var_5_21 = var_12.contains
			local var_5_22 = var_1_10009

			ShipSkin = var_1_10014

			local var_5_23

			if not var_5_21(var_5_22, var_1_10014.WITH_SPINE) then
				table = var_5_23
				var_5_23 = var_5_23.contains

				local var_5_24 = var_1_10009

				ShipSkin = var_1_10014
				var_5_23 = var_5_23(var_5_24, var_1_10014.WITH_SPINE_PLUS)
			end

			var_10(var_5_20, var_5_23)
		end
	end

	setActive = var_2

	var_2(arg_5_0._toggleContainer, not arg_5_0:IsAsmrSkin())

	return
end

function var_0_0.updateAsmrUI(arg_6_0)
	setActive = var_1_10001

	var_1_10001(arg_6_0._asmrContainer, arg_6_0:IsAsmrSkin())

	ShipSkin = var_1_10001

	local var_6_0 = var_1_10001.GetChangeSkinCustomDataId(arg_6_0._skinId, "asmr") == 1

	setActive = var_2
	findTF = var_3

	var_2(var_3(arg_6_0._asmrContainer, "on"), var_6_0)

	setActive = var_2
	findTF = var_3

	var_2(var_3(arg_6_0._asmrContainer, "off"), not var_6_0)

	return
end

function var_0_0.setChildVisible(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0 = 1, arg_7_1.childCount do
		setActive = var_1_10007

		var_1_10007(arg_7_1:GetChild(iter_7_0 - 1), arg_7_2)
	end

	return
end

function var_0_0.SetAsmrTurnning(arg_8_0, arg_8_1)
	arg_8_0._asmrTurnning = arg_8_1

	arg_8_0:UpdateVisible(true)

	if arg_8_0._skinId then
		arg_8_0:updateUI()
	end

	return
end

function var_0_0.UpdateVisible(arg_9_0, arg_9_1)
	if not arg_9_0._skinId then
		setActive = var_2

		var_2(arg_9_0._tf, false)

		return
	end

	if arg_9_0:IsAsmrSkin() and not arg_9_0._asmrTurnning then
		setActive = var_2

		var_2(arg_9_0._tf, false)

		return
	end

	setActive = var_2

	var_2(arg_9_0._tf, arg_9_1)

	return
end

function var_0_0.IsAsmrSkin(arg_10_0)
	if not arg_10_0._skinId then
		return false
	end

	ShipSkin = var_1

	local var_10_0

	if var_1.GetChangeSkinCustomDataId(arg_10_0._skinId, "asmr") ~= 1 then
		ShipSkin = var_1

		if var_1.GetChangeSkinCustomDataId(arg_10_0._nextSkinId, "asmr") ~= 1 then
			var_10_0 = false

			if false then
				var_10_0 = false
			end

			goto label_10_0
		end
	end

	var_10_0 = true

	::label_10_0::

	return var_10_0
end

return var_0_0
