class = var_0_10000

local var_0_0 = "LinerLogBookLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.PAGE_SCHEDULE = 1
var_0_1.PAGE_ROOM = 2
var_0_1.PAGE_EVENT = 3

local var_0_2 = {
	"liner_log_schedule_title",
	"liner_log_room_title",
	"liner_log_event_title"
}
local var_0_3 = var_0_1.PAGE_SCHEDULE

function var_0_1.getUIName(arg_1_0)
	return "LinerLogBookUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10003
	Animation = var_1_10004
	arg_2_0.anim = var_2_1(var_2_0, var_1_10003(var_1_10004))

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.animEvent = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0.animEvent

	var_1.SetEndEvent(var_2_4, function()
		local var_3_0 = arg_2_0

		var_0.emit(var_3_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_2_5 = arg_2_0._tf

	arg_2_0.togglesTF = var_1.Find(var_2_5, "frame/toggles")

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/pages")

	LinerLogSchedulePage = var_2_6
	arg_2_0.schedulePage = var_2_6.New(var_2_7, arg_2_0)
	LinerLogRoomPage = var_2
	arg_2_0.roomPage = var_2.New(var_2_7, arg_2_0)
	LinerLogEventPage = var_2
	arg_2_0.eventPage = var_2.New(var_2_7, arg_2_0)
	arg_2_0.pages = {
		[var_0_1.PAGE_SCHEDULE] = arg_2_0.schedulePage,
		[var_0_1.PAGE_ROOM] = arg_2_0.roomPage,
		[var_0_1.PAGE_EVENT] = arg_2_0.eventPage
	}
	LinerReasoningPage = var_2

	local var_2_8 = var_2.New
	local var_2_9 = arg_2_0._tf

	arg_2_0.reasoningPage = var_2_8(var_3.Find(var_2_9, "pages"), arg_2_0)

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "frame/close")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.onBackPressed(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_0, var_4_2, var_4_3, var_5)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_3.Find(var_4_5, "mask")

	local function var_4_7()
		local var_6_0 = arg_4_0

		var_0.onBackPressed(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_4, var_4_6, var_4_7, var_5)

	eachChild = var_1_10001

	var_1_10001(arg_4_0.togglesTF, function(arg_7_0)
		setText = var_2_10001

		local var_7_0 = arg_7_0
		local var_7_1 = arg_7_0.Find(var_7_0, "Text")

		i18n = var_7_0

		local var_7_2 = var_0_2

		tonumber = var_2_10005

		var_2_10001(var_7_1, var_7_0(var_7_2[var_2_10005(arg_7_0.name)]))

		onButton = var_2_10001

		var_2_10001(arg_4_0, arg_7_0, function()
			tonumber = var_3_10000

			if var_3_10000(arg_7_0.name) == var_0_1.PAGE_EVENT then
				LinerLogEventPage = var_1

				if not var_1.IsUnlcok() then
					pg = var_1

					local var_8_0 = var_1.TipsMgr.GetInstance()
					local var_8_1 = var_1.ShowTips

					i18n = var_3_10003

					var_8_1(var_8_0, var_3_10003("liner_event_lock"))

					goto label_8_0
				end
			end

			if arg_4_0.curPageIdx and arg_4_0.curPageIdx == var_0 then
				return
			end

			arg_4_0.curPageIdx = var_0

			do
				local var_8_2 = arg_4_0

				var_1.SwitchPage(var_8_2)

				local var_8_3 = arg_7_0

				var_1.SetAsLastSibling(var_8_3)

				local var_8_4 = arg_4_0

				var_1.UpdateToggles(var_8_4)
			end

			::label_8_0::

			return
		end)

		return
	end)

	local var_4_8

	if not arg_4_0.contextData.page then
		var_4_8 = var_0_3
	end

	triggerButton = var_2

	local var_4_9 = arg_4_0._tf
	local var_4_10 = var_3.Find

	tostring = var_5

	var_2(var_4_10(var_4_9, var_5(var_4_8), arg_4_0.togglesTF), true)
	arg_4_0:UpdateTips()

	return
end

function var_0_1.UpdateToggles(arg_9_0)
	setActive = var_1_10001

	local var_9_0 = arg_9_0.togglesTF
	local var_9_1 = var_2.Find(var_9_0, "3/lock")

	LinerLogEventPage = var_9_0

	var_1_10001(var_9_1, not var_9_0.IsUnlcok())

	eachChild = var_1_10001

	var_1_10001(arg_9_0.togglesTF, function(arg_10_0)
		setActive = var_2_10001

		local var_10_0 = arg_10_0
		local var_10_1 = arg_10_0.Find(var_10_0, "selected")

		tonumber = var_10_0

		var_2_10001(var_10_1, var_10_0(arg_10_0.name) == arg_9_0.curPageIdx)

		return
	end)

	return
end

function var_0_1.SwitchPage(arg_11_0)
	pairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.pages) do
		if iter_11_0 == arg_11_0.curPageIdx then
			iter_11_1:ExecuteAction("FlushPage")

			arg_11_0.curPage = iter_11_1
		else
			iter_11_1:ExecuteAction("Hide")
		end
	end

	return
end

function var_0_1.UpdateView(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.pages) do
		iter_12_1:ExecuteAction("UpdateActivity")
	end

	local var_12_0 = arg_12_0.curPage

	var_1.ExecuteAction(var_12_0, "FlushPage")
	arg_12_0:UpdateTips()

	return
end

function var_0_1.UpdateTips(arg_13_0)
	eachChild = var_1_10001

	var_1_10001(arg_13_0.togglesTF, function(arg_14_0)
		tonumber = var_2_10001

		local var_14_0 = var_2_10001(arg_14_0.name)

		setActive = var_2

		var_2(arg_14_0:Find("tip"), arg_13_0.pages[var_14_0].IsTip())

		return
	end)

	return
end

function var_0_1.OnStartReasoning(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.reasoningPage

	var_3.ExecuteAction(var_15_0, "ShowOptions", arg_15_1, arg_15_2)

	return
end

function var_0_1.onBackPressed(arg_16_0)
	local var_16_0 = arg_16_0.anim

	var_1.Play(var_16_0, "anim_liner_logbook_out")

	return
end

function var_0_1.willExit(arg_17_0)
	local var_17_0 = arg_17_0.animEvent

	var_1.SetEndEvent(var_17_0, nil)

	pairs = var_1

	for iter_17_0, iter_17_1 in var_1(arg_17_0.pages) do
		iter_17_1:Destroy()

		iter_17_1 = nil
	end

	local var_17_1 = arg_17_0.reasoningPage

	var_1.Destroy(var_17_1)

	arg_17_0.reasoningPage = nil

	if arg_17_0.contextData.onExit then
		arg_17_0.contextData.onExit()

		arg_17_0.contextData.onExit = nil
	end

	return
end

function var_0_1.IsTip()
	LinerLogSchedulePage = var_1_10000

	local var_18_0

	if not var_1_10000.IsTip() then
		LinerLogRoomPage = var_18_0

		if not var_18_0.IsTip() then
			LinerLogEventPage = var_18_0
			var_18_0 = var_18_0.IsTip()
		end
	end

	return var_18_0
end

return var_0_1
