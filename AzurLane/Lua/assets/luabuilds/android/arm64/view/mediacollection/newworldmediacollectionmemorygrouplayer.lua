class = var_0_10000

local var_0_0 = "NewWorldMediaCollectionMemoryGroupLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".WorldMediaCollectionSubLayer"))

var_0_1.Role = 3
var_0_1.FORM_MODE = 1
var_0_1.LINE_MODE = -1
var_0_1.index = -1
var_0_1.sort = false

function var_0_1.getUIName(arg_1_0)
	return "NewWorldMediaCollectionMemoryGroupUI"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	assert = var_1

	var_1(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)

	underscore = var_1
	pg = var_3

	local var_2_0 = var_1(var_3.memory_group.all)
	local var_2_1 = var_1.chain(var_2_0)
	local var_2_2 = var_1.map(var_2_1, function(arg_3_0)
		pg = var_2_10001

		return var_2_10001.memory_group[arg_3_0]
	end)
	local var_2_3 = var_1.filter(var_2_2, function(arg_4_0)
		return arg_4_0.type == var_0_1.Role
	end)

	arg_2_0.baseMemoryGroups = var_1.value(var_2_3)
	underscore = var_1
	arg_2_0.memoryGroups = var_1.to_array(arg_2_0.baseMemoryGroups)

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "GroupRect")

	arg_2_0.memoryGroupList = var_1.GetComponent(var_2_5, "LScrollRect")

	function arg_2_0.memoryGroupList.onInitItem(arg_5_0)
		local var_5_0 = arg_2_0

		var_1.onInitMemoryGroup(var_5_0, arg_5_0)

		return
	end

	function arg_2_0.memoryGroupList.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0

		var_2.onUpdateMemoryGroup(var_6_0, arg_6_0 + 1, arg_6_1)

		return
	end

	arg_2_0.memoryGroupInfos = {}
	tf = var_1

	local var_2_6 = var_1(arg_2_0.memoryGroupList)
	local var_2_7 = var_1.Find(var_2_6, "GroupItem")

	setActive = var_2

	var_2(var_2_7, false)

	tf = var_2

	local var_2_8 = var_2(arg_2_0.memoryGroupList)

	arg_2_0.memoryGroupViewport = var_2.Find(var_2_8, "Viewport")
	tf = var_2

	local var_2_9 = var_2(arg_2_0.memoryGroupList)
	local var_2_10 = var_2.Find(var_2_9, "Viewport/Content")
	local var_2_11 = var_2.GetComponent

	typeof = var_5
	GridLayoutGroup = var_1_10007
	arg_2_0.memoryGroupsGrid = var_2_11(var_2_10, var_5(var_1_10007))
	AutoLoader = var_2
	arg_2_0.loader = var_2.New()

	local var_2_12 = arg_2_0._tf

	arg_2_0.searchBtn = var_2.Find(var_2_12, "ActivityToggle/search_btn/btn")

	local var_2_13 = arg_2_0._tf

	arg_2_0.nameSearchInput = var_2.Find(var_2_13, "ActivityToggle/search_btn/search")

	local var_2_14 = arg_2_0._tf

	arg_2_0.closeSearch = var_2.Find(var_2_14, "ActivityToggle/search_btn/icon")
	setText = var_2

	local var_2_15 = arg_2_0.searchBtn
	local var_2_16 = var_4.Find(var_2_15, "label")

	i18n = var_5

	var_2(var_2_16, var_5("storyline_memorysearch2"))

	onButton = var_2

	var_2(arg_2_0, arg_2_0.searchBtn, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.nameSearchInput, true)

		setActive = var_2_10000

		var_2_10000(arg_2_0.searchBtn, false)

		setText = var_2_10000

		local var_7_0 = arg_2_0.nameSearchInput
		local var_7_1 = var_2.Find(var_7_0, "holder")

		i18n = var_3

		var_2_10000(var_7_1, var_3("storyline_memorysearch1"))

		arg_2_0.searchOpen = true

		return
	end)

	onButton = var_2

	var_2(arg_2_0, arg_2_0.closeSearch, function()
		if arg_2_0.searchOpen then
			setActive = var_0

			var_0(arg_2_0.nameSearchInput, false)

			setActive = var_0

			var_0(arg_2_0.searchBtn, true)

			setText = var_0

			local var_8_0 = arg_2_0.searchBtn
			local var_8_1 = var_2.Find(var_8_0, "label")

			i18n = var_3

			var_0(var_8_1, var_3("storyline_memorysearch2"))
		else
			triggerButton = var_0

			var_0(arg_2_0.searchBtn)
		end

		return
	end)

	setInputText = var_2

	var_2(arg_2_0.nameSearchInput, "")

	onInputChanged = var_2

	var_2(arg_2_0, arg_2_0.nameSearchInput, function()
		local var_9_0 = arg_2_0

		var_0.searchFilter(var_9_0)

		return
	end)

	onButton = var_2

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0._tf

	var_2(var_2_17, var_5.Find(var_2_18, "ActivityToggle/search/up"), function()
		local var_10_0 = arg_2_0

		var_10_0.selectAsc = false
		setActive = var_10_0

		local var_10_1 = arg_2_0._tf

		var_10_0(var_2.Find(var_10_1, "ActivityToggle/search/up"), arg_2_0.selectAsc)

		setActive = var_10_0

		local var_10_2 = arg_2_0._tf

		var_10_0(var_2.Find(var_10_2, "ActivityToggle/search/below"), not arg_2_0.selectAsc)

		local var_10_3 = arg_2_0

		var_0.searchFilter(var_10_3)

		return
	end)

	onButton = var_2

	local var_2_19 = arg_2_0
	local var_2_20 = arg_2_0._tf

	var_2(var_2_19, var_5.Find(var_2_20, "ActivityToggle/search/below"), function()
		local var_11_0 = arg_2_0

		var_11_0.selectAsc = true
		setActive = var_11_0

		local var_11_1 = arg_2_0._tf

		var_11_0(var_2.Find(var_11_1, "ActivityToggle/search/up"), arg_2_0.selectAsc)

		setActive = var_11_0

		local var_11_2 = arg_2_0._tf

		var_11_0(var_2.Find(var_11_2, "ActivityToggle/search/below"), not arg_2_0.selectAsc)

		local var_11_3 = arg_2_0

		var_0.searchFilter(var_11_3)

		return
	end)

	onButton = var_2

	local var_2_21 = arg_2_0
	local var_2_22 = arg_2_0._tf

	var_2(var_2_21, var_5.Find(var_2_22, "ActivityToggle/btn"), function()
		local var_12_0 = {}

		Clone = var_2_10001
		var_12_0.indexDatas = var_2_10001(arg_2_0.contextData.indexDatas)

		local var_12_1 = {
			minHeight = 650
		}
		local var_12_2 = {
			isSort = true
		}

		CustomIndexLayer = var_3
		var_12_2.mode = var_3.Mode.OR
		ShipIndexConst = var_3
		var_12_2.options = var_3.SortRoleStory
		ShipIndexConst = var_3
		var_12_2.names = var_3.SortRoleStoryName
		var_12_1.sortIndex = var_12_2

		local var_12_3 = {
			blueSeleted = true
		}

		CustomIndexLayer = var_3
		var_12_3.mode = var_3.Mode.AND
		ShipIndexConst = var_3
		var_12_3.options = var_3.RoleProgress
		ShipIndexConst = var_3
		var_12_3.names = var_3.RoleProgressName
		var_12_1.progressIndex = var_12_3

		local var_12_4 = {
			blueSeleted = true
		}

		CustomIndexLayer = var_3
		var_12_4.mode = var_3.Mode.AND
		ShipIndexConst = var_3
		var_12_4.options = var_3.TypeIndexs
		ShipIndexConst = var_3
		var_12_4.names = var_3.TypeNames
		var_12_1.typeIndex = var_12_4

		local var_12_5 = {
			blueSeleted = true
		}

		CustomIndexLayer = var_3
		var_12_5.mode = var_3.Mode.AND
		ShipIndexConst = var_3
		var_12_5.options = var_3.CampIndexs
		ShipIndexConst = var_3
		var_12_5.names = var_3.CampNames
		var_12_1.campIndex = var_12_5
		Vector2 = var_12_5
		var_12_1.layoutPos = var_12_5(0, -25)
		var_12_0.customPanels = var_12_1
		var_12_0.groupList = {
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
		}

		function var_12_0.callback(arg_13_0)
			arg_2_0.sortIndex = arg_13_0.sortIndex
			arg_2_0.typeIndex = arg_13_0.typeIndex
			arg_2_0.campIndex = arg_13_0.campIndex
			arg_2_0.progressIndex = arg_13_0.progressIndex

			local var_13_0 = arg_2_0

			var_1.updateIndexDatas(var_13_0)

			local var_13_1 = arg_2_0

			var_1.filterCommon(var_13_1)

			local var_13_2 = arg_2_0

			var_1.searchFilter(var_13_2)

			local var_13_3 = arg_2_0

			var_1.UpdateFilterBtn(var_13_3)

			return
		end

		Context = var_1

		local var_12_6 = var_1.New
		local var_12_7 = {}

		CustomIndexMediator = var_4
		var_12_7.mediator = var_4
		RoleStoryCustomIndexLayer = var_4
		var_12_7.viewComponent = var_4
		var_12_7.data = var_12_0

		local var_12_8 = var_12_6(var_12_7)
		local var_12_9 = arg_2_0
		local var_12_10 = var_2.emit

		WorldMediaCollectionMediator = var_5

		var_12_10(var_12_9, var_5.ON_ADD_SUBLAYER, var_12_8)

		return
	end)

	local var_2_23 = arg_2_0._tf

	arg_2_0.HallGloryTF = var_2.Find(var_2_23, "HonorBtn")
	onButton = var_2

	var_2(arg_2_0, arg_2_0.HallGloryTF, function()
		arg_2_0.index = 2

		local var_14_0 = arg_2_0.viewParent

		var_0.ShowHallGloryLayer(var_14_0)

		return
	end)

	local var_2_24

	if arg_2_0.contextData.indexDatas then
		var_2_24 = arg_2_0.contextData
		var_2_24.indexDatas = nil
	end

	triggerButton = var_2_24

	local var_2_25 = arg_2_0._tf

	var_2_24(var_4.Find(var_2_25, "ActivityToggle/search/below"))
	arg_2_0:UpdateFilterBtn()

	return
end

function var_0_1.updateIndexDatas(arg_15_0)
	local var_15_0 = arg_15_0.contextData
	local var_15_1

	if not arg_15_0.contextData.indexDatas then
		var_15_1 = {}
	end

	var_15_0.indexDatas = var_15_1
	arg_15_0.contextData.indexDatas.sortIndex = arg_15_0.sortIndex
	arg_15_0.contextData.indexDatas.typeIndex = arg_15_0.typeIndex
	arg_15_0.contextData.indexDatas.campIndex = arg_15_0.campIndex
	arg_15_0.contextData.indexDatas.progressIndex = arg_15_0.progressIndex

	return
end

function var_0_1.filterCommon(arg_16_0)
	local var_16_0 = arg_16_0.sortIndex

	arg_16_0.GroupList = {}
	arg_16_0.memoryGroups = {}

	if not arg_16_0.shipDic then
		arg_16_0.shipDic = {}
		ipairs = var_2

		for iter_16_0, iter_16_1 in var_2(arg_16_0.baseMemoryGroups) do
			if iter_16_1.ship_group ~= 0 then
				ShipGroup = var_1_10007
				var_1_10007 = var_1_10007.getDefaultShipConfig(iter_16_1.ship_group)

				local var_16_1 = arg_16_0.shipDic
				local var_16_2 = iter_16_1.id

				Ship = var_1_10010
				var_16_1[var_16_2] = var_1_10010.New({
					configId = var_1_10007.id
				})
			end
		end
	end

	ipairs = var_2

	for iter_16_2, iter_16_3 in var_2(arg_16_0.baseMemoryGroups) do
		assert = var_1_10007

		var_1_10007(iter_16_3.ship_group ~= 0, "MemoryGroup " .. iter_16_3.id .. " missing ship group")

		var_1_10007 = arg_16_0.shipDic[iter_16_3.id]
		ShipIndexConst = var_8

		if var_8.filterByType(var_1_10007, arg_16_0.typeIndex) then
			ShipIndexConst = var_8

			if var_8.filterByCamp(var_1_10007, arg_16_0.campIndex) then
				ShipIndexConst = var_8

				if var_8.filterRoleProgressBar(iter_16_3, arg_16_0.progressIndex) then
					table = var_8

					var_8.insert(arg_16_0.memoryGroups, iter_16_3)
				end
			end
		end
	end

	ShipIndexConst = var_2

	if var_2.getSortName(var_16_0) == 1 then
		-- block empty
	elseif var_2 == 2 then
		table = var_3

		local var_16_3 = var_3.sort
		local var_16_4 = arg_16_0.memoryGroups

		CompareFuncs = iter_16_3

		var_16_3(var_16_4, iter_16_3({
			function(arg_17_0)
				local var_17_0 = arg_16_0
				local var_17_1, var_17_2 = var_1.OnSchedule(var_17_0, arg_17_0)

				return var_17_1 / var_17_2
			end,
			function(arg_18_0)
				return arg_18_0.id
			end
		}))
	end

	return
end

function var_0_1.StoryLineBtnSetActive(arg_19_0, arg_19_1)
	setActive = var_1_10002

	var_1_10002(arg_19_0.storyLineEntranceBtn, arg_19_1)

	setActive = var_1_10002

	var_1_10002(arg_19_0.storyLineHideBtn, arg_19_1)

	setActive = var_1_10002

	local var_19_0 = arg_19_0._tf

	var_1_10002(var_4.Find(var_19_0, "StoryLineBtn/on"), not arg_19_1)

	return
end

function var_0_1.Hide(arg_20_0)
	var_0_1.super.Hide(arg_20_0)

	return
end

function var_0_1.GetCurrentMode(arg_21_0)
	return arg_21_0.currentMode
end

function var_0_1.OnLockRole(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1

	getProxy = var_1_10003
	BayProxy = var_1_10005

	local var_22_1 = var_1_10003(var_1_10005)
	local var_22_2 = false
	local var_22_3 = var_22_1:getShips()

	ipairs = var_1_10006

	for iter_22_0, iter_22_1 in var_1_10006(var_22_3) do
		tonumber = var_1_10011
		var_1_10011 = var_1_10011(iter_22_1:getGroupId())
		tonumber = var_1_10012

		if var_1_10011 == var_1_10012(var_22_0.ship_group) then
			var_22_2 = true

			break
		end
	end

	return var_22_2
end

function var_0_1.OnSchedule(arg_23_0, arg_23_1)
	local var_23_0 = #arg_23_1.memories

	_ = var_1_10004

	return var_1_10004.reduce(var_2.memories, 0, function(arg_24_0, arg_24_1)
		pg = var_2_10002

		if var_2_10002.memory_template[arg_24_1].is_open ~= 1 then
			pg = var_3

			local var_24_0 = var_3.NewStoryMgr.GetInstance()

			if var_3.IsPlayed(var_24_0, var_2.unlock_pre, true) then
				arg_24_0 = arg_24_0 + 1
			end

			return arg_24_0
		end
	end), var_23_0
end

function var_0_1.MemoryFilter(arg_25_0)
	arg_25_0:searchFilter()

	return
end

function var_0_1.searchFilter(arg_26_0)
	getInputText = var_1_10001

	local var_26_0 = var_1_10001(arg_26_0.nameSearchInput)

	arg_26_0.searchGroupList = arg_26_0:GetMatchGroupList(var_26_0)

	if not arg_26_0.selectAsc then
		underscore = var_2
		arg_26_0.searchGroupList = var_2.reverse(arg_26_0.searchGroupList)
	end

	local var_26_1 = arg_26_0.memoryGroupList

	var_2.SetTotalCount(var_26_1, #arg_26_0.searchGroupList, 0)

	return
end

function var_0_1.Show(arg_27_0)
	var_0_1.super.Show(arg_27_0)

	arg_27_0.index = -1

	return
end

function var_0_1.onInitMemoryGroup(arg_28_0, arg_28_1)
	if arg_28_0.exited then
		return
	end

	onButton = var_2

	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_1

	local function var_28_2()
		arg_28_0.index = 1

		if arg_28_0.memoryGroupInfos[arg_28_1] then
			getProxy = var_1
			PlayerProxy = var_2_10003

			local var_29_0 = var_1(var_2_10003)
			local var_29_1 = var_1.getRawData(var_29_0).id

			PlayerPrefs = var_2_10002

			var_2_10002.DeleteKey("MEMORY_GROUP_NOTIFICATION" .. var_29_1 .. " " .. var_0.id)

			local var_29_2 = arg_28_0.viewParent

			var_2.ShowSubMemories(var_29_2, var_0)
		end

		return
	end

	SOUND_BACK = var_1_10007

	var_2(var_28_0, var_28_1, var_28_2, var_1_10007)

	return
end

function var_0_1.onUpdateMemoryGroup(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0.exited then
		return
	end

	getProxy = var_3
	CollectionProxy = var_1_10005

	local var_30_0 = var_3(var_1_10005)
	local var_30_1 = arg_30_0.searchGroupList[arg_30_1]

	assert = var_1_10005

	var_1_10005(var_30_1, "MemoryGroup Missing Config Index " .. arg_30_1)

	arg_30_0.memoryGroupInfos[arg_30_2] = var_30_1

	local var_30_2 = #var_30_1.memories

	_ = var_1_10006

	local var_30_3 = var_1_10006.reduce(var_30_1.memories, 0, function(arg_31_0, arg_31_1)
		pg = var_2_10002

		if var_2_10002.memory_template[arg_31_1].is_open ~= 1 then
			pg = var_3

			local var_31_0 = var_3.NewStoryMgr.GetInstance()

			if var_3.IsPlayed(var_31_0, var_2.unlock_pre, true) then
				arg_31_0 = arg_31_0 + 1
			end

			return arg_31_0
		end
	end)

	getProxy = var_7
	PlayerProxy = var_9

	local var_30_4 = var_7(var_9)
	local var_30_5 = var_7.getRawData(var_30_4).id

	PlayerPrefs = var_8

	local var_30_6

	var_30_6 = var_8.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_30_5 .. " " .. var_30_1.id, 0) == 1
	tobool = var_30_4

	local var_30_7 = var_30_4(var_30_0 and var_30_0.shipGroups[var_30_1.ship_group]) or var_30_3 > 0

	setActive = var_11
	tf = var_13

	local var_30_8 = var_13(arg_30_2)

	var_11(var_13.Find(var_30_8, "on"), var_30_7)

	setActive = var_11
	tf = var_13

	local var_30_9 = var_13(arg_30_2)

	var_11(var_13.Find(var_30_9, "off"), not var_30_7)

	local var_30_10 = var_30_3 == 0 and var_9 and var_30_1.id ~= 501

	setActive = var_12
	tf = var_14

	local var_30_11 = var_14(arg_30_2)

	var_12(var_14.Find(var_30_11, "Tip"), var_30_10)

	setActive = var_12
	tf = var_14

	local var_30_12 = var_14(arg_30_2)

	var_12(var_14.Find(var_30_12, "on/get"), var_30_10)

	setActive = var_12
	tf = var_14

	local var_30_13 = var_14(arg_30_2)

	var_12(var_14.Find(var_30_13, "on/title_get"), var_30_10)

	setText = var_12
	tf = var_14

	local var_30_14 = var_14(arg_30_2)

	var_12(var_14.Find(var_30_14, "on/title"), var_30_1.title)

	setText = var_12
	tf = var_14

	local var_30_15 = var_14(arg_30_2)
	local var_30_16 = var_14.Find(var_30_15, "off/title")

	i18n = var_15

	var_12(var_30_16, var_15("memory_filter_option_6"))

	setText = var_12
	tf = var_30_16

	local var_30_17 = var_30_16(arg_30_2)
	local var_30_18 = var_14.Find(var_30_17, "on/title_get/title")

	i18n = var_15

	var_12(var_30_18, var_15("memory_filter_option_4"))

	setText = var_12
	tf = var_30_18

	local var_30_19 = var_30_18(arg_30_2)

	var_12(var_14.Find(var_30_19, "on/count"), var_30_3 .. "/" .. var_30_2)

	local var_30_20 = arg_30_0.loader
	local var_30_21 = var_12.GetSpriteQuiet
	local var_30_22 = "memoryicon/" .. var_30_1.icon
	local var_30_23 = ""

	tf = var_17

	local var_30_24 = var_17(arg_30_2)

	var_30_21(var_30_20, var_30_22, var_30_23, var_17.Find(var_30_24, "on/BG"))

	local var_30_25 = arg_30_0.loader
	local var_30_26 = var_12.GetSpriteQuiet
	local var_30_27 = "memoryicon/" .. var_30_1.icon
	local var_30_28 = ""

	tf = var_17

	local var_30_29 = var_17(arg_30_2)

	var_30_26(var_30_25, var_30_27, var_30_28, var_17.Find(var_30_29, "off/BG"))

	return
end

function var_0_1.Return2MemoryGroup(arg_32_0)
	if not arg_32_0.contextData.memoryGroup or arg_32_0:GetCurrentMode() == var_0_1.LINE_MODE then
		return
	end

	local var_32_0 = 0

	ipairs = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10003(arg_32_0.searchGroupList) do
		if iter_32_1.id == var_1 then
			var_32_0 = iter_32_0

			break
		end
	end

	setInputText = var_3

	var_3(arg_32_0.nameSearchInput, "")

	local var_32_1 = arg_32_0:GetIndexRatio(var_32_0)
	local var_32_2 = arg_32_0.memoryGroupList

	var_4.SetTotalCount(var_32_2, #arg_32_0.searchGroupList, var_32_1)

	return
end

function var_0_1.SwitchReddotMemory(arg_33_0)
	local var_33_0 = 0

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_33_1 = var_1_10002(var_1_10004)
	local var_33_2 = var_2.getRawData(var_33_1).id

	ipairs = var_1_10003

	for iter_33_0, iter_33_1 in var_1_10003(arg_33_0.searchGroupList) do
		PlayerPrefs = var_1_10008

		if var_1_10008.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_33_2 .. " " .. iter_33_1.id, 0) == 1 then
			var_33_0 = iter_33_0

			break
		end
	end

	if var_33_0 == 0 then
		return
	end

	local var_33_3 = arg_33_0:GetIndexRatio(var_33_0)
	local var_33_4 = arg_33_0.memoryGroupList

	var_4.SetTotalCount(var_33_4, #arg_33_0.searchGroupList, var_33_3)

	return
end

function var_0_1.GetIndexRatio(arg_34_0, arg_34_1)
	local var_34_0 = 0

	if arg_34_1 > 0 then
		local var_34_1 = arg_34_0.memoryGroupList
		local var_34_2 = arg_34_0.memoryGroupsGrid.cellSize.y + arg_34_0.memoryGroupsGrid.spacing.y
		local var_34_3 = arg_34_0.memoryGroupsGrid.constraintCount

		math = var_1_10006

		local var_34_4 = var_34_2 * var_1_10006.ceil(#arg_34_0.searchGroupList / var_34_3)

		math = var_1_10007
		var_34_0 = (var_34_2 * var_1_10007.floor((arg_34_1 - 1) / var_34_3) + var_34_1.paddingFront) / (var_34_4 - arg_34_0.memoryGroupViewport.rect.height)
		Mathf = var_7
		var_34_0 = var_7.Clamp01(var_34_0)
	end

	return var_34_0
end

function var_0_1.GetMatchGroupList(arg_35_0, arg_35_1, arg_35_2)
	noEmptyStr = var_1_10003

	if not var_1_10003(arg_35_1) then
		underscore = var_3

		return var_3.to_array(arg_35_0.memoryGroups)
	end

	string = var_3

	local var_35_0 = var_3.lower

	string = var_5
	arg_35_1 = var_35_0(var_5.gsub(arg_35_1, "%.", "%%."))

	local var_35_1 = {}

	pairs = var_1_10004

	for iter_35_0, iter_35_1 in var_1_10004(arg_35_0.memoryGroups) do
		string = var_35_2

		local var_35_2 = var_35_2.find

		string = var_1_10011

		if var_35_2(var_1_10011.lower(iter_35_1.title), arg_35_1) then
			table = var_35_2

			var_35_2.insert(var_35_1, iter_35_1)
		else
			ShipGroup = var_35_2
			var_35_2 = var_35_2.getDefaultShipNameByGroupID(iter_35_1.ship_group)
			string = var_1_10010
			var_1_10010 = var_1_10010.find
			string = var_12

			if var_1_10010(var_12.lower(var_35_2), arg_35_1) then
				table = var_1_10010

				var_1_10010.insert(var_35_1, iter_35_1)
			end
		end
	end

	return var_35_1
end

function var_0_1.UpdateFilterBtn(arg_36_0)
	if arg_36_0.contextData.indexDatas then
		::label_36_0::

		var_1_10002 = var_1.sortIndex
		ShipIndexConst = var_1_10003

		if var_1_10002 == var_1_10003.SortDefault then
			var_1_10002 = var_1.typeIndex
			ShipIndexConst = var_1_10003

			if var_1_10002 == var_1_10003.TypeAll then
				var_1_10002 = var_1.campIndex
				ShipIndexConst = var_1_10003

				if var_1_10002 == var_1_10003.CampAll then
					var_1_10002 = var_1.progressIndex
					ShipIndexConst = var_1_10003

					if var_1_10002 == var_1_10003.All then
						var_1_10002 = false

						goto label_36_1
					end
				end
			end
		end

		var_1_10002 = true
	end

	::label_36_1::

	setActive = var_1_10003

	local var_36_0 = arg_36_0._tf

	var_1_10003(var_5.Find(var_36_0, "ActivityToggle/btn/active"), var_1_10002)

	return
end

function var_0_1.UpdateView(arg_37_0)
	return
end

return var_0_1
