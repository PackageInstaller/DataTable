local KnightStarUpComp = class("KnightStarUpComp", require("app.fairyGUI.knight.UI_KnightStarUpComp"))
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.config.talent_skill_info
local var_0_3 = g.core.config.knight_info
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_6 = g.core.const.ConstMgr.KNIGHT_CONST

function KnightStarUpComp:ctor()
	self._SKILL_NUM = 3
	self._knight = nil
	self._changeTalentTip = false
	self._skillData = {}

	self:_addListener()
end

function KnightStarUpComp:_addListener()
	self.m_valueDescText:addClickListener(handler(self, self._onClickValueDesc))
	self.m_skillDescText:addClickListener(handler(self, self._onClickSkillDesc))
	self.m_skill1:addClickListener(handler(self, self._onSkill1Click))
	self.m_skill2:addClickListener(handler(self, self._onSkill2Click))
end

function KnightStarUpComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_STARINCREASE, handler(self, self._onKnightStarUp), self)
end

function KnightStarUpComp:updateView(arg_4_1)
	local var_4_0

	if arg_4_1 then
		var_4_0 = arg_4_1.data.knight
		self._knight = arg_4_1.data.knight
	else
		var_4_0 = self._knight
	end

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0:getBaseInfo()
	local var_4_2 = {}

	self._skillData = {}

	local var_4_3 = var_4_0:isMaxStar()
	local var_4_4 = var_4_0:getStarLv()

	self:_setQualityController((var_4_0:getQuality()))

	local var_4_5 = var_4_1.advance_id

	var_4_2 = var_4_1.next_star_id > 0 and var_0_3.get(var_4_1.next_star_id) or var_4_1

	local var_4_7 = var_4_2["star_talent_" .. var_4_2.star]

	if var_4_3 then
		self.m_enterTransition = self.m_enter_1Transition

		self.m_levelText:setText(var_4_4)
	else
		self.m_enterTransition = self.m_enter_0Transition

		self.m_levelText:setText(var_4_4 .. "    " .. var_4_4 + 1)
	end

	local var_4_8 = var_4_0:getBaseInfo()

	self.m_mrTips:setVisible(false)

	if var_4_8.token_value ~= 0 and not var_4_3 then
		self.m_mrTips:setVisible(true)
		self.m_mrTips:setText(g.core.lang:get(201122, {
			name = g.core.common.Goods:convert({
				type = g.core.common.Goods.TYPE_ITEM,
				value = var_4_8.token_value
			}).name,
			num = var_4_8.token_num
		}))
	end

	if var_4_8.quality <= var_0_5.SSR then
		if not var_4_3 then
			self.m_isMaxController:setSelectedIndex(0)

			if var_4_7 > 0 then
				self.m_valueDescText:setTitle(g.core.lang:get(201012))

				local var_4_9 = var_0_2.get(var_4_7)

				self.m_skillDescText:setTitle(g.core.lang:get(201004, {
					name = var_4_9.name
				}) .. " " .. var_4_9.description)
			end

			if var_4_8.active_skill_id ~= var_4_2.active_skill_id and var_4_2.shield_active ~= 1 then
				table.insert(self._skillData, {
					skillId = var_4_2.active_skill_id,
					skillTip = {
						skillId = var_4_2.active_skill_id,
						star = var_4_8.star + 1,
						knightAdvId = var_4_8.advance_id
					}
				})
			elseif var_4_8.common_id ~= var_4_2.common_id and var_4_2.shield_common ~= 1 then
				table.insert(self._skillData, {
					skillId = var_4_2.common_id,
					skillTip = {
						skillId = var_4_2.common_id,
						star = var_4_8.star + 1,
						knightAdvId = var_4_8.advance_id
					}
				})
			end
		else
			self.m_isMaxController:setSelectedIndex(1)
			self.m_valueDescText:setTitle(g.core.lang:get(201013))
			self.m_skillDescText:setTitle(g.core.lang:get(201014))
			table.insert(self._skillData, {
				skillId = var_4_8.common_id,
				skillTip = {
					skillId = var_4_8.common_id,
					star = var_4_8.star,
					knightAdvId = var_4_8.advance_id
				}
			})
			table.insert(self._skillData, {
				skillId = var_4_8.active_skill_id,
				skillTip = {
					skillId = var_4_8.active_skill_id,
					star = var_4_8.star,
					knightAdvId = var_4_8.advance_id
				}
			})
		end

		if var_4_3 then
			self.m_skill1:updateIcon(self._skillData[1])
			self.m_skill2:updateIcon(self._skillData[2])

			local var_4_10 = var_0_1:getMaxAssistantTalent(var_4_0)

			if var_4_10 then
				self.m_talentSkillIcon:updateKnightAdvExIcon(var_4_0, var_4_10.talentSkillCfg)
			else
				self.m_talentSkillIcon:setEmpty()
			end
		else
			self.m_skill2:updateIcon(self._skillData[1])
			self.m_baseSkillName:setText(g.core.lang:get(201029, {
				name = g.core.config.skill_info.get(self._skillData[1].skillId).curtain_name
			}))
		end

		if var_4_2 and var_4_2.star_talent_extra and var_4_2.star_talent_extra ~= 0 then
			local var_4_11 = g.core.config.talent_skill_info.get(var_4_2.star_talent_extra)

			self.m_talentSkillIcon:updateKnightAdvExIcon(var_4_0, var_4_11)
			self.m_talentSkillName:setText(g.core.lang:get(201029, {
				name = var_4_11.name
			}))
			self.m_talentSkillDesc:setText(var_4_11.description)
		elseif not var_4_3 then
			self.m_isMaxController:setSelectedIndex(2)
		end
	elseif var_4_8.quality >= var_0_5.UR then
		local var_4_12 = {}

		if var_4_3 then
			table.insert(var_4_12, {
				isPassive = false,
				isActive = true,
				skillId = var_4_8.common_id,
				star = var_4_4,
				knightAdvId = var_4_5
			})
			table.insert(var_4_12, {
				isPassive = false,
				isActive = true,
				skillId = var_4_8.active_skill_id,
				star = var_4_4,
				knightAdvId = var_4_5
			})
			table.insert(var_4_12, {
				isPassive = false,
				isActive = true,
				skillId = var_4_8.energy_skill_id,
				star = var_4_4,
				knightAdvId = var_4_5
			})

			local var_4_13 = var_4_0:getAdvancedPassiveList()

			if var_4_13.id > 0 then
				table.insert(var_4_12, {
					isPassive = true,
					skillId = var_4_13.id,
					isActive = var_4_13.isActive,
					star = var_4_4,
					knightAdvId = var_4_5
				})
			end
		else
			if var_4_2 and var_4_2.common_id ~= var_4_8.common_id then
				table.insert(var_4_12, {
					isPassive = false,
					isActive = true,
					skillId = var_4_2.common_id,
					star = var_4_2.star,
					knightAdvId = var_4_5
				})
			end

			if var_4_2 and var_4_2.active_skill_id ~= var_4_8.active_skill_id then
				table.insert(var_4_12, {
					isPassive = false,
					isActive = true,
					skillId = var_4_2.active_skill_id,
					star = var_4_2.star,
					knightAdvId = var_4_5
				})
			end

			if var_4_2 and var_4_2.energy_skill_id ~= var_4_8.energy_skill_id then
				table.insert(var_4_12, {
					isPassive = false,
					isActive = true,
					skillId = var_4_2.energy_skill_id,
					star = var_4_2.star,
					knightAdvId = var_4_5
				})
			end

			if var_4_2 and var_4_2.advanced_passive_skill_id_1 ~= var_4_8.advanced_passive_skill_id_1 then
				if var_4_2.advanced_passive_skill_id_1 > 0 then
					table.insert(var_4_12, {
						isPassive = true,
						isActive = true,
						skillId = var_4_2.advanced_passive_skill_id_1,
						star = var_4_2.star,
						knightAdvId = var_4_5
					})
				end
			end
		end

		local var_4_14

		if var_4_3 then
			var_4_14 = var_0_6.SKILL_STATE.IS_MAX or var_0_6.SKILL_STATE.NO_TALENT
		end

		local var_4_15 = var_4_2.star_talent_extra or 0

		self.m_isMaxController:setSelectedIndex((var_4_15 > 0 or nil) and (var_4_3 and var_0_6.SKILL_STATE.IS_MAX or var_0_6.SKILL_STATE.NOT_MAX))
		self.m_urSkillComp:updateView(var_4_12, var_4_7, var_4_0, var_4_15)
	end

	self.m_knightFragComp:updateComp(var_4_0)
end

function KnightStarUpComp:_onClickValueDesc()
	local KnightBaseAttrUpTip = require("app.view.module.tip.view.KnightBaseAttrUpTip")

	var_0_4:pushPopup(KnightBaseAttrUpTip.new({
		knightSid = self._knight:getServerId(),
		type = KnightBaseAttrUpTip.ATTR_UP_STATE.STAR_UP
	}), {
		touchDisappear = true
	})
end

function KnightStarUpComp:_onClickSkillDesc()
	var_0_4:pushPopup(require("app.view.module.tip.view.KnightTalentTip").new({
		knightSid = self._knight:getServerId(),
		type = g.core.const.ConstMgr.TipConst.KnightTipType.STAR
	}), {
		touchDisappear = true
	})
end

function KnightStarUpComp:_onSkill1Click(arg_7_1)
	var_0_4:pushPopup(require("app.view.module.tip.view.KnightSkillDescTip").new(self._skillData[1].skillTip), {
		touchDisappear = true
	})
end

function KnightStarUpComp:_onSkill2Click(arg_8_1)
	var_0_4:pushPopup(require("app.view.module.tip.view.KnightSkillDescTip").new((self._skillData[2] or self._skillData[1]).skillTip), {
		touchDisappear = true
	})
end

function KnightStarUpComp:_onKnightStarUp(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_9_4.awards)
	end

	self:updateView()
	self:dispatchCompEvent("lock_switch", {
		isLock = false
	})
end

function KnightStarUpComp:_setQualityController(arg_10_1)
	if arg_10_1 < var_0_5.UR then
		self.m_qualityRangeController:setSelectedIndex(0)
	elseif arg_10_1 >= var_0_5.UR then
		self.m_qualityRangeController:setSelectedIndex(1)
	end
end

return KnightStarUpComp
