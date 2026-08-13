class = var_0_10000

local var_0_0 = "MakeTeaPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))
local var_0_2 = 5
local var_0_3 = {
	"caizhai",
	"tanfang",
	"shaqing",
	"huichao",
	"huiguo",
	"yincha"
}
local var_0_4 = "ui/activityuipage/maketeaptpage_atlas"
local var_0_5

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	return
end

function var_0_1.initMv(arg_2_0)
	local var_2_0

	if not (arg_2_0.activity.data3 < var_0_2) or not arg_2_0.activity.data3 then
		var_2_0 = var_0_2
	end

	arg_2_0.showItemNum = var_2_0
	findTF = var_2_0
	arg_2_0.mvTf = var_2_0(arg_2_0._tf, "AD/mvPage")
	setActive = var_1

	var_1(arg_2_0.mvTf, false)

	findTF = var_1
	arg_2_0.mvContent = var_1(arg_2_0._tf, "AD/mvPage/movie/view/content")
	findTF = var_1
	arg_2_0.movieWord = var_1(arg_2_0._tf, "AD/mvPage/movie/movieWord")
	findTF = var_1
	arg_2_0.descClose = var_1(arg_2_0._tf, "AD/mvPage/descClose")
	setText = var_1

	local var_2_1 = arg_2_0.descClose

	i18n = var_3

	var_1(var_2_1, var_3("island_act_tips1"))

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
		if var_0_5 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_5 < 1 then
				return
			end
		end

		Time = var_0
		var_0_5 = var_0.realtimeSinceStartup

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
		if var_0_5 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_5 < 1 then
				return
			end
		end

		Time = var_0
		var_0_5 = var_0.realtimeSinceStartup

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
		if var_0_5 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_5 < 1 then
				return
			end
		end

		Time = var_0
		var_0_5 = var_0.realtimeSinceStartup

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
		if var_0_5 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_5 < 1 then
				return
			end
		end

		Time = var_0
		var_0_5 = var_0.realtimeSinceStartup

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

	local var_2_2 = arg_2_0

	findTF = var_3

	var_1(var_2_2, var_3(arg_2_0.mvTf, "left"), function()
		if var_0_5 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_5 < 1 then
				return
			end
		end

		Time = var_0
		var_0_5 = var_0.realtimeSinceStartup

		if arg_2_0.mvIndex > 1 and not arg_2_0.isLoading then
			arg_2_0.mvIndex = arg_2_0.mvIndex - 1

			local var_7_0 = arg_2_0

			var_0.pageChange(var_7_0)
		end

		return
	end)

	onButton = var_1

	local var_2_3 = arg_2_0

	findTF = var_3

	var_1(var_2_3, var_3(arg_2_0.mvTf, "right"), function()
		if var_0_5 then
			Time = var_0

			if var_0.realtimeSinceStartup - var_0_5 < 1 then
				return
			end
		end

		Time = var_0
		var_0_5 = var_0.realtimeSinceStartup

		if arg_2_0.mvIndex < arg_2_0.showItemNum and not arg_2_0.isLoading then
			arg_2_0.mvIndex = arg_2_0.mvIndex + 1

			local var_8_0 = arg_2_0

			var_0.pageChange(var_8_0)
		end

		return
	end)

	for iter_2_0 = 1, var_0_2 do
		local var_2_4 = iter_2_0

		onButton = var_1_10006

		local var_2_5 = arg_2_0

		findTF = var_1_10008

		var_1_10006(var_2_5, var_1_10008(arg_2_0.mvTf, "page/" .. iter_2_0), function()
			if var_0_5 then
				Time = var_0

				if var_0.realtimeSinceStartup - var_0_5 < 1 then
					return
				end
			end

			Time = var_0
			var_0_5 = var_0.realtimeSinceStartup

			if arg_2_0.nday < 6 then
				return
			end

			if arg_2_0.mvIndex ~= var_2_4 and not arg_2_0.isLoading then
				arg_2_0.mvIndex = var_2_4

				local var_9_0 = arg_2_0

				var_0.pageChange(var_9_0)
			end

			return
		end)

		setActive = var_1_10006
		findTF = var_2_5

		local var_2_6 = var_2_5(arg_2_0.mvTf, "page/" .. iter_2_0)

		var_1_10008 = iter_2_0 <= arg_2_0.showItemNum

		var_1_10006(var_2_6, var_1_10008)
	end

	setActive = var_1

	var_1(arg_2_0.mvTf, false)

	return
end

function var_0_1.UpdateTask(arg_10_0, arg_10_1, arg_10_2)
	var_0_1.super.UpdateTask(arg_10_0, arg_10_1, arg_10_2)

	local var_10_0 = arg_10_2:Find("get_btn")
	local var_10_1 = arg_10_1 + 1
	local var_10_2 = arg_10_0.taskGroup[arg_10_0.nday][var_10_1]
	local var_10_3 = arg_10_0.taskProxy
	local var_10_4

	if not var_6.getTaskById(var_10_3, var_10_2) then
		var_10_3 = arg_10_0.taskProxy
		var_10_4 = var_6.getFinishTaskById(var_10_3, var_10_2)
	end

	onButton = var_10_3

	local var_10_5 = arg_10_0
	local var_10_6 = var_10_0

	local function var_10_7()
		if arg_10_0.nday <= var_0_2 then
			arg_10_0.mvIndex = arg_10_0.nday

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
			local var_11_1 = arg_10_0.activity
			local var_11_2 = var_0.getConfig(var_11_1, "config_client").story

			checkExist = var_11_1

			if var_11_1(var_11_2, {
				arg_10_0.nday
			}, {
				1
			}) then
				pg = var_1

				local var_11_3 = var_1.NewStoryMgr.GetInstance()

				var_1.Play(var_11_3, var_11_2[arg_10_0.nday][1], function()
					local var_13_0 = arg_10_0
					local var_13_1 = var_0.emit

					ActivityMediator = var_3_10002

					var_13_1(var_13_0, var_3_10002.ON_TASK_SUBMIT, var_10_4)

					return
				end)
			else
				local var_11_4 = arg_10_0
				local var_11_5 = var_1.emit

				ActivityMediator = var_3

				var_11_5(var_11_4, var_3.ON_TASK_SUBMIT, var_10_4)
			end
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_10_3(var_10_5, var_10_6, var_10_7, var_1_10011)

	local var_10_8 = arg_10_2
	local var_10_9 = arg_10_2.Find(var_10_8, "got_btn")

	onButton = var_10_8

	local var_10_10 = arg_10_0
	local var_10_11 = var_10_9

	local function var_10_12()
		local var_14_0 = arg_10_0

		var_0.displayWindow(var_14_0, true)

		return
	end

	SFX_PANEL = var_1_10012

	var_10_8(var_10_10, var_10_11, var_10_12, var_1_10012)

	return
end

function var_0_1.pageChange(arg_15_0)
	arg_15_0:pageUpdate()
	arg_15_0:loadMv()

	return
end

function var_0_1.pageUpdate(arg_16_0)
	for iter_16_0 = 1, var_0_2 do
		setActive = var_1_10005
		findTF = var_1_10006

		var_1_10005(var_1_10006(arg_16_0.mvTf, "page/" .. iter_16_0 .. "/selected"), arg_16_0.mvIndex == iter_16_0)
	end

	for iter_16_1 = 1, #var_0_3 do
		setActive = var_1_10005
		findTF = var_1_10006

		var_1_10005(var_1_10006(arg_16_0.mvTf, "title_word/" .. iter_16_1), iter_16_1 == arg_16_0.mvIndex)
	end

	return
end

function var_0_1.OnFirstFlush(arg_17_0)
	var_0_1.super.OnFirstFlush(arg_17_0)

	arg_17_0.mvIndex = arg_17_0.activity.data3 > var_0_2 and 1 or arg_17_0.activity.data3

	arg_17_0:initMv()

	return
end

function var_0_1.OnUpdateFlush(arg_18_0)
	arg_18_0.nday = arg_18_0.activity.data3

	if arg_18_0.dayTF then
		setText = var_1

		local var_18_0 = arg_18_0.dayTF

		tostring = var_1_10003

		var_1(var_18_0, var_1_10003(arg_18_0.nday))
	end

	local var_18_1 = arg_18_0.uilist

	var_1.align(var_18_1, #arg_18_0.taskGroup[arg_18_0.nday])

	for iter_18_0 = 1, #var_0_3 do
		setActive = var_1_10005
		findTF = var_1_10006

		var_1_10005(var_1_10006(arg_18_0._tf, "AD/word/" .. iter_18_0), iter_18_0 == arg_18_0.nday)
	end

	return
end

function var_0_1.updateMvUI(arg_19_0)
	local var_19_0

	if not (arg_19_0.activity.data3 < var_0_2) or not arg_19_0.activity.data3 then
		var_19_0 = var_0_2
	end

	arg_19_0.showItemNum = var_19_0

	if arg_19_0.playHandle then
		setActive = var_1
		findTF = var_2

		var_1(var_2(arg_19_0.mvTf, "left"), false)

		setActive = var_1
		findTF = var_2

		var_1(var_2(arg_19_0.mvTf, "right"), false)
	else
		setActive = var_1
		findTF = var_2

		var_1(var_2(arg_19_0.mvTf, "left"), arg_19_0.showItemNum > 1)

		setActive = var_1
		findTF = var_2

		var_1(var_2(arg_19_0.mvTf, "right"), arg_19_0.showItemNum > 1)
	end

	for iter_19_0 = 1, var_0_2 do
		setActive = var_1_10005
		findTF = var_1_10006

		var_1_10005(var_1_10006(arg_19_0.mvTf, "page/" .. iter_19_0 .. "/selected"), arg_19_0.mvIndex == iter_19_0)

		setActive = var_1_10005
		findTF = var_1_10006

		var_1_10005(var_1_10006(arg_19_0.mvTf, "page/" .. iter_19_0), iter_19_0 <= arg_19_0.showItemNum)

		setActive = var_1_10005
		findTF = var_1_10006

		var_1_10005(var_1_10006(arg_19_0.mvTf, "title_word/" .. iter_19_0), iter_19_0 == arg_19_0.mvIndex)
	end

	return
end

function var_0_1.displayWindow(arg_20_0, arg_20_1)
	if not arg_20_1 and not arg_20_0.blurFlag then
		return
	end

	if arg_20_0.isLoading then
		return
	end

	if arg_20_0.blurFlag == arg_20_1 then
		return
	end

	local var_20_0

	if arg_20_1 then
		setActive = var_20_0

		var_20_0(arg_20_0.mvTf, true)

		Screen = var_20_0
		var_20_0 = var_20_0.width
		Screen = var_3

		local var_20_1 = var_3.height

		setSizeDelta = var_4
		findTF = var_1_10005

		local var_20_2 = var_1_10005(arg_20_0.mvTf, "bottom")

		Vector2 = var_6
		Screen = var_7

		local var_20_3 = var_7.width

		Screen = var_1_10008

		var_4(var_20_2, var_6(var_20_3, var_1_10008.height))

		pg = var_4

		local var_20_4 = var_4.UIMgr.GetInstance()

		var_4.BlurPanel(var_20_4, arg_20_0.mvTf, {
			staticBlur = true
		})
		arg_20_0:updateMvUI()
		arg_20_0:loadMv()
	else
		pg = var_20_0

		local var_20_5 = var_20_0.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_20_5, arg_20_0.mvTf)

		setActive = var_2

		var_2(arg_20_0.mvTf, false)
	end

	arg_20_0.blurFlag = arg_20_1

	return
end

function var_0_1.OnDestroy(arg_21_0)
	var_0_1.super.OnDestroy(arg_21_0)

	arg_21_0.isLoading = false

	arg_21_0:displayWindow(false)
	arg_21_0:clearMovie()

	return
end

function var_0_1.clearMovie(arg_22_0)
	if arg_22_0.mvGo then
		local var_22_0 = arg_22_0.mvManaCpkUI

		var_1.SetPlayEndHandler(var_22_0, nil)

		local var_22_1 = arg_22_0.mvManaCpkUI

		var_1.StopCpk(var_22_1)

		destroy = var_1

		var_1(arg_22_0.mvGo)

		arg_22_0.mvManaCpkUI = nil
		arg_22_0.mvGo = nil
		arg_22_0.mvName = nil
	end

	return
end

function var_0_1.GetProgressColor(arg_23_0)
	return "#57896D", "#A1AAA1"
end

function var_0_1.loadMv(arg_24_0)
	arg_24_0:clearMovie()

	if arg_24_0.isLoading then
		return
	end

	local var_24_0 = "paocha" .. arg_24_0.mvIndex

	arg_24_0.isLoading = true
	PoolMgr = var_2

	local var_24_1 = var_2.GetInstance()

	var_2.GetUI(var_24_1, var_24_0, true, function(arg_25_0)
		arg_24_0.mvGo = arg_25_0
		arg_24_0.mvName = var_24_0

		local var_25_0 = arg_24_0

		GetComponent = var_2
		findTF = var_2_10003

		local var_25_1 = var_2_10003(arg_24_0.mvGo, "video/cpk")

		typeof = var_4
		CriManaCpkUI = var_5
		var_25_0.mvManaCpkUI = var_2(var_25_1, var_4(var_5))

		local var_25_2 = arg_24_0.mvManaCpkUI
		local var_25_3 = var_1.SetPlayEndHandler

		System = var_25_1

		var_25_3(var_25_2, var_25_1.Action(function()
			local var_26_0 = arg_24_0

			var_0.mvComplete(var_26_0)

			if arg_24_0.playHandle then
				arg_24_0.playHandle()

				arg_24_0.playHandle = nil
			end

			return
		end))

		setActive = var_25_3

		var_25_3(arg_24_0.btnPlay, false)

		setActive = var_25_3

		var_25_3(arg_24_0.btnStop, true)

		setActive = var_25_3

		var_25_3(arg_24_0.btnRepeat, false)

		setText = var_25_3

		local var_25_4 = arg_24_0.movieWord

		i18n = var_3

		var_25_3(var_25_4, var_3("mktea_" .. arg_24_0.mvIndex))

		if arg_24_0.isLoading == false then
			local var_25_5 = arg_24_0

			var_1.clearMovie(var_25_5)
		else
			local var_25_6 = arg_24_0

			var_25_6.isLoading = false
			setParent = var_25_6

			var_25_6(arg_24_0.mvGo, arg_24_0.mvContent)

			setActive = var_25_6

			var_25_6(arg_24_0.mvGo, true)
		end

		arg_24_0.mvCompleteFlag = false

		local var_25_7 = arg_24_0.mvManaCpkUI

		var_1.PlayCpk(var_25_7)

		return
	end)

	return
end

function var_0_1.mvComplete(arg_27_0)
	print = var_1_10001

	var_1_10001("播放完成")

	arg_27_0.mvCompleteFlag = true

	arg_27_0:onPlayerEnd()

	if arg_27_0.mvIndex == arg_27_0.nday then
		-- block empty
	end

	return
end

function var_0_1.onPlayerEnd(arg_28_0)
	setActive = var_1_10001

	var_1_10001(arg_28_0.btnPlay, false)

	setActive = var_1_10001

	var_1_10001(arg_28_0.btnStop, false)

	setActive = var_1_10001

	var_1_10001(arg_28_0.btnRepeat, true)

	return
end

function var_0_1.onPlayerStop(arg_29_0)
	setActive = var_1_10001

	var_1_10001(arg_29_0.btnPlay, true)

	setActive = var_1_10001

	var_1_10001(arg_29_0.btnStop, false)

	setActive = var_1_10001

	var_1_10001(arg_29_0.btnRepeat, false)

	return
end

function var_0_1.onPlayerStart(arg_30_0)
	setActive = var_1_10001

	var_1_10001(arg_30_0.btnPlay, false)

	setActive = var_1_10001

	var_1_10001(arg_30_0.btnStop, true)

	setActive = var_1_10001

	var_1_10001(arg_30_0.btnRepeat, false)

	return
end

return var_0_1
