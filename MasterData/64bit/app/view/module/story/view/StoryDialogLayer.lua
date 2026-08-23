local var_0_0 = g.core.service.ServiceManager:getServiceByName("BioTeamInviteFloatService")
local StoryDialogLayer = class("StoryDialogLayer", require("app.fairyGUI.story.UI_StoryDialogLayer"), require("app.view.module.story.StoryStep"), function()
	return fgui.GComponent:create({
		resName = "StoryDialogLayer",
		pkgName = "story",
		isFullScreen = true,
		pkgPath = "ui/story/story"
	}, ...)
end)
local var_0_2 = g.core.const.ConstMgr.StoryConst
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.common.Path

function StoryDialogLayer:ctor(arg_2_1)
	self._storyData = g.core.model.User.storyData

	local var_2_0 = arg_2_1.isEditor or false

	self._lblName = self.m_dialogComp:getChild("nameTxt")
	self._lblDialog = self.m_dialogComp:getChild("dialogTxt")

	self.m_dialogComp:setVisible(false)

	if arg_2_1.id then
		self._nowDialogId = arg_2_1.id
		self._data = self._storyData:getDialogData(arg_2_1.id)

		if var_2_0 then
			self._storyData:getEditorStr(self._data)
		end

		self._storyId = arg_2_1.id
	end

	self:initParams()
	self:newScheduleOnce(handler(self, function()
		self:dispatchCompEvent(g.core.event.enum.EVENT_STORY_START)
	end))
end

function StoryDialogLayer:_onClick()
	if not self._isAuto then
		if self._inDialog then
			if self._typeWriter then
				self._typeWriter:finish()

				self._typeWriter = nil
			else
				self._inDialog = false

				if self:_checkNextChoose() then
					self:endStep()
				else
					self._lblDialog:setText("")
					self._lblName:setText("")
					self:endStep()
				end
			end
		end
	elseif self._inDialog then
		if self._typeWriter then
			self._typeWriter:finish()

			self._typeWriter = nil
		else
			self._inDialog = false

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

function StoryDialogLayer:onLoad()
	if var_0_0 and var_0_0.judgeIsRefuseBioInviteIfEnterModule then
		var_0_0:judgeIsRefuseBioInviteIfEnterModule()
	end

	if self._data and next(self._data) then
		self:playNextStep()
	else
		table.insert(self._scheduleHandlers, (self:newScheduleOnce(function()
			self:finish()
		end, 0)))
	end
end

function StoryDialogLayer:playNextStep()
	self._nowIndex = self._nowIndex + 1

	self:_checkRemoveEffects()

	if self._nowIndex > self._indexMax then
		table.insert(self._scheduleHandlers, (self:newScheduleOnce(function()
			self:finish()
		end, 0)))

		return
	end

	self._indexLock = 1

	self:playWithDelaytime(self._data[self._nowIndex], 0)

	for iter_7_0 = self._nowIndex + 1, self._indexMax do
		if self._data[iter_7_0].playtype == var_0_2.STEP_PLAY_TYPE.WITH_LAST then
			self._nowIndex = iter_7_0

			self:playWithDelaytime(self._data[iter_7_0], iter_7_0 - self._nowIndex)
		else
			break
		end
	end
end

function StoryDialogLayer:playSingleStep(arg_9_1)
	local var_9_0 = self._storyData:getGenderList()
	local var_9_1 = arg_9_1.params or {}
	local var_9_2 = false

	if var_9_1.role then
		for iter_9_0 = 1, #var_9_0 do
			if var_9_0[iter_9_0].roleIndex == var_9_1.role then
				var_9_2 = true
			end
		end

		if var_9_2 then
			arg_9_1.params.role = self._storyData:getMyGenderIndex()
		end
	end

	if var_9_2 then
		self._lblName:setColor(cc.c3b(255, 204, 131))
	else
		self._lblName:setColor(g.core.common.Color.A6)
	end

	local var_9_3 = tonumber(arg_9_1.type)

	if var_9_3 == var_0_2.STEP_TYPE.DARK_CURTAIN then
		self:playDarkCurtain(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.CREATE_BARKGROUND then
		self:playBackground(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.PLAY_EFFECT then
		local var_9_4 = tonumber(arg_9_1.params.eff_type) or 1

		if var_9_4 == var_0_2.EFF_TYPE.GLOBAL then
			self:playEffect(arg_9_1)
		elseif var_9_4 == var_0_2.EFF_TYPE.KNIGHT then
			self:playKnightEffect(arg_9_1)
		end
	elseif var_9_3 == var_0_2.STEP_TYPE.HIDE_DRAWKNIGHT then
		self:hideDiaKnight(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.MOVE_DRAWKNIGHT then
		self:moveDiaKnight(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.SHOW_DRAWKNIGHT then
		self:showDiaKnight(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.FLIP_DRAWKNIGHT then
		self:flipDiaKnight(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.HIDE_DIA_FRAME then
		self:hideDiaFrame(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.PLAY_DIALOG then
		self:playDialog(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.SHOW_KNIGHT_INFO then
		self:showKnightInfo(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.CHOOSE_STORY then
		self:chooseStory(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.SHAKE_LAYER then
		self:shakeLayer(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.PLAY_NEXT_STORY then
		self:playNextStory(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.PLAY_SOUND then
		self:playSound(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.HIDE_DIAMASK then
		self:hideDiaMask(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.SHOW_DIAMASK then
		self:showDiaMask(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.INSERT_KNIGHT then
		self:insertKnight(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.INSERT_PICTURE then
		self:insertPicture(arg_9_1)
	elseif var_9_3 == var_0_2.STEP_TYPE.DELETE_INSERT_KNIGHT then
		self:deleteInsertKnight(arg_9_1)
	end
end

function StoryDialogLayer:endStep()
	if self._indexLock then
		self._indexLock = self._indexLock - 1

		if self._indexLock == 0 then
			self:endTalk()
			self:playNextStep()
		end
	end
end

function StoryDialogLayer:playBackground(arg_11_1)
	local var_11_0 = tonumber(arg_11_1.params.dis) or 0
	local var_11_1 = tonumber(arg_11_1.params.dis_y) or 0

	if arg_11_1.params.background and arg_11_1.params.background ~= "" then
		local var_11_2 = string.split(arg_11_1.params.background, ".")
		local var_11_3 = var_0_4:getBackground(var_11_2[1])

		if var_11_2[2] and var_11_2[2] == "png" then
			var_11_3 = string.gsub(var_11_3, ".jpg", ".png")
		end

		self.m_bgLoader:setURL(var_11_3)
		self.m_bgLoader:setPosition(cc.p(display.width / 2 + var_11_0, display.height / 2 + var_11_1))
		self:_setBgScale(var_11_0, var_11_1)
	end

	if arg_11_1.params.background_night then
		self.m_maskLoader:setURL((var_0_4:getBgMask(arg_11_1.params.background_night)))
		self.m_maskLoader:setPosition(cc.p(display.width / 2 + var_11_0, display.height / 2 + var_11_1))
	end

	self:endStep()
end

function StoryDialogLayer:_setBgScale(arg_12_1, arg_12_2)
	arg_12_1 = arg_12_1 < 0 and arg_12_1 * -2 or arg_12_1 * 2
	arg_12_2 = arg_12_2 < 0 and arg_12_2 * -2 or arg_12_2 * 2

	self.m_bgLoader:setSize(display.width + arg_12_1, display.height + arg_12_2)
end

function StoryDialogLayer:playKnightEffect(arg_13_1)
	local var_13_0 = self:getDiaKnight(arg_13_1.params.dindex)

	if not var_13_0 then
		self:endStep()

		return
	end

	local var_13_1 = var_13_0:getRoleId()

	self:sortChildIndex(var_13_1)
	self:setKnightDark(var_13_1)

	local var_13_2 = arg_13_1.params.path
	local var_13_3 = tonumber(arg_13_1.params.multi) == 1
	local var_13_4 = var_13_3 and -1 or tonumber(arg_13_1.params.count)
	local var_13_5 = self._nowIndex

	assert(var_13_4, "incorrect play times")

	local var_13_6

	var_13_6 = require("app.view.common.SpineBase").new({
		resId = "",
		path = var_13_2,
		isLoop = var_13_3,
		listener = function(self)
			if not var_13_6 then
				return
			end

			if self.type == "complete" then
				var_13_4 = var_13_4 - 1

				if var_13_4 == 0 then
					var_13_6:removeFromParent(true)

					self._effects[var_13_5] = nil

					self:endStep()
				elseif var_13_4 > 0 then
					var_13_6:setAnimation(0, "play", var_13_3)
				end
			end
		end
	})

	if not var_13_6 then
		self:endStep()

		return
	end

	local var_13_7 = tonumber(arg_13_1.params.x) or var_13_0:getSize().width / 2
	local var_13_8 = tonumber(arg_13_1.params.y) or var_13_0:getSize().height / 2
	local var_13_9 = tonumber(arg_13_1.params.scale) or 1

	var_13_6:setScale(var_13_9 * (tonumber(arg_13_1.params.flip) == 1 and -1 or 1), var_13_9)

	local var_13_10 = fgui.GComponent:create()

	var_13_10:setPosition(var_13_7, var_13_8)
	var_13_10:displayObject():addChild(var_13_6)

	self._effects[var_13_5] = {
		eff = var_13_10
	}

	var_13_0:addChild(var_13_10)

	if var_13_3 then
		self._effects[var_13_5].endIndex = tonumber(arg_13_1.params.endstep) or var_13_5

		self:endStep()
	end
end

function StoryDialogLayer:playEffect(arg_15_1)
	local var_15_0 = arg_15_1.params.path
	local var_15_1 = tonumber(arg_15_1.params.multi) == 1
	local var_15_2 = var_15_1 and -1 or tonumber(arg_15_1.params.count)
	local var_15_3 = self._nowIndex

	assert(var_15_2, "incorrect play times")

	local var_15_4

	if string.find(var_15_0, ".png") then
		var_15_1 = true
		var_15_4 = display.newSprite(var_15_0)
	else
		var_15_4 = require("app.view.common.SpineBase").new({
			resId = "",
			path = var_15_0,
			isLoop = var_15_1,
			listener = function(self)
				if not var_15_4 then
					return
				end

				if self.type == "complete" then
					var_15_2 = var_15_2 - 1

					if var_15_2 == 0 then
						var_15_4:removeFromParent(true)

						self._effects[var_15_3] = nil

						self:endStep()
					elseif var_15_2 > 0 then
						var_15_4:setAnimation(0, "play", var_15_1)
					end
				end
			end
		})
	end

	if not var_15_4 then
		self:endStep()

		return
	end

	local var_15_5 = tonumber(arg_15_1.params.x) or display.width / 2
	local var_15_6 = tonumber(arg_15_1.params.y) or display.height / 2
	local var_15_7 = self:formatX(var_15_5)
	local var_15_8 = self:formatY(var_15_6)
	local var_15_9 = tonumber(arg_15_1.params.scale) or 1

	var_15_4:setScale(var_15_9 * (tonumber(arg_15_1.params.flip) == 1 and -1 or 1), var_15_9)

	local var_15_10 = fgui.GComponent:create()

	var_15_10:setPosition(var_15_7, var_15_8)
	var_15_10:displayObject():addChild(var_15_4)
	var_15_10:setSortingOrder(tonumber(arg_15_1.params.zorder) or #self._diaKnights + 1)

	self._effects[var_15_3] = {
		eff = var_15_10
	}

	self:getView():addChild(var_15_10)

	if var_15_1 then
		self._effects[var_15_3].endIndex = tonumber(arg_15_1.params.endstep) or var_15_3

		self:endStep()
	end
end

function StoryDialogLayer:chooseStory(arg_17_1)
	if self._isAuto then
		self:_onAuto()
	end

	local var_17_0 = arg_17_1.params

	self.m_chooseBgImg:setVisible(true)

	function var_17_0.callback()
		self._autoBtn:setTouchable(true)
		self.m_chooseBgImg:setVisible(false)
		self:endStep()
	end

	self._autoBtn:setTouchable(false)
	self.m_holderComp:addChild(require("app.view.module.story.view.StoryChoosePop").new(var_17_0))
end

function StoryDialogLayer:clearAll()
	for iter_19_0 = #self._diaKnights, 1, -1 do
		self._diaKnights[iter_19_0]:clear()
	end

	if self._preSoundName then
		g.core.sound.SoundManager:stopSound(self._preSoundName)

		self._preSoundName = nil
	end

	g.core.sound.SoundManager:stopCurrentVoice()

	for iter_19_1, iter_19_2 in ipairs(self._scheduleHandlers) do
		self:cancelSchedule(iter_19_2)
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

	for iter_19_3, iter_19_4 in pairs(self._effects) do
		iter_19_4.eff:removeFromParent()
	end

	self._effects = {}

	if self._soundEndHandler then
		self:cancelSchedule(self._soundEndHandler)

		self._soundEndHandler = nil
	end
end

function StoryDialogLayer:finish(arg_20_1)
	if self._inEnd then
		return
	end

	if self.m_skipComp then
		self.m_skipComp:setVisible(false)
	end

	self._inEnd = true

	local var_20_0 = self._nowDialogId or 0

	if self._nowDialogId and self._nowDialogId > 0 then
		self._storyData:setDialogPlayed(self._nowDialogId)

		self._nowDialogId = nil
	end

	self:dispatchCompEvent(g.core.event.enum.EVENT_STORY_NOTICE, {
		id = var_20_0
	})

	if (self:_checkLastIsChoose() or self:_checkLastIsPlayNextStory() or self._isPlayingNext) and not arg_20_1 then
		self:clearAll()

		if g.core.model.User.storyData:getStoryAutoingState() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_AUTO_END_NOTICE, false, {})
		end

		var_0_3:onlyPopSelfByDisplay(self)

		if self:_checkLastIsPlayNextStory() and not self._isPostNextStoryEvent then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, true, {
				nostart = true,
				id = tonumber(clone(self._nextStoryData).params.storyid)
			})
		end

		return
	end

	if #self._diaKnights > 0 then
		for iter_20_0, iter_20_1 in ipairs(self._diaKnights) do
			if iter_20_1 and iter_20_1.hide then
				iter_20_1:hide({
					isfade = 0
				})
			end
		end
	end

	if g.core.model.User.storyData:getStoryAutoingState() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_AUTO_END_NOTICE, false, {})
	end

	self:clearAll()

	local var_20_1 = self.m_dialogComp:getTransition("hide")

	if var_20_1 then
		var_20_1:play()
	end

	local var_20_2 = self._storyData:getTriggerType()
	local var_20_3 = self._storyData:getTriggerData()
	local var_20_4 = self._storyData:getChooseIndex()

	self:getView():getTransition("allHide"):play(function()
		self:dispatchCompEvent(g.core.event.enum.EVENT_STORY_END, {
			isDialog = true,
			chooseIndex = var_20_4,
			trigger_type = var_20_2,
			trigger_data = var_20_3,
			triggerTaskId = self._triggerTaskId
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_END, false, {
			id = var_20_0
		})
		var_0_3:onlyPopSelfByDisplay(self)
	end)
end

function StoryDialogLayer:doAutoAction()
	if self.m_holderComp:getChild("StoryChoosePop") then
		self.m_holderComp:getChild("StoryChoosePop"):doAutoAction()
	end
end

function StoryDialogLayer:onUnload()
	self:clearAll()
	g.core.sound.SoundManager:stopCurrentVoice()
end

return StoryDialogLayer
