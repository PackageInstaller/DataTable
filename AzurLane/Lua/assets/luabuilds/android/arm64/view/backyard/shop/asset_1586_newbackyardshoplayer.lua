class = var_0_10000

local var_0_0 = "NewBackYardShopLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 6
local var_0_8 = 7
local var_0_9 = {
	"word_theme",
	"word_wallpaper",
	"word_floorpaper",
	"word_furniture",
	"word_shipskin",
	"word_decorate",
	"word_wall"
}

local function var_0_10(arg_1_0)
	i18n = var_1_10001

	return var_1_10001(var_0_9[arg_1_0])
end

local function var_0_11(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0(arg_3_0, arg_3_1)
		setActive = var_2_10002

		var_2_10002(arg_3_0:Find("sel"), arg_3_1)

		setActive = var_2_10002

		var_2_10002(arg_3_0:Find("unsel"), not arg_3_1)

		return
	end

	onButton = var_1_10004

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_1

	local function var_2_3()
		if not arg_2_2() then
			return
		end

		if arg_2_0.btn then
			var_2_0(arg_2_0.btn, false)
		end

		var_2_0(arg_2_1, true)

		arg_2_0.btn = arg_2_1

		return
	end

	SFX_PANEL = var_1_10009

	var_1_10004(var_2_1, var_2_2, var_2_3, var_1_10009)
	var_2_0(arg_2_1, false)

	return
end

function var_0_1.forceGC(arg_5_0)
	return true
end

function var_0_1.getUIName(arg_6_0)
	return "NewBackYardShopUI"
end

function var_0_1.SetDorm(arg_7_0, arg_7_1)
	arg_7_0.dorm = arg_7_1

	return
end

function var_0_1.SetPlayer(arg_8_0, arg_8_1)
	arg_8_0.player = arg_8_1

	return
end

function var_0_1.PlayerUpdated(arg_9_0, arg_9_1)
	arg_9_0:SetPlayer(arg_9_1)
	arg_9_0:UpdateRes()

	if arg_9_0.pageType then
		local var_9_0 = arg_9_0.pages[arg_9_0.pageType]

		var_2.ExecuteAction(var_9_0, "PlayerUpdated", arg_9_1)
	end

	return
end

function var_0_1.DormUpdated(arg_10_0, arg_10_1)
	arg_10_0:SetDorm(arg_10_1)

	if arg_10_0.pageType then
		local var_10_0 = arg_10_0.pages[arg_10_0.pageType]

		var_2.ExecuteAction(var_10_0, "DormUpdated", arg_10_1)
	end

	return
end

function var_0_1.FurnituresUpdated(arg_11_0, arg_11_1)
	if arg_11_0.pageType then
		local var_11_0 = arg_11_0.pages[arg_11_0.pageType]

		var_2.ExecuteAction(var_11_0, "FurnituresUpdated", arg_11_1)
	end

	return
end

function var_0_1.init(arg_12_0)
	local var_12_0 = arg_12_0._tf

	arg_12_0.pageContainer = var_1.Find(var_12_0, "pages")

	local var_12_1 = arg_12_0._tf

	arg_12_0.adpter = var_1.Find(var_12_1, "adpter")

	local var_12_2 = arg_12_0._tf

	arg_12_0.btnTpl = var_1.Find(var_12_2, "adpter/tag/list/tpl")

	local var_12_3 = arg_12_0._tf

	arg_12_0.btnContainer = var_1.Find(var_12_3, "adpter/tag/list")

	local var_12_4 = arg_12_0._tf

	arg_12_0.backBtn = var_1.Find(var_12_4, "adpter/top/fanhui")

	local var_12_5 = arg_12_0._tf
	local var_12_6 = var_1.Find(var_12_5, "adpter/top/res_gold/Text")
	local var_12_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_12_0.goldTxt = var_12_7(var_12_6, var_4(var_1_10006))

	local var_12_8 = arg_12_0._tf
	local var_12_9 = var_1.Find(var_12_8, "adpter/top/res_gem/Text")
	local var_12_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_12_0.gemTxt = var_12_10(var_12_9, var_4(var_1_10006))

	local var_12_11 = arg_12_0._tf

	arg_12_0.goldAddBtn = var_1.Find(var_12_11, "adpter/top/res_gold/jiahao")

	local var_12_12 = arg_12_0._tf

	arg_12_0.gemAddBtn = var_1.Find(var_12_12, "adpter/top/res_gem/jiahao")

	local var_12_13 = arg_12_0._tf

	arg_12_0.help = var_1.Find(var_12_13, "adpter/top/help")
	BackYardThemePage = var_1
	arg_12_0.themePage = var_1.New(arg_12_0.pageContainer, arg_12_0.event, arg_12_0.contextData)
	BackYardFurniturePage = var_1
	arg_12_0.furniturePage = var_1.New(arg_12_0.pageContainer, arg_12_0.event, arg_12_0.contextData)

	local var_12_14 = arg_12_0.contextData

	BackYardShopFilterPanel = var_1_10002
	var_12_14.filterPanel = var_1_10002.New(arg_12_0._tf, arg_12_0.event, arg_12_0.contextData)
	arg_12_0.pages = {
		[var_0_2] = arg_12_0.themePage,
		[var_0_3] = arg_12_0.furniturePage,
		[var_0_4] = arg_12_0.furniturePage,
		[var_0_5] = arg_12_0.furniturePage,
		[var_0_6] = arg_12_0.furniturePage,
		[var_0_7] = arg_12_0.furniturePage,
		[var_0_8] = arg_12_0.furniturePage
	}

	local var_12_15 = arg_12_0.contextData

	BackYardFurnitureMsgBoxPage = var_2
	var_12_15.furnitureMsgBox = var_2.New(arg_12_0._tf, arg_12_0.event)

	local var_12_16 = arg_12_0.contextData

	BackYardThemeMsgBoxPage = var_2
	var_12_16.themeMsgBox = var_2.New(arg_12_0._tf, arg_12_0.event)

	local var_12_17 = arg_12_0.contextData

	BackYardThemeMsgBoxForAllPage = var_2
	var_12_17.themeAllMsgBox = var_2.New(arg_12_0._tf, arg_12_0.event)

	return
end

function var_0_1.didEnter(arg_13_0)
	onButton = var_1_10001

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.backBtn

	local function var_13_2()
		if arg_13_0.contextData.onDeattch then
			arg_13_0.contextData.onDeattch()
		end

		local var_14_0 = arg_13_0

		var_0.emit(var_14_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_13_0, var_13_1, var_13_2, var_1_10006)

	onButton = var_1_10001

	local var_13_3 = arg_13_0
	local var_13_4 = arg_13_0.help

	local function var_13_5()
		local var_15_0 = arg_13_0

		var_0.emit(var_15_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_13_3, var_13_4, var_13_5, var_1_10006)

	onButton = var_1_10001

	local var_13_6 = arg_13_0
	local var_13_7 = arg_13_0.goldAddBtn

	local function var_13_8()
		local var_16_0 = arg_13_0
		local var_16_1 = var_0.emit

		NewBackYardShopMediator = var_2_10003

		local var_16_2 = var_2_10003.ON_CHARGE

		PlayerConst = var_2_10004

		var_16_1(var_16_0, var_16_2, var_2_10004.ResDormMoney)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_13_6, var_13_7, var_13_8, var_1_10006)

	onButton = var_1_10001

	local var_13_9 = arg_13_0
	local var_13_10 = arg_13_0.gemAddBtn

	local function var_13_11()
		local var_17_0 = arg_13_0
		local var_17_1 = var_0.emit

		NewBackYardShopMediator = var_2_10003

		local var_17_2 = var_2_10003.ON_CHARGE

		PlayerConst = var_2_10004

		var_17_1(var_17_0, var_17_2, var_2_10004.ResDiamond)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_13_9, var_13_10, var_13_11, var_1_10006)
	arg_13_0:InitPageFooter()
	arg_13_0:UpdateRes()

	local var_13_12

	if not arg_13_0.contextData.page then
		var_13_12 = var_0_2
	end

	triggerButton = var_1_10002

	var_1_10002(arg_13_0.btns[var_13_12])

	local var_13_13, var_13_14

	if arg_13_0.contextData.topLayer then
		GetOrAddComponent = var_13_14
		var_13_13 = arg_13_0._tf
		typeof = var_13_11
		Canvas = var_1_10007
		var_13_14 = var_13_14(var_13_13, var_13_11(var_1_10007))
		var_13_14.overrideSorting = true
		var_13_14.sortingOrder = 900
		GetOrAddComponent = var_3

		local var_13_15 = arg_13_0._tf

		typeof = var_1_10006
		GraphicRaycaster = var_1_10008

		var_3(var_13_15, var_1_10006(var_1_10008))
	end

	getProxy = var_13_14
	SettingsProxy = var_13_13

	local var_13_16 = var_13_14(var_13_13)

	var_2.UpdateNewThemeValue(var_13_16)

	return
end

function var_0_1.UpdateRes(arg_18_0)
	local var_18_0 = arg_18_0.goldTxt
	local var_18_1 = arg_18_0.player
	local var_18_2 = var_2.getResource

	PlayerConst = var_1_10005
	var_18_0.text = var_18_2(var_18_1, var_1_10005.ResDormMoney)

	local var_18_3 = arg_18_0.gemTxt
	local var_18_4 = arg_18_0.player

	var_18_3.text = var_2.getTotalGem(var_18_4)

	return
end

local var_0_12 = {
	"0",
	"1",
	"4",
	"2",
	"8",
	"3",
	"6",
	"7"
}

function var_0_1.InitPageFooter(arg_19_0)
	arg_19_0.btns = {}
	ipairs = var_1

	for iter_19_0, iter_19_1 in var_1(arg_19_0.pages) do
		cloneTplTo = var_1_10006

		local var_19_0 = var_1_10006(arg_19_0.btnTpl, arg_19_0.btnContainer)
		local var_19_1 = var_1_10006.Find(var_19_0, "unsel")
		local var_19_2 = var_7.GetComponent

		typeof = var_10
		Image = var_1_10012

		local var_19_3 = var_19_2(var_19_1, var_10(var_1_10012))

		GetSpriteFromAtlas = var_8
		var_19_3.sprite = var_8("ui/NewBackYardShopUI_atlas", "text_tag" .. iter_19_0 - 1)

		var_19_3:SetNativeSize()

		local var_19_4 = var_1_10006:Find("sel/Text")
		local var_19_5 = var_8.GetComponent

		typeof = var_11
		Image = var_1_10013

		local var_19_6 = var_19_5(var_19_4, var_11(var_1_10013))

		GetSpriteFromAtlas = var_19_1
		var_19_6.sprite = var_19_1("ui/NewBackYardShopUI_atlas", "text_tag" .. iter_19_0 - 1)

		local var_19_7 = var_19_6

		var_19_6.SetNativeSize(var_19_7)

		local var_19_8 = var_0_12[iter_19_0]

		var_1_10012 = var_1_10006
		var_1_10012 = var_1_10006.Find(var_1_10012, "sel/icon")

		local var_19_9 = var_10.GetComponent

		typeof = var_1_10013
		Image = var_1_10015

		local var_19_10 = var_19_9(var_1_10012, var_1_10013(var_1_10015))

		LoadSpriteAtlasAsync = var_19_7

		var_19_7("ui/CourtyardUI_atlas", "icon_" .. var_19_8, function(arg_20_0)
			if arg_19_0.exited then
				return
			end

			var_19_10.sprite = arg_20_0

			return
		end)
		var_0_11(arg_19_0, var_1_10006, function()
			if arg_19_0.pageType == iter_19_0 then
				return
			end

			if arg_19_0.pageType then
				local var_21_0 = arg_19_0.pages[arg_19_0.pageType]

				if not var_0.GetLoaded(var_21_0) then
					return
				end
			end

			if arg_19_0.pageType and arg_19_0.pages[arg_19_0.pageType] ~= iter_19_1 then
				local var_21_1 = arg_19_0.pages[arg_19_0.pageType]

				var_0.Hide(var_21_1)
			end

			local var_21_2 = iter_19_1

			var_0.ExecuteAction(var_21_2, "SetUp", iter_19_0, arg_19_0.dorm, arg_19_0.player, function()
				return
			end)

			arg_19_0.pageType = iter_19_0

			if iter_19_0 == 5 then
				getProxy = var_0
				SettingsProxy = var_21_2

				local var_21_3 = var_0(var_21_2)

				var_0.UpdateNewGemFurnitureValue(var_21_3)

				local var_21_4 = arg_19_0

				var_0.UpdateSpecialPageFooter(var_21_4)
			end

			return true
		end)

		arg_19_0.btns[iter_19_0] = var_1_10006
	end

	arg_19_0:UpdateSpecialPageFooter()

	setActive = var_1

	var_1(arg_19_0.btnTpl, false)

	return
end

function var_0_1.UpdateSpecialPageFooter(arg_23_0)
	local var_23_0 = arg_23_0.btns[5]

	setActive = var_1_10002

	local var_23_1 = var_23_0:Find("new")

	getProxy = var_1_10005
	SettingsProxy = var_7

	local var_23_2 = var_1_10005(var_7)

	var_1_10002(var_23_1, var_5.IsTipNewGemFurniture(var_23_2))

	return
end

function var_0_1.willExit(arg_24_0)
	arg_24_0.isOverlay = false

	local var_24_0 = arg_24_0.contextData.filterPanel

	var_1.Destroy(var_24_0)

	local var_24_1 = arg_24_0.themePage

	var_1.Destroy(var_24_1)

	local var_24_2 = arg_24_0.furniturePage

	var_1.Destroy(var_24_2)

	local var_24_3 = arg_24_0.contextData.furnitureMsgBox

	var_1.Destroy(var_24_3)

	arg_24_0.contextData.furnitureMsgBox = nil

	local var_24_4 = arg_24_0.contextData.themeMsgBox

	var_1.Destroy(var_24_4)

	arg_24_0.contextData.themeMsgBox = nil

	return
end

return var_0_1
