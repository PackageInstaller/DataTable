local var_0_0 = g.core.model.User.uniteTokenData
local UniteTokenCommon = require("app.view.module.uniteToken.common.UniteTokenCommon")
local UniteTokenTabBaseComp = class("UniteTokenTabBaseComp", require("app.fairyGUI.uniteToken.UI_UniteTokenTabBaseComp"))

function UniteTokenTabBaseComp:ctor()
	self._tokenData = nil
	self._skillInfo = nil

	self:_initBtn()
end

function UniteTokenTabBaseComp:updateShow(arg_2_1)
	self:updateBaseInfo(arg_2_1.tokenData)
end

function UniteTokenTabBaseComp:_initBtn()
	self.m_skillIcon:addClickListener(handler(self, self._onSkillClick))
	self.m_passiveIcon:addClickListener(handler(self, self._onClickPassive))
end

function UniteTokenTabBaseComp:updateBaseInfo(arg_4_1)
	if not arg_4_1 then
		return
	end

	self._tokenData = arg_4_1

	local var_4_0 = var_0_0:getTokenBaseInfo(arg_4_1._baseId).skillInfo

	self._skillInfo = var_4_0

	self.m_skillRangeTxt:setText(g.core.config.skill_range_info.get(var_4_0.cfg.skill_range_info).name)
	UniteTokenCommon.updateBaseInfo(self, arg_4_1)
	self.m_descText:setText(arg_4_1:getCfg().description)

	local var_4_1 = var_0_0:getTokenPassiveInfo(arg_4_1:getAdvanceId(), arg_4_1:getStarLevel())

	self._passiveData = var_4_1

	if var_4_1 then
		self.m_passiveIcon:updateIcon(var_4_1)
		self.m_passiveName:setText(var_4_1.passiveCfg.name)
		self.m_passiveDesc:getChild("title"):enableRich()
		self.m_passiveDesc:setTitle(var_4_1.desc)
		self.m_showPassiveController:setSelectedIndex(1)
	else
		self.m_showPassiveController:setSelectedIndex(0)
	end
end

function UniteTokenTabBaseComp:_onSkillClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.UniteTokenSkillPop").new(self._skillInfo), {
		touchDisappear = true
	})
end

function UniteTokenTabBaseComp:_onClickPassive()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.UniteTokenPassiveSkillPop").new({
		skillData = self._passiveData,
		tokenData = self._tokenData
	}), {
		touchDisappear = true
	})
end

function UniteTokenTabBaseComp:_onSkillPreviewClick()
	UniteTokenCommon.openSkillPreviewPop(self._tokenData)
end

return UniteTokenTabBaseComp
