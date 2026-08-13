class = var_0_10000

local var_0_0 = "WorldMediaCollectionMemoryDetailLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WorldMediaCollectionSubLayer"))

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionMemoryDetailUI"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	assert = var_1

	var_1(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)

	setActive = var_1

	local var_2_0 = arg_2_0._tf

	var_1(var_2.Find(var_2_0, "ItemRect/TitleRecord"), false)

	setActive = var_1

	local var_2_1 = arg_2_0._tf

	var_1(var_2.Find(var_2_1, "ItemRect/TitleMemory"), true)

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "ItemRect")

	arg_2_0.memoryItemList = var_1.GetComponent(var_2_3, "LScrollRect")

	function arg_2_0.memoryItemList.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.onInitMemoryItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.memoryItemList.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.onUpdateMemoryItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	arg_2_0.memoryItems = {}
	tf = var_1

	local var_2_4 = var_1(arg_2_0.memoryItemList)
	local var_2_5 = var_1.Find(var_2_4, "Item")

	setActive = var_2_4

	var_2_4(var_2_5, false)

	AutoLoader = var_2_4
	arg_2_0.loader = var_2_4.New()
	tf = var_2

	local var_2_6 = var_2(arg_2_0.memoryItemList)

	arg_2_0.memoryItemViewport = var_2.Find(var_2_6, "Viewport")
	tf = var_2

	local var_2_7 = var_2(arg_2_0.memoryItemList)
	local var_2_8 = var_2.Find(var_2_7, "Viewport/Content")
	local var_2_9 = var_2.GetComponent

	typeof = var_4
	GridLayoutGroup = var_1_10005
	arg_2_0.memoryItemsGrid = var_2_9(var_2_8, var_4(var_1_10005))
	setText = var_2

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "ItemRect/ProgressDesc")

	i18n = var_2_10

	var_2(var_2_11, var_2_10("world_collection_2"))

	local var_2_12 = arg_2_0._tf

	arg_2_0.rectAnchorX = var_2.Find(var_2_12, "ItemRect").anchoredPosition.x

	arg_2_0:UpdateView()

	return
end

function var_0_1.onInitMemoryItem(arg_5_0, arg_5_1)
	if arg_5_0.exited then
		return
	end

	onButton = var_2

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_1

	local function var_5_2()
		if arg_5_0.memoryItems[arg_5_1] then
			if var_0.is_open ~= 1 then
				pg = var_1

				local var_6_0 = var_1.NewStoryMgr.GetInstance()

				if var_1.IsPlayed(var_6_0, var_0.unlock_pre, true) then
					local var_6_1 = arg_5_0

					var_1.PlayMemory(var_6_1, var_0)
				end

				return
			end
		end
	end

	SOUND_BACK = var_1_10006

	var_2(var_5_0, var_5_1, var_5_2, var_1_10006)

	return
end

function var_0_1.onUpdateMemoryItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.exited then
		return
	end

	local var_7_0

	if arg_7_0.memories then
		var_7_0 = arg_7_0.memories[arg_7_1 + 1]
	end

	local var_7_1 = arg_7_0.memoryItems

	var_7_1[arg_7_2] = var_7_0
	tf = var_7_1

	local var_7_2 = var_7_1(arg_7_2)

	if var_7_0.is_open ~= 1 then
		pg = var_7_5

		local var_7_3 = var_7_5.NewStoryMgr.GetInstance()
		local var_7_5

		if var_7_5.IsPlayed(var_7_3, var_7_0.unlock_pre, true) then
			setActive = var_7_5

			var_7_5(var_7_2:Find("normal"), true)

			setActive = var_7_5

			var_7_5(var_7_2:Find("lock"), false)

			local var_7_4 = var_7_2:Find("normal/title")

			var_7_5 = var_7_5.GetComponent
			typeof = var_7
			Text = var_8
			var_7_5 = var_7_5(var_7_4, var_7(var_8))
			var_7_5.text = var_7_0.title

			local var_7_6 = arg_7_0.loader

			var_7.GetSpriteQuiet(var_7_6, "memoryicon/" .. var_7_0.icon, "", var_7_2:Find("normal"))

			setText = var_7

			var_7(var_7_2:Find("normal/id"), "#" .. arg_7_0.memoryIds[arg_7_1 + 1])
		else
			setActive = var_7_5

			var_7_5(var_7_2:Find("normal"), false)

			setActive = var_7_5

			var_7_5(var_7_2:Find("lock"), true)

			setText = var_7_5

			var_7_5(var_7_2:Find("lock/condition"), var_7_0.condition)
		end

		return
	end
end

function var_0_1.SetStoryMask(arg_8_0, arg_8_1)
	arg_8_0.memoryMask = arg_8_1

	return
end

function var_0_1.PlayMemory(arg_9_0, arg_9_1)
	if arg_9_1.type == 1 then
		findTF = var_2

		local var_9_0 = var_2(arg_9_0.memoryMask, "pic")

		string = var_3

		local var_9_2

		if var_3.len(arg_9_1.mask) > 0 then
			setActive = var_9_2

			var_9_2(var_9_0, true)

			local var_9_1 = var_9_0

			var_9_2 = var_9_0.GetComponent
			typeof = var_5
			Image = var_1_10006
			var_9_2 = var_9_2(var_9_1, var_5(var_1_10006))
			LoadSprite = var_9_1
			var_9_2.sprite = var_9_1(arg_9_1.mask)
		else
			setActive = var_9_2

			var_9_2(var_9_0, false)
		end

		setActive = var_9_2

		var_9_2(arg_9_0.memoryMask, true)

		pg = var_9_2

		local var_9_3 = var_9_2.NewStoryMgr.GetInstance()

		var_3.ReViewPlay(var_9_3, arg_9_1.story, function()
			setActive = var_2_10000

			var_2_10000(arg_9_0.memoryMask, false)

			return
		end, true)
	elseif arg_9_1.type == 2 then
		pg = var_2

		local var_9_4 = var_2.NewStoryMgr.GetInstance()
		local var_9_5 = var_2.StoryName2StoryId(var_9_4, arg_9_1.story)

		assert = var_9_4

		local var_9_6 = var_9_5 and var_9_5 ~= 0
		local var_9_7 = "Missing Story Stage ID: "
		local var_9_8

		if not arg_9_1.story then
			var_9_8 = "NIL"
		end

		var_9_4(var_9_6, var_9_7 .. var_9_8)

		local var_9_9 = arg_9_0
		local var_9_10 = arg_9_0.emit

		WorldMediaCollectionMediator = var_5

		local var_9_11 = var_5.BEGIN_STAGE
		local var_9_12 = {
			memory = true
		}

		SYSTEM_PERFORM = var_1_10007
		var_9_12.system = var_1_10007
		var_9_12.stageId = var_9_5

		var_9_10(var_9_9, var_9_11, var_9_12)
	end

	return
end

function var_0_1.ShowSubMemories(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.contextData

	var_11_0.memoryGroup = arg_11_1.id
	_ = var_11_0
	arg_11_0.memories = var_11_0.map(arg_11_1.memories, function(arg_12_0)
		pg = var_2_10001

		return var_2_10001.memory_template[arg_12_0]
	end)

	local var_11_1 = 0

	_ = var_4
	arg_11_0.memoryIds = var_4.map(arg_11_1.memories, function(arg_13_0)
		pg = var_2_10001

		if not (var_2_10001.memory_template[arg_13_0].number and var_1 > 0) then
			var_11_1 = var_11_1 + 1
		end

		return var_2 and var_1 or var_11_1
	end)

	local var_11_2 = 0

	if arg_11_2 then
		local var_11_3 = 0

		for iter_11_0 = 1, #arg_11_0.memories do
			if arg_11_0.memories[iter_11_0].id == arg_11_2 then
				var_11_3 = iter_11_0

				break
			end
		end

		if var_11_3 > 0 then
			local var_11_4 = arg_11_0.memoryItemList
			local var_11_5 = arg_11_0.memoryItemsGrid.cellSize.y + arg_11_0.memoryItemsGrid.spacing.y
			local var_11_6 = arg_11_0.memoryItemsGrid.constraintCount

			math = iter_11_0

			local var_11_7 = var_11_5 * iter_11_0.ceil(#arg_11_0.memories / var_11_6)

			math = var_10
			var_11_2 = (var_11_5 * var_10.floor((var_11_3 - 1) / var_11_6) + var_11_4.paddingFront) / (var_11_7 - arg_11_0.memoryItemViewport.rect.height)
			Mathf = var_10
			var_11_2 = var_10.Clamp01(var_11_2)
		end
	end

	local var_11_8 = arg_11_0.memoryItemList

	var_5.SetTotalCount(var_11_8, #arg_11_0.memories, var_11_2)

	local var_11_9 = #arg_11_0.memories

	_ = var_11_8

	local var_11_10 = var_11_8.reduce(arg_11_0.memories, 0, function(arg_14_0, arg_14_1)
		if arg_14_1.is_open ~= 1 then
			pg = var_2

			local var_14_0 = var_2.NewStoryMgr.GetInstance()

			if var_2.IsPlayed(var_14_0, arg_14_1.unlock_pre, true) then
				arg_14_0 = arg_14_0 + 1
			end

			return arg_14_0
		end
	end)

	setText = var_7

	local var_11_11 = arg_11_0._tf

	var_7(var_8.Find(var_11_11, "ItemRect/ProgressText"), var_11_10 .. "/" .. var_11_9)

	_ = var_7

	local var_11_12 = var_7.filter

	pg = var_8

	local var_11_13 = var_11_12(var_8.re_map_template.all, function(arg_15_0)
		pg = var_2_10001

		return var_2_10001.re_map_template[arg_15_0].memory_group == arg_11_1.id
	end)

	if var_11_10 < var_11_9 then
		local var_11_14 = #var_11_13
		local var_11_15

		if not (0 < var_11_14) then
			var_11_15 = false
		else
			var_11_15 = true
		end

		setActive = var_9

		local var_11_16 = arg_11_0._tf

		var_9(var_10.Find(var_11_16, "ItemRect/UnlockTip"), var_11_15)

		if var_11_15 then
			_ = var_9

			local var_11_17 = var_9.map

			_ = var_10

			local var_11_18 = var_10.sort

			Map = var_11

			local var_11_19 = var_11_17(var_11_18(var_11.GetRearChaptersOfRemaster(var_11_13[1])), function(arg_16_0)
				getProxy = var_2_10001
				ChapterProxy = var_2_10002

				local var_16_0 = var_2_10001(var_2_10002)
				local var_16_1 = var_1.getChapterById(var_16_0, arg_16_0, true)

				return var_1.getConfig(var_16_1, "chapter_name")
			end)

			setText = var_10

			local var_11_20 = arg_11_0._tf
			local var_11_21 = var_11.Find(var_11_20, "ItemRect/UnlockTip")

			i18n = var_11_20

			local var_11_22 = "levelScene_remaster_unlock_tip"
			local var_11_23 = arg_11_1.title

			table = var_1_10015

			var_10(var_11_21, var_11_20(var_11_22, var_11_23, var_1_10015.concat(var_11_19, "/")))
		end

		return
	end
end

function var_0_1.CleanList(arg_17_0)
	arg_17_0.memories = nil

	local var_17_0 = arg_17_0.memoryItemList

	var_1.SetTotalCount(var_17_0, 0)

	return
end

function var_0_1.UpdateView(arg_18_0)
	WorldMediaCollectionScene = var_1_10001

	local var_18_0 = var_1_10001.WorldRecordLock()

	setAnchoredPosition = var_1_10002

	local var_18_1 = arg_18_0._tf

	var_1_10002(var_3.Find(var_18_1, "ItemRect"), {
		x = var_18_0 and 0 or arg_18_0.rectAnchorX
	})

	return
end

return var_0_1
