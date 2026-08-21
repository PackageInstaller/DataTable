local var_0_0 = class("BackYardThemePage", import(".BackYardShopBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "BackYardThemePage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0:LoadList()
	arg_2_0:LoadDetail()

	arg_2_0.largeSpLoader = BackYardLargeSpriteLoader.New(6)

	return
end

function var_0_0.LoadList(arg_3_0)
	arg_3_0._parentTF = arg_3_0._tf.parent
	arg_3_0.adpter = arg_3_0._tf:Find("adpter")
	arg_3_0.themeContainer = arg_3_0._tf:Find("list/frame")
	arg_3_0.scrollRect = arg_3_0._tf:Find("list/frame/mask/content"):GetComponent("LScrollRect")
	arg_3_0.scrollRectWidth = arg_3_0._tf:Find("list/frame/mask").rect.width
	arg_3_0.searchInput = arg_3_0._tf:Find("adpter/search")
	arg_3_0.searchClear = arg_3_0.searchInput:Find("clear")

	setText(arg_3_0.searchInput:Find("Placeholder"), i18n("courtyard_label_search_holder"))

	return
end

function var_0_0.LoadDetail(arg_4_0)
	arg_4_0.purchaseBtn = arg_4_0._tf:Find("adpter/descript/btn_goumai")
	arg_4_0.title = arg_4_0._tf:Find("adpter/descript/title"):GetComponent(typeof(Text))
	arg_4_0.desc = arg_4_0._tf:Find("adpter/descript/desc"):GetComponent(typeof(Text))
	arg_4_0.actualPrice = arg_4_0._tf:Find("adpter/descript/price/actual_price")
	arg_4_0.actualPriceTxt = arg_4_0._tf:Find("adpter/descript/price/actual_price/Text"):GetComponent(typeof(Text))
	arg_4_0.goldTxt = arg_4_0._tf:Find("adpter/descript/price/price/Text"):GetComponent(typeof(Text))
	arg_4_0.preview = arg_4_0._tf:Find("preview"):GetComponent(typeof(Image))
	arg_4_0.descript = arg_4_0._tf:Find("adpter/descript")
	arg_4_0.infoPage = BackYardThemeInfoPage.New(arg_4_0._tf.parent, arg_4_0.event, arg_4_0.contextData)

	function arg_4_0.infoPage.OnEnter()
		arg_4_0:UnBlurView()

		return
	end

	function arg_4_0.infoPage.OnExit()
		arg_4_0:BlurView()

		return
	end

	function arg_4_0.infoPage.OnPrevTheme()
		arg_4_0:OnInfoPagePrevTheme()

		return
	end

	function arg_4_0.infoPage.OnNextTheme()
		arg_4_0:OnInfoPageNextTheme()

		return
	end

	onButton(arg_4_0, arg_4_0.purchaseBtn, function()
		arg_4_0.infoPage:ExecuteAction("SetUp", arg_4_0:GetSelectedIndex(), arg_4_0.selected, arg_4_0.dorm, arg_4_0.player)

		return
	end, SFX_PANEL)
	setText(arg_4_0.purchaseBtn:Find("Text"), i18n("word_buy"))

	return
end

function var_0_0.OnInit(arg_10_0)
	arg_10_0.cards = {}

	function arg_10_0.scrollRect.onInitItem(arg_11_0)
		arg_10_0:OnInitCard(arg_11_0)

		return
	end

	function arg_10_0.scrollRect.onUpdateItem(arg_12_0, arg_12_1)
		arg_10_0:OnUpdateCard(arg_12_0, arg_12_1)

		return
	end

	arg_10_0:InitInput()
	onButton(arg_10_0, arg_10_0.searchClear, function()
		setInputText(arg_10_0.searchInput, "")

		return
	end, SFX_PANEL)

	return
end

function var_0_0.InitInput(arg_14_0)
	onInputChanged(arg_14_0, arg_14_0.searchInput, function()
		setActive(arg_14_0.searchClear, getInputText(arg_14_0.searchInput) ~= "")
		arg_14_0:OnSearchKeyChange()

		return
	end)

	return
end

function var_0_0.GetData(arg_16_0)
	local var_16_0 = getInputText(arg_16_0.searchInput)
	local var_16_1 = arg_16_0.dorm:GetPurchasedFurnitures()
	local var_16_2 = {}

	for iter_16_0, iter_16_1 in ipairs((getProxy(DormProxy):GetSystemThemes())) do
		if not iter_16_1:IsOverTime() and iter_16_1:MatchSearchKey(var_16_0) then
			table.insert({}, iter_16_1)

			var_16_2[iter_16_1.id] = iter_16_1:IsPurchased(var_16_1) and 1 or 0
		end
	end

	local var_16_3 = pg.backyard_theme_template

	local function var_16_4(arg_17_0, arg_17_1)
		if var_16_3[arg_17_0.id].hot == var_16_3[arg_17_1.id].hot then
			return var_16_3[arg_17_0.id].order > var_16_3[arg_17_1.id].order
		else
			return var_16_3[arg_17_0.id].hot > var_16_3[arg_17_1.id].hot
		end

		return
	end

	table.sort({}, function(arg_18_0, arg_18_1)
		local var_18_0 = var_16_2[arg_18_0.id]
		local var_18_1 = var_16_2[arg_18_1.id]

		if var_16_2[arg_18_0.id] == var_16_2[arg_18_1.id] then
			if var_16_3[arg_18_0.id].new == var_16_3[arg_18_1.id].new then
				return var_16_4(arg_18_0, arg_18_1)
			else
				return var_16_3[arg_18_0.id].new > var_16_3[arg_18_1.id].new
			end
		else
			return var_18_0 < var_18_1
		end

		return
	end)

	return {}
end

function var_0_0.FurnituresUpdated(arg_19_0, arg_19_1)
	if arg_19_0.infoPage:GetLoaded() then
		arg_19_0.infoPage:ExecuteAction("FurnituresUpdated", arg_19_1)
	end

	if arg_19_0.card then
		arg_19_0:UpdatePrice(arg_19_0.card)
	end

	arg_19_0:InitThemeList()

	return
end

function var_0_0.OnDormUpdated(arg_20_0)
	if arg_20_0.infoPage:GetLoaded() then
		arg_20_0.infoPage:ExecuteAction("DormUpdated", arg_20_0.dorm)
	end

	return
end

function var_0_0.OnPlayerUpdated(arg_21_0)
	if arg_21_0.infoPage:GetLoaded() then
		arg_21_0.infoPage:ExecuteAction("OnPlayerUpdated", arg_21_0.player)
	end

	return
end

function var_0_0.OnSetUp(arg_22_0)
	arg_22_0:InitThemeList()
	arg_22_0:BlurView()

	return
end

function var_0_0.InitThemeList(arg_23_0)
	arg_23_0.disPlays = arg_23_0:GetData()

	onNextTick(function()
		arg_23_0.scrollRect.enabled = true

		arg_23_0.scrollRect:SetTotalCount(#arg_23_0.disPlays)

		return
	end)

	return
end

function var_0_0.OnSearchKeyChange(arg_25_0)
	arg_25_0:InitThemeList()

	return
end

function var_0_0.CreateCard(arg_26_0, arg_26_1)
	return (BackYardThemeCard.New(arg_26_1))
end

function var_0_0.OnInitCard(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:CreateCard(arg_27_1)

	onButton(arg_27_0, var_27_0._go, function()
		arg_27_0:OnCardClick(var_27_0)

		arg_27_0.selected = var_27_0.themeVO

		if arg_27_0.selected then
			for iter_28_0, iter_28_1 in pairs(arg_27_0.cards) do
				if iter_28_1.themeVO.id == arg_27_0.selected.id and iter_28_1._go.name ~= "-1" then
					preCard = iter_28_1

					break
				end
			end

			if preCard then
				preCard:UpdateSelected(arg_27_0.selected)
			end
		end

		var_27_0:UpdateSelected(arg_27_0.selected)

		return
	end, SFX_PANEL)

	arg_27_0.cards[arg_27_1] = var_27_0

	return
end

function var_0_0.OnUpdateCard(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_0.cards[arg_29_2] then
		arg_29_0:OnInitCard(arg_29_2)
	end

	local var_29_0 = arg_29_0.cards[arg_29_2]

	arg_29_0.cards[arg_29_2]:Update(arg_29_0.disPlays[arg_29_1 + 1], arg_29_0.disPlays[arg_29_1 + 1]:IsPurchased((arg_29_0.dorm:GetPurchasedFurnitures())))
	var_29_0:UpdateSelected(arg_29_0.selected)

	if arg_29_0:NoSelected() and arg_29_1 == 0 then
		triggerButton(var_29_0._go)
	end

	return
end

function var_0_0.NoSelected(arg_30_0)
	return not arg_30_0.selected or not _.any(arg_30_0.disPlays, function(arg_31_0)
		return arg_31_0.id == arg_30_0.selected.id
	end)
end

function var_0_0.OnCardClick(arg_32_0, arg_32_1)
	arg_32_0:UpdateMainPage(arg_32_1.themeVO)

	return
end

function var_0_0.UpdateMainPage(arg_33_0, arg_33_1)
	if arg_33_1 == arg_33_0.card then
		return
	end

	arg_33_0.title.text = string.gsub(string.gsub(arg_33_1:getConfig("name"), "<size=%d+>", ""), "</size>", "")
	arg_33_0.desc.text = arg_33_1:getConfig("desc")

	local var_33_0 = arg_33_1:getConfig("discount")

	setActive(arg_33_0.actualPrice, (arg_33_1:HasDiscount()))
	arg_33_0:UpdatePrice(arg_33_1)
	arg_33_0.largeSpLoader:LoadSpriteAsync("BackYardTheme/theme_" .. arg_33_1.id, function(arg_34_0)
		if IsNil(arg_33_0.preview) then
			return
		end

		arg_33_0.preview.sprite = arg_34_0
		arg_33_0.preview.enabled = true

		return
	end)

	arg_33_0.card = arg_33_1

	return
end

function var_0_0.UpdatePrice(arg_35_0, arg_35_1)
	local var_35_0, var_35_1 = arg_35_0:CalcThemePrice(arg_35_1)

	arg_35_0.actualPriceTxt.text = var_35_1
	arg_35_0.goldTxt.text = var_35_0

	return
end

function var_0_0.GetAddList(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.dorm:GetPurchasedFurnitures()

	for iter_36_0, iter_36_1 in ipairs((arg_36_1:GetFurnitures())) do
		if not var_36_0[iter_36_1] then
			table.insert({}, Furniture.New({
				id = iter_36_1
			}))
		end
	end

	return {}
end

function var_0_0.CalcThemePrice(arg_37_0, arg_37_1)
	local var_37_0 = 0
	local var_37_1 = 0

	for iter_37_0, iter_37_1 in ipairs((arg_37_0:GetAddList(arg_37_1))) do
		var_37_1 = var_37_1 + iter_37_1:getConfig("dorm_icon_price")
		var_37_0 = var_37_0 + iter_37_1:getPrice(PlayerConst.ResDormMoney)
	end

	return var_37_0, var_37_1
end

local function var_0_1(arg_38_0, arg_38_1)
	local var_38_0

	for iter_38_0, iter_38_1 in pairs(arg_38_0) do
		if iter_38_1.themeVO.id == arg_38_1.id then
			var_38_0 = iter_38_1

			break
		end
	end

	return var_38_0
end

local function var_0_2(arg_39_0, arg_39_1, arg_39_2)
	return math.abs(arg_39_0:HeadIndexToValue(arg_39_2) - arg_39_0:HeadIndexToValue(arg_39_1))
end

function var_0_0.GetSelectedIndex(arg_40_0)
	local var_40_0 = 0

	for iter_40_0, iter_40_1 in ipairs(arg_40_0.disPlays) do
		if iter_40_1.id == arg_40_0.selected.id then
			var_40_0 = iter_40_0

			break
		end
	end

	return var_40_0
end

function var_0_0.OnSwitchToNextTheme(arg_41_0)
	local var_41_0 = arg_41_0:GetSelectedIndex()

	if var_41_0 >= #arg_41_0.disPlays then
		return false
	end

	local var_41_1 = arg_41_0.disPlays[var_41_0 + 1]
	local var_41_2 = var_0_1(arg_41_0.cards, arg_41_0.disPlays[var_41_0 + 1])

	if var_41_2 then
		if var_41_2 and (function(arg_42_0)
			local var_42_0 = go(arg_41_0.scrollRect).transform.parent

			return go(arg_41_0.scrollRect).transform.localPosition.x + arg_41_0.scrollRectWidth / 2 < var_42_0:InverseTransformPoint(arg_42_0._tf.position).x
		end)(var_41_2) then
			arg_41_0.scrollRect:ScrollTo(arg_41_0.scrollRect.value + var_0_2(arg_41_0.scrollRect, 1, 2), true)

			var_41_2 = var_0_1(arg_41_0.cards, var_41_1)
		end

		if var_41_2 then
			triggerButton(var_41_2._go)
		end

		return true
	end
end

function var_0_0.OnSwitchToPrevTheme(arg_43_0)
	local var_43_0 = arg_43_0:GetSelectedIndex()

	if var_43_0 <= 1 then
		return false
	end

	local var_43_1 = arg_43_0.disPlays[var_43_0 - 1]
	local var_43_2 = var_0_1(arg_43_0.cards, arg_43_0.disPlays[var_43_0 - 1])

	if var_43_2 then
		if var_43_2 and (function(arg_44_0)
			local var_44_0 = go(arg_43_0.scrollRect).transform.parent

			return go(arg_43_0.scrollRect).transform.localPosition.x - arg_43_0.scrollRectWidth / 2 > var_44_0:InverseTransformPoint(arg_44_0._tf.position).x
		end)(var_43_2) then
			arg_43_0.scrollRect:ScrollTo(arg_43_0.scrollRect.value - var_0_2(arg_43_0.scrollRect, 1, 2), true)

			var_43_2 = var_0_1(arg_43_0.cards, var_43_1)
		end

		if var_43_2 then
			triggerButton(var_43_2._go)
		end

		return true
	end
end

function var_0_0.OnInfoPagePrevTheme(arg_45_0)
	if arg_45_0:OnSwitchToPrevTheme() then
		triggerButton(arg_45_0.purchaseBtn)
	end

	return
end

function var_0_0.OnInfoPageNextTheme(arg_46_0)
	if arg_46_0:OnSwitchToNextTheme() then
		triggerButton(arg_46_0.purchaseBtn)
	end

	return
end

function var_0_0.Hide(arg_47_0)
	var_0_0.super.Hide(arg_47_0)
	arg_47_0:UnBlurView()

	return
end

function var_0_0.BlurView(arg_48_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_48_0.adpter, {
		pbList = {
			arg_48_0._tf:Find("adpter/descript")
		}
	})

	return
end

function var_0_0.UnBlurView(arg_49_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_49_0.adpter, arg_49_0._tf)

	return
end

function var_0_0.OnDestroy(arg_50_0)
	if arg_50_0.largeSpLoader then
		arg_50_0.largeSpLoader:Dispose()

		arg_50_0.largeSpLoader = nil
	end

	if arg_50_0.infoPage then
		arg_50_0.infoPage.OnExit = nil
		arg_50_0.infoPage.OnEnter = nil
		arg_50_0.infoPage.OnPrevTheme = nil
		arg_50_0.infoPage.OnNextTheme = nil

		arg_50_0.infoPage:Destroy()
	end

	local var_50_1 = arg_50_0.cards or {}

	for iter_50_0, iter_50_1 in var_50_0(var_50_1) do
		iter_50_1:Dispose()
	end

	arg_50_0.cards = nil

	arg_50_0:Hide()

	return
end

return var_0_0
