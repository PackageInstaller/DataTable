local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.redCliffData
local RedCliffPoolBackComp = class("RedCliffPoolBackComp", require("app.fairyGUI.redCliff.UI_RedCliffPoolBackComp"))

function RedCliffPoolBackComp:ctor()
	self._poolId = 0
	self._poolInfo = nil
end

function RedCliffPoolBackComp:updatePoolComp(arg_2_1)
	self._poolInfo = arg_2_1.poolInfo

	if self._poolInfo then
		self._poolId = self._poolInfo.id

		self.m_poolName:setText(self._poolInfo.pool_name)

		if arg_2_1.myPoolId > self._poolId then
			self.m_poolState:setText(g.core.lang:get(421009))
		else
			local var_2_0, var_2_1 = var_0_1:getDurationByPoolId(self._poolId)
			local var_2_2 = var_0_0:getTime()

			self.m_poolState:setText(g.core.lang:get(421114))

			if var_2_0 <= var_2_2 and var_2_2 < var_2_1 then
				-- block empty
			elseif var_2_2 < var_2_0 then
				local var_2_3 = var_0_0:getDateObject(var_2_0)

				self.m_poolState:setText(g.core.lang:get(421011, {
					month = var_2_3.month,
					day = var_2_3.day
				}))
			else
				self.m_poolState:setText(g.core.lang:get(421010))
			end
		end
	end
end

return RedCliffPoolBackComp
