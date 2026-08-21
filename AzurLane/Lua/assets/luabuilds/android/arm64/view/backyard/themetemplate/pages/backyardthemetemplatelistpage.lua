local var_0_0 = class("BackYardThemeTemplateListPage", import("...Shop.pages.BackYardThemePage"))

var_0_0.nextClickRefreshTime = 0

function var_0_0.getUIName(arg_1_0)
	return "BackYardThemeTemplateThemePage"
end

function var_0_0.LoadDetail(arg_2_0)
	setActive(arg_2_0._tf:Find("adpter/descript"), false)

	return
end

function var_0_0.OnInit(arg_3_0)
	var_0_0.super.OnInit(arg_3_0)

	arg_3_0.tipBg = arg_3_0._tf:Find("tip")
	arg_3_0.tips = {
		arg_3_0._tf:Find("tip1"),
		arg_3_0._tf:Find("tip2"),
		arg_3_0._tf:Find("tip3")
	}
	arg_3_0.goBtn = arg_3_0._tf:Find("go_btn")
	arg_3_0.helpBtn = arg_3_0._tf:Find("adpter/help")
	arg_3_0.rawImage = arg_3_0._tf:Find("preview_raw"):GetComponent(typeof(RawImage))
	arg_3_0.listRect = arg_3_0._tf:Find("list/frame")
	arg_3_0.refreshBtns = arg_3_0._tf:Find("adpter/refresh_btns")
	arg_3_0.btns = {
		[5] = arg_3_0.refreshBtns:Find("random"),
		[3] = arg_3_0.refreshBtns:Find("hot"),
		[2] = arg_3_0.refreshBtns:Find("new")
	}

	setText(arg_3_0.refreshBtns:Find("random/Text"), i18n("word_random"))
	setText(arg_3_0.refreshBtns:Find("random/sel/Text"), i18n("word_random"))
	setText(arg_3_0.refreshBtns:Find("hot/Text"), i18n("word_hot"))
	setText(arg_3_0.refreshBtns:Find("hot/sel/Text"), i18n("word_hot"))
	setText(arg_3_0.refreshBtns:Find("new/Text"), i18n("word_new"))
	setText(arg_3_0.refreshBtns:Find("new/sel/Text"), i18n("word_new"))

	for iter_3_0, iter_3_1 in pairs(arg_3_0.btns) do
		onButton(arg_3_0, iter_3_1, function()
			if arg_3_0:CanClickRefBtn(iter_3_0) then
				if arg_3_0.selectedRefBtn then
					setActive(arg_3_0.selectedRefBtn:Find("sel"), false)
					setActive(arg_3_0.selectedRefBtn:Find("Text"), true)
				end

				setActive(iter_3_1:Find("sel"), true)
				setActive(iter_3_1:Find("Text"), false)
				arg_3_0:SwitchPage(iter_3_0, 1)

				arg_3_0.selectedRefBtn = iter_3_1
			end

			return
		end, SFX_PANEL)
	end

	onButton(arg_3_0, arg_3_0.helpBtn, function()
		_backYardThemeTemplateMsgbox:ShowHelp({
			helps = pg.gametip.backyard_theme_template_shop_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		arg_3_0:emit(NewBackYardThemeTemplateMediator.GO_DECORATION)

		return
	end, SFX_PANEL)
	arg_3_0.scrollRect.onValueChanged:RemoveAllListeners()

	arg_3_0.arrLeftBtnShop = arg_3_0._tf:Find("list/frame/zuobian_shop")
	arg_3_0.arrRightBtnShop = arg_3_0._tf:Find("list/frame/youbian_shop")

	onButton(arg_3_0, arg_3_0.arrLeftBtnShop, function()
		if arg_3_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
			local var_7_0 = getProxy(DormProxy).PAGE

			if var_7_0 > 1 then
				arg_3_0:SwitchPage(getProxy(DormProxy).TYPE, var_7_0 - 1, true)
			end
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.arrRightBtnShop, function()
		if arg_3_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
			getProxy(DormProxy).ClickPage = true

			arg_3_0:SwitchPage(getProxy(DormProxy).TYPE, getProxy(DormProxy).PAGE + 1, true)
		end

		return
	end, SFX_PANEL)

	local function var_3_0()
		if arg_3_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
			arg_3_0:emit(NewBackYardThemeTemplateMediator.ON_GET_SPCAIL_TYPE_TEMPLATE, (BackYardConst.ThemeSortIndex2ServerIndex(arg_3_0.sortIndex, arg_3_0.asc)))
		else
			arg_3_0:SetTotalCount()
		end

		return
	end

	arg_3_0.descPages = BackYardThemeTemplateDescPage.New(arg_3_0._tf, arg_3_0.event, arg_3_0.contextData)

	function arg_3_0.descPages.OnSortChange(arg_10_0)
		arg_3_0.asc = arg_10_0

		var_3_0()

		return
	end

	arg_3_0.contextData.infoPage = BackYardThemeTemplateInfoPage.New(arg_3_0._parentTf, arg_3_0.event, arg_3_0.contextData)
	arg_3_0.contextData.furnitureMsgBox = BackYardFurnitureMsgBoxPage.New(arg_3_0._parentTf, arg_3_0.event, arg_3_0.contextData)
	arg_3_0.contextData.themeMsgBox = BackYardThemeTemplatePurchaseMsgbox.New(arg_3_0._parentTf, arg_3_0.event, arg_3_0.contextData)

	setText(arg_3_0.goBtn:Find("Text"), i18n("courtyard_label_go"))
	setText(arg_3_0._tf:Find("tip1"), i18n("courtyard_label_empty_template_list"))
	setText(arg_3_0._tf:Find("tip2"), i18n("courtyard_label_empty_custom_template_list"))
	setText(arg_3_0._tf:Find("tip3"), i18n("courtyard_label_empty_collection_list"))

	return
end

function var_0_0.InitInput(arg_11_0)
	onInputChanged(arg_11_0, arg_11_0.searchInput, function()
		setActive(arg_11_0.searchClear, getInputText(arg_11_0.searchInput) ~= "")

		return
	end)
	onInputEndEdit(arg_11_0, arg_11_0.searchInput, function()
		arg_11_0:OnSearchKeyChange()

		return
	end)

	return
end

function var_0_0.UpdateArr(arg_14_0)
	if arg_14_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		local var_14_0 = getProxy(DormProxy).PAGE
		local var_14_1 = getProxy(DormProxy).lastPages[getProxy(DormProxy).TYPE]
		local var_14_2 = getProxy(DormProxy).ClickPage

		setActive(arg_14_0.arrLeftBtnShop, var_14_0 > 1)
		setActive(arg_14_0.arrRightBtnShop, var_14_0 < var_14_1 or not var_14_2)
	elseif arg_14_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
		setActive(arg_14_0.arrLeftBtnShop, false)
		setActive(arg_14_0.arrRightBtnShop, false)
	else
		setActive(arg_14_0.arrLeftBtnShop, false)
		setActive(arg_14_0.arrRightBtnShop, false)
	end

	return
end

function var_0_0.CanClickRefBtn(arg_15_0, arg_15_1)
	local var_15_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_15_0 < var_0_0.nextClickRefreshTime then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_shop_refresh_frequently", (math.ceil(var_0_0.nextClickRefreshTime - var_15_0))))

		return false
	end

	if getProxy(DormProxy).TYPE == arg_15_1 and arg_15_1 ~= 5 then
		return false
	end

	return true
end

function var_0_0.SwitchPage(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if getProxy(DormProxy).TYPE ~= arg_16_1 or arg_16_3 then
		arg_16_0:emit(NewBackYardThemeTemplateMediator.ON_REFRESH, arg_16_1, arg_16_2, arg_16_0.timeType, arg_16_3)

		if not arg_16_3 then
			var_0_0.nextClickRefreshTime = BackYardConst.MANUAL_REFRESH_THEME_TEMPLATE_TIME + pg.TimeMgr.GetInstance():GetServerTime()
		end
	end

	return
end

function var_0_0.UpdateDorm(arg_17_0, arg_17_1)
	arg_17_0.dorm = arg_17_1

	if arg_17_0.contextData.infoPage:GetLoaded() and arg_17_0.contextData.infoPage:isShowing() then
		arg_17_0.contextData.infoPage:ExecuteAction("DormUpdated", arg_17_1)
	end

	if arg_17_0.descPages:GetLoaded() then
		arg_17_0.descPages:ExecuteAction("UpdateDorm", arg_17_1)
	end

	return
end

function var_0_0.PlayerUpdated(arg_18_0, arg_18_1)
	arg_18_0.player = arg_18_1

	if arg_18_0.contextData.infoPage:GetLoaded() and arg_18_0.contextData.infoPage:isShowing() then
		arg_18_0.contextData.infoPage:ExecuteAction("OnPlayerUpdated", arg_18_1)
	end

	if arg_18_0.descPages:GetLoaded() then
		arg_18_0.descPages:ExecuteAction("PlayerUpdated", arg_18_1)
	end

	return
end

function var_0_0.FurnituresUpdated(arg_19_0, arg_19_1)
	if arg_19_0.contextData.infoPage:GetLoaded() and arg_19_0.contextData.infoPage:isShowing() then
		arg_19_0.contextData.infoPage:ExecuteAction("FurnituresUpdated", arg_19_1)
	end

	return
end

function var_0_0.ThemeTemplateUpdate(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.list) do
		if iter_20_1.id == arg_20_1.id then
			arg_20_0.list[iter_20_0] = arg_20_1

			break
		end
	end

	for iter_20_2, iter_20_3 in pairs(arg_20_0.cards) do
		if iter_20_3.template.id == arg_20_1.id then
			iter_20_3:Update(arg_20_1)
		end
	end

	if arg_20_0.descPages:GetLoaded() then
		arg_20_0.descPages:ThemeTemplateUpdate(arg_20_1)
	end

	return
end

function var_0_0.ThemeTemplatesUpdate(arg_21_0, arg_21_1)
	arg_21_0:Flush(arg_21_1)

	return
end

function var_0_0.OnSearchKeyChange(arg_22_0)
	arg_22_0:emit(NewBackYardThemeTemplateMediator.ON_SEARCH, arg_22_0.pageType, (getInputText(arg_22_0.searchInput)))

	return
end

function var_0_0.ShopSearchKeyChange(arg_23_0, arg_23_1)
	arg_23_0.searchTemplate = arg_23_1

	arg_23_0:InitThemeList()

	for iter_23_0, iter_23_1 in pairs(arg_23_0.cards) do
		if iter_23_1.themeVO.id == arg_23_1.id then
			triggerButton(iter_23_1._tf)

			break
		end
	end

	return
end

function var_0_0.OnSearchKeyEditEnd(arg_24_0)
	local var_24_0 = getInputText(arg_24_0.searchInput)

	if not var_24_0 or var_24_0 == "" then
		arg_24_0:emit(NewBackYardThemeTemplateMediator.ON_SEARCH, arg_24_0.pageType, var_24_0)
	end

	return
end

function var_0_0.ClearShopSearchKey(arg_25_0)
	arg_25_0.searchTemplate = nil

	arg_25_0:InitThemeList()
	arg_25_0:ForceActiveFirstCard()

	return
end

function var_0_0.DeleteCustomThemeTemplate(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0.list) do
		if iter_26_1.id == arg_26_1 then
			table.remove(arg_26_0.list, iter_26_0)

			break
		end
	end

	arg_26_0:InitThemeList()
	arg_26_0:ForceActiveFirstCard()

	return
end

function var_0_0.DeleteCollectionThemeTemplate(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.list) do
		if iter_27_1.id == arg_27_1 then
			table.remove(arg_27_0.list, iter_27_0)

			break
		end
	end

	arg_27_0:InitThemeList()
	arg_27_0:ForceActiveFirstCard()

	return
end

function var_0_0.AddCollectionThemeTemplate(arg_28_0, arg_28_1)
	table.insert(arg_28_0.list, arg_28_1)
	arg_28_0:InitThemeList()

	return
end

function var_0_0.DeleteShopThemeTemplate(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0.list) do
		if iter_29_1.id == arg_29_1 then
			table.remove(arg_29_0.list, iter_29_0)

			break
		end
	end

	arg_29_0:InitThemeList()
	arg_29_0:ForceActiveFirstCard()

	return
end

function var_0_0.ThemeTemplatesErro(arg_30_0)
	arg_30_0:UpdateArr()

	return
end

function var_0_0.GetData(arg_31_0)
	if arg_31_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		table.sort(arg_31_0.list, function(arg_32_0, arg_32_1)
			return arg_32_0.sortIndex < arg_32_1.sortIndex
		end)
	elseif arg_31_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
		local var_31_2, var_31_3 = BackYardConst.ServerIndex2ThemeSortIndex(getProxy(DormProxy).TYPE)
	else
		local var_31_4 = defaultValue(arg_31_0.sortIndex, 1)
		local var_31_5 = defaultValue(arg_31_0.asc, true)
	end

	return arg_31_0.list
end

function var_0_0.OnDormUpdated(arg_33_0)
	return
end

function var_0_0.OnPlayerUpdated(arg_34_0)
	return
end

function var_0_0.BlurView(arg_35_0)
	return
end

function var_0_0.UnBlurView(arg_36_0)
	return
end

function var_0_0.SetUp(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	arg_37_0.searchTemplate = nil
	arg_37_0.searchKey = ""
	arg_37_0.pageType = arg_37_1
	arg_37_0.dorm = arg_37_3
	arg_37_0.player = arg_37_4

	arg_37_0:Flush(arg_37_2)

	if arg_37_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		local var_37_0 = getProxy(DormProxy).TYPE

		setActive(arg_37_0.btns[var_37_0]:Find("sel"), true)

		arg_37_0.selectedRefBtn = arg_37_0.btns[var_37_0]

		if getProxy(DormProxy):NeedRefreshThemeTemplateShop() then
			arg_37_0:SwitchPage(var_37_0, getProxy(DormProxy).PAGE, true)
		end
	end

	setActive(arg_37_0.refreshBtns, arg_37_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP)
	setActive(arg_37_0.searchInput.gameObject, arg_37_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP)

	if arg_37_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
		if getProxy(DormProxy):NeedCollectionTip() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("BackYard_collection_be_delete_tip"))
		end
	end

	local var_37_1 = getProxy(DormProxy)

	if var_37_1:NeedShopShowHelp() then
		-- block empty
	end

	if arg_37_0.pageType ~= BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		for iter_37_0, iter_37_1 in pairs(arg_37_0.btns) do
			setActive(iter_37_1:Find("sel"), false)
			setActive(iter_37_1:Find("Text"), true)
		end
	end

	return
end

function var_0_0.Flush(arg_38_0, arg_38_1)
	arg_38_0:Show()

	arg_38_0.list = arg_38_1 or {}

	arg_38_0:InitThemeList()
	arg_38_0:UpdateArr()

	arg_38_0.card = nil

	onNextTick(function()
		arg_38_0:ForceActiveFirstCard()

		return
	end)

	return
end

function var_0_0.InitThemeList(arg_40_0)
	setActive(arg_40_0.rawImage.gameObject, false)
	arg_40_0:SetTotalCount()

	return
end

function var_0_0.SetTotalCount(arg_41_0)
	arg_41_0.disPlays = {}

	if arg_41_0.searchTemplate then
		table.insert(arg_41_0.disPlays, arg_41_0.searchTemplate)
	else
		for iter_41_0, iter_41_1 in ipairs((arg_41_0:GetData())) do
			if iter_41_1:MatchSearchKey(arg_41_0.searchKey) then
				table.insert(arg_41_0.disPlays, iter_41_1)
			end
		end
	end

	arg_41_0.scrollRect.enabled = true

	arg_41_0.scrollRect:SetTotalCount(#arg_41_0.disPlays)

	return
end

function var_0_0.ForceActiveFirstCard(arg_42_0)
	local var_42_0 = #arg_42_0.disPlays == 0

	setActive(arg_42_0.tipBg, #arg_42_0.disPlays == 0)

	local var_42_1 = GetOrAddComponent(arg_42_0.listRect, typeof(CanvasGroup))

	var_42_1.alpha = var_42_0 and 0 or 1
	var_42_1.blocksRaycasts = not var_42_0

	_.each(arg_42_0.tips, function(arg_43_0)
		setActive(arg_43_0, arg_43_0.gameObject.name == "tip" .. tostring(arg_42_0.pageType) and #arg_42_0.disPlays == 0)

		return
	end)
	setActive(arg_42_0.goBtn, arg_42_0.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM and #arg_42_0.disPlays == 0)

	if #arg_42_0.disPlays == 0 then
		arg_42_0.descPages:ExecuteAction("Hide")

		return
	end

	local var_42_2 = arg_42_0.disPlays[1]

	for iter_42_0, iter_42_1 in pairs(arg_42_0.cards) do
		if var_42_2.id == iter_42_1.template.id then
			triggerButton(iter_42_1._tf)

			break
		end
	end

	return
end

function var_0_0.NoSelected(arg_44_0)
	return false
end

function var_0_0.CreateCard(arg_45_0, arg_45_1)
	return (BackYardThemeTemplateCard.New(arg_45_1))
end

function var_0_0.OnUpdateCard(arg_46_0, arg_46_1, arg_46_2)
	var_0_0.super.OnUpdateCard(arg_46_0, arg_46_1, arg_46_2)

	local var_46_0 = arg_46_0.cards[arg_46_2]

	if arg_46_0.cards[arg_46_2].template:ShouldFetch() then
		arg_46_0:emit(NewBackYardThemeTemplateMediator.ON_GET_THEMPLATE_DATA, arg_46_0.cards[arg_46_2].template.id, function(arg_47_0)
			var_46_0:FlushData(arg_47_0)

			return
		end)
	end

	return
end

function var_0_0.OnCardClick(arg_48_0, arg_48_1)
	if arg_48_1.template == arg_48_0.card then
		return
	end

	if arg_48_0.descPages:GetLoaded() then
		arg_48_0.descPages:Hide()
	end

	setActive(arg_48_0.rawImage.gameObject, false)

	local function var_48_0(arg_49_0)
		BackYardThemeTempalteUtil.GetTexture(arg_49_0:GetTextureName(), arg_49_0:GetImageMd5(), function(arg_50_0)
			if not IsNil(arg_48_0.rawImage) and arg_50_0 then
				arg_48_0.rawImage.texture = arg_50_0

				setActive(arg_48_0.rawImage.gameObject, true)
				arg_48_0.rawImage:SetNativeSize()
			end

			return
		end)
		arg_48_0.descPages:ExecuteAction("SetUp", arg_48_0.pageType, arg_48_1.template, arg_48_0.dorm, arg_48_0.player)

		return
	end

	if arg_48_1.template:ShouldFetch() then
		arg_48_0:emit(NewBackYardThemeTemplateMediator.ON_GET_THEMPLATE_DATA, arg_48_1.template.id, function(arg_51_0)
			var_48_0(arg_48_1.template)

			return
		end)
	else
		(function(arg_49_0)
			BackYardThemeTempalteUtil.GetTexture(arg_49_0:GetTextureName(), arg_49_0:GetImageMd5(), function(arg_50_0)
				if not IsNil(arg_48_0.rawImage) and arg_50_0 then
					arg_48_0.rawImage.texture = arg_50_0

					setActive(arg_48_0.rawImage.gameObject, true)
					arg_48_0.rawImage:SetNativeSize()
				end

				return
			end)
			arg_48_0.descPages:ExecuteAction("SetUp", arg_48_0.pageType, arg_48_1.template, arg_48_0.dorm, arg_48_0.player)

			return
		end)(arg_48_1.template)
	end

	arg_48_0.card = arg_48_1.template

	return
end

function var_0_0.OnDestroy(arg_52_0)
	var_0_0.super.OnDestroy(arg_52_0)

	arg_52_0.descPages.OnSortChange = nil

	arg_52_0.descPages:Destroy()
	arg_52_0.contextData.infoPage:Destroy()
	arg_52_0.contextData.furnitureMsgBox:Destroy()
	arg_52_0.contextData.themeMsgBox:Destroy()

	if not IsNil(arg_52_0.rawImage.texture) then
		Object.Destroy(arg_52_0.rawImage.texture)

		arg_52_0.rawImage.texture = nil
	end

	return
end

return var_0_0
