PopFriendManagementLayer = class("PopFriendManagementLayer", function()
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
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local score_arena_awards_data = require("data.score_arena_awards_data")
local friend_system_manager = require("controller.friend_system_manager")
local var_0_8
local activity_manager = require("controller.activity_manager")
local var_0_10 = config._DEBUG and 0 or 1
local var_0_11 = require("controller.activity_manager")
local var_0_12 = {
	{
		off = "friendsystem/mgr_friend_add_off.png",
		on = "friendsystem/mgr_friend_add_on.png"
	},
	{
		off = "friendsystem/mgr_friend_apply_off.png",
		on = "friendsystem/mgr_friend_apply_on.png"
	}
}
local var_0_13 = {
	online = cc.c3b(0, 255, 18),
	offline = cc.c3b(133, 133, 133)
}
local var_0_14 = 128
local var_0_15 = 507
local var_0_16 = 130

function PopFriendManagementLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopFriendManagementLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopFriendManagementLayer:init(arg_3_1)
	var_0_8 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopFriendManagementLayer.json" or "PopFriendManagementLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.panel_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_add")
	self.panel_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_apply")
	self.btn_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_add")
	self.btn_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_apply")
	self.additem = ccui.Helper:seekWidgetByName(self.rootLayer, "add_items")
	self.applyitem = ccui.Helper:seekWidgetByName(self.rootLayer, "apply_items")
	self.panel_di = ccui.Helper:seekWidgetByName(self.rootLayer, "buttom_panel")
	self.friendnum = ccui.Helper:seekWidgetByName(self.panel_di, "Label_332")
	self.btn_ignore_all = ccui.Helper:seekWidgetByName(self.panel_2, "btn_ignore_all")
	self.btn_add_all = ccui.Helper:seekWidgetByName(self.panel_2, "btn_add_all")

	if self.btn_add_all == nil then
		self.btn_ignore_all:setPosition(cc.p(140, -41))

		self.btn_add_all = ccui.Button:create("friendsystem/mgr_btn_add_all.png", "friendsystem/mgr_btn_add_all.png", "friendsystem/mgr_btn_add_all.png", var_0_10)

		self.btn_add_all:setPosition(cc.p(390, -41))
		self.btn_add_all:setName("btn_add_all")
		self.panel_2:addChild(self.btn_add_all)
	end

	self.apply_limit_tips = ccui.Helper:seekWidgetByName(self.panel_2, "Label_62")

	self.apply_limit_tips:setPositionY(26)
	self:updateBtnAlert()

	self.top_btn = {
		self.btn_1,
		self.btn_2
	}
	self.panels = {
		self.panel_1,
		self.panel_2
	}
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "img_bg")

	self.rootpanel:setCascadeOpacityEnabled(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_root"):setPositionY(70 + GameDisplay.fix_y)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	if arg_3_1 then
		if arg_3_1.callback then
			self.callback = arg_3_1.callback or nil
		end

		if arg_3_1.select_index then
			self.select_index = arg_3_1.select_index or 2
		end
	else
		self.select_index = 2
	end

	for iter_3_0, iter_3_1 in pairs(self.top_btn) do
		iter_3_1:addTouchEventListener(function(arg_6_0, arg_6_1)
			if arg_6_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.select_index = iter_3_0

			self:updateTopBtn(self.select_index)

			if iter_3_0 == 2 then
				RoleDefault:getInstance():setBoolForKey("NewFriendApplyHave", false)
				self:updateBtnAlert()
			end
		end)
	end

	self:initUI()
	self:registerActivityEventListener()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			if self.callback then
				self.callback()
			end

			var_0_8 = nil

			activity_manager:releaseEventListenerByName("PopFriendManagementLayer")
		end
	end)
end

function PopFriendManagementLayer:initUI()
	self:updateTopBtn(self.select_index)
	self:updateFriendNum()
end

function PopFriendManagementLayer:updateFriendNum()
	local var_9_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_332")
	local var_9_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_5")
	local var_9_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_6")

	var_9_1:setColor(cc.c3b(170, 212, 231))
	var_9_2:setColor(cc.c3b(170, 212, 231))
	var_9_1:setFontSize(18)
	var_9_2:setFontSize(18)
	var_9_0:setString("/" .. friend_system_manager:geMaxFriendNum())
	var_9_1:setString("" .. friend_system_manager:getHaveFriendNum())
	var_9_2:setString(L_FRIEND_LISTLAYER.friend_num)
	var_9_1:setPositionX(var_9_0:getPositionX() - var_9_0:getContentSize().width)
	var_9_2:setPositionX(var_9_1:getPositionX() - var_9_1:getContentSize().width)
	var_9_2:setPositionY(15)
	var_9_2:setPositionY(15)
end

function PopFriendManagementLayer.updateTopBtn(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 then
		return
	end

	local function var_10_0(arg_11_0, arg_11_1, arg_11_2)
		if not var_0_8 then
			return
		end

		if arg_11_0 == 1 then
			if arg_11_2 == 1 then
				arg_10_0:initAddPanel(arg_10_0:sortByOnlinetime(arg_11_1))

				if arg_10_2 then
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.recomment_flash_success)
				end
			elseif arg_11_2 == 2 then
				local var_11_0 = false

				if arg_11_1 and next(arg_11_1) then
					arg_10_0:initApplyPanel(arg_11_1)
					arg_10_0.panel_2:getChildByName("img_nodata"):setVisible(false)

					var_11_0 = true
				else
					arg_10_0.panel_2:getChildByName("img_nodata"):setVisible(true)

					if arg_10_0.panel_2:getChildByName("roleTableView") then
						arg_10_0.panel_2:getChildByName("roleTableView"):removeFromParent()
					end
				end

				arg_10_0:initIgnoreBtn(var_11_0)
				arg_10_0:initAllAddBtn(var_11_0)
				arg_10_0:updateApplyNumLable(#arg_11_1)
			end

			local var_11_1 = cc.MoveTo:create(0, cc.p(20, 2))
			local var_11_2 = cc.MoveTo:create(0, cc.p(70020, 2))

			for iter_11_0, iter_11_1 in pairs(arg_10_0.top_btn) do
				if arg_10_1 == iter_11_0 then
					arg_10_0.panels[iter_11_0]:setVisible(true)
					arg_10_0.panels[iter_11_0]:runAction(var_11_1)
					iter_11_1:loadTextures(var_0_12[iter_11_0].on, var_0_12[iter_11_0].on, var_0_12[iter_11_0].on, var_0_10)
				else
					arg_10_0.panels[iter_11_0]:setVisible(false)
					arg_10_0.panels[iter_11_0]:runAction(var_11_2)
					iter_11_1:loadTextures(var_0_12[iter_11_0].off, var_0_12[iter_11_0].off, var_0_12[iter_11_0].off, var_0_10)
				end
			end
		elseif arg_11_2 == 1 and arg_10_2 then
			global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.recomment_flash_fail)
		end

		if var_0_8 then
			arg_10_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
				if arg_10_3 then
					arg_10_3()
				end
			end)))
		end
	end

	if arg_10_1 == 1 then
		friend_system_manager:get_friend_recommend_list(arg_10_2, var_10_0)
	elseif arg_10_1 == 2 then
		friend_system_manager:resetApplicationListListParam()
		friend_system_manager:get_friend_application_list(1, 200, var_10_0)
	end
end

function PopFriendManagementLayer:initAddPanel(arg_13_1)
	if not arg_13_1 or not next(arg_13_1) then
		print("no  data !!!!!!!!!!!")
	end

	self.player_uid = ccui.Helper:seekWidgetByName(self.panel_1, "Label_261")
	self.input_bg = ccui.Helper:seekWidgetByName(self.panel_1, "img_input")
	self.btn_clear = ccui.Helper:seekWidgetByName(self.panel_1, "btn_clear")
	self.btn_search = ccui.Helper:seekWidgetByName(self.panel_1, "btn_search")
	self.btn_flash = ccui.Helper:seekWidgetByName(self.panel_1, "btn_flash")
	self.player_num = ccui.Helper:seekWidgetByName(self.panel_1, "Label_332")
	self.panel_search = ccui.Helper:seekWidgetByName(self.panel_1, "panel_select")
	self.panel_scroll = ccui.Helper:seekWidgetByName(self.panel_1, "ScrollView_270")
	self.lable_recommend = ccui.Helper:seekWidgetByName(self.panel_1, "label_recoment")
	self.lable_dotted_line = ccui.Helper:seekWidgetByName(self.panel_1, "Label_268")
	self.mask1 = ccui.Helper:seekWidgetByName(self.panel_1, "panel_zhezhao")

	self.mask1:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)

	local var_13_0 = GameDisplay.getScreenSize()

	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_root"):setClippingEnabled(false)
	self.mask1:setContentSize(cc.size(525, 177 + GameDisplay.fix_y))
	self.mask1:setPositionX(0)
	self.mask1:setPositionY(-170 - GameDisplay.fix_y)
	self:hideSelectLayer(false)
	self:initAddPanelScroll(arg_13_1)
	self:initInPutLayer()
	self:initMyUid(self.player_uid)
	self:initSearchBtn()
	self:initFlashBtn()
end

function PopFriendManagementLayer:initAddPanelScroll(arg_16_1)
	if not arg_16_1 or not next(arg_16_1) then
		return
	end

	self.scrollnodes = {}

	self.panel_scroll:removeAllChildren()

	local var_16_0 = self.panel_scroll:getContentSize()
	local var_16_1 = var_0_14 * #arg_16_1 + (#arg_16_1 - 1) * 2 + 32

	if var_0_14 * #arg_16_1 + (#arg_16_1 - 1) * 2 + 32 < var_16_0.height then
		var_16_1 = var_16_0.height
	end

	self.panel_scroll:setContentSize(var_16_0)
	self.panel_scroll:setInnerContainerSize(cc.size(var_16_0.width, var_16_1))

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		local var_16_2 = self.additem:clone()

		var_16_2.id = iter_16_0

		var_16_2:setOpacity(0)
		self:updateAddItemInfo(iter_16_1, var_16_2)
		var_16_2:setPosition(cc.p(4, var_16_1 - (iter_16_0 - 1) * 2 - iter_16_0 * var_0_14))
		self.panel_scroll:addChild(var_16_2)
		table.insert(self.scrollnodes, var_16_2)
		var_16_2:runAction(cc.Sequence:create(cc.DelayTime:create((iter_16_0 - 1) * 0.1), cc.FadeIn:create(0.3)))
	end
end

function PopFriendManagementLayer:updateAddItemInfo(arg_17_1, arg_17_2)
	if not arg_17_1 or not arg_17_2 then
		return
	end

	local var_17_0 = ccui.Helper:seekWidgetByName(arg_17_2, "player_name")
	local var_17_1 = ccui.Helper:seekWidgetByName(arg_17_2, "class_img")
	local var_17_2 = ccui.Helper:seekWidgetByName(arg_17_2, "level")
	local var_17_3 = ccui.Helper:seekWidgetByName(arg_17_2, "power")
	local var_17_4 = ccui.Helper:seekWidgetByName(arg_17_2, "online_time")
	local var_17_5 = ccui.Helper:seekWidgetByName(arg_17_2, "btn_friend")

	var_17_5.id = arg_17_2.id

	var_17_0:setString(arg_17_1.name)
	var_17_2:setString("LV." .. arg_17_1.level)
	var_17_2:setVisible(false)
	var_17_3:setString(global_trans_bitmapnumber(arg_17_1.fightpower))
	var_17_3:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	var_17_4:setString("")

	if arg_17_1.lastlogin == "-1" then
		var_17_4:setColor(var_0_13.online)
	else
		var_17_4:setColor(var_0_13.offline)
	end

	self:initPlayerFace(arg_17_1.head_sculpture, arg_17_2, arg_17_1.playerid)
	self:initPlayerGrade(arg_17_1.class, var_17_1)
	self:dealWithApplyBtn(var_17_5, arg_17_1.playerid)
end

function PopFriendManagementLayer.initPlayerFace(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if not arg_18_1 or not arg_18_2 then
		return
	end

	arg_18_4 = arg_18_4 or 0.54
	arg_18_4 = 0.65

	local var_18_0 = AvatarSprite:create(tonumber(arg_18_1))

	var_18_0:setPosition(cc.p(36, 24))
	var_18_0:setName("avatar_face")
	var_18_0:setScale(arg_18_4)
	arg_18_2:addChild(var_18_0)
	var_18_0:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_19_0

		if arg_18_3 <= 0 then
			do return end

			var_19_0 = {
				layerName = "PopFriendManagementLayer",
				playeruid = arg_18_3
			}
		end

		function var_19_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_19_0)
	end)
end

function PopFriendManagementLayer.initPlayerGrade(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_1 or not arg_21_2 then
		return
	end

	local var_21_0

	if arg_21_1 == 4 then
		var_21_0 = "TopcostLayer/new_master.png"
	elseif arg_21_1 == 3 then
		var_21_0 = "TopcostLayer/new_Univ.png"
	elseif arg_21_1 == 2 then
		var_21_0 = "TopcostLayer/new_Senior.png"
	elseif arg_21_1 == 1 then
		var_21_0 = "TopcostLayer/new_Junior.png"
	end

	arg_21_2:loadTexture(var_21_0, var_0_10)
end

function PopFriendManagementLayer.dealWithApplyBtn(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_1 or not arg_22_2 then
		return
	end

	arg_22_1:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		friend_system_manager:apply_add_friend(arg_22_2, function(arg_24_0)
			if arg_24_0.result == 1 then
				if arg_22_0.scrollnodes and arg_22_0.scrollnodes[arg_22_1.id] then
					arg_22_0.scrollnodes[arg_22_1.id]:runAction(cc.Sequence:create(cc.MoveTo:create(0.3, cc.p(arg_22_0.scrollnodes[arg_22_1.id]:getPositionX() - 1500, arg_22_0.scrollnodes[arg_22_1.id]:getPositionY())), cc.CallFunc:create(function()
						cc.RemoveSelf:create()
						arg_22_0:updateTopBtn(1)
					end)))
				end

				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_friend_success)
			elseif arg_24_0.result == 2 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_max_limit)
			elseif arg_24_0.result == 3 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_is_friend)
			elseif arg_24_0.result == 4 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_is_self)
			elseif arg_24_0.result == 5 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.apply_list_limit)
			else
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_friend_fail)
			end
		end)
	end)
end

function PopFriendManagementLayer.initMyUid(arg_26_0, arg_26_1)
	if not arg_26_1 then
		return
	end

	arg_26_1:setString("" .. playermodel.playerid)
end

function PopFriendManagementLayer:initInPutLayer()
	self.editBox = cc.EditBox:create(cc.size(418, 39), (config._DEBUG or nil) and (cc.Scale9Sprite:create("friendsystem/mgr_btn_friend_input.png") or cc.Scale9Sprite:createWithSpriteFrameName("friendsystem/mgr_btn_friend_input.png")))

	self.editBox:setPosition(cc.p(self.input_bg:getContentSize().width / 2, self.input_bg:getContentSize().height / 2))
	self.editBox:setPlaceHolder(L_FRIEND_MANAGEMENT_LAYER.input_tips)
	self.editBox:setInputMode(cc.EDITBOX_INPUT_MODE_NUMERIC)
	self.editBox:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	self.editBox:setFont(FONT_NAME, 20)
	self.editBox:setMaxLength(400)
	self.input_bg:addChild(self.editBox)
	self:showClearBtn(false)
	self.editBox:registerScriptEditBoxHandler(function(arg_28_0, arg_28_1)
		if arg_28_0 == "began" then
			arg_28_1:setText("")
		elseif arg_28_0 == "ended" then
			-- block empty
		elseif arg_28_0 == "return" then
			-- block empty
		elseif arg_28_0 == "changed" then
			self:showClearBtn(true)
		end
	end)
	self.btn_clear:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_29_0 = self.panel_search:getChildByName("panel_search_itmes")

		if var_29_0 then
			var_29_0:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-2496, 520)), cc.CallFunc:create(function()
				self:hideSelectLayer(false)
				self:showClearBtn(false)
				cc.RemoveSelf:create()
			end)))
		end
	end)
end

function PopFriendManagementLayer:initSearchBtn()
	local var_31_0 = self.editBox:getText()

	self.btn_search:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_32_0 = self:CheckUidValidity((self.editBox:getText()))

		if var_32_0 then
			friend_system_manager:friend_search_player(var_32_0, function(arg_33_0)
				if arg_33_0.result == 1 then
					self:updateSearchPanel(arg_33_0.data, arg_33_0.relation)
					self:showClearBtn(true)
				elseif arg_33_0.result == 3 then
					self:resetInPutText()
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.limit_search_self)
				else
					self:resetInPutText()
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.no_exist_player)
				end
			end)
		end
	end)
end

function PopFriendManagementLayer:updateSearchPanel(arg_34_1, arg_34_2)
	if not arg_34_1 or not next(arg_34_1) then
		return
	end

	local var_34_0 = arg_34_1.playerid

	self:hideSelectLayer(true)
	self.panel_search:removeAllChildren()

	local var_34_1 = self.additem:clone()

	self:updateAddItemInfo(arg_34_1, var_34_1)

	local var_34_2 = ccui.Helper:seekWidgetByName(var_34_1, "level_applying")
	local var_34_3 = ccui.Helper:seekWidgetByName(var_34_1, "btn_friend")

	var_34_2:setString(L_FRIEND_MANAGEMENT_LAYER.applying)

	if arg_34_2 then
		var_34_2:setVisible(true)
		var_34_3:setVisible(false)
	else
		var_34_2:setVisible(false)
		var_34_3:setVisible(true)
	end

	if arg_34_2 and arg_34_2 == 1 then
		var_34_2:setVisible(true)
		var_34_3:setVisible(false)
		var_34_2:setString(L_FRIEND_MANAGEMENT_LAYER.is_friend_tip)
	elseif arg_34_2 and arg_34_2 == -1 then
		var_34_2:setVisible(false)
		var_34_3:setVisible(true)
	elseif arg_34_2 and arg_34_2 == 3 then
		var_34_2:setString(L_FRIEND_MANAGEMENT_LAYER.applying)
		var_34_2:setVisible(true)
		var_34_3:setVisible(false)
	else
		var_34_2:setVisible(false)
		var_34_3:setVisible(false)
	end

	var_34_1:setPosition(cc.p(4, 520))
	var_34_3:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		friend_system_manager:apply_add_friend(var_34_0, function(arg_36_0)
			if arg_36_0.result == 1 then
				var_34_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-2496, 520)), cc.CallFunc:create(function()
					cc.RemoveSelf:create()
					self:hideSelectLayer(false)
					self:showClearBtn(false)
				end)))
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_friend_success)
			elseif arg_36_0.result == 2 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_max_limit)
			elseif arg_36_0.result == 3 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_is_friend)
			elseif arg_36_0.result == 4 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_is_self)
			elseif arg_36_0.result == 5 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.apply_list_limit)
			else
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_friend_fail)
			end
		end)
	end)
	var_34_1:setName("panel_search_itmes")
	self.panel_search:addChild(var_34_1)
end

function PopFriendManagementLayer.CheckUidValidity(arg_38_0, arg_38_1)
	if not arg_38_1 then
		return
	end

	local var_38_0 = tonumber(arg_38_1)

	if var_38_0 then
		return var_38_0
	else
		global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.input_right_uid)

		return nil
	end
end

function PopFriendManagementLayer:showClearBtn(arg_39_1)
	self.btn_clear:setVisible(arg_39_1)

	if not arg_39_1 then
		self:resetInPutText()
	end
end

function PopFriendManagementLayer:hideSelectLayer(arg_40_1)
	self.panel_search:setVisible(arg_40_1)
	self.panel_scroll:setVisible(not arg_40_1)
end

function PopFriendManagementLayer:initFlashBtn()
	self.btn_flash:addTouchEventListener(function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.btn_flash:isBright() then
			return
		end

		self.btn_flash:setBright(false)
		self:updateTopBtn(1, true, function()
			if var_0_8 then
				self.btn_flash:setBright(true)
			end
		end)
	end)
end

function PopFriendManagementLayer:resetInPutText()
	self.editBox:setText("")
end

function PopFriendManagementLayer.sortByOnlinetime(arg_45_0, arg_45_1)
	if not arg_45_1 or not next(arg_45_1) then
		return
	end

	local var_45_0 = {}
	local var_45_1 = {}
	local var_45_2 = {}

	for iter_45_0, iter_45_1 in ipairs(arg_45_1) do
		if iter_45_1.lastlogin == "-1" then
			table.insert(var_45_0, iter_45_1)
		else
			table.insert(var_45_1, iter_45_1)
		end
	end

	if next(var_45_0) then
		table.sort(var_45_0, function(arg_46_0, arg_46_1)
			if arg_46_0.class == arg_46_1.class then
				return arg_46_0.level > arg_46_1.level
			else
				return arg_46_0.class > arg_46_1.class
			end
		end)

		for iter_45_2, iter_45_3 in ipairs(var_45_0) do
			table.insert(var_45_2, iter_45_3)
		end
	end

	if next(var_45_1) then
		table.sort(var_45_1, function(arg_47_0, arg_47_1)
			if math.ceil(global_get_time_by_date(arg_47_0.lastlogin) / 60) == math.ceil(global_get_time_by_date(arg_47_1.lastlogin) / 60) then
				if arg_47_0.class == arg_47_1.class then
					return arg_47_0.level > arg_47_1.level
				else
					return arg_47_0.class > arg_47_1.class
				end
			else
				return math.ceil(global_get_time_by_date(arg_47_0.lastlogin) / 60) > math.ceil(global_get_time_by_date(arg_47_1.lastlogin) / 60)
			end
		end)

		for iter_45_4, iter_45_5 in ipairs(var_45_1) do
			table.insert(var_45_2, iter_45_5)
		end
	end

	return var_45_2
end

function PopFriendManagementLayer:initApplyPanel(arg_48_1)
	self.tableViewdata = arg_48_1

	if not self.tableViewdata or not next(self.tableViewdata) then
		print("no  data !!!!!!!!!!!")
	end

	if self.panel_2:getChildByName("roleTableView") then
		self.panel_2:getChildByName("roleTableView"):removeFromParent()
	end

	self.nodata_img = ccui.Helper:seekWidgetByName(self.panel_2, "img_nodata")

	self.nodata_img:setVisible(false)

	self.apply_panel_ani = false

	if not self.panel_2:getChildByName("roleTableView") then
		self:createTableView()
	end

	self:getTableViewData()
end

function PopFriendManagementLayer:initIgnoreBtn(arg_49_1)
	self.btn_ignore_all:addTouchEventListener(function(arg_50_0, arg_50_1)
		if arg_50_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_49_1 then
			global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.no_apply_data)

			return
		else
			local function var_50_0()
				friend_system_manager:handle_friend_application(nil, 3, function(arg_52_0)
					if arg_52_0.result == 1 then
						self:updateTopBtn(2)
					else
						global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.operate_fail)
					end
				end)
			end

			;(function()
				self:addChild(ConfirmDialogSprite:create("", L_FRIEND_MANAGEMENT_LAYER.ignore_all_tips, {
					headImage = "friendsystem/mgr_info_igore_all.png",
					layerType = "PopFriendIntroduceLayer",
					surecallback = var_50_0,
					cancelcallback = function()
						return
					end
				}), 999)
			end)()
		end
	end)
end

function PopFriendManagementLayer:initAllAddBtn(arg_56_1)
	self.btn_add_all:addTouchEventListener(function(arg_57_0, arg_57_1)
		if arg_57_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_56_1 then
			global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.no_apply_data)

			return
		else
			local function var_57_0()
				friend_system_manager:handle_friend_application(nil, 4, function(arg_59_0)
					if arg_59_0.successlist then
						local var_59_0 = #arg_59_0.successlist or 0

						if var_59_0 > 0 then
							global_ShowBlockWords(string.format(L_FRIEND_MANAGEMENT_LAYER.accept_n_friend_success, var_59_0))
						elseif arg_59_0.result == 1 and var_59_0 <= 0 then
							global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.accept_fail)
						elseif arg_59_0.result == 2 and var_59_0 <= 0 then
							global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.friend_max)
						end
					end

					self:updateTopBtn(2)
				end)
			end

			;(function()
				self:addChild(ConfirmDialogSprite:create("", L_FRIEND_MANAGEMENT_LAYER.add_all_tips, {
					headImage = "friendsystem/mgr_info_add_all.png",
					layerType = "PopFriendIntroduceLayer",
					surecallback = var_57_0,
					cancelcallback = function()
						return
					end
				}), 999)
			end)()
		end
	end)
end

function PopFriendManagementLayer:createTableView()
	self.roleTableView = cc.TableView:create(cc.size(618, 722))

	self.roleTableView:setName("roleTableView")
	self.roleTableView:setPosition(cc.p(0, 40))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.panel_2:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rootLayer:setName("roleTableView")

	self.roleTableViewhight = 722

	self.roleTableView:setVisible(false)
end

function PopFriendManagementLayer:createNode()
	local var_64_0 = self.applyitem:clone()
	local var_64_1 = AvatarSprite:create(tonumber(9200101))

	var_64_1:setPosition(cc.p(36, 24))
	var_64_1:setName("avatar_face_pm")
	var_64_1:setScale(0.65)
	var_64_0:addChild(var_64_1)

	return var_64_0
end

function PopFriendManagementLayer:updateNode(arg_65_1, arg_65_2, arg_65_3)
	local var_65_0 = ccui.Helper:seekWidgetByName(arg_65_1, "level")
	local var_65_1 = ccui.Helper:seekWidgetByName(arg_65_1, "power")

	ccui.Helper:seekWidgetByName(arg_65_1, "player_name"):setString(arg_65_2.name)
	var_65_0:setString("LV." .. arg_65_2.level)
	var_65_0:setVisible(false)
	var_65_1:setString(global_trans_bitmapnumber(arg_65_2.fightpower))
	var_65_1:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	self:initPlayerGrade(arg_65_2.class, (ccui.Helper:seekWidgetByName(arg_65_1, "class_img")))

	local var_65_2 = arg_65_1:getChildByName("avatar_face_pm")

	var_65_2:switchShowAvatar(tonumber(arg_65_2.head_sculpture))
	var_65_2:addTouchEventListener(function(arg_66_0, arg_66_1)
		if arg_66_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_66_0

		if arg_65_2.playerid <= 0 then
			do return end

			var_66_0 = {
				layerName = "PopFriendManagementLayer",
				playeruid = arg_65_2.playerid
			}
		end

		function var_66_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_66_0)
	end)
	ccui.Helper:seekWidgetByName(arg_65_1, "btn_igrone"):addTouchEventListener(function(arg_68_0, arg_68_1)
		if arg_68_1 ~= ccui.TouchEventType.ended then
			return
		end

		friend_system_manager:handle_friend_application(arg_65_2.playerid, 2, function(arg_69_0)
			if arg_69_0.result == 1 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.igrone_apply)
				self:updateApplyPanel(arg_65_3)
			elseif arg_69_0.result == 2 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.friend_max)
			elseif arg_69_0.result == 3 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.friend_limit)
			elseif arg_69_0.result == 4 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.apply_invalid)
			else
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.operate_fail)
			end
		end)
	end)
	ccui.Helper:seekWidgetByName(arg_65_1, "btn_accept"):addTouchEventListener(function(arg_70_0, arg_70_1)
		if arg_70_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_70_1 ~= ccui.TouchEventType.ended then
			return
		end

		friend_system_manager:handle_friend_application(arg_65_2.playerid, 1, function(arg_71_0)
			if arg_71_0.result == 1 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.accept_friend_success)
				self:updateApplyPanel(arg_65_3)
				self:updateFriendNum()
			elseif arg_71_0.result == 2 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.friend_max)
			elseif arg_71_0.result == 3 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.friend_limit)
			elseif arg_71_0.result == 4 then
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.apply_invalid)
			else
				global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.operate_fail)
			end
		end)
	end)
end

function PopFriendManagementLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_76_0, arg_76_1)
		return var_0_15, var_0_16
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_73_0, arg_73_1)
		local var_73_0 = arg_73_0:dequeueCell()

		if not var_73_0 then
			var_73_0 = cc.TableViewCell:create()

			local var_73_1 = self:createNode()

			var_73_1:setName("node")
			var_73_1:setPosition(cc.p(5, -5))
			self:updateNode(var_73_1, self.tableViewdata[arg_73_1 + 1], arg_73_1)

			if arg_73_1 <= math.floor(self.roleTableViewhight / var_0_16) then
				var_73_1:setOpacity(0)
				var_73_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * arg_73_1), cc.FadeIn:create(0.1)))
			else
				var_73_1:setOpacity(255)
			end

			var_73_0:addChild(var_73_1)

			if self.apply_panel_ani then
				var_73_0:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_73_0:getPositionX() - 1500, var_73_0:getPositionY())), cc.CallFunc:create(function()
					cc.RemoveSelf:create()

					self.apply_panel_ani = false

					self:updateTopBtn(2)
				end)))
			end
		else
			local var_73_2 = var_73_0:getChildByName("node")

			var_73_2:setOpacity(255)
			self:updateNode(var_73_2, self.tableViewdata[arg_73_1 + 1], arg_73_1)

			if self.apply_panel_ani then
				var_73_0:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_73_0:getPositionX() - 1500, var_73_0:getPositionY())), cc.CallFunc:create(function()
					cc.RemoveSelf:create()

					self.apply_panel_ani = false

					self:updateTopBtn(2)
				end)))
			end
		end

		return var_73_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_77_0, arg_77_1)
		return #self.tableViewdata
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function PopFriendManagementLayer:holdOrOpenPanel(arg_78_1)
	self.roleTableView:setVisible(arg_78_1)
	self.nodata_img:setVisible(not arg_78_1)
end

function PopFriendManagementLayer:getTableViewData()
	if not self.tableViewdata then
		self:holdOrOpenPanel(false)

		return
	end

	self:holdOrOpenPanel(true)
	self:initTableView()
end

function PopFriendManagementLayer:updateApplyPanel(arg_80_1)
	if not arg_80_1 or not self.tableViewdata or not next(self.tableViewdata) then
		return
	end

	local var_80_0, var_80_1 = GetTableViewShowCellIdx(self.roleTableView, {
		cellsize = cc.size(var_0_15, var_0_16),
		maxcount = #self.tableViewdata
	})

	if var_80_0 <= arg_80_1 and arg_80_1 <= var_80_1 then
		self.apply_panel_ani = true

		self.roleTableView:updateCellAtIndex(arg_80_1)
	end
end

function PopFriendManagementLayer:updateBtnAlert()
	if RoleDefault:getInstance():getBoolForKey("NewFriendApplyHave", false) then
		global_add_alert_tag(self.btn_2, (cc.p(180, 74)))
	else
		global_remove_alert_tag(self.btn_2)
	end
end

function PopFriendManagementLayer.registerActivityEventListener(arg_82_0)
	activity_manager:registerEventListener("PopFriendManagementLayer", activity_manager.activityEventId.FRIEND_NEW_APPLY_NOTICE, function(arg_83_0)
		arg_82_0:updateBtnAlert()
	end)
end

function PopFriendManagementLayer:updateApplyNumLable(arg_84_1)
	arg_84_1 = arg_84_1 or 0

	self.apply_limit_tips:setString((arg_84_1 == "" or (friend_system_manager:geMaxFriendApplyNum() or "") == "" or nil) and "")
end

function PopFriendManagementLayer:initBg(arg_85_1)
	local var_85_0 = ccui.Layout:create()

	var_85_0:setTouchEnabled(true)
	var_85_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_85_0:setAnchorPoint(cc.p(0, 0))
	var_85_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_85_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_85_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_85_0:setOpacity(0)
	var_85_0:setCascadeOpacityEnabled(false)
	self:addChild(var_85_0, -1)

	local var_85_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_85_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_85_1:setPositionX(var_85_0:getContentSize().width / 2)
	var_85_1:setPositionY(var_85_0:getContentSize().height / 2)
	var_85_0:addChild(var_85_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_86_0)
		self:addChild(arg_86_0, -2)
		arg_86_0:setPositionY(arg_86_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_85_1)
		var_85_0:setOpacity(102)
		var_85_0:setTouchEnabled(false)
	end)
end

function PopFriendManagementLayer:exit()
	self.hideActions.shrinkBoth(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
