class = var_0_10000

local var_0_0 = "BillboardScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
local var_0_2 = {}

PowerRank = var_2
var_0_2[1] = var_2.TYPE_EXTRA_CHAPTER
PowerRank = var_2
var_0_2[2] = var_2.TYPE_ACT_BOSS_BATTLE
PowerRank = var_2
var_0_2[3] = var_2.TYPE_BOSSRUSH
var_0_1.SINGLE_SHOW = var_0_2

function var_0_1.getUIName(arg_1_0)
	return "BillboardUI"
end

function var_0_1.updateRankList(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if not arg_2_0.rankVOs then
		arg_2_0.rankVOs = {}
	end

	if not arg_2_0.playerRankVOs then
		arg_2_0.playerRankVOs = {}
	end

	arg_2_0.rankVOs[arg_2_1] = arg_2_2

	if not arg_2_0.ptRanks then
		arg_2_0.ptRanks = {}
	end

	PowerRank = var_5

	if arg_2_1 == var_5.TYPE_PT then
		assert = var_5

		var_5(arg_2_4)

		arg_2_0.ptRanks[arg_2_4] = arg_2_2

		local var_2_0

		if not arg_2_0.playerPTRankVOMap then
			var_2_0 = {}
		end

		arg_2_0.playerPTRankVOMap = var_2_0
		arg_2_0.playerPTRankVOMap[arg_2_4] = arg_2_3
	end

	arg_2_0.playerRankVOs[arg_2_1] = arg_2_3

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.blurPanel = var_1.Find(var_3_0, "blur_panel")

	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_1.Find(var_3_1, "main/frame/ranks")

	arg_3_0.rankRect = var_1.GetComponent(var_3_2, "LScrollRect")

	local var_3_3 = arg_3_0._tf

	arg_3_0.playerRankTF = var_1.Find(var_3_3, "main/frame/player_rank")
	setActive = var_1

	var_1(arg_3_0.playerRankTF, false)

	local var_3_4 = arg_3_0.blurPanel

	arg_3_0.topPanel = var_1.Find(var_3_4, "adapt/top")

	local var_3_5 = arg_3_0.blurPanel

	arg_3_0.leftPanel = var_1.Find(var_3_5, "adapt/left_length")

	local var_3_6 = arg_3_0._tf

	arg_3_0.mainPanel = var_1.Find(var_3_6, "main")

	local var_3_7 = arg_3_0._tf

	arg_3_0.extraChapterBg = var_1.Find(var_3_7, "extra_chapter_bg")

	local var_3_8 = arg_3_0.leftPanel

	arg_3_0.toggleScrollRect = var_1.Find(var_3_8, "frame/scroll_rect")

	local var_3_9 = arg_3_0.leftPanel

	arg_3_0.toggleContainer = var_1.Find(var_3_9, "frame/scroll_rect/tagRoot")

	local var_3_10 = arg_3_0._tf

	arg_3_0.listEmptyTF = var_1.Find(var_3_10, "main/frame/empty")
	setActive = var_1

	var_1(arg_3_0.listEmptyTF, false)

	local var_3_11 = arg_3_0.listEmptyTF

	arg_3_0.listEmptyTxt = var_1.Find(var_3_11, "Text")
	setText = var_1

	local var_3_12 = arg_3_0.listEmptyTxt

	i18n = var_3

	var_1(var_3_12, var_3("list_empty_tip_billboardui"))

	local var_3_13 = {}
	local var_3_14 = arg_3_0.leftPanel

	var_3_13[1] = var_2.Find(var_3_14, "frame/scroll_rect/tagRoot/power")

	local var_3_15 = arg_3_0.leftPanel

	var_3_13[2] = var_2.Find(var_3_15, "frame/scroll_rect/tagRoot/collection")

	local var_3_16 = arg_3_0.leftPanel

	var_3_13[3] = var_2.Find(var_3_16, "frame/scroll_rect/tagRoot/pt")

	local var_3_17 = arg_3_0.leftPanel

	var_3_13[4] = var_2.Find(var_3_17, "frame/scroll_rect/tagRoot/pledge")

	local var_3_18 = arg_3_0.leftPanel

	var_3_13[5] = var_2.Find(var_3_18, "frame/scroll_rect/tagRoot/chanllenge")

	local var_3_19 = arg_3_0.leftPanel

	var_3_13[6] = var_2.Find(var_3_19, "frame/scroll_rect/tagRoot/extra_chapter")

	local var_3_20 = arg_3_0.leftPanel

	var_3_13[7] = var_2.Find(var_3_20, "frame/scroll_rect/tagRoot/boss_battle")

	local var_3_21 = arg_3_0.leftPanel

	var_3_13[8] = var_2.Find(var_3_21, "frame/scroll_rect/tagRoot/guild")

	local var_3_22 = arg_3_0.leftPanel

	var_3_13[9] = var_2.Find(var_3_22, "frame/scroll_rect/tagRoot/military")

	local var_3_23 = arg_3_0.leftPanel

	var_3_13[10] = var_2.Find(var_3_23, "frame/scroll_rect/tagRoot/bossrush")
	arg_3_0.toggles = var_3_13
	arg_3_0.ptToggles = {}
	_ = var_1

	local var_3_24 = var_1.filter

	getProxy = var_2
	ActivityProxy = var_3_23

	local var_3_25 = var_2(var_3_23)
	local var_3_26 = var_2.getActivitiesByType

	ActivityConst = var_4

	local var_3_27 = #var_3_24(var_3_26(var_3_25, var_4.ACTIVITY_TYPE_PT_RANK), function(arg_4_0)
		if not arg_4_0:isEnd() then
			tonumber = var_1

			local var_4_0

			if not (var_1(arg_4_0:getConfig("config_data")) > 0) then
				var_4_0 = false
			else
				var_4_0 = true
			end

			return var_4_0
		end
	end)

	if 1 < var_3_27 then
		local var_3_28 = arg_3_0.toggles[3]

		pairs = var_3

		for iter_3_0, iter_3_1 in var_3(var_1) do
			cloneTplTo = var_1_10008
			var_1_10008 = var_1_10008(var_3_28, var_3_28.parent)
			arg_3_0.ptToggles[iter_3_1.id] = var_1_10008
		end

		arg_3_0.toggles[3] = nil
	end

	arg_3_0:updateToggles()

	arg_3_0.rankRect.decelerationRate = 0.07

	local var_3_29

	if not arg_3_0.contextData.page then
		PowerRank = var_3_29
		var_3_29 = var_3_29.TYPE_POWER
	end

	table = var_3

	local var_3_31

	if var_3.contains(var_0_1.SINGLE_SHOW, var_3_29) then
		setActive = var_3_31

		var_3_31(arg_3_0.leftPanel, false)

		setAnchoredPosition = var_3_31

		local var_3_30 = arg_3_0.mainPanel

		Vector2 = var_5

		var_3_31(var_3_30, var_5(0, -35.5))

		GetSpriteFromAtlas = var_3_31
		var_3_31 = var_3_31("commonbg/bg_fengshan", "")
		setImageSprite = var_4

		var_4(arg_3_0.extraChapterBg, var_3_31)
	end

	setActive = var_3_31

	local var_3_32 = arg_3_0.extraChapterBg

	PowerRank = var_5

	var_3_31(var_3_32, var_3_29 == var_5.TYPE_EXTRA_CHAPTER)

	return
end

function var_0_1.updateToggles(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.toggles) do
		var_1_10006 = nil
		PowerRank = var_1_10007

		if var_1_10007.typeInfo[iter_5_0].act_type then
			PowerRank = var_1_10007
			var_1_10006 = var_1_10007:getActivityByRankType(iter_5_0)
		else
			PowerRank = var_1_10007

			if iter_5_0 == var_1_10007.TYPE_PLEDGE then
				var_1_10006 = false
			else
				PowerRank = var_1_10007
				var_1_10006 = iter_5_0 == var_1_10007.TYPE_GUILD_BATTLE and true or true
			end
		end

		setActive = var_1_10007

		var_1_10007(iter_5_1, var_1_10006)
	end

	pairs = var_1

	for iter_5_2, iter_5_3 in var_1(arg_5_0.ptToggles) do
		getProxy = var_1_10006
		ActivityProxy = var_1_10007
		var_1_10007 = var_1_10006(var_1_10007)
		var_1_10006 = var_1_10006.getActivityById(var_1_10007, iter_5_2)
		setActive = var_1_10007

		var_1_10007(iter_5_3, var_1_10006 and not var_1_10006:isEnd())
	end

	setActive = var_1

	var_1(arg_5_0.toggleContainer, true)

	Canvas = var_1

	var_1.ForceUpdateCanvases()

	local var_5_0 = arg_5_0.toggleScrollRect.rect.height < arg_5_0.toggleContainer.rect.height
	local var_5_1 = arg_5_0.toggleContainer
	local var_5_2 = var_2.GetComponent

	typeof = iter_5_2
	ScrollRect = iter_5_3
	var_5_2(var_5_1, iter_5_2(iter_5_3)).enabled = var_5_0

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.topPanel
	local var_6_2 = var_3.Find(var_6_1, "back_btn")

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0.emit(var_7_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_6_0, var_6_2, var_6_3, var_5)

	pairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.toggles) do
		onToggle = var_1_10006

		local var_6_4 = arg_6_0
		local var_6_5 = iter_6_1

		local function var_6_6(arg_8_0)
			local var_8_0 = iter_6_0

			PowerRank = var_2_10002

			local var_8_1

			if var_8_0 == var_2_10002.TYPE_GUILD_BATTLE then
				setActive = var_8_0

				var_8_0(arg_6_0.mainPanel, not arg_8_0)

				var_8_1 = arg_6_0
				var_8_0 = var_8_0.emit
				BillboardMediator = var_3

				var_8_0(var_8_1, var_3.ON_GUILD_RANK, arg_8_0)

				return
			end

			if arg_8_0 then
				checkExist = var_8_0
				PowerRank = var_8_1

				local var_8_2 = var_8_0(var_8_1:getActivityByRankType(iter_6_0), {
					"id"
				})
				local var_8_3 = arg_6_0

				var_2.switchPage(var_8_3, iter_6_0, var_8_2)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_6_4, var_6_5, var_6_6, var_1_10010)
	end

	pairs = var_1

	for iter_6_2, iter_6_3 in var_1(arg_6_0.ptToggles) do
		onToggle = var_1_10006

		local var_6_7 = arg_6_0
		local var_6_8 = iter_6_3

		local function var_6_9(arg_9_0)
			if arg_9_0 then
				local var_9_0 = arg_6_0
				local var_9_1 = var_1.switchPage

				PowerRank = var_2_10003

				var_9_1(var_9_0, var_2_10003.TYPE_PT, iter_6_2)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_6_7, var_6_8, var_6_9, var_1_10010)
	end

	arg_6_0.cards = {}

	function arg_6_0.rankRect.onInitItem(arg_10_0)
		local var_10_0 = arg_6_0

		var_1.onInintItem(var_10_0, arg_10_0)

		return
	end

	function arg_6_0.rankRect.onUpdateItem(arg_11_0, arg_11_1)
		local var_11_0 = arg_6_0

		var_2.onUpdateItem(var_11_0, arg_11_0, arg_11_1, arg_6_0.curPagePTActID)

		return
	end

	local var_6_10 = arg_6_0.rankRect

	function var_6_10.onReturnItem(arg_12_0, arg_12_1)
		local var_12_0 = arg_6_0

		var_2.onReturnItem(var_12_0, arg_12_0, arg_12_1)

		return
	end

	RankCard = var_6_10

	local var_6_11 = var_6_10.New
	local var_6_12 = arg_6_0.playerRankTF

	RankCard = var_3
	arg_6_0.playerCard = var_6_11(var_6_12, var_3.TYPE_SELF)

	local var_6_13

	if not arg_6_0.contextData.page then
		PowerRank = var_6_13
		var_6_13 = var_6_13.TYPE_POWER
	end

	triggerToggle = var_6_12

	var_6_12(arg_6_0.toggles[var_6_13], true)

	return
end

function var_0_1.onInintItem(arg_13_0, arg_13_1)
	RankCard = var_1_10002

	local var_13_0 = var_1_10002.New
	local var_13_1 = arg_13_1

	RankCard = var_1_10004

	local var_13_2 = var_13_0(var_13_1, var_1_10004.TYPE_OTHER)

	onButton = var_13_1

	var_13_1(arg_13_0, var_13_2._tf, function()
		local var_14_0 = var_13_2.rankVO.type

		PowerRank = var_2_10001

		if var_14_0 == var_2_10001.TYPE_MILITARY_RANK then
			local var_14_1 = arg_13_0
			local var_14_2 = var_0.emit

			BillboardMediator = var_2_10002

			var_14_2(var_14_1, var_2_10002.OPEN_RIVAL_INFO, var_13_2.rankVO.id)
		end

		return
	end)

	arg_13_0.cards[arg_13_1] = var_13_2

	return
end

function var_0_1.onUpdateItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0

	if not arg_15_0.cards[arg_15_2] then
		arg_15_0:onInintItem(arg_15_2)

		var_15_0 = arg_15_0.cards[arg_15_2]
	end

	local var_15_1 = arg_15_0.displayRankVOs[arg_15_1 + 1]

	var_15_0:update(var_15_1, arg_15_3)

	return
end

function var_0_1.onReturnItem(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.exited then
		return
	end

	if arg_16_0.cards[arg_16_2] then
		var_3:clear()
	end

	return
end

function var_0_1.filter(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 ~= arg_17_0.page then
		return
	end

	local var_17_0 = arg_17_0.page
	local var_17_1

	PowerRank = var_1_10005

	if var_1_10005.TYPE_PT == arg_17_1 then
		assert = var_5

		var_5(arg_17_2)

		var_17_1 = arg_17_0.ptRanks[arg_17_2]
	else
		var_17_1 = arg_17_0.rankVOs[var_17_0]
	end

	arg_17_0.displayRankVOs = {}
	ipairs = var_5

	for iter_17_0, iter_17_1 in var_5(var_17_1) do
		table = var_1_10010

		var_1_10010.insert(arg_17_0.displayRankVOs, iter_17_1)
	end

	local var_17_2 = arg_17_0.rankRect

	var_5.SetTotalCount(var_17_2, #arg_17_0.displayRankVOs)

	setActive = var_5

	var_5(arg_17_0.listEmptyTF, #arg_17_0.displayRankVOs <= 0)

	local var_17_3 = arg_17_0.playerRankVOs[arg_17_0.page]

	PowerRank = var_6

	if var_6.TYPE_PT == arg_17_1 then
		local var_17_4 = arg_17_0.playerPTRankVOMap[arg_17_2]
		local var_17_5 = arg_17_0.playerCard

		var_7.update(var_17_5, var_17_4, arg_17_2)
	else
		local var_17_6 = arg_17_0.playerCard

		var_6.update(var_17_6, var_17_3, arg_17_2)
	end

	return
end

function var_0_1.switchPage(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.page == arg_18_1 then
		PowerRank = var_3

		if arg_18_1 ~= var_3.TYPE_PT then
			return
		end
	end

	PowerRank = var_3

	if arg_18_1 == var_3.TYPE_PT then
		arg_18_0.curPagePTActID = arg_18_2
	else
		arg_18_0.curPagePTActID = nil
	end

	arg_18_0.page = arg_18_1

	local var_18_0
	local var_18_1 = arg_18_0.page

	PowerRank = var_1_10005

	if var_18_1 == var_1_10005.TYPE_PT then
		assert = var_18_1

		var_18_1(arg_18_2)

		var_18_0 = arg_18_0.ptRanks[arg_18_2]
	else
		var_18_0 = arg_18_0.rankVOs[arg_18_1]
	end

	if not var_18_0 then
		local var_18_2 = arg_18_0.rankRect

		var_18_1.SetTotalCount(var_18_2, 0)

		local var_18_3 = arg_18_0.playerCard

		var_18_1.clear(var_18_3)

		local var_18_4 = arg_18_0

		var_18_1 = arg_18_0.emit
		BillboardMediator = var_6

		var_18_1(var_18_4, var_6.FETCH_RANKS, arg_18_0.page, arg_18_2)
	else
		arg_18_0:filter(arg_18_0.page, arg_18_2)
	end

	setActive = var_18_1

	local var_18_5 = arg_18_0.topPanel
	local var_18_6 = var_5.Find(var_18_5, "tip")

	table = var_18_5

	local var_18_7 = var_18_5.contains

	BillboardProxy = var_7

	var_18_1(var_18_6, not var_18_7(var_7.NONTIMER, arg_18_0.page))
	arg_18_0:updateScoreTitle(arg_18_0.page, arg_18_2)

	return
end

function var_0_1.updateScoreTitle(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._tf
	local var_19_1 = var_3.Find(var_19_0, "main/frame/title")

	PowerRank = var_19_0

	local var_19_2 = var_19_0:getTitleWord(arg_19_1, arg_19_2)

	for iter_19_0 = 1, 4 do
		setText = var_1_10009

		var_1_10009(var_19_1:GetChild(iter_19_0 - 1), var_19_2[iter_19_0])
	end

	return
end

function var_0_1.willExit(arg_20_0)
	ipairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.cards) do
		iter_20_1:dispose()
	end

	local var_20_0 = arg_20_0.playerCard

	var_1.dispose(var_20_0)

	if arg_20_0.name then
		retPaintingPrefab = var_1

		var_1(arg_20_0.paintingTF, arg_20_0.name)
	end

	return
end

return var_0_1
