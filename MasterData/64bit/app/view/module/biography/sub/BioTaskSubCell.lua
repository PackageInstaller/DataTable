local BioTaskSubCell = class("BioTaskSubCell", require("app.fairyGUI.biography.UI_BioTaskSubCell"))

function BioTaskSubCell:ctor()
	return
end

function BioTaskSubCell:updateData(arg_2_1)
	self.m_nameTxt:setText(arg_2_1.des .. "（" .. arg_2_1.value .. "/" .. arg_2_1.max .. "）")
	self.m_descTxt:setText(g.core.lang:get(302018, {
		content = arg_2_1.description
	}))
	self.m_stateController:setSelectedIndex(arg_2_1.finish and 1 or 0)
end

return BioTaskSubCell
