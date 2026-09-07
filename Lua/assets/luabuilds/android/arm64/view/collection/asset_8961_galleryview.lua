local GalleryView = class("GalleryView", import("..base.BaseSubView"))

GalleryView.GalleryPicGroupName = "GALLERY_PIC"

function GalleryView:getUIName()
	return "GalleryUI"
end

function GalleryView:OnInit()
	self:initData()
	self:findUI()
	self:addListener()

	self.galleryScrollView = GalleryScrollView.New(self.scrollPanel, self)
	self.galleryGridView = GalleryGridView.New(self.gridPanel, self)

	self:Show()
	self:refreshPicInfoList()
	self:tryShowTipMsgBox()

	return
end

function GalleryView:OnDestroy()
	if self.galleryScrollView then
		self.galleryScrollView:dispose()

		self.galleryScrollView = nil
	end

	if self.galleryGridView then
		self.galleryGridView:dispose()

		self.galleryGridView = nil
	end

	return
end

function GalleryView:onBackPressed()
	return true
end

function GalleryView:initData()
	self.appreciateProxy = getProxy(AppreciateProxy)

	self.appreciateProxy:checkPicFileState()

	self.picInfoListForShow = {}
	self.isDownloading = false
	self.downloadCount = 0
	self.downloadTotal = 0
	self.downloadFailed = false
	self.hasMissingGalleryPic = false
	self.hasExistingGalleryPic = false
	self.curViewMode = "scroll"
	self.curPicLikeValue = GalleryConst.Filte_Normal_Value
	self.curPicSetValue = GalleryConst.Filte_Set_Normal_Value
	self.curPicSortValue = GalleryConst.Sort_Order_Up

	return
end

function GalleryView:findUI()
	setLocalPosition(self._tf, Vector2.zero)

	self._tf.anchorMin = Vector2.zero
	self._tf.anchorMax = Vector2.one
	self._tf.offsetMax = Vector2.zero
	self._tf.offsetMin = Vector2.zero
	self.topPanel = self._tf:Find("TopPanel")
	self.setFilterToggle = self.topPanel:Find("List/SetFilterBtn")

	setText(self.setFilterToggle:Find("TextLikeOff"), i18n("loading_pic_btn"))
	setText(self.setFilterToggle:Find("TextLikeOn"), i18n("loading_pic_btn"))
	setActive(self.setFilterToggle, true)
	setActive(self.topPanel:Find("List/TimeFilterBtn"), false)

	self.likeFilterToggle = self.topPanel:Find("List/LikeFilterBtn")

	setActive(self.likeFilterToggle, true)

	self.likeNumText = self.likeFilterToggle:Find("TextNum")

	setActive(self.likeNumText, false)

	self.orderToggle = self.topPanel:Find("List/OrderBtn")
	self.resRepaireBtn = self.topPanel:Find("List/RepaireBtn")
	self.switchToGridBtn = self.topPanel:Find("SwitchToGridBtn")
	self.switchToScrollBtn = self.topPanel:Find("SwitchToScrollBtn")
	self.scrollPanel = self._tf:Find("Scroll")
	self.gridPanel = self._tf:Find("Grid")
	self.emptyPanel = self._tf:Find("EmptyPanel")
	self.updatePanel = self._tf:Find("UpdatePanel")

	return
end

function GalleryView:addListener()
	onToggle(self, self.orderToggle, function(arg_8_0)
		self.curPicSortValue = arg_8_0 == true and GalleryConst.Sort_Order_Down or GalleryConst.Sort_Order_Up

		self:refreshPicInfoList(true)

		return
	end, SFX_PANEL)
	onToggle(self, self.likeFilterToggle, function(arg_9_0)
		self.curPicLikeValue = arg_9_0 == true and GalleryConst.Filte_Like_Value or GalleryConst.Filte_Normal_Value

		self:refreshPicInfoList(true)

		return
	end)
	onToggle(self, self.setFilterToggle, function(arg_10_0)
		self.curPicSetValue = arg_10_0 == true and GalleryConst.Filte_Set_Value or GalleryConst.Filte_Set_Normal_Value

		self:refreshPicInfoList(true)

		return
	end)
	onButton(self, self.resRepaireBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideYes = true,
			content = i18n("resource_verify_warn"),
			custom = {
				{
					text = i18n("msgbox_repair"),
					onCallback = function()
						if PathMgr.FileExists(Application.persistentDataPath .. "/hashes-pic.csv") then
							BundleWizard.Inst:GetGroupMgr(GalleryView.GalleryPicGroupName):StartVerifyForLua()
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
	onButton(self, self.switchToGridBtn, function()
		self:switchViewMode("grid")

		return
	end, SFX_PANEL)
	onButton(self, self.switchToScrollBtn, function()
		self:switchViewMode("scroll")

		return
	end, SFX_PANEL)

	return
end

function GalleryView:refreshPicInfoList()
	self:filterPicInfoList()
	self:updateViewDisplay()

	return
end

function GalleryView:switchViewMode(arg_16_1)
	if self.curViewMode == arg_16_1 then
		return
	end

	self.curViewMode = arg_16_1

	self:resetActiveViewState()
	self:updateViewDisplay()

	return
end

function GalleryView:resetActiveViewState()
	if self.curViewMode == "scroll" and self.galleryScrollView then
		self.galleryScrollView:resetMiddleDataIndex()
	end

	return
end

function GalleryView:updateViewDisplay()
	local var_18_0 = #self.picInfoListForShow <= 0
	local var_18_1

	if #self.picInfoListForShow <= 0 then
		::label_18_0::

		var_18_1 = not self.hasExistingGalleryPic and self.hasMissingGalleryPic and self:isNeedShowDownBtn() or false
	else
		var_18_1 = true
	end

	local var_18_2 = self.curViewMode == "scroll"
	local var_18_3 = self.curViewMode == "grid"

	setActive(self.emptyPanel, var_18_0 and not var_18_1)
	setActive(self.updatePanel, var_18_1)
	setActive(self.scrollPanel, not var_18_0 and not var_18_1 and var_18_2)
	setActive(self.gridPanel, not var_18_0 and not var_18_1 and var_18_3)
	setActive(self.switchToGridBtn, var_18_2)
	setActive(self.switchToScrollBtn, var_18_3)

	if var_18_1 then
		self:initDownBtnPanel()
	elseif not var_18_0 then
		if var_18_3 then
			self.galleryGridView:refresh(self.picInfoListForShow)
		else
			self.galleryScrollView:refresh(self.picInfoListForShow)
		end
	end

	return
end

function GalleryView:initDownBtnPanel()
	local var_19_0 = self.updatePanel:Find("Btn")
	local var_19_1 = var_19_0:Find("Text")

	setActive(var_19_0, not self.isDownloading)
	setActive(self.updatePanel:Find("Progress"), self.isDownloading)

	if self.downloadFailed then
		setText(var_19_1, i18n("word_manga_updatefailure"))
	elseif self.isDownloading then
		local var_19_2, var_19_3 = self:getGalleryDownloadProgress()

		setText(var_19_1, i18n("word_manga_updating", var_19_2, var_19_3))
	else
		setText(var_19_1, i18n("word_manga_checktoupdate"))
	end

	onButton(self, var_19_0, function()
		self:showDownloadMsgBox()

		return
	end, SFX_PANEL)

	return
end

function GalleryView:isGalleryDownloading()
	return self.isDownloading
end

function GalleryView:isGalleryDownloadFailed()
	return self.downloadFailed
end

function GalleryView:getGalleryDownloadProgress()
	return self.downloadCount, self.downloadTotal
end

function GalleryView:refreshDownloadStateViews()
	if self.galleryScrollView then
		self.galleryScrollView:updateEmptyCardDownloadStateList()
	end

	if self.galleryGridView then
		self.galleryGridView:updateEmptyCardDownloadStateList()
	end

	if self.updatePanel and isActive(self.updatePanel) then
		self:initDownBtnPanel()
	end

	return
end

function GalleryView:showDownloadMsgBox()
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		type = MSGBOX_TYPE_NORMAL,
		content = string.format(i18n("group_download_tip", (HashUtil.BytesToString((GroupHelper.GetGroupSize(GalleryView.GalleryPicGroupName)))))),
		onYes = function()
			self:startDownloadGroup()

			return
		end
	})

	return
end

function GalleryView:startDownloadGroup()
	if self.isDownloading or self.exited then
		return
	end

	self.isDownloading = true
	self.downloadFailed = false
	self.downloadCount = 0
	self.downloadTotal = 0

	self:refreshDownloadStateViews()

	local var_27_0 = {
		GalleryView.GalleryPicGroupName
	}

	BundleWizardUpdater.Inst:StartUpdate((BundleWizardUpdater.Inst:CreateListInfo(table.concat(var_27_0, "_"), BundleWizardUpdater.Inst:GetFileList(var_27_0), nil, function(arg_29_0, arg_29_1)
		self:onDownloadFinish(arg_29_0, arg_29_1)

		return
	end, function(arg_28_0, arg_28_1, arg_28_2)
		self:onDownloadProgress(arg_28_0, arg_28_1, arg_28_2)

		return
	end)))

	return
end

function GalleryView:onDownloadProgress(arg_30_1, arg_30_2, arg_30_3)
	if self.exited then
		return
	end

	self.downloadCount = (arg_30_1 or 0) + (arg_30_2 or 0)
	self.downloadTotal = arg_30_3 or 0

	self:refreshDownloadStateViews()

	return
end

function GalleryView:onDownloadFinish(arg_31_1, arg_31_2)
	self.isDownloading = false
	self.downloadFailed = not arg_31_1

	if self.exited then
		return
	end

	if arg_31_1 then
		self.downloadCount = self.downloadTotal

		self.appreciateProxy:checkPicFileState()
		self:refreshDownloadStateViews()
		self:refreshPicInfoList()
	else
		self:refreshDownloadStateViews()
		self:showDownloadRetryMsgBox(arg_31_2)
	end

	return
end

function GalleryView:showDownloadRetryMsgBox(arg_32_1)
	if arg_32_1 then
		warning("gallery download failed:", tostring(arg_32_1))
	end

	local function var_32_0()
		if not self.exited then
			self.downloadFailed = false
			self.downloadCount = 0
			self.downloadTotal = 0

			self:refreshDownloadStateViews()
		end

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		type = MSGBOX_TYPE_NORMAL,
		content = i18n("file_down_mgr_error", "", tostring(arg_32_1 or "")),
		onYes = function()
			if not self.exited then
				self:startDownloadGroup()
			end

			return
		end,
		onNo = var_32_0,
		onClose = var_32_0
	})

	return
end

function GalleryView:tryShowTipMsgBox()
	if self.appreciateProxy:isGalleryHaveNewRes() then
		local function var_35_0()
			PlayerPrefs.SetInt("galleryVersion", GalleryConst.Version)
			self:emit(CollectionScene.UPDATE_RED_POINT)

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			hideClose = true,
			content = i18n("res_pic_new_tip", GalleryConst.NewCount),
			onYes = var_35_0,
			onCancel = var_35_0,
			onClose = var_35_0
		})
	end

	return
end

function GalleryView:getPicInfoForShowByIndex(arg_37_1)
	if self.picInfoListForShow[arg_37_1] then
		return self.picInfoListForShow[arg_37_1]
	elseif self.picInfoListForShow[arg_37_1] == false then
		return false
	else
		assert(false, "不存在的Index:" .. tostring(arg_37_1))
	end

	return
end

function GalleryView:sortPicInfoListForShow()
	table.sort(self.picInfoListForShow, function(arg_39_0, arg_39_1)
		if self.curPicSortValue == GalleryConst.Sort_Order_Up then
			return arg_39_0.id < arg_39_1.id
		elseif self.curPicSortValue == GalleryConst.Sort_Order_Down then
			return arg_39_0.id >= arg_39_1.id
		end

		return
	end)

	return
end

function GalleryView:filterPicInfoForShow()
	local var_40_0 = {}

	self.hasMissingGalleryPic = false

	for iter_40_0, iter_40_1 in ipairs(pg.gallery_config.all) do
		if self.appreciateProxy:getPicExistStateByID(iter_40_1) then
			var_40_0[#var_40_0 + 1] = AppreciatePicConst.createPicInfo(AppreciatePicConst.TYPE_GALLERY, iter_40_1)
		else
			self.hasMissingGalleryPic = true
		end
	end

	self.hasExistingGalleryPic = #var_40_0 > 0

	return var_40_0
end

function GalleryView:filterPicInfoForShowByLike()
	if self.curPicLikeValue == GalleryConst.Filte_Normal_Value then
		return self.picInfoListForShow
	end

	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(self.picInfoListForShow) do
		if GalleryConst.isGalleryLikeByID(iter_41_1.id) then
			var_41_0[#var_41_0 + 1] = iter_41_1
		end
	end

	return var_41_0
end

function GalleryView:filterPicInfoForShowBySet()
	if self.curPicSetValue == GalleryConst.Filte_Set_Normal_Value then
		return self.picInfoListForShow
	end

	local var_42_0 = {}
	local var_42_1 = getProxy(LoadingPicProxy):getDiyModeOpenFlag()

	for iter_42_0, iter_42_1 in ipairs(self.picInfoListForShow) do
		if var_42_1 and AppreciatePicConst.isUsedPicInfo(iter_42_1) or iter_42_1.id > 1000 then
			var_42_0[#var_42_0 + 1] = iter_42_1
		end
	end

	return var_42_0
end

function GalleryView:filterPicInfoList()
	self.picInfoListForShow = self:filterPicInfoForShow()
	self.picInfoListForShow = self:filterPicInfoForShowByLike(self.curPicLikeValue)
	self.picInfoListForShow = self:filterPicInfoForShowBySet(self.curPicSetValue)

	self:sortPicInfoListForShow()

	if #self.picInfoListForShow > 0 and self.hasMissingGalleryPic and self:isNeedShowDownBtn() then
		table.insert(self.picInfoListForShow, 1, false)
	end

	return
end

function GalleryView:isNeedShowDownBtn()
	if Application.isEditor then
		return false
	end

	if GroupHelper.IsGroupVerLastest(GalleryView.GalleryPicGroupName) then
		return false
	end

	if not GroupHelper.IsGroupWaitToUpdate(GalleryView.GalleryPicGroupName) then
		return false
	end

	return true
end

return GalleryView
