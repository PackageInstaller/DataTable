local ValentinesDayItemCountComp = class("ValentinesDayItemCountComp", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayItemCountComp"))
local var_0_1 = g.core.common.Path

function ValentinesDayItemCountComp:ctor()
	return
end

function ValentinesDayItemCountComp:updateRes(arg_2_1)
	self._type = arg_2_1.type
	self._value = arg_2_1.value
	self._size = arg_2_1.size or 0

	self.m_iconLoader:setURL((var_0_1:getIconByTypeValue(self._type, self._value, true)))
	self.m_sizeTxt:setText(self._size)
end

function ValentinesDayItemCountComp:onLoad()
	return
end

function ValentinesDayItemCountComp:onUnload()
	return
end

return ValentinesDayItemCountComp
