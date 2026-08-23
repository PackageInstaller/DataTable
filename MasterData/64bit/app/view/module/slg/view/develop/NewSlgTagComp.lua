local NewSlgTagComp = class("NewSlgTagComp", require("app.fairyGUI.newSlg.UI_NewSlgTagComp"))

function NewSlgTagComp:ctor()
	return
end

function NewSlgTagComp:updateView(arg_2_1)
	self.m_lvTxt:setText(g.core.lang:get(2052, {
		level = arg_2_1.level
	}))
end

return NewSlgTagComp
