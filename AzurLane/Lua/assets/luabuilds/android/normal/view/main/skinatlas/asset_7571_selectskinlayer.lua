class = var_0_10000

local var_0_0 = "SelectSkinLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SkinAtlasScene"))

var_0_1.MODE_SELECT = 1
var_0_1.MODE_VIEW = 2

function var_0_1.getUIName(arg_1_0)
	return "SelectSkinUI"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	pg = var_1

	local var_2_0 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_2_0, arg_2_0._tf)

	SelectSkinMsgbox = var_1
	arg_2_0.msgBox = var_1.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_1.didEnter(arg_3_0)
	var_0_1.super.didEnter(arg_3_0)

	return
end

function var_0_1.GetSkinList(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0

	if not arg_4_0.contextData.selectableSkinList then
		var_4_0 = {}
	end

	local var_4_1 = {}

	ipairs = var_1_10005

	for iter_4_0, iter_4_1 in var_1_10005(var_4_0) do
		local var_4_2 = iter_4_1:ToShipSkin()

		if (arg_4_1 == var_0_1.PAGE_ALL or var_4_2:IsType(arg_4_1)) and not var_4_2:IsDefault() and var_4_2:IsMatchKey(arg_4_2) and arg_4_0:MatchIndex(var_4_2) then
			table = var_11

			var_11.insert(var_4_1, iter_4_1)
		end
	end

	return var_4_1
end

function var_0_1.SortDisplay(arg_5_0, arg_5_1)
	table = var_1_10002

	var_1_10002.sort(arg_5_1, function(arg_6_0, arg_6_1)
		if arg_6_0:GetTimeLimitWeight() == arg_6_1:GetTimeLimitWeight() then
			if arg_6_0:GetOwnWeight() == arg_6_1:GetOwnWeight() then
				return arg_6_0.skinId > arg_6_1.skinId
			else
				return var_5 < var_4
			end
		else
			return var_3 < var_2
		end

		return
	end)

	return
end

function var_0_1.OnInitItem(arg_7_0, arg_7_1)
	SelectSkinCard = var_1_10002

	local var_7_0 = var_1_10002.New(arg_7_1)

	onButton = var_3

	local var_7_1 = arg_7_0
	local var_7_2 = var_7_0._tf

	local function var_7_3()
		if arg_7_0.contextData.mode == var_0_1.MODE_VIEW then
			return
		end

		local var_8_0 = arg_7_0

		var_0.Check(var_8_0, var_7_0.skin)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_7_1, var_7_2, var_7_3, var_1_10007)

	arg_7_0.cards[arg_7_1] = var_7_0

	return
end

function var_0_1.OnUpdateItem(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0.cards[arg_9_2] then
		arg_9_0:OnInitItem(arg_9_2)
	end

	local var_9_0 = arg_9_0.cards[arg_9_2]
	local var_9_1 = arg_9_0.displays[arg_9_1 + 1]
	local var_9_2 = var_4.ToShipSkin(var_9_1)

	var_9_0:Update(var_9_2, arg_9_1 + 1, var_4:IsTimeLimit(), var_4:OwnSkin())

	return
end

function var_0_1.Check(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	ShipSkinProxy = var_1_10003

	local var_10_0 = var_1_10002(var_1_10003)

	if var_2.hasSkin(var_10_0, arg_10_1.id) then
		return
	end

	local var_10_1 = arg_10_0.contextData.itemId

	Item = var_4

	local var_10_2 = var_4.getConfigData(var_10_1).name
	local var_10_3 = arg_10_0.msgBox
	local var_10_4 = var_5.ExecuteAction
	local var_10_5 = "Show"
	local var_10_6 = {}

	i18n = var_1_10009
	var_10_6.content = var_1_10009("skin_exchange_confirm", var_10_2, arg_10_1.skinName)

	local var_10_7 = {
		count = 1
	}

	DROP_TYPE_ITEM = var_10
	var_10_7.type = var_10
	var_10_7.id = var_10_1
	var_10_6.leftDrop = var_10_7

	local var_10_8 = {
		count = 1
	}

	DROP_TYPE_SKIN = var_10
	var_10_8.type = var_10
	var_10_8.id = arg_10_1.id
	var_10_6.rightDrop = var_10_8

	function var_10_6.onYes()
		arg_10_0.contextData.OnConfirm(arg_10_1.id)

		local var_11_0 = arg_10_0

		var_0.closeView(var_11_0)

		return
	end

	var_10_4(var_10_3, var_10_5, var_10_6)

	return
end

function var_0_1.willExit(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf)

	local var_12_1 = arg_12_0.msgBox

	var_1.Destroy(var_12_1)
	var_0_1.super.willExit(arg_12_0)

	return
end

return var_0_1
