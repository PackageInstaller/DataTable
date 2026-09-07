local GalleryGridView = class("GalleryGridView")

function GalleryGridView:Ctor(arg_1_1, arg_1_2)
	self.owner = arg_1_2
	self.gridPanel = arg_1_1
	self.rootTF = arg_1_1.parent
	self.isDisposed = false

	self:initUIRefs()
	self:initData()
	self:initScrollCallbacks()

	return
end

function GalleryGridView:initUIRefs()
	self.scrollListContainer = self.gridPanel:Find("Content")
	self.scrollRect = GetComponent(self.scrollListContainer, "LScrollRect")

	self.scrollRect:BeginLayout()
	self.scrollRect:EndLayout()

	self.cardTpl = self.gridPanel:Find("Card")

	return
end

function GalleryGridView:initData()
	self.resLoader = AutoLoader.New()
	self.cardTFList = {}

	return
end

function GalleryGridView:dispose()
	self.isDisposed = true

	self.resLoader:Clear()

	return
end

function GalleryGridView:isDestroyed()
	return self.isDisposed or not self.owner or self.owner.exited
end

function GalleryGridView:initScrollCallbacks()
	function self.scrollRect.onInitItem(arg_7_0)
		self:onInitItem(arg_7_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_8_0, arg_8_1)
		self:onUpdateItem(arg_8_0, arg_8_1)

		return
	end

	function self.scrollRect.onReturnItem(arg_9_0, arg_9_1)
		self:onReturnItem(arg_9_0, arg_9_1)

		return
	end

	return
end

function GalleryGridView:onInitItem(arg_10_1)
	setActive(tf(arg_10_1), true)

	return
end

function GalleryGridView:onUpdateItem(arg_11_1, arg_11_2)
	local var_11_0 = tf(arg_11_2)

	self.cardTFList[arg_11_1 + 1] = var_11_0

	if self:getPicInfoForShowByIndex(arg_11_1 + 1) == false then
		self:updateEmptyCard(var_11_0)
	else
		self:updateCard(arg_11_1 + 1, var_11_0)
	end

	return
end

function GalleryGridView:onReturnItem(arg_12_1, arg_12_2)
	self.cardTFList[arg_12_1 + 1] = nil

	return
end

function GalleryGridView:refresh(arg_13_1)
	if self:isDestroyed() then
		return
	end

	arg_13_1 = arg_13_1 or {}
	self.cardTFList = {}

	self.resLoader:Clear()
	self.scrollRect:SetTotalCount(#arg_13_1, -1)

	return
end

function GalleryGridView:openPicViewLayer(arg_14_1)
	local var_14_0 = self:getPicInfoForShowByIndex(arg_14_1)

	if not var_14_0 then
		return
	end

	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = AppreciatePicViewMediator,
		viewComponent = AppreciatePicViewLayer,
		data = {
			isShowLikeBtn = true,
			curPicInfo = var_14_0,
			picInfoList = self:getPicInfoListForShow()
		},
		onRemoved = function()
			if not self:isDestroyed() then
				self:refreshVisibleCards()
			end

			return
		end
	}))

	return
end

function GalleryGridView:updateCard(arg_16_1, arg_16_2)
	local var_16_0 = self:getPicInfoForShowByIndex(arg_16_1)

	setActive(arg_16_2, true)

	local var_16_1 = arg_16_2:Find("Update")

	setActive(var_16_1, false)
	setActive(var_16_1:Find("Progress"), false)

	local var_16_2 = arg_16_2:Find("NumText")

	self:updateCardImg(var_16_0, (arg_16_2:Find("Image")))
	setActive(var_16_2, true)
	setText(var_16_2, string.format("%d", arg_16_1))
	setActive(arg_16_2:Find("NewTag"), self:isPicNew(var_16_0))
	onButton(self.owner, arg_16_2, function()
		self:openPicViewLayer(arg_16_1)

		return
	end, SFX_PANEL)

	return
end

function GalleryGridView:updateCardImg(arg_18_1, arg_18_2)
	local var_18_0 = self:getPreviewPicPath(arg_18_1)
	local var_18_1 = GetFileName(var_18_0)
	local var_18_2 = GetComponent(arg_18_2, typeof(Image)).sprite

	if not IsNil(var_18_2) then
		if string.lower(var_18_2.name) ~= string.lower(var_18_1) then
			self.resLoader:LoadSprite(var_18_0, var_18_1, arg_18_2, false)
		end
	else
		self.resLoader:LoadSprite(var_18_0, var_18_1, arg_18_2, false)
	end

	return
end

function GalleryGridView:updateEmptyCard(arg_19_1)
	setActive(arg_19_1, true)

	local var_19_0

	for iter_19_0, iter_19_1 in ipairs(self.owner.picInfoListForShow) do
		if iter_19_1 then
			var_19_0 = iter_19_1

			break
		end
	end

	if not var_19_0 then
		return
	end

	self:updateCardImg(var_19_0, (arg_19_1:Find("Image")))
	setActive(arg_19_1:Find("NumText"), false)
	setActive(arg_19_1:Find("NewTag"), false)
	self:updateEmptyCardDownloadState(arg_19_1)

	return
end

function GalleryGridView:updateEmptyCardDownloadState(arg_20_1)
	local var_20_0 = arg_20_1:Find("Update")
	local var_20_1 = var_20_0:Find("Btn")
	local var_20_2 = var_20_1:Find("Text")
	local var_20_3 = var_20_0:Find("Progress")
	local var_20_4 = var_20_3:Find("Slider")
	local var_20_5 = self.owner:isGalleryDownloading()
	local var_20_6, var_20_7 = self.owner:getGalleryDownloadProgress()

	setActive(var_20_0, true)
	setActive(var_20_1, not var_20_5)
	setActive(var_20_3, var_20_5)

	if var_20_5 then
		setText(var_20_2, i18n("word_manga_updating", var_20_6, var_20_7))
		setSlider(var_20_4, 0, math.max(var_20_7, 1), var_20_6)
	elseif self.owner:isGalleryDownloadFailed() then
		setText(var_20_2, i18n("word_manga_updatefailure"))
		setSlider(var_20_4, 0, 1, 0)
	else
		setText(var_20_2, i18n("word_manga_checktoupdate"))
		setSlider(var_20_4, 0, 1, 0)
	end

	onButton(self.owner, var_20_1, function()
		self.owner:showDownloadMsgBox()

		return
	end, SFX_PANEL)

	return
end

function GalleryGridView:updateEmptyCardDownloadStateList()
	if self:isDestroyed() then
		return
	end

	for iter_22_0, iter_22_1 in pairs(self.cardTFList) do
		if iter_22_1 and self:getPicInfoForShowByIndex(iter_22_0) == false then
			self:updateEmptyCardDownloadState(iter_22_1)

			break
		end
	end

	return
end

function GalleryGridView:refreshVisibleCards()
	if self:isDestroyed() then
		return
	end

	for iter_23_0, iter_23_1 in pairs(self.cardTFList) do
		if iter_23_1 and self:getPicInfoForShowByIndex(iter_23_0) then
			self:updateCard(iter_23_0, iter_23_1)
		end
	end

	return
end

function GalleryGridView:getPreviewPicPath(arg_24_1)
	return GalleryConst.GetGalleryPicPathByID(arg_24_1.id)
end

function GalleryGridView:isPicNew(arg_25_1)
	return AppreciatePicConst.isNewPicInfo(arg_25_1)
end

function GalleryGridView:getPicInfoListForShow()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(self.owner.picInfoListForShow) do
		if iter_26_1 then
			table.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0
end

function GalleryGridView:getPicInfoForShowByIndex(arg_27_1)
	return self.owner:getPicInfoForShowByIndex(arg_27_1)
end

return GalleryGridView
