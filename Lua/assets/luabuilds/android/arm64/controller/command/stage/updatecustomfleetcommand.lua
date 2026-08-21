local var_0_0 = class("UpdateCustomFleetCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().chapterId
	local var_1_1 = getProxy(BayProxy):getRawData()

	pg.ConnectionMgr.GetInstance():Send(13107, {
		id = var_1_0,
		fleet = Chapter.PackEliteFleetInfo(getProxy(ChapterProxy):getChapterById(var_1_0).eliteFleetList)
	}, 13108, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("update_custom_fleet", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
