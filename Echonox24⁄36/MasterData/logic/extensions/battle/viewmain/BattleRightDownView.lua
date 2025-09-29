-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/BattleRightDownView.lua

module("logic.extensions.battle.viewmain.BattleRightDownView", package.seeall)

local BattleRightDownView = class("BattleRightDownView", ViewComponent)

function BattleRightDownView:buildUI()
	self.mainGO = self:getGoByPath("rightDownHint")
	self._goPositionSelectHint = goutil.findChild(self.mainGO, "positionSelectHint")
	self._animationPositionSelect = goutil.addComponentOnce(self._goPositionSelectHint, ComponentType.Animation)
	self._enableState = GameObjectEnableState.New(self.mainGO)
	self._timelineTask = TimelineTask.New()

	goutil.setActive(self._goPositionSelectHint, false)
end

function BattleRightDownView:destroyUI()
	self._timelineTask = nil
	self._animationPositionSelect = nil
	self._goPositionSelectHint = nil
end

function BattleRightDownView:onEnter()
	return
end

function BattleRightDownView:onExit()
	self._timelineTask:clear()
	self._enableState:clear()
end

function BattleRightDownView:setVisible(visible, key)
	self._enableState:setEnable(key, visible)

	if self._enableState:isEnable() then
		self._timelineTask:clear()
		self._timelineTask:addTask(0, self._tPlayShowAnimation, self)
		self._timelineTask:addTask(2, self._tPlayLoopAnimation, self)
		self._timelineTask:start()
	end
end

function BattleRightDownView:_tPlayShowAnimation()
	goutil.setActive(self._goPositionSelectHint, true)
	self._animationPositionSelect:Play("positionselect")
end

function BattleRightDownView:_tPlayLoopAnimation()
	goutil.setActive(self._goPositionSelectHint, true)
	self._animationPositionSelect:Play("positionselect_loop")
end

return BattleRightDownView
