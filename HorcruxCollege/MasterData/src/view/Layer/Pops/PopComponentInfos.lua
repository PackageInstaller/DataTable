local var_0_0 = config._DEBUG and 0 or 1

require("data.constants")
require("data.language_constants")
require("view.Sprite.ItemSprite")

local component_manager = require("controller.component_manager")
local component_effect_data = require("data.component_effect_data")
local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")
local var_0_6 = require("data.item_data")
local playermodel = require("model.playermodel")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local core_manager = require("controller.core_manager")
local array_manager = require("controller.array_manager")
local component_strengthen_weight_data = require("data.component_strengthen_weight_data")
local audio_manager = require("controller.audio_manager")

PopComponentInfos = class("PopComponentInfos", function()
	return PopBaseLayer:create()
end)

function PopComponentInfos.create(arg_2_0, arg_2_1)
	local var_2_0 = PopComponentInfos.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopComponentInfos:init(arg_3_1)
	self.Pop = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Popup_normal.json" or "Popup_normal.ExportJson")
	arg_3_1.panel = self.Pop
	self.entityid = arg_3_1.entityid

	self:addChild(self.Pop)
	self.Pop:runAction(cc.CallFunc:create(function()
		return
	end))

	self.removeFlag = true
	self.rootpanel = ccui.Helper:seekWidgetByName(self.Pop, "panel_back")

	local var_3_0 = ccui.Helper:seekWidgetByName(self.Pop, "panel_all")
	local var_3_1 = ccui.Helper:seekWidgetByName(self.Pop, "title")
	local var_3_2 = ccui.Helper:seekWidgetByName(self.Pop, "button_sure")
	local var_3_3 = var_3_2:getChildByName("label")

	ccui.Helper:seekWidgetByName(self.Pop, "image_system_figure"):setVisible(false)
	self.Pop:setAnchorPoint(cc.p(0.5, 0.5))
	self:ActionofAccess(self.rootpanel)
	self.Pop:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, self.rootpanel:getContentSize().height / 2))
	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, self.rootpanel:getContentSize().height / 2))

	local var_3_4 = COMPONENT_MAIN_ATTR[item_data[playermodel.items[arg_3_1.entityid].itemid].main_attr]

	if playermodel.items[arg_3_1.entityid].component_attr.attr2 then
		var_3_4 = COMPONENT_MAIN_ATTR[playermodel.items[arg_3_1.entityid].component_attr.attr1]
	end

	local var_3_5 = FIGHT_ATTR_FORMAT(var_3_4, FIGHT_ATTR_TRANS_FAC[var_3_4] * 6) .. "~" .. FIGHT_ATTR_FORMAT(var_3_4, FIGHT_ATTR_TRANS_FAC[var_3_4] * MAX_COMPONENT_SUB_ATTR)

	local function var_3_6(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_3_1.cancelcallback then
			arg_3_1.cancelcallback()
		end

		self:removeSelf(self.rootpanel)
	end

	ccui.Helper:seekWidgetByName(self.Pop, "button_close"):addTouchEventListener(var_3_6)
	var_3_0:addTouchEventListener(var_3_6)
	ccui.Helper:seekWidgetByName(self.Pop, "bg"):setTouchEnabled(true)

	if arg_3_1.labels and arg_3_1.labels.title then
		var_3_1:setString(arg_3_1.labels.title)
	else
		var_3_1:setString("")
	end

	if arg_3_1.labels and arg_3_1.labels.button then
		var_3_3:setString(arg_3_1.labels.button)
	end

	var_3_2:setVisible(false)

	if arg_3_1.cost then
		local var_3_7

		if config._DEBUG then
			var_3_7 = cc.Sprite:create(arg_3_1.cost.costtype) or cc.Sprite:createWithSpriteFrameName(arg_3_1.cost.costtype)
		end

		var_3_7:setAnchorPoint(0.5, 0)
		var_3_7:setPosition(cc.p(SCREEN_WIDTH / 2 - 25, 450 + 37))
		var_3_7:setName("cost_icon")
		var_3_7:setVisible(false)

		if arg_3_1.cost.costtype == IMAGE_CLOTHESTICKET then
			var_3_7:setScale(0.3125)
		else
			var_3_7:setScale(0.6)
		end

		self.Pop:addChild(var_3_7, 10)

		local var_3_8 = cc.Label:createWithTTF(arg_3_1.cost.costnum, FONT_DES, 25)

		var_3_8:setAnchorPoint(0.5, 0)
		var_3_8:setPosition(cc.p(55, 0))
		var_3_7:addChild(var_3_8, 1)
		var_3_8:setVisible(false)
	end

	if component_manager:getMaxLevel(arg_3_1.itemid) == component_manager:getExtraPoint(arg_3_1.entityid) then
		if self.rootpanel:getChildByName("gold_num") then
			self.rootpanel:getChildByName("gold_num"):setVisible(false)
		end

		if self.rootpanel:getChildByName("gold_img") then
			self.rootpanel:getChildByName("gold_img"):setVisible(false)
		end
	end

	local var_3_9 = {}

	if arg_3_1.button then
		local var_3_11 = #arg_3_1.button

		for iter_3_0, iter_3_1 in pairs(arg_3_1.button) do
			if iter_3_1.label == L_COMPONENT_TEXT.Button_Label[5] or iter_3_1.label == L_COMPONENT_TEXT.Button_Label[6] then
				var_3_11 = var_3_11 + 1
			end
		end

		for iter_3_2, iter_3_3 in pairs(arg_3_1.button) do
			if iter_3_3.label ~= L_COMPONENT_TEXT.Button_Label[5] and iter_3_3.label ~= L_COMPONENT_TEXT.Button_Label[6] then
				x = SCREEN_WIDTH / 2 - 5 + 280 * (iter_3_2 - 1 - (var_3_11 - 1) / 2)
				var_3_9[iter_3_2] = ccui.Button:create("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_0)

				var_3_9[iter_3_2]:setAnchorPoint(cc.p(0.5, 0.5))
				var_3_9[iter_3_2]:setPosition(cc.p(430, 340))

				local var_3_12 = cc.Label:createWithTTF(iter_3_3.label, FONT_BUTTON, 30)

				var_3_12:setColor(cc.c3b(41, 49, 58))
				var_3_12:setName("openLabel")
				var_3_12:setPosition(cc.p(var_3_9[iter_3_2]:getContentSize().width / 2, var_3_9[iter_3_2]:getContentSize().height / 2))
				var_3_9[iter_3_2]:setScale(0.95)
				var_3_9[iter_3_2]:addChild(var_3_12)

				if iter_3_3.label == L_COMPONENT_TEXT.Button_Label[4] then
					var_3_9[iter_3_2]:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", var_0_0)
					var_3_9[iter_3_2]:getChildByName("openLabel"):setPosition(cc.p(var_3_9[iter_3_2]:getContentSize().width / 2, var_3_9[iter_3_2]:getContentSize().height / 2))
					var_3_9[iter_3_2]:setPressedActionEnabled(true)
				end

				if iter_3_3.label == L_COMPONENT_TEXT.Button_Label[9] then
					var_3_9[iter_3_2]:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", var_0_0)
				end

				if iter_3_2 == 3 and component_manager:is_reinforce_component(self.entityid) then
					local var_3_13 = ccui.ImageView:create("public/panelbg/reinforcedes_bg.png", var_0_0)

					var_3_13:setPositionX(var_3_9[iter_3_2]:getContentSize().width / 2)
					var_3_13:setPositionY(90)
					var_3_9[iter_3_2]:addChild(var_3_13)

					local var_3_14 = cc.Label:createWithTTF("该芯片已经聚合，替换后将失去聚合效果", FONT_BUTTON, 18)

					var_3_14:setPositionX(var_3_13:getContentSize().width / 2 + 23)
					var_3_14:setPositionY(var_3_13:getContentSize().height / 2 + 4)
					var_3_13:addChild(var_3_14)
				end

				if iter_3_3.label == L_COMPONENT_TEXT.Button_Label[4] or iter_3_3.label == L_COMPONENT_TEXT.Button_Label[3] then
					self.specialTag = true
				end

				if iter_3_3.label == L_COMPONENT_TEXT.Button_Label[3] then
					var_3_9[iter_3_2]:setName("strengthenBtn")

					if component_manager:isTipsStrengComponent(arg_3_1.entityid, arg_3_1.servantid) then
						self.labelStreng = cc.Label:createWithTTF(L_COMPONENT_TEXT.Button_Label[3], FONT_BUTTON, 30)

						self.labelStreng:setPosition(440, 300)
						self.labelStreng:setColor(cc.c3b(41, 49, 58))
						var_3_12:setVisible(false)
						self.rootpanel:addChild(self.labelStreng, 9999)

						self.imageBtnFade = ccui.ImageView:create("public/button/public_button_orange.png", var_0_0)

						self.rootpanel:addChild(self.imageBtnFade, 999)
						self.imageBtnFade:setPosition(cc.p(440, 300))
						self.imageBtnFade:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.8, 0), cc.FadeTo:create(0.8, 255), cc.DelayTime:create(0.4))))
					end
				end
			else
				if iter_3_3.label == L_COMPONENT_TEXT.Button_Label[5] then
					var_3_9[iter_3_2] = ccui.Button:create("public/button/pop_lock.png", nil, "public/button/pop_lock.png", var_0_0)
				elseif iter_3_3.label == L_COMPONENT_TEXT.Button_Label[6] then
					var_3_9[iter_3_2] = ccui.Button:create("public/button/pop_unlock.png", nil, "public/button/pop_unlock.png", var_0_0)
				end

				var_3_9[iter_3_2]:setAnchorPoint(cc.p(0.5, 0.5))
				var_3_9[iter_3_2]:setPosition(530, 785)
				var_3_9[iter_3_2]:setName("lockbtn")
			end

			if iter_3_3.label == L_COMPONENT_TEXT.Button_Label[7] then
				var_3_9[iter_3_2]:loadTextures("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_0_0)
				var_3_9[iter_3_2]:setPosition(cc.p(190, 340))
				var_3_9[iter_3_2]:getChildByName("openLabel"):setString(L_COMPONENT_TEXT.Button_Label[7])
				var_3_9[iter_3_2]:setScale(0.95)

				if component_manager:checkIsCanReplaceBetter(arg_3_1.servantid, item_data[arg_3_1.itemid].pos) then
					AlertManager:add_alert_by_config(var_3_9[iter_3_2], true, {
						ALERT_SHOW_REDDOT,
						"",
						cc.p(var_3_9[iter_3_2]:getContentSize().width - 10, var_3_9[iter_3_2]:getContentSize().height - 10)
					})
				end
			elseif iter_3_3.label == L_BUTTON_TEXT.Item_Panel_Btn.Unload then
				var_3_9[iter_3_2]:loadTextures("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_0_0)
				var_3_9[iter_3_2]:setPosition(cc.p(480, 340))
				var_3_9[iter_3_2]:setVisible(false)
			end

			var_3_9[iter_3_2].count = iter_3_3.count

			self.rootpanel:addChild(var_3_9[iter_3_2], 10)
			var_3_9[iter_3_2]:addTouchEventListener(function(arg_6_0, arg_6_1)
				if arg_6_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_6_0:isBright() then
					return
				end

				if iter_3_3.label == L_COMPONENT_TEXT.Button_Label[9] then
					global_ShowBlockWords("该芯片已校准!")

					return
				end

				if iter_3_3.label == L_COMPONENT_TEXT.Button_Label[8] then
					LayerManager:removePopLayer()
					LayerManager:pushInLayer("PopComponentStrengthenLayer", {
						type = "adjust",
						entityid = self.entityid,
						callback = callback
					})

					return
				end

				local function var_6_0(...)
					local var_7_0, var_7_1, var_7_2, var_7_3 = component_manager:getStrengthenInfo(arg_3_1.entityid, true)
					local var_7_4 = component_manager:getUpGradeData(arg_3_1.entityid)
					local var_7_6 = {
						L_COMPONENT_TEXT.prefix_str[1] .. "\n" .. var_7_0[1].name .. " + " .. FIGHT_ATTR_FORMAT(var_7_0[1].key, var_7_0[1].value)
					}

					if var_7_4 then
						local var_7_7 = FIGHT_ATTR_FORMAT(var_7_4.labels[2].key, var_7_4.labels[2].newvalue) .. "~" .. FIGHT_ATTR_FORMAT(var_7_4.labels[2].key, var_7_4.labels[2].max_value)

						self.rootpanel:getChildByName("newvalue"):setString((var_7_4.labels[2].newvalue == var_7_4.labels[2].max_value or nil) and FIGHT_ATTR_FORMAT(var_7_4.labels[2].key, var_7_4.labels[2].newvalue))
					else
						self.rootpanel:getChildByName("newvalue"):setVisible(false)
						self.rootpanel:getChildByName("arrow"):setVisible(false)
					end

					if playermodel.items[arg_3_1.entityid].component_attr.attr2 then
						var_7_6[2] = var_7_3[1].name .. " + " .. FIGHT_ATTR_FORMAT(var_7_3[1].key, var_7_3[1].value)

						for iter_7_0, iter_7_1 in pairs(var_7_0[3]) do
							var_7_6[iter_7_0 + 2] = iter_7_0 == 1 and L_COMPONENT_TEXT.prefix_str[2] .. "\n" .. FIGHT_ATTR_INFO[iter_7_1.key] .. " + " .. FIGHT_ATTR_FORMAT(iter_7_1.key, iter_7_1.value) or FIGHT_ATTR_INFO[iter_7_1.key] .. " + " .. FIGHT_ATTR_FORMAT(iter_7_1.key, iter_7_1.value)
						end

						if var_7_4 then
							self.rootpanel:getChildByName("newvalue2"):setString(FIGHT_ATTR_FORMAT(var_7_4.labels2[2].key, var_7_4.labels2[2].newvalue) .. "~" .. FIGHT_ATTR_FORMAT(var_7_4.labels2[2].key, var_7_4.labels2[2].max_value))
						else
							self.rootpanel:getChildByName("newvalue2"):setVisible(false)
							self.rootpanel:getChildByName("arrow2"):setVisible(false)
						end
					else
						for iter_7_2, iter_7_3 in pairs(var_7_0[3]) do
							var_7_6[iter_7_2 + 1] = iter_7_2 == 1 and L_COMPONENT_TEXT.prefix_str[2] .. "\n" .. FIGHT_ATTR_INFO[iter_7_3.key] .. " + " .. FIGHT_ATTR_FORMAT(iter_7_3.key, iter_7_3.value) or FIGHT_ATTR_INFO[iter_7_3.key] .. " + " .. FIGHT_ATTR_FORMAT(iter_7_3.key, iter_7_3.value)
						end
					end

					local var_7_8 = component_manager:getStrengthenInfo(arg_3_1.entityid, true, self.servantid)
					local var_7_9 = {}
					local var_7_10 = {}

					if var_7_0[1].value ~= var_7_8[1].value then
						local var_7_11 = 2

						for iter_7_4, iter_7_5 in pairs(var_7_8[3]) do
							var_7_9[#var_7_9 + 1] = {}
							var_7_9[#var_7_9].key = FIGHT_ATTR_INFO[iter_7_5.key]
							var_7_9[#var_7_9].value = " + " .. FIGHT_ATTR_FORMAT(iter_7_5.key, iter_7_5.value)
							var_7_11 = var_7_11 + 1
						end

						var_7_10[1] = L_COMPONENT_TEXT.prefix_str[5] .. "\n" .. var_7_8[1].name .. " + " .. FIGHT_ATTR_FORMAT(var_7_8[1].key, var_7_8[1].value)

						for iter_7_6, iter_7_7 in pairs(var_7_9) do
							var_7_10[iter_7_6 + 1] = iter_7_6 == 1 and L_COMPONENT_TEXT.prefix_str[6] .. "\n" .. iter_7_7.key .. iter_7_7.value or iter_7_7.key .. iter_7_7.value
						end
					end

					if var_7_6 and self.info_label then
						for iter_7_8 = 1, #self.info_label do
							if var_7_6[iter_7_8] and var_7_6[iter_7_8] ~= nil then
								self.info_label[iter_7_8]:setString(var_7_6[iter_7_8])
							end
						end
					end

					if var_7_10 and next(var_7_10) and self.limit_info_label then
						for iter_7_9 = 1, #self.limit_info_label do
							if var_7_10[iter_7_9] then
								self.limit_info_label[iter_7_9]:setVisible(true)
								self.limit_info_label[iter_7_9]:setString(var_7_10[iter_7_9])
								self.line:setVisible(true)
							end
						end
					elseif self.limit_info_label then
						for iter_7_10 = 1, #self.limit_info_label do
							if var_7_10 and var_7_10[iter_7_10] then
								self.limit_info_label[iter_7_10]:setVisible(false)
								self.line:setVisible(false)
							end
						end
					end

					if self.Strength_Icon then
						self.Strength_Icon:updateBigInfo(false, arg_3_1.entityid)
					end

					if arg_3_1.exitCallback then
						arg_3_1.exitCallback()
					end

					self:updateStrengthenInfo()

					local var_7_12 = component_manager:getStrengthenStatus(arg_3_1.entityid)

					if component_manager:canAdjustComponent(arg_3_1.entityid) then
						var_3_9[iter_3_2]:getChildByName("openLabel"):setString(L_COMPONENT_TEXT.Button_Label[8])
					end
				end

				if iter_3_2 == 2 then
					local var_6_1 = component_manager:canAdjustComponent(arg_3_1.entityid)

					if not component_manager:getStrengthenStatus(arg_3_1.entityid) and var_6_1 then
						LayerManager:removePopLayer()
						LayerManager:pushInLayer("PopComponentStrengthenLayer", {
							type = "adjust",
							entityid = self.entityid,
							callback = callback
						})

						return
					end

					if not component_manager:getComponetLevelUpNeedExp(arg_3_1.entityid) then
						arg_6_0:setBright(false)
						component_manager:strengthenComponent(arg_3_1.entityid, nil, function(arg_8_0)
							if arg_8_0 == 1 then
								var_6_0()
							elseif arg_8_0 == 2 then
								global_ShowBlockWords("芯片已经强化至满级!")
								audio_manager:playeffectMusicTest("sound/invalid")
							elseif arg_8_0 == 4 then
								global_ShowBlockWords(L_GOLD_LACK)
								LayerManager:pushInLayer("PopGoGainLayer", {
									item = "gold",
									goto_back_system_id = self.goto_back_system_id
								})
							end

							arg_6_0:setBright(true)

							if component_manager:getMaxLevel(arg_3_1.itemid) == component_manager:getExtraPoint(arg_3_1.entityid) then
								if self.rootpanel:getChildByName("gold_num") then
									self.rootpanel:getChildByName("gold_num"):setVisible(false)
								end

								if self.rootpanel:getChildByName("gold_img") then
									self.rootpanel:getChildByName("gold_img"):setVisible(false)
								end

								var_3_9[iter_3_2]:getChildByName("openLabel"):setString((not var_6_1 or nil) and (L_COMPONENT_TEXT.Button_Label[4] or L_COMPONENT_TEXT.Button_Label[8]))

								if component_manager:canAdjustComponent(arg_3_1.entityid) then
									var_3_9[iter_3_2]:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_0)
								else
									var_3_9[iter_3_2]:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", var_0_0)
								end
							elseif self.rootpanel:getChildByName("gold_num") then
								self.rootpanel:getChildByName("gold_num"):setString(component_manager:getUpGradeData(arg_3_1.entityid).gold_cost)
							end
						end)
					else
						arg_6_0:setBright(true)
						LayerManager:pushInLayer("PopComponentStrengthenLayer", {
							entityid = arg_3_1.entityid,
							callback = var_6_0
						})
					end
				else
					if iter_3_3.surecallback then
						iter_3_3.surecallback(arg_6_0, arg_6_1, function(arg_9_0, arg_9_1, arg_9_2)
							if not self.removeFlag then
								return
							end

							if arg_9_0 and arg_9_0 == 0 then
								var_3_9[iter_3_2]:loadTextures("public/button/pop_lock.png", nil, "public/button/pop_lock.png", var_0_0)
								self.Strength_Icon:getChildByName("lock"):setVisible(false)
							elseif arg_9_0 and arg_9_0 == 1 then
								var_3_9[iter_3_2]:loadTextures("public/button/pop_unlock.png", nil, "public/button/pop_unlock.png", var_0_0)
							end

							if self.Strength_Icon then
								self.Strength_Icon:updateBigInfo(false, arg_3_1.entityid)

								if self.Strength_Icon:getChildByName("lock") then
									self.Strength_Icon:getChildByName("lock"):setVisible(false)
								end

								if (not arg_9_0 or arg_9_0 == nil) and not component_manager:getStrengthenStatus(arg_3_1.entityid) then
									var_3_9[iter_3_2]:getChildByName("openLabel"):setString(L_COMPONENT_TEXT.Button_Label[4])
									var_3_9[iter_3_2]:stopAllActions()
									var_3_9[iter_3_2]:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", var_0_0)
								end
							end

							if arg_9_1 and self.info_label then
								for iter_9_0 = 1, #self.info_label do
									if arg_9_1[iter_9_0] and arg_9_1[iter_9_0] ~= nil then
										self.info_label[iter_9_0]:setString(arg_9_1[iter_9_0])
									end
								end
							end

							if arg_9_2 and next(arg_9_2) and self.limit_info_label then
								for iter_9_1 = 1, #self.limit_info_label do
									if arg_9_2[iter_9_1] then
										self.limit_info_label[iter_9_1]:setVisible(true)
										self.limit_info_label[iter_9_1]:setString(arg_9_2[iter_9_1])
										self.line:setVisible(true)
									end
								end
							elseif self.limit_info_label then
								for iter_9_2 = 1, #self.limit_info_label do
									if arg_9_2 and arg_9_2[iter_9_2] then
										self.limit_info_label[iter_9_2]:setVisible(false)
										self.line:setVisible(false)
									end
								end
							end

							if self.Pop and self.Pop:getChildByName("attrLayout") then
								self.Pop:getChildByName("attrLayout"):runAction(cc.RemoveSelf:create())
							end

							if iter_3_3.label == L_COMPONENT_TEXT.Button_Label[3] then
								local var_9_0 = component_manager:getUpGradeData(arg_3_1.entityid)

								if component_manager:getStrengthenStatus(arg_3_1.entityid) then
									if self.rootpanel:getChildByName("newvalue") then
										self.rootpanel:getChildByName("newvalue"):setString(FIGHT_ATTR_FORMAT(var_9_0.labels[2].key, var_9_0.labels[2].newvalue) .. "~" .. FIGHT_ATTR_FORMAT(var_9_0.labels[2].key, var_9_0.labels[2].max_value))
									end

									if not var_9_0.labels[3] or next(var_9_0.labels[3]) == nil then
										local var_9_1 = 1

										while self.rootpanel:getChildByName("subLabel" .. var_9_1) do
											self.rootpanel:getChildByName("subLabel" .. var_9_1):setVisible(false)

											var_9_1 = var_9_1 + 1
										end
									else
										for iter_9_3 = 1, #var_9_0.labels[3] do
											if self.rootpanel:getChildByName("subLabel" .. iter_9_3) then
												self.rootpanel:getChildByName("subLabel" .. iter_9_3):setString(var_9_0.labels[3][iter_9_3].newvalue)
												self.rootpanel:getChildByName("subLabel" .. iter_9_3):setVisible(true)
											else
												-- block empty
											end
										end
									end

									if self.rootpanel:getChildByName("gold_num") then
										self.rootpanel:getChildByName("gold_num"):setString(var_9_0.gold_cost)
									end
								else
									var_3_9[iter_3_2]:stopAllActions()
									var_3_9[iter_3_2]:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", var_0_0)
									var_3_9[iter_3_2]:getChildByName("openLabel"):setString(L_COMPONENT_TEXT.Button_Label[4])
									var_3_9[iter_3_2]:getChildByName("openLabel"):setVisible(true)
									var_3_9[iter_3_2]:setOpacity(255)

									if self.labelStreng then
										self.labelStreng:removeFromParent()
									end

									if self.imageBtnFade then
										self.imageBtnFade:removeFromParent()
									end

									if self.rootpanel:getChildByName("newvalue") then
										self.rootpanel:getChildByName("newvalue"):setVisible(false)
									end

									if self.rootpanel:getChildByName("gold_num") then
										self.rootpanel:getChildByName("gold_num"):setVisible(false)
									end

									if self.rootpanel:getChildByName("gold_img") then
										self.rootpanel:getChildByName("gold_img"):setVisible(false)
									end

									if self.rootpanel:getChildByName("arrow") then
										self.rootpanel:getChildByName("arrow"):setVisible(false)
									end

									if self.rootpanel:getChildByName("arrow2") then
										self.rootpanel:getChildByName("arrow2"):setVisible(false)
									end

									local var_9_4 = 1

									while self.rootpanel:getChildByName("subLabel" .. var_9_4) do
										self.rootpanel:getChildByName("subLabel" .. var_9_4):setVisible(false)

										var_9_4 = var_9_4 + 1
									end
								end
							end
						end)
					end

					if iter_3_3.label ~= L_COMPONENT_TEXT.Button_Label[3] and iter_3_3.label ~= L_COMPONENT_TEXT.Button_Label[4] and iter_3_3.label ~= L_COMPONENT_TEXT.Button_Label[5] and iter_3_3.label ~= L_COMPONENT_TEXT.Button_Label[6] then
						if arg_3_1.cancelcallback then
							arg_3_1.cancelcallback()
						end

						self.removeFlag = false

						self:removeSelf(self.rootpanel)
					end
				end
			end)
		end

		if #var_3_9 == 2 and self.rootpanel:getChildByName("lockbtn") or #var_3_9 == 1 then
			var_3_9[#var_3_9]:loadTextures("public/button/public_button_orange.png", "public/button/public_button_orange.png", "public/button/public_button_orange.png", var_0_0)

			if arg_3_1.button[#var_3_9].label == L_COMPONENT_TEXT.Button_Label[4] then
				var_3_9[#var_3_9]:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", var_0_0)
			end

			var_3_9[#var_3_9]:getChildByName("openLabel"):setPosition(cc.p(var_3_9[#var_3_9]:getContentSize().width / 2, var_3_9[#var_3_9]:getContentSize().height / 2 - 5))
			var_3_9[#var_3_9]:setPressedActionEnabled(true)

			if arg_3_1.cost then
				self.Pop:getChildByName("cost_icon"):setPosition(cc.p(320, 450))
			end
		end
	end

	if arg_3_1.nextgrade and component_manager:getStrengthenStatus(arg_3_1.entityid) then
		if self.specialTag == true then
			local var_3_15 = ccui.ImageView:create("public/panelbg/strengen_arrow.png", var_0_0)

			var_3_15:setPosition(cc.p(290, 713))
			var_3_15:setName("arrow")
			self.rootpanel:addChild(var_3_15)

			local var_3_16 = FIGHT_ATTR_FORMAT(arg_3_1.nextgrade.labels[2].key, arg_3_1.nextgrade.labels[2].newvalue) .. "~" .. FIGHT_ATTR_FORMAT(arg_3_1.nextgrade.labels[2].key, arg_3_1.nextgrade.labels[2].max_value)
			local var_3_17 = cc.Label:createWithTTF((arg_3_1.nextgrade.labels[2].newvalue == arg_3_1.nextgrade.labels[2].max_value or nil) and FIGHT_ATTR_FORMAT(arg_3_1.nextgrade.labels[2].key, arg_3_1.nextgrade.labels[2].newvalue), FONT_DES, 20)

			var_3_17:setColor(cc.c3b(0, 216, 255))
			var_3_17:setPosition(cc.p(var_3_15:getPositionX() + var_3_15:getContentSize().width / 2, var_3_15:getPositionY()))
			var_3_17:setAnchorPoint(cc.p(0, 0.5))
			var_3_17:setName("newvalue")
			self.rootpanel:addChild(var_3_17)

			if playermodel.items[arg_3_1.entityid].component_attr.attr2 then
				local var_3_18 = ccui.ImageView:create("public/panelbg/strengen_arrow.png", var_0_0)

				var_3_18:setPosition(cc.p(290, 673))
				var_3_18:setName("arrow2")
				self.rootpanel:addChild(var_3_18)

				local var_3_19 = cc.Label:createWithTTF(FIGHT_ATTR_FORMAT(arg_3_1.nextgrade.labels2[2].key, arg_3_1.nextgrade.labels2[2].newvalue) .. "~" .. FIGHT_ATTR_FORMAT(arg_3_1.nextgrade.labels2[2].key, arg_3_1.nextgrade.labels2[2].max_value), FONT_DES, 20)

				var_3_19:setColor(cc.c3b(0, 216, 255))
				var_3_19:setPosition(cc.p(var_3_18:getPositionX() + var_3_18:getContentSize().width / 2, var_3_18:getPositionY()))
				var_3_19:setAnchorPoint(cc.p(0, 0.5))
				var_3_19:setName("newvalue2")
				self.rootpanel:addChild(var_3_19)
			end

			if arg_3_1.nextgrade.labels[3] and next(arg_3_1.nextgrade.labels[3]) ~= nil then
				-- block empty
			end

			if arg_3_1.nextgrade.gold_cost then
				local var_3_22 = ccui.ImageView:create(IMAGE_GOLD, var_0_0)

				var_3_22:setPosition(cc.p(395, 290))
				var_3_22:setName("gold_img")
				self.rootpanel:addChild(var_3_22)

				local var_3_23 = cc.Label:createWithTTF(arg_3_1.nextgrade.gold_cost, FONT_DES, 20)

				var_3_23:setAnchorPoint(cc.p(0, 0.5))
				var_3_23:setPosition(cc.p(var_3_22:getPositionX() + var_3_22:getContentSize().width / 2 + 4, 290))
				var_3_23:setName("gold_num")
				self.rootpanel:addChild(var_3_23)

				if #var_3_9 == 2 and self.rootpanel:getChildByName("lockbtn") or #var_3_9 == 1 then
					var_3_22:setPosition(cc.p(290, 250))
					var_3_23:setPosition(cc.p(320, 250))
				end

				local var_3_24 = 0

				ccui.Helper:seekWidgetByName(self.rootpanel, "strengthenBtn"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
					if playermodel.gold < tonumber(arg_3_1.nextgrade.gold_cost) then
						if self.imageBtnFade then
							self.imageBtnFade:setVisible(false)
						end

						if var_3_24 == 0 then
							ccui.Helper:seekWidgetByName(self.rootpanel, "strengthenBtn"):loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", var_0_0)

							var_3_24 = 1
						end
					else
						if self.imageBtnFade then
							self.imageBtnFade:setVisible(true)
						end

						if var_3_24 == 1 then
							ccui.Helper:seekWidgetByName(self.rootpanel, "strengthenBtn"):loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_0)

							var_3_24 = 0
						end
					end
				end))))
			end
		else
			self:Upgrade_Everything_COST(arg_3_1.nextgrade)
		end
	end

	if arg_3_1.itemid then
		local var_3_25 = self:Layer_Item_Info(arg_3_1)

		var_3_25:setPosition(cc.p(20, 275))
		self.rootpanel:addChild(var_3_25, 1)
	end

	self:fullScreen(var_3_0, self.rootpanel)
	ccui.Helper:seekWidgetByName(self.Pop, "image_bg"):setScale9Enabled(true)

	if component_manager:getComponetLevelUpNeedExp(arg_3_1.entityid) then
		if self.rootpanel:getChildByName("gold_num") then
			self.rootpanel:getChildByName("gold_num"):setVisible(false)
		end

		if self.rootpanel:getChildByName("gold_img") then
			self.rootpanel:getChildByName("gold_img"):setVisible(false)
		end
	end

	self:updateStrengthenInfo()
end

function PopComponentInfos:updateStrengthenInfo(...)
	if not self.entityid then
		return
	end

	local var_11_0 = {
		{
			id = 6,
			path = "public/panelbg/red.png"
		},
		{
			id = 5,
			path = "public/panelbg/orange.png"
		},
		{
			id = 4,
			path = "public/panelbg/purple.png"
		},
		{
			id = 3,
			path = "public/panelbg/blue.png"
		},
		{
			id = 2,
			path = "public/panelbg/green.png"
		},
		{
			id = 1,
			path = "public/panelbg/white.png"
		}
	}

	if not self.componentStrengthenInfoPanel then
		self.componentStrengthenInfoPanel = ccui.Layout:create()

		self.componentStrengthenInfoPanel:setTouchEnabled(false)
		self.componentStrengthenInfoPanel:setContentSize(cc.size(500, 20))
		self.componentStrengthenInfoPanel:setAnchorPoint(cc.p(0, 0))
		self.componentStrengthenInfoPanel:setPosition(cc.p(40, 588))
		self.componentStrengthenInfoPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		self.rootpanel:addChild(self.componentStrengthenInfoPanel, 100)

		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			local var_11_1 = ccui.ImageView:create(iter_11_1.path, var_0_0)

			var_11_1:setAnchorPoint(cc.p(0, 0.5))
			var_11_1:setName("componentinfo_sp_" .. iter_11_0)
			self.componentStrengthenInfoPanel:addChild(var_11_1)

			local var_11_2 = cc.Label:createWithTTF("", FONT_DES, 22)

			var_11_2:setAnchorPoint(cc.p(0, 0.5))
			var_11_2:setName("componentinfo_label_" .. iter_11_0)
			self.componentStrengthenInfoPanel:addChild(var_11_2)
		end
	end

	local var_11_3 = item_data[playermodel.items[self.entityid].itemid].equip_quality
	local var_11_4 = 1

	while component_strengthen_weight_data[var_11_3]["add_weight" .. 1] do
		if component_strengthen_weight_data[var_11_3]["add_weight" .. 1] > 0 then
			var_11_4 = 1
		end
	end

	local var_11_6 = 1
	local var_11_7 = {
		217,
		279,
		348,
		417,
		486,
		555
	}
	local var_11_8 = component_manager:getComponentStrengthenInfo(self.entityid)

	for iter_11_2, iter_11_3 in pairs(var_11_0) do
		self.componentStrengthenInfoPanel:getChildByName("componentinfo_label_" .. iter_11_2):setString(var_11_8[iter_11_3.id])
		self.componentStrengthenInfoPanel:getChildByName("componentinfo_label_" .. iter_11_2):setVisible(false)
		self.componentStrengthenInfoPanel:getChildByName("componentinfo_sp_" .. iter_11_2):setVisible(false)

		if var_11_4 >= iter_11_3.id and component_strengthen_weight_data[var_11_3]["add_weight" .. iter_11_3.id] > 0 then
			self.componentStrengthenInfoPanel:getChildByName("componentinfo_label_" .. iter_11_2):setPositionX(var_11_7[var_11_6] + 40)
			self.componentStrengthenInfoPanel:getChildByName("componentinfo_sp_" .. iter_11_2):setPositionX(var_11_7[var_11_6])
			self.componentStrengthenInfoPanel:getChildByName("componentinfo_label_" .. iter_11_2):setVisible(true)
			self.componentStrengthenInfoPanel:getChildByName("componentinfo_sp_" .. iter_11_2):setVisible(true)

			var_11_6 = var_11_6 + 1
		end
	end
end

function PopComponentInfos.fullScreen(arg_12_0, arg_12_1, arg_12_2)
	arg_12_1:setContentSize(GameDisplay.getScreenSize())
	arg_12_2:setPositionY(arg_12_2:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
end
