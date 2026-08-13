ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst

class = var_0_10002

local var_0_2 = var_0_10002("BattleAOEData")

var_0.Battle.BattleAOEData = var_0_2
var_0_2.__name = "BattleAOEData"
var_0_2.ALIGNMENT_LEFT = "left"
var_0_2.ALIGNMENT_RIGHT = "right"
var_0_2.ALIGNMENT_MIDDLE = "middle"
var_0_2.SOURCE_BULLET_9 = "bulletType9"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._areaUniqueID = arg_1_1
	arg_1_0._areaCldFunc = arg_1_3
	arg_1_0._endFunc = arg_1_4
	arg_1_0._IFF = arg_1_2
	arg_1_0._cldObjList = {}
	arg_1_0._cldObjDistanceList = {}

	arg_1_0:SetTickness(10)

	Vector3 = var_5
	arg_1_0._alignment = var_5.zero
	arg_1_0._angle = 0
	arg_1_0._component = {}
	arg_1_0._timeExemptKey = "aoe_" .. arg_1_0._areaUniqueID

	return
end

function var_0_2.StartTimer(arg_2_0)
	if arg_2_0._lifeTime == -1 then
		arg_2_0._flag = false

		return
	end

	arg_2_0._flag = true

	if arg_2_0._lifeTime > 0 then
		pg = var_1

		local var_2_0 = var_1.TimeMgr.GetInstance()

		arg_2_0._lifeTimer = var_1.AddBattleTimer(var_2_0, "areaTimer", 0, arg_2_0._lifeTime, function()
			local var_3_0 = arg_2_0

			var_0.RemoveTimer(var_3_0)

			return
		end, true)
	end

	return
end

function var_0_2.GetTimeRationExemptKey(arg_4_0)
	return arg_4_0._timeExemptKey
end

function var_0_2.RemoveTimer(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_5_0, arg_5_0._lifeTimer)

	arg_5_0._lifeTimer = nil
	arg_5_0._flag = false

	return
end

function var_0_2.ClearCLDList(arg_6_0)
	arg_6_0._cldObjList = {}

	return
end

function var_0_2.AppendCldObj(arg_7_0, arg_7_1)
	arg_7_0._cldObjList[#arg_7_0._cldObjList + 1] = arg_7_1

	return
end

function var_0_2.Settle(arg_8_0)
	arg_8_0.SortCldObjList(arg_8_0._cldObjList)

	local var_8_0 = arg_8_0._cldComponent

	var_1.GetCldData(var_8_0).func(arg_8_0._cldObjList)

	return
end

function var_0_2.SettleFinale(arg_9_0)
	if arg_9_0._endFunc then
		arg_9_0.SortCldObjList(arg_9_0._cldObjList)
		arg_9_0._endFunc(arg_9_0._cldObjList)
	end

	return
end

function var_0_2.ForceExit(arg_10_0)
	return
end

function var_0_2.SortCldObjList(arg_11_0)
	table = var_1_10001

	var_1_10001.sort(arg_11_0, var_0_2._Fun_SortCldObjList)

	return
end

function var_0_2._Fun_SortCldObjList(arg_12_0, arg_12_1)
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

function var_0_2.SetOpponentAffected(arg_13_0, arg_13_1)
	arg_13_0._opponentAffected = arg_13_1

	return
end

function var_0_2.OpponentAffected(arg_14_0)
	return arg_14_0._opponentAffected
end

function var_0_2.SetIndiscriminate(arg_15_0, arg_15_1)
	arg_15_0._indicriminate = arg_15_1

	return
end

function var_0_2.GetIndiscriminate(arg_16_0)
	return arg_16_0._indicriminate
end

function var_0_2.GetActiveFlag(arg_17_0)
	return arg_17_0._flag
end

function var_0_2.SetActiveFlag(arg_18_0, arg_18_1)
	arg_18_0._flag = arg_18_1

	return
end

function var_0_2.Dispose(arg_19_0)
	ipairs = var_1_10001

	for iter_19_0, iter_19_1 in var_1_10001(arg_19_0._component) do
		iter_19_1:Dispose()
	end

	arg_19_0._component = nil

	arg_19_0:RemoveTimer()

	arg_19_0._cldObjList = nil

	return
end

function var_0_2.GetUniqueID(arg_20_0)
	return arg_20_0._areaUniqueID
end

function var_0_2.GetIFF(arg_21_0)
	return arg_21_0._IFF
end

function var_0_2.GetAreaType(arg_22_0)
	return arg_22_0._areaType
end

function var_0_2.GetPosition(arg_23_0)
	return arg_23_0._pos
end

function var_0_2.GetTickness(arg_24_0)
	return arg_24_0._tickness
end

function var_0_2.GetLifeTime(arg_25_0)
	return arg_25_0._lifeTime
end

function var_0_2.GetFieldType(arg_26_0)
	return arg_26_0._fieldType
end

function var_0_2.GetDiveFilter(arg_27_0)
	return arg_27_0._diveFilter
end

function var_0_2.GetCldFunc(arg_28_0)
	return arg_28_0._areaCldFunc
end

function var_0_2.GetSource(arg_29_0)
	return arg_29_0._source
end

function var_0_2.GetHeight(arg_30_0)
	return arg_30_0._height
end

function var_0_2.GetWidth(arg_31_0)
	return arg_31_0._width
end

function var_0_2.GetAngle(arg_32_0)
	return arg_32_0._angle
end

function var_0_2.GetRange(arg_33_0)
	return arg_33_0._range
end

function var_0_2.GetSectorAngle(arg_34_0)
	return arg_34_0._sectorAngle
end

function var_0_2.SetAreaType(arg_35_0, arg_35_1)
	arg_35_0._areaType = arg_35_1

	arg_35_0:InitCldComponent()

	return
end

function var_0_2.SetDiveFilter(arg_36_0, arg_36_1)
	arg_36_0._diveFilter = arg_36_1

	return
end

function var_0_2.SetPosition(arg_37_0, arg_37_1)
	arg_37_0._pos = arg_37_1

	return
end

function var_0_2.SetTickness(arg_38_0, arg_38_1)
	arg_38_0._tickness = arg_38_1

	return
end

function var_0_2.SetFieldType(arg_39_0, arg_39_1)
	arg_39_0._fieldType = arg_39_1

	return
end

function var_0_2.SetLifeTime(arg_40_0, arg_40_1)
	arg_40_0._lifeTime = arg_40_1

	return
end

function var_0_2.SetSource(arg_41_0, arg_41_1)
	arg_41_0._source = arg_41_1

	return
end

function var_0_2.SetHeight(arg_42_0, arg_42_1)
	arg_42_0._height = arg_42_1

	return
end

function var_0_2.SetWidth(arg_43_0, arg_43_1)
	arg_43_0._width = arg_43_1

	return
end

function var_0_2.SetAngle(arg_44_0, arg_44_1)
	arg_44_0._angle = arg_44_1

	return
end

function var_0_2.SetRange(arg_45_0, arg_45_1)
	arg_45_0._range = arg_45_1

	return
end

function var_0_2.SetSectorAngle(arg_46_0, arg_46_1, arg_46_2)
	arg_46_0._sectorAngle = arg_46_1
	arg_46_0._sectorDir = arg_46_2

	local var_46_0 = arg_46_0._sectorAngle / 2

	math = var_1_10004
	arg_46_0._upperEdge = var_1_10004.deg2Rad * var_46_0
	arg_46_0._lowerEdge = -1 * arg_46_0._upperEdge

	local var_46_1 = 0

	if arg_46_2 == var_0_1.UnitDir.LEFT then
		math = var_5
		arg_46_0._normalizeOffset = var_5.pi - var_46_1
	elseif arg_46_2 == var_0_1.UnitDir.RIGHT then
		arg_46_0._normalizeOffset = var_46_1
	end

	math = var_5
	arg_46_0._wholeCircle = var_5.pi - arg_46_0._normalizeOffset
	math = var_5
	arg_46_0._negativeCircle = -var_5.pi - arg_46_0._normalizeOffset

	local var_46_2 = arg_46_0._normalizeOffset

	math = var_6
	arg_46_0._wholeCircleNormalizeOffset = var_46_2 - var_6.pi * 2

	local var_46_3 = arg_46_0._normalizeOffset

	math = var_6
	arg_46_0._negativeCircleNormalizeOffset = var_46_3 + var_6.pi * 2

	return
end

function var_0_2.SetAnchorPointAlignment(arg_47_0, arg_47_1)
	if arg_47_1 == var_0_2.ALIGNMENT_LEFT then
		Vector3 = var_2
		arg_47_0._alignment = var_2(arg_47_0._width * 0.5, 0, 0)
	elseif arg_47_1 == var_0_2.ALIGNMENT_RIGHT then
		Vector3 = var_2
		arg_47_0._alignment = var_2(arg_47_0._width * -0.5, 0, 0)
	end

	return
end

function var_0_2.GetAnchorPointAlignment(arg_48_0)
	return arg_48_0._alignment
end

function var_0_2.GetFXStatic(arg_49_0)
	return arg_49_0._fxStatic
end

function var_0_2.SetFXStatic(arg_50_0, arg_50_1)
	arg_50_0._fxStatic = arg_50_1

	return
end

function var_0_2.AppendComponent(arg_51_0, arg_51_1)
	table = var_1_10002

	var_1_10002.insert(arg_51_0._component, arg_51_1)

	return
end

function var_0_2.InitCldComponent(arg_52_0)
	if arg_52_0._areaType == var_0_1.AreaType.CUBE or arg_52_0._areaType == var_0_1.AreaType.ELLIPSE then
		arg_52_0._cldComponent = var_0.Battle.BattleCubeCldComponent.New(arg_52_0._width, arg_52_0._tickness, arg_52_0._height, 0, 0)
	elseif arg_52_0._areaType == var_0_1.AreaType.COLUMN then
		arg_52_0._cldComponent = var_0.Battle.BattleColumnCldComponent.New(arg_52_0._range, arg_52_0._tickness)
	end

	local var_52_0 = {
		type = var_0_1.CldType.AOE,
		UID = arg_52_0:GetUniqueID(),
		IFF = arg_52_0:GetIFF(),
		func = arg_52_0:GetCldFunc()
	}
	local var_52_1 = arg_52_0._cldComponent

	var_2.SetCldData(var_52_1, var_52_0)

	local var_52_2 = arg_52_0._cldComponent

	var_2.SetActive(var_52_2, true)

	return
end

function var_0_2.GetCldComponent(arg_53_0)
	return arg_53_0._cldComponent
end

function var_0_2.DeactiveCldBox(arg_54_0)
	local var_54_0 = arg_54_0._cldComponent

	var_1.SetActive(var_54_0, false)

	return
end

function var_0_2.GetCldBox(arg_55_0)
	local var_55_0 = arg_55_0._cldComponent

	return var_1.GetCldBox(var_55_0, arg_55_0:GetPosition() + arg_55_0._alignment)
end

function var_0_2.GetCldData(arg_56_0)
	local var_56_0 = arg_56_0._cldComponent

	return var_1.GetCldData(var_56_0)
end

function var_0_2.UpdateDistanceInfo(arg_57_0)
	ipairs = var_1_10001

	for iter_57_0, iter_57_1 in var_1_10001(arg_57_0._cldObjList) do
		local var_57_0
		local var_57_1 = iter_57_1.LeftBound
		local var_57_2 = iter_57_1.RightBound
		local var_57_3 = iter_57_1.UpperBound
		local var_57_4 = iter_57_1.LowerBound
		local var_57_5 = arg_57_0._pos.x
		local var_57_6
		local var_57_7

		if var_57_1 <= var_57_5 and var_57_5 <= var_57_2 then
			var_57_6 = true
		elseif var_57_5 < var_57_1 then
			var_57_7 = var_57_1
		elseif var_57_2 < var_57_5 then
			var_57_7 = var_57_2
		end

		local var_57_8 = arg_57_0._pos.z
		local var_57_9
		local var_57_10

		if var_57_4 <= var_57_8 and var_57_8 <= var_57_3 then
			var_57_9 = true
		elseif var_57_8 < var_57_4 then
			var_57_10 = var_57_4
		elseif var_57_3 < var_57_8 then
			var_57_10 = var_57_3
		end

		if var_57_6 and var_57_9 then
			var_57_0 = 0
		elseif var_57_6 then
			math = var_1_10017
			var_57_0 = var_1_10017.abs(var_57_10 - var_57_8)
		elseif var_57_9 then
			math = var_1_10017
			var_57_0 = var_1_10017.abs(var_57_7 - var_57_5)
		else
			math = var_1_10017
			var_57_0 = var_1_10017.sqrt((var_57_7 - var_57_5)^2 + (var_57_10 - var_57_8)^2)
		end

		var_1_10017 = arg_57_0._cldObjDistanceList
		var_1_10017[iter_57_1.UID] = var_57_0
	end

	return
end

function var_0_2.GetDistance(arg_58_0, arg_58_1)
	return arg_58_0._cldObjDistanceList[arg_58_1]
end

function var_0_2.IsOutOfAngle(arg_59_0, arg_59_1)
	if arg_59_0._sectorAngle then
		local var_59_0 = arg_59_0._sectorAngle

		if 360 <= var_59_0 then
			return false
		else
			local var_59_1 = arg_59_1:GetPosition()

			math = var_1_10003

			local var_59_2

			if var_1_10003.atan2(var_59_1.z - arg_59_0._pos.z, var_59_1.x - arg_59_0._pos.x) > arg_59_0._wholeCircle then
				var_59_2 = var_59_2 + arg_59_0._wholeCircleNormalizeOffset
			elseif var_59_2 < arg_59_0._negativeCircle then
				var_59_2 = var_59_2 + arg_59_0._negativeCircleNormalizeOffset
			else
				var_59_2 = var_59_2 + arg_59_0._normalizeOffset
			end

			if var_59_2 > arg_59_0._lowerEdge and var_59_2 < arg_59_0._upperEdge then
				return false
			else
				return true
			end
		end

		return
	end
end

return
