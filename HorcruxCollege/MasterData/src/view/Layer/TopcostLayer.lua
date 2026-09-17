TopcostLayer = class("TopcostLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.AvatarSprite")

local playermodel = require("model.playermodel")
local sign_manager = require("controller.sign_manager")
local grade_exp_data = require("data.grade_exp_data")
local item_data = require("data.item_data")
local item_manager = require("controller.item_manager")
local var_0_5
local activity_return_manager = require("controller.activity_return_manager")
local gamebuff_data = require("data.gamebuff_data")
local var_0_8 = require("controller.activity_return_manager")
local activity_manager = require("controller.activity_manager")
local souls_manager = require("controller.souls_manager")
local var_0_11 = config._DEBUG and 0 or 1
local var_0_12
local var_0_13
local var_0_14
local var_0_15
local var_0_16
local var_0_17
local var_0_18
local var_0_19
local var_0_20
local var_0_21
local var_0_22
local var_0_23
local var_0_24
local var_0_25 = {
	gold = 100,
	exp = 100,
	sp = 100
}
local var_0_26
local var_0_27

function TopcostLayer.create(arg_2_0)
	local var_2_0 = TopcostLayer.new()

	var_2_0:init()

	return var_2_0
end

function TopcostLayer.getInstance()
	return var_0_5
end

function TopcostLayer:init()
	var_0_5 = self
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TopcostLayer.json" or "TopcostLayer.ExportJson")

	self:addChild(self.rootlayer)
	self:initGold()
	self:initDiamond()
	self:initSp()
	self:initExp()
	self:initGrade()
	self:initPlayerInfo()
	self:initPoltBnt()
	self:initBagBtn()
	activity_return_manager:get_game_buffs()
	self:initDropInfo()
	self:initElectricPower()
	self:fullScreen()
	self:registerActivityEventListener()
	self:updateHangupBuff()

	self.hangupbuffs = {}

	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "enter" then
			self:checkActivityHangupInfo()
		end

		if arg_5_0 == "exit" then
			var_0_12 = nil
			var_0_13 = nil
			var_0_15 = nil
			var_0_16 = nil
			var_0_19 = nil
			var_0_18 = nil
			var_0_17 = nil
			var_0_20 = nil
			var_0_21 = nil
			var_0_23 = nil
			var_0_24 = nil
			var_0_22 = nil
			var_0_5 = nil

			activity_manager:releaseEventListenerByName("TopcostLayer")
		end
	end)
end

function TopcostLayer.registerActivityEventListener(arg_6_0)
	activity_manager:registerEventListener("TopcostLayer", activity_manager.activityEventId.ACTIVITY_RETURN_BUFF_UPDATE, function(arg_7_0)
		arg_6_0:createReturnBuff(var_0_8:get_buffs())
	end)
end

function TopcostLayer:checkActivityHangupInfo(arg_8_1)
	function self:eventCallback()
		self.param.type = "hangup_buff"
		self.hangupbuffs = self.param

		local var_9_0 = 100
		local var_9_1 = 100
		local var_9_2 = 100

		for iter_9_0, iter_9_1 in pairs(self.hangupbuffs.hangup_info) do
			if type(iter_9_1) == "table" then
				if iter_9_1.gold > 100 then
					var_9_0 = var_9_0 + iter_9_1.gold - 100
				end

				if iter_9_1.exp > 100 then
					var_9_1 = var_9_1 + iter_9_1.exp - 100
				end

				if iter_9_1.sp > 100 then
					var_9_2 = var_9_2 + iter_9_1.sp - 100
				end
			end
		end

		var_0_25.gold = var_9_0
		var_0_25.exp = var_9_1
		var_0_25.sp = var_9_2

		self:updateHangupBuff()
		GlobalUpdateDropinfo()
	end

	if arg_8_1 and arg_8_1.result and arg_8_1.result == 1 then
		self.eventCallback({
			param = arg_8_1
		})
	end
end

function TopcostLayer:fullScreen()
	self.rootlayer_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, self.rootlayer:getContentSize().height - 2, TRANSFORM_UNIT.PX)

	self.rootlayer:setPositionY(self.rootlayer_posY)
end

function TopcostLayer:choseTodeal(arg_11_1)
	var_0_22:setVisible(arg_11_1 == 1 and true or false)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_SkillPointBottom"):setVisible(arg_11_1 == 2 and true or false)
	var_0_24:setVisible(arg_11_1 == 3 and true or false)
end

function TopcostLayer:initGold()
	var_0_12 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_goldBottom")
	var_0_13 = var_0_12:getChildByName("Label_gold")

	var_0_13:setString(global_trans_number(playermodel.gold))
	var_0_12:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.touchLock then
			return
		end

		sign_manager:createMidasLayer()
	end)
end

function TopcostLayer:initDiamond()
	local var_14_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_diamondBottom")

	var_0_15 = var_14_0:getChildByName("Label_diamond")

	var_0_15:setString(global_trans_number(playermodel.diamond))
	var_14_0:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.touchLock then
			return
		end

		AnalyticManager.clickActivityEntranceType({
			jumpid = 170,
			enterType = "TopCostLayer"
		})
		LayerManager:switchShowLayer("SupermarketLayer", {
			showtab = 1,
			returnLayer = LayerManager:getActiveLayerName()
		})
	end)
end

function TopcostLayer:initSp()
	var_0_16 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_SkillPointBottom"):getChildByName("Label_skillPoint")

	var_0_16:setString(global_trans_number(playermodel.strengthpoint))
end

function TopcostLayer:initExp()
	local var_17_1 = playermodel.exp / (playermodel.totalexp or grade_exp_data[playermodel.grade].exp) * 100

	var_17_1 = var_17_1 <= 100 and var_17_1 or 100

	local var_17_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_lvBottom")

	var_17_2:setTouchEnabled(true)
	var_17_2:setSwallowsTouches(false)

	var_0_19 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("TopcostLayer/new_jingyan1.png") or cc.Sprite:createWithSpriteFrameName("TopcostLayer/new_jingyan1.png")))

	var_0_19:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_0_19:setBarChangeRate(cc.p(1, 0))
	var_0_19:setMidpoint(cc.p(0, 0))
	var_0_19:setAnchorPoint(cc.p(0.5, 0.5))
	var_0_19:setPosition(cc.p(var_17_2:getChildByName("Image_bottomBar"):getPositionX(), var_17_2:getChildByName("Image_bottomBar"):getPositionY()))
	var_0_19:setName("global_exp_bar")
	var_0_19:setPercentage(var_17_1)
	var_17_2:addChild(var_0_19, 999)

	local var_17_3 = ccui.ImageView:create("TopcostLayer/new_jingyan3.png", var_0_11)

	var_17_3:setAnchorPoint(cc.p(0, 0.5))

	local var_17_4 = ccui.ImageView:create("TopcostLayer/max.png", var_0_11)

	var_17_4:setAnchorPoint(cc.p(1, 0.5))
	var_17_4:setPosition(cc.p(var_0_19:getContentSize().width, var_0_19:getContentSize().height / 2))

	local var_17_5 = ccui.ImageView:create("TopcostLayer/max_fade.png", var_0_11)

	var_17_5:setPosition(cc.p(var_17_5:getContentSize().width / 2, var_17_5:getContentSize().height / 2))
	var_17_4:addChild(var_17_5, 999)
	var_17_4:setTouchEnabled(true)
	var_17_4:setSwallowsTouches(false)
	var_17_2:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.touchLock then
			return
		end

		LayerManager:pushInLayer("TopPlotListLayer", {
			taskType = TASK_TYPE_CAREER
		})
		var_0_19.updateExpPoint(var_17_1)
	end)
	var_17_5:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.FadeIn:create(2))))
	var_17_4:setVisible(false)

	if playermodel.class >= 4 then
		var_17_4:loadTexture("TopcostLayer/max.png", var_0_11)
		var_17_5:loadTexture("TopcostLayer/max_fade.png", var_0_11)
	else
		var_17_4:loadTexture("TopcostLayer/can_upschool.png", var_0_11)
		var_17_5:loadTexture("TopcostLayer/can_upschool_fade.png", var_0_11)
	end

	var_0_19:addChild(var_17_3, 999)
	var_0_19:addChild(var_17_4, 999)

	function var_0_19.updateExpPoint(arg_19_0)
		var_0_19:setPercentage(arg_19_0)

		if playermodel.class >= 4 then
			var_17_4:loadTexture("TopcostLayer/max.png", var_0_11)
			var_17_5:loadTexture("TopcostLayer/max_fade.png", var_0_11)
		else
			var_17_4:loadTexture("TopcostLayer/can_upschool.png", var_0_11)
			var_17_5:loadTexture("TopcostLayer/can_upschool_fade.png", var_0_11)
		end

		if arg_19_0 == 100 then
			var_17_3:setVisible(false)
			var_17_4:setVisible(true)
		else
			var_17_3:setVisible(true)
			var_17_3:setPosition(cc.p(arg_19_0 / 100 * 208, 2))
			var_17_4:setVisible(false)
		end
	end

	var_0_19.updateExpPoint(var_17_1)
end

function TopcostLayer:initGrade()
	var_0_18 = ccui.Helper:seekWidgetByName(self.rootlayer, "label_lv")

	var_0_18:setString("" .. playermodel.grade - (playermodel.class - 1) * 100)
end

function TopcostLayer:initElectricPower()
	var_0_22 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_electric")

	var_0_22:getChildByName("Label_electric"):setString(global_trans_number(item_manager:getItemNumber(ELECTRIC)))
	var_0_22:setTouchEnabled(true)
	var_0_22:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopElectricSupplyLayer", {})
	end)
end

function TopcostLayer:initPlayerInfo()
	local var_23_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_image")

	var_23_0:getChildByName("Image_head"):setVisible(false)

	var_0_20 = AvatarSprite:create(playermodel.head_sculpture)

	var_0_20:setScale(0.5)
	var_23_0:addChild(var_0_20)
	var_23_0:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.touchLock then
			return
		end

		LayerManager:switchShowLayer("ClassupdateLayer", LayerManager:getActiveLayerName())
	end)

	var_0_24 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_nameBottom")

	var_0_24:setOpacity(0)
	var_0_24:setCascadeOpacityEnabled(false)

	var_0_17 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_name")

	var_0_17:setString(playermodel.nickname)

	if string.len(playermodel.nickname) == 21 then
		var_0_24:setPositionX(147)
	else
		var_0_24:setPositionX(167)
	end

	var_0_23 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_grade")

	local var_23_1

	if playermodel.class == 5 then
		var_23_1 = "TopcostLayer/new_doctor.png"
	elseif playermodel.class == 4 then
		var_23_1 = "TopcostLayer/new_master.png"
	elseif playermodel.class == 3 then
		var_23_1 = "TopcostLayer/new_Univ.png"
	elseif playermodel.class == 2 then
		var_23_1 = "TopcostLayer/new_Senior.png"
	elseif playermodel.class == 1 then
		var_23_1 = "TopcostLayer/new_Junior.png"
	end

	var_0_23:loadTexture(var_23_1, var_0_11)

	global_contract_attr = ccui.Helper:seekWidgetByName(self.rootlayer, "contract_attr")

	global_contract_attr:setString(souls_manager:get_total_contract_attr())
	ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_contractAttrDetail"):addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopContractAttrDetailLayer")
	end)
end

function TopcostLayer:initPoltBnt()
	local var_26_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "plotBnt")

	if AlertManager.alertsys[ALERT_TOP_PLOT] then
		AlertManager:add_alert_by_config(var_26_0, true, {
			ALERT_SHOW_REDDOT,
			"plotBnt",
			cc.p(54, 27)
		})
	end

	var_26_0:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.touchLock then
			return
		end

		LayerManager:pushInLayer("TopPlotListLayer")
	end)
end

function TopcostLayer:initBagBtn(...)
	ccui.Helper:seekWidgetByName(self.rootlayer, "bagBnt"):addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.touchLock then
			return
		end

		LayerManager:switchShowLayer("BagLayerNew", {
			bagType = 2
		})
	end)
end

function TopcostLayer:initDropInfo()
	local var_30_0 = ccui.ImageView:create("TopcostLayer/dropinfobg.png", var_0_11)

	var_30_0:setAnchorPoint(cc.p(0, 0.5))
	var_30_0:setPosition(cc.p(5, GameDisplay.height - 160 - GameDisplay.fix_y))
	var_30_0:setName("dropinfoPanel")

	local var_30_1 = ccui.ImageView:create("TopcostLayer/new_money.png", var_0_11)

	var_30_1:setAnchorPoint(cc.p(0, 0.5))
	var_30_1:setPosition(cc.p(20, var_30_0:getContentSize().height / 2 - 25))
	var_30_1:setScale(0.8)
	var_30_0:addChild(var_30_1)

	local var_30_2 = cc.Label:createWithTTF(L_ADD_FEN, "fonts/name.ttf", 20)

	var_30_2:setAnchorPoint(cc.p(0, 0.5))
	var_30_2:setColor(cc.c3b(248, 250, 254))
	var_30_2:setPosition(cc.p(var_30_1:getPositionX() + var_30_1:getContentSize().width, var_30_1:getPositionY()))
	var_30_2:setName("goldadd")
	var_30_0:addChild(var_30_2)

	local var_30_3 = ccui.ImageView:create("TopcostLayer/up_money.png", var_0_11)

	var_30_3:setAnchorPoint(cc.p(0, 0.5))
	var_30_3:setPosition(cc.p(20, var_30_0:getContentSize().height / 2 + 10))
	var_30_3:setScale(0.8)
	var_30_0:addChild(var_30_3)

	local var_30_4 = cc.Label:createWithTTF(L_ADD_FEN, "fonts/name.ttf", 20)

	var_30_4:setAnchorPoint(cc.p(0, 0.5))
	var_30_4:setColor(cc.c3b(248, 250, 254))
	var_30_4:setPosition(cc.p(var_30_3:getPositionX() + var_30_3:getContentSize().width, var_30_3:getPositionY()))
	var_30_4:setName("spadd")
	var_30_0:addChild(var_30_4)
	self:addChild(var_30_0)

	var_0_21 = var_30_0
end

function TopcostLayer.registeReturnEvent(arg_31_0)
	print("registerReturnEvent is deprecated!!!!")
end

function TopcostLayer.showStrengthPoint(arg_32_0)
	print("showStrengthPoint is deprecated!!!!")
end

function TopcostLayer:showTopcostLayer()
	self.touchLock = false

	self.rootlayer:stopAllActions()
	self.rootlayer:runAction(cc.Sequence:create(cc.Show:create(), cc.MoveTo:create(0.2, cc.p(0, self.rootlayer_posY))))

	self.displayState = 1
end

function TopcostLayer:hideTopcostLayer(arg_34_1)
	self.touchLock = true

	self.rootlayer:stopAllActions()

	if arg_34_1 and next(arg_34_1) ~= nil and arg_34_1.action == false then
		self.rootlayer:setVisible(false)
	end

	self.rootlayer:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(0, GameDisplay.top)), cc.Hide:create()))

	if var_0_21 then
		var_0_21:setVisible(false)
	end

	self.displayState = 0
end

function TopcostLayer.setTouchLock(arg_35_0, arg_35_1)
	arg_35_1 = arg_35_1 or true
	arg_35_0.touchLock = arg_35_1
end

function TopcostLayer:getTopcostLayerState()
	return self.displayState
end

function TopcostLayer.shopTopDropinfo(arg_37_0)
	if var_0_21 then
		var_0_21:setVisible(true)
	end
end

function TopcostLayer.hideTopDropinfo(arg_38_0)
	if var_0_21 then
		var_0_21:setVisible(false)
	end
end

function TopcostLayer:onFirstCreate(arg_39_1)
	self.displayState = 1

	self.rootlayer:setPosition(cc.p(0, GameDisplay.top))
	self.rootlayer:runAction(cc.MoveTo:create(0.2, cc.p(0, self.rootlayer_posY)))

	if var_0_21 then
		var_0_21:setVisible(arg_39_1 == "FightLayer")
	end
end

function _G.GlobalUpdateGoldImg()
	if not var_0_12 then
		return
	end

	var_0_12:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2), cc.ScaleTo:create(0.2, 1)))
end

function _G.GlobalUpdateGold(arg_41_0)
	if not var_0_13 then
		return
	end

	var_0_13:setString(global_trans_number(playermodel.gold))

	if not arg_41_0 then
		var_0_13:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2), cc.ScaleTo:create(0.2, 1)))
	end
end

function _G.GlobalUpdateGoldButton(arg_42_0)
	if not var_0_14 then
		return
	end
end

function _G.GlobalUpdateDiamond()
	if not var_0_15 then
		return
	end

	var_0_15:setString(global_trans_number(playermodel.diamond))
	var_0_15:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2), cc.ScaleTo:create(0.2, 1)))
end

function _G.GlobalUpdateSp()
	if not var_0_16 then
		return
	end

	var_0_16:setString(global_trans_number(playermodel.strengthpoint))
	var_0_16:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2), cc.ScaleTo:create(0.2, 1)))
end

function _G.GlobalUpdateName()
	if not var_0_17 then
		return
	end

	var_0_17:setString(playermodel.nickname)

	if string.len(playermodel.nickname) == 21 then
		var_0_24:setPositionX(147)
	else
		var_0_24:setPositionX(167)
	end
end

function _G.GlobalUpdateGrade()
	if not var_0_18 then
		return
	end

	var_0_18:setString("" .. playermodel.grade - (playermodel.class - 1) * 100)

	if var_0_23 then
		local var_46_0

		if playermodel.class == 5 then
			var_46_0 = "TopcostLayer/new_doctor.png"
		elseif playermodel.class == 4 then
			var_46_0 = "TopcostLayer/new_master.png"
		elseif playermodel.class == 3 then
			var_46_0 = "TopcostLayer/new_Univ.png"
		elseif playermodel.class == 2 then
			var_46_0 = "TopcostLayer/new_Senior.png"
		elseif playermodel.class == 1 then
			var_46_0 = "TopcostLayer/new_Junior.png"
		end

		var_0_23:loadTexture(var_46_0, var_0_11)
	end
end

function _G.GlobalUpdateContractAttr()
	if not global_contract_attr then
		return
	end

	global_contract_attr:setString(souls_manager:get_total_contract_attr())
end

function _G.GlobalUpdateExp()
	if not var_0_19 then
		return
	end

	local var_48_0 = playermodel.exp / (playermodel.totalexp or grade_exp_data[playermodel.grade].exp) * 100

	var_48_0 = var_48_0 > 100 and 100 or var_48_0

	var_0_19.updateExpPoint(var_48_0)
end

function _G.GlobalUpdateHeadimg()
	if not var_0_20 then
		return
	end

	var_0_20:switchShowAvatar(playermodel.head_sculpture)
end

function _G.GlobalUpdateDropinfo(arg_50_0, arg_50_1)
	if not var_0_21 then
		return
	end

	var_0_26 = arg_50_0 or var_0_26
	var_0_27 = arg_50_1 or var_0_27

	local var_50_0 = var_0_25.sp or 100
	local var_50_1 = var_0_25.gold or 100
	local var_50_2, var_50_3 = var_0_8:get_money_or_science_up(2)
	local var_50_4, var_50_5 = var_0_8:get_money_or_science_up(3)
	local var_50_6 = var_50_0 + (var_50_3 - 1) * 100 + GetPrivilegeSpDropMarkup()
	local var_50_7 = var_50_1 + (var_50_5 - 1) * 100 + GetPrivilegeGoldDropMarkup()

	var_0_21:getChildByName("goldadd"):setString(string.format(L_ADD_FEN, math.floor(var_0_26 * var_50_7 / 100)))
	var_0_21:getChildByName("spadd"):setString(string.format(L_ADD_FEN, math.floor(var_0_27 * var_50_6 / 100)))

	if var_50_7 > 100 then
		var_0_21:getChildByName("goldadd"):setColor(cc.c3b(0, 208, 255))
	else
		var_0_21:getChildByName("goldadd"):setColor(cc.c3b(255, 255, 255))
	end

	if var_50_6 > 100 then
		var_0_21:getChildByName("spadd"):setColor(cc.c3b(0, 208, 255))
	else
		var_0_21:getChildByName("spadd"):setColor(cc.c3b(255, 255, 255))
	end
end

function _G.GlobalUpdateElectric()
	if not var_0_22 then
		return
	end

	var_0_22:getChildByName("Label_electric"):setString(global_trans_number(item_manager:getItemNumber(10100001)))
end

function TopcostLayer:updateHangupBuff()
	local var_52_0 = var_0_21:getChildByName("buff_panel")

	if not var_52_0 then
		var_52_0 = ccui.Layout:create()

		var_52_0:setContentSize(cc.size(180, 100))
		var_52_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		var_52_0:setAnchorPoint(0, 0)
		var_52_0:setPosition(cc.p(0, 0))
		var_52_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_52_0:setTouchEnabled(true)
		var_52_0:setName("buff_panel")
		var_0_21:addChild(var_52_0)
		var_52_0:addTouchEventListener(function(arg_53_0, arg_53_1)
			if arg_53_1 ~= ccui.TouchEventType.ended then
				return
			end

			local level_manager = require("controller.level_manager")

			self.hangupbuffs.base_sp = level_manager:getSpDropSpeed() * 6 * var_0_25.sp / 100
			self.hangupbuffs.base_gold = level_manager:getGoldDropSpeed() * 6 * var_0_25.gold / 100
			self.hangupbuffs.base_exp = level_manager:getExpDropSpeed() * 6 * var_0_25.exp / 100

			LayerManager:pushInLayer("PopReturnBuffLayer", {
				hangupbuffs = self.hangupbuffs
			})
		end)
	end

	if var_52_0:getChildByName("image_returnbuffs") then
		var_52_0:getChildByName("image_returnbuffs"):setVisible(false)
	end

	if var_52_0:getChildByName("image_hangupbuffs") then
		var_52_0:getChildByName("image_hangupbuffs"):setVisible(false)
	end

	local var_52_1 = 1

	while var_52_0:getChildByName("image_hangupbuffs_" .. var_52_1) do
		var_52_0:getChildByName("image_hangupbuffs_" .. var_52_1):setVisible(false)

		var_52_1 = var_52_1 + 1
	end

	local var_52_2 = 1
	local var_52_3 = 120

	if self.hangupbuffs then
		for iter_52_0, iter_52_1 in pairs(self.hangupbuffs.hangup_info) do
			if not iter_52_1.topcost_img[1] then
				if iter_52_1.equips and iter_52_1.equips[1] and iter_52_1.equips[1].dropid then
					local var_52_4 = "TopcostLayer/" .. item_data[iter_52_1.equips[1].dropid].image_id .. ".png"
					local var_52_5

					if var_52_0:getChildByName("image_hangupbuffs_1") then
						var_52_5 = var_52_0:getChildByName("image_hangupbuffs_1")
					else
						var_52_5 = ccui.ImageView:create(var_52_4, var_0_11)

						var_52_5:setTouchEnabled(false)
						var_52_5:setVisible(true)
						var_52_5:setName("image_hangupbuffs_1")
						var_52_0:addChild(var_52_5)
					end

					var_52_5:loadTexture(var_52_4, var_0_11)
					var_52_5:setPosition(cc.p(var_52_3, 87))
					var_52_5:setVisible(true)

					var_52_3 = var_52_3 + 30
				end
			else
				local var_52_6 = 1

				while iter_52_1.topcost_img[var_52_6] do
					local var_52_7 = "TopcostLayer/" .. iter_52_1.topcost_img[var_52_6] .. ".png"
					local var_52_8

					if not var_52_0:getChildByName("image_hangupbuffs_" .. var_52_2) then
						var_52_8 = ccui.ImageView:create(var_52_7, var_0_11)

						var_52_8:setTouchEnabled(false)
						var_52_8:setVisible(true)
						var_52_8:setName("image_hangupbuffs_" .. var_52_2)
						var_52_0:addChild(var_52_8)
					else
						var_52_8 = var_52_0:getChildByName("image_hangupbuffs_" .. var_52_2)
					end

					var_52_8:loadTexture(var_52_7, var_0_11)
					var_52_8:setVisible(true)
					var_52_8:setPosition(cc.p(var_52_3, 87))

					var_52_3 = var_52_3 + 30
					var_52_6 = var_52_6 + 1
					var_52_2 = var_52_2 + 1
				end
			end
		end
	end

	var_0_8:get_game_buffs(callback)
end

function TopcostLayer:createReturnBuff(arg_54_1)
	local var_54_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_lvBottom")

	if var_0_21 and var_0_21:getChildByName("buff_panel_card") then
		var_0_21:getChildByName("buff_panel_card"):removeFromParent()
	end

	if not arg_54_1 then
		return
	end

	local var_54_1 = ccui.Layout:create()

	var_54_1:setContentSize(cc.size(46, 30))
	var_54_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_54_1:setAnchorPoint(0.5, 0.5)
	var_54_1:setPosition(cc.p(120, 92))
	var_54_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_54_1:setCascadeOpacityEnabled(false)
	var_54_1:setBackGroundColorOpacity(0)
	var_54_1:setTouchEnabled(false)
	var_54_1:setName("buff_panel_card")
	var_0_21:addChild(var_54_1, 100)

	local var_54_2 = var_0_8:have_buff(13)
	local var_54_3 = 0

	for iter_54_0, iter_54_1 in pairs({
		"exp",
		"science",
		"money"
	}) do
		if var_0_8:get_money_or_science_up(iter_54_0) then
			local var_54_4 = ccui.Button:create("TopcostLayer/add_" .. iter_54_1 .. ".png", nil, "TopcostLayer/add_" .. iter_54_1 .. ".png", var_0_11)

			if self.hangupbuffs and next(self.hangupbuffs) and self.hangupbuffs.hangup_info and next(self.hangupbuffs.hangup_info) then
				var_54_1:setPosition(cc.p(170, 87))
			else
				var_54_1:setPosition(cc.p(120, 87))
			end

			var_54_4:setTouchEnabled(false)

			var_54_3 = var_54_3 + 1

			var_54_4:setScale(1.3)

			if var_54_2 then
				var_54_4:setPosition(cc.p(40 * (var_54_3 - 1) + 75, var_54_1:getContentSize().height / 2))
			else
				var_54_4:setPosition(cc.p(40 * (var_54_3 - 1) + 25, var_54_1:getContentSize().height / 2))
			end

			var_54_4:addTouchEventListener(function(arg_55_0, arg_55_1)
				if arg_55_1 ~= ccui.TouchEventType.ended then
					return
				end
			end)
			var_54_1:addChild(var_54_4)
		end
	end

	if var_54_3 > 0 then
		if var_54_2 then
			local var_54_5 = ccui.ImageView:create("TopcostLayer/add_return.png", var_0_11)

			var_54_5:setName("add_return")
			var_54_5:setScale(1.1)
			var_54_5:setPosition(cc.p(30, var_54_1:getContentSize().height / 2))
			var_54_1:addChild(var_54_5)
		else
			local var_54_6 = ccui.ImageView:create("TopcostLayer/arrow.png", var_0_11)

			var_54_6:setName("arrow")
			var_54_6:setScale(1.1)
			var_54_6:setPosition(cc.p(5, var_54_1:getContentSize().height / 2))
			var_54_1:addChild(var_54_6)
		end
	end

	local var_54_7 = {
		specical = cc.c3b(0, 208, 255),
		common = cc.c3b(255, 255, 255)
	}
	local var_54_8 = var_0_21:getChildByName("goldadd")
	local var_54_9 = var_0_21:getChildByName("spadd")

	if var_0_8:get_money_or_science_up(3) then
		if var_54_8 then
			var_54_8:setColor(var_54_7.specical)
		end
	elseif var_54_8 then
		var_54_8:setColor(var_54_7.common)
	end

	if var_0_8:get_money_or_science_up(2) then
		if var_54_9 then
			var_54_9:setColor(var_54_7.specical)
		end
	elseif var_54_9 then
		var_54_9:setColor(var_54_7.common)
	end
end
