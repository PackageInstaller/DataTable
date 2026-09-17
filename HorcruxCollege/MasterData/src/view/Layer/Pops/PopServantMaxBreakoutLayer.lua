PopServantMaxBreakoutLayer = class("PopServantMaxBreakoutLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local core_manager = require("controller.core_manager")
local item_data = require("data.item_data")
local lab_workshop_data = require("data.lab_workshop_data")
local servant_data = require("data.servant_data")
local total_skill_data = require("data.total_skill_data")
local var_0_9 = require("data.total_skill_data")
local model_data = require("data.model_data")

require("view.Sprite.ItemSprite")

local var_0_11 = "effect/particle/purchaseResultLayer/particle_triangle_static.plist"

function PopServantMaxBreakoutLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopServantMaxBreakoutLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopServantMaxBreakoutLayer:initBg(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_3_0:setOpacity(0)
	self:addChild(var_3_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_4_0)
		self:addChild(arg_4_0, -2)
		arg_4_0:setPositionY(arg_4_0:getPositionY() - GameDisplay.fix_y)

		local var_4_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_4_0:setAnchorPoint(cc.p(0, 0))
		var_4_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_4_0, -1)
		self:init(arg_3_1)
		var_3_0:setOpacity(102)
		var_3_0:setTouchEnabled(false)
	end)
end

function PopServantMaxBreakoutLayer:init(arg_5_1)
	self.servantid = arg_5_1.servantid
	self.modelid = global_get_servant_skin(self.servantid)
	self.exSkill = model_data[self.modelid].ex_3

	self:initUI()
	self:updateUI()
end

function PopServantMaxBreakoutLayer:initUI()
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.rootLayer:setAnchorPoint(cc.p(0, 0))
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)
	self.rootLayer:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)

	local var_6_0 = cc.ParticleSystemQuad:create(var_0_11)

	var_6_0:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2 - 100))
	self.rootLayer:addChild(var_6_0)

	local var_6_1 = cc.ParticleSystemQuad:create(var_0_11)

	var_6_1:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2 + 100))
	self.rootLayer:addChild(var_6_1)

	self.cuteImage = ccui.ImageView:create("GUI/image.png", var_0_0)

	self.cuteImage:setAnchorPoint(cc.p(0.5, 0))
	self.cuteImage:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2 - 50))
	self.rootLayer:addChild(self.cuteImage)

	self.nameBg = ccui.ImageView:create("PopServantMaxBreakoutLayer/name_bg.png", var_0_0)

	self.nameBg:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2 - 70))
	self.rootLayer:addChild(self.nameBg)

	self.nameLabel = cc.Label:createWithTTF("", FONT_NAME, 22)

	self.nameLabel:setPosition(cc.p(self.nameBg:getPositionX(), self.nameBg:getPositionY()))
	self.rootLayer:addChild(self.nameLabel)

	self.maxLevelImg = ccui.ImageView:create("PopServantMaxBreakoutLayer/max_level.png", var_0_0)

	self.maxLevelImg:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2 - 130))
	self.rootLayer:addChild(self.maxLevelImg)

	self.skillImg = ccui.ImageView:create("PopServantMaxBreakoutLayer/skill_bg.png", var_0_0)

	self.skillImg:setPosition(cc.p(520, self.rootLayer:getContentSize().height / 2 - 50))
	self.skillImg:setTouchEnabled(true)
	self.rootLayer:addChild(self.skillImg)
	self.skillImg:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showSkillInfo()
	end)

	self.skillLabel = cc.Label:createWithTTF("技能", FONT_NAME, 20)

	self.skillLabel:setPosition(cc.p(440, self.skillImg:getPositionY() - 28))
	self.rootLayer:addChild(self.skillLabel)

	self.skillName = cc.Label:createWithTTF("", FONT_NAME, 20)

	self.skillName:setAnchorPoint(cc.p(0, 0.5))
	self.skillName:setPositionX(self.skillLabel:getPositionX() + self.skillLabel:getContentSize().width / 2)
	self.skillName:setPositionY(self.skillLabel:getPositionY())
	self.skillName:setColor(cc.c3b(220, 251, 241))
	self.rootLayer:addChild(self.skillName)
end

function PopServantMaxBreakoutLayer:updateUI()
	self.cuteImage:loadTexture("roleimage/role1/" .. model_data[self.modelid].cute_role .. ".png")
	self.nameLabel:setString(servant_data[self.servantid].name)
	self.skillLabel:setString("技能")
	self.skillName:setString("【" .. total_skill_data[self.exSkill].name .. "】" .. "MAX")
end

function PopServantMaxBreakoutLayer:showSkillInfo()
	local var_10_0 = ccui.Layout:create()

	var_10_0:setTouchEnabled(true)
	var_10_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_10_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_10_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_10_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_10_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_10_0:setBackGroundColorOpacity(120)
	var_10_0:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_10_0:runAction(cc.RemoveSelf:create())
	end)
	;(function()
		local var_12_0 = ccui.ImageView:create("EquipLayer/skill_des_bg.png", var_0_0)

		var_12_0:setPosition(cc.p(320, 672))
		var_12_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_10_0:addChild(var_12_0)

		local var_12_1 = ccui.Layout:create()

		var_12_1:setContentSize(cc.size(500, 124))
		var_12_1:setAnchorPoint(cc.p(0, 0))
		var_12_1:setPosition(cc.p(70, 600))
		var_12_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_12_1:setBackGroundColor(cc.c3b(0, 0, 0))
		var_12_1:setBackGroundColorOpacity(0)
		var_10_0:addChild(var_12_1, 2)

		local var_12_2 = ccui.ImageView:create("EquipLayer/normal_skill_frame.png", var_0_0)

		var_12_2:setPosition(cc.p(58, 63))
		var_12_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_12_1:addChild(var_12_2)

		local var_12_3 = ccui.ImageView:create("skill_new/skill/ex3.png", var_0_0)

		var_12_3:setScale(0.88)
		var_12_3:setPosition(cc.p(58, 63))
		var_12_1:addChild(var_12_3)

		local var_12_4 = cc.Label:createWithTTF(var_0_9[self.exSkill].name, FONT_DES, 24)

		var_12_4:setAnchorPoint(cc.p(0, 0.5))
		var_12_4:setPosition(cc.p(121, 96))
		var_12_1:addChild(var_12_4)

		if var_0_9[self.exSkill].cd then
			local var_12_5 = cc.Label:createWithTTF("冷却时间: " .. var_0_9[self.exSkill].cd .. "s", FONT_DES, 20)

			var_12_5:setAnchorPoint(cc.p(1, 0.5))
			var_12_5:setPosition(cc.p(473, 96))
			var_12_1:addChild(var_12_5)
		end

		local var_12_6 = transSkillDesToRichText(var_0_9[self.exSkill].description)
		local var_12_7 = RichTextPro:create()

		var_12_7:setMaxWidth(380)
		var_12_7:setSize(20)
		var_12_7:setColor(cc.c3b(220, 251, 241))
		var_12_7:setLineSpace(0)
		var_12_7:setText(var_12_6)
		var_12_7:setName("richText")
		var_12_7:setPosition(cc.p(120, 86))
		var_12_1:addChild(var_12_7)
	end)()
	self.rootLayer:addChild(var_10_0)
end

function PopServantMaxBreakoutLayer:exit()
	LayerManager:removePopLayer(self.__queueindex)
end
