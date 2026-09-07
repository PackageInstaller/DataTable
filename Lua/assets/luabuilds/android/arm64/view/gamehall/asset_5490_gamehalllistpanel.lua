local GameHallListPanel = class("GameHallListPanel")

GameHallListPanel.ScrollPosition = nil

function GameHallListPanel:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	self.content = findTF(self._tf, "ad/viewport/content")
	self.listTpl = findTF(self.content, "listTpl")

	setActive(self.listTpl, false)

	self.gameRoomDatas = {}

	for iter_1_0, iter_1_1 in ipairs(pg.game_room_template.all) do
		if pg.TimeMgr.GetInstance():Table2ServerTime({
			year = pg.game_room_template[iter_1_1].unlock_time[1][1],
			month = pg.game_room_template[iter_1_1].unlock_time[1][2],
			day = pg.game_room_template[iter_1_1].unlock_time[1][3],
			hour = pg.game_room_template[iter_1_1].unlock_time[2][1],
			min = pg.game_room_template[iter_1_1].unlock_time[2][2],
			sec = pg.game_room_template[iter_1_1].unlock_time[2][3]
		}) < pg.TimeMgr.GetInstance():GetServerTime() then
			table.insert(self.gameRoomDatas, Clone(pg.game_room_template[iter_1_1]))
		end
	end

	table.sort(self.gameRoomDatas, function(arg_2_0, arg_2_1)
		return arg_2_0.order < arg_2_1.order
	end)

	for iter_1_2 = 1, #self.gameRoomDatas do
		local var_1_1 = tf(instantiate(go(self.listTpl)))
		local var_1_2 = self.gameRoomDatas[iter_1_2]

		setParent(var_1_1, self.content)
		setActive(var_1_1, true)

		local var_1_3 = self.gameRoomDatas[iter_1_2].icon
		local var_1_4 = getProxy(GameRoomProxy):getRoomScore(self.gameRoomDatas[iter_1_2].id)

		setActive(findTF(var_1_1, "empty"), var_1_4 == 0)
		setActive(findTF(var_1_1, "total"), var_1_4 > 0)
		setActive(findTF(var_1_1, "txtScore"), var_1_4 > 0)
		setText(findTF(var_1_1, "txtScore"), var_1_4 < 10 and "00" .. var_1_4 or var_1_4 < 100 and "0" .. var_1_4 or "" .. var_1_4)
		setImageSprite(findTF(var_1_1, "mask/gameIcon"), LoadSprite("gamehallicon/" .. var_1_3), true)
		onButton(self._event, var_1_1, function()
			GameHallListPanel.ScrollPosition = self.content.anchoredPosition

			self._event:emit(GameHallMediator.OPEN_MINI_GAME, var_1_2)

			return
		end, SFX_CANCEL)
	end

	return
end

function GameHallListPanel:setVisible(arg_4_1)
	setActive(self._tf, arg_4_1)

	if arg_4_1 then
		local var_4_0 = getProxy(GameRoomProxy):ticketMaxTip()

		if var_4_0 and not GameRoomProxy.ticket_remind then
			GameRoomProxy.ticket_remind = true

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = var_4_0,
				onYes = function()
					return
				end,
				onNo = function()
					self:setVisible(false)

					return
				end
			})
		end

		if GameHallListPanel.ScrollPosition then
			self.content.anchoredPosition = GameHallListPanel.ScrollPosition
		end
	end

	return
end

function GameHallListPanel:getVisible()
	return isActive(self._tf)
end

function GameHallListPanel:dispose()
	return
end

return GameHallListPanel
