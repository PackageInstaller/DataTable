local var_0_0 = g.core.const.ConstMgr.UniteTokenConst
local UniteTokenTalentCell = class("UniteTokenTalentCell", require("app.fairyGUI.uniteToken.UI_UniteTokenTabTalentCell"))

function UniteTokenTalentCell:ctor()
	return
end

function UniteTokenTalentCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self.m_title:setText(g.core.lang:get(202512, {
		name = arg_2_1.info.name
	}))
	self.m_desc:setText(g.core.lang:get(202513, {
		desc = arg_2_1.info.description,
		level = arg_2_1.level
	}))
	self.m_isActiveController:setSelectedIndex((arg_2_1.isActive or nil) and (var_0_0.CTRL_TALENT_ACTIVE or var_0_0.CTRL_TALENT_UNACTIVE))
end

return UniteTokenTalentCell
