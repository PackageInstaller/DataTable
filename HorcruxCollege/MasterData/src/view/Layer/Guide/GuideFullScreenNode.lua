GuideFullScreenNode = class("GuideFullScreenNode", function()
	return ccui.Layout:create()
end)

local guide_data = require("data.guide_data")
local var_0_1 = "mainScenebg/guide/"

function GuideFullScreenNode.create(arg_2_0)
	local var_2_0 = GuideFullScreenNode.new()

	var_2_0:init()

	return var_2_0
end

function GuideFullScreenNode:init()
	self:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self:setPosition(cc.p(-GameDisplay.fix_x, -GameDisplay.fix_y))
	self:setTouchEnabled(true)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "enter" then
			self:getParent():onFullScreenEvent(arg_4_0)
			self:popNextFullScreenGuide()
		elseif arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function GuideFullScreenNode:exit()
	self:runAction(cc.RemoveSelf:create())
	self:getParent():onFullScreenEvent("exit")
end

function GuideFullScreenNode:popNextFullScreenGuide()
	local var_6_0 = self:getParent():popNextFullScreenGuide()

	if not var_6_0 then
		self:exit()

		return
	end

	self:initGuideAction(var_6_0)
end

function GuideFullScreenNode:finishCurrentGuide(arg_7_1)
	GuideListener.finishGuide(arg_7_1)
	self:addTouchEventListener(function(...)
		return
	end)
	self.sublayer:runAction(cc.RemoveSelf:create())
	self:popNextFullScreenGuide()
end

function GuideFullScreenNode:initGuideAction(arg_9_1)
	local var_9_0 = type(arg_9_1) == "number" and arg_9_1 or arg_9_1.guideID
	local var_9_1 = guide_data[var_9_0]

	if guide_data[var_9_0].guideaction == GUIDEACTION_SNAP then
		self:forwardGuideSnap(var_9_0)
	elseif var_9_1.guideaction == GUIDEACTION_ANI then
		self:forwardGuideAni(var_9_0)
	elseif var_9_1.guideaction == GUIDEACTION_EXPLAIN then
		self:forwardGuideExplain(arg_9_1)
	elseif var_9_1.guideaction == GUIDEACTION_TALK then
		self:forwardGuideTalk(arg_9_1)
	end
end

function GuideFullScreenNode:forwardGuideSnap(arg_10_1)
	local var_10_0 = guide_data[arg_10_1]

	if guide_data[arg_10_1].shelter == 1 then
		self.sublayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 180), GameDisplay.width, GameDisplay.height)

		self.sublayer:setCascadeOpacityEnabled(false)
		self:addChild(self.sublayer)
	else
		self.sublayer = cc.Layer:create()

		self:addChild(self.sublayer)
	end

	local var_10_1 = cc.Sprite:create(var_0_1 .. var_10_0.snap)

	var_10_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self.sublayer:addChild(var_10_1, 1)
	self:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:finishCurrentGuide(arg_10_1)
	end)
end

function GuideFullScreenNode:forwardGuideAni(arg_12_1)
	local var_12_0 = guide_data[arg_12_1]

	self.sublayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 180), GameDisplay.width, GameDisplay.height)

	self.sublayer:setCascadeOpacityEnabled(false)
	self:addChild(self.sublayer)

	local var_12_1 = sp.SkeletonAnimation:create(UI_SPINE_PATH .. "unclock.json", UI_SPINE_PATH .. "unclock.atlas", 1)

	var_12_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self.sublayer:addChild(var_12_1)
	var_12_1:registerSpineEventHandler(function(arg_13_0)
		if arg_13_0.animation == "unclock" then
			self:finishCurrentGuide(arg_12_1)
		end
	end, SP_ANIMATION_COMPLETE)
	self.sublayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.7), cc.CallFunc:create(function()
		local var_14_0

		if config._DEBUG then
			var_14_0 = cc.Sprite:create(var_12_0.ani) or cc.Sprite:createWithSpriteFrameName(var_12_0.ani)
		end

		var_14_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
		var_14_0:setOpacity(0)
		self.sublayer:addChild(var_14_0, 1)
		var_14_0:runAction(cc.FadeIn:create(0.4))
	end)))
	var_12_1:setAnimation(0, "unclock", false)
end

local function var_0_2(arg_15_0)
	if not arg_15_0 then
		return nil
	end

	local var_15_0, var_15_1 = arg_15_0:match("(%d+),(%d+)")

	return cc.size(tonumber(var_15_0), tonumber(var_15_1))
end

local function var_0_3(arg_16_0)
	if not arg_16_0 then
		return {
			pos = GuideListener.center,
			boundingbox = GuideListener.fullrect
		}
	end

	if tolua.isnull(arg_16_0) then
		return {
			pos = GuideListener.center,
			boundingbox = GuideListener.fullrect
		}
	end

	local var_16_0 = GuideListener.convertToGuideSpace(arg_16_0:getParent(), cc.p(arg_16_0:getPosition()))
	local var_16_1 = arg_16_0:getBoundingBox()
	local var_16_2 = arg_16_0:getAnchorPoint()

	return {
		pos = cc.p(var_16_0.x - (var_16_2.x - 0.5) * var_16_1.width, var_16_0.y - (var_16_2.y - 0.5) * var_16_1.height),
		boundingbox = var_16_1
	}
end

function GuideFullScreenNode:forwardGuideExplain(arg_17_1)
	local var_17_0 = arg_17_1.guideID
	local var_17_1 = arg_17_1.conf
	local var_17_2 = guide_data[arg_17_1.guideID]

	self:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:finishCurrentGuide(var_17_0)
	end)

	self.sublayer = cc.Layer:create()

	self.sublayer:setPosition(cc.p(GameDisplay.fix_x, GameDisplay.fix_y))
	self:addChild(self.sublayer)

	if var_17_2.shelter == 1 then
		if var_17_1.shelterconf then
			if var_17_1.shelterconf.pos then
				local var_17_3 = var_0_2(var_17_2.sheltersize) or cc.size(GameDisplay.width, GameDisplay.height)
				local var_17_4 = cc.rect(var_17_1.shelterconf.pos.x - var_17_3.width / 2, var_17_1.shelterconf.pos.y - var_17_3.height / 2, var_17_3.width, var_17_3.height)

				self.sublayer:addChild(GuideClipping:create(nil, {
					pos = var_17_1.shelterconf.pos,
					rect = var_17_4,
					resource = var_17_2.resource,
					alphathreshold = var_17_2.alpha,
					shelterdelay = var_17_2.shelterdelay
				}, (var_17_2.useframe or nil) and {
					pos = var_17_1.shelterconf.pos,
					rect = var_17_4
				}), 1)
			elseif var_17_1.shelterconf.obj then
				local var_17_6 = var_0_3(var_17_1.shelterconf.obj)

				if var_17_1.shelterconf.offset then
					var_17_6.pos.x = var_17_6.pos.x + var_17_1.shelterconf.offset.x
					var_17_6.pos.y = var_17_6.pos.y + var_17_1.shelterconf.offset.y
				end

				local var_17_7 = var_0_2(var_17_2.sheltersize) or var_17_6.boundingbox
				local var_17_8 = cc.rect(var_17_6.pos.x - var_17_7.width / 2, var_17_6.pos.y - var_17_7.height / 2, var_17_7.width, var_17_7.height)

				self.sublayer:addChild(GuideClipping:create(nil, {
					pos = var_17_6.pos,
					rect = var_17_8,
					resource = var_17_2.resource,
					alphathreshold = var_17_2.alpha,
					shelterdelay = var_17_2.shelterdelay
				}, (var_17_2.useframe or nil) and {
					pos = var_17_6.pos,
					rect = var_17_8
				}), 1)
			end
		else
			local var_17_10 = cc.LayerColor:create(cc.c4b(0, 0, 0, 153), GameDisplay.width, GameDisplay.height)

			var_17_10:setCascadeOpacityEnabled(false)
			var_17_10:setPosition(cc.p(-GameDisplay.fix_x, -GameDisplay.fix_y))
			self.sublayer:addChild(var_17_10)
		end
	else
		self.sublayer = cc.Layer:create()

		self:addChild(self.sublayer)
	end

	if var_17_1 and var_17_1.obj then
		local var_17_11 = var_0_3(var_17_1.obj)

		self.sublayer:addChild(GuideExplain:create(var_17_2.text, var_17_2.explainmodel, var_17_2.explainmodeloffset, var_17_11.pos, cc.rect(var_17_11.pos.x - var_17_11.boundingbox.width / 2, var_17_11.pos.y - var_17_11.boundingbox.height / 2, var_17_11.boundingbox.width, var_17_11.boundingbox.height), var_17_2.explainpos, var_17_2.sound), 10)
	else
		self.sublayer:addChild(GuideExplain:create(var_17_2.text, var_17_2.explainmodel, var_17_2.explainmodeloffset, nil, nil, var_17_2.explainpos, var_17_2.sound), 10)
	end
end

function GuideFullScreenNode:forwardGuideTalk(arg_19_1)
	local var_19_0 = arg_19_1.guideID
	local var_19_1 = guide_data[arg_19_1.guideID]

	self.sublayer = cc.Layer:create()

	self.sublayer:setPosition(cc.p(GameDisplay.fix_x, GameDisplay.fix_y))
	self:addChild(self.sublayer)

	if var_19_1.shelter == 1 then
		if arg_19_1.conf.shelterconf then
			if arg_19_1.conf.shelterconf.pos then
				local var_19_2 = var_0_2(var_19_1.sheltersize) or cc.size(GameDisplay.width, GameDisplay.height)
				local var_19_3 = cc.rect(arg_19_1.conf.shelterconf.pos.x - var_19_2.width / 2, arg_19_1.conf.shelterconf.pos.y - var_19_2.height / 2, var_19_2.width, var_19_2.height)

				self.sublayer:addChild(GuideClipping:create(nil, {
					pos = arg_19_1.conf.shelterconf.pos,
					rect = var_19_3,
					resource = var_19_1.resource,
					alphathreshold = var_19_1.alpha,
					shelterdelay = var_19_1.shelterdelay
				}, (var_19_1.useframe or nil) and {
					pos = arg_19_1.conf.shelterconf.pos,
					rect = var_19_3
				}), 1)
			elseif arg_19_1.conf.shelterconf.obj then
				local var_19_5 = var_0_3(arg_19_1.conf.shelterconf.obj)

				if arg_19_1.conf.shelterconf.offset then
					var_19_5.pos.x = var_19_5.pos.x + arg_19_1.conf.shelterconf.offset.x
					var_19_5.pos.y = var_19_5.pos.y + arg_19_1.conf.shelterconf.offset.y
				end

				local var_19_6 = var_0_2(var_19_1.sheltersize) or var_19_5.boundingbox
				local var_19_7 = cc.rect(var_19_5.pos.x - var_19_6.width / 2, var_19_5.pos.y - var_19_6.height / 2, var_19_6.width, var_19_6.height)

				self.sublayer:addChild(GuideClipping:create(nil, {
					pos = var_19_5.pos,
					rect = var_19_7,
					resource = var_19_1.resource,
					alphathreshold = var_19_1.alpha,
					shelterdelay = var_19_1.shelterdelay
				}, (var_19_1.useframe or nil) and {
					pos = var_19_5.pos,
					rect = var_19_7
				}), 1)
			end
		else
			local var_19_9 = cc.LayerColor:create(cc.c4b(0, 0, 0, 153), GameDisplay.width, GameDisplay.height)

			var_19_9:setCascadeOpacityEnabled(false)
			var_19_9:setPosition(cc.p(-GameDisplay.fix_x, -GameDisplay.fix_y))
			self.sublayer:addChild(var_19_9)
		end
	else
		self.sublayer = cc.Layer:create()

		self:addChild(self.sublayer)
	end

	self:addChild(TalkLayer:create(var_19_1.talkid, nil, TALK_TYPE_NORMAL, "", function()
		self:finishCurrentGuide(var_19_0)
	end))
end
