class = var_0_10000

local var_0_0 = "StartCampTecCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().tecID
	local var_1_1 = var_2.levelID

	pg = var_1_10005

	local var_1_2 = var_1_10005.TimeMgr.GetInstance()
	local var_1_3 = var_5.DescCDTime

	pg = var_1_10007

	local var_1_4 = var_1_3(var_1_2, var_1_10007.fleet_tech_template[var_1_1].time)

	getProxy = var_1_2
	TechnologyNationProxy = var_7

	local var_1_5 = var_1_2(var_7)

	if var_6.getStudyingTecItem(var_1_5) then
		pg = var_1_5

		local var_1_6 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10010
		var_1_10011 = "technology_uplevel_error_studying"
		pg = var_1_10012

		var_1_5(var_1_6, var_1_10010(var_1_10011, var_1_10012.fleet_tech_group[var_7].name))

		return
	end

	pg = var_1_5

	local var_1_7 = var_1_5.MsgboxMgr.GetInstance()
	local var_1_8 = var_8.ShowMsgBox
	local var_1_9 = {}

	i18n = var_1_10011

	local var_1_10 = "technology_uplevel_error_no_res"

	pg = var_1_10013

	local var_1_11 = var_1_10013.fleet_tech_template[var_1_1].cost
	local var_1_12 = var_1_4

	math = var_1_10015

	local var_1_13 = var_1_10015.fmod(var_2.levelID, 1000) - 1

	math = var_16
	var_1_9.content = var_1_10011(var_1_10, var_1_11, var_1_12, var_1_13, var_16.fmod(var_2.levelID, 1000))

	function var_1_9.onYes()
		getProxy = var_2_10000
		PlayerProxy = var_2_10001

		local var_2_0 = var_2_10000(var_2_10001)
		local var_2_1 = var_0.getData(var_2_0).gold

		pg = var_2_10002

		if var_2_1 < var_2_10002.fleet_tech_template[var_1_1].cost then
			pg = var_2_1

			local var_2_2 = var_2_1.TipsMgr.GetInstance()

			var_2_1 = var_2_1.ShowTips
			i18n = var_3

			var_2_1(var_2_2, var_3("common_no_gold"))

			return
		end

		pg = var_2_1

		local var_2_3 = var_2_1.ConnectionMgr.GetInstance()

		var_1.Send(var_2_3, 1, {
			tech_group_id = var_1_0,
			tech_id = var_1_1
		}, 2, function(arg_3_0)
			local var_3_1

			if arg_3_0.result == 0 then
				pg = var_3_1

				local var_3_0 = var_3_1.TimeMgr.GetInstance()

				var_3_1 = var_3_1.GetServerTime(var_3_0)
				pg = var_3_0
				var_3_1 = var_3_1 + var_3_0.fleet_tech_template[var_1_1].time
				var_3_10003 = var_0

				var_2.updateTecItem(var_3_10003, var_1_0, nil, var_1_1, var_3_1)

				var_3_10003 = var_0

				var_2.setTimer(var_3_10003)

				var_3_10003 = arg_1_0

				local var_3_2 = var_2.sendNotification

				TechnologyConst = var_4

				var_3_2(var_3_10003, var_4.START_TEC_BTN_SUCCESS, var_1_0)

				var_3_10003 = var_0

				var_2.refreshRedPoint(var_3_10003)

				var_3_10003 = arg_1_0

				local var_3_3 = var_2.sendNotification

				TechnologyConst = var_4

				var_3_3(var_3_10003, var_4.UPDATE_REDPOINT_ON_TOP)

				getProxy = var_3_3
				PlayerProxy = var_3_10003

				local var_3_4 = var_3_3(var_3_10003)
				local var_3_5 = var_2.getData(var_3_4)
				local var_3_6 = var_3_10003.consume
				local var_3_7 = {}

				id2res = var_7

				local var_3_8 = var_7(1)

				pg = var_8
				var_3_7[var_3_8] = var_8.fleet_tech_template[var_1_1].cost

				var_3_6(var_3_5, var_3_7)
				var_2:updatePlayer(var_3_10003)
			else
				pg = var_3_1

				local var_3_9 = var_3_1.TipsMgr.GetInstance()
				local var_3_10 = var_1.ShowTips

				errorTip = var_3_10003

				var_3_10(var_3_9, var_3_10003("coloring_cell", arg_3_0.result))
			end

			return
		end)

		return
	end

	var_1_8(var_1_7, var_1_9)

	return
end

return var_0_1
