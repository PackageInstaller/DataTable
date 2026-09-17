FriendListLayer = class("FriendListLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")
local var_0_3 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local TempWidget = require("view.Sprite.TempWidget")

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Layer.BattleArrayLayerNew")
require("view.Sprite.AvatarSprite")

local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local audio_manager = require("controller.audio_manager")
local item_manager = require("controller.item_manager")
local friend_system_manager = require("controller.friend_system_manager")
local activity_manager = require("controller.activity_manager")
local levelmode_data = require("data.levelmode_data")
local var_0_14 = require("data.item_data")
local time_check_manager = require("controller.time_check_manager")
local var_0_17
local var_0_18 = 618
local var_0_19 = 156
local var_0_20 = {
	get = {
		off = "friendsystem/info_btn_get_off.png",
		on = "friendsystem/info_btn_get_light.png"
	},
	send = {
		off = "friendsystem/info_btn_send_off.png",
		on = "friendsystem/info_btn_send_light.png"
	}
}
local var_0_21 = {
	online = cc.c3b(0, 255, 18),
	offline = cc.c3b(133, 133, 133)
}

function FriendListLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = FriendListLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function FriendListLayer:init(arg_3_1)
	var_0_17 = self

	TopcostLayer.getInstance():hideTopcostLayer()

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "FriendListLayer.json" or "FriendListLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.no_data_img = ccui.Helper:seekWidgetByName(self.rootLayer, "img_nofriend")

	self.no_data_img:setVisible(false)
	self.no_data_img:setPositionY(568 + GameDisplay.fix_y)

	if arg_3_1 then
		self.callback = arg_3_1.callback or nil
	end

	self:initTile()
	self:initBottomList()
	self:createTableView()
	self:getListData()
	self:registerActivityEventListener()
	self:registerTimeCheckEvent()
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_17 = nil

			activity_manager:releaseEventListenerByName("FriendListLayer")

			if self.callback then
				self.callback()
			end
		end
	end)
end

function FriendListLayer:initTile()
	self.titleSprite = TitleSprite:create("friendsystem/list_title.png", 2, "friendsystem/list_tile_bg.png")

	self.titleSprite:setPosition(0, 1136 + GameDisplay.fix_y * 2 - self.titleSprite:getContentSize().height)
	self.titleSprite:setName("title_sprite")
	self.rootLayer:addChild(self.titleSprite, 25)

	self.info_btn = ccui.Button:create("friendsystem/new_weihao.png", nil, "friendsystem/new_weihao.png", var_0_3)

	self.info_btn:setPosition(cc.p(self.titleSprite:getContentSize().width / 2 - 80, self.titleSprite:getContentSize().height / 2 + 9))
	self.titleSprite:addChild(self.info_btn)
	self.info_btn:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_6_0 = {
			callback = callback
		}

		var_6_0.key = "friend_system"

		if not require("data.detail_data")[var_6_0.key] then
			print("error:----------------> detail_data.lua is no data for this layer  找策划填写规则表")
		else
			LayerManager:pushInLayer("PopActivityDetail", var_6_0)
		end
	end)

	local var_5_0 = ccui.Layout:create()

	var_5_0:setContentSize(cc.size(110, 34))
	var_5_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_5_0:setAnchorPoint(0, 0)
	var_5_0:setPosition(cc.p(self.titleSprite:getContentSize().width - var_5_0:getContentSize().width - 30, self.titleSprite:getContentSize().height / 2 - var_5_0:getContentSize().height / 2))
	var_5_0:setCascadeOpacityEnabled(false)
	var_5_0:setBackGroundImage("friendsystem/info_corn_friend_di.png", var_0_3)
	var_5_0:setTouchEnabled(false)
	var_5_0:setName("frned_point_layer")
	self.titleSprite:addChild(var_5_0)

	self.friend_point = cc.Label:createWithTTF("0", "fonts/number.ttf", 24)

	self.friend_point:setAnchorPoint(cc.p(0, 0.5))
	self.friend_point:setPosition(cc.p(var_5_0:getContentSize().width / 2 + 14, var_5_0:getContentSize().height / 2))
	var_5_0:addChild(self.friend_point)
end

function FriendListLayer.registerActivityEventListener(arg_7_0)
	activity_manager:registerEventListener("FriendListLayer", activity_manager.activityEventId.FRIEND_NEW_APPLY_NOTICE, function(arg_8_0)
		arg_7_0:updateBtnAlert()
	end)
	activity_manager:registerEventListener("FriendListLayer", activity_manager.activityEventId.FRIEND_NEW_Gift_NOTICE, function(arg_9_0)
		arg_7_0:updateGetAllAlert()
		arg_7_0:updateGiftStatus(arg_9_0, true)

		if arg_9_0 then
			arg_7_0.roleTableView:reloadData()
		end
	end)
end

function FriendListLayer:initBottomList()
	local var_10_0 = BottomBtnList:create(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("MainLayer")
	end)

	var_10_0:setName("bottomlist")

	self.bottomList = var_10_0

	self.bottomList:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(var_10_0, 10)
	self:initBottomAddPanel()
end

function FriendListLayer:updateBtnAlert()
	if RoleDefault:getInstance():getBoolForKey("NewFriendApplyHave", false) and self.btn_manage then
		global_add_alert_tag(self.btn_manage, (cc.p(164, 70)))
	elseif self.btn_manage then
		global_remove_alert_tag(self.btn_manage)
	end
end

function FriendListLayer:initBottomAddPanel()
	local var_13_0 = ccui.Layout:create()

	var_13_0:setPosition(cc.p(320, 30))
	var_13_0:setName("bottomAddPanel")

	self.bottomlayer = var_13_0

	self.bottomList:addChild(var_13_0)

	self.btn_getall = ccui.Button:create("friendsystem/list_btn_get_all_gift.png", nil, "friendsystem/list_btn_get_all_gift.png", var_0_3)

	self.btn_getall:setPosition(cc.p(240, 0))
	self.bottomlayer:addChild(self.btn_getall)
	self.btn_getall:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_14_0:isBright() then
			return
		end

		arg_14_0:setBright(false)
		friend_system_manager:friend_gift_opt(3, nil, function(arg_15_0)
			if arg_15_0.result == 1 then
				if not var_0_17 then
					return
				end

				RoleDefault:getInstance():setBoolForKey("NewFriendGiftHave", false)

				if arg_15_0.items and arg_15_0.items[1] and arg_15_0.items[1].itemcount then
					global_ShowBlockWords(string.format(L_FRIEND_SYSTEM.get_award_success, arg_15_0.items[1].itemcount - friend_system_manager:getLastFriendNum()))
				elseif arg_15_0.list and next(arg_15_0.list) then
					global_ShowBlockWords(L_FRIEND_SYSTEM.send_all_gift)
				else
					global_ShowBlockWords(L_FRIEND_SYSTEM.no_get_or_send_gift)
				end

				if arg_15_0.items and next(arg_15_0.items) or arg_15_0.list and next(arg_15_0.list) then
					self:updateGetAllAlert()
					self:updateGiftStatus(arg_15_0.list)
					self:updateFriendPoint()
					self.roleTableView:reloadData()
				end
			elseif arg_15_0.result == 2 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.operate_fail)
			elseif arg_15_0.result == 3 then
				global_ShowBlockWords(L_FRIEND_SYSTEM.get_fail)
			else
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.operate_fail)
			end

			arg_14_0:setBright(true)
		end)
	end)

	local var_13_1 = ccui.Button:create("friendsystem/list_btn_manage.png", nil, "friendsystem/list_btn_manage.png", var_0_3)

	var_13_1:setPosition(cc.p(self.btn_getall:getPositionX() - self.btn_getall:getContentSize().width / 2 - var_13_1:getContentSize().width / 2, self.btn_getall:getPositionY()))
	self.bottomlayer:addChild(var_13_1)

	self.btn_manage = var_13_1

	self:updateBtnAlert()
	var_13_1:addTouchEventListener(function(arg_16_0, arg_16_1)
		local var_16_0

		if arg_16_1 ~= ccui.TouchEventType.ended then
			do return end

			var_16_0 = {}
		end

		function var_16_0.callback(...)
			if var_0_17 then
				self:getListData()
				self:updateBtnAlert()
			end
		end

		LayerManager:pushInLayer("PopFriendManagementLayer", var_16_0)
	end)

	if self.bottomlayer:getChildByName("self.friendnum1") then
		self.bottomlayer:getChildByName("self.friendnum1"):removeFromParent()
	end

	if self.bottomlayer:getChildByName("self.friendnum2") then
		self.bottomlayer:getChildByName("self.friendnum2"):removeFromParent()
	end

	if self.bottomlayer:getChildByName("self.friendnum3") then
		self.bottomlayer:getChildByName("self.friendnum3"):removeFromParent()
	end

	self.friendnum1 = cc.Label:createWithTTF("", "fonts/number.ttf", 18)

	self.friendnum1:setAnchorPoint(cc.p(1, 0.5))
	self.friendnum1:setColor(cc.c3b(170, 212, 231))
	self.friendnum1:setName("self.friendnum1")
	self.friendnum1:setPosition(cc.p(self.bottomlayer:getContentSize().width / 2 - 30, self.bottomlayer:getContentSize().height / 2))
	self.bottomlayer:addChild(self.friendnum1)

	self.friendnum2 = cc.Label:createWithTTF("", "fonts/number.ttf", 18)

	self.friendnum2:setAnchorPoint(cc.p(1, 0.5))
	self.friendnum2:setColor(cc.c3b(170, 212, 231))
	self.friendnum2:setName("self.friendnum2")
	self.friendnum2:setPosition(cc.p(self.friendnum1:getPositionX() - self.friendnum1:getContentSize().width, self.friendnum1:getPositionY()))
	self.bottomlayer:addChild(self.friendnum2)

	self.friendnum3 = cc.Label:createWithTTF("", "fonts/number.ttf", 18)

	self.friendnum3:setAnchorPoint(cc.p(1, 0.5))
	self.friendnum3:setColor(cc.c3b(170, 212, 231))
	self.friendnum3:setName("self.friendnum3")
	self.friendnum3:setPosition(cc.p(self.friendnum2:getPositionX() - self.friendnum2:getContentSize().width, self.friendnum2:getPositionY()))
	self.bottomlayer:addChild(self.friendnum3)
end

function FriendListLayer:createTableView()
	if self.rootLayer:getChildByName("self.roleTableView") then
		self.rootLayer:getChildByName("self.roleTableView"):removeFromParent()
	end

	local var_18_0 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.roleTableView = cc.TableView:create(cc.size(640, 1000 + var_18_0))

	self.roleTableView:setPosition(cc.p(0, 90))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rootLayer:setName("self.roleTableView")

	self.roleTableViewhight = 1000 + var_18_0

	self.roleTableView:setVisible(false)
end

function FriendListLayer:updateFriendLabel(arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1 or ""
	arg_19_2 = arg_19_2 or ""

	if arg_19_1 == "" or arg_19_2 == "" then
		-- block empty
	end

	self.friendnum1:setString("/" .. arg_19_2)
	self.friendnum2:setString("" .. arg_19_1)
	self.friendnum3:setString(L_FRIEND_LISTLAYER.friend_num)
	self.friendnum2:setPositionX(self.friendnum1:getPositionX() - self.friendnum1:getContentSize().width)
	self.friendnum3:setPositionX(self.friendnum2:getPositionX() - self.friendnum2:getContentSize().width)
end

function FriendListLayer:createNode()
	local var_20_0 = self.items:clone()
	local var_20_1 = AvatarSprite:create(tonumber(9200101))

	var_20_1:setPosition(cc.p(30, var_20_0:getContentSize().height / 2 - 60))
	var_20_1:setName("avatar_face_fl")
	var_20_1:setScale(0.75)
	var_20_0:addChild(var_20_1)

	return var_20_0
end

function FriendListLayer:updateNode(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = ccui.Helper:seekWidgetByName(arg_21_1, "player_name")
	local var_21_1 = ccui.Helper:seekWidgetByName(arg_21_1, "level")
	local var_21_2 = ccui.Helper:seekWidgetByName(arg_21_1, "power")
	local var_21_3 = ccui.Helper:seekWidgetByName(arg_21_1, "btn_get")
	local var_21_4 = ccui.Helper:seekWidgetByName(arg_21_1, "btn_send")

	var_21_0:setString(arg_21_2.name)
	var_21_1:setString("等级." .. arg_21_2.level)
	var_21_1:setColor(cc.c3b(255, 255, 255))
	var_21_2:setString(global_trans_bitmapnumber(arg_21_2.fightpower))
	var_21_2:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	self:createFace(arg_21_1, arg_21_2.head_sculpture, arg_21_2.playerid, arg_21_2.lastlogin, arg_21_3)
	self:updatePlayerImage(ccui.Helper:seekWidgetByName(arg_21_1, "class_img"), arg_21_2.class)
	self:initGiftBtn(arg_21_1, arg_21_2.gift, arg_21_2.playerid, arg_21_3)
	self:dealWithTheChageBtn(ccui.Helper:seekWidgetByName(arg_21_1, "Button_106"), arg_21_2.playerid, arg_21_2.name, arg_21_2.fightpower)

	local var_21_5 = var_21_0:getParent()

	if not var_21_5:getChildByName("player_privilege") then
		local var_21_6 = TempWidget:CreateTempImg("friendsystem/privilege_img.png", var_21_5)

		var_21_6:setAnchorPoint((var_21_0:getAnchorPoint()))
		var_21_6:setName("player_privilege")
	end

	local var_21_7 = var_21_5:getChildByName("player_privilege")

	if arg_21_2.subscribe and arg_21_2.subscribe > time_check_manager:getCurTime() then
		var_21_7:setPosition(cc.p(var_21_0:getPositionX() + var_21_0:getContentSize().width + 10, var_21_0:getPositionY()))
		var_21_7:show()
	else
		var_21_7:hide()
	end
end

function FriendListLayer.dealWithTheChageBtn(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if not arg_22_1 then
		return
	end

	arg_22_1.playerid = arg_22_2
	arg_22_1.name = arg_22_3
	arg_22_1.fightpower = arg_22_4

	arg_22_1:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_23_0:isBright() then
			return
		end

		arg_23_0:setBright(false)
		friend_system_manager:get_someone_array_fightdata(arg_23_0.playerid, function(arg_24_0, arg_24_1)
			if not var_0_17 then
				return
			end

			if arg_24_0 and type(arg_24_0) == "table" then
				LayerManager:pushInLayer("PopShowScoreArenaEnemyArray", {
					enemysData = arg_24_0,
					playerid = arg_23_0.playerid,
					friendfight = CONFIG_TYPE_FRIEND_FIGHT,
					friendname = arg_22_3,
					fightpoint = arg_24_1
				})
			end

			arg_23_0:setBright(true)
		end)
	end)
end

function FriendListLayer:initGiftBtn(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = ccui.Helper:seekWidgetByName(arg_25_1, "btn_get")
	local var_25_1 = ccui.Helper:seekWidgetByName(arg_25_1, "btn_send")

	var_25_0:setPositionX(510)
	var_25_1:setPositionX(570)

	if not arg_25_1 or not arg_25_3 or not arg_25_2 then
		var_25_0:setVisible(false)
		var_25_1:setVisible(false)

		return
	end

	local var_25_2, var_25_3, var_25_4 = self:analysisByte(arg_25_2)

	if var_25_4 == 1 then
		var_25_1:loadTextures(var_0_20.send.off, nil, var_0_20.send.off, var_0_3)
		var_25_1:setEnabled(false)
	else
		var_25_1:loadTextures(var_0_20.send.on, nil, var_0_20.send.on, var_0_3)
		var_25_1:setEnabled(true)
	end

	if var_25_3 == 1 and var_25_2 == 0 then
		var_25_0:loadTextures(var_0_20.get.on, nil, var_0_20.get.on, var_0_3)
		var_25_0:setEnabled(true)
		var_25_0:setVisible(true)
	elseif var_25_3 == 0 then
		var_25_0:setVisible(false)
	else
		var_25_0:loadTextures(var_0_20.get.off, nil, var_0_20.get.off, var_0_3)
		var_25_0:setEnabled(false)
		var_25_0:setVisible(true)
	end

	if var_25_0:isVisible() then
		ccui.Helper:seekWidgetByName(arg_25_1, "Button_106"):setPositionX(448)
	else
		ccui.Helper:seekWidgetByName(arg_25_1, "Button_106"):setPositionX(510)
	end

	var_25_1:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_26_0:isBright() then
			return
		end

		arg_26_0:setBright(false)
		friend_system_manager:friend_gift_opt(2, arg_25_3, function(arg_27_0)
			if not var_0_17 then
				return
			end

			if arg_27_0.result == 1 then
				global_ShowBlockWords(L_FRIEND_SYSTEM.send_gift_success)
				self:updateGiftStatus(arg_27_0.list)
				self:updateShowCell(arg_25_4)
				friend_system_manager:get_friend_max_num()
			elseif arg_27_0.result == 2 then
				global_ShowBlockWords(L_FRIEND_SYSTEM.send_fail)
			elseif arg_27_0.result == 3 then
				global_ShowBlockWords(L_FRIEND_SYSTEM.send_fail)
			else
				global_ShowBlockWords(L_FRIEND_SYSTEM.send_fail)
			end

			arg_26_0:setBright(true)
		end)
	end)
	var_25_0:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_28_0:isBright() then
			return
		end

		arg_28_0:setBright(false)
		friend_system_manager:friend_gift_opt(1, arg_25_3, function(arg_29_0)
			if not var_0_17 then
				return
			end

			if arg_29_0.result == 1 then
				global_ShowBlockWords(string.format(L_FRIEND_SYSTEM.get_award_success, 1))
				self:updateFriendPoint()
				self:updateGiftStatus(arg_29_0.list)
				self:updateShowCell(arg_25_4)
				self:updateFriendPoint()
				friend_system_manager:get_friend_max_num()
			elseif arg_29_0.result == 2 then
				global_ShowBlockWords(L_FRIEND_SYSTEM.get_fail)
			elseif arg_29_0.result == 3 then
				global_ShowBlockWords(L_FRIEND_SYSTEM.get_fail)
			elseif arg_29_0.result == 4 then
				global_ShowBlockWords(L_FRIEND_SYSTEM.get_gift_limit)
			else
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.operate_fail)
			end

			arg_28_0:setBright(true)
		end)
	end)
end

function FriendListLayer.analysisByte(arg_30_0, arg_30_1)
	local var_30_0 = 0
	local var_30_1 = 0
	local var_30_2 = 0

	for iter_30_0 = 0, 1 do
		for iter_30_1 = 0, 1 do
			for iter_30_2 = 0, 1 do
				if iter_30_0 * 4 + iter_30_1 * 2 + iter_30_2 == arg_30_1 then
					var_30_2 = iter_30_2
					var_30_1 = iter_30_1
					var_30_0 = iter_30_0

					break
				end
			end
		end
	end

	return var_30_0, var_30_1, var_30_2
end

function FriendListLayer:updateFriendPoint()
	self.friend_point:setString(global_trans_number(friend_system_manager:getPlayerFriendCurrency()))
end

function FriendListLayer:updateGiftStatus(arg_32_1, arg_32_2)
	if not arg_32_1 or not next(arg_32_1) then
		return
	end

	if not arg_32_2 then
		for iter_32_0, iter_32_1 in pairs(arg_32_1) do
			for iter_32_2, iter_32_3 in pairs(self.data) do
				if iter_32_1.playerid == iter_32_3.playerid then
					iter_32_3.gift = iter_32_1.gift

					break
				end
			end
		end
	else
		for iter_32_4, iter_32_5 in pairs(self.data) do
			if iter_32_5.playerid == arg_32_1.playerid then
				iter_32_5.gift = arg_32_1.gift
			end
		end
	end
end

function FriendListLayer:updateShowCell(arg_33_1)
	if not arg_33_1 or not self.roleTableView or not next(self.data) then
		return
	end

	local var_33_0, var_33_1 = GetTableViewShowCellIdx(self.roleTableView, {
		cellsize = cc.size(var_0_18, var_0_19),
		maxcount = #self.data
	})

	if var_33_0 <= arg_33_1 and arg_33_1 <= var_33_1 then
		self.roleTableView:updateCellAtIndex(arg_33_1)
	end
end

function FriendListLayer:updateGetAllAlert()
	if RoleDefault:getInstance():getBoolForKey("NewFriendGiftHave", false) and self.btn_getall then
		global_add_alert_tag(self.btn_getall, (cc.p(190, 70)))
	elseif self.btn_getall then
		global_remove_alert_tag(self.btn_getall)
	end
end

function FriendListLayer.createFace(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5)
	if not arg_35_1 or not arg_35_2 or not arg_35_3 then
		return
	end

	local var_35_0 = arg_35_1:getChildByName("avatar_face_fl")

	var_35_0:switchShowAvatar(tonumber(arg_35_2))
	var_35_0:addTouchEventListener(function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_36_0

		if arg_35_3 <= 0 then
			do return end

			var_36_0 = {
				layerName = "FriendListLayer",
				playeruid = arg_35_3
			}
		end

		function var_36_0.callback(...)
			if var_0_17 then
				arg_35_0:getListData(arg_35_5)
			end
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_36_0)
	end)

	if arg_35_1:getChildByName("onlinetime_label") then
		arg_35_1:getChildByName("onlinetime_label"):removeFromParent()
	end

	local var_35_1 = cc.Label:createWithTTF("", "fonts/number.ttf", 18)

	var_35_1:setAnchorPoint(cc.p(1, 0.5))
	var_35_1:setPosition(cc.p(arg_35_1:getContentSize().width - 20, arg_35_1:getContentSize().height / 2 + 30))
	var_35_1:setName("onlinetime_label")
	arg_35_1:addChild(var_35_1)
	var_35_1:setString(friend_system_manager:dealTheOnlineTime(arg_35_4))

	if arg_35_4 == "-1" then
		var_35_1:setColor(var_0_21.online)
	else
		var_35_1:setColor(var_0_21.offline)
	end
end

function FriendListLayer.updatePlayerImage(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0

	if arg_38_2 == 5 then
		var_38_0 = "TopcostLayer/new_doctor.png"
	elseif arg_38_2 == 4 then
		var_38_0 = "TopcostLayer/new_master.png"
	elseif arg_38_2 == 3 then
		var_38_0 = "TopcostLayer/new_Univ.png"
	elseif arg_38_2 == 2 then
		var_38_0 = "TopcostLayer/new_Senior.png"
	elseif arg_38_2 == 1 then
		var_38_0 = "TopcostLayer/new_Junior.png"
	end

	arg_38_1:loadTexture(var_38_0, var_0_3)
end

function FriendListLayer:initTableView(arg_39_1)
	self.roleTableView:registerScriptHandler(function(arg_41_0, arg_41_1)
		return var_0_18, var_0_19
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_40_0, arg_40_1)
		local var_40_0 = arg_40_0:dequeueCell()

		if not var_40_0 then
			var_40_0 = cc.TableViewCell:create()

			local var_40_1 = self:createNode()

			var_40_1:setName("node")
			var_40_1:setPosition(cc.p(10, -10))
			self:updateNode(var_40_1, self.data[arg_40_1 + 1], arg_40_1)

			if arg_40_1 <= math.floor(self.roleTableViewhight / var_0_19) then
				var_40_1:setOpacity(0)
				var_40_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_40_1), cc.FadeIn:create(0.1)))
			else
				var_40_1:setOpacity(255)
			end

			var_40_0:addChild(var_40_1)
		else
			local var_40_2 = var_40_0:getChildByName("node")

			var_40_2:setOpacity(255)
			self:updateNode(var_40_2, self.data[arg_40_1 + 1], arg_40_1)
		end

		return var_40_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_42_0, arg_42_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()

	if arg_39_1 then
		local var_39_0 = math.ceil(self.roleTableViewhight / var_0_19)

		if var_39_0 >= arg_39_1 + 1 or var_39_0 >= #self.data then
			return
		elseif arg_39_1 > 0 and self.data[arg_39_1] then
			local var_39_1 = (arg_39_1 - 1) * (100 / (#self.data - self.roleTableViewhight / 155))

			if (arg_39_1 - 1) * (100 / (#self.data - self.roleTableViewhight / 155)) < 0 then
				var_39_1 = 0
			elseif var_39_1 > 100 then
				var_39_1 = 100
			end

			self.roleTableView:scrollToPercent(var_39_1, 0, false)
		end
	end
end

function FriendListLayer:initListInfo(arg_43_1)
	self.data = self:sortByOnlinetime(arg_43_1)

	if self.data and next(self.data) then
		self:holdOrOpenPanel(true)
		self:initTableView(self.jumpindex)

		if self.btn_getall then
			self.btn_getall:setVisible(true)
		end

		friend_system_manager:get_friend_max_num(function(arg_44_0)
			if not var_0_17 then
				return
			end

			self:updateFriendLabel(#self.data, arg_44_0.maxfriend)
			self:updateFriendPoint()
		end)
	else
		if self.btn_getall then
			self.btn_getall:setVisible(false)
		end

		self:holdOrOpenPanel(false)
		friend_system_manager:get_friend_max_num(function(arg_45_0)
			if not var_0_17 then
				return
			end

			self:updateFriendLabel(0, arg_45_0.maxfriend)
		end)
	end

	self:updateGetAllAlert()
	self:updateFriendPoint()
end

function FriendListLayer.getListData(arg_46_0, arg_46_1)
	arg_46_0.jumpindex = arg_46_1

	friend_system_manager:resetFriendListParam()
	friend_system_manager:get_friend_list(1, 200, function(arg_47_0, arg_47_1)
		if not var_0_17 then
			return
		end

		if arg_47_0 == 1 and type(arg_46_0.initListInfo) == "function" then
			arg_46_0:initListInfo(arg_47_1)
		end
	end)
end

function FriendListLayer:holdOrOpenPanel(arg_48_1)
	self.roleTableView:setVisible(arg_48_1)
	self.no_data_img:setVisible(not arg_48_1)
end

function FriendListLayer.sortByOnlinetime(arg_49_0, arg_49_1)
	if not arg_49_1 or not next(arg_49_1) then
		return
	end

	local var_49_0 = {}
	local var_49_1 = {}
	local var_49_2 = {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		if iter_49_1.lastlogin == "-1" then
			table.insert(var_49_0, iter_49_1)
		else
			table.insert(var_49_1, iter_49_1)
		end
	end

	for iter_49_2, iter_49_3 in ipairs(var_49_0) do
		table.insert(var_49_2, iter_49_3)
	end

	if next(var_49_1) then
		table.sort(var_49_1, function(arg_50_0, arg_50_1)
			return global_get_time_by_date(arg_50_0.lastlogin) > global_get_time_by_date(arg_50_1.lastlogin)
		end)

		for iter_49_4, iter_49_5 in ipairs(var_49_1) do
			table.insert(var_49_2, iter_49_5)
		end
	end

	return var_49_2
end

function FriendListLayer.fullScreen(arg_51_0, arg_51_1)
	arg_51_1:setContentSize((GameDisplay.getScreenSize()))
	arg_51_1:setPositionY(arg_51_1:getPositionY() - GameDisplay.fix_y)
end

function FriendListLayer:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_53_0)
		if not var_0_17 then
			return
		end

		if arg_53_0.eventType == NEXT_DAY then
			playermodel:getServerTime(function()
				self:getListData()
			end)
		end
	end), self)
end

function FriendListLayer.delectChatData(arg_55_0, arg_55_1)
	if not arg_55_1 then
		return
	end

	chatSystemManage:clearLocalChatDataByPlayerid(arg_55_1, "chat_cachedata.txt", 1)
	chatSystemManage:clearLocalChatDataByPlayerid(arg_55_1, "recent_friend_chat_data.txt", 2)
end
