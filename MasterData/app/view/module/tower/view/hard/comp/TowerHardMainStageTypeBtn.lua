local var_0_0 = g.core.config.tower_stage_info
local var_0_1 = g.core.model.User.towerHardData
local var_0_2 = g.core.const.ConstMgr.TowerConst
local TowerHardMainStageTypeBtn = class("TowerHardMainStageTypeBtn", require("app.fairyGUI.tower.UI_TowerHardMainStageTypeBtn"))

function TowerHardMainStageTypeBtn:ctor()
	self.m_enterTransition:setHook("start", handler(self, self._onEnterStart))
	self:setVisible(false)
end

function TowerHardMainStageTypeBtn:updateBtn()
	self:setVisible(true)

	local var_2_0, var_2_1 = var_0_1:getCurTowerIdByType(var_0_2.STAGE_TYPE_HARD.MAIN)

	self.m_towerOrder:setText((var_0_0.fetch(var_2_1) or {}).stage_order or 0)
	self.m_effectNode:removeAllEffect()

	local var_2_3, var_2_4, var_2_5 = var_0_1:getMainTowerIsOpen()

	if var_2_3 then
		self.m_isOpenController:setSelectedIndex(0)
	else
		self.m_isOpenController:setSelectedIndex(1)

		local var_2_7, var_2_8

		if var_2_4 == 0 then
			var_2_7 = 0
		elseif var_2_4 <= var_2_5 then
			var_2_7 = 10
		else
			var_2_7 = math.floor((var_0_1:getTotalSubTower() - var_2_5) / (var_2_4 - var_2_5) * 100)
			var_2_8 = {}
		end

		var_2_8.progress = math.min(math.max(var_2_7, 0), 100)

		self.m_progressText:setText(g.core.lang:get(308032, var_2_8))
	end

	if type(self._playOpenEffect) == "boolean" and var_2_3 ~= self._playOpenEffect then
		self:_onEnterStart()
	end
end

function TowerHardMainStageTypeBtn:_onEnterStart()
	local var_3_0, var_3_1, var_3_2 = var_0_1:getMainTowerIsOpen()

	self.m_effTitle:removeAllEffect()

	self._playOpenEffect = var_3_0

	if not var_3_0 then
		self.m_effTitle:addEffectSpine({
			anim = "play",
			name = "eff_ui_TowerHardBuild_BtitleDown",
			remove = true,
			isLoop = false
		})
	else
		local var_3_3 = "eff_ui_TowerHardBuild_BtitleUpLoop"
		local var_3_4 = {
			anim = "play",
			isLoop = false,
			remove = true
		}

		var_3_4.name = "eff_ui_TowerHardBuild_BtitleUp"
		var_3_4.eventHandler = handler(self, function()
			self.m_effTitle:addEffectSpine({
				anim = "play",
				remove = false,
				isLoop = true,
				name = var_3_3
			})
		end)

		self.m_effTitle:addEffectSpine(var_3_4)
	end
end

return TowerHardMainStageTypeBtn
