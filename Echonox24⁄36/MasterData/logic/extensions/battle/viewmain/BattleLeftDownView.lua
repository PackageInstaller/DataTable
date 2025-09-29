-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/BattleLeftDownView.lua

module("logic.extensions.battle.viewmain.BattleLeftDownView", package.seeall)

local BattleLeftDownView = class("BattleLeftDownView", ViewComponent)
local kCloseAnimDuaration = 0.14

function BattleLeftDownView:buildUI()
	self._passHintBtn = Astral.ButtonAdapter.GetFrom(self.mainGO, "btnPassTips")
	self._passHintGo = self:getGoByPath("btnPassTips")

	goutil.setActive(self._passHintGo, false)

	self.mainGO = self:getGoByPath("downHint")
	self._enableState = GameObjectVisibleState.New()
	self._btnPass = Astral.ButtonAdapter.GetFrom(self.mainGO, "btnFinished")
	self._isPlayedAnimation = false
	self._mainAnim = self.mainGO:GetComponent(ComponentType.Animation)
	self._timeWaiter = TimeWaiter.New()
end

function BattleLeftDownView:destroyUI()
	self._btnPass = nil
end

function BattleLeftDownView:bindEvents()
	self._btnPass:AddClickListener(self._onClickPass, self)
	self._passHintBtn:AddClickListener(self._onClickPassHint, self)
end

function BattleLeftDownView:unbindEvents()
	self._btnPass:RemoveClickListener()
	self._passHintBtn:RemoveClickListener()
end

function BattleLeftDownView:onEnter()
	self:_setEvent(true)

	local settingModel = BattleMgr.instance:getSettingModel()

	self:_updateView()
	self:_initPassHint()
end

function BattleLeftDownView:onExit()
	self:_setEvent(false)

	self._showTeaching = false

	self._enableState:clear()
	self._timeWaiter:clear()
end

function BattleLeftDownView:_setEvent(isAdd)
	if isAdd then
		BattleDispatcher:addEventListener(BattleEventType.OnBattleStart, self._onBattleStart, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleStart, self._onBattleStart, self)
	end
end

function BattleLeftDownView:setVisible(visible, key, isImmediately)
	local isPreviewVisible = self._enableState:isEnable()

	self._enableState:setEnable(key, visible)

	local isCurVisible = self._enableState:isEnable()

	if isImmediately then
		AnimationUtils.ResetToLastFrame(self._mainAnim, "battle_main_downhint_open")
		self:_updateVisibleAfterAnim()
	elseif isCurVisible ~= isPreviewVisible then
		self._timeWaiter:clear()

		if isCurVisible then
			goutil.setActive(self.mainGO, isCurVisible)
			self:_updatePassHint()
			self._mainAnim:Stop()
			self._mainAnim:Play("battle_main_downhint_open")
		else
			self._mainAnim:Stop()
			self._mainAnim:Play("battle_main_downhint_close")
			self._timeWaiter:start(kCloseAnimDuaration, self._updateVisibleAfterAnim, self)
		end
	end

	self:_updatePassHint()
end

function BattleLeftDownView:_updateVisibleAfterAnim()
	goutil.setActive(self.mainGO, self._enableState:isEnable())
	self:_updatePassHint()
end

function BattleLeftDownView:_updateView()
	local model = BattleMgr.instance:getModel()

	goutil.setActive(self._btnPass.gameObject, not model:isMultiPlayerMode())
end

function BattleLeftDownView:_onBattleStart()
	return
end

function BattleLeftDownView:_onClickPass()
	local model = BattleMgr.instance:getModel()
	local localLogic = BattleMgr.instance:getLocalLogic()

	if not localLogic:isActiveCampId(model:getOperateCampId()) then
		FloatWordMgr.instance:show(lang("tip_other_team_action"))

		return
	end

	local settingModel = BattleMgr.instance:getSettingModel()

	if settingModel:isAutoBattle() then
		FloatWordMgr.instance:show(lang("tip_battle_in_auto_model"))

		return
	end

	if not self:_hasNextOperatableUnit() then
		self:_onConfirmPassStage()

		return
	end

	local dialog = Dialog.showWarnMessage(lang("tip_end_of_turn"), lang("tip_my_team_not_end"))

	dialog:setConfirmListener(self._onConfirmPassStage, self)
end

function BattleLeftDownView:_hasNextOperatableUnit()
	local campOperator = BattleMgr.instance:getCampOperator()

	return campOperator:hasOperatableUnit()
end

function BattleLeftDownView:_onConfirmPassStage()
	BattleDispatcher:dispatchEvent(BattleEventType.OnBeforeEndStageRequest)

	local releaseSkillAgent = BattleMgr.instance:getReleaseSkillAgent()

	releaseSkillAgent:requestEndStage()
end

function BattleLeftDownView:_onClickPassHint()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
	local teachCO = dungeonMO:geteachingDungeonCO()

	ViewMgr.instance:open(ViewName.TeachPassHintView, teachCO.tipsContent)
end

function BattleLeftDownView:_initPassHint()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if dungeonCode then
		local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)

		if dungeonMO and not dungeonMO:hasPassed() and dungeonMO:getType() == CommEnum.DungeonType.Teaching and DungeonTeachingChapterModel.instance:hasMetPassTipsConditions(dungeonMO) then
			self._showTeaching = true
		else
			self._showTeaching = false
		end
	else
		self._showTeaching = false
	end

	self:_updatePassHint()
end

function BattleLeftDownView:_updatePassHint()
	self:updatePassHintByInfo()
end

function BattleLeftDownView:updatePassHintByInfo()
	local visible = self._enableState:isEnable()

	if not visible and BattleMainViewFacade.instance:getInfoExpand() == false and self._enableState:getCount() == 2 and self._enableState:hasKey("BattleOperatorUnitInfoView") and self._enableState:hasKey("HeroView") then
		visible = true
	end

	goutil.setActive(self._passHintGo, visible and self._showTeaching)
end

return BattleLeftDownView
