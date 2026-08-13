class = var_0_10000

local var_0_0 = "Mv1PtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))
local var_0_2 = 3
local var_0_3

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	return
end

function var_0_1.initMv(arg_2_0)
	arg_2_0.showItemNum = var_0_2
	findTF = var_1
	arg_2_0.mvTf = var_1(arg_2_0._tf, "AD/mvPage")
	setActive = var_1

	var_1(arg_2_0.mvTf, false)

	findTF = var_1
	arg_2_0.mvContent = var_1(arg_2_0._tf, "AD/mvPage/movie/view/content")
	findTF = var_1
	arg_2_0.movieWord = var_1(arg_2_0._tf, "AD/mvPage/movie/movieWord")
	findTF = var_1
	arg_2_0.descClose = var_1(arg_2_0._tf, "AD/mvPage/descClose")
	setText = var_1

	local var_2_0 = arg_2_0.descClose

	i18n = var_4

	var_1(var_2_0, var_4("island_act_tips1"))

	arg_2_0.mvIndex = 1

	arg_2_0:pageUpdate()

	findTF = var_1
	arg_2_0.mvBottom = var_1(arg_2_0.mvTf, "bottom")
	findTF = var_1
	arg_2_0.btnPlay = var_1(arg_2_0.mvTf, "movie/btnPlay")
	findTF = var_1
	arg_2_0.btnStop = var_1(arg_2_0.mvTf, "movie/btnStop")
	findTF = var_1
	arg_2_0.btnRepeat = var_1(arg_2_0.mvTf, "movie/btnRepeat")
	onButton = var_1

	var_1(arg_2_0, arg_2_0.btnPlay, function()
		if var_0_3 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_3 < 1 then
				return
			end
		end

		Time = var_0
		var_0_3 = var_0.realtimeSinceStartup

		if arg_2_0.mvManaCpkUI and not arg_2_0.mvCompleteFlag then
			print = var_0

			var_0("恢复播放")

			local var_3_0 = arg_2_0.mvManaCpkUI

			var_0.Pause(var_3_0, false)

			local var_3_1 = arg_2_0

			var_0.onPlayerStart(var_3_1)
		end

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.btnStop, function()
		if var_0_3 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_3 < 1 then
				return
			end
		end

		Time = var_0
		var_0_3 = var_0.realtimeSinceStartup

		if arg_2_0.mvManaCpkUI and not arg_2_0.mvCompleteFlag then
			print = var_0

			var_0("暂停播放")

			local var_4_0 = arg_2_0.mvManaCpkUI

			var_0.Pause(var_4_0, true)

			local var_4_1 = arg_2_0

			var_0.onPlayerStop(var_4_1)
		end

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.btnRepeat, function()
		if var_0_3 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_3 < 1 then
				return
			end
		end

		Time = var_0
		var_0_3 = var_0.realtimeSinceStartup

		if arg_2_0.mvManaCpkUI and arg_2_0.mvCompleteFlag then
			print = var_0

			var_0("重新播放")

			local var_5_0 = arg_2_0

			var_0.loadMv(var_5_0)
		end

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.mvBottom, function()
		if var_0_3 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_3 < 1 then
				return
			end
		end

		Time = var_0
		var_0_3 = var_0.realtimeSinceStartup

		if arg_2_0.isLoading then
			return
		end

		if arg_2_0.playHandle then
			arg_2_0.playHandle()

			arg_2_0.playHandle = nil
		end

		local var_6_0 = arg_2_0

		var_0.displayWindow(var_6_0, false)

		local var_6_1 = arg_2_0

		var_0.clearMovie(var_6_1)

		return
	end)

	onButton = var_1

	local var_2_1 = arg_2_0

	findTF = var_4

	var_1(var_2_1, var_4(arg_2_0.mvTf, "left"), function()
		if var_0_3 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_3 < 1 then
				return
			end
		end

		Time = var_0
		var_0_3 = var_0.realtimeSinceStartup

		if arg_2_0.mvIndex > 1 and not arg_2_0.isLoading then
			arg_2_0.mvIndex = arg_2_0.mvIndex - 1

			local var_7_0 = arg_2_0

			var_0.pageChange(var_7_0)
		end

		return
	end)

	onButton = var_1

	local var_2_2 = arg_2_0

	findTF = var_4

	var_1(var_2_2, var_4(arg_2_0.mvTf, "right"), function()
		if var_0_3 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_3 < 1 then
				return
			end
		end

		Time = var_0
		var_0_3 = var_0.realtimeSinceStartup

		if arg_2_0.mvIndex < arg_2_0.showItemNum and not arg_2_0.isLoading then
			arg_2_0.mvIndex = arg_2_0.mvIndex + 1

			local var_8_0 = arg_2_0

			var_0.pageChange(var_8_0)
		end

		return
	end)

	onButton = var_1

	local var_2_3 = arg_2_0

	findTF = var_4

	local var_2_4 = var_4(arg_2_0._tf, "AD/chapter")

	local function var_2_5()
		local var_9_0 = arg_2_0

		var_0.displayWindow(var_9_0, true)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_3, var_2_4, var_2_5, var_6)

	onButton = var_1

	local var_2_6 = arg_2_0

	findTF = var_2_4

	var_1(var_2_6, var_2_4(arg_2_0._tf, "AD/left"), function()
		if arg_2_0.mvIndex > 1 and not arg_2_0.isLoading then
			arg_2_0.mvIndex = arg_2_0.mvIndex - 1

			local var_10_0 = arg_2_0

			var_0.pageUpdate(var_10_0)
		end

		return
	end)

	onButton = var_1

	local var_2_7 = arg_2_0

	findTF = var_4

	var_1(var_2_7, var_4(arg_2_0._tf, "AD/right"), function()
		if arg_2_0.mvIndex < arg_2_0.showItemNum and not arg_2_0.isLoading then
			arg_2_0.mvIndex = arg_2_0.mvIndex + 1

			local var_11_0 = arg_2_0

			var_0.pageUpdate(var_11_0)
		end

		return
	end)

	for iter_2_0 = 1, var_0_2 do
		local var_2_8 = iter_2_0

		onButton = var_6

		local var_2_9 = arg_2_0

		findTF = var_1_10009

		var_6(var_2_9, var_1_10009(arg_2_0.mvTf, "page/" .. iter_2_0), function()
			if var_0_3 then
				Time = var_0

				if var_0.realtimeSinceStartup - var_0_3 < 1 then
					return
				end
			end

			Time = var_0
			var_0_3 = var_0.realtimeSinceStartup

			if arg_2_0.nday < 6 then
				return
			end

			if arg_2_0.mvIndex ~= var_2_8 and not arg_2_0.isLoading then
				arg_2_0.mvIndex = var_2_8

				local var_12_0 = arg_2_0

				var_0.pageUpdate(var_12_0)
			end

			return
		end)

		setActive = var_6
		findTF = var_2_9

		local var_2_10 = var_2_9(arg_2_0.mvTf, "page/" .. iter_2_0)

		var_1_10009 = iter_2_0 <= arg_2_0.showItemNum

		var_6(var_2_10, var_1_10009)
	end

	setActive = var_1

	var_1(arg_2_0.mvTf, false)

	return
end

function var_0_1.UpdateTask(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1 + 1
	local var_13_1 = arg_13_2:Find("itemMask/item")
	local var_13_2 = arg_13_0.taskGroup[arg_13_0.nday][var_13_0]
	local var_13_3 = arg_13_0.taskProxy
	local var_13_5

	if not var_6.getTaskById(var_13_3, var_13_2) then
		local var_13_4 = arg_13_0.taskProxy

		var_13_5 = var_6.getFinishTaskById(var_13_4, var_13_2)
	end

	assert = var_7

	var_7(var_13_5, "without this task by id: " .. var_13_2)

	local var_13_6 = var_13_5:getConfig("award_display")[1]
	local var_13_7 = {
		type = var_13_6[1],
		id = var_13_6[2],
		count = var_13_6[3]
	}

	updateDrop = var_9

	var_9(var_13_1, var_13_7)

	onButton = var_9

	local var_13_8 = arg_13_0
	local var_13_9 = var_13_1

	local function var_13_10()
		local var_14_0 = arg_13_0
		local var_14_1 = var_0.emit

		BaseUI = var_2_10003

		var_14_1(var_14_0, var_2_10003.ON_DROP, var_13_7)

		return
	end

	SFX_PANEL = var_1_10014

	var_9(var_13_8, var_13_9, var_13_10, var_1_10014)

	local var_13_11 = var_13_5
	local var_13_12 = var_13_5.getProgress(var_13_11)
	local var_13_13 = var_13_5:getConfig("target_num")

	setText = var_13_11

	var_13_11(arg_13_2:Find("description"), var_13_5:getConfig("desc"))

	local var_13_14 = arg_13_0
	local var_13_15, var_13_16 = arg_13_0.GetProgressColor(var_13_14)

	if var_13_15 then
		setColorStr = var_13_14

		local var_13_17

		if not var_13_14(var_13_12, var_13_15) then
			::label_13_0::

			var_13_17 = var_13_12
		end

		if var_13_16 then
			setColorStr = var_13_14

			local var_13_18

			if not var_13_14("/" .. var_13_13, var_13_16) then
				::label_13_1::

				var_13_18 = "/" .. var_13_13
			end

			setText = var_13_14

			var_13_14(arg_13_2:Find("progressText"), var_13_17 .. var_13_18)

			setSlider = var_13_14

			var_13_14(arg_13_2:Find("progress"), 0, var_13_13, var_13_12)

			local var_13_19 = arg_13_2:Find("go_btn")
			local var_13_20 = arg_13_2:Find("get_btn")
			local var_13_21 = arg_13_2
			local var_13_22 = arg_13_2.Find(var_13_21, "got_btn")
			local var_13_23 = var_13_5:getTaskStatus()

			setActive = var_13_21

			var_13_21(var_13_19, var_13_23 == 0)

			setActive = var_13_21

			var_13_21(var_13_20, var_13_23 == 1)

			setActive = var_13_21

			var_13_21(var_13_22, var_13_23 == 2)

			onButton = var_13_21

			local var_13_24 = arg_13_0
			local var_13_25 = var_13_19

			local function var_13_26()
				local var_15_0 = arg_13_0
				local var_15_1 = var_0.emit

				ActivityMediator = var_2_10003

				var_15_1(var_15_0, var_2_10003.ON_TASK_GO, var_13_5)

				return
			end

			SFX_PANEL = var_1_10022

			var_13_21(var_13_24, var_13_25, var_13_26, var_1_10022)

			onButton = var_13_21

			local var_13_27 = arg_13_0
			local var_13_28 = var_13_20

			local function var_13_29()
				local var_16_0 = arg_13_0
				local var_16_1 = var_0.emit

				ActivityMediator = var_2_10003

				var_16_1(var_16_0, var_2_10003.ON_TASK_SUBMIT, var_13_5)

				return
			end

			SFX_PANEL = var_1_10022

			var_13_21(var_13_27, var_13_28, var_13_29, var_1_10022)

			local var_13_30 = arg_13_2:Find("get_btn")
			local var_13_31 = arg_13_1 + 1
			local var_13_32 = arg_13_0.taskGroup[arg_13_0.nday][var_13_31]
			local var_13_33 = arg_13_0.taskProxy
			local var_13_34

			if not var_20.getTaskById(var_13_33, var_13_32) then
				var_13_33 = arg_13_0.taskProxy
				var_13_34 = var_20.getFinishTaskById(var_13_33, var_13_32)
			end

			onButton = var_13_29

			local var_13_35 = arg_13_0
			local var_13_36 = var_13_30

			local function var_13_37()
				if arg_13_0.nday <= var_0_2 then
					arg_13_0.mvIndex = arg_13_0.nday

					local var_17_0 = arg_13_0
					local var_17_1 = var_0.emit

					ActivityMediator = var_2_10003

					var_17_1(var_17_0, var_2_10003.ON_TASK_SUBMIT, var_13_34)
				else
					local var_17_2 = arg_13_0.activity
					local var_17_3 = var_0.getConfig(var_17_2, "config_client").story

					checkExist = var_1

					if var_1(var_17_3, {
						arg_13_0.nday
					}, {
						1
					}) then
						pg = var_1

						local var_17_4 = var_1.NewStoryMgr.GetInstance()

						var_1.Play(var_17_4, var_17_3[arg_13_0.nday][1], function()
							local var_18_0 = arg_13_0
							local var_18_1 = var_0.emit

							ActivityMediator = var_3_10003

							var_18_1(var_18_0, var_3_10003.ON_TASK_SUBMIT, var_13_34)

							return
						end)
					else
						local var_17_5 = arg_13_0
						local var_17_6 = var_1.emit

						ActivityMediator = var_4

						var_17_6(var_17_5, var_4.ON_TASK_SUBMIT, var_13_34)
					end
				end

				return
			end

			SFX_PANEL = var_1_10026

			var_13_29(var_13_35, var_13_36, var_13_37, var_1_10026)

			local var_13_38 = arg_13_2:Find("got_btn")

			onButton = var_13_33

			local var_13_39 = arg_13_0
			local var_13_40 = var_13_38

			local function var_13_41()
				local var_19_0 = arg_13_0

				var_0.displayWindow(var_19_0, true)

				return
			end

			SFX_PANEL = var_1_10027

			var_13_33(var_13_39, var_13_40, var_13_41, var_1_10027)

			return
		end
	end
end

function var_0_1.pageChange(arg_20_0)
	arg_20_0:pageUpdate()
	arg_20_0:loadMv()

	return
end

function var_0_1.pageUpdate(arg_21_0)
	for iter_21_0 = 1, var_0_2 do
		setActive = var_1_10005
		findTF = var_1_10007

		var_1_10005(var_1_10007(arg_21_0.mvTf, "page/" .. iter_21_0 .. "/selected"), arg_21_0.mvIndex == iter_21_0)
	end

	for iter_21_1 = 1, var_0_2 do
		setActive = var_1_10005
		findTF = var_1_10007

		var_1_10005(var_1_10007(arg_21_0._tf, "AD/page/" .. iter_21_1 .. "/selected"), arg_21_0.mvIndex == iter_21_1)
	end

	for iter_21_2 = 1, var_0_2 do
		setActive = var_1_10005
		findTF = var_1_10007

		var_1_10005(var_1_10007(arg_21_0._tf, "AD/chapter/" .. iter_21_2), arg_21_0.mvIndex == iter_21_2)
	end

	setActive = var_1
	findTF = var_3

	var_1(var_3(arg_21_0._tf, "AD/right"), arg_21_0.mvIndex ~= arg_21_0.showItemNum)

	setActive = var_1
	findTF = var_3

	var_1(var_3(arg_21_0._tf, "AD/left"), arg_21_0.mvIndex ~= 1)

	return
end

function var_0_1.OnFirstFlush(arg_22_0)
	var_0_1.super.OnFirstFlush(arg_22_0)

	arg_22_0.mvIndex = arg_22_0.activity.data3 > var_0_2 and 1 or arg_22_0.activity.data3

	arg_22_0:initMv()

	return
end

function var_0_1.OnUpdateFlush(arg_23_0)
	arg_23_0.nday = arg_23_0.activity.data3

	if arg_23_0.dayTF then
		setText = var_1

		local var_23_0 = arg_23_0.dayTF

		tostring = var_1_10004

		var_1(var_23_0, var_1_10004(arg_23_0.nday))
	end

	local var_23_1 = arg_23_0.uilist

	var_1.align(var_23_1, #arg_23_0.taskGroup[arg_23_0.nday])

	return
end

function var_0_1.updateMvUI(arg_24_0)
	arg_24_0.showItemNum = var_0_2

	if arg_24_0.playHandle then
		setActive = var_1
		findTF = var_1_10003

		var_1(var_1_10003(arg_24_0.mvTf, "left"), false)

		setActive = var_1
		findTF = var_1_10003

		var_1(var_1_10003(arg_24_0.mvTf, "right"), false)
	else
		setActive = var_1
		findTF = var_1_10003

		local var_24_0 = var_1_10003(arg_24_0.mvTf, "left")
		local var_24_1 = arg_24_0.showItemNum

		var_1(var_24_0, 1 < var_24_1)

		setActive = var_1
		findTF = var_24_0

		local var_24_2 = var_24_0(arg_24_0.mvTf, "right")
		local var_24_3 = arg_24_0.showItemNum

		var_1(var_24_2, 1 < var_24_3)
	end

	for iter_24_0 = 1, var_0_2 do
		setActive = var_1_10005
		findTF = var_1_10007

		var_1_10005(var_1_10007(arg_24_0.mvTf, "page/" .. iter_24_0 .. "/selected"), arg_24_0.mvIndex == iter_24_0)

		setActive = var_1_10005
		findTF = var_1_10007

		var_1_10005(var_1_10007(arg_24_0.mvTf, "page/" .. iter_24_0), iter_24_0 <= arg_24_0.showItemNum)
	end

	return
end

function var_0_1.displayWindow(arg_25_0, arg_25_1)
	if not arg_25_1 and not arg_25_0.blurFlag then
		return
	end

	if arg_25_0.isLoading then
		return
	end

	if arg_25_0.blurFlag == arg_25_1 then
		return
	end

	local var_25_0

	if arg_25_1 then
		setActive = var_25_0

		var_25_0(arg_25_0.mvTf, true)

		Screen = var_25_0
		var_25_0 = var_25_0.width
		Screen = var_1_10003

		local var_25_1 = var_1_10003.height

		setSizeDelta = var_4
		findTF = var_1_10006

		local var_25_2 = var_1_10006(arg_25_0.mvTf, "bottom")

		Vector2 = var_1_10007
		Screen = var_9

		local var_25_3 = var_9.width

		Screen = var_1_10010

		var_4(var_25_2, var_1_10007(var_25_3, var_1_10010.height))

		pg = var_4

		local var_25_4 = var_4.UIMgr.GetInstance()

		var_4.BlurPanel(var_25_4, arg_25_0.mvTf, {
			staticBlur = true
		})
		arg_25_0:updateMvUI()
		arg_25_0:loadMv()
	else
		pg = var_25_0

		local var_25_5 = var_25_0.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_25_5, arg_25_0.mvTf)

		setActive = var_2

		var_2(arg_25_0.mvTf, false)
	end

	arg_25_0.blurFlag = arg_25_1

	return
end

function var_0_1.OnDestroy(arg_26_0)
	var_0_1.super.OnDestroy(arg_26_0)

	arg_26_0.isLoading = false

	arg_26_0:displayWindow(false)
	arg_26_0:clearMovie()

	return
end

function var_0_1.clearMovie(arg_27_0)
	if arg_27_0.mvGo then
		local var_27_0 = arg_27_0.mvManaCpkUI

		var_1.SetPlayEndHandler(var_27_0, nil)

		local var_27_1 = arg_27_0.mvManaCpkUI

		var_1.StopCpk(var_27_1)

		destroy = var_1

		var_1(arg_27_0.mvGo)

		arg_27_0.mvManaCpkUI = nil
		arg_27_0.mvGo = nil
		arg_27_0.mvName = nil
	end

	return
end

function var_0_1.GetProgressColor(arg_28_0)
	return "#FF6868", "#604D49"
end

function var_0_1.loadMv(arg_29_0)
	arg_29_0:clearMovie()

	if arg_29_0.isLoading then
		return
	end

	local var_29_0 = "psplive_" .. arg_29_0.mvIndex

	arg_29_0.isLoading = true
	PoolMgr = var_2

	local var_29_1 = var_2.GetInstance()

	var_2.GetUI(var_29_1, var_29_0, true, function(arg_30_0)
		arg_29_0.mvGo = arg_30_0
		arg_29_0.mvName = var_29_0

		local var_30_0 = arg_29_0

		GetComponent = var_2
		findTF = var_2_10004

		local var_30_1 = var_2_10004(arg_29_0.mvGo, "video/cpk")

		typeof = var_2_10005
		CriManaCpkUI = var_7
		var_30_0.mvManaCpkUI = var_2(var_30_1, var_2_10005(var_7))

		local var_30_2 = arg_29_0.mvManaCpkUI
		local var_30_3 = var_1.SetPlayEndHandler

		System = var_30_1

		var_30_3(var_30_2, var_30_1.Action(function()
			local var_31_0 = arg_29_0

			var_0.mvComplete(var_31_0)

			if arg_29_0.playHandle then
				arg_29_0.playHandle()

				arg_29_0.playHandle = nil
			end

			return
		end))

		setActive = var_30_3

		var_30_3(arg_29_0.btnPlay, false)

		setActive = var_30_3

		var_30_3(arg_29_0.btnStop, true)

		setActive = var_30_3

		var_30_3(arg_29_0.btnRepeat, false)

		if arg_29_0.isLoading == false then
			local var_30_4 = arg_29_0

			var_1.clearMovie(var_30_4)
		else
			local var_30_5 = arg_29_0

			var_30_5.isLoading = false
			setParent = var_30_5

			var_30_5(arg_29_0.mvGo, arg_29_0.mvContent)

			setActive = var_30_5

			var_30_5(arg_29_0.mvGo, true)
		end

		arg_29_0.mvCompleteFlag = false

		local var_30_6 = arg_29_0.mvManaCpkUI

		var_1.PlayCpk(var_30_6)

		return
	end)

	return
end

function var_0_1.mvComplete(arg_32_0)
	print = var_1_10001

	var_1_10001("播放完成")

	arg_32_0.mvCompleteFlag = true

	arg_32_0:onPlayerEnd()

	if arg_32_0.mvIndex == arg_32_0.nday then
		-- block empty
	end

	return
end

function var_0_1.onPlayerEnd(arg_33_0)
	setActive = var_1_10001

	var_1_10001(arg_33_0.btnPlay, false)

	setActive = var_1_10001

	var_1_10001(arg_33_0.btnStop, false)

	setActive = var_1_10001

	var_1_10001(arg_33_0.btnRepeat, true)

	return
end

function var_0_1.onPlayerStop(arg_34_0)
	setActive = var_1_10001

	var_1_10001(arg_34_0.btnPlay, true)

	setActive = var_1_10001

	var_1_10001(arg_34_0.btnStop, false)

	setActive = var_1_10001

	var_1_10001(arg_34_0.btnRepeat, false)

	return
end

function var_0_1.onPlayerStart(arg_35_0)
	setActive = var_1_10001

	var_1_10001(arg_35_0.btnPlay, false)

	setActive = var_1_10001

	var_1_10001(arg_35_0.btnStop, true)

	setActive = var_1_10001

	var_1_10001(arg_35_0.btnRepeat, false)

	return
end

return var_0_1
