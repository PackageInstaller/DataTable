-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewvs/BattleVsView.lua

module("logic.extensions.battle.viewvs.BattleVsView", package.seeall)

local BattleVsView = class("BattleVsView", ViewComponent)
local kRightDirectionShift = 100
local kAttackSign2Name = {
	[BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DOUBLE] = "leftDoubleHit",
	[BattleEnum.AttackingDirection.ATTACKING_DIRECTION_CHASE] = "leftPursuitHit",
	[BattleEnum.AttackingDirection.ATTACKING_DIRECTION_PRIORITY_COUNTER] = "leftPriorityHit",
	[BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DISTANCE_COUNTER] = "leftLongHit",
	[kRightDirectionShift + BattleEnum.AttackingDirection.WEAK_POINT_BROKEN] = "jiaozheng",
	[kRightDirectionShift + BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DOUBLE] = "rightDoubleHit",
	[kRightDirectionShift + BattleEnum.AttackingDirection.ATTACKING_DIRECTION_CHASE] = "rightPursuitHit",
	[kRightDirectionShift + BattleEnum.AttackingDirection.ATTACKING_DIRECTION_PRIORITY_COUNTER] = "rightPriorityHit",
	[kRightDirectionShift + BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DISTANCE_COUNTER] = "rightLongHit"
}

function BattleVsView:buildUI()
	self._leftUnitInfo = BattleVsUnitInfoView.New(goutil.findChild(self.mainGO, "heroLifebar"))
	self._rightUnitInfo = BattleVsUnitInfoView.New(goutil.findChild(self.mainGO, "enemyLifebar"))
	self._goStatusHint = goutil.findChild(self.mainGO, "battle_status_hint")
	self._statusAnimation = self._goStatusHint:GetComponent(typeof(Astral.GUITimelineAniLua))
	self._goSkillInfo = goutil.findChild(self.mainGO, "sanity_consume_process_copy")
	self._skillStrengthen1Go = goutil.findChild(self.mainGO, "sanity_consume_process_copy/skillname_mask")
	self._skillStrengthen2Go = goutil.findChild(self.mainGO, "sanity_consume_process_copy/strengthskillname_mask")
	self._txtSkillName1 = goutil.findChildTextComponent(self.mainGO, "sanity_consume_process_copy/skillname_mask/skillName/txtSkillName")
	self._txtSkillName2 = goutil.findChildTextComponent(self.mainGO, "sanity_consume_process_copy/strengthskillname_mask/skillName/txtSkillName")
	self._attackSignplayerDirector = goutil.addComponentOnce(self._goStatusHint, ComponentType.PlayableDirector)
	self._goAttackSignList = {}
	self._statusTimeWaiter = TimeWaiter.New()
	self._timelineSkillName = TimelineTask.New()
	self._goAttackSignList[BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DOUBLE] = goutil.findChild(self._goStatusHint, "leftDoubleHit")
	self._goAttackSignList[BattleEnum.AttackingDirection.ATTACKING_DIRECTION_CHASE] = goutil.findChild(self._goStatusHint, "leftPursuitHit")
	self._goAttackSignList[BattleEnum.AttackingDirection.ATTACKING_DIRECTION_PRIORITY_COUNTER] = goutil.findChild(self._goStatusHint, "leftPriorityHit")
	self._goAttackSignList[BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DISTANCE_COUNTER] = goutil.findChild(self._goStatusHint, "leftLongHit")
	self._goAttackSignList[kRightDirectionShift + BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DOUBLE] = goutil.findChild(self._goStatusHint, "rightDoubleHit")
	self._goAttackSignList[kRightDirectionShift + BattleEnum.AttackingDirection.ATTACKING_DIRECTION_CHASE] = goutil.findChild(self._goStatusHint, "rightPursuitHit")
	self._goAttackSignList[kRightDirectionShift + BattleEnum.AttackingDirection.ATTACKING_DIRECTION_PRIORITY_COUNTER] = goutil.findChild(self._goStatusHint, "rightPriorityHit")
	self._goAttackSignList[kRightDirectionShift + BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DISTANCE_COUNTER] = goutil.findChild(self._goStatusHint, "rightLongHit")
	self._goAttackSignList[kRightDirectionShift + BattleEnum.AttackingDirection.WEAK_POINT_BROKEN] = goutil.findChild(self._goStatusHint, "jiaozheng")

	self:_hideAttackSignBubble()
	self:_clearSkillInfoTask()
end

function BattleVsView:destroyUI()
	self._leftUnitInfo:destroy()
	self._rightUnitInfo:destroy()
	self._statusTimeWaiter:destroy()
	self._timelineSkillName:clear()

	self._leftUnitInfo = nil
	self._rightUnitInfo = nil
	self._goStatusHint = nil
	self._goSkillInfo = nil
	self._txtSkillName = nil
	self._goAttackSignList = nil
end

function BattleVsView:onEnter()
	self:_setEvent(true)

	local isSoloPerformance = self:getFirstParam() and true or false

	self._leftUnitInfo:setVisible(not isSoloPerformance)
	self._rightUnitInfo:setVisible(not isSoloPerformance)
end

function BattleVsView:onExit()
	self:_setEvent(false)
	self:_hideAttackSignBubble()
	self:_clearSkillInfoTask()
end

function BattleVsView:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_UPDATE_VS_VIEW_INFO, self._onUpdateVsViewInfo, self)
		BattleDispatcher:addEventListener(BattleEventType.ON_SHOW_ATTACK_SIGN, self._onShowAttackSign, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_UPDATE_VS_VIEW_INFO, self._onUpdateVsViewInfo, self)
		BattleDispatcher:removeEventListener(BattleEventType.ON_SHOW_ATTACK_SIGN, self._onShowAttackSign, self)
	end
end

function BattleVsView:_onUpdateVsViewInfo(e, isInit, leftUnit, rightUnit, attackInfo)
	if isInit then
		self._leftUnitInfo:setUnit(leftUnit)
		self._rightUnitInfo:setUnit(rightUnit)
	else
		self._leftUnitInfo:updateUnit(leftUnit, attackInfo)
		self._rightUnitInfo:updateUnit(rightUnit, attackInfo)
	end
end

function BattleVsView:_onShowAttackSign(e, isAtLeft, attackSign)
	self:_hideAttackSignBubble()
	self:_showAttackSignBubble(isAtLeft, attackSign)
end

function BattleVsView:_showAttackSignBubble(isAtLeft, attackSign)
	local attackSignKey = (isAtLeft and 0 or kRightDirectionShift) + attackSign

	for k, go in pairs(self._goAttackSignList) do
		goutil.setActive(go, k == attackSignKey)
	end

	goutil.setActive(self._goStatusHint, true)
	self._statusAnimation:StopTimelineAni()
	self._statusAnimation:PlayAniByName(kAttackSign2Name[attackSignKey])
	self._attackSignplayerDirector:SetPlaySpeed(BattleTime.timeScale)
end

function BattleVsView:_hideAttackSignBubble()
	goutil.setActive(self._goStatusHint, false)
	self._statusTimeWaiter:clear()
end

function BattleVsView:_clearSkillInfoTask()
	self._timelineSkillName:clear()
	goutil.setActive(self._goSkillInfo, false)
end

return BattleVsView
