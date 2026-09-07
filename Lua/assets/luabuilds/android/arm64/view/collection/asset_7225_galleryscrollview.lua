local GalleryScrollView = class("GalleryScrollView")

GalleryScrollView.GalleryPicGroupName = "GALLERY_PIC"

function GalleryScrollView:Ctor(arg_1_1, arg_1_2)
	self.owner = arg_1_2
	self.scrollPanel = arg_1_1
	self.rootTF = arg_1_1.parent
	self.isDisposed = false

	self:initUIRefs()
	self:initData()
	self:initScrollCallbacks()

	return
end

function GalleryScrollView:initUIRefs()
	self.progressText = self.scrollPanel:Find("TextProgress")
	self.lScrollPageSC = GetComponent(self.scrollPanel, "LScrollPage")
	self.scrollListContainer = self.scrollPanel:Find("Content")

	return
end

function GalleryScrollView:initData()
	self.resLoader = AutoLoader.New()
	self.cardTFList = {}
	self.curMiddleDataIndex = 1

	return
end

function GalleryScrollView:dispose()
	self.isDisposed = true

	self.resLoader:Clear()

	return
end

function GalleryScrollView:isDestroyed()
	return self.isDisposed or not self.owner or self.owner.exited
end

function GalleryScrollView:initScrollCallbacks()
	function self.lScrollPageSC.itemInitedCallback(arg_7_0, arg_7_1)
		self.cardTFList[arg_7_0 + 1] = arg_7_1

		if self:getPicInfoForShowByIndex(arg_7_0 + 1) == false then
			self:updateEmptyCard(arg_7_1)
		else
			self:updateCard(arg_7_0, arg_7_1)
		end

		return
	end

	function self.lScrollPageSC.itemClickCallback(arg_8_0, arg_8_1)
		if self:getPicInfoForShowByIndex(arg_8_0 + 1) then
			self:openPicViewLayer(arg_8_0 + 1)
		end

		return
	end

	function self.lScrollPageSC.itemPitchCallback(arg_9_0, arg_9_1)
		if self.curMiddleDataIndex ~= arg_9_0 + 1 then
			self.curMiddleDataIndex = arg_9_0 + 1
		end

		return
	end

	function self.lScrollPageSC.itemRecycleCallback(arg_10_0, arg_10_1)
		self.cardTFList[arg_10_0 + 1] = nil

		return
	end

	function self.lScrollPageSC.itemMoveCallback(arg_11_0)
		if #self.owner.picInfoListForShow == 1 then
			self:updateProgressText(1, 1)
		else
			self:updateProgressText(math.clamp(math.round(arg_11_0 * (#self.owner.picInfoListForShow - 1)) + 1, 1, #self.owner.picInfoListForShow), #self.owner.picInfoListForShow)
		end

		return
	end

	return
end

function GalleryScrollView:refresh(arg_12_1)
	if self:isDestroyed() then
		return
	end

	arg_12_1 = arg_12_1 or {}
	self.cardTFList = {}

	self.resLoader:Clear()
	setActive(self.progressText, true)

	self.curMiddleDataIndex = math.clamp(self.curMiddleDataIndex, 1, #arg_12_1)
	self.lScrollPageSC.DataCount = #arg_12_1

	self.lScrollPageSC:Init(self.curMiddleDataIndex - 1)

	return
end

function GalleryScrollView:resetMiddleDataIndex()
	self.curMiddleDataIndex = 1

	return
end

function GalleryScrollView:openPicViewLayer(arg_14_1)
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
			picInfoList = self:getPicInfoListForShow(),
			onPicSwitch = function(arg_15_0)
				self:moveToPicInfo(arg_15_0)

				return
			end
		},
		onRemoved = function()
			if self:isDestroyed() then
				return
			end

			for iter_16_0, iter_16_1 in pairs(self.cardTFList) do
				if iter_16_1 then
					self:updateCardUsedTag(self:getPicInfoForShowByIndex(iter_16_0), iter_16_1)
				end
			end

			return
		end
	}))

	return
end

function GalleryScrollView:moveToPicInfo(arg_17_1)
	if self:isDestroyed() or not arg_17_1 then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(self.owner.picInfoListForShow) do
		if iter_17_1 and iter_17_1.id == arg_17_1.id and iter_17_1.type == arg_17_1.type then
			self.curMiddleDataIndex = iter_17_0

			self.lScrollPageSC:MoveToItemID(iter_17_0 - 1)

			return
		end
	end

	return
end

function GalleryScrollView:updateProgressText(arg_18_1, arg_18_2)
	setText(self.progressText, arg_18_1 .. "/" .. arg_18_2)

	return
end

function GalleryScrollView:updateCard(arg_19_1, arg_19_2)
	local var_19_0 = self:getPicInfoForShowByIndex(arg_19_1 + 1)

	setActive(arg_19_2:Find("SelectBtn"), false)
	setActive(arg_19_2:Find("BlackMask"), false)

	local var_19_1 = arg_19_2:Find("CardNum")

	setActive(var_19_1, true)
	setText(var_19_1:Find("Text"), "#" .. arg_19_1 + 1)
	self:updateCardImg(var_19_0, arg_19_2)
	self:updateCardUsedTag(var_19_0, arg_19_2)

	return
end

function GalleryScrollView:updateCardImg(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2:Find("CardImg")
	local var_20_1 = self:getPreviewPicPath(arg_20_1)

	setActive(var_20_0, true)
	self.resLoader:LoadSprite(var_20_1, GetFileName(var_20_1), var_20_0, false)

	return
end

function GalleryScrollView:updateCardUsedTag(arg_21_1, arg_21_2)
	setActive(arg_21_2:Find("UsedTag"), self:isPicUsed(arg_21_1))

	return
end

function GalleryScrollView:updateEmptyCard(arg_22_1)
	local var_22_0

	for iter_22_0, iter_22_1 in ipairs(self.owner.picInfoListForShow) do
		if iter_22_1 then
			var_22_0 = iter_22_1

			break
		end
	end

	if not var_22_0 then
		return
	end

	setActive(arg_22_1:Find("SelectBtn"), false)
	setActive(arg_22_1:Find("BlackMask"), true)
	setActive(arg_22_1:Find("CardNum"), false)
	setActive(arg_22_1:Find("UsedTag"), false)
	self:updateCardImg(var_22_0, arg_22_1)
	self:updateEmptyCardDownloadState(arg_22_1)

	return
end

function GalleryScrollView:updateEmptyCardDownloadState(arg_23_1)
	local var_23_0 = arg_23_1:Find("BlackMask")

	setActive(var_23_0, true)

	local var_23_1 = var_23_0:Find("Update")
	local var_23_2 = var_23_1:Find("Btn")
	local var_23_3 = var_23_2:Find("Text")
	local var_23_4 = self.owner:isGalleryDownloading()

	setActive(var_23_1, true)
	setActive(var_23_2, not var_23_4)
	setActive(var_23_1:Find("Progress"), var_23_4)

	if var_23_4 then
		local var_23_5, var_23_6 = self.owner:getGalleryDownloadProgress()

		setText(var_23_3, i18n("word_manga_updating", var_23_5, var_23_6))
	elseif self.owner:isGalleryDownloadFailed() then
		setText(var_23_3, i18n("word_manga_updatefailure"))
	else
		setText(var_23_3, i18n("word_manga_checktoupdate"))
	end

	onButton(self.owner, var_23_2, function()
		self.owner:showDownloadMsgBox()

		return
	end, SFX_PANEL)

	return
end

function GalleryScrollView:updateEmptyCardDownloadStateList()
	if self:isDestroyed() then
		return
	end

	for iter_25_0, iter_25_1 in pairs(self.cardTFList) do
		if iter_25_1 and self:getPicInfoForShowByIndex(iter_25_0) == false then
			self:updateEmptyCardDownloadState(iter_25_1)

			break
		end
	end

	return
end

function GalleryScrollView:getPreviewPicPath(arg_26_1)
	return GalleryConst.GetGalleryPreviewPicPathByID(arg_26_1.id)
end

function GalleryScrollView:isPicUsed(arg_27_1)
	return AppreciatePicConst.isUsedPicInfo(arg_27_1)
end

function GalleryScrollView:getPicInfoListForShow()
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(self.owner.picInfoListForShow) do
		if iter_28_1 then
			table.insert(var_28_0, iter_28_1)
		end
	end

	return var_28_0
end

function GalleryScrollView:getPicInfoForShowByIndex(arg_29_1)
	return self.owner:getPicInfoForShowByIndex(arg_29_1)
end

return GalleryScrollView
