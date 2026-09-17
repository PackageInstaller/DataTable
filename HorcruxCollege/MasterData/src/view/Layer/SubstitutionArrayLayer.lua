SubstitutionArrayLayer = class("SubstitutionArrayLayer", function()
	return BattleArrayLayerNew:create_by_child()
end)

local substitution_manager = require("controller.substitution_manager")
local playermodel = require("model.playermodel")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local horcrux_data = require("data.horcrux_data")
local item_data = require("data.item_data")
local total_skill_data = require("data.total_skill_data")
local servant_data = require("data.servant_data")
local chapter_data = require("data.chapter_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local component_effect_data = require("data.component_effect_data")
local horcrux_manager = require("controller.horcrux_manager")
local array_manager = require("controller.array_manager")
local level_manager = require("controller.level_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local audio_manager = require("controller.audio_manager")
local core_manager = require("controller.core_manager")
local explore_manager = require("controller.explore_manager")
local arena_manager = require("controller.arena_manager")
local scorearena_manager = require("controller.scorearena_manager")
local alert_manager = require("controller.alert_manager")
local patrol_manager = require("controller.patrol_manager")
local component_manager = require("controller.component_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local var_0_24 = config._DEBUG and 0 or 1

function SubstitutionArrayLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SubstitutionArrayLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function SubstitutionArrayLayer:updateArrayFightCapacity(arg_3_1, arg_3_2, arg_3_3)
	local var_3_1 = substitution_manager:getUsingArraysData(self.curSelectArrayId)
	local var_3_2 = fight_capacity_manager:getArrayFightCapacity(arg_3_1, nil, nil, nil, arg_3_2)

	explore_manager:setCurFightCapacity(var_3_2)

	if self.oldFightCapacity then
		fight_capacity_manager:displayArrayChangeValue(var_3_1, arg_3_2, arg_3_3)
	end

	fight_capacity_manager:saveArrayFightCapacity(var_3_1)

	self.oldFightCapacity = var_3_2

	self.fightCapacityLabel:setString(global_trans_bitmapnumber(var_3_2))
end

function SubstitutionArrayLayer:initArrayFightCapacity()
	local var_4_0
	local var_4_1

	if not self.arraydata or not self.arraydata["array_" .. self.curSelectArrayId] and self.usingarrays then
		var_4_0 = substitution_manager:getUsingArraysData(self.curSelectArrayId)
		var_4_1 = fight_capacity_manager:getArrayFightCapacity(var_4_0)
	else
		var_4_0 = substitution_manager:getSubArraysData(self.curSelectArrayId)
		var_4_1 = fight_capacity_manager:getSubUsingArrayFightCapacity(var_4_0)
	end

	explore_manager:setCurFightCapacity(var_4_1)

	self.oldFightCapacity = var_4_1

	fight_capacity_manager:saveArrayFightCapacity(var_4_0)
	self.fightCapacityLabel:setString((global_trans_bitmapnumber(var_4_1)))
end

function SubstitutionArrayLayer:selectArray()
	if self.usingarrays then
		while self.arraydata and self.arraydata["array_" .. self.curSelectArrayId] do
			self.curSelectArrayId = self.curSelectArrayId + 1
		end
	end
end

function SubstitutionArrayLayer:init(arg_6_1)
	battlearraylayerInstance = self
	self.active = true
	self.size = cc.Director:getInstance():getVisibleSize()
	self.enemyid = arg_6_1.enemyid
	self.mode = arg_6_1.mode
	self.level = arg_6_1.level
	self.fightcount = arg_6_1.fightcount
	self.arraydata = arg_6_1.arraydata
	self.usingarrays = arg_6_1.usingarrays
	self.initconfig = arg_6_1

	if arg_6_1 then
		self.configType = arg_6_1.configtype or CONFIG_TYPE_NORMAL
	end

	self.configCallback = arg_6_1 and arg_6_1.configcallback
	self.configMode = arg_6_1 and arg_6_1.initmode
	self.configexitCallback = arg_6_1 and arg_6_1.exitcallback

	if arg_6_1 then
		self.curSelectArrayId = arg_6_1.initindex or 1
	end

	self:checkDefaultArrayIs()
	self:selectArray()

	self.adventuretowercallback = arg_6_1.adventure5callback
	self.cancelcallback = arg_6_1.cancelcallback

	LayerManager:createFullScreenMask(self, 0, function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.cancelcallback then
			self.cancelcallback()
		end

		self:exit()
	end)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "BattleSubArrayLayer.json" or "BattleSubArrayLayer.ExportJson")

	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	local var_6_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn")
	local var_6_1 = cc.Label:createWithTTF("", FONT_BUTTON, 30)

	var_6_1:setName("label_btn")
	var_6_1:setColor(cc.c3b(0, 0, 0))
	var_6_0:addChild(var_6_1, 999)

	self.timerLabel = cc.Label:createWithTTF("00:00:00", FONT_NAME, 24)

	self.timerLabel:setVisible(false)
	self.timerLabel:setPosition(320, 225)
	self.rootLayer:addChild(self.timerLabel)

	local var_6_2 = ccui.ImageView:create("Array/effect_fight_btn_get_award.png", var_0_24)

	var_6_2:setName("effect")
	var_6_2:setVisible(false)
	var_6_2:setContentSize(var_6_0:getContentSize().width, var_6_0:getContentSize().height)
	var_6_2:setPosition(var_6_0:getContentSize().width / 2, var_6_0:getContentSize().height / 2)
	var_6_0:addChild(var_6_2)
	var_6_2:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(1), cc.FadeIn:create(1))))

	self.quick_patrol_bnt = ccui.Button:create("Array/finish_quick.png", nil, "Array/finish_quick.png", var_0_24)

	self.quick_patrol_bnt:setAnchorPoint(cc.p(0, 0.5))
	self.quick_patrol_bnt:setVisible(false)
	self.quick_patrol_bnt:setPositionX(self.timerLabel:getPositionX() + self.timerLabel:getContentSize().width / 2)
	self.quick_patrol_bnt:setPositionY(self.timerLabel:getPositionY())
	self.rootLayer:addChild(self.quick_patrol_bnt)

	if not self.usingarrays then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_arrayStatus"):setVisible(false)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_8_0:isBright() then
			return
		end

		arg_8_0:setBright(false)
		self:btnSureEvent(function()
			arg_8_0:setBright(true)
		end)
	end)
	self.rootLayer:getChildByName("Panel_Pop"):setScaleY(0)
	self.rootLayer:getChildByName("Panel_Pop"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1.1), cc.ScaleTo:create(0.05, 1, 1), cc.CallFunc:create(function()
		self:updateGuidesOnLayer()
	end)))
	self.rootLayer:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.cancelcallback then
			self.cancelcallback()
		end

		self:exit()
	end)
	self:initArrayListPanel()
	self:updateArrayListPanel()
	self:saveInitArrayInfo()
	self:initUI()
	self:updateAllCell()
	self:initArrayFightCapacity()
	self:registerUpdateUI()
	self:registerScriptHandler(function(arg_12_0)
		if arg_12_0 == "exit" then
			battlearraylayerInstance = nil
		end
	end)
end

function SubstitutionArrayLayer:registerUpdateUI()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("substitutionArrayLayerEvent", function(arg_14_0)
		self:updateAllCell()
		self:updateUI()
	end), self)
end

function SubstitutionArrayLayer:initArrayListPanel()
	self.arrayListView = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_arrayList")
	self.btnList = {}

	local var_15_2 = (function()
		local var_16_0 = {}

		if self.usingarrays then
			for iter_16_0 = 1, 5 do
				table.insert(var_16_0, iter_16_0)
			end
		else
			local var_16_1 = 1

			while self.arraydata["array_" .. var_16_1] do
				var_16_1 = var_16_1 + 1
			end

			for iter_16_1 = 1, var_16_1 - 1 do
				table.insert(var_16_0, iter_16_1)
			end
		end

		return var_16_0
	end)()

	self.leftBtnListCount = #nil

	local var_15_3 = {}

	for iter_15_0 = 1, self.leftBtnListCount do
		var_15_3[iter_15_0] = L_TEAM_TIPS.Team .. (var_15_2[iter_15_0] or "+")
	end

	if #nil ~= MAX_ARRAY_COUNT then
		var_15_3[#var_15_3] = L_TEAM_TIPS.Team .. "+"
	end

	for iter_15_1, iter_15_2 in pairs(var_15_3) do
		local var_15_6 = self:createArrayIndexBtn(var_15_2[iter_15_1] or "+")

		var_15_6:setName("array_index_" .. (var_15_2[iter_15_1] or "+"))
		table.insert(self.btnList, var_15_6)
		self.arrayListView:pushBackCustomItem(var_15_6)
	end
end

function SubstitutionArrayLayer.createArrayIndexBtn(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1 == "+" and ccui.ImageView:create("public/button/array_inde_btn_add.png", var_0_24) or ccui.ImageView:create("public/button/array_index_btn.png", var_0_24)

	var_17_0:setTouchEnabled(true)

	var_17_0.index = arg_17_1

	var_17_0:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_18_0.index == "+" then
			arg_17_0:addArray()

			return
		end

		arg_17_0.curSelectArrayId = arg_18_0.index

		arg_17_0:updateAllCell()
		arg_17_0:initArrayFightCapacity()
		arg_17_0:updateArrayListPanel()
		arg_17_0:updateSureBtn()
	end)

	local var_17_1 = cc.Label:createWithTTF(arg_17_1, FONT_NAME, 28)

	var_17_1:setColor(cc.c3b(208, 233, 247))
	var_17_1:setName("label")
	var_17_1:setPositionX(var_17_0:getContentSize().width / 2)
	var_17_1:setPositionY(var_17_0:getContentSize().height / 2)
	var_17_0:addChild(var_17_1)

	return var_17_0
end

function SubstitutionArrayLayer:updateSureBtn()
	local var_19_0
	local var_19_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn")
	local var_19_2 = var_19_1:getChildByName("label_btn")

	if not self.arraydata or not self.arraydata["array_" .. self.curSelectArrayId] then
		var_19_0 = "public/button/public_button_orange_long.png"

		var_19_2:setString("确认派出")
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_arrayStatus"):setString("")
	else
		var_19_0 = "public/button/public_button_gray_long.png"

		var_19_2:setString("该队伍已上阵")
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_arrayStatus"):setString("队伍分数:" .. global_trans_number(substitution_manager:getArrayScore(self.curSelectArrayId)))
	end

	var_19_1:loadTextures(var_19_0, nil, var_19_0, var_0_24)
	var_19_2:setColor(cc.c3b(12, 12, 12))
	var_19_2:setPosition(cc.p(var_19_1:getContentSize().width / 2, var_19_1:getContentSize().height / 2 - 5))
	self:lockRoleChange()
end

function SubstitutionArrayLayer:lockRoleChange()
	if not self.arraydata or not self.arraydata["array_" .. self.curSelectArrayId] and self.usingarrays then
		for iter_20_0, iter_20_1 in pairs(self.slotList) do
			local var_20_0 = ccui.Helper:seekWidgetByName(self.slotList[iter_20_0], "Panel_servant_lock")
			local var_20_1 = ccui.Helper:seekWidgetByName(self.slotList[iter_20_0], "Panel_horcrux_lock")

			var_20_0:setVisible(false)
			var_20_1:setVisible(false)
		end
	else
		for iter_20_2, iter_20_3 in pairs(self.slotList) do
			local var_20_2 = ccui.Helper:seekWidgetByName(self.slotList[iter_20_2], "Panel_servant_lock")
			local var_20_3 = ccui.Helper:seekWidgetByName(self.slotList[iter_20_2], "Panel_horcrux_lock")

			var_20_2:setVisible(true)
			var_20_3:setVisible(true)
		end
	end

	self:initLockChange()
end

function SubstitutionArrayLayer:initLockChange()
	for iter_21_0, iter_21_1 in pairs(self.slotList) do
		local var_21_0 = ccui.Helper:seekWidgetByName(self.slotList[iter_21_0], "Panel_servant_lock")
		local var_21_1 = ccui.Helper:seekWidgetByName(self.slotList[iter_21_0], "Panel_horcrux_lock")

		var_21_0:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.usingarrays then
				global_ShowBlockWords("当前队伍已锁定！")
			end
		end)
		var_21_1:addTouchEventListener(function(arg_23_0, arg_23_1)
			if arg_23_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.usingarrays then
				global_ShowBlockWords("当前队伍已锁定！")
			end
		end)
	end
end

function SubstitutionArrayLayer:initUI()
	self:updateTitle()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_33"):setString(TIPS_DES)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_attrTips"):addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:displayTips()
	end)
	;(function()
		local var_26_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_fightCapacitySumIcon")

		self.fightCapacityLabel = ccui.TextBMFont:create(1, "fonts/array_fightcapacity_number.fnt")

		self.fightCapacityLabel:setPositionX(var_26_0:getPositionX() + var_26_0:getContentSize().width / 2)
		self.fightCapacityLabel:setPositionY(var_26_0:getPositionY())
		self.fightCapacityLabel:setAnchorPoint(cc.p(0, 0.5))
		self.fightCapacityLabel:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pop"):addChild(self.fightCapacityLabel)
	end)()

	self.slot1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_slot")

	self.slot1:setPositionX(-320)

	self.slot2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_slot"):clone()

	self.slot2:setPositionX(-160)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pop"):addChild(self.slot2)

	self.slot3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_slot"):clone()

	self.slot3:setPositionX(0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pop"):addChild(self.slot3)

	self.slot4 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_slot"):clone()

	self.slot4:setPositionX(160)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pop"):addChild(self.slot4)
	ccui.Helper:seekWidgetByName(self.slot1, "Image_attrMatch"):setName("Image_attrMatch_1")
	ccui.Helper:seekWidgetByName(self.slot2, "Image_attrMatch"):setName("Image_attrMatch_2")
	ccui.Helper:seekWidgetByName(self.slot3, "Image_attrMatch"):setName("Image_attrMatch_3")
	ccui.Helper:seekWidgetByName(self.slot4, "Image_attrMatch"):setName("Image_attrMatch_4")

	self.slotList = {}
	self.slotList[1] = self.slot1
	self.slotList[2] = self.slot2
	self.slotList[3] = self.slot3
	self.slotList[4] = self.slot4

	local var_24_0 = {
		"Array/1st.png",
		"Array/2nd.png",
		"Array/3rd.png",
		"Array/4th.png"
	}

	self:updateSureBtn()

	local var_24_1 = 0

	for iter_24_0, iter_24_1 in pairs(self.slotList) do
		ccui.Helper:seekWidgetByName(self.slotList[iter_24_0], "Image_slotIndex"):loadTexture(var_24_0[iter_24_0], var_0_24)

		local var_24_2 = GirlSprite:create({
			initType = "subArrayStyle"
		})

		var_24_2:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant"):getContentSize().width / 2)
		var_24_2:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant"):getContentSize().height / 2)
		var_24_2:setName("girlSprite")
		var_24_2:setTouchEnabled(false)
		ccui.Helper:seekWidgetByName(self.slotList[iter_24_0], "Panel_servant"):addChild(var_24_2, 10)

		local var_24_3 = HorcruxSprite:create({
			initType = "arrayMemberStyle"
		})

		var_24_3:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_horcrux"):getContentSize().width / 2 - 10)
		var_24_3:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_horcrux"):getContentSize().height / 2)
		var_24_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_3:setName("horcruxSprite")
		var_24_3:setTouchEnabled(false)
		var_24_3:setScale(0.8)
		ccui.Helper:seekWidgetByName(self.slotList[iter_24_0], "Panel_horcrux"):addChild(var_24_3, 10)
		iter_24_1:getChildByName("Panel_servant"):getChildByName("Image_add"):setName("servant_add_img_" .. iter_24_0)
		iter_24_1:getChildByName("Panel_servant"):getChildByName("Image_bg"):setName("servant_bg_img_" .. iter_24_0)

		local var_24_4 = 1

		iter_24_1:getChildByName("Panel_servant"):getChildByName("servant_bg_img_" .. iter_24_0):addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 == ccui.TouchEventType.began then
				var_24_2:imgScaleTo(1.1, 0.1)

				local var_27_0 = substitution_manager:getUsingArraysData(self.curSelectArrayId)

				if var_27_0[iter_24_0].fight_girl then
					iter_24_1:getChildByName("Panel_servant"):getChildByName("servant_add_img_" .. iter_24_0):runAction(cc.ScaleTo:create(0.1, var_24_4 * 0.9, var_24_4 * 0.9))
					arg_27_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
						var_24_2:startPressBar(function()
							if var_27_0[iter_24_0].fight_girl then
								LayerManager:pushInLayer("SoulsLayer", {
									showtype = 6,
									cursoul = var_27_0[iter_24_0].fight_girl,
									exitCallback = function()
										if battlearraylayerInstance then
											self:updateAllCell()
											self:updateUI()
										end
									end
								})

								var_24_1 = 0.2
							else
								var_24_1 = 0
							end

							var_24_2:endPressBar()
						end, function(arg_31_0)
							var_24_1 = var_24_1 + arg_31_0
						end)
					end)))
				end
			elseif arg_27_1 == ccui.TouchEventType.canceled then
				var_24_2:imgScaleTo(1, 0.1)
				iter_24_1:getChildByName("Panel_servant"):getChildByName("servant_add_img_" .. iter_24_0):runAction(cc.ScaleTo:create(0.1, var_24_4 * 1, var_24_4 * 1))
				arg_27_0:stopAllActions()
				var_24_2:endPressBar()
			elseif arg_27_1 == ccui.TouchEventType.ended then
				arg_27_0:stopAllActions()

				if var_24_1 == 0 then
					self:changeRole(4 - iter_24_0)
				end

				var_24_1 = 0

				var_24_2:endPressBar()
				var_24_2:imgScaleTo(1, 0.1)
				iter_24_1:getChildByName("Panel_servant"):getChildByName("servant_add_img_" .. iter_24_0):runAction(cc.ScaleTo:create(0.1, var_24_4 * 1, var_24_4 * 1))
			end
		end)
		iter_24_1:getChildByName("Panel_horcrux"):getChildByName("Image_bg"):setName("horcrux_bg_img_" .. iter_24_0)
		iter_24_1:getChildByName("Panel_horcrux"):getChildByName("horcrux_bg_img_" .. iter_24_0):addTouchEventListener(function(arg_32_0, arg_32_1)
			if arg_32_1 == ccui.TouchEventType.began then
				var_24_3:imgScaleTo(1.1, 0.1)
				arg_32_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					var_24_3:startPressBar(function()
						local var_34_0 = substitution_manager:getUsingArraysData(self.curSelectArrayId)

						print(dump(var_34_0))
						print(dump(self.specialArray))

						if var_34_0[iter_24_0] and var_34_0[iter_24_0].assist_girl then
							LayerManager:pushInLayer("HorcruxInfoLayer", var_34_0[iter_24_0].assist_girl)

							var_24_1 = 0.2
						else
							var_24_1 = 0
						end

						var_24_3:endPressBar()
					end, function(arg_35_0)
						var_24_1 = var_24_1 + arg_35_0
					end)
				end)))
			elseif arg_32_1 == ccui.TouchEventType.canceled then
				var_24_3:imgScaleTo(1, 0.1)
				arg_32_0:stopAllActions()
				var_24_3:endPressBar()
			elseif arg_32_1 == ccui.TouchEventType.ended then
				arg_32_0:stopAllActions()

				if var_24_1 == 0 then
					self:changeAssistGirl(iter_24_0, var_24_3)
				end

				var_24_1 = 0

				var_24_3:endPressBar()
				var_24_3:imgScaleTo(1, 0.1)
			end
		end)
	end
end

function SubstitutionArrayLayer:updateAllCell()
	if not self.arraydata or not self.arraydata["array_" .. self.curSelectArrayId] and self.usingarrays then
		local var_36_1 = substitution_manager:getUsingArraysData(self.curSelectArrayId)

		for iter_36_0 = 1, 4 do
			self:updateSlot(var_36_1, iter_36_0)
		end
	else
		local var_36_2 = substitution_manager:getSubArraysData(self.curSelectArrayId)
		local var_36_3 = substitution_manager:getLockList()

		for iter_36_1 = 1, 4 do
			self:updateSubSlot(var_36_2, iter_36_1)
		end
	end
end

function SubstitutionArrayLayer:updateSlot(arg_37_1, arg_37_2)
	local var_37_0 = self.slotList[arg_37_2]
	local var_37_1 = arg_37_1[arg_37_2].fight_girl
	local var_37_2 = arg_37_1[arg_37_2].assist_girl

	var_37_0.servantid = arg_37_1[arg_37_2].fight_girl
	var_37_0.horcruxid = var_37_2
	var_37_0.skill1id = nil
	var_37_0.skill2id = nil

	local var_37_3 = ccui.Helper:seekWidgetByName(var_37_0, "girlSprite")

	if var_37_1 then
		var_37_3:update(var_37_1)
		var_37_3:setVisible(true)

		if role_false_level_manager:isRoleFalseLevelMember(var_37_1, FIGHTTYPE_SUBSTITUTION) then
			local var_37_4, var_37_5, var_37_6 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(var_37_1, FIGHTTYPE_SUBSTITUTION)

			var_37_3:updateByFalseLevel(var_37_1, var_37_4, var_37_5)
		else
			var_37_3:stopFalseLevelAni()
		end
	else
		var_37_3:setVisible(false)
	end

	local var_37_7 = ccui.Helper:seekWidgetByName(var_37_0, "horcruxSprite")

	if var_37_2 then
		var_37_7:update(var_37_2)
		var_37_7:setVisible(true)
	else
		var_37_7:setVisible(false)
	end

	if var_37_2 then
		local var_37_8 = self:getAttrIconPath(var_37_1)
		local var_37_9 = self:getAttrIconPath(playermodel.items[var_37_2].itemid)
		local var_37_10 = horcrux_manager:getHorcruxAssistConfigWithServant(var_37_2, (core_manager:getServantCoreRank(var_37_1)))

		var_37_0.skill1id = var_37_10.skills[1]
		var_37_0.skill2id = var_37_10.skills[2]

		if var_37_8 == var_37_9 then
			ccui.Helper:seekWidgetByName(var_37_0, "Image_attrMatch_" .. arg_37_2):loadTexture("Array/attr_" .. var_37_8 .. ".png", var_0_24)
		elseif var_37_8 == "imaginary" then
			ccui.Helper:seekWidgetByName(var_37_0, "Image_attrMatch_" .. arg_37_2):loadTexture("Array/frame_add_attribute_half.png", var_0_24)
		else
			ccui.Helper:seekWidgetByName(var_37_0, "Image_attrMatch_" .. arg_37_2):loadTexture("Array/frame_add_attribute_half.png", var_0_24)
		end

		local var_37_11 = horcrux_manager:getServantAttrAddPercent(var_37_9, global_get_all_servant_attrs(var_37_1))

		ccui.Helper:seekWidgetByName(var_37_0, "Label_damageAdd"):setString(L_TEAM_ATTR.Attack .. global_trans_number(math.floor(var_37_10.damage * var_37_11.damage)))
		ccui.Helper:seekWidgetByName(var_37_0, "Label_hpAdd"):setString(L_TEAM_ATTR.Blood .. global_trans_number(math.floor(var_37_10.hp * var_37_11.hp)))
	else
		ccui.Helper:seekWidgetByName(var_37_0, "Image_attrMatch_" .. arg_37_2):loadTexture("Array/attr_non.png", var_0_24)
	end

	ccui.Helper:seekWidgetByName(var_37_0, "Label_damageAdd"):setVisible(var_37_2 ~= nil)
	ccui.Helper:seekWidgetByName(var_37_0, "Label_hpAdd"):setVisible(var_37_2 ~= nil)
	ccui.Helper:seekWidgetByName(var_37_0, "fightCapacityLabel"):setVisible(var_37_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_37_0, "Image_fightCapacityIcon"):setVisible(var_37_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_37_0, "Panel_component"):setVisible(var_37_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_37_0, "Panel_fightpower"):setVisible(var_37_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_37_0, "Panel_servant"):getChildByName("servant_add_img_" .. arg_37_2):setVisible(var_37_1 == nil)
	ccui.Helper:seekWidgetByName(var_37_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_37_2):setOpacity(var_37_1 == nil and 255 or 0)
	ccui.Helper:seekWidgetByName(var_37_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_37_2):setOpacity(var_37_2 == nil and 255 or 0)
	ccui.Helper:seekWidgetByName(var_37_0, "fightCapacityLabel"):setString(global_trans_number(fight_capacity_manager:getArrayFightCapacity({
		arg_37_1[arg_37_2]
	}, nil, arg_37_1, nil, self.mode)))

	local var_37_12 = ccui.Helper:seekWidgetByName(var_37_0, "Image_fightCapacityIcon")

	var_37_12:setPositionX(ccui.Helper:seekWidgetByName(var_37_0, "fightCapacityLabel"):getPositionX() - ccui.Helper:seekWidgetByName(var_37_0, "fightCapacityLabel"):getContentSize().width - var_37_12:getContentSize().width / 2)

	if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[arg_37_2]) then
		ccui.Helper:seekWidgetByName(var_37_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_37_2):loadTexture("Array/servant_lock.png", var_0_24)
		ccui.Helper:seekWidgetByName(var_37_0, "Panel_servant"):getChildByName("servant_add_img_" .. arg_37_2):setVisible(false)
		ccui.Helper:seekWidgetByName(var_37_0, "Image_attrMatch_" .. arg_37_2):loadTexture("Array/attr_non.png", var_0_24)

		local var_37_13 = ccui.Helper:seekWidgetByName(var_37_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_37_2)

		if not var_37_13:getChildByName("label1") then
			local var_37_14 = cc.Label:createWithTTF(L_TEAM_TIPS.Lock, FONT_DES, 20)

			var_37_14:setPosition(cc.p(var_37_13:getContentSize().width / 2, 60))
			var_37_14:setAnchorPoint(cc.p(0.5, 0.5))
			var_37_14:setColor(cc.c3b(175, 191, 195))
			var_37_14:setName("label1")
			var_37_13:addChild(var_37_14)

			local var_37_15 = cc.Label:createWithTTF(level_manager:formatModeChapterLevelByPlayerLevel(BATTLEARRAY_SOUL_UNLOCK[arg_37_2]), FONT_DES, 20)

			var_37_15:setAnchorPoint(cc.p(0.5, 0.5))
			var_37_15:setPosition(cc.p(var_37_14:getPositionX(), var_37_14:getPositionY() - var_37_15:getContentSize().height))
			var_37_15:setColor(cc.c3b(255, 211, 115))
			var_37_13:addChild(var_37_15)
		end
	end

	if not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_37_2]) then
		ccui.Helper:seekWidgetByName(var_37_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_37_2):loadTexture("Array/horcrux_lock.png", var_0_24)
		ccui.Helper:seekWidgetByName(var_37_0, "Image_attrMatch_" .. arg_37_2):loadTexture("Array/attr_non.png", var_0_24)

		local var_37_16 = ccui.Helper:seekWidgetByName(var_37_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_37_2)

		if not var_37_16:getChildByName("label1") then
			local var_37_17 = cc.Label:createWithTTF(L_TEAM_TIPS.Lock, FONT_DES, 20)

			var_37_17:setPosition(cc.p(var_37_16:getContentSize().width / 2, 60))
			var_37_17:setAnchorPoint(cc.p(0.5, 0.5))
			var_37_17:setColor(cc.c3b(175, 191, 195))
			var_37_17:setName("label1")
			var_37_16:addChild(var_37_17)

			local var_37_18 = cc.Label:createWithTTF(level_manager:formatModeChapterLevelByPlayerLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_37_2]), FONT_DES, 20)

			var_37_18:setAnchorPoint(cc.p(0.5, 0.5))
			var_37_18:setPosition(cc.p(var_37_17:getPositionX(), var_37_17:getPositionY() - var_37_18:getContentSize().height))
			var_37_18:setColor(cc.c3b(255, 211, 115))
			var_37_16:addChild(var_37_18)
		end
	end

	local var_37_19 = component_manager:getSoulComponentlist(var_37_1)
	local var_37_20 = {
		68,
		50,
		32
	}

	for iter_37_0 = 1, 3 do
		if not playermodel.component[var_37_1] or not playermodel.component[var_37_1][iter_37_0] then
			ccui.Helper:seekWidgetByName(var_37_0, "Panel_component"):getChildByName("Image_add_" .. iter_37_0):setVisible(true)
			ccui.Helper:seekWidgetByName(var_37_0, "Panel_component"):getChildByName("Image_component_" .. iter_37_0):setVisible(false)
		else
			ccui.Helper:seekWidgetByName(var_37_0, "Panel_component"):getChildByName("Image_add_" .. iter_37_0):setVisible(false)
			ccui.Helper:seekWidgetByName(var_37_0, "Panel_component"):getChildByName("Image_component_" .. iter_37_0):setVisible(true)
			ccui.Helper:seekWidgetByName(var_37_0, "Panel_component"):getChildByName("Image_component_" .. iter_37_0):loadTexture(item_data[playermodel.items[playermodel.component[var_37_1][iter_37_0].id].itemid].main_attr and "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_37_1][iter_37_0].id].component_attr.effect].image_id .. "_" .. item_data[playermodel.items[playermodel.component[var_37_1][iter_37_0].id].itemid].main_attr .. "_" .. iter_37_0 .. ".png" or "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_37_1][iter_37_0].id].component_attr.effect].image_id .. "_" .. playermodel.items[playermodel.component[var_37_1][iter_37_0].id].component_attr.attr1 .. "_" .. iter_37_0 .. ".png")

			if var_37_19.effect then
				ccui.Helper:seekWidgetByName(var_37_0, "Panel_component"):getChildByName("Image_component_" .. iter_37_0):setPositionY(var_37_20[2])
			else
				ccui.Helper:seekWidgetByName(var_37_0, "Panel_component"):getChildByName("Image_component_" .. iter_37_0):setPositionY(var_37_20[iter_37_0])
			end
		end
	end

	ccui.Helper:seekWidgetByName(var_37_0, "Image_component_bg"):addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_37_1 then
			return
		end

		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			cursoul = var_37_1,
			exitCallback = function(...)
				if self.updateAllCell then
					self:updateAllCell()
				end
			end
		})
	end)
end

function SubstitutionArrayLayer:updateSubSlot(arg_40_1, arg_40_2)
	local var_40_0 = self.slotList[arg_40_2]
	local var_40_1

	if arg_40_1[arg_40_2] then
		var_40_1 = arg_40_1[arg_40_2].servantid or nil

		local var_40_2

		if arg_40_1[arg_40_2] and arg_40_1[arg_40_2].horcrux then
			var_40_2 = arg_40_1[arg_40_2].horcrux.itemid or nil
		end
	end

	var_40_0.servantid = var_40_1
	var_40_0.horcruxid = var_40_2
	var_40_0.skill1id = nil
	var_40_0.skill2id = nil

	local var_40_3 = ccui.Helper:seekWidgetByName(var_40_0, "girlSprite")

	if var_40_1 then
		var_40_3:updateSub(arg_40_1[arg_40_2])
		var_40_3:setVisible(true)
	else
		var_40_3:setVisible(false)
	end

	local var_40_4 = ccui.Helper:seekWidgetByName(var_40_0, "horcruxSprite")

	if var_40_2 then
		var_40_4:updateSub(arg_40_1[arg_40_2].horcrux)
		var_40_4:setVisible(true)
	else
		var_40_4:setVisible(false)
	end

	if var_40_2 then
		local var_40_5 = self:getAttrIconPath(var_40_1)
		local var_40_6 = self:getAttrIconPath(var_40_2)
		local var_40_7 = horcrux_manager:getSubHorcruxAssistConfigWithServant(arg_40_1[arg_40_2].horcrux, arg_40_1[arg_40_2].servantrank)

		var_40_0.skill1id = var_40_7.skills[1]
		var_40_0.skill2id = var_40_7.skills[2]

		if var_40_5 == var_40_6 then
			ccui.Helper:seekWidgetByName(var_40_0, "Image_attrMatch_" .. arg_40_2):loadTexture("Array/attr_" .. var_40_5 .. ".png", var_0_24)
		elseif var_40_5 == "imaginary" then
			ccui.Helper:seekWidgetByName(var_40_0, "Image_attrMatch_" .. arg_40_2):loadTexture("Array/frame_add_attribute_half.png", var_0_24)
		else
			ccui.Helper:seekWidgetByName(var_40_0, "Image_attrMatch_" .. arg_40_2):loadTexture("Array/frame_add_attribute_half.png", var_0_24)
		end

		local var_40_8 = horcrux_manager:getServantAttrAddPercent(var_40_6, global_get_all_servant_attrs(var_40_1))

		ccui.Helper:seekWidgetByName(var_40_0, "Label_damageAdd"):setString(L_TEAM_ATTR.Attack .. global_trans_number(math.floor(var_40_7.damage * var_40_8.damage)))
		ccui.Helper:seekWidgetByName(var_40_0, "Label_hpAdd"):setString(L_TEAM_ATTR.Blood .. global_trans_number(math.floor(var_40_7.hp * var_40_8.hp)))
	else
		ccui.Helper:seekWidgetByName(var_40_0, "Image_attrMatch_" .. arg_40_2):loadTexture("Array/attr_non.png", var_0_24)
	end

	ccui.Helper:seekWidgetByName(var_40_0, "Label_damageAdd"):setVisible(var_40_2 ~= nil)
	ccui.Helper:seekWidgetByName(var_40_0, "Label_hpAdd"):setVisible(var_40_2 ~= nil)
	ccui.Helper:seekWidgetByName(var_40_0, "fightCapacityLabel"):setVisible(var_40_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_40_0, "Image_fightCapacityIcon"):setVisible(var_40_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_40_0, "Panel_component"):setVisible(var_40_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_40_0, "Panel_fightpower"):setVisible(var_40_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_40_0, "Panel_servant"):getChildByName("servant_add_img_" .. arg_40_2):setVisible(var_40_1 == nil)
	ccui.Helper:seekWidgetByName(var_40_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_40_2):setOpacity(var_40_1 == nil and 255 or 0)
	ccui.Helper:seekWidgetByName(var_40_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_40_2):setOpacity(var_40_2 == nil and 255 or 0)

	if arg_40_1[arg_40_2] then
		ccui.Helper:seekWidgetByName(var_40_0, "fightCapacityLabel"):setString(global_trans_number((fight_capacity_manager:getSubUsingFightCapacity(arg_40_1[arg_40_2]))))

		local var_40_9 = ccui.Helper:seekWidgetByName(var_40_0, "Image_fightCapacityIcon")

		var_40_9:setPositionX(ccui.Helper:seekWidgetByName(var_40_0, "fightCapacityLabel"):getPositionX() - ccui.Helper:seekWidgetByName(var_40_0, "fightCapacityLabel"):getContentSize().width - var_40_9:getContentSize().width / 2)
	end

	if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[arg_40_2]) then
		ccui.Helper:seekWidgetByName(var_40_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_40_2):loadTexture("Array/servant_lock.png", var_0_24)
		ccui.Helper:seekWidgetByName(var_40_0, "Panel_servant"):getChildByName("servant_add_img_" .. arg_40_2):setVisible(false)
		ccui.Helper:seekWidgetByName(var_40_0, "Image_attrMatch_" .. arg_40_2):loadTexture("Array/attr_non.png", var_0_24)

		local var_40_10 = ccui.Helper:seekWidgetByName(var_40_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_40_2)

		if not var_40_10:getChildByName("label1") then
			local var_40_11 = cc.Label:createWithTTF(L_TEAM_TIPS.Lock, FONT_DES, 20)

			var_40_11:setPosition(cc.p(var_40_10:getContentSize().width / 2, 60))
			var_40_11:setAnchorPoint(cc.p(0.5, 0.5))
			var_40_11:setColor(cc.c3b(175, 191, 195))
			var_40_11:setName("label1")
			var_40_10:addChild(var_40_11)

			local var_40_12 = cc.Label:createWithTTF(level_manager:formatModeChapterLevelByPlayerLevel(BATTLEARRAY_SOUL_UNLOCK[arg_40_2]), FONT_DES, 20)

			var_40_12:setAnchorPoint(cc.p(0.5, 0.5))
			var_40_12:setPosition(cc.p(var_40_11:getPositionX(), var_40_11:getPositionY() - var_40_12:getContentSize().height))
			var_40_12:setColor(cc.c3b(255, 211, 115))
			var_40_10:addChild(var_40_12)
		end
	end

	if not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_40_2]) then
		ccui.Helper:seekWidgetByName(var_40_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_40_2):loadTexture("Array/horcrux_lock.png", var_0_24)
		ccui.Helper:seekWidgetByName(var_40_0, "Image_attrMatch_" .. arg_40_2):loadTexture("Array/attr_non.png", var_0_24)

		local var_40_13 = ccui.Helper:seekWidgetByName(var_40_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_40_2)

		if not var_40_13:getChildByName("label1") then
			local var_40_14 = cc.Label:createWithTTF(L_TEAM_TIPS.Lock, FONT_DES, 20)

			var_40_14:setPosition(cc.p(var_40_13:getContentSize().width / 2, 60))
			var_40_14:setAnchorPoint(cc.p(0.5, 0.5))
			var_40_14:setColor(cc.c3b(175, 191, 195))
			var_40_14:setName("label1")
			var_40_13:addChild(var_40_14)

			local var_40_15 = cc.Label:createWithTTF(level_manager:formatModeChapterLevelByPlayerLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_40_2]), FONT_DES, 20)

			var_40_15:setAnchorPoint(cc.p(0.5, 0.5))
			var_40_15:setPosition(cc.p(var_40_14:getPositionX(), var_40_14:getPositionY() - var_40_15:getContentSize().height))
			var_40_15:setColor(cc.c3b(255, 211, 115))
			var_40_13:addChild(var_40_15)
		end
	end

	local var_40_16 = component_manager:getSoulComponentlist(var_40_1)
	local var_40_17 = {
		68,
		50,
		32
	}

	for iter_40_0 = 1, 3 do
		if not playermodel.component[var_40_1] or not playermodel.component[var_40_1][iter_40_0] then
			ccui.Helper:seekWidgetByName(var_40_0, "Panel_component"):getChildByName("Image_add_" .. iter_40_0):setVisible(true)
			ccui.Helper:seekWidgetByName(var_40_0, "Panel_component"):getChildByName("Image_component_" .. iter_40_0):setVisible(false)
		else
			ccui.Helper:seekWidgetByName(var_40_0, "Panel_component"):getChildByName("Image_add_" .. iter_40_0):setVisible(false)
			ccui.Helper:seekWidgetByName(var_40_0, "Panel_component"):getChildByName("Image_component_" .. iter_40_0):setVisible(true)
			ccui.Helper:seekWidgetByName(var_40_0, "Panel_component"):getChildByName("Image_component_" .. iter_40_0):loadTexture(item_data[playermodel.items[playermodel.component[var_40_1][iter_40_0].id].itemid].main_attr and "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_40_1][iter_40_0].id].component_attr.effect].image_id .. "_" .. item_data[playermodel.items[playermodel.component[var_40_1][iter_40_0].id].itemid].main_attr .. "_" .. iter_40_0 .. ".png" or "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_40_1][iter_40_0].id].component_attr.effect].image_id .. "_" .. playermodel.items[playermodel.component[var_40_1][iter_40_0].id].component_attr.attr1 .. "_" .. iter_40_0 .. ".png")

			if var_40_16.effect then
				ccui.Helper:seekWidgetByName(var_40_0, "Panel_component"):getChildByName("Image_component_" .. iter_40_0):setPositionY(var_40_17[2])
			else
				ccui.Helper:seekWidgetByName(var_40_0, "Panel_component"):getChildByName("Image_component_" .. iter_40_0):setPositionY(var_40_17[iter_40_0])
			end
		end
	end

	ccui.Helper:seekWidgetByName(var_40_0, "Image_component_bg"):addTouchEventListener(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_40_1 then
			return
		end

		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			cursoul = var_40_1,
			exitCallback = function(...)
				if self.updateAllCell then
					self:updateAllCell()
				end
			end
		})
	end)
end

function SubstitutionArrayLayer:exit()
	if self.configexitCallback then
		self.configexitCallback()
	end

	self.rootLayer:getChildByName("Panel_Pop"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
		LayerManager:removePopLayer()
		array_manager:executeHangupArrayChange()

		self.active = false
	end)))
end

function SubstitutionArrayLayer:saveInitArrayInfo()
	self.initArrayInfo = {}

	local var_45_0 = substitution_manager:getUsingArraysData(self.curSelectArrayId)

	if var_45_0 then
		for iter_45_0 = 1, 4 do
			self.initArrayInfo[#self.initArrayInfo + 1] = var_45_0[iter_45_0].fight_girl
			self.initArrayInfo[#self.initArrayInfo + 1] = var_45_0[iter_45_0].assist_girl
		end
	end
end

function SubstitutionArrayLayer:checkArrayInfo()
	local var_46_0 = substitution_manager:getUsingArraysData(self.curSelectArrayId)
	local var_46_1 = {}

	for iter_46_0 = 1, 4 do
		var_46_1[#var_46_1 + 1] = var_46_0[iter_46_0].fight_girl
		var_46_1[#var_46_1 + 1] = var_46_0[iter_46_0].assist_girl
	end

	for iter_46_1 = 1, (#self.initArrayInfo > #var_46_1 or nil) and (#self.initArrayInfo or #var_46_1) do
		if self.initArrayInfo[iter_46_1] ~= var_46_1[iter_46_1] then
			return false
		end
	end

	return true
end

function SubstitutionArrayLayer:btnSureEvent(arg_47_1)
	if not self.arraydata or not self.arraydata["array_" .. self.curSelectArrayId] then
		-- block empty
	else
		global_ShowBlockWords(L_SUBSTITUTION_ARRAY_UP)

		if arg_47_1 then
			arg_47_1()
		end

		return
	end

	substitution_manager:switch_to_substitution(self.mode, self.level, self.curSelectArrayId, function(arg_48_0)
		if arg_48_0 == 1 then
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			self:exit()

			if self.configCallback then
				self.configCallback()
			end

			array_manager:executeHangupArrayChange()
		elseif arg_48_0 == 2 then
			global_ShowBlockWords(L_SUBSTITUTION_ARRAY_LEVEL_OPEN)
		elseif arg_48_0 == 3 then
			global_ShowBlockWords(L_SUBSTITUTION_ARRAY_LEVEL_LOCK)
		elseif arg_48_0 == 4 then
			global_ShowBlockWords(L_SUBSTITUTION_ARRAY_ROLE_NUM)
		elseif arg_48_0 == 5 then
			global_ShowBlockWords(L_SUBSTITUTION_INVALID)
		end

		if arg_47_1 then
			arg_47_1()
		end
	end)
end

function SubstitutionArrayLayer:changeRole(arg_49_1)
	if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[4 - arg_49_1]) then
		global_ShowBlockWords(L_Change_ARRAY_WARNING.Unlock)
		audio_manager:playeffectMusicTest("sound/invalid")

		return
	end

	local var_49_0 = substitution_manager:getUsingArraysData(self.curSelectArrayId)

	LayerManager:pushInLayer("GirlSelectLayer", {
		selectType = SELECT_GIRL_SUBSTITUTION,
		cursoul = var_49_0[4 - arg_49_1].fight_girl,
		arrayinfo = {
			index = self.curSelectArrayId,
			pos = 4 - arg_49_1
		},
		sureCallBack = function(arg_50_0)
			self:playChangeRoleSound(4 - arg_49_1, cursoul)
			self:updateAllCell()
			self:updateArrayFightCapacity()
			self:initArrayFightCapacity()

			if substitution_manager:getUsingArraysData(self.curSelectArrayId)[4 - arg_49_1].fight_girl then
				audio_manager:playeffectMusicTest("sound/dispatch")
			end
		end
	})
end

function SubstitutionArrayLayer:changeAssistGirl(arg_51_1, arg_51_2)
	if not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_51_1]) then
		global_ShowBlockWords(L_Change_ARRAY_WARNING.Unlock)
		audio_manager:playeffectMusicTest("sound/invalid")

		return
	end

	local var_51_0 = substitution_manager:getUsingArraysData(self.curSelectArrayId)
	local var_51_1 = SELECT_HORCRUX_SUBSTITUTION

	if not var_51_0[arg_51_1].fight_girl then
		global_ShowBlockWords(L_Change_ARRAY_WARNING.Role_Nil)
		audio_manager:playeffectMusicTest("sound/invalid")

		return
	end

	local var_51_2 = {}

	for iter_51_0 = 1, 4 do
		if var_51_0[iter_51_0].assist_girl then
			table.insert(var_51_2, var_51_0[iter_51_0].assist_girl)
		end
	end

	local var_51_3 = var_51_0[arg_51_1].assist_girl and self:getAttrIconPath(playermodel.items[var_51_0[arg_51_1].assist_girl].itemid) or self:getAttrIconPath(var_51_0[arg_51_1].fight_girl)

	local function var_51_4()
		local var_52_0 = ccui.Helper:seekWidgetByName(arg_51_2, "scale_layer")
		local var_52_1 = var_52_0:clone()

		var_52_0:setVisible(false)
		var_52_1:setOpacity(0)
		var_52_1:setPosition(cc.p(var_52_0:getPositionX(), var_52_0:getPositionY() + 100))
		var_52_0:getParent():addChild(var_52_1)
		var_52_1:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.3), (cc.EaseIn:create(cc.MoveBy:create(0.3, cc.p(0, -100)), 2.5))), cc.CallFunc:create(function()
			var_52_0:setVisible(true)
		end), cc.Spawn:create(cc.ScaleTo:create(0.5, var_52_0:getScale() * 2), cc.FadeOut:create(0.5)), (cc.CallFunc:create(function()
			var_52_1:removeFromParent()
		end))))
	end

	LayerManager:pushInLayer("HorcruxSelectLayer", {
		selectType = var_51_1,
		selectParam = {
			outSide = var_51_2
		},
		arrayIndex = self.curSelectArrayId,
		arrayPos = arg_51_1,
		curHorcrux = var_51_0[arg_51_1].assist_girl,
		defaultAttr = var_51_3,
		selectCallback = function()
			self.patrolingArrayTimer = patrol_manager:getPatrolingArray()

			self:updateAllCell()
			self:updateArrayFightCapacity(nil, 1, var_51_4)
			self:initArrayFightCapacity()

			local var_55_0 = substitution_manager:getUsingArraysData(self.curSelectArrayId)

			if var_55_0[arg_51_1].fight_girl and var_55_0[arg_51_1].assist_girl then
				audio_manager:playeffectMusicTest("sound/dispatch")
			end
		end
	})
end

function SubstitutionArrayLayer:playChangeRoleSound(arg_56_1, arg_56_2)
	local var_56_0 = substitution_manager:getUsingArraysData(self.curSelectArrayId)[arg_56_1].fight_girl

	if not var_56_0 then
		return
	end

	GlobalPlayRoleSound(global_get_servant_skin(var_56_0), ROLE_SOUND_TYPE.fight)
end
