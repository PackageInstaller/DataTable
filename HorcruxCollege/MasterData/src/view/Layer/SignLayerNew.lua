SignLayerNew = class("SignLayerNew", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local var_0_1 = config._DEBUG and 0 or 1
local var_0_2 = "SignLayerNew/"
local l2utils = require("controller.l2utils")
local sign_manager = require("controller.sign_manager")
local time_check_manager = require("controller.time_check_manager")
local drop_manager = require("controller.drop_manager")
local ItemSprite = require("view.Sprite.ItemSprite")
local var_0_8 = require("controller.time_check_manager")
local component_manager = require("controller.component_manager")
local item_data = require("data.item_data")
local mail_data = require("data.mail_data")
local recharge_data = require("data.recharge_data")
local sign_accumulate_data = require("data.sign_accumulate_data")
local var_0_14 = 12000001
local var_0_15 = 12000003
local var_0_16 = 12000005
local var_0_17 = 88001
local var_0_18 = 88002
local var_0_19 = 88003
local var_0_20 = 20001
local var_0_21 = 20002
local var_0_22 = {
	nil,
	"public/box/new_item_bg2.png",
	"public/box/new_item_bg3.png",
	"public/box/new_item_bg4.png",
	"public/box/new_item_bg5.png",
	"public/box/new_item_bg6.png"
}
local var_0_23 = 5
local var_0_24 = 8
local var_0_25 = 8
local var_0_26 = 10
local var_0_27
local var_0_28 = 125
local var_0_29

function SignLayerNew:ctor()
	SignLayerNew.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.sign_new_manager"):getInstance()
	self.bInit = false
end

function SignLayerNew.create(arg_2_0, arg_2_1)
	local var_2_0 = SignLayerNew.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function SignLayerNew:updateTime()
	local var_3_0 = os.date("*t", (time_check_manager:getCurTime()))

	if var_3_0.min == 0 and var_3_0.hour == 0 and var_3_0.sec == 0 and self.month and self.month ~= var_3_0.month then
		self:updateMonth()
	end
end

function SignLayerNew:onEnter()
	SignLayerNew.super.onEnter(self)
	self:scheduleUpdateWithPriorityLua(handler(self, self.updateTime), 1)
	self:setPositionY(self:getPositionY() - GameDisplay.statusbar_height / 2)
end

function SignLayerNew:onExit()
	SignLayerNew.super.onExit(self)

	if self.data and self.data.callback then
		self.data.callback()
	end

	if self.iscansign then
		AlertManager:register_alert(ALERT_SIGN)
	else
		AlertManager:unregister_alert(ALERT_SIGN, true)
	end
end

function SignLayerNew:init(arg_6_1)
	self.data = arg_6_1

	self:initLayer()

	return true
end

function SignLayerNew:initLayer()
	local var_7_0 = TempWidget:CreateTempLayout(self)

	var_7_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_7_0

	var_7_0:align(cc.p(0.5, 0.5), self:getContentSize().width / 2, self:getContentSize().height / 2)
	l2utils:captureScreenGaussBlur(function(arg_8_0)
		self.manager:captureScreenGaussBlurComplete(arg_8_0)
	end)
end

function SignLayerNew:captureScreenGaussBlurComplete(arg_9_1)
	self._root:setScaleY(0)
	self._root:runAction(cc.ScaleTo:create(0.15, 1, 1))
	self._root:addChild(arg_9_1)
	sign_manager:getSignAccuTimeFromServe(function(arg_10_0)
		self.signVersion = arg_10_0.version

		self.manager:getSignAccuTimeFromServeComplete(arg_10_0)
	end)
end

function SignLayerNew:getSignAccuTimeFromServeComplete(arg_11_1)
	self.bInit = true

	local var_11_0 = sign_manager:getTime(time_check_manager:getCurTime())

	self.month = var_11_0.month
	self.monthNum = var_11_0.dayNum
	self.date = var_11_0.day
	self.signNum = arg_11_1.signaccumulate
	self.signTotal = arg_11_1.signtotal
	self.iscansign = arg_11_1.iscansign
	self.signaccuaward = arg_11_1.signaccuaward
	self.itemList = sign_manager:getSignItemDataNew(self.month, self.monthNum)

	self:setSignData()

	local var_11_1 = TempWidget:CreateTempImg(var_0_2 .. "bg.png", self._root)

	var_11_1:align(cc.p(0.5, 0), self._root:size().w / 2, 120)
	var_11_1:_addEvent(function()
		return
	end)

	local var_11_2 = TempWidget:CreateTempLayout(self._root)

	var_11_2:setContentSize(self._root:size())

	local var_11_3 = TempWidget:CreateTempImg(var_0_2 .. "stand.png", var_11_2)

	var_11_3:align(cc.p(1, 0.5), self._root:size().w, self._root:size().h / 2)

	self.standImg = var_11_3

	self:updateStandImg()

	local var_11_4 = TempWidget:CreateTempBtn(var_0_2 .. "sign_btn.png", self._root)

	var_11_4:align(cc.p(0.5, 0), 160, 40)

	self.signBtn = var_11_4

	local var_11_5 = TempWidget:CreateTempBtn(var_0_2 .. "timely_btn.png", self._root)

	var_11_5:align(cc.p(0.5, 0), 460, 40)

	self.timelyBtn = var_11_5

	TempWidget:CreateTempImg(var_0_2 .. "tips.png", self._root):align(cc.p(0.5, 0), 460, 100)

	local var_11_6 = TempWidget:CreateTempImg(var_0_2 .. "main_bg.png", self._root)

	var_11_6:align(cc.p(0.5, 1), self._root:size().w / 2 - 3, var_11_1:pos().y + var_11_1:size().h - 75)
	var_11_3:align(cc.p(1, 0.5), self._root:size().w, var_11_6:pos().y - var_11_6:size().h / 2 + 100)
	TempWidget:CreateTempImg(var_0_2 .. "title.png", self._root):align(cc.p(0, 1), 0, var_11_3:size().h / 2 + var_11_3:pos().y - 100)

	local var_11_7 = string.format("%.2d", self.month)
	local var_11_8 = TempWidget:CreateTempImg(var_0_2 .. string.sub(var_11_7, 1, 1) .. ".png", var_11_6)

	var_11_8:align(cc.p(0, 1), 8, var_11_6:size().h - 10)

	self.oneNumImg = var_11_8

	local var_11_9 = TempWidget:CreateTempImg(var_0_2 .. string.sub(var_11_7, 2, 2) .. ".png", var_11_6)

	var_11_9:align(cc.p(0, 1), var_11_8:pos().x + var_11_8:size().w - 13, var_11_8:pos().y)

	self.twoNumImg = var_11_9

	local var_11_10 = TempWidget:CreateTempImg(var_0_2 .. "extra_reward_bg.png", var_11_6)

	var_11_10:align(cc.p(1, 0), var_11_6:size().w, -10)

	self.extraRewardBg = var_11_10

	self:initExtraRewardBg()

	local var_11_11 = TempWidget:CreateTempListView(var_11_6)

	var_11_11:setContentSize(cc.size(510, 565))
	var_11_11:move(10, 9)

	self.listView = var_11_11

	self:initListView()
	self:updateListView()

	local var_11_12 = TempWidget:CreateTempImg(var_0_2 .. "bottom_bg.png", self._root)

	var_11_12:align(cc.p(0.5, 0), self._root:size().w / 2, var_11_1:pos().y + 5)

	self.bottomBg = var_11_12

	if var_0_8:getCurTime() < os.time({
		hour = 0,
		month = 10,
		year = 2022,
		min = 0,
		sec = 0,
		day = 1
	}) then
		self:initBottomBg()
	else
		self.bottomBg:hide()
	end

	self:initListener()
end

function SignLayerNew:initBottomBg()
	if var_0_8:getCurTime() > os.time({
		hour = 0,
		month = 10,
		year = 2022,
		min = 0,
		sec = 0,
		day = 1
	}) then
		return
	end

	local var_13_0 = self.bottomBg
	local var_13_1 = TempWidget:CreateTempLabel("00", FONT_NAME, 37, self.bottomBg)

	var_13_1:align(cc.p(0, 0), 20, 10)

	self.signDayText = var_13_1

	local var_13_2 = TempWidget:CreateTempLabel("/" .. self.monthNum, FONT_NAME, 17, var_13_0)

	var_13_2:_setColor("4b98b5")
	var_13_2:align(cc.p(1, 0), 110, 15)
	TempWidget:CreateTempImg(var_0_2 .. "loading_bg.png", var_13_0):align(cc.p(0, 0), 135, var_13_0:size().h / 2)

	local var_13_3 = ccui.LoadingBar:create()

	var_13_3:loadTexture(var_0_2 .. "loading.png", var_0_1)
	var_13_3:setPercent(0)

	self.loadingBar = var_13_3

	var_13_0:addChild(var_13_3)
	var_13_3:setAnchorPoint(cc.p(0, 0))
	var_13_3:setPosition(cc.p(135, var_13_0:size().h / 2))

	local var_13_4 = sign_manager:getsignAccuItemData(self.month)

	self.accumulativeBtnTable = {}

	for iter_13_0 = 1, #var_13_4 do
		local var_13_5 = TempWidget:CreateTempLayout(var_13_0)
		local var_13_6 = TempWidget:CreateTempBtn(var_13_4[iter_13_0].image, var_13_5, 0)

		var_13_5:setContentSize(var_13_6:size().w * 0.35, var_13_6:size().h * 0.35)
		var_13_5:align(cc.p(0.5, 0.5), 200 + (iter_13_0 - 1) * 120, var_13_0:size().h / 2 + 5)
		var_13_6:align(cc.p(0.5, 0.5), var_13_5:size().w / 2, var_13_5:size().h / 2)
		var_13_6:setScale(0.35)

		self.accumulativeBtnTable[iter_13_0] = var_13_6
		var_13_6._childData = {}

		local var_13_7 = TempWidget:CreateTempImg(var_0_2 .. "can_get_reward.png", var_13_5)

		var_13_7:setLocalZOrder(var_13_6:getLocalZOrder() - 1)
		var_13_7:move(var_13_5:size().w / 2, var_13_5:size().h / 2 + 10)
		var_13_7:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 100), cc.FadeTo:create(1, 255))))
		var_13_7:hide()

		var_13_6._childData.canGetImg = var_13_7

		local var_13_8 = TempWidget:CreateTempImg(var_0_2 .. "have_get_reward.png", var_13_5)

		var_13_8:setLocalZOrder(var_13_6:getLocalZOrder() + 1)
		var_13_8:move(var_13_5:size().w / 2, var_13_5:size().h / 2 - 10)
		var_13_8:hide()

		var_13_6._childData.haveGetImg = var_13_8

		TempWidget:CreateTempLabel(var_13_4[iter_13_0].daycount .. "日", FONT_DES, 16, var_13_0):align(cc.p(0.5, 0), 200 + (iter_13_0 - 1) * 120, 5)
	end

	self:updateBottomBg()
end

function SignLayerNew:initExtraRewardBg()
	local var_14_0 = 1

	if global_is_in_time("2024-12-13 00:00:00", "2025-03-03 00:00:00") then
		var_14_0 = 2
	end

	local var_14_1 = TempWidget:CreateTempLayout(self.extraRewardBg)

	var_14_1:setContentSize(cc.size(110, 135))
	var_14_1:align(cc.p(0.5, 1), self.extraRewardBg:size().w / 2, self.extraRewardBg:size().h - 50)

	self.monthCardLayout = var_14_1
	self.monthCardLayout._childData = {}

	local var_14_2 = TempWidget:CreateTempImg(var_0_2 .. "month_title.png", var_14_1)

	var_14_2:align(cc.p(0.5, 1), var_14_1:size().w / 2, var_14_1:size().h)

	local var_14_3 = TempWidget:CreateTempImg(var_0_2 .. "preview_layout.png", var_14_1)

	var_14_3:align(cc.p(0.5, 1), var_14_1:size().w / 2, var_14_2:pos().y - var_14_2:size().h + 10)

	self.monthCardLayout._childData.cardBox = var_14_3

	local var_14_4 = drop_manager:getAllDrops(mail_data[var_0_14].dropid)
	local var_14_5 = drop_manager:getNormalDrops(mail_data[var_0_14].dropid)

	if var_14_5.diamond and var_14_5.diamond > 0 then
		local var_14_6 = TempWidget:CreateTempImg("equipment/1000000.png", var_14_3, 0)

		var_14_6:setScale(0.5)
		var_14_6:center()

		local var_14_7 = TempWidget:CreateTempImg(var_0_2 .. "preview_box.png", var_14_3)

		var_14_7:align(cc.p(1, 0), var_14_3:size().w - 20, 20)
		TempWidget:CreateTempLabel(var_14_5.diamond * var_14_0, FONT_NAME, 17, var_14_7):align(cc.p(1, 0.5), var_14_7:size().w - 5, var_14_7:size().h / 2)
	end

	local var_14_8 = TempWidget:CreateTempImg(var_0_2 .. "have_bought.png", var_14_3)

	var_14_8:hide()
	var_14_8:center()

	self.monthCardLayout._childData.haveBoughtImg = var_14_8

	local var_14_9 = TempWidget:CreateTempImg(var_0_2 .. "renew_bg.png", var_14_1)

	var_14_9:align(cc.p(0.5, 0), var_14_1:size().w / 2, 5)

	self.monthCardLayout._childData.remainBg = var_14_9

	local var_14_10 = TempWidget:CreateTempLabel(string.format(L_SIGNLAYER_LESS, 0), FONT_NAME, 17, var_14_9)

	var_14_10:setVisible(0 <= 9)
	var_14_10:center()

	self.monthCardLayout._childData.remainText = var_14_10

	local var_14_11 = L2Skeleton:create(UI_SPINE_PATH .. "sign/skeleton.json", UI_SPINE_PATH .. "sign/skeleton.atlas")

	var_14_11:refreshSkeleton()
	var_14_11:setName("monthCardSpine")
	var_14_11:play("animation", true)
	var_14_11:setVisible(false)
	var_14_11.skeletonAnimation:setPositionX(54)
	var_14_11.skeletonAnimation:setPositionY(54)
	var_14_3:addChild(var_14_11)

	self.monthCardLayout._childData.monthCardSpine = var_14_11

	local var_14_12 = TempWidget:CreateTempLayout(self.extraRewardBg)

	var_14_12:setContentSize(var_14_1:size())
	var_14_12:align(cc.p(0.5, 1), self.extraRewardBg:size().w / 2, var_14_1:pos().y - var_14_1:size().h - 10)

	self.seasonCardLayout = var_14_12
	self.seasonCardLayout._childData = {}

	local var_14_13 = TempWidget:CreateTempImg(var_0_2 .. "season_title.png", var_14_12)

	var_14_13:align(cc.p(0.5, 1), var_14_12:size().w / 2, var_14_12:size().h)

	local var_14_14 = TempWidget:CreateTempImg(var_0_2 .. "preview_layout.png", var_14_12)

	var_14_14:align(cc.p(0.5, 1), var_14_12:size().w / 2, var_14_13:pos().y - var_14_13:size().h + 10)

	self.seasonCardLayout._childData.cardBox = var_14_14

	local var_14_15 = drop_manager:getAllDrops(mail_data[var_0_15].dropid)
	local var_14_16 = drop_manager:getNormalDrops(mail_data[var_0_15].dropid)

	if var_14_16.diamond and var_14_16.diamond > 0 then
		local var_14_17 = TempWidget:CreateTempImg("equipment/1000000.png", var_14_14, 0)

		var_14_17:setScale(0.5)
		var_14_17:center()

		local var_14_18 = TempWidget:CreateTempImg(var_0_2 .. "preview_box.png", var_14_14)

		var_14_18:align(cc.p(1, 0), var_14_14:size().w - 20, 20)
		TempWidget:CreateTempLabel(var_14_16.diamond * var_14_0, FONT_NAME, 17, var_14_18):align(cc.p(1, 0.5), var_14_18:size().w - 5, var_14_18:size().h / 2)
	end

	local var_14_19 = TempWidget:CreateTempImg(var_0_2 .. "have_bought.png", var_14_14)

	var_14_19:hide()
	var_14_19:center()

	self.seasonCardLayout._childData.haveBoughtImg = var_14_19

	local var_14_20 = TempWidget:CreateTempImg(var_0_2 .. "renew_bg.png", var_14_12)

	var_14_20:align(cc.p(0.5, 0), var_14_12:size().w / 2, 5)

	self.seasonCardLayout._childData.remainBg = var_14_20

	local var_14_21 = TempWidget:CreateTempLabel(string.format(L_SIGNLAYER_LESS, 8), FONT_NAME, 17, var_14_20)

	var_14_21:setVisible(8 <= 9)
	var_14_21:center()

	self.seasonCardLayout._childData.remainText = var_14_21

	local var_14_22 = L2Skeleton:create(UI_SPINE_PATH .. "sign/skeleton.json", UI_SPINE_PATH .. "sign/skeleton.atlas")

	var_14_22:refreshSkeleton()
	var_14_22.skeletonAnimation:setPositionX(54)
	var_14_22.skeletonAnimation:setPositionY(54)
	var_14_22:setName("seasonCardSpine")
	var_14_22:play("animation", true)
	var_14_22:setVisible(false)
	var_14_14:addChild(var_14_22)

	self.seasonCardLayout._childData.seasonCardSpine = var_14_22

	local var_14_23 = TempWidget:CreateTempLayout(self.extraRewardBg)

	var_14_23:setContentSize(var_14_1:size())
	var_14_23:align(cc.p(0.5, 1), self.extraRewardBg:size().w / 2, var_14_12:pos().y - var_14_12:size().h - 10)

	self.yearCardLayout = var_14_23
	self.yearCardLayout._childData = {}

	local var_14_24 = TempWidget:CreateTempImg(var_0_2 .. "year_title.png", var_14_23)

	var_14_24:align(cc.p(0.5, 1), var_14_23:size().w / 2, var_14_23:size().h)

	local var_14_25 = TempWidget:CreateTempImg(var_0_2 .. "preview_layout.png", var_14_23)

	var_14_25:align(cc.p(0.5, 1), var_14_23:size().w / 2, var_14_24:pos().y - var_14_24:size().h + 10)

	self.yearCardLayout._childData.cardBox = var_14_25

	local var_14_26 = drop_manager:getAllDrops(mail_data[var_0_16].dropid)
	local var_14_27 = drop_manager:getNormalDrops(mail_data[var_0_16].dropid)

	if var_14_27.diamond and var_14_27.diamond > 0 then
		local var_14_28 = TempWidget:CreateTempImg("equipment/1000000.png", var_14_25, 0)

		var_14_28:setScale(0.5)
		var_14_28:center()

		local var_14_29 = TempWidget:CreateTempImg(var_0_2 .. "preview_box.png", var_14_25)

		var_14_29:align(cc.p(1, 0), var_14_25:size().w - 20, 20)
		TempWidget:CreateTempLabel(var_14_27.diamond * var_14_0, FONT_NAME, 17, var_14_29):align(cc.p(1, 0.5), var_14_29:size().w - 5, var_14_29:size().h / 2)
	end

	local var_14_30 = TempWidget:CreateTempImg(var_0_2 .. "have_bought.png", var_14_25)

	var_14_30:hide()
	var_14_30:center()

	self.yearCardLayout._childData.haveBoughtImg = var_14_30

	local var_14_31 = TempWidget:CreateTempImg(var_0_2 .. "renew_bg.png", var_14_23)

	var_14_31:align(cc.p(0.5, 0), var_14_23:size().w / 2, 5)

	self.yearCardLayout._childData.remainBg = var_14_31

	local var_14_32 = TempWidget:CreateTempLabel(string.format(L_SIGNLAYER_LESS, 8), FONT_NAME, 17, var_14_31)

	var_14_32:setVisible(8 <= 9)
	var_14_32:center()

	self.yearCardLayout._childData.remainText = var_14_32

	local var_14_33 = L2Skeleton:create(UI_SPINE_PATH .. "sign/skeleton.json", UI_SPINE_PATH .. "sign/skeleton.atlas")

	var_14_33:refreshSkeleton()
	var_14_33.skeletonAnimation:setPositionX(54)
	var_14_33.skeletonAnimation:setPositionY(54)
	var_14_33:setName("yearCardSpine")
	var_14_33:play("animation", true)
	var_14_33:setVisible(false)
	var_14_25:addChild(var_14_33)

	self.yearCardLayout._childData.yearCardSpine = var_14_33

	local var_14_34 = TempWidget:CreateTempLayout(self.extraRewardBg)

	var_14_34:setContentSize(var_14_1:size())
	var_14_34:align(cc.p(0.5, 1), self.extraRewardBg:size().w / 2, var_14_23:pos().y - var_14_23:size().h - 10)

	self.timelyCardLayout = var_14_34
	self.timelyCardLayout._childData = {}

	local var_14_35 = TempWidget:CreateTempImg(var_0_2 .. "timely_title.png", var_14_34)

	var_14_35:align(cc.p(0.5, 1), var_14_34:size().w / 2, var_14_34:size().h)

	local var_14_36 = TempWidget:CreateTempImg(var_0_2 .. "preview_layout.png", var_14_34)

	var_14_36:align(cc.p(0.5, 1), var_14_34:size().w / 2, var_14_35:pos().y - var_14_35:size().h + 10)

	self.timelyCardLayout._childData.cardBox = var_14_36

	local var_14_37 = TempWidget:CreateTempImg(nil, var_14_36)

	var_14_37:setScale(0.5)
	var_14_37:center()

	self.timelyCardLayout._childData.icon = var_14_37

	local var_14_38 = TempWidget:CreateTempImg(var_0_2 .. "preview_box.png", var_14_36)

	var_14_38:align(cc.p(1, 0), var_14_36:size().w - 20, 20)

	local var_14_39 = TempWidget:CreateTempLabel("", FONT_NAME, 17, var_14_38)

	var_14_39:align(cc.p(1, 0.5), var_14_38:size().w - 5, var_14_38:size().h / 2)

	self.timelyCardLayout._childData.numText = var_14_39

	local var_14_40 = TempWidget:CreateTempImg(var_0_2 .. "have_bought.png", var_14_36)

	var_14_40:hide()
	var_14_40:center()

	self.timelyCardLayout._childData.haveBoughtImg = var_14_40

	local var_14_41 = TempWidget:CreateTempImg(var_0_2 .. "renew_bg.png", var_14_34)

	var_14_41:align(cc.p(0.5, 0), var_14_34:size().w / 2, 5)

	self.timelyCardLayout._childData.remainBg = var_14_41

	local var_14_42 = TempWidget:CreateTempLabel(string.format(L_SIGNLAYER_LESS, 8), FONT_NAME, 17, var_14_41)

	var_14_42:setVisible(8 <= 9)
	var_14_42:center()

	self.timelyCardLayout._childData.remainText = var_14_42

	local var_14_43 = L2Skeleton:create(UI_SPINE_PATH .. "sign/skeleton.json", UI_SPINE_PATH .. "sign/skeleton.atlas")

	var_14_43:refreshSkeleton()
	var_14_43.skeletonAnimation:setPositionX(54)
	var_14_43.skeletonAnimation:setPositionY(54)
	var_14_43:setName("timelyCardSpine")
	var_14_43:play("animation", true)
	var_14_43:setVisible(false)
	var_14_36:addChild(var_14_43)

	self.timelyCardLayout._childData.timelyCardSpine = var_14_43

	self.manager:requestExtraRewardInfo()
end

function SignLayerNew:updateBottomBg()
	if var_0_8:getCurTime() > os.time({
		hour = 0,
		month = 10,
		year = 2022,
		min = 0,
		sec = 0,
		day = 1
	}) then
		return
	end

	if not self.bInit then
		return
	end

	local var_15_0 = sign_manager:getsignAccuItemData(self.month)

	for iter_15_0 = 1, #var_15_0 do
		local var_15_1 = self.accumulativeBtnTable[iter_15_0]

		if self.signTotal >= var_15_0[iter_15_0].daycount and not self.signaccuaward[iter_15_0] then
			self.accumulativeBtnTable[iter_15_0]._childData.canGetImg:show()
			self.accumulativeBtnTable[iter_15_0]._childData.haveGetImg:hide()
		elseif self.signTotal >= var_15_0[iter_15_0].daycount and self.signaccuaward[iter_15_0] then
			self.accumulativeBtnTable[iter_15_0]._childData.canGetImg:hide()
			self.accumulativeBtnTable[iter_15_0]._childData.haveGetImg:show()
		else
			self.accumulativeBtnTable[iter_15_0]._childData.canGetImg:hide()
			self.accumulativeBtnTable[iter_15_0]._childData.haveGetImg:hide()
		end

		var_15_1:_addEvent(function()
			if self.signTotal >= var_15_0[iter_15_0].daycount and not self.signaccuaward[iter_15_0] then
				self.manager:requestAccumulateAward(self.month, iter_15_0)
			else
				self:showItemDetail(drop_manager:getAllDrops(var_15_0[iter_15_0].dropid)[1].dropid)
			end
		end)
	end

	local var_15_2 = {
		{
			proValue = 14
		},
		{
			proValue = 39
		},
		{
			proValue = 63
		},
		{
			proValue = 87
		},
		{
			proValue = 100
		}
	}

	for iter_15_1 = 1, #var_15_0 do
		var_15_2[iter_15_1].value = var_15_0[iter_15_1].daycount
	end

	var_15_2[#var_15_2].value = self.monthNum

	for iter_15_2 = 1, #var_15_2 do
		if self.signTotal <= var_15_2[iter_15_2].value then
			local var_15_3 = 0

			if iter_15_2 > 1 then
				var_15_3 = var_15_2[iter_15_2 - 1].proValue
			end

			local var_15_4 = var_15_2[iter_15_2].proValue

			if iter_15_2 > 1 then
				var_15_4 = var_15_2[iter_15_2].proValue - var_15_2[iter_15_2 - 1].proValue
			end

			self.loadingBar:setPercent(iter_15_2 > 1 and (self.signTotal - var_15_2[iter_15_2 - 1].value) / (var_15_2[iter_15_2].value - var_15_2[iter_15_2 - 1].value) * var_15_4 + var_15_3 or self.signTotal / var_15_2[iter_15_2].value * var_15_4 + var_15_3)

			break
		end
	end

	self.signDayText:setString(string.format("%.2d", self.signTotal))
end

function SignLayerNew:initListView()
	self.listView:removeAllItems()

	var_0_27 = math.ceil(self.monthNum / var_0_23)
	var_0_29 = (self.listView:size().w - var_0_24 * 2 - var_0_26 * (var_0_23 - 1)) / var_0_23

	for iter_17_0 = 1, var_0_27 do
		local var_17_1 = TempWidget:CreateTempLayout()

		var_17_1:setContentSize(cc.size(self.listView:size().w, var_0_28))
		var_17_1:setOpacity(0)
		var_17_1:runAction(cc.Sequence:create(cc.DelayTime:create(iter_17_0 * 0.05), cc.FadeIn:create(0.2)))

		var_17_1._childData = {}
		var_17_1._childData.icons = {}

		for iter_17_1 = 1, var_0_23 do
			if var_0_23 * (iter_17_0 - 1) + iter_17_1 <= self.monthNum then
				local var_17_2 = TempWidget:CreateTempLayout(var_17_1)

				var_17_2:setContentSize(cc.size(var_0_29, var_0_28))
				var_17_2:align(cc.p(0, 0.5), var_0_25 + (iter_17_1 - 1) * (var_0_29 + var_0_26), var_17_1:size().h / 2)

				local var_17_3 = self:createItemIcon(var_0_23 * (iter_17_0 - 1) + iter_17_1)

				var_17_2:addChild(var_17_3)
				var_17_3:align(cc.p(0.5, 0.5), var_17_2:property().center)

				var_17_1._childData.icons[iter_17_1] = var_17_3
			end
		end

		self.listView:pushBackCustomItem(var_17_1)
	end
end

function SignLayerNew:initListener()
	self._root:_addEvent(function()
		self._root:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0.01), cc.CallFunc:create(function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)))
	end)
	self.signBtn:_addEvent(function()
		if self.iscansign then
			self.manager:requestSign(self.month)
		elseif self.signTotal < tonumber(os.date("%d", var_0_8:getCurTime())) then
			self.manager:requestSupplement(self.date + 1, self.month)
		else
			global_ShowBlockWords(L_ACTIVITY_SIGN_FINISH)
		end
	end)
end

function SignLayerNew:createItemIcon(arg_22_1)
	local var_22_0 = self.itemList[arg_22_1]
	local var_22_1 = TempWidget:CreateTempLayout()

	var_22_1:setContentSize(cc.size(var_0_29, var_0_28))

	var_22_1._childData = {}

	local var_22_2 = TempWidget:CreateTempImg(var_0_2 .. "tips_bg.png", var_22_1)

	var_22_2:align(cc.p(0.5, 0.5), var_22_1:size().w / 2, var_22_1:size().h / 2 + 7)
	var_22_2:setVisible(self.signTotal + 1 == arg_22_1 and tonumber(os.date("%d", var_0_8:getCurTime())) > self.signTotal)

	var_22_1._childData.bg = var_22_2

	local var_22_3 = TempWidget:CreateTempBtn(var_0_22[var_22_0.quality], var_22_1)

	var_22_3:center()
	var_22_3:setScale(0.5)

	var_22_1._childData.btn = var_22_3

	local var_22_4

	if item_data[var_22_0.itemid].bag_item_type == kITEM_COMPONENT then
		var_22_4 = component_manager:create_component_icon(var_22_0.itemid, nil, nil)

		var_22_4:setPosition(cc.p(var_22_3:size().w / 2, var_22_3:size().h / 2))
		var_22_3:addChild(var_22_4)
	else
		var_22_4 = TempWidget:CreateTempImg("equipment/" .. var_22_0.image_id .. ".png", var_22_3, 0)

		var_22_4:align(cc.p(0.5, 0.5), var_22_3:size().w / 2, var_22_3:size().h / 2 + 20)
	end

	var_22_4:setScale(var_22_0.bag_item_type ~= kITEM_HORCRUX and 1 or 0.5)
	TempWidget:CreateTempLabel("x" .. var_22_0.itemNum * self.manager:getSignRate(), FONT_DES, 35, var_22_3):align(cc.p(0.5, 0), var_22_3:size().w / 2, 5)

	local var_22_5 = TempWidget:CreateTempImg(var_0_2 .. "signed_in_bg.png", var_22_1)

	var_22_5:hide()
	var_22_5:center()

	var_22_1._childData.signedInBg = var_22_5

	local var_22_6 = TempWidget:CreateTempImg(var_0_2 .. "supplement.png", var_22_1)

	var_22_6:align(cc.p(0, 1), 5, var_22_1:size().h - 5)
	var_22_6:hide()

	var_22_1._childData.supplementImg = var_22_6

	return var_22_1
end

function SignLayerNew:setSignData()
	self.signDataTbl = {}

	local var_23_0 = self.signNum

	while var_23_0 >= 2 do
		table.insert(self.signDataTbl, var_23_0 % 2)

		var_23_0 = math.floor(var_23_0 / 2)
	end

	if var_23_0 ~= 0 then
		table.insert(self.signDataTbl, var_23_0)
	end
end

function SignLayerNew.updateLayer(arg_24_0)
	return
end

function SignLayerNew.updateRed(arg_25_0)
	return
end

function SignLayerNew:updateListView()
	if not self.bInit then
		return
	end

	local var_26_0 = self.listView:getChildren()
	local var_26_1 = self.itemList

	for iter_26_0 = 1, #var_26_0 do
		for iter_26_1 = 1, var_0_23 do
			if var_26_0[iter_26_0]._childData.icons[iter_26_1] then
				local var_26_2 = var_26_0[iter_26_0]._childData.icons[iter_26_1]._childData.bg
				local var_26_3 = var_26_0[iter_26_0]._childData.icons[iter_26_1]._childData.signedInBg
				local var_26_4 = var_26_0[iter_26_0]._childData.icons[iter_26_1]._childData.supplementImg
				local var_26_5 = var_26_0[iter_26_0]._childData.icons[iter_26_1]._childData.btn
				local var_26_6 = (iter_26_0 - 1) * var_0_23 + iter_26_1

				if self.signVersion == 1 then
					if var_26_6 < self.date then
						if (self.signDataTbl[var_26_6] or 0) == 0 then
							var_26_3:hide()
							var_26_4:show()
							var_26_5:_addEvent(function()
								self.manager:requestSupplement(var_26_6, self.month)
							end, {
								touchDelay = 0.5
							})
						else
							var_26_3:show()
							var_26_4:hide()
							var_26_5:_addEvent(function()
								self:showItemDetail(var_26_1[var_26_6].itemid)
							end, {
								touchDelay = 0.5
							})
						end
					elseif var_26_6 == self.date and #self.signDataTbl < self.date then
						var_26_3:hide()
						var_26_4:hide()
						var_26_5:_addEvent(function()
							self.manager:requestSign(self.month)
						end, {
							touchDelay = 0.5
						})
					elseif var_26_6 == self.date then
						var_26_3:show()
						var_26_4:hide()
						var_26_5:_addEvent(function()
							self:showItemDetail(var_26_1[var_26_6].itemid)
						end, {
							touchDelay = 0.5
						})
					else
						var_26_3:hide()
						var_26_4:hide()
						var_26_5:_addEvent(function()
							self:showItemDetail(var_26_1[var_26_6].itemid)
						end, {
							touchDelay = 0.5
						})
					end
				elseif self.signVersion == 2 then
					var_26_3:setVisible(var_26_6 <= self.signTotal)

					local var_26_8

					if self.iscansign then
						var_26_8 = self.signTotal + 1 or self.signTotal
					end

					local var_26_9 = tonumber(os.date("%d", var_0_8:getCurTime()))

					var_26_4:setVisible(var_26_8 < var_26_6 and var_26_6 <= var_26_9)
					var_26_2:setVisible(self.signTotal + 1 == var_26_6 and var_26_9 > self.signTotal)
					var_26_5:_addEvent(function()
						if self.iscansign and var_26_6 == self.signTotal + 1 then
							self.manager:requestSign(self.month)
						elseif var_26_6 >= self.signTotal and var_26_6 <= var_26_9 then
							if var_26_6 == self.signTotal + 1 then
								self.manager:requestSupplement(var_26_6, self.month)
							else
								global_ShowBlockWords(L_SIGN_DAY_BY_DAY)
							end
						else
							self:showItemDetail(var_26_1[var_26_6].itemid)
						end
					end, {
						touchDelay = 0.5
					})
				end
			end
		end
	end
end

function SignLayerNew:updateExtraRewardBg()
	local var_33_0 = self.manager:getExtraInfo()
	local var_33_1 = self.monthCardLayout

	self.monthCardLayout._childData.haveBoughtImg:hide()

	if var_33_0[var_0_17].remain and var_33_0[var_0_17].remain > 0 and var_33_0[var_0_17].lastreward then
		self.monthCardLayout._childData.haveBoughtImg:show()
	end

	if var_33_0[var_0_17].remain and var_33_0[var_0_17].remain > 0 and var_33_0[var_0_17].remain <= 999 then
		self.monthCardLayout._childData.monthCardSpine:setVisible(true)
		self.monthCardLayout._childData.remainBg:loadTexture(var_0_2 .. "renew_bg.png", var_0_1)
		var_33_1._childData.remainText:setString(string.format(L_SIGNLAYER_LESS, var_33_0[var_0_17].remain))
		var_33_1._childData.remainBg:show()
	else
		local var_33_2 = var_33_1._childData.remainText

		self.monthCardLayout._childData.monthCardSpine:setVisible(false)
		var_33_2:setString(string.format(L_SIGNLAYER_LOCK, var_33_0[var_0_17].remain))
		self.monthCardLayout._childData.remainBg:loadTexture(var_0_2 .. "lock_bg.png", var_0_1)
	end

	var_33_1._childData.cardBox:_addEvent(function()
		if var_33_0[var_0_17].remain and var_33_0[var_0_17].remain > 0 then
			if not var_33_0[var_0_17].lastreward then
				self.manager:requestOtherMonthcardReward(var_0_17)
			end
		else
			LayerManager:pushInLayer("PopSupermarketLayer", {
				tab = 3,
				callback = function()
					require("controller.sign_new_manager"):getInstance():requestExtraRewardInfo()
				end
			})
		end
	end)

	local var_33_3 = self.seasonCardLayout

	self.seasonCardLayout._childData.haveBoughtImg:hide()

	if var_33_0[var_0_18].remain and var_33_0[var_0_18].remain > 0 and var_33_0[var_0_18].lastreward then
		self.seasonCardLayout._childData.haveBoughtImg:show()
	end

	if var_33_0[var_0_18].remain and var_33_0[var_0_18].remain > 0 then
		self.seasonCardLayout._childData.seasonCardSpine:setVisible(true)
		self.seasonCardLayout._childData.remainBg:loadTexture(var_0_2 .. "renew_bg.png", var_0_1)
		var_33_3._childData.remainText:setString(string.format(L_SIGNLAYER_LESS, var_33_0[var_0_18].remain))
		var_33_3._childData.remainBg:show()
	else
		local var_33_4 = var_33_3._childData.remainText

		self.seasonCardLayout._childData.seasonCardSpine:setVisible(false)
		self.seasonCardLayout._childData.remainBg:loadTexture(var_0_2 .. "lock_bg.png", var_0_1)
		var_33_4:setString(string.format(L_SIGNLAYER_LOCK, var_33_0[var_0_18].remain))
	end

	var_33_3._childData.cardBox:_addEvent(function()
		if var_33_0[var_0_18].remain and var_33_0[var_0_18].remain > 0 then
			if not var_33_0[var_0_18].lastreward then
				self.manager:requestOtherMonthcardReward(var_0_18)
			end
		else
			LayerManager:pushInLayer("PopSupermarketLayer", {
				tab = 3,
				callback = function()
					require("controller.sign_new_manager"):getInstance():requestExtraRewardInfo()
				end
			})
		end
	end)

	local var_33_5 = self.yearCardLayout

	self.yearCardLayout._childData.haveBoughtImg:hide()

	if var_33_0[var_0_19].remain and var_33_0[var_0_19].remain > 0 and var_33_0[var_0_19].lastreward then
		self.yearCardLayout._childData.haveBoughtImg:show()
	end

	if var_33_0[var_0_19].remain and var_33_0[var_0_19].remain > 0 then
		self.yearCardLayout._childData.yearCardSpine:setVisible(true)
		self.yearCardLayout._childData.remainBg:loadTexture(var_0_2 .. "renew_bg.png", var_0_1)
		var_33_5._childData.remainText:setString(string.format(L_SIGNLAYER_LESS, var_33_0[var_0_19].remain))
		var_33_5._childData.remainBg:show()
	else
		local var_33_6 = var_33_5._childData.remainText

		self.yearCardLayout._childData.yearCardSpine:setVisible(false)
		self.yearCardLayout._childData.remainBg:loadTexture(var_0_2 .. "lock_bg.png", var_0_1)
		var_33_6:setString(string.format(L_SIGNLAYER_LOCK, var_33_0[var_0_19].remain))
	end

	var_33_5._childData.cardBox:_addEvent(function()
		if var_33_0[var_0_19].remain and var_33_0[var_0_19].remain > 0 then
			if not var_33_0[var_0_19].lastreward then
				self.manager:requestOtherMonthcardReward(var_0_19)
			end
		else
			LayerManager:pushInLayer("PopSupermarketLayer", {
				tab = 3,
				callback = function()
					require("controller.sign_new_manager"):getInstance():requestExtraRewardInfo()
				end
			})
		end
	end)

	local var_33_7 = self.timelyCardLayout

	self.timelyCardLayout:hide()

	local var_33_8 = var_33_7._childData.haveBoughtImg

	var_33_7._childData.haveBoughtImg:hide()

	local var_33_9

	if var_33_0[var_0_21] then
		var_33_9 = var_0_21
	elseif var_33_0[var_0_20] then
		var_33_9 = var_0_20
	end

	if var_33_9 then
		var_33_7:show()

		if var_33_0[var_33_9].remain and var_33_0[var_33_9].remain > 0 and var_33_0[var_33_9].lastreward then
			var_33_8:show()
		end

		if var_33_0[var_33_9].remain and var_33_0[var_33_9].remain > 0 then
			self.timelyCardLayout._childData.timelyCardSpine:setVisible(true)
			self.timelyCardLayout._childData.remainBg:loadTexture(var_0_2 .. "lock_bg.png", var_0_1)
			var_33_7._childData.remainText:setString(string.format(L_SIGNLAYER_LESS, var_33_0[var_33_9].remain))
			var_33_7._childData.remainBg:show()
		else
			local var_33_10 = var_33_7._childData.remainText

			self.timelyCardLayout._childData.timelyCardSpine:setVisible(false)
			self.timelyCardLayout._childData.remainBg:loadTexture(var_0_2 .. "lock_bg.png", var_0_1)
			var_33_10:setString(string.format(L_SIGNLAYER_LOCK, var_33_0[var_0_17].remain))
		end

		var_33_7._childData.cardBox:_addEvent(function()
			if var_33_0[var_33_9].remain and var_33_0[var_33_9].remain > 0 then
				if not var_33_0[var_33_9].lastreward then
					self.manager:requestOtherMonthcardReward(var_33_9)
				end
			else
				LayerManager:pushInLayer("PopSupermarketLayer", {
					tab = 3,
					callback = function()
						require("controller.sign_new_manager"):getInstance():requestExtraRewardInfo()
					end
				})
			end
		end)

		local var_33_11 = drop_manager:getNormalDrops(recharge_data[var_33_9].dropid)

		if var_33_11.diamond and var_33_11.diamond > 0 then
			var_33_7._childData.icon:loadTextureEx("equipment/1000000.png", 0)
			var_33_7._childData.numText:setString(var_33_11.diamond)
		elseif var_33_11.equips and var_33_11.equips[1] then
			var_33_7._childData.icon:loadTextureEx("equipment/" .. var_33_11.equips[1].dropid .. ".png", 0)
			var_33_7._childData.numText:setString(var_33_11.equips[1].dropNum)
		end
	end

	local function var_33_12()
		for iter_42_0, iter_42_1 in ipairs({
			100007,
			98001,
			98004,
			98005,
			30503
		}) do
			if var_33_0[iter_42_1] and var_33_0[iter_42_1].remain and var_33_0[iter_42_1].remain > 0 then
				return true
			end
		end

		return false
	end

	self.timelyBtn:_addEvent(function()
		if var_33_12() then
			if self.iscansign then
				self.manager:requestSign(self.month)
			elseif self.signTotal < tonumber(os.date("%d", var_0_8:getCurTime())) then
				self.manager:requestSupplement(self.date + 1, self.month)
			else
				global_ShowBlockWords(L_ACTIVITY_SIGN_FINISH)
			end
		else
			LayerManager:pushInLayer("PopSupermarketLayer", {
				tab = 998,
				callback = function()
					require("controller.sign_new_manager"):getInstance():requestExtraRewardInfo()
				end
			})
		end
	end)
end

function SignLayerNew.showItemDetail(arg_45_0, arg_45_1)
	local var_45_0 = {
		itemid = arg_45_1
	}

	var_45_0.hideGainButton = true

	if arg_45_1 then
		LayerManager:pushInLayer("PopItemLayer", var_45_0)
	end
end

function SignLayerNew:signSuccess(arg_46_1)
	if self.bInit then
		self.iscansign = arg_46_1.iscansign
		self.signNum = arg_46_1.signaccumulate
		self.signTotal = arg_46_1.signcount

		self:setSignData()
		self:updateListView()
		self:updateBottomBg()
	end
end

function SignLayerNew:supplementSuccess(arg_47_1)
	if self.bInit then
		self.signNum = arg_47_1.signaccumulate
		self.signTotal = arg_47_1.signcount

		self:setSignData()
		self:updateListView()
		self:updateBottomBg()
	end
end

function SignLayerNew:accumulateAwardSuccess(arg_48_1)
	if self.bInit then
		self.signaccuaward = arg_48_1.signaccuaward

		self:updateBottomBg()
	end
end

function SignLayerNew:otherMonthcardRewardSuccess()
	if self.bInit then
		self:updateExtraRewardBg()
	end
end

function SignLayerNew:updateStandImg()
	if self.bInit then
		self.standImg:loadTextureEx(var_0_2 .. sign_accumulate_data[os.date("*t", (time_check_manager:getCurTime())).month].showrole .. ".png")
	end
end

function SignLayerNew:updateMonthNumImg()
	local var_51_0 = string.format("%.2d", self.month)

	self.oneNumImg:loadTextureEx(var_0_2 .. string.sub(var_51_0, 1, 1) .. ".png")
	self.twoNumImg:loadTextureEx(var_0_2 .. string.sub(var_51_0, 2, 2) .. ".png")
end

function SignLayerNew:updateMonth()
	if self.bInit then
		local var_52_0 = sign_manager:getTime(time_check_manager:getCurTime())

		self.month = var_52_0.month
		self.monthNum = var_52_0.dayNum
		self.date = var_52_0.day
		self.itemList = sign_manager:getSignItemDataNew(self.month, self.monthNum)

		self:setSignData()
		self:updateStandImg()
		self:updateBottomBg()
		self:initListView()
		self:updateListView()
		self:updateMonthNumImg()
		self.manager:requestExtraRewardInfo()
	end
end

return SignLayerNew
