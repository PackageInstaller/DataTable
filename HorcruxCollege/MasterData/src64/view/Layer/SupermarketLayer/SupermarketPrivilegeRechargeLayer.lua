local SupermarketPrivilegeRechargeLayer = class("SupermarketPrivilegeRechargeLayer", (require("view.Layer.BaseUILayer")))
local RichTextPro = require("view.Sprite.RichTextPro")
local RichLabel = require("view.Sprite.RichLabel")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5 = "SupermarketPrivilegeRechargeLayer/"
local var_0_6 = "当前特权订阅有效期至:"
local var_0_7 = cc.size(GameDisplay.width, 75)

function SupermarketPrivilegeRechargeLayer:ctor()
	SupermarketPrivilegeRechargeLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.supermarket_privilege_recharge_manager"):getInstance()
end

function SupermarketPrivilegeRechargeLayer:create(arg_2_1)
	local var_2_0 = SupermarketPrivilegeRechargeLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function SupermarketPrivilegeRechargeLayer:onEnter()
	SupermarketPrivilegeRechargeLayer.super.onEnter(self)
	self.manager:requestInfo()
end

function SupermarketPrivilegeRechargeLayer:onExit()
	SupermarketPrivilegeRechargeLayer.super.onExit(self)
	textureManager:removeLayerTextures({
		"SupermarketPrivilegeRechargeLayer"
	})
end

function SupermarketPrivilegeRechargeLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function SupermarketPrivilegeRechargeLayer:initLayer()
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

	self:initListView()
	self:initBuyLayout()
end

function SupermarketPrivilegeRechargeLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self._yearBtn:_addEvent(function()
		self.manager:requestBuy(nil, self.manager.BUY_TYPE.YEAR)
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_10_0)
		require("controller.supermarket_privilege_recharge_manager"):getInstance():buySuccess(arg_10_0)
	end), self)
end

function SupermarketPrivilegeRechargeLayer:initListView()
	self.listView:removeAllItems()

	for iter_11_0 = 1, #self.manager:getConfig() do
		self.listView:pushBackCustomItem((self:createInfoLayout(iter_11_0)))
	end
end

function SupermarketPrivilegeRechargeLayer:createInfoLayout(arg_12_1)
	local var_12_0 = self.manager:getConfig()
	local var_12_1 = TempWidget:CreateTempLayout()

	var_12_1:setContentSize(var_0_7)

	local var_12_2 = TempWidget:CreateTempImg(var_0_5 .. "info_bg.png", var_12_1)

	var_12_2:center()
	TempWidget:CreateTempImg(var_0_5 .. "num_" .. arg_12_1 .. ".png", var_12_2):align(cc.p(0, 0.5), 2, var_12_2:size().h / 2)

	local var_12_3 = RichTextPro:create()

	var_12_3:setMaxWidth(460)
	var_12_3:setSize(27)
	var_12_3:setLineSpace(1)
	var_12_3:setText(string.format(var_12_0[arg_12_1].des or "", var_12_0[arg_12_1].value or 0))
	var_12_3:setPosition(cc.p(120, var_12_2:size().h / 2 + cc.size(var_12_3:getContentSize()).height / 2))
	var_12_2:addChild(var_12_3)

	return var_12_1
end

function SupermarketPrivilegeRechargeLayer:initBuyLayout()
	local var_13_0 = TempWidget:CreateTempLayout(self._root)

	var_13_0:setContentSize(cc.size(self._root:size().w, 150))
	var_13_0:align(cc.p(0.5, 0), self._root:size().w / 2, 200)

	self._buyLayout = var_13_0

	local var_13_1 = TempWidget:CreateTempListView(var_13_0)

	var_13_1:setDirection(ccui.ListViewDirection.horizontal)

	local var_13_2 = TempWidget:CreateTempBtn(var_0_5 .. "year_btn.png")

	self._yearBtn = var_13_2

	var_13_1:setContentSize(cc.size(var_13_2:size().w, var_13_0:size().h))
	var_13_1:align(cc.p(0.5, 0), var_13_0:size().w / 2, 0)
	var_13_1:pushBackCustomItem(var_13_2)
	TempWidget:CreateTempImg(var_0_5 .. "year_tips.png", var_13_2:getVirtualRenderer()):align(cc.p(0.5, 1), var_13_2:size().w / 2, var_13_2:size().h - 15)
	var_13_1:setItemsMargin((var_13_1:size().w - var_13_2:size().w * 3) / 2)
end

function SupermarketPrivilegeRechargeLayer:updateLayer()
	self:updatEexpirationDateText()
	self:updateBuyLayout()
end

function SupermarketPrivilegeRechargeLayer:updateRed()
	return
end

function SupermarketPrivilegeRechargeLayer:updateBySupermarketLayer(...)
	return
end

function SupermarketPrivilegeRechargeLayer:updatEexpirationDateText()
	self.expirationDateText:setString(var_0_6 .. self.manager:getExpirationDateString())
end

function SupermarketPrivilegeRechargeLayer:buySuccess()
	self:updatEexpirationDateText()
end

function SupermarketPrivilegeRechargeLayer:updateBuyLayout()
	local var_19_0 = self._yearBtn:getVirtualRenderer():getChildByName("text")
	local var_19_1 = self.manager:getTextInfoByType(self.manager.BUY_TYPE.YEAR)

	if not var_19_0 then
		var_19_0 = TempWidget:CreateTempLabel(var_19_1.str, var_19_1.font, var_19_1.size, self._yearBtn:getVirtualRenderer())

		var_19_0:align(cc.p(0.5, 0), self._yearBtn:size().w / 2, 10)
		var_19_0:setName("text")
	end

	var_19_0:setString(var_19_1.str)
	var_19_0:_setColor(var_19_1.color)
end

return SupermarketPrivilegeRechargeLayer
