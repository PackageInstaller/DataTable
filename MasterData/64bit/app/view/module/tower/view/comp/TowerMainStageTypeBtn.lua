local var_0_0 = g.core.config.tower_stage_info
local var_0_1 = g.core.model.User.towerData
local var_0_2 = g.core.const.ConstMgr.TowerConst
local TowerMainStageTypeBtn = class("TowerMainStageTypeBtn", require("app.fairyGUI.tower.UI_TowerMainStageTypeBtn"))

function TowerMainStageTypeBtn:ctor()
	self:setVisible(false)
end

function TowerMainStageTypeBtn:updateBtn()
	self:setVisible(true)

	local var_2_0, var_2_1 = var_0_1:getCurTowerIdByType(var_0_2.STAGE_TYPE.MAIN)

	self.m_towerOrder:setText((var_0_0.fetch(var_2_1) or {}).stage_order or 0)
	self.m_effectNode:removeAllEffect()

	local var_2_3, var_2_4, var_2_5 = var_0_1:getMainTowerIsOpen()

	if var_2_3 then
		self.m_isOpenController:setSelectedIndex(0)
		self.m_effectNode:addEffectSpine({
			isLoop = true,
			name = "eff_ui_towerMap_iconIdle",
			anim = "play2"
		})
	else
		self.m_isOpenController:setSelectedIndex(1)

		local var_2_7 = var_2_4 == 0 and 0 or var_2_4 <= var_2_5 and 10 or math.min(math.floor((var_0_1:getTotalSubTower() - var_2_5) / (var_2_4 - var_2_5) * 100), 100)

		self.m_progressText:setText(g.core.lang:get(308032, {
			progress = var_2_7
		}))
	end
end

return TowerMainStageTypeBtn
