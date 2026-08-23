local var_0_0 = g.core.model.User.competitionData
local var_0_1 = g.core.const.ConstMgr.CompetitionConst
local var_0_2 = g.core.config.competition_task_info
local CompetitionTaskCell = class("CompetitionTaskCell", require("app.fairyGUI.competition.UI_CompetitionTaskCell"))

function CompetitionTaskCell:ctor()
	self._taskId = 0
	self._drops = {}

	self.m_awardList:setIniter()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
	self.m_getAwardLoader:addClickListener(handler(self, self._onClickGetAwardLoader))
end

function CompetitionTaskCell:updateTaskCell(arg_2_1)
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		var_2_0 = iter_2_1.id

		if not var_0_0:isGetTaskAward(iter_2_1.id) then
			break
		end
	end

	if var_2_0 > 0 then
		self._taskInfo = var_0_2.get(var_2_0)

		self.m_descTxt:setText(self._taskInfo.des)

		self._drops = g.core.common.Drops:getGoodsArray(self._taskInfo.drop)

		self.m_awardList:setNumItems(#self._drops)
		self.m_taskStateController:setSelectedIndex((var_0_0:getTaskState(var_2_0)))

		self._taskId = var_2_0
	end
end

function CompetitionTaskCell:_onAwardListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon({
		type = self._drops[arg_3_1 + 1].type,
		value = self._drops[arg_3_1 + 1].value,
		size = self._drops[arg_3_1 + 1].size
	})
end

function CompetitionTaskCell:_onClickGetAwardLoader()
	local var_4_0 = var_0_0:getTaskState(self._taskId)

	if var_4_0 == var_0_1.AWARD_STATE.UNGET then
		if self._taskInfo.route > 0 then
			g.view.entrance.ModuleGotoProxy:gotoModule(self._taskInfo.route)
		end
	elseif var_4_0 == var_0_1.AWARD_STATE.CANGET then
		g.core.network.GameNetProxy:send_C2S_HandbookCompetition_GetAward({
			id = var_0_0:getTabAllCanGetAwardId(self._taskInfo.task_tag),
			type = var_0_1.AWARD_TYPE.COMMON
		})
	elseif var_4_0 == var_0_1.AWARD_STATE.ACTEND then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
	end
end

return CompetitionTaskCell
