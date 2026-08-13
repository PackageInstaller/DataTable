class = var_0_10000

local var_0_0 = "TowerClimbingCollectionLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "TowerClimbingCollectionUI"
end

function var_0_1.SetData(arg_2_0, arg_2_1)
	arg_2_0.miniGameData = arg_2_1

	local var_2_0 = arg_2_0.miniGameData
	local var_2_1 = var_2.GetRuntimeData(var_2_0, "kvpElements")

	TowerClimbingGameView = var_2_0

	local var_2_2, var_2_3 = var_2_0.GetTowerClimbingPageAndScore(var_2_1)

	arg_2_0.score = var_2_2
	arg_2_0.pageIndex = var_2_3
	assert = var_1_10005

	var_1_10005(var_2_2)

	assert = var_1_10005

	var_1_10005(var_2_3)

	pg = var_1_10005

	local var_2_4 = var_1_10005.mini_game

	MiniGameDataCreator = var_6
	arg_2_0.config = var_2_4[var_6.TowerClimbingGameID].simple_config_data

	return
end

local function var_0_2(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 < arg_3_0.pageIndex then
		return true
	elseif arg_3_1 == arg_3_0.pageIndex then
		return arg_3_2 <= arg_3_0.score
	else
		return false
	end

	return
end

local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = 2

function var_0_1.IsGotAward(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.miniGameData
	local var_4_1

	if not var_2.GetRuntimeData(var_4_0, "kvpElements")[1] then
		var_4_1 = {}
	end

	ipairs = var_4

	for iter_4_0, iter_4_1 in var_4(var_4_1) do
		if iter_4_1.key == arg_4_1 and iter_4_1.value == 1 then
			return true
		end
	end

	return false
end

function var_0_1.GetAwardState(arg_5_0, arg_5_1)
	local var_5_0 = var_2[#arg_5_0.config[arg_5_1][1]]

	if arg_5_1 < arg_5_0.pageIndex then
		if arg_5_0:IsGotAward(arg_5_1) then
			return var_0_5
		else
			return var_0_4
		end
	elseif arg_5_1 == arg_5_0.pageIndex then
		if arg_5_0:IsGotAward(arg_5_1) then
			return var_0_5
		elseif var_5_0 <= arg_5_0.score and not var_4 then
			return var_0_4
		elseif var_5_0 > arg_5_0.score then
			return var_0_3
		end
	else
		return var_0_3
	end

	return
end

function var_0_1.init(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.bookContainer = var_1.Find(var_6_0, "books")

	local var_6_1 = arg_6_0._tf

	arg_6_0.book = var_1.Find(var_6_1, "book")

	local var_6_2 = arg_6_0._tf

	arg_6_0.nextPageBtn = var_1.Find(var_6_2, "book/next")

	local var_6_3 = arg_6_0._tf

	arg_6_0.prevPageBtn = var_1.Find(var_6_3, "book/prev")
	UIItemList = var_1

	local var_6_4 = var_1.New
	local var_6_5 = arg_6_0._tf
	local var_6_6 = var_2.Find(var_6_5, "book/list")
	local var_6_7 = arg_6_0._tf

	arg_6_0.scoreList = var_6_4(var_6_6, var_3.Find(var_6_7, "book/list/tpl"))

	local var_6_8 = arg_6_0._tf

	arg_6_0.getBtn = var_1.Find(var_6_8, "book/get")

	local var_6_9 = arg_6_0._tf

	arg_6_0.gotBtn = var_1.Find(var_6_9, "book/got")

	local var_6_10 = arg_6_0._tf

	arg_6_0.goBtn = var_1.Find(var_6_10, "book/go")

	local var_6_11 = {}
	local var_6_12 = arg_6_0._tf

	var_6_11[1] = var_2.Find(var_6_12, "books/1")

	local var_6_13 = arg_6_0._tf

	var_6_11[2] = var_2.Find(var_6_13, "books/2")

	local var_6_14 = arg_6_0._tf

	var_6_11[3] = var_2.Find(var_6_14, "books/3")
	arg_6_0.books = var_6_11
	arg_6_0.parent = arg_6_0._tf.parent
	pg = var_1

	local var_6_15 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_6_15, arg_6_0._tf)

	return
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0._tf

	local function var_7_2()
		if arg_7_0.isOpenBook then
			local var_8_0 = arg_7_0

			var_0.CloseBook(var_8_0)
		else
			local var_8_1 = arg_7_0

			var_0.emit(var_8_1, var_0_1.ON_CLOSE)
		end

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)
	arg_7_0:InitBooks()

	return
end

function var_0_1.InitBooks(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.bookContainer, true)

	setActive = var_1_10001

	var_1_10001(arg_9_0.book, false)

	ipairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.books) do
		local var_9_0 = iter_9_0 <= arg_9_0.pageIndex

		setActive = var_1_10007

		var_1_10007(iter_9_1:Find("lock"), not var_9_0)

		local var_9_1 = iter_9_1

		var_1_10007 = iter_9_1.GetComponent
		typeof = var_9
		Image = var_10
		var_1_10007 = var_1_10007(var_9_1, var_9(var_10))

		if var_9_0 then
			Color = var_9_1

			if not var_9_1.New(1, 1, 1, 1) then
				Color = var_9_1
				var_9_1 = var_9_1.New(0.46, 0.46, 0.46, 1)
			end

			var_1_10007.color = var_9_1
			onButton = var_1_10007

			local var_9_2 = arg_9_0
			local var_9_3 = iter_9_1

			local function var_9_4()
				if var_9_0 then
					local var_10_0 = arg_9_0

					var_0.OpenBook(var_10_0, iter_9_0)
				else
					pg = var_0

					local var_10_1 = var_0.TipsMgr.GetInstance()
					local var_10_2 = var_0.ShowTips

					i18n = var_2_10002

					var_10_2(var_10_1, var_2_10002("towerclimbing_book_tip"))
				end

				return
			end

			SFX_PANEL = var_1_10011

			var_1_10007(var_9_2, var_9_3, var_9_4, var_1_10011)
		end
	end

	arg_9_0:UpdateTip()

	return
end

function var_0_1.UpdateTip(arg_11_0)
	ipairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.books) do
		local var_11_0 = arg_11_0:GetAwardState(iter_11_0) == var_0_4

		setActive = var_7

		var_7(iter_11_1:Find("tip"), var_11_0)
	end

	return
end

function var_0_1.OpenBook(arg_12_0, arg_12_1)
	arg_12_0.isOpenBook = true
	setActive = var_2

	var_2(arg_12_0.bookContainer, false)

	setActive = var_2

	var_2(arg_12_0.book, true)

	setActive = var_2

	local var_12_0 = arg_12_0.book

	var_2(var_3.Find(var_12_0, "1"), arg_12_1 == 1)

	setActive = var_2

	local var_12_1 = arg_12_0.book

	var_2(var_3.Find(var_12_1, "2"), arg_12_1 == 2)

	setActive = var_2

	local var_12_2 = arg_12_0.book

	var_2(var_3.Find(var_12_2, "3"), arg_12_1 == 3)

	local var_12_3 = arg_12_0.config[arg_12_1][1]

	onButton = var_3

	local var_12_4 = arg_12_0
	local var_12_5 = arg_12_0.nextPageBtn

	local function var_12_6()
		setActive = var_2_10000

		var_2_10000(arg_12_0.nextPageBtn, false)

		setActive = var_2_10000

		var_2_10000(arg_12_0.prevPageBtn, true)

		_ = var_2_10000

		local var_13_0 = var_2_10000.slice(var_12_3, 4, 2)
		local var_13_1 = arg_12_0

		var_1.UpdatePage(var_13_1, arg_12_1, var_13_0, 3)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_12_4, var_12_5, var_12_6, var_1_10007)

	onButton = var_3

	local var_12_7 = arg_12_0
	local var_12_8 = arg_12_0.prevPageBtn

	local function var_12_9()
		setActive = var_2_10000

		var_2_10000(arg_12_0.nextPageBtn, true)

		setActive = var_2_10000

		var_2_10000(arg_12_0.prevPageBtn, false)

		_ = var_2_10000

		local var_14_0 = var_2_10000.slice(var_12_3, 1, 3)
		local var_14_1 = arg_12_0

		var_1.UpdatePage(var_14_1, arg_12_1, var_14_0, 0)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_12_7, var_12_8, var_12_9, var_1_10007)

	local var_12_10 = arg_12_0
	local var_12_11 = arg_12_0.GetAwardState(var_12_10, arg_12_1)

	setActive = var_12_10

	var_12_10(arg_12_0.getBtn, var_12_11 == var_0_4)

	setActive = var_12_10

	var_12_10(arg_12_0.gotBtn, var_12_11 == var_0_5)

	setActive = var_12_10

	var_12_10(arg_12_0.goBtn, var_12_11 == var_0_3)

	onButton = var_12_10

	local var_12_12 = arg_12_0
	local var_12_13 = arg_12_0.getBtn

	local function var_12_14()
		local var_15_0 = arg_12_0
		local var_15_1 = var_0.emit

		TowerClimbingCollectionMediator = var_2_10002

		var_15_1(var_15_0, var_2_10002.ON_GET, arg_12_1)

		return
	end

	SFX_PANEL = var_1_10008

	var_12_10(var_12_12, var_12_13, var_12_14, var_1_10008)

	onButton = var_12_10

	local var_12_15 = arg_12_0
	local var_12_16 = arg_12_0.goBtn

	local function var_12_17()
		pg = var_2_10000

		local var_16_0 = var_2_10000.TipsMgr.GetInstance()
		local var_16_1 = var_0.ShowTips

		i18n = var_2_10002

		var_16_1(var_16_0, var_2_10002("towerclimbing_reward_tip"))

		return
	end

	SFX_PANEL = var_1_10008

	var_12_10(var_12_15, var_12_16, var_12_17, var_1_10008)

	triggerButton = var_12_10

	var_12_10(arg_12_0.prevPageBtn)

	return
end

function var_0_1.UpdatePage(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0.scoreList

	var_4.make(var_17_0, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			local var_18_0 = arg_17_2[arg_18_1 + 1]
			local var_18_1 = "TowerClimbingCollectionIcon/" .. arg_17_1 .. "_" .. arg_18_1 + 1 + arg_17_3

			GetImageSpriteFromAtlasAsync = var_5

			var_5(var_18_1, "", arg_18_2:Find("icon"))

			setActive = var_5

			var_5(arg_18_2:Find("lock"), not var_0_2(arg_17_0, arg_17_1, var_18_0))
		end

		return
	end)

	local var_17_1 = arg_17_0.scoreList

	var_4.align(var_17_1, #arg_17_2)

	return
end

function var_0_1.CloseBook(arg_19_0)
	arg_19_0.isOpenBook = false
	setActive = var_1

	var_1(arg_19_0.bookContainer, true)

	setActive = var_1

	var_1(arg_19_0.book, false)

	return
end

function var_0_1.willExit(arg_20_0)
	pg = var_1_10001

	local var_20_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_20_0, arg_20_0._tf, arg_20_0.parent)

	return
end

return var_0_1
