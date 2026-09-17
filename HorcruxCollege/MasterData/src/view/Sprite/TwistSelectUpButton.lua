local var_0_0 = config._DEBUG and 0 or 1
local TwistSelectUpButton = class("TwistSelectUpButton", function(arg_1_0)
	return ccui.Button:create(arg_1_0, arg_1_0, arg_1_0, var_0_0)
end)
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local var_0_5 = {
	"TwistEgg/selectup_bg.png",
	"TwistEgg/selectup_bg_on.png"
}
local var_0_6 = {
	cc.size(640, 570),
	cc.size(306, 570),
	cc.size(200, 570),
	cc.size(150, 570)
}
local var_0_7 = {
	"public/rarity/r_short.png",
	"public/rarity/sr_short.png",
	"public/rarity/ur_short.png",
	"public/rarity/mr_short.png",
	"public/rarity/sp_short.png"
}
local var_0_8 = "TwistEgg/selectup_topbg.png"
local var_0_9 = {
	"TwistEgg/selectup_bottombg.png",
	"TwistEgg/selectup_bottombg_on.png"
}
local var_0_10 = {
	"TwistEgg/img_selectup.png",
	"TwistEgg/img_selectup_on.png"
}
local var_0_11 = "TwistEgg/selectup_namebg.png"

function TwistSelectUpButton:create()
	local var_2_0 = TwistSelectUpButton.new(var_0_5[1])

	var_2_0:init()

	return var_2_0
end

function TwistSelectUpButton:init()
	self:setSwallowTouches(false)
	self:setScale9Enabled(true)
	self:setCapInsets(cc.rect(70, 300, 10, 10))
	self:setContentSize(var_0_6[4])
	self:initModel()
	self:initComponents()
	self:initTouchEvent()
end

function TwistSelectUpButton:initModel()
	self._itemid = nil
	self._servantid = nil
	self._touchhandler = nil
	self._selected = false
end

function TwistSelectUpButton:initComponents()
	self:addRoleClippingPanel()
	self:addTopPanel()
	self:addBottomPanel()
	self:addRoleInfoButton()
	self:addRoleNamePanel()
end

function TwistSelectUpButton:initTouchEvent()
	self:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_7_0:getTouchBeganPosition().x - arg_7_0:getTouchEndPosition().x) >= 50 then
			return
		end

		if not self._itemid then
			return
		end

		if self._touchhandler then
			self._touchhandler(self._itemid)
		end
	end)
end

function TwistSelectUpButton:registerTouchEvent(arg_8_1)
	self._touchhandler = arg_8_1
end

function TwistSelectUpButton:update(arg_9_1, arg_9_2, arg_9_3)
	self._itemid = arg_9_1
	self._servantid = item_data[arg_9_1].servant
	self._selected = arg_9_3

	self:setContentSize(var_0_6[arg_9_2])

	if self._selected then
		self:loadTextures(var_0_5[2], var_0_5[2], var_0_5[2], var_0_0)
	else
		self:loadTextures(var_0_5[1], var_0_5[1], var_0_5[1], var_0_0)
	end

	self:updateRoleClippingPanel()
	self:updateTopPanel()
	self:updateBottomPanel()
	self:updateRoleInfoButton()
	self:updateRoleNamePanel()
end

function TwistSelectUpButton:addRoleClippingPanel()
	local var_10_0 = ccui.Layout:create()

	var_10_0:setClippingEnabled(true)
	var_10_0:setContentSize(self:getContentSize())
	var_10_0:setPosition(0, 0)
	self:addChild(var_10_0, 1)

	self.rolePanel = var_10_0

	local var_10_1 = ccui.ImageView:create()

	var_10_1:setName("role")
	var_10_1:setPosition(cc.p(var_10_0:getContentSize().width / 2, var_10_0:getContentSize().height / 2))
	self.rolePanel:addChild(var_10_1)
end

function TwistSelectUpButton:updateRoleClippingPanel()
	self.rolePanel:setContentSize(self:getContentSize())

	local var_11_0 = self.rolePanel:getChildByName("role")

	var_11_0:setPosition(cc.p(self.rolePanel:getContentSize().width / 2, self.rolePanel:getContentSize().height / 2))
	var_11_0:loadTexture("role/twist/" .. self._servantid .. ".png")
end

function TwistSelectUpButton:addTopPanel()
	local var_12_0 = ccui.ImageView:create(var_0_8, var_0_0)

	var_12_0:setScale9Enabled(true)
	var_12_0:setCapInsets(cc.rect(70, 90, 10, 5))
	var_12_0:setContentSize(cc.size(self:getContentSize().width, 100))
	var_12_0:setAnchorPoint(cc.p(0.5, 1))
	var_12_0:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height))
	self:addChild(var_12_0, 2)

	self.topPanel = var_12_0

	local var_12_1 = ccui.ImageView:create(var_0_7[4], var_0_0)

	var_12_1:setName("rarityIcon")
	var_12_1:setPosition(cc.p(25, var_12_0:getContentSize().height - 25))
	self.topPanel:addChild(var_12_1)
end

function TwistSelectUpButton:updateTopPanel()
	self.topPanel:setContentSize(cc.size(self:getContentSize().width, 100))
	self.topPanel:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height))
	self.topPanel:getChildByName("rarityIcon"):loadTexture(var_0_7[servant_data[self._servantid].roll_rarity], var_0_0)
end

function TwistSelectUpButton:addBottomPanel()
	local var_14_0 = ccui.ImageView:create(var_0_9[1], var_0_0)

	var_14_0:setScale9Enabled(true)
	var_14_0:setCapInsets(cc.rect(70, 20, 10, 5))
	var_14_0:setContentSize(cc.size(self:getContentSize().width, 341))
	var_14_0:setAnchorPoint(cc.p(0.5, 0))
	var_14_0:setPosition(cc.p(self:getContentSize().width / 2, 0))
	self:addChild(var_14_0, 2)

	self.bottomPanel = var_14_0

	local var_14_1 = ccui.ImageView:create(var_0_10[1], var_0_0)

	var_14_1:setName("imgselectup")
	var_14_1:setPosition(cc.p(var_14_0:getContentSize().width / 2, 50))
	self.bottomPanel:addChild(var_14_1)
end

function TwistSelectUpButton:updateBottomPanel()
	if self._selected then
		self.bottomPanel:loadTexture(var_0_9[2], var_0_0)
		self.bottomPanel:getChildByName("imgselectup"):loadTexture(var_0_10[2], var_0_0)
	else
		self.bottomPanel:loadTexture(var_0_9[1], var_0_0)
		self.bottomPanel:getChildByName("imgselectup"):loadTexture(var_0_10[1], var_0_0)
	end

	self.bottomPanel:setPosition(cc.p(self:getContentSize().width / 2, 0))
	self.bottomPanel:setContentSize(cc.size(self:getContentSize().width, 341))
	self.bottomPanel:getChildByName("imgselectup"):setPosition(cc.p(self.bottomPanel:getContentSize().width / 2, 50))
end

function TwistSelectUpButton:addRoleInfoButton()
	local var_16_0 = ccui.Button:create("TwistEgg/btn_roleinfo.png", "TwistEgg/btn_roleinfo.png", "TwistEgg/btn_roleinfo.png", var_0_0)

	var_16_0:setAnchorPoint(cc.p(1, 0))
	var_16_0:setPosition(cc.p(self:getContentSize().width, 120))
	var_16_0:setVisible(false)
	self:addChild(var_16_0, 3)

	self.btnRoleInfo = var_16_0

	var_16_0:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self._servantid then
			return
		end

		LayerManager:pushInLayer("SoulsLayer", {
			showtype = SHOW_TYPE_TWISTEGG_PREVIEW,
			cursoul = self._servantid
		})
	end)

	local var_16_1 = ccui.ImageView:create("TwistEgg/img_up.png", var_0_0)

	var_16_1:setAnchorPoint(cc.p(0, 0))
	var_16_1:setPosition(cc.p(0, 120))
	var_16_1:setVisible(false)
	self:addChild(var_16_1, 3)

	self.imgUp = var_16_1
end

function TwistSelectUpButton:updateRoleInfoButton()
	self.imgUp:setVisible(self._selected)
end

function TwistSelectUpButton:addRoleNamePanel()
	local var_19_0 = ccui.ImageView:create(var_0_11, var_0_0)

	var_19_0:setScale9Enabled(true)
	var_19_0:setCapInsets(cc.rect(70, 15, 5, 5))
	var_19_0:setContentSize(cc.size(self:getContentSize().width, 34))
	var_19_0:setPosition(cc.p(self:getContentSize().width / 2, 100))
	self:addChild(var_19_0, 3)

	self.namePanel = var_19_0

	local var_19_1 = cc.Label:createWithTTF("", FONT_NAME, 24)

	var_19_1:setName("name")
	var_19_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_19_1:setPosition(cc.p(var_19_0:getContentSize().width / 2, var_19_0:getContentSize().height / 2))
	var_19_0:addChild(var_19_1)
end

function TwistSelectUpButton:updateRoleNamePanel()
	self.namePanel:setContentSize(cc.size(self:getContentSize().width, 34))
	self.namePanel:setPosition(cc.p(self:getContentSize().width / 2, 100))
	self.namePanel:getChildByName("name"):setString(model_data[servant_data[self._servantid].modelid].name_Q)
	self.namePanel:getChildByName("name"):setPosition(cc.p(self.namePanel:getContentSize().width / 2, self.namePanel:getContentSize().height / 2))
end

return TwistSelectUpButton
