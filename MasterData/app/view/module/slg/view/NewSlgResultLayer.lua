local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local var_0_1 = g.core.model.User.newSlgData
local var_0_2 = g.core.config.new_slg_notice_info
local NewSlgResultLayer = class("NewSlgResultLayer", require("app.fairyGUI.newSlg.UI_NewSlgResultLayer"), function()
	return fgui.GComponent:create({
		resName = "NewSlgResultLayer",
		pkgPath = "ui/newSlg/newSlg",
		isFullScreen = true,
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgResultLayer:ctor()
	self:addBg("bg/newSlg/bg_hzts_zl_goumai.jpg")

	self._rankArr = {}

	self.m_curSesonList:setVirtual()
	self.m_curSesonList:setItemRenderer(handler(self, self._onCurSeasonItemRender))
	self.m_shopBtn:addClickListener(handler(self, self._onClickSlgShopBtn))
	self.m_seasonRankBtn:addClickListener(handler(self, self._onClickSeasonRankBtn))

	self._endTime = var_0_1:getActShowEndTime()

	self.m_enterTransition:play()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG)
end

function NewSlgResultLayer:_onCurSeasonItemRender(arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2:getChild("nameTip")

	var_3_0:getChild("num"):setText(g.core.utils.Number.getFormatNum(2, arg_3_1 + 1))
	var_3_0:setTitle(self._curSeasonData[arg_3_1 + 1].name)
	arg_3_2:getChild("descComp"):setTitle(self._curSeasonData[arg_3_1 + 1].text)
end

function NewSlgResultLayer:onLoad()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_SLG_S4)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETUSERSHOWRANKSTATISTIC, handler(self, self._onRcvShowRank), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETUSERSHOWSTATISTIC, handler(self, self._onRcvShowStatistic), self)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetUserShowRankStatistic({})
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetUserShowStatistic({})

	self._schedule = self:newSchedule(handler(self, self._updateCountDown), 1)

	self:_updateCountDown()
end

function NewSlgResultLayer:_updateCountDown()
	local var_5_0 = self._endTime - g.core.common.ServerTime:getTime()

	if var_5_0 > 0 then
		self.m_timeTxt:setText(g.core.lang:get(429556) .. g.core.common.ServerTime:getCountDownBySecond(var_5_0))
	else
		self:cancelSchedule(self._schedule)

		self._schedule = nil

		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function NewSlgResultLayer:_onRcvShowRank(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:_updateRankView(arg_6_4)
end

function NewSlgResultLayer:_updateRankView(arg_7_1)
	local var_7_0 = arg_7_1.alliance_contribute or {
		rank = 0,
		num = 0
	}

	self._rankArr[1] = {
		rankData = var_7_0,
		awardArr = var_0_1:getRankAwardByTypeAndValueAndRank(var_0_0.RANK_TYPE.UNION, var_7_0.rank)
	}

	local var_7_1 = arg_7_1.final_contribute or {
		rank = 0,
		num = 0
	}

	self._rankArr[2] = {
		rankData = var_7_1,
		awardArr = var_0_1:getRankAwardByTypeAndValueAndRank(var_0_0.RANK_TYPE.FINAL_DRAGON, var_7_1.rank)
	}

	local var_7_2 = arg_7_1.person_contribute or {
		rank = 0,
		num = 0
	}

	self._rankArr[3] = {
		rankData = var_7_2,
		awardArr = var_0_1:getRankAwardByTypeAndValueAndRank(var_0_0.RANK_TYPE.PERSONAL_ALL, var_7_2.rank)
	}

	self.m_infoComp:updateInfoComp(self._rankArr)
end

function NewSlgResultLayer:_onRcvShowStatistic(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self._curSeasonData = {}

	for iter_8_0 = 1, var_0_2.getLength() do
		local var_8_0 = var_0_2.indexOf(iter_8_0)

		if var_8_0.type == var_0_0.SLG_NOTICE_TYPE.KILL_MONSTER then
			if arg_8_4.kill_monster then
				local var_8_1 = arg_8_4.kill_monster.num or 0
				local var_8_2 = arg_8_4.kill_monster.over_num or 0
				local var_8_3 = arg_8_4.kill_monster.total_num or 0

				table.insert(self._curSeasonData, {
					name = var_8_0.name,
					text = g.core.lang:getByString(var_8_0.des, {
						num1 = var_8_1,
						num2 = var_8_3 == 0 and 100 or math.floor(var_8_2 / var_8_3 * 100)
					})
				})
			end
		elseif var_8_0.type == var_0_0.SLG_NOTICE_TYPE.ATTACK_CITY then
			if arg_8_4.attack_city then
				local var_8_5 = arg_8_4.attack_city.num or 0
				local var_8_6 = arg_8_4.attack_city.over_num or 0
				local var_8_7 = arg_8_4.attack_city.total_num or 0

				table.insert(self._curSeasonData, {
					name = var_8_0.name,
					text = g.core.lang:getByString(var_8_0.des, {
						num1 = var_8_5,
						num2 = var_8_7 == 0 and 100 or math.floor(var_8_6 / var_8_7 * 100)
					})
				})
			end
		elseif var_8_0.type == var_0_0.SLG_NOTICE_TYPE.BOSS_WIN_TIME then
			if arg_8_4.boss_team_win then
				local var_8_9 = arg_8_4.boss_team_win.num or 0
				local var_8_10 = arg_8_4.boss_team_win.over_num or 0
				local var_8_11 = arg_8_4.boss_team_win.total_num or 0

				table.insert(self._curSeasonData, {
					name = var_8_0.name,
					text = g.core.lang:getByString(var_8_0.des, {
						num1 = var_8_9,
						num2 = var_8_11 == 0 and 100 or math.floor(var_8_10 / var_8_11 * 100)
					})
				})
			end
		elseif var_8_0.type == var_0_0.SLG_NOTICE_TYPE.DRAGON_RANK then
			table.insert(self._curSeasonData, {
				name = var_8_0.name,
				text = g.core.lang:getByString(var_8_0.des, {
					num1 = self._rankArr[2].rankData.rank
				})
			})
		end
	end

	if next(self._curSeasonData) then
		self.m_curSesonList:setNumItems(#self._curSeasonData)
	end
end

function NewSlgResultLayer:_onClickSeasonRankBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_RANK)
end

function NewSlgResultLayer:_onClickSlgShopBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.NEW_SLG
	})
end

return NewSlgResultLayer
