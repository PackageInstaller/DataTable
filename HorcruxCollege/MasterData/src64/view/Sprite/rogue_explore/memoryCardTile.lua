local baseCard = class("baseCard", function()
	return cc.Node:create()
end)

function baseCard:create()
	local var_2_0 = baseCard.new()

	var_2_0:init()

	return var_2_0
end

function baseCard:init()
	self:setPosition(cc.p(0, 0))

	self.m_scaleDt = 1
	self.m_isScale = false
	self.m_isFront = true
	self.m_pFront = nil
	self.m_pBack = nil
	self.m_box = nil
	self.m_name = ""
end

function baseCard:bindFontSprite(arg_4_1)
	self.m_pFront = arg_4_1

	self.m_pFront:setScaleX(0)
	self:addChild(self.m_pFront)
end

function baseCard:bindBackSprite(arg_5_1)
	self.m_pBack = arg_5_1

	self:addChild(self.m_pBack)
end

function baseCard:getFrontImage()
	return self.m_pFront
end

function baseCard:getBackImage()
	return self.m_pBack
end

function baseCard:setDt(arg_8_1)
	self.m_scaleDt = arg_8_1
end

function baseCard:getDt()
	return self.m_scaleDt
end

function baseCard:scaleCard()
	if self.m_isScale == false then
		self.m_isScale = true

		local var_10_0 = cc.Sequence:create(cc.ScaleTo:create(self.m_scaleDt, 0, 1), cc.CallFunc:create(self:scaleCardStepTwo()))

		if self.m_pFront:getScaleX() == 1 then
			self.m_pFront:runAction(var_10_0)

			self.m_isFront = false
		else
			self.m_pBack:runAction(var_10_0)

			self.m_isFront = true
		end
	end
end

function baseCard:scaleCardStepTwo()
	return function()
		local var_12_0 = cc.Sequence:create(cc.ScaleTo:create(self.m_scaleDt, 1, 1), (cc.CallFunc:create(function()
			self.m_isScale = false
		end)))

		if self.m_isFront == false then
			self.m_pBack:runAction(var_12_0)
		else
			self.m_pFront:runAction(var_12_0)
		end
	end
end

function baseCard:setRect()
	local var_14_0 = self.m_pFront:getContentSize()
	local var_14_1 = self:getBoundingBox()

	self.m_box = cc.rect(var_14_1.x - var_14_0.width / 2, var_14_1.y - var_14_0.height / 2, var_14_0.width, var_14_0.height)
end

function baseCard:isRectContainsPoint(arg_15_1)
	if cc.rectContainsPoint(self.m_box, arg_15_1) then
		return true
	else
		return false
	end
end

local TileSprite = require("view.Sprite.explore.TileSprite")
local memoryCardTile = class("memoryCardTile", function(arg_16_0)
	return TileSprite:createNode(arg_16_0)
end)
local explore_manager = require("controller.explore_manager")
local L2Actor = require("view.Sprite.L2Actor")
local item_manager = require("controller.item_manager")
local explore_img_data = require("data.explore.explore_img_data")
local model_data = require("data.model_data")
local tile_data = require("data.explore.tile_data")
local servant_data = require("data.servant_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local item_data = require("data.item_data")
local audio_manager = require("controller.audio_manager")
local audio_module = require("controller.audio_module")
local explore_memory_card_img_data = require("data.explore.explore_memory_card_img_data")
local var_0_15 = config._DEBUG and 0 or 1
local var_0_17 = 8
local var_0_18 = {
	6700106,
	6700301,
	6700302,
	6700303,
	6700304,
	6700305,
	6700306,
	6700308
}

function memoryCardTile:create(arg_17_1)
	local var_17_0 = memoryCardTile.new(arg_17_1)

	if explore_memory_card_img_data[explore_manager.curMapConfig.aimid] then
		for iter_17_0, iter_17_1 in pairs(var_0_18) do
			if explore_memory_card_img_data[explore_manager.curMapConfig.aimid]["item_" .. iter_17_0] then
				var_0_18[iter_17_0] = explore_memory_card_img_data[explore_manager.curMapConfig.aimid]["item_" .. iter_17_0]
			end
		end
	end

	var_17_0:init(arg_17_1)

	var_17_0.time = tonumber(var_17_0.tileInfo.result1_param_next2 or 40)

	return var_17_0
end

local function var_0_19(arg_18_0)
	for iter_18_0 = #arg_18_0, 1, -1 do
		local var_18_0 = math.random(1, iter_18_0)

		arg_18_0[var_18_0], arg_18_0[iter_18_0] = arg_18_0[iter_18_0], arg_18_0[var_18_0]
	end
end

function memoryCardTile:initother(arg_19_1)
	self.point = 0
	self.isMatch = false
	self.preCard = nil
	self.cardTable = {}

	for iter_19_0 = 1, var_0_17 do
		for iter_19_1 = 1, 2 do
			local var_19_0 = baseCard:create()

			self.panelBottom:addChild(var_19_0)

			self.cardTable[#self.cardTable + 1] = var_19_0

			local var_19_1

			if config._DEBUG then
				var_19_1 = cc.Sprite:create("Activity_bianhua/MemoryCard/front.png") or cc.Sprite:createWithSpriteFrameName("Activity_bianhua/MemoryCard/front.png")
			end

			local var_19_2 = ccui.ImageView:create("equipment/" .. var_0_18[iter_19_0] .. ".png")

			var_19_2:setScale(0.66)
			var_19_2:setPosition(cc.p(var_19_1:getContentSize().width / 2, var_19_1:getContentSize().height / 2))
			var_19_1:addChild(var_19_2, 99)
			var_19_1:setPosition(cc.p(0, 0))
			var_19_0:bindFontSprite(var_19_1)

			local var_19_3

			if config._DEBUG then
				var_19_3 = cc.Sprite:create("Activity_bianhua/MemoryCard/back.png") or cc.Sprite:createWithSpriteFrameName("Activity_bianhua/MemoryCard/back.png")
			end

			var_19_3:setPosition(cc.p(0, 0))
			var_19_0:bindBackSprite(var_19_3)
			var_19_0:setName("food" .. iter_19_0)
			var_19_0:setDt(0.2)
		end
	end

	var_0_19(self.cardTable)

	for iter_19_2 = 1, var_0_17 * 2 do
		self.cardTable[iter_19_2]:setPosition(cc.p(75, 565))
		self.cardTable[iter_19_2]:setRect()

		local var_19_4 = 75 + 120

		if iter_19_2 % 4 == 0 then
			var_19_4 = 75
		end
	end

	local var_19_6 = cc.EventListenerTouchOneByOne:create()

	var_19_6:registerScriptHandler(function(arg_20_0, arg_20_1)
		if self.confirm and self.confirm.isTouch then
			self:onTouchBegan(arg_20_0, arg_20_1, arg_19_1)

			return true
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_19_6:registerScriptHandler(function(arg_21_0, arg_21_1)
		return
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self.panelBottom:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_19_6, self.panelBottom)

	self.confirm.index = 0

	local function var_19_7()
		self.confirm.index = self.confirm.index + 1

		if self.confirm.index == 4 then
			self.confirm.endTime:runAction(cc.RemoveSelf:create())

			for iter_22_0 = 1, var_0_17 * 2 do
				self.cardTable[iter_22_0]:scaleCard()
			end

			self.confirm:stopAllActions()
			self.confirm:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
				for iter_23_0, iter_23_1 in pairs(self.cardTable) do
					iter_23_1:scaleCard()
				end

				self:endGame()

				self.confirm.isTouch = true
			end)))
		end

		if not self.confirm.endTime and self.confirm.index < 4 then
			self.confirm.endTime = ccui.ImageView:create("Activity_bianhua/MemoryCard/" .. self.confirm.index .. ".png", var_0_15)

			self.confirm.endTime:setPosition(cc.p(self.imgBottom:getContentSize().width / 2, self.imgBottom:getContentSize().height / 2))
			self.imgBottom:addChild(self.confirm.endTime, 99)
		elseif self.confirm.index < 4 then
			self.confirm.endTime:loadTexture("Activity_bianhua/MemoryCard/" .. self.confirm.index .. ".png", var_0_15)
		end
	end

	self.btnStart:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.btnStart:setVisible(false)
		self.confirm:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(var_19_7), cc.DelayTime:create(1))))
	end)
end

function memoryCardTile:onTouchBegan(arg_25_1, arg_25_2, arg_25_3)
	local function var_25_0()
		self.preCard = nil
		self.isMatch = false
	end

	local var_25_1 = self.panelBottom:convertToNodeSpace(arg_25_1:getLocation())

	if self.isMatch == false then
		for iter_25_0, iter_25_1 in pairs(self.cardTable) do
			if iter_25_1:isRectContainsPoint(var_25_1) then
				if iter_25_1:getBackImage():getScaleX() == 1 then
					iter_25_1:scaleCard()

					if self.preCard == nil then
						self.preCard = iter_25_1
					else
						self.isMatch = true

						if self.preCard:getName() == iter_25_1:getName() then
							self.confirm:runAction(cc.Sequence:create(cc.DelayTime:create(iter_25_1:getDt() * 3), cc.CallFunc:create(function()
								self.preCard:setVisible(false)
								iter_25_1:setVisible(false)
							end), cc.CallFunc:create(var_25_0)))

							self.point = self.point + 1

							if self.point == var_0_17 then
								self.parent.root.touchLock = false

								self.confirm:stopAllActions()
								self.confirm:runAction(cc.Sequence:create(cc.CallFunc:create(function()
									local var_28_0 = ccui.ImageView:create("Activity_bianhua/MemoryCard/success.png", var_0_15)

									var_28_0:setPosition(cc.p(self.imgBottom:getContentSize().width / 2, self.imgBottom:getContentSize().height / 2))
									self.imgBottom:addChild(var_28_0, 99)
								end), cc.DelayTime:create(1), cc.CallFunc:create(function()
									if self.confirm.scheduler then
										cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.confirm.scheduler)

										self.confirm.scheduler = nil
									end

									self.confirm:runAction(cc.RemoveSelf:create())
									self:runTileEvent(arg_25_3)
								end)))

								if self.confirm.scheduler then
									cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.confirm.scheduler)

									self.confirm.scheduler = nil
								end
							end
						else
							self.confirm:runAction(cc.Sequence:create(cc.DelayTime:create(iter_25_1:getDt() * 3), cc.CallFunc:create(function()
								self.preCard:scaleCard()
								iter_25_1:scaleCard()
								var_25_0()
							end)))
						end
					end

					break
				end
			end
		end
	end
end

function memoryCardTile:checkTriggerPrecondition()
	local function var_31_0()
		local var_32_0

		if self.tileInfo.result1_type then
			local var_32_1 = not self.tileInfo.result2_type and 1 or self.parent.usedTile[self.idx].result and self.parent.usedTile[self.idx].result or 1

			var_32_0 = {
				type = self.tileInfo["result" .. var_32_1 .. "_type"],
				param = self.tileInfo["result" .. var_32_1 .. "_param"],
				des = self.tileInfo["result" .. var_32_1 .. "_des"],
				result_count = var_32_1
			}
		else
			var_32_0 = {}
		end

		local var_32_3

		if self.tileInfo.trigger_type > 0 then
			if self.tileInfo.trigger_type ~= 1 then
				if self.tileInfo.trigger_type == 4 then
					local var_32_2 = {
						trigger_type = self.tileInfo.trigger_type,
						needid = self.tileInfo.trigger_param1,
						neednum = self.tileInfo.trigger_param2
					}

					var_32_2.needItems = self:readNeedItems()
					var_32_2.ownnum = explore_manager:getItemNumber(self.tileInfo.trigger_param1)
					var_32_2.des = self.tileInfo.trigger_des

					function var_32_2.surecallback()
						LayerManager:pushInLayer("PopMemorycardLayer", {
							time = self.time,
							runTileEvent = function()
								self:runTileEvent(var_32_0)
							end,
							exitCallback = function()
								self:exit()
							end
						})
					end

					function var_32_2.cancelcallback()
						self.parent.root.touchLock = false
					end

					self.parent.root:addChild(self:needKeyPopLayer(var_32_2), 999)

					goto label_32_0
				end
			end

			var_32_3 = {
				time = self.time
			}
		end

		function var_32_3.runTileEvent()
			self:runTileEvent(var_32_0)
		end

		function var_32_3.exitCallback()
			self:exit()
		end

		LayerManager:pushInLayer("PopMemorycardLayer", var_32_3)

		::label_32_0::
	end

	if self.tileInfo.card_trigger_talk then
		global_basic_scene:addChild(self.tileInfo.card_trigger_talk_type == 2 and TalkLayer:create(self.tileInfo.card_trigger_talk, nil, 1, "", var_31_0) or ExploreTalkLayer:create({
			classification = self.tileInfo.card_trigger_talk,
			finishCallback = var_31_0
		}), ZORDER_TALKLAYER)
	else
		var_31_0()
	end
end

function memoryCardTile:pop_memoryPanel(arg_39_1)
	self.confirm = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopMemoryCard.json" or "PopMemoryCard.ExportJson")
	self.imgBottom = ccui.Helper:seekWidgetByName(self.confirm, "Image_bottom")
	self.panelBottom = ccui.Helper:seekWidgetByName(self.confirm, "Panel_bottom")
	self.btnStart = ccui.Helper:seekWidgetByName(self.confirm, "Button_start")
	self.surplusTime = ccui.Helper:seekWidgetByName(self.confirm, "Label_time")

	self.surplusTime:setString("00:" .. self.time)
	self:initother(arg_39_1)

	local var_39_0 = ccui.Helper:seekWidgetByName(self.confirm, "Panel_back")

	var_39_0:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
	var_39_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_39_0:setPositionY(-GameDisplay.fix_y)

	return self.confirm
end

function memoryCardTile:exit()
	self.parent.root.touchLock = false
end

function memoryCardTile:endGame()
	self.confirm.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_43_0)
		self.time = self.time - 1

		self.surplusTime:setString("00:" .. self.time)

		if self.time == 0 then
			self.confirm:stopAllActions()
			self.confirm:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				local var_44_0 = ccui.ImageView:create("Activity_bianhua/MemoryCard/fail.png", var_0_15)

				var_44_0:setPosition(cc.p(self.imgBottom:getContentSize().width / 2, self.imgBottom:getContentSize().height / 2))
				self.imgBottom:addChild(var_44_0, 99)

				self.isMatch = true
			end), cc.DelayTime:create(1), cc.CallFunc:create(function()
				self.confirm:runAction(cc.RemoveSelf:create())

				self.parent.root.touchLock = false
			end)))
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.confirm.scheduler)

			self.confirm.scheduler = nil
		end
	end, 1, false)
end

return memoryCardTile
