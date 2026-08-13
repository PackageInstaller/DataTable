require = var_0_10000

local var_0_0 = var_0_10000("view/event/EventConst")

require = EventConst

local var_0_1 = var_0("view/event/EventListItem")

require = EventListItem

local var_0_2 = var_0("view/event/EventDetailPanel")

class = EventDetailPanel

local var_0_3 = "EventListScene"

import = var_0_10002

local var_0_4 = var_0(var_0_3, var_0_10002("..base.BaseUI"))
local var_0_5 = {
	{
		0,
		1,
		3,
		4,
		6
	},
	{
		2,
		5
	}
}

function var_0_4.getUIName(arg_1_0)
	return "EventUI"
end

function var_0_4.init(arg_2_0)
	function arg_2_0.dispatch(...)
		local var_3_0 = arg_2_0

		var_0.emit(var_3_0, ...)

		return
	end

	local var_2_0 = arg_2_0._tf

	arg_2_0.blurPanel = var_1.Find(var_2_0, "blur_panel")

	local var_2_1 = arg_2_0.blurPanel

	arg_2_0.lay = var_1.Find(var_2_1, "adapt/left_length")

	local var_2_2 = arg_2_0._tf

	arg_2_0.topPanel = var_1.Find(var_2_2, "blur_panel/adapt/top").gameObject

	local var_2_3 = arg_2_0._tf

	arg_2_0.btnBack = var_1.Find(var_2_3, "blur_panel/adapt/top/back_btn").gameObject

	local var_2_4 = arg_2_0._tf

	arg_2_0.topLeft = var_1.Find(var_2_4, "blur_panel/adapt/top/topLeftBg$")

	local var_2_5 = arg_2_0._tf

	arg_2_0.topLeftBg = var_1.Find(var_2_5, "blur_panel/adapt/top/topLeftBg$").gameObject

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "blur_panel/adapt/top/topLeftBg$/labelShipNums$")

	arg_2_0.labelShipNums = var_1.GetComponent(var_2_7, "Text")

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "mask$")

	arg_2_0.mask = var_1.GetComponent(var_2_9, "Image")
	EventListItem = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0._tf

	arg_2_0.scrollItem = var_2_10(var_2.Find(var_2_11, "blur_panel/scrollItem").gameObject, arg_2_0.dispatch)

	local var_2_12 = arg_2_0.scrollItem.go

	var_1.SetActive(var_2_12, false)

	EventDetailPanel = var_1

	local var_2_13 = var_1.New
	local var_2_14 = arg_2_0._tf

	arg_2_0.detailPanel = var_2_13(var_2.Find(var_2_14, "detailPanel").gameObject, arg_2_0.dispatch)

	local var_2_15 = arg_2_0.detailPanel.go

	var_1.SetActive(var_2_15, false)

	local var_2_16 = arg_2_0._tf

	arg_2_0.scrollRectObj = var_1.Find(var_2_16, "scrollRect$")

	local var_2_17 = arg_2_0.scrollRectObj

	arg_2_0.scrollRect = var_1.GetComponent(var_2_17, "LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_4_0)
		local var_4_0 = arg_2_0

		var_1.onInitItem(var_4_0, arg_4_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		var_2.onUpdateItem(var_5_0, arg_5_0, arg_5_1)

		return
	end

	function arg_2_0.scrollRect.onReturnItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0

		var_2.onReturnItem(var_6_0, arg_6_0, arg_6_1)

		return
	end

	arg_2_0.scrollItems = {}
	arg_2_0.selectedItem = nil
	arg_2_0.rawLayouts = {}
	setImageAlpha = var_1

	var_1(arg_2_0.mask, 0)

	arg_2_0.scrollRect.decelerationRate = 0.07

	local var_2_18 = arg_2_0._tf

	arg_2_0.listEmptyTF = var_1.Find(var_2_18, "empty")
	setActive = var_1

	var_1(arg_2_0.listEmptyTF, false)

	local var_2_19 = arg_2_0.listEmptyTF

	arg_2_0.listEmptyTxt = var_1.Find(var_2_19, "Text")
	setText = var_1

	local var_2_20 = arg_2_0.listEmptyTxt

	i18n = var_3

	var_1(var_2_20, var_3("list_empty_tip_eventui"))

	return
end

local var_0_6 = {
	"daily",
	"urgency"
}

function var_0_4.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.btnBack

	local function var_7_2()
		if arg_7_0.selectedItem then
			local var_8_0 = arg_7_0

			var_0.easeOut(var_8_0, function()
				local var_9_0 = arg_7_0

				var_0.emit(var_9_0, var_0_4.ON_BACK)

				return
			end)
		else
			local var_8_1 = arg_7_0

			var_0.emit(var_8_1, var_0_4.ON_BACK)
		end

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	setActive = var_1_10001

	local var_7_3 = arg_7_0._tf
	local var_7_4 = var_2.Find(var_7_3, "stamp")

	getProxy = var_7_3
	TaskProxy = var_4

	local var_7_5 = var_7_3(var_4)

	var_1_10001(var_7_4, var_3.mingshiTouchFlagEnabled(var_7_5))

	LOCK_CLICK_MINGSHI = var_1_10001

	if var_1_10001 then
		setActive = var_1_10001

		local var_7_6 = arg_7_0._tf

		var_1_10001(var_2.Find(var_7_6, "stamp"), false)
	end

	onButton = var_1_10001

	local var_7_7 = arg_7_0
	local var_7_8 = arg_7_0._tf
	local var_7_9 = var_3.Find(var_7_8, "stamp")

	local function var_7_10()
		getProxy = var_2_10000
		TaskProxy = var_2_10001

		local var_10_0 = var_2_10000(var_2_10001)

		var_0.dealMingshiTouchFlag(var_10_0, 9)

		return
	end

	SFX_CONFIRM = var_5

	var_1_10001(var_7_7, var_7_9, var_7_10, var_5)

	arg_7_0.toggles = {}
	arg_7_0.toggleIndex = -1
	ipairs = var_1

	for iter_7_0, iter_7_1 in var_1(var_0_6) do
		local var_7_11 = arg_7_0.toggles
		local var_7_12 = arg_7_0.lay

		var_7_11[iter_7_0] = var_1_10007.Find(var_7_12, "frame/scroll_rect/tagRoot/" .. iter_7_1 .. "_btn")
		onToggle = var_7_11

		var_7_11(arg_7_0, arg_7_0.toggles[iter_7_0], function(arg_11_0)
			local var_11_0 = arg_7_0.toggleIndex == -1

			if arg_11_0 and arg_7_0.toggleIndex ~= iter_7_0 then
				arg_7_0.toggleIndex = iter_7_0

				if arg_7_0.selectedItem then
					pg = var_2

					local var_11_1 = var_2.UIMgr.GetInstance()

					var_2.UnOverlayPanel(var_11_1, arg_7_0.blurPanel, arg_7_0._tf)

					local var_11_2 = arg_7_0.scrollRect.content.childCount
					local var_11_3 = 1000000

					for iter_11_0 = 0, var_11_2 - 1 do
						if var_2:GetChild(iter_11_0) == arg_7_0.selectedItem.tr then
							var_11_3 = iter_11_0
						elseif var_11_3 < iter_11_0 then
							local var_11_4 = var_9
							local var_11_5 = var_9.GetComponent

							typeof = var_2_10012
							LayoutElement = var_2_10013

							local var_11_6 = var_11_5(var_11_4, var_2_10012(var_2_10013))
							local var_11_7

							if not arg_7_0.rawLayouts[var_9] then
								var_11_7 = false
							end

							var_11_6.ignoreLayout = var_11_7
						end
					end

					arg_7_0.rawLayouts = {}

					local var_11_8 = arg_7_0.mask.gameObject

					var_5.SetActive(var_11_8, false)

					local var_11_9 = arg_7_0.scrollItem.go

					var_5.SetActive(var_11_9, false)

					local var_11_10 = arg_7_0.detailPanel.go

					var_5.SetActive(var_11_10, false)

					arg_7_0.scrollRect.enabled = true
					arg_7_0.selectedItem = nil
					arg_7_0.contextData.selectedEventId = nil
				end

				arg_7_0.contextData.index = iter_7_0

				local var_11_11 = arg_7_0

				var_2.Flush(var_11_11, not var_11_0)
			end

			return
		end)
	end

	local var_7_13

	if not arg_7_0.contextData.index then
		var_7_13 = 1
	end

	triggerToggle = var_2

	var_2(arg_7_0.toggles[var_7_13], true)

	local function var_7_14()
		local var_12_0 = arg_7_0.scrollItem.event
		local var_12_1 = var_0.GetState(var_12_0)

		EventInfo = var_12_0

		if var_12_1 == var_12_0.StateFinish then
			local var_12_2 = arg_7_0.dispatch

			EventConst = var_1

			var_12_2(var_1.EVENT_FINISH, arg_7_0.scrollItem.event)
		else
			local var_12_3 = arg_7_0

			var_0.easeOut(var_12_3)
		end

		return
	end

	onButton = var_3

	local var_7_15 = arg_7_0
	local var_7_16 = arg_7_0.scrollItem.bgNormal
	local var_7_17 = var_7_14

	SFX_PANEL = var_1_10007

	var_3(var_7_15, var_7_16, var_7_17, var_1_10007)

	onButton = var_3

	local var_7_18 = arg_7_0
	local var_7_19 = arg_7_0.scrollItem.bgEmergence
	local var_7_20 = var_7_14

	SFX_PANEL = var_1_10007

	var_3(var_7_18, var_7_19, var_7_20, var_1_10007)

	onButton = var_3

	local var_7_21 = arg_7_0
	local var_7_22 = arg_7_0.mask.gameObject

	local function var_7_23()
		local var_13_0 = arg_7_0

		var_0.easeOut(var_13_0)

		return
	end

	SFX_CANCEL = var_1_10007

	var_3(var_7_21, var_7_22, var_7_23, var_1_10007)
	arg_7_0:ctimer()
	arg_7_0:updateBtnTip()

	return
end

function var_0_4.onBackPressed(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.CriMgr.GetInstance()
	local var_14_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10003

	var_14_1(var_14_0, var_1_10003)

	triggerButton = var_14_1

	var_14_1(arg_14_0.btnBack)

	return
end

function var_0_4.setEventList(arg_15_0, arg_15_1)
	arg_15_0.eventList = arg_15_1

	return
end

function var_0_4.updateAll(arg_16_0)
	if arg_16_0.selectedItem then
		underscore = var_1

		if var_1.detect(arg_16_0.eventList, function(arg_17_0)
			return arg_17_0.id == arg_16_0.selectedItem.event.id
		end) then
			getProxy = var_2
			EventProxy = var_3

			local var_16_0 = var_2(var_3)

			arg_16_0.labelShipNums.text = var_16_0.maxFleetNums - var_16_0:countBusyFleetNums() .. "/" .. var_16_0.maxFleetNums

			local var_16_1 = arg_16_0.scrollItem

			var_3.Update(var_16_1, arg_16_0.selectedItem.index, var_1)

			local var_16_2 = arg_16_0.detailPanel

			var_3.Update(var_16_2, arg_16_0.selectedItem.index, var_1)
		else
			arg_16_0:easeOut()
		end

		arg_16_0.invalide = true
	else
		arg_16_0:Flush()
	end

	arg_16_0:updateBtnTip()

	return
end

function var_0_4.Flush(arg_18_0, arg_18_1)
	arg_18_1 = false
	getProxy = var_1_10002
	EventProxy = var_1_10003

	local var_18_0 = var_1_10002(var_1_10003)

	if var_2.checkZeroHourEvent(var_18_0) then
		local var_18_1 = arg_18_0.dispatch

		EventConst = var_18_0

		var_18_1(var_18_0.EVENT_FLUSH_ALL)

		return
	elseif var_0_6[arg_18_0.contextData.index] == "urgency" then
		local var_18_2 = var_2

		if var_2.checkNightEvent(var_18_2) then
			local var_18_3 = arg_18_0.dispatch

			EventConst = var_18_2

			var_18_3(var_18_2.EVENT_FLUSH_ALL)

			return
		end
	end

	if not arg_18_1 then
		arg_18_0.labelShipNums.text = var_2.maxFleetNums - var_2:countBusyFleetNums() .. "/" .. var_2.maxFleetNums

		if arg_18_0.contextData.selectedEventId then
			pg = var_3

			local var_18_4 = var_3.UIMgr.GetInstance()

			var_3.LoadingOn(var_18_4)

			seriesAsync = var_3

			var_3({
				function(arg_19_0)
					if arg_18_0.scrollRect.isStart then
						arg_19_0()
					else
						arg_18_0.scrollRect.onStart = arg_19_0
					end

					return
				end,
				function(arg_20_0)
					local var_20_0 = arg_18_0.contextData.selectedEventId
					local var_20_1 = 1

					ipairs = var_2_10003

					for iter_20_0, iter_20_1 in var_2_10003(arg_18_0.filterEventList) do
						if iter_20_1.id == var_20_0 then
							var_20_1 = iter_20_0

							break
						end
					end

					local var_20_2 = arg_18_0.scrollRect
					local var_20_3 = var_3.HeadIndexToValue(var_20_2, var_20_1 - 1)
					local var_20_4 = arg_18_0.scrollRect

					var_4.ScrollTo(var_20_4, var_20_3)

					pairs = var_4

					for iter_20_2, iter_20_3 in var_4(arg_18_0.scrollItems) do
						if iter_20_3.event and iter_20_3.event.id == var_20_0 then
							arg_18_0.selectedItem = iter_20_3

							local var_20_5 = arg_18_0

							var_9.showDetail(var_20_5)

							break
						end
					end

					arg_20_0()

					return
				end
			}, function()
				pg = var_2_10000

				local var_21_0 = var_2_10000.UIMgr.GetInstance()

				var_0.LoadingOff(var_21_0)

				return
			end)
		end
	end

	arg_18_0:filter()

	local var_18_5 = arg_18_0.scrollRect

	var_3.SetTotalCount(var_18_5, #arg_18_0.filterEventList, arg_18_1 and 0 or arg_18_0.scrollRect.value)

	setActive = var_3

	var_3(arg_18_0.listEmptyTF, #arg_18_0.filterEventList <= 0)

	return
end

function var_0_4.filter(arg_22_0)
	arg_22_0.filterEventList = {}

	local var_22_0 = var_0_5[arg_22_0.contextData.index]

	ipairs = var_2

	for iter_22_0, iter_22_1 in var_2(arg_22_0.eventList) do
		ipairs = var_1_10007

		for iter_22_2, iter_22_3 in var_1_10007(var_22_0) do
			if iter_22_1.template.type == iter_22_3 then
				table = var_12

				var_12.insert(arg_22_0.filterEventList, iter_22_1)

				break
			end
		end
	end

	table = var_2

	local var_22_1 = var_2.sort
	local var_22_2 = arg_22_0.filterEventList

	CompareFuncs = var_4

	var_22_1(var_22_2, var_4({
		function(arg_23_0)
			return arg_23_0:IsActivityType() and 0 or 1
		end,
		function(arg_24_0)
			return -arg_24_0:GetState()
		end,
		function(arg_25_0)
			return arg_25_0.template.type == 3 and 0 or 1
		end,
		function(arg_26_0)
			return arg_26_0.overTime == 0 and 0 or 1
		end,
		function(arg_27_0)
			return arg_27_0.id
		end
	}))

	return
end

function var_0_4.onInitItem(arg_28_0, arg_28_1)
	EventListItem = var_1_10002

	local var_28_0 = var_1_10002.New(arg_28_1, arg_28_0.dispatch)

	local function var_28_1()
		local var_29_0 = var_28_0.event
		local var_29_1 = var_0.GetState(var_29_0)

		EventInfo = var_29_0

		if var_29_1 == var_29_0.StateFinish then
			local var_29_2 = arg_28_0.dispatch

			EventConst = var_1

			var_29_2(var_1.EVENT_FINISH, var_28_0.event)
		else
			local var_29_3 = arg_28_0

			var_0.easeIn(var_29_3, var_28_0)
		end

		return
	end

	onButton = var_4

	local var_28_2 = arg_28_0
	local var_28_3 = var_28_0.bgNormal
	local var_28_4 = var_28_1

	SFX_PANEL = var_1_10008

	var_4(var_28_2, var_28_3, var_28_4, var_1_10008)

	onButton = var_4

	local var_28_5 = arg_28_0
	local var_28_6 = var_28_0.bgEmergence
	local var_28_7 = var_28_1

	SFX_PANEL = var_1_10008

	var_4(var_28_5, var_28_6, var_28_7, var_1_10008)

	arg_28_0.scrollItems[arg_28_1] = var_28_0

	return
end

function var_0_4.onUpdateItem(arg_30_0, arg_30_1, arg_30_2)
	GetComponent = var_1_10003
	tf = var_1_10004
	var_1_10003(var_1_10004(arg_30_2), "CanvasGroup").alpha = 1

	local var_30_0

	if not arg_30_0.scrollItems[arg_30_2] then
		arg_30_0:onInitItem(arg_30_2)

		var_30_0 = arg_30_0.scrollItems[arg_30_2]
	end

	if arg_30_0.filterEventList[arg_30_1 + 1] then
		var_30_0:Update(arg_30_1, var_4)
		var_30_0:UpdateTime()
	end

	return
end

function var_0_4.onReturnItem(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0.scrollItems and arg_31_0.scrollItems[arg_31_2] then
		local var_31_0 = arg_31_0.scrollItems[arg_31_2]

		var_3.Clear(var_31_0)
	end

	return
end

function var_0_4.easeIn(arg_32_0, arg_32_1)
	if not arg_32_0.easing then
		arg_32_0.easing = true
		arg_32_0.selectedItem = arg_32_1

		arg_32_0:setOpEnabled(false)
		arg_32_0:easeInDetail(function()
			pg = var_2_10000

			local var_33_0 = var_2_10000.UIMgr.GetInstance()

			var_0.BlurPanel(var_33_0, arg_32_0.blurPanel)

			arg_32_0.easing = false

			local var_33_1 = arg_32_0

			var_0.setOpEnabled(var_33_1, true)

			return
		end)
	end

	return
end

function var_0_4.easeOut(arg_34_0, arg_34_1)
	if not arg_34_0.easing then
		arg_34_0.easing = true

		arg_34_0:setOpEnabled(false)
		arg_34_0:easeOutDetail(function()
			pg = var_2_10000

			local var_35_0 = var_2_10000.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_35_0, arg_34_0.blurPanel, arg_34_0._tf)

			arg_34_0.easing = false
			arg_34_0.selectedItem = nil
			arg_34_0.contextData.selectedEventId = nil

			local var_35_1 = arg_34_0

			var_0.setOpEnabled(var_35_1, true)

			if arg_34_0.invalide then
				arg_34_0.invalide = false

				local var_35_2 = arg_34_0

				var_0.Flush(var_35_2)
			end

			if arg_34_1 then
				arg_34_1()
			end

			return
		end)
	end

	return
end

function var_0_4.easeInDetail(arg_36_0, arg_36_1)
	local var_36_0 = 0.3
	local var_36_1 = 0.3
	local var_36_2 = arg_36_0.mask.gameObject

	var_4.SetActive(var_36_2, true)

	arg_36_0.scrollRect.enabled = false

	local var_36_3 = arg_36_0.scrollRect.transform
	local var_36_4 = arg_36_0.scrollRect.content
	local var_36_5 = var_36_3.rect.yMax

	math = var_1_10007

	local var_36_6 = var_36_0 * var_1_10007.abs(var_36_5 - var_36_4.localPosition.y - arg_36_0.selectedItem.tr.localPosition.y) / var_36_3.rect.height
	local var_36_7 = arg_36_0.scrollRect.value
	local var_36_8 = arg_36_0.scrollRect
	local var_36_9 = var_9.HeadIndexToValue(var_36_8, arg_36_0.selectedItem.index)

	LeanTween = var_36_8

	local var_36_10 = var_36_8.value(var_36_4.gameObject, var_36_7, var_36_9, var_36_6)
	local var_36_11 = var_10.setEase

	LeanTweenType = var_12

	local var_36_12 = var_36_11(var_36_10, var_12.easeInOutCirc)
	local var_36_13 = var_10.setOnUpdate

	System = var_12

	local var_36_14 = var_36_13(var_36_12, var_12.Action_float(function(arg_37_0)
		local var_37_0 = arg_36_0.scrollRect

		var_1.SetNormalizedPosition(var_37_0, arg_37_0, 1)

		return
	end))
	local var_36_15 = var_10.setOnComplete

	System = var_12

	var_36_15(var_36_14, var_12.Action(function()
		local var_38_0 = arg_36_0.scrollItem.tr.localPosition

		var_38_0.y = var_36_5 + var_36_3.localPosition.y
		arg_36_0.scrollItem.tr.localPosition = var_38_0

		local var_38_1 = arg_36_0.scrollItem.go

		var_1.SetActive(var_38_1, true)

		local var_38_2 = arg_36_0.scrollItem

		var_1.Update(var_38_2, arg_36_0.selectedItem.index, arg_36_0.selectedItem.event)

		local var_38_3 = arg_36_0.scrollItem

		var_1.UpdateTime(var_38_3)

		local var_38_4 = -347
		local var_38_5 = arg_36_0.detailPanel.tr
		local var_38_6 = var_2.SetParent
		local var_38_7 = arg_36_0.scrollItem.tr

		var_38_6(var_38_5, var_5.Find(var_38_7, "maskDetail"), true)

		Vector3 = var_38_6
		var_2.localPosition = var_38_6.zero

		local var_38_8 = arg_36_0.detailPanel.go

		var_3.SetActive(var_38_8, true)

		local var_38_9 = arg_36_0.detailPanel

		var_3.Update(var_38_9, arg_36_0.selectedItem.index, arg_36_0.selectedItem.event)

		local var_38_10 = arg_36_0.contextData

		var_38_10.selectedEventId = arg_36_0.selectedItem.event.id
		shiftPanel = var_38_10

		local var_38_11 = var_38_10(arg_36_0.detailPanel.go, nil, -155, var_36_1, 0, true)
		local var_38_12 = var_3.setEase

		LeanTweenType = var_5

		local var_38_13 = var_38_12(var_38_11, var_5.easeInOutCirc)
		local var_38_14 = var_3.setOnComplete

		System = var_5

		var_38_14(var_38_13, var_5.Action(arg_36_1))

		local var_38_15 = var_36_4.childCount
		local var_38_16 = 100000
		local var_38_17 = {}

		for iter_38_0 = 0, var_38_15 - 1 do
			local var_38_18 = var_36_4

			if var_10.GetChild(var_38_18, iter_38_0) == arg_36_0.selectedItem.tr then
				var_38_16 = iter_38_0
			elseif var_38_16 < iter_38_0 then
				table = var_11

				var_11.insert(var_38_17, var_10)
			end
		end

		local var_38_19 = arg_36_0

		var_38_19.rawLayouts = {}
		ipairs = var_38_19

		for iter_38_1, iter_38_2 in var_38_19(var_38_17) do
			local var_38_20 = iter_38_2
			local var_38_21 = iter_38_2.GetComponent

			typeof = var_2_10013
			LayoutElement = var_2_10014

			local var_38_22 = var_38_21(var_38_20, var_2_10013(var_2_10014))

			arg_36_0.rawLayouts[iter_38_2] = var_38_22.ignoreLayout
			var_38_22.ignoreLayout = true
			shiftPanel = var_12
			var_2_10013 = var_12(iter_38_2, nil, iter_38_2.localPosition.y + var_38_4, var_36_1, 0, true)

			local var_38_23 = var_12.setEase

			LeanTweenType = var_2_10014

			var_38_23(var_2_10013, var_2_10014.easeInOutCirc)
		end

		return
	end))

	return
end

function var_0_4.easeOutDetail(arg_39_0, arg_39_1)
	local var_39_0 = 0.2
	local var_39_1 = 268
	local var_39_2 = arg_39_0.scrollRect.content.childCount
	local var_39_3 = 100000
	local var_39_4 = {}

	for iter_39_0 = 0, var_39_2 - 1 do
		var_1_10013 = var_4

		if var_4.GetChild(var_1_10013, iter_39_0) == arg_39_0.selectedItem.tr then
			var_39_3 = iter_39_0
		elseif var_39_3 < iter_39_0 then
			table = var_1_10013

			var_1_10013.insert(var_39_4, var_12)
		end
	end

	ipairs = var_8

	for iter_39_1, iter_39_2 in var_8(var_39_4) do
		shiftPanel = var_1_10013

		local var_39_5 = var_1_10013(iter_39_2, nil, iter_39_2.localPosition.y + var_39_1, var_39_0, 0, true)

		var_1_10013 = var_1_10013.setEase
		LeanTweenType = var_15

		var_1_10013(var_39_5, var_15.easeInOutCirc)
	end

	shiftPanel = var_8

	local var_39_6 = var_8(arg_39_0.detailPanel.go, nil, 129, var_39_0, 0, true)
	local var_39_7 = var_8.setEase

	LeanTweenType = var_10

	local var_39_8 = var_39_7(var_39_6, var_10.easeInOutCirc)
	local var_39_9 = var_8.setOnComplete

	System = var_10

	var_39_9(var_39_8, var_10.Action(function()
		ipairs = var_2_10000

		for iter_40_0, iter_40_1 in var_2_10000(var_39_4) do
			local var_40_0 = iter_40_1
			local var_40_1 = iter_40_1.GetComponent

			typeof = var_2_10007
			LayoutElement = var_2_10008

			local var_40_2 = var_40_1(var_40_0, var_2_10007(var_2_10008))
			local var_40_3

			if not arg_39_0.rawLayouts[iter_40_1] then
				var_40_3 = false
			end

			var_40_2.ignoreLayout = var_40_3
		end

		arg_39_0.rawLayouts = {}

		local var_40_4 = arg_39_0.mask.gameObject

		var_0.SetActive(var_40_4, false)

		local var_40_5 = arg_39_0.scrollItem.go

		var_0.SetActive(var_40_5, false)

		local var_40_6 = arg_39_0.detailPanel.go

		var_0.SetActive(var_40_6, false)

		arg_39_0.scrollRect.enabled = true

		arg_39_1()

		return
	end))

	return
end

function var_0_4.showDetail(arg_41_0)
	arg_41_0.scrollRect.enabled = false

	local var_41_0 = arg_41_0.mask.gameObject

	var_1.SetActive(var_41_0, true)

	local var_41_1 = arg_41_0.scrollRect.transform
	local var_41_2 = arg_41_0.scrollRect.content
	local var_41_3 = arg_41_0.scrollItem.tr.localPosition

	var_41_3.y = var_41_1.rect.yMax + var_41_1.localPosition.y
	arg_41_0.scrollItem.tr.localPosition = var_41_3

	local var_41_4 = arg_41_0.scrollItem.go

	var_4.SetActive(var_41_4, true)

	local var_41_5 = arg_41_0.scrollItem

	var_4.Update(var_41_5, arg_41_0.selectedItem.index, arg_41_0.selectedItem.event)

	local var_41_6 = arg_41_0.scrollItem

	var_4.UpdateTime(var_41_6)

	local var_41_7 = -347
	local var_41_8 = arg_41_0.detailPanel.tr
	local var_41_9 = var_5.SetParent
	local var_41_10 = arg_41_0.scrollItem.tr

	var_41_9(var_41_8, var_8.Find(var_41_10, "maskDetail"), true)

	Vector3 = var_41_9
	var_5.anchoredPosition = var_41_9.New(-1, -155, 0)

	local var_41_11 = arg_41_0.detailPanel.go

	var_6.SetActive(var_41_11, true)

	local var_41_12 = arg_41_0.detailPanel

	var_6.Update(var_41_12, arg_41_0.selectedItem.index, arg_41_0.selectedItem.event)

	arg_41_0.contextData.selectedEventId = arg_41_0.selectedItem.event.id

	local var_41_13 = var_41_2.childCount
	local var_41_14 = 100000

	arg_41_0.rawLayouts = {}

	for iter_41_0 = 0, var_41_13 - 1 do
		local var_41_15 = var_41_2:GetChild(iter_41_0)
		local var_41_16 = var_12.GetComponent

		typeof = var_1_10015
		LayoutElement = var_1_10016

		if var_41_16(var_41_15, var_1_10015(var_1_10016)).ignoreLayout or not var_12.gameObject.activeSelf then
			arg_41_0.rawLayouts[var_12] = var_13.ignoreLayout
		elseif var_12 == arg_41_0.selectedItem.tr then
			var_41_14 = iter_41_0
		elseif var_41_14 < iter_41_0 then
			arg_41_0.rawLayouts[var_12] = var_13.ignoreLayout
			var_13.ignoreLayout = true

			local var_41_17 = var_12.localPosition

			Vector3 = var_1_10015
			var_12.localPosition = var_41_17 + var_1_10015.New(-1, var_41_7, 0)
		end
	end

	pg = var_8

	local var_41_18 = var_8.UIMgr.GetInstance()

	var_8.BlurPanel(var_41_18, arg_41_0.blurPanel)

	return
end

function var_0_4.ctimer(arg_42_0)
	local var_42_0 = 1

	Timer = var_1_10002
	arg_42_0.timer = var_1_10002.New(function()
		if arg_42_0.selectedItem then
			local var_43_0 = arg_42_0.scrollItem

			var_0.UpdateTime(var_43_0)
		end

		pg = var_0

		local var_43_1 = var_0.TimeMgr.GetInstance()
		local var_43_2 = var_0.GetServerTime(var_43_1)

		if var_0:STimeDescS(var_43_2, "%Y/%m/%d") ~= var_0:STimeDescS(var_43_2 - 1, "%Y/%m/%d") then
			local var_43_3 = arg_42_0.dispatch

			EventConst = var_3

			var_43_3(var_3.EVENT_FLUSH_ALL)

			return
		end

		local var_43_4 = false

		pairs = var_3

		for iter_43_0, iter_43_1 in var_3(arg_42_0.scrollItems) do
			if iter_43_1.go.name ~= "-1" then
				iter_43_1:UpdateTime()

				local var_43_5 = iter_43_1.event

				if var_8.GetCountDownTime(var_43_5) and var_8 < 0 then
					var_43_4 = true
				end
			end
		end

		if var_43_4 then
			local var_43_6 = arg_42_0.dispatch

			EventConst = var_4

			var_43_6(var_4.EVENT_LIST_UPDATE)
		end

		return
	end, var_42_0, -1, true)

	local var_42_1 = arg_42_0.timer

	var_2.Start(var_42_1)

	return
end

function var_0_4.ktimer(arg_44_0)
	if arg_44_0.timer then
		local var_44_0 = arg_44_0.timer

		var_1.Stop(var_44_0)

		arg_44_0.timer = nil
	end

	return
end

function var_0_4.setOpEnabled(arg_45_0, arg_45_1)
	_ = var_1_10002

	var_1_10002.each(arg_45_0.toggles, function(arg_46_0)
		setToggleEnabled = var_2_10001

		var_2_10001(arg_46_0, arg_45_1)

		return
	end)

	setButtonEnabled = var_2

	var_2(arg_45_0.btnBack, arg_45_1)

	return
end

function var_0_4.updateBtnTip(arg_47_0)
	local var_47_0 = {
		false
	}

	getProxy = var_1_10002
	EventProxy = var_1_10003

	local var_47_1 = var_1_10002(var_1_10003)

	var_47_0[2] = var_2.checkNightEvent(var_47_1)
	ipairs = var_2

	for iter_47_0, iter_47_1 in var_2(arg_47_0.eventList) do
		var_1_10008 = iter_47_1
		var_1_10007 = iter_47_1.GetState(var_1_10008)
		EventInfo = var_1_10008

		if var_1_10007 == var_1_10008.StateFinish then
			var_47_0[iter_47_1.template.type] = true
		end
	end

	ipairs = var_2

	for iter_47_2, iter_47_3 in var_2(arg_47_0.toggles) do
		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(iter_47_3, "tip"), var_47_0[iter_47_2])
	end

	return
end

function var_0_4.willExit(arg_48_0)
	if arg_48_0.tweens then
		cancelTweens = var_1

		var_1(arg_48_0.tweens)
	end

	pg = var_1

	local var_48_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_48_0, arg_48_0.blurPanel, arg_48_0._tf)
	arg_48_0:ktimer()

	pairs = var_1

	for iter_48_0, iter_48_1 in var_1(arg_48_0.scrollItems) do
		iter_48_1:Clear()
	end

	local var_48_1 = arg_48_0.scrollItem

	var_1.Clear(var_48_1)

	local var_48_2 = arg_48_0.detailPanel

	var_1.Clear(var_48_2)

	return
end

return var_0_4
