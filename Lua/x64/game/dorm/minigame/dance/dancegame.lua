local var_0_0 = singletonClass("DanceGame")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = DormCharacterInteractBehaviour
local var_0_4 = Dorm.DormEntityManager

local function var_0_5(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.round

	print("Round:", var_1_0, "Start")
	manager.notify:Invoke(BACKHOME_CRICKET_ROUND_START, var_1_0)
end

local function var_0_6(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.round

	print("Round:", var_2_0, "End")
	manager.notify:Invoke(BACKHOME_CRICKET_ROUND_END, var_2_0)
end

local function var_0_7(arg_3_0)
	if arg_3_0 == nil then
		return nil
	end

	local var_3_0 = arg_3_0[1]

	for iter_3_0 = 2, #arg_3_0 do
		var_3_0 = var_3_0 .. arg_3_0[iter_3_0]
	end

	return var_3_0
end

local function var_0_8()
	DormMinigame.Launch("WT_RK", nil, "idolTraineeCamp")
end

local function var_0_9(arg_5_0, arg_5_1)
	manager.notify:Invoke(BACKHOME_CRICKET_REFRESH_BUFF, arg_5_1.round)
end

local function var_0_10(arg_6_0)
	return arg_6_0 ~= nil and arg_6_0 ~= 0
end

local function var_0_11(arg_7_0)
	local var_7_0 = arg_7_0.myAction.skillID
	local var_7_1 = arg_7_0.enemyAction.skillID
	local var_7_2 = math.random()
	local var_7_3 = var_0_10(var_7_0)
	local var_7_4 = var_0_10(var_7_1)
	local var_7_5
	local var_7_6

	if var_7_3 and var_7_4 then
		var_7_6 = BOTH_USING_SKILL_CHANCE
	elseif var_7_3 then
		var_7_5 = var_0_1
		var_7_6 = ONE_USING_SKILL_CHANCE
	elseif var_7_4 then
		var_7_5 = var_0_2
		var_7_6 = ONE_USING_SKILL_CHANCE
	else
		var_7_5 = var_0_1
		var_7_6 = ADVANCE_NORMAL_ACTION_CHANCE
	end

	var_7_6 = var_7_6 or 0

	if var_7_2 < var_7_6 then
		return nil
	end

	return var_7_5
end

function var_0_0.GetSequence(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3 == nil then
		return var_0_3.GetSequence(arg_8_0, arg_8_1, arg_8_2, "game.dorm.interacts.dance")
	else
		local var_8_0 = var_0_3.GetSequenceGroup(arg_8_0, arg_8_1, arg_8_2, "game.dorm.interacts.dance")

		arg_8_3 = (arg_8_3 - 1) % #var_8_0 + 1

		return var_8_0[arg_8_3]
	end
end

function var_0_0.MakeCtxForAction(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {}
	local var_9_1 = nullable(DormUtils.GetEntityData(arg_9_0), "cfgID")
	local var_9_2 = nullable(DormUtils.GetEntityData(arg_9_1), "cfgID")

	var_9_0.entityCfg, var_9_0.targetCfg = var_9_1, var_9_2

	local var_9_3 = var_0_0.GetSequence(arg_9_0, arg_9_1, arg_9_2, arg_9_3)

	return var_0_3.MakeCtx(arg_9_0, arg_9_1, var_9_0), var_9_3
end

function var_0_0.GetSeqAlignedToRoundDuration(arg_10_0, arg_10_1)
	if arg_10_1 == nil then
		return arg_10_0
	end

	local var_10_0 = arg_10_0.duration / arg_10_1
	local var_10_1 = {
		duration = arg_10_1,
		sequence = {
			[0] = {
				function(arg_11_0)
					DanceGameController.SetEntityAnimeSpeed(arg_11_0.entityID, var_10_0)
				end
			}
		}
	}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.sequence) do
		local var_10_2 = iter_10_0 / var_10_0
		local var_10_3 = var_10_1.sequence[var_10_2] or {}

		if type(iter_10_1) == "function" then
			table.insert(var_10_3, iter_10_1)
		elseif type(iter_10_1) == "table" then
			for iter_10_2, iter_10_3 in ipairs(iter_10_1) do
				table.insert(var_10_3, iter_10_3)
			end
		end

		var_10_1.sequence[var_10_2] = var_10_3
	end

	return var_10_1
end

local function var_0_12(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_2 == nil then
		print("No action, no wait", arg_12_0)

		return nil
	end

	local var_12_0, var_12_1 = var_0_0.MakeCtxForAction(arg_12_0, arg_12_1, arg_12_2, arg_12_3)

	if var_12_1 then
		local var_12_2 = var_0_0.GetSeqAlignedToRoundDuration(var_12_1, arg_12_4)

		var_12_0.curActionTask = var_0_3.MakeInteractTask(var_12_2, var_12_0)
	else
		var_12_0.curActionTask = var_0_0.DebugAction(arg_12_2, var_12_0)
	end

	var_0_4.StopAllCmd(arg_12_0)
	DormUtils.SetEntityInteractContext(arg_12_0, var_12_0)
	var_0_4.SendInteractToEntityCMD(arg_12_0, arg_12_1, true)

	return var_12_0.curActionTask
end

local function var_0_13(arg_13_0, arg_13_1, arg_13_2, ...)
	local var_13_0 = {
		...
	}
	local var_13_1 = var_0_0.StartActionTurn
	local var_13_2 = var_0_0.TurnSettlement
	local var_13_3 = arg_13_0.actionRound[arg_13_1]
	local var_13_4 = var_13_3.start
	local var_13_5 = var_13_3.finish
	local var_13_6 = {
		round = arg_13_1,
		player = arg_13_0:GetPlayerCharaEID(),
		opponent = arg_13_0:GetOpponentCharaEID(),
		roundMusicInfo = var_13_3,
		duration = var_13_5 - var_13_4,
		removedBuff = {}
	}
	local var_13_7 = var_0_11(arg_13_2)
	local var_13_8 = arg_13_0.taskRunner:NewTask()

	var_13_8:WaitUntil(function()
		return arg_13_0.bgmPlayback and arg_13_0.taskRunner:Now() >= var_13_4
	end):Then(function()
		if var_13_7 then
			arg_13_0:ActiveShootToCharaCam(var_13_7)
		end

		arg_13_0.curRound = arg_13_1

		var_0_5(arg_13_0, var_13_6)

		var_13_6.playerTask, var_13_6.opponentTask = var_13_1(arg_13_0, var_13_6, arg_13_2, unpack(var_13_0))
	end):WaitUntil(function()
		return arg_13_0.taskRunner:Now() >= var_13_5
	end):Then(function()
		if var_13_7 then
			arg_13_0:RestoreCam()
		end

		var_13_2(arg_13_0, var_13_6, arg_13_2, unpack(var_13_0))
		var_0_6(arg_13_0, var_13_6)
		DanceGameController.SetEntityAnimeSpeed(var_13_6.player, 1)
		DanceGameController.SetEntityAnimeSpeed(var_13_6.opponent, 1)
	end)
	var_13_8:Start(true)

	return var_13_8
end

local function var_0_14(arg_18_0, arg_18_1)
	local var_18_0 = var_0_0.StartPrepareTurn

	local function var_18_1(arg_19_0, arg_19_1)
		var_0_9(arg_19_0, arg_19_1)
	end

	local var_18_2 = DormCharacterActionManager.frameTaskRunner:NewTask()
	local var_18_3 = 0
	local var_18_4 = {
		round = var_18_3,
		player = arg_18_0:GetPlayerCharaEID(),
		opponent = arg_18_0:GetOpponentCharaEID(),
		removedBuff = {}
	}

	Dorm.storage:RecordData("dance.flags", "start", false)
	var_18_2:Then(function()
		manager.notify:CallUpdateFunc("OnDanceGameStart")
	end):WaitUntil(function()
		return Dorm.storage:GetData("dance.flags", "start")
	end):Then(function()
		arg_18_0.curRound = var_18_3

		var_0_5(arg_18_0, var_18_4)

		var_18_4.playerTask, var_18_4.opponentTask = var_18_0(arg_18_0, var_18_4, arg_18_1)
	end):WaitUntil(function()
		if var_18_4.playerTask and not var_18_4.playerTask:IsFinished() then
			return false
		end

		if var_18_4.opponentTask and not var_18_4.opponentTask:IsFinished() then
			return false
		end

		return true
	end):Then(function()
		var_18_1(arg_18_0, var_18_4, arg_18_1)
		var_0_6(arg_18_0, var_18_4)
		print("准备阶段结束")

		arg_18_0.bgmPlayback = arg_18_0.bgmPlayer:Play()

		arg_18_0.taskRunner:SetPlayback(arg_18_0.bgmPlayback)
		arg_18_0:StartMainCamDirector()
		manager.notify:CallUpdateFunc("OnStartCountDownTimer")
	end)
	var_18_2:Start(true)

	return var_18_2
end

local function var_0_15(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = DormCharacterActionManager.frameTaskRunner:NewTask()
	local var_25_1 = {
		player = arg_25_0:GetPlayerCharaEID(),
		opponent = arg_25_0:GetOpponentCharaEID(),
		removedBuff = {}
	}
	local var_25_2 = "curtain_call_"
	local var_25_3 = 1.25

	var_25_0:WaitTask(arg_25_1):Then(function()
		manager.notify:CallUpdateFunc("OnDanceGameFinish")
		manager.audio:PlayEffect("ui_battle", "ui_battle_stopbgm")
	end):WaitUntil(function(arg_27_0)
		if arg_27_0.startTime == nil then
			arg_27_0.startTime = var_25_0.taskRunner:Now()
		end

		local var_27_0 = var_25_0.taskRunner:Now()

		if not arg_27_0.alreadyShowResult and var_27_0 - arg_27_0.startTime >= var_25_3 then
			arg_27_0.alreadyShowResult = true

			if arg_25_2 then
				arg_25_2()
			end
		end

		local var_27_1 = arg_27_0.player
		local var_27_2 = arg_27_0.opponent

		if arg_27_0.playerTask == nil or arg_27_0.playerTask:IsFinished() then
			arg_27_0.playerTask = var_0_12(var_27_1, var_27_2, var_25_2)
		end

		if arg_27_0.opponentTask == nil or arg_27_0.opponentTask:IsFinished() then
			arg_27_0.opponentTask = var_0_12(var_27_2, var_27_1, var_25_2)
		end

		return false
	end, false, var_25_1)
	var_25_0:Start(true)
end

function var_0_0.GotoResultView(arg_28_0)
	if not arg_28_0.isGotoResult then
		arg_28_0.isGotoResult = true

		local var_28_0 = BackHomeCricketBattleData:GetSingleBattleData()

		if var_28_0.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
			JumpTools.OpenPageByJump("/backHomeCricketBattleResuleView", {
				data = var_28_0
			})
		else
			BackHomeCricketAction.SendBattleComplete(arg_28_0.battleType, function(arg_29_0, arg_29_1)
				JumpTools.OpenPageByJump("/backHomeCricketBattleResuleView", {
					data = arg_29_1
				})
			end)
		end
	end
end

function var_0_0.ProcessDanceSeq(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_0:GetPlayerCharaEID()
	local var_30_1 = arg_30_0:GetOpponentCharaEID()

	DanceGameController.SetEntityAnimeSpeed(var_30_0, 1)
	DanceGameController.SetEntityAnimeSpeed(var_30_1, 1)

	if arg_30_0.prepareRoundTask then
		arg_30_0.prepareRoundTask:Abort()
	end

	arg_30_0.prepareRoundTask = var_0_14(arg_30_0, arg_30_1)

	arg_30_0.prepareRoundTask:SetOnComplete(function()
		arg_30_0.prepareRoundTask = nil
	end)

	local var_30_2

	arg_30_0.totalRound = arg_30_3

	for iter_30_0 = 1, arg_30_3 do
		local var_30_3 = arg_30_2[iter_30_0]

		var_30_2 = var_0_13(arg_30_0, iter_30_0, var_30_3)
	end

	var_0_15(arg_30_0, var_30_2, function()
		arg_30_0:GotoResultView()
	end)
end

function var_0_0.SkipShow(arg_33_0)
	arg_33_0:GotoResultView()
end

function var_0_0.DebugAction(arg_34_0, arg_34_1)
	return var_0_3.MakeInteractTask({
		duration = 1,
		sequence = {
			[0] = function()
				print("普通动作", arg_34_0, 0)
			end,
			[0.5] = function()
				print("普通动作", arg_34_0, 0.5, "InProgress")
			end,
			function()
				print("普通动作", arg_34_0, 1, "Finish")
			end
		}
	}, arg_34_1)
end

local function var_0_16(arg_38_0)
	return arg_38_0 and arg_38_0 ~= "" and not IsAllSpace(arg_38_0)
end

local function var_0_17(arg_39_0)
	local var_39_0 = IdolTraineeSkillCfg[arg_39_0].action

	return var_0_16(var_39_0)
end

local function var_0_18(arg_40_0)
	local var_40_0 = IdolTraineeSkillCfg[arg_40_0].counter_action

	return var_0_16(var_40_0)
end

local var_0_19 = 0
local var_0_20 = 1
local var_0_21 = {
	"type1",
	"type2",
	"type3",
	"type4",
	"type5"
}
local var_0_22 = {
	"b8",
	"b16"
}

local function var_0_23(arg_41_0, arg_41_1)
	local var_41_0 = nullable(DormUtils.GetEntityData(arg_41_0), "skinID")
	local var_41_1

	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		if (var_41_1 == nil or iter_41_1 < var_41_1) and var_0_17(iter_41_1) then
			var_41_1 = iter_41_1
		end
	end

	return nullable(IdolTraineeSkillCfg, var_41_1, "action")
end

local function var_0_24(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = nullable(DormUtils.GetEntityData(arg_42_0), "skinID")
	local var_42_1
	local var_42_2

	if arg_42_2 and var_0_10(arg_42_2.skillID) then
		var_42_1 = arg_42_2.skillID
	end

	if arg_42_3 and var_0_10(arg_42_3.skillID) then
		var_42_2 = arg_42_3.skillID
	end

	local var_42_3

	if var_42_1 then
		var_42_3 = IdolTraineeSkillCfg[var_42_1].action
	elseif var_42_2 then
		var_42_3 = IdolTraineeSkillCfg[var_42_2].counter_action
	end

	local var_42_4 = true

	if not var_0_16(var_42_3) then
		var_42_3 = var_0_21[arg_42_2.actionID]
		var_42_4 = false
	end

	local var_42_5 = var_0_22[arg_42_1.roundMusicInfo.type]

	return string.format("%s_%s_", var_42_3, var_42_5), var_42_4
end

local var_0_25 = 1
local var_0_26 = 2

local function var_0_27(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5, arg_43_6)
	local var_43_0 = IdolTraineeSkillEffectCfg[arg_43_0]
	local var_43_1
	local var_43_2

	if var_43_0.object == var_0_25 then
		local var_43_3 = arg_43_2

		var_43_2 = arg_43_3
	elseif var_43_0.object == var_0_26 then
		local var_43_4 = arg_43_4

		var_43_2 = arg_43_5
	end

	local var_43_5 = arg_43_6.round

	if var_43_5 == 0 then
		var_43_5 = 1
	end

	table.insert(var_43_2.buff, {
		id = arg_43_0,
		skill = arg_43_1,
		duration = var_43_0.round,
		showDuration = var_43_0.round ~= -1,
		triggerRound = var_43_0.trigger_time + var_43_5
	})
end

local function var_0_28(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = DormUtils.GetEntityData(arg_44_0)
	local var_44_1 = DormUtils.GetEntityData(arg_44_1)

	if arg_44_3.action then
		local var_44_2 = arg_44_3.action

		for iter_44_0, iter_44_1 in ipairs(var_44_2.effectList) do
			local var_44_3 = nullable(IdolTraineeSkillCfg, var_44_2.skillID, "skill_effect", iter_44_1)

			if var_44_3 then
				var_0_27(var_44_3, var_44_2.skillID, arg_44_0, var_44_0, arg_44_1, var_44_1, arg_44_2)
			end
		end
	else
		for iter_44_2, iter_44_3 in ipairs(arg_44_3.passive) do
			var_0_27(iter_44_3, nil, arg_44_0, var_44_0, arg_44_1, var_44_1, arg_44_2)
		end
	end
end

local function var_0_29(arg_45_0)
	local var_45_0 = {}
	local var_45_1 = nullable(BackHomeHeroCfg, arg_45_0, "idol_passive_skill_list")

	if var_45_1 then
		for iter_45_0, iter_45_1 in ipairs(var_45_1) do
			table.insert(var_45_0, iter_45_1[1])
		end
	else
		local var_45_2 = nullable(IdolPveNpcCfg, arg_45_0, "idol_passive_skill_list")

		if var_45_2 then
			for iter_45_2, iter_45_3 in ipairs(var_45_2) do
				table.insert(var_45_0, iter_45_3)
			end
		end
	end

	return var_45_0
end

function var_0_0.StartPrepareTurn(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_1.player
	local var_46_1 = arg_46_1.opponent
	local var_46_2 = DormUtils.GetEntityData(var_46_0).heroID
	local var_46_3 = DormUtils.GetEntityData(var_46_1).heroID
	local var_46_4 = var_0_29(var_46_2)
	local var_46_5 = var_0_29(var_46_3)
	local var_46_6 = {
		passive = arg_46_2.myActiveBuffList
	}
	local var_46_7 = {
		passive = arg_46_2.enemyActiveBuffList
	}

	var_0_28(var_46_0, var_46_1, arg_46_1, var_46_6)
	var_0_28(var_46_1, var_46_0, arg_46_1, var_46_7)
	var_0_9(arg_46_0, arg_46_1)

	return var_0_12(var_46_0, var_46_1, var_0_23(var_46_0, arg_46_1, var_46_4)), var_0_12(var_46_1, var_46_0, var_0_23(var_46_1, arg_46_1, var_46_5))
end

function var_0_0.StartActionTurn(arg_47_0, arg_47_1, arg_47_2)
	print("回合开始：", arg_47_1.round)

	local var_47_0 = arg_47_1.player
	local var_47_1 = arg_47_1.opponent
	local var_47_2 = {
		action = arg_47_2.myAction,
		score = arg_47_2.myScore
	}
	local var_47_3 = {
		action = arg_47_2.enemyAction,
		score = arg_47_2.enemyScore
	}

	var_0_28(var_47_0, var_47_1, arg_47_1, var_47_2)
	var_0_28(var_47_1, var_47_0, arg_47_1, var_47_3)
	var_0_9(arg_47_0, arg_47_1)

	local var_47_4
	local var_47_5
	local var_47_6
	local var_47_7

	if arg_47_1.round == 1 then
		local var_47_8
		local var_47_9
		local var_47_10

		var_47_4, var_47_10 = var_0_24(var_47_0, arg_47_1, var_47_2.action, var_47_3.action)

		local var_47_11

		var_47_5, var_47_11 = var_0_24(var_47_1, arg_47_1, var_47_3.action, var_47_2.action)

		if not var_47_10 and not var_47_11 then
			var_47_5 = var_47_4

			local var_47_12 = var_0_3.GetSequenceGroup(var_47_0, var_47_1, var_47_4, "game.dorm.interacts.dance")
			local var_47_13 = math.random(#var_47_12)

			var_47_6, var_47_7 = var_47_13, var_47_13
		end
	elseif arg_47_1.round == arg_47_0.totalRound then
		local var_47_14
		local var_47_15
		local var_47_16

		var_47_4, var_47_16 = var_0_24(var_47_0, arg_47_1, var_47_2.action, var_47_3.action)

		local var_47_17

		var_47_5, var_47_17 = var_0_24(var_47_1, arg_47_1, var_47_3.action, var_47_2.action)

		if not var_47_16 and not var_47_17 then
			var_47_4 = var_47_5

			local var_47_18 = var_0_3.GetSequenceGroup(var_47_0, var_47_1, var_47_5, "game.dorm.interacts.dance")
			local var_47_19 = math.random(#var_47_18)

			var_47_6, var_47_7 = var_47_19, var_47_19
		end
	else
		var_47_4 = var_0_24(var_47_0, arg_47_1, var_47_2.action, var_47_3.action)
		var_47_5 = var_0_24(var_47_1, arg_47_1, var_47_3.action, var_47_2.action)
	end

	return var_0_12(var_47_0, var_47_1, var_47_4, var_47_6, arg_47_1.duration), var_0_12(var_47_1, var_47_0, var_47_5, var_47_7, arg_47_1.duration)
end

local function var_0_30(arg_48_0, arg_48_1)
	local var_48_0 = DormUtils.GetEntityData(arg_48_0)
	local var_48_1 = {}

	for iter_48_0, iter_48_1 in pairs(var_48_0.buff) do
		local var_48_2 = iter_48_1.id
		local var_48_3 = iter_48_1.duration

		if iter_48_1.triggerRound <= arg_48_1.round then
			if not iter_48_1.showDuration then
				if not iter_48_1.activated then
					iter_48_1.activated = true
				end
			else
				if var_48_3 > 0 then
					if not iter_48_1.activated then
						iter_48_1.activated = true
					end

					iter_48_1.duration = var_48_3 - 1
				end

				if iter_48_1.duration <= 0 then
					table.insert(var_48_1, iter_48_0)
				end
			end
		end
	end

	for iter_48_2 = #var_48_1, 1, -1 do
		var_48_1[iter_48_2] = table.remove(var_48_0.buff, var_48_1[iter_48_2]).id
	end

	arg_48_1.removedBuff[arg_48_0] = var_48_1
end

function var_0_0.TurnSettlement(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = arg_49_1.player
	local var_49_1 = arg_49_1.opponent

	var_0_30(var_49_0, arg_49_1)
	var_0_30(var_49_1, arg_49_1)
	var_0_9(arg_49_0, arg_49_1)
end

local function var_0_31(arg_50_0)
	return "CharDorm/dance/" .. arg_50_0.model
end

local function var_0_32(arg_51_0)
	local var_51_0 = "dance.pos." .. arg_51_0.spawnAt

	return Dorm.storage:GetData(var_51_0, 1).transform
end

function var_0_0.Ctor(arg_52_0)
	local var_52_0 = EntityManager.CreateModel.New(var_0_31, var_0_32)

	arg_52_0.charaMgr = EntityManager.New(var_52_0)
	arg_52_0.taskRunner = DanceGameTaskRunner.New()
end

function var_0_0.Init(arg_53_0, arg_53_1)
	arg_53_0:InitGame(arg_53_1)

	local var_53_0 = arg_53_1.stageID
	local var_53_1 = arg_53_1.battleType == BackHomeCricketConst.ROOM_TYPE.PVE_STAGE and IdolTraineePveBattleCfg[var_53_0] or IdolTraineePvpBattleCfg[var_53_0]

	arg_53_0:InitScene(var_53_1)
	DormCharacterActionManager:RegisterTaskRunner(arg_53_0.taskRunner, 2, 1)
	arg_53_0:ProcessDanceSeq(arg_53_1.prepareInfo, arg_53_1.roundList, arg_53_1.lastRound)
end

var_0_0.actionCountNamespace = "dance.action.cnt"

function var_0_0.InitGame(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_1.mySkinID
	local var_54_1 = arg_54_1.enemySkinID

	arg_54_0.battleType = arg_54_1.battleType

	arg_54_0:SetCharacter(var_0_1, var_54_0)
	arg_54_0:SetCharacter(var_0_2, var_54_1)

	arg_54_0.isGotoResult = nil

	Dorm.storage:ClearData(var_0_0.actionCountNamespace)
end

function var_0_0.SetCharacter(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = BackHomeHeroSkinCfg[arg_55_2] or IdolPveNpcCfg[arg_55_2]
	local var_55_1 = nullable(var_55_0, "model")
	local var_55_2 = nullable(var_55_0, "hero_id") or arg_55_2
	local var_55_3 = {
		complex = true,
		model = var_55_1,
		spawnAt = arg_55_1
	}

	arg_55_0.charaMgr:Update(arg_55_1, var_55_3, {
		cfgID = arg_55_2,
		heroID = var_55_2,
		buff = {}
	})
end

function var_0_0.GetPlayerCharaEID(arg_56_0)
	return arg_56_0.charaMgr:GetEntityID(var_0_1)
end

function var_0_0.GetOpponentCharaEID(arg_57_0)
	return arg_57_0.charaMgr:GetEntityID(var_0_2)
end

function var_0_0.Reset(arg_58_0, arg_58_1, arg_58_2)
	arg_58_0.charaMgr:Clear(true)
	arg_58_0.taskRunner:Reset()

	arg_58_0.bgmPlayback = nil
	arg_58_0.totalRound = nil

	if not arg_58_2 then
		arg_58_0.actionRound = nil
	end

	if arg_58_1 then
		arg_58_0.danceGameController = nil
		arg_58_0.shootCam = nil
		arg_58_0.cinemachineBrain = nil
	end
end

function var_0_0.InitBgmPlayer(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	local var_59_0 = GameObject.Find("bgmPlayer"):GetComponent("CriAtomSource")

	DanceGameController.AddCue(arg_59_1, arg_59_3)

	var_59_0.cueSheet = arg_59_1
	var_59_0.cueName = arg_59_2
	arg_59_0.bgmPlayer = var_59_0
end

local var_0_33 = 2

function var_0_0.InitScene(arg_60_0, arg_60_1)
	if arg_60_0.danceGameController == nil then
		local var_60_0 = IdolStageSceneCfg[arg_60_1.scene_id].cam_director_prefab

		arg_60_0.danceGameController = DanceGameController.Load("IdolTrainee/Stage/" .. var_60_0)

		arg_60_0:InitCam()
	end

	local var_60_1 = IdolStageMusicCfg[arg_60_1.bgm]

	if arg_60_0.actionRound == nil then
		local var_60_2 = var_60_1.music_json
		local var_60_3 = AssetEx.LoadText(var_60_2)
		local var_60_4 = require("cjson").decode(var_60_3)
		local var_60_5 = {}

		for iter_60_0 = 1, var_0_33 do
			local var_60_6 = var_60_4["track" .. iter_60_0]

			for iter_60_1, iter_60_2 in pairs(var_60_6) do
				table.insert(var_60_5, {
					type = iter_60_0,
					start = iter_60_2[1] / 1000,
					finish = iter_60_2[2] / 1000
				})
			end
		end

		table.sort(var_60_5, function(arg_61_0, arg_61_1)
			return arg_61_0.start < arg_61_1.start
		end)

		arg_60_0.actionRound = var_60_5
	end

	arg_60_0:InitBgmPlayer(var_60_1.cue_sheet, var_60_1.cue_name, var_60_1.awb_name)
end

function var_0_0.InitCam(arg_62_0)
	arg_62_0.danceGameController:InitCinemachineBrain()

	arg_62_0.cinemachineBrain = arg_62_0.danceGameController.brain
	arg_62_0.cinemachineBrain.m_DefaultBlend = DanceGameController.cut
	arg_62_0.shootCam = GameObject.Find("shoot"):GetComponent("CinemachineVirtualCamera")

	local var_62_0 = arg_62_0:GetPlayerCharaEID()
	local var_62_1 = arg_62_0:GetOpponentCharaEID()

	arg_62_0.danceGameController:SetDummyFollowEntity("player1", var_62_0)
	arg_62_0.danceGameController:SetDummyFollowEntity("player2", var_62_1)

	arg_62_0.cinemachineBrain.enabled = true

	local var_62_2 = var_0_32({
		spawnAt = var_0_1
	})
	local var_62_3 = var_0_32({
		spawnAt = var_0_2
	})

	arg_62_0.shootCamCfg = {
		[var_0_1] = {
			lookAt = arg_62_0.danceGameController:GetDummy("player1") or var_62_2,
			pos = var_62_2:Find("shootPos")
		},
		[var_0_2] = {
			lookAt = arg_62_0.danceGameController:GetDummy("player2") or var_62_3,
			pos = var_62_3:Find("shootPos")
		}
	}
end

function var_0_0.ActiveShootToCharaCam(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_0.shootCamCfg[arg_63_1]

	if var_63_0 then
		arg_63_0.shootCam.Follow = var_63_0.pos
		arg_63_0.shootCam.LookAt = var_63_0.lookAt
		arg_63_0.shootCam.enabled = true
	end
end

function var_0_0.RestoreCam(arg_64_0)
	arg_64_0.shootCam.enabled = false
end

function var_0_0.StartMainCamDirector(arg_65_0)
	local var_65_0 = arg_65_0.danceGameController.director

	if var_65_0 then
		var_65_0:Play()
	end
end

function var_0_0.StopMainCamDirector(arg_66_0)
	local var_66_0 = arg_66_0.danceGameController.director

	if var_66_0 then
		var_66_0:Stop()

		var_66_0.time = var_66_0.initialTime

		var_66_0:Evaluate()
	end
end

function var_0_0.Restart(arg_67_0, arg_67_1)
	arg_67_0:Reset(false, true)
	arg_67_0:InitGame(arg_67_1)
	arg_67_0.bgmPlayer:Stop()
	DormCharacterActionManager:RegisterTaskRunner(arg_67_0.taskRunner, 2, 1)
	arg_67_0:ProcessDanceSeq(arg_67_1.prepareInfo, arg_67_1.roundList, arg_67_1.lastRound)
end

return var_0_0
