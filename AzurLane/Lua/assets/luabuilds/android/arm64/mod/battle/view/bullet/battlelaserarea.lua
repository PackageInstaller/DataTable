ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleBulletEvent
local var_0_2 = var_0.Battle.BattleResourceManager
local var_0_3 = var_0.Battle.BattleConfig

class = var_0_10004

local var_0_4 = var_0_10004("BattleLaserArea", var_0.Battle.BattleBullet)

var_0.Battle.BattleLaserArea = var_0_4
var_0_4.__name = "BattleLaserArea"

function var_0_4.Update(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._bulletData

	if var_2.GetSpeed(var_1_0).x ~= 0 or var_2.z ~= 0 or var_2.y ~= 0 then
		arg_1_0:UpdatePosition()
	end

	return
end

return
