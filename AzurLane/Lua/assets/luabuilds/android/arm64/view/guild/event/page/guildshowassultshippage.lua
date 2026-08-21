local var_0_0 = class("GuildShowAssultShipPage", import(".GuildEventBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "GuildShowAssultShipPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.scrollrect = arg_2_0._tf:Find("frame/scrollrect"):GetComponent("LScrollRect")
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.progress = arg_2_0._tf:Find("frame/progress"):GetComponent(typeof(Text))

	return
end

function var_0_0.OnAssultShipBeRecommanded(arg_3_0, arg_3_1)
	arg_3_0:InitList()

	return
end

function var_0_0.OnRefreshAll(arg_4_0)
	arg_4_0:InitData()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.displays) do
		({})[iter_4_1.ship.id] = iter_4_1
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0.cards) do
		if ({})[iter_4_3.ship.id] then
			iter_4_3:Flush(({})[iter_4_3.ship.id].member, ({})[iter_4_3.ship.id].ship)
		end
	end

	return
end

function var_0_0.OnInit(arg_5_0)
	onButton(arg_5_0, arg_5_0.closeBtn, function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)

	arg_5_0.cards = {}

	function arg_5_0.scrollrect.onInitItem(arg_7_0)
		arg_5_0:OnInitItem(arg_7_0)

		return
	end

	function arg_5_0.scrollrect.onUpdateItem(arg_8_0, arg_8_1)
		arg_5_0:OnUpdateItem(arg_8_0, arg_8_1)

		return
	end

	return
end

function var_0_0.GetRecommandShipCnt(arg_9_0)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.displays) do
		if iter_9_1.ship.guildRecommand then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function var_0_0.OnInitItem(arg_10_0, arg_10_1)
	local var_10_0 = GuildBossAssultCard.New(arg_10_1)

	onButton(arg_10_0, var_10_0.recommendBtn, function()
		local var_11_0 = var_10_0.ship.guildRecommand and GuildConst.CANCEL_RECOMMAND_SHIP or GuildConst.RECOMMAND_SHIP

		arg_10_0:emit(GuildEventMediator.REFRESH_RECOMMAND_SHIPS, function()
			if var_11_0 == GuildConst.RECOMMAND_SHIP and arg_10_0:GetRecommandShipCnt() >= 9 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_recommend_limit"))

				return
			end

			if var_0.guildRecommand then
				local var_12_0 = GuildConst.RECOMMAND_SHIP or GuildConst.CANCEL_RECOMMAND_SHIP

				if var_11_0 ~= var_12_0 then
					arg_10_0:emit(GuildEventMediator.ON_RECOMM_ASSULT_SHIP, var_0.id, var_11_0)
				elseif var_11_0 == GuildConst.RECOMMAND_SHIP then
					pg.TipsMgr.GetInstance():ShowTips(i18n("guild_assult_ship_recommend_conflict"))
				elseif var_11_0 == GuildConst.CANCEL_RECOMMAND_SHIP then
					pg.TipsMgr.GetInstance():ShowTips(i18n("guild_cancel_assult_ship_recommend_conflict"))
				end

				return
			end
		end)

		return
	end, SFX_PANEL)

	local function var_10_1()
		if IsNil(arg_10_0._tf) then
			return
		end

		pg.UIMgr.GetInstance():BlurPanel(arg_10_0._tf)

		return
	end

	local function var_10_2()
		if IsNil(arg_10_0._tf) then
			return
		end

		pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)

		return
	end

	onButton(arg_10_0, var_10_0.viewEquipmentBtn, function()
		arg_10_0:emit(GuildEventLayer.SHOW_SHIP_EQUIPMENTS, var_10_0.ship, var_10_0.member, var_10_1, var_10_2)

		return
	end, SFX_PANEL)

	arg_10_0.cards[arg_10_1] = var_10_0

	return
end

function var_0_0.OnUpdateItem(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0.cards[arg_16_2] then
		arg_16_0:OnInitItem(arg_16_2)
	end

	arg_16_0.cards[arg_16_2]:Flush(arg_16_0.displays[arg_16_1 + 1].member, arg_16_0.displays[arg_16_1 + 1].ship)

	arg_16_0.progress.text = math.ceil((arg_16_0.scrollrect.value + 0.001) * arg_16_0.totalPageCnt) .. "/" .. arg_16_0.totalPageCnt

	return
end

function var_0_0.OnShow(arg_17_0)
	arg_17_0:emit(GuildEventMediator.ON_GET_ALL_ASSULT_FLEET, function()
		arg_17_0:InitList()

		return
	end)

	return
end

function var_0_0.InitData(arg_19_0)
	arg_19_0.displays = {}

	for iter_19_0, iter_19_1 in pairs((arg_19_0.guild:GetMembers())) do
		local var_19_1 = iter_19_1:GetAssaultFleet()

		for iter_19_2, iter_19_3 in pairs((var_19_1:GetShipList())) do
			table.insert(arg_19_0.displays, {
				ship = iter_19_3,
				member = iter_19_1
			})
		end
	end

	table.sort(arg_19_0.displays, function(arg_20_0, arg_20_1)
		return (arg_20_0.ship.guildRecommand and 1 or 0) > (arg_20_1.ship.guildRecommand and 1 or 0)
	end)

	return
end

function var_0_0.InitList(arg_21_0)
	arg_21_0:InitData()

	arg_21_0.totalPageCnt = math.ceil(#arg_21_0.displays / 9)

	arg_21_0.scrollrect:SetTotalCount(#arg_21_0.displays)

	return
end

function var_0_0.OnDestroy(arg_22_0)
	var_0_0.super.OnDestroy(arg_22_0)

	for iter_22_0, iter_22_1 in pairs(arg_22_0.cards) do
		iter_22_1:Dispose()
	end

	return
end

return var_0_0
