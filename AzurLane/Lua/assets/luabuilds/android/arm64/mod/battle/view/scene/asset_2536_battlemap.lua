ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleMap")

var_0.Battle.BattleMap = var_0_1
var_0_1.__name = "BattleMap"
pg = var_2

local var_0_2 = var_2.map_data

var_0_1.LAYERS = {
	"close",
	"mid",
	"long",
	"sky",
	"sea"
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	GameObject = var_1_10002
	arg_1_0._go = var_1_10002.New("scenes")
	arg_1_0.mapLayerCtrls = {}
	arg_1_0.seaAnimList = {}
	pg = var_2

	local var_1_0 = var_2.map_data[arg_1_1]

	assert = var_1_10003

	var_1_10003(var_1_0, "找不到地图: " .. arg_1_1)

	ipairs = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10003(var_0_1.LAYERS) do
		GameObject = var_1_10008
		var_1_10008 = var_1_10008.New(iter_1_1 .. "Layer")
		setParent = var_1_10009

		var_1_10009(var_1_10008, arg_1_0._go, false)

		local var_1_1

		if iter_1_1 ~= "sky" then
			GetOrAddComponent = var_1_10009
			var_1_10009 = var_1_10009(var_1_10008, "MapLayerCtrl")
			var_1_10009.leftBorder = var_1_0.range_left
			var_1_10009.rightBorder = var_1_0.range_right

			if not var_1_0[iter_1_1 .. "_speed"] then
				var_1_1 = 0
			end

			var_1_10009.speedToLeft = var_1_1
			var_1_10009.speedScaler = 1
			pg = var_1_1
			var_1_10009.mainCamera = var_1_1.UIMgr.GetInstance().mainCameraComp
			table = var_1_1

			var_1_1.insert(arg_1_0.mapLayerCtrls, var_1_10009)
		end

		var_1_10009 = arg_1_0.GetMapResNames(arg_1_1, iter_1_1)
		string = var_1_1

		local var_1_2 = var_1_1.split(var_1_0[iter_1_1 .. "_pos"], ";")

		string = var_11

		local var_1_3 = var_11.split(var_1_0[iter_1_1 .. "_scale"], ";")

		ipairs = var_12

		for iter_1_2, iter_1_3 in var_12(var_1_10009) do
			local var_1_4 = var_0.Battle.BattleResourceManager.GetInstance()
			local var_1_5 = var_17.InstMap(var_1_4, iter_1_3)

			tf = var_1_10018
			var_1_10018 = var_1_10018(var_1_5)
			string2vector3 = var_1_4
			var_1_10018.localScale = var_1_4(var_1_3[iter_1_2])
			setParent = var_1_10018

			var_1_10018(var_1_5, var_1_10008, false)

			tf = var_1_10018
			var_1_10018 = var_1_10018(var_1_5)
			string2vector3 = var_19
			var_1_10018.localPosition = var_19(var_1_2[iter_1_2])

			local var_1_6 = var_1_5

			var_1_10018 = var_1_5.GetComponent
			typeof = var_21
			SeaAnim = var_1_10023

			if var_1_10018(var_1_6, var_21(var_1_10023)) then
				table = var_19

				var_19.insert(arg_1_0.seaAnimList, var_1_10018)
			end

			local var_1_7 = var_1_5
			local var_1_8 = var_1_5.GetComponent

			typeof = var_22
			Renderer = var_1_10024

			if var_1_8(var_1_7, var_22(var_1_10024)) then
				var_19.sortingOrder = -1500
			end
		end

		if iter_1_1 == "sea" then
			local var_1_9 = var_1_10008.transform

			arg_1_0._buffer = var_12.Find(var_1_9, "gelidai(Clone)")

			if arg_1_0._buffer then
				local var_1_10 = arg_1_0._buffer

				arg_1_0._bufferRenderer = var_12.GetComponent(var_1_10, "SpriteRenderer")

				local var_1_11 = arg_1_0._bufferRenderer

				Color = var_13
				var_1_11.color = var_13.New(1, 1, 1, 0)
				arg_1_0._bufferRenderer.sortingOrder = -1500
			end
		end
	end

	arg_1_0:UpdateSpeedScaler()

	return arg_1_0._go
end

function var_0_1.ShiftSurface(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_0._shiftTimer then
		return
	end

	local var_2_0 = arg_2_1
	local var_2_1

	if arg_2_2 < arg_2_1 then
		var_2_1 = -1
	elseif arg_2_1 < arg_2_2 then
		var_2_1 = 1
	else
		return
	end

	local function var_2_2()
		if (arg_2_2 - var_2_0) * var_2_1 > 0 then
			var_0.Battle.BattleVariable.AppendMapFactor("seaSurfaceShift", var_2_0)

			local var_3_0 = arg_2_0

			var_0.updateSeaSpeed(var_3_0)

			local var_3_1 = arg_2_0

			var_0.UpdateSpeedScaler(var_3_1)

			var_2_0 = var_2_0 + var_2_1
		else
			pg = var_0

			local var_3_2 = var_0.TimeMgr.GetInstance()

			var_0.RemoveBattleTimer(var_3_2, arg_2_0._shiftTimer)

			arg_2_0._shiftTimer = nil

			if arg_2_4 then
				arg_2_4()
			end
		end

		return
	end

	pg = var_1_10008

	local var_2_3 = var_1_10008.TimeMgr.GetInstance()

	arg_2_0._shiftTimer = var_8.AddBattleTimer(var_2_3, "", -1, arg_2_3, var_2_2, true)

	return
end

function var_0_1.UpdateSpeedScaler(arg_4_0)
	arg_4_0:setSpeedScaler(var_0.Battle.BattleVariable.MapSpeedRatio)

	return
end

function var_0_1.UpdateBufferAlpha(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 * 0.1
	local var_5_1 = arg_5_0._bufferRenderer

	Color = var_1_10004
	var_5_1.color = var_1_10004.New(1, 1, 1, var_5_0)

	return
end

function var_0_1.SetExposeLine(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local function var_6_0(arg_7_0, arg_7_1)
		local var_7_0 = var_0.Battle.BattleResourceManager.GetInstance()
		local var_7_1 = var_2.InstMap(var_7_0, arg_7_1)
		local var_7_2 = arg_6_0._go.transform
		local var_7_3 = var_3.Find(var_7_2, "seaLayer")

		setParent = var_7_0

		var_7_0(var_7_1, var_7_3, false)

		local var_7_4 = var_7_1:GetComponent("SpriteRenderer").bounds.extents.max

		var_4.sortingOrder = -1501
		tf = var_6

		local var_7_5 = var_6(var_7_1).localScale

		tf = var_7

		local var_7_6 = var_7(var_7_1)

		Vector3 = var_8
		var_7_6.localScale = var_8.New(arg_6_1 * var_7_5.x, var_7_5.y, var_7_5.z)
		tf = var_7_6

		local var_7_7 = var_7_6(var_7_1).localPosition
		local var_7_8 = var_4.bounds.extents.x * arg_6_1

		tf = var_9

		local var_7_9 = var_9(var_7_1)

		Vector3 = var_10
		var_7_9.localPosition = var_10.New(arg_7_0 - var_7_8, var_7_7.y, var_7_7.z)
		var_4.enabled = true

		return
	end

	instantiateLine = instantiateLine

	var_4(arg_6_2, "visionLine")

	if arg_6_3 then
		instantiateLine = var_4

		var_4(arg_6_3, "exposeLine")
	end

	return
end

function var_0_1.setSpeedScaler(arg_8_0, arg_8_1)
	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.mapLayerCtrls) do
		iter_8_1.speedScaler = arg_8_1
	end

	return
end

function var_0_1.updateSeaSpeed(arg_9_0)
	local var_9_0 = var_0.Battle.BattleVariable.MapSpeedRatio

	ipairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.seaAnimList) do
		iter_9_1:AdjustAnimSpeed(var_9_0)
	end

	return
end

function var_0_1.Dispose(arg_10_0)
	if arg_10_0._shiftTimer then
		pg = var_1

		local var_10_0 = var_1.TimeMgr.GetInstance()

		var_1.RemoveBattleTimer(var_10_0, arg_10_0._shiftTimer)
	end

	if arg_10_0._go then
		Object = var_1

		var_1.Destroy(arg_10_0._go)

		arg_10_0._go = nil
		arg_10_0._buffer = nil
		arg_10_0._bufferRenderer = nil
	end

	return
end

function var_0_1.GetMapResNames(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.map_data[arg_11_0]

	string = var_1_10003

	return var_1_10003.split(var_11_0[arg_11_1 .. "_shot"], ";")
end

function var_0_1.setActive(arg_12_0, arg_12_1)
	SetActive = var_1_10002

	var_1_10002(arg_12_0._go, arg_12_1)

	return
end

return
