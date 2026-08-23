local var_0_0 = g.core.model.User.wushTowerData
local var_0_1 = g.core.config.dead_tower_card_info
local WushTowerCardDetailsPop = class("WushTowerCardDetailsPop", require("app.fairyGUI.wushTower.UI_WushTowerCardDetailsPop"), function()
	return fgui.GComponent:create({
		resName = "WushTowerCardDetailsPop",
		pkgName = "wushTower",
		pkgPath = "ui/wushTower/wushTower"
	})
end)

function WushTowerCardDetailsPop:ctor(arg_2_1)
	self:showAtCenter()

	self._cardId = arg_2_1.cardId

	self:_initMainView()
end

function WushTowerCardDetailsPop:_initMainView()
	local var_3_0 = var_0_1.get(self._cardId)

	self.m_icon:setURL((g.core.common.Path:getWushCardIconById(var_3_0.icon)))
	self.m_descTxt:setText(var_3_0.description)
	self.m_countTxt:setText(g.core.lang:get(302022, {
		num = var_0_0:getCardNumById(self._cardId)
	}))
	self.m_bgPanel:setTitle(var_3_0.name)
end

return WushTowerCardDetailsPop
