local var_0_0 = 6
local var_0_1 = 4
local var_0_2 = g.core.config.knight_info
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local var_0_4 = g.core.model.User.mineData
local MineFightPop = class("MineFightPop", require("app.fairyGUI.mine.UI_MineFightPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/mine/mine",
		resName = "MineFightPop",
		pkgName = "mine",
		isFullScreen = true
	})
end)

function MineFightPop:ctor(arg_2_1)
	self._user = arg_2_1.data.user
	self._cityStruct = arg_2_1.struct
	self._cityCfg = self._cityStruct:getCfg()
	self._params = arg_2_1.data
	self._knightStructArr = self:_getLineUpKnights(self._user)

	self.m_zs1Loader:setURL("pic/base_new/arena/pic_zhuangshi1.png")
	self.m_zs2Loader:setURL("pic/base_new/arena/pic_zhuangshi2.png")
	self.m_lineUpList:setVirtual()
	self.m_lineUpList:setItemRenderer(handler(self, self._onRenderLineUpList))
	self.m_closePnl:addClickListener(handler(self, self._onCloseClick))
	self.m_fightBtn:addClickListener(handler(self, self._onClickBattle))
	self.m_lineupBtn:addClickListener(handler(self, self._onClickLineUp))
	self.m_enterTransition:play()
	self:_updateView()
end

function MineFightPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_DETAIL_INFO, self._onRcvGetUserInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_ATTACKUSERBEGIN, self._onRcvAttackBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINE_PLAYER_DEAD, self._onRcvDead, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, self._onRcvOpObject, self)
	g.core.network.GameNetProxy:send_C2S_GetUserDetailInfo({
		tp = 0,
		player_id = self._user.id
	})
	self.m_lineUpList:setNumItems(var_0_0)
	self.m_knightPicComp:updateKnight({
		snapshot = self._user
	})
	self.m_nameTxt:setText(self._user.name)
end

function MineFightPop:_onClickBattle()
	self._isBlitz = false

	local var_4_0 = g.core.config.mine_city_info.get(self._cityCfg.mine_parameter)

	if g.core.model.User.mineData:getBattleCostById(self._cityCfg.id) > g.core.model.User.bagData:getOwnNum(var_4_0.attack_spend_type, var_4_0.attack_spend_value) then
		require("app.view.base.infoPop.BasePlayNumPop").createBuy(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.ARMY_TOKEN)
	elseif self:checkShieldInTime(self._params.shield_end_time or 0) and not var_0_4:isNeedShieldFightNotify() then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(408408),
			desc = g.core.lang:get(307554),
			onConfirm = function()
				self:onEnterBattleReq()
			end,
			onCheck = function(arg_6_0)
				var_0_4:setShieldFightNotify(arg_6_0)
			end,
			tip = {
				isChecked = false,
				txt = g.core.lang:get(201569)
			}
		}))
	else
		self:onEnterBattleReq()
	end
end

function MineFightPop:onEnterBattleReq()
	if self._isEnteringBattle then
		return
	end

	self._isEnteringBattle = true

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MINE_ENTER_BATTLE)
	g.core.network.GameNetProxy:send_C2S_Mine_AttackUserBegin({
		skip_battle = false,
		user_id = self._user.id
	})
end

function MineFightPop:_onRcvAttackBegin(arg_8_1, arg_8_2, arg_8_3)
	self._isEnteringBattle = false

	if self._isBlitz then
		return
	end

	if arg_8_3.ret ~= g.core.network.proto.RET_OK then
		g.core.module.ModuleManager:tip(g.core.lang:get(307549))
		self:removeSelf()

		return
	end

	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		soundType = 2,
		bgId = 125,
		battle_id = arg_8_3.battle_id,
		type = BattleConst.TYPE_MINE,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVP
	})
	self:removeSelf()
end

function MineFightPop:_onRcvDead()
	if not self._isEnteringBattle then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.MINE)
	end
end

function MineFightPop:_onRcvOpObject()
	self:_updateView()
end

function MineFightPop:_onRcvGetUserInfo(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_3.player.formation.unite_token_id

	self.m_powerTxt:setText(arg_11_3.player.user.fight_value)

	if arg_11_3.player.user.guild_id and arg_11_3.player.user.guild_id > 0 then
		self.m_serverNameTxt:setText(g.core.lang:get(307522, {
			serverName = arg_11_3.player.user.server_name,
			guildName = arg_11_3.player.user.guild_name
		}))
	else
		self.m_serverNameTxt:setText(g.core.lang:get(307523, {
			serverName = arg_11_3.player.user.server_name
		}))
	end

	self:_updateTokenFormation(var_11_0, arg_11_3.player.unite_tokens)
	self.m_forceTxt:setText(self._params.power .. "/" .. g.core.config.mine_parameter_info.indexOf(1).max_hp)
end

function MineFightPop:_onClickLineUp()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function MineFightPop:_updateTokenFormation(arg_13_1, arg_13_2)
	arg_13_2 = arg_13_2 or {}

	local var_13_0 = arg_13_1 or {}
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_2) do
		var_13_1[iter_13_1.id] = iter_13_1
	end

	for iter_13_2 = 1, var_0_1 do
		if var_13_0[iter_13_2] and var_13_0[iter_13_2] > 0 then
			self["m_skillComp" .. iter_13_2]:update({
				baseId = var_13_1[var_13_0[iter_13_2]].base_id
			})
		else
			self["m_skillComp" .. iter_13_2]:update({
				show = true
			})
		end
	end
end

function MineFightPop:_updateView()
	local var_14_0 = g.core.config.mine_city_info.get(self._cityCfg.mine_parameter)

	self.m_costComp:updateByTVS({
		type = var_14_0.attack_spend_type,
		value = var_14_0.attack_spend_value,
		size = g.core.model.User.mineData:getBattleCostById(self._cityCfg.id)
	})
end

function MineFightPop:_getLineUpKnights(arg_15_1)
	local var_15_1 = arg_15_1.knights or {}
	local var_15_2 = {}

	for iter_15_0 = 1, var_0_0 do
		if var_15_1[iter_15_0] and var_15_1[iter_15_0] > 0 then
			local var_15_3 = var_0_2.get(var_15_1[iter_15_0])
			local var_15_4 = KnightStruct.new(var_15_3.advance_id)

			var_15_4:addCfgInfo(var_15_3)

			var_15_2[iter_15_0] = var_15_4
		end
	end

	return var_15_2
end

function MineFightPop:_onRenderLineUpList(arg_16_1, arg_16_2)
	if self._knightStructArr[arg_16_1 + 1] then
		arg_16_2:updateComp(arg_16_1 + 1, {
			struct = self._knightStructArr[arg_16_1 + 1]
		}, true)
	else
		arg_16_2:updateComp(arg_16_1 + 1, nil, true)
	end
end

function MineFightPop:_onCloseClick()
	if self._closing then
		return
	end

	self._closing = true

	self.m_backTransition:play(handler(self, self._onCloseFinish))
end

function MineFightPop:checkShieldInTime(arg_18_1)
	return arg_18_1 >= g.core.common.ServerTime:getTime()
end

function MineFightPop:_onCloseFinish()
	self:removeSelf()
end

return MineFightPop
