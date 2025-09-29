-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/BattleMainView.lua

module("logic.extensions.battle.viewmain.BattleMainView", package.seeall)

local BattleMainView = class("BattleMainView", ViewComponent)

function BattleMainView:buildUI()
	self._transform = self.mainGO.transform
	self._hackBtn = self:getBtnByPath("modifyAttr")
	self._guiAnimation = self.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))
	self._timeWaiter = TimeWaiter.New()

	local isHide = HacktoolMo.instance:getHideBtns()

	goutil.setActive(self._hackBtn.gameObject, enableDebug and not isHide)
end

function BattleMainView:destroyUI()
	self._guiAnimation = nil
	self._transform = nil
end

function BattleMainView:bindEvents()
	self._hackBtn:AddClickListener(self._onClickHack, self)
end

function BattleMainView:unbindEvents()
	self._hackBtn:RemoveClickListener()
end

function BattleMainView:onEnter()
	BattleMainViewFacade.instance:registerView(self)
	SpaceX.UIBlurUtils.SetUIBlurEffect(2, 2, false)
	SpaceX.UIBlurUtils.SetBlurArgs(3, 3)
end

function BattleMainView:onExit()
	BattleMainViewFacade.instance:unregisterView()
	self._timeWaiter:clear()
end

function BattleMainView:_onClickHack()
	local unitOperator = BattleMgr.instance:getUnitOperator()

	unitOperator:onTouchEmpty(isDoubleClick)

	local activeFlow = BattleMgr.instance:getActiveBattleFlow()

	activeFlow.forecastMgr:clearCaches()
	ViewMgr.instance:open(ViewName.BattleHackToolView)
end

function BattleMainView:doFadeAnim(isFade)
	local isVisible = BattleViewStateModel.instance:isUIElementVisible(BattleUIElement.Main)

	if not isVisible == isFade then
		return
	end

	self._timeWaiter:clear()
	self._guiAnimation:StopTimelineAni()

	if isFade then
		self._guiAnimation:PlayAniByName("close1")
		self._timeWaiter:start(0.2, self._onFadeOutFinish, self)
	else
		BattleMainViewFacade.instance:setForMainVisible(true)
		self:_setVisible(true)
		self._guiAnimation:PlayAniByName("open1")
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_BATTLE_MAIN_VIEW_FADE, isFade)
end

function BattleMainView:_onFadeOutFinish()
	self:_setVisible(false)
end

function BattleMainView:_setVisible(visible)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Main, visible)
	GlobalDispatcher:dispatchEvent(EventType.ON_BATTLE_MAIN_VIEW_VISIBLE, visible)
end

return BattleMainView
