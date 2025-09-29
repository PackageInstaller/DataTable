-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/EchoItemBreakPointView.lua

module("logic.extensions.charactersystem.view.carrier.EchoItemBreakPointView", package.seeall)

local M = class("EchoItemBreakPointView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._maxIndex = 0

	self:_buildUI()
end

function M:_buildUI()
	self._animation = self._mainGo:GetComponent(ComponentType.Animation)
	self._canvasGroup = self._mainGo:GetComponent(ComponentType.CanvasGroup)
	self._imgGoList = {}

	for index = 1, 100 do
		local imgGo = goutil.findChild(self._mainGo, "point/Image" .. index)

		if imgGo then
			table.insert(self._imgGoList, imgGo)
		else
			break
		end
	end
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setEchoItemLevel(level, maxLevel)
	self._echoItemLevel = level
	self._maxIndex = maxLevel or 6

	self:refreshView()
end

function M:setCanvasGroupAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._imgGoList = nil
end

function M:refreshView()
	for index = 1, self._maxIndex - 1 do
		local visible = index < self._echoItemLevel and index <= self._maxIndex - 1

		self._imgGoList[index]:SetActive(visible)
	end
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:playUpgradeAnim(level)
	local showLv = level - 1

	if showLv > 0 then
		local animName = string.format("break_point_point_open%s", showLv)

		self:playAnim(animName)
	end
end

function M:resetAnim(level)
	self:playUpgradeAnim(level)
	self._animation:Stop()
	AnimationUtils.ResetToLastFrame(self._animation)
end

function M:playAnim(name)
	if string.nilorempty(name) then
		return
	end

	self._animation:Stop()
	self._animation:Play(name)
end

return M
