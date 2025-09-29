-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattleViewMgr.lua

module("logic.battle.battleflow.component.BattleViewMgr", package.seeall)

local BattleViewMgr = class("BattleViewMgr", IBattleFlowComp)

function BattleViewMgr:onResourceLoaded()
	if enableDebug then
		ViewMgr.instance:close(ViewName.HackToolView)
		ViewMgr.instance:close(ViewName.BattleTest)
	end

	ViewMgr.instance:open(ViewName.BattleSideHintViewPresentor)
	ViewMgr.instance:open(ViewName.BattleTagSideHintViewPresentor)
	ViewMgr.instance:open(ViewName.BattleDamageHintView)
	ViewMgr.instance:openSpecialView(ViewName.BattleBossPropertyView)
	ViewMgr.instance:openSpecialView(ViewName.BattleRoundReport)
	ScenePickerViewFacade.instance:open(BattleConst.DefaultStateKey)
	ViewMgr.instance:openSpecialView(ViewName.BattleMain)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Main, false)
	self:_bindEvents()
end

function BattleViewMgr:onClear(isRestart)
	self:_unbindEvents()
	BattleViewStateModel.instance:clear()
	ScenePickerViewFacade.instance:close(BattleConst.DefaultStateKey)
	ViewMgr.instance:close(ViewName.BattleMain)
	ViewMgr.instance:close(ViewName.BattleRoundReport)
	ViewMgr.instance:close(ViewName.BattleBossPropertyView)
	ViewMgr.instance:close(ViewName.BattleVs)
	ViewMgr.instance:close(ViewName.BattleCampAdjustment)
	ViewMgr.instance:close(ViewName.BattleFullScreenWarnViewPresentor)
	ViewMgr.instance:close(ViewName.BattleSettingViewPresentor)
	ViewMgr.instance:close(ViewName.BattleSideHintViewPresentor)
	ViewMgr.instance:close(ViewName.BattleTagSideHintViewPresentor)
	ViewMgr.instance:close(ViewName.BattleSkillHint)
	ViewMgr.instance:close(ViewName.BattleDamageHintView)
	ViewMgr.instance:destroy(ViewName.BattleSideHintViewPresentor)
	ViewMgr.instance:destroy(ViewName.BattleMain)
	ViewMgr.instance:destroy(ViewName.BattleRoundReport)
	ViewMgr.instance:destroy(ViewName.BattleBossPropertyView)
end

function BattleViewMgr:clearForExit()
	ViewMgr.instance:close(ViewName.BattleMain)
	ViewMgr.instance:close(ViewName.BattleVs)
	ViewMgr.instance:close(ViewName.BattleCampAdjustment)
	ViewMgr.instance:close(ViewName.BattleFullScreenWarnViewPresentor)
	ViewMgr.instance:close(ViewName.BattleSettingViewPresentor)
	ViewMgr.instance:close(ViewName.ToolTipsSkillDetailViewPresentor)
	ViewMgr.instance:close(ViewName.ToolTipsCharacterSkillDetailViewPresentor)
	ViewMgr.instance:close(ViewName.ToolTipsBattleBuffViewPresentor)
	ViewMgr.instance:close(ViewName.BattleSkillHint)
	ViewMgr.instance:close(ViewName.BattleRoundReport)
	ViewMgr.instance:close(ViewName.BattleBossPropertyView)
end

function BattleViewMgr:_bindEvents()
	BattleDispatcher:addEventListener(BattleEventType.PlaySanityConsumeAnim, self._playSanityConsumeAnim, self)
end

function BattleViewMgr:_unbindEvents()
	BattleDispatcher:removeEventListener(BattleEventType.PlaySanityConsumeAnim, self._playSanityConsumeAnim, self)
end

function BattleViewMgr:_playSanityConsumeAnim(_, attackInfo)
	local attacker = attackInfo:getAttacker()
	local attackerId = attacker.property:getEntityId()
	local skillId = attackInfo:getSkillId()
	local isStrengthen = attackInfo:isStrengthening()

	if not isStrengthen and not ViewMgr.instance:isOpen(ViewName.BattleSkillHint) then
		ViewMgr.instance:open(ViewName.BattleSkillHint, attackerId, skillId, isStrengthen)
	end
end

function BattleViewMgr:onReturnScene()
	ViewMgr.instance:_openPreFullUpView()
end

return BattleViewMgr
