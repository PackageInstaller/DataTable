class = var_0_10000

local var_0_0 = "BackYardDecorationThemePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BackYardDecorationBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "BackYardDecorationThemePage"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	BackYardDecorationMsgBox = var_1
	arg_2_0.msgbox = var_1.New(arg_2_0._parentTf.parent.parent.parent.parent.parent, arg_2_0.event, arg_2_0.contextData)
	arg_2_0.refreshList = {}

	return
end

function var_0_1.OnDisplayList(arg_3_0)
	arg_3_0:InitList()

	return
end

function var_0_1.InitList(arg_4_0)
	arg_4_0.displays = {}

	local var_4_0 = arg_4_0.dorm
	local var_4_1 = var_1.GetPurchasedFurnitures(var_4_0)

	getProxy = var_4_0
	DormProxy = var_1_10003

	local var_4_2 = var_4_0(var_1_10003)
	local var_4_3 = var_2.GetSystemThemes(var_4_2)

	ipairs = var_4_2

	for iter_4_0, iter_4_1 in var_4_2(var_4_3) do
		var_1_10009 = iter_4_1

		if iter_4_1.IsPurchased(var_1_10009, var_4_1) then
			table = var_8

			var_8.insert(arg_4_0.displays, iter_4_1)
		end
	end

	local var_4_4 = 0

	if arg_4_0.customTheme then
		pairs = var_4

		for iter_4_2, iter_4_3 in var_4(arg_4_0.customTheme) do
			var_4_4 = var_4_4 + 1
			table = var_1_10009

			var_1_10009.insert(arg_4_0.displays, iter_4_3)
		end
	end

	BackYardConst = var_4

	if var_4_4 < var_4.MAX_USER_THEME then
		table = var_4

		var_4.insert(arg_4_0.displays, {
			id = "",
			isEmpty = true
		})
	end

	arg_4_0:SortDisplays()

	return
end

local function var_0_2(arg_5_0, arg_5_1)
	if (arg_5_0.isEmpty and 1 or 0) == (arg_5_1.isEmpty and 1 or 0) then
		if (arg_5_0:IsSystem() and 1 or 0) == (arg_5_1:IsSystem() and 1 or 0) then
			if arg_5_0.order == arg_5_1.order then
				return arg_5_0.id > arg_5_1.id
			else
				return arg_5_0.order > arg_5_1.order
			end
		else
			return var_4 < var_5
		end
	else
		return var_3 < var_2
	end

	return
end

local function var_0_3(arg_6_0, arg_6_1)
	if (arg_6_0.isEmpty and 1 or 0) == (arg_6_1.isEmpty and 1 or 0) then
		if (arg_6_0:IsSystem() and 1 or 0) == (arg_6_1:IsSystem() and 1 or 0) then
			if arg_6_0.order == arg_6_1.order then
				return arg_6_0.id < arg_6_1.id
			else
				return arg_6_0.order < arg_6_1.order
			end
		else
			return var_5 < var_4
		end
	else
		return var_3 < var_2
	end

	return
end

function var_0_1.SortDisplays(arg_7_0)
	table = var_1_10001

	var_1_10001.sort(arg_7_0.displays, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_7_0.orderMode

		BackYardDecorationFilterPanel = var_2_10003

		if var_8_0 == var_2_10003.ORDER_MODE_ASC then
			return var_0_3(arg_8_0, arg_8_1)
		else
			return var_0_2(arg_8_0, arg_8_1)
		end

		return
	end)
	arg_7_0:SetTotalCount()

	return
end

function var_0_1.OnOrderModeUpdated(arg_9_0)
	arg_9_0:SortDisplays()

	return
end

function var_0_1.OnInitItem(arg_10_0, arg_10_1)
	BackYardDecorationThemeCard = var_1_10002

	local var_10_0 = var_1_10002.New(arg_10_1)

	onButton = var_3

	var_3(arg_10_0, var_10_0._tf, function()
		local var_11_0 = var_10_0

		if var_0.HasMask(var_11_0) then
			return
		end

		local var_11_1 = arg_10_0.msgbox

		var_0.ExecuteAction(var_11_1, "Show", var_10_0.themeVO, true)

		return
	end)

	onButton = var_3

	var_3(arg_10_0, var_10_0.add, function()
		getProxy = var_2_10000
		DormProxy = var_2_10001

		local var_12_0 = var_2_10000(var_2_10001)
		local var_12_1 = var_0.GetTemplateNewID(var_12_0)
		local var_12_2 = arg_10_0.msgbox

		var_1.ExecuteAction(var_12_2, "Show", {
			id = var_12_1
		}, false)

		return
	end)

	arg_10_0.cards[arg_10_1] = var_10_0

	return
end

function var_0_1.OnUpdateItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0

	if not arg_13_0.cards[arg_13_2] then
		arg_13_0:OnInitItem(arg_13_2)

		var_13_0 = arg_13_0.cards[arg_13_2]
	end

	local var_13_1 = arg_13_0.lastDiaplys[arg_13_1 + 1]

	var_13_0:Update(var_13_1, false)

	return
end

function var_0_1.OnThemeUpdated(arg_14_0)
	arg_14_0.currHouse = nil

	arg_14_0:InitList()

	return
end

function var_0_1.OnApplyThemeBefore(arg_15_0)
	arg_15_0.currHouse = nil
	pairs = var_1

	for iter_15_0, iter_15_1 in var_1(arg_15_0.cards) do
		iter_15_1:Update(iter_15_1.themeVO, false)
	end

	arg_15_0.temps = {}

	return
end

function var_0_1.OnApplyThemeAfter(arg_16_0, arg_16_1)
	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.cards) do
		if iter_16_1.themeVO.id == arg_16_1 then
			iter_16_1:Update(iter_16_1.themeVO, false)
		end
	end

	return
end

function var_0_1.SetTotalCount(arg_17_0)
	if not arg_17_0.searchKey or arg_17_0.searchKey == "" then
		arg_17_0.lastDiaplys = arg_17_0.displays
	else
		arg_17_0.lastDiaplys = {}
		ipairs = var_1

		for iter_17_0, iter_17_1 in var_1(arg_17_0.displays) do
			if iter_17_1.id == "" or iter_17_1:MatchSearchKey(arg_17_0.searchKey) then
				table = var_6

				var_6.insert(arg_17_0.lastDiaplys, iter_17_1)
			end
		end
	end

	arg_17_0.scrollRect.enabled = true

	local var_17_0 = arg_17_0.scrollRect

	var_1.SetTotalCount(var_17_0, #arg_17_0.lastDiaplys)

	return
end

function var_0_1.OnSearchKeyChanged(arg_18_0)
	arg_18_0:SetTotalCount()

	return
end

function var_0_1.OnDestroy(arg_19_0)
	local var_19_0 = arg_19_0.msgbox

	var_1.Destroy(var_19_0)

	pairs = var_1

	local var_19_1

	if not arg_19_0.cards then
		var_19_1 = {}
	end

	for iter_19_0, iter_19_1 in var_1(var_19_1) do
		iter_19_1:Dispose()
	end

	arg_19_0.cards = nil

	return
end

function var_0_1.OnBackPressed(arg_20_0)
	if arg_20_0:GetLoaded() then
		local var_20_0 = arg_20_0.msgbox

		if var_1.GetLoaded(var_20_0) then
			local var_20_1 = arg_20_0.msgbox

			if var_1.isShowing(var_20_1) then
				local var_20_2 = arg_20_0.msgbox

				var_1.Hide(var_20_2)

				return true
			end
		end
	end

	return false
end

return var_0_1
