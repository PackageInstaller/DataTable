local var_0_0 = class("Mv1PtPage", import(".TemplatePage.SkinTemplatePage"))
local var_0_1 = 3
local var_0_2

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	return
end

function var_0_0.initMv(arg_2_0)
	arg_2_0.showItemNum = var_0_1
	arg_2_0.mvTf = findTF(arg_2_0._tf, "AD/mvPage")

	setActive(arg_2_0.mvTf, false)

	arg_2_0.mvContent = findTF(arg_2_0._tf, "AD/mvPage/movie/view/content")
	arg_2_0.movieWord = findTF(arg_2_0._tf, "AD/mvPage/movie/movieWord")
	arg_2_0.descClose = findTF(arg_2_0._tf, "AD/mvPage/descClose")

	setText(arg_2_0.descClose, i18n("island_act_tips1"))

	arg_2_0.mvIndex = 1

	arg_2_0:pageUpdate()

	arg_2_0.mvBottom = findTF(arg_2_0.mvTf, "bottom")
	arg_2_0.btnPlay = findTF(arg_2_0.mvTf, "movie/btnPlay")
	arg_2_0.btnStop = findTF(arg_2_0.mvTf, "movie/btnStop")
	arg_2_0.btnRepeat = findTF(arg_2_0.mvTf, "movie/btnRepeat")

	onButton(arg_2_0, arg_2_0.btnPlay, function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if arg_2_0.mvManaCpkUI and not arg_2_0.mvCompleteFlag then
			print("恢复播放")
			arg_2_0.mvManaCpkUI:Pause(false)
			arg_2_0:onPlayerStart()
		end

		return
	end)
	onButton(arg_2_0, arg_2_0.btnStop, function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if arg_2_0.mvManaCpkUI and not arg_2_0.mvCompleteFlag then
			print("暂停播放")
			arg_2_0.mvManaCpkUI:Pause(true)
			arg_2_0:onPlayerStop()
		end

		return
	end)
	onButton(arg_2_0, arg_2_0.btnRepeat, function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if arg_2_0.mvManaCpkUI and arg_2_0.mvCompleteFlag then
			print("重新播放")
			arg_2_0:loadMv()
		end

		return
	end)
	onButton(arg_2_0, arg_2_0.mvBottom, function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if arg_2_0.isLoading then
			return
		end

		if arg_2_0.playHandle then
			arg_2_0.playHandle()

			arg_2_0.playHandle = nil
		end

		arg_2_0:displayWindow(false)
		arg_2_0:clearMovie()

		return
	end)
	onButton(arg_2_0, findTF(arg_2_0.mvTf, "left"), function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if arg_2_0.mvIndex > 1 and not arg_2_0.isLoading then
			arg_2_0.mvIndex = arg_2_0.mvIndex - 1

			arg_2_0:pageChange()
		end

		return
	end)
	onButton(arg_2_0, findTF(arg_2_0.mvTf, "right"), function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if arg_2_0.mvIndex < arg_2_0.showItemNum and not arg_2_0.isLoading then
			arg_2_0.mvIndex = arg_2_0.mvIndex + 1

			arg_2_0:pageChange()
		end

		return
	end)
	onButton(arg_2_0, findTF(arg_2_0._tf, "AD/chapter"), function()
		arg_2_0:displayWindow(true)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, findTF(arg_2_0._tf, "AD/left"), function()
		if arg_2_0.mvIndex > 1 and not arg_2_0.isLoading then
			arg_2_0.mvIndex = arg_2_0.mvIndex - 1

			arg_2_0:pageUpdate()
		end

		return
	end)
	onButton(arg_2_0, findTF(arg_2_0._tf, "AD/right"), function()
		if arg_2_0.mvIndex < arg_2_0.showItemNum and not arg_2_0.isLoading then
			arg_2_0.mvIndex = arg_2_0.mvIndex + 1

			arg_2_0:pageUpdate()
		end

		return
	end)

	for iter_2_0 = 1, var_0_1 do
		local var_2_0 = iter_2_0

		onButton(arg_2_0, findTF(arg_2_0.mvTf, "page/" .. iter_2_0), function()
			if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
				return
			end

			var_0_2 = Time.realtimeSinceStartup

			if arg_2_0.nday < 6 then
				return
			end

			if arg_2_0.mvIndex ~= var_2_0 and not arg_2_0.isLoading then
				arg_2_0.mvIndex = var_2_0

				arg_2_0:pageUpdate()
			end

			return
		end)
		setActive(findTF(arg_2_0.mvTf, "page/" .. iter_2_0), iter_2_0 <= arg_2_0.showItemNum)
	end

	setActive(arg_2_0.mvTf, false)

	return
end

function var_0_0.UpdateTask(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2:Find("itemMask/item")
	local var_13_1 = arg_13_0.taskProxy:getTaskById(arg_13_0.taskGroup[arg_13_0.nday][arg_13_1 + 1]) or arg_13_0.taskProxy:getFinishTaskById(arg_13_0.taskGroup[arg_13_0.nday][arg_13_1 + 1])

	assert(var_13_1, "without this task by id: " .. arg_13_0.taskGroup[arg_13_0.nday][arg_13_1 + 1])

	local var_13_2 = var_13_1:getConfig("award_display")[1]

	updateDrop(var_13_0, {
		type = var_13_2[1],
		id = var_13_2[2],
		count = var_13_2[3]
	})
	onButton(arg_13_0, var_13_0, function()
		arg_13_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_13_3 = var_13_1:getProgress()
	local var_13_4 = var_13_1:getConfig("target_num")

	setText(arg_13_2:Find("description"), var_13_1:getConfig("desc"))

	local var_13_5, var_13_6 = arg_13_0:GetProgressColor()
	local var_13_7

	var_13_7 = var_13_5 and setColorStr(var_13_3, var_13_5) or var_13_3

	local var_13_8

	var_13_8 = var_13_6 and setColorStr("/" .. var_13_4, var_13_6) or "/" .. var_13_4

	setText(arg_13_2:Find("progressText"), var_13_7 .. var_13_8)
	setSlider(arg_13_2:Find("progress"), 0, var_13_4, var_13_3)

	local var_13_9 = arg_13_2:Find("go_btn")
	local var_13_10 = arg_13_2:Find("get_btn")
	local var_13_11 = arg_13_2:Find("got_btn")
	local var_13_12 = var_13_1:getTaskStatus()

	setActive(var_13_9, var_13_12 == 0)
	setActive(var_13_10, var_13_12 == 1)
	setActive(var_13_11, var_13_12 == 2)
	onButton(arg_13_0, var_13_9, function()
		arg_13_0:emit(ActivityMediator.ON_TASK_GO, var_13_1)

		return
	end, SFX_PANEL)
	onButton(arg_13_0, var_13_10, function()
		arg_13_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_1)

		return
	end, SFX_PANEL)

	local var_13_13

	if not arg_13_0.taskProxy:getTaskById(arg_13_0.taskGroup[arg_13_0.nday][arg_13_1 + 1]) then
		var_13_13 = arg_13_0.taskProxy:getFinishTaskById(arg_13_0.taskGroup[arg_13_0.nday][arg_13_1 + 1])
	end

	onButton(arg_13_0, arg_13_2:Find("get_btn"), function()
		if arg_13_0.nday <= var_0_1 then
			arg_13_0.mvIndex = arg_13_0.nday

			arg_13_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_13)
		else
			local var_17_0 = arg_13_0.activity:getConfig("config_client").story

			if checkExist(var_17_0, {
				arg_13_0.nday
			}, {
				1
			}) then
				pg.NewStoryMgr.GetInstance():Play(var_17_0[arg_13_0.nday][1], function()
					arg_13_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_13)

					return
				end)
			else
				arg_13_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_13)
			end
		end

		return
	end, SFX_PANEL)
	onButton(arg_13_0, arg_13_2:Find("got_btn"), function()
		arg_13_0:displayWindow(true)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.pageChange(arg_20_0)
	arg_20_0:pageUpdate()
	arg_20_0:loadMv()

	return
end

function var_0_0.pageUpdate(arg_21_0)
	for iter_21_0 = 1, var_0_1 do
		setActive(findTF(arg_21_0.mvTf, "page/" .. iter_21_0 .. "/selected"), arg_21_0.mvIndex == iter_21_0)
	end

	for iter_21_1 = 1, var_0_1 do
		setActive(findTF(arg_21_0._tf, "AD/page/" .. iter_21_1 .. "/selected"), arg_21_0.mvIndex == iter_21_1)
	end

	for iter_21_2 = 1, var_0_1 do
		setActive(findTF(arg_21_0._tf, "AD/chapter/" .. iter_21_2), arg_21_0.mvIndex == iter_21_2)
	end

	setActive(findTF(arg_21_0._tf, "AD/right"), arg_21_0.mvIndex ~= arg_21_0.showItemNum)
	setActive(findTF(arg_21_0._tf, "AD/left"), arg_21_0.mvIndex ~= 1)

	return
end

function var_0_0.OnFirstFlush(arg_22_0)
	var_0_0.super.OnFirstFlush(arg_22_0)

	arg_22_0.mvIndex = arg_22_0.activity.data3 > var_0_1 and 1 or arg_22_0.activity.data3

	arg_22_0:initMv()

	return
end

function var_0_0.OnUpdateFlush(arg_23_0)
	arg_23_0.nday = arg_23_0.activity.data3

	if arg_23_0.dayTF then
		setText(arg_23_0.dayTF, tostring(arg_23_0.nday))
	end

	arg_23_0.uilist:align(#arg_23_0.taskGroup[arg_23_0.nday])

	return
end

function var_0_0.updateMvUI(arg_24_0)
	arg_24_0.showItemNum = var_0_1

	if arg_24_0.playHandle then
		setActive(findTF(arg_24_0.mvTf, "left"), false)
		setActive(findTF(arg_24_0.mvTf, "right"), false)
	else
		setActive(findTF(arg_24_0.mvTf, "left"), arg_24_0.showItemNum > 1)
		setActive(findTF(arg_24_0.mvTf, "right"), arg_24_0.showItemNum > 1)
	end

	for iter_24_0 = 1, var_0_1 do
		setActive(findTF(arg_24_0.mvTf, "page/" .. iter_24_0 .. "/selected"), arg_24_0.mvIndex == iter_24_0)
		setActive(findTF(arg_24_0.mvTf, "page/" .. iter_24_0), iter_24_0 <= arg_24_0.showItemNum)
	end

	return
end

function var_0_0.displayWindow(arg_25_0, arg_25_1)
	if not arg_25_1 and not arg_25_0.blurFlag then
		return
	end

	if arg_25_0.isLoading then
		return
	end

	if arg_25_0.blurFlag == arg_25_1 then
		return
	end

	if arg_25_1 then
		setActive(arg_25_0.mvTf, true)
		setSizeDelta(findTF(arg_25_0.mvTf, "bottom"), Vector2(Screen.width, Screen.height))
		pg.UIMgr.GetInstance():BlurPanel(arg_25_0.mvTf, {
			staticBlur = true
		})
		arg_25_0:updateMvUI()
		arg_25_0:loadMv()
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_25_0.mvTf)
		setActive(arg_25_0.mvTf, false)
	end

	arg_25_0.blurFlag = arg_25_1

	return
end

function var_0_0.OnDestroy(arg_26_0)
	var_0_0.super.OnDestroy(arg_26_0)

	arg_26_0.isLoading = false

	arg_26_0:displayWindow(false)
	arg_26_0:clearMovie()

	return
end

function var_0_0.clearMovie(arg_27_0)
	if arg_27_0.mvGo then
		arg_27_0.mvManaCpkUI:SetPlayEndHandler(nil)
		arg_27_0.mvManaCpkUI:StopCpk()
		destroy(arg_27_0.mvGo)

		arg_27_0.mvManaCpkUI = nil
		arg_27_0.mvGo = nil
		arg_27_0.mvName = nil
	end

	return
end

function var_0_0.GetProgressColor(arg_28_0)
	return "#FF6868", "#604D49"
end

function var_0_0.loadMv(arg_29_0)
	arg_29_0:clearMovie()

	if arg_29_0.isLoading then
		return
	end

	local var_29_0 = "psplive_" .. arg_29_0.mvIndex

	arg_29_0.isLoading = true

	PoolMgr.GetInstance():GetUI(var_29_0, true, function(arg_30_0)
		arg_29_0.mvGo = arg_30_0
		arg_29_0.mvName = var_29_0
		arg_29_0.mvManaCpkUI = GetComponent(findTF(arg_29_0.mvGo, "video/cpk"), typeof(CriManaCpkUI))

		arg_29_0.mvManaCpkUI:SetPlayEndHandler(System.Action(function()
			arg_29_0:mvComplete()

			if arg_29_0.playHandle then
				arg_29_0.playHandle()

				arg_29_0.playHandle = nil
			end

			return
		end))
		setActive(arg_29_0.btnPlay, false)
		setActive(arg_29_0.btnStop, true)
		setActive(arg_29_0.btnRepeat, false)

		if arg_29_0.isLoading == false then
			arg_29_0:clearMovie()
		else
			arg_29_0.isLoading = false

			setParent(arg_29_0.mvGo, arg_29_0.mvContent)
			setActive(arg_29_0.mvGo, true)
		end

		arg_29_0.mvCompleteFlag = false

		arg_29_0.mvManaCpkUI:PlayCpk()

		return
	end)

	return
end

function var_0_0.mvComplete(arg_32_0)
	print("播放完成")

	arg_32_0.mvCompleteFlag = true

	arg_32_0:onPlayerEnd()

	if arg_32_0.mvIndex == arg_32_0.nday then
		-- block empty
	end

	return
end

function var_0_0.onPlayerEnd(arg_33_0)
	setActive(arg_33_0.btnPlay, false)
	setActive(arg_33_0.btnStop, false)
	setActive(arg_33_0.btnRepeat, true)

	return
end

function var_0_0.onPlayerStop(arg_34_0)
	setActive(arg_34_0.btnPlay, true)
	setActive(arg_34_0.btnStop, false)
	setActive(arg_34_0.btnRepeat, false)

	return
end

function var_0_0.onPlayerStart(arg_35_0)
	setActive(arg_35_0.btnPlay, false)
	setActive(arg_35_0.btnStop, true)
	setActive(arg_35_0.btnRepeat, false)

	return
end

return var_0_0
