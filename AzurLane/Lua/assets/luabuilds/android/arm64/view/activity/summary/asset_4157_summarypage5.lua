class = var_0_10000

local var_0_0 = "SummaryPage5"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SummaryAnimationPage"))

function var_0_1.OnInit(arg_1_0)
	findTF = var_1_10001

	local var_1_0 = var_1_10001(arg_1_0._go, "share")

	onButton = var_1_10002

	local var_1_1 = arg_1_0
	local var_1_2 = var_1_0

	local function var_1_3()
		local var_2_0 = arg_1_0

		if var_0.inAnim(var_2_0) then
			return
		end

		pg = var_0

		local var_2_1 = var_0.ShareMgr.GetInstance()
		local var_2_2 = var_0.Share

		pg = var_2_10003

		var_2_2(var_2_1, var_2_10003.ShareMgr.TypeSummary)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_1_1, var_1_2, var_1_3, var_1_10007)

	findTF = var_1_10002

	local var_1_4 = var_1_10002(arg_1_0._go, "frame/name")

	findTF = var_3

	local var_1_5 = var_3(var_1_4, "Text")

	setText = var_4

	var_4(var_1_5, arg_1_0.summaryInfoVO.name)

	findTF = var_4

	local var_1_6 = var_4(arg_1_0._go, "frame/texts")

	arg_1_0.textTFs = {}

	for iter_1_0 = 1, var_1_6.childCount do
		local var_1_7 = var_1_6
		local var_1_8 = var_1_6.GetChild(var_1_7, iter_1_0 - 1)

		go = var_1_10010

		if var_1_10010(var_1_8).name == "list" or var_1_10010 == "list1" then
			for iter_1_1 = 1, var_1_8.childCount do
				local var_1_9 = var_1_8
				local var_1_10 = var_1_8.GetChild(var_1_9, iter_1_1 - 1)

				go = var_1_10016
				var_1_10016 = var_1_10016(var_1_10).name
				setActive = var_1_9

				local var_1_11 = var_1_10

				if var_1_10016 == "guildName" then
					local var_1_12 = arg_1_0.summaryInfoVO

					if var_20.hasGuild(var_1_12) then
						local var_1_14

						if var_1_10016 == "medalCount" then
							local var_1_13 = arg_1_0.summaryInfoVO

							var_1_14 = not not var_20.hasMedal(var_1_13)

							if false then
								var_1_14 = false
							end
						else
							var_1_14 = true
						end

						var_1_9(var_1_11, var_1_14)

						go = var_1_9

						if var_1_9(var_1_10).name ~= "label" then
							if var_1_10016 == "guildName" or var_1_10016 == "chapterName" then
								setText = var_17

								local var_1_15 = var_1_10
								local var_1_16 = var_1_10.Find(var_1_15, "image/Text")
								local var_1_17 = "「"

								string = var_1_15

								local var_1_18 = var_1_15.gsub
								local var_1_19 = arg_1_0.summaryInfoVO

								go = var_1_10024

								var_17(var_1_16, var_1_17 .. var_1_18(var_1_19[var_1_10024(var_1_10).name] .. "」", "–", "-"))
							else
								setText = var_17

								local var_1_20 = var_1_10
								local var_1_21 = var_1_10.Find(var_1_20, "image/Text")
								local var_1_22 = arg_1_0.summaryInfoVO

								go = var_1_20

								var_17(var_1_21, var_1_22[var_1_20(var_1_10).name])
							end
						end
					end
				end
			end
		elseif var_1_10010 ~= "label" then
			setText = var_1_7

			var_1_7(var_1_8:Find("Text"), arg_1_0.summaryInfoVO[var_1_10010])
		end

		table = var_1_7

		var_1_7.insert(arg_1_0.textTFs, var_1_8)
	end

	setActive = var_5

	var_5(arg_1_0._go, false)

	return
end

function var_0_1.Clear(arg_3_0)
	return
end

return var_0_1
