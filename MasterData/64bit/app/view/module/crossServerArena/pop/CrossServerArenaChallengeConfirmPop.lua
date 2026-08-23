local var_0_0 = g.core.config.chief_arena_robot_info
local var_0_1 = g.core.model.User.crossServerArenaData
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.const.ConstMgr.CrossServerArenaConst
local var_0_4 = g.core.module.ModuleManager
local BattleConst = require("app.view.battle.const.BattleConst")
local CrossServerArenaChallengeConfirmPop = class("CrossServerArenaChallengeConfirmPop", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaChallengeConfirmPop"), function()
	return fgui.GComponent:create({
		resName = "CrossServerArenaChallengeConfirmPop",
		pkgName = "crossServerArena",
		isFullScreen = true,
		pkgPath = "ui/crossServerArena/crossServerArena"
	})
end)

function CrossServerArenaChallengeConfirmPop:ctor(arg_2_1, arg_2_2)
	self:showAtCenter()
	self.m_enterBattleBtn:addClickListener(handler(self, self._enterBattlePreparation))
	self.m_blankSpace:addClickListener(handler(self, self._onClickBlankSpace))

	self._challengeData = arg_2_1
	self._userInfo = arg_2_1.user or {}
	self._params = arg_2_2
	self._rivalData = nil

	self:_initView()
end

function CrossServerArenaChallengeConfirmPop:_initView()
	self.m_knightPicComp:updateKnight({
		snapshot = self._userInfo
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-300, 0, 400, 0), 200)
	self.m_rankTxt:setText(self._challengeData.showRank or self._challengeData.rank)
	self.m_nameTxt:setText(self._userInfo.name)
	self.m_powerTxt:setText(self._userInfo.fight_value)
end

function CrossServerArenaChallengeConfirmPop:_updateView()
	if not self._rivalData then
		return
	end

	local var_4_0 = 0

	for iter_4_0 = 1, 3 do
		self["m_powerComp" .. iter_4_0]:updateComp(self._rivalData.formations[iter_4_0], self._params)

		var_4_0 = var_4_0 + ((self._rivalData.formations[iter_4_0] or nil) and (self._rivalData.formations[iter_4_0].fight_value or 0))
	end

	self.m_powerTxt:setText(var_4_0)
end

function CrossServerArenaChallengeConfirmPop:_enterBattlePreparation()
	if not self._challengeData then
		return
	end

	if not var_0_1:isFormationValid() then
		var_0_4:tip(g.core.lang:get(411038))

		return
	end

	if g.core.model.User.shopData:getLeftCount(var_0_3.BUY_TIMES_ID) == 0 then
		var_0_4:tip(g.core.lang:get(411010))

		return
	end

	if var_0_1:isSkipFormation() then
		if not self._challengeData then
			return
		end

		if var_0_1:checkChallengeTime(self._challengeData.rank, self._uid) then
			self:_cacheBattleInfo()

			local var_5_0 = {
				rank = self._challengeData.rank
			}

			if self._rivalData.isRobot then
				var_5_0.id = self._challengeData.robotId or self._challengeData.user.id
			end

			g.core.network.GameNetProxy:send_C2S_ChiefArena_ChallengeBegin(var_5_0)
		end

		return
	end

	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.CLICK_ENTER)
	g.core.model.User.guideData:setSaveServerData(var_0_2.GuideConst.SAVE_SERVER_DATA_IDS.CROSS_SERVER_ARENA2)
	var_0_4:pushModule(g.view.entrance.ARENA_BATTLE_PREPARATION, {
		challengeData = self._challengeData,
		rivalData = self._rivalData
	})
	self:_onClose()
end

function CrossServerArenaChallengeConfirmPop:_cacheBattleInfo()
	var_0_1:cacheBattleInfo({
		rivalTeam = self._rivalData,
		rank = self._challengeData.rank,
		isRobot = self._rivalData.isRobot
	})
end

function CrossServerArenaChallengeConfirmPop:_onClickBlankSpace()
	self:setTouchable(false)
	self.m_backTransition:play(handler(self, self._onClose))
end

function CrossServerArenaChallengeConfirmPop:_onClose()
	var_0_4:onlyPopSelfByDisplay(self)
end

function CrossServerArenaChallengeConfirmPop:_onS2CFormationGetOther(arg_9_1, arg_9_2, arg_9_3)
	self._rivalData = var_0_1:getOtherFormationData()

	self:_updateView()
end

function CrossServerArenaChallengeConfirmPop:_onChiefArenaChallengeBegin(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3.ret == 3426 or arg_10_3.ret == 3429 then
		var_0_4:onlyPopSelfByDisplay(self)

		return
	end

	var_0_1:setEnterBattleStatus(true)
	g.core.battle.BattleProxy:enterBattle({
		cloudLoading = true,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		type = BattleConst.TYPE_CROSS_SERVER_ARENA,
		battle_id = arg_10_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		bgm = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_PVP_B
	})
	self:_onClose()
end

function CrossServerArenaChallengeConfirmPop:_createRobotFormation(arg_11_1)
	local var_11_0 = {}

	for iter_11_0 = 1, var_0_3.BATTLE_ROUND_NUM do
		var_11_0[iter_11_0] = {}
		var_11_0[iter_11_0].knight_id = {}
		var_11_0[iter_11_0].position = {}

		for iter_11_1 = 1, var_0_3.MAX_LINEUP_KNIGHT do
			table.insert(var_11_0[iter_11_0].knight_id, arg_11_1["knight_id_" .. (iter_11_0 - 1) * 6 + iter_11_1])
			table.insert(var_11_0[iter_11_0].position, iter_11_1)
		end

		var_11_0[iter_11_0].fight_value = arg_11_1["fight_power_" .. iter_11_0] or 0
	end

	return var_11_0
end

function CrossServerArenaChallengeConfirmPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GETOTHER, self._onS2CFormationGetOther, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_CHALLENGEBEGIN, self._onChiefArenaChallengeBegin, self)

	if self._challengeData.robotId and self._challengeData.robotId > 0 then
		self._rivalData = {}
		self._rivalData.isRobot = true
		self._rivalData.formations = self:_createRobotFormation((var_0_0.fetch(self._challengeData.robotBaseId)))
	else
		g.core.network.GameNetProxy:send_C2S_Formation_GetOther({
			target_id = self._userInfo.id,
			tp = var_0_2.LineUpConst.MulTeamType.CROSS_SERVER_ARENA
		})
	end

	self:_updateView()
	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.FOG_NIGHTMARE_EXPLORE_OPEN)
	self.m_enterTransition:play(handler(self, self._checkTipsGuide))
end

function CrossServerArenaChallengeConfirmPop:_checkTipsGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if not var_0_1:isNeedGuide() then
		return
	end

	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "CS_ARENA_ROBOT_CHALLENGE",
			targetBtn = self.m_enterBattleBtn
		})
	end, 0)
end

return CrossServerArenaChallengeConfirmPop
