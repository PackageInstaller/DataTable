local KnightInfoPopInfoComp = class("KnightInfoPopInfoComp", require("app.fairyGUI.knight.UI_KnightInfoPopInfoComp"))
local KnightSkillDescTip = require("app.view.module.tip.view.KnightSkillDescTip")
local var_0_2 = g.core.module.ModuleManager
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = g.core.const.ConstMgr.QUALITY_TYPE

function KnightInfoPopInfoComp:ctor()
	self._baseInfo = nil
	self._skillTips = {}

	self.m_skill1:addClickListener(handler(self, self._onSkill1Click))
	self.m_skill2:addClickListener(handler(self, self._onSkill2click))
	self.m_skill3:addClickListener(handler(self, self._onSkill3Click))
	self.m_skill4:addClickListener(handler(self, self._onSkill4Click))
	self.m_leaderSkillIcon:openClick()
end

function KnightInfoPopInfoComp:_onSkill1Click()
	var_0_2:pushPopup(KnightSkillDescTip.new(self._skillTips[1]), {
		touchDisappear = true
	})
end

function KnightInfoPopInfoComp:_onSkill2click()
	var_0_2:pushPopup(KnightSkillDescTip.new(self._skillTips[2]), {
		touchDisappear = true
	})
end

function KnightInfoPopInfoComp:_onSkill3Click()
	var_0_2:pushPopup(KnightSkillDescTip.new(self._skillTips[3]), {
		touchDisappear = true
	})
end

function KnightInfoPopInfoComp:_onSkill4Click()
	var_0_2:pushPopup(KnightSkillDescTip.new(self._skillTips[4]), {
		touchDisappear = true
	})
end

function KnightInfoPopInfoComp:updateShow(arg_6_1, arg_6_2)
	self._baseInfo = arg_6_1:getBaseInfo()

	self.m_featureText:setText(self._baseInfo.feature)

	for iter_6_0, iter_6_1 in ipairs((arg_6_1:getBaseAttrs())) do
		self["m_attr" .. iter_6_0]:updateAttr(iter_6_1)
	end

	self.m_groupLoader:setURL((g.core.common.Path:getCampURL(self._baseInfo.group, 2)))
	self:_updateSkills(arg_6_1)

	local var_6_0 = var_0_4:getAssistantTalent(arg_6_1)

	if next(var_6_0) then
		for iter_6_2, iter_6_3 in ipairs(var_6_0) do
			iter_6_3.isActive = true

			if self["m_talentSkill" .. iter_6_2] then
				self["m_talentSkill" .. iter_6_2]:updateStarTalentIcon(nil, iter_6_3)
			end
		end

		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)
	end

	self.m_descText:setText(self._baseInfo.description, true)
	self.m_professionIcon:setURL(g.core.common.Path:getKnightProfessionAndDamageTypeIcon(arg_6_1:getProfession(), (arg_6_1:getDamage())))
	self.m_professionTxt:setText(arg_6_1:getProfessionTxt())

	local var_6_1 = arg_6_1:isElementLeader()

	self.m_leaderSkillIcon:setVisible(var_6_1)

	if var_6_1 and self._baseInfo.army_skill_id > 0 then
		self.m_leaderSkillIcon:updateIcon({
			isPassive = false,
			skillType = 44,
			isActive = true,
			skillId = self._baseInfo.army_skill_id,
			star = self._baseInfo.star,
			knightAdvId = self._baseInfo.advance_id
		})
	end

	if arg_6_2.isOther then
		if g.core.common.ModuleUnlock:getModuleUnlockLevel(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_LINEUP) <= g.core.model.User.playerInfoData:getPassDungeonChapter() then
			self.m_equipTreasureComp:updateOtherComp(arg_6_2.knightPos, arg_6_1)
			self.m_showETController:setSelectedIndex(1)
		end
	else
		self.m_showETController:setSelectedIndex(0)
	end
end

function KnightInfoPopInfoComp:clickTalentSkill()
	return
end

function KnightInfoPopInfoComp:_updateSkills(arg_8_1)
	if not self._baseInfo or not arg_8_1 then
		self.m_skillNumController:setSelectedIndex(0)

		return
	end

	self._skillTips = {}

	if self._baseInfo.quality >= var_0_5.UR then
		table.insert(self._skillTips, {
			skillId = self._baseInfo.common_id,
			star = self._baseInfo.star,
			knightAdvId = self._baseInfo.advance_id
		})
		table.insert(self._skillTips, {
			skillId = self._baseInfo.active_skill_id,
			star = self._baseInfo.star,
			knightAdvId = self._baseInfo.advance_id
		})

		if self._baseInfo.energy_skill_id then
			table.insert(self._skillTips, {
				skillId = self._baseInfo.energy_skill_id,
				star = self._baseInfo.star,
				knightAdvId = self._baseInfo.advance_id
			})
		end

		local var_8_0 = arg_8_1:getAdvancedPassiveList()

		if var_8_0.id > 0 then
			table.insert(self._skillTips, {
				isPassive = true,
				skillId = var_8_0.id,
				isActive = var_8_0.isActive,
				star = self._baseInfo.star,
				knightAdvId = self._baseInfo.advance_id
			})
		end
	else
		table.insert(self._skillTips, {
			skillId = self._baseInfo.common_id,
			star = self._baseInfo.star,
			knightAdvId = self._baseInfo.advance_id
		})
		table.insert(self._skillTips, {
			skillId = self._baseInfo.active_skill_id,
			star = self._baseInfo.star,
			knightAdvId = self._baseInfo.advance_id
		})

		local var_8_1 = arg_8_1:getPassiveList()

		if var_8_1.id > 0 then
			self._skillTip3 = {
				isPassive = true,
				skillId = var_8_1.id,
				isActive = var_8_1.isActive,
				isOwn = arg_8_1:isOwn(),
				knightAdvId = self._baseInfo.advance_id
			}

			table.insert(self._skillTips, self._skillTip3)
		else
			self._skillTip3 = nil
		end
	end

	self.m_skillNumController:setSelectedIndex(#self._skillTips)

	for iter_8_0 = 1, #self._skillTips do
		self["m_skill" .. iter_8_0]:updateIcon(self._skillTips[iter_8_0])
	end
end

return KnightInfoPopInfoComp
