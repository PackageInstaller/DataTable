ys = ys or {}

local var_0_3 = class("BattleLaserArea", ys.Battle.BattleBullet)

ys.Battle.BattleLaserArea = var_0_3
var_0_3.__name = "BattleLaserArea"

function var_0_3.Update(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._bulletData:GetSpeed()

	if var_1_0.x ~= 0 or var_1_0.z ~= 0 or var_1_0.y ~= 0 then
		arg_1_0:UpdatePosition()
	end

	return
end

return
