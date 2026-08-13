class = var_0_10000

local var_0_0 = "EducateCollectEntranceLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateCollectEntranceUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.initData(arg_3_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	arg_3_0.memories = var_1.GetMemories(var_3_0)
	arg_3_0.endings = var_1:GetAllEndings()

	return
end

function var_0_1.findUI(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "anim_root")
	local var_4_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_4_0.anim = var_4_2(var_4_1, var_4(var_1_10006))

	local var_4_3 = arg_4_0._tf
	local var_4_4 = var_1.Find(var_4_3, "anim_root")
	local var_4_5 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_4_0.animEvent = var_4_5(var_4_4, var_4(var_1_10006))

	local var_4_6 = arg_4_0.animEvent

	var_1.SetEndEvent(var_4_6, function()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_4_7 = arg_4_0._tf

	arg_4_0.contentTF = var_1.Find(var_4_7, "anim_root/content")

	local var_4_8 = arg_4_0.contentTF

	arg_4_0.memoryBtn = var_1.Find(var_4_8, "memory_btn")

	local var_4_9 = arg_4_0.contentTF

	arg_4_0.polaroidBtn = var_1.Find(var_4_9, "polaroid_btn")

	local var_4_10 = arg_4_0.contentTF

	arg_4_0.endingBtn = var_1.Find(var_4_10, "ending_btn")

	local var_4_11 = arg_4_0.contentTF

	arg_4_0.reviewBtn = var_1.Find(var_4_11, "review_btn")

	return
end

function var_0_1.addListener(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf

	local function var_6_2()
		local var_7_0 = arg_6_0

		var_0._close(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10006)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.memoryBtn

	local function var_6_5()
		local var_8_0 = arg_6_0
		local var_8_1 = var_0.emit
		local var_8_2 = var_0_1.EDUCATE_GO_SUBLAYER

		Context = var_2_10004

		local var_8_3 = var_2_10004.New
		local var_8_4 = {}

		EducateCollectMediatorTemplate = var_2_10007
		var_8_4.mediator = var_2_10007
		EducateMemoryLayer = var_2_10007
		var_8_4.viewComponent = var_2_10007

		var_8_1(var_8_0, var_8_2, var_8_3(var_8_4))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10006)

	onButton = var_1_10001

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.polaroidBtn

	local function var_6_8()
		isActive = var_2_10000

		local var_9_0 = arg_6_0.polaroidBtn

		if var_2_10000(var_2.Find(var_9_0, "lock")) then
			return
		end

		local var_9_1 = arg_6_0
		local var_9_2 = var_0.emit
		local var_9_3 = var_0_1.EDUCATE_GO_SUBLAYER

		Context = var_9_0

		local var_9_4 = var_9_0.New
		local var_9_5 = {}

		EducateCollectMediatorTemplate = var_2_10007
		var_9_5.mediator = var_2_10007
		EducatePolaroidLayer = var_2_10007
		var_9_5.viewComponent = var_2_10007

		var_9_2(var_9_1, var_9_3, var_9_4(var_9_5))

		setActive = var_9_2

		local var_9_6 = arg_6_0.polaroidBtn

		var_9_2(var_2.Find(var_9_6, "new"), false)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10006)

	onButton = var_1_10001

	local var_6_9 = arg_6_0
	local var_6_10 = arg_6_0.endingBtn

	local function var_6_11()
		isActive = var_2_10000

		local var_10_0 = arg_6_0.endingBtn

		if var_2_10000(var_2.Find(var_10_0, "lock")) then
			return
		end

		local var_10_1 = arg_6_0
		local var_10_2 = var_0.emit
		local var_10_3 = var_0_1.EDUCATE_GO_SUBLAYER

		Context = var_10_0

		local var_10_4 = var_10_0.New
		local var_10_5 = {}

		EducateCollectMediatorTemplate = var_2_10007
		var_10_5.mediator = var_2_10007
		EducateEndingLayer = var_2_10007
		var_10_5.viewComponent = var_2_10007

		var_10_2(var_10_1, var_10_3, var_10_4(var_10_5))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_9, var_6_10, var_6_11, var_1_10006)

	onButton = var_1_10001

	local var_6_12 = arg_6_0
	local var_6_13 = arg_6_0.reviewBtn

	local function var_6_14()
		local var_11_0 = arg_6_0

		var_0.emit(var_11_0, var_0_1.ON_CLOSE)

		pg = var_0

		local var_11_1 = var_0.m02
		local var_11_2 = var_0.sendNotification

		GAME = var_3

		local var_11_3 = var_3.GO_SCENE

		SCENE = var_2_10004

		local var_11_4 = var_2_10004.WORLD_COLLECTION
		local var_11_5 = {}

		WorldMediaCollectionScene = var_2_10006
		var_11_5.page = var_2_10006.PAGE_MEMORTY
		EducateConst = var_6
		var_11_5.memoryGroup = var_6.REVIEW_GROUP_ID

		var_11_2(var_11_1, var_11_3, var_11_4, var_11_5)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_12, var_6_13, var_6_14, var_1_10006)

	return
end

function var_0_1.didEnter(arg_12_0)
	pg = var_1_10001

	local var_12_0 = #var_1_10001.child_memory.all

	setText = var_1_10002

	local var_12_1 = arg_12_0.memoryBtn

	var_1_10002(var_4.Find(var_12_1, "Text"), #arg_12_0.memories .. "/" .. var_12_0)

	local var_12_2 = arg_12_0

	arg_12_0.updateMemoryTip(var_12_2)

	getProxy = var_2
	EducateProxy = var_12_2

	local var_12_3 = var_2(var_12_2)
	local var_12_4, var_12_5 = var_2.GetPolaroidGroupCnt(var_12_3)

	setText = var_12_3

	local var_12_6 = arg_12_0.polaroidBtn

	var_12_3(var_6.Find(var_12_6, "Text"), var_12_4 .. "/" .. var_12_5)

	setActive = var_12_3

	local var_12_7 = arg_12_0.polaroidBtn
	local var_12_8 = var_6.Find(var_12_7, "lock")

	EducateHelper = var_7

	local var_12_9 = var_7.IsSystemUnlock

	EducateConst = var_9

	var_12_3(var_12_8, not var_12_9(var_9.SYSTEM_POLAROID))

	setActive = var_12_3

	local var_12_10 = arg_12_0.polaroidBtn
	local var_12_11 = var_6.Find(var_12_10, "new")

	EducateTipHelper = var_7

	local var_12_12 = var_7.IsShowNewTip

	EducateTipHelper = var_9

	var_12_3(var_12_11, var_12_12(var_9.NEW_POLAROID))

	pg = var_12_3

	local var_12_13 = #var_12_3.child_ending.all

	setText = var_5

	local var_12_14 = arg_12_0.endingBtn

	var_5(var_7.Find(var_12_14, "unlock/Text"), #arg_12_0.endings .. "/" .. var_12_13)

	EducateHelper = var_5

	local var_12_15 = var_5.IsSystemUnlock

	EducateConst = var_7

	local var_12_17

	if not var_12_15(var_7.SYSTEM_ENDING) then
		local var_12_16 = #arg_12_0.endings

		var_12_17 = 0 < var_12_16
	end

	setActive = var_12_11

	local var_12_18 = arg_12_0.endingBtn

	var_12_11(var_8.Find(var_12_18, "unlock"), var_12_17)

	setActive = var_12_11

	local var_12_19 = arg_12_0.endingBtn

	var_12_11(var_8.Find(var_12_19, "lock"), not var_12_17)
	arg_12_0:BlurPanel(arg_12_0._tf)

	EducateGuideSequence = var_6

	var_6.CheckGuide(arg_12_0.__cname, function()
		return
	end)

	return
end

function var_0_1.updateMemoryTip(arg_14_0)
	underscore = var_1_10001

	local var_14_0 = var_1_10001.any

	pg = var_1_10003

	local var_14_1 = var_14_0(var_1_10003.child_memory.all, function(arg_15_0)
		EducateTipHelper = var_2_10001

		local var_15_0 = var_2_10001.IsShowNewTip

		EducateTipHelper = var_2_10003

		return var_15_0(var_2_10003.NEW_MEMORY, arg_15_0)
	end)

	setActive = var_1_10002

	local var_14_2 = arg_14_0.memoryBtn

	var_1_10002(var_4.Find(var_14_2, "new"), var_14_1)

	return
end

function var_0_1._close(arg_16_0)
	local var_16_0 = arg_16_0.anim

	var_1.Play(var_16_0, "anim_educate_collectentrance_out")

	return
end

function var_0_1.onBackPressed(arg_17_0)
	arg_17_0:_close()

	return
end

function var_0_1.willExit(arg_18_0)
	local var_18_0 = arg_18_0.animEvent

	var_1.SetEndEvent(var_18_0, nil)
	arg_18_0:UnOverlayPanel(arg_18_0._tf)

	return
end

return var_0_1
