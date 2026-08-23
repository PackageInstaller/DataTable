local var_0_0 = g.core.model.User.dailyTaskData
local DailyTaskProgressComp = class("DailyTaskProgressComp", require("app.fairyGUI.dailyTask.UI_DailyTaskProgressComp"))

function DailyTaskProgressComp:ctor()
	self._degreeInfo = nil
	self._progressWidth = self.m_progressBar:getWidth()
	self._progressInitialX = self.m_progressBar:getX()
end

function DailyTaskProgressComp:updateProgress()
	local var_2_0 = var_0_0:getDailyTaskBasicInfo()

	self._degreeInfo = var_0_0:getDailyTaskDegreeInfo()

	local var_2_1 = var_0_0:getDailyTaskMaxDegree()
	local var_2_2 = 0

	for iter_2_0 = 1, #self._degreeInfo do
		if var_2_0.curDegree >= self._degreeInfo[iter_2_0].info.num then
			var_2_2 = var_2_1 / 5 * iter_2_0
		else
			local var_2_3

			if iter_2_0 > 1 then
				var_2_3 = self._degreeInfo[iter_2_0 - 1].info.num or 0
			end

			var_2_2 = var_2_2 + var_2_1 / 5 * ((var_2_0.curDegree - var_2_3) / (self._degreeInfo[iter_2_0].info.num - var_2_3))

			break
		end
	end

	self.m_progressBar:setPercent({
		cur = var_2_2,
		max = var_2_1
	})
	self.m_progressValue:setText(var_2_0.curDegree or 0)
	self:_updateBoxState(var_2_1)
end

function DailyTaskProgressComp:_updateBoxState(arg_3_1)
	for iter_3_0 = 1, 5 do
		if self["m_boxComp" .. iter_3_0] then
			self["m_boxComp" .. iter_3_0]:setVisible(false)

			if self._degreeInfo[iter_3_0] then
				self["m_boxComp" .. iter_3_0]:setVisible(true)
				self["m_boxComp" .. iter_3_0]:setX(self._progressInitialX + iter_3_0 / 5 * self._progressWidth)
				self["m_boxComp" .. iter_3_0]:updateBox(self._degreeInfo[iter_3_0])
			end
		end
	end
end

return DailyTaskProgressComp
