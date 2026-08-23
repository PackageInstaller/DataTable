local NewSlgHeadIcon = class("NewSlgHeadIcon", require("app.fairyGUI.newSlg.UI_NewSlgHeadIcon"))

function NewSlgHeadIcon:setAniRotate(arg_1_1)
	self.m_rotateImg:setRotation(arg_1_1 - 90)
end

function NewSlgHeadIcon:setMyIcon(arg_2_1)
	self.m_iconComp:setIcon(arg_2_1)
end

function NewSlgHeadIcon:setLevel(arg_3_1)
	self.m_levelController:setSelectedIndex(arg_3_1 - 1)
end

return NewSlgHeadIcon
