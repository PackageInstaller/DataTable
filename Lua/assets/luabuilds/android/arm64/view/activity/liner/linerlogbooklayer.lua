local var_0_0 = class("LinerLogBookLayer", import("view.base.BaseUI"))

var_0_0.PAGE_SCHEDULE = 1
var_0_0.PAGE_ROOM = 2
var_0_0.PAGE_EVENT = 3

local var_0_1 = {
	"liner_log_schedule_title",
	"liner_log_room_title",
	"liner_log_event_title"
}
local var_0_2 = var_0_0.PAGE_SCHEDULE

function var_0_0.getUIName(arg_1_0)
	return "LinerLogBookUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.anim = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.animEvent = arg_2_0._tf:GetComponent(typeof(DftAniEvent))

	arg_2_0.animEvent:SetEndEvent(function()
		arg_2_0:emit(var_0_0.ON_CLOSE)

		return
	end)

	arg_2_0.togglesTF = arg_2_0._tf:Find("frame/toggles")

	local var_2_0 = arg_2_0._tf:Find("frame/pages")

	arg_2_0.schedulePage = LinerLogSchedulePage.New(var_2_0, arg_2_0)
	arg_2_0.roomPage = LinerLogRoomPage.New(var_2_0, arg_2_0)
	arg_2_0.eventPage = LinerLogEventPage.New(var_2_0, arg_2_0)
	arg_2_0.pages = {
		[var_0_0.PAGE_SCHEDULE] = arg_2_0.schedulePage,
		[var_0_0.PAGE_ROOM] = arg_2_0.roomPage,
		[var_0_0.PAGE_EVENT] = arg_2_0.eventPage
	}
	arg_2_0.reasoningPage = LinerReasoningPage.New(arg_2_0._tf:Find("pages"), arg_2_0)

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("frame/close"), function()
		arg_4_0:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0._tf:Find("mask"), function()
		arg_4_0:onBackPressed()

		return
	end, SFX_PANEL)
	eachChild(arg_4_0.togglesTF, function(arg_7_0)
		setText(arg_7_0:Find("Text"), i18n(var_0_1[tonumber(arg_7_0.name)]))
		onButton(arg_4_0, arg_7_0, function()
			local var_8_0 = tonumber(arg_7_0.name)

			if var_8_0 == var_0_0.PAGE_EVENT and not LinerLogEventPage.IsUnlcok() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("liner_event_lock"))
			else
				if arg_4_0.curPageIdx and arg_4_0.curPageIdx == var_8_0 then
					return
				end

				arg_4_0.curPageIdx = var_8_0

				arg_4_0:SwitchPage()
				arg_7_0:SetAsLastSibling()
				arg_4_0:UpdateToggles()
			end

			return
		end)

		return
	end)

	local var_4_0 = arg_4_0.contextData.page or var_0_2

	triggerButton(arg_4_0._tf:Find(tostring(var_4_0), arg_4_0.togglesTF), true)
	arg_4_0:UpdateTips()

	return
end

function var_0_0.UpdateToggles(arg_9_0)
	setActive(arg_9_0.togglesTF:Find("3/lock"), not LinerLogEventPage.IsUnlcok())
	eachChild(arg_9_0.togglesTF, function(arg_10_0)
		setActive(arg_10_0:Find("selected"), tonumber(arg_10_0.name) == arg_9_0.curPageIdx)

		return
	end)

	return
end

function var_0_0.SwitchPage(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.pages) do
		if iter_11_0 == arg_11_0.curPageIdx then
			iter_11_1:ExecuteAction("FlushPage")

			arg_11_0.curPage = iter_11_1
		else
			iter_11_1:ExecuteAction("Hide")
		end
	end

	return
end

function var_0_0.UpdateView(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.pages) do
		iter_12_1:ExecuteAction("UpdateActivity")
	end

	arg_12_0.curPage:ExecuteAction("FlushPage")
	arg_12_0:UpdateTips()

	return
end

function var_0_0.UpdateTips(arg_13_0)
	eachChild(arg_13_0.togglesTF, function(arg_14_0)
		setActive(arg_14_0:Find("tip"), arg_13_0.pages[tonumber(arg_14_0.name)].IsTip())

		return
	end)

	return
end

function var_0_0.OnStartReasoning(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.reasoningPage:ExecuteAction("ShowOptions", arg_15_1, arg_15_2)

	return
end

function var_0_0.onBackPressed(arg_16_0)
	arg_16_0.anim:Play("anim_liner_logbook_out")

	return
end

function var_0_0.willExit(arg_17_0)
	arg_17_0.animEvent:SetEndEvent(nil)

	for iter_17_0, iter_17_1 in pairs(arg_17_0.pages) do
		iter_17_1:Destroy()

		iter_17_1 = nil
	end

	arg_17_0.reasoningPage:Destroy()

	arg_17_0.reasoningPage = nil

	if arg_17_0.contextData.onExit then
		arg_17_0.contextData.onExit()

		arg_17_0.contextData.onExit = nil
	end

	return
end

function var_0_0.IsTip()
	return LinerLogSchedulePage.IsTip() or LinerLogRoomPage.IsTip() or LinerLogEventPage.IsTip()
end

return var_0_0
