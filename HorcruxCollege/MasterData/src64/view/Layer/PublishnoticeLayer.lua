PublishnoticeLayer = class("PublishnoticeLayer", function()
	return cc.Layer:create()
end)

local network = require("network.network")
local RichTextPro = require("view.Sprite.RichTextPro")
local playermodel = require("model.playermodel")
local alert_manager = require("controller.alert_manager")
local l2utils = require("controller.l2utils")
local notice_data = require("data.notice_data")
local var_0_6 = config._DEBUG and 0 or 1
local var_0_7 = {
	Auto = 1,
	Hand = 2
}
local var_0_8 = 1
local var_0_9 = 0
local var_0_11 = 1
local var_0_12 = 2
local var_0_13 = {
	[1] = 3,
	[2] = 4
}
local var_0_14 = {
	[1] = 1,
	[2] = 2
}

function PublishnoticeLayer.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = PublishnoticeLayer.new()

	var_2_0:initBg(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function PublishnoticeLayer.fullScreen(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:setContentSize(GameDisplay.getScreenSize())
	arg_3_1:setPositionY(arg_3_1:getPositionY() - GameDisplay.fix_y)
	arg_3_2:setPositionY(GameDisplay.getUiScreenSize().height / 2)
end

function PublishnoticeLayer:init(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PublishnoticeLayer.json" or "PublishnoticeLayer.ExportJson")

	self:addChild(self.rootlayer)

	self.rootPanel = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_root")
	self.panelHide = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_isHide")
	self.noticePanel = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_notice")
	self.infoPanel = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_detail")

	self.infoPanel:setTouchEnabled(false)
	self.infoPanel:setVisible(false)
	self.noticePanel:setTouchEnabled(true)

	self.btntab = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_tab")
	self.notice_image = ccui.Helper:seekWidgetByName(self.noticePanel, "notice_image")

	self.notice_image:setVisible(false)

	self.image_no_title = ccui.Helper:seekWidgetByName(self.noticePanel, "Image_no_title")
	self.listView = ccui.Helper:seekWidgetByName(self.noticePanel, "ListView_tab")
	self.btnActivity = ccui.Helper:seekWidgetByName(self.noticePanel, "button_activity")
	self.btnGame = ccui.Helper:seekWidgetByName(self.noticePanel, "button_notice")
	self.imagebg = ccui.Helper:seekWidgetByName(self.noticePanel, "Image_word_bg")

	self:initNotices(arg_4_1, arg_4_2, arg_4_3)
	self.rootPanel:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()
	end)

	self.activity = true

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			self.activity = false

			if arg_4_4 then
				arg_4_4()
			end

			if self.newActCount and self.newGameCount and self.newActCount <= 0 and self.newGameCount <= 0 then
				alert_manager:unregister_alert(ALERT_NEW_NOTICE, true)
			end

			l2utils:removeNodeShake(self.sp)
		end
	end)
	self:fullScreen(self.rootPanel, self.noticePanel)
end

function PublishnoticeLayer.sortTable(arg_7_0, arg_7_1)
	table.sort(arg_7_1, function(arg_8_0, arg_8_1)
		if arg_8_0.read ~= arg_8_1.read then
			return arg_8_0.read > arg_8_1.read
		else
			return arg_8_0.order < arg_8_1.order
		end
	end)
end

function PublishnoticeLayer:initNotices(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 then
		if next(arg_9_1.Activity.isStick) ~= nil then
			self:sortTable(arg_9_1.Activity.isStick)
		end

		if next(arg_9_1.Activity.noStick) ~= nil then
			self:sortTable(arg_9_1.Activity.noStick)
		end

		if next(arg_9_1.Game.isStick) ~= nil then
			self:sortTable(arg_9_1.Game.isStick)
		end

		if next(arg_9_1.Game.noStick) ~= nil then
			self:sortTable(arg_9_1.Game.noStick)
		end
	end

	if arg_9_2 >= 1 then
		local var_9_0 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_6)

		var_9_0:setPosition(cc.p(140, 52))
		var_9_0:setName("reddot_act")
		self.btnActivity:addChild(var_9_0)
	end

	if arg_9_3 >= 1 then
		local var_9_1 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_6)

		var_9_1:setPosition(cc.p(140, 52))
		var_9_1:setName("reddot_game")
		self.btnGame:addChild(var_9_1)
	end

	self.notice_image:setVisible(false)

	self.actionnode = cc.NodeGrid:create()

	self.actionnode:setName("actionnode")

	self.sp = cc.Sprite:create()

	self.sp:setAnchorPoint(cc.p(0.5, 1))
	self.sp:setPosition(self.notice_image:getPosition())
	self.noticePanel:addChild(self.sp, 2)

	self.tag = "ACTIVITY"

	self.btnActivity:loadTextures("PublishnoticeLayer/btn_activity_on.png", "PublishnoticeLayer/btn_activity_on.png", "PublishnoticeLayer/btn_activity_on.png", var_0_6)

	if arg_9_1 and (next(arg_9_1.Activity.isStick) ~= nil or next(arg_9_1.Activity.noStick) ~= nil) then
		self.image_no_title:setVisible(false)
		self:loadNotices(arg_9_1.Activity)
		self.imagebg:setOpacity(0)
		self.imagebg:runAction(cc.FadeIn:create(1))
		self:switchBtn(1)
	else
		self.image_no_title:setVisible(true)
	end

	self.btnActivity:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.tag == "ACTIVITY" then
			return
		end

		self.tag = "ACTIVITY"

		self.image_no_title:setVisible(false)

		if self.panelHide:getChildByName("infoPanel") then
			self.panelHide:getChildByName("infoPanel"):removeFromParent()
		end

		self.listView:removeAllItems()
		self.btnActivity:loadTextures("PublishnoticeLayer/btn_activity_on.png", "PublishnoticeLayer/btn_activity_on.png", "PublishnoticeLayer/btn_activity_on.png", var_0_6)
		self.btnGame:loadTextures("PublishnoticeLayer/btn_notice_no.png", "PublishnoticeLayer/btn_notice_no.png", "PublishnoticeLayer/btn_notice_no.png", var_0_6)
		self.btnActivity:setTouchEnabled(false)
		self.btnGame:setTouchEnabled(true)

		if not arg_9_1 or next(arg_9_1.Activity.isStick) == nil and next(arg_9_1.Activity.noStick) == nil then
			self.image_no_title:setVisible(true)
			self.sp:setVisible(false)
			self.panelHide:setVisible(false)

			return
		else
			self.panelHide:setVisible(true)
			self.imagebg:setOpacity(0)
			self.imagebg:runAction(cc.FadeIn:create(1))
			self.sp:setVisible(true)
		end

		self:loadNotices(arg_9_1.Activity)
		self:switchBtn(1)
	end)
	self.btnGame:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.tag == "NOTICE" then
			return
		end

		self.tag = "NOTICE"

		self.image_no_title:setVisible(false)

		if self.panelHide:getChildByName("infoPanel") then
			self.panelHide:getChildByName("infoPanel"):removeFromParent()
		end

		self.listView:removeAllItems()
		self.btnActivity:loadTextures("PublishnoticeLayer/btn_activity_no.png", "PublishnoticeLayer/btn_activity_no.png", "PublishnoticeLayer/btn_activity_no.png", var_0_6)
		self.btnGame:loadTextures("PublishnoticeLayer/btn_notice_on.png", "PublishnoticeLayer/btn_notice_on.png", "PublishnoticeLayer/btn_notice_on.png", var_0_6)
		self.btnActivity:setTouchEnabled(true)
		self.btnGame:setTouchEnabled(false)

		if not arg_9_1 or next(arg_9_1.Game.isStick) == nil and next(arg_9_1.Game.noStick) == nil then
			self.image_no_title:setVisible(true)
			self.sp:setVisible(false)
			self.panelHide:setVisible(false)

			return
		else
			self.panelHide:setVisible(true)
			self.imagebg:setOpacity(0)
			self.imagebg:runAction(cc.FadeIn:create(1))
			self.sp:setVisible(true)
		end

		self:loadNotices(arg_9_1.Game)
		self:switchBtn(1)
	end)
end

function PublishnoticeLayer:switchBtn(arg_12_1)
	if self.indexId ~= arg_12_1 then
		self.indexId = arg_12_1
	end

	for iter_12_0, iter_12_1 in pairs(self.noticeimg) do
		if iter_12_0 == arg_12_1 then
			iter_12_1:loadTextures("PublishnoticeLayer/bottom_btn_on.png", "PublishnoticeLayer/bottom_btn_on.png", "PublishnoticeLayer/bottom_btn_on.png", var_0_6)
			iter_12_1:getChildByName("Label_24"):setColor(cc.c3b(255, 255, 255))
			iter_12_1:getChildByName("Label_24"):setPositionY(28 + 14)
		else
			iter_12_1:loadTextures("PublishnoticeLayer/bottom_btn_no.png", "PublishnoticeLayer/bottom_btn_no.png", "PublishnoticeLayer/bottom_btn_no.png", var_0_6)
			iter_12_1:getChildByName("Label_24"):setColor(cc.c3b(151, 162, 186))
			iter_12_1:getChildByName("Label_24"):setPositionY(28)
		end
	end
end

function PublishnoticeLayer:loadNotices(arg_13_1)
	local function var_13_0(arg_14_0, arg_14_1)
		local var_14_0 = self.btntab:clone()

		var_14_0.id = arg_14_1

		local var_14_1, var_14_2 = arg_14_0.title:match("(.+)#(.+)")

		var_14_0:getChildByName("Label_24"):setString(var_14_2)
		var_14_0:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.indexId == arg_15_0.id then
				return
			end

			self:switchBtn(arg_15_0.id)
			self:updateBtn(arg_15_0)
			self.imagebg:setOpacity(0)
			self.imagebg:runAction(cc.FadeIn:create(1))
			self:showNoticeInfo(arg_14_0.id, arg_14_0.title, arg_15_0)
			AnalyticManager.enterNoticeIn({
				NoticeId = arg_14_0.id
			})
		end)
		self.listView:pushBackCustomItem(var_14_0)

		if arg_14_0.read == var_0_8 and global_get_time_by_date(arg_14_0.time) > playermodel.create_time then
			local var_14_3 = ccui.ImageView:create("public/reddot/reddot0.png", var_0_6)

			var_14_3:setName("NEW")
			var_14_3:setPosition(cc.p(70, 65))
			var_14_0:addChild(var_14_3)
		end

		return var_14_0
	end

	self.noticeimg = {}

	local var_13_1 = #arg_13_1.isStick or 0
	local var_13_2 = #arg_13_1.noStick or 0
	local var_13_3 = false
	local var_13_4 = RoleDefault:getInstance():getIntegerForKey("ReadNoticeNum", 0)

	if var_13_4 ~= 0 then
		for iter_13_0 = 1, var_13_4 do
			local var_13_5 = RoleDefault:getInstance():getIntegerForKey("ReadNoticeNo" .. iter_13_0, 0)

			_, arg_13_1.isStick = self:notice_compare(var_13_3, var_13_5, arg_13_1.isStick)
			_, arg_13_1.noStick = self:notice_compare(var_13_3, var_13_5, arg_13_1.noStick)
		end
	end

	for iter_13_1 = 1, var_13_1 do
		self.noticeimg[iter_13_1] = var_13_0(arg_13_1.isStick[iter_13_1], iter_13_1)
	end

	for iter_13_2 = var_13_1 + 1, var_13_1 + var_13_2 do
		self.noticeimg[iter_13_2] = var_13_0(arg_13_1.noStick[iter_13_2 - var_13_1], iter_13_2)
	end

	if var_13_1 ~= 0 then
		self:showNoticeInfo(arg_13_1.isStick[1].id, arg_13_1.isStick[1].title, self.noticeimg[1])
	else
		self:showNoticeInfo(arg_13_1.noStick[1].id, arg_13_1.noStick[1].title, self.noticeimg[1])
	end
end

function PublishnoticeLayer:updateBtn(arg_16_1)
	if arg_16_1:getChildByName("NEW") then
		arg_16_1:getChildByName("NEW"):runAction(cc.RemoveSelf:create())

		if self.btnActivity:getChildByName("reddot_act") and self.tag == "ACTIVITY" then
			self.newActCount = self.newActCount - 1
		end

		if self.btnGame:getChildByName("reddot_game") and self.tag == "NOTICE" then
			self.newGameCount = self.newGameCount - 1
		end
	end

	if self.btnActivity:getChildByName("reddot_act") and self.tag == "ACTIVITY" and self.newActCount == 0 then
		self.btnActivity:getChildByName("reddot_act"):setVisible(false)
	end

	if self.btnGame:getChildByName("reddot_game") and self.tag == "NOTICE" and self.newGameCount == 0 then
		self.btnGame:getChildByName("reddot_game"):setVisible(false)
	end
end

function PublishnoticeLayer.changeStr(arg_17_0, arg_17_1)
	while string.find(arg_17_1, "0, 176, 80") do
		arg_17_1 = string.gsub(arg_17_1, "0, 176, 80", "2, 255, 251")
	end

	while string.find(arg_17_1, "0, 176, 240") do
		arg_17_1 = string.gsub(arg_17_1, "0, 176, 240", "0, 216, 255")
	end

	return arg_17_1
end

function PublishnoticeLayer.showNoticeInfo(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	network:rpc("get_notice_info", {
		id = arg_18_1
	}, function(arg_19_0)
		AnalyticManager.on_open_notice({
			noticeid = arg_18_1
		})

		if arg_18_0.activity == true then
			if arg_18_0.panelHide:getChildByName("infoPanel") then
				arg_18_0.panelHide:getChildByName("infoPanel"):removeFromParent()
			end

			if arg_19_0.result == 1 then
				local var_19_0 = arg_18_0.infoPanel:clone()

				var_19_0:setVisible(true)

				local var_19_1, var_19_2 = arg_18_2:match("(.+)#(.+)")

				var_19_1 = var_19_1 or "200006"

				local var_19_3 = var_19_0:getChildByName("scrollview_detail")

				arg_18_0.sp:setTexture("mainScenebg/announcement/" .. var_19_1 .. ".png")
				l2utils:shakeNode(arg_18_0.sp, {
					scanlinethreshold = 0.025,
					driftpixel = 0,
					waitframe = 0,
					shakeframe = 12,
					restoreframe = 12,
					scanlinedriftfac = 5
				})
				arg_18_0.sp:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
					l2utils:removeNodeShake(arg_18_0.sp)
				end)))

				local var_19_4 = RichTextPro:create()

				var_19_4:setMaxWidth(450)
				var_19_4:setText((arg_18_0:changeStr(arg_19_0.info)))
				var_19_4:setPosition(cc.p(27, 480))
				var_19_3:addChild(var_19_4)
				var_19_4:setOpacity(0)

				local var_19_5 = var_19_4:getTable()

				for iter_19_0 = 1, #var_19_5 do
					var_19_5[iter_19_0]:setOpacity(0)
					var_19_5[iter_19_0]:runAction(cc.FadeIn:create(1))
				end

				local var_19_6 = var_19_4:getContentHeight()

				var_19_3:setInnerContainerSize(cc.size(0, 0))
				print("str_height", var_19_6)

				if var_19_6 > 480 then
					var_19_3:setInnerContainerSize(cc.size(0, var_19_6 + 270))
					var_19_3:setClippingEnabled(true)
					var_19_4:setPositionY(var_19_6 + 270)
				else
					var_19_3:setBounceEnabled(false)
				end

				arg_18_0:restoreNoticeId(arg_18_1)
				var_19_0:setName("infoPanel")
				arg_18_0.panelHide:addChild(var_19_0)
			else
				global_riseWord(L_PUBLISH_NOTICE_NIL)
			end
		end
	end)
end

function PublishnoticeLayer.notice_compare(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if #arg_21_3 > 0 then
		for iter_21_0 = 1, #arg_21_3 do
			if arg_21_2 and arg_21_2 == arg_21_3[iter_21_0].id then
				arg_21_1 = true
				arg_21_3[iter_21_0].read = var_0_9

				print("match")

				break
			else
				arg_21_1 = false
			end
		end
	end

	return arg_21_1, arg_21_3
end

function PublishnoticeLayer:OpenNotice(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		if var_22_0 < global_get_time_by_date(iter_22_1.time) then
			var_22_0 = global_get_time_by_date(iter_22_1.time)
		end
	end

	if ((arg_22_2 == var_0_7.Auto or nil) and self:judgeOpenTime(var_22_0)) == true then
		self:judgeOpenType(arg_22_1, arg_22_2, arg_22_3)
	else
		LayerManager:removePopLayer(self.__queueindex)

		if arg_22_3 then
			arg_22_3()
		end
	end
end

function PublishnoticeLayer:judgeOpenType(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = self:rankNoticeTable(arg_23_1)

	local function var_23_1(arg_24_0)
		for iter_24_0 = 1, #arg_24_0 do
			arg_24_0[iter_24_0].read = var_0_8
		end

		return arg_24_0
	end

	var_23_0.Activity.isStick = var_23_1(var_23_0.Activity.isStick)
	var_23_0.Activity.noStick = var_23_1(var_23_0.Activity.noStick)
	var_23_0.Game.isStick = var_23_1(var_23_0.Game.isStick)
	var_23_0.Game.noStick = var_23_1(var_23_0.Game.noStick)

	local var_23_2 = RoleDefault:getInstance():getIntegerForKey("ReadNoticeNum", 0)

	if not var_23_2 then
		var_23_2 = 0

		RoleDefault:getInstance():setIntegerForKey("ReadNoticeNum", 0)
		RoleDefault:getInstance():flush()
	end

	self.newActCount = 0
	self.newGameCount = 0

	local var_23_3 = os.time()

	if var_23_2 ~= 0 then
		for iter_23_0 = 1, var_23_2 do
			local var_23_4 = RoleDefault:getInstance():getIntegerForKey("ReadNoticeNo" .. iter_23_0, 0)
			local var_23_5

			var_23_5, var_23_0.Activity.isStick = self:notice_compare(false, var_23_4, var_23_0.Activity.isStick)

			if var_23_5 == false then
				var_23_5, var_23_0.Activity.noStick = self:notice_compare(var_23_5, var_23_4, var_23_0.Activity.noStick)
			end

			if var_23_5 == false then
				var_23_5, var_23_0.Game.isStick = self:notice_compare(var_23_5, var_23_4, var_23_0.Game.isStick)
			end

			if var_23_5 == false then
				var_23_5, var_23_0.Game.noStick = self:notice_compare(var_23_5, var_23_4, var_23_0.Game.noStick)
			end

			if var_23_5 == false then
				print("missing match")
				RoleDefault:getInstance():setIntegerForKey("ReadNoticeNo" .. iter_23_0, 0)
				RoleDefault:getInstance():flush()
			end
		end

		local var_23_6 = {}

		local function var_23_7(arg_25_0)
			local var_25_0 = 0

			for iter_25_0 = 1, #arg_25_0 do
				if arg_25_0[iter_25_0].read == var_0_8 and global_get_time_by_date(arg_25_0[iter_25_0].time) > playermodel.create_time then
					var_25_0 = var_25_0 + 1
				end
			end

			return var_25_0
		end

		var_23_6[1] = var_23_7(var_23_0.Activity.isStick)
		var_23_6[2] = var_23_7(var_23_0.Activity.noStick)
		var_23_6[3] = var_23_7(var_23_0.Game.isStick)
		var_23_6[4] = var_23_7(var_23_0.Game.noStick)
		var_23_6.activity = var_23_6[1] + var_23_6[2]
		var_23_6.game = var_23_6[3] + var_23_6[4]
		self.newActCount = var_23_6[1] + var_23_6[2]
		self.newGameCount = var_23_6[3] + var_23_6[4]
		ReadAllNotice = var_23_6[1] + var_23_6[2] + var_23_6[3] + var_23_6[4] == 0 and 0 or 1

		if arg_23_2 and arg_23_2 == var_0_7.Auto then
			if ReadAllNotice == 1 then
				print("自动打开公告")
				RoleDefault:getInstance():setIntegerForKey("Open_time", var_23_3)
				RoleDefault:getInstance():flush()
				self:init(var_23_0, var_23_6.activity, var_23_6.game, arg_23_3)
			else
				print("不自动打开公告")
				LayerManager:removePopLayer(self.__queueindex)

				if arg_23_3 then
					arg_23_3()
				end
			end
		elseif arg_23_2 and arg_23_2 == var_0_7.Hand then
			RoleDefault:getInstance():setIntegerForKey("Open_time", var_23_3)
			RoleDefault:getInstance():flush()
			self:init(var_23_0, var_23_6.activity, var_23_6.game, arg_23_3)
			AnalyticManager.enterNotice()
		end
	else
		local var_23_8 = 0
		local var_23_9 = 0

		if next(var_23_0.Activity.isStick) ~= nil or next(var_23_0.Activity.noStick) ~= nil then
			var_23_8 = 0
		end

		if next(var_23_0.Game.isStick) ~= nil or next(var_23_0.Game.noStick) ~= nil then
			var_23_9 = 0
		end

		print("打开公告")
		RoleDefault:getInstance():setIntegerForKey("Open_time", var_23_3)
		RoleDefault:getInstance():flush()
		self:init(var_23_0, var_23_8, var_23_9, arg_23_3)
	end
end

function PublishnoticeLayer.judgeOpenTime(arg_26_0, arg_26_1)
	local var_26_2 = RoleDefault:getInstance()
	local var_26_3 = var_26_2:getIntegerForKey("Open_time", 0)
	local var_26_4 = os.date("*t", var_26_3)
	local var_26_5 = os.date("*t")

	if ((var_26_2.year < var_26_5.year or var_26_4.month < var_26_5.month or var_26_4.day < var_26_5.day or nil) and false) == false or ((var_26_3 < arg_26_1 or nil) and true) == true then
		return true
	else
		return false
	end
end

function PublishnoticeLayer:rankNoticeTable(arg_27_1)
	local var_27_0 = {
		Activity = {
			isStick = {},
			noStick = {}
		},
		Game = {
			isStick = {},
			noStick = {}
		}
	}

	for iter_27_0 = 1, #arg_27_1 do
		if cc.FileUtils:getInstance():isFileExist("mainScenebg/announcement/" .. string.match(arg_27_1[iter_27_0].title, "(.+)#") .. ".png") then
			if arg_27_1[iter_27_0].noticetype == var_0_13[1] or arg_27_1[iter_27_0].noticetype == var_0_13[2] then
				var_27_0.Activity = self:rankByStick(arg_27_1[iter_27_0], var_27_0.Activity, var_0_13)
			elseif arg_27_1[iter_27_0].noticetype == var_0_14[1] or arg_27_1[iter_27_0].noticetype == var_0_14[2] then
				var_27_0.Game = self:rankByStick(arg_27_1[iter_27_0], var_27_0.Game, var_0_14)
			end
		end
	end

	return var_27_0
end

function PublishnoticeLayer:rankByStick(arg_28_1, arg_28_2, arg_28_3)
	if arg_28_1.noticetype == arg_28_3[var_0_11] then
		arg_28_2.isStick = self:rankByTime(arg_28_1, arg_28_2.isStick)
	elseif arg_28_1.noticetype == arg_28_3[var_0_12] then
		arg_28_2.noStick = self:rankByTime(arg_28_1, arg_28_2.noStick)
	end

	return arg_28_2
end

function PublishnoticeLayer.rankByTime(arg_29_0, arg_29_1, arg_29_2)
	if next(arg_29_2) == nil then
		table.insert(arg_29_2, arg_29_1)
	else
		local var_29_0 = global_get_time_by_date(arg_29_1.time)

		for iter_29_0 = 1, #arg_29_2 do
			if tonumber((global_get_time_by_date(arg_29_2[iter_29_0].time))) < tonumber(var_29_0) then
				table.insert(arg_29_2, iter_29_0, arg_29_1)

				break
			end

			if iter_29_0 == #arg_29_2 then
				table.insert(arg_29_2, arg_29_1)
			end
		end
	end

	return arg_29_2
end

function PublishnoticeLayer.modifyTable(arg_30_0, arg_30_1)
	print("修改表")

	local var_30_0 = {}

	for iter_30_0 = 1, #arg_30_1 do
		if arg_30_1[iter_30_0] and arg_30_1[iter_30_0].noticetype ~= 2 then
			var_30_0[iter_30_0] = arg_30_1[iter_30_0]
		else
			break
		end
	end

	return var_30_0
end

function PublishnoticeLayer.restoreNoticeId(arg_31_0, arg_31_1)
	local var_31_0 = false
	local var_31_1 = RoleDefault:getInstance():getIntegerForKey("ReadNoticeNum", 0)
	local var_31_2 = 0

	for iter_31_0 = 1, var_31_1 do
		ret = RoleDefault:getInstance():getIntegerForKey("ReadNoticeNo" .. iter_31_0, 0)

		if ret == arg_31_1 then
			var_31_0 = true
		elseif ret == 0 then
			var_31_2 = iter_31_0
		end
	end

	if var_31_0 == false then
		if var_31_2 == 0 then
			RoleDefault:getInstance():setIntegerForKey("ReadNoticeNum", var_31_1 + 1)
			RoleDefault:getInstance():flush()
			RoleDefault:getInstance():setIntegerForKey("ReadNoticeNo" .. var_31_1 + 1, arg_31_1)
			RoleDefault:getInstance():flush()
		else
			RoleDefault:getInstance():setIntegerForKey("ReadNoticeNo" .. var_31_2, arg_31_1)
			RoleDefault:getInstance():flush()
		end
	end
end

function PublishnoticeLayer:initBg(arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = ccui.Layout:create()

	var_32_0:setTouchEnabled(true)
	var_32_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_32_0:setAnchorPoint(cc.p(0, 0))
	var_32_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_32_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(var_32_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_33_0)
		self:addChild(arg_33_0, -2)
		arg_33_0:setPositionY(arg_33_0:getPositionY() - GameDisplay.fix_y)

		local var_33_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_33_0:setAnchorPoint(cc.p(0, 0))
		var_33_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_33_0, -1)
		self:OpenNotice(arg_32_1, arg_32_2, arg_32_3)
		var_32_0:setTouchEnabled(false)
	end)
end

function PublishnoticeLayer.exit(arg_34_0)
	LayerManager:removePopLayer()
end
