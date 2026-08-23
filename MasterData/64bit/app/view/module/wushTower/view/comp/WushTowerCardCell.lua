local var_0_0 = g.core.const.ConstMgr.WushTowerConst
local var_0_1 = g.core.config.dead_tower_card_info
local WushTowerCardCell = class("WushTowerCardCell", require("app.fairyGUI.wushTower.UI_WushTowerCardCell"))

function WushTowerCardCell:ctor()
	self._cardId = 1

	self.m_lookBtn:addClickListener(handler(self, self._onClickLookCardBtn))
end

function WushTowerCardCell:updateTowerCardCell(arg_2_1, arg_2_2)
	self._cardId = arg_2_1.id

	local var_2_0 = var_0_1.get(self._cardId)
	local var_2_1 = arg_2_1.num
	local var_2_2 = g.core.common.Path:getWushCardIconById(var_2_0.icon)

	self.m_cardLoader:setURL(var_2_2)
	self.m_moreCardLoader:setURL(var_2_2)
	self.m_countTxt:setText("×" .. var_2_1)
	self.m_isMoreController:setSelectedIndex(var_2_1 > 1 and 1 or 0)
	self.m_cardNameTxt:setText(var_2_0.name)

	local var_2_3 = false

	for iter_2_0 = 1, var_0_0.RECOMMEND_NUM do
		if arg_2_2["recommend_" .. iter_2_0] > 0 and arg_2_2["recommend_" .. iter_2_0] == self._cardId then
			var_2_3 = true
		end
	end

	self.m_isRecommendController:setSelectedIndex(var_2_3 and 1 or 0)
end

function WushTowerCardCell:_onClickLookCardBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.wushTower.view.WushTowerCardDetailsPop").new({
		cardId = self._cardId
	})))
end

return WushTowerCardCell
