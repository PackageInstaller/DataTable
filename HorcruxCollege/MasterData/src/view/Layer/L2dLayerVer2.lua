L2dLayer = class("L2dLayer", function()
	return l2d.LAppView:createDrawNode()
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

function L2dLayer.create(arg_2_0)
	local var_2_0 = L2dLayer.new()

	var_2_0:init()

	return var_2_0
end

function L2dLayer:init()
	self:showAllModel(false)

	self._modelid = modelid
	self.model = nil
	self._drawed = false

	self:registerCustomEvent()
	self:fix()
	self:initDownload()

	self.instance = true

	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			self.instance = nil

			self:unActionScheduler()
			self:removeTalkSP()

			if self.model then
				l2d_manager:release(self.model)
				l2d_manager:removeModel(self.model)
			end
		end
	end)
end

function L2dLayer:addPlayer(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if not arg_5_4 and self._modelid == arg_5_2 then
		return
	end

	if self.model and self._drawed then
		l2d_manager:release(self.model)
	end

	var_0_11 = 1
	var_0_12 = nil
	self._modelid = arg_5_2
	self.model = arg_5_3
	self._tag = arg_5_1

	self:checkResource(arg_5_3)
end

require("controller.filedownloader.download_node_utils"):addDownloadInterface(L2dLayer, "Live2d")

function L2dLayer:onDownloadProcessing()
	self._drawed = false

	if self._loadingani then
		self._loadingani:setVisible(true)
		self._loadingani:play()

		return
	end

	self._loadingani = require("view.Sprite.LoadingSprite"):create()

	self._loadingani:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self:addChild(self._loadingani)
end

function L2dLayer:onDownloadComplete(arg_7_1)
	self:drawPlayer(self._tag)
end

function L2dLayer:drawPlayer(arg_8_1, arg_8_2)
	if self._loadingani then
		self._loadingani:setVisible(false)
		self._loadingani:stop()
	end

	self:setDrawModel(self.model)
	l2d_manager:addModel(self.model, "live2d/" .. self.model .. "/", LIVE2D_MODEL)

	if arg_8_1 == 0 then
		l2d_manager:setModelPositionByOffset(self.model, l2d_manager:getModelOffsetX(self.model), l2d_manager:getModelOffsetY(self.model))
	else
		l2d_manager:setModelPositionByOffset(self.model, 0, 0)
	end

	l2d_manager:showSayTex(self.model, true)
	l2d_manager:setSayCallback(self.model)
	self:setCanStayEnabled(arg_8_2)
end

function L2dLayer:setCanStayEnabled(arg_9_1)
	if not self.model then
		return
	end

	if arg_9_1 == nil then
		arg_9_1 = true
	end

	l2d_manager:setModelPlayStayEnabled(self.model, arg_9_1)
end

function L2dLayer:registerCustomEvent()
	self._talktime = 0
	self._angrytime = 0

	self:registerTouchEventCallback(function(arg_11_0)
		if self.touchTalkCallback then
			self.touchTalkCallback()
		end

		if arg_11_0 then
			return
		end

		self:showRoleTalk()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("live2dsaytex", function(arg_12_0)
		local var_12_0 = arg_12_0.sayTextShowTime or -1
		local var_12_1 = arg_12_0.isStay

		if self.model ~= arg_12_0.model then
			return
		end

		if arg_12_0.sound and string.len(arg_12_0.sound) > 0 then
			audio_manager:stopAllRoleSound()

			audio_manager.playingplayersound = false

			if audio_manager:isPlayerSoundValid() then
				local var_12_2

				if not var_12_1 then
					audio_manager.playingplayersound = true

					audio_manager:stopAllRoleSound()

					function var_12_2()
						audio_manager.playingplayersound = false
					end
				end

				audio_manager:playPlayerSound("sound/role_voice/" .. arg_12_0.sound, nil, nil, var_12_2)
			end
		end

		if arg_12_0.sayText and string.len(arg_12_0.sayText) > 0 then
			self:showTalkSP(arg_12_0.sayText, var_12_0)
		end

		if self._talktime >= var_0_9 then
			self._angrytime = self._angrytime + 1

			self:stopActionByTag(var_0_8)

			local var_12_3 = cc.Sequence:create(cc.DelayTime:create(10), cc.CallFunc:create(function()
				self._angrytime = 0
				self._talktime = 0
			end))

			var_12_3:setTag(var_0_8)
			self:runAction(var_12_3)
		else
			self._talktime = self._talktime + 1

			self:stopActionByTag(var_0_7)

			local var_12_4 = cc.Sequence:create(cc.DelayTime:create(5), cc.CallFunc:create(function()
				self._talktime = 0
			end))

			var_12_4:setTag(var_0_7)
			self:runAction(var_12_4)
		end
	end), self)
end

function L2dLayer:insertTalk(arg_16_1)
	self:showRoleTalk(arg_16_1)
end

function L2dLayer:showRoleTalk(arg_17_1)
	if not self._modelid then
		return
	end

	if arg_17_1 then
		self.isInsertTalk = arg_17_1
		self._talktime = 0
		self._angrytime = 0
		var_0_11 = 1
		var_0_12 = nil

		if self:genRoleTalk(arg_17_1) then
			self.isInsertTalk = nil
		end
	elseif self.isInsertTalk then
		if self:genRoleTalk(self.isInsertTalk) then
			self.isInsertTalk = nil
		end
	else
		if self._talktime >= var_0_9 then
			self._angrytime = self._angrytime + 1

			self:genRoleTalk(ROLE_SOUND_TYPE.angry)
			self:stopActionByTag(var_0_8)
		elseif self:genRoleTalk(ROLE_SOUND_TYPE.random) then
			self._talktime = self._talktime + 1
		end

		self:stopActionByTag(var_0_7)
	end
end

function L2dLayer:genRoleTalk(arg_19_1)
	if not model_data[self._modelid] then
		return
	end

	if arg_19_1 == ROLE_CONVERSATION_TYPE.mainTouch then
		if var_0_11 == 1 then
			var_0_12 = GenerateRoleConversationClass(self._modelid, arg_19_1)
		end
	else
		var_0_12 = GenerateRoleConversationClass(self._modelid, arg_19_1) or GenerateRoleConversationClass(self._modelid, ROLE_CONVERSATION_TYPE.mainTouch)
	end

	if not var_0_12 then
		return
	end

	local var_19_1 = 0

	if not role_conversation_data[var_0_12 * 100 + 1] then
		return false
	end

	while role_conversation_data[var_0_12 * 100 + var_19_1 + 1] do
		var_19_1 = var_19_1 + 1
	end

	if var_19_1 < var_0_11 then
		var_0_11 = 1
	end

	self:playRoleTalk(var_0_12)

	var_0_11 = var_0_11 + 1

	if var_19_1 < var_0_11 then
		var_0_11 = 1
	end

	return var_19_1 < var_0_11
end

function L2dLayer:playRoleTalk(arg_20_1)
	local var_20_0 = role_conversation_data[arg_20_1 * 100 + var_0_11].dec
	local var_20_1 = role_conversation_data[arg_20_1 * 100 + var_0_11].sound
	local var_20_2 = role_conversation_data[arg_20_1 * 100 + var_0_11].sound_volume
	local var_20_3 = global_get_conversation_ani(arg_20_1 * 100 + var_0_11, self._modelid, 2)
	local var_20_4 = role_conversation_data[arg_20_1 * 100 + var_0_11].l2d_ani_index or 0
	local var_20_5 = var_20_3 ~= nil and l2d_manager:isModelMotionExist(self.model, var_20_3)

	if var_20_0 then
		self:showTalkSP(var_20_0)
	end

	if var_20_1 then
		audio_manager:stopAllRoleSound()

		audio_manager.playingplayersound = false
	end

	local var_20_6 = var_20_1 and audio_manager:isPlayerSoundValid()

	local function var_20_7()
		if var_20_6 then
			audio_manager.playingplayersound = false
		end

		if not self.instance then
			return
		end

		if var_20_0 then
			self:getTalkSP():setVisible(false)
		end

		self:setTouchEnabled(true)

		if self._talktime >= var_0_9 then
			self:stopActionByTag(var_0_8)

			local var_21_0 = cc.Sequence:create(cc.DelayTime:create(10), cc.CallFunc:create(function()
				self._angrytime = 0
				self._talktime = 0
			end))

			var_21_0:setTag(var_0_8)
			self:runAction(var_21_0)
		else
			self:stopActionByTag(var_0_7)

			local var_21_1 = cc.Sequence:create(cc.DelayTime:create(5), cc.CallFunc:create(function()
				self._talktime = 0
			end))

			var_21_1:setTag(var_0_7)
			self:runAction(var_21_1)
		end

		if self.talkFinishCallback then
			self.talkFinishCallback()

			self.talkFinishCallback = nil
		end
	end

	self:setTouchEnabled(false)

	if var_20_6 then
		audio_manager.playingplayersound = true

		audio_manager:stopAllRoleSound()
		audio_manager:playPlayerSound("sound/role_voice/" .. var_20_1, nil, var_20_2, var_20_7)
	else
		self:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(var_20_7)))
	end

	if var_20_5 then
		l2d_manager:doModelMotion(self.model, var_20_3, var_20_4)
	end
end

function L2dLayer:showTalkSP(arg_24_1, arg_24_2)
	if arg_24_2 and arg_24_2 <= 0 then
		arg_24_2 = 3
	end

	local var_24_0 = self:getTalkSP()

	var_24_0:getChildByName("talklabel"):setString(arg_24_1)

	local var_24_1 = var_24_0:getChildByName("talklabel"):getContentSize().width + 100
	local var_24_2 = var_24_0:getChildByName("talklabel"):getContentSize().height + 70

	var_24_1 = var_24_1 < 348 and 348 or var_24_1
	var_24_2 = var_24_2 < 132 and 132 or var_24_2

	var_24_0:setPreferredSize(cc.size(var_24_1, var_24_2))
	var_24_0:getChildByName("talklabel"):setPosition(cc.p(20, self._talksp:getContentSize().height / 2 - 20))
	var_24_0:setPosition(cc.p(l2d_manager:getModelTextPosX(self.model), l2d_manager:getModelTextPosY(self.model)))
	var_24_0:setVisible(true)
	var_24_0:stopAllActions()

	if arg_24_2 then
		var_24_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_24_2), cc.Hide:create()))
	end
end

function L2dLayer:getTalkSP()
	if not self._talksp then
		local var_25_0 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_25_0:setMaxLineWidth(357)
		var_25_0:setString(dec)
		var_25_0:setAnchorPoint(cc.p(0, 0.5))
		var_25_0:setColor(cc.c3b(71, 75, 86))
		var_25_0:setName("talklabel")

		if config._DEBUG then
			self._talksp = cc.Scale9Sprite:create("public/talk/word_bg.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/talk/word_bg.png")
		end

		self._talksp:setCapInsets(cc.rect(100, 50, 200, 20))
		self._talksp:setPreferredSize(cc.size(var_25_0:getContentSize().width + 40, var_25_0:getContentSize().height + 37))
		var_25_0:setPosition(cc.p(20, self._talksp:getContentSize().height / 2 - 24))
		self._talksp:addChild(var_25_0, 3)

		if LayerManager:getActiveLayerName() == "MainLayer" then
			LayerManager:getActiveLayerObj():addChild(self._talksp, 10)
		elseif LayerManager:getActiveLayerName() == "Live2dDebug" then
			self:getParent():addChild(self._talksp, 10)
		else
			LayerManager:getCurrentLayerObj():addChild(self._talksp, 10)
		end

		self._talksp:setVisible(false)
		self._talksp:registerScriptHandler(function(arg_26_0)
			if arg_26_0 == "exit" then
				self._talksp = nil
			end
		end)
	end

	return self._talksp
end

function L2dLayer:removeTalkSP()
	if self._talksp then
		self._talksp:runAction(cc.RemoveSelf:create())

		self._talksp = nil
	end
end

function L2dLayer.setTouchTalkCallback(arg_28_0, arg_28_1)
	arg_28_0.touchTalkCallback = arg_28_1
end

function L2dLayer:movePlayer(arg_29_1)
	if arg_29_1 == 1 then
		self:moveTo(0.5, cc.p(l2d_manager:getModelOffsetX(self.model), l2d_manager:getModelOffsetY(self.model)))
	else
		self:moveTo(0.5, cc.p(0, 0))
	end
end

function L2dLayer:moveTo(arg_30_1, arg_30_2)
	self:unActionScheduler()

	local var_30_0 = {
		x = l2d_manager:getModelPositionX(self.model),
		y = l2d_manager:getModelPositionY(self.model)
	}
	local var_30_1 = require("fight.tween").new(arg_30_1, var_30_0, {
		x = l2d_manager:getModelInitX(self.model) + arg_30_2.x,
		y = l2d_manager:getModelInitY(self.model) + arg_30_2.y
	})

	self:actionScheduler(function(arg_31_0)
		if var_30_1:update(arg_31_0) then
			self:unActionScheduler()
		end

		l2d_manager:setModelPosition(self.model, var_30_0.x, var_30_0.y)
	end)
end

function L2dLayer:unActionScheduler()
	if self._scheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._scheduler)

		self._scheduler = nil
	end
end

function L2dLayer.actionScheduler(arg_33_0, arg_33_1)
	arg_33_0._scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(arg_33_1, 0, false)
end

function L2dLayer.setTalkCallback(arg_34_0, arg_34_1)
	arg_34_0.talkFinishCallback = arg_34_1
end

function L2dLayer:playTalkCallBack()
	if self.talkFinishCallback then
		self.talkFinishCallback()
	end
end

function L2dLayer:fix()
	self:addChild(cc.Sprite:create("mainScenebg/role_cover.png"), 10)
	self:addChild(cc.Sprite:create("mainScenebg/role_cover.png"), 10)
end
