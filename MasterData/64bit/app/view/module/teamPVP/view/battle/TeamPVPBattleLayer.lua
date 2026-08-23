local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.const.ConstMgr.TeamPvpConst
local var_0_2 = g.core.sound.SoundManager
local var_0_3 = g.core.const.ConstMgr.SoundConst
local TeamPVPBattleLayer = class("TeamPVPBattleLayer", require("app.fairyGUI.teamPVP.UI_TeamPVPBattleLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/teamPVP/teamPVP",
		resName = "TeamPVPBattleLayer",
		pkgName = "teamPVP"
	}, ...)
end)

function TeamPVPBattleLayer:ctor(arg_2_1)
	self._mapId = var_0_0:getMapId()

	if self._mapId > 0 then
		self._mapId = self._mapId or var_0_1.MAP_TYPE.SNOW
	end

	self:addBg(g.core.common.Path:getTeamPVPBattleBg(self._mapId), nil, nil, 1)
	self.m_isExtraController:setSelectedIndex(0)
	self.m_isShowReportController:setSelectedIndex(0)
	self.m_foodReportTxt:setVisible(false)

	if arg_2_1 then
		self._isExtraTurn = arg_2_1.extra or false
	end

	if self._isExtraTurn then
		self.m_mapController:setSelectedIndex(0)

		self._mapComp = self:getChild("mapExtraComp")
		self._mapId = var_0_1.EXTRAID
	else
		self.m_mapController:setSelectedIndex(self._mapId)

		self._mapComp = self:getChild("mapComp" .. self._mapId)
	end

	self._battleReport = nil
	self._isStartBattle = false
	self._killNumbers = {}
	self._playerHeads = {}

	self.m_enterTransition:play(handler(self, self._initMainView))
end

function TeamPVPBattleLayer:_initMainView()
	self._battleReport = var_0_0:getBattleReport()

	if self._battleReport then
		self.m_scoreComp:updateScore()
		self:_initBattlePlayerHeadInfo()
		self:_startFight(self._battleReport)
	end
end

function TeamPVPBattleLayer:_initBattlePlayerHeadInfo()
	local var_4_0 = {}

	if self._battleReport.isAtk then
		local var_4_1 = self._battleReport.atk_user or self._battleReport.def_user

		if self._battleReport.isAtk then
			local var_4_2 = self._battleReport.def_user or self._battleReport.atk_user

			if var_4_1 then
				for iter_4_0, iter_4_1 in ipairs(var_4_1) do
					if iter_4_1.npc_type == 0 then
						table.insert(var_4_0, iter_4_1)
					end
				end
			end

			if var_4_2 then
				for iter_4_2, iter_4_3 in ipairs(var_4_2) do
					if iter_4_3.npc_type == 0 then
						table.insert(var_4_0, iter_4_3)
					end
				end
			end
		end
	end

	for iter_4_4 = 1, var_0_1.MAX_HEAD_COUNT do
		if var_4_0 then
			local var_4_3 = var_4_0[iter_4_4] or nil

			if var_4_3 then
				self._playerHeads[var_4_3.guid] = self["m_headComp" .. iter_4_4]

				self["m_headComp" .. iter_4_4]:updateHeadComp({
					info = var_4_3
				})

				if self._isExtraTurn and not var_0_0:isLivePlayer(var_4_3.guid) then
					self["m_headComp" .. iter_4_4]:dodead()
				end
			end
		end
	end
end

function TeamPVPBattleLayer:_startFight(arg_5_1)
	self._isStartBattle = true

	if self._isExtraTurn then
		self.m_extraComp:play()
		self.m_isExtraController:setSelectedIndex(1)
	else
		self.m_isExtraController:setSelectedIndex(0)
	end

	self._mapComp:enterBattle()
	self._mapComp:startBattle(arg_5_1, self._isExtraTurn)
end

function TeamPVPBattleLayer:onLoad()
	g.core.layer.LayerManager:getSysTipLayer():setVisible(false)
	self._mapComp:updateMapComp({
		isExtra = self._isExtraTurn
	})
	var_0_2:playMusic(var_0_3.BGM.Music_Dingjunshan)
end

function TeamPVPBattleLayer:onUnload()
	g.core.layer.LayerManager:getSysTipLayer():setVisible(true)

	if self._isExtraTurn or not self._battleReport or not self._battleReport.extra_turn and not self._isExtraTurn then
		var_0_0:clearReport()
	end
end

function TeamPVPBattleLayer:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "TEAMPVP_PLAYER_DEAD" then
		if arg_8_2 and arg_8_2.playerGuid then
			if self._playerHeads[arg_8_2.playerGuid] then
				self._playerHeads[arg_8_2.playerGuid]:dodead()
			end
		end
	elseif arg_8_1 == "BattleResult_finish" then
		self:newScheduleOnce(handler(self, function()
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end), 0)
	elseif arg_8_1 == "END_BATTLE_EVENT" then
		g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_PVP_RESULT_DETAIL_LAYER)
	elseif arg_8_1 == "UPDATE_SCORE_BOARD" then
		if arg_8_2 and arg_8_2.isEnemy then
			self.m_scoreComp:blueScoreAdd()
		else
			self.m_scoreComp:redScoreAdd()
		end
	elseif arg_8_1 == "UPDATE_TEAM_BUFF_EFF" then
		self._mapComp:HideTeamPlayerBuffEffect(arg_8_2.isEnemy)
	elseif arg_8_1 == "ENTER_EXTRA_BATTLE" then
		g.core.module.ModuleManager:showCloud({
			callback = function()
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
				g.core.module.ModuleManager:pushModule(g.view.entrance.TEAMPVP_BATTLE_LAYER, {
					extra = true
				})
			end
		})
	elseif arg_8_1 == "CHECK_TOWER_STATE" then
		self._mapComp:checkTowerDestroy()
	elseif arg_8_1 == "SHOW_KILL_BOARD" then
		if arg_8_2 and arg_8_2.playerguid then
			self:_showKillReport(arg_8_2.playerinfo, arg_8_2.playerguid)
		end
	elseif arg_8_1 == "TEAMPVP_UPDATE_MORALE" then
		local var_8_0 = g.core.config.group_battle_parameter_info.get(var_0_1.MORALE_A).parameter

		self.m_scoreComp:updateMorale(arg_8_2.lefthp * var_8_0, arg_8_2.righthp * var_8_0)
		self._mapComp:setRunning(false)
	elseif arg_8_1 == "TEAMPVP_PLAYFOODSUCCESSTITLE" then
		self.m_foodReportTxt:setVisible(true)
		self.m_foodReportTxt:getTransition("enter"):play()
		self._mapComp:setRunning(false)
	elseif arg_8_1 == "TEAMPVP_SHOW_FLAGACTION" then
		local var_8_1, var_8_2 = self._mapComp:getMorale()
		local var_8_3 = self._mapComp:isFoodWin()
		local var_8_4 = g.core.config.group_battle_parameter_info.get(var_0_1.MORALE_A).parameter
		local var_8_5 = g.core.config.group_battle_parameter_info.get(var_0_1.MORALE_B).parameter

		self.m_scoreComp:playScoreChange(var_8_3, var_8_3 and var_8_1 * (var_8_3 and var_8_5 or var_8_4) or var_8_2 * (var_8_3 and var_8_4 or var_8_5))
		self._mapComp:setRunning(false)
	elseif arg_8_1 == "BATTLE_PLAYER_SHOW_NPC_EFFECT" then
		if arg_8_2.npcType and arg_8_2.npcType > 0 then
			self.m_reportTxt:getChild("nameTxt"):setVisible(false)
			self.m_reportTxt:setTitle(g.core.lang:get(420506))
			self.m_isShowReportController:setSelectedIndex(1)
			self.m_reportTxt:getChild("enterEffect"):addEffectSpine({
				name = "eff_ui_teamPvp_txtBattle",
				remove = true,
				isLoop = false,
				anim = "play"
			})
			self.m_reportTxt:getTransition("enter"):play()
		end
	end
end

function TeamPVPBattleLayer:_showKillReport(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1.name or ""

	if arg_11_1.robotName then
		var_11_0 = arg_11_1.robotName
	end

	self._killNumbers[arg_11_2] = not self._killNumbers[arg_11_2] and 1 or self._killNumbers[arg_11_2] + 1

	local var_11_1

	if self._killNumbers then
		var_11_1 = self._killNumbers[arg_11_2] or 1
	end

	local var_11_2 = self:_getKillText(var_11_1)

	self.m_reportTxt:getChild("nameTxt"):setVisible(true)
	self.m_reportTxt:getChild("nameTxt"):setText("[" .. var_11_0 .. "]")
	self.m_reportTxt:setTitle(var_11_2)
	self.m_isShowReportController:setSelectedIndex(1)
	self.m_reportTxt:getChild("enterEffect"):addEffectSpine({
		name = "eff_ui_teamPvp_txtBattle",
		remove = true,
		isLoop = false,
		anim = "play"
	})
	self.m_reportTxt:getTransition("enter"):play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_DEFEATPROMPT)

	if var_11_1 >= g.core.config.group_battle_parameter_info.get(var_0_1.KILL_FIRE_PARAMETER).parameter then
		if self._playerHeads[arg_11_2] then
			self._playerHeads[arg_11_2]:playFireIconEffect()
		end
	end
end

function TeamPVPBattleLayer:_getKillText(arg_12_1)
	for iter_12_0 = 1, g.core.config.group_battle_text_info.getLength() do
		local var_12_0 = g.core.config.group_battle_text_info.indexOf(iter_12_0)

		if var_12_0.trigger_type == arg_12_1 then
			return var_12_0.text
		end
	end

	return tostring(arg_12_1)
end

return TeamPVPBattleLayer
