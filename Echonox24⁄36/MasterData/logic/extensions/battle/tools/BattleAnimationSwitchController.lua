-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/tools/BattleAnimationSwitchController.lua

module("logic.extensions.battle.tools.BattleAnimationSwitchController", package.seeall)

local BattleAnimationSwitchController = class("BattleAnimationSwitchController")

function BattleAnimationSwitchController:ctor(mainGO)
	self.mainGO = mainGO
	self._animation = self.mainGO:GetComponent(ComponentType.Animation)
	self._curState = BattleEnum.AnimationState.Close
	self._prepareState = BattleEnum.AnimationState.Close
	self._isPreparing = false
	self._activeWhenOpen = true
end

function BattleAnimationSwitchController:setAnimName(openName, closeName)
	self._openAnimName = openName
	self._closeAnimName = closeName
end

function BattleAnimationSwitchController:_startAnim()
	self._isPreparing = false

	self._animation:Stop()

	local name = self._closeAnimName

	if self._prepareState ~= self._curState then
		self._curState = self._prepareState

		if self._prepareState == BattleEnum.AnimationState.Open then
			name = self._openAnimName

			if self._activeWhenOpen then
				self:_setVisible(true)
			end
		end

		self._animation:Play(name)
	end
end

function BattleAnimationSwitchController:setVisibleUpdateHandler(func, handler)
	self._visibleUpdateFunc = func
	self._visibleUpdateHandler = handler
end

function BattleAnimationSwitchController:_setVisible(status)
	if self._visibleUpdateFunc then
		self._visibleUpdateFunc(self._visibleUpdateHandler, status)
	else
		goutil.setActive(self.mainGO, status)
	end
end

function BattleAnimationSwitchController:playOpenAnim()
	self._prepareState = BattleEnum.AnimationState.Open

	if not self._isPreparing then
		self._isPreparing = true

		removetimer(self._startAnim, self)
		settimer(0, self._startAnim, self, false)
	end
end

function BattleAnimationSwitchController:playCloseAnim()
	self._prepareState = BattleEnum.AnimationState.Close

	if not self._isPreparing then
		self._isPreparing = true

		removetimer(self._startAnim, self)
		settimer(0, self._startAnim, self, false)
	end
end

function BattleAnimationSwitchController:clear()
	removetimer(self._startAnim, self)
	self._animation:Stop()

	self._isPreparing = false
	self._curState = BattleEnum.AnimationState.Close
	self._prepareState = BattleEnum.AnimationState.Close
end

function BattleAnimationSwitchController:destroy()
	self:clear()

	self._openAnimName = false
	self._closeAnimName = false
end

function BattleAnimationSwitchController:resetForOpen()
	self._curState = BattleEnum.AnimationState.Close

	AnimationUtils.ResetAnimation(self._animation, self._openAnimName)
end

return BattleAnimationSwitchController
