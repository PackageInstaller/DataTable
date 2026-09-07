local AppreciatePicViewLayer = class("AppreciatePicViewLayer", import("..base.BaseUI"))

function AppreciatePicViewLayer:getUIName()
	return "AppreciatePicViewUI"
end

function AppreciatePicViewLayer:init()
	self:findUI()
	self:initData()
	self:addListener()
	self:updatePanel()

	return
end

function AppreciatePicViewLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function AppreciatePicViewLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self.resLoader:Clear()

	return
end

function AppreciatePicViewLayer:findUI()
	setText(self.galleryPicSetLoadingTipText, i18n("loading_set_tip"))
	setText(self.mangaPicSetLoadingTipText, i18n("loading_set_tip"))

	return
end

function AppreciatePicViewLayer:initData()
	self.resLoader = AutoLoader.New()
	self.curPicInfo = self.contextData.curPicInfo
	self.picInfoList = self.contextData.picInfoList
	self.isShowLikeBtn = self.contextData.isShowLikeBtn
	self.onPicSwitch = self.contextData.onPicSwitch
	self.curIndex = self:getPicInfoIndex(self.curPicInfo)
	self.loadingPicProxy = getProxy(LoadingPicProxy)

	self:addOpenList()

	return
end

function AppreciatePicViewLayer:addListener()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.galleryAddLoadingBtn, function()
		self:addLoadingPic(self.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(self, self.galleryRemoveLoadingBtn, function()
		self:removeLoadingPic(self.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(self, self.mangaAddLoadingBtn, function()
		self:addLoadingPic(self.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(self, self.mangaRemoveLoadingBtn, function()
		self:removeLoadingPic(self.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(self, self.galleryAddLikeBtn, function()
		self:addLike(self.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(self, self.galleryRemoveLikeBtn, function()
		self:removeLike(self.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(self, self.mangaAddLikeBtn, function()
		self:addLike(self.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(self, self.mangaRemoveLikeBtn, function()
		self:removeLike(self.curPicInfo)

		return
	end, SFX_PANEL)
	onButton(self, self.galleryPicImg, function()
		self:openFullScreenLayer()

		return
	end, SFX_PANEL)
	onButton(self, self.mangaPicImg, function()
		self:openFullScreenLayer()

		return
	end, SFX_PANEL)
	addSlip(SLIP_TYPE_HRZ, self.galleryPicImg, function()
		self:switchToPrePic()

		return
	end, function()
		self:switchToNextPic()

		return
	end)
	addSlip(SLIP_TYPE_HRZ, self.mangaPicImg, function()
		self:switchToPrePic()

		return
	end, function()
		self:switchToNextPic()

		return
	end)
	onButton(self, self.galleryLeftBtn, function()
		self:switchToPrePic()

		return
	end, SFX_PANEL)
	onButton(self, self.galleryRightBtn, function()
		self:switchToNextPic()

		return
	end, SFX_PANEL)
	onButton(self, self.mangaLeftBtn, function()
		self:switchToPrePic()

		return
	end, SFX_PANEL)
	onButton(self, self.mangaRightBtn, function()
		self:switchToNextPic()

		return
	end, SFX_PANEL)

	return
end

function AppreciatePicViewLayer:updatePanel()
	if self.curPicInfo.type == AppreciatePicConst.TYPE_GALLERY then
		self:updateGalleryPanel()
		self:setImage(self.galleryPicImg, self.curPicInfo)
		setActive(self.galleryPanel, true)
		setActive(self.mangaPanel, false)
	else
		self:updateMangaPanel()
		self:setImage(self.mangaPicImg, self.curPicInfo)
		setActive(self.galleryPanel, false)
		setActive(self.mangaPanel, true)
	end

	return
end

function AppreciatePicViewLayer:updateGalleryPanel()
	self:setImage(self.galleryPicBG, self.curPicInfo)

	local var_28_0 = self:isPicInfoUsed(self.curPicInfo)

	setActive(self.galleryAddLoadingBtn, not var_28_0)
	setActive(self.galleryRemoveLoadingBtn, var_28_0)

	local var_28_1 = self:isPicInfoLiked(self.curPicInfo)

	setActive(self.galleryLikeBtn, self.isShowLikeBtn)
	setActive(self.galleryAddLikeBtn, not var_28_1)
	setActive(self.galleryRemoveLikeBtn, var_28_1)

	return
end

function AppreciatePicViewLayer:updateMangaPanel()
	self:setImage(self.mangaPicBG, self.curPicInfo)

	local var_29_0 = self:isPicInfoUsed(self.curPicInfo)

	setActive(self.mangaAddLoadingBtn, not var_29_0)
	setActive(self.mangaRemoveLoadingBtn, var_29_0)

	local var_29_1 = self:isPicInfoLiked(self.curPicInfo)

	setActive(self.mangaLikeBtn, self.isShowLikeBtn)
	setActive(self.mangaAddLikeBtn, not var_29_1)
	setActive(self.mangaRemoveLikeBtn, var_29_1)

	return
end

function AppreciatePicViewLayer:setImage(arg_30_1, arg_30_2)
	local var_30_0 = GetFileName(arg_30_2.path)
	local var_30_1 = GetComponent(arg_30_1, typeof(Image)).sprite

	if not IsNil(var_30_1) then
		if string.lower(var_30_1.name) ~= string.lower(var_30_0) then
			self.resLoader:LoadSprite(arg_30_2.path, var_30_0, arg_30_1, false)
		end
	else
		self.resLoader:LoadSprite(arg_30_2.path, var_30_0, arg_30_1, false)
	end

	setImageAlpha(arg_30_1, 1)

	return
end

function AppreciatePicViewLayer:openFullScreenLayer()
	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = AppreciatePicFullScreenMediator,
		viewComponent = AppreciatePicFullScreenLayer,
		data = {
			curPicInfo = self.curPicInfo
		}
	}))

	return
end

function AppreciatePicViewLayer:switchToPrePic()
	if self.curIndex > 1 then
		self.curIndex = self.curIndex - 1
		self.curPicInfo = self.picInfoList[self.curIndex]

		self:updatePanel()
		existCall(self.onPicSwitch, self.curPicInfo)
	end

	return
end

function AppreciatePicViewLayer:switchToNextPic()
	if self.curIndex < #self.picInfoList then
		self.curIndex = self.curIndex + 1
		self.curPicInfo = self.picInfoList[self.curIndex]

		self:updatePanel()
		existCall(self.onPicSwitch, self.curPicInfo)
	end

	return
end

function AppreciatePicViewLayer:isPicInfoUsed(arg_34_1)
	return AppreciatePicConst.isUsedPicInfo(arg_34_1)
end

function AppreciatePicViewLayer:removeLoadingPic(arg_35_1)
	local var_35_0 = {}

	if arg_35_1.type == AppreciatePicConst.TYPE_GALLERY then
		local var_35_1 = self.loadingPicProxy:getGalleryPicIDList()

		for iter_35_0, iter_35_1 in ipairs(var_35_1) do
			if iter_35_1 == arg_35_1.id then
				table.remove(var_35_1, iter_35_0)

				break
			end
		end

		var_35_0.galleryPicIDList = var_35_1
	elseif arg_35_1.type == AppreciatePicConst.TYPE_MANGA then
		local var_35_2 = self.loadingPicProxy:getMangaPicIDList()

		for iter_35_2, iter_35_3 in ipairs(var_35_2) do
			if iter_35_3 == arg_35_1.id then
				table.remove(var_35_2, iter_35_2)

				break
			end
		end

		var_35_0.mangaPicIDList = var_35_2
	end

	pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, var_35_0)

	return
end

function AppreciatePicViewLayer:addLoadingPic(arg_36_1)
	if self:isPicInfoUsed(arg_36_1) then
		warning("already used.", arg_36_1.type, arg_36_1.id)

		return
	end

	local var_36_0 = {}

	if arg_36_1.type == AppreciatePicConst.TYPE_GALLERY then
		local var_36_1 = self.loadingPicProxy:getGalleryPicIDList()

		table.insert(var_36_1, arg_36_1.id)

		var_36_0.galleryPicIDList = var_36_1
	elseif arg_36_1.type == AppreciatePicConst.TYPE_MANGA then
		local var_36_2 = self.loadingPicProxy:getMangaPicIDList()

		table.insert(var_36_2, arg_36_1.id)

		var_36_0.mangaPicIDList = var_36_2
	end

	pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, var_36_0)

	return
end

function AppreciatePicViewLayer:isPicInfoLiked(arg_37_1)
	return AppreciatePicConst.isPicInfoLiked(arg_37_1)
end

function AppreciatePicViewLayer:addLike(arg_38_1)
	local var_38_0 = {}

	if arg_38_1.type == AppreciatePicConst.TYPE_GALLERY then
		var_38_0.picID = arg_38_1.id
		var_38_0.isAdd = 0

		pg.m02:sendNotification(GAME.APPRECIATE_GALLERY_LIKE, var_38_0)
	elseif arg_38_1.type == AppreciatePicConst.TYPE_MANGA then
		var_38_0.mangaID = arg_38_1.id
		var_38_0.action = 0

		pg.m02:sendNotification(GAME.APPRECIATE_MANGA_LIKE, var_38_0)
	end

	return
end

function AppreciatePicViewLayer:removeLike(arg_39_1)
	local var_39_0 = {}

	if arg_39_1.type == AppreciatePicConst.TYPE_GALLERY then
		var_39_0.picID = arg_39_1.id
		var_39_0.isAdd = 1

		pg.m02:sendNotification(GAME.APPRECIATE_GALLERY_LIKE, var_39_0)
	elseif arg_39_1.type == AppreciatePicConst.TYPE_MANGA then
		var_39_0.mangaID = arg_39_1.id
		var_39_0.action = 1

		pg.m02:sendNotification(GAME.APPRECIATE_MANGA_LIKE, var_39_0)
	end

	return
end

function AppreciatePicViewLayer:addOpenList()
	if self.curPicInfo.type == AppreciatePicConst.TYPE_GALLERY then
		getProxy(LoadingPicProxy):addGalleryNewPicOpenList(self.curPicInfo.id)
	elseif self.curPicInfo.type == AppreciatePicConst.TYPE_MANGA then
		getProxy(LoadingPicProxy):addMangaNewPicOpenList(self.curPicInfo.id)
	end

	return
end

function AppreciatePicViewLayer:getPicInfoIndex(arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(self.picInfoList) do
		if iter_41_1.id == arg_41_1.id and iter_41_1.type == arg_41_1.type then
			return iter_41_0
		end
	end

	return nil
end

return AppreciatePicViewLayer
