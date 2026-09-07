EventConst = require("view/event/EventConst")
EventListItem = require("view/event/EventListItem")
EventDetailPanel = require("view/event/EventDetailPanel")

local EventListScene = class("EventListScene", import("..base.BaseUI"))
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

function EventListScene:getUIName()
	return "EventUI"
end

function EventListScene:init()
	function self.dispatch(...)
		self:emit(...)

		return
	end

	self.blurPanel = self._tf:Find("blur_panel")
	self.lay = self.blurPanel:Find("adapt/left_length")
	self.topPanel = self._tf:Find("blur_panel/adapt/top").gameObject
	self.btnBack = self._tf:Find("blur_panel/adapt/top/back_btn").gameObject
	self.topLeft = self._tf:Find("blur_panel/adapt/top/topLeftBg$")
	self.topLeftBg = self._tf:Find("blur_panel/adapt/top/topLeftBg$").gameObject
	self.labelShipNums = self._tf:Find("blur_panel/adapt/top/topLeftBg$/labelShipNums$"):GetComponent("Text")
	self.mask = self._tf:Find("mask$"):GetComponent("Image")
	self.scrollItem = EventListItem.New(self._tf:Find("blur_panel/scrollItem").gameObject, self.dispatch)

	self.scrollItem.go:SetActive(false)

	self.detailPanel = EventDetailPanel.New(self._tf:Find("detailPanel").gameObject, self.dispatch)

	self.detailPanel.go:SetActive(false)

	self.scrollRectObj = self._tf:Find("scrollRect$")
	self.scrollRect = self.scrollRectObj:GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_4_0)
		self:onInitItem(arg_4_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_5_0, arg_5_1)
		self:onUpdateItem(arg_5_0, arg_5_1)

		return
	end

	function self.scrollRect.onReturnItem(arg_6_0, arg_6_1)
		self:onReturnItem(arg_6_0, arg_6_1)

		return
	end

	self.scrollItems = {}
	self.selectedItem = nil
	self.rawLayouts = {}

	setImageAlpha(self.mask, 0)

	self.scrollRect.decelerationRate = 0.07
	self.listEmptyTF = self._tf:Find("empty")

	setActive(self.listEmptyTF, false)

	self.listEmptyTxt = self.listEmptyTF:Find("Text")

	setText(self.listEmptyTxt, i18n("list_empty_tip_eventui"))

	return
end

local var_0_2 = {
	"daily",
	"urgency"
}

function EventListScene:didEnter()
	onButton(self, self.btnBack, function()
		if self.selectedItem then
			self:easeOut(function()
				self:emit(EventListScene.ON_BACK)

				return
			end)
		else
			self:emit(EventListScene.ON_BACK)
		end

		return
	end, SFX_CANCEL)
	setActive(self._tf:Find("stamp"), getProxy(TaskProxy):mingshiTouchFlagEnabled())

	if LOCK_CLICK_MINGSHI then
		setActive(self._tf:Find("stamp"), false)
	end

	onButton(self, self._tf:Find("stamp"), function()
		getProxy(TaskProxy):dealMingshiTouchFlag(9)

		return
	end, SFX_CONFIRM)

	self.toggles = {}
	self.toggleIndex = -1

	for iter_7_0, iter_7_1 in ipairs(var_0_2) do
		self.toggles[iter_7_0] = self.lay:Find("frame/scroll_rect/tagRoot/" .. iter_7_1 .. "_btn")

		onToggle(self, self.toggles[iter_7_0], function(arg_11_0)
			if arg_11_0 and self.toggleIndex ~= iter_7_0 then
				self.toggleIndex = iter_7_0

				if self.selectedItem then
					pg.UIMgr.GetInstance():UnOverlayPanel(self.blurPanel, self._tf)

					local var_11_0 = 1000000

					for iter_11_0 = 0, self.scrollRect.content.childCount - 1 do
						local var_11_1 = self.scrollRect.content:GetChild(iter_11_0)

						if var_11_1 == self.selectedItem.tr then
							var_11_0 = iter_11_0
						elseif var_11_0 < iter_11_0 then
							if not self.rawLayouts[var_11_1] then
								var_11_1:GetComponent(typeof(LayoutElement)).ignoreLayout = false
							end
						end
					end

					self.rawLayouts = {}

					self.mask.gameObject:SetActive(false)
					self.scrollItem.go:SetActive(false)
					self.detailPanel.go:SetActive(false)

					self.scrollRect.enabled = true
					self.selectedItem = nil
					self.contextData.selectedEventId = nil
				end

				self.contextData.index = iter_7_0

				self:Flush(not (self.toggleIndex == -1))
			end

			return
		end)
	end

	triggerToggle(self.toggles[self.contextData.index or 1], true)

	local function var_7_0()
		if self.scrollItem.event:GetState() == EventInfo.StateFinish then
			self.dispatch(EventConst.EVENT_FINISH, self.scrollItem.event)
		else
			self:easeOut()
		end

		return
	end

	onButton(self, self.scrollItem.bgNormal, var_7_0, SFX_PANEL)
	onButton(self, self.scrollItem.bgEmergence, var_7_0, SFX_PANEL)
	onButton(self, self.mask.gameObject, function()
		self:easeOut()

		return
	end, SFX_CANCEL)
	self:ctimer()
	self:updateBtnTip()

	return
end

function EventListScene:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(self.btnBack)

	return
end

function EventListScene:setEventList(arg_15_1)
	self.eventList = arg_15_1

	return
end

function EventListScene:updateAll()
	if self.selectedItem then
		local var_16_0 = underscore.detect(self.eventList, function(arg_17_0)
			return arg_17_0.id == self.selectedItem.event.id
		end)

		if var_16_0 then
			local var_16_1 = getProxy(EventProxy)

			self.labelShipNums.text = var_16_1.maxFleetNums - var_16_1:countBusyFleetNums() .. "/" .. var_16_1.maxFleetNums

			self.scrollItem:Update(self.selectedItem.index, var_16_0)
			self.detailPanel:Update(self.selectedItem.index, var_16_0)
		else
			self:easeOut()
		end

		self.invalide = true
	else
		self:Flush()
	end

	self:updateBtnTip()

	return
end

function EventListScene:Flush(arg_18_1)
	local var_18_0 = getProxy(EventProxy)

	if var_18_0:checkZeroHourEvent() then
		self.dispatch(EventConst.EVENT_FLUSH_ALL)

		return
	elseif var_0_2[self.contextData.index] == "urgency" and var_18_0:checkNightEvent() then
		self.dispatch(EventConst.EVENT_FLUSH_ALL)

		return
	end

	if not false then
		self.labelShipNums.text = var_18_0.maxFleetNums - var_18_0:countBusyFleetNums() .. "/" .. var_18_0.maxFleetNums

		if self.contextData.selectedEventId then
			pg.UIMgr.GetInstance():LoadingOn()
			seriesAsync({
				function(arg_19_0)
					if self.scrollRect.isStart then
						arg_19_0()
					else
						self.scrollRect.onStart = arg_19_0
					end

					return
				end,
				function(arg_20_0)
					local var_20_0 = 1

					for iter_20_0, iter_20_1 in ipairs(self.filterEventList) do
						if iter_20_1.id == self.contextData.selectedEventId then
							var_20_0 = iter_20_0

							break
						end
					end

					self.scrollRect:ScrollTo((self.scrollRect:HeadIndexToValue(var_20_0 - 1)))

					for iter_20_2, iter_20_3 in pairs(self.scrollItems) do
						if iter_20_3.event and iter_20_3.event.id == self.contextData.selectedEventId then
							self.selectedItem = iter_20_3

							self:showDetail()

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

	self:filter()
	self.scrollRect:SetTotalCount(#self.filterEventList, false and 0 or self.scrollRect.value)
	setActive(self.listEmptyTF, #self.filterEventList <= 0)

	return
end

function EventListScene:filter()
	self.filterEventList = {}

	for iter_22_0, iter_22_1 in ipairs(self.eventList) do
		for iter_22_2, iter_22_3 in ipairs(var_0_1[self.contextData.index]) do
			if iter_22_1.template.type == iter_22_3 then
				table.insert(self.filterEventList, iter_22_1)

				break
			end
		end
	end

	table.sort(self.filterEventList, CompareFuncs({
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

function EventListScene:onInitItem(arg_28_1)
	local var_28_0 = EventListItem.New(arg_28_1, self.dispatch)

	local function var_28_1()
		if var_28_0.event:GetState() == EventInfo.StateFinish then
			self.dispatch(EventConst.EVENT_FINISH, var_28_0.event)
		else
			self:easeIn(var_28_0)
		end

		return
	end

	onButton(self, var_28_0.bgNormal, var_28_1, SFX_PANEL)
	onButton(self, var_28_0.bgEmergence, var_28_1, SFX_PANEL)

	self.scrollItems[arg_28_1] = var_28_0

	return
end

function EventListScene:onUpdateItem(arg_30_1, arg_30_2)
	GetComponent(tf(arg_30_2), "CanvasGroup").alpha = 1

	local var_30_0 = self.scrollItems[arg_30_2]

	if not self.scrollItems[arg_30_2] then
		self:onInitItem(arg_30_2)

		var_30_0 = self.scrollItems[arg_30_2]
	end

	if self.filterEventList[arg_30_1 + 1] then
		var_30_0:Update(arg_30_1, self.filterEventList[arg_30_1 + 1])
		var_30_0:UpdateTime()
	end

	return
end

function EventListScene:onReturnItem(arg_31_1, arg_31_2)
	if self.scrollItems and self.scrollItems[arg_31_2] then
		self.scrollItems[arg_31_2]:Clear()
	end

	return
end

function EventListScene:easeIn(arg_32_1)
	if not self.easing then
		self.easing = true
		self.selectedItem = arg_32_1

		self:setOpEnabled(false)
		self:easeInDetail(function()
			pg.UIMgr.GetInstance():BlurPanel(self.blurPanel)

			self.easing = false

			self:setOpEnabled(true)

			return
		end)
	end

	return
end

function EventListScene:easeOut(arg_34_1)
	if not self.easing then
		self.easing = true

		self:setOpEnabled(false)
		self:easeOutDetail(function()
			pg.UIMgr.GetInstance():UnOverlayPanel(self.blurPanel, self._tf)

			self.easing = false
			self.selectedItem = nil
			self.contextData.selectedEventId = nil

			self:setOpEnabled(true)

			if self.invalide then
				self.invalide = false

				self:Flush()
			end

			if arg_34_1 then
				arg_34_1()
			end

			return
		end)
	end

	return
end

function EventListScene:easeInDetail(arg_36_1)
	local var_36_0 = 0.3

	self.mask.gameObject:SetActive(true)

	self.scrollRect.enabled = false

	local var_36_1 = self.scrollRect.transform
	local var_36_2 = self.scrollRect.content
	local var_36_3 = self.scrollRect.transform.rect.yMax

	LeanTween.value(self.scrollRect.content.gameObject, self.scrollRect.value, self.scrollRect:HeadIndexToValue(self.selectedItem.index), 0.3 * math.abs(self.scrollRect.transform.rect.yMax - self.scrollRect.content.localPosition.y - self.selectedItem.tr.localPosition.y) / self.scrollRect.transform.rect.height):setEase(LeanTweenType.easeInOutCirc):setOnUpdate(System.Action_float(function(arg_37_0)
		self.scrollRect:SetNormalizedPosition(arg_37_0, 1)

		return
	end)):setOnComplete(System.Action(function()
		self.scrollItem.tr.localPosition.y = var_36_3 + var_36_1.localPosition.y
		self.scrollItem.tr.localPosition = self.scrollItem.tr.localPosition

		self.scrollItem.go:SetActive(true)
		self.scrollItem:Update(self.selectedItem.index, self.selectedItem.event)
		self.scrollItem:UpdateTime()
		self.detailPanel.tr:SetParent(self.scrollItem.tr:Find("maskDetail"), true)

		self.detailPanel.tr.localPosition = Vector3.zero

		self.detailPanel.go:SetActive(true)
		self.detailPanel:Update(self.selectedItem.index, self.selectedItem.event)

		self.contextData.selectedEventId = self.selectedItem.event.id

		shiftPanel(self.detailPanel.go, nil, -155, var_36_0, 0, true):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(arg_36_1))

		local var_38_0 = 100000
		local var_38_1 = {}

		for iter_38_0 = 0, var_36_2.childCount - 1 do
			local var_38_2 = var_36_2:GetChild(iter_38_0)

			if var_38_2 == self.selectedItem.tr then
				var_38_0 = iter_38_0
			elseif var_38_0 < iter_38_0 then
				table.insert(var_38_1, var_38_2)
			end
		end

		self.rawLayouts = {}

		for iter_38_1, iter_38_2 in ipairs(var_38_1) do
			local var_38_3 = iter_38_2:GetComponent(typeof(LayoutElement))

			self.rawLayouts[iter_38_2] = var_38_3.ignoreLayout
			var_38_3.ignoreLayout = true

			shiftPanel(iter_38_2, nil, iter_38_2.localPosition.y + -347, var_36_0, 0, true):setEase(LeanTweenType.easeInOutCirc)
		end

		return
	end))

	return
end

function EventListScene:easeOutDetail(arg_39_1)
	local var_39_0 = 100000
	local var_39_1 = {}

	for iter_39_0 = 0, self.scrollRect.content.childCount - 1 do
		local var_39_2 = self.scrollRect.content:GetChild(iter_39_0)

		if var_39_2 == self.selectedItem.tr then
			var_39_0 = iter_39_0
		elseif var_39_0 < iter_39_0 then
			table.insert(var_39_1, var_39_2)
		end
	end

	for iter_39_1, iter_39_2 in ipairs(var_39_1) do
		shiftPanel(iter_39_2, nil, iter_39_2.localPosition.y + 268, 0.2, 0, true):setEase(LeanTweenType.easeInOutCirc)
	end

	shiftPanel(self.detailPanel.go, nil, 129, 0.2, 0, true):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(function()
		for iter_40_0, iter_40_1 in ipairs(var_39_1) do
			if not self.rawLayouts[iter_40_1] then
				iter_40_1:GetComponent(typeof(LayoutElement)).ignoreLayout = false
			end
		end

		self.rawLayouts = {}

		self.mask.gameObject:SetActive(false)
		self.scrollItem.go:SetActive(false)
		self.detailPanel.go:SetActive(false)

		self.scrollRect.enabled = true

		arg_39_1()

		return
	end))

	return
end

function EventListScene:showDetail()
	self.scrollRect.enabled = false

	self.mask.gameObject:SetActive(true)

	self.scrollItem.tr.localPosition.y = self.scrollRect.transform.rect.yMax + self.scrollRect.transform.localPosition.y
	self.scrollItem.tr.localPosition = self.scrollItem.tr.localPosition

	self.scrollItem.go:SetActive(true)
	self.scrollItem:Update(self.selectedItem.index, self.selectedItem.event)
	self.scrollItem:UpdateTime()
	self.detailPanel.tr:SetParent(self.scrollItem.tr:Find("maskDetail"), true)

	self.detailPanel.tr.anchoredPosition = Vector3.New(-1, -155, 0)

	self.detailPanel.go:SetActive(true)
	self.detailPanel:Update(self.selectedItem.index, self.selectedItem.event)

	self.contextData.selectedEventId = self.selectedItem.event.id

	local var_41_0 = 100000

	self.rawLayouts = {}

	for iter_41_0 = 0, self.scrollRect.content.childCount - 1 do
		local var_41_1 = self.scrollRect.content:GetChild(iter_41_0)
		local var_41_2 = var_41_1:GetComponent(typeof(LayoutElement))

		if var_41_2.ignoreLayout or not var_41_1.gameObject.activeSelf then
			self.rawLayouts[var_41_1] = var_41_2.ignoreLayout
		elseif var_41_1 == self.selectedItem.tr then
			var_41_0 = iter_41_0
		elseif var_41_0 < iter_41_0 then
			self.rawLayouts[var_41_1] = var_41_2.ignoreLayout
			var_41_2.ignoreLayout = true
			var_41_1.localPosition = var_41_1.localPosition + Vector3.New(-1, -347, 0)
		end
	end

	pg.UIMgr.GetInstance():BlurPanel(self.blurPanel)

	return
end

function EventListScene:ctimer()
	self.timer = Timer.New(function()
		if self.selectedItem then
			self.scrollItem:UpdateTime()
		end

		local var_43_0 = pg.TimeMgr.GetInstance()
		local var_43_1 = var_43_0:GetServerTime()

		if var_43_0:STimeDescS(var_43_1, "%Y/%m/%d") ~= var_43_0:STimeDescS(var_43_1 - 1, "%Y/%m/%d") then
			self.dispatch(EventConst.EVENT_FLUSH_ALL)

			return
		end

		local var_43_2 = false

		for iter_43_0, iter_43_1 in pairs(self.scrollItems) do
			if iter_43_1.go.name ~= "-1" then
				iter_43_1:UpdateTime()

				local var_43_3 = iter_43_1.event:GetCountDownTime()

				if var_43_3 and var_43_3 < 0 then
					var_43_2 = true
				end
			end
		end

		if var_43_2 then
			self.dispatch(EventConst.EVENT_LIST_UPDATE)
		end

		return
	end, 1, -1, true)

	self.timer:Start()

	return
end

function EventListScene:ktimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function EventListScene:setOpEnabled(arg_45_1)
	_.each(self.toggles, function(arg_46_0)
		setToggleEnabled(arg_46_0, arg_45_1)

		return
	end)
	setButtonEnabled(self.btnBack, arg_45_1)

	return
end

function EventListScene:updateBtnTip()
	local var_47_0 = {
		false
	}

	var_47_0[2] = getProxy(EventProxy):checkNightEvent()

	for iter_47_0, iter_47_1 in ipairs(self.eventList) do
		if iter_47_1:GetState() == EventInfo.StateFinish then
			var_47_0[iter_47_1.template.type] = true
		end
	end

	for iter_47_2, iter_47_3 in ipairs(self.toggles) do
		setActive(findTF(iter_47_3, "tip"), var_47_0[iter_47_2])
	end

	return
end

function EventListScene:willExit()
	if self.tweens then
		cancelTweens(self.tweens)
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self.blurPanel, self._tf)
	self:ktimer()

	for iter_48_0, iter_48_1 in pairs(self.scrollItems) do
		iter_48_1:Clear()
	end

	self.scrollItem:Clear()
	self.detailPanel:Clear()

	return
end

return EventListScene
