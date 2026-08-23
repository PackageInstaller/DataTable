local NewSlgTeamRulePop = class("NewSlgTeamRulePop", function()
	return fgui.GComponent:create({
		resName = "NewSlgTeamRulePop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgTeamRulePop:ctor(arg_2_1)
	self:showAtCenter()

	self._compContent = self:getChild("Comp_content")
	self._params = arg_2_1
end

function NewSlgTeamRulePop:onLoad()
	self:_updateView()
end

function NewSlgTeamRulePop:_updateView()
	self._compContent:updateView(self._params)
end

return NewSlgTeamRulePop
