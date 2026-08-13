class = var_0_10000

local var_0_0 = var_0_10000("NewEducateTopRes")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.event = arg_1_2

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.GetComponent

	typeof = var_1_10005
	Image = var_1_10006
	arg_1_0.bgImage = var_1_1(var_1_0, var_1_10005(var_1_10006))
	UIItemList = var_3

	local var_1_2 = var_3.New
	local var_1_3 = arg_1_0._tf
	local var_1_4 = arg_1_0._tf

	arg_1_0.resUIList = var_1_2(var_1_3, var_5.Find(var_1_4, "tpl"))

	local var_1_5 = arg_1_0.resUIList

	var_3.make(var_1_5, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventInit then
			local var_2_0 = arg_1_0

			var_3.OnInitItem(var_2_0, arg_2_1, arg_2_2)
		else
			UIItemList = var_3

			if arg_2_0 == var_3.EventUpdate then
				local var_2_1 = arg_1_0

				var_3.OnUpdateItem(var_2_1, arg_2_1, arg_2_2)
			end
		end

		return
	end)

	return
end

function var_0_0.SetBgEnable(arg_3_0, arg_3_1)
	arg_3_0.bgImage.enabled = arg_3_1

	return
end

function var_0_0.OnInitItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.resIds[arg_4_1 + 1]

	setActive = var_4

	var_4(arg_4_2:Find("line"), arg_4_1 + 1 ~= #arg_4_0.resIds)

	pg = var_4

	local var_4_1 = var_4.child2_resource[var_4_0]

	LoadImageSpriteAsync = var_5

	var_5("neweducateicon/" .. var_4_1.icon, arg_4_2:Find("icon"))

	onButton = var_5

	local var_4_2 = arg_4_0.event
	local var_4_3 = arg_4_2

	local function var_4_4()
		local var_5_0 = arg_4_0.event
		local var_5_1 = var_0.emit

		NewEducateBaseUI = var_2_10002

		local var_5_2 = var_2_10002.ON_ITEM
		local var_5_3 = {}
		local var_5_4 = {
			number = 1
		}

		NewEducateConst = var_2_10005
		var_5_4.type = var_2_10005.DROP_TYPE.RES
		var_5_4.id = var_4_0
		var_5_3.drop = var_5_4

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end

	SFX_PANEL = var_9

	var_5(var_4_2, var_4_3, var_4_4, var_9)

	return
end

function var_0_0.OnUpdateItem(arg_6_0, arg_6_1, arg_6_2)
	pg = var_1_10003

	local var_6_0 = var_1_10003.child2_resource[arg_6_0.resIds[arg_6_1 + 1]].type

	NewEducateChar = var_5

	local var_6_1

	if var_6_0 ~= var_5.RES_TYPE.MOOD or not ("/" .. var_3.max_value) then
		var_6_1 = ""
	end

	local var_6_2 = arg_6_0.char
	local var_6_3 = var_5.GetRes(var_6_2, var_3.id)
	local var_6_4 = var_3.type

	NewEducateChar = var_7

	local var_6_6

	if var_6_4 == var_7.RES_TYPE.MOOD then
		setText = var_6_4

		local var_6_5 = arg_6_2

		var_6_6 = arg_6_2.Find(var_6_5, "value")
		setColorStr = var_6_5

		var_6_4(var_6_6, var_6_5(var_6_3, arg_6_0:GetMoodColor(var_6_3)) .. var_6_1)

		goto label_6_0
	end

	local var_6_7 = var_3.type

	NewEducateChar = var_6_6

	if var_6_7 == var_6_6.RES_TYPE.ACTION then
		setText = var_6_7

		local var_6_8 = arg_6_2
		local var_6_9 = arg_6_2.Find(var_6_8, "value")

		if var_6_3 == 0 then
			setColorStr = var_6_8

			do
				local var_6_10

				if not var_6_8(var_6_3, "#ee4a4a") then
					var_6_10 = var_6_3
				end

				var_6_7(var_6_9, var_6_10)

				if false then
					setText = var_6_7

					var_6_7(arg_6_2:Find("value"), var_6_3 .. var_6_1)
				end
			end

			::label_6_0::

			return
		end
	end
end

function var_0_0.Update(arg_7_0, arg_7_1)
	arg_7_0.char = arg_7_1

	local var_7_0

	if not arg_7_0.resIds then
		var_7_0 = {}

		local var_7_1 = arg_7_0.char
		local var_7_2 = var_3.GetResIdByType

		NewEducateChar = var_1_10005
		var_7_0[1] = var_7_2(var_7_1, var_1_10005.RES_TYPE.MONEY)

		local var_7_3 = arg_7_0.char
		local var_7_4 = var_3.GetResIdByType

		NewEducateChar = var_5
		var_7_0[2] = var_7_4(var_7_3, var_5.RES_TYPE.MOOD)

		local var_7_5 = arg_7_0.char
		local var_7_6 = var_3.GetResIdByType

		NewEducateChar = var_5
		var_7_0[3] = var_7_6(var_7_5, var_5.RES_TYPE.ACTION)
	end

	arg_7_0.resIds = var_7_0

	local var_7_7 = arg_7_0.resUIList

	var_2.align(var_7_7, #arg_7_0.resIds)

	return
end

function var_0_0.GetMoodColor(arg_8_0, arg_8_1)
	if arg_8_1 < 20 then
		return "#ee4a4a"
	elseif arg_8_1 < 40 then
		return "#ab4734"
	elseif arg_8_1 < 60 then
		return "#393A3C"
	else
		return "#00c79b"
	end

	return
end

function var_0_0.Dispose(arg_9_0)
	return
end

return var_0_0
