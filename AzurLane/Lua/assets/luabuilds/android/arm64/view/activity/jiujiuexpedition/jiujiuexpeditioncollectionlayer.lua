class = var_0_10000

local var_0_0 = "JiuJiuExpeditionCollectionLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "JiuJiuExpeditionCollectionUI"
end

function var_0_1.SetData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.allDatas = arg_2_1
	arg_2_0.completeDatas = arg_2_2
	arg_2_0.getRewardIndex = arg_2_3
	arg_2_0.gotRewardIndex = arg_2_4

	return
end

local function var_0_2(arg_3_0, arg_3_1, arg_3_2)
	table = var_1_10003

	return var_1_10003.contains(arg_3_0.completeDatas, arg_3_2)
end

local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = 2

function var_0_1.IsGotAward(arg_4_0, arg_4_1)
	if arg_4_1 <= arg_4_0.gotRewardIndex then
		return true
	end

	return false
end

function var_0_1.GetAwardState(arg_5_0, arg_5_1)
	if arg_5_1 > arg_5_0.gotRewardIndex + 1 then
		return var_0_3
	elseif arg_5_1 <= arg_5_0.gotRewardIndex then
		return var_0_5
	elseif arg_5_1 == arg_5_0.gotRewardIndex + 1 and arg_5_1 <= arg_5_0.getRewardIndex then
		return var_0_4
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
	local var_6_6 = var_3.Find(var_6_5, "book/list")
	local var_6_7 = arg_6_0._tf

	arg_6_0.scoreList = var_6_4(var_6_6, var_4.Find(var_6_7, "book/list/tpl"))

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

	SFX_CANCEL = var_1_10006

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10006)
	arg_7_0:InitBooks()

	return
end

function var_0_1.InitBooks(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.bookContainer, true)

	setActive = var_1_10001

	var_1_10001(arg_9_0.book, false)
	arg_9_0:updateBooks()
	arg_9_0:UpdateTip()

	return
end

function var_0_1.updateBooks(arg_10_0)
	ipairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0.books) do
		local var_10_0 = iter_10_0 <= arg_10_0.gotRewardIndex + 1

		setActive = var_1_10007

		var_1_10007(iter_10_1:Find("lock"), not var_10_0)

		local var_10_1 = iter_10_1

		var_1_10007 = iter_10_1.GetComponent
		typeof = var_10
		Image = var_12
		var_1_10007 = var_1_10007(var_10_1, var_10(var_12))

		if var_10_0 then
			Color = var_1_10008

			if not var_1_10008.New(1, 1, 1, 1) then
				Color = var_1_10008
				var_1_10008 = var_1_10008.New(0.46, 0.46, 0.46, 1)
			end

			var_1_10007.color = var_1_10008
			onButton = var_1_10007

			local var_10_2 = arg_10_0
			local var_10_3 = iter_10_1

			local function var_10_4()
				if var_10_0 then
					local var_11_0 = arg_10_0

					var_0.OpenBook(var_11_0, iter_10_0)
				else
					pg = var_0

					local var_11_1 = var_0.TipsMgr.GetInstance()
					local var_11_2 = var_0.ShowTips

					i18n = var_2_10003

					var_11_2(var_11_1, var_2_10003("jiujiu_expedition_book_tip"))
				end

				return
			end

			SFX_PANEL = var_12

			var_1_10007(var_10_2, var_10_3, var_10_4, var_12)
		end
	end

	return
end

function var_0_1.UpdateTip(arg_12_0)
	ipairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.books) do
		local var_12_0 = arg_12_0:GetAwardState(iter_12_0) == var_0_4

		setActive = var_7

		var_7(iter_12_1:Find("tip"), var_12_0)
	end

	return
end

function var_0_1.OpenBook(arg_13_0, arg_13_1)
	arg_13_0.isOpenBook = true
	setActive = var_2

	var_2(arg_13_0.bookContainer, false)

	setActive = var_2

	var_2(arg_13_0.book, true)

	setActive = var_2

	local var_13_0 = arg_13_0.book

	var_2(var_4.Find(var_13_0, "1"), arg_13_1 == 1)

	setActive = var_2

	local var_13_1 = arg_13_0.book

	var_2(var_4.Find(var_13_1, "2"), arg_13_1 == 2)

	setActive = var_2

	local var_13_2 = arg_13_0.book

	var_2(var_4.Find(var_13_2, "3"), arg_13_1 == 3)

	local var_13_3 = arg_13_0.allDatas[arg_13_1]

	onButton = var_1_10003

	local var_13_4 = arg_13_0
	local var_13_5 = arg_13_0.nextPageBtn

	local function var_13_6()
		setActive = var_2_10000

		var_2_10000(arg_13_0.nextPageBtn, false)

		setActive = var_2_10000

		var_2_10000(arg_13_0.prevPageBtn, true)

		_ = var_2_10000

		local var_14_0 = var_2_10000.slice(var_13_3, 4, 2)
		local var_14_1 = arg_13_0

		var_1.UpdatePage(var_14_1, arg_13_1, var_14_0, 3)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_13_4, var_13_5, var_13_6, var_1_10008)

	onButton = var_1_10003

	local var_13_7 = arg_13_0
	local var_13_8 = arg_13_0.prevPageBtn

	local function var_13_9()
		setActive = var_2_10000

		var_2_10000(arg_13_0.nextPageBtn, true)

		setActive = var_2_10000

		var_2_10000(arg_13_0.prevPageBtn, false)

		_ = var_2_10000

		local var_15_0 = var_2_10000.slice(var_13_3, 1, 3)
		local var_15_1 = arg_13_0

		var_1.UpdatePage(var_15_1, arg_13_1, var_15_0, 0)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_13_7, var_13_8, var_13_9, var_1_10008)

	local var_13_10 = arg_13_0:GetAwardState(arg_13_1)

	setActive = var_4

	var_4(arg_13_0.getBtn, var_13_10 == var_0_4)

	setActive = var_4

	var_4(arg_13_0.gotBtn, var_13_10 == var_0_5)

	setActive = var_4

	var_4(arg_13_0.goBtn, var_13_10 == var_0_3)

	onButton = var_4

	local var_13_11 = arg_13_0
	local var_13_12 = arg_13_0.getBtn

	local function var_13_13()
		local var_16_0 = arg_13_0
		local var_16_1 = var_0.emit

		JiuJiuExpeditionCollectionMediator = var_2_10003

		var_16_1(var_16_0, var_2_10003.ON_GET, arg_13_1)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_13_11, var_13_12, var_13_13, var_1_10009)

	onButton = var_4

	local var_13_14 = arg_13_0
	local var_13_15 = arg_13_0.goBtn

	local function var_13_16()
		pg = var_2_10000

		local var_17_0 = var_2_10000.TipsMgr.GetInstance()
		local var_17_1 = var_0.ShowTips

		i18n = var_2_10003

		var_17_1(var_17_0, var_2_10003("jiujiu_expedition_reward_tip"))

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_13_14, var_13_15, var_13_16, var_1_10009)

	triggerButton = var_4

	var_4(arg_13_0.prevPageBtn)

	return
end

function var_0_1.UpdatePage(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0.scoreList

	var_4.make(var_18_0, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = arg_18_2[arg_19_1 + 1]
			local var_19_1 = "JiuJiuExpeditionCollectionIcon/" .. arg_18_1 .. "_" .. arg_19_1 + 1 + arg_18_3

			GetImageSpriteFromAtlasAsync = var_5

			var_5(var_19_1, "", arg_19_2:Find("icon"))

			setActive = var_5

			var_5(arg_19_2:Find("lock"), not var_0_2(arg_18_0, arg_18_1, var_19_0))
		end

		return
	end)

	local var_18_1 = arg_18_0.scoreList

	var_4.align(var_18_1, #arg_18_2)

	return
end

function var_0_1.CloseBook(arg_20_0)
	arg_20_0.isOpenBook = false
	setActive = var_1

	var_1(arg_20_0.bookContainer, true)

	setActive = var_1

	var_1(arg_20_0.book, false)

	return
end

function var_0_1.willExit(arg_21_0)
	pg = var_1_10001

	local var_21_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_0, arg_21_0._tf, arg_21_0.parent)

	return
end

return var_0_1
