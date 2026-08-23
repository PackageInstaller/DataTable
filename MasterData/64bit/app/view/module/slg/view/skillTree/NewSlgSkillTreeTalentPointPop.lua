local NewSlgSkillTreeTalentPointPop = class("NewSlgSkillTreeTalentPointPop", require("app.fairyGUI.newSlg.UI_NewSlgSkillTreeTalentPointPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/newSlg/newSlg",
		resName = "NewSlgSkillTreeTalentPointPop",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgSkillTreeTalentPointPop:ctor()
	self:showAtCenter()
	self.m_valueComp:updatePointDetail()
end

return NewSlgSkillTreeTalentPointPop
