class = var_0_10000

local var_0_0 = "MangaFullScreenLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MangaViewUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)
	arg_3_0:readManga()
	arg_3_0:updatePicImg()
	arg_3_0:updateLikeBtn()
	arg_3_0:updateLoadingBtn()

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	local var_4_1 = arg_4_0.resLoader

	var_1.Clear(var_4_1)

	if arg_4_0.contextData.mangaContext then
		local var_4_2 = arg_4_0.mangaIDLIst[arg_4_0.curMangaIndex]
		local var_4_3 = arg_4_0.contextData.mangaContext

		var_2.updateToMangaID(var_4_3, var_4_2)
	end

	return
end

function var_0_1.onBackPressed(arg_5_0)
	if not arg_5_0.isShowing then
		arg_5_0:closeView()
	end

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.bg = var_1.Find(var_6_0, "BG")

	local var_6_1 = arg_6_0._tf

	arg_6_0.picImg = var_1.Find(var_6_1, "Manga/Pic")

	local var_6_2 = arg_6_0._tf

	arg_6_0.indexText = var_1.Find(var_6_2, "Manga/Index")

	local var_6_3 = arg_6_0._tf

	arg_6_0.preBtn = var_1.Find(var_6_3, "LeftBtn")

	local var_6_4 = arg_6_0._tf

	arg_6_0.rightBtn = var_1.Find(var_6_4, "RightBtn")

	local var_6_5 = arg_6_0._tf

	arg_6_0.tipText = var_1.Find(var_6_5, "Tip")

	local var_6_6 = arg_6_0._tf

	arg_6_0.likeOnBtn = var_1.Find(var_6_6, "Manga/LikeOn")

	local var_6_7 = arg_6_0._tf

	arg_6_0.likeOffBtn = var_1.Find(var_6_7, "Manga/LikeOff")

	local var_6_8 = arg_6_0._tf

	arg_6_0.addLoadingBtn = var_1.Find(var_6_8, "Manga/LoadingBtn/Off")

	local var_6_9 = arg_6_0._tf

	arg_6_0.removeLoadingBtn = var_1.Find(var_6_9, "Manga/LoadingBtn/On")
	setText = var_1

	local var_6_10 = arg_6_0.tipText

	i18n = var_3

	var_1(var_6_10, var_3("world_collection_back"))

	return
end

function var_0_1.initData(arg_7_0)
	AutoLoader = var_1_10001
	arg_7_0.resLoader = var_1_10001.New()
	arg_7_0.curMangaIndex = arg_7_0.contextData.mangaIndex
	arg_7_0.mangaIDLIst = arg_7_0.contextData.mangaIDLIst

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.bg

	local function var_8_2()
		if not arg_8_0.isShowing then
			local var_9_0 = arg_8_0

			var_0.closeView(var_9_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.preBtn

	local function var_8_5()
		if arg_8_0.curMangaIndex > 1 then
			arg_8_0.curMangaIndex = arg_8_0.curMangaIndex - 1

			local var_10_0 = arg_8_0

			var_0.readManga(var_10_0)

			local var_10_1 = arg_8_0

			var_0.updatePicImg(var_10_1)

			local var_10_2 = arg_8_0

			var_0.updateLikeBtn(var_10_2)

			local var_10_3 = arg_8_0

			var_0.updateLoadingBtn(var_10_3)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.rightBtn

	local function var_8_8()
		if arg_8_0.curMangaIndex < #arg_8_0.mangaIDLIst then
			arg_8_0.curMangaIndex = arg_8_0.curMangaIndex + 1

			local var_11_0 = arg_8_0

			var_0.readManga(var_11_0)

			local var_11_1 = arg_8_0

			var_0.updatePicImg(var_11_1)

			local var_11_2 = arg_8_0

			var_0.updateLikeBtn(var_11_2)

			local var_11_3 = arg_8_0

			var_0.updateLoadingBtn(var_11_3)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10005)

	onButton = var_1_10001

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.likeOnBtn

	local function var_8_11()
		local var_12_0 = arg_8_0.mangaIDLIst[arg_8_0.curMangaIndex]

		pg = var_1

		local var_12_1 = var_1.m02
		local var_12_2 = var_1.sendNotification

		GAME = var_2_10003

		local var_12_3 = var_2_10003.APPRECIATE_MANGA_LIKE
		local var_12_4 = {
			mangaID = var_12_0
		}

		MangaConst = var_2_10005
		var_12_4.action = var_2_10005.CANCEL_MANGA_LIKE

		var_12_2(var_12_1, var_12_3, var_12_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_9, var_8_10, var_8_11, var_1_10005)

	onButton = var_1_10001

	local var_8_12 = arg_8_0
	local var_8_13 = arg_8_0.likeOffBtn

	local function var_8_14()
		local var_13_0 = arg_8_0.mangaIDLIst[arg_8_0.curMangaIndex]

		pg = var_1

		local var_13_1 = var_1.m02
		local var_13_2 = var_1.sendNotification

		GAME = var_2_10003

		local var_13_3 = var_2_10003.APPRECIATE_MANGA_LIKE
		local var_13_4 = {
			mangaID = var_13_0
		}

		MangaConst = var_2_10005
		var_13_4.action = var_2_10005.SET_MANGA_LIKE

		var_13_2(var_13_1, var_13_3, var_13_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_12, var_8_13, var_8_14, var_1_10005)

	addSlip = var_1_10001
	SLIP_TYPE_HRZ = var_8_12

	var_1_10001(var_8_12, arg_8_0.picImg, function()
		triggerButton = var_2_10000

		var_2_10000(arg_8_0.preBtn)

		return
	end, function()
		triggerButton = var_2_10000

		var_2_10000(arg_8_0.rightBtn)

		return
	end)

	addSlip = var_1_10001
	SLIP_TYPE_HRZ = var_8_12

	var_1_10001(var_8_12, arg_8_0.bg, function()
		triggerButton = var_2_10000

		var_2_10000(arg_8_0.preBtn)

		return
	end, function()
		triggerButton = var_2_10000

		var_2_10000(arg_8_0.rightBtn)

		return
	end)

	onButton = var_1_10001

	local var_8_15 = arg_8_0
	local var_8_16 = arg_8_0.addLoadingBtn

	local function var_8_17()
		local var_18_0 = arg_8_0

		var_0.addLoadingPic(var_18_0, arg_8_0.mangaIDLIst[arg_8_0.curMangaIndex])

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_15, var_8_16, var_8_17, var_5)

	onButton = var_1_10001

	local var_8_18 = arg_8_0
	local var_8_19 = arg_8_0.removeLoadingBtn

	local function var_8_20()
		local var_19_0 = arg_8_0

		var_0.removeLoadingPic(var_19_0, arg_8_0.mangaIDLIst[arg_8_0.curMangaIndex])

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_18, var_8_19, var_8_20, var_5)

	return
end

function var_0_1.updatePicImg(arg_20_0)
	local var_20_0 = arg_20_0.mangaIDLIst[arg_20_0.curMangaIndex]

	pg = var_2

	local var_20_1 = var_2.cartoon[var_20_0].resource

	MangaConst = var_1_10003

	local var_20_2 = var_1_10003.MANGA_PATH_PREFIX .. var_20_1
	local var_20_3 = arg_20_0.resLoader

	var_4.LoadSprite(var_20_3, var_20_2, var_20_1, arg_20_0.picImg, false)

	local var_20_4
	local var_20_5

	if arg_20_0.contextData.isShowingNotRead then
		var_20_5 = "#"
		pg = var_6
		var_20_4 = var_20_5 .. var_6.cartoon[var_20_0].cartoon_id
	else
		var_20_5 = "#"
		pg = var_6
		var_20_4 = var_20_5 .. var_6.cartoon[var_20_0].cartoon_id .. "/" .. #arg_20_0.mangaIDLIst
	end

	setText = var_20_5

	var_20_5(arg_20_0.indexText, var_20_4)

	arg_20_0.isShowing = true

	local var_20_6 = arg_20_0
	local var_20_7 = arg_20_0.managedTween

	LeanTween = var_7

	local var_20_8 = var_7.value
	local var_20_9

	go = var_9

	local var_20_10 = var_20_7(var_20_6, var_20_8, var_20_9, var_9(arg_20_0.picImg), 0, 1, 0.3)
	local var_20_11 = var_5.setOnUpdate

	System = var_20_8

	local var_20_12 = var_20_11(var_20_10, var_20_8.Action_float(function(arg_21_0)
		setImageAlpha = var_2_10001

		var_2_10001(arg_20_0.picImg, arg_21_0)

		return
	end))
	local var_20_13 = var_5.setOnComplete

	System = var_7

	var_20_13(var_20_12, var_7.Action(function()
		local var_22_0 = arg_20_0

		var_22_0.isShowing = false
		setImageAlpha = var_22_0

		var_22_0(arg_20_0.picImg, 1)

		return
	end))

	setActive = var_20_13

	var_20_13(arg_20_0.preBtn, arg_20_0.curMangaIndex > 1)

	setActive = var_20_13

	var_20_13(arg_20_0.rightBtn, arg_20_0.curMangaIndex < #arg_20_0.mangaIDLIst)

	return
end

function var_0_1.updateLikeBtn(arg_23_0)
	local var_23_0 = arg_23_0.mangaIDLIst[arg_23_0.curMangaIndex]

	MangaConst = var_2

	local var_23_1 = var_2.isMangaLikeByID(var_23_0)

	setActive = var_3

	var_3(arg_23_0.likeOnBtn, var_23_1)

	setActive = var_3

	var_3(arg_23_0.likeOffBtn, not var_23_1)

	return
end

function var_0_1.updateLoadingBtn(arg_24_0)
	local var_24_0 = arg_24_0.mangaIDLIst[arg_24_0.curMangaIndex]
	local var_24_1 = arg_24_0
	local var_24_2 = arg_24_0.isPicUsed(var_24_1, var_24_0)

	setActive = var_24_1

	var_24_1(arg_24_0.addLoadingBtn, not var_24_2)

	setActive = var_24_1

	var_24_1(arg_24_0.removeLoadingBtn, var_24_2)

	return
end

function var_0_1.readManga(arg_25_0)
	local var_25_0 = arg_25_0.mangaIDLIst[arg_25_0.curMangaIndex]

	MangaConst = var_2

	if not var_2.isMangaEverReadByID(var_25_0) then
		pg = var_2

		local var_25_1 = var_2.m02
		local var_25_2 = var_2.sendNotification

		GAME = var_1_10004

		var_25_2(var_25_1, var_1_10004.APPRECIATE_MANGA_READ, {
			mangaID = var_25_0
		})
	end

	return
end

function var_0_1.isPicUsed(arg_26_0, arg_26_1)
	table = var_1_10002

	local var_26_0 = var_1_10002.contains

	getProxy = var_1_10003
	LoadingPicProxy = var_1_10004

	local var_26_1 = var_1_10003(var_1_10004)

	return var_26_0(var_3.getMangaPicIDList(var_26_1, true), arg_26_1)
end

function var_0_1.removeLoadingPic(arg_27_0, arg_27_1)
	local var_27_0 = {}

	getProxy = var_1_10003
	LoadingPicProxy = var_1_10004

	local var_27_1 = var_1_10003(var_1_10004)
	local var_27_2 = var_3.getMangaPicIDList(var_27_1)

	ipairs = var_27_1

	for iter_27_0, iter_27_1 in var_27_1(var_27_2) do
		if iter_27_1 == arg_27_1 then
			table = var_1_10009

			var_1_10009.remove(var_27_2, iter_27_0)

			break
		end
	end

	var_27_0.mangaPicIDList = var_27_2
	pg = var_4

	local var_27_3 = var_4.m02
	local var_27_4 = var_4.sendNotification

	GAME = var_6

	var_27_4(var_27_3, var_6.UPDATE_LOADING_PIC, var_27_0)

	return
end

function var_0_1.addLoadingPic(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0

	if arg_28_0.isPicUsed(var_28_0, arg_28_1) then
		warning = var_2

		var_2("already used.", arg_28_1)

		return
	end

	local var_28_1 = {}

	getProxy = var_28_0
	LoadingPicProxy = var_4

	local var_28_2 = var_28_0(var_4)
	local var_28_3 = var_3.getMangaPicIDList(var_28_2)

	table = var_28_2

	var_28_2.insert(var_28_3, arg_28_1)

	var_28_1.mangaPicIDList = var_28_3
	pg = var_4

	local var_28_4 = var_4.m02
	local var_28_5 = var_4.sendNotification

	GAME = var_6

	var_28_5(var_28_4, var_6.UPDATE_LOADING_PIC, var_28_1)

	return
end

return var_0_1
