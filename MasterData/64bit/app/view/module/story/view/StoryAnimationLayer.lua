local StoryAnimationLayer = class("StoryAnimationLayer", require("app.view.module.story.StoryStep"), require("app.fairyGUI.story.UI_StoryAnimationLayer"), function()
	return fgui.GComponent:create({
		pkgName = "story",
		isFullScreen = true,
		pkgPath = "ui/story/story",
		resName = "StoryAnimationLayer"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.StoryConst
local BGFactory = require("app.view.common.BGFactory")
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.const.ConstMgr.SpineConst

function StoryAnimationLayer:ctor(arg_2_1)
	self._storyData = g.core.model.User.storyData

	local var_2_0 = arg_2_1.isEditor or false

	self._lblName = self.m_dialogComp:getChild("nameTxt")
	self._lblDialog = self.m_dialogComp:getChild("dialogTxt")

	self.m_dialogComp:setVisible(false)

	self._bgCtrl = nil
	self._roles = {}

	if arg_2_1.id then
		self._nowAnimationId = arg_2_1.id
		self._data = self._storyData:getAnimationData(arg_2_1.id)

		if var_2_0 then
			self._storyData:getEditorStr(self._data)
		end

		self._storyId = var_0_1.DIALOG_MAX + arg_2_1.id
	end

	self:initParams()
	self:newScheduleOnce(handler(self, function()
		self:dispatchCompEvent(g.core.event.enum.EVENT_STORY_START)
	end))
end

function StoryAnimationLayer:onLoad()
	if self._data and next(self._data) then
		self:playNextStep()
	else
		table.insert(self._scheduleHandlers, (self:newScheduleOnce(function()
			self:finish()
		end, 0)))
	end
end

function StoryAnimationLayer:_onClick()
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
end

function StoryAnimationLayer:playNextStep()
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
		if self._data[iter_7_0].playtype == var_0_1.STEP_PLAY_TYPE.WITH_LAST then
			self._nowIndex = iter_7_0
			self._indexLock = self._indexLock + 1

			self:playWithDelaytime(self._data[iter_7_0], iter_7_0 - self._nowIndex)
		else
			break
		end
	end
end

function StoryAnimationLayer:playSingleStep(arg_9_1)
	local var_9_0 = tonumber(arg_9_1.type)

	if var_9_0 ~= var_0_1.STEP_TYPE.DARK_CURTAIN then
		self.m_skipComp:setVisible(true)
	end

	if var_9_0 == var_0_1.STEP_TYPE.DARK_CURTAIN then
		self:playDarkCurtain(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.CREATE_BARKGROUND then
		self:createBackground(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.CREATE_ROLE then
		self:createRole(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.HIDE_ROLE then
		self:hideRole(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.MOVE_ROLE then
		self:moveRole(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.FLIP_ROLE then
		self:flipRole(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.PLAY_ROLE_ANI then
		self:playRoleAni(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.PLAY_EFFECT then
		local var_9_1 = tonumber(arg_9_1.params.eff_type) or 1

		if var_9_1 == var_0_1.EFF_TYPE.GLOBAL then
			self:playEffect(arg_9_1)
		elseif var_9_1 == var_0_1.EFF_TYPE.KNIGHT then
			self:playKnightEffect(arg_9_1)
		end
	elseif var_9_0 == var_0_1.STEP_TYPE.HIDE_DRAWKNIGHT then
		self:hideDiaKnight(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.MOVE_DRAWKNIGHT then
		self:moveDiaKnight(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.SHOW_DRAWKNIGHT then
		self:showDiaKnight(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.FLIP_DRAWKNIGHT then
		self:flipDiaKnight(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.HIDE_DIA_FRAME then
		self:hideDiaFrame(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.MOVE_CAMERA then
		self:moveCamera(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.PLAY_BUBBLE then
		self:playBubble(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.PLAY_DIALOG then
		self:playDialog(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.SHOW_KNIGHT_INFO then
		self:showKnightInfo(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.MOVE_EFFECT then
		self:moveEffect(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.SHAKE_LAYER then
		self:shakeLayer(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.PLAY_NEXT_STORY then
		self:playNextStory(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.PLAY_SOUND then
		self:playSound(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.HIDE_DIAMASK then
		self:hideDiaMask(arg_9_1)
	elseif var_9_0 == var_0_1.STEP_TYPE.SHOW_DIAMASK then
		self:showDiaMask(arg_9_1)
	end
end

function StoryAnimationLayer:endStep()
	if self._indexLock then
		self._indexLock = self._indexLock - 1

		if self._indexLock == 0 then
			self:endTalk()
			self:playNextStep()
		end
	end
end

function StoryAnimationLayer:createBackground(arg_11_1)
	local var_11_1 = tonumber(arg_11_1.params.background_night) or 0
	local var_11_2 = self._storyData:getBackgroundData((tonumber((var_11_1 > 0 and g.core.utils.Time.isNight() or nil) and var_11_1)))
	local var_11_3 = self:formatX(tonumber(arg_11_1.params.dis) or 0)
	local var_11_4 = tonumber(arg_11_1.params.dis_y) or 0

	if var_11_2 then
		self._bgCtrl = BGFactory.createWithPath({
			isStory = true,
			bgPath = var_11_2.scene_value,
			info = var_11_2,
			parent = self.m_bgHolderComp,
			initPosX = var_11_3
		})

		if var_11_3 ~= 0 or var_11_4 ~= 0 then
			self._bgCtrl:move(var_11_3, var_11_4)
		end

		self:endStep()
	end
end

function StoryAnimationLayer:createRole(arg_12_1)
	local var_12_0 = fgui.UIPackage:createObject("story", "StoryKnightComp", self)
	local var_12_1 = arg_12_1.params

	var_12_0.inTop = (tonumber(arg_12_1.params.top) or 0) == 1
	self._roles[#self._roles + 1] = var_12_0

	local var_12_2 = tonumber(var_12_1.x) or display.width / 2
	local var_12_3 = self:formatY(tonumber(var_12_1.y) or display.height / 2)

	var_12_0:setPosition(var_12_2, var_12_3)

	local var_12_4 = tonumber(var_12_1.scale) or 1

	var_12_0:setScale(var_12_4, var_12_4)
	var_12_0:setSortingOrder((var_12_0.inTop or nil) and (var_0_1.TopZOrder or math.abs(var_12_3)))

	if self._bgCtrl then
		self._bgCtrl:getStage():addChild(var_12_0)
		var_12_0:update(var_12_1, handler(self, self.endStep))
	else
		self:endStep()
	end
end

function StoryAnimationLayer:hideRole(arg_13_1)
	if self._roles[arg_13_1.params.rindex] then
		self._roles[arg_13_1.params.rindex]:hide(arg_13_1.params, handler(self, self.endStep))
	else
		self:endStep()
	end
end

function StoryAnimationLayer:moveRole(arg_14_1)
	local var_14_0 = self._roles[arg_14_1.params.rindex]

	if self._roles[arg_14_1.params.rindex] then
		self._roles[arg_14_1.params.rindex]:playAction(var_0_4.LOOP_ACTION.RUN)

		local var_14_1 = tonumber(arg_14_1.params.x) or display.width / 2
		local var_14_2 = self:formatY(tonumber(arg_14_1.params.y) or display.height / 2)

		if var_14_1 < self._roles[arg_14_1.params.rindex]:getPosition().x then
			self._roles[arg_14_1.params.rindex]:setFilp()
		end

		local var_14_3 = tonumber(arg_14_1.params.time) or 1

		if var_14_3 == 0 then
			self._roles[arg_14_1.params.rindex]:setPosition(var_14_1, var_14_2)
			self._roles[arg_14_1.params.rindex]:playAction(var_0_4.LOOP_ACTION.IDLE)

			if not self._roles[arg_14_1.params.rindex].inTop then
				local var_14_4, var_14_5 = self._roles[arg_14_1.params.rindex]:displayObject():getPosition()

				self._roles[arg_14_1.params.rindex]:setSortingOrder(math.abs(var_14_5))
			end

			self:endStep()
		else
			self._roles[arg_14_1.params.rindex]:runFGAction(fgui.FSequence:create(fgui.FMoveTo:create(var_14_3, cc.p(var_14_1, var_14_2)), (fgui.FCallFunc:create(handler(self, function(arg_15_0)
				var_14_0:playAction(var_0_4.LOOP_ACTION.IDLE)
				arg_15_0:endStep()
			end)))))

			if not self._roles[arg_14_1.params.rindex].inTop then
				table.insert(self._scheduleHandlers, (self:newScheduleInterval(function(arg_16_0, arg_16_1)
					local var_16_0, var_16_1 = var_14_0:displayObject():getPosition()

					var_14_0:setSortingOrder(math.abs(var_16_1))
				end, 0, var_14_3)))
			end
		end
	else
		self:endStep()
	end
end

function StoryAnimationLayer:flipRole(arg_17_1)
	if self._roles[arg_17_1.params.rindex] then
		self._roles[arg_17_1.params.rindex]:setFilp()
		self:endStep()
	else
		self:endStep()
	end
end

function StoryAnimationLayer:playRoleAni(arg_18_1)
	local var_18_0 = arg_18_1.params.isSound
	local var_18_1 = self._roles[arg_18_1.params.rindex]
	local var_18_2 = arg_18_1.params.ani or var_0_4.LOOP_ACTION.IDLE
	local var_18_3 = arg_18_1.params.endevent

	if var_18_1 and var_18_2 and var_18_2 ~= "" then
		if var_18_3 and var_18_3 ~= "" then
			if var_18_0 and var_18_0 == 1 then
				var_18_1:playSound(arg_18_1.params.ani)
			end

			var_18_1:playAction(var_18_2, handler(self, self.endStep))
		elseif tonumber(arg_18_1.params.multi) == 1 then
			if var_18_0 and var_18_0 == 1 then
				var_18_1:playSound(arg_18_1.params.ani)
			end

			var_18_1:playAction(var_18_2)
			self:endStep()
		else
			if var_18_0 and var_18_0 == 1 then
				var_18_1:playSound(arg_18_1.params.ani)
			end

			var_18_1:playAction(var_18_2, handler(self, self.endStep))
		end
	else
		self:endStep()
	end
end

function StoryAnimationLayer:playKnightEffect(arg_19_1)
	local var_19_0 = self:getDiaKnight(arg_19_1.params.dindex)

	if not var_19_0 then
		self:endStep()

		return
	end

	local var_19_1 = var_19_0:getRoleId()

	self:sortChildIndex(var_19_1)
	self:setKnightDark(var_19_1)

	local var_19_2 = arg_19_1.params.path
	local var_19_3 = tonumber(arg_19_1.params.multi) == 1
	local var_19_4 = var_19_3 and -1 or tonumber(arg_19_1.params.count)
	local var_19_5 = self._nowIndex

	assert(var_19_4, "incorrect play times")

	local var_19_6

	var_19_6 = require("app.view.common.SpineBase").new({
		resId = "",
		path = var_19_2,
		isLoop = var_19_3,
		listener = function(self)
			if not var_19_6 then
				return
			end

			if self.type == "complete" then
				var_19_4 = var_19_4 - 1

				if var_19_4 == 0 then
					var_19_6:removeFromParent(true)

					self._effects[var_19_5] = nil

					self:endStep()
				elseif var_19_4 > 0 then
					var_19_6:setAnimation(0, "play", var_19_3)
				end
			end
		end
	})

	if not var_19_6 then
		self:endStep()

		return
	end

	local var_19_7 = tonumber(arg_19_1.params.x) or var_19_0:getSize().width / 2
	local var_19_8 = tonumber(arg_19_1.params.y) or var_19_0:getSize().height / 2
	local var_19_9 = tonumber(arg_19_1.params.scale) or 1

	var_19_6:setScale(var_19_9 * (tonumber(arg_19_1.params.flip) == 1 and -1 or 1), var_19_9)

	local var_19_10 = fgui.GComponent:create()

	var_19_10:setPosition(var_19_7, var_19_8)
	var_19_10:displayObject():addChild(var_19_6)

	self._effects[var_19_5] = {
		eff = var_19_10
	}

	var_19_0:addChild(var_19_10)

	if var_19_3 then
		self._effects[var_19_5].endIndex = tonumber(arg_19_1.params.endstep) or var_19_5

		self:endStep()
	end
end

function StoryAnimationLayer:playEffect(arg_21_1)
	local var_21_0 = arg_21_1.params.path
	local var_21_1 = tonumber(arg_21_1.params.multi) == 1
	local var_21_2 = tonumber(arg_21_1.params.flip) == 1
	local var_21_3 = var_21_1 and -1 or tonumber(arg_21_1.params.count)
	local var_21_4 = self._nowIndex

	assert(var_21_3, "incorrect play times")

	local var_21_5

	if string.find(var_21_0, ".png") then
		var_21_1 = true
		var_21_5 = display.newSprite(var_21_0)
	else
		var_21_5 = require("app.view.common.SpineBase").new({
			resId = "",
			path = var_21_0,
			isLoop = var_21_1,
			listener = function(self)
				if not var_21_5 then
					return
				end

				if self.type == "complete" then
					var_21_3 = var_21_3 - 1

					if var_21_3 == 0 then
						var_21_5:removeFromParent(true)

						self._effects[var_21_4] = nil

						self:endStep()
					elseif var_21_3 > 0 then
						var_21_5:setAnimation(0, "play", var_21_1)
					end
				end
			end
		})
	end

	if not var_21_5 then
		self:endStep()

		return
	end

	local var_21_6 = tonumber(arg_21_1.params.x) or display.width / 2
	local var_21_7 = self:formatY(tonumber(arg_21_1.params.y) or display.height / 2)
	local var_21_8 = tonumber(arg_21_1.params.scale) or 1

	var_21_5:setScale(var_21_8 * (var_21_2 and -1 or 1), var_21_8)

	local var_21_9 = fgui.GComponent:create()

	var_21_9:setPosition(var_21_6, var_21_7)
	var_21_9:displayObject():addChild(var_21_5)
	var_21_9:setSortingOrder(tonumber(arg_21_1.params.zorder) or var_21_7)

	self._effects[var_21_4] = {
		eff = var_21_9,
		path = var_21_0
	}

	if self._bgCtrl then
		self._bgCtrl:getStage():addChild(var_21_9)
	else
		self:addChild(var_21_9)
	end

	if var_21_1 then
		self._effects[var_21_4].endIndex = tonumber(arg_21_1.params.endstep) or var_21_4

		self:endStep()
	end
end

function StoryAnimationLayer:moveCamera(arg_23_1)
	local var_23_0 = tonumber(arg_23_1.params.dis) or 100
	local var_23_1 = var_23_0 > 0 and 1 or -1
	local var_23_2 = tonumber(arg_23_1.params.dis_y) or 0
	local var_23_3 = tonumber(arg_23_1.params.speed) or 50
	local var_23_4 = math.abs(var_23_0 / var_23_3)
	local var_23_5 = var_23_2 / var_23_4
	local var_23_6 = 0
	local var_23_7

	var_23_7 = self:newScheduleInterval(function(arg_24_0, arg_24_1)
		var_23_6 = var_23_6 + arg_24_1

		if self._bgCtrl then
			self._bgCtrl:move(arg_24_1 * var_23_1 * var_23_3, arg_24_1 * var_23_5)

			if var_23_6 >= var_23_4 then
				self:endStep()
			end
		else
			self:cancelSchedule(var_23_7)
		end
	end, 0, var_23_4)

	table.insert(self._scheduleHandlers, nil)
end

function StoryAnimationLayer:playBubble(arg_25_1)
	if self._roles[arg_25_1.params.rindex] then
		self._roles[arg_25_1.params.rindex]:showBubble(arg_25_1.params, handler(self, self.endStep))
	else
		self:endStep()
	end

	local var_25_0 = arg_25_1.params.soundpath

	if arg_25_1.params.soundpath and var_25_0 ~= "" then
		local var_25_1 = self._storyData:formatSoundPath(var_25_0, 1)

		if self._preSoundName then
			g.core.sound.SoundManager:stopSound(self._preSoundName)
		end

		g.core.sound.SoundManager:playSound(var_25_1)

		self._preSoundName = var_25_1
	end
end

function StoryAnimationLayer:clearAll()
	for iter_26_0 = #self._diaKnights, 1, -1 do
		self._diaKnights[iter_26_0]:clear()
	end

	if self._preSoundName then
		g.core.sound.SoundManager:stopSound(self._preSoundName)

		self._preSoundName = nil
	end

	for iter_26_1, iter_26_2 in ipairs(self._scheduleHandlers) do
		self:cancelSchedule(iter_26_2)
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

	for iter_26_3, iter_26_4 in pairs(self._roles) do
		iter_26_4:clear()
		iter_26_4:removeFromParent()
	end

	self._roles = {}

	for iter_26_5, iter_26_6 in pairs(self._effects) do
		iter_26_6.eff:removeFromParent()
	end

	self._effects = {}
end

function StoryAnimationLayer:finish(arg_27_1)
	if self._inEnd then
		return
	end

	self._inEnd = true

	self.m_skipComp:setVisible(false)

	local var_27_0 = self._nowAnimationId or 0

	if self._nowAnimationId and self._nowAnimationId > 0 then
		self._storyData:setAnimationPlayed(self._nowAnimationId)

		self._nowAnimationId = nil
	end

	self:dispatchCompEvent(g.core.event.enum.EVENT_STORY_NOTICE, {
		id = var_0_1.DIALOG_MAX + var_27_0
	})
	self:clearAll()

	if self:_checkLastIsChoose() or self:_checkLastIsPlayNextStory() or self._isPlayingNext then
		if arg_27_1 then
			local var_27_1 = {
				isDialog = false,
				chooseIndex = self._storyData:getChooseIndex()
			}

			var_27_1.trigger_type = self._storyData:getTriggerType()
			var_27_1.trigger_data = self._storyData:getTriggerData()
			var_27_1.triggerTaskId = self._triggerTaskId

			self:dispatchCompEvent(g.core.event.enum.EVENT_STORY_END, var_27_1)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_END, false, {
				id = var_0_1.DIALOG_MAX + var_27_0
			})
			var_0_3:onlyPopSelfByDisplay(self)

			goto label_27_0
		end
	end

	var_0_3:onlyPopSelfByDisplay(self)

	::label_27_0::
end

function StoryAnimationLayer:onUnload()
	self:clearAll()
end

return StoryAnimationLayer
