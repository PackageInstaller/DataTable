local var_0_0 = g.core.config.daily_dungeon_reward_preview
local var_0_1 = g.core.config.play_num_info
local var_0_4 = g.core.config.parameter_info
local var_0_5 = g.core.model.User.dailyDungeonData
local var_0_6 = g.core.common.GlobalFunc
local DrawKnight = require("app.view.common.DrawKnight")
local DailyDungeonLayer = class("DailyDungeonLayer", require("app.fairyGUI.dailyDungeon.UI_DailyDungeonDetailLayer"), function()
	return fgui.GComponent:create({
		resName = "DailyDungeonDetailLayer",
		pkgPath = "ui/dailyDungeon/dailyDungeon",
		isFullScreen = true,
		pkgName = "dailyDungeon"
	}, ...)
end)

function DailyDungeonLayer:ctor(arg_2_1, arg_2_2)
	self:_initUIListeners()
	self:_reset()

	self._stageList = arg_2_1
	self._dungeonInfo = arg_2_2

	self.m_topBarComp:setResInfoById(61)
	self.m_topBarComp:setTitle(self._dungeonInfo.info.name)
end

function DailyDungeonLayer:_initUIListeners()
	self.m_list:setVirtual(self)
	self.m_list:setItemRenderer(handler(self, self._onStageItemRender))
	self.m_list:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemChange))
	self.m_list:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardItemRender))
	self.m_rewardList:setVirtual()
	self.m_fightLongBtn:addClickListener(handler(self, self._onFightClick))
	self.m_fightBtn:addClickListener(handler(self, self._onFightClick))
	self.m_swapBtn:addClickListener(handler(self, self._onSwapClick))
	self.m_swapLongBtn:addClickListener(handler(self, self._onSwapClick))
	self.m_lineupBtn:addClickListener(handler(self, self._onLineupClick))
	self.m_switchTransition:setHook("switch", function()
		self:_updateRightUI()
	end)
end

function DailyDungeonLayer:_setPlayerPassiveText()
	self.m_buffTxt:setText((g.core.utils.String.formatPassiveSkillDesc(self._dungeonInfo.player_passive)))
end

function DailyDungeonLayer:_onLineupClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function DailyDungeonLayer:_reset()
	self:_resetOther()
	self:_resetUI()
end

function DailyDungeonLayer:_resetOther()
	self._dungeonInfo = nil
	self._stageList = nil
	self._selectIdx = -1
	self._knights = {}
	self._talkIdx = 1
	self._monsterResId = -1
end

function DailyDungeonLayer:_resetUI()
	self:addBg("bg/dailyDungeon/bg_rcfb_tiaozhan.jpg")
end

function DailyDungeonLayer:_addCustomListeners()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_CHALLENGEBEGIN, self._onRecvChallenge, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_FAST, self._onRecvFast, self)
end

function DailyDungeonLayer:_addSchedule()
	if self._schedule == nil then
		self._schedule = self:newSchedule(handler(self, self._update), tonumber(var_0_4.get(8001).parameter))
	end
end

function DailyDungeonLayer:_showMask()
	self.m_mask:setVisible(true)
end

function DailyDungeonLayer:_hideMask()
	self.m_mask:setVisible(false)
	self:_showNextStageAnime()
end

function DailyDungeonLayer:_showNextStageAnime()
	self.m_list:scrollToView(self._selectIdx, false)
	self.m_list:setSelectedIndex(self._selectIdx + 1)
	self:_onItemChange(true)
	self.m_switchTransition:play()

	self._enterBattle = false

	self:_update()
	self:_updateTipsComp()
end

function DailyDungeonLayer:_updateTipsComp()
	self.m_subTipsComp:updateViewByParams({
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.MONTH_CARD,
		active = g.core.model.User.activityMonthCardData:isPrivilegeActivatedByIndex(1),
		desc = g.core.lang:get(405625) .. g.core.model.User.activityMonthCardData:getPrivilege(1)[2].name,
		btn = g.core.lang:get(405623),
		callback = function()
			g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, {
				tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.RECHARGE_TAB_TYPE,
				shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.MONTH_CARD
			})
		end
	})
	self.m_monthCardTipsComp:updateViewByParams({
		functionId = g.core.const.ConstMgr.FUNCTION_TYPE.TIME_LIFE_CARD,
		active = g.core.model.User.activityLifeTimeCardData:isSubscription(),
		desc = g.core.lang:get(405626) .. g.core.lang:get(405622),
		btn = g.core.lang:get(405624),
		callback = function()
			g.core.module.ModuleManager:pushModule(g.view.entrance.ACTIVITY, {
				activityValue = 0,
				activityType = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.LIFE_TIME_CARD
			})
		end
	})
end

function DailyDungeonLayer:onLoad()
	self:_addCustomListeners()
	self:_addSchedule()
	self.m_list:setNumItems(#self._stageList)

	if self._selectIdx > -1 then
		self.m_list:setSelectedIndex(self._selectIdx)

		self._selectIdx = -1
	else
		local var_18_1 = self:_getLastStageIdx()

		self.m_list:scrollToView(var_18_1, false)
		self.m_list:setSelectedIndex(var_18_1)
		self:playLayerEnterAnime({
			"infoGroup"
		})
	end

	if self._enterBattle then
		g.core.model.User.dailyDungeonData:updateNowStageDatas(true)
	end

	self:_onItemChange(true, self._enterBattle)

	self._enterBattle = false

	self:_update()
	self:_updateTipsComp()
end

function DailyDungeonLayer:_getLastStageIdx()
	local var_19_0 = 0

	for iter_19_0 = 1, #self._stageList do
		local var_19_1 = var_0_5:checkStageOpenState(self._stageList[iter_19_0].id)

		if var_19_1 > 2 and var_19_1 < 6 then
			var_19_0 = math.max(var_19_0, iter_19_0)
		end
	end

	return var_19_0 - 1
end

function DailyDungeonLayer:_onStageItemRender(arg_20_1, arg_20_2)
	local var_20_0 = var_0_5:checkStageOpenState(self._stageList[arg_20_1 + 1].id)

	arg_20_2:updateItem(self._stageList[arg_20_1 + 1], var_20_0)

	if arg_20_1 + 1 > 1 and var_20_0 == 5 and g.core.model.User.dailyDungeonData:isNowUnlockLevel(self._stageList[arg_20_1 + 1].id) then
		arg_20_2:playStageItemUnlock()
		self:_showMask()
		self:newScheduleOnce(handler(self, self._hideMask), 0.8)
	end
end

function DailyDungeonLayer:_onItemChange(arg_21_1, arg_21_2)
	local var_21_0 = self.m_list:getSelectedIndex()

	if var_21_0 == self._selectIdx then
		return
	end

	self._selectIdx = var_21_0

	if arg_21_1 == true then
		self:_updateRightUI()
	else
		self.m_switchTransition:play()
	end

	if not arg_21_2 then
		self:newScheduleOnce(handler(self, self._onPlayItemEffect), 0.1)
	end
end

function DailyDungeonLayer:_onPlayItemEffect()
	local var_22_0 = self.m_list:getChildAt((self.m_list:itemIndexToChildIndex(self._selectIdx)))

	if var_22_0 and var_22_0.playEff then
		var_22_0:playEff()
	end
end

function DailyDungeonLayer:_updateRightUI()
	self:_updateInfoUI()
	self:_updateMoster()
end

function DailyDungeonLayer:_onRewardItemRender(arg_24_1, arg_24_2)
	arg_24_2:updateIcon(self._rewards[arg_24_1 + 1])
end

function DailyDungeonLayer:_updateInfoUI()
	local var_25_0 = self._stageList[self._selectIdx + 1]

	self.m_infoTitleTxt:setText(self._stageList[self._selectIdx + 1].name)
	self.m_tipPowerTxt:setText(g.core.utils.Number.transFightValue(tonumber(var_25_0.fight_power)))

	local var_25_1 = var_0_5:checkStageOpenState(var_25_0.id)
	local var_25_2 = var_0_0.get(var_25_0.reward_preview)
	local var_25_3 = var_0_5:getInfo(var_25_0.id)
	local var_25_4 = var_25_2.k <= var_25_3.record

	self._dungeonNum = self._dungeonInfo.info.dungeon_num

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SUBSCRIPTION_DAILY_DUNGEON) then
		self.m_isShowSwapController:setSelectedIndex(1)
		self.m_fightLongBtn:setVisible(false)
	else
		self.m_isShowSwapController:setSelectedIndex(0)
		self.m_fightLongBtn:setVisible(true)
	end

	if var_25_4 then
		self.m_passStateController:setSelectedIndex(2)
	elseif var_25_3.record >= 0 then
		self.m_passStateController:setSelectedIndex(1)
	else
		self.m_fightLongBtn:setVisible(true)
		self.m_passStateController:setSelectedIndex(0)
	end

	self.m_fightLongBtn:setText(g.core.lang:get(1038))
	self.m_isMatchLvController:setSelectedIndex(1)

	if self.m_chapterIconLoader:getURL() ~= "bg/dailyDungeon/" .. self._dungeonInfo.info.background .. ".jpg" then
		self.m_chapterIconLoader:setURL("bg/dailyDungeon/" .. self._dungeonInfo.info.background .. ".jpg")
	end

	if var_25_1 == 0 or var_25_1 == 1 or var_25_1 == 2 then
		self.m_isLockController:setSelectedIndex(1)

		local var_25_5 = var_25_0.description

		if var_25_1 == 1 or var_25_1 == 0 then
			self.m_isMatchLvController:setSelectedIndex(0)
		end

		self.m_lockTxt:setText(var_25_5)
		self.m_recordController:setSelectedIndex(0)
	elseif var_25_1 == 3 or var_25_1 == 5 then
		self.m_isLockController:setSelectedIndex(0)

		if var_25_1 == 5 then
			self.m_recordController:setSelectedIndex(0)
		else
			self.m_recordController:setSelectedIndex(1)
			self.m_tipScoreTxt:setText((g.core.lang:get(300503 + var_25_2.extra_reward, {
				num = var_25_3.record
			})))
		end
	else
		self.m_isLockController:setSelectedIndex(0)
		self.m_recordController:setSelectedIndex(1)
		self.m_tipScoreTxt:setText((g.core.lang:get(300503 + var_25_2.extra_reward, {
			num = var_25_3.record
		})))
	end

	self.m_descTxt:setText(self._dungeonInfo.info.reward_description)

	self._rewards = {}

	if var_25_2.base_type_1 > 0 then
		self._rewards[#self._rewards + 1] = {
			award = {
				hideNum = true,
				type = var_25_2.base_type_1,
				value = var_25_2.base_type_value_1
			},
			min = var_25_2.base_num_1,
			max = var_25_2.base_num_1 + var_25_2.extra_num
		}
	end

	self.m_rewardList:setNumItems(#self._rewards)
	self:_updateAttackNumTxt()
	self.m_groundBuffTxt:setText(g.core.lang:get(300605) .. g.core.utils.String.formatPassiveSkillDesc(var_25_0.player_passive))
end

function DailyDungeonLayer:_updateAttackNumTxt()
	self.m_atackNumText:setText(g.core.lang:get(102512, {
		num = g.core.model.User.shopData:getLeftCount(self._dungeonNum),
		max = var_0_1.get(self._dungeonNum).reset
	}))
	self:_updateAttackNumPos()
end

function DailyDungeonLayer:_updateAttackNumPos()
	local var_27_0 = self.m_passStateController:getSelectedIndex() == 1 and cc.p(self.m_swapBtn:getPosition()) or cc.p(self.m_fightLongBtn:getPosition())

	var_27_0.y = self.m_attackNumTitleText:getPosition().y

	local var_27_1 = self.m_attackNumTitleText:getWidth()
	local var_27_2 = clone(var_27_0)

	var_27_2.x = var_27_2.x + (var_27_1 - (var_27_1 + self.m_atackNumText:getWidth()) / 2)

	self.m_attackNumTitleText:setPosition(var_27_2)
	self.m_atackNumText:setPosition(var_27_2)
end

function DailyDungeonLayer:_updateMoster()
	if self._monsterResId ~= self._dungeonInfo.info.monster_icon then
		self.m_knightPicComp:updatePic({
			scale = 0.6,
			url = g.core.common.Path:getKnightPicById(self._dungeonInfo.info.monster_icon)
		})
	end
end

function DailyDungeonLayer:onUnload()
	self._schedule = nil
end

function DailyDungeonLayer:_update()
	if self._dungeonInfo.info == nil then
		return
	end

	self._talkIdx = self._talkIdx == 1 and 2 or 1
end

function DailyDungeonLayer:_checkCanClick()
	if var_0_5:checkStageOpenState(self._stageList[self._selectIdx + 1].id) < 3 then
		g.core.module.ModuleManager:tip(g.core.lang:get(300503))

		return
	end

	return true
end

function DailyDungeonLayer:_onFightClick()
	if not self:_checkCanClick() then
		return
	end

	if g.core.model.User.shopData:getLeftCount(self._dungeonNum) <= 0 and self.m_passStateController:getSelectedIndex() ~= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1073))

		return
	end

	local var_32_0 = self._stageList[self._selectIdx + 1]

	if self._dungeonInfo.info.daily_dungeon_type == 4 then
		var_0_6.checkBagBeforeBattle(function()
			g.core.network.GameNetProxy:send_C2S_DailyDungeon_ChallengeBegin({
				id = var_32_0.id
			})
		end)
	else
		g.core.network.GameNetProxy:send_C2S_DailyDungeon_ChallengeBegin({
			id = var_32_0.id
		})
	end
end

function DailyDungeonLayer:_onSwapClick()
	if not self:_checkCanClick() then
		return
	end

	if g.core.model.User.shopData:getLeftCount(self._dungeonNum) <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1073))

		return
	end

	local var_34_0 = self._stageList[self._selectIdx + 1]

	if self._dungeonInfo.info.daily_dungeon_type == 4 then
		var_0_6.checkBagBeforeBattle(function()
			g.core.network.GameNetProxy:send_C2S_DailyDungeon_Fast({
				id = var_34_0.id
			})
		end)
	else
		g.core.network.GameNetProxy:send_C2S_DailyDungeon_Fast({
			id = var_34_0.id
		})
	end
end

function DailyDungeonLayer:_onRecvChallenge(arg_36_1, arg_36_2, arg_36_3)
	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		cloudLoading = true,
		canSkip = var_0_5:getInfo(arg_36_3.id).clear,
		type = BattleConst.TYPE_DAILY,
		battle_id = arg_36_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		bgId = g.core.config.daily_dungeon_stage_info.get(arg_36_3.id).battle_stage
	})

	self._enterBattle = true
end

function DailyDungeonLayer:_onRecvFast(arg_37_1, arg_37_2, arg_37_3)
	self:_updateAttackNumTxt()
	self.m_list:refreshVirtualList()

	if arg_37_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_37_3.awards, true, "ui://text/title_saodangchenggong")
	end
end

return DailyDungeonLayer
