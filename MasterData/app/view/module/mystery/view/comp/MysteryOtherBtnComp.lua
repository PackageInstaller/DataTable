local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local BattleConst = require("app.view.battle.const.BattleConst")
local MysteryOtherBtnComp = class("MysteryOtherBtnComp", require("app.fairyGUI.mystery.UI_MysteryOtherBtnComp"))

function MysteryOtherBtnComp:ctor()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_attackBtn:addClickListener(handler(self, self._onAttackBtnClick))
end

function MysteryOtherBtnComp:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_FRIEND_DUEL, handler(self, self._onDuel), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GET_USER_DETAIL_INFO, handler(self, self._onPlayerInfo), self)
end

function MysteryOtherBtnComp:updateOtherBtnComp(arg_3_1)
	self._userId = arg_3_1:getBindID()
end

function MysteryOtherBtnComp:_onDetailBtnClick()
	g.core.network.GameNetProxy:send_C2S_GetUserDetailInfo({
		tp = 0,
		player_id = self._userId
	})
end

function MysteryOtherBtnComp:_onAttackBtnClick()
	g.core.network.GameNetProxy:send_C2S_Friend_Duel({
		id = self._userId
	})
end

function MysteryOtherBtnComp:_onDuel(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:dispatchCompEvent("MYSTERY_OTHER_OPE_COMP_OUT_SCREEN")
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	local var_6_0 = {}

	var_6_0.battle_id = 0
	var_6_0.atk_type = 2
	var_6_0.is_auto = false
	var_6_0.random_seeds = {}

	for iter_6_0 = 1, 50 do
		var_6_0.random_seeds[iter_6_0] = math.random(1000) - 1
	end

	var_6_0.own_teams = {
		arg_6_4.self
	}
	var_6_0.enemy_teams = {
		arg_6_4.enemy
	}

	g.core.battle.BattleProxy:enterBattle({
		soundType = 2,
		noShare = true,
		report = var_6_0,
		type = BattleConst.TYPE_FRIEND_PVP,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		skip = BattleConst.SKIP_TYPE.ACTIVE
	})
end

function MysteryOtherBtnComp:_onPlayerInfo()
	self:dispatchCompEvent("MYSTERY_OTHER_OPE_COMP_OUT_SCREEN")

	if g.core.module.ModuleManager:getCurModule().module == g.view.entrance.MYSTERY_MAIN_LAYER then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			disableJump = true,
			uid = self._userId
		})
	end
end

return MysteryOtherBtnComp
