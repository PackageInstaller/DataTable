LoadingLayer = class("LoadingLayer", function()
	return cc.Layer:create()
end)

local loading_texture_manager = require("controller.loading_texture_manager")
local playermodel = require("model.playermodel")
local twist_manager = require("controller.twist_manager")

require("view.Sprite.ItemSprite")

function LoadingLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = LoadingLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function LoadingLayer:init(arg_3_1)
	self.loadconf = arg_3_1

	self:initUI()
	self:startLoading()
	self:startAction()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			loading_texture_manager:unregisterLoadingInfo()
		end
	end)
end

function LoadingLayer:initUI()
	local var_5_0 = ccui.Layout:create()

	var_5_0:setContentSize(cc.size(640, 1136))
	var_5_0:setTouchEnabled(true)
	self:addChild(var_5_0)

	self.up = cc.Sprite:create("mainScenebg/loading_bg.jpg")

	self.up:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2 - GameDisplay.fix_y))
	self:addChild(self.up, 1)

	if config._DEBUG then
		self.min = cc.Sprite:create("loadinglayer/min.png") or cc.Sprite:createWithSpriteFrameName("loadinglayer/min.png")
	end

	self.min:setPosition(cc.p(320, 686))
	self:addChild(self.min, 2)

	if config._DEBUG then
		self.mid = cc.Sprite:create("loadinglayer/mid.png") or cc.Sprite:createWithSpriteFrameName("loadinglayer/mid.png")
	end

	self.mid:setPosition(cc.p(320, 686))
	self:addChild(self.mid, 2)

	if config._DEBUG then
		self.max = cc.Sprite:create("loadinglayer/max.png") or cc.Sprite:createWithSpriteFrameName("loadinglayer/max.png")
	end

	self.max:setPosition(cc.p(320, 686))
	self:addChild(self.max, 2)

	if config._DEBUG then
		self.icon = cc.Sprite:create("loadinglayer/icon.png") or cc.Sprite:createWithSpriteFrameName("loadinglayer/icon.png")
	end

	self.icon:setPosition(cc.p(320, 686))
	self:addChild(self.icon, 3)

	if self.loadconf.layerName == "TwisteggLayer" or self.loadconf.layerName == "TwisteggSkinLayer" then
		local var_5_1 = (not playermodel.cur_medal[1] or playermodel.cur_medal[1] == 0) and (not playermodel.cur_medal[2] or playermodel.cur_medal[2] == 0) and (not playermodel.cur_medal[3] or playermodel.cur_medal[3] == 0) and L_TWISTEGG_LOADING[1] or L_TWISTEGG_LOADING[2]

		self.fontList = {}

		local var_5_2 = ccui.Layout:create()

		self:addChild(var_5_2, 4)

		local var_5_3 = 0
		local var_5_4

		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			local var_5_5 = cc.Label:createWithTTF(iter_5_1, FONT_DES, 34)

			var_5_4 = var_5_5:getContentSize().width

			local var_5_6 = ccui.Layout:create()

			var_5_6:setContentSize(cc.size(var_5_5:getContentSize().width, var_5_5:getContentSize().width))
			var_5_6:addChild(var_5_5)
			var_5_6:setPosition(cc.p(0 + var_5_3, 0))
			var_5_2:addChild(var_5_6, 4)

			var_5_3 = var_5_5:getContentSize().width + var_5_3
			self.fontList[#self.fontList + 1] = var_5_6
		end

		local var_5_7 = var_5_3 + 20

		for iter_5_2 = 1, 3 do
			if playermodel.cur_medal[iter_5_2] and playermodel.cur_medal[iter_5_2] ~= 0 then
				local var_5_9 = ItemSprite:create_medal_icon(playermodel.cur_medal[iter_5_2])
				local var_5_10 = var_5_9:getContentSize().width

				var_5_9:setPosition(cc.p(0 + var_5_7, 0))
				var_5_2:addChild(var_5_9, 4)

				var_5_7 = var_5_9:getContentSize().width + var_5_7
				self.fontList[#self.fontList + 1] = var_5_9
			end
		end

		var_5_2:setPosition(320 - ((nil or nil) and (var_5_7 - nil / 2 + var_5_4 / 2 or var_5_7 - 20)) / 2 + var_5_4 / 2, 400)
	end
end

function LoadingLayer:startLoading()
	self:registerLoadingEvent()
	loading_texture_manager:startLoadingTextures(self.loadconf.layerName, function()
		self:loadEnding()
	end)
end

function LoadingLayer:registerLoadingEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("DOWNLOAD_EVENT_COMPLETE", function(arg_9_0)
		loading_texture_manager:onDownloadComplete(arg_9_0.fileName)
	end), self)
end

function LoadingLayer:startAction()
	local var_10_0 = cc.RotateBy:create(2, 360)

	self.max:runAction(cc.RepeatForever:create(var_10_0))
	self.min:runAction(cc.RepeatForever:create(var_10_0:reverse()))

	if self.fontList then
		local var_10_1 = 1

		self:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.75 / #self.fontList), cc.CallFunc:create(function()
			if var_10_1 > #self.fontList then
				if var_10_1 > #self.fontList + 1 then
					var_10_1 = 0
				end

				return
			end

			local var_11_0 = cc.MoveBy:create(1 / #self.fontList, cc.p(0, 50))

			self.fontList[var_10_1]:runAction(cc.Sequence:create(var_11_0, var_11_0:reverse()))

			var_10_1 = var_10_1 + 1
		end))))
	end
end

function LoadingLayer:loadEnding()
	local var_12_0 = cc.EventCustom:new("switchShowLayer")

	var_12_0.layerName = self.loadconf.layerName
	var_12_0.initparam = self.loadconf.initparam

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_12_0)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		self.max:stopAllActions()
		self.min:stopAllActions()
	end), cc.RemoveSelf:create()))
end
