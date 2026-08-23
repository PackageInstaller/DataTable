return {
	btnCfg = {
		{
			redId = 701,
			title = 109057,
			channel = g.core.const.ConstMgr.ChatConst.AREA,
			isShow = function()
				return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND)
			end
		},
		{
			redId = 52,
			title = 109001,
			channel = g.core.const.ConstMgr.ChatConst.WORLD,
			isShow = function()
				return true
			end
		},
		{
			title = 109002,
			channel = g.core.const.ConstMgr.ChatConst.SYSTEM,
			isShow = function()
				return true
			end
		},
		{
			title = 109003,
			channel = g.core.const.ConstMgr.ChatConst.STORM,
			isShow = function()
				return false
			end
		},
		{
			redId = 259,
			title = 109004,
			channel = g.core.const.ConstMgr.ChatConst.ARMY,
			isShow = function()
				return true
			end
		},
		{
			redId = 839,
			title = 428520,
			channel = g.core.const.ConstMgr.ChatConst.ALLIANCE,
			isShow = function()
				return g.core.model.User.allianceData:hasAlliance()
			end
		},
		{
			redId = 260,
			title = 109005,
			channel = g.core.const.ConstMgr.ChatConst.TROOPS,
			isShow = function()
				local var_7_0 = g.core.module.ModuleManager:getCurModule()

				if g.core.model.User.bioData:getTeamInfo().id == 0 or (var_7_0 or nil) and var_7_0.module == g.view.entrance.DUNGEON then
					return false
				else
					return true
				end
			end
		},
		{
			redId = 51,
			title = 109006,
			channel = g.core.const.ConstMgr.ChatConst.SINGLE,
			isShow = function()
				return true
			end
		},
		{
			redId = 322,
			title = 109007,
			channel = g.core.const.ConstMgr.ChatConst.GUILD_WAR,
			isShow = function()
				return g.core.model.User.guildWarData:isOpenChat()
			end
		},
		{
			redId = 792,
			title = 109069,
			channel = g.core.const.ConstMgr.ChatConst.BOUNTY,
			isShow = function()
				return g.core.model.User.bountyData:isActivityOpen()
			end
		},
		{
			redId = 819,
			title = 109070,
			channel = g.core.const.ConstMgr.ChatConst.TEAM_BATTLE,
			isShow = function()
				if not g.core.model.User.teamBattleData:isActivityOpen() then
					return false
				end

				return g.core.model.User.teamBattleData:getTeamUpData():hasMyTeam()
			end
		},
		{
			title = 427100,
			channel = g.core.const.ConstMgr.ChatConst.TEAM_BATTLE_ZONE,
			isShow = function()
				return g.core.model.User.teamBattleData:isActivityOpen()
			end
		},
		{
			title = 429544,
			channel = g.core.const.ConstMgr.ChatConst.NEW_SLG,
			isShow = function()
				return g.core.model.User.newSlgData:isOpen()
			end
		},
		{
			title = 433400,
			channel = g.core.const.ConstMgr.ChatConst.ANCIENTS,
			isShow = function()
				return g.core.model.User.ancientsData:isTimeToOpen()
			end
		},
		{
			redId = 946,
			title = 431652,
			channel = g.core.const.ConstMgr.ChatConst.ANNIVERSARY,
			isShow = function()
				if g.core.model.User.anniversaryData:getCurStage() == g.core.const.ConstMgr.AnniversaryConst.STAGE.GAME then
					return true
				end

				return false
			end
		}
	},
	settingCfg = {
		{
			desc = 109011,
			index = 3
		},
		{
			desc = 109012,
			index = 2
		},
		{
			desc = 109013,
			index = 4
		},
		{
			desc = 109014,
			index = 1
		},
		{
			desc = 109058,
			index = 5
		}
	}
}
