local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_1 = g.core.model.User.gveDataMgr
local GveFormationComp = class("GveFormationComp", require("app.fairyGUI.gve.UI_GveFormationComp"))

function GveFormationComp:ctor()
	self._formationData = var_0_1:getGveFormationData()
end

function GveFormationComp:updateComp(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1 then
		for iter_2_0 = 1, var_0_0.LINEUP_MAX do
			self["m_knight" .. iter_2_0]:updateComp(iter_2_0, (self._formationData:getKnightByPos(iter_2_0)))
		end
	else
		for iter_2_1 = 1, var_0_0.LINEUP_MAX do
			self["m_knight" .. iter_2_1]:updateComp(iter_2_1, arg_2_2, true, arg_2_3, arg_2_4)
		end
	end
end

function GveFormationComp:checkPosInComp(arg_3_1, arg_3_2, arg_3_3)
	for iter_3_0 = 1, var_0_0.LINEUP_MAX do
		if self["m_knight" .. iter_3_0] and self["m_knight" .. iter_3_0]:containPoint(arg_3_1) then
			if arg_3_3 then
				self["m_knight" .. iter_3_0]:setCompTouch(true)
			end

			if arg_3_2 or self["m_knight" .. iter_3_0]:hasKnight() then
				return iter_3_0, self["m_knight" .. iter_3_0]
			else
				return 0
			end
		end
	end

	return 0
end

return GveFormationComp
