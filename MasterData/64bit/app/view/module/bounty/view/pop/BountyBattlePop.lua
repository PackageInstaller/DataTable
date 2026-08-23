local var_0_0 = g.core.const.ConstMgr.BountyConst
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local BountyBattlePop = class("BountyBattlePop", require("app.fairyGUI.bounty.UI_BountyBattlePop"), function()
	return fgui.GComponent:create({
		resName = "BountyBattlePop",
		pkgPath = "ui/bounty/bounty",
		pkgName = "bounty"
	})
end)

function BountyBattlePop:ctor(arg_2_1)
	self._monster = arg_2_1.monster
	self._shareType = arg_2_1.shareType

	self:_initPop()
	self:showAtCenter()
end

function BountyBattlePop:_initPop()
	self.m_starComp:initStar({
		gap = 0,
		index = 3,
		style = 1,
		num = 0,
		max = var_0_1.STAR_MAX
	})
end

function BountyBattlePop:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_CHALLENGEBEGIN, handler(self, self._onS2CBountyChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETMONSTERDETAILINFO, handler(self, self._onS2CBountyGetMonsterDetailInfo), self)
end

function BountyBattlePop:onLoad()
	self:_addCustomListener()
	self:_updateView()
end

function BountyBattlePop:_updateView()
	self.m_knightPicComp:updateKnight({
		useMidKnight = true,
		baseId = self._monster:getAdvanceId()
	})
	self.m_knightPicComp:setAlphaLRDistance(250)
	self.m_formationComp:updateComp(self._monster)
	self.m_starComp:setStarNum(self._monster:getStarNum())
	self.m_nameText:setText(self._monster:getName())

	if not self._monster:isDetailMonster() then
		g.core.network.GameNetProxy:send_C2S_Bounty_GetMonsterDetailInfo({
			id = self._monster:getId(),
			share_type = self._shareType
		})
	end
end

function BountyBattlePop:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "click_battle_btn" then
		self:_sendEnterBattle()

		return true
	elseif arg_7_1 == "click_formation_btn" then
		self:_enterFormation()

		return true
	end
end

function BountyBattlePop:_sendEnterBattle()
	g.core.network.GameNetProxy:send_C2S_Bounty_ChallengeBegin({
		id = self._monster:getId(),
		share_type = self._shareType
	})
end

function BountyBattlePop:_enterFormation()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function BountyBattlePop:onCancelCallback()
	self.m_backTransition:play(handler(self, self._onCloseSelf))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Wujing_YouhuatiMenu_Slide)
end

function BountyBattlePop:_onCloseSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function BountyBattlePop:_showErrorRetTip(arg_12_1)
	local var_12_0

	if arg_12_1 == var_0_0.ERROR_RET_CODE.MONSTER_DEFEATED then
		var_12_0 = 422561
	elseif arg_12_1 == var_0_0.ERROR_RET_CODE.ACTIVITY_EXPIRED then
		var_12_0 = 422562
	elseif arg_12_1 == var_0_0.ERROR_RET_CODE.MONSTER_EXPIRED or arg_12_1 == var_0_0.ERROR_RET_CODE.MONSTER_NOT_EXIST then
		var_12_0 = 422563
	elseif arg_12_1 == var_0_0.ERROR_RET_CODE.MONSTER_SHARE_CHANGED then
		var_12_0 = 422564
	elseif arg_12_1 == var_0_0.ERROR_RET_CODE.SHARE_GUILD_CHANGED then
		var_12_0 = 422565
	end

	if var_12_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(var_12_0))
	end
end

function BountyBattlePop:_onS2CBountyChallengeBegin(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_4.error_ret then
		self:_showErrorRetTip(arg_13_4.error_ret)
		self:dispatchCompEvent("bounty_battle_error", {
			ret = arg_13_4.error_ret
		})
		self:_onCloseSelf()

		return
	end

	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		soundType = 5,
		canSkip = true,
		battle_id = arg_13_4.battle_id,
		type = BattleConst.TYPE_BOUNTY,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVE
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function BountyBattlePop:_onS2CBountyGetMonsterDetailInfo(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_4.error_ret then
		self:_showErrorRetTip(arg_14_4.error_ret)
		self:dispatchCompEvent("bounty_battle_error", {
			ret = arg_14_4.error_ret
		})
		self:_onCloseSelf()

		return
	end

	self:_updateView()
end

return BountyBattlePop
