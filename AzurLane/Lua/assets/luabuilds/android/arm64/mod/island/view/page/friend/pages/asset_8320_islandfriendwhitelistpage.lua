class = var_0_10000

local var_0_0 = "IslandFriendWhiteListPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandFriendListPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandFriendListUI4WhitList"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "tip/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.titleTxt = var_2_2(var_2_1, var_4(var_1_10006))

	arg_2_0:InitTitle()

	return
end

function var_0_1.InitTitle(arg_3_0)
	local var_3_0 = arg_3_0.titleTxt

	i18n = var_1_10002
	var_3_0.text = var_1_10002("island_white_list_tip")

	return
end

function var_0_1.GetData(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_4_0 = var_1_10002(var_1_10004)
	local var_4_1 = var_2.GetIsland(var_4_0)
	local var_4_2 = var_2.GetAccessAgency(var_4_1)

	if #var_2.GetWhiteList(var_4_2) <= 0 then
		arg_4_1(var_2)

		return
	end

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.emit

	IslandMediator = var_1_10006

	var_4_4(var_4_3, var_1_10006.BATCH_GET_FRIEND, var_2, arg_4_1)

	return
end

function var_0_1.OnInitItem(arg_5_0, arg_5_1)
	IslandBlackWhitListCard = var_1_10002

	local var_5_0 = var_1_10002.New(arg_5_1)

	onButton = var_1_10003

	local var_5_1 = arg_5_0
	local var_5_2 = var_5_0.removeBtn

	local function var_5_3()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		IslandMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.REMOVE_WHITE_LIST, var_5_0.player.id)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_5_1, var_5_2, var_5_3, var_1_10008)

	arg_5_0.cards[arg_5_1] = var_5_0

	return
end

return var_0_1
