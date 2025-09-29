-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryViewComponent.lua

module("logic.extensions.story.view.StoryViewComponent", package.seeall)

local M = class("StoryViewComponent", ViewComponent)

function M:buildUI()
	self._dialogPanel = self:getGo("story_main_view_-233468769")
	self._extraPanel = self:getGo("story_main_view_745372372")
	self._roleInfoPanel = self:getGo("story_main_view_-1947114781")
	self._normalChoicePanel = self:getGo("story_main_view_-719354965")
	self._attrChoicePanel = self:getGo("story_main_view_1795691225")
	self._extraPanel = self:getGo("story_main_view_745372372")
	self._fullTxtPanel = self:getGo("story_main_view_-1765807412")
	self._bubblePanel = self:getGo("story_main_view_156299194")
	self._vedioPanel = self:getGo("story_main_view_949477232")

	self:_resetUIView()
end

function M:onEnter()
	StoryFacde.instance:registerView(self)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Plot)
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Plot)
	StoryFacde.instance:unregisterView(self)
	self:_resetUIView()
end

function M:destroyUI()
	return
end

function M:_resetUIView()
	goutil.setActive(self._dialogPanel, false)
	goutil.setActive(self._extraPanel, false)
	goutil.setActive(self._roleInfoPanel, false)
	goutil.setActive(self._normalChoicePanel, false)
	goutil.setActive(self._attrChoicePanel, false)
	goutil.setActive(self._extraPanel, false)
	goutil.setActive(self._fullTxtPanel, false)
	goutil.setActive(self._bubblePanel, false)
	goutil.setActive(self._vedioPanel, false)
end

return M
