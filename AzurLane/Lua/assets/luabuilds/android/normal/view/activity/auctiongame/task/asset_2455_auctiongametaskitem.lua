class = var_0_10000

local var_0_0 = "AuctionGameTaskItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiGoBtn

	local function var_2_2()
		local var_3_0 = arg_2_0.taskVO

		if var_0.getConfig(var_3_0, "scene") then
			local var_3_1 = #var_0

			if 0 < var_3_1 and var_0[2] and var_0[2].unlockActivityID and var_0[1] == "AUCTION_GAME_ENTRANCE" then
				getProxy = var_1
				ContextProxy = var_2

				local var_3_2 = var_1(var_2)
				local var_3_3 = var_1.getContextByMediator

				AuctionGameEntranceMediator = var_2_10003

				if var_3_3(var_3_2, var_2_10003) then
					local var_3_4 = arg_2_0
					local var_3_5 = var_1.emit

					BaseUI = var_2_10003

					var_3_5(var_3_4, var_2_10003.ON_CLOSE)

					return
				end
			end
		end

		local var_3_6 = arg_2_0
		local var_3_7 = var_1.emit

		AuctionGameTaskMediator = var_2_10003

		var_3_7(var_3_6, var_2_10003.ON_TASK_GO, arg_2_0.taskVO)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiGetBtn

	local function var_2_5()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		AuctionGameTaskMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.ON_TASK_SUBMIT, arg_2_0.taskVO)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	UIItemList = var_1_10001
	arg_2_0.rewardList = var_1_10001.New(arg_2_0.uiRewardList, arg_2_0.uiRewardItem)

	local var_2_6 = arg_2_0.rewardList

	var_1.make(var_2_6, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_5_1 + 1
			local var_5_1 = arg_2_0.taskVO
			local var_5_2 = var_4.getConfig(var_5_1, "award_display")

			Drop = var_5_1

			local var_5_3 = var_5_1.Create(var_5_2[var_5_0])

			updateDrop = var_6

			var_6(arg_5_2, var_5_3)

			onButton = var_6

			local var_5_4 = arg_2_0
			local var_5_5 = arg_5_2

			local function var_5_6()
				local var_6_0 = arg_2_0
				local var_6_1 = var_0.emit

				BaseUI = var_3_10002

				var_6_1(var_6_0, var_3_10002.ON_DROP, var_5_3)

				return
			end

			SFX_PANEL = var_2_10010

			var_6(var_5_4, var_5_5, var_5_6, var_2_10010)
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_7_0)
	return
end

function var_0_1.willExit(arg_8_0)
	arg_8_0:detach()

	return
end

function var_0_1.SetData(arg_9_0, arg_9_1)
	arg_9_0.taskVO = arg_9_1
	setText = var_1_10002

	var_1_10002(arg_9_0.uiDescText, arg_9_1:getConfig("desc"))

	local var_9_0 = arg_9_1:getConfig("target_num")
	local var_9_1 = arg_9_1:getProgress()
	local var_9_2 = arg_9_1
	local var_9_3 = arg_9_1.getConfig(var_9_2, "sub_type")

	TASK_SUB_TYPE_REPEATABLE = var_9_2

	if var_9_3 == var_9_2 then
		var_9_0 = 1
	end

	if var_9_0 < var_9_1 then
		var_9_1 = var_9_0
	end

	setText = var_9_3

	local var_9_4 = arg_9_0.uiProgressText

	string = var_6

	var_9_3(var_9_4, var_6.format("%s/%s", var_9_1, var_9_0))

	arg_9_0.uiSlider.value = var_9_1 / var_9_0

	if arg_9_1:isReceive() then
		setActive = var_4

		var_4(arg_9_0.uiGoBtn, false)

		setActive = var_4

		var_4(arg_9_0.uiGetBtn, false)

		setActive = var_4

		var_4(arg_9_0.uiGotBtn, true)
	else
		setActive = var_4

		var_4(arg_9_0.uiGotBtn, false)

		if arg_9_1:isFinish() then
			setActive = var_4

			var_4(arg_9_0.uiGoBtn, false)

			setActive = var_4

			var_4(arg_9_0.uiGetBtn, true)
		else
			setActive = var_4

			var_4(arg_9_0.uiGoBtn, true)

			setActive = var_4

			var_4(arg_9_0.uiGetBtn, false)
		end
	end

	local var_9_5 = arg_9_1:getConfig("award_display")
	local var_9_6 = arg_9_0.rewardList

	var_5.align(var_9_6, #var_9_5)

	local var_9_7 = arg_9_1
	local var_9_8 = arg_9_1.getConfig(var_9_7, "type")

	Task = var_9_7

	local var_9_9 = var_9_8 == var_9_7.TYPE_REPEATABLE

	setActive = var_6

	var_6(arg_9_0.uiRepeatableGo, var_9_9)

	return
end

return var_0_1
