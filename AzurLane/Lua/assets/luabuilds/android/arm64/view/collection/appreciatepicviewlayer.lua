local var_0_0 = class("AppreciatePicViewLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AppreciatePicViewUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()
	arg_2_0:updatePanel()

	return
end

function var_0_0.didEnter(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)
	arg_4_0.resLoader:Clear()

	return
end

function var_0_0.findUI(arg_5_0)
	setText(arg_5_0.galleryPicSetLoadingTipText, i18n("loading_set_tip"))
	setText(arg_5_0.mangaPicSetLoadingTipText, i18n("loading_set_tip"))

	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.resLoader = AutoLoader.New()
	arg_6_0.curPicInfo = arg_6_0.contextData.curPicInfo
	arg_6_0.picInfoList = arg_6_0.contextData.picInfoList
	arg_6_0.isShowLikeBtn = arg_6_0.contextData.isShowLikeBtn
	arg_6_0.onPicSwitch = arg_6_0.contextData.onPicSwitch
	arg_6_0.curIndex = arg_6_0:getPicInfoIndex(arg_6_0.curPicInfo)
	arg_6_0.loadingPicProxy = getProxy(LoadingPicProxy)

	arg_6_0:addOpenList()

	return
end

function var_0_0.addListener(arg_7_0)
	onButton(arg_7_0, arg_7_0.bg, function()
		arg_7_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.galleryAddLoadingBtn, function()
		arg_7_0:addLoadingPic(arg_7_0.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.galleryRemoveLoadingBtn, function()
		arg_7_0:removeLoadingPic(arg_7_0.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.mangaAddLoadingBtn, function()
		arg_7_0:addLoadingPic(arg_7_0.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.mangaRemoveLoadingBtn, function()
		arg_7_0:removeLoadingPic(arg_7_0.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.galleryAddLikeBtn, function()
		arg_7_0:addLike(arg_7_0.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.galleryRemoveLikeBtn, function()
		arg_7_0:removeLike(arg_7_0.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.mangaAddLikeBtn, function()
		arg_7_0:addLike(arg_7_0.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.mangaRemoveLikeBtn, function()
		arg_7_0:removeLike(arg_7_0.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.galleryPicImg, function()
		arg_7_0:openFullScreenLayer()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.mangaPicImg, function()
		arg_7_0:openFullScreenLayer()

		return
	end, SFX_PANEL)
	addSlip(SLIP_TYPE_HRZ, arg_7_0.galleryPicImg, function()
		arg_7_0:switchToPrePic()

		return
	end, function()
		arg_7_0:switchToNextPic()

		return
	end)
	addSlip(SLIP_TYPE_HRZ, arg_7_0.mangaPicImg, function()
		arg_7_0:switchToPrePic()

		return
	end, function()
		arg_7_0:switchToNextPic()

		return
	end)
	onButton(arg_7_0, arg_7_0.galleryLeftBtn, function()
		arg_7_0:switchToPrePic()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.galleryRightBtn, function()
		arg_7_0:switchToNextPic()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.mangaLeftBtn, function()
		arg_7_0:switchToPrePic()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.mangaRightBtn, function()
		arg_7_0:switchToNextPic()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updatePanel(arg_27_0)
	if arg_27_0.curPicInfo.type == AppreciatePicConst.TYPE_GALLERY then
		arg_27_0:updateGalleryPanel()
		arg_27_0:setImage(arg_27_0.galleryPicImg, arg_27_0.curPicInfo)
		setActive(arg_27_0.galleryPanel, true)
		setActive(arg_27_0.mangaPanel, false)
	else
		arg_27_0:updateMangaPanel()
		arg_27_0:setImage(arg_27_0.mangaPicImg, arg_27_0.curPicInfo)
		setActive(arg_27_0.galleryPanel, false)
		setActive(arg_27_0.mangaPanel, true)
	end

	return
end

function var_0_0.updateGalleryPanel(arg_28_0)
	arg_28_0:setImage(arg_28_0.galleryPicBG, arg_28_0.curPicInfo)

	local var_28_0 = arg_28_0:isPicInfoUsed(arg_28_0.curPicInfo)

	setActive(arg_28_0.galleryAddLoadingBtn, not var_28_0)
	setActive(arg_28_0.galleryRemoveLoadingBtn, var_28_0)

	local var_28_1 = arg_28_0:isPicInfoLiked(arg_28_0.curPicInfo)

	setActive(arg_28_0.galleryLikeBtn, arg_28_0.isShowLikeBtn)
	setActive(arg_28_0.galleryAddLikeBtn, not var_28_1)
	setActive(arg_28_0.galleryRemoveLikeBtn, var_28_1)

	return
end

function var_0_0.updateMangaPanel(arg_29_0)
	arg_29_0:setImage(arg_29_0.mangaPicBG, arg_29_0.curPicInfo)

	local var_29_0 = arg_29_0:isPicInfoUsed(arg_29_0.curPicInfo)

	setActive(arg_29_0.mangaAddLoadingBtn, not var_29_0)
	setActive(arg_29_0.mangaRemoveLoadingBtn, var_29_0)

	local var_29_1 = arg_29_0:isPicInfoLiked(arg_29_0.curPicInfo)

	setActive(arg_29_0.mangaLikeBtn, arg_29_0.isShowLikeBtn)
	setActive(arg_29_0.mangaAddLikeBtn, not var_29_1)
	setActive(arg_29_0.mangaRemoveLikeBtn, var_29_1)

	return
end

function var_0_0.setImage(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = GetFileName(arg_30_2.path)
	local var_30_1 = GetComponent(arg_30_1, typeof(Image)).sprite

	if not IsNil(var_30_1) then
		if string.lower(var_30_1.name) ~= string.lower(var_30_0) then
			arg_30_0.resLoader:LoadSprite(arg_30_2.path, var_30_0, arg_30_1, false)
		end
	else
		arg_30_0.resLoader:LoadSprite(arg_30_2.path, var_30_0, arg_30_1, false)
	end

	setImageAlpha(arg_30_1, 1)

	return
end

function var_0_0.openFullScreenLayer(arg_31_0)
	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = AppreciatePicFullScreenMediator,
		viewComponent = AppreciatePicFullScreenLayer,
		data = {
			curPicInfo = arg_31_0.curPicInfo
		}
	}))

	return
end

function var_0_0.switchToPrePic(arg_32_0)
	if arg_32_0.curIndex > 1 then
		arg_32_0.curIndex = arg_32_0.curIndex - 1
		arg_32_0.curPicInfo = arg_32_0.picInfoList[arg_32_0.curIndex]

		arg_32_0:updatePanel()
		existCall(arg_32_0.onPicSwitch, arg_32_0.curPicInfo)
	end

	return
end

function var_0_0.switchToNextPic(arg_33_0)
	if arg_33_0.curIndex < #arg_33_0.picInfoList then
		arg_33_0.curIndex = arg_33_0.curIndex + 1
		arg_33_0.curPicInfo = arg_33_0.picInfoList[arg_33_0.curIndex]

		arg_33_0:updatePanel()
		existCall(arg_33_0.onPicSwitch, arg_33_0.curPicInfo)
	end

	return
end

function var_0_0.isPicInfoUsed(arg_34_0, arg_34_1)
	return AppreciatePicConst.isUsedPicInfo(arg_34_1)
end

function var_0_0.removeLoadingPic(arg_35_0, arg_35_1)
	if arg_35_1.type == AppreciatePicConst.TYPE_GALLERY then
		local var_35_0 = arg_35_0.loadingPicProxy:getGalleryPicIDList()

		for iter_35_0, iter_35_1 in ipairs(var_35_0) do
			if iter_35_1 == arg_35_1.id then
				table.remove(var_35_0, iter_35_0)

				break
			end
		end

		;({}).galleryPicIDList = var_35_0
	elseif arg_35_1.type == AppreciatePicConst.TYPE_MANGA then
		local var_35_1 = arg_35_0.loadingPicProxy:getMangaPicIDList()

		for iter_35_2, iter_35_3 in ipairs(var_35_1) do
			if iter_35_3 == arg_35_1.id then
				table.remove(var_35_1, iter_35_2)

				break
			end
		end

		;({}).mangaPicIDList = var_35_1
	end

	pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, {})

	return
end

function var_0_0.addLoadingPic(arg_36_0, arg_36_1)
	if arg_36_0:isPicInfoUsed(arg_36_1) then
		warning("already used.", arg_36_1.type, arg_36_1.id)

		return
	end

	local var_36_0 = {}

	if arg_36_1.type == AppreciatePicConst.TYPE_GALLERY then
		local var_36_1 = arg_36_0.loadingPicProxy:getGalleryPicIDList()

		table.insert(var_36_1, arg_36_1.id)

		var_36_0.galleryPicIDList = var_36_1
	elseif arg_36_1.type == AppreciatePicConst.TYPE_MANGA then
		local var_36_2 = arg_36_0.loadingPicProxy:getMangaPicIDList()

		table.insert(var_36_2, arg_36_1.id)

		var_36_0.mangaPicIDList = var_36_2
	end

	pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, var_36_0)

	return
end

function var_0_0.isPicInfoLiked(arg_37_0, arg_37_1)
	return AppreciatePicConst.isPicInfoLiked(arg_37_1)
end

function var_0_0.addLike(arg_38_0, arg_38_1)
	if arg_38_1.type == AppreciatePicConst.TYPE_GALLERY then
		({}).picID = arg_38_1.id
		;({}).isAdd = 0

		pg.m02:sendNotification(GAME.APPRECIATE_GALLERY_LIKE, {})
	elseif arg_38_1.type == AppreciatePicConst.TYPE_MANGA then
		({}).mangaID = arg_38_1.id
		;({}).action = 0

		pg.m02:sendNotification(GAME.APPRECIATE_MANGA_LIKE, {})
	end

	return
end

function var_0_0.removeLike(arg_39_0, arg_39_1)
	if arg_39_1.type == AppreciatePicConst.TYPE_GALLERY then
		({}).picID = arg_39_1.id
		;({}).isAdd = 1

		pg.m02:sendNotification(GAME.APPRECIATE_GALLERY_LIKE, {})
	elseif arg_39_1.type == AppreciatePicConst.TYPE_MANGA then
		({}).mangaID = arg_39_1.id
		;({}).action = 1

		pg.m02:sendNotification(GAME.APPRECIATE_MANGA_LIKE, {})
	end

	return
end

function var_0_0.addOpenList(arg_40_0)
	if arg_40_0.curPicInfo.type == AppreciatePicConst.TYPE_GALLERY then
		getProxy(LoadingPicProxy):addGalleryNewPicOpenList(arg_40_0.curPicInfo.id)
	elseif arg_40_0.curPicInfo.type == AppreciatePicConst.TYPE_MANGA then
		getProxy(LoadingPicProxy):addMangaNewPicOpenList(arg_40_0.curPicInfo.id)
	end

	return
end

function var_0_0.getPicInfoIndex(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0.picInfoList) do
		if iter_41_1.id == arg_41_1.id and iter_41_1.type == arg_41_1.type then
			return iter_41_0
		end
	end

	return nil
end

return var_0_0
