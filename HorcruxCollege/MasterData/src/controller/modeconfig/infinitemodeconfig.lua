local network = require("network.network")
local playermodel = require("model.playermodel")

return {
	getModeProceed = function(self, arg_1_1)
		return tostring(self:getCurEnemyCount(arg_1_1) + 1) .. "/10"
	end,
	getPassLevelCallback = function(arg_2_0)
		return function(arg_3_0, arg_3_1)
			if arg_3_0 == 1 then
				network:rpc("sync_curenemycount", {
					mode = playermodel.curMode,
					count = math.pow(50, 2)
				}, nil)

				if playermodel.levelmode[playermodel.curMode].status > arg_2_0:getModeTotalChapter(playermodel.curMode) then
					arg_2_0:returnToNormalFight()
				else
					arg_2_0:cleanHangupCount()
					FightManager.unregisterFightBoss()

					if arg_2_0:isCurChapterOld() then
						FightLayer.getInstance():updateFightButtonStatus(FIGHTBUTTON_HANGUPOLD)
					elseif arg_2_0:isChapterComplete() then
						arg_2_0:returnToNormalFight()
					else
						FightManager.setSearchDistance(ADVENTURE_SEARCH_DISTANCE)
						FightManager.setFightStatus(FIGHTSTATUS_SEARCHING)
						SmallFightLayer.getInstance():changeLevel()
					end
				end
			else
				arg_2_0:returnToNormalFight()
			end
		end
	end
}
