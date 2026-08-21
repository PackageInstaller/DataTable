local var_0_0 = class("WorldMediaCollectionStoryLineView")

var_0_0.START_GAP = 800
var_0_0.END_GAP = 1000
var_0_0.HRZ_GAP = 467
var_0_0.CHAPTER_PROGRESS_MIN_WIDTH = 120
var_0_0.NATION_LIST = {
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

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.tf = arg_1_1

	arg_1_0:init()
	arg_1_0:ConfigData()
	arg_1_0:UpdateView()

	return
end

function var_0_0.init(arg_2_0)
	arg_2_0.contentHeight = 0
	arg_2_0.nodeTpl = arg_2_0.tf:Find("Story/NodeTemplate")
	arg_2_0.nodeContainer = arg_2_0.tf:Find("Story/Nodes/Viewport/Content")
	arg_2_0.scroll = arg_2_0.tf:Find("Story/Nodes")

	arg_2_0.scroll:GetComponent(typeof(ScrollRect)).onValueChanged:AddListener(function()
		arg_2_0:onScroll()

		return
	end)

	arg_2_0.progressMark = arg_2_0.tf:Find("ChapterProgress/bg/progressMark")
	arg_2_0.progressCurrentMark = arg_2_0.tf:Find("ChapterProgress/bg/currentMark")
	arg_2_0.linkHrzTpl = arg_2_0.tf:Find("Story/Horizon")
	arg_2_0.linkVrtTpl = arg_2_0.tf:Find("Story/Vertical")

	arg_2_0:initFilter()

	arg_2_0.detailView = arg_2_0.tf:Find("NodeDetail")
	arg_2_0.gotoBtn = arg_2_0.detailView:Find("goto_btn")

	setText(arg_2_0.detailView:Find("camp/label/text"), i18n("storyline_camp"))
	setText(arg_2_0.gotoBtn:Find("text"), i18n("storyline_goto"))

	arg_2_0.filterBtn = arg_2_0.tf:Find("Filter")

	onButton(arg_2_0, arg_2_0.filterBtn, function()
		arg_2_0:showFilter()

		return
	end)
	onButton(arg_2_0, arg_2_0.gotoBtn, function()
		arg_2_0:gotoStory()

		return
	end)
	onButton(arg_2_0, arg_2_0.scroll, function()
		arg_2_0:HideNodeDetail()

		return
	end)

	return
end

function var_0_0.initFilter(arg_7_0)
	arg_7_0.filterDict = {}
	arg_7_0.filter = arg_7_0.tf:Find("NodeFilter")
	arg_7_0.filterCancel = arg_7_0.tf:Find("NodeFilter/cancel")
	arg_7_0.filterConfirm = arg_7_0.tf:Find("NodeFilter/confirm")

	onButton(arg_7_0, arg_7_0.filterCancel, function()
		arg_7_0:cancelFilter()

		return
	end)
	onButton(arg_7_0, arg_7_0.filterConfirm, function()
		arg_7_0:confirmFilter()

		return
	end)
	setText(arg_7_0.tf:Find("NodeFilter/label/cn"), i18n("indexsort_camp"))
	setText(arg_7_0.tf:Find("NodeFilter/label/en"), i18n("indexsort_campeng"))

	arg_7_0.filterTFDict = {}

	local var_7_0 = arg_7_0.tf:Find("NodeFilter/content")
	local var_7_1 = arg_7_0.tf:Find("NodeFilter/content/camp")

	for iter_7_0, iter_7_1 in ipairs(var_0_0.NATION_LIST) do
		local var_7_2 = cloneTplTo(var_7_1, var_7_0)

		arg_7_0.filterTFDict[iter_7_1.key] = var_7_2

		setActive(var_7_2, true)
		onButton(arg_7_0, var_7_2, function()
			arg_7_0:updateFilterList(iter_7_1.key)

			return
		end)
		setText(var_7_2:Find("Text"), i18n(iter_7_1.name))
	end

	arg_7_0:updateFilterList(-1)

	return
end

function var_0_0.updateFilterList(arg_11_0, arg_11_1)
	if arg_11_1 == -1 then
		if arg_11_0.filterDict[-1] then
			return
		else
			arg_11_0.filterDict = {
				[-1] = true
			}
		end
	elseif arg_11_0.filterDict[arg_11_1] then
		arg_11_0.filterDict[arg_11_1] = nil
	else
		arg_11_0.filterDict[arg_11_1] = true
	end

	local var_11_0 = true

	for iter_11_0, iter_11_1 in pairs(arg_11_0.filterDict) do
		if iter_11_0 ~= -1 then
			var_11_0 = false

			break
		end
	end

	arg_11_0.filterDict[-1] = var_11_0 and true or nil

	for iter_11_2, iter_11_3 in ipairs(var_0_0.NATION_LIST) do
		setActive(arg_11_0.filterTFDict[iter_11_3.key]:Find("on"), arg_11_0.filterDict[iter_11_3.key])
		setActive(arg_11_0.filterTFDict[iter_11_3.key]:Find("off"), not arg_11_0.filterDict[iter_11_3.key])
	end

	return
end

function var_0_0.ConfigCallback(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.storyJumpCallback = arg_12_1
	arg_12_0.recordJumpCallback = arg_12_2

	return
end

function var_0_0.ConfigData(arg_13_0)
	arg_13_0.memoryNodeDict = {}
	arg_13_0.chapterHead = {}

	for iter_13_0, iter_13_1 in ipairs(pg.memory_storyline.all) do
		local var_13_0 = MemoryStoryLineNode.New({
			configId = iter_13_1
		})
		local var_13_1 = var_13_0:GetColumn()

		arg_13_0.memoryNodeDict[var_13_1] = arg_13_0.memoryNodeDict[var_13_1] or {}

		table.insert(arg_13_0.memoryNodeDict[var_13_1], var_13_0)

		local var_13_2 = var_13_0:GetChapter()

		if arg_13_0.chapterHead[var_13_2] == nil or var_13_0:GetColumn() < arg_13_0.chapterHead[var_13_2]:GetColumn() then
			arg_13_0.chapterHead[var_13_2] = var_13_0
		end
	end

	return
end

function var_0_0.UpdateView(arg_14_0)
	arg_14_0:updateNodeTree()
	arg_14_0:updateNodeLine()
	arg_14_0:updateChapterProgress()
	arg_14_0:onScroll()

	return
end

function var_0_0.updateChapterProgress(arg_15_0)
	arg_15_0.progressDict = {}
	arg_15_0.chapterProgress = arg_15_0.tf:Find("ChapterProgress")
	arg_15_0.chapterProgressContainer = arg_15_0.chapterProgress:Find("bg")
	arg_15_0.chapterProgressSplit = arg_15_0.chapterProgress:Find("bg/splitTpl")
	arg_15_0.chapterProgressLabel = arg_15_0.chapterProgress:Find("bg/chapterLabelTpl")
	arg_15_0.chapterProgressTotalWidth = rtf(arg_15_0.chapterProgressContainer).rect.width

	local var_15_0 = {}
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_0.nodeDataDict) do
		var_15_1 = var_15_1 + 1

		local var_15_2 = iter_15_1.VO:GetChapter()

		if var_15_0[var_15_2] then
			var_15_0[var_15_2] = var_15_0[var_15_2] + 1 or 1
		end
	end

	for iter_15_2, iter_15_3 in pairs(var_15_0) do
		table.insert({}, iter_15_2)
	end

	table.sort({})

	if #{} == 0 then
		return
	end

	local var_15_3 = math.min(var_0_0.CHAPTER_PROGRESS_MIN_WIDTH, arg_15_0.chapterProgressTotalWidth / #{})
	local var_15_4 = {}
	local var_15_5 = arg_15_0.chapterProgressTotalWidth
	local var_15_6 = var_15_1

	while true and var_15_6 > 0 do
		local var_15_7 = false

		for iter_15_4, iter_15_5 in ipairs({}) do
			if not ({})[iter_15_5] then
				if var_15_3 > var_15_5 * (var_15_0[iter_15_5] / var_15_6) then
					var_15_4[iter_15_5] = var_15_3
					;({})[iter_15_5] = true
					var_15_5 = var_15_5 - var_15_3
					var_15_6 = var_15_6 - var_15_0[iter_15_5]
					var_15_7 = true
				end
			end
		end
	end

	for iter_15_6, iter_15_7 in ipairs({}) do
		if not ({})[iter_15_7] then
			if var_15_6 > 0 then
				var_15_4[iter_15_7] = var_15_5 * (var_15_0[iter_15_7] / var_15_6) or 0
			end
		end
	end

	for iter_15_8, iter_15_9 in ipairs({}) do
		if iter_15_8 > 1 then
			local var_15_8 = cloneTplTo(arg_15_0.chapterProgressSplit, arg_15_0.chapterProgressContainer)

			setActive(var_15_8, true)

			var_15_8.anchoredPosition = Vector2(({
				w = var_15_4[iter_15_9],
				x = 0
			}).x, 2.86)
		end

		;({
			w = var_15_4[iter_15_9],
			x = 0
		}).leftBound = ({
			w = var_15_4[iter_15_9],
			x = 0
		}).x
		;({
			w = var_15_4[iter_15_9],
			x = 0
		}).rightBound = ({
			w = var_15_4[iter_15_9],
			x = 0
		}).x + ({
			w = var_15_4[iter_15_9],
			x = 0
		}).w

		local var_15_9 = cloneTplTo(arg_15_0.chapterProgressLabel, arg_15_0.chapterProgressContainer)

		var_15_9.anchoredPosition = Vector2(({
			w = var_15_4[iter_15_9],
			x = 0
		}).x, 12)
		rtf(var_15_9).sizeDelta = Vector2(({
			w = var_15_4[iter_15_9],
			x = 0
		}).w, 32)

		setText(var_15_9, i18n("storyline_chapter" .. iter_15_9))
		setActive(var_15_9, true)
		onButton(arg_15_0, var_15_9:Find("chapterWarpBtn"), function()
			scrollTo(arg_15_0.scroll, (arg_15_0.nodeDataDict[arg_15_0.chapterHead[iter_15_9]:GetConfigID()].nodeTF.anchoredPosition.x - var_0_0.START_GAP) / arg_15_0.contentWidth)

			return
		end)

		arg_15_0.progressDict[iter_15_9] = {
			w = var_15_4[iter_15_9],
			x = 0
		}
	end

	return
end

function var_0_0.showFilter(arg_17_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_17_0.filter)

	for iter_17_0, iter_17_1 in ipairs(var_0_0.NATION_LIST) do
		setActive(arg_17_0.filterTFDict[iter_17_1.key]:Find("on"), arg_17_0.filterDict[iter_17_1.key])
		setActive(arg_17_0.filterTFDict[iter_17_1.key]:Find("off"), not arg_17_0.filterDict[iter_17_1.key])
	end

	setActive(arg_17_0.filter, true)

	arg_17_0.filterSnapShot = Clone(arg_17_0.filterDict)

	return
end

function var_0_0.cancelFilter(arg_18_0)
	arg_18_0.filterDict = arg_18_0.filterSnapShot

	arg_18_0:closeFilter()

	return
end

function var_0_0.confirmFilter(arg_19_0)
	arg_19_0:updateNodes()
	arg_19_0:closeFilter()

	return
end

function var_0_0.closeFilter(arg_20_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_20_0.filter, arg_20_0.tf)

	arg_20_0.filterSnapShot = nil

	setActive(arg_20_0.filter, false)

	return
end

function var_0_0.refresh(arg_21_0)
	arg_21_0.selectedID = nil

	arg_21_0:closeFilter()
	arg_21_0:HideNodeDetail()
	setActive(arg_21_0.detailView, false)
	scrollTo(arg_21_0.scroll, 0)

	return
end

function var_0_0.ShowNodeDetail(arg_22_0, arg_22_1)
	if arg_22_0.selectedID then
		setActive(arg_22_0.nodeDataDict[arg_22_0.selectedID].nodeTF:Find("info/selected"), false)
		setActive(arg_22_0.nodeDataDict[arg_22_0.selectedID].nodeTF:Find("info/selected_multi"), false)
	end

	arg_22_0.selectedID = arg_22_1

	setActive(arg_22_0.detailView, true)
	quickPlayAnimation(arg_22_0.detailView, "anim_WorldMediaCollectionMemoryGroupUI_NodeDetail_enter")
	setText(arg_22_0.detailView:Find("info/title"), arg_22_0.nodeDataDict[arg_22_1].VO:GetName())
	setText(arg_22_0.detailView:Find("info/desc/content"), arg_22_0.nodeDataDict[arg_22_1].VO:GetDesc())
	LoadImageSpriteAsync("memorystoryline/" .. arg_22_0.nodeDataDict[arg_22_1].VO:GetIcon(), arg_22_0.detailView:Find("info/icon"), true)
	LoadImageSpriteAtlasAsync("ui/worldmediacollectionmemoryui_atlas", arg_22_0.nodeDataDict[arg_22_1].VO:GetMark(), arg_22_0.detailView:Find("info/icon/mark"), true)

	local var_22_0 = arg_22_0.nodeDataDict[arg_22_1].VO:GetNations()

	eachChild(arg_22_0.detailView:Find("camp/nations"), function(arg_23_0)
		local var_23_0 = tonumber(arg_23_0.name)

		setActive(arg_23_0, table.contains(var_22_0, var_23_0))
		setActive(arg_23_0:Find("filter"), arg_22_0.filterDict[var_23_0])

		return
	end)

	local var_22_1 = arg_22_0.nodeDataDict[arg_22_1].nodeTF
	local var_22_2 = false

	for iter_22_0, iter_22_1 in pairs(arg_22_0.filterDict) do
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

	scrollTo(arg_22_0.scroll, (var_22_1.anchoredPosition.x - var_0_0.START_GAP) / arg_22_0.contentWidth)
	arg_22_0:TryPlayBGM()

	return
end

function var_0_0.TryPlayBGM(arg_24_0)
	if arg_24_0.selectedID then
		pg.BgmMgr.GetInstance():TempPlay(arg_24_0.nodeDataDict[arg_24_0.selectedID].VO:GetBGM())
	end

	return
end

function var_0_0.HideNodeDetail(arg_25_0)
	if arg_25_0.selectedID then
		setActive(arg_25_0.nodeDataDict[arg_25_0.selectedID].nodeTF:Find("info/selected"), false)
		setActive(arg_25_0.nodeDataDict[arg_25_0.selectedID].nodeTF:Find("info/selected_multi"), false)
		quickPlayAnimation(arg_25_0.detailView, "anim_WorldMediaCollectionMemoryGroupUI_NodeDetail_quit")

		arg_25_0.selectedID = false

		pg.BgmMgr.GetInstance():ContinuePlay()
	end

	return
end

function var_0_0.onScroll(arg_26_0)
	arg_26_0.progressMark.anchoredPosition.x = Mathf.Clamp(-arg_26_0.nodeContainer.anchoredPosition.x / arg_26_0.contentWidth, 0, 1) * arg_26_0.chapterProgressTotalWidth
	arg_26_0.progressMark.anchoredPosition = arg_26_0.progressMark.anchoredPosition

	local var_26_0 = 0

	for iter_26_0, iter_26_1 in pairs(arg_26_0.progressDict) do
		if arg_26_0.progressMark.anchoredPosition.x >= iter_26_1.leftBound and arg_26_0.progressMark.anchoredPosition.x <= iter_26_1.rightBound then
			var_26_0 = iter_26_0
		end
	end

	arg_26_0:updateCurrentChapterMark(var_26_0)

	local var_26_1 = -math.modf(arg_26_0.nodeContainer.anchoredPosition.x / var_0_0.HRZ_GAP) + 1
	local var_26_2
	local var_26_3

	for iter_26_2 = var_26_1 - 2, var_26_1 + 2 do
		for iter_26_3, iter_26_4 in ipairs(arg_26_0.nodeDataDict) do
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

	if var_26_4 ~= arg_26_0.contentHeight then
		arg_26_0.contentHeight = var_26_4

		if LeanTween.isTweening(arg_26_0.nodeContainer.gameObject) then
			LeanTween.cancel(arg_26_0.nodeContainer.gameObject)
		end

		LeanTween.moveY(rtf(arg_26_0.nodeContainer), var_26_4, 0.5)
	end

	return
end

function var_0_0.updateCurrentChapterMark(arg_27_0, arg_27_1)
	if arg_27_0.currentChapter ~= arg_27_1 then
		arg_27_0.progressCurrentMark.sizeDelta = Vector2(arg_27_0.progressDict[arg_27_1].w, rtf(arg_27_0.progressCurrentMark).rect.height)
		arg_27_0.progressCurrentMark.anchoredPosition.x = arg_27_0.progressDict[arg_27_1].x
		arg_27_0.progressCurrentMark.anchoredPosition = arg_27_0.progressCurrentMark.anchoredPosition
	end

	arg_27_0.currentChapter = arg_27_1

	return
end

function var_0_0.gotoStory(arg_28_0)
	pg.BgmMgr.GetInstance():ContinuePlay()

	local var_28_0 = arg_28_0.nodeDataDict[arg_28_0.selectedID].VO:GetMemoryID()
	local var_28_1 = arg_28_0.nodeDataDict[arg_28_0.selectedID].VO:GetWorldID()

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

		arg_28_0.storyJumpCallback(pg.memory_group[var_28_2], var_28_3)
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

		arg_28_0.recordJumpCallback(var_28_4, var_28_5, arg_28_0.selectedID)
	end

	return
end

function var_0_0.updateNodes(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.nodeDataDict) do
		local var_29_0 = iter_29_1.VO:GetNations()

		if not iter_29_1.VO:IsMemoryBlock() then
			local var_29_1 = false

			for iter_29_2, iter_29_3 in pairs(arg_29_0.filterDict) do
				if table.contains(var_29_0, iter_29_2) then
					var_29_1 = true

					break
				end
			end

			setActive(iter_29_1.nodeTF:Find("info/selected_filter"), var_29_1)
		end
	end

	if arg_29_0.selectedID then
		local var_29_2 = arg_29_0.nodeDataDict[arg_29_0.selectedID].VO:GetNations()
		local var_29_3 = false

		for iter_29_4, iter_29_5 in pairs(arg_29_0.filterDict) do
			if table.contains(var_29_2, iter_29_4) then
				var_29_3 = true

				break
			end
		end

		if var_29_3 then
			setActive(arg_29_0.nodeDataDict[arg_29_0.selectedID].nodeTF:Find("info/selected_multi"), true)
			setActive(arg_29_0.nodeDataDict[arg_29_0.selectedID].nodeTF:Find("info/selected"), false)
		else
			setActive(arg_29_0.nodeDataDict[arg_29_0.selectedID].nodeTF:Find("info/selected_multi"), false)
			setActive(arg_29_0.nodeDataDict[arg_29_0.selectedID].nodeTF:Find("info/selected"), true)
		end

		eachChild(arg_29_0.detailView:Find("camp/nations"), function(arg_30_0)
			local var_30_0 = tonumber(arg_30_0.name)

			setActive(arg_30_0, table.contains(var_29_2, var_30_0))
			setActive(arg_30_0:Find("filter"), arg_29_0.filterDict[var_30_0])

			return
		end)
	end

	return
end

function var_0_0.updateNodeTree(arg_31_0)
	arg_31_0.nodeDataDict = {}
	arg_31_0.nodeMap = {}

	local var_31_0

	for iter_31_0, iter_31_1 in pairs(arg_31_0.memoryNodeDict) do
		for iter_31_2, iter_31_3 in ipairs(iter_31_1) do
			local var_31_3 = {}
			local var_31_4 = cloneTplTo(arg_31_0.nodeTpl, arg_31_0.nodeContainer)

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
				onButton(arg_31_0, var_31_4, function()
					arg_31_0:ShowNodeDetail(iter_31_3:GetConfigID())

					return
				end)
			end

			local var_31_5 = var_0_0.START_GAP + (iter_31_0 - 1) * var_0_0.HRZ_GAP
			local var_31_6 = iter_31_3:GetRow()

			var_31_4.anchoredPosition = Vector2(var_0_0.START_GAP + (iter_31_0 - 1) * var_0_0.HRZ_GAP, -var_31_6 * 254)
			var_31_0 = var_31_5 + var_0_0.END_GAP
			var_31_3.nodeTF = var_31_4
			var_31_3.row = var_31_6
			var_31_3.col = iter_31_0
			var_31_3.linkData = {}
			var_31_3.VO = iter_31_3
			arg_31_0.nodeMap[iter_31_0] = arg_31_0.nodeMap[iter_31_0] or {}
			arg_31_0.nodeMap[iter_31_0][var_31_6] = true
			arg_31_0.nodeDataDict[iter_31_3:GetConfigID()] = var_31_3
		end
	end

	arg_31_0.nodeTail = arg_31_0.tf:Find("Story/NodeTail")

	setActive(arg_31_0.nodeTail, false)
	arg_31_0:sortLinkData()

	arg_31_0.nodeContainer.sizeDelta.x = var_31_0
	arg_31_0.nodeContainer.sizeDelta = arg_31_0.nodeContainer.sizeDelta
	arg_31_0.contentWidth = rtf(arg_31_0.nodeContainer).rect.width - rtf(arg_31_0.scroll).rect.width

	return
end

function var_0_0.sortLinkData(arg_33_0)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.nodeDataDict) do
		if type(iter_33_1.VO:GetLinkEvent()) == "table" then
			for iter_33_2, iter_33_3 in ipairs(iter_33_1.VO:GetLinkEvent()) do
				if arg_33_0.nodeDataDict[iter_33_3].col < iter_33_1.col then
					if not table.contains(arg_33_0.nodeDataDict[iter_33_3].linkData, iter_33_0) then
						table.insert(arg_33_0.nodeDataDict[iter_33_3].linkData, iter_33_0)
					end
				else
					table.insert(iter_33_1.linkData, iter_33_3)
				end
			end
		end
	end

	return
end

function var_0_0.updateNodeLine(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.nodeDataDict) do
		local var_34_0 = iter_34_1.VO:GetColumn()

		for iter_34_2, iter_34_3 in ipairs(iter_34_1.linkData) do
			if arg_34_0.nodeDataDict[iter_34_3].VO:GetColumn() == var_34_0 then
				arg_34_0:linkVRTLine(iter_34_1, arg_34_0.nodeDataDict[iter_34_3])
			elseif iter_34_1.row == arg_34_0.nodeDataDict[iter_34_3].row then
				arg_34_0:linkHRZLine(iter_34_1, arg_34_0.nodeDataDict[iter_34_3])
			else
				arg_34_0:linkBranchLine(iter_34_1, arg_34_0.nodeDataDict[iter_34_3])
			end
		end
	end

	return
end

var_0_0.VRT_LINE_POS = Vector2(0, -150)

function var_0_0.linkVRTLine(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_1.row < arg_35_2.row and arg_35_1 or arg_35_2
	local var_35_2 = tf(Instantiate(arg_35_0.linkVrtTpl))

	setActive(var_35_2, true)
	var_35_2:SetParent(var_35_0.nodeTF, false)

	var_35_2.anchoredPosition = var_0_0.VRT_LINE_POS

	return
end

var_0_0.HRZ_LINE_POS = Vector2(185, 0)

function var_0_0.linkHRZLine(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_1.VO:GetColumn() < arg_36_2.VO:GetColumn() and arg_36_1 or arg_36_2
	local var_36_2 = tf(Instantiate(arg_36_0.linkHrzTpl))

	setActive(var_36_2, true)
	var_36_2:SetParent(var_36_0.nodeTF, false)

	var_36_2.anchoredPosition = var_0_0.HRZ_LINE_POS

	return
end

var_0_0.UP_POS = Vector2(-3.5, 100)
var_0_0.DOWN_POS = Vector2(0, -105)
var_0_0.RIGHT_POS = Vector2(185, 0)

function var_0_0.linkBranchLine(arg_37_0, arg_37_1, arg_37_2)
	local var_37_1
	local var_37_2
	local var_37_3 = arg_37_1.VO:GetColumn()
	local var_37_4 = arg_37_2.VO:GetColumn()
	local var_37_5 = arg_37_1.row
	local var_37_6 = arg_37_2.row
	local var_37_7 = "Right"
	local var_37_8 = arg_37_2.row < arg_37_1.row and "Up" or "Down"

	if not arg_37_0.nodeMap[var_37_3 + 1][arg_37_1.row] then
		var_37_2 = var_37_7 .. var_37_8
		var_37_1 = var_0_0.RIGHT_POS
	elseif var_37_6 < var_37_5 and not arg_37_0.nodeMap[var_37_3][var_37_5 - 1] or var_37_5 < var_37_6 and not arg_37_0.nodeMap[var_37_3][var_37_5 + 1] then
		var_37_2 = var_37_8 .. var_37_7
		var_37_1 = var_37_6 < var_37_5 and var_0_0.UP_POS or var_0_0.DOWN_POS
	else
		var_37_2 = var_37_7 .. var_37_8 .. "Lite"
		var_37_1 = var_0_0.RIGHT_POS
	end

	if math.abs(var_37_5 - var_37_6) == 2 and not (var_37_2 .. "Extend") then
		-- block empty
	end

	local var_37_9 = tf((Instantiate(arg_37_0.tf:Find("Story/" .. var_37_2))))

	setActive(var_37_9, true)
	var_37_9:SetParent(arg_37_1.nodeTF, false)

	var_37_9.anchoredPosition = var_37_1

	return
end

function var_0_0.Dispose(arg_38_0)
	pg.DelegateInfo.Dispose(arg_38_0)

	if LeanTween.isTweening(arg_38_0.nodeContainer.gameObject) then
		LeanTween.cancel(arg_38_0.nodeContainer.gameObject)
	end

	return
end

return var_0_0
