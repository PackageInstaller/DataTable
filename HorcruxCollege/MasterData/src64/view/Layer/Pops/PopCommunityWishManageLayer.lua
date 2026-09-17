PopCommunityWishManageLayer = class("PopCommunityWishManageLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")
require("view.Sprite.AvatarSprite")
require("view.Sprite.ConfirmDialogSprite")

local item_data = require("data.item_data")
local community_system_manager = require("controller.community_system_manager")
local chat_system_manager = require("controller.chat_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local var_0_5
local var_0_6 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local var_0_8 = {
	{
		off = "community_system/communityMainLayer/commity_wish_sz_off.png",
		on = "community_system/communityMainLayer/commity_wish_sz_on.png"
	},
	{
		off = "community_system/communityMainLayer/commity_wish_jz_off.png",
		on = "community_system/communityMainLayer/commity_wish_jz_on.png"
	}
}
local var_0_9 = 640
local var_0_10 = 130

function PopCommunityWishManageLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunityWishManageLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunityWishManageLayer:init(arg_3_1)
	var_0_5 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityWishManageLayer.json" or "PopCommunityWishManageLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.panel_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_sz")
	self.panel_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_jz")
	self.btn_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sz")
	self.btn_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_jz")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "add_items")
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "imagebg")
	self.tips = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_45")
	self.tableview_1 = ccui.Helper:seekWidgetByName(self.panel_1, "tableviewlayer")
	self.tableview_2 = ccui.Helper:seekWidgetByName(self.panel_2, "tableviewlayer")
	self.noneimg_1 = ccui.Helper:seekWidgetByName(self.panel_1, "Image_none")
	self.noneimg_2 = ccui.Helper:seekWidgetByName(self.panel_2, "Image_none")

	self.rootpanel:setCascadeOpacityEnabled(false)

	self.top_btn = {
		self.btn_1,
		self.btn_2
	}
	self.panels = {
		self.panel_1,
		self.panel_2
	}

	ccui.Helper:seekWidgetByName(self.rootLayer, "panelbg"):setPositionY(225 + GameDisplay.fix_y)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self.callback then
				self.callback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	self.topindex = 1

	if arg_3_1 then
		self.callback = arg_3_1.callback or nil
	end

	if arg_3_1 then
		self.frindcallback = arg_3_1.frindcallback or nil
	end

	self:initUI()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_5 = nil
		end
	end)
end

function PopCommunityWishManageLayer:initUI()
	self.tips:setString(COMMUNITY_WISH_SYSTEM.tips18)
	self.noneimg_1:getChildByName("Label_19"):getVirtualRenderer():setMaxLineWidth(350)
	self.noneimg_1:getChildByName("Label_19"):setString(COMMUNITY_WISH_SYSTEM.tips19)
	self.noneimg_2:getChildByName("Label_19"):getVirtualRenderer():setMaxLineWidth(350)
	self.noneimg_2:getChildByName("Label_19"):setString(COMMUNITY_WISH_SYSTEM.tips20)
	self:initTopBtn()
end

function PopCommunityWishManageLayer:initTopBtn()
	for iter_8_0, iter_8_1 in ipairs(self.top_btn) do
		iter_8_1.id = iter_8_0

		iter_8_1:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.topindex = arg_9_0.id

			self:updateTopBtnStatus()
		end)
	end

	self:updateTopBtnStatus()
	self:UpdateTopBtnRed()
end

function PopCommunityWishManageLayer:UpdateTopBtnRed()
	for iter_10_0, iter_10_1 in ipairs(self.top_btn) do
		if community_system_manager:getRecordRedStatus(iter_10_0) then
			iter_10_1:getChildByName("red"):setVisible(true)
		else
			iter_10_1:getChildByName("red"):setVisible(false)
		end
	end
end

function PopCommunityWishManageLayer:updateTopBtnStatus()
	for iter_11_0, iter_11_1 in pairs(self.top_btn) do
		if iter_11_1.id == self.topindex then
			iter_11_1:loadTextures(var_0_8[iter_11_1.id].on, var_0_8[iter_11_1.id].on, var_0_8[iter_11_1.id].on, var_0_6)
			self:updateSelectLayer()
		else
			iter_11_1:loadTextures(var_0_8[iter_11_1.id].off, var_0_8[iter_11_1.id].off, var_0_8[iter_11_1.id].off, var_0_6)
		end
	end
end

function PopCommunityWishManageLayer:updateSelectLayer()
	local function var_12_0(arg_13_0)
		if self.panel_1:getChildByName("tableviewlayer"):getChildByName("realtableviewlayer") then
			self.panel_1:getChildByName("tableviewlayer"):getChildByName("realtableviewlayer"):removeFromParent()
		end

		if self.panel_2:getChildByName("tableviewlayer"):getChildByName("realtableviewlayer") then
			self.panel_2:getChildByName("tableviewlayer"):getChildByName("realtableviewlayer"):removeFromParent()
		end

		self.panel_1:setVisible(arg_13_0)
		self.panel_2:setVisible(not arg_13_0)
	end

	if self.topindex == 1 then
		var_12_0(true)
	elseif self.topindex == 2 then
		var_12_0(false)
	end

	local function var_12_1(arg_14_0)
		if arg_14_0.result == 1 then
			self.listdata = community_system_manager:getWishRecordList(self.topindex)

			self:updateSelectTableViewLayer()
			self:UpdateTopBtnRed()
		end
	end

	if self.topindex == 1 then
		community_system_manager:get_family_wish_record1(var_12_1)
	else
		community_system_manager:get_family_wish_record2(var_12_1)
	end
end

function PopCommunityWishManageLayer.createTableView(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = cc.TableView:create(arg_15_1)

	;(nil):setName(arg_15_2)
	var_15_0:setDelegate()
	var_15_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_15_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	return var_15_0
end

function PopCommunityWishManageLayer:updateSelectTableViewLayer(arg_16_1)
	if not self.listdata or not next(self.listdata) then
		if self.topindex == 1 then
			self.noneimg_1:setVisible(true)

			return
		else
			self.noneimg_2:setVisible(true)

			return
		end
	end

	if self.topindex == 1 then
		self.noneimg_1:setVisible(false)

		self.tableview = self:createTableView(cc.size(self.tableview_1:getContentSize().width, self.tableview_1:getContentSize().height), "realtableviewlayer")

		self.tableview_1:addChild(self.tableview)
		self.tableview:setPosition(cc.p(0, 0))

		self.roleTableViewhight = self.tableview:getContentSize().height
	else
		self.noneimg_2:setVisible(false)

		self.tableview = self:createTableView(cc.size(self.tableview_2:getContentSize().width, self.tableview_2:getContentSize().height), "realtableviewlayer")

		self.tableview_2:addChild(self.tableview)
		self.tableview:setPosition(cc.p(0, 0))

		self.roleTableViewhight = self.tableview:getContentSize().height
	end

	self:initTableView(arg_16_1)
end

function PopCommunityWishManageLayer:createMemberNode()
	local var_17_0 = self.items:clone()
	local var_17_1 = AvatarSprite:create(tonumber(9200101))

	var_17_1:setPosition(cc.p(22, var_17_0:getContentSize().height / 2 - 46))
	var_17_1:setName("avatar_face_fl")
	var_17_1:setScale(0.5)
	var_17_0:addChild(var_17_1)

	return var_17_0
end

function PopCommunityWishManageLayer:initTableView(arg_18_1)
	self.tableview:registerScriptHandler(function(arg_20_0, arg_20_1)
		return var_0_9, var_0_10
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableview:registerScriptHandler(function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0:dequeueCell()

		if not var_19_0 then
			var_19_0 = cc.TableViewCell:create()

			local var_19_1 = self:createMemberNode()

			var_19_1:setName("node")
			var_19_1:setPosition(cc.p(0, 0))
			self:updateMemberNode(var_19_1, self.listdata[arg_19_1 + 1], arg_19_1)

			if arg_19_1 <= math.floor(self.roleTableViewhight / var_0_10) then
				var_19_1:setOpacity(0)
				var_19_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * arg_19_1), cc.FadeIn:create(0.1)))
			else
				var_19_1:setOpacity(255)
			end

			var_19_0:addChild(var_19_1)
		else
			local var_19_2 = var_19_0:getChildByName("node")

			var_19_2:setOpacity(255)
			self:updateMemberNode(var_19_2, self.listdata[arg_19_1 + 1], arg_19_1)
		end

		return var_19_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableview:registerScriptHandler(function(arg_21_0, arg_21_1)
		return #self.listdata
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableview:reloadData()

	if arg_18_1 then
		local var_18_0 = math.ceil(self.roleTableViewhight / var_0_10)

		if var_18_0 >= arg_18_1 + 1 or var_18_0 >= #self.listdata then
			return
		elseif arg_18_1 > 0 and self.listdata[arg_18_1] then
			local var_18_1 = (arg_18_1 - 1) * (100 / (#self.listdata - self.roleTableViewhight / 145))

			if (arg_18_1 - 1) * (100 / (#self.listdata - self.roleTableViewhight / 145)) < 0 then
				var_18_1 = 0
			elseif var_18_1 > 100 then
				var_18_1 = 100
			end

			self.tableview:scrollToPercent(var_18_1, 0, false)
		end
	end
end

function PopCommunityWishManageLayer:updateMemberNode(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = ccui.Helper:seekWidgetByName(arg_22_1, "itemimg")
	local var_22_1 = ccui.Helper:seekWidgetByName(arg_22_1, "btn_lq")
	local var_22_2 = ccui.Helper:seekWidgetByName(arg_22_1, "btn_gx")
	local var_22_3 = ccui.Helper:seekWidgetByName(arg_22_1, "btn_sl")

	ccui.Helper:seekWidgetByName(arg_22_1, "name"):setString(arg_22_2.name)
	ccui.Helper:seekWidgetByName(arg_22_1, "time"):setString(community_system_manager:dealWishTime(arg_22_2.record_time))

	local var_22_5
	local var_22_6
	local var_22_7
	local var_22_8 = arg_22_2.itemid

	if var_22_0:getChildByName("awarditem") then
		var_22_0:getChildByName("awarditem"):removeFromParent()
	end

	var_22_5 = type(var_22_8) == "string" and ccui.Button:create("public/box/box_activity_recharge_1.png", "public/box/box_activity_recharge_1.png", nil, var_0_6) or ccui.Button:create("public/box/box_activity_recharge_" .. item_data[var_22_8].equip_quality .. ".png", "public/box/box_activity_recharge_" .. item_data[var_22_8].equip_quality .. ".png", nil, var_0_6)

	var_22_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_22_5:setTouchEnabled(true)
	var_22_5:setSwallowTouches(false)
	var_22_5:setPosition(cc.p(var_22_0:getContentSize().width / 2 + 16, var_22_0:getContentSize().height / 2 - 3))
	var_22_5:setName("awarditem")
	var_22_0:setCascadeOpacityEnabled(false)
	var_22_0:addChild(var_22_5, 1)

	if item_data[var_22_8].bag_item_type == kITEM_SCULTURE then
		var_22_7 = AvatarSprite:create(var_22_8)
	elseif item_data[var_22_8].bag_item_type == kITEM_MEDAL then
		var_22_7 = ItemSprite:create_medal_icon(var_22_8)
	elseif item_data[var_22_8].bag_item_type == kITEM_COMPONENT then
		var_22_7 = componentManager:create_component_icon(var_22_8, nil, nil)
	elseif item_data[var_22_8].bag_item_type == KITEM_SPRING_FESTIVAL_WORD then
		var_22_7 = ItemSprite:create_word_collect_icon(var_22_8)
	elseif item_data[var_22_8].image_id then
		var_22_6 = "equipment/" .. item_data[var_22_8].image_id .. ".png"
	end

	var_22_7 = var_22_7 or ccui.ImageView:create(var_22_6)

	var_22_7:setPosition(cc.p(var_22_5:getContentSize().width / 2, var_22_5:getContentSize().height / 2))
	var_22_7:setName("ItemSprite")
	var_22_7:setScale(84 / math.min(var_22_7:getContentSize().width, var_22_7:getContentSize().height))
	var_22_5:setScale(0.85)
	var_22_5:addChild(var_22_7)

	var_22_5.itemid = var_22_8

	var_22_5:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_23_0:getTouchBeganPosition().y - arg_23_0:getTouchEndPosition().y) > 50 then
			return
		end

		self:showItemDeatil(arg_23_0)
	end)

	if arg_22_2.itemnum then
		local var_22_9 = ccui.ImageView:create("public/box/rechage_itemsprite_num_bg.png", var_0_6)

		var_22_9:setPosition(cc.p(var_22_0:getContentSize().width * var_22_0:getScaleY() - var_22_9:getContentSize().width / 2, var_22_9:getContentSize().height / 2))
		var_22_5:addChild(var_22_9, 100)

		local var_22_10 = cc.Label:createWithTTF("x" .. arg_22_2.itemnum, "fonts/number.ttf", 22)

		var_22_10:setAnchorPoint(cc.p(1, 0))
		var_22_10:setPosition(cc.p(var_22_9:getContentSize().width - 2, 0))
		var_22_9:addChild(var_22_10)
	end

	self:updatePlayerFace(arg_22_1, arg_22_2.head_sculpture, arg_22_2.playerid)

	if self.topindex == 1 then
		var_22_3:setVisible(false)

		if arg_22_2.is_recv then
			var_22_1:setVisible(false)
		else
			var_22_1:setVisible(true)
		end

		if arg_22_2.is_thank then
			var_22_2:setVisible(false)
		else
			var_22_2:setVisible(true)
		end
	else
		var_22_1:setVisible(false)
		var_22_2:setVisible(false)

		if arg_22_2.can_recv and not arg_22_2.is_recv then
			var_22_3:setVisible(true)
		else
			var_22_3:setVisible(false)
		end
	end

	var_22_1:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		community_system_manager:wish_management_operator(arg_22_2.recordid, 1, function(arg_25_0)
			if arg_25_0.result == 1 then
				self.listdata = community_system_manager:getWishRecordList(self.topindex)

				self:updateTableViewPanel()
				self:UpdateTopBtnRed()
			end
		end)
	end)
	var_22_2:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		community_system_manager:wish_management_operator(arg_22_2.recordid, 2, function(arg_27_0)
			if arg_27_0.result == 1 then
				self.listdata = community_system_manager:getWishRecordList(self.topindex)

				self:updateTableViewPanel()
				global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips22)
			end
		end)
	end)
	var_22_3:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		community_system_manager:wish_management_operator(arg_22_2.recordid, 3, function(arg_29_0)
			if arg_29_0.result == 1 then
				self.listdata = community_system_manager:getWishRecordList(self.topindex)

				self:updateTableViewPanel()
				self:UpdateTopBtnRed()
				global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips23)
			end
		end)
	end)
end

function PopCommunityWishManageLayer.updatePlayerFace(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if not arg_30_1 or not arg_30_2 or not arg_30_3 then
		return
	end

	local var_30_0 = arg_30_1:getChildByName("avatar_face_fl")

	var_30_0:switchShowAvatar(tonumber(arg_30_2))
	var_30_0:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_31_0

		if arg_30_3 <= 0 then
			do return end

			var_31_0 = {
				playeruid = arg_30_3
			}
		end

		function var_31_0.callback()
			if var_0_5 then
				community_system_manager:updateWishDataFriendStatus(arg_30_3)

				if arg_30_0.frindcallback then
					arg_30_0.frindcallback()
				end
			end
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_31_0)
	end)
end

function PopCommunityWishManageLayer:updateTableViewPanel()
	if not self.tableview or not self.tableview then
		return
	end

	local var_33_0, var_33_1 = GetTableViewShowCellIdx(self.tableview, {
		cellsize = cc.size(var_0_9, var_0_10),
		maxcount = #self.listdata
	})

	for iter_33_0 = var_33_0, var_33_1 do
		self.tableview:updateCellAtIndex(iter_33_0)
	end
end

function PopCommunityWishManageLayer:showItemDeatil(arg_34_1)
	if type(arg_34_1.itemid) == "string" then
		return
	end

	local var_34_0 = item_data[arg_34_1.itemid].bag_item_type

	if item_data[arg_34_1.itemid].bag_item_type == kITEM_HORCRUX then
		local var_34_1 = -1
		local var_34_2 = require("data.item_data")[arg_34_1.itemid].horcruxtype

		for iter_34_0, iter_34_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if arg_34_1.itemid == iter_34_1.item_id then
				var_34_1 = iter_34_0

				break
			end
		end

		if var_34_1 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_34_1,
			itemid = arg_34_1.itemid
		})
	elseif var_34_0 == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[arg_34_1.itemid].servant
		})
	elseif not self:getChildByName("OTHER_LAYER") then
		local var_34_3 = PopLayer:Item({
			hideGainButton = true,
			itemid = arg_34_1.itemid
		})
	end
end

function PopCommunityWishManageLayer:initBg(arg_35_1)
	local var_35_0 = ccui.Layout:create()

	var_35_0:setTouchEnabled(true)
	var_35_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_35_0:setAnchorPoint(cc.p(0, 0))
	var_35_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_35_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_35_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_35_0:setOpacity(0)
	var_35_0:setCascadeOpacityEnabled(false)
	self:addChild(var_35_0, -1)

	local var_35_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_35_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_35_1:setPositionX(var_35_0:getContentSize().width / 2)
	var_35_1:setPositionY(var_35_0:getContentSize().height / 2)
	var_35_0:addChild(var_35_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_36_0)
		self:addChild(arg_36_0, -2)
		arg_36_0:setPositionY(arg_36_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_35_1)
		var_35_0:setOpacity(102)
		var_35_0:setTouchEnabled(false)
	end)
end

function PopCommunityWishManageLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.callback then
			self.callback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
