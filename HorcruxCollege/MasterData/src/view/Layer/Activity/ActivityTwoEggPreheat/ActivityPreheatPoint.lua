ActivityPreheatPoint = class("ActivityPreheatPoint", function()
	return cc.Layer:create()
end)

local item_data = require("data.item_data")
local activity_proceed_data = require("data.activity_proceed_data")
local drop_data = require("data.drop_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_img_data = require("data.activity_img_data")
local activity_manager = require("controller.activity_manager")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")

require("view.Sprite.ItemSprite")

local var_0_8 = config._DEBUG and 0 or 1
local var_0_9 = "Activity_PointActivityLayer/complete_button.png"
local var_0_10 = "Activity_PointActivityLayer/uncomplete_button.png"
local var_0_11 = "Activity_PointActivityLayer/completed_arrow.png"
local var_0_12 = "Activity_PointActivityLayer/uncompleted_arrow.png"
local var_0_13 = "Activity_PointActivityLayer/completed_box.png"
local var_0_14 = "Activity_PointActivityLayer/uncompleted_box.png"
local var_0_15 = 1
local var_0_16 = 0
local var_0_17 = 2
local var_0_18 = 13

function ActivityPreheatPoint.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityPreheatPoint.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityPreheatPoint:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityPoint.json" or "ActivityPoint.ExportJson")

	self:addChild(self.rootLayer)

	self.scrollView = ccui.Helper:seekWidgetByName(self.rootLayer, "scroll_view")
	self.panelTop = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_top")
	self.panelDown = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_down")
	self.toptile = ccui.Helper:seekWidgetByName(self.rootLayer, "titletop")
	self.medium = ccui.Helper:seekWidgetByName(self.rootLayer, "midelimg")
	self.dibu = ccui.Helper:seekWidgetByName(self.rootLayer, "diitem")

	self.panelTop:retain()
	self.panelTop:removeFromParent()
	self.panelDown:retain()
	self.panelDown:removeFromParent()

	self.topend = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_top_end")

	self.topend:retain()
	self.topend:removeFromParent()

	arg_3_1 = arg_3_1 or {
		activity_type = "proceed_id1",
		id = "13-1",
		activityID = var_0_18
	}
	self.activityinfo = self:getActivityAllInfo(arg_3_1.activityID, arg_3_1.activity_type)
	self.activity = activity_manager:getActivityObj(arg_3_1.activityID)

	self:showActivity()
	self:initBottomList()
	self:initChangeUI()
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.panelTop then
				self.panelTop:release()
			end

			if self.panelDown then
				self.panelDown:release()
			end

			if self.topend then
				self.topend:release()
			end
		end
	end)
end

function ActivityPreheatPoint:initChangeUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "midelimg"):loadTexture("Activity_PointActivityLayer/item_activity_12.png", var_0_8)
	ccui.Helper:seekWidgetByName(self.rootLayer, "diitem"):loadTexture("Activity_PointActivityLayer/item_activity_lingdang.png", var_0_8)
	self.toptile:loadTexture("Activity_PointActivityLayer/top_activity_12.png", var_0_8)
end

function ActivityPreheatPoint:showActivity()
	self:showIntro()
	self:showSelfPoint()
	self:showBasicAwards()
end

local function var_0_19(arg_7_0)
	error(arg_7_0 .. "is Null")
end

function ActivityPreheatPoint.getActivityAllInfo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		awards = {},
		limitpoint = {},
		intro = {},
		targetLayer,
		selfpoint = 0
	}
	local var_8_1 = 1

	while activity_proceed_data[arg_8_1 .. "-" .. var_8_1] and activity_proceed_data[arg_8_1 .. "-" .. var_8_1].drop do
		if drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_1].drop].drop_id1 then
			local var_8_2 = {
				itemid = drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_1].drop].drop_id1
			}

			var_8_2.number = drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_1].drop].drop_num1 or 0

			table.insert(var_8_0.awards, var_8_2)
		elseif drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_1].drop].diamond then
			table.insert(var_8_0.awards, {
				diamond = drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_1].drop].diamond
			})
		elseif drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_1].drop].gold then
			table.insert(var_8_0.awards, {
				gold = drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_1].drop].gold
			})
		end

		table.insert(var_8_0.limitpoint, activity_proceed_data[arg_8_1 .. "-" .. var_8_1].num1)

		var_8_1 = var_8_1 + 1
	end

	local var_8_3 = {
		img = "mainScenebg/activity/branch13/activity_point.jpg"
	}

	var_8_3.intro = activity_conf_data[tonumber(arg_8_1)]["proceed_des" .. string.match(arg_8_2, "proceed_id(%d+)")] or "暂无简介"
	var_8_0.intro = var_8_3
	var_8_0.selfpoint = item_manager:getItemNumber(9000003)
	var_8_0.starttime = activity_conf_data[arg_8_1].starttime
	var_8_0.finishtime = activity_conf_data[arg_8_1].finishtime

	if var_8_0 and next(var_8_0) ~= nil then
		return var_8_0
	else
		var_0_19("activityinfo")
	end
end

function ActivityPreheatPoint:getActivityIntro()
	if self.activityinfo.intro and self.activityinfo.intro ~= "" then
		return self.activityinfo.intro
	else
		var_0_19("intro")
	end
end

function ActivityPreheatPoint:getActivityTime()
	if self.activityinfo.starttime and self.activityinfo.finishtime then
		local var_10_0, var_10_1, var_10_2, var_10_3 = string.match(self.activityinfo.starttime, "(%d+)-(%d+) (%d+):(%d+)")
		local var_10_4, var_10_5, var_10_6, var_10_7 = string.match(self.activityinfo.finishtime, "(%d+)-(%d+) (%d+):(%d+)")

		return var_10_0 .. "/" .. var_10_1 .. " " .. var_10_2 .. ":" .. var_10_3, var_10_4 .. "/" .. var_10_5 .. " " .. var_10_6 .. ":" .. var_10_7
	else
		var_0_19("time")
	end
end

function ActivityPreheatPoint:getActivityawards()
	if self.activityinfo.awards and next(self.activityinfo.awards) ~= nil then
		return self.activityinfo.awards
	else
		var_0_19("awards")
	end
end

function ActivityPreheatPoint:getLimitPoint(arg_12_1)
	if self.activityinfo.limitpoint[arg_12_1] and self.activityinfo.limitpoint[arg_12_1] > 0 then
		return self.activityinfo.limitpoint[arg_12_1]
	else
		var_0_19(arg_12_1 .. "th " .. "limitpoint")
	end
end

function ActivityPreheatPoint:getAlreadyGainTag(arg_13_1)
	if self.activityinfo.alreadygaintag[arg_13_1] then
		return self.activityinfo.alreadygaintag[arg_13_1]
	else
		var_0_19(arg_13_1 .. "th " .. "alreadygaintag")
	end
end

function ActivityPreheatPoint:showIntro()
	local var_14_0 = self:getActivityIntro()

	self.rootLayer:setBackGroundImage(var_14_0.img)

	local var_14_1 = cc.Label:createWithTTF("", FONT_DES, 24)

	var_14_1:setMaxLineWidth(250)
	var_14_1:setAnchorPoint(cc.p(0, 1))
	var_14_1:setPosition(cc.p(50, 940))
	var_14_1:setString(var_14_0.intro)
	var_14_1:setName("activity_label")
	var_14_1:setColor(cc.c4b(167, 60, 60, 1))
	self.rootLayer:addChild(var_14_1, 100)
end

function ActivityPreheatPoint:getSelfPoint()
	if self.activityinfo.selfpoint and self.activityinfo.selfpoint >= 0 then
		return self.activityinfo.selfpoint
	else
		var_0_19("selfpoint")
	end
end

function ActivityPreheatPoint:showSelfPoint()
	local var_16_0 = cc.Label:createWithTTF("", FONT_DES, 26)

	var_16_0:setColor(cc.c3b(255, 204, 0))
	var_16_0:setString((self:getSelfPoint()))
	var_16_0:setAnchorPoint(0, 0.5)
	var_16_0:setPosition(cc.p(550, 506))
	self.rootLayer:addChild(var_16_0, 5)
end

local var_0_20 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_21 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 84, 0, 150)
}

function ActivityPreheatPoint.create_medal_icon(arg_17_0, arg_17_1)
	local var_17_0 = item_data[arg_17_1]
	local var_17_1 = cc.Sprite:create((item_data[arg_17_1].bg or nil) and ("equipment/" .. item_data[arg_17_1].bg .. ".png" or var_0_20[var_17_0.equip_quality]))
	local var_17_2 = cc.Label:createWithTTF(var_17_0.name, FONT_DES, 54)

	var_17_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_17_2:setPosition(cc.p(var_17_1:getContentSize().width / 2 + 5, var_17_1:getContentSize().height / 2 - 5))
	var_17_2:enableOutline(var_0_21[var_17_0.equip_quality], 1)
	var_17_2:enableShadow(var_0_21[var_17_0.equip_quality], cc.size(0, 0))
	var_17_2:setVisible(var_17_0.only_bg ~= 1)
	var_17_1:addChild(var_17_2)

	return var_17_1
end

function ActivityPreheatPoint:showBasicAwards()
	local var_18_0 = 1
	local var_18_1 = 2

	local function var_18_2(arg_19_0, arg_19_1)
		local var_19_0 = ccui.Layout:create()

		var_19_0:setContentSize(arg_19_0:getContentSize())
		var_19_0:setTouchEnabled(false)
		var_19_0:setClippingEnabled(true)
		var_19_0:setName("cut_panel")
		arg_19_0:addChild(var_19_0)
		arg_19_0:setTouchEnabled(true)

		local var_19_1 = arg_19_1.itemid and ccui.ImageView:create("public/box/" .. item_data[arg_19_1.itemid].equip_quality .. ".png", var_0_8) or ccui.ImageView:create("public/box/" .. "1" .. ".png", var_0_8)
		local var_19_2 = var_19_0:getContentSize().width / var_19_1:getContentSize().width

		var_19_1:setPosition(cc.p(var_19_0:getContentSize().width / 2, var_19_0:getContentSize().height / 2))
		var_19_1:setScale((math.max(var_19_2, var_19_0:getContentSize().height / var_19_1:getContentSize().height)))
		var_19_0:addChild(var_19_1, 0)
		var_19_1:setTouchEnabled(false)

		local var_19_3

		if arg_19_1.itemid then
			if item_data[arg_19_1.itemid].bag_item_type == kITEM_HORCRUX then
				var_19_3 = CUTE_ROLE_IMAGE_PATH .. horcruxManager:getHorcruxRoleImage(arg_19_1.itemid) .. ".png"
			elseif item_data[arg_19_1.itemid].bag_item_type == kITEM_MEDAL then
				var_19_3 = nil
			else
				var_19_3 = "equipment/" .. item_data[arg_19_1.itemid].image_id .. ".png"
			end
		elseif arg_19_1.diamond then
			var_19_3 = "equipment/1000000.png"
		elseif arg_19_1.gold then
			var_19_3 = "equipment/1000001.png"
		end

		if var_19_3 then
			local var_19_6 = ccui.ImageView:create(var_19_3)

			var_19_6:setScale(100 / var_19_6:getContentSize().width)

			if self.posTag == var_18_0 then
				var_19_6:setPosition(arg_19_0:getContentSize().width / 2, arg_19_0:getContentSize().height / 2 + 20)
			else
				var_19_6:setPosition(arg_19_0:getContentSize().width / 2, arg_19_0:getContentSize().height / 2 - 20)
			end

			var_19_6:setName("itemSp")
			var_19_0:addChild(var_19_6)
		elseif not var_19_3 and item_data[arg_19_1.itemid].bag_item_type == kITEM_MEDAL then
			local var_19_7 = self:create_medal_icon(arg_19_1.itemid)

			var_19_7:setAnchorPoint(cc.p(0.5, 0.5))

			if self.posTag == var_18_0 then
				var_19_7:setPosition(arg_19_0:getContentSize().width / 2, arg_19_0:getContentSize().height / 2 + 20)
			else
				var_19_7:setPosition(arg_19_0:getContentSize().width / 2, arg_19_0:getContentSize().height / 2 - 20)
			end

			var_19_0:addChild(var_19_7)
		end

		local var_19_8 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_19_8:setAnchorPoint(cc.p(1, 0))

		if self.posTag == var_18_0 then
			var_19_8:setPosition(cc.p(130, 30))
		else
			var_19_8:setPosition(cc.p(130, 112))
		end

		local var_19_9

		if arg_19_1.itemid then
			var_19_9 = arg_19_1.number or 1
		elseif arg_19_1.diamond then
			var_19_9 = arg_19_1.diamond
		elseif arg_19_1.gold then
			var_19_9 = arg_19_1.gold
		end

		var_19_8:setString(var_19_9)
		var_19_8:setName("award_number")
		var_19_0:addChild(var_19_8, 9)
	end

	local function var_18_3(arg_20_0)
		local var_20_0 = {}
		local var_20_1 = self:getSelfPoint()

		if arg_20_0 and next(arg_20_0) ~= nil then
			for iter_20_0 = 1, #arg_20_0 do
				local var_20_2 = self:getLimitPoint(iter_20_0)

				if var_20_1 < var_20_2 then
					self.button[iter_20_0].status = var_0_17
				else
					if arg_20_0[iter_20_0].status == 0 and var_20_2 <= var_20_1 then
						table.insert(var_20_0, iter_20_0)
						self.button[iter_20_0]:setTouchEnabled(true)
						self.button[iter_20_0]:getChildByName("button_label"):setString("领取")

						self.button[iter_20_0].status = var_0_15
					elseif arg_20_0[iter_20_0].status == 1 then
						self.button[iter_20_0]:setTouchEnabled(false)
						self.button[iter_20_0]:getChildByName("button_label"):setString("已领取")

						self.button[iter_20_0].status = var_0_16

						self.button[iter_20_0].completeTag:setVisible(true)

						local var_20_3

						if config._DEBUG then
							var_20_3 = cc.Sprite:create("public/panelbg/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/fragment_tic_new.png")
						end

						var_20_3:setAnchorPoint(cc.p(0.5, 0.5))
						var_20_3:setPosition(cc.p(96, 21))
						var_20_3:setScale(0.8)
						self.button[iter_20_0].completeTag:addChild(var_20_3, 10)
					end

					self.button[iter_20_0]:addTouchEventListener(function(arg_21_0, arg_21_1)
						if arg_21_1 ~= ccui.TouchEventType.ended then
							return
						end

						self:updateGainAward(arg_21_0, iter_20_0)
					end)
				end

				self.button[iter_20_0].bg:addTouchEventListener(function(arg_22_0, arg_22_1)
					if arg_22_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_22_0:getTouchEndPosition().x - arg_22_0:getTouchBeganPosition().x) > 50 then
						return
					end

					if self.button[iter_20_0].status == var_0_16 or self.button[iter_20_0].status == var_0_17 then
						self:showAwardsDetails(arg_22_0.itemid, arg_22_0.item_type)
					elseif self.button[iter_20_0].status == var_0_15 then
						self:updateGainAward(self.button[iter_20_0], iter_20_0)
					end
				end)
			end
		end
	end

	self.button = {}

	local var_18_4 = self:getActivityawards()
	local var_18_5 = 100
	local var_18_7 = 145

	for iter_18_0 = 1, #var_18_4 do
		local var_18_8
		local var_18_9 = self:getSelfPoint()
		local var_18_10 = self:getLimitPoint(iter_18_0)
		local var_18_11 = iter_18_0 - 1 ~= 0 and self:getLimitPoint(iter_18_0 - 1) or 0
		local var_18_12

		if iter_18_0 % 2 == 1 then
			var_18_8 = self.panelTop:clone()
			self.posTag = 1
			var_18_12 = 314
		else
			var_18_8 = self.panelDown:clone()
			self.posTag = var_18_1
			var_18_12 = 100
		end

		if iter_18_0 == #var_18_4 then
			var_18_8 = self.topend:clone()
			self.posTag = 1
			var_18_12 = 314
		end

		var_18_8:setAnchorPoint(cc.p(0, 0.5))

		local var_18_13 = ccui.Helper:seekWidgetByName(var_18_8, "button_complete")
		local var_18_14 = var_18_13:getChildByName("button_label")
		local var_18_15 = ccui.Helper:seekWidgetByName(var_18_8, "progress_bar")
		local var_18_16 = ccui.Helper:seekWidgetByName(var_18_8, "arrow")
		local var_18_17 = ccui.Helper:seekWidgetByName(var_18_8, "img_bg")
		local var_18_18 = ccui.Helper:seekWidgetByName(var_18_8, "complete_tag")

		var_18_18:setVisible(false)

		self.button[iter_18_0] = var_18_13
		self.button[iter_18_0].completeTag = var_18_18
		self.button[iter_18_0].bg = var_18_17

		var_18_2(var_18_17, var_18_4[iter_18_0])
		var_18_14:setString("未领取")
		var_18_15:setPercent(0)

		if var_18_10 <= var_18_9 then
			var_18_14:setString("loading...")
			var_18_16:loadTexture(var_0_11, var_0_8)

			if iter_18_0 ~= #var_18_4 then
				var_18_17:loadTexture(var_0_13, var_0_8)
				var_18_13:loadTextures(var_0_9, var_0_9, var_0_9, var_0_8)
			else
				var_18_17:loadTexture("Activity_PointActivityLayer/new_endaward.png", var_0_8)
				var_18_13:loadTextures("Activity_PointActivityLayer/new_kelingqu.png", "Activity_PointActivityLayer/new_kelingqu.png", "Activity_PointActivityLayer/new_kelingqu.png", var_0_8)
			end

			var_18_13:setTouchEnabled(false)
			var_18_15:setPercent(100)
		else
			var_18_14:setString(var_18_10 .. "只解锁")
			var_18_16:loadTexture(var_0_12, var_0_8)

			if iter_18_0 ~= #var_18_4 then
				var_18_17:loadTexture(var_0_14, var_0_8)
				var_18_13:loadTextures(var_0_10, nil, var_0_10, var_0_8)
			else
				var_18_17:loadTexture("Activity_PointActivityLayer/new_endaward.png", var_0_8)
				var_18_13:loadTextures("Activity_PointActivityLayer/new_weilingqu.png", nil, "Activity_PointActivityLayer/new_weilingqu.png", var_0_8)
			end

			var_18_13:setTouchEnabled(false)
			var_18_15:setPercent((var_18_9 - var_18_11) * 100 / (var_18_10 - var_18_11))
		end

		if iter_18_0 < #var_18_4 then
			var_18_8:setPosition(cc.p(var_18_5 + var_18_7 * (iter_18_0 - 1), var_18_12))
			self.scrollView:addChild(var_18_8)
		else
			var_18_8:setPosition(cc.p(125, 612))
			var_18_8:setName("lastone")
			ccui.Helper:seekWidgetByName(var_18_8, "progress_bg"):setVisible(false)
			ccui.Helper:seekWidgetByName(var_18_8, "arrow"):setVisible(false)
			ccui.Helper:seekWidgetByName(var_18_8, "cut_panel"):getChildByName("award_number"):setPosition(cc.p(150, 20))
			ccui.Helper:seekWidgetByName(var_18_8, "cut_panel"):getChildByName("itemSp"):setPositionY(ccui.Helper:seekWidgetByName(var_18_8, "cut_panel"):getChildByName("itemSp"):getPositionY() - 10)
			var_18_13:setPositionY(var_18_13:getPositionY() - 20)
			self.rootLayer:addChild(var_18_8, 100)
		end

		var_18_17.itemid = var_18_4[iter_18_0].itemid

		if var_18_4[iter_18_0].itemid then
			var_18_17.item_type = "item"
		end

		var_18_17:setTouchEnabled(true)
	end

	self.scrollView:setInnerContainerSize(cc.size(var_18_5 + (#var_18_4 - 2) * var_18_7 + 67, 400))
	self.scrollView:setPosition(cc.p(self.scrollView:getPositionX() + 2, self.scrollView:getPositionY() - 30))
	self.activity:getActivityProceed(function(arg_23_0, arg_23_1)
		if arg_23_0 == 0 then
			global_ShowBlockWords("活动无积分兑换")
		elseif arg_23_0 == 1 then
			var_18_3(arg_23_1)
		elseif arg_23_0 == 2 then
			global_ShowBlockWords("活动已结束")
		end
	end)
end

function ActivityPreheatPoint:updateGainAward(arg_24_1, arg_24_2)
	self.activity:getActivityProceedAward(arg_24_2, function(arg_25_0, arg_25_1)
		if arg_25_0 == 0 then
			global_ShowBlockWords("活动无积分兑换")
		elseif arg_25_0 == 1 then
			arg_24_1.status = var_0_16

			arg_24_1:getChildByName("button_label"):setString("已领取")
			arg_24_1.completeTag:setVisible(true)

			local var_25_0

			if config._DEBUG then
				var_25_0 = cc.Sprite:create("public/panelbg/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/fragment_tic_new.png")
			end

			var_25_0:setScale(4)
			var_25_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_25_0:setPosition(cc.p(96, 21))
			arg_24_1.completeTag:addChild(var_25_0, 10)
			var_25_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.4, 0.8), cc.CallFunc:create(function()
				global_gain(arg_25_1)
			end)))
		elseif arg_25_0 == 2 then
			global_ShowBlockWords("活动已结束")
		elseif arg_25_0 == 3 then
			global_ShowBlockWords("当前奖励已全部领取")
		elseif arg_25_0 == 4 then
			-- block empty
		end
	end)
end

function ActivityPreheatPoint:showAwardsDetails(arg_27_1, arg_27_2)
	local function var_27_0()
		self.rootLayer:setVisible(true)
	end

	if arg_27_2 == "item" then
		if item_data[arg_27_1].bag_item_type == kITEM_HORCRUX then
			local var_27_1 = -1
			local var_27_2 = require("data.horcrux_data")[arg_27_1].horcruxtype

			for iter_27_0, iter_27_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_27_1 == iter_27_1.item_id then
					var_27_1 = iter_27_0

					break
				end
			end

			if var_27_1 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_27_1,
				itemid = arg_27_1,
				callback = var_27_0
			})
			self.rootLayer:setVisible(false)
		elseif item_data[arg_27_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_27_1].major,
				exitCallback = var_27_0
			})
			self.rootLayer:setVisible(false)
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_27_3 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_27_1
			})
		end
	elseif arg_27_2 == "gold" then
		-- block empty
	elseif arg_27_2 == "diamond" then
		-- block empty
	end
end

function ActivityPreheatPoint:initBottomList()
	self.buttonList = BottomBtnList:create(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc(global_basic_scene)
	end, {
		{
			texture = "public/button/public_button_big_blue_y.png",
			name = "goTarget",
			word = "前往任务",
			handler = function(arg_31_0, arg_31_1)
				if arg_31_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:switchShowLayer("ActivityPreheatTask", {})
			end
		}
	})

	self:addChild(self.buttonList, 999)
end

function ActivityPreheatPoint:fullScreen(arg_32_1)
	arg_32_1:setContentSize((GameDisplay.getScreenSize()))
	arg_32_1:setPositionY(arg_32_1:getPositionY() - GameDisplay.fix_y)
	self.buttonList:setPositionY(self.buttonList:getPositionY() - GameDisplay.fix_y)
	self.toptile:setPosition(cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height - 25))
	self.scrollView:setPositionY(self.scrollView:getPositionY() + 32)
	self.medium:setScale9Enabled(true)
	self.medium:setCapInsets(cc.rect(0, 300, 348, 10))
	self.medium:setContentSize(cc.size(348, 391 + GameDisplay.fix_y))
	self.medium:setPositionY(self.toptile:getPositionY() - 4 - self.medium:getContentSize().height / 2 - self.toptile:getContentSize().height / 2)
	arg_32_1:getChildByName("activity_label"):setPositionY(self.toptile:getPositionY() - 4 - 150 - self.toptile:getContentSize().height / 2)
	arg_32_1:getChildByName("lastone"):setPositionY(self.dibu:getPositionY() + self.dibu:getContentSize().height / 2 + 85)
end
