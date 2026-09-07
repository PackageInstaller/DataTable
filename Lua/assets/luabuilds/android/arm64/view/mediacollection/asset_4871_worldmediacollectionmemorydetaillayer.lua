local WorldMediaCollectionMemoryDetailLayer = class("WorldMediaCollectionMemoryDetailLayer", import(".WorldMediaCollectionSubLayer"))

function WorldMediaCollectionMemoryDetailLayer:getUIName()
	return "WorldMediaCollectionMemoryDetailUI"
end

function WorldMediaCollectionMemoryDetailLayer:OnInit()
	WorldMediaCollectionMemoryDetailLayer.super.OnInit(self)
	assert(self.viewParent, "Need assign ViewParent for " .. self.__cname)
	setActive(self._tf:Find("ItemRect/TitleRecord"), false)
	setActive(self._tf:Find("ItemRect/TitleMemory"), true)

	self.memoryItemList = self._tf:Find("ItemRect"):GetComponent("LScrollRect")

	function self.memoryItemList.onInitItem(arg_3_0)
		self:onInitMemoryItem(arg_3_0)

		return
	end

	function self.memoryItemList.onUpdateItem(arg_4_0, arg_4_1)
		self:onUpdateMemoryItem(arg_4_0, arg_4_1)

		return
	end

	self.memoryItems = {}

	setActive(tf(self.memoryItemList):Find("Item"), false)

	self.loader = AutoLoader.New()
	self.memoryItemViewport = tf(self.memoryItemList):Find("Viewport")
	self.memoryItemsGrid = tf(self.memoryItemList):Find("Viewport/Content"):GetComponent(typeof(GridLayoutGroup))

	setText(self._tf:Find("ItemRect/ProgressDesc"), i18n("world_collection_2"))

	self.rectAnchorX = self._tf:Find("ItemRect").anchoredPosition.x

	self:UpdateView()

	return
end

function WorldMediaCollectionMemoryDetailLayer:onInitMemoryItem(arg_5_1)
	if self.exited then
		return
	end

	onButton(self, arg_5_1, function()
		if self.memoryItems[arg_5_1] then
			if self.memoryItems[arg_5_1].is_open ~= 1 then
				if pg.NewStoryMgr.GetInstance():IsPlayed(self.memoryItems[arg_5_1].unlock_pre, true) then
					self:PlayMemory(self.memoryItems[arg_5_1])
				end
			end
		end

		return
	end, SOUND_BACK)

	return
end

function WorldMediaCollectionMemoryDetailLayer:onUpdateMemoryItem(arg_7_1, arg_7_2)
	if self.exited then
		return
	end

	local var_7_0 = self.memories and self.memories[arg_7_1 + 1]

	self.memoryItems[arg_7_2] = var_7_0

	local var_7_1 = tf(arg_7_2)

	if var_7_0.is_open ~= 1 then
		if pg.NewStoryMgr.GetInstance():IsPlayed(var_7_0.unlock_pre, true) then
			setActive(var_7_1:Find("normal"), true)
			setActive(var_7_1:Find("lock"), false)

			var_7_1:Find("normal/title"):GetComponent(typeof(Text)).text = var_7_0.title

			self.loader:GetSpriteQuiet("memoryicon/" .. var_7_0.icon, "", var_7_1:Find("normal"))
			setText(var_7_1:Find("normal/id"), "#" .. self.memoryIds[arg_7_1 + 1])

			goto label_7_0
		end
	end

	setActive(var_7_1:Find("normal"), false)
	setActive(var_7_1:Find("lock"), true)
	setText(var_7_1:Find("lock/condition"), var_7_0.condition)

	::label_7_0::

	return
end

function WorldMediaCollectionMemoryDetailLayer:SetStoryMask(arg_8_1)
	self.memoryMask = arg_8_1

	return
end

function WorldMediaCollectionMemoryDetailLayer:PlayMemory(arg_9_1)
	if arg_9_1.type == 1 then
		local var_9_0 = findTF(self.memoryMask, "pic")

		if string.len(arg_9_1.mask) > 0 then
			setActive(var_9_0, true)

			var_9_0:GetComponent(typeof(Image)).sprite = LoadSprite(arg_9_1.mask)
		else
			setActive(var_9_0, false)
		end

		setActive(self.memoryMask, true)
		pg.NewStoryMgr.GetInstance():ReViewPlay(arg_9_1.story, function()
			setActive(self.memoryMask, false)

			return
		end, true)
	elseif arg_9_1.type == 2 then
		local var_9_1 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_9_1.story)

		assert(var_9_1 and var_9_1 ~= 0, "Missing Story Stage ID: " .. (arg_9_1.story or "NIL"))
		self:emit(WorldMediaCollectionMediator.BEGIN_STAGE, {
			memory = true,
			system = SYSTEM_PERFORM,
			stageId = var_9_1
		})
	end

	return
end

function WorldMediaCollectionMemoryDetailLayer:ShowSubMemories(arg_11_1, arg_11_2)
	self.contextData.memoryGroup = arg_11_1.id
	self.memories = _.map(arg_11_1.memories, function(arg_12_0)
		return pg.memory_template[arg_12_0]
	end)

	local var_11_0 = 0

	self.memoryIds = _.map(arg_11_1.memories, function(arg_13_0)
		local var_13_0 = pg.memory_template[arg_13_0].number

		if not (pg.memory_template[arg_13_0].number and var_13_0 > 0) then
			var_11_0 = var_11_0 + 1
		end

		return pg.memory_template[arg_13_0].number and var_13_0 > 0 and var_13_0 or var_11_0
	end)

	local var_11_1 = 0

	if arg_11_2 then
		local var_11_2 = 0

		for iter_11_0 = 1, #self.memories do
			if self.memories[iter_11_0].id == arg_11_2 then
				var_11_2 = iter_11_0

				break
			end
		end

		if var_11_2 > 0 then
			var_11_1 = ((self.memoryItemsGrid.cellSize.y + self.memoryItemsGrid.spacing.y) * math.floor((var_11_2 - 1) / self.memoryItemsGrid.constraintCount) + self.memoryItemList.paddingFront) / ((self.memoryItemsGrid.cellSize.y + self.memoryItemsGrid.spacing.y) * math.ceil(#self.memories / self.memoryItemsGrid.constraintCount) - self.memoryItemViewport.rect.height)
			var_11_1 = Mathf.Clamp01(var_11_1)
		end
	end

	self.memoryItemList:SetTotalCount(#self.memories, var_11_1)

	local var_11_3 = #self.memories
	local var_11_4 = _.reduce(self.memories, 0, function(arg_14_0, arg_14_1)
		if arg_14_1.is_open ~= 1 then
			if pg.NewStoryMgr.GetInstance():IsPlayed(arg_14_1.unlock_pre, true) then
				arg_14_0 = arg_14_0 + 1
			end
		end

		return arg_14_0
	end)

	setText(self._tf:Find("ItemRect/ProgressText"), var_11_4 .. "/" .. #self.memories)

	local var_11_5 = _.filter(pg.re_map_template.all, function(arg_15_0)
		return pg.re_map_template[arg_15_0].memory_group == arg_11_1.id
	end)
	local var_11_6 = var_11_4 < var_11_3 and #var_11_5 > 0

	setActive(self._tf:Find("ItemRect/UnlockTip"), var_11_4 < var_11_3 and #var_11_5 > 0)

	if var_11_6 then
		setText(self._tf:Find("ItemRect/UnlockTip"), i18n("levelScene_remaster_unlock_tip", arg_11_1.title, table.concat(_.map(_.sort(Map.GetRearChaptersOfRemaster(var_11_5[1])), function(arg_16_0)
			return getProxy(ChapterProxy):getChapterById(arg_16_0, true):getConfig("chapter_name")
		end), "/")))
	end

	return
end

function WorldMediaCollectionMemoryDetailLayer:CleanList()
	self.memories = nil

	self.memoryItemList:SetTotalCount(0)

	return
end

function WorldMediaCollectionMemoryDetailLayer:UpdateView()
	setAnchoredPosition(self._tf:Find("ItemRect"), {
		x = WorldMediaCollectionScene.WorldRecordLock() and 0 or self.rectAnchorX
	})

	return
end

return WorldMediaCollectionMemoryDetailLayer
