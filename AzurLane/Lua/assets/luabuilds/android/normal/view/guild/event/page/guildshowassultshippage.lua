class = var_0_10000

local var_0_0 = "GuildShowAssultShipPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildEventBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "GuildShowAssultShipPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/scrollrect")

	arg_2_0.scrollrect = var_1.GetComponent(var_2_1, "LScrollRect")

	local var_2_2 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_2, "frame/close")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/progress")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.progress = var_2_5(var_2_4, var_3(var_1_10004))

	return
end

function var_0_1.OnAssultShipBeRecommanded(arg_3_0, arg_3_1)
	arg_3_0:InitList()

	return
end

function var_0_1.OnRefreshAll(arg_4_0)
	local var_4_0 = arg_4_0

	arg_4_0.InitData(var_4_0)

	local var_4_1 = {}

	ipairs = var_4_0

	for iter_4_0, iter_4_1 in var_4_0(arg_4_0.displays) do
		var_4_1[iter_4_1.ship.id] = iter_4_1
	end

	pairs = var_2

	for iter_4_2, iter_4_3 in var_2(arg_4_0.cards) do
		if var_4_1[iter_4_3.ship.id] then
			iter_4_3:Flush(var_7.member, var_7.ship)
		end
	end

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.closeBtn

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	arg_5_0.cards = {}

	function arg_5_0.scrollrect.onInitItem(arg_7_0)
		local var_7_0 = arg_5_0

		var_1.OnInitItem(var_7_0, arg_7_0)

		return
	end

	function arg_5_0.scrollrect.onUpdateItem(arg_8_0, arg_8_1)
		local var_8_0 = arg_5_0

		var_2.OnUpdateItem(var_8_0, arg_8_0, arg_8_1)

		return
	end

	return
end

function var_0_1.GetRecommandShipCnt(arg_9_0)
	local var_9_0 = 0

	ipairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.displays) do
		if iter_9_1.ship.guildRecommand then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function var_0_1.OnInitItem(arg_10_0, arg_10_1)
	GuildBossAssultCard = var_1_10002

	local var_10_0 = var_1_10002.New(arg_10_1)

	onButton = var_3

	local var_10_1 = arg_10_0
	local var_10_2 = var_10_0.recommendBtn

	local function var_10_3()
		if var_10_0.ship.guildRecommand then
			GuildConst = var_11_0

			local var_11_0

			if not var_11_0.CANCEL_RECOMMAND_SHIP then
				GuildConst = var_11_0
				var_11_0 = var_11_0.RECOMMAND_SHIP
			end

			local var_11_1 = arg_10_0
			local var_11_2 = var_2.emit

			GuildEventMediator = var_2_10004

			var_11_2(var_11_1, var_2_10004.REFRESH_RECOMMAND_SHIPS, function()
				local var_12_0 = var_11_0

				GuildConst = var_3_10001

				if var_12_0 == var_3_10001.RECOMMAND_SHIP then
					local var_12_1 = arg_10_0

					if var_0.GetRecommandShipCnt(var_12_1) >= 9 then
						pg = var_0

						local var_12_2 = var_0.TipsMgr.GetInstance()
						local var_12_3 = var_0.ShowTips

						i18n = var_3_10002

						var_12_3(var_12_2, var_3_10002("guild_recommend_limit"))

						return
					end
				end

				if var_0.guildRecommand then
					GuildConst = var_12_4

					local var_12_4

					if not var_12_4.RECOMMAND_SHIP then
						GuildConst = var_12_4
						var_12_4 = var_12_4.CANCEL_RECOMMAND_SHIP
					end

					if var_11_0 ~= var_12_4 then
						var_3_10002 = arg_10_0

						local var_12_5 = var_1.emit

						GuildEventMediator = var_3_10003

						var_12_5(var_3_10002, var_3_10003.ON_RECOMM_ASSULT_SHIP, var_0.id, var_11_0)
					else
						local var_12_6 = var_11_0

						GuildConst = var_3_10002

						local var_12_7

						if var_12_6 == var_3_10002.RECOMMAND_SHIP then
							pg = var_12_6
							var_12_7 = var_12_6.TipsMgr.GetInstance()

							local var_12_8 = var_1.ShowTips

							i18n = var_3_10003

							var_12_8(var_12_7, var_3_10003("guild_assult_ship_recommend_conflict"))
						else
							local var_12_9 = var_11_0

							GuildConst = var_12_7

							if var_12_9 == var_12_7.CANCEL_RECOMMAND_SHIP then
								pg = var_12_9

								local var_12_10 = var_12_9.TipsMgr.GetInstance()
								local var_12_11 = var_1.ShowTips

								i18n = var_3_10003

								var_12_11(var_12_10, var_3_10003("guild_cancel_assult_ship_recommend_conflict"))
							end
						end
					end

					return
				end
			end)

			return
		end
	end

	SFX_PANEL = var_1_10007

	var_3(var_10_1, var_10_2, var_10_3, var_1_10007)

	local function var_10_4()
		IsNil = var_2_10000

		if var_2_10000(arg_10_0._tf) then
			return
		end

		pg = var_0

		local var_13_0 = var_0.UIMgr.GetInstance()

		var_0.BlurPanel(var_13_0, arg_10_0._tf)

		return
	end

	local function var_10_5()
		IsNil = var_2_10000

		if var_2_10000(arg_10_0._tf) then
			return
		end

		pg = var_0

		local var_14_0 = var_0.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_14_0, arg_10_0._tf, arg_10_0._parentTf)

		return
	end

	onButton = var_10_2

	local var_10_6 = arg_10_0
	local var_10_7 = var_10_0.viewEquipmentBtn

	local function var_10_8()
		local var_15_0 = var_10_0.ship
		local var_15_1 = var_10_0.member
		local var_15_2 = arg_10_0
		local var_15_3 = var_2.emit

		GuildEventLayer = var_2_10004

		var_15_3(var_15_2, var_2_10004.SHOW_SHIP_EQUIPMENTS, var_15_0, var_15_1, var_10_4, var_10_5)

		return
	end

	SFX_PANEL = var_1_10009

	var_10_2(var_10_6, var_10_7, var_10_8, var_1_10009)

	arg_10_0.cards[arg_10_1] = var_10_0

	return
end

function var_0_1.OnUpdateItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	if not arg_16_0.cards[arg_16_2] then
		arg_16_0:OnInitItem(arg_16_2)

		var_16_0 = arg_16_0.cards[arg_16_2]
	end

	local var_16_1 = arg_16_0.displays[arg_16_1 + 1]
	local var_16_2 = var_16_0

	var_16_0.Flush(var_16_2, var_16_1.member, var_16_1.ship)

	local var_16_3 = arg_16_0.totalPageCnt

	math = var_16_2

	local var_16_4 = var_16_2.ceil((arg_16_0.scrollrect.value + 0.001) * var_16_3)

	arg_16_0.progress.text = var_16_4 .. "/" .. var_16_3

	return
end

function var_0_1.OnShow(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.emit

	GuildEventMediator = var_1_10003

	var_17_1(var_17_0, var_1_10003.ON_GET_ALL_ASSULT_FLEET, function()
		local var_18_0 = arg_17_0

		var_0.InitList(var_18_0)

		return
	end)

	return
end

function var_0_1.InitData(arg_19_0)
	local var_19_0 = arg_19_0.guild
	local var_19_1 = arg_19_0.player

	arg_19_0.displays = {}

	local var_19_2 = var_19_0
	local var_19_3 = var_19_0.GetMembers(var_19_2)

	pairs = var_19_2

	for iter_19_0, iter_19_1 in var_19_2(var_19_3) do
		local var_19_4 = iter_19_1:GetAssaultFleet()
		local var_19_5 = var_9.GetShipList(var_19_4)

		pairs = var_19_4

		for iter_19_2, iter_19_3 in var_19_4(var_19_5) do
			table = var_1_10016

			var_1_10016.insert(arg_19_0.displays, {
				ship = iter_19_3,
				member = iter_19_1
			})
		end
	end

	table = var_4

	var_4.sort(arg_19_0.displays, function(arg_20_0, arg_20_1)
		return (arg_20_0.ship.guildRecommand and 1 or 0) > (arg_20_1.ship.guildRecommand and 1 or 0)
	end)

	return
end

function var_0_1.InitList(arg_21_0)
	arg_21_0:InitData()

	math = var_1
	arg_21_0.totalPageCnt = var_1.ceil(#arg_21_0.displays / 9)

	local var_21_0 = arg_21_0.scrollrect

	var_1.SetTotalCount(var_21_0, #arg_21_0.displays)

	return
end

function var_0_1.OnDestroy(arg_22_0)
	var_0_1.super.OnDestroy(arg_22_0)

	pairs = var_1

	for iter_22_0, iter_22_1 in var_1(arg_22_0.cards) do
		iter_22_1:Dispose()
	end

	return
end

return var_0_1
