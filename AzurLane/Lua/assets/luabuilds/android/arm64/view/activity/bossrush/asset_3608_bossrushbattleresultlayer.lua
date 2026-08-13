class = var_0_10000

local var_0_0 = "BossRushBattleResultLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BattleResultBossRushUI"
end

function var_0_1.getGroupName(arg_2_0)
	return "BattleScene"
end

function var_0_1.Ctor(arg_3_0, ...)
	var_0_1.super.Ctor(arg_3_0, ...)

	AutoLoader = var_1
	arg_3_0.loader = var_1.New()

	return
end

function var_0_1.GetAtalsName(arg_4_0)
	return "ui/battleresult_atlas"
end

function var_0_1.preload(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.loader

	var_2.LoadBundle(var_5_0, arg_5_0:GetAtalsName())

	existCall = var_2

	var_2(arg_5_1)

	return
end

function var_0_1.init(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "main/Series")

	arg_6_0.resultScroll = var_1.Find(var_6_1, "Scroll")
	arg_6_0.resultList = var_1:Find("Scroll/List")
	arg_6_0.playerExp = var_1:Find("playerExp")
	arg_6_0.rightBottomPanel = var_1:Find("rightBottomPanel")
	setText = var_2

	local var_6_2 = arg_6_0.rightBottomPanel
	local var_6_3 = var_4.Find(var_6_2, "confirmBtn/Text")

	i18n = var_5

	var_2(var_6_3, var_5("text_confirm"))

	setText = var_2

	local var_6_4 = arg_6_0.resultList
	local var_6_5 = var_4.Find(var_6_4, "Result/BG/Ships/resulttpl/result/Statistics/kill_count_label")

	i18n = var_5

	var_2(var_6_5, var_5("battle_result_kill_count"))

	setText = var_2

	local var_6_6 = arg_6_0.resultList
	local var_6_7 = var_4.Find(var_6_6, "Result/BG/Ships/resulttpl/result/Statistics/dmg_count_label")

	i18n = var_5

	var_2(var_6_7, var_5("battle_result_dmg"))

	setText = var_2

	local var_6_8 = arg_6_0.resultList
	local var_6_9 = var_4.Find(var_6_8, "Result/BG/commanderExp/commander_container")
	local var_6_10 = var_4.GetChild(var_6_9, 0)
	local var_6_11 = var_4.Find(var_6_10, "empty/add/Text")

	i18n = var_5

	var_2(var_6_11, var_5("series_enemy_empty_commander_main"))

	setText = var_2

	local var_6_12 = arg_6_0.resultList
	local var_6_13 = var_4.Find(var_6_12, "Result/BG/commanderExp/commander_container")
	local var_6_14 = var_4.GetChild(var_6_13, 1)
	local var_6_15 = var_4.Find(var_6_14, "empty/add/Text")

	i18n = var_5

	var_2(var_6_15, var_5("series_enemy_empty_commander_assistant"))

	return
end

local var_0_2 = {
	"sucess_title_bg",
	"fail_title_bg",
	"none_title_bg"
}
local var_0_3 = {
	"1216207f",
	"48160d7f",
	"3c3c3c7f"
}

function var_0_1.didEnter(arg_7_0)
	arg_7_0:BlurPanel(arg_7_0._tf, {
		staticBlur = true,
		lockGlobalBlur = true
	})

	local var_7_0 = arg_7_0.contextData.seriesData
	local var_7_1 = var_1.GetBattleStatistics(var_7_0)
	local var_7_2 = var_1:GetFinalResults()
	local var_7_3 = var_1:GetExpeditionIds()
	local var_7_4, var_7_5 = var_1:GetModeFleetIDs(var_1:GetMode())
	local var_7_6 = var_1:GetFleets(var_7_4)
	local var_7_7 = var_1:GetFleets(var_7_5)[1]
	local var_7_8 = var_8.getTeamByName

	TeamType = var_1_10012

	local var_7_9 = var_7_8(var_7_7, var_1_10012.Submarine)
	local var_7_10 = var_8:GetRawCommanderIds()
	local var_7_11 = {}
	local var_7_12 = {}

	for iter_7_0 = 1, #var_7_3 do
		local var_7_13

		if not var_7_6[iter_7_0] then
			var_7_13 = var_7_6[1]
		end

		local var_7_14 = var_7_2[iter_7_0]
		local var_7_15 = {
			index = iter_7_0,
			oldShips = {},
			ships = {},
			oldCmds = {},
			cmds = {}
		}
		local var_7_16

		if not var_7_14 or not var_7_14.mvp then
			var_7_16 = 0
		end

		var_7_15.mvp = var_7_16
		Clone = var_7_16

		local var_7_17 = var_7_16(var_7_15)

		table = var_1_10021

		var_1_10021.Foreach(var_7_13:getShipIds(), function(arg_8_0, arg_8_1)
			local var_8_0

			if iter_7_0 <= #var_7_2 then
				if var_7_14.newShips[arg_8_1] then
					table = var_8_0

					var_8_0.insert(var_7_15.ships, var_2)

					var_8_0 = var_7_15.oldShips
					var_8_0[arg_8_1] = var_7_14.oldShips[arg_8_1]
				end
			else
				getProxy = var_2
				BayProxy = var_2_10004

				local var_8_1 = var_2(var_2_10004)
				local var_8_2 = var_2.getShipById(var_8_1, arg_8_1)

				table = var_8_0

				var_8_0.insert(var_7_15.ships, var_8_2)

				var_7_15.oldShips[arg_8_1] = var_8_2
			end

			return
		end)

		table = var_1_10021

		var_1_10021.Foreach(var_7_9, function(arg_9_0, arg_9_1)
			if iter_7_0 <= #var_7_2 and var_7_14.newShips[arg_9_1] then
				table = var_3

				var_3.insert(var_7_17.ships, var_2)

				var_7_17.oldShips[arg_9_1] = var_7_14.oldShips[arg_9_1]
			end

			return
		end)

		var_1_10021 = var_7_13:GetRawCommanderIds()
		_ = var_22

		var_22.each({
			1,
			2
		}, function(arg_10_0)
			local var_10_0

			if not var_1_10021[arg_10_0] then
				var_10_0 = false
			end

			if var_10_0 then
				local var_10_1

				if iter_7_0 <= #var_7_2 then
					if var_7_14.newCmds[var_10_0] then
						table = var_10_1

						var_10_1.insert(var_7_15.cmds, var_2_10002)

						var_10_1 = var_7_15.oldCmds
						var_10_1[var_10_0] = var_7_14.oldCmds[var_10_0]
					end
				else
					getProxy = var_2_10002
					CommanderProxy = var_2_10004

					local var_10_2 = var_2_10002(var_2_10004)

					var_2_10002 = var_2_10002.getCommanderById(var_10_2, var_10_0)
					table = var_10_1

					var_10_1.insert(var_7_15.cmds, var_2_10002)

					var_7_15.oldCmds[var_10_0] = var_2_10002
				end
			else
				table = var_2_10002

				var_2_10002.insert(var_7_15.cmds, false)
			end

			return
		end)

		_ = var_22

		var_22.each({
			1,
			2
		}, function(arg_11_0)
			local var_11_0

			if not var_7_10[arg_11_0] then
				var_11_0 = false
			end

			if iter_7_0 <= #var_7_2 then
				if var_11_0 then
					local var_11_1

					if var_7_14.newCmds[var_11_0] then
						table = var_11_1

						var_11_1.insert(var_7_17.cmds, var_2)

						var_11_1 = var_7_17.oldCmds
						var_11_1[var_2.id] = var_7_14.oldCmds[var_11_0]
					else
						table = var_11_1

						var_11_1.insert(var_7_17.cmds, false)
					end
				else
					table = var_2

					var_2.insert(var_7_17.cmds, false)
				end
			end

			return
		end)

		var_7_11[iter_7_0] = var_7_15
		next = var_22

		if var_22(var_7_17.ships) then
			table = var_22

			var_22.insert(var_7_12, var_7_17)
		end
	end

	local var_7_18 = 0
	local var_7_19 = 0

	local function var_7_20(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		var_2_10003.StaticAlign(arg_12_0, arg_12_0:GetChild(0), 2, function(arg_13_0, arg_13_1, arg_13_2)
			UIItemList = var_3_10003

			if arg_13_0 ~= var_3_10003.EventUpdate then
				return
			end

			local var_13_0 = not arg_12_2[arg_13_1 + 1]

			setActive = var_3_10005

			var_3_10005(arg_13_2:Find("empty"), var_13_0)

			setActive = var_3_10005

			var_3_10005(arg_13_2:Find("exp"), not var_13_0)

			if var_13_0 then
				return
			end

			local var_13_1 = arg_12_1[var_3.id]
			local var_13_2 = var_3.exp

			GetImageSpriteFromAtlasAsync = var_7

			var_7("commandericon/" .. var_3:getPainting(), "", arg_13_2:Find("exp/icon"))

			setText = var_7

			var_7(arg_13_2:Find("exp/name_text"), var_3:getName())

			setText = var_7

			var_7(arg_13_2:Find("exp/lv_text"), "Lv." .. var_3.level)

			math = var_7

			local var_13_3 = var_7.max
			local var_13_4 = 0
			local var_13_5

			if not var_13_1.expAdd then
				var_13_5 = 0
			end

			local var_13_6 = var_13_3(var_13_4, var_13_5)

			setText = var_8

			var_8(arg_13_2:Find("exp/exp_text"), "+" .. var_13_6)

			local var_13_7
			local var_13_8 = var_3:isMaxLevel() and 1 or var_13_2 / var_3:getNextLevelExp()
			local var_13_9 = arg_13_2:Find("exp/exp_progress")
			local var_13_10 = var_9.GetComponent

			typeof = var_12
			Image = var_14
			var_13_10(var_13_9, var_12(var_14)).fillAmount = var_13_8

			return
		end)

		return
	end

	local function var_7_21(arg_14_0, arg_14_1, arg_14_2)
		setActive = var_2_10003

		var_2_10003(arg_14_0:Find("result/mvpBG"), arg_14_1 == arg_14_2)

		return
	end

	local function var_7_22(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		UIItemList = var_2_10004

		var_2_10004.StaticAlign(arg_15_0, arg_15_0:GetChild(0), #arg_15_1, function(arg_16_0, arg_16_1, arg_16_2)
			UIItemList = var_3_10003

			if arg_16_0 ~= var_3_10003.EventUpdate then
				return
			end

			local var_16_0 = arg_15_1[arg_16_1 + 1]
			local var_16_1 = arg_15_2[var_16_0.id]

			setActive = var_5

			var_5(arg_16_2:Find("result/Exp"), true)

			setActive = var_5

			var_5(arg_16_2:Find("result/Statistics"), false)
			var_7_21(arg_16_2, var_16_0.id, arg_15_3)

			local var_16_2 = arg_16_2
			local var_16_3 = arg_16_2.Find(var_16_2, "result/mask/icon")
			local var_16_4 = arg_16_2
			local var_16_5 = arg_16_2.Find(var_16_4, "result/type")

			GetSpriteFromAtlas = var_16_2

			local var_16_6 = "shiptype"

			shipType2print = var_10

			local var_16_7 = var_16_2(var_16_6, var_10(var_16_1:getShipType()))

			setImageSprite = var_16_4

			var_16_4(var_16_5, var_16_7, true)

			setImageSprite = var_16_4

			local var_16_8 = var_16_3

			LoadSprite = var_11

			var_16_4(var_16_8, var_11("herohrzicon/" .. var_16_1:getPainting()))

			findTF = var_16_4

			local var_16_9 = var_16_4(arg_16_2, "result/stars")

			findTF = var_16_6

			local var_16_10 = var_16_6(arg_16_2, "result/stars/star_tpl")
			local var_16_11 = var_16_1
			local var_16_12 = var_16_1.getStar(var_16_11)
			local var_16_13 = var_16_1:getMaxStar()

			UIItemList = var_16_11

			var_16_11.StaticAlign(var_16_9, var_16_10, var_16_13, function(arg_17_0, arg_17_1, arg_17_2)
				UIItemList = var_4_10003

				if arg_17_0 ~= var_4_10003.EventUpdate then
					return
				end

				local var_17_0 = var_16_13 - arg_17_1

				SetActive = var_4_10004

				var_4_10004(arg_17_2:Find("empty"), var_17_0 > var_16_12)

				SetActive = var_4_10004

				var_4_10004(arg_17_2:Find("star"), var_17_0 <= var_16_12)

				return
			end)

			setText = var_12

			var_12(arg_16_2:Find("result/Exp/Level"), "Lv." .. var_16_0.level)

			setText = var_12

			var_12(arg_16_2:Find("result/Exp/name"), var_16_0:getName())

			local var_16_14 = arg_16_2:Find("result/Exp/exp_text")
			local var_16_15 = var_16_1:getConfig("rarity")
			local var_16_16

			if var_16_1.level < var_16_0.level then
				var_16_16 = 0

				for iter_16_0 = var_16_1.level, var_16_0.level - 1 do
					getExpByRarityFromLv1 = var_3_10019
					var_16_16 = var_16_16 + var_3_10019(var_16_15, iter_16_0)
				end

				setText = var_15

				local var_16_17 = var_16_14
				local var_16_18 = "+"

				var_3_10021 = var_16_0

				var_15(var_16_17, var_16_18 .. var_16_16 + var_16_0.getExp(var_3_10021) - var_16_1:getExp())
			else
				setText = var_16_16

				local var_16_19 = var_16_14
				local var_16_20 = "+"
				local var_16_21

				if not var_16_1.expAdd then
					var_16_21 = 0
				end

				var_16_16(var_16_19, var_16_20 .. var_16_21)
			end

			local var_16_22 = arg_16_2
			local var_16_23 = arg_16_2.Find(var_16_22, "result/Progress/progress_bar")
			local var_16_24 = var_16_0:getExp()

			getExpByRarityFromLv1 = var_16_22

			local var_16_25 = var_16_24 / var_16_22(var_16_15, var_16_0.level)
			local var_16_26 = var_16_23
			local var_16_27 = var_16_23.GetComponent

			typeof = var_19
			Image = var_3_10021
			var_16_27(var_16_26, var_19(var_3_10021)).fillAmount = var_16_25

			return
		end)

		return
	end

	local function var_7_23(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
		arg_18_4 = arg_18_4 and arg_18_4.statistics

		local var_18_0 = 0

		if not arg_18_4 then
			var_18_0 = 10000
		elseif arg_18_3 == 0 then
			var_18_0 = 0
			pairs = var_2_10006

			for iter_18_0, iter_18_1 in var_2_10006(arg_18_2) do
				math = var_2_10011
				var_18_0 = var_2_10011.max(arg_18_4[iter_18_1.id].output, var_18_0)
			end
		elseif 0 < arg_18_3 then
			var_18_0 = arg_18_4[arg_18_3].output
		end

		UIItemList = var_2_10006

		var_2_10006.StaticAlign(arg_18_0, arg_18_0:GetChild(0), #arg_18_1, function(arg_19_0, arg_19_1, arg_19_2)
			UIItemList = var_3_10003

			if arg_19_0 ~= var_3_10003.EventUpdate then
				return
			end

			local var_19_0 = arg_18_1[arg_19_1 + 1]
			local var_19_1 = arg_18_2[var_19_0.id]

			setActive = var_5

			var_5(arg_19_2:Find("result/Statistics"), true)

			setActive = var_5

			var_5(arg_19_2:Find("result/Exp"), false)
			var_7_21(arg_19_2, var_19_0.id, arg_18_3)

			local var_19_2 = arg_19_2
			local var_19_3 = arg_19_2.Find(var_19_2, "result/mask/icon")
			local var_19_4 = arg_19_2
			local var_19_5 = arg_19_2.Find(var_19_4, "result/type")

			GetSpriteFromAtlas = var_19_2

			local var_19_6 = "shiptype"

			shipType2print = var_10

			local var_19_7 = var_19_2(var_19_6, var_10(var_19_1:getShipType()))

			setImageSprite = var_19_4

			var_19_4(var_19_5, var_19_7, true)

			setImageSprite = var_19_4

			local var_19_8 = var_19_3

			LoadSprite = var_11

			var_19_4(var_19_8, var_11("herohrzicon/" .. var_19_1:getPainting()))

			findTF = var_19_4

			local var_19_9 = var_19_4(arg_19_2, "result/stars")

			findTF = var_19_6

			local var_19_10 = var_19_6(arg_19_2, "result/stars/star_tpl")
			local var_19_11 = var_19_1
			local var_19_12 = var_19_1.getStar(var_19_11)
			local var_19_13 = var_19_1:getMaxStar()

			UIItemList = var_19_11

			var_19_11.StaticAlign(var_19_9, var_19_10, var_19_13, function(arg_20_0, arg_20_1, arg_20_2)
				UIItemList = var_4_10003

				if arg_20_0 ~= var_4_10003.EventUpdate then
					return
				end

				local var_20_0 = var_19_13 - arg_20_1

				SetActive = var_4_10004

				var_4_10004(arg_20_2:Find("empty"), var_20_0 > var_19_12)

				SetActive = var_4_10004

				var_4_10004(arg_20_2:Find("star"), var_20_0 <= var_19_12)

				return
			end)

			local var_19_14

			if not arg_18_4 or not arg_18_4[var_19_1.id].output then
				var_19_14 = 0
			end

			local var_19_15

			if not arg_18_4 or not arg_18_4[var_19_1.id].kill_count then
				var_19_15 = 0
			end

			local var_19_16 = arg_19_2
			local var_19_17 = arg_19_2.Find(var_19_16, "result/Statistics/atk")

			setText = var_15

			var_15(var_19_17, 0)

			setText = var_15

			var_15(var_19_17, var_19_14)

			local var_19_18 = arg_19_2:Find("result/Statistics/killCount")

			setText = var_19_16

			var_19_16(var_19_18, 0)

			setText = var_19_16

			var_19_16(var_19_18, var_19_15)

			local var_19_19 = arg_19_2:Find("result/Progress/progress_bar")
			local var_19_20 = var_16.GetComponent

			typeof = var_3_10020
			Image = var_3_10022
			var_19_20(var_19_19, var_3_10020(var_3_10022)).fillAmount = 0

			local var_19_21 = var_19_14 / var_18_0
			local var_19_22 = var_16
			local var_19_23 = var_16.GetComponent

			typeof = var_3_10021
			Image = var_3_10023
			var_19_23(var_19_22, var_3_10021(var_3_10023)).fillAmount = var_19_21

			return
		end)

		return
	end

	local function var_7_24(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		arg_21_2 = arg_21_2 and arg_21_2.statistics

		local var_21_0 = arg_21_0:Find("Title/Label")
		local var_21_1 = arg_21_0:Find("Title/Letter")
		local var_21_2 = {
			"d",
			"c",
			"b",
			"a",
			"s"
		}
		local var_21_3
		local var_21_4
		local var_21_5
		local var_21_6
		local var_21_7

		if arg_21_2 then
			local var_21_8 = var_21_2[arg_21_2._battleScore + 1]

			var_21_6 = "letter_" .. var_21_8
			var_21_4 = "battlescore/battle_score_" .. var_21_8 .. "/letter_" .. var_21_8
			var_21_7 = "label_" .. var_21_8
			var_21_5 = "battlescore/battle_score_" .. var_21_8 .. "/label_" .. var_21_8

			local var_21_9 = arg_21_2._scoreMark

			ys = var_14

			if var_21_9 == var_14.Battle.BattleConst.DEAD_FLAG then
				var_21_7 = "label_flag_destroy"
				var_21_5 = "battlescore/battle_score_c/label_flag_destroy"
			end
		else
			var_21_6 = ""
			var_21_7 = "label_none"
			var_21_5 = "battlescore/grade_label_none"
		end

		eachChild = var_2_10012

		var_2_10012(var_21_0, function(arg_22_0)
			setActive = var_3_10001

			var_3_10001(arg_22_0, arg_22_0.name == var_21_7)

			if arg_22_0.name == var_21_7 then
				local var_22_0 = arg_7_0.loader

				var_1.GetSprite(var_22_0, var_21_5, "", arg_22_0)
			end

			return
		end)

		eachChild = var_2_10012

		var_2_10012(var_21_1, function(arg_23_0)
			setActive = var_3_10001

			var_3_10001(arg_23_0, arg_23_0.name == var_21_6)

			if arg_23_0.name == var_21_6 then
				local var_23_0 = arg_7_0.loader

				var_1.GetSprite(var_23_0, var_21_4, "", arg_23_0)
			end

			return
		end)

		local var_21_10 = 0

		if not arg_21_2 then
			var_21_10 = 3
		else
			local var_21_11 = arg_21_2._battleScore

			ys = var_14
			var_21_10 = var_21_11 > var_14.Battle.BattleConst.BattleScore.C and 1 or 2
		end

		local var_21_12 = var_0_2[var_21_10]
		local var_21_13 = arg_7_0.loader
		local var_21_14 = var_14.GetSprite
		local var_21_15 = arg_7_0

		var_21_14(var_21_13, var_17.GetAtalsName(var_21_15), var_21_12, arg_21_0:Find("Title"))

		local var_21_16 = var_0_3[var_21_10]

		setImageColor = var_15

		local var_21_17 = arg_21_0:Find("BG")

		SummerFeastScene = var_18

		var_15(var_21_17, var_18.TransformColor(var_21_16))

		pg = var_15

		local var_21_18 = var_15.expedition_data_template[var_7_3[arg_21_3]]

		setText = var_16

		var_16(arg_21_0:Find("Title/Name"), var_21_18.name)

		setText = var_16

		local var_21_19 = arg_21_0:Find("BG/FleetName/Text")

		i18n = var_19

		local var_21_20 = "series_enemy_fleet_prefix"

		GetRomanDigit = var_22

		var_16(var_21_19, var_19(var_21_20, var_22(arg_21_1.index)))
		var_7_20(arg_21_0:Find("BG/commanderExp/commander_container"), arg_21_1.oldCmds, arg_21_1.cmds)

		return
	end

	local function var_7_25()
		local var_24_0

		if not (var_7_19 == 1) or not var_7_12 then
			var_24_0 = var_7_11
		end

		UIItemList = var_2_10002

		local var_24_1 = var_2_10002.StaticAlign
		local var_24_2 = arg_7_0.resultList
		local var_24_3 = arg_7_0.resultList

		var_24_1(var_24_2, var_5.GetChild(var_24_3, 0), #var_24_0, function(arg_25_0, arg_25_1, arg_25_2)
			UIItemList = var_3_10003

			if arg_25_0 ~= var_3_10003.EventUpdate then
				return
			end

			local var_25_0 = var_24_0[arg_25_1 + 1]
			local var_25_1 = var_7_1[var_25_0.index]

			var_7_24(arg_25_2, var_25_0, var_25_1, var_25_0.index)
			var_7_22(arg_25_2:Find("BG/Ships"), var_25_0.ships, var_25_0.oldShips, var_25_0.mvp)

			return
		end)

		return
	end

	local function var_7_26()
		local var_26_0

		if not (var_7_19 == 1) or not var_7_12 then
			var_26_0 = var_7_11
		end

		UIItemList = var_2_10002

		local var_26_1 = var_2_10002.StaticAlign
		local var_26_2 = arg_7_0.resultList
		local var_26_3 = arg_7_0.resultList

		var_26_1(var_26_2, var_5.GetChild(var_26_3, 0), #var_26_0, function(arg_27_0, arg_27_1, arg_27_2)
			UIItemList = var_3_10003

			if arg_27_0 ~= var_3_10003.EventUpdate then
				return
			end

			local var_27_0 = var_26_0[arg_27_1 + 1]
			local var_27_1 = var_7_1[var_27_0.index]

			var_7_24(arg_27_2, var_27_0, var_27_1, var_27_0.index)
			var_7_23(arg_27_2:Find("BG/Ships"), var_27_0.ships, var_27_0.oldShips, var_27_0.mvp, var_27_1)

			return
		end)

		return
	end

	local var_7_27 = arg_7_0.rightBottomPanel
	local var_7_28 = var_22.Find(var_7_27, "submarine")
	local var_7_29 = arg_7_0.rightBottomPanel
	local var_7_30 = var_23.Find(var_7_29, "main")

	setActive = var_7_27

	var_7_27(var_7_28, #var_7_12 > 0)
	;(function()
		setActive = var_2_10000

		var_2_10000(var_7_30, var_7_19 == 1)

		setActive = var_2_10000

		var_2_10000(var_7_28, var_7_19 == 0 and #var_7_12 > 0)

		if var_7_18 == 0 then
			var_7_25()
		elseif var_7_18 == 1 then
			var_7_26()
		end

		return
	end)()
	;(function()
		getProxy = var_2_10000
		PlayerProxy = var_2_10002

		local var_29_0 = var_2_10000(var_2_10002)
		local var_29_1 = var_0.getRawData(var_29_0)

		_ = var_2_10001

		local var_29_2 = var_2_10001.reduce(var_7_2, 0, function(arg_30_0, arg_30_1)
			return arg_30_0 + arg_30_1.playerExp.addExp
		end)

		setText = var_29_0

		local var_29_3 = arg_7_0._tf

		var_29_0(var_4.Find(var_29_3, "main/Series/playerExp/name_text"), var_29_1.name)

		setText = var_29_0

		local var_29_4 = arg_7_0._tf

		var_29_0(var_4.Find(var_29_4, "main/Series/playerExp/lv_text"), "Lv." .. var_29_1.level)

		setText = var_29_0

		local var_29_5 = arg_7_0._tf

		var_29_0(var_4.Find(var_29_5, "main/Series/playerExp/exp_text"), "+" .. var_29_2)

		local var_29_6 = arg_7_0._tf
		local var_29_7 = var_2.Find(var_29_6, "main/Series/playerExp/exp_progress")

		getConfigFromLevel1 = var_3
		pg = var_5

		local var_29_8 = var_3(var_5.user_level, var_29_1.level)
		local var_29_9 = var_29_7
		local var_29_10 = var_29_7.GetComponent

		typeof = var_7
		Image = var_2_10009
		var_29_10(var_29_9, var_7(var_2_10009)).fillAmount = var_29_1.exp / var_29_8.exp_interval

		return
	end)()

	onButton = var_26

	local var_7_31 = arg_7_0
	local var_7_32 = arg_7_0.rightBottomPanel
	local var_7_33 = var_29.Find(var_7_32, "statisticsBtn")

	local function var_7_34()
		var_7_18 = 1 - var_7_18

		var_0()

		return
	end

	SFX_PANEL = var_7_32

	var_26(var_7_31, var_7_33, var_7_34, var_7_32)

	onButton = var_26

	local var_7_35 = arg_7_0
	local var_7_36 = var_7_28

	local function var_7_37()
		var_7_19 = 1

		var_0()

		return
	end

	SFX_PANEL = var_7_32

	var_26(var_7_35, var_7_36, var_7_37, var_7_32)

	onButton = var_26

	local var_7_38 = arg_7_0
	local var_7_39 = var_7_30

	local function var_7_40()
		var_7_19 = 0

		var_0()

		return
	end

	SFX_PANEL = var_7_32

	var_26(var_7_38, var_7_39, var_7_40, var_7_32)

	onButton = var_26

	local var_7_41 = arg_7_0
	local var_7_42 = arg_7_0.rightBottomPanel
	local var_7_43 = var_29.Find(var_7_42, "confirmBtn")

	local function var_7_44()
		local var_34_0 = arg_7_0
		local var_34_1 = var_0.emit

		BossRushBattleResultMediator = var_2_10003

		var_34_1(var_34_0, var_2_10003.ON_SETTLE)

		return
	end

	SFX_PANEL = var_7_42

	var_26(var_7_41, var_7_43, var_7_44, var_7_42)

	local var_7_45 = arg_7_0._tf
	local var_7_46 = var_26.Find(var_7_45, "main/Series/ArrowLeft")
	local var_7_47 = arg_7_0._tf
	local var_7_48 = var_27.Find(var_7_47, "main/Series/ArrowRight")

	Canvas = var_7_45

	var_7_45.ForceUpdateCanvases()

	if arg_7_0.resultScroll.rect.width >= arg_7_0.resultList.rect.width then
		setActive = var_30

		var_30(var_7_46, false)

		setActive = var_30

		var_30(var_7_48, false)
	else
		setActive = var_30

		var_30(var_7_46, false)

		setActive = var_30

		var_30(var_7_48, true)

		onScroll = var_30

		var_30(arg_7_0, arg_7_0.resultScroll, function(arg_35_0)
			setActive = var_2_10001

			var_2_10001(var_7_46, arg_35_0.x > 0.01)

			setActive = var_2_10001

			var_2_10001(var_7_48, arg_35_0.x < 0.99)

			return
		end)
	end

	return
end

function var_0_1.HideConfirmPanel(arg_36_0)
	setActive = var_1_10001

	local var_36_0 = arg_36_0.rightBottomPanel

	var_1_10001(var_3.Find(var_36_0, "confirmBtn"), false)

	return
end

function var_0_1.onBackPressed(arg_37_0)
	triggerButton = var_1_10001

	local var_37_0 = arg_37_0.rightBottomPanel

	var_1_10001(var_3.Find(var_37_0, "confirmBtn"))

	return
end

function var_0_1.willExit(arg_38_0)
	arg_38_0:UnOverlayPanel(arg_38_0._tf)

	local var_38_0 = arg_38_0.loader

	var_1.Clear(var_38_0)

	if arg_38_0.contextData.OnClose then
		arg_38_0.contextData.OnClose()
	end

	return
end

return var_0_1
