class = var_0_10000

local var_0_0 = "NewWorldMediaCollectionMemoryDetailLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WorldMediaCollectionSubLayer"))

function var_0_1.getUIName(arg_1_0)
	return "NewWorldMediaCollectionMemoryDetailUI"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	assert = var_1

	var_1(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "AD/task/ItemRect")

	arg_2_0.memoryItemList = var_1.GetComponent(var_2_1, "LScrollRect")
	arg_2_0.memoryItems = {}
	AutoLoader = var_1
	arg_2_0.loader = var_1.New()
	setText = var_1

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "AD/task/ProgressDesc")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("activity_permanent_progress"))

	return
end

function var_0_1.onInitMemoryItem(arg_3_0, arg_3_1)
	if arg_3_0.exited then
		return
	end

	return
end

function var_0_1.onUpdateMemoryItem(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	if arg_4_0.exited then
		return
	end

	local var_4_0

	if arg_4_0.memories then
		var_4_0 = arg_4_0.memories[arg_4_1]
	end

	local var_4_1 = arg_4_0.memoryItems

	var_4_1[arg_4_2] = var_4_0
	tf = var_4_1

	local var_4_2 = var_4_1(arg_4_2)
	local var_4_3 = var_4_0.task

	getProxy = var_1_10010
	TaskProxy = var_1_10011

	local var_4_4 = var_1_10010(var_1_10011)

	setText = var_1_10011

	var_1_10011(var_4_2:Find("lock_bg/lockname"), var_4_0.condition)

	setText = var_1_10011

	var_1_10011(var_4_2:Find("on/taskname"), var_4_0.title)

	setText = var_1_10011

	local var_4_5 = var_4_2
	local var_4_6 = var_4_2.Find(var_4_5, "on/num")

	string = var_4_5

	var_1_10011(var_4_6, var_4_5.format("%02d", arg_4_1))

	setText = var_1_10011

	local var_4_7 = var_4_2
	local var_4_8 = var_4_2.Find(var_4_7, "deblocking/Text")

	i18n = var_4_7

	var_1_10011(var_4_8, var_4_7("memory_unlock"))

	setText = var_1_10011

	local var_4_9 = var_4_2
	local var_4_10 = var_4_2.Find(var_4_9, "lock_bg/go/name")

	i18n = var_4_9

	var_1_10011(var_4_10, var_4_9("memory_goto"))

	if arg_4_1 == 1 and not arg_4_3 and arg_4_5 < arg_4_1 and arg_4_0.groupInfo.id ~= 501 then
		setActive = var_1_10011

		var_1_10011(var_4_2:Find("deblocking"), true)

		setActive = var_1_10011

		var_1_10011(var_4_2:Find("lock_bg"), true)

		setActive = var_1_10011

		var_1_10011(var_4_2:Find("lock_bg/lock"), false)

		setActive = var_1_10011

		var_1_10011(var_4_2:Find("on"), false)
	else
		setActive = var_1_10011

		var_1_10011(var_4_2:Find("deblocking"), false)

		setActive = var_1_10011

		var_1_10011(var_4_2:Find("lock_bg"), arg_4_5 < arg_4_1)

		setActive = var_1_10011

		var_1_10011(var_4_2:Find("lock_bg/go"), not arg_4_3 and arg_4_1 == arg_4_5 + 1)

		setActive = var_1_10011

		var_1_10011(var_4_2:Find("lock_bg/lock"), arg_4_3 or arg_4_1 > arg_4_5 + 1)

		setActive = var_1_10011

		var_1_10011(var_4_2:Find("on"), arg_4_1 <= arg_4_5)
	end

	onButton = var_1_10011

	local var_4_11 = arg_4_0
	local var_4_12 = var_4_2:Find("lock_bg/go")

	local function var_4_13()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit

		WorldMediaCollectionMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.GO_TASK)

		return
	end

	SOUND_BACK = var_15

	var_1_10011(var_4_11, var_4_12, var_4_13, var_15)

	onButton = var_1_10011

	local var_4_14 = arg_4_0
	local var_4_15 = var_4_2:Find("deblocking")

	local function var_4_16()
		if arg_4_0.isFoldState then
			return
		end

		local var_6_0 = arg_4_0
		local var_6_1 = var_0.emit

		WorldMediaCollectionMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.TRIGGER_PERSONAL_TASK, arg_4_4, function()
			local var_7_0 = arg_4_0

			var_0.ShowSubMemories(var_7_0, arg_4_0.groupInfo, arg_4_0.memoryID)

			return
		end)

		return
	end

	SOUND_BACK = var_15

	var_1_10011(var_4_14, var_4_15, var_4_16, var_15)

	onButton = var_1_10011

	local var_4_17 = arg_4_0
	local var_4_18 = var_4_2:Find("on/play")

	local function var_4_19()
		if var_4_0 then
			if var_4_0.is_open ~= 1 then
				pg = var_0

				local var_8_0 = var_0.NewStoryMgr.GetInstance()

				if var_0.IsPlayed(var_8_0, var_4_0.unlock_pre, true) then
					local var_8_1 = arg_4_0

					var_0.PlayMemory(var_8_1, var_4_0)
				end

				return
			end
		end
	end

	SOUND_BACK = var_15

	var_1_10011(var_4_17, var_4_18, var_4_19, var_15)

	return
end

function var_0_1.SetStoryMask(arg_9_0, arg_9_1)
	arg_9_0.memoryMask = arg_9_1

	return
end

function var_0_1.PlayMemory(arg_10_0, arg_10_1)
	if arg_10_1.type == 1 then
		findTF = var_2

		local var_10_0 = var_2(arg_10_0.memoryMask, "pic")

		string = var_3

		local var_10_2

		if var_3.len(arg_10_1.mask) > 0 then
			setActive = var_10_2

			var_10_2(var_10_0, true)

			local var_10_1 = var_10_0

			var_10_2 = var_10_0.GetComponent
			typeof = var_5
			Image = var_1_10006
			var_10_2 = var_10_2(var_10_1, var_5(var_1_10006))
			LoadSprite = var_10_1
			var_10_2.sprite = var_10_1(arg_10_1.mask)
		else
			setActive = var_10_2

			var_10_2(var_10_0, false)
		end

		setActive = var_10_2

		var_10_2(arg_10_0.memoryMask, true)

		pg = var_10_2

		local var_10_3 = var_10_2.NewStoryMgr.GetInstance()

		var_3.ReViewPlay(var_10_3, arg_10_1.story, function()
			setActive = var_2_10000

			var_2_10000(arg_10_0.memoryMask, false)

			return
		end, true)
	elseif arg_10_1.type == 2 then
		pg = var_2

		local var_10_4 = var_2.NewStoryMgr.GetInstance()
		local var_10_5 = var_2.StoryName2StoryId(var_10_4, arg_10_1.story)

		assert = var_10_4

		local var_10_6 = var_10_5 and var_10_5 ~= 0
		local var_10_7 = "Missing Story Stage ID: "
		local var_10_8

		if not arg_10_1.story then
			var_10_8 = "NIL"
		end

		var_10_4(var_10_6, var_10_7 .. var_10_8)

		local var_10_9 = arg_10_0
		local var_10_10 = arg_10_0.emit

		WorldMediaCollectionMediator = var_5

		local var_10_11 = var_5.BEGIN_STAGE
		local var_10_12 = {
			memory = true
		}

		SYSTEM_PERFORM = var_1_10007
		var_10_12.system = var_1_10007
		var_10_12.stageId = var_10_5

		var_10_10(var_10_9, var_10_11, var_10_12)
	end

	return
end

function var_0_1.ShowSubMemories(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.groupInfo = arg_12_1
	arg_12_0.memoryID = arg_12_2

	local var_12_0 = arg_12_0.contextData

	var_12_0.memoryGroup = arg_12_1.id
	_ = var_12_0
	arg_12_0.memories = var_12_0.map(arg_12_1.memories, function(arg_13_0)
		pg = var_2_10001

		return var_2_10001.memory_template[arg_13_0]
	end)
	getProxy = var_3
	CollectionProxy = var_4

	local var_12_1 = var_3(var_4)
	local var_12_2 = arg_12_1.ship_group

	ShipGroup = var_5

	local var_12_3 = var_5.getDefaultShipConfig(var_12_2)
	local var_12_4 = var_12_1 and var_12_1.shipGroups[var_12_2] == nil

	setText = var_1_10007

	local var_12_5 = arg_12_0._tf

	var_1_10007(var_8.Find(var_12_5, "AD/icon_bg/painting/name_bg/name"), var_12_3.name)

	SetActive = var_1_10007

	local var_12_6 = arg_12_0._tf

	var_1_10007(var_8.Find(var_12_6, "AD/icon_bg/painting/name_bg/off"), var_12_4)

	local var_12_7 = arg_12_0._tf
	local var_12_8 = var_7.Find(var_12_7, "AD/icon_bg/painting")

	pg = var_12_7

	local var_12_9 = var_12_7.ship_skin_template[var_12_3.skin_id].painting

	setPaintingPrefabAsync = var_9

	var_9(var_12_8, var_12_9, "duihua", function(arg_14_0)
		arg_12_0.rtPaint = arg_14_0

		return
	end)

	local var_12_10 = 0

	_ = var_10
	arg_12_0.memoryIds = var_10.map(arg_12_1.memories, function(arg_15_0)
		pg = var_2_10001

		if not (var_2_10001.memory_template[arg_15_0].number and var_1 > 0) then
			var_12_10 = var_12_10 + 1
		end

		return var_2 and var_1 or var_12_10
	end)

	local var_12_11 = 0
	local var_12_13

	if arg_12_2 then
		local var_12_12 = 0

		for iter_12_0 = 1, #arg_12_0.memories do
			if arg_12_0.memories[iter_12_0].id == arg_12_2 then
				var_12_12 = iter_12_0

				break
			end
		end

		if 0 < var_12_12 then
			var_12_13 = arg_12_0.memoryItemList

			local var_12_14 = arg_12_0.memoryItemsGrid.cellSize.y + arg_12_0.memoryItemsGrid.spacing.y
			local var_12_15 = arg_12_0.memoryItemsGrid.constraintCount

			math = iter_12_0

			local var_12_16 = var_12_14 * iter_12_0.ceil(#arg_12_0.memories / var_12_15)

			math = var_16
			var_12_11 = (var_12_14 * var_16.floor((var_12_12 - 1) / var_12_15) + var_12_13.paddingFront) / (var_12_16 - arg_12_0.memoryItemViewport.rect.height)
			Mathf = var_16
			var_12_11 = var_16.Clamp01(var_12_11)
		end
	end

	local var_12_17 = #arg_12_0.memories

	_ = var_12_13

	local var_12_18 = var_12_13.reduce(arg_12_0.memories, 0, function(arg_16_0, arg_16_1)
		if arg_16_1.is_open ~= 1 then
			pg = var_2

			local var_16_0 = var_2.NewStoryMgr.GetInstance()

			if var_2.IsPlayed(var_16_0, arg_16_1.story, true) then
				arg_16_0 = arg_16_0 + 1
			end

			return arg_16_0
		end
	end)

	setText = var_13

	local var_12_19 = arg_12_0._tf

	var_13(var_14.Find(var_12_19, "AD/task/ProgressText"), var_12_18 .. "/" .. var_12_17)

	setText = var_13

	local var_12_20 = arg_12_0._tf

	var_13(var_14.Find(var_12_20, "AD/task/headline_bg/headline_name"), arg_12_1.title)

	function arg_12_0.memoryItemList.onUpdateItem(arg_17_0, arg_17_1)
		local var_17_0 = arg_12_0

		var_2.onUpdateMemoryItem(var_17_0, arg_17_0 + 1, arg_17_1, var_12_4, var_12_2, var_12_18, var_12_17)

		return
	end

	local var_12_21 = arg_12_0.memoryItemList

	var_13.SetTotalCount(var_12_21, #arg_12_0.memories, var_12_11)

	return
end

function var_0_1.CleanList(arg_18_0)
	arg_18_0.memories = nil

	local var_18_0 = arg_18_0.memoryItemList

	var_1.SetTotalCount(var_18_0, 0)

	return
end

function var_0_1.UpdateView(arg_19_0)
	return
end

return var_0_1
