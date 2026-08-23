local StormBigMapIconComp = class("StormBigMapIconComp", require("app.fairyGUI.storm.UI_StormBigMapIconComp"))

function StormBigMapIconComp:updateState(arg_1_1)
	self._curLandIndex = arg_1_1.index

	if arg_1_1.isOpen then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	self.m_effchoose:removeAllEffect()

	if arg_1_1.isCurLand then
		self.m_stateController:setSelectedIndex(2)
	end
end

return StormBigMapIconComp
