local GuildShowAssultShipPage = class("GuildShowAssultShipPage", import(".GuildEventBasePage"))

function GuildShowAssultShipPage:getUIName()
	return "GuildShowAssultShipPage"
end

function GuildShowAssultShipPage:OnLoaded()
	self.scrollrect = self._tf:Find("frame/scrollrect"):GetComponent("LScrollRect")
	self.closeBtn = self._tf:Find("frame/close")
	self.progress = self._tf:Find("frame/progress"):GetComponent(typeof(Text))

	return
end

function GuildShowAssultShipPage:OnAssultShipBeRecommanded(arg_3_1)
	self:InitList()

	return
end

function GuildShowAssultShipPage:OnRefreshAll()
	self:InitData()

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self.displays) do
		var_4_0[iter_4_1.ship.id] = iter_4_1
	end

	for iter_4_2, iter_4_3 in pairs(self.cards) do
		if var_4_0[iter_4_3.ship.id] then
			iter_4_3:Flush(var_4_0[iter_4_3.ship.id].member, var_4_0[iter_4_3.ship.id].ship)
		end
	end

	return
end

function GuildShowAssultShipPage:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.cards = {}

	function self.scrollrect.onInitItem(arg_7_0)
		self:OnInitItem(arg_7_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_8_0, arg_8_1)
		self:OnUpdateItem(arg_8_0, arg_8_1)

		return
	end

	return
end

function GuildShowAssultShipPage:GetRecommandShipCnt()
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(self.displays) do
		if iter_9_1.ship.guildRecommand then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function GuildShowAssultShipPage:OnInitItem(arg_10_1)
	local var_10_0 = GuildBossAssultCard.New(arg_10_1)

	onButton(self, var_10_0.recommendBtn, function()
		local var_11_0 = var_10_0.ship

		if var_10_0.ship.guildRecommand then
			local var_11_1 = GuildConst.CANCEL_RECOMMAND_SHIP or GuildConst.RECOMMAND_SHIP
		end

		self:emit(GuildEventMediator.REFRESH_RECOMMAND_SHIPS, function()
			if var_11_1 == GuildConst.RECOMMAND_SHIP and self:GetRecommandShipCnt() >= 9 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_recommend_limit"))

				return
			end

			if var_11_0.guildRecommand then
				if var_11_1 ~= (GuildConst.RECOMMAND_SHIP or GuildConst.CANCEL_RECOMMAND_SHIP) then
					self:emit(GuildEventMediator.ON_RECOMM_ASSULT_SHIP, var_11_0.id, var_11_1)
				elseif var_11_1 == GuildConst.RECOMMAND_SHIP then
					pg.TipsMgr.GetInstance():ShowTips(i18n("guild_assult_ship_recommend_conflict"))
				elseif var_11_1 == GuildConst.CANCEL_RECOMMAND_SHIP then
					pg.TipsMgr.GetInstance():ShowTips(i18n("guild_cancel_assult_ship_recommend_conflict"))
				end
			end

			return
		end)

		return
	end, SFX_PANEL)

	local function var_10_1()
		if IsNil(self._tf) then
			return
		end

		pg.UIMgr.GetInstance():BlurPanel(self._tf)

		return
	end

	local function var_10_2()
		if IsNil(self._tf) then
			return
		end

		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

		return
	end

	onButton(self, var_10_0.viewEquipmentBtn, function()
		self:emit(GuildEventLayer.SHOW_SHIP_EQUIPMENTS, var_10_0.ship, var_10_0.member, var_10_1, var_10_2)

		return
	end, SFX_PANEL)

	self.cards[arg_10_1] = var_10_0

	return
end

function GuildShowAssultShipPage:OnUpdateItem(arg_16_1, arg_16_2)
	if not self.cards[arg_16_2] then
		self:OnInitItem(arg_16_2)
	end

	self.cards[arg_16_2]:Flush(self.displays[arg_16_1 + 1].member, self.displays[arg_16_1 + 1].ship)

	self.progress.text = math.ceil((self.scrollrect.value + 0.001) * self.totalPageCnt) .. "/" .. self.totalPageCnt

	return
end

function GuildShowAssultShipPage:OnShow()
	self:emit(GuildEventMediator.ON_GET_ALL_ASSULT_FLEET, function()
		self:InitList()

		return
	end)

	return
end

function GuildShowAssultShipPage:InitData()
	self.displays = {}

	for iter_19_0, iter_19_1 in pairs((self.guild:GetMembers())) do
		for iter_19_2, iter_19_3 in pairs((iter_19_1:GetAssaultFleet():GetShipList())) do
			table.insert(self.displays, {
				ship = iter_19_3,
				member = iter_19_1
			})
		end
	end

	table.sort(self.displays, function(arg_20_0, arg_20_1)
		return (arg_20_0.ship.guildRecommand and 1 or 0) > (arg_20_1.ship.guildRecommand and 1 or 0)
	end)

	return
end

function GuildShowAssultShipPage:InitList()
	self:InitData()

	self.totalPageCnt = math.ceil(#self.displays / 9)

	self.scrollrect:SetTotalCount(#self.displays)

	return
end

function GuildShowAssultShipPage:OnDestroy()
	GuildShowAssultShipPage.super.OnDestroy(self)

	for iter_22_0, iter_22_1 in pairs(self.cards) do
		iter_22_1:Dispose()
	end

	return
end

return GuildShowAssultShipPage
