local NewSlgBuildComp = class("NewSlgBuildComp", require("app.fairyGUI.newSlg.UI_NewSlgBuildComp"))

function NewSlgBuildComp:ctor()
	return
end

function NewSlgBuildComp:updateView(arg_2_1)
	self.m_levelNumController:setSelectedIndex(arg_2_1.nextLv and arg_2_1.nextLv > 0 and arg_2_1.nextLv ~= arg_2_1.curLv and 2 or 1)
	self.m_title:setText(arg_2_1.title or "")

	local var_2_1 = {}

	var_2_1.level = arg_2_1.curLv or 0

	self.m_curLv:setText(g.core.lang:get(2052, var_2_1))

	local var_2_2 = {}

	var_2_2.level = arg_2_1.nextLv or 0

	self.m_nextLv:setText(g.core.lang:get(2052, var_2_2))

	if arg_2_1.resURL then
		self.m_icon:setURL(arg_2_1.resURL)
	end
end

return NewSlgBuildComp
