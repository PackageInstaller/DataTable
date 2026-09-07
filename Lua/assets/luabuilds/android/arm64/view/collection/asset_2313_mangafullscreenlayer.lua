local MangaFullScreenLayer = class("MangaFullScreenLayer", import("..base.BaseUI"))

function MangaFullScreenLayer:getUIName()
	return "MangaViewUI"
end

function MangaFullScreenLayer:init()
	self:findUI()
	self:initData()
	self:addListener()

	return
end

function MangaFullScreenLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:readManga()
	self:updatePicImg()
	self:updateLikeBtn()
	self:updateLoadingBtn()

	return
end

function MangaFullScreenLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self.resLoader:Clear()

	if self.contextData.mangaContext then
		self.contextData.mangaContext:updateToMangaID(self.mangaIDLIst[self.curMangaIndex])
	end

	return
end

function MangaFullScreenLayer:onBackPressed()
	if not self.isShowing then
		self:closeView()
	end

	return
end

function MangaFullScreenLayer:findUI()
	self.bg = self._tf:Find("BG")
	self.picImg = self._tf:Find("Manga/Pic")
	self.indexText = self._tf:Find("Manga/Index")
	self.preBtn = self._tf:Find("LeftBtn")
	self.rightBtn = self._tf:Find("RightBtn")
	self.tipText = self._tf:Find("Tip")
	self.likeOnBtn = self._tf:Find("Manga/LikeOn")
	self.likeOffBtn = self._tf:Find("Manga/LikeOff")
	self.addLoadingBtn = self._tf:Find("Manga/LoadingBtn/Off")
	self.removeLoadingBtn = self._tf:Find("Manga/LoadingBtn/On")

	setText(self.tipText, i18n("world_collection_back"))

	return
end

function MangaFullScreenLayer:initData()
	self.resLoader = AutoLoader.New()
	self.curMangaIndex = self.contextData.mangaIndex
	self.mangaIDLIst = self.contextData.mangaIDLIst

	return
end

function MangaFullScreenLayer:addListener()
	onButton(self, self.bg, function()
		if not self.isShowing then
			self:closeView()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.preBtn, function()
		if self.curMangaIndex > 1 then
			self.curMangaIndex = self.curMangaIndex - 1

			self:readManga()
			self:updatePicImg()
			self:updateLikeBtn()
			self:updateLoadingBtn()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.rightBtn, function()
		if self.curMangaIndex < #self.mangaIDLIst then
			self.curMangaIndex = self.curMangaIndex + 1

			self:readManga()
			self:updatePicImg()
			self:updateLikeBtn()
			self:updateLoadingBtn()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.likeOnBtn, function()
		pg.m02:sendNotification(GAME.APPRECIATE_MANGA_LIKE, {
			mangaID = self.mangaIDLIst[self.curMangaIndex],
			action = MangaConst.CANCEL_MANGA_LIKE
		})

		return
	end, SFX_PANEL)
	onButton(self, self.likeOffBtn, function()
		pg.m02:sendNotification(GAME.APPRECIATE_MANGA_LIKE, {
			mangaID = self.mangaIDLIst[self.curMangaIndex],
			action = MangaConst.SET_MANGA_LIKE
		})

		return
	end, SFX_PANEL)
	addSlip(SLIP_TYPE_HRZ, self.picImg, function()
		triggerButton(self.preBtn)

		return
	end, function()
		triggerButton(self.rightBtn)

		return
	end)
	addSlip(SLIP_TYPE_HRZ, self.bg, function()
		triggerButton(self.preBtn)

		return
	end, function()
		triggerButton(self.rightBtn)

		return
	end)
	onButton(self, self.addLoadingBtn, function()
		self:addLoadingPic(self.mangaIDLIst[self.curMangaIndex])

		return
	end, SFX_PANEL)
	onButton(self, self.removeLoadingBtn, function()
		self:removeLoadingPic(self.mangaIDLIst[self.curMangaIndex])

		return
	end, SFX_PANEL)

	return
end

function MangaFullScreenLayer:updatePicImg()
	self.resLoader:LoadSprite(MangaConst.MANGA_PATH_PREFIX .. pg.cartoon[self.mangaIDLIst[self.curMangaIndex]].resource, pg.cartoon[self.mangaIDLIst[self.curMangaIndex]].resource, self.picImg, false)
	setText(self.indexText, self.contextData.isShowingNotRead and "#" .. pg.cartoon[self.mangaIDLIst[self.curMangaIndex]].cartoon_id or "#" .. pg.cartoon[self.mangaIDLIst[self.curMangaIndex]].cartoon_id .. "/" .. #self.mangaIDLIst)

	self.isShowing = true

	self:managedTween(LeanTween.value, nil, go(self.picImg), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_21_0)
		setImageAlpha(self.picImg, arg_21_0)

		return
	end)):setOnComplete(System.Action(function()
		self.isShowing = false

		setImageAlpha(self.picImg, 1)

		return
	end))
	setActive(self.preBtn, self.curMangaIndex > 1)
	setActive(self.rightBtn, self.curMangaIndex < #self.mangaIDLIst)

	return
end

function MangaFullScreenLayer:updateLikeBtn()
	local var_23_0 = MangaConst.isMangaLikeByID(self.mangaIDLIst[self.curMangaIndex])

	setActive(self.likeOnBtn, var_23_0)
	setActive(self.likeOffBtn, not var_23_0)

	return
end

function MangaFullScreenLayer:updateLoadingBtn()
	local var_24_0 = self:isPicUsed(self.mangaIDLIst[self.curMangaIndex])

	setActive(self.addLoadingBtn, not var_24_0)
	setActive(self.removeLoadingBtn, var_24_0)

	return
end

function MangaFullScreenLayer:readManga()
	if not MangaConst.isMangaEverReadByID(self.mangaIDLIst[self.curMangaIndex]) then
		pg.m02:sendNotification(GAME.APPRECIATE_MANGA_READ, {
			mangaID = self.mangaIDLIst[self.curMangaIndex]
		})
	end

	return
end

function MangaFullScreenLayer:isPicUsed(arg_26_1)
	return table.contains(getProxy(LoadingPicProxy):getMangaPicIDList(true), arg_26_1)
end

function MangaFullScreenLayer:removeLoadingPic(arg_27_1)
	local var_27_0 = {}
	local var_27_1 = getProxy(LoadingPicProxy):getMangaPicIDList()

	for iter_27_0, iter_27_1 in ipairs(var_27_1) do
		if iter_27_1 == arg_27_1 then
			table.remove(var_27_1, iter_27_0)

			break
		end
	end

	var_27_0.mangaPicIDList = var_27_1

	pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, var_27_0)

	return
end

function MangaFullScreenLayer:addLoadingPic(arg_28_1)
	if self:isPicUsed(arg_28_1) then
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

return MangaFullScreenLayer
