local var_0_0 = g.core.config.talent_skill_info
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.model.User.petsData
local PetAdvanceComp = class("PetAdvanceComp", require("app.fairyGUI.pet.UI_PetAdvanceComp"))

function PetAdvanceComp:ctor()
	self._petStruct = nil
	self._matItemArr = {}
	self._promoteCode = nil
	self._promoteLevel = nil
	self._advInfo = nil

	self.m_advBtn:addClickListener(handler(self, self._onClickAdvBtn))
	self.m_talentTitleLbl:addClickListener(handler(self, self._onClickViewTalentTitle))
	self.m_talentTitleLbl2:addClickListener(handler(self, self._onClickViewBaseAttrTitle))
	self.m_talentTitleLbl3:addClickListener(handler(self, self._onClickViewBaseAttrTitle))
	self.m_viewTalentTitleLbl:addClickListener(handler(self, self._onClickViewTalentTitle))
	self.m_skillIcon_1:addClickListener(handler(self, self._onClickSkillIcon))
	self.m_skillIcon_2:addClickListener(handler(self, self._onClickSkillIcon))
	self.m_fullSkillIcon:addClickListener(handler(self, self._onClickSkillIcon))
	self.m_matList:setVirtual()
	self.m_matList:setItemRenderer(handler(self, self._onMatListRenderer))
	self.m_matList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickMatListItem))
end

function PetAdvanceComp:_onMatListRenderer(arg_2_1, arg_2_2)
	local var_2_0 = self._matItemArr[arg_2_1 + 1]

	var_2_0.scaleIndex = 3

	arg_2_2:updateIcon(var_2_0)
	arg_2_2:setCompGray(var_2_0.size < var_2_0.numCost)
end

function PetAdvanceComp:_onClickMatListItem(arg_3_1)
	self:_openGotoPop(arg_3_1:getDataValue() + 1)
end

function PetAdvanceComp:updateView(arg_4_1)
	self._petStruct = var_0_3:getPetBySid(arg_4_1.data.sid)
	self._matItemArr = self._petStruct:getMaterialArrNeededForAdv()

	self:_updateView()
end

function PetAdvanceComp:_updateView(arg_5_1)
	if not self._petStruct then
		return
	end

	local var_5_0 = self._petStruct
	local var_5_1 = self._petStruct:getAdvCfg()

	if self._petStruct:isFullStage() then
		self.m_fullStageController:setSelectedIndex(1)

		local var_5_2 = var_5_0:getPassiveSkillId()

		self.m_fullSkillIcon:updateIcon({
			isPassive = true,
			skillId = var_5_2
		})
		self.m_fullSkillDescLbl:getChild("title"):enableRich()
		self.m_fullSkillDescLbl:setTitle((g.core.utils.String.formatPassiveSkillDesc(var_5_2)))
	else
		self.m_fullStageController:setSelectedIndex(0)

		local var_5_3 = var_5_0:getNextBigStageAdvCfg()

		self.m_talentTitleLbl:setText((g.core.lang:get(203002, {
			name = var_0_0.get(var_5_3.talent_skill_1).name
		})))

		local var_5_4 = var_5_0:getPassiveSkillId()

		self.m_skillIcon_1:setGrayed(var_5_1.skill_1 == 0)
		self.m_skillIcon_1:updateIcon({
			isPassive = true,
			skillId = var_5_4
		})
		self.m_skillIcon_2:updateIcon({
			isPassive = true,
			skillId = var_5_3.skill_1
		})
		self.m_matList:setNumItems(#self._matItemArr)
		self.m_passiveChangeController:setSelectedIndex(var_5_4 ~= var_5_3.skill_1 and 1 or 0)
	end

	self.m_progComp:updateComp(var_5_0, arg_5_1)
end

function PetAdvanceComp:_onClickAdvBtn()
	if not self._petStruct then
		return
	end

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_1.FUNCTION_TYPE.PET_ADVANCE) then
		return
	end

	local var_6_0 = self:_getLackItemIdx()

	if var_6_0 > 0 then
		self:_openGotoPop(var_6_0)
	else
		local var_6_1 = self._petStruct:getNextStageAdvCfg()
		local var_6_2 = {}

		var_6_2.id = self._petStruct:getSid()
		var_6_2.next_stage = var_6_1.stage
		var_6_2.next_node = var_6_1.node

		g.core.network.GameNetProxy:send_C2S_Pet_StageUp(var_6_2)
	end
end

function PetAdvanceComp:_onClickViewTalentTitle()
	if not self._petStruct then
		return
	end

	var_0_2:pushPopup(require("app.view.module.tip.view.PetTalentTip").new(self._petStruct), {
		touchDisappear = true
	})
end

function PetAdvanceComp:_onClickViewBaseAttrTitle()
	if not self._petStruct then
		return
	end

	var_0_2:pushPopup(require("app.view.module.pet.view.infoPop.PetAdvanceAttrUpPop").new(self._petStruct), {
		touchDisappear = true
	})
end

function PetAdvanceComp:_onClickSkillIcon(arg_9_1)
	local var_9_0 = arg_9_1:getSender()
	local var_9_1 = self._petStruct:getBigSmallStage()
	local var_9_2 = self._petStruct:getAdvCfg().skill_1
	local var_9_3, var_9_4

	if var_9_0 == self.m_skillIcon_1 then
		var_9_2 = self._petStruct:getPassiveSkillId()
	elseif var_9_0 == self.m_skillIcon_2 then
		var_9_2 = self._petStruct:getNextBigStageAdvCfg().skill_1
		var_9_1 = var_9_1 + 1
		var_9_3 = require("app.view.module.tip.view.PetSkillDescTip").new
		var_9_4 = {
			isPassive = true,
			skillType = 117
		}
	end

	var_9_4.petAdvId = self._petStruct:getAdvanceId()
	var_9_4.skillId = var_9_2
	var_9_4.stage = var_9_1

	var_0_2:pushPopup(require("app.view.module.tip.view.PetSkillDescTip").new(var_9_4), {
		touchDisappear = true
	})
end

function PetAdvanceComp:_openGotoPop(arg_10_1)
	g.view.entrance.ModuleGotoProxy:gotoModuleBySource((clone(self._matItemArr[arg_10_1])))
end

function PetAdvanceComp:_getLackItemIdx()
	for iter_11_0, iter_11_1 in ipairs(self._matItemArr) do
		if iter_11_1.size < iter_11_1.numCost then
			return iter_11_0
		end
	end

	return 0
end

function PetAdvanceComp:onS2CPetStageUp()
	if not self._petStruct then
		return
	end

	self._matItemArr = self._petStruct:getMaterialArrNeededForAdv()

	self.m_progComp:playAniBigStageUp()
	self:_updateView()
end

function PetAdvanceComp:onS2CPetSmallNodeUp()
	if not self._petStruct then
		return
	end

	self._matItemArr = self._petStruct:getMaterialArrNeededForAdv()

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = g.core.const.ConstMgr.BaseShowTypeConst.KNIGHT_ADVANCE
		}
	})
	self:_updateView(true)
end

return PetAdvanceComp
