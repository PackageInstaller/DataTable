ys = ys or {}
ys.Battle.BattleCameraSlider = class("BattleCameraSlider")

local BattleCameraSlider = class("BattleCameraSlider")

ys.Battle.BattleCameraSlider = BattleCameraSlider
BattleCameraSlider.__name = "BattleCameraSlider"

function BattleCameraSlider:Ctor(arg_1_1)
	self._go = arg_1_1

	self:Init()

	return
end

function BattleCameraSlider:Init()
	SetActive(self._go, true)

	self._distX, self._distY = 0, 0
	self._dirX, self._dirY = 0, 0
	self._isPress = false

	local var_2_0 = pg.CameraFixMgr.GetInstance()

	self._screenWidth, self._screenHeight = var_2_0.actualWidth, var_2_0.actualHeight

	self._go:GetComponent("StickController"):SetStickFunc(function(arg_3_0, arg_3_1)
		self:updateStick(arg_3_0, arg_3_1)

		return
	end)

	return
end

function BattleCameraSlider:updateStick(arg_4_1, arg_4_2)
	self._initX = false
	self._initY = false

	if arg_4_2 == -1 then
		self._startX = nil
		self._startY = nil
		self._isPress = false
	else
		self._isPress = true

		local var_4_0 = arg_4_1.x
		local var_4_1 = arg_4_1.y

		if self._startX == nil then
			self._startX = var_4_0
			self._startY = var_4_1
			self._initX = true
			self._initY = true
		else
			local var_4_2 = var_4_0 - self._lastPosX

			if (var_4_0 - self._lastPosX) * self._dirX < 0 then
				self._startX = var_4_0
				self._initX = true
			end

			if var_4_2 ~= 0 then
				self._dirX = var_4_2
			end

			local var_4_3 = var_4_1 - self._lastPosY

			if (var_4_1 - self._lastPosY) * self._dirY < 0 then
				self._startY = var_4_1
				self._initY = true
			end

			if var_4_3 ~= 0 then
				self._dirY = var_4_3
			end
		end

		self._distX = (var_4_0 - self._startX) / self._screenWidth
		self._distY = (var_4_1 - self._startY) / self._screenHeight
	end

	self._lastPosX = arg_4_1.x
	self._lastPosY = arg_4_1.y

	return
end

function BattleCameraSlider:GetDistance()
	return self._distX, self._distY
end

function BattleCameraSlider:IsFirstPress()
	return self._initX, self._initY
end

function BattleCameraSlider:IsPress()
	return self._isPress
end

return
