ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleConfig
local BattleEffectArea = class("BattleEffectArea")

ys.Battle.BattleEffectArea = BattleEffectArea
BattleEffectArea.__name = "BattleEffectArea"

local var_0_4 = Vector3(0, 3.5, -5)

function BattleEffectArea:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._go = arg_1_1
	self._aoeData = arg_1_2
	self._topCover = arg_1_3

	self:Init()

	return
end

function BattleEffectArea:Init()
	self._tf = self._go.transform
	self._areaType = self._aoeData:GetAreaType()

	if self._areaType == var_0_1.AreaType.CUBE or self._areaType == var_0_1.AreaType.ELLIPSE then
		self.UpdateScale = self.updateCubeScale
	elseif self._areaType == var_0_1.AreaType.COLUMN then
		self.UpdateScale = self.updateColumnScale
	end

	self.GetAngle = self._aoeData:GetIFF() == var_0_2.FOE_CODE and function()
		return self._aoeData:GetAngle() * -1 + 180
	end or function()
		return self._aoeData:GetAngle() * -1
	end

	self:Update()

	return
end

function BattleEffectArea:Update()
	self:UpdateScale()
	self:UpdatePosition()
	self:UpdateRotation()

	return
end

function BattleEffectArea:updateCubeScale()
	local var_6_0 = 1
	local var_6_1 = 1

	if not self._aoeData:GetFXStatic() then
		var_6_0 = self._aoeData:GetWidth() * self._aoeData:GetIFF()
		var_6_1 = self._aoeData:GetHeight()
	end

	if var_6_0 == self._preWidth and var_6_1 == self._preHeight then
		return
	end

	self._tf.localScale = Vector3(var_6_0, 1, var_6_1)
	self._preWidth = var_6_0
	self._preHeight = var_6_1

	return
end

function BattleEffectArea:updateColumnScale()
	local var_7_0 = self._aoeData:GetRange()

	if var_7_0 == self._preRange then
		return
	end

	self._tf.localScale = Vector3(var_7_0, 1, var_7_0)
	self._preRange = var_7_0

	return
end

function BattleEffectArea:UpdatePosition()
	self._tf.position = self._topCover and self._aoeData:GetPosition() + var_0_4 or self._aoeData:GetPosition()

	return
end

function BattleEffectArea:UpdateRotation()
	local var_9_0 = self:GetAngle()

	if self._preAngle == var_9_0 then
		return
	end

	self._tf.localEulerAngles = Vector3(0, var_9_0, 0)
	self._preAngle = var_9_0

	return
end

function BattleEffectArea:Dispose()
	var_0_0.Battle.BattleResourceManager.GetInstance():DestroyOb(self._go)

	self._go = nil

	return
end

return
