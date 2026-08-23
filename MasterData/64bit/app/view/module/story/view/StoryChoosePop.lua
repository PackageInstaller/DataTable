local StoryChoosePop = class("StoryChoosePop", require("app.fairyGUI.story.UI_StoryChoosePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/story/story",
		resName = "StoryChoosePop",
		pkgName = "story",
		isFullScreen = true
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.StoryConst

function StoryChoosePop:ctor(arg_2_1)
	self._data = arg_2_1
	self._endCallback = arg_2_1.callback

	local var_2_0 = 0

	for iter_2_0 = 1, var_0_1.BRANCH_MAX_CHOOSE do
		if arg_2_1["key" .. iter_2_0] and arg_2_1["key" .. iter_2_0] ~= "" then
			var_2_0 = var_2_0 + 1
		end

		self["m_chooseBtn" .. iter_2_0]:addClickListener(function()
			self:onClickBrance(iter_2_0)
		end)

		if arg_2_1["key" .. iter_2_0] and arg_2_1["key" .. iter_2_0] ~= "" then
			local var_2_1 = self["m_chooseBtn" .. iter_2_0]:getChild("title")

			var_2_1:disableAutoChange()
			var_2_1:setText(arg_2_1["key" .. iter_2_0])
		end

		if tonumber(arg_2_1["useeff" .. iter_2_0]) == 1 then
			-- block empty
		end
	end

	local var_2_2 = var_2_0 < var_0_1.BRANCH_MAX_CHOOSE and 1 or 0

	self.m_numsController:setSelectedIndex(var_2_0 < var_0_1.BRANCH_MAX_CHOOSE and 1 or 0)

	if var_2_2 == 1 then
		self.m_enter1Transition:play()
	else
		self.m_enter0Transition:play()
	end
end

function StoryChoosePop:_onStopBubble(arg_4_1)
	arg_4_1:stopPropagation()
end

function StoryChoosePop:onLoad()
	return
end

function StoryChoosePop:onUnload()
	return
end

function StoryChoosePop:onClickBrance(arg_7_1)
	local var_7_0 = tonumber(self._data["story" .. arg_7_1])

	if self._endCallback then
		self._endCallback()
	end

	self:removeFromParent()

	if var_7_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, true, {
			nostart = true,
			id = var_7_0
		})
	end
end

function StoryChoosePop:doAutoAction()
	self:onClickBrance(1)
end

return StoryChoosePop
