local NewWorldMediaCollectionMemoryGroupLayer = class("NewWorldMediaCollectionMemoryGroupLayer", import(".WorldMediaCollectionSubLayer"))

NewWorldMediaCollectionMemoryGroupLayer.Role = 3
NewWorldMediaCollectionMemoryGroupLayer.FORM_MODE = 1
NewWorldMediaCollectionMemoryGroupLayer.LINE_MODE = -1
NewWorldMediaCollectionMemoryGroupLayer.index = -1
NewWorldMediaCollectionMemoryGroupLayer.sort = false

function NewWorldMediaCollectionMemoryGroupLayer:getUIName()
	return "NewWorldMediaCollectionMemoryGroupUI"
end

function NewWorldMediaCollectionMemoryGroupLayer:OnInit()
	NewWorldMediaCollectionMemoryGroupLayer.super.OnInit(self)
	assert(self.viewParent, "Need assign ViewParent for " .. self.__cname)

	self.baseMemoryGroups = underscore(pg.memory_group.all):chain():map(function(arg_3_0)
		return pg.memory_group[arg_3_0]
	end):filter(function(arg_4_0)
		return arg_4_0.type == NewWorldMediaCollectionMemoryGroupLayer.Role
	end):value()
	self.memoryGroups = underscore.to_array(self.baseMemoryGroups)
	self.memoryGroupList = self._tf:Find("GroupRect"):GetComponent("LScrollRect")

	function self.memoryGroupList.onInitItem(arg_5_0)
		self:onInitMemoryGroup(arg_5_0)

		return
	end

	function self.memoryGroupList.onUpdateItem(arg_6_0, arg_6_1)
		self:onUpdateMemoryGroup(arg_6_0 + 1, arg_6_1)

		return
	end

	self.memoryGroupInfos = {}

	setActive(tf(self.memoryGroupList):Find("GroupItem"), false)

	self.memoryGroupViewport = tf(self.memoryGroupList):Find("Viewport")
	self.memoryGroupsGrid = tf(self.memoryGroupList):Find("Viewport/Content"):GetComponent(typeof(GridLayoutGroup))
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
	onButton(self, self._tf:Find("ActivityToggle/search/up"), function()
		self.selectAsc = false

		setActive(self._tf:Find("ActivityToggle/search/up"), self.selectAsc)
		setActive(self._tf:Find("ActivityToggle/search/below"), not self.selectAsc)
		self:searchFilter()

		return
	end)
	onButton(self, self._tf:Find("ActivityToggle/search/below"), function()
		self.selectAsc = true

		setActive(self._tf:Find("ActivityToggle/search/up"), self.selectAsc)
		setActive(self._tf:Find("ActivityToggle/search/below"), not self.selectAsc)
		self:searchFilter()

		return
	end)
	onButton(self, self._tf:Find("ActivityToggle/btn"), function()
		self:emit(WorldMediaCollectionMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = CustomIndexMediator,
			viewComponent = RoleStoryCustomIndexLayer,
			data = {
				indexDatas = Clone(self.contextData.indexDatas),
				customPanels = {
					minHeight = 650,
					sortIndex = {
						isSort = true,
						mode = CustomIndexLayer.Mode.OR,
						options = ShipIndexConst.SortRoleStory,
						names = ShipIndexConst.SortRoleStoryName
					},
					progressIndex = {
						blueSeleted = true,
						mode = CustomIndexLayer.Mode.AND,
						options = ShipIndexConst.RoleProgress,
						names = ShipIndexConst.RoleProgressName
					},
					typeIndex = {
						blueSeleted = true,
						mode = CustomIndexLayer.Mode.AND,
						options = ShipIndexConst.TypeIndexs,
						names = ShipIndexConst.TypeNames
					},
					campIndex = {
						blueSeleted = true,
						mode = CustomIndexLayer.Mode.AND,
						options = ShipIndexConst.CampIndexs,
						names = ShipIndexConst.CampNames
					},
					layoutPos = Vector2(0, -25)
				},
				groupList = {
					{
						dropdown = false,
						titleENTxt = "indexsort_indexeng",
						titleTxt = "indexsort_sort",
						tags = {
							"sortIndex"
						}
					},
					{
						dropdown = false,
						titleENTxt = "indexsort_indexeng",
						titleTxt = "world_collection_2",
						tags = {
							"progressIndex"
						}
					},
					{
						dropdown = false,
						titleENTxt = "indexsort_indexeng",
						titleTxt = "indexsort_index",
						tags = {
							"typeIndex"
						}
					},
					{
						dropdown = false,
						titleENTxt = "indexsort_campeng",
						titleTxt = "indexsort_camp",
						tags = {
							"campIndex"
						}
					}
				},
				callback = function(self)
					self.sortIndex = self.sortIndex
					self.typeIndex = self.typeIndex
					self.campIndex = self.campIndex
					self.progressIndex = self.progressIndex

					self:updateIndexDatas()
					self:filterCommon()
					self:searchFilter()
					self:UpdateFilterBtn()

					return
				end
			}
		})))

		return
	end)

	self.HallGloryTF = self._tf:Find("HonorBtn")

	onButton(self, self.HallGloryTF, function()
		self.index = 2

		self.viewParent:ShowHallGloryLayer()

		return
	end)

	if self.contextData.indexDatas then
		self.contextData.indexDatas = nil
	end

	triggerButton(self._tf:Find("ActivityToggle/search/below"))
	self:UpdateFilterBtn()

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:updateIndexDatas()
	self.contextData.indexDatas = self.contextData.indexDatas or {}
	self.contextData.indexDatas.sortIndex = self.sortIndex
	self.contextData.indexDatas.typeIndex = self.typeIndex
	self.contextData.indexDatas.campIndex = self.campIndex
	self.contextData.indexDatas.progressIndex = self.progressIndex

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:filterCommon()
	self.GroupList = {}
	self.memoryGroups = {}

	if not self.shipDic then
		self.shipDic = {}

		for iter_16_0, iter_16_1 in ipairs(self.baseMemoryGroups) do
			if iter_16_1.ship_group ~= 0 then
				self.shipDic[iter_16_1.id] = Ship.New({
					configId = ShipGroup.getDefaultShipConfig(iter_16_1.ship_group).id
				})
			end
		end
	end

	for iter_16_2, iter_16_3 in ipairs(self.baseMemoryGroups) do
		assert(iter_16_3.ship_group ~= 0, "MemoryGroup " .. iter_16_3.id .. " missing ship group")

		if ShipIndexConst.filterByType(self.shipDic[iter_16_3.id], self.typeIndex) and ShipIndexConst.filterByCamp(self.shipDic[iter_16_3.id], self.campIndex) and ShipIndexConst.filterRoleProgressBar(iter_16_3, self.progressIndex) then
			table.insert(self.memoryGroups, iter_16_3)
		end
	end

	local var_16_0 = ShipIndexConst.getSortName(self.sortIndex)

	if var_16_0 == 1 then
		-- block empty
	elseif var_16_0 == 2 then
		table.sort(self.memoryGroups, CompareFuncs({
			function(arg_17_0)
				local var_17_0, var_17_1 = self:OnSchedule(arg_17_0)

				return var_17_0 / var_17_1
			end,
			function(arg_18_0)
				return arg_18_0.id
			end
		}))
	end

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:StoryLineBtnSetActive(arg_19_1)
	setActive(self.storyLineEntranceBtn, arg_19_1)
	setActive(self.storyLineHideBtn, arg_19_1)
	setActive(self._tf:Find("StoryLineBtn/on"), not arg_19_1)

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:Hide()
	NewWorldMediaCollectionMemoryGroupLayer.super.Hide(self)

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:GetCurrentMode()
	return self.currentMode
end

function NewWorldMediaCollectionMemoryGroupLayer:OnLockRole(arg_22_1)
	local var_22_1 = false

	for iter_22_0, iter_22_1 in ipairs((getProxy(BayProxy):getShips())) do
		if tonumber(iter_22_1:getGroupId()) == tonumber(arg_22_1.ship_group) then
			var_22_1 = true

			break
		end
	end

	return var_22_1
end

function NewWorldMediaCollectionMemoryGroupLayer:OnSchedule(arg_23_1)
	return _.reduce(arg_23_1.memories, 0, function(arg_24_0, arg_24_1)
		if pg.memory_template[arg_24_1].is_open ~= 1 then
			if pg.NewStoryMgr.GetInstance():IsPlayed(pg.memory_template[arg_24_1].unlock_pre, true) then
				arg_24_0 = arg_24_0 + 1
			end
		end

		return arg_24_0
	end), #arg_23_1.memories
end

function NewWorldMediaCollectionMemoryGroupLayer:MemoryFilter()
	self:searchFilter()

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:searchFilter()
	self.searchGroupList = self:GetMatchGroupList((getInputText(self.nameSearchInput)))

	if not self.selectAsc then
		self.searchGroupList = underscore.reverse(self.searchGroupList)
	end

	self.memoryGroupList:SetTotalCount(#self.searchGroupList, 0)

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:Show()
	NewWorldMediaCollectionMemoryGroupLayer.super.Show(self)

	self.index = -1

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:onInitMemoryGroup(arg_28_1)
	if self.exited then
		return
	end

	onButton(self, arg_28_1, function()
		self.index = 1

		if self.memoryGroupInfos[arg_28_1] then
			PlayerPrefs.DeleteKey("MEMORY_GROUP_NOTIFICATION" .. getProxy(PlayerProxy):getRawData().id .. " " .. self.memoryGroupInfos[arg_28_1].id)
			self.viewParent:ShowSubMemories(self.memoryGroupInfos[arg_28_1])
		end

		return
	end, SOUND_BACK)

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:onUpdateMemoryGroup(arg_30_1, arg_30_2)
	if self.exited then
		return
	end

	local var_30_0 = getProxy(CollectionProxy)
	local var_30_1 = self.searchGroupList[arg_30_1]

	assert(self.searchGroupList[arg_30_1], "MemoryGroup Missing Config Index " .. arg_30_1)

	self.memoryGroupInfos[arg_30_2] = var_30_1

	local var_30_2 = #var_30_1.memories
	local var_30_3 = _.reduce(var_30_1.memories, 0, function(arg_31_0, arg_31_1)
		if pg.memory_template[arg_31_1].is_open ~= 1 then
			if pg.NewStoryMgr.GetInstance():IsPlayed(pg.memory_template[arg_31_1].unlock_pre, true) then
				arg_31_0 = arg_31_0 + 1
			end
		end

		return arg_31_0
	end)
	local var_30_4 = PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. getProxy(PlayerProxy):getRawData().id .. " " .. var_30_1.id, 0) == 1
	local var_30_5 = tobool(var_30_0 and var_30_0.shipGroups[var_30_1.ship_group])
	local var_30_6 = var_30_5 or var_30_3 > 0

	setActive(tf(arg_30_2):Find("on"), var_30_5 or var_30_3 > 0)
	setActive(tf(arg_30_2):Find("off"), not var_30_6)

	local var_30_7 = var_30_3 == 0 and var_30_5 and var_30_1.id ~= 501

	setActive(tf(arg_30_2):Find("Tip"), var_30_3 == 0 and var_30_5 and var_30_1.id ~= 501)
	setActive(tf(arg_30_2):Find("on/get"), var_30_7)
	setActive(tf(arg_30_2):Find("on/title_get"), var_30_7)
	setText(tf(arg_30_2):Find("on/title"), var_30_1.title)
	setText(tf(arg_30_2):Find("off/title"), i18n("memory_filter_option_6"))
	setText(tf(arg_30_2):Find("on/title_get/title"), i18n("memory_filter_option_4"))
	setText(tf(arg_30_2):Find("on/count"), var_30_3 .. "/" .. var_30_2)
	self.loader:GetSpriteQuiet("memoryicon/" .. var_30_1.icon, "", tf(arg_30_2):Find("on/BG"))
	self.loader:GetSpriteQuiet("memoryicon/" .. var_30_1.icon, "", tf(arg_30_2):Find("off/BG"))

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:Return2MemoryGroup()
	if not self.contextData.memoryGroup or self:GetCurrentMode() == NewWorldMediaCollectionMemoryGroupLayer.LINE_MODE then
		return
	end

	local var_32_0 = 0

	for iter_32_0, iter_32_1 in ipairs(self.searchGroupList) do
		if iter_32_1.id == self.contextData.memoryGroup then
			var_32_0 = iter_32_0

			break
		end
	end

	setInputText(self.nameSearchInput, "")
	self.memoryGroupList:SetTotalCount(#self.searchGroupList, (self:GetIndexRatio(var_32_0)))

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:SwitchReddotMemory()
	local var_33_0 = 0
	local var_33_1 = getProxy(PlayerProxy):getRawData().id

	for iter_33_0, iter_33_1 in ipairs(self.searchGroupList) do
		if PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_33_1 .. " " .. iter_33_1.id, 0) == 1 then
			var_33_0 = iter_33_0

			break
		end
	end

	if var_33_0 == 0 then
		return
	end

	self.memoryGroupList:SetTotalCount(#self.searchGroupList, (self:GetIndexRatio(var_33_0)))

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:GetIndexRatio(arg_34_1)
	local var_34_0 = 0

	if arg_34_1 > 0 then
		var_34_0 = ((self.memoryGroupsGrid.cellSize.y + self.memoryGroupsGrid.spacing.y) * math.floor((arg_34_1 - 1) / self.memoryGroupsGrid.constraintCount) + self.memoryGroupList.paddingFront) / ((self.memoryGroupsGrid.cellSize.y + self.memoryGroupsGrid.spacing.y) * math.ceil(#self.searchGroupList / self.memoryGroupsGrid.constraintCount) - self.memoryGroupViewport.rect.height)
		var_34_0 = Mathf.Clamp01(var_34_0)
	end

	return var_34_0
end

function NewWorldMediaCollectionMemoryGroupLayer:GetMatchGroupList(arg_35_1, arg_35_2)
	if not noEmptyStr(arg_35_1) then
		return underscore.to_array(self.memoryGroups)
	end

	arg_35_1 = string.lower(string.gsub(arg_35_1, "%.", "%%."))

	local var_35_0 = {}

	for iter_35_0, iter_35_1 in pairs(self.memoryGroups) do
		if string.find(string.lower(iter_35_1.title), arg_35_1) then
			table.insert(var_35_0, iter_35_1)
		elseif string.find(string.lower((ShipGroup.getDefaultShipNameByGroupID(iter_35_1.ship_group))), arg_35_1) then
			table.insert(var_35_0, iter_35_1)
		end
	end

	return var_35_0
end

function NewWorldMediaCollectionMemoryGroupLayer:UpdateFilterBtn()
	setActive(self._tf:Find("ActivityToggle/btn/active"), self.contextData.indexDatas and (self.contextData.indexDatas.sortIndex ~= ShipIndexConst.SortDefault or self.contextData.indexDatas.typeIndex ~= ShipIndexConst.TypeAll or self.contextData.indexDatas.campIndex ~= ShipIndexConst.CampAll or self.contextData.indexDatas.progressIndex ~= ShipIndexConst.All))

	return
end

function NewWorldMediaCollectionMemoryGroupLayer:UpdateView()
	return
end

return NewWorldMediaCollectionMemoryGroupLayer
