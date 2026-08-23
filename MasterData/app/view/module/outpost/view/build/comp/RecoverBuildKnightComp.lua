local RecoverBuildKnightComp = class("RecoverBuildKnightComp", require("app.fairyGUI.outpost.UI_RecoverBuildKnightComp"))

function RecoverBuildKnightComp:ctor()
	self._knightInfo = nil
end

function RecoverBuildKnightComp:updateKnightComp(arg_2_1)
	self.m_knightHolder:removeChildren()

	local var_2_0 = require("app.view.common.CommonKnight").new({
		resId = g.core.config.knight_info.get((g.core.model.User.outpostData:getKnightsData():getKnightBySid(arg_2_1.sid):getAdvId())).res_id
	})

	var_2_0:setPosition((cc.p(0, var_2_0:getSize().height / 2)))
	self.m_knightHolder:addChild(var_2_0)

	self._knightInfo = arg_2_1

	self.m_timePro:setMax(self._knightInfo.time - self._knightInfo.inTime)
	self:doTickPro()
end

function RecoverBuildKnightComp:doTickPro()
	local var_3_0 = self._knightInfo.leftTime

	self.m_timePro:setValue(self._knightInfo.leftTime)

	if var_3_0 <= 0 then
		var_3_0 = 0

		local var_3_1 = {}

		var_3_1.time = 0

		self.m_timeSecTxt:setText(g.core.lang:get(432634, var_3_1))
	else
		self.m_timeSecTxt:setText(g.core.lang:get(432634, {
			time = var_3_0
		}))
	end
end

return RecoverBuildKnightComp
