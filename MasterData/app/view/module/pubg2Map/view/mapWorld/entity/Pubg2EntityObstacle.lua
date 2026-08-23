local var_0_0 = g.core.const.ConstMgr.PubgConst
local Pubg2EntityObstacle = class("Pubg2EntityObstacle", require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityBase"))

function Pubg2EntityObstacle:ctor(arg_1_1, arg_1_2)
	Pubg2EntityObstacle.super.ctor(self, arg_1_1)

	self._type = var_0_0.entity.obstacle
	self._resId = arg_1_2

	self:setStatic(true)
end

function Pubg2EntityObstacle:getResId()
	return self._resId
end

return Pubg2EntityObstacle
