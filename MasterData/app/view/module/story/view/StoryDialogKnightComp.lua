local StoryDialogKnightComp = class("StoryDialogKnightComp", require("app.fairyGUI.story.UI_StoryDialogKnightComp"))
local DrawKnight = require("app.view.common.DrawKnight")

StoryDialogKnightComp.BUB_TIME = 1
StoryDialogKnightComp.FADE_TIME = 1

local var_0_2 = 0.3
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = g.core.const.ConstMgr.SpineConst

function StoryDialogKnightComp:ctor()
	self._params = nil
	self._drawKnight = nil
	self._delayHandler = nil
	self._loadedKnight = {}
	self._colorValue = var_0_2
	self._preAniName = nil
end

function StoryDialogKnightComp:setFlip(arg_2_1)
	if not self._drawKnight then
		return
	end

	if arg_2_1 then
		self._drawKnight:setSpineFlip(true)
	else
		self._drawKnight:setSpineFlip(false)
	end
end

function StoryDialogKnightComp:setDark(arg_3_1)
	if arg_3_1 then
		if self._colorValue == var_0_2 then
			return
		end

		if self._scheduleUp then
			self:cancelSchedule(self._scheduleUp)

			self._scheduleUp = nil
		end

		self._scheduleUp = self._scheduleUp or self:newSchedule(handler(self, function(arg_4_0)
			arg_4_0._drawKnight:mulColor(true, cc.vec3(arg_4_0._colorValue, arg_4_0._colorValue, arg_4_0._colorValue))

			arg_4_0._colorValue = arg_4_0._colorValue - 0.02 * var_0_4

			if arg_4_0._colorValue <= var_0_2 then
				arg_4_0._colorValue = var_0_2

				if arg_4_0._scheduleUp then
					arg_4_0:cancelSchedule(arg_4_0._scheduleUp)

					arg_4_0._scheduleUp = nil
				end
			end
		end))
	else
		if self._colorValue == 1 then
			return
		end

		if self._scheduleUp then
			self:cancelSchedule(self._scheduleUp)

			self._scheduleUp = nil
		end

		self._scheduleUp = self._scheduleUp or self:newSchedule(handler(self, function(arg_5_0, arg_5_1)
			arg_5_0._drawKnight:mulColor(true, cc.vec3(arg_5_0._colorValue, arg_5_0._colorValue, arg_5_0._colorValue))

			arg_5_0._colorValue = arg_5_0._colorValue + 0.02 * var_0_4

			if arg_5_0._colorValue >= var_0_3 then
				arg_5_0._colorValue = var_0_3

				if arg_5_0._scheduleUp then
					arg_5_0:cancelSchedule(arg_5_0._scheduleUp)

					arg_5_0._scheduleUp = nil
				end
			end
		end))
	end
end

function StoryDialogKnightComp:update(arg_6_1, arg_6_2)
	if self._params and tonumber(arg_6_1.role) == tonumber(self._params.role) then
		return
	elseif self._drawKnight then
		self._drawKnight:setVisible(false)

		self._loadedKnight[tonumber(self._params.role)] = self._drawKnight
		self._drawKnight = nil
	end

	self._params = arg_6_1

	local var_6_0 = g.core.model.User.storyData:getRoleData(arg_6_1.role)

	self._isSpecialMain = tonumber(var_6_0.res) and tonumber(var_6_0.res) == 210000

	if g.core.utils.Rule.matchChannelAndLv() and tonumber(var_6_0.res) == 510030 then
		self:setOpacity(0)
	end

	local var_6_1 = self._loadedKnight[tonumber(self._params.role)]

	if var_6_1 then
		var_6_1:setVisible(true)
	else
		var_6_0.maskParams = var_6_0.maskParams or {}

		local var_6_2 = tonumber(var_6_0.res)
		local var_6_3 = {
			ignoreSpine = true,
			isAlphaNode = true,
			resId = (g.core.model.User.storyData:isMainRole(tonumber(var_6_0.res)) or nil) and g.core.model.User.knightsData:getMainKnight():getResInfo().id
		}

		var_6_3.scale = var_6_0.maskParams.scale or 1
		var_6_1 = DrawKnight.new(var_6_3)

		local var_6_4 = var_6_0.maskParams.maskType or 0
		local var_6_5 = var_6_0.maskParams.mask or {}
		local var_6_6 = var_6_0.maskParams.round
		local var_6_7, var_6_8, var_6_9, var_6_10

		if not var_6_0.maskParams.round then
			var_6_6 = 150
			var_6_7 = var_6_5[tostring(1)] or 0
			var_6_8 = var_6_5[tostring(2)] or 0
			var_6_9 = var_6_5[tostring(3)] or 0
			var_6_10 = var_6_5[tostring(4)] or 0
		end

		var_6_1:setAlphaRect(var_6_4, cc.rect(var_6_7, var_6_8, var_6_9, var_6_10), var_6_6)
		self.m_knightComp:addChild(var_6_1)
	end

	local var_6_11 = self.m_knightComp:getPivot()
	local var_6_12 = self.m_knightComp:getSize()

	var_6_1:setPosition(var_6_12.width * var_6_11.x, var_6_12.height * var_6_11.y)

	self._drawKnight = var_6_1

	if self._isSpecialMain then
		self._drawKnight:playIdle()
	end

	if arg_6_1.defaultColorValue then
		self._colorValue = arg_6_1.defaultColorValue
	end

	if arg_6_2 then
		arg_6_2()
	end
end

function StoryDialogKnightComp:playAction(arg_7_1, arg_7_2)
	if self._drawKnight then
		if arg_7_1 == "talk" then
			self:playTalk()
		else
			if self._preAniName and self._preAniName == "idle" and arg_7_1 == "idle" then
				if arg_7_2 then
					arg_7_2()
				end

				return
			end

			self._preAniName = arg_7_1

			self._drawKnight:playAction(arg_7_1, arg_7_2)
		end
	elseif arg_7_2 then
		arg_7_2()
	end
end

function StoryDialogKnightComp:playTalk()
	if self._drawKnight then
		self._inTalk = true

		if self._preAniName == var_0_5.LOOP_DRAW_ACTION.TALK then
			return
		end

		self._preAniName = var_0_5.LOOP_DRAW_ACTION.TALK

		if self._drawKnight then
			self._drawKnight:playAction(var_0_5.LOOP_DRAW_ACTION.TALK)
		end
	end
end

function StoryDialogKnightComp:endTalk()
	if self._drawKnight then
		self._drawKnight:closeTalkSch()
	end

	if self._inTalk then
		self._inTalk = false

		if self._preAniName == var_0_5.LOOP_DRAW_ACTION.IDLE then
			return
		end

		self._preAniName = var_0_5.LOOP_DRAW_ACTION.IDLE

		if self._drawKnight then
			self._drawKnight:playAction(var_0_5.LOOP_DRAW_ACTION.IDLE)
		end
	end
end

function StoryDialogKnightComp:playKouXing(arg_10_1)
	if self._drawKnight then
		self._drawKnight:playKouXing(arg_10_1)
	end
end

function StoryDialogKnightComp:getKnight()
	return self._drawKnight
end

function StoryDialogKnightComp:showBubble(arg_12_1, arg_12_2)
	if arg_12_2 then
		arg_12_2()
	end
end

function StoryDialogKnightComp:hide(arg_13_1, arg_13_2)
	if tonumber(arg_13_1.isfade) == 1 then
		if self._drawKnight then
			self._drawKnight:getBaseSpine():runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(handler(self, function(arg_14_0)
				if arg_13_2 then
					arg_13_2()
				end
			end))))
		elseif arg_13_2 then
			arg_13_2()
		end
	else
		if self._drawKnight then
			self._drawKnight:setAlpha(0)
		end

		if arg_13_2 then
			arg_13_2()
		end
	end
end

function StoryDialogKnightComp:show(arg_15_1, arg_15_2)
	if tonumber(arg_15_1.isfade) == 1 then
		self._drawKnight:getBaseSpine():runAction(cc.Sequence:create(cc.FadeIn:create(0.5), cc.CallFunc:create(handler(self, function(arg_16_0)
			if arg_15_2 then
				arg_15_2()
			end
		end))))
	else
		self._drawKnight:setAlpha(255)

		if arg_15_2 then
			arg_15_2()
		end
	end
end

function StoryDialogKnightComp:clear()
	if self._delayHandler then
		self:cancelSchedule(self._delayHandler)
	end
end

function StoryDialogKnightComp:getRoleId()
	return self._params.role
end

function StoryDialogKnightComp:getParams()
	return self._params
end

function StoryDialogKnightComp:setBlackShadow(arg_20_1)
	if arg_20_1 then
		self._drawKnight:mulColor(true, cc.vec3(0.2, 0.2, 0.2))
	else
		self._drawKnight:mulColor(false)
	end
end

function StoryDialogKnightComp:onUnload()
	self._preAniName = nil
end

return StoryDialogKnightComp
