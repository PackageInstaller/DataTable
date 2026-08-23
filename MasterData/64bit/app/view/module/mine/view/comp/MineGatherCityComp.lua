local MineGatherCityComp = class("MineGatherCityComp", require("app.fairyGUI.mine.UI_MineGatherCityComp"))

function MineGatherCityComp:updateCity(arg_1_1)
	self.m_nameTxt:setText(arg_1_1.cityInfo.name)
	self.m_qualityController:setSelectedIndex(arg_1_1.cityInfo.quality - 3)
	self.m_picComp:setIcon(g.core.common.Path:getCityBuildingPic(arg_1_1.cityInfo.city_pic))

	if g.core.model.User.mineData:getCityObjById(arg_1_1.cityInfo.id):isInBonusEvent() then
		self.m_upProductController:setSelectedIndex(1)
	else
		self.m_upProductController:setSelectedIndex(0)
	end
end

return MineGatherCityComp
