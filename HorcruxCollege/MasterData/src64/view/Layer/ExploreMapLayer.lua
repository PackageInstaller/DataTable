ExploreMapLayer = class("ExploreMapLayer", function()
	return cc.Layer:create()
end)

local RoomMap
local var_0_1 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local favor_data = require("data.favor_data")
local explore_buff_data = require("data.explore.explore_buff_data")
local explore_sellbuff_data = require("data.explore.explore_sellbuff_data")
local total_skill_data = require("data.total_skill_data")
local skill_data = require("data.skill_data")
local explore_sellweapon_data = require("data.explore.explore_sellweapon_data")
local explore_weapon_data = require("data.explore.explore_weapon_data")
local explore_map_config_data = require("data.explore.explore_map_config_data")
local servant_data = require("data.servant_data")
local plot_data = require("data.plot_data")
local plot_class_data = require("data.plot_class_data")
local explore_img_data = require("data.explore.explore_img_data")
local explore_aim_data = require("data.explore.explore_aim_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local L2Actor = require("view.Sprite.L2Actor")
local explore_manager = require("controller.explore_manager")
local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local core_manager = require("controller.core_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local audio_manager = require("controller.audio_manager")
local component_manager = require("controller.component_manager")
local l2utils = require("controller.l2utils")
local MaskNode = require("view.Sprite.MaskNode")
local Utility = require("common.Utility")
local var_0_32
local var_0_33
local var_0_34
local var_0_35

require("view.Layer.ExploreTalkLayer")
require("view.Sprite.ConfirmDialogSprite")

local var_0_36
local var_0_37 = 0
local var_0_38 = 10
local var_0_39 = 20
local var_0_40 = 30
local var_0_41 = 1
local var_0_42 = 2
local var_0_43 = 3
local var_0_44 = 4
local var_0_45 = 8
local var_0_46 = 7
local var_0_47 = 6
local var_0_48 = 5
local var_0_49 = {}

var_0_49[1] = 3
var_0_49[2] = 4
var_0_49[3] = 1
var_0_49[4] = 2
var_0_49[8] = 6
var_0_49[7] = 5
var_0_49[6] = 8
var_0_49[5] = 7
;({})[TILE_TYPE.SPECIAL_ENEMY] = "explore/monster_title1.png"

local var_0_53 = {
	monster = "explore/small_map_boss.png",
	box = "explore/small_map_box.png",
	aim = "explore/small_map_aim.png"
}
local var_0_54 = {
	"FightLayer/anim_quality_equipment_lv1.png",
	"FightLayer/anim_quality_equipment_lv2.png",
	"FightLayer/anim_quality_equipment_lv3.png",
	"FightLayer/anim_quality_equipment_lv4.png",
	"FightLayer/anim_quality_equipment_lv5.png",
	"FightLayer/anim_quality_equipment_lv5.png"
}
local var_0_55 = {
	{
		"explore/arrow_green_1.png",
		"explore/arrow_yellow_2.png"
	},
	{
		"explore/arrow_green_2.png",
		"explore/arrow_yellow_1.png"
	},
	{
		"explore/arrow_green_3.png",
		"explore/arrow_yellow_2.png"
	},
	{
		"explore/arrow_green_4.png",
		"explore/arrow_yellow_1.png"
	}
}
local var_0_56 = 2
local var_0_57 = 3
local var_0_58 = {
	{
		idle = "idle",
		run = "run"
	},
	{
		idle = "caishui",
		run = "swim"
	},
	{
		idle = "idle",
		run = "run"
	}
}
local var_0_59 = {
	EXPLORE_WALK,
	EXPLORE_SWIM_EFFECT,
	EXPLORE_WALK
}
local var_0_60 = false
local var_0_61 = 1
local var_0_66 = 0.24
local var_0_67 = 0.8
local var_0_68 = 100
local var_0_69 = 0.3
local var_0_70 = {
	cc.p(336, 873),
	cc.p(147, 688),
	cc.p(464, 630),
	cc.p(49, 461),
	cc.p(409, 405),
	(cc.p(-25, 255))
}

function ExploreMapLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ExploreMapLayer.new(arg_3_1)

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ExploreMapLayer.getInstance()
	return var_0_36
end

function ExploreMapLayer:init(arg_5_1)
	var_0_36 = self
	self.touchLock = false
	self.isMainAimFinish = false

	if arg_5_1 then
		self.activityid = arg_5_1.activityid or 207
	end

	if arg_5_1 then
		self.returnUiLayer = arg_5_1.returnUiLayer or "SchoolAreaLayer"
	end

	self.failReturnUiLayer = arg_5_1 and arg_5_1.failReturnUiLayer
	self.curMapConfig = explore_manager.curMapConfig
	self.curMapId = self.curMapConfig.mapid
	self.curMapSize = self.curMapConfig.mapRoomSize
	self.curAimId = self.curMapConfig.aimid
	self.followQueue = self.curMapConfig.followQueue
	self.bridgeLocks = self.curMapConfig.bridgeLocks
	self.aimTypeTbl = self.curMapConfig.aimTypeTbl
	self.puzzleConfig = self.curMapConfig.puzzleConfig
	self.roomPathTree = self.curMapConfig.pathtree
	self.roomMapBlocks = self.curMapConfig.mapBlocks
	self.usedTilesConfig = self.curMapConfig.usedTile
	self.replaceConfig = self.curMapConfig.replaceConfig
	self.exploredRooms = self.curMapConfig.exploredRooms
	self.rangeConfig = self.curMapConfig.objectRange
	self.monsterRangeConfig = self.curMapConfig.monsterRange
	self.roomsLightConfig = self.curMapConfig.roomsLightConfig
	self.effect = self.curMapConfig.effect
	self.particle = self.curMapConfig.particle
	self.roomColor = self.curMapConfig.roomColor
	self.jumpEffect = self.curMapConfig.jumpEffect
	self.roomfollowholeConfig = self.curMapConfig.roomfollowholeConfig
	self.roomteleportConfig = self.curMapConfig.roomteleportConfig
	self.roomgreenConfig = self.curMapConfig.roomgreenConfig
	self.exploreProgressList = {}
	var_0_32 = require("data.explore.map_data")
	var_0_33 = require("data.explore.room_data")
	var_0_34 = require("data.explore.room_tile_data")
	var_0_35 = require("data.explore.tile_data")

	self:initUI()
	self:enterMap()

	self.start_time = os.time()

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_36 = nil

			playermodel:resetExploreArraysHpInherit()
			explore_manager:clearExploreInfoHpInherit()
			explore_manager:reset_map()
			self:removeCachedTextured()
			audio_manager:stopAllEffects()

			for iter_6_0 = 1, #self.followQueue do
				self.followQueue[iter_6_0]:release()
			end
		end
	end)
end

function ExploreMapLayer.onForeground(arg_7_0, arg_7_1)
	return
end

function ExploreMapLayer.onBackground(arg_8_0)
	return
end

function ExploreMapLayer:playUIAnimation(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = ccui.Layout:create()

	var_9_0:setContentSize(cc.size(640, GameDisplay.height))
	var_9_0:setTouchEnabled(true)
	var_9_0:setPositionY(-GameDisplay.fix_y)
	self:addChild(var_9_0, 999)
	var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_9_0:runAction(cc.RemoveSelf:create())

		if arg_9_2 then
			arg_9_2()
		end
	end)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(arg_9_1 .. ".ExportJson")

	local var_9_1 = ccs.Armature:create(arg_9_1)

	var_9_1:setPosition(320, GameDisplay.height / 2)
	var_9_0:addChild(var_9_1)
	var_9_1:getAnimation():play("Animation1")
	var_9_1:getAnimation():setFrameEventCallFunc(function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		if arg_11_1 == "end" and not arg_9_3 then
			var_9_0:runAction(cc.RemoveSelf:create())

			if arg_9_2 then
				arg_9_2()
			end
		end
	end)
end

function ExploreMapLayer:enterMap()
	if explore_aim_data[self.curMapConfig.aimid].enter_map_talk then
		global_basic_scene:addChild(TalkLayer:create(explore_aim_data[self.curMapConfig.aimid].enter_map_talk, nil, TALK_TYPE_NORMAL, "", nil), 9999)
	end

	self:mapLoading(self.curMapId, function()
		self:initSmallMap()
		self:initAimUI()
		self:switchRoom()
		self.mapPanel:setVisible(true)
	end)
end

function ExploreMapLayer:exit(arg_14_1)
	local function var_14_0()
		explore_manager:explore_success_finish(function(arg_16_0)
			if arg_16_0.result == 1 then
				self.curRoomMap:stopAllActions()

				local function var_16_0()
					local function var_17_0()
						explore_manager:reset_map(self.curMapType, {
							mapfloor = 0,
							maplevel = 6
						})
						self.curRoomMap:stopAllActions()
						LayerManager:switchShowLayer(self.returnUiLayer, {
							activityid = self.activityid
						})
						AnalyticManager.explore_success({
							aimid = self.curAimId,
							explore_time = math.floor(os.time() - self.start_time)
						})
					end

					for iter_17_0, iter_17_1 in pairs(self.curMapConfig.array) do
						iter_17_1.classtype = 1
					end

					if self.curMapConfig.isrepeat then
						var_17_0()
					else
						local var_17_1 = {
							items = arg_16_0.items,
							curarray = self.curMapConfig.array
						}

						var_17_1.showText = explore_aim_data[self.curAimId].name or L_EXPLOREMAP_AREA
						var_17_1.cancelcallback = var_17_0

						LayerManager:pushInLayer("PopExploreResultLayer", var_17_1)
					end
				end

				if explore_aim_data[self.curMapConfig.aimid].out_map_talk then
					global_basic_scene:addChild(TalkLayer:create(explore_aim_data[self.curMapConfig.aimid].out_map_talk, nil, TALK_TYPE_NORMAL, "", var_16_0), 999)
				else
					var_16_0()
				end
			end
		end)
	end

	if (#self.curMapConfig.mapProgress == 0 or explore_manager:getMapProgress() >= 100) and explore_manager:is_main_aim_finish() then
		var_14_0()
	elseif explore_manager:is_main_aim_finish() then
		local var_14_1 = {
			surecallback = var_14_0,
			cancelcallback = arg_14_1,
			labels = L_EXPLOREMAP_EXIT_MSG.Exit_Button_Finish
		}

		var_14_1.labels.titleImage = "title_return.png"

		LayerManager:pushInLayer("PopDoLayer", var_14_1)
	else
		local var_14_2 = {}

		function var_14_2.surecallback()
			explore_manager:reset_map(self.curMapType, {
				mapfloor = 0,
				maplevel = 6
			})
			self.curRoomMap:stopAllActions()
			print("??????????????????", self.returnUiLayer, self.failReturnUiLayer)

			if self.failReturnUiLayer then
				LayerManager:switchShowLayer(self.failReturnUiLayer)
			else
				LayerManager:switchShowLayer(self.returnUiLayer, {
					activityid = self.activityid
				})
			end

			AnalyticManager.explore_cancel({
				aimid = self.curAimId
			})
		end

		var_14_2.cancelcallback = arg_14_1
		var_14_2.labels = L_EXPLOREMAP_EXIT_MSG.Exit_Button_Unfinish
		var_14_2.labels.titleImage = "title_retreat.png"

		LayerManager:pushInLayer("PopDoLayer", var_14_2)
	end
end

function ExploreMapLayer:failExit()
	local function var_20_0()
		self:playUIAnimation("shibai", function()
			self.curRoomMap:stopAllActions()

			if self.failReturnUiLayer then
				LayerManager:switchShowLayer(self.failReturnUiLayer)
			else
				LayerManager:switchShowLayer(self.returnUiLayer)
			end

			AnalyticManager.explore_fail({
				aimid = self.curAimId
			})
		end, true)
	end

	if explore_aim_data[self.curMapConfig.aimid].aim_fail_talk then
		global_basic_scene:addChild(TalkLayer:create(explore_aim_data[self.curMapConfig.aimid].aim_fail_talk, nil, TALK_TYPE_NORMAL, "", var_20_0), 999)
	else
		var_20_0()
	end
end

function ExploreMapLayer:initUI()
	local var_23_0 = ccui.Layout:create()

	var_23_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_23_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_23_0:setBackGroundColorOpacity(opacity)
	var_23_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_23_0:setPosition(-GameDisplay.fix_x, -GameDisplay.fix_y)
	self:addChild(var_23_0, -1)

	self.mapPanel = ccui.Layout:create()

	self.mapPanel:setVisible(false)
	self:addChild(self.mapPanel)

	self.effectLayer = ccui.Layout:create()

	self.effectLayer:setVisible(false)
	self.effectLayer:setTouchEnabled(false)
	self.effectLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.effectLayer:setPosition(-GameDisplay.fix_x, -GameDisplay.fix_y)
	self:addChild(self.effectLayer)

	local var_23_1 = var_0_33[explore_manager:getRoomid(self.curMapId, self.curMapConfig.curRoomOrder)]

	self.mapView = ccui.ScrollView:create()

	self.mapView:setDirection(ccui.ScrollViewDir.both)
	self.mapView:setContentSize(cc.size(640, 880))
	self.mapView:setPosition(0, 0)
	self.mapView:setTouchEnabled(false)

	local var_23_2 = var_23_1.width_num * var_0_68
	local var_23_3 = var_23_1.height_num * var_0_68

	var_23_2 = var_23_1.width_num * var_0_68 < self.mapView:getContentSize().width / var_0_67 and self.mapView:getContentSize().width / var_0_67 or var_23_2
	var_23_3 = var_23_3 < self.mapView:getContentSize().height / var_0_67 and self.mapView:getContentSize().height / var_0_67 or var_23_3

	self.mapView:setInnerContainerSize(cc.size(var_23_2, var_23_3))
	self.mapView:getInnerContainer():setScale(var_0_67)
	self.mapPanel:addChild(self.mapView, 1)

	self.mapUIPanel = ccui.Layout:create()

	self.mapPanel:addChild(self.mapUIPanel, 9)

	self.gainItemPanel = ccui.Layout:create()
	self.gainItemPanel.sp_tbl = {}

	self.mapUIPanel:addChild(self.gainItemPanel, 9)

	local var_23_4 = explore_manager:isHpInherit()
	local var_23_5 = ccui.Button:create("explore/top_bg.png", "explore/top_bg.png", "explore/top_bg.png", var_0_1)

	if var_23_4 then
		var_23_5 = ccui.Button:create("explore/hpInherit/bg.png", "explore/hpInherit/bg.png", "explore/hpInherit/bg.png", var_0_1)
	end

	var_23_5:setTouchEnabled(false)
	var_23_5:setSwallowTouches(false)
	var_23_5:setAnchorPoint(cc.p(0, 1))
	var_23_5:setPosition(0, GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 0, TRANSFORM_UNIT.PX))
	var_23_5:setName("topbg")
	self.mapUIPanel:addChild(var_23_5)

	self.mapFloorLabel = cc.Label:createWithTTF(explore_aim_data[self.curMapConfig.aimid].name, FONT_NAME, 30)

	self.mapFloorLabel:setName("mapfloor")
	self.mapFloorLabel:setAnchorPoint(cc.p(0, 0.5))
	self.mapFloorLabel:setPosition(5, 240)
	var_23_5:addChild(self.mapFloorLabel)

	local var_23_6 = ccui.Button:create("explore/map_give_up.png", nil, "explore/map_give_up.png", var_0_1)

	if var_23_4 then
		var_23_6 = ccui.Button:create("explore/hpInherit/map_give_up.png", nil, "explore/hpInherit/map_give_up.png", var_0_1)
	end

	var_23_6:setName("mapGiveupBnt")
	var_23_6:setAnchorPoint(cc.p(1, 1))
	var_23_6:setPosition(var_23_5:getContentSize().width - 10, var_23_5:getContentSize().height)
	var_23_5:addChild(var_23_6)
	var_23_6:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_24_0:isBright() then
			return
		end

		arg_24_0:setBright(false)
		self:exit(function()
			arg_24_0:setBright(true)
		end)
	end)

	local var_23_7 = ccui.Button:create("explore/bag_icon.png", nil, "explore/bag_icon.png", var_0_1)

	if var_23_4 then
		var_23_7 = ccui.Button:create("explore/hpInherit/bag_icon.png", nil, "explore/hpInherit/bag_icon.png", var_0_1)
	end

	var_23_7:setAnchorPoint(cc.p(1, 0))
	var_23_7:setPosition(638, GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 2, TRANSFORM_UNIT.PX))
	var_23_7:setName("bagBnt")
	self.mapUIPanel:addChild(var_23_7)
	var_23_7:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:popExploreBag()
	end)
	self:initBtnArray(var_23_4)

	local var_23_8 = ccui.Layout:create()

	var_23_8:setTouchEnabled(true)
	var_23_8:setBackGroundImage("explore/small_map_bg.png", var_0_1)

	if var_23_4 then
		var_23_8:setBackGroundImage("explore/hpInherit/small_map_bg.png", var_0_1)
	end

	var_23_8:setAnchorPoint(cc.p(0, 0))
	var_23_8:setClippingEnabled(true)
	var_23_8:setPosition(7, 17)
	var_23_8:setContentSize(cc.size(168, 199))
	var_23_5:addChild(var_23_8, -1)
	var_23_8:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:popBigMap()
	end)

	self.smallMap = ccui.Layout:create()

	var_23_8:addChild(self.smallMap)

	local var_23_9 = ccui.ImageView:create("explore/room_name_bg.png", var_0_1)

	if var_23_4 then
		var_23_9 = ccui.ImageView:create("explore/hpInherit/room_name_bg.png", var_0_1)
	end

	var_23_9:setAnchorPoint(cc.p(0, 1))
	var_23_9:setPosition(0, 5)
	var_23_5:addChild(var_23_9, -1)

	self.roomName = cc.Label:createWithTTF("", FONT_NAME, 30)

	self.roomName:setPosition(var_23_9:getContentSize().width / 2, var_23_9:getContentSize().height / 2)
	var_23_9:addChild(self.roomName)

	local var_23_10 = ccui.Layout:create()

	var_23_10:setPosition(184, 20)
	var_23_10:setClippingEnabled(true)
	var_23_10:setContentSize(cc.size(450, 200))
	var_23_5:addChild(var_23_10)

	self.aimLayout = ccui.Layout:create()

	self.aimLayout:setPosition(-var_23_10:getPositionX(), -var_23_10:getPositionY())
	var_23_10:addChild(self.aimLayout)

	self.exploreProgressLayout = ccui.Layout:create()

	self.exploreProgressLayout:setVisible(false)
	self.exploreProgressLayout:setPosition(-var_23_10:getPositionX(), -var_23_10:getPositionY())
	var_23_10:addChild(self.exploreProgressLayout)
	self:initBloodUI()
	self:initExploreProgress()
	self:registerExploreBeginFightCallback()
end

function ExploreMapLayer.registerExploreBeginFightCallback(arg_28_0)
	if explore_manager:isHpInherit() then
		explore_manager:initHorcruxCache()
		explore_manager:setFightBeginCallback(function(arg_29_0)
			local var_29_0 = explore_manager.arrayIndex or 1

			local function var_29_1()
				arg_28_0.touchLock = false
			end

			local function var_29_2(arg_31_0)
				explore_manager:updateSelectedArray(arg_31_0)

				explore_manager.levelmode = arg_29_0
				explore_manager.dieCount = 0

				FightManager.refreshFightToType(FIGHTTYPE_EXPLORE)
				LayerManager:switchShowLayer("FightLayer", {
					is_hide_topcost = true,
					is_hide_listbutton = true
				})
			end

			local var_29_3, var_29_4 = explore_manager:getCurrentFixArray()

			if explore_manager:isFixArray() then
				require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationSpecialExploreLayer", {
					is_hp_inherit = true,
					fix_array = var_29_4,
					initindex = var_29_0,
					configtype = CONFIG_TYPE_EXPLORE_HP_INHERIT,
					configCallback = var_29_2
				})
			else
				require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationExploreLayer", {
					is_hp_inherit = true,
					fix_array = var_29_4,
					initindex = var_29_0,
					configtype = CONFIG_TYPE_EXPLORE_HP_INHERIT,
					configCallback = var_29_2,
					customConfigexitCallback = var_29_1
				})
			end
		end)
	end
end

function ExploreMapLayer:initBtnArray(arg_32_1)
	if not arg_32_1 then
		return
	end

	local var_32_0 = self.mapUIPanel:getChildByName("bagBnt")
	local var_32_1 = ccui.Button:create("explore/hpInherit/team_icon.png", "explore/hpInherit/team_icon.png", "explore/hpInherit/team_icon.png", var_0_1)

	var_32_1:setAnchorPoint(var_32_0:getAnchorPoint())
	var_32_1:setPosition(var_32_0:getPositionX() - var_32_0:getContentSize().width - 20, (var_32_0:getPositionY()))
	self.mapUIPanel:addChild(var_32_1, 1, "btnArray")
	var_32_1:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_33_0 = explore_manager.arrayIndex or 1

		local function var_33_1()
			self.touchLock = false
		end

		local var_33_2, var_33_3 = explore_manager:getCurrentFixArray()
		local var_33_4 = {
			is_hp_inherit = true,
			initindex = var_33_0,
			configtype = CONFIG_TYPE_EXPLORE_HP_INHERIT,
			configcallback = function(arg_35_0)
				self.touchLock = false

				explore_manager:updateSelectedArray(arg_35_0)
			end,
			exitcallback = var_33_1,
			fix_array = var_33_3
		}

		if explore_manager:isFixArray() then
			require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationSpecialExploreLayer", var_33_4)
		else
			require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationExploreLayer", var_33_4)
		end
	end)
end

function ExploreMapLayer:mapLoading(arg_36_1, arg_36_2)
	local var_36_0 = explore_aim_data[self.curAimId]
	local var_36_1 = "sound/" .. explore_aim_data[self.curAimId].bgm .. ".ogg"
	local var_36_2 = ccui.Layout:create()

	var_36_2:setContentSize(cc.size(640, GameDisplay.height))
	var_36_2:setTouchEnabled(true)
	global_basic_scene:addChild(var_36_2, 999)

	var_36_2.wait_ani = true
	var_36_2.wait_load = 2

	function var_36_2:initUI(arg_37_1)
		self.up = cc.Sprite:create("mainScenebg/explore/loading.jpg")

		self.up:setPosition(cc.p(320, GameDisplay.height / 2))
		self:addChild(self.up, 1)

		if config._DEBUG then
			self.title = cc.Sprite:create("explore/load_title.png") or cc.Sprite:createWithSpriteFrameName("explore/load_title.png")
		end

		self.title:setPosition(cc.p(480, 60))
		self:addChild(self.title, 2)

		self.points = {}

		for iter_37_0 = 1, 3 do
			local var_37_0

			if config._DEBUG then
				var_37_0 = cc.Sprite:create("explore/load_point.png") or cc.Sprite:createWithSpriteFrameName("explore/load_point.png")
			end

			var_37_0:setPosition(self.title:getPositionX() + self.title:getContentSize().width / 2 + 4 + (iter_37_0 - 1) * 12, 60)
			self:addChild(var_37_0, 2)

			self.points[iter_37_0] = var_37_0
		end
	end

	function var_36_2.startScheduler(arg_38_0)
		arg_38_0.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_39_0)
			if not arg_38_0.wait_ani and arg_38_0.wait_load <= 0 then
				arg_38_0:loadEnding()
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_38_0.scheduler)

				arg_38_0.scheduler = nil
			end
		end, 0.1, false)
	end

	function var_36_2:startLoading()
		self:checkResource((explore_manager:getSpineList()))
	end

	local file_check_manager = require("controller.filedownloader.file_check_manager")

	require("controller.filedownloader.download_node_utils"):addDownloadInterface(var_36_2)

	function var_36_2:checkResource(arg_41_1)
		self._downloadinglist = {}

		local var_41_0, var_41_1 = file_check_manager:checkSpineByIDList(arg_41_1)

		var_41_1 = var_41_1 or {}

		if file_check_manager:checkFileNeedDownload(var_36_1) then
			table.insert(var_41_1, file_check_manager:getFileDownloadInfo(var_36_1))
		end

		if #var_41_1 > 0 then
			self:startDownload(var_41_1)
		else
			self:onDownloadComplete()
		end
	end

	function var_36_2:startDownload(arg_42_1)
		self._downloadinglist = {}

		for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
			self._downloadinglist[iter_42_1.filename] = true
		end

		require("controller.filedownloader.download_manager"):insertDownloadTasks(arg_42_1, "fight")
	end

	function var_36_2.onDownloadComplete(arg_43_0)
		local var_43_0 = {}

		if var_0_32[arg_36_1].fullImage:find(",") then
			for iter_43_0 in var_0_32[arg_36_1].fullImage:gmatch("([^,]+)") do
				table.insert(var_43_0, "tilemap/tiles_" .. iter_43_0 .. ".plist")
			end
		else
			var_43_0 = {
				"tilemap/tiles_" .. var_0_32[arg_36_1].fullImage .. ".plist"
			}
		end

		for iter_43_1, iter_43_2 in pairs(var_43_0) do
			local var_43_1

			if iter_43_2:find(".png") then
				var_43_1 = iter_43_2
			elseif iter_43_2:find(".plist") then
				var_43_1 = iter_43_2:match("(.+).plist") .. ".png"
			end

			cc.Director:getInstance():getTextureCache():addImageAsync(var_43_1, function()
				if iter_43_2:find(".plist") then
					cc.SpriteFrameCache:getInstance():addSpriteFrames(iter_43_2)
				end

				arg_43_0.wait_load = arg_43_0.wait_load - 1
			end)
		end

		audio_manager:loadAudio(var_36_1, function()
			arg_43_0.wait_load = arg_43_0.wait_load - 1
		end)
	end

	function var_36_2:startAction()
		for iter_46_0 = 1, 3 do
			self.points[iter_46_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create((iter_46_0 - 1) * 0.2), cc.JumpBy:create(0.2, cc.p(0, 0), 8, 1), cc.DelayTime:create(3 * 0.2 + 0.5 - (iter_46_0 - 1) * 0.2))))
		end

		self.wait_ani = false
	end

	function var_36_2:loadEnding()
		self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			if arg_36_2 then
				arg_36_2()
			end

			for iter_48_0 = 1, 3 do
				self.points[iter_48_0]:stopAllActions()
			end

			audio_manager:switchLayerBGM("sound/" .. var_36_0.bgm, true)
		end), cc.RemoveSelf:create()))
	end

	var_36_2:initDownload()
	var_36_2:initUI()
	var_36_2:startScheduler()
	var_36_2:startLoading()
	var_36_2:startAction()
end

function ExploreMapLayer:removeCachedTextured()
	for iter_49_0, iter_49_1 in pairs({
		"tilemap/tiles_" .. var_0_32[self.curMapId].fullImage .. ".plist"
	}) do
		if iter_49_1:find(".png") then
			cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_49_1)
		elseif iter_49_1:find(".plist") then
			cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile(iter_49_1)
			cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_49_1:match("(.+).plist") .. ".png")
		end
	end
end

function ExploreMapLayer:checkCurRoomLogo(arg_50_1)
	if not self.exploredRooms[arg_50_1] then
		return false
	end

	local function var_50_0(arg_51_0)
		return self.curMapConfig.aimTypeTbl[arg_51_0] and self.curMapConfig.aimTypeTbl[arg_51_0].result_type == "map" and self.curMapConfig.aimTypeTbl[arg_51_0].is_show
	end

	local function var_50_1(arg_52_0)
		if var_0_35[arg_52_0].show_class then
			return true
		else
			return false
		end
	end

	local function var_50_2(arg_53_0)
		return var_0_35[arg_53_0].class == TILE_TYPE.SPECIAL_ENEMY
	end

	local var_50_3
	local var_50_4
	local var_50_5

	for iter_50_0, iter_50_1 in pairs(self.usedTilesConfig[arg_50_1]) do
		var_50_3 = var_50_3 or var_50_0(iter_50_1.tileid)
		var_50_4 = var_50_4 or var_50_1(iter_50_1.tileid)
		var_50_5 = var_50_5 or var_50_2(iter_50_1.tileid)
	end

	local var_50_6

	if var_50_3 then
		var_50_6 = "aim"
	elseif var_50_4 then
		var_50_6 = "box"
	elseif var_50_5 then
		var_50_6 = "monster"
	end

	return var_50_6
end

function ExploreMapLayer:initSmallMap()
	local var_54_0 = 18
	local var_54_1 = cc.size(explore_manager:getCurMapMaxSize(var_0_32[self.curMapId].map_cad_id))

	self.smallMap:setContentSize(cc.size(var_54_1.width * 87 + (var_54_1.width - 1) * 18 + 40, var_54_1.height * 84 + (var_54_1.height - 1) * 18 + 40))
	self.smallMap:setScale(0.5)

	local var_54_2 = explore_manager:get_map_cad_config(var_0_32[self.curMapId].map_cad_id)

	for iter_54_0, iter_54_1 in pairs(var_54_2) do
		local var_54_3
		local var_54_4

		if self.roomPathTree[iter_54_0] then
			var_54_3 = iter_54_0 == self.curMapConfig.curRoomOrder and "explore/small_map_room2.png" or "explore/small_map_room1.png"
			var_54_4 = self:checkCurRoomLogo(iter_54_0)
		else
			var_54_3 = "explore/small_map_room3.png"
		end

		local var_54_5 = ccui.ImageView:create(var_54_3, var_0_1)

		if explore_manager:isHpInherit() and var_54_3 == "explore/small_map_room1.png" then
			var_54_5 = ccui.ImageView:create("explore/hpInherit/small_map_room1.png", var_0_1)
		end

		var_54_5:setName("room" .. iter_54_0)
		var_54_5:setPosition(20 + var_54_5:getContentSize().width / 2 + ((iter_54_0 - 1) % self.curMapSize.width + 1 - 1) * (var_54_0 + var_54_5:getContentSize().width), self.smallMap:getContentSize().height - 20 - var_54_5:getContentSize().height / 2 - (math.floor((iter_54_0 - 1) / self.curMapSize.width) + 1 - 1) * (var_54_0 + var_54_5:getContentSize().height))
		self.smallMap:addChild(var_54_5)

		if var_54_4 then
			local var_54_6 = ccui.ImageView:create(var_0_53[var_54_4], var_0_1)

			var_54_6:setPosition(var_54_5:getPositionX(), var_54_5:getPositionY())
			var_54_6:setName("logo" .. iter_54_0)

			var_54_6.show_type = var_54_4

			self.smallMap:addChild(var_54_6)
		end

		if self.roomPathTree[iter_54_0] then
			for iter_54_2, iter_54_3 in pairs(self.roomPathTree[iter_54_0].nexts) do
				local var_54_7 = explore_manager:getBridgeOrderByDirection(iter_54_0, iter_54_2)

				if not self.smallMap:getChildByName("bridge" .. var_54_7) then
					local var_54_8

					if self.bridgeLocks[var_54_7] then
						var_54_8 = ccui.ImageView:create("explore/small_map_path2.png", var_0_1)
					else
						var_54_8 = ccui.ImageView:create("explore/small_map_path1.png", var_0_1)

						if explore_manager:isHpInherit() then
							var_54_8 = ccui.ImageView:create("explore/hpInherit/small_map_path1.png", var_0_1)
						end
					end

					local var_54_9
					local var_54_10
					local var_54_11

					if iter_54_2 == var_0_41 then
						var_54_9 = var_54_5:getPositionX()
						var_54_10 = var_54_5:getPositionY() + var_54_5:getContentSize().height / 2 + var_54_8:getContentSize().height / 2
						var_54_11 = 0
					elseif iter_54_2 == var_0_43 then
						var_54_9 = var_54_5:getPositionX()
						var_54_10 = var_54_5:getPositionY() - var_54_5:getContentSize().height / 2 - var_54_8:getContentSize().height / 2
						var_54_11 = 0
					elseif iter_54_2 == var_0_44 then
						var_54_9 = var_54_5:getPositionX() - var_54_5:getContentSize().width / 2 - var_54_8:getContentSize().height / 2
						var_54_10 = var_54_5:getPositionY()
						var_54_11 = 90
					elseif iter_54_2 == var_0_42 then
						var_54_9 = var_54_5:getPositionX() + var_54_5:getContentSize().width / 2 + var_54_8:getContentSize().height / 2
						var_54_10 = var_54_5:getPositionY()
						var_54_11 = 90
					end

					var_54_8:setName("bridge" .. var_54_7)
					var_54_8:setPosition(var_54_9, var_54_10)
					var_54_8:setRotation(var_54_11)
					self.smallMap:addChild(var_54_8)
				end
			end
		end
	end

	function self.smallMap.updateExploredRoom(arg_55_0)
		local var_55_0
		local var_55_1 = cc.p(self.smallMap:getParent():getContentSize().width / 2, self.smallMap:getParent():getContentSize().height / 2)

		for iter_55_0, iter_55_1 in pairs(self.roomPathTree) do
			if self.exploredRooms[iter_55_0] then
				self.smallMap:getChildByName("room" .. iter_55_0):setVisible(true)
				self.smallMap:getChildByName("room" .. iter_55_0):stopAllActions()

				if iter_55_0 == self.curMapConfig.curRoomOrder then
					self.smallMap:getChildByName("room" .. iter_55_0):loadTexture("explore/small_map_room2.png", var_0_1)

					var_55_0 = cc.p(self.smallMap:getChildByName("room" .. iter_55_0):getPosition())

					self.smallMap:getChildByName("room" .. iter_55_0):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 80), cc.FadeTo:create(1, 255))))
				else
					self.smallMap:getChildByName("room" .. iter_55_0):loadTexture("explore/small_map_room1.png", var_0_1)

					if explore_manager:isHpInherit() then
						self.smallMap:getChildByName("room" .. iter_55_0):loadTexture("explore/hpInherit/small_map_room1.png", var_0_1)
					end
				end
			else
				self.smallMap:getChildByName("room" .. iter_55_0):loadTexture("explore/small_map_room3.png", var_0_1)
			end
		end

		self.smallMap:stopAllActions()
		self.smallMap:runAction(cc.MoveTo:create(0.3, cc.p(var_55_1.x - var_55_0.x * self.smallMap:getScale(), var_55_1.y - var_55_0.y * self.smallMap:getScale())))
	end

	function self.smallMap.updateByObject(arg_56_0, arg_56_1)
		local var_56_0 = self:checkCurRoomLogo(self.curRoomMap.curRoomOrder)
		local var_56_1 = self.smallMap:getChildByName("logo" .. self.curRoomMap.curRoomOrder)

		if var_56_0 then
			if not var_56_1 then
				local var_56_2 = self.smallMap:getChildByName("room" .. self.curRoomMap.curRoomOrder)
				local var_56_3 = ccui.ImageView:create(var_0_53[var_56_0], var_0_1)

				var_56_3:setPosition(var_56_2:getPositionX(), var_56_2:getPositionY())
				var_56_3:setName("logo" .. self.curRoomMap.curRoomOrder)

				var_56_3.show_type = var_56_0

				self.smallMap:addChild(var_56_3)
			elseif var_56_1.show_type ~= var_56_0 then
				var_56_1:loadTexture(var_0_53[var_56_0], var_0_1)

				var_56_1.show_type = var_56_0
			end
		elseif var_56_1 then
			var_56_1:removeFromParent()
		end
	end

	function self.smallMap.updateAll(arg_57_0)
		for iter_57_0, iter_57_1 in pairs(var_54_2) do
			local var_57_0 = self:checkCurRoomLogo(iter_57_0)
			local var_57_1 = self.smallMap:getChildByName("logo" .. iter_57_0)

			if var_57_0 then
				if not var_57_1 then
					local var_57_2 = self.smallMap:getChildByName("room" .. iter_57_0)
					local var_57_3 = ccui.ImageView:create(var_0_53[var_57_0], var_0_1)

					var_57_3:setPosition(var_57_2:getPositionX(), var_57_2:getPositionY())
					var_57_3:setName("logo" .. iter_57_0)

					var_57_3.show_type = var_57_0

					self.smallMap:addChild(var_57_3)
				elseif var_57_1.show_type ~= var_57_0 then
					var_57_1:loadTexture(var_0_53[var_57_0], var_0_1)

					var_57_1.show_type = var_57_0
				end
			elseif var_57_1 then
				var_57_1:removeFromParent()
			end
		end
	end

	self.smallMap:updateExploredRoom()
end

function ExploreMapLayer:popBigMap()
	if self.bigMap then
		self.bigMap:updateBigMap()
		self.bigMap:setVisible(true)

		return
	end

	self.bigMap = ccui.ScrollView:create()

	self.bigMap:setContentSize(cc.size(640, GameDisplay.height))
	self.bigMap:setTouchEnabled(true)
	self.bigMap:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.bigMap:setBackGroundColor(cc.c3b(0, 0, 0))
	self.bigMap:setBackGroundColorOpacity(200)
	self.bigMap:setCascadeOpacityEnabled(false)
	self.bigMap:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.bigMap, 999)

	local var_58_0 = ccui.Layout:create()

	var_58_0:setTouchEnabled(false)
	self.bigMap:addChild(var_58_0, 999)

	local var_58_1 = cc.EventListenerTouchOneByOne:create()

	var_58_1:setSwallowTouches(false)
	var_58_1:registerScriptHandler(function(arg_59_0, arg_59_1)
		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_58_1:registerScriptHandler(function(arg_60_0, arg_60_1)
		local var_60_0 = var_58_0:convertToNodeSpace(arg_60_0:getStartLocation())
		local var_60_1 = var_58_0:convertToNodeSpace(arg_60_0:getLocation())

		if math.abs(var_60_1.x - var_60_0.x) < 50 and math.abs(var_60_1.y - var_60_0.y) < 50 then
			self.bigMap:setVisible(false)
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_58_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_58_1, var_58_0)

	local var_58_2 = 87
	local var_58_3 = 84
	local var_58_4 = 18
	local var_58_5 = cc.size(explore_manager:getCurMapMaxSize(var_0_32[self.curMapId].map_cad_id))
	local var_58_6 = var_58_5.width * 87 + (var_58_5.width - 1) * 18 + 40
	local var_58_7 = var_58_5.height * 84 + (var_58_5.width - 1) * 18 + 40

	var_58_6 = var_58_5.width * 87 + (var_58_5.width - 1) * 18 + 40 < self.bigMap:getContentSize().width and self.bigMap:getContentSize().width or var_58_6
	var_58_7 = var_58_7 < self.bigMap:getContentSize().height and self.bigMap:getContentSize().height or var_58_7

	self.bigMap:setInnerContainerSize(cc.size(var_58_6, var_58_7))
	self.bigMap:runAction(cc.CallFunc:create(function()
		self.bigMap:getInnerContainer():setPosition((self.bigMap:getContentSize().width - var_58_6) / 2, (self.bigMap:getContentSize().height - var_58_7) / 2)
	end))

	for iter_58_0, iter_58_1 in pairs((explore_manager:get_map_cad_config(var_0_32[self.curMapId].map_cad_id))) do
		local var_58_8
		local var_58_9

		if self.roomPathTree[iter_58_0] then
			var_58_8 = iter_58_0 == self.curMapConfig.curRoomOrder and "explore/small_map_room2.png" or self.exploredRooms[iter_58_0] and "explore/small_map_room1.png" or "explore/small_map_room3.png"
			var_58_9 = self:checkCurRoomLogo(iter_58_0)
		else
			var_58_8 = "explore/small_map_room3.png"
		end

		local var_58_10 = ccui.ImageView:create(var_58_8, var_0_1)

		if explore_manager:isHpInherit() and var_58_8 == "explore/small_map_room1.png" then
			var_58_10 = ccui.ImageView:create("explore/hpInherit/small_map_room1.png", var_0_1)
		end

		var_58_10:setName("room" .. iter_58_0)
		var_58_10:setPosition(var_58_6 / 2 + ((iter_58_0 - 1) % self.curMapSize.width + 1 - (var_58_5.width + 1) / 2) * (var_58_4 + var_58_2), var_58_7 / 2 + ((var_58_5.height + 1) / 2 - (math.floor((iter_58_0 - 1) / self.curMapSize.width) + 1)) * (var_58_4 + var_58_3))
		self.bigMap:addChild(var_58_10)

		if var_58_8 == "explore/small_map_room2.png" then
			var_58_10:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 80), cc.FadeTo:create(1, 255))))
		end

		if var_58_9 then
			local var_58_11 = ccui.ImageView:create(var_0_53[var_58_9], var_0_1)

			var_58_11:setPosition(var_58_10:getPositionX(), var_58_10:getPositionY())
			var_58_11:setName("logo" .. iter_58_0)

			var_58_11.show_type = var_58_9

			self.bigMap:addChild(var_58_11)
		end

		if self.roomPathTree[iter_58_0] then
			for iter_58_2, iter_58_3 in pairs(self.roomPathTree[iter_58_0].nexts) do
				local var_58_12 = explore_manager:getBridgeOrderByDirection(iter_58_0, iter_58_2)

				if not self.bigMap:getChildByName("bridge" .. var_58_12) then
					local var_58_13

					if self.bridgeLocks[var_58_12] then
						var_58_13 = ccui.ImageView:create("explore/small_map_path2.png", var_0_1)
						var_58_13.is_yellow = true
					else
						var_58_13 = ccui.ImageView:create("explore/small_map_path1.png", var_0_1)

						if explore_manager:isHpInherit() then
							var_58_13 = ccui.ImageView:create("explore/hpInherit/small_map_path1.png", var_0_1)
						end
					end

					local var_58_14
					local var_58_15
					local var_58_16

					if iter_58_2 == var_0_41 then
						var_58_14 = var_58_10:getPositionX()
						var_58_15 = var_58_10:getPositionY() + var_58_10:getContentSize().height / 2 + var_58_13:getContentSize().height / 2
						var_58_16 = 0
					elseif iter_58_2 == var_0_43 then
						var_58_14 = var_58_10:getPositionX()
						var_58_15 = var_58_10:getPositionY() - var_58_10:getContentSize().height / 2 - var_58_13:getContentSize().height / 2
						var_58_16 = 0
					elseif iter_58_2 == var_0_44 then
						var_58_14 = var_58_10:getPositionX() - var_58_10:getContentSize().width / 2 - var_58_13:getContentSize().height / 2
						var_58_15 = var_58_10:getPositionY()
						var_58_16 = 90
					elseif iter_58_2 == var_0_42 then
						var_58_14 = var_58_10:getPositionX() + var_58_10:getContentSize().width / 2 + var_58_13:getContentSize().height / 2
						var_58_15 = var_58_10:getPositionY()
						var_58_16 = 90
					end

					var_58_13:setName("bridge" .. var_58_12)
					var_58_13:setPosition(var_58_14, var_58_15)
					var_58_13:setRotation(var_58_16)
					self.bigMap:addChild(var_58_13)
				end
			end
		end
	end

	function self.bigMap.updateBigMap(arg_62_0)
		local var_62_1 = explore_manager:isHpInherit()

		for iter_62_0, iter_62_1 in pairs(self.roomPathTree) do
			if self.exploredRooms[iter_62_0] then
				self.bigMap:getChildByName("room" .. iter_62_0):setVisible(true)
				self.bigMap:getChildByName("room" .. iter_62_0):stopAllActions()

				if iter_62_0 == self.curMapConfig.curRoomOrder then
					self.bigMap:getChildByName("room" .. iter_62_0):loadTexture("explore/small_map_room2.png", var_0_1)

					local var_62_2 = cc.p(self.bigMap:getChildByName("room" .. iter_62_0):getPosition())

					self.bigMap:getChildByName("room" .. iter_62_0):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 80), cc.FadeTo:create(1, 255))))
				else
					self.bigMap:getChildByName("room" .. iter_62_0):loadTexture("explore/small_map_room1.png", var_0_1)

					if var_62_1 then
						self.bigMap:getChildByName("room" .. iter_62_0):loadTexture("explore/hpInherit/small_map_room1.png", var_0_1)
					end
				end
			else
				self.bigMap:getChildByName("room" .. iter_62_0):loadTexture("explore/small_map_room3.png", var_0_1)
			end

			local var_62_3 = self:checkCurRoomLogo(iter_62_0)
			local var_62_4 = self.bigMap:getChildByName("logo" .. iter_62_0)

			if var_62_3 then
				if not var_62_4 then
					local var_62_5 = self.bigMap:getChildByName("room" .. iter_62_0)
					local var_62_6 = ccui.ImageView:create(var_0_53[var_62_3], var_0_1)

					var_62_6:setPosition(var_62_5:getPositionX(), var_62_5:getPositionY())
					var_62_6:setName("logo" .. iter_62_0)

					var_62_6.show_type = var_62_3

					self.bigMap:addChild(var_62_6)
				elseif var_62_4.show_type ~= var_62_3 then
					var_62_4:loadTexture(var_0_53[var_62_3], var_0_1)

					var_62_4.show_type = var_62_3
				end
			elseif var_62_4 then
				var_62_4:removeFromParent()
			end
		end

		for iter_62_2, iter_62_3 in pairs(self.aimTypeTbl) do
			if iter_62_3.result_type == "bridge" then
				if not self.bridgeLocks[iter_62_3.result_param1] and self.bigMap:getChildByName("bridge" .. iter_62_3.result_param1).is_yellow then
					self.bigMap:getChildByName("bridge" .. iter_62_3.result_param1):loadTexture("explore/small_map_path1.png", var_0_1)

					if var_62_1 then
						self.bigMap:getChildByName("bridge" .. iter_62_3.result_param1):loadTexture("explore/hpInherit/small_map_path1.png", var_0_1)
					end

					self.bigMap:getChildByName("bridge" .. iter_62_3.result_param1).is_yellow = false
				end
			end
		end
	end
end

function ExploreMapLayer:popExploreBag()
	local var_63_0 = ccui.Layout:create()

	var_63_0:setTouchEnabled(true)
	var_63_0:setContentSize(cc.size(640, GameDisplay.height))
	var_63_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_63_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_63_0:setBackGroundColorOpacity(200)
	var_63_0:setCascadeOpacityEnabled(false)
	var_63_0:setPositionY(-GameDisplay.fix_y)
	self:addChild(var_63_0, 999)

	local var_63_1 = ccui.ImageView:create("explore/bag_effect.png", var_0_1)

	if explore_manager:isHpInherit() then
		var_63_1 = ccui.ImageView:create("explore/hpInherit/bag_effect.png", var_0_1)
	end

	var_63_1:setAnchorPoint(cc.p(1, 0))
	var_63_1:setPosition(638, 2)
	var_63_0:addChild(var_63_1)
	var_63_1:setScale(0)
	var_63_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1)))
	var_63_0:addTouchEventListener(function(arg_64_0, arg_64_1)
		if arg_64_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_63_1:stopAllActions()
		var_63_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 0, 0), cc.CallFunc:create(function()
			var_63_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
	print(dump(self.curMapConfig.itemcache))

	if next(self.curMapConfig.itemcache) == nil then
		local var_63_2 = cc.Label:createWithTTF(L_EXPLOREMAP_BAG.Empty, FONT_TITLE, 40)

		var_63_2:setPosition(var_63_1:getContentSize().width / 2 - 20, var_63_1:getContentSize().height / 2 + 160)
		var_63_2:setOpacity(200)
		var_63_1:addChild(var_63_2, 9)
	end

	local var_63_3 = ccui.ScrollView:create()

	var_63_3:setBounceEnabled(true)

	local var_63_4 = table.nums(self.curMapConfig.itemcache)
	local var_63_5 = var_63_4 * 200 < 507 and 507 or var_63_4 * 200

	var_63_3:setInnerContainerSize(cc.size(508, var_63_4 * 200 < 507 and 507 or var_63_4 * 200))
	var_63_3:setDirection(ccui.ScrollViewDir.vertical)
	var_63_3:setContentSize(cc.size(508, 507))
	var_63_3:setAnchorPoint(cc.p(0, 0))
	var_63_3:setPosition(6, 276)
	var_63_1:addChild(var_63_3)

	local var_63_6 = 1

	for iter_63_0, iter_63_1 in pairs(self.curMapConfig.itemcache) do
		local var_63_7 = ItemSprite:createNewWithItemId(iter_63_1.itemid, iter_63_1.number)

		var_63_7:setScale(0.8)
		var_63_7:setAnchorPoint(cc.p(0, 0))
		var_63_7:setPosition(4 + (var_63_6 - 1) % 3 * 176, var_63_5 - (math.floor((var_63_6 - 1) / 3) + 1) * 200)
		var_63_3:addChild(var_63_7)
		var_63_7:setTouchEnabled(true)
		var_63_7:addSpriteTouchEventListener(function(arg_66_0, arg_66_1)
			if arg_66_1 ~= ccui.TouchEventType.ended then
				return
			end

			PopLayer:Item({
				hideGainButton = true,
				itemid = iter_63_1.itemid,
				itemnum = iter_63_1.number
			})
		end)

		if item_data[iter_63_1.itemid].buffid then
			local var_63_8 = ccui.ImageView:create("explore/item_tips_buff.png", var_0_1)

			var_63_8:setAnchorPoint(cc.p(0, 1))
			var_63_8:setPosition(0, var_63_7:getContentSize().height)
			var_63_7:addChild(var_63_8, 99)
		elseif item_data[iter_63_1.itemid].bag_item_type == kITEM_EXPLORE_ITEM then
			local var_63_9 = ccui.ImageView:create("explore/item_tips.png", var_0_1)

			var_63_9:setAnchorPoint(cc.p(0, 1))
			var_63_9:setPosition(0, var_63_7:getContentSize().height)
			var_63_7:addChild(var_63_9, 99)
		end

		var_63_6 = var_63_6 + 1
	end
end

function ExploreMapLayer:initAimUI()
	local var_67_0 = explore_manager:isHpInherit()
	local var_67_1 = ccui.ImageView:create("explore/aim_title_bg1.png", var_0_1)

	if var_67_0 then
		var_67_1 = ccui.ImageView:create("explore/hpInherit/aim_title_bg1.png", var_0_1)
	end

	var_67_1:setAnchorPoint(cc.p(0, 0.5))
	var_67_1:setPosition(186, 200)
	self.aimLayout:addChild(var_67_1)

	local var_67_2 = cc.Label:createWithTTF(L_EXPLOREMAP_AIM.Title[1], FONT_NAME, 26)

	var_67_2:setAnchorPoint(cc.p(0, 0.5))
	var_67_2:setPosition(15, var_67_1:getContentSize().height / 2)
	var_67_1:addChild(var_67_2)

	local var_67_3 = ccui.ImageView:create("explore/aim_title_bg2.png", var_0_1)

	if var_67_0 then
		var_67_3 = ccui.ImageView:create("explore/hpInherit/aim_title_bg2.png", var_0_1)
	end

	var_67_3:setName("aimTile2")
	var_67_3:setAnchorPoint(cc.p(0, 0.5))
	var_67_3:setPosition(186, 80)
	self.aimLayout:addChild(var_67_3)

	local var_67_4 = cc.Label:createWithTTF(L_EXPLOREMAP_AIM.Title[2], FONT_NAME, 26)

	var_67_4:setAnchorPoint(cc.p(0, 0.5))
	var_67_4:setPosition(15, var_67_1:getContentSize().height / 2)
	var_67_3:addChild(var_67_4)

	local var_67_5 = {}
	local var_67_6 = true

	for iter_67_0, iter_67_1 in pairs(self.aimTypeTbl) do
		if iter_67_1.result_type == "map" then
			table.insert(var_67_5, iter_67_1)
		elseif var_67_6 then
			table.insert(var_67_5, iter_67_1)

			var_67_6 = false
		end
	end

	local var_67_7 = var_67_6 and {
		cc.p(200, 160),
		cc.p(200, 120),
		cc.p(200, 80),
		cc.p(200, 40)
	} or {
		cc.p(200, 160),
		cc.p(200, 120),
		cc.p(200, 45)
	}

	for iter_67_2, iter_67_3 in pairs(var_67_5) do
		local var_67_8 = ccui.Layout:create()

		var_67_8:setVisible(iter_67_3.is_show)
		var_67_8:setName("aim" .. iter_67_3.tileid)

		var_67_8.aimInfo = iter_67_3
		var_67_8.tileid = iter_67_3.tileid

		self.aimLayout:addChild(var_67_8)

		local var_67_9 = cc.DrawNode:create()

		var_67_9:setName("drawNode")
		var_67_8:addChild(var_67_9, 9)

		local var_67_10 = ccui.ImageView:create("explore/aim_bg.png", var_0_1)

		var_67_10:setName("aim_bg")
		var_67_10:setVisible(false)
		var_67_10:setAnchorPoint(cc.p(0, 0.5))
		var_67_10:setPosition(var_67_7[iter_67_3.order].x - 18, var_67_7[iter_67_3.order].y)
		var_67_8:addChild(var_67_10)

		local var_67_11 = ccui.ImageView:create("explore/aim_light.png", var_0_1)

		if var_67_0 then
			var_67_11 = ccui.ImageView:create("explore/hpInherit/aim_light.png", var_0_1)
		end

		var_67_11.img_n = "explore/aim_light.png"
		var_67_11.img_s = "explore/aim_yellow_point.png"

		var_67_11:setName("aim_point")
		var_67_11:setPosition(var_67_7[iter_67_3.order])
		var_67_8:addChild(var_67_11)

		local var_67_12 = cc.Label:createWithTTF(iter_67_3.flag .. "/" .. iter_67_3.num, FONT_NAME, 25)
		local var_67_13 = cc.Label:createWithTTF(iter_67_3.des .. "(", FONT_NAME, 25)
		local var_67_14 = var_67_13:getContentSize().width
		local var_67_15 = " "

		for iter_67_4 = 1, string.len(iter_67_3.flag .. "/" .. iter_67_3.num) do
			var_67_15 = var_67_15 .. " "
		end

		var_67_13:setString(iter_67_3.des .. "(" .. var_67_15 .. ")")
		var_67_13:setColor(cc.c3b(64, 154, 192))
		var_67_13:setAnchorPoint(cc.p(0, 0.5))
		var_67_13:setPosition(var_67_11:getPositionX() + var_67_11:getContentSize().width / 2 + 4, var_67_11:getPositionY())
		var_67_13:setName("aim_des")

		var_67_13.color_n = cc.c3b(64, 154, 192)
		var_67_13.color_s = cc.c3b(255, 154, 0)

		var_67_12:setAnchorPoint(cc.p(0, 0.5))
		var_67_12:setPosition(var_67_13:getPositionX() + var_67_14 + 4, var_67_11:getPositionY())
		var_67_12:setColor(cc.c3b(60, 192, 159))
		var_67_12:setName("aim_label")
		var_67_8:addChild(var_67_13)
		var_67_8:addChild(var_67_12)

		local var_67_16 = ccui.ImageView:create("explore/aim_box.png", var_0_1)

		if var_67_0 then
			var_67_16 = ccui.ImageView:create("explore/hpInherit/aim_box.png", var_0_1)
		end

		var_67_16:setName("aim_box")
		var_67_16:setPosition(608, var_67_11:getPositionY())
		var_67_8:addChild(var_67_16)

		function var_67_8:finish_action()
			local var_68_0 = 0.5
			local var_68_1 = 0
			local var_68_2 = cc.p(var_67_11:getPosition())

			var_67_9:stopAllActions()
			var_67_9:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
				var_68_1 = var_68_1 + 1

				var_67_9:clear()
				var_67_9:drawSegment(var_68_2, cc.p(var_67_11:getPositionX() + var_68_1 * 0.016666666666666666 * (var_67_13:getContentSize().width + var_67_11:getContentSize().width / 2 + 4) / var_68_0, var_67_11:getPositionY()), 2, cc.c4f(0.2549019607843137, 0.6509803921568628, 0.8196078431372549, 1))

				if var_68_1 * 0.016666666666666666 >= var_68_0 then
					var_67_9:stopAllActions()
					var_67_8:setOpacity(120)
				end
			end))))

			local var_68_3 = var_67_8:getChildByName("finish_aim_box")

			if not var_68_3 then
				var_68_3 = ccui.ImageView:create("explore/aim_box2.png", var_0_1)

				var_68_3:setName("finish_aim_box")
				var_68_3:setPosition(var_67_16:getPosition())
				var_67_8:addChild(var_68_3)
			end

			var_68_3:setVisible(true)
			var_68_3:setScale(3)
			var_68_3:runAction(cc.ScaleTo:create(0.5, 1))

			if self.aimInfo.result_type == "bridge" then
				local var_68_4 = self.aimInfo.result_param1
				local var_68_5 = not not explore_manager:checkBridegRoomClosed(self.curRoomMap.curRoomOrder, self.aimInfo.result_param1)

				if var_68_5 then
					self.isBridgeAction = self.aimInfo.result_param1
				end

				var_67_8:stopAllActions()
				var_67_8:runAction(cc.Sequence:create(cc.DelayTime:create(0.8), cc.MoveBy:create(0.1, cc.p(40, 0)), cc.MoveBy:create(0.3, cc.p(-450, 0)), cc.Hide:create(), cc.CallFunc:create(function()
					var_67_3:setVisible(false)
					self.smallMap:getChildByName("bridge" .. var_68_4):loadTexture("explore/small_map_path1.png", var_0_1)

					if var_67_0 then
						self.smallMap:getChildByName("bridge" .. var_68_4):loadTexture("explore/hpInherit/small_map_path1.png", var_0_1)
					end

					self.curRoomMap:popTalkSp(L_EXPLOREMAP_AIM.TalkSp)

					if var_68_5 then
						self.curRoomMap:updateBoundUI(var_68_4)
					end
				end)))
			end
		end

		if iter_67_3.result_type == "bridge" then
			self.aimLayout.bridge_aim_panel = var_67_8

			function var_67_8.bridge_aim_panel_reset(arg_71_0, arg_71_1)
				var_67_8:setVisible(true)
				var_67_3:setVisible(true)

				if arg_71_1.tileid == var_67_8.tileid then
					return
				end

				var_67_8.tileid = arg_71_1.tileid
				var_67_8.aimInfo = arg_71_1

				var_67_8:setName("aim" .. arg_71_1.tileid)
				var_67_8:setPositionX(450)
				var_67_8:setOpacity(255)

				var_67_8.isfinish = false

				var_67_9:clear()

				if var_67_8:getChildByName("finish_aim_box") then
					var_67_8:getChildByName("finish_aim_box"):setVisible(false)
				end

				var_67_8:runAction(cc.Sequence:create(cc.MoveTo:create(0.4, cc.p(-20, var_67_8:getPositionY())), cc.MoveTo:create(0.05, cc.p(20, var_67_8:getPositionY())), cc.MoveTo:create(0.05, cc.p(0, var_67_8:getPositionY()))))
				var_67_13:setString(arg_71_1.des .. "(")

				local var_71_0 = " "

				for iter_71_0 = 1, string.len(arg_71_1.flag .. "/" .. arg_71_1.num) do
					var_71_0 = var_71_0 .. " "
				end

				var_67_13:setString(arg_71_1.des .. "(" .. var_71_0 .. ")")
				var_67_12:setString(arg_71_1.flag .. "/" .. arg_71_1.num)
				var_67_12:setPositionX(var_67_13:getPositionX() + var_67_13:getContentSize().width + 4)
			end
		else
			function var_67_8.show_main_aim_by_object(arg_72_0, arg_72_1)
				var_67_8:setPositionX(410)
				var_67_8:setVisible(true)
				var_67_8:runAction(cc.Sequence:create(cc.MoveTo:create(0.4, cc.p(-20, var_67_8:getPositionY())), cc.MoveTo:create(0.05, cc.p(20, var_67_8:getPositionY())), cc.MoveTo:create(0.05, cc.p(0, var_67_8:getPositionY()))))
			end
		end
	end

	function self.aimLayout.updateAim(arg_73_0, arg_73_1)
		if not self.aimTypeTbl[arg_73_1] then
			return
		end

		local var_73_0 = self.aimLayout:getChildByName("aim" .. self.aimTypeTbl[arg_73_1].tileid)

		if var_73_0 and var_73_0.isfinish then
			return
		end

		if var_73_0 then
			var_73_0:getChildByName("aim_label"):setString(self.aimTypeTbl[arg_73_1].flag .. "/" .. self.aimTypeTbl[arg_73_1].num)

			if self.aimTypeTbl[arg_73_1].flag >= self.aimTypeTbl[arg_73_1].num and not var_73_0.isfinish then
				var_73_0.isfinish = true

				var_73_0:finish_action()
			end
		end

		local var_73_1 = true

		for iter_73_0, iter_73_1 in pairs(self.aimTypeTbl) do
			if iter_73_1.result_type == "map" and iter_73_1.flag < iter_73_1.num then
				var_73_1 = false
			end
		end

		if var_73_1 and self.aimTypeTbl[arg_73_1].result_type == "map" then
			self.isMainAimFinish = true

			self.aimLayout:setVisible(false)
			self.exploreProgressLayout:setVisible(true)
			self:playAimFinishAni()
			self:updateEffect()

			if explore_manager:getMapProgress() == 100 then
				-- block empty
			end
		end
	end

	function self.aimLayout.triggerAim(arg_74_0, arg_74_1)
		local var_74_0 = self.aimLayout:getChildByName("aim" .. arg_74_1)

		var_74_0:stopAllActions()
		var_74_0:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			var_74_0:getChildByName("aim_bg"):setVisible(true)
			var_74_0:getChildByName("aim_point"):loadTexture(var_74_0:getChildByName("aim_point").img_s, var_0_1)
			var_74_0:getChildByName("aim_des"):setColor(var_74_0:getChildByName("aim_des").color_s)
		end), cc.MoveTo:create(0.1, cc.p(-10, 0)), cc.MoveTo:create(0.2, cc.p(10, 0)), cc.MoveTo:create(0.2, cc.p(-10, 0)), cc.MoveTo:create(0.4, cc.p(10, 0)), cc.MoveTo:create(0.3, cc.p(-10, 0)), cc.MoveTo:create(0.3, cc.p(0, 0)), cc.CallFunc:create(function()
			var_74_0:getChildByName("aim_bg"):setVisible(false)
			var_74_0:getChildByName("aim_point"):loadTexture(var_74_0:getChildByName("aim_point").img_n, var_0_1)
			var_74_0:getChildByName("aim_des"):setColor(var_74_0:getChildByName("aim_des").color_n)
		end)))
	end
end

function ExploreMapLayer:updateEffect()
	if self.mapPanel:getChildByTag(123) then
		self.mapPanel:getChildByTag(123):removeFromParent()
	end

	if self.mapPanel:getChildByTag(456) then
		self.mapPanel:getChildByTag(456):removeFromParent()
	end

	if self.mapPanel:getChildByTag(789) then
		self.mapPanel:getChildByTag(789):removeFromParent()
	end
end

function ExploreMapLayer:playAimFinishAni()
	local function var_78_0()
		local var_79_0 = self.mapUIPanel:getChildByName("topbg"):getChildByName("mapGiveupBnt")

		var_79_0:setPositionX(var_79_0:getParent():getContentSize().width + var_79_0:getContentSize().width)
		var_79_0:loadTextures("explore/map_finish.png", nil, "explore/map_finish.png", var_0_1)

		local var_79_1 = ccui.ImageView:create("explore/map_finish_bg.png", var_0_1)

		if explore_manager:isHpInherit() then
			var_79_1 = ccui.ImageView:create("explore/hpInherit/map_finish_bg.png", var_0_1)
		end

		var_79_1:setAnchorPoint(cc.p(1, 1))
		var_79_1:setPosition(var_79_0:getContentSize().width, var_79_0:getContentSize().height)
		var_79_0:addChild(var_79_1, -1)
		var_79_0:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_79_0:getParent():getContentSize().width, var_79_0:getPositionY()))))

		for iter_79_0 = 1, 2 do
			local var_79_2 = ccui.ImageView:create("explore/map_finish_frame.png", var_0_1)

			var_79_2:setAnchorPoint(cc.p(1, 1))
			var_79_2:setPosition(var_79_0:getContentSize().width, var_79_0:getContentSize().height)
			var_79_0:addChild(var_79_2)
			var_79_2:runAction(cc.Sequence:create(cc.DelayTime:create((iter_79_0 - 1) * 0.4), cc.CallFunc:create(function()
				var_79_2:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.8, 1.1), cc.FadeOut:create(0.8)), cc.CallFunc:create(function()
					var_79_2:setScale(1)
					var_79_2:setOpacity(255)
				end))))
			end)))
		end
	end

	local function var_78_1()
		if self.curMapConfig.isrepeat then
			var_78_0()

			return
		end

		local var_82_0 = ccui.Layout:create()

		var_82_0:setTouchEnabled(true)
		var_82_0:setContentSize(cc.size(640, GameDisplay.height))
		var_82_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_82_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_82_0:setBackGroundColorOpacity(200)
		var_82_0:setCascadeOpacityEnabled(false)
		var_82_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_82_0, 999)

		local var_82_1 = ccui.Layout:create()

		var_82_1:setPositionY(GameDisplay.height / 2 - 100)
		var_82_1:setVisible(false)
		var_82_1:setScaleY(0.01)
		var_82_0:addChild(var_82_1, 9)

		local var_82_2 = explore_aim_data[self.curMapConfig.aimid]

		if explore_aim_data[self.curMapConfig.aimid].aim_finish_dropid then
			var_82_0.lock = true

			local var_82_3 = drop_manager:getAllDrops(explore_aim_data[self.curMapConfig.aimid].aim_finish_dropid)

			for iter_82_0, iter_82_1 in pairs(var_82_3) do
				local var_82_4 = ItemSprite:createNewWithItemId(iter_82_1.dropid)

				var_82_4:setPosition((iter_82_0 - (#var_82_3 + 1) / 2) * 136 + 320, 0)
				var_82_4:setScale(0.66)
				var_82_1:addChild(var_82_4)
			end
		else
			var_82_0:setBackGroundColorOpacity(0)
		end

		audio_manager:playeffectMusicTest("sound/achievement")
		ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("chenggong.ExportJson")

		local var_82_5 = ccs.Armature:create("chenggong")

		var_82_5:setPosition(320, GameDisplay.height / 2)
		var_82_0:addChild(var_82_5)
		var_82_5:getAnimation():play("Animation1")
		var_82_5:getAnimation():setFrameEventCallFunc(function(arg_83_0, arg_83_1, arg_83_2, arg_83_3)
			if arg_83_1 == "end1" then
				if var_82_2.aim_finish_dropid then
					var_82_5:getAnimation():play("Animation2")
					var_82_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.Show:create(), cc.ScaleTo:create(0.15, 1, 1)))
				else
					var_82_0:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.RemoveSelf:create()))
				end
			elseif arg_83_1 == "end2" then
				var_82_0.lock = false
			elseif arg_83_1 == "end3" then
				var_82_0:runAction(cc.RemoveSelf:create())
			end
		end)
		var_82_0:addTouchEventListener(function(arg_84_0, arg_84_1)
			if arg_84_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_82_0.lock then
				return
			end

			var_82_0.lock = true

			if var_82_2.aim_finish_dropid then
				var_82_5:getAnimation():play("Animation3")
				var_82_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0.01), cc.Hide:create()))
			else
				var_82_0:runAction(cc.RemoveSelf:create())
			end
		end)
		var_78_0()
	end

	if explore_aim_data[self.curMapConfig.aimid].aim_finish_talk then
		global_basic_scene:addChild(TalkLayer:create(explore_aim_data[self.curMapConfig.aimid].aim_finish_talk, nil, TALK_TYPE_NORMAL, "", var_78_1), 999)
	else
		var_78_1()
	end
end

function ExploreMapLayer:initExploreProgress()
	local var_85_0 = ccui.Button:create("explore/box_icon.png", nil, nil, var_0_1)

	var_85_0:setOpacity(200)
	var_85_0:setAnchorPoint(cc.p(1, 0.5))
	var_85_0:setPosition(640, 110)
	var_85_0:setName("boxicon")
	self.exploreProgressLayout:addChild(var_85_0)

	self.exploreProgressBar = ccui.Layout:create()

	self.exploreProgressLayout:addChild(self.exploreProgressBar)

	local var_85_1 = explore_manager:isHpInherit()

	for iter_85_0 = 1, 20 do
		local var_85_2 = ccui.ImageView:create("explore/bar_bg.png", var_0_1)

		if var_85_1 then
			var_85_2 = ccui.ImageView:create("explore/hpInherit/bar_bg.png", var_0_1)
		end

		var_85_2:setPosition(610, 40 + (iter_85_0 - 1) * 8)
		self.exploreProgressBar:addChild(var_85_2)

		local var_85_3 = ccui.ImageView:create("explore/bar_icon.png", var_0_1)

		if var_85_1 then
			local var_85_4 = ccui.ImageView:create("explore/hpInherit/bar_icon.png", var_0_1)
		end

		var_85_3:setVisible(false)
		var_85_3:setName("bar_icon" .. iter_85_0)
		var_85_3:setPosition(610, 40 + (iter_85_0 - 1) * 8)
		self.exploreProgressBar:addChild(var_85_3)
	end

	function self.exploreProgressBar.setPercentage(arg_86_0, arg_86_1)
		local var_86_0 = math.floor(arg_86_1 / 100 * 20)

		for iter_86_0 = 1, 20 do
			if iter_86_0 <= var_86_0 then
				self.exploreProgressBar:getChildByName("bar_icon" .. iter_86_0):setVisible(true)
			else
				self.exploreProgressBar:getChildByName("bar_icon" .. iter_86_0):setVisible(false)
			end
		end
	end

	self.exploreProgressLabel = cc.Label:createWithTTF(explore_manager:getMapProgress() .. "%", FONT_NAME, 14)

	self.exploreProgressLabel:setColor(cc.c3b(138, 213, 255))
	self.exploreProgressLabel:setPosition(610, 28)
	self.exploreProgressLayout:addChild(self.exploreProgressLabel)

	local var_85_5 = ccui.ScrollView:create()

	var_85_5:setContentSize(cc.size(260, 200))
	var_85_5:setPosition(180, 20)
	self.exploreProgressLayout:addChild(var_85_5)

	local var_85_6 = table.nums(explore_manager.curMapConfig.mapProgress)
	local var_85_7 = 60 + 30 * var_85_6 < 200 and 200 or 60 + 30 * table.nums(explore_manager.curMapConfig.mapProgress)

	var_85_5:setInnerContainerSize(cc.size(180, var_85_7))

	local var_85_8 = 1

	for iter_85_1, iter_85_2 in pairs(explore_manager.curMapConfig.mapProgress) do
		local var_85_9 = ccui.Layout:create()

		if var_85_7 > 200 then
			var_85_9:setPosition(26, var_85_7 - 30 - (var_85_8 - 1) * 30)
		else
			var_85_9:setPosition(26, var_85_7 / 2 + (var_85_8 - (var_85_6 + 1) / 2) * 30)
		end

		var_85_5:addChild(var_85_9)

		self.exploreProgressList[iter_85_1] = var_85_9

		local var_85_10 = cc.DrawNode:create()

		var_85_10:setName("drawNode")
		var_85_9:addChild(var_85_10)

		local var_85_11 = ccui.ImageView:create("explore/aim_light.png", var_0_1)

		if var_85_1 then
			var_85_11 = ccui.ImageView:create("explore/hpInherit/aim_light.png", var_0_1)
		end

		var_85_11:setPosition(0, 0)
		var_85_9:addChild(var_85_11)

		local var_85_12 = cc.Label:createWithTTF(iter_85_2.total .. "/" .. iter_85_2.total, FONT_NAME, 25)
		local var_85_13 = cc.Label:createWithTTF(TILE_SHOW_STR[iter_85_1] .. "(", FONT_NAME, 25)
		local var_85_14 = var_85_13:getContentSize().width
		local var_85_15 = " "

		for iter_85_3 = 1, string.len(iter_85_2.total .. "/" .. iter_85_2.total) do
			var_85_15 = var_85_15 .. " "
		end

		var_85_13:setString(TILE_SHOW_STR[iter_85_1] .. "(" .. var_85_15 .. ")")
		var_85_13:setColor(cc.c3b(64, 154, 192))
		var_85_13:setAnchorPoint(cc.p(0, 0.5))
		var_85_13:setPosition(var_85_11:getPositionX() + var_85_11:getContentSize().width / 2 + 4, var_85_11:getPositionY())
		var_85_12:setString(iter_85_2.used .. "/" .. iter_85_2.total)
		var_85_12:setAnchorPoint(cc.p(0, 0.5))
		var_85_12:setPosition(var_85_13:getPositionX() + var_85_14 + 4, var_85_11:getPositionY())
		var_85_12:setColor(cc.c3b(60, 192, 159))
		var_85_12:setName("num")
		var_85_9:addChild(var_85_13)
		var_85_9:addChild(var_85_12)

		var_85_9.count = var_85_8
		var_85_8 = var_85_8 + 1

		function var_85_9:finish_action()
			local var_87_0 = 0.5
			local var_87_1 = 0
			local var_87_2 = cc.p(var_85_11:getPosition())

			var_85_10:stopAllActions()
			var_85_10:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
				var_87_1 = var_87_1 + 1

				var_85_10:clear()
				var_85_10:drawSegment(var_87_2, cc.p(var_85_11:getPositionX() + var_87_1 * 0.016666666666666666 * (var_85_13:getContentSize().width + var_85_11:getContentSize().width / 2 + 4) / var_87_0, var_85_11:getPositionY()), 2, cc.c4f(0.2549019607843137, 0.6509803921568628, 0.8196078431372549, 1))

				if var_87_1 * 0.016666666666666666 >= var_87_0 then
					var_85_10:stopAllActions()
				end
			end))))
			var_85_13:stopAllActions()
			var_85_13:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeTo:create(0.3, 100)))
			var_85_12:stopAllActions()
			var_85_12:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeTo:create(0.3, 100)))

			self.count = table.nums(explore_manager.curMapConfig.mapProgress)

			self:stopAllActions()
			self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.MoveBy:create(0.1, cc.p(50, 0)), cc.MoveTo:create(0.2, cc.p(50, var_85_7 - 30 - (self.count - 1) * 30)), cc.MoveTo:create(0.2, cc.p(26, var_85_7 - 30 - (self.count - 1) * 30))))

			for iter_87_0, iter_87_1 in pairs(self.exploreProgressList) do
				if self.count < iter_87_1.count and iter_87_0 ~= iter_85_1 then
					iter_87_1.count = iter_87_1.count - 1

					iter_87_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.MoveTo:create(0.4, cc.p(26, var_85_7 - 30 - (iter_87_1.count - 1) * 30))))
				end
			end
		end
	end

	function self.exploreProgressLayout.exploreProgressComplete(arg_89_0)
		var_85_5:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(-300, 0)), cc.FadeOut:create(0.3)), cc.Hide:create()))
		self.exploreProgressBar:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(200, 0)), cc.FadeOut:create(0.3)), cc.Hide:create()))
		self.exploreProgressLabel:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(200, 0)), cc.FadeOut:create(0.3)), cc.Hide:create()))
		var_85_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.MoveTo:create(0.5, cc.p(565, var_85_0:getPositionY())), cc.CallFunc:create(function()
			local var_90_0 = ccui.Button:create("explore/finish_bnt.png", nil, "explore/finish_bnt.png", var_0_1)

			var_90_0:setPosition(415, 115)
			var_90_0:setOpacity(0)
			var_90_0:setScaleX(0.5)
			self.exploreProgressLayout:addChild(var_90_0)
			var_90_0:runAction(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.5, 1)))
			var_90_0:addTouchEventListener(function(arg_91_0, arg_91_1)
				if arg_91_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_91_0:isBright() then
					return
				end

				arg_91_0:setBright(false)
				self:exit(function()
					arg_91_0:setBright(true)
				end)
			end)

			local var_90_1 = ccui.ImageView:create("explore/clear_img.png", var_0_1)

			var_90_1:setPosition(var_90_0:getPositionX(), var_90_0:getPositionY() + 10)
			var_90_1:setOpacity(0)
			self.exploreProgressLayout:addChild(var_90_1)
			var_90_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.FadeIn:create(0.2)))

			local var_90_2 = ccui.ImageView:create("explore/yellow_arrow.png", var_0_1)

			var_90_2:setOpacity(0)
			var_90_2:setPosition(var_90_0:getPositionX(), var_90_1:getPositionY() - 30)
			self.exploreProgressLayout:addChild(var_90_2)
			var_90_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.2)))

			local var_90_3 = {
				0.9,
				0.74,
				0.58
			}

			for iter_90_0 = 1, 3 do
				local var_90_4 = ccui.ImageView:create("explore/blue_arrow.png", var_0_1)

				if var_85_1 then
					var_90_4 = ccui.ImageView:create("explore/hpInherit/blue_arrow.png", var_0_1)
				end

				var_90_4:setVisible(false)
				var_90_4:setPosition(var_90_0:getPositionX() + 180, var_90_1:getPositionY())
				self.exploreProgressLayout:addChild(var_90_4)

				local var_90_5 = ccui.ImageView:create("explore/blue_arrow.png", var_0_1)

				if var_85_1 then
					var_90_5 = ccui.ImageView:create("explore/hpInherit/blue_arrow.png", var_0_1)
				end

				var_90_5:setFlippedX(true)
				var_90_5:setVisible(false)
				var_90_5:setPosition(var_90_0:getPositionX() - 180, var_90_1:getPositionY())
				self.exploreProgressLayout:addChild(var_90_5)
				var_90_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.Show:create(), cc.MoveTo:create(var_90_3[iter_90_0], cc.p(var_90_0:getPositionX() + 90 + (iter_90_0 - 1) * 16, var_90_1:getPositionY())), cc.DelayTime:create(0.05 * (4 - iter_90_0)), cc.CallFunc:create(function()
					var_90_4:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.4, 50), cc.FadeTo:create(0.4, 255))))
				end)))
				var_90_5:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.Show:create(), cc.MoveTo:create(var_90_3[iter_90_0], cc.p(var_90_0:getPositionX() - 90 - (iter_90_0 - 1) * 16, var_90_1:getPositionY())), cc.DelayTime:create(0.05 * (4 - iter_90_0)), cc.CallFunc:create(function()
					var_90_5:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.4, 50), cc.FadeTo:create(0.4, 255))))
				end)))
			end
		end)))
	end

	if next(self.curMapConfig.mapProgress) == nil then
		self.exploreProgressLayout.exploreProgressComplete()
	end
end

function ExploreMapLayer:updateExploreProgress(arg_95_1)
	if explore_manager.curMapConfig.mapProgress[var_0_35[arg_95_1].show_class] then
		self.exploreProgressList[var_0_35[arg_95_1].show_class]:getChildByName("num"):setString(explore_manager.curMapConfig.mapProgress[var_0_35[arg_95_1].show_class].used .. "/" .. explore_manager.curMapConfig.mapProgress[var_0_35[arg_95_1].show_class].total)
		self.exploreProgressLabel:setString(explore_manager:getMapProgress() .. "%")
		self.exploreProgressBar:setPercentage((explore_manager:getMapProgress()))

		if explore_manager.curMapConfig.mapProgress[var_0_35[arg_95_1].show_class].used >= explore_manager.curMapConfig.mapProgress[var_0_35[arg_95_1].show_class].total then
			self.exploreProgressList[var_0_35[arg_95_1].show_class]:finish_action()
		end

		if explore_manager:getMapProgress() == 100 then
			self.exploreProgressLayout:exploreProgressComplete()

			if explore_manager:is_main_aim_finish() then
				-- block empty
			end
		end
	end
end

function ExploreMapLayer:initBloodUI()
	local var_96_0 = explore_manager:isHpInherit()

	self.bloodbg = ccui.ImageView:create("explore/blood_bg.png", var_0_1)

	if var_96_0 then
		self.bloodbg = ccui.ImageView:create("explore/hpInherit/blood_bg.png", var_0_1)
	end

	self.bloodbg:setScale9Enabled(true)
	self.bloodbg:setCapInsets(cc.rect(160, 5, 10, 5))
	self.bloodbg:setContentSize(cc.size(self.bloodbg:getContentSize().width + 20, self.bloodbg:getContentSize().height))
	self.bloodbg:setAnchorPoint(cc.p(0, 0))
	self.bloodbg:setPosition(0, -GameDisplay.fix_y)
	self.mapUIPanel:addChild(self.bloodbg)

	local var_96_1 = cc.Label:createWithTTF(self.curMapConfig.team_hp .. "/" .. TOTAL_TEAM_HP, FONT_NAME, 12)

	var_96_1:setColor(cc.c3b(0, 216, 255))

	if var_96_0 then
		var_96_1:setColor(cc.c3b(230, 0, 0))
	end

	var_96_1:setAnchorPoint(cc.p(0, 0))
	var_96_1:setPosition(10, 5)
	var_96_1:setName("label")
	self.bloodbg:addChild(var_96_1)

	for iter_96_0 = 1, TOTAL_TEAM_HP do
		local var_96_2 = ccui.ImageView:create("explore/blood_bar.png", var_0_1)

		if var_96_0 then
			var_96_2 = ccui.ImageView:create("explore/hpInherit/blood_bar.png", var_0_1)
		end

		var_96_2:setName("blood" .. iter_96_0)
		var_96_2:setAnchorPoint(cc.p(0, 0))
		var_96_2:setPosition(50 + (iter_96_0 - 1) * var_96_2:getContentSize().width, 4)
		var_96_2:ignoreContentAdaptWithSize(false)
		self.bloodbg:addChild(var_96_2)
	end

	function self.bloodbg.updateBloodUI(arg_97_0)
		for iter_97_0 = 1, TOTAL_TEAM_HP do
			local var_97_0 = self.bloodbg:getChildByName("blood" .. iter_97_0)

			if iter_97_0 <= self.curMapConfig.team_hp then
				var_97_0:loadTexture("explore/blood_bar.png", var_0_1)

				if var_96_0 then
					var_97_0:loadTexture("explore/hpInherit/blood_bar.png", var_0_1)
				end
			else
				var_97_0:loadTexture("explore/blood_bar_gray.png", var_0_1)
			end
		end

		self.bloodbg:getChildByName("label"):setString(self.curMapConfig.team_hp .. "/" .. TOTAL_TEAM_HP)
	end
end

function ExploreMapLayer:switchRoom(arg_98_1)
	if self.curRoomMap then
		self.curRoomMap = RoomMap:create(self, arg_98_1)

		self.mapView:addChild(self.curRoomMap)
		self.smallMap:updateExploredRoom()
		self.smallMap:updateAll()
		self.roomName:setString(var_0_33[self.curRoomMap.curRoomId].name or L_EXPLOREMAP_ROOM.Room_SP_Name)
		LayerManager:cleanPopLayer()
		self.curRoomMap:go_out_action(arg_98_1, function()
			self.touchLock = false
		end)
	else
		self.curRoomMap = RoomMap:create(self)

		self.mapView:addChild(self.curRoomMap)
		self.roomName:setString(var_0_33[self.curRoomMap.curRoomId].name or L_EXPLOREMAP_ROOM.Room_SP_Name)
	end
end

function ExploreMapLayer:jumpRoom(arg_100_1)
	local var_100_0 = explore_manager:get_two_room_direction(self.curRoomMap.curRoomOrder, arg_100_1)

	self.curRoomMap = RoomMap:create(self, var_100_0)

	self.mapView:addChild(self.curRoomMap)
	self.smallMap:updateExploredRoom()
	self.smallMap:updateAll()
	self.roomName:setString(var_0_33[self.curRoomMap.curRoomId].name or L_EXPLOREMAP_ROOM.Room_SP_Name)
	self.curRoomMap:go_out_action(var_100_0, function()
		return
	end)

	local var_100_1 = self.curRoomMap:getChildByName("iconLayout"):getChildByName("tag")

	if self.jumpEffect and self.jumpEffect.jump_effect then
		local var_100_2 = L2Skeleton:create("spine/explore/" .. self.jumpEffect.jump_effect .. ".json", "spine/explore/" .. self.jumpEffect.jump_effect .. ".atlas")

		var_100_2:setName("jumpRoomEffect")
		var_100_2:setScaleX(1.2)
		var_100_2:setScaleY(1.2)
		var_100_2:refreshSkeleton()
		var_100_2:play("animation", false)
		var_100_2:registerListener(SP_ANIMATION_COMPLETE, function(arg_102_0)
			self.touchLock = false

			var_100_2:runAction(cc.RemoveSelf:create())
		end)
		var_100_2:setPosition(cc.p(var_100_1:getContentSize().width / 2, var_100_1:getContentSize().height / 2))
		var_100_1:addChild(var_100_2, 99)
		var_100_2:setGlobalZOrder(-1)
	else
		self.touchLock = false
	end
end

function ExploreMapLayer.showFailLayer(arg_103_0)
	FightManager.setFightState(FIGHTSTATE_WAIT)
	FightManager.stopStatistics()

	FightManager.needGuideFight = false

	FightManager.battlefieldRef:exploreFightFail(function()
		FightManager.switchFight(FIGHTTYPE_NORMAL)
	end)

	local var_103_0 = cloneconf(explore_manager.curMapConfig.array)

	for iter_103_0, iter_103_1 in pairs(var_103_0) do
		iter_103_1.classtype = 1
	end

	require("view.Layer.LevelResultLayer")

	local function var_103_1()
		arg_103_0:failExit()
	end

	LevelResultLayer:create({
		showtype = 7,
		curarray = var_103_0,
		surecallback = var_103_1,
		cancelcallback = var_103_1
	})
end

RoomMap = class("RoomMap", function()
	return ccui.Layout:create()
end)

function RoomMap:create(arg_107_1, arg_107_2)
	local var_107_0 = RoomMap.new()

	var_107_0:init(arg_107_1, arg_107_2)

	return var_107_0
end

function RoomMap:init(arg_108_1, arg_108_2)
	self.direction = arg_108_2
	self.root = arg_108_1
	self.curMapConfig = self.root.curMapConfig
	self.curMapId = self.curMapConfig.mapid
	self.curMapSize = self.curMapConfig.mapRoomSize
	self.curRoomOrder = self.curMapConfig.curRoomOrder
	self.curRoomObjectId = self.curMapConfig.pathtree[self.curRoomOrder].objectid
	self.curRoomId = explore_manager:getRoomid(self.curMapId, self.curRoomOrder)
	self.curRoomInfo = var_0_33[self.curRoomId]
	self.effect = self.root.effect
	self.particle = self.root.particle
	self.roomColor = self.root.roomColor
	self.room_width_num, self.room_height_num = self.curRoomInfo.width_num, self.curRoomInfo.height_num
	self.room_width, self.room_height = self.room_width_num * var_0_68, self.room_height_num * var_0_68
	self.roomBound = {
		x_min = 0,
		y_min = 0,
		x_max = self.room_width,
		y_max = self.room_height
	}
	self.bridgeLocks = self.curMapConfig.bridgeLocks
	self.aimTypeTbl = self.curMapConfig.aimTypeTbl
	self.roomPathTree = self.curMapConfig.pathtree
	self.roomMapBlocks = self.curMapConfig.mapBlocks
	self.roomMapEnvs = self.curMapConfig.mapEnvs
	self.usedTilesConfig = self.curMapConfig.usedTile
	self.replaceConfig = self.curMapConfig.replaceConfig
	self.roomsLightConfig = self.curMapConfig.roomsLightConfig
	self.roomfollowholeConfig = self.curMapConfig.roomfollowholeConfig
	self.roomteleportConfig = self.curMapConfig.roomteleportConfig
	self.roomgreenConfig = self.curMapConfig.roomgreenConfig
	self.rangeConfig = self.curMapConfig.objectRange
	self.monsterRangeConfig = self.curMapConfig.monsterRange
	self.alignmentType = self.curMapConfig.alignmentType
	self.puzzleConfig = self.curMapConfig.puzzleConfig
	self.pathTree = self.roomPathTree[self.curRoomOrder]
	self.mapBlock = self.roomMapBlocks[self.curRoomOrder]
	self.mapEnvs = self.roomMapEnvs[self.curRoomOrder]
	self.usedTile = self.usedTilesConfig[self.curRoomOrder]
	self.roomLight = self.roomsLightConfig[self.curRoomOrder]
	self.replaceModel = self.replaceConfig[self.curRoomOrder]
	self.objectRange = self.rangeConfig[self.curRoomOrder]
	self.monsterRange = self.monsterRangeConfig[self.curRoomOrder]
	self.tileobjects = {}
	self.curMapEnv = 1

	self:initMapViewHeight(arg_108_2)
	self:setContentSize(self:getFirstSize())
	self:setPosition(self:getFirstPos())

	self.batchNodeLayout = cc.SpriteBatchNode:create("tilemap/tiles_" .. var_0_32[self.curMapId].fullImage .. ".png")

	self.batchNodeLayout:setPosition(0, 0)
	self:addChild(self.batchNodeLayout, var_0_37)

	self.maskPanel = ccui.Layout:create()

	self:addChild(self.maskPanel, var_0_38)

	self.iconLayout = ccui.Layout:create()

	self.iconLayout:setName("iconLayout")
	self.iconLayout:setPosition(0, 0)
	self:addChild(self.iconLayout, var_0_39)

	self.darkLayout = ccui.Layout:create()

	self.darkLayout:setTouchEnabled(false)
	self.darkLayout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.darkLayout:setBackGroundColor(cc.c3b(0, 0, 0))
	self.darkLayout:setBackGroundColorOpacity(80)
	self.darkLayout:setContentSize(cc.size(self:getContentSize().width * 2, self:getContentSize().height * 2))
	self.darkLayout:setPosition(cc.p(-self:getContentSize().width / 2, -self:getContentSize().height / 2))
	self:addChild(self.darkLayout, var_0_40)

	if var_0_60 then
		local var_108_0 = ccui.Layout:create()

		var_108_0:setName("testLayout")
		self:addChild(var_108_0)
	end

	self:updateCurPosInfo()
	self:initDarkLayer()
	self:initSelectedFrame()
	self:initTouchMark()
	self:genMap()
	self:updateBoundUI()
	self:registerTouchEvent()
	self:triggerRoomEvent()

	if self.root.isMainAimFinish ~= true or explore_manager:isEndEffect(self.root.curAimId) then
		self:initEffectRoom()
		self:initParticletRoom()
		self:initRoomColorEffect()
	end

	if self.direction then
		self:go_in_action(function()
			self.root.mapView:getInnerContainer():setContentSize(self:getFirstSize())

			if self.mask then
				self.mask:setPosition((self:convertToNodeSpace(cc.p(GameDisplay.cx, GameDisplay.cy))))

				local var_109_0 = self:convertToWorldSpace(cc.p(self.curCoordinate.x, self.curCoordinate.y + self.tag:getBoundingBox().height / 2))

				self.mask:focus(var_109_0.x, var_109_0.y)
			end

			self.darkLayout:setVisible(false)
		end)
		self:initCameraPos()
	else
		self:initCameraPos()
	end

	Utility:registerNodeEvent(self)
end

function RoomMap:onEnter()
	explore_manager:registerEvent(self, EVENT_TYPE.CHANGE_DRESS, handler(self, self.onUpdateRole))
end

function RoomMap:onExit()
	explore_manager:removeEvent(self)
end

function RoomMap:onUpdateRole()
	local var_112_0 = 1

	for iter_112_0, iter_112_1 in ipairs(self.curMapConfig.array) do
		if iter_112_1.fight_girl then
			var_112_0 = iter_112_0

			break
		end
	end

	self:updateSelectedFrame(var_112_0)
end

function RoomMap:isMainAimFinish()
	local var_113_0 = true

	for iter_113_0, iter_113_1 in pairs(self.aimTypeTbl) do
		if iter_113_1.result_type == "map" and iter_113_1.flag < iter_113_1.num then
			var_113_0 = false
		end
	end

	return var_113_0
end

function RoomMap:handleColorStr(arg_114_1)
	return (string_split(arg_114_1, ","))
end

function RoomMap:initRoomColorEffect()
	if self.roomColor and self.roomColor["room_" .. self.curRoomOrder] and not self.root.isCloseRoomColor then
		if not self.root.mapPanel:getChildByName(self.roomColor["room_" .. self.curRoomOrder]) then
			if self.root.mapPanel:getChildByTag(789) then
				self.root.mapPanel:getChildByTag(789):removeFromParent()
			end

			local var_115_0 = ccui.Layout:create()

			var_115_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)

			local var_115_1 = self:handleColorStr(self.roomColor["room_" .. self.curRoomOrder])

			var_115_0:setBackGroundColor(cc.c3b(var_115_1[1], var_115_1[2], var_115_1[3]))
			var_115_0:setContentSize(cc.size(640, GameDisplay.height))
			var_115_0:setPosition(cc.p(0, -GameDisplay.fix_y))
			var_115_0:setTag(789)
			var_115_0:setName(self.roomColor["room_" .. self.curRoomOrder])
			var_115_0:setOpacity(60)
			self.root.mapPanel:addChild(var_115_0, 2)

			local var_115_2 = var_115_1[4] or 0.5

			var_115_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(var_115_2, var_115_1[5] or 45), cc.FadeTo:create(var_115_2, var_115_1[6] or 60))))
		end
	elseif self.root.mapPanel:getChildByTag(789) then
		self.root.mapPanel:getChildByTag(789):removeFromParent()
	end
end

function RoomMap:updateRoomColorEffect(arg_116_1)
	if arg_116_1 == 1 then
		self.root.isCloseRoomColor = true

		if self.root.mapPanel:getChildByTag(789) then
			self.root.mapPanel:getChildByTag(789):removeFromParent()
		end
	end
end

function RoomMap:initParticletRoom()
	if self.particle and self.particle["room_" .. self.curRoomOrder] then
		if not self.root.mapPanel:getChildByName(self.particle["room_" .. self.curRoomOrder]) then
			if self.root.mapPanel:getChildByTag(456) then
				self.root.mapPanel:getChildByTag(456):removeFromParent()
			end

			print("$$$$$$$$$$$$$$$$$$$$$$", "effect/" .. self.particle["room_" .. self.curRoomOrder] .. ".plist")

			local var_117_0 = cc.ParticleSystemQuad:create("effect/" .. self.particle["room_" .. self.curRoomOrder] .. ".plist")

			var_117_0:setName(self.particle["room_" .. self.curRoomOrder])
			var_117_0:setTag(456)
			var_117_0:setAutoRemoveOnFinish(true)
			var_117_0:setPosition(cc.p(320, -GameDisplay.fix_y))
			self.root.mapPanel:addChild(var_117_0, 2)
		end
	elseif self.root.mapPanel:getChildByTag(456) then
		self.root.mapPanel:getChildByTag(456):removeFromParent()
	end
end

function RoomMap:initEffectRoom()
	if self.effect and self.effect["room_" .. self.curRoomOrder] then
		if not self.root.mapPanel:getChildByName(self.effect["room_" .. self.curRoomOrder]) then
			if self.root.mapPanel:getChildByTag(123) then
				self.root.mapPanel:getChildByTag(123):removeFromParent()
			end

			local var_118_0 = L2Skeleton:create("spine/explore/" .. self.effect["room_" .. self.curRoomOrder] .. ".json", "spine/explore/" .. self.effect["room_" .. self.curRoomOrder] .. ".atlas")

			var_118_0:setTag(123)
			var_118_0:setName(self.effect["room_" .. self.curRoomOrder])
			var_118_0:refreshSkeleton()
			var_118_0:setScaleX(1.3)
			var_118_0:setScaleY((GameDisplay.height - 205) / 874)
			var_118_0:setVisible(true)
			var_118_0:play("animation", true)
			var_118_0:setPosition(cc.p(320, GameDisplay.height / 2 - 205))
			self.root.mapPanel:addChild(var_118_0, 2)
		end
	elseif self.root.mapPanel:getChildByTag(123) then
		self.root.mapPanel:getChildByTag(123):removeFromParent()
	end
end

function RoomMap:initMapViewHeight(arg_119_1)
	local var_119_0 = GameDisplay.height - 256

	if self.room_height_num * var_0_68 * var_0_67 < GameDisplay.height - 256 then
		var_119_0 = self.room_height_num * var_0_68 * var_0_67
	end

	self.root.mapView:setContentSize(cc.size(640, var_119_0))
	self.root.mapView:setPositionY((GameDisplay.height - 256 - var_119_0) / 2 - GameDisplay.fix_y)

	if arg_119_1 then
		local var_119_1 = self.root.mapView:getInnerContainerSize().width * var_0_67 - self.root.mapView:getContentSize().width
		local var_119_2 = self.root.mapView:getInnerContainerSize().height * var_0_67 - self.root.mapView:getContentSize().height
		local var_119_3 = self.root.curRoomMap.curCoordinate.x * var_0_67 - self.root.mapView:getContentSize().width / 2
		local var_119_4 = self.root.curRoomMap.curCoordinate.y * var_0_67 - self.root.mapView:getContentSize().height / 2

		if var_119_1 < var_119_3 then
			var_119_3 = var_119_1
		elseif var_119_3 < 0 then
			var_119_3 = 0
		end

		if var_119_2 < var_119_4 then
			var_119_4 = var_119_2
		elseif var_119_4 < 0 then
			var_119_4 = 0
		end

		self.root.mapView:getInnerContainer():setPosition(-var_119_3, -var_119_4)
	end
end

function RoomMap:initDarkLayer()
	if not self.roomfollowholeConfig[self.curRoomOrder] then
		self.darkLayout:setVisible(false)
	else
		self.darkLayout:setVisible(true)
		self.darkLayout:setBackGroundColorOpacity(255)

		self.mask = MaskNode:create()

		self:addChild(self.mask, var_0_40)
	end

	if self.roomteleportConfig[self.curRoomOrder] then
		if self.root.mapPanel:getChildByName("zhangzongmiwu") then
			self.root.mapPanel:getChildByName("zhangzongmiwu"):removeFromParent()
		end

		self.mask1 = MaskNode:createDreamMask()

		self.mask1:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2 - 200))
		self.mask1:setScale(self.roomteleportConfig[self.curRoomOrder])
		self.mask1:setName("zhangzongmiwu")
		self.root.mapPanel:addChild(self.mask1, 3)
	elseif self.root.mapPanel:getChildByName("zhangzongmiwu") then
		self.root.mapPanel:getChildByName("zhangzongmiwu"):removeFromParent()
	end

	if self.root.mapPanel:getChildByName("greenScreen") then
		self.root.mapPanel:getChildByName("greenScreen"):removeFromParent()
	end

	if self.roomgreenConfig[self.curRoomOrder] and self.roomgreenConfig[self.curRoomOrder] == 1 then
		local var_120_0 = ccui.ImageView:create("mainScenebg/test3.png")

		var_120_0:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2 - 200))
		var_120_0:setName("greenScreen")
		self.root.mapPanel:addChild(var_120_0, 2)
	end
end

function RoomMap:triggerRoomEvent()
	(function()
		local var_122_0 = {}

		for iter_122_0, iter_122_1 in pairs(self.bridgeLocks) do
			var_122_0[iter_122_1.room_order1] = iter_122_0
			var_122_0[iter_122_1.room_order2] = iter_122_0
		end

		if var_122_0[self.curRoomOrder] then
			self.root.aimLayout.bridge_aim_panel:bridge_aim_panel_reset(self.aimTypeTbl[self.bridgeLocks[var_122_0[self.curRoomOrder]].tileid])
		else
			self.root.aimLayout:getChildByName("aimTile2"):setVisible(self.root.aimLayout.bridge_aim_panel and self.root.aimLayout.bridge_aim_panel:isVisible() or false)
		end
	end)()
end

function RoomMap:updateBoundUI(arg_123_1)
	if not var_0_33[self.curRoomId].arrowsImg then
		return
	end

	local var_123_0 = {}

	for iter_123_0, iter_123_1 in pairs(var_0_33[self.curRoomId].arrowsImg) do
		var_123_0[iter_123_1] = var_123_0[iter_123_1] or {}

		table.insert(var_123_0[iter_123_1], iter_123_0)
	end

	for iter_123_2 = 1, 4 do
		if self.roomPathTree[self.curMapConfig.curRoomOrder].nexts[iter_123_2] and var_123_0[iter_123_2] then
			local var_123_1
			local var_123_3

			if self:checkBoundIsLock(iter_123_2) and not self.root.isBridgeAction then
				var_123_1 = var_0_55[iter_123_2][2]
				var_123_3 = false
			else
				var_123_1 = var_0_55[iter_123_2][1]
				var_123_3 = true
			end

			local var_123_4
			local var_123_5

			if iter_123_2 == 1 then
				var_123_4 = cc.p(0, -20)
				var_123_5 = cc.p(0, 20)
			elseif iter_123_2 == 2 then
				var_123_4 = cc.p(-20, 0)
				var_123_5 = cc.p(20, 0)
			elseif iter_123_2 == 3 then
				var_123_4 = cc.p(0, 20)
				var_123_5 = cc.p(0, -20)
			elseif iter_123_2 == 4 then
				var_123_4 = cc.p(20, 0)
				var_123_5 = cc.p(-20, 0)
			end

			for iter_123_3, iter_123_4 in pairs(var_123_0[iter_123_2]) do
				local var_123_6 = self.maskPanel:getChildByName("arrow" .. iter_123_4)

				if var_123_6 then
					var_123_6:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
						var_123_6:loadTexture(var_123_1, var_0_1)

						if var_123_6.is_action ~= var_123_3 then
							if var_123_3 then
								self.root.isBridgeAction = nil

								var_123_6:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.15, var_123_4), cc.MoveBy:create(0.15, var_123_5), cc.MoveBy:create(0.15, var_123_4), cc.MoveBy:create(0.15, var_123_5), cc.DelayTime:create(1))))
							else
								var_123_6:stopAllActions()
							end
						end
					end), cc.FadeIn:create(0.5)))
				else
					local var_123_7 = self:transform_index_pos_coordinate(iter_123_4, "index")

					var_123_6 = ccui.ImageView:create(var_123_1, var_0_1)

					var_123_6:setAnchorPoint(cc.p(0, 0))
					var_123_6:setName("arrow" .. iter_123_4)
					var_123_6:setPosition(var_123_7.x, var_123_7.y)

					if var_123_3 then
						var_123_6.is_action = var_123_3

						var_123_6:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.15, var_123_4), cc.MoveBy:create(0.15, var_123_5), cc.MoveBy:create(0.15, var_123_4), cc.MoveBy:create(0.15, var_123_5), cc.DelayTime:create(1))))
					end

					self.maskPanel:addChild(var_123_6)
				end
			end
		end
	end
end

function RoomMap:initCameraPos()
	local var_125_0 = self:getContentSize().width * var_0_67 - self.root.mapView:getContentSize().width
	local var_125_1 = self:getContentSize().height * var_0_67 - self.root.mapView:getContentSize().height
	local var_125_2 = self.curCoordinate.x * var_0_67 - self.root.mapView:getContentSize().width / 2
	local var_125_3 = self.curCoordinate.y * var_0_67 - self.root.mapView:getContentSize().height / 2

	if var_125_0 < var_125_2 then
		var_125_2 = var_125_0
	elseif var_125_2 < 0 then
		var_125_2 = 0
	end

	if var_125_1 < var_125_3 then
		var_125_3 = var_125_1
	elseif var_125_3 < 0 then
		var_125_3 = 0
	end

	self.root.mapView:getInnerContainer():runAction(cc.MoveTo:create(var_0_69, cc.p(-var_125_2, -var_125_3)))
end

function RoomMap:getFirstSize()
	return cc.size(self.room_width < self.root.mapView:getContentSize().width / var_0_67 and self.root.mapView:getContentSize().width / var_0_67 or self.room_width, self.room_height < self.root.mapView:getContentSize().height / var_0_67 and self.root.mapView:getContentSize().height / var_0_67 or self.room_height)
end

local var_0_72 = {
	function(arg_127_0, arg_127_1)
		return 0
	end,
	function(arg_128_0, arg_128_1)
		return (arg_128_0 - arg_128_1) / 2
	end,
	function(arg_129_0, arg_129_1)
		return arg_129_0 - arg_129_1
	end
}

function RoomMap:getFirstPos()
	local var_130_0 = 1

	if self.direction then
		var_130_0 = self:getCurAlignment(self.curRoomOrder, self.root.curRoomMap.curRoomOrder)
	end

	if self.direction then
		local var_130_1
		local var_130_2

		if self.direction == var_0_41 then
			var_130_1 = var_0_72[var_130_0](self.root.mapView:getInnerContainerSize().width, self:getContentSize().width)
			var_130_2 = self.root.mapView:getInnerContainerSize().height
		elseif self.direction == var_0_42 then
			var_130_1 = self.root.mapView:getInnerContainerSize().width
			var_130_2 = var_0_72[var_130_0](self.root.mapView:getInnerContainerSize().height, self:getContentSize().height)
		elseif self.direction == var_0_43 then
			var_130_1 = var_0_72[var_130_0](self.root.mapView:getInnerContainerSize().width, self:getContentSize().width)
			var_130_2 = -self.room_height
		elseif self.direction == var_0_44 then
			var_130_1 = -self.room_width
			var_130_2 = var_0_72[var_130_0](self.root.mapView:getInnerContainerSize().height, self:getContentSize().height)
		elseif self.direction == var_0_48 then
			var_130_1 = self.root.mapView:getInnerContainerSize().width
			var_130_2 = self.root.mapView:getInnerContainerSize().height
		elseif self.direction == var_0_47 then
			var_130_1 = self.root.mapView:getInnerContainerSize().width
			var_130_2 = -self:getContentSize().width
		elseif self.direction == var_0_46 then
			var_130_1 = -self:getContentSize().width
			var_130_2 = -self:getContentSize().height
		elseif self.direction == var_0_45 then
			var_130_1 = -self:getContentSize().width
			var_130_2 = self.root.mapView:getInnerContainerSize().height
		end

		return var_130_1, var_130_2
	else
		return 0, 0
	end
end

function RoomMap:go_in_action(arg_131_1)
	self:runAction(cc.Sequence:create(cc.MoveTo:create(var_0_69, cc.p(0, 0)), cc.CallFunc:create(function()
		if self.roomfollowholeConfig and next(self.roomfollowholeConfig) then
			-- block empty
		end
	end), cc.CallFunc:create(function()
		if arg_131_1 then
			arg_131_1()
		end
	end)))
	self:mainRoleEnterAction(0.1)
end

function RoomMap:go_out_action(arg_134_1, arg_134_2)
	local var_134_0 = self:getCurAlignment(self.curRoomOrder, self.root.curRoomMap.curRoomOrder)

	self:stopAllActions()
	self.tag:setVisible(false)
	self:runAction(cc.Sequence:create(({
		[var_0_41] = cc.MoveBy:create(var_0_69, cc.p(var_0_72[var_134_0](self.root.curRoomMap:getContentSize().width, self:getContentSize().width), -self:getContentSize().height)),
		[var_0_42] = cc.MoveBy:create(var_0_69, cc.p(-self:getContentSize().width, var_0_72[var_134_0](self.root.curRoomMap:getContentSize().height, self:getContentSize().height))),
		[var_0_43] = cc.MoveBy:create(var_0_69, cc.p(var_0_72[var_134_0](self.root.curRoomMap:getContentSize().width, self:getContentSize().width), self.root.curRoomMap:getContentSize().height)),
		[var_0_44] = cc.MoveBy:create(var_0_69, cc.p(self.root.curRoomMap:getContentSize().width, var_0_72[var_134_0](self.root.curRoomMap:getContentSize().height, self:getContentSize().height))),
		[var_0_45] = cc.MoveBy:create(var_0_69, cc.p(self:getContentSize().width, -self:getContentSize().height)),
		[var_0_46] = cc.MoveBy:create(var_0_69, cc.p(self:getContentSize().width, self.root.curRoomMap:getContentSize().height)),
		[var_0_47] = cc.MoveBy:create(var_0_69, cc.p(-self.root.curRoomMap:getContentSize().width, self.root.curRoomMap:getContentSize().height)),
		[var_0_48] = cc.MoveBy:create(var_0_69, cc.p(-self.root.curRoomMap:getContentSize().width, -self:getContentSize().height))
	})[arg_134_1], cc.Hide:create(), cc.RemoveSelf:create(), cc.CallFunc:create(function()
		if arg_134_2 then
			arg_134_2()
		end
	end)))

	if self.mask then
		self.darkLayout:setVisible(true)
	end
end

function RoomMap:getCurAlignment(arg_136_1, arg_136_2)
	return self.alignmentType[explore_manager:getBridgeOrder(arg_136_1 .. "-" .. arg_136_2)] or 1
end

function RoomMap:transform_index_pos_coordinate(arg_137_1, arg_137_2)
	if arg_137_2 == "index" then
		local var_137_0 = math.floor((arg_137_1 - 1) / self.room_width_num) + 1

		return {
			index = arg_137_1,
			order_x = (arg_137_1 - 1) % self.room_width_num + 1,
			order_y = var_137_0,
			x = ((arg_137_1 - 1) % self.room_width_num + 1 - (self.room_width_num + 1) / 2) * var_0_68 + self:getContentSize().width / 2 - var_0_68 / 2,
			y = (var_137_0 - (self.room_height_num + 1) / 2) * var_0_68 + self:getContentSize().height / 2 - var_0_68 / 2
		}
	elseif arg_137_2 == "pos" then
		return {
			index = (arg_137_1.y - 1) * self.room_width_num + arg_137_1.x,
			order_x = arg_137_1.x,
			order_y = arg_137_1.y,
			x = (arg_137_1.x - (self.room_width_num + 1) / 2) * var_0_68 + self:getContentSize().width / 2 - var_0_68 / 2,
			y = (arg_137_1.y - (self.room_height_num + 1) / 2) * var_0_68 + self:getContentSize().height / 2 - var_0_68 / 2
		}
	elseif arg_137_2 == "coordinate" then
		if arg_137_1.x < self.roomBound.x_min or arg_137_1.x > self.roomBound.x_max or arg_137_1.y < self.roomBound.y_min or arg_137_1.y > self.roomBound.y_max then
			local var_137_1
			local var_137_2

			var_137_1 = arg_137_1.x < self.roomBound.x_min and self.roomBound.x_min - (math.floor((self.roomBound.x_min - arg_137_1.x) / var_0_68) + 1) * var_0_68 or arg_137_1.x > self.roomBound.x_max and self.roomBound.x_max + (math.floor((arg_137_1.x - self.roomBound.x_max) / var_0_68) + 1) * var_0_68 or (math.floor((arg_137_1.x - self.roomBound.x_min) / var_0_68) + 1 - (self.room_width_num + 1) / 2) * var_0_68 + self:getContentSize().width / 2 - var_0_68
			var_137_2 = arg_137_1.y < self.roomBound.y_min and self.roomBound.y_min - (math.floor((self.roomBound.y_min - arg_137_1.y) / var_0_68) + 1) * var_0_68 or arg_137_1.y > self.roomBound.y_max and self.roomBound.y_max + (math.floor((arg_137_1.y - self.roomBound.y_max) / var_0_68) + 1) * var_0_68 or (math.floor((arg_137_1.y - self.roomBound.y_min) / var_0_68) + 1 - (self.room_height_num + 1) / 2) * var_0_68 + self:getContentSize().height / 2 - var_0_68

			return {
				x = var_137_1,
				y = var_137_2,
				index = tonumber(var_137_1 .. var_137_2)
			}
		else
			local var_137_5 = math.floor((arg_137_1.x - self.roomBound.x_min) / var_0_68) + 1
			local var_137_6 = math.floor((arg_137_1.y - self.roomBound.y_min) / var_0_68) + 1

			return {
				index = (var_137_6 - 1) * self.room_width_num + var_137_5,
				order_x = var_137_5,
				order_y = var_137_6,
				x = (var_137_5 - (self.room_width_num + 1) / 2) * var_0_68 + self:getContentSize().width / 2 - var_0_68 / 2,
				y = (var_137_6 - (self.room_height_num + 1) / 2) * var_0_68 + self:getContentSize().height / 2 - var_0_68 / 2
			}
		end
	end
end

function RoomMap:transform_map_camera(arg_138_1, arg_138_2)
	local var_138_0, var_138_1 = self.root.mapView:getInnerContainer():getPosition()
	local var_138_2, var_138_3 = self.root.mapView:getInnerContainer():getContentSize()

	if arg_138_2 == "map_to_camera" then
		return arg_138_1.x + var_138_0, arg_138_1.y + var_138_1
	elseif arg_138_2 == "camera_to_map" then
		return arg_138_1.x - var_138_0, arg_138_1.y - var_138_1
	end
end

function RoomMap:getChangeEnvAni(arg_139_1, arg_139_2)
	if arg_139_1 == 1 and arg_139_2 == 2 then
		return "xiashui", "run"
	elseif arg_139_1 == 2 and arg_139_2 == 1 then
		return "shangshui", "run"
	elseif arg_139_1 == 3 and arg_139_2 == 1 then
		return "run", "idle"
	elseif arg_139_1 == 1 and arg_139_2 == 3 then
		return "idle", "noAni"
	end
end

function RoomMap:isEnvRedayByCurSkin(arg_140_1)
	if not self.curMapConfig.array[self.tag.arrayorder] then
		return false
	end

	local var_140_0 = explore_manager:getCurArraySkin(self.curMapConfig.array[self.tag.arrayorder])

	if var_140_0 and var_140_0 == major_factor_data[servant_data[self.curMapConfig.array[self.tag.arrayorder].fight_girl].major][({
		[var_0_56] = "swim_suit"
	})[arg_140_1]] then
		return true
	else
		return false
	end
end

function RoomMap:isEnvCanPass(arg_141_1)
	if ({
		[var_0_57] = true
	})[arg_141_1] then
		return true
	else
		return false
	end
end

function RoomMap:playChangeEnvAni()
	local var_142_0 = self.mapEnvs[self.curPosIndex] or 1

	if var_142_0 ~= self.curMapEnv and (function(arg_143_0)
		if arg_143_0 == var_0_56 then
			return self:isEnvRedayByCurSkin(arg_143_0)
		else
			return true
		end
	end)(var_142_0, self.curMapEnv) then
		local var_142_1, var_142_2 = self:getChangeEnvAni(self.curMapEnv, var_142_0)

		if self:isEnvCanPass(var_142_0) == false then
			self:playAni(var_142_1, function()
				self:playAni(var_142_2)
			end)
		end

		self.curMapEnv = var_142_0
	end
end

function RoomMap:updateCurPosInfo()
	self.curPosIndex = self.curMapConfig.curPosIndex

	local var_145_0 = math.floor((self.curPosIndex - 1) / self.room_width_num) + 1

	self.curPos = cc.p((self.curPosIndex - 1) % self.room_width_num + 1, var_145_0)
	self.curCoordinate = cc.p(((self.curPosIndex - 1) % self.room_width_num + 1 - (self.room_width_num + 1) / 2) * var_0_68 + self:getContentSize().width / 2, (var_145_0 - (self.room_height_num + 1) / 2) * var_0_68 + self:getContentSize().height / 2)
end

function RoomMap:randomRole(arg_146_1)
	if not self.curMapConfig.array then
		return
	end

	local var_146_0 = {}

	if arg_146_1 then
		local var_146_3

		for iter_146_0 = 1, 4 do
			if self.curMapConfig.array[iter_146_0] and self.curMapConfig.array[iter_146_0].fight_girl then
				var_146_3 = iter_146_0

				break
			end
		end

		local var_146_6 = self.curMapConfig.change_role_modelid
		local var_146_9
		local var_146_7
		local var_146_10
		local var_146_8

		if not self.curMapConfig.change_role_modelid then
			var_146_6 = explore_manager:getCurArrayModel(self.curMapConfig.array[var_146_3])
			var_146_7 = model_data[var_146_6].clothes_model
			var_146_8 = var_0_66 * (model_data[var_146_6].modelscale > 1.3 and 1.3 or model_data[var_146_6].modelscale)
			var_146_9 = cc.size(model_data[var_146_6].modelweight, model_data[var_146_6].modelheight)
			var_146_10 = {
				jsonFilePath = ROLE_SPINE_PATH .. model_data[var_146_6].spine_model .. ".json"
			}
		end

		var_146_10.atlasFilePath = ROLE_SPINE_PATH .. model_data[var_146_6].spine_model .. ".atlas"

		if var_146_7 then
			var_146_10.clothesFilePath = CLOTHES_SPINE_PATH .. var_146_7 .. ".atlas" or nil
		end

		var_146_10.scale = var_146_8
		var_146_10.size = var_146_9
		var_146_10.modelid = var_146_6
		var_146_10.arrayorder = var_146_3

		return var_146_10
	end

	for iter_146_1, iter_146_2 in pairs(self.curMapConfig.array) do
		if iter_146_2.fight_girl then
			var_146_0[#var_146_0 + 1] = iter_146_2.fight_girl
		end
	end

	return CUTE_ROLE_IMAGE_PATH .. model_data[servant_data[var_146_0[math.random(#var_146_0)]].modelid].cute_role .. ".png"
end

function RoomMap:initSelectedFrame()
	local var_147_0 = self:randomRole(true)

	self.tag = L2Actor:createExploreLead(var_147_0.jsonFilePath, var_147_0.atlasFilePath, var_147_0.clothesFilePath)

	self.tag:setName("tag")

	self.tag.modelid = var_147_0.modelid
	self.tag.arrayorder = var_147_0.arrayorder

	self.tag:setScale(var_147_0.scale * (self.direction == var_0_44 and -1 or 1), var_147_0.scale)

	self.tag.cur_scale = var_147_0.scale

	self.tag:setContentSize(var_147_0.size)
	self.tag:setPosition(self.curCoordinate)
	self:playAni("idle")
	self.tag.skeletonAnimation:setTimeScale(1.5)
	self.iconLayout:addChild(self.tag, (self.room_height_num - self.curPos.y + 1) * 2)

	self.SPEED = 720

	if self.roomfollowholeConfig[self.curRoomOrder] and self.mask then
		self.mask:setPosition(self:getContentSize().width * self.roomfollowholeConfig[self.curRoomOrder].scale / 2, self:getContentSize().height / 2)
		self.mask:setScale(self.roomfollowholeConfig[self.curRoomOrder].scale)

		local var_147_2 = self:convertToWorldSpace(cc.p(self.curCoordinate.x, self.curCoordinate.y + self.tag:getBoundingBox().height / 2))

		self.mask:focus(var_147_2.x, var_147_2.y)
	end

	for iter_147_0 = 1, #self.root.followQueue do
		self.root.followQueue[iter_147_0]:removeFromParent()

		if self.direction == var_0_41 then
			local var_147_3 = self:transform_index_pos_coordinate(self.curPosIndex - self.room_width_num, "index")

			self.root.followQueue[iter_147_0]:setPosition(cc.p(var_147_3.x, var_147_3.y))
			self.root.followQueue[iter_147_0]:updateNpcPosInfo(self.curPosIndex - self.room_width_num, self)
		elseif self.direction == var_0_43 then
			local var_147_4 = self:transform_index_pos_coordinate(self.curPosIndex + self.room_width_num, "index")

			self.root.followQueue[iter_147_0]:setPosition(cc.p(var_147_4.x, var_147_4.y))
			self.root.followQueue[iter_147_0]:updateNpcPosInfo(self.curPosIndex + self.room_width_num, self)
		elseif self.direction == var_0_44 then
			local var_147_5 = self:transform_index_pos_coordinate(self.curPosIndex + 1, "index")

			print("m_tbl===", dump(var_147_5), dump(self.curCoordinate))
			self.root.followQueue[iter_147_0]:setPosition(cc.p(var_147_5.x, var_147_5.y))
			self.root.followQueue[iter_147_0]:updateNpcPosInfo(self.curPosIndex + 1, self)
		elseif self.direction == var_0_42 then
			local var_147_6 = self:transform_index_pos_coordinate(self.curPosIndex - 1, "index")

			self.root.followQueue[iter_147_0]:setPosition(cc.p(var_147_6.x, var_147_6.y))
			self.root.followQueue[iter_147_0]:updateNpcPosInfo(self.curPosIndex - 1, self)
		else
			local var_147_7 = self:transform_index_pos_coordinate(self.curPosIndex, "index")

			self.root.followQueue[iter_147_0]:setPosition(cc.p(var_147_7.x, var_147_7.y))
			self.root.followQueue[iter_147_0]:updateNpcPosInfo(self.curPosIndex, self)
		end

		self.root.followQueue[iter_147_0]:playAni(nil, "idle", true)
		self.iconLayout:addChild(self.root.followQueue[iter_147_0], (self.room_height_num - 3 + 1) * 2)
	end
end

function RoomMap:popTalkSp(arg_148_1, arg_148_2, arg_148_3)
	require("view.Sprite.TalkSprite")

	arg_148_1 = arg_148_1 or "Hello World"

	if self.tag:getChildByName("pop_talk") then
		self.tag:getChildByName("pop_talk"):updateString(arg_148_1, arg_148_3, arg_148_2)
	else
		local var_148_0 = TalkSprite:create(arg_148_1, 120, nil, arg_148_3, arg_148_2)

		var_148_0:setName("pop_talk")
		self.tag:addChild(var_148_0)
	end

	if self.roomBound.x_max - self.tag:getPositionX() <= 150 then
		self.tag:getChildByName("pop_talk"):setAnchorPoint(cc.p(0.75, self.tag:getChildByName("pop_talk"):getAnchorPoint().y))
		self.tag:getChildByName("pop_talk"):setArrowPositionX(self.tag:getChildByName("pop_talk"):getContentSize().width / 4 + 125)
	end
end

function RoomMap:updateSelectedFrame(arg_149_1)
	if not self.curMapConfig.array then
		return
	end

	if not self.curMapConfig.array[arg_149_1] then
		return
	end

	local var_149_2 = explore_manager:getCurArraySkin(self.curMapConfig.array[arg_149_1])
	local var_149_3 = explore_manager:getCurArrayModel(self.curMapConfig.array[arg_149_1])
	local var_149_4

	if model_data[var_149_3].clothes_model then
		var_149_4 = CLOTHES_SPINE_PATH .. model_data[var_149_3].clothes_model .. ".atlas" or nil
	end

	local var_149_5 = var_0_66 * (model_data[var_149_3].modelscale > 1.3 and 1.3 or model_data[var_149_3].modelscale)

	self.tag:updateSpine(ROLE_SPINE_PATH .. model_data[var_149_3].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_149_3].spine_model .. ".atlas", var_149_4)
	self.tag:setScale(var_149_5, var_149_5)
	self.tag:setContentSize((cc.size(model_data[var_149_3].modelweight, model_data[var_149_3].modelheight)))
	self.tag:playAni(nil, self.tag.aniName, true)

	self.tag.modelid = var_149_3
	self.tag.arrayorder = arg_149_1

	explore_manager:setModelId(var_149_3)
end

function RoomMap:mainRoleEnterAction(arg_150_1)
	if not self.direction then
		return
	end

	arg_150_1 = arg_150_1 or 0

	if self.direction == var_0_41 then
		self.tag:setPositionY(self.curCoordinate.y - var_0_68 * 1.5)
	elseif self.direction == var_0_43 then
		self.tag:setPositionY(self.curCoordinate.y + var_0_68 * 1.5)
	elseif self.direction == var_0_44 then
		self.tag:setPositionX(self.curCoordinate.x + var_0_68 * 1.5)
	elseif self.direction == var_0_42 then
		self.tag:setPositionX(self.curCoordinate.x - var_0_68 * 1.5)
	end

	self:playAni("run")
	self.tag:runAction(cc.Sequence:create(cc.DelayTime:create(arg_150_1), cc.MoveTo:create(var_0_69, self.curCoordinate), cc.CallFunc:create(function()
		self:playAni("idle")

		if self.roomfollowholeConfig and next(self.roomfollowholeConfig) then
			audio_manager:playeffectMusicTest("sound/bat_transition")
		end
	end)))
end

function RoomMap:getIcePath()
	local var_152_0 = self.curPosIndex
	local var_152_1 = {}

	if self.curPosIndex - self.prePosIndex == 1 then
		while not self.objectRange[var_152_0] and not self.mapBlock[var_152_0] and self.mapEnvs[var_152_0] == var_0_57 do
			table.insert(var_152_1, var_152_0)

			var_152_0 = var_152_0 + 1
		end
	elseif self.curPosIndex - self.prePosIndex == -1 then
		while not self.objectRange[var_152_0] and not self.mapBlock[var_152_0] and self.mapEnvs[var_152_0] == var_0_57 do
			table.insert(var_152_1, var_152_0)

			var_152_0 = var_152_0 - 1
		end
	elseif self.curPosIndex - self.prePosIndex > 1 then
		while not self.objectRange[var_152_0] and not self.mapBlock[var_152_0] and self.mapEnvs[var_152_0] == var_0_57 do
			table.insert(var_152_1, var_152_0)

			var_152_0 = var_152_0 + self.room_width_num
		end
	else
		while not self.objectRange[var_152_0] and not self.mapBlock[var_152_0] and self.mapEnvs[var_152_0] == var_0_57 do
			table.insert(var_152_1, var_152_0)

			var_152_0 = var_152_0 - self.room_width_num
		end
	end

	if self.mapEnvs[var_152_0] ~= var_0_57 and not self.mapBlock[var_152_0] and var_152_0 > 0 then
		table.insert(var_152_1, var_152_0)
	end

	return var_152_1
end

function RoomMap:updateRoute()
	if (self.curMapEnv == var_0_57 or self.preEnv == var_0_57) and self.root.touchLock == false then
		self.root.touchLock = true

		local var_153_0 = self:getIcePath()

		if #var_153_0 >= 2 then
			self.SPEED = 1440
			self.actionMove = "noAni"

			self:moveSelectedFrame(var_153_0, nil, function()
				self.root.touchLock = false
				self.SPEED = 720
				self.actionMove = nil
			end)
		else
			self:moveSelectedFrame(var_153_0)

			self.root.touchLock = false
			self.SPEED = 720
		end
	end
end

function RoomMap:updateRouteWithEnv()
	if self.curMapEnv == var_0_57 or self.preEnv == var_0_57 and self.root.touchLock == false then
		self:updateRoute()
	end
end

function RoomMap:getAniNameByEnv(arg_156_1)
	if arg_156_1 == "idle" or arg_156_1 == "run" then
		if var_0_58[self.curMapEnv] then
			return var_0_58[self.curMapEnv][arg_156_1]
		end
	else
		return arg_156_1
	end
end

function RoomMap:playAni(arg_157_1, arg_157_2)
	if self.tag.aniName == "run" and arg_157_1 == "skill1" then
		self.root.touchLock = false

		return
	end

	if self.role_ani_lock then
		return
	end

	arg_157_1 = self:getAniNameByEnv(arg_157_1)

	if arg_157_1 == self.tag.aniName then
		return
	end

	if arg_157_1 == "noAni" then
		arg_157_1 = "idle"
	end

	self.tag.aniName = arg_157_1

	if arg_157_2 then
		self.tag:playAni(arg_157_2, arg_157_1, false)
	else
		self.tag:playAni(nil, arg_157_1, true)

		if arg_157_1 == var_0_58[self.curMapEnv].run then
			if not self.cur_sound_effect or self.cur_sound_effect and self.cur_sound_effect ~= var_0_59[self.curMapEnv] then
				self.cur_sound_effect = var_0_59[self.curMapEnv]

				audio_manager:stopAllEffects()
			end

			audio_manager:playeffectMusic(self.cur_sound_effect, true)
		else
			audio_manager:stopAllEffects()
		end
	end

	if arg_157_1 == "run" then
		self.tag.skeletonAnimation:setTimeScale(1)
	elseif arg_157_1 == "idle" then
		self.tag.skeletonAnimation:setTimeScale(0.8)
	else
		self.tag.skeletonAnimation:setTimeScale(1)
	end
end

function RoomMap:initTouchMark()
	self.touchMark = ccui.ImageView:create("explore/touch_mark1.png", var_0_1)

	self.touchMark:setAnchorPoint(cc.p(0, 0))
	self.touchMark:setVisible(false)
	self.iconLayout:addChild(self.touchMark, 999)

	local var_158_0 = ccui.ImageView:create("explore/touch_mark2.png", var_0_1)

	var_158_0:setName("mark2")
	var_158_0:setPosition(self.touchMark:getContentSize().width / 2, self.touchMark:getContentSize().height / 2)
	self.touchMark:addChild(var_158_0)
end

function RoomMap:setTouchMarkPos(arg_159_1, arg_159_2, arg_159_3, arg_159_4, arg_159_5)
	self.touchMark:stopAllActions()
	self.touchMark:setVisible(true)
	self.touchMark:setOpacity(255)
	self.touchMark:getChildByName("mark2"):stopAllActions()
	self.touchMark:getChildByName("mark2"):setOpacity(0)
	self.touchMark:getChildByName("mark2"):setScale(1)
	self.touchMark:setPosition(arg_159_1)

	if arg_159_2 > 0 then
		self.touchMark:loadTexture("explore/touch_mark1.png", var_0_1)
		self.touchMark:getChildByName("mark2"):loadTexture("explore/touch_mark2.png", var_0_1)
	else
		self.touchMark:loadTexture("explore/no_touch_mark1.png", var_0_1)
		self.touchMark:getChildByName("mark2"):loadTexture("explore/no_touch_mark2.png", var_0_1)
	end

	self.touchMark.flag = arg_159_2
	self.touchMark.path = arg_159_3
	self.touchMark.curIndex = arg_159_4
	self.touchMark.targetIndex = arg_159_5
end

function RoomMap:playTouchMarkAction()
	if not self.touchMark then
		return
	end

	local var_160_0 = self.touchMark:getChildByName("mark2")

	self.touchMark:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.FadeOut:create(0.2)))
	var_160_0:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.3), cc.ScaleTo:create(0.3, 1.1)), cc.ScaleTo:create(0.2, 1)))

	if self.touchMark.flag == 2 then
		if self.touchMark.curIndex and self.touchMark.curIndex ~= self.curPosIndex then
			local var_160_1 = self:findRoad(self.touchMark.targetIndex)

			if var_160_1 then
				return 2, var_160_1
			else
				return -3
			end
		else
			return self.touchMark.flag, self.touchMark.path
		end
	else
		print("self.touchMark.flag, self.touchMark.path222", self.touchMark.flag, dump(self.touchMark.path))

		return self.touchMark.flag, self.touchMark.path
	end
end

function RoomMap:createTileObject(arg_161_1, arg_161_2, arg_161_3, arg_161_4)
	local var_161_0 = {
		tileInfo = arg_161_1,
		idx = arg_161_2,
		order = arg_161_3,
		pos = arg_161_4,
		zOrder = (self.room_height_num - self:transform_index_pos_coordinate(arg_161_3, "index").order_y + 1) * 2 - 1,
		parent = self,
		fullImage = var_0_32[self.curMapId].fullImage,
		size_num = cc.size(explore_manager:getTileSize(arg_161_1.id))
	}
	local var_161_1 = {
		[TILE_TYPE.NORMAL_ENEMY] = function()
			return require("view.Sprite.explore.MonsterTile"):create(var_161_0)
		end,
		[TILE_TYPE.SPECIAL_ENEMY] = function()
			return require("view.Sprite.explore.MonsterTile"):create(var_161_0)
		end,
		[TILE_TYPE.NPC] = function()
			return require("view.Sprite.explore.NpcTile"):create(var_161_0)
		end,
		[TILE_TYPE.DES_WALL] = function()
			return require("view.Sprite.explore.DesWallTile"):create(var_161_0)
		end,
		[TILE_TYPE.POKEMON] = function()
			return require("view.Sprite.explore.PokemonTile"):create(var_161_0)
		end,
		[TILE_TYPE.NPCFOLLOW] = function()
			return require("view.Sprite.explore.NpcfollowTile"):create(var_161_0)
		end,
		[TILE_TYPE.STATEPROCESS] = function()
			return require("view.Sprite.explore.StateProceTile"):create(var_161_0)
		end,
		[TILE_TYPE.ANIMATION] = function()
			return require("view.Sprite.explore.aniTile"):create(var_161_0)
		end,
		[TILE_TYPE.CRACKLE] = function()
			return require("view.Sprite.explore.CrackleTile"):create(var_161_0)
		end,
		[TILE_TYPE.CRACKLE_DOOR] = function()
			return require("view.Sprite.explore.crackleDoorTile"):create(var_161_0)
		end,
		[TILE_TYPE.PASSWORD] = function()
			return require("view.Sprite.explore.PasswordTile"):create(var_161_0)
		end,
		[TILE_TYPE.STORY_ENEMY] = function()
			return require("view.Sprite.explore.storyMonsterTile"):create(var_161_0)
		end,
		[TILE_TYPE.MEMORY_CARD] = function()
			return require("view.Sprite.explore.memoryCardTile"):create(var_161_0)
		end,
		[TILE_TYPE.SELECT_TALK] = function()
			return require("view.Sprite.explore.TalkTile"):create(var_161_0)
		end
	}

	setmetatable(var_161_1, {
		__index = function()
			return function()
				return require("view.Sprite.explore.TileSprite"):create(var_161_0)
			end
		end,
		__call = function(self, arg_178_1)
			return self[arg_178_1]()
		end
	})

	return var_161_1(arg_161_1.class)
end

function RoomMap:genMap()
	(function()
		for iter_181_0 = 1, self.room_width_num * self.room_height_num do
			local var_181_0 = self:transform_index_pos_coordinate(iter_181_0, "index")
			local var_181_2 = {}

			for iter_181_1, iter_181_2 in pairs(var_0_34[self.curRoomInfo.imglayer][iter_181_0]) do
				iter_181_2, transform_type = explore_manager:decodeImgid(iter_181_2)

				if type(iter_181_1) == "number" or type(iter_181_1) == "string" and not self.replaceModel[iter_181_0] then
					iter_181_1 = type(iter_181_1) == "number" and iter_181_1 or var_0_34[self.curRoomInfo.imglayer].max_zorder

					table.insert(var_181_2, {
						img = iter_181_2,
						z_order = iter_181_1,
						transform_type = transform_type
					})
				end
			end

			if explore_manager.curMapConfig.finishImgs[self.curRoomInfo.imglayer] and explore_manager.curMapConfig.finishImgs[self.curRoomInfo.imglayer][iter_181_0] then
				table.insert(var_181_2, 1, {
					img = explore_manager.curMapConfig.finishImgs[self.curRoomInfo.imglayer][iter_181_0],
					z_order = var_0_34[self.curRoomInfo.imglayer].max_zorder
				})
			end

			table.sort(var_181_2, function(arg_182_0, arg_182_1)
				return arg_182_0.z_order > arg_182_1.z_order
			end)

			if self.curRoomInfo.doorsImg[iter_181_0] and not self.pathTree.nexts[self.curRoomInfo.doorsImg[iter_181_0].direction] then
				imgid, transform_type = explore_manager:decodeImgid(self.curRoomInfo.doorsImg[iter_181_0].img)

				if self.curRoomInfo.doorsImg[iter_181_0].is_replace then
					var_181_2[1].img = imgid
					var_181_2[1].transform_type = transform_type
				else
					table.insert(var_181_2, 1, {
						img = imgid,
						z_order = var_181_2[1].z_order + 1,
						transform_type = transform_type
					})
				end
			end

			for iter_181_3 = #var_181_2, 1, -1 do
				local var_181_3 = cc.Sprite:createWithSpriteFrameName("tiles_" .. var_0_32[self.curMapId].fullImage .. "/" .. var_181_2[iter_181_3].img .. ".png")

				var_181_3:setPosition(var_181_0.x + var_181_3:getContentSize().width / 2, var_181_0.y + var_181_3:getContentSize().height / 2)
				var_179_2(var_181_3, var_181_2[iter_181_3].transform_type)

				if explore_img_data[var_181_2[iter_181_3].img].is_big_icon then
					self.iconLayout:addChild(var_181_3, (self.room_height_num - var_181_0.order_y + 1) * 2 - 1)
				else
					self.batchNodeLayout:addChild(var_181_3, (self.room_height_num - var_181_0.order_y + 1) * 2 - 1)
				end
			end
		end
	end)()
	;(function()
		for iter_183_0, iter_183_1 in pairs(self.usedTile) do
			local var_183_0 = self:transform_index_pos_coordinate(iter_183_1.order, "index")

			self.tileobjects[iter_183_0] = self:createTileObject(var_0_35[iter_183_1.tileid], iter_183_0, var_183_0.index, cc.p(var_183_0.x, var_183_0.y))
		end
	end)()
	;(function()
		if not self.roomLight then
			return
		end

		for iter_184_0, iter_184_1 in pairs(self.roomLight) do
			local var_184_0

			if config._DEBUG then
				var_184_0 = cc.Sprite:create("explore/" .. iter_184_1.light .. ".png") or cc.Sprite:createWithSpriteFrameName("explore/" .. iter_184_1.light .. ".png")
			end

			local var_184_1 = self:transform_index_pos_coordinate(iter_184_1.light_pos, "pos")

			var_184_0:setPosition(var_184_1.x + var_0_68 / 2 + iter_184_1.light_offset.x, var_184_1.y + var_0_68 / 2 + iter_184_1.light_offset.y)
			var_184_0:setScale(iter_184_1.light_scale)
			var_184_0:setOpacity(255 * iter_184_1.light_opacity)
			var_184_0:setBlendFunc(GL_SRC_COLOR, GL_ONE)
			self.iconLayout:addChild(var_184_0, 99)
		end
	end)()
end

function RoomMap:updateRangeModel(arg_185_1)
	if not self.rangeModel.center[arg_185_1] then
		return
	end

	local function var_185_0(arg_186_0)
		if self.maskPanel:getChildByName("maskPanel" .. arg_186_0) then
			self.maskPanel:getChildByName("maskPanel" .. arg_186_0):removeFromParent()
		end
	end

	for iter_185_0, iter_185_1 in pairs(self.rangeModel.center[arg_185_1]) do
		for iter_185_2, iter_185_3 in pairs(self.rangeModel.range[iter_185_1]) do
			if iter_185_3 == arg_185_1 then
				table.remove(self.rangeModel.range[iter_185_1], iter_185_2)
			end
		end

		if next(self.rangeModel.range[iter_185_1]) == nil then
			self.rangeModel.range[iter_185_1] = nil
		end
	end

	self.rangeModel.center[arg_185_1] = nil

	var_185_0(arg_185_1)
end

function RoomMap:registerTouchEvent()
	listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(true)
	listener:registerScriptHandler(function(arg_188_0, arg_188_1)
		if self.root.touchLock then
			return false
		end

		local var_188_0 = self:convertToNodeSpace(arg_188_0:getLocation())

		if cc.rectContainsPoint(cc.rect(self.root.mapView:getPositionX(), GameDisplay.fix_y + self.root.mapView:getPositionY(), self.root.mapView:getContentSize().width, self.root.mapView:getContentSize().height), arg_188_0:getLocation()) then
			local var_188_1 = self:transform_index_pos_coordinate(var_188_0, "coordinate")

			self:setTouchMarkPos(cc.p(var_188_1.x, var_188_1.y), self:getTouchResult(var_188_0))

			return true
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(function(arg_189_0, arg_189_1)
		local var_189_0 = self:convertToNodeSpace(arg_189_0:getLocation())
		local var_189_1 = self:transform_index_pos_coordinate(var_189_0, "coordinate")

		if var_189_1.index ~= self:transform_index_pos_coordinate(self:convertToNodeSpace(arg_189_0:getPreviousLocation()), "coordinate").index or var_189_1.index ~= self.touchMark.targetIndex then
			self:setTouchMarkPos(cc.p(var_189_1.x, var_189_1.y), self:getTouchResult(var_189_0))
		end
	end, cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(function(arg_190_0, arg_190_1)
		local var_190_0, var_190_1 = self:playTouchMarkAction()
		local var_190_2 = self:transform_index_pos_coordinate(self:convertToNodeSpace(arg_190_0:getLocation()), "coordinate").index

		if self.touchMark.targetIndex and self.touchMark.targetIndex ~= var_190_2 then
			var_190_2 = self.touchMark.targetIndex
		end

		if var_190_0 > 0 then
			if var_190_2 == self.curPosIndex then
				if self.objectRange[var_190_2] then
					self:triggerEvent(self.objectRange[var_190_2])
				else
					self:popSwitchRole()
				end
			else
				self:updatePos(var_190_2, var_190_1)
			end
		elseif var_190_0 == -1 then
			-- block empty
		elseif var_190_0 == -2 then
			audio_manager:playeffectMusicTest(EXPLORE_INVALID)
			global_ShowBlockWords(L_EXPLOREMAP_ROOM.Room_state[2])
		elseif var_190_0 == -3 then
			global_ShowBlockWords(L_EXPLOREMAP_ROOM.Room_state[3])
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)
end

function RoomMap:getnext(arg_191_1, arg_191_2)
	local var_191_0 = self:transform_index_pos_coordinate(arg_191_1, "index")
	local var_191_1

	if arg_191_2 == var_0_41 then
		var_191_1 = arg_191_1 + self.room_width_num

		if var_191_0.order_y == self.room_height_num then
			var_191_1 = nil
		end
	elseif arg_191_2 == var_0_42 then
		var_191_1 = arg_191_1 + 1

		if var_191_0.order_x == self.room_width_num then
			var_191_1 = nil
		end
	elseif arg_191_2 == var_0_43 then
		var_191_1 = arg_191_1 - self.room_width_num

		if var_191_0.order_y == 1 then
			var_191_1 = nil
		end
	elseif arg_191_2 == var_0_44 then
		var_191_1 = arg_191_1 - 1

		if var_191_0.order_x == 1 then
			var_191_1 = nil
		end
	end

	return var_191_1
end

function RoomMap:isImgMapBlock(arg_192_1)
	if self.mapEnvs[arg_192_1] then
		if self:isEnvRedayByCurSkin(self.mapEnvs[arg_192_1]) or self:isEnvCanPass(self.mapEnvs[arg_192_1]) then
			return not not self.mapBlock[arg_192_1]
		else
			return true
		end
	elseif self.mapBlock[arg_192_1] then
		return true
	else
		return false
	end
end

function RoomMap:isTileCanPass(arg_193_1)
	if self.monsterRange[arg_193_1] then
		return false
	elseif self.objectRange[arg_193_1] then
		return self.tileobjects[self.objectRange[arg_193_1]]:isTileCanPass() and not self:isImgMapBlock(arg_193_1)
	elseif self:checkIsBound(arg_193_1) then
		return false
	else
		return not self:isImgMapBlock(arg_193_1)
	end
end

function RoomMap:checkIsBound(arg_194_1)
	local var_194_0 = self:transform_index_pos_coordinate(arg_194_1, "index")

	if (var_194_0.order_x == 1 or var_194_0.order_x == self.room_width_num) and (var_194_0.order_y == 1 or var_194_0.order_y == self.room_height_num) then
		return false
	end

	if var_194_0.order_x == 1 and self.pathTree.nexts[var_0_44] then
		return true, var_0_44
	elseif var_194_0.order_x == self.room_width_num and self.pathTree.nexts[var_0_42] then
		return true, var_0_42
	elseif var_194_0.order_y == 1 and self.pathTree.nexts[var_0_43] then
		return true, var_0_43
	elseif var_194_0.order_y == self.room_height_num and self.pathTree.nexts[var_0_41] then
		return true, var_0_41
	end

	return false
end

function RoomMap:checkBoundIsLock(arg_195_1)
	local var_195_0 = math.floor((self.curRoomOrder - 1) / self.curMapSize.width) + 1

	if self.pathTree.nexts[arg_195_1] then
		local var_195_1

		if arg_195_1 == var_0_41 then
			var_195_1 = (var_195_0 - 1) * (self.curMapSize.width - 1) + (var_195_0 - 1 - 1) * self.curMapSize.width + ((self.curRoomOrder - 1) % self.curMapSize.width + 1)
		elseif arg_195_1 == var_0_43 then
			var_195_1 = var_195_0 * (self.curMapSize.width - 1) + (var_195_0 - 1) * self.curMapSize.width + ((self.curRoomOrder - 1) % self.curMapSize.width + 1)
		elseif arg_195_1 == var_0_44 then
			var_195_1 = (var_195_0 - 1) * (self.curMapSize.width - 1 + self.curMapSize.width) + ((self.curRoomOrder - 1) % self.curMapSize.width + 1) - 1
		elseif arg_195_1 == var_0_42 then
			var_195_1 = (var_195_0 - 1) * (self.curMapSize.width - 1 + self.curMapSize.width) + ((self.curRoomOrder - 1) % self.curMapSize.width + 1)
		end

		if self.bridgeLocks[var_195_1] then
			return true, self.bridgeLocks[var_195_1]
		elseif self.root.isBridgeAction and self.root.isBridgeAction == var_195_1 then
			return true, {
				tileid = self.root.isBridgeAction
			}
		end
	end
end

function RoomMap:getTouchResult(arg_196_1)
	if arg_196_1.x < self.roomBound.x_min or arg_196_1.x > self.roomBound.x_max or arg_196_1.y < self.roomBound.y_min or arg_196_1.y > self.roomBound.y_max then
		return -1
	end

	local var_196_0 = self:transform_index_pos_coordinate(arg_196_1, "coordinate")
	local var_196_1 = var_196_0.index

	if var_196_0.index == self.curPosIndex then
		return 1
	end

	if (var_196_0.order_x == 1 or var_196_0.order_x == self.room_width_num) and (var_196_0.order_y == 1 or var_196_0.order_y == self.room_height_num) then
		return -1
	end

	if not self.objectRange[var_196_1] and self:isImgMapBlock(var_196_1) then
		return -1
	end

	if (function(arg_197_0)
		if self.monsterRange[arg_197_0] then
			return false
		end

		if self.objectRange[arg_197_0] then
			if explore_manager:objectIsMonster(self.usedTile[self.objectRange[arg_197_0]].tileid) and self.tileobjects[self.objectRange[arg_197_0]].order == arg_197_0 then
				return false
			end

			local var_197_0 = self.tileobjects[self.objectRange[arg_197_0]].size_num.width
			local var_197_1 = self.tileobjects[self.objectRange[arg_197_0]].size_num.height
			local var_197_2 = self:transform_index_pos_coordinate(self.tileobjects[self.objectRange[arg_197_0]].order, "index")
			local var_197_3 = var_197_2.order_x
			local var_197_4 = var_197_2.order_y
			local var_197_5 = 0
			local var_197_6 = 0

			for iter_197_0 = 1, 4 do
				if iter_197_0 == var_0_41 or iter_197_0 == var_0_43 then
					for iter_197_1 = var_197_3, var_197_3 + var_197_0 - 1 do
						local var_197_7 = self:getnext(self:transform_index_pos_coordinate(cc.p(iter_197_1, (iter_197_0 == var_0_41 or nil) and (var_197_4 + var_197_1 - 1 or var_197_4)), "pos").index, iter_197_0)

						if not var_197_7 then
							var_197_6 = var_197_6 + 1
						elseif not self:isTileCanPass(var_197_7) then
							var_197_6 = var_197_6 + 1
						end

						var_197_5 = var_197_5 + 1
					end
				elseif iter_197_0 == var_0_44 or iter_197_0 == var_0_42 then
					local var_197_8 = iter_197_0 == var_0_44 and var_197_3 or var_197_3 + var_197_0 - 1

					for iter_197_2 = var_197_4, var_197_4 + var_197_1 - 1 do
						local var_197_9 = self:getnext(self:transform_index_pos_coordinate(cc.p(var_197_8, iter_197_2), "pos").index, iter_197_0)

						if not var_197_9 then
							var_197_6 = var_197_6 + 1
						elseif not self:isTileCanPass(var_197_9) then
							var_197_6 = var_197_6 + 1
						end

						var_197_5 = var_197_5 + 1
					end
				end
			end

			if var_197_5 == var_197_6 then
				return true
			else
				return false
			end
		else
			local var_197_10 = 0

			for iter_197_3 = 1, 4 do
				local var_197_11 = self:getnext(arg_197_0, iter_197_3)

				if not var_197_11 then
					var_197_10 = var_197_10 + 1
				elseif not self:isTileCanPass(var_197_11) then
					var_197_10 = var_197_10 + 1
				end
			end

			if var_197_10 == 4 then
				return true
			else
				return false
			end
		end
	end)(var_196_1) then
		return -3
	end

	local var_196_2 = self:findRoad(var_196_1)

	if var_196_2 then
		return 2, var_196_2, self.curPosIndex, var_196_1
	else
		return -3
	end
end

function RoomMap:findRoad(arg_198_1)
	if self:getChildByName("testLayout") then
		self:getChildByName("testLayout"):removeAllChildren()
	end

	local var_198_0 = self.curPosIndex
	local var_198_2 = self:transform_index_pos_coordinate(arg_198_1, "index")
	local var_198_3 = cc.p(var_198_2.order_x, var_198_2.order_y)
	local var_198_4 = {
		{
			index = self.curPosIndex
		}
	}
	local var_198_5 = {
		[self.curPosIndex] = 1
	}
	local var_198_6 = {}
	local var_198_7 = {
		[self.curPosIndex] = -1
	}

	local function var_198_8(arg_199_0, arg_199_1, arg_199_2, arg_199_3)
		if not var_0_60 then
			return
		end

		local var_199_0 = self:getChildByName("testLayout")

		self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_199_3), cc.CallFunc:create(function()
			local var_200_0 = self:transform_index_pos_coordinate(arg_199_0, "index")
			local var_200_3 = ccui.ImageView:create("public/box/UI_smeltScene_equipOn.png", var_0_1)

			var_200_3:setAnchorPoint(cc.p(0, 0))
			var_200_3:setName("test" .. arg_199_0)
			var_200_3:setPosition(var_200_0.x, var_200_0.y)
			var_199_0:addChild(var_200_3, 1)

			local var_200_4 = cc.Label:createWithTTF("G: " .. arg_199_1, FONT_NAME, 20)

			var_200_4:setName("G_label")
			var_200_4:setColor(cc.c3b(0, 0, 0))
			var_200_4:setAnchorPoint(cc.p(0, 0.5))
			var_200_4:setPosition(0, 30)
			var_200_3:addChild(var_200_4)

			local var_200_5 = cc.Label:createWithTTF("H: " .. arg_199_2, FONT_NAME, 20)

			var_200_5:setName("H_label")
			var_200_5:setColor(cc.c3b(0, 0, 0))
			var_200_5:setAnchorPoint(cc.p(0, 0.5))
			var_200_5:setPosition(0, 60)
			var_200_3:addChild(var_200_5)

			local var_200_6 = cc.Label:createWithTTF("F: " .. arg_199_2 + arg_199_1, FONT_NAME, 20)

			var_200_6:setName("F_label")
			var_200_6:setColor(cc.c3b(0, 0, 0))
			var_200_6:setAnchorPoint(cc.p(0, 0.5))
			var_200_6:setPosition(0, 90)
			var_200_3:addChild(var_200_6)
		end)))
	end

	local function var_198_9(arg_201_0, arg_201_1, arg_201_2, arg_201_3)
		if not var_0_60 then
			return
		end

		if not self:getChildByName("testLayout") then
			return
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_201_3), cc.CallFunc:create(function()
			local var_202_0 = self:getChildByName("testLayout"):getChildByName("test" .. arg_201_0)

			var_202_0:getChildByName("G_label"):setString("G:" .. arg_201_1)
			var_202_0:getChildByName("H_label"):setString("H:" .. arg_201_2)
			var_202_0:getChildByName("F_label"):setString("F:" .. arg_201_2 + arg_201_1)
		end)))
	end

	local function var_198_10(arg_203_0, arg_203_1)
		if not var_0_60 then
			return
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_203_1), cc.CallFunc:create(function()
			if not self:getChildByName("testLayout") then
				return
			end

			if not self:getChildByName("testLayout"):getChildByName("test" .. arg_203_0) then
				return
			end

			self:getChildByName("testLayout"):getChildByName("test" .. arg_203_0):setColor(cc.c3b(100, 0, 0))
		end)))
	end

	local function var_198_11(arg_205_0)
		if not var_198_7[arg_205_0] then
			return
		end

		local var_205_0 = 1
		local var_205_1 = arg_205_0

		while var_198_7[arg_205_0] > 0 do
			var_205_0 = var_205_0 + 1
			var_205_1 = var_198_7[arg_205_0]
		end

		return var_205_0
	end

	local function var_198_12(arg_206_0)
		local var_206_0 = self:transform_index_pos_coordinate(arg_206_0, "index")
		local var_206_1 = math.sqrt(math.abs(var_206_0.order_x - var_198_3.x) * math.abs(var_206_0.order_x - var_198_3.x) + math.abs(var_206_0.order_y - var_198_3.y) * math.abs(var_206_0.order_y - var_198_3.y))

		return (math.abs(var_206_0.order_x - var_198_3.x) + math.abs(var_206_0.order_y - var_198_3.y)) * 1.01
	end

	local function var_198_13()
		var_198_5 = {}

		for iter_207_0, iter_207_1 in pairs(var_198_4) do
			var_198_5[iter_207_1.index] = iter_207_0
		end
	end

	local function var_198_14(arg_208_0, arg_208_1)
		var_198_4[arg_208_0], var_198_4[arg_208_1] = var_198_4[arg_208_1], var_198_4[arg_208_0]
	end

	local function var_198_15()
		local var_209_0 = 0

		while 1 * 2 <= #var_198_4 and not false do
			var_209_0 = var_198_4[1].F_value > var_198_4[1 * 2].F_value and 1 * 2 or 1

			if 1 * 2 + 1 <= #var_198_4 and var_198_4[var_209_0].F_value > var_198_4[1 * 2 + 1].F_value then
				var_209_0 = 1 * 2 + 1
			end

			local var_209_1, var_209_2

			if var_209_0 ~= 1 then
				var_198_14(var_209_0, 1)

				var_209_1 = var_209_0
			else
				var_209_2 = true
			end
		end
	end

	local function var_198_16()
		if #var_198_4 == 1 then
			return
		end

		local var_210_0 = #var_198_4

		::label_210_0::

		while var_210_0 ~= 1 and not false do
			if var_210_0 % 2 == 0 then
				local var_210_1 = var_210_0 / 2 or (var_210_0 - 1) / 2

				if var_198_4[var_210_0].F_value < var_198_4[var_210_1].F_value then
					var_198_14(var_210_0, var_210_1)

					var_210_0 = var_210_1

					goto label_210_0
				end
			end
		end
	end

	local function var_198_17(arg_211_0, arg_211_1, arg_211_2)
		var_198_4[#var_198_4 + 1] = {
			index = arg_211_0,
			G_value = arg_211_1,
			H_value = arg_211_2,
			F_value = arg_211_1 + arg_211_2
		}

		var_198_16()
		var_198_13()
	end

	local function var_198_18()
		var_198_4[1] = var_198_4[#var_198_4]
		var_198_4[#var_198_4] = nil

		var_198_15()
		var_198_13()
	end

	local function var_198_19(arg_214_0)
		local var_214_0 = {}
		local var_214_1 = false

		while next(var_198_4) ~= nil do
			var_198_10(var_198_4[1].index, 0 * 0.01)
			var_198_18()

			var_198_6[var_198_4[1].index] = 1

			for iter_214_0 = 1, 4 do
				local var_214_2 = self:getnext(var_198_4[1].index, iter_214_0)

				if var_214_2 then
					local var_214_4

					if not self.usedTile[arg_214_0].range[var_214_2] then
						if self:isTileCanPass(var_214_2) and not var_198_6[var_214_2] then
							if var_198_5[var_214_2] then
								indexInfo = var_198_4[var_198_5[var_214_2]]

								local var_214_3 = var_198_11(var_198_4[1].index) + 1

								if var_214_3 < indexInfo.G_value then
									indexInfo.G_value = var_214_3
									indexInfo.F_value = var_214_3 + var_198_12(var_214_2)
									var_198_7[var_214_2] = var_198_4[1].index

									var_198_9(var_214_2, var_198_11(var_198_4[1].index) + 1, var_198_12(var_214_2), 0 * 0.01)
								end
							else
								var_198_8(var_214_2, var_198_11(var_198_4[1].index) + 1, var_198_12(var_214_2), 0 * 0.01)

								var_214_4 = 0 + 1

								var_198_17(var_214_2, var_198_11(var_198_4[1].index) + 1, var_198_12(var_214_2))

								var_198_7[var_214_2] = var_198_4[1].index
							end
						end
					else
						var_214_1 = true
						var_214_0 = {
							var_214_2
						}
						var_198_7[var_214_2] = var_198_4[1].index

						local var_214_5 = var_214_2

						while var_198_7[var_214_5] ~= var_198_0 do
							table.insert(var_214_0, 1, var_198_7[var_214_5])

							var_214_5 = var_198_7[var_214_5]
						end

						break
					end
				end
			end

			if var_214_1 then
				return var_214_0
			end
		end

		if var_214_1 == false then
			return
		end
	end

	if self.monsterRange[arg_198_1] then
		return var_198_19(self.monsterRange[arg_198_1][1])
	elseif self.objectRange[arg_198_1] then
		return var_198_19(self.objectRange[arg_198_1])
	else
		return (function()
			local var_213_0 = {
				arg_198_1
			}
			local var_213_1 = false

			while next(var_198_4) ~= nil do
				var_198_10(var_198_4[1].index, 0 * 0.01)
				var_198_18()

				var_198_6[var_198_4[1].index] = 1

				for iter_213_0 = 1, 4 do
					local var_213_2 = self:getnext(var_198_4[1].index, iter_213_0)

					if var_213_2 then
						local var_213_4

						if var_213_2 ~= arg_198_1 then
							if self:isTileCanPass(var_213_2) and not var_198_6[var_213_2] then
								if var_198_5[var_213_2] then
									indexInfo = var_198_4[var_198_5[var_213_2]]

									local var_213_3 = var_198_11(var_198_4[1].index) + 1

									if var_213_3 < indexInfo.G_value then
										indexInfo.G_value = var_213_3
										indexInfo.F_value = var_213_3 + var_198_12(var_213_2)
										var_198_7[var_213_2] = var_198_4[1].index

										var_198_9(var_213_2, var_198_11(var_198_4[1].index) + 1, var_198_12(var_213_2), 0 * 0.01)
									end
								else
									var_198_8(var_213_2, var_198_11(var_198_4[1].index) + 1, var_198_12(var_213_2), 0 * 0.01)

									var_213_4 = 0 + 1

									var_198_17(var_213_2, var_198_11(var_198_4[1].index) + 1, var_198_12(var_213_2))

									var_198_7[var_213_2] = var_198_4[1].index
								end
							end
						else
							var_213_1 = true
							var_198_7[var_213_2] = var_198_4[1].index

							local var_213_5 = arg_198_1

							while var_198_7[var_213_5] ~= var_198_0 do
								table.insert(var_213_0, 1, var_198_7[var_213_5])

								var_213_5 = var_198_7[var_213_5]
							end

							break
						end
					end
				end

				if var_213_1 then
					return var_213_0
				end
			end

			if var_213_1 == false then
				return
			end
		end)()
	end
end

function RoomMap:updatePos(arg_215_1, arg_215_2)
	local var_215_0
	local var_215_1
	local var_215_2 = {}

	if not arg_215_2 then
		global_ShowBlockWords(L_EXPLOREMAP_ROOM.Room_state[3])

		return
	end

	local var_215_3 = arg_215_2[#arg_215_2]

	if self.monsterRange[arg_215_1] then
		if self.tileobjects[self.monsterRange[arg_215_1][1]]:isTileActive() then
			var_215_1 = self.monsterRange[arg_215_1][1]
		end

		table.remove(arg_215_2, #arg_215_2)
	elseif self.objectRange[arg_215_1] then
		if self.tileobjects[self.objectRange[arg_215_1]]:isTileActive() then
			var_215_1 = self.objectRange[arg_215_1]

			if not self.tileobjects[self.objectRange[arg_215_1]]:isTileCanPass() then
				table.remove(arg_215_2, #arg_215_2)
			end
		end
	else
		var_215_0 = var_215_3
	end

	for iter_215_0, iter_215_1 in ipairs(arg_215_2) do
		if iter_215_0 == #arg_215_2 then
			var_215_0 = iter_215_1
		end

		if self.objectRange[iter_215_1] then
			if self.tileobjects[self.objectRange[iter_215_1]] and self.tileobjects[self.objectRange[iter_215_1]].tileInfo.is_touch == 2 then
				var_215_1 = self.objectRange[iter_215_1]
				var_215_0 = iter_215_1

				break
			end
		end
	end

	for iter_215_2, iter_215_3 in ipairs(arg_215_2) do
		var_215_2[iter_215_2] = iter_215_3

		if iter_215_3 == var_215_0 then
			break
		end
	end

	if next(var_215_2) ~= nil then
		local var_215_4, var_215_5 = self:checkIsBound(var_215_0)

		if var_215_4 then
			if self:checkBoundIsLock(var_215_5) then
				table.remove(var_215_2, #var_215_2)
			end

			if not self.root.touchLock then
				self:moveSelectedFrame(var_215_2, var_215_5, nil)
			end
		elseif not self.root.touchLock then
			self:moveSelectedFrame(var_215_2, nil, function()
				if var_215_1 then
					self:triggerEvent(var_215_1)
				end

				explore_manager:move_cur_pos(self.curMapType, var_215_0)
			end)
		end
	elseif var_215_1 then
		self:stopActionByTag(self.actionTag)
		self:playAni("idle")
		self:triggerEvent(var_215_1)
	end
end

function RoomMap:getFinialPath(arg_217_1, arg_217_2)
	local var_217_0
	local var_217_2 = {}

	if not arg_217_2 then
		global_ShowBlockWords(L_EXPLOREMAP_ROOM.Room_state[3])

		return
	end

	local var_217_3 = arg_217_2[#arg_217_2]

	if self.monsterRange[arg_217_1] then
		if self.tileobjects[self.monsterRange[arg_217_1][1]]:isTileActive() then
			-- block empty
		end

		table.remove(arg_217_2, #arg_217_2)
	elseif self.objectRange[arg_217_1] then
		if self.tileobjects[self.objectRange[arg_217_1]]:isTileActive() then
			if not self.tileobjects[self.objectRange[arg_217_1]]:isTileCanPass() then
				table.remove(arg_217_2, #arg_217_2)
			end
		end
	else
		var_217_0 = var_217_3
	end

	for iter_217_0, iter_217_1 in ipairs(arg_217_2) do
		if iter_217_0 == #arg_217_2 then
			var_217_0 = iter_217_1
		end

		if self.objectRange[iter_217_1] then
			if self.tileobjects[self.objectRange[iter_217_1]] and self.tileobjects[self.objectRange[iter_217_1]].tileInfo.is_touch == 2 then
				var_217_0 = iter_217_1

				break
			end
		end
	end

	for iter_217_2, iter_217_3 in ipairs(arg_217_2) do
		var_217_2[iter_217_2] = iter_217_3

		if iter_217_3 == var_217_0 then
			break
		end
	end

	return var_217_2
end

function RoomMap:moveSelectedFrame(arg_218_1, arg_218_2, arg_218_3)
	self.curPosIndex = self.curMapConfig.curPosIndex
	self.actionTag = 111

	self:stopActionByTag(self.actionTag)

	local function var_218_2(arg_219_0, arg_219_1)
		if math.abs(arg_219_0 - arg_219_1) == 1 then
			return "x"
		elseif math.abs(arg_219_0 - arg_219_1) == self.room_width_num then
			return "y"
		else
			print(arg_219_0, arg_219_1, arg_219_0 - arg_219_1)
		end
	end

	local function var_218_3()
		local var_220_0, var_220_1 = self:checkBoundIsLock(arg_218_2)

		if var_220_0 then
			self:playAni("idle")
			self:popTalkSp(L_EXPLOREMAP_ROOM.TalkSp)
			self:isTriggerAim(var_220_1.tileid)

			return
		end

		self.root.touchLock = true

		local var_220_2 = self.curCoordinate.x
		local var_220_3 = self.curCoordinate.y
		local var_220_4
		local var_220_5

		if arg_218_2 == var_0_41 then
			var_220_5 = self.curCoordinate.y + var_0_68 / 2
			var_220_4 = self.curCoordinate.x
		elseif arg_218_2 == var_0_43 then
			var_220_5 = self.curCoordinate.y - var_0_68 / 2
			var_220_4 = self.curCoordinate.x
		elseif arg_218_2 == var_0_44 then
			var_220_5 = self.curCoordinate.y
			var_220_4 = self.curCoordinate.x - var_0_68 / 2
		elseif arg_218_2 == var_0_42 then
			var_220_5 = self.curCoordinate.y
			var_220_4 = self.curCoordinate.x + var_0_68 / 2
		end

		local var_220_6 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
			var_220_2, var_220_3 = self.tag:getPositionX(), self.tag:getPositionY()

			if arg_218_2 == var_0_41 or arg_218_2 == var_0_43 then
				if var_220_3 ~= var_220_5 then
					var_220_3 = var_220_3 + (var_220_5 - var_220_3) / math.abs(var_220_5 - var_220_3) * (math.abs(var_220_5 - var_220_3) < 0.016666666666666666 * self.SPEED and math.abs(var_220_5 - var_220_3) or 0.016666666666666666 * self.SPEED)
				else
					explore_manager:goto_next_room(arg_218_2)
					self.root:switchRoom(arg_218_2)
					self:stopActionByTag(self.actionTag)

					return
				end
			elseif arg_218_2 == var_0_44 or arg_218_2 == var_0_42 then
				if var_220_2 ~= var_220_4 then
					local var_221_1 = math.abs(var_220_4 - var_220_2) < 0.016666666666666666 * self.SPEED and math.abs(var_220_4 - var_220_2) or 0.016666666666666666 * self.SPEED
					local var_221_2 = (var_220_4 - var_220_2) / math.abs(var_220_4 - var_220_2)

					var_220_2 = var_220_2 + var_221_2 * var_221_1

					if var_221_2 ~= self.tag.dir then
						self.tag:setScale(var_221_2 * math.abs(self.tag.scale), math.abs(self.tag.scale))
					end
				else
					explore_manager:goto_next_room(arg_218_2)
					self.root:switchRoom(arg_218_2)
					self:stopActionByTag(self.actionTag)

					return
				end
			end

			self.tag:setPosition(var_220_2, var_220_3)
		end)))

		var_220_6:setTag(self.SPEED)
		self:runAction(var_220_6)
		self:playAni("run")
	end

	if next(arg_218_1) == nil and arg_218_2 then
		var_218_3()

		return
	end

	local var_218_4 = var_218_2(self.curPosIndex, arg_218_1[1])
	local var_218_5 = 1
	local var_218_6 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
		local var_222_9000
		local var_222_0 = arg_218_1[var_218_5]
		local var_222_1 = self:transform_index_pos_coordinate(arg_218_1[var_218_5], "index")
		local var_222_3 = var_222_1.order_y
		local var_222_4 = var_222_1.x + var_0_68 / 2
		local var_222_5 = var_222_1.y + var_0_68 / 2
		local var_222_6 = self.tag:getPositionX()
		local var_222_7 = self.tag:getPositionY()

		if cc.rectContainsPoint(cc.rect(var_222_1.x + var_0_68 / 2 - 50, var_222_1.y + var_0_68 / 2 - 50, 100, 100), cc.p(var_222_6, var_222_7)) and var_222_0 ~= self.curPosIndex then
			self.prePosIndex = self.curPosIndex
			self.preEnv = self.curMapEnv
			self.curMapConfig.curPosIndex = var_222_0

			self:updateCurPosInfo()
			self:playChangeEnvAni()
			self:updateRouteWithEnv()

			if self.curMapConfig.curPosIndex == arg_218_1[#arg_218_1] and arg_218_3 then
				arg_218_3()
			end
		end

		if var_218_4 and var_218_4 == "x" or not var_218_4 then
			if var_218_5 == #arg_218_1 then
				if var_222_6 == var_222_4 and var_222_7 == var_222_5 then
					self:stopActionByTag(self.actionTag)

					if arg_218_2 then
						var_218_3()
					else
						self:playAni("idle")
					end

					return
				elseif var_222_6 ~= var_222_4 then
					local var_222_8 = math.abs(var_222_4 - var_222_6) < 0.016666666666666666 * self.SPEED and math.abs(var_222_4 - var_222_6) or 0.016666666666666666 * self.SPEED
					local var_222_9 = (var_222_4 - var_222_6) / math.abs(var_222_4 - var_222_6)

					var_222_6 = var_222_6 + var_222_9 * var_222_8

					if var_222_9 ~= self.tag.dir then
						self.tag:setScale(var_222_9 * math.abs(self.tag.scale), math.abs(self.tag.scale))
					end
				elseif var_222_7 ~= var_222_5 then
					var_222_7 = var_222_7 + (var_222_5 - var_222_7) / math.abs(var_222_5 - var_222_7) * (math.abs(var_222_5 - var_222_7) < 0.016666666666666666 * self.SPEED and math.abs(var_222_5 - var_222_7) or 0.016666666666666666 * self.SPEED)
				end
			elseif var_222_6 == var_222_4 and self.curPosIndex == var_222_0 then
				var_218_5 = var_218_5 + 1
				var_218_4 = var_218_2(explore_manager.curMapConfig.curPosIndex, arg_218_1[var_218_5])
			elseif var_222_6 ~= var_222_4 then
				local var_222_11 = math.abs(var_222_4 - var_222_6) < 0.016666666666666666 * self.SPEED and math.abs(var_222_4 - var_222_6) or 0.016666666666666666 * self.SPEED
				local var_222_12 = (var_222_4 - var_222_6) / math.abs(var_222_4 - var_222_6)

				var_222_6 = var_222_6 + var_222_12 * var_222_11

				if var_222_12 ~= self.tag.dir then
					self.tag:setScale(var_222_12 * math.abs(self.tag.scale), math.abs(self.tag.scale))
				end
			elseif var_222_7 ~= var_222_5 then
				var_222_7 = var_222_7 + (var_222_5 - var_222_7) / math.abs(var_222_5 - var_222_7) * (math.abs(var_222_5 - var_222_7) < 0.016666666666666666 * self.SPEED and math.abs(var_222_5 - var_222_7) or 0.016666666666666666 * self.SPEED)
			end
		elseif var_218_4 and var_218_4 == "y" then
			if var_218_5 == #arg_218_1 then
				if var_222_6 == var_222_4 and var_222_7 == var_222_5 then
					self:stopActionByTag(self.actionTag)

					if arg_218_2 then
						var_218_3()
					else
						self:playAni("idle")
					end

					return
				elseif var_222_7 ~= var_222_5 then
					var_222_7 = var_222_7 + (var_222_5 - var_222_7) / math.abs(var_222_5 - var_222_7) * (math.abs(var_222_5 - var_222_7) < 0.016666666666666666 * self.SPEED and math.abs(var_222_5 - var_222_7) or 0.016666666666666666 * self.SPEED)
				elseif var_222_6 ~= var_222_4 then
					local var_222_15 = math.abs(var_222_4 - var_222_6) < 0.016666666666666666 * self.SPEED and math.abs(var_222_4 - var_222_6) or 0.016666666666666666 * self.SPEED
					local var_222_16 = (var_222_4 - var_222_6) / math.abs(var_222_4 - var_222_6)

					var_222_6 = var_222_6 + var_222_16 * var_222_15

					if var_222_16 ~= self.tag.dir then
						self.tag:setScale(var_222_16 * math.abs(self.tag.scale), math.abs(self.tag.scale))
					end
				end
			elseif var_222_7 == var_222_5 and self.curPosIndex == var_222_0 then
				var_218_5 = var_218_5 + 1
				var_218_4 = var_218_2(explore_manager.curMapConfig.curPosIndex, arg_218_1[var_218_5])
			elseif var_222_7 ~= var_222_5 then
				var_222_7 = var_222_7 + (var_222_5 - var_222_7) / math.abs(var_222_5 - var_222_7) * (math.abs(var_222_5 - var_222_7) < 0.016666666666666666 * self.SPEED and math.abs(var_222_5 - var_222_7) or 0.016666666666666666 * self.SPEED)
			elseif var_222_6 ~= var_222_4 then
				local var_222_18 = math.abs(var_222_4 - var_222_6) < 0.016666666666666666 * self.SPEED and math.abs(var_222_4 - var_222_6) or 0.016666666666666666 * self.SPEED
				local var_222_19 = (var_222_4 - var_222_6) / math.abs(var_222_4 - var_222_6)

				var_222_6 = var_222_6 + var_222_19 * var_222_18

				if var_222_19 ~= self.tag.dir then
					self.tag:setScale(var_222_19 * math.abs(self.tag.scale), math.abs(self.tag.scale))
				end
			end
		end

		self.tag:setPosition(var_222_6, var_222_7)

		if self.mask then
			self.mask:setPosition((self:convertToNodeSpace(cc.p(GameDisplay.cx, GameDisplay.cy))))

			local var_222_20 = self:convertToWorldSpace(cc.p(var_222_6, var_222_7 + self.tag:getBoundingBox().height / 2))

			self.mask:focus(var_222_20.x, var_222_20.y)
		end

		self.tag:setLocalZOrder((self.room_height_num - var_222_3 + 1) * 2)

		if var_0_61 == 1 then
			local var_222_21 = self:getContentSize().width * var_0_67 - self.root.mapView:getContentSize().width
			local var_222_22 = self:getContentSize().height * var_0_67 - self.root.mapView:getContentSize().height
			local var_222_23 = var_222_6 * var_0_67 - self.root.mapView:getContentSize().width / 2
			local var_222_24 = var_222_7 * var_0_67 - self.root.mapView:getContentSize().height / 2

			if var_222_21 < var_222_23 then
				var_222_23 = var_222_21
			elseif var_222_23 < 0 then
				var_222_23 = 0
			end

			if var_222_22 < var_222_24 then
				var_222_24 = var_222_22
			elseif var_222_24 < 0 then
				var_222_24 = 0
			end

			self.root.mapView:getInnerContainer():setPosition(-var_222_23, -var_222_24)
		elseif var_0_61 == 2 then
			local var_222_25 = 200
			local var_222_26 = 600
			local var_222_27 = self.root.mapView:getInnerContainer():getPositionY() + var_222_7 * var_0_67
			local var_222_28, var_222_29 = self.root.mapView:getInnerContainer():getPosition()

			if self.root.mapView:getInnerContainer():getPositionX() + var_222_6 * var_0_67 < 160 then
				var_222_28 = var_222_28 + 160 - (self.root.mapView:getInnerContainer():getPositionX() + var_222_6 * var_0_67)
			elseif 480 < self.root.mapView:getInnerContainer():getPositionX() + var_222_6 * var_0_67 then
				var_222_28 = var_222_28 - (self.root.mapView:getInnerContainer():getPositionX() + var_222_6 * var_0_67) + 480
			end

			if var_222_27 < var_222_25 then
				var_222_29 = var_222_29 + var_222_25 - var_222_27
			else
				local var_222_30

				if var_222_26 < var_222_27 then
					var_222_29 = var_222_29 - var_222_27 + var_222_26
					var_222_30 = self:getContentSize().height * var_0_67 - self.root.mapView:getContentSize().height
				end
			end

			if self:getContentSize().width < -var_222_28 then
				var_222_28 = -(var_222_9000 * var_0_67 - self.root.mapView:getContentSize().width)
			elseif -var_222_28 < 0 then
				var_222_28 = 0
			end

			if var_222_30 < -var_222_29 then
				var_222_29 = -var_222_30
			elseif -var_222_29 < 0 then
				var_222_29 = 0
			end

			self.root.mapView:getInnerContainer():setPosition(var_222_28, var_222_29)
		end
	end)))

	var_218_6:setTag(self.actionTag)
	self:runAction(var_218_6)
	self:playAni((self.actionMove or nil) and (self.actionMove or "run"))
	self:npcMove(arg_218_1)
end

function RoomMap:npcMove(arg_223_1)
	local var_223_0 = global_deepCopy(arg_223_1)

	table.insert(var_223_0, 1, self.curMapConfig.curPosIndex)
	table.remove(var_223_0, #var_223_0)

	if self.root.followQueue and next(self.root.followQueue) ~= nil then
		for iter_223_0 = 1, #self.root.followQueue do
			self.root.followQueue[iter_223_0]:npcMove(var_223_0)

			local var_223_2 = global_deepCopy(var_223_0)

			table.insert(var_223_2, 1, self.root.followQueue[iter_223_0].curPosIndexNpc)
			table.remove(var_223_2, #var_223_2)

			var_223_0 = var_223_2
		end
	end
end

function RoomMap:triggerEvent(arg_224_1)
	print("??????triggerEvent", arg_224_1, self.usedTile[arg_224_1], self.tileobjects[arg_224_1])

	if not self.usedTile[arg_224_1] then
		return
	end

	if not self.tileobjects[arg_224_1] and self.tileobjects[arg_224_1].tileid then
		return
	end

	if self.root.touchLock then
		return
	end

	self.root.touchLock = true

	self:isTriggerAim(self.tileobjects[arg_224_1].tileid)
	self.tileobjects[arg_224_1]:triggerEvent(function(arg_225_0)
		local var_225_0 = arg_225_0.msg
		local var_225_1 = arg_225_0.eventconfig

		if arg_225_0.msg.result > 0 then
			self:checkisShowMainAim(arg_224_1, var_225_1)
			self.root.smallMap:updateByObject(arg_225_0.tileInfo.id)
			self.root:updateExploreProgress(arg_225_0.tileInfo.id)
			self.root.aimLayout:updateAim(arg_225_0.tileInfo.id)

			if arg_225_0.msg.config and arg_225_0.msg.config.HP then
				self.root.bloodbg.updateBloodUI()

				if arg_225_0.msg.config.add_hp > 0 then
					self:playAni("hitdown")
					self:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.CallFunc:create(function()
						self.role_ani_lock = false

						self:playAni("idle")

						if var_225_1.result_des then
							LayerManager:pushInLayer("PopDoLayer", {
								labels = {
									titleImage = "title_explore_msg.png",
									title = L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.title,
									des = var_225_1.result_des or L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.des,
									button = L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.button
								}
							})
						else
							global_ShowBlockWords(string.format(L_EXPLOREMAP_TRIGGER_EVENT.Team_Energe_Minus, var_225_0.config.add_hp))
						end
					end)))

					self.role_ani_lock = true
				elseif arg_225_0.msg.config.add_hp < 0 then
					self:playAni("win", function()
						self.role_ani_lock = false

						self:playAni("idle")

						if var_225_1.result_des then
							LayerManager:pushInLayer("PopDoLayer", {
								labels = {
									titleImage = "title_explore_msg.png",
									title = L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.title,
									des = var_225_1.result_des or L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.des,
									button = L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.button
								}
							})
						else
							global_ShowBlockWords(string.format(L_EXPLOREMAP_TRIGGER_EVENT.Team_Energe_Plus, var_225_0.config.add_hp * -1))
						end
					end)

					self.role_ani_lock = true
				end
			end

			if arg_225_0.tileInfo.class == TILE_TYPE.POKEMON then
				self.root:playUIAnimation("BZchenggong")
			elseif var_225_1.result_type == EVENT_TYPE.CHANGE_DRESS then
				self:updateCurGirlSkin(var_225_1.result_param)
			elseif var_225_1.result_type == EVENT_TYPE.PORTAL then
				if self.root.jumpEffect then
					local var_225_2 = self.root.jumpEffect.jump_effect or "chansongh"

					if var_225_2 then
						local var_225_3 = L2Skeleton:create("spine/explore/" .. var_225_2 .. ".json", "spine/explore/" .. var_225_2 .. ".atlas")

						var_225_3:setScaleX(1.2)
						var_225_3:setScaleY(1.2)
						var_225_3:setName("jumpRoomEffect")
						var_225_3:refreshSkeleton()
						var_225_3:play("animation", false)
						var_225_3:registerListener(SP_ANIMATION_COMPLETE, function(arg_228_0)
							var_225_3:runAction(cc.RemoveSelf:create())

							local var_228_0, var_228_1 = var_225_1.result_param:match("(%d+)-(%d+)")
							local var_228_2 = tonumber(var_228_0)

							explore_manager:jumpto_other_room(var_228_2, (tonumber(var_228_1)))
							self.root:jumpRoom(var_228_2)
						end)
						var_225_3:setPosition(cc.p(self.tag:getContentSize().width / 2, self.tag:getContentSize().height / 2))
						self.tag:addChild(var_225_3, 99)
						var_225_3:setGlobalZOrder(-1)

						goto label_225_0
					end
				end

				local var_225_4, var_225_5 = var_225_1.result_param:match("(%d+)-(%d+)")
				local var_225_6 = tonumber(var_225_4)

				explore_manager:jumpto_other_room(var_225_6, (tonumber(var_225_5)))
				self.root:jumpRoom(var_225_6)
			elseif arg_225_0.tileInfo.class == TILE_TYPE.NPCFOLLOW then
				self.root.followQueue[#self.root.followQueue + 1] = self.tileobjects[arg_224_1]
				self.root.followQueue[#self.root.followQueue].index = #self.root.followQueue

				self.root.followQueue[#self.root.followQueue]:retain()

				for iter_225_0 = 1, 4 do
					if self.root.curMapConfig.array[iter_225_0] then
						if not self.root.curMapConfig.array[iter_225_0].fight_girl then
							self.root.curMapConfig.array[iter_225_0] = {
								pos = #self.root.curMapConfig.array + 1,
								fight_girl = npc_fightconfig_data[tonumber(var_225_1.result_param)].servantid,
								npcid = npc_fightconfig_data[tonumber(var_225_1.result_param)].soulid
							}

							break
						end
					end
				end

				global_ShowBlockWords(var_225_1.result_des)
			elseif arg_225_0.tileInfo.class == TILE_TYPE.CRACKLE then
				self.root.touchLock = false
			end

			::label_225_0::

			if var_225_1.result_type == EVENT_TYPE.CHANGE_ROLEMODEL then
				self:changeMainRoleMode(var_225_1.result_param)
			elseif var_225_1.result_type == EVENT_TYPE.UPDATE_ROOM_COLOR then
				self:updateRoomColorEffect(tonumber(var_225_1.result_param))
			end
		elseif arg_225_0.msg.result == 0 then
			if var_225_1.result_type == EVENT_TYPE.FIGHT then
				for iter_225_1, iter_225_2 in pairs(arg_225_0.msg.cur_array) do
					iter_225_2.classtype = 1
				end

				require("view.Layer.LevelResultLayer")

				local function var_225_7()
					self.root:failExit()
				end

				LevelResultLayer:create({
					showtype = 7,
					curarray = arg_225_0.msg.cur_array,
					surecallback = var_225_7,
					cancelcallback = var_225_7
				})
			else
				self.root:failExit()
			end
		elseif arg_225_0.msg.result == -5 then
			self.root.curRoomMap:stopAllActions()
			LayerManager:switchShowLayer(self.root.returnUiLayer)
		end

		if var_225_1.result_type ~= EVENT_TYPE.PORTAL then
			self.root.touchLock = false
		elseif arg_225_0.msg.result < 0 then
			self.root.touchLock = false
		end
	end)
end

function RoomMap:popSwitchRole()
	return
end

function RoomMap:isTriggerAim(arg_231_1)
	if self.aimTypeTbl[arg_231_1] then
		self.root.aimLayout:triggerAim(arg_231_1)
	end
end

function RoomMap:gainItemToCache(arg_232_1)
	local var_232_0 = cc.size(explore_manager:getTileSize(self.usedTile[arg_232_1.object_idx].tileid))
	local var_232_1 = self:transform_index_pos_coordinate(self.usedTile[arg_232_1.object_idx].order, "index")
	local var_232_2, var_232_3 = self:transform_map_camera(cc.p(var_232_1.x + var_232_0.width / 2, var_232_1.y + var_232_0.height / 2), "map_to_camera")

	for iter_232_0, iter_232_1 in pairs(arg_232_1.items) do
		local var_232_5 = cc.Node:create()

		var_232_5:setVisible(false)
		var_232_5:setPosition(var_232_2, var_232_3)

		var_232_5.order = #self.root.gainItemPanel.sp_tbl

		self.root.gainItemPanel:addChild(var_232_5)
		table.insert(self.root.gainItemPanel.sp_tbl, var_232_5)

		local var_232_6 = item_data[iter_232_1.itemid]

		item = item_data[iter_232_1.itemid].bag_item_type == kITEM_COMPONENT and component_manager:create_component_icon(iter_232_1.itemid) or var_232_6.bag_item_type == kITEM_HORCRUX and cc.Sprite:create("role1/" .. model_data[var_232_6.model].cute_role .. ".png") or cc.Sprite:create("equipment/" .. var_232_6.image_id .. ".png")

		item:setScale(168 / item:getContentSize().width * 0.4)
		item:setName("item")
		var_232_5:addChild(item, 2)

		local var_232_7

		if config._DEBUG then
			var_232_7 = cc.Sprite:create(var_0_54[var_232_6.equip_quality]) or cc.Sprite:createWithSpriteFrameName(var_0_54[var_232_6.equip_quality])
		end

		var_232_7:setScale(0.4)
		var_232_7:setName("light")
		var_232_5:addChild(var_232_7, 1)
		var_232_5:runAction(cc.Sequence:create(cc.DelayTime:create(var_232_5.order * 7 / 6), cc.Show:create(), cc.MoveTo:create(0.3333333333333333, cc.p(320, 600)), cc.DelayTime:create(0.8333333333333334), cc.MoveTo:create(0.3333333333333333, cc.p(596, 50)), cc.CallFunc:create(function()
			if var_0_36 then
				table.remove(var_0_36.gainItemPanel.sp_tbl, 1)
			end
		end), cc.DelayTime:create(0.16666666666666666), cc.RemoveSelf:create()))
		var_232_7:runAction(cc.Sequence:create(cc.DelayTime:create(var_232_5.order * 7 / 6), cc.ScaleTo:create(0.3333333333333333, 1), cc.RotateTo:create(0.16666666666666666, 44), cc.RotateTo:create(0.6666666666666666, 164), cc.ScaleTo:create(0.3333333333333333, 0.6), cc.FadeOut:create(0.16666666666666666)))
		item:runAction(cc.Sequence:create(cc.DelayTime:create(var_232_5.order * 7 / 6), cc.ScaleTo:create(0.3333333333333333, 168 / item:getContentSize().width), cc.DelayTime:create(0.8333333333333334), cc.ScaleTo:create(0.3333333333333333, 168 / item:getContentSize().width * 0.4), cc.FadeOut:create(0.16666666666666666)))
	end
end

function RoomMap:updateCurGirlSkin(arg_234_1)
	if not arg_234_1 then
		return
	end

	for iter_234_0 = 1, 4 do
		if self.curMapConfig.array[iter_234_0] and self.curMapConfig.array[iter_234_0].fight_girl then
			if self.curMapConfig.array[iter_234_0].fight_girl then
				if major_factor_data[servant_data[self.curMapConfig.array[iter_234_0].fight_girl].major][arg_234_1] then
					self.curMapConfig.array[iter_234_0].servantskin = major_factor_data[servant_data[self.curMapConfig.array[iter_234_0].fight_girl].major][arg_234_1]

					if self.tag.arrayorder == iter_234_0 then
						self:updateSelectedFrame(self.tag.arrayorder)
					end
				end
			end
		end
	end
end

function RoomMap:changeMainRoleMode(arg_235_1)
	if not arg_235_1 then
		return
	end

	local var_235_0 = arg_235_1

	if not model_data[arg_235_1].spine_model then
		print("error:modelid is not have spine  ", var_235_0)

		return
	end

	local var_235_1

	if model_data[var_235_0].clothes_model then
		var_235_1 = CLOTHES_SPINE_PATH .. model_data[var_235_0].clothes_model .. ".atlas" or nil
	end

	local var_235_2 = var_0_66 * (model_data[var_235_0].modelscale > 1.3 and 1.3 or model_data[var_235_0].modelscale)

	self.tag:updateSpine(ROLE_SPINE_PATH .. model_data[arg_235_1].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[arg_235_1].spine_model .. ".atlas", var_235_1)
	self.tag:setScale(var_235_2, var_235_2)
	self.tag:setContentSize((cc.size(model_data[var_235_0].modelweight, model_data[var_235_0].modelheight)))
	self.tag:playAni(nil, self.tag.aniName, true)

	self.tag.modelid = var_235_0
	self.curMapConfig.change_role_modelid = var_235_0
end

function RoomMap:checkisShowMainAim(arg_236_1, arg_236_2)
	for iter_236_0, iter_236_1 in pairs(self.aimTypeTbl) do
		if iter_236_1.trigger_objectidx == arg_236_1 and (not iter_236_1.trigger_condition or iter_236_1.trigger_condition and arg_236_2 and iter_236_1.trigger_condition == arg_236_2.aim_condition) then
			self.aimTypeTbl[iter_236_0].is_show = true

			self.root.aimLayout:getChildByName("aim" .. iter_236_1.tileid):show_main_aim_by_object(self.aimTypeTbl[iter_236_1.tileid])
			self.root.smallMap:updateAll()

			break
		end
	end
end

function RoomMap:checkPuzzle(arg_237_1)
	if not var_0_35[arg_237_1].puzzleids then
		return
	end

	local var_237_0 = {}

	for iter_237_0, iter_237_1 in pairs(self.usedTilesConfig) do
		for iter_237_2, iter_237_3 in pairs(iter_237_1) do
			if var_0_35[iter_237_3.tileid].puzzleids then
				for iter_237_4 in var_0_35[iter_237_3.tileid].puzzleids:gmatch("([^,]+)") do
					var_237_0[iter_237_4] = var_237_0[iter_237_4] and var_237_0[iter_237_4] + 1 or 1
				end
			end
		end
	end

	for iter_237_5 = #self.puzzleConfig, 1, -1 do
		local var_237_1

		if self.puzzleConfig[iter_237_5].is_and then
			var_237_1 = true

			for iter_237_6, iter_237_7 in pairs(self.puzzleConfig[iter_237_5].condition) do
				if (var_237_0[iter_237_7.puzzleid] or 0) < iter_237_7.puzzlenum then
					var_237_1 = false

					break
				end
			end
		else
			var_237_1 = false

			for iter_237_8, iter_237_9 in pairs(self.puzzleConfig[iter_237_5].condition) do
				if (var_237_0[iter_237_9.puzzleid] or 0) >= iter_237_9.puzzlenum then
					var_237_1 = true

					break
				end
			end
		end

		if var_237_1 then
			for iter_237_10, iter_237_11 in pairs(self.puzzleConfig[iter_237_5].controller) do
				if iter_237_11.roomorder == self.curRoomOrder then
					if self.tileobjects[iter_237_11.controller_idx] then
						self.tileobjects[iter_237_11.controller_idx]:updateState(true)
					end
				else
					explore_manager:updateObjectState(iter_237_11.roomorder, iter_237_11.controller_idx)
				end
			end

			local var_237_4 = self.puzzleConfig[iter_237_5].controller_des or L_EXPLORE_CONTROLLER_OPEN

			if var_237_4 ~= "kong" then
				self:popTalkSp(var_237_4)
			end

			table.remove(self.puzzleConfig, iter_237_5)
		end
	end
end
