local var_0_0 = g.core.module.ModuleManager
local KnightInfoSkillsComp = class("KnightInfoSkillsComp", require("app.fairyGUI.knight.UI_KnightInfoSkillsComp"))

function KnightInfoSkillsComp:ctor()
	self._skillTips = {}

	self:_addListeners()
end

function KnightInfoSkillsComp:_addListeners()
	self.m_skill1:addClickListener(handler(self, self._onSkill1Click))
	self.m_skill2:addClickListener(handler(self, self._onSkill2Click))
	self.m_skill3:addClickListener(handler(self, self._onSkill3Click))
	self.m_skill4:addClickListener(handler(self, self._onSkill4Click))
end

function KnightInfoSkillsComp:updateView(arg_3_1)
	self._skillTips = arg_3_1

	for iter_3_0 = 1, 4 do
		local var_3_0 = self._skillTips[iter_3_0]
		local var_3_1 = self["m_skill" .. iter_3_0]

		if self._skillTips[iter_3_0] and var_3_1 then
			var_3_1:setVisible(true)
			var_3_1:updateIcon(var_3_0)
			var_3_1:setGrayed(not (var_3_0.isActive ~= false))
		elseif var_3_1 then
			var_3_1:setVisible(false)
		end
	end
end

function KnightInfoSkillsComp:_onSkill1Click()
	self:_popSkillTip(self._skillTips[1])
end

function KnightInfoSkillsComp:_onSkill2Click()
	self:_popSkillTip(self._skillTips[2])
end

function KnightInfoSkillsComp:_onSkill3Click()
	self:_popSkillTip(self._skillTips[3])
end

function KnightInfoSkillsComp:_onSkill4Click()
	self:_popSkillTip(self._skillTips[4])
end

function KnightInfoSkillsComp:_popSkillTip(arg_8_1)
	if arg_8_1 then
		var_0_0:pushPopup(require("app.view.module.tip.view.KnightSkillDescTip").new(arg_8_1), {
			touchDisappear = true
		})
	else
		dump("skillTip为空！！！")
	end
end

return KnightInfoSkillsComp
