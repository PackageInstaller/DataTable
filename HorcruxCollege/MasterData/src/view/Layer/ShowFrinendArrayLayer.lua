ShowFrinendArrayLayer = class("ShowFrinendArrayLayer", function()
	return BattleArrayLayerNew:create_by_child()
end)

local friend_system_manager = require("controller.friend_system_manager")
local playermodel = require("model.playermodel")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local horcrux_data = require("data.horcrux_data")
local item_data = require("data.item_data")
local total_skill_data = require("data.total_skill_data")
local servant_data = require("data.servant_data")
local chapter_data = require("data.chapter_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
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
local var_0_21 = config._DEBUG and 0 or 1

function ShowFrinendArrayLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ShowFrinendArrayLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function ShowFrinendArrayLayer:initArrayFightCapacity()
	self.fightCapacityLabel:setString((global_trans_number((friend_system_manager:getFrindArrayCapacityData(self.infotype, self.curSelectArrayId)))))
end

function ShowFrinendArrayLayer.selectArray(arg_4_0)
	return
end

function ShowFrinendArrayLayer:init(arg_5_1)
	battlearraylayerInstance = self
	self.size = cc.Director:getInstance():getVisibleSize()
	self.enemyid = arg_5_1.enemyid
	self.mode = arg_5_1.mode
	self.level = arg_5_1.level
	self.arraydata = arg_5_1.arraydata
	self.infotype = arg_5_1.infotype or 4
	self.initconfig = arg_5_1

	if arg_5_1 then
		self.configType = arg_5_1.configtype or CONFIG_TYPE_NORMAL
	end

	self.configCallback = arg_5_1 and arg_5_1.configcallback
	self.configMode = arg_5_1 and arg_5_1.initmode
	self.configexitCallback = arg_5_1 and arg_5_1.exitcallback

	if arg_5_1 then
		self.curSelectArrayId = arg_5_1.initindex or 1
	end

	self.cancelcallback = arg_5_1.cancelcallback

	LayerManager:createFullScreenMask(self, 0, function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
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

	local var_5_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn")
	local var_5_1 = cc.Label:createWithTTF("", FONT_BUTTON, 30)

	var_5_1:setName("label_btn")
	var_5_1:setColor(cc.c3b(0, 0, 0))
	var_5_0:addChild(var_5_1, 999)

	self.timerLabel = cc.Label:createWithTTF("00:00:00", FONT_NAME, 24)

	self.timerLabel:setVisible(false)
	self.timerLabel:setPosition(320, 225)
	self.rootLayer:addChild(self.timerLabel)

	local var_5_2 = ccui.ImageView:create("Array/effect_fight_btn_get_award.png", var_0_21)

	var_5_2:setName("effect")
	var_5_2:setVisible(false)
	var_5_2:setContentSize(var_5_0:getContentSize().width, var_5_0:getContentSize().height)
	var_5_2:setPosition(var_5_0:getContentSize().width / 2, var_5_0:getContentSize().height / 2)
	var_5_0:addChild(var_5_2)
	var_5_2:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(1), cc.FadeIn:create(1))))

	self.quick_patrol_bnt = ccui.Button:create("Array/finish_quick.png", nil, "Array/finish_quick.png", var_0_21)

	self.quick_patrol_bnt:setAnchorPoint(cc.p(0, 0.5))
	self.quick_patrol_bnt:setVisible(false)
	self.quick_patrol_bnt:setPositionX(self.timerLabel:getPositionX() + self.timerLabel:getContentSize().width / 2)
	self.quick_patrol_bnt:setPositionY(self.timerLabel:getPositionY())
	self.rootLayer:addChild(self.quick_patrol_bnt)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_arrayStatus"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		arg_7_0:setBright(false)
	end)
	self.rootLayer:getChildByName("Panel_Pop"):setScaleY(0)
	self.rootLayer:getChildByName("Panel_Pop"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1.1), cc.ScaleTo:create(0.05, 1, 1), cc.CallFunc:create(function()
		self:updateGuidesOnLayer()
	end)))
	self.rootLayer:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.cancelcallback then
			self.cancelcallback()
		end

		self:exit()
	end)
	self:initArrayListPanel()
	self:updateArrayListPanel()
	self:initUI()
	self:updateAllCell()
	self:initArrayFightCapacity()
	self:registerUpdateUI()
	self:registerScriptHandler(function(arg_11_0)
		if arg_11_0 == "exit" then
			battlearraylayerInstance = nil
		end
	end)
end

function ShowFrinendArrayLayer:registerUpdateUI()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("ShowFrinendArrayLayerEvent", function(arg_13_0)
		self:updateAllCell()
		self:updateUI()
	end), self)
end

function ShowFrinendArrayLayer:initArrayListPanel()
	self.arrayListView = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_arrayList")
	self.btnList = {}

	local var_14_2 = (function()
		local var_15_0 = {}

		if self.infotype == 4 then
			local var_15_1 = 1

			while self.arraydata["array_" .. var_15_1] do
				var_15_1 = var_15_1 + 1
			end

			for iter_15_0 = 1, var_15_1 - 1 do
				table.insert(var_15_0, iter_15_0)
			end

			return var_15_0
		elseif self.infotype == 3 then
			var_15_0 = {
				1,
				2,
				3
			}
		elseif self.infotype == 2 then
			var_15_0 = {
				1
			}
		end

		return var_15_0
	end)()

	self.leftBtnListCount = #nil

	local var_14_3 = {}

	for iter_14_0 = 1, self.leftBtnListCount do
		var_14_3[iter_14_0] = L_TEAM_TIPS.Team .. (var_14_2[iter_14_0] or "+")
	end

	if #nil ~= MAX_ARRAY_COUNT then
		var_14_3[#var_14_3] = L_TEAM_TIPS.Team .. "+"
	end

	for iter_14_1, iter_14_2 in pairs(var_14_3) do
		local var_14_6 = self:createArrayIndexBtn(var_14_2[iter_14_1] or "+")

		var_14_6:setName("array_index_" .. (var_14_2[iter_14_1] or "+"))
		table.insert(self.btnList, var_14_6)
		self.arrayListView:pushBackCustomItem(var_14_6)
	end
end

function ShowFrinendArrayLayer.createArrayIndexBtn(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1 == "+" and ccui.ImageView:create("public/button/array_inde_btn_add.png", var_0_21) or ccui.ImageView:create("public/button/array_index_btn.png", var_0_21)

	var_16_0:setTouchEnabled(true)

	var_16_0.index = arg_16_1

	var_16_0:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_17_0.index == "+" then
			arg_16_0:addArray()

			return
		end

		arg_16_0.curSelectArrayId = arg_17_0.index

		arg_16_0:updateAllCell()
		arg_16_0:initArrayFightCapacity()
		arg_16_0:updateArrayListPanel()
		arg_16_0:updateSureBtn()
	end)

	local var_16_1 = cc.Label:createWithTTF(arg_16_1, FONT_NAME, 28)

	var_16_1:setColor(cc.c3b(208, 233, 247))
	var_16_1:setName("label")
	var_16_1:setPositionX(var_16_0:getContentSize().width / 2)
	var_16_1:setPositionY(var_16_0:getContentSize().height / 2)
	var_16_0:addChild(var_16_1)

	return var_16_0
end

function ShowFrinendArrayLayer.updateSureBtn(arg_18_0)
	return
end

function ShowFrinendArrayLayer:lockRoleChange()
	for iter_19_0, iter_19_1 in pairs(self.slotList) do
		local var_19_0 = ccui.Helper:seekWidgetByName(self.slotList[iter_19_0], "Panel_servant_lock")
		local var_19_1 = ccui.Helper:seekWidgetByName(self.slotList[iter_19_0], "Panel_horcrux_lock")

		var_19_0:setVisible(true)
		var_19_1:setVisible(true)
	end

	self:initLockChange()
end

function ShowFrinendArrayLayer:initLockChange()
	for iter_20_0, iter_20_1 in pairs(self.slotList) do
		local var_20_0 = ccui.Helper:seekWidgetByName(self.slotList[iter_20_0], "Panel_servant_lock")
		local var_20_1 = ccui.Helper:seekWidgetByName(self.slotList[iter_20_0], "Panel_horcrux_lock")
	end
end

function ShowFrinendArrayLayer:initUI()
	self:updateTitle()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_33"):setString(TIPS_DES)
	;(function()
		local var_22_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_fightCapacitySumIcon")

		self.fightCapacityLabel = ccui.TextBMFont:create(1, "fonts/array_fightcapacity_number.fnt")

		self.fightCapacityLabel:setPositionX(var_22_0:getPositionX() + var_22_0:getContentSize().width / 2)
		self.fightCapacityLabel:setPositionY(var_22_0:getPositionY())
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

	local var_21_0 = {
		"Array/1st.png",
		"Array/2nd.png",
		"Array/3rd.png",
		"Array/4th.png"
	}

	self:updateSureBtn()

	for iter_21_0, iter_21_1 in pairs(self.slotList) do
		ccui.Helper:seekWidgetByName(self.slotList[iter_21_0], "Image_slotIndex"):loadTexture(var_21_0[iter_21_0], var_0_21)

		local var_21_1 = GirlSprite:create({
			initType = "subArrayStyle"
		})

		var_21_1:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant"):getContentSize().width / 2)
		var_21_1:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant"):getContentSize().height / 2)
		var_21_1:setName("girlSprite")
		var_21_1:setTouchEnabled(false)
		ccui.Helper:seekWidgetByName(self.slotList[iter_21_0], "Panel_servant"):addChild(var_21_1, 10)

		local var_21_2 = HorcruxSprite:create({
			initType = "arrayMemberStyle"
		})

		var_21_2:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_horcrux"):getContentSize().width / 2 - 10)
		var_21_2:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_horcrux"):getContentSize().height / 2)
		var_21_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_21_2:setName("horcruxSprite")
		var_21_2:setTouchEnabled(false)
		var_21_2:setScale(0.8)
		ccui.Helper:seekWidgetByName(self.slotList[iter_21_0], "Panel_horcrux"):addChild(var_21_2, 10)
		iter_21_1:getChildByName("Panel_servant"):getChildByName("Image_add"):setName("servant_add_img_" .. iter_21_0)
		iter_21_1:getChildByName("Panel_servant"):getChildByName("Image_bg"):setName("servant_bg_img_" .. iter_21_0)
		iter_21_1:getChildByName("Panel_horcrux"):getChildByName("Image_bg"):setName("horcrux_bg_img_" .. iter_21_0)
		iter_21_1:getChildByName("Panel_horcrux"):getChildByName("Image_skill1"):addTouchEventListener(function(arg_23_0, arg_23_1)
			if arg_23_1 == ccui.TouchEventType.began then
				var_21_2:showSkillPanel(iter_21_1.skill1id)
			elseif arg_23_1 == ccui.TouchEventType.canceled then
				var_21_2:hideSkillPanel()
			elseif arg_23_1 == ccui.TouchEventType.ended then
				var_21_2:hideSkillPanel()
			end
		end)
		iter_21_1:getChildByName("Panel_horcrux"):getChildByName("Image_skill2"):addTouchEventListener(function(arg_24_0, arg_24_1)
			if arg_24_1 == ccui.TouchEventType.began then
				var_21_2:showSkillPanel(iter_21_1.skill2id)
			elseif arg_24_1 == ccui.TouchEventType.canceled then
				var_21_2:hideSkillPanel()
			elseif arg_24_1 == ccui.TouchEventType.ended then
				var_21_2:hideSkillPanel()
			end
		end)
	end
end

function ShowFrinendArrayLayer:updateAllCell()
	local var_25_1 = friend_system_manager:getFrindArraysData(self.infotype, self.curSelectArrayId)
	local var_25_2 = friend_system_manager:getLockList()

	for iter_25_0 = 1, 4 do
		self:updateSubSlot(var_25_1, iter_25_0)
	end
end

function ShowFrinendArrayLayer:updateSubSlot(arg_26_1, arg_26_2)
	local var_26_0 = self.slotList[arg_26_2]
	local var_26_1
	local var_26_2

	if self.infotype == 4 or self.infotype == 3 or self.infotype == 2 then
		var_26_1 = arg_26_1[arg_26_2] and arg_26_1[arg_26_2].servantid or nil
		var_26_2 = arg_26_1[arg_26_2] and arg_26_1[arg_26_2].horcrux and arg_26_1[arg_26_2].horcrux.itemid or nil
	elseif self.infotype == 1 then
		-- block empty
	end

	var_26_0.servantid = var_26_1
	var_26_0.horcruxid = var_26_2
	var_26_0.skill1id = nil
	var_26_0.skill2id = nil

	local var_26_3 = ccui.Helper:seekWidgetByName(var_26_0, "girlSprite")

	if var_26_1 then
		var_26_3:updateSub(arg_26_1[arg_26_2])
		var_26_3:setVisible(true)
	else
		var_26_3:setVisible(false)
	end

	local var_26_4 = ccui.Helper:seekWidgetByName(var_26_0, "horcruxSprite")

	if var_26_2 then
		if self.infotype == 1 then
			-- block empty
		elseif self.infotype == 4 or self.infotype == 3 or self.infotype == 2 then
			var_26_4:updateSub(arg_26_1[arg_26_2].horcrux)
		end

		var_26_4:setVisible(true)
	else
		var_26_4:setVisible(false)
	end

	if var_26_2 then
		local var_26_5 = self:getAttrIconPath(var_26_1)
		local var_26_6 = self:getAttrIconPath(var_26_2)

		if self.infotype == 1 then
			-- block empty
		else
			rank = arg_26_1[arg_26_2].servantrank
		end

		if self.infotype ~= 2 then
			local var_26_7 = horcrux_manager:getSubHorcruxAssistConfigWithServant(arg_26_1[arg_26_2].horcrux, rank)

			var_26_0.skill1id = var_26_7.skills[1]
			var_26_0.skill2id = var_26_7.skills[2]

			if var_26_5 == var_26_6 then
				ccui.Helper:seekWidgetByName(var_26_0, "Image_attrMatch_" .. arg_26_2):loadTexture("Array/attr_" .. var_26_5 .. ".png", var_0_21)
				ccui.Helper:seekWidgetByName(var_26_0, "Label_damageAdd"):setString(L_TEAM_ATTR.Attack .. global_trans_number(math.floor(var_26_7.damage) * 2))
				ccui.Helper:seekWidgetByName(var_26_0, "Label_hpAdd"):setString(L_TEAM_ATTR.Blood .. global_trans_number(math.floor(var_26_7.hp) * 2))
			elseif var_26_5 == "imaginary" then
				ccui.Helper:seekWidgetByName(var_26_0, "Image_attrMatch_" .. arg_26_2):loadTexture("Array/frame_add_attribute_half.png", var_0_21)
				ccui.Helper:seekWidgetByName(var_26_0, "Label_damageAdd"):setString(L_TEAM_ATTR.Attack .. global_trans_number(math.floor(var_26_7.damage) * 2))
				ccui.Helper:seekWidgetByName(var_26_0, "Label_hpAdd"):setString(L_TEAM_ATTR.Blood .. global_trans_number(math.floor(var_26_7.hp) * 2))
			else
				ccui.Helper:seekWidgetByName(var_26_0, "Image_attrMatch_" .. arg_26_2):loadTexture("Array/frame_add_attribute_half.png", var_0_21)
				ccui.Helper:seekWidgetByName(var_26_0, "Label_damageAdd"):setString(L_TEAM_ATTR.Attack .. global_trans_number(math.floor(var_26_7.damage)))
				ccui.Helper:seekWidgetByName(var_26_0, "Label_hpAdd"):setString(L_TEAM_ATTR.Blood .. global_trans_number(math.floor(var_26_7.hp)))
			end
		else
			local var_26_8 = arg_26_1[arg_26_2].damage
			local var_26_9 = {}

			while horcrux_data[var_26_2]["skill" .. 1] do
				table.insert(var_26_9, horcrux_data[var_26_2]["skill" .. 1])
			end

			var_26_0.skill1id = var_26_9[1]
			var_26_0.skill2id = var_26_9[2]

			if var_26_5 == var_26_6 then
				ccui.Helper:seekWidgetByName(var_26_0, "Image_attrMatch_" .. arg_26_2):loadTexture("Array/attr_" .. var_26_5 .. ".png", var_0_21)
				ccui.Helper:seekWidgetByName(var_26_0, "Label_damageAdd"):setString(L_TEAM_ATTR.Attack .. global_trans_number(var_26_8))
				ccui.Helper:seekWidgetByName(var_26_0, "Label_hpAdd"):setString(L_TEAM_ATTR.Blood .. global_trans_number(arg_26_1[arg_26_2].hp))
			elseif var_26_5 == "imaginary" then
				ccui.Helper:seekWidgetByName(var_26_0, "Image_attrMatch_" .. arg_26_2):loadTexture("Array/frame_add_attribute_half.png", var_0_21)
				ccui.Helper:seekWidgetByName(var_26_0, "Label_damageAdd"):setString(L_TEAM_ATTR.Attack .. global_trans_number(var_26_8))
				ccui.Helper:seekWidgetByName(var_26_0, "Label_hpAdd"):setString(L_TEAM_ATTR.Blood .. global_trans_number(arg_26_1[arg_26_2].hp))
			else
				ccui.Helper:seekWidgetByName(var_26_0, "Image_attrMatch_" .. arg_26_2):loadTexture("Array/frame_add_attribute_half.png", var_0_21)
				ccui.Helper:seekWidgetByName(var_26_0, "Label_damageAdd"):setString(L_TEAM_ATTR.Attack .. global_trans_number(var_26_8))
				ccui.Helper:seekWidgetByName(var_26_0, "Label_hpAdd"):setString(L_TEAM_ATTR.Blood .. global_trans_number(arg_26_1[arg_26_2].hp))
			end
		end
	else
		ccui.Helper:seekWidgetByName(var_26_0, "Image_attrMatch_" .. arg_26_2):loadTexture("Array/attr_non.png", var_0_21)
	end

	if var_26_0.skill1id then
		var_26_11 = 0 + 1

		ccui.Helper:seekWidgetByName(var_26_0, "Image_skill1"):getChildByName("Image_skillIcon"):loadTexture("skill_new/skill/" .. total_skill_data[var_26_0.skill1id].icon .. ".png", var_0_21)
	end

	if var_26_0.skill2id then
		ccui.Helper:seekWidgetByName(var_26_0, "Image_skill2"):getChildByName("Image_skillIcon"):loadTexture("skill_new/skill/" .. total_skill_data[var_26_0.skill2id].icon .. ".png", var_0_21)
	end

	ccui.Helper:seekWidgetByName(var_26_0, "Image_skill1"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_26_0, "Image_skill2"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_26_0, "Label_damageAdd"):setVisible(var_26_2 ~= nil)
	ccui.Helper:seekWidgetByName(var_26_0, "Label_hpAdd"):setVisible(var_26_2 ~= nil)
	ccui.Helper:seekWidgetByName(var_26_0, "fightCapacityLabel"):setVisible(var_26_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_26_0, "Image_fightCapacityIcon"):setVisible(var_26_1 ~= nil)
	ccui.Helper:seekWidgetByName(var_26_0, "Panel_servant"):getChildByName("servant_add_img_" .. arg_26_2):setVisible(var_26_1 == nil)
	ccui.Helper:seekWidgetByName(var_26_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_26_2):setOpacity(var_26_1 == nil and 255 or 0)
	ccui.Helper:seekWidgetByName(var_26_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_26_2):setOpacity(var_26_2 == nil and 255 or 0)

	local var_26_13 = 0

	if self.infotype == 4 or self.infotype == 3 then
		var_26_13 = arg_26_1[arg_26_2] and fight_capacity_manager:getSubUsingFightCapacity(arg_26_1[arg_26_2]) or 0
	elseif self.infotype == 2 then
		var_26_13 = arg_26_1[arg_26_2].fightpower
	end

	if var_26_13 then
		ccui.Helper:seekWidgetByName(var_26_0, "fightCapacityLabel"):setString(global_trans_number(var_26_13))
	end

	local var_26_14 = ccui.Helper:seekWidgetByName(var_26_0, "Image_fightCapacityIcon")

	var_26_14:setPositionX(ccui.Helper:seekWidgetByName(var_26_0, "fightCapacityLabel"):getPositionX() - ccui.Helper:seekWidgetByName(var_26_0, "fightCapacityLabel"):getContentSize().width - var_26_14:getContentSize().width / 2)

	if not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[arg_26_2]) then
		ccui.Helper:seekWidgetByName(var_26_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_26_2):loadTexture("Array/servant_lock.png", var_0_21)
		ccui.Helper:seekWidgetByName(var_26_0, "Panel_servant"):getChildByName("servant_add_img_" .. arg_26_2):setVisible(false)
		ccui.Helper:seekWidgetByName(var_26_0, "Image_attrMatch_" .. arg_26_2):loadTexture("Array/attr_non.png", var_0_21)

		local var_26_15 = ccui.Helper:seekWidgetByName(var_26_0, "Panel_servant"):getChildByName("servant_bg_img_" .. arg_26_2)

		if not var_26_15:getChildByName("label1") then
			local var_26_16 = cc.Label:createWithTTF(L_TEAM_TIPS.Lock, FONT_DES, 20)

			var_26_16:setPosition(cc.p(var_26_15:getContentSize().width / 2, 60))
			var_26_16:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_16:setColor(cc.c3b(175, 191, 195))
			var_26_16:setName("label1")
			var_26_15:addChild(var_26_16)

			local var_26_17 = cc.Label:createWithTTF(level_manager:formatModeChapterLevelByPlayerLevel(BATTLEARRAY_SOUL_UNLOCK[arg_26_2]), FONT_DES, 20)

			var_26_17:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_17:setPosition(cc.p(var_26_16:getPositionX(), var_26_16:getPositionY() - var_26_17:getContentSize().height))
			var_26_17:setColor(cc.c3b(255, 211, 115))
			var_26_15:addChild(var_26_17)
		end
	end

	if not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_26_2]) then
		ccui.Helper:seekWidgetByName(var_26_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_26_2):loadTexture("Array/horcrux_lock.png", var_0_21)
		ccui.Helper:seekWidgetByName(var_26_0, "Image_attrMatch_" .. arg_26_2):loadTexture("Array/attr_non.png", var_0_21)

		local var_26_18 = ccui.Helper:seekWidgetByName(var_26_0, "Panel_horcrux"):getChildByName("horcrux_bg_img_" .. arg_26_2)

		if not var_26_18:getChildByName("label1") then
			local var_26_19 = cc.Label:createWithTTF(L_TEAM_TIPS.Lock, FONT_DES, 20)

			var_26_19:setPosition(cc.p(var_26_18:getContentSize().width / 2, 60))
			var_26_19:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_19:setColor(cc.c3b(175, 191, 195))
			var_26_19:setName("label1")
			var_26_18:addChild(var_26_19)

			local var_26_20 = cc.Label:createWithTTF(level_manager:formatModeChapterLevelByPlayerLevel(BATTLEARRAY_HORCRUX_UNLOCK[arg_26_2]), FONT_DES, 20)

			var_26_20:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_20:setPosition(cc.p(var_26_19:getPositionX(), var_26_19:getPositionY() - var_26_20:getContentSize().height))
			var_26_20:setColor(cc.c3b(255, 211, 115))
			var_26_18:addChild(var_26_20)
		end
	end
end

function ShowFrinendArrayLayer:exit()
	if self.configexitCallback then
		self.configexitCallback()
	end

	self.rootLayer:getChildByName("Panel_Pop"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
		LayerManager:removePopLayer()
	end)))
end
