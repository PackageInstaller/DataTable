local var_0_0 = g.core.config.tower_stage_info
local var_0_1 = g.core.model.User.towerHardData
local var_0_2 = g.core.const.ConstMgr.TowerConst
local var_0_4 = g.core.module.ModuleManager
local TowerHardSubStageTypeBtn = class("TowerHardSubStageTypeBtn", require("app.fairyGUI.tower.UI_TowerHardSubStageTypeBtn"))

function TowerHardSubStageTypeBtn:ctor(arg_1_1)
	self.m_enterTransition:setHook("start", handler(self, self._onEnterStart))

	self._stageType = 0

	self:addClick()
end

function TowerHardSubStageTypeBtn:setStageType(arg_2_1)
	self._stageType = arg_2_1
end

function TowerHardSubStageTypeBtn:initBtnGroup(arg_3_1)
	self.m_groupController:setSelectedIndex(arg_3_1 - 2)
end

function TowerHardSubStageTypeBtn:updateBtnState(arg_4_1)
	self.m_isOpenController:setSelectedIndex(arg_4_1 and 0 or 1)
end

function TowerHardSubStageTypeBtn:addClick()
	self.m_touchComp:addClickListener(handler(self, self._onClickStageBtnClick))
end

function TowerHardSubStageTypeBtn:_onClickStageBtnClick()
	local var_6_0, var_6_1 = var_0_1:getSubTowerIsOpen(self._stageType)

	if var_6_0 then
		var_0_4:pushPopup(require("app.view.module.tower.view.hard.TowerHardSubStageLayer").new({
			stageType = self._stageType
		}), {
			ignoreTouch = false,
			touchDisappear = false
		})
	else
		var_0_4:tip(g.core.lang:get(308017))
	end
end

function TowerHardSubStageTypeBtn:updateBtn(arg_7_1)
	local var_7_0, var_7_1 = var_0_1:getCurTowerIdByType(arg_7_1)
	local var_7_3 = (var_0_0.fetch(var_7_1) or {}).stage_order or 0

	if arg_7_1 == var_0_2.STAGE_TYPE_HARD.MAIN then
		self.m_towerName:setText(g.core.lang:get(308002))
	else
		var_7_3 = var_0_1:getStageStr(var_7_3)

		local var_7_4, var_7_5 = var_0_1:getSubTowerIsOpen(arg_7_1)

		self.m_effectNode:removeAllEffect()
		self.m_towerName:setText((self:getTowerNameByType(arg_7_1)))
		self.m_isOpenController:setSelectedIndex(0)

		if var_7_4 then
			-- block empty
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

		if type(self._playOpenEffect) == "boolean" and var_7_4 ~= self._playOpenEffect then
			self:_onEnterStart()
		end
	end

	self.m_towerOrder:setText(var_7_3)
end

function TowerHardSubStageTypeBtn:getTowerNameByType(arg_8_1)
	return g.core.lang:get(308001 + arg_8_1 - 5)
end

function TowerHardSubStageTypeBtn:_onEnterStart()
	local var_9_0, var_9_1 = var_0_1:getSubTowerIsOpen(self._stageType)

	self.m_effTitle:removeAllEffect()

	self._playOpenEffect = var_9_0

	if not var_9_0 then
		self.m_effTitle:addEffectSpine({
			isLoop = false,
			name = "eff_ui_TowerHardBuild_StitleDown",
			remove = true,
			anim = "play"
		})
	else
		local var_9_2 = "eff_ui_TowerHardBuild_StitleUpLoop"
		local var_9_3 = {
			isLoop = false,
			remove = true,
			anim = "play"
		}

		var_9_3.name = "eff_ui_TowerHardBuild_StitleUp"
		var_9_3.eventHandler = handler(self, function(arg_10_0, arg_10_1, arg_10_2)
			if arg_10_1.eventData and arg_10_1.eventData.name == "cut" and arg_10_2 and not tolua.isnull(arg_10_2) then
				arg_10_0.m_effTitle:addEffectSpine({
					isLoop = true,
					remove = false,
					anim = "play",
					name = var_9_2
				})
			end
		end)

		self.m_effTitle:addEffectSpine(var_9_3)
	end
end

return TowerHardSubStageTypeBtn
