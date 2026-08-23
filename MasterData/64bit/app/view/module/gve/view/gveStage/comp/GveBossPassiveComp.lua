local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveData()
local GveBossPassiveComp = class("GveBossPassiveComp", require("app.fairyGUI.gve.UI_GveBossPassiveComp"))

function GveBossPassiveComp:ctor()
	var_0_1 = var_0_0:getGveData()
end

function GveBossPassiveComp:updateByPoc(arg_2_1)
	local var_2_0 = var_0_1:getBuildDataByPos(arg_2_1).cfg

	if var_2_0 then
		for iter_2_0 = 1, 3 do
			if var_2_0["passive_skill_" .. iter_2_0] and var_2_0["passive_skill_" .. iter_2_0] ~= 0 then
				self["m_icon" .. iter_2_0]:updateIconById(var_2_0["passive_skill_" .. iter_2_0])
			end
		end
	end
end

return GveBossPassiveComp
