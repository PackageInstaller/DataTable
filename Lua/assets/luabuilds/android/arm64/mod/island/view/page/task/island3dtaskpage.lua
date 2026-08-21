local var_0_0 = class("Island3dTaskPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "Island3dTaskUI"
end

function var_0_0.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("adapt/toggles/content")

	arg_2_0.toggleUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	local var_2_1 = arg_2_0._tf:Find("adapt/types/content")

	arg_2_0.typeUIList = UIItemList.New(var_2_1, var_2_1:Find("type_tpl"))
	arg_2_0.detailAnim = arg_2_0._tf:Find("adapt/detail"):GetComponent(typeof(Animation))
	arg_2_0.emptyTF = arg_2_0._tf:Find("adapt/detail/empty")
	arg_2_0.detailTF = arg_2_0._tf:Find("adapt/detail/content")
	arg_2_0.titleBg = arg_2_0.detailTF:Find("title")
	arg_2_0.typeIcon = arg_2_0.detailTF:Find("title/icon")
	arg_2_0.nameTF = arg_2_0.detailTF:Find("title/icon/name")
	arg_2_0.timeTF = arg_2_0.detailTF:Find("title/time")
	arg_2_0.descTF = arg_2_0.detailTF:Find("view/Viewport/content/desc")
	arg_2_0.targetTF = arg_2_0.detailTF:Find("view/Viewport/content/targets")

	setText(arg_2_0.targetTF:Find("Text"), i18n("island_task_target"))

	arg_2_0.finishedTargetTF = arg_2_0.targetTF:Find("content/finished")
	arg_2_0.finishedTargetTextTF = arg_2_0.finishedTargetTF:Find("Text")
	arg_2_0.finishedTargetLocTF = arg_2_0.finishedTargetTF:Find("location")
	arg_2_0.targetContent = arg_2_0.targetTF:Find("content/list")
	arg_2_0.targetUIList = UIItemList.New(arg_2_0.targetContent, arg_2_0.targetContent:Find("tpl"))
	arg_2_0.targetBtnUIList = UIItemList.New(arg_2_0.detailTF:Find("view/Viewport/btns"), arg_2_0.detailTF:Find("view/Viewport/btns/tpl"))
	arg_2_0.awardsTF = arg_2_0.detailTF:Find("awards")

	setText(arg_2_0.awardsTF:Find("title/Text"), i18n("island_task_award"))

	local var_2_2 = arg_2_0.awardsTF:Find("view/mask/content")

	arg_2_0.awardUIList = UIItemList.New(var_2_2, var_2_2:Find("tpl"))
	arg_2_0.detailBtns = arg_2_0.detailTF:Find("btns")
	arg_2_0.traceBtn = arg_2_0.detailBtns:Find("trace")

	setText(arg_2_0.traceBtn:Find("Text"), i18n("island_task_tracking"))

	arg_2_0.tracedBtn = arg_2_0.detailBtns:Find("traced")

	setText(arg_2_0.tracedBtn:Find("Text"), i18n("island_task_tracked"))
	setText(arg_2_0._tf:Find("top/title/Text"), i18n("island_task_title"))
	setText(arg_2_0._tf:Find("top/title/Text/en"), i18n("island_task_title_en"))

	arg_2_0.richtext = arg_2_0.descTF:GetComponent("RichText")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/back"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	arg_3_0.toggleUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			arg_3_0:InitToggleItem(arg_5_1, arg_5_2)
		end

		return
	end)
	arg_3_0.typeUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateTypeItem(arg_6_1, arg_6_2)
		end

		return
	end)
	arg_3_0.targetUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateTargetItem(arg_7_1, arg_7_2)
		end

		return
	end)
	arg_3_0.targetBtnUIList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateTargetBtnItem(arg_8_1, arg_8_2)
		end

		return
	end)
	arg_3_0.awardUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_9_2, arg_3_0.showAwards[arg_9_1 + 1])
			onButton(arg_3_0, arg_9_2, function()
				arg_3_0:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_0
				})

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0:AddListener(GAME.ISLAND_SET_TRACE_TASK_DONE, arg_11_0.FlushDetail)
	arg_11_0:AddListener(GAME.ISLAND_ACCEPT_TASK_DONE, arg_11_0.Flush)
	arg_11_0:AddListener(GAME.ISLAND_SUBMIT_TASK_DONE, arg_11_0.Flush)
	arg_11_0:AddListener(GAME.ISLAND_UPDATE_TASK_DONE, arg_11_0.Flush)
	arg_11_0:AddListener(GAME.ISLAND_GET_RANDOM_REFRESH_TASK_DONE, arg_11_0.Flush)
	arg_11_0:AddListener(IslandTaskAgency.TASK_ADDED, arg_11_0.Flush)
	arg_11_0:AddListener(IslandTaskAgency.TASK_UPDATED, arg_11_0.Flush)
	arg_11_0:AddListener(IslandTaskAgency.TASK_REMOVED, arg_11_0.Flush)

	return
end

function var_0_0.RemoveListeners(arg_12_0)
	arg_12_0:RemoveListener(GAME.ISLAND_SET_TRACE_TASK_DONE, arg_12_0.FlushDetail)
	arg_12_0:RemoveListener(GAME.ISLAND_ACCEPT_TASK_DONE, arg_12_0.Flush)
	arg_12_0:RemoveListener(GAME.ISLAND_SUBMIT_TASK_DONE, arg_12_0.Flush)
	arg_12_0:RemoveListener(GAME.ISLAND_UPDATE_TASK_DONE, arg_12_0.Flush)
	arg_12_0:RemoveListener(GAME.ISLAND_GET_RANDOM_REFRESH_TASK_DONE, arg_12_0.Flush)
	arg_12_0:RemoveListener(IslandTaskAgency.TASK_ADDED, arg_12_0.Flush)
	arg_12_0:RemoveListener(IslandTaskAgency.TASK_UPDATED, arg_12_0.Flush)
	arg_12_0:RemoveListener(IslandTaskAgency.TASK_REMOVED, arg_12_0.Flush)

	return
end

function var_0_0.InitToggleItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.toggleList[arg_13_1 + 1]

	arg_13_2.name = arg_13_0.toggleList[arg_13_1 + 1]

	setText(arg_13_2:Find("unsel"), IslandTaskType.ShowTypeNames[arg_13_0.toggleList[arg_13_1 + 1]])
	setText(arg_13_2:Find("sel/content/Text"), IslandTaskType.ShowTypeNames[arg_13_0.toggleList[arg_13_1 + 1]])

	if arg_13_0.toggleList[arg_13_1 + 1] ~= IslandTaskType.SHOW_ALL then
		LoadImageSpriteAtlasAsync("island/islandtasktype", IslandTaskType.ShowTypeFields[arg_13_0.toggleList[arg_13_1 + 1]], arg_13_2:Find("sel/content/Image"), false)
	end

	onToggle(arg_13_0, arg_13_2, function(arg_14_0)
		if arg_14_0 and (not arg_13_0.selectedType or arg_13_0.selectedType ~= var_13_0) then
			arg_13_0.selectedType = var_13_0

			arg_13_0:Flush()
			arg_13_2:GetComponent(typeof(Animation)):Play()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateTypeItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.showTypeList[arg_15_1 + 1]

	arg_15_2.name = arg_15_0.showTypeList[arg_15_1 + 1]

	setText(arg_15_2:Find("title/Text"), IslandTaskType.ShowTypeNames[var_15_0])
	setImageColor(arg_15_2:Find("title"), Color.NewHex(IslandTaskType.ShowTypeColors[var_15_0]))
	LoadImageSpriteAtlasAsync("island/islandtasktype", IslandTaskType.ShowTypeFields[var_15_0], arg_15_2:Find("title/Image"))
	setActive(arg_15_2:Find("line"), arg_15_1 + 1 ~= #arg_15_0.showTypeList)

	local var_15_1 = UIItemList.New(arg_15_2:Find("list"), arg_15_2:Find("list"):GetChild(0))

	var_15_1:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			arg_15_0:UpdateTaskItem(arg_16_2, arg_15_0.showTaskDict[var_15_0][arg_16_1 + 1])
		end

		return
	end)

	if arg_15_0.showTaskDict[var_15_0] then
		local var_15_2 = arg_15_0.showTaskDict[var_15_0] or {}

		var_15_1:align(#var_15_2)

		return
	end
end

function var_0_0.UpdateTaskItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1.name = arg_17_2.id

	local var_17_0 = arg_17_2:GetShowType()

	setImageColor(arg_17_1:Find("main/line"), Color.NewHex(IslandTaskType.ShowTypeColors[var_17_0]))

	local var_17_1 = arg_17_2:IsSeries()
	local var_17_2 = var_17_1 and arg_17_2:GetSeriesTitle() or arg_17_2:GetName()

	setText(arg_17_1:Find("main/name"), var_17_2)
	setActive(arg_17_1:Find("sub"), var_17_1)
	setActive(arg_17_1:Find("main/location"), not var_17_1)

	if var_17_1 then
		LoadImageSpriteAtlasAsync("ui/island3dtaskui_atlas", "color_" .. IslandTaskType.ShowTypeFields[var_17_0], arg_17_1:Find("sub/bg"))
		setText(arg_17_1:Find("sub/name"), arg_17_2:GetName())
		arg_17_0:UpdateLocation(arg_17_1:Find("sub/location"), arg_17_2)
	else
		arg_17_0:UpdateLocation(arg_17_1:Find("main/location"), arg_17_2)
	end

	onToggle(arg_17_0, arg_17_1, function(arg_18_0)
		setActive(arg_17_1:Find("main/selected"), arg_18_0 and not var_17_1)
		setActive(arg_17_1:Find("sub/selected"), arg_18_0 and var_17_1)

		if arg_18_0 and (not arg_17_0.selectedTaskId or arg_17_0.selectedTaskId ~= arg_17_2.id or arg_17_0.isOpen) then
			arg_17_0.selectedTaskId = arg_17_2.id

			arg_17_0:FlushDetail()

			arg_17_0.isOpen = false
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateLocation(arg_19_0, arg_19_1, arg_19_2)
	setActive(arg_19_1, arg_19_2.id == arg_19_0.trackTaskId)

	if arg_19_2.id == arg_19_0.trackTaskId then
		local var_19_0 = tonumber((arg_19_2:GetTraceParam()))

		setActive(arg_19_1, var_19_0)

		if var_19_0 then
			local var_19_1 = pg.island_world_objects[var_19_0].mapId == arg_19_0.curMapId and arg_19_0:CalcDistance(var_19_0) .. "m" or pg.island_map[pg.island_world_objects[var_19_0].mapId].name

			setText(arg_19_1:Find("Text"), var_19_1)
		end
	end

	return
end

function var_0_0.CalcDistance(arg_20_0, arg_20_1)
	local var_20_0 = _IslandCore:GetView():GetPlayerPosition()
	local var_20_1 = _IslandCore:GetView():GetUnitPosition(arg_20_1) or var_20_0

	return math.ceil((Vector3.Distance(var_20_0, var_20_1)))
end

function var_0_0.UpdateTargetItem(arg_21_0, arg_21_1, arg_21_2)
	setText(arg_21_2:Find("content/Text"), arg_21_0.showTargets[arg_21_1 + 1]:getConfig("name"))

	local var_21_1 = var_21_0:GetProgress()
	local var_21_2 = var_21_0:GetTargetNum()
	local var_21_3 = var_21_1 < var_21_2 and setColorStr(var_21_1, "#dd374e") or var_21_1

	setText(arg_21_2:Find("content/num"), "(" .. var_21_3 .. "/" .. var_21_2 .. ")")

	local var_21_4 = var_21_0:IsFinish()

	setActive(arg_21_2:Find("status/unfinish"), not var_21_4)
	setActive(arg_21_2:Find("status/finished"), var_21_4)

	local var_21_5, var_21_6 = arg_21_0.showVO:GetTraceParam()
	local var_21_7 = arg_21_2:Find("content/location")
	local var_21_8 = var_21_6 and var_21_6 == arg_21_1 + 1

	setActive(var_21_7, var_21_6 and var_21_6 == arg_21_1 + 1)

	if var_21_8 then
		arg_21_0:UpdateLocation(var_21_7, arg_21_0.showVO)
	end

	return
end

function var_0_0._SkipBtn(arg_22_0, arg_22_1)
	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(pg.island_main_btns[arg_22_1].ability_id) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_taskjump_systemnoopen_tips"))

		return
	end

	if pg.island_main_btns[arg_22_1].open_page ~= "" then
		arg_22_0:Hide()
		arg_22_0:emit(IslandMediator.OPEN_PAGE, pg.island_main_btns[arg_22_1].open_page, pg.island_main_btns[arg_22_1].page_param)
	end

	return
end

function var_0_0._SkipObj(arg_23_0, arg_23_1)
	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlockMap(pg.island_world_objects[arg_23_1].mapId) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_taskjump_placenoopen_tips"))

		return
	end

	arg_23_0:Hide(false)
	arg_23_0:emit(IslandBaseMediator.SWITCH_MAP, pg.island_world_objects[arg_23_1].mapId, pg.island_map[pg.island_world_objects[arg_23_1].mapId].born_object)

	return
end

function var_0_0.UpdateTargetBtnItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2:Find("btn")

	removeOnButton(var_24_0)
	setActive(var_24_0, false)

	if arg_24_0.showTargets[arg_24_1 + 1] then
		local var_24_1 = tonumber(pg.island_task_target[arg_24_0.showTargets[arg_24_1 + 1].id].tips)
		local var_24_2 = tonumber(pg.island_task_target[arg_24_0.showTargets[arg_24_1 + 1].id].jump_ui)

		if not arg_24_0.showTargets[arg_24_1 + 1]:IsFinish() then
			if tonumber(pg.island_task_target[arg_24_0.showTargets[arg_24_1 + 1].id].jump_ui) then
				setActive(var_24_0, true)
				onButton(arg_24_0, var_24_0, function()
					arg_24_0:_SkipBtn(var_24_2)

					return
				end, SFX_PANEL)
			elseif var_24_1 then
				if IslandMainBtnTipHelper.IsUnlock("map") and arg_24_0.curMapId ~= pg.island_world_objects[var_24_1].mapId then
					setActive(var_24_0, true)
					onButton(arg_24_0, var_24_0, function()
						arg_24_0:_SkipObj(var_24_1)

						return
					end, SFX_PANEL)
				end
			end
		end
	else
		setActive(var_24_0, false)

		local var_24_3 = tonumber(arg_24_0.showVO:getConfig("complete_data"))

		if var_24_3 and var_24_3 ~= 0 then
			if IslandMainBtnTipHelper.IsUnlock("map") and arg_24_0.curMapId ~= pg.island_world_objects[var_24_3].mapId then
				setActive(var_24_0, true)
				onButton(arg_24_0, var_24_0, function()
					arg_24_0:_SkipObj(var_24_3)

					return
				end, SFX_PANEL)
			end
		end
	end

	return
end

function var_0_0.Flush(arg_28_0)
	arg_28_0.selectedType = arg_28_0.selectedType or IslandTaskType.SHOW_ALL

	local var_28_0 = getProxy(IslandProxy):GetIsland()

	arg_28_0.curMapId = var_28_0:GetMapId()
	arg_28_0.taskAgency = var_28_0:GetTaskAgency()
	arg_28_0.trackTaskId = arg_28_0.taskAgency:GetTraceId()
	arg_28_0.showTaskDict = {}

	for iter_28_0, iter_28_1 in pairs((arg_28_0.taskAgency:GetShowTasks())) do
		local var_28_1 = iter_28_1:GetShowType()

		if var_28_1 then
			arg_28_0.showTaskDict[var_28_1] = arg_28_0.showTaskDict[var_28_1] or {}

			table.insert(arg_28_0.showTaskDict[var_28_1], iter_28_1)
		end
	end

	arg_28_0.showTypeList = {
		arg_28_0.selectedType
	}

	if arg_28_0.selectedType == IslandTaskType.SHOW_ALL then
		arg_28_0.showTypeList = arg_28_0:GetShowTypeList()
	end

	table.sort(arg_28_0.showTypeList)
	arg_28_0.typeUIList:align(#arg_28_0.showTypeList)
	arg_28_0:PingFirstTask()

	return
end

function var_0_0.FlushTypeUIList(arg_29_0)
	arg_29_0.typeUIList:align(#arg_29_0.showTypeList)

	local var_29_0 = {}

	arg_29_0.typeUIList:eachActive(function(arg_30_0, arg_30_1)
		arg_30_1:GetComponent(typeof(CanvasGroup)).alpha = 0

		table.insert(var_29_0, function(arg_31_0)
			arg_30_1:GetComponent(typeof(Animation)):Play()

			arg_30_1:GetComponent(typeof(CanvasGroup)).alpha = 1

			arg_29_0:managedTween(LeanTween.delayedCall, function()
				arg_31_0()

				return
			end, 0.06, nil)

			return
		end)

		return
	end)
	seriesAsync({})

	return
end

function var_0_0.PingFirstTask(arg_33_0)
	local var_33_0 = underscore.detect(arg_33_0.showTypeList, function(arg_34_0)
		return arg_33_0.showTaskDict[arg_34_0] and #arg_33_0.showTaskDict[arg_34_0] > 0
	end)

	if var_33_0 then
		triggerToggle(arg_33_0.typeUIList.container:Find(var_33_0 .. "/list"):GetChild(0), true)
	else
		arg_33_0.selectedTaskId = nil

		arg_33_0:FlushDetail()
	end

	return
end

function var_0_0.FlushDetail(arg_35_0)
	arg_35_0.trackTaskId = arg_35_0.taskAgency:GetTraceId()

	setActive(arg_35_0.detailTF, arg_35_0.selectedTaskId)
	setActive(arg_35_0.emptyTF, not arg_35_0.selectedTaskId)

	arg_35_0.showVO = arg_35_0.taskAgency:GetTask(arg_35_0.selectedTaskId)

	if arg_35_0.selectedTaskId and arg_35_0.showVO then
		arg_35_0.detailAnim:Play()

		local var_35_0 = arg_35_0.showVO:GetShowType()

		LoadImageSpriteAtlasAsync("ui/island3dtaskui_atlas", "title_bg_" .. IslandTaskType.ShowTypeFields[var_35_0], arg_35_0.titleBg)
		LoadImageSpriteAtlasAsync("ui/island3dtaskui_atlas", "title_icon_" .. IslandTaskType.ShowTypeFields[var_35_0], arg_35_0.typeIcon)
		setText(arg_35_0.nameTF, arg_35_0.showVO:GetName())

		local var_35_1 = var_35_0 == IslandTaskType.SHOW_ACTIVITY and arg_35_0.showVO.endTime ~= 0

		setActive(arg_35_0.timeTF, var_35_0 == IslandTaskType.SHOW_ACTIVITY and arg_35_0.showVO.endTime ~= 0)

		if var_35_1 then
			setText(arg_35_0.timeTF:Find("Text"), arg_35_0.showVO:GetRemainTimeStr())
		end

		arg_35_0.richtext.text = arg_35_0.showVO:GetDesc()

		arg_35_0.richtext:RemoveAllListeners()
		arg_35_0.richtext:AddListener(function(arg_36_0, arg_36_1)
			if arg_36_0 == "dropDesHandle" then
				local var_36_0, var_36_1 = string.match(arg_36_1, "{(%d+),(%d+)}")

				arg_35_0:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = Drop.New({
						count = 0,
						type = tonumber(var_36_0),
						id = tonumber(var_36_1)
					})
				})
			end

			return
		end)

		arg_35_0.showTargets = arg_35_0.showVO:GetTargetList()

		local var_35_2 = not arg_35_0.showVO:IsSubmitImmediately() and arg_35_0.showVO:IsFinish()

		arg_35_0.targetUIList:align(#arg_35_0.showTargets)
		setActive(arg_35_0.finishedTargetTF, var_35_2)

		if var_35_2 then
			setText(arg_35_0.finishedTargetTextTF, arg_35_0.showVO:GetFinishedDesc())
			arg_35_0:UpdateLocation(arg_35_0.finishedTargetLocTF, arg_35_0.showVO)
		end

		arg_35_0.targetBtnUIList:align(#arg_35_0.showTargets + (var_35_2 and 1 or 0))

		arg_35_0.showAwards = arg_35_0.showVO:GetAwards()

		arg_35_0.awardUIList:align(#arg_35_0.showAwards)

		local var_35_3 = arg_35_0.showVO:GetType() == IslandTaskType.MAIN
		local var_35_4 = var_35_3 and IslandTaskTrackCard.TYPES.MAIN or IslandTaskTrackCard.TYPES.OTHER

		setActive(arg_35_0.traceBtn, not var_35_3 and arg_35_0.showVO.id ~= arg_35_0.trackTaskId)
		onButton(arg_35_0, arg_35_0.traceBtn, function()
			arg_35_0:emit(IslandMediator.ON_SET_TRACE_ID, arg_35_0.showVO.id, var_35_4)

			return
		end, SFX_PANEL)
		setActive(arg_35_0.tracedBtn, var_35_3 or arg_35_0.showVO.id == arg_35_0.trackTaskId)
		onButton(arg_35_0, arg_35_0.tracedBtn, function()
			if var_35_3 then
				return
			end

			arg_35_0:emit(IslandMediator.ON_SET_TRACE_ID, 0, var_35_4)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.OnShow(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0.isOpen = true
	arg_39_0.toggleList = arg_39_0:GetShowTypeList()

	table.insert(arg_39_0.toggleList, 1, IslandTaskType.SHOW_ALL)
	arg_39_0.toggleUIList:align(#arg_39_0.toggleList)
	arg_39_0:Flush()

	local var_39_0 = false

	if arg_39_1 and arg_39_0.toggleUIList.container:Find(arg_39_1) then
		triggerToggle(arg_39_0.toggleUIList.container:Find(arg_39_1), true)

		var_39_0 = true
	end

	local var_39_1 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

	if var_39_1:GetTask(arg_39_2 or 0) then
		if not var_39_0 then
			triggerToggle(arg_39_0.toggleUIList.container:GetChild(0), true)
		end

		triggerToggle(arg_39_0.typeUIList.container:Find(IslandTaskType.Type2ShowType[pg.island_task[arg_39_2].type] .. "/list/" .. arg_39_2), true)
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_39_0._tf)

	return
end

function var_0_0.GetShowTypeList(arg_40_0)
	local var_40_0 = getProxy(IslandProxy):GetIsland():GetAblityAgency()
	local var_40_1 = underscore.select(underscore.keys(IslandTaskType.ShowTypeUnlockId), function(arg_41_0)
		return var_40_0:HasAbility(IslandTaskType.ShowTypeUnlockId[arg_41_0])
	end)

	table.sort(var_40_1)

	return var_40_1
end

function var_0_0.OnHide(arg_42_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_42_0._tf)

	return
end

function var_0_0.OnDisable(arg_43_0)
	arg_43_0:OnHide()

	return
end

function var_0_0.OnDestroy(arg_44_0)
	arg_44_0.richtext:RemoveAllListeners()
	arg_44_0:OnHide()

	return
end

return var_0_0
