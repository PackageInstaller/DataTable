local var_0_0 = g.core.model.User.releaseActivityData
local ReleaseAccumulateComp = class("ReleaseAccumulateComp", require("app.fairyGUI.release.UI_ReleaseAccumulateComp"))

function ReleaseAccumulateComp:ctor()
	self._releaseReward = {}

	self.m_accumulateList:setVirtual()
	self.m_accumulateList:setItemRenderer(handler(self, self._onAccumulateItemRender))
end

function ReleaseAccumulateComp:_onAccumulateItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateAccumulateCell(self._releaseReward[arg_2_1 + 1], arg_2_1 + 1)
end

function ReleaseAccumulateComp:updateAccumulateComp()
	self._releaseReward = var_0_0:getReleaseRewardData()

	self.m_accumulateList:setNumItems(#self._releaseReward)
	self.m_accumulateList:scrollToView(self:getScorllIdx())
	self.m_drawCountTxt:setText(var_0_0:getDrawTime())
end

function ReleaseAccumulateComp:getScorllIdx()
	local var_4_0 = 0
	local var_4_1 = var_0_0:getDrawTime()

	for iter_4_0, iter_4_1 in ipairs(self._releaseReward) do
		if not var_0_0:isGetReleaseReward(iter_4_1.id) and var_4_1 >= iter_4_1.num then
			var_4_0 = iter_4_0

			break
		end
	end

	return math.max(var_4_0 - 1, 0)
end

return ReleaseAccumulateComp
