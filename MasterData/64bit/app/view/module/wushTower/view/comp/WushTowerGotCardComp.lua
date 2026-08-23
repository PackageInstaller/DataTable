local var_0_0 = g.core.config.dead_tower_card_info
local var_0_1 = g.core.common.Path
local WushTowerGotCardComp = class("WushTowerGotCardComp", require("app.fairyGUI.wushTower.UI_WushTowerGotCardComp"))

function WushTowerGotCardComp:update(arg_1_1)
	local var_1_0 = var_0_0.get(arg_1_1.cardId)

	self.m_cardLoader:setURL((var_0_1:getWushCardIconById(var_1_0.icon)))
	self.m_cardNameTxt:setText(var_1_0.name)
end

function WushTowerGotCardComp:playAnimate()
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		remove = false,
		scale = 1,
		isLoop = false,
		name = "eff_ui_common_singlereward"
	})
end

return WushTowerGotCardComp
