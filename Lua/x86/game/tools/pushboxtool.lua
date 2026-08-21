local var_0_0 = {}
local var_0_1 = 99
local var_0_2 = GameDisplayCfg.activity_celebration_grid_max_length.value[1]
local var_0_3 = GameDisplayCfg.activity_celebration_box_speed and GameDisplayCfg.activity_celebration_box_speed.value[1] or 0.5
local var_0_4 = 0
local var_0_5 = 0

function var_0_0.GetFatigueID(arg_1_0, arg_1_1)
	local var_1_0 = GameSetting.activity_fatigue_info.value

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1[1] == arg_1_1 then
			return iter_1_1[2]
		end
	end
end

function var_0_0.GetFatigueMax(arg_2_0, arg_2_1)
	local var_2_0 = 0
	local var_2_1 = GameSetting.activity_celebration_cake_fatigue_default.value

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		if iter_2_1[1] == arg_2_1 then
			var_2_0 = iter_2_1[2]

			break
		end
	end

	return var_2_0
end

function var_0_0.SetStartTime(arg_3_0)
	var_0_4 = manager.time:GetServerTime()
end

function var_0_0.SendSdk(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	var_0_5 = manager.time:GetServerTime()

	local var_4_0 = var_0_5 - var_0_4
	local var_4_1 = {
		activity_id = arg_4_1,
		stage_id = arg_4_2,
		result = arg_4_3,
		use_seconds = var_4_0
	}

	SDKTools.SendMessageToSDK("activity_combat_over", var_4_1)
end

function var_0_0.Init(arg_5_0)
	if arg_5_0.isInit_ then
		return
	end

	arg_5_0.isInit_ = true
	arg_5_0.boxItem_ = {}
	arg_5_0.cellItem_ = {}
	arg_5_0.mapSize_ = 1
	arg_5_0.mapWidth_ = 1
	arg_5_0.mapHeight_ = 1
	arg_5_0.cellWidth_ = 1
	arg_5_0.actionCnt_ = 0
	arg_5_0.routhMap_ = {}
	arg_5_0.dirMap_ = {}
	arg_5_0.tween_ = nil
	arg_5_0.goalTbl_ = {}
end

function var_0_0.InitMap(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	arg_6_0:Init()

	local var_6_0 = ActivityCelebrationGameCfg[arg_6_1]

	arg_6_0.mapWidth_ = var_6_0.width
	arg_6_0.mapHeight_ = var_6_0.height
	arg_6_0.mapSize_ = arg_6_0.mapWidth_ * arg_6_0.mapHeight_

	local var_6_1 = arg_6_4.rect.width
	local var_6_2 = arg_6_4.rect.height
	local var_6_3 = var_6_1 / arg_6_0.mapWidth_
	local var_6_4 = var_6_2 / arg_6_0.mapHeight_

	arg_6_0.cellWidth_ = var_6_3 < var_6_4 and var_6_3 or var_6_4
	arg_6_0.cellWidth_ = arg_6_0.cellWidth_ > var_0_2 and var_0_2 or arg_6_0.cellWidth_
	arg_6_2:GetComponent("GridLayoutGroup").cellSize = Vector2.New(arg_6_0.cellWidth_, arg_6_0.cellWidth_)
	arg_6_2.sizeDelta = Vector2.New(arg_6_0.mapWidth_ * arg_6_0.cellWidth_, arg_6_0.mapHeight_ * arg_6_0.cellWidth_)
	arg_6_3.sizeDelta = Vector2.New(arg_6_0.mapWidth_ * arg_6_0.cellWidth_, arg_6_0.mapHeight_ * arg_6_0.cellWidth_)

	local var_6_5 = {}
	local var_6_6 = ActivityCelebrationBoxCfg.get_id_list_by_mapId[var_6_0.mapId]

	for iter_6_0, iter_6_1 in ipairs(var_6_6) do
		local var_6_7 = ActivityCelebrationBoxCfg[iter_6_1]
		local var_6_8 = var_6_7.x + (var_6_7.y - 1) * arg_6_0.mapWidth_

		table.insert(var_6_5, {
			var_6_8,
			var_6_7.type
		})
	end

	table.sort(var_6_5, function(arg_7_0, arg_7_1)
		return arg_7_0[1] < arg_7_1[1]
	end)

	arg_6_0.goalTbl_ = {}

	local var_6_9 = 1
	local var_6_10 = arg_6_0.mapWidth_ * arg_6_0.mapHeight_

	for iter_6_2 = 1, var_6_10 do
		if not arg_6_0.cellItem_[iter_6_2] then
			local var_6_11 = Object.Instantiate(arg_6_5, arg_6_2)

			arg_6_0.cellItem_[iter_6_2] = PushBoxCellItem.New(var_6_11)
		end

		local var_6_12 = iter_6_2 % arg_6_0.mapWidth_ == 0 and arg_6_0.mapWidth_ or iter_6_2 % arg_6_0.mapWidth_
		local var_6_13 = iter_6_2 % arg_6_0.mapWidth_ == 0 and iter_6_2 / arg_6_0.mapWidth_ or math.floor(iter_6_2 / arg_6_0.mapWidth_) + 1
		local var_6_14 = PushBoxConst.CELL_TYPE.NORMAL

		if var_6_5[var_6_9] and var_6_5[var_6_9][1] == iter_6_2 then
			var_6_14 = var_6_5[var_6_9][2]
			var_6_9 = var_6_9 + 1
		end

		if var_6_14 == PushBoxConst.CELL_TYPE.GOAL then
			table.insert(arg_6_0.goalTbl_, iter_6_2)
		end

		arg_6_0.cellItem_[iter_6_2]:SetData(var_6_12, var_6_13, var_6_14)
		SetActive(arg_6_0.cellItem_[iter_6_2].gameObject_, true)
	end

	for iter_6_3 = var_6_10 + 1, #arg_6_0.cellItem_ do
		SetActive(arg_6_0.cellItem_[iter_6_3].gameObject_, false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_2)

	local var_6_15 = var_6_0.box_list

	for iter_6_4, iter_6_5 in ipairs(var_6_15) do
		if not arg_6_0.boxItem_[iter_6_4] then
			local var_6_16 = Object.Instantiate(arg_6_6, arg_6_3)

			arg_6_0.boxItem_[iter_6_4] = PushBoxItem.New(var_6_16)
		end

		arg_6_0.boxItem_[iter_6_4]:SetSize(arg_6_0.cellWidth_)

		local var_6_17 = iter_6_5[1]
		local var_6_18 = iter_6_5[2]

		arg_6_0:SyncBoxPosition(iter_6_4, var_6_17, var_6_18)
		arg_6_0.boxItem_[iter_6_4]:SetData(iter_6_4)
		SetActive(arg_6_0.boxItem_[iter_6_4].gameObject_, true)
	end

	for iter_6_6 = #var_6_15 + 1, #arg_6_0.boxItem_ do
		SetActive(arg_6_0.boxItem_[iter_6_6].gameObject_, false)
	end

	return arg_6_0.boxItem_, arg_6_0.cellItem_, arg_6_0.goalTbl_
end

function var_0_0.GetCellIndex(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0.mapWidth_ * (arg_8_2 - 1) + arg_8_1
end

function var_0_0.SyncBoxPosition(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0:GetCellIndex(arg_9_2, arg_9_3)
	local var_9_1, var_9_2 = arg_9_0.cellItem_[var_9_0]:GetLoaclPosition()

	arg_9_0.boxItem_[arg_9_1]:SetPos(arg_9_2, arg_9_3, var_9_1, var_9_2)
end

function var_0_0.OperateMove(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.actionCnt_ = 0
	arg_10_0.routhMap_ = {}
	arg_10_0.dirMap_ = {}

	local var_10_0, var_10_1 = arg_10_0.boxItem_[arg_10_3]:GetCoordinate()

	if arg_10_0:CalMove(var_10_0, var_10_1, arg_10_1, arg_10_2) then
		if #arg_10_0.routhMap_ <= 1 then
			manager.notify:Invoke(PUSH_BOX_STOP)

			return
		end

		manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_carmove")
		arg_10_0:AniMove(2, arg_10_3)
	end
end

function var_0_0.CalMove(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_0.actionCnt_ = arg_11_0.actionCnt_ + 1

	table.insert(arg_11_0.routhMap_, {
		arg_11_1,
		arg_11_2
	})
	table.insert(arg_11_0.dirMap_, {
		arg_11_3,
		arg_11_4
	})

	local var_11_0 = arg_11_0:GetCellIndex(arg_11_1, arg_11_2)
	local var_11_1 = arg_11_0.cellItem_[var_11_0]

	if var_11_1:GetType() == PushBoxConst.CELL_TYPE.GOAL and arg_11_0.actionCnt_ > 1 then
		return true
	end

	if arg_11_0.actionCnt_ >= var_0_1 then
		error("路径过长")

		return false
	end

	local var_11_2 = arg_11_1 + arg_11_3
	local var_11_3 = arg_11_2 + arg_11_4
	local var_11_4 = arg_11_0:GetCellIndex(var_11_2, var_11_3)

	if var_11_2 < 1 or var_11_3 < 1 or var_11_2 > arg_11_0.mapWidth_ or var_11_3 > arg_11_0.mapHeight_ then
		return true
	end

	local var_11_5 = arg_11_0.cellItem_[var_11_4]
	local var_11_6 = var_11_5:IsCanPass()
	local var_11_7 = var_11_5:GetType()

	if var_11_6 then
		var_11_1:ActionPass()

		if var_11_7 == PushBoxConst.CELL_TYPE.UP_SLIDER then
			return arg_11_0:CalMove(var_11_2, var_11_3, 0, -1)
		elseif var_11_7 == PushBoxConst.CELL_TYPE.DOWN_SLIDER then
			return arg_11_0:CalMove(var_11_2, var_11_3, 0, 1)
		elseif var_11_7 == PushBoxConst.CELL_TYPE.LEFT_SLIDER then
			return arg_11_0:CalMove(var_11_2, var_11_3, -1, 0)
		elseif var_11_7 == PushBoxConst.CELL_TYPE.RIGHT_SLIDER then
			return arg_11_0:CalMove(var_11_2, var_11_3, 1, 0)
		else
			return arg_11_0:CalMove(var_11_2, var_11_3, arg_11_3, arg_11_4)
		end
	else
		return true
	end
end

function var_0_0.AniMove(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:RemoveTween()
	arg_12_0.boxItem_[arg_12_2]:PlayDirct(arg_12_0.dirMap_[arg_12_1 - 1])

	local var_12_0 = arg_12_0:GetCellIndex(arg_12_0.routhMap_[arg_12_1][1], arg_12_0.routhMap_[arg_12_1][2])

	arg_12_0.cellItem_[var_12_0]:OnReadyEnter()

	local var_12_1, var_12_2 = arg_12_0.cellItem_[var_12_0]:GetLoaclPosition()

	arg_12_0.tween_ = LeanTween.moveLocal(arg_12_0.boxItem_[arg_12_2].gameObject_, Vector3.New(var_12_1, var_12_2, 0), var_0_3):setEase(LeanTweenType.linear):setOnComplete(LuaHelper.VoidAction(function()
		local var_13_0 = arg_12_0:GetCellIndex(arg_12_0.routhMap_[arg_12_1 - 1][1], arg_12_0.routhMap_[arg_12_1 - 1][2])

		arg_12_0.cellItem_[var_13_0]:OnPass()

		if arg_12_1 == #arg_12_0.routhMap_ then
			arg_12_0:RemoveTween()
			arg_12_0.boxItem_[arg_12_2]:StopAni()

			local var_13_1, var_13_2 = arg_12_0.cellItem_[var_12_0]:GetPos()

			arg_12_0.boxItem_[arg_12_2]:SetPos(var_13_1, var_13_2, var_12_1, var_12_2)

			if arg_12_0.cellItem_[var_12_0]:GetType() == PushBoxConst.CELL_TYPE.GOAL then
				manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_success")
			end

			manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_carstop")
			manager.notify:Invoke(PUSH_BOX_STOP)

			return
		end

		arg_12_0:AniMove(arg_12_1 + 1, arg_12_2)
	end))
end

function var_0_0.GetCanPassDir(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = arg_14_0.boxItem_[arg_14_1]:GetCoordinate()
	local var_14_2 = arg_14_0:CheckCanPass(var_14_0, var_14_1, 0, -1)
	local var_14_3 = arg_14_0:CheckCanPass(var_14_0, var_14_1, 0, 1)
	local var_14_4 = arg_14_0:CheckCanPass(var_14_0, var_14_1, -1, 0)
	local var_14_5 = arg_14_0:CheckCanPass(var_14_0, var_14_1, 1, 0)

	return var_14_2, var_14_3, var_14_4, var_14_5
end

function var_0_0.CheckCanPass(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = arg_15_0:GetCellIndex(arg_15_1, arg_15_2)
	local var_15_1 = arg_15_0.cellItem_[var_15_0]
	local var_15_2 = arg_15_1 + arg_15_3
	local var_15_3 = arg_15_2 + arg_15_4
	local var_15_4 = arg_15_0:GetCellIndex(var_15_2, var_15_3)

	if var_15_2 < 1 or var_15_3 < 1 or var_15_2 > arg_15_0.mapWidth_ or var_15_3 > arg_15_0.mapHeight_ then
		return false
	end

	return (arg_15_0.cellItem_[var_15_4]:IsCanPass())
end

function var_0_0.RemoveTween(arg_16_0)
	if arg_16_0.tween_ then
		arg_16_0.tween_:setOnComplete(nil)
		LeanTween.cancel(arg_16_0.tween_.id)

		arg_16_0.tween_ = nil
	end
end

function var_0_0.OnExit(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.cellItem_ = {}
	arg_18_0.boxItem_ = {}
	arg_18_0.isInit_ = false
end

return var_0_0
