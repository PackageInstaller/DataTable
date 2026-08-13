class = var_0_10000

local var_0_0 = var_0_10000("ShipStatus")

var_0_0.flagList = {
	"inChapter",
	"inFleet",
	"inElite",
	"inActivity",
	"inPvP",
	"inExercise",
	"inEvent",
	"inClass",
	"inTactics",
	"inBackyard",
	"inAdmiral",
	"inWorld",
	"isActivityNpc",
	"inGuildEvent",
	"inGuildBossEvent",
	"inChallenge",
	"inSupport"
}

function var_0_0.checkShipFlag(arg_1_0, arg_1_1, arg_1_2)
	defaultValue = var_1_10003

	local var_1_0 = var_1_10003(arg_1_1[arg_1_2], var_0_0.TAG_HIDE_BASE[arg_1_2])

	type = var_1_10004

	local var_1_1

	if var_1_10004(var_1_0) == "boolean" then
		var_1_1 = not var_1_0 and arg_1_0:getFlag(arg_1_2)

		return var_1_1
	else
		type = var_1_1

		if var_1_1(var_1_0) == "number" then
			return arg_1_0:getFlag(arg_1_2, var_1_0)
		else
			assert = var_4

			var_4(false, "type error")
		end
	end

	return
end

function var_0_0.ShipStatusToTag(arg_2_0, arg_2_1)
	if var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inChapter") then
		local var_2_0 = {
			"shipstatus",
			"red"
		}

		i18n = var_1_10003
		var_2_0[3] = var_1_10003("word_status_inFight")

		return var_2_0
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inFleet") then
		getProxy = var_2
		FleetProxy = var_4

		local var_2_1 = var_2(var_4)

		var_1_10003 = var_2.GetRegularFleetByShip(var_2_1, arg_2_0)
		assert = var_4

		var_4(var_1_10003)

		local var_2_2 = var_1_10003.id

		if var_1_10003:isRegularFleet() then
			math = var_5
			var_2_2 = var_5.fmod(var_2_2, 10)

			return {
				"ui/dockyardui_atlas",
				"biandui0" .. var_2_2,
				""
			}
		else
			local var_2_3 = {
				"shipstatus",
				"red"
			}

			Fleet = var_6
			var_2_3[3] = var_6.DEFAULT_NAME_FOR_DOCKYARD[var_2_2]

			return var_2_3
		end
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inElite") then
		local var_2_4 = {
			"shipstatus",
			"red"
		}

		i18n = var_1_10003
		var_2_4[3] = var_1_10003("word_status_inHardFormation")

		return var_2_4
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inSupport") then
		local var_2_5 = {
			"shipstatus",
			"red"
		}

		i18n = var_1_10003
		var_2_5[3] = var_1_10003("word_status_inSupportFleet")

		return var_2_5
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inActivity") then
		local var_2_6 = {
			"shipstatus",
			"red"
		}

		i18n = var_1_10003
		var_2_6[3] = var_1_10003("word_status_activity")

		return var_2_6
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inChallenge") then
		local var_2_7 = {
			"shipstatus",
			"red"
		}

		i18n = var_1_10003
		var_2_7[3] = var_1_10003("word_status_challenge")

		return var_2_7
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inPvP") then
		local var_2_8 = {
			"shipstatus",
			"red"
		}

		i18n = var_1_10003
		var_2_8[3] = var_1_10003("word_status_inPVP")

		return var_2_8
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inEvent") then
		local var_2_9 = {
			"shipstatus",
			"green"
		}

		i18n = var_1_10003
		var_2_9[3] = var_1_10003("word_status_inEvent")

		return var_2_9
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inBackyard") then
		getProxy = var_2
		DormProxy = var_4

		local var_2_10 = var_2(var_4)
		local var_2_11 = var_2.getRawData(var_2_10)
		local var_2_12

		var_1_10003, var_2_12 = var_2.InBackYard(var_2_11, arg_2_0.id)

		if var_1_10003 then
			DormShip = var_2_11

			if var_2_12 == var_2_11.FLOOR_2 then
				var_2_11 = {
					"shipstatus",
					"purple"
				}
				i18n = var_6
				var_2_11[3] = var_6("word_status_rest")

				do return var_2_11 end

				goto label_2_0
			end
		end

		if var_1_10003 then
			DormShip = var_2_11

			if var_2_12 == var_2_11.FLOOR_1 then
				local var_2_13 = {
					"shipstatus",
					"purple"
				}

				i18n = var_6
				var_2_13[3] = var_6("word_status_train")

				return var_2_13
			end
		end
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inClass") then
		local var_2_14 = {
			"shipstatus",
			"blue"
		}

		i18n = var_1_10003
		var_2_14[3] = var_1_10003("word_status_inClass")

		return var_2_14
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inTactics") then
		local var_2_15 = {
			"shipstatus",
			"blue"
		}

		i18n = var_1_10003
		var_2_15[3] = var_1_10003("word_status_inTactics")

		return var_2_15
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inAdmiral") then
		local var_2_16 = {
			"shipstatus",
			"light_green"
		}

		i18n = var_1_10003
		var_2_16[3] = var_1_10003("common_flag_ship")

		return var_2_16
	else
		local var_2_17

		if var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inWorld") then
			var_2_17 = {
				"shipstatus",
				"red"
			}
			i18n = var_1_10003
			var_2_17[3] = var_1_10003("word_status_world")

			return var_2_17
		else
			getProxy = var_2_17
			SettingsProxy = var_4

			local var_2_18 = var_2_17(var_4)

			if var_2.IsRandomFlagShip(var_2_18, arg_2_0:GetShipPhantomMark()) then
				local var_2_19 = {
					"shipstatus",
					"light_yellow"
				}

				i18n = var_1_10003
				var_2_19[3] = var_1_10003("random_flag_ship")

				return var_2_19
			end
		end
	end

	::label_2_0::

	return
end

var_0_0.FILTER_SHIPS_FLAGS_1 = {
	inExercise = false,
	inChapter = true,
	inSupport = true,
	inFleet = false,
	inPvP = false,
	inActivity = true,
	inTactics = false,
	inElite = false,
	inGuildEvent = true,
	inEvent = true,
	inBackyard = false,
	inClass = true,
	isActivityNpc = true,
	inChallenge = true,
	inWorld = true,
	inAdmiral = true
}
var_0_0.FILTER_SHIPS_FLAGS_2 = {
	inElite = true,
	inChallenge = true,
	inPvP = true,
	inSupport = true,
	inClass = true,
	inActivity = true,
	inGuildEvent = true,
	isActivityNpc = true,
	inWorld = true,
	inAdmiral = true,
	inExercise = true,
	inChapter = true,
	inFleet = true,
	inGuildBossEvent = true,
	inTactics = true,
	inBackyard = true,
	inEvent = true
}
var_0_0.FILTER_SHIPS_FLAGS_3 = {
	inExercise = false,
	inChapter = true,
	inSupport = true,
	inFleet = false,
	inPvP = false,
	inActivity = true,
	inTactics = false,
	inElite = false,
	inGuildEvent = true,
	inEvent = true,
	inBackyard = false,
	inClass = true,
	isActivityNpc = true,
	inChallenge = true,
	inWorld = true,
	inAdmiral = false
}
var_0_0.FILTER_SHIPS_FLAGS_4 = {
	inElite = true,
	inChallenge = true,
	inGuildBossEvent = true,
	inSupport = true,
	inClass = true,
	inActivity = true,
	inGuildEvent = true,
	isActivityNpc = true,
	inWorld = true,
	inAdmiral = true,
	inExercise = true,
	inChapter = true,
	inFleet = true,
	inPvP = true,
	inTactics = true,
	inBackyard = true,
	inEvent = true
}
var_0_0.TAG_HIDE_ALL = {
	inExercise = true,
	inChallenge = true,
	inChapter = true,
	inFleet = true,
	inPvP = true,
	inActivity = true,
	inTactics = true,
	inElite = true,
	inClass = true,
	inEvent = true,
	inBackyard = true,
	isActivityNpc = true,
	inWorld = true,
	inAdmiral = true
}
var_0_0.TAG_HIDE_BASE = {
	inExercise = true,
	inChallenge = false,
	inChapter = false,
	inSupport = false,
	inPvP = false,
	inActivity = false,
	inTactics = false,
	inElite = true,
	inClass = false,
	inEvent = false,
	inFleet = false,
	inBackyard = false,
	isActivityNpc = false,
	inWorld = false,
	inAdmiral = false
}
var_0_0.TAG_HIDE_ACTIVITY_BOSS = {
	inChapter = true,
	inChallenge = true,
	inClass = true,
	inFleet = true,
	inPvP = true,
	inAdmiral = true,
	inTactics = true,
	inBackyard = true
}
var_0_0.TAG_HIDE_BACKYARD = {
	inExercise = false,
	inChallenge = true,
	inChapter = true,
	inEvent = true,
	inPvP = true,
	inActivity = true,
	inTactics = true
}
var_0_0.TAG_HIDE_PVP = {
	inExercise = false,
	inChapter = true,
	inChallenge = true,
	inFleet = true,
	inClass = true,
	inActivity = true,
	inTactics = true,
	inBackyard = true,
	inPvP = true
}
var_0_0.TAG_HIDE_DEFENSE = {
	inExercise = false,
	inChapter = true,
	inChallenge = true,
	inFleet = true,
	inClass = true,
	inActivity = true,
	inTactics = true,
	inBackyard = true,
	inPvP = true,
	inEvent = true
}
var_0_0.TAG_HIDE_LEVEL = {
	inAdmiral = true,
	inChallenge = true,
	inFleet = true,
	inClass = true,
	inActivity = true,
	inTactics = true,
	inBackyard = true
}
var_0_0.TAG_HIDE_SUPPORT = {
	inAdmiral = true,
	inChallenge = true,
	inClass = true,
	inActivity = true,
	inTactics = true,
	inBackyard = true
}
var_0_0.TAG_HIDE_NORMAL = {
	inExercise = false,
	inChallenge = true,
	inClass = true,
	inPvP = true,
	inActivity = true,
	inTactics = true,
	inBackyard = true
}
var_0_0.TAG_HIDE_CHALLENGE = {
	inClass = true,
	inChapter = true,
	inFleet = true,
	inPvP = true,
	inActivity = true,
	inTactics = true,
	inBackyard = true,
	inEvent = false,
	inAdmiral = true
}
var_0_0.TAG_HIDE_EVENT = {
	inExercise = false,
	inChallenge = true,
	inClass = true,
	inActivity = true,
	inTactics = true,
	inBackyard = true
}
var_0_0.TAG_HIDE_TACTICES = {
	inExercise = false,
	inChapter = true,
	inChallenge = true,
	inFleet = true,
	inClass = true,
	inActivity = true,
	inTactics = true,
	inBackyard = true,
	inPvP = true,
	inEvent = true
}
var_0_0.TAG_HIDE_ADMIRAL = {
	inExercise = false,
	inChapter = true,
	inChallenge = true,
	inFleet = true,
	inClass = true,
	inActivity = true,
	inTactics = true,
	inBackyard = true,
	inPvP = true,
	inEvent = true
}
var_0_0.TAG_HIDE_FORMATION = {
	inExercise = false,
	inChallenge = true,
	inClass = true,
	inPvP = true,
	inActivity = true,
	inTactics = true,
	inBackyard = true
}
var_0_0.TAG_HIDE_WORLD = {
	inChallenge = true,
	inActivity = true,
	inFleet = true
}
var_0_0.TAG_HIDE_DESTROY = {
	inElite = false
}
var_0_0.TAG_BLOCK_EVENT = {
	inEvent = true
}
var_0_0.TAG_BLOCK_PVP = {
	inEvent = true
}
var_0_0.TAG_BLOCK_BACKYARD = {
	inClass = true
}
var_0_0.STATE_CHANGE_OK = -1
var_0_0.STATE_CHANGE_FAIL = 0
var_0_0.STATE_CHANGE_CHECK = 1

local var_0_1 = {
	inFleet = {
		inSupport = 1,
		inEvent = 0
	},
	inSupport = {
		inFleet = 0,
		inEvent = 0
	},
	inElite = {
		inElite = 0,
		inEvent = 0
	},
	inActivity = {
		inEvent = 0
	},
	inChallenge = {
		isActivityNpc = 0,
		inEvent = 0
	},
	inEvent = {
		inChapter = 0,
		inEvent = 0,
		inFleet = 1,
		inSupport = 0,
		isActivityNpc = 0,
		inPvP = 1
	},
	inClass = {
		isActivityNpc = 0,
		inClass = 0,
		inBackyard = 1
	},
	inTactics = {
		inTactics = 0
	},
	inBackyard = {
		inClass = 0,
		isActivityNpc = 0
	},
	inWorld = {
		isActivityNpc = 0
	},
	onPropose = {
		inEvent = 0,
		inChapter = 0
	},
	onModify = {
		inChapter = 0
	},
	onDestroy = {
		inExercise = 1,
		inChallenge = 0,
		inFleet = 1,
		inSupport = 0,
		inClass = 0,
		inActivity = 0,
		inTactics = 1,
		inBackyard = 1,
		inGuildEvent = 0,
		inEvent = 0,
		inChapter = 0,
		inPvP = 1,
		isActivityNpc = 0,
		inGuildBossEvent = 1,
		inWorld = 0,
		inAdmiral = 0
	},
	onTeamChange = {
		inExercise = 1,
		inChallenge = 0,
		inChapter = 0,
		inFleet = 1,
		inPvP = 1,
		inActivity = 0,
		inWorld = 1,
		inGuildBossEvent = 1
	}
}
local var_0_2 = {
	inChapter = {
		tips_block = "word_shipState_fight"
	},
	inFleet = {
		tips_block = "word_shipState_fight"
	},
	inElite = {
		tips_block = "word_shipState_fight"
	},
	inActivity = {
		tips_block = "shipmodechange_reject_inactivity"
	},
	inChallenge = {
		tips_block = "shipmodechange_reject_inchallenge"
	},
	inPvP = {
		tips_block = "word_shipState_fight"
	},
	inExercise = {
		tips_block = "word_shipState_fight"
	},
	inEvent = {
		tips_block = "word_shipState_event"
	},
	inClass = {
		tips_block = "word_shipState_study"
	},
	inTactics = {
		tips_block = "word_shipState_tactics"
	},
	inBackyard = {
		tips_block = "word_shipState_rest"
	},
	inAdmiral = {
		tips_block = "playerinfo_ship_is_already_flagship"
	},
	inGuildEvent = {
		tips_block = "word_shipState_guild_event"
	},
	inGuildBossEvent = {
		tips_block = "word_shipState_guild_event"
	},
	isActivityNpc = {
		tips_block = "word_shipState_npc"
	},
	inWorld = {
		tips_block = "word_shipState_world"
	},
	inSupport = {
		tips_block = "word_shipState_support"
	}
}

function var_0_0.ShipStatusCheck(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0, var_3_1 = var_0_0.ShipStatusConflict(arg_3_0, arg_3_1, arg_3_3)

	if var_3_0 == var_0_0.STATE_CHANGE_FAIL then
		local var_3_2 = false

		i18n = var_7

		local var_3_3 = var_7(var_3_1)

		return
	elseif var_3_0 == var_0_0.STATE_CHANGE_CHECK then
		if arg_3_2 then
			return var_0_0.ChangeStatusCheckBox(var_3_1, arg_3_1, arg_3_2)
		else
			return false
		end
	elseif var_3_0 == var_0_0.STATE_CHANGE_OK then
		return true
	else
		assert = var_6

		var_6(false, "unknow error")
	end

	return
end

function var_0_0.ShipStatusConflict(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_1[arg_4_0]

	arg_4_2 = arg_4_2 or {}
	ipairs = var_1_10004

	for iter_4_0, iter_4_1 in var_1_10004(var_0_0.flagList) do
		if var_4_0[iter_4_1] == var_0_0.STATE_CHANGE_FAIL and arg_4_1:getFlag(iter_4_1, arg_4_2[iter_4_1]) then
			return var_0_0.STATE_CHANGE_FAIL, var_0_2[iter_4_1].tips_block
		end
	end

	ipairs = var_4

	for iter_4_2, iter_4_3 in var_4(var_0_0.flagList) do
		if var_4_0[iter_4_3] == var_0_0.STATE_CHANGE_CHECK and arg_4_1:getFlag(iter_4_3, arg_4_2[iter_4_3]) then
			return var_0_0.STATE_CHANGE_CHECK, iter_4_3
		end
	end

	return var_0_0.STATE_CHANGE_OK
end

function var_0_0.ChangeStatusCheckBox(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0 == "inBackyard" then
		pg = var_1_10003
		var_1_10005 = var_1_10003.MsgboxMgr.GetInstance()
		var_1_10003 = var_1_10003.ShowMsgBox

		local var_5_0 = {}

		i18n = var_1_10007
		var_5_0.content = var_1_10007("ship_vo_moveout_backyard")

		function var_5_0.onYes()
			pg = var_2_10000

			local var_6_0 = var_2_10000.m02
			local var_6_1 = var_0.sendNotification

			GAME = var_2_10003

			var_6_1(var_6_0, var_2_10003.EXIT_SHIP, {
				callback = arg_5_2,
				shipId = arg_5_1.id
			})

			return
		end

		var_1_10003(var_1_10005, var_5_0)

		return false, nil
	elseif arg_5_0 == "inFleet" then
		pg = var_1_10003
		var_1_10005 = var_1_10003.MsgboxMgr.GetInstance()
		var_1_10003 = var_1_10003.ShowMsgBox

		local var_5_1 = {}

		i18n = var_1_10007
		var_5_1.content = var_1_10007("shipchange_alert_infleet")

		function var_5_1.onYes()
			getProxy = var_2_10000
			FleetProxy = var_2_10002

			local var_7_0 = var_2_10000(var_2_10002)
			local var_7_1 = var_0.GetRegularFleetByShip(var_7_0, arg_5_1)
			local var_7_3

			if var_0.canRemove(var_7_1, arg_5_1) then
				var_0:removeShip(arg_5_1)

				pg = var_7_3

				local var_7_2 = var_7_3.m02

				var_7_3 = var_7_3.sendNotification
				GAME = var_4

				var_7_3(var_7_2, var_4.UPDATE_FLEET, {
					callback = arg_5_2,
					fleet = var_0
				})
			else
				pg = var_7_3

				local var_7_4 = var_7_3.TipsMgr.GetInstance()
				local var_7_5 = var_1.ShowTips

				i18n = var_4

				var_7_5(var_7_4, var_4("shipmodechange_reject_1stfleet_only"))
			end

			return
		end

		var_1_10003(var_1_10005, var_5_1)

		return false, nil
	elseif arg_5_0 == "inSupport" then
		pg = var_1_10003
		var_1_10005 = var_1_10003.MsgboxMgr.GetInstance()
		var_1_10003 = var_1_10003.ShowMsgBox

		local var_5_2 = {}

		i18n = var_1_10007
		var_5_2.content = var_1_10007("ship_formationMediator_request_replace_support")

		function var_5_2.onYes()
			pg = var_2_10000

			local var_8_0 = var_2_10000.m02
			local var_8_1 = var_0.sendNotification

			GAME = var_2_10003

			var_8_1(var_8_0, var_2_10003.REMOVE_ELITE_TARGET_SHIP, {
				shipId = arg_5_1.id,
				callback = arg_5_2
			})

			return
		end

		var_1_10003(var_1_10005, var_5_2)

		return false, nil
	elseif arg_5_0 == "inPvP" then
		pg = var_1_10003
		var_1_10005 = var_1_10003.MsgboxMgr.GetInstance()
		var_1_10003 = var_1_10003.ShowMsgBox

		local var_5_3 = {}

		i18n = var_1_10007
		var_5_3.content = var_1_10007("shipchange_alert_inpvp")

		function var_5_3.onYes()
			getProxy = var_2_10000
			FleetProxy = var_2_10002

			local var_9_0 = var_2_10000(var_2_10002)
			local var_9_1 = var_0.getFleetById

			FleetProxy = var_2_10003

			local var_9_2 = var_9_1(var_9_0, var_2_10003.PVP_FLEET_ID)

			if var_0.canRemove(var_9_2, arg_5_1) then
				var_0:removeShip(arg_5_1)

				pg = var_1

				local var_9_3 = var_1.m02
				local var_9_4 = var_1.sendNotification

				GAME = var_4

				var_9_4(var_9_3, var_4.UPDATE_FLEET, {
					callback = arg_5_2,
					fleet = var_0
				})
			else
				local var_9_5 = arg_5_1
				local var_9_6 = var_1.getTeamType(var_9_5)

				TeamType = var_9_0

				local var_9_8

				if var_9_6 == var_9_0.Vanguard then
					pg = var_9_8

					local var_9_7 = var_9_8.TipsMgr.GetInstance()

					var_9_8 = var_9_8.ShowTips
					i18n = var_2_10005

					var_9_8(var_9_7, var_2_10005("ship_vo_vanguardFleet_must_hasShip"))
				else
					TeamType = var_9_8

					if var_9_6 == var_9_8.Main then
						pg = var_2

						local var_9_9 = var_2.TipsMgr.GetInstance()
						local var_9_10 = var_2.ShowTips

						i18n = var_2_10005

						var_9_10(var_9_9, var_2_10005("ship_vo_mainFleet_must_hasShip"))
					end
				end
			end

			return
		end

		var_1_10003(var_1_10005, var_5_3)

		return false, nil
	elseif arg_5_0 == "inExercise" then
		getProxy = var_1_10003
		MilitaryExerciseProxy = var_1_10005

		local var_5_4 = var_1_10003(var_1_10005)

		var_1_10007 = var_1_10003.getExerciseFleet(var_5_4)

		if var_4.canRemove(var_1_10007, arg_5_1) then
			pg = var_1_10005
			var_1_10007 = var_1_10005.MsgboxMgr.GetInstance()
			var_1_10005 = var_1_10005.ShowMsgBox

			local var_5_5 = {}

			i18n = var_1_10009
			var_5_5.content = var_1_10009("shipchange_alert_inexercise")

			function var_5_5.onYes()
				local var_10_0 = var_0

				var_0.removeShip(var_10_0, arg_5_1)

				pg = var_0

				local var_10_1 = var_0.m02
				local var_10_2 = var_0.sendNotification

				GAME = var_3

				var_10_2(var_10_1, var_3.UPDATE_EXERCISE_FLEET, {
					fleet = var_0,
					callback = arg_5_2
				})

				return
			end

			var_1_10005(var_1_10007, var_5_5)
		else
			pg = var_1_10005
			var_1_10007 = var_1_10005.MsgboxMgr.GetInstance()
			var_1_10005 = var_1_10005.ShowMsgBox

			local var_5_6 = {}

			i18n = var_1_10009
			var_5_6.content = var_1_10009("exercise_clear_fleet_tip")

			function var_5_6.onYes()
				local var_11_0 = var_0

				var_0.removeShip(var_11_0, arg_5_1)

				pg = var_0

				local var_11_1 = var_0.m02
				local var_11_2 = var_0.sendNotification

				GAME = var_3

				var_11_2(var_11_1, var_3.UPDATE_EXERCISE_FLEET, {
					fleet = var_0,
					callback = arg_5_2
				})

				return
			end

			var_1_10005(var_1_10007, var_5_6)
		end

		return false, nil
	elseif arg_5_0 == "inTactics" then
		pg = var_1_10003
		var_1_10005 = var_1_10003.MsgboxMgr.GetInstance()
		var_1_10003 = var_1_10003.ShowMsgBox

		local var_5_7 = {}

		i18n = var_1_10007
		var_5_7.content = var_1_10007("tactics_lesson_cancel")

		function var_5_7.onYes()
			getProxy = var_2_10000
			NavalAcademyProxy = var_2_10002

			local var_12_0 = var_2_10000(var_2_10002)
			local var_12_1 = var_0.getStudentIdByShipId(var_12_0, arg_5_1.id)

			pg = var_2_10002

			local var_12_2 = var_2_10002.m02
			local var_12_3 = var_2.sendNotification

			GAME = var_2_10005

			local var_12_4 = var_2_10005.CANCEL_LEARN_TACTICS
			local var_12_5 = {
				callback = arg_5_2,
				shipId = var_12_1
			}

			Student = var_7
			var_12_5.type = var_7.CANCEL_TYPE_MANUAL

			var_12_3(var_12_2, var_12_4, var_12_5)

			return
		end

		var_1_10003(var_1_10005, var_5_7)

		return false, nil
	elseif arg_5_0 == "inGuildBossEvent" then
		pg = var_1_10003
		var_1_10005 = var_1_10003.MsgboxMgr.GetInstance()
		var_1_10003 = var_1_10003.ShowMsgBox

		local var_5_8 = {}

		i18n = var_1_10007
		var_5_8.content = var_1_10007("word_shipState_guild_boss")

		function var_5_8.onYes()
			getProxy = var_2_10000
			GuildProxy = var_2_10002

			local var_13_0 = var_2_10000(var_2_10002)

			if not var_0.getRawData(var_13_0) then
				return
			end

			local var_13_1 = var_0

			if not var_0.GetActiveEvent(var_13_1) then
				return
			end

			if var_1:GetBossMission() then
				var_2_10005 = var_2

				if not var_2.IsActive(var_2_10005) then
					return
				end

				getProxy = var_13_1
				PlayerProxy = var_2_10005

				local var_13_2 = var_13_1(var_2_10005)
				local var_13_3 = var_3.getRawData(var_13_2).id

				if not var_2:GetFleetUserId(var_13_3, arg_5_1.id) then
					return
				end

				Clone = var_13_2

				local var_13_4 = var_13_2(var_4)

				var_5.RemoveUserShip(var_13_4, var_13_3, arg_5_1.id)

				pg = var_6

				local var_13_5 = var_6.m02
				local var_13_6 = var_6.sendNotification

				GAME = var_9

				var_13_6(var_13_5, var_9.GUILD_UPDATE_BOSS_FORMATION, {
					force = true,
					editFleet = {
						[var_5.id] = var_5
					},
					callback = arg_5_2
				})

				return
			end
		end

		var_1_10003(var_1_10005, var_5_8)

		return false, nil
	elseif arg_5_0 == "inWorld" then
		nowWorld = var_1_10003

		local var_5_9 = var_1_10003().type

		World = var_1_10005

		if var_5_9 == var_1_10005.TypeBase then
			WorldConst = var_5_9

			var_5_9.ReqWorldCheck(arg_5_2)

			return false, nil
		else
			local var_5_10 = var_3:GetShip(arg_5_1.id).fleetId

			if #var_3:GetFleet(var_5_10)[arg_5_1:getTeamType()] > 1 then
				return true
			else
				pg = var_7

				local var_5_11 = var_7.TipsMgr.GetInstance()
				local var_5_12 = var_7.ShowTips

				i18n = var_1_10010

				var_5_12(var_5_11, var_1_10010("shipmodechange_reject_worldfleet_only"))

				return false, nil
			end
		end
	end

	return true
end

function var_0_0.canDestroyShip(arg_14_0, arg_14_1)
	if arg_14_0:isBluePrintShip() then
		local var_14_0 = false

		i18n = var_1_10003
		var_1_10003 = var_1_10003("blueprint_destory_tip")

		return
	else
		local var_14_1 = arg_14_0:GetLockState()

		Ship = var_1_10003

		local var_14_3

		if var_14_1 == var_1_10003.LOCK_STATE_LOCK then
			local var_14_2 = false

			i18n = var_14_3
			var_14_3 = var_14_3("ship_vo_locked")

			return
		elseif arg_14_0:isMetaShip() then
			local var_14_4 = false

			i18n = var_14_3

			local var_14_5 = var_14_3("meta_destroy_tip")

			return
		end
	end

	return var_0_0.ShipStatusCheck("onDestroy", arg_14_0, arg_14_1)
end

return var_0_0
