local AttireLoadingPicPanel = class("AttireLoadingPicPanel", import("...base.BaseSubView"))

AttireLoadingPicPanel.FilterMode = {
	Default = 2,
	All = 0,
	Selected = 1,
	Manga = 4,
	Gallery = 3
}

function AttireLoadingPicPanel:getUIName()
	return "attireloadingpicui"
end

function AttireLoadingPicPanel:OnInit()
	self:initData()
	self:findUI()
	self:addListener()
	self:initUIText()
	self:autoSelectPanel()
	self:enterEditMode(false)

	return
end

function AttireLoadingPicPanel:Update()
	return
end

function AttireLoadingPicPanel:OnDestroy()
	self.resLoader:Clear()

	return
end

function AttireLoadingPicPanel:initData()
	self.resLoader = AutoLoader.New()
	self.loadingPicProxy = getProxy(LoadingPicProxy)
	self.picInfoList = self:initPicInfoList()
	self.curFilterMode = AttireLoadingPicPanel.FilterMode.All
	self.curPicInfoListForShow = self:getCurPicInfoListForShow()
	self.curUsedPicInfoList = self:getUsedPicInfoList()
	self.isEditMode = false
	self.curEditPicInfoList = {}
	self.isEditChanged = false
	self.returnCount = 0

	return
end

function AttireLoadingPicPanel:findUI()
	self.lScrollRectSC = self.listTF:GetComponent("LScrollRect")

	self.lScrollRectSC:BeginLayout()
	self.lScrollRectSC:EndLayout()

	return
end

function AttireLoadingPicPanel:addListener()
	onButton(self, self.openShowBtn, function()
		local var_8_0 = {}

		var_8_0.diyModeOpenFlag = true

		function var_8_0.callback()
			self:switchPanel(true, true)

			return
		end

		pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, var_8_0)

		return
	end, SFX_PANEL)
	onButton(self, self.closeShowBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("loading_quit_tip"),
			onYes = function()
				local var_11_0 = {}

				var_11_0.diyModeOpenFlag = false

				function var_11_0.callback()
					self:switchPanel(false)

					return
				end

				pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, var_11_0)

				return
			end
		})
		pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, {
			diyModeOpenFlag = diyModeOpenFlag,
			callback = closeFunc
		})

		return
	end, SFX_PANEL)

	function self.lScrollRectSC.onReturnItem(arg_13_0, arg_13_1)
		self:checkReturnCount()

		return
	end

	function self.lScrollRectSC.onInitItem(arg_14_0)
		return
	end

	function self.lScrollRectSC.onUpdateItem(arg_15_0, arg_15_1)
		arg_15_0 = arg_15_0 + 1

		local var_15_0 = self:getCurPicInfoForShowByIndex(arg_15_0)

		self:updatePicTpl(arg_15_1, var_15_0)
		onButton(self, arg_15_1, function()
			if self.isEditMode then
				if self:isPicInfoSelected(var_15_0) then
					self:removePicInfoFromEditList(var_15_0)
				else
					self:addPicInfoToEditList(var_15_0)
				end

				self:updatePicTpl(arg_15_1, var_15_0)
				self:updateCountText()
			else
				self:openPicViewLayer(var_15_0)
			end

			return
		end, SFX_PANEL)

		return
	end

	onButton(self, self.openFilterBtn, function()
		self:showFilterPanel(true)

		return
	end, SFX_PANEL)
	onButton(self, self.closeFilterBtn, function()
		self:showFilterPanel(false)

		return
	end, SFX_PANEL)
	onButton(self, self.filterSelectedBtn, function()
		self.curFilterMode = AttireLoadingPicPanel.FilterMode.Selected
		self.curPicInfoListForShow = self:getCurPicInfoListForShow()

		self:updateAllPicTplList()
		self:showFilterPanel(false)
		self:updateFilterBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.filterDefaultBtn, function()
		self.curFilterMode = AttireLoadingPicPanel.FilterMode.Default
		self.curPicInfoListForShow = self:getCurPicInfoListForShow()

		self:updateAllPicTplList()
		self:showFilterPanel(false)
		self:updateFilterBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.filterGalleryBtn, function()
		self.curFilterMode = AttireLoadingPicPanel.FilterMode.Gallery
		self.curPicInfoListForShow = self:getCurPicInfoListForShow()

		self:updateAllPicTplList()
		self:showFilterPanel(false)
		self:updateFilterBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.filterMangaBtn, function()
		self.curFilterMode = AttireLoadingPicPanel.FilterMode.Manga
		self.curPicInfoListForShow = self:getCurPicInfoListForShow()

		self:updateAllPicTplList()
		self:showFilterPanel(false)
		self:updateFilterBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.filterAllBtn, function()
		self.curFilterMode = AttireLoadingPicPanel.FilterMode.All
		self.curPicInfoListForShow = self:getCurPicInfoListForShow()

		self:updateAllPicTplList()
		self:showFilterPanel(false)
		self:updateFilterBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.editBtn, function()
		if not self.isEditMode then
			self:enterEditMode(true)
		else
			local function var_24_0()
				self:enterEditMode(false)

				return
			end

			if self.isEditChanged then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("loading_pic_tip"),
					onYes = function()
						var_24_0()

						return
					end
				})
			else
				var_24_0()
			end
		end

		return
	end)
	onButton(self, self.resetBtn, function()
		self.curEditPicInfoList = self:getDefaultPicInfoList()
		self.isEditChanged = true

		self:updateCurPicTplList()
		self:updateCountText()

		return
	end, SFX_PANEL)
	onButton(self, self.clearBtn, function()
		self.curEditPicInfoList = {}
		self.isEditChanged = true

		self:updateCurPicTplList()
		self:updateCountText()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if #self.curEditPicInfoList == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("loading_pic_min"))

			return
		end

		local var_29_0 = true
		local var_29_1 = {}
		local var_29_2 = {}

		for iter_29_0, iter_29_1 in ipairs(self.curEditPicInfoList) do
			if iter_29_1.type == AppreciatePicConst.TYPE_GALLERY then
				table.insert(var_29_1, iter_29_1.id)
			elseif iter_29_1.type == AppreciatePicConst.TYPE_MANGA then
				table.insert(var_29_2, iter_29_1.id)
			end
		end

		pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, {
			diyModeOpenFlag = var_29_0,
			galleryPicIDList = var_29_1,
			mangaPicIDList = var_29_2,
			callback = function()
				self.isEditChanged = false
				self.curPicInfoListForShow = self:getCurPicInfoListForShow()

				self:enterEditMode(false)
				self:updateAllPicTplList()

				return
			end
		})

		return
	end, SFX_PANEL)
	self.filterListTF:GetComponent(typeof(DftAniEvent)):SetCommonEvent(function(arg_31_0)
		if arg_31_0.stringParameter == "OnFilterMenuPanelClose" then
			setActive(self.filterPanelTF, false)
		end

		return
	end)

	return
end

function AttireLoadingPicPanel:initUIText()
	setText(self.emptyTitieText, i18n("loading_title"))
	setText(self.emptyTipText, i18n("loading_picture_lack"))
	setText(self.openShowBtnText, i18n("loading_start_set"))
	setText(self.closeShowBtnText, i18n("loading_start_set"))
	setText(self.showTitieText, i18n("loading_title"))
	setText(self.countTipText, i18n("loading_pic_chosen"))
	setText(self.emptyViewTipText, i18n("loading_chosen_blank"))

	return
end

function AttireLoadingPicPanel:autoSelectPanel()
	if self.loadingPicProxy:getDiyModeOpenFlag() then
		self:switchPanel(true)
	else
		self:switchPanel(false)
	end

	return
end

function AttireLoadingPicPanel:switchPanel(arg_34_1, arg_34_2)
	if not arg_34_1 then
		setActive(self.emptyPanelTF, true)
		setActive(self.showPanelTF, false)
		quickPlayAnimation(self._tf, "anim_AttireLoadingPicUI_not_select")
	elseif arg_34_1 and arg_34_2 then
		setActive(self.emptyPanelTF, true)
		setActive(self.showPanelTF, true)
		quickPlayAnimation(self._tf, "anim_AttireLoadingPicUI_open")
	elseif arg_34_1 then
		setActive(self.emptyPanelTF, false)
		setActive(self.showPanelTF, true)
		quickPlayAnimation(self._tf, "anim_AttireLoadingPicUI_select")
	end

	if arg_34_1 then
		self:updateCountText()
		self:updateAllPicTplList()
		self:updateFilterBtn()
	end

	return
end

function AttireLoadingPicPanel:updateCountText()
	setText(self.countNumText, string.format("%d/%d", #(self.isEditMode and self.curEditPicInfoList or self.curUsedPicInfoList), AppreciatePicConst.MAX_COUNT))

	return
end

function AttireLoadingPicPanel:updateAllPicTplList()
	self.resLoader:Clear()
	setActive(self.emptyViewTF, #self.curPicInfoListForShow == 0)
	setActive(self.scrollViewTF, #self.curPicInfoListForShow > 0)

	if #self.curPicInfoListForShow > 0 then
		self.lScrollRectSC:SetTotalCount(#self.curPicInfoListForShow)
	end

	return
end

function AttireLoadingPicPanel:enterEditMode(arg_37_1)
	self.isEditMode = arg_37_1

	if arg_37_1 then
		self.curEditPicInfoList = Clone(self.curUsedPicInfoList)
	else
		self.curEditPicInfoList = {}
		self.curUsedPicInfoList = self:getUsedPicInfoList()
	end

	self.isEditChanged = false

	setActive(self.clearBtn, arg_37_1)
	setActive(self.confirmBtn, arg_37_1)
	setActive(self.resetBtn, arg_37_1)
	self:updateCurPicTplList()
	self:updateCountText()

	return
end

function AttireLoadingPicPanel:updatePicTpl(arg_38_1, arg_38_2)
	self:updatePicTplForImg(arg_38_1, arg_38_2)
	self:updatePicTplForTag(arg_38_1, arg_38_2)
	self:updatePicTplForSelect(arg_38_1, arg_38_2)

	return
end

function AttireLoadingPicPanel:updatePicTplForImg(arg_39_1, arg_39_2)
	local var_39_0 = findTF(arg_39_1, "Pic/Gallery")
	local var_39_1 = findTF(arg_39_1, "Pic/Manga/Image")

	setActive(var_39_0, arg_39_2.type == AppreciatePicConst.TYPE_GALLERY)
	setActive(var_39_1, arg_39_2.type == AppreciatePicConst.TYPE_MANGA)

	if arg_39_2.type == AppreciatePicConst.TYPE_GALLERY then
		self:setImage(var_39_0, arg_39_2)
		setActive(findTF(arg_39_1, "Pic/Gallery"), true)
		setActive(findTF(arg_39_1, "Pic/Manga"), false)
	elseif arg_39_2.type == AppreciatePicConst.TYPE_MANGA then
		self:setImage(var_39_1, arg_39_2)
		setActive(findTF(arg_39_1, "Pic/Gallery"), false)
		setActive(findTF(arg_39_1, "Pic/Manga"), true)
	end

	return
end

function AttireLoadingPicPanel:updatePicTplForTag(arg_40_1, arg_40_2)
	local var_40_0 = findTF(arg_40_1, "Tag/Used")
	local var_40_1 = findTF(arg_40_1, "Tag/New")

	if self.isEditMode then
		setActive(var_40_0, self:isPicInfoSelected(arg_40_2))
	else
		setActive(var_40_0, self:isPicInfoUsed(arg_40_2))
	end

	if isActive(var_40_0) then
		setActive(var_40_1, false)
	else
		setActive(var_40_1, self:isNewPicInfo(arg_40_2))
	end

	return
end

function AttireLoadingPicPanel:updatePicTplForSelect(arg_41_1, arg_41_2)
	local var_41_0 = findTF(arg_41_1, "Pic/Selected")

	if self.isEditMode then
		setActive(var_41_0, self:isPicInfoSelected(arg_41_2))
	else
		setActive(var_41_0, self:isPicInfoUsed(arg_41_2))
	end

	return
end

function AttireLoadingPicPanel:setImage(arg_42_1, arg_42_2)
	local var_42_0 = GetFileName(arg_42_2.path)
	local var_42_1 = GetComponent(arg_42_1, typeof(Image)).sprite

	if not IsNil(var_42_1) then
		if string.lower(var_42_1.name) ~= string.lower(var_42_0) then
			self.resLoader:LoadSprite(arg_42_2.path, var_42_0, arg_42_1, false)
		end
	else
		self.resLoader:LoadSprite(arg_42_2.path, var_42_0, arg_42_1, false)
	end

	return
end

function AttireLoadingPicPanel:showFilterPanel(arg_43_1)
	setActive(self.filterPanelTF, true)

	if arg_43_1 then
		quickPlayAnimation(self.filterListTF, "anim_FilterMenuPanel_open")
	else
		quickPlayAnimation(self.filterListTF, "anim_FilterMenuPanel_close")
	end

	return
end

function AttireLoadingPicPanel:openPicViewLayer(arg_44_1)
	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = AppreciatePicViewMediator,
		viewComponent = AppreciatePicViewLayer,
		data = {
			curPicInfo = arg_44_1,
			picInfoList = self.curPicInfoListForShow
		},
		onRemoved = function()
			self.curUsedPicInfoList = self:getUsedPicInfoList()

			self:updateCurPicTplList()
			self:updateCountText()

			return
		end
	}))

	return
end

function AttireLoadingPicPanel:updateCurPicTplList()
	for iter_46_0 = 1, self.listTF.childCount do
		local var_46_0 = self.listTF:GetChild(iter_46_0 - 1)
		local var_46_1 = go(var_46_0).name

		if var_46_1 ~= "-1" then
			self:updatePicTpl(var_46_0, (self:getCurPicInfoForShowByIndex(tonumber(var_46_1) + 1)))
		end
	end

	return
end

function AttireLoadingPicPanel:checkReturnCount()
	return
end

function AttireLoadingPicPanel:updateFilterBtn()
	local var_48_0 = findTF(self.openFilterBtn, "Default")
	local var_48_1 = findTF(self.openFilterBtn, "Gallery")
	local var_48_2 = findTF(self.openFilterBtn, "Manga")
	local var_48_3 = findTF(self.openFilterBtn, "Selected")

	setActive(findTF(self.openFilterBtn, "ALL"), self.curFilterMode == AttireLoadingPicPanel.FilterMode.All)
	setActive(var_48_0, self.curFilterMode == AttireLoadingPicPanel.FilterMode.Default)
	setActive(var_48_1, self.curFilterMode == AttireLoadingPicPanel.FilterMode.Gallery)
	setActive(var_48_2, self.curFilterMode == AttireLoadingPicPanel.FilterMode.Manga)
	setActive(var_48_3, self.curFilterMode == AttireLoadingPicPanel.FilterMode.Selected)

	return
end

function AttireLoadingPicPanel:initPicInfoList()
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in ipairs(pg.gallery_config.all) do
		if checkABExist((GalleryConst.GetGalleryPicPathByID(iter_49_1))) then
			table.insert(var_49_0, (AppreciatePicConst.createPicInfo(AppreciatePicConst.TYPE_GALLERY, iter_49_1)))
		end
	end

	for iter_49_2, iter_49_3 in ipairs(pg.cartoon.all) do
		if checkABExist((MangaConst.GetMangaPicPathByID(iter_49_3))) then
			table.insert(var_49_0, (AppreciatePicConst.createPicInfo(AppreciatePicConst.TYPE_MANGA, iter_49_3)))
		end
	end

	return var_49_0
end

function AttireLoadingPicPanel:getUsedPicInfoList()
	local var_50_0 = {}

	for iter_50_0, iter_50_1 in ipairs(self.picInfoList) do
		if self:isPicInfoUsed(iter_50_1) then
			table.insert(var_50_0, iter_50_1)
		end
	end

	self.curUsedPicInfoList = var_50_0

	return var_50_0
end

function AttireLoadingPicPanel:isPicInfoUsed(arg_51_1)
	return AppreciatePicConst.isUsedPicInfo(arg_51_1)
end

function AttireLoadingPicPanel:isNewPicInfo(arg_52_1)
	return AppreciatePicConst.isNewPicInfo(arg_52_1)
end

function AttireLoadingPicPanel:isDefaultPicInfo(arg_53_1)
	return self:isGalleryPic(arg_53_1) and table.contains(AppreciatePicConst.getDefaultGalleryPicIDList(), arg_53_1.id)
end

function AttireLoadingPicPanel:isGalleryPic(arg_54_1)
	return arg_54_1.type == AppreciatePicConst.TYPE_GALLERY
end

function AttireLoadingPicPanel:isMangaPic(arg_55_1)
	return arg_55_1.type == AppreciatePicConst.TYPE_MANGA
end

function AttireLoadingPicPanel:getPicInfoTypeSortWeight(arg_56_1)
	if self:isGalleryPic(arg_56_1) and not self:isDefaultPicInfo(arg_56_1) then
		return 3
	elseif self:isDefaultPicInfo(arg_56_1) then
		return 2
	elseif self:isMangaPic(arg_56_1) then
		return 1
	end

	return 0
end

function AttireLoadingPicPanel:isPicInfoSelected(arg_57_1)
	for iter_57_0, iter_57_1 in ipairs(self.isEditMode and self.curEditPicInfoList or self.curUsedPicInfoList) do
		if iter_57_1.id == arg_57_1.id and iter_57_1.type == arg_57_1.type then
			return true
		end
	end

	return false
end

function AttireLoadingPicPanel:sortPicInfoList(arg_58_1)
	table.sort(arg_58_1, function(arg_59_0, arg_59_1)
		local var_59_0 = self:isNewPicInfo(arg_59_0)
		local var_59_1 = self:isNewPicInfo(arg_59_1)

		if var_59_0 ~= var_59_1 then
			return var_59_0
		end

		local var_59_2 = self:getPicInfoTypeSortWeight(arg_59_0)
		local var_59_3 = self:getPicInfoTypeSortWeight(arg_59_1)

		if var_59_0 and var_59_1 then
			if var_59_2 ~= var_59_3 then
				return var_59_3 < var_59_2
			end

			return arg_59_0.id > arg_59_1.id
		end

		local var_59_4 = self:isPicInfoUsed(arg_59_0)

		if var_59_4 ~= self:isPicInfoUsed(arg_59_1) then
			return var_59_4
		end

		if var_59_2 ~= var_59_3 then
			return var_59_3 < var_59_2
		end

		return arg_59_0.id > arg_59_1.id
	end)

	return arg_58_1
end

function AttireLoadingPicPanel:getCurPicInfoListForShow()
	local var_60_0 = {}

	if self.curFilterMode == AttireLoadingPicPanel.FilterMode.All then
		var_60_0 = Clone(self.picInfoList)
	elseif self.curFilterMode == AttireLoadingPicPanel.FilterMode.Selected then
		for iter_60_0, iter_60_1 in ipairs(self.picInfoList) do
			if self:isPicInfoSelected(iter_60_1) then
				table.insert(var_60_0, iter_60_1)
			end
		end
	elseif self.curFilterMode == AttireLoadingPicPanel.FilterMode.Gallery then
		for iter_60_2, iter_60_3 in ipairs(self.picInfoList) do
			if self:isGalleryPic(iter_60_3) and not self:isDefaultPicInfo(iter_60_3) then
				table.insert(var_60_0, iter_60_3)
			end
		end
	elseif self.curFilterMode == AttireLoadingPicPanel.FilterMode.Manga then
		for iter_60_4, iter_60_5 in ipairs(self.picInfoList) do
			if self:isMangaPic(iter_60_5) then
				table.insert(var_60_0, iter_60_5)
			end
		end
	elseif self.curFilterMode == AttireLoadingPicPanel.FilterMode.Default then
		var_60_0 = self:getDefaultPicInfoList()
	end

	local var_60_1 = self:sortPicInfoList(var_60_0)

	self.curPicInfoListForShow = var_60_1

	return var_60_1
end

function AttireLoadingPicPanel:getDefaultPicInfoList()
	local var_61_0 = {}

	for iter_61_0, iter_61_1 in ipairs((AppreciatePicConst.getDefaultGalleryPicIDList())) do
		if checkABExist((GalleryConst.GetGalleryPicPathByID(iter_61_1))) then
			table.insert(var_61_0, (AppreciatePicConst.createPicInfo(AppreciatePicConst.TYPE_GALLERY, iter_61_1)))
		end
	end

	return var_61_0
end

function AttireLoadingPicPanel:getCurPicInfoForShowByIndex(arg_62_1)
	return self.curPicInfoListForShow[arg_62_1]
end

function AttireLoadingPicPanel:getPicInfoIndexInShowList(arg_63_1)
	for iter_63_0, iter_63_1 in ipairs(self.curPicInfoListForShow) do
		if iter_63_1.id == arg_63_1.id and iter_63_1.type == arg_63_1.type then
			return iter_63_0
		end
	end

	return 0
end

function AttireLoadingPicPanel:removePicInfoFromEditList(arg_64_1)
	for iter_64_0, iter_64_1 in ipairs(self.curEditPicInfoList) do
		if iter_64_1.id == arg_64_1.id and iter_64_1.type == arg_64_1.type then
			table.remove(self.curEditPicInfoList, iter_64_0)

			break
		end
	end

	self.isEditChanged = true

	return
end

function AttireLoadingPicPanel:addPicInfoToEditList(arg_65_1)
	if #self.curEditPicInfoList >= AppreciatePicConst.MAX_COUNT then
		pg.TipsMgr.GetInstance():ShowTips(i18n("loading_pic_max"))

		return
	end

	table.insert(self.curEditPicInfoList, arg_65_1)

	self.isEditChanged = true

	return
end

return AttireLoadingPicPanel
