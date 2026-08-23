local ExplorationBuffSelectCard = class("ExplorationBuffSelectCard", require("app.fairyGUI.exploration.UI_ExplorationBuffSelectCard"))

function ExplorationBuffSelectCard:ctor()
	return
end

function ExplorationBuffSelectCard:updateCardInfo(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = g.core.config.exploration_buff_info.get(arg_2_1)

	for iter_2_0 = 1, 3 do
		self["m_qualityLoader" .. iter_2_0]:setURL(g.core.common.Path:getQualityLineByQualityAndIndex(var_2_0.quality, iter_2_0))
	end

	self.m_nameTxt:setText(var_2_0.name)
	self.m_descComp:setTitle(var_2_0.des)
	self.m_iconLoader:setURL(g.core.common.Path:getThemeExplorePowerPic(var_2_0.image))
end

return ExplorationBuffSelectCard
