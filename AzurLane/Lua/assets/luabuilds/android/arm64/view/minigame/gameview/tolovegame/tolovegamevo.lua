class = var_0_10000

local var_0_0 = var_0_10000("ToLoveGameVo")

var_0_0.game_id = nil
var_0_0.hub_id = nil
var_0_0.total_times = nil
var_0_0.drop = nil
var_0_0.story = nil
Application = var_1

local var_0_1

if not var_1.targetFrameRate then
	var_0_1 = 60
end

var_0_0.frameRate = var_0_1
var_0_0.gameTime = 0
var_0_0.gameStepTime = 0
var_0_0.doTime = 0
var_0_0.gameArrowTime = 0
var_0_0.gameMoveTime = 0
var_0_0.gameBombTime = 0
var_0_0.gameBombBlastTime = 0
var_0_0.deltaTime = 0
var_0_0.score = 0
var_0_0.startSettlement = false
var_0_0.showArrowFlag = true
var_0_0.playerMoveFlag = false
var_0_0.waitingFlag = false
var_0_0.currentPlayerPosition = {
	3,
	3
}
var_0_0.previousPlayerPosition = {
	3,
	3
}
var_0_0.safeCellPosition = {
	3,
	3
}
var_0_0.arrowList = {}
var_0_0.safeList = {}
var_0_0.nowArrowIndex = 1
var_0_0.nowBombIndex = 999
var_0_0.hasDone = false
var_0_0.canMove = false
var_0_0.bombBlast = false
var_0_0.highestScore = 0
var_0_0.combo = 0
var_0_0.buffIndex = 0
var_0_0.shieldCount = 0
var_0_0.shieldGetCombo = 0
var_0_0.arrowVideoCount = 2
var_0_0.moveCount = 2

function var_0_0.Init(arg_1_0, arg_1_1)
	var_0_0.game_id = arg_1_0
	var_0_0.hub_id = arg_1_1

	local var_1_0 = var_0_0

	pg = var_1_10003
	var_1_0.total_times = var_1_10003.mini_game_hub[var_0_0.hub_id].reward_need

	local var_1_1 = var_0_0

	pg = var_3
	var_1_1.drop = var_3.mini_game[var_0_0.game_id].simple_config_data.drop_ids

	local var_1_2 = var_0_0

	pg = var_3
	var_1_2.story = var_3.mini_game[var_0_0.game_id].simple_config_data.story

	return
end

function var_0_0.GetMiniGameData()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10002

	local var_2_0 = var_1_10000(var_1_10002)

	return var_0.GetMiniGameData(var_2_0, var_0_0.game_id)
end

function var_0_0.GetMiniGameHubData()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10002

	local var_3_0 = var_1_10000(var_1_10002)

	return var_0.GetHubByHubId(var_3_0, var_0_0.hub_id)
end

function var_0_0.Prepare()
	local var_4_0 = var_0_0

	PlayerPrefs = var_1_10001
	var_4_0.buffIndex = var_1_10001.GetInt("ToLoveGameBuff", 0)

	local var_4_1 = var_0_0

	ToLoveGameConst = var_1
	var_4_1.gameTime = var_1.gameTime

	if var_0_0.buffIndex == 3 or var_0_0.buffIndex == 6 or var_0_0.buffIndex == 7 then
		local var_4_2 = var_0_0

		ToLoveGameConst = var_1

		local var_4_3 = var_1.gameTime

		ToLoveGameConst = var_1_10002
		var_4_2.gameTime = var_4_3 + var_1_10002.addTime
	end

	var_0_0.gameStepTime = 0
	var_0_0.doTime = var_0_0.GetDoTime()
	var_0_0.gameArrowTime = 0
	var_0_0.gameMoveTime = 0
	var_0_0.gameBombTime = 0
	var_0_0.gameBombBlastTime = 0
	var_0_0.score = 0
	var_0_0.startSettlement = false
	var_0_0.showArrowFlag = false
	var_0_0.playerMoveFlag = true
	var_0_0.waitingFlag = false

	var_0_0.ChangeMotion()

	var_0_0.currentPlayerPosition = {
		3,
		3
	}
	var_0_0.previousPlayerPosition = {
		3,
		3
	}
	var_0_0.safeCellPosition = {
		3,
		3
	}
	var_0_0.hasDone = false
	var_0_0.canMove = false
	var_0_0.nowArrowIndex = 1
	var_0_0.nowBombIndex = 999
	var_0_0.bombBlast = false
	var_0_0.combo = 0
	var_0_0.shieldCount = 0

	if var_0_0.buffIndex == 1 or var_0_0.buffIndex == 4 or var_0_0.buffIndex == 7 then
		var_0_0.shieldCount = 1
	end

	var_0_0.shieldGetCombo = 0
	var_0_0.arrowVideoCount = 2
	var_0_0.moveCount = 2

	return
end

function var_0_0.ChangeMotion()
	if var_0_0.showArrowFlag then
		var_0_0.gameMoveTime = var_0_0.doTime
		var_0_0.gameBombTime = 0
		var_0_0.nowBombIndex = 1
		var_0_0.safeList = var_0_0.arrowList
		var_0_0.showArrowFlag = false
		var_0_0.playerMoveFlag = true
		var_0_0.waitingFlag = false
		var_0_0.hasDone = false
	elseif var_0_0.playerMoveFlag then
		var_0_0.showArrowFlag = false
		var_0_0.playerMoveFlag = false
		var_0_0.waitingFlag = true
	elseif var_0_0.waitingFlag then
		local var_5_0 = var_0_0.GetArrowNum()

		var_0_0.SetRandomArrawList(var_5_0)

		var_0_0.doTime = var_0_0.GetDoTime()
		var_0_0.gameArrowTime = var_0_0.doTime
		var_0_0.nowArrowIndex = 1
		var_0_0.arrowVideoCount = var_5_0
		var_0_0.moveCount = var_5_0
		var_0_0.showArrowFlag = true
		var_0_0.playerMoveFlag = false
		var_0_0.waitingFlag = false
		var_0_0.hasDone = false
	end

	return
end

function var_0_0.GetArrowNum()
	local var_6_0 = 2

	ipairs = var_1_10001
	ToLoveGameConst = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10001(var_1_10003.remainingTimeToArrowNumber) do
		local var_6_1 = var_0_0.gameTime

		ToLoveGameConst = var_1_10007

		if var_1_10007.remainingTimeToArrowTime[iter_6_0] <= var_6_1 then
			return iter_6_1
		end
	end

	return
end

function var_0_0.GetDoTime()
	ToLoveGameConst = var_1_10000

	return var_1_10000.motionTime / var_0_0.GetArrowNum()
end

function var_0_0.SetRandomArrawList(arg_8_0)
	var_0_0.arrowList = {}

	for iter_8_0 = 1, arg_8_0 do
		math = var_1_10005

		if 4 * var_1_10005.random() < 1 then
			table = var_6

			local var_8_0 = var_6.insert
			local var_8_1 = var_0_0.arrowList

			ToLoveGameConst = var_1_10009

			var_8_0(var_8_1, var_1_10009.arrowUp)
		elseif var_1_10005 < 2 then
			table = var_6

			local var_8_2 = var_6.insert
			local var_8_3 = var_0_0.arrowList

			ToLoveGameConst = var_1_10009

			var_8_2(var_8_3, var_1_10009.arrowDown)
		else
			local var_8_4

			if var_1_10005 < 3 then
				table = var_8_4
				var_8_4 = var_8_4.insert

				local var_8_5 = var_0_0.arrowList

				ToLoveGameConst = var_1_10009

				var_8_4(var_8_5, var_1_10009.arrowLeft)
			else
				table = var_8_4

				local var_8_6 = var_8_4.insert
				local var_8_7 = var_0_0.arrowList

				ToLoveGameConst = var_1_10009

				var_8_6(var_8_7, var_1_10009.arrowRight)
			end
		end
	end

	return
end

function var_0_0.GetSafeCellPosition(arg_9_0)
	Clone = var_1_10001

	local var_9_0 = var_1_10001(var_0_0.previousPlayerPosition)

	ToLoveGameConst = var_1_10002

	if arg_9_0 == var_1_10002.arrowUp then
		var_9_0[1] = var_0_0.previousPlayerPosition[1] - 1

		if var_9_0[1] == 0 then
			var_9_0[1] = 5
		end
	else
		ToLoveGameConst = var_2

		if arg_9_0 == var_2.arrowDown then
			var_9_0[1] = var_0_0.previousPlayerPosition[1] + 1

			if var_9_0[1] == 6 then
				var_9_0[1] = 1
			end
		else
			ToLoveGameConst = var_2

			if arg_9_0 == var_2.arrowLeft then
				var_9_0[2] = var_0_0.previousPlayerPosition[2] - 1

				if var_9_0[2] == 0 then
					var_9_0[2] = 5
				end
			else
				ToLoveGameConst = var_2

				if arg_9_0 == var_2.arrowRight then
					var_9_0[2] = var_0_0.previousPlayerPosition[2] + 1

					if var_9_0[2] == 6 then
						var_9_0[2] = 1
					end
				end
			end
		end
	end

	return var_9_0
end

function var_0_0.GetBuffList(arg_10_0)
	Clone = var_1_10001
	ToLoveGameConst = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003.buffList)[1]

	i18n = var_3
	var_10_0[1] = var_3("tolovegame_buff_name_1")

	local var_10_1 = var_1[2]

	i18n = var_3
	var_10_1[1] = var_3("tolovegame_buff_name_2")

	local var_10_2 = var_1[3]

	i18n = var_3
	var_10_2[1] = var_3("tolovegame_buff_name_3")

	local var_10_3 = var_1[4]

	i18n = var_3
	var_10_3[1] = var_3("tolovegame_buff_name_4")

	local var_10_4 = var_1[5]

	i18n = var_3
	var_10_4[1] = var_3("tolovegame_buff_name_5")

	local var_10_5 = var_1[6]

	i18n = var_3
	var_10_5[1] = var_3("tolovegame_buff_name_6")

	local var_10_6 = var_1[7]

	i18n = var_3
	var_10_6[1] = var_3("tolovegame_buff_name_7")
	table = var_10_6

	local var_10_7 = var_10_6.insert
	local var_10_8 = var_1[1]

	i18n = var_5

	var_10_7(var_10_8, var_5("tolovegame_buff_desc_1"))

	table = var_10_7

	local var_10_9 = var_10_7.insert
	local var_10_10 = var_1[2]

	i18n = var_5

	var_10_9(var_10_10, var_5("tolovegame_buff_desc_2"))

	table = var_10_9

	local var_10_11 = var_10_9.insert
	local var_10_12 = var_1[3]

	i18n = var_5

	var_10_11(var_10_12, var_5("tolovegame_buff_desc_3"))

	table = var_10_11

	local var_10_13 = var_10_11.insert
	local var_10_14 = var_1[4]

	i18n = var_5

	var_10_13(var_10_14, var_5("tolovegame_buff_desc_4"))

	table = var_10_13

	local var_10_15 = var_10_13.insert
	local var_10_16 = var_1[5]

	i18n = var_5

	var_10_15(var_10_16, var_5("tolovegame_buff_desc_5"))

	table = var_10_15

	local var_10_17 = var_10_15.insert
	local var_10_18 = var_1[6]

	i18n = var_5

	var_10_17(var_10_18, var_5("tolovegame_buff_desc_6"))

	table = var_10_17

	local var_10_19 = var_10_17.insert
	local var_10_20 = var_1[7]

	i18n = var_5

	var_10_19(var_10_20, var_5("tolovegame_buff_desc_7"))

	local var_10_21 = arg_10_0
	local var_10_22 = arg_10_0.getConfig(var_10_21, "act_id")

	pg = var_3

	local var_10_23 = var_3.activity_template[var_10_22].time

	type = var_10_21

	if var_10_21(var_10_23) == "table" then
		pg = var_4

		local var_10_24 = var_4.TimeMgr.GetInstance()
		local var_10_25 = var_4.GetServerTime(var_10_24)

		pg = var_5

		local var_10_26 = var_5.TimeMgr.GetInstance()
		local var_10_27 = var_5.parseTimeFromConfig(var_10_26, var_10_23[2])
		local var_10_28 = 3600
		local var_10_29 = 0

		for iter_10_0 = 1, #var_1 do
			math = var_1_10012
			var_1_10012 = var_1_10012.floor((var_10_27 + (iter_10_0 - 1) * var_10_29 - var_10_25) / var_10_29)
			math = var_1_10013
			var_1_10013 = var_1_10013.floor((var_10_27 + (iter_10_0 - 1) * var_10_29 - var_10_25) % var_10_29 / var_10_28)

			local var_10_30

			if var_10_27 + (iter_10_0 - 1) * var_10_29 - var_10_25 > 0 then
				if 0 < var_1_10012 then
					table = var_10_30
					var_10_30 = var_10_30.insert

					local var_10_31 = var_1[iter_10_0]

					i18n = var_1_10017

					var_10_30(var_10_31, var_1_10017("tolovegame_lock_1", var_1_10012, var_1_10013))
				else
					table = var_10_30
					var_10_30 = var_10_30.insert

					local var_10_32 = var_1[iter_10_0]

					i18n = var_1_10017

					var_10_30(var_10_32, var_1_10017("tolovegame_lock_2", var_1_10013))
				end
			else
				table = var_10_30

				var_10_30.insert(var_1[iter_10_0], "")
			end
		end
	else
		for iter_10_1 = 1, #var_1 do
			table = var_1_10008

			var_1_10008.insert(var_1[iter_10_1], "")
		end
	end

	return var_1
end

function var_0_0.GetScoreMultiplyRate()
	local var_11_0 = 1

	ipairs = var_1_10001
	ToLoveGameConst = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10001(var_1_10003.scoreMultiplyRate) do
		local var_11_1 = var_0_0.gameTime

		ToLoveGameConst = var_1_10007

		if var_1_10007.scoreMultiplyTimes[iter_11_0] <= var_11_1 then
			return iter_11_1
		end
	end

	return
end

function var_0_0.ShouldShowTip()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10002

	local var_12_0 = var_1_10000(var_1_10002)
	local var_12_1 = var_0.GetHubByGameId(var_12_0, 69).count > 0
	local var_12_2 = false
	local var_12_3 = 0
	local var_12_4 = var_0_0.GetBuffList(var_0)

	ipairs = var_1_10005

	for iter_12_0, iter_12_1 in var_1_10005(var_12_4) do
		if iter_12_1[3] == "" then
			var_12_3 = var_12_3 + 1
		end
	end

	PlayerPrefs = var_5

	if var_12_3 ~= var_5.GetInt("toLoveGameBuffCount", 0) then
		var_12_2 = true
	end

	local var_12_5 = false

	getProxy = var_7
	ActivityProxy = iter_12_1

	local var_12_6 = var_7(iter_12_1)
	local var_12_7 = var_7.getActivityById

	ActivityConst = var_1_10010

	local var_12_8 = var_12_7(var_12_6, var_1_10010.TOLOVE_MINIGAME_TASK_ID)
	local var_12_9 = var_7.getConfig(var_12_8, "config_client").task_ids

	pairs = var_12_6

	for iter_12_2, iter_12_3 in var_12_6(var_12_9) do
		getProxy = var_1_10014
		TaskProxy = var_1_10016
		var_1_10016 = var_1_10014(var_1_10016)

		local var_12_10 = var_1_10014.getTaskVO(var_1_10016, iter_12_3)

		if var_1_10014.getTaskStatus(var_12_10) == 1 then
			var_12_5 = true

			break
		end
	end

	if var_12_1 or var_12_2 or var_12_5 then
		return true
	end

	return false
end

return var_0_0
