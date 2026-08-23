local var_0_0 = g.core.const.ConstMgr.ThemeBioConst
local ThemeBioMapWorldDirectionComp = class("ThemeBioMapWorldDirectionComp", require("app.fairyGUI.themeBio.UI_ThemeBioMapWorldDirectionComp"))

function ThemeBioMapWorldDirectionComp:updateDirectionByAngle(arg_1_1, arg_1_2, arg_1_3)
	self.m_directionIcon:setRotation(arg_1_1)
	self.m_directionTypeController:setSelectedIndex(arg_1_3 == var_0_0.BIO_TASK_STATE.MAIN_TASK_UN_FINISH and 0 or 1)
	self.m_posTypeController:setSelectedIndex(arg_1_2 or 0)
end

return ThemeBioMapWorldDirectionComp
