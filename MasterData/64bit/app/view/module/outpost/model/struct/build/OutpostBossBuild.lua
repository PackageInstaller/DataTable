local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostBossBuild = class("OutpostBossBuild", (require("app.view.module.outpost.model.struct.build.OutpostBuildBaseStruct")))

function OutpostBossBuild:ctor(arg_1_1, arg_1_2)
	self._bossLevelToId = {}
	self._bossCnt = 0
	self._bossLevelToDrops = {}

	OutpostBossBuild.super.ctor(self, arg_1_1, arg_1_2)

	self._maxKnightCnt = 0
end

function OutpostBossBuild:_initBuild()
	self._tab = g.core.config.outpost_boss_building_info

	OutpostBossBuild.super._initBuild(self)

	for iter_2_0 = 1, g.core.config.outpost_drop_info.getLength() do
		local var_2_0 = g.core.config.outpost_drop_info.indexOf(iter_2_0)

		if var_2_0.building_type == var_0_0.BuildType.Boss then
			self._bossLevelToDrops[var_2_0.level] = var_2_0
		end
	end
end

function OutpostBossBuild:_onOneCfgGot(arg_3_1)
	self._bossLevelToId[arg_3_1.level] = arg_3_1.boss_id
	self._bossCnt = self._bossCnt + 1
end

function OutpostBossBuild:canChangePos()
	return true
end

function OutpostBossBuild:getBuildInfo()
	return
end

function OutpostBossBuild:getAllBossInfo()
	local var_6_0 = {}
	local var_6_1 = g.core.model.User.outpostData:getAllArenaInfo()

	for iter_6_0 = 1, self._bossCnt do
		local var_6_2 = self._bossLevelToId[iter_6_0]
		local var_6_3 = g.core.config.outpost_monster_info.get(self._bossLevelToId[iter_6_0])
		local var_6_4 = {
			bossCfg = var_6_3,
			isLock = iter_6_0 > self._level,
			level = iter_6_0,
			firstDrops = g.core.common.Drops:getGoodsArray(var_6_3.first_reward),
			dropCfg = self:getBossDropsCfgByLevel(iter_6_0),
			scale = self._tab.get(self._levelToIdDic[iter_6_0]).scale
		}

		if not var_6_4.isLock then
			var_6_4.canSweep = self:_getConditionProcess(var_0_0.BuildUnlockType.KILL_BOSS, var_6_2) > 0
		end

		if not var_6_1[var_6_3.map].isOpen then
			var_6_4.mapTips = g.core.lang:get(432673, {
				name = g.core.config.outpost_map_info.get(var_6_3.map).name
			})
		end

		var_6_0[#var_6_0 + 1] = var_6_4
	end

	return var_6_0
end

function OutpostBossBuild:getBossDropsCfgByLevel(arg_7_1)
	return self._bossLevelToDrops[arg_7_1]
end

function OutpostBossBuild:onEffect(arg_8_1)
	if arg_8_1.opType == var_0_0.BOSS_OP_TYPE.CALL_BOSS then
		self:_doCallBoss(arg_8_1)
	elseif arg_8_1.opType == var_0_0.BOSS_OP_TYPE.SWEEP_BOSS then
		self:_doSweepBoss(arg_8_1)
	elseif arg_8_1.opType == var_0_0.BOSS_OP_TYPE.CANCEL_BOSS then
		self:_doCancelBoss(arg_8_1)
	end
end

function OutpostBossBuild:_doCallBoss(arg_9_1)
	local var_9_1 = self._cfg.boss_id

	var_9_1 = arg_9_1 and arg_9_1.bossId or var_9_1

	if g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.outpostConst.BOSS_SUMMON_PLAY_NUM_ID) < 1 and self:_getConditionProcess(var_0_0.BuildUnlockType.KILL_BOSS, var_9_1) > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432670))

		return
	end

	local var_9_2 = arg_9_1.bossId or self._cfg.boss_id

	g.core.network.GameNetProxy:send_C2S_Outpost_Build_CallBoss({
		boss_id = var_9_2
	})
end

function OutpostBossBuild:_doSweepBoss(arg_10_1)
	local var_10_0 = g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.outpostConst.BOSS_SUMMON_PLAY_NUM_ID)

	if var_10_0 < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432670))

		return
	end

	local var_10_1 = arg_10_1.times and math.min(arg_10_1.times, var_10_0) or var_10_0
	local var_10_2 = arg_10_1.bossId or self._cfg.boss_id

	g.core.network.GameNetProxy:send_C2S_Outpost_Boss_Sweep({
		boss_id = var_10_2,
		num = var_10_1
	})
end

function OutpostBossBuild:_doCancelBoss(arg_11_1)
	g.core.network.GameNetProxy:send_C2S_Outpost_DelBoss({})
end

return OutpostBossBuild
