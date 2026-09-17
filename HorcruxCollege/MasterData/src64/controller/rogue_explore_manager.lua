local var_0_0 = {}
local network = require("network.network")
local rogue_explore_model = require("model.rogue_explore_model")

var_0_0.mapModels = {}

function var_0_0.init_map(arg_1_0, arg_1_1)
	LayerManager:pushInLayer("PopExplorePreviewLayer", {
		aimid = 10000001,
		sureCallback = function(arg_2_0)
			network:rpc("get_explore_config", {
				class = 5,
				param1 = 10000001
			}, function(arg_3_0)
				dump(arg_3_0)
			end)

			arg_1_1 = {
				activityid = 8848,
				aimid = 10000001,
				array = arg_2_0
			}
			arg_1_0.mapModels[arg_1_1.activityid] = rogue_explore_model:create(arg_1_1)

			LayerManager:switchShowLayer("RogueExploreLayer", {
				model = arg_1_0.mapModels[arg_1_1.activityid]
			})
		end
	})
end

function var_0_0:beginExplore(arg_4_1)
	self.mapModels[arg_4_1.activityid .. "_" .. arg_4_1.levelid] = rogue_explore_model:create(arg_4_1)

	self:setCurFightModel(arg_4_1.activityid .. "_" .. arg_4_1.levelid)
	LayerManager:switchShowLayer("RogueExploreLayer", {
		returnUiLayer = "ActivityMainLayer_505",
		model = self.mapModels[arg_4_1.activityid .. "_" .. arg_4_1.levelid]
	})
end

function var_0_0:removeRogue(arg_5_1)
	self.mapModels[arg_5_1] = nil
	self.cur_fight_activityid = nil
end

function var_0_0.setCurFightModel(arg_6_0, arg_6_1)
	arg_6_0.cur_fight_activityid = arg_6_1
end

function var_0_0:getExplorePlayer()
	return self.mapModels[self.cur_fight_activityid]:getExplorePlayer()
end

function var_0_0.initBossList(arg_8_0, arg_8_1)
	return var_0_0.mapModels[var_0_0.cur_fight_activityid]:initBossList(arg_8_1)
end

function var_0_0.onPlayerDie(arg_9_0)
	var_0_0.mapModels[var_0_0.cur_fight_activityid]:onPlayerDie()
end

function var_0_0.fightSurrender(arg_10_0, arg_10_1)
	var_0_0.mapModels[var_0_0.cur_fight_activityid]:fightSurrender(arg_10_1)
end

function var_0_0.fightFail(arg_11_0, arg_11_1)
	var_0_0.mapModels[var_0_0.cur_fight_activityid]:fightFail(arg_11_1)
end

function var_0_0.fightSuccess(arg_12_0, arg_12_1)
	var_0_0.mapModels[var_0_0.cur_fight_activityid]:fightSuccess(arg_12_1)
end

function var_0_0.getExploreCurLevelData(arg_13_0)
	return var_0_0.mapModels[var_0_0.cur_fight_activityid]:getExploreCurLevelData()
end

function var_0_0.getExploringbuffList(arg_14_0)
	return var_0_0.mapModels[var_0_0.cur_fight_activityid]:getExploringbuffList()
end

function var_0_0.getExploreSkills(arg_15_0)
	return var_0_0.mapModels[var_0_0.cur_fight_activityid]:getExploreSkills()
end

function var_0_0.getHpInherit(arg_16_0, arg_16_1)
	if not var_0_0.cur_fight_activityid then
		return false
	end

	if not var_0_0.mapModels[var_0_0.cur_fight_activityid] then
		return
	end

	return var_0_0.mapModels[var_0_0.cur_fight_activityid]:getHpInherit(arg_16_1)
end

return var_0_0
