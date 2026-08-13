class = var_0_10000

local var_0_0 = "GalleryView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

var_0_1.GalleryPicGroupName = "GALLERY_PIC"

function var_0_1.getUIName(arg_1_0)
	return "GalleryUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	GalleryScrollView = var_1
	arg_2_0.galleryScrollView = var_1.New(arg_2_0.scrollPanel, arg_2_0)
	GalleryGridView = var_1
	arg_2_0.galleryGridView = var_1.New(arg_2_0.gridPanel, arg_2_0)

	arg_2_0:Show()
	arg_2_0:refreshPicInfoList()
	arg_2_0:tryShowTipMsgBox()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	if arg_3_0.galleryScrollView then
		local var_3_0 = arg_3_0.galleryScrollView

		var_1.dispose(var_3_0)

		arg_3_0.galleryScrollView = nil
	end

	if arg_3_0.galleryGridView then
		local var_3_1 = arg_3_0.galleryGridView

		var_1.dispose(var_3_1)

		arg_3_0.galleryGridView = nil
	end

	return
end

function var_0_1.onBackPressed(arg_4_0)
	return true
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	AppreciateProxy = var_1_10002
	arg_5_0.appreciateProxy = var_1_10001(var_1_10002)

	local var_5_0 = arg_5_0.appreciateProxy

	var_1.checkPicFileState(var_5_0)

	arg_5_0.picInfoListForShow = {}
	arg_5_0.isDownloading = false
	arg_5_0.downloadCount = 0
	arg_5_0.downloadTotal = 0
	arg_5_0.downloadFailed = false
	arg_5_0.hasMissingGalleryPic = false
	arg_5_0.hasExistingGalleryPic = false
	arg_5_0.curViewMode = "scroll"
	GalleryConst = var_1
	arg_5_0.curPicLikeValue = var_1.Filte_Normal_Value
	GalleryConst = var_1
	arg_5_0.curPicSetValue = var_1.Filte_Set_Normal_Value
	GalleryConst = var_1
	arg_5_0.curPicSortValue = var_1.Sort_Order_Up

	return
end

function var_0_1.findUI(arg_6_0)
	setLocalPosition = var_1_10001

	local var_6_0 = arg_6_0._tf

	Vector2 = var_1_10003

	var_1_10001(var_6_0, var_1_10003.zero)

	local var_6_1 = arg_6_0._tf

	Vector2 = var_6_0
	var_6_1.anchorMin = var_6_0.zero

	local var_6_2 = arg_6_0._tf

	Vector2 = var_2
	var_6_2.anchorMax = var_2.one

	local var_6_3 = arg_6_0._tf

	Vector2 = var_2
	var_6_3.offsetMax = var_2.zero

	local var_6_4 = arg_6_0._tf

	Vector2 = var_2
	var_6_4.offsetMin = var_2.zero

	local var_6_5 = arg_6_0._tf

	arg_6_0.topPanel = var_1.Find(var_6_5, "TopPanel")

	local var_6_6 = arg_6_0.topPanel

	arg_6_0.setFilterToggle = var_1.Find(var_6_6, "List/SetFilterBtn")
	setText = var_1

	local var_6_7 = arg_6_0.setFilterToggle
	local var_6_8 = var_2.Find(var_6_7, "TextLikeOff")

	i18n = var_6_7

	var_1(var_6_8, var_6_7("loading_pic_btn"))

	setText = var_1

	local var_6_9 = arg_6_0.setFilterToggle
	local var_6_10 = var_2.Find(var_6_9, "TextLikeOn")

	i18n = var_6_9

	var_1(var_6_10, var_6_9("loading_pic_btn"))

	setActive = var_1

	var_1(arg_6_0.setFilterToggle, true)

	local var_6_11 = arg_6_0.topPanel
	local var_6_12 = var_1.Find(var_6_11, "List/TimeFilterBtn")

	setActive = var_6_11

	var_6_11(var_6_12, false)

	local var_6_13 = arg_6_0.topPanel

	arg_6_0.likeFilterToggle = var_2.Find(var_6_13, "List/LikeFilterBtn")
	setActive = var_2

	var_2(arg_6_0.likeFilterToggle, true)

	local var_6_14 = arg_6_0.likeFilterToggle

	arg_6_0.likeNumText = var_2.Find(var_6_14, "TextNum")
	setActive = var_2

	var_2(arg_6_0.likeNumText, false)

	local var_6_15 = arg_6_0.topPanel

	arg_6_0.orderToggle = var_2.Find(var_6_15, "List/OrderBtn")

	local var_6_16 = arg_6_0.topPanel

	arg_6_0.resRepaireBtn = var_2.Find(var_6_16, "List/RepaireBtn")

	local var_6_17 = arg_6_0.topPanel

	arg_6_0.switchToGridBtn = var_2.Find(var_6_17, "SwitchToGridBtn")

	local var_6_18 = arg_6_0.topPanel

	arg_6_0.switchToScrollBtn = var_2.Find(var_6_18, "SwitchToScrollBtn")

	local var_6_19 = arg_6_0._tf

	arg_6_0.scrollPanel = var_2.Find(var_6_19, "Scroll")

	local var_6_20 = arg_6_0._tf

	arg_6_0.gridPanel = var_2.Find(var_6_20, "Grid")

	local var_6_21 = arg_6_0._tf

	arg_6_0.emptyPanel = var_2.Find(var_6_21, "EmptyPanel")

	local var_6_22 = arg_6_0._tf

	arg_6_0.updatePanel = var_2.Find(var_6_22, "UpdatePanel")

	return
end

function var_0_1.addListener(arg_7_0)
	onToggle = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.orderToggle

	local function var_7_2(arg_8_0)
		if arg_8_0 == true then
			local var_8_0 = arg_7_0

			GalleryConst = var_2_10002
			var_8_0.curPicSortValue = var_2_10002.Sort_Order_Down
		else
			local var_8_1 = arg_7_0

			GalleryConst = var_2_10002
			var_8_1.curPicSortValue = var_2_10002.Sort_Order_Up
		end

		local var_8_2 = arg_7_0

		var_1.refreshPicInfoList(var_8_2, true)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onToggle = var_1_10001

	var_1_10001(arg_7_0, arg_7_0.likeFilterToggle, function(arg_9_0)
		if arg_9_0 == true then
			local var_9_0 = arg_7_0

			GalleryConst = var_2_10002
			var_9_0.curPicLikeValue = var_2_10002.Filte_Like_Value
		else
			local var_9_1 = arg_7_0

			GalleryConst = var_2_10002
			var_9_1.curPicLikeValue = var_2_10002.Filte_Normal_Value
		end

		local var_9_2 = arg_7_0

		var_1.refreshPicInfoList(var_9_2, true)

		return
	end)

	onToggle = var_1_10001

	var_1_10001(arg_7_0, arg_7_0.setFilterToggle, function(arg_10_0)
		if arg_10_0 == true then
			local var_10_0 = arg_7_0

			GalleryConst = var_2_10002
			var_10_0.curPicSetValue = var_2_10002.Filte_Set_Value
		else
			local var_10_1 = arg_7_0

			GalleryConst = var_2_10002
			var_10_1.curPicSetValue = var_2_10002.Filte_Set_Normal_Value
		end

		local var_10_2 = arg_7_0

		var_1.refreshPicInfoList(var_10_2, true)

		return
	end)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.resRepaireBtn

	local function var_7_5()
		local var_11_0 = {}

		i18n = var_2_10001
		var_11_0.text = var_2_10001("msgbox_repair")

		function var_11_0.onCallback()
			PathMgr = var_3_10000

			local var_12_0 = var_3_10000.FileExists

			Application = var_3_10001

			local var_12_2

			if var_12_0(var_3_10001.persistentDataPath .. "/hashes-pic.csv") then
				BundleWizard = var_0

				local var_12_1 = var_0.Inst

				var_12_2 = var_0.GetGroupMgr(var_12_1, var_0_1.GalleryPicGroupName)

				var_0.StartVerifyForLua(var_12_2)
			else
				pg = var_0

				local var_12_3 = var_0.TipsMgr.GetInstance()
				local var_12_4 = var_0.ShowTips

				i18n = var_12_2

				var_12_4(var_12_3, var_12_2("word_no_cache"))
			end

			return
		end

		pg = var_1

		local var_11_1 = var_1.MsgboxMgr.GetInstance()
		local var_11_2 = var_1.ShowMsgBox
		local var_11_3 = {
			hideYes = true
		}

		i18n = var_2_10004
		var_11_3.content = var_2_10004("resource_verify_warn")
		var_11_3.custom = {
			var_11_0
		}

		var_11_2(var_11_1, var_11_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.switchToGridBtn

	local function var_7_8()
		local var_13_0 = arg_7_0

		var_0.switchViewMode(var_13_0, "grid")

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10005)

	onButton = var_1_10001

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.switchToScrollBtn

	local function var_7_11()
		local var_14_0 = arg_7_0

		var_0.switchViewMode(var_14_0, "scroll")

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_9, var_7_10, var_7_11, var_1_10005)

	return
end

function var_0_1.refreshPicInfoList(arg_15_0)
	arg_15_0:filterPicInfoList()
	arg_15_0:updateViewDisplay()

	return
end

function var_0_1.switchViewMode(arg_16_0, arg_16_1)
	if arg_16_0.curViewMode == arg_16_1 then
		return
	end

	arg_16_0.curViewMode = arg_16_1

	arg_16_0:resetActiveViewState()
	arg_16_0:updateViewDisplay()

	return
end

function var_0_1.resetActiveViewState(arg_17_0)
	if arg_17_0.curViewMode == "scroll" and arg_17_0.galleryScrollView then
		local var_17_0 = arg_17_0.galleryScrollView

		var_1.resetMiddleDataIndex(var_17_0)
	end

	return
end

function var_0_1.updateViewDisplay(arg_18_0)
	local var_18_0

	if #arg_18_0.picInfoListForShow <= 0 then
		::label_18_0::

		if not arg_18_0.hasExistingGalleryPic then
			if arg_18_0.hasMissingGalleryPic then
				var_18_0 = arg_18_0:isNeedShowDownBtn()
			end
		else
			var_18_0 = false
		end

		if false then
			var_18_0 = true
		end
	end

	local var_18_1 = arg_18_0.curViewMode == "scroll"
	local var_18_2 = arg_18_0.curViewMode == "grid"

	setActive = var_1_10005

	var_1_10005(arg_18_0.emptyPanel, var_1 and not var_18_0)

	setActive = var_1_10005

	var_1_10005(arg_18_0.updatePanel, var_18_0)

	setActive = var_1_10005

	var_1_10005(arg_18_0.scrollPanel, not var_1 and not var_18_0 and var_18_1)

	setActive = var_1_10005

	var_1_10005(arg_18_0.gridPanel, not var_1 and not var_18_0 and var_18_2)

	setActive = var_1_10005

	var_1_10005(arg_18_0.switchToGridBtn, var_18_1)

	setActive = var_1_10005

	var_1_10005(arg_18_0.switchToScrollBtn, var_18_2)

	if var_18_0 then
		arg_18_0:initDownBtnPanel()
	elseif not var_1 then
		if var_18_2 then
			local var_18_3 = arg_18_0.galleryGridView

			var_5.refresh(var_18_3, arg_18_0.picInfoListForShow)
		else
			local var_18_4 = arg_18_0.galleryScrollView

			var_5.refresh(var_18_4, arg_18_0.picInfoListForShow)
		end
	end

	return
end

function var_0_1.initDownBtnPanel(arg_19_0)
	local var_19_0 = arg_19_0.updatePanel
	local var_19_1 = var_1.Find(var_19_0, "Btn")
	local var_19_2 = var_1.Find(var_19_1, "Text")
	local var_19_3 = arg_19_0.updatePanel
	local var_19_4 = var_3.Find(var_19_3, "Progress")

	setActive = var_19_3

	var_19_3(var_1, not arg_19_0.isDownloading)

	setActive = var_19_3

	var_19_3(var_19_4, arg_19_0.isDownloading)

	local var_19_6

	if arg_19_0.downloadFailed then
		setText = var_19_6

		local var_19_5 = var_19_2

		i18n = var_6

		var_19_6(var_19_5, var_6("word_manga_updatefailure"))
	elseif arg_19_0.isDownloading then
		local var_19_7

		var_19_6, var_19_7 = arg_19_0:getGalleryDownloadProgress()
		setText = var_6

		local var_19_8 = var_19_2

		i18n = var_1_10008

		var_6(var_19_8, var_1_10008("word_manga_updating", var_19_6, var_19_7))
	else
		setText = var_19_6

		local var_19_9 = var_19_2

		i18n = var_6

		var_19_6(var_19_9, var_6("word_manga_checktoupdate"))
	end

	onButton = var_19_6

	local var_19_10 = arg_19_0
	local var_19_11 = var_1

	local function var_19_12()
		local var_20_0 = arg_19_0

		var_0.showDownloadMsgBox(var_20_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_19_6(var_19_10, var_19_11, var_19_12, var_1_10008)

	return
end

function var_0_1.isGalleryDownloading(arg_21_0)
	return arg_21_0.isDownloading
end

function var_0_1.isGalleryDownloadFailed(arg_22_0)
	return arg_22_0.downloadFailed
end

function var_0_1.getGalleryDownloadProgress(arg_23_0)
	return arg_23_0.downloadCount, arg_23_0.downloadTotal
end

function var_0_1.refreshDownloadStateViews(arg_24_0)
	if arg_24_0.galleryScrollView then
		local var_24_0 = arg_24_0.galleryScrollView

		var_1.updateEmptyCardDownloadStateList(var_24_0)
	end

	if arg_24_0.galleryGridView then
		local var_24_1 = arg_24_0.galleryGridView

		var_1.updateEmptyCardDownloadStateList(var_24_1)
	end

	if arg_24_0.updatePanel then
		isActive = var_1

		if var_1(arg_24_0.updatePanel) then
			arg_24_0:initDownBtnPanel()
		end
	end

	return
end

function var_0_1.showDownloadMsgBox(arg_25_0)
	GroupHelper = var_1_10001

	local var_25_0 = var_1_10001.GetGroupSize(var_0_1.GalleryPicGroupName)

	HashUtil = var_2

	local var_25_1 = var_2.BytesToString(var_25_0)

	pg = var_3

	local var_25_2 = var_3.MsgboxMgr.GetInstance()
	local var_25_3 = var_3.ShowMsgBox
	local var_25_4 = {}

	MSGBOX_TYPE_NORMAL = var_1_10006
	var_25_4.type = var_1_10006
	string = var_1_10006

	local var_25_5 = var_1_10006.format

	i18n = var_1_10007
	var_25_4.content = var_25_5(var_1_10007("group_download_tip", var_25_1))

	function var_25_4.onYes()
		local var_26_0 = arg_25_0

		var_0.startDownloadGroup(var_26_0)

		return
	end

	var_25_3(var_25_2, var_25_4)

	return
end

function var_0_1.startDownloadGroup(arg_27_0)
	if arg_27_0.isDownloading or arg_27_0.exited then
		return
	end

	arg_27_0.isDownloading = true
	arg_27_0.downloadFailed = false
	arg_27_0.downloadCount = 0
	arg_27_0.downloadTotal = 0

	arg_27_0:refreshDownloadStateViews()

	local var_27_0 = {
		var_0_1.GalleryPicGroupName
	}

	table = var_2

	local var_27_1 = var_2.concat(var_27_0, "_")

	local function var_27_2(arg_28_0, arg_28_1, arg_28_2)
		local var_28_0 = arg_27_0

		var_3.onDownloadProgress(var_28_0, arg_28_0, arg_28_1, arg_28_2)

		return
	end

	local function var_27_3(arg_29_0, arg_29_1)
		local var_29_0 = arg_27_0

		var_2.onDownloadFinish(var_29_0, arg_29_0, arg_29_1)

		return
	end

	BundleWizardUpdater = var_1_10005

	local var_27_4 = var_1_10005.Inst
	local var_27_5 = var_5.GetFileList(var_27_4, var_27_0)

	BundleWizardUpdater = var_27_4

	local var_27_6 = var_27_4.Inst
	local var_27_7 = var_6.CreateListInfo(var_27_6, var_27_1, var_27_5, nil, var_27_3, var_27_2)

	BundleWizardUpdater = var_27_6

	local var_27_8 = var_27_6.Inst

	var_7.StartUpdate(var_27_8, var_27_7)

	return
end

function var_0_1.onDownloadProgress(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_0.exited then
		return
	end

	arg_30_0.downloadCount = (arg_30_1 or 0) + (arg_30_2 or 0)
	arg_30_0.downloadTotal = arg_30_3 or 0

	arg_30_0:refreshDownloadStateViews()

	return
end

function var_0_1.onDownloadFinish(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0.isDownloading = false
	arg_31_0.downloadFailed = not arg_31_1

	if arg_31_0.exited then
		return
	end

	if arg_31_1 then
		arg_31_0.downloadCount = arg_31_0.downloadTotal

		local var_31_0 = arg_31_0.appreciateProxy

		var_3.checkPicFileState(var_31_0)
		arg_31_0:refreshDownloadStateViews()
		arg_31_0:refreshPicInfoList()
	else
		arg_31_0:refreshDownloadStateViews()
		arg_31_0:showDownloadRetryMsgBox(arg_31_2)
	end

	return
end

function var_0_1.showDownloadRetryMsgBox(arg_32_0, arg_32_1)
	if arg_32_1 then
		warning = var_1_10002

		local var_32_0 = "gallery download failed:"

		tostring = var_1_10004

		var_1_10002(var_32_0, var_1_10004(arg_32_1))
	end

	local function var_32_1()
		if not arg_32_0.exited then
			arg_32_0.downloadFailed = false
			arg_32_0.downloadCount = 0
			arg_32_0.downloadTotal = 0

			local var_33_0 = arg_32_0

			var_0.refreshDownloadStateViews(var_33_0)
		end

		return
	end

	local function var_32_2()
		if not arg_32_0.exited then
			local var_34_0 = arg_32_0

			var_0.startDownloadGroup(var_34_0)
		end

		return
	end

	pg = var_1_10004

	local var_32_3 = var_1_10004.MsgboxMgr.GetInstance()
	local var_32_4 = var_4.ShowMsgBox
	local var_32_5 = {}

	MSGBOX_TYPE_NORMAL = var_1_10007
	var_32_5.type = var_1_10007
	i18n = var_1_10007

	local var_32_6 = "file_down_mgr_error"
	local var_32_7 = ""

	tostring = var_1_10010
	var_32_5.content = var_1_10007(var_32_6, var_32_7, var_1_10010(arg_32_1 or ""))
	var_32_5.onYes = var_32_2
	var_32_5.onNo = var_32_1
	var_32_5.onClose = var_32_1

	var_32_4(var_32_3, var_32_5)

	return
end

function var_0_1.tryShowTipMsgBox(arg_35_0)
	local var_35_0 = arg_35_0.appreciateProxy

	if var_1.isGalleryHaveNewRes(var_35_0) then
		local function var_35_1()
			PlayerPrefs = var_2_10000

			local var_36_0 = var_2_10000.SetInt
			local var_36_1 = "galleryVersion"

			GalleryConst = var_2_10002

			var_36_0(var_36_1, var_2_10002.Version)

			local var_36_2 = arg_35_0
			local var_36_3 = var_0.emit

			CollectionScene = var_2

			var_36_3(var_36_2, var_2.UPDATE_RED_POINT)

			return
		end

		pg = var_1_10003

		local var_35_2 = var_1_10003.MsgboxMgr.GetInstance()
		local var_35_3 = var_3.ShowMsgBox
		local var_35_4 = {
			hideNo = true,
			hideClose = true
		}

		i18n = var_1_10006

		local var_35_5 = "res_pic_new_tip"

		GalleryConst = var_1_10008
		var_35_4.content = var_1_10006(var_35_5, var_1_10008.NewCount)
		var_35_4.onYes = var_35_1
		var_35_4.onCancel = var_35_1
		var_35_4.onClose = var_35_1

		var_35_3(var_35_2, var_35_4)
	end

	return
end

function var_0_1.getPicInfoForShowByIndex(arg_37_0, arg_37_1)
	if arg_37_0.picInfoListForShow[arg_37_1] then
		return var_2
	elseif var_2 == false then
		return false
	else
		assert = var_1_10003

		local var_37_0 = false
		local var_37_1 = "不存在的Index:"

		tostring = var_1_10006

		var_1_10003(var_37_0, var_37_1 .. var_1_10006(arg_37_1))
	end

	return
end

function var_0_1.sortPicInfoListForShow(arg_38_0)
	local function var_38_0(arg_39_0, arg_39_1)
		local var_39_0 = arg_38_0.curPicSortValue

		GalleryConst = var_2_10003

		if var_39_0 == var_2_10003.Sort_Order_Up then
			return arg_39_0.id < arg_39_1.id
		else
			local var_39_1 = arg_38_0.curPicSortValue

			GalleryConst = var_3

			if var_39_1 == var_3.Sort_Order_Down then
				return arg_39_0.id >= arg_39_1.id
			end
		end

		return
	end

	table = var_1_10002

	var_1_10002.sort(arg_38_0.picInfoListForShow, var_38_0)

	return
end

function var_0_1.filterPicInfoForShow(arg_40_0)
	local var_40_0 = {}

	arg_40_0.hasMissingGalleryPic = false
	ipairs = var_2
	pg = var_1_10003

	for iter_40_0, iter_40_1 in var_2(var_1_10003.gallery_config.all) do
		local var_40_1 = arg_40_0.appreciateProxy

		if var_7.getPicExistStateByID(var_40_1, iter_40_1) then
			local var_40_2 = #var_40_0 + 1

			AppreciatePicConst = var_40_1

			local var_40_3 = var_40_1.createPicInfo

			AppreciatePicConst = var_9
			var_40_0[var_40_2] = var_40_3(var_9.TYPE_GALLERY, iter_40_1)
		else
			arg_40_0.hasMissingGalleryPic = true
		end
	end

	arg_40_0.hasExistingGalleryPic = #var_40_0 > 0

	return var_40_0
end

function var_0_1.filterPicInfoForShowByLike(arg_41_0)
	local var_41_0 = arg_41_0.curPicLikeValue

	GalleryConst = var_1_10002

	if var_41_0 == var_1_10002.Filte_Normal_Value then
		return arg_41_0.picInfoListForShow
	end

	local var_41_1 = {}

	ipairs = var_1_10003

	for iter_41_0, iter_41_1 in var_1_10003(arg_41_0.picInfoListForShow) do
		GalleryConst = var_1_10008

		if var_1_10008.isGalleryLikeByID(iter_41_1.id) then
			var_41_1[#var_41_1 + 1] = iter_41_1
		end
	end

	return var_41_1
end

function var_0_1.filterPicInfoForShowBySet(arg_42_0)
	local var_42_0 = arg_42_0.curPicSetValue

	GalleryConst = var_1_10002

	if var_42_0 == var_1_10002.Filte_Set_Normal_Value then
		return arg_42_0.picInfoListForShow
	end

	local var_42_1 = {}

	getProxy = var_1_10003
	LoadingPicProxy = var_1_10004

	local var_42_2 = var_1_10003(var_1_10004)
	local var_42_3 = var_3.getDiyModeOpenFlag(var_42_2)

	ipairs = var_42_2

	for iter_42_0, iter_42_1 in var_42_2(arg_42_0.picInfoListForShow) do
		local var_42_4

		if var_42_3 then
			AppreciatePicConst = var_1_10010
			var_42_4 = var_1_10010.isUsedPicInfo(iter_42_1)
		else
			var_42_4 = iter_42_1.id > 1000
		end

		if var_42_4 then
			var_42_1[#var_42_1 + 1] = iter_42_1
		end
	end

	return var_42_1
end

function var_0_1.filterPicInfoList(arg_43_0)
	arg_43_0.picInfoListForShow = arg_43_0:filterPicInfoForShow()
	arg_43_0.picInfoListForShow = arg_43_0:filterPicInfoForShowByLike(arg_43_0.curPicLikeValue)
	arg_43_0.picInfoListForShow = arg_43_0:filterPicInfoForShowBySet(arg_43_0.curPicSetValue)

	arg_43_0:sortPicInfoListForShow()

	if #arg_43_0.picInfoListForShow > 0 and arg_43_0.hasMissingGalleryPic and arg_43_0:isNeedShowDownBtn() then
		table = var_1

		var_1.insert(arg_43_0.picInfoListForShow, 1, false)
	end

	return
end

function var_0_1.isNeedShowDownBtn(arg_44_0)
	Application = var_1_10001

	if var_1_10001.isEditor then
		return false
	end

	GroupHelper = var_1

	if var_1.IsGroupVerLastest(var_0_1.GalleryPicGroupName) then
		return false
	end

	GroupHelper = var_1

	if not var_1.IsGroupWaitToUpdate(var_0_1.GalleryPicGroupName) then
		return false
	end

	return true
end

return var_0_1
