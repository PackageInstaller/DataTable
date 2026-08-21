local var_0_0 = class("ToLoveGameVo")

var_0_0.game_id = nil
var_0_0.hub_id = nil
var_0_0.total_times = nil
var_0_0.drop = nil
var_0_0.story = nil
var_0_0.frameRate = Application.targetFrameRate or 60
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
	var_0_0.total_times = pg.mini_game_hub[var_0_0.hub_id].reward_need
	var_0_0.drop = pg.mini_game[var_0_0.game_id].simple_config_data.drop_ids
	var_0_0.story = pg.mini_game[var_0_0.game_id].simple_config_data.story

	return
end

function var_0_0.GetMiniGameData()
	return getProxy(MiniGameProxy):GetMiniGameData(var_0_0.game_id)
end

function var_0_0.GetMiniGameHubData()
	return getProxy(MiniGameProxy):GetHubByHubId(var_0_0.hub_id)
end

function var_0_0.Prepare()
	var_0_0.buffIndex = PlayerPrefs.GetInt("ToLoveGameBuff", 0)
	var_0_0.gameTime = ToLoveGameConst.gameTime

	if var_0_0.buffIndex == 3 or var_0_0.buffIndex == 6 or var_0_0.buffIndex == 7 then
		var_0_0.gameTime = ToLoveGameConst.gameTime + ToLoveGameConst.addTime
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
	for iter_6_0, iter_6_1 in ipairs(ToLoveGameConst.remainingTimeToArrowNumber) do
		if var_0_0.gameTime >= ToLoveGameConst.remainingTimeToArrowTime[iter_6_0] then
			return iter_6_1
		end
	end

	return
end

function var_0_0.GetDoTime()
	return ToLoveGameConst.motionTime / var_0_0.GetArrowNum()
end

function var_0_0.SetRandomArrawList(arg_8_0)
	var_0_0.arrowList = {}

	for iter_8_0 = 1, arg_8_0 do
		local var_8_0 = 4 * math.random()

		if var_8_0 < 1 then
			table.insert(var_0_0.arrowList, ToLoveGameConst.arrowUp)
		elseif var_8_0 < 2 then
			table.insert(var_0_0.arrowList, ToLoveGameConst.arrowDown)
		elseif var_8_0 < 3 then
			table.insert(var_0_0.arrowList, ToLoveGameConst.arrowLeft)
		else
			table.insert(var_0_0.arrowList, ToLoveGameConst.arrowRight)
		end
	end

	return
end

function var_0_0.GetSafeCellPosition(arg_9_0)
	local var_9_0 = Clone(var_0_0.previousPlayerPosition)

	if arg_9_0 == ToLoveGameConst.arrowUp then
		var_9_0[1] = var_0_0.previousPlayerPosition[1] - 1

		if var_9_0[1] == 0 then
			var_9_0[1] = 5
		end
	elseif arg_9_0 == ToLoveGameConst.arrowDown then
		var_9_0[1] = var_0_0.previousPlayerPosition[1] + 1

		if var_9_0[1] == 6 then
			var_9_0[1] = 1
		end
	elseif arg_9_0 == ToLoveGameConst.arrowLeft then
		var_9_0[2] = var_0_0.previousPlayerPosition[2] - 1

		if var_9_0[2] == 0 then
			var_9_0[2] = 5
		end
	elseif arg_9_0 == ToLoveGameConst.arrowRight then
		var_9_0[2] = var_0_0.previousPlayerPosition[2] + 1

		if var_9_0[2] == 6 then
			var_9_0[2] = 1
		end
	end

	return var_9_0
end

function var_0_0.GetBuffList(arg_10_0)
	local var_10_0 = Clone(ToLoveGameConst.buffList)

	var_10_0[1][1] = i18n("tolovegame_buff_name_1")
	var_10_0[2][1] = i18n("tolovegame_buff_name_2")
	var_10_0[3][1] = i18n("tolovegame_buff_name_3")
	var_10_0[4][1] = i18n("tolovegame_buff_name_4")
	var_10_0[5][1] = i18n("tolovegame_buff_name_5")
	var_10_0[6][1] = i18n("tolovegame_buff_name_6")
	var_10_0[7][1] = i18n("tolovegame_buff_name_7")

	table.insert(var_10_0[1], i18n("tolovegame_buff_desc_1"))
	table.insert(var_10_0[2], i18n("tolovegame_buff_desc_2"))
	table.insert(var_10_0[3], i18n("tolovegame_buff_desc_3"))
	table.insert(var_10_0[4], i18n("tolovegame_buff_desc_4"))
	table.insert(var_10_0[5], i18n("tolovegame_buff_desc_5"))
	table.insert(var_10_0[6], i18n("tolovegame_buff_desc_6"))
	table.insert(var_10_0[7], i18n("tolovegame_buff_desc_7"))

	local var_10_1 = pg.activity_template[arg_10_0:getConfig("act_id")].time

	if type(var_10_1) == "table" then
		local var_10_2 = pg.TimeMgr.GetInstance():GetServerTime()
		local var_10_3 = pg.TimeMgr.GetInstance():parseTimeFromConfig(var_10_1[2])

		for iter_10_0 = 1, #var_10_0 do
			local var_10_4 = math.floor((var_10_3 + (iter_10_0 - 1) * 0 - var_10_2) / 0)
			local var_10_5 = math.floor((var_10_3 + (iter_10_0 - 1) * 0 - var_10_2) % 0 / 3600)

			if var_10_3 + (iter_10_0 - 1) * 0 - var_10_2 > 0 then
				if var_10_4 > 0 then
					table.insert(var_10_0[iter_10_0], i18n("tolovegame_lock_1", var_10_4, var_10_5))
				else
					table.insert(var_10_0[iter_10_0], i18n("tolovegame_lock_2", var_10_5))
				end
			else
				table.insert(var_10_0[iter_10_0], "")
			end
		end
	else
		for iter_10_1 = 1, #var_10_0 do
			table.insert(var_10_0[iter_10_1], "")
		end
	end

	return var_10_0
end

function var_0_0.GetScoreMultiplyRate()
	for iter_11_0, iter_11_1 in ipairs(ToLoveGameConst.scoreMultiplyRate) do
		if var_0_0.gameTime >= ToLoveGameConst.scoreMultiplyTimes[iter_11_0] then
			return iter_11_1
		end
	end

	return
end

function var_0_0.ShouldShowTip()
	local var_12_0 = getProxy(MiniGameProxy):GetHubByGameId(69)
	local var_12_1 = var_12_0.count > 0
	local var_12_2 = false
	local var_12_3 = 0

	for iter_12_0, iter_12_1 in ipairs((var_0_0.GetBuffList(var_12_0))) do
		if iter_12_1[3] == "" then
			var_12_3 = var_12_3 + 1
		end
	end

	if var_12_3 ~= PlayerPrefs.GetInt("toLoveGameBuffCount", 0) then
		var_12_2 = true
	end

	local var_12_4 = false

	for iter_12_2, iter_12_3 in pairs(getProxy(ActivityProxy):getActivityById(ActivityConst.TOLOVE_MINIGAME_TASK_ID):getConfig("config_client").task_ids) do
		local var_12_5 = getProxy(TaskProxy):getTaskVO(iter_12_3)

		if var_12_5:getTaskStatus() == 1 then
			var_12_4 = true

			break
		end
	end

	if var_12_1 or var_12_2 or var_12_4 then
		return true
	end

	return false
end

return var_0_0
