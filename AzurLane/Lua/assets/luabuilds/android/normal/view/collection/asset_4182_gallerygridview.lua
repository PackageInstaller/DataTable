class = var_0_10000

local var_0_0 = var_0_10000("GalleryGridView")

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
	local var_2_0 = arg_2_0.gridPanel

	arg_2_0.scrollListContainer = var_1.Find(var_2_0, "Content")
	GetComponent = var_1
	arg_2_0.scrollRect = var_1(arg_2_0.scrollListContainer, "LScrollRect")

	local var_2_1 = arg_2_0.scrollRect

	var_1.BeginLayout(var_2_1)

	local var_2_2 = arg_2_0.scrollRect

	var_1.EndLayout(var_2_2)

	local var_2_3 = arg_2_0.gridPanel

	arg_2_0.cardTpl = var_1.Find(var_2_3, "Card")

	return
end

function var_0_0.initData(arg_3_0)
	AutoLoader = var_1_10001
	arg_3_0.resLoader = var_1_10001.New()
	arg_3_0.cardTFList = {}

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
	function arg_6_0.scrollRect.onInitItem(arg_7_0)
		local var_7_0 = arg_6_0

		var_1.onInitItem(var_7_0, arg_7_0)

		return
	end

	function arg_6_0.scrollRect.onUpdateItem(arg_8_0, arg_8_1)
		local var_8_0 = arg_6_0

		var_2.onUpdateItem(var_8_0, arg_8_0, arg_8_1)

		return
	end

	function arg_6_0.scrollRect.onReturnItem(arg_9_0, arg_9_1)
		local var_9_0 = arg_6_0

		var_2.onReturnItem(var_9_0, arg_9_0, arg_9_1)

		return
	end

	return
end

function var_0_0.onInitItem(arg_10_0, arg_10_1)
	tf = var_1_10002

	local var_10_0 = var_1_10002(arg_10_1)

	setActive = var_3

	var_3(var_10_0, true)

	return
end

function var_0_0.onUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1 + 1

	tf = var_1_10004

	local var_11_1 = var_1_10004(arg_11_2)

	arg_11_0.cardTFList[var_11_0] = var_11_1

	if arg_11_0:getPicInfoForShowByIndex(var_11_0) == false then
		arg_11_0:updateEmptyCard(var_11_1)
	else
		arg_11_0:updateCard(var_11_0, var_11_1)
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

	local var_13_0 = arg_13_0.resLoader

	var_2.Clear(var_13_0)

	local var_13_1 = arg_13_0.scrollRect

	var_2.SetTotalCount(var_13_1, #arg_13_1, -1)

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
		picInfoList = arg_14_0:getPicInfoListForShow()
	}

	function var_14_3.onRemoved()
		local var_15_0 = arg_14_0

		if not var_0.isDestroyed(var_15_0) then
			local var_15_1 = arg_14_0

			var_0.refreshVisibleCards(var_15_1)
		end

		return
	end

	var_14_1(var_14_2(var_14_3))

	return
end

function var_0_0.updateCard(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.getPicInfoForShowByIndex(var_16_0, arg_16_1)

	setActive = var_16_0

	var_16_0(arg_16_2, true)

	local var_16_2 = arg_16_2:Find("Update")
	local var_16_3 = var_4.Find(var_16_2, "Progress")

	setActive = var_16_2

	var_16_2(var_4, false)

	setActive = var_16_2

	var_16_2(var_16_3, false)

	local var_16_4 = arg_16_2:Find("Image")
	local var_16_5 = arg_16_2:Find("NumText")
	local var_16_6 = arg_16_2:Find("NewTag")

	arg_16_0:updateCardImg(var_16_1, var_16_4)

	setActive = var_9

	var_9(var_16_5, true)

	setText = var_9

	local var_16_7 = var_16_5

	string = var_11

	var_9(var_16_7, var_11.format("%d", arg_16_1))

	setActive = var_9

	var_9(var_16_6, arg_16_0:isPicNew(var_16_1))

	onButton = var_9

	local var_16_8 = arg_16_0.owner
	local var_16_9 = arg_16_2

	local function var_16_10()
		local var_17_0 = arg_16_0

		var_0.openPicViewLayer(var_17_0, arg_16_1)

		return
	end

	SFX_PANEL = var_13

	var_9(var_16_8, var_16_9, var_16_10, var_13)

	return
end

function var_0_0.updateCardImg(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.getPreviewPicPath(var_18_0, arg_18_1)

	GetFileName = var_18_0

	local var_18_2 = var_18_0(var_18_1)

	GetComponent = var_5

	local var_18_3 = arg_18_2

	typeof = var_1_10007
	Image = var_1_10008

	local var_18_4 = var_5(var_18_3, var_1_10007(var_1_10008)).sprite

	IsNil = var_18_3

	if not var_18_3(var_18_4) then
		local var_18_5 = var_18_4.name

		string = var_7

		local var_18_6 = var_7.lower(var_18_5)

		string = var_8

		if var_18_6 ~= var_8.lower(var_18_2) then
			local var_18_7 = arg_18_0.resLoader

			var_7.LoadSprite(var_18_7, var_18_1, var_18_2, arg_18_2, false)
		end
	else
		local var_18_8 = arg_18_0.resLoader

		var_6.LoadSprite(var_18_8, var_18_1, var_18_2, arg_18_2, false)
	end

	return
end

function var_0_0.updateEmptyCard(arg_19_0, arg_19_1)
	setActive = var_1_10002

	var_1_10002(arg_19_1, true)

	local var_19_0

	ipairs = var_3

	for iter_19_0, iter_19_1 in var_3(arg_19_0.owner.picInfoListForShow) do
		if iter_19_1 then
			var_19_0 = iter_19_1

			break
		end
	end

	if not var_19_0 then
		return
	end

	local var_19_1 = arg_19_1:Find("Image")
	local var_19_2 = arg_19_1:Find("NumText")
	local var_19_3 = arg_19_1:Find("NewTag")

	arg_19_0:updateCardImg(var_19_0, var_19_1)

	setActive = var_6

	var_6(var_19_2, false)

	setActive = var_6

	var_6(var_19_3, false)
	arg_19_0:updateEmptyCardDownloadState(arg_19_1)

	return
end

function var_0_0.updateEmptyCardDownloadState(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1:Find("Update")
	local var_20_1 = var_2.Find(var_20_0, "Btn")
	local var_20_2 = var_3.Find(var_20_1, "Text")
	local var_20_3 = var_2:Find("Progress")
	local var_20_4 = var_5.Find(var_20_3, "Slider")
	local var_20_5 = arg_20_0.owner
	local var_20_6 = var_7.isGalleryDownloading(var_20_5)
	local var_20_7 = arg_20_0.owner
	local var_20_8, var_20_9 = var_8.getGalleryDownloadProgress(var_20_7)

	setActive = var_1_10010

	var_1_10010(var_2, true)

	setActive = var_1_10010

	var_1_10010(var_3, not var_20_6)

	setActive = var_1_10010

	var_1_10010(var_5, var_20_6)

	local var_20_12

	if var_20_6 then
		setText = var_1_10010

		local var_20_10 = var_20_2

		i18n = var_20_12

		var_1_10010(var_20_10, var_20_12("word_manga_updating", var_20_8, var_20_9))

		setSlider = var_1_10010

		local var_20_11 = var_20_4

		var_20_12 = 0
		math = var_13

		var_1_10010(var_20_11, var_20_12, var_13.max(var_20_9, 1), var_20_8)
	else
		local var_20_13 = arg_20_0.owner

		if var_1_10010.isGalleryDownloadFailed(var_20_13) then
			setText = var_1_10010

			local var_20_14 = var_20_2

			i18n = var_20_12

			var_1_10010(var_20_14, var_20_12("word_manga_updatefailure"))

			setSlider = var_1_10010

			var_1_10010(var_20_4, 0, 1, 0)
		else
			setText = var_1_10010

			local var_20_15 = var_20_2

			i18n = var_20_12

			var_1_10010(var_20_15, var_20_12("word_manga_checktoupdate"))

			setSlider = var_1_10010

			var_1_10010(var_20_4, 0, 1, 0)
		end
	end

	onButton = var_1_10010

	local var_20_16 = arg_20_0.owner
	local var_20_17 = var_3

	local function var_20_18()
		local var_21_0 = arg_20_0.owner

		var_0.showDownloadMsgBox(var_21_0)

		return
	end

	SFX_PANEL = var_1_10014

	var_1_10010(var_20_16, var_20_17, var_20_18, var_1_10014)

	return
end

function var_0_0.updateEmptyCardDownloadStateList(arg_22_0)
	if arg_22_0:isDestroyed() then
		return
	end

	pairs = var_1

	for iter_22_0, iter_22_1 in var_1(arg_22_0.cardTFList) do
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

	pairs = var_1

	for iter_23_0, iter_23_1 in var_1(arg_23_0.cardTFList) do
		local var_23_0 = arg_23_0:getPicInfoForShowByIndex(iter_23_0)

		if iter_23_1 and var_23_0 then
			arg_23_0:updateCard(iter_23_0, iter_23_1)
		end
	end

	return
end

function var_0_0.getPreviewPicPath(arg_24_0, arg_24_1)
	GalleryConst = var_1_10002

	return var_1_10002.GetGalleryPicPathByID(arg_24_1.id)
end

function var_0_0.isPicNew(arg_25_0, arg_25_1)
	AppreciatePicConst = var_1_10002

	return var_1_10002.isNewPicInfo(arg_25_1)
end

function var_0_0.getPicInfoListForShow(arg_26_0)
	local var_26_0 = {}

	ipairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0.owner.picInfoListForShow) do
		if iter_26_1 then
			table = var_1_10007

			var_1_10007.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0
end

function var_0_0.getPicInfoForShowByIndex(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.owner

	return var_2.getPicInfoForShowByIndex(var_27_0, arg_27_1)
end

return var_0_0
