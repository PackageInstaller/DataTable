local StoryMovieLayer = class("StoryMovieLayer", require("app.fairyGUI.story.UI_StoryMovieLayer"), require("app.view.module.story.StoryStep"), function()
	return fgui.GComponent:create({
		resName = "StoryMovieLayer",
		pkgName = "story",
		isFullScreen = true,
		pkgPath = "ui/story/story"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.StoryConst
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.service.ServiceManager:getServiceByName("BioTeamInviteFloatService")

function StoryMovieLayer:ctor(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1.isEditor or false

	self._videoPlayer = nil
	self._videoPlayerBg = nil
	self._isClosed = false
	self._movieNode = nil

	self.m_movieBg:addClickListener(handler(self, self._onBgClick))

	self._isMoviePause = false

	if arg_2_1.id then
		self._nowMovieId = arg_2_1.id
		self._data = g.core.model.User.storyData:getMovieData(arg_2_1.id)

		if var_2_0 then
			g.core.model.User.storyData:getEditorStr(self._data)
		end

		self._storyId = var_0_1.ILLUSTRATION_MAX + arg_2_1.id

		if arg_2_2 and arg_2_2.removeNextStory then
			for iter_2_0 = #self._data, 1, -1 do
				if tonumber(self._data[iter_2_0].type) == var_0_1.STEP_TYPE.PLAY_NEXT_STORY then
					table.remove(self._data, iter_2_0)
				end
			end
		end
	end

	self:initParams()
	self:newScheduleOnce(handler(self, function()
		self:dispatchCompEvent(g.core.event.enum.EVENT_STORY_START)
	end))
end

function StoryMovieLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_MOVIE_SKIP_POP_CLOSE, handler(self, self._skipPopCloseAtClickAnyWhere), self)

	if var_0_3 and var_0_3.judgeIsRefuseBioInviteIfEnterModule then
		var_0_3:judgeIsRefuseBioInviteIfEnterModule()
	end

	if self._data and next(self._data) then
		self:playNextStep()
	else
		table.insert(self._scheduleHandlers, (self:newScheduleOnce(function()
			self:finish()
		end, 0)))
	end
end

function StoryMovieLayer:playSingleStep(arg_6_1)
	local var_6_0 = tonumber(arg_6_1.type)

	if var_6_0 == var_0_1.STEP_TYPE.PLAY_SOUND then
		self:playSound(arg_6_1)
	elseif var_6_0 == var_0_1.STEP_TYPE.PLAY_MOVIE then
		self:playMovie(arg_6_1)
	elseif var_6_0 == var_0_1.STEP_TYPE.PLAY_NEXT_STORY then
		self:playNextStory(arg_6_1)
	end
end

function StoryMovieLayer:playMovie(arg_7_1)
	local var_7_0 = tonumber(arg_7_1.params.x) or display.width / 2
	local var_7_1 = tonumber(arg_7_1.params.y) or display.height / 2
	local var_7_2 = arg_7_1.params.path
	local var_7_3 = tonumber(arg_7_1.params.scale) or 1

	if not arg_7_1.params.path then
		self:endStep()

		return
	end

	local var_7_4 = {
		x = var_7_0,
		y = var_7_1,
		movieName = var_7_2
	}

	var_7_4.isLoop = false
	var_7_4.autoRemove = false
	var_7_4.listener = handler(self, function(arg_8_0, arg_8_1)
		if arg_8_1 == "complete" then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_MOVIE_AUTO_END_NOTICE, false, {})
			arg_8_0:finish()
		end
	end)
	self._movieNode = require("app.view.common.CriSprite").new(var_7_4)

	if not self._movieNode then
		self:endStep()

		return
	end

	self._movieNode:setScale(var_7_3)
	self.m_movieBg:addNode(self._movieNode)
end

function StoryMovieLayer:clearAll()
	if self._preSoundName then
		g.core.sound.SoundManager:stopSound(self._preSoundName)
		g.core.sound.SoundManager:switchPVCG2Music()

		self._preSoundName = nil
	end

	if self._videoPlayer then
		if device.isAndroid() then
			self._videoPlayer:stop()
		end

		if self._videoPlayerBg then
			self._videoPlayerBg:removeFromParent()

			self._videoPlayerBg = nil
		end

		self._videoPlayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.05), cc.CallFunc:create(function()
			self._videoPlayer:removeFromParent()

			self._videoPlayer = nil
		end)))
	end

	for iter_9_0, iter_9_1 in ipairs(self._scheduleHandlers) do
		self:cancelSchedule(iter_9_1)
	end

	self._scheduleHandlers = {}

	if self._delayScheduleHandler then
		self:cancelSchedule(self._delayScheduleHandler)
	end

	self._delayScheduleHandler = nil
	self._alreadyDelayTime = 0
	self._delayList = {}
end

function StoryMovieLayer:finish(arg_11_1)
	if self._isClosed then
		return
	end

	self._isClosed = true

	if self._storyId == g.core.const.ConstMgr.StoryConst.CREATE_ROLE_CG_STEP then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst.PLAY_CG_END
		})
	end

	local var_11_0 = self._nowMovieId or 0

	if self._nowMovieId and self._nowMovieId > 0 then
		g.core.model.User.storyData:setMoviePlayed(self._nowMovieId)

		self._nowMovieId = nil
	end

	local var_11_1 = self._nowIndex + 1 <= self._indexMax

	self:clearAll()

	if var_11_1 then
		if self._movieNode then
			self._movieNode:dispose()

			self._movieNode = nil

			var_0_2:popAllPopup()
			var_0_2:onlyPopSelfByDisplay(self)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, true, {
				nostart = true,
				id = tonumber(clone(self._data[self._nowIndex + 1]).params.storyid)
			})
		end
	else
		local var_11_2 = g.core.model.User.storyData:getTriggerType()

		if self._movieNode then
			self._movieNode:dispose()

			self._movieNode = nil

			self:dispatchCompEvent(g.core.event.enum.EVENT_STORY_END, {
				isDialog = true,
				chooseIndex = g.core.model.User.storyData:getChooseIndex(),
				trigger_type = var_11_2,
				trigger_data = g.core.model.User.storyData:getTriggerData()
			})
			var_0_2:popAllPopup()
			var_0_2:onlyPopSelfByDisplay(self)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_END, false, {
				id = var_0_1.ILLUSTRATION_MAX + var_11_0
			})
		end
	end
end

function StoryMovieLayer:onUnload()
	self._isClosed = true

	if self._movieNode then
		self._movieNode:dispose()

		self._movieNode = nil
	end
end

function StoryMovieLayer:_onBgClick()
	if self and self.m_skipComp then
		self.m_skipComp:setVisible(not self.m_skipComp:isVisible())
	end
end

function StoryMovieLayer:pauseMovieWhenSkipShow(arg_14_1)
	if self._movieNode and self._movieNode.pause and self._isMoviePause ~= arg_14_1 then
		self._movieNode:pause(arg_14_1)

		self._isMoviePause = arg_14_1

		if arg_14_1 then
			g.core.sound.SoundManager:pauseMovieSound()
		else
			g.core.sound.SoundManager:resumeMovieSound()
		end
	end
end

function StoryMovieLayer:_skipPopCloseAtClickAnyWhere()
	if self.pauseMovieWhenSkipShow then
		self:pauseMovieWhenSkipShow(false)
	end
end

function StoryMovieLayer:playSoundEnd()
	return
end

function StoryMovieLayer:pauseStorySoundByFlag(arg_17_1)
	if self.pauseMovieWhenSkipShow then
		self:pauseMovieWhenSkipShow(arg_17_1)
	end
end

return StoryMovieLayer
