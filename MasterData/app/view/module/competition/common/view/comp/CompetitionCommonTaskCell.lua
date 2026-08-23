local var_0_0 = g.core.model.User.commonCompetitionDataManager
local var_0_1 = g.core.const.ConstMgr.CompetitionConst
local CompetitionCommonTaskCell = class("CompetitionCommonTaskCell", require("app.fairyGUI.competition.UI_CompetitionCommonTaskCell"))

function CompetitionCommonTaskCell:ctor()
	self._taskId = 0
	self._drops = {}
	self._taskInfo = nil
	self._activeSubId = 0

	self.m_awardList:setIniter()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
	self.m_getAwardLoader:addClickListener(handler(self, self._onClickGetAwardLoader))
end

function CompetitionCommonTaskCell:setActivitySubId(arg_2_1)
	self._activeSubId = arg_2_1
	self._competitionData = var_0_0:getDataById(arg_2_1)
end

function CompetitionCommonTaskCell:updateTaskCell(arg_3_1, arg_3_2)
	self:setActivitySubId(arg_3_2)

	local var_3_0

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		var_3_0 = iter_3_1

		if not self._competitionData:isGetTaskAward(iter_3_1.id) then
			break
		end
	end

	if var_3_0 then
		self._taskInfo = var_3_0
		self._taskId = self._taskInfo.id

		self.m_descTxt:setText(self._taskInfo.des)

		self._drops = g.core.common.Drops:getGoodsArray(self._taskInfo.drop)

		self.m_awardList:setNumItems(#self._drops)
		self.m_taskStateController:setSelectedIndex((self._competitionData:getTaskState(self._taskId)))
	end
end

function CompetitionCommonTaskCell:_onAwardListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon({
		type = self._drops[arg_4_1 + 1].type,
		value = self._drops[arg_4_1 + 1].value,
		size = self._drops[arg_4_1 + 1].size
	})
end

function CompetitionCommonTaskCell:_onClickGetAwardLoader()
	local var_5_0 = self._competitionData:getTaskState(self._taskId)

	if var_5_0 == var_0_1.AWARD_STATE.UNGET then
		if self._taskInfo.route > 0 then
			g.view.entrance.ModuleGotoProxy:gotoModule(self._taskInfo.route)
		end
	elseif var_5_0 == var_0_1.AWARD_STATE.CANGET then
		g.core.network.GameNetProxy:send_C2S_Competition_TaskAward({
			task_id = self._competitionData:getTabAllCanGetAwardId(self._taskInfo.task_tag),
			activity_sub_id = self._activeSubId
		})
	elseif var_5_0 == var_0_1.AWARD_STATE.ACTEND then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
	end
end

return CompetitionCommonTaskCell
