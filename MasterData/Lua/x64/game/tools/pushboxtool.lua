local var_0_0 = {}
local var_0_1 = 99
local var_0_2 = GameDisplayCfg.activity_celebration_grid_max_length.value[1]

if GameDisplayCfg.activity_celebration_box_speed then
	local var_0_3 = GameDisplayCfg.activity_celebration_box_speed.value[1] or 0.5
end

local var_0_4 = 0
local var_0_5 = 0

function var_0_0.GetFatigueID(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(GameSetting.activity_fatigue_info.value) do
		if iter_1_1[1] == arg_1_1 then
			return iter_1_1[2]
		end
	end
end

function var_0_0.GetFatigueMax(arg_2_0, arg_2_1)
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in ipairs(GameSetting.activity_celebration_cake_fatigue_default.value) do
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

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = arg_4_1,
		stage_id = arg_4_2,
		result = arg_4_3,
		use_seconds = var_0_5 - var_0_4
	})
end

function var_0_0:Init()
	if self.isInit_ then
		return
	end

	self.isInit_ = true
	self.boxItem_ = {}
	self.cellItem_ = {}
	self.mapSize_ = 1
	self.mapWidth_ = 1
	self.mapHeight_ = 1
	self.cellWidth_ = 1
	self.actionCnt_ = 0
	self.routhMap_ = {}
	self.dirMap_ = {}
	self.tween_ = nil
	self.goalTbl_ = {}
end

function var_0_0:InitMap(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	self:Init()

	local var_6_0 = ActivityCelebrationGameCfg[arg_6_1]

	self.mapWidth_ = ActivityCelebrationGameCfg[arg_6_1].width
	self.mapHeight_ = var_6_0.height
	self.mapSize_ = self.mapWidth_ * self.mapHeight_
	self.cellWidth_ = arg_6_4.rect.width / self.mapWidth_ < arg_6_4.rect.height / self.mapHeight_ and arg_6_4.rect.width / self.mapWidth_ or arg_6_4.rect.height / self.mapHeight_

	if self.cellWidth_ > var_0_2 then
		self.cellWidth_ = var_0_2 or self.cellWidth_
	end

	arg_6_2:GetComponent("GridLayoutGroup").cellSize = Vector2.New(self.cellWidth_, self.cellWidth_)
	arg_6_2.sizeDelta = Vector2.New(self.mapWidth_ * self.cellWidth_, self.mapHeight_ * self.cellWidth_)
	arg_6_3.sizeDelta = Vector2.New(self.mapWidth_ * self.cellWidth_, self.mapHeight_ * self.cellWidth_)

	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(ActivityCelebrationBoxCfg.get_id_list_by_mapId[var_6_0.mapId]) do
		table.insert(var_6_1, {
			ActivityCelebrationBoxCfg[iter_6_1].x + (ActivityCelebrationBoxCfg[iter_6_1].y - 1) * self.mapWidth_,
			ActivityCelebrationBoxCfg[iter_6_1].type
		})
	end

	table.sort(var_6_1, function(arg_7_0, arg_7_1)
		return arg_7_0[1] < arg_7_1[1]
	end)

	self.goalTbl_ = {}

	local var_6_2 = 1

	for iter_6_2 = 1, self.mapWidth_ * self.mapHeight_ do
		self.cellItem_[iter_6_2] = self.cellItem_[iter_6_2] or PushBoxCellItem.New((Object.Instantiate(arg_6_5, arg_6_2)))

		local var_6_3

		if iter_6_2 % self.mapWidth_ == 0 then
			var_6_3 = self.mapWidth_ or iter_6_2 % self.mapWidth_

			local var_6_4

			if iter_6_2 % self.mapWidth_ == 0 then
				var_6_4 = iter_6_2 / self.mapWidth_ or math.floor(iter_6_2 / self.mapWidth_) + 1
			end
		end

		local var_6_5 = PushBoxConst.CELL_TYPE.NORMAL

		if var_6_1[var_6_2] and var_6_1[var_6_2][1] == iter_6_2 then
			var_6_5 = var_6_1[var_6_2][2]
			var_6_2 = var_6_2 + 1
		end

		if var_6_5 == PushBoxConst.CELL_TYPE.GOAL then
			table.insert(self.goalTbl_, iter_6_2)
		end

		self.cellItem_[iter_6_2]:SetData(var_6_3, var_6_4, var_6_5)
		SetActive(self.cellItem_[iter_6_2].gameObject_, true)
	end

	for iter_6_3 = self.mapWidth_ * self.mapHeight_ + 1, #self.cellItem_ do
		SetActive(self.cellItem_[iter_6_3].gameObject_, false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_2)

	for iter_6_4, iter_6_5 in ipairs(var_6_0.box_list) do
		self.boxItem_[iter_6_4] = self.boxItem_[iter_6_4] or PushBoxItem.New((Object.Instantiate(arg_6_6, arg_6_3)))

		self.boxItem_[iter_6_4]:SetSize(self.cellWidth_)
		self:SyncBoxPosition(iter_6_4, iter_6_5[1], iter_6_5[2])
		self.boxItem_[iter_6_4]:SetData(iter_6_4)
		SetActive(self.boxItem_[iter_6_4].gameObject_, true)
	end

	for iter_6_6 = #var_6_0.box_list + 1, #self.boxItem_ do
		SetActive(self.boxItem_[iter_6_6].gameObject_, false)
	end

	return self.boxItem_, self.cellItem_, self.goalTbl_
end

function var_0_0:GetCellIndex(arg_8_1, arg_8_2)
	return self.mapWidth_ * (arg_8_2 - 1) + arg_8_1
end

function var_0_0:SyncBoxPosition(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0, var_9_1 = self.cellItem_[self:GetCellIndex(arg_9_2, arg_9_3)]:GetLoaclPosition()

	self.boxItem_[arg_9_1]:SetPos(arg_9_2, arg_9_3, var_9_0, var_9_1)
end

function var_0_0:OperateMove(arg_10_1, arg_10_2, arg_10_3)
	self.actionCnt_ = 0
	self.routhMap_ = {}
	self.dirMap_ = {}

	local var_10_0, var_10_1 = self.boxItem_[arg_10_3]:GetCoordinate()

	if self:CalMove(var_10_0, var_10_1, arg_10_1, arg_10_2) then
		if #self.routhMap_ <= 1 then
			manager.notify:Invoke(PUSH_BOX_STOP)

			return
		end

		manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_carmove")
		self:AniMove(2, arg_10_3)
	end
end

function var_0_0:CalMove(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self.actionCnt_ = self.actionCnt_ + 1

	table.insert(self.routhMap_, {
		arg_11_1,
		arg_11_2
	})
	table.insert(self.dirMap_, {
		arg_11_3,
		arg_11_4
	})

	local var_11_0 = self.cellItem_[self:GetCellIndex(arg_11_1, arg_11_2)]

	if var_11_0:GetType() == PushBoxConst.CELL_TYPE.GOAL and self.actionCnt_ > 1 then
		return true
	end

	if self.actionCnt_ >= var_0_1 then
		error("路径过长")

		return false
	end

	local var_11_1 = arg_11_1 + arg_11_3
	local var_11_2 = self:GetCellIndex(arg_11_1 + arg_11_3, arg_11_2 + arg_11_4)

	if arg_11_1 + arg_11_3 < 1 or arg_11_2 + arg_11_4 < 1 or var_11_1 > self.mapWidth_ or arg_11_2 + arg_11_4 > self.mapHeight_ then
		return true
	end

	local var_11_3 = self.cellItem_[var_11_2]:GetType()

	if self.cellItem_[var_11_2]:IsCanPass() then
		var_11_0:ActionPass()

		if var_11_3 == PushBoxConst.CELL_TYPE.UP_SLIDER then
			return self:CalMove(var_11_1, arg_11_2 + arg_11_4, 0, -1)
		elseif var_11_3 == PushBoxConst.CELL_TYPE.DOWN_SLIDER then
			return self:CalMove(var_11_1, arg_11_2 + arg_11_4, 0, 1)
		elseif var_11_3 == PushBoxConst.CELL_TYPE.LEFT_SLIDER then
			return self:CalMove(var_11_1, arg_11_2 + arg_11_4, -1, 0)
		elseif var_11_3 == PushBoxConst.CELL_TYPE.RIGHT_SLIDER then
			return self:CalMove(var_11_1, arg_11_2 + arg_11_4, 1, 0)
		else
			return self:CalMove(var_11_1, arg_11_2 + arg_11_4, arg_11_3, arg_11_4)
		end
	else
		return true
	end
end

function var_0_0:AniMove(arg_12_1, arg_12_2)
	self:RemoveTween()
	self.boxItem_[arg_12_2]:PlayDirct(self.dirMap_[arg_12_1 - 1])

	local var_12_0 = self:GetCellIndex(self.routhMap_[arg_12_1][1], self.routhMap_[arg_12_1][2])

	self.cellItem_[var_12_0]:OnReadyEnter()

	local var_12_1, var_12_2 = self.cellItem_[var_12_0]:GetLoaclPosition()

	self.tween_ = LeanTween.moveLocal(self.boxItem_[arg_12_2].gameObject_, Vector3.New(var_12_1, var_12_2, 0), var_0_3):setEase(LeanTweenType.linear):setOnComplete(LuaHelper.VoidAction(function()
		self.cellItem_[self:GetCellIndex(self.routhMap_[arg_12_1 - 1][1], self.routhMap_[arg_12_1 - 1][2])]:OnPass()

		if arg_12_1 == #self.routhMap_ then
			self:RemoveTween()
			self.boxItem_[arg_12_2]:StopAni()

			local var_13_0, var_13_1 = self.cellItem_[var_12_0]:GetPos()

			self.boxItem_[arg_12_2]:SetPos(var_13_0, var_13_1, var_12_1, var_12_2)

			if self.cellItem_[var_12_0]:GetType() == PushBoxConst.CELL_TYPE.GOAL then
				manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_success")
			end

			manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_carstop")
			manager.notify:Invoke(PUSH_BOX_STOP)

			return
		end

		self:AniMove(arg_12_1 + 1, arg_12_2)
	end))
end

function var_0_0:GetCanPassDir(arg_14_1)
	local var_14_0, var_14_1 = self.boxItem_[arg_14_1]:GetCoordinate()

	return self:CheckCanPass(var_14_0, var_14_1, 0, -1), self:CheckCanPass(var_14_0, var_14_1, 0, 1), self:CheckCanPass(var_14_0, var_14_1, -1, 0), (self:CheckCanPass(var_14_0, var_14_1, 1, 0))
end

function var_0_0:CheckCanPass(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = self.cellItem_[self:GetCellIndex(arg_15_1, arg_15_2)]

	if arg_15_1 + arg_15_3 < 1 or arg_15_2 + arg_15_4 < 1 or arg_15_1 + arg_15_3 > self.mapWidth_ or arg_15_2 + arg_15_4 > self.mapHeight_ then
		return false
	end

	return (self.cellItem_[self:GetCellIndex(arg_15_1 + arg_15_3, arg_15_2 + arg_15_4)]:IsCanPass())
end

function var_0_0:RemoveTween()
	if self.tween_ then
		self.tween_:setOnComplete(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
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
