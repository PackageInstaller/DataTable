local BackYardThemeTemplateListPage = class("BackYardThemeTemplateListPage", import("...Shop.pages.BackYardThemePage"))

BackYardThemeTemplateListPage.nextClickRefreshTime = 0

function BackYardThemeTemplateListPage:getUIName()
	return "BackYardThemeTemplateThemePage"
end

function BackYardThemeTemplateListPage:LoadDetail()
	setActive(self._tf:Find("adpter/descript"), false)

	return
end

function BackYardThemeTemplateListPage:OnInit()
	BackYardThemeTemplateListPage.super.OnInit(self)

	self.tipBg = self._tf:Find("tip")
	self.tips = {
		self._tf:Find("tip1"),
		self._tf:Find("tip2"),
		self._tf:Find("tip3")
	}
	self.goBtn = self._tf:Find("go_btn")
	self.helpBtn = self._tf:Find("adpter/help")
	self.rawImage = self._tf:Find("preview_raw"):GetComponent(typeof(RawImage))
	self.listRect = self._tf:Find("list/frame")
	self.refreshBtns = self._tf:Find("adpter/refresh_btns")
	self.btns = {
		[5] = self.refreshBtns:Find("random"),
		[3] = self.refreshBtns:Find("hot"),
		[2] = self.refreshBtns:Find("new")
	}

	setText(self.refreshBtns:Find("random/Text"), i18n("word_random"))
	setText(self.refreshBtns:Find("random/sel/Text"), i18n("word_random"))
	setText(self.refreshBtns:Find("hot/Text"), i18n("word_hot"))
	setText(self.refreshBtns:Find("hot/sel/Text"), i18n("word_hot"))
	setText(self.refreshBtns:Find("new/Text"), i18n("word_new"))
	setText(self.refreshBtns:Find("new/sel/Text"), i18n("word_new"))

	for iter_3_0, iter_3_1 in pairs(self.btns) do
		onButton(self, iter_3_1, function()
			if self:CanClickRefBtn(iter_3_0) then
				if self.selectedRefBtn then
					setActive(self.selectedRefBtn:Find("sel"), false)
					setActive(self.selectedRefBtn:Find("Text"), true)
				end

				setActive(iter_3_1:Find("sel"), true)
				setActive(iter_3_1:Find("Text"), false)
				self:SwitchPage(iter_3_0, 1)

				self.selectedRefBtn = iter_3_1
			end

			return
		end, SFX_PANEL)
	end

	onButton(self, self.helpBtn, function()
		_backYardThemeTemplateMsgbox:ShowHelp({
			helps = pg.gametip.backyard_theme_template_shop_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		self:emit(NewBackYardThemeTemplateMediator.GO_DECORATION)

		return
	end, SFX_PANEL)
	self.scrollRect.onValueChanged:RemoveAllListeners()

	self.arrLeftBtnShop = self._tf:Find("list/frame/zuobian_shop")
	self.arrRightBtnShop = self._tf:Find("list/frame/youbian_shop")

	onButton(self, self.arrLeftBtnShop, function()
		if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
			local var_7_0 = getProxy(DormProxy).PAGE

			if var_7_0 > 1 then
				self:SwitchPage(getProxy(DormProxy).TYPE, var_7_0 - 1, true)
			end
		end

		return
	end, SFX_PANEL)
	onButton(self, self.arrRightBtnShop, function()
		if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
			getProxy(DormProxy).ClickPage = true

			self:SwitchPage(getProxy(DormProxy).TYPE, getProxy(DormProxy).PAGE + 1, true)
		end

		return
	end, SFX_PANEL)

	local function var_3_0()
		if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
			self:emit(NewBackYardThemeTemplateMediator.ON_GET_SPCAIL_TYPE_TEMPLATE, (BackYardConst.ThemeSortIndex2ServerIndex(self.sortIndex, self.asc)))
		else
			self:SetTotalCount()
		end

		return
	end

	self.descPages = BackYardThemeTemplateDescPage.New(self._tf, self.event, self.contextData)

	function self.descPages.OnSortChange(arg_10_0)
		self.asc = arg_10_0

		var_3_0()

		return
	end

	self.contextData.infoPage = BackYardThemeTemplateInfoPage.New(self._parentTf, self.event, self.contextData)
	self.contextData.furnitureMsgBox = BackYardFurnitureMsgBoxPage.New(self._parentTf, self.event, self.contextData)
	self.contextData.themeMsgBox = BackYardThemeTemplatePurchaseMsgbox.New(self._parentTf, self.event, self.contextData)

	setText(self.goBtn:Find("Text"), i18n("courtyard_label_go"))
	setText(self._tf:Find("tip1"), i18n("courtyard_label_empty_template_list"))
	setText(self._tf:Find("tip2"), i18n("courtyard_label_empty_custom_template_list"))
	setText(self._tf:Find("tip3"), i18n("courtyard_label_empty_collection_list"))

	return
end

function BackYardThemeTemplateListPage:InitInput()
	onInputChanged(self, self.searchInput, function()
		setActive(self.searchClear, getInputText(self.searchInput) ~= "")

		return
	end)
	onInputEndEdit(self, self.searchInput, function()
		self:OnSearchKeyChange()

		return
	end)

	return
end

function BackYardThemeTemplateListPage:UpdateArr()
	if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		local var_14_0 = getProxy(DormProxy).PAGE
		local var_14_1 = getProxy(DormProxy).lastPages[getProxy(DormProxy).TYPE]
		local var_14_2 = getProxy(DormProxy).ClickPage

		setActive(self.arrLeftBtnShop, var_14_0 > 1)
		setActive(self.arrRightBtnShop, var_14_0 < var_14_1 or not var_14_2)
	elseif self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
		setActive(self.arrLeftBtnShop, false)
		setActive(self.arrRightBtnShop, false)
	else
		setActive(self.arrLeftBtnShop, false)
		setActive(self.arrRightBtnShop, false)
	end

	return
end

function BackYardThemeTemplateListPage:CanClickRefBtn(arg_15_1)
	local var_15_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_15_0 < BackYardThemeTemplateListPage.nextClickRefreshTime then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_shop_refresh_frequently", (math.ceil(BackYardThemeTemplateListPage.nextClickRefreshTime - var_15_0))))

		return false
	end

	if getProxy(DormProxy).TYPE == arg_15_1 and arg_15_1 ~= 5 then
		return false
	end

	return true
end

function BackYardThemeTemplateListPage:SwitchPage(arg_16_1, arg_16_2, arg_16_3)
	if getProxy(DormProxy).TYPE ~= arg_16_1 or arg_16_3 then
		self:emit(NewBackYardThemeTemplateMediator.ON_REFRESH, arg_16_1, arg_16_2, self.timeType, arg_16_3)

		if not arg_16_3 then
			BackYardThemeTemplateListPage.nextClickRefreshTime = BackYardConst.MANUAL_REFRESH_THEME_TEMPLATE_TIME + pg.TimeMgr.GetInstance():GetServerTime()
		end
	end

	return
end

function BackYardThemeTemplateListPage:UpdateDorm(arg_17_1)
	self.dorm = arg_17_1

	if self.contextData.infoPage:GetLoaded() and self.contextData.infoPage:isShowing() then
		self.contextData.infoPage:ExecuteAction("DormUpdated", arg_17_1)
	end

	if self.descPages:GetLoaded() then
		self.descPages:ExecuteAction("UpdateDorm", arg_17_1)
	end

	return
end

function BackYardThemeTemplateListPage:PlayerUpdated(arg_18_1)
	self.player = arg_18_1

	if self.contextData.infoPage:GetLoaded() and self.contextData.infoPage:isShowing() then
		self.contextData.infoPage:ExecuteAction("OnPlayerUpdated", arg_18_1)
	end

	if self.descPages:GetLoaded() then
		self.descPages:ExecuteAction("PlayerUpdated", arg_18_1)
	end

	return
end

function BackYardThemeTemplateListPage:FurnituresUpdated(arg_19_1)
	if self.contextData.infoPage:GetLoaded() and self.contextData.infoPage:isShowing() then
		self.contextData.infoPage:ExecuteAction("FurnituresUpdated", arg_19_1)
	end

	return
end

function BackYardThemeTemplateListPage:ThemeTemplateUpdate(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(self.list) do
		if iter_20_1.id == arg_20_1.id then
			self.list[iter_20_0] = arg_20_1

			break
		end
	end

	for iter_20_2, iter_20_3 in pairs(self.cards) do
		if iter_20_3.template.id == arg_20_1.id then
			iter_20_3:Update(arg_20_1)
		end
	end

	if self.descPages:GetLoaded() then
		self.descPages:ThemeTemplateUpdate(arg_20_1)
	end

	return
end

function BackYardThemeTemplateListPage:ThemeTemplatesUpdate(arg_21_1)
	self:Flush(arg_21_1)

	return
end

function BackYardThemeTemplateListPage:OnSearchKeyChange()
	self:emit(NewBackYardThemeTemplateMediator.ON_SEARCH, self.pageType, (getInputText(self.searchInput)))

	return
end

function BackYardThemeTemplateListPage:ShopSearchKeyChange(arg_23_1)
	self.searchTemplate = arg_23_1

	self:InitThemeList()

	for iter_23_0, iter_23_1 in pairs(self.cards) do
		if iter_23_1.themeVO.id == arg_23_1.id then
			triggerButton(iter_23_1._tf)

			break
		end
	end

	return
end

function BackYardThemeTemplateListPage:OnSearchKeyEditEnd()
	local var_24_0 = getInputText(self.searchInput)

	if not var_24_0 or var_24_0 == "" then
		self:emit(NewBackYardThemeTemplateMediator.ON_SEARCH, self.pageType, var_24_0)
	end

	return
end

function BackYardThemeTemplateListPage:ClearShopSearchKey()
	self.searchTemplate = nil

	self:InitThemeList()
	self:ForceActiveFirstCard()

	return
end

function BackYardThemeTemplateListPage:DeleteCustomThemeTemplate(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(self.list) do
		if iter_26_1.id == arg_26_1 then
			table.remove(self.list, iter_26_0)

			break
		end
	end

	self:InitThemeList()
	self:ForceActiveFirstCard()

	return
end

function BackYardThemeTemplateListPage:DeleteCollectionThemeTemplate(arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(self.list) do
		if iter_27_1.id == arg_27_1 then
			table.remove(self.list, iter_27_0)

			break
		end
	end

	self:InitThemeList()
	self:ForceActiveFirstCard()

	return
end

function BackYardThemeTemplateListPage:AddCollectionThemeTemplate(arg_28_1)
	table.insert(self.list, arg_28_1)
	self:InitThemeList()

	return
end

function BackYardThemeTemplateListPage:DeleteShopThemeTemplate(arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(self.list) do
		if iter_29_1.id == arg_29_1 then
			table.remove(self.list, iter_29_0)

			break
		end
	end

	self:InitThemeList()
	self:ForceActiveFirstCard()

	return
end

function BackYardThemeTemplateListPage:ThemeTemplatesErro()
	self:UpdateArr()

	return
end

function BackYardThemeTemplateListPage:GetData()
	if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		table.sort(self.list, function(arg_32_0, arg_32_1)
			return arg_32_0.sortIndex < arg_32_1.sortIndex
		end)
	elseif self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
		local var_31_2, var_31_3 = BackYardConst.ServerIndex2ThemeSortIndex(getProxy(DormProxy).TYPE)
	else
		local var_31_4 = defaultValue(self.sortIndex, 1)
		local var_31_5 = defaultValue(self.asc, true)
	end

	return self.list
end

function BackYardThemeTemplateListPage:OnDormUpdated()
	return
end

function BackYardThemeTemplateListPage:OnPlayerUpdated()
	return
end

function BackYardThemeTemplateListPage:BlurView()
	return
end

function BackYardThemeTemplateListPage:UnBlurView()
	return
end

function BackYardThemeTemplateListPage:SetUp(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	self.searchTemplate = nil
	self.searchKey = ""
	self.pageType = arg_37_1
	self.dorm = arg_37_3
	self.player = arg_37_4

	self:Flush(arg_37_2)

	if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		local var_37_0 = getProxy(DormProxy).TYPE

		setActive(self.btns[var_37_0]:Find("sel"), true)

		self.selectedRefBtn = self.btns[var_37_0]

		if getProxy(DormProxy):NeedRefreshThemeTemplateShop() then
			self:SwitchPage(var_37_0, getProxy(DormProxy).PAGE, true)
		end
	end

	setActive(self.refreshBtns, self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP)
	setActive(self.searchInput.gameObject, self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP)

	if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
		if getProxy(DormProxy):NeedCollectionTip() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("BackYard_collection_be_delete_tip"))
		end
	end

	if getProxy(DormProxy):NeedShopShowHelp() then
		-- block empty
	end

	if self.pageType ~= BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		for iter_37_0, iter_37_1 in pairs(self.btns) do
			setActive(iter_37_1:Find("sel"), false)
			setActive(iter_37_1:Find("Text"), true)
		end
	end

	return
end

function BackYardThemeTemplateListPage:Flush(arg_38_1)
	self:Show()

	self.list = arg_38_1 or {}

	self:InitThemeList()
	self:UpdateArr()

	self.card = nil

	onNextTick(function()
		self:ForceActiveFirstCard()

		return
	end)

	return
end

function BackYardThemeTemplateListPage:InitThemeList()
	setActive(self.rawImage.gameObject, false)
	self:SetTotalCount()

	return
end

function BackYardThemeTemplateListPage:SetTotalCount()
	self.disPlays = {}

	if self.searchTemplate then
		table.insert(self.disPlays, self.searchTemplate)
	else
		for iter_41_0, iter_41_1 in ipairs((self:GetData())) do
			if iter_41_1:MatchSearchKey(self.searchKey) then
				table.insert(self.disPlays, iter_41_1)
			end
		end
	end

	self.scrollRect.enabled = true

	self.scrollRect:SetTotalCount(#self.disPlays)

	return
end

function BackYardThemeTemplateListPage:ForceActiveFirstCard()
	local var_42_0 = #self.disPlays == 0

	setActive(self.tipBg, #self.disPlays == 0)

	local var_42_1 = GetOrAddComponent(self.listRect, typeof(CanvasGroup))

	var_42_1.alpha = var_42_0 and 0 or 1
	var_42_1.blocksRaycasts = not var_42_0

	_.each(self.tips, function(arg_43_0)
		setActive(arg_43_0, arg_43_0.gameObject.name == "tip" .. tostring(self.pageType) and #self.disPlays == 0)

		return
	end)
	setActive(self.goBtn, self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM and #self.disPlays == 0)

	if #self.disPlays == 0 then
		self.descPages:ExecuteAction("Hide")

		return
	end

	local var_42_2 = self.disPlays[1]

	for iter_42_0, iter_42_1 in pairs(self.cards) do
		if var_42_2.id == iter_42_1.template.id then
			triggerButton(iter_42_1._tf)

			break
		end
	end

	return
end

function BackYardThemeTemplateListPage:NoSelected()
	return false
end

function BackYardThemeTemplateListPage:CreateCard(arg_45_1)
	return (BackYardThemeTemplateCard.New(arg_45_1))
end

function BackYardThemeTemplateListPage:OnUpdateCard(arg_46_1, arg_46_2)
	BackYardThemeTemplateListPage.super.OnUpdateCard(self, arg_46_1, arg_46_2)

	local var_46_0 = self.cards[arg_46_2]

	if self.cards[arg_46_2].template:ShouldFetch() then
		self:emit(NewBackYardThemeTemplateMediator.ON_GET_THEMPLATE_DATA, self.cards[arg_46_2].template.id, function(arg_47_0)
			var_46_0:FlushData(arg_47_0)

			return
		end)
	end

	return
end

function BackYardThemeTemplateListPage:OnCardClick(arg_48_1)
	if arg_48_1.template == self.card then
		return
	end

	if self.descPages:GetLoaded() then
		self.descPages:Hide()
	end

	setActive(self.rawImage.gameObject, false)

	local function var_48_0(arg_49_0)
		BackYardThemeTempalteUtil.GetTexture(arg_49_0:GetTextureName(), arg_49_0:GetImageMd5(), function(arg_50_0)
			if not IsNil(self.rawImage) and arg_50_0 then
				self.rawImage.texture = arg_50_0

				setActive(self.rawImage.gameObject, true)
				self.rawImage:SetNativeSize()
			end

			return
		end)
		self.descPages:ExecuteAction("SetUp", self.pageType, arg_48_1.template, self.dorm, self.player)

		return
	end

	if arg_48_1.template:ShouldFetch() then
		self:emit(NewBackYardThemeTemplateMediator.ON_GET_THEMPLATE_DATA, arg_48_1.template.id, function(arg_51_0)
			var_48_0(arg_48_1.template)

			return
		end)
	else
		var_48_0(arg_48_1.template)
	end

	self.card = arg_48_1.template

	return
end

function BackYardThemeTemplateListPage:OnDestroy()
	BackYardThemeTemplateListPage.super.OnDestroy(self)

	self.descPages.OnSortChange = nil

	self.descPages:Destroy()
	self.contextData.infoPage:Destroy()
	self.contextData.furnitureMsgBox:Destroy()
	self.contextData.themeMsgBox:Destroy()

	if not IsNil(self.rawImage.texture) then
		Object.Destroy(self.rawImage.texture)

		self.rawImage.texture = nil
	end

	return
end

return BackYardThemeTemplateListPage
