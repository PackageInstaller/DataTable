local var_0_0 = g.core.const.ConstMgr.PubgConst
local Pubg2EntityObstacleTriangle = class("Pubg2EntityObstacleTriangle", require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityBase"))

function Pubg2EntityObstacleTriangle:ctor(arg_1_1, arg_1_2)
	Pubg2EntityObstacleTriangle.super.ctor(self, arg_1_1)

	self._type = var_0_0.entity.obstacle_triangle
	self._triangle = arg_1_2
	self._isObstacle = false
end

function Pubg2EntityObstacleTriangle:setObstacle(arg_2_1)
	self._isObstacle = arg_2_1
end

function Pubg2EntityObstacleTriangle:isObstacle()
	return self._isObstacle
end

function Pubg2EntityObstacleTriangle:getTriangle()
	return self._triangle
end

return Pubg2EntityObstacleTriangle
