class = var_0_10000

local var_0_0 = "WorldDailyTaskLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.Listeners = {
	onUpdateTasks = "OnUpdateTasks"
}
var_0_1.optionsPath = {
	"blur_panel/adapt/top/title/option"
}

function var_0_1.getUIName(arg_1_0)
	return "WorldDailyTaskUI"
end

function var_0_1.init(arg_2_0)
	pairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(var_0_1.Listeners) do
		arg_2_0[iter_2_0] = function(...)
			var_0_1[iter_2_1](arg_2_0, ...)

			return
		end
	end

	local var_2_0 = arg_2_0._tf

	arg_2_0.rtBg = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.rtBlurPanel = var_1.Find(var_2_1, "blur_panel")

	local var_2_2 = arg_2_0.rtBlurPanel

	arg_2_0.rtTasks = var_1.Find(var_2_2, "adapt/tasks")
	setText = var_1

	local var_2_3 = arg_2_0.rtTasks
	local var_2_4 = var_3.Find(var_2_3, "frame/empty/Text")

	i18n = var_4

	var_1(var_2_4, var_4("world_daily_task_none"))

	setText = var_1

	local var_2_5 = arg_2_0.rtTasks
	local var_2_6 = var_3.Find(var_2_5, "frame/empty/Text_en")

	i18n = var_4

	var_1(var_2_6, var_4("world_daily_task_none_2"))

	local var_2_7 = arg_2_0.rtBlurPanel

	arg_2_0.rtTop = var_1.Find(var_2_7, "adapt/top")

	local var_2_8 = arg_2_0.rtTop

	arg_2_0.btnBack = var_1.Find(var_2_8, "title/back_button")

	local var_2_9 = arg_2_0.rtTop

	arg_2_0.btnAllAccept = var_1.Find(var_2_9, "title/btn_accept_all")

	local var_2_10 = arg_2_0.rtTop

	arg_2_0.rtTopTitle = var_1.Find(var_2_10, "title")

	local var_2_11 = arg_2_0.rtTopTitle

	arg_2_0.rtImageTitle = var_1.Find(var_2_11, "print/title")

	local var_2_12 = arg_2_0.rtTopTitle

	arg_2_0.rtImageTitleTask = var_1.Find(var_2_12, "print/title_task")

	local var_2_13 = arg_2_0.rtTopTitle

	arg_2_0.rtImageTitleShop = var_1.Find(var_2_13, "print/title_shop")

	local var_2_14 = arg_2_0._tf

	arg_2_0.rtTaskWindow = var_1.Find(var_2_14, "task_window")
	arg_2_0.wsTasks = {}

	local var_2_15 = arg_2_0.rtTasks
	local var_2_16 = var_1.Find(var_2_15, "frame/viewport/content")
	local var_2_17 = var_1.GetChild(var_2_16, 0)

	UIItemList = var_2_15
	arg_2_0.taskItemList = var_2_15.New(var_1, var_2_17)

	local var_2_18 = arg_2_0.taskItemList

	var_3.make(var_2_18, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0

			if not arg_2_0.wsTasks[arg_4_1] then
				WSPortTask = var_2_10004
				var_4_0 = var_2_10004.New(arg_4_2)
				onButton = var_4

				local var_4_1 = arg_2_0
				local var_4_2 = var_4_0.btnInactive

				local function var_4_3()
					WorldTask = var_3_10000

					local var_5_0, var_5_1 = var_3_10000.canTrigger(var_4_0.task.id)
					local var_5_3

					if var_5_0 then
						local var_5_2 = arg_2_0

						var_5_3 = var_5_3.emit
						WorldDailyTaskMediator = var_3_10005

						var_5_3(var_5_2, var_3_10005.OnAccepetTask, {
							var_4_0.task.id
						})
					else
						pg = var_5_3

						local var_5_4 = var_5_3.TipsMgr.GetInstance()

						var_2.ShowTips(var_5_4, var_5_1)
					end

					return
				end

				SFX_PANEL = var_2_10009

				var_4(var_4_1, var_4_2, var_4_3, var_2_10009)

				onButton = var_4

				local var_4_4 = arg_2_0
				local var_4_5 = var_4_0.btnOnGoing

				local function var_4_6()
					local var_6_0 = arg_2_0

					var_0.showTaskWindow(var_6_0, var_4_0.task)

					return
				end

				SFX_PANEL = var_2_10009

				var_4(var_4_4, var_4_5, var_4_6, var_2_10009)

				onButton = var_4

				local var_4_7 = arg_2_0
				local var_4_8 = var_4_0.btnFinished

				local function var_4_9()
					local var_7_0 = arg_2_0
					local var_7_1 = var_0.emit

					WorldDailyTaskMediator = var_3_10003

					var_7_1(var_7_0, var_3_10003.OnSubmitTask, var_4_0.task)

					return
				end

				SFX_PANEL = var_2_10009

				var_4(var_4_7, var_4_8, var_4_9, var_2_10009)

				function var_4_0.onDrop(arg_8_0)
					local var_8_0 = arg_2_0

					var_1.emit(var_8_0, var_0_1.ON_DROP, arg_8_0)

					return
				end

				arg_2_0.wsTasks[arg_4_1] = var_4_0
			end

			var_4_0:Setup(arg_2_0.taskVOs[arg_4_1])
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_9_0)
	arg_9_0:BlurPanel(arg_9_0._tf)
	arg_9_0:BlurPanel(arg_9_0.rtBlurPanel)

	onButton = var_1

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.btnBack

	local function var_9_2()
		local var_10_0 = arg_9_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_9_0, var_9_1, var_9_2, var_1_10006)

	onButton = var_1

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.btnAllAccept

	local function var_9_5()
		local var_11_0 = arg_9_0
		local var_11_1 = var_0.emit

		WorldDailyTaskMediator = var_2_10003

		local var_11_2 = var_2_10003.OnAccepetTask

		underscore = var_2_10004

		var_11_1(var_11_0, var_11_2, var_2_10004.map(arg_9_0.taskVOs, function(arg_12_0)
			return arg_12_0.id
		end))

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_9_3, var_9_4, var_9_5, var_1_10006)
	arg_9_0:OnUpdateTasks()

	return
end

function var_0_1.onBackPressed(arg_13_0)
	triggerButton = var_1_10001

	var_1_10001(arg_13_0.btnBack)

	return
end

function var_0_1.willExit(arg_14_0)
	arg_14_0:UnOverlayPanel(arg_14_0.rtBlurPanel, arg_14_0._tf)
	arg_14_0:UnOverlayPanel(arg_14_0._tf)
	arg_14_0:DisposeTasks()

	local var_14_0 = arg_14_0.taskProxy
	local var_14_1 = var_1.RemoveListener

	WorldTaskProxy = var_4

	var_14_1(var_14_0, var_4.EventUpdateDailyTaskIds, arg_14_0.onUpdateTasks)

	arg_14_0.taskProxy = nil

	return
end

function var_0_1.SetTaskProxy(arg_15_0, arg_15_1)
	arg_15_0.taskProxy = arg_15_1

	local var_15_0 = arg_15_0.taskProxy
	local var_15_1 = var_2.AddListener

	WorldTaskProxy = var_1_10005

	var_15_1(var_15_0, var_1_10005.EventUpdateDailyTaskIds, arg_15_0.onUpdateTasks)

	return
end

function var_0_1.OnUpdateTasks(arg_16_0)
	underscore = var_1_10001

	local var_16_0 = var_1_10001.map
	local var_16_1 = arg_16_0.taskProxy

	arg_16_0.taskVOs = var_16_0(var_3.getDailyTaskIds(var_16_1), function(arg_17_0)
		WorldTask = var_2_10001

		return var_2_10001.New({
			id = arg_17_0
		})
	end)
	table = var_1

	local var_16_2 = var_1.sort
	local var_16_3 = arg_16_0.taskVOs

	CompareFuncs = var_4
	WorldTask = var_1_10006

	var_16_2(var_16_3, var_4(var_1_10006.sortDic))

	local var_16_4 = arg_16_0.taskItemList

	var_1.align(var_16_4, #arg_16_0.taskVOs)

	local var_16_5 = arg_16_0.rtTasks
	local var_16_6 = var_1.Find(var_16_5, "frame/empty")

	setActive = var_1_10002

	var_1_10002(var_16_6, #arg_16_0.taskVOs == 0)

	setActive = var_1_10002

	local var_16_7 = arg_16_0.btnAllAccept
	local var_16_8 = arg_16_0.taskProxy

	var_1_10002(var_16_7, var_5.canAcceptDailyTask(var_16_8))

	return
end

function var_0_1.DisposeTasks(arg_18_0)
	_ = var_1_10001

	var_1_10001.each(arg_18_0.wsTasks, function(arg_19_0)
		arg_19_0:Dispose()

		return
	end)

	arg_18_0.wsTasks = nil

	return
end

function var_0_1.showTaskWindow(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.config.rare_task_icon
	local var_20_1 = arg_20_0.rtTaskWindow
	local var_20_2 = var_3.Find(var_20_1, "main_window/left_panel")

	setActive = var_1_10004

	var_1_10004(var_20_2:Find("bg"), arg_20_1:IsSpecialType())

	local var_20_3 = #var_20_0

	if 0 < var_20_3 then
		GetImageSpriteFromAtlasAsync = var_20_3

		var_20_3("shipyardicon/" .. var_20_0, "", var_20_2:Find("card"), true)
	else
		GetImageSpriteFromAtlasAsync = var_20_3

		var_20_3("ui/worldportui_atlas", "nobody", var_20_2:Find("card"), true)
	end

	local var_20_4 = arg_20_0.rtTaskWindow
	local var_20_5 = var_4.Find(var_20_4, "main_window/right_panel")

	setText = var_5

	var_5(var_20_5:Find("title/Text"), arg_20_1.config.name)

	setText = var_5

	var_5(var_20_5:Find("content/desc"), arg_20_1.config.rare_task_text)

	setText = var_5

	var_5(var_20_5:Find("content/slider_progress/Text"), arg_20_1:getProgress() .. "/" .. arg_20_1:getMaxProgress())

	setSlider = var_5

	var_5(var_20_5:Find("content/slider"), 0, arg_20_1:getMaxProgress(), arg_20_1:getProgress())

	local var_20_6 = var_20_5:Find("content/item_tpl")
	local var_20_7 = var_20_5
	local var_20_8 = var_20_5.Find(var_20_7, "content/award_bg/panel/content")
	local var_20_9 = arg_20_1.config.show

	removeAllChildren = var_20_7

	var_20_7(var_20_8)

	ipairs = var_20_7

	for iter_20_0, iter_20_1 in var_20_7(var_20_9) do
		cloneTplTo = var_1_10013
		var_1_10013 = var_1_10013(var_20_6, var_20_8)

		local var_20_10 = {
			type = iter_20_1[1],
			id = iter_20_1[2],
			count = iter_20_1[3]
		}

		updateDrop = var_15

		var_15(var_1_10013, var_20_10)

		onButton = var_15

		local var_20_11 = arg_20_0
		local var_20_12 = var_1_10013

		local function var_20_13()
			local var_21_0 = arg_20_0

			var_0.emit(var_21_0, var_0_1.ON_DROP, var_20_10)

			return
		end

		SFX_PANEL = var_1_10020

		var_15(var_20_11, var_20_12, var_20_13, var_1_10020)

		setActive = var_15

		var_15(var_1_10013, true)
	end

	setActive = var_8

	var_8(var_20_6, false)

	setActive = var_8

	var_8(var_20_5:Find("content/award_bg/arror"), #var_20_9 > 3)

	onButton = var_8

	local var_20_14 = arg_20_0
	local var_20_15 = var_20_5
	local var_20_16 = var_20_5.Find(var_20_15, "btn_close")

	local function var_20_17()
		local var_22_0 = arg_20_0

		var_0.hideTaskWindow(var_22_0)

		return
	end

	SFX_CANCEL = var_20_15

	var_8(var_20_14, var_20_16, var_20_17, var_20_15)

	onButton = var_8

	local var_20_18 = arg_20_0
	local var_20_19 = arg_20_0.rtTaskWindow
	local var_20_20 = var_11.Find(var_20_19, "bg")

	local function var_20_21()
		local var_23_0 = arg_20_0

		var_0.hideTaskWindow(var_23_0)

		return
	end

	SFX_CANCEL = var_20_19

	var_8(var_20_18, var_20_20, var_20_21, var_20_19)

	onButton = var_8

	local var_20_22 = arg_20_0
	local var_20_23 = var_20_5
	local var_20_24 = var_20_5.Find(var_20_23, "btn_go")

	local function var_20_25()
		local var_24_0 = arg_20_0

		var_0.hideTaskWindow(var_24_0)

		local var_24_1 = arg_20_0
		local var_24_2 = var_0.emit

		WorldDailyTaskMediator = var_2_10003

		var_24_2(var_24_1, var_2_10003.OnTaskGoto, arg_20_1.id)

		return
	end

	SFX_PANEL = var_20_23

	var_8(var_20_22, var_20_24, var_20_25, var_20_23)

	setButtonEnabled = var_8

	local var_20_26 = var_20_5:Find("btn_go")
	local var_20_27

	if not arg_20_1:GetFollowingAreaId() then
		var_20_27 = arg_20_1:GetFollowingEntrance()
	end

	var_8(var_20_26, var_20_27)

	setActive = var_8

	var_8(arg_20_0.rtTaskWindow, true)

	pg = var_8

	local var_20_28 = var_8.UIMgr.GetInstance()

	var_8.BlurPanel(var_20_28, arg_20_0.rtTaskWindow)

	return
end

function var_0_1.hideTaskWindow(arg_25_0)
	setActive = var_1_10001

	var_1_10001(arg_25_0.rtTaskWindow, false)

	pg = var_1_10001

	local var_25_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_25_0, arg_25_0.rtTaskWindow, arg_25_0._tf)

	return
end

return var_0_1
