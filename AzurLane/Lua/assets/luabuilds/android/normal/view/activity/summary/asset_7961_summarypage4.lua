class = var_0_10000

local var_0_0 = "SummaryPage4"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SummaryAnimationPage"))

function var_0_1.OnInit(arg_1_0)
	findTF = var_1_10001

	local var_1_0 = var_1_10001(arg_1_0._go, "content")
	local var_1_1 = arg_1_0.summaryInfoVO.furnitures
	local var_1_2 = {}

	for iter_1_0 = 1, var_1_0.childCount do
		local var_1_3 = var_1_0
		local var_1_4 = var_1_0.GetChild(var_1_3, iter_1_0 - 1)

		findTF = var_1_3

		local var_1_5 = var_1_3(var_1_4, "info")

		tonumber = var_10
		go = var_11

		local var_1_6 = var_1_1[var_10(var_11(var_1_4).name)]

		triggerToggle = var_1_7

		var_1_7(var_1_5, var_1_6)

		local var_1_7

		if var_1_6 then
			setText = var_1_7

			var_1_7(var_1_5:Find("from/Text"), var_1_6:getConfig("gain_by"))
		else
			pg = var_1_7
			var_1_7 = var_1_7.furniture_data_template[var_10]
			setText = var_13

			local var_1_8 = var_1_5:Find("from/Text")
			local var_1_9

			if not var_1_7 or not var_1_7.gain_by then
				var_1_9 = "--：--:--"
			end

			var_13(var_1_8, var_1_9)
		end

		setText = var_1_7

		local var_1_10 = var_1_5
		local var_1_11 = var_1_5.Find(var_1_10, "date/Text")

		if not var_1_6 or not var_1_6:getDate() then
			i18n = var_1_10
			var_1_10 = var_1_10("summary_page_un_rearch")
		end

		var_1_7(var_1_11, var_1_10)

		table = var_1_7

		var_1_7.insert(var_1_2, var_1_5)
	end

	setActive = var_4

	var_4(arg_1_0._go, false)

	return
end

function var_0_1.Clear(arg_2_0)
	return
end

return var_0_1
