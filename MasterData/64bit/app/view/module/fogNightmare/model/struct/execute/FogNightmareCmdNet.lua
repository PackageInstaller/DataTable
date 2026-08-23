local FogNightmareCmdNet = class("FogNightmareCmdNet", (require("app.view.module.fogNightmare.model.struct.execute.FogNightmareCmdBase")))

function FogNightmareCmdNet:ctor(arg_1_1)
	FogNightmareCmdNet.super.ctor(self, arg_1_1)

	self._netFunc = arg_1_1.netFunc
	self._receiveFunc = arg_1_1.receive
	self._netParams = arg_1_1.netParams
	self._netEventKey = arg_1_1.netEventKey
	self._waitNetMsg = arg_1_1.waitMsg
	self._isReceive = false
end

function FogNightmareCmdNet:onActive()
	g.core.event.EventManager:addEventListener(self._netEventKey, self._onReceiveNetMsg, self)
end

function FogNightmareCmdNet:onInactive()
	g.core.event.EventManager:removeListenerWithTarget(self)
end

function FogNightmareCmdNet:_isTrigger(arg_4_1)
	return FogNightmareCmdNet.super._isTrigger(self, arg_4_1) and self._waitNetMsg and self._isReceive
end

function FogNightmareCmdNet:_onExecuteSelf()
	if self._netFunc then
		self._netFunc(self._netParams)
	end
end

function FogNightmareCmdNet:isFinish()
	return self._isReceive and FogNightmareCmdNet.super.isFinish(self)
end

function FogNightmareCmdNet:_onReceiveNetMsg(arg_7_1, arg_7_2, arg_7_3)
	self._isReceive = true

	if self._receiveFunc then
		self._receiveFunc(arg_7_3)
	end
end

return FogNightmareCmdNet
