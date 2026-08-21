local var_0_0 = class("LinerRoomInfoPage", import("view.base.BaseSubView"))

var_0_0.TYPEWRITE_SPEED = 0.03
var_0_0.TYPE_EXPLORE = 1
var_0_0.TYPE_EVENT = 2
var_0_0.MODE_EVENT_DESC = 1
var_0_0.MODE_OPTION_DESC = 2
var_0_0.MODE_ROOM_DESC = 3
var_0_0.TIME_DIFF_LIST = {
	1,
	2,
	3,
	4,
	5,
	6,
	12,
	13,
	14
}
var_0_0.ICON_LIST = {
	2,
	5,
	6,
	12,
	13,
	14
}

function var_0_0.getUIName(arg_1_0)
	return "LinerRoomInfoPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.dotTF = arg_2_0._tf:Find("frame/bottom/name/Image")
	arg_2_0.nameTF = arg_2_0._tf:Find("frame/bottom/name/Text")
	arg_2_0.iconTF = arg_2_0._tf:Find("frame/bottom/icon/mask/Image")
	arg_2_0.descTF = arg_2_0._tf:Find("frame/bottom/Text")
	arg_2_0.nextTF = arg_2_0._tf:Find("frame/bottom/next")
	arg_2_0.typewrite = GetComponent(arg_2_0.descTF, typeof(Typewriter))

	arg_2_0.typewrite:setSpeed(var_0_0.TYPEWRITE_SPEED)

	arg_2_0.optionsTF = arg_2_0._tf:Find("frame/options")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("mask"), function()
		arg_3_0:OnClick()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("frame/bottom"), function()
		arg_3_0:OnClick()

		return
	end, SFX_PANEL)

	function arg_3_0.typewrite.endFunc()
		if arg_3_0.curIndex == #arg_3_0.descList then
			switch(arg_3_0.mode, {
				[var_0_0.MODE_EVENT_DESC] = function()
					setActive(arg_3_0.optionsTF, true)
					arg_3_0:ShowOptionsAnim()

					return
				end,
				[var_0_0.MODE_OPTION_DESC] = function()
					pg.TipsMgr.GetInstance():ShowTips(i18n("liner_event_get_tip", arg_3_0.eventName))

					return
				end,
				[var_0_0.MODE_ROOM_DESC] = function()
					pg.TipsMgr.GetInstance():ShowTips(i18n("liner_room_get_tip", arg_3_0.room:GetName()))

					return
				end
			})
		end

		arg_3_0.isWriting = false
		arg_3_0.curIndex = arg_3_0.curIndex + 1

		return
	end

	arg_3_0.optionsUIList = UIItemList.New(arg_3_0.optionsTF, arg_3_0.optionsTF:Find("tpl"))

	arg_3_0.optionsUIList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			setText(arg_10_2:Find("Text"), arg_3_0.events[arg_10_1 + 1]:GetOptionName())
			onButton(arg_3_0, arg_10_2, function()
				if table.contains(arg_3_0.finishEventIds, var_0.id) then
					return
				end

				arg_3_0.isClickEvent = true

				arg_3_0:emit(LinerMediator.CLICK_EVENT, {
					actId = arg_3_0.activity.id,
					roomId = arg_3_0.room.id,
					eventId = var_0.id,
					callback = function()
						arg_3_0.eventName = var_0:GetTitle()

						arg_3_0:SetContent(var_0:GetOptionDisplay(), var_0_0.MODE_OPTION_DESC)
						table.insert(arg_3_0.finishEventIds, var_0.id)
						table.remove(arg_3_0.events, var_0)
						arg_3_0.optionsUIList:align(#arg_3_0.events)

						return
					end
				})

				return
			end, SFX_CONFIRM)
		end

		return
	end)

	return
end

function var_0_0.ShowInfo(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.activity = arg_13_1
	arg_13_0.curTime = arg_13_0.activity:GetCurTime()
	arg_13_0.room = LinerRoom.New(arg_13_2)
	arg_13_0.callback = arg_13_3

	setText(arg_13_0.nameTF, arg_13_0.room:GetName())

	local var_13_0 = tostring(arg_13_2)

	setLocalScale(arg_13_0.iconTF, {
		x = 0.7,
		y = 0.7
	})

	if table.contains(var_0_0.TIME_DIFF_LIST, arg_13_2) then
		var_13_0 = var_13_0 .. "_" .. arg_13_0.curTime:GetBgType()
	end

	if table.contains(var_0_0.ICON_LIST, arg_13_2) then
		var_13_0 = "icon_" .. var_13_0

		setLocalScale(arg_13_0.iconTF, {
			x = 1,
			y = 1
		})
	end

	setImageSprite(arg_13_0.iconTF, GetSpriteFromAtlas("ui/linermainui_atlas", var_13_0), true)
	switch(arg_13_0.curTime:GetType(), {
		[LinerTime.TYPE.EXPLORE] = function()
			arg_13_0:ShowRoomInfos()

			return
		end,
		[LinerTime.TYPE.EVENT] = function()
			arg_13_0:ShowEventInfos()

			return
		end
	})
	arg_13_0:Show()

	return
end

function var_0_0.ShowRoomInfos(arg_16_0)
	setImageColor(arg_16_0.dotTF, Color.NewHex("FE9400"))
	setActive(arg_16_0.optionsTF, false)
	arg_16_0:emit(LinerMediator.CLICK_ROOM, arg_16_0.activity.id, arg_16_0.room.id)
	arg_16_0:SetContent(arg_16_0.room:GetDescList(), var_0_0.MODE_ROOM_DESC)

	return
end

function var_0_0.ShowEventInfos(arg_17_0)
	setImageColor(arg_17_0.dotTF, Color.NewHex("4E5BFF"))

	local var_17_0 = ""

	arg_17_0.events = {}
	arg_17_0.finishEventIds = arg_17_0.activity:GetCurEventInfo()[arg_17_0.room.id] or {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.curTime:GetParamInfo()) do
		if iter_17_1[1] == arg_17_0.room.id then
			var_17_0 = HXSet.hxLan(iter_17_1[3])

			for iter_17_2, iter_17_3 in ipairs(iter_17_1[4]) do
				if not table.contains(arg_17_0.finishEventIds, iter_17_3) then
					table.insert(arg_17_0.events, LinerEvent.New(iter_17_3))
				end
			end
		end
	end

	arg_17_0:SetContent({
		var_17_0
	}, var_0_0.MODE_EVENT_DESC)
	setActive(arg_17_0.optionsTF, false)

	return
end

function var_0_0.ShowOptionsAnim(arg_18_0)
	for iter_18_0 = 1, #arg_18_0.events do
		table.insert({}, function(arg_19_0)
			arg_18_0:managedTween(LeanTween.delayedCall, function()
				arg_18_0.optionsUIList:align(#arg_18_0.events)
				arg_19_0()

				return
			end, 0.066, nil)

			return
		end)
	end

	seriesAsync({}, function()
		return
	end)

	return
end

function var_0_0.SetContent(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.mode = arg_22_2
	arg_22_0.curIndex = 1
	arg_22_0.descList = arg_22_1

	arg_22_0:SetOnePage()

	return
end

function var_0_0.SetOnePage(arg_23_0)
	arg_23_0.isWriting = true

	setActive(arg_23_0.nextTF, arg_23_0.curIndex < #arg_23_0.descList)
	setText(arg_23_0.descTF, arg_23_0.descList[arg_23_0.curIndex])
	arg_23_0.typewrite:Play()

	return
end

function var_0_0.OnClick(arg_24_0)
	if arg_24_0.isWriting then
		return
	end

	if #arg_24_0.descList >= arg_24_0.curIndex then
		arg_24_0:SetOnePage()

		return
	end

	if arg_24_0.events and #arg_24_0.events > 0 then
		return
	end

	arg_24_0:Hide()

	if arg_24_0.callback and (arg_24_0.isClickEvent or arg_24_0.curTime:GetType() == LinerTime.TYPE.EXPLORE) then
		arg_24_0.callback()

		arg_24_0.callback = nil
		arg_24_0.isClickEvent = nil
	end

	return
end

return var_0_0
