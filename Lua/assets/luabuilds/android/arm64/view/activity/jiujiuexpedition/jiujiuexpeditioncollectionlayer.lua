local var_0_0 = class("JiuJiuExpeditionCollectionLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "JiuJiuExpeditionCollectionUI"
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.allDatas = arg_2_1
	arg_2_0.completeDatas = arg_2_2
	arg_2_0.getRewardIndex = arg_2_3
	arg_2_0.gotRewardIndex = arg_2_4

	return
end

local function var_0_1(arg_3_0, arg_3_1, arg_3_2)
	return table.contains(arg_3_0.completeDatas, arg_3_2)
end

local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2

function var_0_0.IsGotAward(arg_4_0, arg_4_1)
	if arg_4_1 <= arg_4_0.gotRewardIndex then
		return true
	end

	return false
end

function var_0_0.GetAwardState(arg_5_0, arg_5_1)
	if arg_5_1 > arg_5_0.gotRewardIndex + 1 then
		return var_0_2
	elseif arg_5_1 <= arg_5_0.gotRewardIndex then
		return var_0_4
	elseif arg_5_1 == arg_5_0.gotRewardIndex + 1 and arg_5_1 <= arg_5_0.getRewardIndex then
		return var_0_3
	else
		return var_0_2
	end

	return
end

function var_0_0.init(arg_6_0)
	arg_6_0.bookContainer = arg_6_0._tf:Find("books")
	arg_6_0.book = arg_6_0._tf:Find("book")
	arg_6_0.nextPageBtn = arg_6_0._tf:Find("book/next")
	arg_6_0.prevPageBtn = arg_6_0._tf:Find("book/prev")
	arg_6_0.scoreList = UIItemList.New(arg_6_0._tf:Find("book/list"), arg_6_0._tf:Find("book/list/tpl"))
	arg_6_0.getBtn = arg_6_0._tf:Find("book/get")
	arg_6_0.gotBtn = arg_6_0._tf:Find("book/got")
	arg_6_0.goBtn = arg_6_0._tf:Find("book/go")
	arg_6_0.books = {
		arg_6_0._tf:Find("books/1"),
		arg_6_0._tf:Find("books/2"),
		arg_6_0._tf:Find("books/3")
	}
	arg_6_0.parent = arg_6_0._tf.parent

	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)

	return
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0._tf, function()
		if arg_7_0.isOpenBook then
			arg_7_0:CloseBook()
		else
			arg_7_0:emit(var_0_0.ON_CLOSE)
		end

		return
	end, SFX_CANCEL)
	arg_7_0:InitBooks()

	return
end

function var_0_0.InitBooks(arg_9_0)
	setActive(arg_9_0.bookContainer, true)
	setActive(arg_9_0.book, false)
	arg_9_0:updateBooks()
	arg_9_0:UpdateTip()

	return
end

function var_0_0.updateBooks(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.books) do
		local var_10_0 = iter_10_0 <= arg_10_0.gotRewardIndex + 1

		setActive(iter_10_1:Find("lock"), not (iter_10_0 <= arg_10_0.gotRewardIndex + 1))

		local var_10_1 = iter_10_1:GetComponent(typeof(Image))

		var_10_1.color = var_10_0 and Color.New(1, 1, 1, 1) or Color.New(0.46, 0.46, 0.46, 1)

		onButton(arg_10_0, iter_10_1, function()
			if var_10_0 then
				arg_10_0:OpenBook(iter_10_0)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("jiujiu_expedition_book_tip"))
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.UpdateTip(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.books) do
		setActive(iter_12_1:Find("tip"), arg_12_0:GetAwardState(iter_12_0) == var_0_3)
	end

	return
end

function var_0_0.OpenBook(arg_13_0, arg_13_1)
	arg_13_0.isOpenBook = true

	setActive(arg_13_0.bookContainer, false)
	setActive(arg_13_0.book, true)
	setActive(arg_13_0.book:Find("1"), arg_13_1 == 1)
	setActive(arg_13_0.book:Find("2"), arg_13_1 == 2)
	setActive(arg_13_0.book:Find("3"), arg_13_1 == 3)

	local var_13_0 = arg_13_0.allDatas[arg_13_1]

	onButton(arg_13_0, arg_13_0.nextPageBtn, function()
		setActive(arg_13_0.nextPageBtn, false)
		setActive(arg_13_0.prevPageBtn, true)
		arg_13_0:UpdatePage(arg_13_1, _.slice(var_13_0, 4, 2), 3)

		return
	end, SFX_PANEL)
	onButton(arg_13_0, arg_13_0.prevPageBtn, function()
		setActive(arg_13_0.nextPageBtn, true)
		setActive(arg_13_0.prevPageBtn, false)
		arg_13_0:UpdatePage(arg_13_1, _.slice(var_13_0, 1, 3), 0)

		return
	end, SFX_PANEL)

	local var_13_1 = arg_13_0:GetAwardState(arg_13_1)

	setActive(arg_13_0.getBtn, var_13_1 == var_0_3)
	setActive(arg_13_0.gotBtn, var_13_1 == var_0_4)
	setActive(arg_13_0.goBtn, var_13_1 == var_0_2)
	onButton(arg_13_0, arg_13_0.getBtn, function()
		arg_13_0:emit(JiuJiuExpeditionCollectionMediator.ON_GET, arg_13_1)

		return
	end, SFX_PANEL)
	onButton(arg_13_0, arg_13_0.goBtn, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("jiujiu_expedition_reward_tip"))

		return
	end, SFX_PANEL)
	triggerButton(arg_13_0.prevPageBtn)

	return
end

function var_0_0.UpdatePage(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0.scoreList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("JiuJiuExpeditionCollectionIcon/" .. arg_18_1 .. "_" .. arg_19_1 + 1 + arg_18_3, "", arg_19_2:Find("icon"))
			setActive(arg_19_2:Find("lock"), not var_0_1(arg_18_0, arg_18_1, arg_18_2[arg_19_1 + 1]))
		end

		return
	end)
	arg_18_0.scoreList:align(#arg_18_2)

	return
end

function var_0_0.CloseBook(arg_20_0)
	arg_20_0.isOpenBook = false

	setActive(arg_20_0.bookContainer, true)
	setActive(arg_20_0.book, false)

	return
end

function var_0_0.willExit(arg_21_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0._tf, arg_21_0.parent)

	return
end

return var_0_0
