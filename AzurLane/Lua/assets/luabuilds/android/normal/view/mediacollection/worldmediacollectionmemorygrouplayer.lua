class = var_0_10000

local var_0_0 = "WorldMediaCollectionMemoryGroupLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WorldMediaCollectionSubLayer"))

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionMemoryGroupUI"
end

var_0_1.PAGE_ACTIVITY = 2
var_0_1.FORM_MODE = 1
var_0_1.LINE_MODE = -1

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	assert = var_1

	var_1(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)

	_ = var_1

	local var_2_0 = var_1.map

	pg = var_2
	arg_2_0.memoryGroups = var_2_0(var_2.memory_group.all, function(arg_3_0)
		pg = var_2_10001

		return var_2_10001.memory_group[arg_3_0]
	end)

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "GroupRect")

	arg_2_0.memoryGroupList = var_1.GetComponent(var_2_2, "LScrollRect")

	function arg_2_0.memoryGroupList.onInitItem(arg_4_0)
		local var_4_0 = arg_2_0

		var_1.onInitMemoryGroup(var_4_0, arg_4_0)

		return
	end

	function arg_2_0.memoryGroupList.onUpdateItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		var_2.onUpdateMemoryGroup(var_5_0, arg_5_0 + 1, arg_5_1)

		return
	end

	arg_2_0.memoryGroupInfos = {}
	tf = var_1

	local var_2_3 = var_1(arg_2_0.memoryGroupList)
	local var_2_4 = var_1.Find(var_2_3, "GroupItem")

	setActive = var_2_3

	var_2_3(var_2_4, false)

	tf = var_2_3

	local var_2_5 = var_2_3(arg_2_0.memoryGroupList)

	arg_2_0.memoryGroupViewport = var_2.Find(var_2_5, "Viewport")
	tf = var_2

	local var_2_6 = var_2(arg_2_0.memoryGroupList)
	local var_2_7 = var_2.Find(var_2_6, "Viewport/Content")
	local var_2_8 = var_2.GetComponent

	typeof = var_4
	GridLayoutGroup = var_1_10005
	arg_2_0.memoryGroupsGrid = var_2_8(var_2_7, var_4(var_1_10005))

	local var_2_9 = arg_2_0._tf

	arg_2_0.memoryTogGroup = var_2.Find(var_2_9, "Toggles")
	setActive = var_2

	var_2(arg_2_0.memoryTogGroup, true)

	arg_2_0.memoryToggles = {}

	for iter_2_0 = 0, 3 do
		local var_2_10 = arg_2_0.memoryToggles

		var_1_10007 = iter_2_0 + 1

		local var_2_11 = arg_2_0.memoryTogGroup

		var_2_10[var_1_10007] = var_1_10008.Find(var_2_11, iter_2_0)
	end

	arg_2_0.memoryFilterIndex = {
		true,
		true,
		false
	}

	local var_2_12 = arg_2_0._tf

	arg_2_0.groupToggle = var_2.Find(var_2_12, "ActivityToggle")

	local var_2_13 = arg_2_0._tf

	arg_2_0.memoryActivityTogGroup = var_2.Find(var_2_13, "ActivityToggle/ActivityBar")
	setActive = var_2

	var_2(arg_2_0.memoryActivityTogGroup, true)

	arg_2_0.memoryActivityToggles = {}

	for iter_2_1 = 0, 3 do
		local var_2_14 = arg_2_0.memoryActivityToggles

		var_1_10007 = iter_2_1 + 1

		local var_2_15 = arg_2_0.memoryActivityTogGroup

		var_2_14[var_1_10007] = var_1_10008.Find(var_2_15, iter_2_1)
	end

	arg_2_0.activityFilter = 0

	arg_2_0:UpdateActivityBar()

	ipairs = var_2

	for iter_2_2, iter_2_3 in var_2(arg_2_0.memoryActivityToggles) do
		onButton = var_1_10007
		var_1_10008 = arg_2_0

		local var_2_16 = iter_2_3

		local function var_2_17()
			if iter_2_2 == arg_2_0.activityFilter then
				arg_2_0.activityFilter = 0
			elseif iter_2_2 ~= arg_2_0.activityFilter then
				arg_2_0.activityFilter = iter_2_2
			end

			local var_6_0 = arg_2_0

			var_0.UpdateActivityBar(var_6_0)

			local var_6_1 = arg_2_0

			var_0.MemoryFilter(var_6_1)

			return
		end

		SFX_UI_TAG = var_1_10011

		var_1_10007(var_1_10008, var_2_16, var_2_17, var_1_10011)
	end

	setText = var_2

	local var_2_18 = arg_2_0.memoryActivityToggles[1]
	local var_2_19 = var_3.Find(var_2_18, "Image1/Text")

	i18n = var_2_18

	var_2(var_2_19, var_2_18("memory_actiivty_ex"))

	setText = var_2

	local var_2_20 = arg_2_0.memoryActivityToggles[1]
	local var_2_21 = var_3.Find(var_2_20, "Image2/Text")

	i18n = var_2_20

	var_2(var_2_21, var_2_20("memory_actiivty_ex"))

	setText = var_2

	local var_2_22 = arg_2_0.memoryActivityToggles[2]
	local var_2_23 = var_3.Find(var_2_22, "Image1/Text")

	i18n = var_2_22

	var_2(var_2_23, var_2_22("memory_activity_sp"))

	setText = var_2

	local var_2_24 = arg_2_0.memoryActivityToggles[2]
	local var_2_25 = var_3.Find(var_2_24, "Image2/Text")

	i18n = var_2_24

	var_2(var_2_25, var_2_24("memory_activity_sp"))

	setText = var_2

	local var_2_26 = arg_2_0.memoryActivityToggles[3]
	local var_2_27 = var_3.Find(var_2_26, "Image1/Text")

	i18n = var_2_26

	var_2(var_2_27, var_2_26("memory_activity_daily"))

	setText = var_2

	local var_2_28 = arg_2_0.memoryActivityToggles[3]
	local var_2_29 = var_3.Find(var_2_28, "Image2/Text")

	i18n = var_2_28

	var_2(var_2_29, var_2_28("memory_activity_daily"))

	setText = var_2

	local var_2_30 = arg_2_0.memoryActivityToggles[4]
	local var_2_31 = var_3.Find(var_2_30, "Image1/Text")

	i18n = var_2_30

	var_2(var_2_31, var_2_30("memory_activity_others"))

	setText = var_2

	local var_2_32 = arg_2_0.memoryActivityToggles[4]
	local var_2_33 = var_3.Find(var_2_32, "Image2/Text")

	i18n = var_2_32

	var_2(var_2_33, var_2_32("memory_activity_others"))

	local var_2_34 = arg_2_0.contextData
	local var_2_35

	if not arg_2_0.contextData.toggle then
		var_2_35 = 1
	end

	var_2_34.toggle = var_2_35

	local var_2_36 = arg_2_0.contextData.toggle

	triggerToggle = var_2_35

	var_2_35(arg_2_0.memoryToggles[var_2_36], true)
	arg_2_0:SwitchMemoryFilter(var_2_36)

	ipairs = var_3

	for iter_2_4, iter_2_5 in var_3(arg_2_0.memoryToggles) do
		onToggle = var_1_10008

		local var_2_37 = arg_2_0
		local var_2_38 = iter_2_5

		local function var_2_39(arg_7_0)
			if not arg_7_0 then
				return
			end

			local var_7_0 = arg_2_0

			var_1.SwitchMemoryFilter(var_7_0, iter_2_4)

			local var_7_1 = arg_2_0

			var_1.MemoryFilter(var_7_1)

			return
		end

		SFX_UI_TAG = var_1_10012

		var_1_10008(var_2_37, var_2_38, var_2_39, var_1_10012)
	end

	local var_2_40 = arg_2_0
	local var_2_41 = arg_2_0.OverlayPanel
	local var_2_42 = arg_2_0.memoryTogGroup
	local var_2_43 = {}

	LayerWeightConst = iter_2_5
	var_2_43.overlayType = iter_2_5.OVERLAY_UI_ADAPT

	var_2_41(var_2_40, var_2_42, var_2_43)

	AutoLoader = var_2_41
	arg_2_0.loader = var_2_41.New()

	local var_2_44 = arg_2_0._tf

	arg_2_0.searchBtn = var_3.Find(var_2_44, "ActivityToggle/search_btn/btn")

	local var_2_45 = arg_2_0._tf

	arg_2_0.nameSearchInput = var_3.Find(var_2_45, "ActivityToggle/search_btn/search")

	local var_2_46 = arg_2_0._tf

	arg_2_0.closeSearch = var_3.Find(var_2_46, "ActivityToggle/search_btn/icon")
	setText = var_3

	local var_2_47 = arg_2_0.searchBtn
	local var_2_48 = var_4.Find(var_2_47, "label")

	i18n = var_2_47

	var_3(var_2_48, var_2_47("storyline_memorysearch2"))

	onButton = var_3

	var_3(arg_2_0, arg_2_0.searchBtn, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.nameSearchInput, true)

		setActive = var_2_10000

		var_2_10000(arg_2_0.searchBtn, false)

		setText = var_2_10000

		local var_8_0 = arg_2_0.nameSearchInput
		local var_8_1 = var_1.Find(var_8_0, "holder")

		i18n = var_8_0

		var_2_10000(var_8_1, var_8_0("storyline_memorysearch1"))

		arg_2_0.searchOpen = true

		return
	end)

	onButton = var_3

	var_3(arg_2_0, arg_2_0.closeSearch, function()
		if arg_2_0.searchOpen then
			setActive = var_0

			var_0(arg_2_0.nameSearchInput, false)

			setActive = var_0

			var_0(arg_2_0.searchBtn, true)

			setText = var_0

			local var_9_0 = arg_2_0.searchBtn
			local var_9_1 = var_1.Find(var_9_0, "label")

			i18n = var_9_0

			var_0(var_9_1, var_9_0("storyline_memorysearch2"))
		else
			triggerButton = var_0

			var_0(arg_2_0.searchBtn)
		end

		return
	end)

	setInputText = var_3

	var_3(arg_2_0.nameSearchInput, "")

	onInputChanged = var_3

	var_3(arg_2_0, arg_2_0.nameSearchInput, function()
		local var_10_0 = arg_2_0

		var_0.searchFilter(var_10_0)

		return
	end)
	arg_2_0:MemoryFilter()

	local var_2_49 = arg_2_0._tf

	arg_2_0.rectAnchorX = var_3.Find(var_2_49, "GroupRect").anchoredPosition.x

	arg_2_0:UpdateView()

	local var_2_50 = arg_2_0._tf

	arg_2_0.storyLineBtn = var_3.Find(var_2_50, "StoryLineBtn")

	local var_2_51 = arg_2_0._tf

	arg_2_0.storyLineEntranceBtn = var_3.Find(var_2_51, "StoryLineBtn/entranceBtn")

	local var_2_52 = arg_2_0._tf

	arg_2_0.storyLineHideBtn = var_3.Find(var_2_52, "StoryLineBtn/closeBtn")
	arg_2_0.currentMode = var_0_1.FORM_MODE
	onButton = var_3

	var_3(arg_2_0, arg_2_0.storyLineEntranceBtn, function()
		local var_11_0 = arg_2_0

		var_0.SwitchStoryLineMode(var_11_0, var_0_1.LINE_MODE)

		return
	end)

	onButton = var_3

	var_3(arg_2_0, arg_2_0.storyLineHideBtn, function()
		local var_12_0 = arg_2_0

		var_0.StoryLineBtnSetActive(var_12_0, false)

		return
	end)

	onButton = var_3

	var_3(arg_2_0, arg_2_0.storyLineBtn, function()
		local var_13_0 = arg_2_0

		var_0.StoryLineBtnSetActive(var_13_0, true)

		return
	end)

	local var_2_53 = arg_2_0._tf

	arg_2_0.storylineTF = var_3.Find(var_2_53, "StoryLine")
	WorldMediaCollectionStoryLineView = var_3
	arg_2_0.storyLineView = var_3.New(arg_2_0.storylineTF)

	local function var_2_54(arg_14_0, arg_14_1)
		local var_14_0 = arg_2_0.viewParent

		var_2.ShowSubMemories(var_14_0, arg_14_0, true, arg_14_1)
		var_0_1.super.Hide(arg_2_0)

		return
	end

	local function var_2_55(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_2_0.viewParent.viewParent

		var_3.WarpToRecord(var_15_0, arg_15_0, arg_15_1, arg_15_2)

		return
	end

	local var_2_56 = arg_2_0.storyLineView

	var_5.ConfigCallback(var_2_56, var_2_54, var_2_55)

	return
end

function var_0_1.StoryLineBtnSetActive(arg_16_0, arg_16_1)
	setActive = var_1_10002

	var_1_10002(arg_16_0.storyLineEntranceBtn, arg_16_1)

	setActive = var_1_10002

	var_1_10002(arg_16_0.storyLineHideBtn, arg_16_1)

	setActive = var_1_10002

	local var_16_0 = arg_16_0._tf

	var_1_10002(var_3.Find(var_16_0, "StoryLineBtn/on"), not arg_16_1)

	return
end

function var_0_1.SwitchStoryLineMode(arg_17_0, arg_17_1)
	arg_17_0.currentMode = arg_17_1

	if arg_17_1 == var_0_1.FORM_MODE then
		setActive = var_2

		local var_17_0 = arg_17_0._tf

		var_2(var_3.Find(var_17_0, "GroupRect"), true)

		setActive = var_2

		var_2(arg_17_0.memoryTogGroup, true)

		setActive = var_2

		var_2(arg_17_0.groupToggle, true)

		setActive = var_2

		var_2(arg_17_0.storylineTF, false)

		setActive = var_2

		var_2(arg_17_0.storyLineBtn, true)

		local var_17_1 = arg_17_0.storyLineView

		var_2.closeFilter(var_17_1)
		arg_17_0:MemoryFilter()

		pg = var_2

		local var_17_2 = var_2.BgmMgr.GetInstance()

		var_2.ContinuePlay(var_17_2)
	elseif arg_17_1 == var_0_1.LINE_MODE then
		setActive = var_2

		local var_17_3 = arg_17_0._tf

		var_2(var_3.Find(var_17_3, "GroupRect"), false)

		setActive = var_2

		var_2(arg_17_0.memoryTogGroup, false)

		setActive = var_2

		var_2(arg_17_0.groupToggle, false)

		setActive = var_2

		var_2(arg_17_0.storylineTF, true)

		setActive = var_2

		var_2(arg_17_0.storyLineBtn, false)

		local var_17_4 = arg_17_0.storyLineView

		var_2.refresh(var_17_4)
	end

	return
end

function var_0_1.Show(arg_18_0)
	var_0_1.super.Show(arg_18_0)

	setActive = var_1

	var_1(arg_18_0.memoryTogGroup, arg_18_0.currentMode == var_0_1.FORM_MODE)

	return
end

function var_0_1.Hide(arg_19_0)
	if arg_19_0.currentMode == var_0_1.FORM_MODE then
		setActive = var_1

		var_1(arg_19_0.memoryTogGroup, false)
		var_0_1.super.Hide(arg_19_0)
	else
		arg_19_0:SwitchStoryLineMode(var_0_1.FORM_MODE)
	end

	return
end

function var_0_1.GetCurrentMode(arg_20_0)
	return arg_20_0.currentMode
end

function var_0_1.SwitchMemoryFilter(arg_21_0, arg_21_1)
	if arg_21_1 == 1 then
		arg_21_0.memoryFilterIndex = {
			true,
			true,
			false
		}
	else
		ipairs = var_1_10002

		for iter_21_0 in var_1_10002(arg_21_0.memoryFilterIndex) do
			arg_21_0.memoryFilterIndex[iter_21_0] = arg_21_1 - 1 == iter_21_0
		end

		if arg_21_1 - 1 == var_0_1.PAGE_ACTIVITY then
			arg_21_0.activityFilter = 0

			arg_21_0:UpdateActivityBar()
		end
	end

	return
end

function var_0_1.MemoryFilter(arg_22_0)
	table = var_1_10001

	var_1_10001.clear(arg_22_0.memoryGroups)

	_ = var_1

	local var_22_0 = not var_1.all(arg_22_0.memoryFilterIndex, function(arg_23_0)
		return arg_23_0
	end) and arg_22_0.memoryFilterIndex[var_0_1.PAGE_ACTIVITY]

	ipairs = var_3
	pg = var_1_10004

	for iter_22_0, iter_22_1 in var_3(var_1_10004.memory_group.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.memory_group[iter_22_1]

		if arg_22_0.memoryFilterIndex[var_1_10008.type] then
			if var_22_0 then
				if arg_22_0.activityFilter == 0 or arg_22_0.activityFilter == var_1_10008.subtype then
					table = var_9

					var_9.insert(arg_22_0.memoryGroups, var_1_10008)
				end
			else
				table = var_9

				var_9.insert(arg_22_0.memoryGroups, var_1_10008)
			end
		end
	end

	table = var_3

	var_3.sort(arg_22_0.memoryGroups, function(arg_24_0, arg_24_1)
		return arg_24_0.id < arg_24_1.id
	end)
	arg_22_0:searchFilter()

	setActive = var_3

	var_3(arg_22_0.memoryActivityTogGroup, var_22_0)

	return
end

function var_0_1.searchFilter(arg_25_0)
	getInputText = var_1_10001

	if not var_1_10001(arg_25_0.nameSearchInput) or var_1 == "" then
		arg_25_0.searchGroupList = nil

		local var_25_0 = arg_25_0.memoryGroupList

		var_2.SetTotalCount(var_25_0, #arg_25_0.memoryGroups, 0)
	else
		arg_25_0.searchGroupList = arg_25_0:GetMatchGroupList(var_1)

		local var_25_1 = arg_25_0.memoryGroupList

		var_2.SetTotalCount(var_25_1, #arg_25_0.searchGroupList, 0)
	end

	return
end

function var_0_1.onInitMemoryGroup(arg_26_0, arg_26_1)
	if arg_26_0.exited then
		return
	end

	onButton = var_2

	local var_26_0 = arg_26_0
	local var_26_1 = arg_26_1

	local function var_26_2()
		if arg_26_0.memoryGroupInfos[arg_26_1] then
			getProxy = var_1
			PlayerProxy = var_2_10002

			local var_27_0 = var_1(var_2_10002)
			local var_27_1 = var_1.getRawData(var_27_0).id

			PlayerPrefs = var_27_0

			var_27_0.DeleteKey("MEMORY_GROUP_NOTIFICATION" .. var_27_1 .. " " .. var_0.id)

			local var_27_2 = arg_26_0.viewParent

			var_2.ShowSubMemories(var_27_2, var_0)
		end

		return
	end

	SOUND_BACK = var_1_10006

	var_2(var_26_0, var_26_1, var_26_2, var_1_10006)

	return
end

function var_0_1.onUpdateMemoryGroup(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_0.exited then
		return
	end

	local var_28_0

	if not arg_28_0.searchGroupList or not arg_28_0.searchGroupList[arg_28_1] then
		var_28_0 = arg_28_0.memoryGroups[arg_28_1]
	end

	assert = var_1_10004

	var_1_10004(var_28_0, "MemoryGroup Missing Config Index " .. arg_28_1)

	local var_28_1 = arg_28_0.memoryGroupInfos

	var_28_1[arg_28_2] = var_28_0
	setText = var_28_1
	tf = var_5

	local var_28_2 = var_5(arg_28_2)

	var_28_1(var_5.Find(var_28_2, "title"), var_28_0.title)

	local var_28_3 = arg_28_0.loader
	local var_28_4 = var_4.GetSpriteQuiet
	local var_28_5 = "memoryicon/" .. var_28_0.icon
	local var_28_6 = ""

	tf = var_1_10008

	local var_28_7 = var_1_10008(arg_28_2)

	var_28_4(var_28_3, var_28_5, var_28_6, var_8.Find(var_28_7, "BG"))

	getProxy = var_28_4
	PlayerProxy = var_28_3

	local var_28_8 = var_28_4(var_28_3)
	local var_28_9 = var_4.getRawData(var_28_8).id

	PlayerPrefs = var_28_8

	local var_28_10 = var_28_8.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_28_9 .. " " .. var_28_0.id, 0) == 1

	setActive = var_6
	tf = var_7

	local var_28_11 = var_7(arg_28_2)

	var_6(var_7.Find(var_28_11, "Tip"), var_28_10)

	local var_28_12 = #var_28_0.memories

	_ = var_7

	local var_28_13 = var_7.reduce(var_28_0.memories, 0, function(arg_29_0, arg_29_1)
		pg = var_2_10002

		if var_2_10002.memory_template[arg_29_1].is_open ~= 1 then
			pg = var_3

			local var_29_0 = var_3.NewStoryMgr.GetInstance()

			if var_3.IsPlayed(var_29_0, var_2.unlock_pre, true) then
				arg_29_0 = arg_29_0 + 1
			end

			return arg_29_0
		end
	end)

	setText = var_8
	tf = var_9

	local var_28_14 = var_9(arg_28_2)

	var_8(var_9.Find(var_28_14, "count"), var_28_13 .. "/" .. var_28_12)

	return
end

function var_0_1.Return2MemoryGroup(arg_30_0)
	if arg_30_0.contextData.memoryGroup then
		var_1_10003 = arg_30_0

		if arg_30_0.GetCurrentMode(var_1_10003) == var_0_1.LINE_MODE then
			return
		end

		local var_30_0 = 0

		ipairs = var_1_10003

		for iter_30_0, iter_30_1 in var_1_10003(arg_30_0.memoryGroups) do
			if iter_30_1.id == var_1 then
				var_30_0 = iter_30_0

				break
			end
		end

		setInputText = var_3

		var_3(arg_30_0.nameSearchInput, "")

		local var_30_1 = arg_30_0:GetIndexRatio(var_30_0)
		local var_30_2 = arg_30_0.memoryGroupList

		var_4.SetTotalCount(var_30_2, #arg_30_0.memoryGroups, var_30_1)

		return
	end
end

function var_0_1.SwitchReddotMemory(arg_31_0)
	local var_31_0 = 0

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_31_1 = var_1_10002(var_1_10003)
	local var_31_2 = var_2.getRawData(var_31_1).id

	ipairs = var_31_1

	for iter_31_0, iter_31_1 in var_31_1(arg_31_0.memoryGroups) do
		PlayerPrefs = var_1_10008

		if var_1_10008.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_31_2 .. " " .. iter_31_1.id, 0) == 1 then
			var_31_0 = iter_31_0

			break
		end
	end

	if var_31_0 == 0 then
		return
	end

	setInputText = var_3

	var_3(arg_31_0.nameSearchInput, "")

	local var_31_3 = arg_31_0:GetIndexRatio(var_31_0)
	local var_31_4 = arg_31_0.memoryGroupList

	var_4.SetTotalCount(var_31_4, #arg_31_0.memoryGroups, var_31_3)

	return
end

function var_0_1.GetIndexRatio(arg_32_0, arg_32_1)
	local var_32_0 = 0

	if arg_32_1 > 0 then
		local var_32_1 = arg_32_0.memoryGroupList
		local var_32_2 = arg_32_0.memoryGroupsGrid.cellSize.y + arg_32_0.memoryGroupsGrid.spacing.y
		local var_32_3 = arg_32_0.memoryGroupsGrid.constraintCount

		math = var_1_10006

		local var_32_4 = var_32_2 * var_1_10006.ceil(#arg_32_0.memoryGroups / var_32_3)

		math = var_7
		var_32_0 = (var_32_2 * var_7.floor((arg_32_1 - 1) / var_32_3) + var_32_1.paddingFront) / (var_32_4 - arg_32_0.memoryGroupViewport.rect.height)
		Mathf = var_7
		var_32_0 = var_7.Clamp01(var_32_0)
	end

	return var_32_0
end

function var_0_1.UpdateView(arg_33_0)
	WorldMediaCollectionScene = var_1_10001

	local var_33_0 = var_1_10001.WorldRecordLock()

	setAnchoredPosition = var_1_10002

	local var_33_1 = arg_33_0._tf

	var_1_10002(var_3.Find(var_33_1, "GroupRect"), {
		x = var_33_0 and 0 or arg_33_0.rectAnchorX
	})

	ipairs = var_1_10002

	for iter_33_0, iter_33_1 in var_1_10002(arg_33_0.memoryActivityToggles) do
		setActive = var_1_10007

		local var_33_2 = iter_33_1

		_ = var_1_10009
		var_1_10009 = var_1_10009.any
		pg = var_1_10010

		var_1_10007(var_33_2, var_1_10009(var_1_10010.memory_group.all, function(arg_34_0)
			pg = var_2_10001

			return var_2_10001.memory_group[arg_34_0].subtype == iter_33_0
		end))
	end

	return
end

function var_0_1.UpdateActivityBar(arg_35_0)
	ipairs = var_1_10001

	for iter_35_0, iter_35_1 in var_1_10001(arg_35_0.memoryActivityToggles) do
		local var_35_0 = arg_35_0.activityFilter == iter_35_0

		setActive = var_1_10007

		var_1_10007(iter_35_1:Find("Image1"), not var_35_0)

		setActive = var_1_10007

		var_1_10007(iter_35_1:Find("Image2"), var_35_0)
	end

	return
end

function var_0_1.OnDestroy(arg_36_0)
	var_0_1.super.OnDestroy(arg_36_0)

	local var_36_0 = arg_36_0.storyLineView

	var_1.Dispose(var_36_0)
	arg_36_0:UnOverlayPanel(arg_36_0.memoryTogGroup, arg_36_0._tf)

	return
end

function var_0_1.GetMatchGroupList(arg_37_0, arg_37_1, arg_37_2)
	string = var_1_10003

	local var_37_0 = var_1_10003.lower

	string = var_1_10004
	arg_37_1 = var_37_0(var_1_10004.gsub(arg_37_1, "%.", "%%."))

	local var_37_1 = {}

	pairs = var_4

	for iter_37_0, iter_37_1 in var_4(arg_37_0.memoryGroups) do
		string = var_1_10009
		var_1_10009 = var_1_10009.find
		string = var_1_10010

		if var_1_10009(var_1_10010.lower(iter_37_1.title), arg_37_1) then
			table = var_1_10009

			var_1_10009.insert(var_37_1, iter_37_1)
		end
	end

	return var_37_1
end

return var_0_1
