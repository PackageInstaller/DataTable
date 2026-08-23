local var_0_0 = g.core.const.ConstMgr.PubgConst
local Pubg2EntityObstaclePoint = class("Pubg2EntityObstaclePoint", require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityBase"))

function Pubg2EntityObstaclePoint:ctor(arg_1_1, arg_1_2)
	Pubg2EntityObstaclePoint.super.ctor(self, arg_1_1)

	self._type = var_0_0.entity.obstacle_point
	self._point = arg_1_2
end

function Pubg2EntityObstaclePoint:getPoint()
	return self._point
end

return Pubg2EntityObstaclePoint
