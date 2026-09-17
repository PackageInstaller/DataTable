RechargeSprite = {}

local item_data = require("data.item_data")
local recharge_data = require("data.recharge_data")
local var_0_2 = config._DEBUG and 0 or 1
local ShopSprite = require("view.Sprite.ShopSprite")
local playermodel = require("model.playermodel")
local time_check_manager = require("controller.time_check_manager")
local drop_manager = require("controller.drop_manager")
local recharge_manager = require("controller.recharge_manager")
local TempWidget = require("view/Sprite/TempWidget")
local var_0_10 = {
	returnback_card = 20002,
	newbee_card = 20001,
	gold_quarter_card = 30004,
	quartercard = 90,
	month_card = 1,
	yearcard = 365,
	diamond_quarter_card = 88002,
	diamond_year_card = 88003,
	gold_card = 20003,
	horcrux_card = 20004,
	diamond_month_card = 88001,
	forevercard = 9
}

local function var_0_11(arg_1_0)
	if not arg_1_0 then
		return ""
	end

	if arg_1_0 > 86400 then
		return string.format(L_TIME_SINGLE.Day, math.floor(arg_1_0 / 3600 / 24))
	elseif arg_1_0 >= 3600 then
		return string.format(L_TIME_SINGLE.Hour, math.floor(arg_1_0 / 3600))
	elseif arg_1_0 >= 60 then
		return string.format(L_TIME_SINGLE.Minute, math.floor(arg_1_0 % 3600 / 60))
	else
		return string.format(L_TIME_SINGLE.Minute, 1)
	end
end

local function var_0_12(arg_2_0, arg_2_1)
	ccui.Helper:seekWidgetByName(arg_2_0, "Button_bg"):loadTextures("mainScenebg/recharge/" .. arg_2_1.id .. ".png", "mainScenebg/recharge/" .. arg_2_1.id .. ".png", "mainScenebg/recharge/" .. arg_2_1.id .. ".png")
	ccui.Helper:seekWidgetByName(arg_2_0, "Button_bg"):setLocalZOrder(-1)
	ccui.Helper:seekWidgetByName(arg_2_0, "Label_name"):setString(arg_2_1.name)

	if arg_2_1.rmb then
		ccui.Helper:seekWidgetByName(arg_2_0, "Label_cost"):setString(arg_2_1.rmb)
		ccui.Helper:seekWidgetByName(arg_2_0, "Image_costcurrency"):loadTexture("public/currency/rmb_white.png", var_0_2)
	end

	if arg_2_1.price_diamond then
		ccui.Helper:seekWidgetByName(arg_2_0, "Label_cost"):setString(arg_2_1.price_diamond)
		ccui.Helper:seekWidgetByName(arg_2_0, "Image_costcurrency"):loadTexture("public/currency/UI_battleEnd_diamond.png", var_0_2)
	end

	if arg_2_1.price_card then
		ccui.Helper:seekWidgetByName(arg_2_0, "Label_cost"):setString(arg_2_1.price_card)
		ccui.Helper:seekWidgetByName(arg_2_0, "Image_costcurrency"):loadTexture("public/currency/6800601.png", var_0_2)
	end

	ccui.Helper:seekWidgetByName(arg_2_0, "Image_costcurrency"):setVisible(true)

	if arg_2_1.type == 11 or arg_2_1.type == 8 and not arg_2_1.rmb then
		ccui.Helper:seekWidgetByName(arg_2_0, "Label_cost"):setString(L_FREE_BUY)
		ccui.Helper:seekWidgetByName(arg_2_0, "Image_costcurrency"):setVisible(false)
	end

	ccui.Helper:seekWidgetByName(arg_2_0, "Image_costcurrency"):setPositionX(ccui.Helper:seekWidgetByName(arg_2_0, "Label_cost"):getPositionX() - (ccui.Helper:seekWidgetByName(arg_2_0, "Label_cost"):getContentSize().width + ccui.Helper:seekWidgetByName(arg_2_0, "Image_costcurrency"):getContentSize().width / 2))

	if arg_2_1.buy_limit then
		ccui.Helper:seekWidgetByName(arg_2_0, "Label_limit"):setString(L_LIMIT .. "(" .. arg_2_1.have_bought .. "/" .. arg_2_1.buy_limit .. ")")
		ccui.Helper:seekWidgetByName(arg_2_0, "Image_buylimit"):setVisible(true)

		local var_2_0 = ccui.Helper:seekWidgetByName(arg_2_0, "Label_limit")
		local var_2_1 = var_2_0:getContentSize().width

		ccui.Helper:seekWidgetByName(arg_2_0, "Image_buylimit"):setContentSize(cc.size(var_2_1 + 20, ccui.Helper:seekWidgetByName(arg_2_0, "Image_buylimit").getContentSize(var_2_0).height))
		ccui.Helper:seekWidgetByName(arg_2_0, "Label_limit"):setPositionX(var_2_1 + 8)
	else
		ccui.Helper:seekWidgetByName(arg_2_0, "Image_buylimit"):setVisible(false)
	end

	ccui.Helper:seekWidgetByName(arg_2_0, "Label_name"):setVisible(false)
	ccui.Helper:seekWidgetByName(arg_2_0, "Image_new"):setVisible(arg_2_1.new_tag == true)

	if arg_2_1.refreshtype then
		ccui.Helper:seekWidgetByName(arg_2_0, "Image_refresh"):setVisible(true)
		ccui.Helper:seekWidgetByName(arg_2_0, "Label_refreshtime"):setString((function(arg_3_0, arg_3_1)
			local var_3_0 = ""

			if arg_3_0 == 1 then
				var_3_0 = var_3_0 .. string.format(L_RECHARGE_DAY, arg_3_1) .. L_RECHARGE_REFRESH
			elseif arg_3_0 == 2 then
				var_3_0 = var_3_0 .. "每" .. L_WEEK_TEXT[tonumber(arg_3_1)] .. L_RECHARGE_REFRESH
			elseif arg_3_0 == 3 then
				var_3_0 = var_3_0 .. string.format(L_RECHARGE_MONTH, arg_3_1) .. L_RECHARGE_REFRESH
			end

			return var_3_0
		end)(arg_2_1.refreshtype, arg_2_1.refresh_time))

		local var_2_3 = ccui.Helper:seekWidgetByName(arg_2_0, "Label_refreshtime")
		local var_2_4 = ccui.Helper:seekWidgetByName(arg_2_0, "Image_refresh").getContentSize(var_2_3).height

		ccui.Helper:seekWidgetByName(arg_2_0, "Image_refresh"):setContentSize(cc.size(var_2_3:getContentSize().width + 20, var_2_4))
		ccui.Helper:seekWidgetByName(arg_2_0, "Label_refreshtime"):setPositionY(var_2_4 / 2)
	else
		ccui.Helper:seekWidgetByName(arg_2_0, "Image_refresh"):setVisible(false)
	end

	;(function(arg_4_0)
		if arg_2_1.type ~= 21 then
			ccui.Helper:seekWidgetByName(arg_4_0, "Button_bg"):setScale(1)

			local var_4_0 = arg_4_0:getChildByName("panelLimit")

			if var_4_0 then
				var_4_0:removeFromParent(false)
			end
		else
			ccui.Helper:seekWidgetByName(arg_4_0, "Button_bg"):setScale(0.95)

			local var_4_1 = arg_4_0:getChildByName("panelLimit")

			if not var_4_1 then
				var_4_1 = ccui.Layout:create()

				var_4_1:setContentSize(arg_4_0:getContentSize())
				var_4_1:setTouchEnabled(false)

				local var_4_2 = ccui.ImageView:create("SupermarketLayer/img_clock.png", var_0_2)

				var_4_2:setPosition(15, 202)
				var_4_1:addChild(var_4_2)

				local var_4_3 = ccui.Text:create("", "fonts/W5.ttf", 16)

				var_4_3:setName("labelRemainTime")
				var_4_3:setPosition(30, 202)
				var_4_3:setAnchorPoint(0, 0.5)
				var_4_3:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
				var_4_3:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
				var_4_1:addChild(var_4_3)
				var_4_1:setName("panelLimit")
				arg_4_0:addChild(var_4_1)
			end

			local var_4_4 = var_4_1:getChildByName("labelRemainTime")
			local Utility = require("common.Utility")
			local var_4_6 = math.max(0, global_get_time_by_date(arg_2_1.finishtime) - time_check_manager:getCurTime())

			var_4_4:setString("剩余时间: " .. Utility:formatTimeStr(var_4_6))
			var_4_4:stopAllActions()
			var_4_4:runAction((Utility:createClockTimerAction(var_4_4, 1, var_4_6, function(arg_5_0)
				var_4_4:setString("剩余时间: " .. Utility:formatTimeStr(arg_5_0))
			end)))
		end
	end)(arg_2_0)
end

local var_0_13

RechargeSprite1 = class("rechargeSpriteUiType1", function()
	if not var_0_13 then
		var_0_13 = ccui.Helper:seekWidgetByName(ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "rechargeSpriteUiType1.json" or "rechargeSpriteUiType1.ExportJson"), "Button_rechargeDiamond")

		var_0_13:retain()
	end

	return var_0_13:clone()
end)

function RechargeSprite1.update(arg_7_0, arg_7_1)
	ccui.Helper:seekWidgetByName(arg_7_0, "Image_price"):setVisible(false)
	;(function()
		ccui.Helper:seekWidgetByName(arg_7_0, "Panel_des"):setVisible(false)
		ccui.Helper:seekWidgetByName(arg_7_0, "Label_1"):setVisible(true)
		ccui.Helper:seekWidgetByName(arg_7_0, "Label_2"):setVisible(true)
		ccui.Helper:seekWidgetByName(arg_7_0, "Label_3"):setVisible(false)
		ccui.Helper:seekWidgetByName(arg_7_0, "Image_16"):setVisible(false)

		if recharge_data[arg_7_1.id].award then
			ccui.Helper:seekWidgetByName(arg_7_0, "Panel_des"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_7_0, "Label_1"):setString(recharge_data[arg_7_1.id].des1 .. recharge_data[arg_7_1.id].award .. L_DIAMOND)
			ccui.Helper:seekWidgetByName(arg_7_0, "Label_2"):setString(recharge_data[arg_7_1.id].des1 .. recharge_data[arg_7_1.id].award .. L_DIAMOND)
		end

		if recharge_data[arg_7_1.id].first_award and arg_7_1.have_bought == 0 then
			ccui.Helper:seekWidgetByName(arg_7_0, "Image_16"):loadTexture("recharge/first_recharge_title_" .. arg_7_1.shop_type .. ".png", var_0_2)
			ccui.Helper:seekWidgetByName(arg_7_0, "Image_16"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_7_0, "Panel_des"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_7_0, "Label_1"):setString(recharge_data[arg_7_1.id].des1 .. recharge_data[arg_7_1.id].des2)
			ccui.Helper:seekWidgetByName(arg_7_0, "Label_2"):setString(recharge_data[arg_7_1.id].des1 .. recharge_data[arg_7_1.id].des2)
		end
	end)()
	var_0_12(arg_7_0, arg_7_1)
	;(function()
		if not arg_7_0:getChildByName("Label_price") then
			local var_9_0 = ccui.TextBMFont:create("", "fonts/recharge_price.fnt")

			var_9_0:setPosition(cc.p(35, 28))
			var_9_0:setName("Label_price")
			var_9_0:setAnchorPoint(0, 0.5)
			arg_7_0:addChild(var_9_0)
		end

		local var_9_1 = arg_7_0:getChildByName("Label_price")

		var_9_1:setString(recharge_manager:getCommodityPriceStr(arg_7_1.id))
		var_9_1:setVisible(true)
	end)()
	;(function()
		ccui.Helper:seekWidgetByName(arg_7_0, "Panel_monthcard"):setVisible(false)

		if arg_7_1.id == 1 then
			ccui.Helper:seekWidgetByName(arg_7_0, "Panel_monthcard"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_7_0, "des1"):setVisible(false)
			ccui.Helper:seekWidgetByName(arg_7_0, "des2"):setVisible(false)
			ccui.Helper:seekWidgetByName(arg_7_0, "des3"):setVisible(false)
			ccui.Helper:seekWidgetByName(arg_7_0, "Image_surplusTime"):setVisible(false)

			if arg_7_1.remain and arg_7_1.remain > 0 then
				ccui.Helper:seekWidgetByName(arg_7_0, "Image_surplusTime"):setVisible(true)
				ccui.Helper:seekWidgetByName(arg_7_0, "des1"):setVisible(true)
				ccui.Helper:seekWidgetByName(arg_7_0, "des1"):setColor(cc.c3b(251, 189, 241))
				ccui.Helper:seekWidgetByName(arg_7_0, "des1"):setString("剩余:" .. arg_7_1.remain .. "日")
			else
				ccui.Helper:seekWidgetByName(arg_7_0, "Image_surplusTime"):setVisible(true)
				ccui.Helper:seekWidgetByName(arg_7_0, "des1"):setVisible(true)
				ccui.Helper:seekWidgetByName(arg_7_0, "des2"):setVisible(true)
				ccui.Helper:seekWidgetByName(arg_7_0, "des3"):setVisible(true)
				ccui.Helper:seekWidgetByName(arg_7_0, "des1"):setColor(cc.c3b(169, 226, 255))
				ccui.Helper:seekWidgetByName(arg_7_0, "des1"):setString(recharge_data[arg_7_1.id].des1)
				ccui.Helper:seekWidgetByName(arg_7_0, "des2"):setString(recharge_data[arg_7_1.id].des2)
				ccui.Helper:seekWidgetByName(arg_7_0, "des3"):setString(recharge_data[arg_7_1.id].des3)
			end

			local var_10_0 = ccui.Helper:seekWidgetByName(arg_7_0, "des1")
			local var_10_1 = ccui.Helper:seekWidgetByName(arg_7_0, "des2")

			var_10_0:setPositionX(ccui.Helper:seekWidgetByName(arg_7_0, "Image_surplusTime"):getPositionX() + ccui.Helper:seekWidgetByName(arg_7_0, "Image_surplusTime"):getContentSize().width / 2)

			local var_10_3 = ccui.Helper:seekWidgetByName(arg_7_0, "Image_surplusTime"):getPositionX() + ccui.Helper:seekWidgetByName(arg_7_0, "Image_surplusTime"):getContentSize().width / 2 + var_10_0:getContentSize().width

			var_10_1:setPositionX(var_10_3)
			ccui.Helper:seekWidgetByName(arg_7_0, "des3"):setPositionX(var_10_3 + var_10_1:getContentSize().width)
		end
	end)()
end

function RechargeSprite1.updateNew(arg_11_0)
	ccui.Helper:seekWidgetByName(arg_11_0, "Image_new"):setVisible(false)
end

function RechargeSprite1.hideReddot(arg_12_0)
	ccui.Helper:seekWidgetByName(arg_12_0, "Image_new"):setVisible(false)
end

local var_0_14

RechargeSprite2 = class("rechargeSpriteUiType2", function()
	if not var_0_14 then
		var_0_14 = ccui.Helper:seekWidgetByName(ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "rechargeSpriteUiType2.json" or "rechargeSpriteUiType2.ExportJson"), "Button_rechargeClone")

		var_0_14:retain()
	end

	return var_0_14:clone()
end)

function RechargeSprite2:update(arg_14_1)
	self.info = arg_14_1

	local function var_14_0()
		ccui.Helper:seekWidgetByName(self, "Image_circle"):loadTexture("recharge/" .. arg_14_1.id .. "_circle.png", var_0_2)
		ccui.Helper:seekWidgetByName(self, "Image_circle"):setVisible(true)
		ccui.Helper:seekWidgetByName(self, "Image_circle"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.RotateBy:create(3, 360))))
		ccui.Helper:seekWidgetByName(self, "Button_dailyAward"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(1, 0.85, 0.85), cc.ScaleTo:create(1, 1, 1))))

		local var_16_0 = {
			[var_0_10.newbee_card] = {
				json = "spine/ui/recharge/blue.json",
				atlas = "spine/ui/recharge/blue.atlas"
			},
			[var_0_10.returnback_card] = {
				json = "spine/ui/recharge/red.json",
				atlas = "spine/ui/recharge/red.atlas"
			},
			[var_0_10.gold_card] = {
				json = "spine/ui/recharge/cyan.json",
				atlas = "spine/ui/recharge/cyan.atlas"
			},
			[var_0_10.gold_quarter_card] = {
				json = "spine/ui/recharge/cyan.json",
				atlas = "spine/ui/recharge/cyan.atlas"
			},
			[var_0_10.horcrux_card] = {
				json = "spine/ui/recharge/purple.json",
				atlas = "spine/ui/recharge/purple.atlas"
			},
			[var_0_10.diamond_month_card] = {
				json = "spine/ui/recharge/blue.json",
				atlas = "spine/ui/recharge/blue.atlas"
			},
			[var_0_10.diamond_quarter_card] = {
				json = "spine/ui/recharge/purple.json",
				atlas = "spine/ui/recharge/purple.atlas"
			},
			[var_0_10.diamond_year_card] = {
				json = "spine/ui/recharge/red.json",
				atlas = "spine/ui/recharge/red.atlas"
			}
		}
		local var_16_1 = self:getChildByName("spine")

		if not var_16_1 and var_16_0[arg_14_1.id] then
			var_16_1 = L2Skeleton:create(var_16_0[arg_14_1.id].json, var_16_0[arg_14_1.id].atlas)

			var_16_1:setName("spine")
			self:addChild(var_16_1)
		end

		var_16_1:resetL2Skeleton(var_16_0[arg_14_1.id].json, var_16_0[arg_14_1.id].atlas)
		var_16_1:refreshSkeleton()
		var_16_1.skeletonAnimation:setPositionX(ccui.Helper:seekWidgetByName(self, "Image_circlebg"):getPositionX())
		var_16_1.skeletonAnimation:setPositionY(ccui.Helper:seekWidgetByName(self, "Image_circlebg"):getPositionY())
		var_16_1:play("animation", true)
	end

	ccui.Helper:seekWidgetByName(self, "Button_buy"):setTouchEnabled(false)
	ccui.Helper:seekWidgetByName(self, "Label_cost"):setVisible(true)
	ccui.Helper:seekWidgetByName(self, "Image_circle"):setVisible(false)
	ccui.Helper:seekWidgetByName(self, "Image_circlebg"):setVisible(false)
	ccui.Helper:seekWidgetByName(self, "Image_discount"):setVisible(false)
	ccui.Helper:seekWidgetByName(self, "Image_discount"):setPositionY(264)

	if arg_14_1.id == var_0_10.forevercard or arg_14_1.id == var_0_10.month_card or arg_14_1.id == var_0_10.quartercard or arg_14_1.id == var_0_10.yearcard then
		if arg_14_1.remain and arg_14_1.remain > 0 then
			ccui.Helper:seekWidgetByName(self, "Image_47"):setVisible(true)
			ccui.Helper:seekWidgetByName(self, "Image_47"):setScale(1)

			if arg_14_1.id == var_0_10.forevercard then
				ccui.Helper:seekWidgetByName(self, "Label_surplusTime"):setString("∞天")
			else
				ccui.Helper:seekWidgetByName(self, "Label_surplusTime"):setString(arg_14_1.remain .. "天")
			end
		else
			ccui.Helper:seekWidgetByName(self, "Label_surplusTime"):setString("未购买")
			ccui.Helper:seekWidgetByName(self, "Image_47"):setVisible(false)

			if arg_14_1.discount then
				ccui.Helper:seekWidgetByName(self, "Image_discount"):setVisible(true)
				ccui.Helper:seekWidgetByName(self, "Image_discount"):getChildByName("Label_discount"):setText((arg_14_1.discount % 10 == 0 or nil) and (arg_14_1.discount / 10 .. ".0" or arg_14_1.discount / 10))
			end
		end

		ccui.Helper:seekWidgetByName(self, "Image_surplus_time"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "Image_surplus_canbuy_time"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "Button_dailyAward"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "Label_dailyAward"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "Label_surplusTime"):setVisible(true)
		ccui.Helper:seekWidgetByName(self, "Image_gettag"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "Button_buy"):loadTextures("recharge/recharge_" .. arg_14_1.id .. "_btn.png", "recharge/recharge_" .. arg_14_1.id .. "_btn.png", "recharge/recharge_" .. arg_14_1.id .. "_btn.png", var_0_2)
	elseif arg_14_1.id == var_0_10.newbee_card or arg_14_1.id == var_0_10.returnback_card or arg_14_1.id == var_0_10.gold_card or arg_14_1.id == var_0_10.gold_quarter_card or arg_14_1.id == var_0_10.horcrux_card or arg_14_1.id == var_0_10.diamond_month_card or arg_14_1.id == var_0_10.diamond_quarter_card or arg_14_1.id == var_0_10.diamond_year_card then
		ccui.Helper:seekWidgetByName(self, "Image_47"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "Image_surplus_time"):loadTexture("recharge/surplus_time_" .. arg_14_1.id .. ".png", var_0_2)
		ccui.Helper:seekWidgetByName(self, "Label_dailyAward"):setString((function(arg_15_0)
			local var_15_0 = ""
			local var_15_1 = drop_manager:getDropMsg(arg_15_0)

			if var_15_1.diamond > 0 then
				var_15_0 = L_DIAMOND .. "X" .. var_15_1.diamond
			end

			if var_15_1.gold > 0 then
				var_15_0 = L_GOLD .. "X" .. var_15_1.gold
			end

			for iter_15_0, iter_15_1 in pairs(var_15_1.equips) do
				var_15_0 = item_data[iter_15_1.dropid].name .. "X" .. iter_15_1.dropNum
			end

			return var_15_0
		end)(recharge_data[arg_14_1.id].dropid))
		ccui.Helper:seekWidgetByName(self, "Label_dailyAward"):setColor(cc.c3b(255, 224, 130))
		ccui.Helper:seekWidgetByName(self, "Image_circle"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "Image_circlebg"):setVisible(true)
		ccui.Helper:seekWidgetByName(self, "Image_circlebg"):loadTexture("recharge/" .. arg_14_1.id .. "_circle_bg.png", var_0_2)
		ccui.Helper:seekWidgetByName(self, "Button_buy"):loadTextures("recharge/recharge_" .. arg_14_1.id .. "_btn.png", "recharge/recharge_" .. arg_14_1.id .. "_btn.png", "recharge/recharge_" .. arg_14_1.id .. "_btn.png", var_0_2)

		if arg_14_1.id == var_0_10.newbee_card or arg_14_1.id == var_0_10.returnback_card then
			ccui.Helper:seekWidgetByName(self, "Image_surplus_canbuy_time"):loadTexture("recharge/surplus_canbuy_time_" .. arg_14_1.id .. ".png", var_0_2)
		end

		ccui.Helper:seekWidgetByName(self, "Button_dailyAward"):loadTextures("recharge/daily_item_" .. arg_14_1.id .. ".png", "recharge/daily_item_" .. arg_14_1.id .. ".png", "recharge/daily_item_" .. arg_14_1.id .. ".png", var_0_2)

		if arg_14_1.remain and arg_14_1.remain > 0 then
			ccui.Helper:seekWidgetByName(self, "Button_dailyAward"):setVisible(true)
			ccui.Helper:seekWidgetByName(self, "Label_surplusTime"):setVisible(false)
			ccui.Helper:seekWidgetByName(self, "Image_surplus_time"):setVisible(true)
			ccui.Helper:seekWidgetByName(self, "Image_surplus_canbuy_time"):setVisible(false)
			ccui.Helper:seekWidgetByName(self, "Image_surplus_time"):getChildByName("Label_day"):setString(arg_14_1.remain .. "天")

			if arg_14_1.id == var_0_10.newbee_card or arg_14_1.id == var_0_10.returnback_card then
				ccui.Helper:seekWidgetByName(self, "Button_buy"):loadTextures("recharge/btn_get_daily_award.png", "recharge/btn_get_daily_award.png", "recharge/btn_get_daily_award.png", var_0_2)
				ccui.Helper:seekWidgetByName(self, "Image_gettag"):setVisible(false)
				ccui.Helper:seekWidgetByName(self, "Label_dailyAward"):setVisible(true)

				playermodel.newbee_card_finishtime = os.time(parse_time(os.date("%Y-%m-%d 00:00:00", time_check_manager:getCurTime() + 2592000)))
			else
				ccui.Helper:seekWidgetByName(self, "Image_gettag"):setVisible(true)
				ccui.Helper:seekWidgetByName(self, "Image_gettag"):loadTexture("recharge/" .. arg_14_1.id .. "_tag_get.png", var_0_2)
				ccui.Helper:seekWidgetByName(self, "Label_dailyAward"):setVisible(false)
			end

			if arg_14_1.buy_limit and arg_14_1.have_bought >= arg_14_1.buy_limit then
				ccui.Helper:seekWidgetByName(self, "Label_cost"):setVisible(false)
			end

			if arg_14_1.lastreward then
				ccui.Helper:seekWidgetByName(self, "Label_dailyAward"):setColor(cc.c3b(177, 176, 186))
				ccui.Helper:seekWidgetByName(self, "Button_dailyAward"):loadTextures("recharge/daily_item_" .. arg_14_1.id .. "_off.png", "recharge/daily_item_" .. arg_14_1.id .. "_off.png", "recharge/daily_item_" .. arg_14_1.id .. "_off.png", var_0_2)

				if arg_14_1.id == var_0_10.gold_card or arg_14_1.id == var_0_10.gold_quarter_card or arg_14_1.id == var_0_10.horcrux_card or arg_14_1.id == var_0_10.diamond_month_card or arg_14_1.id == var_0_10.diamond_quarter_card or arg_14_1.id == var_0_10.diamond_year_card then
					ccui.Helper:seekWidgetByName(self, "Image_gettag"):loadTexture("recharge/" .. arg_14_1.id .. "_tag_got.png", var_0_2)
				else
					ccui.Helper:seekWidgetByName(self, "Button_buy"):loadTextures("recharge/recharge_" .. arg_14_1.id .. "_got_btn.png", "recharge/recharge_" .. arg_14_1.id .. "_got_btn.png", "recharge/recharge_" .. arg_14_1.id .. "_got_btn.png", var_0_2)
				end
			else
				var_14_0()
			end

			if self._rechargeBtnHanel then
				ccui.Helper:seekWidgetByName(self, "Button_buy"):setTouchEnabled(true)
				ccui.Helper:seekWidgetByName(self, "Button_buy"):addTouchEventListener(self._rechargeBtnHanel)
			end
		else
			ccui.Helper:seekWidgetByName(self, "Image_gettag"):setVisible(false)
			ccui.Helper:seekWidgetByName(self, "Button_dailyAward"):setVisible(false)
			ccui.Helper:seekWidgetByName(self, "Label_dailyAward"):setVisible(false)
			ccui.Helper:seekWidgetByName(self, "Image_surplus_time"):setVisible(false)
			ccui.Helper:seekWidgetByName(self, "Label_surplusTime"):setVisible(true)
			ccui.Helper:seekWidgetByName(self, "Label_surplusTime"):setString("未购买")

			if recharge_data[arg_14_1.id].canbuy_timeout then
				ccui.Helper:seekWidgetByName(self, "Image_surplus_canbuy_time"):setVisible(true)
				ccui.Helper:seekWidgetByName(self, "Image_surplus_canbuy_time"):getChildByName("Label_day"):setString((var_0_11(os.time(parse_time(arg_14_1.finishtime)) - time_check_manager:getCurTime())))
				ccui.Helper:seekWidgetByName(self, "Image_discount"):setPositionY(231)
			else
				ccui.Helper:seekWidgetByName(self, "Image_surplus_canbuy_time"):setVisible(false)
			end

			if arg_14_1.discount then
				ccui.Helper:seekWidgetByName(self, "Image_discount"):setVisible(true)
				ccui.Helper:seekWidgetByName(self, "Image_discount"):getChildByName("Label_discount"):setText((arg_14_1.discount % 10 == 0 or nil) and (arg_14_1.discount / 10 .. ".0" or arg_14_1.discount / 10))
			end
		end
	end

	var_0_12(self, arg_14_1)
	;(function()
		ccui.Helper:seekWidgetByName(self, "Image_costcurrency"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "Label_cost"):setString(recharge_manager:getCommodityPriceStr(arg_14_1.id))
	end)()
	ccui.Helper:seekWidgetByName(self, "Image_buylimit"):setVisible(false)
	ccui.Helper:seekWidgetByName(self, "Image_buytips"):setVisible(false)

	if arg_14_1.id == var_0_10.newbee_card or arg_14_1.id == var_0_10.returnback_card then
		ccui.Helper:seekWidgetByName(self, "Image_buytips"):loadTexture("recharge/buy_tips_" .. arg_14_1.id .. ".png", var_0_2)
		ccui.Helper:seekWidgetByName(self, "Image_buytips"):setVisible(true)
	end

	self:updateNew()

	local var_14_2 = self:getChildByName("Image_rewardDouble")

	if not var_14_2 then
		var_14_2 = TempWidget:CreateTempImg("public/panelbg/double_reward.png", self, var_0_2)

		var_14_2:setName("Image_rewardDouble")
	end

	if arg_14_1.reward_double then
		var_14_2:setVisible(true)

		if arg_14_1.remain and arg_14_1.remain > 0 then
			var_14_2:loadTextureEx("public/panelbg/double_reward1.png")

			local var_14_3 = self:getContentSize().width

			var_14_2:align(cc.p(0, 1), 0, self:getContentSize().height)
		else
			var_14_2:loadTextureEx("public/panelbg/double_reward.png")
			var_14_2:align(cc.p(1, 1), self:getContentSize().width, self:getContentSize().height)
		end
	elseif var_14_2 then
		var_14_2:setVisible(false)
	end
end

function RechargeSprite2:updateNew()
	if self.info.remain and self.info.remain > 0 and not self.info.lastreward and (self.info.id == var_0_10.newbee_card or self.info.id == var_0_10.returnback_card or self.info.id == var_0_10.gold_card or self.info.id == var_0_10.gold_quarter_card or self.info.id == var_0_10.horcrux_card or self.info.id == var_0_10.diamond_month_card or self.info.id == var_0_10.diamond_quarter_card or self.info.id == var_0_10.diamond_year_card) then
		ccui.Helper:seekWidgetByName(self, "Image_new"):loadTexture("public/reddot/reddot2.png", var_0_2)
		ccui.Helper:seekWidgetByName(self, "Image_new"):setVisible(true)
		ccui.Helper:seekWidgetByName(self, "Image_new"):setPosition(cc.p(460, 223))
	elseif self.info.new_tag and self.info.new_tag == 2 then
		ccui.Helper:seekWidgetByName(self, "Image_new"):loadTexture("public/reddot/new.png", var_0_2)
		ccui.Helper:seekWidgetByName(self, "Image_new"):setVisible(true)
		ccui.Helper:seekWidgetByName(self, "Image_new"):setPosition(cc.p(528, 292))
	else
		ccui.Helper:seekWidgetByName(self, "Image_new"):loadTexture("public/reddot/new.png", var_0_2)
		ccui.Helper:seekWidgetByName(self, "Image_new"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "Image_new"):setPosition(cc.p(528, 292))
	end
end

function RechargeSprite2.setrechargeBtnHanel(arg_20_0, arg_20_1)
	arg_20_0._rechargeBtnHanel = arg_20_1
end

function RechargeSprite2.hideReddot(arg_21_0)
	ccui.Helper:seekWidgetByName(arg_21_0, "Image_new"):setVisible(false)
end

local var_0_15

RechargeSprite3 = class("rechargeSpriteUiType3", function()
	if not var_0_15 then
		var_0_15 = ccui.Helper:seekWidgetByName(ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "rechargeSpriteUiType3.json" or "rechargeSpriteUiType3.ExportJson"), "Button_rechargeClone")

		var_0_15:retain()
	end

	return var_0_15:clone()
end)

function RechargeSprite3.update(arg_23_0, arg_23_1)
	ccui.Helper:seekWidgetByName(arg_23_0, "Image_price"):setVisible(arg_23_1.shop_type ~= 1 and arg_23_1.shop_type ~= 2)
	ccui.Helper:seekWidgetByName(arg_23_0, "Image_surplusTime"):setVisible(false)
	ccui.Helper:seekWidgetByName(arg_23_0, "Image_discount"):setVisible(false)

	if arg_23_1.remain and arg_23_1.remain > 0 then
		ccui.Helper:seekWidgetByName(arg_23_0, "Image_surplusTime"):setVisible(true)
		ccui.Helper:seekWidgetByName(arg_23_0, "Image_47"):setScale(1)
		ccui.Helper:seekWidgetByName(arg_23_0, "Label_surplusTime"):setFontSize(22)

		if arg_23_1.id == var_0_10.month_card or arg_23_1.id == var_0_10.diamond_month_card then
			ccui.Helper:seekWidgetByName(arg_23_0, "Label_surplusTime"):setString("剩余:∞日")
			ccui.Helper:seekWidgetByName(arg_23_0, "Label_surplusTime"):setColor(cc.c3b(255, 204, 0))
			ccui.Helper:seekWidgetByName(arg_23_0, "Image_47"):loadTexture("recharge/forever_card_time.png", var_0_2)
		elseif arg_23_1.id == var_0_10.yearcard or arg_23_1.id == var_0_10.diamond_year_card then
			ccui.Helper:seekWidgetByName(arg_23_0, "Label_surplusTime"):setString("剩余:" .. arg_23_1.remain .. "日")
			ccui.Helper:seekWidgetByName(arg_23_0, "Label_surplusTime"):setColor(cc.c3b(255, 204, 0))
			ccui.Helper:seekWidgetByName(arg_23_0, "Image_47"):loadTexture("recharge/quarter_card_time.png", var_0_2)
		elseif arg_23_1.id == var_0_10.quartercard or arg_23_1.id == var_0_10.diamond_quarter_card then
			ccui.Helper:seekWidgetByName(arg_23_0, "Label_surplusTime"):setString("剩余:" .. arg_23_1.remain .. "日")
			ccui.Helper:seekWidgetByName(arg_23_0, "Label_surplusTime"):setColor(cc.c3b(255, 0, 255))
			ccui.Helper:seekWidgetByName(arg_23_0, "Image_47"):loadTexture("recharge/quarter_card_time.png", var_0_2)
		else
			ccui.Helper:seekWidgetByName(arg_23_0, "Label_surplusTime"):setString("剩余:" .. arg_23_1.remain .. "日")
			ccui.Helper:seekWidgetByName(arg_23_0, "Label_surplusTime"):setColor(cc.c3b(0, 255, 252))
			ccui.Helper:seekWidgetByName(arg_23_0, "Image_47"):loadTexture("recharge/month_card_time.png", var_0_2)
		end
	elseif arg_23_1.discount then
		ccui.Helper:seekWidgetByName(arg_23_0, "Image_discount"):setVisible(true)
		ccui.Helper:seekWidgetByName(arg_23_0, "Image_discount"):getChildByName("Label_discount"):setText((arg_23_1.discount % 10 == 0 or nil) and (arg_23_1.discount / 10 .. ".0" or arg_23_1.discount / 10))
	end

	var_0_12(arg_23_0, arg_23_1)
	;(function()
		if not arg_23_0:getChildByName("Label_price") then
			local var_24_0 = cc.Label:createWithTTF("", FONT_BUTTON, 28)

			var_24_0:setPosition(cc.p(396, 88))
			var_24_0:setName("Label_price")
			arg_23_0:addChild(var_24_0)
		end

		arg_23_0:getChildByName("Label_price"):setVisible(false)
	end)()
	ccui.Helper:seekWidgetByName(arg_23_0, "Image_new"):setVisible(false)

	if arg_23_1.type == 11 and arg_23_1.have_bought == 0 then
		ccui.Helper:seekWidgetByName(arg_23_0, "Image_new"):loadTexture("public/reddot/reddot2.png", var_0_2)
		ccui.Helper:seekWidgetByName(arg_23_0, "Image_new"):setVisible(true)
	elseif arg_23_1.type == 8 and not arg_23_1.rmb and arg_23_1.price_diamond == 0 and arg_23_1.have_bought < arg_23_1.buy_limit and playermodel.grade >= recharge_data[arg_23_1.id].buy_grade_limit then
		ccui.Helper:seekWidgetByName(arg_23_0, "Image_new"):loadTexture("public/reddot/reddot2.png", var_0_2)
		ccui.Helper:seekWidgetByName(arg_23_0, "Image_new"):setVisible(true)
	end
end

RechargeSprite10 = class("RechargeSprite10", ShopSprite.getClass("shopSpriteType3"))

local var_0_16 = {
	[6800202] = "public/currency/6800202.png",
	[SHOP_CURRENCY_GOLD] = "public/currency/UI_battleEnd_gold.png",
	[SHOP_CURRENCY_DIAMOND] = "public/currency/UI_battleEnd_diamond.png",
	[SHOP_CURRENCY_HORNOR] = "public/currency/arenascene_dot_1.png",
	[SHOP_CURRENCY_EXPLORECOIN] = "public/currency/explorecoin.png",
	[SHOP_CURRENCY_RMB] = "public/currency/rmb_white.png",
	[BLACK_CARD] = "public/currency/1500001_1.png",
	[BLACK_SP_CARD] = "public/currency/1500002_1.png",
	[85000006] = "equipment/" .. item_data[85000006].image_id .. ".png"
}

setmetatable(var_0_16, {
	__index = function(arg_25_0, arg_25_1)
		return "public/currency/" .. item_data[arg_25_1].image_id .. ".png"
	end
})

local function var_0_17(arg_26_0)
	if item_data[arg_26_0].bag_item_type == kITEM_WEAPON then
		return playermodel.haveServant[item_data[arg_26_0].servant]
	end

	return true
end

function RechargeSprite10:update(arg_27_1)
	local var_27_0 = item_data[arg_27_1.itemtype].bag_item_type == kITEM_SKIN and "mainScenebg/market/" .. item_data[arg_27_1.itemtype].model .. ".png" or "mainScenebg/market/" .. item_data[arg_27_1.itemtype].image_id .. ".png"
	local var_27_1 = {}

	var_27_1.sell_out = arg_27_1.buy_limit and arg_27_1.buy_limit <= arg_27_1.have_bought
	var_27_1.bag_item_type = item_data[arg_27_1.itemtype].bag_item_type
	var_27_1.buy_limit = arg_27_1.buy_limit
	var_27_1.purchaseid = arg_27_1.productid
	var_27_1.costIcon = var_0_16[arg_27_1.currency]
	var_27_1.discount = arg_27_1.discount
	var_27_1.itemid = arg_27_1.itemtype
	var_27_1.touchCallBack = arg_27_1.touchCallBack
	var_27_1.currency = arg_27_1.currency
	var_27_1.finish_time = arg_27_1.finish_time
	var_27_1.quality = item_data[arg_27_1.itemtype].equip_quality or 1
	var_27_1.cost = arg_27_1.discount * arg_27_1.item_number or arg_27_1.price * arg_27_1.item_number
	var_27_1.canUse = var_0_17(arg_27_1.itemtype)
	var_27_1.isnewitem = arg_27_1.isnewitem
	var_27_1.tag = arg_27_1.tag or 0
	var_27_1.shopid = arg_27_1.shopid
	var_27_1.pos = arg_27_1.pos
	var_27_1.cost_old = arg_27_1.price
	var_27_1.have_bought = arg_27_1.have_bought
	var_27_1.is_lock_activitycity = arg_27_1.is_lock_activitycity
	var_27_1.name = item_data[arg_27_1.itemtype].name
	var_27_1.icon = var_27_0

	self.super.update(self, var_27_1)
end

local var_0_18

RechargeSprite4 = class("rechargeSpriteUiType4", function()
	if not var_0_18 then
		var_0_18 = ccui.Helper:seekWidgetByName(ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "rechargeSpriteUiType4.json" or "rechargeSpriteUiType4.ExportJson"), "Button_rechargeDiamond")

		var_0_18:retain()
	end

	return var_0_18:clone()
end)

function RechargeSprite4.update(arg_29_0, arg_29_1)
	ccui.Helper:seekWidgetByName(arg_29_0, "Label_name"):setFontSize(30)
	ccui.Helper:seekWidgetByName(arg_29_0, "Label_name_dark"):setFontSize(30)
	ccui.Helper:seekWidgetByName(arg_29_0, "Button_bg"):loadTextures("mainScenebg/recharge/" .. arg_29_1.id .. ".png", "mainScenebg/recharge/" .. arg_29_1.id .. ".png", "mainScenebg/recharge/" .. arg_29_1.id .. ".png")
	ccui.Helper:seekWidgetByName(arg_29_0, "Label_name"):setString(arg_29_1.name)
	ccui.Helper:seekWidgetByName(arg_29_0, "Label_name_dark"):setString(arg_29_1.name)
	ccui.Helper:seekWidgetByName(arg_29_0, "Label_no"):setString(arg_29_1.no .. "档")
	ccui.Helper:seekWidgetByName(arg_29_0, "Label_no"):setPositionY(110)
	ccui.Helper:seekWidgetByName(arg_29_0, "Label_des"):setAnchorPoint(cc.p(0.5, 1))
	ccui.Helper:seekWidgetByName(arg_29_0, "Label_des"):setString("累计达到" .. recharge_data[arg_29_1.id].need_total_recharge .. "元\n     即可获得")
	ccui.Helper:seekWidgetByName(arg_29_0, "Image_new"):setVisible(false)
	ccui.Helper:seekWidgetByName(arg_29_0, "Image_new"):setVisible(false)

	local var_29_0 = ccui.Helper:seekWidgetByName(arg_29_0, "Label_name"):getPositionX()
	local var_29_1 = ccui.Helper:seekWidgetByName(arg_29_0, "Label_name"):getContentSize().width

	ccui.Helper:seekWidgetByName(arg_29_0, "Label_name"):setPositionY(110)
	ccui.Helper:seekWidgetByName(arg_29_0, "Label_name_dark"):setPositionY(ccui.Helper:seekWidgetByName(arg_29_0, "Label_name"):getPositionY() - 2)
	ccui.Helper:seekWidgetByName(arg_29_0, "Image_left_brace"):setPositionX(var_29_0 - var_29_1 / 2)
	ccui.Helper:seekWidgetByName(arg_29_0, "Image_right_brace"):setPositionX(var_29_0 + var_29_1 / 2)
	ccui.Helper:seekWidgetByName(arg_29_0, "Image_left_brace"):setPositionY(ccui.Helper:seekWidgetByName(arg_29_0, "Label_name"):getPositionY() + 12)
	ccui.Helper:seekWidgetByName(arg_29_0, "Image_right_brace"):setPositionY(ccui.Helper:seekWidgetByName(arg_29_0, "Label_name"):getPositionY() - 12)
	ccui.Helper:seekWidgetByName(arg_29_0, "Label_des"):setVisible(true)
	ccui.Helper:seekWidgetByName(arg_29_0, "Image_can_get_award"):setVisible(false)
	ccui.Helper:seekWidgetByName(arg_29_0, "Image_can_get_award"):setPosition(cc.p(456, 27))

	if recharge_data[arg_29_1.id].dropid_ext then
		if arg_29_1.have_bought >= arg_29_1.buy_limit and arg_29_1.have_bought_ext >= arg_29_1.buy_limit then
			ccui.Helper:seekWidgetByName(arg_29_0, "Button_bg"):loadTextures("mainScenebg/recharge/" .. arg_29_1.id .. ".png", "mainScenebg/recharge/" .. arg_29_1.id .. ".png", "mainScenebg/recharge/" .. arg_29_1.id .. ".png")
			ccui.Helper:seekWidgetByName(arg_29_0, "Panel_mask"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_29_0, "Label_complete_award"):setVisible(false)
			ccui.Helper:seekWidgetByName(arg_29_0, "Label_complete_award"):setFontSize(32)
			ccui.Helper:seekWidgetByName(arg_29_0, "Label_complete_award"):setString(L_BUTTON_TEXT.Got)
			ccui.Helper:seekWidgetByName(arg_29_0, "Label_des"):setVisible(false)
			ccui.Helper:seekWidgetByName(arg_29_0, "Image_can_get_award"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_29_0, "Image_can_get_award"):loadTexture("recharge/diamond_num_btn.png", var_0_2)
		else
			ccui.Helper:seekWidgetByName(arg_29_0, "Button_bg"):loadTextures("mainScenebg/recharge/" .. arg_29_1.id .. "_ext.png", "mainScenebg/recharge/" .. arg_29_1.id .. "_ext.png", "mainScenebg/recharge/" .. arg_29_1.id .. "_ext.png")
			ccui.Helper:seekWidgetByName(arg_29_0, "Panel_mask"):setVisible(false)
			ccui.Helper:seekWidgetByName(arg_29_0, "Label_complete_award"):setVisible(false)
		end

		if arg_29_1.have_bought < arg_29_1.buy_limit then
			ccui.Helper:seekWidgetByName(arg_29_0, "Button_bg"):loadTextures("mainScenebg/recharge/" .. arg_29_1.id .. ".png", "mainScenebg/recharge/" .. arg_29_1.id .. ".png", "mainScenebg/recharge/" .. arg_29_1.id .. ".png")
		end

		if playermodel.rechargeamount >= recharge_data[arg_29_1.id].need_total_recharge then
			if arg_29_1.have_bought < arg_29_1.buy_limit then
				ccui.Helper:seekWidgetByName(arg_29_0, "Label_des"):setVisible(false)
				ccui.Helper:seekWidgetByName(arg_29_0, "Image_can_get_award"):setVisible(true)
				ccui.Helper:seekWidgetByName(arg_29_0, "Image_can_get_award"):loadTexture("recharge/can_get_award.png", var_0_2)
			elseif arg_29_1.have_bought == arg_29_1.buy_limit and arg_29_1.have_bought_ext < arg_29_1.buy_limit then
				ccui.Helper:seekWidgetByName(arg_29_0, "Label_des"):setVisible(false)
				ccui.Helper:seekWidgetByName(arg_29_0, "Image_can_get_award"):setVisible(true)
				ccui.Helper:seekWidgetByName(arg_29_0, "Image_can_get_award"):loadTexture("recharge/can_continue_get_award.png", var_0_2)
			end
		end
	else
		if arg_29_1.have_bought == arg_29_1.buy_limit then
			ccui.Helper:seekWidgetByName(arg_29_0, "Panel_mask"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_29_0, "Label_complete_award"):setVisible(false)
			ccui.Helper:seekWidgetByName(arg_29_0, "Label_complete_award"):setFontSize(32)
			ccui.Helper:seekWidgetByName(arg_29_0, "Label_complete_award"):setString(L_BUTTON_TEXT.Got)
			ccui.Helper:seekWidgetByName(arg_29_0, "Label_des"):setVisible(false)
			ccui.Helper:seekWidgetByName(arg_29_0, "Image_can_get_award"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_29_0, "Image_can_get_award"):loadTexture("recharge/diamond_num_btn.png", var_0_2)
		else
			ccui.Helper:seekWidgetByName(arg_29_0, "Panel_mask"):setVisible(false)
			ccui.Helper:seekWidgetByName(arg_29_0, "Label_complete_award"):setVisible(false)
		end

		if arg_29_1.have_bought < arg_29_1.buy_limit and playermodel.rechargeamount >= recharge_data[arg_29_1.id].need_total_recharge then
			ccui.Helper:seekWidgetByName(arg_29_0, "Label_des"):setVisible(false)
			ccui.Helper:seekWidgetByName(arg_29_0, "Image_can_get_award"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_29_0, "Image_can_get_award"):loadTexture("recharge/can_get_award.png", var_0_2)
		end
	end

	ccui.Helper:seekWidgetByName(arg_29_0, "Image_new"):setVisible(false)

	if arg_29_1.type == 9 and playermodel.rechargeamount >= recharge_data[arg_29_1.id].need_total_recharge and (arg_29_1.have_bought == 0 or recharge_data[arg_29_1.id].dropid_ext and arg_29_1.have_bought_ext == 0) then
		ccui.Helper:seekWidgetByName(arg_29_0, "Image_new"):loadTexture("public/reddot/reddot2.png", var_0_2)
		ccui.Helper:seekWidgetByName(arg_29_0, "Image_new"):setVisible(true)
		ccui.Helper:seekWidgetByName(arg_29_0, "Image_new"):setPositionX(540)
		ccui.Helper:seekWidgetByName(arg_29_0, "Image_new"):setPositionY(40)
		ccui.Helper:seekWidgetByName(arg_29_0, "Image_new"):setLocalZOrder(100)
	end
end

function RechargeSprite4.hideReddot(arg_30_0)
	ccui.Helper:seekWidgetByName(arg_30_0, "Image_new"):setVisible(false)
end

local var_0_19
local var_0_20

RechargeSprite5 = class("rechargeSpriteUiType5", function()
	if not rechargeSpriteUiType5 then
		local var_31_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "rechargeSpriteUiType5.json" or "rechargeSpriteUiType5.ExportJson")

		var_0_19 = ccui.Helper:seekWidgetByName(var_31_0, "Button_rechargeClone")
		var_0_20 = ccui.Helper:seekWidgetByName(var_31_0, "ItemSprite")

		var_0_19:retain()
		var_0_20:retain()
	end

	return var_0_19:clone()
end)

function RechargeSprite5:update(arg_32_1, arg_32_2)
	self.info = arg_32_1

	print(dump(arg_32_1))

	local function var_32_0(arg_33_0, arg_33_1, arg_33_2)
		local var_33_0 = var_0_20:clone()
		local var_33_1
		local var_33_3

		if arg_33_0 == "diamond" then
			var_33_1 = 5
			var_33_3 = "1000000"
		else
			var_33_1 = item_data[arg_33_0].equip_quality
			var_33_3 = item_data[arg_33_0].image_id
		end

		var_33_0:loadTexture("public/box/" .. var_33_1 .. ".png", var_0_2)
		var_33_0:getChildByName("Image_44"):loadTexture("equipment/" .. var_33_3 .. ".png")
		var_33_0:getChildByName("Image_44"):setScale(0.55)
		var_33_0:getChildByName("Label_45"):setString("X" .. (arg_33_1 or 0))
		var_33_0:getChildByName("Image_46"):setVisible(arg_33_2)
		var_33_0:setTouchEnabled(false)

		return var_33_0
	end

	local var_32_1 = ccui.Helper:seekWidgetByName(self, "Button_bg")
	local var_32_2 = string.format("mainScenebg/recharge/%s.png", arg_32_1.id)

	var_32_1:loadTextures(var_32_2, nil, var_32_2)

	local var_32_3 = var_32_1:getChildByName("time_bg")

	var_32_3:getChildByName("time"):setString(string.format(L_NEW_DIAMOND_CARD_LESS_TIME[arg_32_1.id], arg_32_1.remain))
	var_32_3:setVisible(arg_32_1.remain > 0)
	ccui.Helper:seekWidgetByName(self, "Button_buy"):getChildByName("Label_cost"):setString(recharge_manager:getCommodityPriceStr(arg_32_1.id))

	if self._rechargeBtnHanel then
		ccui.Helper:seekWidgetByName(self, "Button_buy"):setTouchEnabled(true)
		ccui.Helper:seekWidgetByName(self, "Button_buy"):addTouchEventListener(self._rechargeBtnHanel)
	end

	local var_32_4 = arg_32_1.reward_double and 2 or 1
	local var_32_5 = 0
	local var_32_6 = drop_manager:getDropMsg(recharge_data[arg_32_1.id].dropid)
	local var_32_7 = var_32_1:getChildByName("reward")

	if var_32_6.diamond > 0 then
		local var_32_8 = var_32_0("diamond", var_32_6.diamond * var_32_4, arg_32_1.lastreward == true)

		var_32_8:setPosition(cc.p(43 + 75 * var_32_5, 45))
		var_32_8:setScale(0.8)
		var_32_7:addChild(var_32_8)

		var_32_5 = var_32_5 + 1
	end

	for iter_32_0, iter_32_1 in pairs(var_32_6.equips) do
		local var_32_9 = var_32_0(iter_32_1.dropid, iter_32_1.dropNum * var_32_4, arg_32_1.lastreward == true)

		var_32_9:setPosition(cc.p(43 + 75 * var_32_5, 45))
		var_32_9:setScale(0.8)
		var_32_7:addChild(var_32_9)

		var_32_5 = var_32_5 + 1
	end

	var_32_7:getChildByName("Image_49"):setVisible(arg_32_1.reward_double == true)

	local var_32_10 = var_32_1:getChildByName("btn_total_reward")
	local var_32_11 = var_32_10:getChildByName("time")
	local var_32_12 = var_32_10:getChildByName("total_reward_bg")
	local var_32_13 = var_32_10:getChildByName("touch")

	var_32_12:setLocalZOrder(999)
	var_32_13:setLocalZOrder(888)
	var_32_10:addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_32_13:setVisible(true)
		var_32_12:setVisible(true)
	end)
	var_32_13:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_32_13:setVisible(false)
		var_32_12:setVisible(false)
	end)

	if arg_32_1.remain <= 0 then
		var_32_11:setString(L_SHOPSPRITE[4])
	else
		var_32_11:setString(string.format(L_NEW_DIAMOND_CARD_TOTAL_TIME, arg_32_1.total_card_reward))
	end

	local var_32_14 = var_32_12:getChildByName("lbl_des")
	local var_32_15 = var_32_12:getChildByName("listView")

	var_32_15:removeAllItems()
	var_32_14:setString(L_NEW_DIAMOND_CARD_TOTAL_DES)

	for iter_32_2 = 1, 30 do
		if recharge_data[arg_32_1.id]["total_recharge_" .. iter_32_2] then
			local var_32_17 = drop_manager:getDropMsg(recharge_data[arg_32_1.id]["total_recharge_" .. iter_32_2])

			if var_32_17.diamond > 0 then
				local var_32_18 = var_32_0("diamond", var_32_17.diamond, iter_32_2 <= arg_32_1.total_card_reward)

				var_32_18:setScale(0.8)

				local var_32_19 = cc.Label:createWithTTF(string.format(L_THE_DAY, iter_32_2), FONT_BUTTON, 22)

				var_32_19:setPosition(cc.p(43, -20))
				var_32_18:addChild(var_32_19)
				var_32_15:pushBackCustomItem(var_32_18)
			end

			for iter_32_3, iter_32_4 in pairs(var_32_17.equips) do
				local var_32_20 = var_32_0(iter_32_4.dropid, iter_32_4.dropNum, iter_32_2 <= arg_32_1.total_card_reward)

				var_32_20:setScale(0.8)

				local var_32_21 = cc.Label:createWithTTF(string.format(L_THE_DAY, iter_32_2), FONT_BUTTON, 22)

				var_32_21:setPosition(cc.p(43, -20))
				var_32_20:addChild(var_32_21)
				var_32_15:pushBackCustomItem(var_32_20)
			end
		end
	end

	if arg_32_2 or arg_32_1.remain and arg_32_1.remain > 0 or arg_32_1.id ~= var_0_10.diamond_month_card and arg_32_1.id ~= var_0_10.diamond_quarter_card and arg_32_1.id ~= var_0_10.diamond_year_card and arg_32_1.id ~= var_0_10.returnback_card then
		self:getChildByName("Button_bg"):setVisible(true)
		self:getChildByName("Image_new"):setVisible(true)
		self:getChildByName("Button_buy"):setVisible(true)
		self:getChildByName("Button_preview"):setVisible(false)
	else
		self:getChildByName("Button_bg"):setVisible(false)
		self:getChildByName("Image_new"):setVisible(false)
		self:getChildByName("Button_buy"):setVisible(false)
		self:getChildByName("Button_preview"):setVisible(true)
		self:getChildByName("Button_preview"):setTouchEnabled(false)
		self:getChildByName("Button_preview"):loadTextures("mainScenebg/recharge/" .. arg_32_1.id .. "_preview.png", nil, "mainScenebg/recharge/" .. arg_32_1.id .. "_preview.png")

		if self._rechargeBtnHanel then
			self:getChildByName("Button_preview"):setTouchEnabled(true)
			self:getChildByName("Button_preview"):addTouchEventListener(self._rechargeBtnHanel)
		end
	end

	self:updateNew()
end

function RechargeSprite5:updateNew()
	if self.info.remain and self.info.remain > 0 and not self.info.lastreward and (self.info.id == var_0_10.newbee_card or self.info.id == var_0_10.returnback_card or self.info.id == var_0_10.gold_card or self.info.id == var_0_10.gold_quarter_card or self.info.id == var_0_10.horcrux_card or self.info.id == var_0_10.diamond_month_card or self.info.id == var_0_10.diamond_quarter_card or self.info.id == var_0_10.diamond_year_card) then
		ccui.Helper:seekWidgetByName(self, "Image_new"):loadTexture("public/reddot/reddot2.png", var_0_2)
		ccui.Helper:seekWidgetByName(self, "Image_new"):setVisible(true)
		ccui.Helper:seekWidgetByName(self, "Image_new"):setPosition(cc.p(460, 223))
	elseif self.info.new_tag and self.info.new_tag == 2 then
		ccui.Helper:seekWidgetByName(self, "Image_new"):loadTexture("public/reddot/new.png", var_0_2)
		ccui.Helper:seekWidgetByName(self, "Image_new"):setVisible(true)
		ccui.Helper:seekWidgetByName(self, "Image_new"):setPosition(cc.p(528, 292))
	else
		ccui.Helper:seekWidgetByName(self, "Image_new"):loadTexture("public/reddot/new.png", var_0_2)
		ccui.Helper:seekWidgetByName(self, "Image_new"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "Image_new"):setPosition(cc.p(528, 292))
	end
end

function RechargeSprite5.setrechargeBtnHanel(arg_37_0, arg_37_1)
	arg_37_0._rechargeBtnHanel = arg_37_1
end

function RechargeSprite5.hideReddot(arg_38_0)
	ccui.Helper:seekWidgetByName(arg_38_0, "Image_new"):setVisible(false)
end

local var_0_21

RechargeSprite6 = class("rechargeSpriteUiType6", function()
	if not var_0_21 then
		var_0_21 = ccui.Helper:seekWidgetByName(ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "rechargeSpriteUiType6.json" or "rechargeSpriteUiType6.ExportJson"), "Button_rechargeDiamond")

		var_0_21:retain()
	end

	return var_0_21:clone()
end)

function RechargeSprite6:update(arg_40_1)
	self:loadTextures("mainScenebg/recharge/" .. arg_40_1.id .. ".png", "mainScenebg/recharge/" .. arg_40_1.id .. ".png", "mainScenebg/recharge/" .. arg_40_1.id .. ".png")
	ccui.Helper:seekWidgetByName(self, "level"):setString(arg_40_1.no)
	ccui.Helper:seekWidgetByName(self, "name"):setString(recharge_data[arg_40_1.id].name)

	local var_40_0 = drop_manager:getDropMsg(recharge_data[arg_40_1.id].dropid)

	for iter_40_0 = 1, 3 do
		local var_40_1 = self:getChildByName("item_" .. iter_40_0)

		if var_40_1 then
			var_40_1:removeFromParent()
		end
	end

	local var_40_2 = 1

	if var_40_0.diamond and var_40_0.diamond > 0 then
		local var_40_3 = ItemSprite:createNewWithItemId("diamond", var_40_0.diamond)

		var_40_3:setName("item_" .. var_40_2)
		var_40_3:setScale(0.36)
		var_40_3:setPosition(cc.p(200, 68))
		self:addChild(var_40_3)

		var_40_2 = var_40_2 + 1
	end

	for iter_40_1 = 1, 3 do
		if var_40_0.equips[iter_40_1] then
			local var_40_4 = ItemSprite:createNewWithItemId(var_40_0.equips[iter_40_1].dropid, var_40_0.equips[iter_40_1].dropNum)

			var_40_4:setName("item_" .. var_40_2 + iter_40_1)
			var_40_4:setPosition(cc.p(60 + (iter_40_1 + var_40_2) * 70, 68))
			var_40_4:setScale(0.36)
			self:addChild(var_40_4)
		end
	end

	if playermodel.rechargeamount >= recharge_data[arg_40_1.id].need_total_recharge then
		if arg_40_1.have_bought < arg_40_1.buy_limit then
			ccui.Helper:seekWidgetByName(self, "Button_22"):loadTextures("recharge/total_recharge_reward.png", nil, "recharge/total_recharge_reward.png", var_0_2)
		elseif arg_40_1.have_bought == arg_40_1.buy_limit then
			ccui.Helper:seekWidgetByName(self, "Button_22"):loadTextures("recharge/total_recharge_got.png", nil, "recharge/total_recharge_got.png", var_0_2)
		end
	else
		ccui.Helper:seekWidgetByName(self, "Button_22"):loadTextures("recharge/total_recharge_goto.png", nil, "recharge/total_recharge_goto.png", var_0_2)
	end

	ccui.Helper:seekWidgetByName(self, "Button_22"):setSwallowTouches(false)
end

function RechargeSprite6.hideReddot(arg_41_0)
	ccui.Helper:seekWidgetByName(arg_41_0, "Image_new"):setVisible(false)
end

function RechargeSprite.create(arg_42_0, arg_42_1)
	local var_42_0 = {
		function()
			return RechargeSprite1.new()
		end,
		function()
			return RechargeSprite2.new()
		end,
		function()
			return RechargeSprite3.new()
		end,
		function()
			return RechargeSprite4.new()
		end,
		function()
			return RechargeSprite5.new()
		end,
		function()
			return RechargeSprite6.new()
		end,
		[10] = function()
			return RechargeSprite10.new()
		end
	}

	setmetatable(var_42_0, {
		__index = function(arg_50_0, arg_50_1)
			return function()
				return RechargeSprite1.new()
			end
		end
	})

	return var_42_0[arg_42_1]()
end

return RechargeSprite
