class = var_0_10000

local var_0_0 = "SummaryPage2"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SummaryAnimationPage"))

function var_0_1.OnInit(arg_1_0)
	findTF = var_1_10001

	local var_1_0 = var_1_10001(arg_1_0._go, "name/Text")

	setText = var_1_10002

	var_1_10002(var_1_0, arg_1_0.summaryInfoVO.firstProposeName)

	findTF = var_1_10002

	local var_1_1 = var_1_10002(arg_1_0._go, "texts")

	arg_1_0.textTFs = {}

	for iter_1_0 = 1, var_1_1.childCount do
		local var_1_2 = var_1_1
		local var_1_3 = var_1_1.GetChild(var_1_2, iter_1_0 - 1)

		go = var_1_10008

		if var_1_10008(var_1_3).name ~= "label" then
			setText = var_1_2

			var_1_2(var_1_3:Find("Text"), arg_1_0.summaryInfoVO[var_1_10008])
		end

		table = var_1_2

		var_1_2.insert(arg_1_0.textTFs, var_1_3)
	end

	findTF = var_3

	local var_1_4 = var_3(arg_1_0._go, "name/date")

	setText = var_4

	var_4(var_1_4, arg_1_0.summaryInfoVO.firstLadyTime)

	findTF = var_4

	local var_1_5 = var_4(arg_1_0._go, "painting")
	local var_1_6 = var_4.Find(var_1_5, "mask/painting")

	Ship = var_6

	local var_1_7 = var_6.New({
		configId = arg_1_0.summaryInfoVO.firstLadyId
	})
	local var_1_8 = var_6.getPainting(var_1_7)

	setPaintingPrefabAsync = var_1_5

	var_1_5(var_1_6, var_1_8, "chuanwu")

	setActive = var_1_5

	var_1_5(arg_1_0._go, false)

	return
end

function var_0_1.Clear(arg_2_0)
	return
end

return var_0_1
