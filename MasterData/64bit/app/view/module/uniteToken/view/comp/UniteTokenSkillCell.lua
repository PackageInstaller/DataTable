local var_0_0 = g.core.const.ConstMgr.UniteTokenConst
local UniteTokenSkillCell = class("UniteTokenSkillCell", require("app.fairyGUI.uniteToken.UI_UniteTokenSkillCell"))

function UniteTokenSkillCell:ctor()
	return
end

function UniteTokenSkillCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self.m_title:setText(g.core.lang:get(202519, {
		level = arg_2_1.level,
		star = arg_2_1.star
	}))
	self.m_desc:setText((arg_2_1.isActive or nil) and (arg_2_1.desc or g.core.utils.String.paintDescGreyColorful(arg_2_1.desc)))
	self.m_isActiveController:setSelectedIndex((arg_2_1.isActive or nil) and (var_0_0.CTRL_TALENT_ACTIVE or var_0_0.CTRL_TALENT_UNACTIVE))
end

return UniteTokenSkillCell
