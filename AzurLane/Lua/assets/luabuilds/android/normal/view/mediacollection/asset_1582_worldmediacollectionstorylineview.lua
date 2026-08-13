class = var_0_10000

local var_0_0 = var_0_10000("WorldMediaCollectionStoryLineView")

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
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0.tf = arg_1_1

	arg_1_0:init()
	arg_1_0:ConfigData()
	arg_1_0:UpdateView()

	return
end

function var_0_0.init(arg_2_0)
	arg_2_0.contentHeight = 0

	local var_2_0 = arg_2_0.tf

	arg_2_0.nodeTpl = var_1.Find(var_2_0, "Story/NodeTemplate")

	local var_2_1 = arg_2_0.tf

	arg_2_0.nodeContainer = var_1.Find(var_2_1, "Story/Nodes/Viewport/Content")

	local var_2_2 = arg_2_0.tf

	arg_2_0.scroll = var_1.Find(var_2_2, "Story/Nodes")

	local var_2_3 = arg_2_0.scroll
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	ScrollRect = var_1_10004

	local var_2_5 = var_2_4(var_2_3, var_3(var_1_10004)).onValueChanged

	var_1.AddListener(var_2_5, function()
		local var_3_0 = arg_2_0

		var_0.onScroll(var_3_0)

		return
	end)

	local var_2_6 = arg_2_0.tf

	arg_2_0.progressMark = var_1.Find(var_2_6, "ChapterProgress/bg/progressMark")

	local var_2_7 = arg_2_0.tf

	arg_2_0.progressCurrentMark = var_1.Find(var_2_7, "ChapterProgress/bg/currentMark")

	local var_2_8 = arg_2_0.tf

	arg_2_0.linkHrzTpl = var_1.Find(var_2_8, "Story/Horizon")

	local var_2_9 = arg_2_0.tf

	arg_2_0.linkVrtTpl = var_1.Find(var_2_9, "Story/Vertical")

	arg_2_0:initFilter()

	local var_2_10 = arg_2_0.tf

	arg_2_0.detailView = var_1.Find(var_2_10, "NodeDetail")

	local var_2_11 = arg_2_0.detailView

	arg_2_0.gotoBtn = var_1.Find(var_2_11, "goto_btn")
	setText = var_1

	local var_2_12 = arg_2_0.detailView
	local var_2_13 = var_2.Find(var_2_12, "camp/label/text")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("storyline_camp"))

	setText = var_1

	local var_2_14 = arg_2_0.gotoBtn
	local var_2_15 = var_2.Find(var_2_14, "text")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("storyline_goto"))

	local var_2_16 = arg_2_0.tf

	arg_2_0.filterBtn = var_1.Find(var_2_16, "Filter")
	onButton = var_1

	var_1(arg_2_0, arg_2_0.filterBtn, function()
		local var_4_0 = arg_2_0

		var_0.showFilter(var_4_0)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.gotoBtn, function()
		local var_5_0 = arg_2_0

		var_0.gotoStory(var_5_0)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.scroll, function()
		local var_6_0 = arg_2_0

		var_0.HideNodeDetail(var_6_0)

		return
	end)

	return
end

function var_0_0.initFilter(arg_7_0)
	arg_7_0.filterDict = {}

	local var_7_0 = arg_7_0.tf

	arg_7_0.filter = var_1.Find(var_7_0, "NodeFilter")

	local var_7_1 = arg_7_0.tf

	arg_7_0.filterCancel = var_1.Find(var_7_1, "NodeFilter/cancel")

	local var_7_2 = arg_7_0.tf

	arg_7_0.filterConfirm = var_1.Find(var_7_2, "NodeFilter/confirm")
	onButton = var_1

	var_1(arg_7_0, arg_7_0.filterCancel, function()
		local var_8_0 = arg_7_0

		var_0.cancelFilter(var_8_0)

		return
	end)

	onButton = var_1

	var_1(arg_7_0, arg_7_0.filterConfirm, function()
		local var_9_0 = arg_7_0

		var_0.confirmFilter(var_9_0)

		return
	end)

	setText = var_1

	local var_7_3 = arg_7_0.tf
	local var_7_4 = var_2.Find(var_7_3, "NodeFilter/label/cn")

	i18n = var_7_3

	var_1(var_7_4, var_7_3("indexsort_camp"))

	setText = var_1

	local var_7_5 = arg_7_0.tf
	local var_7_6 = var_2.Find(var_7_5, "NodeFilter/label/en")

	i18n = var_7_5

	var_1(var_7_6, var_7_5("indexsort_campeng"))

	arg_7_0.filterTFDict = {}

	local var_7_7 = arg_7_0.tf
	local var_7_8 = var_1.Find(var_7_7, "NodeFilter/content")
	local var_7_9 = arg_7_0.tf
	local var_7_10 = var_2.Find(var_7_9, "NodeFilter/content/camp")

	ipairs = var_7_9

	for iter_7_0, iter_7_1 in var_7_9(var_0_0.NATION_LIST) do
		cloneTplTo = var_1_10008
		var_1_10008 = var_1_10008(var_7_10, var_7_8)

		local var_7_11 = arg_7_0.filterTFDict

		var_7_11[iter_7_1.key] = var_1_10008
		setActive = var_7_11

		var_7_11(var_1_10008, true)

		onButton = var_7_11

		var_7_11(arg_7_0, var_1_10008, function()
			local var_10_0 = arg_7_0

			var_0.updateFilterList(var_10_0, iter_7_1.key)

			return
		end)

		setText = var_7_11

		local var_7_12 = var_1_10008
		local var_7_13 = var_1_10008.Find(var_7_12, "Text")

		i18n = var_7_12

		var_7_11(var_7_13, var_7_12(iter_7_1.name))
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

	pairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0.filterDict) do
		if iter_11_0 ~= -1 then
			var_11_0 = false

			break
		end
	end

	local var_11_1 = arg_11_0.filterDict

	var_11_1[-1] = var_11_0 and true or nil
	ipairs = var_11_1

	for iter_11_2, iter_11_3 in var_11_1(var_0_0.NATION_LIST) do
		setActive = var_1_10008

		local var_11_2 = arg_11_0.filterTFDict[iter_11_3.key]

		var_1_10008(var_9.Find(var_11_2, "on"), arg_11_0.filterDict[iter_11_3.key])

		setActive = var_1_10008

		local var_11_3 = arg_11_0.filterTFDict[iter_11_3.key]

		var_1_10008(var_9.Find(var_11_3, "off"), not arg_11_0.filterDict[iter_11_3.key])
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
	pg = var_1

	local var_13_0 = var_1.memory_storyline

	ipairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(var_13_0.all) do
		MemoryStoryLineNode = var_1_10007

		local var_13_1 = var_1_10007.New({
			configId = iter_13_1
		})
		local var_13_2 = var_1_10007.GetColumn(var_13_1)
		local var_13_3 = arg_13_0.memoryNodeDict
		local var_13_4

		if not arg_13_0.memoryNodeDict[var_13_2] then
			var_13_4 = {}
		end

		var_13_3[var_13_2] = var_13_4
		table = var_13_3

		var_13_3.insert(arg_13_0.memoryNodeDict[var_13_2], var_1_10007)

		local var_13_5 = var_1_10007:GetChapter()

		if arg_13_0.chapterHead[var_13_5] ~= nil then
			local var_13_6 = var_1_10007:GetColumn()
			local var_13_7 = arg_13_0.chapterHead[var_13_5]

			if var_13_6 < var_11.GetColumn(var_13_7) then
				arg_13_0.chapterHead[var_13_5] = var_1_10007
			end
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

	local var_15_0 = arg_15_0.tf

	arg_15_0.chapterProgress = var_1.Find(var_15_0, "ChapterProgress")

	local var_15_1 = arg_15_0.chapterProgress

	arg_15_0.chapterProgressContainer = var_1.Find(var_15_1, "bg")

	local var_15_2 = arg_15_0.chapterProgress

	arg_15_0.chapterProgressSplit = var_1.Find(var_15_2, "bg/splitTpl")

	local var_15_3 = arg_15_0.chapterProgress

	arg_15_0.chapterProgressLabel = var_1.Find(var_15_3, "bg/chapterLabelTpl")
	rtf = var_1
	arg_15_0.chapterProgressTotalWidth = var_1(arg_15_0.chapterProgressContainer).rect.width

	local var_15_4 = {}
	local var_15_5 = 0

	pairs = var_3

	for iter_15_0, iter_15_1 in var_3(arg_15_0.nodeDataDict) do
		var_15_5 = var_15_5 + 1
		var_1_10009 = iter_15_1.VO

		if not var_15_4[var_8.GetChapter(var_1_10009)] or not (var_15_4[var_8] + 1) then
			var_1_10009 = 1
		end

		var_15_4[var_8] = var_1_10009
	end

	local var_15_6 = {}

	pairs = var_4

	for iter_15_2, iter_15_3 in var_4(var_15_4) do
		table = var_1_10009

		var_1_10009.insert(var_15_6, iter_15_2)
	end

	table = var_4

	var_4.sort(var_15_6)

	if #var_15_6 == 0 then
		return
	end

	math = var_5

	local var_15_7 = var_5.min(var_0_0.CHAPTER_PROGRESS_MIN_WIDTH, arg_15_0.chapterProgressTotalWidth / var_4)
	local var_15_8 = {}
	local var_15_9 = {}
	local var_15_10 = arg_15_0.chapterProgressTotalWidth
	local var_15_11 = var_15_5
	local var_15_12 = true

	while var_15_12 and 0 < var_15_11 do
		var_15_12 = false
		ipairs = var_1_10011

		for iter_15_4, iter_15_5 in var_1_10011(var_15_6) do
			if not var_15_9[iter_15_5] and var_15_7 > var_15_10 * (var_15_4[iter_15_5] / var_15_11) then
				var_15_8[iter_15_5] = var_15_7
				var_15_9[iter_15_5] = true
				var_15_10 = var_15_10 - var_15_7
				var_15_11 = var_15_11 - var_16
				var_15_12 = true
			end
		end
	end

	ipairs = var_1_10011

	for iter_15_6, iter_15_7 in var_1_10011(var_15_6) do
		if not var_15_9[iter_15_7] then
			local var_15_13

			if not (var_15_11 > 0) or not (var_15_10 * (var_15_4[iter_15_7] / var_15_11)) then
				var_15_13 = 0
			end

			var_15_8[iter_15_7] = var_15_13
		end
	end

	local var_15_14 = 0

	ipairs = var_12

	for iter_15_8, iter_15_9 in var_12(var_15_6) do
		local var_15_15 = {
			w = var_15_8[iter_15_9],
			x = var_15_14
		}

		if 1 < iter_15_8 then
			cloneTplTo = var_18

			local var_15_16 = var_18(arg_15_0.chapterProgressSplit, arg_15_0.chapterProgressContainer)

			setActive = var_19

			var_19(var_15_16, true)

			Vector2 = var_19
			var_15_16.anchoredPosition = var_19(var_15_15.x, 2.86)
		end

		var_15_15.leftBound = var_15_15.x
		var_15_15.rightBound = var_15_15.x + var_15_15.w
		cloneTplTo = var_18

		local var_15_17 = var_18(arg_15_0.chapterProgressLabel, arg_15_0.chapterProgressContainer)

		Vector2 = var_19
		var_15_17.anchoredPosition = var_19(var_15_15.x, 12)
		rtf = var_19

		local var_15_18 = var_19(var_15_17)

		Vector2 = var_20
		var_15_18.sizeDelta = var_20(var_15_15.w, 32)
		setText = var_15_18

		local var_15_19 = var_15_17

		i18n = var_21

		var_15_18(var_15_19, var_21("storyline_chapter" .. iter_15_9))

		setActive = var_15_18

		var_15_18(var_15_17, true)

		local var_15_20 = var_15_17
		local var_15_21 = var_15_17.Find(var_15_20, "chapterWarpBtn")

		onButton = var_15_20

		var_15_20(arg_15_0, var_15_21, function()
			local var_16_0 = arg_15_0.chapterHead[iter_15_9]
			local var_16_1 = var_0.GetConfigID(var_16_0)
			local var_16_2 = (arg_15_0.nodeDataDict[var_16_1].nodeTF.anchoredPosition.x - var_0_0.START_GAP) / arg_15_0.contentWidth

			scrollTo = var_2

			var_2(arg_15_0.scroll, var_16_2)

			return
		end)

		arg_15_0.progressDict[iter_15_9] = var_15_15
		var_15_14 = var_15_14 + var_15_15.w
	end

	return
end

function var_0_0.showFilter(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_17_0, arg_17_0.filter)

	ipairs = var_1

	for iter_17_0, iter_17_1 in var_1(var_0_0.NATION_LIST) do
		setActive = var_1_10006

		local var_17_1 = arg_17_0.filterTFDict[iter_17_1.key]

		var_1_10006(var_7.Find(var_17_1, "on"), arg_17_0.filterDict[iter_17_1.key])

		setActive = var_1_10006

		local var_17_2 = arg_17_0.filterTFDict[iter_17_1.key]

		var_1_10006(var_7.Find(var_17_2, "off"), not arg_17_0.filterDict[iter_17_1.key])
	end

	setActive = var_1

	var_1(arg_17_0.filter, true)

	Clone = var_1
	arg_17_0.filterSnapShot = var_1(arg_17_0.filterDict)

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
	pg = var_1_10001

	local var_20_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_20_0, arg_20_0.filter, arg_20_0.tf)

	arg_20_0.filterSnapShot = nil
	setActive = var_1

	var_1(arg_20_0.filter, false)

	return
end

function var_0_0.refresh(arg_21_0)
	arg_21_0.selectedID = nil

	arg_21_0:closeFilter()
	arg_21_0:HideNodeDetail()

	setActive = var_1

	var_1(arg_21_0.detailView, false)

	scrollTo = var_1

	var_1(arg_21_0.scroll, 0)

	return
end

function var_0_0.ShowNodeDetail(arg_22_0, arg_22_1)
	if arg_22_0.selectedID then
		local var_22_0 = arg_22_0.nodeDataDict[arg_22_0.selectedID].nodeTF

		setActive = var_1_10003

		var_1_10003(var_22_0:Find("info/selected"), false)

		setActive = var_1_10003

		var_1_10003(var_22_0:Find("info/selected_multi"), false)
	end

	arg_22_0.selectedID = arg_22_1

	local var_22_1 = arg_22_0.nodeDataDict[arg_22_1].VO

	setActive = var_1_10003

	var_1_10003(arg_22_0.detailView, true)

	quickPlayAnimation = var_1_10003

	var_1_10003(arg_22_0.detailView, "anim_WorldMediaCollectionMemoryGroupUI_NodeDetail_enter")

	setText = var_1_10003

	local var_22_2 = arg_22_0.detailView

	var_1_10003(var_4.Find(var_22_2, "info/title"), var_22_1:GetName())

	setText = var_1_10003

	local var_22_3 = arg_22_0.detailView

	var_1_10003(var_4.Find(var_22_3, "info/desc/content"), var_22_1:GetDesc())

	LoadImageSpriteAsync = var_1_10003

	local var_22_4 = "memorystoryline/" .. var_22_1:GetIcon()
	local var_22_5 = arg_22_0.detailView

	var_1_10003(var_22_4, var_5.Find(var_22_5, "info/icon"), true)

	LoadImageSpriteAtlasAsync = var_1_10003

	local var_22_6 = "ui/worldmediacollectionmemoryui_atlas"
	local var_22_7 = var_22_1:GetMark()
	local var_22_8 = arg_22_0.detailView

	var_1_10003(var_22_6, var_22_7, var_6.Find(var_22_8, "info/icon/mark"), true)

	local var_22_9 = arg_22_0.detailView
	local var_22_10 = var_3.Find(var_22_9, "camp/nations")
	local var_22_11 = var_22_1
	local var_22_12 = var_22_1.GetNations(var_22_11)

	eachChild = var_22_11

	var_22_11(var_22_10, function(arg_23_0)
		tonumber = var_2_10001

		local var_23_0 = var_2_10001(arg_23_0.name)

		setActive = var_2

		local var_23_1 = arg_23_0

		table = var_2_10004

		var_2(var_23_1, var_2_10004.contains(var_22_12, var_23_0))

		setActive = var_2

		var_2(arg_23_0:Find("filter"), arg_22_0.filterDict[var_23_0])

		return
	end)

	local var_22_13 = arg_22_0.nodeDataDict[arg_22_1].nodeTF
	local var_22_14 = false

	pairs = var_7

	for iter_22_0, iter_22_1 in var_7(arg_22_0.filterDict) do
		table = var_1_10012

		if var_1_10012.contains(var_22_12, iter_22_0) then
			var_22_14 = true

			break
		end
	end

	if var_22_14 then
		setActive = var_7

		var_7(var_22_13:Find("info/selected_multi"), true)
	else
		setActive = var_7

		var_7(var_22_13:Find("info/selected"), true)
	end

	local var_22_15 = (var_22_13.anchoredPosition.x - var_0_0.START_GAP) / arg_22_0.contentWidth

	scrollTo = var_8

	var_8(arg_22_0.scroll, var_22_15)
	arg_22_0:TryPlayBGM()

	return
end

function var_0_0.TryPlayBGM(arg_24_0)
	if arg_24_0.selectedID then
		local var_24_0 = arg_24_0.nodeDataDict[arg_24_0.selectedID].VO

		pg = var_2

		local var_24_1 = var_2.BgmMgr.GetInstance()

		var_2.TempPlay(var_24_1, var_24_0:GetBGM())
	end

	return
end

function var_0_0.HideNodeDetail(arg_25_0)
	if arg_25_0.selectedID then
		local var_25_0 = arg_25_0.nodeDataDict[arg_25_0.selectedID].nodeTF

		setActive = var_2

		var_2(var_25_0:Find("info/selected"), false)

		setActive = var_2

		var_2(var_25_0:Find("info/selected_multi"), false)

		quickPlayAnimation = var_2

		var_2(arg_25_0.detailView, "anim_WorldMediaCollectionMemoryGroupUI_NodeDetail_quit")

		arg_25_0.selectedID = false
		pg = var_2

		local var_25_1 = var_2.BgmMgr.GetInstance()

		var_2.ContinuePlay(var_25_1)
	end

	return
end

function var_0_0.onScroll(arg_26_0)
	Mathf = var_1_10001

	local var_26_0 = var_1_10001.Clamp(-arg_26_0.nodeContainer.anchoredPosition.x / arg_26_0.contentWidth, 0, 1)
	local var_26_1 = arg_26_0.progressMark.anchoredPosition

	var_26_1.x = var_26_0 * arg_26_0.chapterProgressTotalWidth
	arg_26_0.progressMark.anchoredPosition = var_26_1

	local var_26_2 = 0

	pairs = var_4

	for iter_26_0, iter_26_1 in var_4(arg_26_0.progressDict) do
		if var_26_1.x >= iter_26_1.leftBound and var_26_1.x <= iter_26_1.rightBound then
			var_26_2 = iter_26_0
		end
	end

	arg_26_0:updateCurrentChapterMark(var_26_2)

	math = var_4

	local var_26_3 = -var_4.modf(arg_26_0.nodeContainer.anchoredPosition.x / var_0_0.HRZ_GAP) + 1
	local var_26_4
	local var_26_5

	for iter_26_2 = var_26_3 - 2, var_26_3 + 2 do
		ipairs = var_1_10011

		for iter_26_3, iter_26_4 in var_1_10011(arg_26_0.nodeDataDict) do
			if iter_26_2 == iter_26_4.col then
				if iter_26_4.row == 2 then
					var_26_4 = true
				elseif iter_26_4.row == -1 then
					var_26_5 = true
				end
			end
		end
	end

	local var_26_6

	if var_26_4 and not var_26_5 then
		var_26_6 = 254
	elseif not var_26_4 then
		var_26_6 = 0
	elseif var_26_4 and var_26_5 then
		var_26_6 = 115
	end

	if var_26_6 ~= arg_26_0.contentHeight then
		arg_26_0.contentHeight = var_26_6
		LeanTween = var_8

		if var_8.isTweening(arg_26_0.nodeContainer.gameObject) then
			LeanTween = var_8

			var_8.cancel(arg_26_0.nodeContainer.gameObject)
		end

		LeanTween = var_8

		local var_26_7 = var_8.moveY

		rtf = var_9

		var_26_7(var_9(arg_26_0.nodeContainer), var_26_6, 0.5)
	end

	return
end

function var_0_0.updateCurrentChapterMark(arg_27_0, arg_27_1)
	if arg_27_0.currentChapter ~= arg_27_1 then
		local var_27_0 = arg_27_0.progressDict[arg_27_1]

		rtf = var_1_10003

		local var_27_1 = var_1_10003(arg_27_0.progressCurrentMark).rect
		local var_27_2 = arg_27_0.progressCurrentMark

		Vector2 = var_1_10005
		var_27_2.sizeDelta = var_1_10005(var_27_0.w, var_27_1.height)

		local var_27_3 = arg_27_0.progressCurrentMark.anchoredPosition

		var_27_3.x = var_27_0.x
		arg_27_0.progressCurrentMark.anchoredPosition = var_27_3
	end

	arg_27_0.currentChapter = arg_27_1

	return
end

function var_0_0.gotoStory(arg_28_0)
	pg = var_1_10001

	local var_28_0 = var_1_10001.BgmMgr.GetInstance()

	var_1.ContinuePlay(var_28_0)

	local var_28_1 = arg_28_0.nodeDataDict[arg_28_0.selectedID].VO
	local var_28_2 = var_1.GetMemoryID(var_28_1)
	local var_28_3 = var_1:GetWorldID()

	if var_28_2 ~= "" then
		local var_28_4
		local var_28_5

		if var_28_2[1] == 1 then
			var_28_4 = var_28_2[2]
		elseif var_28_2[1] == 2 then
			var_28_5 = var_28_2[2][1]
			ipairs = var_6
			pg = var_1_10007

			for iter_28_0, iter_28_1 in var_6(var_1_10007.memory_group.all) do
				pg = var_1_10011
				var_1_10011 = var_1_10011.memory_group[iter_28_1]
				table = var_1_10012

				if var_1_10012.contains(var_1_10011.memories, var_28_5) then
					var_28_4 = iter_28_1

					break
				end
			end
		end

		local var_28_6 = arg_28_0.storyJumpCallback

		pg = var_1_10007

		var_28_6(var_1_10007.memory_group[var_28_4], var_28_5)
	elseif var_28_3 ~= "" then
		local var_28_7
		local var_28_8

		if var_28_3[1] == 1 then
			var_28_7 = var_28_3[2]
		elseif var_28_3[1] == 2 then
			var_28_8 = var_28_3[2][1]
			ipairs = var_6
			pg = var_1_10007

			for iter_28_2, iter_28_3 in var_6(var_1_10007.world_collection_record_group.all) do
				pg = var_1_10011
				var_1_10011 = var_1_10011.world_collection_record_group[iter_28_3]
				table = var_1_10012

				if var_1_10012.contains(var_1_10011.child, var_28_8) then
					var_28_7 = iter_28_3

					break
				end
			end
		end

		arg_28_0.recordJumpCallback(var_28_7, var_28_8, arg_28_0.selectedID)
	end

	return
end

function var_0_0.updateNodes(arg_29_0)
	pairs = var_1_10001

	for iter_29_0, iter_29_1 in var_1_10001(arg_29_0.nodeDataDict) do
		local var_29_0 = iter_29_1.nodeTF
		local var_29_1 = iter_29_1.VO
		local var_29_2 = var_7.GetNations(var_29_1)
		local var_29_3 = iter_29_1.VO

		if not var_8.IsMemoryBlock(var_29_3) then
			local var_29_4 = false

			pairs = var_29_3

			for iter_29_2, iter_29_3 in var_29_3(arg_29_0.filterDict) do
				table = var_1_10014

				if var_1_10014.contains(var_29_2, iter_29_2) then
					var_29_4 = true

					break
				end
			end

			setActive = var_9

			var_9(var_29_0:Find("info/selected_filter"), var_29_4)
		end
	end

	if arg_29_0.selectedID then
		local var_29_5 = arg_29_0.nodeDataDict[arg_29_0.selectedID].nodeTF
		local var_29_6 = var_1.VO
		local var_29_7 = var_3.GetNations(var_29_6)
		local var_29_8 = false

		pairs = iter_29_1

		for iter_29_4, iter_29_5 in iter_29_1(arg_29_0.filterDict) do
			table = var_1_10010

			if var_1_10010.contains(var_29_7, iter_29_4) then
				var_29_8 = true

				break
			end
		end

		if var_29_8 then
			setActive = var_5

			var_5(var_29_5:Find("info/selected_multi"), true)

			setActive = var_5

			var_5(var_29_5:Find("info/selected"), false)
		else
			setActive = var_5

			var_5(var_29_5:Find("info/selected_multi"), false)

			setActive = var_5

			var_5(var_29_5:Find("info/selected"), true)
		end

		local var_29_9 = arg_29_0.detailView
		local var_29_10 = var_5.Find(var_29_9, "camp/nations")

		eachChild = var_29_9

		var_29_9(var_29_10, function(arg_30_0)
			tonumber = var_2_10001

			local var_30_0 = var_2_10001(arg_30_0.name)

			setActive = var_2

			local var_30_1 = arg_30_0

			table = var_2_10004

			var_2(var_30_1, var_2_10004.contains(var_29_7, var_30_0))

			setActive = var_2

			var_2(arg_30_0:Find("filter"), arg_29_0.filterDict[var_30_0])

			return
		end)
	end

	return
end

function var_0_0.updateNodeTree(arg_31_0)
	arg_31_0.nodeDataDict = {}
	arg_31_0.nodeMap = {}

	local var_31_0
	local var_31_1
	local var_31_2

	pairs = var_1_10004

	for iter_31_0, iter_31_1 in var_1_10004(arg_31_0.memoryNodeDict) do
		ipairs = var_1_10009

		for iter_31_2, iter_31_3 in var_1_10009(iter_31_1) do
			local var_31_3 = {}

			cloneTplTo = var_1_10015
			var_1_10015 = var_1_10015(arg_31_0.nodeTpl, arg_31_0.nodeContainer)
			setActive = var_16

			var_16(var_1_10015, true)

			if iter_31_3:IsMemoryBlock() then
				LoadImageSpriteAtlasAsync = var_16

				var_16("ui/worldmediacollectionmemoryui_atlas", "node_tail", var_1_10015:Find("info/icon"))

				setText = var_16

				var_16(var_1_10015:Find("info/name"), iter_31_3:GetName())

				setActive = var_16

				var_16(var_1_10015:Find("info/name"), false)

				setActive = var_16

				var_16(var_1_10015:Find("info/mark"), false)
			else
				LoadImageSpriteAsync = var_16

				var_16("memorystoryline/" .. iter_31_3:GetIcon(), var_1_10015:Find("info/icon"), true)

				setText = var_16

				var_16(var_1_10015:Find("info/name"), iter_31_3:GetName())

				LoadImageSpriteAtlasAsync = var_16

				var_16("ui/worldmediacollectionmemoryui_atlas", iter_31_3:GetMark(), var_1_10015:Find("info/mark"))

				onButton = var_16

				var_16(arg_31_0, var_1_10015, function()
					local var_32_0 = arg_31_0
					local var_32_1 = var_0.ShowNodeDetail
					local var_32_2 = iter_31_3

					var_32_1(var_32_0, var_2.GetConfigID(var_32_2))

					return
				end)
			end

			local var_31_4 = var_0_0.START_GAP + (iter_31_0 - 1) * var_0_0.HRZ_GAP
			local var_31_5 = -iter_31_3:GetRow() * 254

			Vector2 = var_17
			var_1_10015.anchoredPosition = var_17(var_31_4, var_31_5)
			var_31_0 = var_31_4 + var_0_0.END_GAP
			var_31_3.nodeTF = var_1_10015
			var_31_3.row = var_16
			var_31_3.col = iter_31_0
			var_31_3.linkData = {}
			var_31_3.VO = iter_31_3

			local var_31_6 = arg_31_0.nodeMap
			local var_31_7

			if not arg_31_0.nodeMap[iter_31_0] then
				var_31_7 = {}
			end

			var_31_6[iter_31_0] = var_31_7
			arg_31_0.nodeMap[iter_31_0][var_16] = true
			arg_31_0.nodeDataDict[iter_31_3:GetConfigID()] = var_31_3
		end
	end

	local var_31_8 = arg_31_0.tf

	arg_31_0.nodeTail = var_4.Find(var_31_8, "Story/NodeTail")
	setActive = var_4

	var_4(arg_31_0.nodeTail, false)
	arg_31_0:sortLinkData()

	local var_31_9 = arg_31_0.nodeContainer.sizeDelta

	var_31_9.x = var_31_0

	local var_31_10 = arg_31_0.nodeContainer

	var_31_10.sizeDelta = var_31_9
	rtf = var_31_10

	local var_31_11 = var_31_10(arg_31_0.nodeContainer).rect.width

	rtf = var_6
	arg_31_0.contentWidth = var_31_11 - var_6(arg_31_0.scroll).rect.width

	return
end

function var_0_0.sortLinkData(arg_33_0)
	pairs = var_1_10001

	for iter_33_0, iter_33_1 in var_1_10001(arg_33_0.nodeDataDict) do
		type = var_1_10006

		local var_33_0 = iter_33_1.VO

		if var_1_10006(var_7.GetLinkEvent(var_33_0)) == "table" then
			ipairs = var_1_10006

			local var_33_1 = iter_33_1.VO

			for iter_33_2, iter_33_3 in var_1_10006(var_7.GetLinkEvent(var_33_1)) do
				local var_33_2 = arg_33_0.nodeDataDict[iter_33_3].linkData

				if arg_33_0.nodeDataDict[iter_33_3].col < iter_33_1.col then
					table = var_12

					if not var_12.contains(var_33_2, iter_33_0) then
						table = var_12

						var_12.insert(var_33_2, iter_33_0)
					end
				else
					table = var_12

					var_12.insert(iter_33_1.linkData, iter_33_3)
				end
			end
		end
	end

	return
end

function var_0_0.updateNodeLine(arg_34_0)
	pairs = var_1_10001

	for iter_34_0, iter_34_1 in var_1_10001(arg_34_0.nodeDataDict) do
		local var_34_0 = iter_34_1.VO
		local var_34_1 = var_6.GetColumn(var_34_0)

		ipairs = var_34_0

		for iter_34_2, iter_34_3 in var_34_0(iter_34_1.linkData) do
			local var_34_2 = arg_34_0.nodeDataDict[iter_34_3].VO

			if var_13.GetColumn(var_34_2) == var_34_1 then
				arg_34_0:linkVRTLine(iter_34_1, var_12)
			elseif iter_34_1.row == var_12.row then
				arg_34_0:linkHRZLine(iter_34_1, var_12)
			else
				arg_34_0:linkBranchLine(iter_34_1, var_12)
			end
		end
	end

	return
end

Vector2 = var_1
var_0_0.VRT_LINE_POS = var_1(0, -150)

function var_0_0.linkVRTLine(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0

	var_35_0 = (arg_35_1.row < arg_35_2.row and arg_35_1 or arg_35_2) == arg_35_1 and arg_35_2 or arg_35_1
	tf = var_1_10005
	Instantiate = var_1_10006

	local var_35_1 = var_1_10005(var_1_10006(arg_35_0.linkVrtTpl))

	setActive = var_6

	var_6(var_35_1, true)
	var_35_1:SetParent(var_3.nodeTF, false)

	var_35_1.anchoredPosition = var_0_0.VRT_LINE_POS

	return
end

Vector2 = var_1
var_0_0.HRZ_LINE_POS = var_1(185, 0)

function var_0_0.linkHRZLine(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_1.VO
	local var_36_1 = var_3.GetColumn(var_36_0)
	local var_36_2 = arg_36_2.VO
	local var_36_3

	var_36_3 = (var_36_1 < var_4.GetColumn(var_36_2) and arg_36_1 or arg_36_2) == arg_36_1 and arg_36_2 or arg_36_1
	tf = var_36_2
	Instantiate = var_1_10006

	local var_36_4 = var_36_2(var_1_10006(arg_36_0.linkHrzTpl))

	setActive = var_6

	var_6(var_36_4, true)
	var_36_4:SetParent(var_3.nodeTF, false)

	var_36_4.anchoredPosition = var_0_0.HRZ_LINE_POS

	return
end

Vector2 = var_1
var_0_0.UP_POS = var_1(-3.5, 100)
Vector2 = var_1
var_0_0.DOWN_POS = var_1(0, -105)
Vector2 = var_1
var_0_0.RIGHT_POS = var_1(185, 0)

function var_0_0.linkBranchLine(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0
	local var_37_1
	local var_37_2
	local var_37_3 = arg_37_1.VO
	local var_37_4 = var_6.GetColumn(var_37_3)
	local var_37_5 = arg_37_2.VO
	local var_37_6 = var_7.GetColumn(var_37_5)
	local var_37_7 = arg_37_1.row
	local var_37_8 = arg_37_2.row
	local var_37_9 = "Right"
	local var_37_10 = var_37_8 < var_37_7 and "Up" or "Down"

	if not arg_37_0.nodeMap[var_37_4 + 1][var_37_7] then
		var_37_2 = var_37_9 .. var_37_10
		var_37_1 = var_0_0.RIGHT_POS
	elseif var_37_8 < var_37_7 and not arg_37_0.nodeMap[var_37_4][var_37_7 - 1] or var_37_7 < var_37_8 and not arg_37_0.nodeMap[var_37_4][var_37_7 + 1] then
		var_37_2 = var_37_10 .. var_37_9
		var_37_1 = var_37_8 < var_37_7 and var_0_0.UP_POS or var_0_0.DOWN_POS
	else
		var_37_2 = var_37_9 .. var_37_10 .. "Lite"
		var_37_1 = var_0_0.RIGHT_POS
	end

	math = var_12
	var_37_2 = var_12.abs(var_37_7 - var_37_8) == 2 and var_37_2 .. "Extend" or var_37_2
	Instantiate = var_12

	local var_37_11 = arg_37_0.tf
	local var_37_12 = var_12(var_13.Find(var_37_11, "Story/" .. var_37_2))

	tf = var_12

	local var_37_13 = var_12(var_37_12)

	setActive = var_12

	var_12(var_37_13, true)
	var_37_13:SetParent(arg_37_1.nodeTF, false)

	var_37_13.anchoredPosition = var_37_1

	return
end

function var_0_0.Dispose(arg_38_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_38_0)

	LeanTween = var_1

	if var_1.isTweening(arg_38_0.nodeContainer.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_38_0.nodeContainer.gameObject)
	end

	return
end

return var_0_0
