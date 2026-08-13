class = var_0_10000

local var_0_0 = "AttireLoadingPicPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

var_0_1.FilterMode = {
	Default = 2,
	All = 0,
	Selected = 1,
	Manga = 4,
	Gallery = 3
}

function var_0_1.getUIName(arg_1_0)
	return "attireloadingpicui"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initUIText()
	arg_2_0:autoSelectPanel()
	arg_2_0:enterEditMode(false)

	return
end

function var_0_1.Update(arg_3_0)
	return
end

function var_0_1.OnDestroy(arg_4_0)
	local var_4_0 = arg_4_0.resLoader

	var_1.Clear(var_4_0)

	return
end

function var_0_1.initData(arg_5_0)
	AutoLoader = var_1_10001
	arg_5_0.resLoader = var_1_10001.New()
	getProxy = var_1
	LoadingPicProxy = var_1_10002
	arg_5_0.loadingPicProxy = var_1(var_1_10002)
	arg_5_0.picInfoList = arg_5_0:initPicInfoList()
	arg_5_0.curFilterMode = var_0_1.FilterMode.All
	arg_5_0.curPicInfoListForShow = arg_5_0:getCurPicInfoListForShow()
	arg_5_0.curUsedPicInfoList = arg_5_0:getUsedPicInfoList()
	arg_5_0.isEditMode = false
	arg_5_0.curEditPicInfoList = {}
	arg_5_0.isEditChanged = false
	arg_5_0.returnCount = 0

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0.listTF

	arg_6_0.lScrollRectSC = var_1.GetComponent(var_6_0, "LScrollRect")

	local var_6_1 = arg_6_0.lScrollRectSC

	var_1.BeginLayout(var_6_1)

	local var_6_2 = arg_6_0.lScrollRectSC

	var_1.EndLayout(var_6_2)

	return
end

function var_0_1.addListener(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.openShowBtn

	local function var_7_2()
		local var_8_0 = true

		local function var_8_1()
			local var_9_0 = arg_7_0

			var_0.switchPanel(var_9_0, true, true)

			return
		end

		local var_8_2 = {
			diyModeOpenFlag = var_8_0,
			callback = var_8_1
		}

		pg = var_2_10003

		local var_8_3 = var_2_10003.m02
		local var_8_4 = var_3.sendNotification

		GAME = var_2_10005

		var_8_4(var_8_3, var_2_10005.UPDATE_LOADING_PIC, var_8_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.closeShowBtn

	local function var_7_5()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		i18n = var_2_10003
		var_10_2.content = var_2_10003("loading_quit_tip")

		function var_10_2.onYes()
			local var_11_0 = false

			local function var_11_1()
				local var_12_0 = arg_7_0

				var_0.switchPanel(var_12_0, false)

				return
			end

			local var_11_2 = {
				diyModeOpenFlag = var_11_0,
				callback = var_11_1
			}

			pg = var_3_10003

			local var_11_3 = var_3_10003.m02
			local var_11_4 = var_3.sendNotification

			GAME = var_3_10005

			var_11_4(var_11_3, var_3_10005.UPDATE_LOADING_PIC, var_11_2)

			return
		end

		var_10_1(var_10_0, var_10_2)

		local var_10_3 = {}

		diyModeOpenFlag = var_10_0
		var_10_3.diyModeOpenFlag = var_10_0
		closeFunc = var_10_0
		var_10_3.callback = var_10_0
		pg = var_10_0

		local var_10_4 = var_10_0.m02
		local var_10_5 = var_1.sendNotification

		GAME = var_3

		var_10_5(var_10_4, var_3.UPDATE_LOADING_PIC, var_10_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	function arg_7_0.lScrollRectSC.onReturnItem(arg_13_0, arg_13_1)
		local var_13_0 = arg_7_0

		var_2.checkReturnCount(var_13_0)

		return
	end

	function arg_7_0.lScrollRectSC.onInitItem(arg_14_0)
		return
	end

	local var_7_6 = arg_7_0.lScrollRectSC

	function var_7_6.onUpdateItem(arg_15_0, arg_15_1)
		arg_15_0 = arg_15_0 + 1

		local var_15_0 = arg_7_0
		local var_15_1 = var_2.getCurPicInfoForShowByIndex(var_15_0, arg_15_0)
		local var_15_2 = arg_7_0

		var_3.updatePicTpl(var_15_2, arg_15_1, var_15_1)

		onButton = var_3

		local var_15_3 = arg_7_0
		local var_15_4 = arg_15_1

		local function var_15_5()
			if arg_7_0.isEditMode then
				local var_16_0 = arg_7_0

				if var_0.isPicInfoSelected(var_16_0, var_15_1) then
					local var_16_1 = arg_7_0

					var_1.removePicInfoFromEditList(var_16_1, var_15_1)
				else
					local var_16_2 = arg_7_0

					var_1.addPicInfoToEditList(var_16_2, var_15_1)
				end

				local var_16_3 = arg_7_0

				var_1.updatePicTpl(var_16_3, arg_15_1, var_15_1)

				local var_16_4 = arg_7_0

				var_1.updateCountText(var_16_4)
			else
				local var_16_5 = arg_7_0

				var_0.openPicViewLayer(var_16_5, var_15_1)
			end

			return
		end

		SFX_PANEL = var_2_10007

		var_3(var_15_3, var_15_4, var_15_5, var_2_10007)

		return
	end

	onButton = var_7_6

	local var_7_7 = arg_7_0
	local var_7_8 = arg_7_0.openFilterBtn

	local function var_7_9()
		local var_17_0 = arg_7_0

		var_0.showFilterPanel(var_17_0, true)

		return
	end

	SFX_PANEL = var_1_10005

	var_7_6(var_7_7, var_7_8, var_7_9, var_1_10005)

	onButton = var_7_6

	local var_7_10 = arg_7_0
	local var_7_11 = arg_7_0.closeFilterBtn

	local function var_7_12()
		local var_18_0 = arg_7_0

		var_0.showFilterPanel(var_18_0, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_7_6(var_7_10, var_7_11, var_7_12, var_1_10005)

	onButton = var_7_6

	local var_7_13 = arg_7_0
	local var_7_14 = arg_7_0.filterSelectedBtn

	local function var_7_15()
		arg_7_0.curFilterMode = var_0_1.FilterMode.Selected

		local var_19_0 = arg_7_0
		local var_19_1 = arg_7_0

		var_19_0.curPicInfoListForShow = var_1.getCurPicInfoListForShow(var_19_1)

		local var_19_2 = arg_7_0

		var_0.updateAllPicTplList(var_19_2)

		local var_19_3 = arg_7_0

		var_0.showFilterPanel(var_19_3, false)

		local var_19_4 = arg_7_0

		var_0.updateFilterBtn(var_19_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_7_6(var_7_13, var_7_14, var_7_15, var_1_10005)

	onButton = var_7_6

	local var_7_16 = arg_7_0
	local var_7_17 = arg_7_0.filterDefaultBtn

	local function var_7_18()
		arg_7_0.curFilterMode = var_0_1.FilterMode.Default

		local var_20_0 = arg_7_0
		local var_20_1 = arg_7_0

		var_20_0.curPicInfoListForShow = var_1.getCurPicInfoListForShow(var_20_1)

		local var_20_2 = arg_7_0

		var_0.updateAllPicTplList(var_20_2)

		local var_20_3 = arg_7_0

		var_0.showFilterPanel(var_20_3, false)

		local var_20_4 = arg_7_0

		var_0.updateFilterBtn(var_20_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_7_6(var_7_16, var_7_17, var_7_18, var_1_10005)

	onButton = var_7_6

	local var_7_19 = arg_7_0
	local var_7_20 = arg_7_0.filterGalleryBtn

	local function var_7_21()
		arg_7_0.curFilterMode = var_0_1.FilterMode.Gallery

		local var_21_0 = arg_7_0
		local var_21_1 = arg_7_0

		var_21_0.curPicInfoListForShow = var_1.getCurPicInfoListForShow(var_21_1)

		local var_21_2 = arg_7_0

		var_0.updateAllPicTplList(var_21_2)

		local var_21_3 = arg_7_0

		var_0.showFilterPanel(var_21_3, false)

		local var_21_4 = arg_7_0

		var_0.updateFilterBtn(var_21_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_7_6(var_7_19, var_7_20, var_7_21, var_1_10005)

	onButton = var_7_6

	local var_7_22 = arg_7_0
	local var_7_23 = arg_7_0.filterMangaBtn

	local function var_7_24()
		arg_7_0.curFilterMode = var_0_1.FilterMode.Manga

		local var_22_0 = arg_7_0
		local var_22_1 = arg_7_0

		var_22_0.curPicInfoListForShow = var_1.getCurPicInfoListForShow(var_22_1)

		local var_22_2 = arg_7_0

		var_0.updateAllPicTplList(var_22_2)

		local var_22_3 = arg_7_0

		var_0.showFilterPanel(var_22_3, false)

		local var_22_4 = arg_7_0

		var_0.updateFilterBtn(var_22_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_7_6(var_7_22, var_7_23, var_7_24, var_1_10005)

	onButton = var_7_6

	local var_7_25 = arg_7_0
	local var_7_26 = arg_7_0.filterAllBtn

	local function var_7_27()
		arg_7_0.curFilterMode = var_0_1.FilterMode.All

		local var_23_0 = arg_7_0
		local var_23_1 = arg_7_0

		var_23_0.curPicInfoListForShow = var_1.getCurPicInfoListForShow(var_23_1)

		local var_23_2 = arg_7_0

		var_0.updateAllPicTplList(var_23_2)

		local var_23_3 = arg_7_0

		var_0.showFilterPanel(var_23_3, false)

		local var_23_4 = arg_7_0

		var_0.updateFilterBtn(var_23_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_7_6(var_7_25, var_7_26, var_7_27, var_1_10005)

	onButton = var_7_6

	var_7_6(arg_7_0, arg_7_0.editBtn, function()
		if not arg_7_0.isEditMode then
			local var_24_0 = arg_7_0

			var_0.enterEditMode(var_24_0, true)
		else
			local function var_24_1()
				local var_25_0 = arg_7_0

				var_0.enterEditMode(var_25_0, false)

				return
			end

			if arg_7_0.isEditChanged then
				pg = var_1

				local var_24_2 = var_1.MsgboxMgr.GetInstance()
				local var_24_3 = var_1.ShowMsgBox
				local var_24_4 = {}

				i18n = var_2_10004
				var_24_4.content = var_2_10004("loading_pic_tip")

				function var_24_4.onYes()
					var_24_1()

					return
				end

				var_24_3(var_24_2, var_24_4)
			else
				var_24_1()
			end
		end

		return
	end)

	onButton = var_7_6

	local var_7_28 = arg_7_0
	local var_7_29 = arg_7_0.resetBtn

	local function var_7_30()
		local var_27_0 = arg_7_0
		local var_27_1 = arg_7_0

		var_27_0.curEditPicInfoList = var_1.getDefaultPicInfoList(var_27_1)
		arg_7_0.isEditChanged = true

		local var_27_2 = arg_7_0

		var_0.updateCurPicTplList(var_27_2)

		local var_27_3 = arg_7_0

		var_0.updateCountText(var_27_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_7_6(var_7_28, var_7_29, var_7_30, var_1_10005)

	onButton = var_7_6

	local var_7_31 = arg_7_0
	local var_7_32 = arg_7_0.clearBtn

	local function var_7_33()
		arg_7_0.curEditPicInfoList = {}
		arg_7_0.isEditChanged = true

		local var_28_0 = arg_7_0

		var_0.updateCurPicTplList(var_28_0)

		local var_28_1 = arg_7_0

		var_0.updateCountText(var_28_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_7_6(var_7_31, var_7_32, var_7_33, var_1_10005)

	onButton = var_7_6

	local var_7_34 = arg_7_0
	local var_7_35 = arg_7_0.confirmBtn

	local function var_7_36()
		if #arg_7_0.curEditPicInfoList == 0 then
			pg = var_0

			local var_29_0 = var_0.TipsMgr.GetInstance()
			local var_29_1 = var_0.ShowTips

			i18n = var_2_10002

			var_29_1(var_29_0, var_2_10002("loading_pic_min"))

			return
		end

		local var_29_2 = true
		local var_29_3 = {}
		local var_29_4 = {}

		ipairs = var_2_10003

		for iter_29_0, iter_29_1 in var_2_10003(arg_7_0.curEditPicInfoList) do
			local var_29_5 = iter_29_1.type

			AppreciatePicConst = var_2_10009

			if var_29_5 == var_2_10009.TYPE_GALLERY then
				table = var_29_5

				var_29_5.insert(var_29_3, iter_29_1.id)
			else
				local var_29_6 = iter_29_1.type

				AppreciatePicConst = var_2_10009

				if var_29_6 == var_2_10009.TYPE_MANGA then
					table = var_29_6

					var_29_6.insert(var_29_4, iter_29_1.id)
				end
			end
		end

		local function var_29_7()
			arg_7_0.isEditChanged = false

			local var_30_0 = arg_7_0
			local var_30_1 = arg_7_0

			var_30_0.curPicInfoListForShow = var_1.getCurPicInfoListForShow(var_30_1)

			local var_30_2 = arg_7_0

			var_0.enterEditMode(var_30_2, false)

			local var_30_3 = arg_7_0

			var_0.updateAllPicTplList(var_30_3)

			return
		end

		local var_29_8 = {
			diyModeOpenFlag = var_29_2,
			galleryPicIDList = var_29_3,
			mangaPicIDList = var_29_4,
			callback = var_29_7
		}

		pg = var_5

		local var_29_9 = var_5.m02
		local var_29_10 = var_5.sendNotification

		GAME = iter_29_1

		var_29_10(var_29_9, iter_29_1.UPDATE_LOADING_PIC, var_29_8)

		return
	end

	SFX_PANEL = var_1_10005

	var_7_6(var_7_34, var_7_35, var_7_36, var_1_10005)

	local var_7_37 = arg_7_0.filterListTF
	local var_7_38 = var_1.GetComponent

	typeof = var_7_35
	DftAniEvent = var_7_36

	local var_7_39 = var_7_38(var_7_37, var_7_35(var_7_36))

	var_1.SetCommonEvent(var_7_39, function(arg_31_0)
		if arg_31_0.stringParameter == "OnFilterMenuPanelClose" then
			setActive = var_1

			var_1(arg_7_0.filterPanelTF, false)
		end

		return
	end)

	return
end

function var_0_1.initUIText(arg_32_0)
	setText = var_1_10001

	local var_32_0 = arg_32_0.emptyTitieText

	i18n = var_1_10003

	var_1_10001(var_32_0, var_1_10003("loading_title"))

	setText = var_1_10001

	local var_32_1 = arg_32_0.emptyTipText

	i18n = var_3

	var_1_10001(var_32_1, var_3("loading_picture_lack"))

	setText = var_1_10001

	local var_32_2 = arg_32_0.openShowBtnText

	i18n = var_3

	var_1_10001(var_32_2, var_3("loading_start_set"))

	setText = var_1_10001

	local var_32_3 = arg_32_0.closeShowBtnText

	i18n = var_3

	var_1_10001(var_32_3, var_3("loading_start_set"))

	setText = var_1_10001

	local var_32_4 = arg_32_0.showTitieText

	i18n = var_3

	var_1_10001(var_32_4, var_3("loading_title"))

	setText = var_1_10001

	local var_32_5 = arg_32_0.countTipText

	i18n = var_3

	var_1_10001(var_32_5, var_3("loading_pic_chosen"))

	setText = var_1_10001

	local var_32_6 = arg_32_0.emptyViewTipText

	i18n = var_3

	var_1_10001(var_32_6, var_3("loading_chosen_blank"))

	return
end

function var_0_1.autoSelectPanel(arg_33_0)
	local var_33_0 = arg_33_0.loadingPicProxy

	if var_1.getDiyModeOpenFlag(var_33_0) then
		arg_33_0:switchPanel(true)
	else
		arg_33_0:switchPanel(false)
	end

	return
end

function var_0_1.switchPanel(arg_34_0, arg_34_1, arg_34_2)
	if not arg_34_1 then
		setActive = var_1_10003

		var_1_10003(arg_34_0.emptyPanelTF, true)

		setActive = var_1_10003

		var_1_10003(arg_34_0.showPanelTF, false)

		quickPlayAnimation = var_1_10003

		var_1_10003(arg_34_0._tf, "anim_AttireLoadingPicUI_not_select")
	elseif arg_34_1 and arg_34_2 then
		setActive = var_1_10003

		var_1_10003(arg_34_0.emptyPanelTF, true)

		setActive = var_1_10003

		var_1_10003(arg_34_0.showPanelTF, true)

		quickPlayAnimation = var_1_10003

		var_1_10003(arg_34_0._tf, "anim_AttireLoadingPicUI_open")
	elseif arg_34_1 then
		setActive = var_1_10003

		var_1_10003(arg_34_0.emptyPanelTF, false)

		setActive = var_1_10003

		var_1_10003(arg_34_0.showPanelTF, true)

		quickPlayAnimation = var_1_10003

		var_1_10003(arg_34_0._tf, "anim_AttireLoadingPicUI_select")
	end

	if arg_34_1 then
		arg_34_0:updateCountText()
		arg_34_0:updateAllPicTplList()
		arg_34_0:updateFilterBtn()
	end

	return
end

function var_0_1.updateCountText(arg_35_0)
	local var_35_0

	if arg_35_0.isEditMode then
		var_35_0 = arg_35_0.curEditPicInfoList
	else
		var_35_0 = arg_35_0.curUsedPicInfoList
	end

	local var_35_1 = #var_35_0

	setText = var_1_10003

	local var_35_2 = arg_35_0.countNumText

	string = var_1_10005

	local var_35_3 = var_1_10005.format
	local var_35_4 = "%d/%d"
	local var_35_5 = var_35_1

	AppreciatePicConst = var_1_10008

	var_1_10003(var_35_2, var_35_3(var_35_4, var_35_5, var_1_10008.MAX_COUNT))

	return
end

function var_0_1.updateAllPicTplList(arg_36_0)
	local var_36_0 = arg_36_0.resLoader

	var_1.Clear(var_36_0)

	setActive = var_1

	var_1(arg_36_0.emptyViewTF, #arg_36_0.curPicInfoListForShow == 0)

	setActive = var_1

	var_1(arg_36_0.scrollViewTF, #arg_36_0.curPicInfoListForShow > 0)

	if #arg_36_0.curPicInfoListForShow > 0 then
		local var_36_1 = arg_36_0.lScrollRectSC

		var_1.SetTotalCount(var_36_1, #arg_36_0.curPicInfoListForShow)
	end

	return
end

function var_0_1.enterEditMode(arg_37_0, arg_37_1)
	arg_37_0.isEditMode = arg_37_1

	if arg_37_1 then
		Clone = var_1_10002
		arg_37_0.curEditPicInfoList = var_1_10002(arg_37_0.curUsedPicInfoList)
	else
		arg_37_0.curEditPicInfoList = {}
		arg_37_0.curUsedPicInfoList = arg_37_0:getUsedPicInfoList()
	end

	arg_37_0.isEditChanged = false
	setActive = var_2

	var_2(arg_37_0.clearBtn, arg_37_1)

	setActive = var_2

	var_2(arg_37_0.confirmBtn, arg_37_1)

	setActive = var_2

	var_2(arg_37_0.resetBtn, arg_37_1)
	arg_37_0:updateCurPicTplList()
	arg_37_0:updateCountText()

	return
end

function var_0_1.updatePicTpl(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0:updatePicTplForImg(arg_38_1, arg_38_2)
	arg_38_0:updatePicTplForTag(arg_38_1, arg_38_2)
	arg_38_0:updatePicTplForSelect(arg_38_1, arg_38_2)

	return
end

function var_0_1.updatePicTplForImg(arg_39_0, arg_39_1, arg_39_2)
	findTF = var_1_10003

	local var_39_0 = var_1_10003(arg_39_1, "Pic/Gallery")

	findTF = var_4

	local var_39_1 = var_4(arg_39_1, "Pic/Manga/Image")

	setActive = var_5

	local var_39_2 = var_39_0
	local var_39_3 = arg_39_2.type

	AppreciatePicConst = var_1_10008

	var_5(var_39_2, var_39_3 == var_1_10008.TYPE_GALLERY)

	setActive = var_5

	local var_39_4 = var_39_1
	local var_39_5 = arg_39_2.type

	AppreciatePicConst = var_8

	var_5(var_39_4, var_39_5 == var_8.TYPE_MANGA)

	local var_39_6 = arg_39_2.type

	AppreciatePicConst = var_39_4

	local var_39_7

	if var_39_6 == var_39_4.TYPE_GALLERY then
		var_39_7 = arg_39_0

		arg_39_0.setImage(var_39_7, var_39_0, arg_39_2)

		setActive = var_5
		findTF = var_39_7

		var_5(var_39_7(arg_39_1, "Pic/Gallery"), true)

		setActive = var_5
		findTF = var_39_7

		var_5(var_39_7(arg_39_1, "Pic/Manga"), false)
	else
		local var_39_8 = arg_39_2.type

		AppreciatePicConst = var_39_7

		if var_39_8 == var_39_7.TYPE_MANGA then
			local var_39_9 = arg_39_0

			arg_39_0.setImage(var_39_9, var_39_1, arg_39_2)

			setActive = var_5
			findTF = var_39_9

			var_5(var_39_9(arg_39_1, "Pic/Gallery"), false)

			setActive = var_5
			findTF = var_6

			var_5(var_6(arg_39_1, "Pic/Manga"), true)
		end
	end

	return
end

function var_0_1.updatePicTplForTag(arg_40_0, arg_40_1, arg_40_2)
	findTF = var_1_10003

	local var_40_0 = var_1_10003(arg_40_1, "Tag/Used")

	findTF = var_4

	local var_40_1 = var_4(arg_40_1, "Tag/New")

	if arg_40_0.isEditMode then
		setActive = var_5

		var_5(var_40_0, arg_40_0:isPicInfoSelected(arg_40_2))
	else
		setActive = var_5

		var_5(var_40_0, arg_40_0:isPicInfoUsed(arg_40_2))
	end

	isActive = var_5

	if var_5(var_40_0) then
		setActive = var_5

		var_5(var_40_1, false)
	else
		setActive = var_5

		var_5(var_40_1, arg_40_0:isNewPicInfo(arg_40_2))
	end

	return
end

function var_0_1.updatePicTplForSelect(arg_41_0, arg_41_1, arg_41_2)
	findTF = var_1_10003

	local var_41_0 = var_1_10003(arg_41_1, "Pic/Selected")

	if arg_41_0.isEditMode then
		setActive = var_4

		var_4(var_41_0, arg_41_0:isPicInfoSelected(arg_41_2))
	else
		setActive = var_4

		var_4(var_41_0, arg_41_0:isPicInfoUsed(arg_41_2))
	end

	return
end

function var_0_1.setImage(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_2.path

	GetFileName = var_1_10004

	local var_42_1 = var_1_10004(var_42_0)

	GetComponent = var_5

	local var_42_2 = arg_42_1

	typeof = var_1_10007
	Image = var_1_10008

	local var_42_3 = var_5(var_42_2, var_1_10007(var_1_10008)).sprite

	IsNil = var_42_2

	if not var_42_2(var_42_3) then
		local var_42_4 = var_42_3.name

		string = var_7

		local var_42_5 = var_7.lower(var_42_4)

		string = var_8

		if var_42_5 ~= var_8.lower(var_42_1) then
			local var_42_6 = arg_42_0.resLoader

			var_7.LoadSprite(var_42_6, var_42_0, var_42_1, arg_42_1, false)
		end
	else
		local var_42_7 = arg_42_0.resLoader

		var_6.LoadSprite(var_42_7, var_42_0, var_42_1, arg_42_1, false)
	end

	return
end

function var_0_1.showFilterPanel(arg_43_0, arg_43_1)
	setActive = var_1_10002

	var_1_10002(arg_43_0.filterPanelTF, true)

	if arg_43_1 then
		quickPlayAnimation = var_1_10002

		var_1_10002(arg_43_0.filterListTF, "anim_FilterMenuPanel_open")
	else
		quickPlayAnimation = var_1_10002

		var_1_10002(arg_43_0.filterListTF, "anim_FilterMenuPanel_close")
	end

	return
end

function var_0_1.openPicViewLayer(arg_44_0, arg_44_1)
	LoadContextCommand = var_1_10002

	local var_44_0 = var_1_10002.LoadLayerOnTopContext

	Context = var_1_10003

	local var_44_1 = var_1_10003.New
	local var_44_2 = {}

	AppreciatePicViewMediator = var_1_10005
	var_44_2.mediator = var_1_10005
	AppreciatePicViewLayer = var_1_10005
	var_44_2.viewComponent = var_1_10005
	var_44_2.data = {
		curPicInfo = arg_44_1,
		picInfoList = arg_44_0.curPicInfoListForShow
	}

	function var_44_2.onRemoved()
		local var_45_0 = arg_44_0
		local var_45_1 = arg_44_0

		var_45_0.curUsedPicInfoList = var_1.getUsedPicInfoList(var_45_1)

		local var_45_2 = arg_44_0

		var_0.updateCurPicTplList(var_45_2)

		local var_45_3 = arg_44_0

		var_0.updateCountText(var_45_3)

		return
	end

	var_44_0(var_44_1(var_44_2))

	return
end

function var_0_1.updateCurPicTplList(arg_46_0)
	for iter_46_0 = 1, arg_46_0.listTF.childCount do
		local var_46_0 = arg_46_0.listTF
		local var_46_1 = var_5.GetChild(var_46_0, iter_46_0 - 1)

		go = var_46_0

		if var_46_0(var_46_1).name ~= "-1" then
			tonumber = var_7

			local var_46_2 = var_7(var_6) + 1
			local var_46_3 = arg_46_0:getCurPicInfoForShowByIndex(var_46_2)

			arg_46_0:updatePicTpl(var_46_1, var_46_3)
		end
	end

	return
end

function var_0_1.checkReturnCount(arg_47_0)
	return
end

function var_0_1.updateFilterBtn(arg_48_0)
	findTF = var_1_10001

	local var_48_0 = var_1_10001(arg_48_0.openFilterBtn, "ALL")

	findTF = var_2

	local var_48_1 = var_2(arg_48_0.openFilterBtn, "Default")

	findTF = var_3

	local var_48_2 = var_3(arg_48_0.openFilterBtn, "Gallery")

	findTF = var_4

	local var_48_3 = var_4(arg_48_0.openFilterBtn, "Manga")

	findTF = var_5

	local var_48_4 = var_5(arg_48_0.openFilterBtn, "Selected")

	setActive = var_6

	var_6(var_48_0, arg_48_0.curFilterMode == var_0_1.FilterMode.All)

	setActive = var_6

	var_6(var_48_1, arg_48_0.curFilterMode == var_0_1.FilterMode.Default)

	setActive = var_6

	var_6(var_48_2, arg_48_0.curFilterMode == var_0_1.FilterMode.Gallery)

	setActive = var_6

	var_6(var_48_3, arg_48_0.curFilterMode == var_0_1.FilterMode.Manga)

	setActive = var_6

	var_6(var_48_4, arg_48_0.curFilterMode == var_0_1.FilterMode.Selected)

	return
end

function var_0_1.initPicInfoList(arg_49_0)
	local var_49_0 = {}

	ipairs = var_1_10002
	pg = var_1_10003

	for iter_49_0, iter_49_1 in var_1_10002(var_1_10003.gallery_config.all) do
		GalleryConst = var_1_10007
		var_1_10007 = var_1_10007.GetGalleryPicPathByID(iter_49_1)
		checkABExist = var_8

		if var_8(var_1_10007) then
			AppreciatePicConst = var_8

			local var_49_1 = var_8.createPicInfo

			AppreciatePicConst = var_9

			local var_49_2 = var_49_1(var_9.TYPE_GALLERY, iter_49_1)

			table = var_9

			var_9.insert(var_49_0, var_49_2)
		end
	end

	ipairs = var_2
	pg = var_3

	for iter_49_2, iter_49_3 in var_2(var_3.cartoon.all) do
		MangaConst = var_1_10007
		var_1_10007 = var_1_10007.GetMangaPicPathByID(iter_49_3)
		checkABExist = var_8

		if var_8(var_1_10007) then
			AppreciatePicConst = var_8

			local var_49_3 = var_8.createPicInfo

			AppreciatePicConst = var_9

			local var_49_4 = var_49_3(var_9.TYPE_MANGA, iter_49_3)

			table = var_9

			var_9.insert(var_49_0, var_49_4)
		end
	end

	return var_49_0
end

function var_0_1.getUsedPicInfoList(arg_50_0)
	local var_50_0 = {}

	ipairs = var_1_10002

	for iter_50_0, iter_50_1 in var_1_10002(arg_50_0.picInfoList) do
		if arg_50_0:isPicInfoUsed(iter_50_1) then
			table = var_7

			var_7.insert(var_50_0, iter_50_1)
		end
	end

	arg_50_0.curUsedPicInfoList = var_50_0

	return var_50_0
end

function var_0_1.isPicInfoUsed(arg_51_0, arg_51_1)
	AppreciatePicConst = var_1_10002

	return var_1_10002.isUsedPicInfo(arg_51_1)
end

function var_0_1.isNewPicInfo(arg_52_0, arg_52_1)
	AppreciatePicConst = var_1_10002

	return var_1_10002.isNewPicInfo(arg_52_1)
end

function var_0_1.isDefaultPicInfo(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0
	local var_53_1 = arg_53_0.isGalleryPic(var_53_0, arg_53_1)

	table = var_53_0

	local var_53_2 = var_53_0.contains

	AppreciatePicConst = var_4

	local var_53_3 = var_53_2(var_4.getDefaultGalleryPicIDList(), arg_53_1.id)

	return var_53_1 and var_53_3
end

function var_0_1.isGalleryPic(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_1.type

	AppreciatePicConst = var_1_10003

	return var_54_0 == var_1_10003.TYPE_GALLERY
end

function var_0_1.isMangaPic(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_1.type

	AppreciatePicConst = var_1_10003

	return var_55_0 == var_1_10003.TYPE_MANGA
end

function var_0_1.getPicInfoTypeSortWeight(arg_56_0, arg_56_1)
	if arg_56_0:isGalleryPic(arg_56_1) and not arg_56_0:isDefaultPicInfo(arg_56_1) then
		return 3
	elseif arg_56_0:isDefaultPicInfo(arg_56_1) then
		return 2
	elseif arg_56_0:isMangaPic(arg_56_1) then
		return 1
	end

	return 0
end

function var_0_1.isPicInfoSelected(arg_57_0, arg_57_1)
	local var_57_0

	if arg_57_0.isEditMode then
		var_57_0 = arg_57_0.curEditPicInfoList
	else
		var_57_0 = arg_57_0.curUsedPicInfoList
	end

	ipairs = var_3

	for iter_57_0, iter_57_1 in var_3(var_57_0) do
		if iter_57_1.id == arg_57_1.id and iter_57_1.type == arg_57_1.type then
			return true
		end
	end

	return false
end

function var_0_1.sortPicInfoList(arg_58_0, arg_58_1)
	table = var_1_10002

	var_1_10002.sort(arg_58_1, function(arg_59_0, arg_59_1)
		local var_59_0 = arg_58_0
		local var_59_1 = var_2.isNewPicInfo(var_59_0, arg_59_0)
		local var_59_2 = arg_58_0

		if var_59_1 ~= var_3.isNewPicInfo(var_59_2, arg_59_1) then
			return var_59_1
		end

		local var_59_3 = arg_58_0
		local var_59_4 = var_4.getPicInfoTypeSortWeight(var_59_3, arg_59_0)
		local var_59_5 = arg_58_0
		local var_59_6 = var_5.getPicInfoTypeSortWeight(var_59_5, arg_59_1)

		if var_59_1 and var_3 then
			if var_59_4 ~= var_59_6 then
				return var_59_6 < var_59_4
			end

			return arg_59_0.id > arg_59_1.id
		end

		local var_59_7 = arg_58_0
		local var_59_8 = var_6.isPicInfoUsed(var_59_7, arg_59_0)
		local var_59_9 = arg_58_0

		if var_59_8 ~= var_7.isPicInfoUsed(var_59_9, arg_59_1) then
			return var_59_8
		end

		if var_59_4 ~= var_59_6 then
			return var_59_6 < var_59_4
		end

		return arg_59_0.id > arg_59_1.id
	end)

	return arg_58_1
end

function var_0_1.getCurPicInfoListForShow(arg_60_0)
	local var_60_0 = {}

	if arg_60_0.curFilterMode == var_0_1.FilterMode.All then
		Clone = var_2
		var_60_0 = var_2(arg_60_0.picInfoList)
	elseif arg_60_0.curFilterMode == var_0_1.FilterMode.Selected then
		ipairs = var_2

		for iter_60_0, iter_60_1 in var_2(arg_60_0.picInfoList) do
			if arg_60_0:isPicInfoSelected(iter_60_1) then
				table = var_7

				var_7.insert(var_60_0, iter_60_1)
			end
		end
	elseif arg_60_0.curFilterMode == var_0_1.FilterMode.Gallery then
		ipairs = var_2

		for iter_60_2, iter_60_3 in var_2(arg_60_0.picInfoList) do
			if arg_60_0:isGalleryPic(iter_60_3) and not arg_60_0:isDefaultPicInfo(iter_60_3) then
				table = var_7

				var_7.insert(var_60_0, iter_60_3)
			end
		end
	elseif arg_60_0.curFilterMode == var_0_1.FilterMode.Manga then
		ipairs = var_2

		for iter_60_4, iter_60_5 in var_2(arg_60_0.picInfoList) do
			if arg_60_0:isMangaPic(iter_60_5) then
				table = var_7

				var_7.insert(var_60_0, iter_60_5)
			end
		end
	elseif arg_60_0.curFilterMode == var_0_1.FilterMode.Default then
		var_60_0 = arg_60_0:getDefaultPicInfoList()
	end

	arg_60_0.curPicInfoListForShow = arg_60_0:sortPicInfoList(var_60_0)

	return var_1
end

function var_0_1.getDefaultPicInfoList(arg_61_0)
	AppreciatePicConst = var_1_10001

	local var_61_0 = var_1_10001.getDefaultGalleryPicIDList()
	local var_61_1 = {}

	ipairs = var_1_10003

	for iter_61_0, iter_61_1 in var_1_10003(var_61_0) do
		GalleryConst = var_1_10008
		var_1_10008 = var_1_10008.GetGalleryPicPathByID(iter_61_1)
		checkABExist = var_9

		if var_9(var_1_10008) then
			AppreciatePicConst = var_9

			local var_61_2 = var_9.createPicInfo

			AppreciatePicConst = var_10

			local var_61_3 = var_61_2(var_10.TYPE_GALLERY, iter_61_1)

			table = var_10

			var_10.insert(var_61_1, var_61_3)
		end
	end

	return var_61_1
end

function var_0_1.getCurPicInfoForShowByIndex(arg_62_0, arg_62_1)
	return arg_62_0.curPicInfoListForShow[arg_62_1]
end

function var_0_1.getPicInfoIndexInShowList(arg_63_0, arg_63_1)
	local var_63_0 = 0

	ipairs = var_1_10003

	for iter_63_0, iter_63_1 in var_1_10003(arg_63_0.curPicInfoListForShow) do
		if iter_63_1.id == arg_63_1.id and iter_63_1.type == arg_63_1.type then
			return iter_63_0
		end
	end

	return 0
end

function var_0_1.removePicInfoFromEditList(arg_64_0, arg_64_1)
	local var_64_0 = 0

	ipairs = var_1_10003

	for iter_64_0, iter_64_1 in var_1_10003(arg_64_0.curEditPicInfoList) do
		if iter_64_1.id == arg_64_1.id and iter_64_1.type == arg_64_1.type then
			table = var_8

			var_8.remove(arg_64_0.curEditPicInfoList, iter_64_0)

			break
		end
	end

	arg_64_0.isEditChanged = true

	return
end

function var_0_1.addPicInfoToEditList(arg_65_0, arg_65_1)
	local var_65_0 = #arg_65_0.curEditPicInfoList

	AppreciatePicConst = var_1_10003

	if var_65_0 >= var_1_10003.MAX_COUNT then
		pg = var_65_0

		local var_65_1 = var_65_0.TipsMgr.GetInstance()

		var_65_0 = var_65_0.ShowTips
		i18n = var_1_10004

		var_65_0(var_65_1, var_1_10004("loading_pic_max"))

		return
	end

	table = var_65_0

	var_65_0.insert(arg_65_0.curEditPicInfoList, arg_65_1)

	arg_65_0.isEditChanged = true

	return
end

return var_0_1
