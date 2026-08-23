local var_0_0 = g.core.model.User.peakArenaData
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User
local BattleVSPeakArenaUserInfoComp = class("BattleVSPeakArenaUserInfoComp", require("app.fairyGUI.battle.UI_BattleVSPeakArenaLeftUserInfoComp"))

function BattleVSPeakArenaUserInfoComp:updateComp(arg_1_1, arg_1_2)
	local var_1_1 = var_0_0:getMatchedOpponentInfo()

	if var_1_1 then
		if arg_1_1 then
			self:_updateScoreView(var_1_1.myScore)
		elseif var_1_1.isRobot then
			local var_1_2 = g.core.model.User.snapShotCacheData:getDataSnapShotTemplate(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_1_1.targetId)

			self:_updateScoreView(g.core.config.peakarena_robot_info.get(var_1_1.targetId).score)
		else
			local var_1_3 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_1_1.targetId)

			self:_updateScoreView(var_1_1.score)
		end
	else
		local var_1_4 = var_0_0:getRecordByBattleId((var_0_0:getCacheBattleId()))

		if var_1_4 then
			local var_1_5 = var_1_4.attacker == var_0_2:getId()
			local var_1_6, var_1_7, var_1_8

			if var_1_5 then
				var_1_6 = var_1_4.attacker_score or var_1_4.defender_score

				if var_1_5 then
					var_1_7 = var_1_4.defender_score or var_1_4.attacker_score

					if var_1_5 then
						var_1_8 = var_1_4.defender or var_1_4.attacker
					end
				end
			end

			local var_1_9 = var_1_4.defender_robot_id and var_1_4.defender_robot_id > 0

			if arg_1_1 then
				if var_1_5 then
					self:_updateScoreView(var_1_6)
				else
					local var_1_10 = g.core.model.User.snapShotCacheData

					if var_1_9 then
						var_1_8 = var_1_4.defender_robot_id

						local var_1_11 = var_1_10:getDataSnapShotTemplate(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_1_4.defender_robot_id)

						self:_updateScoreView(g.core.config.peakarena_robot_info.get(var_1_4.defender_robot_id).score)
					else
						local var_1_12 = var_1_10:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_1_8)

						self:_updateScoreView(var_1_7)
					end
				end
			elseif var_1_5 then
				if var_1_9 then
					var_1_8 = var_1_4.defender_robot_id

					local var_1_13 = g.core.model.User.snapShotCacheData:getDataSnapShotTemplate(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_1_4.defender_robot_id)

					self:_updateScoreView(g.core.config.peakarena_robot_info.get(var_1_4.defender_robot_id).score)
				else
					local var_1_14 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_1_8)

					self:_updateScoreView(var_1_7)
				end
			else
				self:_updateScoreView(var_1_6)
			end
		end
	end

	self.m_nameText:setText(arg_1_2.name)
	self.m_serverNameTxt:setText(arg_1_2.serverName)
	self.m_powerTxt:setText(arg_1_2.fightValue)
end

function BattleVSPeakArenaUserInfoComp:_updateScoreView(arg_2_1)
	self.m_scoreTxt:setText(arg_2_1)

	local var_2_0 = var_0_2.peakArenaData:getPALevelInfo(arg_2_1)

	self.m_danGradingLoader:setURL((var_0_1:getPeakArenaDanGradingPic(var_2_0.pic)))
	self.m_danGradingTxt:setText(var_2_0.name)
	self.m_starComp:initStar({
		gap = -6,
		style = 2,
		index = 8,
		max = var_0_2.peakArenaData:getMaxStarNum(var_2_0.pic),
		num = var_2_0.star
	})
end

return BattleVSPeakArenaUserInfoComp
