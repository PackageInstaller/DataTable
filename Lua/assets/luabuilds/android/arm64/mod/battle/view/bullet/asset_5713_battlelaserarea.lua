ys = ys or {}

local BattleLaserArea = class("BattleLaserArea", ys.Battle.BattleBullet)

ys.Battle.BattleLaserArea = BattleLaserArea
BattleLaserArea.__name = "BattleLaserArea"

function BattleLaserArea:Update(arg_1_1)
	local var_1_0 = self._bulletData:GetSpeed()

	if var_1_0.x ~= 0 or var_1_0.z ~= 0 or var_1_0.y ~= 0 then
		self:UpdatePosition()
	end

	return
end

return
