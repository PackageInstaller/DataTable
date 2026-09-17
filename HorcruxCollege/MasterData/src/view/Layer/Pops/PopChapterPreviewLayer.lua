local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local array_manager = require("controller.array_manager")
local explore_manager = require("controller.explore_manager")
local var_0_5 = require("controller.formation.formation_manager"):getInstance()
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local chapter_data = require("data.chapter_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local chapter_star_data = require("data.chapter_star_data")
local levelmode_data = require("data.levelmode_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local drop_data = require("data.drop_data")
local city_data = require("data.city_data")
local var_0_16 = config._DEBUG and 0 or 1

PopChaptersPreviewLayer = class("PopChaptersPreviewLayer", function()
	return PopBaseLayer:create()
end)

function PopChaptersPreviewLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = PopChaptersPreviewLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function PopChaptersPreviewLayer.create_talk(arg_4_0, arg_4_1)
	return (PopChaptersPreviewLayer.new())
end

function PopChaptersPreviewLayer:init(arg_5_1)
	self.mode = arg_5_1.mode
	self.chapter = arg_5_1.chapter
	self.msg = arg_5_1

	if level_manager:getChapterStrongholdLv(self.mode, self.chapter) == 1 then
		self:initSmallChapter()
	else
		self:initBigChapter()
	end

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function PopChaptersPreviewLayer:initSmallChapter()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_small_chapter_preview.json" or "Pop_small_chapter_preview.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)
	self.rootLayer:setTouchEnabled(false)
	self:createFullScreenMask(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_8_0:isBright() then
			return
		end

		arg_8_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)
	self:initBasicInfo()
	self:initItemsPanel()
	self:initBtnSureEvent()
	self:initRefightBnt()
	self:initStarsInfo()
	level_manager:getBigBossDropInfo(self.mode, self.chapter, function(arg_10_0)
		if arg_10_0 then
			self.dropdata2 = arg_10_0

			self:initChapterDropData2()
		end
	end)
end

function PopChaptersPreviewLayer:initChapterDropData2()
	self.listviewdrop = ccui.Helper:seekWidgetByName(self.rootpanel, "itemspanel_0")
	self.item_h = ccui.Helper:seekWidgetByName(self.rootLayer, "items_0")

	local function var_11_0(arg_12_0)
		if type(arg_12_0.itemid) == "string" then
			return
		end

		local var_12_0 = item_data[arg_12_0.itemid].bag_item_type

		if item_data[arg_12_0.itemid].bag_item_type == kITEM_HORCRUX then
			local var_12_1 = -1
			local var_12_2 = require("data.item_data")[arg_12_0.itemid].horcruxtype

			for iter_12_0, iter_12_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_12_0.itemid == iter_12_1.item_id then
					var_12_1 = iter_12_0

					break
				end
			end

			if var_12_1 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_12_1,
				itemid = arg_12_0.itemid
			})
		elseif var_12_0 == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				defaultDisplayType = "preview",
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_12_0.itemid].servant
			})
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_12_3 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_12_0.itemid
			})
		end
	end

	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(self.dropdata2) do
		if iter_11_1.itemid and iter_11_1.itemid == 1 then
			iter_11_1.itemid = "gold"
		end

		if iter_11_1.itemid and type(iter_11_1.itemid) == "string" or type(iter_11_1.itemid) == "number" and iter_11_1.itemid > 15 then
			table.insert(var_11_1, iter_11_1)
		end
	end

	for iter_11_2, iter_11_3 in ipairs(var_11_1) do
		if iter_11_3.itemid then
			local var_11_2 = self.item_h:clone()

			var_11_2:setScale(0.65)

			local var_11_3 = ItemSprite:createNewWithItemId(iter_11_3.itemid, iter_11_3.count)

			var_11_3:setPosition(cc.p(var_11_2:getContentSize().width / 2, var_11_2:getContentSize().height / 2))
			var_11_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_11_2:addChild(var_11_3)
			var_11_2:setName("itemshave_" .. iter_11_2)
			var_11_3:setTouchEnabled(false)
			var_11_2:setVisible(true)

			var_11_2:getChildByName("Button_13").itemid = iter_11_3.itemid

			var_11_2:getChildByName("Button_13"):addTouchEventListener(function(arg_13_0, arg_13_1)
				if arg_13_1 ~= ccui.TouchEventType.ended then
					return
				end

				if math.abs(arg_13_0:getTouchBeganPosition().y - arg_13_0:getTouchEndPosition().y) > 50 then
					return
				end

				var_11_0(arg_13_0)
			end)
			var_11_2:setPosition(cc.p(10 + 119.10000000000001 * (iter_11_2 - 1), 6))
			self.listviewdrop:addChild(var_11_2)
		end
	end

	self.listviewdrop:setInnerContainerSize(cc.size(300 + #var_11_1 * 120, 6))
end

function PopChaptersPreviewLayer:initBigChapter()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_big_chapter_preview.json" or "Pop_big_chapter_preview.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2 + 50)
	self.rootLayer:setTouchEnabled(false)
	self:createFullScreenMask(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_15_0:isBright() then
			return
		end

		arg_15_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)

	local var_14_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure")
	local var_14_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_patrol")
	local var_14_2 = ccui.Button:create("public/button/btn_view_details.png", nil, "public/button/btn_view_details.png", var_0_16)

	var_14_2:setPosition(235, 624)
	var_14_2:setScale(0.8)
	self.rootpanel:addChild(var_14_2)
	var_14_2:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		level_manager:getChapterHangupDropInfo(self.mode, self.chapter, function(arg_18_0)
			LayerManager:pushInLayer("DropDetailsLayer", {
				callback = callback,
				category = {
					type = 1
				},
				items_tbl = self:formatChartEndData(arg_18_0),
				words_tbl = {
					type_tbl = {}
				}
			})
		end)
	end)
	self:initBasicInfo()
	self:initItemsPanel()
	self:initBtnSureEvent()
	self:initMapImg()
	self:initBtnPatrolEvent()
	self:initRefightBnt()
	self:initStarsInfo()
	level_manager:getBigBossDropInfo(self.mode, self.chapter, function(arg_19_0)
		if arg_19_0 then
			self.dropdata2 = arg_19_0

			self:initChapterDropData2()
		end
	end)
end

function PopChaptersPreviewLayer:formatChartEndData(arg_20_1)
	if not arg_20_1 then
		return
	end

	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		local var_20_1 = true

		for iter_20_2 = 1, #var_20_0 do
			if iter_20_1.itemid == var_20_0[iter_20_2].itemid then
				var_20_1 = false

				break
			end
		end

		if var_20_1 then
			table.insert(var_20_0, iter_20_1)
		end
	end

	local var_20_2 = {
		attribute = 1,
		content = {}
	}
	local var_20_3 = {
		attribute = 2,
		content = {}
	}
	local var_20_4 = {
		attribute = 3,
		content = {}
	}
	local var_20_5 = {
		attribute = 4,
		content = {}
	}
	local var_20_6 = {}
	local var_20_7 = {}

	for iter_20_3, iter_20_4 in ipairs(var_20_0) do
		if iter_20_4.rare and iter_20_4.rare == 1 then
			table.insert(var_20_2.content, {
				itemid = iter_20_4.itemid
			})
		elseif item_data[iter_20_4.itemid].bag_item_type and item_data[iter_20_4.itemid].bag_item_type == kITEM_MATRIAL then
			table.insert(var_20_4.content, {
				itemid = iter_20_4.itemid
			})
		elseif item_data[iter_20_4.itemid].bag_item_type and item_data[iter_20_4.itemid].bag_item_type == kITEM_COMPONENT then
			table.insert(var_20_5.content, {
				itemid = iter_20_4.itemid
			})
		else
			table.insert(var_20_3.content, {
				itemid = iter_20_4.itemid
			})
		end
	end

	if #var_20_2.content > 0 then
		table.insert(var_20_6, L_FIGHT_RESULT_LEVLE_DROP_DATA.raredata)
		self:sortByQuality(var_20_2.content)
		table.insert(var_20_7, var_20_2)
	end

	if #var_20_3.content > 0 then
		table.insert(var_20_6, L_FIGHT_RESULT_LEVLE_DROP_DATA.commondata)
		self:sortByQuality(var_20_3.content)
		table.insert(var_20_7, var_20_3)
	end

	if #var_20_4.content > 0 then
		table.insert(var_20_6, L_FIGHT_RESULT_LEVLE_DROP_DATA.sciencedata)
		self:sortByQuality(var_20_4.content)
		table.insert(var_20_7, var_20_4)
	end

	if #var_20_5.content > 0 then
		table.insert(var_20_6, L_FIGHT_RESULT_LEVLE_DROP_DATA.componentdata)

		var_20_5.content = self:formatComponentData(var_20_5.content)

		table.insert(var_20_7, var_20_5)
	end

	var_20_7.type_tbl = var_20_6

	return var_20_7
end

function PopChaptersPreviewLayer.formatComponentData(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return
	end

	local var_21_2 = {}
	local var_21_3 = {}
	local var_21_4 = {}
	local var_21_5 = {}

	local function var_21_6(arg_22_0)
		if arg_22_0 and #arg_22_0 > 1 then
			table.sort(arg_22_0, function(arg_23_0, arg_23_1)
				return arg_23_0.itemid < arg_23_1.itemid
			end)
		end
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		local var_21_7 = true

		for iter_21_2, iter_21_3 in ipairs(var_21_2) do
			if item_data[iter_21_1.itemid].equip_quality == iter_21_3 then
				var_21_7 = false

				break
			end
		end

		if var_21_7 then
			table.insert(var_21_2, item_data[iter_21_1.itemid].equip_quality)
		end

		local var_21_8 = true
		local var_21_9 = tostring(iter_21_1.itemid)
		local var_21_10 = string.len(var_21_9)
		local var_21_11 = tonumber(string.sub(var_21_9, var_21_10 - 1, var_21_10))

		for iter_21_4, iter_21_5 in ipairs(var_21_5) do
			if var_21_11 == iter_21_5 then
				var_21_8 = false

				break
			end
		end

		if var_21_8 then
			table.insert(var_21_5, var_21_11)
		end
	end

	table.sort(var_21_2, function(arg_24_0, arg_24_1)
		return arg_24_1 < arg_24_0
	end)
	table.sort(var_21_5, function(arg_25_0, arg_25_1)
		return arg_25_1 < arg_25_0
	end)

	for iter_21_6, iter_21_7 in ipairs(var_21_2) do
		local var_21_12 = {}

		for iter_21_8, iter_21_9 in ipairs(arg_21_1) do
			if item_data[iter_21_9.itemid].equip_quality == iter_21_7 then
				table.insert(var_21_12, iter_21_9)
			end
		end

		if #var_21_12 > 0 then
			local var_21_13 = {}

			for iter_21_10, iter_21_11 in ipairs(var_21_5) do
				local var_21_14 = {}

				for iter_21_12, iter_21_13 in ipairs(var_21_12) do
					local var_21_15 = tostring(iter_21_13.itemid)
					local var_21_16 = string.len(var_21_15)

					if tonumber(string.sub(var_21_15, var_21_16 - 1, var_21_16)) == iter_21_11 then
						table.insert(var_21_14, iter_21_13)
					end
				end

				var_21_6(var_21_14)

				var_21_13[iter_21_10] = var_21_14
			end

			var_21_3[iter_21_6] = var_21_13
		end
	end

	for iter_21_14, iter_21_15 in ipairs(var_21_3) do
		for iter_21_16, iter_21_17 in ipairs(iter_21_15) do
			for iter_21_18, iter_21_19 in ipairs(iter_21_17) do
				table.insert(var_21_4, iter_21_19)
			end
		end
	end

	return var_21_4
end

function PopChaptersPreviewLayer.sortByQuality(arg_26_0, arg_26_1)
	if arg_26_1 and #arg_26_1 > 1 then
		table.sort(arg_26_1, function(arg_27_0, arg_27_1)
			if item_data[arg_27_0.itemid].equip_quality == item_data[arg_27_1.itemid].equip_quality then
				return arg_27_0.itemid < arg_27_1.itemid
			else
				return item_data[arg_27_0.itemid].equip_quality > item_data[arg_27_1.itemid].equip_quality
			end
		end)
	end
end

function PopChaptersPreviewLayer:initBasicInfo()
	ccui.Helper:seekWidgetByName(self.rootLayer, "chaptername"):setString(level_manager:getChapterName(self.mode, self.chapter))
	ccui.Helper:seekWidgetByName(self.rootLayer, "info"):setString(level_manager:getChapterDes(self.mode, self.chapter))
	ccui.Helper:seekWidgetByName(self.rootLayer, "info"):getVirtualRenderer():setMaxLineWidth(450)
	ccui.Helper:seekWidgetByName(self.rootLayer, "power"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "word"):setVisible(false)

	self.nodeServantRank = require("view.Sprite.NodeServantRankEntrance").showInLayer(self.rootpanel, {
		mode = self.mode,
		chapter = self.chapter,
		fightType = require("controller.servant_rank_manager").getInstance().FIGHT_TYPE.PVE
	}, cc.p(470, 35))

	self.nodeServantRank:setVisible(self.mode ~= 1)
end

function PopChaptersPreviewLayer:initItemsPanel()
	local var_29_0 = {}

	while chapter_data[self.mode .. "-" .. self.chapter]["rare_item" .. 1] do
		table.insert(var_29_0, chapter_data[self.mode .. "-" .. self.chapter]["rare_item" .. 1])
	end

	local var_29_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "itemspanel")

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		local var_29_3 = ItemSprite:createNewWithItemId(iter_29_1)

		var_29_3:setScale(0.65)
		var_29_3:setPosition(cc.p(65 + (iter_29_0 - 1) * 120, 85))
		var_29_3:setTouchEnabled(true)
		var_29_2:addChild(var_29_3)
		var_29_3:addSpriteTouchEventListener(function(arg_30_0, arg_30_1)
			if arg_30_1 ~= ccui.TouchEventType.ended then
				return
			end

			if item_data[iter_29_1].bag_item_type == kITEM_HORCRUX then
				return
			end

			if item_data[iter_29_1].bag_item_type == kITEM_HERO then
				return
			end

			if math.abs(arg_30_0:getLocation().x - arg_30_0:getStartLocation().x) >= 50 then
				return
			end

			if not global_basic_scene:getChildByName("OTHER_LAYER") then
				local var_30_0 = PopLayer:Item({
					hideGainButton = true,
					itemid = iter_29_1
				})
			end
		end)
	end

	var_29_2:setInnerContainerSize(cc.size(65 + #var_29_0 * 120, 165))
end

function PopChaptersPreviewLayer:initBtnSureEvent()
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_32_0:isBright() then
			return
		end

		arg_32_0:setBright(false)

		if playermodel.curMode == self.mode and self.chapter == level_manager:getCurChapter(self.mode) then
			audio_manager:playeffectMusicTest("sound/switch_chapter")
			self.hideActions.shrinkVertical(self, function()
				LayerManager:switchShowLayer("FightLayer")
			end)
		end

		level_manager:selectChapter(self.mode, self.chapter, function(arg_34_0)
			if tolua.isnull(self) then
				return
			end

			if arg_34_0 == 1 then
				audio_manager:playeffectMusicTest("sound/switch_chapter")
				self.hideActions.shrinkVertical(self, function()
					LayerManager:switchShowLayer("FightLayer")
				end)
				FightManager.changeChapter()
			else
				self.hideActions.shrinkVertical(self, function()
					LayerManager:removePopLayer(self.__queueindex)
				end)
			end
		end)
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):getChildByName("Label_2"):setFontName(FONT_NAME)
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):getChildByName("Label_2"):setString(L_UNLOCK)

	if level_manager:isChapterPass(self.mode, self.chapter) then
		ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):getChildByName("Label_2"):setString(L_GO)
	end
end

function PopChaptersPreviewLayer:initMapImg()
	ccui.Helper:seekWidgetByName(self.rootLayer, "map"):loadTexture("PreviewMap/" .. level_manager:getCityImg((level_manager:getLevelModeCity(self.mode))) .. ".png")
end

function PopChaptersPreviewLayer:initBtnPatrolEvent()
	local patrol_manager = require("controller.patrol_manager")
	local array_manager = require("controller.array_manager")
	local var_38_2 = patrol_manager:getPatrolInfo(self.mode .. "-" .. self.chapter)

	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_patrol"):addTouchEventListener(function(arg_39_0, arg_39_1)
		if arg_39_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not level_manager:isChapterPass(self.mode, self.chapter) then
			global_ShowBlockWords(L_POPCHAPTERS_PATROL_BTN.UNPASS)

			return
		end

		if not array_manager:getAnyFreeArray() and patrol_manager:getPatrolState(self.mode .. "-" .. self.chapter) == 1 then
			global_ShowBlockWords(L_POPCHAPTERS_PATROL_BTN.Team_Lack)

			return
		end

		if self.patrolLeftTimes <= 0 then
			global_ShowBlockWords(L_POPCHAPTERS_PATROL_BTN.Tims_Lack)

			if self.msg.patrolCallback then
				if patrol_manager:isModeNewPatrol(self.mode, self.chapter) and arg_39_0:getChildByName("newTips") then
					patrol_manager:unMarkChapterNew(self.mode, self.chapter)
					arg_39_0:removeChildByName("newTips")
				end

				self.msg.patrolCallback()
			end

			return
		end

		if patrol_manager:isModeNewPatrol(self.mode, self.chapter) and self.msg.patrolCallback then
			patrol_manager:unMarkChapterNew(self.mode, self.chapter)

			if arg_39_0:getChildByName("newTips") then
				arg_39_0:removeChildByName("newTips")
			end

			self.msg.patrolCallback()
		end

		local var_39_0 = patrol_manager:getPatrolState(self.mode .. "-" .. self.chapter)

		LayerManager:pushInLayer("PatrolPopLayer", {
			inittype = 2,
			mode = self.mode,
			chapter = self.chapter,
			callback = function()
				LayerManager:removePopLayer(self.__queueindex)

				if self.msg.patrolCallback then
					self.msg.patrolCallback()
				end
			end
		})
	end)

	local var_38_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_patrol")

	var_38_3:setVisible(false)
	patrol_manager:getPatrolTime(self.mode, self.chapter, function(arg_41_0)
		if tolua.isnull(self) then
			return
		end

		self.patrolLeftTimes = arg_41_0

		if self.patrolLeftTimes <= 0 then
			var_38_3:loadTextures("ChapterPreviewLayer/patrol_bnt_no_times.png", nil, "ChapterPreviewLayer/patrol_bnt_no_times.png", var_0_16)
		end

		local var_41_0 = cc.Label:createWithTTF(string.format(L_PATROL_CHAPTER_LEFT, self.patrolLeftTimes), FONT_NAME, 18)

		var_41_0:setAnchorPoint(cc.p(1, 0.5))
		var_41_0:setColor(cc.c3b(190, 213, 228))
		var_41_0:setPosition(-20, var_38_3:getContentSize().height / 2)
		var_41_0:setName("t_label")
		var_38_3:addChild(var_41_0)
		var_38_3:setVisible(true)
	end)

	local var_38_4 = patrol_manager:getPatrolState(self.mode .. "-" .. self.chapter)

	if var_38_4 == 3 then
		var_38_3:loadTextures("public/button/public_button_normal_y.png", nil, "public/button/public_button_normal_y.png", var_0_16)

		local var_38_5

		self:scheduleUpdateWithPriorityLua(function(arg_42_0)
			local var_42_0 = patrol_manager:getPatrolInfo(self.mode .. "-" .. self.chapter)

			if var_42_0.time <= 0 then
				if not var_38_5 then
					var_38_5 = true

					var_38_3:setTitleText(L_BUTTON_TEXT.Battle_Array_Btn.GetResults)
					var_38_3:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_16)
				end
			else
				var_38_3:setTitleText((function(arg_43_0)
					return string.format("%02d:%02d", math.floor(arg_43_0 / 60), arg_43_0 % 60)
				end)(var_42_0.time))
			end
		end, 0)
	elseif var_38_4 == 2 then
		var_38_3:setTitleText(L_BUTTON_TEXT.Battle_Array_Btn.GetResults)
		var_38_3:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_16)
	else
		var_38_3:setTitleText("")

		if level_manager:isChapterPass(self.mode, self.chapter) then
			var_38_3:loadTextures("ChapterPreviewLayer/patrol_bnt.png", nil, "ChapterPreviewLayer/patrol_bnt.png", var_0_16)
		else
			var_38_3:loadTextures("ChapterPreviewLayer/patrol_bnt_no.png", nil, "ChapterPreviewLayer/patrol_bnt_no.png", var_0_16)
		end

		if patrol_manager:isModeNewPatrol(self.mode, self.chapter) then
			local var_38_6 = ccui.ImageView:create("LevelMap/img_tagnew.png", var_0_16)

			var_38_6:setPosition(var_38_3:getContentSize().width - 20, var_38_3:getContentSize().height - 20)
			var_38_6:setName("newTips")
			var_38_3:addChild(var_38_6)
		end

		local var_38_10 = cc.Label:createWithTTF((chapter_data[self.mode .. "-" .. self.chapter].patrol_time or 1) >= 1 and string.format(L_TIME_SINGLE.Hour, chapter_data[self.mode .. "-" .. self.chapter].patrol_time or 1) or string.format(L_TIME_SINGLE.Minute, (chapter_data[self.mode .. "-" .. self.chapter].patrol_time or 1) * 60), FONT_NAME, 16)

		var_38_10:setColor(cc.c3b(255, 180, 0))
		var_38_10:setAnchorPoint(cc.p(0.5, 0))
		var_38_10:setPosition(var_38_3:getContentSize().width / 2, var_38_3:getContentSize().height - 8)
		var_38_10:setName("m_label")
		var_38_3:addChild(var_38_10)
	end
end

function PopChaptersPreviewLayer:initRefightBnt()
	local var_44_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_fight_again")

	if not level_manager:isChapterPass(self.mode, self.chapter) then
		var_44_0:setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):setPositionX(self.rootpanel:getContentSize().width / 2)
	end

	var_44_0:addTouchEventListener(function(arg_45_0, arg_45_1)
		if arg_45_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not FightManager.isNormalFight() then
			return
		end

		if FightManager.isBigBossFight() then
			return
		end

		local var_45_0 = self.mode
		local var_45_1 = self.chapter
		local var_45_2 = false
		local var_45_3 = chapter_data[self.mode .. "-" .. self.chapter].level_num

		var_45_3 = chapter_data[self.mode .. "-" .. self.chapter].level_num == 0 and 1 or var_45_3

		LayerManager:pushInLayer("LevelDetailLayer", {
			fight_type = "REFIGHT",
			mode = self.mode,
			level = self.chapter .. "-" .. var_45_3,
			callback = function()
				if var_45_2 then
					return
				end

				var_45_2 = true

				require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationMainLayer", {
					repeatChallenge = true,
					configtype = CONFIG_TYPE_REFIGHT,
					configcallback = function(arg_47_0)
						level_manager:selectChapter(self.mode, self.chapter, function(arg_48_0)
							if tolua.isnull(self) then
								return
							end

							if arg_48_0 == 1 or arg_48_0 == 3 then
								require("controller.autopop_manager"):pauseAchievementPop()
								LayerManager:switchShowLayer("FightLayer")
								FightManager.startRefightBigBoss()
								require("controller.parse_server"):onFightBigBoss(var_45_0, var_45_1, arg_47_0)
							else
								self.hideActions.shrinkVertical(self, function()
									LayerManager:removePopLayer(self.__queueindex)
								end)
							end

							var_45_2 = false
						end)
					end
				})
			end
		})
	end)
end

function PopChaptersPreviewLayer:initStarsInfo()
	local var_50_0 = level_manager:getChapterStarsState(self.mode, self.chapter)

	for iter_50_0 = 1, LEVEL_STARS_NUM do
		local var_50_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel" .. iter_50_0)
		local var_50_2 = var_50_1:getChildByName("star")

		var_50_2:setScale(1.25)

		local var_50_3 = var_50_1:getChildByName("label1")
		local var_50_4 = var_50_1:getChildByName("label2")
		local var_50_5 = var_50_1:getChildByName("icon")

		var_50_3:setString(chapter_star_data[self.mode .. "-" .. self.chapter]["star" .. iter_50_0 .. "_des"] or "")

		if var_50_0[iter_50_0] then
			var_50_5:setVisible(false)
			var_50_2:loadTexture("LevelMap/star_icon.png", var_0_16)
			var_50_4:setVisible(false)
		else
			var_50_5:setVisible(true)
			var_50_2:loadTexture("LevelMap/star_gray.png", var_0_16)
			var_50_4:setVisible(true)
			var_50_4:setColor(cc.c3b(190, 213, 228))
		end
	end
end

PopCityUnlockLayer = class("PopCityUnlockLayer", function()
	return PopBaseLayer:create()
end)

function PopCityUnlockLayer.create(arg_52_0, arg_52_1)
	local var_52_0 = PopCityUnlockLayer.new()

	var_52_0:init(arg_52_1)

	return var_52_0
end

function PopCityUnlockLayer:init(arg_53_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_unlock_city.json" or "Pop_unlock_city.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)
	self.rootLayer:setTouchEnabled(false)
	self:createFullScreenMask(function(arg_54_0, arg_54_1)
		if arg_54_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_54_0:isBright() then
			return
		end

		arg_54_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)

	self.city = arg_53_1.city
	self.successcallback = arg_53_1.successcallback

	self:initCityInfo()
	self:initBtnSure()

	self.dropdata = self:getDropData(self.city)

	self:initChapterDropData(nextmode)
end

function PopCityUnlockLayer.getDropData(arg_56_0, arg_56_1)
	if not arg_56_1 or not city_data[arg_56_1] then
		return {}
	end

	local var_56_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}

	if city_data[arg_56_1]["difficulty" .. 1] then
		while chapter_data[city_data[arg_56_1]["difficulty" .. 1] .. "-" .. 1] do
			local var_56_1 = drop_data[chapter_data[city_data[arg_56_1]["difficulty" .. 1] .. "-" .. 1].bigbossdrop] or drop_data[chapter_data[city_data[arg_56_1]["difficulty" .. 1] .. "-" .. 1].equip_drop] or {}

			if var_56_1.gold then
				var_56_0.gold = var_56_0.gold + var_56_1.gold
			end

			if var_56_1.diamond then
				var_56_0.diamond = var_56_0.diamond + var_56_1.diamond
			end

			local var_56_2 = 1

			while var_56_1["drop_id" .. var_56_2] do
				var_56_0.items["" .. var_56_1["drop_id" .. var_56_2]] = var_56_0.items["" .. var_56_1["drop_id" .. var_56_2]] or true
				var_56_2 = var_56_2 + 1
			end

			local var_56_3 = 1

			while var_56_1["dropmodel_id" .. var_56_3] do
				if drop_data[var_56_1["dropmodel_id" .. var_56_3]].gold then
					var_56_0.gold = var_56_0.gold + drop_data[var_56_1["dropmodel_id" .. var_56_3]].gold
				end

				if drop_data[var_56_1["dropmodel_id" .. var_56_3]].diamond then
					var_56_0.diamond = var_56_0.diamond + drop_data[var_56_1["dropmodel_id" .. var_56_3]].diamond
				end

				local var_56_4 = 1

				while drop_data[var_56_1["dropmodel_id" .. var_56_3]]["drop_id" .. var_56_4] do
					var_56_0.items["" .. drop_data[var_56_1["dropmodel_id" .. var_56_3]]["drop_id" .. var_56_4]] = var_56_0.items["" .. drop_data[var_56_1["dropmodel_id" .. var_56_3]]["drop_id" .. var_56_4]] or true
					var_56_4 = var_56_4 + 1
				end

				local var_56_5 = 1

				while drop_data[var_56_1["dropmodel_id" .. var_56_3]]["rd_drop_id" .. var_56_5] do
					var_56_0.items["" .. drop_data[var_56_1["dropmodel_id" .. var_56_3]]["rd_drop_id" .. var_56_5]] = var_56_0.items["" .. drop_data[var_56_1["dropmodel_id" .. var_56_3]]["rd_drop_id" .. var_56_5]] or true
					var_56_5 = var_56_5 + 1
				end

				var_56_3 = var_56_3 + 1
			end

			local var_56_6 = 1

			while var_56_1["rd_drop_id" .. var_56_6] do
				var_56_0.items["" .. var_56_1["rd_drop_id" .. var_56_6]] = var_56_0.items["" .. var_56_1["rd_drop_id" .. var_56_6]] or true
				var_56_6 = var_56_6 + 1
			end

			local var_56_7 = 1

			while var_56_1["rd_dropmodel_id" .. var_56_7] do
				if drop_data[var_56_1["rd_dropmodel_id" .. var_56_7]].gold then
					var_56_0.gold = var_56_0.gold + drop_data[var_56_1["rd_dropmodel_id" .. var_56_7]].gold
				end

				if drop_data[var_56_1["rd_dropmodel_id" .. var_56_7]].diamond then
					var_56_0.diamond = var_56_0.diamond + drop_data[var_56_1["rd_dropmodel_id" .. var_56_7]].diamond
				end

				local var_56_8 = 1

				while drop_data[var_56_1["rd_dropmodel_id" .. var_56_7]]["drop_id" .. var_56_8] do
					var_56_0.items["" .. drop_data[var_56_1["rd_dropmodel_id" .. var_56_7]]["drop_id" .. var_56_8]] = var_56_0.items["" .. drop_data[var_56_1["rd_dropmodel_id" .. var_56_7]]["drop_id" .. var_56_8]] or true
					var_56_8 = var_56_8 + 1
				end

				local var_56_9 = 1

				while drop_data[var_56_1["rd_dropmodel_id" .. var_56_7]]["rd_drop_id" .. var_56_9] do
					var_56_0.items["" .. drop_data[var_56_1["rd_dropmodel_id" .. var_56_7]]["rd_drop_id" .. var_56_9]] = var_56_0.items["" .. drop_data[var_56_1["rd_dropmodel_id" .. var_56_7]]["rd_drop_id" .. var_56_9]] or true
					var_56_9 = var_56_9 + 1
				end

				var_56_7 = var_56_7 + 1
			end
		end
	end

	local var_56_11 = {}

	if next(var_56_0.items) then
		for iter_56_0, iter_56_1 in pairs(var_56_0.items) do
			if tonumber(iter_56_0) and item_data[tonumber(iter_56_0)].equip_quality and item_data[tonumber(iter_56_0)].equip_quality >= 3 then
				table.insert(var_56_11, {
					itemid = tonumber(iter_56_0)
				})
			end
		end
	end

	table.sort(var_56_11, function(arg_57_0, arg_57_1)
		if type(arg_57_0.itemid) == "number" and type(arg_57_1.itemid) == "number" and item_data[arg_57_0.itemid].equip_quality and item_data[arg_57_1.itemid].equip_quality then
			return item_data[arg_57_0.itemid].equip_quality > item_data[arg_57_1.itemid].equip_quality
		end
	end)

	return var_56_11
end

function PopCityUnlockLayer:initCityInfo()
	ccui.Helper:seekWidgetByName(self.rootLayer, "cityname"):setString(level_manager:getCityName(self.city))
	ccui.Helper:seekWidgetByName(self.rootLayer, "info"):setString(level_manager:getCityDes(self.city))
	ccui.Helper:seekWidgetByName(self.rootLayer, "info"):getVirtualRenderer():setMaxLineWidth(450)
	ccui.Helper:seekWidgetByName(self.rootLayer, "recommend"):setString(global_trans_bitmapnumber(level_manager:getCityRecommendPower(self.city)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "max"):setString(global_trans_bitmapnumber(fight_capacity_manager:getArrayFightCapacity(array_manager:getBattleArrayData(playermodel.curArray, nil, nil, nil, self.mode))))
	ccui.Helper:seekWidgetByName(self.rootLayer, "map"):loadTexture("PreviewMap/" .. level_manager:getCityImg(self.city) .. ".png")
end

function PopCityUnlockLayer:initBtnSure()
	local function var_59_0(arg_60_0)
		if tolua.isnull(self) then
			return
		end

		print("unlock City Result: ", arg_60_0)

		if arg_60_0 == 1 and self.successcallback then
			self.successcallback()
		end

		if arg_60_0 == 2 then
			playermodel.citystat[self.city] = true

			if self.successcallback then
				self.successcallback()
			end
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):addTouchEventListener(function(arg_62_0, arg_62_1)
		if arg_62_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_62_0:isBright() then
			return
		end

		arg_62_0:setBright(false)
		level_manager:unlockCity(self.city, var_59_0)
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):getChildByName("Label_13"):setString(L_UNLOCK)

	if RoleDefault:getInstance():getBoolForKey("MainLineAutoFight", false) then
		global_count_down_layer(4, function()
			if not ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):isBright() then
				return
			end

			ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):setBright(false)
			level_manager:unlockCity(self.city, var_59_0)
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("main_line_auto_fight")))
			RoleDefault:getInstance():setBoolForKey("MainLineAutoFight", false)
		end)
	end
end

function PopCityUnlockLayer:initChapterDropData()
	self.tblview = ccui.Helper:seekWidgetByName(self.rootLayer, "tablelayer")
	self.items_w = ccui.Helper:seekWidgetByName(self.rootLayer, "items")

	if self.rootpanel:getChildByName("tabeview_drop") then
		self.rootpanel:getChildByName("tabeview_drop"):removeFromParent()
	end

	local var_65_0 = cc.TableView:create(cc.size(self.tblview:getContentSize().width, self.tblview:getContentSize().height))

	var_65_0:setPosition(0, 0)
	var_65_0:setDelegate()
	var_65_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_65_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_65_0:setName("tabeview_drop")
	self.tblview:addChild(var_65_0, 99)

	self.tabeview_drop = var_65_0

	local var_65_1 = {
		cc.p(26, 0),
		cc.p(148, 0),
		cc.p(270, 0),
		(cc.p(392, 0))
	}

	local function var_65_2()
		local var_66_0 = self.items_w:clone()

		var_66_0:setScale(0.64)
		var_66_0:setTouchEnabled(false)

		return var_66_0
	end

	local function var_65_3()
		local var_67_0 = math.ceil(#self.dropdata / 4)

		if var_67_0 < 3 then
			var_67_0 = 3
		end

		return var_67_0
	end

	local function var_65_4(arg_68_0)
		if type(arg_68_0.itemid) == "string" then
			return
		end

		local var_68_0 = item_data[arg_68_0.itemid].bag_item_type

		if item_data[arg_68_0.itemid].bag_item_type == kITEM_HORCRUX then
			local var_68_1 = -1
			local var_68_2 = require("data.item_data")[arg_68_0.itemid].horcruxtype

			for iter_68_0, iter_68_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_68_0.itemid == iter_68_1.item_id then
					var_68_1 = iter_68_0

					break
				end
			end

			if var_68_1 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_68_1,
				itemid = arg_68_0.itemid
			})
		elseif var_68_0 == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				defaultDisplayType = "preview",
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_68_0.itemid].servant
			})
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_68_3 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_68_0.itemid
			})
		end
	end

	local function var_65_5(arg_69_0, arg_69_1, arg_69_2)
		if not arg_69_0 or not arg_69_1 then
			return
		end

		arg_69_0:setName("sp_" .. arg_69_2)
		arg_69_0:setPosition(var_65_1[arg_69_2])

		arg_69_0:getChildByName("Button_13").selectindex = arg_69_1

		arg_69_0:getChildByName("Button_13"):setSwallowTouches(false)

		if arg_69_0:getChildByName("awarditem") then
			arg_69_0:getChildByName("awarditem"):removeFromParent()
		end

		if self.dropdata[arg_69_1] then
			local var_69_0 = self.dropdata[arg_69_1].itemid or nil

			if var_69_0 then
				local var_69_1 = ItemSprite:createNewWithItemId(var_69_0)

				var_69_1:setName("awarditem")
				var_69_1:setPosition(cc.p(arg_69_0:getContentSize().width / 2, arg_69_0:getContentSize().height / 2))
				var_69_1:setAnchorPoint(cc.p(0.5, 0.5))
				arg_69_0:addChild(var_69_1)
				var_69_1:setTouchEnabled(false)
				arg_69_0:setVisible(true)

				arg_69_0:getChildByName("Button_13").itemid = var_69_0

				arg_69_0:getChildByName("Button_13"):addTouchEventListener(function(arg_70_0, arg_70_1)
					if arg_70_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_70_0:getTouchBeganPosition().y - arg_70_0:getTouchEndPosition().y) > 50 then
						return
					end

					var_65_4(arg_70_0)
				end)

				goto label_69_0
			end
		end

		arg_69_0:setVisible(false)

		::label_69_0::
	end

	;(function()
		self.tabeview_drop:registerScriptHandler(function(arg_73_0, arg_73_1)
			return 500, 160
		end, cc.TABLECELL_SIZE_FOR_INDEX)
		self.tabeview_drop:registerScriptHandler(function(arg_72_0, arg_72_1)
			local var_72_0 = arg_72_0:dequeueCell()

			if not var_72_0 then
				var_72_0 = cc.TableViewCell:create()

				for iter_72_0 = 1, 4 do
					local var_72_1 = var_65_2()

					var_65_5(var_72_1, 4 * arg_72_1 + iter_72_0, iter_72_0)
					var_72_0:addChild(var_72_1)
				end
			else
				local var_72_2 = 4

				for iter_72_1 = 1, 4 do
					var_65_5(var_72_0:getChildByName("sp_" .. iter_72_1), var_72_2 * arg_72_1 + iter_72_1, iter_72_1)
				end
			end

			return var_72_0
		end, cc.TABLECELL_SIZE_AT_INDEX)
		self.tabeview_drop:registerScriptHandler(function(arg_74_0, arg_74_1)
			return var_65_3()
		end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
		self.tabeview_drop:reloadData()
	end)()
end

PopExplorePreviewLayer = class("PopExplorePreviewLayer", function()
	return PopBaseLayer:create()
end)

function PopExplorePreviewLayer.create(arg_76_0, arg_76_1)
	local var_76_0 = PopExplorePreviewLayer.new()

	var_76_0:init(arg_76_1)

	return var_76_0
end

function PopExplorePreviewLayer:init(arg_77_1)
	self.frameType = arg_77_1.frameType
	self.aimid = arg_77_1.aimid
	self.msg = arg_77_1

	self:loadBasicUIAssets()
	self:initBigChapter()

	if self.msg.firstPassDropid then
		self:initFirstPassPanel()
	end
end

local var_0_18 = config._DEBUG and {
	"LevelMap/btn_easy.png",
	"LevelMap/btn_hard.png",
	"LevelMap/btn_hell.png",
	"LevelMap/btn_return.png",
	"LevelMap/city_frame_new.png",
	"LevelMap/city_frame_normal.png",
	"LevelMap/city_frame_selected.png",
	"LevelMap/city_region.png",
	"LevelMap/cover_easy.png",
	"LevelMap/cover_hard.png",
	"LevelMap/cover_hell.png",
	"LevelMap/cover_locked.png",
	"LevelMap/frame_drop.png",
	"LevelMap/img_city_panelframe.png",
	"LevelMap/img_tagnew.png",
	"LevelMap/img_unknow_drop.png",
	"LevelMap/img_word.png",
	"LevelMap/level1_easy.png",
	"LevelMap/level1_hard.png",
	"LevelMap/level1_hell.png",
	"LevelMap/level1_lock.png",
	"LevelMap/level2_easy.png",
	"LevelMap/level2_hard.png",
	"LevelMap/level2_hell.png",
	"LevelMap/level2_lock.png"
} or {}

function PopExplorePreviewLayer.loadBasicUIAssets(arg_78_0)
	if config._DEBUG then
		for iter_78_0, iter_78_1 in ipairs(var_0_18) do
			cc.Director:getInstance():getTextureCache():addImage(iter_78_1)
		end
	end
end

function PopExplorePreviewLayer:initBigChapter()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(self.msg.firstPassDropid and (config._DEBUG and "Pop_explore_preview_firstpass.json" or "Pop_explore_preview_firstpass.ExportJson") or config._DEBUG and "Pop_explore_preview.json" or "Pop_explore_preview.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)
	self.rootpanel:getChildByName("Image_title"):loadTexture("ChapterPreviewLayer/explore_popbg_title.png", var_0_16)
	self.rootLayer:setTouchEnabled(false)
	self:createFullScreenMask(function(arg_80_0, arg_80_1)
		if arg_80_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_80_0:isBright() then
			return
		end

		if self.msg.cancelCallback then
			self.msg.cancelCallback()
		end

		arg_80_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)
	self:initBasicInfo()
	self:initItemsPanel()
	self:initBtnSureEvent()
	self:initMapImg()
	self:updateFrame()
end

function PopExplorePreviewLayer:updateFrame()
	if self.msg.frameType then
		if self.msg.frameType == "fire" then
			self.rootpanel:loadTexture("ChapterPreviewLayer/fire.png", var_0_16)
		elseif self.msg.frameType == "bianhua" then
			self.rootpanel:loadTexture("ChapterPreviewLayer/bianhua.png", var_0_16)
		elseif self.msg.frameType == "yellow" then
			self.rootpanel:loadTexture("ChapterPreviewLayer/yellow.png", var_0_16)
		end

		self.rootpanel:getChildByName("Image_title"):setVisible(false)

		local var_82_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "chaptername")

		var_82_0:setColor(cc.c3b(255, 255, 255))
		var_82_0:setPositionY(var_82_0:getPositionY() + 50)
		ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):loadTextures("public/button/public_button_normal_y.png", nil, "public/button/public_button_normal_y.png", var_0_16)
	end
end

function PopExplorePreviewLayer:initBasicInfo()
	local explore_manager = require("controller.explore_manager")
	local var_83_1 = explore_manager:getExploreAimInfo(self.aimid)

	ccui.Helper:seekWidgetByName(self.rootLayer, "chaptername"):setString(var_83_1.name or "")
	ccui.Helper:seekWidgetByName(self.rootLayer, "chaptername"):setAnchorPoint(cc.p(0, 0.5))
	ccui.Helper:seekWidgetByName(self.rootLayer, "chaptername"):setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "chaptername"):getPositionX() - 56)
	ccui.Helper:seekWidgetByName(self.rootLayer, "info"):getVirtualRenderer():setMaxLineWidth(450)
	ccui.Helper:seekWidgetByName(self.rootLayer, "info"):setString(explore_manager:getExploreAimStr(self.aimid))
	ccui.Helper:seekWidgetByName(self.rootLayer, "word"):loadTexture("ChapterPreviewLayer/recommend_word_explore.png", var_0_16)

	if var_83_1.need_fight_power then
		ccui.Helper:seekWidgetByName(self.rootLayer, "power"):setString(global_trans_bitmapnumber(var_83_1.need_fight_power or 0))
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "word"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "power"):setVisible(false)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_patrol"):setVisible(false)

	if var_83_1.is_horcrux_tips then
		local var_83_3 = ccui.Button:create("ChapterPreviewLayer/horcrux_tips.png", nil, "ChapterPreviewLayer/horcrux_tips.png", var_0_16)

		var_83_3.act_type = "up"

		var_83_3:setPosition(480, 296)
		self.rootpanel:addChild(var_83_3)

		local var_83_4 = ccui.ImageView:create("ChapterPreviewLayer/tips_panel.png", var_0_16)

		var_83_4:setTouchEnabled(true)
		var_83_4:setAnchorPoint(cc.p(1, 1))
		var_83_4:setScale(0.01)
		var_83_4:setOpacity(0)
		var_83_4:setPosition(var_83_3:getContentSize().width, var_83_3:getContentSize().height)
		var_83_3:addChild(var_83_4, -1)
		var_83_3:addTouchEventListener(function(arg_84_0, arg_84_1)
			if arg_84_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_84_0.act_type == "up" then
				arg_84_0.act_type = "running"

				var_83_4:runAction(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.4, 1), cc.FadeIn:create(0.4)), cc.CallFunc:create(function()
					arg_84_0.act_type = "down"
				end)))
			elseif arg_84_0.act_type == "down" then
				arg_84_0.act_type = "running"

				var_83_4:runAction(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.4, 0.01), cc.FadeOut:create(0.4)), cc.CallFunc:create(function()
					arg_84_0.act_type = "up"
				end)))
			end
		end)
	end
end

function PopExplorePreviewLayer:initItemsPanel()
	local var_87_0 = require("controller.explore_manager"):getExploreAimInfo(self.aimid)

	if not var_87_0.aim_finish_dropid then
		return
	end

	local var_87_1 = require("controller.drop_manager"):getAllDrops(var_87_0.aim_finish_dropid or "1")
	local var_87_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "itemspanel")

	for iter_87_0, iter_87_1 in ipairs(var_87_1) do
		local var_87_3 = iter_87_1.dropid
		local var_87_4 = ItemSprite:createNewWithItemId(iter_87_1.dropid)

		var_87_4:setScale(0.65)
		var_87_4:setPosition(cc.p(65 + (iter_87_0 - 1) * 120, 85))
		var_87_4:setTouchEnabled(true)
		var_87_2:addChild(var_87_4)
		var_87_4:addSpriteTouchEventListener(function(arg_88_0, arg_88_1)
			if arg_88_1 ~= ccui.TouchEventType.ended then
				return
			end

			if item_data[var_87_3].bag_item_type == kITEM_HORCRUX then
				return
			end

			if item_data[var_87_3].bag_item_type == kITEM_HERO then
				return
			end

			if math.abs(arg_88_0:getLocation().x - arg_88_0:getStartLocation().x) >= 50 then
				return
			end

			if not global_basic_scene:getChildByName("OTHER_LAYER") then
				local var_88_0 = PopLayer:Item({
					hideGainButton = true,
					itemid = var_87_3
				})
			end
		end)
	end

	var_87_2:setInnerContainerSize(cc.size(65 + #var_87_1 * 120, 165))
end

function PopExplorePreviewLayer:initBtnSureEvent()
	local var_89_0 = {}

	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):addTouchEventListener(function(arg_90_0, arg_90_1)
		if arg_90_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_90_0:isBright() then
			return
		end

		arg_90_0:setBright(false)
		self:setVisible(false)

		local var_90_0 = explore_manager:getExploreAimInfo(self.aimid)
		local var_90_1 = not not (var_90_0.hp_inherit and var_90_0.hp_inherit == 1)

		local function var_90_2(arg_91_0)
			if self.msg.sureCallback then
				if type(arg_91_0) == "number" then
					explore_manager.arrayIndex = arg_91_0

					local var_91_0

					if var_90_1 then
						var_91_0 = array_manager:getBattleArrayDataHpInherit(arg_91_0) or array_manager:getBattleArrayData(arg_91_0)
					end

					local var_91_1 = {}

					for iter_91_0 = 1, FORMATION_SHOW_GIRL_NUM do
						if var_91_0[iter_91_0].fight_girl then
							var_91_1[#var_91_1 + 1] = var_91_0[iter_91_0]
						end
					end

					if var_89_0[self.msg.aimid] then
						local var_91_2 = true

						for iter_91_1, iter_91_2 in pairs(var_91_1) do
							if global_get_model_attr(servant_data[iter_91_2.fight_girl].modelid) ~= var_89_0[self.msg.aimid] then
								var_91_2 = false

								global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. L_SORT_ATTR[ATTR_INDEX[var_89_0[self.msg.aimid]]] .. L_SPECIAL_JUMPTOWERLAYER.other2)

								break
							end
						end

						if var_91_2 then
							self.msg.sureCallback(var_91_1)
						end
					else
						self.msg.sureCallback(var_91_1)
					end

					self.hideActions.shrinkVertical(self, function()
						LayerManager:removePopLayer(self.__queueindex)
					end)
				elseif type(arg_91_0) == "table" then
					print(dump(arg_91_0))

					local var_91_3 = {}

					for iter_91_3 = 1, FORMATION_SHOW_GIRL_NUM do
						if arg_91_0[iter_91_3].npcid then
							local var_91_4 = {
								npcid = arg_91_0[iter_91_3].npcid
							}

							var_91_4.fight_girl = arg_91_0[iter_91_3].girlInfo.servantId or arg_91_0[iter_91_3].girlInfo.npcsoulid
							var_91_4.pos = iter_91_3
							var_91_4.isMainCharacter = not not arg_91_0[iter_91_3].isMainCharacter
							var_91_3[#var_91_3 + 1] = var_91_4
						elseif arg_91_0[iter_91_3].girlInfo then
							local var_91_5 = {
								fight_girl = arg_91_0[iter_91_3].girlInfo.servantId
							}

							if arg_91_0[iter_91_3].horcruxInfo then
								var_91_5.assist_girl = arg_91_0[iter_91_3].horcruxInfo.entityid or nil
							end

							var_91_5.pos = iter_91_3
							var_91_3[#var_91_3 + 1] = var_91_5
						end
					end

					self.msg.sureCallback(var_91_3)
					self.hideActions.shrinkVertical(self, function()
						LayerManager:removePopLayer(self.__queueindex)
					end)
				end
			end
		end

		local function var_90_3()
			arg_90_0:setBright(true)
			self:setVisible(true)
		end

		if not not (var_90_0.hp_inherit and var_90_0.hp_inherit == 1) then
			playermodel:initExploreArraysHpInherit()
		end

		local var_90_5, var_90_6 = explore_manager:getCurrentFixArray(self.aimid)
		local var_90_7 = explore_manager:isFixArray(self.aimid)
		local var_90_8 = {
			fix_array = var_90_7 and var_90_6 or nil
		}

		var_90_8.initindex = RoleDefault:getInstance():getIntegerForKey("explore_array_id", 1)

		if var_90_1 then
			var_90_8.configtype = CONFIG_TYPE_EXPLORE_HP_INHERIT or CONFIG_TYPE_EXPLORE
		end

		var_90_8.fighttype = self.msg.fighttype
		var_90_8.configcallback = var_90_2
		var_90_8.exitcallback = var_90_3
		var_90_8.is_hp_inherit = var_90_1

		if var_90_0.is_hide_array and not var_90_1 then
			self.msg.sureCallback()
			self.hideActions.shrinkVertical(self, function()
				LayerManager:removePopLayer(self.__queueindex)
			end)
		elseif var_90_7 then
			print("ssssssssssssss")

			local var_90_9 = {
				fix_array = var_90_7 and var_90_6 or nil
			}

			var_90_9.initindex = RoleDefault:getInstance():getIntegerForKey("explore_array_id", 1)

			if var_90_1 then
				var_90_9.configtype = CONFIG_TYPE_EXPLORE_HP_INHERIT or CONFIG_TYPE_EXPLORE
			end

			var_90_9.fighttype = self.msg.fighttype
			var_90_9.configCallback = var_90_2
			var_90_9.exitcallback = var_90_3
			var_90_9.is_hp_inherit = var_90_1

			var_0_5:pushFormationLayer("FormationSpecialExploreLayer", var_90_9)
		else
			local var_90_10 = {
				fix_array = var_90_7 and var_90_6 or nil
			}

			var_90_10.initindex = RoleDefault:getInstance():getIntegerForKey("explore_array_id", 1)

			if var_90_1 then
				var_90_10.configtype = CONFIG_TYPE_EXPLORE_HP_INHERIT or CONFIG_TYPE_EXPLORE
			end

			var_90_10.fighttype = self.msg.fighttype
			var_90_10.configCallback = var_90_2
			var_90_10.customConfigexitCallback = var_90_3
			var_90_10.is_hp_inherit = var_90_1

			var_0_5:pushFormationLayer("FormationExploreLayer", var_90_10)
		end
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):setPositionX(280)
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):getChildByName("Label_2"):setString(L_GO)
end

function PopExplorePreviewLayer:initMapImg()
	ccui.Helper:seekWidgetByName(self.rootLayer, "map"):loadTexture("PreviewMap/" .. (require("controller.explore_manager"):getExploreAimInfo(self.aimid).preview_img or "country2") .. ".png")
end

function PopExplorePreviewLayer:initFirstPassPanel()
	self.first_pass_pannel = ccui.Helper:seekWidgetByName(self.rootLayer, "first_pass_pannel")

	local var_98_0 = require("controller.drop_manager"):getAllDrops(self.msg.firstPassDropid)

	for iter_98_0, iter_98_1 in ipairs(var_98_0) do
		local var_98_1 = iter_98_1.dropid
		local var_98_2 = ItemSprite:createNewWithItemId(iter_98_1.dropid, iter_98_1.dropNum)

		var_98_2:setScale(0.4)
		var_98_2:setPosition(cc.p(45 + (iter_98_0 - 1) * 80, 50))
		var_98_2:setTouchEnabled(true)
		self.first_pass_pannel:addChild(var_98_2)
		var_98_2:addSpriteTouchEventListener(function(arg_99_0, arg_99_1)
			if arg_99_1 ~= ccui.TouchEventType.ended then
				return
			end

			if item_data[var_98_1].bag_item_type == kITEM_HORCRUX then
				return
			end

			if item_data[var_98_1].bag_item_type == kITEM_HERO then
				return
			end

			if math.abs(arg_99_0:getLocation().x - arg_99_0:getStartLocation().x) >= 50 then
				return
			end

			if not global_basic_scene:getChildByName("OTHER_LAYER") then
				local var_99_0 = PopLayer:Item({
					hideGainButton = true,
					itemid = var_98_1
				})
			end
		end)
	end

	self.first_pass_pannel:setInnerContainerSize(cc.size(45 + #var_98_0 * 80, 96))
end

PopTalkPreviewLayer = class("PopTalkPreviewLayer", function(arg_100_0)
	return PopChaptersPreviewLayer:create_talk(arg_100_0)
end)

function PopTalkPreviewLayer.create(arg_101_0, arg_101_1)
	local var_101_0 = PopTalkPreviewLayer.new(arg_101_1)

	var_101_0:init(arg_101_1)

	return var_101_0
end

function PopTalkPreviewLayer:initSmallChapter()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_talk_chapter_preview.json" or "Pop_talk_chapter_preview.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)
	self.rootLayer:setTouchEnabled(false)
	self:createFullScreenMask(function(arg_103_0, arg_103_1)
		if arg_103_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_103_0:isBright() then
			return
		end

		arg_103_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)
	self:initBasicInfo()
	self:initItemsPanel()
	self:initBtnSureEvent()
end

PopActivityPreviewLayer = class("PopActivityPreviewLayer", function(arg_105_0)
	return PopChaptersPreviewLayer:create_talk(arg_105_0)
end)

function PopActivityPreviewLayer.create(arg_106_0, arg_106_1)
	local var_106_0 = PopActivityPreviewLayer.new(arg_106_1)

	var_106_0:init(arg_106_1)

	return var_106_0
end

function PopActivityPreviewLayer:initBtnSureEvent()
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):addTouchEventListener(function(arg_108_0, arg_108_1)
		if arg_108_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_108_0 = self.mode
		local var_108_1 = self.chapter
		local var_108_2, var_108_3 = level_manager:isModeValid(self.mode)

		if not var_108_2 then
			audio_manager:playeffectMusicTest("sound/invalid")
			global_ShowBlockWords(level_manager:getModeUnlockMsg(var_108_0, var_108_3))

			return
		end

		local function var_108_4(arg_109_0)
			if tolua.isnull(self) then
				return
			end

			if arg_109_0 == 1 then
				AnalyticManager.click_bosstower()
				LayerManager:switchShowLayer("FightLayer", {
					is_hide_topcost = true,
					is_hide_listbutton = true
				})
				FightManager.refreshFightToType(FIGHTTYPE_ADVENTURE)
			else
				if arg_109_0 == 2 then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_ADVENTURE_WARNING[2])
				elseif arg_109_0 == 3 then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_ADVENTURE_WARNING[3])
				elseif arg_109_0 == 4 then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_ADVENTURE_WARNING[4])
				elseif arg_109_0 == 5 then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_ADVENTURE_WARNING[5])
				elseif arg_109_0 == 6 then
					audio_manager:playeffectMusicTest("sound/invalid")

					if chapter_data["" .. var_108_0 .. "-" .. var_108_1] and chapter_data["" .. var_108_0 .. "-" .. var_108_1].boss_combat then
						global_ShowBlockWords(L_ADVENTURE_WARNING[6] .. chapter_data["" .. var_108_0 .. "-" .. var_108_1].boss_combat .. L_ADVENTURE_WARNING[7])
					end
				elseif arg_109_0 == 7 then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_ADVENTURE_WARNING[4])
				end

				GuideListener.showAllGuidesWithFullScreen(true)
			end
		end

		local function var_108_5(arg_110_0)
			GuideListener.showAllGuidesWithFullScreen(false)
			array_manager:resetHangupArray(arg_110_0)
			RoleDefault:getInstance():setIntegerForKey("activityarray", arg_110_0)
			RoleDefault:getInstance():setIntegerForKey("lastadventurearray", arg_110_0)
			RoleDefault:getInstance():setIntegerForKey("SpecialAdventureEnterMode", var_108_0)
			RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", levelmode_data[var_108_0].modetype)
			level_manager:switchToAdventureMode(var_108_0, var_108_1, var_108_4, arg_110_0)
		end

		local var_108_6 = RoleDefault:getInstance():getIntegerForKey("activityarray", 1)

		LayerManager:pushInLayer("LevelDetailLayer", {
			fight_type = "ADVENTURE",
			level = 1,
			mode = var_108_0,
			chapter = self.chapter,
			callback = function()
				return
			end,
			adventuresurecallback = function()
				require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationModeLayer", {
					initindex = var_108_6,
					mode = var_108_0,
					configtype = CONFIG_TYPE_ADVENTURE,
					configcallback = var_108_5,
					exitcallback = callback
				})
			end,
			initindex = var_108_6
		})
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sure"):getChildByName("Label_2"):setFontName(FONT_NAME)
end
