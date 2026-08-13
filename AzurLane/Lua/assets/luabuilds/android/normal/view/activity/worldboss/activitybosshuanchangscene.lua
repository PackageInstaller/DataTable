class = var_0_10000

local var_0_0 = "ActivityBossHuanChangScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ActivityBossSceneTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "ActivityBossHuanChangUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.mainTF = var_1.Find(var_2_0, "adapt")

	local var_2_1 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_1, "bg")

	local var_2_2 = arg_2_0.mainTF

	arg_2_0.bottom = var_1.Find(var_2_2, "bottom")

	local var_2_3 = arg_2_0.bottom

	arg_2_0.hpBar = var_1.Find(var_2_3, "progress")
	arg_2_0.barList = {}

	for iter_2_0 = 1, 4 do
		local var_2_4 = arg_2_0.barList
		local var_2_5 = arg_2_0.hpBar

		var_2_4[iter_2_0] = var_1_10006.Find(var_2_5, iter_2_0)
	end

	local var_2_6 = arg_2_0.bottom

	arg_2_0.progressDigit = var_1.Find(var_2_6, "digit")

	local var_2_7 = arg_2_0.progressDigit

	arg_2_0.digitbig = var_1.Find(var_2_7, "big")

	local var_2_8 = arg_2_0.progressDigit

	arg_2_0.digitsmall = var_1.Find(var_2_8, "small")

	local var_2_9 = arg_2_0.mainTF

	arg_2_0.left = var_1.Find(var_2_9, "left")

	local var_2_10 = arg_2_0.mainTF

	arg_2_0.right = var_1.Find(var_2_10, "right")

	local var_2_11 = arg_2_0.right

	arg_2_0.rankTF = var_1.Find(var_2_11, "rank")
	CustomIndexLayer = var_1

	local var_2_12 = var_1.Clone2Full
	local var_2_13 = arg_2_0.rankTF

	arg_2_0.rankList = var_2_12(var_2.Find(var_2_13, "layout"), 3)
	ipairs = var_1

	for iter_2_1, iter_2_2 in var_1(arg_2_0.rankList) do
		setActive = var_1_10006

		var_1_10006(iter_2_2, false)
	end

	arg_2_0.stageList = {}

	for iter_2_3 = 1, 4 do
		local var_2_14 = arg_2_0.stageList
		local var_2_15 = arg_2_0.right

		var_2_14[iter_2_3] = var_6.Find(var_2_15, iter_2_3)
	end

	local var_2_16 = arg_2_0.right

	arg_2_0.stageSP = var_1.Find(var_2_16, "6")
	IsNil = var_1

	if not var_1(arg_2_0.stageSP) then
		setActive = var_1

		var_1(arg_2_0.stageSP, false)
	end

	local var_2_17 = arg_2_0.right

	arg_2_0.awardFlash = var_1.Find(var_2_17, "ptaward/flash")

	local var_2_18 = arg_2_0.right

	arg_2_0.awardBtn = var_1.Find(var_2_18, "ptaward/button")

	local var_2_19 = arg_2_0.right

	arg_2_0.ptScoreTxt = var_1.Find(var_2_19, "ptaward/Text")

	local var_2_20 = arg_2_0.mainTF

	arg_2_0.top = var_1.Find(var_2_20, "top")

	local var_2_21 = arg_2_0.top

	arg_2_0.ticketNum = var_1.Find(var_2_21, "ticket/Text")

	local var_2_22 = arg_2_0.top

	arg_2_0.helpBtn = var_1.Find(var_2_22, "help")
	onButton = var_1

	local var_2_23 = arg_2_0
	local var_2_24 = arg_2_0.top
	local var_2_25 = var_3.Find(var_2_24, "back_btn")

	local function var_2_26()
		local var_3_0 = arg_2_0

		var_0.emit(var_3_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_5

	var_1(var_2_23, var_2_25, var_2_26, var_5)

	setActive = var_1

	var_1(arg_2_0.top, false)

	setAnchoredPosition = var_1

	var_1(arg_2_0.top, {
		y = 1080
	})

	setActive = var_1

	var_1(arg_2_0.left, false)

	setAnchoredPosition = var_1

	var_1(arg_2_0.left, {
		x = -1920
	})

	setActive = var_1

	var_1(arg_2_0.right, false)

	setAnchoredPosition = var_1

	var_1(arg_2_0.right, {
		x = 1920
	})

	setActive = var_1

	var_1(arg_2_0.bottom, false)

	setAnchoredPosition = var_1

	var_1(arg_2_0.bottom, {
		y = -1080
	})
	arg_2_0:buildCommanderPanel()

	return
end

function var_0_1.UpdateDropItems(arg_4_0)
	ipairs = var_1_10001

	local var_4_0

	if not arg_4_0.contextData.DisplayItems then
		var_4_0 = {}
	end

	for iter_4_0, iter_4_1 in var_1_10001(var_4_0) do
		local var_4_1 = arg_4_0.barList[iter_4_0]
		local var_4_2 = var_6.Find(var_4_1, "milestone/item")
		local var_4_3 = {
			type = arg_4_0.contextData.DisplayItems[5 - iter_4_0][1],
			id = arg_4_0.contextData.DisplayItems[5 - iter_4_0][2],
			count = arg_4_0.contextData.DisplayItems[5 - iter_4_0][3]
		}

		updateDrop = var_8

		var_8(var_4_2:GetChild(0), var_4_3)

		onButton = var_8

		local var_4_4 = arg_4_0
		local var_4_5 = var_4_2

		local function var_4_6()
			local var_5_0 = arg_4_0

			var_0.emit(var_5_0, var_0_1.ON_DROP, var_4_3)

			return
		end

		SFX_PANEL = var_1_10012

		var_8(var_4_4, var_4_5, var_4_6, var_1_10012)
	end

	return
end

function var_0_1.UpdatePage(arg_6_0)
	local var_6_0 = arg_6_0.contextData.bossHP

	setText = var_1_10002

	local var_6_1 = arg_6_0.digitbig

	math = var_1_10004

	var_1_10002(var_6_1, var_1_10004.floor(var_6_0 / 100))

	setText = var_1_10002

	local var_6_2 = arg_6_0.digitsmall

	string = var_4

	var_1_10002(var_6_2, var_4.format("%02d", var_6_0 % 100) .. "%")

	pg = var_1_10002

	local var_6_3 = var_1_10002.TimeMgr.GetInstance()

	for iter_6_0 = 1, 4 do
		local var_6_4 = arg_6_0.barList[iter_6_0]

		setSlider = var_1_10008
		var_1_10009 = var_6_4:Find("Slider")

		local var_6_5 = 0
		local var_6_6 = 2500

		math = var_1_10012
		var_1_10012 = var_1_10012.min
		math = var_1_10013

		var_1_10008(var_1_10009, var_6_5, var_6_6, var_1_10012(var_1_10013.max(var_6_0 - (iter_6_0 - 1) * 2500, 0), 2500))

		var_1_10008 = arg_6_0.contextData.mileStones[5 - iter_6_0]
		setActive = var_1_10009

		var_1_10009(var_6_4:Find("milestone/item"), not var_1_10008)

		setActive = var_1_10009

		var_1_10009(var_6_4:Find("milestone/time"), var_1_10008)

		if var_1_10008 then
			local var_6_7 = var_6_3

			var_1_10009 = var_6_3.STimeDescC(var_6_7, arg_6_0.contextData.mileStones[5 - iter_6_0], "%m/%d/%H:%M")
			setText = var_6_7
			var_1_10012 = var_6_4

			var_6_7(var_6_4.Find(var_1_10012, "milestone/time/Text"), var_1_10009)
		end
	end

	for iter_6_1 = 1, #arg_6_0.stageList - 1 do
		local var_6_8 = arg_6_0.contextData.normalStageIDs[iter_6_1]
		local var_6_9 = arg_6_0.stageList[iter_6_1]

		ipairs = var_1_10009

		for iter_6_2, iter_6_3 in var_1_10009(arg_6_0.contextData.ticketInitPools) do
			ipairs = var_1_10014

			for iter_6_4, iter_6_5 in var_1_10014(iter_6_3[1]) do
				if iter_6_5 == var_6_8 then
					local var_6_10 = iter_6_3[2]
					local var_6_11

					if not arg_6_0.contextData.stageTickets[var_6_8] then
						var_6_11 = 0
					end

					local var_6_12 = var_6_9
					local var_6_13 = var_6_9.Find(var_6_12, "count")

					setActive = var_6_12

					var_6_12(var_6_13, var_6_11 > 0)

					setText = var_6_12

					var_6_12(var_6_13:Find("res"), var_6_11)

					setText = var_6_12

					var_6_12(var_6_13:Find("max"), var_6_10)
				end
			end
		end
	end

	setText = var_3

	var_3(arg_6_0.ptScoreTxt, arg_6_0.contextData.ptData.count)

	setActive = var_3

	local var_6_14 = arg_6_0.awardFlash
	local var_6_15 = arg_6_0.contextData.ptData

	var_3(var_6_14, var_5.CanGetAward(var_6_15))

	if arg_6_0.bonusWindow then
		local var_6_16 = arg_6_0.bonusWindow

		if var_3.IsShowing(var_6_16) then
			local var_6_17 = arg_6_0.bonusWindow.buffer

			var_3.UpdateView(var_6_17, arg_6_0.contextData.ptData)
		end
	end

	local var_6_18 = arg_6_0
	local var_6_19 = arg_6_0.GetEXTicket(var_6_18)

	setText = var_6_18

	var_6_18(arg_6_0.ticketNum, var_6_19)

	return
end

function var_0_1.UpdateRank(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or {}

	for iter_7_0 = 1, #arg_7_0.rankList do
		local var_7_0 = arg_7_0.rankList[iter_7_0]

		setActive = var_1_10007

		var_1_10007(var_7_0, iter_7_0 <= #arg_7_1)

		if iter_7_0 <= #arg_7_1 then
			local var_7_1 = var_7_0

			var_1_10007 = var_7_0.Find(var_7_1, "Text")
			tostring = var_7_1

			local var_7_3

			if #var_7_1(arg_7_1[iter_7_0].name) >= 11 then
				local var_7_2 = var_1_10007

				var_7_3 = var_1_10007.GetComponent
				typeof = var_1_10011
				Text = var_1_10012
				var_7_3 = var_7_3(var_7_2, var_1_10011(var_1_10012))
				var_7_3.fontSize = 23
			else
				local var_7_4 = var_1_10007

				var_7_3 = var_1_10007.GetComponent
				typeof = var_1_10011
				Text = var_1_10012
				var_7_3 = var_7_3(var_7_4, var_1_10011(var_1_10012))
				var_7_3.fontSize = 28
			end

			setText = var_7_3

			var_7_3(var_1_10007, var_8)
		end
	end

	return
end

return var_0_1
