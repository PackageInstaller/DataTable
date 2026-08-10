require("game.data.BackHomeCricketDataTemplate")

local var_0_0 = singletonClass("BackHomeCricketBattleData")
local var_0_1
local var_0_2

function var_0_0.InitSimpleCricketBattleInfo(arg_1_0, arg_1_1)
	return
end

function var_0_0.InitDetailCricketBattleData(arg_2_0, arg_2_1)
	return
end

function var_0_0.EnterCurSystem(arg_3_0)
	return
end

function var_0_0.ExitCurSystem(arg_4_0)
	if var_0_1 then
		var_0_1:Dispose()

		var_0_1 = nil
	end
end

function var_0_0.ExitBackHomeSystem(arg_5_0)
	if var_0_1 then
		var_0_1:Dispose()

		var_0_1 = nil
	end
end

function var_0_0.RefreshCricketBattleDailyZero(arg_6_0)
	return
end

function var_0_0.InitSingleBattleData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if var_0_1 then
		var_0_1:Dispose()

		var_0_1 = nil
	end

	var_0_1 = BackHomeCricketBattleResult.New(arg_7_1, arg_7_2, arg_7_3)
end

function var_0_0.GetSingleBattleData(arg_8_0)
	if var_0_1 then
		return var_0_1
	end
end

function var_0_0.SetDanceBackCB(arg_9_0)
	if var_0_1 then
		if var_0_1.settleType == BackHomeCricketConst.ROOM_TYPE.Video or var_0_1.enemyID ~= nil then
			local var_9_0 = var_0_1.stageID

			function var_0_2()
				JumpTools.OpenPageByJump("/idolTraineeEnterBattleView", {
					pvpBattle = true,
					stageID = var_9_0
				})
			end
		else
			local var_9_1 = var_0_1.stageID
			local var_9_2 = IdolTraineeTools:GetPveStageChapter(var_9_1)

			function var_0_2()
				JumpTools.OpenPageByJump("/idolTraineeEnterBattleView", {
					pvpBattle = false,
					stageID = var_9_1
				})
				JumpTools.OpenPageByJump("/idolTraineeLevelMainView", {
					chapterID = var_9_2
				})
				JumpTools.OpenPageByJump("/idolTraineeChapterMain")
			end
		end
	end
end

function var_0_0.InvokeDanceBackCB(arg_12_0)
	if var_0_2 then
		var_0_2()

		var_0_2 = nil
	end
end

return var_0_0
