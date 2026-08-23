local StorySkipPop = class("StorySkipPop", require("app.fairyGUI.story.UI_StorySkipPop"), function()
	return fgui.GComponent:create({
		pkgName = "story",
		resName = "StorySkipPop",
		pkgPath = "ui/story/story"
	}, ...)
end)
local var_0_1 = g.core.module.ModuleManager

function StorySkipPop:ctor(arg_2_1)
	self:setOpaque(false)
	self:showAtCenter()

	self._storyId = arg_2_1.storyId or 1
	self._skipFunc = arg_2_1.skipFunc
	self._backFunc = arg_2_1.backFunc

	self.m_popPanel:getChild("closeBtn"):setClickFunc(handler(self, self._onClickBack))
	self.m_cancelBtn:addClickListener(handler(self, self._onClickBack))
	self.m_okBtn:addClickListener(handler(self, self._onClickSkip))

	self._isOpen = true
	self._descCompHeightSize = self.m_descTxt:getSize().height
	self.m_text = self.m_descTxt:getChild("title")
end

function StorySkipPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_AUTO_END_NOTICE, handler(self, self._autoCloseWhenStoryEnd), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_MOVIE_AUTO_END_NOTICE, handler(self, self._movieAutoEnd), self)

	local var_3_0 = g.core.model.User:getName()
	local var_3_1 = g.core.config.story_summary_info.fetch(self._storyId)

	self.m_descTxt:setTitle((var_3_1 or nil) and string.gsub(var_3_1.text, "#main_role#", var_3_0))
	self:_adjustPos()
end

function StorySkipPop:_onClickBack()
	if self._isOpen then
		var_0_1:onlyPopSelfByDisplay(self)
	end

	self._isOpen = false

	if self._backFunc then
		self._backFunc()
	end
end

function StorySkipPop:_onClickSkip()
	if self._isOpen then
		var_0_1:onlyPopSelfByDisplay(self)
	end

	self._isOpen = false

	if self._skipFunc then
		self._skipFunc()
	end
end

function StorySkipPop:onUnload()
	self._isOpen = false

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_MOVIE_SKIP_POP_CLOSE)
end

function StorySkipPop:_autoCloseWhenStoryEnd()
	local var_7_0 = self

	if self and self._isOpen then
		self:newScheduleOnce(function()
			if var_7_0 and var_7_0._isOpen then
				var_7_0._isOpen = false

				var_0_1:onlyPopSelfByDisplay(var_7_0)
			end
		end, 0)
	end
end

function StorySkipPop:_movieAutoEnd()
	self._isOpen = false
end

function StorySkipPop:_adjustPos()
	local var_10_0 = self.m_text:getSize().height

	if var_10_0 < self._descCompHeightSize then
		self.m_text:setY(self._descCompHeightSize / 2 - var_10_0 / 2)
	end
end

return StorySkipPop
