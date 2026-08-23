local var_0_0 = g.core.config.tower_stage_info
local var_0_1 = g.core.model.User.towerData
local var_0_2 = g.core.const.ConstMgr.TowerConst
local var_0_3 = g.core.module.ModuleManager
local TowerSubStageTypeBtn = class("TowerSubStageTypeBtn", require("app.fairyGUI.tower.UI_TowerSubStageTypeBtn"))

function TowerSubStageTypeBtn:ctor(arg_1_1)
	self._stageType = 0

	self:addClick()
end

function TowerSubStageTypeBtn:setStageType(arg_2_1)
	self._stageType = arg_2_1
end

function TowerSubStageTypeBtn:initBtnGroup(arg_3_1)
	self.m_groupController:setSelectedIndex(arg_3_1 - 2)
end

function TowerSubStageTypeBtn:updateBtnState(arg_4_1)
	self.m_isOpenController:setSelectedIndex(arg_4_1 and 0 or 1)
end

function TowerSubStageTypeBtn:addClick()
	self.m_touchComp:addClickListener(handler(self, self._onClickStageBtnClick))
end

function TowerSubStageTypeBtn:_onClickStageBtnClick()
	local var_6_0, var_6_1 = var_0_1:getSubTowerIsOpen(self._stageType)

	if var_6_0 then
		var_0_3:pushPopup(require("app.view.module.tower.view.TowerSubStageLayer").new({
			stageType = self._stageType
		}), {
			touchDisappear = false,
			ignoreTouch = false
		})
	else
		var_0_3:tip(g.core.lang:get(308017))
	end
end

function TowerSubStageTypeBtn:updateBtn(arg_7_1)
	local var_7_0, var_7_1 = var_0_1:getCurTowerIdByType(arg_7_1)
	local var_7_3 = (var_0_0.fetch(var_7_1) or {}).stage_order or 0

	if arg_7_1 == var_0_2.STAGE_TYPE.MAIN then
		self.m_towerName:setText(g.core.lang:get(308002))
	else
		var_7_3 = var_0_1:getStageStr(var_7_3)

		local var_7_4, var_7_5 = var_0_1:getSubTowerIsOpen(arg_7_1)

		self.m_effectNode:removeAllEffect()
		self.m_towerName:setText(g.core.lang:get(308001 + arg_7_1))
		self.m_isOpenController:setSelectedIndex(0)

		if var_7_4 then
			self.m_effectNode:addEffectSpine({
				isLoop = true,
				anim = "play",
				name = "eff_ui_towerMap_iconIdle"
			})
		else
			self.m_isOpenController:setSelectedIndex(1)

			local var_7_6 = var_0_1:getParamDataByType(arg_7_1)
			local var_7_7 = 0

			for iter_7_0 = 1, 4 do
				if var_7_6["open_time_" .. iter_7_0] > 0 then
					var_7_7 = var_7_7 + 1
				end
			end

			local var_7_8 = 308001

			if var_7_7 == 3 then
				var_7_8 = 308031
			elseif var_7_7 == 2 then
				var_7_8 = 308035
			end

			self.m_towerOpenTime:setText((g.core.lang:get(var_7_8, {
				day1 = var_7_6.open_time_1,
				day2 = var_7_6.open_time_2,
				day3 = var_7_6.open_time_3,
				day4 = var_7_6.open_time_4
			})))
		end
	end

	self.m_towerOrder:setText(var_7_3)
end

return TowerSubStageTypeBtn
