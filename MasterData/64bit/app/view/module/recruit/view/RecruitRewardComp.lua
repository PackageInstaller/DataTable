local RecruitRewardComp = class("RecruitRewardComp", require("app.fairyGUI.recruitKnight.UI_RecruitRewardComp"))
local TaskAward = require("app.core.common.TaskAward")

function RecruitRewardComp:ctor()
	self._stateList = {}
	self._taskData = TaskAward:getTaskAwardById(g.core.const.ConstMgr.TaskConst.MODULE_ID.RECRUIT, g.core.const.ConstMgr.TaskConst.TYPE_ID.ADVANCE_RECRUIT)

	self.m_boxIcon1:addClickListener(handler(self, self._onBox1TouchClick))
	self.m_boxIcon2:addClickListener(handler(self, self._onBox2TouchClick))
	self:_updateView()
end

function RecruitRewardComp:updateView()
	self:_updateView()
end

function RecruitRewardComp:_updateView()
	local var_3_0 = g.core.model.User.recruitData:getAdvanceAndGroupNum()
	local var_3_1 = {}

	for iter_3_0 = 1, 2 do
		if self._taskData[iter_3_0] and self._taskData[iter_3_0].awards then
			self["m_flagTxt" .. iter_3_0]:setText(self._taskData[iter_3_0].times)

			var_3_1[iter_3_0] = self._taskData[iter_3_0].times
		end
	end

	var_3_1[3] = self._taskData[3].times

	if var_3_0 < self._taskData[3].times then
		self.m_finalTxt:setText("[color=#E52E2E]" .. var_3_0 .. "[/color]/" .. self._taskData[3].times)
	else
		self.m_finalTxt:setText(self._taskData[3].times .. "/" .. self._taskData[3].times)
	end

	self:_updateBoxView()
	self:_updateProcessView(var_3_0, var_3_1)
end

function RecruitRewardComp:_updateBoxView()
	local var_4_0 = g.core.model.User.taskData:getTaskInfoByModuleId(g.core.const.ConstMgr.TaskConst.MODULE_ID.RECRUIT)
	local var_4_1 = g.core.model.User.recruitData:getAdvanceAndGroupNum()

	self._stateList = {}

	for iter_4_0 = 1, 2 do
		self._stateList[iter_4_0] = 0
		self._stateList[iter_4_0] = not var_4_0.receiveIdList[self._taskData[iter_4_0].taskId] and (var_4_1 >= self._taskData[iter_4_0].times and 1 or 0) or 2

		if self._stateList[iter_4_0] == 0 then
			self["m_boxDesc" .. iter_4_0]:setText(g.core.lang:get(108024))
		elseif self._stateList[iter_4_0] == 1 then
			self["m_boxDesc" .. iter_4_0]:setText(g.core.lang:get(108024))
		else
			self["m_boxDesc" .. iter_4_0]:setText(g.core.lang:get(108025))
		end
	end
end

function RecruitRewardComp:_updateProcessView(arg_5_1, arg_5_2)
	local var_5_0 = 100
	local var_5_1 = 0

	var_5_1 = arg_5_1 / arg_5_2[#arg_5_2] < 29 / 100 and math.floor(arg_5_1 / arg_5_2[1] * 29) or arg_5_1 / arg_5_2[#arg_5_2] < 70 / var_5_0 and 29 + math.floor((arg_5_1 - arg_5_2[1]) / (arg_5_2[2] - arg_5_2[1]) * (70 - 29 - 3)) + 3 or 70 + math.floor((arg_5_1 - arg_5_2[2]) / (arg_5_2[3] - arg_5_2[2]) * (100 - 70 - 3)) + 3

	self.m_pointImg1:setVisible(arg_5_1 >= arg_5_2[1])
	self.m_pointImg2:setVisible(arg_5_1 >= arg_5_2[2])
	self.m_processBar:setMax(var_5_0)
	self.m_processBar:setValue(var_5_1)
end

function RecruitRewardComp:_onBox1TouchClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.recruit.view.RecruitRewardPop").new(self._taskData[1], self._stateList[1])))
end

function RecruitRewardComp:_onBox2TouchClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.recruit.view.RecruitRewardPop").new(self._taskData[2], self._stateList[2])))
end

return RecruitRewardComp
