EventConst = require("view/event/EventConst")
EventListItem = require("view/event/EventListItem")
EventDetailPanel = require("view/event/EventDetailPanel")

local var_0_0 = class("EventListScene", import("..base.BaseUI"))
local var_0_1 = {
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

function var_0_0.getUIName(arg_1_0)
	return "EventUI"
end

function var_0_0.init(arg_2_0)
	function arg_2_0.dispatch(...)
		arg_2_0:emit(...)

		return
	end

	arg_2_0.blurPanel = arg_2_0._tf:Find("blur_panel")
	arg_2_0.lay = arg_2_0.blurPanel:Find("adapt/left_length")
	arg_2_0.topPanel = arg_2_0._tf:Find("blur_panel/adapt/top").gameObject
	arg_2_0.btnBack = arg_2_0._tf:Find("blur_panel/adapt/top/back_btn").gameObject
	arg_2_0.topLeft = arg_2_0._tf:Find("blur_panel/adapt/top/topLeftBg$")
	arg_2_0.topLeftBg = arg_2_0._tf:Find("blur_panel/adapt/top/topLeftBg$").gameObject
	arg_2_0.labelShipNums = arg_2_0._tf:Find("blur_panel/adapt/top/topLeftBg$/labelShipNums$"):GetComponent("Text")
	arg_2_0.mask = arg_2_0._tf:Find("mask$"):GetComponent("Image")
	arg_2_0.scrollItem = EventListItem.New(arg_2_0._tf:Find("blur_panel/scrollItem").gameObject, arg_2_0.dispatch)

	arg_2_0.scrollItem.go:SetActive(false)

	arg_2_0.detailPanel = EventDetailPanel.New(arg_2_0._tf:Find("detailPanel").gameObject, arg_2_0.dispatch)

	arg_2_0.detailPanel.go:SetActive(false)

	arg_2_0.scrollRectObj = arg_2_0._tf:Find("scrollRect$")
	arg_2_0.scrollRect = arg_2_0.scrollRectObj:GetComponent("LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_4_0)
		arg_2_0:onInitItem(arg_4_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_5_0, arg_5_1)
		arg_2_0:onUpdateItem(arg_5_0, arg_5_1)

		return
	end

	function arg_2_0.scrollRect.onReturnItem(arg_6_0, arg_6_1)
		arg_2_0:onReturnItem(arg_6_0, arg_6_1)

		return
	end

	arg_2_0.scrollItems = {}
	arg_2_0.selectedItem = nil
	arg_2_0.rawLayouts = {}

	setImageAlpha(arg_2_0.mask, 0)

	arg_2_0.scrollRect.decelerationRate = 0.07
	arg_2_0.listEmptyTF = arg_2_0._tf:Find("empty")

	setActive(arg_2_0.listEmptyTF, false)

	arg_2_0.listEmptyTxt = arg_2_0.listEmptyTF:Find("Text")

	setText(arg_2_0.listEmptyTxt, i18n("list_empty_tip_eventui"))

	return
end

local var_0_2 = {
	"daily",
	"urgency"
}

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0.btnBack, function()
		if arg_7_0.selectedItem then
			arg_7_0:easeOut(function()
				arg_7_0:emit(var_0_0.ON_BACK)

				return
			end)
		else
			arg_7_0:emit(var_0_0.ON_BACK)
		end

		return
	end, SFX_CANCEL)
	setActive(arg_7_0._tf:Find("stamp"), getProxy(TaskProxy):mingshiTouchFlagEnabled())

	if LOCK_CLICK_MINGSHI then
		setActive(arg_7_0._tf:Find("stamp"), false)
	end

	onButton(arg_7_0, arg_7_0._tf:Find("stamp"), function()
		getProxy(TaskProxy):dealMingshiTouchFlag(9)

		return
	end, SFX_CONFIRM)

	arg_7_0.toggles = {}
	arg_7_0.toggleIndex = -1

	for iter_7_0, iter_7_1 in ipairs(var_0_2) do
		arg_7_0.toggles[iter_7_0] = arg_7_0.lay:Find("frame/scroll_rect/tagRoot/" .. iter_7_1 .. "_btn")

		onToggle(arg_7_0, arg_7_0.toggles[iter_7_0], function(arg_11_0)
			local var_11_0 = arg_7_0.toggleIndex == -1

			if arg_11_0 and arg_7_0.toggleIndex ~= iter_7_0 then
				arg_7_0.toggleIndex = iter_7_0

				if arg_7_0.selectedItem then
					pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0.blurPanel, arg_7_0._tf)

					local var_11_1 = 1000000

					for iter_11_0 = 0, arg_7_0.scrollRect.content.childCount - 1 do
						local var_11_2 = arg_7_0.scrollRect.content:GetChild(iter_11_0)

						if var_11_2 == arg_7_0.selectedItem.tr then
							var_11_1 = iter_11_0
						elseif var_11_1 < iter_11_0 then
							local var_11_3 = var_11_2:GetComponent(typeof(LayoutElement))

							var_11_3.ignoreLayout = arg_7_0.rawLayouts[var_11_2] or false
						end
					end

					arg_7_0.rawLayouts = {}

					arg_7_0.mask.gameObject:SetActive(false)
					arg_7_0.scrollItem.go:SetActive(false)
					arg_7_0.detailPanel.go:SetActive(false)

					arg_7_0.scrollRect.enabled = true
					arg_7_0.selectedItem = nil
					arg_7_0.contextData.selectedEventId = nil
				end

				arg_7_0.contextData.index = iter_7_0

				arg_7_0:Flush(not var_11_0)
			end

			return
		end)
	end

	local var_7_0 = arg_7_0.contextData.index or 1

	triggerToggle(arg_7_0.toggles[var_7_0], true)
	onButton(arg_7_0, arg_7_0.scrollItem.bgNormal, function()
		if arg_7_0.scrollItem.event:GetState() == EventInfo.StateFinish then
			arg_7_0.dispatch(EventConst.EVENT_FINISH, arg_7_0.scrollItem.event)
		else
			arg_7_0:easeOut()
		end

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.scrollItem.bgEmergence, function()
		if arg_7_0.scrollItem.event:GetState() == EventInfo.StateFinish then
			arg_7_0.dispatch(EventConst.EVENT_FINISH, arg_7_0.scrollItem.event)
		else
			arg_7_0:easeOut()
		end

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.mask.gameObject, function()
		arg_7_0:easeOut()

		return
	end, SFX_CANCEL)
	arg_7_0:ctimer()
	arg_7_0:updateBtnTip()

	return
end

function var_0_0.onBackPressed(arg_14_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(arg_14_0.btnBack)

	return
end

function var_0_0.setEventList(arg_15_0, arg_15_1)
	arg_15_0.eventList = arg_15_1

	return
end

function var_0_0.updateAll(arg_16_0)
	if arg_16_0.selectedItem then
		local var_16_0 = underscore.detect(arg_16_0.eventList, function(arg_17_0)
			return arg_17_0.id == arg_16_0.selectedItem.event.id
		end)

		if var_16_0 then
			local var_16_1 = getProxy(EventProxy)

			arg_16_0.labelShipNums.text = var_16_1.maxFleetNums - var_16_1:countBusyFleetNums() .. "/" .. var_16_1.maxFleetNums

			arg_16_0.scrollItem:Update(arg_16_0.selectedItem.index, var_16_0)
			arg_16_0.detailPanel:Update(arg_16_0.selectedItem.index, var_16_0)
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

function var_0_0.Flush(arg_18_0, arg_18_1)
	local var_18_0 = getProxy(EventProxy)

	if var_18_0:checkZeroHourEvent() then
		arg_18_0.dispatch(EventConst.EVENT_FLUSH_ALL)

		return
	elseif var_0_2[arg_18_0.contextData.index] == "urgency" and var_18_0:checkNightEvent() then
		arg_18_0.dispatch(EventConst.EVENT_FLUSH_ALL)

		return
	end

	if not false then
		arg_18_0.labelShipNums.text = var_18_0.maxFleetNums - var_18_0:countBusyFleetNums() .. "/" .. var_18_0.maxFleetNums

		if arg_18_0.contextData.selectedEventId then
			pg.UIMgr.GetInstance():LoadingOn()
			seriesAsync({
				function(arg_19_0)
					if arg_18_0.scrollRect.isStart then
						arg_19_0()
					else
						arg_18_0.scrollRect.onStart = arg_19_0
					end

					return
				end,
				function(arg_20_0)
					local var_20_0 = 1

					for iter_20_0, iter_20_1 in ipairs(arg_18_0.filterEventList) do
						if iter_20_1.id == arg_18_0.contextData.selectedEventId then
							var_20_0 = iter_20_0

							break
						end
					end

					arg_18_0.scrollRect:ScrollTo((arg_18_0.scrollRect:HeadIndexToValue(var_20_0 - 1)))

					for iter_20_2, iter_20_3 in pairs(arg_18_0.scrollItems) do
						if iter_20_3.event and iter_20_3.event.id == arg_18_0.contextData.selectedEventId then
							arg_18_0.selectedItem = iter_20_3

							arg_18_0:showDetail()

							break
						end
					end

					arg_20_0()

					return
				end
			}, function()
				pg.UIMgr.GetInstance():LoadingOff()

				return
			end)
		end
	end

	arg_18_0:filter()
	arg_18_0.scrollRect:SetTotalCount(#arg_18_0.filterEventList, false and 0 or arg_18_0.scrollRect.value)
	setActive(arg_18_0.listEmptyTF, #arg_18_0.filterEventList <= 0)

	return
end

function var_0_0.filter(arg_22_0)
	arg_22_0.filterEventList = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.eventList) do
		for iter_22_2, iter_22_3 in ipairs(var_0_1[arg_22_0.contextData.index]) do
			if iter_22_1.template.type == iter_22_3 then
				table.insert(arg_22_0.filterEventList, iter_22_1)

				break
			end
		end
	end

	table.sort(arg_22_0.filterEventList, CompareFuncs({
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

function var_0_0.onInitItem(arg_28_0, arg_28_1)
	local var_28_0 = EventListItem.New(arg_28_1, arg_28_0.dispatch)

	onButton(arg_28_0, var_28_0.bgNormal, function()
		if var_28_0.event:GetState() == EventInfo.StateFinish then
			arg_28_0.dispatch(EventConst.EVENT_FINISH, var_28_0.event)
		else
			arg_28_0:easeIn(var_28_0)
		end

		return
	end, SFX_PANEL)
	onButton(arg_28_0, var_28_0.bgEmergence, function()
		if var_28_0.event:GetState() == EventInfo.StateFinish then
			arg_28_0.dispatch(EventConst.EVENT_FINISH, var_28_0.event)
		else
			arg_28_0:easeIn(var_28_0)
		end

		return
	end, SFX_PANEL)

	arg_28_0.scrollItems[arg_28_1] = var_28_0

	return
end

function var_0_0.onUpdateItem(arg_30_0, arg_30_1, arg_30_2)
	GetComponent(tf(arg_30_2), "CanvasGroup").alpha = 1

	local var_30_0 = arg_30_0.scrollItems[arg_30_2]

	if not arg_30_0.scrollItems[arg_30_2] then
		arg_30_0:onInitItem(arg_30_2)

		var_30_0 = arg_30_0.scrollItems[arg_30_2]
	end

	local var_30_1 = arg_30_0.filterEventList[arg_30_1 + 1]

	if arg_30_0.filterEventList[arg_30_1 + 1] then
		var_30_0:Update(arg_30_1, var_30_1)
		var_30_0:UpdateTime()
	end

	return
end

function var_0_0.onReturnItem(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0.scrollItems and arg_31_0.scrollItems[arg_31_2] then
		arg_31_0.scrollItems[arg_31_2]:Clear()
	end

	return
end

function var_0_0.easeIn(arg_32_0, arg_32_1)
	if not arg_32_0.easing then
		arg_32_0.easing = true
		arg_32_0.selectedItem = arg_32_1

		arg_32_0:setOpEnabled(false)
		arg_32_0:easeInDetail(function()
			pg.UIMgr.GetInstance():BlurPanel(arg_32_0.blurPanel)

			arg_32_0.easing = false

			arg_32_0:setOpEnabled(true)

			return
		end)
	end

	return
end

function var_0_0.easeOut(arg_34_0, arg_34_1)
	if not arg_34_0.easing then
		arg_34_0.easing = true

		arg_34_0:setOpEnabled(false)
		arg_34_0:easeOutDetail(function()
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_34_0.blurPanel, arg_34_0._tf)

			arg_34_0.easing = false
			arg_34_0.selectedItem = nil
			arg_34_0.contextData.selectedEventId = nil

			arg_34_0:setOpEnabled(true)

			if arg_34_0.invalide then
				arg_34_0.invalide = false

				arg_34_0:Flush()
			end

			if arg_34_1 then
				arg_34_1()
			end

			return
		end)
	end

	return
end

function var_0_0.easeInDetail(arg_36_0, arg_36_1)
	local var_36_0 = 0.3

	arg_36_0.mask.gameObject:SetActive(true)

	arg_36_0.scrollRect.enabled = false

	LeanTween.value(arg_36_0.scrollRect.content.gameObject, arg_36_0.scrollRect.value, arg_36_0.scrollRect:HeadIndexToValue(arg_36_0.selectedItem.index), 0.3 * math.abs(arg_36_0.scrollRect.transform.rect.yMax - arg_36_0.scrollRect.content.localPosition.y - arg_36_0.selectedItem.tr.localPosition.y) / arg_36_0.scrollRect.transform.rect.height):setEase(LeanTweenType.easeInOutCirc):setOnUpdate(System.Action_float(function(arg_37_0)
		arg_36_0.scrollRect:SetNormalizedPosition(arg_37_0, 1)

		return
	end)):setOnComplete(System.Action(function()
		arg_36_0.scrollItem.tr.localPosition.y = var_0 + var_0.localPosition.y
		arg_36_0.scrollItem.tr.localPosition = arg_36_0.scrollItem.tr.localPosition

		arg_36_0.scrollItem.go:SetActive(true)
		arg_36_0.scrollItem:Update(arg_36_0.selectedItem.index, arg_36_0.selectedItem.event)
		arg_36_0.scrollItem:UpdateTime()
		arg_36_0.detailPanel.tr:SetParent(arg_36_0.scrollItem.tr:Find("maskDetail"), true)

		arg_36_0.detailPanel.tr.localPosition = Vector3.zero

		arg_36_0.detailPanel.go:SetActive(true)
		arg_36_0.detailPanel:Update(arg_36_0.selectedItem.index, arg_36_0.selectedItem.event)

		arg_36_0.contextData.selectedEventId = arg_36_0.selectedItem.event.id

		shiftPanel(arg_36_0.detailPanel.go, nil, -155, var_36_0, 0, true):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(arg_36_1))

		local var_38_0 = 100000

		for iter_38_0 = 0, var_0.childCount - 1 do
			local var_38_1 = var_0:GetChild(iter_38_0)

			if var_38_1 == arg_36_0.selectedItem.tr then
				var_38_0 = iter_38_0
			elseif var_38_0 < iter_38_0 then
				table.insert({}, var_38_1)
			end
		end

		arg_36_0.rawLayouts = {}

		for iter_38_1, iter_38_2 in ipairs({}) do
			local var_38_2 = iter_38_2:GetComponent(typeof(LayoutElement))

			arg_36_0.rawLayouts[iter_38_2] = var_38_2.ignoreLayout
			var_38_2.ignoreLayout = true

			shiftPanel(iter_38_2, nil, iter_38_2.localPosition.y + -347, var_36_0, 0, true):setEase(LeanTweenType.easeInOutCirc)
		end

		return
	end))

	return
end

function var_0_0.easeOutDetail(arg_39_0, arg_39_1)
	local var_39_0 = 100000
	local var_39_1 = {}

	for iter_39_0 = 0, arg_39_0.scrollRect.content.childCount - 1 do
		local var_39_2 = arg_39_0.scrollRect.content:GetChild(iter_39_0)

		if var_39_2 == arg_39_0.selectedItem.tr then
			var_39_0 = iter_39_0
		elseif var_39_0 < iter_39_0 then
			table.insert({}, var_39_2)
		end
	end

	for iter_39_1, iter_39_2 in ipairs({}) do
		shiftPanel(iter_39_2, nil, iter_39_2.localPosition.y + 268, 0.2, 0, true):setEase(LeanTweenType.easeInOutCirc)
	end

	shiftPanel(arg_39_0.detailPanel.go, nil, 129, 0.2, 0, true):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(function()
		for iter_40_0, iter_40_1 in ipairs(var_39_1) do
			local var_40_0 = iter_40_1:GetComponent(typeof(LayoutElement))

			var_40_0.ignoreLayout = arg_39_0.rawLayouts[iter_40_1] or false
		end

		arg_39_0.rawLayouts = {}

		arg_39_0.mask.gameObject:SetActive(false)
		arg_39_0.scrollItem.go:SetActive(false)
		arg_39_0.detailPanel.go:SetActive(false)

		arg_39_0.scrollRect.enabled = true

		arg_39_1()

		return
	end))

	return
end

function var_0_0.showDetail(arg_41_0)
	arg_41_0.scrollRect.enabled = false

	arg_41_0.mask.gameObject:SetActive(true)

	arg_41_0.scrollItem.tr.localPosition.y = arg_41_0.scrollRect.transform.rect.yMax + arg_41_0.scrollRect.transform.localPosition.y
	arg_41_0.scrollItem.tr.localPosition = arg_41_0.scrollItem.tr.localPosition

	arg_41_0.scrollItem.go:SetActive(true)
	arg_41_0.scrollItem:Update(arg_41_0.selectedItem.index, arg_41_0.selectedItem.event)
	arg_41_0.scrollItem:UpdateTime()
	arg_41_0.detailPanel.tr:SetParent(arg_41_0.scrollItem.tr:Find("maskDetail"), true)

	arg_41_0.detailPanel.tr.anchoredPosition = Vector3.New(-1, -155, 0)

	arg_41_0.detailPanel.go:SetActive(true)
	arg_41_0.detailPanel:Update(arg_41_0.selectedItem.index, arg_41_0.selectedItem.event)

	arg_41_0.contextData.selectedEventId = arg_41_0.selectedItem.event.id

	local var_41_0 = 100000

	arg_41_0.rawLayouts = {}

	for iter_41_0 = 0, arg_41_0.scrollRect.content.childCount - 1 do
		local var_41_1 = arg_41_0.scrollRect.content:GetChild(iter_41_0)
		local var_41_2 = var_41_1:GetComponent(typeof(LayoutElement))

		if var_41_2.ignoreLayout or not var_41_1.gameObject.activeSelf then
			arg_41_0.rawLayouts[var_41_1] = var_41_2.ignoreLayout
		elseif var_41_1 == arg_41_0.selectedItem.tr then
			var_41_0 = iter_41_0
		elseif var_41_0 < iter_41_0 then
			arg_41_0.rawLayouts[var_41_1] = var_41_2.ignoreLayout
			var_41_2.ignoreLayout = true
			var_41_1.localPosition = var_41_1.localPosition + Vector3.New(-1, -347, 0)
		end
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_41_0.blurPanel)

	return
end

function var_0_0.ctimer(arg_42_0)
	arg_42_0.timer = Timer.New(function()
		if arg_42_0.selectedItem then
			arg_42_0.scrollItem:UpdateTime()
		end

		local var_43_0 = pg.TimeMgr.GetInstance()
		local var_43_1 = var_43_0:GetServerTime()

		if var_43_0:STimeDescS(var_43_1, "%Y/%m/%d") ~= var_43_0:STimeDescS(var_43_1 - 1, "%Y/%m/%d") then
			arg_42_0.dispatch(EventConst.EVENT_FLUSH_ALL)

			return
		end

		local var_43_2 = false

		for iter_43_0, iter_43_1 in pairs(arg_42_0.scrollItems) do
			if iter_43_1.go.name ~= "-1" then
				iter_43_1:UpdateTime()

				local var_43_3 = iter_43_1.event:GetCountDownTime()

				if var_43_3 and var_43_3 < 0 then
					var_43_2 = true
				end
			end
		end

		if var_43_2 then
			arg_42_0.dispatch(EventConst.EVENT_LIST_UPDATE)
		end

		return
	end, 1, -1, true)

	arg_42_0.timer:Start()

	return
end

function var_0_0.ktimer(arg_44_0)
	if arg_44_0.timer then
		arg_44_0.timer:Stop()

		arg_44_0.timer = nil
	end

	return
end

function var_0_0.setOpEnabled(arg_45_0, arg_45_1)
	_.each(arg_45_0.toggles, function(arg_46_0)
		setToggleEnabled(arg_46_0, arg_45_1)

		return
	end)
	setButtonEnabled(arg_45_0.btnBack, arg_45_1)

	return
end

function var_0_0.updateBtnTip(arg_47_0)
	({
		false
	})[2] = getProxy(EventProxy):checkNightEvent()

	for iter_47_0, iter_47_1 in ipairs(arg_47_0.eventList) do
		if iter_47_1:GetState() == EventInfo.StateFinish then
			({
				false
			})[iter_47_1.template.type] = true
		end
	end

	for iter_47_2, iter_47_3 in ipairs(arg_47_0.toggles) do
		setActive(findTF(iter_47_3, "tip"), ({
			false
		})[iter_47_2])
	end

	return
end

function var_0_0.willExit(arg_48_0)
	if arg_48_0.tweens then
		cancelTweens(arg_48_0.tweens)
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_48_0.blurPanel, arg_48_0._tf)
	arg_48_0:ktimer()

	for iter_48_0, iter_48_1 in pairs(arg_48_0.scrollItems) do
		iter_48_1:Clear()
	end

	arg_48_0.scrollItem:Clear()
	arg_48_0.detailPanel:Clear()

	return
end

return var_0_0
