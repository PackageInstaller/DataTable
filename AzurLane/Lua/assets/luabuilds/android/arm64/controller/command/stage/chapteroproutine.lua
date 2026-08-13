class = var_0_10000

local var_0_0 = "ChapterOpRoutine"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.initData(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.op = arg_1_1
	arg_1_0.data = arg_1_2
	arg_1_0.chapter = arg_1_3
	arg_1_0.items = {}
	arg_1_0.fullpath = nil
	arg_1_0.flag = 0
	arg_1_0.extraFlag = 0

	return
end

function var_0_1.doDropUpdate(arg_2_0)
	PlayerConst = var_1_10001
	arg_2_0.items = var_1_10001.addTranDrop(arg_2_0.data.drop_list)
	table = var_1

	local var_2_0 = var_1.insertto
	local var_2_1 = arg_2_0.items

	underscore = var_1_10004

	local var_2_2 = var_1_10004.map

	PlayerConst = var_1_10006

	var_2_0(var_2_1, var_2_2(var_1_10006.addTranDrop(arg_2_0.data.extra_drop_list), function(arg_3_0)
		arg_3_0.riraty = true

		return arg_3_0
	end))

	return
end

function var_0_1.doMapUpdate(arg_4_0)
	local var_4_0 = arg_4_0.data
	local var_4_1 = arg_4_0.flag
	local var_4_2 = arg_4_0.extraFlag
	local var_4_3 = arg_4_0.chapter

	if #var_4_0.map_update > 0 then
		_ = var_5

		var_5.each(var_4_0.map_update, function(arg_5_0)
			local var_5_0 = arg_5_0.item_type

			ChapterConst = var_2_10002

			if var_5_0 == var_2_10002.AttachStory then
				local var_5_1 = arg_5_0.item_data

				ChapterConst = var_2

				if var_5_1 == var_2.StoryTrigger then
					ChapterCell = var_5_1

					local var_5_2 = var_5_1.Line2Name(arg_5_0.pos.row, arg_5_0.pos.column)
					local var_5_3 = var_4_3

					if var_2.GetChapterCellAttachemnts(var_5_3)[var_5_2] then
						var_5_3 = var_3.flag
						ChapterConst = var_2_10005

						if var_5_3 == var_2_10005.CellFlagTriggerActive then
							var_5_3 = arg_5_0.item_flag
							ChapterConst = var_5

							if var_5_3 == var_5.CellFlagTriggerDisabled then
								pg = var_5_3

								if var_5_3.map_event_template[var_3.attachmentId].gametip ~= "" then
									pg = var_5

									local var_5_4 = var_5.TipsMgr.GetInstance()
									local var_5_5 = var_5.ShowTips

									i18n = var_2_10008

									var_5_5(var_5_4, var_2_10008(var_5_3))
								end
							end
						end

						var_3.attachment = arg_5_0.item_type
						var_3.attachmentId = arg_5_0.item_id
						var_3.flag = arg_5_0.item_flag
						var_3.data = arg_5_0.item_data
					else
						ChapterCell = var_5_3
						var_2[var_5_2] = var_5_3.New(arg_5_0)
					end

					goto label_5_0
				end
			end

			do
				local var_5_6 = arg_5_0.item_type

				ChapterConst = var_2

				if var_5_6 ~= var_2.AttachNone then
					local var_5_7 = arg_5_0.item_type

					ChapterConst = var_2

					if var_5_7 ~= var_2.AttachBorn then
						local var_5_8 = arg_5_0.item_type

						ChapterConst = var_2

						if var_5_8 ~= var_2.AttachBorn_Sub then
							ChapterCell = var_5_8

							local var_5_9 = var_5_8.New(arg_5_0)
							local var_5_10 = var_4_3

							var_2.mergeChapterCell(var_5_10, var_5_9)
						end
					end
				end
			end

			::label_5_0::

			return
		end)

		bit = var_5

		local var_4_4 = var_5.bor
		local var_4_5 = var_4_1

		ChapterConst = var_8
		var_4_1 = var_4_4(var_4_5, var_8.DirtyAttachment)
		bit = var_5

		local var_4_6 = var_5.bor
		local var_4_7 = var_4_2

		ChapterConst = var_8
		var_4_2 = var_4_6(var_4_7, var_8.DirtyAutoAction)
	end

	arg_4_0.flag = var_4_1
	arg_4_0.extraFlag = var_4_2

	return
end

function var_0_1.doCellFlagUpdate(arg_6_0)
	local var_6_0 = arg_6_0.data
	local var_6_1 = arg_6_0.flag
	local var_6_2 = arg_6_0.chapter

	if #var_6_0.cell_flag_list > 0 then
		_ = var_4

		var_4.each(var_6_0.cell_flag_list, function(arg_7_0)
			local var_7_0 = var_6_2
			local var_7_1

			if var_1.getChapterCell(var_7_0, arg_7_0.pos.row, arg_7_0.pos.column) then
				var_7_1:updateFlagList(arg_7_0)
			else
				ChapterCell = var_2_10002
				var_7_1 = var_2_10002.New(arg_7_0)
			end

			local var_7_2 = arg_6_0.chapter

			var_2.updateChapterCell(var_7_2, var_7_1)

			return
		end)

		bit = var_4

		local var_6_3 = var_4.bor
		local var_6_4 = var_6_1

		ChapterConst = var_7
		var_6_1 = var_6_3(var_6_4, var_7.DirtyCellFlag)
	end

	arg_6_0.flag = var_6_1

	return
end

function var_0_1.doAIUpdate(arg_8_0)
	local var_8_0 = arg_8_0.data
	local var_8_1 = arg_8_0.flag
	local var_8_2 = arg_8_0.extraFlag
	local var_8_3 = arg_8_0.chapter

	if #var_8_0.ai_list > 0 then
		_ = var_5

		var_5.each(var_8_0.ai_list, function(arg_9_0)
			ChapterChampionPackage = var_2_10001

			local var_9_0 = var_2_10001.New(arg_9_0)
			local var_9_1 = var_8_3

			var_2.mergeChampion(var_9_1, var_9_0)

			return
		end)

		bit = var_5

		local var_8_4 = var_5.bor
		local var_8_5 = var_8_1

		ChapterConst = var_8
		var_8_1 = var_8_4(var_8_5, var_8.DirtyChampion)
		bit = var_5

		local var_8_6 = var_5.bor
		local var_8_7 = var_8_2

		ChapterConst = var_8
		var_8_2 = var_8_6(var_8_7, var_8.DirtyAutoAction)
	end

	arg_8_0.flag = var_8_1
	arg_8_0.extraFlag = var_8_2

	return
end

function var_0_1.doShipUpdate(arg_10_0)
	local var_10_0 = arg_10_0.data
	local var_10_1 = arg_10_0.flag
	local var_10_2 = arg_10_0.chapter

	if #var_10_0.ship_update > 0 then
		_ = var_4

		var_4.each(var_10_0.ship_update, function(arg_11_0)
			local var_11_0 = var_10_2

			var_1.updateFleetShipHp(var_11_0, arg_11_0.id, arg_11_0.hp_rant)

			bit = var_1

			local var_11_1 = var_1.bor
			local var_11_2 = var_10_1

			ChapterConst = var_4
			var_10_1 = var_11_1(var_11_2, var_4.DirtyStrategy)

			return
		end)

		bit = var_4

		local var_10_3 = var_4.bor
		local var_10_4 = var_10_1

		ChapterConst = var_7
		var_10_1 = var_10_3(var_10_4, var_7.DirtyFleet)
	end

	arg_10_0.flag = var_10_1

	return
end

function var_0_1.doBuffUpdate(arg_12_0)
	local var_12_0 = arg_12_0.data
	local var_12_1 = arg_12_0.chapter

	var_2.UpdateBuffList(var_12_1, var_12_0.buff_list)

	return
end

function var_0_1.doExtraFlagUpdate(arg_13_0)
	local var_13_0 = arg_13_0.data
	local var_13_1 = arg_13_0.chapter

	getProxy = var_1_10003
	ChapterProxy = var_1_10005

	local var_13_2 = var_1_10003(var_1_10005)

	if #var_13_0.add_flag_list > 0 or #var_13_0.del_flag_list > 0 then
		var_13_2:updateExtraFlag(var_13_1, var_13_0.add_flag_list, var_13_0.del_flag_list)

		bit = var_4

		local var_13_3 = var_4.bor
		local var_13_4 = arg_13_0.flag

		ChapterConst = var_7

		local var_13_5 = var_7.DirtyFleet

		ChapterConst = var_8

		local var_13_6 = var_8.DirtyStrategy

		ChapterConst = var_9

		local var_13_7 = var_9.DirtyCellFlag

		ChapterConst = var_1_10010

		local var_13_8 = var_1_10010.DirtyFloatItems

		ChapterConst = var_1_10011
		arg_13_0.flag = var_13_3(var_13_4, var_13_5, var_13_6, var_13_7, var_13_8, var_1_10011.DirtyAttachment)
	end

	return
end

function var_0_1.doRetreat(arg_14_0)
	local var_14_0 = arg_14_0.op
	local var_14_1 = arg_14_0.flag
	local var_14_2 = arg_14_0.chapter

	if var_14_0.id then
		if #var_14_2.fleets > 0 then
			var_14_2:retreatFleet(var_14_0.id)

			bit = var_4

			local var_14_3 = var_4.bor
			local var_14_4 = var_14_1

			ChapterConst = var_7

			local var_14_5 = var_7.DirtyFleet

			ChapterConst = var_1_10008

			local var_14_6 = var_1_10008.DirtyAttachment

			ChapterConst = var_1_10009

			local var_14_7 = var_1_10009.DirtyChampion

			ChapterConst = var_1_10010
			var_14_1 = var_14_3(var_14_4, var_14_5, var_14_6, var_14_7, var_1_10010.DirtyStrategy)
		end
	else
		var_14_2:retreat(var_14_0.win)
	end

	arg_14_0.flag = var_14_1

	return
end

function var_0_1.doMove(arg_15_0)
	local var_15_0 = arg_15_0.extraFlag
	local var_15_1 = arg_15_0.data
	local var_15_2 = arg_15_0.chapter
	local var_15_3

	if #var_15_1.move_path > 0 then
		_ = var_5

		local var_15_4 = var_5.map

		_ = var_1_10007
		var_15_3 = var_15_4(var_1_10007.rest(var_15_1.move_path, 1), function(arg_16_0)
			return {
				row = arg_16_0.row,
				column = arg_16_0.column
			}
		end)
		var_15_2.moveStep = var_15_2.moveStep + #var_15_1.move_path
		bit = var_5

		local var_15_5 = var_5.bor
		local var_15_6 = var_15_0

		ChapterConst = var_8

		local var_15_7 = var_8.DirtyAutoAction

		ChapterConst = var_9
		var_15_0 = var_15_5(var_15_6, var_15_7, var_9.DirtyWeather)
	end

	arg_15_0.fullpath = var_15_3

	var_15_2:IncreaseRound()

	arg_15_0.extraFlag = var_15_0

	return
end

function var_0_1.doOpenBox(arg_17_0)
	local var_17_0 = arg_17_0.items
	local var_17_1 = arg_17_0.flag
	local var_17_2 = arg_17_0.chapter.fleet.line
	local var_17_3 = var_3:getChapterCell(var_17_2.row, var_17_2.column)

	ChapterConst = var_1_10007
	var_17_3.flag = var_1_10007.CellFlagDisabled
	bit = var_7

	local var_17_4 = var_7.bor
	local var_17_5 = var_17_1

	ChapterConst = var_10

	local var_17_6 = var_17_4(var_17_5, var_10.DirtyAttachment)

	pg = var_7

	local var_17_7 = var_7.box_data_template[var_17_3.attachmentId]

	assert = var_8

	var_8(var_17_7, "box_data_template not exist: " .. var_17_3.attachmentId)

	local var_17_8 = var_17_7.type

	ChapterConst = var_17_5

	local var_17_10

	if var_17_8 == var_17_5.BoxStrategy then
		local var_17_9 = var_17_7.effect_id

		var_17_10 = var_17_7.effect_arg

		var_4:achievedStrategy(var_17_9, var_17_10)

		table = var_10

		local var_17_11 = var_10.insert
		local var_17_12 = var_17_0

		Drop = var_13

		local var_17_13 = var_13.New
		local var_17_14 = {}

		DROP_TYPE_STRATEGY = var_1_10016
		var_17_14.type = var_1_10016
		var_17_14.id = var_17_9
		var_17_14.count = var_17_10

		var_17_11(var_17_12, var_17_13(var_17_14))

		bit = var_17_11

		local var_17_15 = var_17_11.bor
		local var_17_16 = var_17_6

		ChapterConst = var_13
		var_17_6 = var_17_15(var_17_16, var_13.DirtyStrategy)
	else
		local var_17_17 = var_17_7.type

		ChapterConst = var_17_10

		if var_17_17 == var_17_10.BoxSupply then
			local var_17_18, var_17_19 = var_3:getFleetAmmo(var_4)
			local var_17_20 = var_4.restAmmo

			math = var_11
			var_4.restAmmo = var_17_20 + var_11.min(var_17_18 - var_17_19, var_17_7.effect_id)
			bit = var_10

			local var_17_21 = var_10.bor
			local var_17_22 = var_17_6

			ChapterConst = var_13
			var_17_6 = var_17_21(var_17_22, var_13.DirtyFleet)
			pg = var_10

			local var_17_23 = var_10.TipsMgr.GetInstance()
			local var_17_24 = var_10.ShowTips

			i18n = var_13

			var_17_24(var_17_23, var_13("level_ammo_supply_p1", var_17_7.effect_id))
		end
	end

	var_3:clearChapterCell(var_17_2.row, var_17_2.column)

	arg_17_0.flag = var_17_6
	bit = var_8

	local var_17_25 = var_8.bor
	local var_17_26 = arg_17_0.extraFlag

	ChapterConst = var_11
	arg_17_0.extraFlag = var_17_25(var_17_26, var_11.DirtyAutoAction)

	return
end

function var_0_1.doPlayStory(arg_18_0)
	local var_18_0 = arg_18_0.flag
	local var_18_1 = arg_18_0.chapter.fleet.line
	local var_18_2 = var_2:getChapterCell(var_18_1.row, var_18_1.column)

	ChapterConst = var_1_10006
	var_18_2.flag = var_1_10006.CellFlagDisabled

	var_2:updateChapterCell(var_18_2)

	bit = var_6

	local var_18_3 = var_6.bor
	local var_18_4 = var_18_0

	ChapterConst = var_9
	arg_18_0.flag = var_18_3(var_18_4, var_9.DirtyAttachment)

	return
end

function var_0_1.doAmbush(arg_19_0)
	local var_19_0 = arg_19_0.op
	local var_19_1 = arg_19_0.chapter.fleet

	if var_19_0.arg1 == 1 then
		local var_19_2 = var_19_1.line
		local var_19_3 = var_2
		local var_19_4 = var_2.getChapterCell(var_19_3, var_19_2.row, var_19_2.column).flag

		ChapterConst = var_19_3

		if var_19_4 == var_19_3.CellFlagAmbush then
			var_2:clearChapterCell(var_19_2.row, var_19_2.column)
		end

		pg = var_19_4

		local var_19_5 = var_19_4.TipsMgr.GetInstance()
		local var_19_6 = var_6.ShowTips
		local var_19_7 = var_5.flag

		ChapterConst = var_1_10010

		if var_19_7 == var_1_10010.CellFlagActive then
			i18n = var_19_7

			if not var_19_7("chapter_tip_aovid_failed") then
				i18n = var_19_7
				var_19_7 = var_19_7("chapter_tip_aovid_succeed")
			end

			var_19_6(var_19_5, var_19_7)

			return
		end
	end
end

function var_0_1.doStrategy(arg_20_0)
	local var_20_0 = arg_20_0.flag
	local var_20_1 = arg_20_0.op
	local var_20_2 = arg_20_0.chapter

	pg = var_1_10004

	local var_20_3 = var_1_10004.strategy_data_template[var_20_1.arg1].type

	ChapterConst = var_1_10006

	local var_20_4

	if var_20_3 == var_1_10006.StgTypeForm then
		var_20_3 = var_20_2.fleet
		ipairs = var_20_4

		for iter_20_0, iter_20_1 in var_20_4(var_20_3.stgIds) do
			pg = var_1_10011
			var_1_10011 = var_1_10011.strategy_data_template[iter_20_1].type
			ChapterConst = var_1_10012

			if var_1_10011 == var_1_10012.StgTypeForm then
				var_1_10011 = var_20_3.stgIds
				var_1_10011[iter_20_0] = var_4.id
			end
		end

		PlayerPrefs = var_20_4

		var_20_4.SetInt("team_formation_" .. var_20_3.id, var_4.id)

		pg = var_20_4
		var_1_10008 = var_20_4.TipsMgr.GetInstance()
		var_20_4 = var_20_4.ShowTips
		i18n = var_9

		var_20_4(var_1_10008, var_9("chapter_tip_change", var_4.name))

		goto label_20_0
	end

	var_20_3 = var_4.type
	ChapterConst = var_20_4

	if var_20_3 == var_20_4.StgTypeConsume then
		var_1_10008 = var_20_2.fleet

		var_20_3.consumeOneStrategy(var_1_10008, var_4.id)

		local var_20_5 = var_4.id

		ChapterConst = var_1_10007

		if var_20_5 ~= var_1_10007.StrategyRepair then
			var_20_5 = var_4.id
			ChapterConst = var_7

			if var_20_5 == var_7.StrategyExchange then
				pg = var_20_5
				var_1_10008 = var_20_5.TipsMgr.GetInstance()
				var_20_5 = var_20_5.ShowTips
				i18n = var_9

				var_20_5(var_1_10008, var_9("chapter_tip_use", var_4.name))
			end

			var_20_5 = var_4.id
			ChapterConst = var_7

			if var_20_5 == var_7.StrategyExchange then
				var_1_10008 = var_20_2
				var_20_5 = var_20_2.getFleetById(var_1_10008, var_20_1.id)
				var_1_10008 = var_20_2:getFleetById(var_20_1.arg2).line
				var_7.line = var_20_5.line
				var_20_5.line = var_1_10008
				bit = var_1_10008
				var_1_10008 = var_1_10008.bor

				local var_20_6 = var_20_0

				ChapterConst = var_1_10011
				var_20_0 = var_1_10008(var_20_6, var_1_10011.DirtyFleet)
			end

			if false then
				var_20_3 = var_4.type
				ChapterConst = var_20_5

				if var_20_3 == var_20_5.StgTypeBindSupportConsume then
					var_1_10008 = var_20_2:getChapterSupportFleet()

					var_20_3.consumeOneStrategy(var_1_10008, var_4.id)
				end
			end

			::label_20_0::

			bit = var_20_3

			local var_20_7 = var_20_3.bor
			local var_20_8 = var_20_0

			ChapterConst = var_1_10008
			arg_20_0.flag = var_20_7(var_20_8, var_1_10008.DirtyStrategy)

			return
		end
	end
end

function var_0_1.doRepair(arg_21_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10003
	var_1.repairTimes = var_1_10001(var_1_10003).repairTimes + 1
	ChapterConst = var_2

	local var_21_0, var_21_1, var_21_2 = var_2.GetRepairParams()

	if var_21_0 < var_1.repairTimes then
		getProxy = var_5
		PlayerProxy = var_1_10007

		local var_21_3 = var_5(var_1_10007)
		local var_21_4 = var_5.getData(var_21_3)

		var_6.consume(var_21_4, {
			gem = var_21_2
		})
		var_5:updatePlayer(var_6)
	end

	return
end

function var_0_1.doSupply(arg_22_0)
	local var_22_0 = arg_22_0.flag
	local var_22_1 = arg_22_0.chapter.fleet
	local var_22_2, var_22_3 = var_2:getFleetAmmo(var_22_1)
	local var_22_4 = var_22_1.line
	local var_22_5 = var_2:getChapterCell(var_22_4.row, var_22_4.column)

	math = var_1_10008

	local var_22_6 = var_1_10008.min(var_22_5.attachmentId, var_22_2 - var_22_3)

	var_22_5.attachmentId = var_22_5.attachmentId - var_22_6
	var_22_1.restAmmo = var_22_1.restAmmo + var_22_6

	var_2:updateChapterCell(var_22_5)

	local var_22_8

	if var_22_5.attachmentId > 20 then
		pg = var_22_8

		local var_22_7 = var_22_8.TipsMgr.GetInstance()

		var_22_8 = var_22_8.ShowTips
		i18n = var_12

		var_22_8(var_22_7, var_12("level_ammo_supply_p1", var_22_6))
	elseif var_22_5.attachmentId > 0 then
		pg = var_22_8

		local var_22_9 = var_22_8.TipsMgr.GetInstance()

		var_22_8 = var_22_8.ShowTips
		i18n = var_12

		var_22_8(var_22_9, var_12("level_ammo_supply", var_22_6, var_22_5.attachmentId))
	else
		pg = var_22_8

		local var_22_10 = var_22_8.TipsMgr.GetInstance()

		var_22_8 = var_22_8.ShowTips
		i18n = var_12

		var_22_8(var_22_10, var_12("level_ammo_empty", var_22_6))
	end

	bit = var_22_8

	local var_22_11 = var_22_8.bor
	local var_22_12 = var_22_0

	ChapterConst = var_12

	local var_22_13 = var_12.DirtyAttachment

	ChapterConst = var_1_10013
	arg_22_0.flag = var_22_11(var_22_12, var_22_13, var_1_10013.DirtyFleet)

	return
end

function var_0_1.doSubState(arg_23_0)
	local var_23_0 = arg_23_0.flag
	local var_23_1 = arg_23_0.op

	arg_23_0.chapter.subAutoAttack = var_23_1.arg1
	bit = var_4

	local var_23_2 = var_4.bor
	local var_23_3 = var_23_0

	ChapterConst = var_1_10007
	arg_23_0.flag = var_23_2(var_23_3, var_1_10007.DirtyStrategy)

	return
end

function var_0_1.doCollectAI(arg_24_0)
	local var_24_0 = arg_24_0.data
	local var_24_1

	if not arg_24_0.aiActs then
		var_24_1 = {}
	end

	arg_24_0.aiActs = var_24_1

	if var_24_0.submarine_act_list then
		_ = var_2

		var_2.each(var_24_0.submarine_act_list, function(arg_25_0)
			table = var_2_10001

			local var_25_0 = var_2_10001.insert
			local var_25_1 = arg_24_0.aiActs

			SubAIAction = var_2_10004

			var_25_0(var_25_1, var_2_10004.New(arg_25_0))

			return
		end)
	end

	if var_24_0.escort_act_list then
		_ = var_2

		var_2.each(var_24_0.escort_act_list, function(arg_26_0)
			table = var_2_10001

			local var_26_0 = var_2_10001.insert
			local var_26_1 = arg_24_0.aiActs

			TransportAIAction = var_2_10004

			var_26_0(var_26_1, var_2_10004.New(arg_26_0))

			return
		end)
	end

	_ = var_2

	var_2.each(var_24_0.ai_act_list, function(arg_27_0)
		local var_27_0
		local var_27_1 = arg_27_0.act_type

		ChapterConst = var_2_10003

		if var_27_1 == var_2_10003.ActType_TargetDown then
			var_27_1 = arg_24_0.op.type
			ChapterConst = var_3

			if var_27_1 == var_3.OpStrategy then
				var_27_1 = arg_24_0.op.arg1
				ChapterConst = var_3

				if var_27_1 == var_3.StrategyMissileStrike then
					ChapterMissileExplodeAction = var_27_1
					var_27_0 = var_27_1.New(arg_27_0)
				else
					var_27_1 = arg_24_0.op.arg1
					ChapterConst = var_3

					if var_27_1 == var_3.StrategyAirSupport then
						ChapterAirSupportAIAction = var_27_1
						var_27_0 = var_27_1.New(arg_27_0)
					end
				end

				var_27_0:SetTargetLine({
					row = arg_24_0.op.arg2,
					column = arg_24_0.op.arg3
				})
			else
				ChapterMissileExplodeAction = var_27_1
				var_27_0 = var_27_1.New(arg_27_0)
			end
		else
			var_27_1 = arg_27_0.act_type
			ChapterConst = var_3

			if var_27_1 == var_3.ActType_Expel then
				ChapterExpelAIAction = var_27_1

				local var_27_2 = var_27_1.New(arg_27_0)

				var_27_0.SetTargetLine(var_27_2, {
					row = arg_24_0.op.arg2,
					column = arg_24_0.op.arg3
				}, {
					row = arg_24_0.op.arg4,
					column = arg_24_0.op.arg5
				})
			else
				ChapterAIAction = var_27_1
				var_27_0 = var_27_1.New(arg_27_0)
			end
		end

		table = var_27_1

		var_27_1.insert(arg_24_0.aiActs, var_27_0)

		return
	end)

	_ = var_2

	var_2.each(var_24_0.fleet_act_list, function(arg_28_0)
		table = var_2_10001

		local var_28_0 = var_2_10001.insert
		local var_28_1 = arg_24_0.aiActs

		FleetAIAction = var_2_10004

		var_28_0(var_28_1, var_2_10004.New(arg_28_0))

		return
	end)

	return
end

function var_0_1.doBarrier(arg_29_0)
	local var_29_0 = arg_29_0.flag
	local var_29_1 = arg_29_0.op
	local var_29_2 = arg_29_0.chapter
	local var_29_3 = var_3.getChapterCell(var_29_2, var_29_1.arg1, var_29_1.arg2)

	assert = var_1_10005

	var_1_10005(var_29_3, "cell not exist: " .. var_29_1.arg1 .. ", " .. var_29_1.arg2)

	ChapterConst = var_1_10005

	local var_29_4 = var_1_10005.AttachBox

	_ = var_29_2

	local var_29_5 = var_29_2.detect

	pg = var_8

	local var_29_6 = var_29_5(var_8.box_data_template.all, function(arg_30_0)
		pg = var_2_10001

		local var_30_0 = var_2_10001.box_data_template[arg_30_0].type

		ChapterConst = var_2_10002

		return var_30_0 == var_2_10002.BoxBarrier
	end)

	if var_29_3.attachment ~= var_29_4 or var_29_3.attachmentId ~= var_29_6 then
		var_29_3.attachment = var_29_4
		var_29_3.attachmentId = var_29_6
		ChapterConst = var_7
		var_29_3.flag = var_7.CellFlagDisabled
	end

	local var_29_7 = var_3.modelCount
	local var_29_8 = var_29_3.flag

	ChapterConst = var_9
	var_3.modelCount = var_29_7 + (var_29_8 == var_9.CellFlagDisabled and -1 or 1)
	var_29_3.flag = 1 - var_29_3.flag

	var_3:updateChapterCell(var_29_3)

	bit = var_7

	local var_29_9 = var_7.bor
	local var_29_10 = var_29_0

	ChapterConst = var_10

	local var_29_11 = var_10.DirtyAttachment

	ChapterConst = var_11
	arg_29_0.flag = var_29_9(var_29_10, var_29_11, var_11.DirtyStrategy)

	return
end

function var_0_1.doRequest(arg_31_0)
	local var_31_0 = arg_31_0.data
	local var_31_1 = -1
	local var_31_2 = arg_31_0.chapter.fleet

	if #var_31_0.move_path > 0 then
		local var_31_3 = var_31_0.move_path[#var_31_0.move_path]

		var_31_2.line = {
			row = var_31_3.row,
			column = var_31_3.column
		}
	end

	arg_31_0.flag = var_31_1

	return
end

function var_0_1.doSkipBattle(arg_32_0)
	local var_32_0 = arg_32_0.flag

	bit = var_1_10002

	local var_32_1 = var_1_10002.bor
	local var_32_2 = var_32_0

	ChapterConst = var_1_10005

	local var_32_3 = var_1_10005.DirtyStrategy

	ChapterConst = var_1_10006

	local var_32_4 = var_1_10006.DirtyAttachment

	ChapterConst = var_1_10007

	local var_32_5 = var_1_10007.DirtyAchieve

	ChapterConst = var_1_10008

	local var_32_6 = var_1_10008.DirtyFleet

	ChapterConst = var_1_10009
	arg_32_0.flag = var_32_1(var_32_2, var_32_3, var_32_4, var_32_5, var_32_6, var_1_10009.DirtyChampion)

	return
end

function var_0_1.doTeleportSub(arg_33_0)
	local var_33_0 = arg_33_0.op
	local var_33_1 = arg_33_0.chapter

	_ = var_1_10003

	local var_33_2 = var_1_10003.detect(var_33_1.fleets, function(arg_34_0)
		return arg_34_0.id == var_33_0.id
	end).startPos

	arg_33_0.fullpath = {
		var_33_2,
		{
			row = var_33_0.arg1,
			column = var_33_0.arg2
		}
	}

	return
end

function var_0_1.doEnemyRound(arg_35_0)
	local var_35_0 = arg_35_0.chapter
	local var_35_1 = arg_35_0.extraFlag

	var_35_0:IncreaseRound()

	local var_35_2 = var_35_0:getPlayType()

	ChapterConst = var_1_10004

	if var_35_2 == var_1_10004.TypeDefence then
		bit = var_35_2
		var_35_2 = var_35_2.bor

		local var_35_3 = arg_35_0.flag

		ChapterConst = var_1_10006
		arg_35_0.flag = var_35_2(var_35_3, var_1_10006.DirtyAttachment)
	end

	bit = var_35_2

	local var_35_4 = var_35_2.bor
	local var_35_5 = var_35_1

	ChapterConst = var_1_10006
	arg_35_0.extraFlag = var_35_4(var_35_5, var_1_10006.DirtyAutoAction)

	return
end

function var_0_1.doTeleportByPortal(arg_36_0)
	local var_36_0

	if arg_36_0.fullpath then
		var_36_0 = arg_36_0.fullpath[#arg_36_0.fullpath]
	end

	if not var_36_0 then
		return
	end

	local var_36_1 = arg_36_0.chapter
	local var_36_2
	local var_36_3 = arg_36_0.op.type

	ChapterConst = var_1_10005

	if var_36_3 == var_1_10005.OpMove then
		var_1_10006 = var_36_1
		var_36_2 = var_36_1.GetCellEventByKey(var_1_10006, "jump", var_36_0.row, var_36_0.column)
	else
		local var_36_4 = arg_36_0.op.type

		ChapterConst = var_5

		if var_36_4 == var_5.OpSubTeleport then
			var_1_10006 = var_36_1
			var_36_2 = var_36_1.GetCellEventByKey(var_1_10006, "jumpsub", var_36_0.row, var_36_0.column)
		end
	end

	if not var_36_2 then
		return
	end

	local var_36_5 = {
		row = var_36_2[1],
		column = var_36_2[2]
	}
	local var_36_6 = arg_36_0.op.type

	ChapterConst = var_1_10006

	if var_36_6 == var_1_10006.OpMove then
		local var_36_7 = var_36_1
		local var_36_8 = var_36_1.getFleet

		FleetType = var_1_10008

		if var_36_8(var_36_7, var_1_10008.Normal, var_36_5.row, var_36_5.column) then
			return
		end
	end

	local var_36_9

	if not arg_36_0.teleportPaths then
		var_36_9 = {}
	end

	arg_36_0.teleportPaths = var_36_9
	table = var_36_9

	var_36_9.insert(arg_36_0.teleportPaths, {
		row = var_36_0.row,
		column = var_36_0.column
	})

	table = var_5

	var_5.insert(arg_36_0.teleportPaths, var_36_5)

	return
end

function var_0_1.doCollectCommonAction(arg_37_0)
	local var_37_0

	if not arg_37_0.aiActs then
		var_37_0 = {}
	end

	arg_37_0.aiActs = var_37_0
	table = var_37_0

	local var_37_1 = var_37_0.insert
	local var_37_2 = arg_37_0.aiActs

	ChapterCommonAction = var_1_10004

	var_37_1(var_37_2, var_1_10004.New(arg_37_0))

	return
end

function var_0_1.AddBoxAction(arg_38_0)
	local var_38_0 = arg_38_0.chapter.fleet.line
	local var_38_1 = var_1:getChapterCell(var_38_0.row, var_38_0.column)

	pg = var_1_10005

	local var_38_2 = var_1_10005.box_data_template[var_38_1.attachmentId]

	assert = var_6

	var_6(var_38_2, "box_data_template not exist: " .. var_38_1.attachmentId)

	local var_38_3 = var_38_2.type

	ChapterConst = var_7

	if var_38_3 == var_7.BoxStrategy then
		local var_38_4 = var_38_2.effect_id
		local var_38_5 = var_38_2.effect_arg

		table = var_8

		local var_38_6 = var_8.insert
		local var_38_7 = arg_38_0.items

		Drop = var_1_10011

		local var_38_8 = var_1_10011.New
		local var_38_9 = {}

		DROP_TYPE_STRATEGY = var_1_10014
		var_38_9.type = var_1_10014
		var_38_9.id = var_38_4
		var_38_9.count = var_38_5

		var_38_6(var_38_7, var_38_8(var_38_9))
	end

	local var_38_10

	if not arg_38_0.aiActs then
		var_38_10 = {}
	end

	arg_38_0.aiActs = var_38_10
	table = var_38_10

	local var_38_11 = var_38_10.insert
	local var_38_12 = arg_38_0.aiActs

	ChapterBoxAction = var_9

	var_38_11(var_38_12, var_9.New(arg_38_0))

	return
end

return var_0_1
