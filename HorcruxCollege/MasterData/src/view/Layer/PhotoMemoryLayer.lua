PhotoMemoryLayer = class("PhotoMemoryLayer", function()
	return cc.Layer:create()
end)

require("data.constants")

local photo_manager = require("controller.photo_manager")
local var_0_2 = "memory_thread"
local var_0_3 = {}

var_0_3[#var_0_3 + 1] = "memory_thread"
var_0_3[#var_0_3 + 1] = "memory_branch"
var_0_3[#var_0_3 + 1] = "memory_postcard"

local var_0_4 = {}

var_0_4[#var_0_4 + 1] = L_SCHOOL_CINEMA_TYPE.photoData
var_0_4[#var_0_4 + 1] = L_SCHOOL_CINEMA_TYPE.explorePhotoData
var_0_4[#var_0_4 + 1] = L_SCHOOL_CINEMA_TYPE.postcardData

local var_0_5 = {}

var_0_5.memory_thread = true
var_0_5.memory_branch = true
var_0_5.memory_postcard = true

local conversation_data = require("data.conversation_data")
local conversation_extension_data = require("data.conversation_extension_data")
local travel_photo_data = require("data.travel_photo_data")
local var_0_9 = {
	memory_thread = require("data.photo_data"),
	memory_branch = require("data.photo_extension_data"),
	memory_postcard = require("data.postcard_data")
}
local var_0_10 = "Photo/plot_play.png"
local var_0_11 = "Photo/plot_lock.png"
local var_0_13 = config._DEBUG and 0 or 1
local var_0_14 = "ALL"
local var_0_15 = "UNLOCK"

function PhotoMemoryLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PhotoMemoryLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PhotoMemoryLayer.exit(arg_3_0)
	photo_manager:releaseAllData()
	LayerManager:switchReturnLayer("SchoolCinemaLayer")
end

function PhotoMemoryLayer.topupdate()
	return {
		"public/return1.png",
		"public/return1_on.png"
	}
end

function PhotoMemoryLayer:init(arg_5_1)
	local var_5_0 = cc.EventCustom:new("showTopBottomLayer")

	var_5_0.showconfig = {
		ListButtonLayer = false,
		TopcostLayer = false
	}

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_5_0)

	self.select_buttonMode = var_0_14
	self.talkType = nil
	self.runLayer = nil
	self.size = cc.Director:getInstance():getVisibleSize()
	self.bottomList = nil
	self.rootlayer = cc.Layer:create()

	self.rootlayer:setAnchorPoint(cc.p(0, 0))
	self:addChild(self.rootlayer)
	require("view.Sprite.TitleSprite")

	local var_5_1 = TitleSprite:create("public/title/Memory.png", 2)

	var_5_1:setPosition(0, 1080)
	self.rootlayer:addChild(var_5_1, 25)

	self.unlockLabel = cc.Label:createWithTTF(L_UNLOCK, FONT_NAME, 28)

	self.unlockLabel:setPosition(cc.p(476, 1103))
	self.unlockLabel:setColor(cc.c3b(198, 216, 233))
	self:addChild(self.unlockLabel, 1000)

	self.unlockNumLabel = cc.Label:createWithTTF(" ", FONT_DES, 22)

	self.unlockNumLabel:setAnchorPoint(cc.p(0, 0.5))
	self.unlockNumLabel:setPosition(cc.p(self.unlockLabel:getPositionX() + 35, self.unlockLabel:getPositionY()))
	self.unlockNumLabel:setName("unlockNumLabel")
	self.unlockNumLabel:setColor(cc.c3b(255, 164, 16))
	self:addChild(self.unlockNumLabel, 1000)
	self:setBottomBtnList()

	self.leftMemoryListCount = #var_0_4
	self.leftMemoryListSize = cc.p(52, 162)
	self.index = self.leftMemoryListCount - 1
	self.space = 200
	self.indexOrder = 0
	self.leftBtnList = {}
	self.cellList = {}

	local var_5_2 = cc.TableView:create(cc.size(52, self.size.height - 58))

	var_5_2:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_5_2:setPosition(cc.p(0, 0))
	var_5_2:setDelegate()
	self.rootlayer:addChild(var_5_2)
	var_5_2:registerScriptHandler(function(arg_7_0)
		return self.leftMemoryListCount
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_5_2:registerScriptHandler(function(arg_8_0)
		layout = arg_8_0:getContainer()
		currentY = layout:getPositionY()

		if -currentY > layout:getContentSize().height - arg_8_0:getViewSize().height then
			arg_8_0:setContentOffset(cc.p(0, -layout:getContentSize().height + arg_8_0:getViewSize().height))
		end
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_5_2:registerScriptHandler(function(arg_9_0, arg_9_1)
		if var_0_5[var_0_3[#var_0_3 - arg_9_1:getIdx()]] == false then
			global_ShowBlockWords(L_FUNCTION_NO_OPEN)

			return
		end

		local var_9_0 = self.leftBtnList[tostring(self.index)]

		if config._DEBUG then
			var_9_0:setTexture("public/button/selected_tab_mid.png")
			var_9_0:getChildByName("text"):setColor(cc.c3b(152, 156, 183))
		else
			var_9_0:setSpriteFrame("public/button/selected_tab_mid.png")
			var_9_0:getChildByName("text"):setColor(cc.c3b(152, 156, 183))
		end

		local var_9_1 = var_9_0:getChildByName("text")
		local var_9_2 = self.leftBtnList[tostring(arg_9_1:getIdx())]

		if config._DEBUG then
			var_9_2:setTexture("public/button/selected_tab_top_on.png")
			var_9_2:getChildByName("text"):setColor(cc.c3b(140, 215, 255))
		else
			var_9_2:setSpriteFrame("public/button/selected_tab_top_on.png")
			var_9_2:getChildByName("text"):setColor(cc.c3b(140, 215, 255))
		end

		local var_9_3 = var_9_2:getChildByName("text")

		self.index = arg_9_1:getIdx()

		for iter_9_0, iter_9_1 in pairs(self.cellList) do
			iter_9_1:setLocalZOrder(iter_9_1:getIdx())
		end

		arg_9_1:setLocalZOrder(999)

		if var_0_3[self.leftMemoryListCount - arg_9_1:getIdx()] == "memory_postcard" then
			photo_manager:getPostcardTaskData(function()
				self:showRightViewList(var_0_3[self.leftMemoryListCount - arg_9_1:getIdx()])
			end)
		else
			self:showRightViewList(var_0_3[self.leftMemoryListCount - arg_9_1:getIdx()])
		end
	end, cc.TABLECELL_TOUCHED)
	var_5_2:registerScriptHandler(function(arg_11_0, arg_11_1)
		if arg_11_1 == 0 then
			return 52, 362
		else
			return 52, 162
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_5_2:registerScriptHandler(function(arg_6_0, arg_6_1)
		local var_6_0 = string.format("%d", arg_6_1)
		local var_6_1 = arg_6_0:dequeueCell()

		if var_6_1 == nil then
			var_6_1 = cc.TableViewCell:new()

			local var_6_3 = arg_6_1 == self.leftMemoryListCount - 1 and (config._DEBUG and cc.Sprite:create("public/button/selected_tab_top_on.png") or cc.Sprite:createWithSpriteFrameName("public/button/selected_tab_top_on.png")) or config._DEBUG and cc.Sprite:create("public/button/selected_tab_mid.png") or cc.Sprite:createWithSpriteFrameName("public/button/selected_tab_mid.png")
			local var_6_5 = cc.Label:createWithTTF((var_0_4[self.leftMemoryListCount - arg_6_1] or nil) and var_0_4[self.leftMemoryListCount - arg_6_1], FONT_BUTTON, 25)

			var_6_5:setName("text")
			var_6_5:setPosition(cc.p(25, 95))
			var_6_5:setLineBreakWithoutSpace(true)
			var_6_5:setMaxLineWidth(26)

			if arg_6_1 == self.leftMemoryListCount - 1 then
				var_6_5:setColor(cc.c3b(140, 215, 255))
			else
				var_6_5:setColor(cc.c3b(152, 156, 183))
			end

			var_6_3:addChild(var_6_5)
			var_6_3:setAnchorPoint(cc.p(0, 0))

			if arg_6_1 == 0 then
				var_6_3:setPosition(cc.p(0, 0 + self.space))
			else
				var_6_3:setPosition(cc.p(0, 0))
			end

			self.leftBtnList[tostring(var_6_0)] = var_6_3

			var_6_1:addChild(var_6_3)
		else
			var_6_1:removeAllChildren()

			local var_6_6 = arg_6_1 == self.leftMemoryListCount - 1 and (config._DEBUG and cc.Sprite:create("public/button/selected_tab_top_on.png") or cc.Sprite:createWithSpriteFrameName()) or config._DEBUG and cc.Sprite:create("public/button/selected_tab_top_on.png") or cc.Sprite:createWithSpriteFrameName()
			local var_6_8 = cc.Label:createWithTTF((var_0_4[self.leftMemoryListCount - arg_6_1] or nil) and var_0_4[self.leftMemoryListCount - arg_6_1], FONT_BUTTON, 25)

			var_6_8:setName("text")
			var_6_8:setPosition(cc.p(25, 95))
			var_6_8:setLineBreakWithoutSpace(true)
			var_6_8:setMaxLineWidth(26)

			if arg_6_1 == self.leftMemoryListCount - 1 then
				var_6_8:setColor(cc.c3b(140, 215, 255))
			else
				var_6_8:setColor(cc.c3b(152, 156, 183))
			end

			var_6_6:addChild(var_6_8)
			var_6_6:setAnchorPoint(cc.p(0, 0))

			if arg_6_1 == 0 then
				var_6_6:setPosition(cc.p(0, 0 + self.space))
			else
				var_6_6:setPosition(cc.p(0, 0))
			end

			self.leftBtnList[tostring(var_6_0)] = var_6_6

			var_6_1:addChild(var_6_6)
		end

		if arg_6_1 == self.leftMemoryListCount - 1 then
			tempCell = var_6_1
		end

		self.cellList[#self.cellList + 1] = var_6_1

		return var_6_1
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_5_2:reloadData()

	self.memorySelectType = var_0_2

	self:showRightViewList(self.memorySelectType)
end

function PhotoMemoryLayer:setBottomBtnList()
	if self.bottomlist then
		self:removeChild(self.bottomlist)
	end

	local var_12_0 = {
		{
			name = "select"
		}
	}

	var_12_0[1].word = self.select_buttonMode == var_0_14 and L_PHOTO_SELECT_BUTTON_MODE[1] or L_PHOTO_SELECT_BUTTON_MODE[2]
	var_12_0[1].handler = function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.select_buttonMode = self.select_buttonMode == var_0_14 and var_0_15 or var_0_14

		self:setBottomBtnList()
		self:showRightViewList()
	end
	self.bottomList = BottomBtnList:create(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end, var_12_0)

	self.bottomList:setName("bottomlist")
	self:addChild(self.bottomList, 1000)
end

function PhotoMemoryLayer:showRightViewList(arg_15_1)
	self.rootlayer:removeChild(self.runLayer)

	if arg_15_1 then
		self.memorySelectType = arg_15_1
	end

	local var_15_0 = 0
	local var_15_1 = 0

	self.totalNumber = nil
	self.storyInfo = nil

	if self.memorySelectType == var_0_3[1] then
		photo_manager:initThreadStoryData()

		self.talkType = TALK_TYPE_NORMAL

		if self.select_buttonMode == var_0_14 then
			self.totalNumber = photo_manager:getThreadStoryNumber()
			self.storyInfo = photo_manager:getThreadStoryData()
		else
			self.totalNumber = photo_manager:getTreadUnlockNumber()
			self.storyInfo = photo_manager:getUnlockThreadData()
		end

		var_15_0 = photo_manager:getThreadStoryNumber()
		var_15_1 = photo_manager:getTreadUnlockNumber()
	elseif self.memorySelectType == var_0_3[2] then
		photo_manager:initBranchStoryData()

		self.talkType = TALK_TYPE_BRANCH

		if self.select_buttonMode == var_0_14 then
			self.totalNumber = photo_manager:getBranchStoryNumber()
			self.storyInfo = photo_manager:getBranchStoryData()
		else
			self.totalNumber = photo_manager:getBranchUnlockNumber()
			self.storyInfo = photo_manager:getUnlockBranchData()
		end

		var_15_0 = photo_manager:getBranchStoryNumber()
		var_15_1 = photo_manager:getBranchUnlockNumber()
	elseif self.memorySelectType == var_0_3[3] then
		photo_manager:initEventStoryData()

		self.talkType = TALK_TYPE_EVENT

		if self.select_buttonMode == var_0_14 then
			self.totalNumber = photo_manager:getEventStoryNumber()
			self.storyInfo = photo_manager:getEventStoryData()
		else
			self.totalNumber = photo_manager:getEventUnlockNumber()
			self.storyInfo = photo_manager:getUnlockEventData()
		end

		var_15_0 = photo_manager:getEventStoryNumber()
		var_15_1 = photo_manager:getEventUnlockNumber()
	elseif arg_15_1 ~= nil then
		return
	end

	self.unlockNumLabel:setString(tostring(var_15_1) .. "/" .. tostring(var_15_0))

	self.memoryTableCellNumber = math.ceil(self.totalNumber / 2)

	local var_15_2 = cc.Director:getInstance():getVisibleSize()

	var_15_2.width = var_15_2.width - 52
	var_15_2.height = var_15_2.height + 100
	self.runLayer = cc.TableView:create(cc.size(var_15_2.width, 1078))

	self.runLayer:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.runLayer:setPosition(cc.p(72, 0))
	self.runLayer:setDelegate()
	self.rootlayer:addChild(self.runLayer)
	self.runLayer:registerScriptHandler(function(arg_25_0)
		return self.memoryTableCellNumber
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.runLayer:registerScriptHandler(function(arg_26_0)
		return
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	self.runLayer:registerScriptHandler(function(arg_27_0, arg_27_1)
		if self.memoryTableCellNumber > 4 and arg_27_1 == 0 then
			return 300, 180 + self.space
		end

		return 300, 180
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.runLayer:registerScriptHandler(function(arg_24_0, arg_24_1)
		local var_24_0 = string.format("%d", arg_24_1)
		local var_24_1 = arg_24_0:dequeueCell()
		local var_24_2
		local var_24_3
		local var_24_4 = (self.memoryTableCellNumber - arg_24_1) * 2 - 1

		if var_24_1 == nil then
			var_24_1 = cc.TableViewCell:create()
			var_24_2 = config._DEBUG and cc.Sprite:create("Photo/transparent.png") or cc.Sprite:createWithSpriteFrameName("Photo/transparent.png")

			if self.memoryTableCellNumber > 4 and arg_24_1 == 0 then
				var_24_2:setPosition(cc.p(0, self.space))
			else
				var_24_2:setPosition(cc.p(0, 0))
			end

			var_24_2:setAnchorPoint(cc.p(0, 0))
			var_24_2:setName("story1")
			var_24_1:addChild(var_24_2)

			if var_24_4 + 1 <= self.totalNumber then
				var_24_3 = config._DEBUG and cc.Sprite:create("Photo/transparent.png") or cc.Sprite:createWithSpriteFrameName("Photo/transparent.png")

				if self.memoryTableCellNumber > 4 and arg_24_1 == 0 then
					var_24_3:setPosition(cc.p(280, self.space))
				else
					var_24_3:setPosition(cc.p(280, 0))
				end

				var_24_3:setAnchorPoint(cc.p(0, 0))
				var_24_3:setName("story2")
				var_24_1:addChild(var_24_3)
			end
		else
			var_24_2 = var_24_1:getChildByName("story1")
			var_24_3 = var_24_1:getChildByName("story2")

			if var_24_2 and self.memoryTableCellNumber > 4 and arg_24_1 == 0 then
				var_24_2:setPosition(cc.p(0, self.space))
			else
				var_24_2:setPosition(cc.p(0, 0))
			end

			if var_24_3 and self.memoryTableCellNumber > 4 and arg_24_1 == 0 then
				var_24_3:setPosition(cc.p(280, self.space))
			elseif var_24_3 then
				var_24_3:setPosition(cc.p(280, 0))
			end
		end

		if var_24_3 then
			var_24_3:setVisible(false)
		end

		var_15_3(var_24_2, var_24_4, var_0_9[self.memorySelectType])

		if var_24_4 + 1 <= self.totalNumber and var_24_3 then
			var_24_3:setVisible(true)
			var_15_3(var_24_3, var_24_4 + 1, var_0_9[self.memorySelectType])
		end

		return var_24_1
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.runLayer:reloadData()
end

function PhotoMemoryLayer.playPV(arg_28_0, arg_28_1)
	require("view.Layer.VideoPlayerLayer")

	local audio_manager = require("controller.audio_manager")
	local var_28_1 = audio_manager.music_volume

	audio_manager.music_volume = 0

	audio_manager:setMusicVolume()

	local var_28_2 = VideoPlayerLayer:create(arg_28_1, true)

	global_basic_scene:addChild(var_28_2, ZORDER_TALKLAYER)

	local function var_28_3()
		var_28_2:runAction(cc.RemoveSelf:create())

		audio_manager.music_volume = var_28_1

		audio_manager:setMusicVolume()
	end

	var_28_2:registerEventHandler(3, var_28_3)
	var_28_2:registerEventHandler(2, var_28_3)
	var_28_2:play()
end
