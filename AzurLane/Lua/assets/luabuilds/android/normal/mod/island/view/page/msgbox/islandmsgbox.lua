class = var_0_10000

local var_0_0 = "IslandMsgBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.TYPE_COMMON = 1
var_0_1.TYPE_ITEM = 2
var_0_1.TYPE_SHIP_OWN_STATUS = 3
var_0_1.TYPE_COMMON_ITEM = 4
var_0_1.TYPE_ITEM_INFO = 5
var_0_1.TYPE_MATERIAL_INFO = 6
var_0_1.TYPE_REMIND = 7
var_0_1.TYPE_SHIP_SKILL = 8
var_0_1.TYPE_SHIP_STATUS_MSG = 9
var_0_1.TYPE_AGORA_PLACED_LIST = 10
var_0_1.TYPE_AGORA_UPGRADE = 11
var_0_1.TYPE_WHITOUT_BTN = 12
var_0_1.TYPE_SAVE_THEME = 13
var_0_1.TYPE_THEME = 14
var_0_1.TYPE_SEASON_TIP = 15
var_0_1.TYPE_SEASON_RESET = 16
var_0_1.TYPE_SYSTEM_THEME = 17
var_0_1.TYPE_ORDER_TENDENCY = 18
var_0_1.TYPE_SEND_DRESS = 19
var_0_1.TYPE_AOGRA_SAVE_CD = 20
var_0_1.TYPE_CHAT_SETTINGS = 21
var_0_1.TYPE_DRAW_AWARD_COUNT = 22
var_0_1.TYPE_DRAW_AWARD_LIST = 23
var_0_1.TYPE_DRAW_AWARD_ALL = 24
var_0_1.TYPE_TICKET_EXPIRED = 25
var_0_1.TYPE_DRESS_WEAR_CONFIRE = 26
var_0_1.TYPE_COMMON_DROP_DESCRIBE = 27
var_0_1.TYPE_ISLAND_POST_EVENT = 28
var_0_1.TYPE_TRADE_CONFRIM = 29
var_0_1.TYPE_COMMON_AUTO_CONFIRM = 30

function var_0_1.getUIName(arg_1_0)
	return "IslandMsgboxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	arg_2_0.stack = {}
	arg_2_0.cacheCnt = 3
	arg_2_0.tempWindows = {}
	arg_2_0.residentWindows = {}

	local var_2_0 = {}
	local var_2_1 = var_0_1.TYPE_COMMON

	IslandCommonMsgboxEXWindow = var_1_10003
	var_2_0[var_2_1] = var_1_10003

	local var_2_2 = var_0_1.TYPE_ITEM

	IslandItemMsgboxWindow = var_1_10003
	var_2_0[var_2_2] = var_1_10003

	local var_2_3 = var_0_1.TYPE_SHIP_OWN_STATUS

	IslandMsgBoxForStatusWindow = var_1_10003
	var_2_0[var_2_3] = var_1_10003

	local var_2_4 = var_0_1.TYPE_ITEM_INFO

	IslandMsgBoxSingleItemWindow = var_1_10003
	var_2_0[var_2_4] = var_1_10003

	local var_2_5 = var_0_1.TYPE_MATERIAL_INFO

	IslandMsgBoxSingleMaterialWindow = var_1_10003
	var_2_0[var_2_5] = var_1_10003

	local var_2_6 = var_0_1.TYPE_REMIND

	IslandRemindMsgboxWindow = var_1_10003
	var_2_0[var_2_6] = var_1_10003

	local var_2_7 = var_0_1.TYPE_SHIP_SKILL

	IslandShipSkillMsgboxWindow = var_1_10003
	var_2_0[var_2_7] = var_1_10003

	local var_2_8 = var_0_1.TYPE_SHIP_STATUS_MSG

	IslandShipStatusMsgboxWindow = var_1_10003
	var_2_0[var_2_8] = var_1_10003

	local var_2_9 = var_0_1.TYPE_AGORA_PLACED_LIST

	IslandAgoraPlacedListMsgboxWindow = var_1_10003
	var_2_0[var_2_9] = var_1_10003

	local var_2_10 = var_0_1.TYPE_AGORA_UPGRADE

	IslandAgoraUpgradeMsgboxWindow = var_1_10003
	var_2_0[var_2_10] = var_1_10003

	local var_2_11 = var_0_1.TYPE_WHITOUT_BTN

	IslandwithoutBtnMsgboxWindow = var_1_10003
	var_2_0[var_2_11] = var_1_10003

	local var_2_12 = var_0_1.TYPE_SAVE_THEME

	IslandSaveThemeMsgboxWindow = var_1_10003
	var_2_0[var_2_12] = var_1_10003

	local var_2_13 = var_0_1.TYPE_THEME

	IslandThemeMsgboxWindow = var_1_10003
	var_2_0[var_2_13] = var_1_10003

	local var_2_14 = var_0_1.TYPE_SEASON_TIP

	IslandSeasonTipMsgBoxWindow = var_1_10003
	var_2_0[var_2_14] = var_1_10003

	local var_2_15 = var_0_1.TYPE_SEASON_RESET

	IslandSeasonResetMsgBoxWindow = var_1_10003
	var_2_0[var_2_15] = var_1_10003

	local var_2_16 = var_0_1.TYPE_SYSTEM_THEME

	IslandSystemThemeMsgboxWindow = var_1_10003
	var_2_0[var_2_16] = var_1_10003

	local var_2_17 = var_0_1.TYPE_ORDER_TENDENCY

	IslandOrderTendencyPage = var_1_10003
	var_2_0[var_2_17] = var_1_10003

	local var_2_18 = var_0_1.TYPE_SEND_DRESS

	IslandSendDressUpMsgboxWindow = var_1_10003
	var_2_0[var_2_18] = var_1_10003

	local var_2_19 = var_0_1.TYPE_AOGRA_SAVE_CD

	IslandAgoraSaveCdMsgboxWindow = var_1_10003
	var_2_0[var_2_19] = var_1_10003

	local var_2_20 = var_0_1.TYPE_CHAT_SETTINGS

	IslandChatSettingsMsgboxWindow = var_1_10003
	var_2_0[var_2_20] = var_1_10003

	local var_2_21 = var_0_1.TYPE_DRAW_AWARD_COUNT

	IslandDrawAwardCountWindow = var_1_10003
	var_2_0[var_2_21] = var_1_10003

	local var_2_22 = var_0_1.TYPE_DRAW_AWARD_LIST

	IslandDrawAwardListWindow = var_1_10003
	var_2_0[var_2_22] = var_1_10003

	local var_2_23 = var_0_1.TYPE_DRAW_AWARD_ALL

	IslandDrawAwardAllWindow = var_1_10003
	var_2_0[var_2_23] = var_1_10003

	local var_2_24 = var_0_1.TYPE_TICKET_EXPIRED

	IslandTicketExpiredMsgBoxWindow = var_1_10003
	var_2_0[var_2_24] = var_1_10003

	local var_2_25 = var_0_1.TYPE_DRESS_WEAR_CONFIRE

	IslandDressWearMsgboxWindow = var_1_10003
	var_2_0[var_2_25] = var_1_10003

	local var_2_26 = var_0_1.TYPE_COMMON_DROP_DESCRIBE

	IslandMsgBoxSingleDropWindow = var_1_10003
	var_2_0[var_2_26] = var_1_10003

	local var_2_27 = var_0_1.TYPE_ISLAND_POST_EVENT

	IslandPostEventWindow = var_1_10003
	var_2_0[var_2_27] = var_1_10003

	local var_2_28 = var_0_1.TYPE_TRADE_CONFRIM

	IslandTradeConfirmWindow = var_1_10003
	var_2_0[var_2_28] = var_1_10003

	local var_2_29 = var_0_1.TYPE_COMMON_AUTO_CONFIRM

	IslandMsgBoxAutoCollectionWindow = var_1_10003
	var_2_0[var_2_29] = var_1_10003
	arg_2_0.PAGES = var_2_0

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.rtBg

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.HideWindow(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.CheckType(arg_5_0, arg_5_1)
	local var_5_0

	if not arg_5_1.type then
		var_5_0 = var_0_1.TYPE_COMMON
	end

	if var_5_0 == var_0_1.TYPE_COMMON_ITEM then
		IslandItem = var_3

		local var_5_1 = var_3.New({
			id = arg_5_1.itemId
		})

		var_5_0 = var_3.CanConvert(var_5_1) and var_0_1.TYPE_MATERIAL_INFO or var_0_1.TYPE_ITEM_INFO
	end

	return var_5_0
end

function var_0_1.Show(arg_6_0, arg_6_1, arg_6_2)
	var_0_1.super.Show(arg_6_0)

	arg_6_0.callback = arg_6_2

	local var_6_0 = arg_6_0:CheckType(arg_6_1)
	local var_6_1 = arg_6_0:CreateWindow(var_6_0)

	var_4.ExecuteAction(var_6_1, "Show", arg_6_1)

	table = var_5

	var_5.insert(arg_6_0.stack, var_4)

	return
end

function var_0_1.CreateWindow(arg_7_0, arg_7_1)
	local var_7_0

	if arg_7_1 ~= var_0_1.TYPE_COMMON or not arg_7_0.residentWindows then
		var_7_0 = arg_7_0.tempWindows
	end

	local var_7_1 = arg_7_0
	local var_7_2 = arg_7_0.FindOrCreateWindow(var_7_1, arg_7_1, var_7_0)

	table = var_7_1

	var_7_1.insert(var_7_0, 1, {
		type = arg_7_1,
		window = var_7_2
	})
	arg_7_0:CheckPoolCnt(var_7_0)

	return var_7_2
end

function var_0_1.FindOrCreateWindow(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0

	ipairs = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10004(arg_8_2) do
		if iter_8_1.type == arg_8_1 then
			var_8_0 = iter_8_0

			break
		end
	end

	local var_8_1

	if 0 < var_8_0 then
		table = var_5
		var_8_1 = var_5.remove(arg_8_2, var_8_0).window
	else
		local var_8_2 = arg_8_0.PAGES[arg_8_1]

		assert = var_6

		var_6(var_8_2, arg_8_1)

		var_8_1 = var_8_2.New(arg_8_0, arg_8_0.rtPages)
	end

	return var_8_1
end

function var_0_1.CheckPoolCnt(arg_9_0, arg_9_1)
	if #arg_9_1 > arg_9_0.cacheCnt then
		table = var_2

		if var_2.remove(arg_9_1, #arg_9_1).window and var_3:GetLoaded() then
			var_3:Destroy()
		end
	end

	return
end

function var_0_1.HideWindow(arg_10_0, arg_10_1)
	local var_10_0 = false

	if arg_10_1 then
		table = var_1_10003
		var_10_0 = var_1_10003.indexof(arg_10_0.stack, arg_10_1)
	end

	var_10_0 = var_10_0 or #arg_10_0.stack

	if var_10_0 > 0 and var_10_0 <= #arg_10_0.stack then
		table = var_3
		arg_10_1 = var_3.remove(arg_10_0.stack, var_10_0)
	end

	if arg_10_1 then
		if arg_10_1.onHide then
			arg_10_1.onHide()
		end

		setActive = var_3

		var_3(arg_10_1._tf, false)
	end

	if #arg_10_0.stack == 0 then
		arg_10_0:Hide()

		local var_10_1 = arg_10_0.callback

		arg_10_0.callback = nil

		if var_10_1 then
			var_10_1()
		end
	end

	return
end

function var_0_1.OnDestroy(arg_11_0)
	ipairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.residentWindows) do
		local var_11_0 = iter_11_1.window

		var_6.Destroy(var_11_0)
	end

	ipairs = var_1

	for iter_11_2, iter_11_3 in var_1(arg_11_0.tempWindows) do
		local var_11_1 = iter_11_3.window

		var_6.Destroy(var_11_1)
	end

	arg_11_0.residentWindows = nil
	arg_11_0.tempWindows = nil

	return
end

return var_0_1
