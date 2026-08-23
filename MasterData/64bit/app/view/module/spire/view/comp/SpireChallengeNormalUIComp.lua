local SpireChallengeNormalUIComp = class("SpireChallengeNormalUIComp", require("app.fairyGUI.spire.UI_SpireChallengeNormalUIComp"))

function SpireChallengeNormalUIComp:ctor()
	self._floor = nil
end

function SpireChallengeNormalUIComp:updateUI(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs((arg_2_1:getCurStageStruct():getBuffInfoList())) do
		local var_2_1, var_2_2 = g.core.utils.String.formatPassiveSkillDesc(iter_2_1.buff)

		var_2_0[#var_2_0 + 1] = g.core.lang:get(432023, {
			index = iter_2_0,
			des = var_2_1
		})
	end

	if #var_2_0 == 0 then
		self.m_tipComp:setVisible(false)
	else
		self.m_tipComp:updateTip(table.concat(var_2_0, "\n"))
		self.m_tipComp:setVisible(true)
	end

	self.m_proComp:updateProByFloor(arg_2_1)

	self._floor = arg_2_1
end

function SpireChallengeNormalUIComp:playProAnim()
	self.m_proComp:playProActionToIndexPos((self._floor:getCurStage()))
end

return SpireChallengeNormalUIComp
