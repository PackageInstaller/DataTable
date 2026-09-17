AvatarSprite = class("AvatarSprite", function()
	return ccui.Layout:create()
end)

require("view.Armature.L2Skeleton")

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = "roleimage/role/wuji/"
local var_0_2 = "spine/avatar/"
local item_data = require("data.item_data")
local var_0_4 = 1
local var_0_5 = 2

function AvatarSprite.create(arg_2_0, arg_2_1)
	local var_2_0 = AvatarSprite.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AvatarSprite:init(arg_3_1)
	self.__avatarId = arg_3_1

	if item_data[arg_3_1].spine then
		self:initSpineAvatar(arg_3_1, scale)
	else
		self:initImageAvatar(arg_3_1, scale)
	end

	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			self.__avatarId = nil

			local var_4_0 = self:getChildByName("ava_spine")

			if var_4_0 then
				var_4_0:removeFromParent()
			end
		end
	end)
end

function AvatarSprite:initImageAvatar(arg_5_1)
	self.__showType = var_0_4

	local var_5_0 = ccui.ImageView:create(var_0_1 .. item_data[arg_5_1].image_id .. ".png")

	var_5_0:setName("ava_img")
	var_5_0:setPosition(cc.p(90, 90))
	self:addChild(var_5_0)
end

function AvatarSprite:initSpineAvatar(arg_6_1)
	self.__showType = var_0_5

	local var_6_0 = L2Skeleton:create(var_0_2 .. item_data[arg_6_1].spine .. ".json", var_0_2 .. item_data[arg_6_1].spine .. ".atlas")

	var_6_0:refreshSkeleton()
	var_6_0:play("touxiang", true)
	var_6_0:setName("ava_spine")
	var_6_0:setPosition(cc.p(80, 0))
	self:addChild(var_6_0, 1)
end

function AvatarSprite:switchShowAvatar(arg_7_1)
	if self.__avatarId == arg_7_1 then
		return
	end

	self.__avatarId = arg_7_1

	if item_data[arg_7_1].spine then
		self:switchShowSpineAvatar(arg_7_1)
	else
		self:switchShowImageAvatar(arg_7_1)
	end

	if self.__touchCallback then
		self:addTouchEventListener()
	end
end

function AvatarSprite:switchShowImageAvatar(arg_8_1)
	local var_8_0 = self:getChildByName("ava_spine")

	if var_8_0 then
		var_8_0:removeFromParent()
	end

	local var_8_1 = self:getChildByName("ava_img")

	if var_8_1 then
		var_8_1:removeFromParent()
	end

	local var_8_2 = ccui.ImageView:create(var_0_1 .. item_data[arg_8_1].image_id .. ".png")

	var_8_2:setName("ava_img")
	var_8_2:setPosition(cc.p(90, 90))
	self:addChild(var_8_2)

	self.__showType = var_0_4
end

function AvatarSprite:switchShowSpineAvatar(arg_9_1)
	local var_9_0 = self:getChildByName("ava_spine")

	if var_9_0 then
		var_9_0:removeFromParent()
	end

	local var_9_1 = self:getChildByName("ava_img")

	if var_9_1 then
		var_9_1:removeFromParent()
	end

	local var_9_2 = L2Skeleton:create(var_0_2 .. item_data[arg_9_1].spine .. ".json", var_0_2 .. item_data[arg_9_1].spine .. ".atlas")

	var_9_2:refreshSkeleton()
	var_9_2:play("touxiang", true)
	var_9_2:setName("ava_spine")
	var_9_2:setPosition(cc.p(80, 0))
	self:addChild(var_9_2, 1)

	self.__showType = var_0_5
end

function AvatarSprite:addTouchEventListener(arg_10_1)
	self.__touchCallback = arg_10_1 or self.__touchCallback

	local var_10_0 = self:getChildByName("ava_spine")
	local var_10_1 = self:getChildByName("ava_img") or var_10_0
	local var_10_2 = 230
	local var_10_3

	if var_10_0 then
		var_10_3 = 150
		var_10_2 = 80
	end

	local var_10_4 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_0)

	var_10_4:setContentSize(cc.size(300, 300))
	var_10_4:setPosition(cc.p(var_10_2 or var_10_1:getContentSize().width / 2, var_10_3 or var_10_1:getContentSize().height / 2))
	var_10_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_10_4:setTouchEnabled(true)
	var_10_1:addChild(var_10_4)
	var_10_4:addTouchEventListener(function(arg_11_0, arg_11_1)
		self.__touchCallback(arg_11_0, arg_11_1)
	end)
end

function AvatarSprite:getContentSize()
	local var_12_0 = self:getChildByName("ava_spine")
	local var_12_1 = self:getChildByName("ava_img") or var_12_0
	local var_12_2
	local var_12_3

	if var_12_0 then
		var_12_3 = 300
		var_12_2 = 300
	end

	return {
		width = var_12_2 or var_12_1:getContentSize().width,
		height = var_12_3 or var_12_1:getContentSize().height
	}
end
