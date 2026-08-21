local var_0_0 = class("SnackResultView", import("...base.BaseSubView"))

var_0_0.EXTable = {
	[0] = 0,
	1,
	2,
	5
}

function var_0_0.getUIName(arg_1_0)
	return "SnackResult"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initUI()
	arg_2_0:updateView()
	arg_2_0:Show()
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.OnDestroy(arg_3_0)
	arg_3_0.lockBackPress = false

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_3_0._tf)

	return
end

function var_0_0.initUI(arg_4_0)
	local var_4_0 = arg_4_0._tf:Find("Content")

	arg_4_0.timeText = var_4_0:Find("Tip/Time/TimeText")
	arg_4_0.scoreText = var_4_0:Find("Tip/Score/ScoreText")
	arg_4_0.snackTpl = var_4_0:Find("SnackTpl")
	arg_4_0.orderListContainer = var_4_0:Find("Order/OrderList")
	arg_4_0.orderList = UIItemList.New(arg_4_0.orderListContainer, arg_4_0.snackTpl)
	arg_4_0.selectedListContainer = var_4_0:Find("Select/SelectList")
	arg_4_0.selectedList = UIItemList.New(arg_4_0.selectedListContainer, arg_4_0.snackTpl)
	arg_4_0.submitBtn = var_4_0:Find("Buttons/SubmitBtn")
	arg_4_0.continueBtn = var_4_0:Find("Buttons/ContinueBtn")

	onButton(arg_4_0, arg_4_0.submitBtn, function()
		arg_4_0.contextData.onSubmit((arg_4_0:calculateLevel()))
		arg_4_0:Destroy()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.continueBtn, function()
		arg_4_0.contextData.onContinue()
		arg_4_0:Destroy()

		return
	end)

	return
end

function var_0_0.updateView(arg_7_0)
	local var_7_0 = arg_7_0:calculateEXValue()

	if arg_7_0.contextData.countTime > 0 then
		setText(arg_7_0.timeText, arg_7_0.contextData.countTime .. "s   + " .. setColorStr(var_7_0 .. "s", "#3068E6FF"))
	else
		setText(arg_7_0.timeText, arg_7_0.contextData.countTime .. "s")
	end

	setText(arg_7_0.scoreText, arg_7_0.contextData.score .. "   + " .. setColorStr(var_7_0, "#3068E6FF"))
	arg_7_0.orderList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			setImageSprite(arg_8_2:Find("SnackImg"), GetSpriteFromAtlas("ui/snackui_atlas", "snack_" .. arg_7_0.contextData.orderIDList[arg_8_1 + 1]))
		end

		return
	end)
	arg_7_0.orderList:align(#arg_7_0.contextData.orderIDList)
	arg_7_0.selectedList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = arg_7_0.contextData.selectedIDList[arg_9_1 + 1]

			setImageSprite(arg_9_2:Find("SnackImg"), GetSpriteFromAtlas("ui/snackui_atlas", "snack_" .. arg_7_0.contextData.selectedIDList[arg_9_1 + 1]))

			local var_9_1 = arg_7_0.contextData.orderIDList[arg_9_1 + 1]
			local var_9_2 = arg_9_2:Find("ErrorImg")

			setActive(arg_9_2:Find("CorrectImg"), var_9_0 == arg_7_0.contextData.orderIDList[arg_9_1 + 1])
			setActive(var_9_2, var_9_0 ~= var_9_1)
		end

		return
	end)
	arg_7_0.selectedList:align(#arg_7_0.contextData.selectedIDList)

	if arg_7_0.contextData.countTime == 0 then
		setActive(arg_7_0.continueBtn, false)
	end

	arg_7_0.contextData.countTime = arg_7_0.contextData.countTime + var_7_0
	arg_7_0.contextData.score = arg_7_0.contextData.score + var_7_0

	return
end

function var_0_0.calculateEXValue(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.contextData.selectedIDList) do
		if arg_10_0.contextData.orderIDList[iter_10_0] == iter_10_1 then
			var_10_0 = var_10_0 + 1
		end
	end

	return arg_10_0.contextData.correctNumToEXValue[var_10_0]
end

function var_0_0.calculateLevel(arg_11_0)
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

return var_0_0
