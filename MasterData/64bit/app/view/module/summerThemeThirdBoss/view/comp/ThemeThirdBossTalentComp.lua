local var_0_0 = g.core.common.Path
local ThemeThirdBossTalentComp = class("ThemeThirdBossTalentComp", require("app.fairyGUI.summerThemeThirdBoss.UI_ThemeThirdBossTalentComp"))

function ThemeThirdBossTalentComp:ctor()
	self._talentId = 0
	self._talentStruct = nil
	self._selectEffect = nil
	self._bigNodeEffect = nil
end

function ThemeThirdBossTalentComp:setClickState(arg_2_1)
	self.m_isSelectedController:setSelectedIndex(arg_2_1 and 1 or 0)
	self:updateSelectEffect(arg_2_1)
end

function ThemeThirdBossTalentComp:getNextLineWidth()
	return self._talentStruct:getNextLineWidth()
end

function ThemeThirdBossTalentComp:getNextLineWidth()
	return self._talentStruct:getNextLineWidth()
end

function ThemeThirdBossTalentComp:showActiveEff()
	self.m_eff:addEffectSpine({
		anim = "play2",
		name = "eff_ui_summerThemeThirdBoss_talent",
		remove = true,
		isLoop = false
	})
end

function ThemeThirdBossTalentComp:_activeEffectEnd(arg_6_1)
	return
end

function ThemeThirdBossTalentComp:updateCompByStruct(arg_7_1, arg_7_2)
	self._talentId = arg_7_1:getId()
	self._talentStruct = arg_7_1

	if arg_7_2 then
		self:setClickState(arg_7_2 == self._talentId)
	end

	self:_updateIcon()
	self:updateActive()
end

function ThemeThirdBossTalentComp:refreshComp()
	if self._talentStruct then
		self:updateCompByStruct(self._talentStruct)
	end
end

function ThemeThirdBossTalentComp:_updateIcon()
	local var_9_0 = self._talentStruct:getInfo().pot_type
	local var_9_1 = self._talentStruct:getInfo().pot_icon
	local var_9_2 = ""

	if var_9_0 == 1 then
		var_9_2 = var_0_0:getAttrIconByName(var_9_1)
	elseif var_9_0 == 2 then
		var_9_2 = var_0_0:getAttrIconByName(var_9_1)
	elseif var_9_0 == 3 then
		var_9_2 = var_0_0:getTalentIcon(var_9_1)
	end

	self.m_icon:setURL(var_9_2)
	self.m_talentTypeController:setSelectedIndex(var_9_0 - 1)
end

function ThemeThirdBossTalentComp:updateSelectEffect(arg_10_1)
	if arg_10_1 then
		self._selectEffect = self._selectEffect or self.m_eff:addEffectSpine({
			name = "eff_ui_summerThemeThirdBoss_talent",
			anim = "play",
			isLoop = true
		})

		self._selectEffect:setVisible(true)
	elseif self._selectEffect then
		self._selectEffect:setVisible(false)
	end
end

function ThemeThirdBossTalentComp:getId()
	return self._talentId
end

function ThemeThirdBossTalentComp:updateActive(arg_12_1)
	self.m_isActiveController:setSelectedIndex((arg_12_1 == nil and self._talentStruct or nil) and self._talentStruct:isActive() and 1 or 0)
end

return ThemeThirdBossTalentComp
