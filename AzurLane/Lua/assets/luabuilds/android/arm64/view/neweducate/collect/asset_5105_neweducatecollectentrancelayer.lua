class = var_0_10000

local var_0_0 = "NewEducateCollectEntranceLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateCollectEntranceUI"
end

function var_0_1.getGroupName(arg_2_0)
	return "NewEducateBaseUI"
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "anim_root")
	local var_3_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_3_0.anim = var_3_2(var_3_1, var_4(var_1_10006))

	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_1.Find(var_3_3, "anim_root")
	local var_3_5 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_3_0.animEvent = var_3_5(var_3_4, var_4(var_1_10006))

	local var_3_6 = arg_3_0.animEvent

	var_1.SetEndEvent(var_3_6, function()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_3_7 = arg_3_0._tf

	arg_3_0.contentTF = var_1.Find(var_3_7, "anim_root/content")

	local var_3_8 = arg_3_0.contentTF

	Vector2 = var_1_10002
	var_3_8.offsetMin = var_1_10002(arg_3_0.contextData.isSelect and 208 or 0, 0)

	local var_3_9 = arg_3_0.contentTF

	Vector2 = var_2
	var_3_9.offsetMax = var_2(0, 0)

	local var_3_10 = arg_3_0.contentTF

	arg_3_0.memoryBtn = var_1.Find(var_3_10, "memory_btn")

	local var_3_11 = arg_3_0.contentTF

	arg_3_0.polaroidBtn = var_1.Find(var_3_11, "polaroid_btn")

	local var_3_12 = arg_3_0.contentTF

	arg_3_0.polaroidBtn2 = var_1.Find(var_3_12, "polaroid_btn2")

	local var_3_13 = arg_3_0.contentTF

	arg_3_0.buffBtn = var_1.Find(var_3_13, "buff_btn")

	local var_3_14 = arg_3_0.contentTF

	arg_3_0.endingBtn = var_1.Find(var_3_14, "ending_btn")

	local var_3_15 = arg_3_0.contentTF

	arg_3_0.reviewBtn = var_1.Find(var_3_15, "review_btn")

	local var_3_16 = arg_3_0._tf

	arg_3_0.leftTF = var_1.Find(var_3_16, "anim_root/left")

	local var_3_17 = arg_3_0.leftTF

	arg_3_0.togglesTF = var_1.Find(var_3_17, "toggles")
	arg_3_0.ids = {
		0
	}
	table = var_1

	local var_3_18 = var_1.mergeArray
	local var_3_19 = arg_3_0.ids

	pg = var_4
	arg_3_0.ids = var_3_18(var_3_19, var_4.child2_data.all)
	UIItemList = var_1

	local var_3_20 = var_1.New
	local var_3_21 = arg_3_0.togglesTF
	local var_3_22 = arg_3_0.togglesTF

	arg_3_0.toggleList = var_3_20(var_3_21, var_4.Find(var_3_22, "tpl"))

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:BlurPanel(arg_5_0._tf)

	onButton = var_1

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0._close(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.memoryBtn

	local function var_5_5()
		if arg_5_0.contextData.id == 0 then
			local var_7_0 = arg_5_0
			local var_7_1 = var_0.emit

			NewEducateCollectEntranceMediator = var_2_10003
			var_2_10003 = var_2_10003.GO_SUBLAYER
			Context = var_2_10004
			var_2_10004 = var_2_10004.New

			local var_7_2 = {}

			EducateCollectMediatorTemplate = var_2_10007
			var_7_2.mediator = var_2_10007
			EducateMemoryLayer = var_2_10007
			var_7_2.viewComponent = var_2_10007

			var_7_1(var_7_0, var_2_10003, var_2_10004(var_7_2))
		else
			local var_7_3 = arg_5_0
			local var_7_4 = var_0.emit

			NewEducateCollectEntranceMediator = var_2_10003

			local var_7_5 = var_2_10003.GO_SUBLAYER

			Context = var_2_10004

			local var_7_6 = var_2_10004.New
			local var_7_7 = {}

			NewEducateCollectMediatorTemplate = var_2_10007
			var_7_7.mediator = var_2_10007
			NewEducateMemoryLayer = var_2_10007
			var_7_7.viewComponent = var_2_10007
			var_7_7.data = {
				permanentData = arg_5_0.permanentData
			}

			var_7_4(var_7_3, var_7_5, var_7_6(var_7_7))
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_3, var_5_4, var_5_5, var_1_10006)

	onButton = var_1

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.polaroidBtn

	local function var_5_8()
		if arg_5_0.contextData.id == 0 then
			local var_8_0 = arg_5_0
			local var_8_1 = var_0.emit

			NewEducateCollectEntranceMediator = var_2_10003
			var_2_10003 = var_2_10003.GO_SUBLAYER
			Context = var_2_10004
			var_2_10004 = var_2_10004.New

			local var_8_2 = {}

			EducateCollectMediatorTemplate = var_2_10007
			var_8_2.mediator = var_2_10007
			EducatePolaroidLayer = var_2_10007
			var_8_2.viewComponent = var_2_10007

			var_8_1(var_8_0, var_2_10003, var_2_10004(var_8_2))

			setActive = var_8_1
			var_2_10004 = arg_5_0.polaroidBtn

			var_8_1(var_2.Find(var_2_10004, "new"), false)
		else
			local var_8_3 = arg_5_0
			local var_8_4 = var_0.emit

			NewEducateCollectEntranceMediator = var_2_10003

			local var_8_5 = var_2_10003.GO_SUBLAYER

			Context = var_2_10004

			local var_8_6 = var_2_10004.New
			local var_8_7 = {}

			NewEducateCollectMediatorTemplate = var_2_10007
			var_8_7.mediator = var_2_10007
			NewEducatePolaroidLayer = var_2_10007
			var_8_7.viewComponent = var_2_10007
			var_8_7.data = {
				permanentData = arg_5_0.permanentData
			}

			var_8_4(var_8_3, var_8_5, var_8_6(var_8_7))
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_6, var_5_7, var_5_8, var_1_10006)

	onButton = var_1

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.polaroidBtn2

	local function var_5_11()
		local var_9_0 = arg_5_0
		local var_9_1 = var_0.emit

		NewEducateCollectEntranceMediator = var_2_10003

		local var_9_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_9_3 = var_2_10004.New
		local var_9_4 = {}

		NewEducateCollectMediatorTemplate = var_2_10007
		var_9_4.mediator = var_2_10007
		NewEducatePolaroidLayer = var_2_10007
		var_9_4.viewComponent = var_2_10007
		var_9_4.data = {
			permanentData = arg_5_0.permanentData
		}

		var_9_1(var_9_0, var_9_2, var_9_3(var_9_4))

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_9, var_5_10, var_5_11, var_1_10006)

	onButton = var_1

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.endingBtn
	local var_5_14 = var_4.Find(var_5_13, "unlock")

	local function var_5_15()
		if arg_5_0.contextData.id == 0 then
			isActive = var_0
			var_2_10004 = arg_5_0.endingBtn

			if var_0(var_2.Find(var_2_10004, "lock")) then
				return
			end

			local var_10_0 = arg_5_0
			local var_10_1 = var_0.emit

			NewEducateCollectEntranceMediator = var_2_10003
			var_2_10003 = var_2_10003.GO_SUBLAYER
			Context = var_2_10004
			var_2_10004 = var_2_10004.New

			local var_10_2 = {}

			EducateCollectMediatorTemplate = var_2_10007
			var_10_2.mediator = var_2_10007
			EducateEndingLayer = var_2_10007
			var_10_2.viewComponent = var_2_10007

			var_10_1(var_10_0, var_2_10003, var_2_10004(var_10_2))
		else
			local var_10_3 = arg_5_0
			local var_10_4 = var_0.emit

			NewEducateCollectEntranceMediator = var_2_10003

			local var_10_5 = var_2_10003.GO_SUBLAYER

			Context = var_2_10004

			local var_10_6 = var_2_10004.New
			local var_10_7 = {}

			NewEducateCollectMediatorTemplate = var_2_10007
			var_10_7.mediator = var_2_10007
			NewEducateEndingLayer = var_2_10007
			var_10_7.viewComponent = var_2_10007
			var_10_7.data = {
				permanentData = arg_5_0.permanentData
			}

			var_10_4(var_10_3, var_10_5, var_10_6(var_10_7))
		end

		return
	end

	SFX_PANEL = var_5_13

	var_1(var_5_12, var_5_14, var_5_15, var_5_13)

	onButton = var_1

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.reviewBtn

	local function var_5_18()
		local var_11_2

		if arg_5_0.contextData.id == 0 then
			local var_11_0 = arg_5_0

			var_11_2.emit(var_11_0, var_0_1.ON_CLOSE)

			pg = var_11_2

			local var_11_1 = var_11_2.m02

			var_11_2 = var_11_2.sendNotification
			GAME = var_3

			local var_11_3 = var_3.GO_SCENE

			SCENE = var_2_10004

			local var_11_4 = var_2_10004.WORLD_COLLECTION

			var_2_10005 = {}
			WorldMediaCollectionScene = var_2_10006
			var_2_10005.page = var_2_10006.PAGE_MEMORTY
			EducateConst = var_6
			var_2_10005.memoryGroup = var_6.REVIEW_GROUP_ID

			var_11_2(var_11_1, var_11_3, var_11_4, var_2_10005)
		else
			pg = var_11_2

			local var_11_5 = var_11_2.child2_data[arg_5_0.contextData.id].memory_group
			local var_11_6 = arg_5_0

			var_1.emit(var_11_6, var_0_1.ON_CLOSE)

			pg = var_1

			local var_11_7 = var_1.m02
			local var_11_8 = var_1.sendNotification

			GAME = var_4

			local var_11_9 = var_4.GO_SCENE

			SCENE = var_2_10005

			local var_11_10 = var_2_10005.WORLD_COLLECTION
			local var_11_11 = {}

			WorldMediaCollectionScene = var_2_10007
			var_11_11.page = var_2_10007.PAGE_MEMORTY
			var_11_11.memoryGroup = var_11_5

			var_11_8(var_11_7, var_11_9, var_11_10, var_11_11)
		end

		return
	end

	SFX_PANEL = var_5_13

	var_1(var_5_16, var_5_17, var_5_18, var_5_13)

	onButton = var_1

	local var_5_19 = arg_5_0
	local var_5_20 = arg_5_0.buffBtn

	local function var_5_21()
		local var_12_0 = arg_5_0
		local var_12_1 = var_0.emit

		NewEducateCollectEntranceMediator = var_2_10003

		local var_12_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_12_3 = var_2_10004.New
		local var_12_4 = {}

		NewEducateCollectMediatorTemplate = var_2_10007
		var_12_4.mediator = var_2_10007
		NewEducateBuffLayer = var_2_10007
		var_12_4.viewComponent = var_2_10007
		var_12_4.data = {
			permanentData = arg_5_0.permanentData
		}

		var_12_1(var_12_0, var_12_2, var_12_3(var_12_4))

		return
	end

	SFX_PANEL = var_5_13

	var_1(var_5_19, var_5_20, var_5_21, var_5_13)

	local var_5_22 = arg_5_0.toggleList

	var_1.make(var_5_22, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventInit then
			arg_13_2.name = arg_5_0.ids[arg_13_1 + 1]

			local var_13_0

			if var_3 == 0 then
				var_13_0 = "linghangyuan1_1"
			else
				pg = var_13_0
				var_13_0 = var_13_0.child2_data[var_3].head
			end

			LoadImageSpriteAsync = var_2_10005

			local var_13_1 = "qicon/" .. var_13_0
			local var_13_2 = arg_13_2

			var_2_10005(var_13_1, arg_13_2.Find(var_13_2, "icon"))

			onToggle = var_2_10005

			local var_13_3 = arg_5_0
			local var_13_4 = arg_13_2

			local function var_13_5(arg_14_0)
				if arg_14_0 then
					arg_5_0.contextData.id = var_0

					if arg_5_0.contextData.id == 0 then
						local var_14_0 = arg_5_0

						var_1.FlushTBView(var_14_0)
					else
						local var_14_1 = arg_5_0

						var_1.FlushView(var_14_1, arg_5_0.contextData.id)
					end
				end

				return
			end

			SFX_PANEL = var_13_2

			var_2_10005(var_13_3, var_13_4, var_13_5, var_13_2)
		end

		return
	end)

	local var_5_23 = arg_5_0.toggleList

	var_1.align(var_5_23, #arg_5_0.ids)

	setActive = var_1

	var_1(arg_5_0.leftTF, arg_5_0.contextData.isSelect)

	if arg_5_0.contextData.isSelect then
		triggerToggle = var_1

		local var_5_24 = arg_5_0.togglesTF
		local var_5_25 = var_3.Find

		tostring = var_5_13

		var_1(var_5_25(var_5_24, var_5_13(arg_5_0.contextData.id)), true)
	else
		arg_5_0:FlushView(arg_5_0.contextData.id)
	end

	return
end

function var_0_1.FlushView(arg_15_0, arg_15_1)
	getProxy = var_1_10002
	NewEducateProxy = var_1_10004

	local var_15_0 = var_1_10002(var_1_10004)
	local var_15_1 = var_2.GetChar(var_15_0, arg_15_1)

	arg_15_0.permanentData = var_2.GetPermanentData(var_15_1)

	local var_15_2 = arg_15_0.permanentData
	local var_15_3 = #var_2.GetUnlockMemoryIds(var_15_2)
	local var_15_4 = arg_15_0.permanentData
	local var_15_5 = #var_3.GetAllMemoryIds(var_15_4)

	setText = var_15_2

	local var_15_6 = arg_15_0.memoryBtn

	var_15_2(var_6.Find(var_15_6, "Text"), var_15_3 .. "/" .. var_15_5)

	setActive = var_15_2

	local var_15_7 = arg_15_0.memoryBtn

	var_15_2(var_6.Find(var_15_7, "new"), false)

	local var_15_8 = arg_15_0.permanentData
	local var_15_9 = var_4.IsTarotType(var_15_8)
	local var_15_10 = arg_15_0.permanentData
	local var_15_11 = #var_5.GetUnlockPolaroidGroups(var_15_10)
	local var_15_12 = arg_15_0.permanentData
	local var_15_13 = #var_6.GetAllPolaroidGroups(var_15_12)

	setText = var_15_10

	local var_15_14 = arg_15_0.polaroidBtn

	var_15_10(var_9.Find(var_15_14, "Text"), var_15_11 .. "/" .. var_15_13)

	setText = var_15_10

	local var_15_15 = arg_15_0.polaroidBtn2

	var_15_10(var_9.Find(var_15_15, "Text"), var_15_11 .. "/" .. var_15_13)

	setActive = var_15_10

	local var_15_16 = arg_15_0.polaroidBtn

	var_15_10(var_9.Find(var_15_16, "new"), false)

	setActive = var_15_10

	local var_15_17 = arg_15_0.polaroidBtn2

	var_15_10(var_9.Find(var_15_17, "new"), false)

	setActive = var_15_10

	var_15_10(arg_15_0.polaroidBtn, not var_15_9)

	setActive = var_15_10

	var_15_10(arg_15_0.polaroidBtn2, var_15_9)

	setActive = var_15_10

	var_15_10(arg_15_0.buffBtn, var_15_9)

	if var_15_9 then
		local var_15_18 = arg_15_0.permanentData
		local var_15_19 = var_7.GetAllBuffCnt(var_15_18)
		local var_15_20 = arg_15_0.permanentData
		local var_15_21 = var_8.GetAllUnlockBuffCnt(var_15_20)

		setText = var_15_18

		local var_15_22 = arg_15_0.buffBtn

		var_15_18(var_11.Find(var_15_22, "Text"), var_15_21 .. "/" .. var_15_19)
	end

	local var_15_23 = arg_15_0.permanentData
	local var_15_24 = #var_7.GetActivatedEndings(var_15_23)
	local var_15_25 = arg_15_0.permanentData
	local var_15_26 = #var_8.GetAllEndingIds(var_15_25)

	setText = var_15_23

	local var_15_27 = arg_15_0.endingBtn

	var_15_23(var_11.Find(var_15_27, "unlock/Text"), var_15_24 .. "/" .. var_15_26)

	NewEducateConst = var_15_23

	local var_15_29

	if var_15_23.LOCK_ENDING then
		local var_15_28 = arg_15_0.permanentData

		var_15_29 = var_9.GetGameCnt(var_15_28)
	end

	setActive = var_15_25

	local var_15_30 = arg_15_0.endingBtn

	var_15_25(var_12.Find(var_15_30, "unlock"), not var_15_29)

	setActive = var_15_25

	local var_15_31 = arg_15_0.endingBtn

	var_15_25(var_12.Find(var_15_31, "lock"), var_15_29)

	return
end

function var_0_1.FlushTBView(arg_16_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_16_0 = var_1_10001(var_1_10003)
	local var_16_1 = var_1.GetMemories(var_16_0)
	local var_16_2 = var_1
	local var_16_3 = var_1.GetAllEndings(var_16_2)

	pg = var_16_0

	local var_16_4 = #var_16_0.child_memory.all

	setText = var_16_2

	local var_16_5 = arg_16_0.memoryBtn

	var_16_2(var_7.Find(var_16_5, "Text"), #var_16_1 .. "/" .. var_16_4)
	arg_16_0:UpdateMemoryTip()

	local var_16_6 = var_1
	local var_16_7, var_16_8 = var_1.GetPolaroidGroupCnt(var_16_6)

	setText = var_16_6

	local var_16_9 = arg_16_0.polaroidBtn

	var_16_6(var_9.Find(var_16_9, "Text"), var_16_7 .. "/" .. var_16_8)

	setActive = var_16_6

	local var_16_10 = arg_16_0.polaroidBtn
	local var_16_11 = var_9.Find(var_16_10, "lock")

	EducateHelper = var_10

	local var_16_12 = var_10.IsSystemUnlock

	EducateConst = var_12

	var_16_6(var_16_11, not var_16_12(var_12.SYSTEM_POLAROID))

	setActive = var_16_6

	local var_16_13 = arg_16_0.polaroidBtn
	local var_16_14 = var_9.Find(var_16_13, "new")

	EducateTipHelper = var_10

	local var_16_15 = var_10.IsShowNewTip

	EducateTipHelper = var_12

	var_16_6(var_16_14, var_16_15(var_12.NEW_POLAROID))

	setActive = var_16_6

	var_16_6(arg_16_0.polaroidBtn, true)

	setActive = var_16_6

	var_16_6(arg_16_0.polaroidBtn2, false)

	setActive = var_16_6

	var_16_6(arg_16_0.buffBtn, false)

	pg = var_16_6

	local var_16_16 = #var_16_6.child_ending.all

	setText = var_8

	local var_16_17 = arg_16_0.endingBtn

	var_8(var_10.Find(var_16_17, "unlock/Text"), #var_16_3 .. "/" .. var_16_16)

	EducateHelper = var_8

	local var_16_18 = var_8.IsSystemUnlock

	EducateConst = var_10

	local var_16_20

	if not var_16_18(var_10.SYSTEM_ENDING) then
		local var_16_19 = #var_16_3

		var_16_20 = 0 < var_16_19
	end

	setActive = var_9

	local var_16_21 = arg_16_0.endingBtn

	var_9(var_11.Find(var_16_21, "unlock"), var_16_20)

	setActive = var_9

	local var_16_22 = arg_16_0.endingBtn

	var_9(var_11.Find(var_16_22, "lock"), not var_16_20)

	return
end

function var_0_1.UpdateMemoryTip(arg_17_0)
	underscore = var_1_10001

	local var_17_0 = var_1_10001.any

	pg = var_1_10003

	local var_17_1 = var_17_0(var_1_10003.child_memory.all, function(arg_18_0)
		EducateTipHelper = var_2_10001

		local var_18_0 = var_2_10001.IsShowNewTip

		EducateTipHelper = var_2_10003

		return var_18_0(var_2_10003.NEW_MEMORY, arg_18_0)
	end)

	setActive = var_1_10002

	local var_17_2 = arg_17_0.memoryBtn

	var_1_10002(var_4.Find(var_17_2, "new"), var_17_1)

	return
end

function var_0_1._close(arg_19_0)
	local var_19_0 = arg_19_0.anim

	var_1.Play(var_19_0, "anim_educate_collectentrance_out")

	return
end

function var_0_1.onBackPressed(arg_20_0)
	arg_20_0:_close()

	return
end

function var_0_1.willExit(arg_21_0)
	local var_21_0 = arg_21_0.animEvent

	var_1.SetEndEvent(var_21_0, nil)
	arg_21_0:UnOverlayPanel(arg_21_0._tf)

	return
end

return var_0_1
