require("view.Layer.L2dLayer")

DormL2dLayer = class("DormL2dLayer", function()
	return L2dLayer:create()
end)

local l2d_manager = require("controller.l2d_manager")
local audio_manager = require("controller.audio_manager")
local model_data = require("data.model_data")
local role_conversation_data = require("data.role_conversation_data")
local conversation_class_data = require("data.conversation_class_data")
local conversation_type_data = require("data.conversation_type_data")
local var_0_7 = 1001
local var_0_8 = 1002
local var_0_9 = 5
local var_0_11 = 1
local var_0_12

function DormL2dLayer.create(arg_2_0)
	var_0_11 = 1
	var_0_12 = nil

	return (DormL2dLayer.new())
end

function DormL2dLayer:insertTalk(arg_3_1)
	self:showRoleTalk(arg_3_1)
end

function DormL2dLayer:showRoleTalk(arg_4_1)
	if not self._modelid then
		return
	end

	if arg_4_1 then
		self.isInsertTalk = arg_4_1
		self._talktime = 0
		self._angrytime = 0
		var_0_11 = 1
		var_0_12 = nil

		if self:genRoleTalk(arg_4_1) then
			self.isInsertTalk = nil
		end
	elseif self.isInsertTalk then
		if self:genRoleTalk(self.isInsertTalk) then
			self.isInsertTalk = nil
		end
	else
		if self._talktime >= var_0_9 then
			self._angrytime = self._angrytime + 1

			self:genRoleTalk(ROLE_CONVERSATION_TYPE.angry)
		elseif self:genRoleTalk(ROLE_CONVERSATION_TYPE.dormTouch) then
			self._talktime = self._talktime + 1
		end

		self:stopActionByTag(var_0_7)
	end
end

function DormL2dLayer:genRoleTalk(arg_5_1)
	if var_0_11 == 1 then
		var_0_12 = GenerateRoleConversationClass(self._modelid, arg_5_1)
	end

	local var_5_1 = 0

	if not role_conversation_data[var_0_12 * 100 + 1] then
		return false
	end

	while role_conversation_data[var_0_12 * 100 + var_5_1 + 1] do
		var_5_1 = var_5_1 + 1
	end

	if var_5_1 < var_0_11 then
		var_0_11 = 1
	end

	self:playRoleTalk(var_0_12)

	var_0_11 = var_0_11 + 1

	if var_5_1 < var_0_11 then
		var_0_11 = 1
	end

	return var_5_1 < var_0_11
end

function DormL2dLayer:playRoleTalk(arg_6_1)
	local var_6_0 = role_conversation_data[arg_6_1 * 100 + var_0_11].dec
	local var_6_1 = role_conversation_data[arg_6_1 * 100 + var_0_11].sound
	local var_6_2 = role_conversation_data[arg_6_1 * 100 + var_0_11].sound_volume
	local var_6_3 = role_conversation_data[arg_6_1 * 100 + var_0_11].ani
	local var_6_4 = role_conversation_data[arg_6_1 * 100 + var_0_11].l2d_ani_index or 0
	local var_6_5 = var_6_3 ~= nil and l2d_manager:isModelMotionExist(self.model, var_6_3)

	if var_6_0 then
		self:showTalkSP(var_6_0)
	end

	local var_6_6 = self._modelid
	local var_6_7 = var_6_1 and audio_manager:isPlayerSoundValid()

	local function var_6_8()
		if var_6_7 then
			audio_manager.playingplayersound = false
		end

		if var_6_6 ~= self._modelid then
			return
		end

		if var_6_0 then
			self:getTalkSP():setVisible(false)
		end

		self:setTouchEnabled(true)

		if self._talktime >= var_0_9 then
			self:stopActionByTag(var_0_8)

			local var_7_0 = cc.Sequence:create(cc.DelayTime:create(10), cc.CallFunc:create(function()
				self._angrytime = 0
				self._talktime = 0
			end))

			var_7_0:setTag(var_0_8)
			self:runAction(var_7_0)
		else
			self:stopActionByTag(var_0_7)

			local var_7_1 = cc.Sequence:create(cc.DelayTime:create(5), cc.CallFunc:create(function()
				self._talktime = 0
			end))

			var_7_1:setTag(var_0_7)
			self:runAction(var_7_1)
		end

		if self.talkFinishCallback then
			self.talkFinishCallback()

			self.talkFinishCallback = nil
		end
	end

	self:setTouchEnabled(false)

	if var_6_7 then
		audio_manager.playingplayersound = true

		audio_manager:playPlayerSound("sound/role_voice/" .. var_6_1, nil, var_6_2, var_6_8)
	else
		self:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(var_6_8)))
	end

	if var_6_5 then
		l2d_manager:doModelMotion(self.model, var_6_3, var_6_4)
	end
end

function DormL2dLayer:getTalkSP()
	if not self._talksp then
		local var_10_0 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_10_0:setMaxLineWidth(357)
		var_10_0:setString(dec)
		var_10_0:setAnchorPoint(cc.p(0, 0.5))
		var_10_0:setColor(cc.c3b(71, 75, 86))
		var_10_0:setName("talklabel")

		if config._DEBUG then
			self._talksp = cc.Scale9Sprite:create("public/talk/word_bg.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/talk/word_bg.png")
		end

		self._talksp:setCapInsets(cc.rect(100, 50, 200, 20))
		self._talksp:setPreferredSize(cc.size(var_10_0:getContentSize().width + 40, var_10_0:getContentSize().height + 37))
		var_10_0:setPosition(cc.p(20, self._talksp:getContentSize().height / 2 - 24))
		self._talksp:addChild(var_10_0, 3)
		self._talksp:setName("talksp")

		if DormRoomLayer and DormRoomLayer.getInstance() then
			DormRoomLayer.getInstance().uiPanel:addChild(self._talksp, 2)
		elseif DormRoomPopLayer and DormRoomPopLayer.getInstance() then
			DormRoomPopLayer.getInstance().uiPanel:addChild(self._talksp, 2)
		end

		self._talksp:setVisible(false)
		self._talksp:registerScriptHandler(function(arg_11_0)
			if arg_11_0 == "exit" then
				self._talksp = nil
			end
		end)
	end

	return self._talksp
end
