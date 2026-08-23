local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.model.User.gveDataMgr
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.const.ConstMgr.GveConst
local var_0_6 = g.core.model.User.gveDataMgr:getGveInstituteData()
local GveBossLayer = class("GveBossLayer", require("app.fairyGUI.gve.UI_GveBossLayer"), function()
	return fgui.GComponent:create({
		resName = "GveBossLayer",
		pkgPath = "ui/gve/gve",
		isFullScreen = true,
		pkgName = "gve"
	}, ...)
end)

function GveBossLayer:ctor(arg_2_1)
	var_0_6 = var_0_3:getGveInstituteData()
	self._bossId = arg_2_1.bossId
	self._gridX = arg_2_1.x
	self._gridY = arg_2_1.y
	self._isCanChallenge = arg_2_1.isCanChallenge
	self._timer = nil
	self._isInBattle = false
	self._gveData = var_0_3:getGveData()
	self._monsterList = {}
	self._allAwardList = {}
	self._bossData = self._gveData:getBossData(self._bossId, self._gridX, self._gridY)
	self._selectWave = 0
	self._debugFastBattle = false

	self:_initView()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Basic_Team_02)
end

function GveBossLayer:_initData()
	self._isInBattle = false

	var_0_3:getGveFormationData():resetKnights()
end

function GveBossLayer:_initView()
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.GVE_MAIN_LAYER)
	self.m_bossNameText:setText(self._bossData:getInfo().name)
	self.m_bossTip:setText(g.core.lang:get(309006, {
		name = self._bossData:getInfo().name
	}))
	self.m_descComp:setTitle(self._bossData:getInfo().des)
	self.m_skillComp:initComp(self._bossData:getInfo())
	self.m_skillComp1:initComp(self._bossData:getInfo())
	self.m_knightImg:setURL(var_0_2:getGveBossPath(self._bossData:getInfo().image))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_rankBtn2:addClickListener(handler(self, self._onClickFinalRankBtn))
	self.m_challengeBtn:addClickListener(handler(self, self._onClickChallengeBtn))
	self.m_monsterDetailsBtn:addClickListener(handler(self, self._onClickDetailsBtn))
	self.m_detailBtn:addClickListener(handler(self, self._onClickResearchDetailsBtn))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRendererAwardList))
	self.m_awardList2:setVirtual()
	self.m_awardList2:setItemRenderer(handler(self, self._onRendererAwardList2))
	self.m_monsterList:setVirtual()
	self.m_monsterList:setItemRenderer(handler(self, self._onRendererMonstList))
	self.m_monsterList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onMonsterListClickItem))

	local var_4_0 = self._bossData:getInfo().boss_type

	if self._bossData:getInfo().rank_award_1 > 0 or var_4_0 == var_0_5.GVE_BOSS_TYPE.RAND then
		self.m_isAwardController:setSelectedIndex(1)

		if var_4_0 == var_0_5.GVE_BOSS_TYPE.NORMAL then
			self.m_bossTypeController:setSelectedIndex(0)

			self._allAwardList = self._bossData:getAllBossRankAwardList()
		elseif var_4_0 == var_0_5.GVE_BOSS_TYPE.RAND then
			self.m_bossTypeController:setSelectedIndex(1)

			self._allAwardList = var_0_3:getChallengeReward()
		end

		self.m_awardList:setNumItems(#self._allAwardList)
	else
		self.m_bossTypeController:setSelectedIndex(0)
		self.m_isAwardController:setSelectedIndex(0)
	end

	for iter_4_0, iter_4_1 in ipairs((var_0_6:getInstituteStruct())) do
		if self["m_bossEquip" .. iter_4_0] then
			self["m_bossEquip" .. iter_4_0]:setEquipStruct(iter_4_1)
		end
	end
end

function GveBossLayer:updatePlayTimes()
	if not self._bossData then
		return
	end

	if self._bossData:getInfo().boss_type == var_0_5.GVE_BOSS_TYPE.RAND then
		local var_5_0 = var_0_3:getGveData():getTodayRandBossRandTime()
		local var_5_1 = var_0_3:getGveInstituteData():getInstituteByType(var_0_5.GVE_INSTITUTE_TYPE.RAND_BOSS):getEventValue(8)

		if var_5_1 <= var_5_0 then
			self.m_hasRewardController:setSelectedIndex(1)
		else
			self.m_hasRewardController:setSelectedIndex(0)
		end

		self.m_rewardTimesTxt:setText(math.max(var_5_1 - var_5_0, 0))
		self.m_allRewardTimesTxt:setText("/" .. var_5_1)
	end
end

function GveBossLayer:_onRendererMonstList(arg_6_1, arg_6_2)
	arg_6_2:updateByMonsterData(self._monsterList[arg_6_1 + 1], self._bossData)
end

function GveBossLayer:_onRendererAwardList(arg_7_1, arg_7_2)
	self._allAwardList[arg_7_1 + 1].hideNum = true

	arg_7_2:getChild("awardIcon"):updateIcon(self._allAwardList[arg_7_1 + 1])
end

function GveBossLayer:_onRendererAwardList2(arg_8_1, arg_8_2)
	self._challengeReward[arg_8_1 + 1].hideNum = true

	arg_8_2:getChild("awardIcon"):updateIcon(self._challengeReward[arg_8_1 + 1])
end

function GveBossLayer:_onMonsterListClickItem(arg_9_1)
	self._selectWave = self._monsterList[self.m_monsterList:getSelectedIndex() + 1].wave
end

function GveBossLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_BOSSGETINFO, self.onGetBossInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_BOSSNOTIFYDEAD, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_CHALLENGEBOSSBEGIN, self.onGetBattleEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_GOTO_TARGET_POS, handler(self, self._onGoToTargetPos), self)

	if var_0_1:getTime() - var_0_3:getGveData():getLastBossInfoTime() < 1 then
		self:newScheduleOnce(handler(self, self.sendMsg), 1)
	else
		self:sendMsg()
	end

	if not var_0_3:getGveData():getTargetPath({
		x = self._gridX,
		y = self._gridY
	}) then
		self.m_challengeBtn:setGrayed(true)
	else
		self.m_challengeBtn:setGrayed(false)
	end

	if DebugCommon.getDebugGlobalValueByKey("gve_skip_battle") ~= nil then
		self._debugFastBattle = DebugCommon.getDebugGlobalValueByKey("gve_skip_battle")
	end

	local var_10_0 = var_0_3:getGveData():getRandBossShowAward()

	if var_10_0 then
		var_0_4:awardSummary(var_10_0)
	end

	self:updatePlayTimes()

	local var_10_1 = var_0_3:getGveData():getFinalChallengeAward()

	if var_10_1 then
		var_0_4:awardSummary(var_10_1)
	end
end

function GveBossLayer:_onGoToTargetPos()
	var_0_4:onlyPopSelfByDisplay(self)
end

function GveBossLayer:sendMsg()
	g.core.network.GameNetProxy:send_C2S_GVE_BossGetInfo({
		boss_id = self._bossId,
		x = self._gridX,
		y = self._gridY
	})
end

function GveBossLayer:onGetBossInfo()
	var_0_3:getGveData():setLastBossInfoTime(var_0_1:getTime())
	self:_initData()
	self:updateView(true)

	local var_13_0 = -1

	if self._selectWave > 0 then
		for iter_13_0, iter_13_1 in pairs(self._monsterList) do
			if iter_13_1.wave == self._selectWave and iter_13_1.curTotalHp > 0 then
				var_13_0 = iter_13_0 - 1

				break
			end
		end

		if var_13_0 == -1 then
			self._selectWave = 0
		end
	end

	self.m_monsterList:setSelectedIndex(var_13_0)
end

function GveBossLayer:onGetBattleEnd()
	if self._debugFastBattle then
		self._isInBattle = false

		self:updateView()

		return
	end

	self._isInBattle = true
end

function GveBossLayer:updateView(arg_15_1)
	self.m_fianlBossDesc:setVisible(false)
	self.m_isFinalBossController:setSelectedIndex(0)

	if not self._bossData:isDeadByIndex(0) then
		self:_updateBossExpireTimer()

		if self._bossData:isAllMonsterDead() then
			self.m_showStateController:setSelectedIndex(1)
			self.m_bossNameComp:updateByBossData(self._bossData)

			local var_15_0 = self._bossData:getInfo()

			if var_15_0.boss_type == 1 and var_15_0.rank_award_1 == 0 then
				self.m_fianlBossDesc:setVisible(true)

				if self._bossData:isTodayOpenChallenge() then
					self.m_isFinalBossController:setSelectedIndex(2)

					self._challengeReward = var_0_3:getChallengeReward()

					self.m_awardList2:setNumItems(#self._challengeReward)
					self.m_finalRewardTimeTxt:setText(var_0_5.FINAL_BOSS_DAILY_REWARD_TIME - self._bossData:getFinalRewardTime() .. "/" .. var_0_5.FINAL_BOSS_DAILY_REWARD_TIME)
					self.m_finalDamageTxt:setText(self._bossData:getFinalDamageMax())
				else
					self.m_isFinalBossController:setSelectedIndex(1)
				end
			end
		else
			self.m_showStateController:setSelectedIndex(0)

			self._monsterList = self._bossData:getMonsterList()

			self.m_monsterList:setNumItems(#self._monsterList)
		end
	elseif not self._isInBattle then
		var_0_4:tip(g.core.lang:get(309010))
		var_0_4:onlyPopSelfByDisplay(self)
	end
end

function GveBossLayer:_onClickRankBtn()
	if self.m_bossTypeController:getSelectedIndex() == 1 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveInstituteInfoPop").new(252)))
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Menu_Slide)
		var_0_4:pushPopup(require("app.view.module.gve.view.gveStage.GveBossRankPop").new(self._bossData), {
			touchDisappear = false,
			ignoreTouch = false
		})
	end
end

function GveBossLayer:_onClickFinalRankBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Menu_Slide)
	var_0_4:pushPopup(require("app.view.module.gve.view.gveStage.GveBossFinalRankPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function GveBossLayer:_onClickChallengeBtn()
	if self._bossData:isAllMonsterDead() then
		self._selectWave = 0
	elseif self._selectWave == 0 then
		var_0_4:tip(g.core.lang:get(309022))

		return
	end

	local var_18_0 = var_0_3:getGveData():getTargetPath({
		x = self._gridX,
		y = self._gridY
	})

	if not var_18_0 then
		var_0_4:tip(g.core.lang:get(309140))
		g.core.module.ModuleManager:popComponent()

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_FORMATION_LAYER, true, {
		x = self._gridX,
		y = self._gridY,
		path = var_18_0,
		wave = self._selectWave,
		monsterId = self._bossId
	})
end

function GveBossLayer:_onClickDetailsBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Wujing_YouhuatiMenu_Slide)
	var_0_4:pushPopup(require("app.view.module.gve.view.gveStage.GveBossEscortPop").new(self._bossData, self._selectWave), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function GveBossLayer:_onClickResearchDetailsBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveInstitutePop").new()))
end

function GveBossLayer:_updateBossExpireTimer()
	if not self._bossData or not self._bossData:checkBossCanChallenge() then
		return
	end

	local var_21_0 = self._bossData:getExpireTime()

	if not var_21_0 or var_21_0 == 0 then
		self.m_limitTimeText:setText("")

		return
	end

	local var_21_1 = g.core.common.ServerTime:getDateObject(var_21_0)

	self.m_limitTimeText:setText((g.core.lang:get(309199, {
		month = var_21_1.month,
		day = var_21_1.day,
		hour = string.format("%02d", var_21_1.hour),
		min = string.format("%02d", var_21_1.min)
	})))
end

return GveBossLayer
