ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_1 = class("BattleAOEData")

ys.Battle.BattleAOEData = var_0_1
var_0_1.__name = "BattleAOEData"
var_0_1.ALIGNMENT_LEFT = "left"
var_0_1.ALIGNMENT_RIGHT = "right"
var_0_1.ALIGNMENT_MIDDLE = "middle"
var_0_1.SOURCE_BULLET_9 = "bulletType9"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._areaUniqueID = arg_1_1
	arg_1_0._areaCldFunc = arg_1_3
	arg_1_0._endFunc = arg_1_4
	arg_1_0._IFF = arg_1_2
	arg_1_0._cldObjList = {}
	arg_1_0._cldObjDistanceList = {}

	arg_1_0:SetTickness(10)

	arg_1_0._alignment = Vector3.zero
	arg_1_0._angle = 0
	arg_1_0._component = {}
	arg_1_0._timeExemptKey = "aoe_" .. arg_1_0._areaUniqueID

	return
end

function var_0_1.StartTimer(arg_2_0)
	if arg_2_0._lifeTime == -1 then
		arg_2_0._flag = false

		return
	end

	arg_2_0._flag = true

	if arg_2_0._lifeTime > 0 then
		arg_2_0._lifeTimer = pg.TimeMgr.GetInstance():AddBattleTimer("areaTimer", 0, arg_2_0._lifeTime, function()
			arg_2_0:RemoveTimer()

			return
		end, true)
	end

	return
end

function var_0_1.GetTimeRationExemptKey(arg_4_0)
	return arg_4_0._timeExemptKey
end

function var_0_1.RemoveTimer(arg_5_0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_5_0._lifeTimer)

	arg_5_0._lifeTimer = nil
	arg_5_0._flag = false

	return
end

function var_0_1.ClearCLDList(arg_6_0)
	arg_6_0._cldObjList = {}

	return
end

function var_0_1.AppendCldObj(arg_7_0, arg_7_1)
	arg_7_0._cldObjList[#arg_7_0._cldObjList + 1] = arg_7_1

	return
end

function var_0_1.Settle(arg_8_0)
	arg_8_0.SortCldObjList(arg_8_0._cldObjList)
	arg_8_0._cldComponent:GetCldData().func(arg_8_0._cldObjList)

	return
end

function var_0_1.SettleFinale(arg_9_0)
	if arg_9_0._endFunc then
		arg_9_0.SortCldObjList(arg_9_0._cldObjList)
		arg_9_0._endFunc(arg_9_0._cldObjList)
	end

	return
end

function var_0_1.ForceExit(arg_10_0)
	return
end

function var_0_1.SortCldObjList(arg_11_0)
	table.sort(arg_11_0, var_0_1._Fun_SortCldObjList)

	return
end

function var_0_1._Fun_SortCldObjList(arg_12_0, arg_12_1)
	if arg_12_0.IsBoss ~= arg_12_1.IsBoss then
		if arg_12_1.IsBoss then
			return true
		else
			return false
		end
	else
		return arg_12_0.UID < arg_12_1.UID
	end

	return
end

function var_0_1.SetOpponentAffected(arg_13_0, arg_13_1)
	arg_13_0._opponentAffected = arg_13_1

	return
end

function var_0_1.OpponentAffected(arg_14_0)
	return arg_14_0._opponentAffected
end

function var_0_1.SetIndiscriminate(arg_15_0, arg_15_1)
	arg_15_0._indicriminate = arg_15_1

	return
end

function var_0_1.GetIndiscriminate(arg_16_0)
	return arg_16_0._indicriminate
end

function var_0_1.GetActiveFlag(arg_17_0)
	return arg_17_0._flag
end

function var_0_1.SetActiveFlag(arg_18_0, arg_18_1)
	arg_18_0._flag = arg_18_1

	return
end

function var_0_1.Dispose(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._component) do
		iter_19_1:Dispose()
	end

	arg_19_0._component = nil

	arg_19_0:RemoveTimer()

	arg_19_0._cldObjList = nil

	return
end

function var_0_1.GetUniqueID(arg_20_0)
	return arg_20_0._areaUniqueID
end

function var_0_1.GetIFF(arg_21_0)
	return arg_21_0._IFF
end

function var_0_1.GetAreaType(arg_22_0)
	return arg_22_0._areaType
end

function var_0_1.GetPosition(arg_23_0)
	return arg_23_0._pos
end

function var_0_1.GetTickness(arg_24_0)
	return arg_24_0._tickness
end

function var_0_1.GetLifeTime(arg_25_0)
	return arg_25_0._lifeTime
end

function var_0_1.GetFieldType(arg_26_0)
	return arg_26_0._fieldType
end

function var_0_1.GetDiveFilter(arg_27_0)
	return arg_27_0._diveFilter
end

function var_0_1.GetCldFunc(arg_28_0)
	return arg_28_0._areaCldFunc
end

function var_0_1.GetSource(arg_29_0)
	return arg_29_0._source
end

function var_0_1.GetHeight(arg_30_0)
	return arg_30_0._height
end

function var_0_1.GetWidth(arg_31_0)
	return arg_31_0._width
end

function var_0_1.GetAngle(arg_32_0)
	return arg_32_0._angle
end

function var_0_1.GetRange(arg_33_0)
	return arg_33_0._range
end

function var_0_1.GetSectorAngle(arg_34_0)
	return arg_34_0._sectorAngle
end

function var_0_1.SetAreaType(arg_35_0, arg_35_1)
	arg_35_0._areaType = arg_35_1

	arg_35_0:InitCldComponent()

	return
end

function var_0_1.SetDiveFilter(arg_36_0, arg_36_1)
	arg_36_0._diveFilter = arg_36_1

	return
end

function var_0_1.SetPosition(arg_37_0, arg_37_1)
	arg_37_0._pos = arg_37_1

	return
end

function var_0_1.SetTickness(arg_38_0, arg_38_1)
	arg_38_0._tickness = arg_38_1

	return
end

function var_0_1.SetFieldType(arg_39_0, arg_39_1)
	arg_39_0._fieldType = arg_39_1

	return
end

function var_0_1.SetLifeTime(arg_40_0, arg_40_1)
	arg_40_0._lifeTime = arg_40_1

	return
end

function var_0_1.SetSource(arg_41_0, arg_41_1)
	arg_41_0._source = arg_41_1

	return
end

function var_0_1.SetHeight(arg_42_0, arg_42_1)
	arg_42_0._height = arg_42_1

	return
end

function var_0_1.SetWidth(arg_43_0, arg_43_1)
	arg_43_0._width = arg_43_1

	return
end

function var_0_1.SetAngle(arg_44_0, arg_44_1)
	arg_44_0._angle = arg_44_1

	return
end

function var_0_1.SetRange(arg_45_0, arg_45_1)
	arg_45_0._range = arg_45_1

	return
end

function var_0_1.SetSectorAngle(arg_46_0, arg_46_1, arg_46_2)
	arg_46_0._sectorAngle = arg_46_1
	arg_46_0._sectorDir = arg_46_2
	arg_46_0._upperEdge = math.deg2Rad * (arg_46_0._sectorAngle / 2)
	arg_46_0._lowerEdge = -1 * arg_46_0._upperEdge

	if arg_46_2 == var_0_0.UnitDir.LEFT then
		arg_46_0._normalizeOffset = math.pi - 0
	elseif arg_46_2 == var_0_0.UnitDir.RIGHT then
		arg_46_0._normalizeOffset = 0
	end

	arg_46_0._wholeCircle = math.pi - arg_46_0._normalizeOffset
	arg_46_0._negativeCircle = -math.pi - arg_46_0._normalizeOffset
	arg_46_0._wholeCircleNormalizeOffset = arg_46_0._normalizeOffset - math.pi * 2
	arg_46_0._negativeCircleNormalizeOffset = arg_46_0._normalizeOffset + math.pi * 2

	return
end

function var_0_1.SetAnchorPointAlignment(arg_47_0, arg_47_1)
	if arg_47_1 == var_0_1.ALIGNMENT_LEFT then
		arg_47_0._alignment = Vector3(arg_47_0._width * 0.5, 0, 0)
	elseif arg_47_1 == var_0_1.ALIGNMENT_RIGHT then
		arg_47_0._alignment = Vector3(arg_47_0._width * -0.5, 0, 0)
	end

	return
end

function var_0_1.GetAnchorPointAlignment(arg_48_0)
	return arg_48_0._alignment
end

function var_0_1.GetFXStatic(arg_49_0)
	return arg_49_0._fxStatic
end

function var_0_1.SetFXStatic(arg_50_0, arg_50_1)
	arg_50_0._fxStatic = arg_50_1

	return
end

function var_0_1.AppendComponent(arg_51_0, arg_51_1)
	table.insert(arg_51_0._component, arg_51_1)

	return
end

function var_0_1.InitCldComponent(arg_52_0)
	if arg_52_0._areaType == var_0_0.AreaType.CUBE or arg_52_0._areaType == var_0_0.AreaType.ELLIPSE then
		arg_52_0._cldComponent = var_0.Battle.BattleCubeCldComponent.New(arg_52_0._width, arg_52_0._tickness, arg_52_0._height, 0, 0)
	elseif arg_52_0._areaType == var_0_0.AreaType.COLUMN then
		arg_52_0._cldComponent = var_0.Battle.BattleColumnCldComponent.New(arg_52_0._range, arg_52_0._tickness)
	end

	arg_52_0._cldComponent:SetCldData({
		type = var_0_0.CldType.AOE,
		UID = arg_52_0:GetUniqueID(),
		IFF = arg_52_0:GetIFF(),
		func = arg_52_0:GetCldFunc()
	})
	arg_52_0._cldComponent:SetActive(true)

	return
end

function var_0_1.GetCldComponent(arg_53_0)
	return arg_53_0._cldComponent
end

function var_0_1.DeactiveCldBox(arg_54_0)
	arg_54_0._cldComponent:SetActive(false)

	return
end

function var_0_1.GetCldBox(arg_55_0)
	return arg_55_0._cldComponent:GetCldBox(arg_55_0:GetPosition() + arg_55_0._alignment)
end

function var_0_1.GetCldData(arg_56_0)
	return arg_56_0._cldComponent:GetCldData()
end

function var_0_1.UpdateDistanceInfo(arg_57_0)
	for iter_57_0, iter_57_1 in ipairs(arg_57_0._cldObjList) do
		local var_57_1 = iter_57_1.UpperBound
		local var_57_2 = iter_57_1.LowerBound
		local var_57_3 = arg_57_0._pos.x
		local var_57_4
		local var_57_5

		if iter_57_1.LeftBound <= arg_57_0._pos.x and var_57_3 <= iter_57_1.RightBound then
			var_57_4 = true
		elseif var_57_3 < iter_57_1.LeftBound then
			var_57_5 = iter_57_1.LeftBound
		elseif iter_57_1.RightBound < var_57_3 then
			var_57_5 = iter_57_1.RightBound
		end

		local var_57_6 = arg_57_0._pos.z
		local var_57_7
		local var_57_8

		if var_57_2 <= arg_57_0._pos.z and var_57_6 <= var_57_1 then
			var_57_7 = true
		elseif var_57_6 < var_57_2 then
			var_57_8 = var_57_2
		elseif var_57_1 < var_57_6 then
			var_57_8 = var_57_1
		end

		arg_57_0._cldObjDistanceList[iter_57_1.UID] = var_57_4 and var_57_7 and 0 or var_57_4 and math.abs(var_57_8 - var_57_6) or var_57_7 and math.abs(var_57_5 - var_57_3) or math.sqrt((var_57_5 - var_57_3)^2 + (var_57_8 - var_57_6)^2)
	end

	return
end

function var_0_1.GetDistance(arg_58_0, arg_58_1)
	return arg_58_0._cldObjDistanceList[arg_58_1]
end

function var_0_1.IsOutOfAngle(arg_59_0, arg_59_1)
	if not arg_59_0._sectorAngle or arg_59_0._sectorAngle >= 360 then
		return false
	else
		local var_59_0 = arg_59_1:GetPosition()
		local var_59_1 = math.atan2(var_59_0.z - arg_59_0._pos.z, var_59_0.x - arg_59_0._pos.x)

		var_59_1 = var_59_1 > arg_59_0._wholeCircle and var_59_1 + arg_59_0._wholeCircleNormalizeOffset or var_59_1 < arg_59_0._negativeCircle and var_59_1 + arg_59_0._negativeCircleNormalizeOffset or var_59_1 + arg_59_0._normalizeOffset

		if var_59_1 > arg_59_0._lowerEdge and var_59_1 < arg_59_0._upperEdge then
			return false
		else
			return true
		end
	end

	return
end

return
