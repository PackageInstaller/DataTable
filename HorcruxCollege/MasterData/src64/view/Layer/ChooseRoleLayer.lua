ChooseRoleLayer = class("ChooseRoleLayer", function()
	return ccui.Layout:create()
end)

local playermodel = require("model.playermodel")
local array_manager = require("controller.array_manager")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local var_0_5 = config._DEBUG and 0 or 1
local var_0_6 = {
	"explore/explore_level3_bg8a.png",
	"explore/explore_level3_bg8a_on.png"
}
local RoleHeadSp = class("RoleHeadSp", function()
	return ccui.Button:create(var_0_6[1], var_0_6[2], var_0_6[1], var_0_5)
end)

function ChooseRoleLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ChooseRoleLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ChooseRoleLayer:init(arg_4_1)
	self:setContentSize(cc.size(640, 1136))
	self:setTouchEnabled(true)
	self:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self:setBackGroundColor(cc.c3b(15, 15, 15))
	self:setCascadeOpacityEnabled(false)
	self:setBackGroundColorOpacity(240)
	self:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runAction(cc.RemoveSelf:create())
	end)

	self.selectedRole = arg_4_1.selected
	self.consumeRecommend = arg_4_1.recommend
	self.callback = arg_4_1.callback

	self:initBg()
	self:initRoles()
	self:initButtonSure()
end

local var_0_8 = 500
local var_0_9 = 750
local var_0_10 = 150
local var_0_11 = 160
local var_0_12 = 98
local var_0_13 = 87

function ChooseRoleLayer:initBg()
	local var_6_0 = ccui.ImageView:create("public/new/large_bg.png", var_0_5)

	var_6_0:setPosition(cc.p(320, 568))
	self:addChild(var_6_0)

	local var_6_1 = ccui.ImageView:create("public/new/text_bg.png", var_0_5)

	var_6_1:setScale9Enabled(true)
	var_6_1:setCapInsets(cc.rect(6, 6, 2, 2))
	var_6_1:setContentSize(cc.size(500, 750))
	var_6_1:setPosition(cc.p(var_6_0:getContentSize().width / 2, var_6_0:getContentSize().height / 2 + 35))
	var_6_0:addChild(var_6_1)

	self.roleList = ccui.ScrollView:create()

	self.roleList:setDirection(ccui.ScrollViewDir.vertical)
	self.roleList:setContentSize(cc.size(500, 750))
	self.roleList:setPosition(cc.p(var_6_0:getContentSize().width / 2 - 247, var_6_0:getContentSize().height / 2 - 340))
	self.roleList:setInnerContainerSize(cc.size(500, 750))
	var_6_0:addChild(self.roleList, 2)
end

function ChooseRoleLayer:initRoles()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(playermodel.haveSuit) do
		if iter_7_1 and iter_7_0 ~= self.selectedRole and not array_manager:isSoulInHangup(iter_7_0) then
			table.insert(var_7_0, {
				id = iter_7_0,
				activity = playermodel.activity[iter_7_0]
			})
		end
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		if arg_8_0.activity == arg_8_1.activity then
			return arg_8_0.id < arg_8_1.id
		else
			return arg_8_0.activity > arg_8_1.activity
		end
	end)

	if self.selectedRole ~= nil then
		table.insert(var_7_0, 1, {
			id = self.selectedRole,
			activity = playermodel.activity[self.selectedRole]
		})
	end

	local var_7_1 = #var_7_0
	local var_7_2 = var_0_11 * (#var_7_0 - 1) + var_0_13

	var_7_2 = var_0_11 * (#var_7_0 - 1) + var_0_13 < var_0_9 and var_0_9 or var_7_2

	self.roleList:setInnerContainerSize(cc.size(var_0_8, var_7_2))

	for iter_7_2 = 1, var_7_1 do
		local var_7_3 = RoleHeadSp:create(var_7_0[iter_7_2].id, self.consumeRecommend)

		var_7_3:setPosition(cc.p(var_0_12 + var_0_10 * ((iter_7_2 - 1) % 3), var_7_2 - var_0_13 - var_0_11 * (math.ceil(iter_7_2 / 3) - 1)))
		self.roleList:addChild(var_7_3)

		if var_7_3.id == self.selectedRole then
			var_7_3:loadTextures(var_0_6[2], var_0_6[2], var_0_6[2], var_0_5)
		end

		var_7_3:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.selectedRole == arg_9_0.id then
				return
			end

			if array_manager:isSoulInHangup(arg_9_0.id) then
				global_ShowBlockWords(major_factor_data[arg_9_0.id].name .. L_ROLE_HANGUPING, RISE_WORDS_FAIL)

				return
			end

			if self.selectedRole then
				self.roleList:getChildByName("role_" .. self.selectedRole):loadTextures(var_0_6[1], var_0_6[2], var_0_6[1], var_0_5)
			end

			self.selectedRole = arg_9_0.id

			arg_9_0:loadTextures(var_0_6[2], var_0_6[2], var_0_6[2], var_0_5)
		end)
	end
end

function ChooseRoleLayer:initButtonSure()
	local var_10_0 = ccui.Button:create(SINGLE_YELLOW_BUTTON, nil, SINGLE_YELLOW_BUTTON, var_0_5)

	var_10_0:setPosition(cc.p(320, 165))
	self:addChild(var_10_0, 5)

	local var_10_1 = cc.Label:createWithTTF(L_BUTTON_TEXT.Sure, "fonts/W5.ttf", 25)

	var_10_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_10_1:setPosition(cc.p(var_10_0:getContentSize().width / 2, var_10_0:getContentSize().height / 2))
	var_10_0:addChild(var_10_1)
	var_10_0:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.callback then
			self.callback(self.selectedRole)
		end

		self:runAction(cc.RemoveSelf:create())
	end)
end

function RoleHeadSp:create(arg_12_1, arg_12_2)
	local var_12_0 = RoleHeadSp.new()

	var_12_0:init(arg_12_1, arg_12_2)

	return var_12_0
end

function RoleHeadSp:init(arg_13_1, arg_13_2)
	local var_13_0 = ccui.ImageView:create(ROLE_RECT_HEAD_IMAGE_PATH .. model_data[item_data[playermodel.items[playermodel.weaponId[arg_13_1]].itemid].modelid].head_image .. ".png")

	var_13_0:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
	var_13_0:setScale(0.8)
	self:addChild(var_13_0, -2)

	local var_13_1 = cc.Label:createWithTTF("", "fonts/new1.ttf", 18)

	var_13_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_13_1:setPosition(cc.p(self:getContentSize().width / 2, -15))
	var_13_1:setString(L_PHYSICAL_POWER .. playermodel.activity[arg_13_1])
	self:addChild(var_13_1)

	local var_13_2 = ccui.ImageView:create("explore/explore_level3_bg8b.png", var_0_5)

	var_13_2:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2 + 5))
	self:addChild(var_13_2, -1)

	if arg_13_2 > playermodel.activity[arg_13_1] then
		self:setOpacity(114.75)
	end

	self.id = arg_13_1

	self:setName("role_" .. arg_13_1)
end
