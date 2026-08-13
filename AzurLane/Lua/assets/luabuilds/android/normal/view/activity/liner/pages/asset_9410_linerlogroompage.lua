class = var_0_10000

local var_0_0 = "LinerLogRoomPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "LinerLogRoomPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.leftTF = var_1.Find(var_2_0, "left")

	local var_2_1 = arg_2_0._tf

	arg_2_0.rightTF = var_1.Find(var_2_1, "right")

	local var_2_2 = arg_2_0._tf

	arg_2_0.togglesTF = var_1.Find(var_2_2, "toggles")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "view")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.anim = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "view/content")

	arg_2_0.itemTFs = {
		var_2_7:Find("1"),
		var_2_7:Find("2"),
		var_2_7:Find("3"),
		(var_2_7:Find("4"))
	}
	pairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_0.itemTFs) do
		local var_2_8 = iter_2_1:Find("empty")
		local var_2_9 = var_7.GetComponent

		typeof = var_9
		Image = var_1_10010

		local var_2_10 = var_2_9(var_2_8, var_9(var_1_10010))

		var_7.SetNativeSize(var_2_10)
	end

	local var_2_11 = arg_2_0._tf

	arg_2_0.awardTF = var_2.Find(var_2_11, "award/mask/IconTpl")

	local var_2_12 = arg_2_0._tf

	arg_2_0.awardDesc = var_2.Find(var_2_12, "award/Text")
	setText = var_2

	local var_2_13 = arg_2_0.awardDesc

	i18n = var_4

	var_2(var_2_13, var_4("liner_room_award_tip"))

	local var_2_14 = arg_2_0._tf

	arg_2_0.goBtn = var_2.Find(var_2_14, "award/go")

	local var_2_15 = arg_2_0._tf

	arg_2_0.getBtn = var_2.Find(var_2_15, "award/get")

	local var_2_16 = arg_2_0._tf

	arg_2_0.gotTF = var_2.Find(var_2_16, "award/got")

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0:UpdateActivity()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.getBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		LinerLogBookMediator = var_2_10002

		local var_4_2 = var_2_10002.GET_ROOM_AWARD
		local var_4_3 = arg_3_0.activity.id
		local var_4_4 = arg_3_0.curIdx
		local var_4_5 = arg_3_0.groups[arg_3_0.curIdx]

		var_4_1(var_4_0, var_4_2, var_4_3, var_4_4, var_5.GetDrop(var_4_5))

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.goBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		LinerLogBookMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_CLOSE)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)

	local var_3_6 = arg_3_0.activity

	arg_3_0.groupIds = var_1.getConfig(var_3_6, "config_data")[2]
	arg_3_0.groups = {}
	ipairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0.groupIds) do
		local var_3_7 = arg_3_0.groups

		LinerRoomGroup = var_1_10007
		var_3_7[iter_3_0] = var_1_10007.New(iter_3_1)
	end

	UIItemList = var_1

	local var_3_8 = var_1.New
	local var_3_9 = arg_3_0.togglesTF
	local var_3_10 = arg_3_0.togglesTF

	arg_3_0.toggleUIList = var_3_8(var_3_9, var_3.Find(var_3_10, "tpl"))

	local var_3_11 = arg_3_0.toggleUIList

	var_1.make(var_3_11, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventInit then
			arg_6_2.name = arg_6_1 + 1

			local var_6_0 = "PAGE "

			string = var_2_10005

			local var_6_1 = var_6_0 .. var_2_10005.format("%02d", var_3)

			setText = var_5

			var_5(arg_6_2:Find("Text"), var_6_1)

			setText = var_5

			var_5(arg_6_2:Find("selected/Text"), var_6_1)

			onToggle = var_5

			local var_6_2 = arg_3_0
			local var_6_3 = arg_6_2

			local function var_6_4(arg_7_0)
				if arg_7_0 then
					if arg_3_0.curIdx and arg_3_0.curIdx == var_0 then
						return
					end

					arg_3_0.curIdx = var_0

					local var_7_0 = arg_3_0

					var_1.FlushPage(var_7_0)
				end

				return
			end

			SFX_CONFIRM = var_2_10009

			var_5(var_6_2, var_6_3, var_6_4, var_2_10009)
		else
			UIItemList = var_3

			if arg_6_0 == var_3.EventUpdate then
				setActive = var_3

				var_3(arg_6_2:Find("tip"), var_0_1.IsTipWithGroupId(arg_3_0.activity, arg_3_0.groups[arg_6_1 + 1].id))
			end
		end

		return
	end)

	local var_3_12 = arg_3_0.toggleUIList

	var_1.align(var_3_12, #arg_3_0.groupIds)

	triggerToggle = var_1

	local var_3_13 = arg_3_0.toggleUIList.container

	var_1(var_2.Find(var_3_13, "1"), true)

	return
end

function var_0_1.UpdateActivity(arg_8_0, arg_8_1)
	local var_8_1

	if not arg_8_1 then
		::label_8_0::

		getProxy = var_8_1
		ActivityProxy = var_1_10003

		local var_8_0 = var_8_1(var_1_10003)

		var_8_1 = var_8_1.getActivityByType
		ActivityConst = var_1_10004
		var_8_1 = var_8_1(var_8_0, var_1_10004.ACTIVITY_TYPE_LINER)
	end

	arg_8_0.activity = var_8_1
	assert = var_8_1

	local var_8_3

	if arg_8_0.activity then
		local var_8_2 = arg_8_0.activity

		var_8_3 = not var_3.isEnd(var_8_2)
	end

	local var_8_4 = "not exist liner act, type: "

	ActivityConst = var_1_10005

	var_8_1(var_8_3, var_8_4 .. var_1_10005.ACTIVITY_TYPE_LINER)

	local var_8_5 = arg_8_0.activity

	arg_8_0.finishRoomIds = var_2.GetExploredRoomIds(var_8_5)

	return
end

function var_0_1.FlushPage(arg_9_0)
	local var_9_0 = arg_9_0.anim

	var_1.Play(var_9_0)

	local var_9_1 = arg_9_0.toggleUIList

	var_1.align(var_9_1, #arg_9_0.groupIds)

	local var_9_2 = false
	local var_9_3 = arg_9_0.groups[arg_9_0.curIdx]
	local var_9_4 = var_2.GetIds(var_9_3)

	ipairs = var_9_3

	for iter_9_0, iter_9_1 in var_9_3(var_9_4) do
		if arg_9_0.itemTFs[iter_9_0] then
			setActive = var_1_10009

			var_1_10009(var_1_10008, true)

			var_1_10009 = var_1_10008:Find("name/Text")

			local var_9_5 = var_1_10008:Find("desc")
			local var_9_6 = arg_9_0.groups[arg_9_0.curIdx]
			local var_9_7 = var_11.GetRoom(var_9_6, iter_9_1)

			setText = var_9_6

			var_9_6(var_1_10009, var_9_7:GetName())

			setImageSprite = var_9_6

			local var_9_8 = var_1_10008
			local var_9_9 = var_1_10008.Find(var_9_8, "icon")

			GetSpriteFromAtlas = var_9_8

			var_9_6(var_9_9, var_9_8("ui/linermainui_atlas", "area" .. iter_9_1, true))

			table = var_9_6

			if not var_9_6.contains(arg_9_0.finishRoomIds, iter_9_1) then
				var_9_2 = true
			end

			setText = var_13

			local var_9_10 = var_9_5
			local var_9_11

			if not var_12 or not var_9_7:GetDesc() then
				var_9_11 = ""
			end

			var_13(var_9_10, var_9_11)

			setActive = var_13

			var_13(var_1_10008:Find("empty"), not var_12)
		end
	end

	for iter_9_2 = #var_9_4 + 1, #arg_9_0.itemTFs do
		setActive = iter_9_1

		iter_9_1(arg_9_0.itemTFs[iter_9_2], false)
	end

	local var_9_12 = arg_9_0.groups[arg_9_0.curIdx]
	local var_9_13 = var_3.GetDrop(var_9_12)

	updateDrop = var_9_12

	var_9_12(arg_9_0.awardTF, var_9_13)

	onButton = var_9_12

	local var_9_14 = arg_9_0
	local var_9_15 = arg_9_0.awardTF

	local function var_9_16()
		local var_10_0 = arg_9_0
		local var_10_1 = var_0.emit

		BaseUI = var_2_10002

		var_10_1(var_10_0, var_2_10002.ON_DROP, var_9_13)

		return
	end

	SFX_PANEL = var_1_10008

	var_9_12(var_9_14, var_9_15, var_9_16, var_1_10008)

	local var_9_17 = arg_9_0.activity
	local var_9_18 = not var_4.IsGotRoomAward(var_9_17, arg_9_0.curIdx) and not var_9_2

	setActive = var_6

	var_6(arg_9_0.goBtn, not var_4 and not var_9_18)

	setActive = var_6

	var_6(arg_9_0.gotTF, var_4)

	setActive = var_6

	local var_9_19 = arg_9_0.awardTF

	var_6(var_7.Find(var_9_19, "mask"), var_4)

	setActive = var_6

	var_6(arg_9_0.getBtn, var_9_18)
	arg_9_0:Show()

	return
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

function var_0_1.IsTipWithGroupId(arg_12_0, arg_12_1)
	table = var_1_10002

	local var_12_0 = var_1_10002.indexof(arg_12_0:GetRoomGroupIds(), arg_12_1)

	if arg_12_0:IsGotRoomAward(var_12_0) then
		return false
	end

	local var_12_1 = arg_12_0
	local var_12_2 = arg_12_0.GetExploredRoomIds(var_12_1)

	underscore = var_12_1

	local var_12_3 = var_12_1.all

	pg = var_5

	return var_12_3(var_5.activity_liner_room_group[arg_12_1].ids, function(arg_13_0)
		table = var_2_10001

		return var_2_10001.contains(var_12_2, arg_13_0)
	end)
end

function var_0_1.IsTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_14_0 = var_1_10000(var_1_10001)
	local var_14_1 = var_0.getActivityByType

	ActivityConst = var_1_10002

	local var_14_2 = var_14_1(var_14_0, var_1_10002.ACTIVITY_TYPE_LINER)

	assert = var_14_0

	local var_14_3 = var_14_2 and not var_14_2:isEnd()
	local var_14_4 = "not exist liner act, type: "

	ActivityConst = var_1_10004

	var_14_0(var_14_3, var_14_4 .. var_1_10004.ACTIVITY_TYPE_LINER)

	local var_14_5 = var_14_2
	local var_14_6 = var_14_2.GetRoomGroupIds(var_14_5)

	underscore = var_14_5

	return var_14_5.any(var_14_6, function(arg_15_0)
		return var_0_1.IsTipWithGroupId(var_14_2, arg_15_0)
	end)
end

return var_0_1
