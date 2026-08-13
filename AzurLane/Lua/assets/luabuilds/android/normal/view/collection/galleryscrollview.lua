class = var_0_10000

local var_0_0 = var_0_10000("GalleryScrollView")

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
	local var_2_0 = arg_2_0.scrollPanel

	arg_2_0.progressText = var_1.Find(var_2_0, "TextProgress")
	GetComponent = var_1
	arg_2_0.lScrollPageSC = var_1(arg_2_0.scrollPanel, "LScrollPage")

	local var_2_1 = arg_2_0.scrollPanel

	arg_2_0.scrollListContainer = var_1.Find(var_2_1, "Content")

	return
end

function var_0_0.initData(arg_3_0)
	AutoLoader = var_1_10001
	arg_3_0.resLoader = var_1_10001.New()
	arg_3_0.cardTFList = {}
	arg_3_0.curMiddleDataIndex = 1

	return
end

function var_0_0.dispose(arg_4_0)
	arg_4_0.isDisposed = true

	local var_4_0 = arg_4_0.resLoader

	var_1.Clear(var_4_0)

	return
end

function var_0_0.isDestroyed(arg_5_0)
	local var_5_0

	if not arg_5_0.isDisposed then
		var_5_0 = not arg_5_0.owner or arg_5_0.owner.exited
	end

	return var_5_0
end

function var_0_0.initScrollCallbacks(arg_6_0)
	function arg_6_0.lScrollPageSC.itemInitedCallback(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0 + 1

		arg_6_0.cardTFList[var_7_0] = arg_7_1

		local var_7_1 = arg_6_0

		if var_3.getPicInfoForShowByIndex(var_7_1, var_7_0) == false then
			local var_7_2 = arg_6_0

			var_4.updateEmptyCard(var_7_2, arg_7_1)
		else
			local var_7_3 = arg_6_0

			var_4.updateCard(var_7_3, arg_7_0, arg_7_1)
		end

		return
	end

	function arg_6_0.lScrollPageSC.itemClickCallback(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0 + 1
		local var_8_1 = arg_6_0

		if var_3.getPicInfoForShowByIndex(var_8_1, var_8_0) then
			local var_8_2 = arg_6_0

			var_4.openPicViewLayer(var_8_2, var_8_0)
		end

		return
	end

	function arg_6_0.lScrollPageSC.itemPitchCallback(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0 + 1

		if arg_6_0.curMiddleDataIndex ~= var_9_0 then
			arg_6_0.curMiddleDataIndex = var_9_0
		end

		return
	end

	function arg_6_0.lScrollPageSC.itemRecycleCallback(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0 + 1

		arg_6_0.cardTFList[var_10_0] = nil

		return
	end

	function arg_6_0.lScrollPageSC.itemMoveCallback(arg_11_0)
		if #arg_6_0.owner.picInfoListForShow == 1 then
			local var_11_0 = arg_6_0

			var_2.updateProgressText(var_11_0, 1, 1)
		else
			local var_11_1 = arg_6_0
			local var_11_2 = var_2.updateProgressText

			math = var_2_10004

			local var_11_3 = var_2_10004.clamp

			math = var_2_10005

			var_11_2(var_11_1, var_11_3(var_2_10005.round(arg_11_0 * (#var_1 - 1)) + 1, 1, #var_1), #var_1)
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

	local var_12_0 = arg_12_0.resLoader

	var_2.Clear(var_12_0)

	setActive = var_2

	var_2(arg_12_0.progressText, true)

	math = var_2
	arg_12_0.curMiddleDataIndex = var_2.clamp(arg_12_0.curMiddleDataIndex, 1, #arg_12_1)
	arg_12_0.lScrollPageSC.DataCount = #arg_12_1

	local var_12_1 = arg_12_0.lScrollPageSC

	var_2.Init(var_12_1, arg_12_0.curMiddleDataIndex - 1)

	return
end

function var_0_0.resetMiddleDataIndex(arg_13_0)
	arg_13_0.curMiddleDataIndex = 1

	return
end

function var_0_0.openPicViewLayer(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0

	if not arg_14_0.getPicInfoForShowByIndex(var_14_0, arg_14_1) then
		return
	end

	LoadContextCommand = var_14_0

	local var_14_1 = var_14_0.LoadLayerOnTopContext

	Context = var_4

	local var_14_2 = var_4.New
	local var_14_3 = {}

	AppreciatePicViewMediator = var_1_10006
	var_14_3.mediator = var_1_10006
	AppreciatePicViewLayer = var_1_10006
	var_14_3.viewComponent = var_1_10006
	var_14_3.data = {
		isShowLikeBtn = true,
		curPicInfo = var_2,
		picInfoList = arg_14_0:getPicInfoListForShow(),
		onPicSwitch = function(arg_15_0)
			local var_15_0 = arg_14_0

			var_1.moveToPicInfo(var_15_0, arg_15_0)

			return
		end
	}

	function var_14_3.onRemoved()
		local var_16_0 = arg_14_0

		if var_0.isDestroyed(var_16_0) then
			return
		end

		pairs = var_0

		for iter_16_0, iter_16_1 in var_0(arg_14_0.cardTFList) do
			if iter_16_1 then
				local var_16_1 = arg_14_0
				local var_16_2 = var_5.getPicInfoForShowByIndex(var_16_1, iter_16_0)
				local var_16_3 = arg_14_0

				var_6.updateCardUsedTag(var_16_3, var_16_2, iter_16_1)
			end
		end

		return
	end

	var_14_1(var_14_2(var_14_3))

	return
end

function var_0_0.moveToPicInfo(arg_17_0, arg_17_1)
	if arg_17_0:isDestroyed() or not arg_17_1 then
		return
	end

	ipairs = var_2

	for iter_17_0, iter_17_1 in var_2(arg_17_0.owner.picInfoListForShow) do
		if iter_17_1 and iter_17_1.id == arg_17_1.id and iter_17_1.type == arg_17_1.type then
			arg_17_0.curMiddleDataIndex = iter_17_0

			local var_17_0 = arg_17_0.lScrollPageSC

			var_7.MoveToItemID(var_17_0, iter_17_0 - 1)

			return
		end
	end

	return
end

function var_0_0.updateProgressText(arg_18_0, arg_18_1, arg_18_2)
	setText = var_1_10003

	var_1_10003(arg_18_0.progressText, arg_18_1 .. "/" .. arg_18_2)

	return
end

function var_0_0.updateCard(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1 + 1
	local var_19_1 = arg_19_0:getPicInfoForShowByIndex(var_19_0)
	local var_19_2 = arg_19_2
	local var_19_3 = arg_19_2.Find(var_19_2, "SelectBtn")

	setActive = var_19_2

	var_19_2(var_19_3, false)

	local var_19_4 = arg_19_2
	local var_19_5 = arg_19_2.Find(var_19_4, "BlackMask")

	setActive = var_19_4

	var_19_4(var_19_5, false)

	local var_19_6 = arg_19_2:Find("CardNum")
	local var_19_7 = var_7.Find(var_19_6, "Text")

	setActive = var_19_6

	var_19_6(var_7, true)

	setText = var_19_6

	var_19_6(var_19_7, "#" .. var_19_0)
	arg_19_0:updateCardImg(var_19_1, arg_19_2)
	arg_19_0:updateCardUsedTag(var_19_1, arg_19_2)

	return
end

function var_0_0.updateCardImg(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2:Find("CardImg")
	local var_20_1 = arg_20_0
	local var_20_2 = arg_20_0.getPreviewPicPath(var_20_1, arg_20_1)

	GetFileName = var_20_1

	local var_20_3 = var_20_1(var_20_2)

	setActive = var_6

	var_6(var_20_0, true)

	local var_20_4 = arg_20_0.resLoader

	var_6.LoadSprite(var_20_4, var_20_2, var_20_3, var_20_0, false)

	return
end

function var_0_0.updateCardUsedTag(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_2
	local var_21_1 = arg_21_2.Find(var_21_0, "UsedTag")

	setActive = var_21_0

	var_21_0(var_21_1, arg_21_0:isPicUsed(arg_21_1))

	return
end

function var_0_0.updateEmptyCard(arg_22_0, arg_22_1)
	local var_22_0

	ipairs = var_1_10003

	for iter_22_0, iter_22_1 in var_1_10003(arg_22_0.owner.picInfoListForShow) do
		if iter_22_1 then
			var_22_0 = iter_22_1

			break
		end
	end

	if not var_22_0 then
		return
	end

	local var_22_1 = arg_22_1
	local var_22_2 = arg_22_1.Find(var_22_1, "SelectBtn")

	setActive = var_22_1

	var_22_1(var_22_2, false)

	local var_22_3 = arg_22_1
	local var_22_4 = arg_22_1.Find(var_22_3, "BlackMask")

	setActive = var_22_3

	var_22_3(var_22_4, true)

	local var_22_5 = arg_22_1
	local var_22_6 = arg_22_1.Find(var_22_5, "CardNum")

	setActive = var_22_5

	var_22_5(var_22_6, false)

	local var_22_7 = arg_22_1
	local var_22_8 = arg_22_1.Find(var_22_7, "UsedTag")

	setActive = var_22_7

	var_22_7(var_22_8, false)
	arg_22_0:updateCardImg(var_22_0, arg_22_1)
	arg_22_0:updateEmptyCardDownloadState(arg_22_1)

	return
end

function var_0_0.updateEmptyCardDownloadState(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1
	local var_23_1 = arg_23_1.Find(var_23_0, "BlackMask")

	setActive = var_23_0

	var_23_0(var_23_1, true)

	local var_23_2 = var_23_1:Find("Update")
	local var_23_3 = var_3.Find(var_23_2, "Btn")
	local var_23_4 = var_4.Find(var_23_3, "Text")
	local var_23_5 = var_3:Find("Progress")
	local var_23_6 = arg_23_0.owner
	local var_23_7 = var_7.isGalleryDownloading(var_23_6)

	setActive = var_23_6

	var_23_6(var_3, true)

	setActive = var_23_6

	var_23_6(var_4, not var_23_7)

	setActive = var_23_6

	var_23_6(var_23_5, var_23_7)

	if var_23_7 then
		local var_23_8 = arg_23_0.owner
		local var_23_9

		var_23_6, var_23_9 = var_23_6.getGalleryDownloadProgress(var_23_8)
		setText = var_10

		local var_23_10 = var_23_4

		i18n = var_1_10012

		var_10(var_23_10, var_1_10012("word_manga_updating", var_23_6, var_23_9))
	else
		local var_23_11 = arg_23_0.owner

		if var_23_6.isGalleryDownloadFailed(var_23_11) then
			setText = var_23_6

			local var_23_12 = var_23_4

			i18n = var_10

			var_23_6(var_23_12, var_10("word_manga_updatefailure"))
		else
			setText = var_23_6

			local var_23_13 = var_23_4

			i18n = var_10

			var_23_6(var_23_13, var_10("word_manga_checktoupdate"))
		end
	end

	onButton = var_23_6

	local var_23_14 = arg_23_0.owner
	local var_23_15 = var_4

	local function var_23_16()
		local var_24_0 = arg_23_0.owner

		var_0.showDownloadMsgBox(var_24_0)

		return
	end

	SFX_PANEL = var_1_10012

	var_23_6(var_23_14, var_23_15, var_23_16, var_1_10012)

	return
end

function var_0_0.updateEmptyCardDownloadStateList(arg_25_0)
	if arg_25_0:isDestroyed() then
		return
	end

	pairs = var_1

	for iter_25_0, iter_25_1 in var_1(arg_25_0.cardTFList) do
		if iter_25_1 and arg_25_0:getPicInfoForShowByIndex(iter_25_0) == false then
			arg_25_0:updateEmptyCardDownloadState(iter_25_1)

			break
		end
	end

	return
end

function var_0_0.getPreviewPicPath(arg_26_0, arg_26_1)
	GalleryConst = var_1_10002

	return var_1_10002.GetGalleryPreviewPicPathByID(arg_26_1.id)
end

function var_0_0.isPicUsed(arg_27_0, arg_27_1)
	AppreciatePicConst = var_1_10002

	return var_1_10002.isUsedPicInfo(arg_27_1)
end

function var_0_0.getPicInfoListForShow(arg_28_0)
	local var_28_0 = {}

	ipairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0.owner.picInfoListForShow) do
		if iter_28_1 then
			table = var_1_10007

			var_1_10007.insert(var_28_0, iter_28_1)
		end
	end

	return var_28_0
end

function var_0_0.getPicInfoForShowByIndex(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.owner

	return var_2.getPicInfoForShowByIndex(var_29_0, arg_29_1)
end

return var_0_0
