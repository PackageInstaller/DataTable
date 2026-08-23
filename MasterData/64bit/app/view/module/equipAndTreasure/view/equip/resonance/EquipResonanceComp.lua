local var_0_0 = g.core.config.equipment_resonance_info
local var_0_1 = g.core.config.talent_skill_info
local var_0_2 = g.core.model.User.equipmentData
local EquipResonanceComp = class("EquipResonanceComp", require("app.fairyGUI.equipAndTreasure.UI_EquipResonanceComp"))

function EquipResonanceComp:ctor()
	self:addListen(self.m_talentComp)
	self:addListen(self.m_resonanceComp)
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onSelfTouchEnd))
end

function EquipResonanceComp:receiveCompEvent(arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or {}

	if arg_2_1 == "EquipResonance_selectMaterial" then
		self:_updateLevelChange(arg_2_2.predictLevel, arg_2_2.predictExp)
	elseif arg_2_1 == "EquipResonance_talentSkill" then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.EquipResonanceSkillPop").new({
			equipId = self._equipId,
			curLevel = self._equip:getResonanceLevel()
		})))
	end
end

function EquipResonanceComp:updateView(arg_3_1)
	arg_3_1 = arg_3_1 or {}

	if arg_3_1.data then
		self._equip = arg_3_1.data
	end

	if not self._equip then
		return
	end

	self._equipId = self._equip:getCfg().id
	self._maxLevel = var_0_2:getMaxResonanceInfo(self._equipId).level
	self._curLevel = self._equip:getResonanceLevel()
	self._curExp = self._equip:getResonanceExp()
	self._isMaxLevel = self._curLevel == self._maxLevel

	self:_updateLevelComp()
	self:_updateStrengthComp()
	self:_updateTalentComp()
	self:_updateResonanceComp()
end

function EquipResonanceComp:_updateLevelChange(arg_4_1, arg_4_2)
	if arg_4_1 > self._equip:getResonanceLevel() then
		arg_4_2 = self._nextResonanceInfo.exp + arg_4_2
	end

	self.m_expValueTxt:setText(g.core.lang:get(201607, {
		num = arg_4_2,
		max = self._nextResonanceInfo.exp
	}))
	self.m_expProgBar:setPreviewEnable(true)
	self.m_expProgBar:setPreviewPercent(arg_4_2 * 100 / self._nextResonanceInfo.exp)
end

function EquipResonanceComp:_updateLevelComp()
	local var_5_0 = self._equip:getResonanceLevel()

	self._isMaxLevel = var_5_0 == self._maxLevel

	self.m_levelupComp:updateLevelupComp({
		fromLevel = var_5_0,
		toLevel = var_5_0 + 1,
		hideNext = self._isMaxLevel
	})

	local var_5_1 = self._equip:getResonanceExp()
	local var_5_2 = self._equip:getCfg().resonance_id
	local var_5_3 = self._isMaxLevel and var_0_0.get(var_5_2, var_5_0) or var_0_0.get(var_5_2, var_5_0 + 1)

	self._nextResonanceInfo = var_5_3

	local var_5_4 = var_5_3.exp

	if self._isMaxLevel then
		self.m_expValueTxt:setText(g.core.lang:get(201617))
	else
		self.m_expValueTxt:setText(g.core.lang:get(201607, {
			num = var_5_1,
			max = var_5_4
		}))
	end

	self.m_expProgBar:setPercent({
		value = self._isMaxLevel and var_5_4 or var_5_1,
		max = var_5_4
	})
	self.m_expProgBar:setPreviewEnable(false)
	self.m_expProgBar:setPreviewPercent(0)
end

function EquipResonanceComp:_updateStrengthComp()
	self.m_strengthComp:setItemData((self._equip:getCurResonanceAttrData(not self._isMaxLevel)))
end

function EquipResonanceComp:_updateTalentComp()
	if self._nextResonanceInfo then
		self.m_talentComp:update({
			talentName = var_0_1.get(self._nextResonanceInfo.talent_skill).name
		})
	end
end

function EquipResonanceComp:_updateResonanceComp()
	local var_8_0 = self._equip:getResonanceLevel()

	self._isMaxLevel = var_8_0 == self._maxLevel

	if self._isMaxLevel then
		self.m_resonanceComp:setCtrlState("uplimited", {
			index = 1
		})
	else
		self.m_resonanceComp:setCtrlState("uplimited", {
			index = 0
		})
		self.m_resonanceComp:updateMaterial({
			materials = var_0_2:getEquipResonanceMaterials(var_0_0.get(self._equip:getCfg().resonance_id, var_8_0 + 1).cost),
			equip = self._equip
		})
	end
end

function EquipResonanceComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_RESONANCE_UP, handler(self, self._onRcvResonanceUp), self)
end

function EquipResonanceComp:onUnload()
	return
end

function EquipResonanceComp:_onRcvResonanceUp(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if self._curLevel < arg_11_4.level and arg_11_4.level > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
			data = {
				beforeAttr = self._equip:getResonanceAttrDataBySetting(self._curLevel, self._curExp),
				afterAttr = self._equip:getResonanceAttrDataBySetting(arg_11_4.level, arg_11_4.exp),
				beforeLevel = self._curLevel,
				afterLevel = arg_11_4.level,
				talentSkillInfo = var_0_1.get(var_0_0.get(self._equip:getCfg().resonance_id, arg_11_4.level).talent_skill)
			},
			title = g.core.lang:get(201610),
			showComp = fgui.UIPackage:createObject("equipAndTreasure", "EquipResonanceUpComp")
		}), {
			hideContinue = false,
			touchDisappear = true
		})
	end

	self:updateView()
end

function EquipResonanceComp:resetMaterialSelect()
	self.m_resonanceComp:materialReset()
	self:_updateLevelComp()
end

function EquipResonanceComp:_onSelfTouchEnd(arg_13_1)
	local var_13_0 = arg_13_1:getInput():getTouch():getLocation()

	if var_13_0 and not self.m_resonanceComp:containPoint(var_13_0) then
		self:resetMaterialSelect()
	end
end

return EquipResonanceComp
