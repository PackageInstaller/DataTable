require("game.data.RhythmItemTemplate")

local var_0_0 = singletonClass("DormRhythmGameData")
local var_0_1
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8

local function var_0_9()
	var_0_2.judgeWidth = var_0_6.judgeWidth
	var_0_7.deterGo.transform.rect.width = var_0_2.judgeWidth
end

local function var_0_10()
	local var_2_0 = var_0_8[var_0_1.levelID]

	for iter_2_0, iter_2_1 in ipairs(var_2_0.check_speed) do
		if iter_2_1[1] > var_0_2.deterGenNum then
			var_0_2.gameSpeed = var_2_0.check_speed[iter_2_0 - 1][2]

			return
		end
	end

	var_0_2.gameSpeed = var_2_0.check_speed[#var_2_0.check_speed][2]
end

local function var_0_11()
	local var_3_0 = var_0_8[var_0_1.levelID]

	for iter_3_0, iter_3_1 in ipairs(var_3_0.check_hit_length) do
		if iter_3_1[1] > var_0_2.deterGenNum then
			var_0_2.deterLength = var_3_0.check_hit_length[iter_3_0 - 1][2]

			return
		end
	end

	var_0_2.deterLength = var_3_0.check_hit_length[#var_3_0.check_hit_length][2]
end

local function var_0_12()
	local var_4_0 = var_0_8[var_0_1.levelID]

	for iter_4_0, iter_4_1 in ipairs(var_4_0.time_interval) do
		if iter_4_1[1] > var_0_2.deterGenNum then
			var_0_2.interval = var_4_0.time_interval[iter_4_0 - 1][2]

			return
		end
	end

	var_0_2.interval = var_4_0.time_interval[#var_4_0.time_interval][2]
end

local function var_0_13()
	var_0_10()
	var_0_12()
	var_0_11()
end

local function var_0_14()
	var_0_2 = {
		interval = 0,
		gameSpeed = 0,
		batterNum = 0,
		pauseFlag = false,
		gameRunFlag = false,
		deterGenNum = 0,
		judgeWidth = 0,
		mistakeNum = 0,
		maxBatterNum = 0,
		successfulNum = 0,
		deterLength = 0
	}
	var_0_4 = {}
	var_0_5 = 1

	var_0_13()
	var_0_9()
end

local function var_0_15()
	if var_0_2.deterGenNum >= var_0_8[var_0_1.levelID].total_check then
		return
	end

	if var_0_4[var_0_5] and var_0_2.gameRunFlag then
		local var_7_0 = var_0_4[var_0_5].trs
		local var_7_1 = var_0_7.parentTrs
		local var_7_2 = math.random(var_0_2.interval[1], var_0_2.interval[2]) * 10

		if not isNil(var_7_1) and var_7_1.rect.width / 2 - var_7_0.localPosition.x > var_7_0.rect.width + var_7_2 then
			var_0_5 = var_0_5 + 1

			local var_7_3 = math.random(1, 2)

			var_0_2.deterGenNum = var_0_2.deterGenNum + 1

			local var_7_4 = {
				index = var_0_5,
				type = var_7_3,
				totalNum = var_0_2.deterGenNum
			}

			var_0_4[var_0_5] = DormRhythmItemTemplate.New(var_0_7, var_7_4, var_0_8)

			var_0_13()
		end
	end

	if var_0_5 == 1 and not var_0_4[var_0_5] and var_0_2.gameRunFlag then
		local var_7_5 = math.random(1, 2)

		var_0_2.deterGenNum = var_0_2.deterGenNum + 1

		local var_7_6 = {
			index = var_0_5,
			type = var_7_5,
			totalNum = var_0_2.deterGenNum
		}

		var_0_4[var_0_5] = DormRhythmItemTemplate.New(var_0_7, var_7_6, var_0_8)

		var_0_13()
	end
end

local function var_0_16()
	if var_0_4 then
		for iter_8_0, iter_8_1 in pairs(var_0_4) do
			iter_8_1:Tick()
		end
	end
end

local function var_0_17()
	var_0_15()
	var_0_16()
end

local function var_0_18()
	if var_0_3 then
		for iter_10_0, iter_10_1 in pairs(var_0_3) do
			FuncTimerManager.inst:RemoveFuncTimer(iter_10_1)

			iter_10_1 = nil
		end
	end
end

local function var_0_19()
	var_0_18()

	var_0_3 = {}
	var_0_3.tickTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if not var_0_2.pauseFlag then
			var_0_17()
		end
	end, -1, true)
end

local function var_0_20(arg_13_0)
	var_0_1 = {}
	var_0_1.ratio = Screen.width / 1920
	var_0_1.diff = arg_13_0.diff
	var_0_1.heroID = arg_13_0.heroID
	var_0_7 = arg_13_0.goInfo

	local var_13_0 = arg_13_0.activityID or 1

	var_0_6 = DormRhythmGameTools:GetGameConfigData(var_13_0)
	var_0_8 = DormRhythmGameTools.gameConfigData[var_13_0].stageCfg

	if var_13_0 == 1 then
		var_0_1.levelID = arg_13_0.diff
	else
		var_0_1.levelID = var_0_8.get_id_list_by_difficult[arg_13_0.diff][1]
	end
end

local function var_0_21()
	if var_0_4 then
		for iter_14_0, iter_14_1 in pairs(var_0_4) do
			iter_14_1:Dispose()

			var_0_4[iter_14_0] = nil
		end
	end

	var_0_4 = nil
end

function var_0_0.GetLevelData(arg_15_0)
	return var_0_1
end

function var_0_0.GetRunTimeData(arg_16_0)
	return var_0_2
end

function var_0_0.GetResultInfo(arg_17_0)
	return {
		maxBatterNum = var_0_2.maxBatterNum,
		mistakeNum = var_0_2.mistakeNum,
		successfulNum = var_0_2.successfulNum
	}
end

function var_0_0.GetJudgeWidth(arg_18_0)
	return var_0_2.judgeWidth
end

function var_0_0.GetDeterLength(arg_19_0)
	return var_0_2.deterLength, var_0_1.ratio
end

function var_0_0.GetMistakeNum(arg_20_0)
	return var_0_2.mistakeNum or 0
end

function var_0_0.GetLevelIDByDiff(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_2 or 1

	if var_21_0 == 1 then
		return arg_21_1
	end

	local var_21_1 = DormRhythmGameTools.gameConfigData[var_21_0]

	if var_21_1 then
		return var_21_1.stageCfg.get_id_list_by_difficult[arg_21_1][1]
	end
end

function var_0_0.DisPoseItem(arg_22_0, arg_22_1)
	if var_0_4[arg_22_1] then
		var_0_4[arg_22_1]:Dispose()

		var_0_4[arg_22_1] = nil
	end
end

function var_0_0.GetGameInterval(arg_23_0)
	return var_0_2.interval
end

function var_0_0.GetGameSpeed(arg_24_0)
	return 1920 / (var_0_2.gameSpeed / 10) * Time.deltaTime
end

function var_0_0.GetGameRunFlag(arg_25_0)
	if var_0_2 then
		return var_0_2.gameRunFlag
	end
end

function var_0_0.Dispose(arg_26_0)
	var_0_18()
	var_0_21()

	var_0_1 = nil
	var_0_2 = nil
	var_0_3 = nil
	var_0_4 = nil
	var_0_7 = nil
end

function var_0_0.StartGame(arg_27_0, arg_27_1)
	if not var_0_2 or not var_0_2.gameRunFlag then
		var_0_20(arg_27_1)
		var_0_14()

		var_0_2.gameRunFlag = true

		var_0_19()
	else
		Debug.LogError("已开始游戏")
	end
end

function var_0_0.SetPauseFlag(arg_28_0, arg_28_1)
	var_0_2.pauseFlag = arg_28_1
end

function var_0_0.StopGame(arg_29_0)
	if var_0_2 and var_0_2.gameRunFlag then
		manager.audio:StopEffect()

		var_0_2.gameRunFlag = false

		var_0_18()
		var_0_21()
		manager.gc:Collect()
	end
end

function var_0_0.ClickDetermination(arg_30_0, arg_30_1)
	if var_0_2.gameRunFlag then
		local var_30_0 = {
			buttonType = arg_30_1,
			judgeWidth = var_0_2.judgeWidth
		}
		local var_30_1 = false

		if var_0_4 then
			local var_30_2 = false

			for iter_30_0, iter_30_1 in pairs(var_0_4) do
				if iter_30_1.go and not arg_30_0.hasCheck then
					local var_30_3, var_30_4 = iter_30_1:CheckHit(var_30_0)

					if var_30_4 then
						if not iter_30_1.hasHit then
							iter_30_1.hasHit = true
							var_30_2 = var_30_3
							var_30_1 = iter_30_1:IsLast()

							break
						else
							return nil
						end
					end
				end
			end

			var_0_0:UpdateBatterNum(var_30_2, arg_30_1, var_30_1)

			return var_30_2 and 1 or 0
		end
	end
end

function var_0_0.UpdateBatterNum(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_1 == nil then
		return
	end

	if arg_31_1 == true then
		var_0_2.successfulNum = var_0_2.successfulNum + 1
		var_0_2.batterNum = var_0_2.batterNum + 1
		var_0_2.maxBatterNum = math.max(var_0_2.maxBatterNum, var_0_2.batterNum)
	elseif arg_31_1 == false then
		var_0_2.maxBatterNum = math.max(var_0_2.maxBatterNum, var_0_2.batterNum)
		var_0_2.batterNum = 0
		var_0_2.mistakeNum = var_0_2.mistakeNum + 1
	end

	if var_0_2.gameRunFlag then
		manager.notify:Invoke(DORM_REFRESH_BATTER_NUM, arg_31_2, arg_31_3)
	end
end

return var_0_0
