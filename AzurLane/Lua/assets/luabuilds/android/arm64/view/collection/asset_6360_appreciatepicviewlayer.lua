class = var_0_10000

local var_0_0 = "AppreciatePicViewLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AppreciatePicViewUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()
	arg_2_0:updatePanel()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	local var_4_1 = arg_4_0.resLoader

	var_1.Clear(var_4_1)

	return
end

function var_0_1.findUI(arg_5_0)
	setText = var_1_10001

	local var_5_0 = arg_5_0.galleryPicSetLoadingTipText

	i18n = var_1_10004

	var_1_10001(var_5_0, var_1_10004("loading_set_tip"))

	setText = var_1_10001

	local var_5_1 = arg_5_0.mangaPicSetLoadingTipText

	i18n = var_4

	var_1_10001(var_5_1, var_4("loading_set_tip"))

	return
end

function var_0_1.initData(arg_6_0)
	AutoLoader = var_1_10001
	arg_6_0.resLoader = var_1_10001.New()
	arg_6_0.curPicInfo = arg_6_0.contextData.curPicInfo
	arg_6_0.picInfoList = arg_6_0.contextData.picInfoList
	arg_6_0.isShowLikeBtn = arg_6_0.contextData.isShowLikeBtn
	arg_6_0.onPicSwitch = arg_6_0.contextData.onPicSwitch

	local var_6_0 = arg_6_0

	arg_6_0.curIndex = arg_6_0.getPicInfoIndex(var_6_0, arg_6_0.curPicInfo)
	getProxy = var_1
	LoadingPicProxy = var_6_0
	arg_6_0.loadingPicProxy = var_1(var_6_0)

	arg_6_0:addOpenList()

	return
end

function var_0_1.addListener(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.bg

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.closeView(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10006)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.galleryAddLoadingBtn

	local function var_7_5()
		local var_9_0 = arg_7_0

		var_0.addLoadingPic(var_9_0, arg_7_0.curPicInfo)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10006)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.galleryRemoveLoadingBtn

	local function var_7_8()
		local var_10_0 = arg_7_0

		var_0.removeLoadingPic(var_10_0, arg_7_0.curPicInfo)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10006)

	onButton = var_1_10001

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.mangaAddLoadingBtn

	local function var_7_11()
		local var_11_0 = arg_7_0

		var_0.addLoadingPic(var_11_0, arg_7_0.curPicInfo)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_9, var_7_10, var_7_11, var_1_10006)

	onButton = var_1_10001

	local var_7_12 = arg_7_0
	local var_7_13 = arg_7_0.mangaRemoveLoadingBtn

	local function var_7_14()
		local var_12_0 = arg_7_0

		var_0.removeLoadingPic(var_12_0, arg_7_0.curPicInfo)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_12, var_7_13, var_7_14, var_1_10006)

	onButton = var_1_10001

	local var_7_15 = arg_7_0
	local var_7_16 = arg_7_0.galleryAddLikeBtn

	local function var_7_17()
		local var_13_0 = arg_7_0

		var_0.addLike(var_13_0, arg_7_0.curPicInfo)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_15, var_7_16, var_7_17, var_1_10006)

	onButton = var_1_10001

	local var_7_18 = arg_7_0
	local var_7_19 = arg_7_0.galleryRemoveLikeBtn

	local function var_7_20()
		local var_14_0 = arg_7_0

		var_0.removeLike(var_14_0, arg_7_0.curPicInfo)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_18, var_7_19, var_7_20, var_1_10006)

	onButton = var_1_10001

	local var_7_21 = arg_7_0
	local var_7_22 = arg_7_0.mangaAddLikeBtn

	local function var_7_23()
		local var_15_0 = arg_7_0

		var_0.addLike(var_15_0, arg_7_0.curPicInfo)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_21, var_7_22, var_7_23, var_1_10006)

	onButton = var_1_10001

	local var_7_24 = arg_7_0
	local var_7_25 = arg_7_0.mangaRemoveLikeBtn

	local function var_7_26()
		local var_16_0 = arg_7_0

		var_0.removeLike(var_16_0, arg_7_0.curPicInfo)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_24, var_7_25, var_7_26, var_1_10006)

	onButton = var_1_10001

	local var_7_27 = arg_7_0
	local var_7_28 = arg_7_0.galleryPicImg

	local function var_7_29()
		local var_17_0 = arg_7_0

		var_0.openFullScreenLayer(var_17_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_27, var_7_28, var_7_29, var_1_10006)

	onButton = var_1_10001

	local var_7_30 = arg_7_0
	local var_7_31 = arg_7_0.mangaPicImg

	local function var_7_32()
		local var_18_0 = arg_7_0

		var_0.openFullScreenLayer(var_18_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_30, var_7_31, var_7_32, var_1_10006)

	addSlip = var_1_10001
	SLIP_TYPE_HRZ = var_7_30

	var_1_10001(var_7_30, arg_7_0.galleryPicImg, function()
		local var_19_0 = arg_7_0

		var_0.switchToPrePic(var_19_0)

		return
	end, function()
		local var_20_0 = arg_7_0

		var_0.switchToNextPic(var_20_0)

		return
	end)

	addSlip = var_1_10001
	SLIP_TYPE_HRZ = var_7_30

	var_1_10001(var_7_30, arg_7_0.mangaPicImg, function()
		local var_21_0 = arg_7_0

		var_0.switchToPrePic(var_21_0)

		return
	end, function()
		local var_22_0 = arg_7_0

		var_0.switchToNextPic(var_22_0)

		return
	end)

	onButton = var_1_10001

	local var_7_33 = arg_7_0
	local var_7_34 = arg_7_0.galleryLeftBtn

	local function var_7_35()
		local var_23_0 = arg_7_0

		var_0.switchToPrePic(var_23_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_7_33, var_7_34, var_7_35, var_6)

	onButton = var_1_10001

	local var_7_36 = arg_7_0
	local var_7_37 = arg_7_0.galleryRightBtn

	local function var_7_38()
		local var_24_0 = arg_7_0

		var_0.switchToNextPic(var_24_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_7_36, var_7_37, var_7_38, var_6)

	onButton = var_1_10001

	local var_7_39 = arg_7_0
	local var_7_40 = arg_7_0.mangaLeftBtn

	local function var_7_41()
		local var_25_0 = arg_7_0

		var_0.switchToPrePic(var_25_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_7_39, var_7_40, var_7_41, var_6)

	onButton = var_1_10001

	local var_7_42 = arg_7_0
	local var_7_43 = arg_7_0.mangaRightBtn

	local function var_7_44()
		local var_26_0 = arg_7_0

		var_0.switchToNextPic(var_26_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_7_42, var_7_43, var_7_44, var_6)

	return
end

function var_0_1.updatePanel(arg_27_0)
	local var_27_0 = arg_27_0.curPicInfo.type

	AppreciatePicConst = var_1_10002

	if var_27_0 == var_1_10002.TYPE_GALLERY then
		arg_27_0:updateGalleryPanel()
		arg_27_0:setImage(arg_27_0.galleryPicImg, arg_27_0.curPicInfo)

		setActive = var_1

		var_1(arg_27_0.galleryPanel, true)

		setActive = var_1

		var_1(arg_27_0.mangaPanel, false)
	else
		arg_27_0:updateMangaPanel()
		arg_27_0:setImage(arg_27_0.mangaPicImg, arg_27_0.curPicInfo)

		setActive = var_1

		var_1(arg_27_0.galleryPanel, false)

		setActive = var_1

		var_1(arg_27_0.mangaPanel, true)
	end

	return
end

function var_0_1.updateGalleryPanel(arg_28_0)
	arg_28_0:setImage(arg_28_0.galleryPicBG, arg_28_0.curPicInfo)

	local var_28_0 = arg_28_0:isPicInfoUsed(arg_28_0.curPicInfo)

	setActive = var_1_10002

	var_1_10002(arg_28_0.galleryAddLoadingBtn, not var_28_0)

	setActive = var_1_10002

	var_1_10002(arg_28_0.galleryRemoveLoadingBtn, var_28_0)

	local var_28_1 = arg_28_0
	local var_28_2 = arg_28_0.isPicInfoLiked(var_28_1, arg_28_0.curPicInfo)
	local var_28_3 = arg_28_0.isShowLikeBtn

	setActive = var_28_1

	var_28_1(arg_28_0.galleryLikeBtn, var_28_3)

	setActive = var_28_1

	var_28_1(arg_28_0.galleryAddLikeBtn, not var_28_2)

	setActive = var_28_1

	var_28_1(arg_28_0.galleryRemoveLikeBtn, var_28_2)

	return
end

function var_0_1.updateMangaPanel(arg_29_0)
	arg_29_0:setImage(arg_29_0.mangaPicBG, arg_29_0.curPicInfo)

	local var_29_0 = arg_29_0:isPicInfoUsed(arg_29_0.curPicInfo)

	setActive = var_1_10002

	var_1_10002(arg_29_0.mangaAddLoadingBtn, not var_29_0)

	setActive = var_1_10002

	var_1_10002(arg_29_0.mangaRemoveLoadingBtn, var_29_0)

	local var_29_1 = arg_29_0
	local var_29_2 = arg_29_0.isPicInfoLiked(var_29_1, arg_29_0.curPicInfo)
	local var_29_3 = arg_29_0.isShowLikeBtn

	setActive = var_29_1

	var_29_1(arg_29_0.mangaLikeBtn, var_29_3)

	setActive = var_29_1

	var_29_1(arg_29_0.mangaAddLikeBtn, not var_29_2)

	setActive = var_29_1

	var_29_1(arg_29_0.mangaRemoveLikeBtn, var_29_2)

	return
end

function var_0_1.setImage(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_2.path

	GetFileName = var_1_10004

	local var_30_1 = var_1_10004(var_30_0)

	GetComponent = var_1_10005

	local var_30_2 = arg_30_1

	typeof = var_1_10008
	Image = var_1_10010

	local var_30_3 = var_1_10005(var_30_2, var_1_10008(var_1_10010)).sprite

	IsNil = var_6

	local var_30_4

	if not var_6(var_30_3) then
		var_30_4 = var_30_3.name
		string = var_30_2

		local var_30_5 = var_30_2.lower(var_30_4)

		string = var_8

		if var_30_5 ~= var_8.lower(var_30_1) then
			local var_30_6 = arg_30_0.resLoader

			var_7.LoadSprite(var_30_6, var_30_0, var_30_1, arg_30_1, false)
		end
	else
		local var_30_7 = arg_30_0.resLoader

		var_30_4.LoadSprite(var_30_7, var_30_0, var_30_1, arg_30_1, false)
	end

	setImageAlpha = var_30_4

	var_30_4(arg_30_1, 1)

	return
end

function var_0_1.openFullScreenLayer(arg_31_0)
	LoadContextCommand = var_1_10001

	local var_31_0 = var_1_10001.LoadLayerOnTopContext

	Context = var_1_10003

	local var_31_1 = var_1_10003.New
	local var_31_2 = {}

	AppreciatePicFullScreenMediator = var_1_10006
	var_31_2.mediator = var_1_10006
	AppreciatePicFullScreenLayer = var_1_10006
	var_31_2.viewComponent = var_1_10006
	var_31_2.data = {
		curPicInfo = arg_31_0.curPicInfo
	}

	var_31_0(var_31_1(var_31_2))

	return
end

function var_0_1.switchToPrePic(arg_32_0)
	if arg_32_0.curIndex > 1 then
		arg_32_0.curIndex = arg_32_0.curIndex - 1
		arg_32_0.curPicInfo = arg_32_0.picInfoList[arg_32_0.curIndex]

		arg_32_0:updatePanel()

		existCall = var_1

		var_1(arg_32_0.onPicSwitch, arg_32_0.curPicInfo)
	end

	return
end

function var_0_1.switchToNextPic(arg_33_0)
	if arg_33_0.curIndex < #arg_33_0.picInfoList then
		arg_33_0.curIndex = arg_33_0.curIndex + 1
		arg_33_0.curPicInfo = arg_33_0.picInfoList[arg_33_0.curIndex]

		arg_33_0:updatePanel()

		existCall = var_1

		var_1(arg_33_0.onPicSwitch, arg_33_0.curPicInfo)
	end

	return
end

function var_0_1.isPicInfoUsed(arg_34_0, arg_34_1)
	AppreciatePicConst = var_1_10002

	return var_1_10002.isUsedPicInfo(arg_34_1)
end

function var_0_1.removeLoadingPic(arg_35_0, arg_35_1)
	local var_35_0 = {}
	local var_35_1 = arg_35_1.type

	AppreciatePicConst = var_1_10004

	if var_35_1 == var_1_10004.TYPE_GALLERY then
		local var_35_2 = arg_35_0.loadingPicProxy

		var_35_1 = var_35_1.getGalleryPicIDList(var_35_2)
		ipairs = var_4

		for iter_35_0, iter_35_1 in var_4(var_35_1) do
			if iter_35_1 == arg_35_1.id then
				table = var_9

				var_9.remove(var_35_1, iter_35_0)

				break
			end
		end

		var_35_0.galleryPicIDList = var_35_1
	else
		var_35_1 = arg_35_1.type
		AppreciatePicConst = var_4

		if var_35_1 == var_4.TYPE_MANGA then
			local var_35_3 = arg_35_0.loadingPicProxy

			var_35_1 = var_35_1.getMangaPicIDList(var_35_3)
			ipairs = var_4

			for iter_35_2, iter_35_3 in var_4(var_35_1) do
				if iter_35_3 == arg_35_1.id then
					table = var_9

					var_9.remove(var_35_1, iter_35_2)

					break
				end
			end

			var_35_0.mangaPicIDList = var_35_1
		end
	end

	pg = var_35_1

	local var_35_4 = var_35_1.m02
	local var_35_5 = var_3.sendNotification

	GAME = var_1_10006

	var_35_5(var_35_4, var_1_10006.UPDATE_LOADING_PIC, var_35_0)

	return
end

function var_0_1.addLoadingPic(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0

	if arg_36_0.isPicInfoUsed(var_36_0, arg_36_1) then
		warning = var_2

		var_2("already used.", arg_36_1.type, arg_36_1.id)

		return
	end

	local var_36_1 = {}
	local var_36_2 = arg_36_1.type

	AppreciatePicConst = var_36_0

	if var_36_2 == var_36_0.TYPE_GALLERY then
		local var_36_3 = arg_36_0.loadingPicProxy

		var_36_2 = var_36_2.getGalleryPicIDList(var_36_3)
		table = var_4

		var_4.insert(var_36_2, arg_36_1.id)

		var_36_1.galleryPicIDList = var_36_2
	else
		var_36_2 = arg_36_1.type
		AppreciatePicConst = var_4

		if var_36_2 == var_4.TYPE_MANGA then
			local var_36_4 = arg_36_0.loadingPicProxy

			var_36_2 = var_36_2.getMangaPicIDList(var_36_4)
			table = var_4

			var_4.insert(var_36_2, arg_36_1.id)

			var_36_1.mangaPicIDList = var_36_2
		end
	end

	pg = var_36_2

	local var_36_5 = var_36_2.m02
	local var_36_6 = var_3.sendNotification

	GAME = var_1_10006

	var_36_6(var_36_5, var_1_10006.UPDATE_LOADING_PIC, var_36_1)

	return
end

function var_0_1.isPicInfoLiked(arg_37_0, arg_37_1)
	AppreciatePicConst = var_1_10002

	return var_1_10002.isPicInfoLiked(arg_37_1)
end

function var_0_1.addLike(arg_38_0, arg_38_1)
	local var_38_0 = {}
	local var_38_1 = arg_38_1.type

	AppreciatePicConst = var_1_10004

	if var_38_1 == var_1_10004.TYPE_GALLERY then
		var_38_0.picID = arg_38_1.id
		var_38_0.isAdd = 0
		pg = var_3

		local var_38_2 = var_3.m02
		local var_38_3 = var_3.sendNotification

		GAME = var_1_10006

		var_38_3(var_38_2, var_1_10006.APPRECIATE_GALLERY_LIKE, var_38_0)
	else
		local var_38_4 = arg_38_1.type

		AppreciatePicConst = var_4

		if var_38_4 == var_4.TYPE_MANGA then
			var_38_0.mangaID = arg_38_1.id
			var_38_0.action = 0
			pg = var_3

			local var_38_5 = var_3.m02
			local var_38_6 = var_3.sendNotification

			GAME = var_1_10006

			var_38_6(var_38_5, var_1_10006.APPRECIATE_MANGA_LIKE, var_38_0)
		end
	end

	return
end

function var_0_1.removeLike(arg_39_0, arg_39_1)
	local var_39_0 = {}
	local var_39_1 = arg_39_1.type

	AppreciatePicConst = var_1_10004

	if var_39_1 == var_1_10004.TYPE_GALLERY then
		var_39_0.picID = arg_39_1.id
		var_39_0.isAdd = 1
		pg = var_3

		local var_39_2 = var_3.m02
		local var_39_3 = var_3.sendNotification

		GAME = var_1_10006

		var_39_3(var_39_2, var_1_10006.APPRECIATE_GALLERY_LIKE, var_39_0)
	else
		local var_39_4 = arg_39_1.type

		AppreciatePicConst = var_4

		if var_39_4 == var_4.TYPE_MANGA then
			var_39_0.mangaID = arg_39_1.id
			var_39_0.action = 1
			pg = var_3

			local var_39_5 = var_3.m02
			local var_39_6 = var_3.sendNotification

			GAME = var_1_10006

			var_39_6(var_39_5, var_1_10006.APPRECIATE_MANGA_LIKE, var_39_0)
		end
	end

	return
end

function var_0_1.addOpenList(arg_40_0)
	local var_40_0 = arg_40_0.curPicInfo.type

	AppreciatePicConst = var_1_10002

	if var_40_0 == var_1_10002.TYPE_GALLERY then
		getProxy = var_40_0
		LoadingPicProxy = var_1_10003
		var_1_10003 = var_40_0(var_1_10003)

		var_1.addGalleryNewPicOpenList(var_1_10003, arg_40_0.curPicInfo.id)
	else
		local var_40_1 = arg_40_0.curPicInfo.type

		AppreciatePicConst = var_2

		if var_40_1 == var_2.TYPE_MANGA then
			getProxy = var_40_1
			LoadingPicProxy = var_1_10003

			local var_40_2 = var_40_1(var_1_10003)

			var_1.addMangaNewPicOpenList(var_40_2, arg_40_0.curPicInfo.id)
		end
	end

	return
end

function var_0_1.getPicInfoIndex(arg_41_0, arg_41_1)
	ipairs = var_1_10002

	for iter_41_0, iter_41_1 in var_1_10002(arg_41_0.picInfoList) do
		if iter_41_1.id == arg_41_1.id and iter_41_1.type == arg_41_1.type then
			return iter_41_0
		end
	end

	return nil
end

return var_0_1
