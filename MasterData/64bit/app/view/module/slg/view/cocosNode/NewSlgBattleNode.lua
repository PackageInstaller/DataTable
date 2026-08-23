local NewSlgBattleNode = class("NewSlgBattleNode", function()
	return cc.Node:create()
end)
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = g.core.const.ConstMgr.NewSlgConst.REPORT
local NewSlgIconNode = require("app.view.module.slg.view.cocosNode.NewSlgIconNode")

function NewSlgBattleNode:ctor()
	self._parameterInfo = g.core.model.User.newSlgData:getNewSlgParamsCfg()
	self._roles = {}
	self._atkRole = nil
	self._defRole = nil
	self._battleData = nil
	self._isInBattleStage2 = false
	self._screenHideCall = nil
end

function NewSlgBattleNode:_initRecycle()
	return
end

function NewSlgBattleNode:updateGIDData(arg_4_1)
	self:setPosition(cc.p(arg_4_1.x, arg_4_1.y))

	self._battleData = arg_4_1.battleData
	self._gid = arg_4_1.id
	self._tid = arg_4_1.target_id
	self._pos = arg_4_1.pos

	self:_prepareBattle()
end

function NewSlgBattleNode:_prepareBattle()
	local var_5_0 = g.core.common.ServerTime:getTime()

	self._battleData:splitOutTimeRound()

	if self._battleData:isBattleFinish() then
		self:_battleFinish()

		return
	end

	local var_5_1 = var_5_0 > self._battleData.battleStartTime and 0 or self._battleData.battleStartTime - var_5_0
	local var_5_2 = var_5_0 > self._battleData.battleStartTime and 0 or self._battleData.battleStartTime - var_5_0
	local var_5_3 = g.core.model.User:getId()
	local var_5_4 = {}
	local var_5_5 = false

	if self._battleData.report.report_type == var_0_1.BATTLE_TYPE.CITY then
		local var_5_6 = clone(self._battleData.atkTeams)

		table.sort(var_5_6, function(arg_6_0, arg_6_1)
			return arg_6_0.max_troops > arg_6_1.max_troops
		end)

		if self._tid and g.core.model.User.newSlgData:isCityOccupied(self._tid) then
			var_5_5 = true
		end

		for iter_5_0 = 1, math.min(math.max(self._parameterInfo.name_num, (math.ceil(self._parameterInfo.name_pro / 10000 * #var_5_6))), #var_5_6) do
			var_5_4[var_5_6[iter_5_0].team_id] = true
		end
	end

	for iter_5_1, iter_5_2 in ipairs(self._battleData.atkTeams) do
		local var_5_7 = NewSlgIconNode:create()

		self:addChild(var_5_7)

		local var_5_8 = {}
		local var_5_9 = {
			name = iter_5_2.user.name,
			troop_type = iter_5_2.troop_type
		}

		var_5_9.character = iter_5_2.characters and #iter_5_2.characters > 0 and iter_5_2.characters[1]
		var_5_9.forceShowName = var_5_4[iter_5_2.team_id]
		var_5_8.deltaInfo = var_5_9
		var_5_8.battleTeam = iter_5_2
		var_5_8.authority = iter_5_2.authority

		local var_5_10

		if not var_5_5 then
			if iter_5_2.user.uid == var_5_3 then
				var_5_10 = var_0_1.BATTLE_PLAYER_TYPE.SELF or var_0_1.BATTLE_PLAYER_TYPE.FRIEND or var_0_1.BATTLE_PLAYER_TYPE.ENEMY
			end
		end

		var_5_8.roleType = var_5_10

		var_5_7:setData(var_5_8)
		var_5_7:setHp(self._battleData:getRoleMaxHp(iter_5_2.team_id), self._battleData:getRoleHp(iter_5_2.team_id))
		table.insert(self._roles, var_5_7)
	end

	local var_5_11 = table.shuffle((self:_getRoleRandomPos(#self._roles, false, self._battleData.report.report_type)))

	for iter_5_3, iter_5_4 in ipairs(self._roles) do
		self:_setRolePos(var_5_2, var_5_11, iter_5_4)
	end

	local var_5_12 = self._battleData.watchTeams

	if self._battleData.watchTeams and #var_5_12 > 0 then
		local var_5_13 = #self._roles + 1
		local var_5_14 = g.core.model.User.newSlgData:getComponentsByGID(self._gid)[1]
		local var_5_15

		if var_5_14 then
			var_5_15 = var_5_14.value or 0
		end

		local var_5_16 = var_5_15 > 0 and g.core.model.User.newSlgData:isLastCity(var_5_15) or false

		for iter_5_5, iter_5_6 in ipairs(var_5_12) do
			local var_5_17 = self._battleData:getWatchTeamRemoveTime(iter_5_6.team_id)

			if var_5_17 and var_5_0 < var_5_17 then
				local var_5_18 = NewSlgIconNode:create()

				self:addChild(var_5_18)

				local var_5_19 = {}
				local var_5_20 = {
					name = iter_5_6.user.name,
					troop_type = iter_5_6.troop_type
				}

				var_5_20.character = iter_5_6.characters and #iter_5_6.characters > 0 and iter_5_6.characters[1]
				var_5_19.deltaInfo = var_5_20
				var_5_19.battleTeam = iter_5_6
				var_5_19.authority = iter_5_6.authority

				if var_5_16 then
					var_5_19.roleType = var_0_1.BATTLE_PLAYER_TYPE.ENEMY or var_0_1.BATTLE_PLAYER_TYPE.NEUTRAL
				end

				var_5_18:setData(var_5_19)
				var_5_18:setHp(iter_5_6.max_troops, iter_5_6.max_troops)
				table.insert(self._roles, var_5_18)

				if var_5_17 then
					var_5_18:runAction(cc.Sequence:create(cc.DelayTime:create(var_5_17 - g.core.common.ServerTime:getTime()), (cc.CallFunc:create(handler(self, function(arg_7_0)
						var_5_18:stopAllActions()
						arg_7_0:_playRoleRemove(var_5_18)
					end)))))
				end
			end
		end

		local var_5_22 = table.shuffle((self:_getRoleRandomPos(#var_5_12, true, self._battleData.report.report_type)))

		for iter_5_7 = var_5_13, #self._roles do
			self:_setRolePos(var_5_2, var_5_22, self._roles[iter_5_7])
		end
	end

	if self._battleData.report.report_type == var_0_1.BATTLE_TYPE.MONSTER then
		if self._battleData.atkTeams and #self._battleData.atkTeams > 0 then
			-- block empty
		end
	end

	if var_5_2 > 0 and self._battleData:isFirstRound() then
		self._defRole = self:_createDefRole(self._battleData.battleTeamRoundDatas[1].defTeamId)

		self._defRole:setHp(self._battleData.battleTeamRoundDatas[1].defMaxHp, self._battleData.battleTeamRoundDatas[1].roundDataArr[1].defHp)
		self._defRole:setPosition(cc.p(0, 0))
		self._defRole:runAction(cc.MoveTo:create(var_5_2, cc.p(self._defRole:getBattlePositionX(var_0_1.BATTLE_ROLE_POSX_DELTA), 0)))
	end

	if var_5_1 > 0 then
		self:runAction(cc.Sequence:create(cc.DelayTime:create(var_5_1), (cc.CallFunc:create(handler(self, function(arg_8_0)
			arg_8_0:_resetRolesAction()
			arg_8_0:_prepareBattleRole()
		end)))))
	elseif self._battleData:isBattleStage2() then
		self:_playAllTeamBattle()
	else
		self:_resetRolesAction()
		self:_prepareBattleRole()
	end
end

function NewSlgBattleNode:_clearRoleAction()
	for iter_9_0, iter_9_1 in ipairs(self._roles) do
		iter_9_1:stopAllActions()
	end
end

function NewSlgBattleNode:_resetRolesAction()
	for iter_10_0, iter_10_1 in ipairs(self._roles) do
		self:_playRoleIdleAction(iter_10_1)
	end
end

function NewSlgBattleNode:_playRoleIdleAction(arg_11_1)
	local var_11_0 = cc.p(arg_11_1:getPositionX(), arg_11_1:getPositionY())
	local var_11_1 = math.random(0.8, 1.2)

	arg_11_1:runAction(cc.RepeatForever:create(cc.Spawn:create(cc.DelayTime:create(var_11_1), (cc.CallFunc:create(function()
		arg_11_1:runAction((cc.MoveTo:create(var_11_1, cc.p(math.random(var_11_0.x - 15, var_11_0.x + 15), (math.random(var_11_0.y - 15, var_11_0.y + 15))))))
	end)))))
end

function NewSlgBattleNode:_playRoleRemove(arg_13_1)
	local var_13_0 = self:_getPosWithAngleAndRadius(0, 2 * math.pi, 900, 1500)

	arg_13_1:runAction((cc.FadeOut:create(3)))
	arg_13_1:runAction((cc.Sequence:create(cc.MoveTo:create(3.5, cc.p(var_13_0.x, var_13_0.y)), (cc.CallFunc:create(handler(self, function(arg_14_0)
		arg_13_1:stopAllActions()

		for iter_14_0, iter_14_1 in ipairs(arg_14_0._roles) do
			if iter_14_1 == arg_13_1 then
				table.remove(arg_14_0._roles, iter_14_0)
				arg_13_1:removeFromParent()

				break
			end
		end
	end))))))
end

function NewSlgBattleNode:_prepareBattleRole()
	local var_15_0 = g.core.common.ServerTime:getTime()
	local var_15_1 = self._battleData.battleTeamRoundDatas[1]

	if self._battleData.battleTeamRoundDatas[1] == nil then
		print("错误的战斗数据")

		return
	end

	local var_15_2 = var_15_1.changeRoleStartTime

	if (var_15_1.changeRoleStartTime <= var_15_0 and 0 or var_15_2 - var_15_0) > 0 then
		self:runAction(cc.Sequence:create(cc.DelayTime:create(var_15_1.changeRoleStartTime <= var_15_0 and 0 or var_15_2 - var_15_0), (cc.CallFunc:create(handler(self, function(arg_16_0)
			arg_16_0:_prepareBattleRole()
		end)))))

		return
	end

	local var_15_3 = var_15_1.roundDataArr[1]
	local var_15_4 = math.min(var_15_0 >= var_15_1.roundDataArr[1].roundStartTime and 0 or var_15_3.roundStartTime - var_15_0, 1)
	local var_15_5 = self:_findAtkRole(var_15_1.atkTeamId)
	local var_15_6
	local var_15_7

	if self._atkRole ~= var_15_5 then
		if self._atkRole then
			var_15_6 = self._atkRole
			var_15_7 = cc.p(var_15_5:getPositionX(), var_15_5:getPositionY())
		end

		self._atkRole = var_15_5
	end

	local var_15_8 = false

	if self._defRole then
		if self._defRole.battleTeam.team_id ~= var_15_1.defTeamId then
			self._defRole:stopAllActions()
			self._defRole:removeFromParent()

			self._defRole = self:_createDefRole(var_15_1.defTeamId)
			var_15_8 = true
		end
	else
		self._defRole = self:_createDefRole(var_15_1.defTeamId)
		var_15_8 = true
	end

	if var_15_6 then
		var_15_6:stopAllActions()
	end

	self._atkRole:setLocalZOrder(9999)
	self._atkRole:setLocalZOrder(9998)
	self._atkRole:stopAllActions()
	self._atkRole:setHp(var_15_1.atkMaxHp, var_15_3.atkHp)
	self._defRole:setHp(var_15_1.defMaxHp, var_15_3.defHp)

	if var_15_4 > 0 then
		local var_15_9 = math.min(var_15_4, self._parameterInfo.battle_change_time / 1000 * 0.8)

		self._atkRole:runAction((cc.MoveTo:create(var_15_9, cc.p(self._atkRole:getBattlePositionX(-var_0_1.BATTLE_ROLE_POSX_DELTA), 0))))

		if var_15_6 then
			var_15_6:runAction(cc.Sequence:create(cc.MoveTo:create(var_15_9, var_15_7), (cc.CallFunc:create(handler(self, function(arg_17_0)
				arg_17_0:_playRoleIdleAction(var_15_6)
			end)))))
		end

		if var_15_8 then
			self._defRole:setPosition(cc.p(0, 0))
			self._defRole:runAction(cc.MoveTo:create(var_15_9, cc.p(self._defRole:getBattlePositionX(var_0_1.BATTLE_ROLE_POSX_DELTA), 0)))
		end
	else
		self._atkRole:setBattlePosition(-var_0_1.BATTLE_ROLE_POSX_DELTA)

		if var_15_6 then
			var_15_6:setPosition(var_15_7)
			self:_playRoleIdleAction(var_15_6)
		end
	end

	if var_15_6 then
		self:_safeCachePos(var_15_6.battleTeam.team_id, cc.p(var_15_7.x, var_15_7.y))
	end

	if var_15_4 > 0 then
		self:runAction(cc.Sequence:create(cc.DelayTime:create(var_15_4), (cc.CallFunc:create(handler(self, function(arg_18_0)
			arg_18_0:_playBattle()
		end)))))
	else
		self:_playBattle()
	end
end

function NewSlgBattleNode:_playBattle()
	if self._battleData == nil then
		return
	end

	local var_19_0 = g.core.common.ServerTime:getTime()
	local var_19_1 = self._battleData.battleTeamRoundDatas[1]
	local var_19_2 = table.shift(self._battleData.battleTeamRoundDatas[1].roundDataArr)

	if var_19_2 then
		self._battleData:updateRoleHp(var_19_2, self._battleData.battleTeamRoundDatas[1].atkTeamId)
	end

	local var_19_3 = math.max(var_19_2.roundStartTime - var_19_0, 0)

	self._atkRole:setBattlePosition(-var_0_1.BATTLE_ROLE_POSX_DELTA)
	self._defRole:setBattlePosition(var_0_1.BATTLE_ROLE_POSX_DELTA)
	self._atkRole:runAction(cc.Sequence:create(cc.DelayTime:create(var_19_3), cc.CallFunc:create(handler(self, function(arg_20_0)
		arg_20_0._atkRole:setLocalZOrder(9999)
		arg_20_0._defRole:setLocalZOrder(9998)

		local var_20_0 = #var_19_1.roundDataArr == 0
		local var_20_1 = {}
		local var_20_2

		if #var_19_1.roundDataArr == 0 then
			::label_20_0::

			var_20_2 = var_19_1.isWin and var_19_1.continueKill
		end

		var_20_1.continueKill = var_20_2
		var_20_1.showDeath = var_20_0 and not var_19_1.isWin

		arg_20_0._atkRole:attack(var_20_1, var_19_1.atkMaxHp, var_19_2.atkHp - var_19_2.atkDecValue)
		arg_20_0._defRole:attack({
			continueKill = var_20_0 and not var_19_1.isWin and var_19_1.continueKill,
			showDeath = var_20_0 and var_19_1.isWin
		}, var_19_1.defMaxHp, var_19_2.defHp - var_19_2.defDecValue)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_migrate)

		local var_20_3

		var_20_3 = require("app.view.common.SpineBase").new({
			resId = "eff_ui_newSlg_hit",
			isLoop = false,
			anim = "play",
			path = g.core.common.Path:getEffSpine("eff_ui_newSlg_hit"),
			listener = function(self)
				if self.type == "complete" then
					var_20_3:removeFromParent(true)
				end
			end
		})

		;(nil):setPosition(cc.p(0, 0))
		arg_20_0:addChild(var_20_3)
	end)), cc.DelayTime:create(self._parameterInfo.show_parameter_21 / 1000), (cc.CallFunc:create(handler(self, function(arg_22_0)
		if #var_19_1.roundDataArr == 0 then
			arg_22_0._battleData:shiftBattleTeamRoundDatas()

			if #arg_22_0._battleData.battleTeamRoundDatas > 0 then
				arg_22_0:_prepareBattleRole()
			elseif arg_22_0._battleData:hasBattleStage2() then
				arg_22_0._defRole:stopAllActions()
				arg_22_0._defRole:removeFromParent()

				arg_22_0._defRole = nil

				arg_22_0:_playAllTeamBattle()
			else
				local var_22_0 = math.max(g.core.common.ServerTime:getTime() - arg_22_0._battleData.battleEndTime, 0)

				if var_22_0 > 0 then
					arg_22_0._defRole:stopAllActions()
					arg_22_0._defRole:removeFromParent()

					arg_22_0._defRole = nil

					if arg_22_0._battleData:isBattleFinish() then
						arg_22_0:_battleFinish()

						return
					else
						arg_22_0:runAction(cc.Sequence:create(cc.DelayTime:create(var_22_0), cc.CallFunc:create(handler(arg_22_0, function()
							arg_22_0:_battleFinish()
						end))))
					end
				else
					arg_22_0:_battleFinish()
				end
			end
		else
			arg_22_0:_playBattle()
		end
	end)))))
end

function NewSlgBattleNode:_findAtkRole(arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(self._roles) do
		if iter_24_1.battleTeam.team_id == arg_24_1 then
			return iter_24_1
		end
	end
end

function NewSlgBattleNode:_getRoleRandomPos(arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = {}
	local var_25_1 = ({
		[var_0_1.BATTLE_TYPE.MONSTER] = var_0_1.BATTLE_START_MOVE_LEN_MONSTER,
		[var_0_1.BATTLE_TYPE.BOSS] = var_0_1.BATTLE_START_MOVE_LEN_BOSS,
		[var_0_1.BATTLE_TYPE.CITY] = var_0_1.BATTLE_START_MOVE_LEN_CITY,
		[var_0_1.BATTLE_TYPE.FARM] = var_0_1.BATTLE_START_MOVE_LEN_MONSTER
	})[arg_25_3]

	local function var_25_2(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0, var_26_1

		if arg_25_2 then
			var_26_0 = 2 * math.pi * 1 / 4 / arg_26_0 or 2 * math.pi * 3 / 4 / arg_26_0

			if arg_25_2 then
				var_26_1 = 2 * math.pi * 3 / 4 or 0
			end
		end

		for iter_26_0 = 1, arg_26_0 do
			table.insert(var_25_0, (self:_getPosWithAngleAndRadius(var_26_1 + var_26_0 * iter_26_0, var_26_1 + var_26_0 * iter_26_0 + var_26_0, arg_26_1, arg_26_2)))
		end
	end

	local var_25_3 = math.min(45, arg_25_1)
	local var_25_4 = arg_25_1 - var_25_3

	var_25_2(var_25_3, var_25_1[1], var_25_1[2])

	if var_25_4 > 0 then
		local var_25_5 = math.min(60, var_25_4)

		var_25_4 = var_25_4 - var_25_5

		var_25_2(var_25_5, var_25_1[3], var_25_1[4])
	end

	if var_25_4 > 0 then
		var_25_2(var_25_4, var_25_1[5], var_25_1[6])
	end

	return var_25_0
end

function NewSlgBattleNode:_setRolePos(arg_27_1, arg_27_2, arg_27_3)
	if arg_27_1 > 0 then
		if self._battleData:isFirstRound() and arg_27_3.battleTeam.team_id == self._battleData.battleTeamRoundDatas[1].atkTeamId then
			arg_27_3:setPosition(cc.p(0, 0))
			arg_27_3:runAction(cc.MoveTo:create(arg_27_1, cc.p(arg_27_3:getBattlePositionX(-var_0_1.BATTLE_ROLE_POSX_DELTA), 0)))
		else
			local var_27_0 = table.remove(arg_27_2, #arg_27_2)

			arg_27_3:setPosition(cc.p(0, 0))
			arg_27_3:runAction(cc.MoveTo:create(arg_27_1, cc.p(var_27_0.x, var_27_0.y)))
		end
	else
		local var_27_1 = self._battleData:getCacheRolePos(arg_27_3.battleTeam.team_id)

		if var_27_1 then
			arg_27_3:setPosition(cc.p(var_27_1.x, var_27_1.y))
		else
			local var_27_2 = table.remove(arg_27_2, #arg_27_2)

			arg_27_3:setPosition(cc.p(var_27_2.x, var_27_2.y))

			if self._battleData:isBattleStage2() then
				self:_safeCachePos(arg_27_3.battleTeam.team_id, cc.p(arg_27_3:getPositionX(), arg_27_3:getPositionY()))
			end
		end
	end
end

function NewSlgBattleNode:_getPosWithAngleAndRadius(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0 = math.random(arg_28_1, arg_28_2)
	local var_28_1 = math.sqrt(math.random() * (arg_28_4^2 - arg_28_3^2) + arg_28_3^2)

	return cc.p(var_28_1 * math.cos(var_28_0), var_28_1 * math.sin(var_28_0))
end

function NewSlgBattleNode:_getDefTeam(arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(self._battleData.defTeams) do
		if iter_29_1.team_id == arg_29_1 then
			return iter_29_1
		end
	end

	return nil
end

function NewSlgBattleNode:_createDefRole(arg_30_1)
	local var_30_0 = self:_getDefTeam(arg_30_1)
	local var_30_1
	local var_30_2 = not not (self._battleData.report.report_type == var_0_1.BATTLE_TYPE.CITY and self._tid and g.core.model.User.newSlgData:isCityOccupied(self._tid))
	local var_30_3 = g.core.model.User:getId()

	if var_30_0 then
		local var_30_4 = self._battleData:getDefId()
		local var_30_5 = self._battleData:getBattleType()

		if var_30_5 == var_0_2.SVR_TYPE.NEW_SLG_REPORT_TYPE_MONSTER then
			var_30_1 = g.core.config.new_slg_monster_info.get(var_30_4, g.core.model.User.newSlgData:getSlgInfo().monster_group).pic
		elseif var_30_5 == var_0_2.SVR_TYPE.NEW_SLG_REPORT_TYPE_TEAM then
			var_30_1 = g.core.config.new_slg_boss_info.get(var_30_4).avata
		elseif var_30_5 == var_0_2.SVR_TYPE.NEW_SLG_REPORT_TYPE_CITY then
			var_30_1 = 113
		elseif var_30_5 == var_0_2.SVR_TYPE.NEW_SLG_REPORT_TYPE_CITY and not var_30_0.characters then
			var_30_1 = 113
		end

		local var_30_6 = NewSlgIconNode:create()

		var_30_6:setPosition(cc.p(0, 0))
		self:addChild(var_30_6)

		local var_30_7 = {}
		local var_30_8 = {}

		if var_30_0.user then
			var_30_8.name = var_30_0.user.name or ""
		end

		var_30_8.troop_type = var_30_0.troop_type
		var_30_8.character = var_30_0.characters and #var_30_0.characters > 0 and var_30_0.characters[1]
		var_30_8.monster_res_id = var_30_1
		var_30_7.deltaInfo = var_30_8
		var_30_7.battleTeam = var_30_0
		var_30_7.authority = var_30_0.authority

		if var_30_2 then
			var_30_7.roleType = var_0_1.BATTLE_PLAYER_TYPE.SELF or var_0_1.BATTLE_PLAYER_TYPE.ENEMY
		end

		var_30_7.axis = self._battleData.report.def_axis

		var_30_6:setData(var_30_7)

		return var_30_6
	end
end

function NewSlgBattleNode:_battleFinish()
	print("战斗结束")
	self:removeFromParent()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NEW_SLG_BATTLE_END)
end

function NewSlgBattleNode:_playAllTeamBattle()
	if self._battleData:isBattleFinish() then
		self:_battleFinish()

		return
	end

	self._isInBattleStage2 = true

	for iter_32_0, iter_32_1 in ipairs(self._roles) do
		self:_safeCachePos(iter_32_1.battleTeam.team_id, cc.p(iter_32_1:getPositionX(), iter_32_1:getPositionY()))
	end

	if self._atkRole then
		self:_playRoleIdleAction(self._atkRole)
	end

	local var_32_0 = self._parameterInfo.show_parameter_22 / 1000
	local var_32_1 = self._parameterInfo.show_parameter_23
	local var_32_2 = self._parameterInfo.show_parameter_24 / 1000

	self:runAction(cc.Spawn:create(cc.DelayTime:create((math.max(self._battleData.cityBattleStartTime - g.core.common.ServerTime:getTime(), 0))), (cc.CallFunc:create(handler(self, function(arg_33_0)
		for iter_33_0, iter_33_1 in ipairs(arg_33_0._roles) do
			iter_33_1:stopAllActions()
			iter_33_1:runAction((cc.RepeatForever:create((cc.Sequence:create(cc.Repeat:create(cc.Sequence:create(cc.CallFunc:create(function()
				local var_34_0 = cc.pNormalize(cc.p(iter_33_1:getPosition()))

				iter_33_1:attack({
					cityAttack = true,
					cityLen = 2,
					direction = cc.p(-var_34_0.x, -var_34_0.y)
				})
			end), (cc.DelayTime:create(var_32_0))), var_32_1), (cc.DelayTime:create(var_32_2)))))))
		end

		arg_33_0:runAction((cc.RepeatForever:create((cc.Sequence:create(cc.Repeat:create(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(handler(arg_33_0, function(arg_35_0)
			if arg_35_0._battleData:isBattleFinish() then
				arg_35_0:stopAllActions()
				arg_35_0:_battleFinish()

				return
			end
		end)), (cc.DelayTime:create(var_32_0 - 0.2))), var_32_1), (cc.DelayTime:create(var_32_2)))))))
	end)))))
end

function NewSlgBattleNode:_safeCachePos(arg_36_1, arg_36_2)
	if math.abs(arg_36_2.x) + math.abs(arg_36_2.y) <= 30 then
		print("位置异常: id=%d, x=%d, y=%d", arg_36_1, arg_36_2.x, arg_36_2.y)

		return
	end

	self._battleData:cacheRolePos(arg_36_1, arg_36_2)
end

return NewSlgBattleNode
