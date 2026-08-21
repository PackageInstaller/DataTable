local var_0_0 = class("WorldMediaCollectionMemoryDetailLayer", import(".WorldMediaCollectionSubLayer"))

function var_0_0.getUIName(arg_1_0)
	return "WorldMediaCollectionMemoryDetailUI"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	assert(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)
	setActive(arg_2_0._tf:Find("ItemRect/TitleRecord"), false)
	setActive(arg_2_0._tf:Find("ItemRect/TitleMemory"), true)

	arg_2_0.memoryItemList = arg_2_0._tf:Find("ItemRect"):GetComponent("LScrollRect")

	function arg_2_0.memoryItemList.onInitItem(arg_3_0)
		arg_2_0:onInitMemoryItem(arg_3_0)

		return
	end

	function arg_2_0.memoryItemList.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:onUpdateMemoryItem(arg_4_0, arg_4_1)

		return
	end

	arg_2_0.memoryItems = {}

	setActive(tf(arg_2_0.memoryItemList):Find("Item"), false)

	arg_2_0.loader = AutoLoader.New()
	arg_2_0.memoryItemViewport = tf(arg_2_0.memoryItemList):Find("Viewport")
	arg_2_0.memoryItemsGrid = tf(arg_2_0.memoryItemList):Find("Viewport/Content"):GetComponent(typeof(GridLayoutGroup))

	setText(arg_2_0._tf:Find("ItemRect/ProgressDesc"), i18n("world_collection_2"))

	arg_2_0.rectAnchorX = arg_2_0._tf:Find("ItemRect").anchoredPosition.x

	arg_2_0:UpdateView()

	return
end

function var_0_0.onInitMemoryItem(arg_5_0, arg_5_1)
	if arg_5_0.exited then
		return
	end

	onButton(arg_5_0, arg_5_1, function()
		if arg_5_0.memoryItems[arg_5_1] then
			if arg_5_0.memoryItems[arg_5_1].is_open ~= 1 then
				if pg.NewStoryMgr.GetInstance():IsPlayed(arg_5_0.memoryItems[arg_5_1].unlock_pre, true) then
					arg_5_0:PlayMemory(arg_5_0.memoryItems[arg_5_1])
				end

				return
			end
		end
	end, SOUND_BACK)

	return
end

function var_0_0.onUpdateMemoryItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.exited then
		return
	end

	local var_7_0 = arg_7_0.memories and arg_7_0.memories[arg_7_1 + 1]

	arg_7_0.memoryItems[arg_7_2] = var_7_0

	local var_7_1 = tf(arg_7_2)

	if var_7_0.is_open ~= 1 then
		if pg.NewStoryMgr.GetInstance():IsPlayed(var_7_0.unlock_pre, true) then
			setActive(var_7_1:Find("normal"), true)
			setActive(var_7_1:Find("lock"), false)

			var_7_1:Find("normal/title"):GetComponent(typeof(Text)).text = var_7_0.title

			arg_7_0.loader:GetSpriteQuiet("memoryicon/" .. var_7_0.icon, "", var_7_1:Find("normal"))
			setText(var_7_1:Find("normal/id"), "#" .. arg_7_0.memoryIds[arg_7_1 + 1])
		else
			setActive(var_7_1:Find("normal"), false)
			setActive(var_7_1:Find("lock"), true)
			setText(var_7_1:Find("lock/condition"), var_7_0.condition)
		end

		return
	end
end

function var_0_0.SetStoryMask(arg_8_0, arg_8_1)
	arg_8_0.memoryMask = arg_8_1

	return
end

function var_0_0.PlayMemory(arg_9_0, arg_9_1)
	if arg_9_1.type == 1 then
		local var_9_0 = findTF(arg_9_0.memoryMask, "pic")

		if string.len(arg_9_1.mask) > 0 then
			setActive(var_9_0, true)

			var_9_0:GetComponent(typeof(Image)).sprite = LoadSprite(arg_9_1.mask)
		else
			setActive(var_9_0, false)
		end

		setActive(arg_9_0.memoryMask, true)
		pg.NewStoryMgr.GetInstance():ReViewPlay(arg_9_1.story, function()
			setActive(arg_9_0.memoryMask, false)

			return
		end, true)
	elseif arg_9_1.type == 2 then
		local var_9_1 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_9_1.story)
		local var_9_2 = var_9_1 and var_9_1 ~= 0
		local var_9_3 = "Missing Story Stage ID: "
		local var_9_4 = arg_9_1.story or "NIL"

		assert(var_9_2, var_9_3 .. var_9_4)
		arg_9_0:emit(WorldMediaCollectionMediator.BEGIN_STAGE, {
			memory = true,
			system = SYSTEM_PERFORM,
			stageId = var_9_1
		})
	end

	return
end

function var_0_0.ShowSubMemories(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.contextData.memoryGroup = arg_11_1.id
	arg_11_0.memories = _.map(arg_11_1.memories, function(arg_12_0)
		return pg.memory_template[arg_12_0]
	end)

	local var_11_0 = 0

	arg_11_0.memoryIds = _.map(arg_11_1.memories, function(arg_13_0)
		local var_13_0 = pg.memory_template[arg_13_0].number
		local var_13_1 = pg.memory_template[arg_13_0].number and var_13_0 > 0

		if not (pg.memory_template[arg_13_0].number and var_13_0 > 0) then
			var_11_0 = var_11_0 + 1
		end

		return var_13_1 and var_13_0 or var_11_0
	end)

	local var_11_1 = 0

	if arg_11_2 then
		local var_11_2 = 0

		for iter_11_0 = 1, #arg_11_0.memories do
			if arg_11_0.memories[iter_11_0].id == arg_11_2 then
				var_11_2 = iter_11_0

				break
			end
		end

		if var_11_2 > 0 then
			var_11_1 = ((arg_11_0.memoryItemsGrid.cellSize.y + arg_11_0.memoryItemsGrid.spacing.y) * math.floor((var_11_2 - 1) / arg_11_0.memoryItemsGrid.constraintCount) + arg_11_0.memoryItemList.paddingFront) / ((arg_11_0.memoryItemsGrid.cellSize.y + arg_11_0.memoryItemsGrid.spacing.y) * math.ceil(#arg_11_0.memories / arg_11_0.memoryItemsGrid.constraintCount) - arg_11_0.memoryItemViewport.rect.height)
			var_11_1 = Mathf.Clamp01(var_11_1)
		end
	end

	arg_11_0.memoryItemList:SetTotalCount(#arg_11_0.memories, var_11_1)

	local var_11_3 = #arg_11_0.memories
	local var_11_4 = _.reduce(arg_11_0.memories, 0, function(arg_14_0, arg_14_1)
		if arg_14_1.is_open ~= 1 then
			if pg.NewStoryMgr.GetInstance():IsPlayed(arg_14_1.unlock_pre, true) then
				arg_14_0 = arg_14_0 + 1
			end

			return arg_14_0
		end
	end)

	setText(arg_11_0._tf:Find("ItemRect/ProgressText"), var_11_4 .. "/" .. #arg_11_0.memories)

	local var_11_5 = _.filter(pg.re_map_template.all, function(arg_15_0)
		return pg.re_map_template[arg_15_0].memory_group == arg_11_1.id
	end)
	local var_11_6 = var_11_4 < var_11_3 and #var_11_5 > 0

	setActive(arg_11_0._tf:Find("ItemRect/UnlockTip"), var_11_4 < var_11_3 and #var_11_5 > 0)

	if var_11_6 then
		setText(arg_11_0._tf:Find("ItemRect/UnlockTip"), i18n("levelScene_remaster_unlock_tip", arg_11_1.title, table.concat(_.map(_.sort(Map.GetRearChaptersOfRemaster(var_11_5[1])), function(arg_16_0)
			return getProxy(ChapterProxy):getChapterById(arg_16_0, true):getConfig("chapter_name")
		end), "/")))
	end

	return
end

function var_0_0.CleanList(arg_17_0)
	arg_17_0.memories = nil

	arg_17_0.memoryItemList:SetTotalCount(0)

	return
end

function var_0_0.UpdateView(arg_18_0)
	setAnchoredPosition(arg_18_0._tf:Find("ItemRect"), {
		x = WorldMediaCollectionScene.WorldRecordLock() and 0 or arg_18_0.rectAnchorX
	})

	return
end

return var_0_0
