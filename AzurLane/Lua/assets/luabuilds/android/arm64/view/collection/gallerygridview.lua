local var_0_0 = class("GalleryGridView")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.owner = arg_1_2
	arg_1_0.gridPanel = arg_1_1
	arg_1_0.rootTF = arg_1_1.parent
	arg_1_0.isDisposed = false

	arg_1_0:initUIRefs()
	arg_1_0:initData()
	arg_1_0:initScrollCallbacks()

	return
end

function var_0_0.initUIRefs(arg_2_0)
	arg_2_0.scrollListContainer = arg_2_0.gridPanel:Find("Content")
	arg_2_0.scrollRect = GetComponent(arg_2_0.scrollListContainer, "LScrollRect")

	arg_2_0.scrollRect:BeginLayout()
	arg_2_0.scrollRect:EndLayout()

	arg_2_0.cardTpl = arg_2_0.gridPanel:Find("Card")

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.resLoader = AutoLoader.New()
	arg_3_0.cardTFList = {}

	return
end

function var_0_0.dispose(arg_4_0)
	arg_4_0.isDisposed = true

	arg_4_0.resLoader:Clear()

	return
end

function var_0_0.isDestroyed(arg_5_0)
	return arg_5_0.isDisposed or not arg_5_0.owner or arg_5_0.owner.exited
end

function var_0_0.initScrollCallbacks(arg_6_0)
	function arg_6_0.scrollRect.onInitItem(arg_7_0)
		arg_6_0:onInitItem(arg_7_0)

		return
	end

	function arg_6_0.scrollRect.onUpdateItem(arg_8_0, arg_8_1)
		arg_6_0:onUpdateItem(arg_8_0, arg_8_1)

		return
	end

	function arg_6_0.scrollRect.onReturnItem(arg_9_0, arg_9_1)
		arg_6_0:onReturnItem(arg_9_0, arg_9_1)

		return
	end

	return
end

function var_0_0.onInitItem(arg_10_0, arg_10_1)
	setActive(tf(arg_10_1), true)

	return
end

function var_0_0.onUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = tf(arg_11_2)

	arg_11_0.cardTFList[arg_11_1 + 1] = var_11_0

	if arg_11_0:getPicInfoForShowByIndex(arg_11_1 + 1) == false then
		arg_11_0:updateEmptyCard(var_11_0)
	else
		arg_11_0:updateCard(arg_11_1 + 1, var_11_0)
	end

	return
end

function var_0_0.onReturnItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.cardTFList[arg_12_1 + 1] = nil

	return
end

function var_0_0.refresh(arg_13_0, arg_13_1)
	if arg_13_0:isDestroyed() then
		return
	end

	arg_13_1 = arg_13_1 or {}
	arg_13_0.cardTFList = {}

	arg_13_0.resLoader:Clear()
	arg_13_0.scrollRect:SetTotalCount(#arg_13_1, -1)

	return
end

function var_0_0.openPicViewLayer(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getPicInfoForShowByIndex(arg_14_1)

	if not var_14_0 then
		return
	end

	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = AppreciatePicViewMediator,
		viewComponent = AppreciatePicViewLayer,
		data = {
			isShowLikeBtn = true,
			curPicInfo = var_14_0,
			picInfoList = arg_14_0:getPicInfoListForShow()
		},
		onRemoved = function()
			if not arg_14_0:isDestroyed() then
				arg_14_0:refreshVisibleCards()
			end

			return
		end
	}))

	return
end

function var_0_0.updateCard(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getPicInfoForShowByIndex(arg_16_1)

	setActive(arg_16_2, true)

	local var_16_1 = arg_16_2:Find("Update")

	setActive(var_16_1, false)
	setActive(var_16_1:Find("Progress"), false)

	local var_16_2 = arg_16_2:Find("NumText")

	arg_16_0:updateCardImg(var_16_0, (arg_16_2:Find("Image")))
	setActive(var_16_2, true)
	setText(var_16_2, string.format("%d", arg_16_1))
	setActive(arg_16_2:Find("NewTag"), arg_16_0:isPicNew(var_16_0))
	onButton(arg_16_0.owner, arg_16_2, function()
		arg_16_0:openPicViewLayer(arg_16_1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateCardImg(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0:getPreviewPicPath(arg_18_1)
	local var_18_1 = GetFileName(var_18_0)
	local var_18_2 = GetComponent(arg_18_2, typeof(Image)).sprite

	if not IsNil(var_18_2) then
		if string.lower(var_18_2.name) ~= string.lower(var_18_1) then
			arg_18_0.resLoader:LoadSprite(var_18_0, var_18_1, arg_18_2, false)
		end
	else
		arg_18_0.resLoader:LoadSprite(var_18_0, var_18_1, arg_18_2, false)
	end

	return
end

function var_0_0.updateEmptyCard(arg_19_0, arg_19_1)
	setActive(arg_19_1, true)

	local var_19_0

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.owner.picInfoListForShow) do
		if iter_19_1 then
			var_19_0 = iter_19_1

			break
		end
	end

	if not var_19_0 then
		return
	end

	arg_19_0:updateCardImg(var_19_0, (arg_19_1:Find("Image")))
	setActive(arg_19_1:Find("NumText"), false)
	setActive(arg_19_1:Find("NewTag"), false)
	arg_19_0:updateEmptyCardDownloadState(arg_19_1)

	return
end

function var_0_0.updateEmptyCardDownloadState(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1:Find("Update")
	local var_20_1 = var_20_0:Find("Btn")
	local var_20_2 = var_20_1:Find("Text")
	local var_20_3 = var_20_0:Find("Progress")
	local var_20_4 = var_20_3:Find("Slider")
	local var_20_5 = arg_20_0.owner:isGalleryDownloading()
	local var_20_6, var_20_7 = arg_20_0.owner:getGalleryDownloadProgress()

	setActive(var_20_0, true)
	setActive(var_20_1, not var_20_5)
	setActive(var_20_3, var_20_5)

	if var_20_5 then
		setText(var_20_2, i18n("word_manga_updating", var_20_6, var_20_7))
		setSlider(var_20_4, 0, math.max(var_20_7, 1), var_20_6)
	elseif arg_20_0.owner:isGalleryDownloadFailed() then
		setText(var_20_2, i18n("word_manga_updatefailure"))
		setSlider(var_20_4, 0, 1, 0)
	else
		setText(var_20_2, i18n("word_manga_checktoupdate"))
		setSlider(var_20_4, 0, 1, 0)
	end

	onButton(arg_20_0.owner, var_20_1, function()
		arg_20_0.owner:showDownloadMsgBox()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateEmptyCardDownloadStateList(arg_22_0)
	if arg_22_0:isDestroyed() then
		return
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0.cardTFList) do
		if iter_22_1 and arg_22_0:getPicInfoForShowByIndex(iter_22_0) == false then
			arg_22_0:updateEmptyCardDownloadState(iter_22_1)

			break
		end
	end

	return
end

function var_0_0.refreshVisibleCards(arg_23_0)
	if arg_23_0:isDestroyed() then
		return
	end

	for iter_23_0, iter_23_1 in pairs(arg_23_0.cardTFList) do
		local var_23_0 = arg_23_0:getPicInfoForShowByIndex(iter_23_0)

		if iter_23_1 and var_23_0 then
			arg_23_0:updateCard(iter_23_0, iter_23_1)
		end
	end

	return
end

function var_0_0.getPreviewPicPath(arg_24_0, arg_24_1)
	return GalleryConst.GetGalleryPicPathByID(arg_24_1.id)
end

function var_0_0.isPicNew(arg_25_0, arg_25_1)
	return AppreciatePicConst.isNewPicInfo(arg_25_1)
end

function var_0_0.getPicInfoListForShow(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0.owner.picInfoListForShow) do
		if iter_26_1 then
			table.insert({}, iter_26_1)
		end
	end

	return {}
end

function var_0_0.getPicInfoForShowByIndex(arg_27_0, arg_27_1)
	return arg_27_0.owner:getPicInfoForShowByIndex(arg_27_1)
end

return var_0_0
