local SupermarketPrivilegeLayer = class("SupermarketPrivilegeLayer", (require("view.Layer.BaseUILayer")))
local RichTextPro = require("view.Sprite.RichTextPro")
local RichLabel = require("view.Sprite.RichLabel")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_4 = config._DEBUG and 0 or 1
local var_0_5 = "SupermarketPrivilegeLayer/"
local var_0_6 = "当前特权订阅有效期至:"
local var_0_7 = cc.size(GameDisplay.width, 75)

function SupermarketPrivilegeLayer:ctor()
	SupermarketPrivilegeLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.supermarket_privilege_manager"):getInstance()
end

function SupermarketPrivilegeLayer:create(arg_2_1)
	local var_2_0 = SupermarketPrivilegeLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function SupermarketPrivilegeLayer:onEnter()
	SupermarketPrivilegeLayer.super.onEnter(self)
	self.manager:requestInfo()
end

function SupermarketPrivilegeLayer:onExit()
	SupermarketPrivilegeLayer.super.onExit(self)
	textureManager:removeLayerTextures({
		"SupermarketPrivilegeLayer"
	})
end

function SupermarketPrivilegeLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function SupermarketPrivilegeLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg(var_0_5 .. "topBg.png", var_6_0)

	var_6_1:align(cc.p(0.5, 1), var_6_0:size().w / 2, var_6_0:size().h - 100)
	TempWidget:CreateTempImg(var_0_5 .. "time_bg.png", var_6_1):align(cc.p(0.5, 1), var_6_1:size().w / 2, var_6_1:size().h + 108)

	local var_6_2 = TempWidget:CreateTempLabel(var_0_6, FONT_NAME, 18, var_6_1)

	var_6_2:_setColor("00FFFF")
	var_6_2:align(cc.p(0, 0), 10, 17)

	self.expirationDateText = var_6_2

	local var_6_3 = TempWidget:CreateTempListView(var_6_0)

	var_6_3:setDirection(ccui.ListViewDirection.vertical)
	var_6_3:setContentSize(cc.size(var_6_0:size().w, var_6_0:size().h - 700))
	var_6_3:align(cc.p(0, 1), 0, var_6_1:pos().y - var_6_1:size().h - 10)

	self.listView = var_6_3

	local var_6_4 = TempWidget:CreateTempBtn(var_0_5 .. "monthly_subscription_btn_on.png", var_6_0)

	var_6_4:align(cc.p(0.5, 1), var_6_0:size().w / 2, var_6_3:pos().y - var_6_3:size().h - 10)

	self.monthlySubscriptionBtn = var_6_4

	local var_6_5 = TempWidget:CreateTempImg(var_0_5 .. "monthly_subscription_first_buy.png", var_6_4:getVirtualRenderer())

	var_6_5:hide()
	var_6_5:align(cc.p(0.5, 1), var_6_4:size().w / 2, var_6_4:size().h - 20)

	self.monthlySubscriptionFirstBuyImg = var_6_5

	local var_6_6 = TempWidget:CreateTempImg(var_0_5 .. "xieyi_tips.png", var_6_0)

	var_6_6:align(cc.p(0.5, 0.5), var_6_4:pos().x, var_6_4:pos().y - var_6_4:size().h - 15)

	self.xieyiTipsImg = var_6_6

	local var_6_7 = TempWidget:CreateTempImg(var_0_5 .. "xieyi_kuang.png", var_6_0)

	var_6_7:align(cc.p(1, 0.5), var_6_6:pos().x - var_6_6:size().w / 2 - 10, var_6_6:pos().y)

	self.xieyiKuang = var_6_7

	local var_6_8 = TempWidget:CreateTempImg(var_0_5 .. "xieyi_gou.png", var_6_7)

	var_6_8:center()

	self.xieyiGouImg = var_6_8

	self:updateXieyiGouImg()
	self:initListView()
end

function SupermarketPrivilegeLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self.monthlySubscriptionBtn:_addEvent(function()
		self.manager:requestBuyMonthlyCard()
	end)
	self.xieyiKuang:_addEvent(function()
		self.manager:setProtocolState(not self.manager:getProtocolState())
	end)
	self.xieyiTipsImg:_addEvent(function()
		require("controller.device_manager").openURL("https://h-college.com/protocol/subscribe.html")
	end)
end

function SupermarketPrivilegeLayer:initListView()
	self.listView:removeAllItems()

	for iter_12_0 = 1, #self.manager:getConfig() do
		self.listView:pushBackCustomItem((self:createInfoLayout(iter_12_0)))
	end
end

function SupermarketPrivilegeLayer:createInfoLayout(arg_13_1)
	local var_13_0 = self.manager:getConfig()
	local var_13_1 = TempWidget:CreateTempLayout()

	var_13_1:setContentSize(var_0_7)

	local var_13_2 = TempWidget:CreateTempImg(var_0_5 .. "info_bg.png", var_13_1)

	var_13_2:center()
	TempWidget:CreateTempImg(var_0_5 .. "num_" .. arg_13_1 .. ".png", var_13_2):align(cc.p(0, 0.5), 2, var_13_2:size().h / 2)

	local var_13_3 = RichTextPro:create()

	var_13_3:setMaxWidth(460)
	var_13_3:setSize(27)
	var_13_3:setLineSpace(1)
	var_13_3:setText(string.format(var_13_0[arg_13_1].des or "", var_13_0[arg_13_1].value or 0))
	var_13_3:setPosition(cc.p(120, var_13_2:size().h / 2 + cc.size(var_13_3:getContentSize()).height / 2))
	var_13_2:addChild(var_13_3)

	return var_13_1
end

function SupermarketPrivilegeLayer:updateLayer()
	self:updateMonthlySubscriptionBtn()
	self:updatEexpirationDateText()
end

function SupermarketPrivilegeLayer:updateRed()
	return
end

function SupermarketPrivilegeLayer:updateBySupermarketLayer(...)
	return
end

function SupermarketPrivilegeLayer:updateMonthlySubscriptionBtn()
	local var_17_0 = self.manager:getMonthlyBtnInfo()

	if not self.monthlySubscriptionTipsText then
		local var_17_1 = self.monthlySubscriptionBtn:getVirtualRenderer()
		local var_17_2 = TempWidget:CreateTempLabel(var_17_0.str, var_17_0.font, var_17_0.size, var_17_1)

		var_17_2:align(cc.p(0.5, 0), var_17_1:getContentSize().width / 2, 22)

		self.monthlySubscriptionTipsText = var_17_2
	end

	local var_17_3 = self.monthlySubscriptionTipsText

	self.monthlySubscriptionTipsText:_setColor(var_17_0.color)
	var_17_3:setString(var_17_0.str)
	self.monthlySubscriptionFirstBuyImg:setVisible(var_17_0.bShowFirstBuyImg)

	if self.manager:isDeductFail() then
		var_17_3:hide()
		self.monthlySubscriptionFirstBuyImg:hide()
	end

	self.monthlySubscriptionBtn:loadTextureNormal(var_17_0.btnTexturePath, var_0_4)
end

function SupermarketPrivilegeLayer:updatEexpirationDateText()
	self.expirationDateText:setString(var_0_6 .. self.manager:getExpirationDateString())
end

function SupermarketPrivilegeLayer:buySuccess()
	self:updatEexpirationDateText()
	self:updateMonthlySubscriptionBtn()
end

function SupermarketPrivilegeLayer:stateUpdate()
	self:updatEexpirationDateText()
	self:updateMonthlySubscriptionBtn()
end

function SupermarketPrivilegeLayer:updateXieyiGouImg()
	self.xieyiGouImg:setVisible(self.manager:getProtocolState())
end

return SupermarketPrivilegeLayer
