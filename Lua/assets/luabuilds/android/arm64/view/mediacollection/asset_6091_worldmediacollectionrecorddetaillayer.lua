local WorldMediaCollectionRecordDetailLayer = class("WorldMediaCollectionRecordDetailLayer", import(".WorldMediaCollectionSubLayer"))

WorldMediaCollectionRecordDetailLayer.TypeStory = 1
WorldMediaCollectionRecordDetailLayer.TypeBattle = 2

function WorldMediaCollectionRecordDetailLayer:getUIName()
	return "WorldMediaCollectionMemoryDetailUI"
end

function WorldMediaCollectionRecordDetailLayer:OnInit()
	WorldMediaCollectionRecordDetailLayer.super.OnInit(self)
	assert(self.viewParent, "Need assign ViewParent for " .. self.__cname)
	setActive(self._tf:Find("ItemRect/TitleRecord"), true)
	setActive(self._tf:Find("ItemRect/TitleMemory"), false)

	self.recordItemList = self._tf:Find("ItemRect"):GetComponent("LScrollRect")

	function self.recordItemList.onInitItem(arg_3_0)
		self:OnInitRecordItem(arg_3_0)

		return
	end

	function self.recordItemList.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateRecordItem(arg_4_0 + 1, arg_4_1)

		return
	end

	self.recordItems = {}

	setActive(tf(self.recordItemList):Find("Item"), false)

	self.loader = AutoLoader.New()

	setText(self._tf:Find("ItemRect/ProgressDesc"), i18n("world_collection_2"))

	return
end

function WorldMediaCollectionRecordDetailLayer:OnInitRecordItem(arg_5_1)
	if self.exited then
		return
	end

	onButton(self, arg_5_1, function()
		local var_6_0 = nowWorld():GetCollectionProxy()

		if self.recordItems[arg_5_1] and self.CheckRecordIsUnlock(self.recordItems[arg_5_1]) then
			self:PlayMemory(self.recordItems[arg_5_1])
		end

		return
	end, SOUND_BACK)

	return
end

function WorldMediaCollectionRecordDetailLayer:OnUpdateRecordItem(arg_7_1, arg_7_2)
	if self.exited then
		return
	end

	local var_7_0 = self.records

	if self.records then
		var_7_0 = self.records[arg_7_1]
	end

	assert("Not Initialize RecordGroups ID: " .. (self.contextData.recordGroup or "NIL"))

	self.recordItems[arg_7_2] = var_7_0

	local var_7_1 = tf(arg_7_2)

	if self.CheckRecordIsUnlock(var_7_0) then
		setActive(var_7_1:Find("normal"), true)
		setActive(var_7_1:Find("lock"), false)

		var_7_1:Find("normal/title"):GetComponent(typeof(Text)).text = var_7_0.name

		self.loader:GetSpriteQuiet("memoryicon/" .. var_7_0.icon, "", var_7_1:Find("normal"))
		setText(var_7_1:Find("normal/id"), string.format("#%u", var_7_0.group_ID))
	else
		setActive(var_7_1:Find("normal"), false)
		setActive(var_7_1:Find("lock"), true)
		setText(var_7_1:Find("lock/condition"), var_7_0.condition)
	end

	onButton(self, var_7_1, function()
		if not self.CheckRecordIsUnlock(var_7_0) then
			return
		end

		self:PlayMemory(var_7_0)

		return
	end, SFX_PANEL)

	return
end

function WorldMediaCollectionRecordDetailLayer:SetStoryMask(arg_9_1)
	self.memoryMask = arg_9_1

	return
end

function WorldMediaCollectionRecordDetailLayer:PlayMemory(arg_10_1)
	if arg_10_1.type == WorldMediaCollectionRecordDetailLayer.TypeBattle then
		self:emit(WorldMediaCollectionMediator.BEGIN_STAGE, {
			memory = true,
			system = SYSTEM_PERFORM,
			stageId = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_10_1.story)
		})
	else
		local var_10_0 = findTF(self.memoryMask, "pic")

		if string.len(arg_10_1.mask) > 0 then
			setActive(var_10_0, true)

			var_10_0:GetComponent(typeof(Image)).sprite = LoadSprite(arg_10_1.mask)
		else
			setActive(var_10_0, false)
		end

		setActive(self.memoryMask, true)
		pg.NewStoryMgr.GetInstance():Play(arg_10_1.story, function()
			setActive(self.memoryMask, false)

			return
		end, true)
	end

	return
end

function WorldMediaCollectionRecordDetailLayer:ShowRecordGroup(arg_12_1)
	self.contextData.recordGroup = arg_12_1

	assert("Missing Record Group Config ID: " .. (arg_12_1 or "NIL"))

	self.records = _.map(WorldCollectionProxy.GetCollectionRecordGroupTemplate(arg_12_1).child, function(arg_13_0)
		return WorldCollectionProxy.GetCollectionTemplate(arg_13_0)
	end)

	self.recordItemList:SetTotalCount(#self.records, 0)
	setText(self._tf:Find("ItemRect/ProgressText"), _.reduce(self.records, 0, function(arg_14_0, arg_14_1)
		if self.CheckRecordIsUnlock(arg_14_1) then
			arg_14_0 = arg_14_0 + 1
		end

		return arg_14_0
	end) .. "/" .. #self.records)

	return
end

function WorldMediaCollectionRecordDetailLayer:CheckRecordIsUnlock()
	local var_15_0 = nowWorld():GetCollectionProxy():IsUnlock(self.id)

	var_15_0 = var_15_0 or pg.NewStoryMgr.GetInstance():IsPlayed(self.story, true)

	return var_15_0
end

function WorldMediaCollectionRecordDetailLayer:CleanList()
	self.records = nil

	self.recordItemList:SetTotalCount(0)

	return
end

return WorldMediaCollectionRecordDetailLayer
