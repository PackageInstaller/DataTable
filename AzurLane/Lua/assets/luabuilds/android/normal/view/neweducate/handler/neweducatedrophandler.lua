class = var_0_10000

local var_0_0 = var_0_10000("NewEducateDropHandler")
local var_0_1 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.dropsTF = var_2.Find(var_1_0, "drops")
	UIItemList = var_2

	local var_1_1 = var_2.New
	local var_1_2 = arg_1_0.dropsTF
	local var_1_3 = arg_1_0.dropsTF

	arg_1_0.dropUIList = var_1_1(var_1_2, var_4.Find(var_1_3, "tpl"))

	local var_1_4 = arg_1_0.dropUIList

	var_2.make(var_1_4, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_0.drops[arg_2_1 + 1]

			NewEducateHelper = var_4

			local var_2_1

			if not var_4.GetDropConfig(var_2_0).icon then
				var_2_1 = var_4.item_icon
			end

			LoadImageSpriteAsync = var_2_10006

			var_2_10006("neweducateicon/" .. var_2_1, arg_2_2:Find("icon"))

			setText = var_2_10006

			var_2_10006(arg_2_2:Find("name"), var_4.name)

			if var_2_0.number > 0 then
				setActive = var_6

				var_6(arg_2_2:Find("reduce"), false)

				setActive = var_6

				var_6(arg_2_2:Find("increase"), true)

				setText = var_6

				var_6(arg_2_2:Find("increase/value"), "+" .. var_2_0.number)
			else
				setActive = var_6

				var_6(arg_2_2:Find("reduce"), true)

				setActive = var_6

				var_6(arg_2_2:Find("increase"), false)

				setText = var_6

				var_6(arg_2_2:Find("reduce/value"), var_2_0.number)
			end

			setActive = var_6

			var_6(arg_2_2:Find("benefit"), false)
		end

		return
	end)

	local var_1_5 = arg_1_0._tf

	arg_1_0.polaroidTF = var_2.Find(var_1_5, "polaroid")

	return
end

function var_0_0.Play(arg_3_0, arg_3_1, arg_3_2)
	setActive = var_1_10003

	var_1_10003(arg_3_0._go, true)

	setActive = var_1_10003

	var_1_10003(arg_3_0.dropsTF, true)

	setActive = var_1_10003

	var_1_10003(arg_3_0.polaroidTF, false)

	arg_3_0.drops = arg_3_0:FilterPersonality(arg_3_1)

	local var_3_0 = arg_3_0.dropUIList

	var_3.align(var_3_0, #arg_3_0.drops)

	Timer = var_3
	arg_3_0.timer = var_3.New(function()
		existCall = var_2_10000

		var_2_10000(arg_3_2)

		return
	end, var_0_1)

	local var_3_1 = arg_3_0.timer

	var_3.Start(var_3_1)

	return
end

function var_0_0.FilterPersonality(arg_5_0, arg_5_1)
	underscore = var_1_10002

	return var_1_10002.select(arg_5_1, function(arg_6_0)
		local var_6_0 = arg_6_0.type

		NewEducateConst = var_2_10002

		if var_6_0 == var_2_10002.DROP_TYPE.ATTR then
			local var_6_1 = arg_6_0.type

			NewEducateConst = var_2

			if var_6_1 == var_2.DROP_TYPE.ATTR then
				pg = var_6_1

				local var_6_2 = var_6_1.child2_attr[arg_6_0.id].type

				NewEducateChar = var_2

				local var_6_3

				if var_6_2 == var_2.ATTR_TYPE.PERSONALITY then
					var_6_3 = false

					goto label_6_0
				end

				var_6_3 = true

				::label_6_0::

				return var_6_3
			end
		end
	end)
end

function var_0_0.PlayPolaroid(arg_7_0, arg_7_1, arg_7_2)
	setActive = var_1_10003

	var_1_10003(arg_7_0._go, true)

	setActive = var_1_10003

	var_1_10003(arg_7_0.dropsTF, false)

	setActive = var_1_10003

	var_1_10003(arg_7_0.polaroidTF, true)

	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_8_0)
			pg = var_2_10001

			local var_8_0 = var_2_10001.child2_polaroid[arg_7_1.id]

			LoadImageSpriteAsync = var_2

			local var_8_1 = "neweducateicon/" .. var_8_0.pic
			local var_8_2 = arg_7_0.polaroidTF

			var_2(var_8_1, var_4.Find(var_8_2, "content/mask/icon"), true)

			setText = var_2

			local var_8_3 = arg_7_0.polaroidTF

			var_2(var_3.Find(var_8_3, "content/desc"), var_8_0.title)

			onDelayTick = var_2

			var_2(function()
				arg_8_0()

				return
			end, var_0_1)

			return
		end
	}, function()
		existCall = var_2_10000

		var_2_10000(arg_7_2)

		return
	end)

	return
end

function var_0_0.Reset(arg_11_0)
	setActive = var_1_10001

	var_1_10001(arg_11_0._go, false)

	setActive = var_1_10001

	var_1_10001(arg_11_0.polaroidTF, false)

	setActive = var_1_10001

	var_1_10001(arg_11_0.dropsTF, false)

	arg_11_0.drops = {}

	if arg_11_0.timer ~= nil then
		local var_11_0 = arg_11_0.timer

		var_1.Stop(var_11_0)

		arg_11_0.timer = nil
	end

	return
end

function var_0_0.Destroy(arg_12_0)
	return
end

return var_0_0
