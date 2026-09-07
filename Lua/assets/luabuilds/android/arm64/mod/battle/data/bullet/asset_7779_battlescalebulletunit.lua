ys = ys or {}
ys.Battle.BattleScaleBulletUnit = class("BattleScaleBulletUnit", ys.Battle.BattleBulletUnit)
ys.Battle.BattleScaleBulletUnit.__name = "BattleScaleBulletUnit"

local var_0_5 = ys.Battle.BattleScaleBulletUnit

function ys.Battle.BattleScaleBulletUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_5.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._scaleX = 0

	return
end

function ys.Battle.BattleScaleBulletUnit:Update(arg_2_1)
	if self._scaleX + self._tempData.cld_box[1] > self._scaleLimit then
		self:calcSpeed()
	else
		self:UpdateCLDBox()
	end

	var_0_5.super.Update(self, arg_2_1)

	return
end

function ys.Battle.BattleScaleBulletUnit:SetTemplateData(arg_3_1)
	var_0_5.super.SetTemplateData(self, arg_3_1)

	self._scaleSpeed = self._tempData.extra_param.scaleSpeed
	self._scaleLimit = self._tempData.extra_param.cldMax

	return
end

function ys.Battle.BattleScaleBulletUnit:InitSpeed(arg_4_1)
	var_0_5.super.InitSpeed(self, arg_4_1)
	self:calcScaleSpeed()

	return
end

function ys.Battle.BattleScaleBulletUnit:calcScaleSpeed()
	self._speed = Vector3(self._scaleSpeed * 0.5 * math.cos(math.deg2Rad * self._yAngle), 0, self._scaleSpeed * 0.5 * math.sin(math.deg2Rad * self._yAngle))

	return
end

function ys.Battle.BattleScaleBulletUnit:UpdateCLDBox()
	self._scaleX = self._scaleX + self._scaleSpeed

	self._cldComponent:ResetSize(self._tempData.cld_box[1] + self._scaleX, self._tempData.cld_box[2], self._tempData.cld_box[3])

	return
end

function ys.Battle.BattleScaleBulletUnit:GetRadian()
	local var_7_0 = self._radCache or self:GetYAngle() * math.deg2Rad

	return var_7_0, self._cosCache or math.cos(var_7_0), self._sinCache or math.sin(var_7_0)
end

return
