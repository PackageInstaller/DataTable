local StoryOtherChoosePop = class("StoryOtherChoosePop", require("app.fairyGUI.story.UI_StoryChoosePop"), function()
	return fgui.GComponent:create({
		pkgName = "story",
		resName = "StoryChoosePop",
		pkgPath = "ui/story/story",
		isFullScreen = true
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.StoryConst

function StoryOtherChoosePop:ctor(arg_2_1)
	self._data = arg_2_1
	self._branchType = tonumber(arg_2_1.branchtype)
	self._endCallback = arg_2_1.callback

	local var_2_1 = 0

	for iter_2_0 = 1, var_0_1.BRANCH_MAX_CHOOSE do
		if arg_2_1["key" .. iter_2_0] and arg_2_1["key" .. iter_2_0] ~= "" then
			var_2_1 = var_2_1 + 1
		end

		self["m_chooseBtn" .. iter_2_0]:addClickListener(function()
			self:onClickBrance(iter_2_0)
		end)

		if arg_2_1["key" .. iter_2_0] and arg_2_1["key" .. iter_2_0] ~= "" then
			local var_2_2 = self["m_chooseBtn" .. iter_2_0]:getChild("title")

			var_2_2:disableAutoChange()
			var_2_2:setText(arg_2_1["key" .. iter_2_0])
		end

		if tonumber(arg_2_1["useeff" .. iter_2_0]) == 1 then
			-- block empty
		end
	end

	self.m_numsController:setSelectedIndex(var_2_1 < var_0_1.BRANCH_MAX_CHOOSE and 1 or 0)
end

function StoryOtherChoosePop:onLoad()
	return
end

function StoryOtherChoosePop:onUnload()
	return
end

function StoryOtherChoosePop:onClickBrance(arg_6_1)
	g.core.model.User.storyData:setChooseIndex(arg_6_1)

	if self._endCallback then
		self._endCallback()
	end

	self:removeFromParent()
end

return StoryOtherChoosePop
