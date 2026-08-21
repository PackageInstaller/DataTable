local var_0_0 = class("StartCampTecCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_9000
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.tecID
	local var_1_2 = var_1_0.levelID
	local var_1_3 = pg.TimeMgr.GetInstance()
	local var_1_4 = getProxy(TechnologyNationProxy)

	if var_1_3 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("technology_uplevel_error_studying", pg.fleet_tech_group[getProxy(TechnologyNationProxy):getStudyingTecItem()].name))

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("technology_uplevel_error_no_res", pg.fleet_tech_template[var_1_0.levelID].cost, var_1_3.DescCDTime(var_1_9000, pg.fleet_tech_template[var_1_0.levelID].time), math.fmod(var_1_0.levelID, 1000) - 1, math.fmod(var_1_0.levelID, 1000)),
		onYes = function()
			if getProxy(PlayerProxy):getData().gold < pg.fleet_tech_template[var_1_2].cost then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_gold"))

				return
			end

			pg.ConnectionMgr.GetInstance():Send(1, {
				tech_group_id = var_1_1,
				tech_id = var_1_2
			}, 2, function(arg_3_0)
				if arg_3_0.result == 0 then
					var_1_4:updateTecItem(var_1_1, nil, var_1_2, pg.TimeMgr.GetInstance():GetServerTime() + pg.fleet_tech_template[var_1_2].time)
					var_1_4:setTimer()
					arg_1_0:sendNotification(TechnologyConst.START_TEC_BTN_SUCCESS, var_1_1)
					var_1_4:refreshRedPoint()
					arg_1_0:sendNotification(TechnologyConst.UPDATE_REDPOINT_ON_TOP)

					local var_3_0 = getProxy(PlayerProxy)
					local var_3_1 = var_3_0:getData()

					var_3_1:consume({
						[id2res(1)] = pg.fleet_tech_template[var_1_2].cost
					})
					var_3_0:updatePlayer(var_3_1)
				else
					pg.TipsMgr.GetInstance():ShowTips(errorTip("coloring_cell", arg_3_0.result))
				end

				return
			end)

			return
		end
	})

	return
end

return var_0_0
