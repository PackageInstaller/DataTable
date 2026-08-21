ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleStoryWave = class("BattleStoryWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleStoryWave.__name = "BattleStoryWave"

local var_0_1 = ys.Battle.BattleStoryWave

function ys.Battle.BattleStoryWave.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleStoryWave.SetWaveData(arg_2_0, arg_2_1)
	var_0_1.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._storyID = arg_2_0._param.id

	return
end

function ys.Battle.BattleStoryWave.DoWave(arg_3_0)
	var_0_1.super.DoWave(arg_3_0)

	local var_3_0 = true
	local var_3_1 = false

	if var_0_0.Battle.BattleDataProxy.GetInstance():GetInitData().battleType == SYSTEM_SCENARIO then
		local var_3_2 = getProxy(ChapterProxy):getActiveChapter(true)

		var_3_1 = var_3_2 and var_3_2:IsAutoFight() or var_3_1

		if arg_3_0._param.progress then
			if not var_3_2 then
				var_3_0 = false
			elseif math.min(var_3_2.progress + var_3_2:getConfig("progress_boss"), 100) < arg_3_0._param.progress then
				var_3_0 = false
			end
		end

		local var_3_3 = var_3_2 and getProxy(ChapterProxy):getMapById(var_3_2:getConfig("map"))

		if var_3_3 and var_3_3:getRemaster() then
			var_3_0 = false
		end
	end

	if var_3_0 then
		pg.MsgboxMgr.GetInstance():hide()
		ChapterOpCommand.PlayChapterStory(arg_3_0._storyID, function(arg_4_0, arg_4_1)
			if arg_4_0 then
				arg_3_0:doFail(arg_4_1)
			else
				arg_3_0:doPass(arg_4_1)
			end

			return
		end, var_3_1, var_0_0.Battle.BattleDataProxy.GetInstance():GetInitData().isMemory)
		gcAll()
	else
		arg_3_0:doPass()
	end

	return
end

function ys.Battle.BattleStoryWave.doPass(arg_5_0, arg_5_1)
	var_0_0.Battle.BattleDataProxy.GetInstance():AddWaveFlag(arg_5_1)
	var_0_1.super.doPass(arg_5_0)

	return
end

function ys.Battle.BattleStoryWave.doFail(arg_6_0, arg_6_1)
	var_0_0.Battle.BattleDataProxy.GetInstance():AddWaveFlag(arg_6_1)
	var_0_1.super.doFail(arg_6_0)

	return
end

return
