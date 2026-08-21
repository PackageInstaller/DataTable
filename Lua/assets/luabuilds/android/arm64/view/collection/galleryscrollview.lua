local var_0_0 = class("GalleryScrollView")

var_0_0.GalleryPicGroupName = "GALLERY_PIC"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.owner = arg_1_2
	arg_1_0.scrollPanel = arg_1_1
	arg_1_0.rootTF = arg_1_1.parent
	arg_1_0.isDisposed = false

	arg_1_0:initUIRefs()
	arg_1_0:initData()
	arg_1_0:initScrollCallbacks()

	return
end

function var_0_0.initUIRefs(arg_2_0)
	arg_2_0.progressText = arg_2_0.scrollPanel:Find("TextProgress")
	arg_2_0.lScrollPageSC = GetComponent(arg_2_0.scrollPanel, "LScrollPage")
	arg_2_0.scrollListContainer = arg_2_0.scrollPanel:Find("Content")

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.resLoader = AutoLoader.New()
	arg_3_0.cardTFList = {}
	arg_3_0.curMiddleDataIndex = 1

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
	function arg_6_0.lScrollPageSC.itemInitedCallback(arg_7_0, arg_7_1)
		arg_6_0.cardTFList[arg_7_0 + 1] = arg_7_1

		if arg_6_0:getPicInfoForShowByIndex(arg_7_0 + 1) == false then
			arg_6_0:updateEmptyCard(arg_7_1)
		else
			arg_6_0:updateCard(arg_7_0, arg_7_1)
		end

		return
	end

	function arg_6_0.lScrollPageSC.itemClickCallback(arg_8_0, arg_8_1)
		if arg_6_0:getPicInfoForShowByIndex(arg_8_0 + 1) then
			arg_6_0:openPicViewLayer(arg_8_0 + 1)
		end

		return
	end

	function arg_6_0.lScrollPageSC.itemPitchCallback(arg_9_0, arg_9_1)
		if arg_6_0.curMiddleDataIndex ~= arg_9_0 + 1 then
			arg_6_0.curMiddleDataIndex = arg_9_0 + 1
		end

		return
	end

	function arg_6_0.lScrollPageSC.itemRecycleCallback(arg_10_0, arg_10_1)
		arg_6_0.cardTFList[arg_10_0 + 1] = nil

		return
	end

	function arg_6_0.lScrollPageSC.itemMoveCallback(arg_11_0)
		if #arg_6_0.owner.picInfoListForShow == 1 then
			arg_6_0:updateProgressText(1, 1)
		else
			arg_6_0:updateProgressText(math.clamp(math.round(arg_11_0 * (#arg_6_0.owner.picInfoListForShow - 1)) + 1, 1, #arg_6_0.owner.picInfoListForShow), #arg_6_0.owner.picInfoListForShow)
		end

		return
	end

	return
end

function var_0_0.refresh(arg_12_0, arg_12_1)
	if arg_12_0:isDestroyed() then
		return
	end

	arg_12_1 = arg_12_1 or {}
	arg_12_0.cardTFList = {}

	arg_12_0.resLoader:Clear()
	setActive(arg_12_0.progressText, true)

	arg_12_0.curMiddleDataIndex = math.clamp(arg_12_0.curMiddleDataIndex, 1, #arg_12_1)
	arg_12_0.lScrollPageSC.DataCount = #arg_12_1

	arg_12_0.lScrollPageSC:Init(arg_12_0.curMiddleDataIndex - 1)

	return
end

function var_0_0.resetMiddleDataIndex(arg_13_0)
	arg_13_0.curMiddleDataIndex = 1

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
			picInfoList = arg_14_0:getPicInfoListForShow(),
			onPicSwitch = function(arg_15_0)
				arg_14_0:moveToPicInfo(arg_15_0)

				return
			end
		},
		onRemoved = function()
			if arg_14_0:isDestroyed() then
				return
			end

			for iter_16_0, iter_16_1 in pairs(arg_14_0.cardTFList) do
				if iter_16_1 then
					arg_14_0:updateCardUsedTag(arg_14_0:getPicInfoForShowByIndex(iter_16_0), iter_16_1)
				end
			end

			return
		end
	}))

	return
end

function var_0_0.moveToPicInfo(arg_17_0, arg_17_1)
	if arg_17_0:isDestroyed() or not arg_17_1 then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.owner.picInfoListForShow) do
		if iter_17_1 and iter_17_1.id == arg_17_1.id and iter_17_1.type == arg_17_1.type then
			arg_17_0.curMiddleDataIndex = iter_17_0

			arg_17_0.lScrollPageSC:MoveToItemID(iter_17_0 - 1)

			return
		end
	end

	return
end

function var_0_0.updateProgressText(arg_18_0, arg_18_1, arg_18_2)
	setText(arg_18_0.progressText, arg_18_1 .. "/" .. arg_18_2)

	return
end

function var_0_0.updateCard(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:getPicInfoForShowByIndex(arg_19_1 + 1)

	setActive(arg_19_2:Find("SelectBtn"), false)
	setActive(arg_19_2:Find("BlackMask"), false)

	local var_19_1 = arg_19_2:Find("CardNum")

	setActive(var_19_1, true)
	setText(var_19_1:Find("Text"), "#" .. arg_19_1 + 1)
	arg_19_0:updateCardImg(var_19_0, arg_19_2)
	arg_19_0:updateCardUsedTag(var_19_0, arg_19_2)

	return
end

function var_0_0.updateCardImg(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2:Find("CardImg")
	local var_20_1 = arg_20_0:getPreviewPicPath(arg_20_1)

	setActive(var_20_0, true)
	arg_20_0.resLoader:LoadSprite(var_20_1, GetFileName(var_20_1), var_20_0, false)

	return
end

function var_0_0.updateCardUsedTag(arg_21_0, arg_21_1, arg_21_2)
	setActive(arg_21_2:Find("UsedTag"), arg_21_0:isPicUsed(arg_21_1))

	return
end

function var_0_0.updateEmptyCard(arg_22_0, arg_22_1)
	local var_22_0

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.owner.picInfoListForShow) do
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
	arg_22_0:updateCardImg(var_22_0, arg_22_1)
	arg_22_0:updateEmptyCardDownloadState(arg_22_1)

	return
end

function var_0_0.updateEmptyCardDownloadState(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1:Find("BlackMask")

	setActive(var_23_0, true)

	local var_23_1 = var_23_0:Find("Update")
	local var_23_2 = var_23_1:Find("Btn")
	local var_23_3 = var_23_2:Find("Text")
	local var_23_4 = arg_23_0.owner:isGalleryDownloading()

	setActive(var_23_1, true)
	setActive(var_23_2, not var_23_4)
	setActive(var_23_1:Find("Progress"), var_23_4)

	if var_23_4 then
		local var_23_5, var_23_6 = arg_23_0.owner:getGalleryDownloadProgress()

		setText(var_23_3, i18n("word_manga_updating", var_23_5, var_23_6))
	elseif arg_23_0.owner:isGalleryDownloadFailed() then
		setText(var_23_3, i18n("word_manga_updatefailure"))
	else
		setText(var_23_3, i18n("word_manga_checktoupdate"))
	end

	onButton(arg_23_0.owner, var_23_2, function()
		arg_23_0.owner:showDownloadMsgBox()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateEmptyCardDownloadStateList(arg_25_0)
	if arg_25_0:isDestroyed() then
		return
	end

	for iter_25_0, iter_25_1 in pairs(arg_25_0.cardTFList) do
		if iter_25_1 and arg_25_0:getPicInfoForShowByIndex(iter_25_0) == false then
			arg_25_0:updateEmptyCardDownloadState(iter_25_1)

			break
		end
	end

	return
end

function var_0_0.getPreviewPicPath(arg_26_0, arg_26_1)
	return GalleryConst.GetGalleryPreviewPicPathByID(arg_26_1.id)
end

function var_0_0.isPicUsed(arg_27_0, arg_27_1)
	return AppreciatePicConst.isUsedPicInfo(arg_27_1)
end

function var_0_0.getPicInfoListForShow(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.owner.picInfoListForShow) do
		if iter_28_1 then
			table.insert({}, iter_28_1)
		end
	end

	return {}
end

function var_0_0.getPicInfoForShowByIndex(arg_29_0, arg_29_1)
	return arg_29_0.owner:getPicInfoForShowByIndex(arg_29_1)
end

return var_0_0
