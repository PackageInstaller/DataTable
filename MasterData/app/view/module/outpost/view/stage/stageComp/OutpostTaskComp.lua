local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = g.core.model.User.outpostData
local var_0_2 = g.core.const.ConstMgr.GuideConst
local OutpostTaskComp = class("OutpostTaskComp", require("app.fairyGUI.outpost.UI_OutpostTaskComp"))

function OutpostTaskComp:ctor()
	self._taskEffSpine = nil

	self.m_taskProgTxt:disableAutoChange()
	self:addClickListener(handler(self, self._onClickedSelf))
end

function OutpostTaskComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_SYNCTASK, self.updateMainTask, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETTASKAWARD, handler(self, self._onGetTaskAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self.checkTaskContinueGuide), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_ENTER, handler(self, self.checkTaskContinueGuide), self)
	self:updateMainTask()
end

function OutpostTaskComp:updateMainTask()
	local var_3_0 = var_0_1:getTaskData():getCurTask()

	if var_3_0.isAllFinish then
		self:setVisible(false)

		return
	end

	self.m_taskNameTxt:setText(var_3_0.cfg.description)

	local var_3_1 = var_3_0.action
	local var_3_3

	if var_3_0.action then
		local var_3_4 = var_3_1.type == var_0_0.SP_TASK_TYPE and math.max(1, var_3_1.action_value) or var_3_1.action_value

		var_3_3 = g.core.lang:get(432624, {
			cur = var_3_1.action_value,
			max = var_3_0.cfg.quest_value
		})
	else
		var_3_3 = g.core.lang:get(432624, {
			cur = 0,
			max = var_3_0.cfg.quest_value
		})
	end

	self.m_taskProgTxt:setText(var_3_3)
	self.m_icon:setURL(g.core.common.Path:getIconByTypeValue(var_3_0.awards[1].type, var_3_0.awards[1].value))

	if var_3_0.action and var_3_0.action.action_value >= var_3_0.cfg.quest_value then
		self._taskEffSpine = self._taskEffSpine or self.m_effNode:addEffectSpine({
			isLoop = true,
			name = "eff_ui_outpost_taskfull"
		})

		self.m_taskProgTxt:setText(g.core.lang:get(309207))
		self.m_canAwardController:setSelectedIndex(1)
	else
		self.m_canAwardController:setSelectedIndex(0)
	end

	self:checkTaskContinueGuide()
end

function OutpostTaskComp:checkTaskContinueGuide()
	local var_4_0 = g.core.module.ModuleManager:getCurModule()

	if var_4_0 and var_4_0.module == g.view.entrance.OUT_POST_STAGE then
		for iter_4_0, iter_4_1 in pairs(var_0_2.OUTPOST_TASKS) do
			local var_4_1 = var_0_1:getTaskData():getAction(iter_4_0, var_0_0.TASK_TYPE.MAIN)

			if var_4_1 and not var_4_1.finished and var_4_1.action_value >= g.core.config.outpost_main_quest_info.get(iter_4_0).quest_value then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
					tickType = 6,
					enum = var_0_2.ENUM_TICK[iter_4_1]
				})
			end
		end
	end
end

function OutpostTaskComp:_onClickedSelf()
	local var_5_0 = var_0_1:getTaskData():getCurTask()

	if var_5_0.action and var_5_0.action.action_value >= var_5_0.cfg.quest_value then
		self:_sendGetTaskAward({
			id = var_5_0.cfg.id
		})
	else
		g.view.entrance.ModuleGotoProxy:gotoModule(var_5_0.cfg.jump_id)
	end
end

function OutpostTaskComp:_sendGetTaskAward(arg_6_1)
	g.core.network.GameNetProxy:send_C2S_Outpost_GetTaskAward({
		task_id = arg_6_1.id,
		task_tp = var_0_0.TASK_TYPE.MAIN
	})
end

function OutpostTaskComp:_onGetTaskAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowReward = arg_7_4.awards
	})
	self:updateMainTask()
end

return OutpostTaskComp
