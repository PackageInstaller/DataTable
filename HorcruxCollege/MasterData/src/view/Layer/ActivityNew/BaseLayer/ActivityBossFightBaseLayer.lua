ActivityBossFightBaseLayer = class("ActivityBossFightBaseLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local Utility = require("common.Utility")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local time_check_manager = require("controller.time_check_manager")
local adverture_random_manager = require("controller.adverture_random_manager")
local activity_manager = require("controller.activity_manager")

function ActivityBossFightBaseLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityBossFightBaseLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityBossFightBaseLayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId
	self.modetype = ACTIVITY_ID_TO_MODETYPE_FUNC.boss_fight(self.activityId)
	self.layerName = "ActivityBossFight_" .. self.activityId

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.bg = ccui.ImageView:create((string.format("mainScenebg/activity/branch%d/bossfight_bg.png", self.activityId)))

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:get_activity_bossfight_info(self.activityId)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})
		end
	end)
end

function ActivityBossFightBaseLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_BOSSFIGHT_INFO_UPDATE, function(arg_6_0)
		self:updateUI()
	end)
end

function ActivityBossFightBaseLayer:initUI()
	self:initBottomList()
	self:initTitle()
	self:initPatrolPanel()
end

function ActivityBossFightBaseLayer:initBottomList()
	self.bottomList = self.rootLayer:getChildByName("bottomList")

	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setLocalZOrder(888)
	self.bottomList:getChildByName("Button_43"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.btnRank = self.bottomList:getChildByName("btn_rank")

	if self.btnRank then
		self.btnRank:setVisible(false)
		self.btnRank:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self.modetype or not self.rank then
				return
			end

			LayerManager:switchShowLayer("AdventureInfiniteRankLayer", {
				modetype = self.modetype,
				score = self.totalscore,
				rank = self.rank
			})
		end)
	end
end

function ActivityBossFightBaseLayer:initTitle()
	local function var_11_0(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityBossFight_" .. self.activityId
		})
	end

	local var_11_1 = self.rootLayer:getChildByName("img_title")

	var_11_1:setPositionY(var_11_1:getPositionY() + GameDisplay.fix_y)
	var_11_1:getChildByName("Button_24"):addTouchEventListener(var_11_0)
	var_11_1:getChildByName("Button_35"):addTouchEventListener(var_11_0)
	var_11_1:getChildByName("Button_46"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.patrolPanel:setVisible(true)
	end)

	local var_11_2 = var_11_1:getChildByName("Label_27")
	local var_11_3, var_11_4 = adverture_random_manager:getOpenTimeByModeType(self.modetype)

	if type(var_11_3) == "number" and var_11_3 < 0 or type(var_11_4) == "number" and var_11_4 < 0 then
		var_11_2:setVisible(false)

		return
	end

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(global_get_time_by_date(var_11_4) - time_check_manager:getCurTime(), function(arg_14_0)
		var_11_2:setString("剩余时间:" .. Global_format_time_str(arg_14_0))

		if arg_14_0 <= 0 and self.activityScheduler then
			time_check_manager:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end
	end)))
end

function ActivityBossFightBaseLayer:initPatrolPanel()
	self.patrolPanel = self.rootLayer:getChildByName("Panel_47")

	self.patrolPanel:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.patrolPanel:setPositionY(-GameDisplay.fix_y)
	self.patrolPanel:setVisible(false)

	self.patrolBG = self.patrolPanel:getChildByName("Image_48")

	self.patrolBG:setPositionY(self.patrolBG:getPositionY() + GameDisplay.fix_y)
	self.patrolPanel:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.patrolPanel:setVisible(false)
	end)

	self.tempPatrolSprite = self.patrolBG:getChildByName("Image_49")

	local var_15_0 = self.patrolBG:getChildByName("Panel_68")

	self.patrolView = cc.TableView:create(cc.size(var_15_0:getContentSize().width + 50, var_15_0:getContentSize().height))

	self.patrolView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.patrolView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.patrolView:setAnchorPoint(cc.p(0, 0))
	self.patrolView:setPosition(-20, 25)
	self.patrolView:setDelegate()
	self.patrolBG:addChild(self.patrolView)
	self.patrolView:registerScriptHandler(function(arg_18_0, arg_18_1)
		return 640, 200
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.patrolView:registerScriptHandler(function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_0:dequeueCell()

		if not var_17_0 then
			var_17_0 = cc.TableViewCell:create()

			local var_17_3 = self:updatePatrolSprite(arg_17_1 + 1)

			var_17_3:setName("sprite")
			var_17_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_17_3:setPosition(cc.p(320, 100))
			var_17_0:addChild(var_17_3)
		else
			self:updatePatrolSprite(arg_17_1 + 1, (var_17_0:getChildByName("sprite")))
		end

		return var_17_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.patrolView:registerScriptHandler(function(arg_19_0, arg_19_1)
		return #self.patrolListData
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
end

function ActivityBossFightBaseLayer:updateUI()
	self:updateRewardPanel()
	self:updateBossFightPanel()
	self:updatePatrolPanel()
end

function ActivityBossFightBaseLayer:updateRewardPanel()
	self.rewardPanel = self.rootLayer:getChildByName("img_award")

	self.rewardPanel:setAnchorPoint(cc.p(0.5, 0))
	self.rewardPanel:setPositionY(self.bottomList:getPositionY() + 50)

	self.rewardView = self.rewardPanel:getChildByName("ListView_30")

	self.rewardView:removeAllChildren()

	self.rewardItemTemp = self.rootLayer:getChildByName("items2")

	self.rewardView:setItemsMargin(0)

	self.rewardList = activity_manager:getBossFightRewardList(self.activityId)

	if not self.rewardList or not next(self.rewardList) then
		self.rewardPanel:setVisible(false)
		self.btnRank:setVisible(fasle)

		return
	end

	self.curScore = activity_manager:getBossFightRewardScore(self.activityId)

	self.rewardPanel:getChildByName("Label_67"):setString(self.curScore)

	for iter_21_0, iter_21_1 in ipairs(self.rewardList) do
		self.rewardView:pushBackCustomItem((self:createRewardSprite(iter_21_0)))
	end

	local var_21_0 = activity_manager:getBossFightRewardIndex(self.activityId)

	if var_21_0 > 3 then
		local var_21_1 = math.max(0, (math.min((var_21_0 - 1) * (100 / (#self.rewardList - self.rewardView:getContentSize().width / 107)), 100)))

		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			self.rewardView:scrollToPercentHorizontal(var_21_1, 0.5, false)
		end)))
	end
end

function ActivityBossFightBaseLayer:createRewardSprite(arg_23_1)
	local var_23_0 = self.rewardList[arg_23_1]
	local var_23_1 = self.rewardItemTemp:clone()
	local var_23_2 = var_23_1:getChildByName("img_row")
	local var_23_3 = var_23_1:getChildByName("img_canget")
	local var_23_4 = var_23_1:getChildByName("Image_65")
	local var_23_5 = var_23_1:getChildByName("Image_68")
	local var_23_6 = var_23_5:getChildByName("Label_69")

	var_23_3:setVisible(false)
	var_23_4:setVisible(false)
	var_23_1:getChildByName("need_img_di"):getChildByName("Label_64"):setString(var_23_0.needScore)
	var_23_1:getChildByName("progress"):setScaleX(activity_manager:getBossFightRewardpercent(self.activityId, arg_23_1))

	if var_23_0.needScore > self.curScore then
		var_23_2:loadTexture(self.layerName .. "/img_row_off.png", var_0_0)
	else
		if var_23_0.havereceived then
			var_23_4:setVisible(true)
		else
			var_23_3:setVisible(true)
		end

		var_23_2:loadTexture(self.layerName .. "/img_row_on.png", var_0_0)
	end

	local var_23_7 = Utility:getDropData(var_23_0.dropid)
	local var_23_8
	local var_23_9 = 0

	if var_23_7 and next(var_23_7) then
		var_23_8 = var_23_7[1].itemid
		var_23_9 = var_23_7[1].num
	elseif var_23_7.diamond and var_23_7.diamond > 0 then
		var_23_8 = "diamond"
		var_23_9 = var_23_7.diamond
	elseif var_23_7.gold then
		var_23_8 = "gold"
		var_23_9 = var_23_7.gold
	end

	if var_23_8 and var_23_9 then
		if type(var_23_8) == "string" then
			icon = ccui.Button:create("public/box/1.png", "public/box/1.png", nil, var_0_0)
		else
			itemInfo = item_data[var_23_8]
			icon = ccui.Button:create("public/box/" .. itemInfo.equip_quality .. ".png", "public/box/" .. itemInfo.equip_quality .. ".png", nil, var_0_0)
		end

		icon:setAnchorPoint(cc.p(0.5, 0.5))
		icon:setPosition(cc.p(0, 0))
		icon:setTouchEnabled(true)
		icon:setSwallowTouches(true)
		icon:setPosition(cc.p(var_23_1:getContentSize().width / 2, var_23_1:getContentSize().height / 2 + 8))
		icon:setName("awarditem")
		var_23_1:addChild(icon, 2)
		var_23_5:setLocalZOrder(3)
		icon:setScale9Enabled(true)
		icon:setContentSize(cc.size(94, 124))

		local var_23_10
		local var_23_11

		if var_23_8 == "gold" then
			var_23_10 = "equipment/1000001.png"
		elseif var_23_8 == "diamond" then
			var_23_10 = "equipment/1000000.png"
		elseif item_data[var_23_8].bag_item_type == kITEM_MEDAL then
			var_23_11 = ItemSprite:create_medal_icon(var_23_8)
		elseif item_data[var_23_8].bag_item_type == kITEM_COMPONENT then
			var_23_11 = componentManager:create_component_icon(var_23_8, nil, nil)
		elseif item_data[var_23_8].bag_item_type == kITEM_SCULTURE then
			var_23_11 = AvatarSprite:create(var_23_8)
		elseif item_data[var_23_8].image_id then
			var_23_10 = "equipment/" .. item_data[var_23_8].image_id .. ".png"
		end

		var_23_11 = var_23_11 or ccui.ImageView:create(var_23_10)

		var_23_11:setPosition(cc.p(icon:getContentSize().width / 2, icon:getContentSize().height / 2 + 3))
		var_23_11:setName("ItemSprite")

		local var_23_12 = math.min(var_23_11:getContentSize().width, var_23_11:getContentSize().height)
		local var_23_13 = 90 / var_23_12

		if var_23_8 and item_data[var_23_8] and item_data[var_23_8].bag_item_type == kITEM_SCULTURE then
			var_23_13 = 140 / var_23_12

			var_23_11:setPosition(cc.p(0, 20))
		end

		var_23_11:setScale(var_23_13)
		icon:addChild(var_23_11)

		icon.step = arg_23_1
		icon.itemid = var_23_8

		var_23_6:setString("x" .. var_23_9)
		var_23_5:setVisible(true)
		icon:addTouchEventListener(function(arg_24_0, arg_24_1)
			if arg_24_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.curScore >= var_23_0.needScore and not var_23_0.havereceived then
				activity_manager:get_adventure_score_awards(self.activityId, arg_23_1)
			else
				showItemDetails(var_23_8)
			end
		end)
	end

	return var_23_1
end

function ActivityBossFightBaseLayer:updateBossFightPanel()
	self.fightView = self.rootLayer:getChildByName("ListView_59")
	self.fightSpriteTemp = self.rootLayer:getChildByName("items")

	self.fightView:removeAllChildren()
	self.fightView:setItemsMargin(12)

	self.fightViewheight = self.fightViewheight or self.fightView:getContentSize().height + GameDisplay.fix_y * 2

	local var_25_0 = self.fightViewheight

	if not self.rewardList or not next(self.rewardList) then
		var_25_0 = self.fightViewheight + 210

		self.fightView:setPositionY(self.bottomList:getPositionY() + 70)
	else
		self.fightView:setPositionY(self.bottomList:getPositionY() + 280)
	end

	self.fightView:setContentSize(cc.size(self.fightView:getContentSize().width, var_25_0))

	self.bossList = activity_manager:getBossFightLevelList(self.activityId)

	for iter_25_0, iter_25_1 in ipairs(self.bossList) do
		self.fightView:pushBackCustomItem((self:createBossSprite(iter_25_0)))
	end
end

function ActivityBossFightBaseLayer:updatePatrolPanel()
	self.patrolListData = activity_manager:getBossFightPatrolList(self.activityId)

	self.patrolView:reloadData()
end

function ActivityBossFightBaseLayer:createBossSprite(arg_27_1)
	local var_27_0 = self.bossList[arg_27_1]
	local var_27_1 = self.fightSpriteTemp:clone()
	local var_27_2 = var_27_1:getChildByName("bossface")
	local var_27_3 = var_27_1:getChildByName("Image_32")
	local var_27_4 = ccui.Helper:seekWidgetByName(var_27_1, "Label_34")
	local var_27_5 = var_27_1:getChildByName("upbtn")

	var_27_1:getChildByName("Label_58"):setString(self.bossList[arg_27_1].name)
	var_27_1:getChildByName("ceshu"):setString(activity_manager:getBossFightSocreByMode(var_27_0.mode))
	var_27_3:setVisible(false)
	var_27_2:loadTextures(CUTE_ROLE_IMAGE_PATH .. model_data[var_27_0.show_boss].cute_role .. ".png", nil, CUTE_ROLE_IMAGE_PATH .. model_data[var_27_0.show_boss].cute_role .. ".png")
	var_27_2:setScale(0.46)
	var_27_1:getChildByName("name_di"):getChildByName("bossname"):setString(model_data[var_27_0.show_boss].name)

	if var_27_0.starttime then
		var_27_3:setVisible(global_get_time_by_date(var_27_0.starttime) - time_check_manager:getCurTime() > 0)
		var_27_4:setString(var_27_0.starttime .. L_MONOPOLY[23])
	end

	var_27_1:getChildByName("change_btn"):addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", self.modetype)
		LayerManager:pushInLayer("AdventureNewDetailLayer", {
			isvisual = 1,
			data = var_27_0,
			score = var_27_0.score
		})
	end)

	for iter_27_0 = 1, 3 do
		local var_27_6 = var_27_1:getChildByName("img_" .. iter_27_0)

		var_27_6:setCascadeOpacityEnabled(false)

		if var_27_6:getChildByName("awarditem") then
			var_27_6:getChildByName("awarditem"):removeFromParent()
		end
	end

	local var_27_7 = 1
	local var_27_8 = 0

	while var_27_0["show_item" .. var_27_7] do
		local var_27_9 = var_27_1:getChildByName("img_" .. var_27_7)
		local var_27_10 = var_27_0["show_item" .. var_27_7]
		local var_27_12 = type(var_27_0["show_item" .. var_27_7]) == "string" and ccui.Button:create("public/box/1.png", "public/box/1.png", nil, var_0_0) or ccui.Button:create("public/box/" .. item_data[var_27_10].equip_quality .. ".png", "public/box/" .. item_data[var_27_10].equip_quality .. ".png", nil, var_0_0)

		var_27_12:setAnchorPoint(cc.p(0.5, 0.5))
		var_27_12:setPosition(cc.p(0, 0))
		var_27_12:setTouchEnabled(false)
		var_27_12:setSwallowTouches(false)
		var_27_12:setPosition(cc.p(var_27_9:getContentSize().width / 2, var_27_9:getContentSize().height / 2 + 4))
		var_27_12:setName("awarditem")
		var_27_9:addChild(var_27_12, 1)

		local var_27_13
		local var_27_14

		if item_data[var_27_10].bag_item_type == kITEM_SCULTURE then
			var_27_14 = AvatarSprite:create(var_27_10)
		elseif item_data[var_27_10].bag_item_type == kITEM_MEDAL then
			var_27_14 = ItemSprite:create_medal_icon(var_27_10)
		elseif item_data[var_27_10].bag_item_type == kITEM_COMPONENT then
			var_27_14 = componentManager:create_component_icon(var_27_10, nil, nil)
		elseif item_data[var_27_10].image_id then
			var_27_13 = "equipment/" .. item_data[var_27_10].image_id .. ".png"
		end

		var_27_14 = var_27_14 or ccui.ImageView:create(var_27_13)

		var_27_14:setPosition(cc.p(var_27_12:getContentSize().width / 2, var_27_12:getContentSize().height / 2))
		var_27_14:setName("ItemSprite")

		local var_27_15 = math.min(var_27_14:getContentSize().width, var_27_14:getContentSize().height)
		local var_27_16 = 80 / var_27_15

		if var_27_10 and item_data[var_27_10] and item_data[var_27_10].bag_item_type == kITEM_SCULTURE then
			var_27_16 = 130 / var_27_15

			var_27_14:setPosition(cc.p(0, 10))
		end

		var_27_14:setScale(var_27_16)
		var_27_12:addChild(var_27_14)

		var_27_7 = var_27_7 + 1
		var_27_8 = var_27_8 + 1
	end

	return var_27_1
end

function ActivityBossFightBaseLayer:updatePatrolSprite(arg_29_1, arg_29_2)
	arg_29_2 = arg_29_2 or self.tempPatrolSprite:clone()

	local var_29_0 = self.patrolListData[arg_29_1]

	arg_29_2:getChildByName("Label_51"):setString(self.patrolListData[arg_29_1].name)

	local var_29_1 = arg_29_2:getChildByName("Button_60")

	var_29_1:setVisible(not var_29_0.time or var_29_0.time <= time_check_manager:getCurTime())

	if not var_29_0.time then
		var_29_1:loadTextures(self.layerName .. "/inif_change.png", nil, self.layerName .. "/inif_change.png", var_0_0)
	else
		var_29_1:loadTextures(self.layerName .. "/btn_award.png", nil, self.layerName .. "/btn_award.png", var_0_0)
	end

	var_29_1:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_29_0.time and var_29_0.time <= time_check_manager:getCurTime() then
			activity_manager:get_activity_bossfight_reward(self.activityId, var_29_0.mode, var_29_0.curChapter)
		else
			local var_30_0 = var_29_0.mode % (self.modetype * 10)

			RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", self.modetype)
			LayerManager:pushInLayer("AdventureNewDetailLayer", {
				isvisual = 1,
				data = self.bossList[var_30_0],
				score = var_29_0.score
			})
		end
	end)

	local var_29_2 = arg_29_2:getChildByName("Label_61")
	local var_29_3 = arg_29_2:getChildByName("Label_62")

	if var_29_0.time and var_29_0.time > time_check_manager:getCurTime() then
		var_29_2:setVisible(true)
		var_29_3:setVisible(true)
		var_29_3:setString(Global_format_time_str(var_29_0.time - time_check_manager:getCurTime()))
	else
		var_29_2:setVisible(false)
		var_29_3:setVisible(false)
	end

	local var_29_4 = arg_29_2:getChildByName("ListView_59")

	var_29_4:removeAllChildren()

	if var_29_0.servants then
		for iter_29_0, iter_29_1 in ipairs(var_29_0.servants) do
			var_29_4:pushBackCustomItem((self:createLockRole(iter_29_1)))
		end

		var_29_4:setItemsMargin(2)
		var_29_4:setContentSize(cc.size(400, 110))
	else
		require("view.Layer.AdventureNewDetailLayer")

		for iter_29_2, iter_29_3 in pairs(AdventureNewDetailLayer:getDropData(var_29_0.dropid).items) do
			local var_29_5 = ItemPurchaseSprite:createPurchaseItem(iter_29_3.itemid)

			var_29_5:setScale(0.6)
			var_29_4:pushBackCustomItem(var_29_5)
		end

		var_29_4:setItemsMargin(-60)
		var_29_4:setContentSize(cc.size(400, 150))
	end

	return arg_29_2
end

function ActivityBossFightBaseLayer:createLockRole(arg_31_1)
	local var_31_0 = ccui.ImageView:create(self.layerName .. "/role_bg.png", var_0_0)
	local var_31_1 = ccui.ImageView:create(ROLE_HEAD_IMAGE_PATH .. model_data[global_get_servant_skin(arg_31_1)].head_image .. ".png")

	var_31_1:setScale(0.45)
	var_31_1:setPosition(cc.p(var_31_0:getContentSize().width / 2, var_31_0:getContentSize().height / 2))
	var_31_0:addChild(var_31_1)

	return var_31_0
end
