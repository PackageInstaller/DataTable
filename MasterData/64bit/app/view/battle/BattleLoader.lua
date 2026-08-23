local var_0_0 = {}
local BattlePath = require("app.view.battle.BattlePath")
local var_0_2 = g.core.const.ConstMgr.SpineConst
local var_0_3 = g.core.resource.ResourceManager
local var_0_4 = g.core.config.knight_info
local var_0_5 = g.core.config.play_info
local var_0_6 = g.core.config.monster_info
local var_0_7 = g.core.config.unite_token_info
local var_0_9 = g.core.config.pet_info
local var_0_10 = g.core.config.passive_skill_info
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_12 = {}
local var_0_13 = {}
local var_0_14 = {}
local var_0_15 = {}
local var_0_16 = false
local var_0_17 = 1
local var_0_18 = true
local var_0_19 = {}
local var_0_20 = {}
local var_0_21 = {}
local var_0_22 = {}
local var_0_23 = 0

function var_0_0:loadResources()
	if g.core.utils.Quality.needIgnoreBattleCache() then
		var_0_2.BATTLE_TWEEN_CACHE = var_0_2.BATTLE_TWEEN_CACHE2
	end

	var_0_3:addSpineCache(var_0_2.TYPE.RES_EFFECT, var_0_2.BATTLE_RES_EFFECT_CACHE)
	var_0_3:addSpineCache(var_0_2.TYPE.BATTLE_TWEEN, var_0_2.BATTLE_TWEEN_CACHE)
	var_0_3:addSpineCache(var_0_2.TYPE.BATTLE_BUFF, var_0_2.BATTLE_BUFF_CACHE)
	var_0_3:addSpineCache(var_0_2.TYPE.BATTLE_ATTR, var_0_2.BATTLE_ATTR_CACHE)

	local function var_1_0(arg_2_0)
		if arg_2_0 == "0" or var_0_22[arg_2_0] then
			return
		end

		var_0_22[arg_2_0] = true

		local var_2_0 = json.decodeFileIfExists((BattlePath.getSpineEffectGroupPath(arg_2_0)))

		if var_2_0 then
			for iter_2_0, iter_2_1 in ipairs(var_2_0) do
				if iter_2_1.name and (not iter_2_1.type or iter_2_1.type == 1) then
					var_0_20[iter_2_1.name] = true
				end
			end
		else
			dump("ERROR:找不到特效组文件" .. arg_2_0)
			g.core.module.ModuleManager:tip("ERROR:找不到特效组文件" .. arg_2_0)
		end
	end

	local function var_1_1(arg_3_0)
		var_1_0(arg_3_0.attack_action)
		var_1_0(arg_3_0.gethit_action_1)

		if arg_3_0.trajectory ~= "0" then
			var_0_20[arg_3_0.trajectory] = true
		end
	end

	local function var_1_2(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_1.get(arg_4_0.id)
		local var_4_2

		if arg_4_0.common_skill_id and arg_4_0.common_skill_id > 0 then
			if arg_4_0.active_skill_id and arg_4_0.active_skill_id > 0 then
				var_4_2 = arg_4_0.active_skill_id or var_4_0.active_skill_id
			end
		end

		var_1_1((var_0_5:get(var_4_0.advance_id, arg_4_0.skin or 0)))
		var_1_1((var_0_5:get(var_4_0.advance_id, arg_4_0.skin or 0)))
	end

	local var_1_3 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_SKIP)

	local function var_1_4(arg_5_0)
		local var_5_0 = arg_5_0.isMonster and self.play_id ~= BattleConst.ServerPlayId.EXPLORATION_BOSS

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.units) do
			if not var_1_3 or iter_5_1.pos <= 1 then
				var_1_2(iter_5_1, (var_5_0 or nil) and (var_0_6 or var_0_4))
			end
		end

		if not var_1_3 then
			for iter_5_2, iter_5_3 in ipairs(arg_5_0.combo.tokens or {}) do
				var_1_1((var_0_5.get(var_0_7.get(iter_5_3).skill_id, 0, 0)))
			end
		end
	end

	var_1_4(self.own_teams[1])
	var_1_4(self.enemy_teams[1])

	for iter_1_0, iter_1_1 in pairs(var_0_20) do
		if iter_1_1 then
			table.insert(var_0_21, iter_1_0)
		end
	end

	var_0_23 = 5 * #var_0_21

	var_0_3:addSpineCache(var_0_2.TYPE.BATTLE_KNIGHT, var_0_19)

	if not g.core.utils.Quality.needIgnoreBattleCache() then
		var_0_3:addSpineCache(var_0_2.TYPE.BATTLE_EFFECT, var_0_21)
	end
end

function var_0_0.unloadResources()
	var_0_3:removeSpineCache(var_0_2.TYPE.RES_EFFECT, var_0_2.BATTLE_RES_EFFECT_CACHE)
	var_0_3:removeSpineCache(var_0_2.TYPE.BATTLE_TWEEN, var_0_2.BATTLE_TWEEN_CACHE)
	var_0_3:removeSpineCache(var_0_2.TYPE.BATTLE_BUFF, var_0_2.BATTLE_BUFF_CACHE)
	var_0_3:removeSpineCache(var_0_2.TYPE.BATTLE_ATTR, var_0_2.BATTLE_ATTR_CACHE)
	var_0_3:removeSpineCache(var_0_2.TYPE.BATTLE_KNIGHT, var_0_19)

	if not g.core.utils.Quality.needIgnoreBattleCache() then
		var_0_3:removeSpineCache(var_0_2.TYPE.BATTLE_EFFECT, var_0_21)
	end

	var_0_19 = {}
	var_0_20 = {}
	var_0_21 = {}
	var_0_22 = {}
	var_0_23 = 0

	for iter_6_0, iter_6_1 in ipairs(var_0_14) do
		if iter_6_1.texture then
			iter_6_1.texture:release()
		end
	end

	var_0_14 = {}
	var_0_15 = {}
	var_0_12 = {}
	var_0_13 = {}
	var_0_16 = true
end

function var_0_0.step()
	if var_0_18 and (function()
		if var_0_23 < 1 then
			return false
		end

		if var_0_23 % 5 == 0 then
			-- block empty
		end

		var_0_23 = var_0_23 - 1

		return true
	end)() then
		-- block empty
	end
end

function var_0_0:loadResourcesOld()
	local function var_9_0(arg_10_0, arg_10_1)
		var_0_13[arg_10_1] = var_0_13[arg_10_1] or {}

		if var_0_13[arg_10_1][arg_10_0] then
			return
		end

		var_0_12[#var_0_12 + 1] = {
			name = arg_10_0,
			type = arg_10_1
		}
		var_0_13[arg_10_1][arg_10_0] = true
	end

	local function var_9_1(arg_11_0)
		var_9_0(arg_11_0.attack_action, 1)
		var_9_0(arg_11_0.gethit_action_1, 1)
		var_9_0(arg_11_0.gethit_action_2, 1)
		var_9_0(arg_11_0.trajectory, 2)
		var_9_0(arg_11_0.background, 2)
		var_9_0(arg_11_0.splash, 2)
		var_9_0(arg_11_0.unite_skill_drawing, 2)
		var_9_0(arg_11_0.full_screen_up, 2)
		var_9_0(arg_11_0.full_screen_down, 2)
		var_9_0(arg_11_0.camara_effect, 3)
	end

	local function var_9_2(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1.get(arg_12_0.id)
		local var_12_1 = var_12_0.common_id
		local var_12_2 = var_12_0.active_skill_id
		local var_12_3 = var_12_0.advance_id

		if arg_12_0.cardId then
			var_12_3 = g.core.config.transformation_card_info.get(arg_12_0.cardId).advance_id
		end

		if arg_12_0.common_skill_id and arg_12_0.common_skill_id > 0 then
			var_12_1 = arg_12_0.common_skill_id
		end

		if arg_12_0.active_skill_id and arg_12_0.active_skill_id > 0 then
			var_12_2 = arg_12_0.active_skill_id
		end

		local var_12_4 = arg_12_0.skin or 0

		var_9_1((var_0_5.get(var_12_1, var_12_3, var_12_4)))
		var_9_1((var_0_5.get(var_12_2, var_12_3, var_12_4)))
	end

	local function var_9_3(arg_13_0, arg_13_1, arg_13_2)
		for iter_13_0, iter_13_1 in ipairs(arg_13_0) do
			var_9_1((var_0_5.get(var_0_7.get(iter_13_1).skill_id, 0, 0)))
		end
	end

	local function var_9_4(arg_14_0, arg_14_1)
		for iter_14_0, iter_14_1 in ipairs(arg_14_0.units) do
			if arg_14_1 == 1 and iter_14_1.pos <= 3 or arg_14_1 == 2 and iter_14_1.pos >= 4 then
				var_9_2(iter_14_1, (arg_14_0.isMonster or nil) and (var_0_6 or var_0_4))
			end
		end
	end

	local function var_9_5(arg_15_0)
		for iter_15_0, iter_15_1 in ipairs(arg_15_0) do
			local var_15_0 = var_0_9.get(iter_15_1)

			if var_15_0.passive_skill_1 > 0 then
				var_9_1((var_0_5.get(var_0_10.get(var_15_0.passive_skill_1).passive_skill_value, var_15_0.advance_id, 0)))
			end

			if var_15_0.passive_skill_2 > 0 then
				var_9_1((var_0_5.get(var_0_10.get(var_15_0.passive_skill_2).passive_skill_value, var_15_0.advance_id, 0)))
			end
		end
	end

	local function var_9_6(arg_16_0, arg_16_1)
		for iter_16_0, iter_16_1 in ipairs(arg_16_0.units) do
			var_9_2(iter_16_1, (arg_16_0.isMonster or nil) and (var_0_6 or var_0_4))
		end

		var_9_3(arg_16_0.combo.tokens or {}, arg_16_0, arg_16_1)
		var_9_5(arg_16_0.pets or {})
	end

	local var_9_7 = self.own_teams[1]
	local var_9_8 = self.enemy_teams[1]

	if self.atk_type == 2 and self.own_teams[1].fight_value < self.enemy_teams[1].fight_value then
		var_9_7 = self.enemy_teams[1]
		var_9_8 = self.own_teams[1]
	end

	local var_9_9

	if var_9_7.isMonster then
		var_9_9 = var_0_6 or var_0_4
	end

	local var_9_10

	for iter_9_0, iter_9_1 in ipairs(var_9_7.units) do
		local var_9_11

		if 7 > iter_9_1.pos then
			var_9_10 = iter_9_1
			var_9_11 = iter_9_1.pos
		end
	end

	var_9_2(var_9_10, var_9_9)
	var_9_5(var_9_7.pets or {})
	var_9_5(var_9_8.pets or {})
	var_9_4(var_9_7, 1)
	var_9_4(var_9_8, 1)
	var_9_3(var_9_7.combo.tokens or {}, var_9_7, 1)
	var_9_3(var_9_8.combo.tokens or {}, var_9_8, 1)
	var_9_4(var_9_7, 2)
	var_9_4(var_9_8, 2)

	for iter_9_2 = 2, #self.own_teams do
		var_9_6(self.own_teams[iter_9_2], iter_9_2)
	end

	for iter_9_3 = 2, #self.enemy_teams do
		var_9_6(self.enemy_teams[iter_9_3], iter_9_3)
	end

	var_0_0.loadList(var_0_14)

	local var_9_13 = {}

	for iter_9_4 = 1, #var_0_12 do
		var_9_13[iter_9_4] = var_0_12[#var_0_12 + 1 - iter_9_4]
	end

	var_0_12 = var_9_13
	var_0_23 = #var_0_12
end

function var_0_0.loadList(arg_17_0)
	var_0_16 = false
	var_0_18 = false

	local function var_17_1()
		local var_18_0 = arg_17_0[var_0_17]

		if arg_17_0[var_0_17] then
			if arg_17_0[var_0_17].type == 1 then
				display.loadImage(arg_17_0[var_0_17].value, function(arg_19_0)
					assert(arg_19_0, "Load Texture Fail: " .. tostring(var_18_0.value))

					if var_0_16 then
						return
					end

					arg_19_0:retain()

					var_18_0.texture = arg_19_0
					var_0_17 = var_0_17 + 1

					var_17_1()
				end)
			elseif arg_17_0[var_0_17].type == 2 then
				display.loadImage(arg_17_0[var_0_17].value .. ".png", function(arg_20_0)
					assert(arg_20_0, "Load Texture Fail: " .. tostring(var_18_0.value))

					if var_0_16 then
						return
					end

					arg_20_0:retain()

					var_18_0.texture = arg_20_0

					if cc.FileUtils:getInstance():isFileExist(var_18_0.value .. ".bytes") then
						cc.SpriteFrameCache:getInstance():addSpriteFramesWithBytes(var_18_0.value .. ".bytes")
					else
						display.loadSpriteFrames(var_18_0.value .. ".plist", var_18_0.value .. ".png")
					end

					var_0_17 = var_0_17 + 1

					var_17_1()
				end)
			end
		else
			var_0_18 = true
		end
	end

	var_17_1()
end

return var_0_0
