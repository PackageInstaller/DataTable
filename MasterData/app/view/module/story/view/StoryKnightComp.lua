local StoryKnightComp = class("StoryKnightComp", require("app.fairyGUI.story.UI_StoryKnightComp"))
local CommonKnight = require("app.view.common.CommonKnight")
local var_0_2 = g.core.const.ConstMgr.SpineConst

StoryKnightComp.BUB_TIME = 1
StoryKnightComp.FADE_TIME = 1

function StoryKnightComp:ctor()
	self._params = nil
	self._knightSpine = nil
	self._delayHandler = nil
	self._scheduleHandler = nil
	self._storyData = g.core.model.User.storyData
end

function StoryKnightComp:update(arg_2_1, arg_2_2)
	if self._params and tonumber(arg_2_1.role) == tonumber(self._params.role) or self._knightSpine then
		if arg_2_2 then
			arg_2_2()
		end

		return
	end

	self._params = arg_2_1

	self.m_bubbleGroup:setVisible(false)

	local var_2_0 = self._storyData:getRoleData(arg_2_1.role)
	local var_2_1 = CommonKnight.new({
		resId = tonumber(var_2_0.res)
	})

	self.m_knightComp:addChild(var_2_1)

	local var_2_2 = self.m_knightComp:getPivot()
	local var_2_3 = self.m_knightComp:getSize()

	var_2_1:setPosition(var_2_3.width * var_2_2.x, var_2_3.height * var_2_2.y)

	self._knightSpine = var_2_1

	if not var_2_0.quality then
		-- block empty
	end

	if not arg_2_1.setname or arg_2_1.setname == "" then
		arg_2_1.setname = var_2_0.name
	end

	self.m_nameTxt:setText(arg_2_1.setname)

	if arg_2_1.isfade and tonumber(arg_2_1.isfade) == 1 then
		self._knightSpine:getBaseSpine():setOpacity(0)
		self._knightSpine:getBaseSpine():runAction(cc.Sequence:create(cc.FadeIn:create(0.5), cc.CallFunc:create(handler(self, function(arg_3_0)
			if arg_2_2 then
				arg_2_2()
			end
		end))))
	else
		self._knightSpine:getBaseSpine():setOpacity(255)

		if arg_2_2 then
			arg_2_2()
		end
	end
end

function StoryKnightComp:playSound(arg_4_1)
	if arg_4_1 == var_0_2.ACTION.ATTACK then
		-- block empty
	elseif arg_4_1 == var_0_2.ACTION.SKILL then
		-- block empty
	end

	if self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end

	self._scheduleHandler = self:newSchedule(handler(self, self._schedule))
end

function StoryKnightComp:_schedule()
	return
end

function StoryKnightComp:playActionUntilEvent(arg_6_1, arg_6_2, arg_6_3)
	if self._knightSpine then
		-- block empty
	end
end

function StoryKnightComp:setFilp()
	self:setScaleX(-self:getScaleX())

	local var_7_0 = 1
	local var_7_1 = self:getScaleX() < 0 and -var_7_0 or var_7_0

	self.m_nameTxt:setScale(var_7_1, 1)
	self.m_bubbleLabel:setScale(var_7_1, var_7_0)
	self.m_bubbleLoader:setScale(var_7_1, var_7_0)
	self.m_bgImg:setScale(var_7_0, var_7_0)
end

function StoryKnightComp:playAction(arg_8_1, arg_8_2)
	if self._knightSpine then
		self._knightSpine:playAction(arg_8_1, arg_8_2)
	end
end

function StoryKnightComp:getKnight()
	return self._knightSpine
end

function StoryKnightComp:showBubble(arg_10_1, arg_10_2)
	self.m_bubbleGroup:setVisible(true)
	self.m_typeController:setSelectedIndex(0)

	if arg_10_1.str and arg_10_1.str ~= "" then
		self.m_typeController:setSelectedIndex(0)
		self.m_bubbleLabel:setVisible(true)
		self.m_bubbleLoader:setVisible(false)
		self.m_bubbleLabel:setText(arg_10_1.str)
	elseif arg_10_1.bub and arg_10_1.bub ~= "" then
		self.m_typeController:setSelectedIndex(1)
		self.m_bubbleLabel:setVisible(false)
		self.m_bubbleLoader:setVisible(true)
		self.m_bubbleLoader:setURL(g.core.common.Path:getEmojiPath(arg_10_1.bub))
	end

	self._delayHandler = self:newScheduleOnce(handler(self, function(arg_11_0)
		arg_11_0.m_bubbleGroup:setVisible(false)

		if arg_10_2 then
			arg_10_2()
		end
	end), tonumber(arg_10_1.time) or StoryKnightComp.BUB_TIME)
end

function StoryKnightComp:hide(arg_12_1, arg_12_2)
	if tonumber(arg_12_1.isfade) == 1 then
		self:setVisible(true)
		self._knightSpine:getBaseSpine():runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(handler(self, function(arg_13_0)
			arg_13_0:setVisible(false)

			if arg_12_2 then
				arg_12_2()
			end
		end))))
	else
		self._knightSpine:getBaseSpine():setOpacity(0)
		self:setVisible(false)

		if arg_12_2 then
			arg_12_2()
		end
	end
end

function StoryKnightComp:show(arg_14_1, arg_14_2)
	if tonumber(arg_14_1.isfade) == 1 then
		self._knightSpine:getBaseSpine():setOpacity(0)
		self._knightSpine:getBaseSpine():runAction(cc.Sequence:create(cc.FadeIn:create(0.5), cc.CallFunc:create(handler(self, function(arg_15_0)
			if arg_14_2 then
				arg_14_2()
			end
		end))))
	else
		self._knightSpine:getBaseSpine():setOpacity(255)

		if arg_14_2 then
			arg_14_2()
		end
	end
end

function StoryKnightComp:clear()
	if self._delayHandler then
		self:cancelSchedule(self._delayHandler)
	end

	if self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end

	self.m_nameTxt:setVisible(false)
end

return StoryKnightComp
