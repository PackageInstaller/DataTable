local var_0_0 = class("ShipStatus")

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
	local var_1_0 = defaultValue(arg_1_1[arg_1_2], var_0_0.TAG_HIDE_BASE[arg_1_2])

	if type(var_1_0) == "boolean" then
		return not var_1_0 and arg_1_0:getFlag(arg_1_2)
	elseif type(var_1_0) == "number" then
		return arg_1_0:getFlag(arg_1_2, var_1_0)
	else
		assert(false, "type error")
	end

	return
end

function var_0_0.ShipStatusToTag(arg_2_0, arg_2_1)
	if var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inChapter") then
		return {
			"shipstatus",
			"red",
			i18n("word_status_inFight")
		}
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inFleet") then
		local var_2_0 = getProxy(FleetProxy):GetRegularFleetByShip(arg_2_0)

		assert(var_2_0)

		local var_2_1 = var_2_0.id

		if var_2_0:isRegularFleet() then
			var_2_1 = math.fmod(var_2_1, 10)

			return {
				"ui/dockyardui_atlas",
				"biandui0" .. var_2_1,
				""
			}
		else
			return {
				"shipstatus",
				"red",
				Fleet.DEFAULT_NAME_FOR_DOCKYARD[var_2_1]
			}
		end
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inElite") then
		return {
			"shipstatus",
			"red",
			i18n("word_status_inHardFormation")
		}
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inSupport") then
		return {
			"shipstatus",
			"red",
			i18n("word_status_inSupportFleet")
		}
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inActivity") then
		return {
			"shipstatus",
			"red",
			i18n("word_status_activity")
		}
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inChallenge") then
		return {
			"shipstatus",
			"red",
			i18n("word_status_challenge")
		}
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inPvP") then
		return {
			"shipstatus",
			"red",
			i18n("word_status_inPVP")
		}
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inEvent") then
		return {
			"shipstatus",
			"green",
			i18n("word_status_inEvent")
		}
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inBackyard") then
		local var_2_2, var_2_3 = getProxy(DormProxy):getRawData():InBackYard(arg_2_0.id)

		if var_2_2 and var_2_3 == DormShip.FLOOR_2 then
			return {
				"shipstatus",
				"purple",
				i18n("word_status_rest")
			}
		elseif var_2_2 and var_2_3 == DormShip.FLOOR_1 then
			return {
				"shipstatus",
				"purple",
				i18n("word_status_train")
			}
		end
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inClass") then
		return {
			"shipstatus",
			"blue",
			i18n("word_status_inClass")
		}
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inTactics") then
		return {
			"shipstatus",
			"blue",
			i18n("word_status_inTactics")
		}
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inAdmiral") then
		return {
			"shipstatus",
			"light_green",
			i18n("common_flag_ship")
		}
	elseif var_0_0.checkShipFlag(arg_2_0, arg_2_1, "inWorld") then
		return {
			"shipstatus",
			"red",
			i18n("word_status_world")
		}
	else
		local var_2_4 = getProxy(SettingsProxy)

		if var_2_4:IsRandomFlagShip(arg_2_0:GetShipPhantomMark()) then
			return {
				"shipstatus",
				"light_yellow",
				i18n("random_flag_ship")
			}
		end
	end

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
		local var_3_3 = i18n(var_3_1)

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
		assert(false, "unknow error")
	end

	return
end

function var_0_0.ShipStatusConflict(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or {}

	for iter_4_0, iter_4_1 in ipairs(var_0_0.flagList) do
		if var_0_1[arg_4_0][iter_4_1] == var_0_0.STATE_CHANGE_FAIL and arg_4_1:getFlag(iter_4_1, arg_4_2[iter_4_1]) then
			return var_0_0.STATE_CHANGE_FAIL, var_0_2[iter_4_1].tips_block
		end
	end

	for iter_4_2, iter_4_3 in ipairs(var_0_0.flagList) do
		if var_0_1[arg_4_0][iter_4_3] == var_0_0.STATE_CHANGE_CHECK and arg_4_1:getFlag(iter_4_3, arg_4_2[iter_4_3]) then
			return var_0_0.STATE_CHANGE_CHECK, iter_4_3
		end
	end

	return var_0_0.STATE_CHANGE_OK
end

function var_0_0.ChangeStatusCheckBox(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0 == "inBackyard" then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("ship_vo_moveout_backyard"),
			onYes = function()
				pg.m02:sendNotification(GAME.EXIT_SHIP, {
					callback = arg_5_2,
					shipId = arg_5_1.id
				})

				return
			end
		})

		return false, nil
	elseif arg_5_0 == "inFleet" then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("shipchange_alert_infleet"),
			onYes = function()
				local var_7_0 = getProxy(FleetProxy):GetRegularFleetByShip(arg_5_1)

				if var_7_0:canRemove(arg_5_1) then
					var_7_0:removeShip(arg_5_1)
					pg.m02:sendNotification(GAME.UPDATE_FLEET, {
						callback = arg_5_2,
						fleet = var_7_0
					})
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("shipmodechange_reject_1stfleet_only"))
				end

				return
			end
		})

		return false, nil
	elseif arg_5_0 == "inSupport" then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("ship_formationMediator_request_replace_support"),
			onYes = function()
				pg.m02:sendNotification(GAME.REMOVE_ELITE_TARGET_SHIP, {
					shipId = arg_5_1.id,
					callback = arg_5_2
				})

				return
			end
		})

		return false, nil
	elseif arg_5_0 == "inPvP" then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("shipchange_alert_inpvp"),
			onYes = function()
				local var_9_0 = getProxy(FleetProxy):getFleetById(FleetProxy.PVP_FLEET_ID)

				if var_9_0:canRemove(arg_5_1) then
					var_9_0:removeShip(arg_5_1)
					pg.m02:sendNotification(GAME.UPDATE_FLEET, {
						callback = arg_5_2,
						fleet = var_9_0
					})
				else
					local var_9_1 = arg_5_1:getTeamType()

					if var_9_1 == TeamType.Vanguard then
						pg.TipsMgr.GetInstance():ShowTips(i18n("ship_vo_vanguardFleet_must_hasShip"))
					elseif var_9_1 == TeamType.Main then
						pg.TipsMgr.GetInstance():ShowTips(i18n("ship_vo_mainFleet_must_hasShip"))
					end
				end

				return
			end
		})

		return false, nil
	elseif arg_5_0 == "inExercise" then
		local var_5_0 = getProxy(MilitaryExerciseProxy):getExerciseFleet()

		if getProxy(MilitaryExerciseProxy):getExerciseFleet():canRemove(arg_5_1) then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("shipchange_alert_inexercise"),
				onYes = function()
					var_5_0:removeShip(arg_5_1)
					pg.m02:sendNotification(GAME.UPDATE_EXERCISE_FLEET, {
						fleet = var_5_0,
						callback = arg_5_2
					})

					return
				end
			})
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("exercise_clear_fleet_tip"),
				onYes = function()
					var_5_0:removeShip(arg_5_1)
					pg.m02:sendNotification(GAME.UPDATE_EXERCISE_FLEET, {
						fleet = var_5_0,
						callback = arg_5_2
					})

					return
				end
			})
		end

		return false, nil
	elseif arg_5_0 == "inTactics" then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("tactics_lesson_cancel"),
			onYes = function()
				pg.m02:sendNotification(GAME.CANCEL_LEARN_TACTICS, {
					callback = arg_5_2,
					shipId = getProxy(NavalAcademyProxy):getStudentIdByShipId(arg_5_1.id),
					type = Student.CANCEL_TYPE_MANUAL
				})

				return
			end
		})

		return false, nil
	elseif arg_5_0 == "inGuildBossEvent" then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("word_shipState_guild_boss"),
			onYes = function()
				local var_13_0 = getProxy(GuildProxy):getRawData()

				if not var_13_0 then
					return
				end

				local var_13_1 = var_13_0:GetActiveEvent()

				if not var_13_1 then
					return
				end

				local var_13_2 = var_13_1:GetBossMission()

				if not var_13_2 or not var_13_2:IsActive() then
					return
				end

				local var_13_3 = getProxy(PlayerProxy)
				local var_13_4 = var_13_3:getRawData().id
				local var_13_5 = var_13_2:GetFleetUserId(var_13_4, arg_5_1.id)

				if not var_13_5 then
					return
				end

				local var_13_6 = Clone(var_13_5)

				var_13_6:RemoveUserShip(var_13_4, arg_5_1.id)
				pg.m02:sendNotification(GAME.GUILD_UPDATE_BOSS_FORMATION, {
					force = true,
					editFleet = {
						[var_13_6.id] = var_13_6
					},
					callback = arg_5_2
				})

				return
			end
		})

		return false, nil
	elseif arg_5_0 == "inWorld" then
		local var_5_1 = nowWorld()

		if var_5_1.type == World.TypeBase then
			WorldConst.ReqWorldCheck(arg_5_2)

			return false, nil
		elseif #var_5_1:GetFleet(var_5_1:GetShip(arg_5_1.id).fleetId)[arg_5_1:getTeamType()] > 1 then
			return true
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("shipmodechange_reject_worldfleet_only"))

			return false, nil
		end
	end

	return true
end

function var_0_0.canDestroyShip(arg_14_0, arg_14_1)
	if arg_14_0:isBluePrintShip() then
		local var_14_1 = i18n("blueprint_destory_tip")

		return
	elseif arg_14_0:GetLockState() == Ship.LOCK_STATE_LOCK then
		local var_14_3 = i18n("ship_vo_locked")

		return
	elseif arg_14_0:isMetaShip() then
		local var_14_5 = i18n("meta_destroy_tip")

		return
	end

	return var_0_0.ShipStatusCheck("onDestroy", arg_14_0, arg_14_1)
end

return var_0_0
