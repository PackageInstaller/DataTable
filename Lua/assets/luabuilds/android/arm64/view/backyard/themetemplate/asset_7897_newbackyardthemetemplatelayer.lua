local NewBackYardThemeTemplateLayer = class("NewBackYardThemeTemplateLayer", import("...base.BaseUI"))

local function var_0_1(arg_1_0, arg_1_1, arg_1_2)
	local function var_1_0(arg_2_0, arg_2_1)
		setActive(arg_2_0:Find("sel"), arg_2_1)
		setActive(arg_2_0:Find("unsel"), not arg_2_1)

		return
	end

	onButton(arg_1_0, arg_1_1, function()
		if not arg_1_2() then
			return
		end

		if arg_1_0.btn then
			var_1_0(arg_1_0.btn, false)
		end

		var_1_0(arg_1_1, true)

		arg_1_0.btn = arg_1_1

		return
	end, SFX_PANEL)
	var_1_0(arg_1_1, false)

	return
end

function NewBackYardThemeTemplateLayer:forceGC()
	return true
end

function NewBackYardThemeTemplateLayer:getUIName()
	return "NewBackYardTemplateUI"
end

function NewBackYardThemeTemplateLayer:preload(arg_6_1)
	_backYardThemeTemplateMsgbox = BackyardMsgBoxMgr.New()

	_backYardThemeTemplateMsgbox:Init(self, arg_6_1)

	return
end

function NewBackYardThemeTemplateLayer:init()
	self.tpl = self._tf:Find("adpter/tag/list/tpl")
	self.container = self._tf:Find("adpter/tag/list")
	self.pageContainer = self._tf:Find("pages")
	self.backBtn = self._tf:Find("adpter/top/fanhui")
	self.homeBtn = self._tf:Find("adpter/top/help")
	self.goldTxt = self._tf:Find("adpter/top/res_gold/Text"):GetComponent(typeof(Text))
	self.gemTxt = self._tf:Find("adpter/top/res_gem/Text"):GetComponent(typeof(Text))
	self.gemAddBtn = self._tf:Find("adpter/top/res_gem/jiahao")
	self.goldAddBtn = self._tf:Find("adpter/top/res_gold/jiahao")
	self.tags = {
		[BackYardConst.THEME_TEMPLATE_TYPE_SHOP] = i18n("backyard_theme_shop_title"),
		[BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM] = i18n("backyard_theme_mine_title"),
		[BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION] = i18n("backyard_theme_collection_title")
	}
	self.listPage = BackYardThemeTemplateListPage.New(self.pageContainer, self.event, self.contextData)
	self.contextData.msgBox = BackYardThemeTemplateMsgBox.New(self._tf, self.event, self.contextData)

	return
end

function NewBackYardThemeTemplateLayer:SetShopThemeTemplate(arg_8_1)
	self.shopThemeTemplate = arg_8_1

	return
end

function NewBackYardThemeTemplateLayer:ShopThemeTemplateUpdate(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self.shopThemeTemplate) do
		if iter_9_1.id == arg_9_1.id then
			self.shopThemeTemplate[iter_9_0] = arg_9_1

			break
		end
	end

	if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		self.listPage:ExecuteAction("ThemeTemplateUpdate", arg_9_1)
	end

	return
end

function NewBackYardThemeTemplateLayer:OnShopTemplatesUpdated(arg_10_1)
	self:SetShopThemeTemplate(arg_10_1)

	if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		self.listPage:ExecuteAction("ThemeTemplatesUpdate", (self:GetDataForType(self.pageType)))
	end

	return
end

function NewBackYardThemeTemplateLayer:OnShopTemplatesErro()
	if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		self.listPage:ExecuteAction("ThemeTemplatesErro", (self:GetDataForType(self.pageType)))
	end

	return
end

function NewBackYardThemeTemplateLayer:SetCustomThemeTemplate(arg_12_1)
	self.customThemeTemplate = arg_12_1

	return
end

function NewBackYardThemeTemplateLayer:CustomThemeTemplateUpdate(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self.customThemeTemplate) do
		if iter_13_1.id == arg_13_1.id then
			self.customThemeTemplate[iter_13_0] = arg_13_1

			break
		end
	end

	if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
		self.listPage:ExecuteAction("ThemeTemplateUpdate", arg_13_1)
	end

	return
end

function NewBackYardThemeTemplateLayer:SetCollectionThemeTemplate(arg_14_1)
	self.collectionThemeTemplate = arg_14_1

	return
end

function NewBackYardThemeTemplateLayer:CollectionThemeTemplateUpdate(arg_15_1)
	for iter_15_0, iter_15_1 in pairs(self.collectionThemeTemplate) do
		if iter_15_1.id == arg_15_1.id then
			self.collectionThemeTemplate[iter_15_0] = arg_15_1

			break
		end
	end

	if self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
		self.listPage:ExecuteAction("ThemeTemplateUpdate", arg_15_1)
	end

	return
end

function NewBackYardThemeTemplateLayer:SetDorm(arg_16_1)
	self.dorm = arg_16_1

	return
end

function NewBackYardThemeTemplateLayer:UpdateDorm(arg_17_1)
	self:SetDorm(arg_17_1)

	if self.pageType then
		self.listPage:ExecuteAction("UpdateDorm", arg_17_1)
	end

	return
end

function NewBackYardThemeTemplateLayer:SetPlayer(arg_18_1)
	self.player = arg_18_1

	return
end

function NewBackYardThemeTemplateLayer:PlayerUpdated(arg_19_1)
	self:SetPlayer(arg_19_1)
	self:UpdateRes()

	if self.pageType then
		self.listPage:ExecuteAction("PlayerUpdated", arg_19_1)
	end

	return
end

function NewBackYardThemeTemplateLayer:FurnituresUpdated(arg_20_1)
	if self.pageType then
		self.listPage:ExecuteAction("FurnituresUpdated", arg_20_1)
	end

	return
end

function NewBackYardThemeTemplateLayer:SearchKeyChange(arg_21_1)
	if self.pageType and (self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM or self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION) then
		self.listPage:ExecuteAction("SearchKeyChange", arg_21_1)
	end

	return
end

function NewBackYardThemeTemplateLayer:ShopSearchKeyChange(arg_22_1)
	if self.pageType and self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		self.listPage:ExecuteAction("ShopSearchKeyChange", arg_22_1)
	end

	return
end

function NewBackYardThemeTemplateLayer:ClearShopSearchKey()
	if self.pageType and self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		self.listPage:ExecuteAction("ClearShopSearchKey")
	end

	return
end

function NewBackYardThemeTemplateLayer:DeleteCustomThemeTemplate(arg_24_1)
	if not self.customThemeTemplate then
		return
	end

	for iter_24_0, iter_24_1 in pairs(self.customThemeTemplate) do
		if iter_24_1.id == arg_24_1 then
			self.customThemeTemplate[iter_24_0] = nil

			break
		end
	end

	if self.pageType and self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
		self.listPage:ExecuteAction("DeleteCustomThemeTemplate", arg_24_1)
	end

	return
end

function NewBackYardThemeTemplateLayer:DeleteCollectionThemeTemplate(arg_25_1)
	if not self.collectionThemeTemplate then
		return
	end

	for iter_25_0, iter_25_1 in pairs(self.collectionThemeTemplate) do
		if iter_25_1.id == arg_25_1 then
			self.collectionThemeTemplate[iter_25_0] = nil

			break
		end
	end

	if self.pageType and self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
		self.listPage:ExecuteAction("DeleteCollectionThemeTemplate", arg_25_1)
	end

	return
end

function NewBackYardThemeTemplateLayer:DeleteShopThemeTemplate(arg_26_1)
	if not self.shopThemeTemplate then
		return
	end

	for iter_26_0, iter_26_1 in pairs(self.shopThemeTemplate) do
		if iter_26_1.id == arg_26_1 then
			self.shopThemeTemplate[iter_26_0] = nil

			break
		end
	end

	if self.pageType and self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		self.listPage:ExecuteAction("DeleteShopThemeTemplate", arg_26_1)
	end

	return
end

function NewBackYardThemeTemplateLayer:AddCollectionThemeTemplate(arg_27_1)
	self.collectionThemeTemplate[arg_27_1.id] = arg_27_1

	if self.pageType and self.pageType == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
		self.listPage:ExecuteAction("AddCollectionThemeTemplate", arg_27_1.id)
	end

	return
end

function NewBackYardThemeTemplateLayer:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(NewBackYardThemeTemplateLayer.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:emit(NewBackYardThemeTemplateLayer.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self.gemAddBtn, function()
		self:emit(NewBackYardThemeTemplateMediator.ON_CHARGE, PlayerConst.ResDiamond)

		return
	end, SFX_PANEL)
	onButton(self, self.goldAddBtn, function()
		self:emit(NewBackYardThemeTemplateMediator.ON_CHARGE, PlayerConst.ResDormMoney)

		return
	end, SFX_PANEL)
	seriesAsync({
		function(arg_33_0)
			self:emit(NewBackYardThemeTemplateMediator.FETCH_ALL_THEME, arg_33_0)

			return
		end
	}, function()
		self:InitPages()
		self:UpdateRes()
		self:ActiveDefaultPage()

		return
	end)

	return
end

function NewBackYardThemeTemplateLayer:InitPages()
	self.btns = {}

	for iter_35_0, iter_35_1 in pairs(self.tags) do
		local var_35_0 = cloneTplTo(self.tpl, self.container)
		local var_35_1 = var_35_0:Find("unsel"):GetComponent(typeof(Image))

		var_35_1.sprite = GetSpriteFromAtlas("ui/NewBackYardShopUI_atlas", "text_tp_" .. iter_35_0)

		var_35_1:SetNativeSize()

		local var_35_2 = var_35_0:Find("sel/Text"):GetComponent(typeof(Image))

		var_35_2.sprite = GetSpriteFromAtlas("ui/NewBackYardShopUI_atlas", "text_tp_" .. iter_35_0)

		var_35_2:SetNativeSize()
		setActive(var_35_0:Find("line"), iter_35_0 ~= BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION)
		var_0_1(self, var_35_0, function()
			self.listPage:ExecuteAction("SetUp", iter_35_0, self:GetDataForType(iter_35_0), self.dorm, self.player)

			self.pageType = iter_35_0

			return true
		end)

		self.btns[iter_35_0] = var_35_0
	end

	setActive(self.tpl, false)

	return
end

function NewBackYardThemeTemplateLayer:ActiveDefaultPage()
	triggerButton(self.btns[self.contextData.page or BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM])

	return
end

function NewBackYardThemeTemplateLayer:GetDataForType(arg_38_1)
	if arg_38_1 == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		local var_38_0 = {}

		for iter_38_0, iter_38_1 in pairs(self.shopThemeTemplate) do
			table.insert(var_38_0, iter_38_1)
		end

		return var_38_0 or {}
	elseif arg_38_1 == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
		local var_38_1 = {}

		for iter_38_2, iter_38_3 in pairs(self.customThemeTemplate) do
			if iter_38_3:CanDispaly() then
				table.insert(var_38_1, iter_38_3)
			end
		end

		return var_38_1
	elseif arg_38_1 == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
		local var_38_2 = {}

		for iter_38_4, iter_38_5 in pairs(self.collectionThemeTemplate) do
			table.insert(var_38_2, iter_38_5)
		end

		return var_38_2 or {}
	end

	assert(false)

	return
end

function NewBackYardThemeTemplateLayer:UpdateRes()
	self.goldTxt.text = self.player:getResource(PlayerConst.ResDormMoney)
	self.gemTxt.text = self.player:getTotalGem()

	return
end

function NewBackYardThemeTemplateLayer:willExit()
	_backYardThemeTemplateMsgbox:Destroy()

	_backYardThemeTemplateMsgbox = nil

	self.listPage:Destroy()
	self.contextData.msgBox:Destroy()
	BackYardThemeTempalteUtil.ClearAllCache()

	return
end

return NewBackYardThemeTemplateLayer
