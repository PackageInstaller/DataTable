class = var_0_10000

local var_0_0 = var_0_10000("RectKeyTriggerController")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._keyInfo = arg_1_1

	if not arg_1_0.handle then
		UpdateBeat = var_2
		arg_1_0.handle = var_2:CreateListener(arg_1_0.Update, arg_1_0)
	end

	UpdateBeat = var_2

	var_2:AddListener(arg_1_0.handle)

	return
end

function var_0_0.Update(arg_2_0)
	Application = var_1_10001

	if var_1_10001.isEditor then
		Input = var_1

		local var_2_0 = var_1.GetKeyDown

		KeyCode = var_1_10002

		local var_2_1, var_2_2

		if var_2_0(var_1_10002.A) then
			var_2_1 = arg_2_0._keyInfo
			var_2_2 = var_2_2.setKeyPress
			KeyCode = var_1_10003

			var_2_2(var_2_1, var_1_10003.A, true)
		end

		Input = var_2_2

		local var_2_3 = var_2_2.GetKeyDown

		KeyCode = var_2_1

		local var_2_4, var_2_5

		if var_2_3(var_2_1.D) then
			var_2_4 = arg_2_0._keyInfo
			var_2_5 = var_2_5.setKeyPress
			KeyCode = var_1_10003

			var_2_5(var_2_4, var_1_10003.D, true)
		end

		Input = var_2_5

		local var_2_6 = var_2_5.GetKeyUp

		KeyCode = var_2_4

		local var_2_7, var_2_8

		if var_2_6(var_2_4.A) then
			var_2_7 = arg_2_0._keyInfo
			var_2_8 = var_2_8.setKeyPress
			KeyCode = var_1_10003

			var_2_8(var_2_7, var_1_10003.A, false)
		end

		Input = var_2_8

		local var_2_9 = var_2_8.GetKeyUp

		KeyCode = var_2_7

		local var_2_10, var_2_11

		if var_2_9(var_2_7.D) then
			var_2_10 = arg_2_0._keyInfo
			var_2_11 = var_2_11.setKeyPress
			KeyCode = var_1_10003

			var_2_11(var_2_10, var_1_10003.D, false)
		end

		Input = var_2_11

		local var_2_12 = var_2_11.GetKeyDown

		KeyCode = var_2_10

		local var_2_13, var_2_14

		if var_2_12(var_2_10.Space) then
			var_2_13 = arg_2_0._keyInfo
			var_2_14 = var_2_14.setKeyPress
			KeyCode = var_1_10003

			var_2_14(var_2_13, var_1_10003.Space, true)
		end

		Input = var_2_14

		local var_2_15 = var_2_14.GetKeyUp

		KeyCode = var_2_13

		local var_2_16, var_2_17

		if var_2_15(var_2_13.Space) then
			var_2_16 = arg_2_0._keyInfo
			var_2_17 = var_2_17.setKeyPress
			KeyCode = var_1_10003

			var_2_17(var_2_16, var_1_10003.Space, false)
		end

		Input = var_2_17

		local var_2_18 = var_2_17.GetKeyDown

		KeyCode = var_2_16

		local var_2_19, var_2_20

		if var_2_18(var_2_16.J) then
			var_2_19 = arg_2_0._keyInfo
			var_2_20 = var_2_20.setKeyPress
			KeyCode = var_1_10003

			var_2_20(var_2_19, var_1_10003.J, true)
		end

		Input = var_2_20

		local var_2_21 = var_2_20.GetKeyUp

		KeyCode = var_2_19

		if var_2_21(var_2_19.J) then
			local var_2_22 = arg_2_0._keyInfo
			local var_2_23 = var_1.setKeyPress

			KeyCode = var_1_10003

			var_2_23(var_2_22, var_1_10003.J, false)
		end
	end

	return
end

function var_0_0.destroy(arg_3_0)
	if arg_3_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_3_0.handle)

		arg_3_0.handle = nil
	end

	return
end

return var_0_0
