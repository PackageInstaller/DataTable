local TeamBattleBuffSelectCard = class("TeamBattleBuffSelectCard", require("app.fairyGUI.teamBattle.UI_TeamBattleBuffSelectCard"))

function TeamBattleBuffSelectCard:updateCardInfo(arg_1_1, arg_1_2)
	if not arg_1_1 then
		return
	end

	local var_1_0 = arg_1_2 and g.core.config.team_battle_buff_shop_info.get(arg_1_1) or g.core.config.team_battle_buff_info.get(arg_1_1)

	for iter_1_0 = 1, 3 do
		self["m_qualityLoader" .. iter_1_0]:setURL(g.core.common.Path:getQualityLineByQualityAndIndex(var_1_0.quality, iter_1_0))
	end

	self.m_nameTxt:setText(var_1_0.name)
	self.m_descComp:setTitle(var_1_0.des)
	self.m_iconLoader:setURL(g.core.common.Path:getThemeExplorePowerPic(var_1_0.image))
end

function TeamBattleBuffSelectCard:getNameTxt()
	return self.m_nameTxt:getText()
end

return TeamBattleBuffSelectCard
