local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.blazingArenaData
local BlazingArenaChallengeCell = class("BlazingArenaChallengeCell", require("app.fairyGUI.blazingArena.UI_BlazingArenaChallengeCell"))

function BlazingArenaChallengeCell:ctor()
	self._info = nil

	self:addClickListener(handler(self, self._onClickSelf))
end

function BlazingArenaChallengeCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateUIWithBlazingArenaUnit), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GETOTHER, handler(self, self._onS2CFormationGetOther), self)
end

function BlazingArenaChallengeCell:updateChallengeCell(arg_3_1, arg_3_2)
	self._info = arg_3_1

	if arg_3_1.isRobot and not arg_3_1.formations then
		self._info = var_0_1:combineAndGetNetRobotInfo(arg_3_1)
	end

	if not self._info.formations and var_0_1:isSkipFormation() then
		g.core.network.GameNetProxy:send_C2S_Formation_GetOther({
			target_id = self._info.id,
			tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA
		})
	end

	if arg_3_1.isRobot then
		self:_updateUIWithRobot()
	else
		self:_updateUIWithBlazingArenaUnit()
	end

	local var_3_0 = var_0_1:getCurRank()

	self.m_isSweepController:setSelectedIndex((var_3_0 ~= 0 or nil) and var_3_0 < arg_3_1.rank and 1 or 0)
end

function BlazingArenaChallengeCell:_updateUIWithRobot()
	self.m_lvText:setText(g.core.lang:get(2052, {
		level = self._info.userLv
	}))
	self.m_serverNameText:setText(g.core.platform.ServerListProxy:getSelectedServer().name)
	self.m_nameText:setText(self._info.name)
	self.m_picComp:getChild("icon"):setURL(var_0_0:getKnightPictorialBook(var_0_1:getPlayerPlayerPaintedId(self._info)))
	self:updateBaseView()
end

function BlazingArenaChallengeCell:_updateUIWithBlazingArenaUnit()
	if self._info.isRobot then
		return
	end

	local var_5_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._info.id)

	if not var_5_0 then
		self.m_lvText:setText("")
		self.m_serverNameText:setText("")
		self.m_nameText:setText("")
	else
		self.m_lvText:setText(g.core.lang:get(2052, {
			level = var_5_0.level
		}))
		self.m_serverNameText:setText(var_5_0.server_name)
		self.m_nameText:setText(var_5_0.name)
		self.m_picComp:getChild("icon"):setURL(var_0_0:getKnightPictorialBook(var_0_1:getPlayerPlayerPaintedId(self._info, var_5_0)))
	end

	self:updateBaseView()
end

function BlazingArenaChallengeCell:updateBaseView()
	local var_6_0 = math.min(self._info.rank, var_0_1:getMaxRankNum())
	local var_6_1 = 205
	local var_6_2 = 56

	if var_6_0 > 3 and var_6_0 <= 99 then
		var_6_2 = 48

		if var_6_0 > 9 then
			var_6_1 = 206
		end
	elseif var_6_0 > 99 and var_6_0 <= 999 then
		var_6_2 = 38
		var_6_1 = 202
	elseif var_6_0 > 999 then
		var_6_2 = 28
		var_6_1 = 200
	end

	self.m_rankText:setFontSize(var_6_2)
	self.m_rankText:setPosition(var_6_1, self.m_rankText:getPosition().y)
	self.m_rankText:setText(var_6_0)
	self.m_powerNumText:setText(self._info.fightValue)
	self.m_rankController:setSelectedIndex((var_6_0 <= 3 or nil) and var_6_0 - 1)
end

function BlazingArenaChallengeCell:isChallengeTimeOut()
	local var_7_0 = g.core.config.shop_score_info.get(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.BLAZING_ARENA_TOKEN)

	return g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_ITEM,
		value = g.core.common.Goods.ITEM.TYPE_BLAZING_ARENA_TOKEN,
		shopId = g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.BLAZING_ARENA_TOKEN
	}).size == 0 and math.max(math.min(g.core.model.User.shopData:getBuyLimitLeft(var_7_0), (math.floor(g.core.model.User.bagData:getOwnNum(var_7_0.price_type_1, var_7_0.price_value_1) / g.core.model.User.shopData:getBuyItemPrice(var_7_0, 1)))), 0) == 0
end

function BlazingArenaChallengeCell:_onS2CFormationGetOther()
	local var_8_0 = g.core.model.User.blazingArenaData:getOtherFormationData(self._info.id)

	self._info.formations = var_8_0
	self._rivalData = var_8_0
end

function BlazingArenaChallengeCell:_onClickSelf()
	if not var_0_1:isInActivityPlayTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(431423))

		return
	end

	if var_0_1:getAttackTimes() < 1 then
		if self:isChallengeTimeOut() then
			g.core.module.ModuleManager:tip(g.core.lang:get(308651))

			return
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
			type = g.core.common.Goods.TYPE_ITEM,
			value = g.core.common.Goods.ITEM.TYPE_BLAZING_ARENA_TOKEN,
			shopId = g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.BLAZING_ARENA_TOKEN
		}), {
			touchDisappear = true
		})

		return
	end

	if not var_0_1:isSkipFormation() then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.blazingArena.view.pop.BlazingArenaChallengeConfirmPop").new(self._info), {
			touchDisappear = false,
			ignoreTouch = false
		})
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Wuzhuang_GetMenuSlide)
	else
		self:_checkEnterBattle()
	end
end

function BlazingArenaChallengeCell:_checkEnterBattle()
	self._challengeData = self._info
	self._uid = self._challengeData.id

	if not self._challengeData then
		return
	end

	self._rivalData = self._challengeData.formations

	if not self._info.isRobot and not self._rivalData then
		g.core.network.GameNetProxy:send_C2S_Formation_GetOther({
			target_id = self._info.id,
			tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA
		})
		g.core.module.ModuleManager:tip(g.core.lang:get(431428))

		return
	elseif self._info.isRobot and not self._rivalData then
		self._info = var_0_1:combineAndGetNetRobotInfo(self._info)
		self._challengeData = self._info
		self._rivalData = self._challengeData.formations
	end

	if not var_0_1:isInActivityPlayTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(431409))

		return
	end

	if var_0_1:getAttackTimes() < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(431410))

		return
	end

	if not var_0_1:isFormationValid() then
		g.core.module.ModuleManager:tip(g.core.lang:get(411038))

		return
	end

	if #var_0_1:getAllExpiredMember().typeList > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(431414))

		return
	end

	if var_0_1:checkCanSendBattle() then
		g.core.network.GameNetProxy:send_C2S_BlazingArena_ChallengeBegin({
			rank = self._challengeData.rank,
			id = self._uid
		})
		var_0_1:setEnemyFormations(self._rivalData)
		var_0_1:saveLastRank()
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_OPEN_ASSISTANT)
end

return BlazingArenaChallengeCell
