class = var_0_10000

local var_0_0 = "BossRushEscapeManorBattleResultLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BattleResultBossRushEscapeManorEXUI"
end

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "TotalScore/Desc")

	i18n = var_2_0

	var_1_10001(var_2_1, var_2_0("series_enemy_total_score"))

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	local var_3_1 = arg_3_0.contextData.seriesData

	onButton = var_3_0

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_4.Find(var_3_3, "Confirm")

	local function var_3_5()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		BossRushBattleResultMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.ON_SETTLE)

		return
	end

	SFX_PANEL = var_6

	var_3_0(var_3_2, var_3_4, var_3_5, var_6)

	setText = var_3_0

	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_3.Find(var_3_6, "Confirm/Text")

	i18n = var_3_6

	var_3_0(var_3_7, var_3_6("battle_result_confirm"))

	local var_3_8

	if not var_3_1 or not var_3_1:GetFinalResults() then
		var_3_8 = {}
	end

	local var_3_9 = var_3_1 and var_3_1:GetEXScores()
	local var_3_10 = 0

	arg_3_0.retPaintings = {}
	_ = var_5

	local var_3_11 = var_5.each

	_ = var_6

	var_3_11(var_6.range(#var_3_9), function(arg_5_0)
		local var_5_0 = arg_3_0._tf
		local var_5_1 = var_1.Find(var_5_0, "Paintings")
		local var_5_2 = var_1.GetChild(var_5_1, arg_5_0 - 1)
		local var_5_3 = var_1.Find(var_5_2, "content/text")
		local var_5_4 = var_1:Find("content/desc")
		local var_5_5 = var_1
		local var_5_6 = var_1.Find(var_5_5, "mask/painting")

		setActive = var_5_5

		var_5_5(var_1, arg_5_0 <= #var_3_9)

		if #var_3_9 < arg_5_0 then
			return
		end

		setText = var_5

		var_5(var_5_3, var_3_9[arg_5_0])

		setText = var_5

		local var_5_7 = var_5_4

		i18n = var_7

		var_5(var_5_7, var_7("series_enemy_score") .. " ")

		var_3_10 = var_3_10 + var_3_9[arg_5_0]

		local var_5_8

		if not (function()
			if not var_3_8[arg_5_0] then
				return
			end

			if not (function()
				if var_0.mvp ~= 0 then
					return var_0.mvp
				end

				local var_7_0

				if not var_0.newShips[1] or not var_0.newShips[1].id then
					var_7_0 = nil
				end

				return var_7_0
			end)() then
				return
			end

			getProxy = var_3_10003
			BayProxy = var_3_10004

			local var_6_0 = var_3_10003(var_3_10004)

			if not var_3.RawGetShipById(var_6_0, var_2) then
				return
			end

			return var_3:getPainting()
		end)() then
			var_5_8 = "changdao"
		end

		local var_5_9 = arg_3_0

		var_7.setPainting(var_5_9, var_5_6, var_5_8)

		table = var_7

		var_7.insert(arg_3_0.retPaintings, {
			var_5_6,
			var_5_8
		})

		return
	end)

	setText = var_3_11

	local var_3_12 = arg_3_0._tf

	var_3_11(var_6.Find(var_3_12, "TotalScore/Text"), var_3_10)
	arg_3_0:loadUI()

	return
end

function var_0_1.setPainting(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	setPaintingPrefabAsync = var_1_10004

	var_1_10004(arg_8_1, arg_8_2, "biandui", arg_8_3)

	return
end

function var_0_1.retPainting(arg_9_0, arg_9_1, arg_9_2)
	retPaintingPrefab = var_1_10003

	var_1_10003(arg_9_1, arg_9_2)

	return
end

function var_0_1.onBackPressed(arg_10_0)
	triggerButton = var_1_10001

	local var_10_0 = arg_10_0._tf

	var_1_10001(var_2.Find(var_10_0, "Confirm"))

	return
end

function var_0_1.willExit(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_0, arg_11_0._tf)

	if arg_11_0.retPaintings and #arg_11_0.retPaintings > 0 then
		ipairs = var_1

		for iter_11_0, iter_11_1 in var_1(arg_11_0.retPaintings) do
			arg_11_0:retPainting(iter_11_1[1], iter_11_1[2])
		end
	end

	return
end

function var_0_1.loadUI(arg_12_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)
	local var_12_1 = var_1.getRawData(var_12_0)

	getProxy = var_12_0
	UserProxy = var_1_10003

	local var_12_2 = var_12_0(var_1_10003)
	local var_12_3 = var_2.getRawData(var_12_2)

	getProxy = var_12_2
	ServerProxy = var_1_10004

	local var_12_4 = var_12_2(var_1_10004)
	local var_12_5 = var_3.getRawData(var_12_4)
	local var_12_6

	if not var_12_3 or not var_12_3.server then
		var_12_6 = 0
	end

	local var_12_7 = var_12_5[var_12_6]
	local var_12_8

	if not var_12_1 or not var_12_1.name then
		var_12_8 = ""
	end

	local var_12_9

	if not var_12_7 or not var_12_7.name then
		var_12_9 = ""
	end

	local var_12_10 = arg_12_0._tf
	local var_12_11 = var_6.Find(var_12_10, "share")

	setText = var_12_10

	var_12_10(var_12_11:Find("name/value"), var_12_8)

	setText = var_12_10

	local var_12_12 = var_12_11
	local var_12_13 = var_12_11.Find(var_12_12, "server")

	i18n = var_12_12

	var_12_10(var_12_13, var_12_12("zengke_series_serverinfo"))

	setText = var_12_10

	var_12_10(var_12_11:Find("server/value"), var_12_9)

	setText = var_12_10

	var_12_10(var_12_11:Find("lv/value"), var_12_1.level)

	return
end

return var_0_1
