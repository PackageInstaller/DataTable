PopCommunityApplyingLayer = class("PopCommunityApplyingLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")
require("view.Sprite.AvatarSprite")
require("view.Sprite.ConfirmDialogSprite")

local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local family_medal_data = require("data.family_medal_data")
local var_0_8
local var_0_9 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local var_0_11 = 640
local var_0_12 = 150
local var_0_13 = {
	online = cc.c3b(0, 255, 18),
	offline = cc.c3b(133, 133, 133)
}

function PopCommunityApplyingLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunityApplyingLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunityApplyingLayer:init(arg_3_1)
	var_0_8 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityApplyingLayer.json" or "PopCommunityApplyingLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.applyitem = ccui.Helper:seekWidgetByName(self.rootLayer, "add_items")
	self.ignoreall = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_ignore_all")
	self.acceptall = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_accept_all")
	self.btn_zhaomu = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_zhaomu")
	self.tablelayer = ccui.Helper:seekWidgetByName(self.rootLayer, "tablelayer")
	self.membernumbg = ccui.Helper:seekWidgetByName(self.rootLayer, "applyimg")
	self.applynumbg = ccui.Helper:seekWidgetByName(self.rootLayer, "memberimg")
	self.membernum = ccui.Helper:seekWidgetByName(self.membernumbg, "Label_67")
	self.applynum = ccui.Helper:seekWidgetByName(self.applynumbg, "Label_68")
	self.tempimg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_25")

	self.tempimg:getChildByName("Label_26"):setString(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips1)
	self.tempimg:setVisible(false)
	self.btn_zhaomu:setVisible(false)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")

	self.rootpanel:setCascadeOpacityEnabled(false)
	self.rootpanel:setPositionY(590 + GameDisplay.fix_y)

	if arg_3_1 then
		self.familyid = arg_3_1.familyid or nil
	end

	if arg_3_1 then
		self.positon = arg_3_1.positon or nil
	end

	if arg_3_1 then
		self.callback = arg_3_1.callback or nil
	end

	if arg_3_1 then
		self.redcallback = arg_3_1.redcallback or nil
	end

	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self.redcallback then
				self.redcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self:updateMemberNumLable()
	self.applynum:setString("")
	self:initBtnLayer()
	self:getlistData()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_8 = nil
		end
	end)
end

function PopCommunityApplyingLayer.getlistData(arg_7_0)
	community_system_manager:get_family_applications(function(arg_8_0)
		if arg_8_0.result == 1 then
			if var_0_8 then
				arg_7_0.applydata = arg_8_0.list

				arg_7_0:initUI()
				arg_7_0:updateApplyNumLable()
			end
		elseif arg_8_0.result == 2 then
			-- block empty
		elseif arg_8_0.result == 3 then
			-- block empty
		end
	end)
end

function PopCommunityApplyingLayer:initUI()
	if self.tablelayer:getChildByName("roleTableView") then
		self.tablelayer:getChildByName("roleTableView"):removeFromParent()
	end

	if not self.applydata or not next(self.applydata) then
		print("no  data !!!!!!!!!!!")
		self.tempimg:setVisible(true)

		return
	end

	self.tempimg:setVisible(false)

	self.apply_panel_ani = false

	if not self.tablelayer:getChildByName("roleTableView") then
		self:createTableView()
	end

	self:initTableView()
end

function PopCommunityApplyingLayer:initBtnLayer(arg_10_1)
	if self.positon == 1 or self.positon == 2 then
		self.ignoreall:setVisible(true)
		self.acceptall:setVisible(true)
	else
		self.ignoreall:setVisible(false)
		self.acceptall:setVisible(false)
	end

	self.ignoreall:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_11_0()
			if self.applydata and next(self.applydata) then
				local var_12_0 = {}

				for iter_12_0, iter_12_1 in ipairs(self.applydata) do
					table.insert(var_12_0, iter_12_1.playerid)
				end

				community_system_manager:audit_family_application(var_12_0, 1, function(arg_13_0)
					if arg_13_0.result == 1 then
						if var_0_8 then
							self:getlistData()
						end

						global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips5)
					elseif arg_13_0.result == 2 then
						global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips8)
					elseif arg_13_0.result == 3 then
						global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips9)
					elseif arg_13_0.result == 4 then
						global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips13)
					end
				end)
			else
				global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips1)
			end
		end

		if not self.applydata or not next(self.applydata) then
			global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips1)
		else
			(function()
				global_basic_scene:addChild(ConfirmDialogSprite:create("", COMMUNITY_COMMUNITYAPPLYINGLAYER.tips2, {
					headImage = "community_system/joinCommunityLayer/tips_sure.png",
					layerType = "CommunityMainLayer",
					assgin = 2,
					surecallback = var_11_0,
					cancelcallback = function()
						return
					end
				}), 999)
			end)()
		end
	end)
	self.acceptall:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_17_0()
			if self.applydata and next(self.applydata) then
				local var_18_0 = {}

				for iter_18_0, iter_18_1 in ipairs(self.applydata) do
					table.insert(var_18_0, iter_18_1.playerid)
				end

				community_system_manager:audit_family_application(var_18_0, 2, function(arg_19_0)
					if arg_19_0.result == 1 then
						local var_19_0 = 0

						if arg_19_0.success_ids then
							var_19_0 = #arg_19_0.success_ids
						end

						if not arg_19_0.fullbreak then
							if var_19_0 > 0 then
								global_ShowBlockWords(string.format(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips11, var_19_0))
							end
						elseif var_19_0 > 0 then
							global_ShowBlockWords(string.format(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips12, var_19_0))
						end

						if var_0_8 then
							self:updateMemberNumLable(arg_19_0.member or 0)
							self:getlistData()
						end

						if self.callback then
							self.callback()
						end
					elseif arg_19_0.result == 2 then
						global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips8)
					elseif arg_19_0.result == 3 then
						global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips9)
					elseif arg_19_0.result == 4 then
						if var_0_8 then
							self:updateMemberNumLable(arg_19_0.member or 0)
							global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips10)
						end
					end
				end)
			else
				global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips1)
			end
		end

		if not self.applydata or not next(self.applydata) then
			global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips1)
		else
			(function()
				global_basic_scene:addChild(ConfirmDialogSprite:create("", COMMUNITY_COMMUNITYAPPLYINGLAYER.tips3, {
					headImage = "community_system/joinCommunityLayer/tips_sure.png",
					layerType = "CommunityMainLayer",
					assgin = 2,
					surecallback = var_17_0,
					cancelcallback = function()
						return
					end
				}), 999)
			end)()
		end
	end)
end

function PopCommunityApplyingLayer:createTableView()
	self.roleTableView = cc.TableView:create(cc.size(self.tablelayer:getContentSize().width, self.tablelayer:getContentSize().height))

	self.roleTableView:setName("roleTableView")
	self.roleTableView:setPosition(cc.p(0, 0))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tablelayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rootLayer:setName("roleTableView")

	self.roleTableViewhight = 586
end

function PopCommunityApplyingLayer.initPlayerGrade(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_1 or not arg_24_2 then
		return
	end

	local var_24_0

	if arg_24_1 == 4 then
		var_24_0 = "TopcostLayer/new_master.png"
	elseif arg_24_1 == 3 then
		var_24_0 = "TopcostLayer/new_Univ.png"
	elseif arg_24_1 == 2 then
		var_24_0 = "TopcostLayer/new_Senior.png"
	elseif arg_24_1 == 1 then
		var_24_0 = "TopcostLayer/new_Junior.png"
	end

	arg_24_2:loadTexture(var_24_0, var_0_9)
end

function PopCommunityApplyingLayer:createNode()
	local var_25_0 = self.applyitem:clone()
	local var_25_1 = AvatarSprite:create(tonumber(9200101))

	var_25_1:setPosition(cc.p(10, 10))
	var_25_1:setName("avatar_face_pm")
	var_25_1:setScale(0.65)
	var_25_0:addChild(var_25_1)

	return var_25_0
end

function PopCommunityApplyingLayer:updateNode(arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = ccui.Helper:seekWidgetByName(arg_26_1, "class_img")
	local var_26_1 = ccui.Helper:seekWidgetByName(arg_26_1, "power")
	local var_26_2 = ccui.Helper:seekWidgetByName(arg_26_1, "online_time")
	local var_26_3 = ccui.Helper:seekWidgetByName(arg_26_1, "btn_ignore")
	local var_26_4 = ccui.Helper:seekWidgetByName(arg_26_1, "btn_accept")

	ccui.Helper:seekWidgetByName(arg_26_1, "player_name"):setString(arg_26_2.name)
	ccui.Helper:seekWidgetByName(arg_26_1, "level"):setString("LV." .. arg_26_2.level)
	var_26_1:setString(global_trans_number(arg_26_2.fightpower))
	var_26_1:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)

	if arg_26_2.lastlogin then
		if arg_26_2.lastlogin == "-1" then
			var_26_2:setColor(var_0_13.online)
		else
			var_26_2:setColor(var_0_13.offline)
		end

		var_26_2:setString(community_system_manager:dealTheOnlineTime(arg_26_2.lastlogin))
	else
		var_26_2:setString("")
	end

	self:initPlayerGrade(arg_26_2.class, var_26_0)

	local var_26_5 = arg_26_1:getChildByName("avatar_face_pm")

	var_26_5:switchShowAvatar(tonumber(arg_26_2.head_sculpture))
	var_26_5:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_27_0

		if arg_26_2.playerid <= 0 then
			do return end

			var_27_0 = {
				ishidaddbtn = 1,
				playeruid = arg_26_2.playerid
			}
		end

		function var_27_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_27_0)
	end)

	if self.positon == 1 or self.positon == 2 then
		var_26_3:setVisible(true)
		var_26_4:setVisible(true)
	else
		var_26_3:setVisible(false)
		var_26_4:setVisible(false)
	end

	var_26_3:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		community_system_manager:audit_family_application({
			arg_26_2.playerid
		}, 1, function(arg_30_0)
			if arg_30_0.result == 1 then
				global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips5)

				if var_0_8 then
					self:updateApplyPanel(arg_26_3)
				end
			elseif arg_30_0.result == 2 then
				global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips8)
			elseif arg_30_0.result == 3 then
				global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips9)
			elseif arg_30_0.result == 4 then
				global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips13)
			else
				global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips7)
			end
		end)
	end)
	var_26_4:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		community_system_manager:audit_family_application({
			arg_26_2.playerid
		}, 2, function(arg_32_0)
			if arg_32_0.result == 1 then
				global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips6)

				if arg_32_0.success_ids and #arg_32_0.success_ids >= 1 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips6)
				end

				if var_0_8 then
					self:updateMemberNumLable(arg_32_0.member or 0)
					self:updateApplyPanel(arg_26_3)

					if self.callback then
						self.callback()
					end
				end
			elseif arg_32_0.result == 2 then
				global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips8)
			elseif arg_32_0.result == 3 then
				global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips9)
			elseif arg_32_0.result == 4 then
				if var_0_8 then
					self:updateMemberNumLable(arg_32_0.member or 0)
				end

				global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips10)
			else
				global_ShowBlockWords(COMMUNITY_COMMUNITYAPPLYINGLAYER.tips7)
			end
		end)
	end)
end

function PopCommunityApplyingLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_37_0, arg_37_1)
		return var_0_11, var_0_12
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_34_0, arg_34_1)
		local var_34_0 = arg_34_0:dequeueCell()

		if not var_34_0 then
			var_34_0 = cc.TableViewCell:create()

			local var_34_1 = self:createNode()

			var_34_1:setName("node")
			var_34_1:setPosition(cc.p(5, -5))
			self:updateNode(var_34_1, self.applydata[arg_34_1 + 1], arg_34_1)

			if arg_34_1 <= math.floor(self.roleTableViewhight / var_0_12) then
				var_34_1:setOpacity(0)
				var_34_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * arg_34_1), cc.FadeIn:create(0.1)))
			else
				var_34_1:setOpacity(255)
			end

			var_34_0:addChild(var_34_1)

			if self.apply_panel_ani then
				var_34_0:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_34_0:getPositionX() - 1500, var_34_0:getPositionY())), cc.CallFunc:create(function()
					cc.RemoveSelf:create()

					self.apply_panel_ani = false

					self:getlistData()
				end)))
			end
		else
			local var_34_2 = var_34_0:getChildByName("node")

			var_34_2:setOpacity(255)
			self:updateNode(var_34_2, self.applydata[arg_34_1 + 1], arg_34_1)

			if self.apply_panel_ani then
				var_34_0:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_34_0:getPositionX() - 1500, var_34_0:getPositionY())), cc.CallFunc:create(function()
					cc.RemoveSelf:create()

					self.apply_panel_ani = false

					self:getlistData()
				end)))
			end
		end

		return var_34_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_38_0, arg_38_1)
		return #self.applydata
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function PopCommunityApplyingLayer:updateApplyPanel(arg_39_1)
	if not arg_39_1 or not self.applydata or not next(self.applydata) then
		self.tempimg:setVisible(true)

		return
	end

	self.tempimg:setVisible(false)

	local var_39_0, var_39_1 = GetTableViewShowCellIdx(self.roleTableView, {
		cellsize = cc.size(var_0_11, var_0_12),
		maxcount = #self.applydata
	})

	if var_39_0 <= arg_39_1 and arg_39_1 <= var_39_1 then
		self.apply_panel_ani = true

		self.roleTableView:updateCellAtIndex(arg_39_1)
	end
end

function PopCommunityApplyingLayer:updateBtnAlert()
	if RoleDefault:getInstance():getBoolForKey("NewCommunityApplyHave", false) then
		global_add_alert_tag(self.btn_2, (cc.p(180, 74)))
	else
		global_remove_alert_tag(self.btn_2)
	end
end

function PopCommunityApplyingLayer.registerActivityEventListener(arg_41_0)
	activityManager:registerEventListener("NewCommunityApplyHave", activityManager.activityEventId.FRIEND_NEW_APPLY_NOTICE, function(arg_42_0)
		arg_41_0:updateBtnAlert()
	end)
end

function PopCommunityApplyingLayer:updateApplyNumLable(arg_43_1)
	self.applynum:setString("" .. (community_system_manager:getCommunityApplyingNum() or ""))
end

function PopCommunityApplyingLayer:updateMemberNumLable(arg_44_1)
	local var_44_0 = arg_44_1 or community_system_manager:getCommunityMemberNum()
	local var_44_1 = community_system_manager:getMaxMember()

	if var_44_1 and var_44_1 ~= "" then
		self.membernum:setString("" .. var_44_0 .. "/" .. var_44_1)
	else
		self.membernum:setString("" .. var_44_0)
	end
end

function PopCommunityApplyingLayer:initBg(arg_45_1)
	local var_45_0 = ccui.Layout:create()

	var_45_0:setTouchEnabled(true)
	var_45_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_45_0:setAnchorPoint(cc.p(0, 0))
	var_45_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_45_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_45_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_45_0:setOpacity(0)
	var_45_0:setCascadeOpacityEnabled(false)
	self:addChild(var_45_0, -1)

	local var_45_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_45_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_45_1:setPositionX(var_45_0:getContentSize().width / 2)
	var_45_1:setPositionY(var_45_0:getContentSize().height / 2)
	var_45_0:addChild(var_45_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_46_0)
		self:addChild(arg_46_0, -2)
		arg_46_0:setPositionY(arg_46_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_45_1)
		var_45_0:setOpacity(102)
		var_45_0:setTouchEnabled(false)
	end)
end

function PopCommunityApplyingLayer:exit()
	self.hideActions.shrinkBoth(self, function()
		if self.redcallback then
			self.redcallback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
