local WorldBossStartBattleCommand = class("WorldBossStartBattleCommand", pm.SimpleCommand)

function WorldBossStartBattleCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.bossId
	local var_1_2 = var_1_0.isOther
	local var_1_3 = var_1_0.hpRate
	local var_1_4 = var_1_0.isSimulate
	local var_1_5 = nowWorld():GetBossProxy()
	local var_1_6 = var_1_5:GetBossById(var_1_0.bossId)
	local var_1_7

	if var_1_0.isSimulate then
		var_1_7 = pg.world_boss_level[WorldBossConst.GetCurrBossID() == var_1_1 and pg.world_joint_boss_template[var_1_1].boss_level_id + var_1_5.currentBossLV - 1 or pg.world_joint_boss_template[var_1_1].boss_level_id + 14].expedition_id
	else
		if not var_1_6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_boss_not_found"))

			return
		end

		if var_1_0.isOther and var_1_5:GetPt() <= 0 and WorldBossConst._IsCurrBoss(var_1_6) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_count_no_enough"))

			return
		end

		var_1_7 = var_1_6:GetStageID()
	end

	local function var_1_9()
		pg.m02:retrieveMediator(getProxy(ContextProxy):getCurrentContext().mediator.__cname):addSubLayers(Context.New({
			mediator = WorldBossFormationMediator,
			viewComponent = WorldBossFormationLayer,
			data = {
				actID = 0,
				stageId = var_1_7,
				bossId = var_1_1,
				system = SYSTEM_WORLD_BOSS,
				isOther = var_1_2,
				hpRate = var_1_3,
				isSimulate = var_1_4
			}
		}))

		return
	end

	if var_1_4 then
		var_1_9()
	else
		self:sendNotification(GAME.CHECK_WORLD_BOSS_STATE, {
			bossId = var_1_1,
			time = var_1_6.lastTime,
			callback = var_1_9,
			failedCallback = function()
				var_1_5:RemoveCacheBoss(var_1_6.id)

				return
			end
		})
	end

	return
end

return WorldBossStartBattleCommand
