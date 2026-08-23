local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveData()
local var_0_2 = g.core.config.massive_monster_team_info
local GveCoordEnemyComp = class("GveCoordEnemyComp", require("app.fairyGUI.gve.UI_GveCoordEnemyComp"))

function GveCoordEnemyComp:ctor()
	var_0_1 = var_0_0:getGveData()

	self.m_enemyNumList:setVirtual()
	self.m_enemyNumList:setItemRenderer(handler(self, self._onMonsterBtnRenderer))
	self.m_enemyList:setVirtual()
	self.m_enemyList:setItemRenderer(handler(self, self._onEnemyListRenderer))
	self.m_fightBtn:addClickListener(handler(self, self._onFightClick))
	self.m_enemyPageController:addEventListener(fgui.UIEventType.Changed, handler(self, self.updateMonster))

	self._curMonsterData = {}
	self._gridX = 0
	self._gridY = 0

	self.m_fightState_2:setVisible(false)
end

function GveCoordEnemyComp:setState(arg_2_1, arg_2_2)
	if arg_2_1 == 3 then
		self.m_lockTxt:setText(g.core.lang:get(309206, {
			level = arg_2_2
		}))
	end

	self.m_stateController:setSelectedIndex(arg_2_1)
end

function GveCoordEnemyComp:setFightState(arg_3_1)
	self.m_fightStateController:setSelectedIndex(arg_3_1)
end

function GveCoordEnemyComp:_onMonsterBtnRenderer(arg_4_1, arg_4_2)
	arg_4_2:setTitle(g.core.lang:get(309109, {
		num = arg_4_1 + 1
	}))
end

function GveCoordEnemyComp:_onEnemyListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateByMonsterData(self._curMonsterData[arg_5_1 + 1])
end

function GveCoordEnemyComp:_onFightClick()
	local var_6_0 = var_0_1:getCurGridBaseData(self._gridX, self._gridY)

	if self:checkLockState(var_6_0.lock_ts, var_6_0.own_user_id) and var_6_0.lock_ts > g.core.common.ServerTime:getTime() then
		return g.core.module.ModuleManager:tip(g.core.lang:get(309132))
	end

	if not var_0_1:getTargetPath({
		x = self._gridX,
		y = self._gridY
	}) then
		g.core.module.ModuleManager:tip(g.core.lang:get(309140))
	else
		local var_6_1 = self.m_enemyPageController:getSelectedIndex()

		self:dispatchCompEvent("Gve_close_parent_pop")
		g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_FORMATION_LAYER, false, {
			x = self._gridX,
			y = self._gridY,
			path = {},
			wave = var_6_1 + 1,
			monsterId = self._monster[var_6_1 + 1],
			baseId = self._baseId
		})
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Menu_Slide)
end

function GveCoordEnemyComp:setOpeType(arg_7_1)
	self._opeType = arg_7_1
end

function GveCoordEnemyComp:updateInfoData(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self._monster = arg_8_1
	self._baseId = arg_8_2.id
	self._baseCfg = arg_8_2
	self._gridX = arg_8_3
	self._gridY = arg_8_4

	self.m_enemyNumList:setNumItems(#arg_8_1)

	for iter_8_0 = 0, #arg_8_1 - 1 do
		self.m_enemyPageController:addPage(iter_8_0, tostring(iter_8_0))
	end

	local var_8_0 = var_0_1:getCurGridBaseData(arg_8_3, arg_8_4)

	self.m_skillComp:updateByPoc({
		x = arg_8_3,
		y = arg_8_4
	})
	self.m_enemyPageController:setSelectedIndex((var_8_0 and var_8_0.wave or nil) and (#arg_8_1 >= var_8_0.wave and var_8_0.wave or #arg_8_1))
	self:updateMonster()

	if var_8_0.recover_ts and g.core.common.ServerTime:getLeftSeconds(var_8_0.recover_ts) > 0 then
		local var_8_2, var_8_3, var_8_4, var_8_5 = g.core.common.ServerTime:getLeftTimeParts(var_8_0.recover_ts)

		self.m_recoverTxt:setText(g.core.lang:get(309131, {
			min = var_8_4,
			sec = var_8_5
		}))
		self:checkUpdateScheduler()
	else
		self.m_recoverTxt:setText("")
	end
end

function GveCoordEnemyComp:reqNewDetail()
	g.core.network.GameNetProxy:send_C2S_GVE_WorldCellDetail({
		x = self._gridX,
		y = self._gridY
	})
end

function GveCoordEnemyComp:checkUpdateScheduler()
	if self._updSchedule then
		self:cancelSchedule(self._keepAliveSchedule)

		self._updSchedule = nil
	end

	self._updSchedule = self:newSchedule(handler(self, self.fsmScheduleUpdate), 1)
end

function GveCoordEnemyComp:stopUpdateScheduler()
	if self._updSchedule then
		self:cancelSchedule(self._keepAliveSchedule)

		self._updSchedule = nil
	end
end

function GveCoordEnemyComp:fsmScheduleUpdate()
	local var_12_0 = var_0_1:getCurGridBaseData(self._gridX, self._gridY)

	if var_12_0.recover_ts then
		if g.core.common.ServerTime:getLeftSeconds(var_12_0.recover_ts) <= 0 then
			self:reqNewDetail()

			return self:stopUpdateScheduler()
		end

		local var_12_1, var_12_2, var_12_3, var_12_4 = g.core.common.ServerTime:getLeftTimeParts(var_12_0.recover_ts)

		self.m_recoverTxt:setText(g.core.lang:get(309131, {
			min = var_12_3,
			sec = var_12_4
		}))
	else
		self.m_recoverTxt:setText("")
	end
end

function GveCoordEnemyComp:checkLockState(arg_13_1, arg_13_2)
	if not arg_13_1 or not arg_13_2 then
		return false
	end

	if arg_13_2 == g.core.model.User:getId() then
		return false
	end

	if arg_13_1 <= g.core.common.ServerTime:getTime() then
		return true
	end

	return false
end

function GveCoordEnemyComp:updateMonster()
	if not self._monster then
		return
	end

	local var_14_0 = var_0_0:getGveData():getCurGridBaseData(self._gridX, self._gridY)

	if not next(var_14_0) then
		return
	end

	local var_14_1 = var_14_0.wave or 0
	local var_14_2 = var_14_0.hp or {}

	self._curMonsterData = {}

	local var_14_3 = self.m_enemyPageController:getSelectedIndex()
	local var_14_4 = var_0_2.get(self._monster[var_14_3 + 1])
	local var_14_5 = true

	for iter_14_0 = 1, 6 do
		local var_14_6 = 100

		if var_14_3 == var_14_1 then
			var_14_6 = var_14_2[iter_14_0] and var_14_2[iter_14_0] / 10 or 100
		elseif var_14_3 < var_14_1 then
			var_14_6 = 0
		end

		if var_14_6 > 0 then
			var_14_5 = false
		end

		if var_14_4["knight_id_" .. iter_14_0] ~= 0 then
			local var_14_7 = g.core.config.knight_info.fetch(var_14_4["knight_id_" .. iter_14_0])
			local var_14_8 = {
				knightId = var_14_4["knight_id_" .. iter_14_0],
				hpPer = var_14_6,
				equipLv = var_14_4.equip_level,
				isDead = var_14_6 == 0
			}

			if var_14_7 then
				var_14_8.star = var_14_7.star or 0
			end

			table.insert(self._curMonsterData, var_14_8)
		end
	end

	self.m_fightValueTxt:setText(var_14_4.fight)
	self.m_enemyList:setNumItems(#self._curMonsterData)

	local var_14_9 = var_0_0:getGveBagData():getCoreHalidomLevel()

	self.m_fightState_2:setVisible(true)

	if var_14_9 > var_14_4.equip_level then
		self.m_fightStateController:setSelectedIndex(0)
	elseif var_14_9 == var_14_4.equip_level then
		self.m_fightStateController:setSelectedIndex(1)
	else
		self.m_fightStateController:setSelectedIndex(2)
	end

	local var_14_10, var_14_11 = var_0_0:getCondIsUnlock(self._baseCfg)

	if not var_14_10 then
		self:setState(3, var_14_11)

		return
	end

	if self._opeType == "detail" then
		self.m_stateController:setSelectedIndex(2)

		return
	end

	if var_14_1 < var_14_3 then
		self.m_stateController:setSelectedIndex(1)
	elseif var_14_5 then
		self.m_stateController:setSelectedIndex(2)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function GveCoordEnemyComp:onUnload()
	if self._updSchedule then
		self:cancelSchedule(self._keepAliveSchedule)

		self._updSchedule = nil
	end
end

return GveCoordEnemyComp
