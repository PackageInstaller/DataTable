local var_0_0 = class("WorldMediaCollectionMemoryGroupLayer", import(".WorldMediaCollectionSubLayer"))

function var_0_0.getUIName(arg_1_0)
	return "WorldMediaCollectionMemoryGroupUI"
end

var_0_0.PAGE_ACTIVITY = 2
var_0_0.FORM_MODE = 1
var_0_0.LINE_MODE = -1

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	assert(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)

	arg_2_0.memoryGroups = _.map(pg.memory_group.all, function(arg_3_0)
		return pg.memory_group[arg_3_0]
	end)
	arg_2_0.memoryGroupList = arg_2_0._tf:Find("GroupRect"):GetComponent("LScrollRect")

	function arg_2_0.memoryGroupList.onInitItem(arg_4_0)
		arg_2_0:onInitMemoryGroup(arg_4_0)

		return
	end

	function arg_2_0.memoryGroupList.onUpdateItem(arg_5_0, arg_5_1)
		arg_2_0:onUpdateMemoryGroup(arg_5_0 + 1, arg_5_1)

		return
	end

	arg_2_0.memoryGroupInfos = {}

	setActive(tf(arg_2_0.memoryGroupList):Find("GroupItem"), false)

	arg_2_0.memoryGroupViewport = tf(arg_2_0.memoryGroupList):Find("Viewport")
	arg_2_0.memoryGroupsGrid = tf(arg_2_0.memoryGroupList):Find("Viewport/Content"):GetComponent(typeof(GridLayoutGroup))
	arg_2_0.memoryTogGroup = arg_2_0._tf:Find("Toggles")

	setActive(arg_2_0.memoryTogGroup, true)

	arg_2_0.memoryToggles = {}

	for iter_2_0 = 0, 3 do
		arg_2_0.memoryToggles[iter_2_0 + 1] = arg_2_0.memoryTogGroup:Find(iter_2_0)
	end

	arg_2_0.memoryFilterIndex = {
		true,
		true,
		false
	}
	arg_2_0.groupToggle = arg_2_0._tf:Find("ActivityToggle")
	arg_2_0.memoryActivityTogGroup = arg_2_0._tf:Find("ActivityToggle/ActivityBar")

	setActive(arg_2_0.memoryActivityTogGroup, true)

	arg_2_0.memoryActivityToggles = {}

	for iter_2_1 = 0, 3 do
		arg_2_0.memoryActivityToggles[iter_2_1 + 1] = arg_2_0.memoryActivityTogGroup:Find(iter_2_1)
	end

	arg_2_0.activityFilter = 0

	arg_2_0:UpdateActivityBar()

	for iter_2_2, iter_2_3 in ipairs(arg_2_0.memoryActivityToggles) do
		onButton(arg_2_0, iter_2_3, function()
			if iter_2_2 == arg_2_0.activityFilter then
				arg_2_0.activityFilter = 0
			elseif iter_2_2 ~= arg_2_0.activityFilter then
				arg_2_0.activityFilter = iter_2_2
			end

			arg_2_0:UpdateActivityBar()
			arg_2_0:MemoryFilter()

			return
		end, SFX_UI_TAG)
	end

	setText(arg_2_0.memoryActivityToggles[1]:Find("Image1/Text"), i18n("memory_actiivty_ex"))
	setText(arg_2_0.memoryActivityToggles[1]:Find("Image2/Text"), i18n("memory_actiivty_ex"))
	setText(arg_2_0.memoryActivityToggles[2]:Find("Image1/Text"), i18n("memory_activity_sp"))
	setText(arg_2_0.memoryActivityToggles[2]:Find("Image2/Text"), i18n("memory_activity_sp"))
	setText(arg_2_0.memoryActivityToggles[3]:Find("Image1/Text"), i18n("memory_activity_daily"))
	setText(arg_2_0.memoryActivityToggles[3]:Find("Image2/Text"), i18n("memory_activity_daily"))
	setText(arg_2_0.memoryActivityToggles[4]:Find("Image1/Text"), i18n("memory_activity_others"))
	setText(arg_2_0.memoryActivityToggles[4]:Find("Image2/Text"), i18n("memory_activity_others"))

	arg_2_0.contextData.toggle = arg_2_0.contextData.toggle or 1

	triggerToggle(arg_2_0.memoryToggles[arg_2_0.contextData.toggle], true)
	arg_2_0:SwitchMemoryFilter(arg_2_0.contextData.toggle)

	for iter_2_4, iter_2_5 in ipairs(arg_2_0.memoryToggles) do
		onToggle(arg_2_0, iter_2_5, function(arg_7_0)
			if not arg_7_0 then
				return
			end

			arg_2_0:SwitchMemoryFilter(iter_2_4)
			arg_2_0:MemoryFilter()

			return
		end, SFX_UI_TAG)
	end

	arg_2_0:OverlayPanel(arg_2_0.memoryTogGroup, {
		overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
	})

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
	arg_2_0:MemoryFilter()

	arg_2_0.rectAnchorX = arg_2_0._tf:Find("GroupRect").anchoredPosition.x

	arg_2_0:UpdateView()

	arg_2_0.storyLineBtn = arg_2_0._tf:Find("StoryLineBtn")
	arg_2_0.storyLineEntranceBtn = arg_2_0._tf:Find("StoryLineBtn/entranceBtn")
	arg_2_0.storyLineHideBtn = arg_2_0._tf:Find("StoryLineBtn/closeBtn")
	arg_2_0.currentMode = var_0_0.FORM_MODE

	onButton(arg_2_0, arg_2_0.storyLineEntranceBtn, function()
		arg_2_0:SwitchStoryLineMode(var_0_0.LINE_MODE)

		return
	end)
	onButton(arg_2_0, arg_2_0.storyLineHideBtn, function()
		arg_2_0:StoryLineBtnSetActive(false)

		return
	end)
	onButton(arg_2_0, arg_2_0.storyLineBtn, function()
		arg_2_0:StoryLineBtnSetActive(true)

		return
	end)

	arg_2_0.storylineTF = arg_2_0._tf:Find("StoryLine")
	arg_2_0.storyLineView = WorldMediaCollectionStoryLineView.New(arg_2_0.storylineTF)

	arg_2_0.storyLineView:ConfigCallback(function(arg_14_0, arg_14_1)
		arg_2_0.viewParent:ShowSubMemories(arg_14_0, true, arg_14_1)
		var_0_0.super.Hide(arg_2_0)

		return
	end, function(arg_15_0, arg_15_1, arg_15_2)
		arg_2_0.viewParent.viewParent:WarpToRecord(arg_15_0, arg_15_1, arg_15_2)

		return
	end)

	return
end

function var_0_0.StoryLineBtnSetActive(arg_16_0, arg_16_1)
	setActive(arg_16_0.storyLineEntranceBtn, arg_16_1)
	setActive(arg_16_0.storyLineHideBtn, arg_16_1)
	setActive(arg_16_0._tf:Find("StoryLineBtn/on"), not arg_16_1)

	return
end

function var_0_0.SwitchStoryLineMode(arg_17_0, arg_17_1)
	arg_17_0.currentMode = arg_17_1

	if arg_17_1 == var_0_0.FORM_MODE then
		setActive(arg_17_0._tf:Find("GroupRect"), true)
		setActive(arg_17_0.memoryTogGroup, true)
		setActive(arg_17_0.groupToggle, true)
		setActive(arg_17_0.storylineTF, false)
		setActive(arg_17_0.storyLineBtn, true)
		arg_17_0.storyLineView:closeFilter()
		arg_17_0:MemoryFilter()
		pg.BgmMgr.GetInstance():ContinuePlay()
	elseif arg_17_1 == var_0_0.LINE_MODE then
		setActive(arg_17_0._tf:Find("GroupRect"), false)
		setActive(arg_17_0.memoryTogGroup, false)
		setActive(arg_17_0.groupToggle, false)
		setActive(arg_17_0.storylineTF, true)
		setActive(arg_17_0.storyLineBtn, false)
		arg_17_0.storyLineView:refresh()
	end

	return
end

function var_0_0.Show(arg_18_0)
	var_0_0.super.Show(arg_18_0)
	setActive(arg_18_0.memoryTogGroup, arg_18_0.currentMode == var_0_0.FORM_MODE)

	return
end

function var_0_0.Hide(arg_19_0)
	if arg_19_0.currentMode == var_0_0.FORM_MODE then
		setActive(arg_19_0.memoryTogGroup, false)
		var_0_0.super.Hide(arg_19_0)
	else
		arg_19_0:SwitchStoryLineMode(var_0_0.FORM_MODE)
	end

	return
end

function var_0_0.GetCurrentMode(arg_20_0)
	return arg_20_0.currentMode
end

function var_0_0.SwitchMemoryFilter(arg_21_0, arg_21_1)
	if arg_21_1 == 1 then
		arg_21_0.memoryFilterIndex = {
			true,
			true,
			false
		}
	else
		for iter_21_0 in ipairs(arg_21_0.memoryFilterIndex) do
			arg_21_0.memoryFilterIndex[iter_21_0] = arg_21_1 - 1 == iter_21_0
		end

		if arg_21_1 - 1 == var_0_0.PAGE_ACTIVITY then
			arg_21_0.activityFilter = 0

			arg_21_0:UpdateActivityBar()
		end
	end

	return
end

function var_0_0.MemoryFilter(arg_22_0)
	table.clear(arg_22_0.memoryGroups)

	local var_22_0 = not _.all(arg_22_0.memoryFilterIndex, function(arg_23_0)
		return arg_23_0
	end) and arg_22_0.memoryFilterIndex[var_0_0.PAGE_ACTIVITY]

	for iter_22_0, iter_22_1 in ipairs(pg.memory_group.all) do
		if arg_22_0.memoryFilterIndex[pg.memory_group[iter_22_1].type] then
			if var_22_0 then
				if arg_22_0.activityFilter == 0 or arg_22_0.activityFilter == pg.memory_group[iter_22_1].subtype then
					table.insert(arg_22_0.memoryGroups, pg.memory_group[iter_22_1])
				end
			else
				table.insert(arg_22_0.memoryGroups, pg.memory_group[iter_22_1])
			end
		end
	end

	table.sort(arg_22_0.memoryGroups, function(arg_24_0, arg_24_1)
		return arg_24_0.id < arg_24_1.id
	end)
	arg_22_0:searchFilter()
	setActive(arg_22_0.memoryActivityTogGroup, var_22_0)

	return
end

function var_0_0.searchFilter(arg_25_0)
	local var_25_0 = getInputText(arg_25_0.nameSearchInput)

	if not var_25_0 or var_25_0 == "" then
		arg_25_0.searchGroupList = nil

		arg_25_0.memoryGroupList:SetTotalCount(#arg_25_0.memoryGroups, 0)
	else
		arg_25_0.searchGroupList = arg_25_0:GetMatchGroupList(var_25_0)

		arg_25_0.memoryGroupList:SetTotalCount(#arg_25_0.searchGroupList, 0)
	end

	return
end

function var_0_0.onInitMemoryGroup(arg_26_0, arg_26_1)
	if arg_26_0.exited then
		return
	end

	onButton(arg_26_0, arg_26_1, function()
		if arg_26_0.memoryGroupInfos[arg_26_1] then
			PlayerPrefs.DeleteKey("MEMORY_GROUP_NOTIFICATION" .. getProxy(PlayerProxy):getRawData().id .. " " .. arg_26_0.memoryGroupInfos[arg_26_1].id)
			arg_26_0.viewParent:ShowSubMemories(arg_26_0.memoryGroupInfos[arg_26_1])
		end

		return
	end, SOUND_BACK)

	return
end

function var_0_0.onUpdateMemoryGroup(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_0.exited then
		return
	end

	if arg_28_0.searchGroupList then
		local var_28_0 = arg_28_0.searchGroupList[arg_28_1] or arg_28_0.memoryGroups[arg_28_1]

		assert(var_28_0, "MemoryGroup Missing Config Index " .. arg_28_1)

		arg_28_0.memoryGroupInfos[arg_28_2] = var_28_0

		setText(tf(arg_28_2):Find("title"), var_28_0.title)
		arg_28_0.loader:GetSpriteQuiet("memoryicon/" .. var_28_0.icon, "", tf(arg_28_2):Find("BG"))

		local var_28_1 = getProxy(PlayerProxy)

		setActive(tf(arg_28_2):Find("Tip"), PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_28_1:getRawData().id .. " " .. var_28_0.id, 0) == 1)
		setText(tf(arg_28_2):Find("count"), _.reduce(var_28_0.memories, 0, function(arg_29_0, arg_29_1)
			if pg.memory_template[arg_29_1].is_open ~= 1 then
				if pg.NewStoryMgr.GetInstance():IsPlayed(pg.memory_template[arg_29_1].unlock_pre, true) then
					arg_29_0 = arg_29_0 + 1
				end

				return arg_29_0
			end
		end) .. "/" .. #var_28_0.memories)

		return
	end
end

function var_0_0.Return2MemoryGroup(arg_30_0)
	if not arg_30_0.contextData.memoryGroup or arg_30_0:GetCurrentMode() == var_0_0.LINE_MODE then
		return
	end

	local var_30_0 = 0

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.memoryGroups) do
		if iter_30_1.id == arg_30_0.contextData.memoryGroup then
			var_30_0 = iter_30_0

			break
		end
	end

	setInputText(arg_30_0.nameSearchInput, "")
	arg_30_0.memoryGroupList:SetTotalCount(#arg_30_0.memoryGroups, (arg_30_0:GetIndexRatio(var_30_0)))

	return
end

function var_0_0.SwitchReddotMemory(arg_31_0)
	local var_31_0 = 0
	local var_31_1 = getProxy(PlayerProxy):getRawData().id

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.memoryGroups) do
		if PlayerPrefs.GetInt("MEMORY_GROUP_NOTIFICATION" .. var_31_1 .. " " .. iter_31_1.id, 0) == 1 then
			var_31_0 = iter_31_0

			break
		end
	end

	if var_31_0 == 0 then
		return
	end

	setInputText(arg_31_0.nameSearchInput, "")
	arg_31_0.memoryGroupList:SetTotalCount(#arg_31_0.memoryGroups, (arg_31_0:GetIndexRatio(var_31_0)))

	return
end

function var_0_0.GetIndexRatio(arg_32_0, arg_32_1)
	local var_32_0 = 0

	if arg_32_1 > 0 then
		var_32_0 = ((arg_32_0.memoryGroupsGrid.cellSize.y + arg_32_0.memoryGroupsGrid.spacing.y) * math.floor((arg_32_1 - 1) / arg_32_0.memoryGroupsGrid.constraintCount) + arg_32_0.memoryGroupList.paddingFront) / ((arg_32_0.memoryGroupsGrid.cellSize.y + arg_32_0.memoryGroupsGrid.spacing.y) * math.ceil(#arg_32_0.memoryGroups / arg_32_0.memoryGroupsGrid.constraintCount) - arg_32_0.memoryGroupViewport.rect.height)
		var_32_0 = Mathf.Clamp01(var_32_0)
	end

	return var_32_0
end

function var_0_0.UpdateView(arg_33_0)
	setAnchoredPosition(arg_33_0._tf:Find("GroupRect"), {
		x = WorldMediaCollectionScene.WorldRecordLock() and 0 or arg_33_0.rectAnchorX
	})

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.memoryActivityToggles) do
		setActive(iter_33_1, _.any(pg.memory_group.all, function(arg_34_0)
			return pg.memory_group[arg_34_0].subtype == iter_33_0
		end))
	end

	return
end

function var_0_0.UpdateActivityBar(arg_35_0)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.memoryActivityToggles) do
		local var_35_0 = arg_35_0.activityFilter == iter_35_0

		setActive(iter_35_1:Find("Image1"), not (arg_35_0.activityFilter == iter_35_0))
		setActive(iter_35_1:Find("Image2"), var_35_0)
	end

	return
end

function var_0_0.OnDestroy(arg_36_0)
	var_0_0.super.OnDestroy(arg_36_0)
	arg_36_0.storyLineView:Dispose()
	arg_36_0:UnOverlayPanel(arg_36_0.memoryTogGroup, arg_36_0._tf)

	return
end

function var_0_0.GetMatchGroupList(arg_37_0, arg_37_1, arg_37_2)
	arg_37_1 = string.lower(string.gsub(arg_37_1, "%.", "%%."))

	for iter_37_0, iter_37_1 in pairs(arg_37_0.memoryGroups) do
		if string.find(string.lower(iter_37_1.title), arg_37_1) then
			table.insert({}, iter_37_1)
		end
	end

	return {}
end

return var_0_0
