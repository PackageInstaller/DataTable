local BioHeadBtn = class("BioHeadBtn", require("app.fairyGUI.biography.UI_BioHeadBtn"))

function BioHeadBtn:ctor()
	self.m_headIcon:setIcon((g.core.common.Path:getKnightIconById(300060)))
end

function BioHeadBtn:setHeadInfo(arg_2_1)
	self.m_headIcon:setIcon((g.core.common.Path:getKnightIconById(arg_2_1)))
end

function BioHeadBtn:setRotationTo(arg_3_1)
	self.m_arrowImg:setRotation(arg_3_1 - 90)
end

return BioHeadBtn
