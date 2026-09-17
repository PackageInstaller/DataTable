local playermodel = require("model.playermodel")
local chapter_data = require("data.chapter_data")
local levelmode_data = require("data.levelmode_data")
local core_manager = require("controller.core_manager")
local var_0_4 = {}

local function var_0_5()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(playermodel.haveServant) do
		if iter_3_1 and not var_0_4[iter_3_0] then
			table.insert(var_3_0, {
				servantid = iter_3_0,
				sciencepoint = core_manager:getStrengthenValue(iter_3_0, playermodel.cores[iter_3_0].coreid, core_manager:getCoreLv(iter_3_0))
			})
		end
	end

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		if arg_4_0.sciencepoint == arg_4_1.sciencepoint then
			return arg_4_0.servantid < arg_4_1.servantid
		else
			return arg_4_0.sciencepoint > arg_4_1.sciencepoint
		end
	end)

	return var_3_0
end

return {
	initAdventureStatus = function(arg_1_0)
		var_0_4 = {}

		for iter_1_0, iter_1_1 in pairs(playermodel.curSoul) do
			var_0_4[iter_1_1.fight_girl] = true
		end
	end,
	getModeProceed = function(arg_2_0, arg_2_1)
		return string.format("%d/%d" .. L_LAYER, playermodel.levelmode[arg_2_1].status, levelmode_data[arg_2_1].totalchapter)
	end,
	onPlayerDie = function(arg_5_0, arg_5_1)
		local var_5_0
		local var_5_1 = var_0_5()

		if var_5_1[1] then
			var_5_0 = var_5_1[1].servantid
		end

		if not var_5_0 then
			return
		end

		FightManager.getCharacter(arg_5_1):unregisterPlayerItem()
		FightManager.playerleave(arg_5_1)

		local var_5_2, var_5_3 = arg_5_1:match("([^@]+)@(.+)")
		local var_5_4 = tonumber(var_5_3)

		playermodel.curSoul[var_5_4].fight_girl = var_5_0
		var_0_4[var_5_0] = true

		FightManager.addNewPlayer(var_5_4)
	end,
	getPassLevelCallback = function(arg_6_0, arg_6_1)
		return function(arg_7_0, arg_7_1)
			if arg_7_0 == 1 then
				if playermodel.levelmode[arg_6_1].status > arg_6_0:getModeTotalChapter(arg_6_1) then
					arg_6_0:returnToNormalFight()
				else
					arg_6_0:cleanHangupCount()
					FightManager.unregisterFightBoss()

					if arg_6_0:isCurChapterOld() then
						FightLayer.getInstance():updateFightButtonStatus(FIGHTBUTTON_HANGUPOLD)
					elseif arg_6_0:isChapterComplete() then
						arg_6_0:returnToNormalFight()
					else
						FightManager.setSearchDistance(ADVENTURE_SEARCH_DISTANCE)
						FightManager.setFightStatus(FIGHTSTATUS_SEARCHING)
						SmallFightLayer.getInstance():changeLevel()
					end
				end
			else
				arg_6_0:returnToNormalFight()
			end
		end
	end
}
