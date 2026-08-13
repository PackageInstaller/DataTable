class = var_0_10000

local var_0_0 = var_0_10000("MainGuildSequence")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.ignores = {}
	pg = var_1

	local var_1_0 = var_1.TimeMgr.GetInstance()

	arg_1_0.refreshTime = var_1.GetServerTime(var_1_0)

	return
end

function var_0_0.Execute(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	GuildProxy = var_1_10003

	local var_2_0 = var_1_10002(var_1_10003)

	if not var_2.getRawData(var_2_0) then
		arg_2_1()

		return
	end

	if not var_2:GetActiveEvent() or not var_3:IsParticipant() then
		arg_2_1()

		return
	end

	local var_2_1, var_2_2 = var_3:AnyMissionFirstFleetCanFroamtion()

	if var_2_1 and var_2_2 then
		table = var_1_10006

		if var_1_10006.contains(arg_2_0.ignores, var_2_2.id) then
			arg_2_1()

			return
		end
	end

	if var_2_1 then
		arg_2_0:Notify(arg_2_1)
	else
		pg = var_1_10006

		local var_2_3 = var_1_10006.TimeMgr.GetInstance()

		if var_6.GetServerTime(var_2_3) - arg_2_0.refreshTime > 900 then
			arg_2_0:RefreshEvent(var_3, false, arg_2_1)
		else
			arg_2_0:Notify(arg_2_1)
		end
	end

	return
end

function var_0_0.RefreshEvent(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_1

	if arg_3_1.GetUnlockMission(var_3_0) and (not arg_3_2 or var_4.id ~= arg_3_2.id) then
		pg = var_3_0

		local var_3_1 = var_3_0.m02
		local var_3_2 = var_5.sendNotification

		GAME = var_1_10007

		var_3_2(var_3_1, var_1_10007.GUILD_REFRESH_MISSION, {
			force = true,
			id = var_4.id,
			callback = function()
				local var_4_0 = arg_3_0

				var_0.RefreshEvent(var_4_0, arg_3_1, var_0, arg_3_3)

				return
			end
		})

		pg = var_3_2

		local var_3_3 = var_3_2.TimeMgr.GetInstance()

		arg_3_0.refreshTime = var_5.GetServerTime(var_3_3)
	else
		arg_3_0:Notify(arg_3_3)
	end

	return
end

function var_0_0.Notify(arg_5_0, arg_5_1)
	pg = var_1_10002

	local var_5_0 = var_1_10002.GuildMsgBoxMgr.GetInstance()
	local var_5_1 = var_2.Notification
	local var_5_2 = {
		condition = function()
			getProxy = var_2_10000
			GuildProxy = var_2_10001

			local var_6_0 = var_2_10000(var_2_10001)
			local var_6_1 = var_0.getRawData(var_6_0)
			local var_6_2 = var_0.GetActiveEvent(var_6_1)
			local var_6_3, var_6_4 = var_1.AnyMissionFirstFleetCanFroamtion(var_6_2)

			if var_6_3 then
				table = var_2_10004

				if not var_2_10004.contains(arg_5_0.ignores, var_6_4.id) then
					table = var_4

					var_4.insert(arg_5_0.ignores, var_6_4.id)

					return true
				end
			end

			return false
		end
	}

	i18n = var_5
	var_5_2.content = var_5("guild_operation_event_occurrence")

	function var_5_2.OnYes()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_7_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_7_1(var_7_0, var_7_2, var_2_10003.GUILD, {
			page = "battle"
		})

		return
	end

	var_5_2.OnNo = arg_5_1

	var_5_1(var_5_0, var_5_2)

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.ignores = {}
	arg_8_0.refreshTime = nil

	return
end

return var_0_0
