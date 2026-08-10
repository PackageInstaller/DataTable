local var_0_0 = class("BattleFailedView", ReduxView)
local var_0_1 = import("game.tools.BattleInstance")

function var_0_0.UIName(arg_1_0)
	return "UI/BattleResult/BattleFailed"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stayTime = 6
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.mask_, nil, function()
		if arg_5_0.isEnd then
			return
		end

		if Time.realtimeSinceStartup - arg_5_0.startTime < 2 then
			return
		end

		arg_5_0:Quit()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnBattleCount_, nil, function()
		arg_5_0:GoToBattleStatistics()
	end)
end

function var_0_0.GoToBattleStatistics(arg_8_0)
	if arg_8_0.isEnd then
		return
	end

	arg_8_0:RemoveTimer()
	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = arg_8_0.stageData,
		battleTime = arg_8_0:GetBattleTime()
	})
end

function var_0_0.GetBattleTime(arg_9_0)
	local var_9_0 = (LuaExchangeHelper.GetBattleStatisticsData() or LuaExchangeHelper.GetBattleStatisticsDataBeforeBattleEnd()).dataForLua.battleTime

	return manager.time:DescCdTime2(var_9_0)
end

function var_0_0.Quit(arg_10_0)
	arg_10_0.isEnd = true

	arg_10_0:RemoveTimer()

	arg_10_0.timer_ = Timer.New(function()
		arg_10_0:QuitUI()
	end, 1, 1)

	arg_10_0.timer_:Start()
	arg_10_0.animator_:Play("battleFailed_out")
end

function var_0_0.OnEnter(arg_12_0)
	var_0_1.hideBattlePanel()
	arg_12_0:RecordThreeStar()

	arg_12_0.startTime = Time.realtimeSinceStartup
	arg_12_0.isEnd = false

	arg_12_0:RemoveTimer()

	arg_12_0.timer_ = Timer.New(function()
		arg_12_0:Quit()
	end, arg_12_0.stayTime, 1)

	arg_12_0.timer_:Start()

	arg_12_0.battleTimeText_.text = arg_12_0:GetBattleTime()

	arg_12_0.animator_:Play("battleFailed")
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveTimer()
end

function var_0_0.RemoveTimer(arg_15_0)
	if arg_15_0.timer_ then
		arg_15_0.timer_:Stop()

		arg_15_0.timer_ = nil
	end
end

function var_0_0.QuitUI(arg_16_0)
	local var_16_0 = PlayerData:GetlevelUpInfos()

	if #var_16_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_16_0,
			callback = function()
				FrameTimer.New(function()
					var_0_1.QuitBattle(arg_16_0.params_.stageData, true, true)
				end, 1, 1):Start()
			end
		})
	else
		var_0_1.QuitBattle(arg_16_0.params_.stageData, true, true)
	end
end

function var_0_0.RecordThreeStar(arg_19_0)
	arg_19_0.stageData_ = arg_19_0.params_.stageData
	arg_19_0.stageID_ = arg_19_0.stageData_:GetStageId()
	arg_19_0.stageType_ = arg_19_0.stageData_:GetType()

	local var_19_0 = arg_19_0.params_.starMissionData
	local var_19_1 = {}

	for iter_19_0 = 1, 3 do
		if var_19_0 ~= nil and var_19_0[iter_19_0] ~= nil then
			local var_19_2 = ThreeStarConditionCfg[var_19_0[iter_19_0].id]
			local var_19_3

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_19_0.stageType_ then
				var_19_3 = BattleStageData:GetStageData()[arg_19_0.stageID_]
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == arg_19_0.stageType_ then
				var_19_3 = BattleBossChallengeNormalData:GetStarList(arg_19_0.stageID_)
			end

			local var_19_4 = false

			if var_19_3 and var_19_3.stars and var_19_3.stars[iter_19_0] == 1 then
				var_19_4 = true
			end

			local var_19_5 = false

			if var_19_2.id == 15 or var_19_2.id == 16 then
				var_19_5 = var_19_0[iter_19_0].isComplete
			end

			var_19_1[iter_19_0] = (var_19_5 or var_19_4) and 1 or 0
		end
	end

	var_0_1.RecordThreeStar(arg_19_0.stageType_, arg_19_0.stageID_, var_19_1)
end

return var_0_0
