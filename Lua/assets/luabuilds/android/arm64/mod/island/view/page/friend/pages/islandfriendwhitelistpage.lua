local var_0_0 = class("IslandFriendWhiteListPage", import(".IslandFriendListPage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandFriendListUI4WhitList"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.titleTxt = arg_2_0._tf:Find("tip/Text"):GetComponent(typeof(Text))

	arg_2_0:InitTitle()

	return
end

function var_0_0.InitTitle(arg_3_0)
	arg_3_0.titleTxt.text = i18n("island_white_list_tip")

	return
end

function var_0_0.GetData(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(IslandProxy):GetIsland():GetAccessAgency():GetWhiteList()

	if #var_4_0 <= 0 then
		arg_4_1(var_4_0)

		return
	end

	arg_4_0:emit(IslandMediator.BATCH_GET_FRIEND, var_4_0, arg_4_1)

	return
end

function var_0_0.OnInitItem(arg_5_0, arg_5_1)
	local var_5_0 = IslandBlackWhitListCard.New(arg_5_1)

	onButton(arg_5_0, var_5_0.removeBtn, function()
		arg_5_0:emit(IslandMediator.REMOVE_WHITE_LIST, var_5_0.player.id)

		return
	end, SFX_PANEL)

	arg_5_0.cards[arg_5_1] = var_5_0

	return
end

return var_0_0
