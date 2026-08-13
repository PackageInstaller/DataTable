class = var_0_10000

local var_0_0 = "BattleFailTipMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.CHAPTER_RETREAT = "BattleFailTipMediator:CHAPTER_RETREAT"
var_0_1.GO_NAVALTACTICS = "BattleFailTipMediator:GO_NAVALTACTICS"
var_0_1.GO_HIGEST_CHAPTER = "BattleFailTipMediator:GO_HIGEST_CHAPTER"
var_0_1.GO_DOCKYARD_EQUIP = "BattleFailTipMediator:GO_DOCKYARD_EQUIP"
var_0_1.GO_DOCKYARD_SHIP = "BattleFailTipMediator:GO_DOCKYARD_SHIP"

function var_0_1.register(arg_1_0)
	arg_1_0:initData()
	arg_1_0:bindEvent()

	return
end

function var_0_1.initData(arg_2_0)
	arg_2_0.mainShips = arg_2_0.contextData.mainShips
	arg_2_0.battleSystem = arg_2_0.contextData.battleSystem

	return
end

function var_0_1.bindEvent(arg_3_0)
	arg_3_0:bind(var_0_1.CHAPTER_RETREAT, function(arg_4_0, arg_4_1)
		getProxy = var_2_10002
		ChapterProxy = var_2_10004

		local var_4_0 = var_2_10002(var_2_10004)
		local var_4_1 = var_2.getActiveChapter(var_4_0)
		local var_4_2

		if var_4_1 then
			var_4_2 = var_4_1:getShips()
		else
			var_4_2 = arg_3_0.mainShips
		end

		local var_4_3 = {}

		ipairs = var_2_10006

		for iter_4_0, iter_4_1 in var_2_10006(var_4_2) do
			var_4_3[#var_4_3 + 1] = iter_4_1.id
		end

		arg_3_0.tempShipIDList = var_4_3

		local var_4_4 = arg_3_0
		local var_4_5 = var_6.sendNotification

		GAME = iter_4_0

		local var_4_6 = iter_4_0.CHAPTER_OP
		local var_4_7 = {}

		ChapterConst = var_2_10011
		var_4_7.type = var_2_10011.OpRetreat

		var_4_5(var_4_4, var_4_6, var_4_7)

		return
	end)
	arg_3_0:bind(var_0_1.GO_HIGEST_CHAPTER, function(arg_5_0)
		local var_5_0 = arg_3_0

		var_1.removeContextBeforeGO(var_5_0)

		getProxy = var_1
		ChapterProxy = var_5_0

		local var_5_1 = var_1(var_5_0)
		local var_5_2, var_5_3 = var_1.getHigestClearChapterAndMap(var_5_1)
		local var_5_4 = arg_3_0
		local var_5_5 = var_4.sendNotification

		GAME = var_2_10007

		local var_5_6 = var_2_10007.CHANGE_SCENE

		SCENE = var_2_10008

		var_5_5(var_5_4, var_5_6, var_2_10008.LEVEL, {
			targetChapter = var_5_2,
			targetMap = var_5_3
		})

		return
	end)
	arg_3_0:bind(var_0_1.GO_DOCKYARD_EQUIP, function(arg_6_0)
		local var_6_0 = arg_3_0

		var_1.removeContextBeforeGO(var_6_0)

		if not arg_3_0.tempShipIDList then
			local var_6_1 = {}

			ipairs = var_2_10002

			for iter_6_0, iter_6_1 in var_2_10002(arg_3_0.mainShips) do
				var_6_1[#var_6_1 + 1] = iter_6_1.id
			end

			arg_3_0.tempShipIDList = var_6_1
		end

		local var_6_2 = arg_3_0
		local var_6_3 = var_1.sendNotification

		GAME = var_2_10004

		local var_6_4 = var_2_10004.CHANGE_SCENE

		SCENE = iter_6_0

		local var_6_5 = iter_6_0.DOCKYARD
		local var_6_6 = {
			priorEquipUpShipIDList = arg_3_0.tempShipIDList
		}

		DockyardScene = var_7
		var_6_6.priorMode = var_7.PRIOR_MODE_EQUIP_UP
		DockyardScene = var_7
		var_6_6.mode = var_7.MODE_OVERVIEW

		function var_6_6.onClick(arg_7_0, arg_7_1)
			pg = var_3_10002

			local var_7_0 = var_3_10002.m02
			local var_7_1 = var_2.sendNotification

			GAME = var_3_10005

			local var_7_2 = var_3_10005.GO_SCENE

			SCENE = var_3_10006

			local var_7_3 = var_3_10006.SHIPINFO
			local var_7_4 = {
				openEquipUpgrade = true,
				shipId = arg_7_0.id,
				shipVOs = arg_7_1
			}

			ShipViewConst = var_8
			var_7_4.page = var_8.PAGE.EQUIPMENT

			var_7_1(var_7_0, var_7_2, var_7_3, var_7_4)

			return
		end

		var_6_3(var_6_2, var_6_4, var_6_5, var_6_6)

		return
	end)
	arg_3_0:bind(var_0_1.GO_DOCKYARD_SHIP, function(arg_8_0)
		local var_8_0 = arg_3_0

		var_1.removeContextBeforeGO(var_8_0)

		if not arg_3_0.tempShipIDList then
			local var_8_1 = {}

			ipairs = var_2_10002

			for iter_8_0, iter_8_1 in var_2_10002(arg_3_0.mainShips) do
				var_8_1[#var_8_1 + 1] = iter_8_1.id
			end

			arg_3_0.tempShipIDList = var_8_1
		end

		local var_8_2 = arg_3_0
		local var_8_3 = var_1.sendNotification

		GAME = var_2_10004

		local var_8_4 = var_2_10004.CHANGE_SCENE

		SCENE = iter_8_0

		local var_8_5 = iter_8_0.DOCKYARD
		local var_8_6 = {
			priorEquipUpShipIDList = arg_3_0.tempShipIDList
		}

		DockyardScene = var_7
		var_8_6.priorMode = var_7.PRIOR_MODE_SHIP_UP
		DockyardScene = var_7
		var_8_6.mode = var_7.MODE_OVERVIEW

		function var_8_6.onClick(arg_9_0, arg_9_1)
			pg = var_3_10002

			local var_9_0 = var_3_10002.m02
			local var_9_1 = var_2.sendNotification

			GAME = var_3_10005

			local var_9_2 = var_3_10005.GO_SCENE

			SCENE = var_3_10006

			local var_9_3 = var_3_10006.SHIPINFO
			local var_9_4 = {
				shipId = arg_9_0.id,
				shipVOs = arg_9_1
			}

			ShipViewConst = var_8
			var_9_4.page = var_8.PAGE.INTENSIFY

			var_9_1(var_9_0, var_9_2, var_9_3, var_9_4)

			return
		end

		var_8_3(var_8_2, var_8_4, var_8_5, var_8_6)

		return
	end)
	arg_3_0:bind(var_0_1.GO_NAVALTACTICS, function(arg_10_0)
		local var_10_0 = arg_3_0

		var_1.removeContextBeforeGO(var_10_0)

		local var_10_1 = arg_3_0
		local var_10_2 = var_1.sendNotification

		GAME = var_2_10004

		local var_10_3 = var_2_10004.CHANGE_SCENE

		SCENE = var_2_10005

		var_10_2(var_10_1, var_10_3, var_2_10005.NAVALTACTICS)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_11_0)
	local var_11_0 = {}

	GAME = var_1_10002
	var_11_0[1] = var_1_10002.CHAPTER_OP_DONE

	return var_11_0
end

function var_0_1.handleNotification(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_1.getName(var_12_0)
	local var_12_2 = arg_12_1
	local var_12_3 = arg_12_1.getBody(var_12_2)

	GAME = var_12_0

	if var_12_1 == var_12_0.CHAPTER_OP_DONE then
		local var_12_4 = arg_12_0.viewComponent.lastClickBtn

		BattleFailTipLayer = var_12_2

		local var_12_6

		if var_12_4 == var_12_2.PowerUpBtn.ShipLevelUp then
			getProxy = var_12_4
			ContextProxy = var_1_10006

			local var_12_5 = var_12_4(var_1_10006)

			var_12_6 = var_4.getContextByMediator
			LevelMediator2 = var_1_10008

			if var_12_6(var_12_5, var_1_10008) then
				var_1_10008 = var_12_6
				var_1_10006 = var_12_6.getContextByMediator
				ChapterPreCombatMediator = var_1_10009

				if var_1_10006(var_1_10008, var_1_10009) then
					var_1_10009 = var_12_6

					var_12_6.removeChild(var_1_10009, var_1_10006)
				end

				var_1_10009 = var_12_6

				local var_12_7 = var_12_6.getContextByMediator

				BattleResultMediator = var_1_10010

				if var_12_7(var_1_10009, var_1_10010) then
					var_1_10010 = var_12_6

					var_12_6.removeChild(var_1_10010, var_7)
				end
			end

			getProxy = var_1_10006
			ChapterProxy = var_1_10008
			var_1_10009 = var_1_10006(var_1_10008)

			local var_12_8

			var_12_8, var_1_10008 = var_1_10006.getHigestClearChapterAndMap(var_1_10009)

			local var_12_9 = arg_12_0

			var_1_10009 = arg_12_0.sendNotification
			GAME = var_1_10012

			var_1_10009(var_12_9, var_1_10012.GO_BACK, {
				targetChapter = var_12_8,
				targetMap = var_1_10008
			})
		else
			local var_12_10 = arg_12_0.viewComponent.lastClickBtn

			BattleFailTipLayer = var_12_6

			local var_12_12

			if var_12_10 == var_12_6.PowerUpBtn.EquipLevelUp then
				getProxy = var_12_10
				ContextProxy = var_1_10006

				local var_12_11 = var_12_10(var_1_10006)

				var_12_12 = var_4.getContextByMediator
				LevelMediator2 = var_1_10008

				if var_12_12(var_12_11, var_1_10008) then
					var_1_10008 = var_12_12
					var_1_10006 = var_12_12.getContextByMediator
					ChapterPreCombatMediator = var_1_10009

					if var_1_10006(var_1_10008, var_1_10009) then
						var_1_10009 = var_12_12

						var_12_12.removeChild(var_1_10009, var_1_10006)
					end

					var_1_10009 = var_12_12

					local var_12_13 = var_12_12.getContextByMediator

					BattleResultMediator = var_1_10010

					if var_12_13(var_1_10009, var_1_10010) then
						var_1_10010 = var_12_12

						var_12_12.removeChild(var_1_10010, var_7)
					end
				end

				var_1_10008 = arg_12_0
				var_1_10006 = arg_12_0.sendNotification
				GAME = var_1_10009
				var_1_10009 = var_1_10009.CHANGE_SCENE
				SCENE = var_1_10010
				var_1_10010 = var_1_10010.DOCKYARD

				local var_12_14 = {
					priorEquipUpShipIDList = arg_12_0.tempShipIDList
				}

				DockyardScene = var_12
				var_12_14.priorMode = var_12.PRIOR_MODE_EQUIP_UP
				DockyardScene = var_12
				var_12_14.mode = var_12.MODE_OVERVIEW

				function var_12_14.onClick(arg_13_0, arg_13_1)
					pg = var_2_10002

					local var_13_0 = var_2_10002.m02
					local var_13_1 = var_2.sendNotification

					GAME = var_2_10005

					local var_13_2 = var_2_10005.GO_SCENE

					SCENE = var_2_10006

					local var_13_3 = var_2_10006.SHIPINFO
					local var_13_4 = {
						openEquipUpgrade = true,
						shipId = arg_13_0.id,
						shipVOs = arg_13_1
					}

					ShipViewConst = var_8
					var_13_4.page = var_8.PAGE.EQUIPMENT

					var_13_1(var_13_0, var_13_2, var_13_3, var_13_4)

					return
				end

				var_1_10006(var_1_10008, var_1_10009, var_1_10010, var_12_14)
			else
				local var_12_15 = arg_12_0.viewComponent.lastClickBtn

				BattleFailTipLayer = var_12_12

				local var_12_17

				if var_12_15 == var_12_12.PowerUpBtn.SkillLevelUp then
					getProxy = var_12_15
					ContextProxy = var_1_10006

					local var_12_16 = var_12_15(var_1_10006)

					var_12_17 = var_4.getContextByMediator
					LevelMediator2 = var_1_10008

					if var_12_17(var_12_16, var_1_10008) then
						var_1_10008 = var_12_17
						var_1_10006 = var_12_17.getContextByMediator
						ChapterPreCombatMediator = var_1_10009

						if var_1_10006(var_1_10008, var_1_10009) then
							var_1_10009 = var_12_17

							var_12_17.removeChild(var_1_10009, var_1_10006)
						end

						var_1_10009 = var_12_17

						local var_12_18 = var_12_17.getContextByMediator

						BattleResultMediator = var_1_10010

						if var_12_18(var_1_10009, var_1_10010) then
							var_1_10010 = var_12_17

							var_12_17.removeChild(var_1_10010, var_7)
						end
					end

					var_1_10008 = arg_12_0
					var_1_10006 = arg_12_0.sendNotification
					GAME = var_1_10009
					var_1_10009 = var_1_10009.CHANGE_SCENE
					SCENE = var_1_10010

					var_1_10006(var_1_10008, var_1_10009, var_1_10010.NAVALTACTICS)
				else
					local var_12_19 = arg_12_0.viewComponent.lastClickBtn

					BattleFailTipLayer = var_12_17

					if var_12_19 == var_12_17.PowerUpBtn.ShipBreakUp then
						getProxy = var_12_19
						ContextProxy = var_1_10006

						local var_12_20 = var_12_19(var_1_10006)
						local var_12_21 = var_4.getContextByMediator

						LevelMediator2 = var_1_10008

						if var_12_21(var_12_20, var_1_10008) then
							local var_12_22 = var_5
							local var_12_23 = var_5.getContextByMediator

							ChapterPreCombatMediator = var_1_10009

							if var_12_23(var_12_22, var_1_10009) then
								var_1_10009 = var_5

								var_5.removeChild(var_1_10009, var_6)
							end

							var_1_10009 = var_5

							local var_12_24 = var_5.getContextByMediator

							BattleResultMediator = var_1_10010

							if var_12_24(var_1_10009, var_1_10010) then
								var_1_10010 = var_5

								var_5.removeChild(var_1_10010, var_7)
							end
						end

						local var_12_25 = arg_12_0
						local var_12_26 = arg_12_0.sendNotification

						GAME = var_1_10009

						local var_12_27 = var_1_10009.CHANGE_SCENE

						SCENE = var_1_10010

						local var_12_28 = var_1_10010.DOCKYARD
						local var_12_29 = {
							priorEquipUpShipIDList = arg_12_0.tempShipIDList
						}

						DockyardScene = var_12
						var_12_29.priorMode = var_12.PRIOR_MODE_SHIP_UP
						DockyardScene = var_12
						var_12_29.mode = var_12.MODE_OVERVIEW

						function var_12_29.onClick(arg_14_0, arg_14_1)
							pg = var_2_10002

							local var_14_0 = var_2_10002.m02
							local var_14_1 = var_2.sendNotification

							GAME = var_2_10005

							local var_14_2 = var_2_10005.GO_SCENE

							SCENE = var_2_10006

							local var_14_3 = var_2_10006.SHIPINFO
							local var_14_4 = {
								shipId = arg_14_0.id,
								shipVOs = arg_14_1
							}

							ShipViewConst = var_8
							var_14_4.page = var_8.PAGE.INTENSIFY

							var_14_1(var_14_0, var_14_2, var_14_3, var_14_4)

							return
						end

						var_12_26(var_12_25, var_12_27, var_12_28, var_12_29)
					end
				end
			end
		end

		arg_12_0.tempShipIDList = nil
	end

	return
end

function var_0_1.removeContextBeforeGO(arg_15_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)
	local var_15_1 = arg_15_0.battleSystem

	SYSTEM_SCENARIO = var_1_10003

	if var_15_1 == var_1_10003 then
		local var_15_2 = var_15_0

		var_1_10003 = var_15_0.getContextByMediator
		LevelMediator2 = var_1_10006

		if var_1_10003(var_15_2, var_1_10006) then
			var_1_10006 = var_1_10003

			local var_15_3 = var_1_10003.getContextByMediator

			ChapterPreCombatMediator = var_1_10007

			if var_15_3(var_1_10006, var_1_10007) then
				var_1_10007 = var_1_10003

				var_1_10003.removeChild(var_1_10007, var_4)
			end

			var_1_10007 = var_1_10003

			local var_15_4 = var_1_10003.getContextByMediator

			BattleResultMediator = var_1_10008

			if var_15_4(var_1_10007, var_1_10008) then
				var_1_10008 = var_1_10003

				var_1_10003.removeChild(var_1_10008, var_5)
			end
		end

		goto label_15_0
	end

	SYSTEM_ROUTINE = var_1_10003

	if var_15_1 ~= var_1_10003 then
		SYSTEM_SUB_ROUTINE = var_1_10003

		if var_15_1 == var_1_10003 then
			local var_15_5 = var_15_0

			var_1_10003 = var_15_0.getContextByMediator
			DailyLevelMediator = var_1_10006

			if var_1_10003(var_15_5, var_1_10006) then
				var_1_10006 = var_1_10003

				local var_15_6 = var_1_10003.getContextByMediator

				PreCombatMediator = var_1_10007

				if var_15_6(var_1_10006, var_1_10007) then
					var_1_10007 = var_1_10003

					var_1_10003.removeChild(var_1_10007, var_4)
				end

				var_1_10007 = var_1_10003

				local var_15_7 = var_1_10003.getContextByMediator

				BattleResultMediator = var_1_10008

				if var_15_7(var_1_10007, var_1_10008) then
					var_1_10008 = var_1_10003

					var_1_10003.removeChild(var_1_10008, var_5)
				end
			end
		else
			SYSTEM_DUEL = var_1_10003

			if var_15_1 == var_1_10003 then
				local var_15_8 = var_15_0

				var_1_10003 = var_15_0.getContextByMediator
				MilitaryExerciseMediator = var_1_10006

				if var_1_10003(var_15_8, var_1_10006) then
					var_1_10006 = var_1_10003

					local var_15_9 = var_1_10003.getContextByMediator

					ExercisePreCombatMediator = var_1_10007

					if var_15_9(var_1_10006, var_1_10007) then
						var_1_10003:removeChild(var_4)
					end

					local var_15_10 = var_1_10003
					local var_15_11 = var_1_10003.getContextByMediator

					BattleResultMediator = var_1_10008

					if var_15_11(var_15_10, var_1_10008) then
						var_1_10003:removeChild(var_5)
					end
				end
			else
				SYSTEM_HP_SHARE_ACT_BOSS = var_1_10003

				if var_15_1 == var_1_10003 then
					local var_15_12 = var_15_0
					local var_15_13 = var_15_0.getContextByMediator

					ActivityBossPreCombatMediator = var_1_10006

					local var_15_14, var_15_15 = var_15_13(var_15_12, var_1_10006)

					if var_15_14 then
						var_15_15:removeChild(var_15_14)
					end
				end
			end
		end

		::label_15_0::

		return
	end
end

return var_0_1
