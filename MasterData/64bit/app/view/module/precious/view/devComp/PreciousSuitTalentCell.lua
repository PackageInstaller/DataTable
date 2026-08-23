local PreciousSuitTalentCell = class("PreciousSuitTalentCell", require("app.fairyGUI.precious.UI_PreciousSuitTalentCell"))

function PreciousSuitTalentCell:ctor()
	return
end

function PreciousSuitTalentCell:updateTalentCell(arg_2_1, arg_2_2, arg_2_3)
	arg_2_3 = arg_2_3 and arg_2_1 >= arg_2_2.star

	self.m_isActiveController:setSelectedIndex(arg_2_3 and 1 or 0)
	self.m_title:setText(g.core.config.talent_skill_info.get(arg_2_2.skillId).description .. ((not arg_2_3 or nil) and (arg_2_2.star == 0 and g.core.lang:get(421225) or g.core.lang:get(421202, {
		star = arg_2_2.star
	}))))
end

return PreciousSuitTalentCell
