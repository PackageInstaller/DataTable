local FogNightmareCmdBase = require("app.view.module.fogNightmare.model.struct.execute.FogNightmareCmdBase")
local FogNightmareCmdNet = require("app.view.module.fogNightmare.model.struct.execute.FogNightmareCmdNet")
local FogNightmareCmdWaiting = require("app.view.module.fogNightmare.model.struct.execute.FogNightmareCmdWaiting")
local FogNightmarePlayerWaiter = class("FogNightmarePlayerWaiter", (import(".FogNightmarePlayerBase")))

function FogNightmarePlayerWaiter:ctor()
	FogNightmarePlayerWaiter.super:ctor(self)
end

function FogNightmarePlayerWaiter:setUIEnable(arg_2_1)
	return
end

function FogNightmarePlayerWaiter:_doSelectStageKeepsake()
	if self._isUsedUI then
		local var_3_0 = {}

		table.insert(var_3_0, (FogNightmareCmdNet.new({
			waitMsg = true,
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_GIVEUPSEAL
		})))
		table.insert(var_3_0, (FogNightmareCmdNet.new({
			waitMsg = true,
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_CHOOSESEAL
		})))

		local var_3_1 = {
			cnt = 1,
			cmdList = var_3_0
		}

		var_3_1.waiterParam = g.core.model.User.fogNightmareData:getAutoPlay():getWaiterParam()

		local var_3_2 = FogNightmareCmdWaiting.new(var_3_1)

		var_3_2:setId("checkKeepsakeNet")
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_3_2)
	else
		assert(false, "FogNightmarePlayerWaiter must use UI! ")
	end

	local var_3_3 = FogNightmareCmdBase.new({
		execute = handler(self, self._doEnterNextFloor)
	})

	var_3_3:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_3_3)
end

return FogNightmarePlayerWaiter
