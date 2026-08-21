local var_0_0 = class("NewBackYardShopLayer", import("...base.BaseUI"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 6
local var_0_7 = 7
local var_0_8 = {
	"word_theme",
	"word_wallpaper",
	"word_floorpaper",
	"word_furniture",
	"word_shipskin",
	"word_decorate",
	"word_wall"
}

local function var_0_10(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0(arg_3_0, arg_3_1)
		setActive(arg_3_0:Find("sel"), arg_3_1)
		setActive(arg_3_0:Find("unsel"), not arg_3_1)

		return
	end

	onButton(arg_2_0, arg_2_1, function()
		if not arg_2_2() then
			return
		end

		if arg_2_0.btn then
			var_2_0(arg_2_0.btn, false)
		end

		var_2_0(arg_2_1, true)

		arg_2_0.btn = arg_2_1

		return
	end, SFX_PANEL)
	;(function(arg_3_0, arg_3_1)
		setActive(arg_3_0:Find("sel"), arg_3_1)
		setActive(arg_3_0:Find("unsel"), not arg_3_1)

		return
	end)(arg_2_1, false)

	return
end

function var_0_0.forceGC(arg_5_0)
	return true
end

function var_0_0.getUIName(arg_6_0)
	return "NewBackYardShopUI"
end

function var_0_0.SetDorm(arg_7_0, arg_7_1)
	arg_7_0.dorm = arg_7_1

	return
end

function var_0_0.SetPlayer(arg_8_0, arg_8_1)
	arg_8_0.player = arg_8_1

	return
end

function var_0_0.PlayerUpdated(arg_9_0, arg_9_1)
	arg_9_0:SetPlayer(arg_9_1)
	arg_9_0:UpdateRes()

	if arg_9_0.pageType then
		arg_9_0.pages[arg_9_0.pageType]:ExecuteAction("PlayerUpdated", arg_9_1)
	end

	return
end

function var_0_0.DormUpdated(arg_10_0, arg_10_1)
	arg_10_0:SetDorm(arg_10_1)

	if arg_10_0.pageType then
		arg_10_0.pages[arg_10_0.pageType]:ExecuteAction("DormUpdated", arg_10_1)
	end

	return
end

function var_0_0.FurnituresUpdated(arg_11_0, arg_11_1)
	if arg_11_0.pageType then
		arg_11_0.pages[arg_11_0.pageType]:ExecuteAction("FurnituresUpdated", arg_11_1)
	end

	return
end

function var_0_0.init(arg_12_0)
	arg_12_0.pageContainer = arg_12_0._tf:Find("pages")
	arg_12_0.adpter = arg_12_0._tf:Find("adpter")
	arg_12_0.btnTpl = arg_12_0._tf:Find("adpter/tag/list/tpl")
	arg_12_0.btnContainer = arg_12_0._tf:Find("adpter/tag/list")
	arg_12_0.backBtn = arg_12_0._tf:Find("adpter/top/fanhui")
	arg_12_0.goldTxt = arg_12_0._tf:Find("adpter/top/res_gold/Text"):GetComponent(typeof(Text))
	arg_12_0.gemTxt = arg_12_0._tf:Find("adpter/top/res_gem/Text"):GetComponent(typeof(Text))
	arg_12_0.goldAddBtn = arg_12_0._tf:Find("adpter/top/res_gold/jiahao")
	arg_12_0.gemAddBtn = arg_12_0._tf:Find("adpter/top/res_gem/jiahao")
	arg_12_0.help = arg_12_0._tf:Find("adpter/top/help")
	arg_12_0.themePage = BackYardThemePage.New(arg_12_0.pageContainer, arg_12_0.event, arg_12_0.contextData)
	arg_12_0.furniturePage = BackYardFurniturePage.New(arg_12_0.pageContainer, arg_12_0.event, arg_12_0.contextData)
	arg_12_0.contextData.filterPanel = BackYardShopFilterPanel.New(arg_12_0._tf, arg_12_0.event, arg_12_0.contextData)
	arg_12_0.pages = {
		[var_0_1] = arg_12_0.themePage,
		[var_0_2] = arg_12_0.furniturePage,
		[var_0_3] = arg_12_0.furniturePage,
		[var_0_4] = arg_12_0.furniturePage,
		[var_0_5] = arg_12_0.furniturePage,
		[var_0_6] = arg_12_0.furniturePage,
		[var_0_7] = arg_12_0.furniturePage
	}
	arg_12_0.contextData.furnitureMsgBox = BackYardFurnitureMsgBoxPage.New(arg_12_0._tf, arg_12_0.event)
	arg_12_0.contextData.themeMsgBox = BackYardThemeMsgBoxPage.New(arg_12_0._tf, arg_12_0.event)
	arg_12_0.contextData.themeAllMsgBox = BackYardThemeMsgBoxForAllPage.New(arg_12_0._tf, arg_12_0.event)

	return
end

function var_0_0.didEnter(arg_13_0)
	onButton(arg_13_0, arg_13_0.backBtn, function()
		if arg_13_0.contextData.onDeattch then
			arg_13_0.contextData.onDeattch()
		end

		arg_13_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_13_0, arg_13_0.help, function()
		arg_13_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_13_0, arg_13_0.goldAddBtn, function()
		arg_13_0:emit(NewBackYardShopMediator.ON_CHARGE, PlayerConst.ResDormMoney)

		return
	end, SFX_PANEL)
	onButton(arg_13_0, arg_13_0.gemAddBtn, function()
		arg_13_0:emit(NewBackYardShopMediator.ON_CHARGE, PlayerConst.ResDiamond)

		return
	end, SFX_PANEL)
	arg_13_0:InitPageFooter()
	arg_13_0:UpdateRes()

	local var_13_0 = arg_13_0.contextData.page or var_0_1

	triggerButton(arg_13_0.btns[var_13_0])

	if arg_13_0.contextData.topLayer then
		local var_13_1 = GetOrAddComponent(arg_13_0._tf, typeof(Canvas))

		var_13_1.overrideSorting = true
		var_13_1.sortingOrder = 900

		GetOrAddComponent(arg_13_0._tf, typeof(GraphicRaycaster))
	end

	getProxy(SettingsProxy):UpdateNewThemeValue()

	return
end

function var_0_0.UpdateRes(arg_18_0)
	arg_18_0.goldTxt.text = arg_18_0.player:getResource(PlayerConst.ResDormMoney)
	arg_18_0.gemTxt.text = arg_18_0.player:getTotalGem()

	return
end

local var_0_11 = {
	"0",
	"1",
	"4",
	"2",
	"8",
	"3",
	"6",
	"7"
}

function var_0_0.InitPageFooter(arg_19_0)
	arg_19_0.btns = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.pages) do
		local var_19_0 = cloneTplTo(arg_19_0.btnTpl, arg_19_0.btnContainer)
		local var_19_1 = var_19_0:Find("unsel"):GetComponent(typeof(Image))

		var_19_1.sprite = GetSpriteFromAtlas("ui/NewBackYardShopUI_atlas", "text_tag" .. iter_19_0 - 1)

		var_19_1:SetNativeSize()

		local var_19_2 = var_19_0:Find("sel/Text"):GetComponent(typeof(Image))

		var_19_2.sprite = GetSpriteFromAtlas("ui/NewBackYardShopUI_atlas", "text_tag" .. iter_19_0 - 1)

		var_19_2:SetNativeSize()

		local var_19_3 = var_19_0:Find("sel/icon"):GetComponent(typeof(Image))

		LoadSpriteAtlasAsync("ui/CourtyardUI_atlas", "icon_" .. var_0_11[iter_19_0], function(arg_20_0)
			if arg_19_0.exited then
				return
			end

			var_19_3.sprite = arg_20_0

			return
		end)
		var_0_10(arg_19_0, var_19_0, function()
			if arg_19_0.pageType == iter_19_0 then
				return
			end

			if arg_19_0.pageType and not arg_19_0.pages[arg_19_0.pageType]:GetLoaded() then
				return
			end

			if arg_19_0.pageType and arg_19_0.pages[arg_19_0.pageType] ~= iter_19_1 then
				arg_19_0.pages[arg_19_0.pageType]:Hide()
			end

			iter_19_1:ExecuteAction("SetUp", iter_19_0, arg_19_0.dorm, arg_19_0.player, function()
				return
			end)

			arg_19_0.pageType = iter_19_0

			if iter_19_0 == 5 then
				getProxy(SettingsProxy):UpdateNewGemFurnitureValue()
				arg_19_0:UpdateSpecialPageFooter()
			end

			return true
		end)

		arg_19_0.btns[iter_19_0] = var_19_0
	end

	arg_19_0:UpdateSpecialPageFooter()
	setActive(arg_19_0.btnTpl, false)

	return
end

function var_0_0.UpdateSpecialPageFooter(arg_23_0)
	setActive(arg_23_0.btns[5]:Find("new"), getProxy(SettingsProxy):IsTipNewGemFurniture())

	return
end

function var_0_0.willExit(arg_24_0)
	arg_24_0.isOverlay = false

	arg_24_0.contextData.filterPanel:Destroy()
	arg_24_0.themePage:Destroy()
	arg_24_0.furniturePage:Destroy()
	arg_24_0.contextData.furnitureMsgBox:Destroy()

	arg_24_0.contextData.furnitureMsgBox = nil

	arg_24_0.contextData.themeMsgBox:Destroy()

	arg_24_0.contextData.themeMsgBox = nil

	return
end

return var_0_0
