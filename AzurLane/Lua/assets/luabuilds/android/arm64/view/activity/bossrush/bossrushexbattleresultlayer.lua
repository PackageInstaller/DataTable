class = var_0_10000

local var_0_0 = "BossRushEXBattleResultLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BattleResultBossRushEXUI"
end

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "TotalScore/Desc")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("series_enemy_total_score"))

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	local var_3_1 = arg_3_0.contextData.seriesData

	onButton = var_1_10002

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_5.Find(var_3_3, "Confirm")

	local function var_3_5()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		BossRushBattleResultMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.ON_SETTLE)

		return
	end

	SFX_PANEL = var_3_3

	var_1_10002(var_3_2, var_3_4, var_3_5, var_3_3)

	local var_3_6

	if not var_3_1 or not var_3_1:GetFinalResults() then
		var_3_6 = {}
	end

	local var_3_7 = var_3_1 and var_3_1:GetEXScores()
	local var_3_8 = 0

	arg_3_0.retPaintings = {}
	_ = var_5

	local var_3_9 = var_5.each

	_ = var_3_3

	var_3_9(var_3_3.range(#var_3_7), function(arg_5_0)
		local var_5_0 = arg_3_0._tf
		local var_5_1 = var_1.Find(var_5_0, "List")
		local var_5_2 = var_1.GetChild(var_5_1, arg_5_0 - 1)
		local var_5_3 = arg_3_0._tf
		local var_5_4 = var_2.Find(var_5_3, "Paintings")
		local var_5_5 = var_2.GetChild(var_5_4, arg_5_0 - 1)
		local var_5_6 = var_5_2:Find("content/text")
		local var_5_7 = var_5_2
		local var_5_8 = var_5_2.Find(var_5_7, "content/desc")
		local var_5_9 = var_5_5:Find("mask/painting")

		setActive = var_5_7

		var_5_7(var_5_2, arg_5_0 <= #var_3_7)

		setActive = var_5_7

		var_5_7(var_5_5, arg_5_0 <= #var_3_7)

		if #var_3_7 < arg_5_0 then
			return
		end

		setText = var_6

		var_6(var_5_6, var_3_7[arg_5_0])

		setText = var_6

		local var_5_10 = var_5_8

		i18n = var_9

		var_6(var_5_10, var_9("series_enemy_score") .. " ")

		var_3_8 = var_3_8 + var_3_7[arg_5_0]

		local var_5_11

		if not (function()
			if not var_3_6[arg_5_0] then
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
			BayProxy = var_3_10005

			local var_6_0 = var_3_10003(var_3_10005)

			if not var_3.RawGetShipById(var_6_0, var_2) then
				return
			end

			return var_3:getPainting()
		end)() then
			var_5_11 = "changdao"
		end

		local var_5_12 = arg_3_0

		var_8.setPainting(var_5_12, var_5_9, var_5_11)

		table = var_8

		var_8.insert(arg_3_0.retPaintings, {
			var_5_9,
			var_5_11
		})

		return
	end)

	setText = var_3_9

	local var_3_10 = arg_3_0._tf

	var_3_9(var_7.Find(var_3_10, "TotalScore/Text"), var_3_8)
	arg_3_0:loadUI()

	return
end

function var_0_1.shareEx(arg_8_0)
	return
end

function var_0_1.setPainting(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	setPaintingPrefabAsync = var_1_10004

	var_1_10004(arg_9_1, arg_9_2, "biandui", arg_9_3)

	return
end

function var_0_1.retPainting(arg_10_0, arg_10_1, arg_10_2)
	retPaintingPrefab = var_1_10003

	var_1_10003(arg_10_1, arg_10_2)

	return
end

function var_0_1.onBackPressed(arg_11_0)
	triggerButton = var_1_10001

	local var_11_0 = arg_11_0._tf

	var_1_10001(var_3.Find(var_11_0, "Confirm"))

	return
end

function var_0_1.willExit(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf)

	if arg_12_0.retPaintings and #arg_12_0.retPaintings > 0 then
		ipairs = var_1

		for iter_12_0, iter_12_1 in var_1(arg_12_0.retPaintings) do
			arg_12_0:retPainting(iter_12_1[1], iter_12_1[2])
		end
	end

	return
end

function var_0_1.loadUI(arg_13_0)
	PoolMgr = var_1_10001

	local var_13_0 = var_1_10001.GetInstance()

	var_1.GetUI(var_13_0, "ShareUI", false, function(arg_14_0)
		local var_14_0 = arg_14_0.transform
		local var_14_1 = var_1.Find(var_14_0, "panel")
		local var_14_2 = var_1
		local var_14_3 = var_1.Find(var_14_2, "panel_pink")

		setParent = var_14_0

		var_14_0(var_1, arg_13_0._tf)

		local var_14_4 = var_1
		local var_14_5 = var_1.Find(var_14_4, "deck")

		setActive = var_14_2

		var_14_2(var_14_1, false)

		setActive = var_14_2

		var_14_2(var_14_3, false)

		local var_14_6 = var_1
		local var_14_7 = var_1.Find(var_14_6, "deck/logo")

		GetComponent = var_14_4

		local var_14_8 = var_14_4(var_14_7, "Image")

		var_6.SetNativeSize(var_14_8)

		pg = var_6

		local var_14_9 = var_6.share_template

		pg = var_14_6

		local var_14_10 = var_14_9[var_14_6.ShareMgr.TypeBossRushEX]

		assert = var_7

		local var_14_11 = var_14_10
		local var_14_12 = "share_template not exist: "

		pg = var_2_10011

		var_7(var_14_11, var_14_12 .. var_2_10011.ShareMgr.TypeBossRushEX)

		getProxy = var_7
		PlayerProxy = var_14_11

		local var_14_13 = var_7(var_14_11)
		local var_14_14 = var_7.getRawData(var_14_13)

		getProxy = var_14_8
		UserProxy = var_10

		local var_14_15 = var_14_8(var_10)
		local var_14_16 = var_8.getRawData(var_14_15)

		getProxy = var_14_13
		ServerProxy = var_11

		local var_14_17 = var_14_13(var_11)
		local var_14_18 = var_9.getRawData(var_14_17)
		local var_14_19

		if not var_14_16 or not var_14_16.server then
			var_14_19 = 0
		end

		local var_14_20 = var_14_18[var_14_19]
		local var_14_21

		if not var_14_14 or not var_14_14.name then
			var_14_21 = ""
		end

		local var_14_22

		if not var_14_20 or not var_14_20.name then
			var_14_22 = ""
		end

		pg = var_2_10012

		local var_14_23

		if not var_2_10012.ShareMgr.ANCHORS_TYPE[var_14_10.deck] then
			var_14_23 = {
				0.5,
				0.5,
				0.5,
				0.5
			}
		end

		Vector2 = var_13
		var_14_5.anchorMin = var_13(var_14_23[1], var_14_23[2])
		Vector2 = var_13
		var_14_5.anchorMax = var_13(var_14_23[3], var_14_23[4])
		setText = var_13

		var_13(var_14_5:Find("name/value"), var_14_21)

		setText = var_13

		var_13(var_14_5:Find("server/value"), var_14_22)

		setText = var_13

		var_13(var_14_5:Find("lv/value"), var_14_14.level)

		PLATFORM_CODE = var_13
		PLATFORM_CHT = var_2_10014

		if var_13 ~= var_2_10014 then
			PLATFORM_CODE = var_13
			PLATFORM_CH = var_2_10014

			if var_13 == var_2_10014 then
				setActive = var_13

				var_13(var_14_5:Find("code_bg"), true)
			else
				setActive = var_13

				var_13(var_14_5:Find("code_bg"), false)
			end

			Vector3 = var_13
			var_14_5.anchoredPosition3D = var_13(var_14_10.qrcode_location[1], var_14_10.qrcode_location[2], -100)
			Vector2 = var_13
			var_14_5.anchoredPosition = var_13(var_14_10.qrcode_location[1], var_14_10.qrcode_location[2])

			return
		end
	end)

	return
end

return var_0_1
