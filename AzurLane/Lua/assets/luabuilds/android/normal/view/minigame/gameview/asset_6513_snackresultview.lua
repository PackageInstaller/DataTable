class = var_0_10000

local var_0_0 = "SnackResultView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

var_0_1.EXTable = {
	[0] = 0,
	1,
	2,
	5
}

function var_0_1.getUIName(arg_1_0)
	return "SnackResult"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initUI()
	arg_2_0:updateView()
	arg_2_0:Show()

	pg = var_1

	local var_2_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	return
end

function var_0_1.OnDestroy(arg_3_0)
	arg_3_0.lockBackPress = false
	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.initUI(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "Content")

	arg_4_0.timeText = var_1.Find(var_4_1, "Tip/Time/TimeText")
	arg_4_0.scoreText = var_1:Find("Tip/Score/ScoreText")
	arg_4_0.snackTpl = var_1:Find("SnackTpl")
	arg_4_0.orderListContainer = var_1:Find("Order/OrderList")
	UIItemList = var_2
	arg_4_0.orderList = var_2.New(arg_4_0.orderListContainer, arg_4_0.snackTpl)
	arg_4_0.selectedListContainer = var_1:Find("Select/SelectList")
	UIItemList = var_2
	arg_4_0.selectedList = var_2.New(arg_4_0.selectedListContainer, arg_4_0.snackTpl)
	arg_4_0.submitBtn = var_1:Find("Buttons/SubmitBtn")
	arg_4_0.continueBtn = var_1:Find("Buttons/ContinueBtn")
	onButton = var_2

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.submitBtn

	local function var_4_4()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.calculateLevel(var_5_0)

		arg_4_0.contextData.onSubmit(var_5_1)

		local var_5_2 = arg_4_0

		var_1.Destroy(var_5_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_4_2, var_4_3, var_4_4, var_1_10006)

	onButton = var_2

	var_2(arg_4_0, arg_4_0.continueBtn, function()
		arg_4_0.contextData.onContinue()

		local var_6_0 = arg_4_0

		var_0.Destroy(var_6_0)

		return
	end)

	return
end

function var_0_1.updateView(arg_7_0)
	local var_7_0 = arg_7_0:calculateEXValue()

	if arg_7_0.contextData.countTime > 0 then
		setText = var_2

		local var_7_1 = arg_7_0.timeText
		local var_7_2 = arg_7_0.contextData.countTime
		local var_7_3 = "s   + "

		setColorStr = var_1_10006

		var_2(var_7_1, var_7_2 .. var_7_3 .. var_1_10006(var_7_0 .. "s", "#3068E6FF"))
	else
		setText = var_2

		var_2(arg_7_0.timeText, arg_7_0.contextData.countTime .. "s")
	end

	setText = var_2

	local var_7_4 = arg_7_0.scoreText
	local var_7_5 = arg_7_0.contextData.score
	local var_7_6 = "   + "

	setColorStr = var_1_10006

	var_2(var_7_4, var_7_5 .. var_7_6 .. var_1_10006(var_7_0, "#3068E6FF"))

	local var_7_7 = arg_7_0.orderList

	var_2.make(var_7_7, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_7_0.contextData.orderIDList[arg_8_1 + 1]
			local var_8_1 = arg_8_2
			local var_8_2

			var_8_2, setImageSprite = arg_8_2.Find(var_8_1, "SnackImg"), var_8_1
			GetSpriteFromAtlas = var_2_10007

			var_8_1(var_8_2, var_2_10007("ui/snackui_atlas", "snack_" .. var_8_0))
		end

		return
	end)

	local var_7_8 = arg_7_0.orderList

	var_2.align(var_7_8, #arg_7_0.contextData.orderIDList)

	local var_7_9 = arg_7_0.selectedList

	var_2.make(var_7_9, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_7_0.contextData.selectedIDList[arg_9_1 + 1]
			local var_9_1 = arg_9_2
			local var_9_2

			var_9_2, setImageSprite = arg_9_2.Find(var_9_1, "SnackImg"), var_9_1
			GetSpriteFromAtlas = var_2_10007

			var_9_1(var_9_2, var_2_10007("ui/snackui_atlas", "snack_" .. var_9_0))

			local var_9_3 = arg_7_0.contextData.orderIDList[arg_9_1 + 1]
			local var_9_4 = arg_9_2:Find("ErrorImg")
			local var_9_5 = arg_9_2
			local var_9_6 = arg_9_2.Find(var_9_5, "CorrectImg")

			setActive = var_9_5

			var_9_5(var_9_6, var_9_0 == var_9_3)

			setActive = var_9_5

			var_9_5(var_9_4, var_9_0 ~= var_9_3)
		end

		return
	end)

	local var_7_10 = arg_7_0.selectedList

	var_2.align(var_7_10, #arg_7_0.contextData.selectedIDList)

	if arg_7_0.contextData.countTime == 0 then
		setActive = var_2

		var_2(arg_7_0.continueBtn, false)
	end

	arg_7_0.contextData.countTime = arg_7_0.contextData.countTime + var_7_0
	arg_7_0.contextData.score = arg_7_0.contextData.score + var_7_0

	return
end

function var_0_1.calculateEXValue(arg_10_0)
	local var_10_0 = 0

	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.contextData.selectedIDList) do
		if arg_10_0.contextData.orderIDList[iter_10_0] == iter_10_1 then
			var_10_0 = var_10_0 + 1
		end
	end

	return arg_10_0.contextData.correctNumToEXValue[var_10_0]
end

function var_0_1.calculateLevel(arg_11_0)
	if arg_11_0.contextData.score >= arg_11_0.contextData.scoreLevel[4] then
		return 1
	elseif arg_11_0.contextData.score >= arg_11_0.contextData.scoreLevel[3] then
		return 2
	elseif arg_11_0.contextData.score >= arg_11_0.contextData.scoreLevel[2] then
		return 3
	elseif arg_11_0.contextData.score >= arg_11_0.contextData.scoreLevel[1] then
		return 4
	end

	return
end

return var_0_1
