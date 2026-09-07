local BackYardDecrationLayer = class("BackYardDecrationLayer", import("...base.BaseUI"))

BackYardDecrationLayer.INNER_SELECTED_FURNITRUE = "BackYardDecrationLayer:INNER_SELECTED_FURNITRUE"

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 6
local var_0_7 = 7
local var_0_8 = 8
local var_0_9 = 9

function BackYardDecrationLayer:getUIName()
	return "BackYardDecorationUI"
end

function BackYardDecrationLayer:init()
	self.animation = self._tf:GetComponent(typeof(Animation))
	self.dftAniEvent = self._tf:GetComponent(typeof(DftAniEvent))
	self.adpter = self._tf:Find("adpter")
	self.pageConainer = self._tf:Find("adpter/bottom/animroot/root/pages")
	self.bAnimtion = self._tf:Find("adpter/bottom"):GetComponent(typeof(Animation))
	self.shopBtn = self._tf:Find("adpter/shop_btn")
	self.saveBtn = self._tf:Find("adpter/bottom/animroot/save_btn")
	self.clearBtn = self._tf:Find("adpter/bottom/animroot/clear_btn")
	self.bottomTr = self._tf:Find("adpter/bottom")
	self.orderBtn = self._tf:Find("adpter/bottom/animroot/root/fliter_container/order")
	self.orderBtnTxt = self.orderBtn:Find("Text"):GetComponent(typeof(Image))
	self.orderBtnIcon = self.orderBtn:Find("icon")
	self.filterBtn = self._tf:Find("adpter/bottom/animroot/root/fliter_container/filter")
	self.filterBtnTxt = self.filterBtn:Find("Text"):GetComponent(typeof(Image))
	self.filterBtnTxt.sprite = GetSpriteFromAtlas("ui/NewBackYardDecorateUI_atlas", "text_default")

	self.filterBtnTxt:SetNativeSize()

	self.searchInput = self._tf:Find("adpter/bottom/animroot/root/fliter_container/search/search")

	setText(self.searchInput:Find("holder"), i18n("courtyard_label_search_holder"))

	self.searchClear = self._tf:Find("adpter/bottom/animroot/root/fliter_container/search/search/clear")
	self.hideBtn = self._tf:Find("adpter/bottom/animroot/root/fliter_container/hide")
	self.showBtn = self._tf:Find("adpter/bottom/animroot/show_btn")
	self.showPutListBtn = self._tf:Find("adpter/putlist_btn")
	self.themePage = BackYardDecorationThemePage.New(self.pageConainer, self.event, self.contextData)
	self.furniturePage = BackYardDecorationFurniturePage.New(self.pageConainer, self.event, self.contextData)
	self.putListPage = BackYardDecorationPutlistPage.New(self.adpter, self.event, self.contextData)

	function self.putListPage.OnShow(arg_3_0)
		setActive(self.showPutListBtn, not arg_3_0)

		return
	end

	function self.putListPage.OnShowImmediately()
		setActive(self.showPutListBtn, false)

		return
	end

	self.contextData.furnitureDescMsgBox = BackYardDecorationDecBox.New(self._tf, self.event, self.contextData)
	self.contextData.filterPanel = BackYardDecorationFilterPanel.New(self._tf, self.event, self.contextData)
	self.pages = {
		[var_0_1] = self.themePage,
		[var_0_2] = self.furniturePage,
		[var_0_3] = self.furniturePage,
		[var_0_4] = self.furniturePage,
		[var_0_5] = self.furniturePage,
		[var_0_6] = self.furniturePage,
		[var_0_7] = self.furniturePage,
		[var_0_8] = self.furniturePage,
		[var_0_9] = self.furniturePage
	}
	self.themeTag = self._tf:Find("adpter/bottom/animroot/root/theme")

	setText(self.shopBtn:Find("Text"), i18n("courtyard_label_shop_1"))
	setText(self.showPutListBtn:Find("Text"), i18n("courtyard_label_placed_furniture"))
	setText(self.saveBtn:Find("Text"), i18n("courtyard_label_save"))
	setText(self.clearBtn:Find("Text"), i18n("courtyard_label_clear"))

	return
end

function BackYardDecrationLayer:didEnter()
	self.orderMode = BackYardDecorationFilterPanel.ORDER_MODE_DASC

	local function var_5_0(arg_6_0)
		local var_6_0 = ""

		if arg_6_0 == BackYardDecorationFilterPanel.ORDER_MODE_ASC then
			var_6_0 = "text_asc"
			self.orderBtnIcon.localEulerAngles = Vector3(0, 0, 0)
		elseif arg_6_0 == BackYardDecorationFilterPanel.ORDER_MODE_DASC then
			var_6_0 = "text_dasc"
			self.orderBtnIcon.localEulerAngles = Vector3(0, 0, 180)
		end

		self.orderBtnTxt.sprite = GetSpriteFromAtlas("ui/NewBackYardDecorateUI_atlas", var_6_0)

		self.orderBtnTxt:SetNativeSize()

		return
	end

	onToggle(self, self.orderBtn, function(arg_7_0)
		if arg_7_0 then
			self.orderMode = BackYardDecorationFilterPanel.ORDER_MODE_ASC or BackYardDecorationFilterPanel.ORDER_MODE_DASC
		end

		if self.pageType then
			self.pages[self.pageType]:ExecuteAction("OrderModeUpdated", self.orderMode)
		end

		var_5_0(self.orderMode)

		return
	end, SFX_PANEL)
	var_5_0(self.orderMode)
	onButton(self, self.shopBtn, function()
		self:emit(BackYardDecorationMediator.OPEN_SHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.searchClear, function()
		setInputText(self.searchInput, "")

		return
	end, SFX_PANEL)
	onButton(self, self.saveBtn, function()
		self.dftAniEvent:SetEndEvent(function()
			self.dftAniEvent:SetEndEvent(nil)
			self:emit(BackYardDecorationMediator.SAVE_ALL)

			return
		end)
		self.animation:Play("anim_courtyard_decoration_out")

		return
	end, SFX_PANEL)
	onButton(self, self.clearBtn, function()
		self:emit(BackYardDecorationMediator.ClEAR_ALL, true)

		return
	end, SFX_PANEL)
	onButton(self, self.filterBtn, function()
		if not self.pageType then
			return
		end

		self.pages[self.pageType]:ShowFilterPanel(function(arg_14_0)
			self.filterBtnTxt.sprite = GetSpriteFromAtlas("ui/NewBackYardDecorateUI_atlas", i18n("backyard_sort_tag_price") == arg_14_0 and "text_price" or i18n("backyard_sort_tag_comfortable") == arg_14_0 and "text_comfortable" or i18n("backyard_sort_tag_size") == arg_14_0 and "text_area" or "text_default")

			self.filterBtnTxt:SetNativeSize()

			return
		end)

		return
	end, SFX_PANEL)
	onInputChanged(self, self.searchInput, function(arg_15_0)
		if not self.pageType then
			return
		end

		setActive(self.searchClear, arg_15_0 ~= "")
		self.pages[self.pageType]:ExecuteAction("SearchKeyUpdated", arg_15_0)

		return
	end)
	onButton(self, self.showPutListBtn, function()
		self.putListPage:ExecuteAction("SetUp", 0, self.dorm, self.themes, self.orderMode)

		return
	end, SFX_PANEL)
	onToggle(self, self.themeTag, function(arg_17_0)
		if arg_17_0 then
			self:SwitchToPage(var_0_1)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.hideBtn, function()
		self.bAnimtion:Play("anim_courtyard_decoration_bottomout")

		return
	end, SFX_PANEL)
	onButton(self, self.showBtn, function()
		self.bAnimtion:Play("anim_courtyard_decoration_bottomin")

		return
	end, SFX_PANEL)

	self.tags = {
		self._tf:Find("adpter/bottom/animroot/root/tags/1"),
		self._tf:Find("adpter/bottom/animroot/root/tags/2"),
		self._tf:Find("adpter/bottom/animroot/root/tags/3"),
		self._tf:Find("adpter/bottom/animroot/root/tags/4"),
		self._tf:Find("adpter/bottom/animroot/root/tags/5"),
		self._tf:Find("adpter/bottom/animroot/root/tags/6"),
		self._tf:Find("adpter/bottom/animroot/root/tags/7"),
		self._tf:Find("adpter/bottom/animroot/root/tags/8")
	}

	onNextTick(function()
		self:emit(BackYardDecorationMediator.ON_SET_UP)

		return
	end)

	return
end

function BackYardDecrationLayer:SetDorm(arg_21_1)
	self.dorm = arg_21_1

	return
end

function BackYardDecrationLayer:UpdateDorm(arg_22_1)
	self.dorm = arg_22_1

	if self.pageType then
		self.pages[self.pageType]:ExecuteAction("DormUpdated", self.dorm)
	end

	if self.putListPage:GetLoaded() and self.putListPage:isShowing() then
		self.putListPage:ExecuteAction("DormUpdated", self.dorm)
	end

	return
end

function BackYardDecrationLayer:OnApplyThemeBefore()
	if self.pageType then
		self.pages[self.pageType]:ExecuteAction("OnApplyThemeBefore")
	end

	return
end

function BackYardDecrationLayer:OnApplyThemeAfter(arg_24_1)
	if self.pageType then
		self.pages[self.pageType]:ExecuteAction("OnApplyThemeAfter", arg_24_1)
	end

	return
end

function BackYardDecrationLayer:UpdateFurnitrue(arg_25_1)
	if self.pageType then
		self.pages[self.pageType]:ExecuteAction("FurnitureUpdated", arg_25_1)
	end

	return
end

function BackYardDecrationLayer:SetThemes(arg_26_1)
	self.themes = arg_26_1

	return
end

function BackYardDecrationLayer:CustomThemeAdded(arg_27_1)
	self.themes[arg_27_1.id] = arg_27_1

	if self.pageType then
		self.pages[self.pageType]:ExecuteAction("CustomThemeAdded", arg_27_1)
	end

	return
end

function BackYardDecrationLayer:CustomThemeDeleted(arg_28_1)
	self.themes[arg_28_1] = nil

	if self.pageType then
		self.pages[self.pageType]:ExecuteAction("CustomThemeDeleted", arg_28_1)
	end

	return
end

function BackYardDecrationLayer:ThemeUpdated()
	if self.pageType then
		self.pages[self.pageType]:ExecuteAction("ThemeUpdated")
	end

	return
end

function BackYardDecrationLayer:UpdateTagTF(arg_30_1, arg_30_2)
	onToggle(self, arg_30_2, function(arg_31_0)
		if arg_31_0 then
			self:SwitchToPage(arg_30_1)
		end

		return
	end, SFX_PANEL)

	return
end

function BackYardDecrationLayer:InitPages()
	for iter_32_0, iter_32_1 in ipairs(self.tags) do
		self:UpdateTagTF(iter_32_0 + 1, iter_32_1)
	end

	triggerToggle(self.themeTag, true)

	return
end

function BackYardDecrationLayer:SwitchToPage(arg_33_1)
	if self.pageType == arg_33_1 then
		return
	end

	if self.page and not self.page:GetLoaded() then
		return
	end

	local var_33_0 = self.pages[arg_33_1]

	if self.page and self.page ~= var_33_0 then
		self.page:ExecuteAction("Hide")
	end

	var_33_0:ExecuteAction("SetUp", arg_33_1, self.dorm, self.themes, self.orderMode)

	self.page = var_33_0
	self.pageType = arg_33_1

	setActive(self.filterBtn, self.pageType ~= var_0_1)

	return
end

function BackYardDecrationLayer:willExit()
	self.dftAniEvent:SetEndEvent(nil)
	self.themePage:Destroy()
	self.furniturePage:Destroy()
	self.putListPage:Destroy()
	self.contextData.furnitureDescMsgBox:Destroy()
	self.contextData.filterPanel:Destroy()
	BackYardThemeTempalteUtil.ClearAllCache()

	return
end

function BackYardDecrationLayer:onBackPressed()
	if self.themePage:OnBackPressed() then
		return
	end

	if self.furniturePage:OnBackPressed() then
		return
	end

	if self.putListPage:OnBackPressed() then
		return
	end

	if self.contextData.furnitureDescMsgBox:GetLoaded() and self.contextData.furnitureDescMsgBox:isShowing() then
		self.contextData.furnitureDescMsgBox:Hide()

		return
	end

	if self.contextData.filterPanel:GetLoaded() and self.contextData.filterPanel:isShowing() then
		self.contextData.filterPanel:Hide()

		return
	end

	triggerButton(self.saveBtn)

	return
end

return BackYardDecrationLayer
