class = var_0_10000

local var_0_0 = "SummaryPage1"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SummaryAnimationPage"))

function var_0_1.OnInit(arg_1_0)
	findTF = var_1_10001

	local var_1_0 = var_1_10001(arg_1_0._go, "name")

	findTF = var_2

	local var_1_1 = var_2(var_1_0, "Text")

	findTF = var_3

	local var_1_2 = var_3(arg_1_0._go, "painting")

	findTF = var_4

	local var_1_3 = var_4(var_1_2, "mask/painting")

	setText = var_5

	var_5(var_1_1, arg_1_0.summaryInfoVO.name)

	findTF = var_5

	local var_1_4 = var_5(arg_1_0._go, "time_line")
	local var_1_5 = {}

	for iter_1_0 = 1, var_1_4.childCount do
		local var_1_6 = var_1_4:GetChild(iter_1_0 - 1)
		local var_1_7 = var_11.Find(var_1_6, "texts")

		for iter_1_1 = 1, var_1_7.childCount do
			local var_1_8 = var_1_7
			local var_1_9 = var_1_7.GetChild(var_1_8, iter_1_1 - 1)

			go = var_1_8

			if var_1_8(var_1_9).name == "guildName" then
				if not (not arg_1_0.summaryInfoVO.guildName or var_19 == "") then
					setText = var_1_10021

					var_1_10021(var_1_9:Find("text/Text"), "「" .. var_19 .. "」")
				end

				setActive = var_1_10021

				var_1_10021(var_1_9:Find("image"), var_20)

				setActive = var_1_10021

				var_1_10021(var_1_9:Find("text"), not var_20)
			elseif var_18 == "days" or var_18 == "furnitureCount" or var_18 == "furnitureWorth" then
				setText = var_19
				var_1_10021 = var_1_9

				var_19(var_1_9.Find(var_1_10021, "Text"), arg_1_0.summaryInfoVO[var_18])
			elseif var_18 ~= "label" then
				setText = var_19
				var_1_10021 = var_1_9

				local var_1_10 = var_1_9.Find(var_1_10021, "Text")

				var_1_10021 = "「"
				string = var_22

				var_19(var_1_10, var_1_10021 .. var_22.gsub(arg_1_0.summaryInfoVO[var_18], "–", "-") .. "」")
			end
		end

		table = var_13

		var_13.insert(var_1_5, var_11)
	end

	Ship = var_7

	local var_1_11 = var_7.New({
		configId = arg_1_0.summaryInfoVO.flagShipId
	})
	local var_1_12 = var_7.getPainting(var_1_11)

	setPaintingPrefabAsync = var_1_11

	var_1_11(var_1_3, var_1_12, "chuanwu")

	setActive = var_1_11

	var_1_11(arg_1_0._go, false)

	return
end

return var_0_1
