local BaseConst = require("app.view.base.const.BaseConst")
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local BaseSkillIcon = class("BaseSkillIcon", require("app.fairyGUI.base_new.UI_BaseSkillIcon"))
local var_0_3 = {
	PetPassive = 117,
	PetActive = 6,
	KnightPassive = 17,
	PetLink = 113
}
local var_0_4 = {
	2000,
	2001,
	2001,
	nil,
	nil,
	2003,
	nil,
	nil,
	nil,
	nil,
	nil,
	2005,
	[113] = 2004,
	[44] = 2007,
	[117] = 2002,
	[17] = 2002,
	[29] = 2002,
	[32] = 2006
}

function BaseSkillIcon:ctor()
	self._effectNode = nil
	self._skillInfo = {}
	self._orginShowCostIdx = self.m_showUnitCostController:getSelectedIndex()
	self._orginSkillTypeIdx = self.m_skillTypeController:getSelectedIndex()
	self._addClick = false
end

function BaseSkillIcon:updateIcon(arg_2_1, arg_2_2)
	self._skillData = arg_2_1

	if arg_2_1 then
		self.m_isEmptyController:setSelectedIndex(0)

		local var_2_0 = self.m_levelShowTypeController:getSelectedIndex() == 1
		local var_2_1 = self.m_isShowTypeTextController:getSelectedIndex() == 0
		local var_2_2 = arg_2_1.skillId

		if arg_2_1.isPassive then
			var_2_2 = g.core.config.passive_skill_info.get(var_2_2).passive_skill_value
		end

		local var_2_3 = g.core.config.skill_info.get(var_2_2)

		self._skillInfo = var_2_3

		local var_2_4 = g.core.common.Path:getSkillIconById(var_2_3.icon)

		self:setIcon(var_2_4)

		local var_2_5 = self.m_skillTypeController:getSelectedIndex() == 3

		if var_2_5 then
			self.m_iconComp:setIcon(var_2_4)
		end

		if arg_2_1.showName then
			self.m_nameText:setText(var_2_3.curtain_name)
			self.m_isShowNameController:setSelectedIndex(1)
		else
			self.m_isShowNameController:setSelectedIndex(0)
		end

		if not var_2_0 then
			self.m_levelText:setText(var_2_3.level)
		else
			self.m_levelShowTypeController:setSelectedIndex(1)
		end

		if not var_2_1 then
			if var_0_4[var_2_3.skill_type] then
				self.m_skillTypeText:setText(g.core.lang:get(var_0_4[var_2_3.skill_type]))
			elseif var_0_4[arg_2_1.skillType] then
				self.m_skillTypeText:setText(g.core.lang:get(var_0_4[arg_2_1.skillType]))
			else
				self.m_skillTypeText:setText(g.core.lang:get(var_0_4[var_0_3[arg_2_1.skillType]]))
			end
		end

		if not var_2_5 then
			if var_2_3.skill_type == 3 then
				self:setUniteCost(var_2_3.rage_value)
				self.m_skillTypeController:setSelectedIndex(1)
				self.m_iconBg:setScale(1.12)
				self.m_iconBg:setURL(g.core.common.Path:getUniteTokenSkillQualityImg(var_2_3.skill_quality))
			elseif var_2_3.skill_type == 14 or var_2_3.skill_type == 17 then
				self.m_skillTypeController:setSelectedIndex(2)
			elseif var_2_3.skill_type == 30 then
				self.m_skillTypeController:setSelectedIndex(1)
				self.m_iconBg:setScale(1.12)
				self.m_iconBg:setURL(g.core.common.Path:getUniteTokenSkillQualityImg(var_2_3.skill_quality))
			elseif var_2_3.skill_type == 44 then
				self.m_skillTypeController:setSelectedIndex(4)
				self.m_leaderIconComp:setIcon(var_2_4)
			else
				self.m_skillTypeController:setSelectedIndex(0)
			end

			self.m_showUnitCostController:setSelectedIndex(self._orginShowCostIdx)
		end

		self:_judgeSkillExtraState(arg_2_1.skillExtraData)
	else
		arg_2_2 = arg_2_2 or self._orginSkillTypeIdx

		self.m_skillTypeController:setSelectedIndex(arg_2_2)
		self.m_isEmptyController:setSelectedIndex(1)
		self.m_showUnitCostController:setSelectedIndex(0)
	end
end

function BaseSkillIcon:setUniteCost(arg_3_1)
	self.m_costText:setText(arg_3_1)
end

function BaseSkillIcon:setName(arg_4_1)
	self.m_isShowNameController:setSelectedIndex(1)

	arg_4_1 = arg_4_1 or self._skillInfo.curtain_name

	self.m_nameText:setText(arg_4_1)
end

function BaseSkillIcon:setDecorateFrame(arg_5_1)
	if arg_5_1 then
		self.m_decorateFrame:setURL(arg_5_1)
	end
end

function BaseSkillIcon:showIconEffect(arg_6_1)
	self:_deleteEffect()

	local var_6_0 = {
		name = arg_6_1.name,
		isLoop = arg_6_1.isLoop and true or false
	}

	var_6_0.anim = arg_6_1.anim or "play"
	self._effectNode = self.m_bgEffectComp:addEffectSpine(var_6_0)
end

function BaseSkillIcon:_judgeSkillExtraState(arg_7_1)
	if arg_7_1 and arg_7_1.extraType then
		if arg_7_1.extraType == BaseConst.BASE_SKILL_EXTRA_TYPE.ARTIFACT then
			self:setDecorateFrame("bg/artifact/bg_gmwz_skill.png")
			self:showIconEffect({
				isLoop = true,
				name = "eff_ui_artifact_hongdi"
			})

			local var_7_0 = arg_7_1.data

			self.m_isShowStarCompController:setSelectedIndex(arg_7_1.data and 1 or 0)

			if var_7_0 then
				local var_7_1 = var_7_0:getStar()

				if not self._isInitStar then
					self._isInitStar = true

					self.m_starComp:initStar({
						style = 1,
						type = 2,
						index = 9,
						gap = -5,
						max = var_7_0:getMaxStar(),
						num = var_7_1
					})
				end

				if self._isInitStar then
					self.m_starComp:setStarNum(var_7_1)
				end
			end
		end
	else
		self:setDecorateFrame("")
		self.m_isShowStarCompController:setSelectedIndex(0)
		self:_deleteEffect()
	end
end

function BaseSkillIcon:_deleteEffect()
	if self._effectNode then
		self._effectNode:removeFromParent()

		self._effectNode = nil
	end
end

function BaseSkillIcon:openClick()
	if not self._addClick then
		self:addClickListener(handler(self, self._onClick))
		self:setTouchable(true)
	end

	self._addClick = true
end

function BaseSkillIcon:_onClick()
	if not self._skillData then
		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.KnightSkillDescTip").new(self._skillData), {
		touchDisappear = true
	})
end

return BaseSkillIcon
