local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.const.ConstMgr.AncientsConst
local var_0_4 = g.core.event.EventManager
local var_0_5 = g.core.event.enum
local AncientsMainLayer = class("AncientsMainLayer", require("app.fairyGUI.ancients.UI_AncientsMainLayer"), function()
	return fgui.GComponent:create({
		resName = "AncientsMainLayer",
		pkgPath = "ui/ancients/ancients",
		isFullScreen = true,
		pkgName = "ancients"
	}, ...)
end)

function AncientsMainLayer:ctor()
	self:initView()
end

function AncientsMainLayer:initView()
	self:addBg("bg/ancients/bg_jxmy_zjm_jxmyzjmbg.jpg", false, nil, 1)
	self.m_Btn_chain:addClickListener(handler(self, self._onClickBtnChain))
	self.m_Btn_rank:addClickListener(handler(self, self._onClickBtnRank))
	self.m_Btn_shop:addClickListener(handler(self, self._onClickBtnShop))
	self.m_Btn_report:addClickListener(handler(self, self._onClickBtnReport))
	self.m_Btn_message:addClickListener(handler(self, self._onClickBtnMessage))
	self.m_Btn_pet:addClickListener(handler(self, self._onClickBtnPet))
	self.m_Btn_apply:addClickListener(handler(self, self._onClickBtnApply))
	self.m_Btn_lineup:addClickListener(handler(self, self._onClickBtnLineup))
	self.m_topBarComp:setResInfoById(var_0_3.TopBarId)

	self._compUsers = {
		self.m_Comp_user1,
		self.m_Comp_user2,
		self.m_Comp_user3,
		self.m_Comp_user4
	}

	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_TeamPVP)
	self.m_stateController:setSelectedIndex(g.core.model.User.ancientsData:isFinalState() and 1 or 0)

	if not g.core.model.User.ancientsData:isTeamUserLeader(g.core.model.User:getId(), var_0_3.GET_TEAM_TYPE.CURRENT_TEAM) then
		self.m_Btn_apply:setVisible(false)
	end

	self.m_enterTransition:play()
	self.m_effDi:addEffectSpine({
		anim = "play",
		name = "eff_ui_ancients_mainbglight",
		remove = false,
		isLoop = true
	})
	self.m_effPetUp:addEffectSpine({
		anim = "up",
		name = "eff_ui_ancients_petglowmain",
		isLoop = true
	})
	self.m_effPetDown:addEffectSpine({
		anim = "down",
		name = "eff_ui_ancients_petglowmain",
		isLoop = true
	})
end

function AncientsMainLayer:onLoad()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_2.FUNCTION_TYPE.ANCIENTS)
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_ANCIENT_ENTER, handler(self, self._onRcvEnter), self)
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_ANCIENT_NOTIFYTEAMCHANGE, handler(self, self._onRcvNotifyTeamChange), self)
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_ANCIENT_NOTIFYBEKICK, handler(self, self._onRcvNotifyBeKick), self)
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_ANCIENT_QUITTEAM, handler(self, self._onRcvQuitTeam), self)
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_ANCIENT_BATTLESPECTATE, handler(self, self._onRcvBattleSpectate), self)
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_ANCIENT_FIGHTTIMESNTF, handler(self, self._onRcvFightTimesNtf), self)
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_ANCIENT_NOTIFYMAXMESSAGEID, handler(self, self._onRcvNotifyMaxMessageId), self)
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_ANCIENT_TEAMTASKNTF, handler(self, self._onRevTeamTaskNtf), self)
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onS2CGetUserSnapShot), self)
	var_0_4:addEventListener(var_0_5.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayEvent), self)
	g.core.network.GameNetProxy:send_C2S_Ancient_Enter({})
end

function AncientsMainLayer:_updateView()
	local var_5_0 = g.core.model.User.ancientsData

	self.m_Comp_stage:updateView()
	self.m_Btn_fight:updateView({
		onClick = handler(self, self._onClickBtnFight),
		showAdd = var_5_0:getAncientsState() == var_0_3.ANCIENT_STATUS.FIGHT
	})

	if var_5_0:isFinalState() then
		self.m_stateController:setSelectedIndex(1)
		self.m_Comp_pet:updateView()
	else
		self.m_stateController:setSelectedIndex(0)
		self.m_Comp_score:updateView()
		self.m_Comp_award:updateView()
		self.m_Comp_prog:updateView()
	end

	self:_updateCompUsers()
end

function AncientsMainLayer:_updateCompUsers()
	for iter_6_0, iter_6_1 in ipairs(self._compUsers) do
		iter_6_1:updateView({
			pos = iter_6_0
		})
	end

	if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot((g.core.model.User.ancientsData:getTeamUserIds(var_0_3.GET_TEAM_TYPE.CURRENT_TEAM))) then
		for iter_6_2, iter_6_3 in ipairs(self._compUsers) do
			iter_6_3:updateUserBaseInfo()
		end
	end
end

function AncientsMainLayer:_onClickBtnLineup()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_FORMATION_LAYER, {
		formationType = g.core.const.ConstMgr.LineUpConst.MulTeamType.ANCIENTS
	})
end

function AncientsMainLayer:_onClickBtnChain()
	g.core.model.User.giftData:refreshInTime()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.ShopActivityGiftPop").new({
		activityValue = var_0_2.ActivityConst.ACTIVITY_TYPE.ANCIENTS_ACTIVITY,
		shopValue = var_0_2.ShopConst.SHOP_GIFT_VALUE.ANCIENTS_ACTIVITY,
		openCheckFunc = handler(self, function(arg_9_0)
			return g.core.model.User.ancientsData:isTimeToOpen()
		end),
		title = self.m_Btn_chain:getTitle()
	})))
end

function AncientsMainLayer:_onClickBtnRank()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_TEAM_RANK_POP)
end

function AncientsMainLayer:_onClickBtnShop()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_2.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_2.ShopConst.SHOP_TYPE.ANCIENTS
	})
end

function AncientsMainLayer:_onClickBtnReport()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_BATTLE_REPORT_POP)
end

function AncientsMainLayer:_onClickBtnMessage()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_MESSAGE_POP)
end

function AncientsMainLayer:_onClickBtnPet()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_SOUL_POP)
end

function AncientsMainLayer:_onClickBtnApply()
	if not g.core.model.User.ancientsData:isTeamUserLeader(g.core.model.User:getId(), var_0_3.GET_TEAM_TYPE.CURRENT_TEAM) then
		g.core.module.ModuleManager:tip(g.core.lang:get(433314))

		return
	end

	if g.core.model.User.ancientsData:getAncientsState() >= var_0_2.AncientsConst.ANCIENT_STATUS.FINAL then
		g.core.module.ModuleManager:tip(g.core.lang:get(433315))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_TEAM_APPLY_POP)
end

function AncientsMainLayer:_onClickBtnFight()
	local var_16_0 = g.core.model.User.ancientsData:getAncientsState()

	if var_16_0 == var_0_3.ANCIENT_STATUS.COOP then
		g.core.module.ModuleManager:tip(g.core.lang:get(433309))

		return
	elseif var_16_0 == var_0_3.ANCIENT_STATUS.FIGHT then
		local var_16_1 = g.core.model.User.ancientsData:getTeamOperateState(var_0_3.GET_TEAM_TYPE.CURRENT_TEAM)

		if var_16_1 == var_0_3.ANCIENT_OPERATE_STATUS.NONE then
			if g.core.model.User.ancientsData:isUserBanFight(g.core.model.User:getId(), var_0_3.GET_TEAM_TYPE.CURRENT_TEAM) then
				g.core.module.ModuleManager:tip(g.core.lang:get(433306))
			else
				g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_LINEUP_LAYER)
			end
		elseif var_16_1 == var_0_3.ANCIENT_OPERATE_STATUS.BATTLE then
			g.core.network.GameNetProxy:send_C2S_Ancient_BattleSpectate({})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(433305))
		end
	elseif var_16_0 == var_0_3.ANCIENT_STATUS.FINAL_COOP then
		g.core.module.ModuleManager:tip(g.core.lang:get(433410, {
			date = g.core.common.ServerTime:getDateMDFormat(g.core.model.User.ancientsData:getActivityData().final_start_time)
		}))
	elseif var_16_0 == var_0_3.ANCIENT_STATUS.FINAL then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_LINEUP_LAYER)
	elseif var_16_0 == var_0_3.ANCIENT_STATUS.REVIEW then
		g.core.module.ModuleManager:tip(g.core.lang:get(433310))
	end
end

function AncientsMainLayer:_onRcvEnter(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if g.core.utils.Tools.ancientsFunc.getNeedOpenModule() == g.view.entrance.ANCIENTS_COOP_MAIN_LAYER then
		g.core.utils.Tools.ancientsFunc.openAncientsMainLayer(true)

		return
	end

	self:_updateView()

	if g.core.model.User.ancientsData:isShowDiceReward() then
		local var_17_0 = g.core.model.User.ancientsData:getDailyDiceReward()

		if var_17_0 and #var_17_0 > 0 then
			for iter_17_0, iter_17_1 in ipairs(var_17_0) do
				if iter_17_1.uid == g.core.model.User:getId() and iter_17_1.dice_num > 0 and iter_17_1.dice_num == g.core.model.User.ancientsData:getSelfDiceNum() then
					g.core.common.Storage:save("ancients_daily_dice_reward_cache.json", {
						time = g.core.common.ServerTime:getTime()
					})
					g.core.module.ModuleManager:awardSummary({
						{
							value = 12004,
							type = g.core.common.Goods.TYPE_ITEM,
							size = iter_17_1.dice_num
						}
					}, false)
				end
			end
		end
	end

	var_0_4:dispatchEvent(var_0_5.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_Btn_pet
	})
end

function AncientsMainLayer:_onRcvNotifyTeamChange(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	self:_updateView()
end

function AncientsMainLayer:_onRcvNotifyBeKick(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	g.core.utils.Tools.ancientsFunc.openAncientsMainLayer(true)
end

function AncientsMainLayer:_onRcvQuitTeam(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	g.core.utils.Tools.ancientsFunc.openAncientsMainLayer(true)
end

function AncientsMainLayer:_onRcvBattleSpectate(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_BATTLE_LAYER, {
		atkTeam = g.core.model.User.ancientsData:getTeam(var_0_3.GET_TEAM_TYPE.CURRENT_TEAM),
		defTeam = g.core.model.User.ancientsData:getTeam(var_0_3.GET_TEAM_TYPE.ENEMY_TEAM),
		turns = arg_21_4.turns
	})
end

function AncientsMainLayer:_onRcvFightTimesNtf(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	self.m_Btn_fight:updateLeftCount()
end

function AncientsMainLayer:_onRcvNotifyMaxMessageId(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	return
end

function AncientsMainLayer:_onRevTeamTaskNtf()
	self.m_Comp_prog:updateView()
end

function AncientsMainLayer:_onS2CGetUserSnapShot(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	for iter_25_0, iter_25_1 in ipairs(self._compUsers) do
		iter_25_1:updateUserBaseInfo()
	end
end

function AncientsMainLayer:_onCrossDayEvent()
	if g.core.utils.Tools.ancientsFunc.getNeedOpenModule() ~= g.view.entrance.ANCIENTS_MAIN_LAYER then
		g.core.utils.Tools.ancientsFunc.openAncientsMainLayer(true)
	else
		g.core.network.GameNetProxy:send_C2S_Ancient_Enter({})
	end
end

return AncientsMainLayer
