local MinePlayerArrowComp = class("MinePlayerArrowComp", require("app.fairyGUI.mine.UI_MinePlayerArrowComp"))

function MinePlayerArrowComp:updateIcon(arg_1_1)
	self.m_playerIconComp:setIcon(arg_1_1)
end

function MinePlayerArrowComp:setAniRotate(arg_2_1)
	self.m_arrow:setRotation(arg_2_1)
end

return MinePlayerArrowComp
