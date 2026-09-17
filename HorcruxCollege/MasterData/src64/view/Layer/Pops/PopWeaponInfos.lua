local var_0_0 = config._DEBUG and 0 or 1
local component_manager = require("controller.component_manager")
local audio_manager = require("controller.audio_manager")
local component_effect_data = require("data.component_effect_data")
local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")
local var_0_7 = require("data.item_data")
local var_0_8 = require("data.item_data")
local playermodel = require("model.playermodel")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local core_manager = require("controller.core_manager")
local array_manager = require("controller.array_manager")
local level_manager = require("controller.level_manager")
local patrol_manager = require("controller.patrol_manager")
local network = require("network.network")
local var_0_16 = L_POP_INTRO_TITLE
local var_0_17

function PopBaseLayer:Layer_Item_Info(arg_1_1)
	local var_1_0 = cc.Layer:create()
	local var_1_1 = arg_1_1.entityid
	local var_1_2 = tonumber(arg_1_1.itemid)
	local var_1_5 = 490
	local var_1_6 = 65
	local var_1_7 = {}
	local var_1_8
	local var_1_9 = false
	local var_1_10 = 20
	local var_1_11 = 245

	if tonumber(var_1_2) ~= nil then
		var_1_9 = true
		var_1_8 = var_0_7[var_1_2]
	end

	local var_1_12 = ccui.ImageView:create("public/panelbg/intro_bottom.png", var_0_0)

	var_1_12:setScale9Enabled(true)
	var_1_12:setContentSize(cc.size(470, 50))
	var_1_12:setAnchorPoint(cc.p(0, 1))
	var_1_12:setPosition(cc.p(53, var_1_5 - 220))
	var_1_0:addChild(var_1_12, 1)

	local var_1_13 = cc.Label:createWithTTF("", FONT_NAME, 17)

	var_1_13:setString(item_data[var_1_2].user_manual or L_ITEM_NAME_DEFAULT)
	var_1_13:setPosition(cc.p(10, 50 - 10))
	var_1_13:setAnchorPoint(cc.p(0, 1))
	var_1_13:setMaxLineWidth(470)
	var_1_13:setColor(cc.c3b(243, 249, 255))
	var_1_12:addChild(var_1_13)

	local var_1_14 = var_0_16[var_1_8.bag_item_type] or ""
	local var_1_15
	local var_1_16 = cc.Label:createWithTTF(var_1_14 .. L_ITEM_INFO_LOCK, FONT_DES, 17)

	var_1_16:setColor(cc.c3b(188, 206, 226))
	var_1_16:setMaxLineWidth(450)

	if var_1_8 and var_1_8.intro then
		var_1_15 = math.ceil(17 * string.len(var_1_14 .. var_1_8.intro) / 3 / 430) + 1

		var_1_16:setString(var_1_14 .. var_1_8.intro)
	end

	local var_1_17 = ccui.ImageView:create("public/panelbg/intro_bottom.png", var_0_0)

	var_1_17:setScale9Enabled(true)
	var_1_17:setContentSize(cc.size(470, 30))
	var_1_17:setAnchorPoint(cc.p(0, 1))
	var_1_0:addChild(var_1_17, 1)

	if var_1_1 then
		self.Strength_Icon = ItemSprite:createBigWithEntityId(var_1_1, arg_1_1.dropnum or playermodel.items[var_1_1].number)

		if self.Strength_Icon:getChildByName("use") then
			local var_1_19

			if item_data[var_1_2].bag_item_type == kITEM_COMPONENT then
				var_1_19 = playermodel.items[var_1_1].component_attr.use
			elseif item_data[var_1_2].bag_item_type == kITEM_WEAPON then
				var_1_19 = playermodel.items[var_1_1].weapon_attr.use
			end

			if var_1_19 then
				self.Strength_Icon:getChildByName("use"):setVisible(true)
			else
				self.Strength_Icon:getChildByName("use"):setVisible(false)
			end
		end

		if self.Strength_Icon:getChildByName("lock") then
			self.Strength_Icon:getChildByName("lock"):setVisible(false)
		end

		if item_data[var_1_2].bag_item_type == kITEM_COMPONENT then
			var_1_7 = component_manager:initComponentIntro(var_1_1, true)

			var_1_17:setPosition(cc.p(53, var_1_5 - 285))

			if 17 * var_1_15 + 6 > 140 then
				var_1_17:setContentSize(cc.size(470, 17 * var_1_15 + 6))
				var_1_16:setPosition(cc.p(10, 17 * var_1_15 - 4))
			else
				var_1_17:setContentSize(cc.size(470, var_1_6))
				var_1_16:setPosition(cc.p(10, var_1_6 - 10))
			end

			var_1_16:setAnchorPoint(cc.p(0, 1))
		elseif item_data[var_1_2].bag_item_type == kITEM_WEAPON then
			var_1_7 = weapon_manager:getWeaponInfowithEntityid(var_1_1)

			var_1_17:setPosition(cc.p(53, var_1_5 - 280))
			var_1_17:setContentSize(cc.size(470, var_1_6))
			var_1_16:setAnchorPoint(cc.p(0, 1))
			var_1_16:setPosition(cc.p(10, var_1_6 - 10))
		end
	else
		self.Strength_Icon = ItemSprite:createNewWithItemId(var_1_2, nil, nil, nil, arg_1_1.item_attr)

		if var_1_9 == true then
			if item_data[var_1_2].bag_item_type == kITEM_COMPONENT and arg_1_1.itemattr and #arg_1_1.itemattr ~= 0 then
				var_1_7 = component_manager:initComponentIntrowithItemid(var_1_2, arg_1_1.itemattr)
			elseif item_data[var_1_2].bag_item_type == kITEM_WEAPON and arg_1_1.itemattr and #arg_1_1.itemattr ~= 0 then
				var_1_7 = weapon_manager:initWeaponInfowithItemid(var_1_2, arg_1_1.itemattr)
			end
		end

		var_1_17:setPosition(cc.p(53, var_1_5 - 280))
		var_1_17:setContentSize(cc.size(470, var_1_6))
		var_1_16:setAnchorPoint(cc.p(0, 1))
		var_1_16:setPosition(cc.p(10, var_1_6 - 10))
	end

	self.Strength_Icon:setPosition(cc.p(140, 410))
	self.Strength_Icon:setScale(0.62)
	self.Strength_Icon:setName("Strength_Icon")
	self:ActionofAccess(self.Strength_Icon)
	var_1_0:addChild(self.Strength_Icon, 1)

	if var_1_9 == true then
		if item_data[var_1_2].bag_item_type == kITEM_COMPONENT and next(var_1_7) ~= nil then
			self.info_label = {}

			local var_1_20 = {
				L_WEAPON_MAIN_ATTR .. "：\n",
				L_WEAPON_SUB_ATTR .. "：\n",
				[#var_1_7] = ""
			}

			if playermodel.items[var_1_1].component_attr.attr2 then
				var_1_20 = {
					L_WEAPON_MAIN_ATTR .. "：\n",
					[2] = "",
					[3] = L_WEAPON_SUB_ATTR .. "：\n",
					[#var_1_7] = ""
				}
			end

			for iter_1_0 = 1, #var_1_7 - 1 do
				if var_1_20[iter_1_0] then
					self.info_label[iter_1_0] = cc.Label:createWithTTF(var_1_20[iter_1_0] .. var_1_7[iter_1_0], FONT_DES, var_1_10)

					if iter_1_0 ~= 1 then
						var_1_5 = var_1_5 - 60
					end
				else
					self.info_label[iter_1_0] = cc.Label:createWithTTF(var_1_7[iter_1_0], FONT_DES, var_1_10)
					var_1_5 = var_1_5 - self.info_label[iter_1_0 - 1]:getContentSize().height
				end

				if playermodel.items[var_1_1].component_attr.attr2 then
					if iter_1_0 == 1 or iter_1_0 == 2 then
						self.info_label[iter_1_0]:setColor(cc.c3b(0, 216, 255))
					else
						self.info_label[iter_1_0]:setColor(cc.c3b(243, 249, 255))
					end
				elseif iter_1_0 == 1 then
					self.info_label[iter_1_0]:setColor(cc.c3b(0, 216, 255))
				else
					self.info_label[iter_1_0]:setColor(cc.c3b(243, 249, 255))
				end

				self.info_label[iter_1_0]:setAnchorPoint(cc.p(0, 1))
				self.info_label[iter_1_0]:setPosition(cc.p(var_1_11, var_1_5 - 2))
				var_1_0:addChild(self.info_label[iter_1_0])
			end

			var_1_13:setString(var_1_20[#var_1_7] .. var_1_7[#var_1_7])

			if arg_1_1.servantid and COMPONENT_SERVANT_LIMIT and core_manager:getServantCoreRank(arg_1_1.servantid) < COMPONENT_SERVANT_LIMIT[var_0_8[playermodel.items[var_1_1].itemid].equip_quality] or playermodel.items[var_1_1].component_attr.extra < var_0_8[playermodel.items[var_1_1].itemid].equip_quality * 5 then
				var_1_5 = var_1_5 - 50

				local var_1_21 = {
					L_WEAPON_MAIN_ATTR_EFFECTIVE .. "：",
					L_WEAPON_SUB_ATTR_EFFECTIVE .. "：",
					[#var_1_7] = ""
				}

				self.line = ccui.Layout:create()

				self.line:setTouchEnabled(true)
				self.line:setContentSize(cc.size(300, 2))
				self.line:setAnchorPoint(cc.p(0, 1))
				self.line:setPosition(cc.p(230, var_1_5 + 2))
				self.line:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				self.line:setBackGroundColor(cc.c3b(113, 119, 134))
				self.line:setBackGroundColorOpacity(255)
				var_1_0:addChild(self.line)

				local var_1_22 = component_manager:initComponentIntro(var_1_1, true, nil, arg_1_1.servantid)

				self.limit_info_label = {}

				for iter_1_1 = 1, #var_1_22 - 1 do
					if var_1_22[iter_1_1] then
						self.limit_info_label[iter_1_1] = cc.Label:createWithTTF(var_1_21[iter_1_1] .. "\n" .. var_1_22[iter_1_1], FONT_DES, var_1_10)

						if iter_1_1 ~= 1 then
							var_1_5 = var_1_5 - 45
						end
					else
						self.limit_info_label[iter_1_1] = cc.Label:createWithTTF(var_1_22[iter_1_1], FONT_DES, var_1_10)
						var_1_5 = var_1_5 - self.limit_info_label[iter_1_1 - 1]:getContentSize().height
					end

					self.limit_info_label[iter_1_1]:setAnchorPoint(cc.p(0, 1))
					self.limit_info_label[iter_1_1]:setPosition(cc.p(230, var_1_5 - 2))
					var_1_0:addChild(self.limit_info_label[iter_1_1])
					self:ActionofAccess(self.limit_info_label[iter_1_1])

					if var_1_22[1] == var_1_7[1] then
						self.limit_info_label[iter_1_1]:setVisible(false)
						self.line:setVisible(false)
					end

					if playermodel.items[var_1_1].component_attr.attr2 then
						if iter_1_1 == 1 or iter_1_1 == 2 then
							self.info_label[iter_1_1]:setColor(cc.c3b(0, 216, 255))
						else
							self.info_label[iter_1_1]:setColor(cc.c3b(243, 249, 255))
						end
					elseif iter_1_1 == 1 then
						self.info_label[iter_1_1]:setColor(cc.c3b(0, 216, 255))
					else
						self.info_label[iter_1_1]:setColor(cc.c3b(243, 249, 255))
					end
				end
			end
		elseif item_data[var_1_2].bag_item_type == kITEM_WEAPON and next(var_1_7) then
			self.info_label = {}

			local var_1_24 = {}

			table.insert(var_1_24, {
				key = "mainAttrDes",
				value = L_WEAPON_MAIN_ATTR
			})

			for iter_1_2, iter_1_3 in pairs(var_1_7.mainAttr) do
				table.insert(var_1_24, {
					key = iter_1_3.key,
					value = iter_1_3.value
				})
			end

			table.insert(var_1_24, {
				key = "subAttrDes",
				value = L_WEAPON_SUB_ATTR
			})

			for iter_1_4, iter_1_5 in pairs(var_1_7.subAttr) do
				table.insert(var_1_24, {
					key = iter_1_5.key,
					value = iter_1_5.value
				})
			end

			for iter_1_6, iter_1_7 in pairs(var_1_24) do
				self.info_label[iter_1_6] = cc.Label:createWithTTF(iter_1_7.value, FONT_DES, var_1_10)

				self.info_label[iter_1_6]:setAnchorPoint(cc.p(0, 1))
				self.info_label[iter_1_6]:setPosition(cc.p(var_1_11, var_1_5 - 2))

				self.info_label[iter_1_6].key = iter_1_7.key

				var_1_0:addChild(self.info_label[iter_1_6])

				var_1_5 = var_1_5 - self.info_label[iter_1_6]:getContentSize().height

				if iter_1_7.key == "mainAttrDes" or iter_1_7.key == "subAttrDes" then
					self.info_label[iter_1_6]:setColor(cc.c3b(0, 216, 255))
				else
					self.info_label[iter_1_6]:setColor(cc.c3b(243, 249, 255))
				end
			end
		end

		if item_data[var_1_2].bag_item_type == kITEM_WEAPON and var_1_1 then
			function var_1_0:updateShow()
				var_1_7 = weapon_manager:getWeaponInfowithEntityid(var_1_1)

				if next(var_1_7) then
					local var_2_0 = {}

					table.insert(var_2_0, {
						key = "mainAttrDes",
						value = L_WEAPON_MAIN_ATTR
					})

					for iter_2_0, iter_2_1 in pairs(var_1_7.mainAttr) do
						table.insert(var_2_0, {
							key = iter_2_1.key,
							value = iter_2_1.value
						})
					end

					table.insert(var_2_0, {
						key = "subAttrDes",
						value = L_WEAPON_SUB_ATTR
					})

					for iter_2_2, iter_2_3 in pairs(var_1_7.subAttr) do
						table.insert(var_2_0, {
							key = iter_2_3.key,
							value = iter_2_3.value
						})
					end

					for iter_2_4, iter_2_5 in pairs(var_2_0) do
						if not self.info_label[iter_2_4] then
							self.info_label[iter_2_4] = cc.Label:createWithTTF(iter_2_5.value, FONT_DES, var_1_10)

							self.info_label[iter_2_4]:setAnchorPoint(cc.p(0, 1))
							self.info_label[iter_2_4]:setPosition(cc.p(var_1_11, var_1_5 - 2))
							self:addChild(self.info_label[iter_2_4])

							var_1_5 = var_1_5 - self.info_label[iter_2_4]:getContentSize().height
							self.info_label[iter_2_4].key = iter_2_5.key
						end

						self.info_label[iter_2_4]:setString(iter_2_5.value)

						if iter_2_5.key == "mainAttrDes" or iter_2_5.key == "subAttrDes" then
							self.info_label[iter_2_4]:setColor(cc.c3b(0, 216, 255))
						else
							self.info_label[iter_2_4]:setColor(cc.c3b(203, 218, 235))
						end
					end
				end

				self.Strength_Icon:updateBigInfo(false)

				if self.Strength_Icon:getChildByName("lock") then
					self.Strength_Icon:getChildByName("lock"):setVisible(false)
				end
			end
		end

		if item_data[var_1_2].bag_item_type == kITEM_COMPONENT or item_data[var_1_2].bag_item_type == kITEM_WEAPON then
			local var_1_25 = cc.Label:createWithTTF("", FONT_DES, 22)

			var_1_25:setPosition(cc.p(210, 510))
			var_1_25:setAnchorPoint(cc.p(1, 1))
			var_1_25:setColor(cc.c3b(198, 197, 38))
			var_1_0:addChild(var_1_25, 100)

			if arg_1_1.tag_exist == false then
				var_1_25:setString("new")
			end

			if arg_1_1.tag_equip == true then
				var_1_25:setString(L_COMPONENT_AUTO_EQUIP)
			end
		else
			local var_1_26 = cc.Label:createWithTTF("", FONT_DES, 20)

			var_1_26:setAnchorPoint(cc.p(0, 0.5))
			var_1_26:setPosition(cc.p(245, var_1_5 - 20))
			var_1_26:setColor(cc.c3b(0, 216, 255))
			var_1_0:addChild(var_1_26, 1)

			if item_data[var_1_2].bag_item_type ~= 13 then
				var_1_26:setString(L_ITEM_NUMBER .. item_manager:getItemNumber(arg_1_1.itemid))
			else
				var_1_26:setString(item_data[var_1_2].name)
			end

			var_1_17:setPosition(cc.p(53, var_1_5 - 280))

			if self.costLayer then
				var_1_17:setContentSize(cc.size(470, var_1_6))
				var_1_16:setPosition(cc.p(10, var_1_6 - 10))
			else
				var_1_17:setContentSize(cc.size(470, var_1_6))
				var_1_16:setPosition(cc.p(10, var_1_6 - 10))
			end

			var_1_16:setAnchorPoint(cc.p(0, 1))
		end
	end

	local var_1_27 = cc.Label:createWithTTF(item_data[var_1_2].name, FONT_DES, 32)

	var_1_27:setColor(cc.c3b(188, 206, 226))
	var_1_27:setAnchorPoint(0, 0.5)
	var_1_27:setPosition(cc.p(var_1_11, 510))
	var_1_0:addChild(var_1_27, 1)
	var_1_16:setDimensions(460, 0)
	var_1_17:addChild(var_1_16, 2)
	self:ActionofAccess(var_1_17)

	if item_data[var_1_2].bagweight and item_data[var_1_2].bagweight ~= 0 then
		local var_1_28 = ccui.Helper:seekWidgetByName(arg_1_1.panel, "image_bg")
		local var_1_29 = ccui.Helper:seekWidgetByName(arg_1_1.panel, "title")

		var_1_28:setContentSize(cc.size(532, 540))
		var_1_28:setPositionY(var_1_28:getPositionY() + 17)

		local var_1_30 = cc.Label:createWithTTF(L_ITEM_WEIGHT .. item_data[var_1_2].bagweight, FONT_DES, 20)

		var_1_30:setColor(cc.c3b(188, 206, 226))
		var_1_30:setAnchorPoint(cc.p(1, 0))
		var_1_30:setPosition(cc.p(520, 120))
		var_1_0:addChild(var_1_30)
	end

	local var_1_31 = ccui.Button:create("public/button/button_saying.png", nil, "public/button/button_saying.png", var_0_0)

	var_1_31:setPosition(cc.p(470, 295))
	var_1_31:setName("GainButton")
	var_1_0:addChild(var_1_31, 1)

	if arg_1_1.hideGainButton == true then
		var_1_31:setVisible(false)
	end

	var_1_31:setVisible(false)
	var_1_31:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_3_0()
			self.Pop:setVisible(true)
		end

		self.Pop:setVisible(false)

		local var_3_1 = PopLayer.new()
		local var_3_2 = PopLayer:Go_Gain_Layer({
			item = var_1_2,
			surecallback = function()
				self:runAction(cc.RemoveSelf:create())

				if arg_1_1.cancelcallback then
					arg_1_1.cancelcallback()
				end

				if arg_1_1.removeParentCallback then
					arg_1_1.removeParentCallback()
				end
			end,
			returnlayer = arg_1_1.returnlayer,
			goto_back_system_id = arg_1_1.goto_back_system_id,
			goto_back_system_config = arg_1_1.goto_back_system_config,
			cancelcallback = var_3_0
		})

		if var_3_2 then
			cc.Director:getInstance():getRunningScene():addChild(var_3_2, 999)
		end
	end)

	local var_1_32 = ccui.ImageView:create("public/panelbg/title_component.png", var_0_0)

	var_1_32:setAnchorPoint(cc.p(0, 0.5))
	var_1_32:setPosition(cc.p(34, 578))
	var_1_0:addChild(var_1_32)

	if item_data[var_1_2].bag_item_type == kITEM_WEAPON then
		var_1_32:loadTexture("public/panelbg/title_weapon.png", var_0_0)
	elseif item_data[var_1_2].bag_item_type == kITEM_COMPONENT then
		-- block empty
	else
		var_1_32:loadTexture("public/panelbg/title_item.png", var_0_0)
	end

	return var_1_0
end

function PopBaseLayer.ActionofAccess(arg_6_0, arg_6_1)
	arg_6_1:setOpacity(0)
	arg_6_1:setScale(1, 0.001)
	arg_6_1:runAction((cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.1), cc.ScaleTo:create(0.1, 1, 1)))))
end

function PopBaseLayer:removeSelf()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

PopWeaponInfos = class("PopWeaponInfos", function()
	return PopBaseLayer:create()
end)

function PopWeaponInfos.create(arg_10_0, arg_10_1)
	local var_10_0 = PopWeaponInfos.new()

	var_10_0:init(arg_10_1)

	return var_10_0
end

function PopWeaponInfos.fullScreen(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1:setContentSize(GameDisplay.getScreenSize())
	arg_11_2:setPositionY(arg_11_2:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
end

function PopWeaponInfos:init(arg_12_1)
	var_0_17 = arg_12_1

	local var_12_0 = playermodel.items[arg_12_1.entityid]
	local var_12_2 = weapon_manager:getWeaponConfig(playermodel.items[arg_12_1.entityid])

	self.Pop = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Popup_normal.json" or "Popup_normal.ExportJson")

	self:addChild(self.Pop)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.Pop, "panel_back")

	local var_12_3 = ccui.Helper:seekWidgetByName(self.Pop, "panel_all")
	local var_12_4 = ccui.Helper:seekWidgetByName(self.Pop, "bg")

	var_12_4:setPosition(cc.p(var_12_4:getPositionX() - 10, var_12_4:getPositionY() - 25))

	local var_12_5 = ccui.Helper:seekWidgetByName(self.Pop, "title")
	local var_12_6 = ccui.Helper:seekWidgetByName(self.Pop, "button_sure")
	local var_12_7 = var_12_6:getChildByName("label")

	ccui.Helper:seekWidgetByName(self.Pop, "image_system_figure"):setVisible(false)
	self.Pop:setAnchorPoint(cc.p(0.5, 0.5))
	self:ActionofAccess(self.rootpanel)
	self.Pop:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, self.rootpanel:getContentSize().height / 2))
	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, self.rootpanel:getContentSize().height / 2))

	local function var_12_8(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_12_1.cancelcallback then
			arg_12_1.cancelcallback()
		end

		self:removeSelf(self.rootpanel)

		if arg_12_1.backUpdateCallback then
			arg_12_1.backUpdateCallback()
		end
	end

	arg_12_1.panel = self.rootpanel

	if arg_12_1.itemid then
		self.layer_item_info = self:Layer_Item_Info(arg_12_1)

		self.layer_item_info:setPosition(cc.p(20, 280))
		self.rootpanel:addChild(self.layer_item_info, 1)
	end

	ccui.Helper:seekWidgetByName(self.Pop, "button_close"):addTouchEventListener(var_12_8)
	var_12_3:addTouchEventListener(var_12_8)
	var_12_4:setTouchEnabled(true)

	self.lockBnt = var_12_0.weapon_attr.lock and ccui.Button:create("public/button/pop_unlock.png", nil, "public/button/pop_unlock.png", var_0_0) or ccui.Button:create("public/button/pop_lock.png", nil, "public/button/pop_lock.png", var_0_0)

	self.lockBnt:setAnchorPoint(cc.p(0.5, 0.5))
	self.lockBnt:setPosition(530, 790)
	self.lockBnt:setName("lockbtn")
	self.rootpanel:addChild(self.lockBnt)
	self.lockBnt:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_14_0:setTouchEnabled(false)
		network:rpc("lock_item", {
			locktype = var_12_0.weapon_attr.lock and 1 or 2,
			entityid = arg_12_1.entityid
		}, function(arg_15_0)
			arg_14_0:setTouchEnabled(true)

			if arg_15_0.result == 1 then
				var_12_0.weapon_attr.lock = arg_15_0.lock

				if var_12_0.weapon_attr.lock then
					arg_14_0:loadTextures("public/button/pop_unlock.png", nil, "public/button/pop_unlock.png", var_0_0)
				else
					arg_14_0:loadTextures("public/button/pop_lock.png", nil, "public/button/pop_lock.png", var_0_0)
				end
			else
				l2Log("lock fail")
			end
		end)
	end)

	local function var_12_11(arg_18_0)
		local var_18_0

		if arg_18_0 == "big" then
			var_18_0 = var_12_6

			var_12_6:setVisible(true)
			var_18_0:getChildByName("label"):setColor(cc.c3b(41, 49, 58))
		elseif arg_18_0 == "small" then
			var_12_6:setVisible(false)

			var_18_0 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_gray.png", var_0_0)

			var_18_0:setPosition(440, 310)
			self.rootpanel:addChild(var_18_0)

			local var_18_1 = cc.Label:createWithTTF(L_BUTTON_TEXT.Strengthen, FONT_BUTTON, 30)

			var_18_1:setColor(cc.c3b(41, 49, 58))
			var_18_1:setName("label")
			var_18_1:setPosition(cc.p(var_18_0:getContentSize().width / 2, var_18_0:getContentSize().height / 2))
			var_18_0:addChild(var_18_1)
		end

		var_18_0:setName("strengthenBtn")
		var_18_0:setPressedActionEnabled(true)

		if weapon_manager:isTipsStrengWeapon(arg_12_1.servantid) then
			var_18_0:getChildByName("label"):setVisible(false)

			self.labelStreng = cc.Label:createWithTTF(L_BUTTON_TEXT.Strengthen, FONT_BUTTON, 30)

			self.labelStreng:setPosition(var_18_0:getPosition())
			self.labelStreng:setColor(cc.c3b(41, 49, 58))
			self.rootpanel:addChild(self.labelStreng, 99999)
			var_18_0:setLocalZOrder(999)

			self.imageBtnFade = ccui.ImageView:create("EquipLayer/btn_fade.png", var_0_0)

			self.rootpanel:addChild(self.imageBtnFade, 9999)
			self.imageBtnFade:setPosition(cc.p(440, 310))
			self.imageBtnFade:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.8, 0), cc.FadeTo:create(0.8, 255), cc.DelayTime:create(0.4))))
		end

		var_18_0:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			local function var_19_0()
				self:setVisible(true)
				self.rootpanel:updateShow()
				self.layer_item_info:updateShow()

				if arg_12_1.updateCallback then
					arg_12_1.updateCallback()
				end
			end

			self:setVisible(false)
			LayerManager:pushInLayer("PopWeaponUpLevelList", {
				entityid = arg_12_1.entityid,
				exitCallback = var_19_0
			})
		end)

		return var_18_0
	end

	local function var_12_12()
		local var_21_0 = ccui.Button:create("public/button/public_button_orange.png", nil, "public/button/public_button_gray.png", var_0_0)

		var_21_0:setName("upgradeBnt")
		var_21_0:setPosition(200, 310)
		self.rootpanel:addChild(var_21_0)

		local var_21_1 = cc.Label:createWithTTF(L_BUTTON_TEXT.Up_Star, FONT_BUTTON, 30)

		var_21_1:setColor(cc.c3b(41, 49, 58))
		var_21_1:setName("label")
		var_21_1:setPosition(cc.p(var_21_0:getContentSize().width / 2, var_21_0:getContentSize().height / 2))
		var_21_0:addChild(var_21_1)

		local function var_21_2()
			if playermodel.items[arg_12_1.entityid].weapon_attr.nowStars < item_data[playermodel.items[arg_12_1.entityid].itemid].max_star then
				var_21_0:setVisible(true)
				var_21_0:getChildByName("label"):setString(L_BUTTON_TEXT.Up_Star)
			elseif item_data[playermodel.items[arg_12_1.entityid].itemid].equip_quality > 5 then
				var_21_0:getChildByName("label"):setString(L_WEAPON_STAR.Star_Full)
			else
				var_21_0:getChildByName("label"):setString(L_BUTTON_TEXT.Up_Grade)
			end

			if weapon_manager:checkIsCanUpgrade(arg_12_1.entityid) then
				AlertManager:add_alert_by_config(var_21_0, true, {
					ALERT_SHOW_REDDOT,
					"",
					cc.p(var_21_0:getContentSize().width - 20, var_21_0:getContentSize().height - 20)
				})
			else
				var_21_0:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", var_0_0)
			end
		end

		var_21_2()
		var_21_0:addTouchEventListener(function(arg_23_0, arg_23_1)
			if arg_23_1 ~= ccui.TouchEventType.ended then
				return
			end

			if playermodel.items[arg_12_1.entityid].weapon_attr.nowStars < item_data[playermodel.items[arg_12_1.entityid].itemid].max_star then
				local var_23_0 = weapon_manager:getWeaponConfig(playermodel.items[arg_12_1.entityid])
				local var_23_1 = require("data.weapon_strengthen" .. item_data[arg_12_1.itemid].equip_quality .. "_data")
				local var_23_2 = item_data[arg_12_1.itemid]["upgrade_need_num" .. playermodel.items[arg_12_1.entityid].weapon_attr.nowStars + 1] or 1

				self.Pop:setVisible(false)

				local var_23_3 = {
					showIntro = true,
					labels = {
						{
							newvalue = FIGHT_ATTR_FORMAT(var_23_0.sub_attr.attrtype, var_23_0.sub_attr.value) .. " → " .. weapon_manager:getNextStarAttrValue(arg_12_1.entityid),
							name = FIGHT_ATTR_INFO[var_23_0.sub_attr.attrtype] .. ": "
						}
					},
					materials = {},
					cancelcallback = function()
						if self.Pop then
							self.Pop:setVisible(true)
						end
					end
				}
				local var_23_4 = item_manager:getItemByItemId(arg_12_1.itemid)

				for iter_23_0 = #var_23_4, 1, -1 do
					if var_23_4[iter_23_0] == arg_12_1.entityid or playermodel.items[var_23_4[iter_23_0]].weapon_attr.use then
						table.remove(var_23_4, iter_23_0)
					end
				end

				table.sort(var_23_4, function(arg_25_0, arg_25_1)
					local var_25_0 = playermodel.items[arg_25_0].weapon_attr
					local var_25_1 = playermodel.items[arg_25_1].weapon_attr

					if playermodel.items[arg_25_0].weapon_attr.nowStars == playermodel.items[arg_25_1].weapon_attr.nowStars then
						return var_25_0.level < var_25_1.level
					else
						return var_25_0.nowStars < var_25_1.nowStars
					end
				end)

				local function var_23_5(arg_26_0)
					if #var_23_4 < 1 then
						return -1
					elseif #var_23_4 >= 1 then
						table.remove(var_23_4, 1)

						return var_23_4[1]
					end
				end

				local var_23_6 = {}

				for iter_23_1 = 1, var_23_2 do
					local var_23_7 = var_23_5(arg_12_1.itemid)

					table.insert(var_23_3.materials, {
						neednum = 1,
						entityid = var_23_7,
						id = arg_12_1.itemid,
						ownnum = var_23_7 > 0 and 1 or 0
					})

					if var_23_7 < 0 then
						-- block empty
					end

					table.insert(var_23_6, var_23_7)
				end

				function var_23_3.surecallback(arg_27_0, arg_27_1)
					local function var_27_0()
						local var_28_0 = weapon_manager:getWeaponConfig(playermodel.items[arg_12_1.entityid]).sub_attr.value

						weapon_manager:UpgradeWeapon(arg_12_1.entityid, var_23_6, function(arg_29_0)
							if arg_29_0 == 1 then
								self.layer_item_info:updateShow()
								self.Pop:setVisible(true)

								if arg_27_0 then
									arg_27_0()
								end

								if arg_12_1.updateCallback then
									arg_12_1.updateCallback()
								end

								local var_29_1 = weapon_manager:getWeaponConfig(playermodel.items[arg_12_1.entityid])
								local var_29_2 = {
									L_COMPONENT_TEXT.prefix_str[4] .. FIGHT_ATTR_INFO[var_29_1.sub_attr.attrtype] .. "+" .. FIGHT_ATTR_FORMAT(var_29_1.sub_attr.attrtype, var_29_1.sub_attr.value - var_28_0)
								}

								if weapon_manager:checkIsCanUpgrade(arg_12_1.entityid) then
									AlertManager:add_alert_by_config(var_21_0, true, {
										ALERT_SHOW_REDDOT,
										"",
										cc.p(var_21_0:getContentSize().width - 20, var_21_0:getContentSize().height - 20)
									})
								else
									AlertManager:add_alert_by_config(var_21_0, false, {
										ALERT_SHOW_REDDOT,
										"",
										cc.p(var_21_0:getContentSize().width - 20, var_21_0:getContentSize().height - 20)
									})
								end

								var_21_2()
								self:playStarUpEffect(arg_12_1.entityid, var_29_2)
							elseif arg_29_0 == 2 then
								global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[2])
							elseif arg_29_0 == 3 then
								global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[3])
							elseif arg_29_0 == 4 then
								global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[4])
							elseif arg_29_0 == 5 then
								global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[5])
							end
						end)
					end

					local var_27_1

					for iter_27_0, iter_27_1 in pairs(var_23_6) do
						if playermodel.items[iter_27_1].weapon_attr.lock then
							var_27_1 = 1

							break
						end

						if playermodel.items[iter_27_1].weapon_attr.level > 0 then
							var_27_1 = 2

							break
						end

						if playermodel.items[iter_27_1].weapon_attr.nowStars > 0 then
							var_27_1 = 3

							break
						end
					end

					local function var_27_2()
						arg_27_1(true)
					end

					if var_27_1 then
						require("view.Sprite.ConfirmDialogSprite")
						global_basic_scene:addChild(ConfirmDialogSprite:create(L_WEAPON_UPGRADE_SURE.Title, ({
							L_WEAPON_UPGRADE_MATERIAL_LOCK[1],
							L_WEAPON_UPGRADE_MATERIAL_LOCK[2],
							L_WEAPON_UPGRADE_MATERIAL_LOCK[3]
						})[var_27_1] .. L_WEAPON_UPGRADE_SURE.Comfirm, {
							surecallback = var_27_0,
							cancelCallback = var_27_2
						}, nil, nil, function()
							arg_27_1(true)
						end), 999)
					else
						var_27_0()
					end
				end

				var_23_3.title = L_WEAPON_UPGRADE.title
				var_23_3.bntstr = L_WEAPON_UPGRADE.bntstr
				var_23_3.goto_back_system_id = arg_12_1.goto_back_system_id
				var_23_3.removeCallback = arg_12_1.removeCallback

				LayerManager:pushInLayer("PopUpgradeCostlayer", var_23_3)
			else
				if item_data[playermodel.items[arg_12_1.entityid].itemid].equip_quality >= 6 then
					return
				end

				self.Pop:setVisible(false)

				local function var_23_9()
					self.Pop:setVisible(true)
				end

				LayerManager:pushInLayer("PopWeaponUpQuality", {
					entityid = arg_12_1.entityid,
					goto_back_system_id = arg_12_1.goto_back_system_id,
					exitcallback = function(arg_33_0)
						if arg_33_0 == 1 then
							if arg_12_1.cancelcallback then
								arg_12_1.cancelcallback()
							end

							self:removeSelf(self.rootpanel)

							if arg_12_1.updateEquipLayerCallback then
								arg_12_1.updateEquipLayerCallback()
							end
						elseif arg_33_0 == 0 then
							var_23_9()
						end
					end
				})
			end
		end)

		return var_21_0
	end

	local var_12_13 = ccui.ImageView:create("public/panelbg/strengen_arrow.png", var_0_0)

	var_12_13:setPosition(cc.p(435, 780))
	var_12_13:setName("arrow")
	self.rootpanel:addChild(var_12_13)

	self.newvalue = cc.Label:createWithTTF("", FONT_DES, 20)

	self.newvalue:setColor(cc.c3b(0, 216, 255))
	self.newvalue:setPosition(cc.p(465, var_12_13:getPositionY()))
	self.newvalue:setAnchorPoint(cc.p(0, 0.5))
	self.newvalue:setName("newvalue")
	self.rootpanel:addChild(self.newvalue)

	if arg_12_1.showType == "info" then
		var_12_5:setString("")

		self.strengthenBtn = var_12_11("small")
		self.upgradeBnt = var_12_12()
		self.replaceBnt = (function()
			local var_34_0 = ccui.Button:create("public/button/replace_btn.png", nil, "public/button/replace_btn.png", var_0_0)

			var_34_0:setPosition(248, 580)
			var_34_0:setVisible(false)
			self.rootpanel:addChild(var_34_0, 100)
			var_34_0:addTouchEventListener(function(arg_35_0, arg_35_1)
				if arg_35_1 ~= ccui.TouchEventType.ended then
					return
				end

				local function var_35_0(arg_36_0, arg_36_1, arg_36_2)
					local var_36_0
					local var_36_1
					local var_36_2
					local var_36_3

					if array_manager:isServantPatrolNow(playermodel.items[arg_36_0].weapon_attr.use) then
						var_36_2 = array_manager:getArrayByServantID(playermodel.items[arg_36_0].weapon_attr.use)

						if not fight_capacity_manager:isChangeEquipAfterCanPatrol(var_36_2, {
							servantid = playermodel.items[arg_36_0].weapon_attr.use,
							unuseWeapon = arg_36_0
						}) then
							var_36_0 = true
						end
					end

					if array_manager:isServantPatrolNow(arg_12_1.servantid) then
						var_36_3 = array_manager:getArrayByServantID(arg_12_1.servantid)

						if not fight_capacity_manager:isChangeEquipAftezzrCanPatrol(var_36_3, {
							servantid = arg_12_1.servantid,
							useWeapon = arg_36_0
						}) then
							var_36_1 = true
						end
					end

					if var_36_0 or var_36_1 then
						require("view.Sprite.ConfirmDialogSprite")
						global_basic_scene:addChild(ConfirmDialogSprite:create(L_SOULS_CONFIRM_DIALOG[1], L_SOULS_CONFIRM_DIALOG[2], {
							surecallback = function(arg_37_0, arg_37_1)
								if var_36_0 then
									patrol_manager:cancelPatrolByArrayid(var_36_2, function()
										if arg_36_2 then
											arg_36_2()
										end

										if arg_36_1 then
											arg_36_1()
										end
									end)
								end

								if var_36_1 then
									patrol_manager:cancelPatrolByArrayid(var_36_3, function()
										if arg_36_2 then
											arg_36_2()
										end

										if arg_36_1 then
											arg_36_1()
										end
									end)
								end
							end,
							cancelCallback = function(arg_40_0, arg_40_1)
								if arg_36_1 then
									arg_36_1()
								end
							end
						}, nil, nil, function()
							if arg_36_1 then
								arg_36_1()
							end
						end), 10000)
					elseif arg_36_2 then
						arg_36_2()
					end
				end

				self:addChild(ItemsPanel:create(kITEM_WEAPON, {
					isFilterLocked = true,
					soulid = arg_12_1.servantid
				}, {
					arg_12_1.entityid
				}, {
					unused = function(arg_42_0, arg_42_1)
						var_35_0(arg_42_0, arg_42_1, function()
							fight_capacity_manager:saveSoulAttr(arg_12_1.servantid)
							weapon_manager:replaceRoleWeapon(arg_12_1.servantid, arg_42_0, function(arg_44_0)
								audio_manager:playeffectMusic("sound/equip")

								if arg_44_0 == 1 then
									fight_capacity_manager:displaySoulAttrChangeValue()

									if arg_12_1.updateEquipLayerCallback then
										arg_12_1.updateEquipLayerCallback()
									end

									self:removeSelf(self.rootpanel)
								end

								if arg_42_1 then
									arg_42_1(arg_44_0)
								end
							end)
						end)
					end,
					used = function(arg_45_0)
						(function(arg_46_0, arg_46_1, arg_46_2)
							local var_46_0
							local var_46_1

							if array_manager:isServantPatrolNow(arg_46_0) then
								var_46_1 = array_manager:getArrayByServantID(arg_46_0)

								if not fight_capacity_manager:isChangeEquipAfterCanPatrol(var_46_1, {
									unuseWeapon = -1,
									servantid = arg_46_0
								}) then
									var_46_0 = true
								end
							end

							if var_46_0 then
								require("view.Sprite.ConfirmDialogSprite")
								global_basic_scene:addChild(ConfirmDialogSprite:create(L_SOULS_CONFIRM_DIALOG[1], L_SOULS_CONFIRM_DIALOG[2], {
									surecallback = function(arg_47_0, arg_47_1)
										if var_46_0 then
											patrol_manager:cancelPatrolByArrayid(var_46_1, function()
												if arg_46_2 then
													arg_46_2()
												end

												if btnSetBrightCallback then
													btnSetBrightCallback()
												end
											end)
										end
									end,
									cancelCallback = function(arg_49_0, arg_49_1)
										if arg_46_1 then
											arg_46_1()
										end
									end
								}, nil, nil, function()
									if arg_46_1 then
										arg_46_1()
									end
								end), 10000)
							elseif arg_46_2 then
								arg_46_2()
							end
						end)(arg_12_1.servantid, arg_45_0, function()
							fight_capacity_manager:saveSoulAttr(arg_12_1.servantid)
							weapon_manager:replaceRoleWeapon(arg_12_1.servantid, nil, function(arg_52_0)
								if arg_52_0 == 1 then
									audio_manager:playeffectMusic("sound/equip")
									fight_capacity_manager:displaySoulAttrChangeValue()

									if arg_12_1.updateEquipLayerCallback then
										arg_12_1.updateEquipLayerCallback()
									end

									self:removeSelf(self.rootpanel)
								end

								if arg_45_0 then
									arg_45_0(arg_52_0)
								end
							end)
						end)
					end,
					cancelcallback = function()
						if arg_12_1.topBottomCallback then
							arg_12_1.topBottomCallback()
						end
					end
				}, ITEMPANEL_TYPE_ROLE_WEAPON), 99)
			end)

			if weapon_manager:checkIsCanReplaceBetter(arg_12_1.servantid) and not array_manager:isServantPatrolNow(arg_12_1.servantid) then
				AlertManager:add_alert_by_config(var_34_0, true, {
					ALERT_SHOW_REDDOT,
					"",
					cc.p(var_34_0:getContentSize().width - 5, var_34_0:getContentSize().height - 10)
				})
			end

			return var_34_0
		end)()
	elseif arg_12_1.showType == "strengthen" then
		var_12_5:setString("")

		self.strengthenBtn = var_12_11("small")
	elseif arg_12_1.showType == "bag" then
		var_12_5:setString("")

		self.strengthenBtn = var_12_11("small")
		self.upgradeBnt = var_12_12()
	end

	function self.rootpanel.updateShow(arg_54_0)
		local var_54_0 = playermodel.items[arg_12_1.entityid]
		local var_54_1 = weapon_manager:getWeaponConfig(playermodel.items[arg_12_1.entityid])
		local var_54_2 = require("data.weapon_strengthen" .. item_data[arg_12_1.itemid].equip_quality .. "_data")
		local var_54_3, var_54_4 = weapon_manager:getNextLevelAttrValue(arg_12_1.entityid)

		var_54_4 = var_54_3 and var_54_4 or ""

		if var_54_0.weapon_attr.level >= weapon_manager:getWeaponMaxLevel(arg_12_1.entityid) then
			self.strengthenBtn:stopAllActions()
			self.strengthenBtn:loadTextures("public/button/public_button_blue_new_off.png.png", "public/button/public_button_blue_new_off.png.png", "public/button/public_button_blue_new_off.png.png", var_0_0)
			self.strengthenBtn:getChildByName("label"):setString(L_COMPONENT_TEXT.Button_Label[4])
			self.strengthenBtn:getChildByName("label"):setVisible(true)

			if self.labelStreng then
				self.labelStreng:removeFromParent()
			end

			if self.imageBtnFade then
				self.imageBtnFade:removeFromParent()
			end

			self.strengthenBtn:setOpacity(255)

			if self.strengthenBtn:getChildByName("cost_item") then
				self.strengthenBtn:getChildByName("cost_item"):setVisible(false)
				self.strengthenBtn:getChildByName("cost_item_num"):setVisible(false)
			end

			self.newvalue:setVisible(false)
			var_12_13:setVisible(false)
		else
			self.strengthenBtn:getChildByName("label"):setString(L_BUTTON_TEXT.Strengthen)

			local var_54_5 = 0

			self.strengthenBtn:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				if not item_data[arg_12_1.itemid]["lv" .. var_54_0.weapon_attr.level + 1 .. "_cost"] then
					-- block empty
				elseif playermodel.gold < item_data[arg_12_1.itemid]["lv" .. var_54_0.weapon_attr.level + 1 .. "_cost"] then
					if self.imageBtnFade then
						self.imageBtnFade:setVisible(false)
					end

					if var_54_5 == 0 then
						self.strengthenBtn:loadTextures("public/button/public_button_gray.png", nil, nil, var_0_0)

						var_54_5 = 1
					end
				else
					if self.imageBtnFade then
						self.imageBtnFade:setVisible(true)
					end

					if var_54_5 == 1 then
						self.strengthenBtn:loadTextures("public/button/public_button_normal_y.png", nil, nil, var_0_0)

						var_54_5 = 0
					end
				end
			end))))

			local var_54_6 = 1
			local var_54_7 = self.info_label[1]:getContentSize().height

			for iter_54_0, iter_54_1 in pairs(self.info_label) do
				if iter_54_1.key == var_54_3 then
					var_54_6 = iter_54_0
				end

				print(iter_54_1.key, var_54_7)
			end

			self.newvalue:setPositionY(780 - var_54_6 * var_54_7 - 2)
			var_12_13:setPositionY(780 - var_54_6 * var_54_7 - 2)
			self.newvalue:setVisible(true)
			self.newvalue:setString(var_54_4)
			var_12_13:setVisible(true)

			if self.strengthenBtn:getChildByName("cost_item") then
				self.strengthenBtn:getChildByName("cost_item"):setVisible(false)
			end

			if self.strengthenBtn:getChildByName("cost_item_num") then
				self.strengthenBtn:getChildByName("cost_item_num"):setVisible(false)
			end
		end
	end

	self.rootpanel:updateShow()
	self:fullScreen(var_12_3, self.rootpanel)
end

function PopBaseLayer.playStarUpEffect(arg_56_0, arg_56_1, arg_56_2)
	audio_manager:playeffectMusic("weapon_starup")

	local var_56_0 = ccui.Layout:create()

	var_56_0:setTouchEnabled(true)
	var_56_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_56_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_56_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_56_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_56_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_56_0:setBackGroundColorOpacity(220)
	global_basic_scene:addChild(var_56_0, 999)

	local var_56_1 = playermodel.items[arg_56_1].itemid

	local function var_56_2()
		local var_57_0 = item_data[var_56_1].max_star
		local var_57_1 = {}

		for iter_57_0 = 1, item_data[var_56_1].max_star do
			local var_57_3 = ccui.ImageView:create(iter_57_0 <= playermodel.items[arg_56_1].weapon_attr.nowStars and "public/currency/weapon_star.png" or "public/currency/weapon_star_empty.png", var_0_0)

			var_57_3:setPosition(cc.p(320 + (iter_57_0 - (var_57_0 + 1) / 2) * (var_57_3:getContentSize().width - 10), 545))
			table.insert(var_57_1, var_57_3)
			var_57_3:setVisible(false)
			var_56_0:addChild(var_57_3)
		end

		for iter_57_1, iter_57_2 in pairs(var_57_1) do
			var_57_1[iter_57_1]:setScale(8)
			var_57_1[iter_57_1]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_57_1 / 30), cc.CallFunc:create(function()
				var_57_1[iter_57_1]:setVisible(true)
			end), cc.Spawn:create(cc.RotateBy:create(0.55, 72), cc.Sequence:create(cc.ScaleTo:create(0.15, 1, 1), cc.ScaleTo:create(0.25, 2, 2), cc.ScaleTo:create(0.15, 1, 1)))))
		end
	end

	local var_56_3 = L2Skeleton:create("spine/ui/weapon_up_quality/weapon_up.json", "spine/ui/weapon_up_quality/weapon_up.atlas")

	var_56_3:refreshSkeleton()
	var_56_3:setSlotTexture("wuqi", "diergewuqi", "equipment/" .. item_data[playermodel.items[arg_56_1].itemid].image_id .. ".png")
	var_56_3:setSlotTexture("wuqi", "wuqishengjiewuqi", "equipment/" .. item_data[playermodel.items[arg_56_1].itemid].image_id .. ".png")
	var_56_3:setSlotTexture("wuqikuang", "wuqishengjiewuqikuang", ({
		"weaponIcon/weapon_bg_white.png",
		"weaponIcon/weapon_bg_green.png",
		"weaponIcon/weapon_bg_blue.png",
		"weaponIcon/weapon_bg_purple.png",
		"weaponIcon/weapon_bg_orange.png",
		"weaponIcon/weapon_bg_red.png"
	})[item_data[playermodel.items[arg_56_1].itemid].equip_quality])
	var_56_3.skeletonAnimation:setPosition(cc.p(320, 600))
	var_56_3:play("unique_up", false)
	var_56_0:addChild(var_56_3)
	var_56_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		var_56_2()
	end), cc.DelayTime:create(8), cc.RemoveSelf:create(), cc.CallFunc:create(function()
		fight_capacity_manager:showUpgrade(arg_56_2)

		if callback then
			callback()
		end
	end)))
	var_56_0:addTouchEventListener(function(arg_61_0, arg_61_1)
		if arg_61_1 ~= ccui.TouchEventType.ended then
			return
		end

		if callback then
			callback()
		end

		var_56_0:runAction(cc.Sequence:create(cc.RemoveSelf:create(), cc.CallFunc:create(function()
			fight_capacity_manager:showUpgrade(arg_56_2)
		end)))
	end)
end

function PopWeaponInfos:exit()
	if var_0_17.cancelcallback then
		var_0_17.cancelcallback()
	end

	self:removeSelf(self.rootpanel)

	if var_0_17.backUpdateCallback then
		var_0_17.backUpdateCallback()
	end
end
