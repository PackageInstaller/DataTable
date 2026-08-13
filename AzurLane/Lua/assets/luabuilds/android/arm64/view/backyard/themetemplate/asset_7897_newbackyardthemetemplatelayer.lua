class = var_0_10000

local var_0_0 = "NewBackYardThemeTemplateLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

local function var_0_2(arg_1_0, arg_1_1, arg_1_2)
	local function var_1_0(arg_2_0, arg_2_1)
		setActive = var_2_10002

		var_2_10002(arg_2_0:Find("sel"), arg_2_1)

		setActive = var_2_10002

		var_2_10002(arg_2_0:Find("unsel"), not arg_2_1)

		return
	end

	onButton = var_1_10004

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	local function var_1_3()
		if not arg_1_2() then
			return
		end

		if arg_1_0.btn then
			var_1_0(arg_1_0.btn, false)
		end

		var_1_0(arg_1_1, true)

		arg_1_0.btn = arg_1_1

		return
	end

	SFX_PANEL = var_1_10009

	var_1_10004(var_1_1, var_1_2, var_1_3, var_1_10009)
	var_1_0(arg_1_1, false)

	return
end

function var_0_1.forceGC(arg_4_0)
	return true
end

function var_0_1.getUIName(arg_5_0)
	return "NewBackYardTemplateUI"
end

function var_0_1.preload(arg_6_0, arg_6_1)
	BackyardMsgBoxMgr = var_1_10002

	local var_6_0 = var_1_10002.New()

	_backYardThemeTemplateMsgbox = _backYardThemeTemplateMsgbox

	var_2:Init(arg_6_0, arg_6_1)

	return
end

function var_0_1.init(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.tpl = var_1.Find(var_7_0, "adpter/tag/list/tpl")

	local var_7_1 = arg_7_0._tf

	arg_7_0.container = var_1.Find(var_7_1, "adpter/tag/list")

	local var_7_2 = arg_7_0._tf

	arg_7_0.pageContainer = var_1.Find(var_7_2, "pages")

	local var_7_3 = arg_7_0._tf

	arg_7_0.backBtn = var_1.Find(var_7_3, "adpter/top/fanhui")

	local var_7_4 = arg_7_0._tf

	arg_7_0.homeBtn = var_1.Find(var_7_4, "adpter/top/help")

	local var_7_5 = arg_7_0._tf
	local var_7_6 = var_1.Find(var_7_5, "adpter/top/res_gold/Text")
	local var_7_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_7_0.goldTxt = var_7_7(var_7_6, var_4(var_1_10006))

	local var_7_8 = arg_7_0._tf
	local var_7_9 = var_1.Find(var_7_8, "adpter/top/res_gem/Text")
	local var_7_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_7_0.gemTxt = var_7_10(var_7_9, var_4(var_1_10006))

	local var_7_11 = arg_7_0._tf

	arg_7_0.gemAddBtn = var_1.Find(var_7_11, "adpter/top/res_gem/jiahao")

	local var_7_12 = arg_7_0._tf

	arg_7_0.goldAddBtn = var_1.Find(var_7_12, "adpter/top/res_gold/jiahao")

	local var_7_13 = {}

	BackYardConst = var_1_10002

	local var_7_14 = var_1_10002.THEME_TEMPLATE_TYPE_SHOP

	i18n = var_7_12
	var_7_13[var_7_14] = var_7_12("backyard_theme_shop_title")
	BackYardConst = var_7_14

	local var_7_15 = var_7_14.THEME_TEMPLATE_TYPE_CUSTOM

	i18n = var_3
	var_7_13[var_7_15] = var_3("backyard_theme_mine_title")
	BackYardConst = var_7_15

	local var_7_16 = var_7_15.THEME_TEMPLATE_TYPE_COLLECTION

	i18n = var_3
	var_7_13[var_7_16] = var_3("backyard_theme_collection_title")
	arg_7_0.tags = var_7_13
	BackYardThemeTemplateListPage = var_7_13
	arg_7_0.listPage = var_7_13.New(arg_7_0.pageContainer, arg_7_0.event, arg_7_0.contextData)

	local var_7_17 = arg_7_0.contextData

	BackYardThemeTemplateMsgBox = var_7_16
	var_7_17.msgBox = var_7_16.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	return
end

function var_0_1.SetShopThemeTemplate(arg_8_0, arg_8_1)
	arg_8_0.shopThemeTemplate = arg_8_1

	return
end

function var_0_1.ShopThemeTemplateUpdate(arg_9_0, arg_9_1)
	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.shopThemeTemplate) do
		if iter_9_1.id == arg_9_1.id then
			arg_9_0.shopThemeTemplate[iter_9_0] = arg_9_1

			break
		end
	end

	local var_9_0 = arg_9_0.pageType

	BackYardConst = var_3

	if var_9_0 == var_3.THEME_TEMPLATE_TYPE_SHOP then
		local var_9_1 = arg_9_0.listPage

		var_2.ExecuteAction(var_9_1, "ThemeTemplateUpdate", arg_9_1)
	end

	return
end

function var_0_1.OnShopTemplatesUpdated(arg_10_0, arg_10_1)
	arg_10_0:SetShopThemeTemplate(arg_10_1)

	local var_10_0 = arg_10_0.pageType

	BackYardConst = var_1_10003

	if var_10_0 == var_1_10003.THEME_TEMPLATE_TYPE_SHOP then
		local var_10_1 = arg_10_0:GetDataForType(arg_10_0.pageType)
		local var_10_2 = arg_10_0.listPage

		var_3.ExecuteAction(var_10_2, "ThemeTemplatesUpdate", var_10_1)
	end

	return
end

function var_0_1.OnShopTemplatesErro(arg_11_0)
	local var_11_0 = arg_11_0.pageType

	BackYardConst = var_1_10002

	if var_11_0 == var_1_10002.THEME_TEMPLATE_TYPE_SHOP then
		local var_11_1 = arg_11_0:GetDataForType(arg_11_0.pageType)
		local var_11_2 = arg_11_0.listPage

		var_2.ExecuteAction(var_11_2, "ThemeTemplatesErro", var_11_1)
	end

	return
end

function var_0_1.SetCustomThemeTemplate(arg_12_0, arg_12_1)
	arg_12_0.customThemeTemplate = arg_12_1

	return
end

function var_0_1.CustomThemeTemplateUpdate(arg_13_0, arg_13_1)
	pairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.customThemeTemplate) do
		if iter_13_1.id == arg_13_1.id then
			arg_13_0.customThemeTemplate[iter_13_0] = arg_13_1

			break
		end
	end

	local var_13_0 = arg_13_0.pageType

	BackYardConst = var_3

	if var_13_0 == var_3.THEME_TEMPLATE_TYPE_CUSTOM then
		local var_13_1 = arg_13_0.listPage

		var_2.ExecuteAction(var_13_1, "ThemeTemplateUpdate", arg_13_1)
	end

	return
end

function var_0_1.SetCollectionThemeTemplate(arg_14_0, arg_14_1)
	arg_14_0.collectionThemeTemplate = arg_14_1

	return
end

function var_0_1.CollectionThemeTemplateUpdate(arg_15_0, arg_15_1)
	pairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0.collectionThemeTemplate) do
		if iter_15_1.id == arg_15_1.id then
			arg_15_0.collectionThemeTemplate[iter_15_0] = arg_15_1

			break
		end
	end

	local var_15_0 = arg_15_0.pageType

	BackYardConst = var_3

	if var_15_0 == var_3.THEME_TEMPLATE_TYPE_COLLECTION then
		local var_15_1 = arg_15_0.listPage

		var_2.ExecuteAction(var_15_1, "ThemeTemplateUpdate", arg_15_1)
	end

	return
end

function var_0_1.SetDorm(arg_16_0, arg_16_1)
	arg_16_0.dorm = arg_16_1

	return
end

function var_0_1.UpdateDorm(arg_17_0, arg_17_1)
	arg_17_0:SetDorm(arg_17_1)

	if arg_17_0.pageType then
		local var_17_0 = arg_17_0.listPage

		var_2.ExecuteAction(var_17_0, "UpdateDorm", arg_17_1)
	end

	return
end

function var_0_1.SetPlayer(arg_18_0, arg_18_1)
	arg_18_0.player = arg_18_1

	return
end

function var_0_1.PlayerUpdated(arg_19_0, arg_19_1)
	arg_19_0:SetPlayer(arg_19_1)
	arg_19_0:UpdateRes()

	if arg_19_0.pageType then
		local var_19_0 = arg_19_0.listPage

		var_2.ExecuteAction(var_19_0, "PlayerUpdated", arg_19_1)
	end

	return
end

function var_0_1.FurnituresUpdated(arg_20_0, arg_20_1)
	if arg_20_0.pageType then
		local var_20_0 = arg_20_0.listPage

		var_2.ExecuteAction(var_20_0, "FurnituresUpdated", arg_20_1)
	end

	return
end

function var_0_1.SearchKeyChange(arg_21_0, arg_21_1)
	if arg_21_0.pageType then
		local var_21_0 = arg_21_0.pageType

		BackYardConst = var_1_10003

		if var_21_0 ~= var_1_10003.THEME_TEMPLATE_TYPE_CUSTOM then
			local var_21_1 = arg_21_0.pageType

			BackYardConst = var_3

			if var_21_1 == var_3.THEME_TEMPLATE_TYPE_COLLECTION then
				local var_21_2 = arg_21_0.listPage

				var_2.ExecuteAction(var_21_2, "SearchKeyChange", arg_21_1)
			end

			return
		end
	end
end

function var_0_1.ShopSearchKeyChange(arg_22_0, arg_22_1)
	if arg_22_0.pageType then
		local var_22_0 = arg_22_0.pageType

		BackYardConst = var_1_10003

		if var_22_0 == var_1_10003.THEME_TEMPLATE_TYPE_SHOP then
			local var_22_1 = arg_22_0.listPage

			var_2.ExecuteAction(var_22_1, "ShopSearchKeyChange", arg_22_1)
		end
	end

	return
end

function var_0_1.ClearShopSearchKey(arg_23_0)
	if arg_23_0.pageType then
		local var_23_0 = arg_23_0.pageType

		BackYardConst = var_1_10002

		if var_23_0 == var_1_10002.THEME_TEMPLATE_TYPE_SHOP then
			local var_23_1 = arg_23_0.listPage

			var_1.ExecuteAction(var_23_1, "ClearShopSearchKey")
		end
	end

	return
end

function var_0_1.DeleteCustomThemeTemplate(arg_24_0, arg_24_1)
	if not arg_24_0.customThemeTemplate then
		return
	end

	pairs = var_2

	for iter_24_0, iter_24_1 in var_2(arg_24_0.customThemeTemplate) do
		if iter_24_1.id == arg_24_1 then
			arg_24_0.customThemeTemplate[iter_24_0] = nil

			break
		end
	end

	if arg_24_0.pageType then
		local var_24_0 = arg_24_0.pageType

		BackYardConst = var_3

		if var_24_0 == var_3.THEME_TEMPLATE_TYPE_CUSTOM then
			local var_24_1 = arg_24_0.listPage

			var_2.ExecuteAction(var_24_1, "DeleteCustomThemeTemplate", arg_24_1)
		end
	end

	return
end

function var_0_1.DeleteCollectionThemeTemplate(arg_25_0, arg_25_1)
	if not arg_25_0.collectionThemeTemplate then
		return
	end

	pairs = var_2

	for iter_25_0, iter_25_1 in var_2(arg_25_0.collectionThemeTemplate) do
		if iter_25_1.id == arg_25_1 then
			arg_25_0.collectionThemeTemplate[iter_25_0] = nil

			break
		end
	end

	if arg_25_0.pageType then
		local var_25_0 = arg_25_0.pageType

		BackYardConst = var_3

		if var_25_0 == var_3.THEME_TEMPLATE_TYPE_COLLECTION then
			local var_25_1 = arg_25_0.listPage

			var_2.ExecuteAction(var_25_1, "DeleteCollectionThemeTemplate", arg_25_1)
		end
	end

	return
end

function var_0_1.DeleteShopThemeTemplate(arg_26_0, arg_26_1)
	if not arg_26_0.shopThemeTemplate then
		return
	end

	pairs = var_2

	for iter_26_0, iter_26_1 in var_2(arg_26_0.shopThemeTemplate) do
		if iter_26_1.id == arg_26_1 then
			arg_26_0.shopThemeTemplate[iter_26_0] = nil

			break
		end
	end

	if arg_26_0.pageType then
		local var_26_0 = arg_26_0.pageType

		BackYardConst = var_3

		if var_26_0 == var_3.THEME_TEMPLATE_TYPE_SHOP then
			local var_26_1 = arg_26_0.listPage

			var_2.ExecuteAction(var_26_1, "DeleteShopThemeTemplate", arg_26_1)
		end
	end

	return
end

function var_0_1.AddCollectionThemeTemplate(arg_27_0, arg_27_1)
	arg_27_0.collectionThemeTemplate[arg_27_1.id] = arg_27_1

	if arg_27_0.pageType then
		local var_27_0 = arg_27_0.pageType

		BackYardConst = var_3

		if var_27_0 == var_3.THEME_TEMPLATE_TYPE_COLLECTION then
			local var_27_1 = arg_27_0.listPage

			var_2.ExecuteAction(var_27_1, "AddCollectionThemeTemplate", arg_27_1.id)
		end
	end

	return
end

function var_0_1.didEnter(arg_28_0)
	onButton = var_1_10001

	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.backBtn

	local function var_28_2()
		local var_29_0 = arg_28_0

		var_0.emit(var_29_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_28_0, var_28_1, var_28_2, var_1_10006)

	onButton = var_1_10001

	local var_28_3 = arg_28_0
	local var_28_4 = arg_28_0.homeBtn

	local function var_28_5()
		local var_30_0 = arg_28_0

		var_0.emit(var_30_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_28_3, var_28_4, var_28_5, var_1_10006)

	onButton = var_1_10001

	local var_28_6 = arg_28_0
	local var_28_7 = arg_28_0.gemAddBtn

	local function var_28_8()
		local var_31_0 = arg_28_0
		local var_31_1 = var_0.emit

		NewBackYardThemeTemplateMediator = var_2_10003

		local var_31_2 = var_2_10003.ON_CHARGE

		PlayerConst = var_2_10004

		var_31_1(var_31_0, var_31_2, var_2_10004.ResDiamond)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_28_6, var_28_7, var_28_8, var_1_10006)

	onButton = var_1_10001

	local var_28_9 = arg_28_0
	local var_28_10 = arg_28_0.goldAddBtn

	local function var_28_11()
		local var_32_0 = arg_28_0
		local var_32_1 = var_0.emit

		NewBackYardThemeTemplateMediator = var_2_10003

		local var_32_2 = var_2_10003.ON_CHARGE

		PlayerConst = var_2_10004

		var_32_1(var_32_0, var_32_2, var_2_10004.ResDormMoney)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_28_9, var_28_10, var_28_11, var_1_10006)

	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_33_0)
			local var_33_0 = arg_28_0
			local var_33_1 = var_1.emit

			NewBackYardThemeTemplateMediator = var_2_10004

			var_33_1(var_33_0, var_2_10004.FETCH_ALL_THEME, arg_33_0)

			return
		end
	}, function()
		local var_34_0 = arg_28_0

		var_0.InitPages(var_34_0)

		local var_34_1 = arg_28_0

		var_0.UpdateRes(var_34_1)

		local var_34_2 = arg_28_0

		var_0.ActiveDefaultPage(var_34_2)

		return
	end)

	return
end

function var_0_1.InitPages(arg_35_0)
	arg_35_0.btns = {}
	pairs = var_1

	for iter_35_0, iter_35_1 in var_1(arg_35_0.tags) do
		cloneTplTo = var_1_10006

		local var_35_0 = var_1_10006(arg_35_0.tpl, arg_35_0.container)
		local var_35_1 = var_1_10006.Find(var_35_0, "unsel")
		local var_35_2 = var_7.GetComponent

		typeof = var_10
		Image = var_1_10012

		local var_35_3 = var_35_2(var_35_1, var_10(var_1_10012))

		GetSpriteFromAtlas = var_8
		var_35_3.sprite = var_8("ui/NewBackYardShopUI_atlas", "text_tp_" .. iter_35_0)

		var_35_3:SetNativeSize()

		local var_35_4 = var_1_10006:Find("sel/Text")
		local var_35_5 = var_8.GetComponent

		typeof = var_11
		Image = var_1_10013

		local var_35_6 = var_35_5(var_35_4, var_11(var_1_10013))

		GetSpriteFromAtlas = var_35_1
		var_35_6.sprite = var_35_1("ui/NewBackYardShopUI_atlas", "text_tp_" .. iter_35_0)

		var_35_6:SetNativeSize()

		setActive = var_9
		var_1_10013 = var_1_10006

		local var_35_7 = var_1_10006.Find(var_1_10013, "line")

		BackYardConst = var_1_10012
		var_1_10012 = iter_35_0 ~= var_1_10012.THEME_TEMPLATE_TYPE_COLLECTION

		var_9(var_35_7, var_1_10012)
		var_0_2(arg_35_0, var_1_10006, function()
			local var_36_0 = arg_35_0
			local var_36_1 = var_0.GetDataForType(var_36_0, iter_35_0)
			local var_36_2 = arg_35_0.listPage

			var_1.ExecuteAction(var_36_2, "SetUp", iter_35_0, var_36_1, arg_35_0.dorm, arg_35_0.player)

			arg_35_0.pageType = iter_35_0

			return true
		end)

		arg_35_0.btns[iter_35_0] = var_1_10006
	end

	setActive = var_1

	var_1(arg_35_0.tpl, false)

	return
end

function var_0_1.ActiveDefaultPage(arg_37_0)
	local var_37_0

	if not arg_37_0.contextData.page then
		BackYardConst = var_37_0
		var_37_0 = var_37_0.THEME_TEMPLATE_TYPE_CUSTOM
	end

	triggerButton = var_1_10002

	var_1_10002(arg_37_0.btns[var_37_0])

	return
end

function var_0_1.GetDataForType(arg_38_0, arg_38_1)
	BackYardConst = var_1_10002

	local var_38_0

	if arg_38_1 == var_1_10002.THEME_TEMPLATE_TYPE_SHOP then
		var_38_0 = {}
		pairs = var_1_10003

		for iter_38_0, iter_38_1 in var_1_10003(arg_38_0.shopThemeTemplate) do
			table = var_1_10008

			var_1_10008.insert(var_38_0, iter_38_1)
		end

		var_1_10003 = var_38_0 or {}

		return var_1_10003
	else
		BackYardConst = var_38_0

		if arg_38_1 == var_38_0.THEME_TEMPLATE_TYPE_CUSTOM then
			var_38_0 = {}
			pairs = var_1_10003

			for iter_38_2, iter_38_3 in var_1_10003(arg_38_0.customThemeTemplate) do
				if iter_38_3:CanDispaly() then
					table = var_1_10008

					var_1_10008.insert(var_38_0, iter_38_3)
				end
			end

			return var_38_0
		else
			BackYardConst = var_38_0

			if arg_38_1 == var_38_0.THEME_TEMPLATE_TYPE_COLLECTION then
				var_38_0 = {}
				pairs = var_1_10003

				for iter_38_4, iter_38_5 in var_1_10003(arg_38_0.collectionThemeTemplate) do
					table = var_1_10008

					var_1_10008.insert(var_38_0, iter_38_5)
				end

				return var_38_0 or {}
			end
		end
	end

	assert = var_38_0

	var_38_0(false)

	return
end

function var_0_1.UpdateRes(arg_39_0)
	local var_39_0 = arg_39_0.goldTxt
	local var_39_1 = arg_39_0.player
	local var_39_2 = var_2.getResource

	PlayerConst = var_1_10005
	var_39_0.text = var_39_2(var_39_1, var_1_10005.ResDormMoney)

	local var_39_3 = arg_39_0.gemTxt
	local var_39_4 = arg_39_0.player

	var_39_3.text = var_2.getTotalGem(var_39_4)

	return
end

function var_0_1.willExit(arg_40_0)
	_backYardThemeTemplateMsgbox = var_1_10001

	var_1_10001:Destroy()

	local var_40_0
	local var_40_1 = _backYardThemeTemplateMsgbox
	local var_40_2 = arg_40_0.listPage

	var_1.Destroy(var_40_2)

	local var_40_3 = arg_40_0.contextData.msgBox

	var_1.Destroy(var_40_3)

	BackYardThemeTempalteUtil = var_1

	var_1.ClearAllCache()

	return
end

return var_0_1
