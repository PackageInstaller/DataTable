class = var_0_10000

local var_0_0 = "NewYearSnackResultView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SnackResultView"))

function var_0_1.getUIName(arg_1_0)
	return "NewYearSnackResult"
end

function var_0_1.updateView(arg_2_0)
	local var_2_0 = arg_2_0:calculateEXValue()

	if arg_2_0.contextData.countTime > 0 then
		setText = var_2

		local var_2_1 = arg_2_0.timeText
		local var_2_2 = arg_2_0.contextData.countTime
		local var_2_3 = "s   + "

		setColorStr = var_1_10007

		var_2(var_2_1, var_2_2 .. var_2_3 .. var_1_10007(var_2_0 .. "s", "#3068E6FF"))
	else
		setText = var_2

		var_2(arg_2_0.timeText, arg_2_0.contextData.countTime .. "s")
	end

	setText = var_2

	local var_2_4 = arg_2_0.scoreText
	local var_2_5 = arg_2_0.contextData.score
	local var_2_6 = "   + "

	setColorStr = var_1_10007

	var_2(var_2_4, var_2_5 .. var_2_6 .. var_1_10007(var_2_0, "#3068E6FF"))

	local var_2_7 = arg_2_0.orderList

	var_2.make(var_2_7, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_2_0.contextData.orderIDList[arg_3_1 + 1]
			local var_3_1

			var_3_1, setImageSprite = arg_3_2:Find("SnackImg"), var_2_10005
			GetSpriteFromAtlas = var_2_10008

			var_2_10005(var_3_1, var_2_10008("ui/minigameui/newyearsnackui_atlas", "snack_" .. var_3_0))
		end

		return
	end)

	local var_2_8 = arg_2_0.orderList

	var_2.align(var_2_8, #arg_2_0.contextData.orderIDList)

	local var_2_9 = arg_2_0.selectedList

	var_2.make(var_2_9, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_2_0.contextData.selectedIDList[arg_4_1 + 1]
			local var_4_1

			var_4_1, setImageSprite = arg_4_2:Find("SnackImg"), var_2_10005
			GetSpriteFromAtlas = var_2_10008

			var_2_10005(var_4_1, var_2_10008("ui/minigameui/newyearsnackui_atlas", "snack_" .. var_4_0))

			local var_4_2 = arg_2_0.contextData.orderIDList[arg_4_1 + 1]
			local var_4_3 = arg_4_2
			local var_4_4 = arg_4_2.Find(var_4_3, "ErrorImg")
			local var_4_5 = arg_4_2:Find("CorrectImg")

			setActive = var_4_3

			var_4_3(var_4_5, var_4_0 == var_4_2)

			setActive = var_4_3

			var_4_3(var_4_4, var_4_0 ~= var_4_2)
		end

		return
	end)

	local var_2_10 = arg_2_0.selectedList

	var_2.align(var_2_10, #arg_2_0.contextData.selectedIDList)

	if arg_2_0.contextData.countTime == 0 then
		setActive = var_2

		var_2(arg_2_0.continueBtn, false)
	end

	arg_2_0.contextData.countTime = arg_2_0.contextData.countTime + var_2_0
	arg_2_0.contextData.score = arg_2_0.contextData.score + var_2_0

	return
end

return var_0_1
