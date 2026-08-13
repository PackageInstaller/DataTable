class = var_0_10000

local var_0_0 = "WorldMediaCollectionRecordDetailLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WorldMediaCollectionSubLayer"))

var_0_1.TypeStory = 1
var_0_1.TypeBattle = 2

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionMemoryDetailUI"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	assert = var_1

	var_1(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)

	setActive = var_1

	local var_2_0 = arg_2_0._tf

	var_1(var_2.Find(var_2_0, "ItemRect/TitleRecord"), true)

	setActive = var_1

	local var_2_1 = arg_2_0._tf

	var_1(var_2.Find(var_2_1, "ItemRect/TitleMemory"), false)

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "ItemRect")

	arg_2_0.recordItemList = var_1.GetComponent(var_2_3, "LScrollRect")

	function arg_2_0.recordItemList.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitRecordItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.recordItemList.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateRecordItem(var_4_0, arg_4_0 + 1, arg_4_1)

		return
	end

	arg_2_0.recordItems = {}
	tf = var_1

	local var_2_4 = var_1(arg_2_0.recordItemList)
	local var_2_5 = var_1.Find(var_2_4, "Item")

	setActive = var_2_4

	var_2_4(var_2_5, false)

	AutoLoader = var_2_4
	arg_2_0.loader = var_2_4.New()
	setText = var_2

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_3.Find(var_2_6, "ItemRect/ProgressDesc")

	i18n = var_2_6

	var_2(var_2_7, var_2_6("world_collection_2"))

	return
end

function var_0_1.OnInitRecordItem(arg_5_0, arg_5_1)
	if arg_5_0.exited then
		return
	end

	onButton = var_2

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_1

	local function var_5_2()
		local var_6_0 = arg_5_0.recordItems[arg_5_1]

		nowWorld = var_1

		local var_6_1 = var_1()
		local var_6_2 = var_1.GetCollectionProxy(var_6_1)

		if var_6_0 and arg_5_0.CheckRecordIsUnlock(var_6_0) then
			local var_6_3 = arg_5_0

			var_2.PlayMemory(var_6_3, var_6_0)
		end

		return
	end

	SOUND_BACK = var_1_10006

	var_2(var_5_0, var_5_1, var_5_2, var_1_10006)

	return
end

function var_0_1.OnUpdateRecordItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.exited then
		return
	end

	local var_7_0

	if arg_7_0.records then
		var_7_0 = arg_7_0.records[arg_7_1]
	end

	assert = var_1_10004

	local var_7_1 = "Not Initialize RecordGroups ID: "
	local var_7_2

	if not arg_7_0.contextData.recordGroup then
		var_7_2 = "NIL"
	end

	var_1_10004(var_7_1 .. var_7_2)

	local var_7_3 = arg_7_0.recordItems

	var_7_3[arg_7_2] = var_7_0
	tf = var_7_3

	local var_7_4 = var_7_3(arg_7_2)
	local var_7_6

	if arg_7_0.CheckRecordIsUnlock(var_7_0) then
		setActive = var_7_6

		var_7_6(var_7_4:Find("normal"), true)

		setActive = var_7_6

		var_7_6(var_7_4:Find("lock"), false)

		local var_7_5 = var_7_4:Find("normal/title")

		var_7_6 = var_7_6.GetComponent
		typeof = var_7
		Text = var_8
		var_7_6 = var_7_6(var_7_5, var_7(var_8))
		var_7_6.text = var_7_0.name

		local var_7_7 = arg_7_0.loader

		var_7.GetSpriteQuiet(var_7_7, "memoryicon/" .. var_7_0.icon, "", var_7_4:Find("normal"))

		setText = var_7
		var_1_10009 = var_7_4

		local var_7_8 = var_7_4.Find(var_1_10009, "normal/id")

		string = var_1_10009

		var_7(var_7_8, var_1_10009.format("#%u", var_7_0.group_ID))
	else
		setActive = var_7_6

		var_7_6(var_7_4:Find("normal"), false)

		setActive = var_7_6

		var_7_6(var_7_4:Find("lock"), true)

		setText = var_7_6

		var_7_6(var_7_4:Find("lock/condition"), var_7_0.condition)
	end

	onButton = var_7_6

	local var_7_9 = arg_7_0
	local var_7_10 = var_7_4

	local function var_7_11()
		if not arg_7_0.CheckRecordIsUnlock(var_7_0) then
			return
		end

		local var_8_0 = arg_7_0

		var_0.PlayMemory(var_8_0, var_7_0)

		return
	end

	SFX_PANEL = var_1_10009

	var_7_6(var_7_9, var_7_10, var_7_11, var_1_10009)

	return
end

function var_0_1.SetStoryMask(arg_9_0, arg_9_1)
	arg_9_0.memoryMask = arg_9_1

	return
end

function var_0_1.PlayMemory(arg_10_0, arg_10_1)
	local var_10_1

	if arg_10_1.type == var_0_1.TypeBattle then
		pg = var_10_1

		local var_10_0 = var_10_1.NewStoryMgr.GetInstance()

		var_10_1 = var_10_1.StoryName2StoryId(var_10_0, arg_10_1.story)

		local var_10_2 = arg_10_0
		local var_10_3 = arg_10_0.emit

		WorldMediaCollectionMediator = var_1_10005

		local var_10_4 = var_1_10005.BEGIN_STAGE

		var_1_10006 = {
			memory = true
		}
		SYSTEM_PERFORM = var_1_10007
		var_1_10006.system = var_1_10007
		var_1_10006.stageId = var_10_1

		var_10_3(var_10_2, var_10_4, var_1_10006)
	else
		findTF = var_10_1

		local var_10_5 = var_10_1(arg_10_0.memoryMask, "pic")

		string = var_3

		local var_10_7

		if var_3.len(arg_10_1.mask) > 0 then
			setActive = var_10_7

			var_10_7(var_10_5, true)

			local var_10_6 = var_10_5

			var_10_7 = var_10_5.GetComponent
			typeof = var_5
			Image = var_1_10006
			var_10_7 = var_10_7(var_10_6, var_5(var_1_10006))
			LoadSprite = var_10_6
			var_10_7.sprite = var_10_6(arg_10_1.mask)
		else
			setActive = var_10_7

			var_10_7(var_10_5, false)
		end

		setActive = var_10_7

		var_10_7(arg_10_0.memoryMask, true)

		pg = var_10_7

		local var_10_8 = var_10_7.NewStoryMgr.GetInstance()

		var_3.Play(var_10_8, arg_10_1.story, function()
			setActive = var_2_10000

			var_2_10000(arg_10_0.memoryMask, false)

			return
		end, true)
	end

	return
end

function var_0_1.ShowRecordGroup(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.contextData

	var_12_0.recordGroup = arg_12_1
	WorldCollectionProxy = var_12_0

	local var_12_1 = var_12_0.GetCollectionRecordGroupTemplate(arg_12_1)

	assert = var_3

	var_3("Missing Record Group Config ID: " .. (arg_12_1 or "NIL"))

	_ = var_3
	arg_12_0.records = var_3.map(var_12_1.child, function(arg_13_0)
		WorldCollectionProxy = var_2_10001

		return var_2_10001.GetCollectionTemplate(arg_13_0)
	end)

	local var_12_2 = arg_12_0.recordItemList

	var_3.SetTotalCount(var_12_2, #arg_12_0.records, 0)

	local var_12_3 = #arg_12_0.records

	_ = var_12_2

	local var_12_4 = var_12_2.reduce(arg_12_0.records, 0, function(arg_14_0, arg_14_1)
		if arg_12_0.CheckRecordIsUnlock(arg_14_1) then
			arg_14_0 = arg_14_0 + 1
		end

		return arg_14_0
	end)

	setText = var_5

	local var_12_5 = arg_12_0._tf

	var_5(var_6.Find(var_12_5, "ItemRect/ProgressText"), var_12_4 .. "/" .. var_12_3)

	return
end

function var_0_1.CheckRecordIsUnlock(arg_15_0)
	nowWorld = var_1_10001

	local var_15_0 = var_1_10001()
	local var_15_1 = var_1.GetCollectionProxy(var_15_0)
	local var_15_3

	if not var_1.IsUnlock(var_15_1, arg_15_0.id) then
		pg = var_15_3

		local var_15_2 = var_15_3.NewStoryMgr.GetInstance()

		var_15_3 = var_15_3.IsPlayed(var_15_2, arg_15_0.story, true)
	end

	return var_15_3
end

function var_0_1.CleanList(arg_16_0)
	arg_16_0.records = nil

	local var_16_0 = arg_16_0.recordItemList

	var_1.SetTotalCount(var_16_0, 0)

	return
end

return var_0_1
