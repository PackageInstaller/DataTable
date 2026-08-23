local NewSlgSkillTreeTalentPointPop = class("NewSlgSkillTreeTalentPointPop", require("app.fairyGUI.newSlg.UI_NewSlgSkillTreeTalentPointPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgSkillTreeTalentPointPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgSkillTreeTalentPointPop:ctor()
	self:showAtCenter()
	self.m_valueComp:updatePointDetail()
end

return NewSlgSkillTreeTalentPointPop
