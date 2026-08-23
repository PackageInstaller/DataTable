local var_0_0 = {
	433344,
	433345,
	433346,
	433347,
	433348
}
local AncientsStageComp = class("AncientsStageComp", require("app.fairyGUI.ancients.UI_AncientsStageComp"))

function var_0_1.ctor(arg_1_0)
	return
end

function var_0_1:updateView()
	local var_2_0 = g.core.model.User.ancientsData:getActivityData()
	local var_2_1 = g.core.common.ServerTime:getLeftSeconds(var_2_0.score_start_time)
	local var_2_2 = g.core.common.ServerTime:getLeftSeconds(var_2_0.score_end_time)
	local var_2_3 = g.core.common.ServerTime:getLeftSeconds(var_2_0.final_start_time)
	local var_2_4 = g.core.common.ServerTime:getLeftSeconds(var_2_0.final_end_time)
	local var_2_5 = ""
	local var_2_6 = 0
	local var_2_7 = true

	if var_2_1 > 0 then
		var_2_5 = g.core.lang:get(var_0_0[1])
		var_2_6 = var_2_1
	elseif var_2_2 > 0 then
		var_2_5 = g.core.lang:get(var_0_0[2])
		var_2_6 = var_2_2
	elseif var_2_3 > 0 then
		var_2_5 = g.core.lang:get(var_0_0[3])
		var_2_6 = var_2_3
	elseif var_2_4 > 0 then
		var_2_6 = var_2_4
		var_2_5 = g.core.lang:get(var_0_0[4])
	else
		var_2_7 = false
	end

	self:setVisible(var_2_7)

	if not var_2_7 then
		return
	end

	self.m_Txt_stage:setText(var_2_5)
	self.m_Txt_cd:setText(g.core.common.ServerTime:getShowTimeBySecond(var_2_6))

	self._timeSchedule = self:newSchedule(handler(self, self.updateTime), 1)
end

function var_0_1:updateTime()
	local var_3_0 = g.core.model.User.ancientsData:getActivityData()
	local var_3_1 = g.core.common.ServerTime:getLeftSeconds(var_3_0.score_start_time)
	local var_3_2 = g.core.common.ServerTime:getLeftSeconds(var_3_0.score_end_time)
	local var_3_3 = g.core.common.ServerTime:getLeftSeconds(var_3_0.final_start_time)
	local var_3_4 = g.core.common.ServerTime:getLeftSeconds(var_3_0.final_end_time)

	self.m_Txt_cd:setText(g.core.common.ServerTime:getShowTimeBySecond(var_3_1 > 0 and var_3_1 or var_3_2 > 0 and var_3_2 or var_3_3 > 0 and var_3_3 or var_3_4 > 0 and var_3_4 or g.core.common.ServerTime:getLeftTimeByDay(var_3_0.end_time)))
end

return var_0_1
