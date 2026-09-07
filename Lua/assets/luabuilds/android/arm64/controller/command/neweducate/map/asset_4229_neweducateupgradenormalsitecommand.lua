local NewEducateUpgradeNormalSiteCommand = class("NewEducateUpgradeNormalSiteCommand", pm.SimpleCommand)

function NewEducateUpgradeNormalSiteCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback
	local var_1_2 = var_1_0.id
	local var_1_3 = var_1_0.normalId

	if getProxy(NewEducateProxy):GetCurChar():GetFSM():CheckPriorityStystem() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(29070, {
		id = var_1_2,
		work_id = var_1_0.normalId
	}, 29071, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = pg.child2_site_normal[var_1_3]

			getProxy(NewEducateProxy):GetCurChar():UpdateNormalType2Id(pg.child2_site_normal[var_1_3].type, (underscore.detect(pg.child2_site_normal.get_id_list_by_character[var_1_2], function(arg_3_0)
				return pg.child2_site_normal[arg_3_0].type == var_2_0.type and pg.child2_site_normal[arg_3_0].site_lv == var_2_0.site_lv + 1
			end)))
			existCall(var_1_1)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_UpgradeNormalSite: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateUpgradeNormalSiteCommand
