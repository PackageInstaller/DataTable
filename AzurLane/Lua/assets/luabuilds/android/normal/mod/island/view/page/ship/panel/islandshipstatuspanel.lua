class = var_0_10000

local var_0_0 = var_0_10000("IslandShipStatusPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.tf = arg_1_1
	arg_1_0.emptyTf = arg_1_2
	findTF = var_1_10003
	arg_1_0.state1Tr = var_1_10003(arg_1_1, "1")
	findTF = var_3
	arg_1_0.state2Tr = var_3(arg_1_1, "2")
	findTF = var_3
	arg_1_0.state3Tr = var_3(arg_1_1, "3")
	findTF = var_3
	arg_1_0.viewBtn = var_3(arg_1_1, "view")

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:GetDisplayStatus()

	arg_2_0:UpdateLayout(#var_2_0)
	arg_2_0:UpdateStatus(var_2_0)

	setActive = var_3

	var_3(arg_2_0.emptyTf, #var_2_0 <= 0)

	setActive = var_3

	var_3(arg_2_0.tf, #var_2_0 > 0)

	return
end

function var_0_0.UpdateStatus(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0.viewBtn, #arg_3_1 > 0)
	arg_3_0:UpdateStatusTpl(arg_3_0.state1Tr, arg_3_1[1])
	arg_3_0:UpdateStatusTpl(arg_3_0.state2Tr, arg_3_1[2])
	arg_3_0:UpdateStatusTpl(arg_3_0.state3Tr, arg_3_1[3])

	return
end

function var_0_0.UpdateStatusTpl(arg_4_0, arg_4_1, arg_4_2)
	setActive = var_1_10003

	var_1_10003(arg_4_1, arg_4_2 ~= nil)

	if arg_4_2 then
		setText = var_1_10003

		var_1_10003(arg_4_1:Find("Text"), arg_4_2:GetName())

		Color = var_1_10003

		local var_4_0 = var_1_10003.New(1, 0.5490196, 0.5490196, 1)

		Color = var_4

		local var_4_1 = var_4.New(0.3137255, 0.6745098, 0.9372549, 1)
		local var_4_2 = arg_4_1
		local var_4_3 = arg_4_1.GetComponent

		typeof = var_7
		Image = var_8
		var_4_3(var_4_2, var_7(var_8)).color = arg_4_2:IsRed() and var_4_0 or var_4_1
	end

	return
end

function var_0_0.UpdateLayout(arg_5_0, arg_5_1)
	if arg_5_1 == 1 then
		setAnchoredPosition3D = var_1_10002

		var_1_10002(arg_5_0.state1Tr, {
			x = -16.7,
			y = -4.7
		})

		setAnchoredPosition3D = var_1_10002

		var_1_10002(arg_5_0.viewBtn, {
			x = 123,
			y = -22
		})
	elseif arg_5_1 == 2 then
		setAnchoredPosition3D = var_1_10002

		var_1_10002(arg_5_0.state1Tr, {
			x = -90,
			y = 11
		})

		setAnchoredPosition3D = var_1_10002

		var_1_10002(arg_5_0.state2Tr, {
			x = 56.7,
			y = -32
		})

		setAnchoredPosition3D = var_1_10002

		var_1_10002(arg_5_0.viewBtn, {
			x = 165,
			y = 0
		})
	elseif 2 < arg_5_1 then
		setAnchoredPosition3D = var_2

		var_2(arg_5_0.state1Tr, {
			x = -118.6,
			y = 15
		})

		setAnchoredPosition3D = var_2

		var_2(arg_5_0.state2Tr, {
			x = 132,
			y = 5.1
		})

		setAnchoredPosition3D = var_2

		var_2(arg_5_0.state3Tr, {
			x = -20.6,
			y = -31.8
		})

		setAnchoredPosition3D = var_2

		var_2(arg_5_0.viewBtn, {
			x = 188,
			y = -31.8
		})
	end

	return
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0
