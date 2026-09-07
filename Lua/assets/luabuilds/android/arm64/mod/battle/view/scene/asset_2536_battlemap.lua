ys = ys or {}

local var_0_0 = ys
local BattleMap = class("BattleMap")

ys.Battle.BattleMap = BattleMap
BattleMap.__name = "BattleMap"
BattleMap.LAYERS = {
	"close",
	"mid",
	"long",
	"sky",
	"sea"
}

function BattleMap:Ctor(arg_1_1)
	self._go = GameObject.New("scenes")
	self.mapLayerCtrls = {}
	self.seaAnimList = {}

	assert(pg.map_data[arg_1_1], "找不到地图: " .. arg_1_1)

	for iter_1_0, iter_1_1 in ipairs(BattleMap.LAYERS) do
		local var_1_0 = GameObject.New(iter_1_1 .. "Layer")

		setParent(var_1_0, self._go, false)

		local var_1_3
		local var_1_2

		if iter_1_1 ~= "sky" then
			local var_1_1 = GetOrAddComponent(var_1_0, "MapLayerCtrl")

			var_1_1.leftBorder = pg.map_data[arg_1_1].range_left
			var_1_1.rightBorder = pg.map_data[arg_1_1].range_right
			var_1_1.speedToLeft = pg.map_data[arg_1_1][iter_1_1 .. "_speed"] or 0
			var_1_1.speedScaler = 1
			var_1_1.mainCamera = pg.UIMgr.GetInstance().mainCameraComp

			table.insert(self.mapLayerCtrls, var_1_1)

			var_1_2 = string.split(pg.map_data[arg_1_1][iter_1_1 .. "_pos"], ";")
			var_1_3 = string.split(pg.map_data[arg_1_1][iter_1_1 .. "_scale"], ";")
		end

		for iter_1_2, iter_1_3 in ipairs((self.GetMapResNames(arg_1_1, iter_1_1))) do
			local var_1_4 = var_0_0.Battle.BattleResourceManager.GetInstance():InstMap(iter_1_3)

			tf(var_1_4).localScale = string2vector3(var_1_3[iter_1_2])

			setParent(var_1_4, var_1_0, false)

			tf(var_1_4).localPosition = string2vector3(var_1_2[iter_1_2])

			local var_1_5 = var_1_4:GetComponent(typeof(SeaAnim))

			if var_1_5 then
				table.insert(self.seaAnimList, var_1_5)
			end

			local var_1_6 = var_1_4:GetComponent(typeof(Renderer))

			if var_1_6 then
				var_1_6.sortingOrder = -1500
			end
		end

		if iter_1_1 == "sea" then
			self._buffer = var_1_0.transform:Find("gelidai(Clone)")

			if self._buffer then
				self._bufferRenderer = self._buffer:GetComponent("SpriteRenderer")
				self._bufferRenderer.color = Color.New(1, 1, 1, 0)
				self._bufferRenderer.sortingOrder = -1500
			end
		end
	end

	self:UpdateSpeedScaler()

	return self._go
end

function BattleMap:ShiftSurface(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if self._shiftTimer then
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

	self._shiftTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", -1, arg_2_3, function()
		if (arg_2_2 - var_2_0) * var_2_1 > 0 then
			var_0_0.Battle.BattleVariable.AppendMapFactor("seaSurfaceShift", var_2_0)
			self:updateSeaSpeed()
			self:UpdateSpeedScaler()

			var_2_0 = var_2_0 + var_2_1
		else
			pg.TimeMgr.GetInstance():RemoveBattleTimer(self._shiftTimer)

			self._shiftTimer = nil

			if arg_2_4 then
				arg_2_4()
			end
		end

		return
	end, true)

	return
end

function BattleMap:UpdateSpeedScaler()
	self:setSpeedScaler(var_0_0.Battle.BattleVariable.MapSpeedRatio)

	return
end

function BattleMap:UpdateBufferAlpha(arg_5_1)
	self._bufferRenderer.color = Color.New(1, 1, 1, arg_5_1 * 0.1)

	return
end

function BattleMap:SetExposeLine(arg_6_1, arg_6_2, arg_6_3)
	function instantiateLine(arg_7_0, arg_7_1)
		local var_7_0 = var_0_0.Battle.BattleResourceManager.GetInstance():InstMap(arg_7_1)

		setParent(var_7_0, self._go.transform:Find("seaLayer"), false)

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

function BattleMap:setSpeedScaler(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self.mapLayerCtrls) do
		iter_8_1.speedScaler = arg_8_1
	end

	return
end

function BattleMap:updateSeaSpeed()
	for iter_9_0, iter_9_1 in ipairs(self.seaAnimList) do
		iter_9_1:AdjustAnimSpeed(var_0_0.Battle.BattleVariable.MapSpeedRatio)
	end

	return
end

function BattleMap:Dispose()
	if self._shiftTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._shiftTimer)
	end

	if self._go then
		Object.Destroy(self._go)

		self._go = nil
		self._buffer = nil
		self._bufferRenderer = nil
	end

	return
end

function BattleMap:GetMapResNames(arg_11_1)
	return string.split(pg.map_data[self][arg_11_1 .. "_shot"], ";")
end

function BattleMap:setActive(arg_12_1)
	SetActive(self._go, arg_12_1)

	return
end

return
