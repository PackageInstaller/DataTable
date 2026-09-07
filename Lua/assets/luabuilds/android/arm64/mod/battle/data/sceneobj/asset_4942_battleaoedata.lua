ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local BattleAOEData = class("BattleAOEData")

ys.Battle.BattleAOEData = BattleAOEData
BattleAOEData.__name = "BattleAOEData"
BattleAOEData.ALIGNMENT_LEFT = "left"
BattleAOEData.ALIGNMENT_RIGHT = "right"
BattleAOEData.ALIGNMENT_MIDDLE = "middle"
BattleAOEData.SOURCE_BULLET_9 = "bulletType9"

function BattleAOEData:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._areaUniqueID = arg_1_1
	self._areaCldFunc = arg_1_3
	self._endFunc = arg_1_4
	self._IFF = arg_1_2
	self._cldObjList = {}
	self._cldObjDistanceList = {}

	self:SetTickness(10)

	self._alignment = Vector3.zero
	self._angle = 0
	self._component = {}
	self._timeExemptKey = "aoe_" .. self._areaUniqueID

	return
end

function BattleAOEData:StartTimer()
	if self._lifeTime == -1 then
		self._flag = false

		return
	end

	self._flag = true

	if self._lifeTime > 0 then
		self._lifeTimer = pg.TimeMgr.GetInstance():AddBattleTimer("areaTimer", 0, self._lifeTime, function()
			self:RemoveTimer()

			return
		end, true)
	end

	return
end

function BattleAOEData:GetTimeRationExemptKey()
	return self._timeExemptKey
end

function BattleAOEData:RemoveTimer()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._lifeTimer)

	self._lifeTimer = nil
	self._flag = false

	return
end

function BattleAOEData:ClearCLDList()
	self._cldObjList = {}

	return
end

function BattleAOEData:AppendCldObj(arg_7_1)
	self._cldObjList[#self._cldObjList + 1] = arg_7_1

	return
end

function BattleAOEData:Settle()
	self.SortCldObjList(self._cldObjList)
	self._cldComponent:GetCldData().func(self._cldObjList)

	return
end

function BattleAOEData:SettleFinale()
	if self._endFunc then
		self.SortCldObjList(self._cldObjList)
		self._endFunc(self._cldObjList)
	end

	return
end

function BattleAOEData:ForceExit()
	return
end

function BattleAOEData:SortCldObjList()
	table.sort(self, BattleAOEData._Fun_SortCldObjList)

	return
end

function BattleAOEData:_Fun_SortCldObjList(arg_12_1)
	if self.IsBoss ~= arg_12_1.IsBoss then
		if arg_12_1.IsBoss then
			return true
		else
			return false
		end
	else
		return self.UID < arg_12_1.UID
	end

	return
end

function BattleAOEData:SetOpponentAffected(arg_13_1)
	self._opponentAffected = arg_13_1

	return
end

function BattleAOEData:OpponentAffected()
	return self._opponentAffected
end

function BattleAOEData:SetIndiscriminate(arg_15_1)
	self._indicriminate = arg_15_1

	return
end

function BattleAOEData:GetIndiscriminate()
	return self._indicriminate
end

function BattleAOEData:GetActiveFlag()
	return self._flag
end

function BattleAOEData:SetActiveFlag(arg_18_1)
	self._flag = arg_18_1

	return
end

function BattleAOEData:Dispose()
	for iter_19_0, iter_19_1 in ipairs(self._component) do
		iter_19_1:Dispose()
	end

	self._component = nil

	self:RemoveTimer()

	self._cldObjList = nil

	return
end

function BattleAOEData:GetUniqueID()
	return self._areaUniqueID
end

function BattleAOEData:GetIFF()
	return self._IFF
end

function BattleAOEData:GetAreaType()
	return self._areaType
end

function BattleAOEData:GetPosition()
	return self._pos
end

function BattleAOEData:GetTickness()
	return self._tickness
end

function BattleAOEData:GetLifeTime()
	return self._lifeTime
end

function BattleAOEData:GetFieldType()
	return self._fieldType
end

function BattleAOEData:GetDiveFilter()
	return self._diveFilter
end

function BattleAOEData:GetCldFunc()
	return self._areaCldFunc
end

function BattleAOEData:GetSource()
	return self._source
end

function BattleAOEData:GetHeight()
	return self._height
end

function BattleAOEData:GetWidth()
	return self._width
end

function BattleAOEData:GetAngle()
	return self._angle
end

function BattleAOEData:GetRange()
	return self._range
end

function BattleAOEData:GetSectorAngle()
	return self._sectorAngle
end

function BattleAOEData:SetAreaType(arg_35_1)
	self._areaType = arg_35_1

	self:InitCldComponent()

	return
end

function BattleAOEData:SetDiveFilter(arg_36_1)
	self._diveFilter = arg_36_1

	return
end

function BattleAOEData:SetPosition(arg_37_1)
	self._pos = arg_37_1

	return
end

function BattleAOEData:SetTickness(arg_38_1)
	self._tickness = arg_38_1

	return
end

function BattleAOEData:SetFieldType(arg_39_1)
	self._fieldType = arg_39_1

	return
end

function BattleAOEData:SetLifeTime(arg_40_1)
	self._lifeTime = arg_40_1

	return
end

function BattleAOEData:SetSource(arg_41_1)
	self._source = arg_41_1

	return
end

function BattleAOEData:SetHeight(arg_42_1)
	self._height = arg_42_1

	return
end

function BattleAOEData:SetWidth(arg_43_1)
	self._width = arg_43_1

	return
end

function BattleAOEData:SetAngle(arg_44_1)
	self._angle = arg_44_1

	return
end

function BattleAOEData:SetRange(arg_45_1)
	self._range = arg_45_1

	return
end

function BattleAOEData:SetSectorAngle(arg_46_1, arg_46_2)
	self._sectorAngle = arg_46_1
	self._sectorDir = arg_46_2
	self._upperEdge = math.deg2Rad * (self._sectorAngle / 2)
	self._lowerEdge = -1 * self._upperEdge

	if arg_46_2 == var_0_1.UnitDir.LEFT then
		self._normalizeOffset = math.pi - 0
	elseif arg_46_2 == var_0_1.UnitDir.RIGHT then
		self._normalizeOffset = 0
	end

	self._wholeCircle = math.pi - self._normalizeOffset
	self._negativeCircle = -math.pi - self._normalizeOffset
	self._wholeCircleNormalizeOffset = self._normalizeOffset - math.pi * 2
	self._negativeCircleNormalizeOffset = self._normalizeOffset + math.pi * 2

	return
end

function BattleAOEData:SetAnchorPointAlignment(arg_47_1)
	if arg_47_1 == BattleAOEData.ALIGNMENT_LEFT then
		self._alignment = Vector3(self._width * 0.5, 0, 0)
	elseif arg_47_1 == BattleAOEData.ALIGNMENT_RIGHT then
		self._alignment = Vector3(self._width * -0.5, 0, 0)
	end

	return
end

function BattleAOEData:GetAnchorPointAlignment()
	return self._alignment
end

function BattleAOEData:GetFXStatic()
	return self._fxStatic
end

function BattleAOEData:SetFXStatic(arg_50_1)
	self._fxStatic = arg_50_1

	return
end

function BattleAOEData:AppendComponent(arg_51_1)
	table.insert(self._component, arg_51_1)

	return
end

function BattleAOEData:InitCldComponent()
	if self._areaType == var_0_1.AreaType.CUBE or self._areaType == var_0_1.AreaType.ELLIPSE then
		self._cldComponent = var_0_0.Battle.BattleCubeCldComponent.New(self._width, self._tickness, self._height, 0, 0)
	elseif self._areaType == var_0_1.AreaType.COLUMN then
		self._cldComponent = var_0_0.Battle.BattleColumnCldComponent.New(self._range, self._tickness)
	end

	self._cldComponent:SetCldData({
		type = var_0_1.CldType.AOE,
		UID = self:GetUniqueID(),
		IFF = self:GetIFF(),
		func = self:GetCldFunc()
	})
	self._cldComponent:SetActive(true)

	return
end

function BattleAOEData:GetCldComponent()
	return self._cldComponent
end

function BattleAOEData:DeactiveCldBox()
	self._cldComponent:SetActive(false)

	return
end

function BattleAOEData:GetCldBox()
	return self._cldComponent:GetCldBox(self:GetPosition() + self._alignment)
end

function BattleAOEData:GetCldData()
	return self._cldComponent:GetCldData()
end

function BattleAOEData:UpdateDistanceInfo()
	for iter_57_0, iter_57_1 in ipairs(self._cldObjList) do
		local var_57_1 = iter_57_1.UpperBound
		local var_57_2 = iter_57_1.LowerBound
		local var_57_3 = self._pos.x
		local var_57_4
		local var_57_5

		if iter_57_1.LeftBound <= self._pos.x and var_57_3 <= iter_57_1.RightBound then
			var_57_4 = true
		elseif var_57_3 < iter_57_1.LeftBound then
			var_57_5 = iter_57_1.LeftBound
		elseif iter_57_1.RightBound < var_57_3 then
			var_57_5 = iter_57_1.RightBound
		end

		local var_57_6 = self._pos.z
		local var_57_7
		local var_57_8

		if var_57_2 <= self._pos.z and var_57_6 <= var_57_1 then
			var_57_7 = true
		elseif var_57_6 < var_57_2 then
			var_57_8 = var_57_2
		elseif var_57_1 < var_57_6 then
			var_57_8 = var_57_1
		end

		self._cldObjDistanceList[iter_57_1.UID] = var_57_4 and var_57_7 and 0 or var_57_4 and math.abs(var_57_8 - var_57_6) or var_57_7 and math.abs(var_57_5 - var_57_3) or math.sqrt((var_57_5 - var_57_3)^2 + (var_57_8 - var_57_6)^2)
	end

	return
end

function BattleAOEData:GetDistance(arg_58_1)
	return self._cldObjDistanceList[arg_58_1]
end

function BattleAOEData:IsOutOfAngle(arg_59_1)
	if not self._sectorAngle or self._sectorAngle >= 360 then
		return false
	else
		local var_59_0 = arg_59_1:GetPosition()
		local var_59_1 = math.atan2(var_59_0.z - self._pos.z, var_59_0.x - self._pos.x)

		var_59_1 = var_59_1 > self._wholeCircle and var_59_1 + self._wholeCircleNormalizeOffset or var_59_1 < self._negativeCircle and var_59_1 + self._negativeCircleNormalizeOffset or var_59_1 + self._normalizeOffset

		if var_59_1 > self._lowerEdge and var_59_1 < self._upperEdge then
			return false
		else
			return true
		end
	end

	return
end

return
