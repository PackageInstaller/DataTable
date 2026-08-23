local RecruitUniteTokenTwentyChildComp = class("RecruitUniteTokenTwentyChildComp", require("app.fairyGUI.recruitUniteToken.UI_RecruitUniteTokenTwentyChildComp"))

function RecruitUniteTokenTwentyChildComp:updateCompShow(arg_1_1)
	self._awards = arg_1_1.award
	self._param1 = arg_1_1.newFlag

	for iter_1_0 = 1, 20 do
		self["m_comp" .. iter_1_0]:updateItem(self._awards[iter_1_0], self._param1 / math.pow(10, iter_1_0 - 1) % 10 > 0, true)
	end
end

function RecruitUniteTokenTwentyChildComp:setShareState()
	for iter_2_0 = 1, 20 do
		self["m_comp" .. iter_2_0]:setShareState()
	end
end

function RecruitUniteTokenTwentyChildComp:resetShareState()
	for iter_3_0 = 1, 20 do
		self["m_comp" .. iter_3_0]:resetShareState()
	end
end

function RecruitUniteTokenTwentyChildComp:getIsNewByIndex(arg_4_1)
	return self["m_comp" .. arg_4_1]:getIsNew()
end

return RecruitUniteTokenTwentyChildComp
