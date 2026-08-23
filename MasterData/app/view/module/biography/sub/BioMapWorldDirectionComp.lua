local BioConst = require("app.view.module.biography.const.BioConst")
local BioMapWorldDirectionComp = class("BioMapWorldDirectionComp", require("app.fairyGUI.biography.UI_BioMapWorldDirectionComp"))

function BioMapWorldDirectionComp:ctor()
	return
end

function BioMapWorldDirectionComp:updateDirectionByAngle(arg_2_1, arg_2_2, arg_2_3)
	self.m_directionIcon:setRotation(arg_2_1)
	self.m_directionTypeController:setSelectedIndex(arg_2_3 == BioConst.BIO_TASK_STATE.MAIN_TASK_UN_FINISH and 0 or 1)
	self.m_posTypeController:setSelectedIndex(arg_2_2 or 0)
end

return BioMapWorldDirectionComp
