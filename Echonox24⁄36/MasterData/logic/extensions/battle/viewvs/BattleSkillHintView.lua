-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewvs/BattleSkillHintView.lua

module("logic.extensions.battle.viewvs.BattleSkillHintView", package.seeall)

local BattleSkillHintView = class("BattleSkillHintView", ViewComponent)

function BattleSkillHintView:buildUI()
	self._skillStrengthen1Go = goutil.findChild(self.mainGO, "skillname_mask")
	self._skillStrengthen2Go = goutil.findChild(self.mainGO, "strengthskillname_mask")
	self._txtSkillName1 = goutil.findChildTextComponent(self.mainGO, "skillname_mask/skillName/txtSkillName")
	self._txtSkillName2 = goutil.findChildTextComponent(self.mainGO, "strengthskillname_mask/skillName/txtSkillName")
	self._timelineSkillName = TimelineTask.New()
end

function BattleSkillHintView:destroyUI()
	return
end

function BattleSkillHintView:onEnter()
	self:_playSanityConsumeAnim()
end

function BattleSkillHintView:onExit()
	self._timelineSkillName:clear()
end

function BattleSkillHintView:_playSanityConsumeAnim()
	local params = self:getOpenParam()
	local attackId = params[1]
	local skillId = params[2]
	local isStrenthening = params[3]
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local attacker = unitMgr:getUnit(attackId)

	if not attacker then
		if enableWarnLog then
			BattleLog.warn("The attacker is not exist", attackId)
		end

		ViewMgr.instance:close(ViewName.BattleSkillHint)

		return
	end

	local skillMO = attacker.skill:getActiveSkillById(skillId)
	local skillCOWrapper = skillMO:getSkillCOWrapper()

	self._txtSkillName1.text = skillCOWrapper:getName()
	self._txtSkillName2.text = skillCOWrapper:getName()

	self:_tShowSkillInfo(isStrenthening)
	self._timelineSkillName:clear()
	self._timelineSkillName:addTask(1.8, self._tHideSkillInfo, self)
	self._timelineSkillName:setTimeScale(BattleTime.timeScale)
	self._timelineSkillName:start(isStrenthening)
end

function BattleSkillHintView:_tShowSkillInfo(isStrenthening)
	if not isStrenthening then
		goutil.setActive(self._skillStrengthen1Go, true)
		goutil.setActive(self._skillStrengthen2Go, false)
	else
		CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_battle_lizhi_burst, nil, nil, nil)
		goutil.setActive(self._skillStrengthen1Go, false)
		goutil.setActive(self._skillStrengthen2Go, true)
	end
end

function BattleSkillHintView:_tHideSkillInfo(isStrenthening)
	ViewMgr.instance:close(ViewName.BattleSkillHint)
end

return BattleSkillHintView
