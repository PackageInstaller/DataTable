class = var_0_10000

local var_0_0 = var_0_10000("GameHallListPanel")
local var_0_1 = false

var_0_0.ScrollPosition = nil

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0.content = var_1_10003(arg_1_0._tf, "ad/viewport/content")
	findTF = var_3
	arg_1_0.listTpl = var_3(arg_1_0.content, "listTpl")
	setActive = var_3

	var_3(arg_1_0.listTpl, false)

	arg_1_0.gameRoomDatas = {}
	ipairs = var_3
	pg = var_5

	for iter_1_0, iter_1_1 in var_3(var_5.game_room_template.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.game_room_template[iter_1_1].unlock_time
		pg = var_1_10009
		var_1_10011 = var_1_10009.TimeMgr.GetInstance()
		var_1_10009 = var_1_10009.Table2ServerTime(var_1_10011, {
			year = var_1_10008[1][1],
			month = var_1_10008[1][2],
			day = var_1_10008[1][3],
			hour = var_1_10008[2][1],
			min = var_1_10008[2][2],
			sec = var_1_10008[2][3]
		})
		pg = var_1_10010

		local var_1_0 = var_1_10010.TimeMgr.GetInstance()

		if var_1_10009 < var_1_10010.GetServerTime(var_1_0) then
			table = var_1_10011
			var_1_10011 = var_1_10011.insert

			local var_1_1 = arg_1_0.gameRoomDatas

			Clone = var_1_10014
			pg = var_1_10016

			var_1_10011(var_1_1, var_1_10014(var_1_10016.game_room_template[iter_1_1]))
		end
	end

	table = var_3

	var_3.sort(arg_1_0.gameRoomDatas, function(arg_2_0, arg_2_1)
		return arg_2_0.order < arg_2_1.order
	end)

	for iter_1_2 = 1, #arg_1_0.gameRoomDatas do
		tf = iter_1_1
		instantiate = var_1_10009
		go = var_1_10011
		iter_1_1 = iter_1_1(var_1_10009(var_1_10011(arg_1_0.listTpl)))

		local var_1_2 = arg_1_0.gameRoomDatas[iter_1_2]

		setParent = var_1_10009

		var_1_10009(iter_1_1, arg_1_0.content)

		setActive = var_1_10009

		var_1_10009(iter_1_1, true)

		var_1_10009 = var_1_2.icon

		local var_1_3 = var_1_2.id

		getProxy = var_1_10011
		GameRoomProxy = var_13

		local var_1_4 = var_1_10011(var_13)

		var_1_10011 = var_1_10011.getRoomScore(var_1_4, var_1_3)
		setActive = var_12
		findTF = var_14

		var_12(var_14(iter_1_1, "empty"), var_1_10011 == 0)

		setActive = var_12
		findTF = var_14

		var_12(var_14(iter_1_1, "total"), var_1_10011 > 0)

		setActive = var_12
		findTF = var_14

		var_12(var_14(iter_1_1, "txtScore"), var_1_10011 > 0)

		local var_1_5

		if var_1_10011 < 10 then
			var_1_5 = "00" .. var_1_10011
		elseif var_1_10011 < 100 then
			var_1_5 = "0" .. var_1_10011
		else
			var_1_5 = "" .. var_1_10011
		end

		setText = var_13
		findTF = var_15

		var_13(var_15(iter_1_1, "txtScore"), var_1_5)

		setImageSprite = var_13
		findTF = var_15

		local var_1_6 = var_15(iter_1_1, "mask/gameIcon")

		LoadSprite = var_16

		var_13(var_1_6, var_16("gamehallicon/" .. var_1_10009), true)

		onButton = var_13

		local var_1_7 = arg_1_0._event
		local var_1_8 = iter_1_1

		local function var_1_9()
			var_0_0.ScrollPosition = arg_1_0.content.anchoredPosition

			local var_3_0 = arg_1_0._event
			local var_3_1 = var_0.emit

			GameHallMediator = var_2_10003

			var_3_1(var_3_0, var_2_10003.OPEN_MINI_GAME, var_1_2)

			return
		end

		SFX_CANCEL = var_18

		var_13(var_1_7, var_1_8, var_1_9, var_18)
	end

	return
end

function var_0_0.setVisible(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0._tf, arg_4_1)

	if arg_4_1 then
		getProxy = var_1_10002
		GameRoomProxy = var_4

		local var_4_0 = var_1_10002(var_4)

		if var_2.ticketMaxTip(var_4_0) then
			GameRoomProxy = var_1_10003

			if not var_1_10003.ticket_remind then
				GameRoomProxy = var_3
				var_3.ticket_remind = true
				pg = var_3

				local var_4_1 = var_3.MsgboxMgr.GetInstance()

				var_3.ShowMsgBox(var_4_1, {
					content = var_2,
					onYes = function()
						return
					end,
					onNo = function()
						local var_6_0 = arg_4_0

						var_0.setVisible(var_6_0, false)

						return
					end
				})
			end
		end

		if var_0_0.ScrollPosition then
			arg_4_0.content.anchoredPosition = var_0_0.ScrollPosition
		end
	end

	return
end

function var_0_0.getVisible(arg_7_0)
	isActive = var_1_10001

	return var_1_10001(arg_7_0._tf)
end

function var_0_0.dispose(arg_8_0)
	return
end

return var_0_0
