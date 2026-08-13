class = var_0_10000

local var_0_0 = "ZhenhaiMuseumPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))
local var_0_2 = 7
local var_0_3

function var_0_1.initSkin(arg_1_0)
	local var_1_0

	if not (arg_1_0.activity.data3 < var_0_2) or not arg_1_0.activity.data3 then
		var_1_0 = var_0_2
	end

	arg_1_0.showItemNum = var_1_0
	findTF = var_1_0
	arg_1_0.skinTf = var_1_0(arg_1_0._tf, "AD/skinPage")
	setActive = var_1

	var_1(arg_1_0.skinTf, false)

	findTF = var_1
	arg_1_0.descClose = var_1(arg_1_0._tf, "AD/skinPage/descClose")
	setText = var_1

	local var_1_1 = arg_1_0.descClose

	i18n = var_3

	var_1(var_1_1, var_3("island_act_tips1"))

	arg_1_0.skinIndex = 0

	arg_1_0:pageUpdate()

	findTF = var_1
	arg_1_0.bottom = var_1(arg_1_0.skinTf, "bottom")
	onButton = var_1

	var_1(arg_1_0, arg_1_0.bottom, function()
		if var_0_3 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_3 < 0.5 then
				return
			end
		end

		Time = var_0
		var_0_3 = var_0.realtimeSinceStartup

		if arg_1_0.playHandle then
			arg_1_0.playHandle()

			arg_1_0.playHandle = nil
		end

		local var_2_0 = arg_1_0

		var_0.displayWindow(var_2_0, false)

		return
	end)

	onButton = var_1

	local var_1_2 = arg_1_0

	findTF = var_3

	var_1(var_1_2, var_3(arg_1_0.skinTf, "left"), function()
		if var_0_3 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_3 < 0.5 then
				return
			end
		end

		Time = var_0
		var_0_3 = var_0.realtimeSinceStartup

		if arg_1_0.skinIndex > 0 then
			local var_3_0 = arg_1_0.skinIndex

			arg_1_0.skinIndex = arg_1_0.skinIndex - 1

			local var_3_1 = arg_1_0

			var_1.updateSkinUI(var_3_1)

			setActive = var_1
			findTF = var_3_1

			var_1(var_3_1(arg_1_0.skinTf, "skins/skin" .. var_3_0), true)

			local var_3_2 = arg_1_0

			var_1.StartTimer(var_3_2, function()
				setActive = var_3_10000
				findTF = var_3_10001

				var_3_10000(var_3_10001(arg_1_0.skinTf, "skins/skin" .. var_3_0), false)

				return
			end)

			findTF = var_1

			local var_3_3 = var_1(arg_1_0.skinTf, "skins/skin" .. var_3_0)
			local var_3_4 = var_1.GetComponent

			typeof = var_3
			Animation = var_4

			local var_3_5 = var_3_4(var_3_3, var_3(var_4))

			var_1.Play(var_3_5, "anim_zhenhaimuseum_skin_left")
		end

		return
	end)

	onButton = var_1

	local var_1_3 = arg_1_0

	findTF = var_3

	var_1(var_1_3, var_3(arg_1_0.skinTf, "right"), function()
		if var_0_3 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_3 < 0.5 then
				return
			end
		end

		Time = var_0
		var_0_3 = var_0.realtimeSinceStartup

		if arg_1_0.skinIndex < arg_1_0.showItemNum then
			local var_5_0 = arg_1_0.skinIndex

			arg_1_0.skinIndex = arg_1_0.skinIndex + 1

			local var_5_1 = arg_1_0

			var_1.updateSkinUI(var_5_1)

			setActive = var_1
			findTF = var_5_1

			var_1(var_5_1(arg_1_0.skinTf, "skins/skin" .. var_5_0), true)

			local var_5_2 = arg_1_0

			var_1.StartTimer(var_5_2, function()
				setActive = var_3_10000
				findTF = var_3_10001

				var_3_10000(var_3_10001(arg_1_0.skinTf, "skins/skin" .. var_5_0), false)

				return
			end)

			findTF = var_1

			local var_5_3 = var_1(arg_1_0.skinTf, "skins/skin" .. arg_1_0.skinIndex)
			local var_5_4 = var_1.GetComponent

			typeof = var_3
			Animation = var_4

			local var_5_5 = var_5_4(var_5_3, var_3(var_4))

			var_1.Play(var_5_5, "anim_zhenhaimuseum_skin_right")
		end

		return
	end)

	for iter_1_0 = 0, var_0_2 do
		onButton = var_5

		local var_1_4 = arg_1_0

		findTF = var_1_10007

		var_5(var_1_4, var_1_10007(arg_1_0.skinTf, "page/" .. iter_1_0), function()
			if var_0_3 then
				Time = var_0

				if var_0.realtimeSinceStartup - var_0_3 < 0.5 then
					return
				end
			end

			Time = var_0
			var_0_3 = var_0.realtimeSinceStartup

			if arg_1_0.skinIndex ~= iter_1_0 then
				local var_7_0 = arg_1_0.skinIndex

				if arg_1_0.skinIndex < iter_1_0 then
					arg_1_0.skinIndex = arg_1_0.skinIndex + 1

					local var_7_1 = arg_1_0

					var_1.updateSkinUI(var_7_1)

					setActive = var_1
					findTF = var_7_1

					var_1(var_7_1(arg_1_0.skinTf, "skins/skin" .. var_7_0), true)

					local var_7_2 = arg_1_0

					var_1.StartTimer(var_7_2, function()
						setActive = var_3_10000
						findTF = var_3_10001

						var_3_10000(var_3_10001(arg_1_0.skinTf, "skins/skin" .. var_7_0), false)

						return
					end)

					findTF = var_1

					local var_7_3 = var_1(arg_1_0.skinTf, "skins/skin" .. arg_1_0.skinIndex)
					local var_7_4 = var_1.GetComponent

					typeof = var_3
					Animation = var_4

					local var_7_5 = var_7_4(var_7_3, var_3(var_4))

					var_1.Play(var_7_5, "anim_zhenhaimuseum_skin_right")
				else
					arg_1_0.skinIndex = arg_1_0.skinIndex - 1

					local var_7_6 = arg_1_0

					var_1.updateSkinUI(var_7_6)

					setActive = var_1
					findTF = var_7_6

					var_1(var_7_6(arg_1_0.skinTf, "skins/skin" .. var_7_0), true)

					local var_7_7 = arg_1_0

					var_1.StartTimer(var_7_7, function()
						setActive = var_3_10000
						findTF = var_3_10001

						var_3_10000(var_3_10001(arg_1_0.skinTf, "skins/skin" .. var_7_0), false)

						return
					end)

					findTF = var_1

					local var_7_8 = var_1(arg_1_0.skinTf, "skins/skin" .. var_7_0)
					local var_7_9 = var_1.GetComponent

					typeof = var_3
					Animation = var_4

					local var_7_10 = var_7_9(var_7_8, var_3(var_4))

					var_1.Play(var_7_10, "anim_zhenhaimuseum_skin_left")
				end
			end

			return
		end)

		setActive = var_5
		findTF = var_1_4

		local var_1_5 = var_1_4(arg_1_0.skinTf, "page/" .. iter_1_0)

		var_1_10007 = iter_1_0 <= arg_1_0.showItemNum

		var_5(var_1_5, var_1_10007)
	end

	setActive = var_1

	var_1(arg_1_0.skinTf, false)

	return
end

function var_0_1.UpdateTask(arg_10_0, arg_10_1, arg_10_2)
	var_0_1.super.UpdateTask(arg_10_0, arg_10_1, arg_10_2)

	local var_10_0 = arg_10_1 + 1
	local var_10_1 = arg_10_0.taskGroup[arg_10_0.nday][var_10_0]
	local var_10_2 = arg_10_0.taskProxy
	local var_10_4

	if not var_5.getTaskById(var_10_2, var_10_1) then
		local var_10_3 = arg_10_0.taskProxy

		var_10_4 = var_5.getFinishTaskById(var_10_3, var_10_1)
	end

	local var_10_5 = arg_10_2
	local var_10_6 = arg_10_2.Find(var_10_5, "get_btn")

	onButton = var_10_5

	local var_10_7 = arg_10_0
	local var_10_8 = var_10_6

	local function var_10_9()
		if arg_10_0.nday <= var_0_2 then
			arg_10_0.skinIndex = arg_10_0.nday

			function arg_10_0.playHandle()
				local var_12_0 = arg_10_0
				local var_12_1 = var_0.emit

				ActivityMediator = var_3_10002

				var_12_1(var_12_0, var_3_10002.ON_TASK_SUBMIT, var_10_4)

				return
			end

			local var_11_0 = arg_10_0

			var_0.displayWindow(var_11_0, true)
		else
			local var_11_1 = arg_10_0
			local var_11_2 = var_0.emit

			ActivityMediator = var_2_10002

			var_11_2(var_11_1, var_2_10002.ON_TASK_SUBMIT, var_10_4)
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_10_5(var_10_7, var_10_8, var_10_9, var_1_10011)

	local var_10_10 = arg_10_2
	local var_10_11 = arg_10_2.Find(var_10_10, "got_btn")

	onButton = var_10_10

	local var_10_12 = arg_10_0
	local var_10_13 = var_10_11

	local function var_10_14()
		local var_13_0 = arg_10_0

		var_0.displayWindow(var_13_0, true)

		return
	end

	SFX_PANEL = var_1_10012

	var_10_10(var_10_12, var_10_13, var_10_14, var_1_10012)

	local var_10_15 = arg_10_0.bg
	local var_10_16 = var_8.Find(var_10_15, "review_btn")

	onButton = var_10_15

	local var_10_17 = arg_10_0
	local var_10_18 = var_10_16

	local function var_10_19()
		local var_14_0 = arg_10_0

		var_0.displayWindow(var_14_0, true)

		return
	end

	SFX_PANEL = var_1_10013

	var_10_15(var_10_17, var_10_18, var_10_19, var_1_10013)

	return
end

function var_0_1.pageUpdate(arg_15_0)
	for iter_15_0 = 0, var_0_2 do
		setActive = var_1_10005
		findTF = var_1_10006

		var_1_10005(var_1_10006(arg_15_0.skinTf, "page/" .. iter_15_0), iter_15_0 <= arg_15_0.showItemNum)

		setActive = var_1_10005
		findTF = var_1_10006

		var_1_10005(var_1_10006(arg_15_0.skinTf, "page/" .. iter_15_0 .. "/selected"), arg_15_0.skinIndex == iter_15_0)

		setActive = var_1_10005
		findTF = var_1_10006

		var_1_10005(var_1_10006(arg_15_0.skinTf, "skins/skin" .. iter_15_0), arg_15_0.skinIndex == iter_15_0)

		findTF = var_1_10005
		var_1_10006 = var_1_10005(arg_15_0.skinTf, "skins/skin" .. iter_15_0)
		var_1_10005 = var_1_10005.GetComponent
		typeof = var_7
		Image = var_8
		var_1_10005 = var_1_10005(var_1_10006, var_7(var_8))
		var_1_10005.fillAmount = 1
	end

	return
end

function var_0_1.OnFirstFlush(arg_16_0)
	var_0_1.super.OnFirstFlush(arg_16_0)

	arg_16_0.skinIndex = arg_16_0.activity.data3 > var_0_2 and 0 or arg_16_0.activity.data3

	arg_16_0:initSkin()

	return
end

function var_0_1.OnUpdateFlush(arg_17_0)
	arg_17_0.nday = arg_17_0.activity.data3

	local var_17_0 = arg_17_0.activity
	local var_17_1 = var_1.getConfig(var_17_0, "config_client").story

	checkExist = var_17_0

	if var_17_0(var_17_1, {
		1
	}, {
		1
	}) then
		pg = var_2

		local var_17_2 = var_2.NewStoryMgr.GetInstance()

		var_2.Play(var_17_2, var_17_1[1][1])
	end

	local var_17_3 = arg_17_0.uilist

	var_2.align(var_17_3, #arg_17_0.taskGroup[arg_17_0.nday])

	return
end

function var_0_1.updateSkinUI(arg_18_0)
	if arg_18_0.playHandle then
		setActive = var_1
		findTF = var_1_10002

		var_1(var_1_10002(arg_18_0.skinTf, "left"), false)

		setActive = var_1
		findTF = var_1_10002

		var_1(var_1_10002(arg_18_0.skinTf, "right"), false)

		setActive = var_1
		findTF = var_1_10002

		var_1(var_1_10002(arg_18_0.skinTf, "page"), false)
	else
		setActive = var_1
		findTF = var_1_10002

		var_1(var_1_10002(arg_18_0.skinTf, "left"), arg_18_0.skinIndex > 0)

		setActive = var_1
		findTF = var_2

		var_1(var_2(arg_18_0.skinTf, "right"), arg_18_0.skinIndex < arg_18_0.showItemNum)

		setActive = var_1
		findTF = var_2

		var_1(var_2(arg_18_0.skinTf, "page"), true)
	end

	arg_18_0:pageUpdate()

	return
end

function var_0_1.displayWindow(arg_19_0, arg_19_1)
	if arg_19_0.blurFlag == arg_19_1 then
		return
	end

	local var_19_1

	if arg_19_1 then
		setActive = var_19_1

		var_19_1(arg_19_0.skinTf, true)

		local var_19_0 = arg_19_0.skinTf

		var_19_1 = var_19_1.GetComponent
		typeof = var_4
		Animation = var_1_10005

		local var_19_2 = var_19_1(var_19_0, var_4(var_1_10005))

		var_19_1.Play(var_19_2, "anim_zhenhaimuseum_in")

		pg = var_19_1

		local var_19_3 = var_19_1.UIMgr.GetInstance()

		var_19_1.BlurPanel(var_19_3, arg_19_0.skinTf, {
			staticBlur = true
		})

		var_19_1 = arg_19_0.taskGroup[arg_19_0.nday][1]

		local var_19_4 = arg_19_0.taskProxy
		local var_19_6

		if not var_3.getTaskById(var_19_4, var_19_1) then
			local var_19_5 = arg_19_0.taskProxy

			var_19_6 = var_3.getFinishTaskById(var_19_5, var_19_1)
		end

		var_1_10005 = var_19_6

		local var_19_7 = var_19_6.getTaskStatus(var_1_10005)

		if not (arg_19_0.activity.data3 < var_0_2) or not arg_19_0.activity.data3 then
			var_1_10005 = var_0_2
		end

		arg_19_0.showItemNum = var_1_10005

		if var_19_7 ~= 2 then
			arg_19_0.showItemNum = arg_19_0.showItemNum - 1
		end

		local var_19_8 = arg_19_0

		arg_19_0.updateSkinUI(var_19_8)

		if arg_19_0.playHandle then
			var_1_10005 = arg_19_0.nday - 1
			setActive = var_19_8
			findTF = var_1_10007

			var_19_8(var_1_10007(arg_19_0.skinTf, "skins/skin" .. var_1_10005), true)
			arg_19_0:StartTimer(function()
				setActive = var_2_10000
				findTF = var_2_10001

				var_2_10000(var_2_10001(arg_19_0.skinTf, "skins/skin" .. var_1_10005), false)

				return
			end)

			findTF = var_6

			local var_19_9 = var_6(arg_19_0.skinTf, "skins/skin" .. arg_19_0.skinIndex)
			local var_19_10 = var_6.GetComponent

			typeof = var_8
			Animation = var_9

			local var_19_11 = var_19_10(var_19_9, var_8(var_9))

			var_6.Play(var_19_11, "anim_zhenhaimuseum_skin_right")
		end
	else
		pg = var_19_1

		local var_19_12 = var_19_1.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_19_12, arg_19_0.skinTf)

		local var_19_13 = arg_19_0.skinTf
		local var_19_14 = var_2.GetComponent

		typeof = var_4
		Animation = var_1_10005

		local var_19_15 = var_19_14(var_19_13, var_4(var_1_10005))

		var_2.Play(var_19_15, "anim_zhenhaimuseum_out")
		arg_19_0:StartTimer(function()
			setActive = var_2_10000

			var_2_10000(arg_19_0.skinTf, false)

			return
		end)
	end

	arg_19_0.blurFlag = arg_19_1

	return
end

function var_0_1.StartTimer(arg_22_0, arg_22_1)
	arg_22_0:RemoveTimer()

	Timer = var_2
	arg_22_0.timer = var_2.New(arg_22_1, 0.5, 1)

	local var_22_0 = arg_22_0.timer

	var_2.Start(var_22_0)

	return
end

function var_0_1.RemoveTimer(arg_23_0)
	if arg_23_0.timer then
		local var_23_0 = arg_23_0.timer

		var_1.Stop(var_23_0)

		arg_23_0.timer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_24_0)
	var_0_1.super.OnDestroy(arg_24_0)
	arg_24_0:displayWindow(false)
	arg_24_0:RemoveTimer()

	return
end

function var_0_1.GetProgressColor(arg_25_0)
	return "#435271", "#5D7B97"
end

return var_0_1
