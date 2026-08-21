local var_0_0 = class("GalleryView", import("..base.BaseSubView"))

var_0_0.GalleryPicGroupName = "GALLERY_PIC"

function var_0_0.getUIName(arg_1_0)
	return "GalleryUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	arg_2_0.galleryScrollView = GalleryScrollView.New(arg_2_0.scrollPanel, arg_2_0)
	arg_2_0.galleryGridView = GalleryGridView.New(arg_2_0.gridPanel, arg_2_0)

	arg_2_0:Show()
	arg_2_0:refreshPicInfoList()
	arg_2_0:tryShowTipMsgBox()

	return
end

function var_0_0.OnDestroy(arg_3_0)
	if arg_3_0.galleryScrollView then
		arg_3_0.galleryScrollView:dispose()

		arg_3_0.galleryScrollView = nil
	end

	if arg_3_0.galleryGridView then
		arg_3_0.galleryGridView:dispose()

		arg_3_0.galleryGridView = nil
	end

	return
end

function var_0_0.onBackPressed(arg_4_0)
	return true
end

function var_0_0.initData(arg_5_0)
	arg_5_0.appreciateProxy = getProxy(AppreciateProxy)

	arg_5_0.appreciateProxy:checkPicFileState()

	arg_5_0.picInfoListForShow = {}
	arg_5_0.isDownloading = false
	arg_5_0.downloadCount = 0
	arg_5_0.downloadTotal = 0
	arg_5_0.downloadFailed = false
	arg_5_0.hasMissingGalleryPic = false
	arg_5_0.hasExistingGalleryPic = false
	arg_5_0.curViewMode = "scroll"
	arg_5_0.curPicLikeValue = GalleryConst.Filte_Normal_Value
	arg_5_0.curPicSetValue = GalleryConst.Filte_Set_Normal_Value
	arg_5_0.curPicSortValue = GalleryConst.Sort_Order_Up

	return
end

function var_0_0.findUI(arg_6_0)
	setLocalPosition(arg_6_0._tf, Vector2.zero)

	arg_6_0._tf.anchorMin = Vector2.zero
	arg_6_0._tf.anchorMax = Vector2.one
	arg_6_0._tf.offsetMax = Vector2.zero
	arg_6_0._tf.offsetMin = Vector2.zero
	arg_6_0.topPanel = arg_6_0._tf:Find("TopPanel")
	arg_6_0.setFilterToggle = arg_6_0.topPanel:Find("List/SetFilterBtn")

	setText(arg_6_0.setFilterToggle:Find("TextLikeOff"), i18n("loading_pic_btn"))
	setText(arg_6_0.setFilterToggle:Find("TextLikeOn"), i18n("loading_pic_btn"))
	setActive(arg_6_0.setFilterToggle, true)
	setActive(arg_6_0.topPanel:Find("List/TimeFilterBtn"), false)

	arg_6_0.likeFilterToggle = arg_6_0.topPanel:Find("List/LikeFilterBtn")

	setActive(arg_6_0.likeFilterToggle, true)

	arg_6_0.likeNumText = arg_6_0.likeFilterToggle:Find("TextNum")

	setActive(arg_6_0.likeNumText, false)

	arg_6_0.orderToggle = arg_6_0.topPanel:Find("List/OrderBtn")
	arg_6_0.resRepaireBtn = arg_6_0.topPanel:Find("List/RepaireBtn")
	arg_6_0.switchToGridBtn = arg_6_0.topPanel:Find("SwitchToGridBtn")
	arg_6_0.switchToScrollBtn = arg_6_0.topPanel:Find("SwitchToScrollBtn")
	arg_6_0.scrollPanel = arg_6_0._tf:Find("Scroll")
	arg_6_0.gridPanel = arg_6_0._tf:Find("Grid")
	arg_6_0.emptyPanel = arg_6_0._tf:Find("EmptyPanel")
	arg_6_0.updatePanel = arg_6_0._tf:Find("UpdatePanel")

	return
end

function var_0_0.addListener(arg_7_0)
	onToggle(arg_7_0, arg_7_0.orderToggle, function(arg_8_0)
		arg_7_0.curPicSortValue = arg_8_0 == true and GalleryConst.Sort_Order_Down or GalleryConst.Sort_Order_Up

		arg_7_0:refreshPicInfoList(true)

		return
	end, SFX_PANEL)
	onToggle(arg_7_0, arg_7_0.likeFilterToggle, function(arg_9_0)
		arg_7_0.curPicLikeValue = arg_9_0 == true and GalleryConst.Filte_Like_Value or GalleryConst.Filte_Normal_Value

		arg_7_0:refreshPicInfoList(true)

		return
	end)
	onToggle(arg_7_0, arg_7_0.setFilterToggle, function(arg_10_0)
		arg_7_0.curPicSetValue = arg_10_0 == true and GalleryConst.Filte_Set_Value or GalleryConst.Filte_Set_Normal_Value

		arg_7_0:refreshPicInfoList(true)

		return
	end)
	onButton(arg_7_0, arg_7_0.resRepaireBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideYes = true,
			content = i18n("resource_verify_warn"),
			custom = {
				{
					text = i18n("msgbox_repair"),
					onCallback = function()
						if PathMgr.FileExists(Application.persistentDataPath .. "/hashes-pic.csv") then
							BundleWizard.Inst:GetGroupMgr(var_0_0.GalleryPicGroupName):StartVerifyForLua()
						else
							pg.TipsMgr.GetInstance():ShowTips(i18n("word_no_cache"))
						end

						return
					end
				}
			}
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.switchToGridBtn, function()
		arg_7_0:switchViewMode("grid")

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.switchToScrollBtn, function()
		arg_7_0:switchViewMode("scroll")

		return
	end, SFX_PANEL)

	return
end

function var_0_0.refreshPicInfoList(arg_15_0)
	arg_15_0:filterPicInfoList()
	arg_15_0:updateViewDisplay()

	return
end

function var_0_0.switchViewMode(arg_16_0, arg_16_1)
	if arg_16_0.curViewMode == arg_16_1 then
		return
	end

	arg_16_0.curViewMode = arg_16_1

	arg_16_0:resetActiveViewState()
	arg_16_0:updateViewDisplay()

	return
end

function var_0_0.resetActiveViewState(arg_17_0)
	if arg_17_0.curViewMode == "scroll" and arg_17_0.galleryScrollView then
		arg_17_0.galleryScrollView:resetMiddleDataIndex()
	end

	return
end

function var_0_0.updateViewDisplay(arg_18_0)
	local var_18_0 = #arg_18_0.picInfoListForShow <= 0
	local var_18_1

	if #arg_18_0.picInfoListForShow <= 0 then
		::label_18_0::

		var_18_1 = not arg_18_0.hasExistingGalleryPic and arg_18_0.hasMissingGalleryPic and arg_18_0:isNeedShowDownBtn() or false

		if false then
			var_18_1 = true
		end
	end

	local var_18_2 = arg_18_0.curViewMode == "scroll"
	local var_18_3 = arg_18_0.curViewMode == "grid"

	setActive(arg_18_0.emptyPanel, var_18_0 and not var_18_1)
	setActive(arg_18_0.updatePanel, var_18_1)
	setActive(arg_18_0.scrollPanel, not var_18_0 and not var_18_1 and var_18_2)
	setActive(arg_18_0.gridPanel, not var_18_0 and not var_18_1 and var_18_3)
	setActive(arg_18_0.switchToGridBtn, var_18_2)
	setActive(arg_18_0.switchToScrollBtn, var_18_3)

	if var_18_1 then
		arg_18_0:initDownBtnPanel()
	elseif not var_18_0 then
		if var_18_3 then
			arg_18_0.galleryGridView:refresh(arg_18_0.picInfoListForShow)
		else
			arg_18_0.galleryScrollView:refresh(arg_18_0.picInfoListForShow)
		end
	end

	return
end

function var_0_0.initDownBtnPanel(arg_19_0)
	local var_19_0 = arg_19_0.updatePanel:Find("Btn")
	local var_19_1 = var_19_0:Find("Text")

	setActive(var_19_0, not arg_19_0.isDownloading)
	setActive(arg_19_0.updatePanel:Find("Progress"), arg_19_0.isDownloading)

	if arg_19_0.downloadFailed then
		setText(var_19_1, i18n("word_manga_updatefailure"))
	elseif arg_19_0.isDownloading then
		local var_19_2, var_19_3 = arg_19_0:getGalleryDownloadProgress()

		setText(var_19_1, i18n("word_manga_updating", var_19_2, var_19_3))
	else
		setText(var_19_1, i18n("word_manga_checktoupdate"))
	end

	onButton(arg_19_0, var_19_0, function()
		arg_19_0:showDownloadMsgBox()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.isGalleryDownloading(arg_21_0)
	return arg_21_0.isDownloading
end

function var_0_0.isGalleryDownloadFailed(arg_22_0)
	return arg_22_0.downloadFailed
end

function var_0_0.getGalleryDownloadProgress(arg_23_0)
	return arg_23_0.downloadCount, arg_23_0.downloadTotal
end

function var_0_0.refreshDownloadStateViews(arg_24_0)
	if arg_24_0.galleryScrollView then
		arg_24_0.galleryScrollView:updateEmptyCardDownloadStateList()
	end

	if arg_24_0.galleryGridView then
		arg_24_0.galleryGridView:updateEmptyCardDownloadStateList()
	end

	if arg_24_0.updatePanel and isActive(arg_24_0.updatePanel) then
		arg_24_0:initDownBtnPanel()
	end

	return
end

function var_0_0.showDownloadMsgBox(arg_25_0)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		type = MSGBOX_TYPE_NORMAL,
		content = string.format(i18n("group_download_tip", (HashUtil.BytesToString((GroupHelper.GetGroupSize(var_0_0.GalleryPicGroupName)))))),
		onYes = function()
			arg_25_0:startDownloadGroup()

			return
		end
	})

	return
end

function var_0_0.startDownloadGroup(arg_27_0)
	if arg_27_0.isDownloading or arg_27_0.exited then
		return
	end

	arg_27_0.isDownloading = true
	arg_27_0.downloadFailed = false
	arg_27_0.downloadCount = 0
	arg_27_0.downloadTotal = 0

	arg_27_0:refreshDownloadStateViews()
	BundleWizardUpdater.Inst:StartUpdate((BundleWizardUpdater.Inst:CreateListInfo(table.concat({
		var_0_0.GalleryPicGroupName
	}, "_"), BundleWizardUpdater.Inst:GetFileList({
		var_0_0.GalleryPicGroupName
	}), nil, function(arg_29_0, arg_29_1)
		arg_27_0:onDownloadFinish(arg_29_0, arg_29_1)

		return
	end, function(arg_28_0, arg_28_1, arg_28_2)
		arg_27_0:onDownloadProgress(arg_28_0, arg_28_1, arg_28_2)

		return
	end)))

	return
end

function var_0_0.onDownloadProgress(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_0.exited then
		return
	end

	arg_30_0.downloadCount = (arg_30_1 or 0) + (arg_30_2 or 0)
	arg_30_0.downloadTotal = arg_30_3 or 0

	arg_30_0:refreshDownloadStateViews()

	return
end

function var_0_0.onDownloadFinish(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0.isDownloading = false
	arg_31_0.downloadFailed = not arg_31_1

	if arg_31_0.exited then
		return
	end

	if arg_31_1 then
		arg_31_0.downloadCount = arg_31_0.downloadTotal

		arg_31_0.appreciateProxy:checkPicFileState()
		arg_31_0:refreshDownloadStateViews()
		arg_31_0:refreshPicInfoList()
	else
		arg_31_0:refreshDownloadStateViews()
		arg_31_0:showDownloadRetryMsgBox(arg_31_2)
	end

	return
end

function var_0_0.showDownloadRetryMsgBox(arg_32_0, arg_32_1)
	local var_32_0

	if arg_32_1 then
		warning("gallery download failed:", tostring(arg_32_1))

		var_32_0 = {
			type = MSGBOX_TYPE_NORMAL,
			content = i18n("file_down_mgr_error", "", tostring(arg_32_1 or "")),
			onYes = function()
				if not arg_32_0.exited then
					arg_32_0:startDownloadGroup()
				end

				return
			end,
			onNo = function()
				if not arg_32_0.exited then
					arg_32_0.downloadFailed = false
					arg_32_0.downloadCount = 0
					arg_32_0.downloadTotal = 0

					arg_32_0:refreshDownloadStateViews()
				end

				return
			end
		}
	end

	function var_32_0.onClose()
		if not arg_32_0.exited then
			arg_32_0.downloadFailed = false
			arg_32_0.downloadCount = 0
			arg_32_0.downloadTotal = 0

			arg_32_0:refreshDownloadStateViews()
		end

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox(var_32_0)

	return
end

function var_0_0.tryShowTipMsgBox(arg_35_0)
	if arg_35_0.appreciateProxy:isGalleryHaveNewRes() then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			hideClose = true,
			content = i18n("res_pic_new_tip", GalleryConst.NewCount),
			onYes = function()
				PlayerPrefs.SetInt("galleryVersion", GalleryConst.Version)
				arg_35_0:emit(CollectionScene.UPDATE_RED_POINT)

				return
			end,
			onCancel = function()
				PlayerPrefs.SetInt("galleryVersion", GalleryConst.Version)
				arg_35_0:emit(CollectionScene.UPDATE_RED_POINT)

				return
			end,
			onClose = function()
				PlayerPrefs.SetInt("galleryVersion", GalleryConst.Version)
				arg_35_0:emit(CollectionScene.UPDATE_RED_POINT)

				return
			end
		})
	end

	return
end

function var_0_0.getPicInfoForShowByIndex(arg_37_0, arg_37_1)
	if arg_37_0.picInfoListForShow[arg_37_1] then
		return arg_37_0.picInfoListForShow[arg_37_1]
	elseif arg_37_0.picInfoListForShow[arg_37_1] == false then
		return false
	else
		assert(false, "不存在的Index:" .. tostring(arg_37_1))
	end

	return
end

function var_0_0.sortPicInfoListForShow(arg_38_0)
	table.sort(arg_38_0.picInfoListForShow, function(arg_39_0, arg_39_1)
		if arg_38_0.curPicSortValue == GalleryConst.Sort_Order_Up then
			return arg_39_0.id < arg_39_1.id
		elseif arg_38_0.curPicSortValue == GalleryConst.Sort_Order_Down then
			return arg_39_0.id >= arg_39_1.id
		end

		return
	end)

	return
end

function var_0_0.filterPicInfoForShow(arg_40_0)
	arg_40_0.hasMissingGalleryPic = false

	for iter_40_0, iter_40_1 in ipairs(pg.gallery_config.all) do
		if arg_40_0.appreciateProxy:getPicExistStateByID(iter_40_1) then
			({})[#{} + 1] = AppreciatePicConst.createPicInfo(AppreciatePicConst.TYPE_GALLERY, iter_40_1)
		else
			arg_40_0.hasMissingGalleryPic = true
		end
	end

	arg_40_0.hasExistingGalleryPic = #{} > 0

	return {}
end

function var_0_0.filterPicInfoForShowByLike(arg_41_0)
	if arg_41_0.curPicLikeValue == GalleryConst.Filte_Normal_Value then
		return arg_41_0.picInfoListForShow
	end

	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(arg_41_0.picInfoListForShow) do
		if GalleryConst.isGalleryLikeByID(iter_41_1.id) then
			var_41_0[#var_41_0 + 1] = iter_41_1
		end
	end

	return var_41_0
end

function var_0_0.filterPicInfoForShowBySet(arg_42_0)
	if arg_42_0.curPicSetValue == GalleryConst.Filte_Set_Normal_Value then
		return arg_42_0.picInfoListForShow
	end

	local var_42_0 = {}
	local var_42_1 = getProxy(LoadingPicProxy):getDiyModeOpenFlag()

	for iter_42_0, iter_42_1 in ipairs(arg_42_0.picInfoListForShow) do
		local var_42_2 = var_42_1 and AppreciatePicConst.isUsedPicInfo(iter_42_1) or iter_42_1.id > 1000

		if var_42_2 then
			var_42_0[#var_42_0 + 1] = iter_42_1
		end
	end

	return var_42_0
end

function var_0_0.filterPicInfoList(arg_43_0)
	arg_43_0.picInfoListForShow = arg_43_0:filterPicInfoForShow()
	arg_43_0.picInfoListForShow = arg_43_0:filterPicInfoForShowByLike(arg_43_0.curPicLikeValue)
	arg_43_0.picInfoListForShow = arg_43_0:filterPicInfoForShowBySet(arg_43_0.curPicSetValue)

	arg_43_0:sortPicInfoListForShow()

	if #arg_43_0.picInfoListForShow > 0 and arg_43_0.hasMissingGalleryPic and arg_43_0:isNeedShowDownBtn() then
		table.insert(arg_43_0.picInfoListForShow, 1, false)
	end

	return
end

function var_0_0.isNeedShowDownBtn(arg_44_0)
	if Application.isEditor then
		return false
	end

	if GroupHelper.IsGroupVerLastest(var_0_0.GalleryPicGroupName) then
		return false
	end

	if not GroupHelper.IsGroupWaitToUpdate(var_0_0.GalleryPicGroupName) then
		return false
	end

	return true
end

return var_0_0
