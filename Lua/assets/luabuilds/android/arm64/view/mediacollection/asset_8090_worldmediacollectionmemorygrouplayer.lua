local WorldMediaCollectionMemoryGroupLayer = class("WorldMediaCollectionMemoryGroupLayer", import(".WorldMediaCollectionSubLayer"))

function WorldMediaCollectionMemoryGroupLayer:getUIName()
	return "WorldMediaCollectionMemoryGroupUI"
end

WorldMediaCollectionMemoryGroupLayer.PAGE_ACTIVITY = 2
WorldMediaCollectionMemoryGroupLayer.FORM_MODE = 1
WorldMediaCollectionMemoryGroupLayer.LINE_MODE = -1

function WorldMediaCollectionMemoryGroupLayer:OnInit()
	WorldMediaCollectionMemoryGroupLayer.super.OnInit(self)
	assert(self.viewParent, "Need assign ViewParent for " .. self.__cname)

	self.memoryGroups = _.map(pg.memory_group.all, function(arg_3_0)
		return pg.memory_group[arg_3_0]
	end)
	self.memoryGroupList = self._tf:Find("GroupRect"):GetComponent("LScrollRect")

	function self.memoryGroupList.onInitItem(arg_4_0)
		self:onInitMemoryGroup(arg_4_0)

		return
	end

	function self.memoryGroupList.onUpdateItem(arg_5_0, arg_5_1)
		self:onUpdateMemoryGroup(arg_5_0 + 1, arg_5_1)

		return
	end

	self.memoryGroupInfos = {}

	setActive(tf(self.memoryGroupList):Find("GroupItem"), false)

	self.memoryGroupViewport = tf(self.memoryGroupList):Find("Viewport")
	self.memoryGroupsGrid = tf(self.memoryGroupList):Find("Viewport/Content"):GetComponent(typeof(GridLayoutGroup))
	self.memoryTogGroup = self._tf:Find("Toggles")

	setActive(self.memoryTogGroup, true)

	self.memoryToggles = {}

	for iter_2_0 = 0, 3 do
		self.memoryToggles[iter_2_0 + 1] = self.memoryTogGroup:Find(iter_2_0)
	end

	self.memoryFilterIndex = {
		true,
		true,
		false
	}
	self.groupToggle = self._tf:Find("ActivityToggle")
	self.memoryActivityTogGroup = self._tf:Find("ActivityToggle/ActivityBar")

	setActive(self.memoryActivityTogGroup, true)

	self.memoryActivityToggles = {}

	for iter_2_1 = 0, 3 do
		self.memoryActivityToggles[iter_2_1 + 1] = self.memoryActivityTogGroup:Find(iter_2_1)
	end

	self.activityFilter = 0

	self:UpdateActivityBar()

	for iter_2_2, iter_2_3 in ipairs(self.memoryActivityToggles) do
		onButton(self, iter_2_3, function()
			if iter_2_2 == self.activityFilter then
				self.activityFilter = 0
			elseif iter_2_2 ~= self.activityFilter then
				self.activityFilter = iter_2_2
			end

			self:UpdateActivityBar()
			self:MemoryFilter()

			return
		end, SFX_UI_TAG)
	end

	setText(self.memoryActivityToggles[1]:Find("Image1/Text"), i18n("memory_actiivty_ex"))
	setText(self.memoryActivityToggles[1]:Find("Image2/Text"), i18n("memory_actiivty_ex"))
	setText(self.memoryActivityToggles[2]:Find("Image1/Text"), i18n("memory_activity_sp"))
	setText(self.memoryActivityToggles[2]:Find("Image2/Text"), i18n("memory_activity_sp"))
	setText(self.memoryActivityToggles[3]:Find("Image1/Text"), i18n("memory_activity_daily"))
	setText(self.memoryActivityToggles[3]:Find("Image2/Text"), i18n("memory_activity_daily"))
	setText(self.memoryActivityToggles[4]:Find("Image1/Text"), i18n("memory_activity_others"))
	setText(self.memoryActivityToggles[4]:Find("Image2/Text"), i18n("memory_activity_others"))

	self.contextData.toggle = self.contextData.toggle or 1

	triggerToggle(self.memoryToggles[self.contextData.toggle], true)
	self:SwitchMemoryFilter(self.contextData.toggle)

	for iter_2_4, iter_2_5 in ipairs(self.memoryToggles) do
		onToggle(self, iter_2_5, function(arg_7_0)
			if not arg_7_0 then
				return
			end

			self:SwitchMemoryFilter(iter_2_4)
			self:MemoryFilter()

			return
		end, SFX_UI_TAG)
	end

	self:OverlayPanel(self.memoryTogGroup, {
		overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
	})

	self.loader = AutoLoader.New()
	self.searchBtn = self._tf:Find("ActivityToggle/search_btn/btn")
	self.nameSearchInput = self._tf:Find("ActivityToggle/search_btn/search")
	self.closeSearch = self._tf:Find("ActivityToggle/search_btn/icon")

	setText(self.searchBtn:Find("label"), i18n("storyline_memorysearch2"))
	onButton(self, self.searchBtn, function()
		setActive(self.nameSearchInput, true)
		setActive(self.searchBtn, false)
		setText(self.nameSearchInput:Find("holder"), i18n("storyline_memorysearch1"))

		self.searchOpen = true

		return
	end)
	onButton(self, self.closeSearch, function()
		if self.searchOpen then
			setActive(self.nameSearchInput, false)
			setActive(self.searchBtn, true)
			setText(self.searchBtn:Find("label"), i18n("storyline_memorysearch2"))
		else
			triggerButton(self.searchBtn)
		end

		return
	end)
	setInputText(self.nameSearchInput, "")
	onInputChanged(self, self.nameSearchInput, function()
		self:searchFilter()

		return
	end)
	self:MemoryFilter()

	self.rectAnchorX = self._tf:Find("GroupRect").anchoredPosition.x

	self:UpdateView()

	self.storyLineBtn = self._tf:Find("StoryLineBtn")
	self.storyLineEntranceBtn = self._tf:Find("StoryLineBtn/entranceBtn")
	self.storyLineHideBtn = self._tf:Find("StoryLineBtn/closeBtn")
	self.currentMode = WorldMediaCollectionMemoryGroupLayer.FORM_MODE

	onButton(self, self.storyLineEntranceBtn, function()
		self:SwitchStoryLineMode(WorldMediaCollectionMemoryGroupLayer.LINE_MODE)

		return
	end)
	onButton(self, self.storyLineHideBtn, function()
		self:StoryLineBtnSetActive(false)

		return
	end)
	onButton(self, self.storyLineBtn, function()
		self:StoryLineBtnSetActive(true)

		return
	end)

	self.storylineTF = self._tf:Find("StoryLine")
	self.storyLineView = WorldMediaCollectionStoryLineView.New(self.storylineTF)

	self.storyLineView:ConfigCallback(function(arg_14_0, arg_14_1)
		self.viewParent:ShowSubMemories(arg_14_0, true, arg_14_1)
		WorldMediaCollectionMemoryGroupLayer.super.Hide(self)

		return
	end, function(arg_15_0, arg_15_1, arg_15_2)
		self.viewParent.viewParent:WarpToRecord(arg_15_0, arg_15_1, arg_15_2)

		return
	end)

	return
end

function WorldMediaCollectionMemoryGroupLayer:StoryLineBtnSetActive(arg_16_1)
	setActive(self.storyLineEntranceBtn, arg_16_1)
	setActive(self.storyLineHideBtn, arg_16_1)
	setActive(self._tf:Find("StoryLineBtn/on"), not arg_16_1)

	return
end

function WorldMediaCollectionMemoryGroupLayer:SwitchStoryLineMode(arg_17_1)
	self.currentMode = arg_17_1

	if arg_17_1 == WorldMediaCollectionMemoryGroupLayer.FORM_MODE then
		setActive(self._tf:Find("GroupRect"), true)
		setActive(self.memoryTogGroup, true)
		setActive(self.groupToggle, true)
		setActive(self.storylineTF, false)
		setActive(self.storyLineBtn, true)
		self.storyLineView:closeFilter()
		self:MemoryFilter()
		pg.BgmMgr.GetInstance():ContinuePlay()
	elseif arg_17_1 == WorldMediaCollectionMemoryGroupLayer.LINE_MODE then
		setActive(self._tf:Find("GroupRect"), false)
		setActive(self.memoryTogGroup, false)
		setActive(self.groupToggle, false)
		setActive(self.storylineTF, true)
		setActive(self.storyLineBtn, false)
		self.storyLineView:refresh()
	end

	return
end

function WorldMediaCollectionMemoryGroupLayer:Show()
	WorldMediaCollectionMemoryGroupLayer.super.Show(self)
	setActive(self.memoryTogGroup, self.currentMode == WorldMediaCollectionMemoryGroupLayer.FORM_MODE)

	return
end

function WorldMediaCollectionMemoryGroupLayer:Hide()
	if self.currentMode == WorldMediaCollectionMemoryGroupLayer.FORM_MODE then
		setActive(self.memoryTogGroup, false)
		WorldMediaCollectionMemoryGroupLayer.super.Hide(self)
	else
		self:SwitchStoryLineMode(WorldMediaCollectionMemoryGroupLayer.FORM_MODE)
	end

	return
end

function WorldMediaCollectionMemoryGroupLayer:GetCurrentMode()
	return self.currentMode
end

function WorldMediaCollectionMemoryGroupLayer:SwitchMemoryFilter(arg_21_1)
	if arg_21_1 == 1 then
		self.memoryFilterIndex = {
			true,
			true,
			false
		}
	else
		for iter_21_0 in ipairs(self.memoryFilterIndex) do
			self.memoryFilterIndex[iter_21_0] = arg_21_1 - 1 == iter_21_0
		end

		if arg_21_1 - 1 == WorldMediaCollectionMemoryGroupLayer.PAGE_ACTIVITY then
			self.activityFilter = 0

			self:UpdateActivityBar()
		end
	end

	return
end

function WorldMediaCollectionMemoryGroupLayer:MemoryFilter()
	table.clear(self.memoryGroups)

	local var_22_0 = not _.all(self.memoryFilterIndex, function(arg_23_0)
		return arg_23_0
	end) and self.memoryFilterIndex[WorldMediaCollectionMemoryGroupLayer.PAGE_ACTIVITY]

	for iter_22_0, iter_22_1 in ipairs(pg.memory_group.all) do
		if self.memoryFilterIndex[pg.memory_group[iter_22_1].type] then
			if var_22_0 then
				if self.activityFilter == 0 or self.activityFilter == pg.memory_group[iter_22_1].subtype then
					table.insert(self.memoryGroups, pg.memory_group[iter_22_1])
				end
			else
				table.insert(self.memoryGroups, pg.memory_group[iter_22_1])
			end
		end
	end

	table.sort(self.memoryGroups, function(arg_24_0, arg_24_1)
		return arg_24_0.id < arg_24_1.id
	end)
	self:searchFilter()
	setActive(self.memoryActivityTogGroup, var_22_0)

	return
end

function WorldMediaCollectionMemoryGroupLayer:searchFilter()
	local var_25_0 = getInputText(self.nameSearchInput)

	if not var_25_0 or var_25_0 == "" then
		self.searchGroupList = nil

		self.memoryGroupList:SetTotalCount(#self.memoryGroups, 0)
	else
		self.searchGroupList = self:GetMatchGroupList(var_25_0)

		self.memoryGroupList:SetTotalCount(#self.searchGroupList, 0)
	end

	return
end

function WorldMediaCollectionMemoryGroupLayer:onInitMemoryGroup(arg_26_1)
	if self.exited then
		return
	end

	onButton(self, arg_26_1, function()
		if self.memoryGroupInfos[arg_26_1] then
			PlayerPrefs.DeleteKey("MEMORY_GROUP_NOTIFICATION" .. getProxy(PlayerProxy):getRawData().id .. " " .. self.memoryGroupInfos[arg_26_1].id)
			self.viewParent:ShowSubMemories(self.memoryGroupInfos[arg_26_1])
		end

		return
	end, SOUND_BACK)

	return
end

function WorldMediaCollectionMemoryGroupLayer:onUpdateMemoryGroup(arg_28_1, arg_28_2)
	if self.exited then
		return
	end

	local var_28_0

	if self.searchGroupList then
		var_28_0 = self.searchGroupList[arg_28_1] or self.memoryGroups[arg_28_1]
	end

	assert(var_28_0, "MemoryGroup Missing Config Index " .. arg_28_1)

	self.memoryGroupInfos[arg_28_2] = var_28_0

	setText(tf(arg_28_2):Find("title"), var_28_0.title)
	self.loader:GetSpriteQuiet("memoryicon/" .. var_28_0.icon, "", tf(arg_28_2):Find("BG"))
	setActive(tf(arg_28_2):Find("Tip"), PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. getProxy(PlayerProxy):getRawData().id .. " " .. var_28_0.id, 0) == 1)
	setText(tf(arg_28_2):Find("count"), _.reduce(var_28_0.memories, 0, function(arg_29_0, arg_29_1)
		if pg.memory_template[arg_29_1].is_open ~= 1 then
			if pg.NewStoryMgr.GetInstance():IsPlayed(pg.memory_template[arg_29_1].unlock_pre, true) then
				arg_29_0 = arg_29_0 + 1
			end
		end

		return arg_29_0
	end) .. "/" .. #var_28_0.memories)

	return
end

function WorldMediaCollectionMemoryGroupLayer:Return2MemoryGroup()
	if not self.contextData.memoryGroup or self:GetCurrentMode() == WorldMediaCollectionMemoryGroupLayer.LINE_MODE then
		return
	end

	local var_30_0 = 0

	for iter_30_0, iter_30_1 in ipairs(self.memoryGroups) do
		if iter_30_1.id == self.contextData.memoryGroup then
			var_30_0 = iter_30_0

			break
		end
	end

	setInputText(self.nameSearchInput, "")
	self.memoryGroupList:SetTotalCount(#self.memoryGroups, (self:GetIndexRatio(var_30_0)))

	return
end

function WorldMediaCollectionMemoryGroupLayer:SwitchReddotMemory()
	local var_31_0 = 0
	local var_31_1 = getProxy(PlayerProxy):getRawData().id

	for iter_31_0, iter_31_1 in ipairs(self.memoryGroups) do
		if PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_31_1 .. " " .. iter_31_1.id, 0) == 1 then
			var_31_0 = iter_31_0

			break
		end
	end

	if var_31_0 == 0 then
		return
	end

	setInputText(self.nameSearchInput, "")
	self.memoryGroupList:SetTotalCount(#self.memoryGroups, (self:GetIndexRatio(var_31_0)))

	return
end

function WorldMediaCollectionMemoryGroupLayer:GetIndexRatio(arg_32_1)
	local var_32_0 = 0

	if arg_32_1 > 0 then
		var_32_0 = ((self.memoryGroupsGrid.cellSize.y + self.memoryGroupsGrid.spacing.y) * math.floor((arg_32_1 - 1) / self.memoryGroupsGrid.constraintCount) + self.memoryGroupList.paddingFront) / ((self.memoryGroupsGrid.cellSize.y + self.memoryGroupsGrid.spacing.y) * math.ceil(#self.memoryGroups / self.memoryGroupsGrid.constraintCount) - self.memoryGroupViewport.rect.height)
		var_32_0 = Mathf.Clamp01(var_32_0)
	end

	return var_32_0
end

function WorldMediaCollectionMemoryGroupLayer:UpdateView()
	setAnchoredPosition(self._tf:Find("GroupRect"), {
		x = WorldMediaCollectionScene.WorldRecordLock() and 0 or self.rectAnchorX
	})

	for iter_33_0, iter_33_1 in ipairs(self.memoryActivityToggles) do
		setActive(iter_33_1, _.any(pg.memory_group.all, function(arg_34_0)
			return pg.memory_group[arg_34_0].subtype == iter_33_0
		end))
	end

	return
end

function WorldMediaCollectionMemoryGroupLayer:UpdateActivityBar()
	for iter_35_0, iter_35_1 in ipairs(self.memoryActivityToggles) do
		local var_35_0 = self.activityFilter == iter_35_0

		setActive(iter_35_1:Find("Image1"), not (self.activityFilter == iter_35_0))
		setActive(iter_35_1:Find("Image2"), var_35_0)
	end

	return
end

function WorldMediaCollectionMemoryGroupLayer:OnDestroy()
	WorldMediaCollectionMemoryGroupLayer.super.OnDestroy(self)
	self.storyLineView:Dispose()
	self:UnOverlayPanel(self.memoryTogGroup, self._tf)

	return
end

function WorldMediaCollectionMemoryGroupLayer:GetMatchGroupList(arg_37_1, arg_37_2)
	arg_37_1 = string.lower(string.gsub(arg_37_1, "%.", "%%."))

	local var_37_0 = {}

	for iter_37_0, iter_37_1 in pairs(self.memoryGroups) do
		if string.find(string.lower(iter_37_1.title), arg_37_1) then
			table.insert(var_37_0, iter_37_1)
		end
	end

	return var_37_0
end

return WorldMediaCollectionMemoryGroupLayer
