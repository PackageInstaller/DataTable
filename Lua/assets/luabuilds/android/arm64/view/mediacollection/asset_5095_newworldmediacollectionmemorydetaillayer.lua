local NewWorldMediaCollectionMemoryDetailLayer = class("NewWorldMediaCollectionMemoryDetailLayer", import(".WorldMediaCollectionSubLayer"))

function NewWorldMediaCollectionMemoryDetailLayer:getUIName()
	return "NewWorldMediaCollectionMemoryDetailUI"
end

function NewWorldMediaCollectionMemoryDetailLayer:OnInit()
	NewWorldMediaCollectionMemoryDetailLayer.super.OnInit(self)
	assert(self.viewParent, "Need assign ViewParent for " .. self.__cname)

	self.memoryItemList = self._tf:Find("AD/task/ItemRect"):GetComponent("LScrollRect")
	self.memoryItems = {}
	self.loader = AutoLoader.New()

	setText(self._tf:Find("AD/task/ProgressDesc"), i18n("activity_permanent_progress"))

	return
end

function NewWorldMediaCollectionMemoryDetailLayer:onInitMemoryItem(arg_3_1)
	if self.exited then
		return
	end

	return
end

function NewWorldMediaCollectionMemoryDetailLayer:onUpdateMemoryItem(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	if self.exited then
		return
	end

	local var_4_0 = self.memories

	if self.memories then
		var_4_0 = self.memories[arg_4_1]
	end

	self.memoryItems[arg_4_2] = var_4_0

	local var_4_1 = tf(arg_4_2)
	local var_4_3 = getProxy(TaskProxy)

	setText(var_4_1:Find("lock_bg/lockname"), var_4_0.condition)
	setText(var_4_1:Find("on/taskname"), var_4_0.title)
	setText(var_4_1:Find("on/num"), string.format("%02d", arg_4_1))
	setText(var_4_1:Find("deblocking/Text"), i18n("memory_unlock"))
	setText(var_4_1:Find("lock_bg/go/name"), i18n("memory_goto"))

	if arg_4_1 == 1 and not arg_4_3 and arg_4_5 < arg_4_1 and self.groupInfo.id ~= 501 then
		setActive(var_4_1:Find("deblocking"), true)
		setActive(var_4_1:Find("lock_bg"), true)
		setActive(var_4_1:Find("lock_bg/lock"), false)
		setActive(var_4_1:Find("on"), false)
	else
		setActive(var_4_1:Find("deblocking"), false)
		setActive(var_4_1:Find("lock_bg"), arg_4_5 < arg_4_1)
		setActive(var_4_1:Find("lock_bg/go"), not arg_4_3 and arg_4_1 == arg_4_5 + 1)
		setActive(var_4_1:Find("lock_bg/lock"), arg_4_3 or arg_4_1 > arg_4_5 + 1)
		setActive(var_4_1:Find("on"), arg_4_1 <= arg_4_5)
	end

	onButton(self, var_4_1:Find("lock_bg/go"), function()
		self:emit(WorldMediaCollectionMediator.GO_TASK)

		return
	end, SOUND_BACK)
	onButton(self, var_4_1:Find("deblocking"), function()
		if self.isFoldState then
			return
		end

		self:emit(WorldMediaCollectionMediator.TRIGGER_PERSONAL_TASK, arg_4_4, function()
			self:ShowSubMemories(self.groupInfo, self.memoryID)

			return
		end)

		return
	end, SOUND_BACK)
	onButton(self, var_4_1:Find("on/play"), function()
		if var_4_0 then
			if var_4_0.is_open ~= 1 then
				if pg.NewStoryMgr.GetInstance():IsPlayed(var_4_0.unlock_pre, true) then
					self:PlayMemory(var_4_0)
				end
			end
		end

		return
	end, SOUND_BACK)

	return
end

function NewWorldMediaCollectionMemoryDetailLayer:SetStoryMask(arg_9_1)
	self.memoryMask = arg_9_1

	return
end

function NewWorldMediaCollectionMemoryDetailLayer:PlayMemory(arg_10_1)
	if arg_10_1.type == 1 then
		local var_10_0 = findTF(self.memoryMask, "pic")

		if string.len(arg_10_1.mask) > 0 then
			setActive(var_10_0, true)

			var_10_0:GetComponent(typeof(Image)).sprite = LoadSprite(arg_10_1.mask)
		else
			setActive(var_10_0, false)
		end

		setActive(self.memoryMask, true)
		pg.NewStoryMgr.GetInstance():ReViewPlay(arg_10_1.story, function()
			setActive(self.memoryMask, false)

			return
		end, true)
	elseif arg_10_1.type == 2 then
		local var_10_1 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_10_1.story)

		assert(var_10_1 and var_10_1 ~= 0, "Missing Story Stage ID: " .. (arg_10_1.story or "NIL"))
		self:emit(WorldMediaCollectionMediator.BEGIN_STAGE, {
			memory = true,
			system = SYSTEM_PERFORM,
			stageId = var_10_1
		})
	end

	return
end

function NewWorldMediaCollectionMemoryDetailLayer:ShowSubMemories(arg_12_1, arg_12_2)
	self.groupInfo = arg_12_1
	self.memoryID = arg_12_2
	self.contextData.memoryGroup = arg_12_1.id
	self.memories = _.map(arg_12_1.memories, function(arg_13_0)
		return pg.memory_template[arg_13_0]
	end)

	local var_12_0 = getProxy(CollectionProxy)
	local var_12_1 = arg_12_1.ship_group
	local var_12_2 = ShipGroup.getDefaultShipConfig(arg_12_1.ship_group)
	local var_12_3 = var_12_0 and var_12_0.shipGroups[arg_12_1.ship_group] == nil

	setText(self._tf:Find("AD/icon_bg/painting/name_bg/name"), var_12_2.name)
	SetActive(self._tf:Find("AD/icon_bg/painting/name_bg/off"), var_12_3)
	setPaintingPrefabAsync(self._tf:Find("AD/icon_bg/painting"), pg.ship_skin_template[var_12_2.skin_id].painting, "duihua", function(arg_14_0)
		self.rtPaint = arg_14_0

		return
	end)

	local var_12_4 = 0

	self.memoryIds = _.map(arg_12_1.memories, function(arg_15_0)
		local var_15_0 = pg.memory_template[arg_15_0].number

		if not (pg.memory_template[arg_15_0].number and var_15_0 > 0) then
			var_12_4 = var_12_4 + 1
		end

		return pg.memory_template[arg_15_0].number and var_15_0 > 0 and var_15_0 or var_12_4
	end)

	local var_12_5 = 0

	if arg_12_2 then
		local var_12_6 = 0

		for iter_12_0 = 1, #self.memories do
			if self.memories[iter_12_0].id == arg_12_2 then
				var_12_6 = iter_12_0

				break
			end
		end

		if var_12_6 > 0 then
			var_12_5 = ((self.memoryItemsGrid.cellSize.y + self.memoryItemsGrid.spacing.y) * math.floor((var_12_6 - 1) / self.memoryItemsGrid.constraintCount) + self.memoryItemList.paddingFront) / ((self.memoryItemsGrid.cellSize.y + self.memoryItemsGrid.spacing.y) * math.ceil(#self.memories / self.memoryItemsGrid.constraintCount) - self.memoryItemViewport.rect.height)
			var_12_5 = Mathf.Clamp01(var_12_5)
		end
	end

	local var_12_7 = #self.memories
	local var_12_8 = _.reduce(self.memories, 0, function(arg_16_0, arg_16_1)
		if arg_16_1.is_open ~= 1 then
			if pg.NewStoryMgr.GetInstance():IsPlayed(arg_16_1.story, true) then
				arg_16_0 = arg_16_0 + 1
			end
		end

		return arg_16_0
	end)

	setText(self._tf:Find("AD/task/ProgressText"), var_12_8 .. "/" .. #self.memories)
	setText(self._tf:Find("AD/task/headline_bg/headline_name"), arg_12_1.title)

	function self.memoryItemList.onUpdateItem(arg_17_0, arg_17_1)
		self:onUpdateMemoryItem(arg_17_0 + 1, arg_17_1, var_12_3, var_12_1, var_12_8, var_12_7)

		return
	end

	self.memoryItemList:SetTotalCount(#self.memories, var_12_5)

	return
end

function NewWorldMediaCollectionMemoryDetailLayer:CleanList()
	self.memories = nil

	self.memoryItemList:SetTotalCount(0)

	return
end

function NewWorldMediaCollectionMemoryDetailLayer:UpdateView()
	return
end

return NewWorldMediaCollectionMemoryDetailLayer
