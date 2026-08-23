local var_0_0 = g.core.model.User.teamBattleData
local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleMapRoomCell = class("TeamBattleMapRoomCell", require("app.fairyGUI.teamBattle.UI_TeamBattleMapRoomCell"))

function TeamBattleMapRoomCell:ctor()
	self._roomInfo = nil

	self.m_swithBtn:addClickListener(handler(self, self._onClickSwitchBtn))
end

function TeamBattleMapRoomCell:updateRoomCell(arg_2_1)
	self.m_tipIcon1:setVisible(false)
	self.m_tipIcon2:setVisible(false)
	self.m_tipIcon3:setVisible(false)
	self.m_tipIcon4:setVisible(false)

	self._roomInfo = arg_2_1

	self.m_nameText:setText(arg_2_1:getCfg().name)

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs((arg_2_1:getAllTiled())) do
		local var_2_1 = iter_2_1:getEventInfo()

		if true and var_2_1 then
			local var_2_2 = var_2_1:getState() ~= TeamBattleConst.EVENT_STATE.FINISH
			local var_2_3 = var_2_1:getEventType()

			if var_2_3 == TeamBattleConst.EVENT_TYPE.GAME_DART or var_2_3 == TeamBattleConst.EVENT_TYPE.GAME_METEOR_SHOWER or var_2_3 == TeamBattleConst.EVENT_TYPE.GAME_TURN_CARD then
				var_2_3 = TeamBattleConst.EVENT_TYPE.GAME_DART
				var_2_2 = var_2_2 and var_2_1:getState() ~= TeamBattleConst.EVENT_STATE.WAIT_TRIGGER
			end

			if var_2_2 then
				var_2_0[var_2_3] = iter_2_1:getCfg().id
			end
		end
	end

	self:_updateEventIcon(var_2_0)
	self:_updateUserIndex()
end

function TeamBattleMapRoomCell:_updateEventIcon(arg_3_1)
	local var_3_0 = 1

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		self["m_tipIcon" .. var_3_0]:setVisible(false)

		if iter_3_0 == TeamBattleConst.EVENT_TYPE.BUFF then
			self["m_tipIcon" .. var_3_0]:setURL("ui://teamBattle/icon_hjtj_buff")

			var_3_0 = var_3_0 + 1

			self["m_tipIcon" .. var_3_0]:setVisible(true)
		elseif iter_3_0 == TeamBattleConst.EVENT_TYPE.GAME_DART then
			self["m_tipIcon" .. var_3_0]:setURL("ui://teamBattle/icon_hjtj_game")

			var_3_0 = var_3_0 + 1

			self["m_tipIcon" .. var_3_0]:setVisible(true)
		elseif iter_3_0 == TeamBattleConst.EVENT_TYPE.REVIVAL then
			self["m_tipIcon" .. var_3_0]:setURL("ui://teamBattle/icon_hjtj_fuhuo")

			var_3_0 = var_3_0 + 1

			self["m_tipIcon" .. var_3_0]:setVisible(true)
		elseif iter_3_0 == TeamBattleConst.EVENT_TYPE.RECOVER then
			self["m_tipIcon" .. var_3_0]:setURL("ui://teamBattle/icon_hjtj_zhiliao")

			var_3_0 = var_3_0 + 1

			self["m_tipIcon" .. var_3_0]:setVisible(true)
		end
	end
end

function TeamBattleMapRoomCell:_onClickSwitchBtn()
	self:dispatchCompEvent("switch_room", {
		roomId = self._roomInfo:getCfg().room
	})
end

function TeamBattleMapRoomCell:_updateUserIndex()
	local var_5_0 = false
	local var_5_1 = var_0_0:getTeamUpData():getMyTeam().members

	var_5_1 = var_5_1 or {}

	for iter_5_0 = 1, 3 do
		if var_5_1[iter_5_0] and var_5_1[iter_5_0] > 0 then
			local var_5_2 = var_0_0:getMapData():getPlayerStruct(var_5_1[iter_5_0])

			if var_5_2 then
				local var_5_3 = var_5_2:getRoomId() == self._roomInfo:getMapRoomId()

				self["m_user" .. iter_5_0]:setVisible(var_5_3)

				var_5_0 = var_5_0 or var_5_3
			else
				self["m_user" .. iter_5_0]:setVisible(false)
			end
		else
			self["m_user" .. iter_5_0]:setVisible(false)
		end
	end

	self.m_hasUserController:setSelectedIndex(var_5_0 and 1 or 0)
end

return TeamBattleMapRoomCell
