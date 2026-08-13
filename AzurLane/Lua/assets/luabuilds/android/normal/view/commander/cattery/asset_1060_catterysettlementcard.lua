class = var_0_10000

local var_0_0 = var_0_10000("CatterySettlementCard")
local var_0_1 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.tr = arg_1_1
	arg_1_0.go = arg_1_1.gameObject
	findTF = var_2
	arg_1_0.emptyTF = var_2(arg_1_0.tr, "empty")
	findTF = var_2
	arg_1_0.commanderTF = var_2(arg_1_0.tr, "commander")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0.commanderTF, "name")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_1(var_1_0, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.char = var_2(arg_1_0.commanderTF, "mask/char")
	findTF = var_2

	local var_1_2 = var_2(arg_1_0.commanderTF, "exp/Text")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.expTxt = var_1_3(var_1_2, var_4(var_1_10005))
	findTF = var_2

	local var_1_4 = var_2(arg_1_0.commanderTF, "exp_bar")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Slider = var_1_10005
	arg_1_0.slider = var_1_5(var_1_4, var_4(var_1_10005))
	findTF = var_2

	local var_1_6 = var_2(arg_1_0.commanderTF, "level")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTxt = var_1_7(var_1_6, var_4(var_1_10005))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.cattery = arg_2_1
	arg_2_0.exp = arg_2_2

	local var_2_0 = arg_2_1

	if arg_2_1.ExistCommander(var_2_0) then
		arg_2_0:UpdateCommander()
	end

	setActive = var_2_0

	var_2_0(arg_2_0.emptyTF, not var_3)

	setActive = var_2_0

	var_2_0(arg_2_0.commanderTF, var_3)

	return
end

function var_0_0.UpdateCommander(arg_3_0)
	local var_3_0 = arg_3_0.exp
	local var_3_1 = arg_3_0.cattery
	local var_3_2 = var_2.GetCommander(var_3_1)

	arg_3_0.oldCommander = arg_3_0:GetOldCommander(var_3_2, var_3_0)
	arg_3_0.commander = var_3_2

	arg_3_0:LoadCommander(var_3_2)

	arg_3_0.slider.value = var_4.exp / var_4:getNextLevelExp()
	arg_3_0.levelTxt.text = "LV." .. var_4:getLevel()
	arg_3_0.expTxt.text = var_4.exp .. "/" .. var_4:getNextLevelExp()
	arg_3_0.nameTxt.text = var_4:getName()

	return
end

function var_0_0.InitAnim(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.commander
	local var_4_1 = var_2.getLevel(var_4_0)
	local var_4_2 = arg_4_0.oldCommander
	local var_4_3 = var_3.getLevel(var_4_2)
	local var_4_4 = arg_4_0.commander
	local var_4_5 = var_4.getNextLevelExp(var_4_4)
	local var_4_6 = arg_4_0.commander.exp / var_4_5

	if var_4_3 < var_4_1 then
		table = var_1_10006

		var_1_10006.insert(arg_4_1, function(arg_5_0)
			local var_5_0 = arg_4_0

			var_1.DoUpgradeAnim(var_5_0, arg_5_0)

			return
		end)
	else
		table = var_1_10006

		var_1_10006.insert(arg_4_1, function(arg_6_0)
			local var_6_0 = arg_4_0

			var_1.AddExpAnim(var_6_0, arg_4_0.slider.value, var_4_6, arg_4_0.oldCommander.exp, arg_4_0.commander.exp, var_4_5, arg_6_0)

			return
		end)
	end

	return
end

function var_0_0.Action(arg_7_0, arg_7_1)
	if not arg_7_0.commander then
		arg_7_1()

		return
	end

	local var_7_0 = {}

	arg_7_0:InitAnim(var_7_0)

	parallelAsync = var_3

	var_3(var_7_0, arg_7_1)

	return
end

function var_0_0.DoUpgradeAnim(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.commander
	local var_8_1 = var_2.getLevel(var_8_0)
	local var_8_2 = arg_8_0.oldCommander
	local var_8_3 = var_3.getLevel(var_8_2)
	local var_8_4 = arg_8_0.commander
	local var_8_5 = var_5.getNextLevelExp(var_8_4)
	local var_8_6 = arg_8_0.commander.exp / var_8_5

	local function var_8_7()
		var_8_3 = var_8_3 + 1
		arg_8_0.levelTxt.text = "LV." .. var_8_3

		return
	end

	local var_8_8 = {}
	local var_8_9 = var_3 + 1

	table = var_1_10009

	var_1_10009.insert(var_8_8, function(arg_10_0)
		local var_10_0 = arg_8_0.oldCommander
		local var_10_1 = var_1.getNextLevelExp(var_10_0)
		local var_10_2 = arg_8_0.oldCommander.exp
		local var_10_3 = arg_8_0

		var_3.AddExpAnim(var_10_3, arg_8_0.slider.value, 1, var_10_2, var_10_1, var_10_1, function()
			var_8_7()
			arg_10_0()

			return
		end)

		return
	end)

	while var_8_9 ~= var_8_1 do
		var_8_9 = var_8_9 + 1
		table = var_9

		var_9.insert(var_8_8, function(arg_12_0)
			local var_12_0 = arg_8_0.oldCommander
			local var_12_1 = var_1.getConfigExp(var_12_0, var_8_3)
			local var_12_2 = arg_8_0

			var_2.AddExpAnim(var_12_2, 0, 1, 0, var_12_1, var_12_1, function()
				var_8_7()
				arg_12_0()

				return
			end)

			return
		end)
	end

	table = var_9

	var_9.insert(var_8_8, function(arg_14_0)
		local var_14_0 = arg_8_0

		var_1.AddExpAnim(var_14_0, 0, var_8_6, 0, arg_8_0.commander.exp, var_8_5, arg_14_0)

		return
	end)

	seriesAsync = var_9

	var_9(var_8_8, arg_8_1)

	return
end

function var_0_0.LoadCommander(arg_15_0, arg_15_1)
	arg_15_0:ReturnCommander()

	arg_15_0.painting = arg_15_1:getPainting()
	setCommanderPaintingPrefab = var_2

	var_2(arg_15_0.char, arg_15_0.painting, "result")

	return
end

function var_0_0.ReturnCommander(arg_16_0)
	if arg_16_0.painting then
		retCommanderPaintingPrefab = var_1

		var_1(arg_16_0.char, arg_16_0.painting)

		arg_16_0.painting = nil
	end

	return
end

function var_0_0.Clear(arg_17_0)
	LeanTween = var_1_10001

	local var_17_0 = var_1_10001.isTweening

	go = var_1_10002

	local var_17_1

	if var_17_0(var_1_10002(arg_17_0.slider)) then
		LeanTween = var_17_1
		var_17_1 = var_17_1.cancel
		go = var_2

		var_17_1(var_2(arg_17_0.slider))
	end

	LeanTween = var_17_1

	local var_17_2 = var_17_1.isTweening

	go = var_2

	if var_17_2(var_2(arg_17_0.expTxt)) then
		LeanTween = var_1

		local var_17_3 = var_1.cancel

		go = var_2

		var_17_3(var_2(arg_17_0.expTxt))
	end

	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:Clear()
	arg_18_0:ReturnCommander()

	return
end

function var_0_0.GetOldCommander(arg_19_0, arg_19_1, arg_19_2)
	Clone = var_1_10003

	local var_19_0 = var_1_10003(arg_19_1)

	var_3.ReduceExp(var_19_0, arg_19_2)

	return var_3
end

function var_0_0.AddExpAnim(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
	parallelAsync = var_1_10007

	var_1_10007({
		function(arg_21_0)
			LeanTween = var_2_10001

			local var_21_0 = var_2_10001.value

			go = var_2_10002

			local var_21_1 = var_21_0(var_2_10002(arg_20_0.slider), arg_20_1, arg_20_2, var_0_1)
			local var_21_2 = var_1.setOnUpdate

			System = var_3

			local var_21_3 = var_21_2(var_21_1, var_3.Action_float(function(arg_22_0)
				arg_20_0.slider.value = arg_22_0

				return
			end))
			local var_21_4 = var_1.setOnComplete

			System = var_3

			var_21_4(var_21_3, var_3.Action(arg_21_0))

			return
		end,
		function(arg_23_0)
			LeanTween = var_2_10001

			local var_23_0 = var_2_10001.value

			go = var_2_10002

			local var_23_1 = var_23_0(var_2_10002(arg_20_0.expTxt), arg_20_3, arg_20_4, var_0_1)
			local var_23_2 = var_1.setOnUpdate

			System = var_3

			local var_23_3 = var_23_2(var_23_1, var_3.Action_float(function(arg_24_0)
				math = var_3_10001

				local var_24_0 = var_3_10001.ceil(arg_24_0)
				local var_24_1 = arg_20_0.expTxt
				local var_24_2 = "<color=#94d53eFF>"
				local var_24_3 = var_24_0
				local var_24_4 = "/</color>"
				local var_24_5 = "<color="
				local var_24_6 = arg_20_0

				var_24_1.text = var_24_2 .. var_24_3 .. var_24_4 .. var_24_5 .. var_7.GetColor(var_24_6) .. ">" .. arg_20_5 .. "</color>"

				return
			end))
			local var_23_4 = var_1.setOnComplete

			System = var_3

			var_23_4(var_23_3, var_3.Action(arg_23_0))

			return
		end
	}, function()
		if arg_20_6 then
			arg_20_6()
		end

		return
	end)

	return
end

function var_0_0.GetColor(arg_26_0)
	return "#9f9999"
end

return var_0_0
