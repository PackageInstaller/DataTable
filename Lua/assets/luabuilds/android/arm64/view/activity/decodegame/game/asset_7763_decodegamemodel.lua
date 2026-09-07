local DecodeGameModel = class("DecodeGameModel")

function DecodeGameModel:SetData(arg_1_1)
	self.data = arg_1_1
	self.mapId = arg_1_1.mapId
	self.unlocks = arg_1_1.unlocks
	self.canUseCnt = arg_1_1.canUseCnt
	self.passwords = arg_1_1.passwords
	self.isFinished = arg_1_1.isFinished
	self.mapIndexs = {}

	if self.isFinished then
		self:BuildMapIndexs()
	else
		for iter_1_0 = 1, #DecodeGameConst.PASSWORD do
			table.insert(self.mapIndexs, false)
		end
	end

	self.maps = {}

	for iter_1_1 = 1, DecodeGameConst.MAX_MAP_COUNT do
		table.insert(self.maps, self:InitMap(iter_1_1))
	end

	self:SwitchMap(arg_1_1.mapId)

	return
end

function DecodeGameModel:BuildMapIndexs()
	local function var_2_0(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(DecodeGameConst.MAPS_PASSWORD) do
			if _.any(iter_3_1, function(arg_4_0)
				return arg_4_0[1] == arg_3_0[1] and arg_4_0[2] == arg_3_0[2]
			end) then
				return iter_3_0
			end
		end

		return
	end

	for iter_2_0 = 1, #DecodeGameConst.PASSWORD do
		table.insert(self.mapIndexs, DecodeGameConst.Vect2Index(DecodeGameConst.PASSWORD[iter_2_0][1], DecodeGameConst.PASSWORD[iter_2_0][2]) + (var_2_0(DecodeGameConst.PASSWORD[iter_2_0]) - 1) * (DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN))
	end

	return
end

function DecodeGameModel:InitMap(arg_5_1)
	local function var_5_0(arg_6_0, arg_6_1, arg_6_2)
		return {
			isUsed = false,
			index = arg_6_2,
			i = arg_6_0,
			j = arg_6_1,
			position = Vector3(DecodeGameConst.START_POS[1] + (arg_6_1 - 1) * DecodeGameConst.BLOCK_SIZE[1], DecodeGameConst.START_POS[2] - (arg_6_0 - 1) * DecodeGameConst.BLOCK_SIZE[2], 0),
			isUnlock = table.contains(self.unlocks, arg_6_2)
		}
	end

	local var_5_1 = {}
	local var_5_2 = (arg_5_1 - 1) * (DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN)

	for iter_5_0 = 1, DecodeGameConst.MAP_ROW do
		for iter_5_1 = 1, DecodeGameConst.MAP_COLUMN do
			var_5_2 = var_5_2 + 1

			table.insert(var_5_1, (var_5_0(iter_5_0, iter_5_1, var_5_2)))
		end
	end

	local var_5_3 = {}

	for iter_5_2 = 1, #self.passwords[arg_5_1] do
		table.insert(var_5_3, (arg_5_1 - 1) * (DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN) + DecodeGameConst.Vect2Index(self.passwords[arg_5_1][iter_5_2][1], self.passwords[arg_5_1][iter_5_2][2]))
	end

	return {
		id = arg_5_1,
		items = var_5_1,
		isUnlock = self:IsUnlockMap(arg_5_1),
		password = self.passwords[arg_5_1],
		passwordIndexs = var_5_3
	}
end

function DecodeGameModel:SwitchMap(arg_7_1)
	self.map = self.maps[arg_7_1]

	for iter_7_0, iter_7_1 in ipairs(self.map.items) do
		iter_7_1.isUsed = self:IsUsedMapKey(iter_7_1.index)
	end

	return
end

function DecodeGameModel:ExitMap()
	self.map = nil

	return
end

function DecodeGameModel:UnlockMapItem(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self.map.items) do
		if iter_9_1.index == arg_9_1 then
			iter_9_1.isUnlock = true

			break
		end
	end

	if not table.contains(self.unlocks, arg_9_1) then
		table.insert(self.unlocks, arg_9_1)
	end

	self.canUseCnt = self.canUseCnt - 1

	return
end

function DecodeGameModel:OnRepairMap()
	self.map.isUnlock = true

	return
end

function DecodeGameModel:IsUnlock(arg_11_1)
	return _.any(self.map.items, function(arg_12_0)
		return arg_12_0.index == arg_11_1 and arg_12_0.isUnlock
	end)
end

function DecodeGameModel:GetUnlockedCnt()
	return #self.unlocks
end

function DecodeGameModel:IsUnlockMap(arg_14_1)
	return _.all(_.range((arg_14_1 - 1) * (DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN) + 1, (arg_14_1 - 1) * (DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN) + 1 + DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN - 1), function(arg_15_0)
		return table.contains(self.unlocks, arg_15_0)
	end)
end

function DecodeGameModel:GetUnlockMapCnt()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs(self.maps) do
		if iter_16_1.isUnlock then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function DecodeGameModel:CheckIndex(arg_17_1)
	local var_17_0 = self:GetCurrMapKeyIndex(arg_17_1)
	local var_17_1 = (math.ceil(var_17_0 / #DecodeGameConst.MAPS_PASSWORD[1]) - 1) * #DecodeGameConst.MAPS_PASSWORD[1] + 1

	if var_17_0 == var_17_1 then
		return true
	end

	if var_17_1 < var_17_0 and self.mapIndexs[var_17_0 - 1] ~= false then
		return true
	end

	return false
end

function DecodeGameModel:IsUsedMapKey(arg_18_1)
	return table.contains(self.mapIndexs, arg_18_1)
end

function DecodeGameModel:IsMapKey(arg_19_1)
	return _.any(self.map.passwordIndexs, function(arg_20_0)
		return arg_20_0 == arg_19_1
	end)
end

function DecodeGameModel:InsertMapKey(arg_21_1)
	self.mapIndexs[self:GetCurrMapKeyIndex(arg_21_1)] = arg_21_1

	return
end

function DecodeGameModel:GetMapKeyStr(arg_22_1)
	arg_22_1 = arg_22_1 - (self.map.id - 1) * (DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN)

	return DecodeGameConst.PASSWORDS[arg_22_1]
end

function DecodeGameModel:ClearMapKeys()
	if self.isFinished then
		return
	end

	self.mapIndexs = _.map(self.mapIndexs, function(arg_24_0)
		return false
	end)

	return
end

function DecodeGameModel:GetCurrMapKeyIndex(arg_25_1)
	local var_25_0, var_25_1 = DecodeGameConst.Index2Vect(arg_25_1 % (DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN))
	local var_25_2

	for iter_25_0, iter_25_1 in ipairs(DecodeGameConst.PASSWORD) do
		if iter_25_1[1] == var_25_0 and iter_25_1[2] == var_25_1 then
			var_25_2 = iter_25_0

			break
		end
	end

	assert(var_25_2)

	return var_25_2
end

function DecodeGameModel:IsSuccess()
	return _.all(self.mapIndexs, function(arg_27_0)
		return arg_27_0 ~= false
	end)
end

function DecodeGameModel:GetMapKeyStrs()
	return _.map(self.mapIndexs, function(arg_29_0)
		if arg_29_0 == false then
			return false
		end

		return DecodeGameConst.PASSWORDS[arg_29_0 % (DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN)]
	end)
end

function DecodeGameModel:GetPassWordProgress()
	local var_30_1 = {}
	local var_30_2 = 0

	for iter_30_0 = 1, #DecodeGameConst.PASSWORD, DecodeGameConst.MAX_MAP_COUNT do
		local var_30_3 = _.all(_.slice(self.mapIndexs, iter_30_0, 3), function(arg_31_0)
			return arg_31_0 ~= false
		end)

		if var_30_3 == true then
			var_30_2 = var_30_2 + 1
		end

		table.insert(var_30_1, var_30_3)
	end

	return var_30_1, var_30_2
end

function DecodeGameModel:Finish()
	self.isFinished = true

	return
end

function DecodeGameModel:CanUnlockAward()
	return not self.isFinished and DecodeGameConst.MAX_MAP_COUNT * DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN <= self:GetUnlockedCnt()
end

function DecodeGameModel:Dispose()
	return
end

return DecodeGameModel
