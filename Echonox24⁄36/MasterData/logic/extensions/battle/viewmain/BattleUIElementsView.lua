-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/BattleUIElementsView.lua

module("logic.extensions.battle.viewmain.BattleUIElementsView", package.seeall)

local BattleUIElementsView = class("BattleUIElementsView", ViewComponent)

function BattleUIElementsView:buildUI()
	self._uiElementTable = {}

	self:_addUIElementGameObject(BattleUIElement.Main, self.mainGO)
	self:_addUIElement(BattleUIElement.Auto, "rightTopHint/buttons/btnAuto")
	self:_addUIElement(BattleUIElement.Speed, "rightTopHint/buttons/btnSpeed")
	self:_addUIElement(BattleUIElement.Setting, "rightTopHint/buttons/btnSet")
	self:_addUIElement(BattleUIElement.Undo, "rightTopHint/buttons/btnRepentance")
	self:_addUIElement(BattleUIElement.RoundFinish, "downHint/btnFinished")
	self:_addUIElement(BattleUIElement.DangerZone, "rightTopHint/buttons/btnDangerZone")
	self:_addUIElement(BattleUIElement.RotateCamera, "rightTopHint/visualAngle")
	self:_addUIElement(BattleUIElement.RoundCount, "bout/boutHint")
	self:_addUIElement(BattleUIElement.WinCondition, "bout/layout/txtVictoryConditions")
	self:_addUIElement(BattleUIElement.SanityStrengthen, "operateRoot/strengthSanity")

	self._unionElementTable = {}
end

function BattleUIElementsView:destroyUI()
	self._uiElementTable = false
end

function BattleUIElementsView:onEnter()
	self:_setEvent(true)
	self:_judgeSystemOpen()
end

function BattleUIElementsView:onExit()
	self:_setEvent(false)
end

function BattleUIElementsView:setElementVisible(elementEnum, visible, key)
	local visible = BattleViewStateModel.instance:setUIElementVisible(elementEnum, visible, key)

	self:_setElementVisible(elementEnum, visible)
	self:_updateUnionElementsVisible()
end

function BattleUIElementsView:_setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._judgeSystemOpen, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._judgeSystemOpen, self)
	end
end

function BattleUIElementsView:_judgeSystemOpen()
	for elementEnum, _ in pairs(self._uiElementTable) do
		local visible = BattleViewStateModel.instance:isUIElementVisible(elementEnum)

		self:_setElementVisible(elementEnum, visible)
	end

	self:_updateUnionElementsVisible()
end

function BattleUIElementsView:_updateUnionElementsVisible()
	for go, unionElementKeys in pairs(self._unionElementTable) do
		goutil.setActive(go, self:_isElementEnumsActive(unionElementKeys))
	end
end

function BattleUIElementsView:_isElementEnumsActive(elementEnums)
	for _, elementEnum in ipairs(elementEnums) do
		if not BattleViewStateModel.instance:isUIElementVisible(elementEnum) then
			return false
		end
	end

	return true
end

function BattleUIElementsView:_setElementVisible(elementEnum, visible)
	local goElement = self._uiElementTable[elementEnum]

	if elementEnum <= 0 then
		RectTransformUtils.SetAnchoredPosition(self.mainGO.transform, visible and 0 or -10000, 0)
	else
		goutil.setActive(goElement, visible)
	end
end

function BattleUIElementsView:_addUIElementGameObject(elementEnum, go)
	self._uiElementTable[elementEnum] = go
end

function BattleUIElementsView:_addUIElement(elementEnum, path)
	self._uiElementTable[elementEnum] = goutil.findChild(self.mainGO, path)
end

return BattleUIElementsView
