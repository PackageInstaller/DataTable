local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local explore_manager = require("controller.explore_manager")
local item_data = require("data.item_data")
local drop_data = require("data.drop_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local substitute_awards_data = require("data.substitute_awards_data")
local chapter_data = require("data.chapter_data")
local levelmode_data = require("data.levelmode_data")
local substitution_manager = require("controller.substitution_manager")
local old_substitution_manager = require("controller.old_substitution_manager")
local photo_manager = require("controller.photo_manager")
local school_cinema_manager = require("controller.school_cinema_manager")
local var_0_18 = require("controller.formation.formation_manager"):getInstance()
local var_0_19 = require("controller.weekly_tower_manager").getInstance()
local TempWidget = require("view.Sprite.TempWidget")
local var_0_21 = config._DEBUG and 0 or 1
local var_0_22 = require("view.Sprite.TempWidget")
local var_0_23 = "role/"

local function var_0_25(arg_1_0)
	local var_1_0, var_1_1 = arg_1_0:match("(%d+)-(%d+)")

	return tonumber(var_1_0), tonumber(var_1_1)
end

local function var_0_29(arg_5_0, arg_5_1)
	local var_5_1 = ccui.ListView:create()

	var_5_1:setBounceEnabled(true)
	var_5_1:setDirection(ccui.ListViewDirection.horizontal)
	var_5_1:setItemsMargin(10)
	var_5_1:setAnchorPoint(cc.p(0, 0))
	var_5_1:setPosition(0, 0)
	var_5_1:setContentSize(cc.size(580, 226 * 0.56))

	local var_5_2 = not not next(arg_5_0)

	if next(arg_5_1) then
		var_5_1:pushBackCustomItem((ccui.ImageView:create("ChapterSettlement/reward_last_time.png", var_0_21)))

		for iter_5_0 = 1, #arg_5_1 do
			local var_5_3 = ItemSprite:createBigWithEntityId(arg_5_1[iter_5_0].itemid, arg_5_1[iter_5_0].itemcount)

			var_5_3:setScale(0.56)
			var_5_3:setAnchorPoint(cc.p(0, 0))

			local var_5_4 = ccui.Layout:create()

			var_5_4:setTouchEnabled(true)
			var_5_4:setContentSize(cc.size(var_5_3:getContentSize().width * 0.56, var_5_3:getContentSize().height * 0.56))
			var_5_4:setAnchorPoint(cc.p(0, 0))
			var_5_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_5_4:setBackGroundColor(cc.c3b(0, 0, 0))
			var_5_4:setBackGroundColorOpacity(0)
			var_5_4:addChild(var_5_3)

			if var_5_2 then
				local var_5_5 = ccui.Layout:create()

				var_5_5:setTouchEnabled(false)
				var_5_5:setContentSize(cc.size(var_5_3:getContentSize().width * 0.56, var_5_3:getContentSize().height * 0.56))
				var_5_5:setAnchorPoint(cc.p(0, 0))
				var_5_5:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				var_5_5:setBackGroundColor(cc.c3b(15, 15, 15))
				var_5_5:setBackGroundColorOpacity(180)
				var_5_4:addChild(var_5_5, 10)
			end

			var_5_1:pushBackCustomItem(var_5_4)
		end
	end

	if var_5_2 then
		var_5_1:pushBackCustomItem((ccui.ImageView:create("ChapterSettlement/reward_this_time.png", var_0_21)))
	end

	for iter_5_1 = 1, #arg_5_0 do
		local var_5_6 = ItemSprite:createBigWithEntityId(arg_5_0[iter_5_1].entityid, arg_5_0[iter_5_1].itemcount)

		var_5_6:setScale(0.56)
		var_5_6:setAnchorPoint(cc.p(0, 0))

		local var_5_7 = ccui.Layout:create()

		var_5_7:setTouchEnabled(true)
		var_5_7:setContentSize(cc.size(var_5_6:getContentSize().width * 0.56, var_5_6:getContentSize().height * 0.56))
		var_5_7:setAnchorPoint(cc.p(0, 0))
		var_5_7:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_5_7:setBackGroundColor(cc.c3b(0, 0, 0))
		var_5_7:setBackGroundColorOpacity(0)
		var_5_7:addChild(var_5_6)
		var_5_1:pushBackCustomItem(var_5_7)
	end

	return var_5_1, count
end

local function var_0_30(arg_6_0)
	if type(arg_6_0) ~= "number" then
		return
	end

	if not playermodel.items[arg_6_0] then
		return
	end

	local var_6_0 = playermodel.items[arg_6_0].itemid

	if item_data[playermodel.items[arg_6_0].itemid].bag_item_type == kITEM_HORCRUX then
		local var_6_1 = -1

		for iter_6_0, iter_6_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if iter_6_1.model_id == item_data[var_6_0].model then
				var_6_1 = iter_6_0

				break
			end
		end

		if var_6_1 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_6_1,
			itemid = var_6_0,
			callback = function(...)
				return
			end
		})
	elseif item_data[playermodel.items[arg_6_0].itemid].bag_item_type == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			layertype = "DropDetailsLayer",
			cursoul = item_data[var_6_0].servant,
			exitCallback = function()
				return
			end
		})
	else
		LayerManager:pushInLayer("PopItemLayer", {
			hideGainButton = true,
			itemid = var_6_0
		})
	end
end

local function var_0_31(arg_9_0)
	local var_9_1 = ccui.ListView:create()

	var_9_1:setBounceEnabled(true)
	var_9_1:setDirection(ccui.ListViewDirection.horizontal)
	var_9_1:setItemsMargin(10)
	var_9_1:setAnchorPoint(cc.p(0, 0))
	var_9_1:setPosition(0, 0)
	var_9_1:setContentSize(cc.size(580, 226 * 0.56))

	for iter_9_0 = 1, #arg_9_0 do
		local var_9_2 = ItemSprite:createBigWithEntityId(arg_9_0[iter_9_0].entityid, arg_9_0[iter_9_0].number)

		var_9_2:setScale(0.56)
		var_9_2:setAnchorPoint(cc.p(0, 0))

		local var_9_3 = ccui.Layout:create()

		var_9_3:setTouchEnabled(true)
		var_9_3:setContentSize(cc.size(var_9_2:getContentSize().width * 0.56, var_9_2:getContentSize().height * 0.56))
		var_9_3:setAnchorPoint(cc.p(0, 0))
		var_9_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_9_3:setBackGroundColor(cc.c3b(0, 0, 0))
		var_9_3:setBackGroundColorOpacity(0)
		var_9_3:addChild(var_9_2)
		var_9_1:pushBackCustomItem(var_9_3)
		var_9_3:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_0_30(arg_9_0[iter_9_0].entityid)
		end)
	end

	return var_9_1, #arg_9_0
end

local function var_0_32(arg_11_0)
	local var_11_0 = cc.p(420, 150)
	local var_11_1 = model_data[arg_11_0].levelresult_offset_x or 0
	local var_11_2 = model_data[arg_11_0].levelresult_offset_y or 0

	var_11_0.x = var_11_0.x + var_11_1
	var_11_0.y = var_11_0.y + var_11_2

	if model_data[arg_11_0].is_big_role_image == 1 then
		var_11_0.x = 320
		var_11_0.y = -104
	else
		hx_print("modelid:" .. arg_11_0 .. " " .. model_data[arg_11_0].name .. " 使用偏移 levelresult_offset_x = " .. (var_11_1 or 0) .. " levelresult_offset_y = " .. (var_11_2 or 0), CONSOLE_COLOR_GREEN)
	end

	return var_11_0
end

local function var_0_33(arg_12_0)
	local var_12_0 = arg_12_0.curarray and next(arg_12_0.curarray) ~= nil and arg_12_0.curarray or playermodel.curSoul
	local var_12_1
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		if iter_12_1.fight_girl and iter_12_1.classtype == 1 then
			table.insert(var_12_2, iter_12_1)
		end
	end

	local var_12_3

	if #var_12_2 == 0 then
		if var_12_0[1].fight_girl and var_12_0[1].classtype == 2 then
			var_12_1 = arg_12_0.is_explore and explore_manager:getCurArrayModel(var_12_0[1]) or global_get_servant_skin(var_12_0[1].fight_girl)
		end
	else
		local var_12_4 = math.random(#var_12_2)

		var_12_3 = var_12_4
		var_12_1 = arg_12_0.is_explore and explore_manager:getCurArrayModel(var_12_2[var_12_4]) or global_get_servant_skin(var_12_2[var_12_4].fight_girl)
	end

	return var_12_1, var_12_3
end

local function var_0_34(arg_13_0, arg_13_1)
	local var_13_0 = var_0_32(arg_13_1)
	local var_13_1 = cc.p(var_13_0.x + 640, var_13_0.y)
	local var_13_2 = cc.p(var_13_0.x - 50, var_13_0.y)

	if model_data[arg_13_1].is_big_role_image then
		var_13_1 = var_13_0
		var_13_2 = var_13_0

		ccui.Helper:seekWidgetByName(arg_13_0, "Image_role"):setOpacity(0)
	end

	local var_13_3 = {
		Image_56 = {
			jumpTime = 0.1,
			time = 0.3,
			delay = 0,
			starPos = cc.p(-320, 660),
			endPos = cc.p(320, 660),
			endPosJump = cc.p(400, 660)
		},
		Panel_28 = {
			jumpTime = 0.1,
			time = 0.2,
			delay = 0.1,
			starPos = cc.p(-320, 645),
			endPos = cc.p(320, 645),
			endPosJump = cc.p(400, 645)
		},
		Image_role = {
			jumpTime = 0.1,
			time = 0.3,
			delay = 0.25,
			starPos = var_13_1,
			endPos = var_13_0,
			endPosJump = var_13_2
		},
		Image_54 = {
			jumpTime = 0.1,
			time = 0.2,
			delay = 0.3,
			starPos = cc.p(-320, 246 - GameDisplay.fix_y),
			endPos = cc.p(320, 246 - GameDisplay.fix_y),
			endPosJump = cc.p(350, 246 - GameDisplay.fix_y)
		},
		cost_ai = {
			jumpTime = 0.1,
			time = 0.2,
			delay = 0.3,
			starPos = cc.p(640, 100 - GameDisplay.fix_y),
			endPos = cc.p(320, 100 - GameDisplay.fix_y),
			endPosJump = cc.p(350, 100 - GameDisplay.fix_y)
		},
		Image_sub = {
			jumpTime = 0.1,
			time = 0.2,
			delay = 0.3,
			starPos = cc.p(-320, 246 - GameDisplay.fix_y),
			endPos = cc.p(320, 246 - GameDisplay.fix_y),
			endPosJump = cc.p(350, 246 - GameDisplay.fix_y)
		}
	}
	local var_13_4 = cc.NodeGrid:create()

	var_13_4:setName("actionnode")
	var_13_4:addChild((ccui.ImageView:create("ChapterSettlement/bg_win_fight.png", var_0_21)))
	ccui.Helper:seekWidgetByName(arg_13_0, "Panel_28"):addChild(var_13_4, 2)
	var_13_4:runAction(cc.Sequence:create(cc.TurnOffTiles:create(0.5, cc.size(150, 150), 2):reverse()))

	for iter_13_0, iter_13_1 in pairs(var_13_3) do
		if ccui.Helper:seekWidgetByName(arg_13_0, iter_13_0) then
			ccui.Helper:seekWidgetByName(arg_13_0, iter_13_0):setPosition(iter_13_1.starPos)
			ccui.Helper:seekWidgetByName(arg_13_0, iter_13_0):runAction(cc.Sequence:create(cc.DelayTime:create(iter_13_1.delay), cc.Spawn:create(cc.MoveTo:create(iter_13_1.time, iter_13_1.endPos), cc.FadeIn:create(iter_13_1.time)), cc.MoveTo:create(iter_13_1.jumpTime, iter_13_1.endPosJump), cc.MoveTo:create(iter_13_1.jumpTime, iter_13_1.endPos)))
		end
	end
end

local function var_0_35(arg_14_0)
	return model_data[arg_14_0].levelresult_scale or (not model_data[arg_14_0].is_big_role_image or nil) and 0.8
end

PopAdventureResultLayer = class("PopAdventureResultLayer", function()
	return PopBaseLayer:create()
end)

function PopAdventureResultLayer.create(arg_16_0, arg_16_1)
	local var_16_0 = PopAdventureResultLayer.new()

	var_16_0:initBg(arg_16_1)

	return var_16_0
end

function PopAdventureResultLayer.initBg(arg_17_0, arg_17_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_18_0)
		arg_17_0:addChild(arg_18_0, -1)
		arg_18_0:setPositionY(arg_18_0:getPositionY() - GameDisplay.fix_y)
		arg_17_0:init(arg_17_1)
	end)
end

function PopAdventureResultLayer:init(arg_19_1)
	self:initSuccess(arg_19_1)
end

local var_0_36 = {
	nil,
	true,
	true,
	true
}

local function var_0_39(arg_22_0)
	return ({
		[81421] = true,
		[572] = true,
		[89021] = true,
		[77921] = true,
		[83221] = true,
		[582] = true,
		[562] = true,
		[80921] = true,
		[74221] = true,
		[1042] = true,
		[79821] = true,
		[552] = true,
		[1041] = true,
		[76321] = true,
		[86721] = true,
		[87921] = true,
		[542] = true,
		[84221] = true,
		[79021] = true,
		[88621] = true,
		[81921] = true,
		[532] = true,
		[84921] = true,
		[522] = true,
		[75921] = true,
		[512] = true,
		[88221] = true,
		[85421] = true,
		[1043] = true,
		[87521] = true,
		[501] = true,
		[75021] = true,
		[79421] = true,
		[77121] = true,
		[85921] = true,
		[82721] = true,
		[83621] = true,
		[86221] = true,
		[85721] = true,
		[82521] = true
	})[arg_22_0]
end

function PopAdventureResultLayer:initSuccess(arg_23_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_mainLineResult.json" or "Pop_mainLineResult.ExportJson")

	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer, 2)

	local var_23_0 = levelmode_data[arg_23_1.mode].modetype

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_settlement")

	local var_23_1 = var_0_33(arg_23_1)

	self:initSuccessShowInfos(arg_23_1, var_23_1)
	self:initStarsInfo(self.rootLayer, arg_23_1)

	local var_23_2 = var_0_25(arg_23_1.level)

	if (function()
		if var_0_39(arg_23_1.mode) or var_0_19:isWeeklyTowerModetpye(var_23_0) then
			return true
		end
	end)() and var_23_2 < levelmode_data[arg_23_1.mode].totalchapter then
		local var_23_3 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_0_21)

		var_23_3:setPosition(GameDisplay.cx, self.bg:getPositionY() - 260)
		var_23_3:setZOrder(100)

		local var_23_4 = cc.Label:createWithTTF(L_FIGHT_RESULT_BUTTON[1], FONT_NAME, 30)

		var_23_4:setPosition(var_23_3:getContentSize().width / 2, var_23_3:getContentSize().height / 2)
		var_23_4:setColor(cc.c3b(0, 0, 0))
		var_23_3:addChild(var_23_4)
		var_23_3:addTouchEventListener(function(arg_25_0, arg_25_1)
			if arg_25_1 ~= ccui.TouchEventType.ended then
				return
			end

			if levelmode_data[arg_23_1.mode].totalchapter <= var_23_2 then
				return
			end

			var_0_19:selectDefaultSkill(arg_23_1)

			if arg_23_1.continuecallback then
				arg_23_1.continuecallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
		self.rootLayer:addChild(var_23_3)
	end

	local var_23_5 = arg_23_1.continuecallback
	local var_23_6 = arg_23_1.cancelcallback
	local var_23_7 = arg_23_1.refightcallback

	self.cancelcallback = arg_23_1.cancelcallback

	self:createFullScreenMask(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_26_0:isBright() then
			return
		end

		arg_26_0:setBright(false)

		if var_23_6 then
			var_23_6()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_cancel"):setVisible(var_0_36[var_23_0] ~= nil)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):setVisible(var_0_36[var_23_0] ~= nil)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_27_0:isBright() then
			return
		end

		arg_27_0:setBright(false)

		if arg_23_1.remainfighttime > 0 then
			if var_23_5 then
				var_23_5()
			end

			LayerManager:removePopLayer(self.__queueindex)
		elseif arg_23_1.canbuytime then
			self:buyAdventureDailyTime(var_23_0, arg_23_1.canbuytime, var_23_5, var_23_6)
		else
			global_ShowBlockWords(L_ADVENTURE_WARNING[4])
			arg_27_0:setBright(true)
		end
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_cancel"):addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_28_0:isBright() then
			return
		end

		arg_28_0:setBright(false)

		if var_23_6 then
			var_23_6()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
	var_0_34(self.rootLayer, var_23_1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):setPositionY(-80)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_cancel"):setPositionY(-80)

	if var_0_36[var_23_0] then
		local var_23_8 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")
		local var_23_9 = ccui.Button:create("ChapterSettlement/btn_refight.png", "ChapterSettlement/btn_refight.png", "ChapterSettlement/btn_refight.png", var_0_21)

		var_23_9:setName("buttonrefight")
		var_23_9:addTouchEventListener(function(arg_29_0, arg_29_1)
			if arg_29_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_29_0:isBright() then
				return
			end

			arg_29_0:setBright(false)

			if arg_23_1.remainfighttime > 0 then
				if var_23_7 then
					var_23_7()
				end

				LayerManager:removePopLayer(self.__queueindex)
			elseif arg_23_1.canbuytime then
				self:buyAdventureDailyTime(var_23_0, arg_23_1.canbuytime, var_23_7, var_23_6)
			else
				global_ShowBlockWords(L_ADVENTURE_WARNING[4])
				arg_29_0:setBright(true)
			end
		end)

		if var_23_0 == 2 then
			if RoleDefault:getInstance():getBoolForKey("AdventureItemAutoFight", false) then
				global_count_down_layer(4, function()
					if arg_23_1.remainfighttime > 0 then
						if var_23_7 then
							var_23_7()
						end

						LayerManager:removePopLayer(self.__queueindex)
					elseif arg_23_1.canbuytime then
						self:buyAdventureDailyTime(var_23_0, arg_23_1.canbuytime, var_23_7, var_23_6)
					else
						global_ShowBlockWords(L_ADVENTURE_WARNING[4])
					end
				end, function()
					RoleDefault:getInstance():setBoolForKey("AdventureItemAutoFight", false)
				end)
			end
		end

		var_23_8:getParent():addChild(var_23_9, var_23_8:getLocalZOrder())
		var_23_9:setPositionY(-80)

		if arg_23_1.clear then
			var_23_8:setVisible(false)
			var_23_9:setPositionX(var_23_8:getPositionX())
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Button_cancel"):setPositionX(var_23_8:getPositionX() - 410)
			var_23_9:setPositionX(var_23_8:getPositionX() - 205)
		end
	end

	if var_0_39(arg_23_1.mode) then
		if var_0_25(arg_23_1.level) >= levelmode_data[arg_23_1.mode].totalchapter then
			return
		end

		if RoleDefault:getInstance():getBoolForKey("AdventureTowerAutoFight", false) then
			global_count_down_layer(4, function()
				if arg_23_1.remainfighttime > 0 then
					if var_23_5 then
						var_23_5()
					end

					LayerManager:removePopLayer(self.__queueindex)
				elseif arg_23_1.canbuytime then
					self:buyAdventureDailyTime(var_23_0, arg_23_1.canbuytime, var_23_5, var_23_6)
				else
					global_ShowBlockWords(L_ADVENTURE_WARNING[4])
				end
			end, function()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("adv_tower_auto_fight")))
				RoleDefault:getInstance():setBoolForKey("AdventureTowerAutoFight", false)
			end)
		end
	end

	if var_0_19:isWeeklyTowerModetpye(var_23_0) then
		self:checkAutoFight(arg_23_1)
	end

	if require("controller.activity_manager"):isGroupTowerMode(levelmode_data[arg_23_1.mode].mode) then
		self:checkAutoFight(arg_23_1)
	end
end

function PopAdventureResultLayer.checkAutoFight(arg_34_0, arg_34_1)
	print("checkAutoFight", dump(arg_34_1))

	if var_0_25(arg_34_1.level) >= levelmode_data[arg_34_1.mode].totalchapter then
		return
	end

	if RoleDefault:getInstance():getBoolForKey("WeeklyAutoFight", false) then
		global_count_down_layer(4, function()
			var_0_19:selectDefaultSkill(arg_34_1)

			if arg_34_1.continuecallback then
				arg_34_1.continuecallback()
			end

			LayerManager:removePopLayer(arg_34_0.__queueindex)
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("set_weekly_autofight_false")))
			RoleDefault:getInstance():setBoolForKey("WeeklyAutoFight", false)
		end)
	end

	if RoleDefault:getInstance():getBoolForKey("GroupTowerAutoFight", false) then
		global_count_down_layer(4, function()
			if arg_34_1.continuecallback then
				arg_34_1.continuecallback()
			end

			LayerManager:removePopLayer(arg_34_0.__queueindex)
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("set_group_autofight_false")))
			RoleDefault:getInstance():setBoolForKey("GroupTowerAutoFight", false)
		end)
	end
end

function PopAdventureResultLayer:initSuccessShowInfos(arg_39_1, arg_39_2)
	local var_39_0 = var_0_25(arg_39_1.level)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_chappter"):setString(var_39_0 .. "/" .. level_manager:getModeTotalChapter(arg_39_1.mode))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_chappter"):setVisible(false)

	local var_39_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_role")
	local var_39_4

	if arg_39_1.data and arg_39_1.data.items then
		var_39_4 = var_0_31(arg_39_1.data.items)
	else
		return
	end

	local var_39_5 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_54")

	self.bg = var_39_5

	var_39_4:setPosition(cc.p(60, 9))
	var_39_5:addChild(var_39_4, 10)
	var_39_4:setCascadeOpacityEnabled(true)
	var_39_5:setVisible(next(arg_39_1.data.items))

	curarray = arg_39_1.curarray and next(arg_39_1.curarray) ~= nil and arg_39_1.curarray or playermodel.curSoul

	local var_39_6 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_fight_statistics")
	local var_39_7 = {}

	for iter_39_0, iter_39_1 in pairs(curarray) do
		if iter_39_1.fight_girl then
			var_39_7[#var_39_7 + 1] = {}
			var_39_7[#var_39_7].model = global_get_servant_skin(iter_39_1.fight_girl)
		end
	end

	local var_39_8 = fight_capacity_manager:getBossOrEnemyInfo(arg_39_1.mode, var_39_0)
	local var_39_9 = {}

	if var_39_8.boss then
		if #var_39_8.boss == 0 then
			var_39_9[#var_39_9 + 1] = {}
			var_39_9[#var_39_9].model = var_39_8.boss.modelid
		else
			for iter_39_2 = 1, #var_39_8.boss do
				var_39_9[#var_39_9 + 1] = {}
				var_39_9[#var_39_9].model = var_39_8.boss[iter_39_2].modelid
			end
		end
	end

	if var_39_8.monster then
		for iter_39_3 = 1, #var_39_8.monster do
			var_39_9[#var_39_9 + 1] = {}
			var_39_9[#var_39_9].model = var_39_8.monster[iter_39_3].modelid
		end
	end

	local function var_39_10()
		self:setVisible(true)
		var_39_6:setTouchEnabled(true)
	end

	local var_39_11 = {
		enemyName = "AI",
		oldRank = 0,
		RankIsVisable = true,
		enemyRank = 0,
		playerName = playermodel.nickname,
		playerArray = var_39_7,
		enemyArray = var_39_9
	}

	var_39_6:addTouchEventListener(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:setVisible(false)
		var_39_6:setTouchEnabled(false)
		LayerManager:pushInLayer("PvpResultLayer", {
			fightResult = "win",
			fightData = FightManager.getStatisticsMsg(),
			rankChange = var_39_11,
			cancelCallback = var_39_10
		})
	end)
	var_39_2:loadTexture(var_0_23 .. model_data[arg_39_2].role_image .. ".png")

	if arg_39_1.modelid then
		var_39_2:loadTexture(var_0_23 .. model_data[tostring(arg_39_1.modelid)].role_image .. ".png")
	end

	var_39_2:setScale((var_0_35(arg_39_2)))
	GlobalPlayRoleSound(arg_39_2, ROLE_SOUND_TYPE.win)

	if not require("controller.activity_manager"):isLockActivityBossFight(arg_39_1.mode) then
		if arg_39_1.data and next(arg_39_1.data) and arg_39_1.data.score and arg_39_1.data.score > 0 then
			local var_39_12 = cc.Label:createWithTTF("number.ttf", "fonts/name.ttf", 27)

			var_39_12:setAnchorPoint(cc.p(0, 0))
			var_39_12:setString(L_AVAON_VISUAL.chapter_score .. global_trans_number(arg_39_1.data.score))
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_54"):addChild(var_39_12, 1000)
			var_39_12:setPosition(cc.p(7, 142))
			var_39_12:enableOutline(cc.c4b(0, 0, 0, 255), 1)
		end

		if arg_39_1.data and next(arg_39_1.data) and arg_39_1.data.scoreinfinite and arg_39_1.data.scoreinfinite >= 0 then
			local var_39_13 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_54")

			var_39_13:loadTexture("ChapterSettlement/infinite_scorebg.png", var_0_21)

			local var_39_14 = cc.Label:createWithTTF("", "fonts/name.ttf", 50)

			var_39_14:setAnchorPoint(cc.p(0, 0))
			var_39_14:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			var_39_13:addChild(var_39_14, 1000)
			require("controller.l2utils"):numberlabelRandomAction(var_39_14, "" .. math.ceil(arg_39_1.data.scoreinfinite), 2, "linear", 20)
			var_39_14:setPosition(cc.p(var_39_13:getContentSize().width / 2 - 120, var_39_13:getContentSize().height / 2 - 34))

			local var_39_15 = level_manager:getinfiniteScoreInfo(playermodel.curMode)

			if var_39_15 and var_39_15 < arg_39_1.data.scoreinfinite then
				local var_39_16 = ccui.ImageView:create("ChapterSettlement/infinite_newflag.png", var_0_21)

				var_39_16:setAnchorPoint(cc.p(0, 0))
				var_39_16:setPosition(cc.p(var_39_14:getPositionX() + var_39_14:getContentSize().width, var_39_14:getPositionY() + var_39_14:getContentSize().height - 10))
				var_39_13:addChild(var_39_16)
			end
		end
	end
end

function PopAdventureResultLayer.initFail(arg_42_0, arg_42_1)
	return
end

function PopAdventureResultLayer.initStarsInfo(arg_43_0, arg_43_1, arg_43_2)
	if not levelmode_data[playermodel.curMode].is_check_stars then
		return
	end

	local chapter_star_data = require("data.chapter_star_data")
	local var_43_1 = ccui.ImageView:create("ChapterSettlement/star_info.png", var_0_21)

	var_43_1:setName("star_panel")
	var_43_1:setPositionX(760)
	arg_43_1:addChild(var_43_1, 999)

	local var_43_2 = arg_43_2.data and (arg_43_2.data.new_star or {}) or {}
	local var_43_3 = 470
	local var_43_4

	if arg_43_2.isrefight then
		var_43_4 = 192 - GameDisplay.fix_y

		ccui.Helper:seekWidgetByName(arg_43_1, "Image_54"):setVisible(false)
		var_43_1:setPositionY(var_43_4)
	else
		var_43_4 = 479 - GameDisplay.fix_y

		var_43_1:setPositionY(479 - GameDisplay.fix_y)
	end

	local var_43_5, var_43_6 = var_0_25(arg_43_2.level)
	local var_43_7 = arg_43_2.mode
	local var_43_8 = level_manager:getChapterStarsState(arg_43_2.mode, var_43_5)
	local var_43_9 = {
		cc.p(100, 178),
		cc.p(120, 110),
		cc.p(140, 45)
	}

	for iter_43_0 = 1, LEVEL_STARS_NUM do
		local var_43_10
		local var_43_11

		if var_43_8[iter_43_0] then
			var_43_10 = "ChapterSettlement/star_icon.png"
			var_43_11 = cc.c3b(255, 228, 0)
		else
			var_43_10 = "ChapterSettlement/star_gray.png"
			var_43_11 = cc.c3b(190, 213, 228)
		end

		local var_43_12 = ccui.ImageView:create(var_43_10, var_0_21)

		var_43_12:setScale(4)
		var_43_12:setVisible(false)
		var_43_12:setPosition(var_43_9[iter_43_0])
		var_43_1:addChild(var_43_12)

		if var_43_8[iter_43_0] and var_43_2[iter_43_0] then
			var_43_12:runAction(cc.Sequence:create(cc.DelayTime:create(0.5 + iter_43_0 * 0.2), cc.CallFunc:create(function()
				audio_manager:playeffectMusic(STAR_SOUND_EFFECT)
			end), cc.Show:create(), cc.ScaleTo:create(0.2, 1.25)))
		else
			var_43_12:setScale(1.35)
			var_43_12:setVisible(true)
		end

		local var_43_13 = cc.Label:createWithTTF(chapter_star_data[var_43_7 .. "-" .. var_43_5]["star" .. iter_43_0 .. "_des"] or "", FONT_NAME, 22)

		var_43_13:setColor(var_43_11)
		var_43_13:setAnchorPoint(cc.p(0, 0.5))
		var_43_13:setPosition(var_43_12:getPositionX() + 28, var_43_12:getPositionY())
		var_43_1:addChild(var_43_13)
	end

	if arg_43_2.isrefight then
		local var_43_14 = ccui.Helper:seekWidgetByName(arg_43_1, "Button_fight_statistics"):clone()

		var_43_14:setVisible(true)
		var_43_14:setAnchorPoint(cc.p(1, 0))
		var_43_14:setPosition(var_43_1:getContentSize().width - 40, var_43_1:getContentSize().height)
		var_43_1:addChild(var_43_14)

		local var_43_16 = {}

		for iter_43_1, iter_43_2 in pairs(arg_43_2.curarray and next(arg_43_2.curarray) ~= nil and arg_43_2.curarray or playermodel.curSoul) do
			if iter_43_2.fight_girl then
				var_43_16[#var_43_16 + 1] = {}
				var_43_16[#var_43_16].model = global_get_servant_skin(iter_43_2.fight_girl)
			end
		end

		local var_43_17, var_43_18 = var_0_25(arg_43_2.level)
		local var_43_19 = fight_capacity_manager:getBossOrEnemyInfo(arg_43_2.mode, var_43_17)
		local var_43_20 = {}

		if var_43_19.boss then
			if #var_43_19.boss == 0 then
				var_43_20[#var_43_20 + 1] = {}
				var_43_20[#var_43_20].model = var_43_19.boss.modelid
			else
				for iter_43_3 = 1, #var_43_19.boss do
					var_43_20[#var_43_20 + 1] = {}
					var_43_20[#var_43_20].model = var_43_19.boss[iter_43_3].modelid
				end
			end
		end

		if var_43_19.monster then
			for iter_43_4 = 1, #var_43_19.monster do
				var_43_20[#var_43_20 + 1] = {}
				var_43_20[#var_43_20].model = var_43_19.monster[iter_43_4].modelid
			end
		end

		local function var_43_21()
			arg_43_0:setVisible(true)
			var_43_14:setTouchEnabled(true)
		end

		local var_43_22 = {
			enemyName = "AI",
			oldRank = 0,
			RankIsVisable = true,
			enemyRank = 0,
			playerName = playermodel.nickname,
			playerArray = var_43_16,
			enemyArray = var_43_20
		}

		var_43_14:addTouchEventListener(function(arg_46_0, arg_46_1)
			if arg_46_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_43_0:setVisible(false)
			var_43_14:setTouchEnabled(false)
			LayerManager:pushInLayer("PvpResultLayer", {
				fightResult = "win",
				fightData = FightManager.getStatisticsMsg(),
				rankChange = var_43_22,
				cancelCallback = var_43_21
			})
		end)
	end

	var_43_1:runAction(cc.Sequence:create(cc.EaseIn:create(cc.MoveTo:create(0.4, cc.p(var_43_3, var_43_4)), 2.5), cc.MoveBy:create(0.1, cc.p(-10, 0)), cc.MoveBy:create(0.1, cc.p(10, 0))))
end

function PopAdventureResultLayer:exit()
	if self.cancelcallback then
		self.cancelcallback()
	end

	LayerManager:removePopLayer(self.__queueindex)
end

function PopAdventureResultLayer.buyAdventureDailyTime(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	local var_48_0 = RoleDefault:getInstance():getIntegerForKey("AdventureEnterTrialtype", 0)

	LayerManager:pushInLayer("PopDoLayer", {
		costtype = "diamond",
		ignorecost = true,
		surecallback = function()
			level_manager:buyAdventureDailyTime(arg_48_1, function(arg_50_0)
				if arg_50_0 == 1 then
					if arg_48_3 then
						arg_48_3()
					end

					LayerManager:removePopLayer(arg_48_0.__queueindex)
				else
					if arg_50_0 == 2 then
						LayerManager:pushInLayer("PopGoBuyDiamond", {
							is_need_pop_layer = 1
						})
					elseif arg_50_0 == 4 then
						global_ShowBlockWords(L_BUY_TIMES_OVERSIZE)
					else
						global_ShowBlockWords(L_ADVENTURE_WARNING[4])
					end

					ccui.Helper:seekWidgetByName(arg_48_0.rootLayer, "Button_sure"):setBright(true)
					ccui.Helper:seekWidgetByName(arg_48_0.rootLayer, "buttonrefight"):setBright(true)
				end
			end, var_48_0)
		end,
		cancelcallback = function()
			if arg_48_4 then
				arg_48_4()
			end

			LayerManager:removePopLayer(arg_48_0.__queueindex)
		end,
		cost = arg_48_2,
		own = playermodel.diamond,
		labels = {
			titleImage = "title_more_adventure_times.png",
			button = L_BUY_TIMES_MSG_MODETYPE_2.button,
			des = string.format(L_BUY_TIMES_MSG_MODETYPE_2.des, arg_48_2),
			more = string.format(L_BUY_TIMES_MSG_MODETYPE_2.more, arg_48_2)
		}
	})
end

PopMainLineResultLayer = class("PopMainLineResultLayer", function()
	return PopBaseLayer:create()
end)

function PopMainLineResultLayer.create(arg_53_0, arg_53_1)
	local var_53_0 = PopMainLineResultLayer.new()

	var_53_0:initBg(arg_53_1)

	return var_53_0
end

function PopMainLineResultLayer.initBg(arg_54_0, arg_54_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_55_0)
		arg_54_0:addChild(arg_55_0, -1)
		arg_55_0:setPositionY(arg_55_0:getPositionY() - GameDisplay.fix_y)
		arg_54_0:init(arg_54_1)
	end)
end

function PopMainLineResultLayer:init(arg_56_1)
	local var_56_1 = arg_56_1.level
	local var_56_2 = arg_56_1.data
	local var_56_3 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_mainLineResult.json" or "Pop_mainLineResult.ExportJson")

	var_56_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_56_3:setTouchEnabled(false)

	self.cancelcallback = arg_56_1.cancelcallback

	self:addChild(var_56_3, 2)
	self:initStarsInfo(var_56_3, arg_56_1)
	self:initStarsButton(var_56_3, arg_56_1)
	self:initAutoFight(var_56_3, arg_56_1)
	LayerManager:createFullScreenMask(self, 0, function(arg_57_0, arg_57_1)
		if arg_57_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)

		if arg_56_1.cancelcallback then
			arg_56_1.cancelcallback()
		end
	end)

	local var_56_4 = arg_56_1.curarray and next(arg_56_1.curarray) ~= nil and arg_56_1.curarray or playermodel.curSoul

	ccui.Helper:seekWidgetByName(var_56_3, "Button_sure"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_56_3, "Button_cancel"):setVisible(false)

	local var_56_5 = tonumber(split(var_56_1, "-")[1])

	ccui.Helper:seekWidgetByName(var_56_3, "Label_chappter"):setString(arg_56_1.showText)
	ccui.Helper:seekWidgetByName(var_56_3, "Label_chappter"):setVisible(false)

	local var_56_6 = ccui.Helper:seekWidgetByName(var_56_3, "Image_role")
	local var_56_7 = ccui.Helper:seekWidgetByName(var_56_3, "Button_fight_statistics")
	local var_56_8 = {}

	for iter_56_0, iter_56_1 in pairs(var_56_4) do
		if iter_56_1.fight_girl then
			var_56_8[#var_56_8 + 1] = {}
			var_56_8[#var_56_8].model = global_get_servant_skin(iter_56_1.fight_girl)
		end
	end

	local var_56_9, var_56_10 = var_0_25(playermodel.curLevel)
	local var_56_11 = fight_capacity_manager:getBossOrEnemyInfo(playermodel.curMode, var_56_9)
	local var_56_12 = {}

	if var_56_11.boss then
		if #var_56_11.boss == 0 then
			var_56_12[#var_56_12 + 1] = {}
			var_56_12[#var_56_12].model = var_56_11.boss.modelid
		else
			for iter_56_2 = 1, #var_56_11.boss do
				var_56_12[#var_56_12 + 1] = {}
				var_56_12[#var_56_12].model = var_56_11.boss[iter_56_2].modelid
			end
		end
	end

	if var_56_11.monster then
		for iter_56_3 = 1, #var_56_11.monster do
			var_56_12[#var_56_12 + 1] = {}
			var_56_12[#var_56_12].model = var_56_11.monster[iter_56_3].modelid
		end
	end

	local function var_56_13()
		self:setVisible(true)
		var_56_7:setTouchEnabled(true)
	end

	local var_56_14 = {
		enemyName = "AI",
		oldRank = 0,
		RankIsVisable = true,
		enemyRank = 0,
		playerName = playermodel.nickname,
		playerArray = var_56_8,
		enemyArray = var_56_12
	}

	var_56_7:addTouchEventListener(function(arg_59_0, arg_59_1)
		if arg_59_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:setVisible(false)
		var_56_7:setTouchEnabled(false)
		LayerManager:pushInLayer("PvpResultLayer", {
			fightResult = "win",
			fightData = FightManager.getStatisticsMsg(),
			rankChange = var_56_14,
			cancelCallback = var_56_13
		})
	end)

	local var_56_15 = {}

	if var_56_2 then
		var_56_15 = var_56_2
	end

	local var_56_16 = false

	for iter_56_4, iter_56_5 in pairs(var_56_15) do
		if type(iter_56_5.entityid) == "number" and (playermodel.items[iter_56_5.entityid].itemtype == kITEM_HERO or playermodel.items[iter_56_5.entityid].itemtype == kITEM_SKIN) then
			var_56_16 = true
		end
	end

	local var_56_17 = var_0_31(var_56_15)

	var_56_17:setPosition(cc.p(60, 9))
	ccui.Helper:seekWidgetByName(var_56_3, "Image_54"):addChild(var_56_17, 10)
	var_56_17:setCascadeOpacityEnabled(true)

	local var_56_18 = var_0_33(arg_56_1)

	var_56_6:loadTexture(var_0_23 .. model_data[var_56_18].role_image .. ".png")
	var_56_6:setScale((var_0_35(var_56_18)))

	if not var_56_16 then
		GlobalPlayRoleSound(var_56_18, ROLE_SOUND_TYPE.win)
	end

	var_0_34(var_56_3, var_56_18)
	self:registerScriptHandler(function(arg_60_0)
		if arg_60_0 == "exit" then
			KeyCodeManager:setKeyCodeEventlock(false)
		end
	end)
end

function PopMainLineResultLayer:exit()
	LayerManager:removePopLayer(self.__queueindex)

	if self.cancelcallback then
		self.cancelcallback()
	end
end

function PopMainLineResultLayer:initAutoFight(arg_62_1, arg_62_2)
	if arg_62_2.isrefight then
		return
	end

	local var_62_0 = ccui.ImageView:create("ChapterSettlement/auto_fight_bg.png", var_0_21)

	arg_62_1:addChild(var_62_0)
	var_62_0:setPosition(320, 55 - GameDisplay.fix_y)
	var_62_0:setScale(1.2, 1.2)
	var_62_0:setLocalZOrder(999)

	self.autofightBg = var_62_0

	local var_62_1 = 320

	if self.autofightBg then
		if self.nextFightButton and self.plotViewBtn then
			var_62_1 = 480
		elseif not self.plotViewBtn and self.nextFightButton then
			var_62_1 = 320
		end
	end

	local var_62_2 = ccui.Button:create("ChapterSettlement/auto_fight_choose.png", nil, "ChapterSettlement/auto_fight_choose.png", var_0_21)

	var_62_0:addChild(var_62_2)
	var_62_2:setPosition(var_62_0:getContentSize().width - var_62_2:getContentSize().width / 2 - 3, var_62_2:getContentSize().height / 2 + 3)
	var_62_2:setScale(1.2, 1.2)

	local var_62_3 = ccui.ImageView:create("ChapterSettlement/auto_fight_on.png", var_0_21)

	var_62_2:addChild(var_62_3)
	var_62_3:setPosition(15, 15)
	var_62_3:setScale(1.2, 1.2)

	self.autoFight = RoleDefault:getInstance():getBoolForKey("MainLineAutoFight", false)

	var_62_3:setVisible(self.autoFight)
	var_62_2:addTouchEventListener(function(arg_63_0, arg_63_1)
		if arg_63_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.autoFight = not self.autoFight

		var_62_3:setVisible(self.autoFight)
		AnalyticManager.clickAutoFight({
			autofight = self.autoFight
		})
		RoleDefault:getInstance():setBoolForKey("MainLineAutoFight", self.autoFight)
	end)

	if not level_manager:isPlayerPassLevel(UNLOCK_FIGHT_AUTO) then
		var_62_0:setVisible(false)
	end

	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("main_line_auto_fight", function(arg_64_0)
		self.autoFight = false

		var_62_3:setVisible(self.autoFight)
	end), self)

	if self.autoFight then
		global_count_down_layer(4, function()
			LayerManager:removePopLayer(self.__queueindex)

			local var_65_1 = level_manager:getJumpNextMode(playermodel.curMode)

			if arg_62_2.cancelcallback then
				arg_62_2.cancelcallback(nil, (var_65_1 and var_65_1 == -1 and level_manager:isLevelModeComplete(playermodel.curMode, (level_manager:getCurChapter(playermodel.curMode))) or nil) and false)
			end
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("main_line_auto_fight")))
			RoleDefault:getInstance():setBoolForKey("MainLineAutoFight", false)
		end)
	end

	var_62_0:setPositionX(840)
	var_62_0:runAction(cc.Sequence:create(cc.EaseIn:create(cc.MoveTo:create(0.4, cc.p(var_62_1, 55 - GameDisplay.fix_y)), 2.5), cc.MoveBy:create(0.1, cc.p(-10, 0)), cc.MoveBy:create(0.1, cc.p(10, 0))))
end

function PopMainLineResultLayer.initStarsInfo(arg_67_0, arg_67_1, arg_67_2)
	if level_manager:isTalkLevel(playermodel.curMode) then
		return
	end

	local chapter_star_data = require("data.chapter_star_data")
	local var_67_1 = ccui.ImageView:create("ChapterSettlement/star_info.png", var_0_21)

	var_67_1:setName("star_panel")
	var_67_1:setPositionX(800)
	arg_67_1:addChild(var_67_1, 999)

	local var_67_2 = arg_67_2.data and (arg_67_2.data.new_star or {}) or {}
	local var_67_3 = 470
	local var_67_4

	if arg_67_2.isrefight then
		var_67_4 = 192 - GameDisplay.fix_y

		ccui.Helper:seekWidgetByName(arg_67_1, "Image_54"):setVisible(false)
		var_67_1:setPositionY(var_67_4)
	else
		var_67_4 = 479 - GameDisplay.fix_y

		var_67_1:setPositionY(479 - GameDisplay.fix_y)
	end

	local var_67_5, var_67_6 = var_0_25(playermodel.curLevel)
	local var_67_7 = playermodel.curMode
	local var_67_8 = level_manager:getChapterStarsState(playermodel.curMode, var_67_5)
	local var_67_9 = {
		cc.p(90, 178),
		cc.p(110, 110),
		cc.p(130, 45)
	}

	for iter_67_0 = 1, LEVEL_STARS_NUM do
		local var_67_10
		local var_67_11

		if var_67_8[iter_67_0] then
			var_67_10 = "ChapterSettlement/star_icon.png"
			var_67_11 = cc.c3b(255, 228, 0)
		else
			var_67_10 = "ChapterSettlement/star_gray.png"
			var_67_11 = cc.c3b(190, 213, 228)
		end

		local var_67_12 = ccui.ImageView:create(var_67_10, var_0_21)

		var_67_12:setScale(4)
		var_67_12:setVisible(false)
		var_67_12:setPosition(var_67_9[iter_67_0])
		var_67_1:addChild(var_67_12)

		if var_67_8[iter_67_0] and var_67_2[iter_67_0] then
			var_67_12:runAction(cc.Sequence:create(cc.DelayTime:create(0.5 + iter_67_0 * 0.2), cc.CallFunc:create(function()
				audio_manager:playeffectMusic(STAR_SOUND_EFFECT)
			end), cc.Show:create(), cc.ScaleTo:create(0.2, 1.25)))
		else
			var_67_12:setScale(1.35)
			var_67_12:setVisible(true)
		end

		local var_67_13 = cc.Label:createWithTTF(chapter_star_data[var_67_7 .. "-" .. var_67_5]["star" .. iter_67_0 .. "_des"] or "", FONT_NAME, 24)

		var_67_13:setColor(var_67_11)
		var_67_13:setAnchorPoint(cc.p(0, 0.5))
		var_67_13:setPosition(var_67_12:getPositionX() + 32, var_67_12:getPositionY())
		var_67_1:addChild(var_67_13)

		if var_67_8[iter_67_0] and var_67_2[iter_67_0] then
			local var_67_14 = ccui.ImageView:create("public/currency/888888.png", var_0_21)

			var_67_14:setAnchorPoint(cc.p(0, 0.5))
			var_67_14:setScale(0.8)
			var_67_14:setPosition(var_67_13:getPositionX() + var_67_13:getContentSize().width + 6, var_67_13:getPositionY())
			var_67_1:addChild(var_67_14)

			local var_67_15 = cc.Label:createWithTTF("+5", FONT_NAME, 19)

			var_67_15:setAnchorPoint(cc.p(0, 0.5))
			var_67_15:setColor(var_67_11)
			var_67_15:setPosition(var_67_14:getPositionX() + 42, var_67_14:getPositionY())
			var_67_1:addChild(var_67_15)
			var_67_14:runAction(cc.Sequence:create(cc.DelayTime:create(0.5 + iter_67_0 * 0.2), cc.Show:create(), cc.ScaleTo:create(0.2, 1)))
			var_67_15:runAction(cc.Sequence:create(cc.DelayTime:create(0.5 + iter_67_0 * 0.2), cc.Show:create(), cc.ScaleTo:create(0.2, 1.25)))
		end
	end

	if arg_67_2.isrefight then
		local var_67_16 = ccui.Helper:seekWidgetByName(arg_67_1, "Button_fight_statistics"):clone()

		var_67_16:setVisible(true)
		var_67_16:setAnchorPoint(cc.p(1, 0))
		var_67_16:setPosition(var_67_1:getContentSize().width - 40, var_67_1:getContentSize().height)
		var_67_1:addChild(var_67_16)

		local var_67_18 = {}

		for iter_67_1, iter_67_2 in pairs(arg_67_2.curarray and next(arg_67_2.curarray) ~= nil and arg_67_2.curarray or playermodel.curSoul) do
			if iter_67_2.fight_girl then
				var_67_18[#var_67_18 + 1] = {}
				var_67_18[#var_67_18].model = global_get_servant_skin(iter_67_2.fight_girl)
			end
		end

		local var_67_19, var_67_20 = var_0_25(playermodel.curLevel)
		local var_67_21 = fight_capacity_manager:getBossOrEnemyInfo(playermodel.curMode, var_67_19)
		local var_67_22 = {}

		if var_67_21.boss then
			if #var_67_21.boss == 0 then
				var_67_22[#var_67_22 + 1] = {}
				var_67_22[#var_67_22].model = var_67_21.boss.modelid
			else
				for iter_67_3 = 1, #var_67_21.boss do
					var_67_22[#var_67_22 + 1] = {}
					var_67_22[#var_67_22].model = var_67_21.boss[iter_67_3].modelid
				end
			end
		end

		if var_67_21.monster then
			for iter_67_4 = 1, #var_67_21.monster do
				var_67_22[#var_67_22 + 1] = {}
				var_67_22[#var_67_22].model = var_67_21.monster[iter_67_4].modelid
			end
		end

		local function var_67_23()
			arg_67_0:setVisible(true)
			var_67_16:setTouchEnabled(true)
		end

		local var_67_24 = {
			enemyName = "AI",
			oldRank = 0,
			RankIsVisable = true,
			enemyRank = 0,
			playerName = playermodel.nickname,
			playerArray = var_67_18,
			enemyArray = var_67_22
		}

		var_67_16:addTouchEventListener(function(arg_70_0, arg_70_1)
			if arg_70_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_67_0:setVisible(false)
			var_67_16:setTouchEnabled(false)
			LayerManager:pushInLayer("PvpResultLayer", {
				fightResult = "win",
				fightData = FightManager.getStatisticsMsg(),
				rankChange = var_67_24,
				cancelCallback = var_67_23
			})
		end)
	end

	var_67_1:runAction(cc.Sequence:create(cc.EaseIn:create(cc.MoveTo:create(0.4, cc.p(var_67_3, var_67_4)), 2.5), cc.MoveBy:create(0.1, cc.p(-10, 0)), cc.MoveBy:create(0.1, cc.p(10, 0))))
end

function PopMainLineResultLayer.initStarsButton(arg_71_0, arg_71_1, arg_71_2)
	if level_manager:isTalkLevel(playermodel.curMode) then
		return
	end

	local var_71_0

	if arg_71_2.isrefight then
		var_71_0 = ccui.Helper:seekWidgetByName(arg_71_1, "Button_sure"):clone()

		var_71_0:setVisible(true)
		arg_71_1:addChild(var_71_0)

		local var_71_1 = cc.Label:createWithTTF(L_FIGHT_AGAIN, FONT_NAME, 30)

		var_71_1:setPosition(var_71_0:getContentSize().width / 2, var_71_0:getContentSize().height / 2 + 3)
		var_71_0:addChild(var_71_1)
		var_71_0:loadTextures("public/button/public_button_red.png", nil, "public/button/public_button_red.png", var_0_21)
		var_71_0:addTouchEventListener(function(arg_72_0, arg_72_1)
			if arg_72_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_72_0:isBright() then
				return
			end

			arg_72_0:setBright(false)
			LayerManager:removePopLayer(arg_71_0.__queueindex)
			require("controller.parse_server"):onFightBigBoss(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode), array_manager.last_refight_array)

			if arg_71_2.cancelcallback then
				arg_71_2.cancelcallback(1)
			end
		end)
	end

	local var_71_2 = ccui.Helper:seekWidgetByName(arg_71_1, "Button_cancel"):clone()

	var_71_2:setVisible(true)
	arg_71_1:addChild(var_71_2)

	local var_71_3 = cc.Label:createWithTTF(L_GO_NEXT_LEVEL, FONT_NAME, 30)
	local var_71_4 = playermodel.curMode

	if arg_71_2.isrefight then
		var_71_3:setString(L_ITEM_SURE_BTN)
	elseif level_manager:isLevelModeComplete(var_71_4, (level_manager:getCurChapter(playermodel.curMode))) then
		var_71_3:setString(L_GO_NEXT_CHAPTER)
	end

	var_71_3:setColor(cc.c3b(0, 0, 0))
	var_71_3:setPosition(var_71_2:getContentSize().width / 2, var_71_2:getContentSize().height / 2)
	var_71_2:addChild(var_71_3)
	var_71_2:setVisible(true)
	var_71_2:loadTextures("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_0_21)
	var_71_2:addTouchEventListener(function(arg_73_0, arg_73_1)
		if arg_73_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_73_0:isBright() then
			return
		end

		arg_73_0:setBright(false)
		LayerManager:removePopLayer(arg_71_0.__queueindex)

		if arg_71_2.cancelcallback then
			arg_71_2.cancelcallback()
		end

		if not arg_71_2.isrefight and arg_71_2.showText == "1-3" then
			require("controller/novice_month_card_pop_manager"):getInstance():requestPopInfo()
		end
	end)

	local var_71_5

	if not arg_71_2.isrefight and photo_manager:checkHaveData(arg_71_2.mode, arg_71_2.level) then
		local var_71_6 = var_0_22:CreateTempLayout()

		var_71_6:setContentSize(GameDisplay.size)
		var_71_6:setOpacity(0)

		local var_71_7 = var_0_22:CreateTempImg("ChapterSettlement/story_tips_img.png", var_71_6)

		var_71_7:move(cc.p(var_71_6:size().w / 2, var_71_6:size().h * 0.6))
		var_0_22:CreateTempLabel(L_PLOT_CLASS_STR.NORMAL .. " " .. photo_manager:getPhotoDataNameByModeAndLevel(arg_71_2.mode, arg_71_2.level) .. " " .. L_UNLOCK, FONT_NAME, 30, var_71_7):center()
		global_basic_scene:addChild(var_71_6, 999)
		var_71_6:runAction(cc.Sequence:create(cc.FadeIn:create(0.5), cc.DelayTime:create(1), cc.FadeOut:create(0.5), cc.RemoveSelf:create()))

		var_71_5 = var_0_22:CreateTempBtn("ChapterSettlement/look_story_btn.png")

		var_71_5:addTouchEventListener(function(arg_74_0, arg_74_1)
			if arg_74_1 ~= ccui.TouchEventType.ended then
				return
			end

			school_cinema_manager:init(function()
				local var_75_0 = school_cinema_manager:getCinemaInfo(3)
				local var_75_2
				local var_75_3

				for iter_75_0, iter_75_1 in pairs(var_75_0) do
					if type(iter_75_1) == "table" then
						local var_75_4 = false

						for iter_75_2 = #iter_75_1.list, 1, -1 do
							local var_75_5 = string.split(iter_75_1.list[iter_75_2].id, "#")

							if tostring(arg_71_2.mode) == var_75_5[1] and string.split(arg_71_2.level, "-")[1] == string.split(var_75_5[2], "-")[1] then
								var_75_4 = true
								var_75_3 = iter_75_2

								break
							end
						end

						if var_75_4 then
							var_75_2 = iter_75_0

							break
						end
					end
				end

				if var_75_2 and var_75_3 then
					local var_75_6 = var_75_0[var_75_2].list[var_75_3]

					school_cinema_manager:doPlayerStoryPlot({
						index = 3,
						unlocklevel = var_75_0[var_75_2].list[var_75_3].id,
						dIndex = var_75_2,
						cIndex = var_75_3
					}, function()
						if var_75_6.pv then
							if DeviceManager.platform == "ios" or DeviceManager.platform == "android" then
								require("view.Layer.SchoolCinemaLayer")
								SchoolCinemaLayer:playPV("video/" .. var_75_6.pv .. ".mp4")
							else
								global_ShowBlockWords(L_PV_WARNING.Platform_Win32)
							end
						else
							require("view.Layer.TalkLayer")
							global_basic_scene:addChild(TalkLayer:create(var_75_6.classification, nil, TALK_TYPE_NORMAL, var_75_6.name), 5)
						end

						AnalyticManager.fight_result_layer_look_story({
							look_story_info = arg_71_2.mode .. "#" .. arg_71_2.level
						})
					end)
				end
			end)
		end)
		var_71_5:setPosition(cc.p(160, 120 - GameDisplay.fix_y))
		var_71_5:setLocalZOrder(999)
		var_71_5:setName("plotViewBtn")
		arg_71_1:addChild(var_71_5)

		arg_71_0.plotViewBtn = var_71_5
	end

	local var_71_9 = level_manager:getJumpNextMode(playermodel.curMode) or var_71_4
	local var_71_10

	if not arg_71_2.isrefight and level_manager:isPlayerPassLevel(UNLOCK_FIGHT_NEXT) and not (var_71_9 and var_71_9 == -1) then
		var_71_10 = ccui.Button:create("public/button/public_button_normal_y.png", nil, "public/button/public_button_normal_y.png", var_0_21)

		arg_71_1:addChild(var_71_10)

		local var_71_11 = cc.Label:createWithTTF(L_FIGHT_RESULT_BUTTONS[1], FONT_NAME, 30)

		if level_manager:isLevelModeComplete(playermodel.curMode, (level_manager:getCurChapter(playermodel.curMode))) then
			var_71_11:setString(L_FIGHT_RESULT_BUTTONS[2])
		end

		var_71_11:setColor(cc.c3b(0, 0, 0))
		var_71_11:setPosition(var_71_10:getContentSize().width / 2, var_71_10:getContentSize().height / 2)
		var_71_10:addChild(var_71_11)
		var_71_10:setPosition(cc.p(480, 120 - GameDisplay.fix_y))
		var_71_10:addTouchEventListener(function(arg_77_0, arg_77_1)
			if arg_77_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_77_0:isBright() then
				return
			end

			arg_77_0:setBright(false)
			LayerManager:removePopLayer(arg_71_0.__queueindex)

			if arg_71_2.cancelcallback then
				arg_71_2.cancelcallback(nil, true)
			end
		end)
		var_71_10:setLocalZOrder(999)
		var_71_2:setVisible(false)

		arg_71_0.nextFightButton = var_71_10
	end

	if arg_71_2.isrefight then
		var_71_0:setPosition(-200, 220 - GameDisplay.fix_y)
		var_71_2:setPosition(-200, 120 - GameDisplay.fix_y)
		var_71_0:runAction(cc.Sequence:create(cc.EaseIn:create(cc.MoveTo:create(0.4, cc.p(130, 220 - GameDisplay.fix_y)), 2.5), cc.MoveBy:create(0.1, cc.p(-10, 0)), cc.MoveBy:create(0.1, cc.p(10, 0))))
		var_71_2:runAction(cc.Sequence:create(cc.EaseIn:create(cc.MoveTo:create(0.4, cc.p(130, 120 - GameDisplay.fix_y)), 2.5), cc.MoveBy:create(0.1, cc.p(-10, 0)), cc.MoveBy:create(0.1, cc.p(10, 0))))
	else
		var_71_2:setPosition(840, 120 - GameDisplay.fix_y)

		local var_71_12 = 320

		if photo_manager:checkHaveData(arg_71_2.mode, arg_71_2.level) then
			var_71_12 = 480
		end

		if var_71_5 then
			var_71_5:setPosition(520, 120 - GameDisplay.fix_y)
			var_71_5:runAction(cc.Sequence:create(cc.EaseIn:create(cc.MoveTo:create(0.4, cc.p(160, 120 - GameDisplay.fix_y)), 2.5), cc.MoveBy:create(0.1, cc.p(-10, 0)), cc.MoveBy:create(0.1, cc.p(10, 0))))
		end

		if var_71_10 then
			var_71_10:setPosition(840, 120 - GameDisplay.fix_y)
			var_71_10:runAction(cc.Sequence:create(cc.EaseIn:create(cc.MoveTo:create(0.4, cc.p(var_71_12, 120 - GameDisplay.fix_y)), 2.5), cc.MoveBy:create(0.1, cc.p(-10, 0)), cc.MoveBy:create(0.1, cc.p(10, 0))))
		end

		var_71_2:runAction(cc.Sequence:create(cc.EaseIn:create(cc.MoveTo:create(0.4, cc.p(var_71_12, 120 - GameDisplay.fix_y)), 2.5), cc.MoveBy:create(0.1, cc.p(-10, 0)), cc.MoveBy:create(0.1, cc.p(10, 0))))
	end
end

PopExploreResultLayer = class("PopExploreResultLayer", function()
	return PopBaseLayer:create()
end)

function PopExploreResultLayer.create(arg_79_0, arg_79_1)
	local var_79_0 = PopExploreResultLayer.new()

	var_79_0:initBg(arg_79_1)

	return var_79_0
end

function PopExploreResultLayer.initBg(arg_80_0, arg_80_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_81_0)
		arg_80_0:addChild(arg_81_0, -1)
		arg_81_0:setPositionY(arg_81_0:getPositionY() - GameDisplay.fix_y)
		arg_80_0:init(arg_80_1)
	end)
end

function PopExploreResultLayer:init(arg_82_1)
	local var_82_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_mainLineResult.json" or "Pop_mainLineResult.ExportJson")

	self:addChild(var_82_0, 99)
	ccui.Helper:seekWidgetByName(var_82_0, "Image_56"):loadTexture("ChapterSettlement/title_explore_result.png", var_0_21)
	audio_manager:playeffectMusicTest("sound/smallWin", false, 0.6)
	ccui.Helper:seekWidgetByName(var_82_0, "Button_sure"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_82_0, "Button_cancel"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_82_0, "Label_chappter"):setString(arg_82_1.showText)
	ccui.Helper:seekWidgetByName(var_82_0, "Label_chappter"):setVisible(false)

	local var_82_1 = ccui.Helper:seekWidgetByName(var_82_0, "Image_role")

	LayerManager:createFullScreenMask(self, 0, function(arg_83_0, arg_83_1)
		if arg_83_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)

		if arg_82_1.cancelcallback then
			arg_82_1.cancelcallback()
		end
	end)

	self.cancelcallback = arg_82_1.cancelcallback

	ccui.Helper:seekWidgetByName(var_82_0, "Button_fight_statistics"):setVisible(false)

	local var_82_2 = var_0_31(arg_82_1.items)

	var_82_2:setTouchEnabled(true)
	var_82_2:setPosition(cc.p(60, 9))
	ccui.Helper:seekWidgetByName(var_82_0, "Image_54"):addChild(var_82_2, 999)
	var_82_2:setCascadeOpacityEnabled(true)

	local var_82_4 = arg_82_1.curarray and next(arg_82_1.curarray) ~= nil and arg_82_1.curarray or playermodel.curSoul

	arg_82_1.is_explore = true

	local var_82_5, var_82_6 = var_0_33(arg_82_1)

	assert(model_data[var_82_5], var_82_5)
	var_82_1:loadTexture(var_0_23 .. model_data[var_82_5].role_image .. ".png")
	var_82_1:setScale((var_0_35(var_82_5)))

	if arg_82_1.curarray and next(arg_82_1.curarray) ~= nil and not arg_82_1.curarray[var_82_6].npcid then
		GlobalPlayRoleSound(var_82_5, ROLE_SOUND_TYPE.win)
	end

	var_0_34(var_82_0, var_82_5)
end

function PopExploreResultLayer:exit()
	LayerManager:removePopLayer(self.__queueindex)

	if self.cancelcallback then
		self.cancelcallback()
	end
end

PopSubsResultLayer = class("PopSubsResultLayer", function()
	return PopBaseLayer:create()
end)

function PopSubsResultLayer.create(arg_86_0, arg_86_1)
	local var_86_0 = PopSubsResultLayer.new()

	var_86_0:initBg(arg_86_1)

	return var_86_0
end

function PopSubsResultLayer.initBg(arg_87_0, arg_87_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_88_0)
		arg_87_0:addChild(arg_88_0, -1)
		arg_88_0:setPositionY(arg_88_0:getPositionY() - GameDisplay.fix_y)
		arg_87_0:init(arg_87_1)
	end)
end

function PopSubsResultLayer:init(arg_89_1)
	local var_89_0
	local var_89_1
	local var_89_2
	local var_89_3 = "0"
	local var_89_4
	local var_89_5 = {}

	self.fighttype = arg_89_1.fighttype

	if arg_89_1.fighttype == "monopoly" then
		var_89_0 = require("controller.expedition_manager"):getDamage()
	else
		var_89_0 = substitution_manager:get_damage()
		var_89_1 = substitution_manager:getNewScore()
		var_89_2 = substitution_manager:getOldScore()
		var_89_3 = substitution_manager:getUpStr()
		var_89_4 = substitution_manager:getLevel()
		var_89_5 = substitution_manager:getSubstitutionEnemy()
	end

	local var_89_6 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_mainLineResult.json" or "Pop_mainLineResult.ExportJson")

	self:addChild(var_89_6, 99)
	ccui.Helper:seekWidgetByName(var_89_6, "Image_56"):loadTexture("ChapterSettlement/title_sub_result.png", var_0_21)

	local var_89_7 = ccui.Helper:seekWidgetByName(var_89_6, "Button_fight_statistics")

	var_89_7:setVisible(false)
	audio_manager:playeffectMusicTest("sound/smallWin", false, 0.6)
	ccui.Helper:seekWidgetByName(var_89_6, "Button_sure"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_89_6, "Button_cancel"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_89_6, "Label_chappter"):setVisible(false)

	local var_89_8 = ccui.Helper:seekWidgetByName(var_89_6, "Image_role")

	LayerManager:createFullScreenMask(self, 0, function(arg_90_0, arg_90_1)
		if arg_90_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)

		if arg_89_1.cancelcallback then
			arg_89_1.cancelcallback()
		end
	end)

	local var_89_9 = ccui.Helper:seekWidgetByName(var_89_6, "Image_sub")
	local var_89_10 = ccui.Helper:seekWidgetByName(var_89_6, "Label_cur_socre")
	local var_89_11 = ccui.Helper:seekWidgetByName(var_89_6, "Label_addition")
	local var_89_12 = ccui.Helper:seekWidgetByName(var_89_6, "Label_cur_sum_score")
	local var_89_13 = ccui.Helper:seekWidgetByName(var_89_6, "Image_cur_max_score")
	local var_89_14 = ccui.Helper:seekWidgetByName(var_89_6, "Label_cancel")
	local var_89_15 = ccui.Helper:seekWidgetByName(var_89_6, "Button_start_fight")
	local var_89_16 = ccui.Helper:seekWidgetByName(var_89_6, "Image_result")

	ccui.Helper:seekWidgetByName(var_89_6, "BitmapLabel_damage"):setString(global_trans_bitmapnumber(tonumber(var_89_0)))

	if not var_89_1 then
		var_89_10:setString(global_trans_number(arg_89_1.score))
	else
		var_89_10:setString(global_trans_number(arg_89_1.score - var_89_2))
	end

	if var_89_3 ~= "0" then
		var_89_11:setPositionX(var_89_11:getPositionX() + var_89_10:getContentSize().width + 15)
		var_89_11:setString("(+" .. var_89_3 .. "%)")
	end

	if arg_89_1.result == 2 then
		var_89_12:setVisible(true)
		var_89_13:setVisible(false)
	elseif arg_89_1.result == 3 then
		ccui.Helper:seekWidgetByName(var_89_6, "Image_cur_score"):setVisible(false)
		ccui.Helper:seekWidgetByName(var_89_6, "Image_cur_max_score"):setVisible(false)
	else
		var_89_12:setString(global_trans_number(arg_89_1.score))
	end

	if arg_89_1.fightcount ~= 0 then
		var_89_15:addTouchEventListener(function(arg_91_0, arg_91_1)
			if arg_91_1 ~= ccui.TouchEventType.ended then
				return
			end

			local function var_91_0(arg_92_0, arg_92_1, arg_92_2)
				var_0_18:pushFormationLayer("FormationOverclockLayer", {
					mode = playermodel.curMode,
					level = var_89_4,
					configtype = CONFIG_TYPE_SUBSTITUTION,
					fightcount = arg_92_0,
					arraydata = arg_92_1,
					usingarrays = arg_92_2,
					cancelcallback = arg_89_1.cancelcallback
				})
			end

			LayerManager:removePopLayer(self.__queueindex)
			self:getSubArrayData(var_91_0)
		end)
	else
		if arg_89_1.win == 1 then
			var_89_16:setVisible(false)
		elseif arg_89_1.win == 0 then
			var_89_16:setVisible(true)
			var_89_16:loadTexture("ChapterSettlement/fight_over.png", var_0_21)
		end

		var_89_15:setVisible(false)
	end

	local var_89_17 = ccui.Helper:seekWidgetByName(var_89_6, "Image_54")

	var_89_9:setVisible(true)
	var_89_17:setVisible(false)

	local var_89_18, var_89_19 = var_0_33(arg_89_1)

	var_89_8:loadTexture(var_0_23 .. model_data[var_89_18].role_image .. ".png")
	var_89_8:setScale((var_0_35(var_89_18)))
	GlobalPlayRoleSound(var_89_18, ROLE_SOUND_TYPE.win)

	local function var_89_20()
		self:setVisible(true)
		var_89_7:setTouchEnabled(true)
	end

	local var_89_21 = {}

	for iter_89_0, iter_89_1 in pairs(playermodel.curSoul) do
		if iter_89_1.fight_girl then
			var_89_21[#var_89_21 + 1] = {}
			var_89_21[#var_89_21].model = global_get_servant_skin(iter_89_1.fight_girl)
		end
	end

	local var_89_22 = {}

	if var_89_5.boss then
		var_89_22[#var_89_22 + 1] = {}
		var_89_22[#var_89_22].model = var_89_5.boss.majorlist.modelid
	end

	local var_89_23 = {
		enemyName = "AI",
		oldRank = 0,
		RankIsVisable = true,
		enemyRank = 0,
		playerName = playermodel.nickname,
		playerArray = var_89_21,
		enemyArray = var_89_22
	}
	local var_89_25

	if arg_89_1.win == 1 then
		var_89_25 = "win"
	else
		local var_89_26 = chapter_data[playermodel.curMode .. "-" .. string.split(playermodel.curLevel, "-")[1]]

		var_89_25 = var_89_26 and ((var_89_26.limittime or 99999) <= math.ceil(FightManager.getFightTimeStatistics()) and "win" or "fail") or "fail"
	end

	local var_89_28 = var_0_22:CreateTempBtn("ChapterSettlement/btn_fight_data.png", var_89_10:getParent())

	var_89_28:align(cc.p(1, 0.5), GameDisplay.width - 10, 110)
	var_89_28:_addEvent(function()
		self:setVisible(false)
		var_89_7:setTouchEnabled(false)
		LayerManager:pushInLayer("PvpResultLayer", {
			fightData = FightManager.getStatisticsMsg(),
			rankChange = var_89_23,
			fightResult = var_89_25,
			cancelCallback = var_89_20
		})
	end)
	var_0_34(var_89_6, var_89_18)
end

function PopSubsResultLayer:getSubArrayData(arg_95_1)
	if self.fighttype == "monopoly" then
		if type(arg_95_1) == "function" then
			arg_95_1()
		end
	else
		substitution_manager:get_substitution_battlearrays(playermodel.curMode, arg_95_1)
	end
end

function PopSubsResultLayer:exit()
	LayerManager:removePopLayer(self.__queueindex)

	if self.cancelcallback then
		self.cancelcallback()
	end
end

PopOldSubsResultLayer = class("PopOldSubsResultLayer", function()
	return PopBaseLayer:create()
end)

function PopOldSubsResultLayer.create(arg_98_0, arg_98_1)
	print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr")

	local var_98_0 = PopOldSubsResultLayer.new()

	var_98_0:initBg(arg_98_1)

	return var_98_0
end

function PopOldSubsResultLayer.initBg(arg_99_0, arg_99_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_100_0)
		arg_99_0:addChild(arg_100_0, -1)
		arg_100_0:setPositionY(arg_100_0:getPositionY() - GameDisplay.fix_y)
		arg_99_0:init(arg_99_1)
	end)
end

function PopOldSubsResultLayer:init(arg_101_1)
	local var_101_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_mainLineResult.json" or "Pop_mainLineResult.ExportJson")

	self:addChild(var_101_0)
	ccui.Helper:seekWidgetByName(var_101_0, "Image_56"):loadTexture("ChapterSettlement/title_sub_result.png", var_0_21)
	audio_manager:playeffectMusicTest("sound/smallWin", false, 0.6)
	ccui.Helper:seekWidgetByName(var_101_0, "Button_sure"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_101_0, "Button_cancel"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_101_0, "Label_chappter"):setString(arg_101_1.showText)
	ccui.Helper:seekWidgetByName(var_101_0, "Label_chappter"):setVisible(false)

	local var_101_1 = ccui.Helper:seekWidgetByName(var_101_0, "Image_role")

	LayerManager:createFullScreenMask(self, 0, function(arg_102_0, arg_102_1)
		if arg_102_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)

		if arg_101_1.cancelcallback then
			arg_101_1.cancelcallback()
		end
	end)

	self.cancelcallback = arg_101_1.cancelcallback

	ccui.Helper:seekWidgetByName(var_101_0, "Button_fight_statistics"):setVisible(false)

	local var_101_4 = var_0_29((arg_101_1.newItems or nil) and arg_101_1.newItems, (arg_101_1.oldItems or nil) and arg_101_1.oldItems)
	local var_101_5 = ccui.Helper:seekWidgetByName(var_101_0, "Image_54")

	var_101_5:loadTexture("ChapterSettlement/bg_award_win_fight_sub.png", var_0_21)
	var_101_4:setPosition(cc.p(0, 9))
	var_101_5:addChild(var_101_4, 10)
	var_101_4:setCascadeOpacityEnabled(true)

	local var_101_7 = arg_101_1.curarray and next(arg_101_1.curarray) ~= nil and arg_101_1.curarray or playermodel.curSoul
	local var_101_8 = var_0_33(arg_101_1)

	var_101_1:loadTexture(var_0_23 .. model_data[var_101_8].role_image .. ".png")
	var_101_1:setScale((var_0_35(var_101_8)))
	GlobalPlayRoleSound(var_101_8, ROLE_SOUND_TYPE.win)
	var_0_34(var_101_0, var_101_8)

	local var_101_10 = ccui.ImageView:create("ChapterSettlement/damage.png", var_0_21)

	var_101_10:setPosition(cc.p(var_101_10:getContentSize().width / 2 - 10, 175))
	var_101_5:addChild(var_101_10, 10)

	local var_101_11 = ccui.TextBMFont:create(global_trans_bitmapnumber(arg_101_1.hp), "fonts/array_fightcapacity_number2.fnt")

	var_101_11:setAnchorPoint(cc.p(0, 0.5))
	var_101_11:setPosition(cc.p(var_101_10:getContentSize().width / 2 - 100, var_101_10:getContentSize().height / 2 - 6))
	var_101_11:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	var_101_10:addChild(var_101_11, 99)
end

function PopOldSubsResultLayer:exit()
	LayerManager:removePopLayer(self.__queueindex)

	if self.cancelcallback then
		self.cancelcallback()
	end
end

PopAIAttackResultLayer = class("PopAIAttackResultLayer", function()
	return PopBaseLayer:create()
end)

function PopAIAttackResultLayer.create(arg_105_0, arg_105_1)
	local var_105_0 = PopAIAttackResultLayer.new()

	var_105_0:initBg(arg_105_1)

	return var_105_0
end

function PopAIAttackResultLayer.initBg(arg_106_0, arg_106_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_107_0)
		arg_106_0:addChild(arg_107_0, -1)
		arg_107_0:setPositionY(arg_107_0:getPositionY() - GameDisplay.fix_y)
		arg_106_0:init(arg_106_1)
	end)
end

function PopAIAttackResultLayer:init(arg_108_1)
	local var_108_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_mainLineResult.json" or "Pop_mainLineResult.ExportJson")

	self:addChild(var_108_0)
	ccui.Helper:seekWidgetByName(var_108_0, "Image_56"):loadTexture("ChapterSettlement/title_sub_result.png", var_0_21)
	audio_manager:playeffectMusicTest("sound/smallWin", false, 0.6)
	ccui.Helper:seekWidgetByName(var_108_0, "Button_sure"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_108_0, "Button_cancel"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_108_0, "Label_chappter"):setString(arg_108_1.showText)
	ccui.Helper:seekWidgetByName(var_108_0, "Label_chappter"):setVisible(false)

	local var_108_1 = ccui.Helper:seekWidgetByName(var_108_0, "Image_role")

	LayerManager:createFullScreenMask(var_108_0, 0, function(arg_109_0, arg_109_1)
		if arg_109_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)

		if arg_108_1.cancelcallback then
			arg_108_1.cancelcallback()
		end
	end)

	self.cancelcallback = arg_108_1.cancelcallback

	ccui.Helper:seekWidgetByName(var_108_0, "Button_fight_statistics"):setVisible(false)
	var_108_1:loadTexture(var_0_23 .. model_data[arg_108_1.modelid].role_image .. ".png")
	var_108_1:setScale((var_0_35(arg_108_1.modelid)))

	if arg_108_1.data and arg_108_1.data.items then
		getitems = arg_108_1.data.items

		local var_108_3 = var_0_31(getitems)
		local var_108_4 = ccui.Helper:seekWidgetByName(var_108_0, "Image_54")

		var_108_4:loadTexture("ChapterSettlement/bg_award_win_fight_sub.png", var_0_21)
		var_108_3:setPosition(cc.p(60, 9))
		var_108_4:addChild(var_108_3, 10)
		var_108_3:setCascadeOpacityEnabled(true)
	end

	if arg_108_1.cost_ai then
		local var_108_5 = ccui.ImageView:create("ChapterSettlement/bg_award_win_fight_sub.png", var_0_21)

		var_108_5:setPosition(320, 236)
		var_108_5:setName("cost_ai")
		var_108_5:setTouchEnabled(true)
		var_108_0:addChild(var_108_5, 999)

		local var_108_6 = cc.Label:createWithTTF("阵\n亡\n名\n单", FONT_DES, 22)

		var_108_6:setAnchorPoint(1, 0.5)
		var_108_5:addChild(var_108_6)
		var_108_6:setPosition(var_108_6:getContentSize().width + 10, var_108_5:getContentSize().height / 2)

		local var_108_7 = ccui.ScrollView:create()

		var_108_7:setDirection(ccui.ScrollViewDir.horizontal)
		var_108_7:setContentSize(cc.size(var_108_5:getContentSize().width - var_108_6:getPositionX(), var_108_5:getContentSize().height))
		var_108_7:setPosition(var_108_6:getPositionX(), 0)
		var_108_7:setBounceEnabled(true)
		var_108_7:setInnerContainerSize(cc.size(174 * 0.56 * #arg_108_1.cost_ai, var_108_7:getContentSize().height))
		var_108_5:addChild(var_108_7)

		for iter_108_0, iter_108_1 in pairs(arg_108_1.cost_ai) do
			local var_108_8 = ItemSprite:createNewWithItemId(iter_108_1.itemid, iter_108_1.num)

			var_108_8:setScale(0.56)
			var_108_8:setPositionX(174 * 0.56 / 2 + (iter_108_0 - 1) * (174 * 0.56))
			var_108_8:setPositionY(var_108_7:getContentSize().height / 2)
			var_108_7:addChild(var_108_8)
		end
	end

	var_0_34(var_108_0, arg_108_1.modelid)
end

function PopAIAttackResultLayer:exit()
	LayerManager:removePopLayer(self.__queueindex)

	if self.cancelcallback then
		self.cancelcallback()
	end
end

PopTowerDefenceResultLayer = class("PopTowerDefenceResultLayer", function()
	return PopBaseLayer:create()
end)

function PopTowerDefenceResultLayer.create(arg_112_0, arg_112_1)
	local var_112_0 = PopTowerDefenceResultLayer.new()

	var_112_0:initBg(arg_112_1)

	return var_112_0
end

function PopTowerDefenceResultLayer.initBg(arg_113_0, arg_113_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_114_0)
		arg_113_0:addChild(arg_114_0, -1)
		arg_114_0:setPositionY(arg_114_0:getPositionY() - GameDisplay.fix_y)
		arg_113_0:init(arg_113_1)
	end)
end

function PopTowerDefenceResultLayer:init(arg_115_1)
	local var_115_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_mainLineResult.json" or "Pop_mainLineResult.ExportJson")

	self:addChild(var_115_0)
	ccui.Helper:seekWidgetByName(var_115_0, "Image_56"):loadTexture("ChapterSettlement/title_sub_result.png", var_0_21)
	audio_manager:playeffectMusicTest("sound/smallWin", false, 0.6)
	ccui.Helper:seekWidgetByName(var_115_0, "Button_sure"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_115_0, "Button_cancel"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_115_0, "Label_chappter"):setString(arg_115_1.showText)
	ccui.Helper:seekWidgetByName(var_115_0, "Label_chappter"):setVisible(false)

	local var_115_1 = ccui.Helper:seekWidgetByName(var_115_0, "Image_role")

	LayerManager:createFullScreenMask(var_115_0, 0, function(arg_116_0, arg_116_1)
		if arg_116_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)

		if arg_115_1.cancelcallback then
			arg_115_1.cancelcallback()
		end
	end)

	self.cancelcallback = arg_115_1.cancelcallback

	ccui.Helper:seekWidgetByName(var_115_0, "Button_fight_statistics"):setVisible(false)

	local var_115_2 = arg_115_1.modelid or "22120"

	var_115_1:loadTexture(var_0_23 .. model_data[var_115_2].role_image .. ".png")
	var_115_1:setScale((var_0_35(var_115_2)))

	if arg_115_1.data and arg_115_1.data.items and next(arg_115_1.data.items) ~= nil then
		getitems = arg_115_1.data.items

		local var_115_4 = var_0_31(getitems)

		var_115_4:setPosition(cc.p(60, 9))
		ccui.Helper:seekWidgetByName(var_115_0, "Image_54"):addChild(var_115_4, 10)
		var_115_4:setCascadeOpacityEnabled(true)
	else
		ccui.Helper:seekWidgetByName(var_115_0, "Image_54"):setVisible(false)
	end

	var_0_34(var_115_0, var_115_2)
end

function PopAIAttackResultLayer:exit()
	LayerManager:removePopLayer(self.__queueindex)

	if self.cancelcallback then
		self.cancelcallback()
	end
end

PopExpeditionResultLayer = class("PopExpeditionResultLayer", function()
	return PopBaseLayer:create()
end)

function PopExpeditionResultLayer.create(arg_119_0, arg_119_1)
	local var_119_0 = PopExpeditionResultLayer.new()

	var_119_0:initBg(arg_119_1)

	return var_119_0
end

function PopExpeditionResultLayer.initBg(arg_120_0, arg_120_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_121_0)
		arg_120_0:addChild(arg_121_0, -1)
		arg_121_0:setPositionY(arg_121_0:getPositionY() - GameDisplay.fix_y)
		arg_120_0:init(arg_120_1)
	end)
end

function PopExpeditionResultLayer:init(arg_122_1)
	local var_122_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_mainLineResult.json" or "Pop_mainLineResult.ExportJson")

	self:addChild(var_122_0)
	ccui.Helper:seekWidgetByName(var_122_0, "Image_56"):loadTexture("ChapterSettlement/title_sub_result.png", var_0_21)
	audio_manager:playeffectMusicTest("sound/smallWin", false, 0.6)
	ccui.Helper:seekWidgetByName(var_122_0, "Button_sure"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_122_0, "Button_cancel"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_122_0, "Label_chappter"):setString(arg_122_1.showText)
	ccui.Helper:seekWidgetByName(var_122_0, "Label_chappter"):setVisible(false)

	local var_122_1 = ccui.Helper:seekWidgetByName(var_122_0, "Image_role")

	LayerManager:createFullScreenMask(var_122_0, 0, function(arg_123_0, arg_123_1)
		if arg_123_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)

		if arg_122_1.cancelcallback then
			arg_122_1.cancelcallback()
		end
	end)

	self.cancelcallback = arg_122_1.cancelcallback

	ccui.Helper:seekWidgetByName(var_122_0, "Button_fight_statistics"):setVisible(false)

	local var_122_2 = arg_122_1.modelid or "22120"

	var_122_1:loadTexture(var_0_23 .. model_data[var_122_2].role_image .. ".png")
	var_122_1:setScale((var_0_35(var_122_2)))

	if arg_122_1.data and arg_122_1.data.items and next(arg_122_1.data.items) ~= nil then
		getitems = arg_122_1.data.items

		local var_122_4 = var_0_31(getitems)

		var_122_4:setPosition(cc.p(60, 9))
		ccui.Helper:seekWidgetByName(var_122_0, "Image_54"):addChild(var_122_4, 10)
		var_122_4:setCascadeOpacityEnabled(true)
	else
		ccui.Helper:seekWidgetByName(var_122_0, "Image_54"):setVisible(false)
	end

	var_0_34(var_122_0, var_122_2)
end
