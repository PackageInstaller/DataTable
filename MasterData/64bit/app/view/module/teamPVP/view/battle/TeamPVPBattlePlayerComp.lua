local CommonKnight = require("app.view.common.CommonKnight")
local var_0_1 = g.core.const.ConstMgr.SpineConst
local var_0_2 = g.core.model.User.teamPvpData
local var_0_3 = g.core.const.ConstMgr.TeamPvpConst
local var_0_4 = g.core.config.skin_info
local var_0_5 = g.core.config.knight_base_info
local var_0_6 = g.core.config.knight_info
local TeamPVPBattlePlayerComp = class("TeamPVPBattlePlayerComp", require("app.fairyGUI.teamPVP.UI_TeamPVPBattlePlayerComp"))

function TeamPVPBattlePlayerComp:ctor()
	self._playerinfo = nil
	self._isEnemy = false
	self._isDead = false
	self._curpos = nil
	self._playerguid = ""
	self._isFight = false
	self._posIndex = 1
	self._isBoy = true
	self._npcType = 0
end

function TeamPVPBattlePlayerComp:playFlag(arg_2_1)
	if arg_2_1 then
		arg_2_1()
	end
end

function TeamPVPBattlePlayerComp:updatePlayer(arg_3_1)
	if arg_3_1 then
		self._playerguid = arg_3_1.playerguid or nil
	end

	if arg_3_1 then
		self._isEnemy = arg_3_1.isEnemy or false
	end

	if arg_3_1 then
		self._curpos = arg_3_1.curpos or nil
	end

	if arg_3_1 then
		self._posIndex = arg_3_1.index or 1
	end

	if arg_3_1 then
		self._playerinfo = arg_3_1.playerinfo or nil
	end

	self._npcType = arg_3_1 and arg_3_1.npcType
	self._mapId = var_0_2:getMapId()
	self._battleLine = var_0_3.MAP_PARMAS[self._mapId].Line
	self._materLine = arg_3_1 and arg_3_1.masterLine

	if self._playerinfo then
		self.m_isDeadController:setSelectedIndex(1)
		self.m_attackTowerController:setSelectedIndex(0)
		self.m_isNpcController:setSelectedIndex(0)

		if self._mapId == var_0_3.MAP_TYPE.FIVE and (self._posIndex - 1) % self._battleLine + 1 == self._materLine and self._npcType ~= var_0_3.NPC_TYPE.MASTER then
			self.m_showBuffController:setSelectedIndex(1)
		end

		self.m_hpBar:setValue(arg_3_1.hp or 100)
		self.m_fightValueTxt:setText(g.core.lang:get(420401, {
			num = self._playerinfo.fight_value
		}))

		local var_3_0

		if self._npcType and self._npcType > 0 then
			var_3_0 = var_0_3.NPC_BASE_ID[self._npcType]

			self.m_isNpcController:setSelectedIndex(1)
			self.m_npcNameTxt:setText(var_0_3.NPC_NAME[self._npcType])
		else
			local var_3_1 = var_0_6.get(self._playerinfo.base_id)

			self._isBoy = var_3_1.advance_id == 210000
			var_3_0 = var_3_1.res_id

			if self._playerinfo.robotName then
				var_3_0 = self._playerinfo.robotSkin

				self.m_nameTxt:setText(self._playerinfo.robotName)
			else
				self.m_nameTxt:setText(self._playerinfo.name)

				if self._playerinfo.skin and self._playerinfo.skin > 0 then
					local var_3_2 = var_0_4.fetch(self._playerinfo.skin)

					if var_3_2 then
						local var_3_3 = var_0_5.fetch(var_3_2.res)

						if var_3_3 then
							var_3_0 = var_3_3.fight_id
						end
					end
				end
			end
		end

		self._knightAni = CommonKnight.new((self._playerinfo and self._playerinfo.base_id ~= 0 or nil) and g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(self._playerinfo))

		self.m_knightComp:addChild(self._knightAni)
		self.m_knightComp:setScale(0.7, 0.7)

		if self._isEnemy then
			self.m_knightComp:setScaleX(-0.7)
		end

		self.m_buffEff:addEffectSpine({
			isLoop = true,
			name = "group_battle_buff"
		})
	end
end

function TeamPVPBattlePlayerComp:getIndex()
	return self._posIndex
end

function TeamPVPBattlePlayerComp:getPlayerguid()
	return self._playerguid
end

function TeamPVPBattlePlayerComp:getIsEnemy()
	return self._isEnemy
end

function TeamPVPBattlePlayerComp:setCurPos(arg_7_1)
	if arg_7_1 then
		self._curpos = arg_7_1
	end
end

function TeamPVPBattlePlayerComp:getCurPos()
	return self._curpos
end

function TeamPVPBattlePlayerComp:getIsLive()
	return (not self._isDead or nil) and self._playerguid and self._playerguid ~= ""
end

function TeamPVPBattlePlayerComp:dodead()
	self._isDead = true

	self:playAction((self._npcType == var_0_3.NPC_TYPE.ASSASSIN or nil) and var_0_1.ACTION.OUT)
	self:newScheduleOnce(handler(self, self._doDeadAct), 0.5)
end

function TeamPVPBattlePlayerComp:_doDeadAct()
	self.m_isDeadController:setSelectedIndex(0)
	self:dispatchCompEvent("TEAMPVP_PLAYER_DEAD", {
		playerGuid = self._playerguid
	})

	local var_11_0 = var_0_2:getMapId()

	if var_11_0 == var_0_3.MAP_TYPE.FIRE then
		self:dispatchCompEvent("UPDATE_SCORE_BOARD", {
			isEnemy = self._isEnemy
		})
	elseif var_11_0 == var_0_3.MAP_TYPE.FIVE and self._npcType == var_0_3.NPC_TYPE.MASTER then
		self:dispatchCompEvent("UPDATE_TEAM_BUFF_EFF", {
			isEnemy = self._isEnemy
		})
	end
end

function TeamPVPBattlePlayerComp:doattack(arg_12_1)
	self._isFight = true

	self:playAction(var_0_1.ACTION.ATTACK, handler(self, function()
		if arg_12_1 then
			arg_12_1()
		end
	end))
end

function TeamPVPBattlePlayerComp:beattack(arg_14_1)
	self._isFight = true

	if self._knightAni then
		self._knightAni:playAction(var_0_1.ACTION.ATTACK)
		self:newScheduleOnce(handler(self, function()
			if arg_14_1 then
				arg_14_1()
			end

			self:playDefeatedSound()
		end), 0.5)
	end
end

function TeamPVPBattlePlayerComp:moveBack(arg_16_1, arg_16_2)
	self:idle()
	self:runFGAction(fgui.FSequence:create({
		fgui.FDelayTime:create(0.2),
		fgui.FCallFunc:create(handler(self, function()
			if arg_16_1 and arg_16_1.atk_guid == self._playerguid then
				if arg_16_1.atk_is_win == 1 then
					self:setHp(arg_16_1.hp_percent)
					self:dispatchCompEvent("SHOW_KILL_BOARD", {
						playerguid = self._playerguid,
						playerinfo = self._playerinfo
					})
				elseif arg_16_1.atk_is_win == 2 or arg_16_1.atk_is_win == 3 then
					self:dodead()
					self:setHp(0)
				end
			elseif arg_16_1.atk_is_win == 1 or arg_16_1.atk_is_win == 3 then
				self:dodead()
				self:setHp(0)
			elseif arg_16_1.atk_is_win == 2 then
				self:setHp(arg_16_1.hp_percent)
				self:dispatchCompEvent("SHOW_KILL_BOARD", {
					playerguid = self._playerguid,
					playerinfo = self._playerinfo
				})
			end
		end))
	}))
end

function TeamPVPBattlePlayerComp:playAction(arg_18_1, arg_18_2)
	if self._knightAni then
		self._knightAni:playAction(arg_18_1, arg_18_2)
	end
end

function TeamPVPBattlePlayerComp:run()
	if self._knightAni then
		self._knightAni:playAction(var_0_1.LOOP_ACTION.RUN)
	end
end

function TeamPVPBattlePlayerComp:idle()
	if self._knightAni then
		self._knightAni:playIdle()
	end
end

function TeamPVPBattlePlayerComp:startBattle()
	self._isFight = true
end

function TeamPVPBattlePlayerComp:enterInBattle()
	if self._knightAni then
		self._knightAni:playAction(var_0_1.ACTION.IN)
	end
end

function TeamPVPBattlePlayerComp:setHp(arg_23_1)
	self.m_hpBar:setValue(arg_23_1)
end

function TeamPVPBattlePlayerComp:attackTower(arg_24_1)
	self:playAction(var_0_1.ACTION.ATTACK, handler(self, function()
		if arg_24_1 then
			if arg_24_1() then
				self:stop()
			elseif self._isFight then
				self:attackTower(arg_24_1)
			end
		end
	end))
end

function TeamPVPBattlePlayerComp:stop()
	self._isFight = false

	self:idle()
end

function TeamPVPBattlePlayerComp:hideInfo()
	self.m_attackTowerController:setSelectedIndex(1)
end

function TeamPVPBattlePlayerComp:reversal()
	self.m_knightComp:setScaleX(self.m_knightComp:getScaleX() * -1)
end

function TeamPVPBattlePlayerComp:playDefeatedSound()
	if self._isBoy then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_DEFEATEDFEEDBACK_MALE)
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_DEFEATEDFEEDBACK_FEMALE)
	end
end

function TeamPVPBattlePlayerComp:getNpcType()
	return self._npcType
end

function TeamPVPBattlePlayerComp:hidePlayerBuff()
	self.m_showBuffController:setSelectedIndex(0)
end

return TeamPVPBattlePlayerComp
