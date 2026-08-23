local UniteTokenPassiveSkillPop = class("UniteTokenPassiveSkillPop", require("app.fairyGUI.tip.UI_UniteTokenPassiveSkillPop"), function()
	return fgui.GComponent:create({
		resName = "UniteTokenPassiveSkillPop",
		pkgName = "tip"
	})
end)

function UniteTokenPassiveSkillPop:ctor(arg_2_1)
	self:showAtCenter()

	self._skillData = arg_2_1.skillData
	self._tokenData = arg_2_1.tokenData
	self._showStar = arg_2_1.showStar

	self:_updateView()
end

function UniteTokenPassiveSkillPop:_onItemIniter(arg_3_1, arg_3_2)
	arg_3_2:bindLua("app.view.module.uniteToken.view.component.UniteTokenSkillItemCell")
end

function UniteTokenPassiveSkillPop:_updateView()
	self.m_detailComp:updateView(self._skillData, self._tokenData, self._showStar)
	self.m_nameTxt:setText(self._skillData.passiveCfg.name)

	local var_4_0 = g.core.config.skill_info.get(self._skillData.passiveCfg.passive_skill_value)

	self._level = var_4_0.level

	self.m_bgPanel:setQuality(var_4_0.skill_quality)
	self.m_bgPanel:hideQuality()
	self.m_skillIconComp:updateIcon(self._skillData)
	self:_updateBuffDesc(self._skillData.passiveCfg.passive_skill_value)
end

function UniteTokenPassiveSkillPop:_updateBuffDesc(arg_5_1)
	local var_5_0 = g.core.utils.String.formatSkillSplitDesc(arg_5_1)

	if #var_5_0 == 0 or var_5_0 == "0" then
		self.m_buffDescLabel:setVisible(false)
	else
		self.m_buffDescLabel:getChild("title"):enableRich()
		self.m_buffDescLabel:setTitle(var_5_0)
		self.m_buffDescLabel:setVisible(true)
	end
end

return UniteTokenPassiveSkillPop
