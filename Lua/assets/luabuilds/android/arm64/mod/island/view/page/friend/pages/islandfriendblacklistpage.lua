local var_0_0 = class("IslandFriendBlackListPage", import(".IslandFriendWhiteListPage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandFriendListUI4BlackList"
end

function var_0_0.InitTitle(arg_2_0)
	arg_2_0.titleTxt.text = i18n("island_black_list_tip")

	return
end

function var_0_0.GetData(arg_3_0, arg_3_1)
	local var_3_0 = getProxy(IslandProxy):GetIsland():GetAccessAgency():GetBlackList()

	if #var_3_0 <= 0 then
		arg_3_1(var_3_0)

		return
	end

	arg_3_0:emit(IslandMediator.BATCH_GET_FRIEND, var_3_0, arg_3_1)

	return
end

function var_0_0.OnInitItem(arg_4_0, arg_4_1)
	local var_4_0 = IslandBlackWhitListCard.New(arg_4_1)

	onButton(arg_4_0, var_4_0.removeBtn, function()
		arg_4_0:emit(IslandMediator.REMOVE_BLACK_LIST, var_4_0.player.id)

		return
	end, SFX_PANEL)

	arg_4_0.cards[arg_4_1] = var_4_0

	return
end

return var_0_0
