class = var_0_10000

local var_0_0 = "IslandFriendRequestPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandFriendListPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandFriendRequestUI"
end

function var_0_1.CreateCard(arg_2_0, arg_2_1)
	IslandFriendRequestCard = var_1_10002

	return var_1_10002.New(arg_2_1)
end

function var_0_1.OnInitItem(arg_3_0, arg_3_1)
	var_0_1.super.OnInitItem(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_0.cards[arg_3_1]

	onButton = var_1_10003

	local var_3_1 = arg_3_0
	local var_3_2 = var_3_0.agreeBtn

	local function var_3_3()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		IslandMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.ACCEPT_REQUEST, var_3_0.player.id)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_3_1, var_3_2, var_3_3, var_1_10008)

	onButton = var_1_10003

	local var_3_4 = arg_3_0
	local var_3_5 = var_3_0.refuseBtn

	local function var_3_6()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		IslandMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.REFUSE_REQUEST, var_3_0.player.id, false)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_3_4, var_3_5, var_3_6, var_1_10008)

	return
end

function var_0_1.GetData(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	NotificationProxy = var_1_10004

	local var_6_0 = var_1_10002(var_1_10004)

	if #var_2.getRequests(var_6_0) <= 0 then
		return arg_6_1({})
	end

	arg_6_1(var_2)

	return
end

return var_0_1
