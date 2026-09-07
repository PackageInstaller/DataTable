local IslandTradeRankPage = class("IslandTradeRankPage", import("view.base.BaseSubView"))

function IslandTradeRankPage:getUIName()
	return "IslandTradeRankUI"
end

function IslandTradeRankPage:OnLoaded()
	setText(self._tf:Find("title/Text"), i18n("island_trade_rank_num_label"))
	setText(self._tf:Find("title/Text_1"), i18n("island_trade_rank_info_label"))
	setText(self._tf:Find("title/Text_2"), i18n("island_trade_rank_price_label"))
	setText(self._tf:Find("tpl/main/visit/Text"), i18n("island_visit_title"))
	setText(self._tf:Find("tpl/main/invite/Text"), i18n("island_trade_invite_label"))

	self.scrollrect = self._tf:Find("scrollrect"):GetComponent("LScrollRect")

	function self.scrollrect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	self.selfRankCard = IslandTradeRankCard.New(self._tf:Find("tpl"))
	self.cards = {}

	return
end

function IslandTradeRankPage:Show(arg_5_1, arg_5_2)
	IslandTradeRankPage.super.Show(self)

	self.mode = arg_5_2

	seriesAsync({
		function(arg_6_0)
			self:RequestRank(arg_6_0)

			return
		end
	}, function()
		local var_7_0, var_7_1, var_7_2 = self:GetDislays()

		self.rankNums = var_7_2

		self:DisplayResult(var_7_1, var_7_0)
		self:UpdateSelfRank(var_7_0)

		return
	end)

	return
end

function IslandTradeRankPage:GetDislays()
	local var_8_0
	local var_8_1

	if self.mode == IslandTradePage.MODE_SELL then
		var_8_0, var_8_1 = getProxy(IslandProxy):GetIsland():GetTradeAgency():GetSellRanks()
	elseif self.mode == IslandTradePage.MODE_PURCHAS then
		var_8_0, var_8_1 = getProxy(IslandProxy):GetIsland():GetTradeAgency():GetRanks()
	end

	local var_8_2 = {}

	table.insert(var_8_2, var_8_1)

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if iter_8_1:IsVaild() then
			table.insert(var_8_2, iter_8_1)
		end
	end

	table.sort(var_8_2, function(arg_9_0, arg_9_1)
		if self.mode == IslandTradePage.MODE_SELL then
			return arg_9_0.value > arg_9_1.value
		elseif self.mode == IslandTradePage.MODE_PURCHAS then
			return arg_9_0.value < arg_9_1.value
		end

		return
	end)

	local var_8_3 = {}
	local var_8_4 = 0

	for iter_8_2, iter_8_3 in ipairs(var_8_2) do
		if iter_8_3.value ~= 0 then
			var_8_4 = var_8_4 + 1
			var_8_3[iter_8_3.value] = var_8_4
		end
	end

	return var_8_1, var_8_2, var_8_3
end

function IslandTradeRankPage:RequestRank(arg_10_1)
	self:emit(IslandBaseMediator.REQ_TRADE_RANK, arg_10_1)

	return
end

function IslandTradeRankPage:DisplayResult(arg_11_1, arg_11_2)
	self.displays = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if iter_11_1.id ~= arg_11_2.id then
			table.insert(self.displays, iter_11_1)
		end
	end

	self.scrollrect:SetTotalCount(#self.displays)

	return
end

function IslandTradeRankPage:OnInitItem(arg_12_1)
	local var_12_0 = IslandTradeRankCard.New(arg_12_1)

	onButton(self, var_12_0.visitBtn, function()
		self:emit(IslandBaseMediator.ENTER_ISLAND, var_12_0.id)

		return
	end, SFX_PANEL)

	self.cards[arg_12_1] = var_12_0

	return
end

function IslandTradeRankPage:OnUpdateItem(arg_14_1, arg_14_2)
	local var_14_0 = self.cards[arg_14_2]

	if not self.cards[arg_14_2] then
		self:OnInitItem(arg_14_2)

		var_14_0 = self.cards[arg_14_2]
	end

	local var_14_1 = self.displays[arg_14_1 + 1]

	assert(self.rankNums[self.displays[arg_14_1 + 1].value], self.displays[arg_14_1 + 1].value)
	var_14_0:Update(self.rankNums[self.displays[arg_14_1 + 1].value], var_14_1, arg_14_1)

	return
end

function IslandTradeRankPage:UpdateSelfRank(arg_15_1)
	self.selfRankCard:Update(self.rankNums[arg_15_1.value], arg_15_1, 0)
	onButton(self, self.selfRankCard.inviteBtn, function()
		self:emit(IslandTradePage.OPEN_INVITE_PAGE)

		return
	end, SFX_PANEL)

	return
end

function IslandTradeRankPage:OnDestory()
	ClearLScrollrect(self.scrollrect)

	for iter_17_0, iter_17_1 in pairs(self.cards) do
		iter_17_1:Dispose()
	end

	self.cards = nil

	self.selfRankCard:Dispose()

	return
end

return IslandTradeRankPage
