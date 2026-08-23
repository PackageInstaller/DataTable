local StoryStep = class("StoryStep")
local var_0_1 = g.core.const.ConstMgr.StoryConst
local var_0_2 = g.core.const.ConstMgr.SpineConst
local TypeWriter = require("app.view.common.TypeWriter")
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.common.Path
local var_0_6 = 1
local var_0_7 = {
	cc.p(display.width / 3 / 2, display.height / 2 + 150),
	cc.p(display.width / 2, display.height / 2 + 150),
	cc.p(display.width / 3 * 2 + display.width / 6, display.height / 2 + 150)
}

function StoryStep:ctor()
	return
end

function StoryStep:initParams()
	self:addClickListener(handler(self, self._onClick))

	self._skipBtn = self.m_skipComp:getChild("skipBtn")

	self._skipBtn:addClickListener(handler(self, self._onClickSkip))

	self._autoBtn = self.m_skipComp:getChild("autoBtn")

	self._autoBtn:addClickListener(handler(self, self._onAuto))

	self._reviewBtn = self.m_skipComp:getChild("reviewBtn")

	self._reviewBtn:addClickListener(handler(self, self._onReview))

	self._effects = {}
	self._typeWriter = nil
	self._scheduleHandlers = {}
	self._alreadyDelayTime = 0
	self._delayList = {}
	self._delayScheduleHandler = nil
	self._isPlayingNext = false
	self._diaKnights = {}
	self._insertKnights = {}
	self._drawKnightRoleIdArr = {}
	self._nowIndex = 0
	self._indexMax = #self._data
	self._indexLock = 1
	self._inDialog = false
	self._inSkip = false
	self._inEnd = false
	self._preSoundName = nil
	self._isAuto = true

	self._autoBtn:getChild("autoIcon"):setURL(var_0_5:getStoryAutoURL(self._isAuto))

	local var_2_0 = self._autoBtn:getTransition("loop")

	if var_2_0 then
		var_2_0:play()
	end

	self._storyData = g.core.model.User.storyData

	self._storyData:setStoryAutoingState(self._isAuto)

	self._preDialogRoleId = -1
	self._isAllAutoDialogFinish = false
	self._isPostNextStoryEvent = false
	self._nextStoryData = {}
	self._isTypeWriteFinishWhenAuto = false
	self._isKnightDialogSoundFinish = false
	self._isHasKnightDialogSound = false
	self._isExcuteSoundEndCallBack = false
	self._autoNextHandler = nil

	if self._storyId == g.core.const.ConstMgr.StoryConst.CREATE_ROLE_CG_STEP then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst.PLAY_CREATE_ROLE_CG
		})
		print("_isEnded --> ")
	end
end

function StoryStep:_playDialogSound(arg_3_1)
	self._isKnightDialogSoundFinish = false
	self._isHasKnightDialogSound = false

	if arg_3_1.soundpath and arg_3_1.soundpath ~= "" then
		self._isHasKnightDialogSound = true

		local var_3_0 = g.core.guide.GuideProxy:isGuideRunning()

		if g.core.utils.Quality.needUnLoadSoundBank() and not var_3_0 then
			self._isHasKnightDialogSound = false
		end

		local var_3_1 = self._storyData:formatSoundPath(arg_3_1.soundpath, arg_3_1.role)

		if self._preSoundName then
			g.core.sound.SoundManager:stopSound(self._preSoundName)
		end

		g.core.sound.SoundManager:stopAllSounds()

		if self._isHasKnightDialogSound then
			self._isExcuteSoundEndCallBack = false
			self._soundEndHandler = self:newScheduleOnce(handler(self, function()
				self:_playSoundEnd()
			end), (var_3_0 or nil) and var_0_1.DIALOG_SOUND_TIME_IN_GUIDE)

			g.core.sound.SoundManager:playSound(var_3_1, handler(self, self._playSoundEnd))
		else
			g.core.sound.SoundManager:playSound(var_3_1)
		end

		self._preSoundName = var_3_1
	end
end

function StoryStep:_playSoundEnd()
	if not self._isExcuteSoundEndCallBack then
		if self._soundEndHandler then
			self:cancelSchedule(self._soundEndHandler)

			self._soundEndHandler = nil
		end

		self._isExcuteSoundEndCallBack = true
		self._isKnightDialogSoundFinish = true

		if self._typeWriterEndWhenAutoModel then
			self:_typeWriterEndWhenAutoModel()
		end
	end
end

function StoryStep:getSoundWaveConfig(arg_6_1)
	return (arg_6_1.soundpath and arg_6_1.soundpath ~= "" or nil) and self._storyData:getSoundWaveConfig(arg_6_1.soundpath)
end

function StoryStep:getDiaKnight(arg_7_1)
	if #self._drawKnightRoleIdArr > 1 then
		table.sort(self._drawKnightRoleIdArr, function(arg_8_0, arg_8_1)
			return arg_8_0.roleId < arg_8_1.roleId
		end)
	end

	local var_7_0 = (self._drawKnightRoleIdArr[arg_7_1] or {}).roleId
	local var_7_1

	for iter_7_0, iter_7_1 in ipairs(self._diaKnights) do
		if iter_7_1:getRoleId() == var_7_0 then
			var_7_1 = iter_7_1
		end
	end

	return var_7_1
end

function StoryStep:deleteDiaKnight(arg_9_1)
	local var_9_0 = 1

	for iter_9_0, iter_9_1 in ipairs(self._diaKnights) do
		if iter_9_1:getRoleId() == arg_9_1 then
			var_9_0 = iter_9_0
		end
	end

	if next(self._diaKnights) and self._diaKnights[var_9_0] then
		self._diaKnights[var_9_0]:removeFromParent()
		table.remove(self._diaKnights, var_9_0)
	end
end

function StoryStep:clearDiaKnight()
	for iter_10_0, iter_10_1 in ipairs(self._diaKnights) do
		iter_10_1:removeFromParent()

		iter_10_1 = nil
	end

	self._diaKnights = {}
end

function StoryStep:setKnightDark(arg_11_1)
	arg_11_1 = arg_11_1 and arg_11_1 or -1

	for iter_11_0, iter_11_1 in ipairs(self._diaKnights) do
		if iter_11_1:getRoleId() ~= arg_11_1 then
			iter_11_1:setDark(true)
		else
			iter_11_1:setDark(false)
		end
	end
end

function StoryStep:setKnightBlackShadow(arg_12_1)
	arg_12_1 = arg_12_1 and arg_12_1 or -1

	for iter_12_0, iter_12_1 in ipairs(self._diaKnights) do
		if iter_12_1:getRoleId() == arg_12_1 then
			iter_12_1:setBlackShadow(true)
		end
	end
end

function StoryStep:diaFrameVis(arg_13_1, arg_13_2)
	if self.m_dialogComp:isVisible() == arg_13_1 then
		if arg_13_2 then
			arg_13_2()
		end

		return
	end

	if arg_13_1 == true then
		self.m_dialogComp:setVisible(arg_13_1)
		self.m_dialogComp:getTransition("enter"):play(handler(self, function(arg_14_0)
			if arg_13_2 then
				arg_13_2()
			end
		end))
	else
		self.m_dialogComp:getTransition("back"):play(handler(self, function(arg_15_0)
			arg_15_0.m_dialogComp:setVisible(arg_13_1)

			if arg_13_2 then
				arg_13_2()
			end
		end))
	end

	self.m_knightComp:setVisible(arg_13_1)
end

function StoryStep:endTalk()
	for iter_16_0, iter_16_1 in ipairs(self._diaKnights) do
		iter_16_1:endTalk()
	end

	if self._preSoundName then
		g.core.sound.SoundManager:stopSound(self._preSoundName)

		self._preSoundName = nil
	end
end

function StoryStep:sortChildIndex(arg_17_1)
	local var_17_0 = 1

	for iter_17_0, iter_17_1 in ipairs(self._diaKnights) do
		if iter_17_1:getRoleId() == arg_17_1 then
			var_17_0 = iter_17_0
		end

		iter_17_1:setSortingOrder(iter_17_0)
	end

	if next(self._diaKnights) then
		self._diaKnights[var_17_0]:setSortingOrder(#self._diaKnights + 1)
	end
end

function StoryStep:formatX(arg_18_1)
	return arg_18_1 + (display.width - 1334) / 2
end

function StoryStep:formatY(arg_19_1)
	arg_19_1 = arg_19_1 + (arg_19_1 > 0 and 1 or -1) * math.max(0, display.height - CC_DESIGN_RESOLUTION.height) / 2

	return arg_19_1
end

function StoryStep:_onClick()
	if self._typeWriter then
		self._typeWriter:finish()

		self._typeWriter = nil
	end
end

function StoryStep:_playText(arg_21_1, arg_21_2, arg_21_3)
	self._typeWriter = TypeWriter.new({
		label = arg_21_1,
		str = arg_21_2,
		callback = handler(self, function()
			self._typeWriter = nil

			if self._isAuto then
				self._isTypeWriteFinishWhenAuto = true

				self:_typeWriterEndWhenAutoModel()
			end

			if arg_21_3 then
				arg_21_3()
			end
		end)
	})

	if self._typeWriter then
		self._isTypeWriteFinishWhenAuto = false

		self._typeWriter:start()
	end
end

function StoryStep:_onCheckSkipStoryAndStats(arg_23_1)
	local var_23_0 = ({
		[g.core.const.ConstMgr.StoryConst.CREATE_ROLE_CG_STEP] = g.core.const.ConstMgr.StoryConst.CREATE_ROLE_JUMP_CG_STATS_ID
	})[arg_23_1]

	if var_23_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = var_23_0
		})
	end
end

function StoryStep:_onClickSkip()
	if self:_isForbidClickNow(1, self._skipBtn) then
		return
	end

	if self._isAllAutoDialogFinish then
		return
	end

	if self._storyId == 30001 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst.SHOW_JUMP_CG_POP
		})
	end

	var_0_4:pushPopup(require("app.view.module.story.view.StorySkipPop").new({
		storyId = self._storyId,
		backFunc = handler(self, function(arg_25_0)
			if arg_25_0.m_skipComp then
				arg_25_0.m_skipComp:setVisible(true)
			end

			if not tolua.isnull(arg_25_0) then
				arg_25_0:pauseStorySoundByFlag(false)
			end
		end),
		skipFunc = handler(self, function(arg_26_0)
			if arg_26_0 and arg_26_0._inEnd == false then
				arg_26_0:setVisible(false)

				if arg_26_0._inSkip then
					return
				end

				arg_26_0._inSkip = true

				arg_26_0:clearAll()
				arg_26_0:_onCheckSkipStoryAndStats(arg_26_0._storyId)
				arg_26_0:finish(true)
			end
		end)
	}))

	if not tolua.isnull(self) then
		self:pauseStorySoundByFlag(true)
	end
end

function StoryStep:_onAuto()
	self._isAuto = not self._isAuto

	if self._isAuto then
		local var_27_0 = self._autoBtn:getTransition("loop")

		if var_27_0 then
			var_27_0:play()
		end

		if self._inDialog and self._typeWriter == nil then
			self:endStep()
		end
	else
		local var_27_1 = self._autoBtn:getTransition("loop")

		if var_27_1 then
			var_27_1:stop()
		end
	end

	self._autoBtn:getChild("autoIcon"):setURL(var_0_5:getStoryAutoURL(self._isAuto))
	g.core.model.User.storyData:setStoryAutoingState(self._isAuto)
end

function StoryStep:_onReview()
	if self._isAllAutoDialogFinish then
		return
	end

	self.m_skipComp:setVisible(false)
	var_0_4:pushPopup(require("app.view.module.story.view.StoryReviewPop").new({
		data = self._data,
		nowIndex = self._nowIndex,
		func = handler(self, function(arg_29_0)
			if arg_29_0 and arg_29_0.m_skipComp then
				arg_29_0.m_skipComp:setVisible(true)
			end
		end)
	}))
end

function StoryStep:_checkRemoveEffects()
	for iter_30_0, iter_30_1 in pairs(self._effects) do
		if iter_30_1.endIndex and iter_30_1.endIndex < self._nowIndex then
			iter_30_1.eff:removeFromParent(true)

			self._effects[iter_30_0] = nil
		end
	end
end

function StoryStep:playNextStep()
	self._nowIndex = self._nowIndex + 1

	if self._nowIndex > self._indexMax then
		table.insert(self._scheduleHandlers, (self:newScheduleOnce(function()
			self:finish()
		end, 0)))

		return
	end

	self._indexLock = 1

	self:playWithDelaytime(self._data[self._nowIndex], 0)

	for iter_31_0 = self._nowIndex + 1, self._indexMax do
		if self._data[iter_31_0].playtype == var_0_1.STEP_PLAY_TYPE.WITH_LAST then
			self._nowIndex = iter_31_0

			self:playWithDelaytime(self._data[iter_31_0], iter_31_0 - self._nowIndex)
		else
			break
		end
	end
end

function StoryStep:playWithDelaytime(arg_33_1, arg_33_2)
	local var_33_0 = tonumber(arg_33_1.playparams[1]) or 0

	if var_33_0 == 0 then
		self:playSingleStep(arg_33_1)
	else
		self._delayScheduleHandler = self._delayScheduleHandler or self:newSchedule(function(arg_34_0, arg_34_1)
			self._alreadyDelayTime = self._alreadyDelayTime + arg_34_1 * 1000

			if #self._delayList == 0 then
				self:cancelSchedule(self._delayScheduleHandler)

				self._delayScheduleHandler = nil
				self._alreadyDelayTime = 0
			elseif self._alreadyDelayTime > self._delayList[1].delay then
				self:playSingleStep(self._delayList[1].step)
				table.remove(self._delayList, 1)
			end
		end, 0)
		self._delayList[#self._delayList + 1] = {
			delay = var_33_0 * 1000,
			step = arg_33_1
		}
	end
end

function StoryStep:endStep()
	if self._indexLock then
		self._indexLock = self._indexLock - 1

		if self._indexLock == 0 then
			self:playNextStep()
		end
	end
end

function StoryStep:_checkLastIsChoose()
	if not self._data or not next(self._data) then
		return false
	end

	return self._data[self._indexMax].type == var_0_1.STEP_TYPE.CHOOSE_STORY
end

function StoryStep:_checkLastIsPlayNextStory()
	if not self._data or not next(self._data) then
		return false
	end

	return self._data[self._indexMax].type == var_0_1.STEP_TYPE.PLAY_NEXT_STORY
end

function StoryStep:_checkNextChoose()
	return self._data[self._nowIndex + 1] and self._data[self._nowIndex + 1].type == var_0_1.STEP_TYPE.CHOOSE_STORY
end

function StoryStep:playDarkCurtain(arg_39_1)
	var_0_4:pushModule(g.view.entrance.STORY_DARK_CURTAIN, {
		str = arg_39_1.params.str,
		transparent = arg_39_1.params.transparent,
		showtrans = arg_39_1.params.showtrans,
		usecenter = arg_39_1.params.usecenter,
		callback = handler(self, self.endStep),
		changeSkipStateCallBack = handler(self, function(arg_40_0, arg_40_1)
			if arg_40_0.m_skipComp then
				arg_40_0.m_skipComp:setVisible(arg_40_1)
			end
		end),
		soundpath = arg_39_1.params.soundpath
	})
end

function StoryStep:playDialog(arg_41_1)
	local var_41_0 = arg_41_1.params
	local var_41_1 = tonumber(arg_41_1.params.pos) or 1
	local var_41_2 = arg_41_1.params.role
	local var_41_3 = self._storyData:getRoleData(arg_41_1.params.role)
	local var_41_4 = tonumber(arg_41_1.params.flip) == 1
	local var_41_5 = tonumber(arg_41_1.params.dis_x) or 0
	local var_41_7 = (tonumber(arg_41_1.params.dis_y) or 0) + (tonumber(var_41_3.baseInfo.story_pos_y) or 0)
	local var_41_8 = tonumber(arg_41_1.params.scale) or 1
	local var_41_9

	if arg_41_1.params.ani then
		var_41_9 = arg_41_1.params.ani or var_0_2.LOOP_DRAW_ACTION.TALK
	end

	local var_41_10 = tonumber(arg_41_1.params.isShadow) == 1
	local var_41_11 = string.len(arg_41_1.params.str) / 50
	local var_41_12 = self:getSoundWaveConfig(arg_41_1.params)

	if var_41_12 and var_41_12 ~= "" then
		var_41_9 = ""
		var_41_11 = 0
	end

	local var_41_13 = tonumber(arg_41_1.params.pos_type or var_0_1.POS_TYPE.FOR_POS)
	local var_41_14 = tonumber(arg_41_1.params.ani_order) or var_0_1.ANI_ORDER.ON

	if self.m_dialogComp:isVisible() == true and self._preDialogRoleId ~= tonumber(var_41_2) then
		self.m_dialogComp:getTransition("switch"):play()
	end

	self._preDialogRoleId = tonumber(var_41_2)

	self:diaFrameVis(true)

	local function var_41_15(arg_42_0)
		self._lblDialog:setText("")
		self:_playText(self._lblDialog, var_41_0.str, arg_42_0)

		self._inDialog = true

		if var_41_11 > 0 then
			table.insert(self._scheduleHandlers, (self:newScheduleOnce(function()
				self:endTalk()
			end, var_41_11)))
		end
	end

	if var_41_3 and var_41_1 ~= var_0_1.DIALOG_KNI_POS.NONE then
		local var_41_16

		for iter_41_0, iter_41_1 in ipairs(self._diaKnights) do
			if iter_41_1:getRoleId() == var_41_2 then
				var_41_16 = iter_41_1

				break
			end
		end

		if not var_41_16 then
			var_41_16 = fgui.UIPackage:createObject("story", "StoryDialogKnightComp")

			if var_41_13 == var_0_1.POS_TYPE.FOR_POS then
				var_41_16:setPosition(cc.p(var_0_7[var_41_1].x, var_0_7[var_41_1].y + var_41_7))
			elseif var_41_13 == var_0_1.POS_TYPE.GOTO_RIGHT then
				var_41_16:setPosition((cc.p(display.width / (#self._diaKnights + 1) / 2, var_0_7[var_41_1].y + var_41_7)))

				for iter_41_2, iter_41_3 in ipairs(self._diaKnights) do
					self._diaKnights[iter_41_2]:stopAllFGActions()
					self._diaKnights[iter_41_2]:runFGAction(fgui.FSequence:create((fgui.FMoveTo:create(0.5, cc.p(display.width - display.width / (#self._diaKnights + 1) / 2 - display.width / (#self._diaKnights + 1) * (iter_41_2 - 1), self._diaKnights[iter_41_2]:getPosition().y)))))
				end
			elseif var_41_13 == var_0_1.POS_TYPE.GOTO_MIDDLE then
				if #self._diaKnights < 2 then
					local var_41_17 = 0

					if #self._diaKnights > 0 and #self._diaKnights == 1 then
						var_41_17 = (display.width - CC_DESIGN_RESOLUTION.width) / (#self._diaKnights + 1) / 2
					end

					var_41_16:setPosition((cc.p(display.width / (#self._diaKnights + 1) / 2 + var_41_17, var_0_7[var_41_1].y + var_41_7)))

					for iter_41_4, iter_41_5 in ipairs(self._diaKnights) do
						self._diaKnights[iter_41_4]:stopAllFGActions()
						self._diaKnights[iter_41_4]:runFGAction(fgui.FSequence:create((fgui.FMoveTo:create(0.5, cc.p(display.width - display.width / (#self._diaKnights + 1) / 2 - var_41_17 - display.width / (#self._diaKnights + 1) * (iter_41_4 - 1), self._diaKnights[iter_41_4]:getPosition().y)))))
					end
				else
					var_41_16:setPosition((cc.p(3 * (display.width / (#self._diaKnights + 1) / 2), var_0_7[var_41_1].y + var_41_7)))

					for iter_41_6, iter_41_7 in ipairs(self._diaKnights) do
						local var_41_18 = self._diaKnights[iter_41_6]

						self._diaKnights[iter_41_6]:stopAllFGActions()
						var_41_18:runFGAction(fgui.FSequence:create(iter_41_6 == 1 and fgui.FMoveTo:create(0.5, cc.p(display.width - display.width / (#self._diaKnights + 1) / 2 - display.width / (#self._diaKnights + 1) * (iter_41_6 - 1), var_41_18:getPosition().y)) or iter_41_6 == 2 and fgui.FMoveTo:create(0.5, cc.p(display.width - display.width / (#self._diaKnights + 1) / 2 - display.width / (#self._diaKnights + 1) * #self._diaKnights, var_41_18:getPosition().y)) or fgui.FMoveTo:create(0.5, cc.p(display.width - display.width / (#self._diaKnights + 1) / 2 - display.width / (#self._diaKnights + 1) * (iter_41_6 - 2), var_41_18:getPosition().y))))
					end
				end
			end

			table.insert(self._diaKnights, var_41_16)
			table.insert(self._drawKnightRoleIdArr, {
				roleId = var_41_2
			})
			self.m_knightComp:addChild(var_41_16)
		end

		self._lblName:setText((self._storyData:getKnightShowName(var_41_3, arg_41_1.params)))

		local function var_41_20()
			local var_45_0 = var_41_16:getPosition()

			var_41_16:runFGAction(fgui.FSequence:create((fgui.FMoveTo:create(0.5, cc.p(var_41_5 + var_45_0.x, var_45_0.y)))))
		end

		;(function()
			var_41_16:update(var_41_0)
			var_41_16:setScale(var_41_8)
			var_41_16:setFlip(var_41_4)
			self:_playDialogSound(var_41_0)

			if var_41_9 and var_41_9 ~= "" then
				if var_41_9 == var_0_2.LOOP_DRAW_ACTION.TALK then
					var_41_14 = var_0_1.ANI_ORDER.ON
				end

				if var_41_14 == var_0_1.ANI_ORDER.BEFORE then
					var_41_16:playAction(var_41_9, function()
						var_41_20()
						var_41_15()
					end)
				elseif var_41_14 == var_0_1.ANI_ORDER.ON then
					var_41_15()
					var_41_20()
					var_41_16:playAction(var_41_9)
				else
					var_41_15(function()
						var_41_20()
						var_41_16:playAction(var_41_9)
					end)
				end
			else
				if var_41_12 and var_41_12 ~= "" then
					var_41_16:playKouXing(var_41_12)
				else
					var_41_16:playTalk()
				end

				var_41_15()
			end
		end)()

		if var_41_10 then
			self:setKnightBlackShadow(var_41_16:getRoleId())
		else
			self:setKnightDark(var_41_16:getRoleId())
		end

		self:sortChildIndex(var_41_16:getRoleId())
	else
		self._lblName:setText("")
		;(function(arg_44_0)
			self:_playDialogSound(var_41_0)
			var_41_15(arg_44_0)
		end)()
		self:setKnightDark()
	end
end

function StoryStep:playSound(arg_49_1)
	local var_49_0 = arg_49_1.params.soundpath
	local var_49_1 = tonumber(arg_49_1.params.loop) == 1
	local var_49_2 = tonumber(arg_49_1.params.time) or 5
	local var_49_3 = tonumber(arg_49_1.params.fadein) == 1
	local var_49_4 = tonumber(arg_49_1.params.fadeout) == 1

	if self._preSoundName then
		g.core.sound.SoundManager:stopSound(self._preSoundName)
	end

	g.core.sound.SoundManager:playSound(var_49_0)

	self._preSoundName = var_49_0

	if var_49_1 then
		local var_49_5 = var_49_2 * 1000
		local var_49_6 = 0
		local var_49_7

		var_49_7 = self:newSchedule(function(arg_50_0, arg_50_1)
			var_49_6 = var_49_6 + arg_50_1 * 1000

			if var_49_6 < 1000 and var_49_3 then
				g.core.sound.SoundManager:setSoundsVolume(var_49_6 / 1000)
			elseif var_49_6 > var_49_5 - 1000 and var_49_6 < var_49_5 and var_49_4 then
				g.core.sound.SoundManager:setSoundsVolume((var_49_5 - var_49_6) / 1000)
			elseif var_49_6 > var_49_5 then
				self:cancelSchedule(var_49_7)
				g.core.sound.SoundManager:stopSound(var_49_0)
				self:playSoundEnd()
			end
		end, 0)

		table.insert(self._scheduleHandlers, nil)
	else
		self:playSoundEnd()
	end
end

function StoryStep:playSoundEnd()
	self:endStep()
end

function StoryStep:playNextStory(arg_52_1)
	self._nextStoryData = arg_52_1

	local var_52_0 = tonumber(arg_52_1.params.storyid)

	if var_52_0 then
		table.insert(self._scheduleHandlers, (self:newScheduleOnce(handler(self, function()
			self._isPostNextStoryEvent = true

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, true, {
				nostart = true,
				id = var_52_0
			})
		end), 0)))
	end

	self:endStep()
end

function StoryStep:shakeLayer(arg_54_1)
	local var_54_0 = tonumber(arg_54_1.params.time) or 0.3

	self:runFGAction((fgui.FSequence:create(fgui.FEaseQuinticActionOut:create(fgui.FMoveBy:create(var_54_0 / 16, {
		x = -var_0_1.SHAKE_DIS,
		y = -var_0_1.SHAKE_DIS / 2
	})), fgui.FEaseQuinticActionOut:create(fgui.FMoveBy:create(var_54_0 / 16 * 2, {
		x = var_0_1.SHAKE_DIS * 2,
		y = var_0_1.SHAKE_DIS
	})), fgui.FEaseQuinticActionOut:create(fgui.FMoveBy:create(var_54_0 / 16 * 2, {
		x = -var_0_1.SHAKE_DIS * 3 / 2,
		y = -var_0_1.SHAKE_DIS * 3 / 4
	})), fgui.FEaseQuinticActionOut:create(fgui.FMoveBy:create(var_54_0 / 16 * 2, {
		x = var_0_1.SHAKE_DIS,
		y = var_0_1.SHAKE_DIS / 2
	})), fgui.FEaseQuinticActionOut:create(fgui.FMoveBy:create(var_54_0 / 16 * 2, {
		x = -var_0_1.SHAKE_DIS * 3 / 4,
		y = -var_0_1.SHAKE_DIS * 3 / 8
	})), fgui.FEaseQuinticActionOut:create(fgui.FMoveBy:create(var_54_0 / 16 * 2, {
		x = var_0_1.SHAKE_DIS / 2,
		y = var_0_1.SHAKE_DIS / 4
	})), fgui.FEaseQuinticActionOut:create(fgui.FMoveBy:create(var_54_0 / 16 * 2, {
		x = -var_0_1.SHAKE_DIS / 2,
		y = -var_0_1.SHAKE_DIS / 4
	})), fgui.FEaseQuinticActionOut:create(fgui.FMoveBy:create(var_54_0 / 16 * 2, {
		x = var_0_1.SHAKE_DIS / 2,
		y = var_0_1.SHAKE_DIS / 4
	})), fgui.FEaseQuinticActionOut:create(fgui.FMoveBy:create(var_54_0 / 16, {
		x = -var_0_1.SHAKE_DIS / 4,
		y = -var_0_1.SHAKE_DIS / 8
	})), fgui.FCallFunc:create(function()
		self:endStep()
	end))))
end

function StoryStep:moveEffect(arg_56_1)
	local var_56_0

	for iter_56_0, iter_56_1 in pairs(self._effects) do
		if iter_56_1.path == arg_56_1.params.eindex then
			var_56_0 = iter_56_1.eff
		end
	end

	if var_56_0 then
		local var_56_1 = tonumber(arg_56_1.params.x) or display.width / 2
		local var_56_2 = self:formatY(-(tonumber(arg_56_1.params.y) or display.height / 2))
		local var_56_3 = tonumber(arg_56_1.params.time) or 1

		if var_56_3 == 0 then
			var_56_0:setPosition(var_56_1, -var_56_2)
			self:endStep()
		else
			var_56_0:runAction((cc.Sequence:create(cc.MoveTo:create(var_56_3, {
				x = var_56_1,
				y = var_56_2
			}), cc.CallFunc:create(function()
				self:endStep()
			end))))
		end
	end
end

function StoryStep:showKnightInfo(arg_58_1)
	self:endStep()
end

function StoryStep:hideDiaFrame(arg_59_1)
	if tonumber(arg_59_1.params.isclear) == 1 then
		self:clearDiaKnight()
	end

	if tonumber(arg_59_1.params.isBlack) == 1 then
		if not self._blackTransitionComp then
			self._blackTransitionComp = fgui.UIPackage:createObject("base_new", "BaseEnterTransComp")

			self._blackTransitionComp:setPosition(display.cx, display.cy)
			self._blackTransitionComp:setSize(display.width, display.height)
			self:addChild(self._blackTransitionComp)
		end

		self.m_dialogComp:setVisible(false)
		self._blackTransitionComp:onPlayEnterTransition(nil, {
			toRight = false,
			animIndex = 2,
			callback = handler(self, self.endStep)
		})

		return
	end

	self:diaFrameVis(false, handler(self, self.endStep))
end

function StoryStep:hideDiaKnight(arg_60_1)
	local var_60_0 = self:getDiaKnight(arg_60_1.params.dindex)

	if not var_60_0 then
		self:endStep()

		return
	end

	if tonumber(arg_60_1.params.isvis) == 1 then
		self:deleteDiaKnight(var_60_0:getRoleId())
		self:endStep()
	else
		var_60_0:hide(arg_60_1.params, handler(self, self.endStep))
	end
end

function StoryStep:showDiaKnight(arg_61_1)
	local var_61_0 = self:getDiaKnight(arg_61_1.params.dindex)

	if not var_61_0 then
		self:endStep()

		return
	end

	var_61_0:show(arg_61_1.params, handler(self, self.endStep))
end

function StoryStep:flipDiaKnight(arg_62_1)
	local var_62_0 = self:getDiaKnight(arg_62_1.params.dindex)

	if not var_62_0 then
		self:endStep()

		return
	end

	var_62_0:setFlip(true)
	self:endStep()
end

function StoryStep:moveDiaKnight(arg_63_1)
	local var_63_0 = self:getDiaKnight(arg_63_1.params.dindex)

	if not var_63_0 then
		self:endStep()

		return
	end

	var_63_0:runFGAction(fgui.FSequence:create(fgui.FMoveBy:create(tonumber(arg_63_1.params.time) or 0.5, cc.p(tonumber(arg_63_1.params.x) or 0, tonumber(arg_63_1.params.y) or 0)), (fgui.FCallFunc:create(handler(self, function(arg_64_0)
		arg_64_0:endStep()
	end)))))
end

function StoryStep:hideDiaMask()
	if self.m_dialogMask then
		self.m_dialogMask:setVisible(false)
	end

	self:endStep()
end

function StoryStep:showDiaMask(arg_66_1)
	if arg_66_1 then
		local var_66_0 = tonumber(arg_66_1.params.bgShadowID)

		if var_66_0 then
			local var_66_1 = var_0_5:getBgMask(var_66_0)

			if self.m_dialogMask then
				if cc.FileUtils:getInstance():isFileExist(var_66_1) then
					self.m_dialogMask:setURL(var_66_1)
				end
			end
		end
	end

	self:endStep()
end

function StoryStep:insertKnight(arg_67_1)
	local var_67_0 = arg_67_1.params
	local var_67_1 = arg_67_1.params.pos or 1
	local var_67_2 = arg_67_1.params.role
	local var_67_3 = self._storyData:getRoleData(arg_67_1.params.role)
	local var_67_4 = tonumber(arg_67_1.params.flip) == 1

	if not tonumber(arg_67_1.params.dis_x) then
		-- block empty
	end

	local var_67_7 = (tonumber(arg_67_1.params.dis_y) or 0) + (tonumber(var_67_3.baseInfo.story_pos_y) or 0)
	local var_67_8 = tonumber(arg_67_1.params.scale) or 1

	if var_67_3 and var_67_1 ~= var_0_1.DIALOG_KNI_POS.NONE then
		local var_67_9 = fgui.UIPackage:createObject("story", "StoryDialogKnightComp")

		var_67_9:setPosition(cc.p(var_0_7[var_67_1].x, var_0_7[var_67_1].y + var_67_7))
		table.insert(self._insertKnights, var_67_9)

		var_67_9.roleId = var_67_9.roleId or var_67_2

		self.m_knightComp:addChild(var_67_9)

		arg_67_1.params.defaultColorValue = arg_67_1.params.defaultColorValue or 1

		;(function()
			var_67_9:update(var_67_0)
			var_67_9:setScale(var_67_8)
			var_67_9:setFlip(var_67_4)
		end)()

		if tonumber(arg_67_1.params.isShadow) == 1 then
			var_67_9:setBlackShadow(true)
		else
			var_67_9:setDark(true)
		end
	end

	self:endStep()
end

function StoryStep:deleteInsertKnight(arg_69_1)
	if arg_69_1.params.role then
		local var_69_0

		for iter_69_0, iter_69_1 in ipairs(self._insertKnights) do
			if iter_69_1:getRoleId() == arg_69_1.params.role then
				var_69_0 = iter_69_0

				break
			end
		end

		if var_69_0 and next(self._insertKnights) and self._insertKnights[var_69_0] then
			self._insertKnights[var_69_0]:removeFromParent()
			table.remove(self._insertKnights, var_69_0)
		end
	end

	self:endStep()
end

function StoryStep:insertPicture(arg_70_1)
	if arg_70_1 then
		local var_70_0

		if arg_70_1.params.picName then
			var_70_0 = arg_70_1.params.picName or ""
		end

		local var_70_1 = var_0_5:getStoryInsertDialogPic(var_70_0)

		if var_70_0 ~= "" then
			if cc.FileUtils:getInstance():isFileExist(var_70_1) then
				self.m_skipComp:setVisible(false)
				var_0_4:pushPopup(require("app.view.module.story.view.StoryShowItemPicPop").new({
					stepData = arg_70_1.params,
					itemPath = var_70_1,
					endFunc = handler(self, function()
						if self.m_skipComp and self.endStep then
							self.m_skipComp:setVisible(true)
							self:endStep()
						end
					end)
				}), {
					touchDisappear = false,
					hideContinue = true
				})

				goto label_70_0
			end
		end

		self:endStep()
	end

	::label_70_0::
end

function StoryStep:_isForbidClickNow(arg_72_1, arg_72_2)
	if not arg_72_2 then
		return false
	end

	local var_72_0 = os.time()

	if arg_72_1 < var_72_0 - (arg_72_2.targetLatestClickTime or 0) then
		arg_72_2.targetLatestClickTime = var_72_0

		return false
	else
		return true
	end
end

function StoryStep:_forbidSkipWhenWriterAutoFinish()
	if self._nowIndex + 1 > self._indexMax then
		self._isAllAutoDialogFinish = true
	end
end

function StoryStep:_typeWriterEndWhenAutoModel()
	if not self._isAuto then
		return
	end

	if self._isTypeWriteFinishWhenAuto then
		if self._isHasKnightDialogSound and not self._isKnightDialogSoundFinish then
			return
		end

		self:_forbidSkipWhenWriterAutoFinish()

		local var_74_0 = self:newScheduleOnce(function()
			self:endStep()
		end, var_0_6)

		self._autoNextHandler = var_74_0

		table.insert(self._scheduleHandlers, var_74_0)
	end
end

function StoryStep:pauseStorySoundByFlag(arg_76_1)
	return
end

return StoryStep
