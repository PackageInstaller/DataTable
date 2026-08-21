local var_0_0 = class("IslandShipStatusPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.tf = arg_1_1
	arg_1_0.emptyTf = arg_1_2
	arg_1_0.state1Tr = findTF(arg_1_1, "1")
	arg_1_0.state2Tr = findTF(arg_1_1, "2")
	arg_1_0.state3Tr = findTF(arg_1_1, "3")
	arg_1_0.viewBtn = findTF(arg_1_1, "view")

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:GetDisplayStatus()

	arg_2_0:UpdateLayout(#var_2_0)
	arg_2_0:UpdateStatus(var_2_0)
	setActive(arg_2_0.emptyTf, #var_2_0 <= 0)
	setActive(arg_2_0.tf, #var_2_0 > 0)

	return
end

function var_0_0.UpdateStatus(arg_3_0, arg_3_1)
	setActive(arg_3_0.viewBtn, #arg_3_1 > 0)
	arg_3_0:UpdateStatusTpl(arg_3_0.state1Tr, arg_3_1[1])
	arg_3_0:UpdateStatusTpl(arg_3_0.state2Tr, arg_3_1[2])
	arg_3_0:UpdateStatusTpl(arg_3_0.state3Tr, arg_3_1[3])

	return
end

function var_0_0.UpdateStatusTpl(arg_4_0, arg_4_1, arg_4_2)
	setActive(arg_4_1, arg_4_2 ~= nil)

	if arg_4_2 then
		setText(arg_4_1:Find("Text"), arg_4_2:GetName())

		local var_4_0 = Color.New(1, 0.5490196, 0.5490196, 1)
		local var_4_1 = Color.New(0.3137255, 0.6745098, 0.9372549, 1)

		arg_4_1:GetComponent(typeof(Image)).color = arg_4_2:IsRed() and var_4_0 or var_4_1
	end

	return
end

function var_0_0.UpdateLayout(arg_5_0, arg_5_1)
	if arg_5_1 == 1 then
		setAnchoredPosition3D(arg_5_0.state1Tr, {
			x = -16.7,
			y = -4.7
		})
		setAnchoredPosition3D(arg_5_0.viewBtn, {
			x = 123,
			y = -22
		})
	elseif arg_5_1 == 2 then
		setAnchoredPosition3D(arg_5_0.state1Tr, {
			x = -90,
			y = 11
		})
		setAnchoredPosition3D(arg_5_0.state2Tr, {
			x = 56.7,
			y = -32
		})
		setAnchoredPosition3D(arg_5_0.viewBtn, {
			x = 165,
			y = 0
		})
	elseif arg_5_1 > 2 then
		setAnchoredPosition3D(arg_5_0.state1Tr, {
			x = -118.6,
			y = 15
		})
		setAnchoredPosition3D(arg_5_0.state2Tr, {
			x = 132,
			y = 5.1
		})
		setAnchoredPosition3D(arg_5_0.state3Tr, {
			x = -20.6,
			y = -31.8
		})
		setAnchoredPosition3D(arg_5_0.viewBtn, {
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
