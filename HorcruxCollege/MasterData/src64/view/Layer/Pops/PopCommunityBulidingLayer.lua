PopCommunityBulidingLayer = class("PopCommunityBulidingLayer", function()
	return PopBaseLayer:create()
end)

require("view.Layer.PopLayer")

local item_data = require("data.item_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local family_medal_data = require("data.family_medal_data")
local var_0_5 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local family_tag_data = require("data.family_tag_data")
local family_building_data = require("data.family_building_data")
local var_0_9 = {
	COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips1,
	COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips2,
	COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips16
}
local var_0_10 = {
	{
		COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips3,
		COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips4
	},
	{
		COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips5,
		COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips6
	},
	{
		COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips17,
		""
	}
}
local var_0_11 = {
	{
		off = "community_system/communityMainLayer/building_btn_off.png",
		on = "community_system/communityMainLayer/building_btn_on.png"
	},
	[2] = "community_system/communityMainLayer/building_manji.png"
}
local var_0_12 = {
	cc.c3b(122, 232, 255),
	cc.c3b(255, 150, 150)
}
local var_0_13 = {
	"community_system/communityMainLayer/building_dt.png",
	"community_system/communityMainLayer/building_ck.png",
	"community_system/communityMainLayer/building_sc.png"
}
local var_0_14 = 614
local var_0_15 = 230

function PopCommunityBulidingLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunityBulidingLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunityBulidingLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityBulidingLayer.json" or "PopCommunityBulidingLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.tablelayer = ccui.Helper:seekWidgetByName(self.rootLayer, "tablelayer")
	self.commitymoney = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_46")
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")

	self.rootpanel:setCascadeOpacityEnabled(false)
	self.rootpanel:setPositionY(590 + GameDisplay.fix_y)
	self.rootpanel:setCascadeOpacityEnabled(false)

	if arg_3_1 then
		self.callback = arg_3_1.callback or nil
	end

	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self:initUI()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function PopCommunityBulidingLayer.dealWiththeData(arg_7_0, arg_7_1)
	return
end

function PopCommunityBulidingLayer.createTableView(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = cc.TableView:create(arg_8_1)

	;(nil):setName(arg_8_2)
	var_8_0:setDelegate()
	var_8_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_8_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	return var_8_0
end

function PopCommunityBulidingLayer:initUI()
	self.data = community_system_manager:getFamilyBuilding()

	self:updateCommityMoney()

	if self.tablelayer:getChildByName("tableview") then
		self.tablelayer:getChildByName("tableview"):removeFromParent()

		self.tableview1 = nil
	end

	if not self.data or not next(self.data) then
		return
	end

	self.tableview1 = self:createTableView(cc.size(self.tablelayer:getContentSize().width, self.tablelayer:getContentSize().height), "tableview")

	self.tablelayer:addChild(self.tableview1, 1)
	self.tableview1:setPosition(cc.p(0, 0))

	self.roleTableViewhight = self.tablelayer:getContentSize().height

	self:initTableViewMember()
end

function PopCommunityBulidingLayer:updateCommityMoney()
	self.commitymoney:setString("" .. global_trans_number((community_system_manager:getCommunityMoney())))
end

function PopCommunityBulidingLayer:createNode()
	return (self.items:clone())
end

function PopCommunityBulidingLayer:initTableViewMember()
	self.tableview1:registerScriptHandler(function(arg_14_0, arg_14_1)
		return var_0_14, var_0_15
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableview1:registerScriptHandler(function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:dequeueCell()

		if not var_13_0 then
			var_13_0 = cc.TableViewCell:create()

			local var_13_1 = self:createNode()

			var_13_1:setName("node")
			var_13_1:setPosition(cc.p(3, 0))
			self:updateNode(var_13_1, self.data[arg_13_1 + 1])

			if arg_13_1 <= math.floor(self.roleTableViewhight / var_0_15) then
				var_13_1:setOpacity(0)
				var_13_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * arg_13_1), cc.FadeIn:create(0.1)))
			else
				var_13_1:setOpacity(255)
			end

			var_13_0:addChild(var_13_1)
		else
			local var_13_2 = var_13_0:getChildByName("node")

			var_13_2:setOpacity(255)
			self:updateNode(var_13_2, self.data[arg_13_1 + 1])
		end

		return var_13_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableview1:registerScriptHandler(function(arg_15_0, arg_15_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableview1:reloadData()
end

function PopCommunityBulidingLayer:updateNode(arg_16_1, arg_16_2)
	local var_16_0 = ccui.Helper:seekWidgetByName(arg_16_1, "level")
	local var_16_1 = ccui.Helper:seekWidgetByName(arg_16_1, "old1")
	local var_16_2 = ccui.Helper:seekWidgetByName(arg_16_1, "new1")
	local var_16_3 = ccui.Helper:seekWidgetByName(arg_16_1, "row1")
	local var_16_4 = ccui.Helper:seekWidgetByName(arg_16_1, "Label_49")
	local var_16_5 = ccui.Helper:seekWidgetByName(arg_16_1, "Button_45")
	local var_16_6 = ccui.Helper:seekWidgetByName(arg_16_1, "level_2_3_0")
	local var_16_7 = ccui.Helper:seekWidgetByName(arg_16_1, "level_1")
	local var_16_8 = ccui.Helper:seekWidgetByName(arg_16_1, "old2")
	local var_16_9 = ccui.Helper:seekWidgetByName(arg_16_1, "new2")
	local var_16_10 = ccui.Helper:seekWidgetByName(arg_16_1, "row2")

	ccui.Helper:seekWidgetByName(arg_16_1, "Image_25"):setCascadeOpacityEnabled(false)
	var_16_0:setCascadeOpacityEnabled(false)
	var_16_7:setCascadeOpacityEnabled(false)
	ccui.Helper:seekWidgetByName(arg_16_1, "level_2_3"):setString(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips7)
	arg_16_1:setCascadeOpacityEnabled(false)
	ccui.Helper:seekWidgetByName(arg_16_1, "name"):setString(var_0_9[arg_16_2.id])
	ccui.Helper:seekWidgetByName(arg_16_1, "medal_btn"):loadTextures(var_0_13[arg_16_2.id], var_0_13[arg_16_2.id], var_0_13[arg_16_2.id], var_0_5)

	local var_16_11 = arg_16_2.id .. "_" .. arg_16_2.lv

	var_16_6:setString("" .. global_trans_number(family_building_data[arg_16_2.id .. "_" .. arg_16_2.lv].family_money_cost))
	var_16_0:setString(var_0_10[arg_16_2.id][1])
	var_16_7:setString(var_0_10[arg_16_2.id][2])

	local var_16_12 = community_system_manager:getCommunityMoney()

	if var_16_12 >= family_building_data[var_16_11].family_money_cost then
		var_16_6:setColor(var_0_12[1])
	else
		var_16_6:setColor(var_0_12[2])
	end

	if arg_16_2.id == 1 then
		var_16_1:setString(arg_16_2.lv)
		var_16_8:setString(global_trans_number(family_building_data[var_16_11].max_member))
	elseif arg_16_2.id == 2 then
		var_16_1:setString(arg_16_2.lv)
		var_16_8:setString(global_trans_number(family_building_data[var_16_11].max_money))
	elseif arg_16_2.id == 3 then
		var_16_1:setString(arg_16_2.lv)
		var_16_8:setString("")
	end

	self:createTextForShopTips(arg_16_1, arg_16_2.id)

	local var_16_13 = community_system_manager:getNextBuilding(arg_16_2.id, arg_16_2.lv)

	if var_16_13 then
		if arg_16_2.id == 1 then
			var_16_2:setString(arg_16_2.lv + 1)
			var_16_9:setString(global_trans_number(family_building_data[arg_16_2.id .. "_" .. arg_16_2.lv + 1].max_member))
		elseif arg_16_2.id == 2 then
			var_16_2:setString(arg_16_2.lv + 1)
			var_16_9:setString(global_trans_number(family_building_data[arg_16_2.id .. "_" .. arg_16_2.lv + 1].max_money))
		elseif arg_16_2.id == 3 then
			var_16_2:setString(arg_16_2.lv + 1)
			var_16_9:setString("")
		end

		var_16_3:setVisible(true)
		var_16_10:setVisible(true)

		if arg_16_2.id == 3 then
			var_16_10:setVisible(false)
		end
	else
		var_16_3:setVisible(false)
		var_16_10:setVisible(false)
		var_16_2:setString("")
		var_16_9:setString("")
	end

	if self:checkLevelIsOk(arg_16_2.id, arg_16_2.lv) then
		if not community_system_manager:checkIsLock(arg_16_2.id, arg_16_2.lv) then
			var_16_4:setString(var_0_10[family_building_data[var_16_11].build_id_1] .. "lv" .. family_building_data[var_16_11].build_lv_1 .. COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips9)
		else
			var_16_4:setString("")
		end
	elseif not community_system_manager:checkIsLock(arg_16_2.id, arg_16_2.lv) then
		var_16_4:setString(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips8 .. family_building_data["" .. arg_16_2.id .. "_" .. arg_16_2.lv].family_lv .. ("/" .. var_0_9[family_building_data[var_16_11].build_id_1] .. "lv" .. family_building_data[var_16_11].build_lv_1) .. COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips9)
	else
		var_16_4:setString(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips8 .. family_building_data["" .. arg_16_2.id .. "_" .. arg_16_2.lv].family_lv .. COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips9)
	end

	if var_16_13 then
		if self:checkLevelIsOk(arg_16_2.id, arg_16_2.lv) then
			if not community_system_manager:checkIsLock(arg_16_2.id, arg_16_2.lv) then
				var_16_5:loadTextures(var_0_11[1].off, nil, var_0_11[1].off, var_0_5)
			elseif var_16_12 >= family_building_data[var_16_11].family_money_cost then
				var_16_5:loadTextures(var_0_11[1].on, nil, var_0_11[1].on, var_0_5)
			else
				var_16_5:loadTextures(var_0_11[1].off, nil, var_0_11[1].off, var_0_5)
			end
		else
			var_16_5:loadTextures(var_0_11[1].off, nil, var_0_11[1].off, var_0_5)
		end
	else
		var_16_5:loadTextures(var_0_11[2], nil, var_0_11[2], var_0_5)
		var_16_4:setString("")
	end

	var_16_5:addTouchEventListener(function(arg_17_0, arg_17_1)
		local var_17_0

		if arg_17_1 ~= ccui.TouchEventType.ended then
			do return end

			var_17_0 = {
				headImage = "community_system/joinCommunityLayer/tips_jianshe.png",
				layerType = "CommunityMainLayer",
				assgin = 1,
				surecallback = function()
					community_system_manager:family_building_levelup(arg_16_2.id, function(arg_20_0)
						if arg_20_0.result == 1 then
							self.data = community_system_manager:getFamilyBuilding()

							self:updateCommityMoney()
							self.tableview1:reloadData()

							if self.callback then
								self.callback()
							end

							global_ShowBlockWords(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips10)
						elseif arg_20_0.result == 2 then
							global_ShowBlockWords(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips5)
						elseif arg_20_0.result == 11 then
							global_ShowBlockWords(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips5)
						elseif arg_20_0.result == 12 then
							global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips15)
						elseif arg_20_0.result == 13 then
							global_ShowBlockWords(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips11)
						elseif arg_20_0.result == 14 then
							global_ShowBlockWords(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips12)
						elseif arg_20_0.result == 15 then
							global_ShowBlockWords(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips13)
						end
					end)
				end
			}
		end

		function var_17_0.cancelcallback()
			return
		end

		if not community_system_manager:getCurfamilyPostion() or community_system_manager:getCurfamilyPostion() == 10 then
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips15)
		elseif not self:checkLevelIsOk(arg_16_2.id, arg_16_2.lv) then
			if family_building_data["" .. arg_16_2.id .. "_" .. arg_16_2.lv + 1] then
				global_ShowBlockWords(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips13)
			else
				global_ShowBlockWords(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips11)
			end
		elseif community_system_manager:getCommunityMoney() < family_building_data[var_16_11].family_money_cost then
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips12)
		else
			global_basic_scene:addChild(ConfirmDialogSprite:create("", string.format(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips14, family_building_data[var_16_11].family_money_cost), var_17_0), 999)
		end
	end)
end

function PopCommunityBulidingLayer.checkLevelIsOk(arg_21_0, arg_21_1, arg_21_2)
	return not not (family_building_data["" .. arg_21_1 .. "_" .. arg_21_2] and family_building_data["" .. arg_21_1 .. "_" .. arg_21_2].family_lv and community_system_manager:getCommityLevel() >= family_building_data["" .. arg_21_1 .. "_" .. arg_21_2].family_lv)
end

function PopCommunityBulidingLayer.initCommunityImage(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_2 or not arg_22_1 then
		return
	end

	local var_22_0 = "equipment/family/communitymedal1.png"

	if family_medal_data[arg_22_2] then
		var_22_0 = "equipment/family/" .. family_medal_data[arg_22_2].image_id .. ".png"
	end

	arg_22_1:loadTextures(var_22_0, nil, var_22_0)
end

function PopCommunityBulidingLayer:updateTableViewPanel()
	if not self.tableview1 or not self.data then
		return
	end

	local var_23_0, var_23_1 = GetTableViewShowCellIdx(tableview, {
		cellsize = cc.size(var_0_14, var_0_15),
		maxcount = #self.data
	})

	for iter_23_0 = var_23_0, var_23_1 do
		tableview:updateCellAtIndex(iter_23_0)
	end
end

function PopCommunityBulidingLayer:initBg(arg_24_1)
	local var_24_0 = ccui.Layout:create()

	var_24_0:setTouchEnabled(true)
	var_24_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_24_0:setAnchorPoint(cc.p(0, 0))
	var_24_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_24_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_24_0:setOpacity(0)
	var_24_0:setCascadeOpacityEnabled(false)
	self:addChild(var_24_0, -1)

	local var_24_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_24_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_24_1:setPositionX(var_24_0:getContentSize().width / 2)
	var_24_1:setPositionY(var_24_0:getContentSize().height / 2)
	var_24_0:addChild(var_24_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_25_0)
		self:addChild(arg_25_0, -2)
		arg_25_0:setPositionY(arg_25_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_24_1)
		var_24_0:setOpacity(102)
		var_24_0:setTouchEnabled(false)
	end)
end

function PopCommunityBulidingLayer:exit()
	self.hideActions.shrinkBoth(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopCommunityBulidingLayer.createTextForShopTips(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_1 or not arg_28_2 then
		return
	end

	if arg_28_1:getChildByName("isshoptips") then
		arg_28_1:getChildByName("isshoptips"):removeFromParent()
	end

	if arg_28_2 == 3 then
		local var_28_0 = cc.Label:createWithTTF(COMMUNITY_POPCOMMUNITYBULIDINGLAYER.tips18, "fonts/number.ttf", 22)

		var_28_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_28_0:setColor(cc.c3b(125, 168, 255))
		var_28_0:setName("isshoptips")
		var_28_0:setPosition(cc.p(arg_28_1:getContentSize().width / 2 - 50, arg_28_1:getContentSize().height / 2 - 34))
		arg_28_1:addChild(var_28_0, 1000)
	end
end
