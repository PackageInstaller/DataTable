local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local var_0_1 = g.core.model.User.teamBattleData
local TeamBattleMapRoomPop = class("TeamBattleMapRoomPop", require("app.fairyGUI.teamBattle.UI_TeamBattleMapRoomPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/teamBattle/teamBattle",
		resName = "TeamBattleMapRoomPop",
		pkgName = "teamBattle"
	}, ...)
end)

function TeamBattleMapRoomPop:ctor()
	self:showAtCenter()

	self._roomList = var_0_1:getMapData():getAllUnlockRoom()

	self:_initView()
end

function TeamBattleMapRoomPop:_initView()
	self.m_roomList:setVirtual(self)
	self.m_roomList:setItemRenderer(handler(self, self._onRoomItemRender))
	self.m_closeBtn:addClickListener(handler(self, self._onCloseBtnClicked))
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		isLoop = false,
		anim = "play_fjlist",
		remove = true,
		name = "eff_ui_teamBattle_popBg"
	})
end

function TeamBattleMapRoomPop:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_ENTERROOM, handler(self, self._onS2CTeamBattleEnterRoom), self)
	self.m_roomList:setNumItems(#self._roomList)
end

function TeamBattleMapRoomPop:_onRoomItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateRoomCell(self._roomList[arg_5_1 + 1])
end

function TeamBattleMapRoomPop:_onCloseBtnClicked()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TeamBattleMapRoomPop:_onS2CTeamBattleEnterRoom(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TeamBattleMapRoomPop:receiveCompEvent(arg_8_1, arg_8_2)
	if not self:_checkedSelfRoom() then
		g.core.module.ModuleManager:tip(g.core.lang:get(427138))

		return
	end

	if arg_8_1 == "switch_room" then
		g.core.network.GameNetProxy:send_C2S_TeamBattle_EnterRoom({
			tp = 2,
			value = arg_8_2.roomId
		})

		return true
	end
end

function TeamBattleMapRoomPop:_checkedSelfRoom()
	local var_9_0 = var_0_1:getMapData():getRoomStructByRoomId(var_0_1:getMapData():getPlayerStruct():getRoomId())

	if var_9_0:getBirthTiled() then
		if var_9_0:getGuardTiled():getEventInfo():getState() ~= TeamBattleConst.EVENT_STATE.FINISH then
			return false
		end
	end

	return true
end

return TeamBattleMapRoomPop
