AIchatLayer = class("AIchatLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = "aichat_layer/"
local aichat_manager = require("controller.aichat_manager")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local RichTextPro = require("view.Sprite.RichTextPro")
local var_0_7 = 1
local var_0_8 = 2

function AIchatLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = AIchatLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AIchatLayer:init(arg_3_1)
	self.layerName = "AIchatLayer"
	self.curServant = arg_3_1.servant
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:getServantListData()

	self.aiChatData = {}

	self:initUI()
	self:fullScreen()
	self:switchServant(1)
	self:addTouchEvent()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function AIchatLayer:getServantListData()
	self.servantListData = {}

	for iter_5_0, iter_5_1 in pairs((aichat_manager:getAichatList())) do
		if iter_5_0 == self.curServant then
			table.insert(self.servantListData, 1, {
				servant = iter_5_0,
				ai_chat = iter_5_1
			})
		else
			table.insert(self.servantListData, {
				servant = iter_5_0,
				ai_chat = iter_5_1
			})
		end
	end
end

function AIchatLayer:initUI()
	self.title = self.rootLayer:getChildByName("title")
	self.line = self.rootLayer:getChildByName("line")
	self.chat_event_list = self.rootLayer:getChildByName("chat_event_list")

	self.chat_event_list:removeAllChildren()

	self.chat_event_name = self.rootLayer:getChildByName("chat_event_name")
	self.chat_list = self.rootLayer:getChildByName("chat_list")

	self.chat_list:setDirection(ccui.ScrollViewDir.vertical)

	self.panel_player_guide = self.rootLayer:getChildByName("panel_player_guide")
	self.bottom = self.rootLayer:getChildByName("bottom")
	self.btn_return = self.bottom:getChildByName("btn_return")
	self.servant_item_clone = self.rootLayer:getChildByName("servant_item_clone")
	self.servant_chat_item_clone = self.rootLayer:getChildByName("servant_chat_item_clone")

	self.servant_item_clone:setVisible(false)
	self.servant_chat_item_clone:setVisible(false)

	self.servant_list_temp = self.rootLayer:getChildByName("servant_list_temp")
	self.servant_list_pos = cc.p(self.servant_list_temp:getPositionX(), self.servant_list_temp:getPositionY() - GameDisplay.fix_y)
	self.servant_list_height = self.servant_list_temp:getContentSize().height + GameDisplay.fix_y * 2
	self.servant_list_width = self.servant_list_temp:getContentSize().width
	self.loadingcircle = self.rootLayer:getChildByName("loadingcircle")
	self.loadingText = self.rootLayer:getChildByName("loadingText")

	self.loadingcircle:runAction(cc.RepeatForever:create(cc.RotateBy:create(1, 360)))
	self.loadingcircle:setVisible(false)
	self.loadingText:setVisible(false)

	self.guide_select1 = self.panel_player_guide:getChildByName("guide_select1")
	self.guide_select2 = self.panel_player_guide:getChildByName("guide_select2")
	self.love_progress = self.panel_player_guide:getChildByName("love_progress")
	self.chat_done_btn = self.panel_player_guide:getChildByName("chat_done_btn")
	self.chat_done_label = self.panel_player_guide:getChildByName("chat_done_label")
	self.restart_btn = self.panel_player_guide:getChildByName("restart_btn")

	local var_6_1 = RichTextPro:create()

	var_6_1:setFontName(FONT_DES)
	var_6_1:setSize(24)
	var_6_1:setLineSpace(0)
	self.rootLayer:addChild(var_6_1)
	var_6_1:setPosition(self.chat_event_name:getPositionX() + 280, self.chat_event_name:getPositionY() + 14)

	self.chat_num_label = var_6_1

	self:clearPlayerGuidePanel()
	self:createServantList()
	self.btn_return:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function AIchatLayer:clearPlayerGuidePanel()
	self.reply_guide_1 = nil
	self.reply_guide_2 = nil

	self.guide_select1:setVisible(false)
	self.guide_select2:setVisible(false)
	self.guide_select1:getChildByName("guide_text"):setString("")
	self.guide_select2:getChildByName("guide_text"):setString("")
	self.love_progress:setPercent(0)
	self.chat_done_btn:setVisible(false)
	self.chat_done_label:setVisible(false)
	self.restart_btn:setVisible(false)
end

function AIchatLayer:loadingChat()
	self.isLoading = true

	self.loadingcircle:setVisible(true)
	self.loadingText:setVisible(true)
end

function AIchatLayer:loadingChatDone()
	self.isLoading = false

	self.loadingcircle:setVisible(false)
	self.loadingText:setVisible(false)
end

function AIchatLayer:fullScreen()
	self.title:setPositionY(self.title:getPositionY() + GameDisplay.fix_y)
	self.line:setPositionY(self.line:getPositionY() + GameDisplay.fix_y)
	self.chat_event_list:setPositionY(self.chat_event_list:getPositionY() + GameDisplay.fix_y)
	self.chat_event_name:setPositionY(self.chat_event_name:getPositionY() + GameDisplay.fix_y)
	self.chat_num_label:setPositionY(self.chat_num_label:getPositionY() + GameDisplay.fix_y)
	self.chat_list:setPositionY(self.chat_list:getPositionY() - GameDisplay.fix_y)
	self.panel_player_guide:setPositionY(self.panel_player_guide:getPositionY() - GameDisplay.fix_y)
	self.bottom:setPositionY(self.bottom:getPositionY() - GameDisplay.fix_y)
	self.chat_list:setContentSize(self.chat_list:getContentSize().width, self.chat_list:getContentSize().height + 2 * GameDisplay.fix_y)
end

function AIchatLayer:addTouchEvent()
	self.guide_select1:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.reply_guide_1 then
			return
		end

		if self.isLoading or self.waiting_reply or self.isRestartChat then
			return
		end

		self.waiting_reply = true

		self.chat_list:pushBackCustomItem((self:createChatBubble(nil, self.reply_guide_1, var_0_8)))
		self:waitingReply()
		self:chatScrollToBottom()

		local var_13_0 = self.servantListData[self.curIndex].ai_chat[self.curChatIndex].chat_id
		local var_13_1 = self.reply_guide_1

		aichat_manager:send_message_to_ai({
			id = self.servantListData[self.curIndex].ai_chat[self.curChatIndex].chat_id,
			user_input = self.reply_guide_1
		}, function(arg_14_0)
			if tolua.isnull(self) then
				return
			end

			self.waiting_reply = false

			if arg_14_0.result == 1 then
				self:aiReply(arg_14_0, var_13_1, var_13_0)
			else
				global_ShowBlockWords("网络不稳定 加载失败")
				self:updateChat()
				self:chatScrollToBottom()
			end
		end)
	end)
	self.guide_select2:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.reply_guide_2 then
			return
		end

		if self.isLoading or self.waiting_reply or self.isRestartChat then
			return
		end

		self.waiting_reply = true

		self.chat_list:pushBackCustomItem((self:createChatBubble(nil, self.reply_guide_2, var_0_8)))
		self:waitingReply()
		self:chatScrollToBottom()

		local var_15_0 = self.servantListData[self.curIndex].ai_chat[self.curChatIndex].chat_id
		local var_15_1 = self.reply_guide_2

		aichat_manager:send_message_to_ai({
			id = self.servantListData[self.curIndex].ai_chat[self.curChatIndex].chat_id,
			user_input = self.reply_guide_2
		}, function(arg_16_0)
			if tolua.isnull(self) then
				return
			end

			self.waiting_reply = false

			if arg_16_0.result == 1 then
				self:aiReply(arg_16_0, var_15_1, var_15_0)
			else
				global_ShowBlockWords("网络不稳定 加载失败")
				self:updateChat()
				self:chatScrollToBottom()
			end
		end)
	end)
	self.restart_btn:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isLoading or self.waiting_reply or self.isRestartChat then
			return
		end

		local var_17_1
		local var_17_0

		if not self.curIndex or not self.curChatIndex then
			do return end

			var_17_0 = {
				surecallback = function()
					self:restartChat()
				end
			}
			var_17_1 = {
				titleImage = "title_warorder.png"
			}
		end

		var_17_1.des = string.format("您今日仍可重温此段记忆%s次, 确定要让它回归原点吗？", self.servantListData[self.curIndex].ai_chat[self.curChatIndex].max_reset_num - self.aiChatData[self.servantListData[self.curIndex].ai_chat[self.curChatIndex].chat_id].reset_num)
		var_17_0.labels = var_17_1

		LayerManager:pushInLayer("PopDoLayer", var_17_0)
	end)
end

function AIchatLayer:createServantList()
	self.servant_list = cc.TableView:create(cc.size(self.servant_list_width, self.servant_list_height))

	self.servant_list:setPosition(self.servant_list_pos)
	self.servant_list:setDelegate()
	self.servant_list:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.servant_list)
	self.servant_list:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.servant_list:registerScriptHandler(function(arg_21_0, arg_21_1)
		return self.servant_item_clone:getContentSize().width, self.servant_item_clone:getContentSize().height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.servant_list:registerScriptHandler(function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:dequeueCell()

		if not var_20_0 then
			var_20_0 = cc.TableViewCell:create()

			local var_20_1 = self:createServantItem(arg_20_1 + 1)

			var_20_1:setName("node")
			var_20_1:setAnchorPoint(cc.p(0, 0))
			var_20_1:setPosition(cc.p(0, 0))
			var_20_0:addChild(var_20_1)
		else
			self:updateServantItem(var_20_0:getChildByName("node"), arg_20_1 + 1)
		end

		return var_20_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.servant_list:registerScriptHandler(function(arg_22_0, arg_22_1)
		return #self.servantListData
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.servant_list:reloadData()
end

function AIchatLayer:createServantItem(arg_23_1)
	local var_23_0 = self.servant_item_clone:clone()

	var_23_0:setVisible(true)
	self:updateServantItem(var_23_0, arg_23_1)

	return var_23_0
end

function AIchatLayer:updateServantItem(arg_24_1, arg_24_2)
	local var_24_0 = self.servantListData[arg_24_2].servant
	local var_24_1 = arg_24_1:getChildByName("servant_bg")

	if arg_24_2 == self.curIndex then
		var_24_1:loadTextures(var_0_1 .. "servant_bg_on.png", nil, var_0_1 .. "servant_bg_on.png", var_0_0)
		arg_24_1:getChildByName("servant_name_bg"):loadTexture(var_0_1 .. "servant_name_on.png", var_0_0)
	else
		var_24_1:loadTextures(var_0_1 .. "servant_bg_off.png", nil, var_0_1 .. "servant_bg_off.png", var_0_0)
		arg_24_1:getChildByName("servant_name_bg"):loadTexture(var_0_1 .. "servant_name_off.png", var_0_0)
	end

	arg_24_1:getChildByName("servant_name"):setString(model_data[tostring(var_24_0)].name_Q)
	arg_24_1:setTouchEnabled(false)
	var_24_1:setSwallowTouches(false)
	var_24_1:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isLoading or self.waiting_reply or self.isRestartChat then
			return
		end

		self:switchServant(arg_24_2)
	end)

	if not var_24_1:getChildByName("clipNode") then
		local var_24_2 = cc.ClippingNode:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_1 .. "servant_item_clip_mask.png") or cc.Sprite:createWithSpriteFrameName(var_0_1 .. "servant_item_clip_mask.png")))

		var_24_2:setAlphaThreshold(0.5)
		var_24_1:addChild(var_24_2)
		var_24_2:setName("clipNode")
		var_24_2:setPosition(var_24_1:getContentSize().width / 2, var_24_1:getContentSize().height / 2)

		local var_24_3 = ccui.ImageView:create("res/roleimage/role/portrait/" .. var_24_0 .. ".png")

		var_24_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_3:setName("servantimg")
		var_24_3:setPosition(var_24_2:getContentSize().width / 2, var_24_2:getContentSize().height / 2)
		var_24_2:addChild(var_24_3)
	else
		var_24_1:getChildByName("clipNode"):getChildByName("servantimg"):loadTexture("res/roleimage/role/portrait/" .. var_24_0 .. ".png")
	end
end

function AIchatLayer:switchServant(arg_26_1)
	if self.curIndex == arg_26_1 then
		return
	end

	local var_26_0 = self.curIndex

	self.curIndex = arg_26_1

	if var_26_0 then
		self.servant_list:updateCellAtIndex(var_26_0 - 1)
	end

	self.chat_event_list:removeAllChildren()
	self:clearPlayerGuidePanel()

	self.curChatIndex = nil

	self.chat_list:removeAllChildren()
	self.chat_num_label:clearText()
	self.chat_event_name:setString("")

	for iter_26_0, iter_26_1 in ipairs(self.servantListData[self.curIndex].ai_chat) do
		local var_26_1

		if iter_26_1.unlock then
			var_26_1 = var_0_1 .. "chat_btn_unlock.png" or var_0_1 .. "chat_btn_lock.png"
		end

		local var_26_2 = iter_26_1.unlock and cc.c3b(255, 255, 255) or cc.c3b(139, 139, 139)
		local var_26_3 = ccui.Button:create(var_26_1, nil, var_26_1, var_0_0)
		local var_26_4 = cc.Label:createWithTTF(iter_26_1.title, FONT_BUTTON, 24)

		var_26_4:setPosition(var_26_3:getContentSize().width / 2, var_26_3:getContentSize().height / 2)
		var_26_4:setColor(var_26_2)
		var_26_3:addChild(var_26_4)
		var_26_3:setName("event_btn" .. iter_26_0)
		self.chat_event_list:pushBackCustomItem(var_26_3)
		var_26_3:addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not iter_26_1.unlock then
				if iter_26_1.love_level then
					global_ShowBlockWords("好感度达到" .. iter_26_1.love_level .. "级解锁")
				elseif iter_26_1.unlock_skin then
					global_ShowBlockWords("获取皮肤" .. item_data[iter_26_1.unlock_skin].name .. "后解锁")
				end

				return
			end

			if self.isLoading or self.waiting_reply or self.isRestartChat then
				return
			end

			self:switchChatEventList(iter_26_0)
		end)
	end

	self.servant_list:updateCellAtIndex(arg_26_1 - 1)
	self:switchChatEventList(1)
end

function AIchatLayer:switchChatEventList(arg_28_1)
	if self.curChatIndex == arg_28_1 then
		return
	end

	local var_28_0 = self.servantListData[self.curIndex].ai_chat

	if not self.servantListData[self.curIndex].ai_chat[arg_28_1].unlock then
		return
	end

	if self.curChatIndex and self.chat_event_list:getChildByName("event_btn" .. self.curChatIndex) then
		local var_28_1

		if var_28_0[self.curChatIndex].unlock then
			var_28_1 = var_0_1 .. "chat_btn_unlock.png" or var_0_1 .. "chat_btn_lock.png"
		end

		self.chat_event_list:getChildByName("event_btn" .. self.curChatIndex):loadTextures(var_28_1, nil, var_28_1, var_0_0)
	end

	if self.chat_event_list:getChildByName("event_btn" .. arg_28_1) then
		self.chat_event_list:getChildByName("event_btn" .. arg_28_1):loadTextures(var_0_1 .. "chat_on.png", nil, var_0_1 .. "chat_on.png", var_0_0)
	end

	self.curChatIndex = arg_28_1

	self.chat_event_name:setString(var_28_0[arg_28_1].title)

	local var_28_2 = var_28_0[self.curChatIndex].chat_id

	self.chat_list:removeAllChildren()
	self:clearPlayerGuidePanel()

	if not self.aiChatData[var_28_0[self.curChatIndex].chat_id] then
		self:loadingChat()
		aichat_manager:query_ai_session({
			id = var_28_0[self.curChatIndex].chat_id
		}, function(arg_29_0)
			if tolua.isnull(self) then
				return
			end

			self:loadingChatDone()

			if arg_29_0.result == 1 then
				self.aiChatData[var_28_2] = {
					ai_history = json.decode(arg_29_0.ai_history),
					reset_num = arg_29_0.reset_num
				}

				self:updateChat()

				local var_29_0 = json.decode(arg_29_0.ai_history)
			else
				global_ShowBlockWords("获取对话失败")
			end
		end)
	else
		self:updateChat()
	end
end

function AIchatLayer.createChatBubble(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_1 and model_data[tostring(arg_30_1)].name_Q or ""
	local var_30_1 = cc.Label:createWithTTF("", FONT_DES, 24)

	var_30_1:setMaxLineWidth(310)
	var_30_1:setLineBreakWithoutSpace(true)
	var_30_1:setString(arg_30_2)

	local var_30_2 = var_30_1:getContentSize()

	if arg_30_3 == var_0_7 then
		local var_30_3 = var_0_1 .. "servant_chat_bg.png" or var_0_1 .. "player_chat_bg.png"
		local var_30_4

		if config._DEBUG then
			var_30_4 = cc.Scale9Sprite:create(var_30_3) or cc.Scale9Sprite:createWithSpriteFrameName(var_30_3)
		end
	end

	var_30_4:setCapInsets(cc.rect(25, 20, 70, 40))
	var_30_4:setName("bubble_bg")

	local var_30_5 = math.max(82, var_30_2.height + 26 * 2)
	local var_30_6 = math.max(120, var_30_2.width + 60)

	var_30_4:setContentSize(cc.size(var_30_6, var_30_5))
	var_30_1:setAnchorPoint(0, 0.5)
	var_30_1:setPosition(34, var_30_5 / 2)
	var_30_4:addChild(var_30_1)

	local var_30_7 = math.max(133, 42 + var_30_5)

	var_30_4:setAnchorPoint(0, 1)
	var_30_4:setPosition(105, var_30_7 - 32)

	local var_30_8 = ccui.ImageView:create(var_0_1 .. "servant_img.png", var_0_0)

	var_30_8:setAnchorPoint(0.5, 0.5)
	var_30_8:setPosition(58, var_30_7 / 2)

	if arg_30_1 and arg_30_3 == var_0_7 then
		local var_30_9 = ccui.ImageView:create("res/roleimage/role/wuji/" .. model_data[tostring(arg_30_1)].head_image .. ".png")

		var_30_9:setAnchorPoint(cc.p(0.5, 0.5))
		var_30_9:setName("servantimg")
		var_30_9:setPosition(var_30_8:getContentSize().width / 2, var_30_8:getContentSize().height / 2 + 5)
		var_30_9:setScale(0.4)
		var_30_8:addChild(var_30_9)
	end

	local var_30_10 = cc.Label:createWithTTF(arg_30_2, FONT_DES, 24)

	var_30_10:setString(var_30_0)
	var_30_10:setAnchorPoint(0, 0.5)
	var_30_10:setPosition(123, var_30_7 - 21)

	local var_30_11 = ccui.Layout:create()

	var_30_11:setContentSize(cc.size(480, var_30_7))
	var_30_11:setAnchorPoint(0.5, 0.5)
	var_30_11:setVisible(true)
	var_30_11:addChild(var_30_4)
	var_30_11:addChild(var_30_10)
	var_30_11:addChild(var_30_8)

	if arg_30_3 == var_0_8 then
		var_30_10:setVisible(false)
		var_30_8:setVisible(false)
		var_30_11:setContentSize(cc.size(480, var_30_7 - 50))
		var_30_4:setPositionY(var_30_7 - 52)
		var_30_4:setPositionX(480)
		var_30_4:setAnchorPoint(1, 1)
		var_30_1:setAnchorPoint(1, 0.5)
		var_30_1:setPositionX(var_30_6 - var_30_1:getPositionX())
	end

	return var_30_11
end

function AIchatLayer.createTargetLayout(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_31_0:setMaxLineWidth(450)
	var_31_0:setLineBreakWithoutSpace(true)
	var_31_0:setString("  " .. arg_31_1)
	var_31_0:setColor(cc.c3b(139, 139, 139))

	local var_31_1 = var_31_0:getContentSize()
	local var_31_2 = cc.Label:createWithTTF("", FONT_DES, 24)

	var_31_2:setMaxLineWidth(450)
	var_31_2:setLineBreakWithoutSpace(true)
	var_31_2:setString(arg_31_2)
	var_31_2:setColor(cc.c3b(255, 227, 41))

	local var_31_3 = var_31_1.height + var_31_2:getContentSize().height + 30
	local var_31_4 = ccui.Layout:create()

	var_31_4:setContentSize(cc.size(480, var_31_3))
	var_31_4:setAnchorPoint(0.5, 0.5)
	var_31_4:setVisible(true)
	var_31_0:setAnchorPoint(0.5, 1)
	var_31_0:setPosition(480 / 2, var_31_3 - 15)
	var_31_2:setAnchorPoint(0.5, 1)
	var_31_2:setPosition(480 / 2, var_31_3 - 25 - var_31_1.height)
	var_31_4:addChild(var_31_0)
	var_31_4:addChild(var_31_2)

	return var_31_4
end

function AIchatLayer:updateChat()
	local var_32_0 = self.servantListData[self.curIndex].ai_chat

	self.chat_list:pushBackCustomItem((self:createTargetLayout(self.servantListData[self.curIndex].ai_chat[self.curChatIndex].narration_des, self.servantListData[self.curIndex].ai_chat[self.curChatIndex].target_des)))
	self.chat_list:pushBackCustomItem((self:createChatBubble(self.servantListData[self.curIndex].servant, var_32_0[self.curChatIndex].start_action .. var_32_0[self.curChatIndex].start_reply, var_0_7)))

	local var_32_1 = 0

	if next(self.aiChatData[self.servantListData[self.curIndex].ai_chat[self.curChatIndex].chat_id].ai_history) then
		for iter_32_0, iter_32_1 in ipairs(self.aiChatData[self.servantListData[self.curIndex].ai_chat[self.curChatIndex].chat_id].ai_history) do
			if iter_32_1.role == "user" then
				self.chat_list:pushBackCustomItem((self:createChatBubble(nil, iter_32_1.content, var_0_8)))

				var_32_1 = var_32_1 + 1
			elseif iter_32_1.role == "assistant" then
				local var_32_2 = json.decode(iter_32_1.content)

				self.reply_guide_1 = var_32_2.guide[1]
				self.reply_guide_2 = var_32_2.guide[2]
				self.love_progress_value = var_32_2.progress

				self.chat_list:pushBackCustomItem((self:createChatBubble(self.servantListData[self.curIndex].servant, var_32_2.action .. var_32_2.reply, var_0_7)))
			end
		end
	else
		self.reply_guide_1 = var_32_0[self.curChatIndex].start_guide_1
		self.reply_guide_2 = var_32_0[self.curChatIndex].start_guide_2
		self.love_progress_value = 0
	end

	self.guide_select1:getChildByName("guide_text"):setScale(1)
	self.guide_select2:getChildByName("guide_text"):setScale(1)

	if self.love_progress_value >= 100 then
		self.reply_guide_1 = nil
		self.reply_guide_2 = nil

		self.guide_select1:getChildByName("guide_text"):setString("")
		self.guide_select2:getChildByName("guide_text"):setString("")
		self.guide_select1:setVisible(false)
		self.guide_select2:setVisible(false)
		self.chat_done_btn:setVisible(true)
		self.chat_done_label:setString("目标已完成！")
		self.chat_done_label:setVisible(true)
	elseif var_32_1 < var_32_0[self.curChatIndex].max_talk_time then
		self.guide_select1:getChildByName("guide_text"):setString(self.reply_guide_1)
		self.guide_select2:getChildByName("guide_text"):setString(self.reply_guide_2)

		if self.guide_select1:getChildByName("guide_text"):getContentSize().width > 410 then
			self.guide_select1:getChildByName("guide_text"):setScale(410 / self.guide_select1:getChildByName("guide_text"):getContentSize().width)
		end

		if self.guide_select2:getChildByName("guide_text"):getContentSize().width > 410 then
			self.guide_select2:getChildByName("guide_text"):setScale(410 / self.guide_select2:getChildByName("guide_text"):getContentSize().width)
		end

		self.guide_select1:setVisible(true)
		self.guide_select2:setVisible(true)
		self.chat_done_btn:setVisible(false)
		self.chat_done_label:setVisible(false)
	else
		self.reply_guide_1 = nil
		self.reply_guide_2 = nil

		self.guide_select1:getChildByName("guide_text"):setString("")
		self.guide_select2:getChildByName("guide_text"):setString("")
		self.guide_select1:setVisible(false)
		self.guide_select2:setVisible(false)
		self.chat_done_btn:setVisible(false)
		self.chat_done_label:setString("对话次数已用尽！")
		self.chat_done_label:setVisible(true)
	end

	self.love_progress:setPercent(self.love_progress_value)
	self.restart_btn:setVisible(true)
	self.chat_num_label:clearText()
	self.chat_num_label:setText((string.format("尝试次数: <span style=color: rgb(255, 227, 41);>%s</span>/%s", var_32_1, var_32_0[self.curChatIndex].max_talk_time)))
end

function AIchatLayer:waitingReply()
	local var_33_1 = self:createChatBubble(self.servantListData[self.curIndex].servant, "", var_0_7)
	local var_33_2 = var_33_1:getChildByName("bubble_bg")
	local var_33_3 = ccui.ImageView:create(var_0_1 .. "loadingcircle.png", var_0_0)

	var_33_3:runAction(cc.RepeatForever:create(cc.RotateBy:create(1, 360)))
	var_33_2:addChild(var_33_3)
	var_33_3:setScale(0.5)
	var_33_3:setPosition(var_33_2:getContentSize().width / 2, var_33_2:getContentSize().height / 2)
	self.chat_list:pushBackCustomItem(var_33_1)
	var_33_1:setName("waitingBubble")
end

function AIchatLayer:aiReply(arg_34_1, arg_34_2, arg_34_3)
	table.insert(self.aiChatData[arg_34_3].ai_history, {
		role = "user",
		content = arg_34_2
	})
	table.insert(self.aiChatData[arg_34_3].ai_history, {
		role = "assistant",
		content = json.decode(arg_34_1.ai_reply).reply
	})
	self.chat_list:removeAllChildren()
	self:updateChat()
	self:chatScrollToBottom()
end

function AIchatLayer:restartChat()
	local var_35_0 = self.servantListData[self.curIndex].ai_chat[self.curChatIndex].chat_id

	self.isRestartChat = true

	aichat_manager:restart_ai_chat({
		id = self.servantListData[self.curIndex].ai_chat[self.curChatIndex].chat_id
	}, function(arg_36_0)
		if tolua.isnull(self) then
			return
		end

		self.isRestartChat = false

		if arg_36_0.result == 1 then
			self.aiChatData[var_35_0] = {
				ai_history = {},
				reset_num = arg_36_0.reset_num
			}

			self.chat_list:removeAllChildren()
			self:updateChat()
		elseif arg_36_0.result == 2 then
			global_ShowBlockWords("今日重置次数已耗尽")
		else
			global_ShowBlockWords("重置失败")
		end
	end)
end

function AIchatLayer:chatScrollToBottom()
	self.chat_list:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), (cc.CallFunc:create(function()
		self.chat_list:stopAllActions()
		self.chat_list:scrollToBottom(0.5, true)
	end))))
end

function AIchatLayer.updateUI(arg_39_0)
	return
end
