local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.model.User.petsData
local var_0_2 = g.core.const.ConstMgr.PetConst
local PetStarUpComp = class("PetStarUpComp", require("app.fairyGUI.pet.UI_PetStarUpComp"))

function PetStarUpComp:ctor()
	self._petStruct = nil
	self._changeTalentTip = false
	self._hpAttrList = {}

	self.m_baseAttrUpLbl:addClickListener(handler(self, self._onClickBaseAttrUpLbl))
	self.m_lvUpAttrGrowUpLbl:addClickListener(handler(self, self._onClickLvUpAttrGrowUpLbl))
	self.m_hpAttrGrowUpLbl:addClickListener(handler(self, self._onClickHpAttrGrowUpLbl))
	self.m_curSkillIcon:addClickListener(handler(self, self._onClickSkillIcon))
	self.m_nextSkillIcon:addClickListener(handler(self, self._onClickSkillIcon))
	self.m_fullStarSkillIcon:addClickListener(handler(self, self._onClickSkillIcon))
end

function PetStarUpComp:updateView(arg_2_1)
	local var_2_0 = var_0_1:getPetBySid(arg_2_1.data.sid)

	self._petStruct = var_2_0

	local var_2_1 = var_2_0:getCfg()

	if var_2_0:isMaxStar() then
		self.m_enterTransition = self.m_enter_1Transition

		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FRAGMENT_RECOVERY, nil, true) then
			self.m_fullStarController:setSelectedIndex(1)
		else
			self.m_fullStarController:setSelectedIndex(2)
		end

		self.m_fullStarTxt:setText(var_2_0:getStarNum())
		self.m_fullStarSkillIcon:updateIcon({
			isPassive = true,
			skillId = var_2_1.passive_skill_1
		})
	else
		self.m_enterTransition = self.m_enter_0Transition

		self.m_fullStarController:setSelectedIndex(0)

		local var_2_2 = var_2_0:getStarNum()

		self.m_curStarTxt:setText(var_2_2)
		self.m_nextStarTxt:setText(var_2_2 + 1)
		self.m_curSkillIcon:updateIcon({
			isPassive = true,
			skillId = var_2_1.passive_skill_1
		})
		self.m_nextSkillIcon:updateIcon({
			isPassive = true,
			skillId = var_2_0:getNextStarCfg().passive_skill_1
		})
	end

	self.m_petStarUpFragComp:updateComp(var_2_0)

	self._hpAttrList = var_2_0:getHpAttrList()

	self.m_hpAttrGrowUpLbl:setVisible(#self._hpAttrList > 0)
end

function PetStarUpComp:_onClickBaseAttrUpLbl()
	var_0_0:pushPopup(require("app.view.module.pet.view.infoPop.PetStarAttrPop").new(self._petStruct, var_0_2.ATTR_BASE_POP), {
		touchDisappear = true
	})
end

function PetStarUpComp:_onClickLvUpAttrGrowUpLbl()
	var_0_0:pushPopup(require("app.view.module.pet.view.infoPop.PetStarAttrPop").new(self._petStruct, var_0_2.ATTR_DEV_POP), {
		touchDisappear = true
	})
end

function PetStarUpComp:_onClickHpAttrGrowUpLbl()
	var_0_0:pushPopup(require("app.view.module.pet.view.infoPop.PetStarAttrHpPop").new({
		attrList = self._hpAttrList,
		starNum = self._petStruct:getStarNum()
	}), {
		touchDisappear = true
	})
end

function PetStarUpComp:_onClickSkillIcon(arg_6_1)
	local var_6_0 = self._petStruct:getStarNum()
	local var_6_1 = {
		isPassive = true,
		skillId = 0,
		petAdvId = self._petStruct:getAdvanceId(),
		star = var_6_0
	}
	local var_6_2 = arg_6_1:getSender()

	if var_6_2 == self.m_curSkillIcon then
		var_6_1.skillId = self._petStruct:getCfg().passive_skill_1
	elseif var_6_2 == self.m_nextSkillIcon then
		var_6_1.skillId = self._petStruct:getNextStarCfg().passive_skill_1
		var_6_1.star = var_6_0 + 1
	else
		var_6_1.skillId = self._petStruct:getCfg().passive_skill_1
	end

	var_0_0:pushPopup(require("app.view.module.tip.view.PetSkillDescTip").new(var_6_1), {
		touchDisappear = true
	})
end

return PetStarUpComp
