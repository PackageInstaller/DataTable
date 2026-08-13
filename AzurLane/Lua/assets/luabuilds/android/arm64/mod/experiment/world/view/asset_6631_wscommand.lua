class = var_0_10000

local var_0_0 = "WSCommand"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".WSBaseCommand"))
local var_0_2

function var_0_1.Bind(arg_1_0)
	var_0_2 = arg_1_0

	return
end

function var_0_1.Unbind()
	var_0_2 = nil

	return
end

function var_0_1.OpCall(arg_3_0, arg_3_1)
	arg_3_1(function()
		local var_4_0 = arg_3_0

		var_0.OpDone(var_4_0)

		return
	end)

	return
end

function var_0_1.OpSwitchMap(arg_5_0, arg_5_1, arg_5_2)
	nowWorld = var_1_10003

	local var_5_0 = var_1_10003()

	defaultValue = var_1_10004
	arg_5_2 = var_1_10004(arg_5_2, function()
		local var_6_0 = arg_5_0

		var_0.OpInteractive(var_6_0)

		return
	end)

	local var_5_1 = var_5_0:GetActiveMap()
	local var_5_2 = var_0_2

	if not var_5.GetInMap(var_5_2) then
		arg_5_0:OpDone()
		arg_5_1:Apply()

		local var_5_3 = var_5_0
		local var_5_4 = var_5_0.GetActiveEntrance(var_5_3)
		local var_5_5 = var_5_0:GetActiveMap()

		World = var_5_3

		if var_5_3.ReplacementMapType(var_5_4, var_5_5) == "complete_chapter" then
			getProxy = var_7
			SettingsProxy = var_9

			local var_5_6 = var_7(var_9)

			if var_7.GetWorldFlag(var_5_6, "auto_save_area") then
				PlayerPrefs = var_7

				local var_5_7 = var_7.SetInt
				local var_5_8 = "autoBotIsAcitve"

				AutoBotCommand = var_10

				local var_5_9 = var_10.GetAutoBotMark

				SYSTEM_WORLD = var_1_10012

				var_5_7(var_5_8 .. var_5_9(var_1_10012), 1)
			end
		end

		local var_5_10 = var_5_0
		local var_5_11 = var_5_0.TriggerAutoFight

		if not var_5_0.isAutoSwitch then
			World = var_5_13

			local var_5_13

			if var_5_13.ReplacementMapType(var_5_4, var_5_5) == "complete_chapter" then
				getProxy = var_5_13
				SettingsProxy = var_12

				local var_5_12 = var_5_13(var_12)

				var_5_13 = var_5_13.GetWorldFlag(var_5_12, "auto_save_area")
			else
				var_5_13 = false
			end
		end

		if false then
			var_5_13 = true
		end

		var_5_11(var_5_10, var_5_13)
		arg_5_0:OpSetInMap(true, arg_5_2)
	elseif arg_5_1.destMapId ~= var_5_1.id or arg_5_1.destGridId ~= var_5_1.gid then
		local var_5_14 = {}

		table = var_6

		var_6.insert(var_5_14, function(arg_7_0)
			pg = var_2_10001

			local var_7_0 = var_2_10001.UIMgr.GetInstance()
			local var_7_1 = var_1.BlurCamera

			pg = var_2_10004

			var_7_1(var_7_0, var_2_10004.UIMgr.CameraOverlay, true)

			local var_7_2 = var_0_2.wsTimer
			local var_7_3 = var_1.AddInMapTimer(var_7_2, arg_7_0, 1, 1)

			var_1.Start(var_7_3)

			return
		end)

		table = var_6

		var_6.insert(var_5_14, function(arg_8_0)
			pg = var_2_10001

			local var_8_0 = var_2_10001.UIMgr.GetInstance()
			local var_8_1 = var_1.UnblurCamera

			pg = var_2_10004

			var_8_1(var_8_0, var_2_10004.UIMgr.CameraOverlay)

			local var_8_2 = var_0_2

			var_1.StopAnim(var_8_2)

			local var_8_3 = var_0_2

			var_1.HideMap(var_8_3)

			local var_8_4 = var_0_2

			var_1.HideMapUI(var_8_4)
			arg_8_0()

			return
		end)

		table = var_6

		var_6.insert(var_5_14, function(arg_9_0)
			local var_9_0 = arg_5_1

			var_1.Apply(var_9_0)

			local var_9_1 = var_5_0
			local var_9_2 = var_1.GetActiveEntrance(var_9_1)
			local var_9_3 = var_5_0
			local var_9_4 = var_2.GetActiveMap(var_9_3)

			World = var_9_1

			if var_9_1.ReplacementMapType(var_9_2, var_9_4) == "complete_chapter" then
				getProxy = var_3
				SettingsProxy = var_5

				local var_9_5 = var_3(var_5)

				if var_3.GetWorldFlag(var_9_5, "auto_save_area") then
					PlayerPrefs = var_3

					local var_9_6 = var_3.SetInt
					local var_9_7 = "autoBotIsAcitve"

					AutoBotCommand = var_6

					local var_9_8 = var_6.GetAutoBotMark

					SYSTEM_WORLD = var_2_10008

					var_9_6(var_9_7 .. var_9_8(var_2_10008), 1)
				end
			end

			local var_9_9 = var_5_0
			local var_9_10 = var_3.TriggerAutoFight

			if not var_5_0.isAutoSwitch then
				World = var_9_12

				local var_9_12

				if var_9_12.ReplacementMapType(var_9_2, var_9_4) == "complete_chapter" then
					getProxy = var_9_12
					SettingsProxy = var_8

					local var_9_11 = var_9_12(var_8)

					var_9_12 = var_9_12.GetWorldFlag(var_9_11, "auto_save_area")
				else
					var_9_12 = false
				end
			end

			if false then
				var_9_12 = true
			end

			var_9_10(var_9_9, var_9_12)

			assert = var_9_10

			var_9_10(var_9_4, "active map not exist")

			parallelAsync = var_9_10

			var_9_10({
				function(arg_10_0)
					local var_10_0 = var_0_2

					var_1.DisplayEnv(var_10_0, arg_10_0)

					return
				end,
				function(arg_11_0)
					local var_11_0 = var_0_2

					var_1.LoadMap(var_11_0, var_9_4, arg_11_0)

					return
				end
			}, arg_9_0)

			return
		end)

		table = var_6

		var_6.insert(var_5_14, function(arg_12_0)
			local var_12_0 = var_0_2

			var_1.DisplayMap(var_12_0)

			local var_12_1 = var_0_2

			var_1.DisplayMapUI(var_12_1)

			local var_12_2 = var_0_2

			var_1.UpdateMapUI(var_12_2)
			arg_12_0()

			return
		end)

		table = var_6

		var_6.insert(var_5_14, function(arg_13_0)
			local var_13_0 = var_0_2.wsTimer
			local var_13_1 = var_1.AddInMapTimer(var_13_0, arg_13_0, 0.5, 1)

			var_1.Start(var_13_1)

			return
		end)

		seriesAsync = var_6

		var_6(var_5_14, function()
			local var_14_0 = arg_5_0

			var_0.OpDone(var_14_0)

			return arg_5_2()
		end)
	else
		arg_5_0:OpDone()
		arg_5_1:Apply()

		local var_5_15 = var_0_2.wsDragProxy
		local var_5_16 = var_5.Focus
		local var_5_17 = var_0_2.wsMap

		var_5_16(var_5_15, var_8.GetFleet(var_5_17).transform.position)

		return arg_5_2()
	end

	return
end

function var_0_1.OpOpenLayer(arg_15_0, arg_15_1)
	arg_15_0:OpDone()

	local var_15_0 = var_0_2
	local var_15_1 = var_2.emit

	WorldMediator = var_1_10005

	var_15_1(var_15_0, var_1_10005.OnOpenLayer, arg_15_1)

	return
end

function var_0_1.OpOpenScene(arg_16_0, arg_16_1, ...)
	arg_16_0:OpDone()

	local var_16_0 = var_0_2
	local var_16_1 = var_2.emit

	WorldMediator = var_1_10005

	var_16_1(var_16_0, var_1_10005.OnOpenScene, arg_16_1, ...)

	return
end

function var_0_1.OpChangeScene(arg_17_0, arg_17_1, ...)
	arg_17_0:OpDone()

	local var_17_0 = var_0_2
	local var_17_1 = var_2.emit

	WorldMediator = var_1_10005

	var_17_1(var_17_0, var_1_10005.OnChangeScene, arg_17_1, ...)

	return
end

function var_0_1.OpInteractive(arg_18_0, arg_18_1)
	nowWorld = var_1_10002

	if var_1_10002().forceLock then
		return
	end

	arg_18_0:OpDone()

	if var_0_2.contextData.inShop then
		local var_18_0 = var_0_2.contextData

		var_18_0.inShop = false
		pg = var_18_0

		local var_18_1 = var_18_0.MsgboxMgr.GetInstance()
		local var_18_2 = var_3.ShowMsgBox
		local var_18_3 = {}

		i18n = var_1_10007
		var_18_3.content = var_1_10007("world_shop_init_notice")

		function var_18_3.onYes()
			local var_19_0 = var_0_2
			local var_19_1 = var_0.MoveAndOpenLayer
			local var_19_2 = {
				inMap = false
			}

			Context = var_2_10004

			local var_19_3 = var_2_10004.New
			local var_19_4 = {}

			WorldShopMediator = var_2_10007
			var_19_4.mediator = var_2_10007
			WorldShopLayer = var_2_10007
			var_19_4.viewComponent = var_2_10007
			var_19_2.context = var_19_3(var_19_4)

			var_19_1(var_19_0, var_19_2)

			return
		end

		function var_18_3.onNo()
			local var_20_0 = arg_18_0

			var_0.OpInteractive(var_20_0)

			return
		end

		var_18_2(var_18_1, var_18_3)

		return
	end

	local var_18_4 = var_2:GetRound()

	WorldConst = var_1_10004

	if var_18_4 == var_1_10004.RoundElse then
		arg_18_0:OpReqRound()

		return
	end

	local var_18_5 = var_0_2

	var_3.InteractiveMoveQueue(var_18_5)

	local var_18_6 = var_0_2

	if not var_3.GetInMap(var_18_6) then
		return
	end

	local var_18_7 = var_2
	local var_18_8 = var_2.GetActiveMap(var_18_7)
	local var_18_9 = {}

	table = var_18_7

	var_18_7.insert(var_18_9, function(arg_21_0)
		local var_21_0 = var_0
		local var_21_1 = var_1.GetTaskProxy(var_21_0)

		if var_1.getAutoSubmitTaskVO(var_21_1) then
			local var_21_2 = arg_18_0

			var_2.OpAutoSubmitTask(var_21_2, var_1)
		else
			arg_21_0()
		end

		return
	end)

	table = var_5

	var_5.insert(var_18_9, function(arg_22_0)
		local var_22_0 = var_0_2

		if var_1.CheckEventForMsg(var_22_0) then
			getProxy = var_1
			EventProxy = var_22_0

			local var_22_1

			if not var_1(var_22_0).eventForMsg.id then
				var_22_1 = 0
			end

			pg = var_22_0

			if var_22_0.collection_template[var_22_1] then
				pg = var_3

				local var_22_2

				if not var_3.collection_template[var_22_1].title then
					var_22_2 = ""
				end

				if var_0.isAutoFight then
					local var_22_3 = var_0
					local var_22_4 = var_4.AddAutoInfo
					local var_22_5 = "message"

					i18n = var_2_10008

					var_22_4(var_22_3, var_22_5, var_2_10008("autofight_entrust", var_22_2))
					arg_22_0()
				else
					local function var_22_6()
						local var_23_0 = arg_18_0

						var_0.OpInteractive(var_23_0)

						return
					end

					pg = var_2_10005

					local var_22_7 = var_2_10005.MsgboxMgr.GetInstance()
					local var_22_8 = var_5.ShowMsgBox
					local var_22_9 = {
						hideNo = true
					}

					i18n = var_2_10009
					var_22_9.content = var_2_10009("event_special_update", var_22_2)
					var_22_9.onYes = var_22_6
					var_22_9.onNo = var_22_6

					var_22_8(var_22_7, var_22_9)
				end

				var_1.eventForMsg = nil

				if false then
					arg_22_0()
				end

				return
			end
		end
	end)

	table = var_5

	var_5.insert(var_18_9, function(arg_24_0)
		pg = var_2_10001

		local var_24_0 = var_2_10001.GuildMsgBoxMgr.GetInstance()

		if var_0.isAutoFight then
			if var_24_0:GetShouldShowBattleTip() then
				var_24_0:SubmitTask(function(arg_25_0, arg_25_1, arg_25_2)
					local var_25_0 = var_0
					local var_25_1 = var_3.AddAutoInfo
					local var_25_2 = "message"

					i18n = var_3_10007

					local var_25_3 = "autofight_task"

					pg = var_3_10010

					var_25_1(var_25_0, var_25_2, var_3_10007(var_25_3, var_3_10010.task_data_template[arg_25_2].desc))

					if arg_25_1 then
						if arg_25_0 then
							local var_25_4 = var_0
							local var_25_5 = var_3.AddAutoInfo
							local var_25_6 = "message"

							i18n = var_7

							local var_25_7 = "guild_task_autoaccept_1"

							pg = var_10

							var_25_5(var_25_4, var_25_6, var_7(var_25_7, var_10.task_data_template[arg_25_2].desc))
						end

						local var_25_8 = var_24_0

						var_3.CancelShouldShowBattleTip(var_25_8)
						arg_24_0()
					else
						local var_25_9 = var_24_0

						var_3.NotificationForWorld(var_25_9, arg_24_0)
					end

					return
				end)
			else
				arg_24_0()
			end
		else
			var_24_0:NotificationForWorld(arg_24_0)
		end

		return
	end)

	table = var_5

	var_5.insert(var_18_9, function(arg_26_0)
		local var_26_0 = var_18_8.isLoss
		local var_26_1 = var_18_8

		var_26_1.isLoss = false

		if var_26_0 then
			WorldConst = var_26_1

			local var_26_3

			if var_26_1.IsRookieMap(var_18_8.id) then
				local var_26_2 = arg_18_0

				var_26_3 = var_26_3.OpStory
				WorldConst = var_2_10005

				var_26_3(var_26_2, var_2_10005.GetRookieBattleLoseStory(), true, false, false, function()
					local var_27_0 = arg_18_0

					var_0.OpKillWorld(var_27_0)

					return
				end)

				return
			else
				WorldGuider = var_26_3

				local var_26_4 = var_26_3.GetInstance()

				if var_2.PlayGuide(var_26_4, "WorldG161") then
					local var_26_5 = var_0

					var_2.TriggerAutoFight(var_26_5, false)

					local var_26_6 = arg_18_0

					var_2.OpInteractive(var_26_6)

					return
				end
			end
		end

		arg_26_0()

		return
	end)

	table = var_5

	var_5.insert(var_18_9, function(arg_28_0)
		if #var_0_2.achievedList > 0 then
			local var_28_0 = var_0_2

			var_1.ShowSubView(var_28_0, "Achievement", var_0_2.achievedList[1])
		else
			arg_28_0()
		end

		return
	end)

	table = var_5

	var_5.insert(var_18_9, function(arg_29_0)
		if #var_18_8.phaseDisplayList > 0 then
			local var_29_0 = var_0_2

			var_1.DisplayPhaseAction(var_29_0, var_18_8.phaseDisplayList)
		else
			arg_29_0()
		end

		return
	end)

	table = var_5

	var_5.insert(var_18_9, function(arg_30_0)
		local var_30_0 = var_18_8

		if var_1.CheckFleetSalvage(var_30_0) then
			local var_30_1 = arg_18_0

			var_1.OpReqCatSalvage(var_30_1)
		else
			arg_30_0()
		end

		return
	end)

	table = var_5

	var_5.insert(var_18_9, function(arg_31_0)
		local var_31_0 = var_0
		local var_31_1 = var_1.GetBossProxy(var_31_0)

		if not var_1.ShouldTipProgress(var_31_1) then
			arg_31_0()
		else
			var_1:ClearTipProgress()

			local var_31_2 = var_0

			var_2.TriggerAutoFight(var_31_2, false)

			WorldGuider = var_2

			local var_31_3 = var_2.GetInstance()

			if var_2.PlayGuide(var_31_3, "WorldG190") then
				-- block empty
			else
				pg = var_2

				local var_31_4 = var_2.MsgboxMgr.GetInstance()
				local var_31_5 = var_2.ShowMsgBox
				local var_31_6 = {}

				i18n = var_2_10006
				var_31_6.content = var_2_10006("world_boss_get_item")

				function var_31_6.onYes()
					local var_32_0 = arg_18_0
					local var_32_1 = var_0.OpOpenScene

					SCENE = var_3_10003

					var_32_1(var_32_0, var_3_10003.WORLDBOSS)

					return
				end

				function var_31_6.onNo()
					local var_33_0 = arg_18_0

					var_0.OpInteractive(var_33_0)

					return
				end

				var_31_5(var_31_4, var_31_6)
			end
		end

		return
	end)

	table = var_5

	var_5.insert(var_18_9, function(arg_34_0)
		local var_34_0 = var_18_8

		if var_1.CheckInteractive(var_34_0) then
			local var_34_1 = var_18_8
			local var_34_2 = var_2.GetFleet(var_34_1)
			local var_34_3 = var_1.type

			WorldMapAttachment = var_34_1

			if var_34_3 == var_34_1.TypeEvent then
				if var_1:RemainOpEffect() then
					local var_34_4 = arg_18_0

					var_34_3.OpEventOp(var_34_4, var_1)
				else
					local var_34_5 = arg_18_0

					var_34_3.OpEvent(var_34_5, var_34_2, var_1)
				end

				goto label_34_1
			end

			WorldMapAttachment = var_34_3

			if var_34_3.IsEnemyType(var_1.type) then
				if var_0.isAutoFight or arg_18_1 then
					local var_34_6 = var_1
					local var_34_7 = var_1.GetBattleStageId(var_34_6)

					pg = var_34_8

					local var_34_8 = var_34_8.expedition_data_template[var_34_7]

					assert = var_34_6

					var_34_6(var_34_8, "expedition_data_template not exist: " .. var_34_7)

					local var_34_9 = var_0

					if var_5.CheckSkipBattle(var_34_9) then
						local var_34_10 = arg_18_0

						var_5.OpReqSkipBattle(var_34_10, var_34_2.id)

						goto label_34_1
					end

					if not var_0.isAutoFight then
						PlayerPrefs = var_34_12

						do
							local var_34_12

							if var_34_12.GetInt("world_skip_precombat", 0) == 1 then
								local var_34_11 = var_0_2

								var_34_12 = var_34_12.emit
								WorldMediator = var_8

								var_34_12(var_34_11, var_8.OnStart, var_34_7, var_34_2, var_1)
							else
								pg = var_34_12

								local var_34_13

								if var_34_12.world_expedition_data[var_34_7] and var_5.battle_type then
									var_34_13 = var_5.battle_type ~= 0
								end

								local var_34_14 = {}

								if var_34_13 then
									WorldBossInformationMediator = var_8
									var_34_14.mediator = var_8
									WorldBossInformationLayer = var_8
									var_34_14.viewComponent = var_8
								else
									WorldPreCombatMediator = var_8
									var_34_14.mediator = var_8
									WorldPreCombatLayer = var_8
									var_34_14.viewComponent = var_8
								end

								local var_34_15 = arg_18_0
								local var_34_16 = var_8.OpOpenLayer

								Context = var_2_10011

								var_34_16(var_34_15, var_2_10011.New(var_34_14))
							end

							if false then
								arg_34_0()
							end

							goto label_34_1

							local var_34_17 = var_1.type

							WorldMapAttachment = var_34_8

							if var_34_17 == var_34_8.TypeBox then
								local var_34_18 = arg_18_0

								var_34_17.OpReqBox(var_34_18, var_34_2, var_1)
							else
								assert = var_34_17

								var_34_17(false, "invalide interactive type: " .. var_1.type)
							end

							goto label_34_1

							arg_34_0()
						end

						::label_34_1::

						return
					end
				end
			end
		end
	end)

	table = var_5

	var_5.insert(var_18_9, function(arg_35_0)
		if var_0_2.inLoopAutoFight then
			local var_35_0 = var_0_2

			var_35_0.inLoopAutoFight = false
			pg = var_35_0

			local var_35_1 = var_35_0.MsgboxMgr.GetInstance()
			local var_35_2 = var_1.ShowMsgBox
			local var_35_3 = {
				hideNo = true
			}

			i18n = var_2_10005
			var_35_3.content = var_2_10005("autofight_tip_bigworld_loop")
			var_35_3.onYes = arg_35_0
			var_35_3.onNo = arg_35_0

			var_35_2(var_35_1, var_35_3)
		else
			arg_35_0()
		end

		return
	end)

	table = var_5

	var_5.insert(var_18_9, function(arg_36_0)
		if not var_0.isAutoFight and not var_0.isAutoSwitch then
			local var_36_0 = var_0

			if var_1.HasAutoFightDrops(var_36_0) then
				local var_36_1 = arg_18_0
				local var_36_2 = var_1.OpOpenLayer

				Context = var_2_10004

				local var_36_3 = var_2_10004.New
				local var_36_4 = {}

				WorldAutoFightRewardMediator = var_2_10007
				var_36_4.mediator = var_2_10007
				WorldAutoFightRewardLayer = var_2_10007
				var_36_4.viewComponent = var_2_10007
				var_36_4.onRemoved = arg_36_0

				var_36_2(var_36_1, var_36_3(var_36_4))

				goto label_36_0
			end
		end

		arg_36_0()

		::label_36_0::

		return
	end)

	seriesAsync = var_5

	var_5(var_18_9, function()
		local var_37_0 = arg_18_0

		var_0.OpReqDiscover(var_37_0)

		return
	end)

	return
end

function var_0_1.OpReqDiscover(arg_38_0)
	nowWorld = var_1_10001

	local var_38_0 = var_1_10001()
	local var_38_1 = var_1.GetActiveMap(var_38_0)

	if #var_1.CheckDiscover(var_38_1) > 0 then
		local var_38_2 = {}
		local var_38_3 = {}

		_ = var_1_10005

		var_1_10005.each(var_2, function(arg_39_0)
			local var_39_0 = var_0
			local var_39_1 = var_1.GetCell(var_39_0, arg_39_0.row, arg_39_0.column)

			table = var_2_10002

			var_2_10002.insert(var_38_2, var_39_1)

			_ = var_2

			var_2.each(var_39_1.attachments, function(arg_40_0)
				if arg_40_0:ShouldMarkAsLurk() then
					table = var_1

					var_1.insert(var_38_3, arg_40_0)
				end

				return
			end)

			return
		end)

		local var_38_4 = var_0_2
		local var_38_5 = var_5.emit

		WorldMediator = var_8

		local var_38_6 = var_8.OnMapOp
		local var_38_7 = var_0_2
		local var_38_8 = var_9.NewMapOp
		local var_38_9 = {}

		WorldConst = var_1_10013
		var_38_9.op = var_1_10013.OpReqDiscover
		var_38_9.locations = var_2
		var_38_9.hiddenCells = var_38_2
		var_38_9.hiddenAttachments = var_38_3

		var_38_5(var_38_4, var_38_6, var_38_8(var_38_7, var_38_9))
	else
		arg_38_0:OpDone("OpReqDiscoverDone")
	end

	return
end

function var_0_1.OpReqDiscoverDone(arg_41_0, arg_41_1)
	nowWorld = var_1_10002

	local var_41_0 = var_1_10002()
	local var_41_1 = var_2.GetActiveMap(var_41_0)
	local var_41_2 = {}

	if arg_41_1 and #arg_41_1.hiddenAttachments > 0 then
		table = var_41_0

		var_41_0.insert(var_41_2, function(arg_42_0)
			local var_42_0 = arg_41_0
			local var_42_1 = var_1.OpAnim

			WorldConst = var_2_10004

			var_42_1(var_42_0, var_2_10004.AnimRadar, arg_42_0)

			return
		end)
	end

	seriesAsync = var_41_0

	var_41_0(var_41_2, function()
		if arg_41_1 then
			local var_43_0 = arg_41_1

			var_0.Apply(var_43_0)

			local var_43_1 = arg_41_0

			var_0.OpInteractive(var_43_1)
		else
			local var_43_2 = var_41_1

			if var_0.CheckMapPressing(var_43_2) then
				local var_43_3 = arg_41_0

				var_0.OpReqPressingMap(var_43_3)
			else
				local var_43_4 = var_0

				if var_0.CheckFleetMovable(var_43_4) then
					local var_43_5 = arg_41_0

					var_0.OpReadyToMove(var_43_5)
				else
					local var_43_6 = var_41_1
					local var_43_7 = var_0.GetFleet(var_43_6)
					local var_43_8 = var_41_1

					if not var_1.CheckFleetMovable(var_43_8, var_43_7) then
						local var_43_9 = var_41_1
						local var_43_10 = var_1.GetFleetTerrain(var_43_9, var_43_7)

						WorldMapCell = var_43_6

						if var_43_10 == var_43_6.TerrainWind then
							pg = var_43_10

							local var_43_11 = var_43_10.TipsMgr.GetInstance()
							local var_43_12 = var_1.ShowTips

							i18n = var_4

							var_43_12(var_43_11, var_4("world_wind_move"))
						end
					end
				end
			end
		end

		return
	end)

	return
end

function var_0_1.OpAnim(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = var_0_2

	var_3.DoAnim(var_44_0, arg_44_1, function()
		local var_45_0 = arg_44_0

		var_0.OpDone(var_45_0)
		arg_44_2()

		return
	end)

	return
end

function var_0_1.OpReadyToMove(arg_46_0)
	arg_46_0:OpDone()

	local var_46_0 = var_0_2.wsMap.map
	local var_46_1 = var_2.GetFleet(var_46_0)
	local var_46_2 = var_3.GetBuffsByTrap

	WorldBuff = var_1_10007

	local var_46_3 = #var_46_2(var_46_1, var_1_10007.TrapDisturbance)

	if 0 < var_46_3 then
		var_46_3 = var_2:GetMoveRange(var_3)
		math = var_5

		local var_46_4 = var_5.clamp

		math = var_7

		local var_46_5 = var_7.ceil

		math = var_1_10009

		if var_46_3[var_46_4(var_46_5(var_1_10009.random() * #var_46_3), 1, #var_46_3)] then
			local var_46_6 = var_0_2

			var_6.ClearMoveQueue(var_46_6)
			arg_46_0:OpReqMoveFleet(var_3, var_46_3[var_5].row, var_46_3[var_5].column)

			return
		end
	end

	nowWorld = var_46_3

	if var_46_3().isAutoFight then
		if #var_0_2.moveQueue > 0 then
			local var_46_7 = var_0_2

			var_5.DoQueueMove(var_46_7, var_3)
		else
			local var_46_8 = var_0_2

			if var_5.CheckLostMoveQueueCount(var_46_8) then
				local var_46_9 = var_0_2

				var_5.ResetLostMoveQueueCount(var_46_9, true)
				var_4:TriggerAutoFight(false)
				arg_46_0:OpInteractive()
			else
				arg_46_0:OpAutoFightSeach()
			end
		end

		return
	end

	if #var_0_2.moveQueue > 0 and var_2:CanLongMove(var_3) then
		local var_46_10 = var_0_2

		var_5.DoQueueMove(var_46_10, var_3)

		return
	end

	local var_46_11 = var_0_2

	var_5.ClearMoveQueue(var_46_11)
	var_1:UpdateRangeVisible(true)

	local var_46_12 = var_0_2.contextData.inPort
	local var_46_13 = var_0_2.contextData

	var_46_13.inPort = false

	if var_46_12 then
		checkExist = var_46_13

		if var_46_13(var_2, {
			"GetPort"
		}, {
			"IsOpen",
			{
				var_4:GetRealm(),
				var_4:GetProgress()
			}
		}) then
			arg_46_0:OpReqEnterPort()

			return
		end
	end

	local var_46_14 = var_0_2

	var_6.CheckGuideSLG(var_46_14, var_2, var_3)

	return
end

function var_0_1.OpLongMoveFleet(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	arg_47_0:OpDone()

	nowWorld = var_4

	local var_47_0 = var_4()
	local var_47_1 = var_4.GetActiveMap(var_47_0)

	if var_4:CheckFleetMovable() then
		local var_47_2 = {
			row = arg_47_1.row,
			column = arg_47_1.column
		}
		local var_47_3 = {
			row = arg_47_2,
			column = arg_47_3
		}
		local var_47_4 = var_47_1
		local var_47_5, var_47_6 = var_47_1.GetLongMoveRange(var_47_4, arg_47_1)

		_ = var_47_4

		if not var_47_4.any(var_47_5, function(arg_48_0)
			return arg_48_0.row == var_47_3.row and arg_48_0.column == var_47_3.column
		end) then
			pg = var_11

			local var_47_7 = var_11.TipsMgr.GetInstance()
			local var_47_8 = var_11.ShowTips

			i18n = var_1_10014

			var_47_8(var_47_7, var_1_10014("destination_not_in_range"))
		else
			local var_47_9 = {}
			local var_47_10 = 0
			local var_47_11

			;(function(arg_49_0, arg_49_1)
				if arg_49_0.last[arg_49_1] then
					var_0(arg_49_0.last[arg_49_1][1], arg_49_0.last[arg_49_1][2])

					var_47_10 = var_47_10 + 1
					table = var_2

					var_2.insert(var_47_9, {
						row = arg_49_0.row,
						column = arg_49_0.column,
						step = var_47_10,
						stay = arg_49_1 == 0
					})
				end

				return
			end)(var_47_6[var_47_3.row][var_47_3.column], 0)

			local var_47_12 = var_0_2

			var_14.SetMoveQueue(var_47_12, var_47_9)

			local var_47_13 = var_0_2

			var_14.DoQueueMove(var_47_13, arg_47_1)
		end
	end

	return
end

function var_0_1.OpReqMoveFleet(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	nowWorld = var_1_10004

	local var_50_0 = var_1_10004()
	local var_50_1 = var_4.GetActiveMap(var_50_0)

	if var_4:CheckFleetMovable() then
		local var_50_2 = {
			row = arg_50_1.row,
			column = arg_50_1.column
		}
		local var_50_3 = {
			row = arg_50_2,
			column = arg_50_3
		}
		local var_50_4

		if var_50_1:IsSign(var_50_3.row, var_50_3.column) then
			local var_50_5 = var_50_1
			local var_50_6

			var_50_6, var_1_10010 = var_50_1.FindPath(var_50_5, var_50_2, var_50_3)
			PathFinding = var_50_5

			if var_50_6 < var_50_5.PrioObstacle then
				var_50_4 = var_50_3
				var_50_3 = var_1_10010[#var_1_10010 - 1]
			end
		end

		local var_50_7 = var_50_1
		local var_50_8 = var_50_1.GetMoveRange(var_50_7, arg_50_1)

		_ = var_1_10010

		local var_50_10

		if var_1_10010.detect(var_50_8, function(arg_51_0)
			return arg_51_0.row == var_50_3.row and arg_51_0.column == var_50_3.column
		end) then
			var_50_7 = nil

			local var_50_9 = arg_50_1

			var_50_10 = arg_50_1.GetBuffsByTrap
			WorldBuff = var_1_10015

			local var_50_11 = #var_50_10(var_50_9, var_1_10015.TrapVortex)

			if 0 < var_50_11 then
				math = var_50_11

				local var_50_12 = var_50_11.random() * 100

				underscore = var_14

				if var_14.all(var_50_10, function(arg_52_0)
					return var_50_12 < arg_52_0:GetTrapParams()[1]
				end) then
					local var_50_13 = arg_50_1.row

					var_50_3.column = arg_50_1.column
					var_50_3.row = var_50_13
					WorldBuff = var_50_13
					var_50_7 = var_50_13.TrapVortex
				end
			end

			var_1_10015 = var_50_1

			local var_50_14, var_50_15 = var_50_1.FindPath(var_1_10015, var_50_2, var_50_3)

			PathFinding = var_1_10015

			if var_50_14 < var_1_10015.PrioObstacle then
				local var_50_16 = var_0_2

				var_1_10015 = var_1_10015.emit
				WorldMediator = var_1_10018
				var_1_10018 = var_1_10018.OnMapOp

				local var_50_17 = var_0_2
				local var_50_18 = var_19.NewMapOp
				local var_50_19 = {}

				WorldConst = var_1_10023
				var_50_19.op = var_1_10023.OpReqMoveFleet
				var_50_19.id = arg_50_1.id
				var_50_19.arg1 = var_50_3.row
				var_50_19.arg2 = var_50_3.column
				var_50_19.sign = var_50_4
				var_50_19.trap = var_50_7

				var_1_10015(var_50_16, var_1_10018, var_50_18(var_50_17, var_50_19))

				return
			else
				PathFinding = var_1_10015

				if var_50_14 < var_1_10015.PrioForbidden then
					pg = var_1_10015

					local var_50_20 = var_1_10015.TipsMgr.GetInstance()

					var_1_10015 = var_1_10015.ShowTips
					i18n = var_1_10018

					var_1_10015(var_50_20, var_1_10018("destination_can_not_reach_safety"))
				else
					pg = var_1_10015

					local var_50_21 = var_1_10015.TipsMgr.GetInstance()

					var_1_10015 = var_1_10015.ShowTips
					i18n = var_1_10018

					var_1_10015(var_50_21, var_1_10018("destination_can_not_reach"))
				end
			end
		else
			trap = var_50_7

			local var_50_22 = var_50_7 and "world_fleet_in_vortex" or "destination_not_in_range"

			pg = var_50_10

			local var_50_23 = var_50_10.TipsMgr.GetInstance()
			local var_50_24 = var_12.ShowTips

			i18n = var_1_10015

			var_50_24(var_50_23, var_1_10015(var_50_22))
		end
	end

	local var_50_25 = var_0_2

	var_6.ClearMoveQueue(var_50_25)
	arg_50_0:OpDone()

	return
end

function var_0_1.OpReqMoveFleetDone(arg_53_0, arg_53_1)
	local var_53_0 = {}
	local var_53_1 = var_0_2.wsMap.map
	local var_53_2 = var_4.GetFleet(var_53_1)

	table = var_1_10006

	var_1_10006.insert(var_53_0, function(arg_54_0)
		local var_54_0 = var_0

		var_1.UpdateRangeVisible(var_54_0, false)

		if var_53_2.row ~= arg_53_1.arg1 or var_53_2.column ~= arg_53_1.arg2 then
			local var_54_1 = var_0

			var_1.DisplayTargetArrow(var_54_1, arg_53_1.arg1, arg_53_1.arg2)
		end

		local var_54_2 = arg_53_0

		var_1.OpActions(var_54_2, arg_53_1.childOps, arg_54_0)

		return
	end)

	table = var_6

	var_6.insert(var_53_0, function(arg_55_0)
		local var_55_0 = var_0_2

		var_1.CheckMoveQueue(var_55_0, arg_53_1.path)
		arg_55_0()

		return
	end)

	if arg_53_1.sign then
		table = var_6

		var_6.insert(var_53_0, function(arg_56_0)
			local var_56_0 = var_0_2

			var_1.ClearMoveQueue(var_56_0)

			if var_53_2.row == arg_53_1.arg1 and var_53_2.column == arg_53_1.arg2 then
				local var_56_1 = var_0
				local var_56_2 = var_1.GetCell(var_56_1, arg_53_1.sign.row, arg_53_1.sign.column)
				local var_56_3 = arg_53_0

				var_2.OpTriggerSign(var_56_3, var_53_2, var_56_2:GetEventAttachment(), arg_56_0)
			else
				arg_56_0()
			end

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_53_0, function()
		local var_57_0 = var_0

		var_0.HideTargetArrow(var_57_0)

		local var_57_1 = arg_53_1

		var_0.Apply(var_57_1)

		local var_57_2 = arg_53_0

		var_0.OpInteractive(var_57_2)

		return
	end)

	return
end

function var_0_1.OpMoveFleet(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = var_0_2

	arg_58_2 = var_3.DoTopBlock(var_58_0, arg_58_2)

	local var_58_1 = var_0_2.wsMap.map
	local var_58_2 = var_4.GetFleet(var_58_1, arg_58_1.id)
	local var_58_3 = var_3:GetFleet(var_58_2).fleet
	local var_58_4 = var_3.map
	local var_58_5 = var_7.GetCell(var_58_4, var_58_3.row, var_58_3.column)
	local var_58_6 = var_3
	local var_58_7 = var_3.MovePath
	local var_58_8 = var_5
	local var_58_9 = arg_58_1.path
	local var_58_10 = arg_58_1.pos

	WorldConst = var_1_10014

	local var_58_11 = var_1_10014.DirType2
	local var_58_12 = var_58_5
	local var_58_13 = var_58_5.GetTerrain(var_58_12)

	WorldMapCell = var_1_10016

	local var_58_14 = var_58_7(var_58_6, var_58_8, var_58_9, var_58_10, var_58_11, var_58_13 == var_1_10016.TerrainWind)

	local function var_58_15(arg_59_0, arg_59_1)
		local var_59_0 = arg_58_1.stepOps[arg_59_0]

		assert = var_2_10003

		var_2_10003(var_59_0, "step op not exist: " .. arg_59_0)

		local var_59_1 = {}

		if #var_59_0.hiddenAttachments > 0 then
			table = var_4

			var_4.insert(var_59_1, function(arg_60_0)
				if arg_59_0 < #arg_58_1.stepOps then
					local var_60_0 = var_58_14

					var_1.UpdatePaused(var_60_0, true)
				end

				local var_60_1 = var_0_2
				local var_60_2 = var_1.DoAnim

				WorldConst = var_3_10004

				var_60_2(var_60_1, var_3_10004.AnimRadar, function()
					if arg_59_0 < #arg_58_1.stepOps then
						local var_61_0 = var_58_14

						var_0.UpdatePaused(var_61_0, false)
					end

					arg_60_0()

					return
				end)

				return
			end)
		end

		seriesAsync = var_4

		var_4(var_59_1, function()
			local var_62_0 = var_59_0

			var_0.Apply(var_62_0)

			existCall = var_0

			return var_0(arg_59_1)
		end)

		return
	end

	local function var_58_16(arg_63_0)
		local var_63_0 = arg_58_1.path[arg_63_0 + 1]
		local var_63_1 = var_0
		local var_63_2 = var_2.GetCell(var_63_1, var_63_0.row, var_63_0.column).transform.position
		local var_63_3 = var_0_2.wsDragProxy
		local var_63_4 = var_3.Focus
		local var_63_5 = var_63_2
		local var_63_6 = var_63_0.duration

		LeanTweenType = var_2_10008

		var_63_4(var_63_3, var_63_5, var_63_6, var_2_10008.linear)

		return
	end

	local var_58_17 = 0

	var_58_16(var_58_17)

	local function var_58_18(arg_64_0, arg_64_1)
		var_58_17 = var_58_17 + 1

		var_58_16(var_58_17)

		local var_64_0 = var_0_2.wsMapRight

		var_2.UpdateCompassRotation(var_64_0, arg_58_1.path[var_58_17 + 1])
		var_58_15(var_58_17)

		return
	end

	local var_58_19

	local function var_58_20()
		local var_65_0 = var_58_14
		local var_65_1 = var_0.RemoveListener

		WSMapPath = var_2_10003

		var_65_1(var_65_0, var_2_10003.EventArrivedStep, var_58_18)

		local var_65_2 = var_58_14
		local var_65_3 = var_0.RemoveListener

		WSMapPath = var_3

		var_65_3(var_65_2, var_3.EventArrived, var_58_20)

		var_58_17 = var_58_17 + 1

		var_58_15(var_58_17, function()
			if #arg_58_1.locations > 0 then
				local var_66_0 = var_0_2
				local var_66_1 = var_0.emit

				WorldMediator = var_3_10003

				local var_66_2 = var_3_10003.OnMapOp
				local var_66_3 = var_0_2
				local var_66_4 = var_4.NewMapOp
				local var_66_5 = {}

				WorldConst = var_3_10008
				var_66_5.op = var_3_10008.OpReqDiscover
				var_66_5.locations = arg_58_1.locations
				var_66_5.hiddenCells = {}
				var_66_5.hiddenAttachments = {}

				function var_66_5.routine(arg_67_0)
					arg_67_0:Apply()

					local var_67_0 = arg_58_0

					var_1.OpDone(var_67_0)
					arg_58_2()

					return
				end

				var_66_1(var_66_0, var_66_2, var_66_4(var_66_3, var_66_5))
			else
				local var_66_6 = arg_58_0

				var_0.OpDone(var_66_6)
				arg_58_2()
			end

			return
		end)

		return
	end

	local var_58_21 = var_58_14
	local var_58_22 = var_58_14.AddListener

	WSMapPath = var_58_12

	var_58_22(var_58_21, var_58_12.EventArrivedStep, var_58_18)

	local var_58_23 = var_58_14
	local var_58_24 = var_58_14.AddListener

	WSMapPath = var_17

	var_58_24(var_58_23, var_17.EventArrived, var_58_20)

	ipairs = var_58_24

	for iter_58_0, iter_58_1 in var_58_24(var_58_3:GetCarries()) do
		local var_58_25 = var_3:GetCarryItem(iter_58_1)
		local var_58_26 = var_58_3:BuildCarryPath(iter_58_1, arg_58_1.pos, arg_58_1.path)

		var_58_25:FollowPath(var_58_26)
	end

	local var_58_27 = var_0_2.wsMapRight

	var_14.UpdateCompassRotation(var_58_27, arg_58_1.path[1])

	return
end

function var_0_1.OpMoveAttachment(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0 = var_0_2

	arg_68_2 = var_3.DoTopBlock(var_68_0, arg_68_2)

	local var_68_1 = var_0_2.wsMap.map
	local var_68_2 = arg_68_1.attachment
	local var_68_3 = var_3:GetAttachment(var_68_2.row, var_68_2.column, var_68_2.type)

	var_3:FlushMovingAttachment(var_68_3)

	local var_68_4 = 0
	local var_68_5 = var_3:MovePath(var_68_3, arg_68_1.path, arg_68_1.pos, var_68_2:GetDirType())

	local function var_68_6(arg_69_0, arg_69_1)
		var_68_4 = var_68_4 + 1

		local var_69_0 = var_0

		var_2.FlushMovingAttachmentOrder(var_69_0, var_68_3, arg_68_1.path[var_68_4])

		return
	end

	local var_68_7

	local function var_68_8()
		local var_70_0 = var_68_5
		local var_70_1 = var_0.RemoveListener

		WSMapPath = var_2_10003

		var_70_1(var_70_0, var_2_10003.EventArrivedStep, var_68_6)

		local var_70_2 = var_68_5
		local var_70_3 = var_0.RemoveListener

		WSMapPath = var_3

		var_70_3(var_70_2, var_3.EventArrived, var_68_8)

		local var_70_4 = arg_68_0

		var_0.OpDone(var_70_4)
		arg_68_2()

		return
	end

	local var_68_9 = var_68_5
	local var_68_10 = var_68_5.AddListener

	WSMapPath = var_14

	var_68_10(var_68_9, var_14.EventArrivedStep, var_68_6)

	local var_68_11 = var_68_5
	local var_68_12 = var_68_5.AddListener

	WSMapPath = var_14

	var_68_12(var_68_11, var_14.EventArrived, var_68_8)

	return
end

function var_0_1.OpReqRound(arg_71_0)
	local var_71_0 = var_0_2
	local var_71_1 = var_1.emit

	WorldMediator = var_1_10004

	local var_71_2 = var_1_10004.OnMapOp
	local var_71_3 = var_0_2
	local var_71_4 = var_5.NewMapOp
	local var_71_5 = {}

	WorldConst = var_1_10009
	var_71_5.op = var_1_10009.OpReqRound

	var_71_1(var_71_0, var_71_2, var_71_4(var_71_3, var_71_5))

	return
end

function var_0_1.OpReqRoundDone(arg_72_0, arg_72_1)
	arg_72_0:OpActions(arg_72_1.childOps, function()
		local var_73_0 = arg_72_1

		var_0.Apply(var_73_0)

		local var_73_1 = arg_72_0

		var_0.OpInteractive(var_73_1, true)

		return
	end)

	return
end

function var_0_1.OpActions(arg_74_0, arg_74_1, arg_74_2)
	arg_74_0:OpDone()

	_ = var_3

	local var_74_0 = var_3.map(arg_74_1 or {}, function(arg_75_0)
		return function(arg_76_0)
			local var_76_0 = arg_74_0

			var_1.OpAction(var_76_0, arg_75_0, arg_76_0)

			return
		end
	end)

	seriesAsync = var_1_10004

	var_1_10004(var_74_0, arg_74_2)

	return
end

function var_0_1.OpAction(arg_77_0, arg_77_1, arg_77_2)
	local var_77_0 = arg_77_0

	arg_77_0.OpDone(var_77_0)

	local var_77_1 = {}

	if arg_77_1.childOps then
		table = var_4

		var_4.insert(var_77_1, function(arg_78_0)
			local var_78_0 = arg_77_0

			var_1.OpActions(var_78_0, arg_77_1.childOps, arg_78_0)

			return
		end)
	end

	local var_77_2 = arg_77_1.op

	WorldConst = var_77_0

	if var_77_2 == var_77_0.OpActionUpdate then
		table = var_77_2

		var_77_2.insert(var_77_1, function(arg_79_0)
			local var_79_0 = arg_77_1

			var_1.Apply(var_79_0)
			arg_79_0()

			return
		end)
	else
		var_77_2 = arg_77_1.op
		WorldConst = var_5

		if var_77_2 == var_5.OpActionFleetMove then
			table = var_77_2

			var_77_2.insert(var_77_1, function(arg_80_0)
				local var_80_0 = arg_77_0

				var_1.OpMoveFleet(var_80_0, arg_77_1, function()
					local var_81_0 = arg_77_1

					var_0.Apply(var_81_0)
					arg_80_0()

					return
				end)

				return
			end)
		else
			var_77_2 = arg_77_1.op
			WorldConst = var_5

			if var_77_2 == var_5.OpActionAttachmentMove then
				table = var_77_2

				var_77_2.insert(var_77_1, function(arg_82_0)
					local var_82_0 = arg_77_0

					var_1.OpMoveAttachment(var_82_0, arg_77_1, function()
						local var_83_0 = arg_77_1

						var_0.Apply(var_83_0)
						arg_82_0()

						return
					end)

					return
				end)
			else
				var_77_2 = arg_77_1.op
				WorldConst = var_5

				if var_77_2 == var_5.OpActionAttachmentAnim then
					table = var_77_2

					var_77_2.insert(var_77_1, function(arg_84_0)
						local var_84_0 = arg_77_0

						var_1.OpAttachmentAnim(var_84_0, arg_77_1, function()
							local var_85_0 = arg_77_1

							var_0.Apply(var_85_0)
							arg_84_0()

							return
						end)

						return
					end)
				else
					var_77_2 = arg_77_1.op
					WorldConst = var_5

					if var_77_2 == var_5.OpActionFleetAnim then
						table = var_77_2

						var_77_2.insert(var_77_1, function(arg_86_0)
							local var_86_0 = arg_77_0

							var_1.OpFleetAnim(var_86_0, arg_77_1, function()
								local var_87_0 = arg_77_1

								var_0.Apply(var_87_0)
								arg_86_0()

								return
							end)

							return
						end)
					else
						var_77_2 = arg_77_1.op
						WorldConst = var_5

						if var_77_2 == var_5.OpActionEventEffect then
							table = var_77_2

							var_77_2.insert(var_77_1, function(arg_88_0)
								local var_88_0 = arg_77_0

								var_1.OpTriggerEvent(var_88_0, arg_77_1, arg_88_0)

								return
							end)
						else
							var_77_2 = arg_77_1.op
							WorldConst = var_5

							if var_77_2 == var_5.OpActionCameraMove then
								table = var_77_2

								var_77_2.insert(var_77_1, function(arg_89_0)
									local var_89_0 = arg_77_0

									var_1.OpMoveCameraTarget(var_89_0, arg_77_1.attachment, 0.1, function()
										local var_90_0 = arg_77_1

										var_0.Apply(var_90_0)
										arg_89_0()

										return
									end)

									return
								end)
							else
								var_77_2 = arg_77_1.op
								WorldConst = var_5

								if var_77_2 == var_5.OpActionTrapGravityAnim then
									table = var_77_2

									var_77_2.insert(var_77_1, function(arg_91_0)
										local var_91_0 = arg_77_0

										var_1.OpTrapGravityAnim(var_91_0, arg_77_1.attachment, function()
											local var_92_0 = arg_77_1

											var_0.Apply(var_92_0)
											arg_91_0()

											return
										end)

										return
									end)
								else
									assert = var_77_2

									var_77_2(false)
								end
							end
						end
					end
				end
			end
		end
	end

	seriesAsync = var_77_2

	var_77_2(var_77_1, arg_77_2)

	return
end

function var_0_1.OpEvent(arg_93_0, arg_93_1, arg_93_2)
	arg_93_0:OpDone()

	nowWorld = var_3

	local var_93_0 = var_3()
	local var_93_1
	local var_93_2
	local var_93_3 = arg_93_2:GetEventEffect().effect_type
	local var_93_4 = var_6.effect_paramater
	local var_93_5 = {}

	WorldMapAttachment = var_1_10010

	local var_93_6

	if var_93_3 == var_1_10010.EffectEventStoryOption then
		var_93_6 = var_93_4[1]

		if var_6.autoflag[1] then
			WorldConst = var_1_10012

			if var_1_10012.CheckWorldStorySkip(var_93_6) then
				table = var_1_10012

				var_1_10012.insert(var_93_5, function(arg_94_0)
					arg_94_0(var_1_10011)

					return
				end)

				goto label_93_0
			end
		end

		table = var_1_10012

		var_1_10012.insert(var_93_5, function(arg_95_0)
			local var_95_0 = arg_93_0
			local var_95_1 = var_1.OpStory
			local var_95_2 = var_93_6
			local var_95_3 = true
			local var_95_4 = true
			local var_95_5

			if not var_93_0.isAutoFight or not var_1_10011 or not {
				var_1_10011
			} then
				var_95_5 = false
			end

			var_95_1(var_95_0, var_95_2, var_95_3, var_95_4, var_95_5, arg_95_0)

			return
		end)

		::label_93_0::

		table = var_1_10012

		var_1_10012.insert(var_93_5, function(arg_96_0, arg_96_1)
			assert = var_2_10002

			var_2_10002(arg_96_1, "without option in story:" .. var_93_4[1])

			underscore = var_2_10002

			if var_2_10002.detect(var_93_4[2], function(arg_97_0)
				return arg_97_0[1] == arg_96_1
			end) then
				var_93_1 = var_2[2]

				arg_96_0()
			else
				arg_93_2.triggered = true

				local var_96_0 = arg_93_0

				var_3.OpInteractive(var_96_0)
			end

			return
		end)
	else
		WorldMapAttachment = var_93_6

		if var_93_3 == var_93_6.EffectEventConsumeItem then
			if var_93_0.isAutoFight or var_93_4[4] then
				-- block empty
			else
				table = var_93_6

				var_93_6.insert(var_93_5, function(arg_98_0)
					pg = var_2_10001

					local var_98_0 = var_2_10001.MsgboxMgr.GetInstance()
					local var_98_1 = var_1.ShowMsgBox
					local var_98_2 = {}

					MSGBOX_TYPE_ITEM_BOX = var_2_10005
					var_98_2.type = var_2_10005
					i18n = var_2_10005
					var_98_2.content = var_2_10005("sub_item_warning")

					local var_98_3 = {}
					local var_98_4 = {}

					DROP_TYPE_WORLD_ITEM = var_7
					var_98_4.type = var_7
					var_98_4.id = var_93_4[1]
					var_98_4.count = var_93_4[2]
					var_98_3[1] = var_98_4
					var_98_2.items = var_98_3
					var_98_2.onYes = arg_98_0

					function var_98_2.onNo()
						arg_93_2.triggered = true

						local var_99_0 = arg_93_0

						var_0.OpInteractive(var_99_0)

						return
					end

					var_98_1(var_98_0, var_98_2)

					return
				end)
			end

			table = var_93_6

			var_93_6.insert(var_93_5, function(arg_100_0)
				local var_100_0 = var_93_0
				local var_100_1 = var_1.GetInventoryProxy(var_100_0)

				if var_1.GetItemCount(var_100_1, var_93_4[1]) < var_93_4[2] then
					local var_100_2 = var_93_0

					var_1.TriggerAutoFight(var_100_2, false)

					arg_93_2.triggered = true

					local var_100_3 = arg_93_0

					var_1.OpStory(var_100_3, var_93_4[3], true, false, false, function()
						local var_101_0 = arg_93_0

						var_0.OpInteractive(var_101_0)

						return
					end)
				else
					arg_100_0()
				end

				return
			end)
		else
			WorldMapAttachment = var_93_6

			if var_93_3 == var_93_6.EffectEventGuide then
				table = var_93_6

				var_93_6.insert(var_93_5, function(arg_102_0)
					local var_102_0 = arg_93_2

					if var_1.IsAttachmentFinish(var_102_0) then
						arg_102_0()
					else
						local var_102_1 = arg_93_0

						var_1.OpGuide(var_102_1, var_93_4[1], var_93_4[2], function()
							arg_93_2.finishMark = arg_93_2.data

							if var_0_2 then
								local var_103_0 = arg_93_0

								var_0.OpInteractive(var_103_0)
							end

							return
						end)
					end

					return
				end)
			else
				WorldMapAttachment = var_93_6

				if var_93_3 == var_93_6.EffectEventConsumeCarry then
					if not var_6.effect_paramater[1] then
						var_93_6 = {}
					end

					_ = var_1_10011

					if var_1_10011.any(var_93_6, function(arg_104_0)
						local var_104_0 = arg_93_1

						return not var_1.ExistCarry(var_104_0, arg_104_0)
					end) then
						arg_93_2.triggered = true

						var_93_0:TriggerAutoFight(false)

						if var_6.effect_paramater[2] then
							table = var_1_10012

							var_1_10012.insert(var_93_5, function(arg_105_0)
								local var_105_0 = arg_93_0

								var_1.OpStory(var_105_0, var_1_10011, true, false, false, arg_105_0)

								return
							end)
						end

						table = var_1_10012

						var_1_10012.insert(var_93_5, function(arg_106_0)
							local var_106_0 = arg_93_0

							var_1.OpInteractive(var_106_0)

							return
						end)
					end
				else
					WorldMapAttachment = var_93_6

					if var_93_3 == var_93_6.EffectEventCatSalvage then
						if arg_93_1:GetDisplayCommander() and not arg_93_1:IsCatSalvage() then
							if not var_93_0.isAutoFight then
								table = var_93_6

								var_93_6.insert(var_93_5, function(arg_107_0)
									local var_107_0 = arg_93_0

									var_1.OpStory(var_107_0, var_93_4[1], true, true, false, function(arg_108_0)
										if arg_108_0 == var_93_4[2] then
											arg_107_0()
										else
											arg_93_2.triggered = true

											local var_108_0 = arg_93_0

											var_1.OpInteractive(var_108_0)
										end

										return
									end)

									return
								end)
							end
						else
							arg_93_2.triggered = true

							if not var_93_0.isAutoFight then
								pg = var_93_6
								var_93_6 = var_93_6.gameset.world_catsearch_failure.description[1]
								table = var_1_10011

								var_1_10011.insert(var_93_5, function(arg_109_0)
									local var_109_0 = arg_93_0

									var_1.OpStory(var_109_0, var_93_6, true, false, false, arg_109_0)

									return
								end)
							end

							table = var_93_6

							var_93_6.insert(var_93_5, function(arg_110_0)
								local var_110_0 = arg_93_0

								var_1.OpInteractive(var_110_0)

								return
							end)
						end
					else
						WorldMapAttachment = var_93_6

						if var_93_3 == var_93_6.EffectEventMsgbox then
							table = var_93_6

							var_93_6.insert(var_93_5, function(arg_111_0)
								local var_111_0 = var_93_0

								var_1.TriggerAutoFight(var_111_0, false)

								pg = var_1

								local var_111_1 = var_1.MsgboxMgr.GetInstance()
								local var_111_2 = var_1.ShowMsgBox
								local var_111_3 = {}

								i18n = var_2_10005
								var_111_3.content = var_2_10005(var_93_4[1])
								var_111_3.onYes = arg_111_0
								var_111_3.onNo = var_93_4[1] == 0 and arg_111_0 or function()
									arg_93_2.triggered = true

									local var_112_0 = arg_93_0

									var_0.OpInteractive(var_112_0)

									return
								end
								var_111_3.hideNo = var_93_4[1] == 0

								var_111_2(var_111_1, var_111_3)

								return
							end)
						else
							WorldMapAttachment = var_93_6

							if var_93_3 == var_93_6.EffectEventStoryBattle then
								table = var_93_6

								var_93_6.insert(var_93_5, function(arg_113_0)
									local var_113_0 = arg_93_2

									if var_1.IsAttachmentFinish(var_113_0) then
										arg_113_0()
									else
										local var_113_1 = var_0_2
										local var_113_2 = var_1.emit

										WorldMediator = var_2_10004

										var_113_2(var_113_1, var_2_10004.OnStartPerform, var_93_4[1], function()
											arg_93_2.finishMark = arg_93_2.data

											return
										end)
									end

									return
								end)
							end
						end
					end
				end
			end
		end
	end

	seriesAsync = var_93_6

	var_93_6(var_93_5, function()
		local var_115_0 = var_0_2
		local var_115_1 = var_0.NewMapOp
		local var_115_2 = {}

		WorldConst = var_2_10004
		var_115_2.op = var_2_10004.OpReqEvent
		var_115_2.id = arg_93_1.id
		var_115_2.arg1 = var_93_1
		var_115_2.arg2 = var_93_2
		var_115_2.attachment = arg_93_2
		var_115_2.effect = var_0
		var_115_2.locations = {
			{
				row = arg_93_2.row,
				column = arg_93_2.column
			}
		}

		local var_115_3 = var_115_1(var_115_0, var_115_2)
		local var_115_4 = arg_93_0

		var_1.OpReqEvent(var_115_4, var_115_3)

		return
	end)

	return
end

function var_0_1.OpReqEvent(arg_116_0, arg_116_1)
	local var_116_0 = var_0_2
	local var_116_1 = var_2.emit

	WorldMediator = var_1_10005

	var_116_1(var_116_0, var_1_10005.OnMapOp, arg_116_1)

	return
end

function var_0_1.OpReqEventDone(arg_117_0, arg_117_1)
	arg_117_0:OpTriggerEvent(arg_117_1, function()
		local var_118_0 = arg_117_0

		var_0.OpInteractive(var_118_0, true)

		return
	end)

	return
end

function var_0_1.OpEventOp(arg_119_0, arg_119_1)
	arg_119_0:OpDone()

	local var_119_0 = var_0_2
	local var_119_1 = var_2.NewMapOp
	local var_119_2 = {}

	WorldConst = var_1_10006
	var_119_2.op = var_1_10006.OpActionEventOp
	var_119_2.attachment = arg_119_1
	var_119_2.effect = arg_119_1:GetOpEffect()

	local var_119_3 = var_119_1(var_119_0, var_119_2)

	arg_119_0:OpTriggerEvent(var_119_3, function()
		local var_120_0 = arg_119_0

		var_0.OpInteractive(var_120_0)

		return
	end)

	return
end

function var_0_1.OpTriggerEvent(arg_121_0, arg_121_1, arg_121_2)
	arg_121_0:OpDone()

	nowWorld = var_3

	local var_121_0 = var_3()
	local var_121_1 = {}
	local var_121_2 = arg_121_1.effect.effect_type
	local var_121_3 = var_5.effect_paramater

	switch = var_1_10008

	local var_121_4 = var_121_2
	local var_121_5 = {}

	WorldMapAttachment = var_1_10012
	var_121_5[var_1_10012.EffectEventStory] = function()
		getProxy = var_2_10000
		WorldProxy = var_2_10002

		local var_122_0 = var_2_10000(var_2_10002)
		local var_122_1 = var_121_3[1]

		WorldConst = var_2_10002

		if var_2_10002.CheckWorldStorySkip(var_122_1) then
			table = var_2

			var_2.insert(var_121_1, function(arg_123_0)
				local var_123_0 = var_0_2

				var_1.ReContinueMoveQueue(var_123_0)
				arg_123_0()

				return
			end)
		else
			table = var_2

			var_2.insert(var_121_1, function(arg_124_0)
				local var_124_0 = arg_121_0
				local var_124_1 = var_1.OpStory
				local var_124_2 = var_122_1
				local var_124_3 = true
				local var_124_4 = false
				local var_124_5

				if not var_121_0.isAutoFight or not {} then
					var_124_5 = false
				end

				var_124_1(var_124_0, var_124_2, var_124_3, var_124_4, var_124_5, arg_124_0)

				return
			end)
		end

		table = var_2

		var_2.insert(var_121_1, function(arg_125_0)
			local var_125_0 = arg_121_1

			var_1.Apply(var_125_0)
			arg_125_0()

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventTeleport] = function()
		local var_126_0 = arg_121_1.attachment

		assert = var_2_10001

		if var_126_0 then
			::label_126_0::

			var_2_10003 = var_126_0.type
			WorldMapAttachment = var_2_10004
			var_2_10003 = var_2_10003 == var_2_10004.TypeEvent
		end

		var_2_10001(var_2_10003)

		local var_126_1 = var_121_0
		local var_126_2 = var_1.GetMap(var_126_1, arg_121_1.destMapId)

		if var_2[#arg_121_1.effect.effect_paramater[1]] == 1 then
			table = var_3

			var_3.insert(var_121_1, function(arg_127_0)
				local var_127_0 = var_0_2

				var_1.ShowTransportMarkOverview(var_127_0, {
					ids = {
						arg_121_1.entranceId
					}
				}, arg_127_0)

				return
			end)
		end

		local var_126_3 = var_0_2

		if var_3.GetInMap(var_126_3) and var_126_0.config.icon == "chuansong01" then
			table = var_3

			var_3.insert(var_121_1, function(arg_128_0)
				local var_128_0 = arg_121_0
				local var_128_1 = var_1.OpAttachmentAnim
				local var_128_2 = var_0_2

				var_128_1(var_128_0, var_4.NewMapOp(var_128_2, {
					anim = "chuansong_open",
					attachment = var_126_0
				}), arg_128_0)

				return
			end)
		end

		table = var_3

		var_3.insert(var_121_1, function(arg_129_0)
			local var_129_0 = arg_121_0

			var_1.OpSwitchMap(var_129_0, arg_121_1, arg_129_0)

			return
		end)

		return
	end
	WorldMapAttachment = var_12

	local var_121_6 = var_12.EffectEventTeleportBack

	WorldMapAttachment = var_13
	var_121_5[var_121_6] = var_13.EffectEventTeleport
	WorldMapAttachment = var_121_6
	var_121_5[var_121_6.EffectEventShowMapMark] = function()
		if var_121_0.isAutoFight then
			-- block empty
		else
			table = var_0

			var_0.insert(var_121_1, function(arg_131_0)
				local var_131_0 = arg_121_0

				var_1.OpShowMarkOverview(var_131_0, {
					ids = var_121_3
				}, arg_131_0)

				return
			end)
		end

		table = var_0

		var_0.insert(var_121_1, function(arg_132_0)
			local var_132_0 = arg_121_1

			var_1.Apply(var_132_0)
			arg_132_0()

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventCameraMove] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_134_0)
			local var_134_0 = arg_121_0

			var_1.OpMoveCamera(var_134_0, var_121_3[1], var_121_3[2], function()
				local var_135_0 = arg_121_1

				var_0.Apply(var_135_0)
				arg_134_0()

				return
			end)

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventShakePlane] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_137_0)
			local var_137_0 = arg_121_0

			var_1.OpShakePlane(var_137_0, var_121_3[1], var_121_3[2], var_121_3[3], var_121_3[4], function()
				local var_138_0 = arg_121_1

				var_0.Apply(var_138_0)
				arg_137_0()

				return
			end)

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventBlink1] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_140_0)
			local var_140_0 = var_121_0

			var_1.TriggerAutoFight(var_140_0, false)

			local var_140_1 = arg_121_0

			var_1.OpActions(var_140_1, arg_121_1.childOps, function()
				local var_141_0 = arg_121_1

				var_0.Apply(var_141_0)
				arg_140_0()

				return
			end)

			return
		end)

		return
	end
	WorldMapAttachment = var_12

	local var_121_7 = var_12.EffectEventBlink2

	WorldMapAttachment = var_13
	var_121_5[var_121_7] = var_13.EffectEventBlink1
	WorldMapAttachment = var_121_7
	var_121_5[var_121_7.EffectEventFlash] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_143_0)
			Color = var_3_10001

			local var_143_0 = var_3_10001.New(var_121_3[4][1] / 255, var_121_3[4][2] / 255, var_121_3[4][3] / 255, var_121_3[4][4] / 255)
			local var_143_1 = arg_121_0

			var_2.OpFlash(var_143_1, var_121_3[1], var_121_3[2], var_121_3[3], var_143_0, function()
				local var_144_0 = arg_121_1

				var_0.Apply(var_144_0)
				arg_143_0()

				return
			end)

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventShipBuff] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_146_0)
			local var_146_0 = arg_121_1

			var_1.Apply(var_146_0)
			arg_146_0()

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventHelp] = function()
		if var_121_0.isAutoFight then
			-- block empty
		else
			table = var_0

			var_0.insert(var_121_1, function(arg_148_0)
				WorldConst = var_3_10001

				local var_148_0 = var_3_10001.BuildHelpTips
				local var_148_1 = var_121_0
				local var_148_2 = var_148_0(var_3.GetProgress(var_148_1))

				var_148_2.defaultpage = var_121_3[1]
				pg = var_2

				local var_148_3 = var_2.MsgboxMgr.GetInstance()
				local var_148_4 = var_2.ShowMsgBox
				local var_148_5 = {}

				MSGBOX_TYPE_HELP = var_3_10006
				var_148_5.type = var_3_10006
				var_148_5.helps = var_148_2
				var_148_5.onClose = arg_148_0

				var_148_4(var_148_3, var_148_5)

				return
			end)
		end

		table = var_0

		var_0.insert(var_121_1, function(arg_149_0)
			local var_149_0 = arg_121_1

			var_1.Apply(var_149_0)
			arg_149_0()

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventProgress] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_151_0)
			local var_151_0 = arg_121_0

			var_1.OpActions(var_151_0, arg_121_1.childOps, function()
				local var_152_0 = arg_121_1

				var_0.Apply(var_152_0)
				arg_151_0()

				return
			end)

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventReturn2World] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_154_0)
			local var_154_0 = var_121_0

			var_1.TriggerAutoFight(var_154_0, false)

			local var_154_1 = arg_121_0

			var_1.OpSetInMap(var_154_1, false, function()
				local var_155_0 = arg_121_1

				var_0.Apply(var_155_0)
				arg_154_0()

				return
			end)

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventShowPort] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_157_0)
			local var_157_0 = arg_121_1

			var_1.Apply(var_157_0)

			local var_157_1 = var_121_0

			var_1.TriggerAutoFight(var_157_1, false)

			local var_157_2 = var_0_2

			var_1.OpenPortLayer(var_157_2, {
				page = var_121_3[1]
			})
			arg_157_0()

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventGlobalBuff] = function()
		local var_158_0 = {
			id = var_121_3[1],
			floor = var_121_3[2]
		}
		local var_158_1 = var_121_0
		local var_158_2 = var_1.GetGlobalBuff(var_158_1, var_121_3[1])

		var_158_0.before = var_1.GetFloor(var_158_2)

		if var_121_0.isAutoFight then
			local var_158_3 = var_121_0

			var_1.AddAutoInfo(var_158_3, "buffs", var_158_0)
		else
			table = var_1

			var_1.insert(var_121_1, function(arg_159_0)
				local var_159_0 = var_0_2

				var_1.ShowSubView(var_159_0, "GlobalBuff", {
					var_158_0,
					arg_159_0
				})

				return
			end)
		end

		table = var_1

		var_1.insert(var_121_1, function(arg_160_0)
			local var_160_0 = arg_121_1

			var_1.Apply(var_160_0)
			arg_160_0()

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventSound] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_162_0)
			local var_162_0 = arg_121_0

			var_1.OpPlaySound(var_162_0, var_121_3[1], function()
				local var_163_0 = arg_121_1

				var_0.Apply(var_163_0)
				arg_162_0()

				return
			end)

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventHelpLayer] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_165_0)
			local var_165_0 = var_121_0

			var_1.TriggerAutoFight(var_165_0, false)

			local var_165_1 = arg_121_1

			var_1.Apply(var_165_1)

			local var_165_2 = arg_121_0
			local var_165_3 = var_1.OpOpenLayer

			Context = var_4

			local var_165_4 = var_4.New
			local var_165_5 = {}

			WorldHelpMediator = var_3_10007
			var_165_5.mediator = var_3_10007
			WorldHelpLayer = var_3_10007
			var_165_5.viewComponent = var_3_10007
			var_165_5.data = {
				titleId = var_121_3[1],
				pageId = var_121_3[2]
			}
			var_165_5.onRemoved = arg_165_0

			var_165_3(var_165_2, var_165_4(var_165_5))

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventFleetShipHP] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_167_0)
			local var_167_0 = arg_121_1

			var_1.Apply(var_167_0)

			if var_121_3[1] > 0 then
				local var_167_1 = arg_121_0

				var_1.OpShowAllFleetHealth(var_167_1, arg_167_0)
			else
				arg_167_0()
			end

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventCatSalvage] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_169_0)
			local var_169_0 = arg_121_1

			var_1.Apply(var_169_0)

			pg = var_1

			local var_169_1 = var_1.TipsMgr.GetInstance()
			local var_169_2 = var_1.ShowTips

			i18n = var_3_10004

			var_169_2(var_169_1, var_3_10004("world_catsearch_success"))
			arg_169_0()

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectEventTeleportEvent] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_171_0)
			local var_171_0 = arg_121_1

			var_1.Apply(var_171_0)

			local var_171_1 = var_0_2.wsMap
			local var_171_2 = var_1.GetFleet(var_171_1)
			local var_171_3 = var_0_2.wsDragProxy
			local var_171_4 = var_2.Focus
			local var_171_5 = var_171_2.transform.position
			local var_171_6

			LeanTweenType = var_3_10007

			var_171_4(var_171_3, var_171_5, var_171_6, var_3_10007.easeInOutSine, arg_171_0)

			return
		end)

		return
	end
	WorldMapAttachment = var_12
	var_121_5[var_12.EffectSideText] = function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_173_0)
			local var_173_0 = arg_121_1

			var_1.Apply(var_173_0)

			local var_173_1 = var_0_2.wsMapTop

			var_1.OnUpdateFlashTips(var_173_1, nil, nil, var_121_3[1])
			arg_173_0()

			return
		end)

		return
	end

	var_1_10008(var_121_4, var_121_5, function()
		table = var_2_10000

		var_2_10000.insert(var_121_1, function(arg_175_0)
			local var_175_0 = arg_121_1

			var_1.Apply(var_175_0)
			arg_175_0()

			return
		end)

		return
	end)

	seriesAsync = var_1_10008

	var_1_10008(var_121_1, arg_121_2)

	return
end

function var_0_1.OpReqRetreat(arg_176_0, arg_176_1)
	nowWorld = var_1_10002

	local var_176_0 = var_1_10002()
	local var_176_1 = var_2.GetActiveMap(var_176_0)
	local var_176_2 = var_2.GetCell(var_176_1, arg_176_1.row, arg_176_1.column)

	assert = var_176_0

	local var_176_3 = var_176_2

	var_176_0(var_176_2.ExistEnemy(var_176_3))

	local var_176_4 = var_176_2:GetAliveAttachment()
	local var_176_5 = var_0_2
	local var_176_6 = var_5.emit

	WorldMediator = var_176_3

	local var_176_7 = var_176_3.OnMapOp
	local var_176_8 = var_0_2
	local var_176_9 = var_9.NewMapOp
	local var_176_10 = {}

	WorldConst = var_1_10013
	var_176_10.op = var_1_10013.OpReqRetreat
	var_176_10.id = arg_176_1.id
	var_176_10.attachment = var_176_4

	var_176_6(var_176_5, var_176_7, var_176_9(var_176_8, var_176_10))

	return
end

function var_0_1.OpReqRetreatDone(arg_177_0, arg_177_1)
	local var_177_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_177_0, function(arg_178_0)
		local var_178_0 = arg_177_0

		var_1.OpActions(var_178_0, arg_177_1.childOps, arg_178_0)

		return
	end)

	seriesAsync = var_3

	var_3(var_177_0, function()
		local var_179_0 = arg_177_1

		var_0.Apply(var_179_0)

		local var_179_1 = arg_177_0

		var_0.OpInteractive(var_179_1)

		return
	end)

	return
end

function var_0_1.OpTransport(arg_180_0, arg_180_1, arg_180_2)
	arg_180_0:OpDone()

	nowWorld = var_3

	local var_180_0 = var_3()
	local var_180_1 = var_3.GetActiveMap(var_180_0)
	local var_180_2 = var_3
	local var_180_3 = var_3.IsSystemOpen

	WorldConst = var_1_10008

	if not var_180_3(var_180_2, var_1_10008.SystemOutMap) then
		pg = var_5

		local var_180_4 = var_5.TipsMgr.GetInstance()
		local var_180_5 = var_5.ShowTips

		i18n = var_8

		var_180_5(var_180_4, var_8("word_systemClose"))
	elseif not arg_180_2:IsMapOpen() then
		pg = var_5

		local var_180_6 = var_5.TipsMgr.GetInstance()
		local var_180_7 = var_5.ShowTips

		i18n = var_8

		var_180_7(var_180_6, var_8("world_map_not_open"))
	else
		arg_180_0:OpReqTransport(var_180_1:GetFleet(), arg_180_1, arg_180_2)
	end

	return
end

function var_0_1.OpReqTransport(arg_181_0, arg_181_1, arg_181_2, arg_181_3)
	local var_181_0 = var_0_2
	local var_181_1 = var_4.emit

	WorldMediator = var_1_10007

	local var_181_2 = var_1_10007.OnMapOp
	local var_181_3 = var_0_2
	local var_181_4 = var_8.NewMapOp
	local var_181_5 = {}

	WorldConst = var_1_10012
	var_181_5.op = var_1_10012.OpReqTransport
	var_181_5.id = arg_181_1.id
	var_181_5.arg1 = arg_181_3.id
	var_181_5.arg2 = arg_181_2.id

	local var_181_6 = {}
	local var_181_7 = arg_181_3
	local var_181_8 = arg_181_3.CalcTransportPos

	nowWorld = var_1_10016

	local var_181_9 = var_1_10016()

	var_181_6[1] = var_181_8(var_181_7, var_16.GetActiveEntrance(var_181_9), arg_181_2)
	var_181_5.locations = var_181_6

	var_181_1(var_181_0, var_181_2, var_181_4(var_181_3, var_181_5))

	return
end

function var_0_1.OpReqTransportDone(arg_182_0, arg_182_1)
	local var_182_0 = {}

	seriesAsync = var_1_10003

	var_1_10003(var_182_0, function()
		local var_183_0 = arg_182_0

		var_0.OpSwitchMap(var_183_0, arg_182_1)

		return
	end)

	return
end

function var_0_1.OpReqSub(arg_184_0, arg_184_1)
	assert = var_1_10002
	nowWorld = var_1_10004

	local var_184_0 = var_1_10004()

	var_1_10002(var_4.CanCallSubmarineSupport(var_184_0))

	var_0_2.subCallback = arg_184_1

	local var_184_1 = var_0_2
	local var_184_2 = var_2.emit

	WorldMediator = var_1_10005

	local var_184_3 = var_1_10005.OnMapOp
	local var_184_4 = var_0_2
	local var_184_5 = var_6.NewMapOp
	local var_184_6 = {}

	WorldConst = var_1_10010
	var_184_6.op = var_1_10010.OpReqSub
	nowWorld = var_10

	local var_184_7 = var_10()

	var_184_6.id = var_10.GetSubmarineFleet(var_184_7).id

	var_184_2(var_184_1, var_184_3, var_184_5(var_184_4, var_184_6))

	return
end

function var_0_1.OpReqSubDone(arg_185_0, arg_185_1)
	nowWorld = var_1_10002

	local var_185_0 = var_1_10002()
	local var_185_1 = var_2.CalcOrderCost

	WorldConst = var_1_10006

	local var_185_2 = var_185_1(var_185_0, var_1_10006.OpReqSub)
	local var_185_3 = var_2.staminaMgr

	var_4.ConsumeStamina(var_185_3, var_185_2)

	local var_185_4 = var_2
	local var_185_5 = var_2.SetReqCDTime

	WorldConst = var_7

	local var_185_6 = var_7.OpReqSub

	pg = var_1_10008

	local var_185_7 = var_1_10008.TimeMgr.GetInstance()

	var_185_5(var_185_4, var_185_6, var_8.GetServerTime(var_185_7))

	local var_185_8 = var_2:GetSubmarineFleet()
	local var_185_9 = var_4.GetFlagShipVO(var_185_8)
	local var_185_10 = var_0_2

	var_5.DoStrikeAnim(var_185_10, var_185_9:GetMapStrikeAnim(), var_185_9, function()
		local var_186_0 = arg_185_1

		var_0.Apply(var_186_0)

		if var_0_2.subCallback then
			local var_186_1 = var_0_2.subCallback

			var_0_2.subCallback = nil

			var_186_1()
		end

		return
	end)

	return
end

function var_0_1.OpReqJumpOut(arg_187_0, arg_187_1, arg_187_2)
	local var_187_0 = {}

	if not arg_187_2 then
		table = var_1_10004

		var_1_10004.insert(var_187_0, function(arg_188_0)
			pg = var_2_10001

			local var_188_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_188_1 = var_1.ShowMsgBox
			local var_188_2 = {}

			pg = var_2_10005
			var_188_2.content = var_2_10005.world_chapter_template_reset[arg_187_1].tip
			var_188_2.onYes = arg_188_0

			function var_188_2.onNo()
				local var_189_0 = arg_187_0

				var_0.OpDone(var_189_0)

				return
			end

			var_188_1(var_188_0, var_188_2)

			return
		end)
	end

	seriesAsync = var_1_10004

	var_1_10004(var_187_0, function()
		local var_190_0 = var_0_2
		local var_190_1 = var_0.emit

		WorldMediator = var_2_10003

		local var_190_2 = var_2_10003.OnMapOp
		local var_190_3 = var_0_2
		local var_190_4 = var_4.NewMapOp
		local var_190_5 = {}

		WorldConst = var_2_10008
		var_190_5.op = var_2_10008.OpReqJumpOut
		var_190_5.skipDisplay = arg_187_2

		var_190_1(var_190_0, var_190_2, var_190_4(var_190_3, var_190_5))

		return
	end)

	return
end

function var_0_1.OpReqJumpOutDone(arg_191_0, arg_191_1)
	local var_191_0 = {}

	if not arg_191_1.skipDisplay then
		table = var_3

		var_3.insert(var_191_0, function(arg_192_0)
			local var_192_0 = var_0_2

			var_1.ShowTransportMarkOverview(var_192_0, {
				ids = {
					arg_191_1.entranceId
				}
			}, arg_192_0)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_191_0, function()
		local var_193_0 = arg_191_0

		var_0.OpSwitchMap(var_193_0, arg_191_1)

		return
	end)

	return
end

function var_0_1.OpReqSwitchFleet(arg_194_0, arg_194_1)
	local var_194_0 = var_0_2
	local var_194_1 = var_2.emit

	WorldMediator = var_1_10005

	local var_194_2 = var_1_10005.OnMapOp
	local var_194_3 = var_0_2
	local var_194_4 = var_6.NewMapOp
	local var_194_5 = {}

	WorldConst = var_1_10010
	var_194_5.op = var_1_10010.OpReqSwitchFleet
	var_194_5.id = arg_194_1.id

	var_194_1(var_194_0, var_194_2, var_194_4(var_194_3, var_194_5))

	return
end

function var_0_1.OpReqSwitchFleetDone(arg_195_0, arg_195_1)
	nowWorld = var_1_10002

	local var_195_0 = var_1_10002()

	table = var_1_10003

	local var_195_1 = var_1_10003.indexof(var_195_0.fleets, var_195_0:GetFleet(arg_195_1.id))
	local var_195_2 = var_195_0:GetActiveMap()

	var_4.UpdateFleetIndex(var_195_2, var_195_1)

	local var_195_3 = var_0_2.wsMap

	var_4.UpdateRangeVisible(var_195_3, false)
	arg_195_0:OpInteractive()

	return
end

function var_0_1.OpStory(arg_196_0, arg_196_1, arg_196_2, arg_196_3, arg_196_4, arg_196_5)
	local function var_196_0(arg_197_0, arg_197_1)
		local var_197_0 = arg_196_0

		var_2.OpDone(var_197_0)

		existCall = var_2

		var_2(arg_196_5, arg_197_1)

		return
	end

	pg = var_1_10007

	local var_196_1 = var_1_10007.NewStoryMgr.GetInstance()
	local var_196_2 = var_7.PlayForWorld
	local var_196_3 = arg_196_1
	local var_196_4 = arg_196_4
	local var_196_5 = var_196_0
	local var_196_6 = arg_196_2
	local var_196_7 = false

	tobool = var_1_10015

	var_196_2(var_196_1, var_196_3, var_196_4, var_196_5, var_196_6, var_196_7, var_1_10015(arg_196_4), arg_196_3)

	return
end

function var_0_1.OpTriggerSign(arg_198_0, arg_198_1, arg_198_2, arg_198_3)
	assert = var_1_10004

	var_1_10004(arg_198_2:IsSign())
	arg_198_0:OpDone()

	local var_198_0 = arg_198_2

	if arg_198_2.IsAvatar(var_198_0) then
		var_198_0 = var_0_2.wsMap

		local var_198_1 = var_4.GetAttachment(var_198_0, arg_198_2.row, arg_198_2.column, arg_198_2.type)
		local var_198_2 = var_0_2.wsMap
		local var_198_3 = var_5.GetFleet(var_198_2)

		if arg_198_2.column ~= var_198_3.fleet.column then
			var_198_0 = var_198_1:GetModelAngles()
			var_198_0.y = arg_198_2.column < var_198_3.fleet.column and 0 or 180

			var_198_1:UpdateModelAngles(var_198_0)

			local var_198_4 = var_198_3:GetModelAngles()

			var_198_4.y = 180 - var_198_0.y

			var_198_3:UpdateModelAngles(var_198_4)
		end
	end

	local var_198_5 = {}
	local var_198_6 = arg_198_2:GetEventEffects()

	_ = var_198_0

	var_198_0.each(var_198_6, function(arg_199_0)
		local var_199_0 = arg_199_0.effect_type
		local var_199_1 = arg_199_0.effect_paramater

		WorldMapAttachment = var_2_10003

		local var_199_2

		if var_199_0 == var_2_10003.EffectEventStoryOptionClient then
			var_199_2 = var_199_1[1]

			if arg_199_0.autoflag[1] then
				WorldConst = var_2_10005

				if var_2_10005.CheckWorldStorySkip(var_199_2) then
					table = var_2_10005

					var_2_10005.insert(var_198_5, function(arg_200_0)
						arg_200_0(var_0)

						return
					end)

					goto label_199_0
				end
			end

			table = var_2_10005

			var_2_10005.insert(var_198_5, function(arg_201_0)
				local var_201_0 = arg_198_0
				local var_201_1 = var_1.OpStory
				local var_201_2 = var_199_2
				local var_201_3 = true
				local var_201_4 = true

				nowWorld = var_3_10007

				local var_201_5

				if not var_3_10007().isAutoFight or not var_0 or not {
					var_0
				} then
					var_201_5 = false
				end

				var_201_1(var_201_0, var_201_2, var_201_3, var_201_4, var_201_5, arg_201_0)

				return
			end)

			::label_199_0::

			table = var_2_10005

			var_2_10005.insert(var_198_5, function(arg_202_0, arg_202_1)
				assert = var_3_10002

				var_3_10002(arg_202_1, "without option in story:" .. var_199_1[1])

				_ = var_3_10002

				if var_3_10002.detect(var_199_1[2], function(arg_203_0)
					return arg_203_0[1] == arg_202_1
				end) and var_2[2] > 0 then
					local var_202_0 = arg_198_0
					local var_202_1 = var_3.OpTriggerEvent
					local var_202_2 = var_0_2
					local var_202_3 = var_6.NewMapOp
					local var_202_4 = {
						attachment = arg_198_2
					}

					pg = var_10
					var_202_4.effect = var_10.world_effect_data[var_2[2]]

					var_202_1(var_202_0, var_202_3(var_202_2, var_202_4), arg_202_0)
				else
					arg_202_0()
				end

				return
			end)
		else
			table = var_199_2

			var_199_2.insert(var_198_5, function(arg_204_0)
				local var_204_0 = arg_198_0
				local var_204_1 = var_1.OpTriggerEvent
				local var_204_2 = var_0_2

				var_204_1(var_204_0, var_4.NewMapOp(var_204_2, {
					attachment = arg_198_2,
					effect = arg_199_0
				}), arg_204_0)

				return
			end)
		end

		return
	end)

	seriesAsync = var_6

	var_6(var_198_5, arg_198_3)

	return
end

function var_0_1.OpShowMarkOverview(arg_205_0, arg_205_1, arg_205_2)
	local var_205_0 = var_0_2
	local var_205_1 = var_3.emit

	WorldMediator = var_1_10006

	local var_205_2 = var_1_10006.OnOpenLayer

	Context = var_1_10007

	local var_205_3 = var_1_10007.New
	local var_205_4 = {}

	WorldOverviewMediator = var_1_10010
	var_205_4.mediator = var_1_10010
	WorldOverviewLayer = var_1_10010
	var_205_4.viewComponent = var_1_10010
	var_205_4.data = {
		info = arg_205_1
	}

	function var_205_4.onRemoved()
		local var_206_0 = arg_205_0

		var_0.OpDone(var_206_0)

		existCall = var_0

		return var_0(arg_205_2)
	end

	var_205_1(var_205_0, var_205_2, var_205_3(var_205_4))

	return
end

function var_0_1.OpFocusTargetEntrance(arg_207_0, arg_207_1)
	arg_207_0:OpDone()

	local var_207_0 = {}
	local var_207_1 = var_0_2

	if var_3.GetInMap(var_207_1) then
		table = var_3

		var_3.insert(var_207_0, function(arg_208_0)
			local var_208_0 = var_0_2

			var_1.QueryTransport(var_208_0, arg_208_0)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_207_0, function()
		local var_209_0 = var_0_2

		var_0.EnterTransportWorld(var_209_0, arg_207_1)

		return
	end)

	return
end

function var_0_1.OpShowOrderPanel(arg_210_0)
	arg_210_0:OpDone()

	nowWorld = var_1

	local var_210_0 = var_1()
	local var_210_1 = var_0_2
	local var_210_2 = var_2.ShowSubView
	local var_210_3 = "OrderPanel"
	local var_210_4 = {
		var_210_0:GetActiveEntrance(),
		(var_210_0:GetActiveMap())
	}
	local var_210_5 = var_0_2.wsMapRight.wsCompass

	var_210_4[3] = var_7.GetAnchorEulerAngles(var_210_5)

	var_210_2(var_210_1, var_210_3, var_210_4)

	return
end

function var_0_1.OpShowScannerPanel(arg_211_0, arg_211_1, arg_211_2)
	arg_211_0:OpDone()

	nowWorld = var_3

	local var_211_0 = var_3()
	local var_211_1 = var_0_2

	var_4.ShowSubView(var_211_1, "ScannerPanel", {
		var_211_0:GetActiveMap(),
		var_0_2.wsDragProxy
	}, {
		arg_211_1,
		arg_211_2
	})

	return
end

function var_0_1.OpMoveCamera(arg_212_0, arg_212_1, arg_212_2, arg_212_3)
	local var_212_0 = var_0_2

	arg_212_3 = var_4.DoTopBlock(var_212_0, arg_212_3)

	local var_212_1 = {}

	if arg_212_1 > 0 then
		local var_212_2 = var_0_2.wsMap.map
		local var_212_3 = var_5.FindAttachments

		WorldMapAttachment = var_1_10008

		local var_212_4 = var_212_3(var_212_2, var_1_10008.TypeEvent, arg_212_1)

		ipairs = var_212_0

		for iter_212_0, iter_212_1 in var_212_0(var_212_4) do
			table = var_1_10011

			var_1_10011.insert(var_212_1, {
				focusPos = function()
					local var_213_0 = var_0_2.wsMap

					return var_0.GetAttachment(var_213_0, iter_212_1.row, iter_212_1.column, iter_212_1.type).transform.position
				end,
				row = iter_212_1.row,
				column = iter_212_1.column
			})
		end
	else
		local var_212_5 = var_0_2.wsMap
		local var_212_6 = var_5.GetFleet(var_212_5)

		table = var_212_0

		var_212_0.insert(var_212_1, {
			focusPos = function()
				return var_212_6.transform.position
			end,
			row = var_212_6.fleet.row,
			column = var_212_6.fleet.column
		})
	end

	local var_212_7 = {}

	ipairs = var_212_0

	for iter_212_2, iter_212_3 in var_212_0(var_212_1) do
		table = var_1_10011

		var_1_10011.insert(var_212_7, function(arg_215_0)
			local var_215_0 = var_0_2.wsMapRight

			var_1.UpdateCompossView(var_215_0, iter_212_3.row, iter_212_3.column)
			arg_215_0()

			return
		end)

		table = var_1_10011

		var_1_10011.insert(var_212_7, function(arg_216_0)
			local var_216_0 = var_0_2.wsDragProxy
			local var_216_1 = var_1.Focus
			local var_216_2 = iter_212_3.focusPos()
			local var_216_3

			LeanTweenType = var_2_10006

			var_216_1(var_216_0, var_216_2, var_216_3, var_2_10006.easeInOutSine, arg_216_0)

			return
		end)

		table = var_1_10011

		var_1_10011.insert(var_212_7, function(arg_217_0)
			local var_217_0 = var_0_2.wsTimer
			local var_217_1 = var_1.AddInMapTimer(var_217_0, arg_217_0, arg_212_2, 1)

			var_1.Start(var_217_1)

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_212_7, function()
		local var_218_0 = arg_212_0

		var_0.OpDone(var_218_0)

		existCall = var_0

		return var_0(arg_212_3)
	end)

	return
end

function var_0_1.OpMoveCameraTarget(arg_219_0, arg_219_1, arg_219_2, arg_219_3)
	local var_219_0 = var_0_2

	arg_219_3 = var_4.DoTopBlock(var_219_0, arg_219_3)

	if not arg_219_1 then
		local var_219_1 = var_0_2.wsMap
		local var_219_2 = var_4.GetFleet(var_219_1)

		arg_219_1 = {
			row = var_219_2.fleet.row,
			column = var_219_2.fleet.column
		}
	end

	local var_219_3 = {}

	table = var_1_10005

	var_1_10005.insert(var_219_3, function(arg_220_0)
		local var_220_0 = var_0_2.wsMapRight

		var_1.UpdateCompossView(var_220_0, arg_219_1.row, arg_219_1.column)
		arg_220_0()

		return
	end)

	table = var_5

	var_5.insert(var_219_3, function(arg_221_0)
		local var_221_0 = var_0_2.wsDragProxy
		local var_221_1 = var_1.Focus
		local var_221_2 = var_0_2.wsMap
		local var_221_3 = var_4.GetCell(var_221_2, arg_219_1.row, arg_219_1.column).transform.position
		local var_221_4

		LeanTweenType = var_221_2

		var_221_1(var_221_0, var_221_3, var_221_4, var_221_2.easeInOutSine, arg_221_0)

		return
	end)

	table = var_5

	var_5.insert(var_219_3, function(arg_222_0)
		local var_222_0 = var_0_2.wsTimer
		local var_222_1 = var_1.AddInMapTimer(var_222_0, arg_222_0, arg_219_2, 1)

		var_1.Start(var_222_1)

		return
	end)

	seriesAsync = var_5

	var_5(var_219_3, function()
		local var_223_0 = arg_219_0

		var_0.OpDone(var_223_0)

		existCall = var_0

		return var_0(arg_219_3)
	end)

	return
end

function var_0_1.OpShakePlane(arg_224_0, arg_224_1, arg_224_2, arg_224_3, arg_224_4, arg_224_5)
	local var_224_0 = var_0_2.wsDragProxy

	var_6.ShakePlane(var_224_0, arg_224_1, arg_224_2, arg_224_3, arg_224_4, function()
		local var_225_0 = arg_224_0

		var_0.OpDone(var_225_0)

		if arg_224_5 then
			arg_224_5()
		end

		return
	end)

	return
end

function var_0_1.OpAttachmentAnim(arg_226_0, arg_226_1, arg_226_2)
	local var_226_0 = arg_226_1.attachment
	local var_226_1 = var_0_2.wsMap
	local var_226_2 = var_4.GetAttachment(var_226_1, var_226_0.row, var_226_0.column, var_226_0.type)

	seriesAsync = var_1_10005

	var_1_10005({
		function(arg_227_0)
			local var_227_0 = var_226_2

			var_1.PlayModelAction(var_227_0, arg_226_1.anim, arg_226_1.duration, arg_227_0)

			return
		end
	}, function()
		local var_228_0 = var_226_2

		var_0.FlushModelAction(var_228_0)

		local var_228_1 = arg_226_0

		var_0.OpDone(var_228_1)
		arg_226_2()

		return
	end)

	return
end

function var_0_1.OpFleetAnim(arg_229_0, arg_229_1, arg_229_2)
	local var_229_0 = var_0_2.wsMap.map
	local var_229_1 = var_3.GetFleet(var_229_0, arg_229_1.id)
	local var_229_2 = var_0_2.wsMap
	local var_229_3 = var_4.GetFleet(var_229_2, var_229_1)

	seriesAsync = var_229_0

	var_229_0({
		function(arg_230_0)
			local var_230_0 = var_229_3

			var_1.PlayModelAction(var_230_0, arg_229_1.anim, arg_229_1.duration, arg_230_0)

			return
		end
	}, function()
		local var_231_0 = var_229_3

		var_0.FlushModelAction(var_231_0)

		local var_231_1 = arg_229_0

		var_0.OpDone(var_231_1)
		arg_229_2()

		return
	end)

	return
end

function var_0_1.OpFlash(arg_232_0, arg_232_1, arg_232_2, arg_232_3, arg_232_4, arg_232_5)
	local var_232_0 = var_0_2.rtTop
	local var_232_1 = var_6.Find(var_232_0, "flash")

	setActive = var_1_10007

	var_1_10007(var_232_1, true)

	setImageColor = var_1_10007

	var_1_10007(var_232_1, arg_232_4)

	setImageAlpha = var_1_10007

	var_1_10007(var_232_1, 0)

	local var_232_2 = var_0_2.wsTimer
	local var_232_3 = var_7.AddInMapTween

	LeanTween = var_10

	var_232_3(var_232_2, var_10.alpha(var_232_1, arg_232_4.a, arg_232_1).uniqueId)

	local var_232_4 = var_0_2.wsTimer
	local var_232_5 = var_7.AddInMapTween

	LeanTween = var_10

	local var_232_6 = var_10.alpha(var_232_1, 0, arg_232_3)
	local var_232_7 = var_10.setDelay(var_232_6, arg_232_1 + arg_232_2)
	local var_232_8 = var_10.setOnComplete

	System = var_13

	var_232_5(var_232_4, var_232_8(var_232_7, var_13.Action(function()
		setActive = var_2_10000

		var_2_10000(var_232_1, false)

		local var_233_0 = arg_232_0

		var_0.OpDone(var_233_0)
		arg_232_5()

		return
	end)).uniqueId)

	return
end

function var_0_1.OpReqBox(arg_234_0, arg_234_1, arg_234_2)
	assert = var_1_10003

	if arg_234_2 then
		::label_234_0::

		var_1_10005 = arg_234_2.type
		WorldMapAttachment = var_1_10006
		var_1_10005 = var_1_10005 == var_1_10006.TypeBox
	end

	var_1_10003(var_1_10005)

	local var_234_0 = var_0_2
	local var_234_1 = var_3.emit

	WorldMediator = var_1_10006

	local var_234_2 = var_1_10006.OnMapOp
	local var_234_3 = var_0_2
	local var_234_4 = var_7.NewMapOp
	local var_234_5 = {}

	WorldConst = var_1_10011
	var_234_5.op = var_1_10011.OpReqBox
	var_234_5.id = arg_234_1.id
	var_234_5.attachment = arg_234_2

	var_234_1(var_234_0, var_234_2, var_234_4(var_234_3, var_234_5))

	return
end

function var_0_1.OpReqBoxDone(arg_235_0, arg_235_1)
	arg_235_1:Apply()
	arg_235_0:OpInteractive()

	return
end

function var_0_1.OpSetInMap(arg_236_0, arg_236_1, arg_236_2)
	arg_236_0:OpDone()

	local var_236_0 = var_0_2

	var_3.SetInMap(var_236_0, arg_236_1, arg_236_2)

	return
end

function var_0_1.OpSwitchInMap(arg_237_0, arg_237_1)
	local var_237_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_237_0, function(arg_238_0)
		local var_238_0 = var_0_2

		var_1.DisplayMap(var_238_0)

		local var_238_1 = var_0_2

		var_1.DisplayMapUI(var_238_1)

		local var_238_2 = var_0_2

		var_1.UpdateMapUI(var_238_2)

		return arg_238_0()
	end)

	table = var_3

	var_3.insert(var_237_0, function(arg_239_0)
		local var_239_0 = var_0_2

		var_1.EaseInMapUI(var_239_0, arg_239_0)

		return
	end)

	table = var_3

	var_3.insert(var_237_0, function(arg_240_0)
		local var_240_0 = arg_237_0

		var_1.OpDone(var_240_0)

		return arg_240_0()
	end)

	seriesAsync = var_3

	var_3(var_237_0, arg_237_1)

	return
end

function var_0_1.OpSwitchOutMap(arg_241_0, arg_241_1)
	local var_241_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_241_0, function(arg_242_0)
		local var_242_0 = var_0_2

		var_1.EaseOutMapUI(var_242_0, arg_242_0)

		return
	end)

	table = var_3

	var_3.insert(var_241_0, function(arg_243_0)
		local var_243_0 = var_0_2

		var_1.HideMap(var_243_0)

		local var_243_1 = var_0_2

		var_1.HideMapUI(var_243_1)

		return arg_243_0()
	end)

	table = var_3

	var_3.insert(var_241_0, function(arg_244_0)
		local var_244_0 = arg_241_0

		var_1.OpDone(var_244_0)

		return arg_244_0()
	end)

	seriesAsync = var_3

	var_3(var_241_0, arg_241_1)

	return
end

function var_0_1.OpSwitchInWorld(arg_245_0, arg_245_1)
	local var_245_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_245_0, function(arg_246_0)
		local var_246_0 = var_0_2

		var_1.DisplayAtlas(var_246_0)

		local var_246_1 = var_0_2

		var_1.DisplayAtlasUI(var_246_1)

		return arg_246_0()
	end)

	table = var_3

	var_3.insert(var_245_0, function(arg_247_0)
		local var_247_0 = var_0_2

		var_1.EaseInAtlasUI(var_247_0, arg_247_0)

		return
	end)

	table = var_3

	var_3.insert(var_245_0, function(arg_248_0)
		local var_248_0 = arg_245_0

		var_1.OpDone(var_248_0)

		return arg_248_0()
	end)

	seriesAsync = var_3

	var_3(var_245_0, arg_245_1)

	return
end

function var_0_1.OpSwitchOutWorld(arg_249_0, arg_249_1)
	local var_249_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_249_0, function(arg_250_0)
		local var_250_0 = var_0_2

		var_1.EaseOutAtlasUI(var_250_0, arg_250_0)

		return
	end)

	table = var_3

	var_3.insert(var_249_0, function(arg_251_0)
		local var_251_0 = var_0_2

		var_1.HideAtlas(var_251_0)

		local var_251_1 = var_0_2

		var_1.HideAtlasUI(var_251_1)

		return arg_251_0()
	end)

	table = var_3

	var_3.insert(var_249_0, function(arg_252_0)
		local var_252_0 = arg_249_0

		var_1.OpDone(var_252_0)

		return arg_252_0()
	end)

	seriesAsync = var_3

	var_3(var_249_0, arg_249_1)

	return
end

function var_0_1.OpRedeploy(arg_253_0)
	local var_253_0 = arg_253_0

	arg_253_0.OpDone(var_253_0)

	nowWorld = var_1

	local var_253_1 = var_1()
	local var_253_2 = var_1.GetActiveMap(var_253_1)

	underscore = var_253_0

	local var_253_3 = var_253_0.any
	local var_253_4 = var_253_2

	if var_253_3(var_253_2.GetNormalFleets(var_253_4), function(arg_254_0)
		return #arg_254_0:GetCarries() > 0
	end) then
		pg = var_3

		local var_253_5 = var_3.TipsMgr.GetInstance()
		local var_253_6 = var_3.ShowTips

		i18n = var_6

		var_253_6(var_253_5, var_6("world_instruction_redeploy_3"))

		return
	end

	if var_253_2:CheckFleetSalvage(true) then
		pg = var_3

		local var_253_7 = var_3.MsgboxMgr.GetInstance()
		local var_253_8 = var_3.ShowMsgBox
		local var_253_9 = {}

		i18n = var_253_4
		var_253_9.content = var_253_4("world_catsearch_fleetcheck")

		function var_253_9.onYes()
			var_253_2.salvageAutoResult = true

			local var_255_0 = arg_253_0

			var_0.OpInteractive(var_255_0)

			return
		end

		var_253_8(var_253_7, var_253_9)
	else
		local var_253_10, var_253_11 = var_1:BuildFormationIds()
		local var_253_12 = arg_253_0
		local var_253_13 = arg_253_0.OpOpenScene

		SCENE = var_1_10008

		var_253_13(var_253_12, var_1_10008.WORLD_FLEET_SELECT, {
			type = var_253_10,
			fleets = var_253_11
		})
	end

	return
end

function var_0_1.OpKillWorld(arg_256_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10003

	local var_256_0 = var_1_10001(var_1_10003)
	local var_256_1 = var_1.getContextByMediator

	WorldMediator = var_1_10004
	var_256_1(var_256_0, var_1_10004).onRemoved = function()
		pg = var_2_10000

		local var_257_0 = var_2_10000.m02
		local var_257_1 = var_0.sendNotification

		GAME = var_2_10003

		var_257_1(var_257_0, var_2_10003.WORLD_KILL)

		return
	end

	local var_256_2 = var_0_2

	var_2.ExitWorld(var_256_2, function()
		local var_258_0 = arg_256_0

		var_0.OpDone(var_258_0)

		return
	end, true)

	return
end

function var_0_1.OpReqMaintenance(arg_259_0, arg_259_1)
	local var_259_0 = var_0_2
	local var_259_1 = var_2.emit

	WorldMediator = var_1_10005

	local var_259_2 = var_1_10005.OnMapOp
	local var_259_3 = var_0_2
	local var_259_4 = var_6.NewMapOp
	local var_259_5 = {}

	WorldConst = var_1_10010
	var_259_5.op = var_1_10010.OpReqMaintenance
	var_259_5.id = arg_259_1

	var_259_1(var_259_0, var_259_2, var_259_4(var_259_3, var_259_5))

	return
end

function var_0_1.OpReqMaintenanceDone(arg_260_0, arg_260_1)
	local var_260_0 = arg_260_1

	arg_260_1.Apply(var_260_0)

	nowWorld = var_2

	local var_260_1 = var_2()
	local var_260_2 = var_2.GetFleets(var_260_1)

	_ = var_260_0

	var_260_0.each(var_260_2, function(arg_261_0)
		arg_261_0:ClearDamageLevel()

		ipairs = var_1

		for iter_261_0, iter_261_1 in var_1(arg_261_0:GetShips(true)) do
			iter_261_1:Repair()
		end

		return
	end)

	local var_260_3 = var_2
	local var_260_4 = var_2.CalcOrderCost

	WorldConst = var_7

	local var_260_5 = var_260_4(var_260_3, var_7.OpReqMaintenance)
	local var_260_6 = var_2.staminaMgr

	var_5.ConsumeStamina(var_260_6, var_260_5)

	local var_260_7 = var_2
	local var_260_8 = var_2.SetReqCDTime

	WorldConst = var_8

	local var_260_9 = var_8.OpReqMaintenance

	pg = var_1_10009

	local var_260_10 = var_1_10009.TimeMgr.GetInstance()

	var_260_8(var_260_7, var_260_9, var_9.GetServerTime(var_260_10))

	local var_260_11 = var_0_2.wsMap

	var_5.UpdateRangeVisible(var_260_11, false)
	arg_260_0:OpShowAllFleetHealth(function()
		local var_262_0 = arg_260_0

		var_0.OpInteractive(var_262_0)

		return
	end)

	return
end

function var_0_1.OpReqVision(arg_263_0)
	local var_263_0 = var_0_2
	local var_263_1 = var_1.emit

	WorldMediator = var_1_10004

	local var_263_2 = var_1_10004.OnMapOp
	local var_263_3 = var_0_2
	local var_263_4 = var_5.NewMapOp
	local var_263_5 = {}

	WorldConst = var_1_10009
	var_263_5.op = var_1_10009.OpReqVision

	var_263_1(var_263_0, var_263_2, var_263_4(var_263_3, var_263_5))

	return
end

function var_0_1.OpReqVisionDone(arg_264_0, arg_264_1)
	arg_264_1:Apply()

	nowWorld = var_2

	local var_264_0 = var_2()
	local var_264_1 = var_2.CalcOrderCost

	WorldConst = var_1_10006

	local var_264_2 = var_264_1(var_264_0, var_1_10006.OpReqVision)
	local var_264_3 = var_2.staminaMgr

	var_4.ConsumeStamina(var_264_3, var_264_2)

	local var_264_4 = var_2
	local var_264_5 = var_2.SetReqCDTime

	WorldConst = var_7

	local var_264_6 = var_7.OpReqVision

	pg = var_1_10008

	local var_264_7 = var_1_10008.TimeMgr.GetInstance()

	var_264_5(var_264_4, var_264_6, var_8.GetServerTime(var_264_7))

	local var_264_8 = var_2:GetActiveMap()

	var_4.UpdateVisionFlag(var_264_8, true)

	local var_264_9 = var_0_2.wsMap

	var_4.UpdateRangeVisible(var_264_9, false)
	arg_264_0:OpInteractive()

	return
end

function var_0_1.OpReqPressingMap(arg_265_0)
	nowWorld = var_1_10001

	local var_265_0 = var_1_10001()
	local var_265_1 = var_1.GetActiveMap(var_265_0)
	local var_265_2 = var_1.GetFleet(var_265_1).id
	local var_265_3 = var_0_2
	local var_265_4 = var_3.emit

	WorldMediator = var_1_10006

	local var_265_5 = var_1_10006.OnMapOp
	local var_265_6 = var_0_2
	local var_265_7 = var_7.NewMapOp
	local var_265_8 = {}

	WorldConst = var_1_10011
	var_265_8.op = var_1_10011.OpReqPressingMap
	var_265_8.id = var_265_2
	var_265_8.arg1 = var_1.id

	var_265_4(var_265_3, var_265_5, var_265_7(var_265_6, var_265_8))

	return
end

function var_0_1.OpReqPressingMapDone(arg_266_0, arg_266_1, arg_266_2)
	local var_266_0 = arg_266_2
	local var_266_1 = arg_266_1.arg1

	nowWorld = var_1_10005

	local var_266_2 = var_1_10005()
	local var_266_3 = var_5.GetMap(var_266_2, var_266_1)

	if var_6.CheckMapPressingDisplay(var_266_3) then
		table = var_6

		var_6.insert(var_266_0, 1, function(arg_267_0)
			local var_267_0 = var_0_2

			var_1.BuildCutInAnim(var_267_0, "WorldPressingWindow", arg_267_0)

			return
		end)
	end

	if var_5:GetPressingAward(var_266_1) and var_6.flag then
		pg = var_1_10007

		if #var_1_10007.world_event_complete[var_6.id].event_reward_slgbuff > 1 then
			local var_266_4 = {
				id = var_8[1],
				floor = var_8[2]
			}
			local var_266_5 = var_5:GetGlobalBuff(var_8[1])

			var_266_4.before = var_10.GetFloor(var_266_5)

			if var_5.isAutoFight then
				var_5:AddAutoInfo("buffs", var_266_4)
			else
				table = var_10

				var_10.insert(var_266_0, function(arg_268_0)
					local var_268_0 = var_0_2

					var_1.ShowSubView(var_268_0, "GlobalBuff", {
						var_266_4,
						arg_268_0
					})

					return
				end)
			end

			table = var_10

			var_10.insert(var_266_0, function(arg_269_0)
				local var_269_0 = var_0

				var_1.AddGlobalBuff(var_269_0, var_0[1], var_0[2])
				arg_269_0()

				return
			end)
		end
	end

	seriesAsync = var_1_10007

	var_1_10007(var_266_0, function()
		local var_270_0 = arg_266_1

		var_0.Apply(var_270_0)

		local var_270_1 = var_0_2.wsMap

		var_0.UpdateRangeVisible(var_270_1, false)

		local var_270_2 = arg_266_0

		var_0.OpInteractive(var_270_2)

		return
	end)

	return
end

function var_0_1.OpReqEnterPort(arg_271_0)
	nowWorld = var_1_10001

	local var_271_0 = var_1_10001()
	local var_271_1 = var_1.GetActiveMap(var_271_0)
	local var_271_2 = var_2.GetPort(var_271_1)
	local var_271_4

	if var_2.IsOpen(var_271_2, var_1:GetRealm(), var_1:GetProgress()) then
		local var_271_3 = var_0_2

		var_271_4 = var_271_4.emit
		WorldMediator = var_6

		local var_271_5 = var_6.OnMapOp
		local var_271_6 = var_0_2
		local var_271_7 = var_7.NewMapOp
		local var_271_8 = {}

		WorldConst = var_1_10011
		var_271_8.op = var_1_10011.OpReqEnterPort

		var_271_4(var_271_3, var_271_5, var_271_7(var_271_6, var_271_8))
	else
		pg = var_271_4

		local var_271_9 = var_271_4.TipsMgr.GetInstance()

		var_3.ShowTips(var_271_9, "port is not open: " .. var_2.id)
	end

	return
end

function var_0_1.OpReqEnterPortDone(arg_272_0, arg_272_1)
	arg_272_1:Apply()

	local var_272_0 = var_0_2

	var_2.OpenPortLayer(var_272_0)

	return
end

function var_0_1.OpReqCatSalvage(arg_273_0, arg_273_1)
	if not arg_273_1 then
		nowWorld = var_1_10002

		local var_273_0 = var_1_10002()
		local var_273_1 = var_2.GetActiveMap(var_273_0)

		arg_273_1 = var_2.CheckFleetSalvage(var_273_1)
	end

	local var_273_2 = var_0_2
	local var_273_3 = var_2.emit

	WorldMediator = var_1_10005

	local var_273_4 = var_1_10005.OnMapOp
	local var_273_5 = var_0_2
	local var_273_6 = var_6.NewMapOp
	local var_273_7 = {}

	WorldConst = var_1_10010
	var_273_7.op = var_1_10010.OpReqCatSalvage
	var_273_7.id = arg_273_1

	var_273_3(var_273_2, var_273_4, var_273_6(var_273_5, var_273_7))

	return
end

function var_0_1.OpReqCatSalvageDone(arg_274_0, arg_274_1, arg_274_2)
	local var_274_0 = arg_274_2

	nowWorld = var_1_10004

	if var_1_10004().isAutoFight then
		-- block empty
	else
		table = var_5

		var_5.insert(var_274_0, 1, function(arg_275_0)
			local var_275_0 = var_0
			local var_275_1 = var_1.GetFleet(var_275_0, arg_274_1.id)
			local var_275_2 = var_1.GetRarityState(var_275_1)
			local var_275_3 = 0 < var_275_2 and 2 or 1

			pg = var_2

			local var_275_4 = var_2.NewStoryMgr.GetInstance()
			local var_275_5 = var_2.Play

			pg = var_2_10005

			var_275_5(var_275_4, var_2_10005.gameset.world_catsearch_completed.description[var_275_3], arg_275_0, true)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_274_0, function()
		local var_276_0 = arg_274_1

		var_0.Apply(var_276_0)

		local var_276_1 = arg_274_0

		var_0.OpInteractive(var_276_1)

		return
	end)

	return
end

function var_0_1.OpReqSkipBattle(arg_277_0, arg_277_1)
	local var_277_0 = var_0_2
	local var_277_1 = var_2.emit

	WorldMediator = var_1_10005

	local var_277_2 = var_1_10005.OnMapOp
	local var_277_3 = var_0_2
	local var_277_4 = var_6.NewMapOp
	local var_277_5 = {}

	WorldConst = var_1_10010
	var_277_5.op = var_1_10010.OpReqSkipBattle
	var_277_5.id = arg_277_1

	var_277_1(var_277_0, var_277_2, var_277_4(var_277_3, var_277_5))

	return
end

function var_0_1.OpReqSkipBattleDone(arg_278_0, arg_278_1)
	arg_278_1:Apply()
	arg_278_0:OpInteractive()

	return
end

function var_0_1.OpPlaySound(arg_279_0, arg_279_1, arg_279_2)
	local var_279_0 = var_0_2

	var_3.PlaySound(var_279_0, arg_279_1, arg_279_2)

	return
end

function var_0_1.OpGuide(arg_280_0, arg_280_1, arg_280_2, arg_280_3)
	arg_280_0:OpDone()

	WorldGuider = var_4

	local var_280_0 = var_4.GetInstance()

	arg_280_1 = var_4.SpecialCheck(var_280_0, arg_280_1)
	arg_280_2 = arg_280_2 == 1 and true or false

	if var_4:PlayGuide(arg_280_1, arg_280_2, arg_280_3) then
		nowWorld = var_5

		local var_280_1 = var_5()

		var_5.TriggerAutoFight(var_280_1, false)
	end

	return
end

function var_0_1.OpTaskGoto(arg_281_0, arg_281_1)
	arg_281_0:OpDone()

	nowWorld = var_2

	local var_281_0 = var_2()
	local var_281_1 = var_2.GetTaskProxy(var_281_0)
	local var_281_2 = var_3.getTaskById(var_281_1, arg_281_1)

	if var_3.GetFollowingAreaId(var_281_2) then
		arg_281_0:OpShowMarkOverview({
			mode = "Task",
			taskId = arg_281_1
		})
	elseif var_2:GetActiveEntrance().id ~= var_3:GetFollowingEntrance() then
		local var_281_3 = var_3:GetFollowingEntrance()
		local var_281_4 = var_2:GetAtlas()
		local var_281_5 = var_5.GetTaskDic(var_281_4, var_3.id)
		local var_281_6 = var_0_2

		var_6.QueryTransport(var_281_6, function()
			local var_282_0 = var_0_2
			local var_282_1 = var_0.EnterTransportWorld
			local var_282_2 = {}
			local var_282_3 = var_0

			var_282_2.entrance = var_4.GetEntrance(var_282_3, var_281_3)

			local var_282_4

			if not var_281_5[var_281_3] or not {
				"task_chapter"
			} then
				var_282_4 = {
					"complete_chapter",
					"base_chapter"
				}
			end

			var_282_2.mapTypes = var_282_4

			var_282_1(var_282_0, var_282_2)

			return
		end)
	else
		local var_281_7 = var_3.config.task_goto
		local var_281_8 = var_3.config.following_random
		local var_281_9 = var_2:GetActiveMap()
		local var_281_10 = #var_281_8

		if 0 < var_281_10 then
			_ = var_281_10

			if not var_281_10.any(var_281_8, function(arg_283_0)
				return arg_283_0 == var_281_9.id
			end) then
				pg = var_7

				local var_281_11 = var_7.TipsMgr.GetInstance()
				local var_281_12 = var_7.ShowTips

				i18n = var_1_10010

				var_281_12(var_281_11, var_1_10010("world_task_goto0"))

				return
			end
		end

		if not var_281_7[1] then
			return
		elseif var_281_7[1] == 1 then
			local var_281_13 = {}

			ipairs = var_8

			for iter_281_0, iter_281_1 in var_8(var_281_7[2]) do
				assert = var_1_10013
				pg = var_1_10015

				var_1_10013(var_1_10015.world_effect_data[iter_281_1], "without effect: " .. iter_281_1)

				table = var_1_10013

				var_1_10013.insert(var_281_13, function(arg_284_0)
					local var_284_0 = var_0_2
					local var_284_1 = var_1.NewMapOp
					local var_284_2 = {}

					WorldConst = var_2_10005
					var_284_2.op = var_2_10005.OpActionTaskGoto
					pg = var_5
					var_284_2.effect = var_5.world_effect_data[iter_281_1]

					local var_284_3 = var_284_1(var_284_0, var_284_2)
					local var_284_4 = arg_281_0

					var_2.OpTriggerEvent(var_284_4, var_284_3, arg_284_0)

					return
				end)
			end

			seriesAsync = var_8

			var_8(var_281_13, function()
				local var_285_0 = arg_281_0

				var_0.OpInteractive(var_285_0)

				return
			end)
		elseif var_281_7[1] == 2 then
			checkExist = var_7

			local var_281_14 = var_7(var_2:GetActiveMap(), {
				"GetPort"
			})

			var_1_10010 = var_2

			local var_281_15 = var_2.GetRealm(var_1_10010)

			checkExist = var_9

			if var_281_15 == var_9(var_281_14, {
				"GetRealm"
			}) then
				checkExist = var_9

				if var_9(var_281_14, {
					"IsOpen",
					{
						var_281_15,
						var_2:GetProgress()
					}
				}) then
					arg_281_0:OpRedeploy()

					goto label_281_0
				end
			end

			pg = var_9

			local var_281_16 = var_9.TipsMgr.GetInstance()
			local var_281_17 = var_9.ShowTips

			i18n = var_12

			var_281_17(var_281_16, var_12("world_instruction_redeploy_1"))

			return
		else
			local var_281_19

			if var_281_7[1] == 3 then
				pg = var_281_19

				local var_281_18 = var_281_19.TipsMgr.GetInstance()

				var_281_19 = var_281_19.ShowTips
				i18n = var_1_10010

				var_281_19(var_281_18, var_1_10010("world_task_goto3"))

				return
			else
				assert = var_281_19

				var_281_19(false, "goto info error:" .. var_281_7[1])

				return
			end
		end

		::label_281_0::
	end

	return
end

function var_0_1.OpShowAllFleetHealth(arg_286_0, arg_286_1)
	arg_286_0:OpDone()

	local var_286_0 = var_0_2

	if var_2.GetInMap(var_286_0) then
		ipairs = var_2

		for iter_286_0, iter_286_1 in var_2(var_0_2.wsMap.wsMapFleets) do
			iter_286_1:DisplayHealth()
		end
	end

	existCall = var_2

	return var_2(arg_286_1)
end

function var_0_1.OpAutoSubmitTask(arg_287_0, arg_287_1)
	local var_287_0 = var_0_2
	local var_287_1 = var_2.emit

	WorldMediator = var_1_10005

	var_287_1(var_287_0, var_1_10005.OnAutoSubmitTask, arg_287_1)

	return
end

function var_0_1.OpAutoSubmitTaskDone(arg_288_0, arg_288_1)
	arg_288_0:OpInteractive()

	return
end

function var_0_1.OpTrapGravityAnim(arg_289_0, arg_289_1, arg_289_2)
	local var_289_0 = var_0_2

	var_3.ClearMoveQueue(var_289_0)

	local var_289_1 = var_0_2.wsMap
	local var_289_2 = var_3.GetAttachment(var_289_1, arg_289_1.row, arg_289_1.column, arg_289_1.type)

	var_3.TrapAnimDisplay(var_289_2, function()
		local var_290_0 = arg_289_0

		var_0.OpDone(var_290_0)

		existCall = var_0

		var_0(arg_289_2)

		return
	end)

	return
end

function var_0_1.OpAutoFightSeach(arg_291_0)
	arg_291_0:OpDone()

	nowWorld = var_1

	local var_291_0 = var_1()
	local var_291_1 = var_1.GetActiveMap(var_291_0)
	local var_291_2 = var_2.GetFleet(var_291_1)
	local var_291_3 = var_2:GetLongMoveRange(var_291_2)
	local var_291_4
	local var_291_5 = 0

	ipairs = var_7

	for iter_291_0, iter_291_1 in var_7(var_291_3) do
		var_1_10014 = var_2
		var_1_10014 = var_2.GetCell(var_1_10014, iter_291_1.row, iter_291_1.column)
		var_1_10013 = var_12.GetEventAttachment(var_1_10014) and var_12:GetEventAutoPri()

		if var_1_10013 and var_291_5 < var_1_10013 and var_2:CheckEventAutoTrigger(var_12) then
			var_291_4 = iter_291_1
			var_291_5 = var_1_10013
		end
	end

	if var_291_4 then
		arg_291_0:OpLongMoveFleet(var_291_2, var_291_4.row, var_291_4.column)
	elseif var_291_2:IsCatSalvage() then
		local var_291_6 = var_291_3[1]

		arg_291_0:OpLongMoveFleet(var_291_2, var_291_6.row, var_291_6.column)
	else
		local var_291_7 = {}
		local var_291_8 = false
		local var_291_9

		if var_1.isAutoSwitch then
			var_291_9 = {
				event_1 = {
					"auto_switch_wait",
					"world_planning_stop_event"
				},
				event_2 = {
					"auto_switch_wait_2",
					"world_planning_stop_event2"
				},
				event_3 = {
					nil,
					"world_planning_stop_event3"
				}
			}

			local var_291_10 = var_2
			local var_291_11 = var_2.FindAttachments

			WorldMapAttachment = var_1_10013

			local var_291_12 = var_291_11(var_291_10, var_1_10013.TypeEvent)

			local function var_291_13(arg_292_0)
				if arg_292_0[1] then
					PlayerPrefs = var_1

					if var_1.GetInt(arg_292_0[1], 0) == 0 then
						do return false end

						goto label_292_0
					end
				end

				do
					local var_292_0 = {}

					ipairs = var_2_10002
					pg = var_2_10004

					for iter_292_0, iter_292_1 in var_2_10002(var_2_10004.gameset[arg_292_0[2]].description) do
						var_292_0[iter_292_1] = true
					end

					underscore = var_2

					return var_2.any(var_291_12, function(arg_293_0)
						local var_293_0

						if arg_293_0:IsAlive() then
							var_293_0 = var_292_0[arg_293_0.id]
						end

						return var_293_0
					end)
				end

				::label_292_0::

				return
			end

			switch = var_291_10
			PlayerPrefs = var_1_10014

			local var_291_14 = var_1_10014.GetInt("auto_switch_mode", 0)
			local var_291_15 = {}

			WorldSwitchPlanningLayer = var_16
			var_291_15[var_16.MODE_DIFFICULT] = function()
				local var_294_0

				if var_0.isPressing then
					underscore = var_294_0
					var_294_0 = not var_294_0.any({
						"event_1",
						"event_2"
					}, function(arg_295_0)
						return var_291_13(var_291_9[arg_295_0])
					end)
				end

				var_291_8 = var_294_0

				return
			end
			WorldSwitchPlanningLayer = var_16
			var_291_15[var_16.MODE_SAFE] = function()
				PlayerPrefs = var_2_10000

				if var_2_10000.GetString("auto_switch_difficult_safe", "only") == "only" then
					World = var_0

					local var_296_0 = var_0.ReplacementMapType
					local var_296_1 = var_0
					local var_296_2

					if var_296_0(var_2.GetActiveEntrance(var_296_1), var_0) ~= "base_chapter" then
						var_296_2 = false
					else
						var_296_2 = true
					end

					local var_296_3

					if var_0.isPressing and not var_296_2 then
						::label_296_0::

						underscore = var_296_3
						var_296_3 = not var_296_3.any({
							"event_1",
							"event_2"
						}, function(arg_297_0)
							return var_291_13(var_291_9[arg_297_0])
						end)
					end

					var_291_8 = var_296_3

					return
				end
			end
			WorldSwitchPlanningLayer = var_16
			var_291_15[var_16.MODE_TREASURE] = function()
				World = var_2_10000

				local var_298_0 = var_2_10000.ReplacementMapType
				local var_298_1 = var_0

				if not (var_298_0(var_2.GetActiveEntrance(var_298_1), var_0) ~= "teasure_chapter") then
					::label_298_0::

					underscore = var_2_10001
					var_2_10001 = not var_2_10001.any({
						"event_1",
						"event_3"
					}, function(arg_299_0)
						return var_291_13(var_291_9[arg_299_0])
					end)
				end

				var_291_8 = var_2_10001

				return
			end

			var_291_10(var_291_14, var_291_15)
		end

		if var_291_8 then
			table = var_291_9

			var_291_9.insert(var_291_7, function(arg_300_0)
				local var_300_0 = arg_291_0

				var_1.OpAutoSwitchMap(var_300_0, arg_300_0)

				return
			end)
		end

		seriesAsync = var_291_9

		var_291_9(var_291_7, function()
			pg = var_2_10000

			local var_301_0 = var_2_10000.TipsMgr.GetInstance()
			local var_301_1 = var_0.ShowTips

			i18n = var_2_10003

			var_301_1(var_301_0, var_2_10003("autofight_tip_bigworld_suspend"))

			local var_301_2 = var_0

			var_0.TriggerAutoFight(var_301_2, false)

			local var_301_3 = arg_291_0

			var_0.OpInteractive(var_301_3)

			return
		end)
	end

	return
end

function var_0_1.OpAutoSwitchMap(arg_302_0, arg_302_1)
	arg_302_0:OpDone()

	nowWorld = var_2

	local var_302_0 = var_2()
	local var_302_1 = var_2.GetAtlas(var_302_0)
	local var_302_2 = var_2:GetActiveEntrance()
	local var_302_3 = var_2:GetActiveMap()
	local var_302_4 = false
	local var_302_5
	local var_302_6

	switch = var_1_10009
	PlayerPrefs = var_1_10011

	local var_302_7 = var_1_10011.GetInt("auto_switch_mode", 0)
	local var_302_8 = {}

	WorldSwitchPlanningLayer = var_13
	var_302_8[var_13.MODE_DIFFICULT] = function()
		underscore = var_2_10000

		local var_303_0 = var_2_10000.values(var_302_1.entranceDic)

		table = var_2_10001

		local var_303_1 = var_2_10001.sort
		local var_303_2 = var_303_0

		CompareFuncs = var_2_10004

		var_303_1(var_303_2, var_2_10004({
			function(arg_304_0)
				local var_304_0 = arg_304_0:GetBaseMap()

				return var_1.GetDanger(var_304_0)
			end,
			function(arg_305_0)
				return arg_305_0.id
			end
		}))

		PlayerPrefs = var_303_1

		local var_303_3 = var_303_1.GetString("auto_switch_difficult_base", "all")

		ipairs = var_2

		for iter_303_0, iter_303_1 in var_2(var_303_0) do
			if var_302_1.transportDic[iter_303_1.id] then
				local var_303_4 = iter_303_1:GetBaseMap()

				if var_7.GetPressingLevel(var_303_4) > 0 and not var_7.isPressing and var_7:IsMapOpen() then
					WorldSwitchPlanningLayer = var_8

					if var_8.checkDifficultValid(var_303_3, var_7:GetDanger()) and not var_302_5 then
						var_302_5, var_302_6 = var_7, iter_303_1

						break
					end
				end
			end
		end

		return
	end
	WorldSwitchPlanningLayer = var_13
	var_302_8[var_13.MODE_SAFE] = function()
		PlayerPrefs = var_2_10000

		local var_306_0 = var_2_10000.GetString("auto_switch_difficult_safe", "only")

		switch = var_2_10001

		var_2_10001(var_306_0, {
			all = function()
				local var_307_0 = var_0
				local var_307_1 = var_0.GetActiveEntrance(var_307_0)
				local var_307_2 = {}

				pairs = var_307_0

				for iter_307_0, iter_307_1 in var_307_0(var_302_1.entranceDic) do
					if iter_307_1 ~= var_307_1 and var_302_1.transportDic[iter_307_1.id] and iter_307_1:GetBaseMap().isPressing and #iter_307_1.config.complete_chapter > 0 then
						local var_307_3 = var_0
						local var_307_4 = var_7.GetMap(var_307_3, iter_307_1.config.complete_chapter[1])

						if var_7.IsMapOpen(var_307_4) then
							table = var_8

							var_8.insert(var_307_2, {
								iter_307_1,
								var_7
							})
						end
					end
				end

				if #var_307_2 > 0 then
					unpack = var_2
					math = var_4

					local var_307_5 = var_4.floor

					math = iter_307_1
					var_302_6, var_302_5 = var_2(var_307_2[var_307_5(iter_307_1.random() * #var_307_2) + 1])
				end

				return
			end,
			only = function()
				var_302_6 = var_302_2

				local var_308_0 = var_302_6
				local var_308_1 = var_0.GetBaseMapId(var_308_0)
				local var_308_2 = var_302_6.config.complete_chapter[1]

				assert = var_308_0

				var_308_0(var_308_1 and var_308_2)

				if var_302_3.id == var_308_1 then
					local var_308_3 = var_0

					var_302_5 = var_2.GetMap(var_308_3, var_308_2)
				elseif var_302_3.id == var_308_2 then
					local var_308_4 = var_0

					var_302_5 = var_2.GetMap(var_308_4, var_308_1)
				else
					assert = var_2

					var_2(false)
				end

				return
			end
		})

		return
	end
	WorldSwitchPlanningLayer = var_13
	var_302_8[var_13.MODE_TREASURE] = function()
		World = var_2_10000

		if var_2_10000.ReplacementMapType(var_302_2, var_302_3) == "teasure_chapter" then
			var_302_4 = true

			return
		end

		underscore = var_0

		local var_309_0 = var_0.map
		local var_309_1 = var_0
		local var_309_2 = var_2.GetInventoryProxy(var_309_1)
		local var_309_3 = var_2.GetItemsByType

		WorldItem = var_2_10005

		local var_309_4 = var_309_0(var_309_3(var_309_2, var_2_10005.UsageWorldMap), function(arg_310_0)
			return arg_310_0.id
		end)

		underscore = var_2_10001

		local var_309_5 = var_2_10001.filter(var_309_4, function(arg_311_0)
			pg = var_3_10001

			return var_3_10001.world_item_data_template[arg_311_0].usage_arg[1] ~= 1
		end)

		underscore = var_1

		local var_309_6 = var_1.map(var_309_5, function(arg_312_0)
			local var_312_0 = var_0
			local var_312_1 = var_1.FindTreasureEntrance(var_312_0, arg_312_0)
			local var_312_2

			ipairs = var_312_0

			for iter_312_0, iter_312_1 in var_312_0(var_312_1.config.teasure_chapter) do
				if arg_312_0 == iter_312_1[1] then
					var_312_2 = iter_312_1[2]

					break
				end
			end

			local var_312_3 = {}
			local var_312_4 = var_0

			var_312_3[1] = var_4.GetMap(var_312_4, var_312_2)
			var_312_3[2] = var_312_1

			return var_312_3
		end)

		table = var_2

		local var_309_7 = var_2.sort
		local var_309_8 = var_309_6

		CompareFuncs = var_5

		var_309_7(var_309_8, var_5({
			function(arg_313_0)
				local var_313_0 = arg_313_0[1]

				return var_1.GetDanger(var_313_0)
			end,
			function(arg_314_0)
				return arg_314_0[1].id
			end
		}))

		PlayerPrefs = var_309_7

		local var_309_9 = var_309_7.GetString("auto_switch_difficult_treasure", "all")

		ipairs = var_3

		for iter_309_0, iter_309_1 in var_3(var_309_6) do
			unpack = var_309_10

			local var_309_10, var_309_11 = var_309_10(iter_309_1)

			if var_302_1.transportDic[var_309_11.id] and var_309_10:IsMapOpen() then
				WorldSwitchPlanningLayer = var_10

				if var_10.checkDifficultValid(var_309_9, var_309_10:GetDanger()) and not var_302_5 then
					var_302_5, var_302_6 = var_309_10, var_309_11

					break
				end
			end
		end

		return
	end

	var_1_10009(var_302_7, var_302_8)

	if var_302_4 then
		arg_302_0:OpReqJumpOut(var_302_3.gid, true)
	elseif not var_302_5 then
		var_2:TriggerAutoSwitch(false)

		pg = var_9

		local var_302_9 = var_9.TipsMgr.GetInstance()
		local var_302_10 = var_9.ShowTips

		i18n = var_12

		var_302_10(var_302_9, var_12("world_automode_start_tip1"))

		existCall = var_302_10

		return var_302_10(arg_302_1)
	else
		local var_302_13

		if not var_302_5.isCost then
			local var_302_11 = var_2.staminaMgr

			if var_302_13.GetTotalStamina(var_302_11) < var_302_5.config.enter_cost then
				var_2:TriggerAutoSwitch(false)

				pg = var_302_13

				local var_302_12 = var_302_13.TipsMgr.GetInstance()

				var_302_13 = var_302_13.ShowTips
				i18n = var_12

				var_302_13(var_302_12, var_12("world_automode_start_tip2"))

				existCall = var_302_13

				do return var_302_13(arg_302_1) end

				goto label_302_0
			end
		end

		nowWorld = var_302_13

		local var_302_14 = var_302_13()

		var_9.TriggerAutoSwitch(var_302_14, true)

		if var_302_5.active then
			nowWorld = var_9

			local var_302_15 = var_9()

			var_9.TriggerAutoFight(var_302_15, true)
			arg_302_0:OpSetInMap(true)
		else
			arg_302_0:OpTransport(var_302_6, var_302_5)
		end
	end

	::label_302_0::

	return
end

return var_0_1
