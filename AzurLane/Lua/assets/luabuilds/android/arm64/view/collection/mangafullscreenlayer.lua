local var_0_0 = class("MangaFullScreenLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "MangaViewUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)
	arg_3_0:readManga()
	arg_3_0:updatePicImg()
	arg_3_0:updateLikeBtn()
	arg_3_0:updateLoadingBtn()

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)
	arg_4_0.resLoader:Clear()

	if arg_4_0.contextData.mangaContext then
		arg_4_0.contextData.mangaContext:updateToMangaID(arg_4_0.mangaIDLIst[arg_4_0.curMangaIndex])
	end

	return
end

function var_0_0.onBackPressed(arg_5_0)
	if not arg_5_0.isShowing then
		arg_5_0:closeView()
	end

	return
end

function var_0_0.findUI(arg_6_0)
	arg_6_0.bg = arg_6_0._tf:Find("BG")
	arg_6_0.picImg = arg_6_0._tf:Find("Manga/Pic")
	arg_6_0.indexText = arg_6_0._tf:Find("Manga/Index")
	arg_6_0.preBtn = arg_6_0._tf:Find("LeftBtn")
	arg_6_0.rightBtn = arg_6_0._tf:Find("RightBtn")
	arg_6_0.tipText = arg_6_0._tf:Find("Tip")
	arg_6_0.likeOnBtn = arg_6_0._tf:Find("Manga/LikeOn")
	arg_6_0.likeOffBtn = arg_6_0._tf:Find("Manga/LikeOff")
	arg_6_0.addLoadingBtn = arg_6_0._tf:Find("Manga/LoadingBtn/Off")
	arg_6_0.removeLoadingBtn = arg_6_0._tf:Find("Manga/LoadingBtn/On")

	setText(arg_6_0.tipText, i18n("world_collection_back"))

	return
end

function var_0_0.initData(arg_7_0)
	arg_7_0.resLoader = AutoLoader.New()
	arg_7_0.curMangaIndex = arg_7_0.contextData.mangaIndex
	arg_7_0.mangaIDLIst = arg_7_0.contextData.mangaIDLIst

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.bg, function()
		if not arg_8_0.isShowing then
			arg_8_0:closeView()
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.preBtn, function()
		if arg_8_0.curMangaIndex > 1 then
			arg_8_0.curMangaIndex = arg_8_0.curMangaIndex - 1

			arg_8_0:readManga()
			arg_8_0:updatePicImg()
			arg_8_0:updateLikeBtn()
			arg_8_0:updateLoadingBtn()
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.rightBtn, function()
		if arg_8_0.curMangaIndex < #arg_8_0.mangaIDLIst then
			arg_8_0.curMangaIndex = arg_8_0.curMangaIndex + 1

			arg_8_0:readManga()
			arg_8_0:updatePicImg()
			arg_8_0:updateLikeBtn()
			arg_8_0:updateLoadingBtn()
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.likeOnBtn, function()
		pg.m02:sendNotification(GAME.APPRECIATE_MANGA_LIKE, {
			mangaID = arg_8_0.mangaIDLIst[arg_8_0.curMangaIndex],
			action = MangaConst.CANCEL_MANGA_LIKE
		})

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.likeOffBtn, function()
		pg.m02:sendNotification(GAME.APPRECIATE_MANGA_LIKE, {
			mangaID = arg_8_0.mangaIDLIst[arg_8_0.curMangaIndex],
			action = MangaConst.SET_MANGA_LIKE
		})

		return
	end, SFX_PANEL)
	addSlip(SLIP_TYPE_HRZ, arg_8_0.picImg, function()
		triggerButton(arg_8_0.preBtn)

		return
	end, function()
		triggerButton(arg_8_0.rightBtn)

		return
	end)
	addSlip(SLIP_TYPE_HRZ, arg_8_0.bg, function()
		triggerButton(arg_8_0.preBtn)

		return
	end, function()
		triggerButton(arg_8_0.rightBtn)

		return
	end)
	onButton(arg_8_0, arg_8_0.addLoadingBtn, function()
		arg_8_0:addLoadingPic(arg_8_0.mangaIDLIst[arg_8_0.curMangaIndex])

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.removeLoadingBtn, function()
		arg_8_0:removeLoadingPic(arg_8_0.mangaIDLIst[arg_8_0.curMangaIndex])

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updatePicImg(arg_20_0)
	arg_20_0.resLoader:LoadSprite(MangaConst.MANGA_PATH_PREFIX .. pg.cartoon[arg_20_0.mangaIDLIst[arg_20_0.curMangaIndex]].resource, pg.cartoon[arg_20_0.mangaIDLIst[arg_20_0.curMangaIndex]].resource, arg_20_0.picImg, false)

	local var_20_0 = arg_20_0.contextData.isShowingNotRead and "#" .. pg.cartoon[arg_20_0.mangaIDLIst[arg_20_0.curMangaIndex]].cartoon_id or "#" .. pg.cartoon[arg_20_0.mangaIDLIst[arg_20_0.curMangaIndex]].cartoon_id .. "/" .. #arg_20_0.mangaIDLIst

	setText(arg_20_0.indexText, var_20_0)

	arg_20_0.isShowing = true

	arg_20_0:managedTween(LeanTween.value, nil, go(arg_20_0.picImg), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_21_0)
		setImageAlpha(arg_20_0.picImg, arg_21_0)

		return
	end)):setOnComplete(System.Action(function()
		arg_20_0.isShowing = false

		setImageAlpha(arg_20_0.picImg, 1)

		return
	end))
	setActive(arg_20_0.preBtn, arg_20_0.curMangaIndex > 1)
	setActive(arg_20_0.rightBtn, arg_20_0.curMangaIndex < #arg_20_0.mangaIDLIst)

	return
end

function var_0_0.updateLikeBtn(arg_23_0)
	local var_23_0 = MangaConst.isMangaLikeByID(arg_23_0.mangaIDLIst[arg_23_0.curMangaIndex])

	setActive(arg_23_0.likeOnBtn, var_23_0)
	setActive(arg_23_0.likeOffBtn, not var_23_0)

	return
end

function var_0_0.updateLoadingBtn(arg_24_0)
	local var_24_0 = arg_24_0:isPicUsed(arg_24_0.mangaIDLIst[arg_24_0.curMangaIndex])

	setActive(arg_24_0.addLoadingBtn, not var_24_0)
	setActive(arg_24_0.removeLoadingBtn, var_24_0)

	return
end

function var_0_0.readManga(arg_25_0)
	if not MangaConst.isMangaEverReadByID(arg_25_0.mangaIDLIst[arg_25_0.curMangaIndex]) then
		pg.m02:sendNotification(GAME.APPRECIATE_MANGA_READ, {
			mangaID = arg_25_0.mangaIDLIst[arg_25_0.curMangaIndex]
		})
	end

	return
end

function var_0_0.isPicUsed(arg_26_0, arg_26_1)
	return table.contains(getProxy(LoadingPicProxy):getMangaPicIDList(true), arg_26_1)
end

function var_0_0.removeLoadingPic(arg_27_0, arg_27_1)
	local var_27_0 = getProxy(LoadingPicProxy):getMangaPicIDList()

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		if iter_27_1 == arg_27_1 then
			table.remove(var_27_0, iter_27_0)

			break
		end
	end

	;({}).mangaPicIDList = var_27_0

	pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, {})

	return
end

function var_0_0.addLoadingPic(arg_28_0, arg_28_1)
	if arg_28_0:isPicUsed(arg_28_1) then
		warning("already used.", arg_28_1)

		return
	end

	local var_28_0 = {}
	local var_28_1 = getProxy(LoadingPicProxy):getMangaPicIDList()

	table.insert(var_28_1, arg_28_1)

	var_28_0.mangaPicIDList = var_28_1

	pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, var_28_0)

	return
end

return var_0_0
