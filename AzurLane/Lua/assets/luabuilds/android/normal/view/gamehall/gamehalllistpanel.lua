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
	pg = var_4

	for iter_1_0, iter_1_1 in var_3(var_4.game_room_template.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.game_room_template[iter_1_1].unlock_time
		pg = var_1_10009

		local var_1_0 = var_1_10009.TimeMgr.GetInstance()

		var_1_10009 = var_1_10009.Table2ServerTime(var_1_0, {
			year = var_1_10008[1][1],
			month = var_1_10008[1][2],
			day = var_1_10008[1][3],
			hour = var_1_10008[2][1],
			min = var_1_10008[2][2],
			sec = var_1_10008[2][3]
		})
		pg = var_1_0

		local var_1_1 = var_1_0.TimeMgr.GetInstance()

		if var_1_10009 < var_10.GetServerTime(var_1_1) then
			table = var_1_1

			local var_1_2 = var_1_1.insert

			var_1_10012 = arg_1_0.gameRoomDatas
			Clone = var_1_10013
			pg = var_1_10014

			var_1_2(var_1_10012, var_1_10013(var_1_10014.game_room_template[iter_1_1]))
		end
	end

	table = var_3

	var_3.sort(arg_1_0.gameRoomDatas, function(arg_2_0, arg_2_1)
		return arg_2_0.order < arg_2_1.order
	end)

	for iter_1_2 = 1, #arg_1_0.gameRoomDatas do
		tf = iter_1_1
		instantiate = var_1_10008
		go = var_1_10009
		iter_1_1 = iter_1_1(var_1_10008(var_1_10009(arg_1_0.listTpl)))
		var_1_10008 = arg_1_0.gameRoomDatas[iter_1_2]
		setParent = var_1_10009

		var_1_10009(iter_1_1, arg_1_0.content)

		setActive = var_1_10009

		var_1_10009(iter_1_1, true)

		var_1_10009 = var_1_10008.icon

		local var_1_3 = var_1_10008.id

		getProxy = var_11
		GameRoomProxy = var_1_10012
		var_1_10012 = var_11(var_1_10012)

		local var_1_4 = var_11.getRoomScore(var_1_10012, var_1_3)

		setActive = var_1_10012
		findTF = var_13

		var_1_10012(var_13(iter_1_1, "empty"), var_1_4 == 0)

		setActive = var_1_10012
		findTF = var_13

		var_1_10012(var_13(iter_1_1, "total"), var_1_4 > 0)

		setActive = var_1_10012
		findTF = var_13

		var_1_10012(var_13(iter_1_1, "txtScore"), var_1_4 > 0)

		var_1_10012 = nil

		if var_1_4 < 10 then
			var_1_10012 = "00" .. var_1_4
		elseif var_1_4 < 100 then
			var_1_10012 = "0" .. var_1_4
		else
			var_1_10012 = "" .. var_1_4
		end

		setText = var_13
		findTF = var_14

		var_13(var_14(iter_1_1, "txtScore"), var_1_10012)

		setImageSprite = var_13
		findTF = var_14

		local var_1_5 = var_14(iter_1_1, "mask/gameIcon")

		LoadSprite = var_15

		var_13(var_1_5, var_15("gamehallicon/" .. var_1_10009), true)

		onButton = var_13

		local var_1_6 = arg_1_0._event
		local var_1_7 = iter_1_1

		local function var_1_8()
			var_0_0.ScrollPosition = arg_1_0.content.anchoredPosition

			local var_3_0 = arg_1_0._event
			local var_3_1 = var_0.emit

			GameHallMediator = var_2_10002

			var_3_1(var_3_0, var_2_10002.OPEN_MINI_GAME, var_1_10008)

			return
		end

		SFX_CANCEL = var_17

		var_13(var_1_6, var_1_7, var_1_8, var_17)
	end

	return
end

function var_0_0.setVisible(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0._tf, arg_4_1)

	if arg_4_1 then
		getProxy = var_1_10002
		GameRoomProxy = var_3

		local var_4_0 = var_1_10002(var_3)

		if var_2.ticketMaxTip(var_4_0) then
			GameRoomProxy = var_4_0

			if not var_4_0.ticket_remind then
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
