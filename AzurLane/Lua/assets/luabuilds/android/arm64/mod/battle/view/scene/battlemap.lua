ys = ys or {}

local var_0_0 = class("BattleMap")

ys.Battle.BattleMap = var_0_0
var_0_0.__name = "BattleMap"
var_0_0.LAYERS = {
	"close",
	"mid",
	"long",
	"sky",
	"sea"
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = GameObject.New("scenes")
	arg_1_0.mapLayerCtrls = {}
	arg_1_0.seaAnimList = {}

	assert(pg.map_data[arg_1_1], "找不到地图: " .. arg_1_1)

	for iter_1_0, iter_1_1 in ipairs(var_0_0.LAYERS) do
		local var_1_0 = GameObject.New(iter_1_1 .. "Layer")

		setParent(var_1_0, arg_1_0._go, false)

		local var_1_2, var_1_3

		if iter_1_1 ~= "sky" then
			local var_1_1 = GetOrAddComponent(var_1_0, "MapLayerCtrl")

			var_1_1.leftBorder = pg.map_data[arg_1_1].range_left
			var_1_1.rightBorder = pg.map_data[arg_1_1].range_right
			var_1_1.speedToLeft = pg.map_data[arg_1_1][iter_1_1 .. "_speed"] or 0
			var_1_1.speedScaler = 1
			var_1_1.mainCamera = pg.UIMgr.GetInstance().mainCameraComp

			table.insert(arg_1_0.mapLayerCtrls, var_1_1)

			var_1_2 = string.split(pg.map_data[arg_1_1][iter_1_1 .. "_pos"], ";")
			var_1_3 = string.split(pg.map_data[arg_1_1][iter_1_1 .. "_scale"], ";")
		end

		for iter_1_2, iter_1_3 in ipairs((arg_1_0.GetMapResNames(arg_1_1, iter_1_1))) do
			local var_1_4 = var_0.Battle.BattleResourceManager.GetInstance():InstMap(iter_1_3)

			tf(var_1_4).localScale = string2vector3(var_1_3[iter_1_2])

			setParent(var_1_4, var_1_0, false)

			tf(var_1_4).localPosition = string2vector3(var_1_2[iter_1_2])

			local var_1_5 = var_1_4:GetComponent(typeof(SeaAnim))

			if var_1_5 then
				table.insert(arg_1_0.seaAnimList, var_1_5)
			end

			local var_1_6 = var_1_4:GetComponent(typeof(Renderer))

			if var_1_6 then
				var_1_6.sortingOrder = -1500
			end
		end

		if iter_1_1 == "sea" then
			arg_1_0._buffer = var_1_0.transform:Find("gelidai(Clone)")

			if arg_1_0._buffer then
				arg_1_0._bufferRenderer = arg_1_0._buffer:GetComponent("SpriteRenderer")
				arg_1_0._bufferRenderer.color = Color.New(1, 1, 1, 0)
				arg_1_0._bufferRenderer.sortingOrder = -1500
			end
		end
	end

	arg_1_0:UpdateSpeedScaler()

	return arg_1_0._go
end

function var_0_0.ShiftSurface(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
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

	arg_2_0._shiftTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", -1, arg_2_3, function()
		if (arg_2_2 - var_2_0) * var_2_1 > 0 then
			var_0.Battle.BattleVariable.AppendMapFactor("seaSurfaceShift", var_2_0)
			arg_2_0:updateSeaSpeed()
			arg_2_0:UpdateSpeedScaler()

			var_2_0 = var_2_0 + var_2_1
		else
			pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_2_0._shiftTimer)

			arg_2_0._shiftTimer = nil

			if arg_2_4 then
				arg_2_4()
			end
		end

		return
	end, true)

	return
end

function var_0_0.UpdateSpeedScaler(arg_4_0)
	arg_4_0:setSpeedScaler(var_0.Battle.BattleVariable.MapSpeedRatio)

	return
end

function var_0_0.UpdateBufferAlpha(arg_5_0, arg_5_1)
	arg_5_0._bufferRenderer.color = Color.New(1, 1, 1, arg_5_1 * 0.1)

	return
end

function var_0_0.SetExposeLine(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	function instantiateLine(arg_7_0, arg_7_1)
		local var_7_0 = var_0.Battle.BattleResourceManager.GetInstance():InstMap(arg_7_1)

		setParent(var_7_0, arg_6_0._go.transform:Find("seaLayer"), false)

		local var_7_1 = var_7_0:GetComponent("SpriteRenderer")

		var_7_1.sortingOrder = -1501

		local var_7_3 = tf(var_7_0).localScale

		tf(var_7_0).localScale = Vector3.New(arg_6_1 * var_7_3.x, var_7_3.y, var_7_3.z)

		local var_7_4 = tf(var_7_0).localPosition

		tf(var_7_0).localPosition = Vector3.New(arg_7_0 - var_7_1.bounds.extents.x * arg_6_1, var_7_4.y, var_7_4.z)
		var_7_1.enabled = true

		return
	end

	instantiateLine(arg_6_2, "visionLine")

	if arg_6_3 then
		instantiateLine(arg_6_3, "exposeLine")
	end

	return
end

function var_0_0.setSpeedScaler(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.mapLayerCtrls) do
		iter_8_1.speedScaler = arg_8_1
	end

	return
end

function var_0_0.updateSeaSpeed(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.seaAnimList) do
		iter_9_1:AdjustAnimSpeed(var_0.Battle.BattleVariable.MapSpeedRatio)
	end

	return
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0._shiftTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_10_0._shiftTimer)
	end

	if arg_10_0._go then
		Object.Destroy(arg_10_0._go)

		arg_10_0._go = nil
		arg_10_0._buffer = nil
		arg_10_0._bufferRenderer = nil
	end

	return
end

function var_0_0.GetMapResNames(arg_11_0, arg_11_1)
	return string.split(pg.map_data[arg_11_0][arg_11_1 .. "_shot"], ";")
end

function var_0_0.setActive(arg_12_0, arg_12_1)
	SetActive(arg_12_0._go, arg_12_1)

	return
end

return
