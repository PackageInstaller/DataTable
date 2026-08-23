local StormBigMapTitleText = class("StormBigMapTitleText", require("app.fairyGUI.storm.UI_StormBigMapTitleText"))

function StormBigMapTitleText:updateState(arg_1_1)
	self._curLandIndex = arg_1_1.index

	if arg_1_1.isSelected then
		self.m_chooseController:setSelectedIndex(1)
	else
		self.m_chooseController:setSelectedIndex(0)
	end
end

return StormBigMapTitleText
