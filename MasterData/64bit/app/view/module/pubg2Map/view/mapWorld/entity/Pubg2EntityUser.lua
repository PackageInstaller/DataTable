local var_0_0 = g.core.const.ConstMgr.PubgConst
local Pubg2EntityUser = class("Pubg2EntityUser", require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityBase"))

function Pubg2EntityUser:ctor(arg_1_1)
	Pubg2EntityUser.super.ctor(self, arg_1_1)

	self._type = var_0_0.entity.user
	self._visualRadius = 350
	self._visualRadius = math.floor(self._visualRadius - 10)
	self._visualRadius2 = self._visualRadius * self._visualRadius
	self._moveTime = 0
	self.isDead = false
end

function Pubg2EntityUser:setMovePosTo(arg_2_1)
	if not arg_2_1 then
		return
	end

	if self.renderComp then
		self.renderComp:setMovePosTo(arg_2_1)
	end
end

function Pubg2EntityUser:isInVisual(arg_3_1)
	if not arg_3_1 then
		return false
	end

	local var_3_0 = self.x - arg_3_1.x
	local var_3_1 = self.y - arg_3_1.y

	return var_3_0 * var_3_0 + var_3_1 * var_3_1 <= self._visualRadius2
end

return Pubg2EntityUser
