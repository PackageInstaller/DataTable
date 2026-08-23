local var_0_0 = g.core.const.ConstMgr.StoryConst
local var_0_1 = g.core.module.ModuleManager
local StoryReviewPop = class("StoryReviewPop", require("app.fairyGUI.story.UI_StoryReviewPop"), function()
	return fgui.GComponent:create({
		resName = "StoryReviewPop",
		pkgPath = "ui/story/story",
		pkgName = "story"
	}, ...)
end)

function StoryReviewPop:ctor(arg_2_1)
	self:showAtCenter()

	self._storyData = g.core.model.User.storyData
	self._callback = arg_2_1.func
	self._data = arg_2_1.data or {}
	self._nowIndex = arg_2_1.nowIndex or 1
	self._dialogArr = {}

	self.m_backBtn:setClickFunc(handler(self, self._onClickClose))
	self.m_dialogList:setVirtual(self)
	self.m_dialogList:setItemRenderer(handler(self, self._onRenderDialog))

	self._isOpen = true
end

function StoryReviewPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_AUTO_END_NOTICE, handler(self, self._autoCloseWhenStoryEnd), self)

	self._dialogArr = {}

	for iter_3_0 = 1, self._nowIndex do
		if not self._data[iter_3_0] then
			break
		end

		local var_3_0 = self._data[iter_3_0]

		if var_0_0.STEP_TYPE.PLAY_DIALOG == tonumber(self._data[iter_3_0].type) then
			local var_3_1 = self._storyData:getRoleData(var_3_0.params.role) or {}

			table.insert(self._dialogArr, {
				name = self._storyData:getKnightShowName(var_3_1, var_3_0.params),
				str = var_3_0.params.str,
				isMainRole = g.core.model.User.storyData:isMainRole(tonumber(var_3_1.res))
			})
		end
	end

	self.m_dialogList:setNumItems(#self._dialogArr)

	if self.m_openTransition then
		self.m_openTransition:play()
	end
end

function StoryReviewPop:_onRenderDialog(arg_4_1, arg_4_2)
	local var_4_0 = self._dialogArr[arg_4_1 + 1]

	arg_4_2:getChild("nameTxt"):setText(self._dialogArr[arg_4_1 + 1].name)

	if var_4_0.isMainRole then
		arg_4_2:getChild("nameTxt"):setColor(cc.c3b(255, 204, 131))
	else
		arg_4_2:getChild("nameTxt"):setColor(g.core.common.Color.A6)
	end

	local var_4_1 = arg_4_2:getChild("dialogTxt")

	var_4_1:setWidth(787)
	var_4_1:setText(var_4_0.str)

	local var_4_2 = var_4_1:getTextSize().width

	if var_4_2 < 787 then
		var_4_1:setWidth(var_4_2)
	else
		var_4_1:setWidth(787)
	end
end

function StoryReviewPop:_onClickClose()
	if self and self._isOpen and self.m_closeTransition then
		self.m_closeTransition:play(handler(self, function(arg_6_0)
			if arg_6_0._callback then
				arg_6_0._callback()
			end

			if arg_6_0._isOpen then
				arg_6_0._isOpen = false

				var_0_1:onlyPopSelfByDisplay(arg_6_0)
			end
		end))
	end
end

function StoryReviewPop:onUnload()
	self._isOpen = false
end

function StoryReviewPop:_autoCloseWhenStoryEnd()
	if self and self._isOpen then
		self:newScheduleOnce(function()
			if self and self._isOpen then
				self._isOpen = false

				var_0_1:onlyPopSelfByDisplay(self)
			end
		end, 0)
	end
end

return StoryReviewPop
