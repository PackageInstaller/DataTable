local ToLoveGameVo = class("ToLoveGameVo")

ToLoveGameVo.game_id = nil
ToLoveGameVo.hub_id = nil
ToLoveGameVo.total_times = nil
ToLoveGameVo.drop = nil
ToLoveGameVo.story = nil
ToLoveGameVo.frameRate = Application.targetFrameRate or 60
ToLoveGameVo.gameTime = 0
ToLoveGameVo.gameStepTime = 0
ToLoveGameVo.doTime = 0
ToLoveGameVo.gameArrowTime = 0
ToLoveGameVo.gameMoveTime = 0
ToLoveGameVo.gameBombTime = 0
ToLoveGameVo.gameBombBlastTime = 0
ToLoveGameVo.deltaTime = 0
ToLoveGameVo.score = 0
ToLoveGameVo.startSettlement = false
ToLoveGameVo.showArrowFlag = true
ToLoveGameVo.playerMoveFlag = false
ToLoveGameVo.waitingFlag = false
ToLoveGameVo.currentPlayerPosition = {
	3,
	3
}
ToLoveGameVo.previousPlayerPosition = {
	3,
	3
}
ToLoveGameVo.safeCellPosition = {
	3,
	3
}
ToLoveGameVo.arrowList = {}
ToLoveGameVo.safeList = {}
ToLoveGameVo.nowArrowIndex = 1
ToLoveGameVo.nowBombIndex = 999
ToLoveGameVo.hasDone = false
ToLoveGameVo.canMove = false
ToLoveGameVo.bombBlast = false
ToLoveGameVo.highestScore = 0
ToLoveGameVo.combo = 0
ToLoveGameVo.buffIndex = 0
ToLoveGameVo.shieldCount = 0
ToLoveGameVo.shieldGetCombo = 0
ToLoveGameVo.arrowVideoCount = 2
ToLoveGameVo.moveCount = 2

function ToLoveGameVo:Init(arg_1_1)
	ToLoveGameVo.game_id = self
	ToLoveGameVo.hub_id = arg_1_1
	ToLoveGameVo.total_times = pg.mini_game_hub[ToLoveGameVo.hub_id].reward_need
	ToLoveGameVo.drop = pg.mini_game[ToLoveGameVo.game_id].simple_config_data.drop_ids
	ToLoveGameVo.story = pg.mini_game[ToLoveGameVo.game_id].simple_config_data.story

	return
end

function ToLoveGameVo.GetMiniGameData()
	return getProxy(MiniGameProxy):GetMiniGameData(ToLoveGameVo.game_id)
end

function ToLoveGameVo.GetMiniGameHubData()
	return getProxy(MiniGameProxy):GetHubByHubId(ToLoveGameVo.hub_id)
end

function ToLoveGameVo.Prepare()
	ToLoveGameVo.buffIndex = PlayerPrefs.GetInt("ToLoveGameBuff", 0)
	ToLoveGameVo.gameTime = ToLoveGameConst.gameTime

	if ToLoveGameVo.buffIndex == 3 or ToLoveGameVo.buffIndex == 6 or ToLoveGameVo.buffIndex == 7 then
		ToLoveGameVo.gameTime = ToLoveGameConst.gameTime + ToLoveGameConst.addTime
	end

	ToLoveGameVo.gameStepTime = 0
	ToLoveGameVo.doTime = ToLoveGameVo.GetDoTime()
	ToLoveGameVo.gameArrowTime = 0
	ToLoveGameVo.gameMoveTime = 0
	ToLoveGameVo.gameBombTime = 0
	ToLoveGameVo.gameBombBlastTime = 0
	ToLoveGameVo.score = 0
	ToLoveGameVo.startSettlement = false
	ToLoveGameVo.showArrowFlag = false
	ToLoveGameVo.playerMoveFlag = true
	ToLoveGameVo.waitingFlag = false

	ToLoveGameVo.ChangeMotion()

	ToLoveGameVo.currentPlayerPosition = {
		3,
		3
	}
	ToLoveGameVo.previousPlayerPosition = {
		3,
		3
	}
	ToLoveGameVo.safeCellPosition = {
		3,
		3
	}
	ToLoveGameVo.hasDone = false
	ToLoveGameVo.canMove = false
	ToLoveGameVo.nowArrowIndex = 1
	ToLoveGameVo.nowBombIndex = 999
	ToLoveGameVo.bombBlast = false
	ToLoveGameVo.combo = 0
	ToLoveGameVo.shieldCount = 0

	if ToLoveGameVo.buffIndex == 1 or ToLoveGameVo.buffIndex == 4 or ToLoveGameVo.buffIndex == 7 then
		ToLoveGameVo.shieldCount = 1
	end

	ToLoveGameVo.shieldGetCombo = 0
	ToLoveGameVo.arrowVideoCount = 2
	ToLoveGameVo.moveCount = 2

	return
end

function ToLoveGameVo.ChangeMotion()
	if ToLoveGameVo.showArrowFlag then
		ToLoveGameVo.gameMoveTime = ToLoveGameVo.doTime
		ToLoveGameVo.gameBombTime = 0
		ToLoveGameVo.nowBombIndex = 1
		ToLoveGameVo.safeList = ToLoveGameVo.arrowList
		ToLoveGameVo.showArrowFlag = false
		ToLoveGameVo.playerMoveFlag = true
		ToLoveGameVo.waitingFlag = false
		ToLoveGameVo.hasDone = false
	elseif ToLoveGameVo.playerMoveFlag then
		ToLoveGameVo.showArrowFlag = false
		ToLoveGameVo.playerMoveFlag = false
		ToLoveGameVo.waitingFlag = true
	elseif ToLoveGameVo.waitingFlag then
		local var_5_0 = ToLoveGameVo.GetArrowNum()

		ToLoveGameVo.SetRandomArrawList(var_5_0)

		ToLoveGameVo.doTime = ToLoveGameVo.GetDoTime()
		ToLoveGameVo.gameArrowTime = ToLoveGameVo.doTime
		ToLoveGameVo.nowArrowIndex = 1
		ToLoveGameVo.arrowVideoCount = var_5_0
		ToLoveGameVo.moveCount = var_5_0
		ToLoveGameVo.showArrowFlag = true
		ToLoveGameVo.playerMoveFlag = false
		ToLoveGameVo.waitingFlag = false
		ToLoveGameVo.hasDone = false
	end

	return
end

function ToLoveGameVo.GetArrowNum()
	for iter_6_0, iter_6_1 in ipairs(ToLoveGameConst.remainingTimeToArrowNumber) do
		if ToLoveGameVo.gameTime >= ToLoveGameConst.remainingTimeToArrowTime[iter_6_0] then
			return iter_6_1
		end
	end

	return
end

function ToLoveGameVo.GetDoTime()
	return ToLoveGameConst.motionTime / ToLoveGameVo.GetArrowNum()
end

function ToLoveGameVo:SetRandomArrawList()
	ToLoveGameVo.arrowList = {}

	for iter_8_0 = 1, self do
		local var_8_0 = 4 * math.random()

		if var_8_0 < 1 then
			table.insert(ToLoveGameVo.arrowList, ToLoveGameConst.arrowUp)
		elseif var_8_0 < 2 then
			table.insert(ToLoveGameVo.arrowList, ToLoveGameConst.arrowDown)
		elseif var_8_0 < 3 then
			table.insert(ToLoveGameVo.arrowList, ToLoveGameConst.arrowLeft)
		else
			table.insert(ToLoveGameVo.arrowList, ToLoveGameConst.arrowRight)
		end
	end

	return
end

function ToLoveGameVo:GetSafeCellPosition()
	local var_9_0 = Clone(ToLoveGameVo.previousPlayerPosition)

	if self == ToLoveGameConst.arrowUp then
		var_9_0[1] = ToLoveGameVo.previousPlayerPosition[1] - 1

		if var_9_0[1] == 0 then
			var_9_0[1] = 5
		end
	elseif self == ToLoveGameConst.arrowDown then
		var_9_0[1] = ToLoveGameVo.previousPlayerPosition[1] + 1

		if var_9_0[1] == 6 then
			var_9_0[1] = 1
		end
	elseif self == ToLoveGameConst.arrowLeft then
		var_9_0[2] = ToLoveGameVo.previousPlayerPosition[2] - 1

		if var_9_0[2] == 0 then
			var_9_0[2] = 5
		end
	elseif self == ToLoveGameConst.arrowRight then
		var_9_0[2] = ToLoveGameVo.previousPlayerPosition[2] + 1

		if var_9_0[2] == 6 then
			var_9_0[2] = 1
		end
	end

	return var_9_0
end

function ToLoveGameVo:GetBuffList()
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

	local var_10_1 = pg.activity_template[self:getConfig("act_id")].time

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

function ToLoveGameVo.GetScoreMultiplyRate()
	for iter_11_0, iter_11_1 in ipairs(ToLoveGameConst.scoreMultiplyRate) do
		if ToLoveGameVo.gameTime >= ToLoveGameConst.scoreMultiplyTimes[iter_11_0] then
			return iter_11_1
		end
	end

	return
end

function ToLoveGameVo.ShouldShowTip()
	local var_12_0 = getProxy(MiniGameProxy):GetHubByGameId(69)
	local var_12_1 = var_12_0.count > 0
	local var_12_2 = false
	local var_12_3 = 0

	for iter_12_0, iter_12_1 in ipairs((ToLoveGameVo.GetBuffList(var_12_0))) do
		if iter_12_1[3] == "" then
			var_12_3 = var_12_3 + 1
		end
	end

	if var_12_3 ~= PlayerPrefs.GetInt("toLoveGameBuffCount", 0) then
		var_12_2 = true
	end

	local var_12_4 = false

	for iter_12_2, iter_12_3 in pairs(getProxy(ActivityProxy):getActivityById(ActivityConst.TOLOVE_MINIGAME_TASK_ID):getConfig("config_client").task_ids) do
		if getProxy(TaskProxy):getTaskVO(iter_12_3):getTaskStatus() == 1 then
			var_12_4 = true

			break
		end
	end

	if var_12_1 or var_12_2 or var_12_4 then
		return true
	end

	return false
end

return ToLoveGameVo
