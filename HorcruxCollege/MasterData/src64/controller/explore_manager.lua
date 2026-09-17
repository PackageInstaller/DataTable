local var_0_0 = {}

setmetatable(var_0_0, {
	__index = require("controller.explore_manager_ext")
})
require("data.constants")

local playermodel = require("model.playermodel")
local network = require("network.network")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local monster_manager = require("controller.monster_manager")
local level_manager = require("controller.level_manager")
local core_manager = require("controller.core_manager")
local json = require("json")
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
local var_0_29 = require("data.explore.room_data")
local room_tile_data = require("data.explore.room_tile_data")
local tile_data = require("data.explore.tile_data")
local explore_level_data = require("data.explore.explore_level_data")
local explore_monster_data = require("data.explore.explore_monster_data")
local explore_monster_team_data = require("data.explore.explore_monster_team_data")
local explore_script_data = require("data.explore_script_data")
local xuanshang_data = require("data.xuanshang_data")

;({}).IS_INVINCIBLE = not not config._DEBUG
TOTAL_TEAM_HP = 5

local var_0_37 = 1
local var_0_38 = 2
local var_0_39 = 3
local var_0_40 = 4
local var_0_41 = 8
local var_0_42 = 7
local var_0_43 = 6
local var_0_44 = 5
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

var_0_0.MapTotalNum = 0
var_0_0.exploreConfigs = {}
var_0_0.fightFinishCallback = nil
var_0_0.arrayIndex = 1
var_0_0.eventHandlers = {}
var_0_0.uniqueMonsterId = nil
var_0_0.preArrayCount = 0
var_0_0.modelId = nil
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
	NORMAL_DROP = 1
}
TILE_SHOW_STR = {
	[TILE_SHOW_CLASS.NORMAL_DROP] = L_EXPLORE_TITLE_SHOW_STR.NORMAL_DROP,
	[TILE_SHOW_CLASS.SPECIAL_EVENT] = L_EXPLORE_TITLE_SHOW_STR.SPECIAL_EVENT
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

local function var_0_52(arg_1_0)
	local var_1_0, var_1_1 = arg_1_0:match("([^,]+),(.+)")

	return tonumber(var_1_0), tonumber(var_1_1)
end

local function var_0_53(arg_2_0, arg_2_1, arg_2_2)
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

local function var_0_54(arg_3_0, arg_3_1)
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

function var_0_0.getCurLayerName(arg_4_0)
	return "ExploreMapLayer"
end

function var_0_0.getCurData(arg_5_0, arg_5_1)
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
	})[arg_5_0]()
end

function var_0_0.getSettlement(arg_13_0)
	if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():getWritablePath() .. "explore_settlement.txt") then
		local var_13_0 = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath() .. "explore_settlement.txt")

		if var_13_0 == "nil" then
			return
		elseif var_13_0 then
			return (json.decode(var_13_0))
		end
	else
		return
	end
end

function var_0_0:updateSettlement(arg_14_1)
	local var_14_0 = self:getSettlement()

	if var_14_0 then
		if arg_14_1.gold then
			if var_14_0.gold then
				var_14_0.gold = var_14_0.gold + arg_14_1.gold or arg_14_1.gold
			end
		end

		if arg_14_1.diamond then
			if var_14_0.diamond then
				var_14_0.diamond = var_14_0.diamond + arg_14_1.diamond or arg_14_1.diamond
			end
		end

		if arg_14_1.items then
			if var_14_0.items then
				local var_14_1 = {}

				for iter_14_0, iter_14_1 in pairs(var_14_0.items) do
					var_14_1[iter_14_1.itemid] = {
						order = iter_14_0,
						itemid = iter_14_1.itemid,
						num = iter_14_1,
						num
					}
				end

				for iter_14_2, iter_14_3 in pairs(arg_14_1.items) do
					if var_14_1[iter_14_3.itemid] then
						var_14_0.items[var_14_1[iter_14_3.itemid].order].num = var_14_0.items[var_14_1[iter_14_3.itemid].order].num + iter_14_3.num
					else
						table.insert(var_14_0.items, iter_14_3)
					end
				end
			else
				var_14_0.items = arg_14_1.items
			end
		end
	end

	local var_14_2

	do
		var_14_0 = arg_14_1
		var_14_2 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. "explore_settlement.txt", "w+"))
	end

	var_14_2:write((json.encode(var_14_0)))
	var_14_2:flush()
	var_14_2:close()
end

function var_0_0.resetSettlement(arg_15_0)
	local var_15_0 = cc.FileUtils:getInstance()
	local var_15_1 = assert(io.open(var_15_0:getWritablePath() .. "explore_settlement.txt", "w+"))

	var_15_1.write(var_15_0, "nil")
	var_15_1:flush()
	var_15_1:close()
end

function var_0_0.getServantSanLevel(arg_16_0, arg_16_1)
	local var_16_0 = not servant_data[arg_16_1] and playermodel.haveSuit[arg_16_1] and arg_16_1 or servant_data[arg_16_1].major
	local var_16_1 = playermodel.souls_sanvalue[var_16_0] / fitness_data[playermodel.fitness[var_16_0].fitnesslevel or 0].sanvalue_up_limit

	for iter_16_0, iter_16_1 in ipairs({
		0.1,
		0.3,
		0.8,
		1
	}) do
		if var_16_1 <= iter_16_1 then
			return iter_16_0
		elseif iter_16_0 == 4 then
			return 4
		end
	end
end

function var_0_0:isServantExploreing(arg_17_1)
	return self:getExploringSouls()[arg_17_1] or false
end

function var_0_0:getExploringSouls()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(var_0_0.exploreConfigs) do
		if iter_18_1.mapfloor > 0 and iter_18_1.array then
			for iter_18_2, iter_18_3 in pairs(iter_18_1.array) do
				var_18_0[iter_18_3.fight_girl] = true
			end
		end
	end

	if self.auto_exploreInfos then
		for iter_18_4, iter_18_5 in pairs(self.auto_exploreInfos) do
			if iter_18_5.array then
				for iter_18_6, iter_18_7 in pairs(iter_18_5.array) do
					var_18_0[iter_18_7.fight_girl] = true
				end
			end
		end
	end

	return var_18_0
end

function var_0_0.getExploredSouls(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = os.time()

	for iter_19_0, iter_19_1 in pairs(playermodel.soul_lase_explore_time) do
		if iter_19_1 > 0 and var_19_1 - iter_19_1 < 3600 then
			var_19_0[iter_19_0] = true
		end
	end

	return var_19_0
end

function var_0_0:reset_map()
	var_0_0.curMapConfig = {}
	var_0_0.exploreType = nil

	self:resetSettlement()
end

function var_0_0:remove_map()
	self:reset_map()
end

function var_0_0.isOfferExplore(arg_22_0)
	return var_0_0.exploreType and var_0_0.exploreType == "offer"
end

function var_0_0.move_cur_pos(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_2 then
		RoleDefault:getInstance():setIntegerForKey("explore_pos_index", arg_23_2)
	end
end

function var_0_0:beginExploreFight(arg_24_1)
	if self.fightBeginCallback then
		self.fightBeginCallback(arg_24_1)
	else
		var_0_0.levelmode = arg_24_1
		var_0_0.dieCount = 0

		FightManager.refreshFightToType(FIGHTTYPE_EXPLORE)
		LayerManager:switchShowLayer("FightLayer", {
			is_hide_topcost = true,
			is_hide_listbutton = true
		})
	end
end

function var_0_0.initCurrentPlayer(arg_25_0)
	SmallFightLayer.getInstance():initExplorePlayer(var_0_0.curMapConfig.array)
end

function var_0_0:isHpInherit(arg_26_1)
	if not arg_26_1 then
		::label_26_0::

		local var_26_0

		if var_0_0.curMapConfig then
			var_26_0 = var_0_0.curMapConfig.aimid or nil

			if not var_26_0 then
				return false
			end
		end
	end

	local var_26_1 = self:getExploreAimInfo(var_26_0)

	if not var_26_1 then
		return false
	else
		return not not (var_26_1.hp_inherit and var_26_1.hp_inherit == 1)
	end
end

function var_0_0:getExplorePlayer()
	if self:isHpInherit() then
		local var_27_0 = {}

		for iter_27_0, iter_27_1 in ipairs(var_0_0.curMapConfig.array) do
			if iter_27_1.fight_girl then
				local var_27_1 = iter_27_1.npcid or iter_27_1.fight_girl
				local var_27_2 = var_0_0.curMapConfig.hpInheritCache[var_27_1] or 1
				local var_27_3 = {
					fight_girl = iter_27_1.fight_girl
				}

				var_27_3.npcid = iter_27_1.npcid or nil
				var_27_3.servantskin = iter_27_1.servantskin or nil
				var_27_3.assist_girl = iter_27_1.assist_girl or nil
				var_27_3.isMainCharacter = not not iter_27_1.isMainCharacter
				var_27_3.extraConfig = {
					percentHp = var_27_2,
					saveHpInherit = function(arg_28_0, arg_28_1)
						self:saveHpInherit(var_27_1, arg_28_0 / arg_28_1)
					end
				}

				table.insert(var_27_0, var_27_3)
			end
		end

		var_0_0.curMapConfig.array = var_27_0

		return var_0_0.curMapConfig.array, var_0_0.curMapConfig.player_science_limit
	else
		return var_0_0.curMapConfig.array, var_0_0.curMapConfig.player_science_limit
	end
end

function var_0_0.getExploreCurLevelData(arg_29_0)
	local var_29_0 = var_0_0.getCurData("level")

	assert(var_29_0[var_0_0.levelmode], var_0_0.levelmode)

	return var_29_0[var_0_0.levelmode]
end

function var_0_0:initBossList(arg_30_1)
	arg_30_1 = arg_30_1 or var_0_0.levelmode

	local var_30_0 = {}
	local var_30_1 = var_0_0.getCurData("monster")
	local var_30_2 = var_0_0.getCurData("level")[arg_30_1].boss_team
	local var_30_3 = var_0_0.getCurData("monsterTeam")[var_30_2]

	assert(var_30_3 ~= nil, "there is no data of team " .. var_30_2 .. " in monster team data!!!")

	while var_30_3["monster" .. 1] do
		local var_30_4 = #var_30_0 + 1

		var_30_0[#var_30_0 + 1] = {}
		var_30_0[#var_30_0 + 1].id = var_30_3["monster" .. 1]
		var_30_0[#var_30_0 + 1].majorlist = var_30_1[var_30_3["monster" .. 1]]
		var_30_0[#var_30_0 + 1].pos = var_30_3["pos" .. 1]
		var_30_0[#var_30_0 + 1].posy = var_30_3["posy" .. 1]
		var_30_0[#var_30_0 + 1].delaytime = var_30_3["delay" .. 1]
		var_30_0[#var_30_0 + 1].offset = var_30_3["offset" .. 1]

		if self:isHpInherit() and self.uniqueMonsterId then
			local var_30_5 = {}

			var_30_5.percentHp = var_0_0.curMapConfig.hpInheritCache[var_30_0[#var_30_0 + 1].id .. self.uniqueMonsterId] or 1

			function var_30_5.saveHpInherit(arg_31_0, arg_31_1)
				self:saveHpInherit(var_30_0[var_30_4].id .. self.uniqueMonsterId, arg_31_0 / arg_31_1)
			end

			var_30_0[#var_30_0 + 1].extraConfig = var_30_5
		end
	end

	if var_30_3.boss then
		var_30_0.boss = {}
		var_30_0.boss.id = var_30_3.boss
		var_30_0.boss.majorlist = var_30_1[var_30_3.boss]
		var_30_0.boss.pos = var_30_3.posboss
		var_30_0.boss.posy = var_30_3.posyboss
		var_30_0.boss.delaytime = var_30_3.delayboss
		var_30_0.boss.offset = var_30_3.offsetboss

		if self:isHpInherit() and self.uniqueMonsterId then
			local var_30_7 = {}

			var_30_7.percentHp = var_0_0.curMapConfig.hpInheritCache[var_30_3.boss .. self.uniqueMonsterId] or 1

			function var_30_7.saveHpInherit(arg_32_0, arg_32_1)
				self:saveHpInherit(var_30_3.boss .. self.uniqueMonsterId, arg_32_0 / arg_32_1)
			end

			var_30_0.boss.extraConfig = var_30_7
		end
	end

	return var_30_0
end

function var_0_0.initBossListInfo(arg_33_0, arg_33_1)
	arg_33_1 = arg_33_1 or var_0_0.levelmode

	local var_33_0 = {
		monster = {}
	}
	local var_33_1 = var_0_0.getCurData("monster")
	local var_33_2 = var_0_0.getCurData("level")[arg_33_1].boss_team
	local var_33_3 = var_0_0.getCurData("monsterTeam")[var_33_2]

	assert(var_33_3 ~= nil, "there is no data of team " .. var_33_2 .. " in monster team data!!!")

	while var_33_3["monster" .. 1] do
		var_33_0.monster[#var_33_0.monster + 1] = {}
		var_33_0.monster[#var_33_0.monster + 1].id = var_33_3["monster" .. 1]
		var_33_0.monster[#var_33_0.monster + 1].majorlist = var_33_1[var_33_3["monster" .. 1]]
		var_33_0.monster[#var_33_0.monster + 1].pos = var_33_3["pos" .. 1]
		var_33_0.monster[#var_33_0.monster + 1].posy = var_33_3["posy" .. 1]
		var_33_0.monster[#var_33_0.monster + 1].delaytime = var_33_3["delay" .. 1]
		var_33_0.monster[#var_33_0.monster + 1].offset = var_33_3["offset" .. 1]
	end

	if var_33_3.boss then
		var_33_0.boss = {}
		var_33_0.boss.id = var_33_3.boss
		var_33_0.boss.majorlist = var_33_1[var_33_3.boss]
		var_33_0.boss.pos = var_33_3.posboss
		var_33_0.boss.posy = var_33_3.posyboss
		var_33_0.boss.delaytime = var_33_3.delayboss
		var_33_0.boss.offset = var_33_3.offsetboss
	end

	return var_33_0
end

function var_0_0:fightSuccess(arg_34_1)
	if not self:executeFightFinishHandler() then
		return
	end

	if var_0_0.fightFinishCallback then
		if self:isHpInherit() then
			var_0_0.fightFinishCallback(arg_34_1, 0)
		else
			var_0_0.fightFinishCallback(arg_34_1, var_0_0.dieCount)
		end
	end
end

function var_0_0:fightFail(arg_35_1)
	if not self:executeFightFinishHandler() then
		return
	end

	if var_0_0.fightFinishCallback then
		if self:isHpInherit() then
			var_0_0.fightFinishCallback(arg_35_1, 0, true)
		else
			var_0_0.fightFinishCallback(arg_35_1, -1 * #var_0_0.curMapConfig.array)
		end
	end
end

function var_0_0:fightSurrender(arg_36_1)
	if not self:executeFightFinishHandler() then
		return
	end

	if var_0_0.fightFinishCallback then
		if self:isHpInherit() then
			var_0_0.fightFinishCallback(arg_36_1, 0, true)
		else
			var_0_0.fightFinishCallback(arg_36_1, var_0_0.dieCount, true)
		end
	end
end

function var_0_0:executeFightFinishHandler()
	if not self:isHpInherit() then
		return true
	end

	local var_37_0 = true

	self.preArrayCount = #self.curMapConfig.array

	for iter_37_0 = #self.curMapConfig.array, 1, -1 do
		if self:getHpInherit(self.curMapConfig.array[iter_37_0].npcid or self.curMapConfig.array[iter_37_0].fight_girl) <= 0 then
			if self.curMapConfig.array[iter_37_0].isMainCharacter then
				var_37_0 = false

				break
			end

			table.remove(self.curMapConfig.array, iter_37_0)
		end
	end

	if not var_37_0 or #self.curMapConfig.array == 0 and self:isAllGirlDeaded() then
		ExploreMapLayer.getInstance():showFailLayer()
		self:reset_map()

		return false
	end

	playermodel:updateExploreArrays(self.arrayIndex, self.curMapConfig.array)

	if not self.curMapConfig.change_role_modelid then
		self:triggerEvent(EVENT_TYPE.CHANGE_DRESS)
	end

	return true
end

function var_0_0:isAllGirlDeaded()
	for iter_38_0, iter_38_1 in pairs((require("data.servant_data"))) do
		if playermodel.haveServant[iter_38_1.id] and self:getHpInherit(iter_38_1.id) > 0 then
			return false
		end
	end

	return true
end

function var_0_0.onPlayerDie(arg_39_0)
	var_0_0.dieCount = var_0_0.dieCount or 0
	var_0_0.dieCount = var_0_0.dieCount + 1
end

function var_0_0.setFightBeginCallback(arg_40_0, arg_40_1)
	arg_40_0.fightBeginCallback = arg_40_1
end

function var_0_0.clearExploreInfoHpInherit(arg_41_0)
	arg_41_0.fightBeginCallback = nil
	arg_41_0.arrayIndex = 1
	arg_41_0.uniqueMonsterId = nil
	arg_41_0.preArrayCount = 0
	arg_41_0.modelId = nil
end

function var_0_0.setFightFinishCallback(arg_42_0, arg_42_1)
	var_0_0.fightFinishCallback = arg_42_1
end

function var_0_0:getExploringbuffList()
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in pairs(self.curMapConfig.itemcache) do
		if item_data[iter_43_1.itemid].bag_item_type == 40 and item_data[iter_43_1.itemid].buffid then
			table.insert(var_43_0, item_data[iter_43_1.itemid].buffid)
		end
	end

	if next(var_43_0) == nil then
		-- block empty
	end

	return var_43_0
end

local function var_0_56(arg_45_0, arg_45_1)
	if not arg_45_0 then
		return
	end

	local var_45_0 = {}

	if type(arg_45_0) == "number" then
		var_45_0 = {
			{
				roomorder = arg_45_1,
				controller_idx = arg_45_0
			}
		}
	elseif type(arg_45_0) == "string" then
		for iter_45_0 in arg_45_0:gmatch("([^,]+)") do
			local var_45_1
			local var_45_2

			if string.find(iter_45_0, "-") then
				var_45_1, var_45_2 = iter_45_0:match("([^-]+)-([^-]+)")
				var_45_2 = tonumber(var_45_1)
				var_45_1 = tonumber(var_45_1)
			else
				var_45_1 = arg_45_1
				var_45_2 = tonumber(iter_45_0)
			end

			var_45_0[#var_45_0 + 1] = {
				roomorder = var_45_1,
				controller_idx = var_45_2
			}
		end
	end

	return var_45_0
end

local function var_0_57(arg_46_0)
	local var_46_0, var_46_1 = arg_46_0:match("(%d+)-(%d+)")
	local var_46_2 = tonumber(var_46_1)
	local var_46_3 = tonumber(var_46_0)
	local var_46_4 = math.floor((var_46_3 - 1) / 10) + 1
	local var_46_5

	if var_46_3 - var_46_2 == -10 then
		var_46_5 = var_46_4 * (10 - 1) + (var_46_4 - 1) * 10 + ((var_46_3 - 1) % 10 + 1)
	elseif var_46_3 - var_46_2 == 10 then
		var_46_5 = (var_46_4 - 1) * (10 - 1) + (var_46_4 - 1 - 1) * 10 + ((var_46_3 - 1) % 10 + 1)
	elseif var_46_3 - var_46_2 == 1 then
		var_46_5 = (var_46_4 - 1) * (10 - 1 + 10) + ((var_46_3 - 1) % 10 + 1) - 1
	elseif var_46_3 - var_46_2 == -1 then
		var_46_5 = (var_46_4 - 1) * (10 - 1 + 10) + ((var_46_3 - 1) % 10 + 1)
	end

	return var_46_5
end

function var_0_0.getBridgeOrder(arg_47_0, arg_47_1)
	return var_0_57(arg_47_1)
end

local function var_0_58(arg_48_0)
	local var_48_0 = {}

	for iter_48_0 in arg_48_0:gmatch("([^,]+)") do
		table.insert(var_48_0, iter_48_0)
	end

	return var_48_0[math.random(#var_48_0)]
end

function var_0_0:canMopUp()
	if not self.curMapConfig or not self.curMapConfig.offerid then
		return false
	end

	return self:getMapProgress() == 100
end

function var_0_0:explore_success_finish(arg_50_1)
	network:rpc("explore_success_finish", {
		canSweep = self:canMopUp()
	}, function(arg_51_0)
		print("explore_success_finish", dump(arg_51_0))

		if arg_51_0.result == 1 then
			if arg_51_0.cacheBag then
				if arg_51_0.cacheBag.cost_items then
					for iter_51_0, iter_51_1 in pairs(arg_51_0.cacheBag.cost_items) do
						item_manager:deleteItem(iter_51_1.itemid, iter_51_1.itemcount)
					end
				end

				if arg_51_0.cacheBag.cost_gold then
					playermodel.gold = playermodel.gold - arg_51_0.cacheBag.cost_gold

					global_update_gold_stone_diamond(playermodel.gold)
				end

				if arg_51_0.consumes then
					for iter_51_2, iter_51_3 in ipairs(arg_51_0.consumes) do
						item_manager:deleteItem(iter_51_3.entityid, iter_51_3.num)
					end
				end

				if arg_51_0.cacheBag.cost_diamond then
					playermodel.diamond = playermodel.diamond - arg_51_0.cacheBag.cost_diamond

					global_update_gold_stone_diamond(nil, nil, arg_51_0.cacheBag.cost_diamond)
				end
			end

			if arg_51_0.items then
				for iter_51_4, iter_51_5 in pairs(arg_51_0.items) do
					arg_51_0.items[iter_51_4].number = item_manager:setItemByServerItem(iter_51_5)

					if item_data[iter_51_5.itemid].bag_item_type == kITEM_HERO or item_data[iter_51_5.itemid].bag_item_type == kITEM_SKIN then
						require("view.Layer.GetRoleAnimationLayer")

						local var_51_0 = GetRoleAnimationLayer:create(iter_51_5.itemid)

						if not var_51_0:getParent() then
							global_basic_scene:addChild(var_51_0, 999)
						end

						if iter_51_5.itemid == 1301820 then
							AnalyticManager.gain_liuli_by_activity()
						end
					end
				end

				if next(arg_51_0.items) ~= nil then
					for iter_51_6 = #arg_51_0.items, 1, -1 do
						if arg_51_0.items[iter_51_6].number == 0 then
							table.remove(arg_51_0.items, iter_51_6)
						end
					end
				end
			end

			if arg_51_0.diamond then
				playermodel.diamond = playermodel.diamond + arg_51_0.diamond

				global_update_gold_stone_diamond(nil, nil, arg_51_0.diamond)
			end

			if arg_51_0.plot_info then
				playermodel.runningPlots[arg_51_0.plot_info.plotinfo.plotClassId][2] = arg_51_0.plot_info.plotinfo.step

				PlotManager:checkIsUnlockMapLevel(arg_51_0.plot_info.plotinfo.plotClassId)
				PlotManager:update_plot_layer_config()

				if PlotManager:check_plot_is_finished(playermodel.runningPlots[arg_51_0.plot_info.plotinfo.plotClassId]) then
					AlertManager:register_alert(ALERT_TOP_PLOT)

					arg_51_0.plot_info.isFinish = true
				end
			end

			if self.curMapConfig.activity_explore_id then
				local var_51_1 = require("data.activity_explore_data")[self.curMapConfig.activity_explore_id]

				if arg_51_0.activity_info then
					if arg_51_0.activity_info.cost_diamond then
						playermodel.diamond = playermodel.diamond - arg_51_0.activity_info.cost_diamond

						global_update_gold_stone_diamond(nil, nil, arg_51_0.activity_info.cost_diamond)
					end

					if arg_51_0.activity_info.cost_item then
						for iter_51_7, iter_51_8 in pairs(arg_51_0.activity_info.cost_item) do
							item_manager:deleteItem(iter_51_8.itemid, iter_51_8.itemcount)
						end
					end
				end

				if self.curMapConfig.activityid and self.curMapConfig.activityid == 4 then
					AnalyticManager.finish_liuli_explore({
						activity_explore_id = self.curMapConfig.activity_explore_id
					})
				end
			end

			if self.curMapConfig.offerid then
				self:finish_offer(self.curMapConfig.offerid, arg_51_0.explore_offer_info)
			end
		elseif arg_51_0.result == 2 then
			global_ShowBlockWords(L_EXPLORE_FINISH_ERROR[2])
		elseif arg_51_0.result == 3 then
			if arg_51_0.plot_info then
				print(dump(arg_51_0.plot_info))
			end

			global_ShowBlockWords(L_EXPLORE_FINISH_ERROR[3])
		elseif arg_51_0.result == 4 then
			if arg_51_0.activity_info then
				print(dump(arg_51_0.activity_info))
			end

			global_ShowBlockWords(L_EXPLORE_FINISH_ERROR[4])
		end

		if arg_50_1 then
			arg_50_1(arg_51_0)
		end
	end)
end

function var_0_0.get_map_cad_config(arg_52_0, arg_52_1)
	local var_52_0 = math.floor((arg_52_1 - 1) / 200) + 1
	local var_52_1 = {}

	for iter_52_0 = (arg_52_1 - 1) % 200 + 1, (arg_52_1 - 1) % 200 + 1 + 10 - 1 do
		for iter_52_1 = var_52_0, var_52_0 + 10 - 1 do
			var_52_1[(iter_52_1 - var_52_0 + 1 - 1) * 10 + (iter_52_0 - ((arg_52_1 - 1) % 200 + 1) + 1)] = (cad_data[iter_52_1] or {})["x_" .. iter_52_0]
		end
	end

	return var_52_1
end

function var_0_0:getRoomid(arg_53_1, arg_53_2)
	return self:get_map_cad_config(var_0_0.getCurData("map", 201)[arg_53_1].map_cad_id)[arg_53_2]
end

function var_0_0.getBridgeOrderByDirection(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = cc.size(10, 10)
	local var_54_1 = math.floor((arg_54_1 - 1) / var_54_0.width) + 1
	local var_54_2

	if arg_54_2 == var_0_37 then
		var_54_2 = (var_54_1 - 1) * (var_54_0.width - 1) + (var_54_1 - 1 - 1) * var_54_0.width + ((arg_54_1 - 1) % var_54_0.width + 1)
	elseif arg_54_2 == var_0_39 then
		var_54_2 = var_54_1 * (var_54_0.width - 1) + (var_54_1 - 1) * var_54_0.width + ((arg_54_1 - 1) % var_54_0.width + 1)
	elseif arg_54_2 == var_0_40 then
		var_54_2 = (var_54_1 - 1) * (var_54_0.width - 1 + var_54_0.width) + ((arg_54_1 - 1) % var_54_0.width + 1) - 1
	elseif arg_54_2 == var_0_38 then
		var_54_2 = (var_54_1 - 1) * (var_54_0.width - 1 + var_54_0.width) + ((arg_54_1 - 1) % var_54_0.width + 1)
	end

	return var_54_2
end

function var_0_0.checkBridegRoomClosed(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = cc.size(10, 10)
	local var_55_1 = math.floor((arg_55_1 - 1) / var_55_0.width) + 1
	local var_55_2 = {}

	for iter_55_0 = 1, 4 do
		if iter_55_0 == var_0_37 and var_55_1 ~= 1 then
			var_55_2[(var_55_1 - 1) * (var_55_0.width - 1) + (var_55_1 - 1 - 1) * var_55_0.width + ((arg_55_1 - 1) % var_55_0.width + 1)] = true
		elseif iter_55_0 == var_0_39 and var_55_1 ~= 10 then
			var_55_2[var_55_1 * (var_55_0.width - 1) + (var_55_1 - 1) * var_55_0.width + ((arg_55_1 - 1) % var_55_0.width + 1)] = true
		elseif iter_55_0 == var_0_40 and (arg_55_1 - 1) % var_55_0.width + 1 ~= 1 then
			var_55_2[(var_55_1 - 1) * (var_55_0.width - 1 + var_55_0.width) + ((arg_55_1 - 1) % var_55_0.width + 1) - 1] = true
		elseif iter_55_0 == var_0_38 and (arg_55_1 - 1) % var_55_0.width + 1 ~= 10 then
			var_55_2[(var_55_1 - 1) * (var_55_0.width - 1 + var_55_0.width) + ((arg_55_1 - 1) % var_55_0.width + 1)] = true
		end
	end

	return not not var_55_2[arg_55_2]
end

function var_0_0.getCurMapMaxSize(arg_56_0, arg_56_1)
	local cad_data = require("data.explore.cad_data")
	local var_56_1 = math.floor((arg_56_1 - 1) / 200) + 1
	local var_56_3 = 0
	local var_56_4 = 0

	for iter_56_0 = (arg_56_1 - 1) % 200 + 1, (arg_56_1 - 1) % 200 + 1 + 10 - 1 do
		for iter_56_1 = var_56_1, var_56_1 + 10 - 1 do
			if (cad_data[iter_56_1] or {})["x_" .. iter_56_0] then
				var_56_3 = var_56_3 < iter_56_0 and iter_56_0 or var_56_3
				var_56_4 = var_56_4 < iter_56_1 and iter_56_1 or var_56_4
			end
		end
	end

	return var_56_3 - ((arg_56_1 - 1) % 200 + 1) + 1, var_56_4 - var_56_1 + 1
end

function var_0_0.objectIsMonster(arg_57_0, arg_57_1)
	return MONSTER_TILE_CLASS[var_0_0.getCurData("tile", 201)[arg_57_1].class]
end

function var_0_0.decodeImgid(arg_58_0, arg_58_1)
	return bit.band(arg_58_1, math.pow(2, 29) - 1), (bit.rshift(arg_58_1, 29))
end

function var_0_0:gen_test_map_info(arg_59_1, arg_59_2)
	local bit = require("bit")
	local explore_aim_data = require("data.explore.explore_aim_data")
	local room_data = require("data.explore.room_data")
	local room_tile_data = require("data.explore.room_tile_data")
	local tile_data = require("data.explore.tile_data")
	local explore_level_data = require("data.explore.explore_level_data")
	local explore_monster_team_data = require("data.explore.explore_monster_team_data")
	local var_59_7 = arg_59_1.aimid

	print("aimid=====", arg_59_1.aimid)

	local var_59_8 = explore_aim_data[var_59_7]
	local var_59_9 = explore_aim_data[var_59_7].mapid
	local var_59_10 = require("data.explore.explore_effect_data")[var_59_7]
	local var_59_11 = require("data.explore.explore_particle_data")[var_59_7]
	local var_59_12 = require("data.explore.explore_room_color_data")[var_59_7]
	local var_59_13 = require("data.explore.explore_jump_room_effect_data")[var_59_7]
	local var_59_14 = cc.size(tonumber(10), tonumber(10))
	local var_59_15 = {
		[10] = var_0_37,
		[-1] = var_0_38,
		[-10] = var_0_39,
		var_0_40
	}
	local var_59_16 = self:get_map_cad_config(require("data.explore.map_data")[explore_aim_data[var_59_7].mapid].map_cad_id)
	local var_59_17 = self:get_map_cad_config(explore_aim_data[var_59_7].object_cad_id)
	local var_59_18 = arg_59_1.player_science_limit
	local var_59_19 = {}
	local var_59_20 = {}
	local var_59_21 = {}
	local var_59_22 = {}
	local var_59_23 = {}
	local var_59_24 = {}
	local var_59_25 = {}
	local var_59_26 = {}
	local var_59_27 = {}
	local var_59_28 = {}
	local var_59_29 = {}
	local var_59_30 = {}
	local var_59_31 = {}
	local var_59_32 = {}
	local var_59_33 = {}
	local var_59_34 = {}
	local var_59_35 = {}
	local var_59_36 = 1

	local function var_59_37(arg_60_0)
		if not TILE_SHOW_STR[arg_60_0] then
			return
		end

		if not var_59_28[arg_60_0] then
			var_59_28[arg_60_0] = {
				used = 0,
				total = 1
			}
		else
			var_59_28[arg_60_0].total = var_59_28[arg_60_0].total + 1
		end
	end

	local var_59_39 = {}

	local function var_59_40(arg_61_0)
		local var_61_0 = arg_61_0.result or 1
		local var_61_1 = tile_data[arg_61_0.tileid]

		if var_59_39[arg_61_0.tileid] then
			return
		end

		var_59_39[arg_61_0.tileid] = 1

		if self:objectIsMonster(arg_61_0.tileid) then
			local var_61_2 = var_61_1["result" .. var_61_0 .. "_param"]

			if not var_61_1["result" .. var_61_0 .. "_param"] or not explore_level_data[var_61_2] then
				print("error result", var_61_0, var_61_2, arg_61_0.tileid)
			end

			table.insert(var_59_35, explore_monster_team_data[explore_level_data[var_61_2].boss_team].boss_icon)
		elseif var_61_1.class == TILE_TYPE.POKEMON then
			table.insert(var_59_35, require("data.horcrux_data")[require("data.explore.explore_horcrux_data")[var_61_1["result" .. var_61_0 .. "_param"]].horcruxid].model)
		elseif var_61_1.model then
			table.insert(var_59_35, var_61_1.model)
		end

		if var_61_1.trigger_theater then
			for iter_61_0, iter_61_1 in pairs(explore_script_data) do
				if iter_61_1.classification == var_61_1.trigger_theater and iter_61_1.model then
					table.insert(var_59_35, iter_61_1.model)
				end
			end
		end

		if var_61_1["result" .. var_61_0 .. "_type"] == EVENT_TYPE.CHANGE_ROLEMODEL then
			table.insert(var_59_35, var_61_1["result" .. var_61_0 .. "_param"])
		end

		if var_61_1.finished_tile then
			var_59_40({
				tileid = var_61_1.finished_tile
			})
		end
	end

	local function var_59_41()
		local var_62_0 = {}
		local var_62_1 = 1

		while var_59_8["mark" .. var_62_1 .. "_room"] do
			local var_62_2 = {}

			for iter_62_0 in string.gmatch(var_59_8["mark" .. var_62_1 .. "_room"], "%d+") do
				local var_62_3 = tonumber(iter_62_0)

				if var_59_17[var_62_3] then
					if room_tile_data[var_59_17[var_62_3]]["mark_points" .. var_59_8["mark" .. var_62_1 .. "_tileid"]] then
						for iter_62_1, iter_62_2 in pairs(room_tile_data[var_59_17[var_62_3]]["mark_points" .. var_59_8["mark" .. var_62_1 .. "_tileid"]]) do
							table.insert(var_62_2, {
								roomorder = var_62_3,
								idx = iter_62_1,
								order = iter_62_2.order,
								is_replace = iter_62_2.is_replace,
								controller = var_0_56(iter_62_2.controller, var_62_3)
							})
						end
					end
				else
					table.insert(var_62_2, {
						is_invalid = true,
						roomorder = var_62_3
					})
				end
			end

			if #var_62_2 == 1 then
				if var_62_0[var_62_2[1].roomorder] then
					var_62_0[var_62_2[1].roomorder][var_62_2[1].idx] = {
						order = var_62_2[1].order,
						tileid = var_59_8["mark" .. var_62_1 .. "_tileid"],
						is_replace = var_62_2[1].is_replace,
						controller = var_62_2[1].controller
					}
				else
					var_62_0[var_62_2[1].roomorder] = {
						[var_62_2[1].idx] = {
							order = var_62_2[1].order,
							tileid = var_59_8["mark" .. var_62_1 .. "_tileid"],
							is_replace = var_62_2[1].is_replace,
							controller = var_62_2[1].controller
						}
					}
				end
			else
				for iter_62_3, iter_62_4 in pairs((var_0_53(var_59_8["mark" .. var_62_1 .. "_num"], 1, #var_62_2))) do
					if not var_62_2[iter_62_4].is_invalid then
						if var_62_0[var_62_2[iter_62_4].roomorder] then
							var_62_0[var_62_2[iter_62_4].roomorder][var_62_2[iter_62_4].idx] = {
								order = var_62_2[iter_62_4].order,
								tileid = var_59_8["mark" .. var_62_1 .. "_tileid"],
								is_replace = var_62_2[iter_62_4].is_replace,
								controller = var_62_2[1].controller
							}
						else
							var_62_0[var_62_2[iter_62_4].roomorder] = {
								[var_62_2[iter_62_4].idx] = {
									order = var_62_2[iter_62_4].order,
									tileid = var_59_8["mark" .. var_62_1 .. "_tileid"],
									is_replace = var_62_2[iter_62_4].is_replace,
									controller = var_62_2[1].controller
								}
							}
						end
					end
				end
			end

			var_62_1 = var_62_1 + 1
		end

		return var_62_0
	end

	local function var_59_42(arg_63_0)
		local var_63_0

		local function var_63_1()
			local var_64_0 = 0
			local var_64_1 = {}
			local var_64_2 = {}

			while tile_data[arg_63_0]["result" .. 1 .. "_weight"] do
				var_64_0 = var_64_0 + tile_data[arg_63_0]["result" .. 1 .. "_weight"]

				table.insert(var_64_1, var_64_0)
				table.insert(var_64_2, 1)
			end

			return var_64_2[var_0_54(var_64_1, math.random(1, var_64_0))]
		end

		assert(tile_data[arg_63_0], arg_63_0 .. " " .. type(arg_63_0))

		if MONSTER_TILE_CLASS[tile_data[arg_63_0].class] and var_59_8.is_fix_monster then
			var_63_0 = math.random(1, 3)

			if not tile_data[arg_63_0]["result" .. var_63_0 .. "_type"] then
				var_63_0 = 1
			end
		elseif tile_data[arg_63_0].class == TILE_TYPE.POKEMON then
			var_63_0 = var_63_1()

			if tile_data[arg_63_0]["result" .. var_63_0 .. "_param"] == "-1" then
				return -1
			end
		elseif tile_data[arg_63_0].result1_type == EVENT_TYPE.SHOP_ITEM then
			var_63_0 = (function()
				local var_65_0 = 0
				local var_65_1 = {}
				local var_65_2 = {}
				local var_65_3 = explore_sellweapon_data[tonumber(tile_data[arg_63_0].result1_param)]

				while var_65_3["weaponclass" .. 1] do
					var_65_0 = var_65_0 + var_65_3["weight" .. 1]

					table.insert(var_65_1, var_65_0)
					table.insert(var_65_2, 1)
				end

				return var_65_2[var_0_54(var_65_1, math.random(1, var_65_0))]
			end)()
		elseif tile_data[arg_63_0].is_result_random == 1 then
			var_63_0 = var_63_1()
		end

		return var_63_0
	end

	;(function()
		for iter_66_0 in var_59_8.bridges:gmatch("([^,]+)") do
			local var_66_1 = {}

			for iter_66_1 in iter_66_0:gmatch("([^-]+)") do
				var_66_1[#var_66_1 + 1] = iter_66_1
			end

			local var_66_2 = tonumber(var_66_1[1])
			local var_66_3 = tonumber(var_66_1[2])

			if next(var_59_19) == nil then
				var_59_36 = var_66_2
			end

			if var_66_1[3] then
				var_59_30[var_0_57(var_66_2 .. "-" .. var_66_3)] = tonumber(var_66_1[3])
			end

			var_59_19[var_66_2] = var_59_19[var_66_2] or {
				nexts = {}
			}

			if var_66_3 and not var_59_19[var_66_3] then
				var_59_19[var_66_3] = {
					nexts = {}
				}
			end

			if var_66_3 then
				var_59_19[var_66_2].nexts[var_59_15[var_66_2 - var_66_3]] = var_66_3
				var_59_19[var_66_3].nexts[var_59_15[var_66_3 - var_66_2]] = var_66_2
			end
		end

		if next(var_59_19) == nil then
			var_59_36 = tonumber(var_59_8.bridges)
			var_59_19[var_59_36] = {
				nexts = {}
			}
		end
	end)()
	;(function()
		local var_68_0 = var_59_41()

		for iter_68_0, iter_68_1 in pairs(var_59_19) do
			print(iter_68_0, room_data[var_59_16[iter_68_0]], "roomid:" .. var_59_16[iter_68_0])
			assert(room_data[var_59_16[iter_68_0]], "roomid:" .. var_59_16[iter_68_0])

			local var_68_1 = room_data[var_59_16[iter_68_0]]
			local var_68_2

			var_59_20[iter_68_0] = {}
			var_59_21[iter_68_0] = {}
			var_59_22[iter_68_0] = {}
			var_59_23[iter_68_0] = {}
			var_59_24[iter_68_0] = {}
			var_59_25[iter_68_0] = {}
			var_59_29[iter_68_0] = {}

			if var_59_17[iter_68_0] then
				var_68_2 = var_0_58(var_59_17[iter_68_0])

				assert(room_tile_data[var_68_2], var_59_7 .. " " .. var_68_2)

				for iter_68_2, iter_68_3 in ipairs(room_tile_data[var_68_2].object_idx_tbl) do
					local var_68_3 = var_59_42(room_tile_data[var_68_2][iter_68_3].tileid)

					if not var_68_3 or var_68_3 and var_68_3 > 0 then
						var_59_20[iter_68_0][iter_68_3] = {
							usedcount = 0,
							tileid = room_tile_data[var_68_2][iter_68_3].tileid,
							order = room_tile_data[var_68_2][iter_68_3].order,
							result = var_68_3,
							range = {}
						}

						if room_tile_data[var_68_2][iter_68_3].is_replace then
							var_59_21[iter_68_0][room_tile_data[var_68_2][iter_68_3].order] = true
						end

						if room_tile_data[var_68_2][iter_68_3].controller then
							print("roomindex", iter_68_0, "object_idx", iter_68_3)

							var_59_20[iter_68_0][iter_68_3].controller = var_0_56(room_tile_data[var_68_2][iter_68_3].controller, iter_68_0)
						end

						local var_68_4, var_68_5 = self:getTileSize(room_tile_data[var_68_2][iter_68_3].tileid)
						local var_68_6 = (room_tile_data[var_68_2][iter_68_3].order - 1) % var_68_1.width_num + 1
						local var_68_7 = math.floor((room_tile_data[var_68_2][iter_68_3].order - 1) / var_68_1.width_num) + 1

						for iter_68_4 = (room_tile_data[var_68_2][iter_68_3].order - 1) % var_68_1.width_num + 1, (room_tile_data[var_68_2][iter_68_3].order - 1) % var_68_1.width_num + 1 + var_68_4 - 1 do
							for iter_68_5 = var_68_7, var_68_7 + var_68_5 - 1 do
								var_59_22[iter_68_0][(iter_68_5 - 1) * var_68_1.width_num + iter_68_4] = iter_68_3
								var_59_20[iter_68_0][iter_68_3].range[(iter_68_5 - 1) * var_68_1.width_num + iter_68_4] = true
							end
						end

						if self:objectIsMonster(room_tile_data[var_68_2][iter_68_3].tileid) and tile_data[room_tile_data[var_68_2][iter_68_3].tileid] and tile_data[room_tile_data[var_68_2][iter_68_3].tileid].trigger_range ~= -1 then
							local var_68_8 = 1
							local var_68_9 = var_68_7 - 1 < 1 and 1 or var_68_7 - var_68_8
							local var_68_10

							if var_68_6 + 1 > var_68_1.width_num then
								var_68_10 = var_68_1.width_num or var_68_6 + var_68_8

								local var_68_11

								if var_68_7 + var_68_8 > var_68_1.height_num then
									var_68_11 = var_68_1.height_num or var_68_7 + var_68_8
								end
							end

							for iter_68_6 = var_68_6 - 1 < 1 and 1 or var_68_6 - var_68_8, var_68_10 do
								for iter_68_7 = var_68_9, var_68_11 do
									var_59_23[iter_68_0][(iter_68_7 - 1) * var_68_1.width_num + iter_68_6] = var_59_23[iter_68_0][(iter_68_7 - 1) * var_68_1.width_num + iter_68_6] or {}

									table.insert(var_59_23[iter_68_0][(iter_68_7 - 1) * var_68_1.width_num + iter_68_6], iter_68_3)

									var_59_20[iter_68_0][iter_68_3].range[(iter_68_7 - 1) * var_68_1.width_num + iter_68_6] = true
								end
							end
						end

						var_59_37(tile_data[room_tile_data[var_68_2][iter_68_3].tileid].show_class)
						var_59_40(var_59_20[iter_68_0][iter_68_3])
					end
				end
			end

			iter_68_1.objectid = var_68_2

			if var_68_0[iter_68_0] then
				for iter_68_8, iter_68_9 in pairs(var_68_0[iter_68_0]) do
					local var_68_12 = var_59_42(iter_68_9.tileid)

					if not var_68_12 or var_68_12 and var_68_12 > 0 then
						var_59_20[iter_68_0][iter_68_8] = {
							usedcount = 0,
							tileid = iter_68_9.tileid,
							order = iter_68_9.order,
							result = var_68_12,
							range = {}
						}

						if iter_68_9.is_replace then
							var_59_21[iter_68_0][iter_68_9.order] = true
						end

						if iter_68_9.controller then
							var_59_20[iter_68_0][iter_68_8].controller = iter_68_9.controller
						end

						local var_68_13, var_68_14 = self:getTileSize(iter_68_9.tileid)
						local var_68_15 = (iter_68_9.order - 1) % var_68_1.width_num + 1
						local var_68_16 = math.floor((iter_68_9.order - 1) / var_68_1.width_num) + 1

						for iter_68_10 = (iter_68_9.order - 1) % var_68_1.width_num + 1, (iter_68_9.order - 1) % var_68_1.width_num + 1 + var_68_13 - 1 do
							for iter_68_11 = var_68_16, var_68_16 + var_68_14 - 1 do
								var_59_22[iter_68_0][(iter_68_11 - 1) * var_68_1.width_num + iter_68_10] = iter_68_8
								var_59_20[iter_68_0][iter_68_8].range[(iter_68_11 - 1) * var_68_1.width_num + iter_68_10] = true
							end
						end

						if self:objectIsMonster(iter_68_9.tileid) and tile_data[iter_68_9.tileid] and tile_data[iter_68_9.tileid].trigger_range ~= 0 then
							local var_68_17 = 1
							local var_68_18 = var_68_16 - 1 < 1 and 1 or var_68_16 - var_68_17
							local var_68_19

							if var_68_15 + 1 > var_68_1.width_num then
								var_68_19 = var_68_1.width_num or var_68_15 + var_68_17

								local var_68_20

								if var_68_16 + var_68_17 > var_68_1.height_num then
									var_68_20 = var_68_1.height_num or var_68_16 + var_68_17
								end
							end

							for iter_68_12 = var_68_15 - 1 < 1 and 1 or var_68_15 - var_68_17, var_68_19 do
								for iter_68_13 = var_68_18, var_68_20 do
									var_59_23[iter_68_0][(iter_68_13 - 1) * var_68_1.width_num + iter_68_12] = var_59_23[iter_68_0][(iter_68_13 - 1) * var_68_1.width_num + iter_68_12] or {}

									table.insert(var_59_23[iter_68_0][(iter_68_13 - 1) * var_68_1.width_num + iter_68_12], iter_68_8)

									var_59_20[iter_68_0][iter_68_8].range[(iter_68_13 - 1) * var_68_1.width_num + iter_68_12] = true
								end
							end
						end

						var_59_37(tile_data[iter_68_9.tileid].show_class)
					end
				end
			end

			for iter_68_14 = 1, var_68_1.width_num * var_68_1.height_num do
				local var_68_21 = math.floor((iter_68_14 - 1) / var_68_1.width_num) + 1
				local var_68_23 = {}

				assert(room_tile_data[var_68_1.imglayer][iter_68_14], "roomInfo.imglayer: " .. var_68_1.imglayer .. "order:" .. iter_68_14)

				for iter_68_15, iter_68_16 in pairs(room_tile_data[var_68_1.imglayer][iter_68_14]) do
					iter_68_16 = self:decodeImgid(iter_68_16)

					assert(explore_img_data[iter_68_16], "explore_img_data no id:" .. iter_68_16)

					if type(iter_68_15) == "number" or type(iter_68_15) == "string" and not var_59_21[iter_68_0][iter_68_14] then
						table.insert(var_68_23, {
							img = iter_68_16,
							z_order = (type(iter_68_15) == "string" or nil) and (room_tile_data[var_68_1.imglayer].max_zorder or iter_68_15)
						})
					end
				end

				table.sort(var_68_23, function(arg_69_0, arg_69_1)
					return arg_69_0.z_order > arg_69_1.z_order
				end)

				if var_68_1.doorsImg[iter_68_14] and not iter_68_1.nexts[var_68_1.doorsImg[iter_68_14].direction] then
					assert(var_68_1.doorsImg[iter_68_14].img, iter_68_14)

					if var_68_1.doorsImg[iter_68_14].is_replace then
						var_68_23[1].img = self:decodeImgid(var_68_1.doorsImg[iter_68_14].img)
					else
						table.insert(var_68_23, 1, {
							img = self:decodeImgid(var_68_1.doorsImg[iter_68_14].img)
						})
					end
				end

				for iter_68_17, iter_68_18 in pairs(var_68_23) do
					if explore_img_data[iter_68_18.img].is_block == 1 then
						local var_68_25 = explore_img_data[iter_68_18.img].touch_height or 1

						for iter_68_19 = (iter_68_14 - 1) % var_68_1.width_num + 1, (iter_68_14 - 1) % var_68_1.width_num + 1 + (explore_img_data[iter_68_18.img].touch_width or 1) - 1 do
							for iter_68_20 = var_68_21, var_68_21 + var_68_25 - 1 do
								var_59_24[iter_68_0][(iter_68_20 - 1) * var_68_1.width_num + iter_68_19] = true
							end
						end
					end

					if explore_img_data[iter_68_18.img].sp_env then
						var_59_25[iter_68_0][(var_68_21 - 1) * var_68_1.width_num + ((iter_68_14 - 1) % var_68_1.width_num + 1)] = explore_img_data[iter_68_18.img].sp_env
					end
				end
			end

			while var_68_1["light" .. 1] do
				local var_68_26 = {
					light = var_68_1["light" .. 1]
				}

				var_68_26.light_pos = cc.p(var_0_52(var_68_1["light" .. 1 .. "_pos"])) or cc.p(0, 0)
				var_68_26.light_scale = var_68_1["light" .. 1 .. "_scale"]
				var_68_26.light_opacity = var_68_1["light" .. 1 .. "_opacity"]
				var_68_26.light_offset = cc.p(var_0_52(var_68_1["light" .. 1 .. "_offset"])) or cc.p(0, 0)

				table.insert(var_59_29[iter_68_0], var_68_26)
			end
		end
	end)()
	;(function()
		while var_59_8["aim" .. 1 .. "_des"] do
			local var_70_1 = {
				result_type = "map",
				flag = 0,
				tileid = var_59_8["aim" .. 1 .. "_param1"]
			}

			var_70_1.num = var_59_8["aim" .. 1 .. "_param2"] or 1
			var_70_1.aim_condition = var_59_8["aim" .. 1 .. "_condition"]
			var_70_1.trigger_objectidx = var_59_8["aim" .. 1 .. "_trigger_object"]
			var_70_1.trigger_condition = var_59_8["aim" .. 1 .. "_trigger_condition"]
			var_70_1.des = var_59_8["aim" .. 1 .. "_des"]
			var_70_1.is_show = not var_59_8["aim" .. 1 .. "_trigger_object"]
			var_70_1.order = 1
			var_59_27[var_59_8["aim" .. 1 .. "_param1"]] = var_70_1
		end

		local var_70_3 = 1

		while var_59_8["lock" .. var_70_3 .. "_bridge"] do
			local var_70_4 = var_0_57(var_59_8["lock" .. var_70_3 .. "_bridge"])

			var_59_26[var_70_4] = {
				tileid = var_59_8["lock" .. var_70_3 .. "_param1"],
				num = var_59_8["lock" .. var_70_3 .. "_param2"],
				room_order1 = tonumber(var_59_8["lock" .. var_70_3 .. "_bridge"]:match("(%d+)-")),
				room_order2 = tonumber(var_59_8["lock" .. var_70_3 .. "_bridge"]:match("-(%d+)"))
			}

			local var_70_5 = {
				result_type = "bridge",
				is_show = false,
				order = 3,
				flag = 0,
				tileid = var_59_8["lock" .. var_70_3 .. "_param1"]
			}

			var_70_5.num = var_59_8["lock" .. var_70_3 .. "_param2"] or 1
			var_70_5.des = var_59_8["lock" .. var_70_3 .. "_des"]
			var_70_5.result_param1 = var_70_4
			var_59_27[var_59_8["lock" .. var_70_3 .. "_param1"]] = var_70_5
			var_70_3 = var_70_3 + 1
		end

		local var_70_6 = 1

		while var_59_8["puzzle" .. var_70_6] do
			var_59_31[var_70_6] = {
				condition = {},
				controller = var_0_56(var_59_8["puzzle" .. var_70_6 .. "_controller"]),
				controller_des = var_59_8["puzzle" .. var_70_6 .. "_controller_des"],
				is_and = var_59_8["puzzle" .. var_70_6 .. "_is_and"] == 1
			}

			for iter_70_0, iter_70_1 in var_59_8["puzzle" .. var_70_6]:gmatch("([^,]+)-([^,]+)") do
				table.insert(var_59_31[var_70_6].condition, {
					puzzleid = iter_70_0,
					puzzlenum = tonumber(iter_70_1)
				})
			end

			var_70_6 = var_70_6 + 1
		end

		if var_59_8.follow_hole then
			for iter_70_2 in var_59_8.follow_hole:gmatch("([^,]+)") do
				local var_70_7 = {}

				for iter_70_3 in iter_70_2:gmatch("([^-]+)") do
					var_70_7[#var_70_7 + 1] = iter_70_3
				end

				if next(var_70_7) then
					var_70_7[3] = var_70_7[3] or 1
					var_59_32[tonumber(var_70_7[1])] = {
						opacity = tonumber(var_70_7[2]),
						scale = tonumber(var_70_7[3])
					}
				end
			end
		end

		if var_59_8.room_teleport then
			for iter_70_4 in var_59_8.room_teleport:gmatch("([^,]+)") do
				local var_70_8 = {}

				for iter_70_5 in iter_70_4:gmatch("([^-]+)") do
					var_70_8[#var_70_8 + 1] = iter_70_5
				end

				if next(var_70_8) then
					var_70_8[2] = var_70_8[2] or "1.9"
					var_59_33[tonumber(var_70_8[1])] = tonumber(var_70_8[2])
				end
			end
		end

		if var_59_8.room_green then
			for iter_70_6 in var_59_8.room_green:gmatch("([^,]+)") do
				local var_70_9 = {}

				for iter_70_7 in iter_70_6:gmatch("([^-]+)") do
					var_70_9[#var_70_9 + 1] = iter_70_7
				end

				if next(var_70_9) then
					var_70_9[2] = var_70_9[2] or "1"
					var_59_34[tonumber(var_70_9[1])] = tonumber(var_70_9[2])
				end
			end
		end
	end)()
	;(function()
		if arg_59_2 and next(arg_59_2) ~= nil then
			-- block empty
		else
			arg_59_2 = {}

			for iter_71_0 = 1, FORMATION_SHOW_GIRL_NUM do
				if var_59_8["fight_girl" .. iter_71_0] then
					local var_71_0 = var_59_8["fight_girl" .. iter_71_0]
					local var_71_1

					print("==============", var_59_8["fight_girl" .. iter_71_0])

					var_71_1 = npc_fightconfig_data[var_71_0].npcsoulid and npc_fightconfig_data[var_71_0].npcsoulid or npc_fightconfig_data[var_71_0].servantid

					table.insert(arg_59_2, {
						fight_girl = var_71_1,
						pos = iter_71_0,
						npcid = var_71_0
					})
				end
			end

			self:setCurFightCapacity(require("controller.fight_capacity_manager"):getNpcArrayFightCapacity(arg_59_2))
		end

		for iter_71_1, iter_71_2 in pairs(arg_59_2) do
			table.insert(var_59_35, self:getCurArrayModel(iter_71_2))
		end
	end)()

	local var_59_43

	if room_tile_data[var_59_19[var_59_36].objectid].birth_points then
		var_59_43 = room_tile_data[var_59_19[var_59_36].objectid].birth_points[0] or room_data[var_59_16[var_59_36]].birth_points[0]
	end

	print(">>>>>>>>>>>spine_model_list", dump(spine_model_listtileid))

	local var_59_44 = var_0_0
	local var_59_45 = {
		cost_diamond = 0,
		cost_gold = 0,
		roomColor = var_59_12,
		particle = var_59_11,
		effect = var_59_10,
		jumpEffect = var_59_13,
		followQueue = {},
		mapid = var_59_9,
		aimid = var_59_7,
		mapRoomSize = var_59_14,
		pathtree = var_59_19,
		alignmentType = var_59_30,
		mapBlocks = var_59_24,
		mapEnvs = var_59_25,
		curRoomOrder = var_59_36,
		usedTile = var_59_20,
		mapProgress = var_59_28,
		replaceConfig = var_59_21,
		roomsLight = {},
		objectRange = var_59_22,
		monsterRange = var_59_23,
		curPosIndex = var_59_43
	}

	var_59_45.array = next(arg_59_2) == nil and {
		{
			pos = 1,
			fight_girl = 20104
		},
		{
			pos = 2,
			fight_girl = 22120
		}
	} or arg_59_2
	var_59_45.hpInheritCache = {}
	var_59_45.horcruxCache = {}
	var_59_45.exploredRooms = {
		[var_59_36] = true
	}
	var_59_45.bridgeLocks = var_59_26
	var_59_45.aimTypeTbl = var_59_27
	var_59_45.puzzleConfig = var_59_31
	var_59_45.roomsLightConfig = var_59_29
	var_59_45.roomfollowholeConfig = var_59_32
	var_59_45.roomteleportConfig = var_59_33
	var_59_45.roomgreenConfig = var_59_34
	var_59_45.spine_model_list = var_59_35
	var_59_45.team_hp = arg_59_1.HP
	var_59_45.plotid = arg_59_1.plotid
	var_59_45.activity_explore_id = arg_59_1.activity_explore_id
	var_59_45.activityid = arg_59_1.activityid
	var_59_45.offerid = arg_59_1.offerid
	var_59_45.isrepeat = arg_59_1.isrepeat
	var_59_45.finishImgs = {}
	var_59_45.finishedAni = {}
	var_59_45.itemcache = {}
	var_59_45.cost_items = {}
	var_59_45.player_science_limit = var_59_18
	var_59_44.curMapConfig = var_59_45

	if callback then
		callback(2)
	end
end

function var_0_0.getSpineList(arg_72_0)
	return var_0_0.curMapConfig.spine_model_list or {}
end

function var_0_0:removeObject(arg_73_1, arg_73_2)
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

function var_0_0:resetObject(arg_74_1, arg_74_2, arg_74_3)
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
			self.curMapConfig.usedTile[arg_74_1][arg_74_2].controller = var_0_56(tile_data[arg_74_3].controller, roomindex)
		end
	end
end

function var_0_0.getTileSize(arg_75_0, arg_75_1)
	local var_75_0 = var_0_0.getCurData("tile", 201)
	local var_75_1 = var_75_0[arg_75_1]

	assert(var_75_0[arg_75_1], "no tileid:" .. arg_75_1 .. " " .. type(arg_75_1))

	return var_75_1.touch_width and var_75_1.touch_width or var_75_0[arg_75_1].icon and (explore_img_data[tonumber(var_75_0[arg_75_1].icon)].touch_width or 1) or 1, var_75_1.touch_height and var_75_1.touch_height or var_75_0[arg_75_1].icon and (explore_img_data[tonumber(var_75_0[arg_75_1].icon)].touch_height or 1) or 1
end

function var_0_0:goto_next_room(arg_76_1)
	local var_76_0 = var_0_0.getCurData("map")
	local var_76_1 = var_0_0.getCurData("roomTile")

	self.curMapConfig.curRoomOrder = self.curMapConfig.pathtree[self.curMapConfig.curRoomOrder].nexts[arg_76_1]
	self.curMapConfig.exploredRooms[self.curMapConfig.curRoomOrder] = true

	local var_76_2 = {
		[var_0_37] = var_0_39,
		[var_0_39] = var_0_37,
		[var_0_38] = var_0_40,
		[var_0_40] = var_0_38
	}

	self.curMapConfig.curPosIndex = self.curMapConfig.pathtree[self.curMapConfig.curRoomOrder].objectid and var_76_1[self.curMapConfig.pathtree[self.curMapConfig.curRoomOrder].objectid].birth_points and var_76_1[self.curMapConfig.pathtree[self.curMapConfig.curRoomOrder].objectid].birth_points[var_76_2[arg_76_1]] or var_0_0.getCurData("room")[self:getRoomid(self.curMapConfig.mapid, self.curMapConfig.curRoomOrder)].birth_points[var_76_2[arg_76_1]]
end

function var_0_0:jumpto_other_room(arg_77_1, arg_77_2)
	assert(self.curMapConfig.pathtree[arg_77_1], "invalid roomorder:" .. arg_77_1)

	local var_77_0 = self:get_two_room_direction(self.curMapConfig.curRoomOrder, arg_77_1)

	self.curMapConfig.curRoomOrder = arg_77_1
	self.curMapConfig.exploredRooms[self.curMapConfig.curRoomOrder] = true

	local var_77_1 = self:getRoomid(self.curMapConfig.mapid, self.curMapConfig.curRoomOrder)

	self.curMapConfig.curPosIndex = arg_77_2 or 1
end

function var_0_0.get_two_room_direction(arg_78_0, arg_78_1, arg_78_2)
	local var_78_0 = math.ceil(arg_78_1 / 10)
	local var_78_1 = math.ceil(arg_78_2 / 10)

	return (arg_78_1 - 1) % 10 + 1 < (arg_78_2 - 1) % 10 + 1 and (var_78_0 < var_78_1 and var_0_43 or var_0_44) or var_78_0 < var_78_1 and var_0_42 or var_0_41
end

function var_0_0:updateExploreAim(arg_79_1, arg_79_2)
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

function var_0_0:checkExploreAim(arg_80_1)
	if self.curMapConfig.aimTypeTbl[arg_80_1] then
		return self.curMapConfig.aimTypeTbl[arg_80_1].flag >= self.curMapConfig.aimTypeTbl[arg_80_1].num
	end
end

function var_0_0:updateMapProgressData(arg_81_1)
	if not self.curMapConfig then
		return
	end

	local var_81_0 = var_0_0.getCurData("tile")[arg_81_1].show_class

	if not self.curMapConfig.mapProgress[var_81_0] then
		return
	end

	self.curMapConfig.mapProgress[var_81_0].used = self.curMapConfig.mapProgress[var_81_0].used + 1
end

function var_0_0:getMapProgress()
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

function var_0_0:trigger_event(arg_83_1, arg_83_2)
	local var_83_0 = arg_83_1.object_idx
	local var_83_1 = self.curMapConfig.usedTile[arg_83_1.room_order][arg_83_1.object_idx]

	if config._DEBUG then
		assert(var_83_1, dump(arg_83_1))
	elseif not var_83_1 then
		return
	end

	local var_83_2 = var_83_1.tileid
	local var_83_3 = var_0_0.getCurData("tile", nil)[var_83_1.tileid]

	if not arg_83_1.result_type and var_83_3.trigger_type <= 0 then
		var_83_1.usedcount = var_83_3.trigger_count + 1

		self:updateExploreAim(var_83_2, arg_83_1)
		self:updateMapProgressData(var_83_2)

		if arg_83_2 then
			arg_83_2({
				result = 1
			})
		end

		return
	end

	local var_83_4
	local var_83_5
	local var_83_6

	if arg_83_1.result_type == EVENT_TYPE.FIGHT then
		var_83_5 = arg_83_1.fightresult
		var_83_6 = arg_83_1.isSurrender and 1 or 0
		var_83_4 = arg_83_1.result_count
	elseif arg_83_1.result_type == EVENT_TYPE.SHOP_ITEM then
		var_83_5 = var_83_1.result
		var_83_6 = arg_83_1.shop_order
		var_83_4 = 1
	else
		var_83_4 = arg_83_1.result_count
	end

	print("@@@@", var_83_2, var_83_4, var_83_5, var_83_6)
	network:rpc("get_event_result", {
		tileid = var_83_2,
		result_count = var_83_4,
		extra_param1 = var_83_5,
		extra_param2 = var_83_6
	}, function(arg_84_0)
		print(dump(arg_84_0))

		if arg_84_0.result > 0 then
			if arg_84_0.config and arg_84_0.config.HP then
				arg_84_0.config.add_hp = self.curMapConfig.team_hp - arg_84_0.config.HP
				self.curMapConfig.team_hp = arg_84_0.config.HP
			end

			if arg_84_0.items and next(arg_84_0.items) ~= nil then
				for iter_84_0, iter_84_1 in pairs(arg_84_0.items) do
					arg_84_0.items[iter_84_0].number = self:setItemByServerItem(iter_84_1)
				end

				if ExploreMapLayer.getInstance() then
					ExploreMapLayer.getInstance().curRoomMap:gainItemToCache({
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

function var_0_0:update_img_config(arg_85_1)
	local var_85_0 = arg_85_1.imgid
	local var_85_1 = arg_85_1.order
	local var_85_2 = arg_85_1.roomorder
	local var_85_3 = arg_85_1.room_size_num
	local var_85_4 = var_0_0.getCurData("roomTile", 201)[arg_85_1.room_img_layer].max_zorder

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

function var_0_0.begin_explore(arg_86_0, arg_86_1)
	if arg_86_1.type == "plot" then
		local var_86_1 = arg_86_1.plotClassId
		local var_86_2 = arg_86_1.returnLayer

		LayerManager:pushInLayer("PopExplorePreviewLayer", {
			aimid = require("data.plot_data")[PlotManager:getRunningPlotId(arg_86_1.plotClassId)].finish_param1,
			sureCallback = function(arg_88_0)
				arg_86_0:begin_explore_by_plot(var_86_1, arg_88_0, function()
					LayerManager:switchShowLayer("ExploreMapLayer", {
						returnUiLayer = var_86_2
					})
				end)
			end,
			cancelCallback = arg_86_1.canCelcallback
		})
	elseif arg_86_1.type == "activity" then
		local var_86_3 = arg_86_1.activity_explore_id
		local var_86_4 = require("data." .. activity_manager:getExplorefile(arg_86_1.activityid))[arg_86_1.activity_explore_id].aimid
		local var_86_5 = arg_86_1.activityid
		local var_86_6 = arg_86_1.returnLayer
		local var_86_7 = arg_86_1.failReturnUiLayer

		local function var_86_8(arg_90_0)
			arg_86_0:begin_explore_by_activity(var_86_5, var_86_3, arg_90_0, function(arg_91_0)
				if arg_91_0 == 1 then
					LayerManager:switchShowLayer("ExploreMapLayer", {
						activityid = var_86_5,
						returnUiLayer = var_86_6,
						failReturnUiLayer = var_86_7
					})
				elseif arg_86_1.cancelCallback then
					arg_86_1.cancelCallback(arg_91_0)
				end
			end)
		end

		if arg_86_1.activityid ~= 12 then
			LayerManager:pushInLayer("PopExplorePreviewLayer", {
				frameType = arg_86_1.frameType,
				aimid = var_86_4,
				materialMsg = arg_86_1.materialMsg,
				sureCallback = var_86_8,
				cancelCallback = arg_86_1.cancelCallback,
				firstPassDropid = require("data.explore.explore_aim_data")[var_86_4].act_aim_first_dropid
			})
		else
			var_86_8()
		end
	elseif arg_86_1.type == "level" then
		local var_86_9 = arg_86_1.classid
		local var_86_10 = arg_86_1.cur_step

		LayerManager:pushInLayer("PopExplorePreviewLayer", {
			frameType = arg_86_1.frameType,
			aimid = require("data.explore_list_data")[arg_86_1.classid]["step" .. arg_86_1.cur_step],
			materialMsg = arg_86_1.materialMsg,
			sureCallback = function(arg_92_0)
				arg_86_0:begin_explore_by_level(var_86_9, arg_92_0, var_86_10, function(arg_93_0)
					if arg_93_0 == 1 then
						LayerManager:switchShowLayer("ExploreMapLayer", {
							returnUiLayer = arg_86_1.returnLayer,
							failReturnUiLayer = arg_86_1.returnLayer
						})
					elseif arg_86_1.cancelCallback then
						arg_86_1.cancelCallback(arg_93_0)
					end
				end)
			end,
			cancelCallback = arg_86_1.cancelCallback
		})
	elseif arg_86_1.type == "offer" then
		function arg_86_1.info.sureCallback(arg_94_0, arg_94_1)
			arg_86_0:begin_explore_by_offer(arg_94_0, arg_94_1, function(arg_95_0)
				if arg_95_0 == 1 then
					LayerManager:switchShowLayer("ExploreMapLayer", {
						returnUiLayer = arg_86_1.returnLayer,
						failReturnUiLayer = arg_86_1.returnLayer
					})
				elseif arg_86_1.cancelCallback then
					arg_86_1.cancelCallback(arg_95_0)
				end
			end)
		end

		LayerManager:pushInLayer("ExploreOfferPopLayer", arg_86_1.info)
	end

	var_0_0.exploreType = arg_86_1.type
end

function var_0_0.begin_explore_by_plot(arg_96_0, arg_96_1, arg_96_2, arg_96_3)
	network:rpc("get_explore_config", {
		class = 1,
		param1 = arg_96_1
	}, function(arg_97_0)
		if arg_97_0.result == 1 then
			arg_96_0:gen_test_map_info(arg_97_0.config, arg_96_2)

			if arg_96_3 then
				arg_96_3()
			end

			AnalyticManager.enter_explore_by_plotnpc()
		elseif arg_97_0.result == 2 then
			-- block empty
		end
	end)
end

function var_0_0.begin_explore_by_activity(arg_98_0, arg_98_1, arg_98_2, arg_98_3, arg_98_4)
	network:rpc("get_explore_config", {
		class = 2,
		param1 = arg_98_1,
		param2 = arg_98_2
	}, function(arg_99_0)
		print(dump(arg_99_0))

		if arg_99_0.result == 1 then
			arg_98_0:gen_test_map_info(arg_99_0.config, arg_98_3)

			if arg_98_1 == 4 and arg_98_2 == 201 then
				AnalyticManager.enter_liuli_welfare_explore()
			elseif arg_98_1 == 4 and arg_98_2 == 101 then
				AnalyticManager.enter_liuli_plot_explore()
			end
		end

		if arg_98_4 then
			arg_98_4(arg_99_0.result)
		end
	end)
end

function var_0_0.begin_explore_by_level(arg_100_0, arg_100_1, arg_100_2, arg_100_3, arg_100_4)
	network:rpc("get_explore_config", {
		class = 3,
		param1 = arg_100_1,
		param2 = arg_100_3
	}, function(arg_101_0)
		print(dump(arg_101_0))

		if arg_101_0.result == 1 then
			arg_100_0:gen_test_map_info(arg_101_0.config, arg_100_2)
		end

		if arg_100_4 then
			arg_100_4(arg_101_0.result)
		end
	end)
end

function var_0_0.begin_explore_by_offer(arg_102_0, arg_102_1, arg_102_2, arg_102_3)
	network:rpc("get_explore_config", {
		class = 4,
		param1 = arg_102_1
	}, function(arg_103_0)
		if arg_103_0.result == 1 then
			arg_103_0.config.player_science_limit = xuanshang_data[arg_102_1].player_science_limit

			arg_102_0:gen_test_map_info(arg_103_0.config, arg_102_2)
		elseif arg_103_0.result == 2 then
			cclog("数据异常")
		elseif arg_103_0.result == 3 then
			global_ShowBlockWords(L_ELECTRIC_LACK)
			LayerManager:pushInLayer("PopElectricSupplyLayer", {
				callback = function()
					if ExploreOfferLayer and ExploreOfferLayer.getInstance() then
						ExploreOfferLayer.getInstance():updateUI()
					end
				end
			})
		end

		if arg_102_3 then
			arg_102_3(arg_103_0.result)
		end
	end)
end

function var_0_0:setItemByServerItem(arg_105_1)
	local var_105_0 = 0
	local var_105_1 = self.curMapConfig.itemcache[arg_105_1.entityid]

	if self.curMapConfig.itemcache[arg_105_1.entityid] then
		var_105_0 = arg_105_1.itemcount - var_105_1.number
	else
		var_105_1 = {}
		var_105_0 = arg_105_1.itemcount
	end

	var_105_1.entityid = arg_105_1.entityid
	var_105_1.itemid = arg_105_1.itemid
	var_105_1.itemtype = item_data[arg_105_1.itemid].bag_item_type
	var_105_1.number = arg_105_1.itemcount
	var_105_1.new = arg_105_1.new
	var_105_1.component_attr = arg_105_1.component_attr
	var_105_1.eatable_attr = arg_105_1.eatable_attr
	var_105_1.horcrux_attr = arg_105_1.horcrux_attr
	var_105_1.weapon_attr = arg_105_1.weapon_attr
	self.curMapConfig.itemcache[arg_105_1.entityid] = var_105_1

	return var_105_0
end

function var_0_0:deleteItem(arg_106_1, arg_106_2)
	arg_106_2 = arg_106_2 or 1

	if arg_106_2 <= 0 then
		return
	end

	self.curMapConfig.itemcache[arg_106_1].number = self.curMapConfig.itemcache[arg_106_1].number - arg_106_2

	if self.curMapConfig.itemcache[arg_106_1].number <= 0 then
		self.curMapConfig.itemcache[arg_106_1] = nil
	end
end

function var_0_0:getItemNumber(arg_107_1)
	if self.curMapConfig.itemcache[arg_107_1] then
		return self.curMapConfig.itemcache[arg_107_1].number
	else
		return 0
	end
end

function var_0_0:is_main_aim_finish()
	if not self.curMapConfig then
		return
	end

	local var_108_0 = true

	for iter_108_0, iter_108_1 in pairs(self.curMapConfig.aimTypeTbl) do
		if iter_108_1.result_type == "map" and iter_108_1.flag < iter_108_1.num then
			var_108_0 = false

			break
		end
	end

	return var_108_0
end

function var_0_0.getExploreMapInfo(arg_109_0, arg_109_1)
	return require("data.explore.map_data")[arg_109_1]
end

function var_0_0.getExploreAimInfo(arg_110_0, arg_110_1)
	local explore_aim_data = require("data.explore.explore_aim_data")

	assert(explore_aim_data[arg_110_1], "aimid:" .. arg_110_1 .. " not exit")

	return explore_aim_data[arg_110_1]
end

function var_0_0.getExploreAimStr(arg_111_0, arg_111_1)
	local var_111_0 = require("data.explore.explore_aim_data")[arg_111_1]
	local var_111_1 = ""

	while var_111_0["aim" .. 1 .. "_des"] do
		var_111_1 = var_111_1 .. var_111_0["aim" .. 1 .. "_des"] .. "\n"
	end

	return var_111_1
end

function var_0_0:getCurExploreBgm()
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

function var_0_0.setCurFightCapacity(arg_113_0, arg_113_1)
	arg_113_0.fight_power = arg_113_1
end

function var_0_0:getCurFightCapacity()
	return self.fight_power
end

function var_0_0.getCurArraySkin(arg_115_0, arg_115_1)
	if not arg_115_1 then
		return nil
	end

	if arg_115_1.servantskin then
		return arg_115_1.servantskin
	elseif arg_115_1.npcid then
		return npc_fightconfig_data[arg_115_1.npcid].servantskin or -1
	else
		return nil
	end
end

function var_0_0:getCurArrayModel(arg_116_1)
	if not arg_116_1 then
		return self.modelId
	end

	if arg_116_1.npcid and npc_fightconfig_data[arg_116_1.npcid].npcsoulid then
		return npc_data[npc_fightconfig_data[arg_116_1.npcid].npcsoulid].model
	else
		return (global_get_servant_skin(arg_116_1.fight_girl, (self:getCurArraySkin(arg_116_1))))
	end
end

function var_0_0:updateObjectState(arg_117_1, arg_117_2)
	if not self.curMapConfig then
		return
	end

	if not self.curMapConfig.usedTile[arg_117_1] then
		return
	end

	if not self.curMapConfig.usedTile[arg_117_1][arg_117_2] then
		return
	end

	local var_117_0 = tile_data[self.curMapConfig.usedTile[arg_117_1][arg_117_2].tileid]

	if tile_data[self.curMapConfig.usedTile[arg_117_1][arg_117_2].tileid].finished_tile then
		self:resetObject(arg_117_1, arg_117_2, var_117_0.finished_tile)
	elseif var_117_0.finished_image then
		local var_117_1 = var_0_29[self:getRoomid(self.curMapConfig.mapid, arg_117_1)]

		self:update_img_config({
			imgid = var_117_0.finished_image,
			order = self.curMapConfig.usedTile[arg_117_1][arg_117_2].order,
			roomorder = arg_117_1,
			room_img_layer = var_117_1.imglayer,
			room_size_num = cc.size(var_117_1.width_num, var_117_1.height_num)
		})
		self:removeObject(arg_117_1, arg_117_2)
	else
		self:removeObject(arg_117_1, arg_117_2)
	end
end

local var_0_59 = {}

local function var_0_60()
	return coroutine.create(function(arg_119_0, arg_119_1)
		while arg_119_0.running do
			arg_119_0:playScript(arg_119_1)

			arg_119_1 = coroutine.yield()
		end

		arg_119_0:removeSelf()
	end)
end

local function var_0_61(arg_120_0, arg_120_1)
	local var_120_0 = model_data[arg_120_0].spine_model
	local var_120_1 = model_data[arg_120_0].clothes_model
	local var_120_4 = {
		jsonFilePath = ROLE_SPINE_PATH .. var_120_0 .. ".json",
		atlasFilePath = ROLE_SPINE_PATH .. var_120_0 .. ".atlas"
	}

	if var_120_1 then
		var_120_4.clothesFilePath = CLOTHES_SPINE_PATH .. var_120_1 .. ".atlas" or nil
	end

	var_120_4.scale = ((model_data[arg_120_0].modelscale or 1) > 1.3 and 1.3 or model_data[arg_120_0].modelscale or 1) * (arg_120_1 or 1) * var_0_51
	var_120_4.size = cc.size(model_data[arg_120_0].modelweight, model_data[arg_120_0].modelheight)

	return var_120_4
end

local function var_0_62(arg_121_0)
	local var_121_0 = {}
	local var_121_1 = {}

	for iter_121_0, iter_121_1 in pairs(explore_script_data) do
		if iter_121_1.classification == arg_121_0 then
			table.insert(var_121_0, iter_121_1.id)

			if not var_121_1[iter_121_1.actor] then
				if iter_121_1.model then
					var_121_1[iter_121_1.actor] = var_0_61(iter_121_1.model, iter_121_1.model_scale)
				elseif iter_121_1.object then
					var_121_1[iter_121_1.actor] = {
						object_idx = iter_121_1.object
					}
				end
			end
		end
	end

	table.sort(var_121_0, function(arg_122_0, arg_122_1)
		return arg_122_0 < arg_122_1
	end)

	return var_121_0[1], var_121_1
end

local function var_0_63(arg_123_0)
	local var_123_0, var_123_1 = arg_123_0:match("([^,]+),(.+)")

	return tonumber(var_123_0), tonumber(var_123_1)
end

local function var_0_64(arg_124_0)
	if arg_124_0:find("-") then
		local var_124_0, var_124_1 = arg_124_0:match("(.+),(.+)")
		local var_124_2, var_124_3 = var_124_0:match("(%a+)-(%d+)")
		local var_124_4, var_124_5 = var_124_1:match("(%a+)-(%d+)")
		local var_124_6 = {
			[var_124_2] = tonumber(var_124_3),
			[var_124_4] = tonumber(var_124_5)
		}

		return var_124_6.x, var_124_6.y, var_124_2
	else
		return var_0_63(arg_124_0)
	end
end

local function var_0_65(arg_125_0)
	local var_125_0, var_125_1 = var_0_63(arg_125_0[2])

	return tonumber(arg_125_0[1]), cc.p(var_125_0, var_125_1)
end

local function var_0_66(arg_128_0)
	local var_128_0 = tonumber(arg_128_0[1])
	local var_128_1, var_128_2 = var_0_63(arg_128_0[2])

	return var_128_0, cc.p(var_128_1, var_128_2), tonumber(arg_128_0[3]), arg_128_0[4] and checkint(arg_128_0[4]) or 1
end

local function var_0_67(arg_132_0)
	return nil
end

local var_0_68 = {
	moveTo_e = function(self)
		local var_126_0, var_126_1, var_126_2 = var_0_64(self[2])
		local var_126_3 = ExploreMapLayer.getInstance().curRoomMap:transform_index_pos_coordinate(cc.p(var_126_0, var_126_1), "pos")

		return tonumber(self[1]), cc.p(var_126_3.x + 50, var_126_3.y + 50), var_126_2
	end,
	moveTo = var_0_65,
	moveBy_e = function()
		local var_127_0, var_127_1, var_127_2 = var_0_64(conf[2])

		return tonumber(conf[1]), cc.p(var_127_0, var_127_1), var_127_2
	end,
	moveBy = var_0_65,
	jumpTo = var_0_66,
	jumpBy = var_0_66,
	playAni = function(self)
		return self[1], self[2] == "1"
	end,
	delayTime = function(self)
		return tonumber(self[1])
	end,
	talk = function(self)
		return self[1], (tonumber(self[2]))
	end,
	show = var_0_67,
	hide = var_0_67
}

local function var_0_69(arg_133_0, arg_133_1)
	if not arg_133_0["order_" .. arg_133_1] then
		return nil
	end

	local var_133_0 = {}

	while arg_133_0["order_" .. arg_133_1 .. "_param_" .. 1] do
		table.insert(var_133_0, arg_133_0["order_" .. arg_133_1 .. "_param_" .. 1])
	end

	return var_0_68[arg_133_0["order_" .. arg_133_1]](var_133_0)
end

function var_0_0.createDirectory(arg_134_0, arg_134_1)
	local var_134_0 = {}
	local var_134_1 = ccui.ImageView:create("mainScenebg/explore_theater.png")

	var_134_1:setAnchorPoint(cc.p(0, 0))
	var_134_1:setScale9Enabled(true)
	var_134_1:setCapInsets(cc.rect(200, 400, 100, 100))
	var_134_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_134_1:setPosition(0, -GameDisplay.fix_y)
	var_134_1:setTouchEnabled(true)
	ExploreMapLayer.getInstance():addChild(var_134_1, 999)

	local var_134_2 = ccui.Button:create("public/talk/new_skip.png", nil, "public/talk/new_skip.png", config._DEBUG and 0 or 1)

	var_134_2:setVisible(false)
	var_134_2:setPosition(560, GameDisplay.height - 50)
	var_134_1:addChild(var_134_2)
	var_134_2:addTouchEventListener(function(arg_135_0, arg_135_1)
		if arg_135_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)

	local var_134_3, var_134_4 = var_0_62(arg_134_1)

	var_134_0.mask = var_134_1
	var_134_0.startindex = var_134_3
	var_134_0.actorconfig = var_134_4
	var_134_0.actorlist = {}
	var_134_0.co = var_0_60()
	var_134_0.running = true
	var_134_0.parent = ExploreMapLayer.getInstance().curRoomMap.iconLayout

	return setmetatable(var_134_0, {
		__index = var_0_59
	})
end

function var_0_0.isEndEffect(arg_136_0, arg_136_1)
	if not explore_aim_data[arg_136_1].isEndEffect then
		return false
	else
		return true
	end
end

function var_0_59:removeSelf()
	if self.exithandler then
		self.exithandler()
	end

	if self.mask then
		self.mask:removeFromParent()

		self.mask = nil
	end

	for iter_137_0 = 1, #self.actorlist do
		if not self.actorconfig[iter_137_0].object_idx then
			self.actorlist[iter_137_0]:removeFromParent()
		end

		self.actorlist[iter_137_0] = nil
	end

	self = nil
end

function var_0_59.deleteSelf(arg_138_0)
	arg_138_0.running = false
end

function var_0_59.registerExitEvent(arg_139_0, arg_139_1)
	arg_139_0.exithandler = arg_139_1
end

function var_0_59:startPlay()
	local var_140_0, var_140_1 = coroutine.resume(self.co, self, self.startindex)

	if config._DEBUG then
		assert(var_140_0, var_140_1)
	end
end

function var_0_59:resume(arg_141_1)
	print(":::::::resume:::", arg_141_1)

	if arg_141_1 < 0 then
		self.running = false
	end

	local var_141_0, var_141_1 = coroutine.resume(self.co, arg_141_1)

	if config._DEBUG then
		assert(var_141_0, var_141_1)
	end
end

function var_0_59.getCallback(arg_142_0, arg_142_1)
	if not arg_142_1 then
		return nil
	end

	return function()
		arg_142_0:resume(arg_142_1)
	end
end

function var_0_59:playScript(arg_144_1)
	local var_144_0 = config._DEBUG and assert(explore_script_data[arg_144_1], "script " .. arg_144_1 .. " is nil!!!!") or explore_script_data[arg_144_1]
	local var_144_1 = self:getActor(var_144_0.actor)

	if not self.actorconfig[var_144_0.actor].object_idx then
		if var_144_0.initpos then
			local var_144_2, var_144_3 = var_0_63(var_144_0.initpos)
			local var_144_4 = var_144_0.direction or 1
			local var_144_5 = self.actorconfig[var_144_0.actor].scale

			var_144_1:setPosition(cc.p(var_144_2, var_144_3))
			var_144_1:setScale(var_144_4 * var_144_5, var_144_5)
		end
	elseif var_144_0.direction then
		var_144_1:setScale((var_144_0.direction or 1) * var_144_1.scale, var_144_1.scale)
	end

	local var_144_7 = 1

	while var_144_0["order_" .. var_144_7] do
		var_144_1:execute(var_144_0["order_" .. var_144_7], self:getCallback(var_144_0["callback_" .. var_144_7]), var_0_69(var_144_0, var_144_7))

		var_144_7 = var_144_7 + 1
	end
end

function var_0_59:getActor(arg_145_1)
	if self.actorconfig[arg_145_1].object_idx then
		return self:getObject(arg_145_1)
	elseif self.actorlist[arg_145_1] then
		return self.actorlist[arg_145_1]
	else
		return self:addActor(arg_145_1)
	end
end

function var_0_59:getObject(arg_146_1)
	self.actorlist[arg_146_1] = self.actorconfig[arg_146_1].object_idx == -1 and ExploreMapLayer.getInstance().curRoomMap.tag or ExploreMapLayer.getInstance().curRoomMap.tileobjects[self.actorconfig[arg_146_1].object_idx]

	return self.actorlist[arg_146_1]
end

function var_0_59:addActor(arg_147_1)
	local var_147_0 = L2Actor:createExploreTheaterActor(self.actorconfig[arg_147_1].jsonFilePath, self.actorconfig[arg_147_1].atlasFilePath, self.actorconfig[arg_147_1].clothesFilePath)

	var_147_0:setScale(self.actorconfig[arg_147_1].scale, self.actorconfig[arg_147_1].scale)
	var_147_0:setContentSize(self.actorconfig[arg_147_1].size)
	var_147_0:setPosition(cc.p(-100, 100))
	self.parent:addChild(var_147_0)

	self.actorlist[arg_147_1] = var_147_0

	return self.actorlist[arg_147_1]
end

function var_0_59:removeActor(arg_148_1)
	if not self.actorlist[arg_148_1] or self.actorconfig[arg_148_1].object_idx then
		-- block empty
	else
		self.actorlist[arg_148_1]:removeFromParent()

		self.actorlist[arg_148_1] = nil
	end
end

function var_0_0:saveHpInherit(arg_149_1, arg_149_2)
	if not self:isHpInherit() then
		return
	end

	print("servant:", arg_149_1, arg_149_2)

	self.curMapConfig.hpInheritCache[arg_149_1] = arg_149_2
end

function var_0_0:getHpInherit(arg_150_1)
	local var_150_0 = require("controller.rogue_explore_manager"):getHpInherit(arg_150_1)

	if type(var_150_0) == "number" then
		return var_150_0
	end

	if self.curMapConfig and self.curMapConfig.hpInheritCache then
		return self.curMapConfig.hpInheritCache[arg_150_1] or 1
	end

	return 1
end

function var_0_0:updateSelectedArray(arg_151_1)
	if type(arg_151_1) == "number" then
		arg_151_1 = arg_151_1 or 1
		self.arrayIndex = arg_151_1

		local var_151_0 = {}

		for iter_151_0 = 1, FORMATION_SHOW_GIRL_NUM do
			if playermodel.exploreArrays[arg_151_1]["pos_" .. iter_151_0] then
				table.insert(var_151_0, {
					fight_girl = playermodel.exploreArrays[arg_151_1]["pos_" .. iter_151_0].fight_girl,
					assist_girl = playermodel.exploreArrays[arg_151_1]["pos_" .. iter_151_0].assist_girl
				})
			end
		end

		self.curMapConfig.array = var_151_0
	elseif type(arg_151_1) == "table" then
		local var_151_1 = {}

		for iter_151_1, iter_151_2 in ipairs(arg_151_1) do
			if iter_151_2.girlInfo then
				local var_151_2 = {
					fight_girl = iter_151_2.girlInfo.servantId
				}

				var_151_2.npcid = iter_151_2.npcid or nil
				var_151_2.servantskin = iter_151_2.girlInfo.servantskin or nil

				if not iter_151_2.npcid and iter_151_2.horcruxInfo then
					var_151_2.assist_girl = iter_151_2.horcruxInfo.entityid or nil
				end

				var_151_2.isMainCharacter = not not iter_151_2.isMainCharacter

				table.insert(var_151_1, var_151_2)
			end
		end

		self.curMapConfig.array = var_151_1
	else
		print("update_selected_array is fail")
	end

	self:updateHorcruxCache()

	if not self.curMapConfig.change_role_modelid then
		self:triggerEvent(EVENT_TYPE.CHANGE_DRESS)
	end
end

function var_0_0:getCurrentFixArray(arg_152_1)
	local function var_152_0(arg_153_0)
		if npc_fightconfig_data[arg_153_0] and npc_fightconfig_data[arg_153_0].npcsoulid then
			return npc_data[npc_fightconfig_data[arg_153_0].npcsoulid].model
		elseif npc_fightconfig_data[arg_153_0] then
			return npc_fightconfig_data[arg_153_0].servantid
		end
	end

	local var_152_1
	local var_152_2

	if self.curMapConfig and self.curMapConfig.array and #self.curMapConfig.array > 0 then
		local var_152_3 = {}

		for iter_152_0 = 1, FORMATION_SHOW_GIRL_NUM do
			if self.curMapConfig.array[iter_152_0] then
				if self.curMapConfig.array[iter_152_0].npcid then
					var_152_1 = true
				end

				table.insert(var_152_3, cloneconf(self.curMapConfig.array[iter_152_0]))
			else
				table.insert(var_152_3, {})
			end
		end

		var_152_2 = var_152_3
	else
		var_152_1, var_152_2 = (function()
			local var_154_0 = {}
			local var_154_1 = false
			local var_154_2 = self:getExploreAimInfo(arg_152_1 or self.curMapConfig.aimid)

			for iter_154_0 = 1, FORMATION_SHOW_GIRL_NUM do
				if var_154_2["fight_girl" .. iter_154_0] then
					var_154_0[iter_154_0] = {
						npcid = var_154_2["fight_girl" .. iter_154_0],
						pos = iter_154_0,
						isMainCharacter = var_154_2["fight_girl" .. iter_154_0 .. "_result"] and var_154_2["fight_girl" .. iter_154_0 .. "_result"] == 1 and true or false,
						fight_girl = var_152_0(var_154_2["fight_girl" .. iter_154_0])
					}
					var_154_1 = true
				else
					var_154_0[iter_154_0] = {
						isMainCharacter = false,
						pos_lock = var_154_2["pos_unlock" .. iter_154_0] ~= 1 and true or false,
						pos = iter_154_0
					}
				end
			end

			return var_154_1, var_154_0
		end)()
	end

	return var_152_1, var_152_2
end

function var_0_0:initHorcruxCache()
	self.curMapConfig.horcruxCache = {}

	do return end

	local var_155_0, var_155_1 = self:getCurrentFixArray()

	for iter_155_0, iter_155_1 in ipairs(var_155_1) do
		if not iter_155_1.npcid and iter_155_1.assist_girl then
			self.curMapConfig.horcruxCache[iter_155_1.assist_girl] = {
				fight_girl = iter_155_1.fight_girl,
				assist_girl = iter_155_1.assist_girl
			}
		end
	end
end

function var_0_0:updateHorcruxCache()
	self.curMapConfig.horcruxCache = {}

	do return end

	for iter_156_0, iter_156_1 in ipairs(self.curMapConfig.array) do
		if not iter_156_1.npcid and iter_156_1.assist_girl then
			self.curMapConfig.horcruxCache[iter_156_1.assist_girl] = {
				fight_girl = iter_156_1.fight_girl,
				assist_girl = iter_156_1.assist_girl
			}
		end
	end
end

function var_0_0:queryHorcruxIsUsed(arg_157_1)
	if not self:isHpInherit() then
		return false
	end

	if self.curMapConfig and self.curMapConfig.horcruxCache then
		return not not self.curMapConfig.horcruxCache[arg_157_1]
	end

	return false
end

function var_0_0:getHorcruxByServantId(arg_158_1)
	if not self:isHpInherit() then
		return nil
	end

	if self.curMapConfig and self.curMapConfig.horcruxCache then
		for iter_158_0, iter_158_1 in pairs(self.curMapConfig.horcruxCache) do
			if iter_158_1.fight_girl == arg_158_1 then
				return iter_158_1.assist_girl
			end
		end
	end

	return nil
end

function var_0_0:registerEvent(arg_159_1, arg_159_2, arg_159_3)
	self.eventHandlers = self.eventHandlers or {}
	self.eventHandlers[arg_159_1] = self.eventHandlers[arg_159_1] or {}
	self.eventHandlers[arg_159_1][arg_159_2] = arg_159_3
end

function var_0_0:triggerEvent(arg_160_1, ...)
	if not self.eventHandlers then
		return
	end

	local var_160_0 = {}

	for iter_160_0, iter_160_1 in pairs(self.eventHandlers) do
		if iter_160_1[arg_160_1] then
			var_160_0[#var_160_0 + 1] = iter_160_1[arg_160_1]
		end
	end

	for iter_160_2, iter_160_3 in ipairs(var_160_0) do
		iter_160_3(...)
	end
end

function var_0_0:removeEvent(arg_161_1, arg_161_2)
	if not arg_161_1 then
		return
	end

	if arg_161_2 then
		self.eventHandlers[arg_161_1][arg_161_2] = nil
	else
		self.eventHandlers[arg_161_1] = nil
	end
end

function var_0_0.removeAllEvents(arg_162_0)
	arg_162_0.eventHandlers = {}
end

function var_0_0:setUniqueMonsterId(arg_163_1, arg_163_2)
	if not self:isHpInherit() then
		return
	end

	self.uniqueMonsterId = "_" .. arg_163_1 .. arg_163_2.x .. arg_163_2.y
end

function var_0_0:getUsedHorcruxs()
	if not self:isHpInherit() then
		return {}
	end

	if not self.curMapConfig or not self.curMapConfig.horcruxCache then
		return {}
	end

	local var_164_0 = {}

	for iter_164_0, iter_164_1 in pairs(self.curMapConfig.horcruxCache) do
		var_164_0[iter_164_1.assist_girl] = true
	end

	return var_164_0
end

function var_0_0:getDeadGirls()
	if not self:isHpInherit() then
		return {}
	end

	if not self.curMapConfig or not self.curMapConfig.hpInheritCache then
		return {}
	end

	local var_165_0 = {}

	for iter_165_0, iter_165_1 in pairs(self.curMapConfig.hpInheritCache) do
		if iter_165_1 <= 0 then
			var_165_0[iter_165_0] = true
		end
	end

	return var_165_0
end

function var_0_0:getExploreSkills()
	if not self:isHpInherit() then
		return nil
	end

	local var_166_0 = self:getExploreAimInfo(self.curMapConfig.aimid)
	local var_166_1 = {}

	while var_166_0["battlefieldstatus" .. 1] do
		var_166_1[#var_166_1 + 1] = var_166_0["battlefieldstatus" .. 1]
	end

	return var_166_1
end

function var_0_0:getExploreSkillDes()
	if not self:isHpInherit() then
		return {}
	end

	local var_167_0 = self:getExploreAimInfo(self.curMapConfig.aimid)
	local var_167_1 = {}

	while var_167_0["battlefieldstatus" .. 1] do
		if not var_167_0["cizhui_hide" .. 1] and var_167_0["cizhui_hide" .. 1] ~= 1 then
			var_167_1[#var_167_1 + 1] = var_167_0["battlefieldstatus" .. 1]
		end
	end

	return var_167_1
end

function var_0_0:isFixArray(arg_168_1)
	local var_168_0 = false
	local var_168_1 = self:getExploreAimInfo(arg_168_1 or self.curMapConfig.aimid)

	for iter_168_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if var_168_1["fight_girl" .. iter_168_0] then
			var_168_0 = true

			break
		end
	end

	return var_168_0
end

function var_0_0.setModelId(arg_169_0, arg_169_1)
	arg_169_0.modelId = arg_169_1
end

return var_0_0
