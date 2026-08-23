local var_0_0 = g.core.config.storm_cell_event_info
local var_0_1 = g.core.config.storm_event_info
local StormConst = require("app.view.module.storm.const.StormConst")
local var_0_3 = StormConst.EVENT_TYPE
local StormMapItem = class("StormMapItem", require("app.core.ksmap.entity.MapItem"))

function StormMapItem:ctor(arg_1_1, arg_1_2)
	self.event_type = arg_1_1.event_type
	self._enterWithShow = arg_1_1.enterWithShow

	StormMapItem.super.ctor(self, arg_1_1, arg_1_2)

	if arg_1_1.enterWithShow then
		self._isOptimizeShow = true
	end
end

function StormMapItem:getEntityName()
	return self._descName
end

function StormMapItem:getMapVisual()
	return self._visualIns
end

function StormMapItem:checkIsNeedShow(arg_4_1)
	if self:isCanHideByFog() and not self:_isFogClear() then
		return false
	end

	return self.super.checkIsNeedShow(self, arg_4_1)
end

function StormMapItem:_isFogClear()
	if self._fatherWorld then
		local var_5_0 = self:getCoord()
		local var_5_1 = self._fatherWorld:getMapGround()

		if var_5_1.isFogClear then
			return var_5_1:isFogClear(var_5_0.x, var_5_0.y)
		else
			return true
		end
	else
		return false
	end
end

function StormMapItem:isCanHideByFog()
	local var_6_0 = self:getBindID()

	if not var_6_0 or var_6_0 < 1 then
		return false
	end

	local var_6_1 = var_0_1.fetch(var_0_0.fetch(var_6_0).event_id_1).event_type

	return var_6_1 == var_0_3.BOX or var_6_1 == var_0_3.NORMAL_AWARD or var_6_1 == var_0_3.MUL_TEAM_MONSTER
end

function StormMapItem:getClearFogRangeAtBirth()
	local var_7_0 = self:getBindID()

	if var_7_0 and var_7_0 > 0 and var_0_1.fetch(var_0_0.fetch(var_7_0).event_id_1).event_type == var_0_3.SPECAIL_BARRIER then
		return StormConst.CLEAR_FOG_RANGE.BARRIER_BIRTH
	end

	return StormConst.CLEAR_FOG_RANGE.NONE
end

return StormMapItem
