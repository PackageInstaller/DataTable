local var_0_0 = class("NewWorldMediaCollectionMemoryGroupLayer", import(".WorldMediaCollectionSubLayer"))

var_0_0.Role = 3
var_0_0.FORM_MODE = 1
var_0_0.LINE_MODE = -1
var_0_0.index = -1
var_0_0.sort = false

function var_0_0.getUIName(arg_1_0)
	return "NewWorldMediaCollectionMemoryGroupUI"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	assert(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)

	arg_2_0.baseMemoryGroups = underscore(pg.memory_group.all):chain():map(function(arg_3_0)
		return pg.memory_group[arg_3_0]
	end):filter(function(arg_4_0)
		return arg_4_0.type == var_0_0.Role
	end):value()
	arg_2_0.memoryGroups = underscore.to_array(arg_2_0.baseMemoryGroups)
	arg_2_0.memoryGroupList = arg_2_0._tf:Find("GroupRect"):GetComponent("LScrollRect")

	function arg_2_0.memoryGroupList.onInitItem(arg_5_0)
		arg_2_0:onInitMemoryGroup(arg_5_0)

		return
	end

	function arg_2_0.memoryGroupList.onUpdateItem(arg_6_0, arg_6_1)
		arg_2_0:onUpdateMemoryGroup(arg_6_0 + 1, arg_6_1)

		return
	end

	arg_2_0.memoryGroupInfos = {}

	setActive(tf(arg_2_0.memoryGroupList):Find("GroupItem"), false)

	arg_2_0.memoryGroupViewport = tf(arg_2_0.memoryGroupList):Find("Viewport")
	arg_2_0.memoryGroupsGrid = tf(arg_2_0.memoryGroupList):Find("Viewport/Content"):GetComponent(typeof(GridLayoutGroup))
	arg_2_0.loader = AutoLoader.New()
	arg_2_0.searchBtn = arg_2_0._tf:Find("ActivityToggle/search_btn/btn")
	arg_2_0.nameSearchInput = arg_2_0._tf:Find("ActivityToggle/search_btn/search")
	arg_2_0.closeSearch = arg_2_0._tf:Find("ActivityToggle/search_btn/icon")

	setText(arg_2_0.searchBtn:Find("label"), i18n("storyline_memorysearch2"))
	onButton(arg_2_0, arg_2_0.searchBtn, function()
		setActive(arg_2_0.nameSearchInput, true)
		setActive(arg_2_0.searchBtn, false)
		setText(arg_2_0.nameSearchInput:Find("holder"), i18n("storyline_memorysearch1"))

		arg_2_0.searchOpen = true

		return
	end)
	onButton(arg_2_0, arg_2_0.closeSearch, function()
		if arg_2_0.searchOpen then
			setActive(arg_2_0.nameSearchInput, false)
			setActive(arg_2_0.searchBtn, true)
			setText(arg_2_0.searchBtn:Find("label"), i18n("storyline_memorysearch2"))
		else
			triggerButton(arg_2_0.searchBtn)
		end

		return
	end)
	setInputText(arg_2_0.nameSearchInput, "")
	onInputChanged(arg_2_0, arg_2_0.nameSearchInput, function()
		arg_2_0:searchFilter()

		return
	end)
	onButton(arg_2_0, arg_2_0._tf:Find("ActivityToggle/search/up"), function()
		arg_2_0.selectAsc = false

		setActive(arg_2_0._tf:Find("ActivityToggle/search/up"), arg_2_0.selectAsc)
		setActive(arg_2_0._tf:Find("ActivityToggle/search/below"), not arg_2_0.selectAsc)
		arg_2_0:searchFilter()

		return
	end)
	onButton(arg_2_0, arg_2_0._tf:Find("ActivityToggle/search/below"), function()
		arg_2_0.selectAsc = true

		setActive(arg_2_0._tf:Find("ActivityToggle/search/up"), arg_2_0.selectAsc)
		setActive(arg_2_0._tf:Find("ActivityToggle/search/below"), not arg_2_0.selectAsc)
		arg_2_0:searchFilter()

		return
	end)
	onButton(arg_2_0, arg_2_0._tf:Find("ActivityToggle/btn"), function()
		arg_2_0:emit(WorldMediaCollectionMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = CustomIndexMediator,
			viewComponent = RoleStoryCustomIndexLayer,
			data = {
				indexDatas = Clone(arg_2_0.contextData.indexDatas),
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
				callback = function(arg_13_0)
					arg_2_0.sortIndex = arg_13_0.sortIndex
					arg_2_0.typeIndex = arg_13_0.typeIndex
					arg_2_0.campIndex = arg_13_0.campIndex
					arg_2_0.progressIndex = arg_13_0.progressIndex

					arg_2_0:updateIndexDatas()
					arg_2_0:filterCommon()
					arg_2_0:searchFilter()
					arg_2_0:UpdateFilterBtn()

					return
				end
			}
		})))

		return
	end)

	arg_2_0.HallGloryTF = arg_2_0._tf:Find("HonorBtn")

	onButton(arg_2_0, arg_2_0.HallGloryTF, function()
		arg_2_0.index = 2

		arg_2_0.viewParent:ShowHallGloryLayer()

		return
	end)

	if arg_2_0.contextData.indexDatas then
		arg_2_0.contextData.indexDatas = nil
	end

	triggerButton(arg_2_0._tf:Find("ActivityToggle/search/below"))
	arg_2_0:UpdateFilterBtn()

	return
end

function var_0_0.updateIndexDatas(arg_15_0)
	arg_15_0.contextData.indexDatas = arg_15_0.contextData.indexDatas or {}
	arg_15_0.contextData.indexDatas.sortIndex = arg_15_0.sortIndex
	arg_15_0.contextData.indexDatas.typeIndex = arg_15_0.typeIndex
	arg_15_0.contextData.indexDatas.campIndex = arg_15_0.campIndex
	arg_15_0.contextData.indexDatas.progressIndex = arg_15_0.progressIndex

	return
end

function var_0_0.filterCommon(arg_16_0)
	arg_16_0.GroupList = {}
	arg_16_0.memoryGroups = {}

	if not arg_16_0.shipDic then
		arg_16_0.shipDic = {}

		for iter_16_0, iter_16_1 in ipairs(arg_16_0.baseMemoryGroups) do
			if iter_16_1.ship_group ~= 0 then
				arg_16_0.shipDic[iter_16_1.id] = Ship.New({
					configId = ShipGroup.getDefaultShipConfig(iter_16_1.ship_group).id
				})
			end
		end
	end

	for iter_16_2, iter_16_3 in ipairs(arg_16_0.baseMemoryGroups) do
		assert(iter_16_3.ship_group ~= 0, "MemoryGroup " .. iter_16_3.id .. " missing ship group")

		if ShipIndexConst.filterByType(arg_16_0.shipDic[iter_16_3.id], arg_16_0.typeIndex) and ShipIndexConst.filterByCamp(arg_16_0.shipDic[iter_16_3.id], arg_16_0.campIndex) and ShipIndexConst.filterRoleProgressBar(iter_16_3, arg_16_0.progressIndex) then
			table.insert(arg_16_0.memoryGroups, iter_16_3)
		end
	end

	local var_16_0 = ShipIndexConst.getSortName(arg_16_0.sortIndex)

	if var_16_0 == 1 then
		-- block empty
	elseif var_16_0 == 2 then
		table.sort(arg_16_0.memoryGroups, CompareFuncs({
			function(arg_17_0)
				local var_17_0, var_17_1 = arg_16_0:OnSchedule(arg_17_0)

				return var_17_0 / var_17_1
			end,
			function(arg_18_0)
				return arg_18_0.id
			end
		}))
	end

	return
end

function var_0_0.StoryLineBtnSetActive(arg_19_0, arg_19_1)
	setActive(arg_19_0.storyLineEntranceBtn, arg_19_1)
	setActive(arg_19_0.storyLineHideBtn, arg_19_1)
	setActive(arg_19_0._tf:Find("StoryLineBtn/on"), not arg_19_1)

	return
end

function var_0_0.Hide(arg_20_0)
	var_0_0.super.Hide(arg_20_0)

	return
end

function var_0_0.GetCurrentMode(arg_21_0)
	return arg_21_0.currentMode
end

function var_0_0.OnLockRole(arg_22_0, arg_22_1)
	local var_22_1 = false

	for iter_22_0, iter_22_1 in ipairs((getProxy(BayProxy):getShips())) do
		if tonumber(iter_22_1:getGroupId()) == tonumber(arg_22_1.ship_group) then
			var_22_1 = true

			break
		end
	end

	return var_22_1
end

function var_0_0.OnSchedule(arg_23_0, arg_23_1)
	return _.reduce(arg_23_1.memories, 0, function(arg_24_0, arg_24_1)
		if pg.memory_template[arg_24_1].is_open ~= 1 then
			if pg.NewStoryMgr.GetInstance():IsPlayed(pg.memory_template[arg_24_1].unlock_pre, true) then
				arg_24_0 = arg_24_0 + 1
			end

			return arg_24_0
		end
	end), #arg_23_1.memories
end

function var_0_0.MemoryFilter(arg_25_0)
	arg_25_0:searchFilter()

	return
end

function var_0_0.searchFilter(arg_26_0)
	arg_26_0.searchGroupList = arg_26_0:GetMatchGroupList((getInputText(arg_26_0.nameSearchInput)))

	if not arg_26_0.selectAsc then
		arg_26_0.searchGroupList = underscore.reverse(arg_26_0.searchGroupList)
	end

	arg_26_0.memoryGroupList:SetTotalCount(#arg_26_0.searchGroupList, 0)

	return
end

function var_0_0.Show(arg_27_0)
	var_0_0.super.Show(arg_27_0)

	arg_27_0.index = -1

	return
end

function var_0_0.onInitMemoryGroup(arg_28_0, arg_28_1)
	if arg_28_0.exited then
		return
	end

	onButton(arg_28_0, arg_28_1, function()
		arg_28_0.index = 1

		if arg_28_0.memoryGroupInfos[arg_28_1] then
			PlayerPrefs.DeleteKey("MEMORY_GROUP_NOTIFICATION" .. getProxy(PlayerProxy):getRawData().id .. " " .. arg_28_0.memoryGroupInfos[arg_28_1].id)
			arg_28_0.viewParent:ShowSubMemories(arg_28_0.memoryGroupInfos[arg_28_1])
		end

		return
	end, SOUND_BACK)

	return
end

function var_0_0.onUpdateMemoryGroup(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0.exited then
		return
	end

	local var_30_0 = getProxy(CollectionProxy)
	local var_30_1 = arg_30_0.searchGroupList[arg_30_1]

	assert(arg_30_0.searchGroupList[arg_30_1], "MemoryGroup Missing Config Index " .. arg_30_1)

	arg_30_0.memoryGroupInfos[arg_30_2] = var_30_1

	local var_30_2 = #var_30_1.memories
	local var_30_3 = _.reduce(var_30_1.memories, 0, function(arg_31_0, arg_31_1)
		if pg.memory_template[arg_31_1].is_open ~= 1 then
			if pg.NewStoryMgr.GetInstance():IsPlayed(pg.memory_template[arg_31_1].unlock_pre, true) then
				arg_31_0 = arg_31_0 + 1
			end

			return arg_31_0
		end
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
	arg_30_0.loader:GetSpriteQuiet("memoryicon/" .. var_30_1.icon, "", tf(arg_30_2):Find("on/BG"))
	arg_30_0.loader:GetSpriteQuiet("memoryicon/" .. var_30_1.icon, "", tf(arg_30_2):Find("off/BG"))

	return
end

function var_0_0.Return2MemoryGroup(arg_32_0)
	if not arg_32_0.contextData.memoryGroup or arg_32_0:GetCurrentMode() == var_0_0.LINE_MODE then
		return
	end

	local var_32_0 = 0

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.searchGroupList) do
		if iter_32_1.id == arg_32_0.contextData.memoryGroup then
			var_32_0 = iter_32_0

			break
		end
	end

	setInputText(arg_32_0.nameSearchInput, "")
	arg_32_0.memoryGroupList:SetTotalCount(#arg_32_0.searchGroupList, (arg_32_0:GetIndexRatio(var_32_0)))

	return
end

function var_0_0.SwitchReddotMemory(arg_33_0)
	local var_33_0 = 0
	local var_33_1 = getProxy(PlayerProxy):getRawData().id

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.searchGroupList) do
		if PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_33_1 .. " " .. iter_33_1.id, 0) == 1 then
			var_33_0 = iter_33_0

			break
		end
	end

	if var_33_0 == 0 then
		return
	end

	arg_33_0.memoryGroupList:SetTotalCount(#arg_33_0.searchGroupList, (arg_33_0:GetIndexRatio(var_33_0)))

	return
end

function var_0_0.GetIndexRatio(arg_34_0, arg_34_1)
	local var_34_0 = 0

	if arg_34_1 > 0 then
		var_34_0 = ((arg_34_0.memoryGroupsGrid.cellSize.y + arg_34_0.memoryGroupsGrid.spacing.y) * math.floor((arg_34_1 - 1) / arg_34_0.memoryGroupsGrid.constraintCount) + arg_34_0.memoryGroupList.paddingFront) / ((arg_34_0.memoryGroupsGrid.cellSize.y + arg_34_0.memoryGroupsGrid.spacing.y) * math.ceil(#arg_34_0.searchGroupList / arg_34_0.memoryGroupsGrid.constraintCount) - arg_34_0.memoryGroupViewport.rect.height)
		var_34_0 = Mathf.Clamp01(var_34_0)
	end

	return var_34_0
end

function var_0_0.GetMatchGroupList(arg_35_0, arg_35_1, arg_35_2)
	if not noEmptyStr(arg_35_1) then
		return underscore.to_array(arg_35_0.memoryGroups)
	end

	arg_35_1 = string.lower(string.gsub(arg_35_1, "%.", "%%."))

	for iter_35_0, iter_35_1 in pairs(arg_35_0.memoryGroups) do
		if string.find(string.lower(iter_35_1.title), arg_35_1) then
			table.insert({}, iter_35_1)
		elseif string.find(string.lower((ShipGroup.getDefaultShipNameByGroupID(iter_35_1.ship_group))), arg_35_1) then
			table.insert({}, iter_35_1)
		end
	end

	return {}
end

function var_0_0.UpdateFilterBtn(arg_36_0)
	setActive(arg_36_0._tf:Find("ActivityToggle/btn/active"), arg_36_0.contextData.indexDatas and (arg_36_0.contextData.indexDatas.sortIndex ~= ShipIndexConst.SortDefault or arg_36_0.contextData.indexDatas.typeIndex ~= ShipIndexConst.TypeAll or arg_36_0.contextData.indexDatas.campIndex ~= ShipIndexConst.CampAll or arg_36_0.contextData.indexDatas.progressIndex ~= ShipIndexConst.All))

	return
end

function var_0_0.UpdateView(arg_37_0)
	return
end

return var_0_0
