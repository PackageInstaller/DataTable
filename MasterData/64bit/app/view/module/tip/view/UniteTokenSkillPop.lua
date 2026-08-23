local UniteTokenSkillPop = class("UniteTokenSkillPop", require("app.fairyGUI.tip.UI_UniteTokenSkillPop"), function()
	return fgui.GComponent:create({
		pkgName = "tip",
		resName = "UniteTokenSkillPop"
	})
end)

function UniteTokenSkillPop:ctor(arg_2_1, arg_2_2, arg_2_3)
	self:showAtCenter()

	self._skillData = arg_2_1
	self._tokenData = arg_2_2
	self._isOther = arg_2_3
	self._pos = arg_2_2 and arg_2_2:getPos() or 0

	self.m_unloadBtn:addClickListener(handler(self, self._onClickUnload))
	self.m_changeBtn:addClickListener(handler(self, self._onClickChange))
	self.m_developBtn:addClickListener(handler(self, self._onClickDevelop))
	self:_updateView()
end

function UniteTokenSkillPop:_onItemIniter(arg_3_1, arg_3_2)
	arg_3_2:bindLua("app.view.module.uniteToken.view.component.UniteTokenSkillItemCell")
end

function UniteTokenSkillPop:_updateView()
	self.m_detailComp:updateView(self._skillData, self._tokenData)

	self._level = self._skillData.cfg.level

	self.m_nameTxt:setText(self._skillData.cfg.curtain_name)

	local var_4_0 = g.core.config.skill_range_info.get(self._skillData.cfg.skill_range_info)

	self.m_bgPanel:setQuality(self._skillData.cfg.skill_quality)
	self.m_bgPanel:hideQuality()
	self.m_skillIconComp:updateIcon(self._skillData)
	self.m_coolDownTxt:setText(g.core.lang:get(202517, {
		num = self._skillData.cfg.extra_cost_value
	}))
	self:_updateBuffDesc(self._skillData.skillId)
	self.m_skillCostTxt:setText(self._skillData.cfg.rage_value .. g.core.lang:get(202528))

	if self._pos > 0 and not self._isOther then
		self.m_showBtnController:setSelectedIndex(1)
	else
		self.m_showBtnController:setSelectedIndex(0)
	end

	if self._pos > 0 and not self._isOther then
		self.m_isLineUpController:setSelectedIndex(1)
	else
		self.m_isLineUpController:setSelectedIndex(0)
	end
end

function UniteTokenSkillPop:_onClickUnload()
	if self._pos > 0 then
		g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
			pos = 0,
			tp = 2,
			id = self._tokenData:getAdvanceId()
		})
		g.core.module.ModuleManager:popComponent()
	end
end

function UniteTokenSkillPop:_onClickChange()
	g.core.module.ModuleManager:popComponent()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.formation.view.FormationUniteTokenPop").new({
		pos = self._pos
	}))
end

function UniteTokenSkillPop:_onClickDevelop()
	g.core.module.ModuleManager:popComponent()
	g.core.module.ModuleManager:pushModule(g.view.entrance.UNITE_TOKEN_DEVELOP, {
		tabIndex = 1,
		severId = self._tokenData:getServerId()
	})
end

function UniteTokenSkillPop:_updateBuffDesc(arg_8_1)
	local var_8_0 = g.core.utils.String.formatSkillSplitDesc(arg_8_1)

	if #var_8_0 == 0 or var_8_0 == "0" then
		self.m_buffDescLabel:setVisible(false)
	else
		self.m_buffDescLabel:getChild("title"):enableRich()
		self.m_buffDescLabel:setTitle(var_8_0)
		self.m_buffDescLabel:setVisible(true)
	end
end

return UniteTokenSkillPop
