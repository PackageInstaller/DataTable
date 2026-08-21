local var_0_0 = class("AttireLoadingPicPanel", import("...base.BaseSubView"))

var_0_0.FilterMode = {
	Default = 2,
	All = 0,
	Selected = 1,
	Manga = 4,
	Gallery = 3
}

function var_0_0.getUIName(arg_1_0)
	return "attireloadingpicui"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initUIText()
	arg_2_0:autoSelectPanel()
	arg_2_0:enterEditMode(false)

	return
end

function var_0_0.Update(arg_3_0)
	return
end

function var_0_0.OnDestroy(arg_4_0)
	arg_4_0.resLoader:Clear()

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.resLoader = AutoLoader.New()
	arg_5_0.loadingPicProxy = getProxy(LoadingPicProxy)
	arg_5_0.picInfoList = arg_5_0:initPicInfoList()
	arg_5_0.curFilterMode = var_0_0.FilterMode.All
	arg_5_0.curPicInfoListForShow = arg_5_0:getCurPicInfoListForShow()
	arg_5_0.curUsedPicInfoList = arg_5_0:getUsedPicInfoList()
	arg_5_0.isEditMode = false
	arg_5_0.curEditPicInfoList = {}
	arg_5_0.isEditChanged = false
	arg_5_0.returnCount = 0

	return
end

function var_0_0.findUI(arg_6_0)
	arg_6_0.lScrollRectSC = arg_6_0.listTF:GetComponent("LScrollRect")

	arg_6_0.lScrollRectSC:BeginLayout()
	arg_6_0.lScrollRectSC:EndLayout()

	return
end

function var_0_0.addListener(arg_7_0)
	onButton(arg_7_0, arg_7_0.openShowBtn, function()
		({}).diyModeOpenFlag = true
		;({}).callback = function()
			arg_7_0:switchPanel(true, true)

			return
		end

		pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, {})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.closeShowBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("loading_quit_tip"),
			onYes = function()
				({}).diyModeOpenFlag = false
				;({}).callback = function()
					arg_7_0:switchPanel(false)

					return
				end

				pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, {})

				return
			end
		})
		pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, {
			diyModeOpenFlag = diyModeOpenFlag,
			callback = closeFunc
		})

		return
	end, SFX_PANEL)

	function arg_7_0.lScrollRectSC.onReturnItem(arg_13_0, arg_13_1)
		arg_7_0:checkReturnCount()

		return
	end

	function arg_7_0.lScrollRectSC.onInitItem(arg_14_0)
		return
	end

	function arg_7_0.lScrollRectSC.onUpdateItem(arg_15_0, arg_15_1)
		arg_15_0 = arg_15_0 + 1

		arg_7_0:updatePicTpl(arg_15_1, (arg_7_0:getCurPicInfoForShowByIndex(arg_15_0)))
		onButton(arg_7_0, arg_15_1, function()
			if arg_7_0.isEditMode then
				if arg_7_0:isPicInfoSelected(var_0) then
					arg_7_0:removePicInfoFromEditList(var_0)
				else
					arg_7_0:addPicInfoToEditList(var_0)
				end

				arg_7_0:updatePicTpl(arg_15_1, var_0)
				arg_7_0:updateCountText()
			else
				arg_7_0:openPicViewLayer(var_0)
			end

			return
		end, SFX_PANEL)

		return
	end

	onButton(arg_7_0, arg_7_0.openFilterBtn, function()
		arg_7_0:showFilterPanel(true)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.closeFilterBtn, function()
		arg_7_0:showFilterPanel(false)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.filterSelectedBtn, function()
		arg_7_0.curFilterMode = var_0_0.FilterMode.Selected
		arg_7_0.curPicInfoListForShow = arg_7_0:getCurPicInfoListForShow()

		arg_7_0:updateAllPicTplList()
		arg_7_0:showFilterPanel(false)
		arg_7_0:updateFilterBtn()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.filterDefaultBtn, function()
		arg_7_0.curFilterMode = var_0_0.FilterMode.Default
		arg_7_0.curPicInfoListForShow = arg_7_0:getCurPicInfoListForShow()

		arg_7_0:updateAllPicTplList()
		arg_7_0:showFilterPanel(false)
		arg_7_0:updateFilterBtn()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.filterGalleryBtn, function()
		arg_7_0.curFilterMode = var_0_0.FilterMode.Gallery
		arg_7_0.curPicInfoListForShow = arg_7_0:getCurPicInfoListForShow()

		arg_7_0:updateAllPicTplList()
		arg_7_0:showFilterPanel(false)
		arg_7_0:updateFilterBtn()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.filterMangaBtn, function()
		arg_7_0.curFilterMode = var_0_0.FilterMode.Manga
		arg_7_0.curPicInfoListForShow = arg_7_0:getCurPicInfoListForShow()

		arg_7_0:updateAllPicTplList()
		arg_7_0:showFilterPanel(false)
		arg_7_0:updateFilterBtn()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.filterAllBtn, function()
		arg_7_0.curFilterMode = var_0_0.FilterMode.All
		arg_7_0.curPicInfoListForShow = arg_7_0:getCurPicInfoListForShow()

		arg_7_0:updateAllPicTplList()
		arg_7_0:showFilterPanel(false)
		arg_7_0:updateFilterBtn()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.editBtn, function()
		if not arg_7_0.isEditMode then
			arg_7_0:enterEditMode(true)
		else
			local function var_24_0()
				arg_7_0:enterEditMode(false)

				return
			end

			if arg_7_0.isEditChanged then
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
	onButton(arg_7_0, arg_7_0.resetBtn, function()
		arg_7_0.curEditPicInfoList = arg_7_0:getDefaultPicInfoList()
		arg_7_0.isEditChanged = true

		arg_7_0:updateCurPicTplList()
		arg_7_0:updateCountText()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.clearBtn, function()
		arg_7_0.curEditPicInfoList = {}
		arg_7_0.isEditChanged = true

		arg_7_0:updateCurPicTplList()
		arg_7_0:updateCountText()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.confirmBtn, function()
		if #arg_7_0.curEditPicInfoList == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("loading_pic_min"))

			return
		end

		local var_29_0 = true

		for iter_29_0, iter_29_1 in ipairs(arg_7_0.curEditPicInfoList) do
			if iter_29_1.type == AppreciatePicConst.TYPE_GALLERY then
				table.insert({}, iter_29_1.id)
			elseif iter_29_1.type == AppreciatePicConst.TYPE_MANGA then
				table.insert({}, iter_29_1.id)
			end
		end

		pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC, {
			diyModeOpenFlag = var_29_0,
			galleryPicIDList = {},
			mangaPicIDList = {},
			callback = function()
				arg_7_0.isEditChanged = false
				arg_7_0.curPicInfoListForShow = arg_7_0:getCurPicInfoListForShow()

				arg_7_0:enterEditMode(false)
				arg_7_0:updateAllPicTplList()

				return
			end
		})

		return
	end, SFX_PANEL)
	arg_7_0.filterListTF:GetComponent(typeof(DftAniEvent)):SetCommonEvent(function(arg_31_0)
		if arg_31_0.stringParameter == "OnFilterMenuPanelClose" then
			setActive(arg_7_0.filterPanelTF, false)
		end

		return
	end)

	return
end

function var_0_0.initUIText(arg_32_0)
	setText(arg_32_0.emptyTitieText, i18n("loading_title"))
	setText(arg_32_0.emptyTipText, i18n("loading_picture_lack"))
	setText(arg_32_0.openShowBtnText, i18n("loading_start_set"))
	setText(arg_32_0.closeShowBtnText, i18n("loading_start_set"))
	setText(arg_32_0.showTitieText, i18n("loading_title"))
	setText(arg_32_0.countTipText, i18n("loading_pic_chosen"))
	setText(arg_32_0.emptyViewTipText, i18n("loading_chosen_blank"))

	return
end

function var_0_0.autoSelectPanel(arg_33_0)
	if arg_33_0.loadingPicProxy:getDiyModeOpenFlag() then
		arg_33_0:switchPanel(true)
	else
		arg_33_0:switchPanel(false)
	end

	return
end

function var_0_0.switchPanel(arg_34_0, arg_34_1, arg_34_2)
	if not arg_34_1 then
		setActive(arg_34_0.emptyPanelTF, true)
		setActive(arg_34_0.showPanelTF, false)
		quickPlayAnimation(arg_34_0._tf, "anim_AttireLoadingPicUI_not_select")
	elseif arg_34_1 and arg_34_2 then
		setActive(arg_34_0.emptyPanelTF, true)
		setActive(arg_34_0.showPanelTF, true)
		quickPlayAnimation(arg_34_0._tf, "anim_AttireLoadingPicUI_open")
	elseif arg_34_1 then
		setActive(arg_34_0.emptyPanelTF, false)
		setActive(arg_34_0.showPanelTF, true)
		quickPlayAnimation(arg_34_0._tf, "anim_AttireLoadingPicUI_select")
	end

	if arg_34_1 then
		arg_34_0:updateCountText()
		arg_34_0:updateAllPicTplList()
		arg_34_0:updateFilterBtn()
	end

	return
end

function var_0_0.updateCountText(arg_35_0)
	setText(arg_35_0.countNumText, string.format("%d/%d", #var_35_0, AppreciatePicConst.MAX_COUNT))

	return
end

function var_0_0.updateAllPicTplList(arg_36_0)
	arg_36_0.resLoader:Clear()
	setActive(arg_36_0.emptyViewTF, #arg_36_0.curPicInfoListForShow == 0)
	setActive(arg_36_0.scrollViewTF, #arg_36_0.curPicInfoListForShow > 0)

	if #arg_36_0.curPicInfoListForShow > 0 then
		arg_36_0.lScrollRectSC:SetTotalCount(#arg_36_0.curPicInfoListForShow)
	end

	return
end

function var_0_0.enterEditMode(arg_37_0, arg_37_1)
	arg_37_0.isEditMode = arg_37_1

	if arg_37_1 then
		arg_37_0.curEditPicInfoList = Clone(arg_37_0.curUsedPicInfoList)
	else
		arg_37_0.curEditPicInfoList = {}
		arg_37_0.curUsedPicInfoList = arg_37_0:getUsedPicInfoList()
	end

	arg_37_0.isEditChanged = false

	setActive(arg_37_0.clearBtn, arg_37_1)
	setActive(arg_37_0.confirmBtn, arg_37_1)
	setActive(arg_37_0.resetBtn, arg_37_1)
	arg_37_0:updateCurPicTplList()
	arg_37_0:updateCountText()

	return
end

function var_0_0.updatePicTpl(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0:updatePicTplForImg(arg_38_1, arg_38_2)
	arg_38_0:updatePicTplForTag(arg_38_1, arg_38_2)
	arg_38_0:updatePicTplForSelect(arg_38_1, arg_38_2)

	return
end

function var_0_0.updatePicTplForImg(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = findTF(arg_39_1, "Pic/Gallery")
	local var_39_1 = findTF(arg_39_1, "Pic/Manga/Image")

	setActive(var_39_0, arg_39_2.type == AppreciatePicConst.TYPE_GALLERY)
	setActive(var_39_1, arg_39_2.type == AppreciatePicConst.TYPE_MANGA)

	if arg_39_2.type == AppreciatePicConst.TYPE_GALLERY then
		arg_39_0:setImage(var_39_0, arg_39_2)
		setActive(findTF(arg_39_1, "Pic/Gallery"), true)
		setActive(findTF(arg_39_1, "Pic/Manga"), false)
	elseif arg_39_2.type == AppreciatePicConst.TYPE_MANGA then
		arg_39_0:setImage(var_39_1, arg_39_2)
		setActive(findTF(arg_39_1, "Pic/Gallery"), false)
		setActive(findTF(arg_39_1, "Pic/Manga"), true)
	end

	return
end

function var_0_0.updatePicTplForTag(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = findTF(arg_40_1, "Tag/Used")
	local var_40_1 = findTF(arg_40_1, "Tag/New")

	if arg_40_0.isEditMode then
		setActive(var_40_0, arg_40_0:isPicInfoSelected(arg_40_2))
	else
		setActive(var_40_0, arg_40_0:isPicInfoUsed(arg_40_2))
	end

	if isActive(var_40_0) then
		setActive(var_40_1, false)
	else
		setActive(var_40_1, arg_40_0:isNewPicInfo(arg_40_2))
	end

	return
end

function var_0_0.updatePicTplForSelect(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = findTF(arg_41_1, "Pic/Selected")

	if arg_41_0.isEditMode then
		setActive(var_41_0, arg_41_0:isPicInfoSelected(arg_41_2))
	else
		setActive(var_41_0, arg_41_0:isPicInfoUsed(arg_41_2))
	end

	return
end

function var_0_0.setImage(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = GetFileName(arg_42_2.path)
	local var_42_1 = GetComponent(arg_42_1, typeof(Image)).sprite

	if not IsNil(var_42_1) then
		if string.lower(var_42_1.name) ~= string.lower(var_42_0) then
			arg_42_0.resLoader:LoadSprite(arg_42_2.path, var_42_0, arg_42_1, false)
		end
	else
		arg_42_0.resLoader:LoadSprite(arg_42_2.path, var_42_0, arg_42_1, false)
	end

	return
end

function var_0_0.showFilterPanel(arg_43_0, arg_43_1)
	setActive(arg_43_0.filterPanelTF, true)

	if arg_43_1 then
		quickPlayAnimation(arg_43_0.filterListTF, "anim_FilterMenuPanel_open")
	else
		quickPlayAnimation(arg_43_0.filterListTF, "anim_FilterMenuPanel_close")
	end

	return
end

function var_0_0.openPicViewLayer(arg_44_0, arg_44_1)
	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = AppreciatePicViewMediator,
		viewComponent = AppreciatePicViewLayer,
		data = {
			curPicInfo = arg_44_1,
			picInfoList = arg_44_0.curPicInfoListForShow
		},
		onRemoved = function()
			arg_44_0.curUsedPicInfoList = arg_44_0:getUsedPicInfoList()

			arg_44_0:updateCurPicTplList()
			arg_44_0:updateCountText()

			return
		end
	}))

	return
end

function var_0_0.updateCurPicTplList(arg_46_0)
	for iter_46_0 = 1, arg_46_0.listTF.childCount do
		local var_46_0 = arg_46_0.listTF:GetChild(iter_46_0 - 1)
		local var_46_1 = go(var_46_0).name

		if var_46_1 ~= "-1" then
			arg_46_0:updatePicTpl(var_46_0, (arg_46_0:getCurPicInfoForShowByIndex(tonumber(var_46_1) + 1)))
		end
	end

	return
end

function var_0_0.checkReturnCount(arg_47_0)
	return
end

function var_0_0.updateFilterBtn(arg_48_0)
	local var_48_0 = findTF(arg_48_0.openFilterBtn, "Default")
	local var_48_1 = findTF(arg_48_0.openFilterBtn, "Gallery")
	local var_48_2 = findTF(arg_48_0.openFilterBtn, "Manga")
	local var_48_3 = findTF(arg_48_0.openFilterBtn, "Selected")

	setActive(findTF(arg_48_0.openFilterBtn, "ALL"), arg_48_0.curFilterMode == var_0_0.FilterMode.All)
	setActive(var_48_0, arg_48_0.curFilterMode == var_0_0.FilterMode.Default)
	setActive(var_48_1, arg_48_0.curFilterMode == var_0_0.FilterMode.Gallery)
	setActive(var_48_2, arg_48_0.curFilterMode == var_0_0.FilterMode.Manga)
	setActive(var_48_3, arg_48_0.curFilterMode == var_0_0.FilterMode.Selected)

	return
end

function var_0_0.initPicInfoList(arg_49_0)
	for iter_49_0, iter_49_1 in ipairs(pg.gallery_config.all) do
		if checkABExist((GalleryConst.GetGalleryPicPathByID(iter_49_1))) then
			table.insert({}, (AppreciatePicConst.createPicInfo(AppreciatePicConst.TYPE_GALLERY, iter_49_1)))
		end
	end

	for iter_49_2, iter_49_3 in ipairs(pg.cartoon.all) do
		if checkABExist((MangaConst.GetMangaPicPathByID(iter_49_3))) then
			table.insert({}, (AppreciatePicConst.createPicInfo(AppreciatePicConst.TYPE_MANGA, iter_49_3)))
		end
	end

	return {}
end

function var_0_0.getUsedPicInfoList(arg_50_0)
	for iter_50_0, iter_50_1 in ipairs(arg_50_0.picInfoList) do
		if arg_50_0:isPicInfoUsed(iter_50_1) then
			table.insert({}, iter_50_1)
		end
	end

	arg_50_0.curUsedPicInfoList = {}

	return {}
end

function var_0_0.isPicInfoUsed(arg_51_0, arg_51_1)
	return AppreciatePicConst.isUsedPicInfo(arg_51_1)
end

function var_0_0.isNewPicInfo(arg_52_0, arg_52_1)
	return AppreciatePicConst.isNewPicInfo(arg_52_1)
end

function var_0_0.isDefaultPicInfo(arg_53_0, arg_53_1)
	return arg_53_0:isGalleryPic(arg_53_1) and table.contains(AppreciatePicConst.getDefaultGalleryPicIDList(), arg_53_1.id)
end

function var_0_0.isGalleryPic(arg_54_0, arg_54_1)
	return arg_54_1.type == AppreciatePicConst.TYPE_GALLERY
end

function var_0_0.isMangaPic(arg_55_0, arg_55_1)
	return arg_55_1.type == AppreciatePicConst.TYPE_MANGA
end

function var_0_0.getPicInfoTypeSortWeight(arg_56_0, arg_56_1)
	if arg_56_0:isGalleryPic(arg_56_1) and not arg_56_0:isDefaultPicInfo(arg_56_1) then
		return 3
	elseif arg_56_0:isDefaultPicInfo(arg_56_1) then
		return 2
	elseif arg_56_0:isMangaPic(arg_56_1) then
		return 1
	end

	return 0
end

function var_0_0.isPicInfoSelected(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.isEditMode and arg_57_0.curEditPicInfoList or arg_57_0.curUsedPicInfoList

	for iter_57_0, iter_57_1 in ipairs(var_57_0) do
		if iter_57_1.id == arg_57_1.id and iter_57_1.type == arg_57_1.type then
			return true
		end
	end

	return false
end

function var_0_0.sortPicInfoList(arg_58_0, arg_58_1)
	table.sort(arg_58_1, function(arg_59_0, arg_59_1)
		local var_59_0 = arg_58_0:isNewPicInfo(arg_59_0)
		local var_59_1 = arg_58_0:isNewPicInfo(arg_59_1)

		if var_59_0 ~= var_59_1 then
			return var_59_0
		end

		local var_59_2 = arg_58_0:getPicInfoTypeSortWeight(arg_59_0)
		local var_59_3 = arg_58_0:getPicInfoTypeSortWeight(arg_59_1)

		if var_59_0 and var_59_1 then
			if var_59_2 ~= var_59_3 then
				return var_59_3 < var_59_2
			end

			return arg_59_0.id > arg_59_1.id
		end

		local var_59_4 = arg_58_0:isPicInfoUsed(arg_59_0)

		if var_59_4 ~= arg_58_0:isPicInfoUsed(arg_59_1) then
			return var_59_4
		end

		if var_59_2 ~= var_59_3 then
			return var_59_3 < var_59_2
		end

		return arg_59_0.id > arg_59_1.id
	end)

	return arg_58_1
end

function var_0_0.getCurPicInfoListForShow(arg_60_0)
	local var_60_0 = {}

	if arg_60_0.curFilterMode == var_0_0.FilterMode.All then
		var_60_0 = Clone(arg_60_0.picInfoList)
	elseif arg_60_0.curFilterMode == var_0_0.FilterMode.Selected then
		for iter_60_0, iter_60_1 in ipairs(arg_60_0.picInfoList) do
			if arg_60_0:isPicInfoSelected(iter_60_1) then
				table.insert(var_60_0, iter_60_1)
			end
		end
	elseif arg_60_0.curFilterMode == var_0_0.FilterMode.Gallery then
		for iter_60_2, iter_60_3 in ipairs(arg_60_0.picInfoList) do
			if arg_60_0:isGalleryPic(iter_60_3) and not arg_60_0:isDefaultPicInfo(iter_60_3) then
				table.insert(var_60_0, iter_60_3)
			end
		end
	elseif arg_60_0.curFilterMode == var_0_0.FilterMode.Manga then
		for iter_60_4, iter_60_5 in ipairs(arg_60_0.picInfoList) do
			if arg_60_0:isMangaPic(iter_60_5) then
				table.insert(var_60_0, iter_60_5)
			end
		end
	elseif arg_60_0.curFilterMode == var_0_0.FilterMode.Default then
		var_60_0 = arg_60_0:getDefaultPicInfoList()
	end

	local var_60_1 = arg_60_0:sortPicInfoList(var_60_0)

	arg_60_0.curPicInfoListForShow = var_60_1

	return var_60_1
end

function var_0_0.getDefaultPicInfoList(arg_61_0)
	for iter_61_0, iter_61_1 in ipairs((AppreciatePicConst.getDefaultGalleryPicIDList())) do
		if checkABExist((GalleryConst.GetGalleryPicPathByID(iter_61_1))) then
			table.insert({}, (AppreciatePicConst.createPicInfo(AppreciatePicConst.TYPE_GALLERY, iter_61_1)))
		end
	end

	return {}
end

function var_0_0.getCurPicInfoForShowByIndex(arg_62_0, arg_62_1)
	return arg_62_0.curPicInfoListForShow[arg_62_1]
end

function var_0_0.getPicInfoIndexInShowList(arg_63_0, arg_63_1)
	for iter_63_0, iter_63_1 in ipairs(arg_63_0.curPicInfoListForShow) do
		if iter_63_1.id == arg_63_1.id and iter_63_1.type == arg_63_1.type then
			return iter_63_0
		end
	end

	return 0
end

function var_0_0.removePicInfoFromEditList(arg_64_0, arg_64_1)
	for iter_64_0, iter_64_1 in ipairs(arg_64_0.curEditPicInfoList) do
		if iter_64_1.id == arg_64_1.id and iter_64_1.type == arg_64_1.type then
			table.remove(arg_64_0.curEditPicInfoList, iter_64_0)

			break
		end
	end

	arg_64_0.isEditChanged = true

	return
end

function var_0_0.addPicInfoToEditList(arg_65_0, arg_65_1)
	if #arg_65_0.curEditPicInfoList >= AppreciatePicConst.MAX_COUNT then
		pg.TipsMgr.GetInstance():ShowTips(i18n("loading_pic_max"))

		return
	end

	table.insert(arg_65_0.curEditPicInfoList, arg_65_1)

	arg_65_0.isEditChanged = true

	return
end

return var_0_0
