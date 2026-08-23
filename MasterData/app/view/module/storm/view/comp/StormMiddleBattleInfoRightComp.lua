local StormMiddleBattleInfoRightComp = class("StormMiddleBattleInfoRightComp", require("app.fairyGUI.storm.UI_StormMiddleBattleInfoRightComp"))
local var_0_1 = g.core.common.GlobalFunc

function StormMiddleBattleInfoRightComp:ctor()
	self._stormId = 0
	self._cellEventId = 0
	self._eventInfo = nil

	self:_initListener()

	local var_1_0 = self.m_effUiAudio:getSize()

	self.m_groupShowController:setSelectedIndex(1)
	self.m_effUiAudio:addEffectSpine({
		name = "eff_ui_dungeon_audio",
		isLoop = true,
		scale = 1,
		x = var_1_0.width / 2,
		y = var_1_0.height / 2
	})

	self._normalRewards = {}
	self._dropRewards = {}

	self.m_enterTransition:play()
end

function StormMiddleBattleInfoRightComp:onLoad()
	return
end

function StormMiddleBattleInfoRightComp:_initListener()
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattle))
	self.m_lineupBtn:addClickListener(handler(self, self._onClickLineUp))
	self.m_normalList:setVirtual()
	self.m_normalList:setItemRenderer(handler(self, self._onNormalRewardRenderer))
	self.m_normalList:doFairyBatching(false)
	self.m_dropList:setVirtual()
	self.m_dropList:setItemRenderer(handler(self, self._onDropRewardRenderer))
	self.m_dropList:doFairyBatching(false)
end

function StormMiddleBattleInfoRightComp:_onNormalRewardRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._normalRewards[arg_4_1 + 1])
end

function StormMiddleBattleInfoRightComp:_onDropRewardRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateIcon({
		award = self._dropRewards[arg_5_1 + 1],
		min = self._dropRewards[arg_5_1 + 1].size,
		max = self._dropRewards[arg_5_1 + 1].max_size
	})
end

function StormMiddleBattleInfoRightComp:_onClickBattle()
	if not self:_checkBattleRes() then
		return
	end

	var_0_1.checkBagBeforeBattle(handler(self, self._startBattle))
end

function StormMiddleBattleInfoRightComp:_checkBattleRes()
	if g.core.model.User.shopData:getLeftCount((g.core.model.User.stormData:getMiddleCityPlayNumId(self._stormId))) <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(304507))

		return false
	end

	return true
end

function StormMiddleBattleInfoRightComp:_startBattle()
	g.core.network.GameNetProxy:send_C2S_Storm_ChallengeBegin({
		storm_id = self._stormId,
		cell_id = self._cellEventId
	})
	self:hideAction()
end

function StormMiddleBattleInfoRightComp:_onClickLineUp()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function StormMiddleBattleInfoRightComp:_onRcvResetCount()
	self:_updateChallengeState()
end

function StormMiddleBattleInfoRightComp:setData(arg_11_1)
	self._stormId = arg_11_1.stormId
	self._cellEventId = arg_11_1.cellEventId
	self._eventInfo = arg_11_1.eventInfo

	table.insert(self._normalRewards, {
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_STORM_SKILL_POINT,
		size = self._eventInfo.point_value
	})
end

function StormMiddleBattleInfoRightComp:_initKnightDrawSpine(arg_12_1)
	self.m_knightPicComp:updateKnight({
		scale = 0.9,
		resId = arg_12_1
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 500, 0), 250)
end

function StormMiddleBattleInfoRightComp:onBattleUserInfoBack(arg_13_1)
	self.m_severTxt:disableAutoChange()

	local var_13_0 = arg_13_1.battle_user.user.server_name

	if arg_13_1.battle_user.user.server_name then
		local var_13_1 = string.match(var_13_0, "%w+")

		if var_13_1 then
			var_13_0 = var_13_1
		end

		self.m_severTxt:setText(var_13_0)
	end

	self.m_nameTxt:setText(arg_13_1.battle_user.user.name)
	self.m_forceTxt:setText(arg_13_1.battle_user.user.fight_value)

	local var_13_2 = {}

	for iter_13_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX do
		if arg_13_1.battle_user.formation.knight_id[iter_13_0] > 0 then
			for iter_13_1, iter_13_2 in pairs(arg_13_1.battle_user.knights) do
				local var_13_4

				if iter_13_2.id == arg_13_1.battle_user.formation.knight_id[iter_13_0] then
					local var_13_3 = g.core.config.knight_info.get(iter_13_2.base_id)

					if var_13_3.quality >= g.core.const.ConstMgr.KNIGHT_CONST.HALO_QUALITY_LIMIT then
						var_13_2[var_13_3.group] = not var_13_2[var_13_3.group] and 1 or var_13_2[var_13_3.group] + 1
					end

					var_13_4 = 1 + 1

					break
				end
			end
		end
	end

	local var_13_5 = 1
	local var_13_6 = var_13_2[1] or 0

	for iter_13_3 = 2, 4 do
		local var_13_7 = var_13_2[iter_13_3] or 0

		if var_13_6 < var_13_7 then
			var_13_5 = iter_13_3
			var_13_6 = var_13_7
		end
	end

	if var_13_6 > 0 then
		self.m_groupLoader:setIcon(g.core.common.Path:getCampURL(var_13_5, 6))
		self.m_groupNumTxt:setText("x" .. var_13_6)
		self.m_groupShowController:setSelectedIndex(0)
	end

	local var_13_8 = g.core.config.knight_base_info.get(g.core.config.knight_info.get(arg_13_1.battle_user.user.base_id).res_id)

	self:_initKnightDrawSpine(((arg_13_1.battle_user.user.skin and arg_13_1.battle_user.user.skin > 0 or nil) and g.core.config.knight_base_info.get(g.core.config.skin_info.get(arg_13_1.battle_user.user.skin).res)).painted_id)

	local var_13_9 = g.core.model.User:getFightValue()

	if self._eventInfo.exchange_point_value ~= 0 then
		table.insert(self._normalRewards, {
			type = g.core.common.Goods.TYPE_RESOURCE,
			value = g.core.common.Goods.RESOURCE.TYPE_STORM_SCORE,
			size = math.floor((1 + cc.clampf((arg_13_1.battle_user.user.fight_value - var_13_9) / var_13_9, -0.2, 0.2)) * self._eventInfo.exchange_point_value)
		})
	end

	self.m_costLoader:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_FUNCTION_NUM, (g.core.model.User.stormData:getMiddleCityPlayNumId(self._stormId)))))
	self.m_costTxt:setText("1")

	if g.core.model.User.shopData:getLeftCount((g.core.model.User.stormData:getMiddleCityPlayNumId(self._stormId))) < 1 then
		self.m_costTxt:setColor(cc.c3b(244, 78, 78))
	else
		self.m_costTxt:setColor(cc.c3b(36, 189, 129))
	end

	self:updateReward()
end

function StormMiddleBattleInfoRightComp:updateReward()
	self.m_normalList:setNumItems(#self._normalRewards)

	self._dropRewards = g.core.common.Drops:getGoodsArray(self._eventInfo.challenge_reward)

	self.m_dropList:setNumItems(#self._dropRewards)
end

function StormMiddleBattleInfoRightComp:hideAction()
	if self._closed then
		return
	end

	self._closed = true

	self:stopAllFGActions()
	g.core.module.ModuleManager:popModule()
end

return StormMiddleBattleInfoRightComp
