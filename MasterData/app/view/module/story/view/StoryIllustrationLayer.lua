local var_0_0 = loadCfg("core.config.cfg.story_name_info")
local var_0_1 = g.core.const.ConstMgr.StoryConst
local TypeWriter = require("app.view.common.TypeWriter")
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.service.ServiceManager:getServiceByName("BioTeamInviteFloatService")
local StoryIllustrationLayer = class("StoryIllustrationLayer", require("app.fairyGUI.story.UI_StoryIllustrationLayer"), require("app.view.module.story.StoryStep"), function()
	return fgui.GComponent:create({
		resName = "StoryIllustrationLayer",
		pkgPath = "ui/story/story",
		isFullScreen = true,
		pkgName = "story"
	}, ...)
end)

function StoryIllustrationLayer:ctor(arg_2_1, arg_2_2)
	self._storyData = g.core.model.User.storyData

	local var_2_0 = arg_2_1.isEditor or false

	self._params = arg_2_2
	self._loaderPic = self.m_maskComp:getChild("picLoader")

	self.m_dialogComp:setVisible(false)

	self._lblDialog = self.m_dialogComp:getChild("dialogTxt")
	self._nameText = self.m_dialogComp:getChild("nameTxt")
	self._isCanClick = false

	if arg_2_1.id then
		self._nowIllustrationId = arg_2_1.id
		self._data = self._storyData:getIllustrationData(arg_2_1.id)

		if var_2_0 then
			self._storyData:getEditorStr(self._data)
		end

		self._storyId = var_0_1.ANIMATION_MAX + arg_2_1.id

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

function StoryIllustrationLayer:onLoad()
	if var_0_4 and var_0_4.judgeIsRefuseBioInviteIfEnterModule then
		var_0_4:judgeIsRefuseBioInviteIfEnterModule()
	end

	if self._data and next(self._data) then
		self:playNextStep()
	else
		table.insert(self._scheduleHandlers, (self:newScheduleOnce(function()
			self:finish()
		end, 0)))
	end
end

function StoryIllustrationLayer:playSingleStep(arg_6_1)
	self.m_tipComp:setVisible(false)

	self._isCanClick = true

	local var_6_0 = tonumber(arg_6_1.type)

	if var_6_0 == var_0_1.STEP_TYPE.PLAY_EFFECT then
		-- block empty
	elseif var_6_0 == var_0_1.STEP_TYPE.MOVE_CAMERA then
		-- block empty
	elseif var_6_0 == var_0_1.STEP_TYPE.MOVE_EFFECT then
		-- block empty
	elseif var_6_0 == var_0_1.STEP_TYPE.SHAKE_LAYER then
		self:shakeLayer(arg_6_1)
	elseif var_6_0 == var_0_1.STEP_TYPE.SET_MASK_SIZE then
		-- block empty
	elseif var_6_0 == var_0_1.STEP_TYPE.LOAD_ILLUSTRATION then
		self:loadIllustration(arg_6_1)
	elseif var_6_0 == var_0_1.STEP_TYPE.PLAY_SOUND then
		self:playSound(arg_6_1)
	elseif var_6_0 == var_0_1.STEP_TYPE.BOTTOM_TIPS then
		self:bottomTips(arg_6_1)
	elseif var_6_0 == var_0_1.STEP_TYPE.SCALE_CAMERA then
		-- block empty
	elseif var_6_0 == var_0_1.STEP_TYPE.PLAY_NEXT_STORY then
		self:playNextStory(arg_6_1)
	elseif var_6_0 == var_0_1.STEP_TYPE.ILLUSTRATION_POS_TIP then
		self:showPosTip(arg_6_1)
	end
end

function StoryIllustrationLayer:playEffect(arg_7_1)
	local var_7_0 = arg_7_1.params.path
	local var_7_1 = tonumber(arg_7_1.params.multi) == 1
	local var_7_2 = var_7_1 and -1 or tonumber(arg_7_1.params.count)
	local var_7_3 = self._nowIndex

	assert(var_7_2, "incorrect play times")

	local var_7_4

	var_7_4 = require("app.view.common.SpineBase").new({
		resId = "",
		path = var_7_0,
		isLoop = var_7_1,
		listener = function(self)
			if not var_7_4 then
				return
			end

			if self.type == "complete" then
				var_7_2 = var_7_2 - 1

				if var_7_2 == 0 then
					var_7_4:removeFromParent(true)

					self._effects[var_7_3] = nil

					self:endStep()
				elseif var_7_2 > 0 then
					var_7_4:setAnimation(0, "play", var_7_1)
				end
			end
		end
	})

	if not var_7_4 then
		self:endStep()

		return
	end

	local var_7_5 = tonumber(arg_7_1.params.x) or display.width / 2
	local var_7_6 = tonumber(arg_7_1.params.y) or display.height / 2
	local var_7_7 = tonumber(arg_7_1.params.scale) or 1
	local var_7_8 = tonumber(arg_7_1.params.zorder) or 4

	var_7_4:setPosition(var_7_5, var_7_6)
	var_7_4:setScale(var_7_7, var_7_7)

	self._effects[var_7_3] = {
		eff = var_7_4,
		path = var_7_0
	}

	var_7_4:setLocalZOrder(var_7_8)
	self._loaderPic:displayObject():addChild(var_7_4)

	if var_7_1 then
		self._effects[var_7_3].endIndex = tonumber(arg_7_1.params.endStep) or var_7_3

		self:endStep()
	end
end

function StoryIllustrationLayer:moveCamera(arg_9_1)
	local var_9_0 = tonumber(arg_9_1.params.dis) or 100
	local var_9_1 = tonumber(arg_9_1.params.dis_y) or 0

	self._loaderPic:runFGAction((fgui.FSequence:create(fgui.FMoveBy:create(math.abs(var_9_0 / (tonumber(arg_9_1.params.speed) or 50)), {
		x = var_9_0,
		y = var_9_1
	}), fgui.FCallFunc:create(function()
		self:endStep()
	end))))
end

function StoryIllustrationLayer:setMaskSize(arg_11_1)
	if not tonumber(arg_11_1.params.width) then
		-- block empty
	end

	if not tonumber(arg_11_1.params.height) then
		-- block empty
	end

	local var_11_2 = tonumber(arg_11_1.params.x) or display.width / 2
	local var_11_3 = tonumber(arg_11_1.params.y) or display.height / 2
	local var_11_4 = self:formatX(var_11_2)
	local var_11_5 = self:formatY(var_11_3)

	self:endStep()
end

function StoryIllustrationLayer:loadIllustration(arg_12_1)
	local var_12_0 = arg_12_1.params.picName or ""
	local var_12_1 = tonumber(arg_12_1.params.x) or display.width / 2
	local var_12_2 = tonumber(arg_12_1.params.y) or display.height / 2
	local var_12_3 = self:formatX(var_12_1)
	local var_12_4 = self:formatY(var_12_2)
	local var_12_5 = tonumber(arg_12_1.params.scale) or 1
	local var_12_6 = tonumber(arg_12_1.params.time)
	local var_12_7 = tonumber(arg_12_1.params.fadein) == 1
	local var_12_8 = tonumber(arg_12_1.params.sex)
	local var_12_9 = var_12_0

	if var_12_8 and var_12_8 == 1 and not g.core.model.User:isBoy() and var_12_0 ~= "" then
		local var_12_10 = string.split(var_12_0, ".")

		var_12_9 = var_12_10[1] .. "_1" .. "." .. var_12_10[2]
	end

	self._loaderPic:setURL((g.core.common.Path:getStoryIllustrationPicRes(var_12_9)))
	self._loaderPic:setPosition(display.width / 2, display.height / 2)
	self._loaderPic:setPivot(0.5, 0.5, true)
	self._loaderPic:setScale(var_12_5)

	local var_12_11 = {
		width = display.width,
		height = display.height
	}

	self._loaderPic:setSize(var_12_11.width, var_12_11.height)

	if var_12_7 then
		self._isCanClick = false

		self:getView():getTransition("showIll"):play(handler(self, self._onLoadPicFinish))
	end
end

function StoryIllustrationLayer:_onLoadPicFinish()
	self._isCanClick = true
end

function StoryIllustrationLayer:bottomTips(arg_14_1)
	local var_14_0 = ""

	if arg_14_1.params.setNameId and arg_14_1.params.setNameId ~= "" then
		local var_14_1 = string.trim(arg_14_1.params.setNameId)

		if tonumber(var_14_1) then
			var_14_0 = (var_0_0.get(tonumber(var_14_1)) or {}).name or ""
		elseif var_14_1 == "#main_role#" then
			var_14_0 = string.gsub(var_14_1, "#main_role#", g.core.model.User:getName())
		end
	end

	self._nameText:setText(var_14_0)

	if arg_14_1.params.str ~= "" then
		self._isCanClick = false
	end

	local var_14_2 = string.gsub(arg_14_1.params.str, "#", "\n")

	self.m_dialogComp:setVisible(true)
	self:_playText(self._lblDialog, var_14_2, handler(self, function()
		self._isCanClick = true
	end))
	self:_playDialogSound(arg_14_1.params)
end

function StoryIllustrationLayer:scaleCamera(arg_16_1)
	self._loaderPic:runFGAction((fgui.FSequence:create(fgui.FScaleTo:create(tonumber(arg_16_1.params.time) or 5, tonumber(arg_16_1.params.scale) or 1.5), fgui.FCallFunc:create(function()
		self:endStep()
	end))))
end

function StoryIllustrationLayer:showPosTip(arg_18_1)
	local var_18_0 = arg_18_1.params.str or ""

	if var_18_0 and var_18_0 ~= "" then
		self.m_tipComp:setVisible(true)
		self.m_tipComp:showTipContent((string.gsub(var_18_0, "#", "\n")))
		self.m_tipComp:setPosition((tonumber(arg_18_1.params.posX) or 0) + (display.width - CC_DESIGN_RESOLUTION.width) / 2, (tonumber(arg_18_1.params.posY) or 0) + (display.height - CC_DESIGN_RESOLUTION.height) / 2)
	end
end

function StoryIllustrationLayer:clearAll()
	if self._preSoundName then
		g.core.sound.SoundManager:stopSound(self._preSoundName)

		self._preSoundName = nil
	end

	for iter_19_0, iter_19_1 in ipairs(self._scheduleHandlers) do
		self:cancelSchedule(iter_19_1)
	end

	self._scheduleHandlers = {}

	if self._delayScheduleHandler then
		self:cancelSchedule(self._delayScheduleHandler)
	end

	self._delayScheduleHandler = nil
	self._alreadyDelayTime = 0
	self._delayList = {}

	if self._typeWriter then
		self._typeWriter:finish()

		self._typeWriter = nil
	end

	for iter_19_2, iter_19_3 in pairs(self._effects) do
		iter_19_3.eff:removeFromParent(true)
	end

	self._effects = {}
end

function StoryIllustrationLayer:finish(arg_20_1)
	if self._inEnd then
		return
	end

	if self.m_skipComp then
		self.m_skipComp:setVisible(false)
	end

	self._inEnd = true

	local var_20_0 = self._nowIllustrationId or 0

	self:dispatchCompEvent(g.core.event.enum.EVENT_STORY_NOTICE, {
		id = var_0_1.ANIMATION_MAX + var_20_0
	})

	if self._nowIllustrationId and self._nowIllustrationId > 0 then
		self._storyData:setIllustrationPlayed(self._nowIllustrationId)

		self._nowIllustrationId = nil
	end

	local var_20_1 = self:_checkLastIsPlayNextStory()

	if (var_20_1 or self._isPlayingNext) and not arg_20_1 then
		if self._inSkip and not self._isPlayingNext then
			self:dispatchCompEvent(g.core.event.enum.EVENT_STORY_END, {
				isDialog = true,
				chooseIndex = self._storyData:getChooseIndex(),
				trigger_type = self._storyData:getTriggerType(),
				trigger_data = self._storyData:getTriggerData(),
				triggerTaskId = self._triggerTaskId
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_END, false, {
				id = var_0_1.ANIMATION_MAX + var_20_0
			})
		end

		self:clearAll()
		var_0_3:onlyPopSelfByDisplay(self)

		if var_20_1 and not self._isPostNextStoryEvent then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, true, {
				nostart = true,
				id = tonumber(clone(self._nextStoryData).params.storyid)
			})
		end

		return
	end

	self:getView():getTransition("hide"):play(function()
		self:clearAll()
		self:dispatchCompEvent(g.core.event.enum.EVENT_STORY_END, {
			isDialog = true,
			chooseIndex = self._storyData:getChooseIndex(),
			trigger_type = self._storyData:getTriggerType(),
			trigger_data = self._storyData:getTriggerData(),
			triggerTaskId = self._triggerTaskId
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_END, false, {
			id = var_0_1.ANIMATION_MAX + var_20_0
		})
		var_0_3:onlyPopSelfByDisplay(self)
	end)
end

function StoryIllustrationLayer:onUnload()
	self._isCanClick = false

	self:clearAll()
end

function StoryIllustrationLayer:doAutoAction()
	self:_onClick()
end

function StoryIllustrationLayer:_onClick()
	if not self._isAuto then
		if self._isCanClick then
			if self._typeWriter then
				self._typeWriter:finish()

				self._typeWriter = nil
			else
				self._isCanClick = false

				if self:_checkNextChoose() then
					self:endStep()
				else
					self._lblDialog:setText("")

					if self._nameText then
						self._nameText:setText("")
					end

					self:endStep()
				end
			end
		end
	elseif self._isCanClick then
		if self._typeWriter then
			self._typeWriter:finish()

			self._typeWriter = nil
		else
			self._isCanClick = false

			if self._soundEndHandler then
				self:cancelSchedule(self._soundEndHandler)

				self._soundEndHandler = nil
			end

			if self._autoNextHandler then
				self:cancelSchedule(self._autoNextHandler)

				self._autoNextHandler = nil
			end

			self:endStep()
		end
	end
end

return StoryIllustrationLayer
