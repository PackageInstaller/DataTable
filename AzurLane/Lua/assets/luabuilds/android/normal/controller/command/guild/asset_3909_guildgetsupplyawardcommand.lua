class = var_0_10000

local var_0_0 = "GuildGetSupplyAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	GuildProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	if not var_3.getData(var_1_2) then
		return
	end

	if not var_4:isOpenedSupply() then
		pg = var_5

		local var_1_3 = var_5.TipsMgr.GetInstance()
		local var_1_4 = var_5.ShowTips

		i18n = var_1_10007

		var_1_4(var_1_3, var_1_10007("guild_supply_no_open"))

		return
	end

	local var_1_5, var_1_6

	if var_4:getSupplyCnt() <= 0 then
		pg = var_1_6
		var_1_5 = var_1_6.TipsMgr.GetInstance()
		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10007

		var_1_6(var_1_5, var_1_10007("guild_supply_award_got"))

		return
	end

	getProxy = var_1_6
	PlayerProxy = var_1_5

	local var_1_7 = var_1_6(var_1_5)
	local var_1_8 = var_5.getData(var_1_7)
	local var_1_9 = var_4

	if not var_4.getMemberById(var_1_9, var_1_8.id) or var_6:isNewMember() then
		pg = var_1_9

		local var_1_10 = var_1_9.TipsMgr.GetInstance()
		local var_1_11 = var_7.ShowTips

		i18n = var_1_10009

		var_1_11(var_1_10, var_1_10009("guild_new_member_get_award_tip"))

		return
	end

	local var_1_13

	if var_6:IsRecruit() then
		pg = var_1_13

		local var_1_12 = var_1_13.TipsMgr.GetInstance()

		var_1_13 = var_1_13.ShowTips
		i18n = var_1_10009

		var_1_13(var_1_12, var_1_10009("guild_duty_is_too_low"))

		return
	end

	pg = var_1_13

	local var_1_14 = var_1_13.ConnectionMgr.GetInstance()

	var_7.Send(var_1_14, 62009, {
		type = 0
	}, 62010, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			GetZeroTime = var_2_0
			var_2_0 = var_2_0() - 0
			var_2_10003 = var_0

			local var_2_1 = var_2.getData(var_2_10003)

			if not var_2.ExistSupply(var_2_1) then
				var_2_0 = var_2:GetSupplyEndTime()
			end

			var_2:updateSupplyTime(var_2_0)

			local var_2_2 = var_0

			var_2_10003.updateGuild(var_2_2, var_2)

			PlayerConst = var_2_10003
			var_2_10003 = var_2_10003.addTranDrop(arg_2_0.drop_list)

			local var_2_3 = arg_1_0
			local var_2_4 = var_4.sendNotification

			GAME = var_2_10006

			var_2_4(var_2_3, var_2_10006.GUILD_GET_SUPPLY_AWARD_DONE, {
				list = var_2_10003
			})
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
