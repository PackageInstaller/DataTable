local var_0_0 = class("MakeTeaPtPage", import(".TemplatePage.SkinTemplatePage"))
local var_0_1 = 5
local var_0_2 = {
	"caizhai",
	"tanfang",
	"shaqing",
	"huichao",
	"huiguo",
	"yincha"
}
local var_0_4

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	return
end

function var_0_0.initMv(arg_2_0)
	if arg_2_0.activity.data3 < var_0_1 then
		arg_2_0.showItemNum = arg_2_0.activity.data3 or var_0_1
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
			if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
				return
			end

			var_0_4 = Time.realtimeSinceStartup

			if arg_2_0.mvManaCpkUI and not arg_2_0.mvCompleteFlag then
				print("恢复播放")
				arg_2_0.mvManaCpkUI:Pause(false)
				arg_2_0:onPlayerStart()
			end

			return
		end)
		onButton(arg_2_0, arg_2_0.btnStop, function()
			if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
				return
			end

			var_0_4 = Time.realtimeSinceStartup

			if arg_2_0.mvManaCpkUI and not arg_2_0.mvCompleteFlag then
				print("暂停播放")
				arg_2_0.mvManaCpkUI:Pause(true)
				arg_2_0:onPlayerStop()
			end

			return
		end)
		onButton(arg_2_0, arg_2_0.btnRepeat, function()
			if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
				return
			end

			var_0_4 = Time.realtimeSinceStartup

			if arg_2_0.mvManaCpkUI and arg_2_0.mvCompleteFlag then
				print("重新播放")
				arg_2_0:loadMv()
			end

			return
		end)
		onButton(arg_2_0, arg_2_0.mvBottom, function()
			if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
				return
			end

			var_0_4 = Time.realtimeSinceStartup

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
			if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
				return
			end

			var_0_4 = Time.realtimeSinceStartup

			if arg_2_0.mvIndex > 1 and not arg_2_0.isLoading then
				arg_2_0.mvIndex = arg_2_0.mvIndex - 1

				arg_2_0:pageChange()
			end

			return
		end)
		onButton(arg_2_0, findTF(arg_2_0.mvTf, "right"), function()
			if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
				return
			end

			var_0_4 = Time.realtimeSinceStartup

			if arg_2_0.mvIndex < arg_2_0.showItemNum and not arg_2_0.isLoading then
				arg_2_0.mvIndex = arg_2_0.mvIndex + 1

				arg_2_0:pageChange()
			end

			return
		end)

		for iter_2_0 = 1, var_0_1 do
			local var_2_0 = iter_2_0

			onButton(arg_2_0, findTF(arg_2_0.mvTf, "page/" .. iter_2_0), function()
				if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
					return
				end

				var_0_4 = Time.realtimeSinceStartup

				if arg_2_0.nday < 6 then
					return
				end

				if arg_2_0.mvIndex ~= var_2_0 and not arg_2_0.isLoading then
					arg_2_0.mvIndex = var_2_0

					arg_2_0:pageChange()
				end

				return
			end)
			setActive(findTF(arg_2_0.mvTf, "page/" .. iter_2_0), iter_2_0 <= arg_2_0.showItemNum)
		end

		setActive(arg_2_0.mvTf, false)

		return
	end
end

function var_0_0.UpdateTask(arg_10_0, arg_10_1, arg_10_2)
	var_0_0.super.UpdateTask(arg_10_0, arg_10_1, arg_10_2)

	local var_10_0

	if not arg_10_0.taskProxy:getTaskById(arg_10_0.taskGroup[arg_10_0.nday][arg_10_1 + 1]) then
		var_10_0 = arg_10_0.taskProxy:getFinishTaskById(arg_10_0.taskGroup[arg_10_0.nday][arg_10_1 + 1])
	end

	onButton(arg_10_0, arg_10_2:Find("get_btn"), function()
		if arg_10_0.nday <= var_0_1 then
			arg_10_0.mvIndex = arg_10_0.nday

			function arg_10_0.playHandle()
				arg_10_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_10_0)

				return
			end

			arg_10_0:displayWindow(true)
		else
			local var_11_0 = arg_10_0.activity:getConfig("config_client").story

			if checkExist(var_11_0, {
				arg_10_0.nday
			}, {
				1
			}) then
				pg.NewStoryMgr.GetInstance():Play(var_11_0[arg_10_0.nday][1], function()
					arg_10_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_10_0)

					return
				end)
			else
				arg_10_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_10_0)
			end
		end

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_2:Find("got_btn"), function()
		arg_10_0:displayWindow(true)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.pageChange(arg_15_0)
	arg_15_0:pageUpdate()
	arg_15_0:loadMv()

	return
end

function var_0_0.pageUpdate(arg_16_0)
	for iter_16_0 = 1, var_0_1 do
		setActive(findTF(arg_16_0.mvTf, "page/" .. iter_16_0 .. "/selected"), arg_16_0.mvIndex == iter_16_0)
	end

	for iter_16_1 = 1, #var_0_2 do
		setActive(findTF(arg_16_0.mvTf, "title_word/" .. iter_16_1), iter_16_1 == arg_16_0.mvIndex)
	end

	return
end

function var_0_0.OnFirstFlush(arg_17_0)
	var_0_0.super.OnFirstFlush(arg_17_0)

	arg_17_0.mvIndex = arg_17_0.activity.data3 > var_0_1 and 1 or arg_17_0.activity.data3

	arg_17_0:initMv()

	return
end

function var_0_0.OnUpdateFlush(arg_18_0)
	arg_18_0.nday = arg_18_0.activity.data3

	if arg_18_0.dayTF then
		setText(arg_18_0.dayTF, tostring(arg_18_0.nday))
	end

	arg_18_0.uilist:align(#arg_18_0.taskGroup[arg_18_0.nday])

	for iter_18_0 = 1, #var_0_2 do
		setActive(findTF(arg_18_0._tf, "AD/word/" .. iter_18_0), iter_18_0 == arg_18_0.nday)
	end

	return
end

function var_0_0.updateMvUI(arg_19_0)
	if arg_19_0.activity.data3 < var_0_1 then
		arg_19_0.showItemNum = arg_19_0.activity.data3 or var_0_1

		if arg_19_0.playHandle then
			setActive(findTF(arg_19_0.mvTf, "left"), false)
			setActive(findTF(arg_19_0.mvTf, "right"), false)
		else
			setActive(findTF(arg_19_0.mvTf, "left"), arg_19_0.showItemNum > 1)
			setActive(findTF(arg_19_0.mvTf, "right"), arg_19_0.showItemNum > 1)
		end

		for iter_19_0 = 1, var_0_1 do
			setActive(findTF(arg_19_0.mvTf, "page/" .. iter_19_0 .. "/selected"), arg_19_0.mvIndex == iter_19_0)
			setActive(findTF(arg_19_0.mvTf, "page/" .. iter_19_0), iter_19_0 <= arg_19_0.showItemNum)
			setActive(findTF(arg_19_0.mvTf, "title_word/" .. iter_19_0), iter_19_0 == arg_19_0.mvIndex)
		end

		return
	end
end

function var_0_0.displayWindow(arg_20_0, arg_20_1)
	if not arg_20_1 and not arg_20_0.blurFlag then
		return
	end

	if arg_20_0.isLoading then
		return
	end

	if arg_20_0.blurFlag == arg_20_1 then
		return
	end

	if arg_20_1 then
		setActive(arg_20_0.mvTf, true)
		setSizeDelta(findTF(arg_20_0.mvTf, "bottom"), Vector2(Screen.width, Screen.height))
		pg.UIMgr.GetInstance():BlurPanel(arg_20_0.mvTf, {
			staticBlur = true
		})
		arg_20_0:updateMvUI()
		arg_20_0:loadMv()
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_20_0.mvTf)
		setActive(arg_20_0.mvTf, false)
	end

	arg_20_0.blurFlag = arg_20_1

	return
end

function var_0_0.OnDestroy(arg_21_0)
	var_0_0.super.OnDestroy(arg_21_0)

	arg_21_0.isLoading = false

	arg_21_0:displayWindow(false)
	arg_21_0:clearMovie()

	return
end

function var_0_0.clearMovie(arg_22_0)
	if arg_22_0.mvGo then
		arg_22_0.mvManaCpkUI:SetPlayEndHandler(nil)
		arg_22_0.mvManaCpkUI:StopCpk()
		destroy(arg_22_0.mvGo)

		arg_22_0.mvManaCpkUI = nil
		arg_22_0.mvGo = nil
		arg_22_0.mvName = nil
	end

	return
end

function var_0_0.GetProgressColor(arg_23_0)
	return "#57896D", "#A1AAA1"
end

function var_0_0.loadMv(arg_24_0)
	arg_24_0:clearMovie()

	if arg_24_0.isLoading then
		return
	end

	local var_24_0 = "paocha" .. arg_24_0.mvIndex

	arg_24_0.isLoading = true

	PoolMgr.GetInstance():GetUI(var_24_0, true, function(arg_25_0)
		arg_24_0.mvGo = arg_25_0
		arg_24_0.mvName = var_24_0
		arg_24_0.mvManaCpkUI = GetComponent(findTF(arg_24_0.mvGo, "video/cpk"), typeof(CriManaCpkUI))

		arg_24_0.mvManaCpkUI:SetPlayEndHandler(System.Action(function()
			arg_24_0:mvComplete()

			if arg_24_0.playHandle then
				arg_24_0.playHandle()

				arg_24_0.playHandle = nil
			end

			return
		end))
		setActive(arg_24_0.btnPlay, false)
		setActive(arg_24_0.btnStop, true)
		setActive(arg_24_0.btnRepeat, false)
		setText(arg_24_0.movieWord, i18n("mktea_" .. arg_24_0.mvIndex))

		if arg_24_0.isLoading == false then
			arg_24_0:clearMovie()
		else
			arg_24_0.isLoading = false

			setParent(arg_24_0.mvGo, arg_24_0.mvContent)
			setActive(arg_24_0.mvGo, true)
		end

		arg_24_0.mvCompleteFlag = false

		arg_24_0.mvManaCpkUI:PlayCpk()

		return
	end)

	return
end

function var_0_0.mvComplete(arg_27_0)
	print("播放完成")

	arg_27_0.mvCompleteFlag = true

	arg_27_0:onPlayerEnd()

	if arg_27_0.mvIndex == arg_27_0.nday then
		-- block empty
	end

	return
end

function var_0_0.onPlayerEnd(arg_28_0)
	setActive(arg_28_0.btnPlay, false)
	setActive(arg_28_0.btnStop, false)
	setActive(arg_28_0.btnRepeat, true)

	return
end

function var_0_0.onPlayerStop(arg_29_0)
	setActive(arg_29_0.btnPlay, true)
	setActive(arg_29_0.btnStop, false)
	setActive(arg_29_0.btnRepeat, false)

	return
end

function var_0_0.onPlayerStart(arg_30_0)
	setActive(arg_30_0.btnPlay, false)
	setActive(arg_30_0.btnStop, true)
	setActive(arg_30_0.btnRepeat, false)

	return
end

return var_0_0
