local var_0_0 = g.core.const.ConstMgr.EchoLabConst
local EchoLabDeploySlotComp = class("EchoLabDeploySlotComp", require("app.fairyGUI.echoLab.UI_EchoLabDeploySlotComp"))

function EchoLabDeploySlotComp:ctor()
	self._ctrlType = 0
	self._cardType = 0
	self._selectPos = 0
end

function EchoLabDeploySlotComp:updateSlotComp(arg_2_1, arg_2_2, arg_2_3)
	self._ctrlType = arg_2_1
	self._cardType = arg_2_2
	self._selectPos = arg_2_3

	for iter_2_0 = 1, var_0_0.ECHOLAB_SLOT_COUNT do
		self["m_card" .. iter_2_0]:updateDeployCardComp(iter_2_0, self._ctrlType, self._cardType, self._selectPos)
	end
end

return EchoLabDeploySlotComp
