class = var_0_10000

local var_0_0 = "PlantNaximofuPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	arg_1_0.clickTime = nil

	return
end

function var_0_1.initSkin(arg_2_0)
	local var_2_0

	if not (arg_2_0.activity.data3 < arg_2_0.itmeNum) or not arg_2_0.activity.data3 then
		var_2_0 = arg_2_0.itmeNum
	end

	arg_2_0.showItemNum = var_2_0
	findTF = var_2_0
	arg_2_0.skinTf = var_2_0(arg_2_0._tf, "AD/skinPage")
	setActive = var_1

	var_1(arg_2_0.skinTf, false)

	findTF = var_1
	arg_2_0.descClose = var_1(arg_2_0._tf, "AD/skinPage/descClose")
	setText = var_1

	local var_2_1 = arg_2_0.descClose

	i18n = var_4

	var_1(var_2_1, var_4("island_act_tips1"))

	arg_2_0.skinIndex = 1

	arg_2_0:pageUpdate()

	findTF = var_1
	arg_2_0.bottom = var_1(arg_2_0.skinTf, "bottom")
	onButton = var_1

	var_1(arg_2_0, arg_2_0.bottom, function()
		if arg_2_0.clickTime then
			Time = var_0

			if var_0.realtimeSinceStartup - arg_2_0.clickTime < 0.5 then
				return
			end
		end

		local var_3_0 = arg_2_0

		Time = var_2_10001
		var_3_0.clickTime = var_2_10001.realtimeSinceStartup

		local var_3_1 = arg_2_0

		var_0.displayWindow(var_3_1, false)

		if arg_2_0.playHandle then
			arg_2_0.playHandle()

			arg_2_0.playHandle = nil
		end

		return
	end)

	onButton = var_1

	local var_2_2 = arg_2_0

	findTF = var_4

	var_1(var_2_2, var_4(arg_2_0.skinTf, "leftGo/left"), function()
		if arg_2_0.clickTime then
			Time = var_0

			if var_0.realtimeSinceStartup - arg_2_0.clickTime < 0.5 then
				return
			end
		end

		local var_4_0 = arg_2_0

		Time = var_2_10001
		var_4_0.clickTime = var_2_10001.realtimeSinceStartup

		if arg_2_0.skinIndex > 1 then
			local var_4_1 = arg_2_0.displayDayList[arg_2_0.skinIndex]

			arg_2_0.skinIndex = arg_2_0.skinIndex - 1

			local var_4_2 = arg_2_0

			var_1.updateSkinUI(var_4_2)

			setActive = var_1
			findTF = var_4_2

			var_1(var_4_2(arg_2_0.skinTf, "skins/skin" .. var_4_1), true)

			local var_4_3 = arg_2_0

			var_1.StartTimer(var_4_3, function()
				setActive = var_3_10000
				findTF = var_3_10002

				var_3_10000(var_3_10002(arg_2_0.skinTf, "skins/skin" .. var_4_1), false)

				return
			end)

			findTF = var_1

			local var_4_4 = var_1(arg_2_0.skinTf, "skins/skin" .. var_4_1)
			local var_4_5 = var_1.GetComponent

			typeof = var_4
			Animation = var_6

			local var_4_6 = var_4_5(var_4_4, var_4(var_6))

			var_1.Play(var_4_6, "anim_zhenhaimuseum_skin_left")
		end

		return
	end)

	onButton = var_1

	local var_2_3 = arg_2_0

	findTF = var_4

	var_1(var_2_3, var_4(arg_2_0.skinTf, "rightGo/right"), function()
		if arg_2_0.clickTime then
			Time = var_0

			if var_0.realtimeSinceStartup - arg_2_0.clickTime < 0.5 then
				return
			end
		end

		local var_6_0 = arg_2_0

		Time = var_2_10001
		var_6_0.clickTime = var_2_10001.realtimeSinceStartup

		if arg_2_0.displayDayList[arg_2_0.skinIndex] < arg_2_0.showItemNum then
			local var_6_1 = arg_2_0.displayDayList[arg_2_0.skinIndex]

			arg_2_0.skinIndex = arg_2_0.skinIndex + 1

			local var_6_2 = arg_2_0

			var_1.updateSkinUI(var_6_2)

			setActive = var_1
			findTF = var_6_2

			var_1(var_6_2(arg_2_0.skinTf, "skins/skin" .. var_6_1), true)

			local var_6_3 = arg_2_0

			var_1.StartTimer(var_6_3, function()
				setActive = var_3_10000
				findTF = var_3_10002

				var_3_10000(var_3_10002(arg_2_0.skinTf, "skins/skin" .. var_6_1), false)

				return
			end)

			findTF = var_1

			local var_6_4 = var_1(arg_2_0.skinTf, "skins/skin" .. arg_2_0.displayDayList[arg_2_0.skinIndex])
			local var_6_5 = var_1.GetComponent

			typeof = var_4
			Animation = var_6

			local var_6_6 = var_6_5(var_6_4, var_4(var_6))

			var_1.Play(var_6_6, "anim_zhenhaimuseum_skin_right")
		end

		return
	end)

	for iter_2_0 = 1, #arg_2_0.displayDayList do
		local var_2_4 = arg_2_0.displayDayList[iter_2_0]

		onButton = var_6

		local var_2_5 = arg_2_0

		findTF = var_1_10009

		var_6(var_2_5, var_1_10009(arg_2_0.skinTf, "page/" .. var_2_4), function()
			if arg_2_0.clickTime then
				Time = var_0

				if var_0.realtimeSinceStartup - arg_2_0.clickTime < 0.5 then
					return
				end
			end

			local var_8_0 = arg_2_0

			Time = var_2_10001
			var_8_0.clickTime = var_2_10001.realtimeSinceStartup

			if arg_2_0.skinIndex ~= iter_2_0 then
				local var_8_1 = arg_2_0.displayDayList[arg_2_0.skinIndex]

				if arg_2_0.skinIndex < iter_2_0 then
					arg_2_0.skinIndex = arg_2_0.skinIndex + 1

					local var_8_2 = arg_2_0

					var_2.updateSkinUI(var_8_2)

					setActive = var_2
					findTF = var_8_2

					var_2(var_8_2(arg_2_0.skinTf, "skins/skin" .. var_8_1), true)

					local var_8_3 = arg_2_0

					var_2.StartTimer(var_8_3, function()
						setActive = var_3_10000
						findTF = var_3_10002

						var_3_10000(var_3_10002(arg_2_0.skinTf, "skins/skin" .. var_8_1), false)

						return
					end)

					findTF = var_2

					local var_8_4 = var_2(arg_2_0.skinTf, "skins/skin" .. arg_2_0.displayDayList[arg_2_0.skinIndex])
					local var_8_5 = var_2.GetComponent

					typeof = var_5
					Animation = var_7

					local var_8_6 = var_8_5(var_8_4, var_5(var_7))

					var_2.Play(var_8_6, "anim_zhenhaimuseum_skin_right")
				elseif arg_2_0.skinIndex > 1 then
					arg_2_0.skinIndex = arg_2_0.skinIndex - 1

					local var_8_7 = arg_2_0

					var_2.updateSkinUI(var_8_7)

					setActive = var_2
					findTF = var_8_7

					var_2(var_8_7(arg_2_0.skinTf, "skins/skin" .. var_8_1), true)

					local var_8_8 = arg_2_0

					var_2.StartTimer(var_8_8, function()
						setActive = var_3_10000
						findTF = var_3_10002

						var_3_10000(var_3_10002(arg_2_0.skinTf, "skins/skin" .. var_8_1), false)

						return
					end)

					findTF = var_2

					local var_8_9 = var_2(arg_2_0.skinTf, "skins/skin" .. var_8_1)
					local var_8_10 = var_2.GetComponent

					typeof = var_5
					Animation = var_7

					local var_8_11 = var_8_10(var_8_9, var_5(var_7))

					var_2.Play(var_8_11, "anim_zhenhaimuseum_skin_left")
				end
			end

			return
		end)

		setActive = var_6
		findTF = var_2_5

		local var_2_6 = var_2_5(arg_2_0.skinTf, "page/" .. var_2_4)

		var_1_10009 = var_2_4 <= arg_2_0.showItemNum

		var_6(var_2_6, var_1_10009)
	end

	return
end

function var_0_1.UpdateTask(arg_11_0, arg_11_1, arg_11_2)
	var_0_1.super.UpdateTask(arg_11_0, arg_11_1, arg_11_2)

	local var_11_0 = arg_11_1 + 1
	local var_11_1 = arg_11_0.taskGroup[arg_11_0.nday][var_11_0]
	local var_11_2 = arg_11_0.taskProxy
	local var_11_3

	if not var_5.getTaskById(var_11_2, var_11_1) then
		var_11_2 = arg_11_0.taskProxy
		var_11_3 = var_5.getFinishTaskById(var_11_2, var_11_1)
	end

	local var_11_4 = arg_11_2
	local var_11_5 = arg_11_2.Find(var_11_4, "get_btn")

	onButton = var_11_2

	local var_11_6 = arg_11_0
	local var_11_7 = var_11_5

	local function var_11_8()
		if arg_11_0.nday <= arg_11_0.itmeNum then
			function arg_11_0.playHandle()
				local var_13_0 = arg_11_0
				local var_13_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_13_1(var_13_0, var_3_10003.ON_TASK_SUBMIT, var_11_3)

				return
			end

			local var_12_0 = arg_11_0

			if var_0.GetDayIndex(var_12_0, arg_11_0.displayDayList, arg_11_0.nday) then
				local var_12_1 = arg_11_0

				var_2_10003 = arg_11_0
				var_12_1.skinIndex = var_1.GetNextDayIndex(var_2_10003, arg_11_0.displayDayList, arg_11_0.nday)

				local var_12_2 = arg_11_0

				var_0.displayWindow(var_12_2, true)
			else
				arg_11_0.playHandle()

				arg_11_0.playHandle = nil
			end
		else
			local var_12_3 = arg_11_0
			local var_12_4 = var_0.emit

			ActivityMediator = var_2_10003

			var_12_4(var_12_3, var_2_10003.ON_TASK_SUBMIT, var_11_3)
		end

		return
	end

	SFX_PANEL = var_1_10012

	var_11_2(var_11_6, var_11_7, var_11_8, var_1_10012)

	local var_11_9 = arg_11_2
	local var_11_10 = arg_11_2.Find(var_11_9, "got_btn")

	onButton = var_11_4

	local var_11_11 = arg_11_0
	local var_11_12 = var_11_10

	local function var_11_13()
		local var_14_0 = arg_11_0

		var_0.displayWindow(var_14_0, true)

		return
	end

	SFX_PANEL = var_1_10013

	var_11_4(var_11_11, var_11_12, var_11_13, var_1_10013)

	local var_11_14 = arg_11_0.bg
	local var_11_15 = var_8.Find(var_11_14, "review_btn")

	onButton = var_11_9

	local var_11_16 = arg_11_0
	local var_11_17 = var_11_15

	local function var_11_18()
		local var_15_0 = arg_11_0

		var_0.displayWindow(var_15_0, true)

		return
	end

	SFX_PANEL = var_1_10014

	var_11_9(var_11_16, var_11_17, var_11_18, var_1_10014)

	return
end

function var_0_1.GetDayIndex(arg_16_0, arg_16_1, arg_16_2)
	ipairs = var_1_10003

	for iter_16_0, iter_16_1 in var_1_10003(arg_16_1) do
		if iter_16_1 == arg_16_2 then
			return iter_16_0
		end
	end

	return
end

function var_0_1.GetNextDayIndex(arg_17_0, arg_17_1, arg_17_2)
	ipairs = var_1_10003

	for iter_17_0, iter_17_1 in var_1_10003(arg_17_1) do
		if arg_17_2 <= iter_17_1 then
			return iter_17_0
		end
	end

	return 1
end

function var_0_1.GetLastDay(arg_18_0, arg_18_1, arg_18_2)
	ipairs = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10003(arg_18_1) do
		if iter_18_1 == arg_18_2 then
			return arg_18_0.displayDayList[iter_18_0 - 1]
		end
	end

	return 0
end

function var_0_1.pageUpdate(arg_19_0)
	ipairs = var_1_10001

	for iter_19_0, iter_19_1 in var_1_10001(arg_19_0.displayDayList) do
		setActive = var_1_10006
		findTF = var_1_10008

		var_1_10006(var_1_10008(arg_19_0.skinTf, "page/" .. iter_19_1), iter_19_1 <= arg_19_0.showItemNum)

		setActive = var_1_10006
		findTF = var_1_10008

		var_1_10006(var_1_10008(arg_19_0.skinTf, "page/" .. iter_19_1 .. "/selected"), arg_19_0.skinIndex == iter_19_0)

		setActive = var_1_10006
		findTF = var_1_10008

		var_1_10006(var_1_10008(arg_19_0.skinTf, "skins/skin" .. iter_19_1), arg_19_0.skinIndex == iter_19_0)

		findTF = var_1_10006
		var_1_10008 = var_1_10006(arg_19_0.skinTf, "skins/skin" .. iter_19_1)
		var_1_10006 = var_1_10006.GetComponent
		typeof = var_9
		Image = var_11
		var_1_10006 = var_1_10006(var_1_10008, var_9(var_11))
		var_1_10006.fillAmount = 1
	end

	return
end

function var_0_1.OnFirstFlush(arg_20_0)
	local var_20_0 = arg_20_0.activity
	local var_20_1

	if not var_1.getConfig(var_20_0, "config_client").displayDay then
		var_20_1 = {
			0,
			1,
			2,
			3,
			4,
			5,
			6,
			7
		}
	end

	arg_20_0.displayDayList = var_20_1

	local var_20_2 = arg_20_0.activity

	arg_20_0.itmeNum = #var_1.getConfig(var_20_2, "config_data")

	var_0_1.super.OnFirstFlush(arg_20_0)

	arg_20_0.skinIndex = arg_20_0:GetNextDayIndex(arg_20_0.displayDayList, arg_20_0.activity.data3 > arg_20_0.itmeNum and 0 or arg_20_0.activity.data3)

	arg_20_0:initSkin()

	return
end

function var_0_1.OnUpdateFlush(arg_21_0)
	arg_21_0.nday = arg_21_0.activity.data3

	local var_21_0 = arg_21_0.activity
	local var_21_1 = var_1.getConfig(var_21_0, "config_client").story

	checkExist = var_1_10002

	if var_1_10002(var_21_1, {
		1
	}, {
		1
	}) then
		pg = var_2

		local var_21_2 = var_2.NewStoryMgr.GetInstance()

		var_2.Play(var_21_2, var_21_1[1][1])
	end

	local var_21_3 = arg_21_0.uilist

	var_2.align(var_21_3, #arg_21_0.taskGroup[arg_21_0.nday])

	return
end

function var_0_1.updateSkinUI(arg_22_0)
	if arg_22_0.playHandle then
		setActive = var_1
		findTF = var_1_10003

		var_1(var_1_10003(arg_22_0.skinTf, "leftGo"), false)

		setActive = var_1
		findTF = var_1_10003

		var_1(var_1_10003(arg_22_0.skinTf, "rightGo"), false)

		setActive = var_1
		findTF = var_1_10003

		var_1(var_1_10003(arg_22_0.skinTf, "page"), false)
	else
		local var_22_0

		if arg_22_0.skinIndex > 1 then
			findTF = var_22_0
			var_1_10003 = var_22_0(arg_22_0.skinTf, "leftGo/left")
			var_22_0 = var_22_0.GetComponent
			typeof = var_4
			CanvasGroup = var_1_10006
			var_22_0 = var_22_0(var_1_10003, var_4(var_1_10006))
			var_22_0.alpha = 1
		else
			findTF = var_22_0
			var_1_10003 = var_22_0(arg_22_0.skinTf, "leftGo/left")

			local var_22_1 = var_1.GetComponent

			typeof = var_4
			CanvasGroup = var_1_10006
			var_22_1(var_1_10003, var_4(var_1_10006)).alpha = 0.2
		end

		local var_22_2

		if arg_22_0.displayDayList[arg_22_0.skinIndex] < arg_22_0.showItemNum then
			findTF = var_22_2
			var_1_10003 = var_22_2(arg_22_0.skinTf, "rightGo/right")
			var_22_2 = var_22_2.GetComponent
			typeof = var_4
			CanvasGroup = var_1_10006
			var_22_2 = var_22_2(var_1_10003, var_4(var_1_10006))
			var_22_2.alpha = 1
		else
			findTF = var_22_2
			var_1_10003 = var_22_2(arg_22_0.skinTf, "rightGo/right")
			var_22_2 = var_22_2.GetComponent
			typeof = var_4
			CanvasGroup = var_1_10006
			var_22_2 = var_22_2(var_1_10003, var_4(var_1_10006))
			var_22_2.alpha = 0.2
		end

		setActive = var_22_2
		findTF = var_1_10003

		var_22_2(var_1_10003(arg_22_0.skinTf, "page"), true)
	end

	arg_22_0:pageUpdate()

	return
end

function var_0_1.displayWindow(arg_23_0, arg_23_1)
	if arg_23_0.blurFlag == arg_23_1 then
		return
	end

	local var_23_1

	if arg_23_1 then
		setActive = var_23_1

		var_23_1(arg_23_0.skinTf, true)

		local var_23_0 = arg_23_0.skinTf

		var_23_1 = var_23_1.GetComponent
		typeof = var_5
		Animation = var_1_10007

		local var_23_2 = var_23_1(var_23_0, var_5(var_1_10007))

		var_23_1.Play(var_23_2, "anim_plantNaximofu_in")

		pg = var_23_1

		local var_23_3 = var_23_1.UIMgr.GetInstance()

		var_23_1.BlurPanel(var_23_3, arg_23_0.skinTf, {
			staticBlur = true
		})

		var_23_1 = arg_23_0.taskGroup[arg_23_0.nday][1]

		local var_23_4 = arg_23_0.taskProxy
		local var_23_6

		if not var_3.getTaskById(var_23_4, var_23_1) then
			local var_23_5 = arg_23_0.taskProxy

			var_23_6 = var_3.getFinishTaskById(var_23_5, var_23_1)
		end

		local var_23_7 = var_23_6:getTaskStatus()
		local var_23_8

		if not (arg_23_0.activity.data3 < arg_23_0.itmeNum) or not arg_23_0.activity.data3 then
			var_23_8 = arg_23_0.itmeNum
		end

		arg_23_0.showItemNum = var_23_8

		if var_23_7 ~= 2 then
			arg_23_0.showItemNum = arg_23_0.showItemNum - 1
		end

		var_1_10007 = arg_23_0

		arg_23_0.updateSkinUI(var_1_10007)

		if arg_23_0.playHandle then
			var_1_10007 = arg_23_0

			local var_23_9 = arg_23_0.GetLastDay(var_1_10007, arg_23_0.displayDayList, arg_23_0.nday)

			setActive = var_6
			findTF = var_8

			var_6(var_8(arg_23_0.skinTf, "skins/skin" .. var_23_9), true)
			arg_23_0:StartTimer(function()
				setActive = var_2_10000
				findTF = var_2_10002

				var_2_10000(var_2_10002(arg_23_0.skinTf, "skins/skin" .. var_23_9), false)

				return
			end)

			findTF = var_6

			local var_23_10 = var_6(arg_23_0.skinTf, "skins/skin" .. arg_23_0.displayDayList[arg_23_0.skinIndex])
			local var_23_11 = var_6.GetComponent

			typeof = var_9
			Animation = var_11

			local var_23_12 = var_23_11(var_23_10, var_9(var_11))

			var_6.Play(var_23_12, "anim_zhenhaimuseum_skin_right")
		end
	else
		pg = var_23_1

		local var_23_13 = var_23_1.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_23_13, arg_23_0.skinTf)

		local var_23_14 = arg_23_0.skinTf
		local var_23_15 = var_2.GetComponent

		typeof = var_5
		Animation = var_1_10007

		local var_23_16 = var_23_15(var_23_14, var_5(var_1_10007))

		var_2.Play(var_23_16, "anim_plantNaximofu_out")
		arg_23_0:StartTimer(function()
			setActive = var_2_10000

			var_2_10000(arg_23_0.skinTf, false)

			SetParent = var_2_10000

			var_2_10000(arg_23_0.skinTf, arg_23_0._tf)

			return
		end)
	end

	arg_23_0.blurFlag = arg_23_1

	return
end

function var_0_1.StartTimer(arg_26_0, arg_26_1)
	arg_26_0:RemoveTimer()

	Timer = var_2
	arg_26_0.timer = var_2.New(arg_26_1, 0.5, 1)

	local var_26_0 = arg_26_0.timer

	var_2.Start(var_26_0)

	return
end

function var_0_1.RemoveTimer(arg_27_0)
	if arg_27_0.timer then
		local var_27_0 = arg_27_0.timer

		var_1.Stop(var_27_0)

		arg_27_0.timer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_28_0)
	var_0_1.super.OnDestroy(arg_28_0)
	arg_28_0:displayWindow(false)
	arg_28_0:RemoveTimer()

	return
end

function var_0_1.GetProgressColor(arg_29_0)
	return "#34480CFF", "#34480C66"
end

return var_0_1
