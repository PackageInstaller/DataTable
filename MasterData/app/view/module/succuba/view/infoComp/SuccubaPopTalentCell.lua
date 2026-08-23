local SuccubaPopTalentCell = class("SuccubaPopTalentCell", require("app.fairyGUI.succuba.UI_SuccubaPopTalentCell"))

function SuccubaPopTalentCell:ctor()
	return
end

function SuccubaPopTalentCell:updateCell(arg_2_1)
	self.m_nameText:setText(arg_2_1.title)
	self.m_descText:setText(arg_2_1.desc)
	self.m_activeController:setSelectedIndex(arg_2_1.state == 0 and 1 or 0)
end

return SuccubaPopTalentCell
