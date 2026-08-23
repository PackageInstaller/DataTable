local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = g.core.config.outpost_parameter_info
local OutpostKnightBagComp = class("OutpostKnightBagComp", require("app.fairyGUI.outpost.UI_OutpostKnightBagComp"))

function OutpostKnightBagComp:ctor()
	self.m_knightBagList:setVirtual()
	self.m_knightBagList:setItemRenderer(handler(self, self._onKnightBagRenderer))

	self._bagList = {}
end

function OutpostKnightBagComp:playEnter()
	self.m_enterTransition:stop()
	self.m_enterTransition:play()
end

function OutpostKnightBagComp:updateWithStruct(arg_3_1)
	self._bagList = arg_3_1:getOwnBagData()

	self.m_knightBagList:setNumItems(var_0_1.get(var_0_0.WorldParam.KnightBagMaxNum).parameter)
	self.m_knightBagList:transitionShowCells("enter_scaleOut", 0.03)
end

function OutpostKnightBagComp:_onKnightBagRenderer(arg_4_1, arg_4_2)
	local var_4_0 = clone(self._bagList[arg_4_1 + 1])

	if var_4_0 then
		var_4_0.ownNum = var_4_0.item_num
	end

	arg_4_2:updateIcon(var_4_0)
end

return OutpostKnightBagComp
