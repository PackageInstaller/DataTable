local StormConst = require("app.view.module.storm.const.StormConst")
local StormMainRole = class("StormMainRole", (require("app.core.ksmap.entity.MapRole")))

function StormMainRole:ctor(arg_1_1)
	self._fightValue = 0
	self._fightShow = false

	StormMainRole.super.ctor(self, arg_1_1)
end

function StormMainRole:_onCoordChanged()
	if not self._fatherWorld then
		return
	end

	self.super._onCoordChanged(self)

	if self:isMainRole() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MAIN_ROLE_COORD_CHANGE, false, (self:getCoord()))
	end
end

function StormMainRole:checkIsNeedShow(arg_3_1)
	if self:_isCanHideByFog() and not self:_isFogClear() then
		return false
	end

	return self.super.checkIsNeedShow(self, arg_3_1)
end

function StormMainRole:setFightValue(arg_4_1)
	if arg_4_1 then
		self._fightValue = arg_4_1
	end

	if self._visualIns and self._visualIns.setFightValue then
		arg_4_1 = arg_4_1 or self._fightValue

		self._visualIns:setFightValue(arg_4_1)
	end
end

function StormMainRole:setName(arg_5_1)
	if self._visualIns and self._visualIns.setName then
		self._visualIns:setName(arg_5_1)
	end
end

function StormMainRole:playJumpEffect()
	self._visualIns:playJumpEffect()
end

function StormMainRole:setVisualBillboardScale(arg_7_1)
	if self._visualIns then
		self._visualIns:setBillboardScale(arg_7_1)
	end

	self._billboardScale = arg_7_1
end

function StormMainRole:_rebuildInit()
	self:setFightFlagShow(self._fightShow)

	if self._fightValue ~= 0 then
		self:setFightValue()
	end

	if self._fightShow then
		self._visualIns:setFightFlagShow(self._fightShow)
	end

	if self._visualIns and self._billboardScale then
		self._visualIns:setBillboardScale(self._billboardScale)
	end
end

function StormMainRole:_refreshVisual()
	StormMainRole.super._refreshVisual(self)

	if self._roleScaleX then
		self:setRoleScale(self._roleScaleX, self._roleScaleY)
	end
end

function StormMainRole:setRoleScale(arg_10_1, arg_10_2)
	self._roleScaleX = arg_10_1 or 1
	self._roleScaleY = arg_10_2 or 1

	if self._visualIns then
		self._visualIns:getVisual():setScaleX(arg_10_1 or 1)
		self._visualIns:getVisual():setScaleY(arg_10_2 or 1)
	end
end

function StormMainRole:setFightFlagShow(arg_11_1)
	self._fightShow = arg_11_1
end

function StormMainRole:_isCanHideByFog()
	return not self:isMainRole()
end

function StormMainRole:_isFogClear()
	if self._fatherWorld then
		local var_13_0 = self:getCoord()
		local var_13_1 = self._fatherWorld:getMapGround()

		if var_13_1.isFogClear then
			return var_13_1:isFogClear(var_13_0.x, var_13_0.y)
		else
			return true
		end
	else
		return false
	end
end

function StormMainRole:getClearFogRangeAtBirth()
	if self:isMainRole() then
		return StormConst.CLEAR_FOG_RANGE.MAIN_ROLE_BIRTH
	else
		return StormConst.CLEAR_FOG_RANGE.NONE
	end
end

return StormMainRole
