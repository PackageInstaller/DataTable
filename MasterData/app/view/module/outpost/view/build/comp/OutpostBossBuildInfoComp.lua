local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostBossBuildInfoComp = class("OutpostBossBuildInfoComp", require("app.fairyGUI.outpost.UI_OutpostBossBuildInfoComp"))

function OutpostBossBuildInfoComp:ctor()
	self._bossInfoList = {}
	self._timer = nil
	self._bossTime = nil
	self._curDrops = nil

	self:_initInfoComp()
end

function OutpostBossBuildInfoComp:setBossCurIdx(arg_2_1)
	self._curIdx = arg_2_1
end

function OutpostBossBuildInfoComp:_initInfoComp()
	self.m_unlockStr:enableRich()
	self.m_sweepBtn:addClickListener(handler(self, self._onSweepBtnClicked))
	self.m_callBtn:addClickListener(handler(self, self._onCallBtnClicked))
	self.m_cancelBtn:addClickListener(handler(self, self._onCancelBtnClicked))
	self.m_leftBtn:addClickListener(handler(self, self._onLeftBtnClicked))
	self.m_rightBtn:addClickListener(handler(self, self._onRightBtnClicked))
	self.m_rewardList:setVirtual(self)
	self.m_rewardList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function OutpostBossBuildInfoComp:onLoad()
	if self._bossTime and self._bossTime > g.core.common.ServerTime:getTime() then
		self:_startBossTimer()
	else
		self:_cancelBossTimer()
	end
end

function OutpostBossBuildInfoComp:onUnload()
	self._timer = nil
end

function OutpostBossBuildInfoComp:updateBossComp(arg_6_1)
	self._bossInfoList = arg_6_1

	self:_updateBossDetail()
end

function OutpostBossBuildInfoComp:_updateBossDetail()
	local var_7_0 = self._bossInfoList[self._curIdx]
	local var_7_1 = self._bossInfoList[self._curIdx].bossCfg

	self.m_nameTxt:setText(self._bossInfoList[self._curIdx].bossCfg.name)
	self:_cancelBossTimer()

	if var_7_0.isLock then
		self.m_unlockStr:setText(g.core.lang:get(432625, {
			level = var_7_0.level
		}))
		self.m_stateController:setSelectedIndex(1)
	else
		self:_checkBossTime(var_7_1.id)
		self.m_stateController:setSelectedIndex(0)

		local var_7_2 = g.core.model.User.outpostData:getStatusByIdAndKey(var_0_0.BuildUnlockType.KILL_BOSS, var_7_1.id)

		if var_7_2 and var_7_2.status > 0 then
			self.m_isFirstBattleController:setSelectedIndex(0)
		else
			self.m_isFirstBattleController:setSelectedIndex(1)
		end
	end

	self._curDrops = {}

	if var_7_0.canSweep then
		self.m_isShowSweepController:setSelectedIndex(1)
	else
		for iter_7_0, iter_7_1 in ipairs(var_7_0.firstDrops) do
			iter_7_1.tagStr = g.core.lang:get(432675)
			self._curDrops[iter_7_0] = iter_7_1
		end

		self.m_isShowSweepController:setSelectedIndex(0)
	end

	self:_updateBossSpine(var_7_1.knight_id, var_7_0.isLock)
	self.m_bossHolder:setScale(var_7_0.scale / 100, var_7_0.scale / 100)
	self:_getCurDrops(var_7_0.dropCfg)

	self._curDrops[#self._curDrops + 1] = {
		type = var_7_1.reward_type,
		value = var_7_1.reward_value,
		size = var_7_1.reward_size,
		pro = var_7_1.reward_pro
	}

	self.m_rewardList:setNumItems(#self._curDrops)
	self.m_timeDescTxt:setText(g.core.lang:get(432626, {
		cur = g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.outpostConst.BOSS_SUMMON_PLAY_NUM_ID),
		max = g.core.model.User.shopData:getInitTimes(g.core.const.ConstMgr.outpostConst.BOSS_SUMMON_PLAY_NUM_ID)
	}))
	self:_updateSwitchBtnVisible()
end

function OutpostBossBuildInfoComp:_checkBossTime(arg_8_1)
	self:_cancelBossTimer()

	local var_8_0 = g.core.model.User.outpostData:getBossById(arg_8_1)
	local var_8_1

	if not var_8_0 then
		do return end

		var_8_1 = g.core.config.outpost_parameter_info.get(var_0_0.WorldParam.BossAttackTime).parameter
	end

	local var_8_2 = var_8_0.alive_time + 0 + var_8_1

	if var_8_0.alive_time + 0 + var_8_1 <= g.core.common.ServerTime:getTime() then
		return
	end

	self._bossTime = var_8_2

	self.m_timeTxt:setText(g.core.lang:get(432666, {
		time = g.core.common.ServerTime:getLeftDHMSFormat(var_8_2)
	}))
	self:_startBossTimer()
end

function OutpostBossBuildInfoComp:_startBossTimer()
	self.m_isShowTimeController:setSelectedIndex(1)

	self._timer = self:newSchedule(handler(self, self._updateBossTime), 1)
end

function OutpostBossBuildInfoComp:_updateBossTime()
	if self._bossTime - g.core.common.ServerTime:getTime() <= 0 then
		self:_cancelBossTimer()
	else
		self.m_timeTxt:setText(g.core.lang:get(432666, {
			time = g.core.common.ServerTime:getLeftDHMSFormat(self._bossTime)
		}))
	end
end

function OutpostBossBuildInfoComp:_cancelBossTimer()
	self.m_isShowTimeController:setSelectedIndex(0)

	if self._timer then
		self:cancelSchedule(self._timer)
	end

	self._timer = nil
end

function OutpostBossBuildInfoComp:_getCurDrops(arg_12_1, arg_12_2, arg_12_3)
	arg_12_2 = arg_12_2 or self._curDrops

	local var_12_0 = 1
	local var_12_1 = {
		"reward_type_"
	}

	var_12_1[2] = 1

	local var_12_2 = table.concat(var_12_1)
	local var_12_3 = table.concat({
		"reward_value_",
		var_12_0
	})
	local var_12_4 = table.concat({
		"reward_size_",
		var_12_0
	})
	local var_12_5 = table.concat({
		"reward_pro_",
		var_12_0
	})

	while g.core.config.outpost_drop_info.hasKey(var_12_2) do
		if arg_12_1[var_12_2] ~= 0 then
			arg_12_2[#arg_12_2 + 1] = {
				type = arg_12_1[var_12_2],
				value = arg_12_1[var_12_3],
				size = arg_12_1[var_12_4],
				pro = arg_12_1[var_12_5],
				tagStr = arg_12_3
			}
		end

		var_12_0 = var_12_0 + 1
		var_12_2 = table.concat({
			"reward_type_",
			var_12_0
		})
		var_12_3 = table.concat({
			"reward_value_",
			var_12_0
		})
		var_12_4 = table.concat({
			"reward_size_",
			var_12_0
		})
		var_12_5 = table.concat({
			"reward_pro_",
			var_12_0
		})
	end
end

function OutpostBossBuildInfoComp:_updateBossSpine(arg_13_1, arg_13_2)
	self.m_bossHolder:removeChildren()

	local var_13_0 = require("app.view.common.CommonKnight").new({
		resId = g.core.config.knight_info.get(arg_13_1).res_id
	})

	var_13_0:setPosition((cc.p(0, var_13_0:getSize().height / 2)))
	self.m_bossHolder:addChild(var_13_0)

	local var_13_1 = var_13_0:getKnightSpine()

	if arg_13_2 then
		var_13_1:setColor(cc.BLACK)
	else
		var_13_1:setColor(cc.WHITE)
	end
end

function OutpostBossBuildInfoComp:_updateSwitchBtnVisible()
	self.m_leftBtn:setVisible(self._curIdx ~= 1)
	self.m_rightBtn:setVisible(self._curIdx ~= #self._bossInfoList)
end

function OutpostBossBuildInfoComp:_onAwardItemRender(arg_15_1, arg_15_2)
	arg_15_2:updateBossRewardIcon(self._curDrops[arg_15_1 + 1])
end

function OutpostBossBuildInfoComp:_onLeftBtnClicked()
	self._curIdx = math.max(1, self._curIdx - 1)

	self:_updateBossDetail()
end

function OutpostBossBuildInfoComp:_onRightBtnClicked()
	self._curIdx = math.min(#self._bossInfoList, self._curIdx + 1)

	self:_updateBossDetail()
end

function OutpostBossBuildInfoComp:_onSweepBtnClicked()
	if not self._bossInfoList[self._curIdx].canSweep then
		g.core.module.ModuleManager:tip(g.core.lang:get(432655))

		return
	end

	self:dispatchCompEvent("sweepBoss", {
		times = 1,
		bossId = self._bossInfoList[self._curIdx].bossCfg.id,
		bossCfg = self._bossInfoList[self._curIdx].bossCfg,
		opType = var_0_0.BOSS_OP_TYPE.SWEEP_BOSS
	})
end

function OutpostBossBuildInfoComp:_onCallBtnClicked()
	if g.core.model.User.outpostData:hasBoss() then
		g.core.module.ModuleManager:tip(g.core.lang:get(432668))

		return
	end

	local var_19_0 = self._bossInfoList[self._curIdx]

	if self._bossInfoList[self._curIdx].mapTips then
		g.core.module.ModuleManager:tip(var_19_0.mapTips)

		return
	end

	self:dispatchCompEvent("callBoss", {
		bossId = var_19_0.bossCfg.id,
		bossCfg = var_19_0.bossCfg,
		opType = var_0_0.BOSS_OP_TYPE.CALL_BOSS
	})
end

function OutpostBossBuildInfoComp:_onCancelBtnClicked()
	self:dispatchCompEvent("cancelBoss", {
		bossId = self._bossInfoList[self._curIdx].bossCfg.id,
		bossCfg = self._bossInfoList[self._curIdx].bossCfg,
		opType = var_0_0.BOSS_OP_TYPE.CANCEL_BOSS
	})
end

return OutpostBossBuildInfoComp
