local IslandTradeInvitePage = class("IslandTradeInvitePage", import("Mod.Island.View.page.friend.IslandSignInInvitationPage"))

function IslandTradeInvitePage:getUIName()
	return "IslandSignInInvitation4TradeUI"
end

function IslandTradeInvitePage:AddListeners()
	IslandTradeInvitePage.super.AddListeners(self)
	self:AddListener(IslandTradegency.INVITE_LIST_UPDATE, self.OnListUpdate)

	return
end

function IslandTradeInvitePage:RemoveListeners()
	IslandTradeInvitePage.super.RemoveListeners(self)
	self:RemoveListener(IslandTradegency.INVITE_LIST_UPDATE, self.OnListUpdate)

	return
end

function IslandTradeInvitePage:OnListUpdate()
	self:FlushList()

	return
end

function IslandTradeInvitePage:OnUpdateItem(arg_5_1, arg_5_2)
	local var_5_0 = self.cards[arg_5_2]

	if not self.cards[arg_5_2] then
		self:OnInitItem(arg_5_2)

		var_5_0 = self.cards[arg_5_2]
	end

	var_5_0:Update(self.displays[arg_5_1 + 1], (self:GetIsland():GetTradeAgency():IsInvited(self.displays[arg_5_1 + 1].id)))

	return
end

function IslandTradeInvitePage:DoInvitation(arg_6_1)
	local var_6_0, var_6_1, var_6_2 = self:GetInfo()

	if var_6_0 then
		self:emit(IslandBaseMediator.TRADE_INVITATION, {
			arg_6_1.player.id
		}, var_6_0, var_6_2)
	end

	return
end

function IslandTradeInvitePage:GetInfo()
	return IslandConst.AGORA_MAP_ID, pg.island_map[IslandConst.AGORA_MAP_ID].name, (self:GetSelfIsland():GetTradeAgency():GetTodaySellPrice())
end

function IslandTradeInvitePage:DoShare()
	local var_8_0, var_8_1, var_8_2 = self:GetInfo()

	if var_8_0 then
		self:emit(IslandBaseMediator.SEND_CHAT, IslandChatConst.CHANNEL_ISLAND, IslandConst.TRADE_SHARE_CODE .. "*" .. var_8_1 .. "*" .. var_8_2)
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_share_success"))
	end

	return
end

function IslandTradeInvitePage:OnOneKey()
	local var_9_0 = self:GetSelfIsland():GetTradeAgency()
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(self.displays) do
		if not var_9_0:IsInvited(iter_9_1.id) then
			table.insert(var_9_1, iter_9_1.id)
		end
	end

	local var_9_2, var_9_3, var_9_4 = self:GetInfo()

	self:emit(IslandBaseMediator.TRADE_INVITATION, var_9_1, var_9_2, var_9_4)

	return
end

function IslandTradeInvitePage:OnShow()
	self:BlurPanel()

	return
end

function IslandTradeInvitePage:OnHide()
	self:UnBlurPanel()

	return
end

return IslandTradeInvitePage
