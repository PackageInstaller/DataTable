-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewundo/BattleUndoEffectView.lua

module("logic.extensions.battle.viewundo.BattleUndoEffectView", package.seeall)

local BattleUndoEffectView = class("BattleUndoEffectView", ViewComponent)

function BattleUndoEffectView:buildUI()
	self._goEffect = self:_createEffect(BattleResourceName.UIUndoEffect)
	self._goEffectStart = self:_createEffect(BattleResourceName.UIUndoEffectStart)
	self._goEffectEnd = self:_createEffect(BattleResourceName.UIUndoEffectEnd)
	self._timeWaiterEffect = TimeWaiter.New()
end

function BattleUndoEffectView:destroyUI()
	goutil.destroy(self._goEffect)
	goutil.destroy(self._goEffectStart)
	goutil.destroy(self._goEffectEnd)

	self._goEffect = false
	self._goEffectStart = false
	self._goEffectEnd = false
end

function BattleUndoEffectView:onEnter()
	goutil.setActive(self._goEffect, true)
	goutil.setActive(self._goEffectStart, false)
	goutil.setActive(self._goEffectStart, true)
	self._timeWaiterEffect:start(3, self._onOpenEffectEnd, self)
end

function BattleUndoEffectView:onExit()
	self._timeWaiterEffect:clear()
	goutil.setActive(self._goEffect, false)
	goutil.setActive(self._goEffectStart, false)
	goutil.setActive(self._goEffectEnd, false)
	goutil.setActive(self._goEffectEnd, true)
	self._timeWaiterEffect:start(3, self._onCloseEffectEnd, self)
end

function BattleUndoEffectView:onExitFinished()
	self._timeWaiterEffect:clear()
	self:_onCloseEffectEnd()
end

function BattleUndoEffectView:_onOpenEffectEnd()
	goutil.setActive(self._goEffectStart, false)
end

function BattleUndoEffectView:_onCloseEffectEnd()
	goutil.setActive(self._goEffectEnd, false)
end

function BattleUndoEffectView:_createEffect(url)
	local goEffect = self:getResInstance(url)

	goutil.addChildToParent(goEffect, SceneMgr.instance:getSceneRoot())
	goutil.setActive(goEffect, false)

	return goEffect
end

return BattleUndoEffectView
