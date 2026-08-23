local var_0_0 = g.core.common.ServerTime
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_2 = g.core.model.User.outpostData
local var_0_3 = g.core.config.outpost_monster_info
local var_0_4 = g.core.const.ConstMgr.outpostConst
local OutpostEntityBossBox = class("OutpostEntityBossBox", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBase"))

function OutpostEntityBossBox:ctor()
	OutpostEntityBossBox.super.ctor(self)

	self.entityType = var_0_4.EntityType.BossBox
	self.svrData = nil
	self._mapType = 1
end

function OutpostEntityBossBox:onCreate(arg_2_1)
	self.svrData = arg_2_1
	self.monsterInfo = var_0_3.get(arg_2_1.boss_id)
	self._destroyTime = arg_2_1.expire_time
end

function OutpostEntityBossBox:getDropId()
	return self.svrData.drop_id or 0
end

function OutpostEntityBossBox:getMapType()
	return self.monsterInfo.map
end

function OutpostEntityBossBox:getDestroyTime()
	return self._destroyTime
end

function OutpostEntityBossBox:onSecondTick()
	if var_0_0:getTime() >= self._destroyTime then
		self:dispose()

		return
	end

	var_0_2:dispatchWorldEvent(OutpostEvent.BossBoxTimeTick, {
		destroyTime = self._destroyTime,
		oid = self.oid
	})
end

return OutpostEntityBossBox
