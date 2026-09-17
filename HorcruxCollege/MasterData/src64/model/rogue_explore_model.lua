local RogueExploreModel = class("RogueExploreModel")

require("data.constants")

local playermodel = require("model.playermodel")
local network = require("network.network")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local monster_manager = require("controller.monster_manager")
local level_manager = require("controller.level_manager")
local core_manager = require("controller.core_manager")
local L2Actor = require("view.Sprite.L2Actor")
local activity_manager = require("controller.activity_manager")
local explore_map_config_data = require("data.explore.explore_map_config_data")
local item_data = require("data.item_data")
local explore_sellweapon_data = require("data.explore.explore_sellweapon_data")
local explore_weapon_data = require("data.explore.explore_weapon_data")
local explore_buff_data = require("data.explore.explore_buff_data")
local explore_sellbuff_data = require("data.explore.explore_sellbuff_data")
local plot_data = require("data.plot_data")
local plot_class_data = require("data.plot_class_data")
local servant_data = require("data.servant_data")
local fitness_data = require("data.fitness_data")
local model_data = require("data.model_data")
local explore_img_data = require("data.explore.explore_img_data")
local explore_aim_data = require("data.explore.explore_aim_data")
local cad_data = require("data.explore.cad_data")
local room_data = require("data.explore.room_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local npc_data = require("data.npc_data")
local map_data = require("data.explore.map_data")
local var_0_28 = require("data.explore.room_data")
local room_tile_data = require("data.explore.room_tile_data")
local tile_data = require("data.explore.tile_data")
local explore_level_data = require("data.explore.explore_level_data")
local explore_monster_data = require("data.explore.explore_monster_data")
local explore_monster_team_data = require("data.explore.explore_monster_team_data")
local explore_script_data = require("data.explore_script_data")
local xuanshang_data = require("data.xuanshang_data")

;({}).IS_INVINCIBLE = not not config._DEBUG
TOTAL_TEAM_HP = 5

local var_0_36 = 1
local var_0_37 = 2
local var_0_38 = 3
local var_0_39 = 4
local var_0_40 = 8
local var_0_41 = 7
local var_0_42 = 6
local var_0_43 = 5
local var_0_44 = 9
local var_0_45 = {}

var_0_45[1] = 3
var_0_45[2] = 4
var_0_45[3] = 1
var_0_45[4] = 2
var_0_45[8] = 6
var_0_45[7] = 5
var_0_45[6] = 8
var_0_45[5] = 7

local var_0_51 = 0.24

EVENT_TYPE = {
	GET_ITEM = 7,
	SHOP_ITEM = 8,
	NEXT_FLOOR = 5,
	SUB_HP = 2,
	SHOP_BUFF = 6,
	GET_DROP = 3,
	FIGHT = 4,
	CHANGE_ROLEMODEL = 13,
	ADD_HP = 1,
	FOLLOW = 12,
	NOTHING = 666,
	UPDATE_ROOM_COLOR = 14,
	PORTAL = 11,
	CHANGE_DRESS = 9
}
TILE_TYPE = {
	RANDOM_EVENT = 5,
	ACTIVITY_MONEY = 29,
	MONEY = 6,
	SKILL_BOOK = 15,
	SPECIAL_ENEMY = 11,
	CONTROLLER = 28,
	GOLD_BOX = 14,
	ACTIVITY_ITEM = 30,
	COMPONENT_CHIP = 21,
	KEY = 9,
	POKEMON = 52,
	WEAPON = 22,
	NPCFOLLOW = 54,
	STORY_ENEMY = 58,
	PASSWORD = 57,
	ANIMATION = 56,
	CHIP = 17,
	CRACKLE = 60,
	SELECT_TALK = 62,
	LAB_MATERIALS = 16,
	CRACKLE_DOOR = 61,
	COMPONENT = 7,
	ENERGY_BATTERY = 8,
	NORMAL_ENEMY = 13,
	PATH_GOLD = 63,
	CONUNDRUM = 53,
	NPC = 27,
	MEMORY_CARD = 59,
	DES_WALL = 19,
	STATEPROCESS = 55,
	LOCK_BOX = 10
}
MONSTER_TILE_CLASS = {
	[TILE_TYPE.SPECIAL_ENEMY] = true,
	[TILE_TYPE.NORMAL_ENEMY] = true,
	[TILE_TYPE.STORY_ENEMY] = true
}
TILE_TYPE_STR = {
	[TILE_TYPE.RANDOM_EVENT] = L_EXPLOREMAP_BOX_TITLE_CLASS.RANDOM_EVENT,
	[TILE_TYPE.MONEY] = L_EXPLOREMAP_BOX_TITLE_CLASS.MONEY,
	[TILE_TYPE.COMPONENT] = L_EXPLOREMAP_BOX_TITLE_CLASS.COMPONENT,
	[TILE_TYPE.ENERGY_BATTERY] = L_EXPLOREMAP_BOX_TITLE_CLASS.ENERGY_BATTERY,
	[TILE_TYPE.KEY] = L_EXPLOREMAP_BOX_TITLE_CLASS.KEY,
	[TILE_TYPE.LOCK_BOX] = L_EXPLOREMAP_BOX_TITLE_CLASS.LOCK_BOX,
	[TILE_TYPE.SPECIAL_ENEMY] = L_EXPLOREMAP_BOX_TITLE_CLASS.SPECIAL_ENEMY,
	[TILE_TYPE.GOLD_BOX] = L_EXPLOREMAP_BOX_TITLE_CLASS.GOLD_BOX,
	[TILE_TYPE.SKILL_BOOK] = L_EXPLOREMAP_BOX_TITLE_CLASS.SKILL_BOOK,
	[TILE_TYPE.LAB_MATERIALS] = L_EXPLOREMAP_BOX_TITLE_CLASS.LAB_MATERIALS,
	[TILE_TYPE.CHIP] = L_EXPLOREMAP_BOX_TITLE_CLASS.CHIP,
	[TILE_TYPE.COMPONENT_CHIP] = L_EXPLOREMAP_BOX_TITLE_CLASS.COMPONENT_CHIP,
	[TILE_TYPE.WEAPON] = L_EXPLOREMAP_BOX_TITLE_CLASS.WEAPON,
	[TILE_TYPE.ACTIVITY_MONEY] = L_EXPLOREMAP_BOX_TITLE_CLASS.ACTIVITY_MONEY,
	[TILE_TYPE.ACTIVITY_ITEM] = L_EXPLOREMAP_BOX_TITLE_CLASS.ACTIVITY_ITEM
}
TILE_SHOW_CLASS = {
	SPECIAL_EVENT = 2,
	NORMAL_DROP = 1,
	ROGUE_SP_TILE2 = 4,
	ROGUE_SP_TILE1 = 3
}
TILE_SHOW_STR = {
	[TILE_SHOW_CLASS.NORMAL_DROP] = L_EXPLORE_TITLE_SHOW_STR.NORMAL_DROP,
	[TILE_SHOW_CLASS.SPECIAL_EVENT] = L_EXPLORE_TITLE_SHOW_STR.SPECIAL_EVENT,
	[TILE_SHOW_CLASS.ROGUE_SP_TILE1] = L_EXPLORE_TITLE_SHOW_STR.ROGUE_SP_TILE1,
	[TILE_SHOW_CLASS.ROGUE_SP_TILE2] = L_EXPLORE_TITLE_SHOW_STR.ROGUE_SP_TILE2
}
ICON_TITLE_IMG = {
	[TILE_TYPE.SPECIAL_ENEMY] = "explore/monster_title1.png"
}
MAP_CLASS_STR = {
	PlAYER_CLASS[1],
	PlAYER_CLASS[2],
	PlAYER_CLASS[3],
	L_ACTIVITY
}

local var_0_52 = {
	[50502001] = true,
	[50501001] = true,
	[50006001] = true
}

local function var_0_53(arg_1_0)
	local var_1_0, var_1_1 = arg_1_0:match("([^,]+),(.+)")

	return tonumber(var_1_0), tonumber(var_1_1)
end

local function var_0_54(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0 > arg_2_2 - arg_2_1 then
		arg_2_0 = arg_2_2 - arg_2_1
	end

	local var_2_0 = {}

	for iter_2_0 = arg_2_1, arg_2_2 do
		if arg_2_0 >= math.random(1, arg_2_2 - iter_2_0 + 1) then
			table.insert(var_2_0, iter_2_0)

			arg_2_0 = arg_2_0 - 1

			if arg_2_0 <= 0 then
				break
			end
		end
	end

	return var_2_0
end

local function var_0_55(arg_3_0, arg_3_1)
	local var_3_0 = #arg_3_0

	while 1 <= var_3_0 do
		local var_3_1 = math.ceil(1 + (var_3_0 - 1) / 2)
		local var_3_2 = arg_3_0[var_3_1 - 1] or 0
		local var_3_3

		if var_3_2 < arg_3_1 and arg_3_1 <= arg_3_0[var_3_1] then
			return var_3_1
		elseif arg_3_0[var_3_1] < arg_3_1 then
			var_3_3 = var_3_1 + 1
		elseif arg_3_1 <= var_3_2 then
			var_3_0 = var_3_1 - 1
		end
	end

	if var_3_0 <= 1 then
		return 1
	end

	return var_3_0
end

function RogueExploreModel:create(arg_4_1)
	local var_4_0 = RogueExploreModel.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function RogueExploreModel:init(arg_5_1)
	self.activityid = arg_5_1.activityid
	self.levelid = arg_5_1.levelid
	self.aimid = arg_5_1.aimid
	self.array = arg_5_1.array
	self.levelmode = nil
	self.dieCount = 0

	self:gen_test_map_info()
	self:init_info_by_server(arg_5_1.server_info)
end

function RogueExploreModel:getCurData(arg_6_1)
	return ({
		map = function()
			return require("data.explore.map_data")
		end,
		room = function()
			return require("data.explore.room_data")
		end,
		roomTile = function()
			return require("data.explore.room_tile_data")
		end,
		tile = function()
			return require("data.explore.tile_data")
		end,
		level = function()
			return require("data.explore.explore_level_data")
		end,
		monster = function()
			return require("data.explore.explore_monster_data")
		end,
		monsterTeam = function()
			return require("data.explore.explore_monster_team_data")
		end
	})[self]()
end

function RogueExploreModel:reset_map()
	require("controller.rogue_explore_manager"):removeRogue(self.activityid .. "_" .. self.levelid)
end

function RogueExploreModel:move_cur_pos(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	return
end

function RogueExploreModel:beginExploreFight(arg_16_1)
	require("controller.rogue_explore_manager"):setCurFightModel(self.activityid .. "_" .. self.levelid)

	if self.fightBeginCallback then
		self.fightBeginCallback(arg_16_1)
	else
		self.levelmode = arg_16_1
		self.dieCount = 0

		FightManager.refreshFightToType(FIGHTTYPE_ROGUEEXPLORE)
		LayerManager:switchShowLayer("FightLayer", {
			is_hide_topcost = true,
			is_hide_listbutton = true
		})
	end
end

function RogueExploreModel:initCurrentPlayer()
	SmallFightLayer.getInstance():initExplorePlayer(self.curMapConfig.array)
end

function RogueExploreModel:isHpInherit(arg_18_1)
	return true
end

function RogueExploreModel:getExplorePlayer()
	if self:isHpInherit() then
		local var_19_0 = {}

		for iter_19_0, iter_19_1 in ipairs(self.curMapConfig.array) do
			if iter_19_1.fight_girl then
				local var_19_1 = iter_19_1.npcid or iter_19_1.fight_girl
				local var_19_2 = self.curMapConfig.hpInheritCache[var_19_1] or 1
				local var_19_3 = {
					fight_girl = iter_19_1.fight_girl
				}

				var_19_3.npcid = iter_19_1.npcid or nil
				var_19_3.servantskin = iter_19_1.servantskin or nil
				var_19_3.assist_girl = iter_19_1.assist_girl or nil
				var_19_3.isMainCharacter = not not iter_19_1.isMainCharacter
				var_19_3.extraConfig = {
					percentHp = var_19_2,
					saveHpInherit = function(arg_20_0, arg_20_1)
						self:saveHpInherit(var_19_1, arg_20_0 / arg_20_1)
					end
				}

				table.insert(var_19_0, var_19_3)
			end
		end

		self.curMapConfig.array = var_19_0

		return self.curMapConfig.array, self.curMapConfig.player_science_limit
	else
		return self.curMapConfig.array, self.curMapConfig.player_science_limit
	end
end

function RogueExploreModel:getExploreCurLevelData()
	local var_21_0 = self.getCurData("level")

	assert(var_21_0[self.levelmode], self.levelmode)

	return var_21_0[self.levelmode]
end

function RogueExploreModel:initBossList(arg_22_1)
	arg_22_1 = arg_22_1 or self.levelmode

	local var_22_0 = {}
	local var_22_1 = self.getCurData("monster")
	local var_22_2 = self.getCurData("level")[arg_22_1].boss_team
	local var_22_3 = self.getCurData("monsterTeam")[var_22_2]

	assert(var_22_3 ~= nil, "there is no data of team " .. var_22_2 .. " in monster team data!!!")

	while var_22_3["monster" .. 1] do
		local var_22_4 = #var_22_0 + 1

		var_22_0[#var_22_0 + 1] = {}
		var_22_0[#var_22_0 + 1].id = var_22_3["monster" .. 1]
		var_22_0[#var_22_0 + 1].majorlist = var_22_1[var_22_3["monster" .. 1]]
		var_22_0[#var_22_0 + 1].pos = var_22_3["pos" .. 1]
		var_22_0[#var_22_0 + 1].posy = var_22_3["posy" .. 1]
		var_22_0[#var_22_0 + 1].delaytime = var_22_3["delay" .. 1]
		var_22_0[#var_22_0 + 1].offset = var_22_3["offset" .. 1]

		if self:isHpInherit() and self.uniqueMonsterId then
			local var_22_5 = {}

			var_22_5.percentHp = self.curMapConfig.hpInheritCache[var_22_0[#var_22_0 + 1].id .. self.uniqueMonsterId] or 1

			function var_22_5.saveHpInherit(arg_23_0, arg_23_1)
				self:saveHpInherit(var_22_0[var_22_4].id .. self.uniqueMonsterId, arg_23_0 / arg_23_1)
			end

			var_22_0[#var_22_0 + 1].extraConfig = var_22_5
		end
	end

	if var_22_3.boss then
		var_22_0.boss = {}
		var_22_0.boss.id = var_22_3.boss
		var_22_0.boss.majorlist = var_22_1[var_22_3.boss]
		var_22_0.boss.pos = var_22_3.posboss
		var_22_0.boss.posy = var_22_3.posyboss
		var_22_0.boss.delaytime = var_22_3.delayboss
		var_22_0.boss.offset = var_22_3.offsetboss

		if self:isHpInherit() and self.uniqueMonsterId then
			local var_22_7 = {}

			var_22_7.percentHp = self.curMapConfig.hpInheritCache[var_22_3.boss .. self.uniqueMonsterId] or 1

			function var_22_7.saveHpInherit(arg_24_0, arg_24_1)
				self:saveHpInherit(var_22_3.boss .. self.uniqueMonsterId, arg_24_0 / arg_24_1)
			end

			var_22_0.boss.extraConfig = var_22_7
		end
	end

	return var_22_0
end

function RogueExploreModel:initBossListInfo(arg_25_1)
	arg_25_1 = arg_25_1 or self.levelmode

	local var_25_0 = {
		monster = {}
	}
	local var_25_1 = self.getCurData("monster")
	local var_25_2 = self.getCurData("level")[arg_25_1].boss_team
	local var_25_3 = self.getCurData("monsterTeam")[var_25_2]

	assert(var_25_3 ~= nil, "there is no data of team " .. var_25_2 .. " in monster team data!!!")

	while var_25_3["monster" .. 1] do
		var_25_0.monster[#var_25_0.monster + 1] = {}
		var_25_0.monster[#var_25_0.monster + 1].id = var_25_3["monster" .. 1]
		var_25_0.monster[#var_25_0.monster + 1].majorlist = var_25_1[var_25_3["monster" .. 1]]
		var_25_0.monster[#var_25_0.monster + 1].pos = var_25_3["pos" .. 1]
		var_25_0.monster[#var_25_0.monster + 1].posy = var_25_3["posy" .. 1]
		var_25_0.monster[#var_25_0.monster + 1].delaytime = var_25_3["delay" .. 1]
		var_25_0.monster[#var_25_0.monster + 1].offset = var_25_3["offset" .. 1]
	end

	if var_25_3.boss then
		var_25_0.boss = {}
		var_25_0.boss.id = var_25_3.boss
		var_25_0.boss.majorlist = var_25_1[var_25_3.boss]
		var_25_0.boss.pos = var_25_3.posboss
		var_25_0.boss.posy = var_25_3.posyboss
		var_25_0.boss.delaytime = var_25_3.delayboss
		var_25_0.boss.offset = var_25_3.offsetboss
	end

	return var_25_0
end

function RogueExploreModel:fightSuccess(arg_26_1)
	if not self:executeFightFinishHandler() then
		return
	end

	if self.fightFinishCallback then
		if self:isHpInherit() then
			self.fightFinishCallback(arg_26_1, 0)
		else
			self.fightFinishCallback(arg_26_1, self.dieCount)
		end
	end
end

function RogueExploreModel:fightFail(arg_27_1)
	if not self:executeFightFinishHandler() then
		return
	end

	if self.fightFinishCallback then
		if self:isHpInherit() then
			self.fightFinishCallback(arg_27_1, 0, true)
		else
			self.fightFinishCallback(arg_27_1, -1 * #self.curMapConfig.array)
		end
	end
end

function RogueExploreModel:fightSurrender(arg_28_1)
	if not self:executeFightFinishHandler() then
		return
	end

	if self.fightFinishCallback then
		if self:isHpInherit() then
			self.fightFinishCallback(arg_28_1, 0, true)
		else
			self.fightFinishCallback(arg_28_1, self.dieCount, true)
		end
	end
end

function RogueExploreModel:executeFightFinishHandler()
	if not self:isHpInherit() then
		return true
	end

	local var_29_0 = true

	self.preArrayCount = #self.curMapConfig.array

	for iter_29_0 = #self.curMapConfig.array, 1, -1 do
		if self:getHpInherit(self.curMapConfig.array[iter_29_0].npcid or self.curMapConfig.array[iter_29_0].fight_girl) <= 0 then
			if self.curMapConfig.array[iter_29_0].isMainCharacter then
				var_29_0 = false

				break
			end

			table.remove(self.curMapConfig.array, iter_29_0)
		end
	end

	if not var_29_0 or #self.curMapConfig.array == 0 and self:isAllGirlDeaded() then
		self:rogueExploreFailServer()

		return false
	end

	playermodel:updateExploreArrays(self.arrayIndex, self.curMapConfig.array)

	if not self.curMapConfig.change_role_modelid then
		self:triggerEvent(EVENT_TYPE.CHANGE_DRESS)
	end

	return true
end

function RogueExploreModel:rogueExploreFailServer()
	network:rpc("activity_rogue_explore_fail", {
		activityid = self.activityid,
		levelid = self.levelid
	}, function(arg_31_0)
		print("activity_rogue_explore_fail", arg_31_0.result)
		RogueExploreLayer.getInstance():showFailLayer()
		self:reset_map()
	end)
end

function RogueExploreModel:rogueExploreRetreatServer()
	network:rpc("activity_rogue_explore_retreat", {
		activityid = self.activityid,
		levelid = self.levelid
	}, function(arg_33_0)
		print("activity_rogue_explore_retreat", arg_33_0.result)
	end)
end

function RogueExploreModel:isAllGirlDeaded()
	for iter_34_0, iter_34_1 in pairs((require("data.servant_data"))) do
		if playermodel.haveServant[iter_34_1.id] and self:getHpInherit(iter_34_1.id) > 0 then
			return false
		end
	end

	return true
end

function RogueExploreModel:onPlayerDie()
	self.dieCount = self.dieCount or 0
	self.dieCount = self.dieCount + 1
end

function RogueExploreModel:setFightBeginCallback(arg_36_1)
	self.fightBeginCallback = arg_36_1
end

function RogueExploreModel:clearExploreInfoHpInherit()
	self.fightBeginCallback = nil
	self.arrayIndex = 1
	self.uniqueMonsterId = nil
	self.preArrayCount = 0
	self.modelId = nil
end

function RogueExploreModel:setFightFinishCallback(arg_38_1)
	self.fightFinishCallback = arg_38_1
end

function RogueExploreModel:getExploringbuffList()
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(self.curMapConfig.itemcache) do
		if item_data[iter_39_1.itemid].bag_item_type == 40 and item_data[iter_39_1.itemid].buffid then
			table.insert(var_39_0, item_data[iter_39_1.itemid].buffid)
		end
	end

	if next(var_39_0) == nil then
		-- block empty
	end

	return var_39_0
end

local function var_0_57(arg_41_0, arg_41_1)
	if not arg_41_0 then
		return
	end

	local var_41_0 = {}

	if type(arg_41_0) == "number" then
		var_41_0 = {
			{
				roomorder = arg_41_1,
				controller_idx = arg_41_0
			}
		}
	elseif type(arg_41_0) == "string" then
		for iter_41_0 in arg_41_0:gmatch("([^,]+)") do
			local var_41_1
			local var_41_2

			if string.find(iter_41_0, "-") then
				var_41_1, var_41_2 = iter_41_0:match("([^-]+)-([^-]+)")
				var_41_2 = tonumber(var_41_1)
				var_41_1 = tonumber(var_41_1)
			else
				var_41_1 = arg_41_1
				var_41_2 = tonumber(iter_41_0)
			end

			var_41_0[#var_41_0 + 1] = {
				roomorder = var_41_1,
				controller_idx = var_41_2
			}
		end
	end

	return var_41_0
end

local function var_0_58(arg_42_0)
	local var_42_0, var_42_1 = arg_42_0:match("(%d+)-(%d+)")
	local var_42_2 = tonumber(var_42_1)
	local var_42_3 = tonumber(var_42_0)
	local var_42_4 = math.floor((var_42_3 - 1) / 10) + 1
	local var_42_5

	if var_42_3 - var_42_2 == -10 then
		var_42_5 = var_42_4 * (10 - 1) + (var_42_4 - 1) * 10 + ((var_42_3 - 1) % 10 + 1)
	elseif var_42_3 - var_42_2 == 10 then
		var_42_5 = (var_42_4 - 1) * (10 - 1) + (var_42_4 - 1 - 1) * 10 + ((var_42_3 - 1) % 10 + 1)
	elseif var_42_3 - var_42_2 == 1 then
		var_42_5 = (var_42_4 - 1) * (10 - 1 + 10) + ((var_42_3 - 1) % 10 + 1) - 1
	elseif var_42_3 - var_42_2 == -1 then
		var_42_5 = (var_42_4 - 1) * (10 - 1 + 10) + ((var_42_3 - 1) % 10 + 1)
	end

	return var_42_5
end

function RogueExploreModel:getBridgeOrder(arg_43_1)
	return var_0_58(arg_43_1)
end

local function var_0_59(arg_44_0)
	local var_44_0 = {}

	for iter_44_0 in arg_44_0:gmatch("([^,]+)") do
		table.insert(var_44_0, iter_44_0)
	end

	return var_44_0[math.random(#var_44_0)]
end

function RogueExploreModel:canMopUp()
	if not self.curMapConfig or not self.curMapConfig.offerid then
		return false
	end

	return self:getMapProgress() == 100
end

function RogueExploreModel:get_map_cad_config(arg_46_1)
	local var_46_0 = math.floor((arg_46_1 - 1) / 200) + 1
	local var_46_1 = {}

	for iter_46_0 = (arg_46_1 - 1) % 200 + 1, (arg_46_1 - 1) % 200 + 1 + 10 - 1 do
		for iter_46_1 = var_46_0, var_46_0 + 10 - 1 do
			if cad_data[iter_46_1]["x_" .. iter_46_0] then
				if cad_data[iter_46_1]["x_" .. iter_46_0]:find(",") then
					local var_46_2, var_46_3 = cad_data[iter_46_1]["x_" .. iter_46_0]:match("(.+),(.+)")

					var_46_1[(iter_46_1 - var_46_0 + 1 - 1) * 10 + (iter_46_0 - ((arg_46_1 - 1) % 200 + 1) + 1)] = var_46_2
					var_46_1[(iter_46_1 - var_46_0 + 1 - 1) * 10 + (iter_46_0 - ((arg_46_1 - 1) % 200 + 1) + 1) + 100] = var_46_3
				else
					var_46_1[(iter_46_1 - var_46_0 + 1 - 1) * 10 + (iter_46_0 - ((arg_46_1 - 1) % 200 + 1) + 1)] = cad_data[iter_46_1]["x_" .. iter_46_0]
				end
			end
		end
	end

	return var_46_1
end

function RogueExploreModel:getRoomid(arg_47_1, arg_47_2)
	return self:get_map_cad_config(self.getCurData("map", 201)[arg_47_1].map_cad_id)[arg_47_2]
end

function RogueExploreModel:getBridgeOrderByDirection(arg_48_1, arg_48_2)
	local var_48_0 = cc.size(10, 10)
	local var_48_1 = math.floor((arg_48_1 - 1) / var_48_0.width) + 1
	local var_48_2

	if arg_48_2 == var_0_36 then
		var_48_2 = (var_48_1 - 1) * (var_48_0.width - 1) + (var_48_1 - 1 - 1) * var_48_0.width + ((arg_48_1 - 1) % var_48_0.width + 1)
	elseif arg_48_2 == var_0_38 then
		var_48_2 = var_48_1 * (var_48_0.width - 1) + (var_48_1 - 1) * var_48_0.width + ((arg_48_1 - 1) % var_48_0.width + 1)
	elseif arg_48_2 == var_0_39 then
		var_48_2 = (var_48_1 - 1) * (var_48_0.width - 1 + var_48_0.width) + ((arg_48_1 - 1) % var_48_0.width + 1) - 1
	elseif arg_48_2 == var_0_37 then
		var_48_2 = (var_48_1 - 1) * (var_48_0.width - 1 + var_48_0.width) + ((arg_48_1 - 1) % var_48_0.width + 1)
	end

	return var_48_2
end

function RogueExploreModel:checkBridegRoomClosed(arg_49_1, arg_49_2)
	local var_49_0 = cc.size(10, 10)
	local var_49_1 = math.floor((arg_49_1 - 1) / var_49_0.width) + 1
	local var_49_2 = {}

	for iter_49_0 = 1, 4 do
		if iter_49_0 == var_0_36 and var_49_1 ~= 1 then
			var_49_2[(var_49_1 - 1) * (var_49_0.width - 1) + (var_49_1 - 1 - 1) * var_49_0.width + ((arg_49_1 - 1) % var_49_0.width + 1)] = true
		elseif iter_49_0 == var_0_38 and var_49_1 ~= 10 then
			var_49_2[var_49_1 * (var_49_0.width - 1) + (var_49_1 - 1) * var_49_0.width + ((arg_49_1 - 1) % var_49_0.width + 1)] = true
		elseif iter_49_0 == var_0_39 and (arg_49_1 - 1) % var_49_0.width + 1 ~= 1 then
			var_49_2[(var_49_1 - 1) * (var_49_0.width - 1 + var_49_0.width) + ((arg_49_1 - 1) % var_49_0.width + 1) - 1] = true
		elseif iter_49_0 == var_0_37 and (arg_49_1 - 1) % var_49_0.width + 1 ~= 10 then
			var_49_2[(var_49_1 - 1) * (var_49_0.width - 1 + var_49_0.width) + ((arg_49_1 - 1) % var_49_0.width + 1)] = true
		end
	end

	return not not var_49_2[arg_49_2]
end

function RogueExploreModel:getCurMapMaxSize(arg_50_1)
	local cad_data = require("data.explore.cad_data")
	local var_50_1 = math.floor((arg_50_1 - 1) / 200) + 1
	local var_50_3 = 0
	local var_50_4 = 0

	for iter_50_0 = (arg_50_1 - 1) % 200 + 1, (arg_50_1 - 1) % 200 + 1 + 10 - 1 do
		for iter_50_1 = var_50_1, var_50_1 + 10 - 1 do
			if cad_data[iter_50_1]["x_" .. iter_50_0] then
				var_50_3 = var_50_3 < iter_50_0 and iter_50_0 or var_50_3
				var_50_4 = var_50_4 < iter_50_1 and iter_50_1 or var_50_4
			end
		end
	end

	return var_50_3 - ((arg_50_1 - 1) % 200 + 1) + 1, var_50_4 - var_50_1 + 1
end

function RogueExploreModel:objectIsMonster(arg_51_1)
	return MONSTER_TILE_CLASS[self.getCurData("tile", 201)[arg_51_1].class]
end

function RogueExploreModel:decodeImgid(arg_52_1)
	return bit.band(arg_52_1, math.pow(2, 29) - 1), (bit.rshift(arg_52_1, 29))
end

function RogueExploreModel:gen_test_map_info()
	local bit = require("bit")
	local explore_aim_data = require("data.explore.explore_aim_data")
	local room_data = require("data.explore.room_data")
	local room_tile_data = require("data.explore.room_tile_data")
	local tile_data = require("data.explore.tile_data")
	local explore_level_data = require("data.explore.explore_level_data")
	local explore_monster_team_data = require("data.explore.explore_monster_team_data")
	local var_53_7 = self.aimid

	print("aimid=====", self.aimid)

	local var_53_8 = explore_aim_data[var_53_7]
	local var_53_9 = explore_aim_data[var_53_7].mapid
	local var_53_10 = require("data.explore.explore_effect_data")[var_53_7]
	local var_53_11 = require("data.explore.explore_particle_data")[var_53_7]
	local var_53_12 = require("data.explore.explore_room_color_data")[var_53_7]
	local var_53_13 = require("data.explore.explore_jump_room_effect_data")[var_53_7]
	local var_53_14 = cc.size(tonumber(10), tonumber(10))
	local var_53_15 = {
		[10] = var_0_36,
		[-1] = var_0_37,
		[-10] = var_0_38,
		var_0_39
	}
	local var_53_16 = self:get_map_cad_config(require("data.explore.map_data")[explore_aim_data[var_53_7].mapid].map_cad_id)
	local var_53_17 = self:get_map_cad_config(explore_aim_data[var_53_7].object_cad_id)
	local var_53_18 = self.player_science_limit or 1
	local var_53_19 = self.array or {}
	local var_53_20 = {}
	local var_53_21 = {}
	local var_53_22 = {}
	local var_53_23 = {}
	local var_53_24 = {}
	local var_53_25 = {}
	local var_53_26 = {}
	local var_53_27 = {}
	local var_53_28 = {}
	local var_53_29 = {}
	local var_53_30 = {}
	local var_53_31 = {}
	local var_53_32 = {}
	local var_53_33 = {}
	local var_53_34 = {}
	local var_53_35 = {}
	local var_53_36 = {}
	local var_53_37 = 1

	local function var_53_38(arg_54_0)
		if not TILE_SHOW_STR[arg_54_0] then
			return
		end

		if not var_53_29[arg_54_0] then
			var_53_29[arg_54_0] = {
				used = 0,
				total = 1
			}
		else
			var_53_29[arg_54_0].total = var_53_29[arg_54_0].total + 1
		end
	end

	local var_53_40 = {}

	local function var_53_41(arg_55_0)
		local var_55_0 = arg_55_0.result or 1
		local var_55_1 = tile_data[arg_55_0.tileid]

		if var_53_40[arg_55_0.tileid] then
			return
		end

		var_53_40[arg_55_0.tileid] = 1

		if self:objectIsMonster(arg_55_0.tileid) then
			local var_55_2 = var_55_1["result" .. var_55_0 .. "_param"]

			if not var_55_1["result" .. var_55_0 .. "_param"] or not explore_level_data[var_55_2] then
				print("error result", var_55_0, var_55_2, arg_55_0.tileid)
			end

			table.insert(var_53_36, explore_monster_team_data[explore_level_data[var_55_2].boss_team].boss_icon)
		elseif var_55_1.class == TILE_TYPE.POKEMON then
			table.insert(var_53_36, require("data.horcrux_data")[require("data.explore.explore_horcrux_data")[var_55_1["result" .. var_55_0 .. "_param"]].horcruxid].model)
		elseif var_55_1.model then
			table.insert(var_53_36, var_55_1.model)
		end

		if var_55_1.trigger_theater then
			for iter_55_0, iter_55_1 in pairs(explore_script_data) do
				if iter_55_1.classification == var_55_1.trigger_theater and iter_55_1.model then
					table.insert(var_53_36, iter_55_1.model)
				end
			end
		end

		if var_55_1["result" .. var_55_0 .. "_type"] == EVENT_TYPE.CHANGE_ROLEMODEL then
			table.insert(var_53_36, var_55_1["result" .. var_55_0 .. "_param"])
		end

		if var_55_1.finished_tile then
			var_53_41({
				tileid = var_55_1.finished_tile
			})
		end
	end

	local function var_53_42()
		local var_56_0 = {}
		local var_56_1 = 1

		while var_53_8["mark" .. var_56_1 .. "_room"] do
			local var_56_2 = {}

			for iter_56_0 in string.gmatch(var_53_8["mark" .. var_56_1 .. "_room"], "%d+") do
				local var_56_3 = tonumber(iter_56_0)

				if var_53_17[var_56_3] then
					if room_tile_data[var_53_17[var_56_3]]["mark_points" .. var_53_8["mark" .. var_56_1 .. "_tileid"]] then
						for iter_56_1, iter_56_2 in pairs(room_tile_data[var_53_17[var_56_3]]["mark_points" .. var_53_8["mark" .. var_56_1 .. "_tileid"]]) do
							table.insert(var_56_2, {
								roomorder = var_56_3,
								idx = iter_56_1,
								order = iter_56_2.order,
								is_replace = iter_56_2.is_replace,
								controller = var_0_57(iter_56_2.controller, var_56_3)
							})
						end
					end
				else
					table.insert(var_56_2, {
						is_invalid = true,
						roomorder = var_56_3
					})
				end
			end

			if #var_56_2 == 1 then
				if var_56_0[var_56_2[1].roomorder] then
					var_56_0[var_56_2[1].roomorder][var_56_2[1].idx] = {
						order = var_56_2[1].order,
						tileid = var_53_8["mark" .. var_56_1 .. "_tileid"],
						is_replace = var_56_2[1].is_replace,
						controller = var_56_2[1].controller
					}
				else
					var_56_0[var_56_2[1].roomorder] = {
						[var_56_2[1].idx] = {
							order = var_56_2[1].order,
							tileid = var_53_8["mark" .. var_56_1 .. "_tileid"],
							is_replace = var_56_2[1].is_replace,
							controller = var_56_2[1].controller
						}
					}
				end
			else
				for iter_56_3, iter_56_4 in pairs((var_0_54(var_53_8["mark" .. var_56_1 .. "_num"], 1, #var_56_2))) do
					if not var_56_2[iter_56_4].is_invalid then
						if var_56_0[var_56_2[iter_56_4].roomorder] then
							var_56_0[var_56_2[iter_56_4].roomorder][var_56_2[iter_56_4].idx] = {
								order = var_56_2[iter_56_4].order,
								tileid = var_53_8["mark" .. var_56_1 .. "_tileid"],
								is_replace = var_56_2[iter_56_4].is_replace,
								controller = var_56_2[1].controller
							}
						else
							var_56_0[var_56_2[iter_56_4].roomorder] = {
								[var_56_2[iter_56_4].idx] = {
									order = var_56_2[iter_56_4].order,
									tileid = var_53_8["mark" .. var_56_1 .. "_tileid"],
									is_replace = var_56_2[iter_56_4].is_replace,
									controller = var_56_2[1].controller
								}
							}
						end
					end
				end
			end

			var_56_1 = var_56_1 + 1
		end

		return var_56_0
	end

	local function var_53_43(arg_57_0)
		local var_57_0

		local function var_57_1()
			local var_58_0 = 0
			local var_58_1 = {}
			local var_58_2 = {}

			while tile_data[arg_57_0]["result" .. 1 .. "_weight"] do
				var_58_0 = var_58_0 + tile_data[arg_57_0]["result" .. 1 .. "_weight"]

				table.insert(var_58_1, var_58_0)
				table.insert(var_58_2, 1)
			end

			return var_58_2[var_0_55(var_58_1, math.random(1, var_58_0))]
		end

		assert(tile_data[arg_57_0], arg_57_0 .. " " .. type(arg_57_0))

		if MONSTER_TILE_CLASS[tile_data[arg_57_0].class] then
			var_57_0 = self.levelid == 1 and 1 or 2

			if not tile_data[arg_57_0]["result" .. var_57_0 .. "_type"] then
				var_57_0 = 1
			end
		elseif tile_data[arg_57_0].class == TILE_TYPE.POKEMON then
			var_57_0 = var_57_1()

			if tile_data[arg_57_0]["result" .. var_57_0 .. "_param"] == "-1" then
				return -1
			end
		elseif tile_data[arg_57_0].result1_type == EVENT_TYPE.SHOP_ITEM then
			var_57_0 = (function()
				local var_59_0 = 0
				local var_59_1 = {}
				local var_59_2 = {}
				local var_59_3 = explore_sellweapon_data[tonumber(tile_data[arg_57_0].result1_param)]

				while var_59_3["weaponclass" .. 1] do
					var_59_0 = var_59_0 + var_59_3["weight" .. 1]

					table.insert(var_59_1, var_59_0)
					table.insert(var_59_2, 1)
				end

				return var_59_2[var_0_55(var_59_1, math.random(1, var_59_0))]
			end)()
		elseif tile_data[arg_57_0].is_result_random == 1 then
			var_57_0 = var_57_1()
		end

		return var_57_0
	end

	local var_53_44 = {}

	;(function()
		for iter_60_0 in var_53_8.bridges:gmatch("([^,]+)") do
			local var_60_1 = {}

			for iter_60_1 in iter_60_0:gmatch("([^-]+)") do
				var_60_1[#var_60_1 + 1] = iter_60_1
			end

			local var_60_2 = tonumber(var_60_1[1])
			local var_60_3 = tonumber(var_60_1[2])

			if next(var_53_20) == nil then
				var_53_37 = var_60_2
			end

			if var_60_1[3] then
				var_53_31[var_0_58(var_60_2 .. "-" .. var_60_3)] = tonumber(var_60_1[3])
			end

			var_53_20[var_60_2] = var_53_20[var_60_2] or {
				nexts = {}
			}

			if var_60_3 and not var_53_20[var_60_3] then
				var_53_20[var_60_3] = {
					nexts = {}
				}
			end

			if var_60_3 then
				var_53_20[var_60_2].nexts[var_53_15[var_60_2 - var_60_3]] = var_60_3
				var_53_20[var_60_3].nexts[var_53_15[var_60_3 - var_60_2]] = var_60_2
			end
		end

		if next(var_53_20) == nil then
			var_53_37 = tonumber(var_53_8.bridges)
			var_53_20[var_53_37] = {
				nexts = {}
			}
		end

		local var_60_4 = {}

		for iter_60_2, iter_60_3 in pairs(var_53_20) do
			var_60_4[iter_60_2 + 100] = {
				nexts = {}
			}

			for iter_60_4, iter_60_5 in pairs(iter_60_3.nexts) do
				var_60_4[iter_60_2 + 100].nexts[iter_60_4] = iter_60_5 + 100
			end
		end

		for iter_60_6, iter_60_7 in pairs(var_60_4) do
			var_53_20[iter_60_6] = iter_60_7
		end
	end)()
	;(function()
		local var_62_0 = var_53_42()

		for iter_62_0, iter_62_1 in pairs(var_53_20) do
			print(iter_62_0, room_data[var_53_16[iter_62_0]], "roomid:" .. var_53_16[iter_62_0])
			assert(room_data[var_53_16[iter_62_0]], "roomid:" .. var_53_16[iter_62_0])

			local var_62_1 = room_data[var_53_16[iter_62_0]]
			local var_62_2

			var_53_21[iter_62_0] = {}
			var_53_22[iter_62_0] = {}
			var_53_23[iter_62_0] = {}
			var_53_24[iter_62_0] = {}
			var_53_25[iter_62_0] = {}
			var_53_26[iter_62_0] = {}
			var_53_30[iter_62_0] = {}

			if var_53_17[iter_62_0] then
				var_62_2 = var_0_59(var_53_17[iter_62_0])

				assert(room_tile_data[var_62_2], var_53_7 .. " " .. var_62_2)

				for iter_62_2, iter_62_3 in ipairs(room_tile_data[var_62_2].object_idx_tbl) do
					local var_62_3 = var_53_43(room_tile_data[var_62_2][iter_62_3].tileid)

					if not var_62_3 or var_62_3 and var_62_3 > 0 then
						var_53_21[iter_62_0][iter_62_3] = {
							usedcount = 0,
							tileid = room_tile_data[var_62_2][iter_62_3].tileid,
							order = room_tile_data[var_62_2][iter_62_3].order,
							result = var_62_3,
							range = {}
						}

						if room_tile_data[var_62_2][iter_62_3].is_replace then
							var_53_22[iter_62_0][room_tile_data[var_62_2][iter_62_3].order] = true
						end

						if room_tile_data[var_62_2][iter_62_3].controller then
							print("roomindex", iter_62_0, "object_idx", iter_62_3)

							var_53_21[iter_62_0][iter_62_3].controller = var_0_57(room_tile_data[var_62_2][iter_62_3].controller, iter_62_0)
						end

						local var_62_4, var_62_5 = self:getTileSize(room_tile_data[var_62_2][iter_62_3].tileid)
						local var_62_6 = (room_tile_data[var_62_2][iter_62_3].order - 1) % var_62_1.width_num + 1
						local var_62_7 = math.floor((room_tile_data[var_62_2][iter_62_3].order - 1) / var_62_1.width_num) + 1

						for iter_62_4 = (room_tile_data[var_62_2][iter_62_3].order - 1) % var_62_1.width_num + 1, (room_tile_data[var_62_2][iter_62_3].order - 1) % var_62_1.width_num + 1 + var_62_4 - 1 do
							for iter_62_5 = var_62_7, var_62_7 + var_62_5 - 1 do
								var_53_23[iter_62_0][(iter_62_5 - 1) * var_62_1.width_num + iter_62_4] = iter_62_3
								var_53_21[iter_62_0][iter_62_3].range[(iter_62_5 - 1) * var_62_1.width_num + iter_62_4] = true
							end
						end

						if self:objectIsMonster(room_tile_data[var_62_2][iter_62_3].tileid) and tile_data[room_tile_data[var_62_2][iter_62_3].tileid] and tile_data[room_tile_data[var_62_2][iter_62_3].tileid].trigger_range ~= -1 then
							local var_62_8 = 1
							local var_62_9 = var_62_7 - 1 < 1 and 1 or var_62_7 - var_62_8
							local var_62_10

							if var_62_6 + 1 > var_62_1.width_num then
								var_62_10 = var_62_1.width_num or var_62_6 + var_62_8

								local var_62_11

								if var_62_7 + var_62_8 > var_62_1.height_num then
									var_62_11 = var_62_1.height_num or var_62_7 + var_62_8
								end
							end

							for iter_62_6 = var_62_6 - 1 < 1 and 1 or var_62_6 - var_62_8, var_62_10 do
								for iter_62_7 = var_62_9, var_62_11 do
									var_53_24[iter_62_0][(iter_62_7 - 1) * var_62_1.width_num + iter_62_6] = var_53_24[iter_62_0][(iter_62_7 - 1) * var_62_1.width_num + iter_62_6] or {}

									table.insert(var_53_24[iter_62_0][(iter_62_7 - 1) * var_62_1.width_num + iter_62_6], iter_62_3)

									var_53_21[iter_62_0][iter_62_3].range[(iter_62_7 - 1) * var_62_1.width_num + iter_62_6] = true
								end
							end
						end

						var_53_38(tile_data[room_tile_data[var_62_2][iter_62_3].tileid].show_class)
						var_53_41(var_53_21[iter_62_0][iter_62_3])
					end
				end
			end

			iter_62_1.objectid = var_62_2

			if var_62_0[iter_62_0] then
				for iter_62_8, iter_62_9 in pairs(var_62_0[iter_62_0]) do
					local var_62_12 = var_53_43(iter_62_9.tileid)

					if not var_62_12 or var_62_12 and var_62_12 > 0 then
						var_53_21[iter_62_0][iter_62_8] = {
							usedcount = 0,
							tileid = iter_62_9.tileid,
							order = iter_62_9.order,
							result = var_62_12,
							range = {}
						}

						if iter_62_9.is_replace then
							var_53_22[iter_62_0][iter_62_9.order] = true
						end

						if iter_62_9.controller then
							var_53_21[iter_62_0][iter_62_8].controller = iter_62_9.controller
						end

						local var_62_13, var_62_14 = self:getTileSize(iter_62_9.tileid)
						local var_62_15 = (iter_62_9.order - 1) % var_62_1.width_num + 1
						local var_62_16 = math.floor((iter_62_9.order - 1) / var_62_1.width_num) + 1

						for iter_62_10 = (iter_62_9.order - 1) % var_62_1.width_num + 1, (iter_62_9.order - 1) % var_62_1.width_num + 1 + var_62_13 - 1 do
							for iter_62_11 = var_62_16, var_62_16 + var_62_14 - 1 do
								var_53_23[iter_62_0][(iter_62_11 - 1) * var_62_1.width_num + iter_62_10] = iter_62_8
								var_53_21[iter_62_0][iter_62_8].range[(iter_62_11 - 1) * var_62_1.width_num + iter_62_10] = true
							end
						end

						if self:objectIsMonster(iter_62_9.tileid) and tile_data[iter_62_9.tileid] and tile_data[iter_62_9.tileid].trigger_range ~= 0 then
							local var_62_17 = 1
							local var_62_18 = var_62_16 - 1 < 1 and 1 or var_62_16 - var_62_17
							local var_62_19

							if var_62_15 + 1 > var_62_1.width_num then
								var_62_19 = var_62_1.width_num or var_62_15 + var_62_17

								local var_62_20

								if var_62_16 + var_62_17 > var_62_1.height_num then
									var_62_20 = var_62_1.height_num or var_62_16 + var_62_17
								end
							end

							for iter_62_12 = var_62_15 - 1 < 1 and 1 or var_62_15 - var_62_17, var_62_19 do
								for iter_62_13 = var_62_18, var_62_20 do
									var_53_24[iter_62_0][(iter_62_13 - 1) * var_62_1.width_num + iter_62_12] = var_53_24[iter_62_0][(iter_62_13 - 1) * var_62_1.width_num + iter_62_12] or {}

									table.insert(var_53_24[iter_62_0][(iter_62_13 - 1) * var_62_1.width_num + iter_62_12], iter_62_8)

									var_53_21[iter_62_0][iter_62_8].range[(iter_62_13 - 1) * var_62_1.width_num + iter_62_12] = true
								end
							end
						end

						var_53_38(tile_data[iter_62_9.tileid].show_class)
					end
				end
			end

			for iter_62_14 = 1, var_62_1.width_num * var_62_1.height_num do
				local var_62_21 = math.floor((iter_62_14 - 1) / var_62_1.width_num) + 1
				local var_62_23 = {}

				assert(room_tile_data[var_62_1.imglayer][iter_62_14], "roomInfo.imglayer: " .. var_62_1.imglayer .. "order:" .. iter_62_14)

				for iter_62_15, iter_62_16 in pairs(room_tile_data[var_62_1.imglayer][iter_62_14]) do
					iter_62_16 = self:decodeImgid(iter_62_16)

					assert(explore_img_data[iter_62_16], "explore_img_data no id:" .. iter_62_16)

					if type(iter_62_15) == "number" or type(iter_62_15) == "string" and not var_53_22[iter_62_0][iter_62_14] then
						table.insert(var_62_23, {
							img = iter_62_16,
							z_order = (type(iter_62_15) == "string" or nil) and (room_tile_data[var_62_1.imglayer].max_zorder or iter_62_15)
						})
					end
				end

				table.sort(var_62_23, function(arg_63_0, arg_63_1)
					return arg_63_0.z_order > arg_63_1.z_order
				end)

				if var_62_1.doorsImg[iter_62_14] and not iter_62_1.nexts[var_62_1.doorsImg[iter_62_14].direction] then
					assert(var_62_1.doorsImg[iter_62_14].img, iter_62_14)

					if var_62_1.doorsImg[iter_62_14].is_replace then
						var_62_23[1].img = self:decodeImgid(var_62_1.doorsImg[iter_62_14].img)
					else
						table.insert(var_62_23, 1, {
							img = self:decodeImgid(var_62_1.doorsImg[iter_62_14].img)
						})
					end
				end

				for iter_62_17, iter_62_18 in pairs(var_62_23) do
					if explore_img_data[iter_62_18.img].is_block == 1 then
						local var_62_25 = explore_img_data[iter_62_18.img].touch_height or 1

						for iter_62_19 = (iter_62_14 - 1) % var_62_1.width_num + 1, (iter_62_14 - 1) % var_62_1.width_num + 1 + (explore_img_data[iter_62_18.img].touch_width or 1) - 1 do
							for iter_62_20 = var_62_21, var_62_21 + var_62_25 - 1 do
								var_53_25[iter_62_0][(iter_62_20 - 1) * var_62_1.width_num + iter_62_19] = true
							end
						end
					end

					if explore_img_data[iter_62_18.img].sp_env then
						var_53_26[iter_62_0][(var_62_21 - 1) * var_62_1.width_num + ((iter_62_14 - 1) % var_62_1.width_num + 1)] = explore_img_data[iter_62_18.img].sp_env
					end
				end
			end

			while var_62_1["light" .. 1] do
				local var_62_26 = {
					light = var_62_1["light" .. 1]
				}

				var_62_26.light_pos = cc.p(var_0_53(var_62_1["light" .. 1 .. "_pos"])) or cc.p(0, 0)
				var_62_26.light_scale = var_62_1["light" .. 1 .. "_scale"]
				var_62_26.light_opacity = var_62_1["light" .. 1 .. "_opacity"]
				var_62_26.light_offset = cc.p(var_0_53(var_62_1["light" .. 1 .. "_offset"])) or cc.p(0, 0)

				table.insert(var_53_30[iter_62_0], var_62_26)
			end
		end
	end)()
	;(function()
		while var_53_8["aim" .. 1 .. "_des"] do
			local var_64_1 = {
				result_type = "map",
				flag = 0,
				tileid = var_53_8["aim" .. 1 .. "_param1"]
			}

			var_64_1.num = var_53_8["aim" .. 1 .. "_param2"] or 1
			var_64_1.aim_condition = var_53_8["aim" .. 1 .. "_condition"]
			var_64_1.trigger_objectidx = var_53_8["aim" .. 1 .. "_trigger_object"]
			var_64_1.trigger_condition = var_53_8["aim" .. 1 .. "_trigger_condition"]
			var_64_1.des = var_53_8["aim" .. 1 .. "_des"]
			var_64_1.is_show = not var_53_8["aim" .. 1 .. "_trigger_object"]
			var_64_1.order = 1
			var_53_28[var_53_8["aim" .. 1 .. "_param1"]] = var_64_1
		end

		local var_64_3 = 1

		while var_53_8["lock" .. var_64_3 .. "_bridge"] do
			local var_64_4 = var_0_58(var_53_8["lock" .. var_64_3 .. "_bridge"])

			var_53_27[var_64_4] = {
				tileid = var_53_8["lock" .. var_64_3 .. "_param1"],
				num = var_53_8["lock" .. var_64_3 .. "_param2"],
				room_order1 = tonumber(var_53_8["lock" .. var_64_3 .. "_bridge"]:match("(%d+)-")),
				room_order2 = tonumber(var_53_8["lock" .. var_64_3 .. "_bridge"]:match("-(%d+)"))
			}

			local var_64_5 = {
				result_type = "bridge",
				is_show = false,
				order = 3,
				flag = 0,
				tileid = var_53_8["lock" .. var_64_3 .. "_param1"]
			}

			var_64_5.num = var_53_8["lock" .. var_64_3 .. "_param2"] or 1
			var_64_5.des = var_53_8["lock" .. var_64_3 .. "_des"]
			var_64_5.result_param1 = var_64_4
			var_53_28[var_53_8["lock" .. var_64_3 .. "_param1"]] = var_64_5
			var_64_3 = var_64_3 + 1
		end

		local var_64_6 = 1

		while var_53_8["puzzle" .. var_64_6] do
			var_53_32[var_64_6] = {
				condition = {},
				controller = var_0_57(var_53_8["puzzle" .. var_64_6 .. "_controller"]),
				controller_des = var_53_8["puzzle" .. var_64_6 .. "_controller_des"],
				is_and = var_53_8["puzzle" .. var_64_6 .. "_is_and"] == 1
			}

			for iter_64_0, iter_64_1 in var_53_8["puzzle" .. var_64_6]:gmatch("([^,]+)-([^,]+)") do
				table.insert(var_53_32[var_64_6].condition, {
					puzzleid = iter_64_0,
					puzzlenum = tonumber(iter_64_1)
				})
			end

			var_64_6 = var_64_6 + 1
		end

		if var_53_8.follow_hole then
			for iter_64_2 in var_53_8.follow_hole:gmatch("([^,]+)") do
				local var_64_7 = {}

				for iter_64_3 in iter_64_2:gmatch("([^-]+)") do
					var_64_7[#var_64_7 + 1] = iter_64_3
				end

				if next(var_64_7) then
					var_64_7[3] = var_64_7[3] or 1
					var_53_33[tonumber(var_64_7[1])] = {
						opacity = tonumber(var_64_7[2]),
						scale = tonumber(var_64_7[3])
					}
				end
			end
		end

		if var_53_8.room_teleport then
			for iter_64_4 in var_53_8.room_teleport:gmatch("([^,]+)") do
				local var_64_8 = {}

				for iter_64_5 in iter_64_4:gmatch("([^-]+)") do
					var_64_8[#var_64_8 + 1] = iter_64_5
				end

				if next(var_64_8) then
					var_64_8[2] = var_64_8[2] or "1.9"
					var_53_34[tonumber(var_64_8[1])] = tonumber(var_64_8[2])
				end
			end
		end

		if var_53_8.room_green then
			for iter_64_6 in var_53_8.room_green:gmatch("([^,]+)") do
				local var_64_9 = {}

				for iter_64_7 in iter_64_6:gmatch("([^-]+)") do
					var_64_9[#var_64_9 + 1] = iter_64_7
				end

				if next(var_64_9) then
					var_64_9[2] = var_64_9[2] or "1"
					var_53_35[tonumber(var_64_9[1])] = tonumber(var_64_9[2])
				end
			end
		end
	end)()
	;(function()
		if var_53_19 and next(var_53_19) ~= nil then
			-- block empty
		else
			var_53_19 = {}

			for iter_65_0 = 1, FORMATION_SHOW_GIRL_NUM do
				if var_53_8["fight_girl" .. iter_65_0] then
					local var_65_0 = var_53_8["fight_girl" .. iter_65_0]
					local var_65_1

					print("==============", var_53_8["fight_girl" .. iter_65_0])

					var_65_1 = npc_fightconfig_data[var_65_0].npcsoulid and npc_fightconfig_data[var_65_0].npcsoulid or npc_fightconfig_data[var_65_0].servantid

					table.insert(var_53_19, {
						fight_girl = var_65_1,
						pos = iter_65_0,
						npcid = var_65_0
					})
				end
			end

			self:setCurFightCapacity(require("controller.fight_capacity_manager"):getNpcArrayFightCapacity(var_53_19))
		end

		for iter_65_1, iter_65_2 in pairs(var_53_19) do
			table.insert(var_53_36, self:getCurArrayModel(iter_65_2))
		end
	end)()
	;(function()
		if var_53_8.npc_space then
			var_53_44.space = {
				npc_tileid = var_53_8.npc_space
			}
		end

		if var_53_8.npc_fire then
			var_53_44.fire = {
				npc_tileid = var_53_8.npc_fire
			}
		end

		if var_53_8.npc_hole then
			var_53_44.hole = {
				npc_tileid = var_53_8.npc_hole
			}
		end
	end)()
	;(function()
		local var_67_0 = {}
		local var_67_1 = 0

		for iter_67_0, iter_67_1 in pairs(var_53_21) do
			var_67_0[iter_67_0] = var_67_0[iter_67_0] or {}

			for iter_67_2, iter_67_3 in pairs(iter_67_1) do
				if iter_67_3.tileid == "10010102" then
					if var_67_0[iter_67_0][iter_67_3.order] then
						assert(false, "??????????", var_53_17[iter_67_0], iter_67_2)
					end

					var_67_0[iter_67_0][iter_67_3.order] = iter_67_3
					var_67_0[iter_67_0][iter_67_3.order].object_idx = iter_67_2
					var_67_1 = var_67_1 + 1
				end
			end
		end

		for iter_67_4, iter_67_5 in pairs(var_67_0) do
			for iter_67_6, iter_67_7 in pairs(iter_67_5) do
				if iter_67_4 > 100 then
					local var_67_2 = iter_67_4 - 100 or iter_67_4 + 100

					if var_67_0[var_67_2][iter_67_6] then
						iter_67_7.controller = iter_67_7.controller or {}

						table.insert(iter_67_7.controller, {
							roomorder = var_67_2,
							controller_idx = var_67_0[var_67_2][iter_67_6].object_idx
						})

						goto label_67_0
					end
				end

				assert(false, "??????????", var_53_17[iter_67_4], iter_67_6)

				::label_67_0::
			end
		end

		var_53_29[1].total = var_53_29[1].total - var_67_1 / 2
	end)()

	local var_53_45 = room_tile_data[var_53_20[var_53_37].objectid].birth_points and room_tile_data[var_53_20[var_53_37].objectid].birth_points or room_data[var_53_16[var_53_37]].birth_points
	local var_53_46

	for iter_53_0 = 0, 4 do
		if var_53_45[iter_53_0] then
			var_53_46 = var_53_45[iter_53_0]

			break
		end
	end

	self.curMapConfig = {
		curSpaceType = 1,
		team_hp = 5,
		activityid = self.activityid,
		activity_explore_id = self.levelid,
		roomColor = var_53_12,
		particle = var_53_11,
		effect = var_53_10,
		jumpEffect = var_53_13,
		followQueue = {},
		serverFollowQueue = {},
		mapid = var_53_9,
		aimid = var_53_7,
		mapRoomSize = var_53_14,
		pathtree = var_53_20,
		alignmentType = var_53_31,
		mapBlocks = var_53_25,
		mapEnvs = var_53_26,
		curRoomOrder = var_53_37,
		usedTile = var_53_21,
		mapProgress = var_53_29,
		replaceConfig = var_53_22,
		roomsLight = {},
		objectRange = var_53_23,
		monsterRange = var_53_24,
		curPosIndex = var_53_46,
		array = self.array,
		hpInheritCache = {},
		horcruxCache = {},
		exploredRooms = {
			[var_53_37] = true
		},
		bridgeLocks = var_53_27,
		aimTypeTbl = var_53_28,
		puzzleConfig = var_53_32,
		roomsLightConfig = var_53_30,
		roomfollowholeConfig = var_53_33,
		roomteleportConfig = var_53_34,
		roomgreenConfig = var_53_35,
		spine_model_list = var_53_36,
		finishImgs = {},
		finishedAni = {},
		itemcache = {},
		player_science_limit = var_53_18,
		npcLockConf = var_53_44
	}
end

function RogueExploreModel:init_info_by_server(arg_68_1)
	if arg_68_1.curPosIndex then
		self.curMapConfig.curPosIndex = arg_68_1.curPosIndex
	end

	if arg_68_1.curRoomOrder then
		self.curMapConfig.curRoomOrder = arg_68_1.curRoomOrder
		self.curMapConfig.exploredRooms[arg_68_1.curRoomOrder] = true
		self.curMapConfig.curSpaceType = self.curMapConfig.curRoomOrder > 100 and -1 or 1
	end

	if arg_68_1.HP then
		self.curMapConfig.team_hp = arg_68_1.HP
	end

	if arg_68_1.array then
		playermodel:initExploreArraysHpInherit()

		self.arrayIndex = 1
		self.curMapConfig.array = arg_68_1.array

		for iter_68_0, iter_68_1 in pairs(self.curMapConfig.array) do
			table.insert(self.curMapConfig.spine_model_list, self:getCurArrayModel(iter_68_1))

			playermodel.exploreArrays[1]["pos_" .. iter_68_1.pos] = iter_68_1
		end
	end

	if arg_68_1.usedTile then
		self:init_usedTile_by_server(arg_68_1.usedTile)
	end

	if arg_68_1.cacheBag then
		self:init_itemcache_by_server(arg_68_1.cacheBag)
	end

	if arg_68_1.hpInheritCache then
		self:init_hpInheritCache_by_server(arg_68_1.hpInheritCache)
	end
end

function RogueExploreModel:init_usedTile_by_server(arg_69_1)
	local var_69_0 = {}

	for iter_69_0, iter_69_1 in pairs(self.curMapConfig.puzzleConfig) do
		for iter_69_2, iter_69_3 in pairs(iter_69_1.controller) do
			var_69_0[iter_69_3.roomorder .. "_" .. iter_69_3.controller_idx] = iter_69_0
		end
	end

	local var_69_1 = {}

	for iter_69_4, iter_69_5 in pairs(self.curMapConfig.aimTypeTbl) do
		if iter_69_5.trigger_objectidx then
			var_69_1[iter_69_5.trigger_objectidx] = iter_69_4
		end
	end

	local var_69_2 = {}

	for iter_69_6, iter_69_7 in pairs(arg_69_1) do
		if not self.curMapConfig.usedTile[iter_69_7.roomid] then
			-- block empty
		elseif not self.curMapConfig.usedTile[iter_69_7.roomid][iter_69_7.index] then
			-- block empty
		else
			self.curMapConfig.exploredRooms[iter_69_7.roomid] = true

			for iter_69_8 = 1, iter_69_7.count do
				if self.curMapConfig.usedTile[iter_69_7.roomid][iter_69_7.index] then
					self.curMapConfig.usedTile[iter_69_7.roomid][iter_69_7.index].usedcount = iter_69_8

					if self.curMapConfig.usedTile[iter_69_7.roomid][iter_69_7.index].controller then
						for iter_69_9, iter_69_10 in pairs(self.curMapConfig.usedTile[iter_69_7.roomid][iter_69_7.index].controller) do
							self:updateExploreAim(self.curMapConfig.usedTile[iter_69_10.roomorder][iter_69_10.controller_idx].tileid)
							self:updateObjectState(iter_69_10.roomorder, iter_69_10.controller_idx)
						end
					end

					local var_69_3 = tile_data[self.curMapConfig.usedTile[iter_69_7.roomid][iter_69_7.index].tileid]

					if tile_data[self.curMapConfig.usedTile[iter_69_7.roomid][iter_69_7.index].tileid].class == TILE_TYPE.NPCFOLLOW then
						table.insert(self.curMapConfig.serverFollowQueue, {
							roomid = iter_69_7.roomid,
							index = iter_69_7.index,
							tileid = var_69_3.id
						})
					end

					self:updateExploreAim(self.curMapConfig.usedTile[iter_69_7.roomid][iter_69_7.index].tileid)
					self:updateMapProgressData(self.curMapConfig.usedTile[iter_69_7.roomid][iter_69_7.index].tileid)

					local var_69_4

					if var_69_0[iter_69_7.roomid .. "_" .. iter_69_7.index] then
						var_69_4 = false
						var_69_2[var_69_0[iter_69_7.roomid .. "_" .. iter_69_7.index]] = true
					else
						var_69_4 = var_69_3.trigger_count <= 0 or var_69_3.trigger_count > self.curMapConfig.usedTile[iter_69_7.roomid][iter_69_7.index].usedcount and true
					end

					if not var_69_4 then
						self:updateObjectState(iter_69_7.roomid, iter_69_7.index)
					end
				end
			end

			if var_69_1[iter_69_7.index] then
				self.curMapConfig.aimTypeTbl[var_69_1[iter_69_7.index]].is_show = true
			end
		end
	end

	for iter_69_11 = #self.curMapConfig.puzzleConfig, 1, -1 do
		if var_69_2[iter_69_11] then
			table.remove(self.curMapConfig.puzzleConfig, iter_69_11)
		end
	end
end

function RogueExploreModel:init_itemcache_by_server(arg_70_1)
	for iter_70_0, iter_70_1 in pairs(arg_70_1) do
		self:setItemByServerItem(iter_70_1)
	end
end

function RogueExploreModel:init_hpInheritCache_by_server(arg_71_1)
	for iter_71_0, iter_71_1 in pairs(arg_71_1) do
		self.curMapConfig.hpInheritCache[iter_71_1.is_monster == 0 and tonumber(iter_71_1.id) or iter_71_1.id] = iter_71_1.hp / 100
	end

	local var_71_0 = global_deepCopy(self.curMapConfig.array)

	self.preArrayCount = #var_71_0

	for iter_71_2 = #var_71_0, 1, -1 do
		if self:getHpInherit(var_71_0[iter_71_2].fight_girl) <= 0 then
			table.remove(var_71_0, iter_71_2)
		end
	end

	playermodel:updateExploreArrays(self.arrayIndex, var_71_0)
end

function RogueExploreModel:getSpineList()
	return self.curMapConfig.spine_model_list or {}
end

function RogueExploreModel:removeObject(arg_73_1, arg_73_2)
	if self:objectIsMonster(self.curMapConfig.usedTile[arg_73_1][arg_73_2].tileid) then
		for iter_73_0, iter_73_1 in pairs(self.curMapConfig.usedTile[arg_73_1][arg_73_2].range) do
			if self.curMapConfig.monsterRange[arg_73_1][iter_73_0] and next(self.curMapConfig.monsterRange[arg_73_1][iter_73_0]) ~= nil then
				for iter_73_2, iter_73_3 in pairs(self.curMapConfig.monsterRange[arg_73_1][iter_73_0]) do
					if iter_73_3 == arg_73_2 then
						table.remove(self.curMapConfig.monsterRange[arg_73_1][iter_73_0], iter_73_2)

						break
					end
				end
			end

			if self.curMapConfig.monsterRange[arg_73_1][iter_73_0] and next(self.curMapConfig.monsterRange[arg_73_1][iter_73_0]) == nil then
				self.curMapConfig.monsterRange[arg_73_1][iter_73_0] = nil
			end
		end

		self.curMapConfig.objectRange[arg_73_1][self.curMapConfig.usedTile[arg_73_1][arg_73_2].order] = nil
		self.curMapConfig.usedTile[arg_73_1][arg_73_2] = nil
	else
		for iter_73_4, iter_73_5 in pairs(self.curMapConfig.usedTile[arg_73_1][arg_73_2].range) do
			self.curMapConfig.objectRange[arg_73_1][iter_73_4] = nil
		end

		self.curMapConfig.usedTile[arg_73_1][arg_73_2] = nil
	end
end

function RogueExploreModel:resetObject(arg_74_1, arg_74_2, arg_74_3)
	self.curMapConfig.usedTile[arg_74_1][arg_74_2].tileid = arg_74_3
	self.curMapConfig.usedTile[arg_74_1][arg_74_2].usedcount = 0
	self.curMapConfig.usedTile[arg_74_1][arg_74_2].result = nil
	self.curMapConfig.usedTile[arg_74_1][arg_74_2].is_triggered = nil

	for iter_74_0, iter_74_1 in pairs(self.curMapConfig.usedTile[arg_74_1][arg_74_2].range) do
		self.curMapConfig.objectRange[arg_74_1][iter_74_0] = nil
		self.curMapConfig.usedTile[arg_74_1][arg_74_2].range[iter_74_0] = nil

		if self.curMapConfig.monsterRange and self.curMapConfig.monsterRange[arg_74_1] then
			self.curMapConfig.monsterRange[arg_74_1][iter_74_0] = nil
		end
	end

	local var_74_0, var_74_1 = self:getTileSize(arg_74_3)
	local var_74_2 = require("data.explore.room_data")[self:getRoomid(self.curMapConfig.mapid, arg_74_1)]
	local var_74_3 = (self.curMapConfig.usedTile[arg_74_1][arg_74_2].order - 1) % var_74_2.width_num + 1
	local var_74_4 = math.floor((self.curMapConfig.usedTile[arg_74_1][arg_74_2].order - 1) / var_74_2.width_num) + 1

	for iter_74_2 = 1, var_74_0 do
		for iter_74_3 = 1, var_74_1 do
			self.curMapConfig.objectRange[arg_74_1][self.curMapConfig.usedTile[arg_74_1][arg_74_2].order - 1 + (iter_74_3 - 1) * var_74_2.width_num + iter_74_2] = arg_74_2
			self.curMapConfig.usedTile[arg_74_1][arg_74_2].range[self.curMapConfig.usedTile[arg_74_1][arg_74_2].order - 1 + (iter_74_3 - 1) * var_74_2.width_num + iter_74_2] = true
		end
	end

	if self:objectIsMonster(arg_74_3) then
		local var_74_5 = 1
		local var_74_6 = var_74_4 - 1 < 1 and 1 or var_74_4 - var_74_5
		local var_74_7

		if var_74_3 + 1 > var_74_2.width_num then
			var_74_7 = var_74_2.width_num or var_74_3 + var_74_5

			local var_74_8

			if var_74_4 + var_74_5 > var_74_2.height_num then
				var_74_8 = var_74_2.height_num or var_74_4 + var_74_5
			end
		end

		for iter_74_4 = var_74_3 - 1 < 1 and 1 or var_74_3 - var_74_5, var_74_7 do
			for iter_74_5 = var_74_6, var_74_8 do
				self.curMapConfig.monsterRange[arg_74_1] = self.curMapConfig.monsterRange[arg_74_1] or {}
				self.curMapConfig.monsterRange[arg_74_1][(iter_74_5 - 1) * var_74_2.width_num + iter_74_4] = self.curMapConfig.monsterRange[arg_74_1][(iter_74_5 - 1) * var_74_2.width_num + iter_74_4] or {}

				table.insert(self.curMapConfig.monsterRange[arg_74_1][(iter_74_5 - 1) * var_74_2.width_num + iter_74_4], arg_74_2)

				self.curMapConfig.usedTile[arg_74_1][arg_74_2].range[(iter_74_5 - 1) * var_74_2.width_num + iter_74_4] = true
			end
		end
	end

	if tile_data[arg_74_3].controller then
		if tile_data[arg_74_3].controller == "kong" then
			self.curMapConfig.usedTile[arg_74_1][arg_74_2].controller = nil
		else
			self.curMapConfig.usedTile[arg_74_1][arg_74_2].controller = var_0_57(tile_data[arg_74_3].controller, roomindex)
		end
	end
end

function RogueExploreModel:getTileSize(arg_75_1)
	local var_75_0 = self.getCurData("tile", 201)
	local var_75_1 = var_75_0[arg_75_1]

	assert(var_75_0[arg_75_1], "no tileid:" .. arg_75_1 .. " " .. type(arg_75_1))

	return var_75_1.touch_width and var_75_1.touch_width or var_75_0[arg_75_1].icon and (explore_img_data[tonumber(var_75_0[arg_75_1].icon)].touch_width or 1) or 1, var_75_1.touch_height and var_75_1.touch_height or var_75_0[arg_75_1].icon and (explore_img_data[tonumber(var_75_0[arg_75_1].icon)].touch_height or 1) or 1
end

function RogueExploreModel:goto_next_room(arg_76_1)
	local var_76_0 = self.getCurData("map")
	local var_76_1 = self.getCurData("roomTile")

	self.curMapConfig.curRoomOrder = self.curMapConfig.pathtree[self.curMapConfig.curRoomOrder].nexts[arg_76_1]
	self.curMapConfig.exploredRooms[self.curMapConfig.curRoomOrder] = true

	local var_76_2 = {
		[var_0_36] = var_0_38,
		[var_0_38] = var_0_36,
		[var_0_37] = var_0_39,
		[var_0_39] = var_0_37
	}

	self.curMapConfig.curPosIndex = self.curMapConfig.pathtree[self.curMapConfig.curRoomOrder].objectid and var_76_1[self.curMapConfig.pathtree[self.curMapConfig.curRoomOrder].objectid].birth_points and var_76_1[self.curMapConfig.pathtree[self.curMapConfig.curRoomOrder].objectid].birth_points[var_76_2[arg_76_1]] or self.getCurData("room")[self:getRoomid(self.curMapConfig.mapid, self.curMapConfig.curRoomOrder)].birth_points[var_76_2[arg_76_1]]
end

function RogueExploreModel:jumpto_other_room(arg_77_1, arg_77_2)
	assert(self.curMapConfig.pathtree[arg_77_1], "invalid roomorder:" .. arg_77_1)

	local var_77_0 = self:get_two_room_direction(self.curMapConfig.curRoomOrder, arg_77_1)

	self.curMapConfig.curRoomOrder = arg_77_1
	self.curMapConfig.exploredRooms[self.curMapConfig.curRoomOrder] = true

	local var_77_1 = self:getRoomid(self.curMapConfig.mapid, self.curMapConfig.curRoomOrder)

	self.curMapConfig.curPosIndex = arg_77_2 or 1

	self:saveRogue()
end

function RogueExploreModel:get_two_room_direction(arg_78_1, arg_78_2)
	local var_78_0

	if math.abs(arg_78_1 - arg_78_2) then
		do return var_0_44 end

		var_78_0 = math.ceil(arg_78_1 / 10)
	end

	local var_78_1 = math.ceil(arg_78_2 / 10)

	return (arg_78_1 - 1) % 10 + 1 < (arg_78_2 - 1) % 10 + 1 and (var_78_0 < var_78_1 and var_0_42 or var_0_43) or var_78_0 < var_78_1 and var_0_41 or var_0_40
end

function RogueExploreModel:updateExploreAim(arg_79_1, arg_79_2)
	if self.curMapConfig.aimTypeTbl[arg_79_1] then
		if self.curMapConfig.aimTypeTbl[arg_79_1].aim_condition then
			if arg_79_2 and self.curMapConfig.aimTypeTbl[arg_79_1].aim_condition == arg_79_2.aim_condition then
				self.curMapConfig.aimTypeTbl[arg_79_1].flag = self.curMapConfig.aimTypeTbl[arg_79_1].flag + 1
			end
		else
			self.curMapConfig.aimTypeTbl[arg_79_1].flag = self.curMapConfig.aimTypeTbl[arg_79_1].flag + 1
		end
	end

	if self:checkExploreAim(arg_79_1) and self.curMapConfig.aimTypeTbl[arg_79_1].result_type == "bridge" then
		self.curMapConfig.bridgeLocks[self.curMapConfig.aimTypeTbl[arg_79_1].result_param1] = nil
	end
end

function RogueExploreModel:checkExploreAim(arg_80_1)
	if self.curMapConfig.aimTypeTbl[arg_80_1] then
		return self.curMapConfig.aimTypeTbl[arg_80_1].flag >= self.curMapConfig.aimTypeTbl[arg_80_1].num
	end
end

function RogueExploreModel:updateMapProgressData(arg_81_1)
	if not self.curMapConfig then
		return
	end

	local var_81_0 = self.getCurData("tile")[arg_81_1].show_class

	if not self.curMapConfig.mapProgress[var_81_0] then
		return
	end

	self.curMapConfig.mapProgress[var_81_0].used = self.curMapConfig.mapProgress[var_81_0].used + 1
end

function RogueExploreModel:getMapProgress()
	local var_82_0 = 0
	local var_82_1 = 0

	if not self.curMapConfig.mapProgress then
		return 0
	end

	for iter_82_0, iter_82_1 in pairs(self.curMapConfig.mapProgress) do
		var_82_0 = var_82_0 + iter_82_1.used
		var_82_1 = var_82_1 + iter_82_1.total
	end

	return var_82_1 > 0 and math.floor(var_82_0 / var_82_1 * 100) or 0
end

function RogueExploreModel:trigger_event(arg_83_1, arg_83_2)
	local var_83_0 = arg_83_1.object_idx
	local var_83_1 = self.curMapConfig.usedTile[arg_83_1.room_order][arg_83_1.object_idx]

	if config._DEBUG then
		assert(var_83_1, dump(arg_83_1))
	elseif not var_83_1 then
		return
	end

	local var_83_2 = var_83_1.tileid
	local var_83_3 = self.getCurData("tile", nil)[var_83_1.tileid]
	local var_83_4
	local var_83_5
	local var_83_6
	local var_83_7

	if arg_83_1.result_type == EVENT_TYPE.FIGHT then
		var_83_5 = arg_83_1.fightresult
		var_83_6 = arg_83_1.isSurrender and 1 or 0
		var_83_4 = arg_83_1.result_count
		var_83_7 = {}

		for iter_83_0, iter_83_1 in pairs(self.curMapConfig.hpInheritCache) do
			table.insert(var_83_7, {
				id = tostring(iter_83_0),
				hp = 100 * tonumber(string.format("%.2f", iter_83_1)),
				is_monster = type(iter_83_0) == "string" and 1 or 0
			})
		end
	elseif arg_83_1.result_type == EVENT_TYPE.SHOP_ITEM then
		var_83_5 = var_83_1.result
		var_83_6 = arg_83_1.shop_order
		var_83_4 = 1
	else
		var_83_4 = arg_83_1.result_count
	end

	if var_83_3.class == TILE_TYPE.STATEPROCESS and self.curMapConfig.npcLockConf and self.curMapConfig.npcLockConf.fire and self.curMapConfig.npcLockConf.fire.is_have then
		var_83_5 = 777
	end

	print("@@@@", var_83_2, var_83_4, var_83_5, var_83_6)
	network:rpc("get_rogue_explore_event_result", {
		tileid = var_83_2,
		result_count = var_83_4,
		extra_param1 = var_83_5,
		extra_param2 = var_83_6,
		levelid = self.curMapConfig.activity_explore_id,
		roomorder = arg_83_1.room_order,
		tileindex = var_83_0,
		hpInheritCache = var_83_7,
		activityid = self.curMapConfig.activityid,
		curPosIndex = self.curMapConfig.curPosIndex,
		curRoomOrder = self.curMapConfig.curRoomOrder
	}, function(arg_84_0)
		print(dump(arg_84_0))

		if arg_84_0.result > 0 then
			if arg_84_0.config and arg_84_0.config.HP then
				arg_84_0.config.add_hp = self.curMapConfig.team_hp - arg_84_0.config.HP
				self.curMapConfig.team_hp = arg_84_0.config.HP
			end

			if arg_84_0.items and next(arg_84_0.items) ~= nil then
				for iter_84_0, iter_84_1 in pairs(arg_84_0.items) do
					local var_84_0 = self:setItemByServerItem(iter_84_1)

					arg_84_0.items[iter_84_0].number = var_84_0

					if var_0_52[iter_84_1.itemid] then
						local var_84_1 = global_deepCopy(iter_84_1)

						var_84_1.itemcount = var_84_0 + (item_manager:getItemNumber(iter_84_1.itemid) or 0)

						item_manager:setItemByServerItem(var_84_1)
					end
				end

				if RogueExploreLayer.getInstance() then
					RogueExploreLayer.getInstance().curRoomMap:gainItemToCache({
						items = arg_84_0.items,
						object_idx = var_83_0
					})
				end
			end

			if arg_84_0.config and arg_84_0.config.cacheBag then
				if arg_84_0.config.cacheBag.cost_diamond then
					self.curMapConfig.cost_diamond = arg_84_0.config.cacheBag.cost_diamond
				end

				if arg_84_0.config.cacheBag.cost_gold then
					self.curMapConfig.cost_gold = arg_84_0.config.cacheBag.cost_gold
				end

				if arg_84_0.config.cacheBag.cost_items then
					self.curMapConfig.cost_items = arg_84_0.config.cacheBag.cost_items
				end
			end

			if arg_84_0.cost_items then
				for iter_84_2, iter_84_3 in pairs(arg_84_0.cost_items) do
					self:deleteItem(iter_84_3.itemid, iter_84_3.itemcount)
				end
			end

			if arg_83_1.result_type == EVENT_TYPE.FIGHT and arg_83_1.isSurrender then
				-- block empty
			else
				var_83_1.usedcount = var_83_1.usedcount + 1

				self:updateExploreAim(var_83_2, arg_83_1)
				self:updateMapProgressData(var_83_2)
			end
		elseif arg_84_0.result == 0 then
			arg_84_0.cur_array = self.curMapConfig.array

			self:reset_map()
		elseif arg_84_0.result == -1 then
			global_ShowBlockWords(L_EXPLORE_EVENT_RESULT_ERROR[1])
		elseif arg_84_0.result == -2 then
			global_ShowBlockWords(L_EXPLORE_EVENT_RESULT_ERROR[2])
		elseif arg_84_0.result == -5 then
			global_ShowBlockWords(L_EXPLORE_EVENT_RESULT_ERROR[5])
			self:reset_map()
		end

		if arg_83_2 then
			arg_83_2(arg_84_0)
		end
	end)
end

function RogueExploreModel:update_img_config(arg_85_1)
	local var_85_0 = arg_85_1.imgid
	local var_85_1 = arg_85_1.order
	local var_85_2 = arg_85_1.roomorder
	local var_85_3 = arg_85_1.room_size_num
	local var_85_4 = self.getCurData("roomTile", 201)[arg_85_1.room_img_layer].max_zorder

	if not self.curMapConfig.finishImgs[arg_85_1.room_img_layer] then
		self.curMapConfig.finishImgs[arg_85_1.room_img_layer] = {
			[var_85_1] = var_85_0
		}
	else
		self.curMapConfig.finishImgs[arg_85_1.room_img_layer][var_85_1] = var_85_0
	end

	if explore_img_data[var_85_0].is_block == 1 then
		local var_85_5 = math.floor((var_85_1 - 1) / var_85_3.width) + 1
		local var_85_6 = explore_img_data[var_85_0].touch_height or 1

		for iter_85_0 = (var_85_1 - 1) % var_85_3.width + 1, (var_85_1 - 1) % var_85_3.width + 1 + (explore_img_data[var_85_0].touch_width or 1) - 1 do
			for iter_85_1 = var_85_5, var_85_5 + var_85_6 - 1 do
				self.curMapConfig.mapBlocks[var_85_2][(iter_85_1 - 1) * var_85_3.width + iter_85_0] = true
			end
		end
	end
end

function RogueExploreModel:setItemByServerItem(arg_86_1)
	local var_86_0 = 0
	local var_86_1 = self.curMapConfig.itemcache[arg_86_1.entityid]

	if self.curMapConfig.itemcache[arg_86_1.entityid] then
		var_86_0 = arg_86_1.itemcount - var_86_1.number
	else
		var_86_1 = {}
		var_86_0 = arg_86_1.itemcount
	end

	var_86_1.entityid = arg_86_1.entityid
	var_86_1.itemid = arg_86_1.itemid
	var_86_1.itemtype = item_data[arg_86_1.itemid].bag_item_type
	var_86_1.number = arg_86_1.itemcount
	var_86_1.new = arg_86_1.new
	var_86_1.component_attr = arg_86_1.component_attr
	var_86_1.eatable_attr = arg_86_1.eatable_attr
	var_86_1.horcrux_attr = arg_86_1.horcrux_attr
	var_86_1.weapon_attr = arg_86_1.weapon_attr
	self.curMapConfig.itemcache[arg_86_1.entityid] = var_86_1

	return var_86_0
end

function RogueExploreModel:deleteItem(arg_87_1, arg_87_2)
	arg_87_2 = arg_87_2 or 1

	if arg_87_2 <= 0 then
		return
	end

	self.curMapConfig.itemcache[arg_87_1].number = self.curMapConfig.itemcache[arg_87_1].number - arg_87_2

	if self.curMapConfig.itemcache[arg_87_1].number <= 0 then
		self.curMapConfig.itemcache[arg_87_1] = nil
	end
end

function RogueExploreModel:getItemNumber(arg_88_1)
	if self.curMapConfig.itemcache[arg_88_1] then
		return self.curMapConfig.itemcache[arg_88_1].number
	else
		return 0
	end
end

function RogueExploreModel:is_main_aim_finish()
	if not self.curMapConfig then
		return
	end

	local var_89_0 = true

	for iter_89_0, iter_89_1 in pairs(self.curMapConfig.aimTypeTbl) do
		if iter_89_1.result_type == "map" and iter_89_1.flag < iter_89_1.num then
			var_89_0 = false

			break
		end
	end

	return var_89_0
end

function RogueExploreModel:getExploreMapInfo(arg_90_1)
	return require("data.explore.map_data")[arg_90_1]
end

function RogueExploreModel:getExploreAimInfo(arg_91_1)
	local explore_aim_data = require("data.explore.explore_aim_data")

	assert(explore_aim_data[arg_91_1], "aimid:" .. arg_91_1 .. " not exit")

	return explore_aim_data[arg_91_1]
end

function RogueExploreModel:getExploreAimStr(arg_92_1)
	local var_92_0 = require("data.explore.explore_aim_data")[arg_92_1]
	local var_92_1 = ""

	while var_92_0["aim" .. 1 .. "_des"] do
		var_92_1 = var_92_1 .. var_92_0["aim" .. 1 .. "_des"] .. "\n"
	end

	return var_92_1
end

function RogueExploreModel:getCurExploreBgm()
	if not self.curMapConfig then
		return "sound/explorebgm_zhanhou"
	end

	if not next(self.curMapConfig) == nil then
		return "sound/explorebgm_zhanhou"
	end

	if not explore_aim_data[self.curMapConfig.aimid].bgm then
		return "sound/explorebgm_zhanhou"
	end

	return "sound/" .. explore_aim_data[self.curMapConfig.aimid].bgm
end

function RogueExploreModel:setCurFightCapacity(arg_94_1)
	self.fight_power = arg_94_1
end

function RogueExploreModel:getCurFightCapacity()
	return self.fight_power
end

function RogueExploreModel:getCurArraySkin(arg_96_1)
	if not arg_96_1 then
		return nil
	end

	if arg_96_1.servantskin then
		return arg_96_1.servantskin
	elseif arg_96_1.npcid then
		return npc_fightconfig_data[arg_96_1.npcid].servantskin or -1
	else
		return nil
	end
end

function RogueExploreModel:getCurArrayModel(arg_97_1)
	if not arg_97_1 then
		return self.modelId
	end

	if arg_97_1.npcid and npc_fightconfig_data[arg_97_1.npcid].npcsoulid then
		return npc_data[npc_fightconfig_data[arg_97_1.npcid].npcsoulid].model
	else
		return (global_get_servant_skin(arg_97_1.fight_girl, (self:getCurArraySkin(arg_97_1))))
	end
end

function RogueExploreModel:updateObjectState(arg_98_1, arg_98_2)
	if not self.curMapConfig then
		return
	end

	if not self.curMapConfig.usedTile[arg_98_1] then
		return
	end

	if not self.curMapConfig.usedTile[arg_98_1][arg_98_2] then
		return
	end

	local var_98_0 = tile_data[self.curMapConfig.usedTile[arg_98_1][arg_98_2].tileid]

	if tile_data[self.curMapConfig.usedTile[arg_98_1][arg_98_2].tileid].finished_tile then
		self:resetObject(arg_98_1, arg_98_2, var_98_0.finished_tile)
	elseif var_98_0.finished_image then
		local var_98_1 = var_0_28[self:getRoomid(self.curMapConfig.mapid, arg_98_1)]

		self:update_img_config({
			imgid = var_98_0.finished_image,
			order = self.curMapConfig.usedTile[arg_98_1][arg_98_2].order,
			roomorder = arg_98_1,
			room_img_layer = var_98_1.imglayer,
			room_size_num = cc.size(var_98_1.width_num, var_98_1.height_num)
		})
		self:removeObject(arg_98_1, arg_98_2)
	else
		self:removeObject(arg_98_1, arg_98_2)
	end
end

local var_0_60 = {}

local function var_0_61()
	return coroutine.create(function(arg_100_0, arg_100_1)
		while arg_100_0.running do
			arg_100_0:playScript(arg_100_1)

			arg_100_1 = coroutine.yield()
		end

		arg_100_0:removeSelf()
	end)
end

local function var_0_62(arg_101_0, arg_101_1)
	local var_101_0 = model_data[arg_101_0].spine_model
	local var_101_1 = model_data[arg_101_0].clothes_model
	local var_101_4 = {
		jsonFilePath = ROLE_SPINE_PATH .. var_101_0 .. ".json",
		atlasFilePath = ROLE_SPINE_PATH .. var_101_0 .. ".atlas"
	}

	if var_101_1 then
		var_101_4.clothesFilePath = CLOTHES_SPINE_PATH .. var_101_1 .. ".atlas" or nil
	end

	var_101_4.scale = ((model_data[arg_101_0].modelscale or 1) > 1.3 and 1.3 or model_data[arg_101_0].modelscale or 1) * (arg_101_1 or 1) * var_0_51
	var_101_4.size = cc.size(model_data[arg_101_0].modelweight, model_data[arg_101_0].modelheight)

	return var_101_4
end

local function var_0_63(arg_102_0)
	local var_102_0 = {}
	local var_102_1 = {}

	for iter_102_0, iter_102_1 in pairs(explore_script_data) do
		if iter_102_1.classification == arg_102_0 then
			table.insert(var_102_0, iter_102_1.id)

			if not var_102_1[iter_102_1.actor] then
				if iter_102_1.model then
					var_102_1[iter_102_1.actor] = var_0_62(iter_102_1.model, iter_102_1.model_scale)
				elseif iter_102_1.object then
					var_102_1[iter_102_1.actor] = {
						object_idx = iter_102_1.object
					}
				end
			end
		end
	end

	table.sort(var_102_0, function(arg_103_0, arg_103_1)
		return arg_103_0 < arg_103_1
	end)

	return var_102_0[1], var_102_1
end

local function var_0_64(arg_104_0)
	local var_104_0, var_104_1 = arg_104_0:match("([^,]+),(.+)")

	return tonumber(var_104_0), tonumber(var_104_1)
end

local function var_0_65(arg_105_0)
	if arg_105_0:find("-") then
		local var_105_0, var_105_1 = arg_105_0:match("(.+),(.+)")
		local var_105_2, var_105_3 = var_105_0:match("(%a+)-(%d+)")
		local var_105_4, var_105_5 = var_105_1:match("(%a+)-(%d+)")
		local var_105_6 = {
			[var_105_2] = tonumber(var_105_3),
			[var_105_4] = tonumber(var_105_5)
		}

		return var_105_6.x, var_105_6.y, var_105_2
	else
		return var_0_64(arg_105_0)
	end
end

local function var_0_66(arg_106_0)
	local var_106_0, var_106_1 = var_0_64(arg_106_0[2])

	return tonumber(arg_106_0[1]), cc.p(var_106_0, var_106_1)
end

local function var_0_67(arg_109_0)
	local var_109_0 = tonumber(arg_109_0[1])
	local var_109_1, var_109_2 = var_0_64(arg_109_0[2])

	return var_109_0, cc.p(var_109_1, var_109_2), tonumber(arg_109_0[3]), arg_109_0[4] and checkint(arg_109_0[4]) or 1
end

local function var_0_68(arg_113_0)
	return nil
end

local var_0_69 = {
	moveTo_e = function(self)
		local var_107_0, var_107_1, var_107_2 = var_0_65(self[2])
		local var_107_3 = ExploreMapLayer.getInstance().curRoomMap:transform_index_pos_coordinate(cc.p(var_107_0, var_107_1), "pos")

		return tonumber(self[1]), cc.p(var_107_3.x + 50, var_107_3.y + 50), var_107_2
	end,
	moveTo = var_0_66,
	moveBy_e = function()
		local var_108_0, var_108_1, var_108_2 = var_0_65(conf[2])

		return tonumber(conf[1]), cc.p(var_108_0, var_108_1), var_108_2
	end,
	moveBy = var_0_66,
	jumpTo = var_0_67,
	jumpBy = var_0_67,
	playAni = function(self)
		return self[1], self[2] == "1"
	end,
	delayTime = function(self)
		return tonumber(self[1])
	end,
	talk = function(self)
		return self[1], (tonumber(self[2]))
	end,
	show = var_0_68,
	hide = var_0_68
}

local function var_0_70(arg_114_0, arg_114_1)
	if not arg_114_0["order_" .. arg_114_1] then
		return nil
	end

	local var_114_0 = {}

	while arg_114_0["order_" .. arg_114_1 .. "_param_" .. 1] do
		table.insert(var_114_0, arg_114_0["order_" .. arg_114_1 .. "_param_" .. 1])
	end

	return var_0_69[arg_114_0["order_" .. arg_114_1]](var_114_0)
end

function RogueExploreModel:createDirectory(arg_115_1)
	local var_115_0 = {}
	local var_115_1 = ccui.ImageView:create("mainScenebg/explore_theater.png")

	var_115_1:setAnchorPoint(cc.p(0, 0))
	var_115_1:setScale9Enabled(true)
	var_115_1:setCapInsets(cc.rect(200, 400, 100, 100))
	var_115_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_115_1:setPosition(0, -GameDisplay.fix_y)
	var_115_1:setTouchEnabled(true)
	ExploreMapLayer.getInstance():addChild(var_115_1, 999)

	local var_115_2 = ccui.Button:create("public/talk/new_skip.png", nil, "public/talk/new_skip.png", config._DEBUG and 0 or 1)

	var_115_2:setVisible(false)
	var_115_2:setPosition(560, GameDisplay.height - 50)
	var_115_1:addChild(var_115_2)
	var_115_2:addTouchEventListener(function(arg_116_0, arg_116_1)
		if arg_116_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)

	local var_115_3, var_115_4 = var_0_63(arg_115_1)

	var_115_0.mask = var_115_1
	var_115_0.startindex = var_115_3
	var_115_0.actorconfig = var_115_4
	var_115_0.actorlist = {}
	var_115_0.co = var_0_61()
	var_115_0.running = true
	var_115_0.parent = ExploreMapLayer.getInstance().curRoomMap.iconLayout

	return setmetatable(var_115_0, {
		__index = var_0_60
	})
end

function RogueExploreModel:isEndEffect(arg_117_1)
	if not explore_aim_data[arg_117_1].isEndEffect then
		return false
	else
		return true
	end
end

function var_0_60:removeSelf()
	if self.exithandler then
		self.exithandler()
	end

	if self.mask then
		self.mask:removeFromParent()

		self.mask = nil
	end

	for iter_118_0 = 1, #self.actorlist do
		if not self.actorconfig[iter_118_0].object_idx then
			self.actorlist[iter_118_0]:removeFromParent()
		end

		self.actorlist[iter_118_0] = nil
	end

	self = nil
end

function var_0_60.deleteSelf(arg_119_0)
	arg_119_0.running = false
end

function var_0_60.registerExitEvent(arg_120_0, arg_120_1)
	arg_120_0.exithandler = arg_120_1
end

function var_0_60:startPlay()
	local var_121_0, var_121_1 = coroutine.resume(self.co, self, self.startindex)

	if config._DEBUG then
		assert(var_121_0, var_121_1)
	end
end

function var_0_60:resume(arg_122_1)
	print(":::::::resume:::", arg_122_1)

	if arg_122_1 < 0 then
		self.running = false
	end

	local var_122_0, var_122_1 = coroutine.resume(self.co, arg_122_1)

	if config._DEBUG then
		assert(var_122_0, var_122_1)
	end
end

function var_0_60.getCallback(arg_123_0, arg_123_1)
	if not arg_123_1 then
		return nil
	end

	return function()
		arg_123_0:resume(arg_123_1)
	end
end

function var_0_60:playScript(arg_125_1)
	local var_125_0 = config._DEBUG and assert(explore_script_data[arg_125_1], "script " .. arg_125_1 .. " is nil!!!!") or explore_script_data[arg_125_1]
	local var_125_1 = self:getActor(var_125_0.actor)

	if not self.actorconfig[var_125_0.actor].object_idx then
		if var_125_0.initpos then
			local var_125_2, var_125_3 = var_0_64(var_125_0.initpos)
			local var_125_4 = var_125_0.direction or 1
			local var_125_5 = self.actorconfig[var_125_0.actor].scale

			var_125_1:setPosition(cc.p(var_125_2, var_125_3))
			var_125_1:setScale(var_125_4 * var_125_5, var_125_5)
		end
	elseif var_125_0.direction then
		var_125_1:setScale((var_125_0.direction or 1) * var_125_1.scale, var_125_1.scale)
	end

	local var_125_7 = 1

	while var_125_0["order_" .. var_125_7] do
		var_125_1:execute(var_125_0["order_" .. var_125_7], self:getCallback(var_125_0["callback_" .. var_125_7]), var_0_70(var_125_0, var_125_7))

		var_125_7 = var_125_7 + 1
	end
end

function var_0_60:getActor(arg_126_1)
	if self.actorconfig[arg_126_1].object_idx then
		return self:getObject(arg_126_1)
	elseif self.actorlist[arg_126_1] then
		return self.actorlist[arg_126_1]
	else
		return self:addActor(arg_126_1)
	end
end

function var_0_60:getObject(arg_127_1)
	self.actorlist[arg_127_1] = self.actorconfig[arg_127_1].object_idx == -1 and ExploreMapLayer.getInstance().curRoomMap.tag or ExploreMapLayer.getInstance().curRoomMap.tileobjects[self.actorconfig[arg_127_1].object_idx]

	return self.actorlist[arg_127_1]
end

function var_0_60:addActor(arg_128_1)
	local var_128_0 = L2Actor:createExploreTheaterActor(self.actorconfig[arg_128_1].jsonFilePath, self.actorconfig[arg_128_1].atlasFilePath, self.actorconfig[arg_128_1].clothesFilePath)

	var_128_0:setScale(self.actorconfig[arg_128_1].scale, self.actorconfig[arg_128_1].scale)
	var_128_0:setContentSize(self.actorconfig[arg_128_1].size)
	var_128_0:setPosition(cc.p(-100, 100))
	self.parent:addChild(var_128_0)

	self.actorlist[arg_128_1] = var_128_0

	return self.actorlist[arg_128_1]
end

function var_0_60:removeActor(arg_129_1)
	if not self.actorlist[arg_129_1] or self.actorconfig[arg_129_1].object_idx then
		-- block empty
	else
		self.actorlist[arg_129_1]:removeFromParent()

		self.actorlist[arg_129_1] = nil
	end
end

function RogueExploreModel:saveHpInherit(arg_130_1, arg_130_2)
	if not self:isHpInherit() then
		return
	end

	if arg_130_1 == 22320 and self.curMapConfig.hpInheritCache[arg_130_1] == 0 then
		return
	end

	print("servant:", arg_130_1, arg_130_2)

	self.curMapConfig.hpInheritCache[arg_130_1] = arg_130_2
end

function RogueExploreModel:getHpInherit(arg_131_1)
	if self.curMapConfig and self.curMapConfig.hpInheritCache then
		return self.curMapConfig.hpInheritCache[arg_131_1] or 1
	end

	return 1
end

function RogueExploreModel:updateSelectedArray(arg_132_1)
	if type(arg_132_1) == "number" then
		arg_132_1 = arg_132_1 or 1
		self.arrayIndex = arg_132_1

		local var_132_0 = {}

		for iter_132_0 = 1, FORMATION_SHOW_GIRL_NUM do
			if playermodel.exploreArrays[arg_132_1]["pos_" .. iter_132_0].fight_girl then
				table.insert(var_132_0, {
					pos = iter_132_0,
					fight_girl = playermodel.exploreArrays[arg_132_1]["pos_" .. iter_132_0].fight_girl,
					assist_girl = playermodel.exploreArrays[arg_132_1]["pos_" .. iter_132_0].assist_girl
				})
			end
		end

		self.curMapConfig.array = var_132_0

		network:rpc("update_activity_rogue_explore_array", {
			levelid = self.curMapConfig.activity_explore_id,
			activityid = self.curMapConfig.activityid,
			array = self.curMapConfig.array
		}, function(arg_133_0)
			print("update_activity_rogue_explore_array", arg_133_0.result)
		end)
	elseif type(arg_132_1) == "table" then
		local var_132_1 = {}

		for iter_132_1, iter_132_2 in ipairs(arg_132_1) do
			if iter_132_2.girlInfo then
				local var_132_2 = {
					fight_girl = iter_132_2.girlInfo.servantId
				}

				var_132_2.npcid = iter_132_2.npcid or nil
				var_132_2.servantskin = iter_132_2.girlInfo.servantskin or nil

				if not iter_132_2.npcid and iter_132_2.horcruxInfo then
					var_132_2.assist_girl = iter_132_2.horcruxInfo.entityid or nil
				end

				var_132_2.isMainCharacter = not not iter_132_2.isMainCharacter

				table.insert(var_132_1, var_132_2)
			end
		end

		self.curMapConfig.array = var_132_1
	else
		print("update_selected_array is fail")
	end

	self:updateHorcruxCache()

	if not self.curMapConfig.change_role_modelid then
		self:triggerEvent(EVENT_TYPE.CHANGE_DRESS)
	end
end

function RogueExploreModel:getCurrentFixArray(arg_134_1)
	local function var_134_0(arg_135_0)
		if npc_fightconfig_data[arg_135_0] and npc_fightconfig_data[arg_135_0].npcsoulid then
			return npc_data[npc_fightconfig_data[arg_135_0].npcsoulid].model
		elseif npc_fightconfig_data[arg_135_0] then
			return npc_fightconfig_data[arg_135_0].servantid
		end
	end

	local var_134_1
	local var_134_2

	if self.curMapConfig and self.curMapConfig.array and #self.curMapConfig.array > 0 then
		local var_134_3 = {}

		for iter_134_0 = 1, FORMATION_SHOW_GIRL_NUM do
			if self.curMapConfig.array[iter_134_0] then
				if self.curMapConfig.array[iter_134_0].npcid then
					var_134_1 = true
				end

				table.insert(var_134_3, cloneconf(self.curMapConfig.array[iter_134_0]))
			else
				table.insert(var_134_3, {})
			end
		end

		var_134_2 = var_134_3
	else
		var_134_1, var_134_2 = (function()
			local var_136_0 = {}
			local var_136_1 = false
			local var_136_2 = self:getExploreAimInfo(arg_134_1 or self.curMapConfig.aimid)

			for iter_136_0 = 1, FORMATION_SHOW_GIRL_NUM do
				if var_136_2["fight_girl" .. iter_136_0] then
					var_136_0[iter_136_0] = {
						npcid = var_136_2["fight_girl" .. iter_136_0],
						pos = iter_136_0,
						isMainCharacter = var_136_2["fight_girl" .. iter_136_0 .. "_result"] and var_136_2["fight_girl" .. iter_136_0 .. "_result"] == 1 and true or false,
						fight_girl = var_134_0(var_136_2["fight_girl" .. iter_136_0])
					}
					var_136_1 = true
				else
					var_136_0[iter_136_0] = {
						isMainCharacter = false,
						pos_lock = var_136_2["pos_unlock" .. iter_136_0] ~= 1 and true or false,
						pos = iter_136_0
					}
				end
			end

			return var_136_1, var_136_0
		end)()
	end

	return var_134_1, var_134_2
end

function RogueExploreModel:initHorcruxCache()
	self.curMapConfig.horcruxCache = {}

	do return end

	local var_137_0, var_137_1 = self:getCurrentFixArray()

	for iter_137_0, iter_137_1 in ipairs(var_137_1) do
		if not iter_137_1.npcid and iter_137_1.assist_girl then
			self.curMapConfig.horcruxCache[iter_137_1.assist_girl] = {
				fight_girl = iter_137_1.fight_girl,
				assist_girl = iter_137_1.assist_girl
			}
		end
	end
end

function RogueExploreModel:updateHorcruxCache()
	self.curMapConfig.horcruxCache = {}

	do return end

	for iter_138_0, iter_138_1 in ipairs(self.curMapConfig.array) do
		if not iter_138_1.npcid and iter_138_1.assist_girl then
			self.curMapConfig.horcruxCache[iter_138_1.assist_girl] = {
				fight_girl = iter_138_1.fight_girl,
				assist_girl = iter_138_1.assist_girl
			}
		end
	end
end

function RogueExploreModel:queryHorcruxIsUsed(arg_139_1)
	if not self:isHpInherit() then
		return false
	end

	if self.curMapConfig and self.curMapConfig.horcruxCache then
		return not not self.curMapConfig.horcruxCache[arg_139_1]
	end

	return false
end

function RogueExploreModel:getHorcruxByServantId(arg_140_1)
	if not self:isHpInherit() then
		return nil
	end

	if self.curMapConfig and self.curMapConfig.horcruxCache then
		for iter_140_0, iter_140_1 in pairs(self.curMapConfig.horcruxCache) do
			if iter_140_1.fight_girl == arg_140_1 then
				return iter_140_1.assist_girl
			end
		end
	end

	return nil
end

function RogueExploreModel:registerEvent(arg_141_1, arg_141_2, arg_141_3)
	self.eventHandlers = self.eventHandlers or {}
	self.eventHandlers[arg_141_1] = self.eventHandlers[arg_141_1] or {}
	self.eventHandlers[arg_141_1][arg_141_2] = arg_141_3
end

function RogueExploreModel:triggerEvent(arg_142_1, ...)
	if not self.eventHandlers then
		return
	end

	local var_142_0 = {}

	for iter_142_0, iter_142_1 in pairs(self.eventHandlers) do
		if iter_142_1[arg_142_1] then
			var_142_0[#var_142_0 + 1] = iter_142_1[arg_142_1]
		end
	end

	for iter_142_2, iter_142_3 in ipairs(var_142_0) do
		iter_142_3(...)
	end
end

function RogueExploreModel:removeEvent(arg_143_1, arg_143_2)
	if not arg_143_1 then
		return
	end

	if arg_143_2 then
		self.eventHandlers[arg_143_1][arg_143_2] = nil
	else
		self.eventHandlers[arg_143_1] = nil
	end
end

function RogueExploreModel:removeAllEvents()
	self.eventHandlers = {}
end

function RogueExploreModel:setUniqueMonsterId(arg_145_1, arg_145_2)
	if not self:isHpInherit() then
		return
	end

	self.uniqueMonsterId = "_" .. arg_145_1 .. arg_145_2.x .. arg_145_2.y
end

function RogueExploreModel:getUsedHorcruxs()
	if not self:isHpInherit() then
		return {}
	end

	if not self.curMapConfig or not self.curMapConfig.horcruxCache then
		return {}
	end

	local var_146_0 = {}

	for iter_146_0, iter_146_1 in pairs(self.curMapConfig.horcruxCache) do
		var_146_0[iter_146_1.assist_girl] = true
	end

	return var_146_0
end

function RogueExploreModel:getDeadGirls()
	if not self:isHpInherit() then
		return {}
	end

	if not self.curMapConfig or not self.curMapConfig.hpInheritCache then
		return {}
	end

	local var_147_0 = {}

	for iter_147_0, iter_147_1 in pairs(self.curMapConfig.hpInheritCache) do
		if iter_147_1 <= 0 then
			var_147_0[iter_147_0] = true
		end
	end

	return var_147_0
end

function RogueExploreModel:getExploreSkills()
	if not self:isHpInherit() then
		return nil
	end

	local var_148_0 = self:getExploreAimInfo(self.curMapConfig.aimid)
	local var_148_1 = {}

	while var_148_0["battlefieldstatus" .. 1] do
		var_148_1[#var_148_1 + 1] = var_148_0["battlefieldstatus" .. 1]
	end

	local var_148_3 = self:getActivityExploreSkills()

	if var_148_3 then
		for iter_148_0, iter_148_1 in pairs(var_148_3) do
			var_148_1[#var_148_1 + 1] = iter_148_1
		end
	end

	return var_148_1
end

function RogueExploreModel:getActivityExploreSkills()
	local var_149_0 = require("data.activity_" .. self.activityid .. ".rougeexplore_buff_data")
	local var_149_1 = item_manager:getItemNumber(50502001)
	local var_149_2 = {}

	for iter_149_0 = #var_149_0, 1, -1 do
		if var_149_1 >= var_149_0[iter_149_0].starnum then
			table.insert(var_149_2, var_149_0[iter_149_0].battlefield_status_id)
		end
	end

	return var_149_2
end

function RogueExploreModel:getExploreSkillDes()
	if not self:isHpInherit() then
		return {}
	end

	local var_150_0 = self:getExploreAimInfo(self.curMapConfig.aimid)
	local var_150_1 = {}

	while var_150_0["battlefieldstatus" .. 1] do
		if not var_150_0["cizhui_hide" .. 1] and var_150_0["cizhui_hide" .. 1] ~= 1 then
			var_150_1[#var_150_1 + 1] = var_150_0["battlefieldstatus" .. 1]
		end
	end

	return var_150_1
end

function RogueExploreModel:isFixArray(arg_151_1)
	return false
end

function RogueExploreModel:setModelId(arg_152_1)
	self.modelId = arg_152_1
end

function RogueExploreModel:checkIsHaveSave()
	if not cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():getWritablePath() .. "src/rogue_settlement.lua") then
		return
	end

	local rogue_settlement = require("rogue_settlement")

	if not rogue_settlement then
		return false
	end

	if next(rogue_settlement) == nil then
		return false
	end

	return true
end

function RogueExploreModel:saveRogue()
	network:rpc("update_activity_rogue_explore_pos", {
		levelid = self.curMapConfig.activity_explore_id,
		activityid = self.curMapConfig.activityid,
		curPosIndex = self.curMapConfig.curPosIndex,
		curRoomOrder = self.curMapConfig.curRoomOrder
	}, function(arg_162_0)
		print("update_activity_rogue_explore_pos", arg_162_0.result)
	end)
end

function RogueExploreModel:getRogueSaveData()
	if not cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():getWritablePath() .. "src/rogue_settlement.lua") then
		return
	end

	self.curMapConfig = require("rogue_settlement")
end

function RogueExploreModel:checkIsFirst()
	self.isFirst = RoleDefault:getInstance():getBoolForKey("firstRolge" .. self.aimid, true)

	if self.isFirst then
		RoleDefault:getInstance():setBoolForKey("firstRolge" .. self.aimid, false)
	end

	return self.isFirst
end

function RogueExploreModel:checkCurSpace()
	if not self.curMapConfig then
		return false
	end

	return self.curMapConfig.curSpaceType > 0
end

return RogueExploreModel
