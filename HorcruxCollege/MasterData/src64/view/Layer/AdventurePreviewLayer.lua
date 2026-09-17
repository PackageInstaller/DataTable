AdventurePreviewLayer = class("AdventurePreviewLayer", function()
	return cc.Layer:create()
end)

local array_manager = require("controller.array_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local level_manager = require("controller.level_manager")
local explore_manager = require("controller.explore_manager")
local drop_manager = require("controller.drop_manager")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local drop_data = require("data.drop_data")
local chapter_data = require("data.chapter_data")
local explore_map_config_data = require("data.explore.explore_map_config_data")
local servant_data = require("data.servant_data")
local playermodel = require("model.playermodel")

require("view.Sprite.ItemSprite")

local var_0_12 = config._DEBUG and 0 or 1

function AdventurePreviewLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = AdventurePreviewLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AdventurePreviewLayer:init(arg_3_1)
	self.previewType = arg_3_1.previewType

	if not arg_3_1.previewType or arg_3_1.previewType == "ADVENTURE" then
		return
	end

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "FightPreview.json" or "FightPreview.ExportJson")

	self:addChild(self.rootLayer)

	self.panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel")
	self.chapterName = ccui.Helper:seekWidgetByName(self.rootLayer, "chapter_name")
	self.chapterDetails = ccui.Helper:seekWidgetByName(self.rootLayer, "img_pass_details")
	self.fightPowerNeed = ccui.Helper:seekWidgetByName(self.rootLayer, "fight_power_need")
	self.enemyIcon = ccui.Helper:seekWidgetByName(self.rootLayer, "img_icon")
	self.enemyName = ccui.Helper:seekWidgetByName(self.rootLayer, "label_enemy_name")
	self.enemy = ccui.Helper:seekWidgetByName(self.rootLayer, "enemy_icon")
	self.fightPower = ccui.Helper:seekWidgetByName(self.rootLayer, "label_fight_power")
	self.buttonChangeTeam = ccui.Helper:seekWidgetByName(self.rootLayer, "button_change_team")
	self.button_sure = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")
	self.awardsList = ccui.Helper:seekWidgetByName(self.rootLayer, "awards_list")
	self.no_drops = ccui.Helper:seekWidgetByName(self.rootLayer, "no_drops")
	self.awardPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "award_panel")

	self.awardPanel:removeFromParent()
	self.awardPanel:retain()

	self.teamPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_rank_list")
	self.role_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "role_panel")

	self.role_panel:removeFromParent()
	self.role_panel:retain()

	self.mode = arg_3_1.mode
	self.dataTable = self:getDataTable(arg_3_1.previewType, arg_3_1)

	self:showChapterDetails()
	self:showTeamDetails(arg_3_1.previewType)
	self:showAwardsDetails()
	self.button_sure:setPressedActionEnabled(true)
	self.button_sure:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_4_0 = array_manager:getBattleArrayData(self.curArray or 1)
		local var_4_1 = {}

		for iter_4_0 = 1, 3 do
			if var_4_0[iter_4_0].fight_girl then
				var_4_1[#var_4_1 + 1] = var_4_0[iter_4_0]
			end
		end

		if self.previewType == "EXPLORE" then
			local var_4_2 = explore_manager.getCurData("map", arg_3_1.mode)

			if explore_manager:checkIsMapRestrainServant(var_4_1, var_4_2[arg_3_1.level].ele or explore_map_config_data[arg_3_1.mode].ele) then
				global_basic_scene:addChild(PopLayer:Do({
					labels = L_ATTR_RESTRAIN_MSG,
					surecallback = function()
						if arg_3_1.surecallback then
							arg_3_1.surecallback(var_4_1)
						end

						LayerManager:removePopLayer()
					end
				}), 999)
			elseif fight_capacity_manager:getArrayFightCapacity(var_4_0, nil, nil, nil, self.mode) < var_4_2[arg_3_1.level].needspower then
				global_basic_scene:addChild(PopLayer:Do({
					labels = {
						title = L_FIGHT_CAPACITY_MSG.title,
						des = L_FIGHT_CAPACITY_MSG.des,
						button = L_FIGHT_CAPACITY_MSG.button
					},
					surecallback = function()
						if arg_3_1.surecallback then
							arg_3_1.surecallback(var_4_1)
						end

						LayerManager:removePopLayer()
					end
				}), 999)
			else
				if arg_3_1.surecallback then
					arg_3_1.surecallback(var_4_1)
				end

				LayerManager:removePopLayer()
			end
		end
	end)
	self.panel:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()
	end)
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			if arg_3_1.exitcallback then
				arg_3_1.exitcallback()
			end
		end
	end)
	GuideListener.swallowEvent(false)
	GuideListener.lockGuideTrigger(false)
	GuideListener.updateGuides(self)
end

local function var_0_14(arg_10_0)
	print("modelid =>>>>>>>>>>>>>>> ", arg_10_0)

	local var_10_0 = global_get_model_attr(arg_10_0)

	if not var_10_0 then
		return
	end

	local var_10_1 = CAREER_ICON[model_data[arg_10_0].career .. "_" .. var_10_0]
	local var_10_2

	if config._DEBUG then
		var_10_2 = cc.Sprite:create(var_10_1) or cc.Sprite:createWithSpriteFrameName(var_10_1)
	end

	var_10_2:setAnchorPoint(cc.p(0.5, 0.5))

	return var_10_2
end

local function var_0_15(arg_11_0, arg_11_1)
	local var_11_0 = global_get_model_attr(arg_11_1)

	if not var_11_0 then
		return
	end

	local var_11_1 = CAREER_ICON[model_data[arg_11_1].career .. "_" .. var_11_0]

	if config._DEBUG then
		arg_11_0:setTexture(var_11_1)
	else
		arg_11_0:setSpriteFrame(var_11_1)
	end

	arg_11_0:setAnchorPoint(cc.p(0.5, 0.5))
end

function AdventurePreviewLayer.getDataTable(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {
		chapterInfo = {},
		teamInfo = {},
		awardsInfo = {}
	}

	if arg_12_1 == "ADVENTURE" then
		var_12_0.chapterInfo = {
			chapterName = chapter_data[arg_12_2.mode .. "-" .. arg_12_2.chapter].name,
			chapterDiscription = chapter_data[arg_12_2.mode .. "-" .. arg_12_2.chapter].des,
			chapterFightPower = chapter_data[arg_12_2.mode .. "-" .. arg_12_2.chapter].fight_capacity,
			enemyName = chapter_data[arg_12_2.mode .. "-" .. arg_12_2.chapter].boss_name,
			enemyAttribute = chapter_data[arg_12_2.mode .. "-" .. arg_12_2.chapter].boss_attribute,
			enemyIcon = chapter_data[arg_12_2.mode .. "-" .. arg_12_2.chapter].image,
			enemyModelId = chapter_data[arg_12_2.mode .. "-" .. arg_12_2.chapter].modelid
		}
		var_12_0.awardsInfo.items = drop_manager:getEquipAllDrops(chapter_data[arg_12_2.mode .. "-" .. arg_12_2.chapter].bigbossdrop or chapter_data[arg_12_2.mode .. "-" .. arg_12_2.chapter].equip_drop)
	elseif arg_12_1 == "EXPLORE" then
		local var_12_2 = explore_manager.getCurData("map", arg_12_2.mode)

		var_12_0.chapterInfo = {
			chapterName = var_12_2[arg_12_2.level].name,
			chapterDiscription = var_12_2[arg_12_2.level].description,
			chapterFightPower = var_12_2[arg_12_2.level].needspower,
			costAirTicket = var_12_2[arg_12_2.level].cost_air_ticket,
			enemyName = model_data[var_12_2[arg_12_2.level].monster].name,
			enemyIcon = model_data[var_12_2[arg_12_2.level].monster].head_image,
			enemyModelId = var_12_2[arg_12_2.level].monster
		}
		var_12_0.awardsInfo.items = drop_manager:getEquipAllDrops(var_12_2[arg_12_2.level].dropid)
	end

	local var_12_3 = RoleDefault:getInstance():getIntegerForKey("explore_array_id", 1)

	arg_12_0.curArray = var_12_3

	local var_12_4 = array_manager:getBattleArrayData(var_12_3)

	for iter_12_0 = 1, 3 do
		var_12_0.teamInfo[iter_12_0] = var_12_4[iter_12_0].fight_girl or 0
	end

	return var_12_0
end

function AdventurePreviewLayer:showChapterDetails()
	local var_13_0 = self.dataTable.chapterInfo

	self.chapterName:setString(self.dataTable.chapterInfo.chapterName)
	self.fightPowerNeed:setString(L_FIGHT_CAPACITY_MSG.Required_Capacity .. global_trans_number(var_13_0.chapterFightPower))

	local var_13_1 = cc.Label:createWithTTF("", FONT_NAME, 20)

	var_13_1:setString(var_13_0.chapterDiscription)
	var_13_1:setMaxLineWidth(348)
	var_13_1:setAnchorPoint(cc.p(0, 1))
	var_13_1:setPosition(cc.p(22, 70))
	self.chapterDetails:addChild(var_13_1)
	self.enemyName:setString(var_13_0.enemyName)

	self.enemyAttribute = var_0_14(var_13_0.enemyModelId)

	self.enemyAttribute:setPosition(cc.p(-5, 16))

	if self.enemyAttribute then
		print("enemyAttribute exsit")
	else
		print("enemyAttribute not exist")
	end

	self.enemy:addChild(self.enemyAttribute, 999)
	self.enemyIcon:loadTexture("roleimage/role/wuji/" .. var_13_0.enemyIcon .. ".png")
	self.enemyIcon:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)

	if var_13_0.costAirTicket then
		local var_13_2 = ccui.ImageView:create("explore/xiaohao.png", var_0_12)

		var_13_2:setPosition(464, 1082)
		self.rootLayer:addChild(var_13_2)

		local var_13_3 = ccui.ImageView:create("explore/cost_bg.png", var_0_12)

		var_13_3:setScale9Enabled(true)
		var_13_3:setCapInsets(cc.rect(24, 24, 2, 2))
		var_13_3:setContentSize(cc.size(100, 60))
		var_13_3:setAnchorPoint(cc.p(0, 0.5))
		var_13_3:setPosition(var_13_2:getContentSize().width + 8, var_13_2:getContentSize().height / 2)
		var_13_2:addChild(var_13_3)

		local var_13_4 = ccui.ImageView:create("equipment/" .. item_data[4000001].image_id .. ".png")

		var_13_4:setScale(0.5)
		var_13_4:setPosition(12, var_13_3:getContentSize().height / 2)
		var_13_3:addChild(var_13_4)

		local var_13_5 = cc.Label:createWithTTF("×" .. var_13_0.costAirTicket, FONT_BUTTON, 26)

		var_13_5:setAnchorPoint(cc.p(1, 0.5))
		var_13_5:setPosition(var_13_3:getContentSize().width - 12, var_13_3:getContentSize().height / 2)
		var_13_3:addChild(var_13_5)
	end
end

function AdventurePreviewLayer:showTeamDetails(arg_15_1)
	local var_15_0 = self.dataTable.teamInfo

	self.rolePanels = {}

	for iter_15_0 = 1, 3 do
		local var_15_1 = self.role_panel:clone()

		if self.dataTable.teamInfo[iter_15_0] ~= 0 then
			local var_15_2 = var_15_1:getChildByName("img_role")

			var_15_2:setPositionX(75)
			var_15_1:getChildByName("img_bottom"):setPositionX(75)
			var_15_1:getChildByName("role_name"):setPositionX(75)

			local var_15_3 = var_15_1:getChildByName("role_name"):getChildByName("label_role_name")
			local var_15_4 = var_15_1:getChildByName("role_name"):getChildByName("role_attribute")

			var_15_2:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[servant_data[self.dataTable.teamInfo[iter_15_0]].modelid].cute_role .. ".png")
			var_15_2:setScale(0.45)
			var_15_3:setString(model_data[servant_data[self.dataTable.teamInfo[iter_15_0]].modelid].main_name)
			var_15_4:setVisible(false)

			local var_15_5 = var_0_14(servant_data[self.dataTable.teamInfo[iter_15_0]].modelid)

			var_15_5:setPosition(cc.p(var_15_4:getPositionX(), (var_15_4:getPositionY())))
			var_15_5:setName("roleAttribute")
			var_15_1:getChildByName("role_name"):addChild(var_15_5, 9)
			var_15_1:setPosition(cc.p(87 + (iter_15_0 - 1) * 163, 85))
			var_15_1:setVisible(true)
			self.teamPanel:addChild(var_15_1)

			local function var_15_6()
				self.rootLayer:setVisible(true)
			end

			var_15_2:setTouchEnabled(true)
			var_15_2:addTouchEventListener(function(arg_17_0, arg_17_1)
				if arg_17_1 ~= ccui.TouchEventType.ended then
					return
				end

				self.rootLayer:setVisible(false)
				LayerManager:pushInLayer("SoulsLayer", {
					showtype = 5,
					layertype = "AdventurePreviewLayer",
					cursoul = item_data[servant_data[var_15_0[iter_15_0]].itemid].servant,
					exitCallback = var_15_6
				})
			end)

			if self.previewType == "EXPLORE" then
				if var_15_1:getChildByName("sanBnt") then
					var_15_1:getChildByName("sanBnt"):removeFromParent()
				end

				local var_15_7 = explore_manager:createSanIcon(self.dataTable.teamInfo[iter_15_0])

				var_15_7:setName("sanBnt")
				var_15_7:setPosition(120, 200)
				var_15_1:addChild(var_15_7)

				if explore_manager:isServantExploreing(self.dataTable.teamInfo[iter_15_0]) then
					if not var_15_1:getChildByName("busyTips") then
						local var_15_8 = globa_create_tips(cc.size(var_15_1:getContentSize().width, 40), L_ADVENTURE_INADVENTURE, 24)

						var_15_8:setName("busyTips")
						var_15_8:setPositionY(60)
						var_15_1:addChild(var_15_8)
					end
				elseif var_15_1:getChildByName("busyTips") then
					var_15_1:getChildByName("busyTips"):removeFromParent()
				end
			end
		else
			var_15_1:setPosition(cc.p(87 + (iter_15_0 - 1) * 163, 85))
			var_15_1:setVisible(false)
			self.teamPanel:addChild(var_15_1)
		end

		self.rolePanels[iter_15_0] = var_15_1
	end

	self.fightPower:setString(L_FIGHT_CAPACITY_MSG.Own_Capacity .. global_trans_number((fight_capacity_manager:getArrayFightCapacity(array_manager:getBattleArrayData((self.previewType == "EXPLORE" or nil) and (RoleDefault:getInstance():getIntegerForKey("explore_array_id", 1) or 1)), nil, nil, nil, self.mode))))
	self.buttonChangeTeam:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:setVisible(false)

		local function var_18_0(arg_19_0)
			self.curArray = arg_19_0

			self:updateTeamRank(arg_19_0)
		end

		local function var_18_1()
			TopcostLayer.getInstance():showTopcostLayer()
			ListButtonLayer.getInstance():showLayer()
			self:setVisible(true)
		end

		if arg_15_1 == "ADVENTURE" then
			require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationModeLayer", {
				initindex = 1,
				mode = self.mode,
				configtype = CONFIG_TYPE_MODE,
				configcallback = var_18_0,
				exitcallback = var_18_1
			})
		elseif arg_15_1 == "EXPLORE" then
			print("type is EXPLORE")

			local var_18_3 = {}

			var_18_3.initindex = RoleDefault:getInstance():getIntegerForKey("explore_array_id", 1)
			var_18_3.configtype = CONFIG_TYPE_EXPLORE
			var_18_3.configcallback = var_18_0
			var_18_3.exitcallback = var_18_1

			require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationExploreLayer", var_18_3)
		end
	end)
end

function AdventurePreviewLayer:showAwardsDetails()
	local var_21_0 = self.dataTable.awardsInfo

	if self.dataTable.awardsInfo.gold then
		local var_21_1 = self.awardPanel:clone()
		local var_21_2 = ItemSprite:createNewWithItemId("gold", self.dataTable.awardsInfo.gold)

		var_21_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_21_2:setPosition(cc.p(var_21_1:getContentSize().width * 0.5, var_21_1:getContentSize().height * 0.5))
		var_21_2:setScale(0.7)
		var_21_1:addChild(var_21_2)
		self.awardsList:pushBackCustomItem(var_21_1)
		self.no_drops:setVisible(false)
	end

	if self.dataTable.awardsInfo.diamond then
		local var_21_3 = self.awardPanel:clone()
		local var_21_4 = ItemSprite:createNewWithItemId("diamond", self.dataTable.awardsInfo.diamond)

		var_21_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_21_4:setPosition(cc.p(var_21_3:getContentSize().width * 0.5, var_21_3:getContentSize().height * 0.5))
		var_21_4:setScale(0.7)
		var_21_3:addChild(var_21_4)
		self.awardsList:pushBackCustomItem(var_21_3)
		self.no_drops:setVisible(false)
	end

	for iter_21_0 = 1, #self.dataTable.awardsInfo.items do
		local var_21_5 = self.awardPanel:clone()
		local var_21_6 = ItemSprite:createNewWithItemId(self.dataTable.awardsInfo.items[iter_21_0].dropid, self.dataTable.awardsInfo.items[iter_21_0].dropNum)

		var_21_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_21_6:setScale(0.7)
		var_21_6:setPosition(cc.p(var_21_5:getContentSize().width * 0.5, var_21_5:getContentSize().height * 0.5))
		var_21_5:addChild(var_21_6)

		var_21_5.item_type = "item"

		var_21_5:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showDetailsofItems(var_21_0.items[iter_21_0].dropid, var_21_5.item_type)
		end)
		self.awardsList:pushBackCustomItem(var_21_5)
		self.no_drops:setVisible(false)
	end
end

function AdventurePreviewLayer:updateTeamRank(arg_23_1)
	if self.previewType == "EXPLORE" then
		RoleDefault:getInstance():setIntegerForKey("explore_array_id", arg_23_1)
	end

	local var_23_0 = array_manager:getBattleArrayData(arg_23_1)

	for iter_23_0 = 1, 3 do
		self.dataTable.teamInfo[iter_23_0] = var_23_0[iter_23_0].fight_girl or 0
	end

	for iter_23_1 = 1, 3 do
		local var_23_1 = self.dataTable.teamInfo[iter_23_1]
		local var_23_2 = self.rolePanels[iter_23_1]

		if not self.rolePanels[iter_23_1] then
			print("rolePanel do not exist,i = ", iter_23_1)
		end

		if var_23_1 ~= 0 then
			var_23_2:setVisible(true)

			local var_23_3 = var_23_2:getChildByName("img_role")
			local var_23_4 = var_23_2:getChildByName("role_name"):getChildByName("label_role_name")
			local var_23_5 = var_23_2:getChildByName("role_name"):getChildByName("roleAttribute")

			var_23_3:setPositionX(75)
			var_23_2:getChildByName("img_bottom"):setPositionX(75)
			var_23_2:getChildByName("role_name"):setPositionX(75)
			var_23_3:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[servant_data[var_23_1].modelid].cute_role .. ".png")
			var_23_3:setScale(0.45)
			var_23_4:setString(model_data[servant_data[var_23_1].modelid].main_name)

			if var_23_5 then
				var_0_15(var_23_5, servant_data[var_23_1].modelid)
			else
				local var_23_6 = var_23_2:getChildByName("role_name"):getChildByName("role_attribute")

				var_23_6:setVisible(false)

				local var_23_7 = var_0_14(servant_data[var_23_1].modelid)

				var_23_7:setPosition(cc.p(var_23_6:getPositionX(), (var_23_6:getPositionY())))
				var_23_7:setName("roleAttribute")
				var_23_2:getChildByName("role_name"):addChild(var_23_7, 9)
			end

			if self.previewType == "EXPLORE" then
				if var_23_2:getChildByName("sanBnt") then
					var_23_2:getChildByName("sanBnt"):removeFromParent()
				end

				local var_23_8 = explore_manager:createSanIcon(var_23_1)

				var_23_8:setName("sanBnt")
				var_23_8:setPosition(120, 200)
				var_23_2:addChild(var_23_8)

				if explore_manager:isServantExploreing(var_23_1) then
					if not var_23_2:getChildByName("busyTips") then
						local var_23_9 = globa_create_tips(cc.size(var_23_2:getContentSize().width, 40), L_EXPLORING, 24)

						var_23_9:setPositionY(60)
						var_23_9:setName("busyTips")
						var_23_2:addChild(var_23_9)
					end
				elseif var_23_2:getChildByName("busyTips") then
					var_23_2:getChildByName("busyTips"):removeFromParent()
				end
			end
		else
			self.rolePanels[iter_23_1]:setVisible(false)
		end
	end

	self.fightPower:setString(L_FIGHT_CAPACITY_MSG.Own_Capacity .. global_trans_number((fight_capacity_manager:getArrayFightCapacity(var_23_0, nil, nil, nil, self.mode))))
end

function AdventurePreviewLayer:showDetailsofItems(arg_24_1, arg_24_2)
	local function var_24_1()
		return
	end

	if arg_24_2 == "item" then
		if item_data[arg_24_1].bag_item_type == kITEM_HORCRUX then
			local var_24_2 = -1
			local var_24_3 = require("data.horcrux_data")[arg_24_1].horcruxtype

			for iter_24_0, iter_24_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_24_1 == iter_24_1.item_id then
					var_24_2 = iter_24_0

					break
				end
			end

			if var_24_2 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_24_2,
				itemid = arg_24_1,
				callback = var_24_1
			})
			self.rootLayer:setVisible(false)
		elseif item_data[arg_24_1].bag_item_type == kITEM_HERO then
			self:setVisible(false)
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_24_1].servant,
				exitCallback = var_24_1
			})
			self.rootLayer:setVisible(false)
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_24_4 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_24_1
			})
		end
	elseif arg_24_2 == "gold" then
		-- block empty
	elseif arg_24_2 == "diamond" then
		-- block empty
	end
end
