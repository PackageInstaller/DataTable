local SortGameGridController = class("SortGameGridController")
local var_0_1 = 3
local var_0_2 = 4
local var_0_3 = 3
local var_0_4 = Vector2(0, -25)

function SortGameGridController:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._runtimeData = arg_1_3
	self._gridTpl = findTF(self._tf, "grids/grid_tpl")

	setActive(self._gridTpl, false)

	self._dragGridTF = findTF(self._tf, "drag_grid")

	setActive(self._dragGridTF, false)

	self._contentAniamtor = self._tf:GetComponent(typeof(Animator))
	self._contentDftEvent = self._tf:GetComponent(typeof(DftAniEvent))

	self._contentDftEvent:SetEndEvent(function()
		self:ResetGrid()

		return
	end)

	self._grids = {}

	for iter_1_0 = 1, var_0_1 * var_0_2 do
		local var_1_1 = findTF(self._tf, "grids/grid_" .. iter_1_0)

		setParent(var_1_1, self._gridTpl.parent)
		setActive(var_1_1, true)

		local var_1_2 = SortGameGrid.New(var_1_1, self._event, iter_1_0)

		self._grids[iter_1_0] = var_1_2

		self._grids[iter_1_0]:SetRemoveEventCallback(function(arg_3_0, arg_3_1)
			self:removeItemIds(arg_3_1)
			self:checkGameOver()

			return
		end)
		self._grids[iter_1_0]:SetMoveBottomCallback(function(arg_4_0)
			self:checkGridInput(self._grids[arg_4_0])

			return
		end)
		self._grids[iter_1_0]:SetScoreCallback(function(arg_5_0, arg_5_1)
			self._comboIndex = self._comboIndex and self._comboIndex + 1 or 0
			self._comboTime = SortGameConst.combo_time
			self._waitTime = 0

			self._event:emit(SimpleMGEvent.ADD_SCORE, {
				num = self:GetScore(arg_5_1),
				combo = self._comboIndex,
				position = self._grids[arg_5_0]:GetPosition()
			})

			if self._wantedItem and self._wantedItem == arg_5_1 then
				self._wantedItem = nil
				self._wantedStepTime = nil

				self._event:emit(SortGameView.WANTED_ITEM_REFRESH, {})
				self._event:emit(SortGameView.PLAYER_SPEAK, self._runtimeData:GetSpeakData(SortGameConst.sort_conifg_type_chat, (self._runtimeData:GetPlayerName(self._runtimeData:GetPlayerIdByItem(arg_5_1)))))
			end

			if table.contains(SortGameConst.combo_speak_num, self._comboIndex) then
				self._event:emit(SortGameView.PLAYER_SPEAK, self._runtimeData:GetSpeakData(SortGameConst.sort_conifg_type_combo))
			end

			return
		end)
		var_1_2:AddItemEventCallback(function(arg_6_0, arg_6_1, arg_6_2)
			self:onGridDrag(arg_6_0, arg_6_1, arg_6_2)

			return
		end, function(arg_7_0, arg_7_1, arg_7_2)
			self:onGridDragEnd(arg_7_0, arg_7_1, arg_7_2)

			return
		end, function(arg_8_0, arg_8_1, arg_8_2)
			self:onGridEnter(arg_8_0, arg_8_1, arg_8_2)

			return
		end, function(arg_9_0, arg_9_1, arg_9_2)
			self:onGridExit(arg_9_0, arg_9_1, arg_9_2)

			return
		end)
	end

	self._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))

	return
end

function SortGameGridController:checkGameOver()
	if #self._itemIds == 0 and #self._itemIdsPool == 0 then
		self._event:emit(SortGameView.GAME_OVER_TIME)
	end

	return
end

function SortGameGridController:removeItemIds(arg_11_1)
	for iter_11_0 = 1, #self._itemIds do
		if self._itemIds[iter_11_0] == arg_11_1 then
			print("item_id = " .. arg_11_1 .. " 被消除了")
			table.remove(self._itemIds, iter_11_0)

			return
		end
	end

	warning("没有在格子中找到这个id = " .. arg_11_1)

	return
end

function SortGameGridController:onGridDrag(arg_12_1, arg_12_2, arg_12_3)
	if self._dragGridIndex ~= nil and self._dragGridIndex ~= arg_12_1 then
		return
	end

	local var_12_0 = self._grids[arg_12_1]

	if not self._grids[arg_12_1] then
		return
	end

	if not self._dragGridIndex then
		self._startDragPos = arg_12_3.position
		self._dragGridStartPos = self._tf:InverseTransformPoint(self._uiCamera:ScreenToWorldPoint(self._startDragPos))

		setActive(self._dragGridTF, true)

		self._dragGridIndex = arg_12_1
		self._dragGridItemIndex = arg_12_2

		local var_12_1 = var_12_0:GetItemBottomId(arg_12_2)

		var_12_0:SetItemAlpha(arg_12_2, true)

		if var_12_1 and var_12_1 > 0 then
			GetSpriteFromAtlasAsync(SortGameConst.ui_atlas, "item_" .. var_12_1, function(arg_13_0)
				setImageSprite(self._dragGridTF, arg_13_0, true)

				return
			end)
		end

		self._dragScreenRate = self:GetScreentScaleRate()
	end

	self._dragGridTF.anchoredPosition = Vector2(self._dragGridStartPos.x + (var_0_4.x + (arg_12_3.position.x - self._startDragPos.x)) * self._dragScreenRate.x, self._dragGridStartPos.y + (var_0_4.y + (arg_12_3.position.y - self._startDragPos.y)) * self._dragScreenRate.y)

	return
end

function SortGameGridController:Start()
	return
end

function SortGameGridController:onGridDragEnd(arg_15_1, arg_15_2, arg_15_3)
	if not self._dragGridIndex then
		return
	end

	setActive(self._dragGridTF, false)

	local var_15_0 = false

	if self._dragGridIndex and self._enterGridIndex then
		if self._dragGridIndex == self._enterGridIndex and self._dragGridItemIndex ~= self._enterGridItemIndex then
			var_15_0 = true
		elseif self._dragGridIndex ~= self._enterGridIndex then
			var_15_0 = true
		end
	end

	self._grids[arg_15_1]:SetItemAlpha(arg_15_2, false)

	if var_15_0 then
		self._grids[self._dragGridIndex]:InSertItem(self._dragGridItemIndex, (self._grids[self._enterGridIndex]:GetItemBottomId(self._enterGridItemIndex)))
		self._grids[self._enterGridIndex]:InSertItem(self._enterGridItemIndex, (self._grids[self._dragGridIndex]:GetItemBottomId(self._dragGridItemIndex)))
		self._grids[self._dragGridIndex]:CheckMoveBottom()
		self._grids[self._enterGridIndex]:CheckMoveBottom()
	end

	if self._enterGridIndex and self._grids[self._enterGridIndex] then
		self._grids[self._enterGridIndex]:SetItemSelect(self._enterGridItemIndex, false)
	end

	if self._dragGridIndex and self._grids[self._dragGridIndex] and self._grids[self._dragGridIndex]:GetType() == SortGameConst.grid_type_out and self._grids[self._dragGridIndex]:GetInputEmptyLayer() == 1 then
		self._grids[self._dragGridIndex]:SetItemLock(2, true)
	end

	self._dragGridIndex = nil
	self._enterGridIndex = nil
	self._dragGridItemIndex = nil
	self._enterGridItemIndex = nil

	return
end

function SortGameGridController:onGridEnter(arg_16_1, arg_16_2, arg_16_3)
	if not self._dragGridIndex then
		return
	end

	if self._dragGridIndex == arg_16_1 and self._dragGridItemIndex == arg_16_2 then
		return
	end

	if self._enterGridIndex and self._grids[self._enterGridIndex] then
		self._grids[self._enterGridIndex]:SetItemSelect(self._enterGridItemIndex, false)
	end

	self._enterGridIndex = arg_16_1
	self._enterGridItemIndex = arg_16_2

	if arg_16_1 and self._grids[arg_16_1] then
		self._grids[self._enterGridIndex]:SetItemSelect(arg_16_2, true)
	end

	return
end

function SortGameGridController:onGridExit(arg_17_1, arg_17_2, arg_17_3)
	if not self._dragGridIndex then
		return
	end

	if not self._enterGridIndex then
		return
	end

	if self._enterGridIndex == arg_17_1 and self._enterGridItemIndex == arg_17_2 then
		if self._enterGridIndex and self._grids[self._enterGridIndex] then
			self._grids[self._enterGridIndex]:SetItemSelect(self._enterGridItemIndex, false)
		end

		self._enterGridIndex = nil
		self._enterGridItemIndex = nil
	end

	return
end

function SortGameGridController:checkGridInput(arg_18_1)
	if arg_18_1:GetInputLayerCount() < self._itemLayerMax and arg_18_1:GetInputEmptyLayer() <= SortGameConst.grid_max_layer then
		self:InPutGrid(arg_18_1, true)

		self._checkLockTime = 0

		return true
	end

	return false
end

function SortGameGridController:GetItemIdList(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = {}
	local var_19_1 = Clone(arg_19_1)

	for iter_19_0 = 1, arg_19_2 do
		for iter_19_1 = 1, var_0_3 * arg_19_3 do
			table.insert(var_19_0, var_19_1[1])
		end
	end

	return var_19_0
end

function SortGameGridController:ShuffleList(arg_20_1, arg_20_2)
	randomRange = arg_20_2 and math.min(arg_20_2, #arg_20_1) or #arg_20_1

	for iter_20_0 = randomRange, 2, -1 do
		local var_20_0 = math.random(1, iter_20_0)

		arg_20_1[iter_20_0], arg_20_1[var_20_0] = arg_20_1[var_20_0], arg_20_1[iter_20_0]
	end

	return
end

function SortGameGridController:InPutGrid(arg_21_1, arg_21_2)
	local var_21_0 = 0

	if arg_21_1:GetType() > 0 then
		local var_21_1 = {}
		local var_21_2 = self:GetGridIdMap(arg_21_1, self._normalItemWeight)

		for iter_21_0 = 1, #var_21_2 do
			if var_21_2[iter_21_0] ~= 0 and #self._itemIdsPool > 0 then
				local var_21_4

				if iter_21_0 == 3 and var_21_1[1] == var_21_1[2] and var_21_1[1] ~= 0 then
					print("当前第三个格子需要优先匹配前两个格子的id，id = " .. var_21_1[1])

					var_21_4 = var_21_1[1]
					var_21_0 = var_21_0 + 1
				end

				table.insert(var_21_1, (self:GetIdFromPool((arg_21_2 or nil) and self:GetIdsDic(self._itemIds), var_21_4)))
			else
				table.insert(var_21_1, 0)
			end
		end

		print("插入id列表 = " .. table.concat(var_21_1, ","))
		arg_21_1:InputIds(var_21_1)
	end

	return var_21_0
end

function SortGameGridController:GetIdFromPool(arg_22_1, arg_22_2)
	if self._itemIdsPool and #self._itemIdsPool > 0 then
		if arg_22_1 then
			if self:GetPassItemCount(arg_22_1) <= SortGameConst.pass_limit_num then
				local var_22_0

				for iter_22_0, iter_22_1 in pairs(arg_22_1) do
					if 0 < iter_22_1 and self:checkIdExist(self._itemIdsPool, iter_22_0) and iter_22_0 ~= arg_22_2 then
						var_22_0 = iter_22_0
					end
				end

				if var_22_0 then
					for iter_22_2 = 1, #self._itemIdsPool do
						if self._itemIdsPool[iter_22_2] == var_22_0 then
							table.insert(self._itemIds, (table.remove(self._itemIdsPool, iter_22_2)))

							arg_22_1[var_22_0] = arg_22_1[var_22_0] + 1

							print("匹配成功，匹配id = " .. var_22_0)

							return var_22_0
						end
					end
				end
			else
				print("本次从池子中取不到元素， 长度 = " .. #self._itemIdsPool)
			end
		end

		local var_22_2 = table.remove(self._itemIdsPool, 1)

		table.insert(self._itemIds, var_22_2)

		return var_22_2
	end

	warning("id池已经没有id了")

	return 0
end

function SortGameGridController:checkIdExist(arg_23_1, arg_23_2)
	return table.contains(arg_23_1, arg_23_2)
end

function SortGameGridController:GetScreentScaleRate()
	local var_24_0 = tf(GameObject.Find("UICamera/Canvas"))

	return Vector2(var_24_0.sizeDelta.x / UnityEngine.Screen.width, var_24_0.sizeDelta.y / UnityEngine.Screen.height)
end

function SortGameGridController:GetGridIdMap(arg_25_1, arg_25_2)
	local var_25_0 = {
		0,
		0,
		0
	}
	local var_25_1 = arg_25_1:GetType()

	if var_25_1 == SortGameConst.grid_type_empty then
		var_25_0 = {
			0,
			0,
			0
		}
	elseif var_25_1 == SortGameConst.grid_type_normal then
		local var_25_2 = math.random()
		local var_25_3 = 1

		for iter_25_0 = 1, #arg_25_2 do
			if iter_25_0 == 1 then
				if var_25_2 <= arg_25_2[iter_25_0] then
					var_25_3 = iter_25_0
				end
			elseif var_25_2 > arg_25_2[iter_25_0 - 1] and var_25_2 <= arg_25_2[iter_25_0] then
				var_25_3 = iter_25_0

				break
			end
		end

		var_25_0 = var_25_3 == 1 and {
			1,
			0,
			0
		} or var_25_3 == 2 and {
			1,
			1,
			0
		} or {
			1,
			1,
			1
		}

		self:shuffleArray(var_25_0)
	elseif var_25_1 == SortGameConst.grid_type_two then
		var_25_0 = {
			1,
			1,
			0
		}

		self:shuffleArray(var_25_0)
	elseif var_25_1 == SortGameConst.grid_type_out then
		var_25_0 = {
			0,
			1,
			0
		}
	end

	return var_25_0
end

function SortGameGridController:shuffleArray(arg_26_1)
	for iter_26_0 = #arg_26_1, 2, -1 do
		local var_26_0 = math.random(1, iter_26_0)

		arg_26_1[iter_26_0], arg_26_1[var_26_0] = arg_26_1[var_26_0], arg_26_1[iter_26_0]
	end

	return
end

function SortGameGridController:CalculateWeight(arg_27_1)
	local var_27_0 = {}
	local var_27_1 = 0

	for iter_27_0 = 1, #arg_27_1 do
		var_27_1 = var_27_1 + arg_27_1[iter_27_0]
	end

	local var_27_2 = 0

	for iter_27_1 = 1, #arg_27_1 do
		var_27_2 = var_27_2 + arg_27_1[iter_27_1]

		table.insert(var_27_0, var_27_2 / var_27_1)
	end

	return var_27_0
end

function SortGameGridController:GetScore(arg_28_1)
	local var_28_0

	if self._wantedItem and arg_28_1 == self._wantedItem then
		var_28_0 = SortGameConst.wanted_score_num or SortGameConst.score_num

		if not self._comboIndex or self._comboIndex == 0 then
			do return var_28_0 end

			goto label_28_0
		end
	end

	for iter_28_0 = 1, #SortGameConst.combo_rate do
		if self._comboIndex >= SortGameConst.combo_rate[iter_28_0].range[1] and self._comboIndex <= SortGameConst.combo_rate[iter_28_0].range[2] then
			return math.floor(var_28_0 * SortGameConst.combo_rate[iter_28_0].rate)
		end
	end

	do return var_28_0 end

	::label_28_0::

	return
end

function SortGameGridController:Prepare()
	self._dragGridIndex = nil
	self._enterGridIndex = nil
	self._dragGridItemIndex = nil
	self._enterGridItemIndex = nil
	self._waitTime = 0
	self._comboIndex = 0
	self._comboTime = nil

	local var_29_0 = self._runtimeData:GetPlayers()
	local var_29_1 = self._runtimeData:GetChapterConfig("player_own_item_count") or 1

	self._normalItemWeight = self:CalculateWeight((self._runtimeData:GetChapterConfig("grid_weight")))

	local var_29_2 = self:GetItemIdList(self._runtimeData:GetComonItems(), self._runtimeData:GetChapterConfig("item_count"), (self._runtimeData:GetChapterConfig("item_rate")))
	local var_29_3 = {}

	for iter_29_0 = 1, #var_29_0 do
		local var_29_4 = self._runtimeData:GetPlayerItems(var_29_0[iter_29_0])

		for iter_29_1 = 1, #var_29_4 do
			table.insert(var_29_3, var_29_4[iter_29_1])
		end
	end

	local var_29_5 = self:GetItemIdList(var_29_3, var_29_1, 1)

	self._itemIdsPool = {}

	for iter_29_2 = 1, #var_29_2 do
		table.insert(self._itemIdsPool, var_29_2[iter_29_2])
	end

	for iter_29_3 = 1, #var_29_5 do
		table.insert(self._itemIdsPool, var_29_5[iter_29_3])
	end

	self._itemIds = {}

	local var_29_6 = {}

	for iter_29_4 = 1, SortGameConst.init_pass_num do
		local var_29_7 = self._itemIdsPool[math.random(1, #self._itemIdsPool)]
		local var_29_8 = 0

		for iter_29_5 = #self._itemIdsPool, 1, -1 do
			if self._itemIdsPool[iter_29_5] == var_29_7 then
				table.insert(var_29_6, table.remove(self._itemIdsPool, iter_29_5))

				var_29_8 = var_29_8 + 1

				if var_29_8 == 3 then
					break
				end
			end
		end
	end

	self:ShuffleList(self._itemIdsPool)

	if #var_29_6 > 0 then
		for iter_29_6 = 1, #var_29_6 do
			table.insert(self._itemIdsPool, 1, var_29_6[iter_29_6])
		end
	end

	self:ShuffleList(self._itemIdsPool, 18)

	self._activeGridCount = 0
	self._boundsData = self._runtimeData:GetBoundConfig()
	self._offsetData = self._runtimeData:GetOffsetConfig()
	self._itemLayerMax = self._runtimeData:GetChapterConfig("item_layer_max")

	for iter_29_7 = 1, #self._boundsData do
		local var_29_11 = self._boundsData[iter_29_7]

		for iter_29_8 = 1, #self._boundsData[iter_29_7] do
			if var_29_11[iter_29_8] > 0 then
				self._activeGridCount = self._activeGridCount + 1 or self._activeGridCount
			end

			self._grids[(iter_29_7 - 1) * var_0_2 + iter_29_8]:SetType(var_29_11[iter_29_8])
		end
	end

	for iter_29_9 = 1, #self._offsetData do
		if self._grids[iter_29_9] then
			self._grids[iter_29_9]:SetOffset(self._offsetData[iter_29_9])
		end
	end

	for iter_29_10 = 1, SortGameConst.grid_max_layer do
		for iter_29_11 = 1, #self._grids do
			self:InPutGrid(self._grids[iter_29_11], false)
		end
	end

	self._wantedStepTime = nil
	self._wantedItem = nil
	self._wantedRefreshTime = nil
	self._checkLockTime = 0

	return
end

function SortGameGridController:Step(arg_30_1, arg_30_2)
	self._gameTime = arg_30_2

	if self._comboTime and self._comboTime >= 0 then
		self._comboTime = self._comboTime - arg_30_1

		if self._comboTime <= 0 then
			self._comboIndex = nil
			self._comboTime = nil
		end
	end

	self._waitTime = self._waitTime + arg_30_1

	if self._waitTime >= SortGameConst.wait_speak_time then
		self._waitTime = 0

		self._event:emit(SortGameView.PLAYER_SPEAK, self._runtimeData:GetSpeakData(SortGameConst.sort_conifg_type_wait))
	end

	if not self._wantedStepTime then
		self._wantedRefreshTime = self._wantedRefreshTime or SortGameConst.wanted_refresh_time

		if self._wantedRefreshTime >= 0 then
			self._wantedRefreshTime = self._wantedRefreshTime - arg_30_1

			if self._wantedRefreshTime <= 0 then
				if math.random() < SortGameConst.wanted_rate then
					self._wantedItem = self._runtimeData:GetRandomWantedItem(self:GetAllBottomIds())

					if self._wantedItem then
						self._event:emit(SortGameView.WANTED_ITEM_REFRESH, {
							item_id = self._wantedItem,
							player_prefab = SortGameConst.player_data[self._runtimeData:GetPlayerIdByItem(self._wantedItem)].prefab
						})

						self._wantedStepTime = SortGameConst.wanted_step_time
					end
				end

				self._wantedRefreshTime = nil
			end
		end
	elseif self._wantedStepTime >= 0 then
		self._wantedStepTime = self._wantedStepTime - arg_30_1

		if self._wantedStepTime <= 0 then
			self._wantedItem = nil
			self._wantedStepTime = nil

			self._event:emit(SortGameView.WANTED_ITEM_REFRESH, {})
		end
	end

	if self._wantedItem then
		if self._wantedStepIndexCheck == nil then
			self._wantedStepIndexCheck = 30
		end

		self._wantedStepIndexCheck = self._wantedStepIndexCheck - 1

		if self._wantedStepIndexCheck <= 0 then
			self._wantedStepIndexCheck = nil

			if not self:checkIdExist(self:GetAllBottomIds(), self._wantedItem) then
				self._wantedStepTime = 0
			end
		end
	end

	self._checkLockTime = self._checkLockTime + arg_30_1

	if self._checkLockTime >= 1.3 then
		local var_30_0 = 0

		for iter_30_0 = 1, #self._grids do
			var_30_0 = var_30_0 + self._grids[iter_30_0]:GetInputEmptyCount()
		end

		local var_30_1 = self:GetPassItemCount((self:GetIdsDic(self:GetAllBottomIds())))

		if var_30_0 == 0 or var_30_0 == 1 and var_30_1 == 0 or var_30_0 == 2 and var_30_1 == 0 then
			self._contentAniamtor:SetTrigger("reset")
		end

		self._checkLockTime = 0
	end

	return
end

function SortGameGridController:ResetGrid()
	self._dragGridIndex = nil
	self._enterGridIndex = nil
	self._dragGridItemIndex = nil
	self._enterGridItemIndex = nil

	setActive(self._dragGridTF, false)

	for iter_31_0 = 1, #self._grids do
		self._grids[iter_31_0]:ClearItems()
	end

	for iter_31_1 = #self._itemIds, 1, -1 do
		table.insert(self._itemIdsPool, self._itemIds[iter_31_1])
	end

	self:shuffleArray(self._itemIdsPool)

	self._itemIds = {}

	for iter_31_2 = 1, #self._grids do
		for iter_31_3 = 1, SortGameConst.grid_max_layer do
			self:checkGridInput(self._grids[iter_31_2])
		end

		self._grids[iter_31_2]:SetShowAniamtion()
	end

	self._wantedItem = nil
	self._wantedStepTime = nil

	self._event:emit(SortGameView.WANTED_ITEM_REFRESH, {})

	return
end

function SortGameGridController:GetPassItemCount(arg_32_1)
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in pairs(arg_32_1) do
		if iter_32_1 >= 3 then
			var_32_0 = var_32_0 + 1
		end
	end

	return var_32_0
end

function SortGameGridController:GetAllBottomIds()
	local var_33_0 = {}

	for iter_33_0 = 1, #self._grids do
		for iter_33_1, iter_33_2 in ipairs((self._grids[iter_33_0]:GetBottomIds())) do
			if iter_33_2 and iter_33_2 > 0 then
				table.insert(var_33_0, iter_33_2)
			end
		end
	end

	return var_33_0
end

function SortGameGridController:GetIdsDic(arg_34_1)
	local var_34_0 = {}

	for iter_34_0 = 1, #arg_34_1 do
		if arg_34_1[iter_34_0] and arg_34_1[iter_34_0] > 0 then
			var_34_0[arg_34_1[iter_34_0]] = not var_34_0[arg_34_1[iter_34_0]] and 1 or var_34_0[arg_34_1[iter_34_0]] + 1
		end
	end

	return var_34_0
end

function SortGameGridController:Stop()
	for iter_35_0 = 1, #self._grids do
		self._grids[iter_35_0]:Stop()
	end

	return
end

function SortGameGridController:Resume()
	for iter_36_0 = 1, #self._grids do
		self._grids[iter_36_0]:Resume()
	end

	return
end

function SortGameGridController:Dispose()
	for iter_37_0 = 1, #self._grids do
		self._grids[iter_37_0]:Dispose()
	end

	return
end

function SortGameGridController:Clear()
	self._dragGridIndex = nil
	self._enterGridIndex = nil
	self._dragGridItemIndex = nil
	self._enterGridItemIndex = nil

	for iter_38_0 = 1, #self._grids do
		self._grids[iter_38_0]:Clear()
	end

	return
end

return SortGameGridController
