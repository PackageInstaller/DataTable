class = var_0_10000

local var_0_0 = "CourtYardBuffPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CourtYardBuffListPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "frame/close")
	UIItemList = var_1

	local var_2_1 = var_1.New
	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "frame/list/content")
	local var_2_4 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_1(var_2_3, var_4.Find(var_2_4, "frame/list/content/tpl"))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "frame/subtitle/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_2_4
	arg_2_0.totalExp = var_2_7(var_2_6, var_4(var_2_4))
	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_3.Find(var_2_8, "frame/title")

	i18n = var_4

	var_1(var_2_9, var_4("courtyard_label_exp_addition"))

	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "frame/subtitle")

	i18n = var_4

	var_1(var_2_11, var_4("courtyard_label_total_exp_addition"))

	arg_2_0.timers = {}

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	var_0_1.super.Show(arg_6_0)
	arg_6_0:Flush(arg_6_1)

	arg_6_0.list = arg_6_1

	return
end

function var_0_1.Flush(arg_7_0, arg_7_1)
	local var_7_0 = 0
	local var_7_1 = {}

	ipairs = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10004(arg_7_1) do
		if iter_7_1:getLeftTime() > 0 then
			table = var_9

			var_9.insert(var_7_1, iter_7_1)
		end
	end

	local var_7_2 = arg_7_0.uiItemList

	var_4.make(var_7_2, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = var_7_1[arg_8_1 + 1]
			local var_8_1 = {
				count = 0
			}

			DROP_TYPE_BUFF = var_2_10005
			var_8_1.type = var_2_10005
			var_8_1.id = var_8_0.id
			updateDrop = var_5

			var_5(arg_8_2:Find("award"), var_8_1)

			setText = var_5

			var_5(arg_8_2:Find("Text"), var_8_0:getConfig("desc"))

			local var_8_2 = arg_7_0

			var_5.AddTimer(var_8_2, arg_8_2:Find("time"), var_8_0)

			local var_8_3 = var_8_0
			local var_8_4 = var_8_0.getConfig(var_8_3, "benefit_effect")
			local var_8_5 = var_7_0

			tonumber = var_8_3
			var_7_0 = var_8_5 + var_8_3(var_8_4)
		end

		return
	end)

	local var_7_3 = arg_7_0.uiItemList

	var_4.align(var_7_3, #var_7_1)

	arg_7_0.totalExp.text = var_7_0 .. "%"

	return
end

function var_0_1.AddTimer(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:RemoveTimer(arg_9_2.id)

	Timer = var_3

	var_3.New(function()
		local var_10_0 = arg_9_2
		local var_10_1 = var_0.getLeftTime(var_10_0)

		if 0 < var_10_1 then
			pg = var_1

			local var_10_2 = var_1.TimeMgr.GetInstance()
			local var_10_3 = var_1.DescCDTime(var_10_2, var_10_1)

			if var_10_1 <= 600 then
				setColorStr = var_10_5

				local var_10_4 = var_10_3

				COLOR_RED = var_2_10005

				local var_10_5

				if not var_10_5(var_10_4, var_2_10005) then
					setColorStr = var_10_5
					var_10_5 = var_10_5(var_10_3, "#72bc42")
				end

				setText = var_10_2

				var_10_2(arg_9_1, var_10_5)

				if false then
					local var_10_6 = arg_9_0

					var_1.RemoveTimer(var_10_6, arg_9_2.id)

					local var_10_7 = arg_9_0

					var_1.Flush(var_10_7, arg_9_0.list)
				end

				return
			end
		end
	end, 1, -1).func()
	var_3:Start()

	arg_9_0.timers[arg_9_2.id] = var_3

	return
end

function var_0_1.RemoveTimer(arg_11_0, arg_11_1)
	if arg_11_0.timers[arg_11_1] then
		local var_11_0 = arg_11_0.timers[arg_11_1]

		var_2.Stop(var_11_0)

		arg_11_0.timers[arg_11_1] = nil
	end

	return
end

function var_0_1.RemoveAllTimer(arg_12_0)
	pairs = var_1_10001

	local var_12_0

	if not arg_12_0.timers then
		var_12_0 = {}
	end

	for iter_12_0, iter_12_1 in var_1_10001(var_12_0) do
		iter_12_1:Stop()
	end

	arg_12_0.timers = {}

	return
end

function var_0_1.OnDestroy(arg_13_0)
	arg_13_0:RemoveAllTimer()

	return
end

return var_0_1
