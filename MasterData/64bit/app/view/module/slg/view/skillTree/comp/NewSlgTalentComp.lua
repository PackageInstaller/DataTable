local var_0_0 = g.core.common.Path
local ThemeThirdBossTalentComp = class("ThemeThirdBossTalentComp", require("app.fairyGUI.newSlg.UI_NewSlgTalentComp"))

function ThemeThirdBossTalentComp:ctor()
	self._talentId = 0
	self._talentStruct = nil
	self._selectEffect = nil
	self._bigNodeEffect = nil

	if g.core.guide.GuideProxy:isGuideRunning() then
		self:getChild("n0"):addClickListener(handler(self, self._onGuideClick))
	end
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
		isLoop = false,
		remove = true,
		name = "eff_ui_newSlgSkillTree_active",
		eventHandler = handler(self, self.nodeEffectEnd)
	})
end

function ThemeThirdBossTalentComp:playUnlockAnim()
	if self._talentStruct:isCanActive() and g.core.model.User.newSlgSkillTreeData:isTalentNeedPlayUnlock(self._talentStruct:getId()) then
		self.m_eff:addEffectSpine({
			isLoop = false,
			remove = true,
			name = "eff_ui_newSlgSkillTree_unlock",
			eventHandler = handler(self, self.nodeEffectEnd)
		})

		return true
	end

	return false
end

function ThemeThirdBossTalentComp:nodeEffectEnd(arg_7_1)
	if arg_7_1.eventData and arg_7_1.eventData.name == "cut" then
		self:updateActive()
	end
end

function ThemeThirdBossTalentComp:_onGuideClick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.SLG_TALENT_GUIDE_CLICK, false, self._talentStruct)
end

function ThemeThirdBossTalentComp:updateCompByStruct(arg_9_1, arg_9_2)
	self._talentId = arg_9_1:getId()
	self._talentStruct = arg_9_1

	if arg_9_2 then
		self:setClickState(arg_9_2 == self._talentId)
	end

	self:_updateIcon()

	if not self:playUnlockAnim() then
		self:updateActive()
	else
		self.m_isActiveController:setSelectedIndex(2)
	end
end

function ThemeThirdBossTalentComp:refreshComp()
	if self._talentStruct then
		self:updateCompByStruct(self._talentStruct)
	end
end

function ThemeThirdBossTalentComp:_updateIcon()
	self.m_icon:setURL((var_0_0:getNewSlgSkillIconByName(self._talentStruct:getInfo().pot_icon)))
	self.m_talentTypeController:setSelectedIndex(self._talentStruct:getInfo().pot_type - 1)
end

function ThemeThirdBossTalentComp:updateSelectEffect(arg_12_1)
	if arg_12_1 then
		self._selectEffect = self._selectEffect or self.m_effDi:addEffectSpine({
			isLoop = true,
			anim = "play",
			name = "eff_ui_newSlgSkillTree_select"
		})

		self._selectEffect:setVisible(true)
	elseif self._selectEffect then
		self._selectEffect:setVisible(false)
	end
end

function ThemeThirdBossTalentComp:getId()
	return self._talentId
end

function ThemeThirdBossTalentComp:updateActive(arg_14_1)
	local var_14_0 = arg_14_1

	if arg_14_1 == nil and self._talentStruct then
		var_14_0 = self._talentStruct:isActive()
	end

	if not self._talentStruct:isCanActive() then
		self.m_isActiveController:setSelectedIndex(2)

		local var_14_1 = self._talentStruct:getInfo()
		local var_14_2 = self._talentStruct:getParentList()

		if #var_14_2 > 0 then
			local var_14_3 = true

			for iter_14_0, iter_14_1 in ipairs(var_14_2) do
				local var_14_4 = iter_14_1:getInfo()

				if var_14_4.unlock_type == var_14_1.unlock_type and var_14_4.unlock_value_2 == var_14_1.unlock_value_2 then
					var_14_3 = false
				end
			end

			if var_14_3 then
				self.m_descStr:setText(g.core.lang:getByString(var_14_1.unlock_des, {
					num = var_14_1.unlock_value_2
				}))
			else
				self.m_descStr:setText("")
			end
		end
	else
		self.m_isActiveController:setSelectedIndex(var_14_0 and 1 or 0)
		self.m_descStr:setText("")
	end
end

return ThemeThirdBossTalentComp
