local NewSlgUpgradeBuildComp = class("NewSlgUpgradeBuildComp", require("app.fairyGUI.newSlg.UI_NewSlgUpgradeBuildComp"))

function NewSlgUpgradeBuildComp:ctor()
	return
end

function NewSlgUpgradeBuildComp:updateView(arg_2_1)
	self:setTitle(g.core.lang:get(2052, {
		level = arg_2_1.level
	}))
	self:setIcon(arg_2_1.resURL)
	self.m_newPoint:setVisible(checkbool(arg_2_1.showRed))
end

return NewSlgUpgradeBuildComp
