local var_0_0 = class("IslandTradeInvitePage", import("Mod.Island.View.page.friend.IslandSignInInvitationPage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandSignInInvitation4TradeUI"
end

function var_0_0.AddListeners(arg_2_0)
	var_0_0.super.AddListeners(arg_2_0)
	arg_2_0:AddListener(IslandTradegency.INVITE_LIST_UPDATE, arg_2_0.OnListUpdate)

	return
end

function var_0_0.RemoveListeners(arg_3_0)
	var_0_0.super.RemoveListeners(arg_3_0)
	arg_3_0:RemoveListener(IslandTradegency.INVITE_LIST_UPDATE, arg_3_0.OnListUpdate)

	return
end

function var_0_0.OnListUpdate(arg_4_0)
	arg_4_0:FlushList()

	return
end

function var_0_0.OnUpdateItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.cards[arg_5_2]

	if not arg_5_0.cards[arg_5_2] then
		arg_5_0:OnInitItem(arg_5_2)

		var_5_0 = arg_5_0.cards[arg_5_2]
	end

	local var_5_1 = arg_5_0:GetIsland():GetTradeAgency()

	var_5_0:Update(arg_5_0.displays[arg_5_1 + 1], (var_5_1:IsInvited(arg_5_0.displays[arg_5_1 + 1].id)))

	return
end

function var_0_0.DoInvitation(arg_6_0, arg_6_1)
	local var_6_0, var_6_1, var_6_2 = arg_6_0:GetInfo()

	if var_6_0 then
		arg_6_0:emit(IslandBaseMediator.TRADE_INVITATION, {
			arg_6_1.player.id
		}, var_6_0, var_6_2)
	end

	return
end

function var_0_0.GetInfo(arg_7_0)
	return IslandConst.AGORA_MAP_ID, pg.island_map[IslandConst.AGORA_MAP_ID].name, (arg_7_0:GetSelfIsland():GetTradeAgency():GetTodaySellPrice())
end

function var_0_0.DoShare(arg_8_0)
	local var_8_0, var_8_1, var_8_2 = arg_8_0:GetInfo()

	if var_8_0 then
		arg_8_0:emit(IslandBaseMediator.SEND_CHAT, IslandChatConst.CHANNEL_ISLAND, IslandConst.TRADE_SHARE_CODE .. "*" .. var_8_1 .. "*" .. var_8_2)
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_share_success"))
	end

	return
end

function var_0_0.OnOneKey(arg_9_0)
	local var_9_0 = arg_9_0:GetSelfIsland():GetTradeAgency()

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.displays) do
		if not var_9_0:IsInvited(iter_9_1.id) then
			table.insert({}, iter_9_1.id)
		end
	end

	local var_9_1, var_9_2, var_9_3 = arg_9_0:GetInfo()

	arg_9_0:emit(IslandBaseMediator.TRADE_INVITATION, {}, var_9_1, var_9_3)

	return
end

function var_0_0.OnShow(arg_10_0)
	arg_10_0:BlurPanel()

	return
end

function var_0_0.OnHide(arg_11_0)
	arg_11_0:UnBlurPanel()

	return
end

return var_0_0
