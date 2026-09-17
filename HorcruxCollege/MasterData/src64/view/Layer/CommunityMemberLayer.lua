CommunityMemberLayer = class("CommunityMemberLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")
require("view.Sprite.AvatarSprite")
require("view.Sprite.ConfirmDialogSprite")
require("view.Sprite.BottomBtnList")

local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local score_arena_awards_data = require("data.score_arena_awards_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local chapter_data = require("data.chapter_data")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local friend_system_manager = require("controller.friend_system_manager")
local var_0_11
local var_0_12 = config._DEBUG and 0 or 1
local var_0_13 = "mainScenebg/community_member_bg.png"
local var_0_14 = {
	[1] = "community_system/communityMainLayer/member_shezhang.png",
	[2] = "community_system/communityMainLayer/member_fusz.png"
}
local var_0_15 = {
	online = cc.c3b(0, 255, 18),
	offline = cc.c3b(0, 0, 0)
}
local var_0_16 = 640
local var_0_17 = 150

function CommunityMemberLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = CommunityMemberLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function CommunityMemberLayer:init(arg_3_1)
	var_0_11 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "CommunityMemberLayer.json" or "CommunityMemberLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.backimg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_40")
	self.tablelayer = ccui.Helper:seekWidgetByName(self.rootLayer, "tablelayer")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "add_items")

	self.backimg:loadTexture(var_0_13)

	if arg_3_1 then
		self.familyid = arg_3_1.familyid or nil
	end

	if arg_3_1 then
		self.positon = arg_3_1.positon or nil
	end

	if self.positon then
		self.positon = community_system_manager:getThePosition(self.positon)
	end

	self:initBottomList()
	self:fullScreen(self.rootLayer)
	self:createFilterBtn()
	self:updateApplyBtn()
	self:getListData()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("CommunityMemberLayer")

			var_0_11 = nil
		end
	end)
end

function CommunityMemberLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("CommunityMemberLayer", activity_manager.activityEventId.COMMUNITY_CHANGE_POSITION, function(arg_6_0)
		if arg_6_0.familyid and arg_6_0.title and var_0_11 and arg_5_0.familyid == arg_6_0.familyid then
			arg_5_0.positon = community_system_manager:getThePosition(arg_6_0.title)

			if arg_6_0.title == 100 then
				local var_6_0

				if arg_5_0.memberdata then
					for iter_6_0, iter_6_1 in pairs(arg_5_0.memberdata) do
						if iter_6_1.title == 100 then
							var_6_0 = iter_6_1.playerid

							break
						end
					end
				end

				if var_6_0 then
					arg_5_0:updateMemberData({
						{
							playerid = playermodel.playerid,
							value = arg_6_0.title
						},
						{
							value = 10,
							playerid = var_6_0
						}
					})
				else
					arg_5_0:updateMemberData({
						{
							playerid = playermodel.playerid,
							value = arg_6_0.title
						}
					})
				end
			else
				arg_5_0:updateMemberData({
					{
						playerid = playermodel.playerid,
						value = arg_6_0.title
					}
				})
			end
		end
	end)
	activity_manager:registerEventListener("CommunityMemberLayer", activity_manager.activityEventId.COMMUNITY_KICK_NOTICE, function(arg_7_0)
		if arg_7_0.familyid and var_0_11 and arg_5_0.familyid == arg_7_0.familyid then
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips7)
			LayerManager:switchShowLayer("joinCommunityLayer")
		end
	end)
end

function CommunityMemberLayer:updateBtnAlert()
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

function CommunityMemberLayer:updateApplyBtn()
	if not self.positon then
		self.applybtn:setVisible(false)
	elseif self.positon == 1 or self.positon == 2 then
		self.applybtn:setVisible(true)
	else
		self.applybtn:setVisible(false)
	end

	self:updateBtnAlert()
end

function CommunityMemberLayer:createFilterBtn()
	self.flitbtn = ccui.Button:create("community_system/joinCommunityLayer/one_shaixuan.png", nil, "community_system/joinCommunityLayer/one_shaixuan.png", var_0_12)

	self.flitbtn:setPosition(cc.p(self.rootLayer:getContentSize().width - self.applybtn:getContentSize().width / 2 + 16, self.rootLayer:getContentSize().height - self.applybtn:getContentSize().height / 2 + 16))
	self.rootLayer:addChild(self.flitbtn, 10)
	self.flitbtn:addTouchEventListener(function(arg_11_0, arg_11_1)
		local var_11_0

		if arg_11_1 ~= ccui.TouchEventType.ended then
			do return end

			var_11_0 = {
				filtertype = 2
			}
		end

		function var_11_0.callback()
			if var_0_11 and self.memberdata and self.tableview1 then
				self.memberdata = community_system_manager:filterComminityMemberData(self.memberdata)

				if self.tableview1 then
					self.tableview1:reloadData()
				end
			end
		end

		LayerManager:pushInLayer("PopCommunityFilterLayer", var_11_0)
	end)
end

function CommunityMemberLayer:getListData(arg_13_1)
	community_system_manager:get_family_members(self.familyid, function(arg_14_0)
		if var_0_11 then
			if arg_14_0.result == 1 then
				self.memberdata = community_system_manager:filterComminityMemberData(arg_14_0.list)

				self:initUI(arg_13_1)
			elseif arg_14_0.result == 9999 then
				global_ShowBlockWords("社团系统已关闭~")
				LayerManager:switchShowLayer("MainLayer")
			end
		end
	end)
end

function CommunityMemberLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("CommunityMainLayer")
	end)

	self:addChild(self.bottomList, 100)

	self.applybtn = ccui.Button:create("community_system/communityMainLayer/member_btn_applying.png", nil, "community_system/communityMainLayer/member_btn_applying.png", var_0_12)

	self.applybtn:setPosition(cc.p(self.bottomList:getContentSize().width - self.applybtn:getContentSize().width / 2 + 5, self.bottomList:getContentSize().height / 2 - 5))
	self.bottomList:addChild(self.applybtn, 10)
	self.applybtn:setVisible(false)
	self.applybtn:addTouchEventListener(function(arg_17_0, arg_17_1)
		local var_17_0

		if arg_17_1 ~= ccui.TouchEventType.ended then
			do return end

			var_17_0 = {}
		end

		function var_17_0.callback()
			self:getListData()
		end

		function var_17_0.redcallback()
			self:updateBtnAlert()
		end

		var_17_0.positon = self.positon

		LayerManager:pushInLayer("PopCommunityApplyingLayer", var_17_0)
	end)
end

function CommunityMemberLayer.createTableView(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = cc.TableView:create(arg_20_1)

	;(nil):setName(arg_20_2)
	var_20_0:setDelegate()
	var_20_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_20_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	return var_20_0
end

function CommunityMemberLayer:initUI(arg_21_1)
	if self.tablelayer:getChildByName("communitytableview") then
		self.tablelayer:getChildByName("communitytableview"):removeFromParent()
	end

	if not self.memberdata or not next(self.memberdata) then
		return
	end

	self.tableview1 = self:createTableView(cc.size(self.tablelayer:getContentSize().width, self.tablelayer:getContentSize().height), "communitytableview")

	self.tablelayer:addChild(self.tableview1, 1)
	self.tableview1:setPosition(cc.p(0, 0))

	self.roleTableViewhight = self.tablelayer:getContentSize().height

	self:initTableViewMember(arg_21_1)
end

function CommunityMemberLayer:createMemberNode()
	local var_22_0 = self.items:clone()
	local var_22_1 = AvatarSprite:create(tonumber(9200101))

	var_22_1:setPosition(cc.p(5, var_22_0:getContentSize().height / 2 - 70))
	var_22_1:setName("avatar_face_fl")
	var_22_1:setScale(0.7)
	var_22_0:addChild(var_22_1)

	return var_22_0
end

function CommunityMemberLayer:initTableViewMember(arg_23_1)
	self.tableview1:registerScriptHandler(function(arg_25_0, arg_25_1)
		return var_0_16, var_0_17
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableview1:registerScriptHandler(function(arg_24_0, arg_24_1)
		local var_24_0 = arg_24_0:dequeueCell()

		if not var_24_0 then
			var_24_0 = cc.TableViewCell:create()

			var_24_0:setLocalZOrder(#self.memberdata - arg_24_1)

			local var_24_1 = self:createMemberNode()

			var_24_1:setName("node")
			var_24_1:setPosition(cc.p(16, 0))
			self:updateMemberNode(var_24_1, self.memberdata[arg_24_1 + 1], arg_24_1)

			if self.memberdata[arg_24_1 + 1] and not self.memberdata[arg_24_1 + 1].isauto then
				var_24_1:setVisible(true)
			else
				var_24_1:setVisible(false)
			end

			if arg_24_1 <= math.floor(self.roleTableViewhight / var_0_17) then
				var_24_1:setOpacity(0)
				var_24_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * arg_24_1), cc.FadeIn:create(0.1)))
			else
				var_24_1:setOpacity(255)
			end

			var_24_0:addChild(var_24_1)
		else
			var_24_0:setLocalZOrder(#self.memberdata - arg_24_1)

			local var_24_2 = var_24_0:getChildByName("node")

			var_24_2:setOpacity(255)
			self:updateMemberNode(var_24_2, self.memberdata[arg_24_1 + 1], arg_24_1)

			if self.memberdata[arg_24_1 + 1] and not self.memberdata[arg_24_1 + 1].isauto then
				var_24_2:setVisible(true)
			else
				var_24_2:setVisible(false)
			end
		end

		return var_24_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableview1:registerScriptHandler(function(arg_26_0, arg_26_1)
		return #self.memberdata
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableview1:reloadData()

	if arg_23_1 then
		local var_23_0 = math.ceil(self.roleTableViewhight / var_0_17)

		if var_23_0 >= arg_23_1 + 1 or var_23_0 >= #self.memberdata then
			return
		elseif arg_23_1 > 0 and self.memberdata[arg_23_1] then
			local var_23_1 = (arg_23_1 - 1) * (100 / (#self.memberdata - self.roleTableViewhight / 145))

			if (arg_23_1 - 1) * (100 / (#self.memberdata - self.roleTableViewhight / 145)) < 0 then
				var_23_1 = 0
			elseif var_23_1 > 100 then
				var_23_1 = 100
			end

			self.tableview1:scrollToPercent(var_23_1, 0, false)
		end
	end
end

function CommunityMemberLayer:updateMemberNode(arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = ccui.Helper:seekWidgetByName(arg_27_1, "class_img")
	local var_27_1 = ccui.Helper:seekWidgetByName(arg_27_1, "role")
	local var_27_2 = ccui.Helper:seekWidgetByName(arg_27_1, "online_time")
	local var_27_3 = ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(arg_27_1, "contribution1"), "number")
	local var_27_4 = ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(arg_27_1, "contribution2"), "number")
	local var_27_5 = ccui.Helper:seekWidgetByName(arg_27_1, "btn_qiecuo")
	local var_27_6 = ccui.Helper:seekWidgetByName(arg_27_1, "btn_caozu")
	local var_27_7 = ccui.Helper:seekWidgetByName(arg_27_1, "panel_btn")
	local var_27_8 = ccui.Helper:seekWidgetByName(var_27_7, "Image_24")

	var_27_7:getChildByName("Image_24"):setScale9Enabled(true)
	var_27_7:setVisible(false)
	var_27_6:setSwallowTouches(false)
	ccui.Helper:seekWidgetByName(arg_27_1, "player_name"):setString(arg_27_2.name)
	ccui.Helper:seekWidgetByName(arg_27_1, "level"):setString("等级." .. arg_27_2.level)
	ccui.Helper:seekWidgetByName(arg_27_1, "power"):setString(global_trans_bitmapnumber(arg_27_2.fightpower))
	var_27_3:setString(COMMUNITY_COMMUNITYMEMBERLAYER.tips1)
	var_27_4:setString(COMMUNITY_COMMUNITYMEMBERLAYER.tips2)
	ccui.Helper:seekWidgetByName(var_27_3, "Label_31"):setString(global_trans_number(arg_27_2.active))
	ccui.Helper:seekWidgetByName(var_27_4, "Label_31"):setString(global_trans_number(arg_27_2.active_total))
	ccui.Helper:seekWidgetByName(arg_27_1, "Label_30"):setString(arg_27_2.star)
	self:updateMangementLayer(var_27_7, arg_27_2.title, arg_27_2.playerid, arg_27_2.name, arg_27_3)

	local var_27_9 = community_system_manager:getThePosition(arg_27_2.title)

	if var_27_9 and var_0_14[var_27_9] then
		var_27_1:loadTexture(var_0_14[var_27_9], var_0_12)
		var_27_1:setVisible(true)
	else
		var_27_1:setVisible(false)
		var_27_6:setVisible(false)
	end

	if self.positon == 1 or self.positon == 2 then
		var_27_6:setVisible(true)

		if self.positon == 2 and arg_27_2.title == 100 then
			var_27_6:setVisible(false)
		end
	else
		var_27_6:setVisible(false)
	end

	if arg_27_2.playerid == playermodel.playerid then
		var_27_6:setVisible(false)
		var_27_5:setVisible(false)
	end

	if arg_27_2.lastlogin == "-1" then
		var_27_2:setColor(var_0_15.online)
	else
		var_27_2:setColor(var_0_15.offline)
	end

	var_27_2:setString(community_system_manager:dealTheOnlineTime(arg_27_2.lastlogin))
	self:updatePlayerFace(arg_27_1, arg_27_2.head_sculpture, arg_27_2.playerid)
	self:updateClassImage(var_27_0, arg_27_2.class)
	var_27_5:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_28_0:isBright() then
			return
		end

		arg_28_0:setBright(false)
		friend_system_manager:get_someone_array_fightdata(arg_27_2.playerid, function(arg_29_0, arg_29_1)
			if arg_29_0 and type(arg_29_0) == "table" then
				LayerManager:pushInLayer("PopShowScoreArenaEnemyArray", {
					enemysData = arg_29_0,
					playerid = arg_27_2.playerid,
					friendfight = CONFIG_TYPE_FRIEND_FIGHT,
					friendname = arg_27_2.name,
					fightpoint = arg_29_1
				})
			end

			arg_28_0:setBright(true)
		end)
	end)
	var_27_6:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_27_7:setVisible(not var_27_7:isVisible())
	end)

	local var_27_10 = cc.EventListenerTouchOneByOne:create()

	var_27_10:setSwallowTouches(false)
	var_27_10:registerScriptHandler(function(arg_31_0, arg_31_1)
		if LayerManager:getCurrentLayerName() ~= "CommunityMemberLayer" then
			return false
		end

		if var_27_7:isVisible() then
			return true
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_27_10:registerScriptHandler(function(arg_32_0, arg_32_1)
		var_27_7:setVisible(false)
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_27_10, var_27_8)
end

function CommunityMemberLayer:updateMangementLayer(arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	if not arg_33_2 then
		return
	end

	local var_33_0 = ccui.Helper:seekWidgetByName(arg_33_1, "btn_zhuangr")
	local var_33_1 = ccui.Helper:seekWidgetByName(arg_33_1, "btn_renm")
	local var_33_2 = ccui.Helper:seekWidgetByName(arg_33_1, "btn_qingli")

	var_33_0:getChildByName("Label_25"):setString(COMMUNITY_COMMUNITYMEMBERLAYER.tips3)
	var_33_1:getChildByName("Label_26"):setString(COMMUNITY_COMMUNITYMEMBERLAYER.tips4)
	var_33_2:getChildByName("Label_27"):setString(COMMUNITY_COMMUNITYMEMBERLAYER.tips5)

	if self.positon == 1 then
		var_33_0:setVisible(true)
		var_33_1:setVisible(true)
		var_33_2:setVisible(true)
		var_33_0:setPositionY(77)
		var_33_1:setPositionY(22)
		var_33_2:setPositionY(-34)
		arg_33_1:getChildByName("Image_24"):setContentSize(cc.size(147, 150))
		arg_33_1:getChildByName("Image_24"):setPositionY(22)

		if arg_33_2 == 90 then
			var_33_1:getChildByName("Label_26"):setString(COMMUNITY_COMMUNITYMEMBERLAYER.tips6)
		end
	else
		var_33_0:setVisible(false)
		var_33_1:setVisible(false)
		var_33_2:setVisible(true)
		var_33_2:setPositionY(42)
		arg_33_1:getChildByName("Image_24"):setContentSize(cc.size(147, 90))
		arg_33_1:getChildByName("Image_24"):setPositionY(44)
	end

	var_33_0:addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_34_0()
			community_system_manager:manage_family_title(arg_33_3, 100, function(arg_36_0)
				if arg_36_0.result == 1 then
					if var_0_11 then
						global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips7)

						self.positon = 3

						self:updateMemberData({
							{
								value = 100,
								playerid = arg_33_3
							},
							{
								value = 10,
								playerid = playermodel.playerid
							}
						})
					end
				elseif arg_36_0.result == 11 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips19)
				elseif arg_36_0.result == 12 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips20)
				elseif arg_36_0.result == 13 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips15)
				elseif arg_36_0.result == 14 then
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.operate_fail)
				elseif arg_36_0.result == 15 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips22)
				else
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.operate_fail)
				end
			end)
		end

		;(function()
			global_basic_scene:addChild(ConfirmDialogSprite:create("", string.format(COMMUNITY_COMMUNITYMEMBERLAYER.tips8, "\"", arg_33_4, "\""), {
				layerType = "CommunityMainLayer",
				headImage = "community_system/joinCommunityLayer/tips_sure.png",
				assgin = 1,
				surecallback = var_34_0,
				cancelcallback = function()
					return
				end,
				btntext = {
					yes = COMMUNITY_COMMUNITYMEMBERLAYER.tips17,
					no = COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips12
				}
			}), 999)
		end)()
	end)
	var_33_1:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_40_0()
			local function var_41_0(arg_42_0)
				if arg_42_0.result == 1 then
					if var_0_11 then
						if arg_33_2 == 90 then
							global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips9)
							self:updateMemberData({
								{
									value = 10,
									playerid = arg_33_3
								}
							})
						else
							global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips10)
							self:updateMemberData({
								{
									value = 90,
									playerid = arg_33_3
								}
							})
						end
					end
				elseif arg_42_0.result == 11 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips19)
				elseif arg_42_0.result == 12 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips20)
				elseif arg_42_0.result == 13 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips15)
				elseif arg_42_0.result == 14 then
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.operate_fail)
				elseif arg_42_0.result == 15 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips21)
				else
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.operate_fail)
				end
			end

			if arg_33_2 == 90 then
				community_system_manager:manage_family_title(arg_33_3, 10, var_41_0)
			else
				community_system_manager:manage_family_title(arg_33_3, 90, var_41_0)
			end
		end

		;(function()
			local var_43_1 = string.format(COMMUNITY_COMMUNITYMEMBERLAYER.tips11, "\"", arg_33_4, "\"")

			global_basic_scene:addChild(ConfirmDialogSprite:create("", (arg_33_2 == 90 or nil) and string.format(COMMUNITY_COMMUNITYMEMBERLAYER.tips12, "\"", arg_33_4, "\""), {
				headImage = "community_system/joinCommunityLayer/tips_sure.png",
				layerType = "CommunityMainLayer",
				assgin = 2,
				surecallback = var_40_0,
				cancelcallback = function()
					return
				end
			}), 999)
		end)()
	end)
	var_33_2:addTouchEventListener(function(arg_46_0, arg_46_1)
		if arg_46_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_46_0()
			community_system_manager:kick_family_member(arg_33_3, function(arg_48_0)
				if arg_48_0.result == 1 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips13)

					if var_0_11 then
						self:getListData(arg_33_5)
					end
				elseif arg_48_0.result == 11 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips14)
				elseif arg_48_0.result == 12 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips15)
				elseif arg_48_0.result == 13 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips16)
				end
			end)
		end

		;(function()
			global_basic_scene:addChild(ConfirmDialogSprite:create("", string.format(COMMUNITY_COMMUNITYMEMBERLAYER.tips18, "\"", arg_33_4, "\""), {
				headImage = "community_system/joinCommunityLayer/tips_sure.png",
				layerType = "CommunityMainLayer",
				assgin = 2,
				surecallback = var_46_0,
				cancelcallback = function()
					return
				end
			}), 999)
		end)()
	end)
end

function CommunityMemberLayer.updatePlayerFace(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	if not arg_52_1 or not arg_52_2 or not arg_52_3 then
		return
	end

	local var_52_0 = arg_52_1:getChildByName("avatar_face_fl")

	var_52_0:switchShowAvatar(tonumber(arg_52_2))
	var_52_0:addTouchEventListener(function(arg_53_0, arg_53_1)
		if arg_53_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_53_0

		if arg_52_3 <= 0 then
			do return end

			var_53_0 = {
				playeruid = arg_52_3
			}
		end

		function var_53_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_53_0)
	end)
end

function CommunityMemberLayer.updateClassImage(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0

	if arg_55_2 == 4 then
		var_55_0 = "TopcostLayer/new_master.png"
	elseif arg_55_2 == 3 then
		var_55_0 = "TopcostLayer/new_Univ.png"
	elseif arg_55_2 == 2 then
		var_55_0 = "TopcostLayer/new_Senior.png"
	elseif arg_55_2 == 1 then
		var_55_0 = "TopcostLayer/new_Junior.png"
	end

	arg_55_1:setScale(1.5)
	arg_55_1:loadTexture(var_55_0, var_0_12)
end

function CommunityMemberLayer:initTopInfoLayer()
	self.medalimg = ccui.Helper:seekWidgetByName(self.toppenel, "medal")
	self.communityname = ccui.Helper:seekWidgetByName(self.toppenel, "Label_7")
	self.communityid = ccui.Helper:seekWidgetByName(self.toppenel, "conmid")
	self.memberbg = ccui.Helper:seekWidgetByName(self.toppenel, "memberbg")
	self.moneybg = ccui.Helper:seekWidgetByName(self.toppenel, "money")
	self.expbg = ccui.Helper:seekWidgetByName(self.toppenel, "exp_di")
	self.member = ccui.Helper:seekWidgetByName(self.memberbg, "Label_19")
	self.money = ccui.Helper:seekWidgetByName(self.moneybg, "Label_19")
	self.label_1 = ccui.Helper:seekWidgetByName(self.toppenel, "lable_img_1")
	self.label_2 = ccui.Helper:seekWidgetByName(self.toppenel, "lable_img_2")
	self.label_3 = ccui.Helper:seekWidgetByName(self.toppenel, "lable_img_3")
	self.level = ccui.Helper:seekWidgetByName(self.expbg, "Label_42")
	self.levelpress = ccui.Helper:seekWidgetByName(self.expbg, "ProgressBar_39")
	self.levelpont = ccui.Helper:seekWidgetByName(self.expbg, "point")
	self.btn_info = ccui.Helper:seekWidgetByName(self.toppenel, "btn_info")
	self.labels = {
		self.label_1,
		self.label_2,
		self.label_3
	}

	for iter_56_0, iter_56_1 in pairs(self.labels) do
		iter_56_1:setVisible(false)
	end

	self.member:setString("")
	self.money:setString("")
	self.level:setString("")
	self.levelpress:setPercent(0)
	self.btn_info:addTouchEventListener(function(arg_57_0, arg_57_1)
		if arg_57_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_57_0:setBright(false)

		local var_57_0 = {
			callback = function()
				if LamiaInstance then
					arg_57_0:setBright(true)
				end
			end
		}

		var_57_0.key = "community_rule"

		LayerManager:pushInLayer("PopActivityDetail", var_57_0)
	end)
end

function CommunityMemberLayer:updateTableViewPanel()
	if not self.tableview1 or not self.tableview1 then
		return
	end

	local var_59_0, var_59_1 = GetTableViewShowCellIdx(self.tableview1, {
		cellsize = cc.size(var_0_16, var_0_17),
		maxcount = #self.memberdata
	})

	for iter_59_0 = var_59_0, var_59_1 do
		self.tableview1:updateCellAtIndex(iter_59_0)
	end
end

function CommunityMemberLayer:updateMemberData(arg_60_1)
	if not self.memberdata or not arg_60_1 or not next(arg_60_1) then
		return
	end

	for iter_60_0, iter_60_1 in pairs(arg_60_1) do
		for iter_60_2, iter_60_3 in pairs(self.memberdata) do
			if iter_60_3.playerid == iter_60_1.playerid then
				iter_60_3.title = iter_60_1.value

				break
			end
		end
	end

	self:updateTableViewPanel()
	self:updateApplyBtn()
end

function CommunityMemberLayer:fullScreen(arg_61_1)
	local var_61_0 = GameDisplay.getScreenSize()

	arg_61_1:setContentSize(var_61_0)
	arg_61_1:setPositionY(arg_61_1:getPositionY() - GameDisplay.fix_y)
	self.backimg:setPositionY(var_61_0.height)
	self.backimg:setPositionX(0)
	self.tablelayer:setContentSize(cc.size(640, 1000 + 2 * GameDisplay.fix_y))
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end
