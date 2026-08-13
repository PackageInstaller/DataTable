class = var_0_10000

local var_0_0 = "GuildGetSupplyAwardCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	if not var_3.getData(var_1_1) then
		return
	end

	if not var_4:isOpenedSupply() then
		pg = var_5

		local var_1_2 = var_5.TipsMgr.GetInstance()
		local var_1_3 = var_5.ShowTips

		i18n = var_1_10008

		var_1_3(var_1_2, var_1_10008("guild_supply_no_open"))

		return
	end

	local var_1_4 = var_4
	local var_1_5

	if var_4.getSupplyCnt(var_1_4) <= 0 then
		pg = var_1_5
		var_1_4 = var_1_5.TipsMgr.GetInstance()
		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10008

		var_1_5(var_1_4, var_1_10008("guild_supply_award_got"))

		return
	end

	getProxy = var_1_5
	PlayerProxy = var_1_4

	local var_1_6 = var_1_5(var_1_4)
	local var_1_7 = var_5.getData(var_1_6)

	if not var_4:getMemberById(var_1_7.id) or var_6:isNewMember() then
		pg = var_1_6

		local var_1_8 = var_1_6.TipsMgr.GetInstance()
		local var_1_9 = var_7.ShowTips

		i18n = var_1_10010

		var_1_9(var_1_8, var_1_10010("guild_new_member_get_award_tip"))

		return
	end

	local var_1_11

	if var_6:IsRecruit() then
		pg = var_1_11

		local var_1_10 = var_1_11.TipsMgr.GetInstance()

		var_1_11 = var_1_11.ShowTips
		i18n = var_1_10010

		var_1_11(var_1_10, var_1_10010("guild_duty_is_too_low"))

		return
	end

	pg = var_1_11

	local var_1_12 = var_1_11.ConnectionMgr.GetInstance()

	var_7.Send(var_1_12, 62009, {
		type = 0
	}, 62010, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			GetZeroTime = var_2_0
			var_2_0 = var_2_0() - 0
			var_2_10004 = var_0

			local var_2_1 = var_2.getData(var_2_10004)

			if not var_2.ExistSupply(var_2_1) then
				var_2_0 = var_2:GetSupplyEndTime()
			end

			var_2:updateSupplyTime(var_2_0)

			local var_2_2 = var_0

			var_3.updateGuild(var_2_2, var_2)

			PlayerConst = var_3

			local var_2_3 = var_3.addTranDrop(arg_2_0.drop_list)
			local var_2_4 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_2_10007

			var_2_10004(var_2_4, var_2_10007.GUILD_GET_SUPPLY_AWARD_DONE, {
				list = var_2_3
			})
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_6(var_2_5, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
