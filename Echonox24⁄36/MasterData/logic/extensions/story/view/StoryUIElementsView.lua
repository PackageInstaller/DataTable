-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryUIElementsView.lua

module("logic.extensions.story.view.StoryUIElementsView", package.seeall)

local StoryUIElementsView = class("StoryUIElementsView", ViewComponent)

function StoryUIElementsView:buildUI()
	self._uiElementTable = {}

	self:_addUIElementGameObject(StoryUIElement.Main, self.mainGO)
	self:_addUIElement(StoryUIElement.All, "rightTopPanel/rightTop/btnAll")
	self:_addUIElement(StoryUIElement.Auto, "rightTopPanel/rightTop/select/btnAuto")
	self:_addUIElement(StoryUIElement.Skip, "rightTopPanel/rightTop/select/btnSkip")
	self:_addUIElement(StoryUIElement.Record, "rightTopPanel/rightTop/select/btnHistory")

	self._unionElementTable = {}
end

function StoryUIElementsView:destroyUI()
	self._uiElementTable = false
end

function StoryUIElementsView:onEnter()
	return
end

function StoryUIElementsView:onExit()
	return
end

function StoryUIElementsView:setElementVisible(elementEnum, visible, key)
	local _curEntry = StoryController.instance:getCurStoryEntry()

	if _curEntry then
		local _canSkip = _curEntry:CanSkip()

		if not _canSkip then
			self:_setElementVisible(StoryUIElement.All, false)

			return
		end
	end

	local showState = StoryViewStateModel.instance:setUIElementVisible(elementEnum, visible, key)

	self:_setElementVisible(elementEnum, showState)
	self:_updateUnionElementsVisible()
end

function StoryUIElementsView:_updateUnionElementsVisible()
	for go, unionElementKeys in pairs(self._unionElementTable) do
		goutil.setActive(go, self:_isElementEnumsActive(unionElementKeys))
	end
end

function StoryUIElementsView:_isElementEnumsActive(elementEnums)
	for _, elementEnum in ipairs(elementEnums) do
		if not StoryViewStateModel.instance:isUIElementVisible(elementEnum) then
			return false
		end
	end

	return true
end

function StoryUIElementsView:_setElementVisible(elementEnum, visible)
	local goElement = self._uiElementTable[elementEnum]

	if elementEnum <= 0 then
		RectTransformUtils.SetAnchoredPosition(self.mainGO.transform, visible and 0 or -10000, 0)
	else
		goutil.setActive(goElement, visible)
	end
end

function StoryUIElementsView:_addUIElementGameObject(elementEnum, go)
	self._uiElementTable[elementEnum] = go
end

function StoryUIElementsView:_addUIElement(elementEnum, path)
	self._uiElementTable[elementEnum] = goutil.findChild(self.mainGO, path)
end

return StoryUIElementsView
