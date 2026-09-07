local WorldMediaCollectionStoryLineView = class("WorldMediaCollectionStoryLineView")

WorldMediaCollectionStoryLineView.START_GAP = 800
WorldMediaCollectionStoryLineView.END_GAP = 1000
WorldMediaCollectionStoryLineView.HRZ_GAP = 467
WorldMediaCollectionStoryLineView.CHAPTER_PROGRESS_MIN_WIDTH = 120
WorldMediaCollectionStoryLineView.NATION_LIST = {
	{
		name = "word_shipNation_all",
		key = -1
	},
	{
		name = "word_shipNation_baiYing",
		key = 1
	},
	{
		name = "word_shipNation_huangJia",
		key = 2
	},
	{
		name = "word_shipNation_chongYing",
		key = 3
	},
	{
		name = "word_shipNation_tieXue",
		key = 4
	},
	{
		name = "word_shipNation_dongHuang",
		key = 5
	},
	{
		name = "word_shipNation_saDing",
		key = 6
	},
	{
		name = "word_shipNation_beiLian",
		key = 7
	},
	{
		name = "word_shipNation_yuanwei",
		key = 10
	},
	{
		name = "word_shipNation_yujinwangguo",
		key = 11
	},
	{
		name = "word_shipNation_jinghuanlianmeng",
		key = 12
	},
	{
		name = "word_shipNation_meta_index",
		key = 97
	}
}

function WorldMediaCollectionStoryLineView:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self.tf = arg_1_1

	self:init()
	self:ConfigData()
	self:UpdateView()

	return
end

function WorldMediaCollectionStoryLineView:init()
	self.contentHeight = 0
	self.nodeTpl = self.tf:Find("Story/NodeTemplate")
	self.nodeContainer = self.tf:Find("Story/Nodes/Viewport/Content")
	self.scroll = self.tf:Find("Story/Nodes")

	self.scroll:GetComponent(typeof(ScrollRect)).onValueChanged:AddListener(function()
		self:onScroll()

		return
	end)

	self.progressMark = self.tf:Find("ChapterProgress/bg/progressMark")
	self.progressCurrentMark = self.tf:Find("ChapterProgress/bg/currentMark")
	self.linkHrzTpl = self.tf:Find("Story/Horizon")
	self.linkVrtTpl = self.tf:Find("Story/Vertical")

	self:initFilter()

	self.detailView = self.tf:Find("NodeDetail")
	self.gotoBtn = self.detailView:Find("goto_btn")

	setText(self.detailView:Find("camp/label/text"), i18n("storyline_camp"))
	setText(self.gotoBtn:Find("text"), i18n("storyline_goto"))

	self.filterBtn = self.tf:Find("Filter")

	onButton(self, self.filterBtn, function()
		self:showFilter()

		return
	end)
	onButton(self, self.gotoBtn, function()
		self:gotoStory()

		return
	end)
	onButton(self, self.scroll, function()
		self:HideNodeDetail()

		return
	end)

	return
end

function WorldMediaCollectionStoryLineView:initFilter()
	self.filterDict = {}
	self.filter = self.tf:Find("NodeFilter")
	self.filterCancel = self.tf:Find("NodeFilter/cancel")
	self.filterConfirm = self.tf:Find("NodeFilter/confirm")

	onButton(self, self.filterCancel, function()
		self:cancelFilter()

		return
	end)
	onButton(self, self.filterConfirm, function()
		self:confirmFilter()

		return
	end)
	setText(self.tf:Find("NodeFilter/label/cn"), i18n("indexsort_camp"))
	setText(self.tf:Find("NodeFilter/label/en"), i18n("indexsort_campeng"))

	self.filterTFDict = {}

	local var_7_0 = self.tf:Find("NodeFilter/content")
	local var_7_1 = self.tf:Find("NodeFilter/content/camp")

	for iter_7_0, iter_7_1 in ipairs(WorldMediaCollectionStoryLineView.NATION_LIST) do
		local var_7_2 = cloneTplTo(var_7_1, var_7_0)

		self.filterTFDict[iter_7_1.key] = var_7_2

		setActive(var_7_2, true)
		onButton(self, var_7_2, function()
			self:updateFilterList(iter_7_1.key)

			return
		end)
		setText(var_7_2:Find("Text"), i18n(iter_7_1.name))
	end

	self:updateFilterList(-1)

	return
end

function WorldMediaCollectionStoryLineView:updateFilterList(arg_11_1)
	if arg_11_1 == -1 then
		if self.filterDict[-1] then
			return
		else
			self.filterDict = {
				[-1] = true
			}
		end
	elseif self.filterDict[arg_11_1] then
		self.filterDict[arg_11_1] = nil
	else
		self.filterDict[arg_11_1] = true
	end

	local var_11_0 = true

	for iter_11_0, iter_11_1 in pairs(self.filterDict) do
		if iter_11_0 ~= -1 then
			var_11_0 = false

			break
		end
	end

	self.filterDict[-1] = var_11_0 and true or nil

	for iter_11_2, iter_11_3 in ipairs(WorldMediaCollectionStoryLineView.NATION_LIST) do
		setActive(self.filterTFDict[iter_11_3.key]:Find("on"), self.filterDict[iter_11_3.key])
		setActive(self.filterTFDict[iter_11_3.key]:Find("off"), not self.filterDict[iter_11_3.key])
	end

	return
end

function WorldMediaCollectionStoryLineView:ConfigCallback(arg_12_1, arg_12_2)
	self.storyJumpCallback = arg_12_1
	self.recordJumpCallback = arg_12_2

	return
end

function WorldMediaCollectionStoryLineView:ConfigData()
	self.memoryNodeDict = {}
	self.chapterHead = {}

	for iter_13_0, iter_13_1 in ipairs(pg.memory_storyline.all) do
		local var_13_0 = MemoryStoryLineNode.New({
			configId = iter_13_1
		})
		local var_13_1 = var_13_0:GetColumn()

		self.memoryNodeDict[var_13_1] = self.memoryNodeDict[var_13_1] or {}

		table.insert(self.memoryNodeDict[var_13_1], var_13_0)

		local var_13_2 = var_13_0:GetChapter()

		if self.chapterHead[var_13_2] == nil or var_13_0:GetColumn() < self.chapterHead[var_13_2]:GetColumn() then
			self.chapterHead[var_13_2] = var_13_0
		end
	end

	return
end

function WorldMediaCollectionStoryLineView:UpdateView()
	self:updateNodeTree()
	self:updateNodeLine()
	self:updateChapterProgress()
	self:onScroll()

	return
end

function WorldMediaCollectionStoryLineView:updateChapterProgress()
	self.progressDict = {}
	self.chapterProgress = self.tf:Find("ChapterProgress")
	self.chapterProgressContainer = self.chapterProgress:Find("bg")
	self.chapterProgressSplit = self.chapterProgress:Find("bg/splitTpl")
	self.chapterProgressLabel = self.chapterProgress:Find("bg/chapterLabelTpl")
	self.chapterProgressTotalWidth = rtf(self.chapterProgressContainer).rect.width

	local var_15_0 = {}
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in pairs(self.nodeDataDict) do
		var_15_1 = var_15_1 + 1

		local var_15_2 = iter_15_1.VO:GetChapter()

		if var_15_0[var_15_2] then
			var_15_0[var_15_2] = var_15_0[var_15_2] + 1 or 1
		end
	end

	local var_15_3 = {}

	for iter_15_2, iter_15_3 in pairs(var_15_0) do
		table.insert(var_15_3, iter_15_2)
	end

	table.sort(var_15_3)

	if #var_15_3 == 0 then
		return
	end

	local var_15_4 = math.min(WorldMediaCollectionStoryLineView.CHAPTER_PROGRESS_MIN_WIDTH, self.chapterProgressTotalWidth / #var_15_3)
	local var_15_5 = {}
	local var_15_6 = {}
	local var_15_7 = self.chapterProgressTotalWidth
	local var_15_8 = var_15_1

	while true and var_15_8 > 0 do
		local var_15_9 = false

		for iter_15_4, iter_15_5 in ipairs(var_15_3) do
			if not var_15_6[iter_15_5] then
				if var_15_4 > var_15_7 * (var_15_0[iter_15_5] / var_15_8) then
					var_15_5[iter_15_5] = var_15_4
					var_15_6[iter_15_5] = true
					var_15_7 = var_15_7 - var_15_4
					var_15_8 = var_15_8 - var_15_0[iter_15_5]
					var_15_9 = true
				end
			end
		end
	end

	for iter_15_6, iter_15_7 in ipairs(var_15_3) do
		if not var_15_6[iter_15_7] then
			if var_15_8 > 0 then
				var_15_5[iter_15_7] = var_15_7 * (var_15_0[iter_15_7] / var_15_8) or 0
			end
		end
	end

	for iter_15_8, iter_15_9 in ipairs(var_15_3) do
		local var_15_10 = {
			w = var_15_5[iter_15_9],
			x = 0
		}

		if iter_15_8 > 1 then
			local var_15_11 = cloneTplTo(self.chapterProgressSplit, self.chapterProgressContainer)

			setActive(var_15_11, true)

			var_15_11.anchoredPosition = Vector2(var_15_10.x, 2.86)
		end

		var_15_10.leftBound = var_15_10.x
		var_15_10.rightBound = var_15_10.x + var_15_10.w

		local var_15_12 = cloneTplTo(self.chapterProgressLabel, self.chapterProgressContainer)

		var_15_12.anchoredPosition = Vector2(var_15_10.x, 12)
		rtf(var_15_12).sizeDelta = Vector2(var_15_10.w, 32)

		setText(var_15_12, i18n("storyline_chapter" .. iter_15_9))
		setActive(var_15_12, true)
		onButton(self, var_15_12:Find("chapterWarpBtn"), function()
			scrollTo(self.scroll, (self.nodeDataDict[self.chapterHead[iter_15_9]:GetConfigID()].nodeTF.anchoredPosition.x - WorldMediaCollectionStoryLineView.START_GAP) / self.contentWidth)

			return
		end)

		self.progressDict[iter_15_9] = var_15_10
	end

	return
end

function WorldMediaCollectionStoryLineView:showFilter()
	pg.UIMgr.GetInstance():BlurPanel(self.filter)

	for iter_17_0, iter_17_1 in ipairs(WorldMediaCollectionStoryLineView.NATION_LIST) do
		setActive(self.filterTFDict[iter_17_1.key]:Find("on"), self.filterDict[iter_17_1.key])
		setActive(self.filterTFDict[iter_17_1.key]:Find("off"), not self.filterDict[iter_17_1.key])
	end

	setActive(self.filter, true)

	self.filterSnapShot = Clone(self.filterDict)

	return
end

function WorldMediaCollectionStoryLineView:cancelFilter()
	self.filterDict = self.filterSnapShot

	self:closeFilter()

	return
end

function WorldMediaCollectionStoryLineView:confirmFilter()
	self:updateNodes()
	self:closeFilter()

	return
end

function WorldMediaCollectionStoryLineView:closeFilter()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.filter, self.tf)

	self.filterSnapShot = nil

	setActive(self.filter, false)

	return
end

function WorldMediaCollectionStoryLineView:refresh()
	self.selectedID = nil

	self:closeFilter()
	self:HideNodeDetail()
	setActive(self.detailView, false)
	scrollTo(self.scroll, 0)

	return
end

function WorldMediaCollectionStoryLineView:ShowNodeDetail(arg_22_1)
	if self.selectedID then
		setActive(self.nodeDataDict[self.selectedID].nodeTF:Find("info/selected"), false)
		setActive(self.nodeDataDict[self.selectedID].nodeTF:Find("info/selected_multi"), false)
	end

	self.selectedID = arg_22_1

	setActive(self.detailView, true)
	quickPlayAnimation(self.detailView, "anim_WorldMediaCollectionMemoryGroupUI_NodeDetail_enter")
	setText(self.detailView:Find("info/title"), self.nodeDataDict[arg_22_1].VO:GetName())
	setText(self.detailView:Find("info/desc/content"), self.nodeDataDict[arg_22_1].VO:GetDesc())
	LoadImageSpriteAsync("memorystoryline/" .. self.nodeDataDict[arg_22_1].VO:GetIcon(), self.detailView:Find("info/icon"), true)
	LoadImageSpriteAtlasAsync("ui/worldmediacollectionmemoryui_atlas", self.nodeDataDict[arg_22_1].VO:GetMark(), self.detailView:Find("info/icon/mark"), true)

	local var_22_0 = self.nodeDataDict[arg_22_1].VO:GetNations()

	eachChild(self.detailView:Find("camp/nations"), function(arg_23_0)
		local var_23_0 = tonumber(arg_23_0.name)

		setActive(arg_23_0, table.contains(var_22_0, var_23_0))
		setActive(arg_23_0:Find("filter"), self.filterDict[var_23_0])

		return
	end)

	local var_22_1 = self.nodeDataDict[arg_22_1].nodeTF
	local var_22_2 = false

	for iter_22_0, iter_22_1 in pairs(self.filterDict) do
		if table.contains(var_22_0, iter_22_0) then
			var_22_2 = true

			break
		end
	end

	if var_22_2 then
		setActive(var_22_1:Find("info/selected_multi"), true)
	else
		setActive(var_22_1:Find("info/selected"), true)
	end

	scrollTo(self.scroll, (var_22_1.anchoredPosition.x - WorldMediaCollectionStoryLineView.START_GAP) / self.contentWidth)
	self:TryPlayBGM()

	return
end

function WorldMediaCollectionStoryLineView:TryPlayBGM()
	if self.selectedID then
		pg.BgmMgr.GetInstance():TempPlay(self.nodeDataDict[self.selectedID].VO:GetBGM())
	end

	return
end

function WorldMediaCollectionStoryLineView:HideNodeDetail()
	if self.selectedID then
		setActive(self.nodeDataDict[self.selectedID].nodeTF:Find("info/selected"), false)
		setActive(self.nodeDataDict[self.selectedID].nodeTF:Find("info/selected_multi"), false)
		quickPlayAnimation(self.detailView, "anim_WorldMediaCollectionMemoryGroupUI_NodeDetail_quit")

		self.selectedID = false

		pg.BgmMgr.GetInstance():ContinuePlay()
	end

	return
end

function WorldMediaCollectionStoryLineView:onScroll()
	self.progressMark.anchoredPosition.x = Mathf.Clamp(-self.nodeContainer.anchoredPosition.x / self.contentWidth, 0, 1) * self.chapterProgressTotalWidth
	self.progressMark.anchoredPosition = self.progressMark.anchoredPosition

	local var_26_0 = 0

	for iter_26_0, iter_26_1 in pairs(self.progressDict) do
		if self.progressMark.anchoredPosition.x >= iter_26_1.leftBound and self.progressMark.anchoredPosition.x <= iter_26_1.rightBound then
			var_26_0 = iter_26_0
		end
	end

	self:updateCurrentChapterMark(var_26_0)

	local var_26_1 = -math.modf(self.nodeContainer.anchoredPosition.x / WorldMediaCollectionStoryLineView.HRZ_GAP) + 1
	local var_26_2
	local var_26_3

	for iter_26_2 = var_26_1 - 2, var_26_1 + 2 do
		for iter_26_3, iter_26_4 in ipairs(self.nodeDataDict) do
			if iter_26_2 == iter_26_4.col then
				if iter_26_4.row == 2 then
					var_26_2 = true
				elseif iter_26_4.row == -1 then
					var_26_3 = true
				end
			end
		end
	end

	local var_26_4

	if var_26_2 and not var_26_3 then
		var_26_4 = 254
	elseif not var_26_2 then
		var_26_4 = 0
	elseif var_26_2 and var_26_3 then
		var_26_4 = 115
	end

	if var_26_4 ~= self.contentHeight then
		self.contentHeight = var_26_4

		if LeanTween.isTweening(self.nodeContainer.gameObject) then
			LeanTween.cancel(self.nodeContainer.gameObject)
		end

		LeanTween.moveY(rtf(self.nodeContainer), var_26_4, 0.5)
	end

	return
end

function WorldMediaCollectionStoryLineView:updateCurrentChapterMark(arg_27_1)
	if self.currentChapter ~= arg_27_1 then
		self.progressCurrentMark.sizeDelta = Vector2(self.progressDict[arg_27_1].w, rtf(self.progressCurrentMark).rect.height)
		self.progressCurrentMark.anchoredPosition.x = self.progressDict[arg_27_1].x
		self.progressCurrentMark.anchoredPosition = self.progressCurrentMark.anchoredPosition
	end

	self.currentChapter = arg_27_1

	return
end

function WorldMediaCollectionStoryLineView:gotoStory()
	pg.BgmMgr.GetInstance():ContinuePlay()

	local var_28_0 = self.nodeDataDict[self.selectedID].VO:GetMemoryID()
	local var_28_1 = self.nodeDataDict[self.selectedID].VO:GetWorldID()

	if var_28_0 ~= "" then
		local var_28_2
		local var_28_3

		if var_28_0[1] == 1 then
			var_28_2 = var_28_0[2]
		elseif var_28_0[1] == 2 then
			var_28_3 = var_28_0[2][1]

			for iter_28_0, iter_28_1 in ipairs(pg.memory_group.all) do
				if table.contains(pg.memory_group[iter_28_1].memories, var_28_3) then
					var_28_2 = iter_28_1

					break
				end
			end
		end

		self.storyJumpCallback(pg.memory_group[var_28_2], var_28_3)
	elseif var_28_1 ~= "" then
		local var_28_4
		local var_28_5

		if var_28_1[1] == 1 then
			var_28_4 = var_28_1[2]
		elseif var_28_1[1] == 2 then
			var_28_5 = var_28_1[2][1]

			for iter_28_2, iter_28_3 in ipairs(pg.world_collection_record_group.all) do
				if table.contains(pg.world_collection_record_group[iter_28_3].child, var_28_5) then
					var_28_4 = iter_28_3

					break
				end
			end
		end

		self.recordJumpCallback(var_28_4, var_28_5, self.selectedID)
	end

	return
end

function WorldMediaCollectionStoryLineView:updateNodes()
	for iter_29_0, iter_29_1 in pairs(self.nodeDataDict) do
		local var_29_0 = iter_29_1.VO:GetNations()

		if not iter_29_1.VO:IsMemoryBlock() then
			local var_29_1 = false

			for iter_29_2, iter_29_3 in pairs(self.filterDict) do
				if table.contains(var_29_0, iter_29_2) then
					var_29_1 = true

					break
				end
			end

			setActive(iter_29_1.nodeTF:Find("info/selected_filter"), var_29_1)
		end
	end

	if self.selectedID then
		local var_29_2 = self.nodeDataDict[self.selectedID].VO:GetNations()
		local var_29_3 = false

		for iter_29_4, iter_29_5 in pairs(self.filterDict) do
			if table.contains(var_29_2, iter_29_4) then
				var_29_3 = true

				break
			end
		end

		if var_29_3 then
			setActive(self.nodeDataDict[self.selectedID].nodeTF:Find("info/selected_multi"), true)
			setActive(self.nodeDataDict[self.selectedID].nodeTF:Find("info/selected"), false)
		else
			setActive(self.nodeDataDict[self.selectedID].nodeTF:Find("info/selected_multi"), false)
			setActive(self.nodeDataDict[self.selectedID].nodeTF:Find("info/selected"), true)
		end

		eachChild(self.detailView:Find("camp/nations"), function(arg_30_0)
			local var_30_0 = tonumber(arg_30_0.name)

			setActive(arg_30_0, table.contains(var_29_2, var_30_0))
			setActive(arg_30_0:Find("filter"), self.filterDict[var_30_0])

			return
		end)
	end

	return
end

function WorldMediaCollectionStoryLineView:updateNodeTree()
	self.nodeDataDict = {}
	self.nodeMap = {}

	local var_31_0

	for iter_31_0, iter_31_1 in pairs(self.memoryNodeDict) do
		for iter_31_2, iter_31_3 in ipairs(iter_31_1) do
			local var_31_3 = {}
			local var_31_4 = cloneTplTo(self.nodeTpl, self.nodeContainer)

			setActive(var_31_4, true)

			if iter_31_3:IsMemoryBlock() then
				LoadImageSpriteAtlasAsync("ui/worldmediacollectionmemoryui_atlas", "node_tail", var_31_4:Find("info/icon"))
				setText(var_31_4:Find("info/name"), iter_31_3:GetName())
				setActive(var_31_4:Find("info/name"), false)
				setActive(var_31_4:Find("info/mark"), false)
			else
				LoadImageSpriteAsync("memorystoryline/" .. iter_31_3:GetIcon(), var_31_4:Find("info/icon"), true)
				setText(var_31_4:Find("info/name"), iter_31_3:GetName())
				LoadImageSpriteAtlasAsync("ui/worldmediacollectionmemoryui_atlas", iter_31_3:GetMark(), var_31_4:Find("info/mark"))
				onButton(self, var_31_4, function()
					self:ShowNodeDetail(iter_31_3:GetConfigID())

					return
				end)
			end

			local var_31_5 = WorldMediaCollectionStoryLineView.START_GAP + (iter_31_0 - 1) * WorldMediaCollectionStoryLineView.HRZ_GAP
			local var_31_6 = iter_31_3:GetRow()

			var_31_4.anchoredPosition = Vector2(WorldMediaCollectionStoryLineView.START_GAP + (iter_31_0 - 1) * WorldMediaCollectionStoryLineView.HRZ_GAP, -var_31_6 * 254)
			var_31_0 = var_31_5 + WorldMediaCollectionStoryLineView.END_GAP
			var_31_3.nodeTF = var_31_4
			var_31_3.row = var_31_6
			var_31_3.col = iter_31_0
			var_31_3.linkData = {}
			var_31_3.VO = iter_31_3
			self.nodeMap[iter_31_0] = self.nodeMap[iter_31_0] or {}
			self.nodeMap[iter_31_0][var_31_6] = true
			self.nodeDataDict[iter_31_3:GetConfigID()] = var_31_3
		end
	end

	self.nodeTail = self.tf:Find("Story/NodeTail")

	setActive(self.nodeTail, false)
	self:sortLinkData()

	self.nodeContainer.sizeDelta.x = var_31_0
	self.nodeContainer.sizeDelta = self.nodeContainer.sizeDelta
	self.contentWidth = rtf(self.nodeContainer).rect.width - rtf(self.scroll).rect.width

	return
end

function WorldMediaCollectionStoryLineView:sortLinkData()
	for iter_33_0, iter_33_1 in pairs(self.nodeDataDict) do
		if type(iter_33_1.VO:GetLinkEvent()) == "table" then
			for iter_33_2, iter_33_3 in ipairs(iter_33_1.VO:GetLinkEvent()) do
				if self.nodeDataDict[iter_33_3].col < iter_33_1.col then
					if not table.contains(self.nodeDataDict[iter_33_3].linkData, iter_33_0) then
						table.insert(self.nodeDataDict[iter_33_3].linkData, iter_33_0)
					end
				else
					table.insert(iter_33_1.linkData, iter_33_3)
				end
			end
		end
	end

	return
end

function WorldMediaCollectionStoryLineView:updateNodeLine()
	for iter_34_0, iter_34_1 in pairs(self.nodeDataDict) do
		local var_34_0 = iter_34_1.VO:GetColumn()

		for iter_34_2, iter_34_3 in ipairs(iter_34_1.linkData) do
			if self.nodeDataDict[iter_34_3].VO:GetColumn() == var_34_0 then
				self:linkVRTLine(iter_34_1, self.nodeDataDict[iter_34_3])
			elseif iter_34_1.row == self.nodeDataDict[iter_34_3].row then
				self:linkHRZLine(iter_34_1, self.nodeDataDict[iter_34_3])
			else
				self:linkBranchLine(iter_34_1, self.nodeDataDict[iter_34_3])
			end
		end
	end

	return
end

WorldMediaCollectionStoryLineView.VRT_LINE_POS = Vector2(0, -150)

function WorldMediaCollectionStoryLineView:linkVRTLine(arg_35_1, arg_35_2)
	local var_35_0 = arg_35_1.row < arg_35_2.row and arg_35_1 or arg_35_2
	local var_35_2 = tf(Instantiate(self.linkVrtTpl))

	setActive(var_35_2, true)
	var_35_2:SetParent(var_35_0.nodeTF, false)

	var_35_2.anchoredPosition = WorldMediaCollectionStoryLineView.VRT_LINE_POS

	return
end

WorldMediaCollectionStoryLineView.HRZ_LINE_POS = Vector2(185, 0)

function WorldMediaCollectionStoryLineView:linkHRZLine(arg_36_1, arg_36_2)
	local var_36_0 = arg_36_1.VO:GetColumn() < arg_36_2.VO:GetColumn() and arg_36_1 or arg_36_2
	local var_36_2 = tf(Instantiate(self.linkHrzTpl))

	setActive(var_36_2, true)
	var_36_2:SetParent(var_36_0.nodeTF, false)

	var_36_2.anchoredPosition = WorldMediaCollectionStoryLineView.HRZ_LINE_POS

	return
end

WorldMediaCollectionStoryLineView.UP_POS = Vector2(-3.5, 100)
WorldMediaCollectionStoryLineView.DOWN_POS = Vector2(0, -105)
WorldMediaCollectionStoryLineView.RIGHT_POS = Vector2(185, 0)

function WorldMediaCollectionStoryLineView:linkBranchLine(arg_37_1, arg_37_2)
	local var_37_1
	local var_37_2
	local var_37_3 = arg_37_1.VO:GetColumn()
	local var_37_4 = arg_37_2.VO:GetColumn()
	local var_37_5 = arg_37_1.row
	local var_37_6 = arg_37_2.row
	local var_37_7 = "Right"
	local var_37_8 = arg_37_2.row < arg_37_1.row and "Up" or "Down"

	if not self.nodeMap[var_37_3 + 1][arg_37_1.row] then
		var_37_2 = var_37_7 .. var_37_8
		var_37_1 = WorldMediaCollectionStoryLineView.RIGHT_POS
	elseif var_37_6 < var_37_5 and not self.nodeMap[var_37_3][var_37_5 - 1] or var_37_5 < var_37_6 and not self.nodeMap[var_37_3][var_37_5 + 1] then
		var_37_2 = var_37_8 .. var_37_7
		var_37_1 = var_37_6 < var_37_5 and WorldMediaCollectionStoryLineView.UP_POS or WorldMediaCollectionStoryLineView.DOWN_POS
	else
		var_37_2 = var_37_7 .. var_37_8 .. "Lite"
		var_37_1 = WorldMediaCollectionStoryLineView.RIGHT_POS
	end

	if math.abs(var_37_5 - var_37_6) == 2 and not (var_37_2 .. "Extend") then
		-- block empty
	end

	local var_37_9 = tf((Instantiate(self.tf:Find("Story/" .. var_37_2))))

	setActive(var_37_9, true)
	var_37_9:SetParent(arg_37_1.nodeTF, false)

	var_37_9.anchoredPosition = var_37_1

	return
end

function WorldMediaCollectionStoryLineView:Dispose()
	pg.DelegateInfo.Dispose(self)

	if LeanTween.isTweening(self.nodeContainer.gameObject) then
		LeanTween.cancel(self.nodeContainer.gameObject)
	end

	return
end

return WorldMediaCollectionStoryLineView
