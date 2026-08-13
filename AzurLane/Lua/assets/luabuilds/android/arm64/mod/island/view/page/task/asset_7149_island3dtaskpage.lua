class = var_0_10000

local var_0_0 = "Island3dTaskPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "Island3dTaskUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "adapt/toggles/content")

	UIItemList = var_1_10002
	arg_2_0.toggleUIList = var_1_10002.New(var_2_1, var_2_1:Find("tpl"))

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "adapt/types/content")

	UIItemList = var_2_0

	local var_2_4 = var_2_0.New
	local var_2_5 = var_2_3
	local var_2_6 = var_2_3

	arg_2_0.typeUIList = var_2_4(var_2_5, var_2_3.Find(var_2_6, "type_tpl"))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_3.Find(var_2_7, "adapt/detail")
	local var_2_9 = var_3.GetComponent

	typeof = var_6
	Animation = var_2_6
	arg_2_0.detailAnim = var_2_9(var_2_8, var_6(var_2_6))

	local var_2_10 = arg_2_0._tf

	arg_2_0.emptyTF = var_3.Find(var_2_10, "adapt/detail/empty")

	local var_2_11 = arg_2_0._tf

	arg_2_0.detailTF = var_3.Find(var_2_11, "adapt/detail/content")

	local var_2_12 = arg_2_0.detailTF

	arg_2_0.titleBg = var_3.Find(var_2_12, "title")

	local var_2_13 = arg_2_0.detailTF

	arg_2_0.typeIcon = var_3.Find(var_2_13, "title/icon")

	local var_2_14 = arg_2_0.detailTF

	arg_2_0.nameTF = var_3.Find(var_2_14, "title/icon/name")

	local var_2_15 = arg_2_0.detailTF

	arg_2_0.timeTF = var_3.Find(var_2_15, "title/time")

	local var_2_16 = arg_2_0.detailTF

	arg_2_0.descTF = var_3.Find(var_2_16, "view/Viewport/content/desc")

	local var_2_17 = arg_2_0.detailTF

	arg_2_0.targetTF = var_3.Find(var_2_17, "view/Viewport/content/targets")
	setText = var_3

	local var_2_18 = arg_2_0.targetTF
	local var_2_19 = var_5.Find(var_2_18, "Text")

	i18n = var_6

	var_3(var_2_19, var_6("island_task_target"))

	local var_2_20 = arg_2_0.targetTF

	arg_2_0.finishedTargetTF = var_3.Find(var_2_20, "content/finished")

	local var_2_21 = arg_2_0.finishedTargetTF

	arg_2_0.finishedTargetTextTF = var_3.Find(var_2_21, "Text")

	local var_2_22 = arg_2_0.finishedTargetTF

	arg_2_0.finishedTargetLocTF = var_3.Find(var_2_22, "location")

	local var_2_23 = arg_2_0.targetTF

	arg_2_0.targetContent = var_3.Find(var_2_23, "content/list")
	UIItemList = var_3

	local var_2_24 = var_3.New
	local var_2_25 = arg_2_0.targetContent
	local var_2_26 = arg_2_0.targetContent

	arg_2_0.targetUIList = var_2_24(var_2_25, var_6.Find(var_2_26, "tpl"))
	UIItemList = var_3

	local var_2_27 = var_3.New
	local var_2_28 = arg_2_0.detailTF
	local var_2_29 = var_5.Find(var_2_28, "view/Viewport/btns")
	local var_2_30 = arg_2_0.detailTF

	arg_2_0.targetBtnUIList = var_2_27(var_2_29, var_6.Find(var_2_30, "view/Viewport/btns/tpl"))

	local var_2_31 = arg_2_0.detailTF

	arg_2_0.awardsTF = var_3.Find(var_2_31, "awards")
	setText = var_3

	local var_2_32 = arg_2_0.awardsTF
	local var_2_33 = var_5.Find(var_2_32, "title/Text")

	i18n = var_6

	var_3(var_2_33, var_6("island_task_award"))

	local var_2_34 = arg_2_0.awardsTF
	local var_2_35 = var_3.Find(var_2_34, "view/mask/content")

	UIItemList = var_2_2
	arg_2_0.awardUIList = var_2_2.New(var_2_35, var_2_35:Find("tpl"))

	local var_2_36 = arg_2_0.detailTF

	arg_2_0.detailBtns = var_4.Find(var_2_36, "btns")

	local var_2_37 = arg_2_0.detailBtns

	arg_2_0.traceBtn = var_4.Find(var_2_37, "trace")
	setText = var_4

	local var_2_38 = arg_2_0.traceBtn
	local var_2_39 = var_6.Find(var_2_38, "Text")

	i18n = var_7

	var_4(var_2_39, var_7("island_task_tracking"))

	local var_2_40 = arg_2_0.detailBtns

	arg_2_0.tracedBtn = var_4.Find(var_2_40, "traced")
	setText = var_4

	local var_2_41 = arg_2_0.tracedBtn
	local var_2_42 = var_6.Find(var_2_41, "Text")

	i18n = var_7

	var_4(var_2_42, var_7("island_task_tracked"))

	setText = var_4

	local var_2_43 = arg_2_0._tf
	local var_2_44 = var_6.Find(var_2_43, "top/title/Text")

	i18n = var_7

	var_4(var_2_44, var_7("island_task_title"))

	setText = var_4

	local var_2_45 = arg_2_0._tf
	local var_2_46 = var_6.Find(var_2_45, "top/title/Text/en")

	i18n = var_7

	var_4(var_2_46, var_7("island_task_title_en"))

	local var_2_47 = arg_2_0.descTF

	arg_2_0.richtext = var_4.GetComponent(var_2_47, "RichText")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "top/back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	local var_3_4 = arg_3_0.toggleUIList

	var_1.make(var_3_4, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventInit then
			local var_5_0 = arg_3_0

			var_3.InitToggleItem(var_5_0, arg_5_1, arg_5_2)
		end

		return
	end)

	local var_3_5 = arg_3_0.typeUIList

	var_1.make(var_3_5, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_3_0

			var_3.UpdateTypeItem(var_6_0, arg_6_1, arg_6_2)
		end

		return
	end)

	local var_3_6 = arg_3_0.targetUIList

	var_1.make(var_3_6, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_3_0

			var_3.UpdateTargetItem(var_7_0, arg_7_1, arg_7_2)
		end

		return
	end)

	local var_3_7 = arg_3_0.targetBtnUIList

	var_1.make(var_3_7, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_3_0

			var_3.UpdateTargetBtnItem(var_8_0, arg_8_1, arg_8_2)
		end

		return
	end)

	local var_3_8 = arg_3_0.awardUIList

	var_1.make(var_3_8, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_3_0.showAwards[arg_9_1 + 1]

			updateCustomDrop = var_4

			var_4(arg_9_2, var_9_0)

			onButton = var_4

			var_4(arg_3_0, arg_9_2, function()
				local var_10_0 = arg_3_0
				local var_10_1 = var_0.ShowMsgBox
				local var_10_2 = {}

				i18n = var_3_10004
				var_10_2.title = var_3_10004("island_word_desc")
				IslandMsgBox = var_4
				var_10_2.type = var_4.TYPE_COMMON_DROP_DESCRIBE
				var_10_2.dropData = var_9_0

				var_10_1(var_10_0, var_10_2)

				return
			end)
		end

		return
	end)

	return
end

function var_0_1.AddListeners(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.AddListener

	GAME = var_1_10004

	var_11_1(var_11_0, var_1_10004.ISLAND_SET_TRACE_TASK_DONE, arg_11_0.FlushDetail)

	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.AddListener

	GAME = var_4

	var_11_3(var_11_2, var_4.ISLAND_ACCEPT_TASK_DONE, arg_11_0.Flush)

	local var_11_4 = arg_11_0
	local var_11_5 = arg_11_0.AddListener

	GAME = var_4

	var_11_5(var_11_4, var_4.ISLAND_SUBMIT_TASK_DONE, arg_11_0.Flush)

	local var_11_6 = arg_11_0
	local var_11_7 = arg_11_0.AddListener

	GAME = var_4

	var_11_7(var_11_6, var_4.ISLAND_UPDATE_TASK_DONE, arg_11_0.Flush)

	local var_11_8 = arg_11_0
	local var_11_9 = arg_11_0.AddListener

	GAME = var_4

	var_11_9(var_11_8, var_4.ISLAND_GET_RANDOM_REFRESH_TASK_DONE, arg_11_0.Flush)

	local var_11_10 = arg_11_0
	local var_11_11 = arg_11_0.AddListener

	IslandTaskAgency = var_4

	var_11_11(var_11_10, var_4.TASK_ADDED, arg_11_0.Flush)

	local var_11_12 = arg_11_0
	local var_11_13 = arg_11_0.AddListener

	IslandTaskAgency = var_4

	var_11_13(var_11_12, var_4.TASK_UPDATED, arg_11_0.Flush)

	local var_11_14 = arg_11_0
	local var_11_15 = arg_11_0.AddListener

	IslandTaskAgency = var_4

	var_11_15(var_11_14, var_4.TASK_REMOVED, arg_11_0.Flush)

	return
end

function var_0_1.RemoveListeners(arg_12_0)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.RemoveListener

	GAME = var_1_10004

	var_12_1(var_12_0, var_1_10004.ISLAND_SET_TRACE_TASK_DONE, arg_12_0.FlushDetail)

	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.RemoveListener

	GAME = var_4

	var_12_3(var_12_2, var_4.ISLAND_ACCEPT_TASK_DONE, arg_12_0.Flush)

	local var_12_4 = arg_12_0
	local var_12_5 = arg_12_0.RemoveListener

	GAME = var_4

	var_12_5(var_12_4, var_4.ISLAND_SUBMIT_TASK_DONE, arg_12_0.Flush)

	local var_12_6 = arg_12_0
	local var_12_7 = arg_12_0.RemoveListener

	GAME = var_4

	var_12_7(var_12_6, var_4.ISLAND_UPDATE_TASK_DONE, arg_12_0.Flush)

	local var_12_8 = arg_12_0
	local var_12_9 = arg_12_0.RemoveListener

	GAME = var_4

	var_12_9(var_12_8, var_4.ISLAND_GET_RANDOM_REFRESH_TASK_DONE, arg_12_0.Flush)

	local var_12_10 = arg_12_0
	local var_12_11 = arg_12_0.RemoveListener

	IslandTaskAgency = var_4

	var_12_11(var_12_10, var_4.TASK_ADDED, arg_12_0.Flush)

	local var_12_12 = arg_12_0
	local var_12_13 = arg_12_0.RemoveListener

	IslandTaskAgency = var_4

	var_12_13(var_12_12, var_4.TASK_UPDATED, arg_12_0.Flush)

	local var_12_14 = arg_12_0
	local var_12_15 = arg_12_0.RemoveListener

	IslandTaskAgency = var_4

	var_12_15(var_12_14, var_4.TASK_REMOVED, arg_12_0.Flush)

	return
end

function var_0_1.InitToggleItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2.name = arg_13_0.toggleList[arg_13_1 + 1]
	IslandTaskType = var_4

	local var_13_0 = var_4.ShowTypeNames[var_3]

	setText = var_1_10005

	var_1_10005(arg_13_2:Find("unsel"), var_13_0)

	setText = var_1_10005

	var_1_10005(arg_13_2:Find("sel/content/Text"), var_13_0)

	IslandTaskType = var_1_10005

	if var_3 ~= var_1_10005.SHOW_ALL then
		LoadImageSpriteAtlasAsync = var_5

		local var_13_1 = "island/islandtasktype"

		IslandTaskType = var_8

		var_5(var_13_1, var_8.ShowTypeFields[var_3], arg_13_2:Find("sel/content/Image"), false)
	end

	onToggle = var_5

	local var_13_2 = arg_13_0
	local var_13_3 = arg_13_2

	local function var_13_4(arg_14_0)
		if arg_14_0 and (not arg_13_0.selectedType or arg_13_0.selectedType ~= var_0) then
			arg_13_0.selectedType = var_0

			local var_14_0 = arg_13_0

			var_1.Flush(var_14_0)

			local var_14_1 = arg_13_2
			local var_14_2 = var_1.GetComponent

			typeof = var_2_10004
			Animation = var_2_10006

			local var_14_3 = var_14_2(var_14_1, var_2_10004(var_2_10006))

			var_1.Play(var_14_3)
		end

		return
	end

	SFX_PANEL = var_10

	var_5(var_13_2, var_13_3, var_13_4, var_10)

	return
end

function var_0_1.UpdateTypeItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2.name = arg_15_0.showTypeList[arg_15_1 + 1]
	IslandTaskType = var_4

	local var_15_0 = var_4.ShowTypeNames[var_3]

	setText = var_1_10005

	var_1_10005(arg_15_2:Find("title/Text"), var_15_0)

	setImageColor = var_1_10005

	local var_15_1 = arg_15_2:Find("title")

	Color = var_8

	local var_15_2 = var_8.NewHex

	IslandTaskType = var_10

	var_1_10005(var_15_1, var_15_2(var_10.ShowTypeColors[var_3]))

	LoadImageSpriteAtlasAsync = var_1_10005

	local var_15_3 = "island/islandtasktype"

	IslandTaskType = var_8

	var_1_10005(var_15_3, var_8.ShowTypeFields[var_3], arg_15_2:Find("title/Image"))

	setActive = var_1_10005

	var_1_10005(arg_15_2:Find("line"), arg_15_1 + 1 ~= #arg_15_0.showTypeList)

	UIItemList = var_1_10005

	local var_15_4 = var_1_10005.New
	local var_15_5 = arg_15_2:Find("list")
	local var_15_6 = arg_15_2:Find("list")
	local var_15_7 = var_15_4(var_15_5, var_8.GetChild(var_15_6, 0))

	var_5.make(var_15_7, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = arg_15_0.showTaskDict[var_0][arg_16_1 + 1]
			local var_16_1 = arg_15_0

			var_4.UpdateTaskItem(var_16_1, arg_16_2, var_16_0)
		end

		return
	end)

	local var_15_8

	if not arg_15_0.showTaskDict[var_3] or not arg_15_0.showTaskDict[var_3] then
		var_15_8 = {}
	end

	var_5:align(#var_15_8)

	return
end

function var_0_1.UpdateTaskItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1.name = arg_17_2.id

	local var_17_0 = arg_17_2
	local var_17_1 = arg_17_2.GetShowType(var_17_0)

	setImageColor = var_1_10004

	local var_17_2 = arg_17_1:Find("main/line")

	Color = var_1_10007

	local var_17_3 = var_1_10007.NewHex

	IslandTaskType = var_9

	var_1_10004(var_17_2, var_17_3(var_9.ShowTypeColors[var_17_1]))

	local var_17_4 = arg_17_2
	local var_17_5 = arg_17_2.IsSeries(var_17_4)

	setText = var_17_0

	local var_17_6 = arg_17_1:Find("main/name")
	local var_17_7

	if not var_17_5 or not arg_17_2:GetSeriesTitle() then
		var_17_7 = arg_17_2:GetName()
	end

	var_17_0(var_17_6, var_17_7)

	setActive = var_17_0

	var_17_0(arg_17_1:Find("sub"), var_17_5)

	setActive = var_17_0

	var_17_0(arg_17_1:Find("main/location"), not var_17_5)

	local var_17_8

	if var_17_5 then
		IslandTaskType = var_17_0
		var_17_0 = var_17_0.ShowTypeFields[var_17_1]
		LoadImageSpriteAtlasAsync = var_17_4

		var_17_4("ui/island3dtaskui_atlas", "color_" .. var_17_0, arg_17_1:Find("sub/bg"))

		setText = var_17_4
		var_17_8 = arg_17_1

		var_17_4(arg_17_1.Find(var_17_8, "sub/name"), arg_17_2:GetName())
		arg_17_0:UpdateLocation(arg_17_1:Find("sub/location"), arg_17_2)
	else
		local var_17_9 = arg_17_0

		var_17_0 = arg_17_0.UpdateLocation
		var_17_8 = arg_17_1

		var_17_0(var_17_9, arg_17_1.Find(var_17_8, "main/location"), arg_17_2)
	end

	onToggle = var_17_0

	local var_17_10 = arg_17_0
	local var_17_11 = arg_17_1

	local function var_17_12(arg_18_0)
		setActive = var_2_10001

		local var_18_0 = arg_17_1

		var_2_10001(var_3.Find(var_18_0, "main/selected"), arg_18_0 and not var_17_5)

		setActive = var_2_10001

		local var_18_1 = arg_17_1

		var_2_10001(var_3.Find(var_18_1, "sub/selected"), arg_18_0 and var_17_5)

		if arg_18_0 and (not arg_17_0.selectedTaskId or arg_17_0.selectedTaskId ~= arg_17_2.id or arg_17_0.isOpen) then
			arg_17_0.selectedTaskId = arg_17_2.id

			local var_18_2 = arg_17_0

			var_1.FlushDetail(var_18_2)

			arg_17_0.isOpen = false
		end

		return
	end

	SFX_PANEL = var_17_8

	var_17_0(var_17_10, var_17_11, var_17_12, var_17_8)

	return
end

function var_0_1.UpdateLocation(arg_19_0, arg_19_1, arg_19_2)
	setActive = var_1_10003

	var_1_10003(arg_19_1, arg_19_2.id == arg_19_0.trackTaskId)

	if arg_19_2.id == arg_19_0.trackTaskId then
		local var_19_0 = arg_19_2
		local var_19_1 = arg_19_2.GetTraceParam(var_19_0)

		tonumber = var_4

		local var_19_2 = var_4(var_19_1)

		setActive = var_19_0

		var_19_0(arg_19_1, var_19_2)

		if var_19_2 then
			pg = var_19_0

			local var_19_3

			if var_19_0.island_world_objects[var_19_2].mapId ~= arg_19_0.curMapId or not (arg_19_0:CalcDistance(var_19_2) .. "m") then
				pg = var_19_3
				var_19_3 = var_19_3.island_map[var_5].name
			end

			setText = var_7

			var_7(arg_19_1:Find("Text"), var_19_3)
		end
	end

	return
end

function var_0_1.CalcDistance(arg_20_0, arg_20_1)
	_IslandCore = var_1_10002

	local var_20_0 = var_1_10002:GetView()
	local var_20_1 = var_2.GetPlayerPosition(var_20_0)

	_IslandCore = var_1_10003

	local var_20_2 = var_1_10003:GetView()
	local var_20_3

	if not var_3.GetUnitPosition(var_20_2, arg_20_1) then
		var_20_3 = var_20_1
	end

	Vector3 = var_20_0

	local var_20_4 = var_20_0.Distance(var_20_1, var_20_3)

	math = var_20_2

	return var_20_2.ceil(var_20_4)
end

function var_0_1.UpdateTargetItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.showTargets[arg_21_1 + 1]

	setText = var_4

	var_4(arg_21_2:Find("content/Text"), var_21_0:getConfig("name"))

	local var_21_1 = var_21_0
	local var_21_2 = var_21_0.GetProgress(var_21_1)
	local var_21_3 = var_21_0
	local var_21_4 = var_21_0.GetTargetNum(var_21_3)

	setText = var_21_1

	local var_21_5 = arg_21_2
	local var_21_6 = arg_21_2.Find(var_21_5, "content/num")
	local var_21_7 = "("

	if var_21_2 < var_21_4 then
		setColorStr = var_21_5

		local var_21_8

		if not var_21_5(var_21_2, "#dd374e") then
			var_21_8 = var_21_2
		end

		var_21_1(var_21_6, var_21_7 .. var_21_8 .. "/" .. var_21_4 .. ")")

		local var_21_9 = var_21_0:IsFinish()

		setActive = var_21_3

		var_21_3(arg_21_2:Find("status/unfinish"), not var_21_9)

		setActive = var_21_3

		var_21_3(arg_21_2:Find("status/finished"), var_21_9)

		local var_21_10 = arg_21_0.showVO
		local var_21_11, var_21_12 = var_7.GetTraceParam(var_21_10)
		local var_21_13 = arg_21_2
		local var_21_14 = arg_21_2.Find(var_21_13, "content/location")
		local var_21_15 = var_21_12 and var_21_12 == arg_21_1 + 1

		setActive = var_21_13

		var_21_13(var_21_14, var_21_15)

		if var_21_15 then
			arg_21_0:UpdateLocation(var_21_14, arg_21_0.showVO)
		end

		return
	end
end

function var_0_1._SkipBtn(arg_22_0, arg_22_1)
	pg = var_1_10002

	local var_22_0 = var_1_10002.island_main_btns[arg_22_1]

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_22_1 = var_1_10003(var_1_10005)
	local var_22_2 = var_3.GetIsland(var_22_1)
	local var_22_3 = var_3.GetAblityAgency(var_22_2)

	if not var_3.HasAbility(var_22_3, var_22_0.ability_id) then
		pg = var_3

		local var_22_4 = var_3.TipsMgr.GetInstance()
		local var_22_5 = var_3.ShowTips

		i18n = var_6

		var_22_5(var_22_4, var_6("island_taskjump_systemnoopen_tips"))

		return
	end

	if var_22_0.open_page ~= "" then
		arg_22_0:Hide()

		local var_22_6 = arg_22_0
		local var_22_7 = arg_22_0.emit

		IslandMediator = var_6

		var_22_7(var_22_6, var_6.OPEN_PAGE, var_22_0.open_page, var_22_0.page_param)
	end

	return
end

function var_0_1._SkipObj(arg_23_0, arg_23_1)
	pg = var_1_10002

	local var_23_0 = var_1_10002.island_world_objects[arg_23_1].mapId

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_23_1 = var_1_10003(var_1_10005)
	local var_23_2 = var_3.GetIsland(var_23_1)
	local var_23_3 = var_3.GetAblityAgency(var_23_2)

	if not var_3.IsUnlockMap(var_23_3, var_23_0) then
		pg = var_3

		local var_23_4 = var_3.TipsMgr.GetInstance()
		local var_23_5 = var_3.ShowTips

		i18n = var_6

		var_23_5(var_23_4, var_6("island_taskjump_placenoopen_tips"))

		return
	end

	arg_23_0:Hide(false)

	local var_23_6 = arg_23_0
	local var_23_7 = arg_23_0.emit

	IslandBaseMediator = var_6

	local var_23_8 = var_6.SWITCH_MAP
	local var_23_9 = var_23_0

	pg = var_1_10008

	var_23_7(var_23_6, var_23_8, var_23_9, var_1_10008.island_map[var_23_0].born_object)

	return
end

function var_0_1.UpdateTargetBtnItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.showTargets[arg_24_1 + 1]
	local var_24_1 = arg_24_2
	local var_24_2 = arg_24_2.Find(var_24_1, "btn")

	removeOnButton = var_1_10005

	var_1_10005(var_24_2)

	setActive = var_1_10005

	var_1_10005(var_24_2, false)

	if var_24_0 then
		pg = var_1_10005
		var_1_10005 = var_1_10005.island_task_target[var_24_0.id]
		tonumber = var_24_1
		var_24_1 = var_24_1(var_1_10005.tips)
		tonumber = var_7

		local var_24_3 = var_7(var_1_10005.jump_ui)

		if not var_24_0:IsFinish() then
			if var_24_3 then
				setActive = var_8

				var_8(var_24_2, true)

				onButton = var_8

				local var_24_4 = arg_24_0
				local var_24_5 = var_24_2

				function var_1_10012()
					local var_25_0 = arg_24_0

					var_0._SkipBtn(var_25_0, var_24_3)

					return
				end

				SFX_PANEL = var_1_10013

				var_8(var_24_4, var_24_5, var_1_10012, var_1_10013)
			elseif var_24_1 then
				pg = var_8

				local var_24_6 = var_8.island_world_objects[var_24_1].mapId

				IslandMainBtnTipHelper = var_9

				if var_9.IsUnlock("map") and arg_24_0.curMapId ~= var_24_6 then
					setActive = var_9

					var_9(var_24_2, true)

					onButton = var_9

					local var_24_7 = arg_24_0

					var_1_10012 = var_24_2

					local function var_24_8()
						local var_26_0 = arg_24_0

						var_0._SkipObj(var_26_0, var_24_1)

						return
					end

					SFX_PANEL = var_1_10014

					var_9(var_24_7, var_1_10012, var_24_8, var_1_10014)
				end
			end
		end
	else
		setActive = var_1_10005

		var_1_10005(var_24_2, false)

		tonumber = var_1_10005

		local var_24_9 = arg_24_0.showVO

		if var_1_10005(var_7.getConfig(var_24_9, "complete_data")) and var_5 ~= 0 then
			pg = var_24_1

			local var_24_10 = var_24_1.island_world_objects[var_5].mapId

			IslandMainBtnTipHelper = var_7

			if var_7.IsUnlock("map") and arg_24_0.curMapId ~= var_24_10 then
				setActive = var_7

				var_7(var_24_2, true)

				onButton = var_7

				local var_24_11 = arg_24_0
				local var_24_12 = var_24_2

				local function var_24_13()
					local var_27_0 = arg_24_0

					var_0._SkipObj(var_27_0, var_0)

					return
				end

				SFX_PANEL = var_1_10012

				var_7(var_24_11, var_24_12, var_24_13, var_1_10012)
			end
		end
	end

	return
end

function var_0_1.Flush(arg_28_0)
	if not arg_28_0.selectedType then
		IslandTaskType = var_1
		arg_28_0.selectedType = var_1.SHOW_ALL
	end

	getProxy = var_1
	IslandProxy = var_1_10003

	local var_28_0 = var_1(var_1_10003)
	local var_28_1 = var_1.GetIsland(var_28_0)

	arg_28_0.curMapId = var_1.GetMapId(var_28_1)
	arg_28_0.taskAgency = var_1:GetTaskAgency()

	local var_28_2 = arg_28_0.taskAgency

	arg_28_0.trackTaskId = var_2.GetTraceId(var_28_2)

	local var_28_3 = arg_28_0.taskAgency
	local var_28_4 = var_2.GetShowTasks(var_28_3)

	arg_28_0.showTaskDict = {}
	pairs = var_3

	for iter_28_0, iter_28_1 in var_3(var_28_4) do
		if iter_28_1:GetShowType() then
			local var_28_5

			if not arg_28_0.showTaskDict[var_8] then
				var_28_5 = arg_28_0.showTaskDict
				var_28_5[var_8] = {}
			end

			table = var_28_5

			var_28_5.insert(arg_28_0.showTaskDict[var_8], iter_28_1)
		end
	end

	arg_28_0.showTypeList = {
		arg_28_0.selectedType
	}

	local var_28_6 = arg_28_0.selectedType

	IslandTaskType = var_4

	if var_28_6 == var_4.SHOW_ALL then
		arg_28_0.showTypeList = arg_28_0:GetShowTypeList()
	end

	table = var_28_6

	var_28_6.sort(arg_28_0.showTypeList)

	local var_28_7 = arg_28_0.typeUIList

	var_3.align(var_28_7, #arg_28_0.showTypeList)
	arg_28_0:PingFirstTask()

	return
end

function var_0_1.FlushTypeUIList(arg_29_0)
	local var_29_0 = arg_29_0.typeUIList

	var_1.align(var_29_0, #arg_29_0.showTypeList)

	local var_29_1 = {}
	local var_29_2 = arg_29_0.typeUIList

	var_2.eachActive(var_29_2, function(arg_30_0, arg_30_1)
		local var_30_0 = arg_30_1
		local var_30_1 = arg_30_1.GetComponent

		typeof = var_2_10005
		CanvasGroup = var_2_10007

		local var_30_2 = var_30_1(var_30_0, var_2_10005(var_2_10007))

		var_30_2.alpha = 0
		table = var_30_2

		var_30_2.insert(var_29_1, function(arg_31_0)
			local var_31_0 = arg_30_1
			local var_31_1 = var_1.GetComponent

			typeof = var_3_10004
			Animation = var_3_10006

			local var_31_2 = var_31_1(var_31_0, var_3_10004(var_3_10006))

			var_1.Play(var_31_2)

			local var_31_3 = arg_30_1
			local var_31_4 = var_1.GetComponent

			typeof = var_4
			CanvasGroup = var_3_10006
			var_31_4(var_31_3, var_4(var_3_10006)).alpha = 1

			local var_31_5 = arg_29_0
			local var_31_6 = var_1.managedTween

			LeanTween = var_4

			var_31_6(var_31_5, var_4.delayedCall, function()
				arg_31_0()

				return
			end, 0.06, nil)

			return
		end)

		return
	end)

	seriesAsync = var_2

	var_2(var_29_1)

	return
end

function var_0_1.PingFirstTask(arg_33_0)
	underscore = var_1_10001

	if var_1_10001.detect(arg_33_0.showTypeList, function(arg_34_0)
		local var_34_0

		if arg_33_0.showTaskDict[arg_34_0] then
			var_34_0 = #arg_33_0.showTaskDict[arg_34_0] > 0
		end

		return var_34_0
	end) then
		triggerToggle = var_1_10002

		local var_33_0 = arg_33_0.typeUIList.container
		local var_33_1 = var_4.Find(var_33_0, var_1 .. "/list")

		var_1_10002(var_4.GetChild(var_33_1, 0), true)
	else
		arg_33_0.selectedTaskId = nil

		arg_33_0:FlushDetail()
	end

	return
end

function var_0_1.FlushDetail(arg_35_0)
	local var_35_0 = arg_35_0.taskAgency

	arg_35_0.trackTaskId = var_1.GetTraceId(var_35_0)
	setActive = var_1

	var_1(arg_35_0.detailTF, arg_35_0.selectedTaskId)

	setActive = var_1

	var_1(arg_35_0.emptyTF, not arg_35_0.selectedTaskId)

	local var_35_1 = arg_35_0.taskAgency

	arg_35_0.showVO = var_1.GetTask(var_35_1, arg_35_0.selectedTaskId)

	if arg_35_0.selectedTaskId and arg_35_0.showVO then
		local var_35_2 = arg_35_0.detailAnim

		var_1.Play(var_35_2)

		local var_35_3 = arg_35_0.showVO
		local var_35_4 = var_1.GetShowType(var_35_3)

		IslandTaskType = var_1_10002

		local var_35_5 = var_1_10002.ShowTypeFields[var_35_4]

		LoadImageSpriteAtlasAsync = var_35_3

		var_35_3("ui/island3dtaskui_atlas", "title_bg_" .. var_35_5, arg_35_0.titleBg)

		LoadImageSpriteAtlasAsync = var_35_3

		var_35_3("ui/island3dtaskui_atlas", "title_icon_" .. var_35_5, arg_35_0.typeIcon)

		setText = var_35_3

		local var_35_6 = arg_35_0.nameTF
		local var_35_7 = arg_35_0.showVO

		var_35_3(var_35_6, var_6.GetName(var_35_7))

		IslandTaskType = var_35_3

		local var_35_8 = var_35_4 == var_35_3.SHOW_ACTIVITY and arg_35_0.showVO.endTime ~= 0

		setActive = var_4

		var_4(arg_35_0.timeTF, var_35_8)

		if var_35_8 then
			setText = var_4

			local var_35_9 = arg_35_0.timeTF
			local var_35_10 = var_6.Find(var_35_9, "Text")
			local var_35_11 = arg_35_0.showVO

			var_4(var_35_10, var_7.GetRemainTimeStr(var_35_11))
		end

		local var_35_12 = arg_35_0.richtext
		local var_35_13 = arg_35_0.showVO

		var_35_12.text = var_5.GetDesc(var_35_13)

		local var_35_14 = arg_35_0.richtext

		var_4.RemoveAllListeners(var_35_14)

		local var_35_15 = arg_35_0.richtext

		var_4.AddListener(var_35_15, function(arg_36_0, arg_36_1)
			if arg_36_0 == "dropDesHandle" then
				string = var_2_10002

				local var_36_0, var_36_1 = var_2_10002.match(arg_36_1, "{(%d+),(%d+)}")

				Drop = var_4

				local var_36_2 = var_4.New
				local var_36_3 = {
					count = 0
				}

				tonumber = var_2_10007
				var_36_3.type = var_2_10007(var_36_0)
				tonumber = var_7
				var_36_3.id = var_7(var_36_1)

				local var_36_4 = var_36_2(var_36_3)
				local var_36_5 = arg_35_0
				local var_36_6 = var_5.ShowMsgBox
				local var_36_7 = {}

				i18n = var_9
				var_36_7.title = var_9("island_word_desc")
				IslandMsgBox = var_9
				var_36_7.type = var_9.TYPE_COMMON_DROP_DESCRIBE
				var_36_7.dropData = var_36_4

				var_36_6(var_36_5, var_36_7)
			end

			return
		end)

		local var_35_16 = arg_35_0.showVO

		arg_35_0.showTargets = var_4.GetTargetList(var_35_16)

		local var_35_17 = arg_35_0.showVO
		local var_35_18

		if not var_4.IsSubmitImmediately(var_35_17) then
			var_35_17 = arg_35_0.showVO
			var_35_18 = var_4.IsFinish(var_35_17)
		else
			var_35_18 = false
		end

		if false then
			var_35_18 = true
		end

		local var_35_19 = arg_35_0.targetUIList

		var_5.align(var_35_19, #arg_35_0.showTargets)

		setActive = var_5

		var_5(arg_35_0.finishedTargetTF, var_35_18)

		if var_35_18 then
			setText = var_5

			local var_35_20 = arg_35_0.finishedTargetTextTF
			local var_35_21 = arg_35_0.showVO

			var_5(var_35_20, var_8.GetFinishedDesc(var_35_21))
			arg_35_0:UpdateLocation(arg_35_0.finishedTargetLocTF, arg_35_0.showVO)
		end

		local var_35_22 = arg_35_0.targetBtnUIList

		var_5.align(var_35_22, #arg_35_0.showTargets + (var_35_18 and 1 or 0))

		local var_35_23 = arg_35_0.showVO

		arg_35_0.showAwards = var_5.GetAwards(var_35_23)

		local var_35_24 = arg_35_0.awardUIList

		var_5.align(var_35_24, #arg_35_0.showAwards)

		local var_35_25 = arg_35_0.showVO
		local var_35_26 = var_5.GetType(var_35_25)

		IslandTaskType = var_35_17

		if var_35_26 == var_35_17.MAIN then
			IslandTaskTrackCard = var_35_27

			local var_35_27

			if not var_35_27.TYPES.MAIN then
				IslandTaskTrackCard = var_35_27
				var_35_27 = var_35_27.TYPES.OTHER
			end

			setActive = var_35_25

			var_35_25(arg_35_0.traceBtn, not var_5 and arg_35_0.showVO.id ~= arg_35_0.trackTaskId)

			onButton = var_35_25

			local var_35_28 = arg_35_0
			local var_35_29 = arg_35_0.traceBtn

			local function var_35_30()
				local var_37_0 = arg_35_0
				local var_37_1 = var_0.emit

				IslandMediator = var_2_10003

				var_37_1(var_37_0, var_2_10003.ON_SET_TRACE_ID, arg_35_0.showVO.id, var_35_27)

				return
			end

			SFX_PANEL = var_1_10012

			var_35_25(var_35_28, var_35_29, var_35_30, var_1_10012)

			setActive = var_35_25

			var_35_25(arg_35_0.tracedBtn, var_5 or arg_35_0.showVO.id == arg_35_0.trackTaskId)

			onButton = var_35_25

			local var_35_31 = arg_35_0
			local var_35_32 = arg_35_0.tracedBtn

			local function var_35_33()
				if var_0 then
					return
				end

				local var_38_0 = arg_35_0
				local var_38_1 = var_0.emit

				IslandMediator = var_2_10003

				var_38_1(var_38_0, var_2_10003.ON_SET_TRACE_ID, 0, var_35_27)

				return
			end

			SFX_PANEL = var_1_10012

			var_35_25(var_35_31, var_35_32, var_35_33, var_1_10012)

			return
		end
	end
end

function var_0_1.OnShow(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0.isOpen = true
	arg_39_0.toggleList = arg_39_0:GetShowTypeList()
	table = var_3

	local var_39_0 = var_3.insert
	local var_39_1 = arg_39_0.toggleList
	local var_39_2 = 1

	IslandTaskType = var_1_10007

	var_39_0(var_39_1, var_39_2, var_1_10007.SHOW_ALL)

	local var_39_3 = arg_39_0.toggleUIList

	var_3.align(var_39_3, #arg_39_0.toggleList)

	local var_39_4 = arg_39_0

	arg_39_0.Flush(var_39_4)

	local var_39_5 = false
	local var_39_6

	if arg_39_1 then
		var_39_6 = arg_39_0.toggleUIList.container

		if var_1_10004.Find(var_39_6, arg_39_1) then
			triggerToggle = var_1_10004

			local var_39_7 = arg_39_0.toggleUIList.container

			var_1_10004(var_39_6.Find(var_39_7, arg_39_1), true)

			var_39_5 = true
		end
	end

	getProxy = var_1_10004
	IslandProxy = var_39_6

	local var_39_8 = var_1_10004(var_39_6)
	local var_39_9 = var_4.GetIsland(var_39_8)
	local var_39_10 = var_4.GetTaskAgency(var_39_9)

	if var_4.GetTask(var_39_10, arg_39_2 or 0) then
		if not var_39_5 then
			triggerToggle = var_39_4

			local var_39_11 = arg_39_0.toggleUIList.container

			var_39_4(var_7.GetChild(var_39_11, 0), true)
		end

		IslandTaskType = var_39_4
		var_39_4 = var_39_4.Type2ShowType
		pg = var_39_10
		var_39_4 = var_39_4[var_39_10.island_task[arg_39_2].type]
		triggerToggle = var_6

		local var_39_12 = arg_39_0.typeUIList.container

		var_6(var_8.Find(var_39_12, var_39_4 .. "/list/" .. arg_39_2), true)
	end

	pg = var_39_4

	local var_39_13 = var_39_4.UIMgr.GetInstance()

	var_5.BlurPanel(var_39_13, arg_39_0._tf)

	return
end

function var_0_1.GetShowTypeList(arg_40_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_40_0 = var_1_10001(var_1_10003)
	local var_40_1 = var_1.GetIsland(var_40_0)
	local var_40_2 = var_1.GetAblityAgency(var_40_1)

	underscore = var_1_10002

	local var_40_3 = var_1_10002.select

	underscore = var_1_10004

	local var_40_4 = var_1_10004.keys

	IslandTaskType = var_1_10006

	local var_40_5 = var_40_3(var_40_4(var_1_10006.ShowTypeUnlockId), function(arg_41_0)
		local var_41_0 = var_40_2
		local var_41_1 = var_1.HasAbility

		IslandTaskType = var_2_10004

		return var_41_1(var_41_0, var_2_10004.ShowTypeUnlockId[arg_41_0])
	end)

	table = var_40_1

	var_40_1.sort(var_40_5)

	return var_40_5
end

function var_0_1.OnHide(arg_42_0)
	pg = var_1_10001

	local var_42_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_42_0, arg_42_0._tf)

	return
end

function var_0_1.OnDisable(arg_43_0)
	arg_43_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_44_0)
	local var_44_0 = arg_44_0.richtext

	var_1.RemoveAllListeners(var_44_0)
	arg_44_0:OnHide()

	return
end

return var_0_1
