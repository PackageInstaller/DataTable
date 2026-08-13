class = var_0_10000

local var_0_0 = "LinerRoomInfoPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.TYPEWRITE_SPEED = 0.03
var_0_1.TYPE_EXPLORE = 1
var_0_1.TYPE_EVENT = 2
var_0_1.MODE_EVENT_DESC = 1
var_0_1.MODE_OPTION_DESC = 2
var_0_1.MODE_ROOM_DESC = 3
var_0_1.TIME_DIFF_LIST = {
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
var_0_1.ICON_LIST = {
	2,
	5,
	6,
	12,
	13,
	14
}

function var_0_1.getUIName(arg_1_0)
	return "LinerRoomInfoPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.dotTF = var_1.Find(var_2_0, "frame/bottom/name/Image")

	local var_2_1 = arg_2_0._tf

	arg_2_0.nameTF = var_1.Find(var_2_1, "frame/bottom/name/Text")

	local var_2_2 = arg_2_0._tf

	arg_2_0.iconTF = var_1.Find(var_2_2, "frame/bottom/icon/mask/Image")

	local var_2_3 = arg_2_0._tf

	arg_2_0.descTF = var_1.Find(var_2_3, "frame/bottom/Text")

	local var_2_4 = arg_2_0._tf

	arg_2_0.nextTF = var_1.Find(var_2_4, "frame/bottom/next")
	GetComponent = var_1

	local var_2_5 = arg_2_0.descTF

	typeof = var_3
	Typewriter = var_1_10004
	arg_2_0.typewrite = var_1(var_2_5, var_3(var_1_10004))

	local var_2_6 = arg_2_0.typewrite

	var_1.setSpeed(var_2_6, var_0_1.TYPEWRITE_SPEED)

	local var_2_7 = arg_2_0._tf

	arg_2_0.optionsTF = var_1.Find(var_2_7, "frame/options")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "mask")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.OnClick(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "frame/bottom")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.OnClick(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	local var_3_8 = arg_3_0.typewrite

	function var_3_8.endFunc()
		if arg_3_0.curIndex == #arg_3_0.descList then
			switch = var_0

			var_0(arg_3_0.mode, {
				[var_0_1.MODE_EVENT_DESC] = function()
					setActive = var_3_10000

					var_3_10000(arg_3_0.optionsTF, true)

					local var_7_0 = arg_3_0

					var_0.ShowOptionsAnim(var_7_0)

					return
				end,
				[var_0_1.MODE_OPTION_DESC] = function()
					pg = var_3_10000

					local var_8_0 = var_3_10000.TipsMgr.GetInstance()
					local var_8_1 = var_0.ShowTips

					i18n = var_3_10002

					var_8_1(var_8_0, var_3_10002("liner_event_get_tip", arg_3_0.eventName))

					return
				end,
				[var_0_1.MODE_ROOM_DESC] = function()
					pg = var_3_10000

					local var_9_0 = var_3_10000.TipsMgr.GetInstance()
					local var_9_1 = var_0.ShowTips

					i18n = var_3_10002

					local var_9_2 = "liner_room_get_tip"
					local var_9_3 = arg_3_0.room

					var_9_1(var_9_0, var_3_10002(var_9_2, var_4.GetName(var_9_3)))

					return
				end
			})
		end

		arg_3_0.isWriting = false
		arg_3_0.curIndex = arg_3_0.curIndex + 1

		return
	end

	UIItemList = var_3_8

	local var_3_9 = var_3_8.New
	local var_3_10 = arg_3_0.optionsTF
	local var_3_11 = arg_3_0.optionsTF

	arg_3_0.optionsUIList = var_3_9(var_3_10, var_3.Find(var_3_11, "tpl"))

	local var_3_12 = arg_3_0.optionsUIList

	var_1.make(var_3_12, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_10_1 + 1
			local var_10_1 = arg_3_0.events[var_10_0]

			setText = var_2_10005

			var_2_10005(arg_10_2:Find("Text"), var_10_1:GetOptionName())

			onButton = var_2_10005

			local var_10_2 = arg_3_0
			local var_10_3 = arg_10_2

			local function var_10_4()
				table = var_3_10000

				if var_3_10000.contains(arg_3_0.finishEventIds, var_10_1.id) then
					return
				end

				arg_3_0.isClickEvent = true

				local var_11_0 = arg_3_0
				local var_11_1 = var_0.emit

				LinerMediator = var_2

				var_11_1(var_11_0, var_2.CLICK_EVENT, {
					actId = arg_3_0.activity.id,
					roomId = arg_3_0.room.id,
					eventId = var_10_1.id,
					callback = function()
						local var_12_0 = arg_3_0
						local var_12_1 = var_10_1

						var_12_0.eventName = var_1.GetTitle(var_12_1)

						local var_12_2 = arg_3_0
						local var_12_3 = var_0.SetContent
						local var_12_4 = var_10_1

						var_12_3(var_12_2, var_2.GetOptionDisplay(var_12_4), var_0_1.MODE_OPTION_DESC)

						table = var_12_3

						var_12_3.insert(arg_3_0.finishEventIds, var_10_1.id)

						table = var_0

						var_0.remove(arg_3_0.events, var_10_0)

						local var_12_5 = arg_3_0.optionsUIList

						var_0.align(var_12_5, #arg_3_0.events)

						return
					end
				})

				return
			end

			SFX_CONFIRM = var_2_10009

			var_2_10005(var_10_2, var_10_3, var_10_4, var_2_10009)
		end

		return
	end)

	return
end

function var_0_1.ShowInfo(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.activity = arg_13_1

	local var_13_0 = arg_13_0.activity

	arg_13_0.curTime = var_4.GetCurTime(var_13_0)
	LinerRoom = var_4
	arg_13_0.room = var_4.New(arg_13_2)
	arg_13_0.callback = arg_13_3
	setText = var_4

	local var_13_1 = arg_13_0.nameTF
	local var_13_2 = arg_13_0.room

	var_4(var_13_1, var_6.GetName(var_13_2))

	tostring = var_4

	local var_13_3 = var_4(arg_13_2)

	setLocalScale = var_5

	var_5(arg_13_0.iconTF, {
		x = 0.7,
		y = 0.7
	})

	table = var_5

	local var_13_5

	if var_5.contains(var_0_1.TIME_DIFF_LIST, arg_13_2) then
		local var_13_4 = arg_13_0.curTime

		var_13_5 = var_13_5.GetBgType(var_13_4)
		var_13_3 = var_13_3 .. "_" .. var_13_5
	end

	table = var_13_5

	if var_13_5.contains(var_0_1.ICON_LIST, arg_13_2) then
		var_13_3 = "icon_" .. var_13_3
		setLocalScale = var_5

		var_5(arg_13_0.iconTF, {
			x = 1,
			y = 1
		})
	end

	setImageSprite = var_5

	local var_13_6 = arg_13_0.iconTF

	GetSpriteFromAtlas = var_7

	var_5(var_13_6, var_7("ui/linermainui_atlas", var_13_3), true)

	switch = var_5

	local var_13_7 = arg_13_0.curTime
	local var_13_8 = var_6.GetType(var_13_7)
	local var_13_9 = {}

	LinerTime = var_8
	var_13_9[var_8.TYPE.EXPLORE] = function()
		local var_14_0 = arg_13_0

		var_0.ShowRoomInfos(var_14_0)

		return
	end
	LinerTime = var_8
	var_13_9[var_8.TYPE.EVENT] = function()
		local var_15_0 = arg_13_0

		var_0.ShowEventInfos(var_15_0)

		return
	end

	var_5(var_13_8, var_13_9)
	arg_13_0:Show()

	return
end

function var_0_1.ShowRoomInfos(arg_16_0)
	setImageColor = var_1_10001

	local var_16_0 = arg_16_0.dotTF

	Color = var_1_10003

	var_1_10001(var_16_0, var_1_10003.NewHex("FE9400"))

	setActive = var_1_10001

	var_1_10001(arg_16_0.optionsTF, false)

	local var_16_1 = arg_16_0
	local var_16_2 = arg_16_0.emit

	LinerMediator = var_3

	var_16_2(var_16_1, var_3.CLICK_ROOM, arg_16_0.activity.id, arg_16_0.room.id)

	local var_16_3 = arg_16_0
	local var_16_4 = arg_16_0.SetContent
	local var_16_5 = arg_16_0.room

	var_16_4(var_16_3, var_3.GetDescList(var_16_5), var_0_1.MODE_ROOM_DESC)

	return
end

function var_0_1.ShowEventInfos(arg_17_0)
	setImageColor = var_1_10001

	local var_17_0 = arg_17_0.dotTF

	Color = var_1_10003

	var_1_10001(var_17_0, var_1_10003.NewHex("4E5BFF"))

	local var_17_1 = ""

	arg_17_0.events = {}

	local var_17_2 = arg_17_0.activity
	local var_17_3

	if not var_2.GetCurEventInfo(var_17_2)[arg_17_0.room.id] then
		var_17_3 = {}
	end

	arg_17_0.finishEventIds = var_17_3
	ipairs = var_17_3

	local var_17_4 = arg_17_0.curTime

	for iter_17_0, iter_17_1 in var_17_3(var_3.GetParamInfo(var_17_4)) do
		if iter_17_1[1] == arg_17_0.room.id then
			HXSet = var_7
			var_17_1 = var_7.hxLan(iter_17_1[3])
			ipairs = var_7

			for iter_17_2, iter_17_3 in var_7(iter_17_1[4]) do
				table = var_1_10012

				if not var_1_10012.contains(arg_17_0.finishEventIds, iter_17_3) then
					table = var_1_10012
					var_1_10012 = var_1_10012.insert

					local var_17_5 = arg_17_0.events

					LinerEvent = var_14

					var_1_10012(var_17_5, var_14.New(iter_17_3))
				end
			end
		end
	end

	arg_17_0:SetContent({
		var_17_1
	}, var_0_1.MODE_EVENT_DESC)

	setActive = var_2

	var_2(arg_17_0.optionsTF, false)

	return
end

function var_0_1.ShowOptionsAnim(arg_18_0)
	local var_18_0 = {}

	for iter_18_0 = 1, #arg_18_0.events do
		table = var_1_10006

		var_1_10006.insert(var_18_0, function(arg_19_0)
			local var_19_0 = arg_18_0
			local var_19_1 = var_1.managedTween

			LeanTween = var_2_10003

			var_19_1(var_19_0, var_2_10003.delayedCall, function()
				local var_20_0 = arg_18_0.optionsUIList

				var_0.align(var_20_0, #arg_18_0.events)
				arg_19_0()

				return
			end, 0.066, nil)

			return
		end)
	end

	seriesAsync = var_2

	var_2(var_18_0, function()
		return
	end)

	return
end

function var_0_1.SetContent(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.mode = arg_22_2
	arg_22_0.curIndex = 1
	arg_22_0.descList = arg_22_1

	arg_22_0:SetOnePage()

	return
end

function var_0_1.SetOnePage(arg_23_0)
	arg_23_0.isWriting = true
	setActive = var_1

	var_1(arg_23_0.nextTF, arg_23_0.curIndex < #arg_23_0.descList)

	setText = var_1

	var_1(arg_23_0.descTF, arg_23_0.descList[arg_23_0.curIndex])

	local var_23_0 = arg_23_0.typewrite

	var_1.Play(var_23_0)

	return
end

function var_0_1.OnClick(arg_24_0)
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

	if arg_24_0.callback then
		if not arg_24_0.isClickEvent then
			local var_24_0 = arg_24_0.curTime
			local var_24_1 = var_1.GetType(var_24_0)

			LinerTime = var_24_0

			if var_24_1 == var_24_0.TYPE.EXPLORE then
				arg_24_0.callback()

				arg_24_0.callback = nil
				arg_24_0.isClickEvent = nil
			end

			return
		end
	end
end

return var_0_1
