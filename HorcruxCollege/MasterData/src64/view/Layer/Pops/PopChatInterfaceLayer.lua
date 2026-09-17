PopChatInterfaceLayer = class("PopChatInterfaceLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = false

require("view.Sprite.ItemSprite")
require("view.Sprite.ChatEmotionSprite")
require("view.Layer.PopLayer")
require("view.Sprite.AvatarSprite")
require("view.Sprite.ConfirmDialogSprite")

local barrage_manager = require("controller.barrage_manager")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local score_arena_awards_data = require("data.score_arena_awards_data")
local friend_system_manager = require("controller.friend_system_manager")
local level_manager = require("controller.level_manager")
local chapter_data = require("data.chapter_data")
local chat_system_manager = require("controller.chat_system_manager")
local time_check_manager = require("controller.time_check_manager")
local playermodel = require("model.playermodel")
local community_system_manager = require("controller.community_system_manager")
local var_0_14
local var_0_15 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local var_0_17 = {
	{
		off = "chat_system_layer/top_btn_friend_off.png",
		on = "chat_system_layer/top_btn_friend_on.png"
	},
	{
		off = "chat_system_layer/top_btn_commity_off.png",
		on = "chat_system_layer/top_btn_commity_on.png"
	}
}
local var_0_18 = {
	[1] = "chat_system_layer/top_btn_big.png",
	[2] = "chat_system_layer/top_btn_small.png"
}
local var_0_20 = {
	{
		off = "chat_system_layer/list_friend_btn_recent_off.png",
		on = "chat_system_layer/list_friend_btn_recent_on.png"
	},
	{
		off = "chat_system_layer/list_friend_btn_all_off.png",
		on = "chat_system_layer/list_friend_btn_all_on.png"
	}
}
local var_0_21 = {
	{
		off = "chat_system_layer/fun_emoticons_off.png",
		on = "chat_system_layer/fun_emoticons_on.png"
	},
	{
		off = "chat_system_layer/fun_emoticons_light_off.png",
		on = "chat_system_layer/fun_emoticons_light_on.png"
	}
}
local var_0_22 = {
	off = "chat_system_layer/bottom_btn_emoticons_off.png",
	on = "chat_system_layer/bottom_btn_emoticons_on.png"
}
local var_0_23 = {
	offline = cc.c3b(90, 116, 196),
	online = cc.c3b(34, 54, 114)
}
local var_0_24 = 100
local var_0_25 = 0.43
local var_0_26 = 1
local var_0_27 = {
	rootbg = {
		low = 483,
		up = 1020
	},
	friendbg = {
		width = 120,
		height = 378
	},
	chatbg = {
		width = 640,
		height = 438
	}
}
local var_0_28 = {
	chart = {
		width = 640,
		height = 376
	},
	friend = {
		width = 120,
		height = 348
	}
}
local var_0_29 = {
	rootbg = {
		small = var_0_27.rootbg.low / 1136,
		big = var_0_27.rootbg.up / 1136
	}
}
local var_0_32 = "##icon##_"
local var_0_33 = 82
local var_0_34 = 120
local var_0_35 = 130
local var_0_37 = {
	32,
	32
}
local var_0_38 = {
	370,
	370
}
local var_0_39 = 530
local var_0_40 = 20
local var_0_41 = {
	cc.p(36, 20),
	cc.p(162, 20),
	cc.p(288, 20),
	(cc.p(414, 20))
}
local var_0_42 = "chat_system_layer/bottom_input.png"

function PopChatInterfaceLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopChatInterfaceLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopChatInterfaceLayer:init(arg_3_1)
	var_0_14 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopChatInterfaceLayer.json" or "PopChatInterfaceLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.panelback = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return")
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_root")
	self.toppanel = ccui.Helper:seekWidgetByName(self.rootpanel, "panel_top")
	self.chatpanel = ccui.Helper:seekWidgetByName(self.rootpanel, "panel_chat")
	self.friendpanel = ccui.Helper:seekWidgetByName(self.rootpanel, "panel_friend")
	self.bottompanel = ccui.Helper:seekWidgetByName(self.rootpanel, "panel_bottom_btn")
	self.emotionpanel = ccui.Helper:seekWidgetByName(self.rootpanel, "panel_icon")
	self.items1 = ccui.Helper:seekWidgetByName(self.rootLayer, "itemtop")
	self.items2 = ccui.Helper:seekWidgetByName(self.rootLayer, "itemfriend")
	self.items3 = ccui.Helper:seekWidgetByName(self.rootLayer, "itemiconbtn")
	self.item4 = ccui.Helper:seekWidgetByName(self.rootLayer, "itemicon")
	self.item5 = ccui.Helper:seekWidgetByName(self.rootLayer, "emotionitemsbtn")
	self.toplistView = ccui.Helper:seekWidgetByName(self.toppanel, "ListView_37")
	self.iconlistView = ccui.Helper:seekWidgetByName(self.emotionpanel, "ListView_59")
	self.iconlistView2 = ccui.Helper:seekWidgetByName(self.emotionpanel, "ListView_59_0")
	self.icon_btn = ccui.Helper:seekWidgetByName(self.bottompanel, "Button_53")
	self.send_btn = ccui.Helper:seekWidgetByName(self.bottompanel, "Button_54")
	self.inputbg = ccui.Helper:seekWidgetByName(self.bottompanel, "Image_52")
	self.zoombtn = ccui.Helper:seekWidgetByName(self.toppanel, "btn_zoom")
	self.chatbg = ccui.Helper:seekWidgetByName(self.chatpanel, "Image_79")
	self.friendbg = ccui.Helper:seekWidgetByName(self.friendpanel, "Image_43")
	self.tabviewpanel1 = ccui.Helper:seekWidgetByName(self.chatpanel, "tableviewlayer")
	self.tabviewpanel2 = ccui.Helper:seekWidgetByName(self.emotionpanel, "tableviewicon")
	self.tabviewpanel3 = ccui.Helper:seekWidgetByName(self.friendpanel, "tableviewfriend")
	self.friendtop = ccui.Helper:seekWidgetByName(self.friendpanel, "fiend_top")
	self.btn_friend_recent = ccui.Helper:seekWidgetByName(self.friendtop, "btn_last")
	self.btn_friend_all = ccui.Helper:seekWidgetByName(self.friendtop, "btn_all")
	self.img_nodata = ccui.Helper:seekWidgetByName(self.chatpanel, "img_nodata")
	self.panelcutinput = ccui.Helper:seekWidgetByName(self.bottompanel, "Panel_43")
	self.emotionmasklayer = ccui.Helper:seekWidgetByName(self.emotionpanel, "maskjump")

	self.img_nodata:setVisible(false)

	self.btn_fiends = {
		self.btn_friend_recent,
		self.btn_friend_all
	}

	self.friendpanel:setVisible(false)
	self.tabviewpanel1:setBackGroundColorOpacity(0)
	self.toppanel:setLocalZOrder(36)
	self:initStatus()

	if arg_3_1 then
		self.jumpfriend = arg_3_1.friendid or nil
	end

	self.callback = arg_3_1 and arg_3_1.callback

	if arg_3_1 then
		self.topbtnindex = arg_3_1.topbtnindex or 1
	end

	self.panelback:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.emotionpanel:isVisible() then
			self.emotionpanel:setVisible(false)
			self.icon_btn:loadTextures(var_0_22.on, var_0_22.on, var_0_22.on, var_0_15)
		else
			LayerManager:removePopLayer(self.__queueindex)
		end
	end)
	global_window_open_action(self.rootpanel)
	chat_system_manager:initChatDataFromCache()
	self:registerActivityEventListener()
	self:initUI()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_14 = nil

			activity_manager:releaseEventListenerByName("PopChatInterfaceLayer")
			chat_system_manager:updateFrinedChatData()
			chat_system_manager:updateRecentFrinedData()

			if self.callback then
				self.callback()
			end
		end
	end)
end

function PopChatInterfaceLayer.initStatus(arg_6_0)
	arg_6_0.zoomstatus = 1
	arg_6_0.friendstutas = 1
	arg_6_0.friendselectindex = 1
	arg_6_0.friendselectRescentindex = 1
	arg_6_0.topbtnindex = 1
	arg_6_0.icontype = 1
	arg_6_0.iconselectindex = nil
	arg_6_0.friendBtnindex = 2
	arg_6_0.chatPool = {}
	arg_6_0.isfirstlayer = true
	arg_6_0.emontiontype = 1
end

function PopChatInterfaceLayer:initUI()
	self:initTopPanel()
	self:initBottompanel()
end

function PopChatInterfaceLayer:registerActivityEventListener()
	activity_manager:registerEventListener("PopChatInterfaceLayer", activity_manager.activityEventId.UPATATE_CHATE_DATA, function()
		if var_0_14 then
			self:updateTopBtnRedStatus(1)

			self.isfirstlayer = true

			if self.topbtnindex == 1 then
				self:dealWithTheTableView()
			end
		end
	end)
	activity_manager:registerEventListener("PopChatInterfaceLayer", activity_manager.activityEventId.UPATATE_COMMITY_CHATE_DATA, function(arg_10_0)
		if arg_10_0.list and next(arg_10_0.list) and var_0_14 then
			self:updateTopBtnRedStatus(2)

			if self.topbtnindex == 2 then
				local var_10_0 = false

				for iter_10_0, iter_10_1 in pairs(arg_10_0.list) do
					if iter_10_1.playerid == playermodel.playerid then
						var_10_0 = true
					end
				end

				self:dealWithTheTableView(var_10_0)
			end
		end
	end)
	activity_manager:registerEventListener("PopChatInterfaceLayer", activity_manager.activityEventId.COMMUNITY_KICK_NOTICE, function(arg_11_0)
		if var_0_14 then
			self.commmitychatdata = nil

			if self.topbtnindex == 2 then
				global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips7)
				self:initCommityChatData()
			end
		end
	end)
	self:registerCustomEvent("HideXPConsole", function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopChatInterfaceLayer:registerCustomEvent(arg_13_1, arg_13_2)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create(arg_13_1, arg_13_2), self)
end

function PopChatInterfaceLayer.updateTheChatData(arg_14_0)
	return
end

function PopChatInterfaceLayer:initTopPanel()
	self.toplistView:removeAllChildren()
	self.toplistView:setItemsMargin(0)

	self.topBtns = {}

	for iter_15_0, iter_15_1 in ipairs(var_0_17) do
		if not iter_15_1.close then
			local var_15_0 = self.items1:clone()

			var_15_0:getChildByName("Button_61"):loadTextures(iter_15_1.off, nil, iter_15_1.off, var_0_15)

			var_15_0.id = iter_15_0
			var_15_0:getChildByName("Button_61").id = iter_15_0

			table.insert(self.topBtns, var_15_0)
			var_15_0:getChildByName("Button_61"):addTouchEventListener(function(arg_16_0, arg_16_1)
				if arg_16_1 ~= ccui.TouchEventType.ended then
					return
				end

				if math.abs(arg_16_0:getTouchBeganPosition().y - arg_16_0:getTouchEndPosition().y) > 30 then
					return
				end

				self.topbtnindex = arg_16_0.id

				self:updateBtnStatus(arg_16_0.id)
			end)
			self.toplistView:pushBackCustomItem(var_15_0)
		end
	end

	self.zoombtn:loadTextures(var_0_18[self.zoomstatus], nil, var_0_18[self.zoomstatus], var_0_15)
	self.zoombtn:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_17_0:isBright() then
			return
		end

		arg_17_0:setBright(false)

		if self.zoomstatus == 1 then
			self.zoomstatus = 2
		elseif self.zoomstatus == 2 then
			self.zoomstatus = 1
		end

		self:zoomPanelUI(function()
			if var_0_14 then
				arg_17_0:setBright(true)
				arg_17_0:loadTextures(var_0_18[self.zoomstatus], nil, var_0_18[self.zoomstatus], var_0_15)
			end
		end)
	end)
	self:updateBtnStatus()
end

function PopChatInterfaceLayer:zoomPanelUI(arg_19_1)
	local var_19_0 = 1

	if self.zoomstatus == 1 then
		var_19_0 = var_0_29.rootbg.small
	elseif self.zoomstatus == 2 then
		var_19_0 = var_0_29.rootbg.big
	end

	local var_19_2 = GameDisplay.getScreenSize().height * var_19_0

	self.rootpanel:setContentSize(cc.size(640, var_19_2))
	self.toppanel:setPositionY(self.rootpanel:getContentSize().height - 25)
	self.chatbg:setScale9Enabled(true)
	self.chatbg:setCapInsets(cc.rect(0, 0, var_0_27.chatbg.width, var_0_27.chatbg.height))
	self.chatbg:setContentSize(cc.size(640, var_19_2 - var_0_27.rootbg.low + var_0_27.chatbg.height))
	self.tabviewpanel1:setContentSize(cc.size(var_0_28.chart.width, var_0_28.chart.height + (var_19_2 - var_0_27.rootbg.low)))
	self.friendbg:setScale9Enabled(true)
	self.friendbg:setCapInsets(cc.rect(0, 0, var_0_27.friendbg.width, var_0_27.friendbg.height))
	self.friendbg:setContentSize(cc.size(var_0_27.friendbg.width, var_0_27.friendbg.height + (var_19_2 - var_0_27.rootbg.low)))
	self.tabviewpanel3:setContentSize(cc.size(var_0_28.friend.width, var_0_28.friend.height + (var_19_2 - var_0_27.rootbg.low)))
	self.img_nodata:setPositionY(276 + (var_19_2 - var_0_27.rootbg.low) / 2)

	if arg_19_1 then
		arg_19_1()
	end

	if self.topbtnindex == 1 then
		self:initFriendPanel(1)
	elseif self.topbtnindex == 2 then
		self:initCommityChatLayer()
	end
end

function PopChatInterfaceLayer:updateTopBtnRedStatus(arg_20_1)
	if arg_20_1 then
		if arg_20_1 == self.topbtnindex then
			self.topBtns[self.topbtnindex]:getChildByName("Image_27"):setVisible(false)
		else
			self.topBtns[arg_20_1]:getChildByName("Image_27"):setVisible(true)
		end
	end
end

function PopChatInterfaceLayer:updateBtnStatus()
	for iter_21_0, iter_21_1 in ipairs(self.topBtns) do
		if self.topbtnindex == iter_21_1.id then
			iter_21_1:getChildByName("Button_61"):loadTextures(var_0_17[iter_21_1.id].on, nil, var_0_17[iter_21_1.id].on, var_0_15)
			self:updateSelectUI(self.topbtnindex)
			iter_21_1:getChildByName("Image_27"):setVisible(false)
		else
			iter_21_1:getChildByName("Button_61"):loadTextures(var_0_17[iter_21_1.id].off, nil, var_0_17[iter_21_1.id].off, var_0_15)
		end
	end
end

function PopChatInterfaceLayer.updateSelectUI(arg_22_0, arg_22_1)
	if not arg_22_1 then
		return
	end

	local var_22_0 = {
		function()
			arg_22_0:initFriendPanel()
			arg_22_0:initFriendTopBtn()
		end,
		function()
			arg_22_0:initCommityChatData()
		end
	}

	if var_22_0[arg_22_1] then
		var_22_0[arg_22_1]()
	end
end

function PopChatInterfaceLayer:initCommityChatData()
	self.friendpanel:setVisible(false)

	if not self.commmitychatdata or not next(self.commmitychatdata) then
		if community_system_manager:getCurfamilyid() then
			if community_system_manager:getCommunityChatFalg() then
				community_system_manager:get_family_chat_history(nil, function(arg_26_0, arg_26_1)
					if arg_26_0 == 1 and var_0_14 then
						self.commmitychatdata = community_system_manager:getCommunityChatData()

						self:initCommityChatLayer()
					end
				end)
			else
				self.commmitychatdata = community_system_manager:getCommunityChatData()

				self:initCommityChatLayer()
			end
		else
			self.commmitychatdata = nil

			self:initCommityChatLayer()
		end
	else
		self.commmitychatdata = community_system_manager:getCommunityChatData()

		self:initCommityChatLayer()
	end
end

function PopChatInterfaceLayer:initCommityChatLayer()
	if self.tabviewpanel1:getChildByName("tableview_chat") then
		self.tabviewpanel1:getChildByName("tableview_chat"):setVisible(false)
	end

	if self.tabviewpanel1:getChildByName("tableview_chat_commity") then
		self.tabviewpanel1:getChildByName("tableview_chat_commity"):stopAllActions()
		self.tabviewpanel1:getChildByName("tableview_chat_commity"):removeFromParent()

		self.tableviewchat = nil
	end

	self.lastId = 0
	self.chatid = 0

	self:resetChatQueue()

	if self.commmitychatdata and next(self.commmitychatdata) then
		for iter_27_0, iter_27_1 in ipairs(self.commmitychatdata) do
			if iter_27_1.msg then
				self:pushBackChat(iter_27_1)
			end
		end
	end

	if not self.chatPool or not next(self.chatPool) then
		self.img_nodata:setVisible(true)

		if self.commmitychatdata then
			self.img_nodata:getChildByName("Label_51"):setString(COMMUNITY_CHAT_SYSTEM.tips1)
		else
			self.img_nodata:getChildByName("Label_51"):setString(COMMUNITY_CHAT_SYSTEM.tips2)
		end
	else
		self.img_nodata:setVisible(false)
	end

	local var_27_0 = cc.TableView:create(cc.size(self.tabviewpanel1:getContentSize().width, self.tabviewpanel1:getContentSize().height))

	var_27_0:setPosition(-6, 0)
	var_27_0:setDelegate()
	var_27_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_27_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_27_0:setName("tableview_chat_commity")
	var_27_0:setVisible(true)
	self.tabviewpanel1:addChild(var_27_0, 99)

	self.tableviewchat = var_27_0

	self:initChatTableView()
end

function PopChatInterfaceLayer:initCommitySendBtn()
	local var_28_0 = self.editBox:getText()

	if self.emotionpanel:isVisible() and self.iconselectindex and (self.emontiontype == 1 or self.emontiontype == 2) and self.emotiondata and self.emotiondata[self.iconselectindex] and self.emotiondata[self.iconselectindex].id and var_28_0 == "" then
		emotion_text = var_0_32 .. self.emotiondata[self.iconselectindex].id

		if not community_system_manager:checkchatIsCD() then
			community_system_manager:family_chat(emotion_text, function(arg_29_0)
				if arg_29_0 == 1 then
					if var_0_14 then
						local var_29_0 = {
							myself = true,
							time = self:global_format_time_by_date((time_check_manager:getCurTime())),
							msg = emotion_text
						}

						self.emotionpanel:setVisible(false)
					end
				elseif arg_29_0 == 2 then
					global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips2)
				elseif arg_29_0 == 3 then
					global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips3)
				elseif arg_29_0 == 4 then
					global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips4)
				elseif arg_29_0 == 9999 then
					global_ShowBlockWords("社团系统已关闭")
				end

				self.editBox:setText("")
			end)
		else
			global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips11)
		end
	elseif self.emotionpanel:isVisible() and self.iconselectindex and self.emotiondata and (self.emontiontype == 1 or self.emontiontype == 2) and self.emotiondata[self.iconselectindex] and self.emotiondata[self.iconselectindex].id and var_28_0 ~= "" then
		emotion_text = var_0_32 .. self.emotiondata[self.iconselectindex].id

		if not community_system_manager:checkchatIsCD() then
			community_system_manager:family_chat(emotion_text, function(arg_30_0)
				if arg_30_0 == 1 then
					if var_0_14 then
						local var_30_0 = {
							myself = true,
							time = self:global_format_time_by_date((time_check_manager:getCurTime())),
							msg = emotion_text
						}

						self.emotionpanel:setVisible(false)
					end
				elseif arg_30_0 == 2 then
					global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips2)
				elseif arg_30_0 == 3 then
					global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips3)
				elseif arg_30_0 == 4 then
					global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips4)
				elseif arg_30_0 == 9999 then
					global_ShowBlockWords("社团系统已关闭")
				end

				if self:checkIsRight(var_28_0) then
					if not community_system_manager:checkchatIsCD() then
						community_system_manager:family_chat(var_28_0, function(arg_31_0)
							if arg_31_0 == 1 then
								if var_0_14 then
									local var_31_0 = {
										myself = true,
										time = self:global_format_time_by_date((time_check_manager:getCurTime())),
										msg = var_28_0
									}
								end
							elseif arg_31_0 == 2 then
								global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips2)
							elseif arg_31_0 == 3 then
								global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips3)
							elseif arg_31_0 == 4 then
								global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips4)
							elseif arg_31_0 == 9999 then
								global_ShowBlockWords("社团系统已关闭")
							end

							self.editBox:setText("")
						end)
					else
						global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips11)
					end
				end
			end)
		else
			global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips11)
		end
	elseif self:checkIsRight(var_28_0) then
		if not community_system_manager:checkchatIsCD() then
			community_system_manager:family_chat(var_28_0, function(arg_32_0)
				if arg_32_0 == 1 then
					if var_0_14 then
						local var_32_0 = {
							myself = true,
							time = self:global_format_time_by_date((time_check_manager:getCurTime())),
							message = var_28_0
						}

						self.emotionpanel:setVisible(false)
					end
				elseif arg_32_0 == 2 then
					global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips2)
				elseif arg_32_0 == 3 then
					global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips3)
				elseif arg_32_0 == 4 then
					global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips4)
				elseif arg_32_0 == 9999 then
					global_ShowBlockWords("社团系统已关闭")
				end

				self.editBox:setText("")
			end)
		else
			global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips11)
		end
	end
end

function PopChatInterfaceLayer:initFriendPanel(arg_33_1)
	if self.tabviewpanel1:getChildByName("tableview_chat_commity") then
		self.tabviewpanel1:getChildByName("tableview_chat_commity"):setVisible(false)
	end

	local function var_33_0(arg_34_0, arg_34_1)
		if arg_34_0 == 1 and var_0_14 then
			if not self.listfrienddata or not next(self.listfrienddata) or self.listfrienddata and arg_34_1 and #self.listfrienddata ~= #arg_34_1 then
				self.listfrienddata = chat_system_manager:sortFrindListData(arg_34_1, self.jumpfriend)
			end

			if not arg_33_1 then
				self.friendpanel:setVisible(not self.friendpanel:isVisible())
			end

			if not self.listfrienddata or not next(self.listfrienddata) then
				self:initFriendUI()

				return
			end

			if self.listfrienddata[self.friendselectindex] then
				self.friendid = self.listfrienddata[self.friendselectindex].playerid
			end

			if self.friendpanel:isVisible() or arg_33_1 then
				self:initFriendUI()
				self:initChatPanel(self.friendid, arg_33_1)
			end
		end
	end

	if self.friendBtnindex == 1 then
		self:getFriendList(self.friendBtnindex, function(arg_35_0)
			if var_0_14 then
				if not arg_33_1 then
					self.friendpanel:setVisible(not self.friendpanel:isVisible())
				end

				self.listrecentfrienddata = chat_system_manager:sortRecentFrindListData(arg_35_0, self.jumpfriend)

				if not self.listrecentfrienddata or not next(self.listrecentfrienddata) then
					self:initFriendUI()

					return
				end

				if self.listrecentfrienddata[self.friendselectRescentindex] then
					self.friendid = self.listrecentfrienddata[self.friendselectRescentindex].playerid
				end

				if self.friendpanel:isVisible() or arg_33_1 then
					self:initFriendUI()
					self:initChatPanel(self.friendid, arg_33_1)
				end
			end
		end, arg_33_1)
	else
		self:getFriendList(self.friendBtnindex, var_33_0, arg_33_1)
	end
end

function PopChatInterfaceLayer:initFriendUI()
	if self.tabviewpanel3:getChildByName("tableview_friend") then
		self.tabviewpanel3:removeAllChildren()

		self.tableviewfrined = nil
	end

	self.frienddata = self.friendBtnindex == 2 and global_deepCopy(self.listfrienddata) or global_deepCopy(self.listrecentfrienddata)

	if not self.frienddata or not next(self.frienddata) then
		self.img_nodata:setVisible(true)
		self.img_nodata:getChildByName("Label_51"):setString(COMMUNITY_CHAT_SYSTEM.tips14)

		return
	end

	self.img_nodata:setVisible(false)

	local var_36_0 = cc.TableView:create(cc.size(self.tabviewpanel3:getContentSize().width, self.tabviewpanel3:getContentSize().height))

	var_36_0:setPosition(0, 0)
	var_36_0:setDelegate()
	var_36_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_36_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_36_0:setName("tableview_friend")
	self.tabviewpanel3:addChild(var_36_0, 99)

	self.tableviewfrined = var_36_0

	self:initFriendTableView()

	local var_36_3 = ((self.friendBtnindex == 1 and self.friendselectRescentindex or self.friendselectindex) - 1) * (100 / (#self.frienddata - self.tabviewpanel3:getContentSize().height / (120 + 10)))

	self.tableviewfrined:scrollToPercent((((self.friendBtnindex == 1 and self.friendselectRescentindex or self.friendselectindex) - 1) * (100 / (#self.frienddata - self.tabviewpanel3:getContentSize().height / (120 + 10))) > 100 or nil) and 100, nil, false)
end

function PopChatInterfaceLayer:initFriendTopBtn()
	for iter_37_0, iter_37_1 in ipairs(self.btn_fiends) do
		iter_37_1.id = iter_37_0

		iter_37_1:addTouchEventListener(function(arg_38_0, arg_38_1)
			if arg_38_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.friendBtnindex = arg_38_0.id

			self:initFriendPanel(true)
			self:updateFriendTopBtn()
		end)
	end

	self:updateFriendTopBtn()
end

function PopChatInterfaceLayer:updateFriendTopBtn()
	for iter_39_0, iter_39_1 in ipairs(self.btn_fiends) do
		if iter_39_0 == self.friendBtnindex then
			iter_39_1:loadTextures(var_0_20[iter_39_0].on, nil, var_0_20[iter_39_0].on, var_0_15)
		else
			iter_39_1:loadTextures(var_0_20[iter_39_0].off, nil, var_0_20[iter_39_0].off, var_0_15)
		end
	end
end

function PopChatInterfaceLayer:createFriendNode()
	local var_40_0 = self.items2:clone()
	local var_40_1 = AvatarSprite:create(tonumber(9200101))

	var_40_1:setPosition(cc.p(20, var_40_0:getContentSize().height / 2 - 25))
	var_40_1:setName("avatar_face_fl")
	var_40_1:setScale(var_40_0:getContentSize().height / var_40_1:getContentSize().height)
	var_40_0:addChild(var_40_1, 1)

	return var_40_0
end

function PopChatInterfaceLayer:updateFrinedNode(arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = ccui.Helper:seekWidgetByName(arg_41_1, "Image_66")
	local var_41_1 = ccui.Helper:seekWidgetByName(arg_41_1, "Image_67")
	local var_41_2 = ccui.Helper:seekWidgetByName(arg_41_1, "Image_69")
	local var_41_3 = ccui.Helper:seekWidgetByName(arg_41_1, "Label_70")
	local var_41_4 = ccui.Helper:seekWidgetByName(arg_41_1, "Label_68")
	local var_41_5 = ccui.Helper:seekWidgetByName(arg_41_1, "Button_39")
	local var_41_6 = ccui.Helper:seekWidgetByName(arg_41_1, "Image_42")

	self:updateFrindSelect(var_41_0, arg_41_3, var_41_2, var_41_3)
	self:updateFriendRead(var_41_2, var_41_3, arg_41_2.playerid)

	local var_41_7 = chat_system_manager:getPlayerInfoByPlayerId(arg_41_2.playerid)

	if var_41_7 then
		var_41_4:setString(var_41_7.name)
		ccui.Helper:seekWidgetByName(var_41_6, "Label_42"):setString("等级." .. var_41_7.level)
		;(function(arg_42_0, arg_42_1)
			local var_42_0

			if arg_42_1 == 4 then
				var_42_0 = "chat_system_layer/master.png"
			elseif arg_42_1 == 3 then
				var_42_0 = "chat_system_layer/univ.png"
			elseif arg_42_1 == 2 then
				var_42_0 = "chat_system_layer/senior.png"
			elseif arg_42_1 == 1 then
				var_42_0 = "chat_system_layer/junior.png"
			end

			arg_42_0:loadTexture(var_42_0, var_0_15)
		end)(var_41_6, var_41_7.class)
		self:updateFrindOnline(ccui.Helper:seekWidgetByName(arg_41_1, "Image_26"), var_41_7.lastlogin, var_41_4, var_41_0)
		self:updateFaceImg(arg_41_1, var_41_7.head_sculpture, arg_41_2.playerid, arg_41_3)
	end

	if var_41_0:isVisible() then
		var_41_2:setVisible(false)
	end

	var_41_5:setSwallowTouches(false)

	var_41_5.id = arg_41_3

	var_41_5:setTouchEnabled(true)
	var_41_5:addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_43_0:getTouchBeganPosition().y - arg_43_0:getTouchEndPosition().y) > 30 then
			return
		end

		if self.friendBtnindex == 1 then
			self.friendselectRescentindex = arg_43_0.id
		else
			self.friendselectindex = arg_43_0.id
		end

		self:updateTableViewPanel(self.friendselectindex, {
			data = self.frienddata,
			tableView = self.tableviewfrined,
			width = var_0_34,
			height = var_0_35
		})

		self.friendid = arg_41_2.playerid

		chat_system_manager:addReadData(self.friendid)
		self:initChatPanel(arg_41_2.playerid)
	end)
end

function PopChatInterfaceLayer.updateFrindOnline(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	if arg_44_2 == "-1" then
		arg_44_1:setVisible(false)

		if arg_44_4:isVisible() then
			arg_44_3:setColor(var_0_23.online)
			arg_44_1:setVisible(false)
		else
			arg_44_3:setColor(var_0_23.online)
			arg_44_1:setVisible(false)
		end
	else
		arg_44_1:setVisible(true)

		if arg_44_4:isVisible() then
			arg_44_3:setColor(var_0_23.online)
			arg_44_1:setVisible(false)
		else
			arg_44_3:setColor(var_0_23.offline)
			arg_44_1:setVisible(true)
		end
	end
end

function PopChatInterfaceLayer:updateFrindSelect(arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	if self.friendBtnindex == 1 then
		if self.friendselectRescentindex == arg_45_2 then
			arg_45_1:setVisible(true)
			chat_system_manager:addReadData(self.friendid)
		else
			arg_45_1:setVisible(false)
		end
	elseif self.friendselectindex == arg_45_2 then
		arg_45_1:setVisible(true)
		chat_system_manager:addReadData(self.friendid)
	else
		arg_45_1:setVisible(false)
	end
end

function PopChatInterfaceLayer.updateFriendRead(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = chat_system_manager:getFriendNoReadNewsNum(arg_46_3)

	if not var_46_0 or var_46_0 == 0 then
		arg_46_1:setVisible(false)

		return
	end

	arg_46_1:setVisible(true)

	if var_46_0 >= 100 then
		arg_46_2:setString("99+")
	else
		arg_46_2:setString("" .. var_46_0)
	end
end

function PopChatInterfaceLayer.updateFaceImg(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	if not arg_47_1 or not arg_47_2 or not arg_47_3 then
		return
	end

	arg_47_1:getChildByName("avatar_face_fl"):switchShowAvatar(tonumber(arg_47_2))
end

function PopChatInterfaceLayer:initFriendTableView()
	self.tableviewfrined:registerScriptHandler(function(arg_50_0, arg_50_1)
		return var_0_34, var_0_35
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableviewfrined:registerScriptHandler(function(arg_49_0, arg_49_1)
		local var_49_0 = arg_49_0:dequeueCell()

		if not var_49_0 then
			var_49_0 = cc.TableViewCell:create()

			local var_49_1 = self:createFriendNode()

			var_49_1:setName("node")
			var_49_1:setPosition(cc.p(0, 0))
			self:updateFrinedNode(var_49_1, self.frienddata[arg_49_1 + 1], arg_49_1 + 1)
			var_49_0:addChild(var_49_1)
		else
			self:updateFrinedNode(var_49_0:getChildByName("node"), self.frienddata[arg_49_1 + 1], arg_49_1 + 1)
		end

		return var_49_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableviewfrined:registerScriptHandler(function(arg_51_0, arg_51_1)
		return #self.frienddata
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableviewfrined:reloadData()
end

function PopChatInterfaceLayer.updateTableViewPanel(arg_52_0, arg_52_1, arg_52_2)
	if not arg_52_1 or not arg_52_2.data or not next(arg_52_2.data) or not arg_52_2.tableView or not arg_52_2.width or not arg_52_2.height then
		return
	end

	local var_52_0, var_52_1 = GetTableViewShowCellIdx(arg_52_2.tableView, {
		cellsize = cc.size(arg_52_2.width, arg_52_2.height),
		maxcount = #arg_52_2.data
	})

	for iter_52_0 = var_52_0, var_52_1 do
		arg_52_2.tableView:updateCellAtIndex(iter_52_0)
	end
end

function PopChatInterfaceLayer:initChatPanel(arg_53_1, arg_53_2)
	if self.isfirstlayer then
		chat_system_manager:resetChatTempDate()
		chat_system_manager:fetch_chat_message(1, function(arg_54_0, arg_54_1)
			self.isfirstlayer = false

			if arg_54_0 == 1 then
				if self.tabviewpanel1:getChildByName("tableview_chat") then
					self.tabviewpanel1:getChildByName("tableview_chat"):stopAllActions()
					self.tabviewpanel1:getChildByName("tableview_chat"):removeFromParent()

					self.tableviewchat = nil
				end

				self.lastId = 0
				self.chatid = 0

				self:resetChatQueue()

				local var_54_0 = chat_system_manager:getPlayerChatList(arg_53_1)

				if var_54_0 then
					for iter_54_0, iter_54_1 in ipairs(var_54_0) do
						if iter_54_1.message then
							self:pushBackChat(iter_54_1)
						end
					end
				end

				if not self.chatPool or not next(self.chatPool) then
					self.img_nodata:setVisible(true)
					self.img_nodata:getChildByName("Label_51"):setString(COMMUNITY_CHAT_SYSTEM.tips5)
				else
					self.img_nodata:setVisible(false)
				end

				local var_54_1 = cc.TableView:create(cc.size(self.tabviewpanel1:getContentSize().width, self.tabviewpanel1:getContentSize().height))

				var_54_1:setPosition(-6, 0)
				var_54_1:setDelegate()
				var_54_1:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
				var_54_1:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
				var_54_1:setName("tableview_chat")
				var_54_1:setVisible(true)
				self.tabviewpanel1:addChild(var_54_1, 99)

				self.tableviewchat = var_54_1

				if self.tableviewfrined then
					self:updateTableViewPanel((self.friendBtnindex == 1 or nil) and self.friendselectRescentindex, {
						data = self.frienddata,
						tableView = self.tableviewfrined,
						width = var_0_34,
						height = var_0_35
					})
				end

				self:initChatTableView(arg_53_2)
			end
		end)
	else
		if self.tabviewpanel1:getChildByName("tableview_chat") then
			self.tabviewpanel1:getChildByName("tableview_chat"):stopAllActions()
			self.tabviewpanel1:getChildByName("tableview_chat"):removeFromParent()

			self.tableviewchat = nil
		end

		self.lastId = 0
		self.chatid = 0

		self:resetChatQueue()

		local var_53_0 = chat_system_manager:getPlayerChatList(arg_53_1)

		if var_53_0 then
			for iter_53_0, iter_53_1 in ipairs(var_53_0) do
				if iter_53_1.message then
					self:pushBackChat(iter_53_1)
				end
			end
		end

		if not self.chatPool or not next(self.chatPool) then
			self.img_nodata:setVisible(true)
			self.img_nodata:getChildByName("Label_51"):setString(COMMUNITY_CHAT_SYSTEM.tips5)
		else
			self.img_nodata:setVisible(false)
		end

		local var_53_1 = cc.TableView:create(cc.size(self.tabviewpanel1:getContentSize().width, self.tabviewpanel1:getContentSize().height))

		var_53_1:setPosition(-6, 0)
		var_53_1:setDelegate()
		var_53_1:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
		var_53_1:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		var_53_1:setName("tableview_chat")
		self.tabviewpanel1:addChild(var_53_1, 99)

		self.tableviewchat = var_53_1

		if self.tableviewfrined then
			self:updateTableViewPanel((self.friendBtnindex == 1 or nil) and self.friendselectRescentindex, {
				data = self.frienddata,
				tableView = self.tableviewfrined,
				width = var_0_34,
				height = var_0_35
			})
		end

		self:initChatTableView(arg_53_2)
	end
end

function PopChatInterfaceLayer.createSystemChatNode(arg_55_0, arg_55_1)
	local var_55_0 = ccui.Layout:create()

	var_55_0:setContentSize(cc.size(640, 36))
	var_55_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_55_0:setBackGroundColor(cc.c3b(255, 150, 207))
	var_55_0:setTouchEnabled(false)
	var_55_0:setAnchorPoint(0, 0)

	local var_55_1 = ccui.ImageView:create("roleimage/role/chat_emotion/systemhead.png")

	var_55_0:addChild(var_55_1)
	var_55_1:setScale(140 / var_55_1:getContentSize().height)

	local var_55_2 = ccui.ImageView:create("chat_system_layer/chat_kuang_xitong.png", var_0_15)

	var_55_2:setScale9Enabled(true)
	var_55_2:setCapInsets(cc.rect(10, 22, 374, 6))
	var_55_0:addChild(var_55_2)

	contant = cc.Label:createWithTTF("", FONT_DES, 20)

	contant:setMaxLineWidth(360)
	contant:setLineBreakWithoutSpace(true)
	contant:setColor(cc.c3b(255, 255, 255))
	contant:setAnchorPoint(cc.p(0, 1))
	var_55_2:addChild(contant)

	local var_55_3 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_55_3:setMaxLineWidth(200)
	var_55_3:setColor(cc.c3b(135, 103, 250))
	var_55_3:setString(arg_55_1.nickname)
	var_55_3:setAnchorPoint(cc.p(0, 0))
	var_55_2:addChild(var_55_3)

	local var_55_4 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_55_4:setMaxLineWidth(100)
	var_55_4:setString(chat_system_manager:dealChatTime(arg_55_1.sendtime))
	var_55_4:setAnchorPoint(cc.p(0, 0))
	var_55_4:setColor(cc.c3b(76, 88, 121))
	var_55_2:addChild(var_55_4)
	contant:setString((chat_system_manager:getSystemTipsText(arg_55_1.playerid, (json.decode(arg_55_1.contant or "")))))
	var_55_3:setString(chat_system_manager:getSystemTipsTitle(arg_55_1.playerid))
	var_55_4:setString(chat_system_manager:dealChatTime(arg_55_1.sendtime))

	if contant:getContentSize().height >= 140 then
		var_55_0:setContentSize(cc.size(640, contant:getContentSize().height + var_55_3:getContentSize().height * 2 + 20))
	else
		var_55_0:setContentSize(cc.size(640, var_55_1:getContentSize().height * var_55_1:getScaleX() - 40))
	end

	if contant:getContentSize().height > 32 then
		var_55_2:setContentSize(cc.size(392, contant:getContentSize().height + 10))
	else
		var_55_2:setContentSize(cc.size(392, 32))
	end

	var_55_1:setPosition(cc.p(var_55_1:getContentSize().width / 2 * var_55_1:getScaleX() - 15, var_55_0:getContentSize().height / 2))
	var_55_2:setPosition(cc.p(var_55_1:getPositionX() + var_55_1:getContentSize().width / 2 * var_55_1:getScaleX() + var_55_2:getContentSize().width / 2 - 10, var_55_0:getContentSize().height / 2))
	contant:setPosition(cc.p(16, var_55_2:getContentSize().height - 6))
	var_55_3:setPosition(cc.p(0, var_55_2:getContentSize().height + 2))
	var_55_4:setPosition(cc.p(var_55_3:getPositionX() + var_55_3:getContentSize().width + 3, var_55_3:getPositionY()))

	return var_55_0
end

function PopChatInterfaceLayer:createChatNode(arg_56_1)
	if arg_56_1.playerid and arg_56_1.playerid < 0 then
		return self:createSystemChatNode(arg_56_1)
	end

	local var_56_0 = ccui.Layout:create()

	var_56_0:setContentSize(cc.size(640, 36))
	var_56_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_56_0:setBackGroundColor(cc.c3b(255, 150, 207))
	var_56_0:setTouchEnabled(false)
	var_56_0:setAnchorPoint(0, 0)

	local var_56_1 = 1

	if arg_56_1.myself then
		var_56_1 = 2
	end

	local function var_56_2(arg_57_0, arg_57_1)
		local var_57_0

		if arg_57_1 == 4 then
			var_57_0 = "chat_system_layer/master.png"
		elseif arg_57_1 == 3 then
			var_57_0 = "chat_system_layer/univ.png"
		elseif arg_57_1 == 2 then
			var_57_0 = "chat_system_layer/senior.png"
		elseif arg_57_1 == 1 then
			var_57_0 = "chat_system_layer/junior.png"
		end

		arg_57_0:loadTexture(var_57_0, var_0_15)
	end

	local var_56_3 = AvatarSprite:create(tonumber(arg_56_1.head_sculpture))

	var_56_3:setName("avatar_face_chat")
	var_56_3:setScale(var_0_25)

	if var_56_1 == 1 then
		var_56_3:setPosition(cc.p(20, var_56_0:getContentSize().height / 2 + 30))
	else
		var_56_3:setPosition(cc.p(var_56_0:getContentSize().width - var_56_3:getContentSize().width / 2 * var_0_25 - 36, var_56_0:getContentSize().height / 2 + 36))
	end

	var_56_3:addTouchEventListener(function(arg_58_0, arg_58_1)
		if arg_58_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_56_1.playerid <= 0 then
			return
		end

		if var_56_1 == 1 then
			LayerManager:pushInLayer("PopFriendIntroduceLayer", {
				openlalei = 1,
				playeruid = arg_56_1.playerid,
				reportinfo = {
					targetplayerid = arg_56_1.playerid,
					targetnickname = arg_56_1.nickname,
					chartcontace1 = arg_56_1.contant
				},
				callback = callback
			})
		end
	end)
	var_56_0:addChild(var_56_3)

	local var_56_4 = ccui.ImageView:create("chat_system_layer/master.png", var_0_15)

	var_56_0:addChild(var_56_4)
	var_56_4:setTouchEnabled(false)
	var_56_2(var_56_4, arg_56_1.class)

	local var_56_5 = cc.Label:createWithTTF("等级." .. arg_56_1.level, FONT_DES, 16)

	var_56_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_56_5:setPosition(cc.p(var_56_4:getContentSize().width / 2, var_56_4:getContentSize().height / 2))
	var_56_4:addChild(var_56_5)

	local var_56_6 = ccui.ImageView:create("chat_system_layer/chat_kuang.png", var_0_15)

	if var_56_1 == 2 then
		var_56_6:loadTexture("chat_system_layer/chat_kuang_my.png", var_0_15)
	end

	var_56_0:addChild(var_56_6)
	var_56_6:setTouchEnabled(false)

	local var_56_7
	local var_56_8 = 0

	if arg_56_1.contant then
		var_56_7 = cc.Label:createWithTTF("", FONT_DES, 22)

		var_56_7:setMaxLineWidth(var_0_38[var_56_1])
		var_56_7:setLineBreakWithoutSpace(true)

		if var_56_1 == 1 then
			var_56_7:setAnchorPoint(cc.p(0, 1))
		else
			var_56_7:setAnchorPoint(cc.p(1, 1))
		end

		var_56_7:setString(arg_56_1.contant)
		var_56_7:setColor(cc.c3b(213, 213, 213))

		if var_56_1 == 2 then
			var_56_7:setColor(cc.c3b(14, 25, 57))
		end

		var_56_6:addChild(var_56_7)

		if var_56_7:getContentSize().height + 20 > var_0_37[var_56_1] then
			var_56_8 = var_56_7:getContentSize().height + 20 - var_0_37[var_56_1]
		end

		if var_56_7:getContentSize().height + 20 > var_0_37[var_56_1] then
			var_56_8 = var_56_7:getContentSize().height + 20 - var_0_37[var_56_1]
		end
	elseif arg_56_1.faceid then
		var_56_7 = ChatEmotionSprite:create(tonumber(arg_56_1.faceid))

		var_56_7:setPosition(cc.p(var_56_6:getContentSize().width / 2, var_56_6:getContentSize().height / 2))
		var_56_7:setScale(var_0_26)
		var_56_6:addChild(var_56_7)

		if var_56_7:getContentSize().height * var_0_26 + 10 > var_0_37[var_56_1] then
			var_56_8 = var_56_7:getContentSize().height * var_0_26 - 40 - var_0_37[var_56_1]
		end
	end

	var_56_6:setScale9Enabled(true)

	if var_56_1 == 1 then
		var_56_6:setCapInsets(cc.rect(10, 22, 374, 6))
	else
		var_56_6:setCapInsets(cc.rect(3, 22, 386, 6))
	end

	local var_56_9 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_56_9:setMaxLineWidth(200)
	var_56_9:setColor(cc.c3b(84, 152, 216))
	var_56_9:setString(arg_56_1.nickname)
	var_56_6:addChild(var_56_9)

	local var_56_10 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_56_10:setMaxLineWidth(100)
	var_56_10:setString(chat_system_manager:dealChatTime(arg_56_1.sendtime))
	var_56_10:setColor(cc.c3b(76, 88, 121))
	var_56_6:addChild(var_56_10)

	if arg_56_1.faceid then
		if not chat_system_manager:checkIsSpineEmotion(arg_56_1.faceid) then
			var_56_0:setContentSize(cc.size(640, var_56_3:getContentSize().height * var_0_25 + var_56_9:getContentSize().height + 10))
		else
			var_56_0:setContentSize(cc.size(640, 140 + var_56_9:getContentSize().height + 14 + 10))
		end
	elseif var_56_7:getContentSize().height >= var_0_33 then
		if var_56_1 == 1 then
			var_56_0:setContentSize(cc.size(640, var_56_7:getContentSize().height + var_56_9:getContentSize().height * 2 + 20))
		else
			var_56_0:setContentSize(cc.size(640, var_56_7:getContentSize().height + var_56_9:getContentSize().height * 2 + 20))
		end
	else
		var_56_0:setContentSize(cc.size(640, var_56_3:getContentSize().height * var_0_25 - 10))
	end

	if arg_56_1.faceid then
		if var_56_1 == 1 then
			if not chat_system_manager:checkIsSpineEmotion(arg_56_1.faceid) then
				var_56_6:setContentSize(cc.size(var_56_7:getContentSize().width * var_0_26 + 10 + 4, var_56_8 + var_0_37[var_56_1] + 10 + 10 + 30))
				var_56_7:setPosition(cc.p(-23, -24))
				var_56_6:setPosition(cc.p(var_56_3:getPositionX() + var_56_3:getContentSize().width * var_0_25 / 2 + var_56_6:getContentSize().width / 2 + 43, var_56_6:getContentSize().height / 2 + 3))
				var_56_3:setPosition(cc.p(20, var_56_0:getContentSize().height / 2 - 30))
				var_56_4:setPosition(cc.p(var_56_3:getPositionX() + var_56_4:getContentSize().width / 2 - 10, var_56_3:getPositionY() - var_56_3:getContentSize().height * var_0_25 / 2 - var_56_4:getContentSize().height / 2 + 65))
				var_56_9:setAnchorPoint(cc.p(0, 0))
				var_56_9:setPosition(cc.p(0, var_56_6:getContentSize().height + 2))
				var_56_10:setAnchorPoint(cc.p(0, 0))
				var_56_10:setPosition(cc.p(var_56_9:getPositionX() + var_56_9:getContentSize().width + 3, var_56_9:getPositionY()))
			else
				var_56_6:setContentSize(cc.size(154, 154))
				var_56_7:setPosition(cc.p(34, 24))
				var_56_7:setScale(140 / var_56_3:getContentSize().height)
				var_56_6:setPosition(cc.p(var_56_3:getPositionX() + var_56_3:getContentSize().width * var_0_25 / 2 + var_56_6:getContentSize().width / 2 + 43, var_56_6:getContentSize().height / 2 + 3))
				var_56_3:setPosition(cc.p(20, var_56_0:getContentSize().height / 2 - 30))
				var_56_4:setPosition(cc.p(var_56_3:getPositionX() + var_56_4:getContentSize().width / 2 - 10, var_56_3:getPositionY() - var_56_3:getContentSize().height * var_0_25 / 2 - var_56_4:getContentSize().height / 2 + 65))
				var_56_9:setAnchorPoint(cc.p(0, 0))
				var_56_9:setPosition(cc.p(0, var_56_6:getContentSize().height + 2))
				var_56_10:setAnchorPoint(cc.p(0, 0))
				var_56_10:setPosition(cc.p(var_56_9:getPositionX() + var_56_9:getContentSize().width + 3, var_56_9:getPositionY()))
				self:adjustChatEmationPos(var_56_7, arg_56_1.faceid, var_56_1)
			end
		elseif not chat_system_manager:checkIsSpineEmotion(arg_56_1.faceid) then
			var_56_6:setContentSize(cc.size(var_56_7:getContentSize().width * var_0_26 + 10 + 4, var_56_8 + var_0_37[var_56_1] + 10 + 10 + 10 + 20))
			var_56_7:setPosition(cc.p(-26, -25))
			var_56_6:setPosition(cc.p(var_56_3:getPositionX() - var_56_3:getContentSize().width * var_0_25 / 2 - var_56_6:getContentSize().width / 2 + 52, var_56_6:getContentSize().height / 2 + 3))
			var_56_3:setPosition(cc.p(var_56_0:getContentSize().width - var_56_3:getContentSize().width / 2 * var_0_25 - 36, var_56_0:getContentSize().height / 2 - 30))
			var_56_4:setPosition(cc.p(var_56_3:getPositionX() + var_56_4:getContentSize().width / 2 - 10, var_56_3:getPositionY() - var_56_3:getContentSize().height * var_0_25 / 2 - var_56_4:getContentSize().height / 2 + 65))
			var_56_9:setAnchorPoint(cc.p(1, 0))
			var_56_9:setPosition(cc.p(var_56_6:getContentSize().width - 10, var_56_6:getContentSize().height + 3))
			var_56_10:setAnchorPoint(cc.p(1, 0))
			var_56_10:setPosition(cc.p(var_56_9:getPositionX() - var_56_9:getContentSize().width - 4, var_56_9:getPositionY()))
		else
			var_56_6:setContentSize(cc.size(154, 154))
			var_56_7:setPosition(cc.p(34, 24))
			var_56_7:setScale(140 / var_56_3:getContentSize().height)
			var_56_6:setPosition(cc.p(var_56_3:getPositionX() - var_56_3:getContentSize().width * var_0_25 / 2 - var_56_6:getContentSize().width / 2 + 52, var_56_6:getContentSize().height / 2 + 3))
			var_56_3:setPosition(cc.p(var_56_0:getContentSize().width - var_56_3:getContentSize().width / 2 * var_0_25 - 36, var_56_0:getContentSize().height / 2 - 30))
			var_56_4:setPosition(cc.p(var_56_3:getPositionX() + var_56_4:getContentSize().width / 2 - 10, var_56_3:getPositionY() - var_56_3:getContentSize().height * var_0_25 / 2 - var_56_4:getContentSize().height / 2 + 65))
			var_56_9:setAnchorPoint(cc.p(1, 0))
			var_56_9:setPosition(cc.p(var_56_6:getContentSize().width - 10, var_56_6:getContentSize().height + 3))
			var_56_10:setAnchorPoint(cc.p(1, 0))
			var_56_10:setPosition(cc.p(var_56_9:getPositionX() - var_56_9:getContentSize().width - 4, var_56_9:getPositionY()))
			self:adjustChatEmationPos(var_56_7, arg_56_1.faceid, var_56_1)
		end
	else
		var_56_6:setContentSize(cc.size(var_56_7:getContentSize().width + 20 + 10, var_56_8 + var_0_37[var_56_1]))

		if var_56_1 == 1 then
			var_56_6:setPosition(cc.p(var_56_3:getPositionX() + var_56_3:getContentSize().width * var_0_25 / 2 + var_56_6:getContentSize().width / 2 + 42, var_56_0:getContentSize().height / 2))
			var_56_7:setPosition(cc.p(18, var_56_6:getContentSize().height - 10))
			var_56_3:setPosition(cc.p(20, var_56_0:getContentSize().height / 2 - 30))
			var_56_4:setPosition(cc.p(var_56_3:getPositionX() + var_56_4:getContentSize().width / 2 - 10, var_56_3:getPositionY() - var_56_3:getContentSize().height * var_0_25 / 2 - var_56_4:getContentSize().height / 2 + 65))
			var_56_9:setAnchorPoint(cc.p(0, 0))
			var_56_9:setPosition(cc.p(0, var_56_6:getContentSize().height + 2))
			var_56_10:setAnchorPoint(cc.p(0, 0))
			var_56_10:setPosition(cc.p(var_56_9:getPositionX() + var_56_9:getContentSize().width + 3, var_56_9:getPositionY()))
		else
			var_56_6:setPosition(cc.p(var_56_3:getPositionX() - var_56_3:getContentSize().width * var_0_25 / 2 - var_56_6:getContentSize().width / 2 + 50, var_56_0:getContentSize().height / 2))
			var_56_7:setPosition(cc.p(var_56_6:getContentSize().width - 16, var_56_6:getContentSize().height - 10))
			var_56_3:setPosition(cc.p(var_56_0:getContentSize().width - var_56_3:getContentSize().width / 2 * var_0_25 - 36, var_56_0:getContentSize().height / 2 - 30))
			var_56_4:setPosition(cc.p(var_56_3:getPositionX() + var_56_4:getContentSize().width / 2 - 10, var_56_3:getPositionY() - var_56_3:getContentSize().height * var_0_25 / 2 - var_56_4:getContentSize().height / 2 + 65))
			var_56_9:setAnchorPoint(cc.p(1, 0))
			var_56_9:setPosition(cc.p(var_56_6:getContentSize().width - 10, var_56_6:getContentSize().height + 3))
			var_56_10:setAnchorPoint(cc.p(1, 0))
			var_56_10:setPosition(cc.p(var_56_9:getPositionX() - var_56_9:getContentSize().width - 4, var_56_9:getPositionY()))
		end
	end

	return var_56_0
end

function PopChatInterfaceLayer:initChatTableView(arg_59_1)
	self.tableviewchat:registerScriptHandler(function(arg_62_0)
		return #self.chatPool
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableviewchat:registerScriptHandler(function(arg_63_0, arg_63_1)
		return 640, self:createChatNode(self.chatPool[arg_63_1 + 1]):getContentSize().height + 6
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableviewchat:registerScriptHandler(function(arg_60_0, arg_60_1)
		local var_60_0 = arg_60_0:dequeueCell()

		if not var_60_0 then
			var_60_0 = cc.TableViewCell:new()

			var_60_0:setContentSize(cc.size(640, self:createChatNode(self.chatPool[arg_60_1 + 1]):getContentSize().height + 30))
		else
			var_60_0:removeAllChildren()
		end

		;(function()
			local var_61_0 = self:createChatNode(self.chatPool[arg_60_1 + 1])

			var_61_0:setPosition(cc.p(0, 0))
			var_61_0:setName("content")
			var_60_0:addChild(var_61_0)
		end)()

		return var_60_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableviewchat:registerScriptHandler(function(arg_64_0)
		self.curContainerPosy = arg_64_0:getContainer():getPositionY()
		self.curContainerHeight = arg_64_0:getContainer():getContentSize().height
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	self.tableviewchat:reloadData()

	if not arg_59_1 or arg_59_1 ~= 2 then
		self:beginListener()
	end

	if arg_59_1 and type(arg_59_1) == "function" then
		arg_59_1()
	end
end

function PopChatInterfaceLayer:dealWithTheTableView(arg_65_1)
	if arg_65_1 then
		self:initCommityChatData()
	elseif not self.curContainerPosy or self.curContainerPosy == 0 then
		if self.topbtnindex == 1 then
			self:initFriendPanel(true)
		elseif self.topbtnindex == 2 then
			self:initCommityChatData()
		end
	else
		local var_65_0 = self.curContainerHeight
		local var_65_1 = self.curContainerPosy

		local function var_65_2()
			self.curContainerPosy = self.tableviewchat:getContainer():getPositionY()
			self.curContainerHeight = self.tableviewchat:getContainer():getContentSize().height

			if self.tableviewchat then
				self.tableviewchat:scrollToPercent(100 - (math.abs(var_65_1) + (self.curContainerHeight - var_65_0)) / self.curContainerHeight * 100, nil, false)
			end
		end

		if self.topbtnindex == 1 then
			self:initFriendPanel(var_65_2)
		elseif self.topbtnindex == 2 then
			self:initCommityChatData()
			var_65_2()
		end
	end
end

function PopChatInterfaceLayer.isIconMessge(arg_67_0, arg_67_1)
	if not arg_67_1 then
		return false, nil
	end

	local var_67_0 = string.match(arg_67_1, var_0_32 .. "(%d+)")

	if var_67_0 and var_67_0 ~= "" then
		return true, tonumber(var_67_0)
	else
		return false, nil
	end
end

function PopChatInterfaceLayer:getLastChat()
	if #self.chatPool > 0 then
		return self.chatPool[#self.chatPool]
	end
end

function PopChatInterfaceLayer:pushBackChat(arg_69_1)
	if self.topbtnindex == 1 then
		local var_69_0 = chat_system_manager:getPlayerInfoByPlayerId(self.friendid)

		if not arg_69_1 or not next(arg_69_1) or not var_69_0 or not next(var_69_0) then
			return
		end

		self.chatid = self.chatid + 1

		local var_69_1 = var_69_0.level or 0
		local var_69_2 = var_69_0.class or 0
		local var_69_3 = self.friendid
		local var_69_4 = var_69_0.name
		local var_69_5 = var_69_0.head_sculpture
		local var_69_6 = arg_69_1.myself

		if arg_69_1.myself then
			var_69_4 = playermodel.nickname
			var_69_1 = playermodel.grade
			var_69_2 = playermodel.class
			var_69_5 = playermodel.head_sculpture
		end

		local var_69_8, var_69_9 = self:isIconMessge(arg_69_1.message)
		local var_69_11 = {
			id = self.chatid,
			level = var_69_1,
			class = var_69_2,
			playerid = var_69_3,
			nickname = var_69_4,
			sendtime = arg_69_1.time,
			head_sculpture = var_69_5,
			contant = (var_69_8 or nil) and nil,
			myself = var_69_6,
			faceid = var_69_9
		}

		if #self.chatPool < var_0_24 then
			table.insert(self.chatPool, var_69_11)
		else
			table.remove(self.chatPool, 1)
			table.insert(self.chatPool, var_69_11)
		end

		if var_69_6 then
			self:beginListener()
		end
	elseif self.topbtnindex == 2 then
		if not arg_69_1 or not next(arg_69_1) then
			return
		end

		self.chatid = self.chatid + 1

		local var_69_12 = arg_69_1.level or 0
		local var_69_13 = arg_69_1.class or 0
		local var_69_14 = arg_69_1.playerid
		local var_69_15 = arg_69_1.nickname
		local var_69_16 = arg_69_1.head_sculpture
		local var_69_17 = arg_69_1.myself

		if arg_69_1.playerid and var_69_14 == playermodel.playerid then
			var_69_17 = true
		end

		if var_69_17 then
			var_69_15 = playermodel.nickname
			var_69_12 = playermodel.grade
			var_69_13 = playermodel.class
			var_69_16 = playermodel.head_sculpture
		end

		local var_69_19, var_69_20 = self:isIconMessge(arg_69_1.msg)
		local var_69_22 = {
			id = self.chatid,
			level = var_69_12,
			class = var_69_13,
			playerid = var_69_14,
			nickname = var_69_15,
			sendtime = arg_69_1.time,
			head_sculpture = var_69_16,
			contant = (var_69_19 or nil) and nil,
			myself = var_69_17,
			faceid = var_69_20
		}

		if #self.chatPool < var_0_24 then
			table.insert(self.chatPool, var_69_22)
		else
			table.remove(self.chatPool, 1)
			table.insert(self.chatPool, var_69_22)
		end
	end
end

function PopChatInterfaceLayer.resetChatQueue(arg_70_0)
	arg_70_0.chatPool = {}
end

function PopChatInterfaceLayer.beginListener(arg_71_0)
	(function()
		if not arg_71_0.tableviewchat then
			return
		end

		local var_72_0 = arg_71_0:getLastChat()

		if not arg_71_0.chatPool or not next(arg_71_0.chatPool) then
			arg_71_0.img_nodata:setVisible(true)
		else
			arg_71_0.img_nodata:setVisible(false)
		end

		if var_72_0 then
			if arg_71_0.lastId ~= var_72_0.id then
				arg_71_0.tableviewchat:reloadData()

				if arg_71_0.tableviewchat:cellAtIndex(0) then
					if ((arg_71_0.zoomstatus == 2 or nil) and var_0_27.rootbg.up - 200 - 40 - 40 - 40) < arg_71_0.tableviewchat:cellAtIndex(0):getPositionY() then
						arg_71_0.tableviewchat:setContentOffset(cc.p(0, 0), false)
					end
				end

				arg_71_0.lastId = var_72_0.id
			end
		end
	end)()
end

function PopChatInterfaceLayer:initBottompanel()
	self:createInPutLayer()
	self:initSendBtn()
	self.icon_btn:addTouchEventListener(function(arg_74_0, arg_74_1)
		if arg_74_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_74_0:isBright() then
			return
		end

		arg_74_0:setBright(false)

		local function var_74_0()
			if var_0_14 then
				arg_74_0:setBright(true)
			end
		end

		if not self.emotionpanel:isVisible() then
			arg_74_0:loadTextures(var_0_22.off, var_0_22.off, var_0_22.off, var_0_15)
			self:initEmotionSideBarUI(var_74_0)
		else
			arg_74_0:loadTextures(var_0_22.on, var_0_22.on, var_0_22.on, var_0_15)
			self.emotionpanel:setVisible(false)
			var_74_0()
		end
	end)
end

function PopChatInterfaceLayer:initEmotionPanel(arg_76_1)
	self.iconlistView:removeAllChildren()
	self.iconlistView:setItemsMargin(0)

	self.emotionbtns = {}

	self.emotionpanel:setVisible(true)

	self.emotiontypedata = chat_system_manager:getEmotionTypeData(arg_76_1)

	for iter_76_0, iter_76_1 in ipairs(self.emotiontypedata) do
		local var_76_0 = self.item5:clone()
		local var_76_1 = iter_76_1.image_id and "roleimage/role/chat_emotion/" .. iter_76_1.image_id .. ".png" or "roleimage/role/chat_emotion/" .. iter_76_1.default .. ".png"

		var_76_0:getChildByName("Button_61"):loadTextures(var_76_1, var_76_1, var_76_1)
		var_76_0:getChildByName("Button_61"):setScale(var_76_0:getContentSize().height / 120)

		var_76_0.id = iter_76_1.icontype
		var_76_0:getChildByName("Button_61").id = iter_76_1.icontype

		table.insert(self.emotionbtns, var_76_0)
		var_76_0:getChildByName("Button_61"):addTouchEventListener(function(arg_77_0, arg_77_1)
			if arg_77_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_77_0:getTouchBeganPosition().y - arg_77_0:getTouchEndPosition().y) > 30 then
				return
			end

			self.icontype = arg_77_0.id

			self:updateEmotionBtnStatus()
		end)
		self.iconlistView:pushBackCustomItem(var_76_0)
	end

	self:initIconType(arg_76_1)
	self:updateEmotionBtnStatus()
end

function PopChatInterfaceLayer:initEmotionSideBarUI(arg_78_1)
	self.iconlistView2:removeAllChildren()
	self.iconlistView2:setItemsMargin(20)
	self.iconlistView:removeAllChildren()
	self.tabviewpanel2:removeAllChildren()

	self.emotionfunbtns = {}

	self.emotionpanel:setVisible(true)

	for iter_78_0, iter_78_1 in ipairs(var_0_21) do
		local var_78_0 = self.items3:clone()

		var_78_0:getChildByName("Button_61"):loadTextures(iter_78_1.off, nil, iter_78_1.off, var_0_15)

		var_78_0.id = iter_78_0
		var_78_0:getChildByName("Button_61").id = iter_78_0

		table.insert(self.emotionfunbtns, var_78_0)
		var_78_0:getChildByName("Button_61"):addTouchEventListener(function(arg_79_0, arg_79_1)
			if arg_79_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_79_0:getTouchBeganPosition().y - arg_79_0:getTouchEndPosition().y) > 30 then
				return
			end

			self.emontiontype = arg_79_0.id

			self:updateEmotionSideBarUI()
		end)
		self.iconlistView2:pushBackCustomItem(var_78_0)
	end

	self:updateEmotionSideBarUI()

	if arg_78_1 then
		arg_78_1()
	end
end

function PopChatInterfaceLayer:updateEmotionSideBarUI()
	self.emotionmasklayer:setVisible(false)

	for iter_80_0, iter_80_1 in pairs(self.emotionfunbtns) do
		if self.emontiontype == iter_80_0 then
			iter_80_1:getChildByName("Button_61"):loadTextures(var_0_21[iter_80_0].on, nil, var_0_21[iter_80_0].on, var_0_15)
		else
			iter_80_1:getChildByName("Button_61"):loadTextures(var_0_21[iter_80_0].off, nil, var_0_21.on, var_0_15)
		end
	end

	local var_80_0 = {
		function()
			self:initEmotionPanel()
		end,
		function()
			self:initEmotionPanel(2)
		end
	}

	self.tabviewpanel2:removeAllChildren()
	self.iconlistView:removeAllChildren()

	if var_80_0[self.emontiontype] then
		var_80_0[self.emontiontype]()
	end
end

function PopChatInterfaceLayer:updateEmotionBtnStatus()
	for iter_83_0, iter_83_1 in pairs(self.emotionbtns) do
		if self.icontype == iter_83_1.id then
			iter_83_1:getChildByName("selet"):setVisible(true)
			self:updateEmotionSelectUI()
		else
			iter_83_1:getChildByName("selet"):setVisible(false)
		end
	end
end

function PopChatInterfaceLayer:updateEmotionSelectUI()
	self.emotiondata = chat_system_manager:getEmotionData(self.icontype)

	if self.tabviewpanel2:getChildByName("tableview_emotion") then
		self.tabviewpanel2:removeAllChildren()

		self.tableviewemotion = nil
	end

	if not self.emotiondata or not next(self.emotiondata) then
		return
	end

	local var_84_0 = cc.TableView:create(cc.size(self.tabviewpanel2:getContentSize().width, self.tabviewpanel2:getContentSize().height))

	var_84_0:setPosition(0, 0)
	var_84_0:setDelegate()
	var_84_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_84_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_84_0:setName("tableview_emotion")
	self.tabviewpanel2:addChild(var_84_0, 99)

	self.tableviewemotion = var_84_0

	self:initEmotionTableView()

	if chat_system_manager:checkEmotionIsHave(self.icontype) then
		self.emotionmasklayer:setVisible(false)
	else
		self.emotionmasklayer:setVisible(true)
		self.emotionmasklayer:getChildByName("Label_11"):getVirtualRenderer():setMaxLineWidth(500)
		self.emotionmasklayer:getChildByName("Label_11"):setString(chat_system_manager:getMaskLayerTips(self.icontype))
		self.emotionmasklayer:addTouchEventListener(function(arg_85_0, arg_85_1)
			if arg_85_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_85_0 = chat_system_manager:getMaskLayerJumpID(self.icontype) or "1-35"
			local var_85_1 = cc.EventCustom:new("switchShowLayer")

			var_85_1.layerName = "MarketLayer"
			var_85_1.initparam = {
				returnLayer = "FightLayer",
				singleMarket = {
					var_85_0
				}
			}

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_85_1)
		end)
	end
end

function PopChatInterfaceLayer:createEmotionNode(arg_86_1)
	local var_86_0 = self.item4:clone()
	local var_86_1 = ChatEmotionSprite:create(tonumber((arg_86_1 or nil) and (arg_86_1.id or chat_system_manager:getDefulatFaceid())))

	if arg_86_1 and arg_86_1.image_id then
		var_86_1:setPosition(cc.p(-22, -20))
		var_86_1:setScale(var_86_0:getContentSize().height / var_86_1:getContentSize().height)
	else
		var_86_1:setPosition(cc.p(6, 0))
		var_86_1:setScale(120 / var_86_1:getContentSize().height)
	end

	var_86_1:setName("emotionavatar")
	var_86_0:addChild(var_86_1, 1)
	self:adjustEmationPos(var_86_0, arg_86_1)

	return var_86_0
end

function PopChatInterfaceLayer:updateEmontionTableViewPanel()
	if not self.tableviewemotion or not self.emotiondata then
		return
	end

	local var_87_0, var_87_1 = GetTableViewShowCellIdx(self.tableviewemotion, {
		cellsize = cc.size(var_0_39, var_0_40),
		maxcount = self:getCurDataListLen()
	})

	for iter_87_0 = var_87_0, var_87_1 do
		self.tableviewemotion:updateCellAtIndex(iter_87_0)
	end
end

function PopChatInterfaceLayer:getCurDataListLen()
	local var_88_0 = math.ceil(#self.emotiondata / 4)

	if var_88_0 < 4 then
		var_88_0 = 4
	end

	return var_88_0
end

function PopChatInterfaceLayer:initEmotionTableView()
	self.tableviewemotion:registerScriptHandler(function(arg_94_0, arg_94_1)
		return var_0_39, var_0_35
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableviewemotion:registerScriptHandler(function(arg_90_0, arg_90_1)
		local var_90_0 = arg_90_0:dequeueCell()

		if not var_90_0 then
			var_90_0 = cc.TableViewCell:create()

			local var_90_1 = 4

			for iter_90_0 = 1, 4 do
				local var_90_2 = self:createEmotionNode(self.emotiondata[var_90_1 * arg_90_1 + iter_90_0])

				var_90_2:setName("sp_" .. iter_90_0)
				var_90_2:setPosition(var_0_41[iter_90_0])
				var_90_2:getChildByName("Button_107"):setSwallowTouches(false)
				var_90_2:getChildByName("Button_107"):addTouchEventListener(function(arg_91_0, arg_91_1)
					if arg_91_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_91_0:getTouchBeganPosition().y - arg_91_0:getTouchEndPosition().y) > 50 then
						return
					end

					self.iconselectindex = arg_91_0.selectindex

					local var_91_0

					if self.emotionpanel:isVisible() and self.iconselectindex and (self.emontiontype == 1 or self.emontiontype == 2) and self.emotiondata and self.emotiondata[self.iconselectindex] and self.emotiondata[self.iconselectindex].id then
						var_91_0 = var_0_32 .. self.emotiondata[self.iconselectindex].id

						if self.topbtnindex == 1 then
							var_91_0 = var_0_32 .. self.emotiondata[self.iconselectindex].id

							chat_system_manager:send_chat_message(1, self.friendid, var_0_32 .. self.emotiondata[self.iconselectindex].id, function(arg_92_0)
								if arg_92_0 == 1 then
									local var_92_0 = chat_system_manager:getPlayerInfoByPlayerId(self.friendid)
									local var_92_1 = {
										myself = true,
										isread = true,
										level = var_92_0.level,
										class = var_92_0.class,
										playerid = self.friendid,
										name = var_92_0.name,
										time = self:global_format_time_by_date((time_check_manager:getCurTime())),
										message = var_91_0
									}

									self:pushBackChat(var_92_1)
									chat_system_manager:updateRecentFriend(self.friendid)
									chat_system_manager:inserChartData(var_92_1)
									self.emotionpanel:setVisible(false)

									self.iconselectindex = nil
								elseif arg_92_0 == 2 then
									global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips6)
								elseif arg_92_0 == 3 then
									global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips7)
								elseif arg_92_0 == 4 then
									global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips3)
								elseif arg_92_0 == 5 then
									global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips4)
								elseif arg_92_0 == 9999 then
									global_ShowBlockWords("社团系统已关闭")
								end
							end)
						elseif self.topbtnindex == 2 then
							if not community_system_manager:checkchatIsCD() then
								community_system_manager:family_chat(var_91_0, function(arg_93_0)
									if arg_93_0 == 1 then
										local var_93_0 = {
											myself = true,
											time = self:global_format_time_by_date((time_check_manager:getCurTime())),
											msg = var_91_0
										}

										self.emotionpanel:setVisible(false)

										self.iconselectindex = nil
									elseif arg_93_0 == 2 then
										global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips2)
									elseif arg_93_0 == 3 then
										global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips3)
									elseif arg_93_0 == 4 then
										global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips4)
									elseif arg_93_0 == 9999 then
										global_ShowBlockWords("社团系统已关闭")
									end
								end)
							else
								global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips11)
							end
						end
					end
				end)

				if self.emotiondata[var_90_1 * arg_90_1 + iter_90_0] then
					if self.emotiondata[var_90_1 * arg_90_1 + iter_90_0].id or nil then
						var_90_2:setVisible(true)

						var_90_2.index = arg_90_1
						var_90_2:getChildByName("Button_107").selectindex = var_90_1 * arg_90_1 + iter_90_0

						goto label_90_0
					end
				end

				var_90_2:setVisible(false)

				::label_90_0::

				if self.iconselectindex == var_90_1 * arg_90_1 + iter_90_0 then
					var_90_2:getChildByName("Image_66"):setVisible(false)
				else
					self.iconitem = nil

					var_90_2:getChildByName("Image_66"):setVisible(false)
				end

				var_90_0:addChild(var_90_2)
			end
		else
			local var_90_4 = 4

			for iter_90_1 = 1, 4 do
				local var_90_5 = var_90_0:getChildByName("sp_" .. iter_90_1)

				if self.emotiondata[var_90_4 * arg_90_1 + iter_90_1] then
					local var_90_6 = self.emotiondata[var_90_4 * arg_90_1 + iter_90_1].id or nil

					if var_90_6 then
						var_90_5.index = arg_90_1
						var_90_5:getChildByName("Button_107").selectindex = var_90_4 * arg_90_1 + iter_90_1

						var_90_5:setVisible(true)

						if var_90_5:getChildByName("emotionavatar") then
							var_90_5:getChildByName("emotionavatar"):removeFromParent()
						end

						local var_90_7 = ChatEmotionSprite:create(tonumber(var_90_6))

						if self.emotiondata[var_90_4 * arg_90_1 + iter_90_1].image_id then
							var_90_7:setPosition(cc.p(-22, -20))
						else
							var_90_7:setPosition(cc.p(6, 0))
						end

						var_90_7:setScale(var_90_5:getContentSize().height / var_90_7:getContentSize().height)
						var_90_7:setName("emotionavatar")
						var_90_5:addChild(var_90_7, 100)

						if self.iconselectindex == var_90_4 * arg_90_1 + iter_90_1 then
							-- block empty
						else
							self.iconitem = nil
						end

						var_90_5:setVisible(true)
						self:adjustEmationPos(var_90_5, self.emotiondata[var_90_4 * arg_90_1 + iter_90_1])

						goto label_90_1
					end
				end

				var_90_5:setVisible(false)

				::label_90_1::
			end
		end

		return var_90_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableviewemotion:registerScriptHandler(function(arg_95_0, arg_95_1)
		return self:getCurDataListLen()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableviewemotion:reloadData()
end

function PopChatInterfaceLayer:createInPutLayer()
	self.editBox = cc.EditBox:create(cc.size(460, 44), (config._DEBUG or nil) and (cc.Scale9Sprite:create(var_0_42) or cc.Scale9Sprite:createWithSpriteFrameName(var_0_42)))

	self.editBox:setPosition(cc.p(self.inputbg:getContentSize().width / 2, self.inputbg:getContentSize().height / 2 - 2))
	self.editBox:setFontColor(cc.c3b(0, 0, 0))
	self.editBox:setPlaceholderFontColor(cc.c3b(73, 92, 145))
	self.editBox:setPlaceHolder(COMMUNITY_CHAT_SYSTEM.tips8)
	self.editBox:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
	self.editBox:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	self.editBox:setFont(FONT_NAME, 20)
	self.editBox:setMaxLength(330)
	self.panelcutinput:addChild(self.editBox)
	self.editBox:registerScriptEditBoxHandler(function(arg_97_0, arg_97_1)
		if arg_97_0 == "began" then
			arg_97_1:setText("")
		elseif arg_97_0 == "ended" then
			if not global_check_sensitive(arg_97_1:getText()) then
				global_ShowBlockWords(L_WORD_SENSITIVE)
				arg_97_1:setText("")
			end
		elseif arg_97_0 == "return" then
			-- block empty
		elseif arg_97_0 == "changed" then
			-- block empty
		end
	end)

	if var_0_0 then
		self.editBox:setEnabled(false)
	end
end

function PopChatInterfaceLayer:initSendBtn()
	local var_98_0 = self.editBox:getText()

	self.send_btn:addTouchEventListener(function(arg_99_0, arg_99_1)
		if arg_99_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.topbtnindex == 1 then
			if not self.listfrienddata or not next(self.listfrienddata) then
				global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips14)

				return
			end
		elseif self.topbtnindex == 2 and not community_system_manager:getCurfamilyid() then
			global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips2)

			return
		end

		local var_99_0 = self.editBox:getText()
		local var_99_1

		if self.topbtnindex == 1 then
			if self.friendid then
				if self.emotionpanel:isVisible() and self.iconselectindex and (self.emontiontype == 1 or self.emontiontype == 2) and self.emotiondata and self.emotiondata[self.iconselectindex] and self.emotiondata[self.iconselectindex].id and var_99_0 == "" then
					var_99_1 = var_0_32 .. self.emotiondata[self.iconselectindex].id

					chat_system_manager:send_chat_message(1, self.friendid, var_0_32 .. self.emotiondata[self.iconselectindex].id, function(arg_101_0)
						if arg_101_0 == 1 then
							if var_0_14 then
								local var_101_0 = chat_system_manager:getPlayerInfoByPlayerId(self.friendid)
								local var_101_1 = {
									myself = true,
									isread = true,
									level = var_101_0.level,
									class = var_101_0.class,
									playerid = self.friendid,
									name = var_101_0.name,
									time = self:global_format_time_by_date((time_check_manager:getCurTime())),
									message = var_99_1
								}

								self:pushBackChat(var_101_1)
								chat_system_manager:updateRecentFriend(self.friendid)
								chat_system_manager:inserChartData(var_101_1)
								self.emotionpanel:setVisible(false)
							end
						elseif arg_101_0 == 2 then
							global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips6)
						elseif arg_101_0 == 3 then
							global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips7)
						elseif arg_101_0 == 4 then
							global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips3)
						elseif arg_101_0 == 5 then
							global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips4)
						end
					end)
				elseif self.emotionpanel:isVisible() and self.iconselectindex and self.emotiondata and (self.emontiontype == 1 or self.emontiontype == 2) and self.emotiondata[self.iconselectindex] and self.emotiondata[self.iconselectindex].id and var_99_0 ~= "" then
					var_99_1 = var_0_32 .. self.emotiondata[self.iconselectindex].id

					chat_system_manager:send_chat_message(1, self.friendid, var_0_32 .. self.emotiondata[self.iconselectindex].id, function(arg_102_0)
						if arg_102_0 == 1 then
							if var_0_14 then
								local var_102_0 = chat_system_manager:getPlayerInfoByPlayerId(self.friendid)
								local var_102_1 = {
									myself = true,
									isread = true,
									level = var_102_0.level,
									class = var_102_0.class,
									playerid = self.friendid,
									name = var_102_0.name,
									time = self:global_format_time_by_date((time_check_manager:getCurTime())),
									message = var_99_1
								}

								self:pushBackChat(var_102_1)
								chat_system_manager:updateRecentFriend(self.friendid)
								chat_system_manager:inserChartData(var_102_1)
								self.emotionpanel:setVisible(false)
							end
						elseif arg_102_0 == 2 then
							global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips6)
						elseif arg_102_0 == 3 then
							global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips7)
						elseif arg_102_0 == 4 then
							global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips3)
						elseif arg_102_0 == 5 then
							global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips4)
						end

						if self:checkIsRight(var_99_0) then
							chat_system_manager:send_chat_message(1, self.friendid, var_99_0, function(arg_103_0)
								if arg_103_0 == 1 then
									if var_0_14 then
										local var_103_0 = chat_system_manager:getPlayerInfoByPlayerId(self.friendid)
										local var_103_1 = {
											myself = true,
											isread = true,
											level = var_103_0.level,
											class = var_103_0.class,
											playerid = self.friendid,
											name = var_103_0.name,
											time = self:global_format_time_by_date((time_check_manager:getCurTime())),
											message = var_99_0
										}

										self:pushBackChat(var_103_1)
										chat_system_manager:updateRecentFriend(self.friendid)
										chat_system_manager:inserChartData(var_103_1)
									end
								elseif arg_103_0 == 2 then
									global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips6)
								elseif arg_103_0 == 3 then
									global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips7)
								elseif arg_103_0 == 4 then
									global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips3)
								elseif arg_103_0 == 5 then
									global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips4)
								end

								self.editBox:setText("")
							end)
						end
					end)
				elseif self:checkIsRight(var_99_0) then
					chat_system_manager:send_chat_message(1, self.friendid, var_99_0, function(arg_100_0)
						if arg_100_0 == 1 then
							if var_0_14 then
								local var_100_0 = chat_system_manager:getPlayerInfoByPlayerId(self.friendid)
								local var_100_1 = {
									myself = true,
									isread = true,
									level = var_100_0.level,
									class = var_100_0.class,
									playerid = self.friendid,
									name = var_100_0.name,
									time = self:global_format_time_by_date((time_check_manager:getCurTime())),
									message = var_99_0
								}

								self:pushBackChat(var_100_1)
								chat_system_manager:updateRecentFriend(self.friendid)
								chat_system_manager:inserChartData(var_100_1)
								self.emotionpanel:setVisible(false)
							end
						elseif arg_100_0 == 2 then
							global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips6)
						elseif arg_100_0 == 3 then
							global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips7)
						elseif arg_100_0 == 4 then
							global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips3)
						elseif arg_100_0 == 5 then
							global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips4)
						end

						self.editBox:setText("")
					end)
				end
			end
		elseif self.topbtnindex == 2 then
			self:initCommitySendBtn()
		end
	end)
end

function PopChatInterfaceLayer:checkIsRight(arg_104_1)
	if not arg_104_1 then
		return true
	end

	if utfstrlen(arg_104_1) == 0 then
		global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips9)

		return false
	elseif utfstrlen(arg_104_1) > chat_system_manager:getChatMaxLine(self.topbtnindex) then
		global_ShowBlockWords(string.format(COMMUNITY_CHAT_SYSTEM.tips10, chat_system_manager:getChatMaxLine(self.topbtnindex)))

		return false
	end

	if not barrage_manager:checkmsg(arg_104_1) then
		global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips4)

		return false
	end

	return true
end

function PopChatInterfaceLayer.getFriendList(arg_105_0, arg_105_1, arg_105_2, arg_105_3)
	if arg_105_1 == 1 then
		if not next(chat_system_manager:getPlayerFriendList()) then
			chat_system_manager:resetFriendListParam()
			chat_system_manager:get_friend_list(1, 200, function()
				if arg_105_2 then
					arg_105_2(chat_system_manager:getRecentFriendData())
				end
			end)
		elseif arg_105_2 then
			arg_105_2(chat_system_manager:getRecentFriendData())
		end
	elseif arg_105_1 == 2 then
		chat_system_manager:resetFriendListParam()
		chat_system_manager:get_friend_list(1, 200, arg_105_2)
	end
end

function PopChatInterfaceLayer.getEmotionList(arg_107_0)
	return
end

function PopChatInterfaceLayer.global_format_time_by_date(arg_108_0, arg_108_1)
	local var_108_0 = ""

	if arg_108_1 then
		local var_108_1 = os.date("*t", math.floor(arg_108_1))

		var_108_0 = var_108_1.year .. "-" .. var_108_1.month .. "-" .. var_108_1.day .. " " .. var_108_1.hour .. ":" .. var_108_1.min .. ":" .. var_108_1.sec
	end

	return var_108_0
end

function PopChatInterfaceLayer.initIconType(arg_109_0, arg_109_1)
	arg_109_1 = arg_109_1 or 1

	if arg_109_1 == 1 then
		arg_109_0.icontype = 1
	elseif arg_109_1 == 2 then
		arg_109_0.icontype = 3
	end
end

function PopChatInterfaceLayer.adjustEmationPos(arg_110_0, arg_110_1, arg_110_2)
	if not arg_110_2 or not arg_110_1 then
		return
	end

	local var_110_0 = arg_110_1:getChildByName("emotionavatar")

	if not var_110_0 then
		return
	end

	local var_110_1 = arg_110_2.id

	local function var_110_2(arg_111_0, arg_111_1, arg_111_2)
		if not arg_111_0 or not arg_111_1 or not arg_111_2 then
			return
		end

		if arg_111_0 and arg_111_0.image_id then
			arg_111_1:setPosition(cc.p(arg_111_2[1].x, arg_111_2[1].y))
		else
			arg_111_1:setPosition(cc.p(arg_111_2[2].x, arg_111_2[2].y))
		end
	end

	local var_110_3 = {
		[123201005] = function()
			var_110_2(arg_110_2, var_110_0, {
				{
					x = -22,
					y = -20
				},
				{
					x = 6,
					y = -30
				}
			})
		end
	}

	if arg_110_2.id and var_110_3[var_110_1] then
		var_110_3[var_110_1]()
	end
end

function PopChatInterfaceLayer.adjustChatEmationPos(arg_113_0, arg_113_1, arg_113_2, arg_113_3)
	if not arg_113_1 or not arg_113_2 or not arg_113_3 then
		return
	end

	local function var_113_0(arg_114_0, arg_114_1, arg_114_2)
		if not arg_114_0 or not arg_114_1 or not arg_114_2 then
			return
		end

		arg_114_0:setPosition(cc.p(arg_114_1[arg_114_2].x, arg_114_1[arg_114_2].y))
	end

	local var_113_1 = {
		[123201005] = function()
			var_113_0(arg_113_1, {
				{
					x = 34,
					y = -10
				},
				{
					x = 34,
					y = -10
				}
			}, arg_113_3)
		end,
		[123201008] = function()
			var_113_0(arg_113_1, {
				{
					x = 34,
					y = 10
				},
				{
					x = 34,
					y = 10
				}
			}, arg_113_3)
		end
	}

	if arg_113_2 and var_113_1[arg_113_2] then
		var_113_1[arg_113_2]()
	end
end
