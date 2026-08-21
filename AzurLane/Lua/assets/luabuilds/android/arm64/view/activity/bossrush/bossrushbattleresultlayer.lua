local var_0_0 = class("BossRushBattleResultLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "BattleResultBossRushUI"
end

function var_0_0.getGroupName(arg_2_0)
	return "BattleScene"
end

function var_0_0.Ctor(arg_3_0, ...)
	var_0_0.super.Ctor(arg_3_0, ...)

	arg_3_0.loader = AutoLoader.New()

	return
end

function var_0_0.GetAtalsName(arg_4_0)
	return "ui/battleresult_atlas"
end

function var_0_0.preload(arg_5_0, arg_5_1)
	arg_5_0.loader:LoadBundle(arg_5_0:GetAtalsName())
	existCall(arg_5_1)

	return
end

function var_0_0.init(arg_6_0)
	local var_6_0 = arg_6_0._tf:Find("main/Series")

	arg_6_0.resultScroll = var_6_0:Find("Scroll")
	arg_6_0.resultList = var_6_0:Find("Scroll/List")
	arg_6_0.playerExp = var_6_0:Find("playerExp")
	arg_6_0.rightBottomPanel = var_6_0:Find("rightBottomPanel")

	setText(arg_6_0.rightBottomPanel:Find("confirmBtn/Text"), i18n("text_confirm"))
	setText(arg_6_0.resultList:Find("Result/BG/Ships/resulttpl/result/Statistics/kill_count_label"), i18n("battle_result_kill_count"))
	setText(arg_6_0.resultList:Find("Result/BG/Ships/resulttpl/result/Statistics/dmg_count_label"), i18n("battle_result_dmg"))
	setText(arg_6_0.resultList:Find("Result/BG/commanderExp/commander_container"):GetChild(0):Find("empty/add/Text"), i18n("series_enemy_empty_commander_main"))
	setText(arg_6_0.resultList:Find("Result/BG/commanderExp/commander_container"):GetChild(1):Find("empty/add/Text"), i18n("series_enemy_empty_commander_assistant"))

	return
end

local var_0_1 = {
	"sucess_title_bg",
	"fail_title_bg",
	"none_title_bg"
}
local var_0_2 = {
	"1216207f",
	"48160d7f",
	"3c3c3c7f"
}

function var_0_0.didEnter(arg_7_0)
	arg_7_0:BlurPanel(arg_7_0._tf, {
		staticBlur = true,
		lockGlobalBlur = true
	})

	local var_7_0 = arg_7_0.contextData.seriesData:GetBattleStatistics()
	local var_7_1 = arg_7_0.contextData.seriesData:GetFinalResults()
	local var_7_2 = arg_7_0.contextData.seriesData:GetExpeditionIds()
	local var_7_3, var_7_4 = arg_7_0.contextData.seriesData:GetModeFleetIDs(arg_7_0.contextData.seriesData:GetMode())
	local var_7_5 = arg_7_0.contextData.seriesData:GetFleets(var_7_3)
	local var_7_6 = arg_7_0.contextData.seriesData:GetFleets(var_7_4)[1]
	local var_7_7 = var_7_6:getTeamByName(TeamType.Submarine)
	local var_7_8 = var_7_6:GetRawCommanderIds()
	local var_7_9 = {}
	local var_7_10 = {}

	for iter_7_0 = 1, #arg_7_0.contextData.seriesData:GetExpeditionIds() do
		local var_7_12 = var_7_1[iter_7_0]
		local var_7_13 = {
			index = iter_7_0,
			oldShips = {},
			ships = {},
			oldCmds = {},
			cmds = {}
		}

		if var_7_1[iter_7_0] then
			var_7_13.mvp = var_7_12.mvp or 0

			local var_7_14 = Clone(var_7_13)

			table.Foreach(var_7_11:getShipIds(), function(arg_8_0, arg_8_1)
				if iter_7_0 <= #var_7_1 then
					if var_7_12.newShips[arg_8_1] then
						table.insert(var_7_13.ships, var_7_12.newShips[arg_8_1])

						var_7_13.oldShips[arg_8_1] = var_7_12.oldShips[arg_8_1]
					end
				else
					local var_8_0 = getProxy(BayProxy):getShipById(arg_8_1)

					table.insert(var_7_13.ships, var_8_0)

					var_7_13.oldShips[arg_8_1] = var_8_0
				end

				return
			end)
			table.Foreach(var_7_7, function(arg_9_0, arg_9_1)
				if iter_7_0 <= #var_7_1 then
					if var_7_12.newShips[arg_9_1] then
						table.insert(var_7_14.ships, var_7_12.newShips[arg_9_1])

						var_7_14.oldShips[arg_9_1] = var_7_12.oldShips[arg_9_1]
					end
				end

				return
			end)

			local var_7_15 = var_7_11:GetRawCommanderIds()

			_.each({
				1,
				2
			}, function(arg_10_0)
				local var_10_0 = var_7_15[arg_10_0] or false

				if var_10_0 then
					if iter_7_0 <= #var_7_1 then
						if var_7_12.newCmds[var_10_0] then
							table.insert(var_7_13.cmds, var_7_12.newCmds[var_10_0])

							var_7_13.oldCmds[var_10_0] = var_7_12.oldCmds[var_10_0]
						end
					else
						local var_10_1 = getProxy(CommanderProxy):getCommanderById(var_10_0)

						table.insert(var_7_13.cmds, var_10_1)

						var_7_13.oldCmds[var_10_0] = var_10_1
					end
				else
					table.insert(var_7_13.cmds, false)
				end

				return
			end)
			_.each({
				1,
				2
			}, function(arg_11_0)
				local var_11_0 = var_7_8[arg_11_0] or false

				if iter_7_0 <= #var_7_1 then
					if var_11_0 then
						if var_7_12.newCmds[var_11_0] then
							table.insert(var_7_14.cmds, var_7_12.newCmds[var_11_0])

							var_7_14.oldCmds[var_7_12.newCmds[var_11_0].id] = var_7_12.oldCmds[var_11_0]
						else
							table.insert(var_7_14.cmds, false)
						end
					else
						table.insert(var_7_14.cmds, false)
					end
				end

				return
			end)

			var_7_9[iter_7_0] = var_7_13

			if next(var_7_14.ships) then
				table.insert(var_7_10, var_7_14)
			end
		end
	end

	local var_7_16 = 0
	local var_7_17 = 0

	local function var_7_18(arg_12_0, arg_12_1, arg_12_2)
		UIItemList.StaticAlign(arg_12_0, arg_12_0:GetChild(0), 2, function(arg_13_0, arg_13_1, arg_13_2)
			if arg_13_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_13_0 = arg_12_2[arg_13_1 + 1]

			setActive(arg_13_2:Find("empty"), not arg_12_2[arg_13_1 + 1])
			setActive(arg_13_2:Find("exp"), not not arg_12_2[arg_13_1 + 1])

			if not arg_12_2[arg_13_1 + 1] then
				return
			end

			local var_13_1 = arg_12_1[var_13_0.id]
			local var_13_2 = var_13_0.exp

			GetImageSpriteFromAtlasAsync("commandericon/" .. var_13_0:getPainting(), "", arg_13_2:Find("exp/icon"))
			setText(arg_13_2:Find("exp/name_text"), var_13_0:getName())
			setText(arg_13_2:Find("exp/lv_text"), "Lv." .. var_13_0.level)

			local var_13_3 = var_13_1.expAdd or 0

			setText(arg_13_2:Find("exp/exp_text"), "+" .. math.max(0, var_13_3))

			local var_13_5 = arg_13_2:Find("exp/exp_progress")

			var_13_5:GetComponent(typeof(Image)).fillAmount = var_13_0:isMaxLevel() and 1 or var_13_2 / var_13_0:getNextLevelExp()

			return
		end)

		return
	end

	local function var_7_19(arg_14_0, arg_14_1, arg_14_2)
		setActive(arg_14_0:Find("result/mvpBG"), arg_14_1 == arg_14_2)

		return
	end

	local function var_7_20(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		UIItemList.StaticAlign(arg_15_0, arg_15_0:GetChild(0), #arg_15_1, function(arg_16_0, arg_16_1, arg_16_2)
			if arg_16_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_16_0 = arg_15_1[arg_16_1 + 1]

			setActive(arg_16_2:Find("result/Exp"), true)
			setActive(arg_16_2:Find("result/Statistics"), false)
			var_7_19(arg_16_2, var_16_0.id, arg_15_3)
			setImageSprite(arg_16_2:Find("result/type"), GetSpriteFromAtlas("shiptype", shipType2print(arg_15_2[arg_15_1[arg_16_1 + 1].id]:getShipType())), true)
			setImageSprite(arg_16_2:Find("result/mask/icon"), LoadSprite("herohrzicon/" .. arg_15_2[arg_15_1[arg_16_1 + 1].id]:getPainting()))

			local var_16_1 = arg_15_2[arg_15_1[arg_16_1 + 1].id]:getStar()

			UIItemList.StaticAlign(findTF(arg_16_2, "result/stars"), findTF(arg_16_2, "result/stars/star_tpl"), arg_15_2[arg_15_1[arg_16_1 + 1].id]:getMaxStar(), function(arg_17_0, arg_17_1, arg_17_2)
				if arg_17_0 ~= UIItemList.EventUpdate then
					return
				end

				local var_17_0 = var_0 - arg_17_1

				SetActive(arg_17_2:Find("empty"), var_0 - arg_17_1 > var_16_1)
				SetActive(arg_17_2:Find("star"), var_17_0 <= var_16_1)

				return
			end)
			setText(arg_16_2:Find("result/Exp/Level"), "Lv." .. var_16_0.level)
			setText(arg_16_2:Find("result/Exp/name"), var_16_0:getName())

			local var_16_2 = arg_16_2:Find("result/Exp/exp_text")
			local var_16_3 = arg_15_2[arg_15_1[arg_16_1 + 1].id]:getConfig("rarity")

			if arg_15_2[arg_15_1[arg_16_1 + 1].id].level < var_16_0.level then
				local var_16_4 = 0

				for iter_16_0 = arg_15_2[arg_15_1[arg_16_1 + 1].id].level, var_16_0.level - 1 do
					var_16_4 = var_16_4 + getExpByRarityFromLv1(var_16_3, iter_16_0)
				end

				setText(var_16_2, "+" .. var_16_4 + var_16_0:getExp() - arg_15_2[arg_15_1[arg_16_1 + 1].id]:getExp())
			else
				local var_16_6 = arg_15_2[arg_15_1[arg_16_1 + 1].id].expAdd or 0

				var_16_5(var_16_2, "+" .. var_16_6)
			end

			local var_16_7 = arg_16_2:Find("result/Progress/progress_bar")

			var_16_7:GetComponent(typeof(Image)).fillAmount = var_16_0:getExp() / getExpByRarityFromLv1(var_16_3, var_16_0.level)

			return
		end)

		return
	end

	local function var_7_21(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
		arg_18_4 = arg_18_4 and arg_18_4.statistics

		local var_18_0 = 0

		if not arg_18_4 then
			var_18_0 = 10000
		elseif arg_18_3 == 0 then
			var_18_0 = 0

			for iter_18_0, iter_18_1 in pairs(arg_18_2) do
				var_18_0 = math.max(arg_18_4[iter_18_1.id].output, 0)
			end
		elseif arg_18_3 > 0 then
			var_18_0 = arg_18_4[arg_18_3].output
		end

		UIItemList.StaticAlign(arg_18_0, arg_18_0:GetChild(0), #arg_18_1, function(arg_19_0, arg_19_1, arg_19_2)
			if arg_19_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_19_0 = arg_18_1[arg_19_1 + 1]
			local var_19_1 = arg_18_2[arg_18_1[arg_19_1 + 1].id]

			setActive(arg_19_2:Find("result/Statistics"), true)
			setActive(arg_19_2:Find("result/Exp"), false)
			var_7_19(arg_19_2, var_19_0.id, arg_18_3)
			setImageSprite(arg_19_2:Find("result/type"), GetSpriteFromAtlas("shiptype", shipType2print(var_19_1:getShipType())), true)
			setImageSprite(arg_19_2:Find("result/mask/icon"), LoadSprite("herohrzicon/" .. var_19_1:getPainting()))

			local var_19_2 = var_19_1:getStar()

			UIItemList.StaticAlign(findTF(arg_19_2, "result/stars"), findTF(arg_19_2, "result/stars/star_tpl"), var_19_1:getMaxStar(), function(arg_20_0, arg_20_1, arg_20_2)
				if arg_20_0 ~= UIItemList.EventUpdate then
					return
				end

				local var_20_0 = var_0 - arg_20_1

				SetActive(arg_20_2:Find("empty"), var_0 - arg_20_1 > var_19_2)
				SetActive(arg_20_2:Find("star"), var_20_0 <= var_19_2)

				return
			end)

			if arg_18_4 then
				local var_19_3 = arg_18_4[var_19_1.id].output or 0

				if arg_18_4 then
					local var_19_4 = arg_18_4[var_19_1.id].kill_count or 0
					local var_19_5 = arg_19_2:Find("result/Statistics/atk")

					setText(var_19_5, 0)
					setText(var_19_5, var_19_3)

					local var_19_6 = arg_19_2:Find("result/Statistics/killCount")

					setText(var_19_6, 0)
					setText(var_19_6, var_19_4)

					local var_19_7 = arg_19_2:Find("result/Progress/progress_bar")

					var_19_7:GetComponent(typeof(Image)).fillAmount = 0
					var_19_7:GetComponent(typeof(Image)).fillAmount = var_19_3 / var_18_0

					return
				end
			end
		end)

		return
	end

	local function var_7_22(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		arg_21_2 = arg_21_2 and arg_21_2.statistics

		local var_21_0 = arg_21_0:Find("Title/Label")
		local var_21_1 = arg_21_0:Find("Title/Letter")
		local var_21_3
		local var_21_4
		local var_21_5
		local var_21_6

		if arg_21_2 then
			var_21_5 = "letter_" .. ({
				"d",
				"c",
				"b",
				"a",
				"s"
			})[arg_21_2._battleScore + 1]
			var_21_3 = "battlescore/battle_score_" .. ({
				"d",
				"c",
				"b",
				"a",
				"s"
			})[arg_21_2._battleScore + 1] .. "/letter_" .. ({
				"d",
				"c",
				"b",
				"a",
				"s"
			})[arg_21_2._battleScore + 1]
			var_21_6 = "label_" .. ({
				"d",
				"c",
				"b",
				"a",
				"s"
			})[arg_21_2._battleScore + 1]
			var_21_4 = "battlescore/battle_score_" .. ({
				"d",
				"c",
				"b",
				"a",
				"s"
			})[arg_21_2._battleScore + 1] .. "/label_" .. ({
				"d",
				"c",
				"b",
				"a",
				"s"
			})[arg_21_2._battleScore + 1]

			if arg_21_2._scoreMark == ys.Battle.BattleConst.DEAD_FLAG then
				var_21_6 = "label_flag_destroy"
				var_21_4 = "battlescore/battle_score_c/label_flag_destroy"
			end
		else
			var_21_5 = ""
			var_21_6 = "label_none"
			var_21_4 = "battlescore/grade_label_none"
		end

		eachChild(var_21_0, function(arg_22_0)
			setActive(arg_22_0, arg_22_0.name == var_21_6)

			if arg_22_0.name == var_21_6 then
				arg_7_0.loader:GetSprite(var_21_4, "", arg_22_0)
			end

			return
		end)
		eachChild(var_21_1, function(arg_23_0)
			setActive(arg_23_0, arg_23_0.name == var_21_5)

			if arg_23_0.name == var_21_5 then
				arg_7_0.loader:GetSprite(var_21_3, "", arg_23_0)
			end

			return
		end)
		arg_7_0.loader:GetSprite(arg_7_0:GetAtalsName(), var_0_1[not arg_21_2 and 3 or arg_21_2._battleScore > ys.Battle.BattleConst.BattleScore.C and 1 or 2], arg_21_0:Find("Title"))
		setImageColor(arg_21_0:Find("BG"), SummerFeastScene.TransformColor(var_0_2[var_21_8]))
		setText(arg_21_0:Find("Title/Name"), pg.expedition_data_template[var_7_2[arg_21_3]].name)
		setText(arg_21_0:Find("BG/FleetName/Text"), i18n("series_enemy_fleet_prefix", GetRomanDigit(arg_21_1.index)))
		var_7_18(arg_21_0:Find("BG/commanderExp/commander_container"), arg_21_1.oldCmds, arg_21_1.cmds)

		return
	end

	local function var_7_23()
		if var_7_17 == 1 then
			local var_24_0 = var_7_10 or var_7_9

			UIItemList.StaticAlign(arg_7_0.resultList, arg_7_0.resultList:GetChild(0), #var_24_0, function(arg_25_0, arg_25_1, arg_25_2)
				if arg_25_0 ~= UIItemList.EventUpdate then
					return
				end

				local var_25_0 = var_24_0[arg_25_1 + 1]

				var_7_22(arg_25_2, var_24_0[arg_25_1 + 1], var_7_0[var_24_0[arg_25_1 + 1].index], var_24_0[arg_25_1 + 1].index)
				var_7_20(arg_25_2:Find("BG/Ships"), var_25_0.ships, var_25_0.oldShips, var_25_0.mvp)

				return
			end)

			return
		end
	end

	local function var_7_24()
		if var_7_17 == 1 then
			local var_26_0 = var_7_10 or var_7_9

			UIItemList.StaticAlign(arg_7_0.resultList, arg_7_0.resultList:GetChild(0), #var_26_0, function(arg_27_0, arg_27_1, arg_27_2)
				if arg_27_0 ~= UIItemList.EventUpdate then
					return
				end

				local var_27_0 = var_26_0[arg_27_1 + 1]

				var_7_22(arg_27_2, var_26_0[arg_27_1 + 1], var_7_0[var_26_0[arg_27_1 + 1].index], var_26_0[arg_27_1 + 1].index)
				var_7_21(arg_27_2:Find("BG/Ships"), var_27_0.ships, var_27_0.oldShips, var_27_0.mvp, var_7_0[var_26_0[arg_27_1 + 1].index])

				return
			end)

			return
		end
	end

	local var_7_25 = arg_7_0.rightBottomPanel:Find("submarine")
	local var_7_26 = arg_7_0.rightBottomPanel:Find("main")

	setActive(var_7_25, #var_7_10 > 0)
	;(function()
		setActive(var_7_26, var_7_17 == 1)
		setActive(var_7_25, var_7_17 == 0 and #var_7_10 > 0)

		if var_7_16 == 0 then
			var_7_23()
		elseif var_7_16 == 1 then
			var_7_24()
		end

		return
	end)()
	;(function()
		local var_29_0 = getProxy(PlayerProxy):getRawData()

		setText(arg_7_0._tf:Find("main/Series/playerExp/name_text"), var_29_0.name)
		setText(arg_7_0._tf:Find("main/Series/playerExp/lv_text"), "Lv." .. var_29_0.level)
		setText(arg_7_0._tf:Find("main/Series/playerExp/exp_text"), "+" .. _.reduce(var_7_1, 0, function(arg_30_0, arg_30_1)
			return arg_30_0 + arg_30_1.playerExp.addExp
		end))

		arg_7_0._tf:Find("main/Series/playerExp/exp_progress"):GetComponent(typeof(Image)).fillAmount = var_29_0.exp / getConfigFromLevel1(pg.user_level, var_29_0.level).exp_interval

		return
	end)()
	onButton(arg_7_0, arg_7_0.rightBottomPanel:Find("statisticsBtn"), function()
		var_7_16 = 1 - var_7_16

		var_0()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, var_7_25, function()
		var_7_17 = 1

		var_0()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, var_7_26, function()
		var_7_17 = 0

		var_0()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.rightBottomPanel:Find("confirmBtn"), function()
		arg_7_0:emit(BossRushBattleResultMediator.ON_SETTLE)

		return
	end, SFX_PANEL)

	local var_7_27 = arg_7_0._tf:Find("main/Series/ArrowLeft")
	local var_7_28 = arg_7_0._tf:Find("main/Series/ArrowRight")

	Canvas.ForceUpdateCanvases()

	if arg_7_0.resultScroll.rect.width >= arg_7_0.resultList.rect.width then
		setActive(var_7_27, false)
		setActive(var_7_28, false)
	else
		setActive(var_7_27, false)
		setActive(var_7_28, true)
		onScroll(arg_7_0, arg_7_0.resultScroll, function(arg_35_0)
			setActive(var_7_27, arg_35_0.x > 0.01)
			setActive(var_7_28, arg_35_0.x < 0.99)

			return
		end)
	end

	return
end

function var_0_0.HideConfirmPanel(arg_36_0)
	setActive(arg_36_0.rightBottomPanel:Find("confirmBtn"), false)

	return
end

function var_0_0.onBackPressed(arg_37_0)
	triggerButton(arg_37_0.rightBottomPanel:Find("confirmBtn"))

	return
end

function var_0_0.willExit(arg_38_0)
	arg_38_0:UnOverlayPanel(arg_38_0._tf)
	arg_38_0.loader:Clear()

	if arg_38_0.contextData.OnClose then
		arg_38_0.contextData.OnClose()
	end

	return
end

return var_0_0
