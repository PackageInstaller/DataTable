class = var_0_10000

local var_0_0 = "NewSelectSkinLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NewSkinAtlasLayer"))

var_0_1.MODE_SELECT = 1
var_0_1.MODE_VIEW = 2

function var_0_1.init(arg_1_0)
	var_0_1.super.init(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "adapt/top/title/Text")

	i18n = var_1_0

	var_1(var_1_1, var_1_0("shop_new_able_to_exchange"))

	setText = var_1

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_2.Find(var_1_2, "adapt/top/have/Text")

	i18n = var_1_2

	var_1(var_1_3, var_1_2("shop_new_able_to_exchange"))

	SelectSkinMsgbox = var_1
	arg_1_0.msgBox = var_1.New(arg_1_0._tf, arg_1_0.event)

	return
end

function var_0_1.InitData(arg_2_0)
	arg_2_0.skins = {}

	local var_2_0

	if not arg_2_0.contextData.selectableSkinList then
		var_2_0 = {}
	end

	table = var_1_10002

	var_1_10002.sort(var_2_0, function(arg_3_0, arg_3_1)
		if arg_3_0:GetTimeLimitWeight() == arg_3_1:GetTimeLimitWeight() then
			if arg_3_0:GetOwnWeight() == arg_3_1:GetOwnWeight() then
				return arg_3_0.skinId > arg_3_1.skinId
			else
				return var_5 < var_4
			end
		else
			return var_3 < var_2
		end

		return
	end)

	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(var_2_0) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0.skins, iter_2_1:ToShipSkin())
	end

	arg_2_0:GetSkinClassify()

	arg_2_0.filterValues = {
		shipHaveType = 0,
		ownType = 0,
		typeType = {
			0
		},
		campType = {
			0
		},
		rarityType = {
			0
		},
		shipType = {
			0
		},
		themeType = {
			0
		}
	}
	Clone = var_2
	arg_2_0.filterValuesTemp = var_2(arg_2_0.filterValues)

	return
end

function var_0_1.Check(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	ShipSkinProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)

	if var_2.hasSkin(var_4_0, arg_4_1.id) then
		return
	end

	local var_4_1 = arg_4_0.contextData.itemId

	Item = var_4

	local var_4_2 = var_4.getConfigData(var_4_1).name
	local var_4_3 = arg_4_0.msgBox
	local var_4_4 = var_5.ExecuteAction
	local var_4_5 = "Show"
	local var_4_6 = {}

	i18n = var_1_10009
	var_4_6.content = var_1_10009("skin_exchange_confirm", var_4_2, arg_4_1.skinName)

	local var_4_7 = {
		count = 1
	}

	DROP_TYPE_ITEM = var_10
	var_4_7.type = var_10
	var_4_7.id = var_4_1
	var_4_6.leftDrop = var_4_7

	local var_4_8 = {
		count = 1
	}

	DROP_TYPE_SKIN = var_10
	var_4_8.type = var_10
	var_4_8.id = arg_4_1.id
	var_4_6.rightDrop = var_4_8

	function var_4_6.onYes()
		arg_4_0.contextData.OnConfirm(arg_4_1.id)

		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	var_4_4(var_4_3, var_4_5, var_4_6)

	return
end

function var_0_1.ClickTrigger(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.contextData.mode == var_0_1.MODE_VIEW then
		return
	end

	arg_6_0:Check(arg_6_1.skin)

	return
end

function var_0_1.OnUpdateItem(arg_7_0, arg_7_1, arg_7_2)
	TweenItemAlphaAndWhite = var_1_10003

	var_1_10003(arg_7_2)

	arg_7_1 = arg_7_1 + 1

	local var_7_0 = arg_7_0.scrollDisplays[arg_7_1]

	if arg_7_0.goDic[arg_7_2] and arg_7_0.goDic[arg_7_2] ~= arg_7_1 then
		local var_7_1 = arg_7_0.scrollShowClassifyIds[arg_7_0.goDic[arg_7_2]]
		local var_7_2 = arg_7_0:GetDisplayIndex(var_7_1)

		arg_7_0:ReturnIndex(arg_7_0.goDic[arg_7_2])

		local var_7_3 = arg_7_0

		if var_7_2 ~= arg_7_0.GetDisplayIndex(var_7_3, var_7_1) then
			local var_7_4 = {}

			table = var_7_3

			var_7_3.insert(var_7_4, var_7_2)

			table = var_7

			var_7.insert(var_7_4, arg_7_0:GetDisplayIndex(var_7_1))
			arg_7_0:ChangeClassifyName(var_7_4)
		end
	end

	arg_7_0.goDic[arg_7_2] = arg_7_1

	local var_7_5 = arg_7_0.scrollShowClassifyIds[arg_7_1]
	local var_7_6 = arg_7_0:GetDisplayIndex(var_7_5)

	arg_7_0:RegisterIndex(arg_7_1)

	local var_7_7 = {}

	if var_7_6 ~= arg_7_0:GetDisplayIndex(var_7_5) then
		table = var_7

		var_7.insert(var_7_7, var_7_6)
	end

	table = var_7

	var_7.insert(var_7_7, arg_7_1)

	local var_7_8 = arg_7_0

	arg_7_0.ChangeClassifyName(var_7_8, var_7_7)

	if var_7_0 then
		UIItemList = var_7

		local var_7_9 = var_7.New

		tf = var_7_8

		local var_7_10 = var_7_8(arg_7_2)
		local var_7_11 = var_8.Find(var_7_10, "skins")

		tf = var_7_10

		local var_7_12 = var_7_10(arg_7_2)
		local var_7_13 = var_7_9(var_7_11, var_9.Find(var_7_12, "skins/SkinAtlasCard"))

		var_7.make(var_7_13, function(arg_8_0, arg_8_1, arg_8_2)
			UIItemList = var_2_10003

			if arg_8_0 == var_2_10003.EventUpdate then
				local var_8_0 = var_7_0[arg_8_1 + 1]

				SkinAtlasCard = var_4

				local var_8_1 = var_4.New(arg_8_2)

				table = var_5

				var_5.insert(arg_7_0.cards, var_8_1)
				var_8_1:Update(var_8_0, arg_8_1 + 1, true)

				onButton = var_5

				local var_8_2 = arg_7_0
				local var_8_3 = arg_8_2

				local function var_8_4()
					local var_9_0 = arg_7_0

					var_0.ClickTrigger(var_9_0, var_8_1, var_8_0)

					return
				end

				SFX_PANEL = var_9

				var_5(var_8_2, var_8_3, var_8_4, var_9)

				onButton = var_5

				local var_8_5 = arg_7_0
				local var_8_6 = var_8_1.changeSkinUI

				local function var_8_7()
					local var_10_0 = var_8_1

					var_0.changeSkinNext(var_10_0)

					return
				end

				SFX_PANEL = var_9

				var_5(var_8_5, var_8_6, var_8_7, var_9)
			end

			return
		end)
		var_7:align(#var_7_0)
	end

	return
end

function var_0_1.willExit(arg_11_0)
	var_0_1.super.willExit(arg_11_0)

	local var_11_0 = arg_11_0.msgBox

	var_1.Destroy(var_11_0)

	return
end

return var_0_1
