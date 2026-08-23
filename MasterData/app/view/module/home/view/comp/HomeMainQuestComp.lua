local var_0_0 = g.core.config.main_quest_info
local var_0_1 = g.core.config.function_info
local var_0_2 = g.core.model.User.homeData
local var_0_3 = g.core.common.Goods
local var_0_4 = g.view.entrance.ModuleGotoProxy
local var_0_5 = g.core.network.GameNetProxy
local var_0_6 = g.core.module.ModuleManager
local var_0_7 = g.core.common.ModuleUnlock
local HomeMainQuestComp = class("HomeMainQuestComp", require("app.fairyGUI.home.UI_HomeMainQuestComp"))

function HomeMainQuestComp:ctor()
	self:setVisible(false)

	self._taskId = 0
	self._finishEffSpine = nil

	self:addClickListener(handler(self, self._onClickSelf))
end

function HomeMainQuestComp:_onClickSelf()
	if self._taskId == 0 then
		return
	end

	local var_2_0 = var_0_0.get(self._taskId)
	local var_2_1 = self.m_taskStateController:getSelectedIndex()

	if var_2_1 == 0 then
		local var_2_2 = var_0_1.get(var_2_0.function_id)

		if var_2_2 then
			var_0_6:tip(var_2_2.lock_direction)
		end
	elseif var_2_1 == 1 then
		if var_2_0.route_id > 1 then
			var_0_4:gotoModule(var_2_0.route_id)
		end
	elseif var_2_1 == 2 then
		var_0_5:send_C2S_MainTask_GetAward({
			id = self._taskId
		})
	elseif var_2_1 == 3 then
		-- block empty
	end
end

function HomeMainQuestComp:updateView()
	self._finishEffSpine = self._finishEffSpine or self.m_finishEffSpine:addEffectSpine({
		anim = "play",
		name = "eff_ui_home_taskglow",
		isLoop = true
	})

	self.m_finishEffSpine:setVisible(false)

	local var_3_0 = var_0_2:getShowMainQuest()

	if not var_3_0 then
		self:setVisible(false)

		return
	else
		self:setVisible(true)
	end

	self._taskId = var_3_0.type

	local var_3_1 = var_0_0.get(self._taskId)

	if var_3_1.function_id ~= 0 and not var_0_7:isModuleUnlock(var_3_1.function_id) then
		self.m_taskStateController:setSelectedIndex(0)
	elseif var_3_0.value < var_3_1.quest_value then
		self.m_taskStateController:setSelectedIndex(1)
	elseif var_3_0.value >= var_3_1.quest_value then
		self.m_taskStateController:setSelectedIndex(2)
		self.m_finishEffSpine:setVisible(true)
	end

	self.m_taskText:setText(var_3_1.description)
	self.m_awardIcon:updateIcon((var_0_3:convert({
		type = var_3_1.reward_type_1,
		value = var_3_1.reward_value_1,
		size = var_3_1.reward_size_1
	})))
end

return HomeMainQuestComp
