local var_0_0 = g.core.model.User.uniteTokenData
local UniteTokenSkillTipsComp = class("UniteTokenSkillTipsComp", require("app.fairyGUI.uniteToken.UI_UniteTokenSkillTipsComp"))

function UniteTokenSkillTipsComp:ctor()
	self._skillList = {}

	self:_initListView()
end

function UniteTokenSkillTipsComp:_initListView()
	self.m_skillList:setIniter()
	self.m_skillList:setItemRenderer(handler(self, self._onRenderTalentList))
end

function UniteTokenSkillTipsComp:_onRenderTalentList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._skillList[arg_3_1 + 1])
end

function UniteTokenSkillTipsComp:updateSkillInfo(arg_4_1, arg_4_2)
	if not arg_4_2 then
		return
	end

	self.m_skillIcon:updateIcon(arg_4_2)
	self.m_nameText:setText(arg_4_2.cfg.curtain_name)
	self.m_roundText:setText(g.core.lang:get(202517, {
		num = arg_4_2.cfg.extra_cost_value
	}))
	self.m_costText:setText(g.core.lang:get(202518, {
		num = arg_4_2.cfg.rage_value
	}))

	self._skillList = var_0_0:getTokenSkillList(arg_4_1, arg_4_2.level)

	self.m_skillList:setNumItems(#self._skillList)
	self.m_skillList:scrollToView(arg_4_2.level - 1)
end

return UniteTokenSkillTipsComp
