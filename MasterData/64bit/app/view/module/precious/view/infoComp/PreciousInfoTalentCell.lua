local var_0_0 = g.core.const.ConstMgr.UniteTokenConst
local PreciousInfoTalentCell = class("PreciousInfoTalentCell", require("app.fairyGUI.precious.UI_PreciousInfoTalentCell"))

function PreciousInfoTalentCell:ctor()
	return
end

function PreciousInfoTalentCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self.m_title:setText(g.core.lang:get(202512, {
		name = arg_2_1.name
	}))
	self.m_desc:setText(g.core.lang:get(421229, {
		desc = arg_2_1.description,
		level = arg_2_1.stage
	}))
	self.m_isActiveController:setSelectedIndex((arg_2_1.isActive or nil) and (var_0_0.CTRL_TALENT_ACTIVE or var_0_0.CTRL_TALENT_UNACTIVE))
end

return PreciousInfoTalentCell
