local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.dungeonData
local var_0_3 = g.core.const.ConstMgr.DungeonConst
local DungeonBattleInfoPop = class("DungeonBattleInfoPop", require("app.fairyGUI.dungeon.UI_DungeonBattleInfoPop"), function()
	return fgui.GComponent:create({
		resName = "DungeonBattleInfoPop",
		pkgPath = "ui/dungeon/dungeon",
		pkgName = "dungeon"
	})
end)

function DungeonBattleInfoPop:ctor(arg_2_1)
	self:getView():setSize(display.width, display.height)

	self._monsterId = arg_2_1
	self._isEnterBattle = false
	self._isClosed = false

	self.m_closePanel:addClickListener(handler(self, self._onClickClose))
	self:_updateBattleView()
	var_0_0:dispatchEvent(var_0_1.EVENT_GUIDE_WAIT)
	var_0_0:dispatchEvent(var_0_1.EVENT_GUIDE_READY)
end

function DungeonBattleInfoPop:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEBEGIN, self._onRcvBattleBegin, self)
	var_0_0:addEventListener(var_0_1.EVENT_DUNGEON_STAGE_TO_BATTLE_FAILED, self._onRcvBattleBeginFailed, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_DUNGEON_RESETCHALLENGECOUNT, self._onRcvResetCount, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_DUNGEON_FASTCHALLENGESTAGE, self._onRcvResetCount, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_ITEM_USE, self._onRcvResetCount, self)
	var_0_0:addEventListener(var_0_1.EVENT_RET_ERROR, self._onRetError, self)
	self.m_topBarComp:setResInfoById(42)
end

function DungeonBattleInfoPop:_updateBattleView()
	if self._monsterId then
		var_0_2:checkResetData()
		self.m_rightBattleInfo:updateComp(self._monsterId)
	end
end

function DungeonBattleInfoPop:_onRcvBattleBegin(arg_5_1, arg_5_2, arg_5_3)
	self.m_rightBattleInfo:onRecvBattleMsgAndPlayAction(arg_5_3)
end

function DungeonBattleInfoPop:_onRcvBattleBeginFailed(arg_6_1, arg_6_2, arg_6_3)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	var_0_0:dispatchEvent(var_0_1.EVENT_FIGHT_SERVER_BACK_ERROR)
	var_0_0:dispatchEvent(var_0_1.EVENT_GUIDE_WAIT)
	var_0_0:dispatchEvent(var_0_1.EVENT_GUIDE_READY)
end

function DungeonBattleInfoPop:_onRcvResetCount()
	self.m_rightBattleInfo:updateChallengeState()
end

function DungeonBattleInfoPop:_onRetError(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_3 == var_0_3.ERROR_MSG_ID then
		self:_onClickClose()
	end
end

function DungeonBattleInfoPop:receiveCompEvent(arg_9_1, arg_9_2)
	if arg_9_1 == "ENTER_BATTLE_CLOSE_BATTLEINFOPOP" then
		self._isEnterBattle = true

		self:dispatchCompEvent("DungeonMonsterComp_HIDE_BATTLE_COMP", {
			isEnterBattle = true
		})
		self:removeSelf()
	end
end

function DungeonBattleInfoPop:_onClickClose()
	if not self._isClosed then
		self._isClosed = true

		self.m_closePanel:setTouchable(false)
		self.m_rightBattleInfo:setTouchable(false)
		self.m_rightBattleInfo:hideAction(handler(self, function()
			self:dispatchCompEvent("DungeonMonsterComp_HIDE_BATTLE_COMP")
			self:removeSelf()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GOLD_SAVING_EXIT_FLUSH)
		end))
	end
end

return DungeonBattleInfoPop
