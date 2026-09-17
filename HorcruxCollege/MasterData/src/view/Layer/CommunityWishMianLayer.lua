CommunityWishMianLayer = class("CommunityWishMianLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")
require("view.Sprite.AvatarSprite")
require("view.Sprite.ConfirmDialogSprite")
require("view.Sprite.BottomBtnList")

local item_data = require("data.item_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_6
local var_0_7 = config._DEBUG and 0 or 1
local var_0_8 = "mainScenebg/commity_wish_bg.png"
local var_0_9 = {
	[100] = COMMUNITY_COMMUNITYVLOGLAYER.tips1,
	[90] = COMMUNITY_COMMUNITYVLOGLAYER.tips2,
	[10] = COMMUNITY_WISH_SYSTEM.tips17
}
local var_0_10 = {
	cc.c3b(103, 159, 238),
	(cc.c3b(32, 76, 139))
}
local var_0_11 = 640
local var_0_12 = 130

function CommunityWishMianLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = CommunityWishMianLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function CommunityWishMianLayer:init(arg_3_1)
	var_0_6 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "CommunityWishMianLayer.json" or "CommunityWishMianLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.backimg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_40")
	self.tablelayer = ccui.Helper:seekWidgetByName(self.rootLayer, "tablelayer")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "add_items")
	self.noneimg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_none")

	self.noneimg:getChildByName("Label_19"):setString(string.format(COMMUNITY_WISH_SYSTEM.tips41, "\"", "\""))
	self.noneimg:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.backimg:loadTexture(var_0_8)
	self.backimg:setAnchorPoint(cc.p(0, 1))
	self:initBottomList()
	self:fullScreen(self.rootLayer)
	self:createFilterBtn()
	self:getListData()
	self:registerActivityEventListener()
	self:registerTimeCheckEvent()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("CommunityWishMianLayer")

			var_0_6 = nil
		end
	end)
end

function CommunityWishMianLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("CommunityWishMianLayer", activity_manager.activityEventId.COMMUNITY_KICK_NOTICE, function(arg_6_0)
		if arg_6_0.familyid and var_0_6 and arg_5_0.familyid == arg_6_0.familyid then
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips7)
			LayerManager:switchShowLayer("joinCommunityLayer")
		end
	end)
	activity_manager:registerEventListener("CommunityWishMianLayer", activity_manager.activityEventId.COMMUNITY_WISH_NEW_AWARD, function(arg_7_0)
		if arg_7_0.tp and var_0_6 then
			arg_5_0:updateRecordRedStatus()
		end
	end)
end

function CommunityWishMianLayer:updateRecordRedStatus()
	if self.jzjl_btn then
		if community_system_manager:getRecordRedStatus() then
			global_add_alert_tag(self.jzjl_btn, {
				x = 144,
				y = 70
			})
		else
			global_remove_alert_tag(self.jzjl_btn)
		end
	end
end

function CommunityWishMianLayer:updateShowFilterAndActivity()
	if community_system_manager:checkIsHaveActivityWish() then
		if self.cjxy_btn then
			self.cjxy_btn:setVisible(true)
		end

		if self.flitbtn then
			self.flitbtn:setVisible(true)
		end
	else
		if self.cjxy_btn then
			self.cjxy_btn:setVisible(false)
		end

		if self.flitbtn then
			self.flitbtn:setVisible(false)
		end
	end
end

function CommunityWishMianLayer:updateDalyWishRedStatus()
	if cc.UserDefault:getInstance():getIntegerForKey("CommunityWishDailyTime", 0) < os.time() then
		cc.UserDefault:getInstance():setBoolForKey("CommunityWishDailyRed", true)
	else
		cc.UserDefault:getInstance():setBoolForKey("CommunityWishDailyRed", false)
	end

	if self.rcxy_btn then
		if cc.UserDefault:getInstance():getBoolForKey("CommunityWishDailyRed", false) then
			global_add_alert_tag(self.rcxy_btn, {
				x = 144,
				y = 70
			})
		else
			global_remove_alert_tag(self.rcxy_btn)
		end
	end
end

function CommunityWishMianLayer:updateBtnAlert()
	if not self.positon or not self.applybtn then
		return
	end

	if self.positon ~= 1 and self.positon ~= 2 then
		return
	end

	if community_system_manager:getApplyStatus() and self.applybtn then
		global_add_alert_tag(self.applybtn, (cc.p(206, 84)))
	else
		global_remove_alert_tag(self.applybtn)
	end
end

function CommunityWishMianLayer:createFilterBtn()
	self.flitbtn = ccui.Button:create("community_system/joinCommunityLayer/one_shaixuan.png", nil, "community_system/joinCommunityLayer/one_shaixuan.png", var_0_7)

	self.flitbtn:setPosition(cc.p(self.rootLayer:getContentSize().width - self.flitbtn:getContentSize().width / 2, self.rootLayer:getContentSize().height - self.flitbtn:getContentSize().height / 2 + 4))
	self.rootLayer:addChild(self.flitbtn, 10)
	self.flitbtn:addTouchEventListener(function(arg_13_0, arg_13_1)
		local var_13_0

		if arg_13_1 ~= ccui.TouchEventType.ended then
			do return end

			var_13_0 = {}
		end

		function var_13_0.callback()
			if var_0_6 and community_system_manager:getCommityWishList() and next(community_system_manager:getCommityWishList()) and self.tableview1 then
				self.wishdata = community_system_manager:filterComminityWishListData(community_system_manager:getCommityWishList())

				self.tableview1:reloadData()
			end
		end

		LayerManager:pushInLayer("PopCommunityWishFilterLayer", var_13_0)
	end)

	self.rulebtn = ccui.Button:create("community_system/communityMainLayer/tips.png", nil, "community_system/communityMainLayer/tips.png", var_0_7)

	self.rulebtn:setPosition(cc.p(self.rulebtn:getContentSize().width + 100, self.flitbtn:getPositionY() + 3))
	self.rulebtn:setScale(0.75)
	self.rootLayer:addChild(self.rulebtn, 10)
	self.rulebtn:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_15_0:setBright(false)

		local var_15_0 = {
			callback = function()
				if var_0_6 then
					arg_15_0:setBright(true)
				end
			end
		}

		var_15_0.key = "community_Wish_rule"

		if not require("data.detail_data")[var_15_0.key] then
			print("error:----------------> detail_data.lua is no data for this layer  找策划填写规则表")
		else
			LayerManager:pushInLayer("PopActivityDetail", var_15_0)
		end
	end)
	self:updateShowFilterAndActivity()
end

function CommunityWishMianLayer.getListData(arg_17_0, arg_17_1)
	community_system_manager:get_family_wish_info(function(arg_18_0)
		if var_0_6 and arg_18_0.result == 1 then
			arg_17_0.wishdata = community_system_manager:getCommityWishList()

			arg_17_0:initUI(arg_17_1)
		end
	end)
end

function CommunityWishMianLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self:addChild(self.bottomList, 100)

	local var_19_0 = ccui.Button:create("community_system/communityMainLayer/commity_wish_jzjl.png", nil, "community_system/communityMainLayer/commity_wish_jzjl.png", var_0_7)

	var_19_0:setPosition(cc.p(self.bottomList:getContentSize().width - var_19_0:getContentSize().width / 2 - 4, self.bottomList:getContentSize().height / 2))
	self.bottomList:addChild(var_19_0)

	self.jzjl_btn = var_19_0

	local var_19_1 = ccui.Button:create("community_system/communityMainLayer/commity_wish_rcxy.png", nil, "community_system/communityMainLayer/commity_wish_rcxy.png", var_0_7)

	var_19_1:setPosition(cc.p(var_19_0:getPositionX() - var_19_1:getContentSize().width / 2 - var_19_0:getContentSize().width / 2 - 4, var_19_0:getPositionY()))
	self.bottomList:addChild(var_19_1)

	self.rcxy_btn = var_19_1

	local var_19_2 = ccui.Button:create("community_system/communityMainLayer/commity_wish_cjxy.png", nil, "community_system/communityMainLayer/commity_wish_cjxy.png", var_0_7)

	var_19_2:setPosition(cc.p(var_19_1:getPositionX() - var_19_2:getContentSize().width / 2 - var_19_1:getContentSize().width / 2 - 4, var_19_0:getPositionY()))
	self.bottomList:addChild(var_19_2)

	self.cjxy_btn = var_19_2

	self.jzjl_btn:addTouchEventListener(function(arg_21_0, arg_21_1)
		local var_21_0

		if arg_21_1 ~= ccui.TouchEventType.ended then
			do return end

			var_21_0 = {}
		end

		function var_21_0.callback()
			if var_0_6 then
				self:updateRecordRedStatus()
			end
		end

		function var_21_0.frindcallback()
			if var_0_6 then
				self.wishdata = community_system_manager:getCommityWishList()

				self:updateTableViewPanel()
			end
		end

		LayerManager:pushInLayer("PopCommunityWishManageLayer", var_21_0)
	end)

	local function var_19_3()
		local var_24_0 = os.date("*t", curTime)

		cc.UserDefault:getInstance():setIntegerForKey("CommunityWishDailyTime", (os.time({
			hour = 23,
			min = 59,
			sec = 59,
			year = var_24_0.year,
			month = var_24_0.month,
			day = var_24_0.day
		})))
	end

	self.rcxy_btn:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_19_3()
		self:updateDalyWishRedStatus()
		LayerManager:pushInLayer("PopCommunityWishLayer", {
			callback = function()
				self:getListData()
			end
		})
	end)
	self:updateDalyWishRedStatus()
	self.cjxy_btn:addTouchEventListener(function(arg_27_0, arg_27_1)
		local var_27_0

		if arg_27_1 ~= ccui.TouchEventType.ended then
			do return end

			var_27_0 = {
				wishtype = 2
			}
		end

		function var_27_0.callback()
			self:getListData()
		end

		LayerManager:pushInLayer("PopCommunityWishLayer", var_27_0)
	end)
end

function CommunityWishMianLayer.createTableView(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = cc.TableView:create(arg_29_1)

	;(nil):setName(arg_29_2)
	var_29_0:setDelegate()
	var_29_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_29_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	return var_29_0
end

function CommunityWishMianLayer:initUI(arg_30_1)
	if self.tablelayer:getChildByName("communitytableview") then
		self.tablelayer:getChildByName("communitytableview"):removeFromParent()
	end

	if not self.wishdata or not next(self.wishdata) then
		self:updateRecordRedStatus()
		self.noneimg:setVisible(true)

		return
	end

	self.noneimg:setVisible(false)

	self.tableview1 = self:createTableView(cc.size(self.tablelayer:getContentSize().width, self.tablelayer:getContentSize().height), "communitytableview")

	self.tablelayer:addChild(self.tableview1, 1)
	self.tableview1:setPosition(cc.p(0, 0))

	self.roleTableViewhight = self.tablelayer:getContentSize().height

	self:initTableViewMember(arg_30_1)
	self:updateRecordRedStatus()
end

function CommunityWishMianLayer:createMemberNode()
	local var_31_0 = self.items:clone()
	local var_31_1 = AvatarSprite:create(tonumber(9200101))

	var_31_1:setPosition(cc.p(22, var_31_0:getContentSize().height / 2 - 46))
	var_31_1:setName("avatar_face_fl")
	var_31_1:setScale(0.5)
	var_31_0:addChild(var_31_1)

	return var_31_0
end

function CommunityWishMianLayer:initTableViewMember(arg_32_1)
	self.tableview1:registerScriptHandler(function(arg_34_0, arg_34_1)
		return var_0_11, var_0_12
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableview1:registerScriptHandler(function(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_0:dequeueCell()

		if not var_33_0 then
			var_33_0 = cc.TableViewCell:create()

			local var_33_1 = self:createMemberNode()

			var_33_1:setName("node")
			var_33_1:setPosition(cc.p(0, 0))
			self:updateMemberNode(var_33_1, self.wishdata[arg_33_1 + 1], arg_33_1)

			if arg_33_1 <= math.floor(self.roleTableViewhight / var_0_12) then
				var_33_1:setOpacity(0)
				var_33_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * arg_33_1), cc.FadeIn:create(0.1)))
			else
				var_33_1:setOpacity(255)
			end

			var_33_0:addChild(var_33_1)
		else
			local var_33_2 = var_33_0:getChildByName("node")

			var_33_2:setOpacity(255)
			self:updateMemberNode(var_33_2, self.wishdata[arg_33_1 + 1], arg_33_1)
		end

		return var_33_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableview1:registerScriptHandler(function(arg_35_0, arg_35_1)
		return #self.wishdata
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableview1:reloadData()

	if arg_32_1 then
		local var_32_0 = math.ceil(self.roleTableViewhight / var_0_12)

		if var_32_0 >= arg_32_1 + 1 or var_32_0 >= #self.wishdata then
			return
		elseif arg_32_1 > 0 and self.wishdata[arg_32_1] then
			local var_32_1 = (arg_32_1 - 1) * (100 / (#self.wishdata - self.roleTableViewhight / 145))

			if (arg_32_1 - 1) * (100 / (#self.wishdata - self.roleTableViewhight / 145)) < 0 then
				var_32_1 = 0
			elseif var_32_1 > 100 then
				var_32_1 = 100
			end

			self.tableview1:scrollToPercent(var_32_1, 0, false)
		end
	end
end

function CommunityWishMianLayer:updateMemberNode(arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(arg_36_1, "role"), "Label_17")
	local var_36_1 = ccui.Helper:seekWidgetByName(arg_36_1, "friend")
	local var_36_2 = ccui.Helper:seekWidgetByName(var_36_1, "Label_17")
	local var_36_3 = ccui.Helper:seekWidgetByName(arg_36_1, "itemimg")
	local var_36_4 = ccui.Helper:seekWidgetByName(arg_36_1, "mynum_lable")
	local var_36_5 = ccui.Helper:seekWidgetByName(arg_36_1, "ProgressBar_36")
	local var_36_6 = ccui.Helper:seekWidgetByName(arg_36_1, "num")
	local var_36_7 = ccui.Helper:seekWidgetByName(arg_36_1, "statuslable")
	local var_36_8 = ccui.Helper:seekWidgetByName(arg_36_1, "mask")
	local var_36_9 = ccui.Helper:seekWidgetByName(arg_36_1, "btn_zs")
	local var_36_10 = community_system_manager:getWishDataByWishid(arg_36_2.wishid)

	ccui.Helper:seekWidgetByName(arg_36_1, "name"):setString(arg_36_2.name)

	if arg_36_2.count >= var_36_10.wish_num then
		var_36_8:setVisible(true)
	else
		var_36_8:setVisible(false)
	end

	var_36_0:setString(var_0_9[arg_36_2.title])
	var_36_4:setString(COMMUNITY_WISH_SYSTEM.tips3 .. community_system_manager:getCommityItemNum(var_36_10.item_id))
	var_36_6:setString(arg_36_2.count .. "/" .. var_36_10.wish_num)
	var_36_5:setPercent(100 * (arg_36_2.count / var_36_10.wish_num))
	var_36_8:setLocalZOrder(20)
	var_36_8:setOpacity(50)
	var_36_7:setString("")

	if arg_36_2.is_friend then
		var_36_1:setVisible(true)
		var_36_2:setString(COMMUNITY_WISH_SYSTEM.tips4)
	else
		var_36_1:setVisible(false)
	end

	local var_36_12
	local var_36_13
	local var_36_14
	local var_36_15 = var_36_10.item_id

	if var_36_3:getChildByName("awarditem") then
		var_36_3:getChildByName("awarditem"):removeFromParent()
	end

	var_36_12 = type(var_36_15) == "string" and ccui.Button:create("public/box/box_activity_recharge_1.png", "public/box/box_activity_recharge_1.png", nil, var_0_7) or ccui.Button:create("public/box/box_activity_recharge_" .. item_data[var_36_15].equip_quality .. ".png", "public/box/box_activity_recharge_" .. item_data[var_36_15].equip_quality .. ".png", nil, var_0_7)

	var_36_12:setAnchorPoint(cc.p(0.5, 0.5))
	var_36_12:setTouchEnabled(true)
	var_36_12:setSwallowTouches(false)
	var_36_12:setPosition(cc.p(var_36_3:getContentSize().width / 2 + 16, var_36_3:getContentSize().height / 2 - 3))
	var_36_12:setName("awarditem")
	var_36_3:setCascadeOpacityEnabled(false)
	var_36_3:addChild(var_36_12, 1)

	if item_data[var_36_15].bag_item_type == kITEM_SCULTURE then
		var_36_14 = AvatarSprite:create(var_36_15)
	elseif item_data[var_36_15].bag_item_type == kITEM_MEDAL then
		var_36_14 = ItemSprite:create_medal_icon(var_36_15)
	elseif item_data[var_36_15].bag_item_type == kITEM_COMPONENT then
		var_36_14 = componentManager:create_component_icon(var_36_15, nil, nil)
	elseif item_data[var_36_15].bag_item_type == KITEM_SPRING_FESTIVAL_WORD then
		var_36_14 = ItemSprite:create_word_collect_icon(var_36_15)
	elseif item_data[var_36_15].image_id then
		var_36_13 = "equipment/" .. item_data[var_36_15].image_id .. ".png"
	end

	var_36_14 = var_36_14 or ccui.ImageView:create(var_36_13)

	var_36_14:setPosition(cc.p(var_36_12:getContentSize().width / 2, var_36_12:getContentSize().height / 2))
	var_36_14:setName("ItemSprite")
	var_36_14:setScale(84 / math.min(var_36_14:getContentSize().width, var_36_14:getContentSize().height))
	var_36_12:setScale(0.85)
	var_36_12:addChild(var_36_14)

	var_36_12.itemid = var_36_15

	var_36_12:addTouchEventListener(function(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_37_0:getTouchBeganPosition().y - arg_37_0:getTouchEndPosition().y) > 50 then
			return
		end

		self:showItemDeatil(arg_37_0)
	end)

	if playermodel.playerid == arg_36_2.playerid then
		var_36_9:setVisible(false)
		var_36_1:setVisible(false)
		var_36_7:setString(COMMUNITY_WISH_SYSTEM.tips5)
		var_36_7:setColor(var_0_10[1])
	elseif arg_36_2.status then
		var_36_7:setString(COMMUNITY_WISH_SYSTEM.tips6)
		var_36_9:setVisible(false)
		var_36_7:setColor(var_0_10[1])
	elseif community_system_manager:getCommityItemNum(var_36_10.item_id) < var_36_10.give_num then
		var_36_7:setString(COMMUNITY_WISH_SYSTEM.tips7)
		var_36_9:setVisible(false)
		var_36_7:setColor(var_0_10[2])
	else
		var_36_7:setString("")
		var_36_9:setVisible(true)
	end

	if arg_36_2.count >= var_36_10.wish_num then
		var_36_8:setVisible(true)
		var_36_7:setString(COMMUNITY_WISH_SYSTEM.tips8)
		var_36_9:setVisible(false)
	else
		var_36_8:setVisible(false)
	end

	self:updatePlayerFace(arg_36_1, arg_36_2.head_sculpture, arg_36_2.playerid)
	var_36_9:addTouchEventListener(function(arg_38_0, arg_38_1)
		local var_38_0

		if arg_38_1 ~= ccui.TouchEventType.ended then
			do return end

			var_38_0 = {
				headImage = "community_system/joinCommunityLayer/tips_juanzeng.png",
				layerType = "CommunityMainLayer"
			}
		end

		function var_38_0.surecallback()
			community_system_manager:send_wish_to_member(arg_36_2.id, function(arg_40_0)
				if arg_40_0.result == 1 then
					self.wishdata = community_system_manager:getCommityWishList()

					self:updateTableViewPanel()
					global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips9)
				elseif arg_40_0.result == 2 then
					global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips2)
				elseif arg_40_0.result == 3 then
					global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips10)
				elseif arg_40_0.result == 4 then
					global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips11)
					self:getListData(arg_36_3)
				elseif arg_40_0.result == 5 then
					global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips12)
					self:getListData(arg_36_3)
				elseif arg_40_0.result == 6 then
					global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips13)
				elseif arg_40_0.result == 7 then
					global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips14)
				elseif arg_40_0.result == 8 then
					global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips15)
				elseif arg_40_0.result == 9 then
					global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips7)
				elseif arg_40_0.result == 10 then
					global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips43)
				else
					global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips10)
				end
			end)
		end

		function var_38_0.cancelcallback()
			return
		end

		global_basic_scene:addChild(ConfirmDialogSprite:create("", string.format(COMMUNITY_WISH_SYSTEM.tips16, var_36_10.give_num or 1, item_data[var_36_10.item_id].name or ""), var_38_0), 999)
	end)
end

function CommunityWishMianLayer.updatePlayerFace(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	if not arg_42_1 or not arg_42_2 or not arg_42_3 then
		return
	end

	local var_42_0 = arg_42_1:getChildByName("avatar_face_fl")

	var_42_0:switchShowAvatar(tonumber(arg_42_2))
	var_42_0:addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_43_0

		if arg_42_3 <= 0 then
			do return end

			var_43_0 = {
				playeruid = arg_42_3
			}
		end

		function var_43_0.callback()
			if var_0_6 then
				community_system_manager:updateWishDataFriendStatus(arg_42_3)

				arg_42_0.wishdata = community_system_manager:getCommityWishList()

				arg_42_0:updateTableViewPanel()
			end
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_43_0)
	end)
end

function CommunityWishMianLayer:updateTableViewPanel()
	if not self.tableview1 or not self.tableview1 then
		return
	end

	local var_45_0, var_45_1 = GetTableViewShowCellIdx(self.tableview1, {
		cellsize = cc.size(var_0_11, var_0_12),
		maxcount = #self.wishdata
	})

	for iter_45_0 = var_45_0, var_45_1 do
		self.tableview1:updateCellAtIndex(iter_45_0)
	end
end

function CommunityWishMianLayer:showItemDeatil(arg_46_1)
	if type(arg_46_1.itemid) == "string" then
		return
	end

	local var_46_0 = item_data[arg_46_1.itemid].bag_item_type

	if item_data[arg_46_1.itemid].bag_item_type == kITEM_HORCRUX then
		local var_46_1 = -1
		local var_46_2 = require("data.item_data")[arg_46_1.itemid].horcruxtype

		for iter_46_0, iter_46_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if arg_46_1.itemid == iter_46_1.item_id then
				var_46_1 = iter_46_0

				break
			end
		end

		if var_46_1 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_46_1,
			itemid = arg_46_1.itemid
		})
	elseif var_46_0 == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[arg_46_1.itemid].servant
		})
	elseif not self:getChildByName("OTHER_LAYER") then
		local var_46_3 = PopLayer:Item({
			hideGainButton = true,
			itemid = arg_46_1.itemid
		})
	end
end

function CommunityWishMianLayer:fullScreen(arg_47_1)
	local var_47_0 = GameDisplay.getScreenSize()

	arg_47_1:setContentSize(var_47_0)
	arg_47_1:setPositionY(arg_47_1:getPositionY() - GameDisplay.fix_y)
	self.backimg:setPositionY(var_47_0.height)
	self.backimg:setPositionX(0)
	self.tablelayer:setContentSize(cc.size(640, 1000 + 2 * GameDisplay.fix_y))
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end

function CommunityWishMianLayer:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_49_0)
		if arg_49_0.eventType == NEXT_DAY then
			playermodel:getServerTime(function()
				return
			end)
		end
	end), self)
end
