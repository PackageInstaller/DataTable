-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewfullscreenwarn/BattleFullScreenWarnView.lua

module("logic.extensions.battle.viewfullscreenwarn.BattleFullScreenWarnView", package.seeall)

local BattleFullScreenWarnView = class("BattleFullScreenWarnView", ViewComponent)
local kTwinkleInternal = 1

function BattleFullScreenWarnView:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)

	goutil.addChildToParent(self.mainGO, SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.Effect))
end

function BattleFullScreenWarnView:destroyUI()
	self._canvasGroup = nil
end

function BattleFullScreenWarnView:onEnter()
	self._canvasGroup:DOFade(0, kTwinkleInternal):SetLoops(-1)
end

function BattleFullScreenWarnView:onExit()
	self._canvasGroup:DOFade(1, 0)
	self._canvasGroup:DOKill(true)
end

return BattleFullScreenWarnView
