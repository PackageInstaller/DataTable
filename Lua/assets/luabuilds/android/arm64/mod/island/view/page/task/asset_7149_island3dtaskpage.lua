local Island3dTaskPage = class("Island3dTaskPage", import("...base.IslandBasePage"))

function Island3dTaskPage:getUIName()
	return "Island3dTaskUI"
end

function Island3dTaskPage:OnLoaded()
	local var_2_0 = self._tf:Find("adapt/toggles/content")

	self.toggleUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	local var_2_1 = self._tf:Find("adapt/types/content")

	self.typeUIList = UIItemList.New(var_2_1, var_2_1:Find("type_tpl"))
	self.detailAnim = self._tf:Find("adapt/detail"):GetComponent(typeof(Animation))
	self.emptyTF = self._tf:Find("adapt/detail/empty")
	self.detailTF = self._tf:Find("adapt/detail/content")
	self.titleBg = self.detailTF:Find("title")
	self.typeIcon = self.detailTF:Find("title/icon")
	self.nameTF = self.detailTF:Find("title/icon/name")
	self.timeTF = self.detailTF:Find("title/time")
	self.descTF = self.detailTF:Find("view/Viewport/content/desc")
	self.targetTF = self.detailTF:Find("view/Viewport/content/targets")

	setText(self.targetTF:Find("Text"), i18n("island_task_target"))

	self.finishedTargetTF = self.targetTF:Find("content/finished")
	self.finishedTargetTextTF = self.finishedTargetTF:Find("Text")
	self.finishedTargetLocTF = self.finishedTargetTF:Find("location")
	self.targetContent = self.targetTF:Find("content/list")
	self.targetUIList = UIItemList.New(self.targetContent, self.targetContent:Find("tpl"))
	self.targetBtnUIList = UIItemList.New(self.detailTF:Find("view/Viewport/btns"), self.detailTF:Find("view/Viewport/btns/tpl"))
	self.awardsTF = self.detailTF:Find("awards")

	setText(self.awardsTF:Find("title/Text"), i18n("island_task_award"))

	local var_2_2 = self.awardsTF:Find("view/mask/content")

	self.awardUIList = UIItemList.New(var_2_2, var_2_2:Find("tpl"))
	self.detailBtns = self.detailTF:Find("btns")
	self.traceBtn = self.detailBtns:Find("trace")

	setText(self.traceBtn:Find("Text"), i18n("island_task_tracking"))

	self.tracedBtn = self.detailBtns:Find("traced")

	setText(self.tracedBtn:Find("Text"), i18n("island_task_tracked"))
	setText(self._tf:Find("top/title/Text"), i18n("island_task_title"))
	setText(self._tf:Find("top/title/Text/en"), i18n("island_task_title_en"))

	self.richtext = self.descTF:GetComponent("RichText")

	return
end

function Island3dTaskPage:OnInit()
	onButton(self, self._tf:Find("top/back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	self.toggleUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			self:InitToggleItem(arg_5_1, arg_5_2)
		end

		return
	end)
	self.typeUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:UpdateTypeItem(arg_6_1, arg_6_2)
		end

		return
	end)
	self.targetUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateTargetItem(arg_7_1, arg_7_2)
		end

		return
	end)
	self.targetBtnUIList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			self:UpdateTargetBtnItem(arg_8_1, arg_8_2)
		end

		return
	end)
	self.awardUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = self.showAwards[arg_9_1 + 1]

			updateCustomDrop(arg_9_2, self.showAwards[arg_9_1 + 1])
			onButton(self, arg_9_2, function()
				self:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_9_0
				})

				return
			end)
		end

		return
	end)

	return
end

function Island3dTaskPage:AddListeners()
	self:AddListener(GAME.ISLAND_SET_TRACE_TASK_DONE, self.FlushDetail)
	self:AddListener(GAME.ISLAND_ACCEPT_TASK_DONE, self.Flush)
	self:AddListener(GAME.ISLAND_SUBMIT_TASK_DONE, self.Flush)
	self:AddListener(GAME.ISLAND_UPDATE_TASK_DONE, self.Flush)
	self:AddListener(GAME.ISLAND_GET_RANDOM_REFRESH_TASK_DONE, self.Flush)
	self:AddListener(IslandTaskAgency.TASK_ADDED, self.Flush)
	self:AddListener(IslandTaskAgency.TASK_UPDATED, self.Flush)
	self:AddListener(IslandTaskAgency.TASK_REMOVED, self.Flush)

	return
end

function Island3dTaskPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_SET_TRACE_TASK_DONE, self.FlushDetail)
	self:RemoveListener(GAME.ISLAND_ACCEPT_TASK_DONE, self.Flush)
	self:RemoveListener(GAME.ISLAND_SUBMIT_TASK_DONE, self.Flush)
	self:RemoveListener(GAME.ISLAND_UPDATE_TASK_DONE, self.Flush)
	self:RemoveListener(GAME.ISLAND_GET_RANDOM_REFRESH_TASK_DONE, self.Flush)
	self:RemoveListener(IslandTaskAgency.TASK_ADDED, self.Flush)
	self:RemoveListener(IslandTaskAgency.TASK_UPDATED, self.Flush)
	self:RemoveListener(IslandTaskAgency.TASK_REMOVED, self.Flush)

	return
end

function Island3dTaskPage:InitToggleItem(arg_13_1, arg_13_2)
	local var_13_0 = self.toggleList[arg_13_1 + 1]

	arg_13_2.name = self.toggleList[arg_13_1 + 1]

	setText(arg_13_2:Find("unsel"), IslandTaskType.ShowTypeNames[self.toggleList[arg_13_1 + 1]])
	setText(arg_13_2:Find("sel/content/Text"), IslandTaskType.ShowTypeNames[self.toggleList[arg_13_1 + 1]])

	if self.toggleList[arg_13_1 + 1] ~= IslandTaskType.SHOW_ALL then
		LoadImageSpriteAtlasAsync("island/islandtasktype", IslandTaskType.ShowTypeFields[self.toggleList[arg_13_1 + 1]], arg_13_2:Find("sel/content/Image"), false)
	end

	onToggle(self, arg_13_2, function(arg_14_0)
		if arg_14_0 and (not self.selectedType or self.selectedType ~= var_13_0) then
			self.selectedType = var_13_0

			self:Flush()
			arg_13_2:GetComponent(typeof(Animation)):Play()
		end

		return
	end, SFX_PANEL)

	return
end

function Island3dTaskPage:UpdateTypeItem(arg_15_1, arg_15_2)
	local var_15_0 = self.showTypeList[arg_15_1 + 1]

	arg_15_2.name = self.showTypeList[arg_15_1 + 1]

	setText(arg_15_2:Find("title/Text"), IslandTaskType.ShowTypeNames[var_15_0])
	setImageColor(arg_15_2:Find("title"), Color.NewHex(IslandTaskType.ShowTypeColors[var_15_0]))
	LoadImageSpriteAtlasAsync("island/islandtasktype", IslandTaskType.ShowTypeFields[var_15_0], arg_15_2:Find("title/Image"))
	setActive(arg_15_2:Find("line"), arg_15_1 + 1 ~= #self.showTypeList)

	local var_15_1 = UIItemList.New(arg_15_2:Find("list"), arg_15_2:Find("list"):GetChild(0))

	var_15_1:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			self:UpdateTaskItem(arg_16_2, self.showTaskDict[var_15_0][arg_16_1 + 1])
		end

		return
	end)
	var_15_1:align(#((self.showTaskDict[var_15_0] or nil) and (self.showTaskDict[var_15_0] or {})))

	return
end

function Island3dTaskPage:UpdateTaskItem(arg_17_1, arg_17_2)
	arg_17_1.name = arg_17_2.id

	local var_17_0 = arg_17_2:GetShowType()

	setImageColor(arg_17_1:Find("main/line"), Color.NewHex(IslandTaskType.ShowTypeColors[var_17_0]))

	local var_17_1 = arg_17_2:IsSeries()

	setText(arg_17_1:Find("main/name"), var_17_1 and arg_17_2:GetSeriesTitle() or arg_17_2:GetName())
	setActive(arg_17_1:Find("sub"), var_17_1)
	setActive(arg_17_1:Find("main/location"), not var_17_1)

	if var_17_1 then
		LoadImageSpriteAtlasAsync("ui/island3dtaskui_atlas", "color_" .. IslandTaskType.ShowTypeFields[var_17_0], arg_17_1:Find("sub/bg"))
		setText(arg_17_1:Find("sub/name"), arg_17_2:GetName())
		self:UpdateLocation(arg_17_1:Find("sub/location"), arg_17_2)
	else
		self:UpdateLocation(arg_17_1:Find("main/location"), arg_17_2)
	end

	onToggle(self, arg_17_1, function(arg_18_0)
		setActive(arg_17_1:Find("main/selected"), arg_18_0 and not var_17_1)
		setActive(arg_17_1:Find("sub/selected"), arg_18_0 and var_17_1)

		if arg_18_0 and (not self.selectedTaskId or self.selectedTaskId ~= arg_17_2.id or self.isOpen) then
			self.selectedTaskId = arg_17_2.id

			self:FlushDetail()

			self.isOpen = false
		end

		return
	end, SFX_PANEL)

	return
end

function Island3dTaskPage:UpdateLocation(arg_19_1, arg_19_2)
	setActive(arg_19_1, arg_19_2.id == self.trackTaskId)

	if arg_19_2.id == self.trackTaskId then
		local var_19_0 = tonumber((arg_19_2:GetTraceParam()))

		setActive(arg_19_1, var_19_0)

		if var_19_0 then
			setText(arg_19_1:Find("Text"), pg.island_world_objects[var_19_0].mapId == self.curMapId and self:CalcDistance(var_19_0) .. "m" or pg.island_map[pg.island_world_objects[var_19_0].mapId].name)
		end
	end

	return
end

function Island3dTaskPage:CalcDistance(arg_20_1)
	local var_20_0 = _IslandCore:GetView():GetPlayerPosition()
	local var_20_1 = _IslandCore:GetView():GetUnitPosition(arg_20_1)

	var_20_1 = var_20_1 or var_20_0

	return math.ceil((Vector3.Distance(var_20_0, var_20_1)))
end

function Island3dTaskPage:UpdateTargetItem(arg_21_1, arg_21_2)
	local var_21_0 = self.showTargets[arg_21_1 + 1]

	setText(arg_21_2:Find("content/Text"), self.showTargets[arg_21_1 + 1]:getConfig("name"))

	local var_21_1 = var_21_0:GetProgress()
	local var_21_2 = var_21_0:GetTargetNum()

	setText(arg_21_2:Find("content/num"), "(" .. (var_21_1 < var_21_2 and setColorStr(var_21_1, "#dd374e") or var_21_1) .. "/" .. var_21_2 .. ")")

	local var_21_3 = var_21_0:IsFinish()

	setActive(arg_21_2:Find("status/unfinish"), not var_21_3)
	setActive(arg_21_2:Find("status/finished"), var_21_3)

	local var_21_4, var_21_5 = self.showVO:GetTraceParam()
	local var_21_6 = arg_21_2:Find("content/location")
	local var_21_7 = var_21_5 and var_21_5 == arg_21_1 + 1

	setActive(var_21_6, var_21_5 and var_21_5 == arg_21_1 + 1)

	if var_21_7 then
		self:UpdateLocation(var_21_6, self.showVO)
	end

	return
end

function Island3dTaskPage:_SkipBtn(arg_22_1)
	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(pg.island_main_btns[arg_22_1].ability_id) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_taskjump_systemnoopen_tips"))

		return
	end

	if pg.island_main_btns[arg_22_1].open_page ~= "" then
		self:Hide()
		self:emit(IslandMediator.OPEN_PAGE, pg.island_main_btns[arg_22_1].open_page, pg.island_main_btns[arg_22_1].page_param)
	end

	return
end

function Island3dTaskPage:_SkipObj(arg_23_1)
	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlockMap(pg.island_world_objects[arg_23_1].mapId) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_taskjump_placenoopen_tips"))

		return
	end

	self:Hide(false)
	self:emit(IslandBaseMediator.SWITCH_MAP, pg.island_world_objects[arg_23_1].mapId, pg.island_map[pg.island_world_objects[arg_23_1].mapId].born_object)

	return
end

function Island3dTaskPage:UpdateTargetBtnItem(arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2:Find("btn")

	removeOnButton(var_24_0)
	setActive(var_24_0, false)

	if self.showTargets[arg_24_1 + 1] then
		local var_24_1 = tonumber(pg.island_task_target[self.showTargets[arg_24_1 + 1].id].tips)
		local var_24_2 = tonumber(pg.island_task_target[self.showTargets[arg_24_1 + 1].id].jump_ui)

		if not self.showTargets[arg_24_1 + 1]:IsFinish() then
			if var_24_2 then
				setActive(var_24_0, true)
				onButton(self, var_24_0, function()
					self:_SkipBtn(var_24_2)

					return
				end, SFX_PANEL)
			elseif var_24_1 then
				if IslandMainBtnTipHelper.IsUnlock("map") and self.curMapId ~= pg.island_world_objects[var_24_1].mapId then
					setActive(var_24_0, true)
					onButton(self, var_24_0, function()
						self:_SkipObj(var_24_1)

						return
					end, SFX_PANEL)
				end
			end
		end
	else
		setActive(var_24_0, false)

		local var_24_3 = tonumber(self.showVO:getConfig("complete_data"))

		if var_24_3 and var_24_3 ~= 0 then
			if IslandMainBtnTipHelper.IsUnlock("map") and self.curMapId ~= pg.island_world_objects[var_24_3].mapId then
				setActive(var_24_0, true)
				onButton(self, var_24_0, function()
					self:_SkipObj(var_24_3)

					return
				end, SFX_PANEL)
			end
		end
	end

	return
end

function Island3dTaskPage:Flush()
	self.selectedType = self.selectedType or IslandTaskType.SHOW_ALL

	local var_28_0 = getProxy(IslandProxy):GetIsland()

	self.curMapId = var_28_0:GetMapId()
	self.taskAgency = var_28_0:GetTaskAgency()
	self.trackTaskId = self.taskAgency:GetTraceId()
	self.showTaskDict = {}

	for iter_28_0, iter_28_1 in pairs((self.taskAgency:GetShowTasks())) do
		local var_28_1 = iter_28_1:GetShowType()

		if var_28_1 then
			self.showTaskDict[var_28_1] = self.showTaskDict[var_28_1] or {}

			table.insert(self.showTaskDict[var_28_1], iter_28_1)
		end
	end

	self.showTypeList = {
		self.selectedType
	}

	if self.selectedType == IslandTaskType.SHOW_ALL then
		self.showTypeList = self:GetShowTypeList()
	end

	table.sort(self.showTypeList)
	self.typeUIList:align(#self.showTypeList)
	self:PingFirstTask()

	return
end

function Island3dTaskPage:FlushTypeUIList()
	self.typeUIList:align(#self.showTypeList)

	local var_29_0 = {}

	self.typeUIList:eachActive(function(arg_30_0, arg_30_1)
		arg_30_1:GetComponent(typeof(CanvasGroup)).alpha = 0

		table.insert(var_29_0, function(arg_31_0)
			arg_30_1:GetComponent(typeof(Animation)):Play()

			arg_30_1:GetComponent(typeof(CanvasGroup)).alpha = 1

			self:managedTween(LeanTween.delayedCall, function()
				arg_31_0()

				return
			end, 0.06, nil)

			return
		end)

		return
	end)
	seriesAsync(var_29_0)

	return
end

function Island3dTaskPage:PingFirstTask()
	local var_33_0 = underscore.detect(self.showTypeList, function(arg_34_0)
		return self.showTaskDict[arg_34_0] and #self.showTaskDict[arg_34_0] > 0
	end)

	if var_33_0 then
		triggerToggle(self.typeUIList.container:Find(var_33_0 .. "/list"):GetChild(0), true)
	else
		self.selectedTaskId = nil

		self:FlushDetail()
	end

	return
end

function Island3dTaskPage:FlushDetail()
	self.trackTaskId = self.taskAgency:GetTraceId()

	setActive(self.detailTF, self.selectedTaskId)
	setActive(self.emptyTF, not self.selectedTaskId)

	self.showVO = self.taskAgency:GetTask(self.selectedTaskId)

	if self.selectedTaskId and self.showVO then
		self.detailAnim:Play()

		local var_35_0 = self.showVO:GetShowType()

		LoadImageSpriteAtlasAsync("ui/island3dtaskui_atlas", "title_bg_" .. IslandTaskType.ShowTypeFields[var_35_0], self.titleBg)
		LoadImageSpriteAtlasAsync("ui/island3dtaskui_atlas", "title_icon_" .. IslandTaskType.ShowTypeFields[var_35_0], self.typeIcon)
		setText(self.nameTF, self.showVO:GetName())

		local var_35_1 = var_35_0 == IslandTaskType.SHOW_ACTIVITY and self.showVO.endTime ~= 0

		setActive(self.timeTF, var_35_0 == IslandTaskType.SHOW_ACTIVITY and self.showVO.endTime ~= 0)

		if var_35_1 then
			setText(self.timeTF:Find("Text"), self.showVO:GetRemainTimeStr())
		end

		self.richtext.text = self.showVO:GetDesc()

		self.richtext:RemoveAllListeners()
		self.richtext:AddListener(function(arg_36_0, arg_36_1)
			if arg_36_0 == "dropDesHandle" then
				local var_36_0, var_36_1 = string.match(arg_36_1, "{(%d+),(%d+)}")

				self:ShowMsgBox({
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

		self.showTargets = self.showVO:GetTargetList()

		local var_35_2 = not self.showVO:IsSubmitImmediately() and self.showVO:IsFinish()

		self.targetUIList:align(#self.showTargets)
		setActive(self.finishedTargetTF, var_35_2)

		if var_35_2 then
			setText(self.finishedTargetTextTF, self.showVO:GetFinishedDesc())
			self:UpdateLocation(self.finishedTargetLocTF, self.showVO)
		end

		self.targetBtnUIList:align(#self.showTargets + (var_35_2 and 1 or 0))

		self.showAwards = self.showVO:GetAwards()

		self.awardUIList:align(#self.showAwards)

		local var_35_3 = self.showVO:GetType() == IslandTaskType.MAIN

		if var_35_3 then
			local var_35_4 = IslandTaskTrackCard.TYPES.MAIN or IslandTaskTrackCard.TYPES.OTHER
		end

		setActive(self.traceBtn, not var_35_3 and self.showVO.id ~= self.trackTaskId)
		onButton(self, self.traceBtn, function()
			self:emit(IslandMediator.ON_SET_TRACE_ID, self.showVO.id, var_35_4)

			return
		end, SFX_PANEL)
		setActive(self.tracedBtn, var_35_3 or self.showVO.id == self.trackTaskId)
		onButton(self, self.tracedBtn, function()
			if var_35_3 then
				return
			end

			self:emit(IslandMediator.ON_SET_TRACE_ID, 0, var_35_4)

			return
		end, SFX_PANEL)
	end

	return
end

function Island3dTaskPage:OnShow(arg_39_1, arg_39_2)
	self.isOpen = true
	self.toggleList = self:GetShowTypeList()

	table.insert(self.toggleList, 1, IslandTaskType.SHOW_ALL)
	self.toggleUIList:align(#self.toggleList)
	self:Flush()

	local var_39_0 = false

	if arg_39_1 and self.toggleUIList.container:Find(arg_39_1) then
		triggerToggle(self.toggleUIList.container:Find(arg_39_1), true)

		var_39_0 = true
	end

	if getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTask(arg_39_2 or 0) then
		if not var_39_0 then
			triggerToggle(self.toggleUIList.container:GetChild(0), true)
		end

		triggerToggle(self.typeUIList.container:Find(IslandTaskType.Type2ShowType[pg.island_task[arg_39_2].type] .. "/list/" .. arg_39_2), true)
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function Island3dTaskPage:GetShowTypeList()
	local var_40_0 = getProxy(IslandProxy):GetIsland():GetAblityAgency()
	local var_40_1 = underscore.select(underscore.keys(IslandTaskType.ShowTypeUnlockId), function(arg_41_0)
		return var_40_0:HasAbility(IslandTaskType.ShowTypeUnlockId[arg_41_0])
	end)

	table.sort(var_40_1)

	return var_40_1
end

function Island3dTaskPage:OnHide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function Island3dTaskPage:OnDisable()
	self:OnHide()

	return
end

function Island3dTaskPage:OnDestroy()
	self.richtext:RemoveAllListeners()
	self:OnHide()

	return
end

return Island3dTaskPage
