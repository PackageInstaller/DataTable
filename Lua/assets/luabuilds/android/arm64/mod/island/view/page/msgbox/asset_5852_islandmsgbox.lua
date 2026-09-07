local IslandMsgBox = class("IslandMsgBox", import("view.base.BaseSubView"))

IslandMsgBox.TYPE_COMMON = 1
IslandMsgBox.TYPE_ITEM = 2
IslandMsgBox.TYPE_SHIP_OWN_STATUS = 3
IslandMsgBox.TYPE_COMMON_ITEM = 4
IslandMsgBox.TYPE_ITEM_INFO = 5
IslandMsgBox.TYPE_MATERIAL_INFO = 6
IslandMsgBox.TYPE_REMIND = 7
IslandMsgBox.TYPE_SHIP_SKILL = 8
IslandMsgBox.TYPE_SHIP_STATUS_MSG = 9
IslandMsgBox.TYPE_AGORA_PLACED_LIST = 10
IslandMsgBox.TYPE_AGORA_UPGRADE = 11
IslandMsgBox.TYPE_WHITOUT_BTN = 12
IslandMsgBox.TYPE_SAVE_THEME = 13
IslandMsgBox.TYPE_THEME = 14
IslandMsgBox.TYPE_SEASON_TIP = 15
IslandMsgBox.TYPE_SEASON_RESET = 16
IslandMsgBox.TYPE_SYSTEM_THEME = 17
IslandMsgBox.TYPE_ORDER_TENDENCY = 18
IslandMsgBox.TYPE_SEND_DRESS = 19
IslandMsgBox.TYPE_AOGRA_SAVE_CD = 20
IslandMsgBox.TYPE_CHAT_SETTINGS = 21
IslandMsgBox.TYPE_DRAW_AWARD_COUNT = 22
IslandMsgBox.TYPE_DRAW_AWARD_LIST = 23
IslandMsgBox.TYPE_DRAW_AWARD_ALL = 24
IslandMsgBox.TYPE_TICKET_EXPIRED = 25
IslandMsgBox.TYPE_DRESS_WEAR_CONFIRE = 26
IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE = 27
IslandMsgBox.TYPE_ISLAND_POST_EVENT = 28
IslandMsgBox.TYPE_TRADE_CONFRIM = 29
IslandMsgBox.TYPE_COMMON_AUTO_CONFIRM = 30

function IslandMsgBox:getUIName()
	return "IslandMsgboxUI"
end

function IslandMsgBox:OnLoaded()
	self.stack = {}
	self.cacheCnt = 3
	self.tempWindows = {}
	self.residentWindows = {}
	self.PAGES = {
		[IslandMsgBox.TYPE_COMMON] = IslandCommonMsgboxEXWindow,
		[IslandMsgBox.TYPE_ITEM] = IslandItemMsgboxWindow,
		[IslandMsgBox.TYPE_SHIP_OWN_STATUS] = IslandMsgBoxForStatusWindow,
		[IslandMsgBox.TYPE_ITEM_INFO] = IslandMsgBoxSingleItemWindow,
		[IslandMsgBox.TYPE_MATERIAL_INFO] = IslandMsgBoxSingleMaterialWindow,
		[IslandMsgBox.TYPE_REMIND] = IslandRemindMsgboxWindow,
		[IslandMsgBox.TYPE_SHIP_SKILL] = IslandShipSkillMsgboxWindow,
		[IslandMsgBox.TYPE_SHIP_STATUS_MSG] = IslandShipStatusMsgboxWindow,
		[IslandMsgBox.TYPE_AGORA_PLACED_LIST] = IslandAgoraPlacedListMsgboxWindow,
		[IslandMsgBox.TYPE_AGORA_UPGRADE] = IslandAgoraUpgradeMsgboxWindow,
		[IslandMsgBox.TYPE_WHITOUT_BTN] = IslandwithoutBtnMsgboxWindow,
		[IslandMsgBox.TYPE_SAVE_THEME] = IslandSaveThemeMsgboxWindow,
		[IslandMsgBox.TYPE_THEME] = IslandThemeMsgboxWindow,
		[IslandMsgBox.TYPE_SEASON_TIP] = IslandSeasonTipMsgBoxWindow,
		[IslandMsgBox.TYPE_SEASON_RESET] = IslandSeasonResetMsgBoxWindow,
		[IslandMsgBox.TYPE_SYSTEM_THEME] = IslandSystemThemeMsgboxWindow,
		[IslandMsgBox.TYPE_ORDER_TENDENCY] = IslandOrderTendencyPage,
		[IslandMsgBox.TYPE_SEND_DRESS] = IslandSendDressUpMsgboxWindow,
		[IslandMsgBox.TYPE_AOGRA_SAVE_CD] = IslandAgoraSaveCdMsgboxWindow,
		[IslandMsgBox.TYPE_CHAT_SETTINGS] = IslandChatSettingsMsgboxWindow,
		[IslandMsgBox.TYPE_DRAW_AWARD_COUNT] = IslandDrawAwardCountWindow,
		[IslandMsgBox.TYPE_DRAW_AWARD_LIST] = IslandDrawAwardListWindow,
		[IslandMsgBox.TYPE_DRAW_AWARD_ALL] = IslandDrawAwardAllWindow,
		[IslandMsgBox.TYPE_TICKET_EXPIRED] = IslandTicketExpiredMsgBoxWindow,
		[IslandMsgBox.TYPE_DRESS_WEAR_CONFIRE] = IslandDressWearMsgboxWindow,
		[IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE] = IslandMsgBoxSingleDropWindow,
		[IslandMsgBox.TYPE_ISLAND_POST_EVENT] = IslandPostEventWindow,
		[IslandMsgBox.TYPE_TRADE_CONFRIM] = IslandTradeConfirmWindow,
		[IslandMsgBox.TYPE_COMMON_AUTO_CONFIRM] = IslandMsgBoxAutoCollectionWindow
	}

	return
end

function IslandMsgBox:OnInit()
	onButton(self, self.rtBg, function()
		self:HideWindow()

		return
	end, SFX_PANEL)

	return
end

function IslandMsgBox:CheckType(arg_5_1)
	local var_5_0 = arg_5_1.type or IslandMsgBox.TYPE_COMMON

	if var_5_0 == IslandMsgBox.TYPE_COMMON_ITEM then
		var_5_0 = IslandItem.New({
			id = arg_5_1.itemId
		}):CanConvert() and IslandMsgBox.TYPE_MATERIAL_INFO or IslandMsgBox.TYPE_ITEM_INFO
	end

	return var_5_0
end

function IslandMsgBox:Show(arg_6_1, arg_6_2)
	IslandMsgBox.super.Show(self)

	self.callback = arg_6_2

	local var_6_0 = self:CreateWindow((self:CheckType(arg_6_1)))

	var_6_0:ExecuteAction("Show", arg_6_1)
	table.insert(self.stack, var_6_0)

	return
end

function IslandMsgBox:CreateWindow(arg_7_1)
	local var_7_0

	if arg_7_1 == IslandMsgBox.TYPE_COMMON then
		var_7_0 = self.residentWindows or self.tempWindows
	end

	local var_7_1 = self:FindOrCreateWindow(arg_7_1, var_7_0)

	table.insert(var_7_0, 1, {
		type = arg_7_1,
		window = var_7_1
	})
	self:CheckPoolCnt(var_7_0)

	return var_7_1
end

function IslandMsgBox:FindOrCreateWindow(arg_8_1, arg_8_2)
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
		local var_8_2 = self.PAGES[arg_8_1]

		assert(self.PAGES[arg_8_1], arg_8_1)

		var_8_1 = var_8_2.New(self, self.rtPages)
	end

	return var_8_1
end

function IslandMsgBox:CheckPoolCnt(arg_9_1)
	if #arg_9_1 > self.cacheCnt then
		local var_9_0 = table.remove(arg_9_1, #arg_9_1).window

		if var_9_0 and var_9_0:GetLoaded() then
			var_9_0:Destroy()
		end
	end

	return
end

function IslandMsgBox:HideWindow(arg_10_1)
	local var_10_0 = false

	if arg_10_1 then
		var_10_0 = table.indexof(self.stack, arg_10_1)
	end

	var_10_0 = var_10_0 or #self.stack

	if var_10_0 > 0 and var_10_0 <= #self.stack then
		arg_10_1 = table.remove(self.stack, var_10_0)
	end

	if arg_10_1 then
		if arg_10_1.onHide then
			arg_10_1.onHide()
		end

		setActive(arg_10_1._tf, false)
	end

	if #self.stack == 0 then
		self:Hide()

		self.callback = nil

		if self.callback then
			self.callback()
		end
	end

	return
end

function IslandMsgBox:OnDestroy()
	for iter_11_0, iter_11_1 in ipairs(self.residentWindows) do
		iter_11_1.window:Destroy()
	end

	for iter_11_2, iter_11_3 in ipairs(self.tempWindows) do
		iter_11_3.window:Destroy()
	end

	self.residentWindows = nil
	self.tempWindows = nil

	return
end

return IslandMsgBox
