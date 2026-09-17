local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local component_manager = require("controller.component_manager")
local component_effect_data = require("data.component_effect_data")
local item_data = require("data.item_data")
local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local var_0_6 = require("data.item_data")
local var_0_7 = require("data.item_data")
local playermodel = require("model.playermodel")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local core_manager = require("controller.core_manager")
local array_manager = require("controller.array_manager")
local audio_manager = require("controller.audio_manager")
local component_strengthen_weight_data = require("data.component_strengthen_weight_data")

PopComponentLayer = class("PopComponentLayer", function(...)
	return PopItemLayer:create(...)
end)

function PopComponentLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopComponentLayer.new(arg_2_1)

	var_2_0:init2(arg_2_1)

	return var_2_0
end

function PopComponentLayer:init2(arg_3_1)
	self.isBag = arg_3_1.isShowInBag
	self.updateCallback = arg_3_1.updateCallback

	self.confirm_button:setVisible(true)
	self.numberLabel:setVisible(false)
	self:initConfirmBtn()
	self:initLockBtn()
	self:registerStrengthenHandel()
	self:initComponentAttrPanel(arg_3_1)
	self:updateComponentPanel()
	self:updateStrengthenInfo()
end

function PopComponentLayer.initOhter(arg_4_0, arg_4_1)
	return
end

function PopComponentLayer:registerStrengthenHandel()
	self.confirm_button:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_6_0:isBright() then
			return
		end

		local function var_6_0()
			self:updateComponentPanel()
			self:updateStrengthenInfo()

			if self.updateCallback then
				self.updateCallback(1)
			end
		end

		if component_manager:canAdjustComponent(self.entityid) then
			LayerManager:removePopLayer(self.__queueindex)
			LayerManager:pushInLayer("PopComponentStrengthenLayer", {
				type = "adjust",
				entityid = self.entityid
			})

			return
		end

		if component_manager:hadAdjustComponent(self.entityid) then
			global_ShowBlockWords("该芯片已校准!")

			return
		end

		if not component_manager:getComponetLevelUpNeedExp(self.entityid) then
			arg_6_0:setBright(false)
			component_manager:strengthenComponent(self.entityid, nil, function(arg_8_0)
				if arg_8_0 == 1 then
					var_6_0()
				elseif arg_8_0 == 2 then
					global_ShowBlockWords("芯片已经强化至满级!")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_8_0 == 4 then
					global_ShowBlockWords(L_GOLD_LACK)
					audio_manager:playeffectMusicTest("sound/invalid")

					if self.goto_back_system_id then
						LayerManager:removePopLayer()
						LayerManager:pushInLayer("PopGoGainLayer", {
							item = "gold",
							goto_back_system_id = self.goto_back_system_id
						})
					end
				end

				arg_6_0:setBright(true)
			end)
		else
			arg_6_0:setBright(true)
			LayerManager:pushInLayer("PopComponentStrengthenLayer", {
				entityid = self.entityid,
				callback = var_6_0
			})
		end
	end)
end

function PopComponentLayer:initComponentAttrPanel(arg_9_1)
	self.mainAttrDes = cc.Label:createWithTTF(L_WEAPON_MAIN_ATTR .. "：", FONT_DES, 20)

	self.mainAttrDes:setColor(cc.c3b(0, 216, 255))
	self.mainAttrDes:setAnchorPoint(cc.p(0, 0.5))
	self.mainAttrDes:setPosition(cc.p(260, 755))
	self.rootpanel:addChild(self.mainAttrDes)

	self.curAttrDes = cc.Label:createWithTTF("", FONT_DES, 20)

	self.curAttrDes:setColor(cc.c3b(0, 216, 255))
	self.curAttrDes:setAnchorPoint(cc.p(0, 0.5))
	self.curAttrDes:setPosition(cc.p(self.mainAttrDes:getPositionX(), self.mainAttrDes:getPositionY() - self.mainAttrDes:getContentSize().height))
	self.rootpanel:addChild(self.curAttrDes)

	self.nextAttrDes = cc.Label:createWithTTF("", FONT_DES, 20)

	self.nextAttrDes:setColor(cc.c3b(0, 216, 255))
	self.nextAttrDes:setAnchorPoint(cc.p(0, 0.5))
	self.nextAttrDes:setPosition(cc.p(self.mainAttrDes:getPositionX(), self.curAttrDes:getPositionY() - self.mainAttrDes:getContentSize().height))
	self.rootpanel:addChild(self.nextAttrDes)

	self.arrow = ccui.ImageView:create("public/panelbg/strengen_arrow.png", var_0_0)

	self.arrow:setAnchorPoint(cc.p(0, 0.5))
	self.arrow:setPositionX(self.mainAttrDes:getPositionX())
	self.arrow:setPositionY(self.nextAttrDes:getPositionY())
	self.rootpanel:addChild(self.arrow)

	self.curAttrDes2 = cc.Label:createWithTTF("", FONT_DES, 20)

	self.curAttrDes2:setColor(cc.c3b(0, 216, 255))
	self.curAttrDes2:setAnchorPoint(cc.p(0, 0.5))
	self.curAttrDes2:setPosition(cc.p(self.mainAttrDes:getPositionX(), self.mainAttrDes:getPositionY() - self.mainAttrDes:getContentSize().height))
	self.rootpanel:addChild(self.curAttrDes2)

	self.nextAttrDes2 = cc.Label:createWithTTF("", FONT_DES, 20)

	self.nextAttrDes2:setColor(cc.c3b(0, 216, 255))
	self.nextAttrDes2:setAnchorPoint(cc.p(0, 0.5))
	self.nextAttrDes2:setPosition(cc.p(self.mainAttrDes:getPositionX(), self.curAttrDes2:getPositionY() - self.mainAttrDes:getContentSize().height))
	self.rootpanel:addChild(self.nextAttrDes2)

	self.arrow2 = ccui.ImageView:create("public/panelbg/strengen_arrow.png", var_0_0)

	self.arrow2:setAnchorPoint(cc.p(0, 0.5))
	self.arrow2:setPositionX(self.mainAttrDes:getPositionX())
	self.arrow2:setPositionY(self.nextAttrDes2:getPositionY())
	self.rootpanel:addChild(self.arrow2)

	self.costIcon = ccui.ImageView:create("public/currency/UI_battleEnd_gold.png", var_0_0)

	self.costIcon:setPosition(cc.p(self.confirm_button:getContentSize().width / 2 - 40, -5))
	self.confirm_button:addChild(self.costIcon)

	self.costLabel = cc.Label:createWithTTF("", FONT_DES, 24)

	self.costLabel:setPosition(cc.p(self.costIcon:getPositionX() + self.costIcon:getContentSize().width + 10, self.costIcon:getPositionY()))
	self.confirm_button:addChild(self.costLabel)

	self.goToRemake = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_0_0)

	self.confirm_button:getParent():addChild(self.goToRemake)
	self.goToRemake:setAnchorPoint(0.5, 0.5)
	self.goToRemake:setPosition(132, self.confirm_button:getPositionY())
	self.goToRemake:setVisible(false)
	self.goToRemake:addTouchEventListener(function(arg_10_0, arg_10_1)
		local var_10_0

		if arg_10_1 ~= ccui.TouchEventType.ended then
			do return end

			var_10_0 = {
				goto_back_system_id = 301,
				itemtype = kITEM_COMPONENT
			}
		end

		var_10_0.callbacklist = {
			returnCallBack = function()
				if arg_9_1.updateCallback then
					arg_9_1.updateCallback(1)
				end
			end
		}
		var_10_0.paneltype = ITEMPANEL_TYPE_ROLE_COMPONENT

		LayerManager:removePopLayer(self._index)
		LayerManager:pushInLayer("ItemsPanel", var_10_0)
	end)

	self.remakeText = cc.Label:createWithTTF(L_COMPONENT_TEXT.Button_Label[10], FONT_BUTTON, 28)

	self.remakeText:setPosition(self.goToRemake:getContentSize().width / 2, self.goToRemake:getContentSize().height / 2)
	self.remakeText:setColor(cc.c3b(0, 0, 0))
	self.goToRemake:addChild(self.remakeText)
end

function PopComponentLayer:updateComponentPanel()
	self.Strength_Icon:updateBigInfo(false, self.entityid)

	if component_manager:getStrengthenStatus(self.entityid) then
		local var_12_0, var_12_1, var_12_2, var_12_3 = component_manager:getStrengthenInfo(self.entityid, true)

		self.curAttrDes:setString(var_12_0[1].name .. " + " .. FIGHT_ATTR_FORMAT(var_12_0[1].key, var_12_0[1].value))

		local var_12_4 = FIGHT_ATTR_FORMAT(var_12_0[2].key, var_12_0[2].value) .. " ~ " .. FIGHT_ATTR_FORMAT(var_12_0[2].key, var_12_0[2].max_value)

		self.nextAttrDes:setString((FIGHT_ATTR_FORMAT(var_12_0[2].key, var_12_0[2].value) == FIGHT_ATTR_FORMAT(var_12_0[2].key, var_12_0[2].max_value) or nil) and FIGHT_ATTR_FORMAT(var_12_0[2].key, var_12_0[2].value))
		self.nextAttrDes:setPositionX(self.arrow:getPositionX() + self.arrow:getContentSize().width)

		if playermodel.items[self.entityid].component_attr.attr2 then
			self.curAttrDes2:setString(var_12_3[1].name .. " + " .. FIGHT_ATTR_FORMAT(var_12_3[1].key, var_12_3[1].value))

			local var_12_5 = FIGHT_ATTR_FORMAT(var_12_3[2].key, var_12_3[2].value) .. " ~ " .. FIGHT_ATTR_FORMAT(var_12_3[2].key, var_12_3[2].max_value)

			self.nextAttrDes2:setString((FIGHT_ATTR_FORMAT(var_12_3[2].key, var_12_3[2].value) == FIGHT_ATTR_FORMAT(var_12_3[2].key, var_12_3[2].max_value) or nil) and FIGHT_ATTR_FORMAT(var_12_3[2].key, var_12_3[2].value))
			self.nextAttrDes2:setPositionX(self.arrow2:getPositionX() + self.arrow2:getContentSize().width)
			self.curAttrDes2:setPositionY(self.nextAttrDes:getPositionY() - self.nextAttrDes:getContentSize().height)
			self.nextAttrDes2:setPositionY(self.curAttrDes2:getPositionY() - self.curAttrDes2:getContentSize().height)
			self.arrow2:setPositionY(self.curAttrDes2:getPositionY() - self.curAttrDes2:getContentSize().height)
		end

		local var_12_6 = 0
		local var_12_10 = component_manager:getComponentStrengthTable()

		self.confirm_button_label:setString(L_BUTTON_TEXT.Strengthen)

		local var_12_11 = component_manager:getComponetLevelUpNeedExp(self.entityid)

		if not var_12_11 then
			self.costLabel:setString(global_trans_number(component_manager:getUpGradeData(self.entityid).gold_cost))

			if var_12_6 > playermodel.gold then
				self.confirm_button:loadTextures("public/button/public_button_orange_long.png", "", "public/button/public_button_orange_long.png", var_0_0)
			else
				self.confirm_button:loadTextures("public/button/public_button_orange_long.png", "", "public/button/public_button_orange_long.png", var_0_0)
			end
		end

		self.costLabel:setVisible(not var_12_11)
		self.costIcon:setVisible(not var_12_11)

		if self.isBag and var_0_6[playermodel.items[self.entityid].itemid].equip_quality == 6 then
			self.confirm_button:loadTextures("public/button/public_button_orange.png", "", "public/button/public_button_orange.png", var_0_0)
			self.confirm_button:setPositionX(382)
			self.confirm_button_label:setPosition(self.confirm_button:getContentSize().width / 2, self.confirm_button:getContentSize().height / 2)
			self.goToRemake:setVisible(true)
		end
	elseif component_manager:canAdjustComponent(self.entityid) then
		self.confirm_button:loadTextures("public/button/public_button_orange_long.png", "", "public/button/public_button_orange_long.png", var_0_0)
		self.confirm_button_label:setString(L_BUTTON_TEXT.Adjust)
		self.costLabel:setVisible(false)
		self.costIcon:setVisible(false)

		local var_12_12, var_12_13, var_12_14, var_12_15 = component_manager:getStrengthenInfo(self.entityid, true)

		self.curAttrDes:setString(FIGHT_ATTR_INFO[var_12_12[1].key] .. " + " .. FIGHT_ATTR_FORMAT(var_12_12[1].key, var_12_12[1].value))

		local var_12_16 = component_manager:getComponentAttrRange(self.entityid)
		local var_12_17 = FIGHT_ATTR_FORMAT(var_12_16.key, var_12_16.minValue) .. "~" .. FIGHT_ATTR_FORMAT(var_12_16.key, var_12_16.maxValue)

		self.nextAttrDes:setString((FIGHT_ATTR_FORMAT(var_12_16.key, var_12_16.minValue) == FIGHT_ATTR_FORMAT(var_12_16.key, var_12_16.maxValue) or nil) and FIGHT_ATTR_FORMAT(var_12_16.key, var_12_16.minValue))
		self.nextAttrDes:setPositionX(self.arrow:getPositionX() + self.arrow:getContentSize().width)

		if playermodel.items[self.entityid].component_attr.attr2 then
			self.curAttrDes2:setString(FIGHT_ATTR_INFO[var_12_15[1].key] .. " + " .. FIGHT_ATTR_FORMAT(var_12_15[1].key, var_12_15[1].value))

			local var_12_18 = FIGHT_ATTR_FORMAT(var_12_15[2].key, var_12_15[2].value) .. " ~ " .. FIGHT_ATTR_FORMAT(var_12_15[2].key, var_12_15[2].max_value)

			self.nextAttrDes2:setString((FIGHT_ATTR_FORMAT(var_12_15[2].key, var_12_15[2].value) == FIGHT_ATTR_FORMAT(var_12_15[2].key, var_12_15[2].max_value) or nil) and FIGHT_ATTR_FORMAT(var_12_15[2].key, var_12_15[2].value))
			self.nextAttrDes2:setPositionX(self.arrow2:getPositionX() + self.arrow2:getContentSize().width)
			self.curAttrDes2:setPositionY(self.nextAttrDes:getPositionY() - self.nextAttrDes:getContentSize().height)
			self.nextAttrDes2:setPositionY(self.curAttrDes2:getPositionY() - self.curAttrDes2:getContentSize().height)
			self.arrow2:setPositionY(self.curAttrDes2:getPositionY() - self.curAttrDes2:getContentSize().height)
		end

		if self.isBag and var_0_6[playermodel.items[self.entityid].itemid].equip_quality == 6 then
			self.confirm_button:loadTextures("public/button/public_button_orange.png", "", "public/button/public_button_orange.png", var_0_0)
			self.confirm_button:setPositionX(382)
			self.confirm_button_label:setPosition(self.confirm_button:getContentSize().width / 2, self.confirm_button:getContentSize().height / 2)
			self.goToRemake:setVisible(true)
		end
	else
		self.confirm_button_label:setString((component_manager:hadAdjustComponent(self.entityid) or nil) and (L_COMPONENT_TEXT.Button_Label[8] or L_COMPONENT_TEXT.Button_Label[4]))
		self.confirm_button:loadTextures("public/button/public_button_gray_long.png", "", "public/button/public_button_gray_long.png", var_0_0)
		self.costLabel:setVisible(false)
		self.costIcon:setVisible(false)

		local var_12_19, var_12_20, var_12_21, var_12_22 = component_manager:getStrengthenInfo(self.entityid, true)

		self.curAttrDes:setString(FIGHT_ATTR_INFO[var_12_19[1].key] .. " + " .. FIGHT_ATTR_FORMAT(var_12_19[1].key, var_12_19[1].value))
		self.nextAttrDes:setString(L_COMPONENT_TEXT.Button_Label[9])
		self.nextAttrDes:setPositionX(self.arrow:getPositionX() + self.arrow:getContentSize().width)

		if playermodel.items[self.entityid].component_attr.attr2 then
			self.curAttrDes2:setString(FIGHT_ATTR_INFO[var_12_22[1].key] .. " + " .. FIGHT_ATTR_FORMAT(var_12_22[1].key, var_12_22[1].value))
			self.nextAttrDes2:setString(L_COMPONENT_TEXT.Button_Label[9])
			self.nextAttrDes2:setPositionX(self.arrow2:getPositionX() + self.arrow2:getContentSize().width)
			self.curAttrDes2:setPositionY(self.nextAttrDes:getPositionY() - self.nextAttrDes:getContentSize().height)
			self.nextAttrDes2:setPositionY(self.curAttrDes2:getPositionY() - self.curAttrDes2:getContentSize().height)
			self.arrow2:setPositionY(self.curAttrDes2:getPositionY() - self.curAttrDes2:getContentSize().height)
		end

		if self.isBag and var_0_6[playermodel.items[self.entityid].itemid].equip_quality == 6 then
			self.confirm_button:loadTextures("public/button/public_button_gray.png", "", "public/button/public_button_gray.png", var_0_0)
			self.confirm_button:setPositionX(382)
			self.confirm_button_label:setPosition(self.confirm_button:getContentSize().width / 2, self.confirm_button:getContentSize().height / 2)
			self.goToRemake:setVisible(true)
		end
	end
end

function PopComponentLayer.registerLockHandel(arg_13_0)
	return
end

function PopComponentLayer:initConfirmBtn()
	if self.msg.button and self.msg.button.confirmHandel then
		self.confirm_button:addTouchEventListener(self.msg.button.confirmHandel)
		self.confirm_button:setVisible(true)
		self.confirm_button_label:setString(self.msg.button.label)
	elseif self.msg.button and next(self.msg.button) then
		for iter_16_0, iter_16_1 in pairs(self.msg.button) do
			if iter_16_1.confirmHandel then
				self.confirm_button:addTouchEventListener(iter_16_1.confirmHandel)
				self.confirm_button:setVisible(true)
				self.confirm_button_label:setString(iter_16_1.label)
			end
		end
	end

	self.confirm_button:setPosition(cc.p(272, self.confirm_button:getPositionY()))
	self.confirm_button:loadTextures("public/button/public_button_orange_long.png", "", "public/button/public_button_orange_long.png", var_0_0)
end

function PopComponentLayer:updateStrengthenInfo(...)
	if not self.entityid then
		return
	end

	local var_17_0 = {
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
		self.componentStrengthenInfoPanel:setPosition(cc.p(40, 626))
		self.componentStrengthenInfoPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		self.rootpanel:addChild(self.componentStrengthenInfoPanel, 100)

		for iter_17_0, iter_17_1 in pairs(var_17_0) do
			local var_17_1 = ccui.ImageView:create(iter_17_1.path, var_0_0)

			var_17_1:setAnchorPoint(cc.p(0, 0.5))
			var_17_1:setName("componentinfo_sp_" .. iter_17_0)
			self.componentStrengthenInfoPanel:addChild(var_17_1)

			local var_17_2 = cc.Label:createWithTTF("", FONT_DES, 22)

			var_17_2:setAnchorPoint(cc.p(0, 0.5))
			var_17_2:setName("componentinfo_label_" .. iter_17_0)
			self.componentStrengthenInfoPanel:addChild(var_17_2)
		end
	end

	local var_17_3 = var_0_6[playermodel.items[self.entityid].itemid].equip_quality
	local var_17_4 = 1

	while component_strengthen_weight_data[var_17_3]["add_weight" .. 1] do
		if component_strengthen_weight_data[var_17_3]["add_weight" .. 1] > 0 then
			var_17_4 = 1
		end
	end

	local var_17_6 = 1
	local var_17_7 = {
		217,
		279,
		348,
		417,
		486,
		555
	}
	local var_17_8 = component_manager:getComponentStrengthenInfo(self.entityid)

	for iter_17_2, iter_17_3 in pairs(var_17_0) do
		self.componentStrengthenInfoPanel:getChildByName("componentinfo_label_" .. iter_17_2):setString(var_17_8[iter_17_3.id])
		self.componentStrengthenInfoPanel:getChildByName("componentinfo_label_" .. iter_17_2):setVisible(false)
		self.componentStrengthenInfoPanel:getChildByName("componentinfo_sp_" .. iter_17_2):setVisible(false)

		if var_17_4 >= iter_17_3.id and component_strengthen_weight_data[var_17_3]["add_weight" .. iter_17_3.id] > 0 then
			self.componentStrengthenInfoPanel:getChildByName("componentinfo_label_" .. iter_17_2):setPositionX(var_17_7[var_17_6] + 40)
			self.componentStrengthenInfoPanel:getChildByName("componentinfo_sp_" .. iter_17_2):setPositionX(var_17_7[var_17_6])
			self.componentStrengthenInfoPanel:getChildByName("componentinfo_label_" .. iter_17_2):setVisible(true)
			self.componentStrengthenInfoPanel:getChildByName("componentinfo_sp_" .. iter_17_2):setVisible(true)

			var_17_6 = var_17_6 + 1
		end
	end
end

function PopComponentLayer:initLockBtn()
	self.lockBtn = ccui.Button:create("public/button/pop_lock.png", nil, "public/button/pop_lock.png", var_0_0)

	self.lockBtn:setAnchorPoint(cc.p(0.5, 0.5))
	self.lockBtn:setPosition(cc.p(535, 785))
	self.rootpanel:addChild(self.lockBtn)
	self.lockBtn:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_19_0:isBright() then
			return
		end

		arg_19_0:setBright(false)
		require("network.network"):rpc("lock_item", {
			locktype = playermodel.items[self.entityid].component_attr.lock and 1 or 2,
			entityid = self.entityid
		}, function(arg_20_0)
			if arg_20_0.result == 1 then
				playermodel.items[self.entityid].component_attr.lock = arg_20_0.lock

				self:updateLockBtn()

				if self.updateCallback then
					self.updateCallback(1)
				end
			else
				l2Log("lock fail")
			end

			arg_19_0:setBright(true)
		end)
	end)
	self:updateLockBtn()

	local var_18_0 = self.itemInfoLayer:getChildByName("name_label")

	self.lockBtn:setPositionY(self.rootpanel:convertToNodeSpace((var_18_0:getParent():convertToWorldSpace(cc.p(var_18_0:getPosition())))).y)
end

function PopComponentLayer:updateLockBtn()
	if playermodel.items[self.entityid].component_attr.lock then
		self.lockBtn:loadTextures("public/button/pop_unlock.png", nil, "public/button/pop_unlock.png", var_0_0)
	else
		self.lockBtn:loadTextures("public/button/pop_lock.png", nil, "public/button/pop_lock.png", var_0_0)
	end
end
