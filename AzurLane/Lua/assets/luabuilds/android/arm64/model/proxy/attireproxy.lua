local var_0_0 = class("AttireProxy", import(".NetProxy"))

var_0_0.ATTIREFRAME_UPDATED = "AttireProxy:ATTIREFRAME_UPDATED"
var_0_0.ATTIREFRAME_ADDED = "AttireProxy:ATTIREFRAME_ADDED"
var_0_0.ATTIREFRAME_EXPIRED = "AttireProxy:ATTIREFRAME_EXPIRED"

local var_0_1 = pg.item_data_frame
local var_0_2 = pg.item_data_chat
local var_0_3 = pg.item_data_battleui
local var_0_4 = false

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.timers = {}
	arg_1_0.expiredChaces = {}
	arg_1_0.data.iconFrames = {}
	arg_1_0.data.chatFrames = {}
	arg_1_0.data.combatUIStyles = {}

	for iter_1_0, iter_1_1 in ipairs(var_0_1.all) do
		arg_1_0.data.iconFrames[iter_1_1] = iter_1_1 == 0 and IconFrame.New({
			end_time = 0,
			id = iter_1_1
		}) or IconFrame.New({
			id = iter_1_1
		})
	end

	for iter_1_2, iter_1_3 in ipairs(var_0_2.all) do
		arg_1_0.data.chatFrames[iter_1_3] = iter_1_3 == 0 and ChatFrame.New({
			end_time = 0,
			id = iter_1_3
		}) or ChatFrame.New({
			id = iter_1_3
		})
	end

	for iter_1_4, iter_1_5 in ipairs(var_0_3.all) do
		arg_1_0.data.combatUIStyles[iter_1_5] = CombatUIStyle.New({
			id = iter_1_5
		})
	end

	if pg.gameset.new_auto_unlock_combat_ui.description ~= PlayerPrefs.GetString("new_auto_unlock_combat_ui") then
		for iter_1_6, iter_1_7 in ipairs((string.split(pg.gameset.new_auto_unlock_combat_ui.description, "|"))) do
			iter_1_7 = tonumber(iter_1_7)

			arg_1_0.data.combatUIStyles[iter_1_7]:setNew()
		end
	end

	PlayerPrefs.SetString("new_auto_unlock_combat_ui", pg.gameset.new_auto_unlock_combat_ui.description)
	arg_1_0:on(11003, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.icon_frame_list) do
			arg_1_0.data.iconFrames[iter_2_1.id]:updateData(iter_2_1)
			arg_1_0:updateAttireFrame(arg_1_0.data.iconFrames[iter_2_1.id])
			arg_1_0:addExpiredTimer(arg_1_0.data.iconFrames[iter_2_1.id])
		end

		local var_2_0 = arg_2_0.chat_frame_list or {}

		for iter_2_2, iter_2_3 in ipairs(var_2_0) do
			arg_1_0.data.chatFrames[iter_2_3.id]:updateData(iter_2_3)
			arg_1_0:updateAttireFrame(arg_1_0.data.chatFrames[iter_2_3.id])
			arg_1_0:addExpiredTimer(arg_1_0.data.chatFrames[iter_2_3.id])
		end

		local var_2_1 = arg_2_0.battle_ui_list or {}

		for iter_2_4, iter_2_5 in ipairs(var_2_1) do
			arg_1_0.data.combatUIStyles[iter_2_5]:setUnlock()
			arg_1_0:updateAttireFrame(arg_1_0.data.combatUIStyles[iter_2_5])
			arg_1_0:addExpiredTimer(arg_1_0.data.combatUIStyles[iter_2_5])
		end

		for iter_2_6, iter_2_7 in pairs(arg_1_0.data.combatUIStyles) do
			if not iter_2_7:isOwned() then
				iter_2_7:setLock()
			end
		end

		return
	end)

	if var_0_4 then
		arg_1_0.timer = Timer.New(function()
			local var_3_0 = {
				101,
				102,
				201,
				301
			}

			for iter_3_0 = 1, 5 do
				local var_3_1 = math.random(1, 4)
				local var_3_3 = {
					count = 1
				}

				if iter_3_0 % 2 == 0 then
					var_3_3.type = DROP_TYPE_ICON_FRAME or DROP_TYPE_CHAT_FRAME
					var_3_3.id = var_3_0[var_3_1]

					local var_3_4 = var_3_2(var_3_3)

					arg_1_0:sendNotification(GAME.ADD_ITEM, var_3_4)
					table.insert({}, var_3_4)
				end
			end

			table.insert({}, Drop.New({
				count = 1000,
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResGold
			}))
			arg_1_0:sendNotification(GAME.ACT_NEW_PT_DONE, {
				awards = {}
			})

			return
		end, 10, 1)

		arg_1_0.timer:Start()
	end

	return
end

function var_0_0.getDataAndTrophys(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getData()

	if arg_4_1 then
		arg_4_0:clearNew()
	end

	var_4_0.trophys = getProxy(CollectionProxy):getTrophys()
	var_4_0.loveTrophys = getProxy(LoveLetterProxy):GetTrophyList()

	return var_4_0
end

function var_0_0.clearNew(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.data.iconFrames) do
		iter_5_1:clearNew()
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0.data.chatFrames) do
		iter_5_3:clearNew()
	end

	for iter_5_4, iter_5_5 in pairs(arg_5_0.data.combatUIStyles) do
		iter_5_5:clearNew()
	end

	pg.EasyRedDotMgr.GetInstance():TriggerMarks("ATTIRE")

	return
end

function var_0_0.getExpiredChaces(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.expiredChaces) do
		table.insert({}, iter_6_1)
	end

	arg_6_0.expiredChaces = {}

	return {}
end

function var_0_0.getAttireFrame(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	if arg_7_1 == AttireConst.TYPE_ICON_FRAME then
		var_7_0 = arg_7_0.data.iconFrames[arg_7_2]
	elseif arg_7_1 == AttireConst.TYPE_CHAT_FRAME then
		var_7_0 = arg_7_0.data.chatFrames[arg_7_2]
	elseif arg_7_1 == AttireConst.TYPE_COMBAT_UI_STYLE then
		var_7_0 = arg_7_0.data.combatUIStyles[arg_7_2]
	end

	return var_7_0
end

function var_0_0.addAttireFrame(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getType()
	local var_8_1 = arg_8_0:getAttireFrame(var_8_0, arg_8_1.id)

	if arg_8_1:expiredType() and var_8_1 and not var_8_1:isExpired() then
		arg_8_1:updateEndTime(var_8_1:getExpiredTime() + arg_8_1:getConfig("time_second"))
	end

	if var_8_0 == AttireConst.TYPE_ICON_FRAME then
		arg_8_0.data.iconFrames[arg_8_1.id] = arg_8_1
	elseif var_8_0 == AttireConst.TYPE_CHAT_FRAME then
		arg_8_0.data.chatFrames[arg_8_1.id] = arg_8_1
	elseif var_8_0 == AttireConst.TYPE_COMBAT_UI_STYLE then
		arg_8_0.data.combatUIStyles[arg_8_1.id] = arg_8_1
	end

	arg_8_0:addExpiredTimer(arg_8_1)
	arg_8_0:sendNotification(var_0_0.ATTIREFRAME_ADDED, arg_8_1:clone())

	return
end

function var_0_0.updateAttireFrame(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getType()

	if var_9_0 == AttireConst.TYPE_ICON_FRAME then
		assert(arg_9_0.data.iconFrames[arg_9_1.id])

		arg_9_0.data.iconFrames[arg_9_1.id] = arg_9_1
	elseif var_9_0 == AttireConst.TYPE_CHAT_FRAME then
		assert(arg_9_0.data.chatFrames[arg_9_1.id])

		arg_9_0.data.chatFrames[arg_9_1.id] = arg_9_1
	elseif var_9_0 == AttireConst.TYPE_COMBAT_UI_STYLE then
		assert(arg_9_0.data.combatUIStyles[arg_9_1.id])

		arg_9_0.data.combatUIStyles[arg_9_1.id] = arg_9_1
	end

	arg_9_0:sendNotification(var_0_0.ATTIREFRAME_UPDATED, arg_9_1:clone())

	return
end

function var_0_0.addExpiredTimer(arg_10_0, arg_10_1)
	arg_10_0:removeExpiredTimer(arg_10_1)

	if not arg_10_1:expiredType() then
		return
	end

	local function var_10_0()
		local var_11_0 = getProxy(PlayerProxy)
		local var_11_1 = var_11_0:getData()
		local var_11_2 = arg_10_1:getType()

		if var_11_1:getAttireByType(var_11_2) == arg_10_1.id then
			var_11_1:updateAttireFrame(var_11_2, 0)
			var_11_0:updatePlayer(var_11_1)
		end

		table.insert(arg_10_0.expiredChaces, arg_10_1)
		arg_10_0:sendNotification(var_0_0.ATTIREFRAME_EXPIRED, arg_10_1:clone())

		return
	end

	local var_10_1 = arg_10_1:getExpiredTime() - pg.TimeMgr.GetInstance():GetServerTime()

	if var_10_1 > 0 then
		local var_10_2 = arg_10_1:getTimerKey()

		arg_10_0.timers[var_10_2] = Timer.New(function()
			var_10_0()
			arg_10_0:removeExpiredTimer(arg_10_1)

			return
		end, var_10_1, 1)

		arg_10_0.timers[var_10_2]:Start()
	else
		var_10_0()
	end

	return
end

function var_0_0.removeExpiredTimer(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:getTimerKey()

	if arg_13_0.timers[var_13_0] then
		arg_13_0.timers[var_13_0]:Stop()

		arg_13_0.timers[var_13_0] = nil
	end

	return
end

function var_0_0.remove(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.timers) do
		iter_14_1:Stop()
	end

	arg_14_0.timers = {}

	return
end

function var_0_0.needTip(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 or arg_15_0:getDataAndTrophys()

	for iter_15_0, iter_15_1 in ipairs({
		var_15_0.iconFrames,
		var_15_0.chatFrames,
		var_15_0.trophys,
		var_15_0.combatUIStyles
	}) do
		if iter_15_0 == 3 then
			table.insert({}, false)
		else
			table.insert({}, (function(arg_16_0)
				local var_16_0 = false

				for iter_16_0, iter_16_1 in pairs(arg_16_0) do
					if iter_16_1:isNew() then
						var_16_0 = true

						break
					end
				end

				return var_16_0
			end)(iter_15_1))
		end
	end

	return {}
end

function var_0_0.IsShowRedDot(arg_17_0)
	return _.any(arg_17_0:needTip(), function(arg_18_0)
		return arg_18_0 == true
	end)
end

return var_0_0
