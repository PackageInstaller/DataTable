local var_0_0 = g.core.module.ModuleManager
local var_0_2 = g.core.model.User.knightsData
local var_0_3 = g.core.config.talent_skill_info
local KnightStarUpSkillsComp = class("KnightStarUpSkillsComp", require("app.fairyGUI.knight.UI_KnightStarUpSkillsComp"))

function KnightStarUpSkillsComp:ctor()
	self._skillTips = {}
	self._knight = nil

	self:_addListeners()
end

function KnightStarUpSkillsComp:_addListeners()
	self.m_valueDescText:addClickListener(handler(self, self._onClickValueDesc))
	self.m_skillDescText:addClickListener(handler(self, self._onClickSkillDesc))
	self.m_skillIcon1:addClickListener(handler(self, self._onSkill1Click))
	self.m_skillIcon2:addClickListener(handler(self, self._onSkill2Click))
	self.m_skillIcon3:addClickListener(handler(self, self._onSkill3Click))
	self.m_skillIcon4:addClickListener(handler(self, self._onSkill4Click))
end

function KnightStarUpSkillsComp:updateView(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self._knight = arg_3_3
	self._skillTips = arg_3_1

	local var_3_0 = self._knight:isMaxStar()

	self.m_isMaxController:setSelectedIndex(var_3_0 and 1 or 0)

	if var_3_0 then
		for iter_3_0 = 1, 4 do
			self["m_skillIcon" .. iter_3_0]:setVisible(checkbool(arg_3_1[iter_3_0]))

			if arg_3_1[iter_3_0] then
				self["m_skillIcon" .. iter_3_0]:updateIcon(arg_3_1[iter_3_0])
			end
		end

		local var_3_1 = var_0_2:getMaxAssistantTalent(arg_3_3)

		if var_3_1 then
			self.m_maxTalentSkillIcon:updateKnightAdvExIcon(arg_3_3, var_3_1.talentSkillCfg)
		else
			self.m_maxTalentSkillIcon:setEmpty()
		end
	else
		self._skillTips = arg_3_1

		local var_3_2 = #arg_3_1 > 0

		self.m_skillNumController:setSelectedIndex(#arg_3_1)

		for iter_3_1, iter_3_2 in ipairs(arg_3_1) do
			if self["m_skillComp" .. iter_3_1] then
				self["m_skillComp" .. iter_3_1]:updateSkill(iter_3_2)
			end
		end

		local var_3_3 = arg_3_4 and arg_3_4 > 0

		if arg_3_4 and arg_3_4 > 0 then
			local var_3_4 = var_0_3.get(arg_3_4)

			self.m_talentSkillIcon:updateKnightAdvExIcon(arg_3_3, var_3_4)
			self.m_talentSkillName:setText(g.core.lang:get(201029, {
				name = var_3_4.name
			}))
			self.m_talentSkillDesc:setText(var_3_4.description)
		end

		if var_3_2 and var_3_3 then
			self.m_skillTypesController:setSelectedIndex(2)
		elseif var_3_2 then
			self.m_skillTypesController:setSelectedIndex(0)
		elseif var_3_3 then
			self.m_skillTypesController:setSelectedIndex(1)
		end

		if arg_3_2 and arg_3_2 > 0 then
			self.m_valueDescText:setTitle(g.core.lang:get(201012))

			local var_3_5 = var_0_3.get(arg_3_2)

			self.m_skillDescText:setTitle(g.core.lang:get(201004, {
				name = var_3_5.name
			}) .. " " .. var_3_5.description)
		end
	end
end

function KnightStarUpSkillsComp:_onClickValueDesc()
	if not self._knight then
		return
	end

	local KnightBaseAttrUpTip = require("app.view.module.tip.view.KnightBaseAttrUpTip")

	var_0_0:pushPopup(KnightBaseAttrUpTip.new({
		knightSid = self._knight:getServerId(),
		type = KnightBaseAttrUpTip.ATTR_UP_STATE.STAR_UP
	}), {
		touchDisappear = true
	})
end

function KnightStarUpSkillsComp:_onClickSkillDesc()
	if not self._knight then
		return
	end

	var_0_0:pushPopup(require("app.view.module.tip.view.KnightTalentTip").new({
		knightSid = self._knight:getServerId(),
		type = g.core.const.ConstMgr.TipConst.KnightTipType.STAR
	}), {
		touchDisappear = true
	})
end

function KnightStarUpSkillsComp:_onSkill1Click()
	self:_popSkillTip(self._skillTips[1])
end

function KnightStarUpSkillsComp:_onSkill2Click()
	self:_popSkillTip(self._skillTips[2])
end

function KnightStarUpSkillsComp:_onSkill3Click()
	self:_popSkillTip(self._skillTips[3])
end

function KnightStarUpSkillsComp:_onSkill4Click()
	self:_popSkillTip(self._skillTips[4])
end

function KnightStarUpSkillsComp:_popSkillTip(arg_10_1)
	if arg_10_1 then
		var_0_0:pushPopup(require("app.view.module.tip.view.KnightSkillDescTip").new(arg_10_1), {
			touchDisappear = true
		})
	else
		dump("skillTip为空！！！")
	end
end

return KnightStarUpSkillsComp
