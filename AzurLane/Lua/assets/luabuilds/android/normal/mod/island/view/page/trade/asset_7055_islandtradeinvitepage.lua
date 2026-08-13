class = var_0_10000

local var_0_0 = "IslandTradeInvitePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.View.page.friend.IslandSignInInvitationPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSignInInvitation4TradeUI"
end

function var_0_1.AddListeners(arg_2_0)
	var_0_1.super.AddListeners(arg_2_0)

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.AddListener

	IslandTradegency = var_1_10003

	var_2_1(var_2_0, var_1_10003.INVITE_LIST_UPDATE, arg_2_0.OnListUpdate)

	return
end

function var_0_1.RemoveListeners(arg_3_0)
	var_0_1.super.RemoveListeners(arg_3_0)

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.RemoveListener

	IslandTradegency = var_1_10003

	var_3_1(var_3_0, var_1_10003.INVITE_LIST_UPDATE, arg_3_0.OnListUpdate)

	return
end

function var_0_1.OnListUpdate(arg_4_0)
	arg_4_0:FlushList()

	return
end

function var_0_1.OnUpdateItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0

	if not arg_5_0.cards[arg_5_2] then
		arg_5_0:OnInitItem(arg_5_2)

		var_5_0 = arg_5_0.cards[arg_5_2]
	end

	local var_5_1 = arg_5_0:GetIsland()
	local var_5_2 = arg_5_0.displays[arg_5_1 + 1]
	local var_5_3 = var_5_1:GetTradeAgency()
	local var_5_4 = var_6.IsInvited(var_5_3, var_5_2.id)

	var_5_0:Update(var_5_2, var_5_4)

	return
end

function var_0_1.DoInvitation(arg_6_0, arg_6_1)
	local var_6_0, var_6_1, var_6_2 = arg_6_0:GetInfo()

	if var_6_0 then
		local var_6_3 = arg_6_0
		local var_6_4 = arg_6_0.emit

		IslandBaseMediator = var_1_10007

		var_6_4(var_6_3, var_1_10007.TRADE_INVITATION, {
			arg_6_1.player.id
		}, var_6_0, var_6_2)
	end

	return
end

function var_0_1.GetInfo(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.GetSelfIsland(var_7_0)

	IslandConst = var_7_0

	local var_7_2 = var_7_0.AGORA_MAP_ID

	pg = var_1_10003

	local var_7_3 = var_1_10003.island_map[var_7_2].name
	local var_7_4 = var_7_1:GetTradeAgency()
	local var_7_5 = var_4.GetTodaySellPrice(var_7_4)

	return var_7_2, var_7_3, var_7_5
end

function var_0_1.DoShare(arg_8_0)
	local var_8_0, var_8_1, var_8_2 = arg_8_0:GetInfo()

	if var_8_0 then
		local var_8_3 = arg_8_0
		local var_8_4 = arg_8_0.emit

		IslandBaseMediator = var_1_10006

		local var_8_5 = var_1_10006.SEND_CHAT

		IslandChatConst = var_1_10007

		local var_8_6 = var_1_10007.CHANNEL_ISLAND

		IslandConst = var_1_10008

		var_8_4(var_8_3, var_8_5, var_8_6, var_1_10008.TRADE_SHARE_CODE .. "*" .. var_8_1 .. "*" .. var_8_2)

		pg = var_8_4

		local var_8_7 = var_8_4.TipsMgr.GetInstance()
		local var_8_8 = var_4.ShowTips

		i18n = var_8_5

		var_8_8(var_8_7, var_8_5("island_trade_share_success"))
	end

	return
end

function var_0_1.OnOneKey(arg_9_0)
	local var_9_0 = arg_9_0:GetSelfIsland()
	local var_9_1 = var_1.GetTradeAgency(var_9_0)
	local var_9_2 = {}

	ipairs = var_1_10004

	for iter_9_0, iter_9_1 in var_1_10004(arg_9_0.displays) do
		local var_9_3 = var_9_1

		if not var_9_1.IsInvited(var_9_3, iter_9_1.id) then
			table = var_9_3

			var_9_3.insert(var_9_2, iter_9_1.id)
		end
	end

	local var_9_4, var_9_5, var_9_6 = arg_9_0:GetInfo()
	local var_9_7 = arg_9_0
	local var_9_8 = arg_9_0.emit

	IslandBaseMediator = var_1_10009

	var_9_8(var_9_7, var_1_10009.TRADE_INVITATION, var_9_2, var_9_4, var_9_6)

	return
end

function var_0_1.OnShow(arg_10_0)
	arg_10_0:BlurPanel()

	return
end

function var_0_1.OnHide(arg_11_0)
	arg_11_0:UnBlurPanel()

	return
end

return var_0_1
