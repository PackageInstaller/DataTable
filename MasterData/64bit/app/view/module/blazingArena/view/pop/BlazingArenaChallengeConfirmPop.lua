local var_0_0 = g.core.model.User.blazingArenaData
local BlazingArenaChallengeConfirmPop = class("BlazingArenaChallengeConfirmPop", require("app.fairyGUI.blazingArena.UI_BlazingArenaChallengeConfirmPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/blazingArena/blazingArena",
		resName = "BlazingArenaChallengeConfirmPop",
		pkgName = "blazingArena"
	})
end)

function BlazingArenaChallengeConfirmPop:ctor(arg_2_1)
	self._challengeData = arg_2_1

	self:_initView()
	self:showAtCenter()
end

function BlazingArenaChallengeConfirmPop:_initView()
	local var_3_0 = {}
	local var_3_1 = 0

	if self._challengeData.isRobot then
		self.m_nameTxt:setText(self._challengeData.name)

		var_3_0.baseId = self._challengeData.knightPic
		var_3_1 = self._challengeData.fightValue
	else
		local var_3_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._challengeData.id)

		self.m_nameTxt:setText(var_3_2.name)

		var_3_0.snapshot = var_3_2
		var_3_1 = self._challengeData.fightValue
	end

	self.m_knightPicComp:updateKnight(var_3_0)
	self.m_rankTxt:setText((math.min(self._challengeData.rank, var_0_0:getMaxRankNum())))
	self.m_powerTxt:setText(var_3_1)
	self.m_enterBattleBtn:addClickListener(handler(self, self._enterBattlePreparation))
	self:addClickListener(handler(self, self._onClickBlankSpace))
end

function BlazingArenaChallengeConfirmPop:_enterBattlePreparation()
	if not self._challengeData then
		return
	end

	if not var_0_0:isInActivityPlayTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(431409))

		return
	end

	if var_0_0:getAttackTimes() < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(431410))

		return
	end

	if not var_0_0:isFormationValid() then
		g.core.module.ModuleManager:tip(g.core.lang:get(411038))

		return
	end

	if #var_0_0:getAllExpiredMember().typeList > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(431414))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.BLAZING_ARENA_BATTLE_PREPARATION, self._challengeData)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.GUILD_WAR_DRILL_CHALLENGE_BTN)
	self:_onClose()
end

function BlazingArenaChallengeConfirmPop:_onClickBlankSpace()
	self:setTouchable(false)
	self.m_backTransition:play(handler(self, self._onClose))
end

function BlazingArenaChallengeConfirmPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function BlazingArenaChallengeConfirmPop:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GETOTHER, handler(self, self._onS2CFormationGetOther), self)
end

function BlazingArenaChallengeConfirmPop:onLoad()
	self:_addCustomListener()

	if not self._challengeData.formations then
		g.core.network.GameNetProxy:send_C2S_Formation_GetOther({
			target_id = self._challengeData.id,
			tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA
		})
	else
		self:_updateFormation(self._challengeData.formations)
	end
end

function BlazingArenaChallengeConfirmPop:_updateFormation(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_0 = {}

		for iter_9_2, iter_9_3 in pairs(iter_9_1.knights) do
			var_9_0[#var_9_0 + 1] = iter_9_2
		end

		table.sort(var_9_0, function(arg_10_0, arg_10_1)
			return arg_10_0 < arg_10_1
		end)

		for iter_9_4, iter_9_5 in ipairs(var_9_0) do
			local var_9_1 = self[table.concat({
				"m_knightComp",
				1
			})]

			if not var_9_1 then
				break
			end

			var_9_1:updateIconComp(g.core.common.Goods.TYPE_KNIGHT, iter_9_1.knights[iter_9_5])
		end

		self[table.concat({
			"m_formationPowerTxt",
			iter_9_0
		})]:setText(iter_9_1.fight_value)
	end
end

function BlazingArenaChallengeConfirmPop:_onS2CFormationGetOther(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = g.core.model.User.blazingArenaData:getOtherFormationData(self._challengeData.id)

	self._challengeData.formations = var_11_0

	self:_updateFormation(var_11_0)
end

return BlazingArenaChallengeConfirmPop
