local var_0_0 = class("IslandMsgBox", import("view.base.BaseSubView"))

var_0_0.TYPE_COMMON = 1
var_0_0.TYPE_ITEM = 2
var_0_0.TYPE_SHIP_OWN_STATUS = 3
var_0_0.TYPE_COMMON_ITEM = 4
var_0_0.TYPE_ITEM_INFO = 5
var_0_0.TYPE_MATERIAL_INFO = 6
var_0_0.TYPE_REMIND = 7
var_0_0.TYPE_SHIP_SKILL = 8
var_0_0.TYPE_SHIP_STATUS_MSG = 9
var_0_0.TYPE_AGORA_PLACED_LIST = 10
var_0_0.TYPE_AGORA_UPGRADE = 11
var_0_0.TYPE_WHITOUT_BTN = 12
var_0_0.TYPE_SAVE_THEME = 13
var_0_0.TYPE_THEME = 14
var_0_0.TYPE_SEASON_TIP = 15
var_0_0.TYPE_SEASON_RESET = 16
var_0_0.TYPE_SYSTEM_THEME = 17
var_0_0.TYPE_ORDER_TENDENCY = 18
var_0_0.TYPE_SEND_DRESS = 19
var_0_0.TYPE_AOGRA_SAVE_CD = 20
var_0_0.TYPE_CHAT_SETTINGS = 21
var_0_0.TYPE_DRAW_AWARD_COUNT = 22
var_0_0.TYPE_DRAW_AWARD_LIST = 23
var_0_0.TYPE_DRAW_AWARD_ALL = 24
var_0_0.TYPE_TICKET_EXPIRED = 25
var_0_0.TYPE_DRESS_WEAR_CONFIRE = 26
var_0_0.TYPE_COMMON_DROP_DESCRIBE = 27
var_0_0.TYPE_ISLAND_POST_EVENT = 28
var_0_0.TYPE_TRADE_CONFRIM = 29
var_0_0.TYPE_COMMON_AUTO_CONFIRM = 30

function var_0_0.getUIName(arg_1_0)
	return "IslandMsgboxUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.stack = {}
	arg_2_0.cacheCnt = 3
	arg_2_0.tempWindows = {}
	arg_2_0.residentWindows = {}
	arg_2_0.PAGES = {
		[var_0_0.TYPE_COMMON] = IslandCommonMsgboxEXWindow,
		[var_0_0.TYPE_ITEM] = IslandItemMsgboxWindow,
		[var_0_0.TYPE_SHIP_OWN_STATUS] = IslandMsgBoxForStatusWindow,
		[var_0_0.TYPE_ITEM_INFO] = IslandMsgBoxSingleItemWindow,
		[var_0_0.TYPE_MATERIAL_INFO] = IslandMsgBoxSingleMaterialWindow,
		[var_0_0.TYPE_REMIND] = IslandRemindMsgboxWindow,
		[var_0_0.TYPE_SHIP_SKILL] = IslandShipSkillMsgboxWindow,
		[var_0_0.TYPE_SHIP_STATUS_MSG] = IslandShipStatusMsgboxWindow,
		[var_0_0.TYPE_AGORA_PLACED_LIST] = IslandAgoraPlacedListMsgboxWindow,
		[var_0_0.TYPE_AGORA_UPGRADE] = IslandAgoraUpgradeMsgboxWindow,
		[var_0_0.TYPE_WHITOUT_BTN] = IslandwithoutBtnMsgboxWindow,
		[var_0_0.TYPE_SAVE_THEME] = IslandSaveThemeMsgboxWindow,
		[var_0_0.TYPE_THEME] = IslandThemeMsgboxWindow,
		[var_0_0.TYPE_SEASON_TIP] = IslandSeasonTipMsgBoxWindow,
		[var_0_0.TYPE_SEASON_RESET] = IslandSeasonResetMsgBoxWindow,
		[var_0_0.TYPE_SYSTEM_THEME] = IslandSystemThemeMsgboxWindow,
		[var_0_0.TYPE_ORDER_TENDENCY] = IslandOrderTendencyPage,
		[var_0_0.TYPE_SEND_DRESS] = IslandSendDressUpMsgboxWindow,
		[var_0_0.TYPE_AOGRA_SAVE_CD] = IslandAgoraSaveCdMsgboxWindow,
		[var_0_0.TYPE_CHAT_SETTINGS] = IslandChatSettingsMsgboxWindow,
		[var_0_0.TYPE_DRAW_AWARD_COUNT] = IslandDrawAwardCountWindow,
		[var_0_0.TYPE_DRAW_AWARD_LIST] = IslandDrawAwardListWindow,
		[var_0_0.TYPE_DRAW_AWARD_ALL] = IslandDrawAwardAllWindow,
		[var_0_0.TYPE_TICKET_EXPIRED] = IslandTicketExpiredMsgBoxWindow,
		[var_0_0.TYPE_DRESS_WEAR_CONFIRE] = IslandDressWearMsgboxWindow,
		[var_0_0.TYPE_COMMON_DROP_DESCRIBE] = IslandMsgBoxSingleDropWindow,
		[var_0_0.TYPE_ISLAND_POST_EVENT] = IslandPostEventWindow,
		[var_0_0.TYPE_TRADE_CONFRIM] = IslandTradeConfirmWindow,
		[var_0_0.TYPE_COMMON_AUTO_CONFIRM] = IslandMsgBoxAutoCollectionWindow
	}

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.rtBg, function()
		arg_3_0:HideWindow()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.CheckType(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.type or var_0_0.TYPE_COMMON

	if var_5_0 == var_0_0.TYPE_COMMON_ITEM then
		var_5_0 = IslandItem.New({
			id = arg_5_1.itemId
		}):CanConvert() and var_0_0.TYPE_MATERIAL_INFO or var_0_0.TYPE_ITEM_INFO
	end

	return var_5_0
end

function var_0_0.Show(arg_6_0, arg_6_1, arg_6_2)
	var_0_0.super.Show(arg_6_0)

	arg_6_0.callback = arg_6_2

	local var_6_0 = arg_6_0:CreateWindow((arg_6_0:CheckType(arg_6_1)))

	var_6_0:ExecuteAction("Show", arg_6_1)
	table.insert(arg_6_0.stack, var_6_0)

	return
end

function var_0_0.CreateWindow(arg_7_0, arg_7_1)
	if arg_7_1 == var_0_0.TYPE_COMMON then
		local var_7_0 = arg_7_0.residentWindows or arg_7_0.tempWindows
		local var_7_1 = arg_7_0:FindOrCreateWindow(arg_7_1, var_7_0)

		table.insert(var_7_0, 1, {
			type = arg_7_1,
			window = var_7_1
		})
		arg_7_0:CheckPoolCnt(var_7_0)

		return var_7_1
	end
end

function var_0_0.FindOrCreateWindow(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_2) do
		if iter_8_1.type == arg_8_1 then
			var_8_0 = iter_8_0

			break
		end
	end

	local var_8_1

	if var_8_0 > 0 then
		var_8_1 = table.remove(arg_8_2, var_8_0).window
	else
		assert(arg_8_0.PAGES[arg_8_1], arg_8_1)

		var_8_1 = var_8_2.New(arg_8_0, arg_8_0.rtPages)
	end

	return var_8_1
end

function var_0_0.CheckPoolCnt(arg_9_0, arg_9_1)
	if #arg_9_1 > arg_9_0.cacheCnt then
		local var_9_0 = table.remove(arg_9_1, #arg_9_1).window

		if var_9_0 and var_9_0:GetLoaded() then
			var_9_0:Destroy()
		end
	end

	return
end

function var_0_0.HideWindow(arg_10_0, arg_10_1)
	local var_10_0 = false

	if arg_10_1 then
		var_10_0 = table.indexof(arg_10_0.stack, arg_10_1)
	end

	var_10_0 = var_10_0 or #arg_10_0.stack

	if var_10_0 > 0 and var_10_0 <= #arg_10_0.stack then
		arg_10_1 = table.remove(arg_10_0.stack, var_10_0)
	end

	if arg_10_1 then
		if arg_10_1.onHide then
			arg_10_1.onHide()
		end

		setActive(arg_10_1._tf, false)
	end

	if #arg_10_0.stack == 0 then
		arg_10_0:Hide()

		arg_10_0.callback = nil

		if arg_10_0.callback then
			arg_10_0.callback()
		end
	end

	return
end

function var_0_0.OnDestroy(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.residentWindows) do
		iter_11_1.window:Destroy()
	end

	for iter_11_2, iter_11_3 in ipairs(arg_11_0.tempWindows) do
		iter_11_3.window:Destroy()
	end

	arg_11_0.residentWindows = nil
	arg_11_0.tempWindows = nil

	return
end

return var_0_0
