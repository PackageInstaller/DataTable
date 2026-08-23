local NewSlgMainQuestComp = class("NewSlgMainQuestComp", require("app.fairyGUI.newSlg.UI_NewSlgMainQuestComp"))

function NewSlgMainQuestComp:ctor()
	self._txtDesc = self:getChild("Txt_desc")

	self:addClickListener(handler(self, self._onClick))

	self._compPlace = self:getChild("Comp_place")
	self.m_iconLoader = self:getChild("iconLoader")
end

function NewSlgMainQuestComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER, handler(self, self._onRcvNewSlgEnter), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCMAINQUESTPROGRESS, handler(self, self._onRcvNewSlgSyncMainQuestProgress), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MAINQUESTAWARD, handler(self, self._onRcvNewSlgMainQuestAward), self)
	self:_updateView()
end

function NewSlgMainQuestComp:_onClick()
	if not self._taskData then
		return
	end

	if self._taskData.value >= g.core.model.User.newSlgData:getMainQuestGoal(self._cfg) and self._taskData.awarded == false then
		g.core.network.GameNetProxy:send_C2S_NewSlg_MainQuestAward({
			id = self._cfg.id
		})
	elseif self._cfg.jump_id > 0 then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._cfg.jump_id)
	end
end

function NewSlgMainQuestComp:_updateView()
	local var_4_0 = g.core.model.User.newSlgData:getCurMainQuest()

	self._taskData = var_4_0

	self.m_eff:removeAllEffect()

	if not var_4_0 then
		self:setVisible(false)

		return
	end

	local var_4_1 = g.core.model.User.newSlgData:getMainQuestInfoById(var_4_0.id)

	self._cfg = var_4_1

	self._txtDesc:setText(var_4_1.description .. g.core.lang:get(428988, {
		num1 = var_4_0.value,
		num2 = g.core.model.User.newSlgData:getMainQuestGoal(var_4_1)
	}))
	self.m_iconLoader:setURL(g.core.common.Goods:convert({
		size = 0,
		type = self._cfg.reward_type_1,
		value = self._cfg.reward_value_1
	}).icon_mini)

	if self._taskData.value >= g.core.model.User.newSlgData:getMainQuestGoal(self._cfg) and self._taskData.awarded == false then
		self.m_eff:addEffectSpine({
			isLoop = true,
			name = "eff_ui_newSlg_task",
			remove = false
		})
	end
end

function NewSlgMainQuestComp:_onRcvNewSlgEnter()
	self:_updateView()
end

function NewSlgMainQuestComp:_onRcvNewSlgSyncMainQuestProgress()
	self:_updateView()
end

function NewSlgMainQuestComp:_onRcvNewSlgMainQuestAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_7_4.awards)
	end

	self:_updateView()
end

return NewSlgMainQuestComp
