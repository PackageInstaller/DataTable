ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleStoryWave = var_0_10002("BattleStoryWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleStoryWave.__name = "BattleStoryWave"

local var_0_2 = var_0.Battle.BattleStoryWave

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.SetWaveData(arg_2_0, arg_2_1)
	var_0_2.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._storyID = arg_2_0._param.id

	return
end

function var_0_2.DoWave(arg_3_0)
	var_0_2.super.DoWave(arg_3_0)

	local var_3_0 = true
	local var_3_1 = false
	local var_3_2 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_3_3 = var_3.GetInitData(var_3_2).battleType

	SYSTEM_SCENARIO = var_1_10004

	if var_3_3 == var_1_10004 then
		getProxy = var_1_10004
		ChapterProxy = var_1_10006

		local var_3_4 = var_1_10004(var_1_10006)
		local var_3_5

		if var_1_10004.getActiveChapter(var_3_4, true) then
			var_3_5 = var_1_10004
			var_3_1 = var_1_10004.IsAutoFight(var_3_5) or var_3_1
		end

		if arg_3_0._param.progress then
			if not var_1_10004 then
				var_3_0 = false
			else
				math = var_3_7

				if var_3_7.min(var_1_10004.progress + var_1_10004:getConfig("progress_boss"), 100) < arg_3_0._param.progress then
					var_3_0 = false
				end
			end
		end

		local var_3_7

		if var_1_10004 then
			::label_3_0::

			getProxy = var_3_7
			ChapterProxy = var_3_5

			local var_3_6 = var_3_7(var_3_5)

			var_3_7 = var_3_7.getMapById(var_3_6, var_1_10004:getConfig("map"))
		end

		if var_3_7 and var_3_7:getRemaster() then
			var_3_0 = false
		end
	end

	if var_3_0 then
		pg = var_1_10004

		local var_3_8 = var_1_10004.MsgboxMgr.GetInstance()

		var_4.hide(var_3_8)

		local function var_3_9(arg_4_0, arg_4_1)
			if arg_4_0 then
				local var_4_0 = arg_3_0

				var_2.doFail(var_4_0, arg_4_1)
			else
				local var_4_1 = arg_3_0

				var_2.doPass(var_4_1, arg_4_1)
			end

			return
		end

		local var_3_10 = var_0.Battle.BattleDataProxy.GetInstance()
		local var_3_11 = var_5.GetInitData(var_3_10).isMemory

		ChapterOpCommand = var_3_8

		var_3_8.PlayChapterStory(arg_3_0._storyID, var_3_9, var_3_1, var_3_11)

		gcAll = var_6

		var_6()
	else
		arg_3_0:doPass()
	end

	return
end

function var_0_2.doPass(arg_5_0, arg_5_1)
	local var_5_0 = var_0.Battle.BattleDataProxy.GetInstance()

	var_2.AddWaveFlag(var_5_0, arg_5_1)
	var_0_2.super.doPass(arg_5_0)

	return
end

function var_0_2.doFail(arg_6_0, arg_6_1)
	local var_6_0 = var_0.Battle.BattleDataProxy.GetInstance()

	var_2.AddWaveFlag(var_6_0, arg_6_1)
	var_0_2.super.doFail(arg_6_0)

	return
end

return
