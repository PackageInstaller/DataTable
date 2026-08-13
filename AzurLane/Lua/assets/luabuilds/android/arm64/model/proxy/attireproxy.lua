class = var_0_10000

local var_0_0 = "AttireProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.ATTIREFRAME_UPDATED = "AttireProxy:ATTIREFRAME_UPDATED"
var_0_1.ATTIREFRAME_ADDED = "AttireProxy:ATTIREFRAME_ADDED"
var_0_1.ATTIREFRAME_EXPIRED = "AttireProxy:ATTIREFRAME_EXPIRED"
pg = var_1

local var_0_2 = var_1.item_data_frame

pg = var_0_0

local var_0_3 = var_0_0.item_data_chat

pg = var_3

local var_0_4 = var_3.item_data_battleui
local var_0_5 = false

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.timers = {}
	arg_1_0.expiredChaces = {}
	arg_1_0.data.iconFrames = {}
	arg_1_0.data.chatFrames = {}

	local var_1_0 = arg_1_0.data

	var_1_0.combatUIStyles = {}
	ipairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0(var_0_2.all) do
		if iter_1_1 == 0 then
			local var_1_1 = arg_1_0.data.iconFrames

			IconFrame = var_1_10007
			var_1_1[iter_1_1] = var_1_10007.New({
				end_time = 0,
				id = iter_1_1
			})
		else
			local var_1_2 = arg_1_0.data.iconFrames

			IconFrame = var_1_10007
			var_1_2[iter_1_1] = var_1_10007.New({
				id = iter_1_1
			})
		end
	end

	ipairs = var_1

	for iter_1_2, iter_1_3 in var_1(var_0_3.all) do
		if iter_1_3 == 0 then
			local var_1_3 = arg_1_0.data.chatFrames

			ChatFrame = var_1_10007
			var_1_3[iter_1_3] = var_1_10007.New({
				end_time = 0,
				id = iter_1_3
			})
		else
			local var_1_4 = arg_1_0.data.chatFrames

			ChatFrame = var_1_10007
			var_1_4[iter_1_3] = var_1_10007.New({
				id = iter_1_3
			})
		end
	end

	ipairs = var_1

	for iter_1_4, iter_1_5 in var_1(var_0_4.all) do
		local var_1_5 = arg_1_0.data.combatUIStyles

		CombatUIStyle = var_1_10007
		var_1_5[iter_1_5] = var_1_10007.New({
			id = iter_1_5
		})
	end

	PlayerPrefs = var_1

	local var_1_6 = var_1.GetString("new_auto_unlock_combat_ui")

	pg = var_2

	local var_1_7

	if var_2.gameset.new_auto_unlock_combat_ui.description ~= var_1_6 then
		string = var_1_7
		var_1_7 = var_1_7.split
		pg = iter_1_4
		var_1_7 = var_1_7(iter_1_4.gameset.new_auto_unlock_combat_ui.description, "|")
		ipairs = var_3

		for iter_1_6, iter_1_7 in var_3(var_1_7) do
			tonumber = var_1_10008
			iter_1_7 = var_1_10008(iter_1_7)

			local var_1_8 = arg_1_0.data.combatUIStyles[iter_1_7]

			var_1_10008.setNew(var_1_8)
		end
	end

	PlayerPrefs = var_1_7

	local var_1_9 = var_1_7.SetString
	local var_1_10 = "new_auto_unlock_combat_ui"

	pg = iter_1_5

	var_1_9(var_1_10, iter_1_5.gameset.new_auto_unlock_combat_ui.description)
	arg_1_0:on(11003, function(arg_2_0)
		ipairs = var_2_10001

		for iter_2_0, iter_2_1 in var_2_10001(arg_2_0.icon_frame_list) do
			local var_2_0 = arg_1_0.data.iconFrames[iter_2_1.id]

			var_6.updateData(var_2_0, iter_2_1)

			local var_2_1 = arg_1_0

			var_7.updateAttireFrame(var_2_1, var_6)

			local var_2_2 = arg_1_0

			var_7.addExpiredTimer(var_2_2, var_6)
		end

		ipairs = var_1

		local var_2_3

		if not arg_2_0.chat_frame_list then
			var_2_3 = {}
		end

		for iter_2_2, iter_2_3 in var_1(var_2_3) do
			local var_2_4 = arg_1_0.data.chatFrames[iter_2_3.id]

			var_6.updateData(var_2_4, iter_2_3)

			local var_2_5 = arg_1_0

			var_7.updateAttireFrame(var_2_5, var_6)

			local var_2_6 = arg_1_0

			var_7.addExpiredTimer(var_2_6, var_6)
		end

		ipairs = var_1

		local var_2_7

		if not arg_2_0.battle_ui_list then
			var_2_7 = {}
		end

		for iter_2_4, iter_2_5 in var_1(var_2_7) do
			local var_2_8 = arg_1_0.data.combatUIStyles[iter_2_5]

			var_6.setUnlock(var_2_8)

			local var_2_9 = arg_1_0

			var_7.updateAttireFrame(var_2_9, var_6)

			local var_2_10 = arg_1_0

			var_7.addExpiredTimer(var_2_10, var_6)
		end

		pairs = var_1

		for iter_2_6, iter_2_7 in var_1(arg_1_0.data.combatUIStyles) do
			if not iter_2_7:isOwned() then
				iter_2_7:setLock()
			end
		end

		return
	end)

	if var_0_5 then
		Timer = var_2
		arg_1_0.timer = var_2.New(function()
			local var_3_0 = {}
			local var_3_1 = {
				101,
				102,
				201,
				301
			}

			for iter_3_0 = 1, 5 do
				math = var_2_10006
				var_2_10006 = var_2_10006.random(1, 4)
				Drop = var_2_10007
				var_2_10007 = var_2_10007.New

				local var_3_2 = {
					count = 1
				}

				if iter_3_0 % 2 == 0 then
					DROP_TYPE_ICON_FRAME = var_10

					if not var_10 then
						DROP_TYPE_CHAT_FRAME = var_10
					end

					var_3_2.type = var_10
					var_3_2.id = var_3_1[var_2_10006]
					var_2_10007 = var_2_10007(var_3_2)

					local var_3_3 = arg_1_0

					var_2_10008 = var_2_10008.sendNotification
					GAME = var_2_10011

					var_2_10008(var_3_3, var_2_10011.ADD_ITEM, var_2_10007)

					table = var_2_10008

					var_2_10008.insert(var_3_0, var_2_10007)
				end
			end

			table = var_2

			local var_3_4 = var_2.insert
			local var_3_5 = var_3_0

			Drop = iter_3_0

			local var_3_6 = iter_3_0.New
			local var_3_7 = {
				count = 1000
			}

			DROP_TYPE_RESOURCE = var_2_10008
			var_3_7.type = var_2_10008
			PlayerConst = var_2_10008
			var_3_7.id = var_2_10008.ResGold

			var_3_4(var_3_5, var_3_6(var_3_7))

			local var_3_8 = arg_1_0
			local var_3_9 = var_2.sendNotification

			GAME = var_5

			var_3_9(var_3_8, var_5.ACT_NEW_PT_DONE, {
				awards = var_3_0
			})

			return
		end, 10, 1)

		local var_1_11 = arg_1_0.timer

		var_2.Start(var_1_11)
	end

	return
end

function var_0_1.getDataAndTrophys(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getData()

	if arg_4_1 then
		var_1_10005 = arg_4_0

		arg_4_0.clearNew(var_1_10005)
	end

	getProxy = var_1_10003
	CollectionProxy = var_1_10005

	local var_4_1 = var_1_10003(var_1_10005)

	var_4_0.trophys = var_3.getTrophys(var_4_1)
	getProxy = var_3
	LoveLetterProxy = var_4_1

	local var_4_2 = var_3(var_4_1)

	var_4_0.loveTrophys = var_3.GetTrophyList(var_4_2)

	return var_4_0
end

function var_0_1.clearNew(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.data.iconFrames) do
		iter_5_1:clearNew()
	end

	pairs = var_1

	for iter_5_2, iter_5_3 in var_1(arg_5_0.data.chatFrames) do
		iter_5_3:clearNew()
	end

	pairs = var_1

	for iter_5_4, iter_5_5 in var_1(arg_5_0.data.combatUIStyles) do
		iter_5_5:clearNew()
	end

	pg = var_1

	local var_5_0 = var_1.EasyRedDotMgr.GetInstance()

	var_1.TriggerMarks(var_5_0, "ATTIRE")

	return
end

function var_0_1.getExpiredChaces(arg_6_0)
	local var_6_0 = {}

	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.expiredChaces) do
		table = var_1_10007

		var_1_10007.insert(var_6_0, iter_6_1)
	end

	arg_6_0.expiredChaces = {}

	return var_6_0
end

function var_0_1.getAttireFrame(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	AttireConst = var_1_10004

	if arg_7_1 == var_1_10004.TYPE_ICON_FRAME then
		var_7_0 = arg_7_0.data.iconFrames[arg_7_2]
	else
		AttireConst = var_4

		if arg_7_1 == var_4.TYPE_CHAT_FRAME then
			var_7_0 = arg_7_0.data.chatFrames[arg_7_2]
		else
			AttireConst = var_4

			if arg_7_1 == var_4.TYPE_COMBAT_UI_STYLE then
				var_7_0 = arg_7_0.data.combatUIStyles[arg_7_2]
			end
		end
	end

	return var_7_0
end

function var_0_1.addAttireFrame(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getType()
	local var_8_1 = arg_8_0:getAttireFrame(var_8_0, arg_8_1.id)
	local var_8_2

	if arg_8_1:expiredType() and var_8_1 and not var_8_1:isExpired() then
		var_8_2 = var_8_1:getExpiredTime() + arg_8_1:getConfig("time_second")

		arg_8_1:updateEndTime(var_8_2)
	end

	AttireConst = var_8_2

	local var_8_3

	if var_8_0 == var_8_2.TYPE_ICON_FRAME then
		var_8_3 = arg_8_0.data.iconFrames
		var_8_3[arg_8_1.id] = arg_8_1
	else
		AttireConst = var_8_3

		local var_8_4

		if var_8_0 == var_8_3.TYPE_CHAT_FRAME then
			var_8_4 = arg_8_0.data.chatFrames
			var_8_4[arg_8_1.id] = arg_8_1
		else
			AttireConst = var_8_4

			if var_8_0 == var_8_4.TYPE_COMBAT_UI_STYLE then
				arg_8_0.data.combatUIStyles[arg_8_1.id] = arg_8_1
			end
		end
	end

	arg_8_0:addExpiredTimer(arg_8_1)
	arg_8_0:sendNotification(var_0_1.ATTIREFRAME_ADDED, arg_8_1:clone())

	return
end

function var_0_1.updateAttireFrame(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getType()

	AttireConst = var_1_10003

	local var_9_1

	if var_9_0 == var_1_10003.TYPE_ICON_FRAME then
		assert = var_9_1

		var_9_1(arg_9_0.data.iconFrames[arg_9_1.id])

		var_9_1 = arg_9_0.data.iconFrames
		var_9_1[arg_9_1.id] = arg_9_1
	else
		AttireConst = var_9_1

		local var_9_2

		if var_9_0 == var_9_1.TYPE_CHAT_FRAME then
			assert = var_9_2

			var_9_2(arg_9_0.data.chatFrames[arg_9_1.id])

			var_9_2 = arg_9_0.data.chatFrames
			var_9_2[arg_9_1.id] = arg_9_1
		else
			AttireConst = var_9_2

			if var_9_0 == var_9_2.TYPE_COMBAT_UI_STYLE then
				assert = var_3

				var_3(arg_9_0.data.combatUIStyles[arg_9_1.id])

				arg_9_0.data.combatUIStyles[arg_9_1.id] = arg_9_1
			end
		end
	end

	arg_9_0:sendNotification(var_0_1.ATTIREFRAME_UPDATED, arg_9_1:clone())

	return
end

function var_0_1.addExpiredTimer(arg_10_0, arg_10_1)
	arg_10_0:removeExpiredTimer(arg_10_1)

	local var_10_0 = arg_10_1

	if not arg_10_1.expiredType(var_10_0) then
		return
	end

	local function var_10_1()
		getProxy = var_2_10000
		PlayerProxy = var_2_10002

		local var_11_0 = var_2_10000(var_2_10002)
		local var_11_1 = var_0.getData(var_11_0)
		local var_11_2 = arg_10_1
		local var_11_3 = var_2.getType(var_11_2)

		if var_11_1:getAttireByType(var_11_3) == arg_10_1.id then
			var_11_1:updateAttireFrame(var_11_3, 0)
			var_0:updatePlayer(var_11_1)
		end

		table = var_4

		var_4.insert(arg_10_0.expiredChaces, arg_10_1)

		local var_11_4 = arg_10_0
		local var_11_5 = var_4.sendNotification
		local var_11_6 = var_0_1.ATTIREFRAME_EXPIRED
		local var_11_7 = arg_10_1

		var_11_5(var_11_4, var_11_6, var_8.clone(var_11_7))

		return
	end

	local var_10_2 = arg_10_1:getExpiredTime()

	pg = var_10_0

	local var_10_3 = var_10_0.TimeMgr.GetInstance()

	if var_10_2 - var_4.GetServerTime(var_10_3) > 0 then
		local var_10_4 = arg_10_1
		local var_10_5 = arg_10_1.getTimerKey(var_10_4)
		local var_10_6 = arg_10_0.timers

		Timer = var_10_4
		var_10_6[var_10_5] = var_10_4.New(function()
			var_10_1()

			local var_12_0 = arg_10_0

			var_0.removeExpiredTimer(var_12_0, arg_10_1)

			return
		end, var_4, 1)

		local var_10_7 = arg_10_0.timers[var_10_5]

		var_6.Start(var_10_7)
	else
		var_10_1()
	end

	return
end

function var_0_1.removeExpiredTimer(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:getTimerKey()

	if arg_13_0.timers[var_13_0] then
		local var_13_1 = arg_13_0.timers[var_13_0]

		var_3.Stop(var_13_1)

		arg_13_0.timers[var_13_0] = nil
	end

	return
end

function var_0_1.remove(arg_14_0)
	pairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(arg_14_0.timers) do
		iter_14_1:Stop()
	end

	arg_14_0.timers = {}

	return
end

function var_0_1.needTip(arg_15_0, arg_15_1)
	local var_15_0 = {}
	local var_15_1 = arg_15_1 or arg_15_0:getDataAndTrophys()
	local var_15_2 = {
		var_15_1.iconFrames,
		var_15_1.chatFrames,
		var_15_1.trophys,
		var_15_1.combatUIStyles
	}

	local function var_15_3(arg_16_0)
		local var_16_0 = false

		pairs = var_2_10002

		for iter_16_0, iter_16_1 in var_2_10002(arg_16_0) do
			if iter_16_1:isNew() then
				var_16_0 = true

				break
			end
		end

		return var_16_0
	end

	ipairs = var_1_10006

	for iter_15_0, iter_15_1 in var_1_10006(var_15_2) do
		if iter_15_0 == 3 then
			table = var_1_10011

			var_1_10011.insert(var_15_0, false)
		else
			table = var_1_10011

			var_1_10011.insert(var_15_0, var_15_3(iter_15_1))
		end
	end

	return var_15_0
end

function var_0_1.IsShowRedDot(arg_17_0)
	_ = var_1_10001

	return var_1_10001.any(arg_17_0:needTip(), function(arg_18_0)
		return arg_18_0 == true
	end)
end

return var_0_1
