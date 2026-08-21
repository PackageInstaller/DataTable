local var_0_0 = class("MainGuildSequence")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.ignores = {}
	arg_1_0.refreshTime = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.Execute(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(GuildProxy):getRawData()

	if not var_2_0 then
		arg_2_1()

		return
	end

	local var_2_1 = var_2_0:GetActiveEvent()

	if not var_2_1 or not var_2_1:IsParticipant() then
		arg_2_1()

		return
	end

	local var_2_2, var_2_3 = var_2_1:AnyMissionFirstFleetCanFroamtion()

	if var_2_2 and var_2_3 and table.contains(arg_2_0.ignores, var_2_3.id) then
		arg_2_1()

		return
	end

	if var_2_2 then
		arg_2_0:Notify(arg_2_1)
	else
		local var_2_4 = pg.TimeMgr.GetInstance()

		if var_2_4:GetServerTime() - arg_2_0.refreshTime > 900 then
			arg_2_0:RefreshEvent(var_2_1, false, arg_2_1)
		else
			arg_2_0:Notify(arg_2_1)
		end
	end

	return
end

function var_0_0.RefreshEvent(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_1:GetUnlockMission()

	if var_3_0 and (not arg_3_2 or var_3_0.id ~= arg_3_2.id) then
		pg.m02:sendNotification(GAME.GUILD_REFRESH_MISSION, {
			force = true,
			id = var_3_0.id,
			callback = function()
				arg_3_0:RefreshEvent(arg_3_1, var_3_0, arg_3_3)

				return
			end
		})

		arg_3_0.refreshTime = pg.TimeMgr.GetInstance():GetServerTime()
	else
		arg_3_0:Notify(arg_3_3)
	end

	return
end

function var_0_0.Notify(arg_5_0, arg_5_1)
	pg.GuildMsgBoxMgr.GetInstance():Notification({
		condition = function()
			local var_6_0, var_6_1 = getProxy(GuildProxy):getRawData():GetActiveEvent():AnyMissionFirstFleetCanFroamtion()

			if var_6_0 and not table.contains(arg_5_0.ignores, var_6_1.id) then
				table.insert(arg_5_0.ignores, var_6_1.id)

				return true
			end

			return false
		end,
		content = i18n("guild_operation_event_occurrence"),
		OnYes = function()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.GUILD, {
				page = "battle"
			})

			return
		end,
		OnNo = arg_5_1
	})

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.ignores = {}
	arg_8_0.refreshTime = nil

	return
end

return var_0_0
