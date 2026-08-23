local var_0_0 = g.core.model.User.domainData
local var_0_1 = g.core.const.ConstMgr.DomainConst
local DonmainStageComp = class("DonmainStageComp", require("app.fairyGUI.domainDungeon.UI_DonmainStageComp"))

function DonmainStageComp:ctor()
	self._loopEff = nil

	self:addClickListener(handler(self, self._onClickStage))
end

function DonmainStageComp:updateStageComp(arg_2_1, arg_2_2)
	self._stageId = arg_2_2
	self._stageStruct = arg_2_1:getStage(arg_2_2)

	self.m_selectLoader:setURL(var_0_0:getDungeonResource(arg_2_1:getId(), "tab_mnly_guanqia2.png"))

	self._curStage, self._curGrade = arg_2_1:getCurStageAndGrade()

	self.m_stageTxt:setText(g.core.utils.Number.getFormatNum(2, arg_2_2))
	self:updateGradeIcon(arg_2_1, arg_2_2)

	self._stageState = self._stageStruct:getStageState()

	self.m_stateController:setSelectedIndex(self._stageState)

	self._loopEff = self._loopEff or self.m_loopEff:addEffectSpine({
		isLoop = true,
		anim = "loop",
		name = "eff_ui_domainDungeon_tablight_" .. arg_2_1:getId()
	})
end

function DonmainStageComp:updateGradeIcon(arg_3_1, arg_3_2)
	if arg_3_2 < self._curStage then
		self.m_gradeLoader:setURL("ui://domainDungeon/pic_mnly_" .. g.core.const.ConstMgr.DomainConst.GRADE.S)
	elseif self._curStage == arg_3_2 or self._curGrade > 0 then
		self.m_gradeLoader:setURL("ui://domainDungeon/pic_mnly_" .. self._curGrade)
	else
		self.m_gradeLoader:setURL("")
	end
end

function DonmainStageComp:setStateCtrl(arg_4_1)
	self.m_stateController:setSelectedIndex(arg_4_1)
end

function DonmainStageComp:setSelected(arg_5_1)
	self.m_isSelectController:setSelectedIndex(arg_5_1 and 1 or 0)
end

function DonmainStageComp:getGradeEffComp()
	return self.m_gradeEff
end

function DonmainStageComp:getUnlockEffComp()
	return self.m_unlockEff
end

function DonmainStageComp:_onClickStage()
	if self._stageState ~= var_0_1.STAGE_STATE.LOCK then
		self:dispatchCompEvent("CLICK_DOMAIN_STAGE", {
			stageId = self._stageId
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(433156))
	end
end

return DonmainStageComp
