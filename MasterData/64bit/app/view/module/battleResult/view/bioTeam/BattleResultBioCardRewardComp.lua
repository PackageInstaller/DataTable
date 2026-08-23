local BattleResultBioCardRewardComp = class("BattleResultBioCardRewardComp", require("app.fairyGUI.battleResult.UI_BattleResultBioCardRewardComp"))

function BattleResultBioCardRewardComp:updateCard(arg_1_1)
	self._cardData = arg_1_1

	self.m_nameComp:setName(arg_1_1.name, arg_1_1.isMine)

	local var_1_0 = g.core.common.Goods:convert(arg_1_1.award)

	self.m_itemNameTxt:setText(var_1_0.name)
	self.m_qualityL:setIcon("ui://base_new/pic_lzzy_jianglipinzhi_" .. var_1_0.quality + 1)
	self.m_qualityR:setIcon("ui://base_new/pic_lzzy_jianglipinzhi_" .. var_1_0.quality + 1)
	self.m_icon:setIcon(var_1_0.icon)
	self.m_numTxt:setText(arg_1_1.award.size)
end

return BattleResultBioCardRewardComp
