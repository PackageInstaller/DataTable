local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_2 = g.core.model.User.petsData
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.module.ModuleManager
local LineUpPetInfoComp = class("LineUpPetInfoComp", require("app.fairyGUI.lineUp.UI_LineUpPetInfoComp"))

function LineUpPetInfoComp:ctor()
	self._pos = 1
	self._petSid = 0
	self._showTipIndex = 0

	self.m_level:enableRich()
	self.m_bgLoader:setURL("pic/base_new/bg_yht_rightdi.png")
	self.m_developBtn:addClickListener(handler(self, self._onClickDevelopBtn))
	self.m_changePetBtn:addClickListener(handler(self, self._onClickChangePetBtn))
	self.m_skillIcon_1:addClickListener(handler(self, self._onSkillClick))
	self.m_skillIcon_2:addClickListener(handler(self, self._onSkillClick))
end

function LineUpPetInfoComp:updateComp(arg_2_1, arg_2_2)
	self._pos = arg_2_1
	self._petSid = arg_2_2

	local var_2_0 = var_0_2:getPetBySid(arg_2_2)
	local var_2_1 = var_2_0:getCfg()
	local var_2_2 = var_2_0:getLevel()

	if var_2_2 < 10 then
		var_2_2 = g.core.lang:get(201026, {
			level = var_2_2
		})
	elseif var_2_2 < 100 then
		var_2_2 = g.core.lang:get(201027, {
			level = var_2_2
		})
	end

	self.m_level:setText(var_2_2)

	if g.core.model.User:getMaxLevel() <= var_2_0:getLevel() then
		self.m_maxLevel:setText("Max")
		self.m_maxLevel:setVisible(true)
	else
		self.m_maxLevel:setVisible(false)
	end

	self.m_skillIcon_1:updateIcon({
		isPassive = true,
		skillType = "PetActive",
		skillId = var_2_1.passive_skill_1
	})

	local var_2_3 = var_2_0:getPassiveSkillId()

	self.m_skillIcon_2:setGrayed(var_2_0:getAdvCfg().skill_1 == 0)
	self.m_skillIcon_2:updateIcon({
		isPassive = true,
		skillType = "PetPassive",
		skillId = var_2_3
	})

	if g.core.common.ModuleUnlock:isModuleShow(var_0_1.EQUIP_LINEUP_PET) then
		self.m_showEquipCompController:setSelectedIndex(1)
		self.m_equipComp:updateComp(arg_2_1, arg_2_2)
	else
		self.m_showEquipCompController:setSelectedIndex(0)
	end

	self.m_developBtn:setRedPointId(378)
	var_0_3:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_developBtn,
		customData = {
			advId = var_2_0:getAdvanceId()
		}
	})
end

function LineUpPetInfoComp:_onClickDevelopBtn()
	self:dispatchCompEvent("COMP_EVENT_ENTER_DEVELOP_LAYER")
	var_0_4:pushModule(g.view.entrance.PET_DEVELOP, {
		onlyLineup = true,
		petSid = self._petSid
	})
end

function LineUpPetInfoComp:_onClickChangePetBtn()
	var_0_4:pushModule(g.view.entrance.LINE_UP_CHOOSE_PET, {
		pos = self._pos,
		petSid = self._petSid
	})
end

function LineUpPetInfoComp:_onSkillClick(arg_5_1)
	local var_5_0 = arg_5_1:getSender()
	local var_5_1 = var_0_2:getPetBySid(self._petSid)
	local var_5_2
	local var_5_4 = var_5_1:getCfg()
	local var_5_5

	if var_5_0 == self.m_skillIcon_1 then
		var_5_2 = var_5_4.passive_skill_1
		var_5_5 = 6
	elseif var_5_0 == self.m_skillIcon_2 then
		var_5_2 = var_5_1:getPassiveSkillId()
		var_5_5 = 117
	else
		var_5_2 = var_5_4.link_passive_skill_1
		var_5_5 = 113
	end

	local var_5_7 = var_0_2:getPetBySid(self._petSid)

	var_0_4:pushPopup((var_5_5 == 113 and require("app.view.module.tip.view.PetLinkSkillDescTip") or require("app.view.module.tip.view.PetSkillDescTip")).new({
		skillType = 117,
		isPassive = true,
		petAdvId = var_5_7:getAdvanceId(),
		skillId = var_5_2,
		star = var_5_4.star
	}), {
		touchDisappear = true,
		hideContinue = true
	})
end

function LineUpPetInfoComp:showEnterCutTransition()
	self.m_enter_cutTransition:play()
end

function LineUpPetInfoComp:showEnterTransition()
	self.m_enterTransition:play()
end

function LineUpPetInfoComp:onUnload()
	var_0_3:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return LineUpPetInfoComp
