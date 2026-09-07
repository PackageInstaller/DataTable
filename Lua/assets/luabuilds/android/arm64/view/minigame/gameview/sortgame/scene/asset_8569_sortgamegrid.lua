local SortGameGrid = class("SortGameGrid")
local var_0_1 = 3

function SortGameGrid:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._ad = findTF(self._tf, "ad")
	self._gridEventTriggerList = {}
	self._index = arg_1_3
	self._itemsTF = {}
	self._itemsAnimator = {}
	self._itemsDftEvent = {}

	for iter_1_0 = 1, var_0_1 do
		local var_1_0 = iter_1_0
		local var_1_1 = findTF(self._tf, "ad/" .. iter_1_0)

		table.insert(self._itemsTF, var_1_1)
		table.insert(self._gridEventTriggerList, (GetOrAddComponent(findTF(var_1_1, "trigger"), typeof(EventTriggerListener))))
		table.insert(self._itemsAnimator, (GetOrAddComponent(var_1_1, typeof(Animator))))

		local var_1_2 = GetOrAddComponent(var_1_1, typeof(DftAniEvent))

		var_1_2:SetEndEvent(function()
			if self._removeDic and self._removeDic[var_1_0] then
				self._removeDic[var_1_0] = nil
				self._itemIdDic[var_1_0][1] = 0

				if not self:MoveItemToBottom() then
					self:UpdateItem(var_1_0)
				elseif self._moveBottomCallback then
					self._moveBottomCallback(self._index)
				end
			end

			return
		end)
		table.insert(self._itemsDftEvent, var_1_2)
		self:SetItemSelect(iter_1_0, false)
		self:SetItemLock(iter_1_0, false)
	end

	self._currentInputCount = 0
	self._left, self._middle, self._right = {}, {}, {}
	self._itemIdDic = {
		self._left,
		self._middle,
		self._right
	}

	for iter_1_1 = 1, SortGameConst.grid_max_layer do
		table.insert(self._left, 0)
		table.insert(self._middle, 0)
		table.insert(self._right, 0)
	end

	return
end

function SortGameGrid:SetRemoveEventCallback(arg_3_1)
	self._itemRemoveCallback = arg_3_1

	return
end

function SortGameGrid:SetMoveBottomCallback(arg_4_1)
	self._moveBottomCallback = arg_4_1

	return
end

function SortGameGrid:SetScoreCallback(arg_5_1)
	self._scoreCallback = arg_5_1

	return
end

function SortGameGrid:SetType(arg_6_1)
	self._gridType = arg_6_1

	self:UpdateUI()

	return
end

function SortGameGrid:GetType()
	return self._gridType
end

function SortGameGrid:GetInputLayerCount()
	return self._currentInputCount
end

function SortGameGrid:HasInputEmptyLayer()
	if self._gridType == SortGameConst.grid_type_empty then
		return false
	end

	return self:GetInputEmptyLayer() <= SortGameConst.grid_max_layer
end

function SortGameGrid:GetInputEmptyLayer()
	local var_10_0 = 1

	for iter_10_0 = 1, SortGameConst.grid_max_layer do
		local var_10_1 = false

		for iter_10_1 = 1, var_0_1 do
			if self._itemIdDic[iter_10_1][iter_10_0] ~= 0 then
				var_10_1 = true

				break
			end
		end

		if var_10_1 then
			var_10_0 = iter_10_0 + 1
		end
	end

	return var_10_0
end

function SortGameGrid:UpdateUI()
	if self._gridType == SortGameConst.grid_type_empty then
		self:SetVisible(false)
	else
		self:SetVisible(true)
	end

	for iter_11_0 = 1, var_0_1 do
		if self._gridType == SortGameConst.grid_type_out then
			self:SetItemLock(iter_11_0, iter_11_0 ~= 2)
		else
			self:SetItemLock(iter_11_0, false)
		end
	end

	return
end

function SortGameGrid:SetItemLock(arg_12_1, arg_12_2)
	setActive(findTF(self._itemsTF[arg_12_1], "lock"), arg_12_2)

	return
end

function SortGameGrid:PassItem()
	self._removeDic = {}

	for iter_13_0 = 1, #self._itemsAnimator do
		self._removeDic[iter_13_0] = true

		self._itemsAnimator[iter_13_0]:SetTrigger("pass")
	end

	if self._scoreCallback then
		self._scoreCallback(self._index, self._itemIdDic[1][1])
	end

	return
end

function SortGameGrid:GetPosition()
	return self._tf.position
end

function SortGameGrid:SetVisible(arg_15_1)
	setActive(self._ad, arg_15_1)

	return
end

function SortGameGrid:GetEmptyLayerFirst()
	local var_16_0 = 0

	for iter_16_0 = 1, SortGameConst.grid_max_layer do
		local var_16_1 = false

		for iter_16_1 = 1, var_0_1 do
			if self._itemIdDic[iter_16_1][iter_16_0] ~= 0 then
				var_16_1 = true

				break
			end
		end

		if not var_16_1 then
			var_16_0 = iter_16_0

			break
		end
	end

	return var_16_0
end

function SortGameGrid:GetLayerEmptyFlag(arg_17_1)
	if arg_17_1 > SortGameConst.grid_max_layer then
		return true
	end

	local var_17_0 = false

	for iter_17_0 = 1, var_0_1 do
		if self._itemIdDic[iter_17_0][arg_17_1] ~= 0 then
			var_17_0 = true

			break
		end
	end

	return not var_17_0
end

function SortGameGrid:GetBottomIds()
	local var_18_0 = {}

	for iter_18_0 = 1, var_0_1 do
		table.insert(var_18_0, self._itemIdDic[iter_18_0][1])
	end

	return var_18_0
end

function SortGameGrid:GetBottomId(arg_19_1)
	return self._itemIdDic[arg_19_1][1]
end

function SortGameGrid:GetAllIds()
	local var_20_0 = {}

	for iter_20_0 = 1, var_0_1 do
		for iter_20_1 = 1, SortGameConst.grid_max_layer do
			table.insert(var_20_0, self._itemIdDic[iter_20_0][iter_20_1])
		end
	end

	return var_20_0
end

function SortGameGrid:SetOffset(arg_21_1)
	self._offset = arg_21_1
	self._ad.anchoredPosition = Vector2(arg_21_1[1] * SortGameConst.grid_bound[1], arg_21_1[2] * SortGameConst.grid_bound[2])

	return
end

function SortGameGrid:checkItemPass()
	if self._gridType == SortGameConst.grid_type_empty or self._gridType == SortGameConst.grid_type_out then
		return false
	end

	local var_22_0 = self:GetItemBottomId(1)
	local var_22_1 = self:GetItemBottomId(2)
	local var_22_2 = self:GetItemBottomId(3)

	if var_22_0 and var_22_1 and var_22_2 and var_22_0 ~= 0 and var_22_1 ~= 0 and var_22_2 ~= 0 and var_22_0 == var_22_1 and var_22_1 == var_22_2 then
		if self._itemRemoveCallback then
			self._itemRemoveCallback(self._index, var_22_0)
			self._itemRemoveCallback(self._index, var_22_1)
			self._itemRemoveCallback(self._index, var_22_2)
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SortGameConst.SFX_PASS)
		self:PassItem()
	end

	return
end

function SortGameGrid:InputIds(arg_23_1)
	local var_23_0 = self:GetInputEmptyLayer()

	if var_23_0 <= SortGameConst.grid_max_layer then
		print("插入层数 = " .. var_23_0)

		for iter_23_0 = 1, var_0_1 do
			self._itemIdDic[iter_23_0][var_23_0] = arg_23_1[iter_23_0]

			self:UpdateItem(iter_23_0)
		end

		setActive(self._ad, true)

		self._currentInputCount = self._currentInputCount + 1
	else
		warning("插入失败！数据对齐出问题，需要排查")
	end

	return
end

function SortGameGrid:ReplaceId(arg_24_1, arg_24_2)
	self._itemIdDic[arg_24_1][1] = arg_24_2

	self:UpdateItem(arg_24_1)

	return
end

function SortGameGrid:UpdateItem(arg_25_1)
	if self._itemIdDic[arg_25_1][1] ~= 0 then
		self:SetItemIcon(arg_25_1, self._itemIdDic[arg_25_1][1], "top")
	end

	if self._itemIdDic[arg_25_1][2] ~= 0 then
		self:SetItemIcon(arg_25_1, self._itemIdDic[arg_25_1][2], "bottom")
	end

	setActive(findTF(self._itemsTF[arg_25_1], "top"), self._itemIdDic[arg_25_1][1] ~= 0)
	setActive(findTF(self._itemsTF[arg_25_1], "bottom"), self._itemIdDic[arg_25_1][2] ~= 0)

	return
end

function SortGameGrid:MoveItemToBottom(arg_26_1)
	local var_26_0

	if arg_26_1 then
		var_26_0 = arg_26_1 + 1 or 1
	end

	local var_26_1 = self:GetEmptyLayerFirst()

	if var_26_1 >= 1 and not self:GetLayerEmptyFlag(var_26_1 + 1) then
		for iter_26_0 = 1, var_0_1 do
			self._itemIdDic[iter_26_0][var_26_1] = self._itemIdDic[iter_26_0][var_26_1 + 1]
			self._itemIdDic[iter_26_0][var_26_1 + 1] = 0
		end

		return self:MoveItemToBottom(var_26_0)
	end

	if var_26_0 > 1 then
		for iter_26_1 = 1, var_0_1 do
			self:UpdateItem(iter_26_1)
			self._itemsAnimator[iter_26_1]:SetTrigger("show")
		end
	end

	return var_26_0 > 1
end

function SortGameGrid:SetShowAniamtion()
	for iter_27_0 = 1, var_0_1 do
		self._itemsAnimator[iter_27_0]:SetTrigger("show")
	end

	return
end

function SortGameGrid:GetItemBottomId(arg_28_1)
	return self._itemIdDic[arg_28_1][1]
end

function SortGameGrid:InSertItem(arg_29_1, arg_29_2)
	if self._itemIdDic and self._itemIdDic[arg_29_1] then
		self._itemIdDic[arg_29_1][1] = arg_29_2

		self:UpdateItem(arg_29_1)
	end

	if not self:checkItemPass() then
		self:UpdateItem(arg_29_1)
	end

	return
end

function SortGameGrid:CheckMoveBottom()
	if self:MoveItemToBottom() and self._moveBottomCallback then
		self._moveBottomCallback(self._index)
	end

	return
end

function SortGameGrid:SetItemAlpha(arg_31_1, arg_31_2)
	self._itemsAnimator[arg_31_1]:SetTrigger(arg_31_2 and "alpha" or "normal")
	print("set alpha " .. arg_31_1 .. " " .. tostring(arg_31_2))

	return
end

function SortGameGrid:SetItemSelect(arg_32_1, arg_32_2)
	setActive(findTF(self._itemsTF[arg_32_1], "select"), arg_32_2)

	return
end

function SortGameGrid:SetItemIcon(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = findTF(self._itemsTF[arg_33_1], arg_33_3 .. "/icon")

	setActive(var_33_0, false)
	GetSpriteFromAtlasAsync(SortGameConst.ui_atlas, "item_" .. arg_33_2, function(arg_34_0)
		if var_33_0 then
			setImageSprite(var_33_0, arg_34_0, true)
			setActive(var_33_0, true)
		end

		return
	end)

	return
end

function SortGameGrid:AddItemEventCallback(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	for iter_35_0 = 1, var_0_1 do
		local var_35_0 = iter_35_0

		if self._gridEventTriggerList[iter_35_0] then
			self._gridEventTriggerList[iter_35_0]:AddDragFunc(function(arg_36_0, arg_36_1)
				if self._itemIdDic[var_35_0][1] == 0 then
					return
				end

				if arg_35_1 then
					arg_35_1(self._index, var_35_0, arg_36_1)
				end

				return
			end)
			self._gridEventTriggerList[iter_35_0]:AddDragEndFunc(function(arg_37_0, arg_37_1)
				if self._itemIdDic[var_35_0][1] == 0 then
					return
				end

				if arg_35_2 then
					arg_35_2(self._index, var_35_0, arg_37_1)
				end

				setActive(self._itemsTF[var_35_0], true)

				return
			end)
			self._gridEventTriggerList[iter_35_0]:AddPointEnterFunc(function(arg_38_0, arg_38_1)
				if self._gridType == SortGameConst.grid_type_out then
					return
				end

				if self._itemIdDic[var_35_0][1] ~= 0 then
					return
				end

				if arg_35_3 then
					arg_35_3(self._index, var_35_0, arg_38_1)
				end

				return
			end)
			self._gridEventTriggerList[iter_35_0]:AddPointExitFunc(function(arg_39_0, arg_39_1)
				if self._gridType == SortGameConst.grid_type_out then
					return
				end

				if self._itemIdDic[var_35_0][1] ~= 0 then
					return
				end

				if arg_35_4 then
					arg_35_4(self._index, var_35_0, arg_39_1)
				end

				return
			end)
		end
	end

	return
end

function SortGameGrid:ClearItems()
	self._currentInputCount = 0

	for iter_40_0 = 1, var_0_1 do
		for iter_40_1 = 1, SortGameConst.grid_max_layer do
			self._itemIdDic[iter_40_0][iter_40_1] = 0
		end

		self:UpdateItem(iter_40_0)
	end

	return
end

function SortGameGrid:GetInputEmptyCount()
	local var_41_0 = 0

	for iter_41_0 = 1, var_0_1 do
		if self._gridType ~= SortGameConst.grid_type_out and self._gridType ~= SortGameConst.grid_type_empty and self._itemIdDic[iter_41_0][1] == 0 then
			var_41_0 = var_41_0 + 1
		end
	end

	return var_41_0
end

function SortGameGrid:Stop()
	for iter_42_0 = 1, #self._itemsAnimator do
		self._itemsAnimator[iter_42_0].speed = 0
	end

	return
end

function SortGameGrid:Resume()
	for iter_43_0 = 1, #self._itemsAnimator do
		self._itemsAnimator[iter_43_0].speed = 1
	end

	return
end

function SortGameGrid:Clear()
	self._currentInputCount = 0

	for iter_44_0 = 1, #self._itemsAnimator do
		self._itemsAnimator[iter_44_0].speed = 1
	end

	for iter_44_1 = 1, var_0_1 do
		for iter_44_2 = 1, SortGameConst.grid_max_layer do
			self._itemIdDic[iter_44_1][iter_44_2] = 0
		end

		self:SetItemSelect(iter_44_1, false)
	end

	setActive(self._ad, false)

	for iter_44_3 = 1, var_0_1 do
		self:UpdateItem(iter_44_3)
	end

	self._removeDic = {}

	return
end

function SortGameGrid:Dispose()
	for iter_45_0 = 1, #self._gridEventTriggerList do
		ClearEventTrigger(self._gridEventTriggerList[iter_45_0])
	end

	return
end

return SortGameGrid
