local KnightInfoComp = class("KnightInfoComp", require("app.fairyGUI.knight.UI_KnightInfoComp"))
local var_0_1 = g.core.config.knight_level_info
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_ONEKEY_LEVELUP
local var_0_4 = g.core.common.ModuleUnlock
local var_0_5 = g.core.model.User.formationData
local var_0_6 = g.core.module.ModuleManager
local var_0_7 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_8 = g.core.model.User.knightsData
local var_0_9 = g.core.common.Path
local var_0_10 = g.core.const.ConstMgr.QUALITY_TYPE

function KnightInfoComp:ctor()
	self._knight = nil
	self._data = {}
	self._isMax = false
	self._curLevel = 0
	self._updateLevelUpComp = false

	self.m_level:enableRich()
	self.m_leaderSkillIcon:openClick()
	self:_addListener()
end

function KnightInfoComp:_addListener()
	self.m_addBtn:addClickListener(handler(self, self._onAddClick))
	self.m_attrComp:addClickListener(handler(self, self._onHelpClick))
	self.m_assctTitle:addClickListener(handler(self, self._onAssctClick))
	self.m_assctComp:addClickListener(handler(self, self._onAssctClick))
end

function KnightInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CHANGE_KNIGHT, self._onKnightChange, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_UPGRADE, handler(self, self._onKnightLvUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_UPGRADEONELEVEL, handler(self, self._onKnightLvUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_ONEKEY_UPGRADE, handler(self, self._onKnightLvUp), self)

	self._updateLevelUpComp = true
end

function KnightInfoComp:updateView(arg_4_1)
	local var_4_0

	if arg_4_1 then
		var_4_0 = arg_4_1.data or {}
	end

	local var_4_1 = var_4_0.knight

	if var_4_0.knight then
		self._knight = var_4_1
		self._curLevel = var_4_1:getLevel()
	else
		var_4_1 = self._knight
	end

	if not var_4_1 then
		return
	end

	local var_4_2 = var_4_1:getBaseInfo()
	local var_4_3 = var_4_1:getInfo()
	local var_4_4 = var_0_1.get(var_4_2.level_exp_id, var_4_3.level)

	self._data.isLineup = var_4_1:isLineup()
	self._isMax = var_4_1:isMaxLevel()

	self.m_isMaxController:setSelectedIndex(var_4_1:isMaxLevel() and 1 or 0)
	self.m_groupLoader:setURL(var_0_9:getCampURL(var_4_1:getGroup(), 1))

	local var_4_5 = var_4_1:getLevel()
	local var_4_6 = ""

	if var_4_5 < 10 then
		var_4_6 = "00"
	elseif var_4_5 < 100 then
		var_4_6 = "0"
	end

	self.m_level:setText(var_4_5)
	self.m_subLevel:setText(var_4_6)
	self.m_maxLevel:setText((var_4_1:getMaxLevel() > var_4_1:getLevel() or nil) and (g.core.lang:get(201028, {
		num = g.core.model.User:getLevel()
	}) or g.core.lang:get(112201)))
	self.m_expProgBar:setPercent({
		init = 0,
		cur = var_4_3.exp,
		max = var_4_4.next_exp
	})
	self.m_attrComp:updateComp(var_4_1:getBaseAttrs(), var_4_1:isLineup())

	local var_4_7 = var_4_1:getQuality()
	local var_4_8 = {}
	local var_4_9 = var_4_2.advance_id
	local var_4_10 = var_4_2.star

	if var_4_7 <= var_0_10.SSR then
		var_4_8[1] = {
			isActive = true,
			isPassive = false,
			skillId = var_4_2.common_id,
			star = var_4_10,
			knightAdvId = var_4_9
		}
		var_4_8[2] = {
			isActive = true,
			isPassive = false,
			skillId = var_4_2.active_skill_id,
			star = var_4_10,
			knightAdvId = var_4_9
		}

		local var_4_11 = var_4_1:getPassiveList()

		if var_4_11.id > 0 then
			var_4_8[3] = {
				isPassive = true,
				skillId = var_4_11.id,
				isActive = var_4_11.isActive,
				star = var_4_10,
				knightAdvId = var_4_9
			}
		end
	elseif var_4_7 >= var_0_10.UR then
		var_4_8[1] = {
			isActive = true,
			isPassive = false,
			skillId = var_4_2.common_id,
			star = var_4_10,
			knightAdvId = var_4_9
		}
		var_4_8[2] = {
			isActive = true,
			isPassive = false,
			skillId = var_4_2.active_skill_id,
			star = var_4_10,
			knightAdvId = var_4_9
		}

		if var_4_2.energy_skill_id then
			table.insert(var_4_8, {
				isActive = true,
				isPassive = false,
				skillId = var_4_2.energy_skill_id,
				star = var_4_10,
				knightAdvId = var_4_9
			})
		end

		local var_4_12 = var_4_1:getAdvancedPassiveList()

		if var_4_12.id > 0 then
			table.insert(var_4_8, {
				isPassive = true,
				skillId = var_4_12.id,
				isActive = var_4_12.isActive,
				star = var_4_10,
				knightAdvId = var_4_9
			})
		end
	end

	self.m_skillsComp:updateView(var_4_8)

	local var_4_13, var_4_14 = var_0_5:generateAssDataAndActiveAssCountByKnight(var_4_1)

	self.m_assctComp:initStar({
		style = 2,
		index = 1,
		num = var_4_14,
		max = math.min(#var_4_13, var_0_7.ASSCT_ACTIVE_MAX)
	})
	self.m_assctComp:addStarEffect(var_4_14, {
		isLoop = true,
		scale = 1,
		name = "eff_ui_lineup_bind"
	})

	self._updateLevelUpComp = true

	if var_4_1:isLineup() and not self._isMax then
		self:newScheduleOnce(handler(self, self._showLineUpComp), 0.1)
	elseif self._isMax and self.m_stateController:getSelectedIndex() == 1 then
		self:_hideLineUpComp()
	end

	self.m_professionIcon:setURL(var_0_9:getKnightProfessionAndDamageTypeIcon(var_4_2.profession, var_4_2.attack_type))
	self.m_professionTxt:setText(var_4_1:getProfessionTxt())

	if var_4_1:getQuality() > 2 then
		local var_4_15 = var_0_8:getAssistantTalent(var_4_1)

		if next(var_4_15) then
			for iter_4_0, iter_4_1 in ipairs(var_4_15) do
				if self["m_talentSkill" .. iter_4_0] then
					self["m_talentSkill" .. iter_4_0]:updateStarTalentIcon(var_4_1, iter_4_1)
				end
			end

			self.m_hasExSkillController:setSelectedIndex(0)
		else
			self.m_hasExSkillController:setSelectedIndex(1)
		end
	else
		self.m_hasExSkillController:setSelectedIndex(1)
	end

	local var_4_16 = var_4_1:isElementLeader()

	self.m_leaderSkillIcon:setVisible(var_4_16)

	if var_4_16 and var_4_2.army_skill_id > 0 then
		self.m_leaderSkillIcon:updateIcon({
			skillType = 44,
			isActive = true,
			isPassive = false,
			skillId = var_4_2.army_skill_id,
			star = var_4_10,
			knightAdvId = var_4_9
		})
	end
end

function KnightInfoComp:receiveTouchBegin(arg_5_1)
	local var_5_0 = arg_5_1:getInput():getTouch():getLocation()

	if not self.m_levelUpComp:containPoint(var_5_0) and not self.m_addBtn:containPoint(var_5_0) then
		self:_hideLineUpComp()
	end
end

function KnightInfoComp:_onAddClick()
	if var_0_4:isModuleUnlock(var_0_3) then
		if self.m_stateController:getSelectedIndex() == 0 and not self._isMax and self._knight then
			self:_showLineUpComp()
		else
			self:_hideLineUpComp()
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201009))
	end
end

function KnightInfoComp:_showLineUpComp()
	if self._updateLevelUpComp then
		self.m_levelUpComp:updateView({
			knight = self._knight
		})

		self._updateLevelUpComp = false
	end

	self.m_stateController:setSelectedIndex(1)
end

function KnightInfoComp:_hideLineUpComp()
	self.m_levelUpComp.m_backTransition:play(handler(self, function()
		self.m_stateController:setSelectedIndex(0)
	end))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.LEVEL_SHOW_CLOSE)
end

function KnightInfoComp:_onHelpClick()
	var_0_6:pushPopup(require("app.view.module.tip.view.KnightAttrTip").new({
		knightSid = self._knight:getServerId()
	}), {
		touchDisappear = true
	})
end

function KnightInfoComp:_onAssctClick()
	var_0_6:pushPopup(require("app.view.module.tip.view.KnightAssctTip").new({
		knightSid = self._knight:getServerId()
	}), {
		touchDisappear = true
	})
end

function KnightInfoComp:_onKnightChange()
	self:updateView()
end

function KnightInfoComp:_onKnightLvUp()
	if self._curLevel < self._knight:getLevel() then
		self._curLevel = self._knight:getLevel()

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			baseShowPop = {
				type = g.core.const.ConstMgr.BaseShowTypeConst.KNIGHT_LEVEL_UP
			}
		})
	end

	if self.m_stateController:getSelectedIndex() == 1 then
		self.m_levelUpComp:updateView()
	end
end

return KnightInfoComp
