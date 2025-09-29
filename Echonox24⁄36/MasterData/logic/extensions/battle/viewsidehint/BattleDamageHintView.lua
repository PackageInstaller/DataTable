-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsidehint/BattleDamageHintView.lua

module("logic.extensions.battle.viewsidehint.BattleDamageHintView", package.seeall)

local M = class("BattleDamageHintView", ViewComponent)

function M:buildUI()
	self._mainGO = self:getGoByPath("imgHurt")
	self._txtNum = self:getTextByPath("imgHurt/txtNum")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._canvasGroup = self._mainGO:GetComponent(ComponentType.CanvasGroup)
	self._totalDamage = 0
	self._isOpen = false
end

function M:onEnter()
	BattleDamageHintFacade.instance:registerView(self)
	self:setVisible(false)
end

function M:onExit()
	self:setVisible(false)
	BattleDamageHintFacade.instance:unregisterView()

	self._isOpen = false
end

function M:setVisible(status)
	if not status then
		if self._isOpen then
			self._guiAnimation:PlayAniByName("close1")
		end

		self._totalDamage = 0
		self._isOpen = false
	elseif self._isOpen then
		self._canvasGroup.alpha = 1

		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("baodian")
	else
		self._guiAnimation:PlayAniByName("open1")

		self._isOpen = true
	end
end

function M:showHint(num)
	self._totalDamage = num + self._totalDamage
	self._txtNum.text = self._totalDamage

	self:setVisible(true)
end

return M
