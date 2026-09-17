local var_0_0 = {}
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local monster_manager = require("controller.monster_manager")
local grade_manager = require("controller.grade_manager")
local item_manager = require("controller.item_manager")
local souls_manager = require("controller.souls_manager")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local old_substitute_awards_data = require("data.old_substitute_awards_data")
local network = require("network.network")

function var_0_0.getCurSubstitutionChapter(arg_1_0, arg_1_1)
	network:rpc("get_substitution_chapter", nil, function(arg_2_0)
		if arg_1_1 then
			arg_1_1(arg_2_0.chapter)
		end
	end)
end

function var_0_0:switchToSubstitution(arg_3_1)
	network:rpc("switch_to_old_substitutionmode", nil, function(arg_4_0)
		if arg_4_0.result == 1 then
			playermodel.curLevel = arg_4_0.curlevel
			playermodel.curMode = arg_4_0.curmode

			self:resetFightingArrays()

			if arg_3_1 then
				arg_3_1(arg_4_0.result)
			end
		elseif arg_4_0.result == 2 and arg_3_1 then
			arg_3_1(arg_4_0.result)
		end
	end)
	self:initDmgPercent()
end

function var_0_0:syncSubstitutionScore()
	network:rpc("sync_subfight_score", {
		hp = math.floor(self._bossinfo.damage)
	})
end

function var_0_0:passSubstitution(arg_6_1, arg_6_2)
	network:rpc("pass_old_substitution", {
		hp = math.floor(self._bossinfo.damage),
		totalhp = self._bossinfo.totalhp,
		issuccess = arg_6_2
	}, function(arg_7_0)
		if arg_7_0.exp and arg_7_0.grade then
			grade_manager:update_player_exp(arg_7_0.exp, arg_7_0.grade, arg_7_0.totalexp)
		end

		if arg_7_0.sp and arg_7_0.sp > 0 then
			playermodel.strengthpoint = playermodel.strengthpoint + arg_7_0.sp

			global_update_strengthpoint(true)
			AlertManager:check_servant_strenghth(true)
		end

		if arg_7_0.gold then
			playermodel.gold = playermodel.gold + arg_7_0.gold
		end

		local var_7_0 = {}

		if arg_7_0.items then
			for iter_7_0, iter_7_1 in pairs(arg_7_0.items) do
				local var_7_1 = item_manager:setItemByServerItem(iter_7_1)

				if var_7_1 ~= 0 then
					table.insert(var_7_0, {
						entityid = iter_7_1.entityid,
						itemid = iter_7_1.itemid,
						itemcount = var_7_1,
						itemtype = iter_7_1.itemtype
					})
				end
			end
		end

		local var_7_2 = {}

		if arg_7_0.olddrop and arg_7_0.olddrop.items then
			for iter_7_2, iter_7_3 in pairs(arg_7_0.olddrop.items) do
				if iter_7_3.dropNum ~= 0 then
					table.insert(var_7_2, {
						itemid = iter_7_3.dropid,
						itemcount = iter_7_3.dropNum
					})
				end
			end
		end

		global_update_gold_stone_diamond(arg_7_0.gold)

		arg_7_0.addItemList = var_7_0
		arg_7_0.oldItemList = var_7_2

		local var_7_3 = {}

		for iter_7_4 = 1, 5 do
			if self._serventArrays[iter_7_4] and next(self._serventArrays[iter_7_4]) then
				for iter_7_5, iter_7_6 in pairs(self._serventArrays[iter_7_4]) do
					table.insert(var_7_3, {
						classtype = 1,
						fight_girl = iter_7_6.servantid
					})
				end
			end
		end

		if #var_7_3 > 0 then
			arg_7_0.curarray = var_7_3
		end

		if arg_6_1 then
			arg_6_1(arg_7_0)
		end
	end)
end

function var_0_0.startSubstitution(arg_8_0)
	arg_8_0._fighted = {}
	arg_8_0._substitute = {}
	arg_8_0._boss = nil
	arg_8_0._bossinfo = {
		totalhp = 100000000000,
		score = 0,
		damage = 0
	}
	arg_8_0._cachequeue = {}
end

local var_0_13 = {
	tank = "fighter",
	shooter = "assassin",
	witcher = "support",
	fighter = "tank",
	assassin = "shooter",
	support = "witcher"
}

function var_0_0:substitutionServant(arg_9_1)
	if self:getRemainServantCount() <= 0 then
		return false
	end

	local var_9_0 = servant_data[playermodel.curSoul[arg_9_1].fight_girl].modelid
	local var_9_1

	repeat
		if self._substitute[model_data[servant_data[playermodel.curSoul[arg_9_1].fight_girl].modelid].career] and #self._substitute[model_data[servant_data[playermodel.curSoul[arg_9_1].fight_girl].modelid].career] > 0 then
			var_9_1 = table.remove(self._substitute[model_data[servant_data[playermodel.curSoul[arg_9_1].fight_girl].modelid].career], 1)

			break
		end

		local var_9_2 = var_0_13[model_data[servant_data[playermodel.curSoul[arg_9_1].fight_girl].modelid].career]

		if self._substitute[var_0_13[model_data[servant_data[playermodel.curSoul[arg_9_1].fight_girl].modelid].career]] and #self._substitute[var_9_2] > 0 then
			var_9_1 = table.remove(self._substitute[var_9_2], 1)

			break
		end

		local var_9_3

		for iter_9_0, iter_9_1 in pairs(self._substitute) do
			if #iter_9_1 > 0 then
				if not var_9_3 then
					var_9_3 = iter_9_0
				elseif iter_9_1[1].fightpower > self._substitute[var_9_3][1].fightpower then
					var_9_3 = iter_9_0
				end
			end
		end

		if var_9_3 then
			var_9_1 = table.remove(self._substitute[var_9_3], 1)
		end
	until true

	if var_9_1 then
		playermodel.curSoul[arg_9_1].fight_girl = var_9_1.servant
		self._fighted[var_9_1.servant] = true

		self:remove_spine_cache(var_9_0)

		return true
	else
		return false
	end
end

function var_0_0:getRemainServantCount()
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(self._substitute) do
		var_10_0 = var_10_0 + #iter_10_1
	end

	return var_10_0
end

function var_0_0:canSubstitute(arg_11_1)
	return self._fightingArrays[arg_11_1][1] ~= nil
end

function var_0_0:dequeueSustitute(arg_12_1)
	local var_12_0 = table.remove(self._fightingArrays[arg_12_1], 1)

	return {
		fight_girl = var_12_0.servantid,
		assist_girl = var_12_0.horcrux
	}
end

function var_0_0:getSubstitutionPlayer()
	self:startSubstitution()

	return self:getBattleArrayData()
end

function var_0_0.getSubstitutionEnemy(arg_14_0)
	local var_14_0 = monster_manager.initBossList((level_manager.getBossTeam()))

	arg_14_0._boss = var_14_0.boss.id

	return var_14_0
end

function var_0_0.updateSubstitutionEnemyTotalHp(arg_15_0, arg_15_1)
	arg_15_0._bossinfo = {
		score = 0,
		damage = 0,
		totalhp = arg_15_1
	}
end

function var_0_0:updateSubstitutionEnemyHurt(arg_16_1)
	self._bossinfo.damage = self._bossinfo.damage + arg_16_1

	if self.dmgPercent ~= self:getCurDamage() then
		self:setDmgPercent(self:getCurDamage())
		FightLayer.getInstance():updateSubRate(self.dmgNum)
	end

	if self:beyondNextScore() then
		self:syncSubstitutionScore()
	end
end

function var_0_0:beyondNextScore()
	if not old_substitute_awards_data[self._bossinfo.score + 1] then
		return false
	end

	if math.floor(self._bossinfo.damage) >= old_substitute_awards_data[self._bossinfo.score + 1].percent then
		self._bossinfo.score = self._bossinfo.score + 1

		return true
	end

	return false
end

function var_0_0:getCurDamage()
	return global_trans_bitmapnumber(self._bossinfo.damage)
end

function var_0_0:getCurDamagePercent()
	return string.format("%.1f", self._bossinfo.damage / self._bossinfo.totalhp * 100)
end

function var_0_0.initDmgPercent(arg_20_0)
	arg_20_0.dmgNum = "0"
end

function var_0_0.setDmgPercent(arg_21_0, arg_21_1)
	arg_21_0.dmgNum = arg_21_1
end

local function var_0_14(arg_22_0)
	local var_22_1 = require("fight.spine." .. model_data[arg_22_0].spinecfg)

	if not var_22_1.xpeffect then
		return
	end

	for iter_22_0, iter_22_1 in pairs(var_22_1.xpeffect) do
		if type(iter_22_1.bgfile) == "string" then
			SpineCacheManager:releaseSpineCacheTextures("spine/test/" .. iter_22_1.bgfile .. ".json", "spine/test/" .. iter_22_1.bgfile .. ".atlas")
		end
	end
end

function var_0_0.remove_spine_cache(arg_23_0, arg_23_1)
	SpineCacheManager:releaseSpineCacheTextures(ROLE_SPINE_PATH .. model_data[arg_23_1].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[arg_23_1].spine_model .. ".atlas", (model_data[arg_23_1].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[arg_23_1].clothes_model .. ".atlas" or nil))
	var_0_14(arg_23_1)
end

function var_0_0.get_old_substitution_array(arg_24_0, arg_24_1)
	network:rpc("get_old_substitution_battlearray", nil, function(arg_25_0)
		if arg_24_1 then
			arg_24_1(arg_25_0)
		end
	end)
end

function var_0_0.set_old_substitution_servant(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	network:rpc("set_old_substitution_servant", {
		array = arg_26_1,
		pos = arg_26_2,
		servantid = arg_26_3
	}, function(arg_27_0)
		if arg_26_4 then
			arg_26_4(arg_27_0)
		end
	end)
end

function var_0_0.set_old_substitution_horcrux(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	network:rpc("set_old_substitution_horcrux", {
		array = arg_28_1,
		pos = arg_28_2,
		horcrux = arg_28_3
	}, function(arg_29_0)
		if arg_28_4 then
			arg_28_4(arg_29_0)
		end
	end)
end

function var_0_0:resetFightingArrays()
	self._fightingArrays = {
		{},
		{},
		{},
		{},
		{}
	}

	local var_30_0 = require("controller.formation.formation_old_substitute_manager"):getInstance():getFormationInfo()

	for iter_30_0 = 1, 5 do
		for iter_30_1 = 1, 5 do
			if var_30_0[iter_30_0][iter_30_1].fight_girl then
				table.insert(self._fightingArrays[iter_30_1], {
					died = false,
					servantid = var_30_0[iter_30_0][iter_30_1].fight_girl,
					horcrux = var_30_0[iter_30_0][iter_30_1].assist_girl
				})
			end
		end
	end

	self._serventArrays = clone(self._fightingArrays)
end

function var_0_0:getAllFightingArrays()
	local var_31_0 = {}

	for iter_31_0 = 1, 5 do
		var_31_0[iter_31_0] = self._fightingArrays[iter_31_0][1] and {
			servantid = self._fightingArrays[iter_31_0][1].servantid,
			horcrux = self._fightingArrays[iter_31_0][1].horcrux
		} or {}
	end

	for iter_31_1, iter_31_2 in ipairs(self._fightingArrays) do
		for iter_31_3, iter_31_4 in ipairs(iter_31_2) do
			table.insert(var_31_0, {
				servantid = iter_31_4.servantid,
				horcrux = iter_31_4.horcrux
			})
		end
	end

	return var_31_0
end

function var_0_0:getBattleArrayData()
	local var_32_0 = {}

	for iter_32_0 = 1, 5 do
		var_32_0[iter_32_0] = self:canSubstitute(iter_32_0) and self:dequeueSustitute(iter_32_0) or {}
	end

	return var_32_0
end

function var_0_0.get_player_old_substitution_data(arg_33_0, arg_33_1)
	network:rpc("get_player_old_substitution_data", nil, function(arg_34_0)
		if arg_34_0.result == 1 then
			if arg_34_0.item_res then
				global_gain(arg_34_0.item_res)
			end

			if arg_33_1 then
				arg_33_1(arg_34_0)
			end
		elseif arg_34_0.result == 2 then
			global_ShowBlockWords("目前没有在进行的极限拟练哦~")
		end
	end)
end

function var_0_0.get_old_substitute_rank_list(arg_35_0, arg_35_1, arg_35_2)
	network:rpc("get_old_substitute_rank_list", {
		type = arg_35_1
	}, function(arg_36_0)
		if arg_36_0.result == 1 then
			if arg_35_2 then
				arg_35_2(arg_36_0.data, arg_36_0.player_data)
			end
		else
			global_ShowBlockWords("暂无极限拟练排行榜哦~")
		end
	end)
end

function var_0_0.get_old_substitute_daily_reward(arg_37_0, arg_37_1)
	network:rpc("get_old_substitute_daily_reward", nil, function(arg_38_0)
		if arg_37_1 then
			arg_37_1(arg_38_0)
		end
	end)
end

function var_0_0.get_old_substitution_remaintime(arg_39_0)
	local var_39_0 = require("controller.time_check_manager"):getCurTime()

	for iter_39_0, iter_39_1 in ipairs((require("data.old_substitution_data"))) do
		if (not iter_39_1.starttime or var_39_0 >= os.time(parse_time(iter_39_1.starttime))) and iter_39_1.finishtime and var_39_0 < os.time(parse_time(iter_39_1.finishtime)) then
			return os.time(parse_time(iter_39_1.finishtime)) - var_39_0
		end
	end
end

function var_0_0.get_old_substitution_showAttr(arg_40_0)
	local var_40_0 = require("controller.time_check_manager"):getCurTime()

	for iter_40_0, iter_40_1 in ipairs((require("data.old_substitution_data"))) do
		if (not iter_40_1.starttime or var_40_0 >= os.time(parse_time(iter_40_1.starttime))) and (not iter_40_1.finishtime or var_40_0 < os.time(parse_time(iter_40_1.finishtime))) then
			return iter_40_1.showAttr
		end
	end
end

function var_0_0.get_old_substitution_shop(arg_41_0)
	local var_41_0 = require("controller.time_check_manager"):getCurTime()

	for iter_41_0, iter_41_1 in ipairs((require("data.old_substitution_data"))) do
		if (not iter_41_1.starttime or var_41_0 >= os.time(parse_time(iter_41_1.starttime))) and (not iter_41_1.finishtime or var_41_0 < os.time(parse_time(iter_41_1.finishtime))) then
			return iter_41_1.shop
		end
	end
end

function var_0_0.get_old_substitute_player_rank(arg_42_0, arg_42_1)
	network:rpc("get_old_substitute_player_rank", nil, function(arg_43_0)
		if arg_43_0.result == 1 and arg_42_1 then
			arg_42_1(arg_43_0)
		end
	end)
end

return var_0_0
