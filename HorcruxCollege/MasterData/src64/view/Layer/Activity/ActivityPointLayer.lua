ActivityPointLayer = class("ActivityPointLayer", function()
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
local network = require("network.network")

require("view.Sprite.ItemSprite")

local var_0_9
local var_0_10 = config._DEBUG and 0 or 1
local var_0_11 = "Activity_PointActivityLayer/complete_button.png"
local var_0_12 = "Activity_PointActivityLayer/uncomplete_button.png"
local var_0_13 = "Activity_PointActivityLayer/completed_arrow.png"
local var_0_14 = "Activity_PointActivityLayer/uncompleted_arrow.png"
local var_0_15 = "Activity_PointActivityLayer/completed_box.png"
local var_0_16 = "Activity_PointActivityLayer/uncompleted_box.png"
local var_0_17 = 1
local var_0_18 = 0
local var_0_19 = 2

function ActivityPointLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityPointLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityPointLayer:init(arg_3_1)
	print(dump(arg_3_1))

	var_0_9 = self
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

	self.activityinfo = self:getActivityAllInfo(arg_3_1.activityID, arg_3_1.activity_type)
	self.activity = activity_manager:getActivityObj(arg_3_1.activityID)

	self:showActivity()
	self:exit(arg_3_1.activityID, arg_3_1.activity_type)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			local var_4_0 = false

			for iter_4_0 = 1, #self.button do
				if self.button[iter_4_0].status and self.button[iter_4_0].status == var_0_17 then
					var_4_0 = true

					break
				end
			end

			if var_4_0 == false then
				activity_manager:updateActivityAlert("proceed", arg_3_1.activityID, false)
			else
				activity_manager:updateActivityAlert("proceed", arg_3_1.activityID)
			end

			local var_4_1 = {}

			for iter_4_1, iter_4_2 in pairs(activity_proceed_data) do
				table.insert(var_4_1, iter_4_2.num1)
			end

			table.sort(var_4_1, function(arg_5_0, arg_5_1)
				return arg_5_0 < arg_5_1
			end)

			local var_4_2 = 0

			for iter_4_3 = 1, #self.button do
				if self.button[iter_4_3].status and (self.button[iter_4_3].status == var_0_17 or self.button[iter_4_3].status == var_0_18) then
					var_4_2 = iter_4_3
				end
			end

			RoleDefault:getInstance():setIntegerForKey("ActivityPointLayer_NextPoint", var_4_2 + 1 > #var_4_1 and 999999 or var_4_1[var_4_2 + 1])

			if self.panelTop then
				self.panelTop:release()
			end

			if self.panelDown then
				self.panelDown:release()
			end

			if self.topend then
				self.topend:release()
			end

			var_0_9 = nil
		end
	end)
	self:fullScreen(self.rootLayer)
end

function ActivityPointLayer:showActivity()
	self:showIntro()
	self:showTime()
	self:showSelfPoint()
	self:showBasicAwards()
end

local function var_0_20(arg_7_0)
	error(arg_7_0 .. "is Null")
end

function ActivityPointLayer.getActivityAllInfo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_1 = {
		awards = {},
		limitpoint = {},
		intro = {},
		targetLayer,
		selfpoint = 0
	}
	local var_8_2 = 1

	::label_8_0::

	local var_8_4

	if activity_proceed_data[arg_8_1 .. "-" .. var_8_2] and activity_proceed_data[arg_8_1 .. "-" .. var_8_2].drop then
		repeat
			if drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_2].drop].drop_id1 then
				local var_8_3 = {
					itemid = drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_2].drop].drop_id1
				}

				var_8_3.number = drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_2].drop].drop_num1 or 0

				table.insert(var_8_1.awards, var_8_3)
			elseif drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_2].drop].diamond then
				table.insert(var_8_1.awards, {
					diamond = drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_2].drop].diamond
				})
			elseif drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_2].drop].gold then
				table.insert(var_8_1.awards, {
					gold = drop_data[activity_proceed_data[arg_8_1 .. "-" .. var_8_2].drop].gold
				})
			end

			table.insert(var_8_1.limitpoint, activity_proceed_data[arg_8_1 .. "-" .. var_8_2].num1)

			var_8_2 = var_8_2 + 1

			goto label_8_0
		until true

		var_8_4 = {}
	end

	var_8_4.img = "mainScenebg/activity/" .. activity_img_data[arg_8_1].path .. "/activity_point.png"
	var_8_4.intro = activity_conf_data[tonumber(arg_8_1)]["proceed_des" .. string.match(arg_8_2, "proceed_id(%d+)")] or L_NO_BRIEF_INTRO
	var_8_1.intro = var_8_4

	local var_8_5 = activity_conf_data[arg_8_1]["item" .. string.match(arg_8_2, "proceed_id(%d+)")]

	if playermodel.items[var_8_5] then
		var_8_1.selfpoint = playermodel.items[var_8_5].number or 0
	end

	var_8_1.starttime = activity_conf_data[arg_8_1].starttime
	var_8_1.finishtime = activity_conf_data[arg_8_1].finishtime

	if var_8_1 and next(var_8_1) ~= nil then
		return var_8_1
	else
		var_0_20("activityinfo")
	end
end

function ActivityPointLayer:getActivityIntro()
	if self.activityinfo.intro and self.activityinfo.intro ~= "" then
		return self.activityinfo.intro
	else
		var_0_20("intro")
	end
end

function ActivityPointLayer:getActivityTime()
	if self.activityinfo.starttime and self.activityinfo.finishtime then
		local var_10_0, var_10_1, var_10_2, var_10_3 = string.match(self.activityinfo.starttime, "(%d+)-(%d+) (%d+):(%d+)")
		local var_10_4, var_10_5, var_10_6, var_10_7 = string.match(self.activityinfo.finishtime, "(%d+)-(%d+) (%d+):(%d+)")

		return var_10_0 .. "/" .. var_10_1 .. " " .. var_10_2 .. ":" .. var_10_3, var_10_4 .. "/" .. var_10_5 .. " " .. var_10_6 .. ":" .. var_10_7
	else
		var_0_20("time")
	end
end

function ActivityPointLayer:getActivityawards()
	if self.activityinfo.awards and next(self.activityinfo.awards) ~= nil then
		return self.activityinfo.awards
	else
		var_0_20("awards")
	end
end

function ActivityPointLayer:getSelfPoint()
	if self.activityinfo.selfpoint and self.activityinfo.selfpoint >= 0 then
		return self.activityinfo.selfpoint
	else
		var_0_20("selfpoint")
	end
end

function ActivityPointLayer:getLimitPoint(arg_13_1)
	if self.activityinfo.limitpoint[arg_13_1] and self.activityinfo.limitpoint[arg_13_1] > 0 then
		return self.activityinfo.limitpoint[arg_13_1]
	else
		var_0_20(arg_13_1 .. "th " .. "limitpoint")
	end
end

function ActivityPointLayer:getAlreadyGainTag(arg_14_1)
	if self.activityinfo.alreadygaintag[arg_14_1] then
		return self.activityinfo.alreadygaintag[arg_14_1]
	else
		var_0_20(arg_14_1 .. "th " .. "alreadygaintag")
	end
end

function ActivityPointLayer:showIntro()
	local var_15_0 = self:getActivityIntro()

	self.rootLayer:setBackGroundImage(var_15_0.img)

	local var_15_1 = cc.Label:createWithTTF("", FONT_DES, 24)

	var_15_1:setMaxLineWidth(250)
	var_15_1:setAnchorPoint(cc.p(0, 1))
	var_15_1:setPosition(cc.p(50, 940))
	var_15_1:setString(var_15_0.intro)
	var_15_1:setName("activity_label")
	self.rootLayer:addChild(var_15_1, 100)
end

function ActivityPointLayer.showTime(arg_16_0)
	return
end

function ActivityPointLayer:showSelfPoint()
	local var_17_0 = cc.Label:createWithTTF("", FONT_DES, 26)

	var_17_0:setColor(cc.c3b(255, 204, 0))
	var_17_0:setString((self:getSelfPoint()))
	var_17_0:setAnchorPoint(0, 0.5)
	var_17_0:setPosition(cc.p(570, 506))
	self.rootLayer:addChild(var_17_0, 5)
end

function ActivityPointLayer:showBasicAwards()
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

		local var_19_1 = arg_19_1.itemid and ccui.ImageView:create("public/box/" .. item_data[arg_19_1.itemid].equip_quality .. ".png", var_0_10) or ccui.ImageView:create("public/box/" .. "1" .. ".png", var_0_10)
		local var_19_2 = var_19_0:getContentSize().width / var_19_1:getContentSize().width

		var_19_1:setPosition(cc.p(var_19_0:getContentSize().width / 2, var_19_0:getContentSize().height / 2))
		var_19_1:setScale((math.max(var_19_2, var_19_0:getContentSize().height / var_19_1:getContentSize().height)))
		var_19_0:addChild(var_19_1, 0)
		var_19_1:setTouchEnabled(false)

		local var_19_3

		if arg_19_1.itemid then
			var_19_3 = item_data[arg_19_1.itemid].bag_item_type == kITEM_HORCRUX and CUTE_ROLE_IMAGE_PATH .. horcruxManager:getHorcruxRoleImage(arg_19_1.itemid) .. ".png" or "equipment/" .. item_data[arg_19_1.itemid].image_id .. ".png"
		elseif arg_19_1.diamond then
			var_19_3 = "equipment/1000000.png"
		elseif arg_19_1.gold then
			var_19_3 = "equipment/1000001.png"
		end

		local var_19_5 = ccui.ImageView:create(var_19_3)

		var_19_5:setScale(100 / var_19_5:getContentSize().width)

		if self.posTag == var_18_0 then
			var_19_5:setPosition(arg_19_0:getContentSize().width / 2, arg_19_0:getContentSize().height / 2 + 20)
		else
			var_19_5:setPosition(arg_19_0:getContentSize().width / 2, arg_19_0:getContentSize().height / 2 - 20)
		end

		var_19_5:setName("itemSp")
		var_19_0:addChild(var_19_5)

		local var_19_6 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_19_6:setAnchorPoint(cc.p(1, 0))

		if self.posTag == var_18_0 then
			var_19_6:setPosition(cc.p(130, 30))
		else
			var_19_6:setPosition(cc.p(130, 112))
		end

		local var_19_7

		if arg_19_1.itemid then
			var_19_7 = arg_19_1.number or 1
		elseif arg_19_1.diamond then
			var_19_7 = arg_19_1.diamond
		elseif arg_19_1.gold then
			var_19_7 = arg_19_1.gold
		end

		var_19_6:setString(var_19_7)
		var_19_6:setName("award_number")
		var_19_0:addChild(var_19_6, 9)
	end

	local function var_18_3(arg_20_0)
		local var_20_0 = {}
		local var_20_1 = self:getSelfPoint()

		if arg_20_0 and next(arg_20_0) ~= nil then
			for iter_20_0 = 1, #arg_20_0 do
				local var_20_2 = self:getLimitPoint(iter_20_0)

				if var_20_1 < var_20_2 then
					self.button[iter_20_0].status = var_0_19
				else
					if arg_20_0[iter_20_0].status == 0 and var_20_2 <= var_20_1 then
						table.insert(var_20_0, iter_20_0)
						self.button[iter_20_0]:setTouchEnabled(true)
						self.button[iter_20_0]:getChildByName("button_label"):setString(L_BUTTON_TEXT.UnGet)

						self.button[iter_20_0].status = var_0_17
					elseif arg_20_0[iter_20_0].status == 1 then
						self.button[iter_20_0]:setTouchEnabled(false)
						self.button[iter_20_0]:getChildByName("button_label"):setString(L_BUTTON_TEXT.Got)

						self.button[iter_20_0].status = var_0_18

						self.button[iter_20_0].completeTag:setVisible(true)

						if iter_20_0 == 10 then
							self.button[iter_20_0].completeTag:setOpacity(0)
							self.button[iter_20_0].completeTag:setCascadeOpacityEnabled(false)
						end

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

					if self.button[iter_20_0].status == var_0_18 or self.button[iter_20_0].status == var_0_19 then
						self:showAwardsDetails(arg_22_0.itemid, arg_22_0.item_type)
					elseif self.button[iter_20_0].status == var_0_17 then
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
		var_18_14:setString(L_ACTIVITY_POINT_UNAWARD)
		var_18_15:setPercent(0)

		if var_18_10 <= var_18_9 then
			var_18_14:setString("loading...")
			var_18_16:loadTexture(var_0_13, var_0_10)

			if iter_18_0 ~= #var_18_4 then
				var_18_17:loadTexture(var_0_15, var_0_10)
				var_18_13:loadTextures(var_0_11, var_0_11, var_0_11, var_0_10)
			else
				var_18_17:loadTexture("Activity_PointActivityLayer/new_endaward.png", var_0_10)
				var_18_13:loadTextures("Activity_PointActivityLayer/new_kelingqu.png", "Activity_PointActivityLayer/new_kelingqu.png", "Activity_PointActivityLayer/new_kelingqu.png", var_0_10)
			end

			var_18_13:setTouchEnabled(false)
			var_18_15:setPercent(100)
		else
			var_18_14:setString(var_18_10 .. L_ACTIVITY_POINT_UNLOCK)
			var_18_16:loadTexture(var_0_14, var_0_10)

			if iter_18_0 ~= #var_18_4 then
				var_18_17:loadTexture(var_0_16, var_0_10)
				var_18_13:loadTextures(var_0_12, nil, var_0_12, var_0_10)
			else
				var_18_17:loadTexture("Activity_PointActivityLayer/new_endaward.png", var_0_10)
				var_18_13:loadTextures("Activity_PointActivityLayer/new_weilingqu.png", nil, "Activity_PointActivityLayer/new_weilingqu.png", var_0_10)
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
			global_ShowBlockWords(L_ACTIVITY_POINT_EXCHANGE_NIL)
		elseif arg_23_0 == 1 then
			var_18_3(arg_23_1)
		elseif arg_23_0 == 2 then
			global_ShowBlockWords(L_ACTIVITY_END)
		end
	end)
end

function ActivityPointLayer.updataAwardsByStatus(arg_24_0, arg_24_1)
	return
end

function ActivityPointLayer:updateGainAward(arg_25_1, arg_25_2)
	self.activity:getActivityProceedAward(arg_25_2, function(arg_26_0, arg_26_1)
		if arg_26_0 == 0 then
			global_ShowBlockWords(L_ACTIVITY_POINT_EXCHANGE_NIL)
		elseif arg_26_0 == 1 then
			arg_25_1.status = var_0_18

			arg_25_1:getChildByName("button_label"):setString(L_BUTTON_TEXT.Got)
			arg_25_1.completeTag:setVisible(true)

			if arg_25_2 and arg_25_2 == 10 then
				arg_25_1.completeTag:setOpacity(0)
				arg_25_1.completeTag:setCascadeOpacityEnabled(false)
			end

			local var_26_0

			if config._DEBUG then
				var_26_0 = cc.Sprite:create("public/panelbg/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/fragment_tic_new.png")
			end

			var_26_0:setScale(4)
			var_26_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_0:setPosition(cc.p(96, 21))
			arg_25_1.completeTag:addChild(var_26_0, 10)
			var_26_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.4, 0.8), cc.CallFunc:create(function()
				global_gain(arg_26_1)
			end)))
		elseif arg_26_0 == 2 then
			global_ShowBlockWords(L_ACTIVITY_END)
		elseif arg_26_0 == 3 then
			global_ShowBlockWords(L_ACTIVITY_GET_ALL_AWARD)
		elseif arg_26_0 == 4 then
			-- block empty
		end
	end)
end

function ActivityPointLayer:showAwardsDetails(arg_28_1, arg_28_2)
	local function var_28_0()
		self.rootLayer:setVisible(true)
	end

	if arg_28_2 == "item" then
		if item_data[arg_28_1].bag_item_type == kITEM_HORCRUX then
			local var_28_1 = -1
			local var_28_2 = require("data.horcrux_data")[arg_28_1].horcruxtype

			for iter_28_0, iter_28_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_28_1 == iter_28_1.item_id then
					var_28_1 = iter_28_0

					break
				end
			end

			if var_28_1 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_28_1,
				itemid = arg_28_1,
				callback = var_28_0
			})
			self.rootLayer:setVisible(false)
		elseif item_data[arg_28_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_28_1].major,
				exitCallback = var_28_0
			})
			self.rootLayer:setVisible(false)
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_28_3 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_28_1
			})
		end
	elseif arg_28_2 == "gold" then
		-- block empty
	elseif arg_28_2 == "diamond" then
		-- block empty
	end
end

function ActivityPointLayer:exit(arg_30_1, arg_30_2)
	local function var_30_0()
		KeyCodeManager:onKeyReleasedCallFunc()

		if callback then
			callback()
		end
	end

	if not arg_30_1 or not arg_30_2 then
		Curtaskshowtype = nil

		LayerManager:switchReturnLayer("MainLayer")

		return
	end

	local var_30_1 = {}

	self.activityid = arg_30_1

	local var_30_2 = string.match(arg_30_2, "proceed_id(%d+)")

	self.next_id = activity_conf_data[arg_30_1]["task_id" .. var_30_2]
	self.next_type = "task_id" .. var_30_2
	var_30_1[1] = {
		texture = "public/button/public_button_big_blue_y.png",
		name = "goTarget",
		word = L_ACTIVITY_POINT_GOTO_TASK,
		handler = function(arg_32_0, arg_32_1)
			if arg_32_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:switchShowLayer("ActivityTaskLayer", {
				jumpbackID = 1201,
				activityID = self.activityid,
				activity_type = self.next_type,
				id = self.next_id
			})
		end
	}
	self.buttonList = BottomBtnList:create(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_30_0()
	end, var_30_1)

	self:addChild(self.buttonList, 999)
end

function ActivityPointLayer:fullScreen(arg_34_1)
	arg_34_1:setContentSize((GameDisplay.getScreenSize()))
	arg_34_1:setPositionY(arg_34_1:getPositionY() - GameDisplay.fix_y)
	self.buttonList:setPositionY(self.buttonList:getPositionY() - GameDisplay.fix_y)
	self.toptile:setPosition(cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height - 25))
	self.scrollView:setPositionY(self.scrollView:getPositionY() + 32)
	self.medium:setScale9Enabled(true)
	self.medium:setCapInsets(cc.rect(0, 300, 348, 10))
	self.medium:setContentSize(cc.size(348, 391 + GameDisplay.fix_y))
	self.medium:setPositionY(self.toptile:getPositionY() - 4 - self.medium:getContentSize().height / 2 - self.toptile:getContentSize().height / 2)
	arg_34_1:getChildByName("activity_label"):setPositionY(self.toptile:getPositionY() - 4 - 150 - self.toptile:getContentSize().height / 2)
	arg_34_1:getChildByName("lastone"):setPositionY(self.dibu:getPositionY() + self.dibu:getContentSize().height / 2 + 85)
end
