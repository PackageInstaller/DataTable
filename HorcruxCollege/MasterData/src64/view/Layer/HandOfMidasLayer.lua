HandOfMidasLayer = class("HandOfMidasLayer", function()
	return cc.Layer:create()
end)

require("data.language_constants")

local handofmidas_data = require("data.handofmidas_data")
local market_level_data = require("data.market_level_data")
local handofmidas_times_data = require("data.handofmidas_times_data")
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local network = require("network.network")
local var_0_9
local var_0_10 = 1
local var_0_11 = 1
local var_0_12 = 1
local var_0_13 = cc.c4b(255, 84, 0, 150)
local var_0_14 = 6800411
local var_0_15 = config._DEBUG and 0 or 1

function HandOfMidasLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = HandOfMidasLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function HandOfMidasLayer.createLabel(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = cc.Label:createWithTTF(arg_3_2, FONT_NAME, 30)

	var_3_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_0:setPosition(cc.p(arg_3_1:getContentSize().width / 2, arg_3_1:getContentSize().height / 2 + 5))
	var_3_0:setName("label")
	var_3_0:enableOutline(var_0_13, 1)
	var_3_0:enableShadow(var_0_13, cc.size(0, 0))
	arg_3_1:addChild(var_3_0)
end

local function var_0_16(arg_4_0)
	global_ShowBlockWords(arg_4_0)
end

local function var_0_17(arg_5_0)
	l2Log("time" .. tostring(arg_5_0))

	if handofmidas_data[arg_5_0] then
		return tonumber(handofmidas_data[arg_5_0].costdiamond), tonumber(handofmidas_data[arg_5_0].costticketnum)
	else
		return nil
	end
end

local function var_0_18(arg_6_0)
	return tonumber((arg_6_0:sub(arg_6_0:find("%d+")))), tonumber((arg_6_0:sub(arg_6_0:find("%d+", (arg_6_0:find("_", 2))))))
end

local function var_0_19(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(market_level_data[arg_7_0]) do
		if iter_7_0 ~= "id" then
			local var_7_0, var_7_1 = var_0_18(iter_7_0)

			if playermodel.grade <= var_7_1 and var_7_0 <= playermodel.grade then
				return iter_7_1
			end
		end
	end
end

local function var_0_20(arg_8_0)
	if handofmidas_data[arg_8_0] then
		return (drop_manager:getGold(var_0_19(handofmidas_data[arg_8_0].gold)))
	else
		return nil
	end
end

local function var_0_21(arg_9_0)
	if not arg_9_0 or not tonumber(arg_9_0) then
		arg_9_0 = 0
	end

	local var_9_0 = 0

	for iter_9_0, iter_9_1 in pairs(handofmidas_data) do
		if not iter_9_1.requirevip or arg_9_0 >= iter_9_1.requirevip then
			var_9_0 = var_9_0 + 1
		end
	end

	l2Log("totalTime: " .. tostring(var_9_0))

	return var_9_0
end

local function var_0_22()
	return var_0_10
end

local function var_0_23(arg_11_0)
	network:rpc("get_daily_midas_times", nil, function(arg_12_0)
		var_0_10 = arg_12_0.result + 1
		var_0_12 = arg_12_0.multiplier_time + 1
		var_0_11 = tonumber(arg_12_0.cost_modulus) or 1

		l2Log("current midas time: " .. tostring(var_0_10))

		if arg_11_0 then
			arg_11_0()
		end
	end)
end

local function var_0_24()
	if var_0_9.goldText then
		var_0_9.goldText:setString(tostring(playermodel.gold))
	end

	if var_0_9.diamondText then
		var_0_9.diamondText:setString(tostring(playermodel.diamond))
	end
end

local function var_0_25(arg_14_0, arg_14_1)
	local var_14_0 = var_0_9

	if arg_14_1 ~= ccui.TouchEventType.ended then
		return
	end

	if var_0_9.touchtag == false then
		return
	end

	local playermodel = require("model.playermodel")
	local var_14_2, var_14_3 = var_0_17(var_0_22())
	local var_14_4

	var_14_4 = var_14_2 or 0

	local var_14_5

	var_14_5 = var_14_3 or 0

	;(function()
		local var_15_0, var_15_1 = var_14_0:Validate(var_0_22(), playermodel.diamond, playermodel.vip)

		if var_15_0 and not var_15_1 then
			var_14_0:Cast(var_0_22(), playermodel)
			var_14_0:RefreshView()
		end
	end)()
end

function HandOfMidasLayer:CastView(arg_16_1, arg_16_2, arg_16_3)
	if arg_16_3 then
		l2Log("Doubled animation...")

		local var_16_0 = ccui.ImageView:create()

		self.image_midas_bg:addChild(var_16_0, 10)
		var_16_0:setVisible(false)

		local var_16_1 = var_16_0:clone()

		var_16_1:loadTexture("fight/crit.png", config._DEBUG and 0 or 1)
		var_16_1:setScale(2)
		var_16_1:setPosition(cc.p(253, 200))
		var_16_0:getParent():addChild(var_16_1, 10)
		var_16_1:setVisible(true)
		var_16_1:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(5, cc.p(0, 300)), (cc.FadeOut:create(3))), (cc.CallFunc:create(function()
			var_16_1:removeFromParent()
		end))))
	end
end

function HandOfMidasLayer:SetToValidView()
	if not global_trans_number(var_0_20(var_0_22())) then
		-- block empty
	end

	local var_18_1, var_18_2 = var_0_17(var_0_22())

	var_18_1 = var_18_1 or 0
	var_18_2 = var_18_2 or 0

	local var_18_5, var_18_6, var_18_7 = self:getCurMultiplier()

	ccui.Helper:seekWidgetByName(self.rootLayer, "diamond_num"):setString(math.ceil(var_18_1 * var_0_11))
	ccui.Helper:seekWidgetByName(self.rootLayer, "diamond_num"):getChildByName("modulus"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "gold_num"):setString(tonumber(var_0_20(var_0_22())))
	ccui.Helper:seekWidgetByName(self.rootLayer, "gold_num"):getChildByName("modulus"):setString("×" .. var_18_6)
	self.cost_icon:loadTexture("midas/zuans.png", var_0_15)
	ccui.Helper:seekWidgetByName(self.panel, "label_time"):setString("(" .. tostring(var_0_21() - var_0_22() + 1) .. "/" .. tostring(var_0_21()) .. ")")
	assert(var_0_21() - var_0_22() + 1 >= 0, "totalTime = " .. var_0_21() .. ", midasTime = " .. var_0_22())

	if var_18_1 == 0 then
		self.button_sure_midas:getChildByName("Label_84"):setString(L_BUTTON_TEXT.Midas_Btn[1])
		self.button_sure_midas:getChildByName("Image_diamond"):setVisible(false)
	else
		self.button_sure_midas:getChildByName("Label_84"):setString(L_BUTTON_TEXT.Midas_Btn[2])
		self.button_sure_midas:getChildByName("Image_diamond"):setVisible(true)
		self.button_sure_midas:getChildByName("Image_diamond"):getChildByName("Label_cost"):setColor(cc.c3b(255, 255, 255))

		if var_18_2 <= item_manager:getItemNumber(var_0_14) then
			self.title_tips:setString(L_MIDAS_TIPS.Ticket)
			self.cost_icon:loadTexture("equipment/" .. item_data[var_0_14].image_id .. ".png")
			self.button_sure_midas:getChildByName("Image_diamond"):loadTexture("equipment/" .. item_data[var_0_14].image_id .. ".png")
			self.button_sure_midas:getChildByName("Image_diamond"):setScale(0.45)
			self.button_sure_midas:getChildByName("Image_diamond"):getChildByName("Label_cost"):setString(var_18_2)
			self.button_sure_midas:getChildByName("Image_diamond"):getChildByName("Label_cost"):setScale(2.2222222222222223)

			local var_18_8 = self.button_sure_midas:getChildByName("Image_diamond"):getChildByName("Label_cost")

			self.button_sure_midas:getChildByName("Image_diamond"):getChildByName("Label_cost"):setPosition(var_18_8:getParent():getContentSize().width + 5, var_18_8:getParent():getContentSize().height / 2)
			ccui.Helper:seekWidgetByName(self.rootLayer, "diamond_num"):setString(var_18_2)
		else
			self.title_tips:setString(L_MIDAS_TIPS.Diamond)
			self.button_sure_midas:getChildByName("Image_diamond"):loadTexture("public/currency/UI_battleEnd_diamond.png", var_0_15)
			self.button_sure_midas:getChildByName("Image_diamond"):setScale(1)
			self.button_sure_midas:getChildByName("Image_diamond"):getChildByName("Label_cost"):setString(math.ceil(var_18_1 * var_0_11))
			self.button_sure_midas:getChildByName("Image_diamond"):getChildByName("Label_cost"):setScale(1)

			local var_18_9 = self.button_sure_midas:getChildByName("Image_diamond"):getChildByName("Label_cost")

			self.button_sure_midas:getChildByName("Image_diamond"):getChildByName("Label_cost"):setPosition(var_18_9:getParent():getContentSize().width + 5, var_18_9:getParent():getContentSize().height / 2)
			ccui.Helper:seekWidgetByName(self.rootLayer, "diamond_num"):setString(math.ceil(var_18_1 * var_0_11))
		end
	end
end

function HandOfMidasLayer:SetToInvalidView()
	if not global_trans_number(var_0_20(var_0_22() - 1)) then
		-- block empty
	end

	local var_19_3, var_19_4 = var_0_17(var_0_22() - 1)
	local var_19_5, var_19_6, var_19_7 = self:getCurMultiplier()

	ccui.Helper:seekWidgetByName(self.rootLayer, "diamond_num"):setString(math.ceil(var_19_3 * var_0_11))
	ccui.Helper:seekWidgetByName(self.rootLayer, "diamond_num"):getChildByName("modulus"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "gold_num"):setString(tonumber(var_0_20(var_0_22() - 1)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "gold_num"):getChildByName("modulus"):setString("×" .. var_19_6)
	self.button_sure_midas:setVisible(false)
	ccui.Helper:seekWidgetByName(self.panel, "label_time"):setString(L_MIDAS_DES[1])

	local var_19_8 = ccui.Helper:seekWidgetByName(self.panel, "label_time")

	ccui.Helper:seekWidgetByName(self.panel, "label_intro"):setString(L_MIDAS_TIPS.No_Times)
	var_19_8:setString("(" .. tostring(var_0_21() - var_0_22() + 1) .. "/" .. tostring(var_0_21()) .. ")")
	var_19_8:setPositionX(110)
end

function HandOfMidasLayer:RefreshView()
	if self:Validate(var_0_22(), playermodel.diamond, nil, true) then
		self:SetToValidView()
	else
		self:SetToInvalidView()
	end

	self:updateRangeBar()
end

function HandOfMidasLayer.Validate(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if not arg_21_1 or arg_21_1 <= 0 then
		l2Log("todaysTime" .. tostring(arg_21_1))
		var_0_16("Warning: time not valid!")

		return false
	end

	if arg_21_1 > #handofmidas_data or not handofmidas_data[arg_21_1] then
		l2Log("todaysTime" .. tostring(arg_21_1))

		if not arg_21_4 then
			var_0_16(L_MIDAS_TIPS.No_Times)
		end

		return false
	end

	local var_21_0 = handofmidas_data[arg_21_1].requirevip

	if not handofmidas_data[arg_21_1].costdiamond then
		var_0_16("Warning: costDiamond is not valid")

		return false
	end

	if not var_21_0 then
		var_0_16("Warning: requireVip is not valid")

		return false
	end

	local var_21_2, var_21_3 = var_0_17(var_0_22())
	local var_21_4

	var_21_4 = var_21_2 or 0
	var_21_3 = var_21_3 or 0

	if var_21_3 <= item_manager:getItemNumber(var_0_14) then
		return true
	elseif arg_21_2 < handofmidas_data[arg_21_1].costdiamond then
		if not arg_21_4 then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 0,
				releaseCallback = function()
					LayerManager:removePopLayer()
				end
			})
		end

		return true, true
	end

	if var_21_0 > 0 and not arg_21_3 then
		if not arg_21_4 then
			var_0_16(L_MIDAS_TIPS.Need_Vip)
		end

		return false
	end

	return true
end

function HandOfMidasLayer.Cast(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.touchtag = false

	if not arg_23_2 then
		return false, nil
	end

	local var_23_0 = false
	local var_23_1
	local var_23_2
	local var_23_4
	local var_23_5

	var_0_10 = var_0_10

	network:rpc("hand_of_midas", nil, function(arg_24_0)
		if not var_0_9 then
			return
		end

		if arg_24_0.result == 1 then
			var_23_0 = true
			var_23_4 = arg_24_0.double
			var_23_2 = tonumber(arg_24_0.gold)
			var_23_1 = arg_24_0.diamond_consumed
			var_23_5 = arg_24_0.cost_ticket_num
			var_0_10 = arg_24_0.time + 1
			var_0_12 = arg_24_0.multiplier_time + 1
			var_0_11 = tonumber(arg_24_0.cost_modulus) or 1

			if var_23_5 and var_23_5 > 0 then
				item_manager:deleteItem(var_0_14, var_23_5)
			end

			arg_23_2.gold = arg_23_2.gold + var_23_2
			arg_23_2.diamond = arg_23_2.diamond - var_23_1

			assert(arg_23_2.diamond >= 0, "after midas, diamond is negative number!!")
			global_update_gold_stone_diamond(var_23_2, nil, var_23_1)
			var_0_24()
			arg_23_0:CastView(var_23_2, var_23_1, var_23_4)
			arg_23_0:RefreshView()
			AlertManager:unregister_alert(ALERT_MIDAS, true)

			if var_23_5 then
				AnalyticManager.midassuccess({
					cost_type = "ticket",
					cost_num = var_23_5
				})
			else
				AnalyticManager.midassuccess({
					cost_type = "diamond",
					cost_num = var_23_1,
					cost_diamond = var_23_1
				})
			end

			require("controller.tips_manager"):pushBackTipsEventWithClient({
				tipsid = E_TIPS_GET_MONEY,
				param1 = arg_24_0.gold
			})
			audio_manager:playeffectMusic(GET_AWARDS)
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("hand_of_midas")))
		elseif arg_24_0.result == -1 then
			global_ShowBlockWords(L_MARKET_CURRENCY_LACK.Diamond)
		else
			var_0_23()
		end

		arg_23_0.touchtag = true
	end)

	return true, nil
end

function HandOfMidasLayer:Test()
	local playermodel = require("model.playermodel")

	if self:Validate(4, playermodel.diamond, playermodel.vip) then
		self:Cast(4, playermodel)
	end
end

function HandOfMidasLayer:initUI()
	self.rangBg = ccui.Helper:seekWidgetByName(self.panel, "Image_rang")
	self.progressBar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("midas/rang1.png") or cc.Sprite:createWithSpriteFrameName("midas/rang1.png")))

	self.progressBar:setRotation(180)
	self.progressBar:setAnchorPoint(cc.p(0.5, 0.5))
	self.progressBar:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	self.progressBar:setPosition(self.rangBg:getPosition())
	self.panel:addChild(self.progressBar, 0)

	self.tipsBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_tips")

	self.tipsBnt:setVisible(false)

	self.tipsPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_tips")

	self.tipsBnt:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.tipsPanel:setVisible(true)
	end)

	local var_26_0 = self.tipsPanel:getChildByName("Image_tips")

	var_26_0:setContentSize(cc.size(var_26_0:getContentSize().width, 40 + #L_HANDOFMIDAS_TIPS * 30))

	for iter_26_0, iter_26_1 in pairs(L_HANDOFMIDAS_TIPS) do
		local var_26_1 = var_26_0:getChildByName("Label_tips" .. iter_26_0)
		local var_26_2

		if not var_26_1 then
			var_26_1 = var_26_0:getChildByName("Label_tips1"):clone()

			var_26_0:addChild(var_26_1)

			var_26_2 = var_26_0:getChildByName("Label_tips1"):getPositionY()
		end

		var_26_1:setPositionY(var_26_2 - (var_26_1:getContentSize().height + 10) * (iter_26_0 - 1))
		var_26_1:setString(iter_26_1)
	end

	local var_26_3 = ccui.ImageView:create("roleimage/role1/100.png")

	var_26_3:setScale(0.4)
	var_26_3:setPosition(40, 100)
	var_26_0:addChild(var_26_3)
	self.button_sure_midas:getChildByName("Label_84"):setPositionY(self.button_sure_midas:getChildByName("Label_84"):getPositionY() + 15)

	self.title_tips = cc.Label:createWithTTF(L_MIDAS_TIPS.Ticket, FONT_NAME, 22)

	self.title_tips:setAnchorPoint(cc.p(0, 0.5))
	self.title_tips:setPosition(206, 476)
	self.title_tips:setColor(cc.c3b(138, 160, 186))
	self.image_bg:addChild(self.title_tips)

	self.cost_icon = ccui.ImageView:create("midas/zuans.png", var_0_15)

	self.cost_icon:setPosition(168, 589)
	self.image_bg:addChild(self.cost_icon)
	self.tipsPanel:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.tipsPanel:setVisible(false)
	end)
end

function HandOfMidasLayer.getCurMultiplier(arg_29_0)
	local var_29_0
	local var_29_1
	local var_29_2 = {}

	for iter_29_0, iter_29_1 in ipairs(handofmidas_times_data) do
		if var_0_12 <= iter_29_1.max_time then
			var_29_0 = iter_29_0
			var_29_1 = iter_29_1.multiplier

			break
		elseif iter_29_0 == #handofmidas_times_data then
			var_29_0 = iter_29_0
			var_29_1 = iter_29_1.multiplier
		end
	end

	local var_29_3

	if var_29_0 == #handofmidas_times_data then
		var_29_3 = var_29_0 - 5 or var_29_0 - (var_29_0 - 1) % 5
	end

	for iter_29_2 = var_29_3, var_29_3 + 5 do
		table.insert(var_29_2, {
			index = iter_29_2,
			multiplier = handofmidas_times_data[iter_29_2].multiplier
		})
	end

	return var_29_0, var_29_1, var_29_2
end

function HandOfMidasLayer:updateRangeBar()
	local var_30_0, var_30_1, var_30_2 = self:getCurMultiplier()
	local var_30_3

	for iter_30_0, iter_30_1 in ipairs(var_30_2) do
		local var_30_4 = self.rangBg:getChildByName("Image_num" .. iter_30_0)

		var_30_4:getChildByName("Label_shadow"):setVisible(false)
		var_30_4:getChildByName("Label_num"):enableOutline(cc.c4b(255, 255, 255, 255), 1)
		var_30_4:getChildByName("Label_num"):setString("×" .. iter_30_1.multiplier)
		var_30_4:getChildByName("Label_shadow"):setString("×" .. iter_30_1.multiplier)

		if iter_30_1.index == var_30_0 then
			var_30_3 = iter_30_0

			var_30_4:loadTexture("midas/yellow_bg.png", var_0_15)
		else
			var_30_4:loadTexture("midas/blue_bg.png", var_0_15)
		end
	end

	if var_30_0 == #handofmidas_times_data then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_title"):setString(L_MIDAS_RANGEBAR.Max_Title)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_count"):setString(L_MIDAS_RANGEBAR.Max_Count)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_count"):setString(handofmidas_times_data[var_30_0].max_time - (var_0_12 - 1) .. L_MIDAS_TIMES)

		if var_30_0 == #var_30_2 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_title"):setString(L_MIDAS_RANGEBAR.Limit_Up)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_title"):setString(L_MIDAS_RANGEBAR.Efficiency_Up)
		end
	end

	self.progressBar:runAction(cc.ProgressTo:create(0.8, math.floor((30 + 60 * (var_30_3 - 1)) / 360 * 100)))
end

function HandOfMidasLayer:init(arg_31_1)
	AnalyticManager.entermidas()

	var_0_9 = self
	self.touchtag = true

	local var_31_0 = arg_31_1.callback

	if arg_31_1 then
		local var_31_1 = arg_31_1.showEnd or nil
	end

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "midas.json" or "midas.ExportJson")

	self.rootLayer:setName("MidasLayer")
	self:addChild(self.rootLayer)

	self.image_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "image_bg")
	self.panel = ccui.Helper:seekWidgetByName(self.rootLayer, "image_midas_bg")
	self.nextUpLabel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_count")
	self.button_sure_midas = ccui.Helper:seekWidgetByName(self.rootLayer, "button_midas_sure")

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_title"):setFontSize(20)
	ccui.Helper:seekWidgetByName(self.rootLayer, "gold_num"):setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "gold_num"):getPositionX() - 12)
	global_window_open_action(self.image_bg)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.25), cc.CallFunc:create(function()
		if var_31_1 then
			var_31_1()
		end
	end)))
	self.image_bg:setTouchEnabled(true)
	self:initUI()
	self.button_sure_midas:loadTextures("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", var_0_15)
	self.button_sure_midas:setPressedActionEnabled(true)
	self.button_sure_midas:addTouchEventListener(var_0_25)
	var_0_23(function()
		if var_0_9 then
			self:RefreshView()
		end
	end)

	self.awardUpBtn = ccui.Button:create("midas/awardup_btn.png", nil, "midas/awardup_btn.png", var_0_15)

	self.awardUpBtn:setPosition(cc.p(430, -20))
	self.awardUpBtn:setVisible(playermodel.award_up_info.midas and playermodel.award_up_info.midas.rate > 1 and global_is_in_time(playermodel.award_up_info.midas.starttime, playermodel.award_up_info.midas.finishtime) or false)
	self.image_bg:addChild(self.awardUpBtn, 100)
	self.awardUpBtn:addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "award_up"
		})
		print(dump(playermodel.award_up_info.midas))
	end)
	self.rootLayer:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.image_bg, function()
			self.image_bg:stopAllActions()
			LayerManager:removePopLayer()
		end)
	end)
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	LayerManager:createFullScreenMask(self, nil, function(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.image_bg, function()
			self.image_bg:stopAllActions()
			LayerManager:removePopLayer()
		end)
	end, ccui.LayoutBackGroundColorType.none)
	self:registerScriptHandler(function(arg_39_0)
		if arg_39_0 == "exit" then
			if var_31_0 then
				var_31_0()
			end

			var_0_9 = nil
		end
	end)
end

function HandOfMidasLayer:initBg(arg_40_1)
	local var_40_0 = ccui.Layout:create()

	var_40_0:setTouchEnabled(true)
	var_40_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_40_0:setAnchorPoint(cc.p(0, 0))
	var_40_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_40_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_40_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_40_0:setOpacity(0)
	self:addChild(var_40_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_41_0)
		self:addChild(arg_41_0, -2)
		arg_41_0:setPositionY(arg_41_0:getPositionY() - GameDisplay.fix_y)

		local var_41_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_41_0:setAnchorPoint(cc.p(0, 0))
		var_41_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_41_0, -1)
		self:init(arg_40_1, initInfo)
		var_40_0:setOpacity(102)
		var_40_0:setTouchEnabled(false)
	end)
end

function HandOfMidasLayer:exit()
	global_window_close_action(self.image_bg, function()
		self.image_bg:stopAllActions()
		LayerManager:removePopLayer()
	end)
end
