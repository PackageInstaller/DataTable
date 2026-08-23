local var_0_0 = g.core.config.knight_info
local var_0_1 = g.core.config.peakarena_robot_info
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.const.ConstMgr.PeakArenaConst
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_5 = 1
local var_0_6 = g.core.model.User.peakArenaData
local var_0_7 = g.core.common.Path
local var_0_8 = g.core.common.ServerTime
local var_0_9 = g.core.platform.ServerListProxy
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local var_0_11 = g.core.model.User.snapShotCacheData
local var_0_12 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER
local PeakArenaMatchSuccessPop = class("PeakArenaMatchSuccessPop", require("app.fairyGUI.peakArena.UI_PeakArenaMatchSuccessPop"), function()
	return fgui.GComponent:create({
		resName = "PeakArenaMatchSuccessPop",
		pkgPath = "ui/peakArena/peakArena",
		isFullScreen = true,
		pkgName = "peakArena"
	}, ...)
end)

function PeakArenaMatchSuccessPop:ctor()
	self._userSnapshot = nil
	self._knightStructArr = {}
	self._opponentInfo = var_0_6:getMatchedOpponentInfo()
	self._timer = nil
	self._endTime = 0
	self._exeTimerLastTime = 0

	self.m_zs1Loader:setURL("pic/base_new/arena/pic_zhuangshi1.png")
	self.m_zs2Loader:setURL("pic/base_new/arena/pic_zhuangshi2.png")
	self.m_lineUpList:setVirtual()
	self.m_lineUpList:setItemRenderer(handler(self, self._onRenderLineUpList))
end

function PeakArenaMatchSuccessPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onS2CUserSnapshot), self)
	g.core.network.GameNetProxy:send_C2S_PeakArena_ChallengeBegin({
		is_battle = true
	})

	self._endTime = var_0_8:getTime() + var_0_3.WAIT_TIME_BEFORE_ENTER_BATTLE

	self:_updateUserSnapshot()
	self:_updateCDTxt((var_0_8:getLeftSeconds(self._endTime)))

	self._timer = self._timer or g.core.common.Scheduler:newSchedule(handler(self, self._onCD), var_0_5)

	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.PEAK_ARENA_SUCCESS_IN)
	self.m_enterTransition:play()
end

function PeakArenaMatchSuccessPop:_onS2CUserSnapshot()
	self:_updateUserSnapshot()
end

function PeakArenaMatchSuccessPop:_updateUserSnapshot()
	self._userSnapshot = self._opponentInfo.isRobot and var_0_11:getDataSnapShotTemplate(var_0_12, self._opponentInfo.targetId) or var_0_11:getSnapShot(var_0_12, self._opponentInfo.targetId)

	if self._userSnapshot then
		self._knightStructArr = self:_getLineUpKnights(self._userSnapshot)

		self:_updateUserInfo()
	end
end

function PeakArenaMatchSuccessPop:onUnload()
	self:_cancelScheduler()
end

function PeakArenaMatchSuccessPop:_onCD()
	local var_7_0 = var_0_8:getTime()

	if var_7_0 - self._exeTimerLastTime < var_0_5 then
		return
	end

	self._exeTimerLastTime = var_7_0

	self:_updateCDTxt(self._endTime - var_7_0)

	if self._endTime - var_7_0 <= 0 then
		self:_cancelScheduler()
		self.m_backTransition:play(handler(self, self._onBackAniEnd))
	end

	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.PEAK_ARENA_SUCCESS_COUNTDOWN)
end

function PeakArenaMatchSuccessPop:_onBackAniEnd()
	g.core.module.ModuleManager:popModule()

	local var_8_0 = var_0_6:getBattleId()

	if var_8_0 > 0 then
		g.core.battle.BattleProxy:enterBattle({
			soundType = 2,
			cloudLoading = true,
			battle_id = var_8_0,
			type = BattleConst.TYPE_PEAK_ARENA_PVP,
			skip = BattleConst.SKIP_TYPE.ACTIVE,
			battleType = BattleConst.BATTLE_TYPE.PVP,
			bgm = var_0_2.SoundConst.BGM.MUSIC_PEAK_ARENA_BATTLE,
			bgId = var_0_3.BATTLE_BG_ID
		})
	end
end

function PeakArenaMatchSuccessPop:_onRenderLineUpList(arg_9_1, arg_9_2)
	if self._knightStructArr[arg_9_1 + 1] then
		arg_9_2:updateComp(arg_9_1 + 1, {
			struct = self._knightStructArr[arg_9_1 + 1]
		}, true)
	else
		arg_9_2:updateComp(arg_9_1 + 1, nil, true)
	end
end

function PeakArenaMatchSuccessPop:_updateCDTxt(arg_10_1)
	if arg_10_1 < 0 then
		arg_10_1 = 0
	end

	self.m_cdTxt:setText((g.core.lang:get(307002, {
		second = arg_10_1
	})))
end

function PeakArenaMatchSuccessPop:_updateUserInfo()
	if self._userSnapshot then
		local var_11_0 = self._userSnapshot.server_name
		local var_11_1 = self._userSnapshot.name

		if self._userSnapshot.is_robot then
			var_11_0 = var_0_9:getSelectedServer().name

			local var_11_2 = g.core.config.peakarena_robot_info.get(self._opponentInfo.targetId)

			self.m_scoreTxt:setText(var_11_2.score)

			local var_11_3 = g.core.config.peakarena_level_info.get(var_11_2.level_id)

			self.m_danGradingTxt:setText(var_11_3.name)
			self.m_danGradingLoader:setURL(var_0_7:getPeakArenaDanGradingPic(var_11_3.pic))
			self.m_starComp:initStar({
				style = 2,
				index = 11,
				gap = -6,
				max = var_0_6:getMaxStarNum(var_11_3.pic),
				num = var_11_3.star
			})
			self.m_powerTxt:setText(var_11_2.fight_power)

			var_11_1 = var_11_2.name

			self.m_knightPicComp:updateKnight({
				baseId = var_11_2.seen_knight
			})
		else
			local var_11_4

			if self._opponentInfo then
				var_11_4 = self._opponentInfo.score or 0
			end

			local var_11_5 = var_0_6:getPALevelInfo(var_11_4)

			self.m_danGradingTxt:setText(var_11_5.name)
			self.m_danGradingLoader:setURL((var_0_7:getPeakArenaDanGradingPic(var_11_5.pic)))
			self.m_scoreTxt:setText(var_11_4)
			self.m_starComp:initStar({
				style = 2,
				index = 11,
				gap = -6,
				max = var_0_6:getMaxStarNum(var_11_5.pic),
				num = var_11_5.star
			})
			self.m_powerTxt:setText(self._userSnapshot.fight_value)
			self.m_knightPicComp:updateKnight({
				snapshot = self._userSnapshot
			})
		end

		var_11_0 = var_11_0 or ""

		self.m_serverNameTxt:setText(var_11_0)
		self.m_nameTxt:setText(var_11_1)
		self.m_lineUpList:setNumItems(var_0_3.LINE_UP_NUM)
	end
end

function PeakArenaMatchSuccessPop:_cancelScheduler()
	if self._timer then
		g.core.common.Scheduler:cancelSchedule(self._timer)

		self._timer = nil
	end
end

function PeakArenaMatchSuccessPop:_getLineUpKnights(arg_13_1)
	local var_13_0 = arg_13_1.knights or {}

	if arg_13_1.is_robot then
		var_13_0 = {}

		local var_13_1 = var_0_1.get(self._opponentInfo.targetId)

		while var_0_1.hasKey("knight_id_" .. 1) do
			if var_13_1["knight_id_" .. 1] > 0 then
				table.insert(var_13_0, var_13_1["knight_id_" .. 1])
			end
		end
	end

	local var_13_3 = {}

	for iter_13_0 = 1, var_0_3.LINE_UP_NUM do
		if var_13_0[iter_13_0] and var_13_0[iter_13_0] > 0 then
			local var_13_4 = var_0_0.get(var_13_0[iter_13_0])
			local var_13_5 = KnightStruct.new(var_13_4.advance_id)

			var_13_5:addCfgInfo(var_13_4)

			var_13_3[iter_13_0] = var_13_5
		end
	end

	return var_13_3
end

return PeakArenaMatchSuccessPop
